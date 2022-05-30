Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5ABC5375DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiE3Hsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiE3Hsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 098AB71D8B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653896902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEMVsNOAzZKL9Irxm9eBIY6vcqLvs7dAXVbpmQP/bfk=;
        b=By7Gerwzvy7p9dkcdKexj+Zg3fGRZ49UqudzF8ejpu5tIIJ8Wc2/4b+lbLKJDzcRhHgDDW
        63mVxegXdDNYZVfTYBH5HeJ0C9/jvOlOArMbLjF0OpzcD+TelsYmBjPR41lxRROsrSnMwE
        DszSt6X/eYAolZiKR9BMWe+AEQDK7Ro=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-J26GZ1GhPMCU740ltIXXRw-1; Mon, 30 May 2022 03:48:13 -0400
X-MC-Unique: J26GZ1GhPMCU740ltIXXRw-1
Received: by mail-wr1-f69.google.com with SMTP id bt14-20020a056000080e00b002100d89c219so1402058wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=PEMVsNOAzZKL9Irxm9eBIY6vcqLvs7dAXVbpmQP/bfk=;
        b=FTjKpzzzAY8Ui9H9Pg5rFzw6j6FXv0i+LQsGqospsvvuA8jAOrHxdtKMfeM2ZExlYN
         fDdt84/2S7104jWldMZYi8xEpYCZZiGNotniPUpyQYgOJK5r6FQDcorwtaWJ2BZhn3ep
         bihVJs7Zwy1pGDcfE0q0qQoenyjpllf2QwpMMZISY4qIDorB/UbTmTGUC3C4QZk/pW8/
         wv1k4mC89BN94GLB3EWtjaUy3BpWqG3JiQgZUggIflpTmWo0j649Wu3qKqdTik5gpTml
         QGA+QLzIYxz4v1tTiMPjirYeo7NTNfC1Eaovms3N7ysxCSWYlPiLqtpsmfnhr7s4ujSl
         DgRg==
X-Gm-Message-State: AOAM531zeHNjamxyG5QiYbym/edbxYne9L1GE7DUo9dwOa2Ue+rDpNRV
        U6yJCBnr+lhRGwSU5DXvHLHANr+imU0y7sneLMZ99ni+2Nzoz7/2DWSxh/Z7ArbpZ9zjFf71NeE
        yceC/vDJD5+Du9Y1vNC3zWDeP
X-Received: by 2002:adf:d1c4:0:b0:210:1935:3dd8 with SMTP id b4-20020adfd1c4000000b0021019353dd8mr12366049wrd.229.1653896892002;
        Mon, 30 May 2022 00:48:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNPExjXLN7wQlflrPRtntRQrkaNjM7MUf8QcWcvv9S4BcH43wTUtjdzSQBAqMJnsRF+swHNw==
