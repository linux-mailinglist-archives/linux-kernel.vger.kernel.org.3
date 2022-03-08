Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8731F4D1B80
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbiCHPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbiCHPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:18:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE20CB868
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:17:37 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228DhBWu012080;
        Tue, 8 Mar 2022 15:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=LjyKfmfP7Vu839xRleqUuDgBE/97p6EYx1iD9+26bz4=;
 b=WWymZ9cSzZTx8cIV56lEJ2JHuAP/8Fjz88Pj97crTw/dUbjtyMapqtnBKbj8mv39GJbn
 QJe2RfFul5xP6tX1PxN3QsV0R95bNIt0+ePt73HtlnxHx/AxlXRNQpiihOMr0KKMR1+w
 P49McYN3ag1ocsnEIjvVzFFIZiepIwwXtP0cRsHKclRzkmhxLKqWEgGZhWjw3ojBfAUs
 6slqXKqIJnsqi4LImsAt9pgfIa3OBTd9S/zx8c0JcuaE7R4Rxc5xfDgfWJP7EqTn1rq5
 BRVoHrIWqMAW7ZP+PzLycfjI70SCRQ96ggWl43JYYPS4E8DQ6y3wUVjhm7Mbelf9zCL+ 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep03vmc0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 15:17:22 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228EMiv6023011;
        Tue, 8 Mar 2022 15:17:21 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep03vmby9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 15:17:21 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228F7aQ1010428;
        Tue, 8 Mar 2022 15:17:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3ekyg96s3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 15:17:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228FHF6Z49611084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 15:17:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B139842041;
        Tue,  8 Mar 2022 15:17:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 014B04203F;
        Tue,  8 Mar 2022 15:17:15 +0000 (GMT)
Received: from localhost (unknown [9.171.12.198])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Mar 2022 15:17:14 +0000 (GMT)
Date:   Tue, 8 Mar 2022 16:17:13 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v6 31/39] kasan, vmalloc: only tag normal vmalloc
 allocations
Message-ID: <your-ad-here.call-01646752633-ext-6250@work.hours>
References: <cover.1643047180.git.andreyknvl@google.com>
 <fbfd9939a4dc375923c9a5c6b9e7ab05c26b8c6b.1643047180.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbfd9939a4dc375923c9a5c6b9e7ab05c26b8c6b.1643047180.git.andreyknvl@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iDBgHtSy0Ow09BuHd6Oj4wKSrRssGLUg
X-Proofpoint-ORIG-GUID: WqPy8d8WPu5_9RZv83SYr5ei94IiJE9c
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_05,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 07:05:05PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> The kernel can use to allocate executable memory. The only supported way
> to do that is via __vmalloc_node_range() with the executable bit set in
> the prot argument. (vmap() resets the bit via pgprot_nx()).
> 
> Once tag-based KASAN modes start tagging vmalloc allocations, executing
> code from such allocations will lead to the PC register getting a tag,
> which is not tolerated by the kernel.
> 
> Only tag the allocations for normal kernel pages.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

This breaks s390 and produce huge amount of false positives.
I haven't been testing linux-next with KASAN for while, now tried it with
next-20220308 and bisected false positives to this commit.

Any idea what is going wrong here?

I see 2 patterns:

[    1.123723] BUG: KASAN: vmalloc-out-of-bounds in ftrace_plt_init+0xb8/0xe0
[    1.123740] Write of size 8 at addr 001bffff80000000 by task swapper/0/1
[    1.123745]
[    1.123749] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc7-118520-ga20d77ce812a #142
[    1.123755] Hardware name: IBM 8561 T01 701 (KVM/Linux)
[    1.123758] Call Trace:
[    1.123761]  [<000000000218e5fe>] dump_stack_lvl+0xc6/0xf8
[    1.123782]  [<0000000002176cb4>] print_address_description.constprop.0+0x64/0x2f0
[    1.123793]  [<000000000086fd3e>] kasan_report+0x15e/0x1c8
[    1.123802]  [<0000000000870f5c>] kasan_check_range+0x174/0x1c0
[    1.123808]  [<0000000000871988>] memcpy+0x58/0x88
[    1.123813]  [<000000000342cea8>] ftrace_plt_init+0xb8/0xe0
[    1.123819]  [<0000000000101522>] do_one_initcall+0xc2/0x468
[    1.123825]  [<000000000341ffc6>] do_initcalls+0x1be/0x1e8
[    1.123830]  [<0000000003420504>] kernel_init_freeable+0x494/0x4e8
[    1.123834]  [<0000000002196556>] kernel_init+0x2e/0x180
[    1.123838]  [<000000000010625a>] __ret_from_fork+0x8a/0xe8
[    1.123843]  [<00000000021b557a>] ret_from_fork+0xa/0x40
[    1.123852]
[    1.123854]
[    1.123856] Memory state around the buggy address:
[    1.123861]  001bffff7fffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    1.123865]  001bffff7fffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    1.123868] >001bffff80000000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[    1.123872]                    ^
[    1.123874]  001bffff80000080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[    1.123878]  001bffff80000100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8

$ cat /sys/kernel/debug/kernel_page_tables
---[ Modules Area Start ]---
0x001bffff80000000-0x001bffff80001000         4K PTE RO X
0x001bffff80001000-0x001bffff80002000         4K PTE I
0x001bffff80002000-0x001bffff80003000         4K PTE RO X
0x001bffff80003000-0x001bffff80004000         4K PTE I

