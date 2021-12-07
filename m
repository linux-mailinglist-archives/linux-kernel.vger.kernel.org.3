Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0567546AF89
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378904AbhLGBJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:09:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3018 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244276AbhLGBJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:09:16 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B70fjr5032653
        for <linux-kernel@vger.kernel.org>; Mon, 6 Dec 2021 17:05:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=vZMgXRT8SOBZpiQJiV5vAL1guD/aW4zAZxKJhDh90sU=;
 b=Na4uhuz9vHQZQHsppOO259WKxNgCkOroA2sEN41GWF7MnlKUUg6gOlmxHzJ7wLQcSfb/
 PUL7aDWOykJyNMEIdg0cCWLH4+2PjlCVdYLwWq4ZDSO4wa2YOpietuzf7jEXVbGOZz83
 3a7qs+2ioFU98K8Vu8Gom8Nv0TpGjAKHsLU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3csb8kpxa2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 17:05:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 17:05:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zuuqbz3HxDl1R7CwSygx5uZyeoLankMpa0xQ6LZE3kepWUksEqLaFVbW2sOFExHyC0AaQpURGVsDDZjH1IUaK1PUM6FtLvt/jRUl87uLSYGy4ulXqdNti8aACCIaZn87oWDCWVOeV9SGXev8kxXCkX9mhGmDzbzNJu1h+6OtOrjjgHzgC12UE0a/u/tH80HaIGcPr4xoZpXjrEOKOcMzGB9r1UJR5YrZr1A/eMyoPCEK5pqpd5pAj4V4Wv9TITSuoa42knTidB4a5XgsQpXkqMMqEdcwo3vEwX99Z4HJN7o5veRDoLoMN3vJQOTHuNLNPLMrzaq2hPV7Xv8yZ/WfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZMgXRT8SOBZpiQJiV5vAL1guD/aW4zAZxKJhDh90sU=;
 b=lGtzJcg/uBce++Q72xe44zzpr+BImgEtziVmHrO4g6Y6q65ZBEsJx56qSSwEO/0xbv3u/iPFuxNGrQKNA1XOf45ccmunyGKnpzj4QSTwRK7LqZq5kqc39U19BrhJ03DtekOGiwtXmoY5pXFMrzBpG59Lo/cAIfdJiohWn6SRo8acgdjs+AWCfdt1mzwAXvI400H2Yz90jRyxjq9pDee893pylxCbgiSipHnngXKTXnCM3+KB1RPBL1/oZKK1+YGgQ2z8AlEM9Ei9c6WUCn0C/LoNfLpBwSUrDqcGxcjS8JiWNth2W9IVklj/0JJGYJK6y8O5jLV+kadF89JEj26lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5062.namprd15.prod.outlook.com (2603:10b6:806:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 01:05:43 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 01:05:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 4/5] perf ftrace: Add -b/--use-bpf option for latency
 subcommand
Thread-Topic: [PATCH 4/5] perf ftrace: Add -b/--use-bpf option for latency
 subcommand
Thread-Index: AQHX5Xd4zjS6VUDI/kCZOLGKxbDvDawmQi0A
Date:   Tue, 7 Dec 2021 01:05:43 +0000
Message-ID: <738F7D58-264D-48A2-9A83-E7D126A50471@fb.com>
References: <20211129231830.1117781-1-namhyung@kernel.org>
 <20211129231830.1117781-5-namhyung@kernel.org>
