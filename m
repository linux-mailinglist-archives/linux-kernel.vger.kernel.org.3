Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA3B5ADA7A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiIEVBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEVBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:01:39 -0400
X-Greylist: delayed 489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Sep 2022 14:01:37 PDT
Received: from smtp.220.in.ua (smtp.220.in.ua [89.184.67.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C74656BA7;
        Mon,  5 Sep 2022 14:01:36 -0700 (PDT)
Received: from [192.168.202.100] (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id 906761A26550;
        Mon,  5 Sep 2022 23:53:47 +0300 (EEST)
Message-ID: <662e227f-b759-df28-8cbf-a2223a1df6b6@kaa.org.ua>
Date:   Mon, 5 Sep 2022 23:53:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/3] leds: el15203000: silent no spi_device_id warning
Content-Language: uk-UA
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220905152659.4152483-1-weiyongjun@huaweicloud.com>
 <20220905152659.4152483-2-weiyongjun@huaweicloud.com>
From:   Oleh Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <20220905152659.4152483-2-weiyongjun@huaweicloud.com>
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
> SPI driver leds_el15203000 has no spi_device_id for crane,el15203000
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/leds/leds-el15203000.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/leds/leds-el15203000.c b/drivers/leds/leds-el15203000.c
> index 7e7b617bcd56..e24b4399176e 100644
> --- a/drivers/leds/leds-el15203000.c
> +++ b/drivers/leds/leds-el15203000.c
> @@ -329,9 +329,16 @@ static const struct of_device_id el15203000_dt_ids[] = {
>   
>   MODULE_DEVICE_TABLE(of, el15203000_dt_ids);
>   
> +static const struct spi_device_id el15203000_spi_ids[] = {
> +	{ "el15203000" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, el15203000_spi_ids);
> +
>   static struct spi_driver el15203000_driver = {
>   	.probe		= el15203000_probe,
>   	.remove		= el15203000_remove,
> +	.id_table	= el15203000_spi_ids,
>   	.driver = {
>   		.name		= KBUILD_MODNAME,
>   		.of_match_table	= el15203000_dt_ids,

