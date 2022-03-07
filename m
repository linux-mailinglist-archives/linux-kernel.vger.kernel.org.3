Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37F4CF43C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiCGJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiCGJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:07:23 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8E60D9E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:06:30 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 050433F60B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646643989;
        bh=G51+HVosbAlITb0w/6sHZUM0ANYY++zOL8WxDgsCYfY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=BmXG8bZOWlwrTC9pwSogufCz4Bp0DgYlIB0o6EkbeHT9KdHetT3T3TXsf0zpz1cEn
         /uGAGpsOiinWUuiVvCRH2dGl6AvtItVsfSY/1cl5MD9ngyPzlXgDxVvyk0wAQzNM5x
         aHqnNGQOvu8tn3epf+e6rcR2QfKG8s0l5xfa7ZYj8hKrYccVBkRu6/EEZn48gksWGR
         /SaWu9b/o6ZQgVIFnXRxB0eejyBJ+sthLiz/iCrcXuh1Zy4fO+6Ftec1d35ZsUDgUr
         U746Z0+lMn368VajdHFwId7L0Yq2Ov/3Ua1LS6ZPkq8Ry+9Te+3EhiZIaIOd1B7PQK
         xwze9p0E4P6Ig==
Received: by mail-ej1-f72.google.com with SMTP id m4-20020a170906160400b006be3f85906eso6688993ejd.23
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G51+HVosbAlITb0w/6sHZUM0ANYY++zOL8WxDgsCYfY=;
        b=oELLT9cpMkAN6ysGHJRINB2o5E6U7hlS2OqOrGChqn3I+bneLhd0NqD34jkjc9Z60k
         Ag8GPTr8E4FZ2il9+3clQ852Ej+CnboqPD0nfY1SV48v2eocYGz2PQeChcZo9jKj32o1
         sHiPhi9QLUAIfDnsiXf22tA0sl0ilTivYnJfxFISv89hHPAuEfULhwedOG7j9fToI3vm
         nIdX0ACtkOsSpXSC2aFis8WPVsAQNjdTviNMx0M3Hot88KFqynP7WsCkRe+iUglQMOsh
         CrbewzmmUAUYrIBL6AnZEjgGIHuix2CGqspckGBLX2ve2TLAk7iAoIYDthX0JftIeuCH
         jT7g==
X-Gm-Message-State: AOAM530y5w644u7ujBZc/j0sgKlKiPF+bFYR6N0clhiI6tX+Bq0gtdkN
        etND3+NY5ScmiuRJJNnfMGe6VH3H9EPnX2sap+gdyA9PMW1uqkaNT4VTjj/J3C6AZaVM1wDCJu9
        IKCMsl/Nk9lCLaVQRqLAuS04mLZ6ipmY2iS/eg2uAqA==
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id fe19-20020a1709072a5300b006cee4fe3f92mr8082883ejc.389.1646643988272;
        Mon, 07 Mar 2022 01:06:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi1G8DMQgsmoK6atV2WQRzLw7W9EhtbGU1zQQMO5T3xle7xKCpGd4S3PplzpSJImoDfIfUbQ==
X-Received: by 2002:a17:907:2a53:b0:6ce:e4fe:3f92 with SMTP id fe19-20020a1709072a5300b006cee4fe3f92mr8082873ejc.389.1646643988071;
        Mon, 07 Mar 2022 01:06:28 -0800 (PST)
Received: from [192.168.0.141] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm5909820edt.3.2022.03.07.01.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 01:06:27 -0800 (PST)
Message-ID: <08992f48-6cb6-8dc0-33d2-f18f942d2bee@canonical.com>
Date:   Mon, 7 Mar 2022 10:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: Support using only local
 timer
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel@axis.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220307083255.1577365-1-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307083255.1577365-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 09:32, Vincent Whitchurch wrote:
> The ARTPEC-8 SoC has a quad-core Cortex-A53 and a single-core Cortex-A5
> which share one MCT with one global and eight local timers.
> 
> The Cortex-A53 boots first and starts the global FRC and also registers
> a clock events device using the global timer.  (This global timer clock
> events is usually replaced by arch timer clock events for each of the
> cores.)
> 
> When the A5 boots, we should not use the global timer interrupts or
> write to the global timer registers.  This is because even if there are
> four global comparators, the control bits for all four are in the same
> registers, and we would need to synchronize between the cpus.  Instead,
> the global timer FRC (already started by the A53) should be used as the
> clock source, and one of the local timers which are not used by the A53
> can be used for clock events on the A5.
> 
> To support this, add a module param to set the local timer starting
> index.  If this parameter is non-zero, the global timer clock events
> device is not registered and we don't write to the global FRC if it is
> already started.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/clocksource/exynos_mct.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)

This should not be send separately from the previous patch.

> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index f29c812b70c9..7ea2919b1808 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -33,7 +33,7 @@
>  #define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
>  #define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
>  #define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
> -#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
> +#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * (x)))
>  #define EXYNOS4_MCT_L_MASK		(0xffffff00)
>  
>  #define MCT_L_TCNTB_OFFSET		(0x00)
> @@ -77,6 +77,13 @@ static unsigned long clk_rate;
>  static unsigned int mct_int_type;
>  static int mct_irqs[MCT_NR_IRQS];
>  
> +/*
> + * First local timer index to use.  If non-zero, global
> + * timer is not written to.
> + */
> +static unsigned int mct_local_idx;
> +module_param_named(local_idx, mct_local_idx, int, 0);

No, it's a no go. Please use dedicated compatible if you need specific
quirks.

> +
>  struct mct_clock_event_device {
>  	struct clock_event_device evt;
>  	unsigned long base;
> @@ -157,6 +164,17 @@ static void exynos4_mct_frc_start(void)
>  	u32 reg;
>  
>  	reg = readl_relaxed(reg_base + EXYNOS4_MCT_G_TCON);
> +
> +	/*
> +	 * If the FRC is already running, we don't need to start it again.  We
> +	 * could probably just do this on all systems, but, to avoid any risk
> +	 * for regressions, we only do it on systems where it's absolutely
> +	 * necessary (i.e., on systems where writes to the global registers
> +	 * need to be avoided).
> +	 */
> +	if (mct_local_idx && (reg & MCT_G_TCON_START))
> +		return;

I don't get it. exynos4_mct_frc_start() is called exactly only once in
the system - during init. Not once per every CPU or cluster (I
understood you have two clusters, right?).

Best regards,
Krzysztof