[    1.409146] BUG: KASAN: vmalloc-out-of-bounds in bpf_jit_binary_alloc+0x138/0x170
[    1.409154] Write of size 4 at addr 001bffff80002000 by task systemd/1
[    1.409158]
[    1.409160] CPU: 0 PID: 1 Comm: systemd Tainted: G    B   W         5.17.0-rc7-118520-ga20d77ce812a #141
[    1.409166] Hardware name: IBM 8561 T01 701 (KVM/Linux)
[    1.409169] Call Trace:
[    1.409171]  [<000000000218e5fe>] dump_stack_lvl+0xc6/0xf8
[    1.409176]  [<0000000002176cb4>] print_address_description.constprop.0+0x64/0x2f0
[    1.409183]  [<000000000086fd3e>] kasan_report+0x15e/0x1c8
[    1.409188]  [<0000000000588860>] bpf_jit_binary_alloc+0x138/0x170
[    1.409192]  [<000000000019fa84>] bpf_int_jit_compile+0x814/0xca8
[    1.409197]  [<000000000058b60e>] bpf_prog_select_runtime+0x286/0x3e8
[    1.409202]  [<000000000059ac2e>] bpf_prog_load+0xe66/0x1a10
[    1.409206]  [<000000000059ebd4>] __sys_bpf+0x8bc/0x1088
[    1.409211]  [<000000000059f9e8>] __s390x_sys_bpf+0x98/0xc8
[    1.409216]  [<000000000010ce74>] do_syscall+0x22c/0x328
[    1.409221]  [<000000000219599c>] __do_syscall+0x94/0xf0
[    1.409226]  [<00000000021b5542>] system_call+0x82/0xb0
[    1.409232]
[    1.409234]
[    1.409235] Memory state around the buggy address:
[    1.409238]  001bffff80001f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[    1.409242]  001bffff80001f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[    1.409246] >001bffff80002000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[    1.409249]                    ^
[    1.409251]  001bffff80002080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
[    1.409255]  001bffff80002100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8

$ git bisect log
git bisect start
# good: [ea4424be16887a37735d6550cfd0611528dbe5d9] Merge tag 'mtd/fixes-for-5.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
git bisect good ea4424be16887a37735d6550cfd0611528dbe5d9
# bad: [cb153b68ff91cbc434f3de70ac549e110543e1bb] Add linux-next specific files for 20220308
git bisect bad cb153b68ff91cbc434f3de70ac549e110543e1bb
# good: [1ce7aac49a7b73abbd691c6e6a1577a449d90bad] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 1ce7aac49a7b73abbd691c6e6a1577a449d90bad
# good: [08688e100b1b07ce178c1d3c6b9983e00cd85413] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
git bisect good 08688e100b1b07ce178c1d3c6b9983e00cd85413
# good: [82a204646439657e5c2f94da5cad7ba96de10414] Merge branch 'togreg' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git bisect good 82a204646439657e5c2f94da5cad7ba96de10414
# good: [ac82bf337c937458bf4f75985857bf3a68cd7c16] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
git bisect good ac82bf337c937458bf4f75985857bf3a68cd7c16
# good: [a36f330518af9bd205451bedb4eb22a5245cf010] ipc/mqueue: use get_tree_nodev() in mqueue_get_tree()
git bisect good a36f330518af9bd205451bedb4eb22a5245cf010
# good: [339c1d0fb400ab3acd2da2d9990242f654689f6e] Merge branch 'for-next' of git://git.infradead.org/users/willy/pagecache.git
git bisect good 339c1d0fb400ab3acd2da2d9990242f654689f6e
# good: [b8a58fecbd4982211f528d405a9ded00ddc7d646] kasan: only apply __GFP_ZEROTAGS when memory is zeroed
git bisect good b8a58fecbd4982211f528d405a9ded00ddc7d646
# bad: [141e05389762bee5fb0eb54af9c4d5266ce11d26] kasan: drop addr check from describe_object_addr
git bisect bad 141e05389762bee5fb0eb54af9c4d5266ce11d26
# good: [97fedbc9a6bccd508c392b0e177380313dd9fcd2] kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
git bisect good 97fedbc9a6bccd508c392b0e177380313dd9fcd2
# bad: [606c2ee3fabbf66594f39998be9b5a21c2bf5dff] arm64: select KASAN_VMALLOC for SW/HW_TAGS modes
git bisect bad 606c2ee3fabbf66594f39998be9b5a21c2bf5dff
# bad: [bd2c296805cff9572080bf56807c16d1dd382260] kasan, scs: support tagged vmalloc mappings
git bisect bad bd2c296805cff9572080bf56807c16d1dd382260
# good: [7b80fa947b3a3ee746115395d1c5f7157119b7d2] kasan, vmalloc: add vmalloc tagging for HW_TAGS
git bisect good 7b80fa947b3a3ee746115395d1c5f7157119b7d2
# bad: [f51c09448ea124622f8ebcfb41d06c809ee01bca] fix for "kasan, vmalloc: only tag normal vmalloc allocations"
git bisect bad f51c09448ea124622f8ebcfb41d06c809ee01bca
# bad: [a20d77ce812a3e11b3cf2cb4f411904bb5c6edaa] kasan, vmalloc: only tag normal vmalloc allocations
git bisect bad a20d77ce812a3e11b3cf2cb4f411904bb5c6edaa
# first bad commit: [a20d77ce812a3e11b3cf2cb4f411904bb5c6edaa] kasan, vmalloc: only tag normal vmalloc allocations
