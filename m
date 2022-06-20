Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24D855100C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiFTGHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiFTGHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:07:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4204A656E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655705232; x=1687241232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jCVW2VD3p3E4Ofb+bvcuspH3xYyQy+8SWjIJiqR2b4M=;
  b=pkPhtuLaxyZC5K73L2bIxAfLf6BWFSveat0VKaJAebhmMlM00N6Cj1Hr
   gxOuisgk05dw02P19nSG04GCT+acGMbadeLg5545ZUfVvR3q5zF+Lwa59
   OBcvlsmqSpIP3WKIsihBhjpsa5NG3Rb052WX4qU43x9UCfXkINkI/p5mK
   wV+RV9gQkTk/8k/hPHSyvOahjVI14t295by1udAPgI8YLG6KE9JzGShXV
   vE3bR8yxGkozALx9IBGGctjGFtFrHQaav3lLsR0jMFYiyZOy4JstD1IPV
   H7sdQiMexrDJtjmWXWtIoXNQER6LSCcL6/TSrCwwH3ofAenSuR2WSu38a
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307912573"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 14:07:10 +0800
IronPort-SDR: ZjXpLpbHChALf6/z3zkvwEBqB24W2jj9wFFg3SsRS13cbYZr4hl6L59Gy3aPS33T4Md8GloHeQ
 Hi4wr+ni2NZS79v9U0glsCM0UP7M3pSewDfgqxsTVENliEyzaUuOs2iHQEH740caS/Jkh4F9ko
 a2EGmoLuLaqX+MTrV1jlsJE5m0ab3QCRdlgUPhRkrRRUjg4JHEgiyw2kSB/9YltIOosE5Olf/+
 pUxrBC9Pu661KtqpRQo/7dHC139LT2PFp7AgUwKCunaih0sO9V52IeFYOVYDqzwABwdwVxewTr
 kF5L2iDMOWXJOb1TDTKEDqCB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 22:29:42 -0700
IronPort-SDR: 2GgwTNq92oXIEbcOwrfAPwPl8qYnP5Al2QyinBCTQ7Giz8shwFK1KpCWnvG0A2eCrXfW3pdnz9
 bP9FxR4ByB+5zKKUwWPiHnzcFpuPwXQ9xOG1fhbyEEkZ6gmGkFwKV3uOXCFZTYLHzL5ZhtZY8P
 Qq6mQbObZDvYZzgcemeWv1ScvOTlArs/a3IHmlPrZSWOE9yA1Jp5pLsa0aD7VtdDXy/sfuC7co
 q5Yu9OYTaSj+hEcfhHAS/jhx3fG3b4Z01UMp663XmEx1HDrG2i/wc/1uDqEErPIdW/XOeWmyib
 LiE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 23:07:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRK196yzxz1SVp2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:07:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655705229; x=1658297230; bh=jCVW2VD3p3E4Ofb+bvcuspH3xYyQy+8SWjI
        JiqR2b4M=; b=q3eZULXz9zGyoqnyr9s7mb/E5slOyE0yiAfnO3ioxojdfjrLpS2
        ftX2RJ+A/SkBChLaHGQrlzoGrkbLCtOoS11b2TzN+esm+4U39V/fTgPJdZgmj2a1
        frFphEFvyXCkgZhsUr8v8BAwDdGE8i5e6OE3vZhPDNSJ1pl1iv5SGQ2AUREyK+j0
        SxThN0R7nEL26MqextyVaPYFUSO/63gjjv8/NvCUTIBAvfyfHkiOuvHhXaVfwBXD
        5+zULVMWxOuX0CPBdaRDoidYpIvEIWQAE3dC08m35C7oC9Dw4u162G8tPUvcPZLy
        TE0InorKFCsTpiGNkjfgIlQLIjJcXiv12qg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yYW57WC6g-XL for <linux-kernel@vger.kernel.org>;
        Sun, 19 Jun 2022 23:07:09 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRK180Gdwz1Rvlc;
        Sun, 19 Jun 2022 23:07:07 -0700 (PDT)
Message-ID: <594ac0c9-a55b-bec7-77e3-a6c7e9525f6b@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 15:07:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/4] scsi: pm8001: Use non-atomic bitmap ops for tag alloc
 + free
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
        jinpu.wang@cloud.ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
 <1654879602-33497-4-git-send-email-john.garry@huawei.com>
 <303bbfad-edde-1197-679e-4a09175fb1f3@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <303bbfad-edde-1197-679e-4a09175fb1f3@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 15:00, Hannes Reinecke wrote:
> On 6/10/22 18:46, John Garry wrote:
>> In pm8001_tag_alloc() we don't require atomic set_bit() as we are already
>> in atomic context. In pm8001_tag_free() we should use the same host
>> spinlock to protect clearing the tag (and then don't require the atomic
>> clear_bit()).
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/scsi/pm8001/pm8001_sas.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
>> index 3a863d776724..8e3f2f9ddaac 100644
>> --- a/drivers/scsi/pm8001/pm8001_sas.c
>> +++ b/drivers/scsi/pm8001/pm8001_sas.c
>> @@ -66,7 +66,11 @@ static int pm8001_find_tag(struct sas_task *task, u32 *tag)
>>   void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>>   {
>>   	void *bitmap = pm8001_ha->tags;
>> -	clear_bit(tag, bitmap);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
>> +	__clear_bit(tag, bitmap);
>> +	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
>>   }
>>   
> This spin lock is pretty much pointless; clear_bit() is always atomic.

But __clear_bit() is not atomic. I think it was the point of this patch,
to not use atomics and use the spinlock instead to protect bitmap.

Before the patch, pm8001_tag_alloc() takes the spinlock *and* use the
atomic set_bit(), which is an overkill. pm8001_tag_free() only clears the
bit using the the atomic clear_bit().

After the patch, spinlock guarantees atomicity for both alloc and free.

Not sure there is any gain from this.

> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
