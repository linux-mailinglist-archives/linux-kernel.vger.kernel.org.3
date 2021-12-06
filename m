Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E234694FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbhLFL3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:29:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242441AbhLFL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:29:30 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6ALWCe009626;
        Mon, 6 Dec 2021 11:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=cvUzpbX3kTppx+sVhx8haj5rk4twt2f/H8ifqy3CTIo=;
 b=pImmdcAsOALnbIYNWxwyPT6OAxxBrdpx/ilFZg2E+VnhctzUlCSnpwaWyrlT+UxcJ2pn
 7FfLQiNK9LykqJFp2vGuINN8pp/x5VtgCcM4ofOuslzGwbd0ie25JyhwNmoUOBVayRxD
 CB76BWPReIdBbFyr3w89t1f6K0LcR2tTppW4eMf7XWzmb+Sq96OpMZ2W9633ORaNzVHj
 TPFw0S54NEhXJtnXmwELUzzL/C5N/5Bgx7Bu5QkZUL0fz3XRP4JYoB7B1BgtZEe40Sjc
 hi1owjlODSlW3YwezTPilX9ECl0RUS58vgFKHgnWNzgaEEBQ4WyT4GT//jnrAZMOB1/o hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csgpsh62f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 11:25:45 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6Am9pY027389;
        Mon, 6 Dec 2021 11:25:44 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csgpsh61u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 11:25:44 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6BMM6u002912;
        Mon, 6 Dec 2021 11:25:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3cqyy936yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 11:25:41 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6BPdpj31195618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 11:25:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0B06A4073;
        Mon,  6 Dec 2021 11:25:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0517A4081;
        Mon,  6 Dec 2021 11:25:38 +0000 (GMT)
Received: from osiris (unknown [9.145.12.237])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Dec 2021 11:25:38 +0000 (GMT)
Date:   Mon, 6 Dec 2021 12:25:37 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ftrace/samples: Add module to test multi direct
 modify interface
Message-ID: <Ya3zMZPcrnSc0Szm@osiris>
References: <20211205232036.51996-1-jolsa@kernel.org>
 <20211205232036.51996-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205232036.51996-4-jolsa@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AHLM9jJtMcDMG4Pa9p9iM58ppP2heGVj
X-Proofpoint-ORIG-GUID: KO-6AdaeTs53qBUJvvjpcSNFLru_61xZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_04,2021-12-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112060066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:20:36AM +0100, Jiri Olsa wrote:
> Adding ftrace-direct-multi-modify.ko kernel module that uses
> modify_ftrace_direct_multi API. The core functionality is taken
> from ftrace-direct-modify.ko kernel module and changed to fit
> multi direct interface.
> 
> The init function creates kthread that periodically calls
> modify_ftrace_direct_multi to change the trampoline address
> for the direct ftrace_ops. The ftrace trace_pipe then shows
> trace from both trampolines.
> 
> Also adding SAMPLE_FTRACE_MULTI_DIRECT to enable build of
> direct multi interface sample modules. It's used in Makefile,
> but not defined at the moment.
> 
> Same as for ftrace-direct-multi.ko, the new module is enabled
> only for x86_64, so there's no need to ifdef the inlined assembly.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  samples/Kconfig                             |   8 ++
>  samples/ftrace/Makefile                     |   1 +
>  samples/ftrace/ftrace-direct-multi-modify.c | 105 ++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c

I think your series is based on something before 5.16-rc2?

Because there are:
503e45108451 ("ftrace/samples: add missing Kconfig option for ftrace direct multi sample")
890e3dc8bb6e ("ftrace/samples: add s390 support for ftrace direct multi sample")

Which would conflict with your patches.
