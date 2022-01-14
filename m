Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540AE48E4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiANH3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:29:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239331AbiANH33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:29:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20E7Rhkl026465;
        Fri, 14 Jan 2022 07:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=K9IbwkIhXCjF4pxomD0f1QSJ5vymDPmoPBH+CzA8h5A=;
 b=Ohg1pdrx597dF9Tw2kqdCOoR8h4FpVQGnZTFjxphhnSHvSoAv518s9a8ZainHCXW0DR7
 CwC1Pe/adAbVLYjXNmDLXjPwElpiDYdVLJgvBrhhIOi2/4PdDYSOpzVtIQKJyUzVI8s7
 B8jNqOtnq1VJJsn7FSnQCMOwtuwRibAGg297iwkCldZpJ8+ZpF4OW69G6rUawUyyFf2O
 KJNCsYJd0vV+QFrrvKPMGXoEM8bx0col2/mLAX0SZafgCdrWvt7hjqxd9OAdLda/deTp
 3KRj2qywmfKXKQ13E4+vBUOjqjlACSDuQ/3d4Y9Rift/+JWto17SO3mOVz8CGdeh8oIM xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dk4t580gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 07:29:07 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20E7RVlP025907;
        Fri, 14 Jan 2022 07:29:07 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dk4t580gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 07:29:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20E7Cm7W017372;
        Fri, 14 Jan 2022 07:29:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vjv9f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 07:29:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20E7T3Xt24969494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 07:29:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B63F52052;
        Fri, 14 Jan 2022 07:29:03 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id BEEE35204F;
        Fri, 14 Jan 2022 07:29:02 +0000 (GMT)
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
        <yt9dwnj3wcke.fsf@linux.ibm.com>
        <20220113165115.0c844df9@gandalf.local.home>
        <20220113211501.473ab5ca@gandalf.local.home>
Date:   Fri, 14 Jan 2022 08:29:02 +0100
In-Reply-To: <20220113211501.473ab5ca@gandalf.local.home> (Steven Rostedt's
        message of "Thu, 13 Jan 2022 21:15:01 -0500")
Message-ID: <yt9dsftqwzb5.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4IFYBnwMJsHhvdpNhP1c855tCKiFmjC6
X-Proofpoint-ORIG-GUID: b71Yasxp7VNmCRNXjJ3N5tnrugPx7iIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_02,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=882
 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 13 Jan 2022 16:51:15 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> We could add something later. As it is currently the merge window, and this
>> is a real bug, I'm going to just leave it as is, and we can work to fix the
>> other archs later. I need to get a pull request ready by tomorrow.
>
> Actually I got this working, and looks like a reasonable answer to the
> problem. It basically requires that the user specify that the pointer
> points into user space for the kernel to read it.
>
> Thus instead of:
>
>   echo 'filename ~ "trace"' > events/syscalls/sys_enter_openat/filter
>
> They must now do:
>
>   echo 'filename.ustring ~ "trace"' > events/syscalls/sys_enter_openat/filter
>
> I updated the documentation to reflect this.

Looks good and works on s390, feel free to add my tested-by:

Tested-by: Sven Schnelle <svens@linux.ibm.com>

Thanks!
