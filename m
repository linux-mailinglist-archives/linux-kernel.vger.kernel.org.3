Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B1D4FDCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbiDLKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354197AbiDLKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:37 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038953A42;
        Tue, 12 Apr 2022 02:33:25 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23C7gt62028744;
        Tue, 12 Apr 2022 11:32:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=UICnyf3oPsQTzRC0I9H7zVlnLQiOcv6ykqLEagOPP+A=;
 b=IZiYzbQebMHtNJebYRpmBh7Lqy92kJ9sBKCGLq14bPG5DvZMzlvjveRPSsU/fG8nFkZc
 d7L+1c5QT0rmaKfaygh6U3kvSXCAm2v8IxvHHnXgIMxkt+03qgjPomdHlCyq9vhxHMUQ
 TYbBnYgDgnja+vR7iGrAVCMwaYCKnEC0b0/S2uP76yfzcYWdeNlsCkO7v7PhVPbQEVSP
 cnVRGjd3hOfOyY59a3X7inTOlAz/lsdR0LRsbEPxvnKKjmYZO0JCg8oVGdj0RIapw7Tx
 u8uJpNiaBIOLA8CMZzlU3E58cl+T1Yl98ZwOJgrGZK6M0b5KOj23WKUy8wUz2VU/XQ+J qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fb74y6cgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 11:32:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4773100038;
        Tue, 12 Apr 2022 11:32:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CC121216833;
        Tue, 12 Apr 2022 11:32:55 +0200 (CEST)
Received: from [10.201.21.201] (10.75.127.49) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 12 Apr
 2022 11:32:54 +0200
Message-ID: <8daae353-911c-3102-756f-1f0448704355@foss.st.com>
Date:   Tue, 12 Apr 2022 11:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Linux-stm32] [PATCH] spi: spi-stm32-qspi: using
 pm_runtime_resume_and_get instead of pm_runtime_get_sync
Content-Language: en-US
To:     <cgel.zte@gmail.com>, <broonie@kernel.org>
CC:     Zeal Robot <zealci@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        <mcoquelin.stm32@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220412070906.2532091-1-chi.minghao@zte.com.cn>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220412070906.2532091-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-12_03,2022-04-11_01,2022-02-23_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

On 4/12/22 09:09, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/spi/spi-stm32-qspi.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index ffdc55f87e82..b3586521d08e 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -463,11 +463,9 @@ static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *
>  	if (!spi_mem_supports_op(mem, op))
>  		return -EOPNOTSUPP;
>  
> -	ret = pm_runtime_get_sync(qspi->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(qspi->dev);
> +	ret = pm_runtime_resume_and_get(qspi->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	mutex_lock(&qspi->lock);
>  
> @@ -490,11 +488,9 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(qspi->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(qspi->dev);
> +	ret = pm_runtime_resume_and_get(qspi->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	mutex_lock(&qspi->lock);
>  	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
> @@ -536,11 +532,9 @@ static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
>  	u32 addr_max;
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(qspi->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(qspi->dev);
> +	ret = pm_runtime_resume_and_get(qspi->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	mutex_lock(&qspi->lock);
>  	/* make a local copy of desc op_tmpl and complete dirmap rdesc
> @@ -583,11 +577,9 @@ static int stm32_qspi_setup(struct spi_device *spi)
>  	if (!spi->max_speed_hz)
>  		return -EINVAL;
>  
> -	ret = pm_runtime_get_sync(qspi->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(qspi->dev);
> +	ret = pm_runtime_resume_and_get(qspi->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	presc = DIV_ROUND_UP(qspi->clk_rate, spi->max_speed_hz) - 1;
>  
> @@ -851,11 +843,9 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
>  
>  	pinctrl_pm_select_default_state(dev);
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
>  	writel_relaxed(qspi->dcr_reg, qspi->io_base + QSPI_DCR);

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

