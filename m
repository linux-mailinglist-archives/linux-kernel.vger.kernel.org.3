Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E649E1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiA0MFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:05:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229801AbiA0MFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:05:20 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RBEdqu019642;
        Thu, 27 Jan 2022 12:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=S0Ka0//cH8D0ru7UT9NthTbr1NSd5r+MVf7IaIMAvew=;
 b=OcxGmYgJcTIqblAopaF6KWjgnIU7csUQvhZ9TKt6Ar9daujx+CxS7bBbvtysBy4CfRbW
 crgcppZ1l81hzAvA/qCugjTFs7fxWVlibuUElWSRQlwRf00DE4z1x2VF+himjClulxEJ
 jZfct8y8DjWJe51T9HTBHptNsLbwfhRW3A4axzuMXT5KdkbCos9cPb5CF2l7dR/94Emb
 KV9uKlJxwVAI6KhT3UEqifGzDbYYQYAzG6TcbZ3uOKQ2d0LsDTTgGwQ97ZtohS08axx8
 kQ171KmATQa4X576EYXABwssGyYBwkDudPZRgkwEaM9KtKgJJWBpQZRFankKSJwNuQDj nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dusemtcex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:04:47 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RBq7Zs022044;
        Thu, 27 Jan 2022 12:04:46 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dusemtcdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:04:46 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RC3tKI009173;
        Thu, 27 Jan 2022 12:04:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3dr9j9nh0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:04:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RC4gn145744398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 12:04:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06CBFAE04D;
        Thu, 27 Jan 2022 12:04:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD31EAE051;
        Thu, 27 Jan 2022 12:04:41 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Jan 2022 12:04:41 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, Sachin Sant <sachinp@linux.ibm.com>,
        linux-kernel@vger.kernel.org, ardb@kernel.org,
        keescook@chromium.org
Subject: Re: [powerpc] ftrace warning kernel/trace/ftrace.c:2068 with
 code-patching selftests
References: <944D10DA-8200-4BA9-8D0A-3BED9AA99F82@linux.ibm.com>
        <e9422643-a210-b77f-a037-da63a9d2e925@linux.alibaba.com>
        <20220124114548.30241947@gandalf.local.home>
        <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
        <YfFclROd+0/61q2d@FVFF77S0Q05N> <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
Date:   Thu, 27 Jan 2022 13:04:41 +0100
In-Reply-To: <YfKGKWW5UfZ15kCW@FVFF77S0Q05N> (Mark Rutland's message of "Thu,
        27 Jan 2022 11:46:49 +0000")
Message-ID: <yt9dy231gzae.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2jf1p-QO8CeMBW923-q0JRNZCd2DK9pj
X-Proofpoint-GUID: kqDF-x1fQX-BJSmQ_Kl4QhowYmLpA66Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 mlxlogscore=782 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:

>> Isn't x86 relocatable in some configurations (e.g. for KASLR)?
>> 
>> I can't see how the sort works for those cases, because the mcount_loc entries
>> are absolute, and either:
>> 
>> * The sorted entries will get overwritten by the unsorted relocation entries,
>>   and won't be sorted.
>> 
>> * The sorted entries won't get overwritten, but then the absolute address will
>>   be wrong since they hadn't been relocated.
>> 
>> How does that work?

From what i've seen when looking into this ftrace sort problem x86 has a
a relocation tool, which is run before final linking: arch/x86/tools/relocs.c
This tools converts all the required relocations to three types:

- 32 bit relocations
- 64 bit relocations
- inverse 32 bit relocations

These are added to the end of the image.

The decompressor then iterates over that array, and just adds/subtracts
the KASLR offset - see arch/x86/boot/compressed/misc.c, handle_relocations()

So IMHO x86 never uses 'real' relocations during boot, and just
adds/subtracts. That's why the order stays the same, and the compile
time sort works.

/Sven
