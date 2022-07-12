Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE4570E79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiGLAA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGLAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:00:24 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015362C656
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:00:21 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220712000019epoutp04a22a2d3409e42be5da289a3b24601736~A6_IRu_9t0427504275epoutp04d
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:00:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220712000019epoutp04a22a2d3409e42be5da289a3b24601736~A6_IRu_9t0427504275epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657584019;
        bh=QbPRAuj/G3AeRRcD3GrylXayae1kNYVlh4RBxNQcYxQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sZHjnFD05TZglR5JEitTIv3qHV1WtU+aoObBam5rDGcKETiNES1yV7eehpmmNVIro
         qF8xhHM3A7yMLaw68zSoZ6EoJsf3Q+NSxziLxDYz9OtAc/VAMDGG3IqPkD8LrViO7q
         bGZ+VdSs4JfysTmYwhh4iMCpXZ8VVZM5yb86eWmE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220712000018epcas1p29199332ae4e22f9e620569bc571ceda0~A6_Hp9bjE2903029030epcas1p2u;
        Tue, 12 Jul 2022 00:00:18 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.222]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lhgqj73LWz4x9Q0; Tue, 12 Jul
        2022 00:00:17 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.CE.09633.199BCC26; Tue, 12 Jul 2022 09:00:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220712000017epcas1p2187113f8068be6949afb87cadfa5476c~A6_GvRpD32903029030epcas1p2p;
        Tue, 12 Jul 2022 00:00:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220712000017epsmtrp10140f2470bc8b8b1d01b0160b3bc9ea8~A6_GuG7In1284112841epsmtrp11;
        Tue, 12 Jul 2022 00:00:17 +0000 (GMT)
X-AuditID: b6c32a36-8821aa80000025a1-0c-62ccb991caec
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.D0.08802.199BCC26; Tue, 12 Jul 2022 09:00:17 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220712000017epsmtip11f78405b314f210a48ca07802f8dff76~A6_Gd63rZ2513025130epsmtip1N;
        Tue, 12 Jul 2022 00:00:17 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <axboe@kernel.dk>,
        <Avri.Altman@wdc.com>, <shawn.lin@rock-chips.com>,
        <adrian.hunter@intel.com>
Cc:     <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
        <dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
        <jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>,
        <seunghwan.hyun@samsung.com>
