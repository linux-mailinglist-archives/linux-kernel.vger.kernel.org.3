Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7955663CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiGEHLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGEHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4606465F1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657005077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJXN8MigLI7PutDCLu0w7BuxFejNMyCNinj+kATd3bo=;
        b=GTdd2ECPsGdu0rYFxaXS1rKI4asfWMmjB5Laj5Y9UaIT8pCTx8L3Cyx75fvTtTyNdd70Es
        bv0loXgJNVpVP6+t7n4oBC7Ev0mMDTsDkSgH21NDPq9Y48CLwEeoTVxPA/rg6MHHgMqO1M
        h/bn1PQ4iUoeOk6bh1JFpJo0bXnt91I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-4cI_71sMM4WBRFBJJfBGhw-1; Tue, 05 Jul 2022 03:11:16 -0400
X-MC-Unique: 4cI_71sMM4WBRFBJJfBGhw-1
Received: by mail-wr1-f72.google.com with SMTP id e7-20020adfa447000000b0021d669c6a76so933781wra.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJXN8MigLI7PutDCLu0w7BuxFejNMyCNinj+kATd3bo=;
        b=h8tW+ymdn9DVkugFpCSRCy0uCYhJl2FDm/JglgKelnRfCYS86FQYfl3eiBwG1mQirm
         0TRpqPBboIrNSJ3uHPJhYhHsYCYFPJ8ujR/C/wHttUz5tJKB7OPOsyikpxLD2uScsRyi
         RAEMh8oHXgvfnIStVsqwCFB0s1IrF+WBeqmk9St0MLo2ZUSP30RiXOfc5s6Lkqztmy2z
         DdtSIBPv+PZ5ElTqzhSkIE5+CUyGgwZVoUosYJrctJoEgZS5bIpmdwhsLOhRZHbybggV
         EjC8NsYbVdg1RXCwIRBRmTBS7H3TeZ1kvdX42oLLlJ1YJ5aLrjD6kJbrSnu4+UPF61s2
         5L1g==
X-Gm-Message-State: AJIora9x6hJfjf8oyQ9rOEIHc0eGER7gFFavIJDLQezzObI0xZMS9VhE
        r5+b5qMng28YG90Uwmue+274eVyP3DBzIEycDaUTHzmcmpC15FG9RR3l1hmE0EgLv5cR+XpzcWc
        rIm631/J5zJx/OpSMWmYzhCOE
X-Received: by 2002:a05:600c:1f0d:b0:3a1:a05c:13c5 with SMTP id bd13-20020a05600c1f0d00b003a1a05c13c5mr10501980wmb.146.1657005074499;
        Tue, 05 Jul 2022 00:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sWjWhrCzGRvoHfRF4VGqhhX94VqJHSrSBXKRmAVO2iCxkXT//j3aoBo3tr1QCnHGg/Q9WPhw==
X-Received: by 2002:a05:600c:1f0d:b0:3a1:a05c:13c5 with SMTP id bd13-20020a05600c1f0d00b003a1a05c13c5mr10501966wmb.146.1657005074306;
        Tue, 05 Jul 2022 00:11:14 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm31484278wrr.101.2022.07.05.00.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:11:13 -0700 (PDT)
Date:   Tue, 5 Jul 2022 09:11:10 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 3/6] virtio_test: call __virtio_unbreak_device
Message-ID: <20220705071110.xqerzycco3pziwbk@sgarzare-redhat>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <20220704171701.127665-4-sgarzare@redhat.com>
 <20220704150450-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220704150450-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 03:06:39PM -0400, Michael S. Tsirkin wrote:
>On Mon, Jul 04, 2022 at 07:16:58PM +0200, Stefano Garzarella wrote:
>> Commit 8b4ec69d7e09 ("virtio: harden vring IRQ") initialize vq->broken
>> to true, so we need to call __virtio_unbreak_device() before starting
>> to use it.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>I think this shouldn't be necessary with latest master.

Right, c346dae4f3fb ("virtio: disable notification hardening by default")
is merged now.

I'll remove this patch.

Thanks,
Stefano

>
>> ---
>>  tools/virtio/linux/virtio.h | 2 ++
>>  tools/virtio/virtio_test.c  | 1 +
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
>> index 363b98228301..feb720d4304f 100644
>> --- a/tools/virtio/linux/virtio.h
>> +++ b/tools/virtio/linux/virtio.h
>> @@ -66,4 +66,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>>  				      const char *name);
>>  void vring_del_virtqueue(struct virtqueue *vq);
>>
>> +void __virtio_unbreak_device(struct virtio_device *dev);
>> +
>>  #endif
>> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>> index 23f142af544a..765e64895dab 100644
>> --- a/tools/virtio/virtio_test.c
>> +++ b/tools/virtio/virtio_test.c
>> @@ -177,6 +177,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>  	long long spurious = 0;
>>  	const bool random_batch = batch == RANDOM_BATCH;
>>
>> +	__virtio_unbreak_device(&dev->vdev);
>>  	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>>  	assert(r >= 0);
>>  	if (!reset_n) {
>> --
>> 2.36.1
>

