Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E85A208D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbiHZFz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241505AbiHZFzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:55:24 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC4C2E93
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:55:20 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220826055515euoutp02b3c941665b0093c84844901e963e5333~Oz14cw2iF2903429034euoutp02h
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:55:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220826055515euoutp02b3c941665b0093c84844901e963e5333~Oz14cw2iF2903429034euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661493315;
        bh=4GR+Vs8QxIsviDnv/eHU0Cv9vVsxhNm7ixoKU4xAS80=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Zf6hsL880TB1WiPYRRi0NPHFBgh6CyFJSCB5cLv+o8EOIOdy5e61qD4njuI8PqIUj
         W6g2cYOr/wKxF87lgMhXvmJhQanEYFOjTliMDm7X+11DUuw7aZTu3iKCuhTnpIcH39
         Qg0AZOTSLjZLVqWvW6zbJUvibRDRRHn2Xnx6hiaM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220826055515eucas1p2e249e3f805b9bbfacb3312ec4bea94f4~Oz14CcxdO3203532035eucas1p2-;
        Fri, 26 Aug 2022 05:55:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 00.77.07817.34068036; Fri, 26
        Aug 2022 06:55:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220826055514eucas1p10f990886cf7333dd48f11465b37104f2~Oz13opndR2865128651eucas1p1s;
        Fri, 26 Aug 2022 05:55:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220826055514eusmtrp1c40a980356df2f2b59ddcbd1b8ccabf9~Oz13nFY3n1173811738eusmtrp1i;
        Fri, 26 Aug 2022 05:55:14 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-06-63086043b9e6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.A4.07473.24068036; Fri, 26
        Aug 2022 06:55:14 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220826055514eusmtip208eb058064faf5c98c6ef6ed80075a06~Oz12_HYdT2757327573eusmtip2H;
        Fri, 26 Aug 2022 05:55:14 +0000 (GMT)
Message-ID: <367f1076-0eec-85bd-577e-d9302e461d00@samsung.com>
Date:   Fri, 26 Aug 2022 07:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v5] regulator: core: Resolve supply name earlier to
 prevent double-init
Content-Language: en-US
To:     =?UTF-8?Q?Christian_Kohlsch=c3=bctter?= 
        <christian@kohlschutter.com>, broonie@kernel.org
