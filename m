Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85154DD21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359695AbiFPIn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiFPIn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:43:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183F5D1B3;
        Thu, 16 Jun 2022 01:43:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1F876601742;
        Thu, 16 Jun 2022 09:43:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655369034;
        bh=4jGClLDY5f6BG1FfD7RfaglDLpDrYdvh0EE5esCI3bo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SIjmBTDdK92BGB0lCzVdaetlRk6h4lsUfEldDJ4R3usWCUsEPDfHMC2RL1RdIj5RE
         aKyw8+jRXdTpADJ9rMJsqz+kH3+P/sw+IT9vyrDlV5LDSL0qghyUq17Xvm4cSeGttM
         R4vvDzvukC+AWxf8Lb0bhE1sVFvtx7StmobyFtAJGe6H7q3m8jJtK9zEaxo/mVq38C
         bdEBRUYRh8lMDPMJqN2C7hl1616zAi9l3J7gnio2FKC2Q+okZMcmO4Db3DVqyUu2OF
         YwzbfhBxYSWtIMLINL1LBbymVf7V/0oU7/3QsBhf9JQ81oE5NRlaI+g7WvWk21b7Ay
         Mq1MhIwx9ar0Q==
Message-ID: <c46dc265-115b-d27a-9e74-a7c48497cdfc@collabora.com>
Date:   Thu, 16 Jun 2022 10:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] mfd: mt6397: Add basic support for MT6331+MT6332 PMIC
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
 <20220520124617.228808-3-angelogioacchino.delregno@collabora.com>
 <YqpUmE5+Kmq9rxwB@google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YqpUmE5+Kmq9rxwB@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/06/22 23:52, Lee Jones ha scritto:
> On Fri, 20 May 2022, AngeloGioacchino Del Regno wrote:
> 
>> Add support for the MT6331 PMIC with MT6332 Companion PMIC, found
>> in MT6795 Helio X10 smartphone platforms.
>>
>> This combo has support for multiple devices but, for a start,
>> only the following have been implemented:
>> - Regulators (two instances, one in MT6331, one in MT6332)
>> - RTC (MT6331)
>> - Keys (MT6331)
>> - Interrupts (MT6331 also dispatches MT6332's interrupts)
>>
>> There's more to be implemented, especially for MT6332, which
>> will come at a later stage.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/mfd/mt6397-core.c            |  47 ++
>>   drivers/mfd/mt6397-irq.c             |   9 +-
>>   include/linux/mfd/mt6331/core.h      |  53 +++
>>   include/linux/mfd/mt6331/registers.h | 584 ++++++++++++++++++++++++
>>   include/linux/mfd/mt6332/core.h      |  53 +++
>>   include/linux/mfd/mt6332/registers.h | 642 +++++++++++++++++++++++++++
>>   include/linux/mfd/mt6397/core.h      |   2 +
>>   7 files changed, 1389 insertions(+), 1 deletion(-)
>>   create mode 100644 include/linux/mfd/mt6331/core.h
>>   create mode 100644 include/linux/mfd/mt6331/registers.h
>>   create mode 100644 include/linux/mfd/mt6332/core.h
>>   create mode 100644 include/linux/mfd/mt6332/registers.h
> 
> [...]
> 
>> +#endif /* __MFD_MT6332_REGISTERS_H__ */
>> diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
>> index 1cf78726503b..4d2b80319db3 100644
>> --- a/include/linux/mfd/mt6397/core.h
>> +++ b/include/linux/mfd/mt6397/core.h
>> @@ -12,6 +12,8 @@
>>   
>>   enum chip_id {
>>   	MT6323_CHIP_ID = 0x23,
> 
>> +	MT6331_CHIP_ID = 0x20,
>> +	MT6332_CHIP_ID = 0x20,
> 
> Are these meant to be the same?
> 

Yes, because this list is referring to the first 8 bits of the CID register,
which is the same for both 6331 and 6332, this is because these two chips are
meant to be used together (at least from my understanding), one as main PMIC
and one as a companion PMIC.

The difference belongs in the higher 8 bits, but there's no support for this
check in the mt6397 driver (yet), and I chose not to implement that to not
complicate this work *at least for now*, as I have no idea about what the
already implemented PMICs read in the high 8 bits (I can check only two of
them, but not the others as I don't have the hardware).

Besides, checking the lower 8 bits is important only because we get knowledge
of the chip *revision* and not the actual model (for which, we use devicetree
anyway).

Regards,
Angelo


