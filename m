Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A582C58800B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbiHBQON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiHBQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35B2A52FC0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659456665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1BN/Juwioxn78sXhSX6LDo1G2nc1seQzhjMfYqlHN4=;
        b=KxnUhOhFbpkr4t8I7uY0schWeZIuYEG8VBj0vmyX/FBm5TOdgKiRcAXxJQ0Um9uETWglDT
        rsvMqdiXH/zy5g/C7aTIoKfz75RnyAEmgmNULcaGoKWKCK3+gjIM92Dr5T9o7jxRWdDbHJ
        nCs4X40W/OaeGx8T0VWkPIyN2/svMM8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-lAdpah4aOiiEW9AbussiuQ-1; Tue, 02 Aug 2022 12:11:04 -0400
X-MC-Unique: lAdpah4aOiiEW9AbussiuQ-1
Received: by mail-wm1-f72.google.com with SMTP id p2-20020a05600c1d8200b003a3262d9c51so9671090wms.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 09:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F1BN/Juwioxn78sXhSX6LDo1G2nc1seQzhjMfYqlHN4=;
        b=N6X3HI5/RgiCq49Sf7Q+HJ9PzuOirgtGNgcZr5KS1Q19qwW6Ue+3wwdw3FlOC/vPLC
         T3QJr0iDXrjAyiB9qA3UQi2k5DEzpI/ZuNY5dz/iPmsUXRYy0otg+CAOBoECPd96/2f6
         tWgABsGAbbKpGXt0kct3Gq9PJdRdPIWCBXhJfX6Y9KVHrWNDM0wdMqGCkfK3CWbWwTbU
         YL4Ej7Y2IKU6jRTIysR/tGC2I8gb0GrXq66b6Y1TTPPSTOemmzcdrDd2yvV03VkKWzLO
         BmaQNXU3WP1nCXQlHpAPvLOgYpjIq8zgicYG8woL+R7za3gQvc9Km3M/7F3Yoczy1Zzk
         4Pjw==
X-Gm-Message-State: ACgBeo2Zn6mSbMd9Wlc97BnyN02sIdrcpcdT79UzU9z9rGFlOBo96CSu
        5DKvc2mkJzJlxVuuvlD8FM4+8Ii6jFRJFJJfbBS6VzwTAT4guoAmPIPKhiRFp51wYl74NruvhFT
        mmB9QbXtWM31uFFjFXgrf139Ml7+NGWXuEGwLwEZnOHeKttdFLHUGP/uPbXRoCxqs4zHUEZ7kcN
        RO
X-Received: by 2002:a05:600c:502b:b0:3a3:1f5c:57f5 with SMTP id n43-20020a05600c502b00b003a31f5c57f5mr126025wmr.5.1659456663533;
        Tue, 02 Aug 2022 09:11:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4z2D1nMb0fc3xUyccQZzyhRJhby4+XRhjb1IvU3RAlBh2PniSqCm1AcHu/nTp/gdJktDH9Ng==
X-Received: by 2002:a05:600c:502b:b0:3a3:1f5c:57f5 with SMTP id n43-20020a05600c502b00b003a31f5c57f5mr125997wmr.5.1659456663291;
        Tue, 02 Aug 2022 09:11:03 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b003a03185231bsm14130710wms.31.2022.08.02.09.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 09:11:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 24/25] KVM: VMX: Cache MSR_IA32_VMX_MISC in vmcs_config
In-Reply-To: <Ytnb2Zc0ANQM+twN@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-25-vkuznets@redhat.com>
 <Ytnb2Zc0ANQM+twN@google.com>
Date:   Tue, 02 Aug 2022 18:11:01 +0200
Message-ID: <87fsie1v8q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
>> @@ -2613,6 +2614,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>>  	if (((vmx_msr_high >> 18) & 15) != 6)
>>  		return -EIO;
>>  
>> +	rdmsrl(MSR_IA32_VMX_MISC, misc_msr);
>
> Might make sense to sanitize fields that KVM doesn't use and that are not exposed
> to L1.  Not sure it's worthwhile though as many of the bits fall into a grey area,
> e.g. all the SMM stuff isn't technically used by KVM, but that's largely because
> much of it just isn't relevant to virtualization.
>
> I'm totally ok leaving it as-is, though maybe name it "unsanitized_misc" or so
> to make that obvious?

I couldn't convince myself to add 'unsanitized_' prefix as I don't think
it significantly reduces possible confusion (the quiestion would be
'sanitized for what and in which way?') so a need for 'git grep' seems
imminent anyway. Hope I've addressed the rest of your comments in v5
though, thanks for your review!

-- 
Vitaly