In-Reply-To: <20211129231830.1117781-5-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceb22afd-7127-4daf-b4dc-08d9b91db1a6
x-ms-traffictypediagnostic: SA1PR15MB5062:EE_
x-microsoft-antispam-prvs: <SA1PR15MB50625E6017F3FAC22537B0C9B36E9@SA1PR15MB5062.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dYSnB3VQzYEnW/hJ3J6uhKfDr654aUDzCJKegt33LWhv+dlz/kQ9sO84wrkXHKTVqB1T44P86nPDxfmNmx/obqW+MiGzB7C41J9xVzOY/YQJ6CRG/H/BXhhrTOV9ylb8qOuHUzowR7Zd7Fw+zA+aFkfl6PheLkMpdzsjQCRADBrorEkobTcuqcxen1mUQwOzPCE293UAgUka+xf4hg6zxM9C2XK0a6piUxmWQZ1gI2MezK9tgbBe5s8ASLJtAmMJcD+DBNt2aCHJCaroLYPpxFNc/JdbBLoGCXsOeSTzNU50upM9piMubT0X2DfWMV1Y2MI/5OXtxKy6VvpEhIAYgylSFY8d2FrxgBEBASr3aayKp9gxyR9A9TG9edxd6JmUnxX1FqIeZ36ArN/+GKR3MxkR5VKbOXV9AfhXQLc1PJZdDBg8L8GwhlKq6lltQUNQ/zCrRLx+W++H3YHS6o96FPWc8RGusASigYKktkNFVZZpiHGpy7k0EcpWcfzCYB9ptsigXmN9c/2uHHD+CIsYKGfqigzedHKvueHZAjaGfPoiMQ+MIvn8oupt9lVE5vvn1wajHthxy95OGHIfz4N5TGyO5bS7vOdn8/TZsrhhFblCGF5wKlbd9I7N6uMWLTuvaejgwtc9a/bu64ttEgpEYOKc7SvFtV0oR9+uUWe+esCDhs0iDfiWJe5TgUYRSnwlyn+o+wN7k1gwNFqKTHG60KcWr9g8u9hdZ9io47vYRQfoPbmg00fbZBrk8nRXduHv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(71200400001)(6916009)(66446008)(66556008)(2906002)(64756008)(7416002)(66946007)(6512007)(38070700005)(6486002)(8936002)(36756003)(66476007)(86362001)(8676002)(2616005)(76116006)(5660300002)(122000001)(6506007)(83380400001)(33656002)(4326008)(54906003)(53546011)(508600001)(186003)(38100700002)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GUeHXXstFeFg/cN8sqMgMobXmDmlwJlnzNPJOBqu6rIYyblm3vKBItZ0LeHi?=
 =?us-ascii?Q?ZSfWkRTRwk14Ok/nXSLXsHLOBdOOBjrGEiU9WZ30ayaPySqFAtq9lB1At7C/?=
 =?us-ascii?Q?Eq0cXIFQkNHvjUhaWE1vuFe/UZzs8zwQsp0Pd9byMCLchdmdSMnQUbb+gbx6?=
 =?us-ascii?Q?Tc3r/K87ZJKYc/bjKltQSzfoC1Dib1223+9Yw4G6lz0DOgPSbQYgHgn3HC5h?=
 =?us-ascii?Q?HZy/pStxGN6Ofp8A4PbhugKcNHQdMjp1nfMIf/sj9Ff8X5bycLl1AoAZmhdn?=
 =?us-ascii?Q?/q0E1kNjMLpBHLRnlJOkWxzPEK5AvnvuWucQ+U8D5QG3ciEG5LiLydFEj3F7?=
 =?us-ascii?Q?XhlnUvz95pOsiX2XJExJT8I0WpUSgtSEe3O+pumemQv26TE7dQuz0D2mzuUY?=
 =?us-ascii?Q?tA885gL2hLx619o5BoRENa+GXli7BUDv/wHLg6151cidtTVxiay/cFxXOhaa?=
 =?us-ascii?Q?ctGYQ0HHK629cDGA/96+haR9SZ2jEC1hu3mSk3D3fYLVPSE8AstvXTlEbuou?=
 =?us-ascii?Q?pHbuOvhQ5wzXpHQ8gz2ZjKTqsnI88KhfuVuFjKOF91KIlpfKk6cAjPiZkJKU?=
 =?us-ascii?Q?o43IDooHwLHpX12F5BFnSQvYskDEyI+84345RG1TstZ6zsOYg465+BwdtSZk?=
 =?us-ascii?Q?/3mxff+tlVtBqNvFJ48Q7TQcjHdcTAINLgo0PkOnQywK/qdVA4TIa0NJlwQv?=
 =?us-ascii?Q?BOt7pShxFaL0XGm/s+kQbxOL/BEPppUqTI1OwLWQNZLUS8x0LK4N/v+L2nOo?=
 =?us-ascii?Q?b/GD8MVsbzrI2J9AndspaWXxF40th/faOCzR7MqHZI77f9/J7FRILKhzyf1Y?=
 =?us-ascii?Q?kzMEjoN19NBitcwedwZwJnHDc9X3MB3CbeYiZekuiFfx5VSdPDiLa+jI/ynR?=
 =?us-ascii?Q?upz9w2MsukBltMjpVapSVHMb2P4XENcRHu3PnsoSVmDTzkjyMpGAuVev+VSO?=
 =?us-ascii?Q?5IN5XwDq/lV5FieyGSmf3XrDX4O3RItXBxA+lUvX2qlRVsXH2WziqyPcZ/lK?=
 =?us-ascii?Q?SJpc+iuiqv0L8BzIw3LAGNwSsYolLOzmQQ9Oduycp66xamx7vvGGist+61ku?=
 =?us-ascii?Q?2AkB7pqeeMwz8J5WZGmrYhKdPrUNgCXFcltvYD9eu6zlL0cyi9wiCSF6J92L?=
 =?us-ascii?Q?hpqISFk9oYGrv48BdEgfm6Hnju/D7SMdYqyXsIYubIx1n7Ab1bTyQg/PvS8k?=
 =?us-ascii?Q?5fBqtCdd/vCvYi8gydqBDm5YwKF81itHdChUtrmfAf40X0qL6Kf4i05Qnb7D?=
 =?us-ascii?Q?fOEVTXDrgQiySBv3NaUAgCn/+R8F4071AAAqi4Iulw062cfyXpuQRf0Rlkx9?=
 =?us-ascii?Q?ShjF0g4K/279tfBjzSJgy3wvTzcP2y8x6WlpY8ywYwmLo13utZcQODsEx9PY?=
 =?us-ascii?Q?G+LDWzYmi9M8nh6pooCQlGmT6xab4gF31au/4HqPhcwGTKX0fB3ofJw8R031?=
 =?us-ascii?Q?VhRUyACbUwo7CoioPIaA3eImrs5vcnAOWCwHME0jHsxCnYKbcn8FRvU8PVEN?=
 =?us-ascii?Q?m3TYxUB0Wqjbv5jkrrHnFLjo7OzTUC0KcBHzizVxJibhS0Rn1zBCtfEXDiGI?=
 =?us-ascii?Q?USmIM6uN8H6UC+U4eTPlkTEVS8/avqNuOxrgeXz4yyfaK0K3GX5ymTQ3G3tX?=
 =?us-ascii?Q?k18qEOsfn0JlS1Q0AYUDLkxtPS+1/IUHgyXWCzyBSCLsDvTdLlFh3j43yCn3?=
 =?us-ascii?Q?6/oEog=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BC096F4495C5F4199681E68FAFF24E8@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb22afd-7127-4daf-b4dc-08d9b91db1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 01:05:43.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEo74X7JI4b5rohlkHVdmCOHknaTfQ4IXRsNKNqnsPDdvgssnOxAiZL7SvCH4C3MJ55H9HV9Ir5Lpf1qtMmSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5062
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: GCrgMNK7H6U8mToPUXLQgl7niMeUsgGr
X-Proofpoint-GUID: GCrgMNK7H6U8mToPUXLQgl7niMeUsgGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_08,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2021, at 3:18 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> The -b/--use-bpf option is to use BPF to get latency info of kernel
> functions.  It'd have better performance impact and I observed that
> latency of same function is smaller than before when using BPF.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

