Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0606056C7AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGIHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:30:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE3691FD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 00:30:02 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2697645w023711;
        Sat, 9 Jul 2022 07:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=4KUMbe54HOgckAM+PFogK3QftA/WyBxdcAazae1raNU=;
 b=iKm1rvjBRtgcifCcMQ7kW729WE98dk9Vt6WutrduOx/lf1gi1+UIQ0R9fNHwAVBC1K9k
 YttjHhDhRGk0DeVrSJXhG9hW1sU1x+w5LVYpzwbW/39Q2EMKhGadNgdRs2GQ9ae9GUjp
 cBRwJOI6UakGTj6xdn6E5dgY4glACOkPf8X7aMu3mZxD3/M/UPw3lt+qaEac2rqjQLwF
 h316RSUnYkVA20qQ6btgdCR+50eDBET9d08ea+l2Ixrac2vv8lFu4SQRTjt7o5CPiBt+
 OPOox3YaWw9KT1VEM4LHRwtsO2gAQ//gM8fbDzj7TcRBqD06Atzxgao12ldSi+U6w4cT yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h7258u67e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Jul 2022 07:29:29 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2697TTaA026121;
        Sat, 9 Jul 2022 07:29:29 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h7258u672-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Jul 2022 07:29:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2697LS4i019350;
        Sat, 9 Jul 2022 07:29:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3h71a8g5u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Jul 2022 07:29:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2697S2D120578754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Jul 2022 07:28:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EBB04203F;
        Sat,  9 Jul 2022 07:29:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07E3242041;
        Sat,  9 Jul 2022 07:29:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  9 Jul 2022 07:29:23 +0000 (GMT)
Date:   Sat, 9 Jul 2022 09:29:22 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v10 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Message-ID: <YskuUvl55iK+uRWf@tuxmaker.boeblingen.de.ibm.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-14-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621204632.3370049-14-Liam.Howlett@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sl9tq6WvPtyQUYLucwK2Zhy-sNnADpF8
X-Proofpoint-GUID: dZfEARRsDJBjLdylsA49W0i8WL4yMHD5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-09_06,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207090032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 08:46:55PM +0000, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The maple tree code was added to find the unmapped area in a previous
> commit and was checked against what the rbtree returned, but the actual
> result was never used.  Start using the maple tree implementation and
> remove the rbtree code.
> 
> Add kernel documentation comment for these functions.

Hi Liam,

With this update a user process crash is triggered on s390 when
the below core is executed (derived from LTP fork14 testcase):

#include <unistd.h>
#include <sys/mman.h>

#define GB		(1024 * 1024 * 1024L)
#define EXTENT		(16 * 1024 + 10)

