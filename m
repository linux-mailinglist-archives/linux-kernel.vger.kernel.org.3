Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39D467E63
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbhLCToW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:44:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14098 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235412AbhLCToV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:44:21 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3HlYCt013705;
        Fri, 3 Dec 2021 11:40:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=O0BtJNUkQnlXuOTBNyjf9ISSNjvugmvwyDAwSTOF77c=;
 b=GPl0CDx1VJGflAA0UqKGqF6a94yzab1LkxbiaxvlS0ciECUg6Z8KBRmG6LFrHWZp3Ffq
 lqV2l/Lkhuxzu2UQ4X7bkNaWeofRj87Yo1u1rkhtyyzCLVfF2rONtFT18THDxEJ4K0Xc
 WynYrJ/XLp0u4/5iDjAE18LZDgN6ADHTKss= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cqck4dbcy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Dec 2021 11:40:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 11:40:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DODcQ9wNNjzpTdNgzZaVDE8xSXwxSWhN5xP9uepKJRaoFG6Zt+RjcDiZeuUOhq7znntud00VGaU7j73bPL+QV8qkJ+7ZdlQ2qrbhAKljjpam5hQHB9PeI5xR9LKec/HohgOzFAhMK7J99BZ7HAgrR/8hklN8rDVoZFF6BkumrCj2ns68WF27/oxhRs056fZmxFvhPkIuN2tbl9xkyCtwwyDuhauEkOQgAHkPwyYGQLLnf1iPFS3/3T1nKoabF3lnREYCI8Fs+YJFkmKAP2V0B+4dkrKs8gyIOTDliCTm1uotODARLsU99pmSC81f2AJBUzK9gUMCw77jz2AT2Z56fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0BtJNUkQnlXuOTBNyjf9ISSNjvugmvwyDAwSTOF77c=;
 b=L9nc5B9+ldQmEgXRTVmtIcHFG39KDINCWaRMDPpsUg4bmjLAiEbKBtiZnUzbNlF56du4xnhAbYiEDe8rRnRS20iwVgt+6/Y48QM0j5uvPHm70YH/iQN4Mitrs+sZIJe/yR7TFhm6y2XameM0yGw+YxHiHTbHr6z/HPyIhET4CyDHbB+EoYP63ORzZS/a3T90JcPqED8LwHPHWGpSnnOjseZx16XKwv6b0lp0gZW1FQg52dZMger82odg64GGPVqLVteAWYmeAckubtc2jgcDG3N0uELzx4v03VKo9ukmZ9qRjeqJ+pDWJTcq8P1zXgRE1T87/8FwtAZzh5bplKzV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5094.namprd15.prod.outlook.com (2603:10b6:806:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 19:40:54 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%5]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 19:40:54 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Topic: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Index: AQHX6EczClIG2E5d9UOz/2n0HlwT/KwgwqAAgAAPowCAAFiNAA==
Date:   Fri, 3 Dec 2021 19:40:54 +0000
Message-ID: <6FF18625-7CD7-43C4-9B3C-43287B2BB7F2@fb.com>
References: <YaoXUrLUZt1scVb0@kernel.org> <YaobYKgrTV1Bthi0@kernel.org>
 <YaoofidHLBsuBdWV@kernel.org>
