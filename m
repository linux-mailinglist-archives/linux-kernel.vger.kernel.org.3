Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC34B0506
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 06:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiBJF1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 00:27:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiBJF1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:27:16 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F741DB3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:27:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i30so8241146pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 21:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aNj5Xh0xA6luKin8itDN2Q7hu6ygPFEEo5apEpE+LlY=;
        b=tBMJbISrQv+1mFot1P5qF4jD2V2MhoFY3dgpLTbOyXJf9HCdVKkRFzDYALxvCLpSU5
         RDp6h19SWeKdPqNQGV61d1dGNX5gzx4+Q0HwUvCE4jaXwgRLR9jJNiJduW2o7Lvy5KgD
         ne19u3f2NT7Q2nTDFtTCXx2qXdFj9DzBxiS/QB5gs+HDmz6jVe/kLNDzK9+2qXkAQ6mg
         swz5K5IzKu/9777ETt+ZLfYKTo28cZfrKZlc6d3ZgKa1GUAiDf8e8OpSC/QmoBSDzM9O
         U0JwdkDRq7lsaU+5lX2pdo9U0nJ+eX9TWgCm1/qFvkmjZiXrrHQ271s3eC5Rnrx1dn1r
         /MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aNj5Xh0xA6luKin8itDN2Q7hu6ygPFEEo5apEpE+LlY=;
        b=OAAY8l6VjoEQ35Tm0ZXKzSUPIwHiWU3Qa8wskth2CdvOUbXk9Z7wW/UJDUzRD/3F1f
         FSeoiSI5kQhdz64yULZb9SgCb+qauGOLYTZqy+aDiJezF1z5ZCrxzmkRxdEQGJet8m8s
         JWl3uLGP5hA2aY9Njg9jhReGShUDGxdclslf4KtEJP1EJuJ2ABunIQpf0YDgta0OH+NI
         txbbxA9DMjsv10Vgl4sx5Oegh9+kPxuVsGXu8chTaK9RCs4EGTQFKaQRalFbdz47oC/7
         7WLIEENTVqBuxD2DpBrXY2qnBxrFMdfDnh4E5TFJ/K9c3N4zUC3zhg2eO2jEl6xh4KPN
         MRcQ==
X-Gm-Message-State: AOAM531JsCmm/xfkbPkdnIOg2Y7tiDdUZ3xSRhN+rC72/dSA6cIQMW+2
        n0pDSLnns/WLW6yxti2J97dnJw==
X-Google-Smtp-Source: ABdhPJySnVchiExhDDsVEiiW2jga5YDbIbQp0gXN4uCn5Wed/vB+Sf7H0H3dId3iJ/6+ssJ2b4IIxg==
X-Received: by 2002:a63:4b17:: with SMTP id y23mr4781304pga.489.1644470836741;
        Wed, 09 Feb 2022 21:27:16 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id pc4sm691067pjb.3.2022.02.09.21.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 21:27:16 -0800 (PST)
Date:   Thu, 10 Feb 2022 10:57:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <Pierre.Gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: CPPC: Fix performance/frequency conversion
Message-ID: <20220210052714.em6vt7j627wi5dns@vireshk-i7>
References: <20220208080109.697904-1-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208080109.697904-1-Pierre.Gondois@arm.com>
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

On 08-02-22, 09:01, Pierre Gondois wrote:
> CPUfreq governors request CPU frequencies using information
> on current CPU usage. The CPPC driver converts them to
> performance requests. Frequency targets are computed as:
> 	target_freq = (util / cpu_capacity) * max_freq
> target_freq is then clamped between [policy->min, policy->max].
> 
> The CPPC driver converts performance values to frequencies
> (and vice-versa) using cppc_cpufreq_perf_to_khz() and
> cppc_cpufreq_khz_to_perf(). These functions both use two different
> factors depending on the range of the input value. For
> cppc_cpufreq_khz_to_perf():
> - (NOMINAL_PERF / NOMINAL_FREQ) or
> - (LOWEST_PERF / LOWEST_FREQ)
> and for cppc_cpufreq_perf_to_khz():
> - (NOMINAL_FREQ / NOMINAL_PERF) or
> - ((NOMINAL_PERF - LOWEST_FREQ) / (NOMINAL_PERF - LOWEST_PERF))
> 
> This means:
> 1- the functions are not inverse for some values:
>    (perf_to_khz(khz_to_perf(x)) != x)
> 2- cppc_cpufreq_perf_to_khz(LOWEST_PERF) can sometimes give
>    a different value from LOWEST_FREQ due to integer approximation
> 3- it is implied that performance and frequency are proportional
>    (NOMINAL_FREQ / NOMINAL_PERF) == (LOWEST_PERF / LOWEST_FREQ)
> 
> This patch changes the conversion functions to an affine function.
> This fixes the 3 points above.
> 
> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 43 +++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 22 deletions(-)

Applied. Thanks.

-- 
viresh
