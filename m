Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE84C4F95
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiBYUYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbiBYUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:24:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F872118E0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:23:59 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PIialO010555;
        Fri, 25 Feb 2022 20:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FApZgnSq1eub8tntMlIfLWj0vkzpoz0RhNNfrDH1/iM=;
 b=E2PCN7/MM2BuuDMJzvdKUj/Izip+d22zRB9VDPdO0EGZcNtvyOgKcAnAedOpLTDC5B3B
 AzI+v4i7w4dogAeEHZUFdqD4VJO/mgx5TSzXxa0QP3ncOmVznfWs29gQP9Kv9KgMuJxh
 VO2IVvxwg92K8hihrlbN+69Hksw6lVZv+nihNa43A3OcElp0wuzisT17RveD6URGwEV9
 YtHwYO3MwUE4GUC0gkVP2uPICfqvEGhEQdj9s1ftA+vVCdtfaHWVwMSDbQRZOeIs1Rh5
 5HKTSquc22Cn8sG4Tl4yn+2Rmmy6SjENttzzsLqjN7pbfTmnmB1u3IlKqNnYZq3/P0Qj Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eey5dhsxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 20:23:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PKGcx3133002;
        Fri, 25 Feb 2022 20:23:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 3eb48564u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 20:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2sIUsvoSkULhpLfUwH0bKPlAU/Ztv2ht8uto5ZJUwmxHFpMmaOZwfRhgaVMdrT2hb4QNE1sF0d8CfPrCFLjvrMtvPvrgyerP/LtCpuRGyTJuT+n+QdLFnVtpO9EC5u5AFKeYIc+ZZUmXo68og7absSFnk6Xg+owEOZoxAHC633VMaUH/G6jJx8itQ3X03X5xwtxg1RmNvvIr83m248rWYIAXFT+ry/wj3XJiGXjHAgTZY/ZIIQZix5r6bvPOwBJWAo2ZNpW1JjSSMYuN2oBacofHeyvkhCq98jz3Kk7HDpgz7IAKtWDIzaZ9lZiILL03gS1hfRhy/0BnGy2ackwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FApZgnSq1eub8tntMlIfLWj0vkzpoz0RhNNfrDH1/iM=;
 b=Zd1CceDag5ZtQyHZz5wbXjX7dMiKA8xzpaNqShtZzSHDMFYWaNprEuyC2NNMTmj1uIO9jESNnN25id7K/CZaLx4HZfYDMoLUZuPSOyRnLvUYlOlxcSzcuzPKE/dj6X2anuq32EOKw6Ca51Ph0bPlVbCG16+nuNgQkUW5kOLmwlCujEYXOQpndg/yAAZyzm3+nmBGmmYRNa5NU0r3u5c8bERIYt2KHTnqkyVNd7WfwhRVq4BFyMj4Qe/zSmyOgsLzJp3lFKxkfcaaoJHXPPw9Yjxg7s5AKy2bkApyPuLmAWNEUTNeA1zWRpPBrGwJOHFpgjUscUmozfDjjNK6FEpIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FApZgnSq1eub8tntMlIfLWj0vkzpoz0RhNNfrDH1/iM=;
 b=yEuPAdYuTZqTugzCqld+NDu7TK9VPTs/Gf5mcavpZR/gC2qYbFCVEyzZVAVqDyIWLSSENvBuWH54378HW4Jk5P9BXJV8VlG/1nUht/CFdBa8NpTjCOtBPhgHqNOMx5YCvY6IJoANRnRquCg9kbO2XqziKxepsFcUCKboeDks7gE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 20:23:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 20:23:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Topic: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Index: AQHYInmXxzMTjmF25U+e/3QAVwcn6KyjsEsAgAEA+wCAABTmAA==
