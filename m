Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA54D50F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbiCJRxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiCJRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:53:21 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C118F21C;
        Thu, 10 Mar 2022 09:52:18 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id dr20so13702080ejc.6;
        Thu, 10 Mar 2022 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6WXp5qVD5RJpTEot5C084K06yGMaS2AEVin/2qPKdzk=;
        b=O/x17lahMsmYF73EZdvo9N5D4sKKiI0QOFvA7kVjKasMfoRMAIcHf5loJyU4MERara
         EiKkvVCV6TSIcbmgszzvLLhL5twQNPGyZec7fb5h4pNyfnpmG8h5jxEAC0Pc1ZwIe8/f
         BAF/6IrxKL6G56Oh6pbJOmipHA6QMS82aO4aI/NAUbwxVP0ZCPnIzp5M2OIpGksF7XJE
         +4wlNj4yXLSLKI/0rfgU6feqUMS9qoviY8khstt2sY5kmlxlWcZ2U3pOnlW5qNRlJS7p
         vXywJBju5msMPlLSiOQ4s6lU6XngApcf+/TExWwutEhyerP03wwhmb3JJl2Pz5orRhE2
         QJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6WXp5qVD5RJpTEot5C084K06yGMaS2AEVin/2qPKdzk=;
        b=ENe3Q6ByrftBrXGf2T3KZ6decwL96ddCYycFwlygsWXmtB718pDjYD+XpmHxwYYS1o
         WbBo+2cygVeenZkszKR1MC7OURTFIUCGIagXQtmeWwBJoDX3VcfVK4lD5p9WlaLJFhuW
         ROCB/joovT3CGkiDL0Vmx3Ce9RCZNMNLe8O8iuAdfPxcJvOg21+cHUu4NisBtdvRn+lR
         s/+/Ko+shpeBywK7KL58d7Ph7+4Y8RajwSCVm3JE8A6nwM+iC5f7qg4f1/BbO4Vji2oh
         7RC6BN2czIBYNKXn8deMdgZWDq65YmdfxBuGkfin/W315Vi6+QKoNqrr7z+4pa0TLUSq
         OUCw==
X-Gm-Message-State: AOAM531fdxLWyIGFtYCnJ0SjmlyzhZ4+PT6yQoGFDjdzJf/rP2jITA+o
        y1VSRe72pD+6V+ID7FCZEb4=
X-Google-Smtp-Source: ABdhPJwiHwGaW6QA66HwC9gez8ruNve1mh6cvXVUMIH0VEiDi1A8GZ4l3yaS+wgYOUkvxRLH7wWUtw==
X-Received: by 2002:a17:906:4a96:b0:6c5:5ea9:5366 with SMTP id x22-20020a1709064a9600b006c55ea95366mr5160528eju.473.1646934736657;
        Thu, 10 Mar 2022 09:52:16 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o10-20020aa7c7ca000000b00416c8defff0sm298885eds.61.2022.03.10.09.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 09:52:16 -0800 (PST)
Message-ID: <9295c92e-e054-8817-c96c-b33821643ce7@gmail.com>
Date:   Thu, 10 Mar 2022 18:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 11/18] crypto: rockhip: do not handle dma clock
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, john@metanate.com
References: <20220302211113.4003816-1-clabbe@baylibre.com>
 <20220302211113.4003816-12-clabbe@baylibre.com>
 <064626ad-129e-c7eb-5e08-12d93cffa993@gmail.com> <YioPGUFPOerQKak5@Red>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <YioPGUFPOerQKak5@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/22 15:45, LABBE Corentin wrote:
