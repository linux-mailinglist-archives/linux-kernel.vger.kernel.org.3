Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F6748E71C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbiANJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:08:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233696AbiANJIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642151334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/tbnGn76vQBdBcG0duWBnDfwWlVcLC0sTsv0law7hM=;
        b=VBVd/lzlgaPNlhue3YF2nEAPP8NKUKUukNfGUIbzXa3LT8i2ufPnFntoXLFkJc2ljJlXjO
        sHLuwHakeck996F2MRIRYsiJ29XtVe3d7y59uqu1iKv7Us5avwSLAqcpnpXsdXLVQrUV4G
        1ZBUcnaDGASEE7umTZVI0Q+Cncn3jJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-1NvuK3KMNy2qqLqB6gBWuQ-1; Fri, 14 Jan 2022 04:08:52 -0500
X-MC-Unique: 1NvuK3KMNy2qqLqB6gBWuQ-1
Received: by mail-wm1-f71.google.com with SMTP id p14-20020a1c544e000000b003490705086bso1895268wmi.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/tbnGn76vQBdBcG0duWBnDfwWlVcLC0sTsv0law7hM=;
        b=HT0xZnTtw6r0rprO6/HTaMzqf2gIQDhNcuQmWjT+0LArzKeIuvrBIgNWFRHye7i4Nc
         LgFn5jwv6EaH++Y/D5vxpoQP9FMmjXO+UUdLQUz7KGlkwlX/jbDD/7iueO+CQqcJwBrF
         V+hMRDmeVeQ2AMIieQluAUn6Js8zyxZJRfVTe3MOwN5DmpS6nAgoDecf2McQIBp2cBg8
         LkIOoarXj73pJKFHCvhylvxadFhxpG9oTibNwnx2hoWJjFaBBdIW5qZaqChTA4G0Q8Z9
         5JaTUV4qkv2UWXdy/Y/iAi7Lbu8ZTumdWgXTPujyQmgar7fd5dBG7qzx3dGTLBfRfoZQ
         H3mQ==
X-Gm-Message-State: AOAM533XItS3gQEPgPBmB5C0ln8wE0D1he6g3RIiIIuayQChAF6DttPL
        9qRbhTv6XTCvuUq9SCARNUXzSGHy86xU+ZVEDhrHKitN2Y0n9pij6C286BPBKXcVnG1gIU+rH0X
        RlPZTbO2LN2DUpZIfsn9suAlS
X-Received: by 2002:a05:600c:1987:: with SMTP id t7mr7419118wmq.154.1642151331131;
        Fri, 14 Jan 2022 01:08:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhfoN2OOQTjZHsQIIXa/cBFJoRQxv2LUVrveuV4ufsBMcmahcNTF92eV8tlV7pZYOpXGshBA==
X-Received: by 2002:a05:600c:1987:: with SMTP id t7mr7419089wmq.154.1642151330842;
        Fri, 14 Jan 2022 01:08:50 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b15sm1339696wrr.50.2022.01.14.01.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 01:08:50 -0800 (PST)
Date:   Fri, 14 Jan 2022 10:08:49 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: x86: Partially allow KVM_SET_CPUID{,2} after
 KVM_RUN for CPU hotplug
Message-ID: <20220114100849.277c04ee@redhat.com>
In-Reply-To: <YeCEyNz/xqcJBcU/@google.com>
References: <20220113133703.1976665-1-vkuznets@redhat.com>
        <YeCEyNz/xqcJBcU/@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 20:00:08 +0000
Sean Christopherson <seanjc@google.com> wrote:

> On Thu, Jan 13, 2022, Vitaly Kuznetsov wrote:
> > Recently, KVM made it illegal to change CPUID after KVM_RUN but
> > unfortunately this change is not fully compatible with existing VMMs.
> > In particular, QEMU reuses vCPU fds for CPU hotplug after unplug and it
> > calls KVM_SET_CPUID2. Relax the requirement by implementing an allowlist
> > of entries which are allowed to change.  
> 
> Honestly, I'd prefer we give up and just revert feb627e8d6f6 ("KVM: x86: Forbid
> KVM_SET_CPUID{,2} after KVM_RUN").  Attempting to retroactively restrict the
> existing ioctls is becoming a mess, and I'm more than a bit concerned that this
> will be a maintenance nightmare in the future, without all that much benefit to
> anyone.

in 63f5a1909f9 ("KVM: x86: Alert userspace that KVM_SET_CPUID{,2} after KVM_RUN is broken")
you mention heterogeneous configuration, and that implies that
a userspace (not upstream qemu today) might attempt to change CPUID
and that would be wrong. Do we still care about that?


> I also don't love that the set of volatile entries is nothing more than "this is
> what QEMU needs today".  There's no architectural justification, and the few cases
> that do architecturally allow CPUID bits to change are disallowed.  E.g. OSXSAVE,
> MONITOR/MWAIT, CPUID.0x12.EAX.SGX1 are all _architecturally_ defined scenarios
> where CPUID can change, yet none of those appear in this list.  Some of those are
> explicitly handled by KVM (runtime CPUID updates), but why should it be illegal
> for userspace to intercept writes to MISC_ENABLE and do its own CPUID emulation?
> 

