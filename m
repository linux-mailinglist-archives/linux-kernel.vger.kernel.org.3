Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F03500D12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbiDNMXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiDNMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:23:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7D8C7C2;
        Thu, 14 Apr 2022 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649938856; x=1681474856;
  h=message-id:date:mime-version:subject:references:from:to:
   in-reply-to:content-transfer-encoding;
  bh=XQzkMr/Z8ZY/1F9whxA7rLJIz5j5Y5jxd67801ew3pM=;
  b=flEL6NI2NMVmPAw9N7DN+Egkwh2wjmK7vYvSFuNovjRoxwUEkBw/FcZs
   3plCQ4Sp5KTWW1cQVuGcNQpyKIkyxlm7Ph52kX6AzFSX+cuOMgOVNwUyP
   f55uylSYDW/cCUpInAV3N5Zh0w3XyFt1fqznKshzT8xzmoUlVajLWO1av
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Apr 2022 05:20:55 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:20:55 -0700
Received: from [10.201.2.159] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 05:20:51 -0700
Message-ID: <2697e757-f446-9cdb-95e0-ea01a642e6d4@quicinc.com>
Date:   Thu, 14 Apr 2022 17:50:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: FW: [PATCH] mtd: rawnand: qcom: fix memory corruption that causes
 panic
Content-Language: en-US
References: <1649914773-22434-1-git-send-email-quic_mdalam@quicinc.com>
 <20220414101517.7bbc5e9d@xps13>
 <DM6PR02MB580382FA47C4884AFC1A98D0FAEF9@DM6PR02MB5803.namprd02.prod.outlook.com>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     <miquel.raynal@bootlin.com>, <mani@kernel.org>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <quic_srichara@quicinc.com>,
        <quic_mdalam@quicinc.com>
In-Reply-To: <DM6PR02MB580382FA47C4884AFC1A98D0FAEF9@DM6PR02MB5803.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

> Hi Md,
>
> quic_mdalam@quicinc.com wrote on Thu, 14 Apr 2022 11:09:33 +0530:
>
>> This patch fixes a memory corruption that occurred in the
>> nand_scan() path for Hynix nand device.
>>
>> On boot, for Hynix nand device will panic at a weird place:
>> | Unable to handle kernel NULL pointer dereference at virtual
>>    address 00000070
>> | [00000070] *pgd=00000000
>> | Internal error: Oops: 5 [#1] PREEMPT SMP ARM Modules linked in:
>> | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-01473-g13ae1769cfb0
>>    #38
>> | Hardware name: Generic DT based system PC is at
>> | nandc_set_reg+0x8/0x1c LR is at qcom_nandc_command+0x20c/0x5d0
>> | pc : [<c088b74c>]    lr : [<c088d9c8>]    psr: 00000113
>> | sp : c14adc50  ip : c14ee208  fp : c0cc970c
>> | r10: 000000a3  r9 : 00000000  r8 : 00000040
>> | r7 : c16f6a00  r6 : 00000090  r5 : 00000004  r4 :c14ee040
>> | r3 : 00000000  r2 : 0000000b  r1 : 00000000  r0 :c14ee040
>> | Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment none
>> | Control: 10c5387d  Table: 8020406a  DAC: 00000051 Register r0
>> | information: slab kmalloc-2k start c14ee000 pointer offset
>>    64 size 2048
>> | Process swapper/0 (pid: 1, stack limit = 0x(ptrval)) nandc_set_reg
>> | from qcom_nandc_command+0x20c/0x5d0 qcom_nandc_command from
>> | nand_readid_op+0x198/0x1e8 nand_readid_op from
>> | hynix_nand_has_valid_jedecid+0x30/0x78
>> | hynix_nand_has_valid_jedecid from hynix_nand_init+0xb8/0x454
>> | hynix_nand_init from nand_scan_with_ids+0xa30/0x14a8
>> | nand_scan_with_ids from qcom_nandc_probe+0x648/0x7b0
>> | qcom_nandc_probe from platform_probe+0x58/0xac
>>
>> The problem is that the nand_scan()'s qcom_nand_attach_chip callback
>> is updating the nandc->max_cwperpage from 1 to 4.This causes the
>> sg_init_table of clear_bam_transaction() in the driver's
>> qcom_nandc_command() to memset much more than what was initially
>> allocated by alloc_bam_transaction().
> Thanks for investigating!
>
>> This patch will update nandc->max_cwperpage 1 to 4 after nand_scan()
>> returns, and remove updating nandc->max_cwperpage from
>> qcom_nand_attach_chip call back.
> The fix does not look right, as far as I understand, this should be properly handled during the attach phase. That is where we have all information about the chip and do the configuration for this chip.
>
> If you update max_cwperpage there you should probably update other internal variables that depend on it as well.

    Currently we are updating max_cwperpage  in qcom_nand_attach_chip(), 
but we are seeing issue for Hynix nand device since nand_scan_tail() is 
getting called after nand_attach() and in nand_attach() we are updating 
max_cwperpage to 4 or 8 based on page size.

     From nand_scan_tail() there is a call for nand_manufacturer_init() 
, specific to Hynix nand read_id is getting called that's why we are 
seeing this issue only for Hynix nand device. Read id sequence as below

    hynix_nand_has_valid_jedecid()

                 |

    nand_readid_op()

              |

  qcom_nandc_command()

             |

pre_command()

           |

clear_bam_transaction()   --> In this call we are doing sg_init_table() 
which is calling memset() based on max_cwperpage.Since initially we have 
allocated bam transaction as per max_cwperpage =1 and , since 
nand_chip_attach() updated max_cwperpage,  now we are doing memset as 
per max_cwperpage = 4 or 8.


So anyway we have to updated max_cwperpage after nand_scan() call only.  
Since there is no other dependency on max_cwperpage in 
nand_attach_chip() and we are using this in bam_alloc() and bam_clear().

>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> ---
>>   drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c
>> b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 1a77542..aa3ec45 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -2652,9 +2652,6 @@ static int qcom_nand_attach_chip(struct
>> nand_chip *chip)
>>
>>        mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
>>
>> -     nandc->max_cwperpage = max_t(unsigned int, nandc->max_cwperpage,
>> -                                  cwperpage);
>> -
>>        /*
>>         * DATA_UD_BYTES varies based on whether the read/write command protects
>>         * spare data with ECC too. We protect spare data by default, so
>> we set @@ -2909,7 +2906,7 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
>>        struct nand_chip *chip = &host->chip;
>>        struct mtd_info *mtd = nand_to_mtd(chip);
>>        struct device *dev = nandc->dev;
>> -     int ret;
>> +     int ret, cwperpage;
>>
>>        ret = of_property_read_u32(dn, "reg", &host->cs);
>>        if (ret) {
>> @@ -2955,6 +2952,9 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
>>        if (ret)
>>                return ret;
>>
>> +     cwperpage = mtd->writesize / NANDC_STEP_SIZE;
>> +     nandc->max_cwperpage = max_t(unsigned int, nandc->max_cwperpage,
>> +                                  cwperpage);
>>        if (nandc->props->is_bam) {
>>                free_bam_transaction(nandc);
>>                nandc->bam_txn = alloc_bam_transaction(nandc);
>
> Thanks,
> Miquèl
