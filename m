Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF53467E99
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382989AbhLCUJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:09:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382982AbhLCUJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:09:27 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3JjesS026123;
        Fri, 3 Dec 2021 12:06:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=s7l21myOHd7GZUGXPsk+h428PHpRU1Rp6PymKktLlUM=;
 b=kd3asy0IFSKdOs7a70fLAgoR6i99pRdECaUlbqcJ2s4WvU125HlsFSy2lyc6nDeqw0mA
 g9FZ2kJXr2EYFR6EfF6V7hWGkhJPUMSoPFAYBxiGT3bucdHwvqCjPVXbViXOse/idz7k
 5dYZvwdPVOmnzv/tmEqqsgnNmOkVZw8ZQcE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cqnf0241w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Dec 2021 12:06:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 12:06:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St14bCHO0smIJ5ccqShsb1/S94sqkVD4LtYQ6RUO/f4Q+cU+Kg8MEttHNwgT2WmnDTH5JIspt5u6V7332YF5mj3YynHlkVzKayvqjm15xiNtgCVhW5vUCtUW2PEG9v/WVaJRneqiNifMQ7Prz+Rc9CycsPY9JtjHdFbSz6RN060PZfHmPjLAtlLxNunDCV0/timgehRarrMiVxbA9TlLYYVIO2vFDHg7vGD6ZUk6aX/1x3j2S6o5eKb5qB/6XXX6Xck1BRYkr/OAPhxNVzDdIFVSgbMB9K2cd55WFDfd9qbEcExbbgWoMN33izpL+U/6jiOW2JnMwoEQ1UjK4Ko6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7l21myOHd7GZUGXPsk+h428PHpRU1Rp6PymKktLlUM=;
 b=B0zHslOa31QWHfneQalYh3RYYWDNiV6Vjd5IID5cZjbXYryAaUzM7DLFGo6Gk3l9jSR616GoeBtqvOPF6uL2eIcOox8vRh2rYKFuI5bITNPk1pEkG0tke2V0AyUOJv613V4miNYXSjLbqMzqsRkOM7btfGryoly7havlctua40V5ehwD9ZtP4gpSxw6N//kYqCrJzJkaHspzPDV7IL3HfZBCzJDxLQfB3bKa5ocxHwTZfyoOGK4BwB6CRam5UPnxkh6Chm/4saFwnwuCngHvvOQD7YGlsBumcCRlI8FYLfK5eBHjMJ3vXTmy6Itvn3ge18RJTTi9JNWQUOhfTGjRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5233.namprd15.prod.outlook.com (2603:10b6:806:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 20:05:59 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%5]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 20:05:59 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Topic: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Index: AQHX6EczClIG2E5d9UOz/2n0HlwT/KwgwqAAgABvMQA=
