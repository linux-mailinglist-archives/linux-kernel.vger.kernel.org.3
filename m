Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3378048E541
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiANIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:12:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236790AbiANIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642147961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwuxbIX1i5Dfm9gk8fkBbEk0Kx7vWseXfNpMD4fzRhg=;
        b=LerQaxZYEwsB+fJc2Yy26XiSYXvSVZuDChqnuvSBfbEMsL1JHGg2h35gt8GqST7lSxV79D
        GE4XAx9le4Zg8tbViM6FV9M2zi1agLn8cOy+mxXHU2oK1fesWIFb+nXDdQspFJCsce/R8n
        hknbuoQi0GBP0g8a2+2HG0n7epXRUIE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-Sz1_lUJ7OsCMNu3F1LIAjQ-1; Fri, 14 Jan 2022 03:12:40 -0500
X-MC-Unique: Sz1_lUJ7OsCMNu3F1LIAjQ-1
Received: by mail-wm1-f69.google.com with SMTP id a3-20020a05600c348300b0034a0dfc86aaso4936169wmq.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dwuxbIX1i5Dfm9gk8fkBbEk0Kx7vWseXfNpMD4fzRhg=;
        b=B/kbx6I3jVjXSEiapKsgAr82p6p9eR+tGCKIvLHAJFkinscg+RWrv9ARTkN8sF/gzy
         fWZ809V1oHqwuVhVtI+0+OrhQlKa/Pt3/CETn1B1/J3a/QOkr46u+2jl7YtJ6Y/e2SrQ
         ShauYnCYORBp122UqGjyt4XY0dNGOuAfssuNHFKrNHjdO9PpPtvRAW68i+QxBfxog5On
         qKNG1QxNA6GyiX3DFwjEEC/sjRs2R9a4AsMk8/NGk9Tsh7qxQw4ZYnOU542x4QTvE0U0
         LATQT02I/eMYAl4oyn9fQBENUrVTD5JB36NzL9j1Xoq+ctFuDN2WD0mXQfFjHmj+bziE
         eWNg==
X-Gm-Message-State: AOAM533D4BM+LBY8nFSnM7YkO1g7MAf3Hys+LJ/bNx5/8Oh5waqJVY6P
        VKuVhT+4uqeErfTIkXpOzyegi0MG5NF7YOacSNziAMSqpLGuDTSe2xnDEvj6Kj/fttgt+Mm3Pnk
        9lD6O9Jj39GbJrEw3tKXz1rbDbd9ZuwsUI8KKnP2B/XNppohxOkS6KNJQoiewFXYMDh4HQpuQkj
        VF
X-Received: by 2002:a5d:6586:: with SMTP id q6mr7426430wru.62.1642147958989;
        Fri, 14 Jan 2022 00:12:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYS3u4Ps5fXTlLgsznvhnty33P7q3kjewzPzh1N7ViZUtbk0nln9x6reL1Wi8sEumeVB28mQ==
X-Received: by 2002:a5d:6586:: with SMTP id q6mr7426403wru.62.1642147958704;
        Fri, 14 Jan 2022 00:12:38 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e4sm1807548wrq.51.2022.01.14.00.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 00:12:37 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: x86: Partially allow KVM_SET_CPUID{,2} after
 KVM_RUN for CPU hotplug
In-Reply-To: <YeCEyNz/xqcJBcU/@google.com>
References: <20220113133703.1976665-1-vkuznets@redhat.com>
 <YeCEyNz/xqcJBcU/@google.com>
Date:   Fri, 14 Jan 2022 09:12:37 +0100
Message-ID: <87o84en3be.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jan 13, 2022, Vitaly Kuznetsov wrote:
>> Recently, KVM made it illegal to change CPUID after KVM_RUN but
>> unfortunately this change is not fully compatible with existing VMMs.
>> In particular, QEMU reuses vCPU fds for CPU hotplug after unplug and it
>> calls KVM_SET_CPUID2. Relax the requirement by implementing an allowlist
>> of entries which are allowed to change.
>
> Honestly, I'd prefer we give up and just revert feb627e8d6f6 ("KVM: x86: Forbid
> KVM_SET_CPUID{,2} after KVM_RUN").  Attempting to retroactively restrict the
> existing ioctls is becoming a mess, and I'm more than a bit concerned that this
> will be a maintenance nightmare in the future, without all that much benefit to
> anyone.

I cannot say I disagree)

>
> I also don't love that the set of volatile entries is nothing more than "this is
> what QEMU needs today".  There's no architectural justification, and the few cases
> that do architecturally allow CPUID bits to change are disallowed.  E.g. OSXSAVE,
> MONITOR/MWAIT, CPUID.0x12.EAX.SGX1 are all _architecturally_ defined scenarios
> where CPUID can change, yet none of those appear in this list.  Some of those are
> explicitly handled by KVM (runtime CPUID updates), but why should it be illegal
> for userspace to intercept writes to MISC_ENABLE and do its own CPUID emulation?

I see. Another approach would be to switch from the current allowlist
approach to a blocklist of things which we forbid to change
("MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, ...") after the
first KVM_RUN.

-- 
Vitaly

