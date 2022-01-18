Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB4492D16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347888AbiARSRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347872AbiARSRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:17:05 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8EAC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:17:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id a1-20020a17090a688100b001b3fd52338eso101846pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=12XZNpl8o9OB6APkzQqhlT2zDw8cBU9If0BRD2I3ujg=;
        b=pRX729irqFCPWqSZqfankoziffIirA/BN8R3rB4h45WiVzTpUfouL7NgCbxQdk00y2
         cJp+rsxu40ORiWBHD8xLKcv2kDBDqHJyUGZp9hsCmtmpPtXM6oMr4XFHpftMqpBuHyMi
         vE2XlapaFzKwjlWP/ZbLWgMAv/S1k5nTL/GgbOa04UxlKHpOcQovKM5LvmE39v2XpUVb
         eGlP19Qm3+ZKKFMdEpcn6vffp7wQOF+f5ulXjB1FCXZjBPvegq1P+ZoQJpyvqBEkHvre
         rCcvSVzBZYB2aVCma8XXfPg1Awf+5R/0ciiAByNtI1i2Qti1/4ifU7yennKOQ/81bdLF
         31pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=12XZNpl8o9OB6APkzQqhlT2zDw8cBU9If0BRD2I3ujg=;
        b=muF9kYbeWybdyRl0pzCVZKXHATp6BIy7sU593mJq6xd6RvONMWBpyxwlmr9mlhH4ht
         l8c28/EWxH6SI6baf79OQeA04RMwQnzgrjb3Aaf3pkHUJ74/zsD/JCt/M+8NQfgPv0nG
         D1Co60Bepyr/yaSRvp8N4wIxDNUt4GAjR0lfO2vz9rgPFMsAJHP1XFga+KC3DPVOZIxA
         nm6XSWlldz5/Lb37dM7jrUNbna46AxWC7jORknCMu+LkEh4sJsqPUh7xWXjxeZaa4+Ap
         deruZyQliZb/EoNN79eHuwKDfGoYHPX7rGdMyB4CARMzUVjK0RG9jmty8zoyv50gAJOe
         8wMw==
X-Gm-Message-State: AOAM533E5mReqdotIKpFBTCCLpRcfaq/txwBJP8I7AmOcVkaKTgSB/3f
        WmBUODcrTEvGpyS0lr4v6RGalA==
X-Google-Smtp-Source: ABdhPJyUSRbqIj2dSKIkusY2dU90msA5PvqdUHgKeVHIUXXv8vkWDAtgQs/5nZz810lFDv8k38rKOA==
X-Received: by 2002:a17:90b:1892:: with SMTP id mn18mr22529691pjb.244.1642529824176;
        Tue, 18 Jan 2022 10:17:04 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q17sm18927985pfj.119.2022.01.18.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:17:03 -0800 (PST)
Date:   Tue, 18 Jan 2022 18:17:00 +0000
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
Subject: Re: [PATCH v5 5/8] KVM: x86: Support interrupt dispatch in x2APIC
 mode with APIC-write VM exit
Message-ID: <YecEHF9Dqf3E3t02@google.com>
References: <20211231142849.611-1-guang.zeng@intel.com>
 <20211231142849.611-6-guang.zeng@intel.com>
 <YeCZpo+qCkvx5l5m@google.com>
 <ec578526-989d-0913-e40e-9e463fb85a8f@intel.com>
 <YeG0Fdn/2++phMWs@google.com>
 <8ab5f976-1f3e-e2a5-87f6-e6cf376ead2f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ab5f976-1f3e-e2a5-87f6-e6cf376ead2f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022, Zeng Guang wrote:
> > What about tweaking my prep patch from before to the below?  That would yield:
> > 
> > 	if (apic_x2apic_mode(apic)) {
> > 		if (WARN_ON_ONCE(offset != APIC_ICR))
> > 			return 1;
> > 
> > 		kvm_lapic_msr_read(apic, offset, &val);
> 
> I think it's problematic to use kvm_lapic_msr_read() in this case. It
> premises the high 32bit value already valid at APIC_ICR2, while in handling
> "nodecode" x2APIC writes we need get continuous 64bit data from offset 300H
> first and prepare emulation of APIC_ICR2 write.

Ah, I read this part of the spec:

  All 64 bits of the ICR are written by using WRMSR to access the MSR with index 830H.
  If ECX = 830H, WRMSR writes the 64-bit value in EDX:EAX to the ICR, causing the APIC
  to send an IPI. If any of bits 13, 17:16, or 31:20 are set in EAX, WRMSR detects a
  reserved-bit violation and causes a general-protection exception (#GP).

but not the part down below that explicit says

  VICR refers the 64-bit field at offset 300H on the virtual-APIC page. When the
  “virtualize x2APIC mode” VM-execution control is 1 (indicating virtualization of
  x2APIC mode), this field is used to virtualize the entire ICR.

But that's indicative of an existing KVM problem.  KVM's emulation of x2APIC is
broken.  The SDM, in section 10.12.9 ICR Operation in x2APIC Mode, clearly states
that the ICR is extended to 64-bits.  ICR2 does not exist in x2APIC mode, full stop.
KVM botched things by effectively aliasing ICR[63:32] to ICR2.

We can and should fix that issue before merging IPIv suport, that way we don't
further propagate KVM's incorrect behavior.  KVM will need to manipulate the APIC
state in KVM_{G,S}ET_LAPIC so as not to "break" migration, "break" in quotes because
I highly doubt any kernel reads ICR[63:32] for anything but debug purposes.  But
we'd need to do that anyways for IPIv, otherwise migration from an IPIv host to
a non-IPIv host would suffer the same migration bug.

I'll post a series this week, in theory we should be able to reduce the patch for
IPIv support to just having to only touching kvm_apic_write_nodecode().
