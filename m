Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2386A4D9867
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbiCOKKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346950AbiCOKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:09:59 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB03BF96;
        Tue, 15 Mar 2022 03:08:46 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22F4JcYN013011;
        Tue, 15 Mar 2022 11:08:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=wZLup1066BSl1Hsk/ZF1vSKE25M+uNQ85H+mRhWlPfw=;
 b=OD5oGWIRM87iRwhfrsGXbAd2cYWCeLngme7W2/UIhqF7KKBQ3DPk/Kw8L3KNdW/QCcql
 /NOyP7JB1BfjqX4fjS1mUVQu5mxmDWBoupuJsBPUZreIAkmToTLYKHjqWiiVcKElx15Y
 78Jug9xNwPIHY5krgWANZqQq44h6JHMoFtHKPvT7tVrjZY8QYYM05B46p+fstSh5jxa9
 RTmmFy/JNFNC7X+cib1CuReB8CFCdziF3ASgRHu+FCQODmN/krqHs9xLA73ajl/9m7+9
 vximtFti7RGxw5AQ5ieSkulQ6JYCOUDdlRBG9pmmiqjKmv7ZFYAQZQ3MXzKVvQb/Cqlk 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3et63h5krf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 11:08:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EFC6010002A;
        Tue, 15 Mar 2022 11:07:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E07B72171CB;
        Tue, 15 Mar 2022 11:07:42 +0100 (CET)
Received: from [10.201.21.172] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 15 Mar
 2022 11:07:42 +0100
Message-ID: <c6972c78-a4eb-02ec-7b35-e473b66df821@foss.st.com>
Date:   Tue, 15 Mar 2022 11:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mmc: mmci: manage MMC_PM_KEEP_POWER per variant config
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>
References: <20220314095225.53563-1-yann.gautier@foss.st.com>
 <20220314125554.190574-1-yann.gautier@foss.st.com>
 <CAPDyKFruN9Xwk4uqFumwBdcn4SjKQcSQVBbALa3kVxY4mVzOnQ@mail.gmail.com>
 <9e4fbf6a-1309-3aee-fcb0-be7c2c683892@foss.st.com>
 <CAPDyKFq2Du1UWpvRFpVF_qL65SP0DfEV872U9Xe-9i7xKxXhqg@mail.gmail.com>
 <ce29e53a-59ff-000a-6b88-0b7ae538c515@foss.st.com>
 <CAPDyKFq29+nwxXkV-Fyn91WD62-6REk+5UryVAK6XC4xKhcsfg@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CAPDyKFq29+nwxXkV-Fyn91WD62-6REk+5UryVAK6XC4xKhcsfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_14,2022-03-14_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 10:07, Ulf Hansson wrote:
> On Mon, 14 Mar 2022 at 17:52, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>
>> On 3/14/22 17:18, Ulf Hansson wrote:
>>> On Mon, 14 Mar 2022 at 15:34, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>>>
>>>> On 3/14/22 14:03, Ulf Hansson wrote:
>>>>> On Mon, 14 Mar 2022 at 13:56, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>>>>>
>>>>>> Add a disable_keep_power field in variant_data struct. The
>>>>>> MMC_PM_KEEP_POWER flag will be enabled if disable_keep_power is not set.
>>>>>> It is only set to true for stm32_sdmmc variants.
>>>>>>
>>>>>> The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
>>>>>> It doesn't correctly support low power on this board. The Wifi chip
>>>>>> awaits an always-on regulator, but it was connected to v3v3 which is off
>>>>>> in low-power sequence. MMC_PM_KEEP_POWER should then be disabled.
>>>>>
>>>>> Just to make sure I get this correct.
>>>>>
>>>>> Why can't the regulator stay on during system suspend? The point is,
>>>>> we don't need an always on regulator to cope with this.
>>>>>
>>>>> Kind regards
>>>>> Uffe
>>>>
>>>> Hi Ulf,
>>>>
>>>> This v3v3 regulator powers most of the devices on this board. So we need
>>>> to switch it off to gain power in suspend mode.
>>>
>>> I see. Thanks for sharing that information.
>>>
>>> The MMC_PM_KEEP_POWER flag is there to describe what is supported by
>>> the platform/host. It doesn't mean that the card *must* stay powered
>>> on during system suspend. Instead that depends on whether system
>>> wakeup for the SDIO/WiFi is supported too - and if that is enabled by
>>> userspace. If not, the regulator will be turned off for the SDIO card
>>> during system suspend.
>>>
>>> Assuming the regulator is implemented as a proper regulator and can
>>> remain on during system suspend, the right thing would be to keep the
>>> MMC_PM_KEEP_POWER flag around.
>>>
>>> Kind regards
>>> Uffe
>>>
>>
>> OK, but in the wifi driver we use on this platform (brcmfmac), the
>> suspend/resume functions (brcmf_ops_sdio_suspend/brcmf_ops_sdio_resume)
>> use the flag to check regu was off, and then call probe function during
>> resume, to re-init Wifi chip and reload its firmware.
> 
> I had a closer look at the brcmfmac driver, thanks for the pointers.
> 
> In my opinion, I think we should change the brcmfmac driver, so it
> decides to power off the SDIO card, unless the WiFi chip is configured
> to serve us with system wakeups.
> 
> I can send a patch for brcmfmac that we can try, unless you want to
> send it yourself?
> 

