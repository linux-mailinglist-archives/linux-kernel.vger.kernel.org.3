Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FEB57074A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiGKPl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiGKPl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:41:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A02C67140
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:41:55 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BEXcEq008325;
        Mon, 11 Jul 2022 15:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=njbWvhg1P0ET7tnM8W/Fu33weGTofxVZ6YDrvtI49BY=;
 b=LXcf4IuEyPEKloQM39kVi8EaETpZu5Drrxp8hvULy3Krxolc1iaj9ZCxj6t5bDRsljM8
 LRaTzD8NcqZECAJaGjmA0M7z2BTvXAJWqspfOwx23XuqAG2TcuTQ7dlXuwinmyODPxz3
 tjOeFJvd8y5zG/TL4P8d9USs2U4dX0UhpnP258KK5n3/apSH3b8zakI5zgDztDQhEQLo
 DYHeHyXARRwsZ+kuyihxo+IHUlS6rM5kAmKkigRkXqy/H7u1NGL+0XPQOf86sXG7d0jQ
 S641Zpwez+Y7O0wvXYwMd+4JX9sktmXmYt6ZEIn6bBj0I69JmahBxfYnffxiKjgZMUjS Fw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h8nqxj56s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 15:41:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26BFcbPa016277;
        Mon, 11 Jul 2022 15:41:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xhtxtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 15:41:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26BFfftC24510818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 15:41:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B12484203F;
        Mon, 11 Jul 2022 15:41:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4787442041;
        Mon, 11 Jul 2022 15:41:41 +0000 (GMT)
Received: from localhost (unknown [9.43.7.231])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jul 2022 15:41:41 +0000 (GMT)
Date:   Mon, 11 Jul 2022 21:11:39 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] perf trace: Fix SIGSEGV when processing syscall args
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, cclaudio@linux.ibm.com,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220707090900.572584-1-naveen.n.rao@linux.vnet.ibm.com>
        <CAM9d7cjUVd+O3Ftg3vSAEHnZqS2ZAGez26BjyjY_ZZ3ce40qyA@mail.gmail.com>
In-Reply-To: <CAM9d7cjUVd+O3Ftg3vSAEHnZqS2ZAGez26BjyjY_ZZ3ce40qyA@mail.gmail.com>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1657553759.3ij85y5uv1.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9U9U4aUSLf48Z3fnHEuc0kZXcFejDF21
X-Proofpoint-ORIG-GUID: 9U9U4aUSLf48Z3fnHEuc0kZXcFejDF21
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_19,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

Namhyung Kim wrote:
> Hello,
>=20
> On Thu, Jul 7, 2022 at 2:09 AM Naveen N. Rao
> <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>
>> On powerpc, 'perf trace' is crashing with a SIGSEGV when trying to
>> process a perf.data file created with 'perf trace record -p':
>>
>>   #0  0x00000001225b8988 in syscall_arg__scnprintf_augmented_string <sni=
p> at builtin-trace.c:1492
>>   #1  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1492
>>   #2  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1486
>>   #3  0x00000001225bdd9c in syscall_arg_fmt__scnprintf_val <snip> at bui=
ltin-trace.c:1973
>>   #4  syscall__scnprintf_args <snip> at builtin-trace.c:2041
>>   #5  0x00000001225bff04 in trace__sys_enter <snip> at builtin-trace.c:2=
319
>>
>> That points to the below code in tools/perf/builtin-trace.c:
>>         /*
>>          * If this is raw_syscalls.sys_enter, then it always comes with =
the 6 possible
>>          * arguments, even if the syscall being handled, say "openat", u=
ses only 4 arguments
>>          * this breaks syscall__augmented_args() check for augmented arg=
s, as we calculate
>>          * syscall->args_size using each syscalls:sys_enter_NAME tracefs=
 format file,
>>          * so when handling, say the openat syscall, we end up getting 6=
 args for the
>>          * raw_syscalls:sys_enter event, when we expected just 4, we end=
 up mistakenly
>>          * thinking that the extra 2 u64 args are the augmented filename=
, so just check
>>          * here and avoid using augmented syscalls when the evsel is the=
 raw_syscalls one.
>>          */
>>         if (evsel !=3D trace->syscalls.events.sys_enter)
>>                 augmented_args =3D syscall__augmented_args(sc, sample, &=
augmented_args_size, trace->raw_augmented_syscalls_args_size);
>>
>> As the comment points out, we should not be trying to augment the args
>> for raw_syscalls. However, when processing a perf.data file, we are not
>> initializing those properly. Fix the same.
>>
>> Reported-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  tools/perf/builtin-trace.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
>> index 897fc504918b91..f075cf37a65ef8 100644
>> --- a/tools/perf/builtin-trace.c
>> +++ b/tools/perf/builtin-trace.c
>> @@ -4280,6 +4280,7 @@ static int trace__replay(struct trace *trace)
>>                 goto out;
>>
>>         evsel =3D evlist__find_tracepoint_by_name(session->evlist, "raw_=
syscalls:sys_enter");
>> +       trace->syscalls.events.sys_enter =3D evsel;
>>         /* older kernels have syscalls tp versus raw_syscalls */
>=20
> Isn't it better to set it after the NULL check below?

From trace__sys_enter():
	/*
	 * If this is raw_syscalls.sys_enter, then it always comes with the 6 poss=
ible
	 * arguments, even if the syscall being handled, say "openat", uses only 4=
 arguments
	 * this breaks syscall__augmented_args() check for augmented args, as we c=
alculate
	 * syscall->args_size using each syscalls:sys_enter_NAME tracefs format fi=
le,
	 * so when handling, say the openat syscall, we end up getting 6 args for =
the
	 * raw_syscalls:sys_enter event, when we expected just 4, we end up mistak=
enly
	 * thinking that the extra 2 u64 args are the augmented filename, so just =
check
	 * here and avoid using augmented syscalls when the evsel is the raw_sysca=
lls one.
	 */
	if (evsel !=3D trace->syscalls.events.sys_enter)
		augmented_args =3D syscall__augmented_args(sc, sample, &augmented_args_si=
ze, trace->raw_augmented_syscalls_args_size);

From the previous discussion [1], it looks like the assumption above is=20
that sys_enter would be set to raw_syscalls.

As such, I set it before the NULL check below, which ends up falling=20
back to the non-raw syscalls tracepoint.


Thanks,
Naveen

[1] https://lore.kernel.org/all/YjDSRb1wwswKpJNJ@kernel.org/
