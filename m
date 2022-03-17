Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3342A4DC779
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiCQNZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiCQNZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:25:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60CD3ACF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:24:16 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HCkBYN023093;
        Thu, 17 Mar 2022 13:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=kOt4ZXQU5LjQtNJqNgi9dTJKAyZIESMcgNYiDtTFs1w=;
 b=oe9xVgjm2bNALwGWbaWw2aqkR8WHonQ6EuiqmFjUw0o2Vxyjy7CLdXBOSFjeLQx3H1zE
 CjzPt7+S3LKQp2j2h9chajywEbCUsnL3nUliQq9rs2lmVMtREWB3DPEm6lQSbrmtW+oJ
 munowJws5JBfp+DxFhyvKZxDeaa0sXNvXUtObH0xIxpizZcypsi4sRujEINLY3RIwPDj
 m4F6XI0HvoXb8kaeUAdbwZajL8KJTXrDZ9Hr3j/mjVJphtO8x7rBTKrrkTYA3VSM1drM
 czo199eyHGdEnwMQIg9EH65n+PBPIK4RTUj67cgFMvt5y+dXlS9HI6takZEkf0Ek1HG4 qw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3euv2yb445-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 13:24:14 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22HDD3CR032354;
        Thu, 17 Mar 2022 13:24:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3et95wxr61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 13:24:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22HDCeO344433716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 13:12:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB2B74C05C;
        Thu, 17 Mar 2022 13:24:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81D2C4C05A;
        Thu, 17 Mar 2022 13:24:09 +0000 (GMT)
Received: from localhost (unknown [9.43.49.2])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Mar 2022 13:24:09 +0000 (GMT)
Date:   Thu, 17 Mar 2022 18:54:08 +0530
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
Message-Id: <1647523376.wy1m43rn4r.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kZ0yycM1Cp6_3xBGmC_28owfeSA7Z5Li
X-Proofpoint-ORIG-GUID: kZ0yycM1Cp6_3xBGmC_28owfeSA7Z5Li
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_05,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203170077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Thanks! That sounds better.


- Naveen
