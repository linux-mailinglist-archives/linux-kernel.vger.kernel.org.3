Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA9510A12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354287AbiDZURj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354815AbiDZURf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:17:35 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E018807A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:14:20 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-deb9295679so20580538fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eEFl4B1FbvWCN+VcPB75wKYhR64TSlqT3NDBP8YMG6w=;
        b=pvQykELPdAYRIv4n3PF2TsQ0zl3cWJBZFPdpWAvODxpyPvY0m8eq9jfCqlyvYeD4yU
         fJO2Kj0707/bgK0QRNynPZcxMgxbiVtImKpWUG1TJN9ZvqnQWnYVFydmcCQH8rBdDyA0
         djLWVhC5EtDPU1qCrvoV0Gny4+uBED4ZOTDNPdJE0xcKzbLs6bdvqbiBhxzA+hCwPI86
         sDooyuCIr2JOdt+bDBI6hWALksoGSGQH/oNyn/kKLf4Ne3EgBezKvYCfI5mQm3y8HIWv
         5GF36UvMNNEfcL+sRyfrXLE27TzxLJRMuRJ2p0VcRdbUya3paTwwe0le8ag8EEO1/wsH
         2Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eEFl4B1FbvWCN+VcPB75wKYhR64TSlqT3NDBP8YMG6w=;
        b=mvpc+0QKkOEbA2l93F9Ove9po9ZobiikeJSmNPVkPkILOHObqGiOmQFE6HXXsJckHi
         DUewncdkvwez2d2SbLybWL4sJBRw5v7tcuEXKseqheGJPMed9OUXELTU3OVi5E3oP9bD
         X49f4Dg81/ftUnrTVFcWcvDsAXCoOP/eCUoxuxeD1atjZNty2pd8mqNTJc8UJke7yNa2
         BchRpesRSh3fyNT8UXYe8qaJrfbR/+Ax6xa5Qg3dp5TJMHPgGLx+cQKZqeMRyFelUpkr
         M/E/mFdfsY+h54BCqJveB9ESxQLrDOkaOd7nTyELkwAIT8jsVkJ3zJV1kkTQ5lAVQIaL
         uFRQ==
X-Gm-Message-State: AOAM530/yc96BlnhHuAd6T2XNRnH6KVHcE46boJ3FyfsdshLWdkFCgEC
        aDKCF120jtEP/HIH+wjTCIE=
X-Google-Smtp-Source: ABdhPJyEF26vNitwwhdzPEF5PDBAWD8n5cbVdb9adbklFjpzJS6fIM6S9OxFvJuSXIVZPIFkuAS/Bw==
X-Received: by 2002:a05:6870:5896:b0:e6:6c21:3584 with SMTP id be22-20020a056870589600b000e66c213584mr9849841oab.220.1651004060310;
        Tue, 26 Apr 2022 13:14:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r23-20020a056830237700b005b2610517c8sm5410175oth.56.2022.04.26.13.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:14:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 13:14:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] soc: rockchip: power-domain: Replace dsb() with
 smb()
Message-ID: <20220426201418.GI4093517@roeck-us.net>
References: <20220426014545.628100-1-briannorris@chromium.org>
 <20220426014545.628100-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426014545.628100-2-briannorris@chromium.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 06:45:43PM -0700, Brian Norris wrote:
> It's unclear if these are really needed at all, but seemingly their
> purpose is only as a write barrier. Use the general macro instead of the
> ARM-specific one.
> 
> This driver is partially marked for COMPILE_TEST'ing, but it doesn't
> build under non-ARM architectures. Fix this up before *really* enabling
> it for COMPILE_TEST.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes in v3:
>  * New in v3
> 
>  drivers/soc/rockchip/pm_domains.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
> index 1b029e494274..cf16ff9b73b3 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -178,7 +178,7 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
>  		regmap_update_bits(pmu->regmap, pmu->info->req_offset,
>  				   pd_info->req_mask, idle ? -1U : 0);
>  
> -	dsb(sy);
> +	wmb();
>  
>  	/* Wait util idle_ack = 1 */
>  	target_ack = idle ? pd_info->ack_mask : 0;
> @@ -285,7 +285,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
>  		regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,
>  				   pd->info->pwr_mask, on ? 0 : -1U);
>  
> -	dsb(sy);
> +	wmb();
>  
>  	if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is_on,
>  				      is_on == on, 0, 10000)) {
> -- 
> 2.36.0.rc2.479.g8af0fa9b8e-goog
> 
