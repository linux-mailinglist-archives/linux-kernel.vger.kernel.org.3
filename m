Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5755646A264
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhLFRLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:11:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49502 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhLFRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:11:54 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6GvWHR026960;
        Mon, 6 Dec 2021 09:08:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=8Tz67/TcFkIGg5CpvCxjo2EYGQhducin384Y63X0gvU=;
 b=qUQVQapOV4AnWry4IYiEaiq+LTosvJ8Y8vQo+zY6EelKgGX/jUmwJ7uhO8Wdik5Q/1bb
 9jhapvLbzsnQs1WlJMSKcoo7/0qlXFCVkwzOhB+EevBlb4QowBAAh6pTgzC/6LQUX5tU
 Ah4coF85bi8aUIhEUlpnvHewTx9JpV6x9fQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cs9h9m8mn-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Dec 2021 09:08:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 09:08:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwdfwl7HBrb/3LyqpnM0F0VEsxcBRKGUd491c5zIN/m7pXGkX+m6bg7LsLXH+aj87o/A5B6goGu/2597+UPHOPfZSt8ldjm25zJgo0i+YrKFuTsWQX3qxBSJzgkEWvc+xiy8X1G+xgR0L1X1ryl6Pg8dOMFE7OBigdnT8s0oOVe2xP6lISl1KaaJqMT3tz2zh5sNf9wHBdQ5icMDi7WgPqFJUXDO/BIPUgoOI7WK9vezUcH0B5Zd/pOAdA7WrvxIozSgRssI3ebzx/a55WauWbZbbwShRBkx8rUablEme4f4GRyTXalatPUBmfGZQ1MfL42oeNmMIoErC5l8VlWlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Tz67/TcFkIGg5CpvCxjo2EYGQhducin384Y63X0gvU=;
 b=eA5/VLWDCG0LFoZZ+vqCHhVvvR3VtsgVy1tLP4bMKZrzNu/SAGLGfvGXeUs3/f7VGHlR0tF6pjPT0ndasdc2f884rzcMwewQBj+YrHsEN54JYZoEyJguQbgWr1MDFqhX52Nwn68i7zSa5HVSyxOiRxbSGHbOjGxoO3iGGI7SVTQKeflmMgb/J94QUSH1pdDdVp2OxGtNbApoSn1f1IzpwPtDvAaDFWX1LbP05VM4eZakc+GwNJQncTc/yXx6mQr6Y8zYcWpxZluC8ecTg3qdEFq+scFFxX1A23pMB+pruKKLVlunTFNPA/SjvVxt2CphCsM0zR6tWjlpW3z8MMHtfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5094.namprd15.prod.outlook.com (2603:10b6:806:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 17:08:21 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 17:08:21 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Topic: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Index: AQHX6EczClIG2E5d9UOz/2n0HlwT/KwgwqAAgABvMQCABDgvAIAATS4A
Date:   Mon, 6 Dec 2021 17:08:21 +0000
Message-ID: <90475C95-0E7E-4212-A390-2FB33E47EC04@fb.com>
References: <YaoXUrLUZt1scVb0@kernel.org> <YaobYKgrTV1Bthi0@kernel.org>
 <80DE5BBF-E831-43F5-91DE-46775DE4D6E7@fb.com> <Ya4CxsyoyFQVFzoi@kernel.org>
In-Reply-To: <Ya4CxsyoyFQVFzoi@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec49bf89-0f85-4646-d60c-08d9b8db01a9
x-ms-traffictypediagnostic: SA1PR15MB5094:EE_
x-microsoft-antispam-prvs: <SA1PR15MB50942FBC8B3BADABA348E813B36D9@SA1PR15MB5094.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0s9zKgApYu2iJEhOQGYfXFwxq3y7u5Eq9iiENWjORzY+R1zZ2PAkAGAm+Wtay0GWlc9tdpBL92FU9FGFuvy1Sq8KP/dsdyAsjtwQspwb73T/28HqW/D3xZG6A3gr2jnuiYxPvxalXgTnPPuPHkfFHjLas3Q7swKXM8nR6VHBSe2NC/Kof5OT9DrIg/DurjNrcBJqSw4y3P+ikY/OoHMc7sWuEo4GDkEsMeWbMYIyjeYDm14RteJuwG5IjHnuItl3LCmvsJ9OENz125WPcBj+au7Hazr8IUpgJoNY+wBt+dNMYXikTC9lgcVJA0XOVj0y8wCqMj42i3CA9p0zN/NyMMyA7mkwJovY1uguI+aIYlHIT8lUPmZWVk5Z3zUn4NKfAh+XMXLYJwl/JgLWI7FMO+mt/EHp+lD1BCWHEAS/xkexDdAoSwQWf+G157K/KzuvLABWZ30tLdbNnxjgjbjj7N/+UdyvEGypvSzm3iTAtaiLnOgH7HLQsEItuWLW8hJUr64GSZTJ6zU1EDteTyVEPS7rla45+/h4f5H4Qb7cxtyIDbW4UVI4ZbGhir5LT/CGs6Y/h0EzCEAW17xHhlvU2KaQ4mkqbKhYLTdhmwDn3asA2naZU3YjdkL678TxN/t8TUaMqFGX/MrwAgA1URiUR4gd8zfQaomshExySLLoXExNbUg6Gs1X8ZzlTpCcv9dZEO0BuYLi049AQl+tO+vF+jm88GPxnY89iWs5OZAh2xi5SaDH03BMEnjXBQL4X/j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(508600001)(38100700002)(86362001)(36756003)(4326008)(6506007)(76116006)(6512007)(6486002)(83380400001)(122000001)(53546011)(66446008)(5660300002)(91956017)(186003)(2616005)(8936002)(316002)(66946007)(66556008)(64756008)(38070700005)(6916009)(71200400001)(8676002)(66476007)(2906002)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vp7FkK9ZqJsfcAsqcHH25Op3XO3TN3AzHCAj12xDL3irHOVVB/Ijkp9fv0Pv?=
 =?us-ascii?Q?qZdL0Wl++g2MrUMqwbHBoeptHKJGJCLkO807sx2iCCrDpUwjo0ogHYhcoxKi?=
 =?us-ascii?Q?P0MnVqScsECU0apw8qSLKRYNF8ypJlybqTMPMEBQqD743BmnSGavumh3d5Vp?=
 =?us-ascii?Q?nqlE6jkXSssP4DXzZV9mFbkva5aoh8Vhbb6gHNnIskgLauoScqwL07gfzrNJ?=
 =?us-ascii?Q?dHwJ619Fkflpwt7TNK2QmDbGwf7WAU6LN/klLGyC8WkaY0e/ftNlOw6E1Uf5?=
 =?us-ascii?Q?Ys6ELGtmz6vL8miyTqvvJz2cyf81mXeakBy4g13uTYQ/bJuRp+me3UlAfj9u?=
 =?us-ascii?Q?XaAVMT+0AqO17282E46EbBFet0jvAMDVumvQwLB8uX7A/3Cw1ePIMbcIVNZ2?=
 =?us-ascii?Q?s3cR+yHXoALHlXftgxAqrs0zV7198TTGUJVIR0wb9HSGHezc+DKZxB8KDLKO?=
 =?us-ascii?Q?1onVNJtCGjThatDZjqz7c0ly+11VnJS8KqLncmYkyEF3SWejTdnvWm/lQOgf?=
 =?us-ascii?Q?tL7ZL7CjJw0cQBdxQQdRaA4KK22o8kqhwQFkQM/V/T9DLCCz5EDBrakUIph0?=
 =?us-ascii?Q?Y7fzZMsEdf8nL5JmmCBq1hFi2TORsa18ugFBKxwTTKj7FOzaTcyFzVbXydgz?=
 =?us-ascii?Q?9vFfA0kCLK7rxB48YY2uyUk3jfyyRN9KkqIHNmHIa1tSH8/ZZ9F0VEe3M07d?=
 =?us-ascii?Q?HpWD0Zvr7JJwq9KmWmUvBHYgXC+C1ycOMDs2QAViHUKJYp1gdF4yJZonXBlt?=
 =?us-ascii?Q?kXlNpiALs7HGPmfxjE90Y5HmHdG4+diLphWDAytAHytITchHPIvP4NJySshb?=
 =?us-ascii?Q?k20/wHCfDqPAnljLCi5PQWWglGUTwEetaMqi1wQgsKJRgibHMkWyoou3a6lZ?=
 =?us-ascii?Q?G4b+xKvsDsAuxukbVtEfZTXpaO/1jrQ80oiB+/GXZvduYHiFsb9pmjxmRiKB?=
 =?us-ascii?Q?+0SgGDB62tEuJSornnVGPJXE8APgk50Bf4bM21VOAbj0n51tOv9h1FaBUzE8?=
 =?us-ascii?Q?aBotH+RAUmOrXsgu1zcfWDXuUoqSG0uKKohQNzyTxLDM+WwDjs1FjY4B6Z/j?=
 =?us-ascii?Q?omI8ntCZSfHpM3b+kbQyldlDRJrA3kSaIxSzLrV+dR5MFATTeF9fHTQJQKt+?=
 =?us-ascii?Q?aJRLsZ45hiBrHZewApIqL+eJG0vN/1M9OYOyK/EivsitTiuBBnTWDhx+FbAO?=
 =?us-ascii?Q?f9b6eWVIY+y8sWBHuasAIvWxFFDMLaMMtyiukZW9jPvlYmG4/PTLdijfsrph?=
 =?us-ascii?Q?4CplgR3CiUlDnNlMbAklLyN9qTVcyvG9xav9a17C4W3mFbSCeSYHnq5emCuk?=
 =?us-ascii?Q?QfCA8APx9qrC6HPkxOd4+D0X9XjrpuYB0T3kKAE2NBH8XqEtvVxJgPNayFrq?=
 =?us-ascii?Q?UgFHumI7QLpheQ+gM3+diDw8+fAFSBKQFMUrsbnK5eErbBSFjUIuhG6PmvIr?=
 =?us-ascii?Q?vUQp9ke7poO4cJ1J0p1bSHlcAQZrqz7BQ93XSBlpLki5TPWfJduUUdhT66Ow?=
 =?us-ascii?Q?C0IaBHQ3MwTBNhaAHzqBMdcARVtl7OQorjVl77Rs/b0Y15gRqoTeOMf1zeso?=
 =?us-ascii?Q?CNUWx6BoWlVYJRr47YkZrAEbPcvlmXVuiS/BhECW5YJqoGjnnQpJo7tKSJCQ?=
 =?us-ascii?Q?fkMpBy1iLHHDrcviCk/CYJaB0o7BjDsAL7eToU/04f1iTHh6nYSLdYFT3SQy?=
 =?us-ascii?Q?XZGsgg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E434EB0493BADC44AE6D6AE6C3642436@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec49bf89-0f85-4646-d60c-08d9b8db01a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 17:08:21.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tw/O0KDyDzR1hWi4hIvICkNsWYoxCQsTISbjgel5+rkABD5pbfMxkGKBxlWIQwOR63Opmby1TmamoDXKPYogiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5094
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: wf0cuBZBP-l97xTe2v-FGVCnX-qmddty
X-Proofpoint-GUID: wf0cuBZBP-l97xTe2v-FGVCnX-qmddty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 6, 2021, at 4:32 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> Em Fri, Dec 03, 2021 at 08:05:59PM +0000, Song Liu escreveu:
>>> On Dec 3, 2021, at 5:28 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>> The failure for fedora:32, which seems to be on the threshold for clang
>>> to be considered recent enough for building skels fails differently:
> 
>>> clang version 10.0.1 (Fedora 10.0.1-3.fc32)
>>> Target: x86_64-unknown-linux-gnu
>>> Thread model: posix
>>> InstalledDir: /usr/bin
>>> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
>>> Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
>>> Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
>>> Candidate multilib: .;@m64
>>> Candidate multilib: 32;@m32
>>> Selected multilib: .;@m64
>>> + '[' '!' ']'
>>> + rm -rf /tmp/build/perf
>>> + mkdir /tmp/build/perf
>>> + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf
>>> make: Entering directory '/git/perf-5.16.0-rc3/tools/perf'
>>> BUILD:   Doing 'make -j32' parallel build
>>> HOSTCC  /tmp/build/perf/fixdep.o
>>> HOSTLD  /tmp/build/perf/fixdep-in.o
>>> LINK    /tmp/build/perf/fixdep
>>> /bin/sh: -c: line 0: syntax error near unexpected token `('
>>> /bin/sh: -c: line 0: `expr bison (GNU Bison) 3.5 \>\= 371'
>>> Makefile.config:997: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
>>> 
>>> Auto-detecting system features:
>>> ...                         dwarf: [ on  ]
>>> ...            dwarf_getlocations: [ on  ]
>>> ...                         glibc: [ on  ]
>>> ...                        libbfd: [ on  ]
>>> ...                libbfd-buildid: [ on  ]
>>> ...                        libcap: [ on  ]
>>> ...                        libelf: [ on  ]
>>> ...                       libnuma: [ on  ]
>>> ...        numa_num_possible_cpus: [ on  ]
>>> ...                       libperl: [ on  ]
>>> ...                     libpython: [ on  ]
>>> ...                     libcrypto: [ on  ]
>>> ...                     libunwind: [ on  ]
>>> ...            libdw-dwarf-unwind: [ on  ]
>>> ...                          zlib: [ on  ]
>>> ...                          lzma: [ on  ]
>>> ...                     get_cpuid: [ on  ]
>>> ...                           bpf: [ on  ]
>>> ...                        libaio: [ on  ]
>>> ...                       libzstd: [ on  ]
>>> ...        disassembler-four-args: [ on  ]
>>> 
> 
> <SNIP>
> 
>>> GEN     /tmp/build/perf/util/bpf_skel/vmlinux.h
>>> CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
>>> CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
>>> CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
>>> CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
>>> GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
>>> GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
>>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
>>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
>>> libbpf: elf: skipping unrecognized data section(7) .eh_frame
>>> libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
>>> libbpf: map 'prev_readings': unexpected def kind var.
>>> Error: failed to open BPF object file: Invalid argument
>>> make[2]: *** [Makefile.perf:1076: /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h] Error 255
>>> make[2]: *** Waiting for unfinished jobs....
>>> make[1]: *** [Makefile.perf:240: sub-make] Error 2
>>> make: *** [Makefile:70: all] Error 2
>>> make: Leaving directory '/git/perf-5.16.0-rc3/tools/perf'
>>> + exit 1
>>> [perfbuilder@five 32]$
>> 
>> Cc Andrii. 
>> 
>> Could you please try the fix below? 
>> 
>> If it doesn't work, could you please dump btf for debugging?
>> 
>>  bpftool btf dump file /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
> 
> It fixes the issue on Alpine Linux 3.12 and 3.13, Alt Linux p9 and fedora:32, probably others, still testing.
> 
> Can you please provide a cset commit log for me to stamp on it?

Please see the following commit log. 

Thanks,
Song

====================================== 8< ========================================

perf/bpf_skel: use vmlinux.h in skeletons

When building bpf_skel in perf on a system with older linux/bpf.h header,
we got errors like:

   util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared
   identifier 'BPF_F_PRESERVE_ELEMS'
           __uint(map_flags, BPF_F_PRESERVE_ELEMS);

Fix this by using vmlinux.h instead. Also remove include of perf_event.h,
as it redefines structs in vmlinux.h.

Fixes: fa853c4b839e ("perf stat: Enable counting events for BPF programs")
Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Song Liu <songliubraving@fb.com>


