Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD358468C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiG1TP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiG1TP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:15:26 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EE12F019;
        Thu, 28 Jul 2022 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659035725; x=1690571725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o0F5wy3XOw205GrsS1q6nC/o+IEYDXZlzsjeKeIuF/w=;
  b=dQoJjR0qA0jvzrCDBXdiUKk5gmde7ZTtO/uCTckT8zW2BSt2QQOy+RBk
   y69NDhk3SW/nE/63G0ALwCpePtcrfifHX6aCOhx+eiYNl4AopqNHcqMVj
   KlJIS3ST9heRQ0f9UJ4c35rOT97j9wYQ4Hsb4YCzLm4Sk/BKjDf5SOJHn
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Jul 2022 12:15:25 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 12:15:25 -0700
Received: from [10.110.38.152] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Jul
 2022 12:15:24 -0700
Message-ID: <ea33dee8-673c-0716-1640-28df7c983ca7@quicinc.com>
Date:   Thu, 28 Jul 2022 12:15:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
To:     John Garry <john.garry@huawei.com>,
        Can Guo <quic_cang@quicinc.com>, <bvanassche@acm.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <beanhuo@micron.com>, <quic_nguyenb@quicinc.com>,
        <quic_ziqichen@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <f93045ec-569c-bd09-3617-d7d7aca4e5cd@huawei.com>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <f93045ec-569c-bd09-3617-d7d7aca4e5cd@huawei.com>
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

Hello John,

On 7/28/2022 12:10 PM, John Garry wrote:
> On 19/07/2022 08:01, Can Guo wrote:
>> +
>> +    hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
>> +    hba->nr_queues[HCTX_TYPE_READ] = 0;
>> +    hba->nr_queues[HCTX_TYPE_POLL] = 1;
>> +
>> +    for (i = 0; i < HCTX_MAX_TYPES; i++)
>> +        host->nr_hw_queues += hba->nr_queues[i];
>> +
>> +    host->can_queue = hba->nutrs;
>> +    host->cmd_per_lun = hba->nutrs;
>> +
>> +    /* One more reserved for dev_cmd_queue */
>> +    hba->nr_hw_queues = host->nr_hw_queues + 1;
>> +
> 
> So this would mean that the host can accept .can_queue * .nr_hw_queues 
> numbers of requests simultaneously - is that true?
> 
That would mean that .can_queue * .nr_hw_queues numbers of request may 
be queued to the host.
Please can you elaborate if you see an issue.

> thanks,
> John

-asd