Cc:     heiko@sntech.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        m.reichl@fivetechno.de, robin.murphy@arm.com,
        vincent.legoll@gmail.com, wens@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220825212842.7176-1-christian@kohlschutter.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMcRTH/e7dvd2Wa24rOvLIXOTZJq+5XnmbNcYMpiaTQTvbnYp2l91K
        DBOiIVopxPZaNIMmlqXHxh/tpt3JoxBpEkmNVLO0GCFZ7d7Qf99zzuc75zGHxMUWoS8Zo4zj
        1EpZLEOIBCXWH7UBKyNI+ayCWiF7tqWNYEst7QTrfNclZL89P4axxtZ6IVtXnkOw952nEPv5
        rRNnO+5/R6y5u03I2q6/J1hd7kti2TBpUV4RkjY2JUlNutceUmPhcUKakVmOSW8XJElL6/Nw
        6Rfj+A1kuGhxJBcbk8CpA4MjRNE5xXZ8l3lC4ukiA3EQ9Y1ORZ4k0HNBW/UTS0UiUkxfRdBl
        1wv54CsCU8YLzEWJ6S8I0pyBfx31Tz8iHrqCoLO3huADB4JGaybuoig6GNIPNXi4tICeDId/
        5GJ83guqL7QJXHokLYf3zstuZgS9FbJaygmXxmkfaGzLd/Pe9DYo672Euxrg9EkMrO12d4Gg
        gyDVnuo2eNJLofhVBcab/SC5ONttADrLEzpeO3B+7lXw6/wFxOsR0Gm748HrsfAw82T/RGS/
        VkHf+Tl8OhHqu4oGrIugqeYn4UJwehoYygcusRwaHjQPOIdDg92Ln2A4ZJRk4XyagmMpYp72
        B53txr+e5ifP8HTE6AYdRTdoed2gXXT/++qRoBD5cPEaRRSnma3k9kg0MoUmXhklkasURtT/
        Zg9/276WoSudDokFYSSyICBxxptaaBXIxVSkbO8+Tq3aro6P5TQWNIYUMD6UPOamTExHyeK4
        nRy3i1P/rWKkp+9BbE+l8qg5MHDK7ujHmtVU0sa+2UueKV7sn8hkaakTdfbwdduubazs0War
        ysLSLg4tmzWuVDU5H6/2M1X8DtLXdZ3ZnGadn0Me+GB89PTjvem+t7jrPX4hptGUNWWRT3Kh
        /6cdZ8I3GbwIm/cp7dDmsIIEbOobld4m0ZuStQ3tFaFTs7lzZ9cLQ9fbmf3Dwj26cw0BuQuO
        RFhMU0y9ce3yGkdI8IIV92Ycj7yY10F1s3OZLV496sX+5vkJa/c9QjM6qwJq/UW2d62KURl2
        PC1xJtO87O48hE1YU52zNX/745TWIYlEbciklrxRBU3NnGiz49IcSXaV4a66ZHzYvNg3laGM
        QBMtC5qOqzWyP1I/rDfVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7pOCRzJBhtnalpMffiEzWL7oeds
        Fv8fvWa1+Halg8li0+NrrBaXd81hszjyv5/R4tOD/8wWL4/8YLQ4+OEJq8Xxtc/YLGbNvc7m
        wOOxZt4aRo9bd+o9ds66y+6xaVUnm8ekybuYPDYvqffYfm0es8fnTXIBHFF6NkX5pSWpChn5
        xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GXO2vmUuOKhQMXHNerYG
        xr+SXYycHBICJhLXLr5j7GLk4hASWMoocWzhXSaIhIzEyWkNrBC2sMSfa11sEEXvGSV2nPnF
        DpLgFbCTmNB4A8xmEVCVaPo5lwkiLihxcuYTFhBbVCBZYsGhpWC2sECsxPSHu9hAbGYBcYlb
        T+aD1YsIxEncvbYUbAGzQA+TxJQvR1ggtp1hlLh8bjYzSBWbgKFE19susG5OAXuJrbcPMEFM
        MpPo2trFCGHLSzRvnc08gVFoFpJDZiFZOAtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXr
        JefnbmIERvG2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrxWx1iShXhTEiurUovy44tKc1KLDzGa
        AkNjIrOUaHI+MI3klcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUw
        Kf0+mb82PVs6w7t0y+vJm4w7eNLZD+3O+XUm48ydggun3t2cJvDhMjer5Rm15KQXN4Wv1Csv
        VE69L9dguMhgnUH13r5FQgwyfhkT7Td8L9RUqjcKuObMczVIYkLnsbIfUR3Pf/u+9n+48S4j
        7xqV6YXqU8TZVp5V+beBY8/JiXbtDx7K9gXW3/lvfDPoqRlPXvGjslN/mfTiemstK1cdzT62
        /7/68aAvCX5/pZ4fabIvsOg4fDzg7NvG0o2Llu458Mwol+lLruys4tnuVj/KmyXP/GiKt1GZ
        H7z+/YnAicvmTnBflp1a9tWTUfzPdv/Vx7dO+irgzX6x/pXLh/tyd1cJ2eybzNB1J86t9NQM
        RyWW4oxEQy3mouJEAA3MeHxrAwAA
X-CMS-MailID: 20220826055514eucas1p10f990886cf7333dd48f11465b37104f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220825212905eucas1p139591652111adb8af44f30c0a2fbfe8e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220825212905eucas1p139591652111adb8af44f30c0a2fbfe8e
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
        <CGME20220825212905eucas1p139591652111adb8af44f30c0a2fbfe8e@eucas1p1.samsung.com>
        <20220825212842.7176-1-christian@kohlschutter.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.2022 23:28, Christian Kohlschütter wrote:
