Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B9D574F35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiGNNbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiGNNbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 473F45E332
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657805475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0v84aQzK5VtpJNrL8vNxYh4ihCQcbd1OPMTZNLA4YQ=;
        b=FP7yZmw8Hv1pzEX4sSsN6C/zxwSL239OIupbNkb+He527/vdWOjuAGZaBAeSlKa4QZ0RW+
        FUjRa0Dix1YE0f2tEoTThpobZWlB4jTD1NgOidPYQtej7UqPeK3UdY/5wIKaa6xue1IDPY
        8yEcUgRCxxAJSuGC30Y5DDSb4Mm6fLE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-HatHPJGqPTyP_JhXSeviqw-1; Thu, 14 Jul 2022 09:31:14 -0400
X-MC-Unique: HatHPJGqPTyP_JhXSeviqw-1
Received: by mail-ed1-f71.google.com with SMTP id y21-20020a056402359500b0043adf65d1a0so1528331edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=S0v84aQzK5VtpJNrL8vNxYh4ihCQcbd1OPMTZNLA4YQ=;
        b=fuqB/MEw7omvR6oLspDshMom5RjUAbNfFhdu1C2W57Nk0Th5yqX2pIQ7tLbrAT4IbC
         ZrRhea+KSnAYF7Ekcq3n6TSHLUWJW6OKXcSmgjyYXckA1h+uHKkN26c32amrYvLV5abc
         /fvm86WImu1/lV5YSmY4psMg9C71oq8L0f9cwgaXN7x2Ex6jpKyQT1D+Nibsz1auI6X1
         KfUgnj1Pm8KjD59El27/tmZ/PtX1+o4ilnMN6Ykz+CpJeqPKE8+sNzq0MNXHBDivY4ai
         ztoodsUyA3GV1v0MDSL9LryGY93p67yIV6uKvBnlz61xECPqiVzUZay6lNR9WTtR9MUB
         /q9A==
X-Gm-Message-State: AJIora9cfClaZrWZ8Uea00DudMMcXRnuSShMlptTSAgX0GM1oqhCBzib
        Dg5zI+SYyz/vrsYkRs4COZHDuBkUejvv7y2y6Lyg1p+T4rhyvxGG1CW3EI1NkyzIDYTAYFBgt+F
        TsAQZO6QOQ3jjPjjIYOj3ftamyWmHpPDFiCEISGNoMhlMyDIEK7jhRnt1yP7Dn4doceF4DAkS5Z
        31
X-Received: by 2002:a17:906:93ef:b0:72b:3e88:a47 with SMTP id yl15-20020a17090693ef00b0072b3e880a47mr8830208ejb.706.1657805472953;
        Thu, 14 Jul 2022 06:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vyGA2DyNCno5IElXh8b5C5z7Aa3bmVWSnWLiTNc6SnaMdy9mGR7CFk8LpUKsaLOZngHRWmXQ==
X-Received: by 2002:a17:906:93ef:b0:72b:3e88:a47 with SMTP id yl15-20020a17090693ef00b0072b3e880a47mr8830179ejb.706.1657805472717;
        Thu, 14 Jul 2022 06:31:12 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402035100b0043a6a7048absm1049315edw.95.2022.07.14.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:31:12 -0700 (PDT)
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
Subject: Re: [PATCH v7 00/39] KVM: x86: hyper-v: Fine-grained TLB flush + L2
 TLB flush features
In-Reply-To: <eab4d1d8-913d-71b8-b48e-01ff83bc128f@redhat.com>
References: <20220613133922.2875594-1-vkuznets@redhat.com>
 <eab4d1d8-913d-71b8-b48e-01ff83bc128f@redhat.com>
Date:   Thu, 14 Jul 2022 15:31:11 +0200
Message-ID: <87a69bom74.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/13/22 15:38, Vitaly Kuznetsov wrote:
>> Changes since v6:
>> - Rebase to the latest kvm/queue [8baacf67c76c], newly introduced
>>    selftests had to be adapted to the overhauled API [blame Sean].
>> - Rename 'entry' to 'flush_all_entry' in hv_tlb_flush_enqueue() [Max].
>> - Add "KVM: selftests: Rename 'evmcs_test' to 'hyperv_evmcs'" patch.
>> - Collect R-b tags.
>> 
>> Original description:
>> 
>> Currently, KVM handles HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} requests
>> by flushing the whole VPID and this is sub-optimal. This series introduces
>> the required mechanism to make handling of these requests more
>> fine-grained by flushing individual GVAs only (when requested). On this
>> foundation, "Direct Virtual Flush" Hyper-V feature is implemented. The
>> feature allows L0 to handle Hyper-V TLB flush hypercalls directly at
>> L0 without the need to reflect the exit to L1. This has at least two
>> benefits: reflecting vmexit and the consequent vmenter are avoided + L0
>> has precise information whether the target vCPU is actually running (and
>> thus requires a kick).
>
> I haven't reviewed the selftests part yet, but for the rest I only had 
> two very small comments.

I got back to this today and turns out there's a conflict with 

commit cc5851c6be864c5772944e32df3da322fe3ad415
Author: Sean Christopherson <seanjc@google.com>
Date:   Wed Jun 8 22:45:15 2022 +0000

    KVM: selftests: Use exception fixup for #UD/#GP Hyper-V MSR/hcall tests
 
in selftest part. It's nothing big but I did some non-trivial changes
when resolving and I think the reslut looks a bit nicer at the end.
Also, I've addresed one of your comments and moved
kvm_hv_get_tlb_flush_fifo()'s 'is_guest_mode' parameter introduction to
PATCH11. I'm going to send out v8 with these changes.

-- 
Vitaly

