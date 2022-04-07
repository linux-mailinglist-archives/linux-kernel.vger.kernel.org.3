Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451DE4F75C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbiDGGOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiDGGOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCB091C5914
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649311955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4YMZD0zaXzNbiLYIAQQ6QdI+WDXn0cZA+j7h4YBjqmQ=;
        b=EACFAS/CuEnkh6duNKmq4PYN3Wui52oV7RpFTZ9nrMNek2vjFwoNbJA474zWOmo5mNOaKR
        tCKsP8i2WM8iFbAW+iEAHgLPUy5W3A973ljqOLbLVfKnB+w0VYCZf+yIfoCkTCnEYfzxIe
        Pg+k7MKqmjTuRuK/rvYDback097kSE8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-NHgvIf4aNIeH4NKqo4WswA-1; Thu, 07 Apr 2022 02:12:34 -0400
X-MC-Unique: NHgvIf4aNIeH4NKqo4WswA-1
Received: by mail-pj1-f71.google.com with SMTP id m8-20020a17090aab0800b001cb1320ef6eso563262pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 23:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4YMZD0zaXzNbiLYIAQQ6QdI+WDXn0cZA+j7h4YBjqmQ=;
        b=CgSvLVZ8Kxcfo3mHpHFHFs2/MlvrXGpqQJY1fkMkscpl1VwMIT1POswFm5ZWf0Rh28
         rxybgamaXm1RdpmPvLuXspsZaIf21VWOkCE2CJ6g763kNACpQXJA9jTkovStV1E4mmaA
         4Pig+wZt6dyicANV5UzjPTk1ZcJcM29yhdtc3xdWG5qWyo5kHLL01yihvG/wjEYJVAxV
         2ks8DKtpbP571OLL99tIaAxfObsqSAtxbuTbRA4SEImLtx9RDpz5Co/+xIH55c/V7wrA
         w5tEp4D492ziCtLeVcnco/hsvS+qe/YnxtoL6g8Oh+dnzH1oTGWHLERSaIVtbaMCK6Mg
         AXuQ==
X-Gm-Message-State: AOAM530KRAgfAN8GHPkjpwICUriot7Y/DvHXo50TDqcuY3Kd6epizkRB
        C4Gc3DByvCA6CxI9UartFc5L6HL2zpVTMnel4y6trJWbuNOsNa8j8Y3xBSL9YXelwhBbLh2vvTi
        RPnHBxNQGAZldkum1H1pLAeHF
X-Received: by 2002:a05:6a00:1256:b0:4fb:1374:2f65 with SMTP id u22-20020a056a00125600b004fb13742f65mr12818679pfi.72.1649311953598;
        Wed, 06 Apr 2022 23:12:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7rGbUuvcCunCR1UohNGot6xcJrqBbgAuS1tOEZdmzy6OiRlug1LP1U5zxK0CgvL2OVrSsvg==
X-Received: by 2002:a05:6a00:1256:b0:4fb:1374:2f65 with SMTP id u22-20020a056a00125600b004fb13742f65mr12818667pfi.72.1649311953327;
        Wed, 06 Apr 2022 23:12:33 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a000b8600b004faa49add69sm21140158pfj.107.2022.04.06.23.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 23:12:32 -0700 (PDT)
Message-ID: <ccb6be3f-e397-21cb-3490-637c96483fcb@redhat.com>
Date:   Thu, 7 Apr 2022 14:12:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 0/5] rework on the IRQ hardening of virtio
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, sgarzare@redhat.com
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406073500-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406073500-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/6 下午7:36, Michael S. Tsirkin 写道:
> On Wed, Apr 06, 2022 at 04:35:33PM +0800, Jason Wang wrote:
>> Hi All:
>>
>> This is a rework on the IRQ hardening for virtio which is done
>> previously by the following commits are reverted:
>>
>> 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
>> 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
>>
>> The reason is that it depends on the IRQF_NO_AUTOEN which may conflict
>> with the assumption of the affinity managed IRQ that is used by some
>> virtio drivers. And what's more, it is only done for virtio-pci but
>> not other transports.
>>
>> In this rework, I try to implement a general virtio solution which
>> borrows the idea of the INTX hardening by introducing a boolean for
>> virtqueue callback enabling and toggle it in virtio_device_ready()
>> and virtio_reset_device(). Then vring_interrupt() can simply check and
>> return early if the driver is not ready.
>
> All of a sudden all patches are having a wrong mime type.
>
> It is application/octet-stream; should be text/plain
>
> Pls fix and repost, thanks!


So the patches are generated via git-format-patch and git-send-email in 
one run.

I can see many upstream patches were converted to 
application/octet-stream if From: tag is different from the sender.

Maxime told me they've also noticed the issue and it looks like a issue 
of mimecast.

Thanks


>
>> Please review.
>>
>> Changes since v1:
>>
>> - Use transport specific irq synchronization method when possible
>> - Drop the module parameter and enable the hardening unconditonally
>> - Tweak the barrier/ordering facilities used in the code
>> - Reanme irq_soft_enabled to driver_ready
>> - Avoid unnecssary IRQ synchornization (e.g during boot)
>>
>> Jason Wang (4):
>>    virtio: use virtio_reset_device() when possible
>>    virtio: introduce config op to synchronize vring callbacks
>>    virtio-pci: implement synchronize_vqs()
>>    virtio: harden vring IRQ
>>
>> Stefano Garzarella (1):
>>    virtio: use virtio_device_ready() in virtio_device_restore()
>>
>>   drivers/virtio/virtio.c            | 20 ++++++++++++++++----
>>   drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>>   drivers/virtio/virtio_pci_common.h |  2 ++
>>   drivers/virtio/virtio_pci_legacy.c |  1 +
>>   drivers/virtio/virtio_pci_modern.c |  2 ++
>>   drivers/virtio/virtio_ring.c       |  9 ++++++++-
>>   include/linux/virtio.h             |  2 ++
>>   include/linux/virtio_config.h      | 24 ++++++++++++++++++++++++
>>   8 files changed, 69 insertions(+), 5 deletions(-)
>>
>> -- 
>> 2.25.1

