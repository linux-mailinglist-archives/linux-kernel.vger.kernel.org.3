Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274085576A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiFWJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFWJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:32:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6264C48888;
        Thu, 23 Jun 2022 02:32:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ge10so8262706ejb.7;
        Thu, 23 Jun 2022 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=LdYhzI3YRM2oYTwNpBD5tbJFl9QVm7xS2r9EfOe6pFE=;
        b=oq5bIlbx99l6S+vuc9hs2AHNbaUQqVmfX/V+4ypbZUR/eYgiUK0t4tw2N1XXp+rsqZ
         BOhCgpj7ZG3I5dlLzAvRsuiCIUD/he4oVAY8dKyTkfG/AELOBzINSBHBHWv6+85HlyAV
         n1k+EkSKaluj115RSY9hqUtqpcq/+layPlf8WBm9qt+/RR1wJ1Whs4hhoNzbl0MfMoO/
         TgV6XxzX2a6r5DDqvX9yqyiCeIcAE7P+hI0s20n/dJigWYorL8p/wu9rTiMC1ZtNzT9F
         hvCtvD22obirIi0+f4vdcucT9+cGm2RuMK2ifgD3kp3APAGdg2n5ywmQ8SwX1nJiojA6
         8MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LdYhzI3YRM2oYTwNpBD5tbJFl9QVm7xS2r9EfOe6pFE=;
        b=ycVKK/+2paFJhTyruHwIFm44jnmud5xaZwxNwxFdk1dDwQWzkQTOl1kflhbnIaYA5C
         BC/hpcQGJxdeYO0KhmkTh3oyNhoQsrTaXJ2vmhITg43gojiy/cQGB+fpeuFiRq1taydk
         tHZz+5oT7/AO/27y+o1z5uewEgiwhXPhzN4dFGzCsSIeCVWDh/cnwah/ePrVmqp4hvy9
         pXLUTgOY9CV9ntlCx6qXLTAgBvbizDeheIJpDw9/W/PLAHcIu2MLYIerEK52gaJLVFg2
         kNIJR4MEQyxsPvMb3RcUso9Z7EYNNaVSPBp01IAuviU3Nj3nUexywn2SwzJBgo9A/eBI
         zavA==
X-Gm-Message-State: AJIora+eIAwFQOSOM2FGkD82gmyKjGcJzw7xZmSYm4mi6xcAk5SZCyca
        v1mklQnlwn2IIGvkxLkZAk4=
X-Google-Smtp-Source: AGRyM1tFcT4/vV3QoB7Vg1mZliuqNEBLbmX9N4CzyLi8jlN+4KQOwKhHav/Y5SDnR79kWbg1DDDyLQ==
X-Received: by 2002:a17:907:16ab:b0:711:f0dd:91c with SMTP id hc43-20020a17090716ab00b00711f0dd091cmr7008431ejc.575.1655976766853;
        Thu, 23 Jun 2022 02:32:46 -0700 (PDT)
Received: from [192.168.1.143] (host-87-242-32-154.prtelecom.hu. [87.242.32.154])
        by smtp.gmail.com with ESMTPSA id d25-20020a17090694d900b00724e6a55d1asm708820ejy.197.2022.06.23.02.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 02:32:46 -0700 (PDT)
Message-ID: <c678589c-cb30-35a3-cc7f-ad4065863640@gmail.com>
Date:   Thu, 23 Jun 2022 11:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] libata: add horkage for M88V29
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>, zboszor@pr.hu,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20220204125750.1771303-1-zboszor@pr.hu>
 <f726e9e1-bdad-ac8a-368b-aae423a00676@opensource.wdc.com>
 <78c29f43-3b67-8e70-0711-14e997f3efb1@gmail.com>
 <09091cc4-f652-0978-bb6a-b63f24fdcf49@opensource.wdc.com>
 <bbfeb862-9e1f-79c2-89dd-7db9515471e4@gmail.com>
 <7f086930-ff6c-da99-212b-46c4479247cb@opensource.wdc.com>
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <7f086930-ff6c-da99-212b-46c4479247cb@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022. 06. 23. 10:46 keltezéssel, Damien Le Moal írta:
> On 6/23/22 17:38, Böszörményi Zoltán wrote:
>> 2022. 06. 23. 10:22 keltezéssel, Damien Le Moal írta:
>>> On 6/23/22 16:47, Böszörményi Zoltán wrote:
>>>> 2022. 02. 08. 9:07 keltezéssel, Damien Le Moal írta:
>>>>> On 2/4/22 21:57, zboszor@pr.hu wrote:
>>>>>> From: Zoltán Böszörményi <zboszor@gmail.com>
>>>>>>
>>>>>> This device is a CF card, or possibly an SSD in CF form factor.
>>>>>> It supports NCQ and high speed DMA.
>>>>>>
>>>>>> While it also advertises TRIM support, I/O errors are reported
>>>>>> when the discard mount option fstrim is used. TRIM also fails
>>>>>> when disabling NCQ and not just as an NCQ command.
>>>>>>
>>>>>> TRIM must be disabled for this device.
>>>>>>
>>>>>> Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
>>>>>> ---
>>>>>>     drivers/ata/libata-core.c | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>>>> index 67f88027680a..4a7f58fcc411 100644
>>>>>> --- a/drivers/ata/libata-core.c
>>>>>> +++ b/drivers/ata/libata-core.c
>>>>>> @@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>>>>>     
>>>>>>     	/* devices that don't properly handle TRIM commands */
>>>>>>     	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
>>>>>> +	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
>>>>>>     
>>>>>>     	/*
>>>>>>     	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
>>>>> Applied to for-5.17-fixes. Thanks !
>>>> Thank you. However, I have second thoughts about this patch.
>>>> The device advertises this:
>>>>
>>>> # hdparm -iI /dev/sda
>>>> ...
>>>>     Enabled Supported
>>>>        *    Data Set Management TRIM supported (limit 1 block)
>>>> ...
>>>>
>>>> but the I/O failures always reported higher number of blocks,
>>>> IIRC the attempted number of block was 8 or so.
>>>>
>>>> Can the kernel limit or split TRIM commands according to the
>>>> advertised limit? If not (or not yet) then the quirk is good for now.
>>> Yes, the kernel does that. See the sysfs queue attributes
>>> discard_max_bytes and discard_max_hw_bytes. What are the values for your
>>> device ? I think that the "limit 1 block" indicated by hdparm is simply to
>>> say that the DSM command (to trim the device) accept only at most a 1
>>> block (512 B) list of sectors to trim. That is not the actual trim limit
>>> for each sector range in that list.
>> With the quirk in effect (TRIM disabled) I have these:
>>
>> [root@chef queue]# pwd
>> /sys/block/sda/queue
>> [root@chef queue]# cat discard_granularity
>> 0
>> [root@chef queue]# cat discard_max_bytes
>> 0
>> [root@chef queue]# cat discard_max_hw_bytes
>> 0
> Yes, expected. What are the values without the quirk applied ?

I built 5.18.6 with removing the quirk.

[root@chef queue]# pwd
/sys/block/sda/queue/
[root@chef queue]# cat discard_granularity
512
[root@chef queue]# cat discard_max_bytes
2147450880
[root@chef queue]# cat discard_max_hw_bytes
2147450880
[root@chef queue]# cat max_discard_segments
1

> With 5.19, you can use libata.force to disable/enable it. See
> Documentation/admin-guide/kernel-parameters.txt for details.
> You could try disabling DSM TRIM (queued trim) and see if the non-ncq trim
> work.
>

