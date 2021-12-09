Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47846E3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhLIIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:09:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbhLIIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639037151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V6HCVZGkUBo6YlkT5/m2ia2EB6+EQEMb/AmjBe2o0Wc=;
        b=PVfjk3rCLixbkYTZZkWiUD1guDgK7A2G88GCj8xu9ACbAuUtnLXekJ4KjFa5L1PqMucc2B
        lqcw/vujhZ8CmiWz7W5qcmsp6FuapP6m07dzWGy2lsn6iQqR6HDhjqs6XKqWrpFoEyE0YF
        DF+hU3KLZbEBZQJTuplavzymQLc8rxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-dvz2a5HROla0xjCds642yw-1; Thu, 09 Dec 2021 03:05:47 -0500
X-MC-Unique: dvz2a5HROla0xjCds642yw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F2F13459B;
        Thu,  9 Dec 2021 08:05:45 +0000 (UTC)
Received: from localhost (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72E4F18035;
        Thu,  9 Dec 2021 08:05:43 +0000 (UTC)
Date:   Thu, 9 Dec 2021 16:05:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Lameter <cl@gentwo.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <20211209080540.GA3050@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2112070859420.201880@gentwo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/21 at 09:05am, Christoph Lameter wrote:
> On Tue, 7 Dec 2021, Baoquan He wrote:
> 
> > into ZONE_DMA32 by default. The zone DMA covering low 16M is used to
> > take care of antique ISA devices. In fact, on 64bit system, it rarely
> > need ZONE_DMA (which is low 16M) to support almost extinct ISA devices.
> > However, some components treat DMA as a generic concept, e.g
> > kmalloc-dma, slab allocator initializes it for later any DMA related
> > buffer allocation, but not limited to ISA DMA.

Thanks a lot for your reviewing and sharing.
> 
> The idea of the slab allocator DMA support is to have memory available
> for devices that can only support a limited range of physical addresses.
> These are only to be enabled for platforms that have such requirements.
> 
> The slab allocators guarantee that all kmalloc allocations are DMA able
> indepent of specifying ZONE_DMA/ZONE_DMA32

Here you mean we guarantee dma-kmalloc will be DMA able independent of
specifying ZONE_DMA/DMA32, or the whole sla/ub allocator? 

Sorry for late reply because I suddenly realized one test case is
missed. In my earlier test on this patchset, I only set crashkernel=256M
in cmdline, then it will reserve 256M memory under 4G. Then in kdump
kernel, all memory belongs to zone DMA32. So requiring dma buffer with
GFP_DMA will finally get memory from zone DMA32 since zone NORMAL
doesn't exist.

I tried crashkernel=256M,high yesterday, it will reserve 256M above 4G,
and another 256M under 4G. Then, the zone NORMAL will have memory above
4G. With this patchset applied, dma-kmalloc will take page from Normal zone,
get pages above 4G. What disappointed me is this patchset works too.

So the confusion to me is in ata_scsi device driver, it require dma buffer
with GFP_DMA, we feed it with memory above 4G, it can succeed too. I
added amd_iommu=off to cmdline to disable IOMMU. Furthermore, if on
risc and ia64, they only have zone DMA32, no zone DMA, and ata_scsi
device is deployed, it require dma buffer with GFP_DMA, but get memory
above 4G, isn't this wrong?

With my understanding, isn't the reasonable sequence zone DMA firstly if
GFP_DMA, then zone DMA32, finaly zone NORMAL. At least, on x86_64, I
believe device driver developer prefer to see this because most of time,
zone DMA and zone DMA32 are both used for dma buffer allocation, if
IOMMU is not enabled. However, memory got from zone NORMAL when required
with GFP_DMA, and it succeeds, does it mean that the developer doesn't
take the GFP_DMA flag seriously, just try to get buffer for allocation?

  --> sr_probe()
      -->get_capabilities()
         --> buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
         --> scsi_mode_sense()
             --> scsi_execute_req()
                 --> blk_rq_map_kern()
                     --> bio_copy_kern()
                         or
                     --> bio_map_kern()

> 
> > On arm64, even though both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> > are enabled, it makes ZONE_DMA covers the low 4G area, and ZONE_DMA32
> > empty. Unless on specific platforms (e.g. 30-bit on Raspberry Pi 4),
> > then zone DMA covers the 1st 1G area, zone DMA32 covers the rest of
> > the 32-bit addressable memory.
> 
> ZONE_NORMAL should cover all memory. ARM does not need ZONE_DMA32.

I grep-ed all ARCHes which provide ZONE_DMA or| and ZONE_DMA32, and
summarize them at below. From these, for ARCH-es which has DMA32, only
x86_64 and mips (which is not on platform SGI_IP22 or SGI_IP28) have
ZONE_DMA of 16M. Obviously the ZONE_DMA is created because they carry
the legacy burden of the old ISA support. Arm64 will have ZONE_DMA to
cover the low 4G by default if ACPI/DT doesn't report a shorter limit of
dma capability. While both riscv and ia64 bypass ZONE_DMA, only use
ZONE_DMA32 to cover low 4G. As for s390 and ppc64, they both takes low
2G into ZONE_DMA, and no ZONE_DMA32 provided.

=============================
ARCH which has DMA32
        ZONE_DMA       ZONE_DMA32
arm64   0~X            X~4G  (X is got from ACPI or DT. Otherwise it's 4G by default, DMA32 is empty)
ia64    None           0~4G
mips    0 or 0~16M     X~4G  (zone DMA is empty on SGI_IP22 or SGI_IP28, otherwise 16M by default like i386)
riscv   None           0~4G
x86_64  16M            16M~4G


=============================
ARCH which has no DMA32
        ZONE_DMA
alpha   0~16M or empty if IOMMU enabled
arm     0~X (X is reported by fdt, 4G by default)
m68k    0~total memory
microblaze 0~total low memory
powerpc 0~2G
s390    0~2G
sparc   0~ total low memory
i386    0~16M



> 
> > I am wondering if we can also change the size of DMA and DMA32 ZONE as
> > dynamically adjusted, just as arm64 is doing? On x86_64, we can make
> > zone DMA covers the 32-bit addressable memory, and empty zone DMA32 by
> > default. Once ISA_DMA_API is enabled, we go back to make zone DMA covers
> > low 16M area, zone DMA32 covers the rest of 32-bit addressable memory.
> > (I am not familiar with ISA_DMA_API, will it require 24-bit addressable
> > memory when enabled?)
> 
> The size of ZONE_DMA is traditionally depending on the platform. On some
> it is 16MB, on some 1G and on some 4GB. ZONE32 is always 4GB and should
> only be used if ZONE_DMA has already been used.

As said at above, ia64 and riscv don't have ZONE_DMA at all, they just
cover low 4G with ZONE_DMA32 alone.

> 
> ZONE_DMA is dynamic in the sense of being different on different
> platforms.
> 
> Generally I guess it would be possible to use ZONE_DMA for generic tagging
> of special memory that can be configured to have a dynamic size but that is
> not what it was designed to do.
> 
Thanks again for these precious sharing. I am still a little confused with
the current ZONE_DMA and it's usage, e.g in slab. May need to continue
explore.

