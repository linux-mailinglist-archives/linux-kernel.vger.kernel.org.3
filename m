Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB51D4659A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353743AbhLAXLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:11:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343909AbhLAXLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638400092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMlQkVJN6gwOHh8YAjKJai/fldqdvC+L3um15iokg2s=;
        b=NIZtHpo22dckYyi6yFd6jAkHRreJAUM+mVDAngcYHbP8uCPrS+c5yRgzxFt6zEtULuRVUz
        qTJH/7MbSmhhFu+Syw837j+IFI2J8qbgL/GAfcJGtNwtNTHv24m9lFduPJN2yogax1fGuv
        /GDrjWvgHQlng0F5QKBUZe/eIMZcYyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-N3aM9K21NoWzIPUH04vuQA-1; Wed, 01 Dec 2021 18:08:07 -0500
X-MC-Unique: N3aM9K21NoWzIPUH04vuQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EB303E741;
        Wed,  1 Dec 2021 23:08:05 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C17D60C0F;
        Wed,  1 Dec 2021 23:08:02 +0000 (UTC)
Message-ID: <44f3f76cb14bafee2d81a615f258a4fb4be93fe1.camel@redhat.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>
Date:   Thu, 02 Dec 2021 01:08:01 +0200
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-23 at 18:10 +0200, Maxim Levitsky wrote:
> As I sadly found out, a s3 cycle makes the AMD's iommu stop sending interrupts
> until the system is rebooted.
> 
> I only noticed it now because otherwise the IOMMU works, and these interrupts
> are only used for errors and for GA log which I tend not to use by
> making my VMs do mwait/pause/etc in guest (cpu-pm=on).
> 
> There are two issues here that prevent interrupts from being generated after
> s3 cycle:
> 
> 1. GA log base address was not restored after resume, and was all zeroed
> after resume (by BIOS or such).
> 
> In theory if BIOS writes some junk to it, that can even cause a memory corruption.
> Patch 2 fixes that.
> 
> 2. INTX (aka x2apic mode) settings were not restored after resume.
> That mode is used regardless if the host uses/supports x2apic, but rather when
> the IOMMU supports it, and mine does.
> Patches 3-4 fix that.
> 
> Note that there is still one slight (userspace) bug remaining:
> During suspend all but the boot CPU are offlined and then after resume
> are onlined again.
> 
> The offlining moves all non-affinity managed interrupts to CPU0, and
> later when all other CPUs are onlined, there is nothing in the kernel
> to spread back the interrupts over the cores.
> 
> The userspace 'irqbalance' daemon does fix this but it seems to ignore
> the IOMMU interrupts in INTX mode since they are not attached to any
> PCI device, and thus they remain on CPU0 after a s3 cycle,
> which is suboptimal when the system has multiple IOMMUs
> (mine has 4 of them).
> 
> Setting the IRQ affinity manually via /proc/irq/ does work.
> 
> This was tested on my 3970X with both INTX and regular MSI mode (later was enabled
> by patching out INTX detection), by running a guest with AVIC enabled and with
> a PCI assigned device (network card), and observing interrupts from
> IOMMU while guest is mostly idle.
> 
> This was also tested on my AMD laptop with 4650U (which has the same issue)
> (I tested only INTX mode)
> 
> Patch 1 is a small refactoring to remove an unused struct field.
> 
> Best regards,
>    Maxim Levitsky
> 
> Maxim Levitsky (5):
>   iommu/amd: restore GA log/tail pointer on host resume
>   iommu/amd: x2apic mode: re-enable after resume
>   iommu/amd: x2apic mode: setup the INTX registers on mask/unmask
>   iommu/amd: x2apic mode: mask/unmask interrupts on suspend/resume
>   iommu/amd: remove useless irq affinity notifier
> 
>  drivers/iommu/amd/amd_iommu_types.h |   2 -
>  drivers/iommu/amd/init.c            | 107 +++++++++++++++-------------
>  2 files changed, 58 insertions(+), 51 deletions(-)
> 
> -- 
> 2.26.3
> 
> 

Polite ping on these patches.
Best regards,
	Maxim Levitsky

