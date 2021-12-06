Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CD746AC32
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357008AbhLFWiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:38:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41630 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241471AbhLFWiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:38:03 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6IcrWv009787;
        Mon, 6 Dec 2021 14:34:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=DJHxke5iC08EBlncNjrCum4y6biWnUoQcctF7p6f8z8=;
 b=Vjxx17LrUY0M73JnMqFse8gZsSPEslr6x83lOwrxqUgmb6Drjd6pDvCm5lyDcuYRtiVS
 liJXa/2KDtQfOM1e5BPQyKur7Qc5HduIOzKuMVSUTa2luNK4hzAKLAs1vd0ByuD3/aKs
 ZFxinAKK8dVjVSVAGIMDiwH8wttWXZuIL7Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3csqyq9j46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Dec 2021 14:34:33 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 14:34:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M36zeFt1E09Oqh8d2eW7/Dn1LsfARDiUb/OKeAmk0BtAdYoOaHAIb1ZwKmASWl3LIW3nA38Q2ouwP+Kz3kHTPpgDG7fFjcYZ7ztlAR7tx8BbYD2iqNL9bzo56R7DEiNf+0akYqvWB+oOqnhRQ/OXY0tFhUGfeIOg0ln/BwAcAAaZ78+OQSu1NdnnNu+qqtFf/pmmLDG1GBzryjSIeXLqwSVIAOyhOzmg87fuZ/6a9HGo4Z6oD/YI494BnqgvlyJghOvxvq+kvYWIX4Zil1+EyMo8osGxufUxo9HLI0s75WSPzepP+VlWrsq0niGmjwZ2v6ToOMqELVvIjOfrOFZayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJHxke5iC08EBlncNjrCum4y6biWnUoQcctF7p6f8z8=;
 b=GLRRV4m+k8w3ClQxRD4szYJEMFPZGVcKgGa6GWi+cEInFRsEwih5G9M5sGV7hx6z+KfMyn28YX7SsbB5YBCvpopqY0s9Z+QBzZ8g5WCseoeDD6QZs0NJxpmguwpzFgQCGfNQHCFsIG8yy96y6XmlZhUWKe6lmmXjDczApmDmmORCBciEZ2lJ5jBONuAFiaAG6DtqdSZODmw5cdN61FGBqeEnP5NWwLWL7cEOaieo0nRilA5grlYypLJ/OEWMBGarF1aBGXruQhZIuTN3AcwjolU9y9gZN8wUVL7HocI4R8eWYJnAbtR9odvNQ2wZ6EYtYLLF3G0UpOXmJRwVtM6qbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 22:34:31 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 22:34:31 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Topic: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Index: AQHX6EczClIG2E5d9UOz/2n0HlwT/KwgwqAAgABvMQCABDgvAIAATS4AgAAwM4CAACruAA==
Date:   Mon, 6 Dec 2021 22:34:31 +0000
Message-ID: <BEF5C312-4331-4A60-AEC0-AD7617CB2BC4@fb.com>
References: <YaoXUrLUZt1scVb0@kernel.org> <YaobYKgrTV1Bthi0@kernel.org>
 <80DE5BBF-E831-43F5-91DE-46775DE4D6E7@fb.com> <Ya4CxsyoyFQVFzoi@kernel.org>
 <90475C95-0E7E-4212-A390-2FB33E47EC04@fb.com> <Ya5r81oxLY1Lb/JN@kernel.org>
