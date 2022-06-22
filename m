Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0371554D04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357677AbiFVO30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358476AbiFVO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0DE92F019
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655908127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x34IRi49NgING8whuhdPrWa3tANXSDCipF9OzN2jvL4=;
        b=KTXOE1ZTOUP8gbxNKFlgx4Hj5P++HdlFHX6WhNau+QeGuOQITie5OsH2GUZqKz+FUsh1Rg
        Xp0D4ssm0Tx0ci4JOUjtO7a6j8iw1VGFabmhBpDJhE7ubQnc1eGTcqH7oLxhkOghx/fW5w
        YcsCY2Mng0I1nIq05ny7yvCNtRgWiCc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-0BuHuD2ENV2s97005W8YUg-1; Wed, 22 Jun 2022 10:28:46 -0400
X-MC-Unique: 0BuHuD2ENV2s97005W8YUg-1
Received: by mail-wm1-f72.google.com with SMTP id l17-20020a05600c4f1100b0039c860db521so7916000wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x34IRi49NgING8whuhdPrWa3tANXSDCipF9OzN2jvL4=;
        b=vtkzxkiQ0QWMzcX7eBgz+c+atT9ZhCO4QQwGLUxs3OYCn73QkcHSa+5E7nrGuNpVo5
         19PqkkqCV/8JDl0Xdy5DH79ST+PhpBpvkWmekFJdZX76byaI1oyTe4qU/V03Bi5TDzKE
         5F7iO2i+7a72EOBKz6E324EYKM5vu4okwM/mPkTEgp4OiU8S8yZmVvWKA8bwzfMqBu6q
         dboSIJLJ5f1qQMWLDemlPFdAc0jB7W6A2fmOjQM9KWEmKy7koGLDTbU5Hl75SNiuo2hJ
         hZ0DVptNNsMIslt7+2wT6Whnw5mRgI9n0og4Fy3ts1TkKt13xJpaLO2m9ZCKP81TPx9F
         r0sw==
X-Gm-Message-State: AJIora/9G4r5TViF8m4Ip98UqZ+l5ZR//4NIUZJmWUMLiP2Wj447V0Ne
        2FRZxPPzhRbQaMatzqhzc61GLWbR6sXQxdshq3yfliNa88SrZTxCAopuv1Mi+lzwmfQUPBoXGrP
        2Luy+LclDj8CX67FZGlgmM4Q2U7iqgPmQ4lWmYlA4EGVx4I7q3o4Tp35GVf97oi/rhkH7as7nnm
        um
X-Received: by 2002:a5d:5984:0:b0:219:e396:d3d1 with SMTP id n4-20020a5d5984000000b00219e396d3d1mr3649487wri.701.1655908124763;
        Wed, 22 Jun 2022 07:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vuhyEjREFg3dGcH7vFPn3yakH8vgcXSr8DuJhoDWbuzWlidbf8KyA6iZoKwjJuqao0HuIjng==
X-Received: by 2002:a5d:5984:0:b0:219:e396:d3d1 with SMTP id n4-20020a5d5984000000b00219e396d3d1mr3649464wri.701.1655908124542;
        Wed, 22 Jun 2022 07:28:44 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c130-20020a1c3588000000b0039c798b2dc5sm25959911wma.8.2022.06.22.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/39] KVM: x86: hyper-v: Don't use
 sparse_set_to_vcpu_mask() in kvm_hv_send_ipi()
In-Reply-To: <36f2de4e-43fe-7280-8cac-f44de89b2b98@redhat.com>
References: <20220613133922.2875594-1-vkuznets@redhat.com>
 <20220613133922.2875594-11-vkuznets@redhat.com>
 <17a2e85a-a1f2-99e1-fc69-1baed2275bd5@redhat.com>
 <87zgi640mm.fsf@redhat.com>
 <36f2de4e-43fe-7280-8cac-f44de89b2b98@redhat.com>
Date:   Wed, 22 Jun 2022 16:28:43 +0200
Message-ID: <87tu8cydpg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/21/22 15:17, Vitaly Kuznetsov wrote:
>>>
>>> Just to be clear, PV IPI does*not*  support the VP_ID, right?
>> Hm, with Hyper-V PV IPI hypercall vCPUs are also addressed by their
>> VP_IDs, not by their APIC ids so similar to Hyper-V PV TLB flush we need
>> to convert the supplied set (either flat u64 bitmask of VP_IDs for
>> non-EX hypercall or a sparse set for -EX).
>> 
>
> So this means the series needs a v8, right?
>

No, I was just trying to explaini what the patch is doing in the series,
it looks good to me (but I'm biased, of course).

-- 
Vitaly

