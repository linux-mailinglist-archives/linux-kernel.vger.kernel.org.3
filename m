Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456B54ECBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349918AbiC3ST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349987AbiC3STp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:19:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22D738AB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:17:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so31395762lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7NnuuJ059MX+/R6R8hSPlWGgObYMG0+HBTsWiYBn0k=;
        b=RD872fF7slzNyr8FioUVkR3B/FRoEYrH4iay+e0QIuWYM+GhoTnZzg29YiOGM1VUDF
         mhMqgFOPRYwWmalTCDmHKIw7NN7ZpXYByatHPSVZTAtvIvru63aeLCJsn0JXzYY0yu5D
         kF82cDP1d/5XkY+NKZbgrRHh2F5zPDrz3D0Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7NnuuJ059MX+/R6R8hSPlWGgObYMG0+HBTsWiYBn0k=;
        b=3/A6aQ/zIWTnVnYsgOuoJc6G4anPhC0O0CSJ6vL6djPmu52YmlBbi/x0Blc4Z9UFDf
         M8xo0mzjQh7M/2NqplnOOqbWkr/PMIoJarVPtoRzChD0dDZ137GO30lmZhXfIsmpIkAe
         ZSfkbQVA1yRPIJjGEYnB2F1pj2iCMC9TIcqPAxC/ScFnmVckTX2Y0vDfV1Vym21qRzGY
         GbdY1OZUPg2/Wcqeq9u2r6tVzZ9IYdSyeKFUfxk9zgdgcHyRaMYHhDWSVMlpoPGRKWZK
         sGF55qOOw+xJX1sDgoliBlU+mDywXPlwskLrKSctMcs7rg4piB82zWB3HeDdbSAgFWUr
         +/HA==
X-Gm-Message-State: AOAM5334y0DnA8TkwnaM+353sSCrkjgMIRWd8NsmHSD5iOJMzQ9TN2sR
        yRXB493NPCsjb8Ypw92au3+m5N7LbTs5DZWW
X-Google-Smtp-Source: ABdhPJwvRxsA9W1jtUcSDmoh/7C0czfyrrE+/ALmzzMsH0mHrANiFsymuBqEUyWfk1pgEjfiPryiHQ==
X-Received: by 2002:a05:6512:39d0:b0:44a:3b54:42db with SMTP id k16-20020a05651239d000b0044a3b5442dbmr7738593lfu.559.1648664271203;
        Wed, 30 Mar 2022 11:17:51 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id i14-20020a198c4e000000b0044a279d25d2sm2403614lfj.244.2022.03.30.11.17.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 11:17:50 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id w7so37282367lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:17:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr7864587lfv.52.1648664269822; Wed, 30
 Mar 2022 11:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
In-Reply-To: <7b0576d8d49bbd358767620218c1966e8fe9a883.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 11:17:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-hs_q-sL6PNptfVmNm7tWrt24o4-YR74Fxo+fdKsmxA@mail.gmail.com>
Message-ID: <CAHk-=wh-hs_q-sL6PNptfVmNm7tWrt24o4-YR74Fxo+fdKsmxA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 5.18
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 12:36 PM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> - Readdir fixes to improve cacheability of large directories when there
>   are multiple readers and writers.

So I only took a look at this part now. I've obviously already pulled
it, but that use of 'xxhash()' just made me go "Whaaa?"

It's claimed that it's used because of its extreme performance, but
the performance numbers come from using it as a block hash.

That's not what nfs does.

The nfs code just does

    xxhash(&cookie, sizeof(cookie), 0) & NFS_READDIR_COOKIE_MASK;

where that "cookie" is just a 64-bit entity. And then it masks off
everything but 18 bits.

Is that *really* appropriate use of a new hash function?

Why is this not just doing

  #include <hash.h>

  hash_64(cookie, 18);

which is a lot more obvious than xxhash().

If there really are some serious problems with the perfectly standard
hash() functionality, I think you should document them.

Because just randomly picking xxhash() without explaining _why_ you
can't just use the same simple thing we use elsewhere is very odd.

Or rather, when the only documentation is "performance", then I think
the regular "hash_64()" is the obvious and trivial choice.

                  Linus
