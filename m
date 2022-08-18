Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F8559873D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbiHRPVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343603AbiHRPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A05A8BC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660836029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GQGhpbZE8ROB+knhR1egNzmPjUJp4WnI2UO3qznnGI=;
        b=TiCxWfNfaoo7OG2GAolITqe0T+j8XORHAX2lDhUnB7ffAkPIWKU/hbtg/A6AOV2WhSfUYP
        i8RQUYcio62tVNM9xNUG4nGNupjA0Wn+76IMN1alMX8IAETf5Pmlry+oQ7u7ZuSa4vnEQb
        tJj8SajWeLA2nZw/NJGSQ4LxCpVDi5k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-oH6b6v52NzGSaYvtyIKEEg-1; Thu, 18 Aug 2022 11:20:28 -0400
X-MC-Unique: oH6b6v52NzGSaYvtyIKEEg-1
Received: by mail-ed1-f70.google.com with SMTP id o2-20020a056402438200b0043d552deb2aso1142100edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=3GQGhpbZE8ROB+knhR1egNzmPjUJp4WnI2UO3qznnGI=;
        b=iW3li0UReQEDPUfQv9nYOBmBpbr5E9HPfjaj2RaJrmpqE4ODlVH85UNzEclJVrgjyJ
         KrzNfD2wNp4W6uLJOkHJkpQxT7fnvT0tD1HwnP3uAKof3KArN4MmAiVOlfKHVMTA2ipa
         edcJxtNNo4CDLacMQJHB5qPqN/j2bKkaQ3oh+fwzrB1ErL+ZuPGb39FkjNJCyrBCOIda
         d8drd8ZenkvzUlmKs1auqPCOl+kM+djJ74YfIDLBm2n+rXFeFrHhSYAJqPOQ2Bp5oWuE
         AUhOdMR/AJTR0jGgmhGQArnFg4nDjI/LaNtlvUFtAqnB7KwExr/sI6GfkDoTPGKVZTN7
         7mKA==
X-Gm-Message-State: ACgBeo1PQLaZFYNre/x3htPAEpZwj2l6DNqhPmi92zcwCALaNMUcFUdp
        15DxKmmdOOdPfol3dKXhNrra0sA6oB7I7cD8v5wd16wRzyKuIz+uzO0TkC3vQeHmGZS0XLdkD/6
        KPO+oHk8c2nRRQWGgHjOysGUNCndRUpA6unYdKVXfIlqgFJCvjtNV6ZR5JKqb38hoxXNLX/CmLt
        rj
X-Received: by 2002:a17:906:9b09:b0:730:9480:9729 with SMTP id eo9-20020a1709069b0900b0073094809729mr2228173ejc.588.1660836026009;
        Thu, 18 Aug 2022 08:20:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7bh4JrZAPWDBf+wZbX/JS8gz/ZAVA15O/nNLBF7TBz5gRTyDxEDV3jKJnQao0yfUYyQPmZUg==
X-Received: by 2002:a17:906:9b09:b0:730:9480:9729 with SMTP id eo9-20020a1709069b0900b0073094809729mr2228146ejc.588.1660836025686;
        Thu, 18 Aug 2022 08:20:25 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p6-20020a05640210c600b0043df40e4cfdsm1308866edu.35.2022.08.18.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:20:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/26] KVM: x86: hyper-v: Expose access to debug MSRs
 in the partition privilege flags
In-Reply-To: <Yv5XPnSRwKduznWI@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-2-vkuznets@redhat.com>
 <Yv5XPnSRwKduznWI@google.com>
Date:   Thu, 18 Aug 2022 17:20:24 +0200
Message-ID: <878rnltw7b.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Aug 02, 2022, Vitaly Kuznetsov wrote:
>> For some features, Hyper-V spec defines two separate CPUID bits: one
>> listing whether the feature is supported or not and another one showing
>> whether guest partition was granted access to the feature ("partition
>> privilege mask"). 'Debug MSRs available' is one of such features. Add
>> the missing 'access' bit.
>> 
>> Note: hv_check_msr_access() deliberately keeps checking
>> HV_FEATURE_DEBUG_MSRS_AVAILABLE bit instead of the new HV_ACCESS_DEBUG_MSRS
>> to not break existing VMMs (QEMU) which only expose one bit. Normally, VMMs
>> should set either both these bits or none.
>
> This is not the right approach long term.  If KVM absolutely cannot unconditionally
> switch to checking HV_ACCESS_DEBUG_MSRS because it would break QEMU users, then we
> should add a quirk, but sweeping the whole thing under the rug is wrong.
>

First, this patch is kind of unrelated to the series so in case it's the
only thing which blocks it from being merged -- let's just pull it out
and discuss separately.

My personal opinion is that in this particular case we actually can
switch to checking HV_ACCESS_DEBUG_MSRS and possibly backport this patch
to stable@ and be done with it as SynDBG is a debug feature which is not
supposed to be used much in the wild. This, however, will not give us
much besides 'purity' in KVM as no sane VMM is supposed to set just one
of the HV_FEATURE_DEBUG_MSRS_AVAILABLE/HV_ACCESS_DEBUG_MSRS bits. TL;DR:
I'm not against the change.

-- 
Vitaly

