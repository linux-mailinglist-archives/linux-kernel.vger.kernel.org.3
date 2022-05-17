Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050E4529E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbiEQJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiEQJeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:34:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E43A5DC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:34:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D2C471F41931
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652780048;
        bh=JjX9Dpbd4y1EXZipRCq/V3m9lUaqIH2abh5TZEersWk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Tj/Q8V7mKAB5+fGOWGQCHAnVuvw8P1FBI9Ra5pfptpnWws0QqJ91j7TQKAvKE7i48
         uorjFjEd75UwKFbJabdDiCtyobnix20H2s95vsJXIL1TIdlbCIsdImqDtlk429FZKV
         /CQBrknPD6Gk2U8SEL1MbWr+6VD1HNs/Y4JqXX7nul9z8pao1hjseT7jNdtHXSxq2O
         5eclHFhAX7a61k32AJKv3bXAW7ChaXkOMaR2nM08wrG2h4ITtYp+NBs95PfykSEAhD
         DpIWEjPIjtyheC7kRdyHOkBMr7M773aRCObe6ysI8eXl5XD9s4+nEkLPqOG7y9NZUi
         jE3CwplldaasA==
Message-ID: <03ac9b18-cb5d-5ff6-d220-f2f4062cea7e@collabora.com>
Date:   Tue, 17 May 2022 11:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 3/5] soc: mediatek: pwrap: Move and check return value
 of platform_get_irq()
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
 <20220516124659.69484-4-angelogioacchino.delregno@collabora.com>
 <ad736290-2e01-f867-d2ec-867a4385005a@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ad736290-2e01-f867-d2ec-867a4385005a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/22 11:18, Matthias Brugger ha scritto:
> 
> 
> On 16/05/2022 14:46, AngeloGioacchino Del Regno wrote:
>> Move the call to platform_get_irq() earlier in the probe function
>> and check for its return value: if no interrupt is specified, it
>> wouldn't make sense to try to call devm_request_irq() so, in that
>> case, we can simply return early.
>>
>> Moving the platform_get_irq() call also makes it possible to use
>> one less goto, as clocks aren't required at that stage.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> ---
>>   drivers/soc/mediatek/mtk-pmic-wrap.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c 
>> b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> index 852514366f1f..332cbcabc299 100644
>> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> @@ -2204,6 +2204,10 @@ static int pwrap_probe(struct platform_device *pdev)
>>       if (!wrp)
>>           return -ENOMEM;
>> +    irq = platform_get_irq(pdev, 0);
>> +    if (irq < 0)
>> +        return irq;
>> +
>>       platform_set_drvdata(pdev, wrp);
>>       wrp->master = of_device_get_match_data(&pdev->dev);
>> @@ -2316,7 +2320,6 @@ static int pwrap_probe(struct platform_device *pdev)
>>       if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
>>           pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>> -    irq = platform_get_irq(pdev, 0);
> 
> For better readability of the code I'd prefer to keep platform_get_irq next to 
> devm_request_irq. I understand that you did this change so that you don't have to code
> if (irq < 0) {
>      ret = irq;
>      goto err_out2;
> }
> 
> Or do I miss something?
> 

That's for the sake of reducing gotos in the code... but there's a bigger
picture that I haven't explained in this commit and that will come later
because I currently don't have the necessary time to perform a "decent"
testing.

As I was explaining - the bigger pictures implies adding a new function for
clock teardown, that we will add as a devm action:

devm_add_action_or_reset(&pdev->dev, pwrap_clk_disable_unprepare, wrp)

...so that we will be able to remove *all* gotos from the probe function.

Sounds good?

Cheers,
Angelo
