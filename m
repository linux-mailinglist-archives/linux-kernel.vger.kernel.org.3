Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4F9584786
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiG1VH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiG1VHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:07:23 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625906D2D1;
        Thu, 28 Jul 2022 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659042441; x=1690578441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mDjr9pk15K3HDo23mFhJv0WTCFDPNDJy6bT+G7ZkmPg=;
  b=HuXtV6E9CFuFK+MWnKCg2SaZN87ydRnc2GTwODYFr7GU1wtoozup+fL4
   Wu2Tcn1xFHj3VLXY3AuuV74bOOjYlMR8dMjJBmtS1EMtkQJ0H7z8CLNRr
   ONIQ9E84UUlogSy8OcLjWdQ2mx1Q9VLjSgPJCUYh/Jdv2C8yjAPz0+K/i
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Jul 2022 14:07:21 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 14:07:20 -0700
Received: from [10.110.38.152] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Jul
 2022 14:07:19 -0700
Message-ID: <6da1447d-01d6-222e-fc98-7e96b154d2d0@quicinc.com>
Date:   Thu, 28 Jul 2022 14:07:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Can Guo <quic_cang@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <quic_nguyenb@quicinc.com>, <quic_ziqichen@quicinc.com>,
        <linux-scsi@vger.kernel.org>, <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <f93045ec-569c-bd09-3617-d7d7aca4e5cd@huawei.com>
 <ea33dee8-673c-0716-1640-28df7c983ca7@quicinc.com>
 <10288041-8c3d-7e3a-9049-10b9fcd8baed@acm.org>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <10288041-8c3d-7e3a-9049-10b9fcd8baed@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/2022 1:29 PM, Bart Van Assche wrote:
> On 7/28/22 12:15, Asutosh Das (asd) wrote:
>> Hello John,
>>
>> On 7/28/2022 12:10 PM, John Garry wrote:
>>> On 19/07/2022 08:01, Can Guo wrote:
>>>> +
>>>> +    hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
>>>> +    hba->nr_queues[HCTX_TYPE_READ] = 0;
>>>> +    hba->nr_queues[HCTX_TYPE_POLL] = 1;
>>>> +
>>>> +    for (i = 0; i < HCTX_MAX_TYPES; i++)
>>>> +        host->nr_hw_queues += hba->nr_queues[i];
>>>> +
>>>> +    host->can_queue = hba->nutrs;
>>>> +    host->cmd_per_lun = hba->nutrs;
>>>> +
>>>> +    /* One more reserved for dev_cmd_queue */
>>>> +    hba->nr_hw_queues = host->nr_hw_queues + 1;
>>>> +
>>>
>>> So this would mean that the host can accept .can_queue * 
>>> .nr_hw_queues numbers of requests simultaneously - is that true?
>>
>> That would mean that .can_queue * .nr_hw_queues numbers of request may 
>> be queued to the host.
>> Please can you elaborate if you see an issue.
> 
> Hi Asutosh,
> 
> The `host_tagset` flag has been introduced by John and Hannes some time 
> ago. See also commit bdb01301f3ea ("scsi: Add host and host template 
> flag 'host_tagset'"). This flag supports sharing tags across hardware 
> queues and could be used to support UFSHCI 4.0 controllers that do not 
> support the EXT_IID feature.
> 
> In order not to complicate the implementation further, I propose to fall 
> back to the UFSHCI 3.0 compatibility mode for UFSHCI 4.0 controllers 
> that do not support the EXT_IID feature.
> 
> To answer John's question: the maximum number of outstanding commands is 
> 16 * hba->nutrs if EXT_IID is supported (EXT_IID is a four bits field). 
> If the hardware queue index is encoded in the EXT_IID field, hba->nutrs 
> is the number of commands per hardware queue.
> 
> Thanks,
> 
> Bart.

Thanks Bart, I wasn't aware of the background of John's Q. I will 
consider your proposal and get back.

-asd
