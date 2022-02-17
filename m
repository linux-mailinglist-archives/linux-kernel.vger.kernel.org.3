Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903334B9E48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiBQLDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:03:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbiBQLDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:03:24 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638612B3579
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:00:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so8275978wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e+JsVIdNvQlf4UWykFf5AIi0gPc4LX18FWl4ZaqpWts=;
        b=T9TJc4T59W3hiOUSJVoF9vBUetFsMyja5FUnfSOVHAR/We+JTlpvvPYU6CgGfSSfVO
         Fa5dQGH0C9Ib3VltN5Yl2wKwtcudlUE7/jUiSCYfMNgqii3uj00ymDnFqZEcYemVZ+lm
         YIH+bUxJy0wqsfVf6Nf5pqkymMa0QZjapdbRCidqXd22hky1V72duSURTuQkEDx4AyyL
         JT+GppffQh3Asi+0yY7tEk+E30TI+Pw2JD7McG9EQyCRJyHXY1ZFbVcnckz+PawRKFoJ
         RIDHfJ+WQfVIHTfmwkbvhUb2Oi/e95JyN38wdp8wvuvkNg9uKdxrDVrVLe4r/jyWHzdW
         3EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e+JsVIdNvQlf4UWykFf5AIi0gPc4LX18FWl4ZaqpWts=;
        b=8A5ABJooai6Dk/ylFlbjtiGgc7XFX5VoXg2Z372uKspcT6DnzDIjloZCOWmZAMLdkj
         6d8R5yhdph784WG98M2xiNHxmbagnxvJ+3LHgSPMpWVqL69aFED8ykP36DVbTr23zzr8
         fRh/CORwEO2XM3wsFTjpXKcUOy28ujhClZe/1+8udrkTfvzi8M/vOeiyp13EjryNpQ9I
         svtLq84vDqitbqh2fncJyYrzJpVQGBtkLk+YavEOm6fbulrhyQdW4Mtr6IoZyfhUv1St
         nkyhpyHYokP/7PoAqDKCy0S5TuY3OqiR9loFP5jghcz4stCLIo9lqZKlJH37f6qpS8M8
         sa6g==
X-Gm-Message-State: AOAM531keEMP18Uqmfv3rjj+HM6e/P7HDLMx6NIFbfYv9RSs5ZtVe4IY
        uapTEe+uSkSElxXbMxRhyyW97Q==
X-Google-Smtp-Source: ABdhPJyMV/QoPazDJt55rGaaRBQnwi7tDPAel46/q7DzmnJQb+mE7mYy9oKetYZ4DvqseVwQLV+AIw==
X-Received: by 2002:adf:80a4:0:b0:1e6:db9f:a8c4 with SMTP id 33-20020adf80a4000000b001e6db9fa8c4mr1831392wrl.345.1645095626387;
        Thu, 17 Feb 2022 03:00:26 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id q2sm37046070wrw.14.2022.02.17.03.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 03:00:25 -0800 (PST)
Message-ID: <8ae6faa4-a46e-bb72-799c-b4a04513b3e4@linaro.org>
Date:   Thu, 17 Feb 2022 11:00:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] mtd: core: Fix a conflict between MTD and NVMEM on
 wp-gpios property
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Christophe Kerello <christophe.kerello@foss.st.com>,
        Pratyush Yadav <p.yadav@ti.com>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, chenshumin86@sina.com,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Khouloud Touil <ktouil@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
 <20220131095755.8981-5-christophe.kerello@foss.st.com>
 <20220131144309.0ffe7cc8@xps13> <20220201104727.7xvcyexf3yucegcb@ti.com>
 <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
 <20220202115327.53oqg5n7tx6b6q7u@ti.com>
 <f6687807-607c-f672-2394-ad463735d597@foss.st.com>
 <d1000482-5385-c6f1-d10e-e5396218e0ea@linaro.org>
 <20220217094819.2548a25e@xps13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220217094819.2548a25e@xps13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/02/2022 08:48, Miquel Raynal wrote:
> Hi Srinivas,
> 
> srinivas.kandagatla@linaro.org wrote on Wed, 16 Feb 2022 09:24:29 +0000:
> 
>> On 16/02/2022 08:46, Christophe Kerello wrote:
>>> Hi Miquel, Pratyush, Srinivas,
>>>
>>> On 2/2/22 12:53, Pratyush Yadav wrote:
>>>> + Khouloud, Linus, Bartosz
>>>>
>>>> On 02/02/22 11:44AM, Christophe Kerello wrote:
>>>>> Hi,
>>>>>
>>>>> On 2/1/22 11:47, Pratyush Yadav wrote:
>>>>>> On 31/01/22 02:43PM, Miquel Raynal wrote:
>>>>>>> Hi Vignesh, Tudory, Pratyush,
>>>>>>>
>>>>>>> + Tudor and Pratyush
>>>>>>>
>>>>>>> christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55 >>>>> +0100:
>>>>>>>   
>>>>>>>> Wp-gpios property can be used on NVMEM nodes and the same property >>>>>> can
>>>>>>>> be also used on MTD NAND nodes. In case of the wp-gpios property is
>>>>>>>> defined at NAND level node, the GPIO management is done at NAND >>>>>> driver
>>>>>>>> level. Write protect is disabled when the driver is probed or resumed
>>>>>>>> and is enabled when the driver is released or suspended.
>>>>>>>>
>>>>>>>> When no partitions are defined in the NAND DT node, then the NAND >>>>>> DT node
>>>>>>>> will be passed to NVMEM framework. If wp-gpios property is defined in
>>>>>>>> this node, the GPIO resource is taken twice and the NAND controller
>>>>>>>> driver fails to probe.
>>>>>>>>
>>>>>>>> A new Boolean flag named skip_wp_gpio has been added in nvmem_config.
>>>>>>>> In case skip_wp_gpio is set, it means that the GPIO is handled by the
>>>>>>>> provider. Lets set this flag in MTD layer to avoid the conflict on
>>>>>>>> wp_gpios property.
>>>>>>>>
>>>>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>>>>>>>> ---
>>>>>>>>     drivers/mtd/mtdcore.c | 2 ++
>>>>>>>>     1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>>>>>>>> index 70f492dce158..e6d251594def 100644
>>>>>>>> --- a/drivers/mtd/mtdcore.c
>>>>>>>> +++ b/drivers/mtd/mtdcore.c
>>>>>>>> @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>>>>>>>>         config.stride = 1;
>>>>>>>>         config.read_only = true;
>>>>>>>>         config.root_only = true;
>>>>>>>> +    config.skip_wp_gpio = true;
>>>>>>>>         config.no_of_node = !of_device_is_compatible(node, >>>>>> "nvmem-cells");
>>>>>>>>         config.priv = mtd;
>>>>>>>> @@ -833,6 +834,7 @@ static struct nvmem_device >>>>>> *mtd_otp_nvmem_register(struct mtd_info *mtd,
>>>>>>>>         config.owner = THIS_MODULE;
>>>>>>>>         config.type = NVMEM_TYPE_OTP;
>>>>>>>>         config.root_only = true;
>>>>>>>> +    config.skip_wp_gpio = true;
>>>>>>>>         config.reg_read = reg_read;
>>>>>>>>         config.size = size;
>>>>>>>>         config.of_node = np;
>>>>>>>
>>>>>>> TLDR: There is a conflict between MTD and NVMEM, who should handle the
>>>>>>> WP pin when there is one? At least for raw NAND devices, I don't want
>>>>>>> the NVMEM core to handle the wp pin. So we've introduced this
>>>>>>> skip_wp_gpio nvmem config option. But there are two places where this
>>>>>>> boolean can be set and one of these is for otp regions (see above). In
>>>>>>> this case, I don't know if it is safe or if CFI/SPI-NOR rely on the
>>>>>>> nvmem protection. Please tell us if you think this is fine for you.
>>>>>>
>>>>>> Why does NVMEM touch hardware write protection in the first place? The
>>>>>> purpose of the framework is to provide a way to retrieve config stored
>>>>>> in memory. It has no business dealing with details of the chip like the
>>>>>> WP line. That should be MTD's job (which it should delegate to SPI NOR,
>>>>>> SPI NAND, etc.). If you want to write protect a cell then do it in
>>>>>> software. I don't see why NVMEM should be dealing with hardware >>>> directly
>>>>>> at all.
>>>>>>
>>>>>> That is my mental model of how things _should_ work. I have not spent
>>>>>> much time digging into how things actually work currently.
>>>>>>   
>>>>>
>>>>> Wp-gpios property management was added in MVMEM framework in January >>> 2020 =>
>>>>> sha1: 2a127da461a9d8d97782d6e82b227041393eb4d2
>>>>> "
>>>>>       nvmem: add support for the write-protect pin
>>>>>
>>>>>       The write-protect pin handling looks like a standard property that
>>>>>       could benefit other users if available in the core nvmem framework.
>>>>>
>>>>>       Instead of modifying all the memory drivers to check this pin, make
>>>>>       the NVMEM subsystem check if the write-protect GPIO being passed
>>>>>       through the nvmem_config or defined in the device tree and pull it
>>>>>       low whenever writing to the memory.
>>>>> "
>>>>>
>>>>> And this modification was done for EEPROMs flashes => sha1:
>>>>> 1c89074bf85068d1b86f2e0f0c2110fdd9b83c9f
>>>>> "
>>>>>       eeprom: at24: remove the write-protect pin support
>>>>>
>>>>>       NVMEM framework is an interface for the at24 EEPROMs as well as for
>>>>>       other drivers, instead of passing the wp-gpios over the different
>>>>>       drivers each time, it would be better to pass it over the NVMEM
>>>>>       subsystem once and for all.
>>>>>
>>>>>       Removing the support for the write-protect pin after adding it to
>>>>>       the NVMEM subsystem.
>>>>> "
>>>>>
>>>>> Current NVMEM framework implementation toggles the WP GPIO when >>> reg_write
>>>>> nvmem_config API is defined. In case of MTD framework, reg_write is not
>>>>> defined in nvmem_config.
>>>>
>>>> Thanks for digging these up. I think this was the wrong decision to
>>>> make. NVMEM should just provide the APIs for handling read/write, and
>>>> leave the rest to the drivers.
>>>>
>>>> It might be convenient for some drivers to put the WP GPIO handling to
>>>> NVMEM core but I just don't think it is the job of the framework to deal
>>>> with this, and it just does not know enough about the device to deal
>>>> with correctly and completely anyway. For example, wp-gpio is only one
>>>> of the ways to write protect a chip. SPI NOR flashes have a WP# pin that
>>>> is often toggled via the SPI controller. There could also be registers
>>>> that do the write protection.
>>>>
>>>> One would have to make strong justifications for making nvmem directly
>>>> deal with hardware level details to convince me it is a good idea. IMHO
>>>> if AT24 EEPROM is the only driver relying on this as of now then we
>>>> should just revert the patches and not have to deal with the
>>>> skip_wp_gpio hackery.
>>>>   
>>>
>>> Based on the  bindings documentation, AT24 EEPROM driver is not the only
>>> driver relying on this implementation. At least, AT25 EEPROM driver will
>>> have to be modified to handle the Write Protect management, and there is
>>> probably others drivers relying on this implementation.
>>>
>>> So, should we keep the legacy and apply the proposal patch to fix this
>>> conflict (I can send a V3 with a fixes tag on patch 3 and 4 as
>>> recommended by Miquel)?
>>> Or should we revert the Write Protect management in NVMEM framework
>>> but in this case I will not be able to handle such modifications (I am
>>> not able to test those drivers).
>>
>> Firstly sorry for such a long delay to reply this thread as I was in travel.
>>
>> I agree with comments from Pratyush but I see no harm in handling simple usecases of write-protect gpio in nvmem core. In fact wp-gpios and read-only are part of nvmem provider bindings.
>>
>> But usecases like the ones described in this patch series which do not want nvmem core to deal with this pin should set this new flag. I think this is a balanced choice.
>>
>> reverting the wp-gpio patch is going to break other providers that are using this bindings.
> 
> I am always puzzled when the community deeply cares about non-mainline
> drivers.
> 
> On one side I can understand that creating a 'grab-the-wp-line'
> flag would immediately break all external users but this is, as
> reported by Pratyush, the more logical approach IMHO. However we might
> possibly miss situations where the flag is necessary and break these
> devices.
> 
> Otherwise the 'ignore-wp' flag is more conservative, it does not

ingore-wp seems to be more sensible flag than skip_wp_gpio flag.


> break the existing users but would just address the MTD case for now, we
> might have other in-tree subsystem that are affected.
> 
> I'm fine either way TBH :-) I would just like this patchset to go in

Am okay either way too, It is just that ingore-wp seems a balanced 
choice in the current situation :-).

> through the next merge window.
Sure.

I can Ack nvmem patch if you wish to carry it via mtd tree.

or

nvmem patches go via Greg's char-misc tree. I can take 4/4 if you ack it 
once V3 is sent


--srini
> 
> Thanks,
> Miquèl