In-Reply-To: <20220705015729.14455-1-sh043.lee@samsung.com>
Subject: RE: [PATCH] mmc: use mmc_card_* macro and add it for sd_combo
Date:   Tue, 12 Jul 2022 09:00:17 +0900
Message-ID: <013e01d89582$5e8d3830$1ba7a890$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGsnp/peaG99Yte9Le8RtwF2g9pOAIxCFJ0rcA8XxA=
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xbZRjOd3o7THGHluEnCOsOIXM4oIXSncJqWGiwUWIg++EddoATipTT
        pqeYTn+MSFIYIle3YcEEtkmUQVDWcQsryAqlXBRhdAlhyVzYABE3y5DQDbD0dMq/53m/5/ne
        5/0uKEf4Kz8ULaCNlIEmtTj/ALf71rHYmNq+yRzJk0aCcC6284mVrTk+ce1uNZ9oGDfzCJvL
        KSA8250CovxGPUL0Lk0KiP7tUoSY7W/iE/bdakD84nTzCNfkGI9YWOzkEY6Od4nrM/9wUzD1
        lYEVRD07VaxecA3w1duWQa66ytoG1OtdEeqyoS+RDMEHhSc1FJlHGcQUnavLK6Dzlfjbp7NT
        sxPlEmmMVEGcwMU0WUQpcVV6RkxagdabHRd/SmqLvaUMkmHwuDdOGnTFRkqs0TFGJU7p87R6
        uT6WIYuYYjo/lqaMSVKJJD7RKzxTqLlj3+HqzyebStvnOCXg77gKEIBCTAarl0e4FeAAKsR6
        Aex+eIPHEreXVA4hLFkHsGehkvvcMnzZzmEX+gEc3ZwUsGQZwKf1I/w9FR87Dv907/r2CsZs
        AHoaan0WDuYB8MJsk2BPFYAlw4clA2APi7A0OO7eQfYwF4uCq7frfZpATAErx2Z4LA6Czm8W
        fTk42GHYs9bEYTOJ4daDVh5bD4aN582+ejCWBHeHmn0pIPYYhTM1SwhrUMHLfZcELBbBPxxW
        Pw6FK9VmP2ageWfH38AEf6564scJ0L2+7g2Nepsdg539/qM8AvuefgvYDC/BvzYqeXsSiAXC
        crOQlUTClfut/gSvwKtl85wagFv2TWbZN5ll3zSW/5s1A24bCKH0TFE+xUj18f/dd66uqAv4
        Xna0vBfUrT2OHQYICoYBRDl4cOCzqfEcYWAeefYzyqDLNhRrKWYYJHrPupYTeihX5/0atDFb
        KlNIZPJ4GZGgSJDjLwe2XZwghVg+aaQKKUpPGZ77EDQgtARpjhodedbxavuPHw9SDZnzQ1/8
        9uKt+SM35zvwMdXpIPOa41Fa0m6UKPmrtqtzJlXMQvgd4dlrMtLVdU50qiYtAzd+KOeGhWeN
        gmy6rOmjrXMnOr5erT+6lJtqChHYCjULjS3aM2+JI1bRqMzvfnrfnnW08b3ulIO2QVdd6EZW
        QffB8I3I17dfWK+4u5q/+U66Bh+qyIy0TlO0s2Xa1aPoQ40T0/EXHvRXWVtaxYeTQu7Z5idw
        e/oVR4Pqc4Ho5rKH9+btOsv9OMTkCEA/uTguTZ2i044Hvfb7KU+04YfpQ3228umRCKAscM19
        /6i0SjmrsN5zj0Rc5+dshreEpYAwnMtoSGk0x8CQ/wKD+zfiYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnO7EnWeSDKb9F7I4+WQNm8XLn1fZ
        LFbf7WezmHGqjdVi37WT7Ba//q5nt+jYOpnJYsfzM+wWu/42M1lc3jWHzeLI/35Gi3MnP7Fa
        XDtzgtXizpP1rBbH14ZbbL70jcVBwGPxnpdMHpfPlnrcubaHzePvrP0sHn1bVjF6fN4k59F+
        oJspgD2KyyYlNSezLLVI3y6BK+P6kX8sBZ3WFc1rrjI3MH7U72Lk5JAQMJE4tOgIcxcjF4eQ
        wA5GiRW3H7NAJCQlFj96yNbFyAFkC0scPlwMUfOMUeLlx/OsIDVsAjoSbz79ZwVJiAgcY5Ro
        m7SAHcRhFmhiknjX95QNoqWHUeLazGmMIC2cAtYSzxr2gNnCAm4Spz79YwKxWQRUJV5fmcwO
        YvMKWEr0nLjECmELSpyc+QTsJGYBbYneh62MELa8xPa3c5ghTlWQ+Pl0GStEXERidmcbWFxE
        wEri/4EFrBMYhWchGTULyahZSEbNQtK+gJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+
        7iZGcPRqae1g3LPqg94hRiYOxkOMEhzMSiK8f86eShLiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e6HrZLyQQHpiSWp2ampBahFMlomDU6qByfBo0pypm5KWe89mnzdt+fnea85fX6/f23px87vc
        ad7CJqbHku7vlXSy2PhNd/9RmSfzrP2/FXg89JfyZv7DKB+4+RD/n7UhffqeL/p39sRnFRS/
        X/b90YfFlQ5fv4tzNr0M+OgUnrbHYH7F/D+8wdnd3xfP57z02+Pq7n9C80U89GeJaXZ/dzGb
        kvGC8e2FTCUTC5kTSdH+5+768Sgv1/w57UWF9D8OiVj5V2W5q2udP/z+tnp/+3sh3nOicmcs
        5xg5MzD9fp2/fLlU8UY/pvt3b+mk1lVb3K2tinu7a73WtGXun7NDm64mfNga/UCJ6YjJi//O
        kU03nslu2VXonBzk8uHDxJWa97NT1klLCCixFGckGmoxFxUnAgDac+64TQMAAA==
