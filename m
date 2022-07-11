Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7F56D477
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGKGCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKGCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3841A17A96
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657519368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPpLorO2rdtW+7ERxebnrugmQ1/TNad30addhYPoqwM=;
        b=K9b/j2xQ4B+FeO4xGPI7hwaYgdqmwXxsKDaD50ReHDVahBbvQ8rCFrZtH/Iz4wmowOG1gV
        llq7lNzVz9O+bhF9mzSt7qTeg7TR5nbVuEru1fso37EN+myiZKGzQ+QJzcBl7csyJU3rHz
        HUe1ilemQxJFTBAwiGzdlAR0xu6RyCU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-KVIVMFLmOo6ib54GdGJ25g-1; Mon, 11 Jul 2022 02:02:41 -0400
X-MC-Unique: KVIVMFLmOo6ib54GdGJ25g-1
Received: by mail-lj1-f197.google.com with SMTP id bj24-20020a2eaa98000000b0025d50c169ccso623099ljb.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPpLorO2rdtW+7ERxebnrugmQ1/TNad30addhYPoqwM=;
        b=CI9CwH0rzz8uMYx9Ssr5+6krjXaZQAKn8jyLy0iJkDwnpY7rLmtbKqrjb9xDLUtYPU
         qej9aTcxg3YmMAyzZ5P4Qp7SoHW3FVvd5nSKGy3HRly61gDtxLXw4ChBhQ/II/bmfAUO
         RGYIYVahaZ4x1PIEITj8dEDy05hOrlUqfvWzMCPQ5fDjVBLMt8OyvngekAQ1e0fTRLVL
         Xi6LyQEO3iFdu3o1mk6UhvnE11Ihz9hhqaOIepimRNaqwzKf13xLxg8iNF7I/fIKqrpH
         uMbeLerov4VkHzAKUrlfDB85Vgy9eFNMrWsBWuWQMHY90gpfcVWpx4ZKKTO+kYRsCwa+
         olWg==
X-Gm-Message-State: AJIora+CiK5oyLIlfUC62prZBPE/iujjC6rF3qXu10w6onhF4ytcMbIm
        isVibf9la6eSjn42NDAx1B3NG1A01sMKhBO6b5hoXAc3zD8LitAEbmE1ebgixftWXWBIGHCAkUB
        X2QdmzGNqNNKT5D18+fQAs+cuHW1NiltcQI8Yoq33
X-Received: by 2002:a2e:8958:0:b0:25a:852a:c302 with SMTP id b24-20020a2e8958000000b0025a852ac302mr9288693ljk.130.1657519359302;
        Sun, 10 Jul 2022 23:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vEQf80zZEme7a96P6lbGDOU+FIN1C2Bhdeho5yTVrdDF55JmNzKCj7M+hCoNmNGuKg9g45YqTOTNelpJflbX4=
X-Received: by 2002:a2e:8958:0:b0:25a:852a:c302 with SMTP id
 b24-20020a2e8958000000b0025a852ac302mr9288677ljk.130.1657519359122; Sun, 10
 Jul 2022 23:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
 <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
 <CACGkMEvtC1VmGjhV6QpEeu+nUikGj5eT79hhyS59rpK1s31TUg@mail.gmail.com> <CACycT3sNnmV8jrnjFkft6oST_6SGLc43f8Y4ZpomkPeOsvsorQ@mail.gmail.com>
In-Reply-To: <CACycT3sNnmV8jrnjFkft6oST_6SGLc43f8Y4ZpomkPeOsvsorQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 11 Jul 2022 14:02:27 +0800
Message-ID: <CACGkMEsuGif+X4Maa-qSNYLzfkvBKV9ZkVEUFgYnjsUUwS4Dkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] VDUSE: Support registering userspace memory as
 bounce buffer
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 5:53 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Jul 8, 2022 at 4:38 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jul 6, 2022 at 6:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Wed, Jul 6, 2022 at 5:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> > > > > VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> > > > > registering and de-registering userspace memory for IOTLB
> > > > > as bounce buffer in virtio-vdpa case.
> > > > >
> > > > > The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> > > > > information such as bounce buffer size. Then user can use
> > > > > those information on VDUSE_IOTLB_REG_UMEM and
> > > > > VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> > > > > userspace memory for IOTLB.
> > > > >
> > > > > During registering and de-registering, the DMA data in use
> > > > > would be copied from kernel bounce pages to userspace bounce
> > > > > pages and back.
> > > > >
> > > > > With this feature, some existing application such as SPDK
> > > > > and DPDK can leverage the datapath of VDUSE directly and
> > > > > efficiently as discussed before [1][2]. They can register
> > > > > some preallocated hugepages to VDUSE to avoid an extra
> > > > > memcpy from bounce-buffer to hugepages.
> > > >
> > > > This is really interesting.
> > > >
> > > > But a small concern on uAPI is that this seems to expose the VDUSE
> > > > internal implementation (bounce buffer) to userspace. We tried hard to
> > > > hide it via the GET_FD before. Anyway can we keep it?
> > > >
> > >
> > > Another way is changing GET_FD ioctl to add a flag or reuse 'perm'
> > > field to indicate whether a IOVA region supports userspace memory
> > > registration. Then userspace can use
> > > VDUSE_IOTLB_REG_UMEM/VDUSE_IOTLB_DEREG_UMEM to register/deregister
> > > userspace memory for this IOVA region.
> >
> > Looks better.
> >
>
> OK.
>
> > > Any suggestions?
> >
> > I wonder what's the value of keeping the compatibility with the kernel
> > mmaped bounce buffer. It means we need to take extra care on e.g data
> > copying when reg/reg user space memory.
> >
>
> I'm not sure I get your point on the compatibility with the kernel
> bounce buffer. Do you mean they use the same iova region?

Yes.

>
> The userspace daemon might crash or reboot. In those cases, we still
> need a kernel buffer to store/recover the data.

Yes, this should be a good point.

>
> > Can we simply allow the third kind of fd that only works for umem registration?
> >
>
> Do you mean using another iova region for umem?

I meant having a new kind of fd that only allows umem registration.

>I think we don't need
> a fd in umem case since the userspace daemon can access the memory
> directly without using mmap() to map it into the address space in
> advance.

Ok, I will have a look at the code and get back.

Thanks

>
> Thanks,
> Yongji
>

