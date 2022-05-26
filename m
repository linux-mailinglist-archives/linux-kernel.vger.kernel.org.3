Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7C534EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiEZL6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiEZL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:58:12 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F7D0293;
        Thu, 26 May 2022 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653566291; x=1685102291;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4zlyYG5DLtUMGECwCuQjiUZwjXRI66JAXV7vKwRun7o=;
  b=vuaUNiO4ZZ2qxFpSh32QLiOefzN41Mma7/05MZjNSt0VEp0e+iYrXoh8
   rGdiB/AERxkk0D532p5RzHth4TaKWh+A4t88xC95X45bMaJi/GUm9M6c4
   sQl/A9qGjzULp5XtS6I2svJpm8rNsV3mOz7wVn+EAjloe1Hdy39+ZdRqn
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 May 2022 04:58:10 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 04:58:10 -0700
Received: from [10.216.50.195] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 26 May
 2022 04:58:05 -0700
Subject: Re: [PATCH V1] mmc: sdhci-msm: Add wakeup functionality support for
 sdio cards
To:     "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "t.scherer@eckelmann.de" <t.scherer@eckelmann.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "sensor1010@163.com" <sensor1010@163.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "hns@goldelico.com" <hns@goldelico.com>,
        "uic_kamasali@quicinc.com" <uic_kamasali@quicinc.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'quic_spathi@quicinc.com'" <quic_spathi@quicinc.com>
References: <1650964225-6705-1-git-send-email-quic_spathi@quicinc.com>
 <CAPDyKFoq2zJwTT6JrnvEjh0VvJLkt6PKhk9KhwVjTF0Eq3jOYw@mail.gmail.com>
 <MWHPR0201MB34661086E86F830C6831CC99E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
Message-ID: <1ba7780a-f560-1e10-226a-fcda785f7e89@quicinc.com>
Date:   Thu, 26 May 2022 17:28:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <MWHPR0201MB34661086E86F830C6831CC99E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ulf,

Thanks for the review.
Please find comments inline.

Thanks,
Sarthak

On 5/24/2022 5:26 PM, Kamasali Satyanarayan (Consultant) (QUIC) wrote:
> Hi,
> These patches will be further taken by Sarthak.
>
> Thanks,
> Satya
>
> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Wednesday, April 27, 2022 4:06 AM
> To: quic_spathi <quic_spathi@quicinc.com>
> Cc: u.kleine-koenig@pengutronix.de; YehezkelShB@gmail.com; rmk+kernel@armlinux.org.uk; t.scherer@eckelmann.de; s.shtylyov@omp.ru; sensor1010@163.com; sartgarg@codeaurora.org; hns@goldelico.com; uic_kamasali@quicinc.com; tiantao6@hisilicon.com; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Kamasali Satyanarayan (Consultant) (QUIC) <quic_kamasali@quicinc.com>
> Subject: Re: [PATCH V1] mmc: sdhci-msm: Add wakeup functionality support for sdio cards
>
> On Tue, 26 Apr 2022 at 11:10, Srinivasarao Pathipati <quic_spathi@quicinc.com> wrote:
>> From: Sarthak Garg <sartgarg@codeaurora.org>
>>
>> This adds external GPIO wakeup support to sdhci-msm driver for sdio
>> cards.
> There is not a single line changed in the sdhci-msm driver, so I am not sure what this is intended to fix.
>
> I assume this is a downstream patch you want to upstream, which is a good thing that we all appreciate. However, before just posting a patch from downstream code, please have a look at the commit message and let it explain what and why you want to change things.
>
> I am deferring to review this, until you post a version with a proper commit message. Sorry.
>
> Kind regards
> Uffe

This is our internal feature where our SDIO card makes use of external 
tlmm pin to wakeup the host from system suspend.
It has approx 200 lines of code changes in the sdhci-msm.c file which 
will create further confusions. For that feature we just need to 
initialize sdio card as a wakeup source and enable wakeup capability for 
that.
Will post V2 patch for that .. please help review.

>
>> Also enables clk gating only in system Suspend/Resume for SDIO card.
>>
>> Also add the below fixes from 4.9 kernel :
>>
>> c363224b: Fix wakeup functionality for SDIO
>> 61fc5bf6: Remove flag MMC_PM_WAKE_SDIO_IRQ in mmc_resume_host
>> a7a2a82e: Set sdio_pending_processing default state to false.
>>
>> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
>> Signed-off-by: kamasali <quic_kamasali@quicinc.com>
>> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
>> ---
>>   drivers/mmc/core/bus.c  | 7 +++++++
>>   drivers/mmc/core/sdio.c | 1 +
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
>> 58a60af..a475fe1 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -364,6 +364,13 @@ int mmc_add_card(struct mmc_card *card)  #endif
>>          card->dev.of_node = mmc_of_find_child_device(card->host, 0);
>>
>> +       if (mmc_card_sdio(card)) {
>> +               ret = device_init_wakeup(&card->dev, true);
>> +               if (ret)
>> +                       pr_err("%s: %s: failed to init wakeup: %d\n",
>> +                               mmc_hostname(card->host), __func__, ret);
>> +       }
>> +
>>          device_enable_async_suspend(&card->dev);
>>
>>          ret = device_add(&card->dev);
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c index
>> 25799ac..9502318 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -1096,6 +1096,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
>>          mmc_release_host(host);
>>
>>          host->pm_flags &= ~MMC_PM_KEEP_POWER;
>> +       host->pm_flags &= ~MMC_PM_WAKE_SDIO_IRQ;
>>          return err;
>>   }
>>
>> --
>> 2.7.4
>>
