Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D071576C2D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiGPG0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiGPG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:26:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2C3137E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:25:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m16so8714233edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dtcch9Qzr0YljStF1nTh6WMavFtjr0p7ajWxxPfvu4k=;
        b=T0yyJPWSSnQtEv4d6WduySsQ4HzRrORjx5MCV0JVY9u8eNC7WCq92f0xjvsZSyHUXJ
         S4kJJ6yZKgIimm3XtlgrW+bJCMBlml5pYvE11ibrJvGEIAzdeeHUrC31JFR7BKuvPvoh
         V/tPMBdIE2MQeLEWa+IMTZI+CT8NmMrm7p3sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dtcch9Qzr0YljStF1nTh6WMavFtjr0p7ajWxxPfvu4k=;
        b=Vy8+zq4kkL5oRVhFYytdOZaJE1jducjTip1r+NTrwZ5VxEuCZPsLyMZwndLkRV83Fc
         NU0copwzRW5L0q4/GJpT9f3hmF1HkFfllZrdfaDfxFwSa4xqMPIi0sYbHF0GfhHe8NzM
         avMINN153Hqc9NxoeKFQXdjhcMamOReI4kbw1DIVfiM/lvFnasKbpzQC3OxzZXV/4Afn
         uLGjvxppIvfm+YlW6sQWx4eokciOhKHuqiaRJvOed6nGH31PYUSiBopUuopGElKO4AdH
         KyKLW1HTuvdHpWr8aHQVZS7Jr0wvdamVueAvgPpwUE47fyRqjN4vKot6kAF5ZR8qtxLE
         U9rg==
X-Gm-Message-State: AJIora9rr/npSqhvFxq0v8vmzK4rKbbeR3f8jSK889PJMpHWNEKEnFo/
        hr0LvxKrP/L4RG3y+JzaDGLC3b+8hfL8ww==
X-Google-Smtp-Source: AGRyM1u4w0Ubsq+NImm4PKhuRK4qH8ukABaDJr6K3EThBLKRKTWNtA4QaspIgIZeXp8OZqxC+l3Xzg==
X-Received: by 2002:a05:6402:b9b:b0:43a:5aac:ed6 with SMTP id cf27-20020a0564020b9b00b0043a5aac0ed6mr23758541edb.131.1657952711286;
        Fri, 15 Jul 2022 23:25:11 -0700 (PDT)
Received: from carbon.gago.life (78-83-68-78.spectrumnet.bg. [78.83.68.78])
        by smtp.gmail.com with ESMTPSA id le20-20020a170906ae1400b00724261b592esm2788546ejb.186.2022.07.15.23.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 23:25:10 -0700 (PDT)
Date:   Sat, 16 Jul 2022 09:25:10 +0300
From:   Petko Manolov <petko.manolov@konsulko.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: GCC fails to spot uninitialized variable
Message-ID: <YtJZxoLXhuVkHPxj@carbon.gago.life>
References: <YtHJbckxy1FJ3ts7@carbon.gago.life>
 <YtHkOQJ8E5cCk+Gj@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtHkOQJ8E5cCk+Gj@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-15 15:03:37, Nathan Chancellor wrote:
> On Fri, Jul 15, 2022 at 11:09:17PM +0300, Petko Manolov wrote:
> > 	Guys,
> > 
> > Today i was bitten by a stupid bug that i introduced myself while writing
> > some v4l2 code.  Looking at it a bit more carefully i was surprised that GCC
> > didn't catch this one, as it was something that should definitely emit a
> > warning.
> > 
> > When included into the driver, this particular code:
> > 
> > int blah(int a, int *b)
> > {
> > 	int ret;
> > 
> > 	switch (a) {
> > 	case 0:
> > 		ret = a;
> > 		break;
> > 	case 1:
> > 		ret = *b;
> > 		break;
> > 	case 2:
> > 		*b = a;
> > 		break;
> > 	default:
> > 		ret = 0;
> > 	}
> > 
> > 	return ret;
> > }
> > 
> > somehow managed to defeat GCC checks.  Compiling it as a standalone .c file
> > with:
> > 
> > 	gcc -Wall -O2 -c t.c
> > 
> > gives me nice:
> > 
> > t.c:19:16: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >    19 |         return ret;
> >       |                ^~~
> > 
> > Any idea what might have gone wrong?
> 
> See commit 78a5255ffb6a ("Stop the ad-hoc games with -Wno-maybe-initialized")
> in 5.7, which disabled that warning for a default kernel build. You have to
> either include 'W=2' (which will introduce other warnings which might be
> noisy) or 'KCFLAGS=-Wmaybe-uninitialized' (which will just add that warning)
> in your make command to see those warnings.

I see.  I guess i'll end up enabling W=2 only for this particular driver and
only while in development.

> As an aside, your mailer adds a "Mail-Followup-To:" header that was set to
> LKML, meaning that you would not have seen this reply unless you were
> subscribed to LKML. Might be something worth looking into.

That would be "set followup_to=no" in mutt speak.  Thanks for looking into this.
I am subscribed to all list i'm replying to but, if i understand this properly,
with the old setup non-subscribers may not get my messages.


cheers,
Petko
