Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF184DA121
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350565AbiCOR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350514AbiCOR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:29:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E7B7FD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:28:08 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FGqYls026060;
        Tue, 15 Mar 2022 17:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=lI7ytVc16nGn3hcR31V7xNj9s5s9jw0BwEdZ22YZ2z8=;
 b=PRPdMlpBiUsT9pvAO4Tv0YvRH0bN/s3m3GOk07QfN403Y4oOqASjZxbspYE0Yte4J+86
 3b4vfHtMhNzyQz+y94QbrFozaH4EyV4L8MfMEc3AMeCdChj1zYKibgItZZDS4IhnqD0+
 OVuOzblOUkYkHOumvjbdB39ZIF80xYdXfvuM+VkzvchPRzFKTA2RaMp6lM8nJxUcvB6U
 G+YtBXtb3obo8XgUlr7WIkPOiYYyjZKuM0xnsYk1IkWyE7hBaXU8ust+8bCwiLKPdyWZ
 vqUT7GPB6VRpIPH0WpxmhdDjZ50Gq7QnvLyujKvaJZLAyY2/jmvFRT5ZYd94XhmNddbk Eg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3etxq3gpy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 17:28:04 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FHDQ8m030822;
        Tue, 15 Mar 2022 17:28:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3erjshq5pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 17:28:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22FHS0gS29098494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:28:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D6B9A4051;
        Tue, 15 Mar 2022 17:28:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C881A4040;
        Tue, 15 Mar 2022 17:27:59 +0000 (GMT)
Received: from localhost (unknown [9.43.69.53])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Mar 2022 17:27:59 +0000 (GMT)
Date:   Tue, 15 Mar 2022 22:57:57 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf trace: Fix SIGSEGV when processing augmented args
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     cclaudio@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20220310104741.209834-1-naveen.n.rao@linux.vnet.ibm.com>
        <Yi+9G1nK1shEIXVN@kernel.org>
In-Reply-To: <Yi+9G1nK1shEIXVN@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1647364864.3xrhklc7kl.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RgZxalOUlxYSlKSiOEpEm3qkAO2fItVm
X-Proofpoint-ORIG-GUID: RgZxalOUlxYSlKSiOEpEm3qkAO2fItVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 10, 2022 at 04:17:41PM +0530, Naveen N. Rao escreveu:
>> On powerpc, 'perf trace' is crashing with a SIGSEGV when trying to
>> process a perf data file created with 'perf trace record -p':
>=20
>>   #0  0x00000001225b8988 in syscall_arg__scnprintf_augmented_string <sni=
p> at builtin-trace.c:1492
>>   #1  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1492
>>   #2  syscall_arg__scnprintf_filename <snip> at builtin-trace.c:1486
>>   #3  0x00000001225bdd9c in syscall_arg_fmt__scnprintf_val <snip> at bui=
ltin-trace.c:1973
>>   #4  syscall__scnprintf_args <snip> at builtin-trace.c:2041
>>   #5  0x00000001225bff04 in trace__sys_enter <snip> at builtin-trace.c:2=
319
>=20
>> The size captured in the augmented arg looks corrupt, resulting in the
>> augmented arg pointer being adjusted incorrectly. Fix this by checking
>> that the size is reasonable.
>=20
>> Reported-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>> While this resolves the 'perf trace' crash, I'm not yet sure why the
>> size for the augmented arg is corrupt. This looks to be happening when
>> processing the sample for 'read' syscall. Any pointers?
>=20
> Strange indeed, the augmented args code should kick in when the payload
> for some tracepoint is bigger than what is expected, i.e. more than the
> sum of its arguments, in which case it assumes that what is coming after
> the expected payload comes with, say, the pathname for an open, openat,
> etc syscall, that otherwise would be just a pointer.
>=20
> This augmentation is done using something like
> tools/perf/examples/bpf/augmented_raw_syscalls.c, i.e.:
>=20
> [root@quaco ~]# perf trace -e openat sleep 1
>      0.000 openat(dfd: CWD, filename: 0x1bbb0b6, flags: RDONLY|CLOEXEC) =
=3D 3
>      0.021 openat(dfd: CWD, filename: 0x1bc8e80, flags: RDONLY|CLOEXEC) =
=3D 3
>      0.201 openat(dfd: CWD, filename: 0x1b34f20, flags: RDONLY|CLOEXEC) =
=3D 3
> [root@quaco ~]# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augm=
ented_raw_syscalls.c,openat sleep 1
>      0.000 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|C=
LOEXEC) =3D 3
>      0.023 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|C=
LOEXEC) =3D 3
>      0.225 openat(dfd: CWD, filename: "/usr/lib/locale/locale-archive", f=
lags: RDONLY|CLOEXEC) =3D 3
> [root@quaco ~]#

Thanks, that clarifies things a bit. I was under the impression that=20
syscalls are augmented through the bpf program by default. But, it looks=20
like that isn't the case (at least on the distro where this problem was=20
reported).

>=20
> So it seems the perf.data file being processed is corrupted somehow...
>=20
> Perhaps we should check if the syscall has pointer args and if not don't
> kick in the augmented code and instead emit some warning about having
> more payload than expected.

Yes, it looks like the current check in 'perf' isn't working. The below=20
patch also resolves the crash we are seeing:

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2f1d20553a0aa3..86b459f4ebdd61 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2326,7 +2326,7 @@ static int trace__sys_enter(struct trace *trace, stru=
ct evsel *evsel,
         * thinking that the extra 2 u64 args are the augmented filename, s=
o just check
         * here and avoid using augmented syscalls when the evsel is the ra=
w_syscalls one.
         */
-       if (evsel !=3D trace->syscalls.events.sys_enter)
+       if (strcmp(evsel__name(evsel), "raw_syscalls:sys_enter"))
                augmented_args =3D syscall__augmented_args(sc, sample, &aug=
mented_args_size, trace->raw_augmented_syscalls_args_size);
        ttrace->entry_time =3D sample->time;
        msg =3D ttrace->entry_str;


Thanks,
Naveen

