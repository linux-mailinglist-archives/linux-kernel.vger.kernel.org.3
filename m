Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EABB463EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbhK3UGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343560AbhK3UGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:06:11 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF84C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:02:51 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f125so7773238pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TtquChD6pqbLM/34QcxaGCa4B/5f160ThA/DKBOfIeU=;
        b=gKapa6qSyvrxjM7bRTUs5VyFbxFMN7z0/w7RwyRHVgBkhp5TgIPEGvTSJw554hVx47
         aC0HuzlSwk0LZqE2YfXuApAYxfcy12jMhhFloCFL/WmW/e6mSv88FqpggIMFkvGfkWLq
         r0qXe2sjP5Uft+VgjrfhiesFgeuXAwMo3EwkdfissO4BbTTnG6TQ3zchuMBotOXW16H2
         Q6haO49WrumKm0TVgyDOsppkYXtp2qg8GYKooG87yBsuA2yp9RHiUIhpYAzai8XqxJ58
         9GYIBKS6p9yEsoSGf1J9T35DXcAXmiZRzoE50bD8SDmY/etS4oi2er9PEBCrvxaGqync
         bxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TtquChD6pqbLM/34QcxaGCa4B/5f160ThA/DKBOfIeU=;
        b=K7OScxOTB8kQ5x8qzmPQ5gionWKDfEDHdC29ZamKevTIQvSBPiE3vy7+1+YmJQXF/V
         5FRuYoBrg01ueEMRct8yzluCpngeG6HK7GAcT4wJMv4hqfKBJdagohGwjzylPpFCBh1L
         xi1quxYRWi/L3kSdHPs3Skk/nvYuni4XEEFXHwhYQiwtRCVltZ6mnqPZgIdFhfikr5wS
         Y4eZhNAGgNOVKRQP8ZgFnO3EPRwRuO46wVJnmQSgNjH09F4C69xn1zUKoTzdiSTd7fpX
         k7o8YT6pVY1t3IprARAXyY/6RV/veijTq7iSmqE5bM1VBbK6a/cxlibPazGdXMBL/10k
         ek/A==
X-Gm-Message-State: AOAM5328vyxYWTNset0VHyTrATlp4HsYLiOensFPHQyMto5xVaS4bJnv
        1Emhz5Oee9Woj5NsvnAMrvhSfA==
X-Google-Smtp-Source: ABdhPJwZ/pL3YCl/mmEp1PboX8ftk1vCx/rIPZqFYRPbDMXbvdw448ypLuFyURIOQONiRLwc2Wbbug==
X-Received: by 2002:aa7:8e48:0:b0:4a7:fe01:5971 with SMTP id d8-20020aa78e48000000b004a7fe015971mr1102647pfr.20.1638302570894;
        Tue, 30 Nov 2021 12:02:50 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y23sm15087205pgf.86.2021.11.30.12.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:02:50 -0800 (PST)
Date:   Tue, 30 Nov 2021 20:02:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Gao, Chao" <chao.gao@intel.com>
Subject: Re: Q. about KVM and CPU hotplug
Message-ID: <YaaDZ+84JVoGZhRL@google.com>
References: <BL1PR11MB54295ADE4D7A81523EA50B2D8C679@BL1PR11MB5429.namprd11.prod.outlook.com>
 <3d3296f0-9245-40f9-1b5a-efffdb082de9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3296f0-9245-40f9-1b5a-efffdb082de9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021, Paolo Bonzini wrote:
> On 11/30/21 09:27, Tian, Kevin wrote:
> > 		r = kvm_arch_hardware_enable();
> > 
> > 		if (r) {
> > 			cpumask_clear_cpu(cpu, cpus_hardware_enabled);
> > 			atomic_inc(&hardware_enable_failed);
> > 			pr_info("kvm: enabling virtualization on CPU%d failed\n", cpu);
> > 		}
> > 	}
> > 
> > Upon error hardware_enable_failed is incremented. However this variable
> > is checked only in hardware_enable_all() called when the 1st VM is called.
> > 
> > This implies that KVM may be left in a state where it doesn't know a CPU
> > not ready to host VMX operations.
> > 
> > Then I'm curious what will happen if a vCPU is scheduled to this CPU. Does
> > KVM indirectly catch it (e.g. vmenter fail) and return a deterministic error
> > to Qemu at some point or may it lead to undefined behavior? And is there
> > any method to prevent vCPU thread from being scheduled to the CPU?
> 
> It should fail the first vmptrld instruction.  It will result in a few
> WARN_ONCE and pr_warn_ratelimited (see vmx_insn_failed).  For VMX this
> should be a pretty bad firmware bug, and it has never been reported. KVM did
> find some undocumented errata but not this one!

Heh, writing MSR_TEST_CTRL on some CPUs, e.g. Haswell, magically disables VMX.
Not exactly CPU hotplug, but we got close :-)  But yeah, if enabling VMX fails,
something in the CPU is badly mangled.

009bce1df0bb ("x86/split_lock: Don't write MSR_TEST_CTRL on CPUs that aren't whitelisted")
