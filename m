Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BAB4C8F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiCAQBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiCAQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:01:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93FD99D4CC;
        Tue,  1 Mar 2022 08:01:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BA2F1042;
        Tue,  1 Mar 2022 08:01:11 -0800 (PST)
Received: from lpieralisi (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE2B73F70D;
        Tue,  1 Mar 2022 08:01:09 -0800 (PST)
Date:   Tue, 1 Mar 2022 16:00:59 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Henry Willard <henry.willard@oracle.com>
Cc:     James Morse <James.Morse@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Colin King <colin.king@canonical.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH][V2] ACPI: sysfs: copy ACPI data using io memory copying
Message-ID: <Yh5DOz/u2hf3Eu5Z@lpieralisi>
References: <20200317165409.469013-1-colin.king@canonical.com>
 <20200320131951.GA6555@lakrids.cambridge.arm.com>
 <698da6fc-3334-5420-5c97-4406914e4599@arm.com>
 <88DFC1B9-D444-4D44-963F-34D0F5B9EC01@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88DFC1B9-D444-4D44-963F-34D0F5B9EC01@oracle.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:51:23PM +0000, Henry Willard wrote:
> 
> 
> > On Apr 1, 2020, at 5:44 AM, James Morse <james.morse@arm.com> wrote:
> > 
> > Hello!
> > 
> > On 3/20/20 1:19 PM, Mark Rutland wrote:
> >> [adding James and Lorenzo]
> > 
> > (but not actually...)
> > 
> > 
> >> On Tue, Mar 17, 2020 at 04:54:09PM +0000, Colin King wrote:
> >>> From: Colin Ian King <colin.king@canonical.com>
> >>> 
> >>> Reading ACPI data on ARM64 at a non-aligned offset from
> >>> /sys/firmware/acpi/tables/data/BERT will cause a splat because
> >>> the data is I/O memory mapped
> > 
> > On your platform, on someone else's it may be in memory.
> > 
> > Which platform is this on?
> > (I've never seen one generate a BERT!)
> 
> I have seen this on several platforms. The latest is an Altra based machine. It shows up in the Linux Test Project: ltp test "read_all -d /sys -q -r 10”. 
> > 
> > 
> >>> and being read with just a memcpy.
> >>> Fix this by introducing an I/O variant of memory_read_from_buffer
> >>> and using I/O memory mapped copies instead.
> > 
> >> Just to check, is that correct is it correct to map those tables with
> >> Device attributes in the first place, or should we be mapping the tables
> >> with Normal Cacheable attributes with memremap()?
> >> 
> >> If the FW placed those into memory using cacheavble attributes, reading
> >> them using Device attributes could result in stale values, which could
> >> be garbage.
> > 
> > Yes. The BERT code should be using arch_apei_get_mem_attribute() to use the
> > correct attributes. See ghes_map() for an example. bert_init() will need to use
> > a version of ioremap() that takes the pgprot_t.
> > 
> > Always using ioremap_cache() means you get a cacheable mapping, regardless of
> > how firmware described this region in the UEFI memory map. This doesn't explain
> > why you got an alignment fault.
> 
> The BERT error region doesn’t appear in the UEFI memory map on any of the systems I have looked at. This means that acpi_os_map_memory() will always map the area  as PROT_DEVICE_nGnRnE, which results in an alignment fault on an unaligned access. For some reason this does not fail on some implementations.
> 
> It isn’t clear to me from the ACPI spec whether this can be in anything other than normal memory as bert_init() seems to assume it is.
> 
> We have used this patch to resolve this problem on the assumption it
> will eventually make it into the mainline kernel. Is there any chance
> this will happen? 

Yes this should be fixed. I put together a patch that I needed to post,
below.

-- >8 --
Subject: [PATCH] ACPI: osl: Fix BERT error region memory mapping

Currently the sysfs interface maps the BERT error region as "memory"
(through acpi_os_map_memory()) in order to copy the error records into
memory buffers through memory operations (eg memory_read_from_buffer()).

The OS system cannot detect whether the BERT error region is part of
system RAM or it is "device memory" (eg BMC memory) and therefore it
cannot detect which memory attributes the bus to memory support (and
corresponding kernel mapping, unless firmware provides the required
information).

The acpi_os_map_memory() arch backend implementation determines the
mapping attributes. On arm64, if the BERT error region is not present in
the EFI memory map, the error region is mapped as device-nGnRnE; this
triggers alignment faults since memcpy unaligned accesses are not
allowed in device-nGnRnE regions.

The ACPI sysfs code cannot therefore map by default the BERT error
region with memory semantics but should use a safer default.

Change the sysfs code to map the BERT error region as MMIO (through
acpi_os_map_iomem()) and use the memcpy_fromio() interface to read the
error region into the kernel buffer.

Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
Link: https://lore.kernel.org/linux-acpi/CAJZ5v0g+OVbhuUUDrLUCfX_mVqY_e8ubgLTU98=jfjTeb4t+Pw@mail.gmail.com
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/sysfs.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a4b638bea6f1..cc2fe0618178 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -415,19 +415,30 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
 			      loff_t offset, size_t count)
 {
 	struct acpi_data_attr *data_attr;
-	void *base;
-	ssize_t rc;
+	void __iomem *base;
+	ssize_t size;
 
 	data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
+	size = data_attr->attr.size;
+
+	if (offset < 0)
+		return -EINVAL;
+
+	if (offset >= size)
+		return 0;
 
-	base = acpi_os_map_memory(data_attr->addr, data_attr->attr.size);
+	if (count > size - offset)
+		count = size - offset;
+
+	base = acpi_os_map_iomem(data_attr->addr, size);
 	if (!base)
 		return -ENOMEM;
-	rc = memory_read_from_buffer(buf, count, &offset, base,
-				     data_attr->attr.size);
-	acpi_os_unmap_memory(base, data_attr->attr.size);
 
-	return rc;
+	memcpy_fromio(buf, base + offset, count);
+
+	acpi_os_unmap_iomem(base, size);
+
+	return count;
 }
 
 static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
-- 
2.31.0
