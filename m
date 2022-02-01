Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0474A4A5E53
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiBAObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:31:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230237AbiBAObq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643725906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMK8/jcOZdjpD/nh6+MuQsZsF0YOGLGqcOfutTCzX3o=;
        b=XUoHWHkxOza6hcagNfrxxFmiLdjEancgSxz/9W3N4E7D/4DLeoHXgWAIPXbZ5YofYfvLH7
        5keHE0ht3esak5Fc6kb+NpvIutZ/rCgz4ATvY2rOSSlJ+kZSb798R/dS/dol0uAcLsada4
        4cwrFFRyN7rTwLRIv9mkKL1+xMlxBZc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-RHVipqQINb20QaNy-t1vhA-1; Tue, 01 Feb 2022 09:31:45 -0500
X-MC-Unique: RHVipqQINb20QaNy-t1vhA-1
Received: by mail-ed1-f72.google.com with SMTP id i22-20020a50fd16000000b00405039f2c59so8782127eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uMK8/jcOZdjpD/nh6+MuQsZsF0YOGLGqcOfutTCzX3o=;
        b=Emq2foWzeFnnPk6go9akpQJZvoz6zLNNlU0fZwsYxGqKAqNF3Wa+RFBc0nUHYgXHlc
         PBQwvP5myAXswuhg59Ekyy6TtvCb9Do6zVplVOSFZdeC4R23LVqSMroGw4n3rL8+Lt5/
         WvZD3GpWuPOuFJNU+w4NplaToi4czRMfgjEbYpp0g+yhc7w47r7z1u3S3E8PpeAxX3Mc
         dZZcDm8ZD+J+h2at3LwfzI8tyZHpKdXRnl1MLMpfTz3P/O0jJFDyzLsjcwpsZhc6yqyz
         iOAjvR6EcI0yrpQbKhM/V1qR0t4VpytxkGc048eXIcd/J0A77NV4gESmBvdPW1Y5djUc
         8avw==
X-Gm-Message-State: AOAM531OnBaEhZr+Yao3J2mLa4KUB+2LjrImkQ6n4dUpIShr4G932xPE
        1Qz0ztzhnG7/EFVLRVasbo3PgJCzrPEYf9A+uopO8yrPDVYDinzCUlNjd77ApPCUgJfsaQGyhLy
        N/GIQFgDP15Oi+d/fl1Ql1PYmQBRYafj2rU5x/oBdexZrqZ9P2dgKxTUZDCR7yerS+hkJaGL6Pn
        Ff
X-Received: by 2002:a17:907:7b8d:: with SMTP id ne13mr6469281ejc.136.1643725904405;
        Tue, 01 Feb 2022 06:31:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaMlxQDg5uPVclG2SA1eg5ZnllWOcMasdnd7IS7AQ5IUKTYNl5m4fiRpbpgX/p7pKN5sDPOA==
X-Received: by 2002:a17:907:7b8d:: with SMTP id ne13mr6469254ejc.136.1643725904126;
        Tue, 01 Feb 2022 06:31:44 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id gh14sm14554716ejb.38.2022.02.01.06.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:31:43 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: SVM: nSVM: Implement Enlightened MSR-Bitmap
 for Hyper-V-on-KVM and fix it for KVM-on-Hyper-V
In-Reply-To: <35f06589-d300-c356-dc17-2c021ac97281@redhat.com>
References: <20211220152139.418372-1-vkuznets@redhat.com>
 <35f06589-d300-c356-dc17-2c021ac97281@redhat.com>
Date:   Tue, 01 Feb 2022 15:31:42 +0100
Message-ID: <87sft2bqup.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/20/21 16:21, Vitaly Kuznetsov wrote:
>> Enlightened MSR-Bitmap feature implements a PV protocol for L0 and L1
>> hypervisors to collaborate and skip unneeded updates to MSR-Bitmap.
>> KVM implements the feature for KVM-on-Hyper-V but it seems there was
>> a flaw in the implementation and the feature may not be fully functional.
>> PATCHes 1-2 fix the problem. The rest of the series implements the same
>> feature for Hyper-V-on-KVM.
>> 
>> Vitaly Kuznetsov (5):
>>    KVM: SVM: Drop stale comment from
>>      svm_hv_vmcb_dirty_nested_enlightenments()
>>    KVM: SVM: hyper-v: Enable Enlightened MSR-Bitmap support for real
>>    KVM: nSVM: Track whether changes in L0 require MSR bitmap for L2 to be
>>      rebuilt
>>    KVM: x86: Make kvm_hv_hypercall_enabled() static inline
>>    KVM: nSVM: Implement Enlightened MSR-Bitmap feature
>> 
>>   arch/x86/kvm/hyperv.c           | 12 +--------
>>   arch/x86/kvm/hyperv.h           |  6 ++++-
>>   arch/x86/kvm/svm/nested.c       | 47 ++++++++++++++++++++++++++++-----
>>   arch/x86/kvm/svm/svm.c          |  3 ++-
>>   arch/x86/kvm/svm/svm.h          | 16 +++++++----
>>   arch/x86/kvm/svm/svm_onhyperv.h | 12 +++------
>>   6 files changed, 63 insertions(+), 33 deletions(-)
>> 
>
> Queued 3-5 now, but it would be nice to have some testcases.
>

Thanks, indeed, I'll try to draft something up, both for nVMX and nSVM.

-- 
Vitaly