int main(int argc, char **argv)
{
	void *addr;
	int i;

	for (i = 0; i < EXTENT; i++) {
		addr = mmap(NULL, 1 * GB, PROT_READ | PROT_WRITE,
			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
		if (addr == MAP_FAILED)
			break;
	}

	return 0;
}

On 4095-th iteration mmap() returns a normal address, but shared
library mappings go away. The page tables seem to be intact as the
memory is still available (I did not check every mapping gone though).
In addition, the memory contents of disappeared mappings is zeroed.
As result, an instruction that follows the mmap() system call turns
into invalid operation code:

t35lp64 login: [45116.631391] User process fault: interruption code 0004 ilc:1 
[45116.631403] Failing address: 000003ffa580c000 TEID: 000003ffa580c884
[45116.631405] Fault in primary space mode while using user ASCE.
[45116.631407] AS:00000000e75fc1c7 R3:00000000e758c007 S:00000000a3e01701 
[45116.631411] CPU: 4 PID: 1745 Comm: mmap Not tainted 5.19.0-rc4-00162-g34de4ebd5706 #36
[45116.631414] Hardware name: IBM 8561 T01 703 (LPAR)
[45116.631416] User PSW : 0705000180000000 000003ffa580cc38
[45116.631418]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:0 PM:0 RI:0 EA:3
[45116.631420] User GPRS: 0000000000000000 000003ffa5af4040 000003ff65afb000 0000000040000000
[45116.631422]            0000000000000003 0000000000000022 0000000000000000 0000000001003e00
[45116.631423]            000003ffa5ab0b48 000003ffa5ab1018 0000000000000001 000003fff5879500
[45116.631425]            000003ffa5ab0f70 0000000000000000 0000000001001218 000003fff5879428
[45116.631429] User Code: 000003ffa580cc32: 0000                illegal 
[45116.631429]            000003ffa580cc34: 0000                illegal 
[45116.631429]           #000003ffa580cc36: 0000                illegal 
[45116.631429]           >000003ffa580cc38: 0000                illegal 
[45116.631429]            000003ffa580cc3a: 0000                illegal 
[45116.631429]            000003ffa580cc3c: 0000                illegal 
[45116.631429]            000003ffa580cc3e: 0000                illegal 
[45116.631429]            000003ffa580cc40: 0000                illegal 
[45116.631437] Last Breaking-Event-Address:
[45116.631438]  [<0000000000000001>] 0x1

In other words, if before the mmap() call memory mappings look like this:

          Start Addr           End Addr       Size     Offset  Perms  objfile
           0x1000000          0x1001000     0x1000        0x0  r--p   /root/main/mmap
           0x1001000          0x1002000     0x1000     0x1000  r-xp   /root/main/mmap
           0x1002000          0x1003000     0x1000     0x2000  r--p   /root/main/mmap
           0x1003000          0x1004000     0x1000     0x2000  r--p   /root/main/mmap
           0x1004000          0x1005000     0x1000     0x3000  rw-p   /root/main/mmap
       0x3fff7c00000      0x3fff7c2b000    0x2b000        0x0  r--p   /usr/lib64/libc.so.6
       0x3fff7c2b000      0x3fff7d64000   0x139000    0x2b000  r-xp   /usr/lib64/libc.so.6
       0x3fff7d64000      0x3fff7dc3000    0x5f000   0x164000  r--p   /usr/lib64/libc.so.6
       0x3fff7dc3000      0x3fff7dc4000     0x1000   0x1c3000  ---p   /usr/lib64/libc.so.6
       0x3fff7dc4000      0x3fff7dc8000     0x4000   0x1c3000  r--p   /usr/lib64/libc.so.6
       0x3fff7dc8000      0x3fff7dca000     0x2000   0x1c7000  rw-p   /usr/lib64/libc.so.6
       0x3fff7dca000      0x3fff7dd2000     0x8000        0x0  rw-p   
       0x3fff7f80000      0x3fff7f82000     0x2000        0x0  r--p   /usr/lib/ld64.so.1
       0x3fff7f82000      0x3fff7fa3000    0x21000     0x2000  r-xp   /usr/lib/ld64.so.1
       0x3fff7fa3000      0x3fff7faf000     0xc000    0x23000  r--p   /usr/lib/ld64.so.1
       0x3fff7faf000      0x3fff7fb1000     0x2000    0x2e000  r--p   /usr/lib/ld64.so.1
       0x3fff7fb1000      0x3fff7fb3000     0x2000    0x30000  rw-p   /usr/lib/ld64.so.1
       0x3fff7ff3000      0x3fff7ffb000     0x8000        0x0  rw-p   
       0x3fffffda000      0x3ffffffb000    0x21000        0x0  rw-p   [stack]
       0x3ffffffc000      0x3ffffffe000     0x2000        0x0  r--p   [vvar]
       0x3ffffffe000      0x40000000000     0x2000        0x0  r-xp   [vdso]

Then after mmap() returns it turns into:

          Start Addr           End Addr       Size     Offset  Perms  objfile
           0x1000000          0x1001000     0x1000        0x0  r--p   /root/main/mmap
           0x1001000          0x1002000     0x1000     0x1000  r-xp   /root/main/mmap
           0x1002000          0x1003000     0x1000     0x2000  r--p   /root/main/mmap
           0x1003000          0x1004000     0x1000     0x2000  r--p   /root/main/mmap
           0x1004000          0x1005000     0x1000     0x3000  rw-p   /root/main/mmap
          0x37c00000      0x3fff7ffb000 0x3ffc03fb000        0x0  rw-p   
       0x3fffffda000      0x3ffffffb000    0x21000        0x0  rw-p   [stack]
       0x3ffffffc000      0x3ffffffe000     0x2000        0x0  r--p   [vvar]
       0x3ffffffe000      0x40000000000     0x2000        0x0  r-xp   [vdso]

Interestingly, all addresses mmap() returns before the problem hits are
1MB-aligned, while the last one that screws the mappings is always page-
aligned. Also, the iteration number 4095 suggests some arithmetics that
leads to an integer overflow.

I did not experiment much with x86, but the problem does not hit there.
The config has CONFIG_PGTABLE_LEVELS=5, but I am not sure about other
options that may be involved.

The tree I used to isolate the issue:

	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm	mm-everything

It (looks like it) gets pulled into every linux-next, so the problem
is reproducable there as well.

As we are approaching the merge window that looks pretty worrisome. I will 
try to get more details on what is going on, but may be you have an immediate
idea?

Thanks!
