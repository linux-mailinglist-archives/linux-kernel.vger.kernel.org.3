Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714FA495D09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379608AbiAUJrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:47:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231417AbiAUJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:47:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L7g08x015892;
        Fri, 21 Jan 2022 09:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=f4JHYwcMV4e54zOcpahbFz7a636zX1CrTjpqpd0Hni4=;
 b=k5f0xmhwIzf/2+N+cuwvATMnZTef9Fw4GlsvDQPZYuakpxxiiBDobA0sC+NWNThrHAan
 VAHEcKR8ndldzGKxcpgQTttczQ7vc21p0Kfo9UNJpVH9UC0BcV9A/UwK6ah+8aenTCHM
 VqSv0xKN3F6NJpkRapzAEQI87bazEPYLCLsDCVl8Av2kBxozVV+hUSx2JbcNLKEjAdO7
 Vvtp+zHr9h4qRz3febws7sA0cr1QqeOvhWT6Z7R3HaX3Y1uFA+aa/75rWhgFRcf237Ig
 j9oL0qTqgRVwBXR7lYRJZXt1ix66dkR8IuUoWyfsgg7be8qDgQQWCwCRgU6IAZ45o3Bw bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqrnmt7ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 09:46:42 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20L9ba1T028069;
        Fri, 21 Jan 2022 09:46:42 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqrnmt7p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 09:46:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20L9bwBf010145;
        Fri, 21 Jan 2022 09:46:39 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3dqj37u66m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 09:46:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20L9kbJE33489330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 09:46:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F5FF5204F;
        Fri, 21 Jan 2022 09:46:37 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0AA785204E;
        Fri, 21 Jan 2022 09:46:37 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     rostedt@goodmis.org, peterz@infradead.org,
        mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v8] scripts: ftrace - move the sort-processing in
 ftrace_init
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211212113358.34208-1-yinan@linux.alibaba.com>
        <20211212113358.34208-2-yinan@linux.alibaba.com>
Date:   Fri, 21 Jan 2022 10:46:36 +0100
In-Reply-To: <20211212113358.34208-2-yinan@linux.alibaba.com> (Yinan Liu's
        message of "Sun, 12 Dec 2021 19:33:58 +0800")
Message-ID: <yt9dee51ctfn.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zVbhHmFDTo2cvPeVVJLmshdKet41wDXE
X-Proofpoint-ORIG-GUID: ctD1dqNde2JwWJCSjezwvpQYBEa-03Hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yinan,

Yinan Liu <yinan@linux.alibaba.com> writes:

> When the kernel starts, the initialization of ftrace takes
> up a portion of the time (approximately 6~8ms) to sort mcount
> addresses. We can save this time by moving mcount-sorting to
> compile time.
>
> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> ---
>  kernel/trace/ftrace.c   |  11 +++-
>  scripts/Makefile        |   6 +-
>  scripts/link-vmlinux.sh |   6 +-
>  scripts/sorttable.c     |   2 +
>  scripts/sorttable.h     | 120 +++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 137 insertions(+), 8 deletions(-)

while i like the idea, this unfortunately breaks ftrace on s390. The
reason for that is that the compiler generates relocation entries for
all the addresses in __mcount_loc. During boot, the s390 decompressor
iterates through all the relocations and overwrites the nicely
sorted list between __start_mcount_loc and __stop_mcount_loc with
the unsorted list because the relocations entries are not adjusted.

Of course we could just disable that option, but that would make us
different compared to x86 which i don't like. Adding code to sort the
relocation would of course also fix that, but i don't think it is a good
idea to rely on the order of relocations.

Any thoughts how a fix could look like, and whether that could also be a
problem on other architectures?

Thanks
Sven
