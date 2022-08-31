Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC145A776C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiHaHXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiHaHW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:22:56 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AADA2615;
        Wed, 31 Aug 2022 00:22:54 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V4PeFi016216;
        Wed, 31 Aug 2022 09:22:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=EQg/IIxHWRoP16UyxonRRbckr/7L8mRwqHs4veLZRPo=;
 b=bnAlnt8+2Q8Z6J9KALAg8S+w27oDIzR8vLU1rFJSqJjGFCy79VH5/Dml/PxNj/2Fk2C7
 Eqh59v2u4c0B2nohAJSBWX6v8HgseCIdIlAYUCydurfm9QbvYzzirSVDQH7DbapDwZde
 M+MzVO0ccP3/0P78rmseA+t3eXbjVsszavsGMoloA078C+tctNcrvkbxKT8rN1ZD3bhS
 Tjd7YEi/I81ba+5K1hbKZM5CM+CtAsS1bCppcZaySLfvirfwul2IPQn3bT7waTL3PSWB
 ARrR5phtG1ludoTbPJDlJCs1HhOWCo1sF3/2eRySHYG+SJoTVlYGBxHUSrbbx1WYZGTJ 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j7a5j4f5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 09:22:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FF7710002A;
        Wed, 31 Aug 2022 09:22:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0694B2138E4;
        Wed, 31 Aug 2022 09:22:10 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.47) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.7; Wed, 31 Aug
 2022 09:22:09 +0200
Message-ID: <33d2da82-1e8a-c5dd-7f75-2454714357e6@foss.st.com>
Date:   Wed, 31 Aug 2022 09:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] spi: stm32-qspi: Replace of_gpio_named_count() by
 gpiod_count()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
References: <20220830182821.47919-1-andriy.shevchenko@linux.intel.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220830182821.47919-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_03,2022-08-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 8/30/22 20:28, Andy Shevchenko wrote:
> As a preparation to unexport of_gpio_named_count(), convert the
> driver to use gpiod_count() instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi-stm32-qspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index 227f450aa5f0..5858f5f9c758 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -656,7 +656,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
>  	mode = spi->mode & (SPI_TX_OCTAL | SPI_RX_OCTAL);
>  	if ((mode == SPI_TX_OCTAL || mode == SPI_RX_OCTAL) ||
>  	    ((mode == (SPI_TX_OCTAL | SPI_RX_OCTAL)) &&
> -	    of_gpio_named_count(qspi->dev->of_node, "cs-gpios") == -ENOENT)) {
> +	    gpiod_count(qspi->dev, "cs") == -ENOENT)) {
>  		dev_err(qspi->dev, "spi-rx-bus-width\\/spi-tx-bus-width\\/cs-gpios\n");
>  		dev_err(qspi->dev, "configuration not supported\n");
>  
> @@ -681,7 +681,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
>  	 * are both set in spi->mode and "cs-gpios" properties is found in DT
>  	 */
>  	if (((spi->mode & (SPI_TX_OCTAL | SPI_RX_OCTAL)) == (SPI_TX_OCTAL | SPI_RX_OCTAL)) &&
> -	    of_gpio_named_count(qspi->dev->of_node, "cs-gpios")) {
> +	    gpiod_count(qspi->dev, "cs")) {
>  		qspi->cr_reg |= CR_DFM;
>  		dev_dbg(qspi->dev, "Dual flash mode enable");
>  	}

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
