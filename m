Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02D49C708
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbiAZKEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:04:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233384AbiAZKD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643191439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrFLYJ9cry+WM5T0ZEL1s3Cr9YcXnG7PMN9SDbX6/ww=;
        b=OOK0kTTiqqPmQM2ACobTrTs3ejLh1gCFFy0tTBMNssqoDQEh7g/ig4mXcQcM7SH0OyXTl1
        q7p4e86VzU4wVIvz9yWwKrsWEND/R7uBQ8jytmngBEfT5tT44/kfjobrMDQodJscFZUfOB
        1vIRdp7Pbxwv+I2rXz7eHVVLUkR4CeI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-x5CTQOX0PHWkT9o4X0egsw-1; Wed, 26 Jan 2022 05:03:57 -0500
X-MC-Unique: x5CTQOX0PHWkT9o4X0egsw-1
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a056402268f00b00408234dc1dfso5860495edd.16
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XrFLYJ9cry+WM5T0ZEL1s3Cr9YcXnG7PMN9SDbX6/ww=;
        b=dOMPMOoMYqK8bKClES0bodb9vFg+gJU1rkO0h/19MIRdK7TVTeLq2FLNgkx9r8a6gr
         dia0/WQRWFmLqCdmVMlSu7RiPfjkq33lOjeNJdawhd4LmEcn0OvESu0zyN+wRa3f7WVG
         eRRN+ECm7DLjzmTl5uu4z1lLcGZx3MuDcsXitnm9ols2ziCJ9rVz+vDDbGtMOiI93h8h
         xGzrY5H8g7bdyxj1Dx9npvV0sTuQ00ph6vGAe0yD6Xq5Ol1eiiRpeDPBI1+FKkiEAcux
         ClnvToQ/KnXBHXdBiW5nq6dbP6QPXys3fNmLyCKXSYqKeBh5ftaNRBzKXny/Y5lic8PF
         1Jhg==
X-Gm-Message-State: AOAM531OCZBHIgOlSfEeZ7AC9AnE+qa0gBk4B4dONPGMgmzAJt4pJ3SY
        no9Z+aFgkWVUOA7Hm9dLy2SRCwhJ7XMK+QnvdobZoDpxb9pHxzIyH9grdvvUnzl9PBQybYdzvI0
        aEDV4w/zxNKT83fogLz2M5qph
X-Received: by 2002:a17:906:cc84:: with SMTP id oq4mr20750935ejb.736.1643191436680;
        Wed, 26 Jan 2022 02:03:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRQ+0XLF4POUmxWH8EJJr77JEz8GW0+2DZNmA1meDp2yb7dCZHSIEtz1s7LpmPIel02UXIsg==
X-Received: by 2002:a17:906:cc84:: with SMTP id oq4mr20750919ejb.736.1643191436473;
        Wed, 26 Jan 2022 02:03:56 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id rv9sm7151085ejb.216.2022.01.26.02.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 02:03:55 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] KVM: x86: Use memcmp in kvm_cpuid_check_equal()
In-Reply-To: <864dfbfdc44e288e99cf7baa3aa8f7c8568db507.camel@perches.com>
References: <20220124103606.2630588-1-vkuznets@redhat.com>
 <20220124103606.2630588-3-vkuznets@redhat.com>
 <864dfbfdc44e288e99cf7baa3aa8f7c8568db507.camel@perches.com>
Date:   Wed, 26 Jan 2022 11:03:54 +0100
Message-ID: <878rv2izjp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Mon, 2022-01-24 at 11:36 +0100, Vitaly Kuznetsov wrote:
>> kvm_cpuid_check_equal() should also check .flags equality but instead
>> of adding it to the existing check, just switch to using memcmp() for
>> the whole 'struct kvm_cpuid_entry2'.
>
> Is the struct padding guaranteed to be identical ?
>

Well, yes (or we're all doomeed):
- 'struct kvm_cpuid_entry2' is part of KVM userspace ABI, it is supposed
to be stable.
- Here we compare structs which come from the same userspace during one
session (vCPU fd stays open), I can't imagine how structure layout can
change on-the-fly.

-- 
Vitaly

