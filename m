Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A969A495E40
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380037AbiAULOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:14:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231467AbiAULOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:14:37 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L8gAMO020747;
        Fri, 21 Jan 2022 11:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=jtuaPQGuGFIy734ZLszc++cxq+pYFIEnY6I21BDuMNU=;
 b=aX0lSZmbHsgSv00ZFAEhzub80tBbrYvBD7s+FUn2YsUB20fZ42UWSwcdQVzZMqjiUw+b
 5n1sGuDmer5yJMksL6P2gzMW4pEB5Canlcp8lwsHws4DN1JC3/sOVWPmj8UNE1Mhdksh
 7f4mQx74ZgKV0PZ/Yh0yVX30nVPzb/VEZvv9wRgw8ZTehEE0RAvPlAc0XYHph7AhYiC7
 PbL7rND5YgcLiJUNBDMwrC6s3ruSrAvkwt/TXAbZxKH+XNuXkz3hPhsRrTaYCsyUxI3U
 52hUCC6uQcfwuElJtlmX9XWc37YFmJs5ncJBp3cweMwMh7ceRvI26aV/XIL4tpVsc70C kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dqsj4txpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 11:14:15 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20LB7WVq004111;
        Fri, 21 Jan 2022 11:14:14 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dqsj4txp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 11:14:14 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20LBCPRk008605;
        Fri, 21 Jan 2022 11:14:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3dqj1k3rqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 11:14:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20LB4kqD45351184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 11:04:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2C1C11C05C;
        Fri, 21 Jan 2022 11:14:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88D9211C050;
        Fri, 21 Jan 2022 11:14:09 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jan 2022 11:14:09 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Yinan Liu <yinan@linux.alibaba.com>, rostedt@goodmis.org,
        peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v8] scripts: ftrace - move the sort-processing in
 ftrace_init
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211212113358.34208-1-yinan@linux.alibaba.com>
        <20211212113358.34208-2-yinan@linux.alibaba.com>
        <yt9dee51ctfn.fsf@linux.ibm.com> <YeqOFHNfxKcNXNrn@osiris>
Date:   Fri, 21 Jan 2022 12:14:09 +0100
In-Reply-To: <YeqOFHNfxKcNXNrn@osiris> (Heiko Carstens's message of "Fri, 21
        Jan 2022 11:42:28 +0100")
Message-ID: <yt9d8rv9cpdq.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oYQXxiYyjYraHsyISFv9G3E8ovobKOKG
X-Proofpoint-ORIG-GUID: Bezku_kbzdYxJ3FLoo27uqD6LLQqstUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <hca@linux.ibm.com> writes:

> On Fri, Jan 21, 2022 at 10:46:36AM +0100, Sven Schnelle wrote:
>> Hi Yinan,
>> 
>> Yinan Liu <yinan@linux.alibaba.com> writes:
>> 
>> > When the kernel starts, the initialization of ftrace takes
>> > up a portion of the time (approximately 6~8ms) to sort mcount
>> > addresses. We can save this time by moving mcount-sorting to
>> > compile time.
>> >
>> > Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
>> > Reported-by: kernel test robot <lkp@intel.com>
>> > Reported-by: kernel test robot <oliver.sang@intel.com>
>> > ---
>> >  kernel/trace/ftrace.c   |  11 +++-
>> >  scripts/Makefile        |   6 +-
>> >  scripts/link-vmlinux.sh |   6 +-
>> >  scripts/sorttable.c     |   2 +
>> >  scripts/sorttable.h     | 120 +++++++++++++++++++++++++++++++++++++++-
>> >  5 files changed, 137 insertions(+), 8 deletions(-)
>> 
>> while i like the idea, this unfortunately breaks ftrace on s390. The
>> reason for that is that the compiler generates relocation entries for
>> all the addresses in __mcount_loc. During boot, the s390 decompressor
>> iterates through all the relocations and overwrites the nicely
>> sorted list between __start_mcount_loc and __stop_mcount_loc with
>> the unsorted list because the relocations entries are not adjusted.
>> 
>> Of course we could just disable that option, but that would make us
>> different compared to x86 which i don't like. Adding code to sort the
>> relocation would of course also fix that, but i don't think it is a good
>> idea to rely on the order of relocations.
>> 
>> Any thoughts how a fix could look like, and whether that could also be a
>> problem on other architectures?
>
> Sven, thanks for figuring this out. Can you confirm that reverting
> commit 72b3942a173c ("scripts: ftrace - move the sort-processing in
> ftrace_init") fixes the problem?

Yes, reverting this commit fixes it.

> This really should be addressed before rc1 is out, otherwise s390 is
> broken if somebody enables ftrace.
> Where "broken" translates to random crashes as soon as ftrace is
> enabled, which again is nowadays quite common.

I wasn't able to reproduce these crashes on my systems so far. For the
readers here, we're seeing about 10-15 systems crashing every night,
usually in the 00basic/ ftrace testcases.

In most of the case it looks like register corruption, where some random
register is or'd or parts are overwritten with 0x0004000000000000,
sometimes 0x00f4000000000000. I haven't found yts found a commit that
might cause this.

/Sven
