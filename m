Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284AA571598
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiGLJUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiGLJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52807BE2F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657617639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYz6sQFrLTtNwewKdjTQqPfTJGeybAAsk7vYVyjO6GM=;
        b=Rm8hpNLvSmExrp4j/s2dxSbuGzBKO813eGorUD//v1OUnruj8Ot/MDJNt0OZMLTxgj3AVF
        4AqkmffEwiFG+0WoFFJuRb6AGvEks2bhyqyDgXg7VbcYQqdNGxEc97ThyDu1+V44d6Yk6K
        ewUo0B7rdcy9q08Jo4NO8jxJlDBV0XY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-cAt94RGWMKC6tVYhh1bBAw-1; Tue, 12 Jul 2022 05:20:37 -0400
X-MC-Unique: cAt94RGWMKC6tVYhh1bBAw-1
Received: by mail-wm1-f69.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so3523801wmp.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LYz6sQFrLTtNwewKdjTQqPfTJGeybAAsk7vYVyjO6GM=;
        b=sNzObrxJDSljbK4uWsJB9y5X+0/6i45SJ6PQkjjXX5uEU7gF9hVuBfKOUDzCjwqda6
         e99sJ01a1iEorePEoUSenZeunCBbh+5mTXlO3JlLJBa97Kayt2W3uYuCfT54rAWUzNJP
         Ikh+0pLz2IzvYMKZTu7ay+R9C1f0R74vORywfvxAzX36fVmgMAXjd12Kab9kBpmfnG+6
         E+T5bZCRmXQniqBbMjjoMkjLWgawQjuvVOevqIS55nmx1MwJi6L1vJ2HKldLsDFp1md2
         /Ugp+ipo3ofkQwDkutfMEQ4QEn992rLqfcH8QT3/D7dSkeKO6J3BLiR43p/hHHN9kkfx
         lw4w==
X-Gm-Message-State: AJIora9NbUT1K3RpqtFfcX9z9w/xoXQOjP9Ef3gUXMyo5TcoDJ+FHhOp
        gQ9ODzZ/6Cb5DgYRo4KLMxaXnuY+ynjNr8n7Pp1O5dSWqfKUjjVs9GkbaIGWg15sgi+BMa7Q8oh
        B45Fzt0PZzCLHe11XVBc87mdP
X-Received: by 2002:a05:600c:3b1d:b0:3a2:60a1:fe6a with SMTP id m29-20020a05600c3b1d00b003a260a1fe6amr2641727wms.3.1657617636573;
        Tue, 12 Jul 2022 02:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9RDSlegIwgOcJ6F20tlQ2lBcbr65X6+YRs7b+2BnymUAXBnm75D8yNy2Zv/ziWoZOQkGE5Q==
X-Received: by 2002:a05:600c:3b1d:b0:3a2:60a1:fe6a with SMTP id m29-20020a05600c3b1d00b003a260a1fe6amr2641714wms.3.1657617636417;
        Tue, 12 Jul 2022 02:20:36 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c48a800b003a2e278510csm8027518wmp.15.2022.07.12.02.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:20:35 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:20:33 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
Message-ID: <20220712092033.637dwixetnaujg6y@sgarzare-redhat>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
 <20220712084544.lgtggj44ihlkfsb3@sgarzare-redhat>
 <CACGkMEtHg_EVYcS=Qxsmwq3t+96E8LNqa5Ck1Gi4hJs2AJ0F+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtHg_EVYcS=Qxsmwq3t+96E8LNqa5Ck1Gi4hJs2AJ0F+Q@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:47:10PM +0800, Jason Wang wrote:
>On Tue, Jul 12, 2022 at 4:46 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Tue, Jul 12, 2022 at 04:34:11PM +0800, Jason Wang wrote:
>> >
>> >在 2022/7/5 01:16, Stefano Garzarella 写道:
>> >>The first 3 patches fix various problems I have encountered with
>> >>virtio_test (they may go without this series, but I included to allow you
>> >>to test the series).
>> >>
>> >>Patch 4 is in preparation of patch 5, moving the feature negotiation when
>> >>we initialize the device.
>> >>
>> >>Patch 5 add the support of vhost-vdpa in virtio_test
>> >>
>> >>Patch 6 add vdpa_test.ko based on vdpa_sim_test.c, so we can reuse most of
>> >>the code coming from the vdpa_sim framework.
>> >>
>> >>I tested in this way:
>> >>
>> >>   $ modprobe vdpa_sim
>> >>   $ modprobe vhost-vdpa
>> >>
>> >>   # load the vdpasim_test device
>> >>   $ insmod vdpa_test.ko
>> >>
>> >>   # create a new vdpasim_test device
>> >>   $ vdpa dev add mgmtdev vdpasim_test name dev0
>> >
>> >
>> >I wonder what's the benefit of using a dedicated test device other
>> >than networking? (already a loopback device anyhow).
>> >
>>
>> The main advantage I was thinking is that we can extend it at will to
>> try to cover as much as possible all the paths that maybe with net we
>> can't (indirect, reset, etc.).
>>
>> Plus it should be easier to test vhost-vdpa this way without using QEMU.
>>
>> Do you think this is redundant?
>
>It's probably fine and it might be better to describe the reason in
>the changelog.

Okay, I'll do in the next version!

Thanks,
Stefano

