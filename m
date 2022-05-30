Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE2F537ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiE3Mvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiE3Mvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:51:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DE0279
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:51:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m14-20020a17090a414e00b001df77d29587so13671465pjg.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZvzQrzGqX0fJW9mWiWfNdI5A2ruzfhQVGGg4PFZYL8Y=;
        b=5LTfDx+bkaTCFM5Negv4ttvuFWwAThetWZq9GeHLSuU8N31iQe1v8qXouG9NSNS0T6
         Ldm0sm18jhB1MBs9eYRRV7f1xbyELfqCVplUXoMX5P8rOuax3m7DbYSS3HH2p+0C2wXA
         25cTRL8bfAHIi1ohekGqUvVk5YCD0/RQk4GlG7kF6iC+nDlmqLXH48VoPgZx8eQzyXfE
         XX4R12kZTezWJnw+cM1ZBL/I6AzA0V/7qEI9H850um38DokHxOMHJ2mbMcpGIq2TUcBZ
         UuCPKXlnmfjHYemIDioZETjyYo67acLvfOdphzCFSLNjKWFn7fWOPl6fUo4D5TWaxJNI
         9pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZvzQrzGqX0fJW9mWiWfNdI5A2ruzfhQVGGg4PFZYL8Y=;
        b=OlRkjTd/yIIM6kFeSZREqoasnCti/HgZ/PK2BPYld+lgJHvXS9uuH0u/NUFpnK/6CT
         k5+i4ego46yABmH6igEzBZNTXkQvQyH/2kRgy8IyIqjI9D9RdzP1QEocx/71vb9fPay7
         fVyErYV8CQo7g/zc+c+O6kksELOTcD4tVDwjn9td9AJh7l3hOAQe8XW+sDnagpkpvRc6
         NIde/n+BIxoim4pSDEr1xEyp+Lo6a7n1Nk8RsPXYCd4si12+eHTueCtDOV6F+zrKz9uR
         dyl09Unq75+ZtpWf3lilBh8FyNIrIbQa4QZyS+84Fltgl7Cl/uqgSzU6ch+OvYPoISUr
         Biaw==
X-Gm-Message-State: AOAM531bzuPRLtKZYhX0DIh25Az7DQHFdoMMqYFkyDWSdGT7OfIg/43K
        SGIaYgiCRmSlKBeHG9QkIS2xpqdL+vFE3Q==
X-Google-Smtp-Source: ABdhPJwTiynlgnZijOQCrJvfmuzkL14Lu9xuJdj0+djeOHFAyAPupu8F5badEOZlrtCuCzbEYSTGWw==
X-Received: by 2002:a17:902:7b8f:b0:162:467:db7c with SMTP id w15-20020a1709027b8f00b001620467db7cmr43791860pll.140.1653915094829;
        Mon, 30 May 2022 05:51:34 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001624dab05edsm9341931plf.8.2022.05.30.05.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 05:51:34 -0700 (PDT)
Message-ID: <e870424d-da27-b369-7406-27f7f2983428@bytedance.com>
Date:   Mon, 30 May 2022 20:47:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-4-pizhenwei@bytedance.com>
 <612e42f7-1a97-9b01-2d45-d4661911e7a8@redhat.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <612e42f7-1a97-9b01-2d45-d4661911e7a8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 15:48, David Hildenbrand wrote:
