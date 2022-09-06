Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D77A5ADED9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiIFFRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIFFRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:17:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539226745D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:17:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso5378808pjd.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=8BL6o4IX1wUUdMQMOvYouiU2H1/IxMVvREYC6zLqjSM=;
        b=TWVCL/xy2HDW+mX4jbgIhLGwdV/WxyPA4RoAN/5cH9gLWKElDmudiSt+BLgWyygYUL
         auKw1A2QkYSevImuO2n+o1XgSBLll2Nco8q4XhnA187HbOc+U5Cp2i67rR50rs/ELzDy
         NOtzxC8RjpPfc87jCp8e46Po/HF2L2I6nSSJbvvD4JIfQX74pWpHmEYRtB4vJrLGTYca
         4ujNx+OlzLtM/0sqxh9DgCzOQT2n5EXHKZTz1lQZ/Fd6ziMtNu6WBBgU06Oqa3MTPYnl
         hX27qfDSveO7p6PQRACejLid/fnq8hfCpPvh9G5VqGJjnxXq7xfwCNID6B7qc2jqgHMK
         vsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8BL6o4IX1wUUdMQMOvYouiU2H1/IxMVvREYC6zLqjSM=;
        b=GDW+90J6JY7Q35qR4UbWVhLH42dSazJGIfQguNTEERWg06CNaPgVRb1e8b031edHuw
         HLav8dmBaEYElV2qdNDGcU8kaJyLlUEGmCcJgzdMVQ7IC8Bl1FElgzneQGeAgb0kP+R3
         1+UAdWzsybCDBTzJzct8H/dnir0VkSMs1sHKlLSCEMH/9APxOJyx0F5PwF7XPXbnoEag
         3s7dO6a5FTrIz4KBtRM1goIatfaeJvGvJEyJ1nNYXa6IWYb5LiAWv66K0/KDVX1aBSNy
         acuZpIVITCY5xeWcacXe6DL2gwYGV1E5UaPtgN367nNaSTqDqK2OZHjxyR35enIYyGHG
         T5Jg==
X-Gm-Message-State: ACgBeo2xoXZhvhKtPgDeXIRLw7tIVScM9JfeSm/0rbdrovx28nTthiq2
        H1geiSCV54jG5uPjy2qhdDMrmw==
X-Google-Smtp-Source: AA6agR4vigj/R654EMDF6SU1v26ypc66waj+AKqfllO/bMw5BRTXkx05tlGvD43pNns3B2wikjG6YA==
X-Received: by 2002:a17:902:9007:b0:176:9f9d:463 with SMTP id a7-20020a170902900700b001769f9d0463mr10844798plp.32.1662441461799;
        Mon, 05 Sep 2022 22:17:41 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id cp15-20020a170902e78f00b00176ae5c0f38sm3276959plb.178.2022.09.05.22.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 22:17:40 -0700 (PDT)
Date:   Tue, 6 Sep 2022 10:47:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 4/5] drm/panfrost: devfreq: set opp to the recommended
 one to configure and enable regulator
Message-ID: <20220906051738.doyrdfcas7f5avkp@vireshk-i7>
References: <20220905171601.79284-1-peron.clem@gmail.com>
 <20220905171601.79284-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905171601.79284-5-peron.clem@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your subject is 87 columns long, better to squeeze it a bit.

On 05-09-22, 19:16, Clément Péron wrote:
> devm_pm_opp_set_regulators() doesn't enable regulator, which make
> regulator framework switching it off during regulator_late_cleanup().

This isn't the normal behavior as it works for everyone at the moment.
You need to explain what special you are doing here, because of which
you are reaching such a situation.

i.e. you are disabling some code that uses GPU ? Please specify exact
code so others can reproduce it as well.

> Call dev_pm_opp_set_opp() with the recommend OPP in
> panfrost_devfreq_init() to enable the regulator and avoid any switch off
> by regulator_late_cleanup().

The regulator is already enabled I think at this point by the
bootloader. What you are doing here is syncing the state of the
hardware with the software, which would disallow disabling of the
resource unnecessarily.

> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 5110cd9b2425..67b242407156 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -131,6 +131,14 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>  		return PTR_ERR(opp);
>  
>  	panfrost_devfreq_profile.initial_freq = cur_freq;
> +
> +	/* Setup and enable regulator */

Similarly here, explain why this is required to be done.

> +	ret = dev_pm_opp_set_opp(dev, opp);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "Couldn't set recommended OPP\n");
> +		return ret;
> +	}
> +
>  	dev_pm_opp_put(opp);

Do this before checking if (ret), so the resource can be freed all the
time.

>  
>  	/*
> -- 
> 2.34.1

-- 
viresh