We can actually get something similar with a bpftrace one-liner, like:

bpftrace -e 'kprobe:mutex_lock { @start[tid] = nsecs; } kretprobe:mutex_lock /@start[tid] != 0/ { @delay = hist(nsecs - @start[tid]); delete(@start[tid]); } END {clear(@start); }'
Attaching 3 probes...
^C

@delay:
[256, 512)       1553006 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)          89171 |@@                                                  |
[1K, 2K)           37522 |@                                                   |
[2K, 4K)            3308 |                                                    |
[4K, 8K)             415 |                                                    |
[8K, 16K)             38 |                                                    |
[16K, 32K)            47 |                                                    |
[32K, 64K)             2 |                                                    |
[64K, 128K)            0 |                                                    |
[128K, 256K)           0 |                                                    |
[256K, 512K)           0 |                                                    |
[512K, 1M)             0 |                                                    |
[1M, 2M)               0 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               1 |                                                    |


So I am not quite sure whether we need this for systems with BPF features. 

Other than this, a few comments and nitpicks below. 

> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 2e5bfbb69960..294b12430d73 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -144,6 +144,7 @@ perf-$(CONFIG_LIBBPF) += bpf-loader.o
> perf-$(CONFIG_LIBBPF) += bpf_map.o
> perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
> perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
> +perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
> perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
> perf-$(CONFIG_LIBELF) += symbol-elf.o
> perf-$(CONFIG_LIBELF) += probe-file.o
> diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
> new file mode 100644
> index 000000000000..1975a6fe73c9
> --- /dev/null
> +++ b/tools/perf/util/bpf_ftrace.c
> @@ -0,0 +1,113 @@
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +
> +#include <linux/err.h>
> +
> +#include "util/ftrace.h"
> +#include "util/debug.h"
> +#include "util/bpf_counter.h"
> +
> +#include "util/bpf_skel/func_latency.skel.h"
> +
> +static struct func_latency_bpf *skel;
> +
> +int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
> +{
> +	int fd, err;
> +	struct filter_entry *func;
> +	struct bpf_link *begin_link, *end_link;
> +
> +	if (!list_is_singular(&ftrace->filters)) {
> +		pr_err("ERROR: %s target function(s).\n",
> +		       list_empty(&ftrace->filters) ? "No" : "Too many");
> +		return -1;
> +	}
> +
> +	func = list_first_entry(&ftrace->filters, struct filter_entry, list);
> +
> +	skel = func_latency_bpf__open();
> +	if (!skel) {
> +		pr_err("Failed to open func latency skeleton\n");
> +		return -1;
> +	}
> +
> +	set_max_rlimit();
> +
> +	err = func_latency_bpf__load(skel);

We can do func_latency_bpf__open_and_load() to save a few lines. 

> +	if (err) {
> +		pr_err("Failed to load func latency skeleton\n");
> +		goto out;
> +	}
> +
> +	begin_link = bpf_program__attach_kprobe(skel->progs.func_begin,
> +						 false, func->name);
> +	if (IS_ERR(begin_link)) {
> +		pr_err("Failed to attach fentry program\n");
> +		err = PTR_ERR(begin_link);
> +		goto out;
> +	}
> +
> +	end_link = bpf_program__attach_kprobe(skel->progs.func_end,
> +					      true, func->name);
> +	if (IS_ERR(end_link)) {
> +		pr_err("Failed to attach fexit program\n");
> +		err = PTR_ERR(end_link);
> +		bpf_link__destroy(begin_link);
> +		goto out;
> +	}

I think we are leaking begin_link and end_link here? (They will be released
on perf termination, but we are not freeing them in the code). 

[...]

> diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
> new file mode 100644
> index 000000000000..d7d31cfeabf8
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +// Copyright (c) 2021 Google
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#define NUM_BUCKET  22

We define NUM_BUCKET twice, which might cause issue when we change it. 
Maybe just use bpf_map__set_max_entries() in user space?

[...]

