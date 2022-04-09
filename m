Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A8D4FA195
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbiDICQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiDICP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:15:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503DDE10;
        Fri,  8 Apr 2022 19:13:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x16so9930230pfa.10;
        Fri, 08 Apr 2022 19:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EoWPSPWqWw5i1pUl8sUAWot9g8foyIcMzdNqiGiO4F4=;
        b=RZt5KYYbOkDfghmFt/7qyoWgsAUAzZMz+zNKjErml7yrqokW4kA3d8GS76kDTuKK51
         9REd9aPYvEnPXgnBPq3kZlfw/LdxTpXAYQmtqPeGWVbxaxlQk61pBgZDA1vDsX4tNwZZ
         w5gq0d6kIfnb4rw2sGFStZeDLMyUztQjVJj2uDHP2qO4CNoaiRHt3KoEfG2WkL0VJtvM
         IoW2mrxaggmRtGvtwqFK8E5A9QRvTaynkZQJoM0xuxuMOrD37IbBlg8RZywPLcW6ZdG8
         iUPAggoA2waPSw/10rgZrurq99Ta9uk37zk+Z1iIF8WLXAYhWnoNZpxVmbaUpR7aCrzk
         oENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EoWPSPWqWw5i1pUl8sUAWot9g8foyIcMzdNqiGiO4F4=;
        b=eb02vsUG1T69YRwLNt35mIuW5atiCPvLuIOP1QplmSWIPxVjJOQLNHRSf7Sbt76+vu
         J+1WELVx7L3NlLeLD13DV14Bk+Tn91qPVeFz/7iV6PExZD6ZQADskoM016mMHoQHoR49
         z1eTiCqbEC0lE2Z5mLaaGGZ6ZRsfAf22Rra5dTsnwvUPdLrSQZFnZ72XHxjx26E7hJ/k
         80ZfLvy4KUhSzgGyEav46BPNokH+kv+joF8juwKz+Z9IY9ziDKPYlycjr8DJR+nTDKHp
         JnDWxP7KphxEXJZGIFd+UJqs/3BxlIeAjt6jAfRayOgGJsQw5MwVqzte6+4Q1ciTaOJo
         rsyA==
X-Gm-Message-State: AOAM532lSDQtDUk3MfWpmNogd7uasn/xJKZeWEpI1ZQaW++gE4osHzaT
        1rJatyn2v+DOyLaICQWKLMP1JjfqgNU=
X-Google-Smtp-Source: ABdhPJzjdcqvB8PwuZTCUyFTNiDQlaThJfAmJ2QvRTpS9iTx7sHXkc2GM6CPQqN03NmU2STbAscy8g==
X-Received: by 2002:a05:6a00:1256:b0:4fb:1374:2f65 with SMTP id u22-20020a056a00125600b004fb13742f65mr22696889pfi.72.1649470432689;
        Fri, 08 Apr 2022 19:13:52 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9186:332c:bcb2:4506])
        by smtp.gmail.com with ESMTPSA id gb5-20020a17090b060500b001c6d46f7e75sm13799347pjb.30.2022.04.08.19.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 19:13:51 -0700 (PDT)
Date:   Fri, 8 Apr 2022 19:13:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Nico Schottelius <nico-bugzilla.kernel.org@schottelius.org>,
        Jingle Wu <jingle.wu@emc.com.tw>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Regression: Mouse gets sluggish after suspend/resume and power
 usage significant higher after resume
Message-ID: <YlDr3bxY3tIOgn44@google.com>
References: <9af2d249-91e7-4871-59c8-704823118e48@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af2d249-91e7-4871-59c8-704823118e48@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:20:14PM +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and all people that seemed to be relevant
> here. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=215747 :

This looks like I2C-HID controller and I see bunch of "incomplete
report"s in the logs:

[16558.456434] i2c_hid_acpi i2c-ELAN0670:00: i2c_hid_get_input: incomplete report (14/3583)
[16558.457434] i2c_hid_acpi i2c-ELAN0670:00: i2c_hid_get_input: incomplete report (14/259)
[16558.458384] i2c_hid_acpi i2c-ELAN0670:00: i2c_hid_get_input: incomplete report (14/65281)

Let's add benjamin, Jiri and Jungle...

> 
> >  Nico Schottelius 2022-03-26 19:27:06 UTC
> > 
> > Created attachment 300619 [details]
> > dmesg
> > 
> > TL;DR:
> > 
> > Suspending and resume makes the ELAN0670:00 trackpad sluggish (very hard to move the pointer) and the energy usage of the notebook is about 3 times higher than before suspend.
> > 
> > Background:
> > 
> > 
> > On a Lenovo X1 Nano the trackpad works fine until suspend/resume.The estimated battery runtime PRIOR to suspend/resume is 8h 43m. After suspend resume it drops to 2h 20m instantly.
> > 
> > There seems to be a firmware error in the iwlwifi card show in the attached dmesg, but I am not sure whether "that's enough" to cause both symptoms.
> > 
> > Kernel is from Alpine Linux, which is basically stock upstream afaics.
> 
> See later comments for more details. In one of them the reporter states
> he's pretty sure that it didn't happen with 5.13.
> 
> Not sure if this is input, PM, bluetooth, or something else. But sounds
> like a problem in the input code to me (you have to start somewhere...).
> 
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
> 
> Anyway, to get this tracked:
> 
> #regzbot introduced: v5.13..v5.15.31	
> #regzbot from: Nico Schottelius  <nico-bugzilla.kernel.org@schottelius.org>
> #regzbot title: input: Mouse gets sluggish after suspend/resume and
> power usage significant higher after resume
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215747
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
> -- 
> Additional information about regzbot:
> 
> If you want to know more about regzbot, check out its web-interface, the
> getting start guide, and the references documentation:
> 
> https://linux-regtracking.leemhuis.info/regzbot/
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
> 
> The last two documents will explain how you can interact with regzbot
> yourself if your want to.
> 
> Hint for reporters: when reporting a regression it's in your interest to
> CC the regression list and tell regzbot about the issue, as that ensures
> the regression makes it onto the radar of the Linux kernel's regression
> tracker -- that's in your interest, as it ensures your report won't fall
> through the cracks unnoticed.
> 
> Hint for developers: you normally don't need to care about regzbot once
> it's involved. Fix the issue as you normally would, just remember to
> include 'Link:' tag in the patch descriptions pointing to all reports
> about the issue. This has been expected from developers even before
> regzbot showed up for reasons explained in
> 'Documentation/process/submitting-patches.rst' and
> 'Documentation/process/5.Posting.rst'.

-- 
Dmitry
