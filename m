Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA64C2782
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiBXJEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiBXJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:03:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB83187E39
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:03:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so5117396pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QCM78YTn8/YVxRCZhQXtEB9THICvyOh286lVLbqQpaE=;
        b=rkNBMDEf/SqUajws9FmdO9tKxMTm17pN9iH5SFB3gRCwM2E/eKIRZYeJPNmzSHSaOn
         lQY9sO/8Lh9xsPcM21Be3q8LV+jNC3t5Shq3Wf+CHC2hs4Zr0++3/KHap3GXDNgMyRhV
         IIHAEfFwRnt6J3UTutGiUM6M6Nm6bNLWAOLmXMratd5dozz6PJ3ySy+BFTdOhAvgzIYM
         NAkwU21Z9Xvq0/Yh3VKrAd7o2FcKtHSCkAfaaLraoItjRSejXUzTq29jlNz2e5qC048e
         6lsjUmkGODO9k+pvJ7+gkSlX6OrzKaCOD2MHIMkPZo4/ugAm7XYufKmfcLTC1dePgyH2
         KRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QCM78YTn8/YVxRCZhQXtEB9THICvyOh286lVLbqQpaE=;
        b=n1E9EjMvBeXzcFMj9k8U0TTMMJGRxPynaHdP6TbscomRGSQLfMLD8yboXo7+2PmHIj
         atoCDEJu0NYri+3SbA+54VzU0SfzmUpOu5uHSQs3qV9ObJVo4qa6TmyEKJJKsloXMlSE
         qWM+3GIv5Uzg8a6tulI+N/kjFOs4S56vH+ioVZuQIQtfTXUzmsdtizU6f8CjLUnfjcD7
         yGv8Mx/aowliL6T4HQIhm9oX/x3oX+8aqsw2h8aigLN6vcl7BA2Ubw2RMAuq1PeLyHcV
         vB2tH+TGO+4n6fyFdEaGnKknc1VHSleUvnKSL6gMuVPF2omYv4R9KQGdVRg6UOs04Yco
         nLSw==
X-Gm-Message-State: AOAM5327ScF1Vv7hPmsOzm/kRO9++kp5+ytGr3anjyzKsq8mAy1EgQTV
        eEdoq2clSCA2U2wpvu9nqza3/Q==
X-Google-Smtp-Source: ABdhPJwGsYnvGBr1SzToJDWL3pbvTkdogMi/iHWJErfg6U8NpfHn2UG+e2zDs4MEgNGGgWVU0CzSlQ==
X-Received: by 2002:a17:902:c20c:b0:150:11df:9918 with SMTP id 12-20020a170902c20c00b0015011df9918mr1526277pll.76.1645693407502;
        Thu, 24 Feb 2022 01:03:27 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id g18sm2507892pfc.108.2022.02.24.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:03:27 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:33:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/4] OPP: Add "opp-microwatt" supporting code
Message-ID: <20220224090325.m4pl36ma3uettxvg@vireshk-i7>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224081131.27282-3-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-02-22, 08:11, Lukasz Luba wrote:
> +/**
> + * dev_pm_opp_get_power() - Gets the power corresponding to an opp
> + * @opp:	opp for which power has to be returned for
> + *
> + * Return: power in micro watt corresponding to the opp, else
> + * return 0
> + *
> + * This is useful only for devices with single power supply.
> + */
> +unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
> +{
> +	if (IS_ERR_OR_NULL(opp)) {
> +		pr_err("%s: Invalid parameters\n", __func__);
> +		return 0;
> +	}
> +
> +	return opp->supplies[0].u_watt;

What about returning the total of all u_watts for this OPP here ?
Surely it doesn't make sense to do the same for voltage and current,
but power is different.

-- 
viresh
