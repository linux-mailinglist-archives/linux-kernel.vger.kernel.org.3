Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD81A58ACEC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbiHEPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiHEPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:08:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 805C21A392
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:08:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64E7E113E;
        Fri,  5 Aug 2022 08:08:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E67183F73B;
        Fri,  5 Aug 2022 08:08:22 -0700 (PDT)
Date:   Fri, 5 Aug 2022 16:08:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
Subject: Re: [5.19.0] [aarch64] WARNING: CPU: 0 PID: 1 at
 mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
Message-ID: <20220805150820.3q4kwrlh7qrt7poa@bogus>
References: <CA+QYu4rPbfH-4wNR06Vn=31RCGKFFEB-KRskn52Jtig_UugYzg@mail.gmail.com>
 <20220805135955.5to2bm6ou35p5zsy@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805135955.5to2bm6ou35p5zsy@bogus>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:59:55PM +0100, Sudeep Holla wrote:
> On Fri, Aug 05, 2022 at 11:47:57AM +0200, Bruno Goncalves wrote:
> > Hello,
> > 
> > Since commit "c1c76700a0d6" we started to hit the following call trace
> > on aarch64 VMs when looking at journalctl log
> >
> > kernel: Mountpoint-cache hash table entries: 16384 (order: 5, 131072
> > bytes, linear)
> > kernel: ACPI PPTT: No PPTT table found, CPU and cache topology may be inaccurate
> > kernel: ------------[ cut here ]------------
> > kernel: WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
> > kernel: Modules linked in:
> > kernel: CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0 #1
> > kernel: pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > kernel: pc : __alloc_pages+0x1a0/0x290
> > kernel: lr : alloc_page_interleave+0x24/0xbc
> > kernel: sp : ffff80000803bb90
> > kernel: x29: ffff80000803bb90 x28: 0000000000000000 x27: 0000000000000000
> > kernel: x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> > kernel: x23: 000000000000001e x22: 0000000000000000 x21: 000000000000001e
> > kernel: x20: 000000000000001e x19: 0000000000040b20 x18: 0000000000000014
> > kernel: x17: 6e69206562207961 x16: 6d2079676f6c6f70 x15: 6f74206568636163
> > kernel: x14: 20646e6120555043 x13: 6574617275636361 x12: 6e69206562207961
> > kernel: x11: 6d2079676f6c6f70 x10: 6f74206568636163 x9 : ffffa4f6617fd5e8
> > kernel: x8 : ffffa4f663ed0440 x7 : 0000000000000007 x6 : 0000000000000000
> > kernel: x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> > kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffa4f663c53532
> > kernel: Call trace:
> > kernel:  __alloc_pages+0x1a0/0x290
> > kernel:  alloc_page_interleave+0x24/0xbc
> > kernel:  alloc_pages+0x10c/0x16c
> > kernel:  kmalloc_order+0x3c/0xc0
> > kernel:  kmalloc_order_trace+0x38/0x130
> > kernel:  __kmalloc+0x2e8/0x350
> > kernel:  detect_cache_attributes+0x9c/0x110
> > kernel:  update_siblings_masks+0x34/0x270
> > kernel:  store_cpu_topology+0x7c/0xc0
> > kernel:  smp_prepare_cpus+0x34/0x108
> > kernel:  kernel_init_freeable+0x108/0x1b8
> > kernel:  kernel_init+0x30/0x150
> > kernel:  ret_from_fork+0x10/0x20
> > kernel: ---[ end trace 0000000000000000 ]---
> > kernel: Early cacheinfo failed, ret = -12
> > kernel: cblist_init_generic: Setting adjustable number of callback queues.
> > kernel: cblist_init_generic: Setting shift to 2 and lim to 1.
> >
> 
> Thanks for the report. I will see if I can reproduce by forcing the absence
> of PPTT which is something I haven't tested after I fixed hotplug issues
> reported with my changes.

OK I was able to reproduce this easily by just saying PPTT doesn't exist
on my system. Not sure if my recent changes made this issue show up easily
or it existed even w/o my changes but it is stupid issue :(.

Can you check if this fixes it for you ? I can post the patch once
you confirm. We assign negative/error value to unsigned int and then
the number of leaves ends up with that value because of wrong comparison.

Regards,
Sudeep

-->8
diff --git i/arch/arm64/kernel/cacheinfo.c w/arch/arm64/kernel/cacheinfo.c
index 587543c6c51c..97c42be71338 100644
--- i/arch/arm64/kernel/cacheinfo.c
+++ w/arch/arm64/kernel/cacheinfo.c
@@ -45,7 +45,8 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,

 int init_cache_level(unsigned int cpu)
 {
-       unsigned int ctype, level, leaves, fw_level;
+       unsigned int ctype, level, leaves;
+       int fw_level;
        struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);

        for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
@@ -63,6 +64,9 @@ int init_cache_level(unsigned int cpu)
        else
                fw_level = acpi_find_last_cache_level(cpu);

+       if (fw_level < 0)
+               return fw_level;
+
        if (level < fw_level) {
                /*
                 * some external caches not specified in CLIDR_EL1

