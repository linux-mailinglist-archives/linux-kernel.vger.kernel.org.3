Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D4F5353D6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345604AbiEZTTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbiEZTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9F312980C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653592739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fyUFbFkju6fcdlgLhkLBlS8xfqObP17OZdzXoe7ozug=;
        b=JE0AJ8JOaWs/8SIWQironU1oRg0Oz9VSP+54PnuJYZHkQ5Hzs+PvBwStKdxn3E686o/U8k
        4pcLrA+RSjSOcxEHQVHfuBdkoZvNCU9UlwUXpf+1NQfxf9eSL41mISqWTEMP/r4O3+w2fa
        dIpxJ/EXPm3vfiJV6+8oRcAxa+Iozwo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-UWrAHxIxPH24Q7QrI5Ow6Q-1; Thu, 26 May 2022 15:18:58 -0400
X-MC-Unique: UWrAHxIxPH24Q7QrI5Ow6Q-1
Received: by mail-ej1-f69.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso1284304ejc.18
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fyUFbFkju6fcdlgLhkLBlS8xfqObP17OZdzXoe7ozug=;
        b=a6hSAhtzKtzLhw6mu56gPaqm4Q0OBgVZkMjEqm1BGrvbVEHZ3FksUOdV8E+/+xevui
         Y9uDdZxkZEcRaFI21GsQUrn6BRLZ1Pa+oF5rCcSqkhldHox3vX3PSYiFx8hEsQ3A/9zX
         g6LgAmpzC13HfFCv4rcwOzA718it/eQYcwqN0XcMS1/wT5/+/kidGkCcfC982adDugD2
         wI3CHyfTaxgYgdIQCEm+kReCPUpov0wf9qYk6rvZUPSUV/t+v2zrGSD+jrRPFu/ScG4i
         NEq0cG5c85ZZFjuXHFYxl30cV4v2rkno1XccxVB79dCno6Ao5Ws2QkFf38HqhRk2rn/T
         GatA==
X-Gm-Message-State: AOAM53335nEiffjnL1Q2/fq2K3autl3eCEEcKZoPoypF9QVdU1/9u3fW
        4nS6guiRmXbVghZFWv4yAyr22LK17dXaLgQDZx02RZX4U1eIEQ6NYsTQsV5P+h1PipU7QjJpaG7
        v1kgla6B5z857jXhM9A8QFSdx
X-Received: by 2002:a17:907:3e8d:b0:6fe:d99b:90a with SMTP id hs13-20020a1709073e8d00b006fed99b090amr20706823ejc.416.1653592737220;
        Thu, 26 May 2022 12:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5y+Z0TuPGB18o6k7alTPdxdPy4itPmkAYi6cWwTiPJlyGiMpV97qNgiMr6KzI8oJqVN5HzQ==
X-Received: by 2002:a17:907:3e8d:b0:6fe:d99b:90a with SMTP id hs13-20020a1709073e8d00b006fed99b090amr20706802ejc.416.1653592736901;
        Thu, 26 May 2022 12:18:56 -0700 (PDT)
Received: from redhat.com ([2.55.45.143])
        by smtp.gmail.com with ESMTPSA id w15-20020a05640234cf00b0042ab1735552sm10039edc.66.2022.05.26.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 12:18:55 -0700 (PDT)
Date:   Thu, 26 May 2022 15:18:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Message-ID: <20220526151507-mutt-send-email-mst@kernel.org>
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520070648.1794132-4-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 03:06:48PM +0800, zhenwei pi wrote:
> Introduce a new queue 'recover VQ', this allows guest to recover
> hardware corrupted page:
> 
> Guest              5.MF -> 6.RVQ FE    10.Unpoison page
>                     /           \            /
> -------------------+-------------+----------+-----------
>                    |             |          |
>                 4.MCE        7.RVQ BE   9.RVQ Event
>  QEMU             /               \       /
>              3.SIGBUS              8.Remap
>                 /
> ----------------+------------------------------------
>                 |
>             +--2.MF
>  Host       /
>        1.HW error
> 
> The workflow:
> 1, HardWare page error occurs randomly.
> 2, host side handles corrupted page by Memory Failure mechanism, sends
>    SIGBUS to the user process if early-kill is enabled.
> 3, QEMU handles SIGBUS, if the address belongs to guest RAM, then:
> 4, QEMU tries to inject MCE into guest.
> 5, guest handles memory failure again.
> 
> 1-5 is already supported for a long time, the next steps are supported
> in this patch(also related driver patch):
> 6, guest balloon driver gets noticed of the corrupted PFN, and sends
>    request to host side by Recover VQ FrontEnd.
> 7, QEMU handles request from Recover VQ BackEnd, then:
> 8, QEMU remaps the corrupted HVA fo fix the memory failure, then:
> 9, QEMU acks the guest side the result by Recover VQ.
> 10, guest unpoisons the page if the corrupted page gets recoverd
>     successfully.
> 
> Then the guest fixes the HW page error dynamiclly without rebooting.
> 
> Emulate MCE by QEMU, the guest works fine:
>  mce: [Hardware Error]: Machine check events logged
>  Memory failure: 0x61646: recovery action for dirty LRU page: Recovered
>  virtio_balloon virtio5: recovered pfn 0x61646
>  Unpoison: Unpoisoned page 0x61646 by virtio-balloon
>  MCE: Killing stress:24502 due to hardware memory corruption fault at 7f5be2e5a010
> 
> The 'HardwareCorrupted' in /proc/meminfo also shows 0 kB.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 243 ++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_balloon.h |  16 ++
>  2 files changed, 259 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f4c34a2a6b8e..f9d95d1d8a4d 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -52,6 +52,7 @@ enum virtio_balloon_vq {
>  	VIRTIO_BALLOON_VQ_STATS,
>  	VIRTIO_BALLOON_VQ_FREE_PAGE,
>  	VIRTIO_BALLOON_VQ_REPORTING,
> +	VIRTIO_BALLOON_VQ_RECOVER,
>  	VIRTIO_BALLOON_VQ_MAX
>  };
>  
> @@ -59,6 +60,12 @@ enum virtio_balloon_config_read {
>  	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
>  };
>  
> +/* the request body to commucate with host side */
> +struct __virtio_balloon_recover {
> +	struct virtio_balloon_recover vbr;
> +	__virtio32 pfns[VIRTIO_BALLOON_PAGES_PER_PAGE];
> +};
> +


