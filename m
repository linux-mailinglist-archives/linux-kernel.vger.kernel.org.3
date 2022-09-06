Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC15AE924
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiIFNLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiIFNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:11:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C3659F8;
        Tue,  6 Sep 2022 06:11:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B80DF660037F;
        Tue,  6 Sep 2022 14:11:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662469869;
        bh=5QO1SLp5eg80ObSSt8FLqmBTFoFhiD0BogISlBa9BUQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mOY7c50kE5+Xmrb35k079cHSMFkYyUhYJe+5NjUUjK8ZUXDK2Cj5ao5UFUt6ANYUq
         MbENZTEK+MC3hZgppOROxiXeWrvpQjkxT6YjcoMgmWubysUlbKG77vCqaEkWRDRal9
         XXpS0HpF4+46bmoLB10JvyBEUVX9ZdQGSREbTyPXFsZn6YfaEG5VzCQDo8FnzKShL+
         XBdK7rg58ksb9EzHK9Ozg4bd0EY8Yc3pKrEVM3aopMr0XqtFVapzbd8WRV3eV8G+7D
         kXDLzfz9Muog+VR73hD4bNVxPc1EBMTiMUwEjla1rHk5Sro9Q91O0seQeTlmhd+iQq
         3CWCI7wojCwxQ==
Message-ID: <efe46a7d-89b7-2465-e593-8383d1546c16@collabora.com>
Date:   Tue, 6 Sep 2022 16:11:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 07/33] thermal/drivers/tegra: Switch to new of API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-8-daniel.lezcano@linexp.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220804224349.1926752-8-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/22 01:43, Daniel Lezcano wrote:
> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
> index 05886684f429..c34501287e96 100644
> --- a/drivers/thermal/tegra/tegra30-tsensor.c
> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -159,9 +159,9 @@ static void devm_tegra_tsensor_hw_disable(void *data)
>  	tegra_tsensor_hw_disable(ts);
>  }
>  
> -static int tegra_tsensor_get_temp(void *data, int *temp)
> +static int tegra_tsensor_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
> -	const struct tegra_tsensor_channel *tsc = data;
> +	const struct tegra_tsensor_channel *tsc = tz->devdata;
>  	const struct tegra_tsensor *ts = tsc->ts;
>  	int err, c1, c2, c3, c4, counter;
>  	u32 val;
> @@ -217,9 +217,9 @@ static int tegra_tsensor_temp_to_counter(const struct tegra_tsensor *ts, int tem
>  	return DIV_ROUND_CLOSEST(c2 * 1000000 - ts->calib.b, ts->calib.a);
>  }
>  
> -static int tegra_tsensor_set_trips(void *data, int low, int high)
> +static int tegra_tsensor_set_trips(struct thermal_zone_device *tz, int low, int high)
>  {
> -	const struct tegra_tsensor_channel *tsc = data;
> +	const struct tegra_tsensor_channel *tsc = tz->devdata;
>  	const struct tegra_tsensor *ts = tsc->ts;
>  	u32 val;
>  
> @@ -240,7 +240,7 @@ static int tegra_tsensor_set_trips(void *data, int low, int high)
>  	return 0;
>  }
>  
> -static const struct thermal_zone_of_device_ops ops = {
> +static const struct thermal_zone_device_ops ops = {
>  	.get_temp = tegra_tsensor_get_temp,
>  	.set_trips = tegra_tsensor_set_trips,
>  };
> @@ -516,7 +516,7 @@ static int tegra_tsensor_register_channel(struct tegra_tsensor *ts,
>  	tsc->id = id;
>  	tsc->regs = ts->regs + 0x40 * (hw_id + 1);
>  
> -	tsc->tzd = devm_thermal_zone_of_sensor_register(ts->dev, id, tsc, &ops);
> +	tsc->tzd = devm_thermal_of_zone_register(ts->dev, id, tsc, &ops);
>  	if (IS_ERR(tsc->tzd)) {
>  		if (PTR_ERR(tsc->tzd) != -ENODEV)
>  			return dev_err_probe(ts->dev, PTR_ERR(tsc->tzd),

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # Nexus7

-- 
Best regards,
Dmitry