X-Received: by 2002:adf:d1c4:0:b0:210:1935:3dd8 with SMTP id b4-20020adfd1c4000000b0021019353dd8mr12366031wrd.229.1653896891745;
        Mon, 30 May 2022 00:48:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736? (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de. [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
        by smtp.gmail.com with ESMTPSA id b14-20020a056000054e00b0021023877ac5sm5990344wrf.107.2022.05.30.00.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:48:11 -0700 (PDT)
Message-ID: <612e42f7-1a97-9b01-2d45-d4661911e7a8@redhat.com>
Date:   Mon, 30 May 2022 09:48:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, mst@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-4-pizhenwei@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
In-Reply-To: <20220520070648.1794132-4-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +
>  struct virtio_balloon {
>  	struct virtio_device *vdev;
>  	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
> @@ -126,6 +133,16 @@ struct virtio_balloon {
>  	/* Free page reporting device */
>  	struct virtqueue *reporting_vq;
>  	struct page_reporting_dev_info pr_dev_info;
> +
> +	/* Memory recover VQ - VIRTIO_BALLOON_F_RECOVER */
> +	struct virtqueue *recover_vq;
> +	spinlock_t recover_vq_lock;
> +	struct notifier_block memory_failure_nb;
> +	struct list_head corrupted_page_list;
> +	struct list_head recovered_page_list;
> +	spinlock_t recover_page_list_lock;
> +	struct __virtio_balloon_recover in_vbr;
> +	struct work_struct unpoison_memory_work;

I assume we want all that only with CONFIG_MEMORY_FAILURE.

>  };
>  
>  static const struct virtio_device_id id_table[] = {
> @@ -494,6 +511,198 @@ static void update_balloon_size_func(struct work_struct *work)
>  		queue_work(system_freezable_wq, work);
>  }
>  
> +/*
> + * virtballoon_memory_failure - notified by memory failure, try to fix the
> + *                              corrupted page.
> + * The memory failure notifier is designed to call back when the kernel handled
> + * successfully only, WARN_ON_ONCE on the unlikely condition to find out any
> + * error(memory error handling is a best effort, not 100% coverd).
> + */
> +static int virtballoon_memory_failure(struct notifier_block *notifier,
> +				      unsigned long pfn, void *parm)
> +{
> +	struct virtio_balloon *vb = container_of(notifier, struct virtio_balloon,
> +						 memory_failure_nb);
> +	struct page *page;
> +	struct __virtio_balloon_recover *out_vbr;
> +	struct scatterlist sg;
> +	unsigned long flags;
> +	int err;
> +
> +	page = pfn_to_online_page(pfn);
> +	if (WARN_ON_ONCE(!page))
> +		return NOTIFY_DONE;
> +
> +	if (PageHuge(page))
> +		return NOTIFY_DONE;
> +
> +	if (WARN_ON_ONCE(!PageHWPoison(page)))
> +		return NOTIFY_DONE;
> +
> +	if (WARN_ON_ONCE(page_count(page) != 1))
> +		return NOTIFY_DONE;

Relying on the page_count to be 1 for correctness is usually a bit
shaky, for example, when racing against isolate_movable_page() that
might temporarily bump upo the refcount.

> +
> +	get_page(page); /* balloon reference */
> +
> +	out_vbr = kzalloc(sizeof(*out_vbr), GFP_KERNEL);

Are we always guaranteed to be able to use GFP_KERNEL out of MCE
context? (IOW, are we never atomic?)

> +	if (WARN_ON_ONCE(!out_vbr))
> +		return NOTIFY_BAD;
> +
> +	spin_lock(&vb->recover_page_list_lock);
> +	balloon_page_push(&vb->corrupted_page_list, page);
> +	spin_unlock(&vb->recover_page_list_lock);
> +
> +	out_vbr->vbr.cmd = VIRTIO_BALLOON_R_CMD_RECOVER;

This makes me wonder if we should have a more generic guest->host
request queue, similar to what e.g., virtio-mem uses, instead of adding
a separate VIRTIO_BALLOON_VQ_RECOVER vq.

> +	set_page_pfns(vb, out_vbr->pfns, page);
> +	sg_init_one(&sg, out_vbr, sizeof(*out_vbr));
> +
> +	spin_lock_irqsave(&vb->recover_vq_lock, flags);
> +	err = virtqueue_add_outbuf(vb->recover_vq, &sg, 1, out_vbr, GFP_KERNEL);
> +	if (unlikely(err)) {
> +		spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
> +		return NOTIFY_DONE;
> +	}
> +	virtqueue_kick(vb->recover_vq);
> +	spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int recover_vq_get_response(struct virtio_balloon *vb)
> +{
> +	struct __virtio_balloon_recover *in_vbr;
> +	struct scatterlist sg;
> +	unsigned long flags;
> +	int err;
> +
> +	spin_lock_irqsave(&vb->recover_vq_lock, flags);
> +	in_vbr = &vb->in_vbr;
> +	memset(in_vbr, 0x00, sizeof(*in_vbr));
> +	sg_init_one(&sg, in_vbr, sizeof(*in_vbr));
> +	err = virtqueue_add_inbuf(vb->recover_vq, &sg, 1, in_vbr, GFP_KERNEL);
> +	if (unlikely(err)) {
> +		spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
> +		return err;
> +	}
> +
> +	virtqueue_kick(vb->recover_vq);
> +	spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
> +
> +	return 0;
> +}
> +
> +static void recover_vq_handle_response(struct virtio_balloon *vb, unsigned int len)
> +{
> +	struct __virtio_balloon_recover *in_vbr;
> +	struct virtio_balloon_recover *vbr;
> +	struct page *page;
> +	unsigned int pfns;
> +	u32 pfn0, pfn1;
> +	__u8 status;
> +
> +	/* the response is not expected */
> +	if (unlikely(len != sizeof(struct __virtio_balloon_recover)))
> +		return;
> +
> +	in_vbr = &vb->in_vbr;
> +	vbr = &in_vbr->vbr;
> +	if (unlikely(vbr->cmd != VIRTIO_BALLOON_R_CMD_RESPONSE))
> +		return;
> +
> +	/* to make sure the contiguous balloon PFNs */
> +	for (pfns = 1; pfns < VIRTIO_BALLOON_PAGES_PER_PAGE; pfns++) {
> +		pfn0 = virtio32_to_cpu(vb->vdev, in_vbr->pfns[pfns - 1]);
> +		pfn1 = virtio32_to_cpu(vb->vdev, in_vbr->pfns[pfns]);
> +		if (pfn1 - pfn0 != 1)
> +			return;

Yeah, we really shouldn't be dealing with (legacy) 4k PFNs here, but
instead, proper ranges I guess.

> +	}
> +
> +	pfn0 = virtio32_to_cpu(vb->vdev, in_vbr->pfns[0]);
> +	if (!pfn_valid(pfn0))
> +		return;
> +
> +	pfn1 = -1;
> +	spin_lock(&vb->recover_page_list_lock);
> +	list_for_each_entry(page, &vb->corrupted_page_list, lru) {
> +		pfn1 = page_to_pfn(page);
> +		if (pfn1 == pfn0)
> +			break;
> +	}
> +	spin_unlock(&vb->recover_page_list_lock);
> +
> +	status = vbr->status;
> +	switch (status) {
> +	case VIRTIO_BALLOON_R_STATUS_RECOVERED:
> +		if (pfn1 == pfn0) {
> +			spin_lock(&vb->recover_page_list_lock);
> +			list_del(&page->lru);
> +			balloon_page_push(&vb->recovered_page_list, page);

We rather not reuse actual balloon functions in !balloon context. Just
move the page to the proper list directly.

> +			spin_unlock(&vb->recover_page_list_lock);
> +			queue_work(system_freezable_wq, &vb->unpoison_memory_work);
> +			dev_info_ratelimited(&vb->vdev->dev, "recovered pfn 0x%x", pfn0);

Well, not yet. Shouldn't this go into unpoison_memory_func() ?

> +		}
> +		break;
> +	case VIRTIO_BALLOON_R_STATUS_FAILED:
> +		/* the hypervisor can't fix this corrupted page, balloon puts page */
> +		if (pfn1 == pfn0) {
> +			spin_lock(&vb->recover_page_list_lock);
> +			list_del(&page->lru);
> +			spin_unlock(&vb->recover_page_list_lock);
> +			put_page(page);
> +			dev_info_ratelimited(&vb->vdev->dev, "failed to recover pfn 0x%x", pfn0);
> +		}
> +	default:
> +		break;
> +	};
> +
> +	/* continue to get response from host side if the response gets handled successfully */
> +	recover_vq_get_response(vb);
> +}
> +
> +static void unpoison_memory_func(struct work_struct *work)
> +{
> +	struct virtio_balloon *vb;
> +	struct page *page;
> +
> +	vb = container_of(work, struct virtio_balloon, unpoison_memory_work);
> +
> +	do {
> +		spin_lock(&vb->recover_page_list_lock);
> +		page = list_first_entry_or_null(&vb->recovered_page_list,
> +						struct page, lru);
> +		if (page)
> +			list_del(&page->lru);
> +		spin_unlock(&vb->recover_page_list_lock);
> +
> +		if (page) {
> +			put_page(page);
> +			unpoison_memory(page_to_pfn(page), true, "virtio-balloon");
> +		}
> +	} while (page);
> +}
> +
> +static void recover_vq_cb(struct virtqueue *vq)
> +{
> +	struct virtio_balloon *vb = vq->vdev->priv;
> +	struct __virtio_balloon_recover *vbr;
> +	unsigned long flags;
> +	unsigned int len;
> +
> +	spin_lock_irqsave(&vb->recover_vq_lock, flags);
> +	do {
> +		virtqueue_disable_cb(vq);
> +		while ((vbr = virtqueue_get_buf(vq, &len)) != NULL) {
> +			spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
> +			if (vbr == &vb->in_vbr)
> +				recover_vq_handle_response(vb, len);
> +			else
> +				kfree(vbr); /* just free the memory for out vbr request */
> +			spin_lock_irqsave(&vb->recover_vq_lock, flags);
> +		}
> +	} while (!virtqueue_enable_cb(vq));
> +	spin_unlock_irqrestore(&vb->recover_vq_lock, flags);
> +}
> +


[...]

>  
> +out_unregister_reporting:
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> +		page_reporting_unregister(&vb->pr_dev_info);
>  out_unregister_oom:
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>  		unregister_oom_notifier(&vb->oom_nb);
> @@ -1082,6 +1319,11 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  		destroy_workqueue(vb->balloon_wq);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_RECOVER)) {

Could the notifier already have been triggered and we might be using the
device before already fully initialized from the notifier and might end
up leaking memory here that we allocated?

> +		unregister_memory_failure_notifier(&vb->memory_failure_nb);
> +		cancel_work_sync(&vb->unpoison_memory_work);
> +	}
> +

Could we be leaking memory from the virtballoon_remove() path?

-- 
Thanks,

David / dhildenb

