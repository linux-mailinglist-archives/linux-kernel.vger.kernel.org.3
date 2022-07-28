Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDC584709
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiG1U3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1U32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:29:28 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF24F4BD16;
        Thu, 28 Jul 2022 13:29:27 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id b9so2856697pfp.10;
        Thu, 28 Jul 2022 13:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jSRNg05RVYNg2Mx0bxK79yY4wawxWqwWlwy1Eu8QpFM=;
        b=4HO7OG6gB8AtDQgmPJvk07mL3+2PWHmGb+Qaiw7uRB81xyIX3gTGebebc1C+igkBkQ
         jG82JhKxI3IW4AlbfV3s33iF8PreIdpTPh1iG/OalHY+vMBq6+pmI0beyISTwV5AMW2f
         oUCzazCe6MYS0Gp+UOGAnRlAvHATjPN3VZYUAySFwVrTSANd1ZSQnrzZn9pnQLnei238
         ye1NQkaYaV35LB3nRMBplXiRoMLwyBXdfWCGYVAXXYkjnGe2jyQWrN1uJ/4JiwbwEhce
         DPfu+DFjDlkqZEqWzs1CZLfKyPSQCcd47tiBUXpn10IUaRrnGZ8Ee86Ydx6lJG8iWSiF
         XJfw==
X-Gm-Message-State: AJIora9I4A/JXH/kHz+YAiqJqTdjt0R1sWXXhd0oN32Qiei9pnrDP2Jd
        Yxfzjp1cEVtH6n/dfCVdUY8=
X-Google-Smtp-Source: AGRyM1v4E9QCHZvDOePFBfRMC9yunxP4Bgo3UNYDwKHqpWj27rO0Okj8f2mtXyre+nwxEU27BJkn1g==
X-Received: by 2002:a63:1324:0:b0:419:afb2:af7b with SMTP id i36-20020a631324000000b00419afb2af7bmr348428pgl.367.1659040167164;
        Thu, 28 Jul 2022 13:29:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9520:2952:8318:8e3e? ([2620:15c:211:201:9520:2952:8318:8e3e])
        by smtp.gmail.com with ESMTPSA id e19-20020a17090ac21300b001f320faea95sm1518199pjt.2.2022.07.28.13.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 13:29:26 -0700 (PDT)
Message-ID: <10288041-8c3d-7e3a-9049-10b9fcd8baed@acm.org>
Date:   Thu, 28 Jul 2022 13:29:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>,
        John Garry <john.garry@huawei.com>,
        Can Guo <quic_cang@quicinc.com>, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, quic_nguyenb@quicinc.com,
        quic_ziqichen@quicinc.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <f93045ec-569c-bd09-3617-d7d7aca4e5cd@huawei.com>
 <ea33dee8-673c-0716-1640-28df7c983ca7@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ea33dee8-673c-0716-1640-28df7c983ca7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 12:15, Asutosh Das (asd) wrote:
> Hello John,
> 
> On 7/28/2022 12:10 PM, John Garry wrote:
>> On 19/07/2022 08:01, Can Guo wrote:
>>> +
>>> +    hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
>>> +    hba->nr_queues[HCTX_TYPE_READ] = 0;
>>> +    hba->nr_queues[HCTX_TYPE_POLL] = 1;
>>> +
>>> +    for (i = 0; i < HCTX_MAX_TYPES; i++)
>>> +        host->nr_hw_queues += hba->nr_queues[i];
>>> +
>>> +    host->can_queue = hba->nutrs;
>>> +    host->cmd_per_lun = hba->nutrs;
>>> +
>>> +    /* One more reserved for dev_cmd_queue */
>>> +    hba->nr_hw_queues = host->nr_hw_queues + 1;
>>> +
>>
>> So this would mean that the host can accept .can_queue * .nr_hw_queues 
>> numbers of requests simultaneously - is that true?
>
> That would mean that .can_queue * .nr_hw_queues numbers of request may 
> be queued to the host.
> Please can you elaborate if you see an issue.

Hi Asutosh,

The `host_tagset` flag has been introduced by John and Hannes some time 
ago. See also commit bdb01301f3ea ("scsi: Add host and host template 
flag 'host_tagset'"). This flag supports sharing tags across hardware 
queues and could be used to support UFSHCI 4.0 controllers that do not 
support the EXT_IID feature.

In order not to complicate the implementation further, I propose to fall 
back to the UFSHCI 3.0 compatibility mode for UFSHCI 4.0 controllers 
that do not support the EXT_IID feature.

To answer John's question: the maximum number of outstanding commands is 
16 * hba->nutrs if EXT_IID is supported (EXT_IID is a four bits field). 
If the hardware queue index is encoded in the EXT_IID field, hba->nutrs 
is the number of commands per hardware queue.

Thanks,

Bart.
