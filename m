Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A5C49FC25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349486AbiA1Ovc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiA1OvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:51:24 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2310C061714;
        Fri, 28 Jan 2022 06:51:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id A3E141F460DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643381483;
        bh=6wPdzXaH8f6GblGOZIXEb8xAztd6pZNs7b+ck+XJb6Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Pcq2GzngcDwmdv7f6o62VSZCrE4VV8uE6ax3TobmwwqsYX3yDyNcDwSfxKU5mjGKf
         QfXhP6yrGJF1yEBoeZjoNjNJdvRi4ky3ZyMzPCpcFYeiJg4kTM5KI5AT+XQwBwEtTb
         88tR5I73XIDB1C+jVWP+2X5s2qrQemZiPfhNCSKb1DhYoZYv5sCz/xogA4VOljLGR2
         NfH1L8Y/zDFQLlYWnCzPpE3CCQ+zCptrFu0XoR7q/qbjKYA26cpbom1rMrqClM8xL7
         XTZjO1dxANhGNl+heWpqjnNQf5sRz4ptLpvXsN+8aQ6hqd1ZHoIZESXpsnud5Jra72
         2/mEvuyDIhLog==
Message-ID: <61220daf-ff1e-0c5d-b89e-9325625417ae@collabora.com>
Date:   Fri, 28 Jan 2022 19:51:13 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: imx: imx8mq-mipi_csi2: Remove unneeded code
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <20220128133649.1393201-1-usama.anjum@collabora.com>
 <20220128135217.ncvjlffzpxxmqbjo@pengutronix.de>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220128135217.ncvjlffzpxxmqbjo@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 6:52 PM, Marc Kleine-Budde wrote:
> On 28.01.2022 18:36:49, Muhammad Usama Anjum wrote:
>> ret is constant in imx8mq_mipi_csi_pm_suspend(). This function cannot
>> return error. Remove the return variable. Simplify other functions which
>> are using this function.
>>
>> Fixes: f0c2ba1ed4ad ("media: imx: imx8mq-mipi_csi2: fix system resume")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  drivers/staging/media/imx/imx8mq-mipi-csi2.c | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
>> index 3b9fa75efac6b..c992b845e63d1 100644
>> --- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
>> +++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
> [...]
>>  static int imx8mq_mipi_csi_pm_resume(struct device *dev)
>> @@ -742,15 +739,12 @@ static int __maybe_unused imx8mq_mipi_csi_suspend(struct device *dev)
>>  {
>>  	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>>  	struct csi_state *state = mipi_sd_to_csi2_state(sd);
>> -	int ret;
>>  
>> -	ret = imx8mq_mipi_csi_pm_suspend(dev);
>> -	if (ret)
>> -		return ret;
>> +	imx8mq_mipi_csi_pm_suspend(dev);
>>  
>>  	state->state |= ST_SUSPENDED;
> 
> 
> what about this flag?
Now that no error is possible inside this function. The state is being
updated each time. This seems correct logically.

Thanks,
Usama
