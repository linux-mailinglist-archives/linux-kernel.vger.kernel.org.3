Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93358AC0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbiHEOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbiHEOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:00:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5813054AFA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:59:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADB66106F;
        Fri,  5 Aug 2022 06:59:59 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A0C83F73B;
        Fri,  5 Aug 2022 06:59:58 -0700 (PDT)
Date:   Fri, 5 Aug 2022 14:59:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
Subject: Re: [5.19.0] [aarch64] WARNING: CPU: 0 PID: 1 at
 mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
Message-ID: <20220805135955.5to2bm6ou35p5zsy@bogus>
References: <CA+QYu4rPbfH-4wNR06Vn=31RCGKFFEB-KRskn52Jtig_UugYzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4rPbfH-4wNR06Vn=31RCGKFFEB-KRskn52Jtig_UugYzg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 11:47:57AM +0200, Bruno Goncalves wrote:
> Hello,
> 
> Since commit "c1c76700a0d6" we started to hit the following call trace
> on aarch64 VMs when looking at journalctl log
>
> kernel: Mountpoint-cache hash table entries: 16384 (order: 5, 131072
> bytes, linear)
> kernel: ACPI PPTT: No PPTT table found, CPU and cache topology may be inaccurate
> kernel: ------------[ cut here ]------------
> kernel: WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:5407 __alloc_pages+0x1a0/0x290
> kernel: Modules linked in:
> kernel: CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0 #1
> kernel: pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> kernel: pc : __alloc_pages+0x1a0/0x290
> kernel: lr : alloc_page_interleave+0x24/0xbc
> kernel: sp : ffff80000803bb90
> kernel: x29: ffff80000803bb90 x28: 0000000000000000 x27: 0000000000000000
> kernel: x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> kernel: x23: 000000000000001e x22: 0000000000000000 x21: 000000000000001e
> kernel: x20: 000000000000001e x19: 0000000000040b20 x18: 0000000000000014
> kernel: x17: 6e69206562207961 x16: 6d2079676f6c6f70 x15: 6f74206568636163
> kernel: x14: 20646e6120555043 x13: 6574617275636361 x12: 6e69206562207961
> kernel: x11: 6d2079676f6c6f70 x10: 6f74206568636163 x9 : ffffa4f6617fd5e8
> kernel: x8 : ffffa4f663ed0440 x7 : 0000000000000007 x6 : 0000000000000000
> kernel: x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffa4f663c53532
> kernel: Call trace:
> kernel:  __alloc_pages+0x1a0/0x290
> kernel:  alloc_page_interleave+0x24/0xbc
> kernel:  alloc_pages+0x10c/0x16c
> kernel:  kmalloc_order+0x3c/0xc0
> kernel:  kmalloc_order_trace+0x38/0x130
> kernel:  __kmalloc+0x2e8/0x350
> kernel:  detect_cache_attributes+0x9c/0x110
> kernel:  update_siblings_masks+0x34/0x270
> kernel:  store_cpu_topology+0x7c/0xc0
> kernel:  smp_prepare_cpus+0x34/0x108
> kernel:  kernel_init_freeable+0x108/0x1b8
> kernel:  kernel_init+0x30/0x150
> kernel:  ret_from_fork+0x10/0x20
> kernel: ---[ end trace 0000000000000000 ]---
> kernel: Early cacheinfo failed, ret = -12
> kernel: cblist_init_generic: Setting adjustable number of callback queues.
> kernel: cblist_init_generic: Setting shift to 2 and lim to 1.
>

Thanks for the report. I will see if I can reproduce by forcing the absence
of PPTT which is something I haven't tested after I fixed hotplug issues
reported with my changes.

--
Regards,
Sudeep
