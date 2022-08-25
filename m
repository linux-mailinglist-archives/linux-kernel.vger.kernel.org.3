Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658185A1843
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiHYSER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiHYSEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:04:15 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711AAB06F;
        Thu, 25 Aug 2022 11:04:14 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so5724003pjj.4;
        Thu, 25 Aug 2022 11:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gh8pLFldO50fiVci0OdL141TCfxkxDjEugbgeSSI8T8=;
        b=DpavOZv0Kd7uDbBG/kQdksF0FCw9jMLRT+e/zQTS/v/DFh4Bdb1vy/Gui7J/q1gew2
         DOBTczcdVMdgr5Uol7pwesoSd2gPpgf4UE2gzH3lq2iL9KCla1c6Tp90wxnMVyIuHI6h
         FgO2Sx/Vh/Y5DQlroifac/ZTnsYfWN20SBJL9HtCzNVVBZfu986/tDIVVChtKXFqjcyh
         K5nroixuw7oQJaegcRq+1aBGrUgZ8bqBgJjzlPDteMaW1VMysDx8CR5sBEcjE9tGq62U
         R/oA7H34n8GH8BAkKLqPKOmv/EvQKWSujMNlMc9PlVk3jI9zeuc1rn/+yKWc2KE+qt87
         93Jg==
X-Gm-Message-State: ACgBeo1hcf5buKoFwV/YyYpMS1ZfZ1xIGnMzf/qq3kiZKlU/oaZFizhr
        GpJI4lfc1KDXOoI4ukg7KDM=
X-Google-Smtp-Source: AA6agR7CFU2aM79N22sDwIWnfty4wO7V1f3b8vn4mHtGQRUYT2S9jgvjfervFyydp7hyA4QOghlj2Q==
X-Received: by 2002:a17:90b:33d2:b0:1fb:971b:c5e9 with SMTP id lk18-20020a17090b33d200b001fb971bc5e9mr251237pjb.90.1661450653976;
        Thu, 25 Aug 2022 11:04:13 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b00172b8e60019sm291701plq.249.2022.08.25.11.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 11:04:13 -0700 (PDT)
Message-ID: <3326ad2e-e82f-7254-7e6b-bb0a120288f8@acm.org>
Date:   Thu, 25 Aug 2022 11:04:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        mani@kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        jongmin jeong <jjmin.jeong@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1660213984-37793-1-git-send-email-quic_cang@quicinc.com>
 <1660213984-37793-2-git-send-email-quic_cang@quicinc.com>
 <ea877f4f-1acd-2da4-a6f5-10df02dfee74@acm.org>
 <4471ed41-516c-95d4-003d-28077df7dce4@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4471ed41-516c-95d4-003d-28077df7dce4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 18:42, Asutosh Das (asd) wrote:
> On 8/18/2022 7:41 PM, Bart Van Assche wrote:
>> On 8/11/22 03:33, Can Guo wrote:
>>> +static inline void ufshcd_mcq_process_event(struct ufs_hba *hba,
>>> +                        struct ufs_hw_queue *hwq)
>>> +{
>>> +    struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
>>> +    int tag;
>>> +
>>> +    tag = ufshcd_mcq_get_tag(hba, hwq, cqe);
>>> +    ufshcd_compl_one_task(hba, tag, cqe);
>>> +}
>>
>> Consider changing "process_event" into "process_cqe". Consider 
>> renaming ufshcd_compl_one_task() into ufshcd_compl_one_cqe().
>>
> The preparatory patch that would precede this change would define 
> ufshcd_compl_one_task() in ufshcd.c. Since this function would be 
> invoked both from Single Doorbell mode and MCQ mode, 
> ufshcd_compl_one_task() sounds more relevant. What say?

The name "task" is confusing since in SCSI standard documents it refers 
to "task management" while ufshcd_compl_one_task() is not related to 
SCSI task management at all. So I would appreciate it if another name is 
chosen than ufshcd_compl_one_task().

>>> +static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
>>> +{
>>> +    struct ufs_hw_queue *hwq;
>>> +    unsigned long outstanding_cqs;
>>> +    unsigned int nr_queues;
>>> +    int i, ret;
>>> +    u32 events;
>>> +
>>> +    ret = ufshcd_vops_get_outstanding_cqs(hba, &outstanding_cqs);
>>> +    if (ret)
>>> +        outstanding_cqs = (1U << hba->nr_hw_queues) - 1;
>>> +
>>> +    /* Exclude the poll queues */
>>> +    nr_queues = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
>>> +    for_each_set_bit(i, &outstanding_cqs, nr_queues) {
>>> +        hwq = &hba->uhq[i];
>>> +
>>> +        events = ufshcd_mcq_read_cqis(hba, i);
>>> +        if (events)
>>> +            ufshcd_mcq_write_cqis(hba, events, i);
>>> +
>>> +        if (events & UFSHCD_MCQ_CQIS_TEPS)
>>> +            ufshcd_mcq_poll_cqe_nolock(hba, hwq);
>>> +    }
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>
>> Why the loop over the completion queues? Shouldn't UFSHCI 4.0 
>> compliant controllers support one interrupt per completion queue?
>>
> MCQ specification doesn't define that UFSHCI 4.0 compliant HC should 
> support one interrupt per completion queue. I guess it would depend on 
> HC vendors. But it specifies ESI as an alternate method; which is 
> implemented in this patch.

It is unfortunate that support for the ESI mechanism is optional in the 
UFSHCI 4.0 specification since I consider this as one of the most 
important UFSHCI 4.0 features. I wouldn't mind if MCQ would only be 
supported for UFSHCI 4.0 controllers that support ESI.

>>> +    if (hba->nutrs != old_nutrs) {
>>> +        ufshcd_release_sdb_queue(hba, old_nutrs);
>>> +        ret = ufshcd_memory_alloc(hba);
>>> +        if (ret)
>>> +            return ret;
>>> +        ufshcd_host_memory_configure(hba);
>>> +    }
>>
>> Can this freeing + reallocating be avoided?
>>
> Umm, we thought about this. Only after reading the device params, the 
> ext_iid support and the device queue depth be determined. So didn't look 
> like there's any other way than this. If you have any ideas, please let 
> us know.