> Le Fri, Mar 04, 2022 at 04:01:58PM +0100, Johan Jonker a écrit :
>> Hi Corentin,
>>
>> Make your clock driver parsing portable.
>>
>> ===
>>     oneOf:
>>       - const: rockchip,rk3288-crypto
>>       - items:
>>           - enum:
>>               - rockchip,rk3328-crypto
>>           - const: rockchip,rk3288-crypto
>>
>> Compatible string must be SoC related!
>>
>> rk3288 was the first in line that had support, so we use that as fall
>> back string.
>>
>> ===
>>
>> Make binding fit for more SoC types.
>> Allow more clocks by using devm_clk_bulk_get_all.
> 
> Hello
> 
> Thanks for the hint of devm_clk_bulk_get_all, I will switch to it as it simplify clock handling.
> 
>> Drop reset-names requirement for devm_reset_control_array_get_exclusive.
>>
>> ===
>>
>> Use a patch order to prevent the scripts generate notifications.
> 

> which scripts ?

For Linux users:
./scripts/checkpatch.pl --strict <patch1> <patch2>

Device tree maintainer rob+dt:
A bot with unknown scripts.

> 
>>


- dts rk3288 clock removal

>> - dt-bindings conversion
>>
>> - add rk3328 compatible string in a separate patch
+ new clock names


>>
>> - your driver changes
>>
>> - dts patches
>>
>> A proposed maintainer must be able to submit patch series without errors. ;)
>>
>> ===
>>
>> When you remove a clock in a YAML conversion you must add a note to the
>> DT maintainer.
>>
>> ===
>>
>> Johan
>>
>> On 3/2/22 22:11, Corentin Labbe wrote:
>>> The DMA clock is handled by the DMA controller, so the crypto does not
>>> have to touch it.
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>>>  drivers/crypto/rockchip/rk3288_crypto.c | 16 +---------------
>>>  drivers/crypto/rockchip/rk3288_crypto.h |  1 -
>>>  2 files changed, 1 insertion(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
>>> index 94ef1283789f..645855d2651b 100644
>>> --- a/drivers/crypto/rockchip/rk3288_crypto.c
>>> +++ b/drivers/crypto/rockchip/rk3288_crypto.c
>>> @@ -40,15 +40,8 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
>>>  			__func__, __LINE__);
>>>  		goto err_hclk;
>>>  	}
>>> -	err = clk_prepare_enable(dev->dmaclk);
>>> -	if (err) {
>>> -		dev_err(dev->dev, "[%s:%d], Couldn't enable clock dmaclk\n",
>>> -			__func__, __LINE__);
>>> -		goto err_dmaclk;
>>> -	}
>>> +
>>>  	return err;
>>> -err_dmaclk:
>>> -	clk_disable_unprepare(dev->hclk);
>>>  err_hclk:
>>>  	clk_disable_unprepare(dev->aclk);
>>>  err_aclk:
>>> @@ -59,7 +52,6 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
>>>  
>>>  static void rk_crypto_disable_clk(struct rk_crypto_info *dev)
>>>  {
>>> -	clk_disable_unprepare(dev->dmaclk);
>>>  	clk_disable_unprepare(dev->hclk);
>>>  	clk_disable_unprepare(dev->aclk);
>>>  	clk_disable_unprepare(dev->sclk);
>>> @@ -199,12 +191,6 @@ static int rk_crypto_probe(struct platform_device *pdev)
>>>  		goto err_crypto;
>>>  	}
>>>  
>>
>>> -	crypto_info->dmaclk = devm_clk_get(&pdev->dev, "apb_pclk");
>>> -	if (IS_ERR(crypto_info->dmaclk)) {
>>> -		err = PTR_ERR(crypto_info->dmaclk);
>>> -		goto err_crypto;
>>> -	}
>>> -
>>
>> rk3288:
>>  		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
>> -			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
>> -		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
>> +			 <&cru SCLK_CRYPTO>;
>> +		clock-names = "aclk", "hclk", "sclk";
>>
>>
>> rk3328:
>> +		clocks = <&cru HCLK_CRYPTO_MST>, <&cru HCLK_CRYPTO_SLV>,
>> +			 <&cru SCLK_CRYPTO>;
>> +		clock-names = "aclk", "hclk", "sclk";
>>
>> The HCLK_CRYPTO_MST not is related to ACLK_CRYPTO.
>> You are reusing rk3288 names to not to change the driver.
>> Give it an other name.
> 
> You are right, I will change them.
> 
> 
>>
>> ===
>>

