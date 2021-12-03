Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC4246713A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 05:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349955AbhLCErI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 23:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349190AbhLCErG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 23:47:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A11C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 20:43:42 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso4253254pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 20:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7mPNLk8tLdK5DDTbw5bfTCjo4IkSyEGMOB9BFirxYGU=;
        b=IKaG1hPcKKzPHkdxz/tFVlAXS0Rd3Pi0CjIPnWAs/jCYFkJoX/NX/d9eKwVd95LCR5
         mgjMTmnUo7tttI5MfgoaeA0Q/eCsjbeKMuzZrHzkZGVN3citeLjiM8P1yiMwBex0zxn8
         nnveMoYL8JYU+YyKGzCnDsC4RcjfDxMwpMZM0OB+SsZOOSDcYNdWcOcovEvPhKlqezkT
         dG0Kmamp6TtuDUZIpZkapyNFQzFy7K660wHDQRBqRKAA7YT27tw/vwf/0t7iseb6z9J8
         EDpthKxwTiqh5ChWlEBtcNNCeGoXl8fzzfWD4HgyWv0GEWwZpzxIFZPlsDLQNqgeogUX
         2erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7mPNLk8tLdK5DDTbw5bfTCjo4IkSyEGMOB9BFirxYGU=;
        b=5wsnJPpnpWVW0zUUwuGjSPYq1IJ3DMAoRSYJbHSc/oqOxUNK/ibPKwxL4qQhHi3s0J
         NwUfVxixcZ4F3n8C9AglugI0xDXsKDpReEbC5QTPWYTqr97jzf/fTthvi102SskA5mSy
         p0hLd5glQnM6/xjs7zHT+xKjcqq5yE8sJh2goVdPqe75bQ9vfXWHpvy/ZOKEN6bne7Lr
         4i+gHmzZHairX6DsSk43DAkTFzh25Zsm55RHXoNxoPmP5ISOxmckKb7FazcS5dsxFqvW
         NBqYeC2wlYF162D5NfEXEy3Z53MpY34BiRNh02lo7HoIhT6Qz1hip7uVsKtFkxfuppNM
         BUJw==
X-Gm-Message-State: AOAM5335IQBL0290q0gy7wMOrSr7ZKcHETfyYIyxTZp/BMI8OOS07wdd
        pULWc6pvfEQgzLSllu5zwxM+wA==
X-Google-Smtp-Source: ABdhPJz327okhh8voT4wIIAxhUoaKYcbIWi4Cfjeksrhd/QxBYsPqkMeYfKWpfxR7/l6L7m4/VzNFw==
X-Received: by 2002:a17:902:7b82:b0:143:a6d6:34ab with SMTP id w2-20020a1709027b8200b00143a6d634abmr20058440pll.30.1638506622012;
        Thu, 02 Dec 2021 20:43:42 -0800 (PST)
Received: from localhost ([106.201.42.111])
        by smtp.gmail.com with ESMTPSA id d10sm1353449pfl.139.2021.12.02.20.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 20:43:41 -0800 (PST)
Date:   Fri, 3 Dec 2021 10:13:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/6] spear: Fix SPEAr3XX plgpio support
Message-ID: <20211203044339.exx77afqgkbdhqgs@vireshk-i7>
References: <20211202095255.165797-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202095255.165797-1-herve.codina@bootlin.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 10:52, Herve Codina wrote:
> Hi,
> 
> This patch series fixes the plgpio support on SPEAr3xx SOCs.
> 
> The first four patches of this series fixes a ressources
> sharing issue between the plgpio driver and the pinmux
> driver.
> Indeed, these two drivers can use the same IO address range
> on some SPEAr3xx SOCs.
> To solve the issue, a regmap (syscon managed) is used in both
> drivers and the plgpio driver can reference the pinmux regmap
> to use it.
> 
> The second part of this series is related to IRQs.
> The plgpio on SPEAr320s SOC uses an IRQ line in the reserve
> range (from SPEAr320 point of view).
> This issue is fixed enabling all the 'reserved' IRQs and
> adding a dtsi file for the SPEAr320s with the correct interrupt
> for the plgpio node.
> 
> Best regards,
> Herve
> 
> Herve Codina (6):
>   pinctrl: spear: spear: Convert to regmap
>   pinctrl: spear: plgpio: Convert to regmap
>   pinctrl: spear: plgpio: Introduce regmap phandle
>   ARM: dts: spear3xx: Use plgpio regmap in SPEAr310 and SPEAr320
>   irq: spear-shirq: Add support for IRQ 0..6
>   ARM: dts: spear3xx: Add spear320s dtsi

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
