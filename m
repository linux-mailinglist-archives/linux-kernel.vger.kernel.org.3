Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2908F578858
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiGRR14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiGRR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:27:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30922C640
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:27:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mf4so22573003ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kGv4Dzn3NGROuY+ZnagFOTMoVDNdaJpTmvteY9zyqDw=;
        b=k7OtEKw8ePt0J1gLOCtaDbhJFTnNEB9nIdz7gNXp+iOw2AbBV0Wss1w4VdVBKCfwaV
         sksMG9FHNQ8hNf8txKjO48pwrlEcbcGT1TQYDofR6d0i9AExPeHT6wROP3UiQnTjKaNr
         RRG9b7k+cRbjIH/kk4RzVRophBDuJiIBIAmYiHo+tVbqtn1yfapzRlKTTvL5La9+zKVK
         bVdbVZOgzSGligYwiFAgUtdcG/sy6R/jR8/qDcreQ90gvQkPkXDPMyAb7y6aj24OErz+
         yvvk3pWoEfO1cbAv4EuHrxFtXo7d3P/FubxWcez8WiA3ZvV5QBgnuBKq8phcEImce+IN
         SQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kGv4Dzn3NGROuY+ZnagFOTMoVDNdaJpTmvteY9zyqDw=;
        b=rbFBl9H9zXZ82hiIKwxWl13Ags4NvBbnfABNHEMG2L+ugfMex5iA6k0yxDPZroSux0
         KmJqArgY/0vKrNMUik8Wx19xCfIHE2lh+o6jV/P3FXRR8tlXS8ercW7gSGSwaDMD171r
         xydOO3kEDD4k2g+y+eL595bOaXOidDFBVL7oJywcLSo0Rb9fXVKAT5BRo8dCFhvjBtfh
         KoyL7mdVlHWly5KJv9zaOI0EhxvWi6obu3Rjnu6DhVtP9wIy1O71SKDFoBuaoL3DCq/T
         2JSQ28fSZNp6ouM2RTuShX2xvvdQzAeyJxSsEathneTLJcUOXp2ULVTD+rLGoj7j6ANX
         6vdQ==
X-Gm-Message-State: AJIora9f+muvk9hxTjUaa9QzmRGXKEXALTJhD0D/O0SfVS3dkBnRRGXM
        hFEk9Qax1FdMh8bzpOt7CnKu1A==
X-Google-Smtp-Source: AGRyM1vp3STBBc6tMp8I3dy4hT2FX66C1r3IVgqXJ3Y6W67ZB1jyxwhCyt9fhwf+SetmiC6fhIAPUA==
X-Received: by 2002:a17:906:ef8c:b0:72e:dd32:4163 with SMTP id ze12-20020a170906ef8c00b0072edd324163mr21073322ejb.430.1658165271505;
        Mon, 18 Jul 2022 10:27:51 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b0072b592ee073sm5803535ejb.147.2022.07.18.10.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 10:27:51 -0700 (PDT)
Date:   Mon, 18 Jul 2022 19:27:50 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: riscv-sbi: Fix CPU_PM_CPU_IDLE_ENTER_xyz()
 macro usage
Message-ID: <20220718172750.fgncyl3egnrykt5a@kamzik>
References: <20220718084553.2056169-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718084553.2056169-1-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 02:15:53PM +0530, Anup Patel wrote:
> Currently, we are using CPU_PM_CPU_IDLE_ENTER_PARAM() for all SBI HSM
> suspend types so retentive suspend types are also treated non-retentive
> and kernel will do redundant additional work for these states.
> 
> The BIT[31] of SBI HSM suspend types allows us to differentiate between
> retentive and non-retentive suspend types so we should use this BIT
> to call appropriate CPU_PM_CPU_IDLE_ENTER_xyz() macro.
> 
> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index 1151e5e2ba82..33c92fec4365 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -97,8 +97,13 @@ static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
>  				   struct cpuidle_driver *drv, int idx)
>  {
>  	u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
> +	u32 state = states[idx];
>  
> -	return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, states[idx]);
> +	if (state & SBI_HSM_SUSP_NON_RET_BIT)
> +		return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, state);
> +	else
> +		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
> +							     idx, state);
>  }
>  
>  static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