In-Reply-To: <YaoofidHLBsuBdWV@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c00d1135-d1f6-4a32-1bfd-08d9b694d23a
x-ms-traffictypediagnostic: SA1PR15MB5094:
x-microsoft-antispam-prvs: <SA1PR15MB50949C376B4568E4D1E49156B36A9@SA1PR15MB5094.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FcKFbt4pyo0W3XVg2hpFcLoH+GXWRG09mQxR4wxU1CQQ/vKX9fKYa/2d0SvdM1oloAWy94oKNoHchAEE6yl/kO3elyjw/ZRJJ1Vq8UACtiGGoaZDLiri+XyVyF0ZtQTVDh4bBKVOK1zrv7rBs944/o5zjdSZz8JnXn5rCwcsWkW49O+NJ0cXJI42HcuUHJTLbWuqP05Ctwrw9y8SQQAFqCQoxnIy/flWxs4oj+xmxJKzSyF/pf8r1EkbYdfXPe+QzA/QEUYZPNbgo4g6dKdOPkYEHojJLl5ufduce9sSzGSsFyfOCoAbDr8zlC0sMHTD8Zb3snEYcMK/00vO/MwhF86ByiFtAv/eOeour6c1HZFsnF1ADa7MUn907K7y9Re0wfhvBkJ7e2pp4TCuoxhYt9QEl+kIZz2uxIAWOdBt4Y4s+p9AADhI0OwFMuEMjlwMh0lhusJDv4UeWKjbVh8/0mvzm6lWXrWLtAPlh+2i/nuTCSELKMIIxqyM9ux5pjrMyUWksFc4Z96p8cUlQGKtGYanS572p34NMz7uX4fzw1/Nq5mxVFIPUHvAJBvsv+RRx9CaK73HNDlfVTiUp99BmyfH49uEKHHWZbHHPEqBW6NITsWyyriE7zR6JfpquzD3uin5JHTfqbVXbj1S4wPBdhl9xhklLKGzT/TiERZKOqstN6c/b7pF0S9ikbXnF1LpaxVMbKcJyQFozAlhsmMWvPzf2c+ZcgTXk7qSQNTbMtMFcMONV7ioW1uBLQ08l8yW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(2616005)(66446008)(38100700002)(6512007)(33656002)(6916009)(66476007)(91956017)(66556008)(6486002)(66946007)(122000001)(64756008)(76116006)(36756003)(54906003)(186003)(316002)(2906002)(4326008)(508600001)(8936002)(38070700005)(5660300002)(53546011)(6506007)(8676002)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rwm6nTMLOYoLy7cKBQgaynKnaaUUtYsCYvTPFS4A+0as3e6N+p3fyTe/kXPn?=
 =?us-ascii?Q?MmteKKoGpiBy8FZvENeGsjbXNddCYoxd+nmZKk924lOIUt6WxEPGGCCBDXuI?=
 =?us-ascii?Q?rwr2Solb03c0SEBjO1v68peSJnpGtGvP+31nY6DGMkUoW0dlIMZ8JBUWki1p?=
 =?us-ascii?Q?09yvQqQglR7ar/Vi504snN323tnUQ7yLo/zR7Y7H9oIhb9NzxhezaCXd3u7h?=
 =?us-ascii?Q?e62OYob18SUORsdSshmR4k0wHllNQIxQyMAKoGwMU+CERzwbI+R79wl1leZZ?=
 =?us-ascii?Q?5fJQ/mB0Nre6YCy/f2lw3GRNdEDyFw21bU0vxB6+bdcMXTepjAxr4HGdS26h?=
 =?us-ascii?Q?EufMafOlyOxvaa1mRjfFGpMn8ZbmSpEHrd1s76ZuOwnOBFWp4M5wf2xXwsOR?=
 =?us-ascii?Q?toJuc4RPHTD/30oSuC9bHYB452Yb9+sBOhM9rJA6m3bwTok6omoCDFS9bteq?=
 =?us-ascii?Q?bJiezgZkyiPv1aW4Tfp4OHvxBbLGy2F2jeXDjXQZ2Us3yjYl4uiLiF6Ei96B?=
 =?us-ascii?Q?Zo5MNqAMtBaq8s3CenQ0OnBQI0O4qkZwxvqTsdD96tLXKoQCZcsYYaY1XIU2?=
 =?us-ascii?Q?FE+o9I32UnicH9bdtU5QWFx+CIeBypr+lo8PGce9sKwfxSt0JcGbsdEdRrSb?=
 =?us-ascii?Q?gFWSTBK/FRUnzil8LKkXJ93CYaUJ+gIXV3NEQW9E3UrcNMCVqH08EseEAp+8?=
 =?us-ascii?Q?MNDxXxy9VvgJ1+MjUkIrb4O23BKjgqfzCNVMGiuqrjuuPjGHjxBBvYrxYqj4?=
 =?us-ascii?Q?9uY1waqvz2FXbPGz4jbC1nfVXx4KBv7ftAXUC7Sj+SrPqfoIiQvcXCM7ceYf?=
 =?us-ascii?Q?Mr1ukxOndmA+rbFGNCQj6g45E3cZzCg9pPG1vijcAMeb1w2KCaGbbGvOlvet?=
 =?us-ascii?Q?VDwT4InksIBKkqcgdD8jiazU0lWqjNcdhBGujQwDgZlqbCxUOziba3aMwV58?=
 =?us-ascii?Q?JaN4o28y27KpQVPh3fG3wWfMf3CZZY8HSObUfIpdCnnXiR1tq8Q7ka9W4qxZ?=
 =?us-ascii?Q?99L+W3Zw9QBN9Xl+xwt1SB9Yb89TY1TmvwrntcA/FaKKrRR2+CMtF2o4k/C5?=
 =?us-ascii?Q?8kP8yvueuleMiJtdHyqlZ2mOEkKqeKTrUuWh4DeCL6UhZ+d4D+F0f3k+NocA?=
 =?us-ascii?Q?fydeZNti1YIYDbtLwZeAeFsISCuWWRCyoNfNwBPt1W3Uspg+1bQyGI8vYzXa?=
 =?us-ascii?Q?H8z5AcpE4LEOwiXfTRTmQkugRMsjZWk+m9ty9iq2io4iJZ4SKqi1sxH1aYTQ?=
 =?us-ascii?Q?mgFtozRoaDNj12pp80c5phgBDaQyy5onH0O+2yqWZ80QiMKs7pqfa2PkoTeW?=
 =?us-ascii?Q?wZJDGeK7XWNcGJfYFD+jDT6CsFILueqFLc+hDUaYDhMA66YjthEMxmqOq0Hi?=
 =?us-ascii?Q?kFcPG/1hjMmpw9SkBGEBQmpn07xiIhprbgD8kI7HpPJvEWnH6GOIR/YXwbfc?=
 =?us-ascii?Q?nQ/d/tEpCrYXSz6sfaYDXMO/9uax1GuVn2U86wY32ippEbMDtx1xsDm2xIEO?=
 =?us-ascii?Q?iWZzrVEBbf+EsT5XUQwptUlNqiLzv3r+309rlyFNMkXN5b+AY/JgbkX+7tzf?=
 =?us-ascii?Q?Tw+abE1UzIzYmgaFyYmDBlGKAvwxlVyRGa0hS/HXv8Y1lRDUNoOocMwAO+Un?=
 =?us-ascii?Q?RuEvWNaD5mAV4HS/3qa+oJPCZ+D+UEdM9wZ7GGKFTPg6aX5SRqfWJ4Xzvq+Q?=
 =?us-ascii?Q?7xvYIQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8D33EB020D20141A4E7D735CABB464A@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00d1135-d1f6-4a32-1bfd-08d9b694d23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 19:40:54.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63VJbagurwBkzx2h0CV2hC/P3PCLRsQu5UcVKeBhdYt14euJgG05teEpy7/pmcbXNaSnkPNkpVKt4+USMi2eeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5094
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 8-qTPiq-6pmxW8LfW5LC6e9xapNg0LVg
X-Proofpoint-GUID: 8-qTPiq-6pmxW8LfW5LC6e9xapNg0LVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 3, 2021, at 6:23 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> Em Fri, Dec 03, 2021 at 10:28:00AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Dec 03, 2021 at 10:10:42AM -0300, Arnaldo Carvalho de Melo escreve

[...]

>  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
>  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
> util/bpf_skel/bpf_prog_profiler.bpf.c:18:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
>        __uint(value_size, sizeof(struct bpf_perf_event_value));
>                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/build/perf/libbpf/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
> #define __uint(name, val) int (*name)[val]
>                                      ^~~
> /tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
> struct bpf_perf_event_value;
>       ^
> util/bpf_skel/bpf_prog_profiler.bpf.c:26:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
>        __uint(value_size, sizeof(struct bpf_perf_event_value));
>                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I guess the vmlinux.h fix should also resolve this one?

Thanks,
Song