> 
>> +
>>   struct virtio_balloon {
>>   	struct virtio_device *vdev;
>>   	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
>> @@ -126,6 +133,16 @@ struct virtio_balloon {
>>   	/* Free page reporting device */
>>   	struct virtqueue *reporting_vq;
>>   	struct page_reporting_dev_info pr_dev_info;
>> +
>> +	/* Memory recover VQ - VIRTIO_BALLOON_F_RECOVER */
>> +	struct virtqueue *recover_vq;
>> +	spinlock_t recover_vq_lock;
>> +	struct notifier_block memory_failure_nb;
>> +	struct list_head corrupted_page_list;
>> +	struct list_head recovered_page_list;
>> +	spinlock_t recover_page_list_lock;
>> +	struct __virtio_balloon_recover in_vbr;
>> +	struct work_struct unpoison_memory_work;
> 
> I assume we want all that only with CONFIG_MEMORY_FAILURE.
> 

Sorry, I missed this.

>>   };
>>   
>>   static const struct virtio_device_id id_table[] = {
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
> 
> Relying on the page_count to be 1 for correctness is usually a bit
> shaky, for example, when racing against isolate_movable_page() that
> might temporarily bump upo the refcount.
> 

The memory notifier is designed to call the chain if a page gets result 
MF_RECOVERED only:
      if (result == MF_RECOVERED)
          blocking_notifier_call_chain(&mf_notifier_list, pfn, NULL);


>> +
>> +	get_page(page); /* balloon reference */
>> +
>> +	out_vbr = kzalloc(sizeof(*out_vbr), GFP_KERNEL);
> 
> Are we always guaranteed to be able to use GFP_KERNEL out of MCE
> context? (IOW, are we never atomic?)
> 
>> +	if (WARN_ON_ONCE(!out_vbr))
>> +		return NOTIFY_BAD;
>> +
>> +	spin_lock(&vb->recover_page_list_lock);
>> +	balloon_page_push(&vb->corrupted_page_list, page);
>> +	spin_unlock(&vb->recover_page_list_lock);
>> +
>> +	out_vbr->vbr.cmd = VIRTIO_BALLOON_R_CMD_RECOVER;
> 
> This makes me wonder if we should have a more generic guest->host
> request queue, similar to what e.g., virtio-mem uses, instead of adding
> a separate VIRTIO_BALLOON_VQ_RECOVER vq.
> 

I'm OK with either one, I'll follow your decision! :D

>> +	set_page_pfns(vb, out_vbr->pfns, page);
>> +	sg_init_one(&sg, out_vbr, sizeof(*out_vbr));
>> +
>> +	spin_lock_irqsave(&vb->recover_vq_lock, flags);
>> +	err = virtqueue_add_outbuf(vb->recover_vq, &sg, 1, out_vbr, GFP_KERNEL);
>> +	if (unlikely(err)) {
>> +		spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
>> +		return NOTIFY_DONE;
>> +	}
>> +	virtqueue_kick(vb->recover_vq);
>> +	spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static int recover_vq_get_response(struct virtio_balloon *vb)
>> +{
>> +	struct __virtio_balloon_recover *in_vbr;
>> +	struct scatterlist sg;
>> +	unsigned long flags;
>> +	int err;
>> +
>> +	spin_lock_irqsave(&vb->recover_vq_lock, flags);
>> +	in_vbr = &vb->in_vbr;
>> +	memset(in_vbr, 0x00, sizeof(*in_vbr));
>> +	sg_init_one(&sg, in_vbr, sizeof(*in_vbr));
>> +	err = virtqueue_add_inbuf(vb->recover_vq, &sg, 1, in_vbr, GFP_KERNEL);
>> +	if (unlikely(err)) {
>> +		spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
>> +		return err;
>> +	}
>> +
>> +	virtqueue_kick(vb->recover_vq);
>> +	spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static void recover_vq_handle_response(struct virtio_balloon *vb, unsigned int len)
>> +{
>> +	struct __virtio_balloon_recover *in_vbr;
>> +	struct virtio_balloon_recover *vbr;
>> +	struct page *page;
>> +	unsigned int pfns;
>> +	u32 pfn0, pfn1;
>> +	__u8 status;
>> +
>> +	/* the response is not expected */
>> +	if (unlikely(len != sizeof(struct __virtio_balloon_recover)))
>> +		return;
>> +
>> +	in_vbr = &vb->in_vbr;
>> +	vbr = &in_vbr->vbr;
>> +	if (unlikely(vbr->cmd != VIRTIO_BALLOON_R_CMD_RESPONSE))
>> +		return;
>> +
>> +	/* to make sure the contiguous balloon PFNs */
>> +	for (pfns = 1; pfns < VIRTIO_BALLOON_PAGES_PER_PAGE; pfns++) {
>> +		pfn0 = virtio32_to_cpu(vb->vdev, in_vbr->pfns[pfns - 1]);
>> +		pfn1 = virtio32_to_cpu(vb->vdev, in_vbr->pfns[pfns]);
>> +		if (pfn1 - pfn0 != 1)
>> +			return;
> 
> Yeah, we really shouldn't be dealing with (legacy) 4k PFNs here, but
> instead, proper ranges I guess.
> 

MST also pointed out this, I explained in this link:
https://lkml.org/lkml/2022/5/26/942

Rather than page reporting style, virtio-mem style should be fine. Ex,
struct virtio_memory_recover {
         __virtio64 addr;
         __virtio32 length;
         __virtio16 padding[2];
};

>> +	}
>> +
>> +	pfn0 = virtio32_to_cpu(vb->vdev, in_vbr->pfns[0]);
>> +	if (!pfn_valid(pfn0))
>> +		return;
>> +
>> +	pfn1 = -1;
>> +	spin_lock(&vb->recover_page_list_lock);
>> +	list_for_each_entry(page, &vb->corrupted_page_list, lru) {
>> +		pfn1 = page_to_pfn(page);
>> +		if (pfn1 == pfn0)
>> +			break;
>> +	}
>> +	spin_unlock(&vb->recover_page_list_lock);
>> +
>> +	status = vbr->status;
>> +	switch (status) {
>> +	case VIRTIO_BALLOON_R_STATUS_RECOVERED:
>> +		if (pfn1 == pfn0) {
>> +			spin_lock(&vb->recover_page_list_lock);
>> +			list_del(&page->lru);
>> +			balloon_page_push(&vb->recovered_page_list, page);
> 
> We rather not reuse actual balloon functions in !balloon context. Just
> move the page to the proper list directly.
> 

OK.

>> +			spin_unlock(&vb->recover_page_list_lock);
>> +			queue_work(system_freezable_wq, &vb->unpoison_memory_work);
>> +			dev_info_ratelimited(&vb->vdev->dev, "recovered pfn 0x%x", pfn0);
> 
> Well, not yet. Shouldn't this go into unpoison_memory_func() ?
> 

OK.

[...]

> 
>>   
>> +out_unregister_reporting:
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
>> +		page_reporting_unregister(&vb->pr_dev_info);
>>   out_unregister_oom:
>>   	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>>   		unregister_oom_notifier(&vb->oom_nb);
>> @@ -1082,6 +1319,11 @@ static void virtballoon_remove(struct virtio_device *vdev)
>>   		destroy_workqueue(vb->balloon_wq);
>>   	}
>>   
>> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_RECOVER)) {
> 
> Could the notifier already have been triggered and we might be using the
> device before already fully initialized from the notifier and might end
> up leaking memory here that we allocated?
> 
>> +		unregister_memory_failure_notifier(&vb->memory_failure_nb);
>> +		cancel_work_sync(&vb->unpoison_memory_work);
>> +	}
>> +
> 
> Could we be leaking memory from the virtballoon_remove() path?
> 

Yes, I'll fix the possible memory leak here.

Thanks a lot.

-- 
zhenwei pi