Date:   Fri, 3 Dec 2021 20:05:59 +0000
Message-ID: <80DE5BBF-E831-43F5-91DE-46775DE4D6E7@fb.com>
References: <YaoXUrLUZt1scVb0@kernel.org> <YaobYKgrTV1Bthi0@kernel.org>
In-Reply-To: <YaobYKgrTV1Bthi0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a6ff7c7-4723-4b85-d83a-08d9b6985337
x-ms-traffictypediagnostic: SA1PR15MB5233:
x-microsoft-antispam-prvs: <SA1PR15MB523304AA669A25F388B98646B36A9@SA1PR15MB5233.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XL6JTFnbUHrohDjsfHXVCR2E3oFnXJ9qlJ7/GpOLpZGkWOPSSNnVAmZKNSgtGh7pm1yAkHNLzNAhUvIWY8CEAOL4sHlMmAlnsHAGt420y0oMfolmHU+AgmGmXpgqLrHgrhCTYoO5SCf+dElmUUyO8HkEgR/Pzdw3NxtMaVlCVB5DUeAYnNe7kWHOKcUKL7V5ZNVYQjAJyya1Tht+sKryzJ3UQx+izwhQaf29OsoWXHO+LnZRi/7vxuiJxjDkAOERp+uagILUKFC5sr4Qr3SKR2I1qX6lAQDrgAMB28ltrVx0EHjTg8+3m3Y9oJDbCdsLrcIDAsuY/JjjKUfLUb3TT5rdIKTW5Xspp/TCJJqm84RAdi9sSoxQzYosNqVdr7E+BBG4p+Sxm2M97+Wl8E4eVqgEaa072wkRpqMf4v95m5qdBVxZuD5tFrPM4G/9V5VtZx3/8Xo+Y3shEAnLeRSW+lSfrrFFsPuRBdHkgNQz08KozM7djQPoCxhLB98lGWvDuW/t4/Tck7vJBUg+KlgIUuRVdOViy95ZVQYVUabR9yioQELBHyIq2K4mceiBd/LsXoJortmxXHWpEEF8pTSObwXNHAh49iJUwbizn3hT2+3SdsSzqqkV0aWW2jkkvifUl9feLqL0lhWVHvG55Yjq2lbICgDU31NKqFRLUTsm9wNQZps05OHIZO4mcC47N/m0yD0XkmE1J7RZB3t+D5TRZdYM80qN/XuCWpv1+6XE8DnYNSrypBbh2s9djFZxI2ZP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(4326008)(316002)(86362001)(2906002)(8936002)(508600001)(6512007)(38070700005)(54906003)(8676002)(30864003)(33656002)(36756003)(71200400001)(6486002)(66476007)(64756008)(91956017)(66946007)(76116006)(2616005)(6506007)(66446008)(66556008)(122000001)(38100700002)(83380400001)(186003)(5660300002)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ljMqCOLxkQFY3WPUa9Tyjl0+IQiwruHSOhHks/XgOxn9aIfTGM3BHJYGoBS?=
 =?us-ascii?Q?4TUYTbgP8s/j2wRucEPL/ZXkqryz1Nf5ox+mCPO3x4MHy1EbfF6LzMJCWpBq?=
 =?us-ascii?Q?K56oqaRaQbNcfuTNbn+FHlfoukjech4MfafxPpuQ0BOCKLO86YwNlqI4rzLb?=
 =?us-ascii?Q?ecG2UUGxByAAAtNjakuUHSY1ZIJ10ryR2VH8fvISz2CL2rFNCV9oAF2P5sWG?=
 =?us-ascii?Q?fPiUMXyWfa20ta3YdfOUbq5JitM/ft0x7aft6ID0iilwGtC1/tn1PvOEBXmO?=
 =?us-ascii?Q?1ABY7EILeM8hhN7Rg2JcLItqqBzsuvzIJLRF520pTZe2Ggcq6Lo6PmEwfMV5?=
 =?us-ascii?Q?x/W8JBgdcB1+FfAngjpsT7rnCmFapDlolZG/gz0EUw7vtzal9HyeEj0YBcyV?=
 =?us-ascii?Q?G/ZNYToKFeajzLXihmaSbdysu7tDc1cdFPd6O6qZ3dPs7e3IuvmHn/GGidAq?=
 =?us-ascii?Q?oJtpColfghlNK0BpnskKNhQew88/QKU3J7kL9R8Rczwf9q3+qW0C5l4/+2At?=
 =?us-ascii?Q?tTqrVz+9kpMq735RG+dy3lmPkjFelJZnWYBFqSnYyRLdRugWwr7m/OndPE3T?=
 =?us-ascii?Q?6HhPv2l3ps8wZS2YGob3aMaCQbZBknnOFI64SM/mb6jUV8Jq2c5W/c21HdB7?=
 =?us-ascii?Q?eJzoUfl4cE7R3jr8XJAoRvgnNNaTQl1U5Xq4gKk0IkZ4RWRaSN+lst2Gc+X3?=
 =?us-ascii?Q?Z4n59eArE8ZaYFbRz7LE2V2gT7kMSQL27u5WYNrLHCnxfmrP/LwQWjYGfk9U?=
 =?us-ascii?Q?9UR7WabwnkZd28g/djAKUEfFqVTpJu7KG8r8UzrAC9KKQcW9XeU+2ayz5Kdf?=
 =?us-ascii?Q?9ssAvV6TSFylb5jMAbat0WLme5oZOTebzHA1CGugAJ1uTnkdLVk7hGRl+Wy0?=
 =?us-ascii?Q?FNL4XqYZ+iPAVxZa5sO+80krF6oo1yuDKReqSK1ut6RDG7GZfgVYQ6u4aPLN?=
 =?us-ascii?Q?qoGZI2M6UBysHeqyKSMA8g4u4UxUXEdlReJoRkZGPY35G9gRIbGUbt3x9vUJ?=
 =?us-ascii?Q?ks84PrH7H5YGN+2tHwgcgT+afTR5t0UeAYvXbc3KkCCaFT3fYvbBgWuvvF4v?=
 =?us-ascii?Q?QvljPDLEhbl+OUbP4zYb4vQYRwEfpR4mqxerbeEOteHluijeUK8pvjy0QXKZ?=
 =?us-ascii?Q?oKySD0VKM7W71SeoegymzLbIpOuL6vutqkjKC+xzekJrqyvHN8eS/494HAu0?=
 =?us-ascii?Q?MmYR9M9tlgj4FXfqotocbQ5bXsl9TVeXLfdY8X8oHqNL5I84bU+C0TrQkU+e?=
 =?us-ascii?Q?jvYLdWyGRsj+d0Qe2ge25Mq+tJ8Jiokrx9qhMVi2UcB2cipt8aLhs7bQWnyZ?=
 =?us-ascii?Q?O4fglnnpmcxRHtGOnJmIuiGqnd3sQ87hZA6LPh5UrUdBfyGjRXy5tkfoYzSo?=
 =?us-ascii?Q?8lVEXRBRRaZbgT6FrlxRJAY7lQZ9LkjGgmyEfHnq09ZSxOWmjRAgg4TApEXU?=
 =?us-ascii?Q?1MSRziKcm2Z20IdNFBJMEsHCOqnWNOVbLW6a+E69um/D9C0DhBpB2gtH/Wa1?=
 =?us-ascii?Q?Tazfs/iDh4WZma+YTWRrw/A/uBjHLacsrqyugOHtaWbGtcX5Zn+TsFv8tpv3?=
 =?us-ascii?Q?rrkVJsqQa+iUR5z7FNtDzHaN+FYPfjmxo3d5ao7J4xcGRhlRfWzbKX6fUkA3?=
 =?us-ascii?Q?QU7ESs02gXU03pC18YNQ5+0AAMAiGwMnwnB56dMwBfeFaRDnlPcdcrqFg88j?=
 =?us-ascii?Q?IbE7zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <242D3EC4B79B724BB42E7145B8FD94EE@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6ff7c7-4723-4b85-d83a-08d9b6985337
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 20:05:59.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gY0fM6o4fO2NUamL/osoqtZ98HZKSNZRW5YQ3ClEOxAmgftN8kpx+i44Agu4pDewR0EVaMax2SuhpjVWGgcKJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5233
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 0tBzvmak6WDiQl6zM8DxhQtm91HIkWLy
X-Proofpoint-ORIG-GUID: 0tBzvmak6WDiQl6zM8DxhQtm91HIkWLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_10,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 3, 2021, at 5:28 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> Em Fri, Dec 03, 2021 at 10:10:42AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Hi Song,
>> 
>> 	So I'm changing all my containers to build with BUILD_BPF_SKEL=1
>> to then make this the default, so far older containers fail either
>> because the clang available is too old, so I've added a NO_BUILD_BPF_SKEL=1
>> env var to disable that in those containers and then there is this other
>> case where clang is recent enough but:
>> 
>>    util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
>>            __uint(map_flags, BPF_F_PRESERVE_ELEMS);
>> 
>> Because the system's /usr/include/linux/bpf.h doesn't have that
>> BPF_F_PRESERVE_ELEMS enum entry.
>> 
>> These are enums to make them available via BTF, but then I can't use
>> the:
>> 
>> #ifdef BPF_F_PRESERVE_ELEMS
>> #define BPF_F_PRESERVE_ELEMS (1U << 11)
>> #endif
>> 
>> approach.
>> 
>> But then we _have_ it in the tools/include/uapi/linux/bpf.h we ship:
>> 
>> $ grep BPF_F_PRESERVE_ELEMS tools/include/uapi/linux/bpf.h
>> 	BPF_F_PRESERVE_ELEMS	= (1U << 11),
>> $
>> 
>> so we need to switch to using it somehow, this way we can build in more
>> systems and make bperf and other BPF enabled features.
>> 
>> From a quick look I couldn't find where to add
>> $(sourcedir)/tools/include/uapi/ to the include path used to build
>> util/bpf_skel/bperf_leader.bpf.c, should be easy, can you take a look?
> 
> The failure for fedora:32, which seems to be on the threshold for clang
> to be considered recent enough for building skels fails differently:
> 
> clang version 10.0.1 (Fedora 10.0.1-3.fc32)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
> Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
> Candidate multilib: .;@m64
> Candidate multilib: 32;@m32
> Selected multilib: .;@m64
> + '[' '!' ']'
> + rm -rf /tmp/build/perf
> + mkdir /tmp/build/perf
> + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf
> make: Entering directory '/git/perf-5.16.0-rc3/tools/perf'
>  BUILD:   Doing 'make -j32' parallel build
>  HOSTCC  /tmp/build/perf/fixdep.o
>  HOSTLD  /tmp/build/perf/fixdep-in.o
>  LINK    /tmp/build/perf/fixdep
> /bin/sh: -c: line 0: syntax error near unexpected token `('
> /bin/sh: -c: line 0: `expr bison (GNU Bison) 3.5 \>\= 371'
> Makefile.config:997: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> 
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                        libbfd: [ on  ]
> ...                libbfd-buildid: [ on  ]
> ...                        libcap: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ on  ]
> ...        numa_num_possible_cpus: [ on  ]
> ...                       libperl: [ on  ]
> ...                     libpython: [ on  ]
> ...                     libcrypto: [ on  ]
> ...                     libunwind: [ on  ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ on  ]
> ...                     get_cpuid: [ on  ]
> ...                           bpf: [ on  ]
> ...                        libaio: [ on  ]
> ...                       libzstd: [ on  ]
> ...        disassembler-four-args: [ on  ]
> 
> 
>  GEN     /tmp/build/perf/common-cmds.h
>  PERF_VERSION = 5.16.rc3.g0c338bcdfdb1
>  CC      /tmp/build/perf/exec-cmd.o
>  CC      /tmp/build/perf/help.o
>  CC      /tmp/build/perf/cpu.o
>  CC      /tmp/build/perf/pager.o
>  CC      /tmp/build/perf/debug.o
>  GEN     perf-archive
>  CC      /tmp/build/perf/parse-options.o
>  CC      /tmp/build/perf/str_error_r.o
>  GEN     perf-with-kcore
>  CC      /tmp/build/perf/run-command.o
>  CC      /tmp/build/perf/sigchain.o
>  GEN     perf-iostat
>  MKDIR   /tmp/build/perf/fd/
>  MKDIR   /tmp/build/perf/fs/
>  CC      /tmp/build/perf/subcmd-config.o
>  MKDIR   /tmp/build/perf/jvmti/
>  MKDIR   /tmp/build/perf/fs/
>  MKDIR   /tmp/build/perf/jvmti/
>  CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
>  CC      /tmp/build/perf/dlfilters/dlfilter-show-cycles.o
>  MKDIR   /tmp/build/perf/jvmti/
>  CC      /tmp/build/perf/fd/array.o
>  MKDIR   /tmp/build/perf/fs/
>  CC      /tmp/build/perf/fs/fs.o
>  MKDIR   /tmp/build/perf/jvmti/
>  MKDIR   /tmp/build/perf/pmu-events/
>  CC      /tmp/build/perf/event-parse.o
>  MKDIR   /tmp/build/perf/pmu-events/
>  CC      /tmp/build/perf/jvmti/libjvmti.o
>  CC      /tmp/build/perf/jvmti/jvmti_agent.o
>  CC      /tmp/build/perf/fs/tracing_path.o
>  CC      /tmp/build/perf/jvmti/libstring.o
>  CC      /tmp/build/perf/fs/cgroup.o
>  HOSTCC  /tmp/build/perf/pmu-events/json.o
>  CC      /tmp/build/perf/jvmti/libctype.o
>  CC      /tmp/build/perf/core.o
>  HOSTCC  /tmp/build/perf/pmu-events/jsmn.o
>  MKDIR   /tmp/build/perf/pmu-events/
>  HOSTCC  /tmp/build/perf/pmu-events/jevents.o
>  CC      /tmp/build/perf/cpumap.o
>  CC      /tmp/build/perf/plugin_jbd2.o
>  CC      /tmp/build/perf/plugin_hrtimer.o
>  CC      /tmp/build/perf/plugin_kmem.o
>  CC      /tmp/build/perf/threadmap.o
>  CC      /tmp/build/perf/plugin_kvm.o
>  CC      /tmp/build/perf/evsel.o
>  CC      /tmp/build/perf/plugin_mac80211.o
>  LINK    /tmp/build/perf/dlfilters/dlfilter-show-cycles.so
>  CC      /tmp/build/perf/plugin_sched_switch.o
> make[3]: *** No rule to make target 'kernelversion'.  Stop.
>  CC      /tmp/build/perf/plugin_function.o
>  LD      /tmp/build/perf/fd/libapi-in.o
>  CC      /tmp/build/perf/event-plugin.o
>  GEN     /tmp/build/perf/libbpf/bpf_helper_defs.h
>  CC      /tmp/build/perf/plugin_futex.o
>  CC      /tmp/build/perf/plugin_xen.o
>  CC      /tmp/build/perf/plugin_scsi.o
>  CC      /tmp/build/perf/evlist.o
>  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf.h
>  LD      /tmp/build/perf/plugin_jbd2-in.o
>  CC      /tmp/build/perf/plugin_cfg80211.o
>  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf.h
>  LD      /tmp/build/perf/plugin_hrtimer-in.o
>  LD      /tmp/build/perf/fs/libapi-in.o
>  LD      /tmp/build/perf/plugin_kmem-in.o
>  CC      /tmp/build/perf/plugin_tlb.o
>  LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
>  CC      /tmp/build/perf/mmap.o
>  CC      /tmp/build/perf/zalloc.o
>  LINK    /tmp/build/perf/plugin_jbd2.so
>  LINK    /tmp/build/perf/plugin_hrtimer.so
>  INSTALL /tmp/build/perf/libbpf/include/bpf/btf.h
>  CC      /tmp/build/perf/xyarray.o
>  CC      /tmp/build/perf/trace-seq.o
>  LD      /tmp/build/perf/plugin_mac80211-in.o
>  LD      /tmp/build/perf/libapi-in.o
>  LD      /tmp/build/perf/plugin_kvm-in.o
>  CC      /tmp/build/perf/parse-filter.o
>  CC      /tmp/build/perf/parse-utils.o
>  LD      /tmp/build/perf/plugin_sched_switch-in.o
>  CC      /tmp/build/perf/kbuffer-parse.o
>  CC      /tmp/build/perf/tep_strerror.o
>  HOSTLD  /tmp/build/perf/pmu-events/jevents-in.o
>  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_common.h
>  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_legacy.h
>  CC      /tmp/build/perf/event-parse-api.o
>  INSTALL /tmp/build/perf/libbpf/include/bpf/xsk.h
>  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helpers.h
>  AR      /tmp/build/perf/libapi.a
>  LD      /tmp/build/perf/plugin_function-in.o
>  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_tracing.h
>  LINK    /tmp/build/perf/plugin_kmem.so
>  LINK    /tmp/build/perf/plugin_mac80211.so
>  LINK    /tmp/build/perf/plugin_kvm.so
>  LD      /tmp/build/perf/plugin_xen-in.o
>  LINK    /tmp/build/perf/plugin_sched_switch.so
>  LD      /tmp/build/perf/plugin_cfg80211-in.o
>  CC      /tmp/build/perf/lib.o
>  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_endian.h
>  LD      /tmp/build/perf/plugin_futex-in.o
>  LD      /tmp/build/perf/plugin_scsi-in.o
>  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_core_read.h
>  LINK    /tmp/build/perf/pmu-events/jevents
>  LD      /tmp/build/perf/plugin_tlb-in.o
>  LINK    /tmp/build/perf/plugin_function.so
>  LINK    /tmp/build/perf/plugin_xen.so
>  INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
>  LINK    /tmp/build/perf/plugin_cfg80211.so
>  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
>  LINK    /tmp/build/perf/plugin_futex.so
>  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h
>  LINK    /tmp/build/perf/plugin_scsi.so
>  LD      /tmp/build/perf/jvmti/jvmti-in.o
>  LINK    /tmp/build/perf/plugin_tlb.so
>  MKDIR   /tmp/build/perf/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/libbpf/staticobjs/
>  LD      /tmp/build/perf/libsubcmd-in.o
>  MKDIR   /tmp/build/perf/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/libbpf/staticobjs/
>  CC      /tmp/build/perf/libbpf/staticobjs/xsk.o
>  CC      /tmp/build/perf/libbpf/staticobjs/libbpf.o
>  LINK    /tmp/build/perf/libperf-jvmti.so
>  CC      /tmp/build/perf/libbpf/staticobjs/bpf.o
>  CC      /tmp/build/perf/libbpf/staticobjs/nlattr.o
>  CC      /tmp/build/perf/libbpf/staticobjs/btf.o
>  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_errno.o
>  CC      /tmp/build/perf/libbpf/staticobjs/hashmap.o
>  CC      /tmp/build/perf/libbpf/staticobjs/str_error.o
>  CC      /tmp/build/perf/libbpf/staticobjs/netlink.o
>  CC      /tmp/build/perf/libbpf/staticobjs/btf_dump.o
>  CC      /tmp/build/perf/libbpf/staticobjs/bpf_prog_linfo.o
>  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_probes.o
>  CC      /tmp/build/perf/libbpf/staticobjs/ringbuf.o
>  CC      /tmp/build/perf/libbpf/staticobjs/strset.o
>  GEN     /tmp/build/perf/libtraceevent-dynamic-list
>  CC      /tmp/build/perf/libbpf/staticobjs/linker.o
>  CC      /tmp/build/perf/libbpf/staticobjs/gen_loader.o
>  CC      /tmp/build/perf/libbpf/staticobjs/relo_core.o
>  AR      /tmp/build/perf/libsubcmd.a
>  LD      /tmp/build/perf/libtraceevent-in.o
>  GEN     /tmp/build/perf/pmu-events/pmu-events.c
>  LINK    /tmp/build/perf/libtraceevent.a
>  LD      /tmp/build/perf/libperf-in.o
>  AR      /tmp/build/perf/libperf.a
>  GEN     /tmp/build/perf/python/perf.so
>  CC      /tmp/build/perf/pmu-events/pmu-events.o
> 
> Auto-detecting system features:
> ...                        libbfd: [ on  ]
> ...        disassembler-four-args: [ on  ]
> ...                          zlib: [ on  ]
> ...                        libcap: [ on  ]
> ...               clang-bpf-co-re: [ on  ]
> 
> 
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/hashmap.h
>  GEN     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/bpf_helper_defs.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/libbpf.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/btf.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/libbpf_common.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/libbpf_legacy.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/xsk.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_helpers.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_tracing.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_endian.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_core_read.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/skel_internal.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/libbpf_version.h
>  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_helper_defs.h
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf_dump.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/nlattr.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/ringbuf.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_errno.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/str_error.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/netlink.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/strset.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_probes.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/xsk.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/hashmap.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/linker.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/gen_loader.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/relo_core.o
>  LD      /tmp/build/perf/pmu-events/pmu-events-in.o
>  LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
>  LINK    /tmp/build/perf/libbpf/libbpf.a
>  LD      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf-in.o
>  LINK    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/libbpf.a
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/common.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/main.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/json_writer.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/gen.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/xlated_dumper.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf_dumper.o
>  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/disasm.o
>  LINK    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/bpftool
>  GEN     /tmp/build/perf/util/bpf_skel/vmlinux.h
>  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
>  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
>  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
>  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
>  GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
>  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> libbpf: elf: skipping unrecognized data section(7) .eh_frame
> libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
> libbpf: map 'prev_readings': unexpected def kind var.
> Error: failed to open BPF object file: Invalid argument
> make[2]: *** [Makefile.perf:1076: /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h] Error 255
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/git/perf-5.16.0-rc3/tools/perf'
> + exit 1
> [perfbuilder@five 32]$

