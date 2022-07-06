Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C24B56885D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiGFMbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiGFMbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:31:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152EC26AFA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:31:40 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266B1fCu027122;
        Wed, 6 Jul 2022 12:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=dYDdcUQdF89TV7ilxTQPKp4DbfjRbcN5O9ow2J7bkB0=;
 b=NXiCRWQbaCmEM87ObgUPDvV5kki/IrC0TlT20pH3p+3GblPTLKBNjKkOj8O8PbNfLFNV
 24UE+CUQ2J3HjtvVfofMWEe7tmKphvWsdF6xRjzU1Y/1qip7FsesZKPvRvsJiSr1qKkm
 M8wmM4pH0Tx20RfdAsY3/8+Z7e4j07X5Op8sMUzXN0SJ4RQ+M25BBxuj70Ro3VLbQ60N
 a0aWzurnVW3+APSetaklnY5uSX6RLgOcgPwMutbogxkLVhTDtCWITZIPMG5eRai64Cth
 OjhUQ2hpDlzyeW3OJrlfvF+7NKDivYMSGcPL0tW15QnnYzaO3czA2HWX9eoONfPKWU5v FA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h57mc4ycb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 12:31:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266CLk8u030958;
        Wed, 6 Jul 2022 12:31:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3h4ujsh3fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 12:31:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266CVVdi17039802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 12:31:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A194A404D;
        Wed,  6 Jul 2022 12:31:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4B4BA4055;
        Wed,  6 Jul 2022 12:31:30 +0000 (GMT)
Received: from localhost (unknown [9.43.110.188])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jul 2022 12:31:30 +0000 (GMT)
Date:   Wed, 06 Jul 2022 18:01:29 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf trace: Fix SIGSEGV when processing augmented args
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     cclaudio@linux.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Linux =?iso-8859-1?q?Kernel=0A?= Mailing List 
        <linux-kernel@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>
References: <20220310104741.209834-1-naveen.n.rao@linux.vnet.ibm.com>
        <Yi+9G1nK1shEIXVN@kernel.org> <1647364864.3xrhklc7kl.naveen@linux.ibm.com>
        <YjDSRb1wwswKpJNJ@kernel.org> <YjJKaSanKI7LQdEk@kernel.org>
In-Reply-To: <YjJKaSanKI7LQdEk@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1657110053.93m1349h4k.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vVVLXEPDFEDzEM7o9bgXPcSq94R7BHrJ
X-Proofpoint-ORIG-GUID: vVVLXEPDFEDzEM7o9bgXPcSq94R7BHrJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_08,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 15, 2022 at 02:52:05PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Tue, Mar 15, 2022 at 10:57:57PM +0530, Naveen N. Rao escreveu:
>> > Yes, it looks like the current check in 'perf' isn't working. The belo=
w
>> > patch also resolves the crash we are seeing:
>> =20
>> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
>> > index 2f1d20553a0aa3..86b459f4ebdd61 100644
>> > --- a/tools/perf/builtin-trace.c
>> > +++ b/tools/perf/builtin-trace.c
>> > @@ -2326,7 +2326,7 @@ static int trace__sys_enter(struct trace *trace,=
 struct evsel *evsel,
>> >         * thinking that the extra 2 u64 args are the augmented filenam=
e, so just check
>> >         * here and avoid using augmented syscalls when the evsel is th=
e raw_syscalls one.
>> >         */
>> > -       if (evsel !=3D trace->syscalls.events.sys_enter)
>> > +       if (strcmp(evsel__name(evsel), "raw_syscalls:sys_enter"))
>> >                augmented_args =3D syscall__augmented_args(sc, sample, =
&augmented_args_size, trace->raw_augmented_syscalls_args_size);
>> >        ttrace->entry_time =3D sample->time;
>> >        msg =3D ttrace->entry_str;
>>=20
>> Interesting, that should be equivalent :-\ humm, not really, understood,
>> when processing perf.data files we don't setup
>> trace->syscalls.events.sys_enter...
>>=20
>> switching from strcmp() to something cheaper but equivalent should be
>> the fix for now.
>=20
> I'll add a trace->use_augmented_args boolean that will do this test
> once, and then use it in this case and will audit to check if this
> should be used in other places.

Does something like the below look reasonable?

I know this isn't quite what you proposed, but it fixes the problem for=20
me while avoiding the need for a string comparison. I also think this=20
addresses all uses in 'perf trace', though I didn't audit the need for a=20
similar fix elsewhere in 'perf'.


Thanks,
Naveen

---
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d2de2a4073e7eb..352b88a51dec2d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4291,6 +4292,8 @@ static int trace__replay(struct trace *trace)
                goto out;
        }
=20
+       trace->syscalls.events.sys_enter =3D evsel;
+
        evsel =3D evlist__find_tracepoint_by_name(session->evlist, "raw_sys=
calls:sys_exit");
        if (evsel =3D=3D NULL)
                evsel =3D evlist__find_tracepoint_by_name(session->evlist, =
"syscalls:sys_exit");
@@ -4301,6 +4304,8 @@ static int trace__replay(struct trace *trace)
                goto out;
        }
=20
+       trace->syscalls.events.sys_exit  =3D evsel;
+
        evlist__for_each_entry(session->evlist, evsel) {
                if (evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE &&
                    (evsel->core.attr.config =3D=3D PERF_COUNT_SW_PAGE_FAUL=
TS_MAJ ||



