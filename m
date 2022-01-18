Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D5492C17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbiARRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346777AbiARRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:15:47 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E0CC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:15:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c6so16549563plh.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ic/vwIPq8hMZb1u5xWyvewRj9YxhdeiZL9lx4T7YK0I=;
        b=l00VsDI/HU/AvE+gDxvRmhKnT9k3vloXiVGVhVgWYDrUBPjsgJov6ULMUdAgYvNYnY
         T5VD4BwTXPGsCXNwiWyARX3w704vNCnU7jj3llyEvCepUQAS0Q4OVHNQ/WhEBNoEXzuM
         afU+ZmoGMHxyMaBKE5308SgszG8QNjgpze5HtALyOngnpI5NE63OFuLwPaPZzL/+fxkk
         DRL343HcZx9PzVjJtixTL6K7J5iZekCkWfuAUzB5VZlbwCJfvjCCc1OxYU/dFd3miDsd
         WwlHebBd6B1/9iSC0pQdfjP7DzbFyG7oIZTsR6i91VnT3FVYji7dGdPcLkM4voDT0+GS
         Hk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ic/vwIPq8hMZb1u5xWyvewRj9YxhdeiZL9lx4T7YK0I=;
        b=kk1CHvtt5vsVnkpZQUBnmPieUQ2oyresU/WRO3yBf9ZiZZd8reRB+y605C9+DhNbqf
         E7j8rMtQParpWqAbaJFwsuigOjP9+CliuR8YGcBOPdRIsEu6Y+cjJQZrNLEfLg6KEz+a
         WsvOU7mQonAEX4awe6u/dJhUkyoPrYTfgbUDWW5NOHBtMu9oREGg1kx/U3AFBlrB1PLk
         HOHUEFoLKroXz9sdC+DXSvZlEDq8FxxYo9wY6+Mcnn1gEfMS54xJojm0ESDI7wQV3YHI
         me3QwAyK3ZeOpRUo9P8Q+xIpznZgovbndnPG4a3kdBSSJaA/SXiz2Vdt62C8knjcwX11
         +6rw==
X-Gm-Message-State: AOAM533HRiDZhn+5KJvBEDqWDzbmdhrHsEWuQCpYE75rzK1ilkcswSlB
        63opjfKQsU7b9qO8l+snbl87Gw==
X-Google-Smtp-Source: ABdhPJyqfLBekUrDXtKwHPv8Mg0fIWxbHcJowdIs3+89lCrR9cDZNt4beNIOj5uVRfh9W4sPgnPXHQ==
X-Received: by 2002:a17:902:8ec5:b0:149:d41a:baa8 with SMTP id x5-20020a1709028ec500b00149d41abaa8mr27731830plo.115.1642526146780;
        Tue, 18 Jan 2022 09:15:46 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i3sm10949269pfu.36.2022.01.18.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:15:46 -0800 (PST)
Date:   Tue, 18 Jan 2022 17:15:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hu, Robert" <robert.hu@intel.com>,
        "Gao, Chao" <chao.gao@intel.com>
Subject: Re: [PATCH v5 8/8] KVM: VMX: Resize PID-ponter table on demand for
 IPI virtualization
Message-ID: <Yeb1vkEclYzD27R/@google.com>
References: <20211231142849.611-1-guang.zeng@intel.com>
 <20211231142849.611-9-guang.zeng@intel.com>
 <YeCjHbdAikyIFQc9@google.com>
 <43200b86-aa40-f7a3-d571-dc5fc3ebd421@intel.com>
 <YeGiVCn0wNH9eqxX@google.com>
 <67262b95-d577-0620-79bf-20fc37906869@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67262b95-d577-0620-79bf-20fc37906869@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022, Zeng Guang wrote:
> On 1/15/2022 12:18 AM, Sean Christopherson wrote:
> > Userspace can simply do KVM_CREATE_VCPU until it hits KVM_MAX_VCPU_IDS...
> IIUC, what you proposed is to use max_vcpus in kvm for x86 arch (currently
> not present yet) and
> provide new api for userspace to notify kvm how many vcpus in current vm
> session prior to vCPU creation.
> Thus IPIv can setup PID-table with this information in one shot.
> I'm thinking this may have several things uncertain:
> 1. cannot identify the exact max APIC ID corresponding to max vcpus
> APIC ID definition is platform dependent. A large APIC ID could be assigned
> to one vCPU in theory even running with
> small max_vcpus. We cannot figure out max APIC ID supported mapping to
> max_vcpus.

Gah, I conflated KVM_CAP_MAX_VCPUS and KVM_MAX_VCPU_IDS.  But the underlying idea
still works: extend KVM_MAX_VCPU_IDS to allow userspace to lower the max allowed
vCPU ID to reduce the memory footprint of densely "packed" and/or small VMs.

> 2. cannot optimize the memory consumption on PID table to the least at
> run-time
>  In case "-smp=small_n,maxcpus=large_N", kvm has to allocate memory to
> accommodate large_N vcpus at the
> beginning no matter whether all maxcpus will run.

That's a feature.  E.g. if userspace defines a max vCPU ID that is larger than
what is required at boot, e.g. to hotplug vCPUs, then consuming a few extra pages
of memory to ensure that IPIv will be supported for hotplugged vCPUs is very
desirable behavior.  Observing poor performance on hotplugged vCPUs because the
host was under memory pressure is far worse.

And the goal isn't to achieve the smallest memory footprint possible, it's to
avoid allocating 32kb of memory when userspace wants to run a VM with only a
handful of vCPUs, i.e. when 4kb will suffice.  Consuming 32kb of memory for a VM
with hundreds of vCPUs is a non-issue, e.g. it's highly unlikely to be running
multiple such VMs on a single host, and such hosts will likely have hundreds of
gb of RAM.  Conversely, hosts running run small VMs will likely run tens or hundreds
of small VMs, e.g. for container scenarios, in which case reducing the per-VM memory
footprint is much more valuable and also easier to achieve.

> 3. Potential backward-compatible problem
> If running with old QEMU version,  kvm cannot get expected information so as
> to make a fallback to use
> KVM_MAX_VCPU_IDS by default. It's feasible but not benefit on memory
> optimization for PID table.

That's totally fine.  This is purely a memory optimization, IPIv will still work
as intended if usersepace doesn't lower the max vCPU ID, it'll just consume a bit
more memory.
