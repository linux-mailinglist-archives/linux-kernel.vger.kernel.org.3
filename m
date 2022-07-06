Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDB56838D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiGFJar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiGFJap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D32D19019
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657099843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8BzlNPid17ZYuPXy7wyRvGnmNT9ou7kXgjhlij1C/I=;
        b=F41dRRR6CuBenM6kvd4lRq6Q2Gn4oUtL+h98d8w79M2z95G36ZhSPzEOd3OkVimQNR0tGQ
        rU4hDw/hVfFQEqPjTPBcc1Od4q86E4yAfhxkYnbLs94pfteoym1RueZmbgpumMeSlT3xBU
        tjzdtpvrNgZmCuY7anwcRsLOpYy9khw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-X_TibUJ6N_yMGlubQCR9nQ-1; Wed, 06 Jul 2022 05:30:42 -0400
X-MC-Unique: X_TibUJ6N_yMGlubQCR9nQ-1
Received: by mail-lf1-f71.google.com with SMTP id x12-20020a19f60c000000b00483880ba018so1516828lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8BzlNPid17ZYuPXy7wyRvGnmNT9ou7kXgjhlij1C/I=;
        b=STqI13dVsc+RC8JT1Zj4kt0LBsZfBXfF2MIZLwXBbzP7uIjCflxBej65H6YVrXT7jy
         7AclAtzhfW8aTFrFR3NvrgBz9PHJWGcr0vL8aeRLALqsa7BIrVY46lHogjll4mAf6BoY
         KtOozqkxdq+hp7pS0/iBwImXLZxhEliMtip/4a51n92nBmYGzmYxaqtLHrfaA7i3VwMV
         EZeJa+X5dfTHFGIwnmtPReAPi8a/mt2A8NEKItav39rXRUjZmuRqr2TnWooyQGYCcqUK
         IyNg66yKk3dNbLd55q/xUX7V9QKv+AMOXGYsIfxdAEF8fcJBcsSRq04cvyMaFxYtRePM
         Fmpw==
X-Gm-Message-State: AJIora9H+P/mLrvyX0OCSX+uDKgtD62CxnbAWUc7Iw4Jv4cdQCb6+u5w
        vC6QzpWvp/LYvXWxy7HnVkj8yZtLv6bItDh+bHjW6H8zqxLu4aSh/u1Ln8c3SNVqha+JRIpDR+r
        ahBAAvqoXkGBpS+J13gH7/K35FaXXD+v49IKa2buJ
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id j3-20020a2eb703000000b0025a93d08a57mr23082271ljo.487.1657099840603;
        Wed, 06 Jul 2022 02:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tn0VU/qJOnX+Quc4LHX2cHJ7O69wBObrlpOxDCHrDTbs96CxnRYeB35+e+oNw3fz0M5H2a3q0J32a2k7fi8g0=
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr23082245ljo.487.1657099840240; Wed, 06
 Jul 2022 02:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com>
In-Reply-To: <20220706050503.171-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 6 Jul 2022 17:30:29 +0800
Message-ID: <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] VDUSE: Support registering userspace memory as
 bounce buffer
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Hi all,
>
> This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> registering and de-registering userspace memory for IOTLB
> as bounce buffer in virtio-vdpa case.
>
> The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> information such as bounce buffer size. Then user can use
> those information on VDUSE_IOTLB_REG_UMEM and
> VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> userspace memory for IOTLB.
>
> During registering and de-registering, the DMA data in use
> would be copied from kernel bounce pages to userspace bounce
> pages and back.
>
> With this feature, some existing application such as SPDK
> and DPDK can leverage the datapath of VDUSE directly and
> efficiently as discussed before [1][2]. They can register
> some preallocated hugepages to VDUSE to avoid an extra
> memcpy from bounce-buffer to hugepages.

This is really interesting.

But a small concern on uAPI is that this seems to expose the VDUSE
internal implementation (bounce buffer) to userspace. We tried hard to
hide it via the GET_FD before. Anyway can we keep it?

Thanks

>
> The kernel and userspace codes could be found in github:
>
> https://github.com/bytedance/linux/tree/vduse-umem
> https://github.com/bytedance/qemu/tree/vduse-umem
>
> To test it with qemu-storage-daemon:
>
> $ qemu-storage-daemon \
>     --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server=on,wait=off \
>     --monitor chardev=charmonitor \
>     --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0 \
>     --export type=vduse-blk,id=vduse-test,name=vduse-test,node-name=disk0,writable=on
>
> [1] https://lkml.org/lkml/2021/6/27/318
> [2] https://lkml.org/lkml/2022/7/4/246
>
> Please review, thanks!
>
> V1 to V2:
> - Drop the patch that updating API version [MST]
> - Replace unpin_user_pages() with unpin_user_pages_dirty_lock() [MST]
> - Use __vmalloc(__GFP_ACCOUNT) for memory accounting [MST]
>
> Xie Yongji (5):
>   vduse: Remove unnecessary spin lock protection
>   vduse: Use memcpy_{to,from}_page() in do_bounce()
>   vduse: Support using userspace pages as bounce buffer
>   vduse: Support querying IOLTB information
>   vduse: Support registering userspace memory for IOTLB
>
>  drivers/vdpa/vdpa_user/iova_domain.c | 134 ++++++++++++++++++++---
>  drivers/vdpa/vdpa_user/iova_domain.h |   9 ++
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 152 +++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h           |  45 ++++++++
>  4 files changed, 327 insertions(+), 13 deletions(-)
>
> --
> 2.20.1
>

