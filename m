Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4124B1EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbiBKGtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:49:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbiBKGtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FCA310FF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644562154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqHQIWGXIFVxKI6GDzeMgJSaFCUeRQ0XbIBm2xgz2GI=;
        b=eIQ6OrmL4dpTIoOMNV7B6wDRTIsttS4kDc5ayJMvQOQ22v89CGja9/tPb9+J1uQPLsBxSx
        n09ZuJuy8fdmFmS2PAoaDsASoYiZ5YumlWE2ybGiaMeQisUj0cC9t5QOMLmnOCuWcRZcnc
        De7POG7rUOxPvrv9aMe2Va0Nbtof3Bo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-C19iD_PtMSiOaS2JToafBw-1; Fri, 11 Feb 2022 01:49:13 -0500
X-MC-Unique: C19iD_PtMSiOaS2JToafBw-1
Received: by mail-pj1-f69.google.com with SMTP id gj12-20020a17090b108c00b001b89b5f3dd4so7721808pjb.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QqHQIWGXIFVxKI6GDzeMgJSaFCUeRQ0XbIBm2xgz2GI=;
        b=GyFduLEbclu5XRNP8QHCXVrT8awEk8k31FyjKmBdG/BroeD+ozDAdCwMqsEZtzaBXk
         Bpieo0BPCSIohwddrR4AxXC0kxIVDBOq9D70Msb1C0VtBLux9uVLpsAq9dbW8o0bABxr
         8R2zb8rLekCCjWzT1LQWx4or5ch2t4oTeyJdg1FrDKuX0Lz/946jbUVJbwa7NjV8I9xI
         xKcdRStVzqgDohsBKxc2+RUm5XonoTYNka+/qgY2cgsD1cL3E9QE1F6MPt9STHIBK/Ri
         Ynw/Qeq/QAogQDDVdGDt54zDz22y08QBfwRIOIHvAivMzWrj8FvxWtYpF0x4QBob2a0w
         pI4w==
X-Gm-Message-State: AOAM532/D9hYyMgmCYwc7hWJeY8+6LlmLIPsqAf+R6HVFGGJVB2TGJ7S
        FDOEBsTnB2/R1pG0rBXF42xY3RAoms70bl+0kjsm9Lqt0Gawecj/pgOKREw9AViwcBHXlK7crDW
        tKaFFIItdWLAcNBaA7Stqv3rq
X-Received: by 2002:a17:90b:1c81:: with SMTP id oo1mr341212pjb.192.1644562151657;
        Thu, 10 Feb 2022 22:49:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlp7DVScBoR+0Irx9Zpl3LczX5pbJo/8fIM1kdX/BqalYu4Z3jVejXSwwGCrfFZDw2RLQUBw==
X-Received: by 2002:a17:90b:1c81:: with SMTP id oo1mr341190pjb.192.1644562151294;
        Thu, 10 Feb 2022 22:49:11 -0800 (PST)
Received: from [10.72.13.85] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f16sm27988160pfa.147.2022.02.10.22.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 22:49:10 -0800 (PST)
Message-ID: <140fc738-3391-5529-dd5a-c46b9e937355@redhat.com>
Date:   Fri, 11 Feb 2022 14:49:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v4 09/14] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <20220209122901.51790-10-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220209122901.51790-10-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/2/9 下午8:28, Xuan Zhuo 写道:
> Performing reset on a queue is divided into four steps:
>
> 1. reset_vq: reset one vq
> 2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> 3. release the ring of the vq by vring_release_virtqueue()
> 4. enable_reset_vq: re-enable the reset queue
>
> So add two callbacks reset_vq, enable_reset_vq to struct
> virtio_config_ops.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   include/linux/virtio_config.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 4d107ad31149..0d01a64f2576 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -74,6 +74,17 @@ struct virtio_shm_region {
>    * @set_vq_affinity: set the affinity for a virtqueue (optional).
>    * @get_vq_affinity: get the affinity for a virtqueue (optional).
>    * @get_shm_region: get a shared memory region based on the index.
> + * @reset_vq: reset a queue individually


This needs to be marked as optional I think.


> + *	vq: the virtqueue
> + *	Returns 0 on success or error status


It looks to me the caller should also guarantee that the vring is not 
accsed by any functions e.g NAPI.


> + *	After successfully calling this, be sure to call
> + *	virtqueue_detach_unused_buf() to recycle the buffer in the ring, and
> + *	then call vring_release_virtqueue() to release the vq ring.
> + * @enable_reset_vq: enable a reset queue
> + *	vq: the virtqueue
> + *	ring_num: specify ring num for the vq to be re-enabled. 0 means use the
> + *	          default value. MUST be a power of 2.


Note that we don't have power of 2 requirement for packed virtqueue.

And I wonder if it's cleaner to have a find_vq() ops instead to dealing 
with the re-allocation and possible size change, or have a dedicated 
helper to set vring size so driver can do.

reset_vq()

virtqueue_set_vring_size()

enable_reset_vq()


> + *	Returns 0 on success or error status
>    */
>   typedef void vq_callback_t(struct virtqueue *);
>   struct virtio_config_ops {
> @@ -100,6 +111,8 @@ struct virtio_config_ops {
>   			int index);
>   	bool (*get_shm_region)(struct virtio_device *vdev,
>   			       struct virtio_shm_region *region, u8 id);
> +	int (*reset_vq)(struct virtqueue *vq);
> +	int (*enable_reset_vq)(struct virtqueue *vq, u16 ring_num);


Note that the current implement is best-effort, so it's not guarantee 
that we can have a vring with ring_num, we may get less under memory 
pressure or even fail. We probably need to have a pamater to mandate the 
ring_num otherwise user may surprise to see a decreased size of the ring 
when a increasing is actually requested.

Thanks


>   };
>   
>   /* If driver didn't advertise the feature, it will never appear. */

