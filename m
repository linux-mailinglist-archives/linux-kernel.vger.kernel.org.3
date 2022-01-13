Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE948DF00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiAMUc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiAMUcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:32:24 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9827C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:32:24 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id pf13so11722306pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IBBvh2HyvrQNgAk8nsnFygdbZgVbnHld6EIlEZF4byk=;
        b=IZYm8sjK++Epb1sCJOa9WlP9JC0uaQ5sCqs9bhxBkI5th0EbHHinHBGTc8ThIFHPCa
         3/8vkEnwwJrgPUBejs1x5i1SLnTQuJL7HTRof15OoyHepv3f5qd9YRFS2IEGPEOZrHJi
         gxfTZdkFJ9PZBL8lxQBf39XOOS5xLZkFfvqQygF8wWLBvG5ZT67bBWwEJET/UN/dfOoD
         WrPYlDpd/WAbQzlQ1YcU+OHYQiR4rnZboq6v14fiRp2RoygJRyid4igpLyPoMO5jn2Na
         dankI5k6phkSWVCYausyZl0ezi/EtJ6nURLtqoB7LXnnY41gPES6c4D88yj0Qm6sebb2
         nNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IBBvh2HyvrQNgAk8nsnFygdbZgVbnHld6EIlEZF4byk=;
        b=Nw9xohLFvggSce4/r6OAWd9+8x4qdcv/X+IqSebyiAKMjJCSZK3M0EuOBUKRUqVfdf
         uwMDqmBZ+8s4NqpUzPsxG7nzypJAZDtoYOxe6V/ToFocuzeY1sOzdKtpaMAN4SGWKc+H
         lMusYSaZXdSN/OpvGLXEKm5QwA05+bNGJbDbphZlF0Bauojx5JBGtqx3c9SR0qe4VUSk
         mEDOOIf0D/IwfPggS/6bsYa6s+zKLvdLoCvvIMxo3O5tbeGQQZ1aeQA6jHX1zFsOKPHA
         ipicSG8008nf+iiyly2W4712R3oKMC8ZPLiL3F1z0zoZGplDIlDbgQ45Ak1e62JYWkX4
         HJuw==
X-Gm-Message-State: AOAM5314/9YhunncRgls7CWEJ6xT1Nn0uSBzsgQ1axJcV882nYOC789D
        PhhJjD2XC+/g41R00P+9XyeV2Q==
X-Google-Smtp-Source: ABdhPJyJInld7xic/jv+S+zn11PGGJlJ8c2yZYRUoj39U0+h90AcpLgEmQ3Ua2SgAsvEgFkkhKsISQ==
X-Received: by 2002:a17:90b:33ce:: with SMTP id lk14mr7050477pjb.25.1642105944046;
        Thu, 13 Jan 2022 12:32:24 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f13sm3558589pfv.98.2022.01.13.12.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 12:32:23 -0800 (PST)
Date:   Thu, 13 Jan 2022 20:32:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup.patel@wdc.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        benh@kernel.crashing.org, borntraeger@linux.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, david@redhat.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, imbrenda@linux.ibm.com, james.morse@arm.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        maz@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        nsaenzju@redhat.com, palmer@dabbelt.com, paulmck@kernel.org,
        paulus@samba.org, paul.walmsley@sifive.com, pbonzini@redhat.com,
        suzuki.poulose@arm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Subject: Re: [PATCH 1/5] kvm: add exit_to_guest_mode() and
 enter_from_guest_mode()
Message-ID: <YeCMVGqiVfTKESzy@google.com>
References: <20220111153539.2532246-1-mark.rutland@arm.com>
 <20220111153539.2532246-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111153539.2532246-2-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022, Mark Rutland wrote:
> Atop this, new exit_to_guest_mode() and enter_from_guest_mode() helpers
> are added to handle the ordering of lockdep, tracing, and RCU manageent.
> These are named to align with exit_to_user_mode() and
> enter_from_user_mode().
> 
> Subsequent patches will migrate architectures over to the new helpers,
> following a sequence:
> 
> 	guest_timing_enter_irqoff();
> 
> 	exit_to_guest_mode();

I'm not a fan of this nomenclature.  First and foremost, virtualization refers to
transfers to guest mode as VM-Enter, and transfers from guest mode as VM-Exit.
It's really, really confusing to read this code from a virtualization perspective.
The functions themselves are contradictory as the "enter" helper calls functions
with "exit" in their name, and vice versa.

We settled on xfer_to_guest_mode_work() for a similar conundrum in the past, though
I don't love using xfer_to/from_guest_mode() as that makes it sound like those
helpers handle the actual transition into guest mode, i.e. runs the vCPU.

To avoid too much bikeshedding, what about reusing the names we all compromised
on when we did this for x86 and call them kvm_guest_enter/exit_irqoff()?  If x86
is converted in the first patch then we could even avoid temporary #ifdefs.

> 	< run the vcpu >
> 	enter_from_guest_mode();
> 	< take any pending IRQs >
> 
> 	guest_timing_exit_irqoff();
