Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF74B5223
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354609AbiBNNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:51:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354629AbiBNNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:50:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1749FB2;
        Mon, 14 Feb 2022 05:50:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4EC2D1F43191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644846643;
        bh=D1yJWGWIImkvAowJ8h80nIsI2GRf98oHfJsbzrHCL5g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eLg4rcGuTVLJAuon8acnkWwPvbOhy4FVYhIKInQOCvtyvTikzf5hUlnBvRFdAN8Hq
         FgIYU1Gv9y3Drl/bDFKTDtZ2VwJ0vsMAb0mUeLKIq8xUgLqoD2dXCKieLkARXz+VOJ
         Ks8qubUZszIdLBApWCiWCotADcPCPMlXKjGszPNeydLeBxCMqKOWuRugnEvuVuR09h
         UdbSVhAc6MXkkCRaF18xUmSktuzBNg5XZ2GVFtVpRMo+6ifYLTZxQcAXnH9km5eKvZ
         jBHFz5yJPLVS8Zue/MGlkkg6R4OEYkmEyLy1/u48A7oYluYVSo9VPHhrwPLIA6E1bV
         XynkDc/ZUQP8Q==
Message-ID: <bb79e52c-bf82-5966-1814-ba23f4b6dcf5@collabora.com>
Date:   Mon, 14 Feb 2022 14:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] pwm: pwm-mediatek: Simplify error handling with
 dev_err_probe()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20220214113038.79130-1-angelogioacchino.delregno@collabora.com>
 <20220214134850.aqmd7wjxjsjyuwz7@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220214134850.aqmd7wjxjsjyuwz7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/02/22 14:48, Uwe Kleine-König ha scritto:
> On Mon, Feb 14, 2022 at 12:30:37PM +0100, AngeloGioacchino Del Regno wrote:
>> Use dev_err_probe() to simplify handling errors in pwm_mediatek_probe().
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/pwm/pwm-mediatek.c | 30 +++++++++++-------------------
>>   1 file changed, 11 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
>> index 0d4dd80e9f07..c7d5ca09a684 100644
>> --- a/drivers/pwm/pwm-mediatek.c
>> +++ b/drivers/pwm/pwm-mediatek.c
>> @@ -227,18 +227,14 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   
>>   	pc->clk_top = devm_clk_get(&pdev->dev, "top");
>> -	if (IS_ERR(pc->clk_top)) {
>> -		dev_err(&pdev->dev, "clock: top fail: %ld\n",
>> -			PTR_ERR(pc->clk_top));
>> -		return PTR_ERR(pc->clk_top);
>> -	}
>> +	if (IS_ERR(pc->clk_top))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_top),
>> +				     "clock: top failed\n");
> 
> The change looks straight forward. I wonder if we should improve the
> error message on this occasion. E.g.
> 
> 	"Failed to get top clock\n"
> 

I can push another commit on top that improves the messages, if desired!

Regards,
Angelo

> ? Ditto below.
> 
> Best regards
> Uwe
> 


