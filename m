Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534E75279B4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbiEOUC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiEOUCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:02:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3246160
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:02:52 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FEtj2u010354;
        Sun, 15 May 2022 20:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=LoYm51HysbawTd6hCFjRTYITO1iPwoUWfVMQyLK2MG8=;
 b=M6KfzFEzjBDDE6EPrBCGA8tQJwqpt4HA0WXahAPgCff2yKtDbMgHtUI+1pzJV1BD29uF
 pkyxCXhC4JYEFpW+DQwpN7BNrul9cLNsJY7c6kAYU2sKngnDNfpLCn9CKLb3EEM5yXMh
 iihvqqUyBXOJvvE0sweY+vKUgOky+pUl0YBDWUKLAJsJUlrtwa1sMU3ZhH8fk3ZhOHF/
 z+5c6PWZ2+J8aY18Xe7AZ7jqBS0kdAVnSoUrhIg4FF12Ki6lZGwQfYCE8EtF1/txgbTR
 iGpsW89nlEQ20wvTioIzhPQb5NlHyRBqfFX+yIRKP5TSrF32CuDTOTF+D2IE+oQaAYrl FA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g2pg6dedj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 20:02:36 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24FK2PKa031614;
        Sun, 15 May 2022 20:02:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3g23pj18je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 May 2022 20:02:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24FJmjLw38469942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 May 2022 19:48:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C77335204E;
        Sun, 15 May 2022 20:02:31 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 925AB5204F;
        Sun, 15 May 2022 20:02:31 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
        <yt9dk0apbicu.fsf@linux.ibm.com>
        <20220513165955.mkg5wvfi4dwpzoer@revolver>
Date:   Sun, 15 May 2022 22:02:31 +0200
In-Reply-To: <20220513165955.mkg5wvfi4dwpzoer@revolver> (Liam Howlett's
        message of "Fri, 13 May 2022 17:00:31 +0000")
Message-ID: <yt9dbkvy5zu0.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tyj9DSb9COv4Gy5i4n6vbfvKiMKFWf92
X-Proofpoint-ORIG-GUID: Tyj9DSb9COv4Gy5i4n6vbfvKiMKFWf92
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-15_11,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=856 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205150117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Howlett <liam.howlett@oracle.com> writes:

> * Sven Schnelle <svens@linux.ibm.com> [220513 10:46]:
>> Starting today we're still seeing the same crash with linux-next from
>> (next-20220513):
>>
>> [  211.937897] CPU: 7 PID: 535 Comm: pt_upgrade Not tainted 5.18.0-rc6-11648-g76535d42eb53-dirty #732
>> [  211.937902] Unable to handle kernel pointer dereference in virtual kernel address space
>> [  211.937903] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
>> [  211.937906] Failing address: 0e00000000000000 TEID: 0e00000000000803
>> [  211.937909] Krnl PSW : 0704c00180000000 0000001ca52f06d6
>> [  211.937910] Fault in home space mode while using kernel ASCE.
>> [  211.937917] AS:0000001ca6e24007 R3:0000001fffff0007 S:0000001ffffef800 P:000000000000003d
>> [  211.937914]  (mmap_region+0x19e/0x848)
>> [  211.937929]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>> [  211.937939] Krnl GPRS: 0000000000000000 0e00000000000000 0000000000000000 0000000000000000
>> [  211.937942]            ffffffff00000f0f ffffffffffffffff 0e00000000000000 0000040000001000
>> [  211.937945]            0000000083551900 0000040000000000 00000000000000fb 000003800070fc58
>> [  211.937947]            000000008f490000 0000000000000000 0000001ca52f06b6 000003800070fb48
>> [  211.937959] Krnl Code: 0000001ca52f06c6: a7740021            brc     7,0000001ca52f0708
>> [  211.937959]            0000001ca52f06ca: ec6801b3007c        cgij    %r6,0,8,0000001ca52f0a30
>> [  211.937959]           #0000001ca52f06d0: e310f0f80004        lg      %r1,248(%r15)
>> [  211.937959]           >0000001ca52f06d6: e37010000020        cg      %r7,0(%r1)
>> [  211.937959]            0000001ca52f06dc: a78400ea            brc     8,0000001ca52f08b0
>> [  211.937959]            0000001ca52f06e0: e310f0f00004        lg      %r1,240(%r15)
>> [  211.937959]            0000001ca52f06e6: ec180008007c        cgij    %r1,0,8,0000001ca52f06f6
>> [  211.937959]            0000001ca52f06ec: e39010080020        cg      %r9,8(%r1)
>> [  211.937973] Call Trace:
>> [  211.937975]  [<0000001ca52f06d6>] mmap_region+0x19e/0x848
>> [  211.937978] ([<0000001ca52f06b6>] mmap_region+0x17e/0x848)
>> [  211.937981]  [<0000001ca52f116a>] do_mmap+0x3ea/0x4c8
>> [  211.937983]  [<0000001ca52bed12>] vm_mmap_pgoff+0xda/0x178
>> [  211.937987]  [<0000001ca52ed5ea>] ksys_mmap_pgoff+0x62/0x238
>> [  211.937989]  [<0000001ca52ed992>] __s390x_sys_old_mmap+0x7a/0xa0
>> [  211.937993]  [<0000001ca5c4ef5c>] __do_syscall+0x1d4/0x200
>> [  211.937999]  [<0000001ca5c5d572>] system_call+0x82/0xb0
>> [  211.938002] Last Breaking-Event-Address:
>> [  211.938003]  [<0000001ca5888616>] mas_prev+0xb6/0xc0
>> [  211.938010] Oops: 0038 ilc:3 [#2]
>> [  211.938011] Kernel panic - not syncing: Fatal exception: panic_on_oops
>> [  211.938012] SMP
>> [  211.938014] Modules linked in:
>> 07: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 0000001C
>> A50679A6
>>
>> IS that issue supposed to be fixed? git bisect pointed me to
>>
>> # bad: [76535d42eb53485775a8c54ea85725812b75543f] Merge branch
>>   'mm-everything' of
>>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>
>> which isn't really helpful.
>>
>> Anything we could help with debugging this?
>
> I tested the maple tree on top of the s390 as it was the same crash and
> it was okay.  I haven't tested the mm-everything branch though.  Can you
> test mm-unstable?

Yes, i tested mm-unstable but wasn't able to reproduce the issue.

> I'll continue setting up a sparc VM for testing here and test
> mm-everything on that and the s390

One thing that is different compared to x86 is that both sparc and s390
are big endian. Not sure whether and where that would make a difference.

The code to trigger the crash on s390 is rather simple: Just force a
paging level upgrade to 5 levels by calling mmap() with an address that
doesn't fit in 3 levels. Haven't tested whether an upgrade to 4 levels
would be sufficent. I've condensed our test case that triggers this, and
basically all that is required is:

--------------------------------8<---------------------------------------
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <stdio.h>

#define PAGE_SIZE       0x1000
#define _REGION1_SIZE   (1UL << 54)

int main(int argc, char *argv[])
{
        int pid, status;
        void *addr;

        pid = fork();
        if (pid == 0) {
                /*
                 * Trigger page table level upgrade
                 */
                addr = mmap((void *)_REGION1_SIZE, PAGE_SIZE, PROT_READ | PROT_WRITE,
                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
                if (addr == MAP_FAILED)
                        return 1;
                *(int *)addr = 1;
                return 0;
        }
        wait(&status);
        return 0;
}
--------------------------------8<---------------------------------------

I've added a few debug statements to the maple tree code:

[   27.769641] mas_next_entry: offset=14
[   27.769642] mas_next_nentry: entry = 0e00000000000000, slots=0000000090249f80, mas->offset=15 count=14

I see in mas_next_nentry() that there's a while that iterates over the
(used?) slots until count is reached. After that loop mas_next_entry()
just picks the next (unused?) entry, which is slot 15 in that case.

What i noticed while scanning over include/linux/maple_tree.h is:

struct maple_range_64 {
	struct maple_pnode *parent;
	unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];
	union {
		void __rcu *slot[MAPLE_RANGE64_SLOTS];
		struct {
		void __rcu *pad[MAPLE_RANGE64_SLOTS - 1];
		struct maple_metadata meta;
        	};
	};
};

and struct maple_metadata is:

struct maple_metadata {
	unsigned char end;
	unsigned char gap;
};

If i swap the gap and end members 0x0e00000000000000 becomes
0x000e000000000000. And 0xe matches our msa->offset 14 above.
So it looks like mas_next() in mmap_region returns the meta
data for the node.

So from the lines above you likely already guessed that i have no clue
how mapple tree works, and i didn't had enough time today to read all
the magic and understand it. But i thought i just drop my observation
here in case someone has an idea.

Thanks,
Sven
