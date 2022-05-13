Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC252652A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359513AbiEMOrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381451AbiEMOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:47:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB46A26AC0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:47:02 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DEfKEc014841;
        Fri, 13 May 2022 14:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=aY9cCpQhk5YJUEcFvnayBr2hyBjVfibfTgjX2zMTo1w=;
 b=PJF/JcmebnfuhsH+82Yltp8NTMgyExdlQ69bql1uqkyq02wk/mglv38USTXUaMOYKG5V
 qUzqgE2AG4uFjMw+bNJ3IT3aI5CUzgvrxGHKvECwyDOrK/jEy9EkPlTrX5xAKPDO/uhk
 xNryhk6nDTC4L3dmYRk9xlXfNWvt2DDMH89uRNIIeLpAZ9w9Y+B5SxcczwCpoIztUTzs
 ZY0hYho7aP7DsYibrxdmJ4FNeBi11bAwobv89mQmpLZekiA5pQWl/F7C6F1WiOgZLSvr
 B0jwsNO/TPjvGWUT/q0uLQDYg0xXsnHr8iswGL5gu6PGCRbeDTwXyGnRq6HcKu8jYK/i cQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1rvkgtvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 14:46:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DEhfjI007151;
        Fri, 13 May 2022 14:46:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk4pyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 14:46:43 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DEkfQN41943414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:46:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C52DD42049;
        Fri, 13 May 2022 14:46:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FA5A42045;
        Fri, 13 May 2022 14:46:41 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 13 May 2022 14:46:41 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mapletree-vs-khugepaged
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
Date:   Fri, 13 May 2022 16:46:41 +0200
In-Reply-To: <YmvVkKXJWBoGqWFx@osiris> (Heiko Carstens's message of "Fri, 29
        Apr 2022 14:09:52 +0200")
Message-ID: <yt9dk0apbicu.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _--nQ_yDx5hd6yqrCtxXkhTVIBcKE11C
X-Proofpoint-ORIG-GUID: _--nQ_yDx5hd6yqrCtxXkhTVIBcKE11C
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=801 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <hca@linux.ibm.com> writes:

> On Thu, Apr 28, 2022 at 10:20:40AM -0700, Guenter Roeck wrote:
>> On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
>> > Fix mapletree for patch series "Make khugepaged collapse readonly FS THP
>> > more consistent", v3.
>> > 
>> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> 
>> This patch causes all my sparc64 boot tests to fail. Bisect and crash logs
>> attached.
>> 
>> Guenter
>> 
>> ---
>> [   12.624703] Unable to handle kernel paging request at virtual address 0e00000000000000
>> [   12.624793] tsk->{mm,active_mm}->context = 0000000000000005
>> [   12.624823] tsk->{mm,active_mm}->pgd = fffff800048b8000
>> [   12.624849]               \|/ ____ \|/
>> [   12.624849]               "@'/ .. \`@"
>> [   12.624849]               /_| \__/ |_\
>> [   12.624849]                  \__U_/
>> [   12.624874] init(1): Oops [#1]
>> [   12.625194] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc4-next-20220428 #1
>> [   12.625421] TSTATE: 0000009911001606 TPC: 00000000005e6330 TNPC: 00000000005e6334 Y: 00000000    Not tainted
>> [   12.625455] TPC: <mmap_region+0x150/0x700>
>> [   12.625503] g0: 0000000000619a00 g1: 0000000000000000 g2: fffff8000488b200 g3: 0000000000000000
>> [   12.625537] g4: fffff8000414a9a0 g5: fffff8001dd3e000 g6: fffff8000414c000 g7: 0000000000000000
>> [   12.625569] o0: 0000000000000000 o1: 0000000000000000 o2: 0000000001167b68 o3: 0000000000f51bb8
>> [   12.625601] o4: fffff80100301fff o5: fffff8000414fc20 sp: fffff8000414f341 ret_pc: 00000000005e6310
>> [   12.625630] RPC: <mmap_region+0x130/0x700>
>> [   12.625692] l0: fffff8000488b260 l1: 000000000000008b l2: fffff80100302000 l3: 0000000000000000
>> [   12.625725] l4: fffff80100301fff l5: 0000000000000000 l6: 30812c2a1dd8556f l7: fffff8000414b438
>> [   12.625762] i0: fffff800044f58a0 i1: fffff801001ec000 i2: 0e00000000000000 i3: 0000000000000075
>> [   12.625795] i4: 0000000000000000 i5: fffff8000414fde0 i6: fffff8000414f461 i7: 00000000005e6c58
>> [   12.625833] I7: <do_mmap+0x378/0x500>
>> [   12.625906] Call Trace:
>> [   12.626006] [<00000000005e6c58>] do_mmap+0x378/0x500
>> [   12.626092] [<00000000005bdc98>] vm_mmap_pgoff+0x78/0x100
>> [   12.626112] [<00000000005e3d24>] ksys_mmap_pgoff+0x164/0x1c0
>> [   12.626129] [<0000000000406294>] linux_sparc_syscall+0x34/0x44
>> [   12.626198] Disabling lock debugging due to kernel taint
>> [   12.626286] Caller[00000000005e6c58]: do_mmap+0x378/0x500
>> [   12.626335] Caller[00000000005bdc98]: vm_mmap_pgoff+0x78/0x100
>> [   12.626354] Caller[00000000005e3d24]: ksys_mmap_pgoff+0x164/0x1c0
>> [   12.626371] Caller[0000000000406294]: linux_sparc_syscall+0x34/0x44
>> [   12.626390] Caller[fffff8010001d88c]: 0xfffff8010001d88c
>> [   12.626537] Instruction DUMP:
>> [   12.626567]  a6100008
>> [   12.626678]  02c68006
>> [   12.626685]  01000000
>> [   12.626690] <c25e8000>
>> [   12.626696]  80a04012
>> [   12.626701]  22600077
>> [   12.626707]  c25ea088
>> [   12.626712]  22c4c00a
>> [   12.626717]  f277a7c7
>> [   12.626728]
>> [   12.627169] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
>
> FWIW, same on s390 - linux-next is completely broken. Note: I didn't
> bisect, but given that the call trace, and even the failing address
> match, I'm quite confident it is the same reason.
>
> Unable to handle kernel pointer dereference in virtual kernel address space
> Failing address: 0e00000000000000 TEID: 0e00000000000803
> Fault in home space mode while using kernel ASCE.
> AS:00000000bac44007 R3:00000001ffff0007 S:00000001fffef800 P:000000000000003d
> Oops: 0038 ilc:3 [#1] SMP
> CPU: 3 PID: 79757 Comm: pt_upgrade_race Tainted: G            E K   5.18.0-20220428.rc4.git500.bdc61aad77fa.300.fc35.s390x+next #1
> Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
> Krnl PSW : 0704c00180000000 00000000b912c9a2 (mmap_region+0x1a2/0x8a8)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: 0000000000000000 0e00000000000000 0000000000000000 0000000000000000
>            ffffffffffffffff 000000000000000f 00000380016b3d98 0000080000100000
>            000000008364c100 0000080000000000 0000000000100077 0e00000000000000
>            00000000909da100 00000380016b3c58 00000000b912c982 00000380016b3b40
> Krnl Code: 00000000b912c992: a774002c          brc     7,00000000b912c9ea
>            00000000b912c996: ecb80225007c      cgij    %r11,0,8,00000000b912cde0
>           #00000000b912c99c: e310f0f80004      lg      %r1,248(%r15)
>           >00000000b912c9a2: e37010000020      cg      %r7,0(%r1)
>            00000000b912c9a8: a784010b          brc     8,00000000b912cbbe
>            00000000b912c9ac: e310f0e80004      lg      %r1,232(%r15)
>            00000000b912c9b2: ec180013007c      cgij    %r1,0,8,00000000b912c9d8
>            00000000b912c9b8: e310f0e80004      lg      %r1,232(%r15)
> Call Trace:
>  [<00000000b912c9a2>] mmap_region+0x1a2/0x8a8
> ([<00000000b912c982>] mmap_region+0x182/0x8a8)
>  [<00000000b912d492>] do_mmap+0x3ea/0x4c8
>  [<00000000b90fb9cc>] vm_mmap_pgoff+0xd4/0x170
>  [<00000000b9129c9a>] ksys_mmap_pgoff+0x62/0x238
>  [<00000000b912a034>] __s390x_sys_old_mmap+0x74/0x98
>  [<00000000b9a78ff8>] __do_syscall+0x1d8/0x200
>  [<00000000b9a872a2>] system_call+0x82/0xb0
> Last Breaking-Event-Address:
>  [<00000000b9b9e678>] __s390_indirect_jump_r14+0x0/0xc
> Kernel panic - not syncing: Fatal exception: panic_on_oops

Starting today we're still seeing the same crash with linux-next from
(next-20220513):

[  211.937897] CPU: 7 PID: 535 Comm: pt_upgrade Not tainted 5.18.0-rc6-11648-g76535d42eb53-dirty #732
[  211.937902] Unable to handle kernel pointer dereference in virtual kernel address space
[  211.937903] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
[  211.937906] Failing address: 0e00000000000000 TEID: 0e00000000000803
[  211.937909] Krnl PSW : 0704c00180000000 0000001ca52f06d6
[  211.937910] Fault in home space mode while using kernel ASCE.
[  211.937917] AS:0000001ca6e24007 R3:0000001fffff0007 S:0000001ffffef800 P:000000000000003d
[  211.937914]  (mmap_region+0x19e/0x848)
[  211.937929]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[  211.937939] Krnl GPRS: 0000000000000000 0e00000000000000 0000000000000000 0000000000000000
[  211.937942]            ffffffff00000f0f ffffffffffffffff 0e00000000000000 0000040000001000
[  211.937945]            0000000083551900 0000040000000000 00000000000000fb 000003800070fc58
[  211.937947]            000000008f490000 0000000000000000 0000001ca52f06b6 000003800070fb48
[  211.937959] Krnl Code: 0000001ca52f06c6: a7740021            brc     7,0000001ca52f0708
[  211.937959]            0000001ca52f06ca: ec6801b3007c        cgij    %r6,0,8,0000001ca52f0a30
[  211.937959]           #0000001ca52f06d0: e310f0f80004        lg      %r1,248(%r15)
[  211.937959]           >0000001ca52f06d6: e37010000020        cg      %r7,0(%r1)
[  211.937959]            0000001ca52f06dc: a78400ea            brc     8,0000001ca52f08b0
[  211.937959]            0000001ca52f06e0: e310f0f00004        lg      %r1,240(%r15)
[  211.937959]            0000001ca52f06e6: ec180008007c        cgij    %r1,0,8,0000001ca52f06f6
[  211.937959]            0000001ca52f06ec: e39010080020        cg      %r9,8(%r1)
[  211.937973] Call Trace:
[  211.937975]  [<0000001ca52f06d6>] mmap_region+0x19e/0x848
[  211.937978] ([<0000001ca52f06b6>] mmap_region+0x17e/0x848)
[  211.937981]  [<0000001ca52f116a>] do_mmap+0x3ea/0x4c8
[  211.937983]  [<0000001ca52bed12>] vm_mmap_pgoff+0xda/0x178
[  211.937987]  [<0000001ca52ed5ea>] ksys_mmap_pgoff+0x62/0x238
[  211.937989]  [<0000001ca52ed992>] __s390x_sys_old_mmap+0x7a/0xa0
[  211.937993]  [<0000001ca5c4ef5c>] __do_syscall+0x1d4/0x200
[  211.937999]  [<0000001ca5c5d572>] system_call+0x82/0xb0
[  211.938002] Last Breaking-Event-Address:
[  211.938003]  [<0000001ca5888616>] mas_prev+0xb6/0xc0
[  211.938010] Oops: 0038 ilc:3 [#2]
[  211.938011] Kernel panic - not syncing: Fatal exception: panic_on_oops
[  211.938012] SMP
[  211.938014] Modules linked in:
07: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 0000001C
A50679A6

IS that issue supposed to be fixed? git bisect pointed me to

# bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
  'mm-everything' of
  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

which isn't really helpful.

Anything we could help with debugging this?

Thanks
Sven