>> The sclk goes through a crypto_div_con.
>> Does that need a frequency set?
>> Or does that come from nowhere?
>>
>> From crypto_v1.c
>> 	priv->frequency = dev_read_u32_default(dev, "clock-frequency",
>> 					       CRYPTO_V1_DEFAULT_RATE);
>>
>> 	ret = clk_set_rate(&priv->sclk, priv->frequency);
>>
> 

> The problem is that I dont see any hints for this in TRM, and their rockchips source are inconsistent, they do this in uboot not in linux....

Rockchip RK3288TRM V1.2 Part2-20170321.pdf
page 1419

Make sure F crypto do not exceed 150M.

===

For rk3228/rk3328:
Rockchip RK3228TRM V0.1 20151016-Part3 Graphic and Multi-media.pdf
page 476

Make sure F crypto do not exceed 150M.

===

Rockchip RK3399TRM V1.1 Part3 20160728.pdf
page 781

Make sure F crypto do not exceed 200M.

===

They all have a limit.
Rockchip uses a default in there drivers and in there TRM tables.
Then stay consistant and use that too what is already set by the bootloader.
(till someone comes up with a better (yet unknown) approuch)

#define CRYPTO_V1_DEFAULT_RATE		100000000

===

Could you disclose your sclk frequency table from:

/sys/kernel/debug/clk/clk_summary

Does that fit within the limits?

> 
>> ===
>>
>> Could you make this portable?
>> Example:
>>
>> 	int i;
>>
>> 	priv->num_clks = devm_clk_bulk_get_all(dev, &priv->clks);
>> 	if (priv->num_clks < 1)
>> 		return -EINVAL;
>>
>> 	priv->sclk = NULL;
>> 	for (i = 0; i < priv->num_clks; i++) {
>> 		if (!strncmp(priv->clks[i].id, "sclk", 3)) {
>> 			priv->sclk = priv->clks[i].clk;
>> 			break;
>> 		}
>> 	}
>>
>> 	if (!priv->sclk) {
>> 		dev_err(dev, "no sclk found\n");
>> 		return -EINVAL;
>> 	}
>>
>> Also add optional "sclk1" clock for rk3399.
>> Use "sclk" and not "sclk0" to be backwards compatible.
>>
>> ===
>>
>> Also make the resets portable for rk3399.
>> Remove the requirement for "reset-names".
>>
>> Example:
>> 	priv->phy_rst = devm_reset_control_array_get_exclusive(dev);
>> 	if (IS_ERR(priv->phy_rst))
>> 		return dev_err_probe(dev, PTR_ERR(priv->phy_rst), "failed to get phy
>> reset\n");
>>
>>
>>
>>>  	crypto_info->irq = platform_get_irq(pdev, 0);
>>>  	if (crypto_info->irq < 0) {
>>>  		dev_err(&pdev->dev, "control Interrupt is not available.\n");
>>> diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
>>> index c741e97057dc..963fbfc4d14e 100644
>>> --- a/drivers/crypto/rockchip/rk3288_crypto.h
>>> +++ b/drivers/crypto/rockchip/rk3288_crypto.h
>>> @@ -191,7 +191,6 @@ struct rk_crypto_info {
>>
>>>  	struct clk			*aclk;
>>>  	struct clk			*hclk;
>>>  	struct clk			*sclk;
>>> -	struct clk			*dmaclk;
>>
>>
>> 	int num_clks;
>> 	struct clk_bulk_data *clks;
>> 	struct clk *sclk;
>> 	struct clk *sclk1;
>>
>>
>>>  	struct reset_control		*rst;
>>>  	void __iomem			*reg;
>>>  	int				irq;
> 
> 
> For handling rk3399, I have no hardware so I cannot do anything for it easily.
> I have asked on IRC for some tests, so let's see if it works.
> Anyway we can always add support for it later, the priority is to fix the driver breakage.

The problem with "later" is always that people "forget".
Now you have all people there attention, so get it right for
rk3228/rk3328 (and probably for rk3399).

Success!

Johan

> 
> Regards
