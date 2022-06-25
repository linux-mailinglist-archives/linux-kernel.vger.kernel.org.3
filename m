Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F5555A784
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 08:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiFYGiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 02:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiFYGh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 02:37:58 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BA6CCE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 23:37:56 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 4zQToScCo6rrE4zQTo0f6d; Sat, 25 Jun 2022 08:37:53 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 25 Jun 2022 08:37:53 +0200
X-ME-IP: 90.11.190.129
Message-ID: <f2e89d3a-f6ad-6fdc-1bd1-eb38f5a8f569@wanadoo.fr>
Date:   Sat, 25 Jun 2022 08:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] usb: typec: ucsi: stm32g0: add support for stm32g0
 i2c controller
Content-Language: en-US
To:     fabrice.gasnier@foss.st.com
Cc:     alexandre.torgue@foss.st.com, amelie.delaunay@foss.st.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, robh+dt@kernel.org
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
 <20220624155413.399190-3-fabrice.gasnier@foss.st.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220624155413.399190-3-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/06/2022 à 17:54, Fabrice Gasnier a écrit :
> STM32G0 provides an integrated USB Type-C and power delivery interface.
> It can be programmed with a firmware to handle UCSI protocol over I2C
> interface. A GPIO is used as an interrupt line.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier-rj0Iel/JR4NBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/usb/typec/ucsi/Kconfig        |  10 ++
>   drivers/usb/typec/ucsi/Makefile       |   1 +
>   drivers/usb/typec/ucsi/ucsi_stm32g0.c | 218 ++++++++++++++++++++++++++
>   3 files changed, 229 insertions(+)
>   create mode 100644 drivers/usb/typec/ucsi/ucsi_stm32g0.c
> 

[...]

> +static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset, const void *val,
> +				    size_t len)
> +{
> +	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	struct i2c_client *client = g0->client;
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr	= client->addr,
> +			.flags  = 0,
> +		}
> +	};
> +	unsigned char *buf;
> +	int ret;
> +
> +	buf = kzalloc(len + 1, GFP_KERNEL);

Hi,

Nit: kmalloc() would be enough here, the whole buffer is written just a 
few lines after.

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf[0] = offset;
> +	memcpy(&buf[1], val, len);
> +	msg[0].len = len + 1;
> +	msg[0].buf = buf;
> +
> +	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	kfree(buf);
> +	if (ret != ARRAY_SIZE(msg)) {
> +		dev_err(g0->dev, "i2c write %02x, %02x error: %d\n", client->addr, buf[0], ret);

Use-after-free of buf.

> +
> +		return ret < 0 ? ret : -EIO;
> +	}
> +
> +	return 0;
> +}
> +

Just my 2c,
CJ

[...]
