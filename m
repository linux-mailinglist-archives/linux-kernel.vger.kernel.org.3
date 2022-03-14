Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331EE4D850F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiCNMen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241682AbiCNM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:27:19 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B40C46152;
        Mon, 14 Mar 2022 05:21:40 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22ECKJ1M026169;
        Mon, 14 Mar 2022 13:20:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=kW1aXwzAxV2OLtkXdpyvfaQAMdSGkHxK0NAJMN1QqM8=;
 b=IgWAUET0aS/wdTiEr7ToHsOaL7jJizPwf2lECqC+0NcoIhqCXATZpGgN+C/iyAGdWRYY
 3WyWDAXs04JUbNOKi8kMct7IU6+Yydwrnxkms3ik+mZftGwrRtn4rJ4IYcsOu0ybfXYu
 gT+yVnPoy8mkwnjUOd9zkUzOw/NN8XmRdqdOaAvYIZeyuGABV7EQIM7xntDRQaCS7zL6
 YdzlUDY74mVENTxJX/58ZWHEmXkGy+RSJtimqjLws4QbhwWs07fShNN5Ds+KGlRWhu1o
 5dkn/uaDggvGxwhgi6+knfbNx9ea70oR8V5Ems4S5kFYENAYonVCzp66l3uPRAPZDY/3 Aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3et5mg801y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 13:20:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1364C100048;
        Mon, 14 Mar 2022 13:20:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A43721E678;
        Mon, 14 Mar 2022 13:20:34 +0100 (CET)
Received: from [10.201.21.172] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 14 Mar
 2022 13:20:33 +0100
Message-ID: <cfeeaa0e-7d52-9267-d46f-62eb91363b60@foss.st.com>
Date:   Mon, 14 Mar 2022 13:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND] mmc: mmci: manage MMC_PM_KEEP_POWER per variant
 config
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
        Grzegorz Szymaszek <gszymaszek@short.pl>
References: <20220314095225.53563-1-yann.gautier@foss.st.com>
 <CAPDyKFqObiC2fwZJ_0JArbVhnFZHV6bA0XJg0diwPgmRx1Bntg@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CAPDyKFqObiC2fwZJ_0JArbVhnFZHV6bA0XJg0diwPgmRx1Bntg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_04,2022-03-14_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 12:17, Ulf Hansson wrote:
> On Mon, 14 Mar 2022 at 10:53, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>
>> Add a disable_keep_power field in variant_data struct. The
>> MMC_PM_KEEP_POWER flag will be enabled if disable_keep_power is not set.
>> It is only set to true for stm32_sdmmc variants.
>>
>> The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
>> It doesn't correctly support low power, and we need to unbind the wifi
>> driver before a suspend sequence. But the wifi chip firmware is then
>> lost, and the communication with SDIO fails if MMC_PM_KEEP_POWER is
>> enabled.
> 
> So the platform supports to maintain the power for the embedded wifi
> chip during system suspend, but the SDIO func driver (for the WiFi
> chip) doesn't implement its part correctly. Did I get that right?
> 
> In that case, it sounds to me like we should try to fix the support
> for power management in the SDIO func driver instead, no?
> I am happy to help with guidance/review if that is needed. What SDIO
> func driver is this about?
> 
> Kind regards
> Uffe
> 

Hi Ulf,

I blindly pushed the patch without rechecking it.
I rephrased it in our downstream to better explain the issue:

The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
It doesn't correctly support low power on this board. The Wifi chip
awaits an always-on regulator, but it was connected to v3v3 which is off
in low-power sequence. MMC_PM_KEEP_POWER should then be disabled.

If it's OK for you, I'll resend the patch with the updated commit message.

Best regards,
Yann

>> The flag can still be enabled through DT property: keep-power-in-suspend.
>>
>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>> ---
>> Resend the patch alone. It was previoulsy in a series [1] for which the
>> other patches will be reworked.
>>
>> [1] https://lore.kernel.org/lkml/20220304135134.47827-1-yann.gautier@foss.st.com/
>>
>>   drivers/mmc/host/mmci.c | 5 ++++-
>>   drivers/mmc/host/mmci.h | 1 +
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 45b8608c935c..0e2f2f5d6a52 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -274,6 +274,7 @@ static struct variant_data variant_stm32_sdmmc = {
>>          .busy_detect            = true,
>>          .busy_detect_flag       = MCI_STM32_BUSYD0,
>>          .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
>> +       .disable_keep_power     = true,
>>          .init                   = sdmmc_variant_init,
>>   };
>>
>> @@ -301,6 +302,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
>>          .busy_detect            = true,
>>          .busy_detect_flag       = MCI_STM32_BUSYD0,
>>          .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
>> +       .disable_keep_power     = true,
>>          .init                   = sdmmc_variant_init,
>>   };
>>
>> @@ -2172,7 +2174,8 @@ static int mmci_probe(struct amba_device *dev,
>>          host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
>>
>>          /* We support these PM capabilities. */
>> -       mmc->pm_caps |= MMC_PM_KEEP_POWER;
>> +       if (!variant->disable_keep_power)
>> +               mmc->pm_caps |= MMC_PM_KEEP_POWER;
>>
>>          /*
>>           * We can do SGIO
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index e1a9b96a3396..2cad1ef9766a 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -361,6 +361,7 @@ struct variant_data {
>>          u32                     opendrain;
>>          u8                      dma_lli:1;
>>          u32                     stm32_idmabsize_mask;
>> +       u8                      disable_keep_power:1;
>>          void (*init)(struct mmci_host *host);
>>   };
>>
>> --
>> 2.25.1
>>