X-CMS-MailID: 20220712000017epcas1p2187113f8068be6949afb87cadfa5476c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220705012516epcas1p2c15e9e9984735c32bcc754ff646ccbf3
References: <CGME20220705012516epcas1p2c15e9e9984735c32bcc754ff646ccbf3@epcas1p2.samsung.com>
        <20220705015729.14455-1-sh043.lee@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Seunghui Lee <sh043.lee@samsung.com>
> Sent: Tuesday, July 5, 2022 10:57 AM
> To: ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-
> kernel@vger.kernel.org; axboe@kernel.dk; Avri.Altman@wdc.com;
> shawn.lin@rock-chips.com; adrian.hunter@intel.com
> Cc: grant.jung@samsung.com; jt77.jang@samsung.com;
> dh0421.hwang@samsung.com; junwoo80.lee@samsung.com; jangsub.yi@samsung.com;
> cw9316.lee@samsung.com; sh8267.baek@samsung.com; wkon.kim@samsung.com;
> seunghwan.hyun@samsung.com; Seunghui Lee <sh043.lee@samsung.com>
> Subject: [PATCH] mmc: use mmc_card_* macro and add it for sd_combo
> 
> add mmc_card_sd_combo() macro for sd combo type card and use mmc_card_*
> macro to simplify instead of comparing card->type
> 
> Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
> ---
>  drivers/mmc/core/block.c  |  4 ++--
>  drivers/mmc/core/bus.c    |  4 ++--
>  drivers/mmc/core/sd.c     |  2 +-
>  drivers/mmc/core/sdio.c   | 16 ++++++++--------
>  drivers/mmc/host/mxcmmc.c |  2 +-
>  include/linux/mmc/card.h  |  1 +
>  6 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> bda6c67ce93f..4d7ae8fc2901 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2987,7 +2987,7 @@ static int mmc_blk_probe(struct mmc_card *card)
>  	 * Don't enable runtime PM for SD-combo cards here. Leave that
>  	 * decision to be taken during the SDIO init sequence instead.
>  	 */
> -	if (card->type != MMC_TYPE_SD_COMBO) {
> +	if (!mmc_card_sd_combo(card)) {
>  		pm_runtime_set_active(&card->dev);
>  		pm_runtime_enable(&card->dev);
>  	}
> @@ -3014,7 +3014,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>  		mmc_blk_part_switch(card, md->part_type);
>  		mmc_release_host(card->host);
>  	}
> -	if (card->type != MMC_TYPE_SD_COMBO)
> +	if (!mmc_card_sd_combo(card))
>  		pm_runtime_disable(&card->dev);
>  	pm_runtime_put_noidle(&card->dev);
>  	mmc_blk_remove_req(md);
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
> 58a60afa650b..d8762fa3d5cd 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -85,7 +85,7 @@ mmc_bus_uevent(struct device *dev, struct
> kobj_uevent_env *env)
>  			return retval;
>  	}
> 
> -	if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO)
> {
> +	if (mmc_card_sdio(card) || mmc_card_sd_combo(card)) {
>  		retval = add_uevent_var(env, "SDIO_ID=%04X:%04X",
>  					card->cis.vendor, card->cis.device);
>  		if (retval)
> @@ -107,7 +107,7 @@ mmc_bus_uevent(struct device *dev, struct
> kobj_uevent_env *env)
>  	 * SDIO (non-combo) cards are not handled by mmc_block driver and
> do not
>  	 * have accessible CID register which used by mmc_card_name()
> function.
>  	 */
> -	if (card->type == MMC_TYPE_SDIO)
> +	if (mmc_card_sdio(card))
>  		return 0;
> 
>  	retval = add_uevent_var(env, "MMC_NAME=%s", mmc_card_name(card));
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> c5f1df6ce4c0..f0186bdf2025 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -793,7 +793,7 @@ static umode_t sd_std_is_visible(struct kobject *kobj,
> struct attribute *attr,
>  	     attr == &dev_attr_info2.attr ||
>  	     attr == &dev_attr_info3.attr ||
>  	     attr == &dev_attr_info4.attr
> -	    ) && card->type != MMC_TYPE_SD_COMBO)
> +	    ) &&!mmc_card_sd_combo(card))
>  		return 0;
> 
>  	return attr->mode;
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c index
> 25799accf8a0..b589df1c35e0 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -335,7 +335,7 @@ static int sdio_disable_4bit_bus(struct mmc_card *card)
> {
>  	int err;
> 
> -	if (card->type == MMC_TYPE_SDIO)
> +	if (mmc_card_sdio(card))
>  		goto out;
> 
>  	if (!(card->host->caps & MMC_CAP_4_BIT_DATA)) @@ -360,7 +360,7 @@
> static int sdio_enable_4bit_bus(struct mmc_card *card)
>  	err = sdio_enable_wide(card);
>  	if (err <= 0)
>  		return err;
> -	if (card->type == MMC_TYPE_SDIO)
> +	if (mmc_card_sdio(card))
>  		goto out;
> 
>  	if (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4) { @@ -415,7 +415,7
> @@ static int sdio_enable_hs(struct mmc_card *card)
>  	int ret;
> 
>  	ret = mmc_sdio_switch_hs(card, true);
> -	if (ret <= 0 || card->type == MMC_TYPE_SDIO)
> +	if (ret <= 0 || mmc_card_sdio(card))
>  		return ret;
> 
>  	ret = mmc_sd_switch_hs(card);
> @@ -441,7 +441,7 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card
> *card)
>  		max_dtr = card->cis.max_dtr;
>  	}
> 
> -	if (card->type == MMC_TYPE_SD_COMBO)
> +	if (mmc_card_sd_combo(card))
>  		max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
> 
>  	return max_dtr;
> @@ -689,7 +689,7 @@ static int mmc_sdio_init_card(struct mmc_host *host,
> u32 ocr,
>  	    mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
>  		card->type = MMC_TYPE_SD_COMBO;
> 
> -		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
> +		if (oldcard && (!mmc_card_sd_combo(oldcard) ||
>  		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card-
> >raw_cid)) != 0)) {
>  			err = -ENOENT;
>  			goto mismatch;
> @@ -697,7 +697,7 @@ static int mmc_sdio_init_card(struct mmc_host *host,
> u32 ocr,
>  	} else {
>  		card->type = MMC_TYPE_SDIO;
> 
> -		if (oldcard && oldcard->type != MMC_TYPE_SDIO) {
> +		if (oldcard && !mmc_card_sdio(oldcard)) {
>  			err = -ENOENT;
>  			goto mismatch;
>  		}
> @@ -754,7 +754,7 @@ static int mmc_sdio_init_card(struct mmc_host *host,
> u32 ocr,
>  	/*
>  	 * Read CSD, before selecting the card
>  	 */
> -	if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
> +	if (!oldcard && mmc_card_sd_combo(card)) {
>  		err = mmc_sd_get_csd(card);
>  		if (err)
>  			goto remove;
> @@ -827,7 +827,7 @@ static int mmc_sdio_init_card(struct mmc_host *host,
> u32 ocr,
> 
>  	mmc_fixup_device(card, sdio_fixup_methods);
> 
> -	if (card->type == MMC_TYPE_SD_COMBO) {
> +	if (mmc_card_sd_combo(card)) {
>  		err = mmc_sd_setup_card(host, card, oldcard != NULL);
>  		/* handle as SDIO-only card if memory init failed */
>  		if (err) {
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c index
> 613f13306433..2cf0413407ea 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -923,7 +923,7 @@ static void mxcmci_init_card(struct mmc_host *host,
> struct mmc_card *card)
>  	 * One way to prevent this is to only allow 1-bit transfers.
>  	 */
> 
> -	if (is_imx31_mmc(mxcmci) && card->type == MMC_TYPE_SDIO)
> +	if (is_imx31_mmc(mxcmci) && mmc_card_sdio(card))
>  		host->caps &= ~MMC_CAP_4_BIT_DATA;
>  	else
>  		host->caps |= MMC_CAP_4_BIT_DATA;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> 37f975875102..156a7b673a28 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -348,5 +348,6 @@ bool mmc_card_is_blockaddr(struct mmc_card *card);
>  #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
>  #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
>  #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
> +#define mmc_card_sd_combo(c)	((c)->type == MMC_TYPE_SD_COMBO)
> 
>  #endif /* LINUX_MMC_CARD_H */
> --
> 2.29.0
Please give me any opinion or suggestion about this commit.
It reduces the length of the line and looks simple.
When it comes to refactoring, I've tried to add sd_combo macro as well.


