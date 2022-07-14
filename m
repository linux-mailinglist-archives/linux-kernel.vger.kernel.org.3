Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2655741AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiGNC7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiGNC7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF718255AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657767568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vljCPqfS4JXAdqfuKpPVeX86cFMumauaVcfGL80nUUY=;
        b=ZPdBsENVBL4XMA3LEXNS2UAZgu9/H5AcR/MmfPG5g6cM4UMBu0c3mtWQWJwkESAxM4xKJe
        4mzIaSoMlPQ8pwn2tiTac6vSgofH00c6V0hByj8V0yjaH1nUuYm+YCPJGc6wLmXRd/YG7S
        m55ojJNTtFGJe8ryCOatxpYhPNgErEQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-KMJahnqINc2MM3HZbHXJlg-1; Wed, 13 Jul 2022 22:59:27 -0400
X-MC-Unique: KMJahnqINc2MM3HZbHXJlg-1
Received: by mail-pj1-f69.google.com with SMTP id x16-20020a17090ab01000b001f06332d7cfso2786061pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vljCPqfS4JXAdqfuKpPVeX86cFMumauaVcfGL80nUUY=;
        b=ciJK/4hwGE2bypuAGCMK91h9P2oecyOhumtfgUZkJioCVe+Oz/ZcxnYxVIFzYjkKyR
         +zwojRYCNNPXAzpgt2D7bTrdVzXtGzmJjF17HzBpnHWNmbBFGuUFa2O0hnbS0/VJwxUF
         GUI8+0xDpF+iSccX18HFNhhzlXWQSLw6hopvDRTFvXi2coR4XRb2J0uNWagFqlGu9LpL
         8P/IhtRb8UL7APij/7gHqR+/Hp1dRgywdExkk2rxYI5fDtfcSRAx7QTYqGLAQazZJOf5
         9Vei12GD7DBuZ+13u3ADuZcbm2fuRlLAx8ICExNOHXFe8sXOSRH+X3VgyKgXGD6sQYfG
         Emrw==
X-Gm-Message-State: AJIora/8eWLSGOeR7UY9GHofOX0i396hMNH+Nx0RttxGs3SKOr+nPvN8
        MJ9X7fzxrAaT1PxbLR/vWGNwEgY5nmg8MRArTOyLVl0JBlNn2KgG6cgaKFT9l6Oa+u2+GnujORz
        Awd4jDadyUmBqBfNt/3grZUhp
X-Received: by 2002:a17:903:22c4:b0:16c:6a72:12b7 with SMTP id y4-20020a17090322c400b0016c6a7212b7mr6303409plg.10.1657767566431;
        Wed, 13 Jul 2022 19:59:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uK4DAlZpD0zNK9Y+KrDKvumOJ7i3EGJ+/6C3HLY/3v2p4iYXHOzlayl5RJDUAfh2Tq370tKg==
X-Received: by 2002:a17:903:22c4:b0:16c:6a72:12b7 with SMTP id y4-20020a17090322c400b0016c6a7212b7mr6303385plg.10.1657767566196;
        Wed, 13 Jul 2022 19:59:26 -0700 (PDT)
Received: from [10.72.12.153] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902cf0b00b0016c06a10861sm161638plg.74.2022.07.13.19.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 19:59:25 -0700 (PDT)
Message-ID: <07a8e952-1347-8920-3a78-0200b865e0e9@redhat.com>
Date:   Thu, 14 Jul 2022 10:59:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] VDUSE: Support registering userspace memory as
 bounce buffer
Content-Language: en-US
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
 <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
 <CACGkMEvtC1VmGjhV6QpEeu+nUikGj5eT79hhyS59rpK1s31TUg@mail.gmail.com>
 <CACycT3sNnmV8jrnjFkft6oST_6SGLc43f8Y4ZpomkPeOsvsorQ@mail.gmail.com>
 <CACGkMEsuGif+X4Maa-qSNYLzfkvBKV9ZkVEUFgYnjsUUwS4Dkw@mail.gmail.com>
 <CACycT3vgaOrLVq+GDRK1PqqBRCkUAU0bYH=2CDvudsX0F9FBDA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <CACycT3vgaOrLVq+GDRK1PqqBRCkUAU0bYH=2CDvudsX0F9FBDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/11 15:24, Yongji Xie 写道:
> On Mon, Jul 11, 2022 at 2:02 PM Jason Wang <jasowang@redhat.com> wrote:
>> On Fri, Jul 8, 2022 at 5:53 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>>> On Fri, Jul 8, 2022 at 4:38 PM Jason Wang <jasowang@redhat.com> wrote:
>>>> On Wed, Jul 6, 2022 at 6:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>>>>> On Wed, Jul 6, 2022 at 5:30 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>> On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
>>>>>>> VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
>>>>>>> registering and de-registering userspace memory for IOTLB
>>>>>>> as bounce buffer in virtio-vdpa case.
>>>>>>>
>>>>>>> The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
>>>>>>> information such as bounce buffer size. Then user can use
>>>>>>> those information on VDUSE_IOTLB_REG_UMEM and
>>>>>>> VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
>>>>>>> userspace memory for IOTLB.
>>>>>>>
>>>>>>> During registering and de-registering, the DMA data in use
>>>>>>> would be copied from kernel bounce pages to userspace bounce
>>>>>>> pages and back.
>>>>>>>
>>>>>>> With this feature, some existing application such as SPDK
>>>>>>> and DPDK can leverage the datapath of VDUSE directly and
>>>>>>> efficiently as discussed before [1][2]. They can register
>>>>>>> some preallocated hugepages to VDUSE to avoid an extra
>>>>>>> memcpy from bounce-buffer to hugepages.
>>>>>> This is really interesting.
>>>>>>
>>>>>> But a small concern on uAPI is that this seems to expose the VDUSE
>>>>>> internal implementation (bounce buffer) to userspace. We tried hard to
>>>>>> hide it via the GET_FD before. Anyway can we keep it?
>>>>>>
>>>>> Another way is changing GET_FD ioctl to add a flag or reuse 'perm'
>>>>> field to indicate whether a IOVA region supports userspace memory
>>>>> registration. Then userspace can use
>>>>> VDUSE_IOTLB_REG_UMEM/VDUSE_IOTLB_DEREG_UMEM to register/deregister
>>>>> userspace memory for this IOVA region.
>>>> Looks better.
>>>>
>>> OK.
>>>
>>>>> Any suggestions?
>>>> I wonder what's the value of keeping the compatibility with the kernel
>>>> mmaped bounce buffer. It means we need to take extra care on e.g data
>>>> copying when reg/reg user space memory.
>>>>
>>> I'm not sure I get your point on the compatibility with the kernel
>>> bounce buffer. Do you mean they use the same iova region?
>> Yes.
>>
>>> The userspace daemon might crash or reboot. In those cases, we still
>>> need a kernel buffer to store/recover the data.
>> Yes, this should be a good point.
>>
>>>> Can we simply allow the third kind of fd that only works for umem registration?
>>>>
>>> Do you mean using another iova region for umem?
>> I meant having a new kind of fd that only allows umem registration.
>>
> OK. It seems to be a little complicated to allow mapping a registered
> user memory via a new fd, e.g. how to handle the mapping if the
> userspace daemon exits but the fd is already passed to another
> process.
>
>>> I think we don't need
>>> a fd in umem case since the userspace daemon can access the memory
>>> directly without using mmap() to map it into the address space in
>>> advance.
>> Ok, I will have a look at the code and get back.
>>
> OK. Looking forward to your reply.


Looks good overall.

Just few comments.

Thanks


>
> Thanks,
> Yongji
>

