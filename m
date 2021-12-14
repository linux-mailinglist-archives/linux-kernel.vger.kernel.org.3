Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13384474150
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhLNLRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhLNLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:17:05 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956C3C061574;
        Tue, 14 Dec 2021 03:17:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so15770375pjq.4;
        Tue, 14 Dec 2021 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdUzozq/ia4XNyw9Pm+HSSllN+T8ynAAyub4gDqEXTw=;
        b=FF5tC5p1JHjCujakt/eVqkNtMr03J1AZ8FOQ+ekPma2ooNlljwmVltMYe9EKxww/hX
         zCfBSt/w75HmySey0Rz8KzE1Tg+08qJnTrh+kYOc+SGtVXDDrRuMdeIzJQHh7Bf5zkCr
         wm6KNdFwKAij7S2PHIzNOZmfTw80UCoRl6w/bl3dqNfRx+dVBW3VOOczVzhaEWXBtBE2
         AuEQyYdkLlw6x/Nmm5SQerxI2cH8ONofrxR6oAXxvRyRpqHYvE1Ua2Fh1N0H+6ar0tl0
         zA613tINPbuL6xvA7vx7F1aX3HLXLy5LAptD342AfSIM4cfj1VtcYe4eQJqTDnwVr1Ba
         WGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdUzozq/ia4XNyw9Pm+HSSllN+T8ynAAyub4gDqEXTw=;
        b=t8qDlJbNlGKshjJZiVe9wcftBzTzJzYNbHAIrHHgY43B3+nM/VD1inK1pCW1SzfK8K
         2VZVtn4mu/YTtyM/xDDqwT/6srNLP3TM7/uwgLvHQ2LQI1MwnyJsRuOuWdExz1yJ5PHK
         uuwHFBhtQfGWQ+RfmfDYLtC7WxpR7lTCPo+ghhBrIFs/0HKpNbJp3AuwD13DrmKN3yGM
         Q6KtCeV+fnWzV2tR2xK6LzVPzRFOQnqSyv1+R1Da4Wv5simPfMIqvVaLGIqGmVLS4C0l
         ysHEJqLO8OBxfpawmnO194g9+wE0mUf96M+v3gDkDzFTztXWW0i2dSroALPdadIecrOl
         5pbw==
X-Gm-Message-State: AOAM533n/2/sNn/xEYG/omRQdCvlXqvArlcGh6BrWwPO+JQm+a0lmaF+
        rEKF2u6pfU9+URuJW65bvy8=
X-Google-Smtp-Source: ABdhPJxi7Vc0gMieaSDjbfQ5fHLxKKOvYsOCvjCR8XYyECgIAJVp2lwcgY5K8ae/LxW3MUlTnu+GFQ==
X-Received: by 2002:a17:90b:17ca:: with SMTP id me10mr4777718pjb.134.1639480625025;
        Tue, 14 Dec 2021 03:17:05 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id u3sm17410146pfk.32.2021.12.14.03.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:17:04 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id ACE2C90090C;
        Tue, 14 Dec 2021 11:17:02 +0000 (GMT)
Date:   Tue, 14 Dec 2021 11:16:59 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] riscv: dts: enable more DA9063 functions for the SiFive
 HiFive Unmatched
Message-ID: <20211214111659.29bf5ea4@gmail.com>
In-Reply-To: <YbhqNY/w36XT5zx0@aurel32.net>
References: <20211108214629.1730870-1-aurelien@aurel32.net>
        <mhng-7ab80707-35c0-4123-8340-cf1feca4cca2@palmer-ri-x1c9>
        <YbhqNY/w36XT5zx0@aurel32.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 10:56:05 +0100, Aurelien Jarno <aurelien@aurel32.net> wrote:
> On 2021-12-13 18:13, Palmer Dabbelt wrote:
> > On Mon, 08 Nov 2021 13:46:29 PST (-0800), aurelien@aurel32.net wrote:  
> > > The DA9063 PMIC found on the SiFive HiFive Unmatched also provides an
> > > RTC, a watchdog and the power button input.
> > > 
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > ---
> > >  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > > index 2e4ea84f27e7..c357b48582f7 100644
> > > --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > > +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > > @@ -70,6 +70,10 @@ pmic@58 {
> > >  		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> > >  		interrupt-controller;
> > > 
> > > +		onkey {
> > > +			compatible = "dlg,da9063-onkey";
> > > +		};
> > > +
> > >  		regulators {
> > >  			vdd_bcore1: bcore1 {
> > >  				regulator-min-microvolt = <900000>;
> > > @@ -205,6 +209,14 @@ vdd_ldo11: ldo11 {
> > >  				regulator-always-on;
> > >  			};
> > >  		};
> > > +
> > > +		rtc {
> > > +			compatible = "dlg,da9063-rtc";
> > > +		};
> > > +
> > > +		wdt {
> > > +			compatible = "dlg,da9063-watchdog";
> > > +		};
> > >  	};
> > >  };  
> 
> Thanks. However, wouldn't be better to merged this patch and the whole
> series instead:
> 
> http://lists.infradead.org/pipermail/linux-riscv/2021-November/010234.html

My apologies about this, by the way: I had prepared that patch stack
last summer and was witholding it until the IRQ-fires-only-once
situation was resolved (it does affect at least the onkey subfunction,
although in a non-obvious way when the event triggers a shutdown or a
reboot). I did not think of checking recent submissions until it was
too late.
-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