Hi Ulf,
If you already have an idea of the patch in the brcmfmac driver, can you 
propose something?
We'll be able to test it at our side.

Thanks,
Yann

>>
>>
>> Best regards,
>> Yann
> 
> Kind regards
> Uffe
> >>
>>>>
>>>>
>>>> Yann
>>>>
>>>>>
>>>>>>
>>>>>> The flag can still be enabled through DT property:
>>>>>> keep-power-in-suspend.
>>>>>>
>>>>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>>>>> ---
>>>>>> Update in v2:
>>>>>> Reword commit message to better explain the issue.
>>>>>>
>>>>>> Resend the patch alone. It was previoulsy in a series [1] for which the
>>>>>> other patches will be reworked.
>>>>>>
>>>>>> [1] https://lore.kernel.org/lkml/20220304135134.47827-1-yann.gautier@foss.st.com/
>>>>>>
>>>>>>     drivers/mmc/host/mmci.c | 5 ++++-
>>>>>>     drivers/mmc/host/mmci.h | 1 +
>>>>>>     2 files changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>>>>> index 45b8608c935c..0e2f2f5d6a52 100644
>>>>>> --- a/drivers/mmc/host/mmci.c
>>>>>> +++ b/drivers/mmc/host/mmci.c
>>>>>> @@ -274,6 +274,7 @@ static struct variant_data variant_stm32_sdmmc = {
>>>>>>            .busy_detect            = true,
>>>>>>            .busy_detect_flag       = MCI_STM32_BUSYD0,
>>>>>>            .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
>>>>>> +       .disable_keep_power     = true,
>>>>>>            .init                   = sdmmc_variant_init,
>>>>>>     };
>>>>>>
>>>>>> @@ -301,6 +302,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
>>>>>>            .busy_detect            = true,
>>>>>>            .busy_detect_flag       = MCI_STM32_BUSYD0,
>>>>>>            .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
>>>>>> +       .disable_keep_power     = true,
>>>>>>            .init                   = sdmmc_variant_init,
>>>>>>     };
>>>>>>
>>>>>> @@ -2172,7 +2174,8 @@ static int mmci_probe(struct amba_device *dev,
>>>>>>            host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
>>>>>>
>>>>>>            /* We support these PM capabilities. */
>>>>>> -       mmc->pm_caps |= MMC_PM_KEEP_POWER;
>>>>>> +       if (!variant->disable_keep_power)
>>>>>> +               mmc->pm_caps |= MMC_PM_KEEP_POWER;
>>>>>>
>>>>>>            /*
>>>>>>             * We can do SGIO
>>>>>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>>>>>> index e1a9b96a3396..2cad1ef9766a 100644
>>>>>> --- a/drivers/mmc/host/mmci.h
>>>>>> +++ b/drivers/mmc/host/mmci.h
>>>>>> @@ -361,6 +361,7 @@ struct variant_data {
>>>>>>            u32                     opendrain;
>>>>>>            u8                      dma_lli:1;
>>>>>>            u32                     stm32_idmabsize_mask;
>>>>>> +       u8                      disable_keep_power:1;
>>>>>>            void (*init)(struct mmci_host *host);
>>>>>>     };
>>>>>>
>>>>>> --
>>>>>> 2.25.1
>>>>>>
>>>>
>>

