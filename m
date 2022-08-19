Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E060C599306
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiHSC24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHSC2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:28:53 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FB38307D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:28:49 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 27J2SQbH004063
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 11:28:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 27J2SQbH004063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660876107;
        bh=rrJ921yhPAkMzrLzHrtU5y8IcXDbFAtgCT5WCYpOw/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZQvhkWM1q5zzSxKT9qzuUBHbiE+EfxVaY8mzgVM4BJ0Wm4Vfpny/n0RHuIXRZcsqI
         sHAXb3cApEpAUo1cp7aywClUyir2Ca1LCTaL8Wrn91tz8uP1ykAkrvqoiDAf8SGNeu
         JOFyZLiEZNsAce4CF3azKGdHsQu+QaVeor2ovpQrjPTfaoZzP/TbOixnukQkrGLytO
         EqfVN+lKsSv0Ausu6p7oy6JlhBc6h+KLSGFNVhYD8SRUBQY2WIT6FLBuR8Sd4GVetF
         1z7KxBxf5HiLMNrI1NjGBWYtGseLQA2uVK4Qk6TJJJLZxbrQC8XGmPUabDpGH7/p3T
         1+mHXgtBvvz6A==
X-Nifty-SrcIP: [209.85.221.54]
Received: by mail-wr1-f54.google.com with SMTP id k16so3622627wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:28:27 -0700 (PDT)
X-Gm-Message-State: ACgBeo0NSqqFEM6pLuOlhJxs1oxM96mdiwywdaDbzfBXZl7ChLk0XRmI
        5GJ2jVzH+cX1s5WuIAluNRgNDetLyMdpuF8eaUY=
X-Google-Smtp-Source: AA6agR6AkkH4jod2L3C2XVXX2/6U1SBRbpx/xIfPL95Xvvq2w2trwsadGUYMvbDBdRrXgnppwBoWgTrBHLaxPmqtEGU=
X-Received: by 2002:a05:6000:2ab:b0:223:6167:a213 with SMTP id
 l11-20020a05600002ab00b002236167a213mr2908206wry.310.1660876105659; Thu, 18
 Aug 2022 19:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com> <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 19 Aug 2022 11:27:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATSr=BXKfkdW8f-H5VT_w=xBpT2ZQcZ7rm6JfkdE+QnmA@mail.gmail.com>
Message-ID: <CAK7LNATSr=BXKfkdW8f-H5VT_w=xBpT2ZQcZ7rm6JfkdE+QnmA@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     alexandre.belloni@bootlin.com,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 8:47 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Aug 4, 2022 at 12:03 PM <alexandre.belloni@bootlin.com> wrote:
> >
> > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >
> > When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
> > with a syntax error which is not the one we are looking for:
>
> Thanks for the patch, though I think I'd rather see `/bin/bash`
> hardcoded. Bash is a non-optional requirement as of
> commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for
> process substitution")
> scripts/ is kind of a mess...



As for scripts/ mess,
perhaps we can remove scripts/gcc-goto.sh?



http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
seems like a bug for GCC 4.x at least...


If we can revert the following two commits:
f3c003f72dfb2497056bcbb864885837a1968ed5
a9468f30b5eac6957c86aea97954553bfb7c1f18

... the asm-goto test will become simple enough
to fit into init/Kconfig.


If we know all GCC 5.1+ and Clang 11+ support asm-goto,
we can remove CC_HAS_ASM_GOTO, but I am not so sure.




-- 
Best Regards
Masahiro Yamada
