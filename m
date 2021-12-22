Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACBA47D083
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbhLVLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhLVLKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:10:00 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF06C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:09:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso850221wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j1lOGi4XuCNFoWkwT37VTBiICql+UYv5lclfC2ZGXww=;
        b=Oz7A4t8x2FkuRIklWoeC2LwPdyPtYFMtkGfwsALFCup7drqgvv0imhE97bFFGtatng
         mnXhx62cJ+yxeAFGvttFa9oFP4xbP584Ph2u2b7/uuf0YrrmTkTzKsQ5HQSBFcQOVf9E
         P19yDSNTqOZtKI9xZkp7IUrm9Z3AYU7npzXSMgeUIjkbACijkHa5UZWscYi7vRwAmOVv
         cgmKlIB0Yv/U5QEg3BWmrAGcpQaTbsYa1OGXNgd6jgnE/grQG0CISR/RHcoOnHeGJydu
         0SFcVlT8M6Klb22t7y/sJqLxCl87Fm4FEIPAzp7GzSsKZOenJHNaaVXpqrA5dz/jbyAH
         2Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j1lOGi4XuCNFoWkwT37VTBiICql+UYv5lclfC2ZGXww=;
        b=3dGCzt7DIfGPh8ng0bAS05xV/ViMRQWnqkFIcDhWXdmWa7IcIivEP5oD1GxeGSc7yN
         QgZ+b4jg6ZWK6ddtfXvk9ovDu5dS/wxzplwSccz57fRT8sLnO8uQsRpnlT4W71KxqbHO
         mq5A+1ZxOx7Qn4wNGZ51R5G0jQsSY3H5IzwzSk/LyvhBClUjShNn6HEghqhUDS/kc/er
         T8ZdE6BUdq+xKm39ifininn6E+FGoaigeGNLH3ombKr8HH2U9ZIVSh735aI2Q/byM/LI
         DosQYHdUyCNFWdyLrIOFY5URXq6NsrUevEzRGtIiP9JSzDc0zpCZQVCpDAFOGVwFdkG0
         mmBA==
X-Gm-Message-State: AOAM532eZG6HXS3ev0JLuwIiTSwqeBV7zJZG/bWPjPFQ7aIsjFGCfgn5
        v+iciJwhzLmHn4y/HOQPrZVYLg==
X-Google-Smtp-Source: ABdhPJybBvd0zx9bUFwYmcCroy3Ek7RtFVbNWKeS7mYi2A0k6ezCDdEGm8Spzd0juXf51LPQC62qsA==
X-Received: by 2002:a05:600c:4e8f:: with SMTP id f15mr565287wmq.151.1640171398299;
        Wed, 22 Dec 2021 03:09:58 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id c13sm1559941wrt.114.2021.12.22.03.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:09:57 -0800 (PST)
Date:   Wed, 22 Dec 2021 11:09:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: rk808: add reboot support to rk808.c
Message-ID: <YcMHhJTsQMLDRRsN@google.com>
References: <20211220144654.926112-1-pgwipeout@gmail.com>
 <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
 <YcGU6pQqfEPBqjrO@google.com>
 <4963E4A2-63B4-48A1-BDDD-5F9D07D71598@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4963E4A2-63B4-48A1-BDDD-5F9D07D71598@public-files.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021, Frank Wunderlich wrote:

> Am 21. Dezember 2021 09:48:43 MEZ schrieb Lee Jones <lee.jones@linaro.org>:
> >On Mon, 20 Dec 2021, Frank Wunderlich wrote:
> >
> >> Hi
> >> 
> >> > Gesendet: Montag, 20. Dezember 2021 um 15:46 Uhr
> >> > Von: "Peter Geis" <pgwipeout@gmail.com>
> >> > @@ -749,6 +791,9 @@ static int rk808_remove(struct i2c_client
> >*client)
> >> >  	if (pm_power_off == rk808_pm_power_off)
> >> >  		pm_power_off = NULL;
> >> >
> >> > +	if (of_property_read_bool(np,
> >"rockchip,system-power-controller"))
> >> > +		unregister_restart_handler(&rk808_restart_handler);
> >> > +
> >> >  	return 0;
> >> >  }
> >> 
> >> this change misses a declaration
> >> 
> >> struct device_node *np = client->dev.of_node;
> >
> >How did this compile when you tested it?
> 
> Here i have squashed the change in:
> 
> https://github.com/frank-w/BPI-R2-4.14/commit/06430ffcb6d58d33014fb940256de77807ed620f
> 
> With the change i can compile it...

Not sure I understand.

Please make sure all patches you send for inclusion into the Linux
kernel are fully tested.  They should also be bisectable i.e. not
depend on patches applied *on top*.

> But in v4 (patch is tagged as v3 too) the of_property_read_bool was dropped completely.
> regards Frank

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
