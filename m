Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30F495E62
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380140AbiAUL3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:29:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349905AbiAUL3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:29:49 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LAgZCM028202;
        Fri, 21 Jan 2022 11:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=Q9ei9VJUKz0sT0uGO/P2sPkgIGa9GD27HpVjME4ge6c=;
 b=Nk70Nk7rNh4Fvyg3BBGt1bhM2LZAWW4XJL4ZYWYkl9zk73jJCxYSCR0vJeeW2FBwJvIX
 B4y03wrnzO1WMegLHGA2cESa6Yrtz9efdOnzLRmGZd1n/CmTzPdeAJDsdkcqdDk88TKU
 I3Ow3XrbI5hLGQ+Sf3R2rbZL8bG3JmcFUvUEY5UPk7KpDTvGcDeDnFMawJJLS6viKOCM
 zoqIV6Tu9f0OXUN1PzXZs0a/rflF5NFqaz/6W3eOwb6kafDxPPT2tu2Q8GNNIx31xAbP
 FmCMVauLpegmlDWvecVmE7m4dPFWhmSObOsk8hpaZmCXMi4VRIu9Pvf/3gRT7ZDzsRta jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dquae8qk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 11:29:27 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20LBJVdQ027502;
        Fri, 21 Jan 2022 11:29:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dquae8qjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 11:29:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20LBC1No015261;
        Fri, 21 Jan 2022 11:29:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3dqj37v1ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 11:29:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20LBTMvr43319766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 11:29:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CB2F11C04A;
        Fri, 21 Jan 2022 11:29:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0500111C050;
        Fri, 21 Jan 2022 11:29:22 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jan 2022 11:29:21 +0000 (GMT)
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
        <yt9d8rv9cpdq.fsf@linux.ibm.com>
Date:   Fri, 21 Jan 2022 12:29:21 +0100
In-Reply-To: <yt9d8rv9cpdq.fsf@linux.ibm.com> (Sven Schnelle's message of
        "Fri, 21 Jan 2022 12:14:09 +0100")
Message-ID: <yt9d4k5xcooe.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VszLzLK5D8E12wbpmlmrxEHE_ymEFlZt
X-Proofpoint-ORIG-GUID: iijYK5lyd7OhKY1Pq3_eASSle0ZJ51b3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> Heiko Carstens <hca@linux.ibm.com> writes:
>
>> On Fri, Jan 21, 2022 at 10:46:36AM +0100, Sven Schnelle wrote:
>>> Hi Yinan,
>>> 
>>> Yinan Liu <yinan@linux.alibaba.com> writes:
>>> 
>>> > When the kernel starts, the initialization of ftrace takes
>>> > up a portion of the time (approximately 6~8ms) to sort mcount
>>> > addresses. We can save this time by moving mcount-sorting to
>>> > compile time.
>>> >
>>> > Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
>>> > Reported-by: kernel test robot <lkp@intel.com>
>>> > Reported-by: kernel test robot <oliver.sang@intel.com>
>>> > ---
>>> >  kernel/trace/ftrace.c   |  11 +++-
>>> >  scripts/Makefile        |   6 +-
>>> >  scripts/link-vmlinux.sh |   6 +-
>>> >  scripts/sorttable.c     |   2 +
>>> >  scripts/sorttable.h     | 120 +++++++++++++++++++++++++++++++++++++++-
>>> >  5 files changed, 137 insertions(+), 8 deletions(-)
>>> 
>>> while i like the idea, this unfortunately breaks ftrace on s390. The
>>> reason for that is that the compiler generates relocation entries for
>>> all the addresses in __mcount_loc. During boot, the s390 decompressor
>>> iterates through all the relocations and overwrites the nicely
>>> sorted list between __start_mcount_loc and __stop_mcount_loc with
>>> the unsorted list because the relocations entries are not adjusted.
>>> 
>>> Of course we could just disable that option, but that would make us
>>> different compared to x86 which i don't like. Adding code to sort the
>>> relocation would of course also fix that, but i don't think it is a good
>>> idea to rely on the order of relocations.
>>> 
>>> Any thoughts how a fix could look like, and whether that could also be a
>>> problem on other architectures?
>>
>> Sven, thanks for figuring this out. Can you confirm that reverting
>> commit 72b3942a173c ("scripts: ftrace - move the sort-processing in
>> ftrace_init") fixes the problem?
>
> Yes, reverting this commit fixes it.
>
>> This really should be addressed before rc1 is out, otherwise s390 is
>> broken if somebody enables ftrace.
>> Where "broken" translates to random crashes as soon as ftrace is
>> enabled, which again is nowadays quite common.
>
> I wasn't able to reproduce these crashes on my systems so far. For the
> readers here, we're seeing about 10-15 systems crashing every night,
> usually in the 00basic/ ftrace testcases.
>
> In most of the case it looks like register corruption, where some random
> register is or'd or parts are overwritten with 0x0004000000000000,
> sometimes 0x00f4000000000000. I haven't found yts found a commit that
> might cause this.

Thinking of it, 04 and f4 are exactly the bytes we're patching in our brcl
instructions right at the beginning of the function. So i guess that
because of this bug the ftrace code now writes those bytes to the wrong
location, sometimes hitting the register save area. I haven't verified
that, but i think there's a high likelyhood.

/Sven
