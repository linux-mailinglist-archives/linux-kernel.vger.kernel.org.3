Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215DC4CED93
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiCFUBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiCFUBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:01:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2D19288
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 12:00:28 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j15so22888502lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 12:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFwJynFO3fJ8ixtoqLr++1NLbQ5v5m+5KLS3G5LcfTE=;
        b=OnbdavhNVJSLJk4bAGHLIMP/HNzhzBn7tUeoGTV+Py3x2I3KBPlcn8Xo93IFJFqxuR
         48BuPrU094sNxSTqm5atY89FnSSQWWF/IATnuI9MI+oYTTQEGt7fKr73AOz347/NINk8
         Q9tMxVvfU1l+z1sQXqyPKWaAlMZzVXnyMiNIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFwJynFO3fJ8ixtoqLr++1NLbQ5v5m+5KLS3G5LcfTE=;
        b=CAjKAdjcs1LBkIlgvydZ3ngzY2ZNrWtV4tCEQYpXFux7StNx+DhUQjg567cOCFbDjG
         oPS131xTnZpm0t5qcNI5adLMZtzFH3SLTKfb5YeHQwx4Dq1eufPfLPw3rJe15rJZX0lG
         DZCBs04wt0xxEsb7D45caUcNblRM4aM8Fb8A4+hiFtjphilWo/A1bX/8Vaa8UTZqbKfx
         Ces/ZaA6jX6ufYzJ750C0/0nZa7593ZiviQqlaFj3ybidD0+w4kmY565zjhwMpSslo0P
         3smfu4hsxc+wrOkvJ3CA6JfJv0Rl8DP4yVZVnbSka8vjKz8p6IwNXsqUq90rQBkgg0hv
         Pn8A==
X-Gm-Message-State: AOAM532meD3Ib2PfymCpInoOrGxAjduwY3oADuybTa8vAnL2agAuJpAN
        Ue9UYtMp+ZtTXBmPjeJhbsx7CcjCwPFcbpCAgFM=
X-Google-Smtp-Source: ABdhPJzpdrFn9XZ6doMHsBdCqyLYiJDOmiJ4AvQdtzLE26eWdeeDaaPNDRi5Ah7uWc5ZMfuQNBw7CQ==
X-Received: by 2002:ac2:5211:0:b0:448:1c0f:b7dc with SMTP id a17-20020ac25211000000b004481c0fb7dcmr5962155lfl.342.1646596826465;
        Sun, 06 Mar 2022 12:00:26 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id g13-20020a2ea4ad000000b0023382d8819esm2541762ljm.69.2022.03.06.12.00.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 12:00:25 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id l12so17646548ljh.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 12:00:24 -0800 (PST)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr2262817lja.443.1646596824468; Sun, 06
 Mar 2022 12:00:24 -0800 (PST)
MIME-Version: 1.0
References: <87bkyjo6wn.fsf@mpe.ellerman.id.au>
In-Reply-To: <87bkyjo6wn.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Mar 2022 12:00:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEQRDQ3fJT1KVVAeaWiJ+mYTM+MwYoXEOUQrnbERLa5w@mail.gmail.com>
Message-ID: <CAHk-=whEQRDQ3fJT1KVVAeaWiJ+mYTM+MwYoXEOUQrnbERLa5w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-5 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        muriloo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 5, 2022 at 11:51 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> powerpc fixes for 5.17 #5
>
> Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set.

Hmm.

I'm *still* not seeing the fix for the reported
powerpc:skiroot_defconfig failure:

    arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
    arch/powerpc/kernel/stacktrace.c:171:9: error: implicit
declaration of function 'nmi_cpu_backtrace'

which has been pending forever.

The alleged fix (commit 5a72345e6a78: "powerpc: Fix STACKTRACE=n
build") has been in linux-next for three weeks by now, but hasn't been
sent to me. And you must be aware of it, since you're the author,
signed off on it and committed it.

What's up? This has been reported forever, and was already failing in
rc2. I'm about to release rc7 and it's *still* there.

                         Linus
