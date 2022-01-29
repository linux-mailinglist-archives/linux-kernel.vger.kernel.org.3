Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343414A2AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbiA2Ax3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiA2Ax2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:53:28 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D83C061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:53:27 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id e21-20020a9d0195000000b005a3cd7c1e09so680617ote.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kdgdtq3eOJHV51siqvXo/GLiap2Pd2Ct5h8leY/7+qQ=;
        b=fiWptCh5t5yJTLtKKqW+Ag6RQ6RGNL8eRJ50PmEcFl2VOoxRJXMkyb1I3y6HYKfDow
         1jLKcBqJxEG/r5+SaKi/+w4kkXXNEfluF3OJofOpTQCluSPdSZxnILu1AIkk7hCWLliS
         CSN8Ixj5fTR5DhfUbaTZNrNip+mfxNpMtUgZrRb9XW2mow9xD43I+CBMK+7CKCWAqMgk
         yMdIPEh36bjEuPHtgiY34m0AVB5zr4hq8irnnwDuxpukW2PZr6ticWOZSeKPwRumK5HN
         ipxXKJFQXiO5o00GlbUHMYrXXspNv7RnkbMTN0fbHz9FIb5y0ucrEHFzJOUBPuEbRhYf
         0wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdgdtq3eOJHV51siqvXo/GLiap2Pd2Ct5h8leY/7+qQ=;
        b=Npsxhb3eOKnsBpS2mlIQr4xVUChZsY7giCAho7zQIU3dQPZAtKBdbh1rUxepFm6Jk9
         K/L+lIiy6wnzpC0SZPJ5MOLgjJj5pqZb2WVvbhyeSmARHJhGB4dzO9Uqc5wJqdHTFYZb
         Z4pBuQnwM0j6LVMu4izj21uvMlnhhQ8AC2uHk2cdMIcspMhweVFs6vJifk8Lhd4KcJPU
         kub2QLHPMwXr7KxJB7eaTeCBQe/P5w5QogRqtRPSVPQpo0aPste6WYVIZkDe8yCB9E0W
         qfKFTaLp79iEWM/0yndAn8C7vS3R6/sXNUq3RwLlRH+vB4qC5RNsoP60iF5m+V2DZEYM
         8jKw==
X-Gm-Message-State: AOAM532yejB6CLZ6plz8bKFBoGKUQLklTw8DP0xmAh1IEfHykMgDP3d4
        0QdaGuZgNrStkt/tGUcfzNz0GQ==
X-Google-Smtp-Source: ABdhPJwM/USBBDqcz3Mo0FpT+5QasQtoHcs2ePLRiKzk0nszAsYbzNIGGqS8hJcbJaiGnR5zlF5l2g==
X-Received: by 2002:a05:6830:839:: with SMTP id t25mr6395244ots.372.1643417607223;
        Fri, 28 Jan 2022 16:53:27 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id 124sm12194246oif.7.2022.01.28.16.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:53:26 -0800 (PST)
Date:   Fri, 28 Jan 2022 18:53:24 -0600
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
Message-ID: <YfSQBOHkwCKMGrbu@yoga>
References: <20211010043912.136640-1-bjorn.andersson@linaro.org>
 <20211010043912.136640-2-bjorn.andersson@linaro.org>
 <YXL0DyyPkS4/wfB7@ripper>
 <20211027211928.tjybwy2lokj6eoun@SoMainline.org>
 <20211027212709.4ma5uzy5titmgzqv@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027212709.4ma5uzy5titmgzqv@SoMainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Oct 16:27 CDT 2021, Marijn Suijten wrote:

> On 2021-10-27 23:19:30, Marijn Suijten wrote:
> > Hi Bjorn,
> > 
> > On 2021-10-22 10:25:35, Bjorn Andersson wrote:
> > > On Sat 09 Oct 21:39 PDT 2021, Bjorn Andersson wrote:
> > > 
> > > > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > > > PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> > > > with their output being routed to various other components, such as
> > > > current sinks or GPIOs.
> > > > 
> > > > Each LPG instance can operate on fixed parameters or based on a shared
> > > > lookup-table, altering the duty cycle over time. This provides the means
> > > > for hardware assisted transitions of LED brightness.
> > > > 
> > > > A typical use case for the fixed parameter mode is to drive a PWM
> > > > backlight control signal, the driver therefor allows each LPG instance
> > > > to be exposed to the kernel either through the LED framework or the PWM
> > > > framework.
> > > > 
> > > > A typical use case for the LED configuration is to drive RGB LEDs in
> > > > smartphones etc, for which the driver support multiple channels to be
> > > > ganged up to a MULTICOLOR LED. In this configuration the pattern
> > > > generators will be synchronized, to allow for multi-color patterns.
> > > > 
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > 
> > > Any feedback on this?
> > 
> > I asked in #linux-msm whether anything is wrong with the patterns,
> > since my Sony Discovery (sdm630 with a pm660l) blinks way quicker on a
> > pattern that's supposed to stay on for 1s and off for 1s:
> > 
> >     echo "0 1000 255 1000" > /sys/class/leds/rgb\:status/hw_pattern
> > 
> > It however seems to be broken in the same way on an older version now
> > (this might be v9 or v8) which I don't remember to be the case.  Can you
> > double-check if this is all working fine on your side?  If so, I'll have
> > to find some time to debug it on my end.
> > 
> > Thanks!
> > - Marijn
> 
> Another thing I just ran into: on both patch revisions the colors are
> flipped.  multi_index reports "red green glue", but the values written
> to multi_intensity correspond to "blue green red" instead.  Is it the
> same on your side?
> 

I booted one of my 8974 devices with RGB LED and the colors matches my
expectations. Can you confirm that your mapping in the DT node is
correct?

E.g. with pm8941 the mapping should be "backwards":

lpg {
    ...;
    rgb-led {
        color = <LED_COLOR_ID_RGB>;
        function = LED_FUNCTION_STATUS;

        #address-cells = <1>;
        #size-cells = <0>;

        led@1 {
            reg = <7>;
            color = <LED_COLOR_ID_RED>;
        };

        led@2 {
            reg = <6>;
            color = <LED_COLOR_ID_GREEN>;
        };

        led@3 {
            reg = <5>;
            color = <LED_COLOR_ID_BLUE>;
        };
};

Regards,
Bjorn