I don't think this idea of passing 32 bit pfns is going to fly.
What is wrong with just passing the pages normally as a s/g list?
this is what is done for the hints at the moment.

neither should you use __virtio types for new functionality
(should all be __le), nor use __virtio for the struct name.



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

covered

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
> +
> +	get_page(page); /* balloon reference */
> +
> +	out_vbr = kzalloc(sizeof(*out_vbr), GFP_KERNEL);
> +	if (WARN_ON_ONCE(!out_vbr))
> +		return NOTIFY_BAD;
> +
> +	spin_lock(&vb->recover_page_list_lock);
> +	balloon_page_push(&vb->corrupted_page_list, page);
> +	spin_unlock(&vb->recover_page_list_lock);
> +
> +	out_vbr->vbr.cmd = VIRTIO_BALLOON_R_CMD_RECOVER;
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
> +			spin_unlock(&vb->recover_page_list_lock);
> +			queue_work(system_freezable_wq, &vb->unpoison_memory_work);
> +			dev_info_ratelimited(&vb->vdev->dev, "recovered pfn 0x%x", pfn0);
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
>  static int init_vqs(struct virtio_balloon *vb)
>  {
>  	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
> @@ -515,6 +724,7 @@ static int init_vqs(struct virtio_balloon *vb)
>  	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>  	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>  	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
> +	names[VIRTIO_BALLOON_VQ_RECOVER] = NULL;
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>  		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
> @@ -531,6 +741,11 @@ static int init_vqs(struct virtio_balloon *vb)
>  		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
>  	}
>  
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_RECOVER)) {
> +		names[VIRTIO_BALLOON_VQ_RECOVER] = "recover_vq";
> +		callbacks[VIRTIO_BALLOON_VQ_RECOVER] = recover_vq_cb;
> +	}
> +
>  	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
>  			      callbacks, names, NULL);
>  	if (err)
> @@ -566,6 +781,9 @@ static int init_vqs(struct virtio_balloon *vb)
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
>  		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
>  
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_RECOVER))
> +		vb->recover_vq = vqs[VIRTIO_BALLOON_VQ_RECOVER];
> +
>  	return 0;
>  }
>  
> @@ -1015,12 +1233,31 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  			goto out_unregister_oom;
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_RECOVER)) {
> +		err = recover_vq_get_response(vb);
> +		if (err)
> +			goto out_unregister_reporting;
> +
> +		vb->memory_failure_nb.notifier_call = virtballoon_memory_failure;
> +		spin_lock_init(&vb->recover_page_list_lock);
> +		spin_lock_init(&vb->recover_vq_lock);
> +		INIT_LIST_HEAD(&vb->corrupted_page_list);
> +		INIT_LIST_HEAD(&vb->recovered_page_list);
> +		INIT_WORK(&vb->unpoison_memory_work, unpoison_memory_func);
> +		err = register_memory_failure_notifier(&vb->memory_failure_nb);
> +		if (err)
> +			goto out_unregister_reporting;
> +	}
> +
>  	virtio_device_ready(vdev);
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
>  	return 0;
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
> +		unregister_memory_failure_notifier(&vb->memory_failure_nb);
> +		cancel_work_sync(&vb->unpoison_memory_work);
> +	}
> +
>  	remove_common(vb);
>  #ifdef CONFIG_BALLOON_COMPACTION
>  	if (vb->vb_dev_info.inode)
> @@ -1147,6 +1389,7 @@ static unsigned int features[] = {
>  	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>  	VIRTIO_BALLOON_F_PAGE_POISON,
>  	VIRTIO_BALLOON_F_REPORTING,
> +	VIRTIO_BALLOON_F_RECOVER,
>  };
>  
>  static struct virtio_driver virtio_balloon_driver = {
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..41d0ffa2fb54 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_RECOVER	6 /* Memory recover virtqueue */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12

Please get this feature recorded in the spec with the virtio TC.
They will also ask you to supply minimal documentation.



> @@ -59,6 +60,8 @@ struct virtio_balloon_config {
>  	};
>  	/* Stores PAGE_POISON if page poisoning is in use */
>  	__le32 poison_val;
> +	/* Number of hardware corrupted pages, guest read only */
> +	__le32 corrupted_pages;
>  };
>  
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> @@ -116,4 +119,17 @@ struct virtio_balloon_stat {
>  	__virtio64 val;
>  } __attribute__((packed));
>  
> +#define VIRTIO_BALLOON_R_CMD_RECOVER      0
> +#define VIRTIO_BALLOON_R_CMD_RESPONSE     0x80
> +
> +#define VIRTIO_BALLOON_R_STATUS_CORRUPTED 0
> +#define VIRTIO_BALLOON_R_STATUS_RECOVERED 1
> +#define VIRTIO_BALLOON_R_STATUS_FAILED    2
> +
> +struct virtio_balloon_recover {
> +	__u8 cmd;
> +	__u8 status;
> +	__u8 padding[6];
> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */
> -- 
> 2.20.1

