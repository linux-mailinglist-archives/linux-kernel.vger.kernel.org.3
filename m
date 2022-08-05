Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C257158A40A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 02:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiHEAAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 20:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiHEAAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 20:00:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE091C9;
        Thu,  4 Aug 2022 17:00:10 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 168826601BFA;
        Fri,  5 Aug 2022 01:00:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659657609;
        bh=9IWOqoMZl87xKFNXdbsY2lD256+X8oemFwBtvRVYKMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCk84Flp/HQMm/r7Wu1xhl6K9nnsuhbKmhYnpEZFhls8m64otTleTFvTId5i3fg0J
         n53uFS0ILVjAVjNE2AxXtF33RNeHDJiwFw4BAi0DpKfRN07o376iDyoMJ7rej8FxAV
         cBzMNgOnjhk93Nck/64Wd61K41LZ3JthNdLcKMCuIUTOW+DOeC2xlKcunNvgiIZPhK
         gzxuhTTlhwwTViXamwzMhNBd16XD0/CyWTVDqK17RRukKIqJlWBKuifhDFwjiQHALy
         jig/uIpwDnMp8StHAvUDBtKHKHK4R1iX3d7oMGIg0EKNQIJpkBiIPGKGOz06se3Khr
         Gi8NSKUhgv3EA==
Date:   Thu, 4 Aug 2022 20:00:03 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: Re: [PATCH v8.1, 4/7] thermal: mediatek: Add LVTS driver for mt8192
 thermal zones
Message-ID: <20220805000003.gljuut3udzed7avz@notapiano>
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-5-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804130912.676043-5-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balsam,

another thing.

On Thu, Aug 04, 2022 at 03:09:09PM +0200, bchihi@baylibre.com wrote:
[..]
> --- /dev/null
> +++ b/drivers/thermal/mediatek/lvts_thermal.h
[..]
> +#define ONE_SAMPLE							(lvts_data->counting_window_us + 2 * BUS_ACCESS_US)

This macro is still using a hardcoded variable.

> +#define NUM_OF_SAMPLE(tc_id)				((lvts_data->tc[tc_id].hw_filter < LVTS_FILTER_2) ? \
> +	1 : ((lvts_data->tc[tc_id].hw_filter > LVTS_FILTER_16_OF_18) ? \
> +	1 : ((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_16_OF_18) ? \
> +	18 : ((lvts_data->tc[tc_id].hw_filter == LVTS_FILTER_8_OF_10) ? \
> +	10 : (lvts_data->tc[tc_id].hw_filter * 2)))))

Ditto.

> +
> +#define PERIOD_UNIT_US(tc_id)		((lvts_data->tc[tc_id].tc_speed->period_unit * 256 * \
> +	CLOCK_26MHZ_CYCLE_NS) / 1000)
> +#define FILTER_INT_US(tc_id)		(lvts_data->tc[tc_id].tc_speed->filter_interval_delay * \
> +	PERIOD_UNIT_US(tc_id))
> +#define SENSOR_INT_US(tc_id)		(lvts_data->tc[tc_id].tc_speed->sensor_interval_delay * \
> +	PERIOD_UNIT_US(tc_id))
> +#define GROUP_INT_US(tc_id)			(lvts_data->tc[tc_id].tc_speed->group_interval_delay * \
> +	PERIOD_UNIT_US(tc_id))

All of these too.

> +#define SENSOR_LATENCY_US(tc_id)	((NUM_OF_SAMPLE(tc_id) - 1) * FILTER_INT_US(tc_id) + \
[..]
> +#define DEVICE_READ				(CK26M_ACTIVE(lvts_data) | DEVICE_ACCESS)

And this.

> +#define DEVICE_WRITE			(CK26M_ACTIVE(lvts_data) | DEVICE_ACCESS | WRITE_ACCESS)

And this.

> +#define RESET_ALL_DEVICES		(DEVICE_WRITE | RG_TSFM_RST << 8 | 0xFF)
> +#define READ_DEVICE_REG(reg_id)	(DEVICE_READ | (reg_id) << 8 | 0x00)
> +#define READ_BACK_DEVICE_ID		(CK26M_ACTIVE(lvts_data) | DEVICE_ACCESS | BROADCAST_ID_UPDATE | \

And finally this one.

I might've have missed some, so please double-check and remove any lingering
hardcoded variable in macros.

Thanks,
Nícolas

> +	RG_DID_LVTS << 8)
[..]
