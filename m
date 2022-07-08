Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE0D56B491
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiGHIjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbiGHIjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6F915C97C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657269538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VjRlQXGGGY292fDcz+4b7uINrKnhV/T0exw7xiAeg2E=;
        b=VhsQYURyrHJiFDz3D4NkX08zqMfBM/kAMa6HnTdbZTLWQ4mqY1RBlwygyOFn5wmuzvAeJ+
        iN/4d25yUmavxvp5sB1i8m2zSIDwJZt1hvR++KR/bBkJnJVAgDE3POXuH2TrOFsx3KdC9j
        Dim1dQCKDENPIZpH0dFMT27/2qAck8Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-Igq-jLh7Omu771M2MN0aZA-1; Fri, 08 Jul 2022 04:38:51 -0400
X-MC-Unique: Igq-jLh7Omu771M2MN0aZA-1
Received: by mail-lf1-f71.google.com with SMTP id h18-20020a056512055200b004810d1b257aso7561969lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 01:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjRlQXGGGY292fDcz+4b7uINrKnhV/T0exw7xiAeg2E=;
        b=JjcqjbDIknlyvHSnyrJNPs+FqaRM1l4xBXP21+YW4i/RJJ78SRgydhuVouImHX/+7S
         o0YdmBJus3vNulZ6tw/j3TB6oXAuqBPIuBUs55rxJfN/QqGcDZEr331dtT1ZWIZYdxiv
         YLkLL26EjbJtfjnvTWvCFEhUeDnyNhN1DhduVLp97BnBEK7uvXw048K+k8PDPjfqzvft
         R/TBHkqPefgjgnkCHiZpPpsWj0az8f15ZDxkgTvdkO5JNrANDNMYuZOUbSc1nm+H4gJo
         CGtfz7X7E19qJlVVGdU4Ek0wn+RuxXy1zlqkPuWRAh2c4x8uSvSZkxbUpqoffTr2fU7R
         OlqA==
X-Gm-Message-State: AJIora+iyMN1kgRPGlQHKjENP6//z9jzw7qiwSC11aeOwhODngO17YzD
        Vrrp5WA9MJZ58YqCju8ByJ2OteEftD8VC1mKqElZycTNBnuEvtWYBhFGu/TIIInZ5Vk1lf5tWvq
        CdIR3IxkDmt+xf5qmrBScKuXtrWHZmI7cILqcEnDf
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id g14-20020a0565123b8e00b004811a750452mr1757471lfv.238.1657269529281;
        Fri, 08 Jul 2022 01:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/lqDZF8NOO7f0vLkQWh9o4W/nvu/S+XKeijIEihRuhlgQCp5a7p0RH7eYUIqfOvRGedEpaTlBeRW3khfgko0=
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id
 g14-20020a0565123b8e00b004811a750452mr1757462lfv.238.1657269529036; Fri, 08
 Jul 2022 01:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
 <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
In-Reply-To: <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 8 Jul 2022 16:38:37 +0800
Message-ID: <CACGkMEvtC1VmGjhV6QpEeu+nUikGj5eT79hhyS59rpK1s31TUg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 6:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Wed, Jul 6, 2022 at 5:30 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > Hi all,
> > >
> > > This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> > > VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> > > registering and de-registering userspace memory for IOTLB
> > > as bounce buffer in virtio-vdpa case.
> > >
> > > The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> > > information such as bounce buffer size. Then user can use
> > > those information on VDUSE_IOTLB_REG_UMEM and
> > > VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> > > userspace memory for IOTLB.
> > >
> > > During registering and de-registering, the DMA data in use
> > > would be copied from kernel bounce pages to userspace bounce
> > > pages and back.
> > >
> > > With this feature, some existing application such as SPDK
> > > and DPDK can leverage the datapath of VDUSE directly and
> > > efficiently as discussed before [1][2]. They can register
> > > some preallocated hugepages to VDUSE to avoid an extra
> > > memcpy from bounce-buffer to hugepages.
> >
> > This is really interesting.
> >
> > But a small concern on uAPI is that this seems to expose the VDUSE
> > internal implementation (bounce buffer) to userspace. We tried hard to
> > hide it via the GET_FD before. Anyway can we keep it?
> >
>
> Another way is changing GET_FD ioctl to add a flag or reuse 'perm'
> field to indicate whether a IOVA region supports userspace memory
> registration. Then userspace can use
> VDUSE_IOTLB_REG_UMEM/VDUSE_IOTLB_DEREG_UMEM to register/deregister
> userspace memory for this IOVA region.

Looks better.

> Any suggestions?

I wonder what's the value of keeping the compatibility with the kernel
mmaped bounce buffer. It means we need to take extra care on e.g data
copying when reg/reg user space memory.

Can we simply allow the third kind of fd that only works for umem registration?

Thanks

>
> Thanks,
> Yongji
>

