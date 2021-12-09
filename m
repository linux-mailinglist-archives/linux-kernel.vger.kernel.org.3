Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214C646F27A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbhLIRy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:54:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57148 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231889AbhLIRy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:54:57 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9H9bSU010677;
        Thu, 9 Dec 2021 17:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=9ZTa3C/+ztR+2VEEkNIyWPQDIo1w4QfLV4PnSVIIfaw=;
 b=sq/nI0d3y3yPwNlijJj6KBKieSY8I9j8TXyWqFZn0WOMc/U/I1Ls/tzF/LUvqpjHdNq/
 eaN7GUXPgZhXtqrMym6ObUgeHW21xjyO9aPp6acWvupmjtbrDscPQ+06jHw4uDfAQbBx
 Oug7tWpbbD78UW95mOokGxiLUy1IDf+2F8auVkr9IoYSuHVdO6s73k0DIQwieNuoHyYQ
 S9LLe2YqUwdQkQL9Yj0uWChFS8ne2tnUFjpxYmygfoj2HykawDN+7yr65iazr0ka5/tD
 nhKJauePaGaWXlN/p3DapU4ep4j2t2SWSImrqg5uL8NhNyDOkmOis8IFyx9VXRtDtS65 vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cumwk2pus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 17:51:04 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B9HkqtC001434;
        Thu, 9 Dec 2021 17:51:03 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cumwk2puc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 17:51:03 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B9HjOu2032411;
        Thu, 9 Dec 2021 17:51:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3cqyya2a4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 17:51:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B9HoxhH28442938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Dec 2021 17:50:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 747E3A4054;
        Thu,  9 Dec 2021 17:50:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 291B9A405C;
        Thu,  9 Dec 2021 17:50:59 +0000 (GMT)
Received: from osiris (unknown [9.145.184.102])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Dec 2021 17:50:59 +0000 (GMT)
Date:   Thu, 9 Dec 2021 18:50:57 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [for-linus][PATCH 5/5] ftrace/samples: Add module to test multi
 direct modify interface
Message-ID: <YbJCAVYQZ5cQ9lmv@osiris>
References: <20211209152908.459494269@goodmis.org>
 <20211209153223.843082247@goodmis.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209153223.843082247@goodmis.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n9ppPNeqOUfmA6O5rGoT2eB-5oqn_m6D
X-Proofpoint-ORIG-GUID: ZI2J0gVxGcPlUyBCC3TzZgBW44GNl0jN
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:29:13AM -0500, Steven Rostedt wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> 
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
> Link: https://lkml.kernel.org/r/20211206182032.87248-4-jolsa@kernel.org
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  samples/ftrace/Makefile                     |   1 +
>  samples/ftrace/ftrace-direct-multi-modify.c | 152 ++++++++++++++++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c

FWIW, for the s390 bits in here:

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Tested-by: Heiko Carstens <hca@linux.ibm.com>