Date:   Fri, 25 Feb 2022 20:23:41 +0000
Message-ID: <20220225202334.bsw5t3retcchpn2e@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <YhhRrBpXTFolUAKi@qian> <20220225190846.u4fwebimd5ejfdpd@revolver>
In-Reply-To: <20220225190846.u4fwebimd5ejfdpd@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f299136-449e-488b-c581-08d9f89cb6df
x-ms-traffictypediagnostic: BLAPR10MB5138:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5138F875F933CFDF101D9C74FD3E9@BLAPR10MB5138.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JlGVf3XFsZzGcCZg01sFxHE23RRt+Tb05BOjnL6+B7ZDqnQ4kePB0tnxAMuibbczrh3jxOffb/rU8FjbgMad48g60jipgswRm7ndUYgUuHKvyu0iCds0jYK512j43wHxpetJoabVUF4L28v3EZ+1vugEaNdllN3XP9DL9MBAyjoB1bJ8C18Ap9H465dPOodEUNQekgujtqOaZaQD0GYF0+MBjp4TvoM8UsovLVRr84KZsEV8KuQaLww2LPBu59LUE1jFBu6/Bu2bd+Oi4WDurmZqrgqggXrY/m2brIbgdEEyXReqqJ443eDyQMVORio4DvnUcU6NL+xLZslTMDtoaDByhyYKWfJCTz7O67WcYu/hqDu49zkWIuz28qqr9dQolYvwXp1cnlggHM6t63q67zOap3wVFSteJufXWC7PMJobSSOZBPzzUPLRz6zuF6aFZ5tWpeK+x1RDXpfosvdEa8RMfxoabqoLvEKoXXB2onVHE4pmWOVYTI3zgGcBXso3c5Q+H7ko+cBzPthCyVhNBWKZPguiKDUyPs0L2g4uOaz4runTLXU5eKkWiUyMgwAI3U2gY0ORJyD6Bf53Zz6p4A6IwnLspv+YB7K2TUOD2zbUwYMHhDnsY8KGjHg9IbkJBqiPXNG8cPXeJYE3EvhWkjfX2ZlfJmvERoee++O840eGpnW6xLziFTHxaJxyPNhTJmB+ZMs4rOj6x7auZLp82qqbRQzslf3bVEdeLKHyQxoATS9zuCoNSrNmoQyZP8N25eajzC3njDE5kkIE4mqPcQjzymKhM2vL865MLSdaOGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(38100700002)(122000001)(6486002)(966005)(1076003)(26005)(508600001)(8936002)(44832011)(5660300002)(71200400001)(6506007)(64756008)(316002)(91956017)(76116006)(66946007)(8676002)(38070700005)(2906002)(33716001)(9686003)(6512007)(83380400001)(86362001)(6916009)(66446008)(66476007)(66556008)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nx70/1h5fG+ktamTCn6VyctxIRNQyNwnCTpXx3hS2vSZAMiil6oNiOs+1foI?=
 =?us-ascii?Q?csmeHJYYU4fP/5Sj9/js1CSAnzirgLUIBrrvu/cJGSREXsXR/gelZQZT2aBK?=
 =?us-ascii?Q?qtBiT86hENUCvxutNtMciryiQN7aHX8xbQ79TYwBwrULJZD4Whb2qbpNczt+?=
 =?us-ascii?Q?eZjgu4kfajdyHkDmx/SA1PXpFEMu6FW0VOzHHtSdMh3rcDoEAzabTGBtxMED?=
 =?us-ascii?Q?PmZTc8QyufbgII9mfUpb9k7ITRVorBEf1b/L1bWA2hI4po0sTdZVrOMFyjoT?=
 =?us-ascii?Q?RkDCl9YVcUDE5PSitM3Ic+jJyUqU6gZvEP67LMnCVn92Gg2dVi91kdo9h5p/?=
 =?us-ascii?Q?1zWy06M9tekJ7QKDfz5z8itV/06PZJbkLKqOsVfwGK7iVi/LGTh5p/jwgjee?=
 =?us-ascii?Q?SD8BVW6l01RSraK+c6wbRvlqCexBTbpHtgumvNSuW/uKQByMDOeHDVnnVh6/?=
 =?us-ascii?Q?nwJ7ewWzvJonjpIy2qlSstSVx2+350nSeB4qwDjgWnp16o3K5WhJlQHuzhbt?=
 =?us-ascii?Q?anvV7dg8ICfoHz0EHB9eM4sBZrf2G078bJTbXh0C+E+X8bRf5xKUqs2386vI?=
 =?us-ascii?Q?Zr9UZ1v9QR+KGtFdnnSC1425MjbYOH0PSc/WxG4WZXlyQbMgX+wIhCTlKa8S?=
 =?us-ascii?Q?oPbQz1GeXdykJIBAd9gn4JzYG0eNUJk3JAeXwmZ6s2axr44dWRyuT6y5XYcF?=
 =?us-ascii?Q?Ye7vlQdodiP1Fvmvztr7FpUMrIyG2uMyApNU93ddkswQXF2loSvIDHhlD0l1?=
 =?us-ascii?Q?qmCs25u5NZ1K0e2He/5BPY1PiPN5zWXqSYsjwsQ40xQ2XhJpA6Cc0D0yvSiC?=
 =?us-ascii?Q?RQviVISnnMLvrB3VlwEwvePNW/AHdD6aFVycRr87FnrswIMoISiKYSwUBdoN?=
 =?us-ascii?Q?vy7ApS7Fd30cAqzIj+mJdYGP4tpLD+XP56zxBdjcKyb7vttUz44G7WUYxE4W?=
 =?us-ascii?Q?xoaE1D9UjraIbty9BMIFAqYESSJRqKbmyvQK7N6HV8E0Z3uA5sv70EAy+Czn?=
 =?us-ascii?Q?o7B+1EwVymHOQav1LjWYbhhwCkazjQ9wi+b3Y8M2M99UX718OGXaD/5cLH2+?=
 =?us-ascii?Q?cAlpvyPVhQZJyPti1sqyTB1LZKe3DWHgb0K5KEi2Jz0sjQsk4qrAL+GBmS6R?=
 =?us-ascii?Q?Qk7K/sys23W54ApXXjO5gKKYwknSDBDW54bdhKHEZ9+XR2V5ZMqjUCcLt+KM?=
 =?us-ascii?Q?z/uIl3cf+a0iYPq/jDPAvKKZ3MnilNmiDSAageNTSsJcNSLblNATnaTkvepK?=
 =?us-ascii?Q?mXM8bZjBeMOge8kFZRk0BvBY83RsQhI+r6AQP8rxwgVtitcqKQDrp4p/5sjM?=
 =?us-ascii?Q?+RCrrXoBpyKEcvN6ImFhLJNthB3k/Y3eTib5Kn7ZVydj5C6a8b51Ez390G9Q?=
 =?us-ascii?Q?HrElbTNuB8lPE2C44BXkRNp7l5H0mqqwDKfLHSQDuqjnUWkxsfoArIlzVaWJ?=
 =?us-ascii?Q?h/gWS7JBVF8gK7ZnqauXRtVEtRH8KgiW7exf2JhhBEtzdKCG+RGSUkh0Ut6W?=
 =?us-ascii?Q?bEvrRk3gdbSNnRJ1X65QV5IL9YeiCx9xdzfnGx2mwAmYADU/oow3/jxPypQF?=
 =?us-ascii?Q?hR211lZbzNQp3O8cTnPVIRsifICIrVsfbglRjYU8UUqiWLxz7PtQ4Irh4M2K?=
 =?us-ascii?Q?EtyQQlC98KCwFQ+8pg/Nm0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21D14E03D8E5204A876199546DB542AF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f299136-449e-488b-c581-08d9f89cb6df
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 20:23:41.5715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TnK6zpVrL02/sZdkPWSWqRLgZtpOxj1Qrto6ugTXEOU/noBdZYTynkdy9MZa24riDHo9MnuvnSZid3UKRMn42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10269 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250112
X-Proofpoint-GUID: 5Ut0vhdRRKQCPdhE4H_WPN0dy7vb5TrM
X-Proofpoint-ORIG-GUID: 5Ut0vhdRRKQCPdhE4H_WPN0dy7vb5TrM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam Howlett <liam.howlett@oracle.com> [220225 14:09]:
> * Qian Cai <quic_qiancai@quicinc.com> [220224 22:49]:
> > On Tue, Feb 15, 2022 at 02:37:44PM +0000, Liam Howlett wrote:
> > > The maple tree is an RCU-safe range based B-tree designed to use mode=
rn
> > > processor cache efficiently.  There are a number of places in the ker=
nel
> > > that a non-overlapping range-based tree would be beneficial, especial=
ly
> > > one with a simple interface.  The first user that is covered in this
> > > patch set is the vm_area_struct, where three data structures are
> > > replaced by the maple tree: the augmented rbtree, the vma cache, and =
the
> > > linked list of VMAs in the mm_struct.  The long term goal is to reduc=
e
> > > or remove the mmap_sem contention.
> > >=20
> > > The tree has a branching factor of 10 for non-leaf nodes and 16 for l=
eaf
> > > nodes.  With the increased branching factor, it is significantly shor=
ter than
> > > the rbtree so it has fewer cache misses.  The removal of the linked l=
ist
> > > between subsequent entries also reduces the cache misses and the need=
 to pull
