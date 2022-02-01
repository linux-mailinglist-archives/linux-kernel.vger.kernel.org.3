Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827174A676A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiBAV6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiBAV6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:58:02 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66608C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:58:02 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a8so17075212pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 13:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ltjF8d5F9x1GgyN29xq25R53ErC8uPxRhu4AGyyM9y4=;
        b=cmJgpg0t93ZTq37e52YSl1WdM61IEHRAVm9N0bLgmydloJWktxnqq1gzaQaVT3kNuH
         yxtTUembz+YViRgIGF1K0LucVHYx12NimPAMTl5sxbXUomHerJyoPCJtyxdCFOpNl32D
         9rZI34Zs4H/yZl38SNvcH5OfxxRc20MyDcYsYDx/Alg55hVVBLMbos2REb5lgyVJP5LW
         w8nZOZSRJAFePucr7ko54yhIF9mRSSg0GtQfWnxGUCpXsvxzVC/bGG1eZBE1Ct4k/gev
         Ua0I8gc+YdFC3B4iechxGb8tdS1TdRp/Nvl05ggoPyKWqNNGG5txVg7ba72VY/TUCKrr
         qd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ltjF8d5F9x1GgyN29xq25R53ErC8uPxRhu4AGyyM9y4=;
        b=oyv97os/PfBNjBtkWeih3OdjOwQSuYgzlBQnvI0Ua7C5qGR5Qt4lWpAaF1on51cMd3
         Wq26XZ0sg5sjhkgXje5Fnvwwbnowp2tuu5QY0N8ohmo1+VmieO/ALmoA4oRw2GP22C3Z
         bM5eyw7cpcS7Ker3imdhAb7z3EZrlHoGeFflRWWo1MBIE2z/G66YvITz70fhA+kmDAfo
         5DGw0Yqi8nX00LjzzEAmKp87uvHOUUoOVSdQ+kw284WUdk3CZzdLeRDFzJDwpHgSgxM1
         beyXQ2INnVZmwjyG20M5jkzLF6X3r/SZAuBUjGHPCRcXgEmjTFAoyzyLTItQ+jNg+ril
         8eng==
X-Gm-Message-State: AOAM532CJQ1oO1OwHI87zeEaCkA9M6zi+JHcy5HQELc512YXagiqf17+
        3iqQ351pc+fVwSjFXfGEaHfp7A==
X-Google-Smtp-Source: ABdhPJwUYUmjATCCR09YewooMx3240UOnyinweW9dy971jFx83HnD9dHa4UJh4yNWaC8bz26ZlWpyw==
X-Received: by 2002:a05:6a00:1494:: with SMTP id v20mr26687004pfu.82.1643752681672;
        Tue, 01 Feb 2022 13:58:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id lp17sm4202784pjb.25.2022.02.01.13.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:58:00 -0800 (PST)
Date:   Tue, 1 Feb 2022 21:57:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, joro@8bytes.org, mlevitsk@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        peterz@infradead.org, hpa@zytor.com, thomas.lendacky@amd.com,
        jon.grimm@amd.com
Subject: Re: [PATCH v3 3/3] KVM: SVM: Extend host physical APIC ID field to
 support more than 8-bit
Message-ID: <Yfms5evHbN8JVbVX@google.com>
References: <20211213113110.12143-1-suravee.suthikulpanit@amd.com>
 <20211213113110.12143-4-suravee.suthikulpanit@amd.com>
 <Yc3qt/x1YPYKe4G0@google.com>
 <34a47847-d80d-e93d-a3fe-c22382977c1c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34a47847-d80d-e93d-a3fe-c22382977c1c@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022, Suthikulpanit, Suravee wrote:
> > That implies that an APIC ID > 255 on older hardware what ignores bits 11:8 even
> > in x2APIC will silently fail, and the whole point of this mask is to avoid exactly
> > that.
> 
> On current AMD system w/ x2APIC and 256 cpus (e.g. max APIC ID is 255), it would only
> need 8 bits in the physical APIC ID table entry, and the bit 11:9 are reserved.
> For newer system, it could take upto 12 bits to represent APIC ID.

But x2APIC IDs are 32-bit values that, from the APM, are model specific:

  The x2APIC_ID is a concatenation of several fields such as socket ID, core ID
  and thread ID.

  Because the number of sockets, cores and threads may differ for each SOC, the
  format of x2APIC ID is model-dependent.

In other words, there's nothing that _architecturally_ guarantees 8 bits are
sufficient to hold the x2APIC ID.

> > But at least one APM blurb appears to have been wrong (or the architecture is broken)
> > prior to the larger AVIC width:
> > 
> >    Since a destination of FFh is used to specify a broadcast, physical APIC ID FFh
> >    is reserved.
> > 
> > We have Rome systems with 256 CPUs and thus an x2APIC ID for a CPU of FFh.  So
> > either the APM is wrong or AVIC is broken on older large systems.
> 
> Actually, the statement is referred to the guest physical APIC ID, which is used to
> index the per-vm physical APIC table in the host. So, it should be correct in the case
> of AVIC, which only support APIC mode in the guest.

Ah.  If you have the ear of the APM writers, can you ask that they insert a "guest",
e.g. so that it reads:

  Since a destination of FFh is used to specify a broadcast, guest physical APIC ID FFh is reserved.
 
> > Anyways, for the new larger mask, IMO dynamically computing the mask based on what
> > APIC IDs were enumerated to the kernel is pointless.  If the AVIC doesn't support
> > using bits 11:0 to address APIC IDs then KVM is silently hosed no matter what if
> > any APIC ID is >255.
> 
> The reason for dynamic mask is to protect the reserved bits, which varies between
> the current platform (i.e 11:8) vs. newer platform (i.e. 11:10), in which
> there is no good way to tell except to check the max_physical_apicid (see below).

...

> > Ideally, there would be a feature flag enumerating the larger AVIC support so we
> > could do:
> > 
> > 	if (!x2apic_mode || !boot_cpu_has(X86_FEATURE_FANCY_NEW_AVIC))
> > 		avic_host_physical_id_mask = GENMASK(7:0);
> > 	else
> > 		avic_host_physical_id_mask = GENMASK(11:0);
> > 
> > but since it sounds like that's not the case, and presumably hardware is smart
> > enough not to assign APIC IDs it can't address, this can simply be
> > 
> > 	if (!x2apic_mode)
> > 		avic_host_physical_id_mask = GENMASK(7:0);
> > 	else
> > 		avic_host_physical_id_mask = GENMASK(11:0);
> > 
> > and patch 01 to add+export apic_get_max_phys_apicid() goes away.
> 
> Unfortunately, we do not have the "X86_FEATURE_FANCY_NEW_AVIC" CPUID bit :(
> 
> Also, based on the previous comment, we can't use the x2APIC mode in the host
> to determine such condition. Hence, the need for dynamic mask based on
> the max_physical_apicid.

I don't get this.  The APM literally says bits 11:8 are:

  Reserved/SBZ for legacy APIC; extension of Host Physical APIC ID when
  x2APIC is enabled.

so we absolutely should be able to key off x2APIC mode.  IMO, defining the mask
based on apic_get_max_phys_apicid() is pointless and misleading.  The only thing
it really protects is passing in a completely bogus value, e.g. -1.  If for some
reason bits 11:8 are ignored/reserved by older CPUs even in x2APIC, and the CPU
assigns an x2APIC ID with bits 11:8!=0, then KVM is hosed no matter what as the
dynamic calculation will also allow the "bad" ID.
