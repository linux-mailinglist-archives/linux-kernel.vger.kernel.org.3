Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20544E49A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiCVX2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbiCVX2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:28:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D39532F2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:26:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h7so14890010lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBxciClPop8HcJOPhu5G8/P4OFfSPZiakZxhaPJleKY=;
        b=OsjODHtaxTJ7Nq1d7M5OujJwtAHdGmpT4UBaK8fl5mHC2tGG0xf0H3q1D2y4Bhu9O2
         y/M96zucWzLS5z49sspM/l1Fi8yDBIpjG6a/IGWynJlqqXDEIz1DuGUTAExof3k+ltYG
         MYoZccoX4NSMkMi5qi5YxDhGRledYaGav6fWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBxciClPop8HcJOPhu5G8/P4OFfSPZiakZxhaPJleKY=;
        b=GZUxObuSczgI126e9SS/t1PId8X5ckcbikxtylxQrEz77gLcHbq1uzb4a3F8BjxIfn
         1JNMz/ZgGjBBWO76G3NRswuMdCkmoobUdGadacn7eMRvwOMsT3cvBQBxwotO9IOVBfPq
         D0LwNEQQ7M76f63+izIagbrt9ZuCqFnfa1KGTphosRX+Zlvz0KhsFNhk/pnCmJFnaoiO
         wp/imVkwzimQOVKlKtgedeHH9Wf1RvYPXD3QRbRAOYSVrk3VzNxxSfQtPKNJgW60b5Na
         gVUZsX0U41Xeb1xcv3TA2MWXoTg0PmXteNDpzX5iDrgpcBcB1aStPUhwOqOrW1nGSzoR
         xV2w==
X-Gm-Message-State: AOAM533PgBbQ+NrL0YPqWcw9sgYyxKsB0uEjciXlL+7DOWTy7cfk6D9X
        oJ/xmi+T+OK9g49CVlOMWEcbYqupN/hMUTUQCcM=
X-Google-Smtp-Source: ABdhPJwt28n0ZboiztSiF5QQIJrI9QRk5cVpEizHJQfqrBxQDi1e/8F6Y6Lg2UholGnPGv8p+m+CPg==
X-Received: by 2002:a05:6512:3e0d:b0:44a:1097:ac with SMTP id i13-20020a0565123e0d00b0044a109700acmr14552137lfv.405.1647991595063;
        Tue, 22 Mar 2022 16:26:35 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a10-20020a19e30a000000b00448ed99d745sm2209638lfh.90.2022.03.22.16.26.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 16:26:34 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id d5so13164505lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:26:33 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr8551255lfv.52.1647991593384; Tue, 22
 Mar 2022 16:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <YjhdcJB4FaLfsoyO@gmail.com> <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
In-Reply-To: <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 16:26:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNBs07foho7=QxVbs_hnpDfPP3s2fwyXK-reNw67mU=g@mail.gmail.com>
Message-ID: <CAHk-=whNBs07foho7=QxVbs_hnpDfPP3s2fwyXK-reNw67mU=g@mail.gmail.com>
Subject: Re: [GIT PULL] locking changes for v5.18
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Mar 22, 2022 at 3:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I see that the -mm tree has a fix for this,[..]

Ok, usually I strive to let the patch-bomb from Andrew sit in a branch
of its own for a while (in case somebody replies to one of Andrew's
emails I can then fix things up).

But I decided to just apply and merge the series immediately instead,
partly to just have this issue sorted out.

Let's hope there's nothing dodgy in there..

               Linus
