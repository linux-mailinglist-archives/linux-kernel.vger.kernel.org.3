Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D106050B483
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446326AbiDVKB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379948AbiDVKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:01:24 -0400
Received: from ZXBJCAS.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35978541A5;
        Fri, 22 Apr 2022 02:58:30 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXBJCAS.zhaoxin.com
 (10.29.252.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Fri, 22 Apr
 2022 17:58:29 +0800
Received: from [10.29.8.9] (10.29.8.9) by zxbjmbx1.zhaoxin.com (10.29.252.163)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Fri, 22 Apr
 2022 17:58:29 +0800
Subject: Re: [PATCH 2/2] ahci: Add PxSCTL.IPM control on actual LPM capability
References: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <1650534217-14052-3-git-send-email-RunaGuo-oc@zhaoxin.com>
 <2a91c02d-4f7c-535b-e047-889df87ebebd@opensource.wdc.com>
From:   RunaGuo-oc <RunaGuo-oc@zhaoxin.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cobe Chen <CobeChen@zhaoxin.com>, Tim Guo <TimGuo@zhaoxin.com>,
        TonyW Wang <TonyWWang@zhaoxin.com>,
        Leo Liu <LeoLiu@zhaoxin.com>
Message-ID: <74749fd5-82ae-ab40-69e8-bd93503cdafa@zhaoxin.com>
Date:   Fri, 22 Apr 2022 17:58:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2a91c02d-4f7c-535b-e047-889df87ebebd@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.29.8.9]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/21 18:53, Damien Le Moal wrote:
> On 4/21/22 18:43, Runa Guo-oc wrote:
>> On some platform, when OS enables LPM by default (eg, min_power),
>> then, DIPM slumber request cannot be disallowed if ahci's CAP.PSC
>> is set to '1' and CAP.SSC is cleared to '0', which may cause ahci
>> to be an uncertain state (same for Partial).
>>
>> In ahci spec, when CAP.PSC/SSC is cleared to '0', the PxSCTL.IPM
>> field must be programmed to disallow device initiated Partial/
>> Slumber request.
>>
>> Adds support to control this case on actual LPM capability.
> s/Adds/Add

Sorry, here should use 'Add' instead of 'Adds'.

> Overall, I need to reread the specs to confirm all this.

Ok.

>> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
>> ---
>>   drivers/ata/libata-sata.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>> index 7a5fe41..e6195cf 100644
>> --- a/drivers/ata/libata-sata.c
>> +++ b/drivers/ata/libata-sata.c
>> @@ -394,9 +394,19 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>>   	case ATA_LPM_MED_POWER_WITH_DIPM:
>>   	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
>>   	case ATA_LPM_MIN_POWER:
>> -		if (ata_link_nr_enabled(link) > 0)
>> +		if (ata_link_nr_enabled(link) > 0) {
>>   			/* no restrictions on LPM transitions */>  			scontrol &= ~(0x7 << 8);
> Given that the added code below adds restrictions, this comment is
> strange. Better change it to something like:
>
> 			/* Assume no restrictions on LPM transitions */
>
>> +
>> +			/* if controller does not support partial, then disallows it,
>> +			 * the same for slumber
>> +			 */
> Please correctly format the comment and check the grammar. Some like below
> is easier to read.
>
> 			/*
> 			 * If the controller does not support partial or
> 			 * slumber then disallow these transitions.
> 			 */
>
>> +			if (!(link->ap->host->flags & ATA_HOST_PART))
>> +				scontrol |= (0x1 << 8);
>> +
>> +			if (!(link->ap->host->flags & ATA_HOST_SSC))
>> +				scontrol |= (0x2 << 8);
>> +		}
>>   		else {
> Please do not leave this else here. Put it on the same line as the closing
> bracket and enclose the below statements in brackets too.
>
>>   			/* empty port, power off */
>>   			scontrol &= ~0xf;
> 		} else {
> 			/* empty port, power off */
>   			scontrol &= ~0xf;
> 		}

  
I'll change it like below,
+		if (ata_link_nr_enabled(link) > 0) {
-			/* no restrictions on LPM transitions */
+			/* Assume no restrictions on LPM transitions */
			scontrol &= ~(0x7 << 8);
  
+			/*
+			 * If the controller does not support partial or
+			 * slumber then disallow these transitions.
+			 */

+			if (!(link->ap->host->flags & ATA_HOST_PART))
+				scontrol |= (0x1 << 8);
+
+			if (!(link->ap->host->flags & ATA_HOST_SSC))
+				scontrol |= (0x2 << 8);

		} else {
			/* empty port, power off */
  			scontrol &= ~0xf;
		}