> Previously, an unresolved regulator supply reference upon calling
> regulator_register on an always-on or boot-on regulator caused
> set_machine_constraints to be called twice.
>
> This in turn may initialize the regulator twice, leading to voltage
> glitches that are timing-dependent. A simple, unrelated configuration
> change may be enough to hide this problem, only to be surfaced by
> chance.
>
> One such example is the SD-Card voltage regulator in a NanoPI R4S that
> would not initialize reliably unless the registration flow was just
> complex enough to allow the regulator to properly reset between calls.
>
> Fix this by re-arranging regulator_register, trying resolve the
> regulator's supply early enough that set_machine_constraints does not
> need to be called twice.
>
> Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/regulator/core.c | 58 ++++++++++++++++++++++++----------------
>   1 file changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 77f60eef960..2ff0ab2730f 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5391,6 +5391,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
>   	bool dangling_of_gpiod = false;
>   	struct device *dev;
>   	int ret, i;
> +	bool resolved_early = false;
>   
>   	if (cfg == NULL)
>   		return ERR_PTR(-EINVAL);
> @@ -5494,24 +5495,10 @@ regulator_register(const struct regulator_desc *regulator_desc,
>   	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
>   	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
>   
> -	/* preform any regulator specific init */
> -	if (init_data && init_data->regulator_init) {
> -		ret = init_data->regulator_init(rdev->reg_data);
> -		if (ret < 0)
> -			goto clean;
> -	}
> -
> -	if (config->ena_gpiod) {
> -		ret = regulator_ena_gpio_request(rdev, config);
> -		if (ret != 0) {
> -			rdev_err(rdev, "Failed to request enable GPIO: %pe\n",
> -				 ERR_PTR(ret));
> -			goto clean;
> -		}
> -		/* The regulator core took over the GPIO descriptor */
> -		dangling_cfg_gpiod = false;
> -		dangling_of_gpiod = false;
> -	}
> +	if (init_data && init_data->supply_regulator)
> +		rdev->supply_name = init_data->supply_regulator;
> +	else if (regulator_desc->supply_name)
> +		rdev->supply_name = regulator_desc->supply_name;
>   
>   	/* register with sysfs */
>   	rdev->dev.class = &regulator_class;
> @@ -5533,13 +5520,38 @@ regulator_register(const struct regulator_desc *regulator_desc,
>   		goto wash;
>   	}
>   
> -	if (init_data && init_data->supply_regulator)
> -		rdev->supply_name = init_data->supply_regulator;
> -	else if (regulator_desc->supply_name)
> -		rdev->supply_name = regulator_desc->supply_name;
> +	if ((rdev->supply_name && !rdev->supply) &&
> +		(rdev->constraints->always_on ||
> +		 rdev->constraints->boot_on)) {
> +		ret = regulator_resolve_supply(rdev);
> +		if (ret != 0)
> +			rdev_dbg(rdev, "Unable to resolve supply early: %pe\n",
> +				 ERR_PTR(ret));
> +
> +		resolved_early = true;
> +	}
> +
> +	/* perform any regulator specific init */
> +	if (init_data && init_data->regulator_init) {
> +		ret = init_data->regulator_init(rdev->reg_data);
> +		if (ret < 0)
> +			goto wash;
> +	}
> +
> +	if (config->ena_gpiod) {
> +		ret = regulator_ena_gpio_request(rdev, config);
> +		if (ret != 0) {
> +			rdev_err(rdev, "Failed to request enable GPIO: %pe\n",
> +					 ERR_PTR(ret));
> +			goto wash;
> +		}
> +		/* The regulator core took over the GPIO descriptor */
> +		dangling_cfg_gpiod = false;
> +		dangling_of_gpiod = false;
> +	}
>   
>   	ret = set_machine_constraints(rdev);
> -	if (ret == -EPROBE_DEFER) {
> +	if (ret == -EPROBE_DEFER && !resolved_early) {
>   		/* Regulator might be in bypass mode and so needs its supply
>   		 * to set the constraints
>   		 */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

