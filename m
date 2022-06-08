Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B443543EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiFHVdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiFHVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:33:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB95F35DFD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:33:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 129so20113764pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WAS8WUh96Qxk8KtjLQvGsql0jH0AMyuKUPSOHCaclbQ=;
        b=UGqihQx5egRZTMtu5cLRjJ2tDnW5LDapd4K8FU6a5kqFQD0+dUIp5jCdl+gL17MxRv
         w8icx9WS4sARssUzi5mloEf09M5TgL+RAFQt63jZNTuhtLkWr9R/6+U88llFHtsy1KCD
         tJOArwy8o1pbOTIc4FsOMYU1pxoThNwxHQQHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WAS8WUh96Qxk8KtjLQvGsql0jH0AMyuKUPSOHCaclbQ=;
        b=1X7Z8S69dIkMYk4KszkmCqIEvvRNapKfJ/QT+gw3SfZBx9CODWvJzbw3v+zI5n4v+N
         Hs7P83AVyTakuE2f9NmDsDoX+EOKAqvyOLSsaa0u3/8rCx1Gj0wqfIdPrQtG8jOHNTtg
         TKLfhfJOxeW6GnLwquByKTH8ClEUT6JBEciOru7fXjV5W05NMoEMEA/B4Du/Pz870ZMm
         VN7c2g1yHi/dbilDazL4GgtFP4lLb6pu+RDjyVqUT0Nm919RDpil6JMph4vDQieW8URm
         VqP6CBUFTTapfY5yUy0SvJq9CR4RXEnOKD7i3hikfSt0lXsua9yc3wpEOt7pkoFhVp4/
         FGUQ==
X-Gm-Message-State: AOAM531UCgMOZbEH0El/2loqU7uqoTLxWL1JLuieKSrxvrxSo4pORfoC
        YboqC0RpAdi0vg+STRECkg8KWieukCdmdw==
X-Google-Smtp-Source: ABdhPJxhm0OSN3b+U3FaRv/i2w6IxDtqVrMA5XE+fJIO7UyBnlo3rxCue7ZVvolT7Z9hVW1RCVrBuA==
X-Received: by 2002:a05:6a00:24c1:b0:51c:784:cb59 with SMTP id d1-20020a056a0024c100b0051c0784cb59mr20947490pfv.57.1654724024105;
        Wed, 08 Jun 2022 14:33:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s5-20020a170903214500b0015ea95948ebsm15060672ple.134.2022.06.08.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:33:43 -0700 (PDT)
Date:   Wed, 8 Jun 2022 14:33:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: disable -Warray-bounds
Message-ID: <202206081404.F98F5FC53E@keescook>
References: <20220422134308.1613610-1-svens@linux.ibm.com>
 <202204221052.85D0C427@keescook>
 <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 01:07:05PM -0700, Linus Torvalds wrote:
> Coming back to this, because my rc2 week tends to be quiet as people
> take a breather, and as such a good time for me to do system upgrades.
> 
> And gcc-12 dropped in Fedora 36, and shows problems on x86 too.
> 
> So I suspect we'll have to disable -Warray-bounds globally on gcc-12,
> not just on s390.
> 
> Unless Kees has patches ready to go already.

I and others have been working through a bunch of them, though yes,
they're not all fixed yet. I've been trying to track it here[1], but
many of those fixes are only in -next.

> Some of the warnings look potentially simple, ie
> 
>    struct mbus_dram_target_info;
> 
> in <linux/mbus.h> has the comment
> 
>          *   [..]  Peripherals are
>          * required to support at least 4 decode windows.
> 
> and then as a result has
> 
>         int             num_cs;
>         struct mbus_dram_window {
>            [..]
>         } cs[4];
> 
> and that "cs[4]" looks just bogus - it can be a much larger array, the
> '4' is just a minimum. The real limit is that 'num_cs' one.
> 
> But there's a *lot* of warnings, and many of them are due to this, and
> while some are obvious, others aren't.

When I did a count in -next 2 weeks ago, there were 182 warnings (x86
allmodconfig) from GCC 12 where 153 were from -Warray-bounds. Today
we're now down to 80 total (61 from -Warray-bounds), so we've solved
over half of them.

> There are other things too in gcc-12 that seem half-baked. I was
> interested to see the new '-Wdangling-pointer' thing, but then when I
> looked at it, the two cases I looked at were just bogus, so ..

Yes, GCC 12 is very odd in places. Besides the literal-as-pointer issue
that still causes problems for s390[2], there seem to be at least a
few other bugs associated with the internal diagnostics infrastructure
that informs -Warray-bounds, -Wstringop-overflow, etc. I narrowed down
one recently with UBSAN_BOUNDS[3] (which therefore impacts all*config
builds), but there is no GCC fix yet. :(

So, it's unclear to me if we want to try to get back to 0 warnings
(where we were with v5.18 and GCC 11) in the next couple weeks, or if we
need to just disable it for GCC 12 until everything is fixed again.

-Kees

[1] https://github.com/KSPP/linux/issues/190
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
[3] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105679

-- 
Kees Cook