> > > in the previous and next VMA during many tree alterations.
> > >=20
> > > This patch is based on v5.17-rc4
> > >=20
> > > git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220214
> >=20
> > Just a heads-up. I noticed an use-after-free in today's linux-next belo=
w. I
> > am running out of time to fully triage this, but I noticed this is the =
only
> > series (not sure which revision) heavily touched mm/mmap.c recently the=
re.
> >=20
> >  BUG: KASAN: use-after-free in move_vma.isra.0
> >  Read of size 8 at addr ffff0009ce752ac8 by task systemd-logind/1280
> >=20
> >  CPU: 21 PID: 1280 Comm: systemd-logind Not tainted 5.17.0-rc5-next-202=
20223-dirty #242
> >  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2=
020
> >  Call trace:
> >   dump_backtrace
> >   show_stack
> >   dump_stack_lvl
> >   print_address_description.constprop.0
> >   kasan_report
> >   __asan_report_load8_noabort
> >   move_vma.isra.0
> >   move_vma at /usr/src/linux-next/mm/mremap.c:714
> >   __do_sys_mremap
> >   __arm64_sys_mremap
> >   invoke_syscall
> >   el0_svc_common.constprop.0
> >   do_el0_svc
> >   el0_svc
> >   el0t_64_sync_handler
> >   el0t_64_sync
> >=20
> >  Allocated by task 1280:
> >   kasan_save_stack
> >   __kasan_slab_alloc
> >   slab_post_alloc_hook
> >   kmem_cache_alloc
> >   vm_area_alloc
> >   vm_area_alloc at /usr/src/linux-next/kernel/fork.c:455
> >   mmap_region
> >   mmap_region at /usr/src/linux-next/mm/mmap.c:2585
> >   do_mmap
> >   vm_mmap_pgoff
> >   ksys_mmap_pgoff
> >   __arm64_sys_mmap
> >   invoke_syscall
> >   el0_svc_common.constprop.0
> >   do_el0_svc
> >   el0_svc
> >   el0t_64_sync_handler
> >   el0t_64_sync
> >=20
> >  Freed by task 1280:
> >   kasan_save_stack
> >   kasan_set_track
> >   kasan_set_free_info
> >   __kasan_slab_free
> >   kmem_cache_free
> >   vm_area_free
> >   remove_vma
> >   remove_vma at /usr/src/linux-next/mm/mmap.c:187
> >   do_mas_align_munmap.isra.0
> >   remove_mt at /usr/src/linux-next/mm/mmap.c:2176
> >   (inlined by) do_mas_align_munmap at /usr/src/linux-next/mm/mmap.c:243=
7
> >   do_mas_munmap
> >   do_mas_munmap at /usr/src/linux-next/mm/mmap.c:2483
> >   do_munmap
> >   move_vma.isra.0
> >   __do_sys_mremap
> >   __arm64_sys_mremap
> >   invoke_syscall
> >   el0_svc_common.constprop.0
> >   do_el0_svc
> >   el0_svc
> >   el0t_64_sync_handler
> >   el0t_64_sync
> >=20
> >  The buggy address belongs to the object at ffff0009ce752aa8
> >   which belongs to the cache vm_area_struct of size 144
> >  The buggy address is located 32 bytes inside of
> >   144-byte region [ffff0009ce752aa8, ffff0009ce752b38)
> >  The buggy address belongs to the page:
> >  page:fffffc002739d400 refcount:1 mapcount:0 mapping:0000000000000000 i=
ndex:0x0 pfn:0xa4e750
> >  head:fffffc002739d400 order:2 compound_mapcount:0 compound_pincount:0
> >  memcg:ffff0009ce456e01
> >  flags: 0xbfffc0000010200(slab|head|node=3D0|zone=3D2|lastcpupid=3D0xff=
ff)
> >  raw: 0bfffc0000010200 fffffc002739f108 fffffc00273a3b08 ffff000800f533=
80
> >  raw: 0000000000000000 0000000000210021 00000001ffffffff ffff0009ce456e=
01
> >  page dumped because: kasan: bad access detected
> >=20
> >  Memory state around the buggy address:
> >   ffff0009ce752980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >   ffff0009ce752a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  >ffff0009ce752a80: fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb
> >                                                ^
> >   ffff0009ce752b00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
> >   ffff0009ce752b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>=20
> Thank you for the report.  I will try to reproduce it with a kvm here.
>=20

I just booted an arm64 VM with my build and kasan enabled with no issue.
Could you please send me your config file for the build?

Thanks,
Liam


