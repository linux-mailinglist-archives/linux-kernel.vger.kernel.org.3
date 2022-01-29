Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2464A2AAD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243092AbiA2Aut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbiA2Aur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:50:47 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA60DC061749
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:50:47 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id p203so15523198oih.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wP9GUemZjobVvElhar7UqvhZ43XmUSMFie0l7uhdp34=;
        b=mMl9H0qw9/VE5m1aO1VI4YZPm4cSdMe0mM3Q2l4V1XUz9/eB0ZKNP/bYFFaNoTXCCq
         Gb2+GZx14nkjburIhdiga039yksG29/Xqy+EMFyFBXbTb9brMIhyntvWRT2RFU8KMwak
         axohOsIVOumItT87Cf3fDnf7as+Xc/uKUaVRIXY6Jd/4Qajcb2OZzn9bVS05p9zHNv7w
         O2gTlJblQuIQbtM0FSf9QnHWBfKzr1rHLNB5nbr7kGfX6jPyNR+0ZWoKB6hXAM3axWnx
         1BB+IGZcE38YeWzvHZtY3adbMruKepDbVCuRUscZ2zLiqpxHsy3U2wBsA7vm0861LeO6
         RNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wP9GUemZjobVvElhar7UqvhZ43XmUSMFie0l7uhdp34=;
        b=05ZBkwaXvxIKullVcyIt+TMqsnhRMEP0l62zSzPNqMBowboSGxnYypr4px4ToSHTAp
         6TkWDGBzqi3wo7vjniNqlDwPiSaPRea/qbXxS+JVA1FgcvtKtAtVfRzOilvti0ZBej9Q
         8JOgFZjBylep0z4rUvwtUkTLBtaem9ZN90m1a+eCM3H6HsrvXRs+OK8X3u4cbdIHfxbm
         k60QJgSCWPM8aVVMBQUfCmiEEplCoTPAOZJj7dZOO+RGNIzzUkeImbjKJ43DS6Thcsvd
         vwpTmEcN+VB7ruGsC2yGOOLnXUXGhwZJp9AfcU81mvdyHYZjE8B8tVLMc09SR+pO251Z
         lsxQ==
X-Gm-Message-State: AOAM531fJnqezakJwi4bwECI6PZFnHigxx+VMELpEgDghkSfikXkS6rB
        7GiRVL3d886gQBMvIOjoZeOmeQ==
X-Google-Smtp-Source: ABdhPJwERBnVifrHrrzYgx92kUQsmMqDK5Gg8Dx7QIQWHze+WTQMcJMbFY9jNW6BAwUh2FHD5fgivA==
X-Received: by 2002:aca:100c:: with SMTP id 12mr7528496oiq.147.1643417446535;
        Fri, 28 Jan 2022 16:50:46 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id c26sm3619496otn.34.2022.01.28.16.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:50:45 -0800 (PST)
Date:   Fri, 28 Jan 2022 18:50:42 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v10 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <YfSPYkbTXMOUGKkG@yoga>
References: <20211010043912.136640-1-bjorn.andersson@linaro.org>
 <20211010043912.136640-2-bjorn.andersson@linaro.org>
 <YXL0DyyPkS4/wfB7@ripper>
 <20211027211928.tjybwy2lokj6eoun@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027211928.tjybwy2lokj6eoun@SoMainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Oct 16:19 CDT 2021, Marijn Suijten wrote:

> Hi Bjorn,
> 
> On 2021-10-22 10:25:35, Bjorn Andersson wrote:
> > On Sat 09 Oct 21:39 PDT 2021, Bjorn Andersson wrote:
> > 
> > > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > > PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> > > with their output being routed to various other components, such as
> > > current sinks or GPIOs.
> > > 
> > > Each LPG instance can operate on fixed parameters or based on a shared
> > > lookup-table, altering the duty cycle over time. This provides the means
> > > for hardware assisted transitions of LED brightness.
> > > 
> > > A typical use case for the fixed parameter mode is to drive a PWM
> > > backlight control signal, the driver therefor allows each LPG instance
> > > to be exposed to the kernel either through the LED framework or the PWM
> > > framework.
> > > 
> > > A typical use case for the LED configuration is to drive RGB LEDs in
> > > smartphones etc, for which the driver support multiple channels to be
> > > ganged up to a MULTICOLOR LED. In this configuration the pattern
> > > generators will be synchronized, to allow for multi-color patterns.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > 
> > Any feedback on this?
> 
> I asked in #linux-msm whether anything is wrong with the patterns,
> since my Sony Discovery (sdm630 with a pm660l) blinks way quicker on a
> pattern that's supposed to stay on for 1s and off for 1s:
> 
>     echo "0 1000 255 1000" > /sys/class/leds/rgb\:status/hw_pattern
> 
> It however seems to be broken in the same way on an older version now
> (this might be v9 or v8) which I don't remember to be the case.  Can you
> double-check if this is all working fine on your side?  If so, I'll have
> to find some time to debug it on my end.
> 

I had missed the fact that LPG_RAMP_DURATION_REG is two registers for
msg and lsb, for a total of 9 bits of duration. So what you saw was
probably ticking at 232ms.

Note though that the pattern uses the last time as "high pause", so I
expect that you should have seen 232 ms of off, followed by 464ms of
light.

I've fixed this for v11, both rejecting invalid input and writing out
all 9 bits.

Thanks for spotting this!
Bjorn