In-Reply-To: <Ya5r81oxLY1Lb/JN@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d77f5db-8f39-4dab-6e7b-08d9b908926f
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_
x-microsoft-antispam-prvs: <SA1PR15MB510985E22DB925FF14A70FB5B36D9@SA1PR15MB5109.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkhHV5CEOS0KFNscH+Cq9mmr333VjlBbViWWefrNaj2vVeLqQ6Xt3ZgQpKtNA2IA8GUMRU5UcmAs0QHgFe0cTIRtv7NSN4wsSV1u52uojBoEm6jaOymnisLa498wESFInDcvQwyCNc2eLdv0m9OITTCo9j6+YfvkojxI7gCGdHWlNOK8iKSNTEXfrr6+/TM/wVD8MJs9ic+6Q/fxAhXvviX0l3puQDaAXQ+IvrQp2f9LZC+EtW/ePdsXGZxM+fdIT3+rQcOiTeJfGAqrbP+kZsGyLWA66mUP8zHdDydzLguRk7eYVHBL8AgPYrZsefkpLxi8k+TtBjWEnzlitxWSeySmW4+2vKmUe1cv+ZtCsm3t+gnP9/RCiG/kgogWB8vL6zA1oL7tIewCRrh3XtEZlWlgbS/sFYd/vPT/ry/jVmtFEPL8ys0RVCigxyIRMJOUHpEMInX7rZqEL3DgmKsGcXD7jRA4bkTdass0di9LjeUUEi3s7f/oLQ5YWZmeAx/h7ixxAPgXBYKW/KM88/DD8DOQc/lccBIExXx+7NncbYJNCz2NCVKXxyGZ2iiwPHiGFEG0CPAE6mNH749SOwk7AV8pEvwuH2D94LTpP8oO7ygdaUuYCd9xSXmzzuHijQafa3sA5qQR+S+93dzMjwmPTcRnIdWNMJYbgJgYGDf0Z16Bcf09mZGwVztBxg9L8ltUJ34OU5pv7fDyHh8kR0oy5LqFlJxC6Zbe3J5n+17bhkF6AvL64Clw9wlWUCS+xSfE5N/yrSGsF5dlVC4xzOfp/ZHZhXJsd6HIFBS6NmHSE8whpr7IdEpygRkcqkPFS0K1y0PbWUsbcxOWLLDKCK7diA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(508600001)(66446008)(71200400001)(66476007)(966005)(66556008)(38100700002)(8676002)(5660300002)(64756008)(6512007)(186003)(66946007)(83380400001)(53546011)(76116006)(6916009)(91956017)(122000001)(2906002)(6486002)(4326008)(2616005)(33656002)(54906003)(316002)(36756003)(86362001)(8936002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c/9YboWJKkrKwVyeFjyAKf5EFDd9Ii96C2JbumkngVaZXUIeF0zjRqb95sOM?=
 =?us-ascii?Q?zdSn53wgx/ztPd30DeDPFvbt4hyezC9uPMdQWPaZMLwc0ozLhjkoVRzcYGYb?=
 =?us-ascii?Q?HR4SsoKY99JMmcdmImNKdm8/eFm4nM/cTXELTXfM2YErPH83W27QspsBc2Tu?=
 =?us-ascii?Q?KY/zqDIF2cMEwGn4dpBnVqaQmNbLvXBdv9mYTSWXuCsI41f/s9TYEc3XqXU3?=
 =?us-ascii?Q?CAyxmprKOy0ue/V3e/l4eTO1DncVLXJe4Sfkyd5WqQpiRRoP/1E7KAWaJjqx?=
 =?us-ascii?Q?5yieFy5hIpXXmzn4eskb6MfE/YCT0kL2etrdzp53RIWzNNiCWmH/bBKpUUvl?=
 =?us-ascii?Q?sezX+cqJ6utUisgqy6L9urm7QAX5HFyeOlxQXdP7Wyb+dJzv9WiJd87QosmO?=
 =?us-ascii?Q?rsDkaKLqTAZYjHHMYO7sWroHVfZScZfnQCSw8Nt9chlqXH0InpHi5DnVQ5Z0?=
 =?us-ascii?Q?YQQ+XmYcapqK5r9Cv9tIeJ2jySwtzt9jEMIBEg7GHg6Mmk2qjYQphigGMJ/0?=
 =?us-ascii?Q?Qr3ZUr8z4wQmItgifUdfjAodzNKGzOtHucvl3vW7qPXIVJmFKxpMFZjgp0bH?=
 =?us-ascii?Q?rRIR+V/ddoIGsnmkX23GjFVi5Bc4pleJXG3Xcdm5kSDWMDM0bYj9CBsYGpJK?=
 =?us-ascii?Q?dlWa4qm10j6wDDGEmlQChkcDIeS2ryizgwz90LkaRcf3tECfLUwXFsqtL2+r?=
 =?us-ascii?Q?31Qec88n/sCWtkygIPjVe7AKb3x9DYfcfR2CtCrQtz1YfKZR7dtoOtF+4t0u?=
 =?us-ascii?Q?oHU+2DB6gQBT+R4c82P/ecQHwEtZ37eop6XydtRl76Dd30hzzusKIAeJn5f1?=
 =?us-ascii?Q?38VgUStNWeemC92pQmLmcwxcuV87Js1PZctU5OAiTK581+Wh7zE8Nu8TPab7?=
 =?us-ascii?Q?PipBoNBYKiHifu45U1M7KkalkwjZTLwIZ8ks9pqpXH2BYjrRj4QdjYspMyVH?=
 =?us-ascii?Q?XIXxOAFAKwd7F9wdJt13mdVnkQzvPOXuhntiFNOOpP4rtiS9SD8JZAu481FY?=
 =?us-ascii?Q?WCoznDs1xDHoYTBzLVl+PfiC3H8bekLl9yKZ66n8QwgeNrowzLvGTaHL7u/D?=
 =?us-ascii?Q?1jpO6aLvgFC8kE3rKlslc6Bn9NUnXinuymPThCZFz9GbAVapW/TMNWOGBFX2?=
 =?us-ascii?Q?rTqxRHrM8fbu3vt/O5lPMj+ybVj6p5Uh25UE56AxBmuSK603524esBoO6gnr?=
 =?us-ascii?Q?4oiGzdBFP/1Jc7uBtT28h9IsAs5SeBtfE1Yt4RPmi/AqYAEq3lKO6OrcRV/n?=
 =?us-ascii?Q?KXChU923Fde2fXCNr+pUpjNlJu/bqZA1crmuO//3Cpj2H1ODjk6RV8OBHuL2?=
 =?us-ascii?Q?YstqQXMHSg3LnP/T/ytF2g3KAf3/8hAaHH99RPc1Y34WBh6TWg0BpGIAXLyU?=
 =?us-ascii?Q?OeNKvKIVdOhm7A/CAhNgDC01DF+DrJmbGlqc7o524kembl4/1gMsk0Ao2W4o?=
 =?us-ascii?Q?oQWJrXnVJMyVka/qsOqfz0ova98AFxpp2jdBw4SqMIUGzDwWDrDvIvtPls2h?=
 =?us-ascii?Q?7JCHSCzIVMZeXBKPzNM69U920zz+TmT3XxnDvYG5uIJAaVWYKfWKl9+C7RA2?=
 =?us-ascii?Q?NtlcqSgmkMeg1oQAootseLuSoambRD/IkF29EHjXkJzksuUwxJcB10eKnOEh?=
 =?us-ascii?Q?RsHexzUBrhsxvSM8wNMzzTbSlq8hNIF4/rUC1pcFvXjCiepx3wG6tHRDtug3?=
 =?us-ascii?Q?EEcuHQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C06FE69949A944F829A18B5E9588A4F@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d77f5db-8f39-4dab-6e7b-08d9b908926f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 22:34:31.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ebs8yhqpQtAFCUSlTvZxwlLYYI5M1Nd3NIj4gaOs9mp/Mkr6tQvXw+mgCqEFOAhFi6FiFthleiZIt9UIJiZ4bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5109
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 6VNJZ_p_kejO1a8CDqW3fN4_0x8y-bkF
X-Proofpoint-ORIG-GUID: 6VNJZ_p_kejO1a8CDqW3fN4_0x8y-bkF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_08,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 6, 2021, at 12:00 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> Em Mon, Dec 06, 2021 at 05:08:21PM +0000, Song Liu escreveu:
>> 
>> 
>>> On Dec 6, 2021, at 4:32 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>> 

[...]

>> 
>> Please see the following commit log. 
> 
> This is for the other one, where I stamped this:
> 
> commit ce71038e673ee8291c64631359e56c48c8616dc7 (HEAD -> perf/urgent)
> Author: Song Liu <songliubraving@fb.com>
> Date:   Fri Dec 3 19:32:34 2021 +0000
> 
>    perf bpf: Fix building perf with BUILD_BPF_SKEL=1 by default in more distros
> 
>    Arnaldo reported that building all his containers with BUILD_BPF_SKEL=1
>    to then make this the default he found problems in some distros where
>    the system linux/bpf.h file was being used and lacked this:
> 
>       util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
>               __uint(map_flags, BPF_F_PRESERVE_ELEMS);
> 
>    So use instead the vmlinux.h file generated by bpftool from BTF info.
> 
>    This fixed these as well, getting the build back working on debian:11,
>    debian:experimental and ubuntu:21.10:
> 
>      In file included from In file included from util/bpf_skel/bperf_leader.bpf.cutil/bpf_skel/bpf_prog_profiler.bpf.c::33:
>      :
>      In file included from In file included from /usr/include/linux/bpf.h/usr/include/linux/bpf.h::1111:
>      :
>      /usr/include/linux/types.h/usr/include/linux/types.h::55::1010:: In file included from  util/bpf_skel/bperf_follower.bpf.c:3fatal errorfatal error:
>      : : In file included from /usr/include/linux/bpf.h:'asm/types.h' file not found11'asm/types.h' file not found:
> 
>      /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
>      #include <asm/types.h>#include <asm/types.h>
> 
>               ^~~~~~~~~~~~~         ^~~~~~~~~~~~~
> 
>      #include <asm/types.h>
>               ^~~~~~~~~~~~~
>      1 error generated.
> 
>    Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>    Signed-off-by: Song Liu <song@kernel.org>
>    Cc: Jiri Olsa <jolsa@kernel.org>
>    Cc: Namhyung Kim <namhyung@kernel.org>
>    Link: http://lore.kernel.org/lkml/CF175681-8101-43D1-ABDB-449E644BE986@fb.com
>    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> For this patch:
> 
> diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> index b8fa3cb2da230803..4a6acfde14937704 100644
> --- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> @@ -1,7 +1,6 @@
> // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> // Copyright (c) 2021 Facebook
> -#include <linux/bpf.h>
> -#include <linux/perf_event.h>
> +#include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include "bperf.h"
> diff --git a/tools/perf/util/bpf_skel/bperf_leader.bpf.c b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> index 4f70d1459e86cb99..40d962b05863421e 100644
> --- a/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> +++ b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> @@ -1,7 +1,6 @@
> // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> // Copyright (c) 2021 Facebook
> -#include <linux/bpf.h>
> -#include <linux/perf_event.h>
> +#include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include "bperf.h"
> diff --git a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> index ab12b4c4ece21a9a..97037d3b3d9fa4cd 100644
> --- a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> +++ b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> @@ -1,6 +1,6 @@
> // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> // Copyright (c) 2020 Facebook
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> 
> 
> But what I asked now was a commit log message for this other one:

Sorry for the confusion. Please use this one, which also removes 
bperf.h (which holds the typedef). 

Thanks,
Song

====================================== 8< ========================================

From e033fd36657288ece383ba528aaff7b56eebfee2 Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Fri, 3 Dec 2021 15:14:41 -0800
Subject: [PATCH] perf/bpf_skel: do not use typedef to avoid error on old clang

When building bpf_skel with clang-10, typedef causes confusions like:

  libbpf: map 'prev_readings': unexpected def kind var.

Fix this by removing the typedef.

Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf_skel/bperf.h              | 14 --------------
 tools/perf/util/bpf_skel/bperf_follower.bpf.c | 16 +++++++++++++---
 tools/perf/util/bpf_skel/bperf_leader.bpf.c   | 16 +++++++++++++---
 3 files changed, 26 insertions(+), 20 deletions(-)
 delete mode 100644 tools/perf/util/bpf_skel/bperf.h

diff --git a/tools/perf/util/bpf_skel/bperf.h b/tools/perf/util/bpf_skel/bperf.h
deleted file mode 100644
index 186a5551ddb9d..0000000000000
--- a/tools/perf/util/bpf_skel/bperf.h
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-// Copyright (c) 2021 Facebook
-
-#ifndef __BPERF_STAT_H
-#define __BPERF_STAT_H
-
-typedef struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(struct bpf_perf_event_value));
-	__uint(max_entries, 1);
-} reading_map;
-
-#endif /* __BPERF_STAT_H */
diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
index 4a6acfde14937..f193998530d43 100644
--- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
@@ -3,11 +3,21 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "bperf.h"
 #include "bperf_u.h"
 
-reading_map diff_readings SEC(".maps");
-reading_map accum_readings SEC(".maps");
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(max_entries, 1);
+} diff_readings SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(max_entries, 1);
+} accum_readings SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
diff --git a/tools/perf/util/bpf_skel/bperf_leader.bpf.c b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
index 40d962b058634..e2a2d4cd7779c 100644
--- a/tools/perf/util/bpf_skel/bperf_leader.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
@@ -3,7 +3,6 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "bperf.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -12,8 +11,19 @@ struct {
 	__uint(map_flags, BPF_F_PRESERVE_ELEMS);
 } events SEC(".maps");
 
-reading_map prev_readings SEC(".maps");
-reading_map diff_readings SEC(".maps");
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(max_entries, 1);
+} prev_readings SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(max_entries, 1);
+} diff_readings SEC(".maps");
 
 SEC("raw_tp/sched_switch")
 int BPF_PROG(on_switch)
-- 
2.30.2