Cc Andrii. 

Could you please try the fix below? 

If it doesn't work, could you please dump btf for debugging?

  bpftool btf dump file /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o

Thanks,
Song




diff --git i/tools/perf/util/bpf_skel/bperf_follower.bpf.c w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
index 4a6acfde14937..bd191c9bc49bc 100644
--- i/tools/perf/util/bpf_skel/bperf_follower.bpf.c
+++ w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
@@ -6,8 +6,19 @@
 #include "bperf.h"
 #include "bperf_u.h"

-reading_map diff_readings SEC(".maps");
-reading_map accum_readings SEC(".maps");
+struct {
+       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+       __uint(key_size, sizeof(__u32));
+       __uint(value_size, sizeof(struct bpf_perf_event_value));
+       __uint(max_entries, 1);
+} diff_readings SEC(".maps");
+
+struct {
+       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+       __uint(key_size, sizeof(__u32));
+       __uint(value_size, sizeof(struct bpf_perf_event_value));
+       __uint(max_entries, 1);
+} accum_readings SEC(".maps");

 struct {
        __uint(type, BPF_MAP_TYPE_HASH);
diff --git i/tools/perf/util/bpf_skel/bperf_leader.bpf.c w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
index 40d962b058634..d52a335e63f0f 100644
--- i/tools/perf/util/bpf_skel/bperf_leader.bpf.c
+++ w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
@@ -12,8 +12,19 @@ struct {
        __uint(map_flags, BPF_F_PRESERVE_ELEMS);
 } events SEC(".maps");

-reading_map prev_readings SEC(".maps");
-reading_map diff_readings SEC(".maps");
+struct {
+       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+       __uint(key_size, sizeof(__u32));
+       __uint(value_size, sizeof(struct bpf_perf_event_value));
+       __uint(max_entries, 1);
+} prev_readings SEC(".maps");
+
+struct {
+       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+       __uint(key_size, sizeof(__u32));
+       __uint(value_size, sizeof(struct bpf_perf_event_value));
+       __uint(max_entries, 1);
+} diff_readings SEC(".maps");

 SEC("raw_tp/sched_switch")
 int BPF_PROG(on_switch)


