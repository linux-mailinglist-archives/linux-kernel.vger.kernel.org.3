Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96A84C4E51
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiBYTJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiBYTJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:09:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE03B1DF841
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:09:23 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PIiWQJ027396;
        Fri, 25 Feb 2022 19:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f6ChPLqcyIhfDUXpSConoAaJZtcuXZvNZeXe3uJTC3I=;
 b=F1mP6oPCELYdD504cylGoMofIAwSYWAOomjyx7sjPhCzXmFt0vlNvgZviavZFiD8py5c
 6H10E+nxMu7ecLDUKKlhBJKInQcEwFx8l5pHBIWYxfuYa4IcSDl3t3MTICCxqiZ6h9vr
 dgNBu5Brh/60Z07+yvQpNjSWukR3UbV1uum5wV19Gi48Y7aV5klwxJkwykIADX54utLY
 XbDxFZ/WxDdIvIjoBXN8XZr3VPgVF11HuZlI+SsTBScEldQ2hYphU3xX8CQHYxEaTlB+
 s5zW0d9nQlTpqf7qFotZ39/2ZX3GRttV5cKVQ3LHCdPveiMZN7rg5onLjAJbay5JSxYy 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexj89v6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 19:08:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PJ5kUg150295;
        Fri, 25 Feb 2022 19:08:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 3eanp0km57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 19:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGAcADhEb50lorimUwjg4+CCAxEpOjr14SOLX5RYbeOAVhi5ZV7gSbB3cw/KiOrHW5f+78YW7cX8PTq0L3kJeU21JJfTjo09aGRmqiXWPU25RVhANhfx0f0dHPYZMzW5QfkkUeTsGj2vFoXB3bRQ3RBcDheQ4MH45jhdrO3KrgtNJyKUknm/5S0zIhTktm6sb73jA0vSMyEUIU//RbuA5dgkCorDXDOr24t/LWdnK+Jd7SoUaDE9hqEQkeEhJ9nixanpVLu6QMcrSIfhvf1T38bHRwgaL+gPjtLANaCHBRPwi7kA9lMlSHhoY2RX/bB+uXRorW1E58p4sQu+jAto1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6ChPLqcyIhfDUXpSConoAaJZtcuXZvNZeXe3uJTC3I=;
 b=nvL20LR3YlQFRT+w/7TWRPZ/87Tc1XnMTvw37QM+WNZymytXeJVR3xNoNaisca5emgnHxcA2+POzfiOY7o/jWmVQsZRnB4JNXh8kvzwaKO6Gw71CMxDJEjvZEKI7qA7BYKZMAOIoTVS2dNyfvPovH7Y8yuU/KuA7vpzXqQ5tdl7L2AOREfWQL/UzLypf10sL3v6SToG4Z7GaiMchyKa4m0KEEZn3j5Gh/4zddvIqSgDIYa4WiHa2eijQwaOi1l1FheZcDl/RSHEZtfKNJPPx2TXLNL+X3MLLITN13cCuWYBEJpca+OzzmsW/BoI25T1m3eH0HKZOc0BqbNPsSSmmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6ChPLqcyIhfDUXpSConoAaJZtcuXZvNZeXe3uJTC3I=;
 b=W6BbhXdWGd0NPZpb9GYYzY9oHmRodcu8PGBcqpL0PywtT05/THL/xlNAMsGGdc2Z1xEjYI8DZh3tE7Ux83yLI05m0TD6+WDl7cUZbml1jMZgbJRiiQScIpQscF+nS+Ln/OWMtBg5PMVYISgPZjm9B/kYrdvdlP1etyqbxI/IHEA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4111.namprd10.prod.outlook.com (2603:10b6:208:111::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 19:08:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 19:08:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Topic: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Index: AQHYInmXxzMTjmF25U+e/3QAVwcn6KyjsEsAgAEA+wA=
Date:   Fri, 25 Feb 2022 19:08:54 +0000
Message-ID: <20220225190846.u4fwebimd5ejfdpd@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <YhhRrBpXTFolUAKi@qian>
In-Reply-To: <YhhRrBpXTFolUAKi@qian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48dee574-d959-457c-b0fb-08d9f8924468
x-ms-traffictypediagnostic: MN2PR10MB4111:EE_
x-microsoft-antispam-prvs: <MN2PR10MB4111790B97162E0BE67FBD8FFD3E9@MN2PR10MB4111.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r0ORa1H40tjpLUrF377ORW7VINq1xE3NS9EoaB3ZB5y13xmtB+5wD27W1V7KBRJwzcVVkKNQPgnPZHZ3tS48eSeon/8TOOa5gtiOHWnPeT0FyOo2JHNOxdgg/RE7CT5UBj9+pB6/K0TWIiexKmC/m3Mh3jDn+/bntIYMN+RJcC1PEXwT7DrJxvNiQ8RVSapHuQkB3ueDoGPKnM9UL1SAiIPQwZEy83NLE1n7iglH4kTtd4Vps+7dI9veQ/6LVm5WVxxVrhG5FhATgScT7fKCHCRjsDUElDDnS0fRdVtljs5iY3rWWWjZEayXMh2tr283p0QwL6ZpvrDcuZgxcTBshOpflWJf8XHDnzV9LVxjAFUGhLOyO3jIfOhi7hjrcX8VFf7B9pJ1bSV1F9LZEJDyu+wapVqnjQ/nzolZWKMEtx/lG4WzxFrEpWtfMboM+Yxpu35q48m7TnUFsmThtp/dql/wP32f2HLyJ/BGf/rHLx09YOonYvbh4ePNu2omfLADEq9i6j+ILrK7+7wgd4akoNsNBhVkJf/lt0NdzsjDCXZlNtmGdno7AFef0wfewRAkfMQz1XfSfiJlAMuSY6jeiHHo048fbqGpfKJSDFeGFmvnfvT5PbcmumpyLpxxZIR9QJfKcItWh2bXCfEj8hjpntKAcKC9AeBh+muyEW2Q8Xz+5tsKSNGl3OADNdRrNZ3JjPwXK3UxsSf98gk2QQ5ZTYhUi3DPMCy0kpQSyTOiPhFxFcOZheX6Y1B9pjKLJVJQJ4aj1BL2LBSGoicA6YMxPCHGAEtz4poXeqKmwrnnfbk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(6506007)(54906003)(76116006)(8676002)(6916009)(316002)(38070700005)(64756008)(91956017)(71200400001)(66446008)(66476007)(66556008)(66946007)(186003)(26005)(5660300002)(33716001)(2906002)(86362001)(44832011)(966005)(6512007)(38100700002)(1076003)(9686003)(122000001)(83380400001)(508600001)(8936002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lvAT9mCVnW1RtUhT7xwVGJbZtP6mzF4VYXYJRVC9laUfvo5M4JnZwETkAMKt?=
 =?us-ascii?Q?OKAuWOdChPQ5CWE0/iwHdjS5wHExcu0TMlurPiX/YrQucAG9y1/JhR7svrwT?=
 =?us-ascii?Q?rwtmS1wuE3Cx+wH4C1NDlQWT5J/i6S5urFTMyQIe0bMNRm0mL4fVPw8yIK12?=
 =?us-ascii?Q?vwfU93bEYAHk+abPIdFiMwZ/SLtZx9FpOornt1zQyx7wJ3SsoDzNkhXfpoUI?=
 =?us-ascii?Q?8OdSUPGpH0922WJEMmZpneneGvDvTdEWySirXHFk/HHS/Z5K2tSGgoVkb5FW?=
 =?us-ascii?Q?pCJmsJifOOgM2T0PbJAOpCmQjPoX8+iNwXn3r08ybESlNaJJBBBMHYG0KAXq?=
 =?us-ascii?Q?xamr7qLMtmGaB0kmc7FSQgFGLBSYBcQaykig+OXItpYLnNY40L2uWbwa71JY?=
 =?us-ascii?Q?TaQX8QHJ3ma8ciEqi5sS18SyMlTkv1va3ENCynIVyLn2O5PsBjv52GXaDrwK?=
 =?us-ascii?Q?NQKD4FJm/IOU02+Gl2Vgym+t+oF3i6qVxlN7t0ytyxgoe2hjDE4cQaMFDKdC?=
 =?us-ascii?Q?fhpFYwrtAiIJlsJleueSugo0FCVLcPhw5QPfqWXK1PWVAiUYnjckPLd9mSrH?=
 =?us-ascii?Q?8rr/SFSluL3jIL45wCZa+Pa1Ux5MHkeli2+3194ZTsHuw/QvSA+drW9X/RP/?=
 =?us-ascii?Q?a0OpYMgopQnFy96GREP5D+5IfQXsI5wOiuNL5T8C4GimA5elSQRSai4aAJvY?=
 =?us-ascii?Q?Vfw1Mz0G7ET6doctLQVhvaHl0LsHAtdy68HU0ggKG2H006kXvhFU2tvEgwwc?=
 =?us-ascii?Q?jKUL3AZjgwKScb4lzcw2psPxlpMvPnr/30kz6BEtN7IlFnJ3e1x5uXqfFaEQ?=
 =?us-ascii?Q?RO/BXtJsiqA1tAvmYubevGWYm+84TIU3W4K2gbYzr7feSHn5LPEDqlrnN0N3?=
 =?us-ascii?Q?KkBgCs8NXZkRc129ptc/DgwAlRioQx7x+F0aC7IdMD4Rl32lDx4NHQqRajYK?=
 =?us-ascii?Q?H9Aumlzui1+6AxU4TsENSb0iQhh60GJYOWotwkHcW93F8Ow3lA2hIqZuLlx3?=
 =?us-ascii?Q?J76s9n9ftSig3VOkfXK60bUVV/fsetBTwD7EX2qbiU6eJUwSgKSXVcnBGBkH?=
 =?us-ascii?Q?VuUx4c/a5sW+z0jTqdu/5OadbcdnGfmKOSKyWHYSGa4X7YlQRkkCJtCPvShi?=
 =?us-ascii?Q?WVgxufbBh1D3aoPd7/3W9jqY5GB2Jy6wlLQ95SbcW21kU3JippzdOw1TZ5Yq?=
 =?us-ascii?Q?XtMjmizsQSFxG5PresFsy4/f6NW2c5PD8we4PApl1nW9yo12Ct1hQofkzdIo?=
 =?us-ascii?Q?iopLT78JFHpwKc5no40n8IqYZsZvQPIM8/NIwZT3O57Is9eKji5hPH1F56AS?=
 =?us-ascii?Q?OtKoFf+b9thzUKOAvj6y1RdAXe9PqN2O1Zy6z74I5ty1ezxOeObQLwCgrq1d?=
 =?us-ascii?Q?oeAyASLkxxDMMGHqQ65pHJqMnHAuPp7vfy98LORcjQzFV0I/hd9Ms/9YYYje?=
 =?us-ascii?Q?YPGpPNVm2I0EaPqCHXntPrlhmD+Cgdhd2buvtHlprt4Yl4CWEIjv53hvLOq3?=
 =?us-ascii?Q?e0Nhw9HbqZQ4C3/pFchWF8iaSVI1zQE3Q/mmR9DZGwP/lwnKePyShpOuMrPa?=
 =?us-ascii?Q?M7DCosIJc3l5WvcBft7LLN2yFqf8Z/B7Xo0JhsAgFnpZC/PDnxgVRB1xkUhs?=
 =?us-ascii?Q?GWBPrYWhaUi3KWBoacwWnnA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A2FA54979E55442B9345472585E5571@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dee574-d959-457c-b0fb-08d9f8924468
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 19:08:54.5636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OM6yJKTeYFgTAeJNgGw7qqPPYSP4o2ROC74kpN8hHteTaAm8XjwS73sPxbzRHnuHgCxXsQC1xViDQ83Pk9krXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4111
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250109
X-Proofpoint-GUID: cSyhj4cH-eLxT6d2W-YmspV2pOFh--X5
X-Proofpoint-ORIG-GUID: cSyhj4cH-eLxT6d2W-YmspV2pOFh--X5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Qian Cai <quic_qiancai@quicinc.com> [220224 22:49]:
> On Tue, Feb 15, 2022 at 02:37:44PM +0000, Liam Howlett wrote:
> > The maple tree is an RCU-safe range based B-tree designed to use modern
> > processor cache efficiently.  There are a number of places in the kerne=
l
> > that a non-overlapping range-based tree would be beneficial, especially
> > one with a simple interface.  The first user that is covered in this
> > patch set is the vm_area_struct, where three data structures are
> > replaced by the maple tree: the augmented rbtree, the vma cache, and th=
e
> > linked list of VMAs in the mm_struct.  The long term goal is to reduce
> > or remove the mmap_sem contention.
> >=20
> > The tree has a branching factor of 10 for non-leaf nodes and 16 for lea=
f
> > nodes.  With the increased branching factor, it is significantly shorte=
r than
> > the rbtree so it has fewer cache misses.  The removal of the linked lis=
t
> > between subsequent entries also reduces the cache misses and the need t=
o pull
> > in the previous and next VMA during many tree alterations.
> >=20
> > This patch is based on v5.17-rc4
> >=20
> > git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220214
>=20
> Just a heads-up. I noticed an use-after-free in today's linux-next below.=
 I
> am running out of time to fully triage this, but I noticed this is the on=
ly
> series (not sure which revision) heavily touched mm/mmap.c recently there=
.
>=20
>  BUG: KASAN: use-after-free in move_vma.isra.0
>  Read of size 8 at addr ffff0009ce752ac8 by task systemd-logind/1280
>=20
>  CPU: 21 PID: 1280 Comm: systemd-logind Not tainted 5.17.0-rc5-next-20220=
223-dirty #242
>  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/202=
0
>  Call trace:
>   dump_backtrace
>   show_stack
>   dump_stack_lvl
>   print_address_description.constprop.0
>   kasan_report
>   __asan_report_load8_noabort
>   move_vma.isra.0
>   move_vma at /usr/src/linux-next/mm/mremap.c:714
>   __do_sys_mremap
>   __arm64_sys_mremap
>   invoke_syscall
>   el0_svc_common.constprop.0
>   do_el0_svc
>   el0_svc
>   el0t_64_sync_handler
>   el0t_64_sync
>=20
>  Allocated by task 1280:
>   kasan_save_stack
>   __kasan_slab_alloc
>   slab_post_alloc_hook
>   kmem_cache_alloc
>   vm_area_alloc
>   vm_area_alloc at /usr/src/linux-next/kernel/fork.c:455
>   mmap_region
>   mmap_region at /usr/src/linux-next/mm/mmap.c:2585
>   do_mmap
>   vm_mmap_pgoff
>   ksys_mmap_pgoff
>   __arm64_sys_mmap
>   invoke_syscall
>   el0_svc_common.constprop.0
>   do_el0_svc
>   el0_svc
>   el0t_64_sync_handler
>   el0t_64_sync
>=20
>  Freed by task 1280:
>   kasan_save_stack
>   kasan_set_track
>   kasan_set_free_info
>   __kasan_slab_free
>   kmem_cache_free
>   vm_area_free
>   remove_vma
>   remove_vma at /usr/src/linux-next/mm/mmap.c:187
>   do_mas_align_munmap.isra.0
>   remove_mt at /usr/src/linux-next/mm/mmap.c:2176
>   (inlined by) do_mas_align_munmap at /usr/src/linux-next/mm/mmap.c:2437
>   do_mas_munmap
>   do_mas_munmap at /usr/src/linux-next/mm/mmap.c:2483
>   do_munmap
>   move_vma.isra.0
>   __do_sys_mremap
>   __arm64_sys_mremap
>   invoke_syscall
>   el0_svc_common.constprop.0
>   do_el0_svc
>   el0_svc
>   el0t_64_sync_handler
>   el0t_64_sync
>=20
>  The buggy address belongs to the object at ffff0009ce752aa8
>   which belongs to the cache vm_area_struct of size 144
>  The buggy address is located 32 bytes inside of
>   144-byte region [ffff0009ce752aa8, ffff0009ce752b38)
>  The buggy address belongs to the page:
>  page:fffffc002739d400 refcount:1 mapcount:0 mapping:0000000000000000 ind=
ex:0x0 pfn:0xa4e750
>  head:fffffc002739d400 order:2 compound_mapcount:0 compound_pincount:0
>  memcg:ffff0009ce456e01
>  flags: 0xbfffc0000010200(slab|head|node=3D0|zone=3D2|lastcpupid=3D0xffff=
)
>  raw: 0bfffc0000010200 fffffc002739f108 fffffc00273a3b08 ffff000800f53380
>  raw: 0000000000000000 0000000000210021 00000001ffffffff ffff0009ce456e01
>  page dumped because: kasan: bad access detected
>=20
>  Memory state around the buggy address:
>   ffff0009ce752980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff0009ce752a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  >ffff0009ce752a80: fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb
>                                                ^
>   ffff0009ce752b00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
>   ffff0009ce752b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Thank you for the report.  I will try to reproduce it with a kvm here.

Cheers,
Liam
