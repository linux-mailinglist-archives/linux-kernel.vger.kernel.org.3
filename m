Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278AA580BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiGZGfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiGZGfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:35:19 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C86617F;
        Mon, 25 Jul 2022 23:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658817317; x=1690353317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oqiaUstZrPNZbvGmC+OGqeMInj0ofQIcow7ykALf3T8=;
  b=ChbkDW40TCKw8/ISjSFgG37LlCFC1LTzy9AzimDVntZXj26oYLX8LObX
   VVolmpT4qBdfqt/ST9JNIlKdssxRcb37V6xDF9niUbD6M2Zbh+SME6/Vo
   dA3+FN8Yw7ubI43td0kTW7yb4l0cgsXN6GFplE0cACpStOlUbWmCUlLiJ
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Jul 2022 23:35:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 23:35:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 23:35:16 -0700
Received: from [10.253.34.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Jul
 2022 23:35:11 -0700
Message-ID: <35eb780d-93cf-be2c-deb5-239fad5f3abf@quicinc.com>
Date:   Tue, 26 Jul 2022 14:35:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65757CEC7F66AB732EF5FC48FC929@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <DM6PR04MB65757CEC7F66AB732EF5FC48FC929@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri,

On 7/24/2022 12:07 PM, Avri Altman wrote:
>> @@ -2558,7 +2587,8 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct
>> ufshcd_lrb *lrbp, u8 upiu_flags)
>>                                  UPIU_TRANSACTION_COMMAND, upiu_flags,
>>                                  lrbp->lun, lrbp->task_tag);
>>          ucd_req_ptr->header.dword_1 = UPIU_HEADER_DWORD(
>> -                               UPIU_COMMAND_SET_TYPE_SCSI, 0, 0, 0);
>> +                               UPIU_COMMAND_SET_TYPE_SCSI |
>> +                               (lrbp->hw_queue_id << 4), 0, 0, 0);
> This is fine, as long as we have 16 queues or less.
> Otherwise, we need to fill the EXT_IID as well (only if bEXTIIDEn = 1).
>
> Also, don't we need to do this for query commands as well?
> Or at least add a comment that the queue id for query command is 0.

As per UFS4.0 JEDEC draft, EXT_IID or IID is not required in QUERY 
REQUEST/RESPONSE UPIU,

unless my doc is out dated, please let me know.


Thanks,

Can Guo.

>
> Thanks,
> Avri
