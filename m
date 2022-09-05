Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAFD5ADA7B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiIEVBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiIEVBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:01:40 -0400
Received: from smtp.220.in.ua (smtp.220.in.ua [89.184.67.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AA5B56BAB;
        Mon,  5 Sep 2022 14:01:39 -0700 (PDT)
Received: from [192.168.202.100] (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id B10D21A22385;
        Mon,  5 Sep 2022 23:53:25 +0300 (EEST)
Message-ID: <414d008c-3be8-a6b8-5f7e-0e034c354acb@kaa.org.ua>
Date:   Mon, 5 Sep 2022 23:53:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/3] leds: cr0014114: silent no spi_device_id warning
Content-Language: uk-UA
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220905152659.4152483-1-weiyongjun@huaweicloud.com>
From:   Oleh Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <20220905152659.4152483-1-weiyongjun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Oleh Kravchenko <oleg@kaa.org.ua>

05.09.22 18:26, Wei Yongjun пише:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Add spi_device_id entries to silent following SPI warning:
> 
> SPI driver leds_cr0014114 has no spi_device_id for crane,cr0014114
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/leds/leds-cr0014114.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
> index c87686bd7c18..095455163246 100644
> --- a/drivers/leds/leds-cr0014114.c
> +++ b/drivers/leds/leds-cr0014114.c
> @@ -281,9 +281,16 @@ static const struct of_device_id cr0014114_dt_ids[] = {
>   
>   MODULE_DEVICE_TABLE(of, cr0014114_dt_ids);
>   
> +static const struct spi_device_id cr0014114_spi_ids[] = {
> +	{ "cr0014114" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, cr0014114_spi_ids);
> +
>   static struct spi_driver cr0014114_driver = {
>   	.probe		= cr0014114_probe,
>   	.remove		= cr0014114_remove,
> +	.id_table	= cr0014114_spi_ids,
>   	.driver = {
>   		.name		= KBUILD_MODNAME,
>   		.of_match_table	= cr0014114_dt_ids,
