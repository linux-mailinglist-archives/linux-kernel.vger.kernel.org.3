Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFCF4BC375
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiBSAcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:32:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSAcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:32:46 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E30177E6C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:32:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso10009181pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ie7wPkZjwdzElvH96PVmNl9jOWV+pttLF9kv7yIV990=;
        b=xTfgkj43GqUJfIT66JQ/CEO0aqbzuw2HDpdXEqpu3IzOYFPcl5HSvT5OKgXRkPn4Gg
         mb4mqEFq63/xODjvuapeQkj14wfE5nq4BTa5lyi8EEDDP7I++RjBebkj8zSSkGUSmARq
         eih719ozeVgjor75YoZyUndQfWr4A5fwFWW+AOnZaQJZgcGXjc5Ydq97v0Tvl0GQ/3sW
         8gMprRWBBG9jm+Mq0rpwPDdYFaBq2y4I5G6igIkAkcXfUlbt1Yvvy9wxYJvGfFP3LDaX
         VSIbE5DUiNSRJV07cI0Ei/gsZuvVmkOS6CIBIcV+5GAWLs9VZefgy1jNamO0Sg0hNtYQ
         XuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ie7wPkZjwdzElvH96PVmNl9jOWV+pttLF9kv7yIV990=;
        b=1p+gKltLkRO2nlervZjvcMwGMX7KPUuzVpL4SoBjkRjE3oFsuC5Ag+l0t1TAEMRvIR
         kRpTrVvkG2pI7Ak2NR17dEeE/EESkFsq6HW78KdueQsAKaNggLiDkfwbBjP+zPFsa0Q2
         8bjFvJXcWEz2fEDpip+4LpBd+ETUbtSXR55nsEeXst92+6EyfbmDR3WdyV/EFNTRBgNO
         pfmZrbsQ75MVdyQ3qMz9HX152+srGT2BXsWUz5YzrG9UMLi1ge2WJIozKD01poiZsPzX
         JQu2TIqmvHL0912X3aRVcKBn2eiz/X50EgSTBklQufqnyu/QC6TTJ99+crD/FaW5HBc8
         ubTA==
X-Gm-Message-State: AOAM531WFiDUiJd53DN99F8Cr0yRMN8/WeCfLAdH66SiG4RM4pUKZkuy
        gKTrqsJC0F3HhhVn+Q6lACCF/g==
X-Google-Smtp-Source: ABdhPJzOdNwzhEWF/xjssr/bVkeFSdPFFlB16rmenkttGnh8q8q7Hd4akRL6ZYVAz/rTPSjBriVFwA==
X-Received: by 2002:a17:90a:6884:b0:1b8:c2c3:e10a with SMTP id a4-20020a17090a688400b001b8c2c3e10amr14993028pjd.38.1645230747811;
        Fri, 18 Feb 2022 16:32:27 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090ae38d00b001b9dedc52d0sm420359pjz.29.2022.02.18.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:32:27 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "shunzhou.jiang@amlogic.com" <shunzhou.jiang@amlogic.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "jianxin.pan" <jianxin.pan@amlogic.com>
Subject: Re: Re: [PATCH 2/2] soc: s4: Add support for power domains controller
In-Reply-To: <2022021510112070486315@amlogic.com>
References: <20220126061018.705338-1-shunzhou.jiang@amlogic.com>
 <20220126061018.705338-3-shunzhou.jiang@amlogic.com>
 <7hzgnal5yu.fsf@baylibre.com> <202202091001287547451@amlogic.com>
 <7hee4bok8w.fsf@baylibre.com> <2022021117375354230910@amlogic.com>
 <7hwni1me12.fsf@baylibre.com> <2022021510112070486315@amlogic.com>
Date:   Fri, 18 Feb 2022 16:32:26 -0800
Message-ID: <7hley7itlx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"shunzhou.jiang@amlogic.com" <shunzhou.jiang@amlogic.com> writes:

> Hi Kevin:
> Thanks your reply
> This has been mentioned before

Yes, you mentioned what the domains are for, but you have not answered
why the domains need to remain powered on when they are not in use.
 
>> S4_VPU_HDMI:  for vpu,  this domain provide power to many moudles(osd, vpp, hdr, dv, di), if close, will cause system crash

Why does the system crash?  Most likely because a driver in this domain
is still trying to access.  This suggests that that the DT shoud be
updated so those devices are listed in the power domain, and also that
those drivers use runtime PM so that the power domain is turned off ONLY
when the devices are not in use.

>> S4_USB_COMB domain: for usb, if not always on,  all usb status will clear to 0, that's not right status for usb

Why is this not the right status for usb?

Again, my question is: why does the power domain need to stay on when
the underlying devices are NOT used.

If the underlying devices are in use, then if the power domain turns off
it is a software bug.  Devices need to be connected to the power domain
(in DT) and their drivers need to use runtime PM.  If that is done
correctly, then there is no reason for the power domain to be turned off
when the devices are in use.

In other words, your solution to always keep the power domain on has a
two main problems:

1) it just hides improperly configured, or poorly written drivers
2) it wastes power and prevents low-power usecases

Kevin

> Shunzhou Jiang
> SW Department
>  
> From: Kevin Hilman
> Date: 2022-02-12 02:52
> To: shunzhou.jiang@amlogic.com; linux-arm-kernel; linux-amlogic; linux-kernel
> CC: Neil Armstrong; jbrunet; Martin Blumenstingl; jianxin.pan
> Subject: Re: Re: [PATCH 2/2] soc: s4: Add support for power domains controller
> [ EXTERNAL EMAIL ]
>  
> Hi Shunzhou,
>  
> "shunzhou.jiang@amlogic.com" <shunzhou.jiang@amlogic.com> writes:
>  
>> Hi Kevin:
>> Thanks your kindly reply
>  
> You're welcome.  For future reference, please avoid top-posting.  See:
> https://www.kernel.org/doc/html/latest/process/2.Process.html?highlight=top-posting#mailing-lists
>  
>> For those domains,  default is active, we hope not close when in use or not in use, in our case, 
>> only runtime PM (include suspend) control this, so set always on flag to avoid domain shutdown,
>  
> my question remains: why do want to keep these powered on even when they
> are not in use?
>  
> The goal of the power-domain framework + runtime PM is to be able to
> save power by turnin off power domains when they are not in use.
>  
>> if you also have concern, we can control this not in kernel, but this not our expect.
>  
> My strong preference is that this is controlled by the kernel.
>  
> Kevin
>  
