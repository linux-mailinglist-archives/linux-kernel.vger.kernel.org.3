Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484A95846CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiG1UA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiG1UAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:00:39 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B2E0E1;
        Thu, 28 Jul 2022 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659038433; x=1690574433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7wSx42yAIj+tsLcAno+zo3P4dnHVjCLTpMmQehR5+1c=;
  b=l7wZdnsqII92IuwFbrFrYN7Y8ArgipZd+U2i5BKOsnIqbPh5+cEHWflC
   AtFQGUQ87cnXYErt66CsaAJhmcoHmmdEoFN3Fye/YN+QLPyDoSyb0SW55
   NKErRUFUmmIpbXEVYx4w0DJomO+OHDIC1NuZKVC/9j04yW9Wv6Lj2HriS
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jul 2022 13:00:32 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 13:00:32 -0700
Received: from [10.110.38.152] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Jul
 2022 13:00:31 -0700
Message-ID: <9fb79479-454d-d636-5554-5e080f05415e@quicinc.com>
Date:   Thu, 28 Jul 2022 13:00:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     Bart Van Assche <bvanassche@acm.org>,
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
 <f803e7fb-9dde-e4d4-a55c-6427516dfdbb@acm.org>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <f803e7fb-9dde-e4d4-a55c-6427516dfdbb@acm.org>
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

On 7/28/2022 12:38 PM, Bart Van Assche wrote:
> On 7/19/22 00:01, Can Guo wrote:
>>   static int ufshcd_map_queues(struct Scsi_Host *shost)
>>   {
>> -    int i, ret;
>> +    int i, queue_offset = 0, ret;
>> +    struct ufs_hba *hba = shost_priv(shost);
>>       for (i = 0; i < shost->nr_maps; i++) {
>>           struct blk_mq_queue_map *map = &shost->tag_set.map[i];
>> -        switch (i) {
>> -        case HCTX_TYPE_DEFAULT:
>> -        case HCTX_TYPE_POLL:
>> -            map->nr_queues = 1;
>> -            break;
>> -        case HCTX_TYPE_READ:
>> -            map->nr_queues = 0;
>> +        map->nr_queues = hba->nr_queues[i];
>> +        if (!map->nr_queues)
>>               continue;
>> -        default:
>> -            WARN_ON_ONCE(true);
>> -        }
>> -        map->queue_offset = 0;
>> +
>> +        map->queue_offset = queue_offset;
>> +        if (i == HCTX_TYPE_POLL && !is_mcq_enabled(hba))
>> +            map->queue_offset = 0;
>> +
>>           ret = blk_mq_map_queues(map);
>> -        WARN_ON_ONCE(ret);
>> +
>> +        if (ret)
>> +            return ret;
>> +
>> +        queue_offset += map->nr_queues;
>>       }
> 
> It is not clear to me why the WARN_ON_ONCE(ret) statement has been 
> changed into "if (ret) return ret;"?
> 
Looks like blk_mq_map_queues() only returns 0.
Will remove the if (ret) return ret statement in the next version.

> Thanks,
> 
> Bart.

