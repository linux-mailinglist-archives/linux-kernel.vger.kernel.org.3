Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C385333F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242679AbiEXXgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbiEXXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:36:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9662131DE1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:36:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q18so17135327pln.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7d1GZoiIPgurRKHqYkbLbRfkJMBlTGlbTuzD6kjnHaA=;
        b=KeFIqxa6CCFetIxYiv9IdzoKB2DP/2IjtAPFyJN7ulMa+N9FmuID4xO83AXLE9XhxD
         QLC9D4pC5g086lAPfbPlDRGHNGdMHwddAVFaFt97S4GEoEBfL5enEWauuAld1AZRclVs
         vlk6RettmorUKl8wUHT10Vie0HCcM3Mx9wBPqG0i6qhZfHFc4kVMJS7KgOVSrQE0xBgI
         9LIyRn2BTe72SSbfwn7J7ox7BQCmbUiHCfzzLsvKvnGb9uty97mnBsqi4usWbcRHpKsb
         9kuGhvHlJM08XtjrVtsc39552A578wJHeQW3WGHq8tKjima0G3jN8kCS2zMVMq4kqLdj
         4kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7d1GZoiIPgurRKHqYkbLbRfkJMBlTGlbTuzD6kjnHaA=;
        b=vjTEIrOysWiqYmJBdSMxPK3AucPmnY5LtYA/H0DeUkAIa2HUF870IG2180ch8Q0F69
         1h03/wlcRC9ITbjQlWVuOvZ8n/mO7y7y9rSJvYylqRBJy67ao3JupqWor8kiP4F6jVX6
         QdjSssw+LhYq02eWGJRw1/kZkgNOdeL7uZIZQ8U08+J3fAYarhnpGJs2oQV1O4SApsCX
         PC/9nToEceK6T1trXnBb28AfF1kW71mgPIBn6Veh6DtjSKajZGbXu4zugw6D+CITuP+o
         ebtYJYjyt9NxCJfaamfgzw71Uuq4wnRcfnf18jR6talDlatgk2eMaLiB1EBCtjegApVW
         nL1w==
X-Gm-Message-State: AOAM531xctivq2TeXWr+jS6w5LbDf9O+WRECmqZylMLvC7unopRYFfmg
        yBOPBH5TkPM16bxF8vzyIWpqYQ==
X-Google-Smtp-Source: ABdhPJyYL9A7b9Eq9H2YA+sOCWRW25ucZlQtBHk+GLvqCYdvPljMLdHOrNVkUrPOkTAZFApgB75bJQ==
X-Received: by 2002:a17:90b:388c:b0:1df:cb4b:3e72 with SMTP id mu12-20020a17090b388c00b001dfcb4b3e72mr7391714pjb.130.1653435410036;
        Tue, 24 May 2022 16:36:50 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id t11-20020a17090abc4b00b001df54d74adbsm272232pjv.25.2022.05.24.16.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 16:36:49 -0700 (PDT)
Message-ID: <79d17b10-3532-57d4-e70c-3ccf1ab0d87d@bytedance.com>
Date:   Wed, 25 May 2022 07:32:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>, david@redhat.com
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com, mst@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-4-pizhenwei@bytedance.com>
 <Yo0zmP28FqpivlxF@google.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <Yo0zmP28FqpivlxF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/22 03:35, Sean Christopherson wrote:
> On Fri, May 20, 2022, zhenwei pi wrote:
>> @@ -59,6 +60,12 @@ enum virtio_balloon_config_read {
>>   	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
>>   };
>>   
>> +/* the request body to commucate with host side */
>> +struct __virtio_balloon_recover {
>> +	struct virtio_balloon_recover vbr;
>> +	__virtio32 pfns[VIRTIO_BALLOON_PAGES_PER_PAGE];
> 
> I assume this is copied from virtio_balloon.pfns, which also uses __virtio32, but
> isn't that horribly broken?  PFNs are 'unsigned long', i.e. 64 bits on 64-bit kernels.
> x86-64 at least most definitely generates 64-bit PFNs.  Unless there's magic I'm
> missing, page_to_balloon_pfn() will truncate PFNs and feed the host bad info.
> 

Yes, I also noticed this point, I suppose the balloon device can not 
work on a virtual machine which has physical address larger than 16T.

I still let the recover VQ keep aligned with the inflate VQ and deflate 
VQ. I prefer the recover VQ to be workable/unworkable with 
inflate/deflate VQ together. So I leave this to the virtio balloon 
maintainer to decide ...

>> @@ -494,6 +511,198 @@ static void update_balloon_size_func(struct work_struct *work)
>>   		queue_work(system_freezable_wq, work);
>>   }
>>   
>> +/*
>> + * virtballoon_memory_failure - notified by memory failure, try to fix the
>> + *                              corrupted page.
>> + * The memory failure notifier is designed to call back when the kernel handled
>> + * successfully only, WARN_ON_ONCE on the unlikely condition to find out any
>> + * error(memory error handling is a best effort, not 100% coverd).
>> + */
>> +static int virtballoon_memory_failure(struct notifier_block *notifier,
>> +				      unsigned long pfn, void *parm)
>> +{
>> +	struct virtio_balloon *vb = container_of(notifier, struct virtio_balloon,
>> +						 memory_failure_nb);
>> +	struct page *page;
>> +	struct __virtio_balloon_recover *out_vbr;
>> +	struct scatterlist sg;
>> +	unsigned long flags;
>> +	int err;
>> +
>> +	page = pfn_to_online_page(pfn);
>> +	if (WARN_ON_ONCE(!page))
>> +		return NOTIFY_DONE;
>> +
>> +	if (PageHuge(page))
>> +		return NOTIFY_DONE;
>> +
>> +	if (WARN_ON_ONCE(!PageHWPoison(page)))
>> +		return NOTIFY_DONE;
>> +
>> +	if (WARN_ON_ONCE(page_count(page) != 1))
>> +		return NOTIFY_DONE;
>> +
>> +	get_page(page); /* balloon reference */
>> +
>> +	out_vbr = kzalloc(sizeof(*out_vbr), GFP_KERNEL);
>> +	if (WARN_ON_ONCE(!out_vbr))
>> +		return NOTIFY_BAD;
> 
> Not that it truly matters, but won't failure at this point leak the poisoned page?

I'll fix this, thanks!

-- 
zhenwei pi
