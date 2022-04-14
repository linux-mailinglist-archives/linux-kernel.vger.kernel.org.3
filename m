Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5795017F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiDNP6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbiDNPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:43:47 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4ECECC6F;
        Thu, 14 Apr 2022 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649950307; x=1681486307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CKnXeJmG80qNasD/DJM86YXzz1D3OUPPffQmkS3LbJs=;
  b=I+dIBkDQADPb1OrLjQ8TjhdKmiyAdRZAOrRWBmTw1bR7MBJOlbc+cHbE
   PaORcllqwIozbyE4e0bdMxsE4xJhdGaQrDKUYXF1H5SoFwxGd0lDeMwe6
   +4diJy+Jing/IouVcczizZrvBRdUu7Gj77mEFvb/S5yknc1uX9SyJYANO
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Apr 2022 08:31:46 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 08:31:46 -0700
Received: from [10.216.13.146] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 08:31:43 -0700
Message-ID: <c28fe8d6-86e9-3676-37ac-6adc8a7baaac@quicinc.com>
Date:   Thu, 14 Apr 2022 21:01:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mtd: rawnand: qcom: fix memory corruption that causes
 panic
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <quic_srichara@quicinc.com>
References: <1649914773-22434-1-git-send-email-quic_mdalam@quicinc.com>
 <20220414101517.7bbc5e9d@xps13>
 <DM6PR02MB580382FA47C4884AFC1A98D0FAEF9@DM6PR02MB5803.namprd02.prod.outlook.com>
 <2697e757-f446-9cdb-95e0-ea01a642e6d4@quicinc.com>
 <20220414144236.4ea54e20@xps13> <20220414143907.GA20493@thinkpad>
 <20220414165909.249c2325@xps13>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20220414165909.249c2325@xps13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/14/2022 8:29 PM, Miquel Raynal wrote:
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
>
> Hi Manivannan,
>
> mani@kernel.org wrote on Thu, 14 Apr 2022 20:09:07 +0530:
>
>> On Thu, Apr 14, 2022 at 02:42:36PM +0200, Miquel Raynal wrote:
>>> Hi Md,
>>>
>>> quic_mdalam@quicinc.com wrote on Thu, 14 Apr 2022 17:50:48 +0530:
>>>
>>>>> Hi Md,
>>>>>
>>>>> quic_mdalam@quicinc.com wrote on Thu, 14 Apr 2022 11:09:33 +0530:
>>>>>
>>>>>> This patch fixes a memory corruption that occurred in the
>>>>>> nand_scan() path for Hynix nand device.
>>>>>>
>>>>>> On boot, for Hynix nand device will panic at a weird place:
>>>>>> | Unable to handle kernel NULL pointer dereference at virtual
>>>>>>     address 00000070
>>>>>> | [00000070] *pgd=00000000
>>>>>> | Internal error: Oops: 5 [#1] PREEMPT SMP ARM Modules linked in:
>>>>>> | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-01473-g13ae1769cfb0
>>>>>>     #38
>>>>>> | Hardware name: Generic DT based system PC is at
>>>>>> | nandc_set_reg+0x8/0x1c LR is at qcom_nandc_command+0x20c/0x5d0
>>>>>> | pc : [<c088b74c>]    lr : [<c088d9c8>]    psr: 00000113
>>>>>> | sp : c14adc50  ip : c14ee208  fp : c0cc970c
>>>>>> | r10: 000000a3  r9 : 00000000  r8 : 00000040
>>>>>> | r7 : c16f6a00  r6 : 00000090  r5 : 00000004  r4 :c14ee040
>>>>>> | r3 : 00000000  r2 : 0000000b  r1 : 00000000  r0 :c14ee040
>>>>>> | Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment none
>>>>>> | Control: 10c5387d  Table: 8020406a  DAC: 00000051 Register r0
>>>>>> | information: slab kmalloc-2k start c14ee000 pointer offset
>>>>>>     64 size 2048
>>>>>> | Process swapper/0 (pid: 1, stack limit = 0x(ptrval)) nandc_set_reg
>>>>>> | from qcom_nandc_command+0x20c/0x5d0 qcom_nandc_command from
>>>>>> | nand_readid_op+0x198/0x1e8 nand_readid_op from
>>>>>> | hynix_nand_has_valid_jedecid+0x30/0x78
>>>>>> | hynix_nand_has_valid_jedecid from hynix_nand_init+0xb8/0x454
>>>>>> | hynix_nand_init from nand_scan_with_ids+0xa30/0x14a8
>>>>>> | nand_scan_with_ids from qcom_nandc_probe+0x648/0x7b0
>>>>>> | qcom_nandc_probe from platform_probe+0x58/0xac
>>>>>>
>>>>>> The problem is that the nand_scan()'s qcom_nand_attach_chip callback
>>>>>> is updating the nandc->max_cwperpage from 1 to 4.This causes the
>>>>>> sg_init_table of clear_bam_transaction() in the driver's
>>>>>> qcom_nandc_command() to memset much more than what was initially
>>>>>> allocated by alloc_bam_transaction().
>>>>> Thanks for investigating!
>>>>>
>>>>>> This patch will update nandc->max_cwperpage 1 to 4 after nand_scan()
>>>>>> returns, and remove updating nandc->max_cwperpage from
>>>>>> qcom_nand_attach_chip call back.
>>>>> The fix does not look right, as far as I understand, this should be properly handled during the attach phase. That is where we have all information about the chip and do the configuration for this chip.
>>>>>
>>>>> If you update max_cwperpage there you should probably update other internal variables that depend on it as well.
>>>>      Currently we are updating max_cwperpage  in qcom_nand_attach_chip(), but we are seeing issue for Hynix nand device since nand_scan_tail() is getting called after nand_attach() and in nand_attach() we are updating max_cwperpage to 4 or 8 based on page size.
>>>>
>>>>       From nand_scan_tail() there is a call for nand_manufacturer_init() , specific to Hynix nand read_id is getting called that's why we are seeing this issue only for Hynix nand device. Read id sequence as below
>>>>
>>>>      hynix_nand_has_valid_jedecid()
>>>>
>>>>                   |
>>>>
>>>>      nand_readid_op()
>>>>
>>>>                |
>>>>
>>>>    qcom_nandc_command()
>>>>
>>>>               |
>>>>
>>>> pre_command()
>>>>
>>>>             |
>>>>
>>>> clear_bam_transaction()   --> In this call we are doing sg_init_table() which is calling memset() based on max_cwperpage.Since initially we have allocated bam transaction as per max_cwperpage =1 and , since nand_chip_attach() updated max_cwperpage,  now we are doing memset as per max_cwperpage = 4 or 8.
>>>>
>>>>
>>>> So anyway we have to updated max_cwperpage after nand_scan() call only.  Since there is no other dependency on max_cwperpage in nand_attach_chip() and we are using this in bam_alloc() and bam_clear().
>>> Why don't you update the sg table after increasing max_cwperpage?
>>>
>> Or we could move the bam reallocation inside qcom_nand_attach_chip() as below?
> Much better approach, yes.
  Updated in V2 patch , as Manivannan suggested.
>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 7c6efa3b6255..58c16054630f 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -2653,9 +2653,23 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>>
>>          mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
>>
>> +       /* Free the initially allocated BAM transaction for reading the ONFI params */
>> +       if (nandc->props->is_bam)
>> +               free_bam_transaction(nandc);
>> +
>>          nandc->max_cwperpage = max_t(unsigned int, nandc->max_cwperpage,
>>                                       cwperpage);
>>
>> +       /* Now allocate the BAM transaction based on updated max_cwperpage */
>> +       if (nandc->props->is_bam) {
>> +               nandc->bam_txn = alloc_bam_transaction(nandc);
>> +               if (!nandc->bam_txn) {
>> +                       dev_err(nandc->dev,
>> +                               "failed to allocate bam transaction\n");
>> +                       return -ENOMEM;
>> +               }
>> +       }
>> +
>>          /*
>>           * DATA_UD_BYTES varies based on whether the read/write command protects
>>           * spare data with ECC too. We protect spare data by default, so we set
>> @@ -2956,17 +2970,6 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
>>          if (ret)
>>                  return ret;
>>
>> -       if (nandc->props->is_bam) {
>> -               free_bam_transaction(nandc);
>> -               nandc->bam_txn = alloc_bam_transaction(nandc);
>> -               if (!nandc->bam_txn) {
>> -                       dev_err(nandc->dev,
>> -                               "failed to allocate bam transaction\n");
>> -                       nand_cleanup(chip);
>> -                       return -ENOMEM;
>> -               }
>> -       }
>> -
>>          ret = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
>>          if (ret)
>>                  nand_cleanup(chip);
>>
>> Thanks,
>> Mani
>
> Thanks,
> Miquèl
