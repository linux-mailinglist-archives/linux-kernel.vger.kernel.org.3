Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2470E48DF95
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiAMV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:28:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230379AbiAMV21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:28:27 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DKRje1005820;
        Thu, 13 Jan 2022 21:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=vQbbFE4uRXmMiOA1FD3iDjLwsHL3MCpfQNcgBNwBVKY=;
 b=lNmIsMBgxetbSuLkRhehg0DJ87gZRp5GninezCKg5qrKOmY0Q4MznCxSoKXqUEHgRUS4
 W8C8Z4FZIwC4HPkZ4HxlquUpZ+3TN2M/sVgCQ9r/Aa/24f/o4zVvpIh3xDk7Yfar7p4X
 9HnGUFqdLESL1SmZ2Ki3Rv9YgW8/ep54gj6oXWUZmpKJTHgQLHmFTpjE/B+esDhRDsXE
 CXbx4gSO28H9EfWaLO1qQiBD1B82QFococZbxbPWpalog79pmV7E2OrcQosLWFW1jw5q
 Sf1Ar/QippC+gzNenOQ+Q58Pns/x9YSoMWnFWF82EieVkmkKyw+0+4oU4aR6EAYvTL8G NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dju4yh74v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 21:28:07 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DKvKPi010721;
        Thu, 13 Jan 2022 21:28:06 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dju4yh743-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 21:28:06 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DLNdGK019374;
        Thu, 13 Jan 2022 21:28:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3df28a6ets-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 21:28:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DLS2mC31981934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 21:28:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C80DAE053;
        Thu, 13 Jan 2022 21:28:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E01D8AE057;
        Thu, 13 Jan 2022 21:28:01 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 13 Jan 2022 21:28:01 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, hca@linux.ibm.com,
        deller@gmx.de
Subject: Re: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <7a0fefb7ed3542b4a49dee1e78b1668b@AcuMS.aculab.com>
        <yt9d8rvmt2jq.fsf@linux.ibm.com>
        <20220113125754.0cb5273f@gandalf.local.home>
Date:   Thu, 13 Jan 2022 22:28:01 +0100
In-Reply-To: <20220113125754.0cb5273f@gandalf.local.home> (Steven Rostedt's
        message of "Thu, 13 Jan 2022 12:57:54 -0500")
Message-ID: <yt9dwnj3wcke.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2Xm2Gx781Ilzv4xsx74fFFpfWP531L6p
X-Proofpoint-ORIG-GUID: zGnbGTDoQybg0oVBoKlTqFX_09Yc9v9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_09,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 11 Jan 2022 21:55:53 +0100
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> > Isn't there also at least one architecture where you can't differentiate
>> > between user and kernel pointers by looking at the address?
>> > (Something like sparc ASI is used for user accesses so both user
>> > and kernel get the full 4G address range. But it isn't sparc (or pdp/11))
>> > ISTR it causing issues with the code for kernel_setsockopt() and
>> > required a separate flag.  
>> 
>> On s390 TASK_SIZE is defined as -PAGE_SIZE, so with the patch above the
>> kernel would always try to fetch it from user space. I think it would be
>> the same for parisc.
>
> As a work around for these cases, would something like this work?

Hmm, i don't see how. On s390, TASK_SIZE is -PAGE_SIZE, which means
0xfffffffffffff000 so i think the if() condition below is always true.

Too bad that the __user attribute is stripped during a normal compile.
But couldn't we add the information whether a pointer belongs to user
or kernel space in the trace event definition? For syscall tracing it's
easy, because pointer types in SYSCALL_DEFINE() and friends are always
userspace pointers?

> -- Steve
>
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 91352a64be09..06013822764c 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -676,7 +676,15 @@ static __always_inline char *test_string(char *str)
>  	ubuf = this_cpu_ptr(ustring_per_cpu);
>  	kstr = ubuf->buffer;
>  
> -	if (likely((unsigned long)str >= TASK_SIZE)) {
> +	/*
> +	 * Test the address of ustring_per_cpu against TASK_SIZE, as
> +	 * comparing TASK_SIZE to determine kernel/user space address
> +	 * is not enough on some architectures. If the address is less
> +	 * than TASK_SIZE we know this is the case, in which we should
> +	 * always use the from_kernel variant.
> +	 */
> +	if ((unsigned long)&ustring_per_cpu < (unsigned long)TASK_SIZE ||
> +	    likely((unsigned long)str >= TASK_SIZE)) {
>  		/* For safety, do not trust the string pointer */
>  		if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
>  			return NULL;
