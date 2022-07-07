Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD52456A076
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiGGKxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiGGKxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:53:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496F657220
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:53:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 70so3483851pfx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o2TkSbcKxozTBX+199C68EfPygrcFe2Tw030jZ4Z9vM=;
        b=GgGDiY3sxbPO69gH48Dooa8AKF4BOxgykhbQ+1ouSF8dLGeghVSxbRuSNK0BPAx24f
         APydzglFENyyildEjJPmyUFjC3ALeywiRgIWzCsL0tD6jlJw7wgdw5SPOpK13mOYQp1m
         iRE8czv4iIOBp8tHhVqGmvMQtjgmCQQP57BnEdZHwyNe49xS3VcFh0QSulsNKyyMgCPW
         m9xDOwuQqIdAk3VF7wOBs1NrObJARy3N3uedK5oGEldvOtNMJf+FjcuB3iPYSAB5BZg5
         zMj+O7USQ4J2eFtVwGZENKFjQzn1jraVue4zr1H3BuKAKaC0F8j1hN7HCCb152wGGCzu
         POoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o2TkSbcKxozTBX+199C68EfPygrcFe2Tw030jZ4Z9vM=;
        b=t6W0e2yeyfkNuPQY9A0N2VqVQJqwHsitjNe2D9UwhT5/9zPHEoqR2a4I0eGQzcEEBB
         b54ZXa0T3STJcexmXRox7iava68qyiY4G47N9HkFJrAAQ15WPB7U1DrWB83yEZaR6FAh
         SWeXhFWzpPW7NsOe1i1zc8eLB6fet/W9y5Fkza/fGu8Y5V5QnfUs41cXnMJjdaie09U8
         Kbh+K0nSsQmPhRHrk+2zNDlxfqWIjj2dh6yo7JX7INtxC1MLrwuCIMz3DUgAboBckaDt
         YMxxFolC6D6kjor87bODoJSJaB1YaYA3afWKvfiEkPy/+yfI27jBl+YYF+iWE97Ngua+
         k6Zw==
X-Gm-Message-State: AJIora8BVO9/kcfJworIgs9dtoh6vY3r8smgirvONHmAVKgAjfDSxF7f
        L1XDThdZNbcSHqPY5K9Y2zr3jA==
X-Google-Smtp-Source: AGRyM1tpqLIhCdElS4dIR3n1+S+tHgSxDTJ1ClIjp5xZogOgUFu5j/N9tejt6VOIggYIE9m6DdN9ow==
X-Received: by 2002:a17:902:e885:b0:16c:408:9317 with SMTP id w5-20020a170902e88500b0016c04089317mr7760209plg.62.1657191189998;
        Thu, 07 Jul 2022 03:53:09 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ab8800b0016a0bf0ce2esm27552884plr.92.2022.07.07.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:53:09 -0700 (PDT)
Date:   Thu, 7 Jul 2022 16:23:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PM: EM: convert power field to micro-Watts
 precision and align drivers
Message-ID: <20220707105307.wl2pnqbf3j4fo75z@vireshk-i7>
References: <20220707071555.10085-1-lukasz.luba@arm.com>
 <20220707071555.10085-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707071555.10085-2-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-22, 08:15, Lukasz Luba wrote:
> The milli-Watts precision causes rounding errors while calculating
> efficiency cost for each OPP. This is especially visible in the 'simple'
> Energy Model (EM), where the power for each OPP is provided from OPP
> framework. This can cause some OPPs to be marked inefficient, while
> using micro-Watts precision that might not happen.
> 
> Update all EM users which access 'power' field and assume the value is
> in milli-Watts.
> 
> Solve also an issue with potential overflow in calculation of energy
> estimation on 32bit machine. It's needed now since the power value
> (thus the 'cost' as well) are higher.
> 
> Example calculation which shows the rounding error and impact:
> 
> power = 'dyn-power-coeff' * volt_mV * volt_mV * freq_MHz
> 
> power_a_uW = (100 * 600mW * 600mW * 500MHz) / 10^6 = 18000
> power_a_mW = (100 * 600mW * 600mW * 500MHz) / 10^9 = 18
> 
> power_b_uW = (100 * 605mW * 605mW * 600MHz) / 10^6 = 21961
> power_b_mW = (100 * 605mW * 605mW * 600MHz) / 10^9 = 21
> 
> max_freq = 2000MHz
> 
> cost_a_mW = 18 * 2000MHz/500MHz = 72
> cost_a_uW = 18000 * 2000MHz/500MHz = 72000
> 
> cost_b_mW = 21 * 2000MHz/600MHz = 70 // <- artificially better
> cost_b_uW = 21961 * 2000MHz/600MHz = 73203
> 
> The 'cost_b_mW' (which is based on old milli-Watts) is misleadingly
> better that the 'cost_b_uW' (this patch uses micro-Watts) and such
> would have impact on the 'inefficient OPPs' information in the Cpufreq
> framework. This patch set removes the rounding issue.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c |  7 ++--
>  drivers/cpufreq/scmi-cpufreq.c        |  6 +++
>  drivers/opp/of.c                      | 15 ++++----
>  drivers/powercap/dtpm_cpu.c           |  5 +--
>  drivers/thermal/cpufreq_cooling.c     | 13 ++++++-
>  drivers/thermal/devfreq_cooling.c     | 19 ++++++++--
>  include/linux/energy_model.h          | 54 +++++++++++++++++++--------
>  kernel/power/energy_model.c           | 24 ++++++++----
>  8 files changed, 100 insertions(+), 43 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
