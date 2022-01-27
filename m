Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340D349EC53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbiA0UPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:15:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7320 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343687AbiA0UPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:15:06 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RIDHiF004073;
        Thu, 27 Jan 2022 20:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vYaGwPpE76Ek4x7uekDqBBkKXk/Xjtzv/LUkGxfS/+0=;
 b=ky+C6N8FXnL8QzDZdNx3GPQ8ko2l1dVWXDTwB0+lkrsgn9aJRlhircoksMNHLMh0aRxq
 6DPgPJ4n9P21sSnwYRfU6Vu8EyUf77JDoKbueWNTV5M5x1BqWsaCF9sweAZt5ZZB23YL
 K3pT4ZfHIBS+7rWihSyG+Fi/hIDqDwMepoypJbVeBcMH1cZqM+RvrQLW9T55FL7htBe7
 xK3LYmaq+Wg4aswDYXoIYmeyp6fTiMeTYCLeaAE+QovVCvdySPjhuE9kRWsS/vKMj8c9
 wjL6MidT07nukc2TU7pd3jm97Tz+prwRb4jDLkJ3Vl5vKGybdg0bCvXAvQuBuoDMZ5Ih 8g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwrxh4xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 20:14:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RK6YD7111840;
        Thu, 27 Jan 2022 20:14:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3drbcu7qr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 20:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ5aTLJjOu6FRMWbTJkXz97y9DzANUkwIpyUd+h7izQzc8uykXGFNR33ydNOGjc/t3O//IoUBpGWDZgLL/TzsP2dHVZY23iYSTonJB5Qf04J3TzsivuUU9uMQ2oxFTMxT+d6y360gycXBKyW1O4RELyedVWg+7wtSzu3nkxXsZaGg0iPgGlvW4UI5gg+B1rjnsU+UgvHs9T0q9UVv/7sjwzAThyxAX3oKd6D5q7jX3lJAJfbiUlJpsN/2dOLuuvV3AfAcL7waYPgLcZjCpirvE75GBFnaA+yODGgrU62duHB+aNGJwYvB5xP4CRfoL9NWD+8gCHlgx1h5iFpG4A0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYaGwPpE76Ek4x7uekDqBBkKXk/Xjtzv/LUkGxfS/+0=;
 b=hDm8eTx7y8SfEc4Z0T4unI1boENjHLLT9xdvAE/dQpjDyi+81Q1VDS9vIxOkGFW3aCo8P0OrE7PYtvbatSi5Mo+qGA+TMF3IODMjmATy2rsNsCVnDGtsR/a/cO2DX+F4kLr9UnXQ68YkfXbKcAizqZJ7naQY5cnriPNmPoAFBk//aMRqwqb6AoeOID+lXeixKXhImraDAzxhu9W+Db9I07PP+PVCzWrYLbFBEMpbDz25JZbMtV3nyMTRK/DZfCOXmLiOmf4dZx77WQ2XPbVFLUnk8mSzeMU5065s5xCu7QJgsZo7tUe5tWYZJ4CutRJufAocWcCaVN7GdtJHKDhHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYaGwPpE76Ek4x7uekDqBBkKXk/Xjtzv/LUkGxfS/+0=;
 b=B3EKvzUOAZmD95sg8cOF3ZgOQPLKSnZmyTQYztccISniQ4QuMyzMIgqzLr9Z2CeQgbZ9KhzkXzzSLY2LK80DHqroGHu9ooubqVj/GhYBFMZxYohy/DTzBV/Eo+TiMrKTlEzotKPlZzjM6AUJPEzlfXd3cDVzcSCof6LNJSWQoho=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1251.namprd10.prod.outlook.com (2603:10b6:405:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 20:14:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 20:14:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
Subject: Re: [PATCH v4 42/66] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v4 42/66] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Index: AQHX5r/xefKkkGSxLEyfIjGHfmNy0qxtrUKAgAn6OwA=
Date:   Thu, 27 Jan 2022 20:14:34 +0000
Message-ID: <20220127201432.npe62zovlvviubfz@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-43-Liam.Howlett@oracle.com>
 <e7c8e1c8-af65-f771-d7ea-4703b1e39fe3@suse.cz>
In-Reply-To: <e7c8e1c8-af65-f771-d7ea-4703b1e39fe3@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa6429c6-8173-43de-254f-08d9e1d1a32b
x-ms-traffictypediagnostic: BN6PR10MB1251:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1251C65BC82D5DC13729B1A2FD219@BN6PR10MB1251.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:459;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CeLXAVIICyZ7z+0RkMaNUsKbHSalFBZrJ+Pbb8zKeqL34ZYi1iPs3oba13ccbMcPyhe+1qLw0d9dAnTzhHMEI6WwWMqiPeTNA6ScgF2ussK5nApI8lUY99DLh1YbCdl0EhHW5Bsyq2oZXZi68TCHBD7VRMpcYYKIBZZeFfoDnMR5zRIIHqzO1VbyhDidJks84KqK/wB/Ci7UiHlbJe3G7ukMQVQ+srsbDYuFV4vQi/mYMKU0kulxhA6LIvDgwa52EJ2+YFIzPdw5ZurwyRxqhLnkrk0NTHpzdRkZ4lxByiuvUfQvm5YTTuFtMa2jK8NBvglARTY/Cfy5mIDisv85BHO5KZc5NHpudkua458d7QRpvMgqX/gWJGp1iHigPDDMptg/gT/b5cNw3XLoBoipI2vbaxj4kCY0ieIa1OP+zsATSbHKEKFxjP+nNvtey4NsvWPCk+UqIgAF4DyaNixVl1FWEq5SyDoUvb4ctHcDq1lVj+pCqUCAKukSy9ao/REizYxqYiNtFRTZSzVnn0oBBCOVsPu0t3i1vO2ka2HkmF8IWkZyusEyqM1XuK+YqdgbvGvnEVnAGXQCMEMSBnF/kYu2+N2+gZVqH+PkkCVWT7Ex6iJBVZ0Brkm939eACLjPDWIqxLifohudmJPL0vnPj0p1QGRdlcWMA1wk5k06e//JDp7qtf4A3XAkZCXtYrnk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(38100700002)(1076003)(54906003)(508600001)(316002)(2906002)(6486002)(38070700005)(33716001)(122000001)(44832011)(9686003)(6512007)(8676002)(4326008)(7416002)(91956017)(76116006)(8936002)(66556008)(66476007)(66446008)(64756008)(66946007)(6506007)(5660300002)(86362001)(186003)(83380400001)(26005)(53546011)(71200400001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+kvzJ0VQ1YiBd2h9aqIN+t+zBoJQ2ILwdT8Z3S0GkbV/EgMEruo0Vj6LVgbg?=
 =?us-ascii?Q?t2PpXGSTvhXcm3NxQFcfBtRMjS+6RxXcDnSj/JutK3xvF/pUI3c6azu33ovc?=
 =?us-ascii?Q?FfxcEa1kWvkVkoF4NyKWKCfKb8lTQuGMiYabEwxgfzDKSGEVE+qaFYFkQUBA?=
 =?us-ascii?Q?yg2ldDdAMEiH99cp0mMBhAjIHW/uzyoUY1QaN/arXbvU0WSC+LdborelKVB6?=
 =?us-ascii?Q?MA6NMl8E0LO864iOMWbJVH1jtckjCT8N+SBLvhjpuRnqsOZja4LwwBdRZ+hl?=
 =?us-ascii?Q?7XsEqPZ3ZP6Q7fBH3mL/MyOInlLKFz52cvFdEACWaDsct93fHiufiLPn9UIt?=
 =?us-ascii?Q?fx9gsTDafeZL725mqGEknx9wW+gOE7LryvnvVP54BeLlSQjmKb2Lq46rHjbG?=
 =?us-ascii?Q?BTS987ZeJMCjZMmviIslFw6fPK7/OLOfg+QnIw8ORCsB5rSR8O2AJu9sTXW0?=
 =?us-ascii?Q?oe2QkD7mLHSknpBjeK8hhZ8ZUUbw6viMpTVO42pCROK/QP0rgoGbftB6/ZXo?=
 =?us-ascii?Q?/mgdVtsZDrCPPX7J022vUZej8px996xDPvg48nLYz9/n61/TuhxB4Kb/R59y?=
 =?us-ascii?Q?SKeCHzaJ7BWGpelOmpgyE9L/ZX34wc2eDdxnVkcePHN9qpKhysMzU5IQ6QDm?=
 =?us-ascii?Q?G0e3KbZJeZLibw3XPCqSmkuN6hePOFW8ToVuKN/yegU4S9RL+nG+RCJr/n2s?=
 =?us-ascii?Q?Tjr76GUrs043n5YW9AXngyCi/dddhFjlbfVEH5o5fhp89Ze//D1nXZutN2X6?=
 =?us-ascii?Q?VsECuhJPbMXevc0vXojYadmjw9VuBffWcSy3VHyQuwEJhzFolRHqfS+7Q/n5?=
 =?us-ascii?Q?O6EBllLEVj9Ih1QSlVmpqH4Be+GCVGZMGmGcHMMTLED+88+nj3+dGTei1dlZ?=
 =?us-ascii?Q?0cxjCiIsM6YUVs0tLrtkot0kyVPU1W6UuPMwU1aBtPs/g3sTo1Cg6yx22SyL?=
 =?us-ascii?Q?1v00HZtlvNUmrXSQZeF3/SmWjr49F4eyX0u+9EUNYm90DRx9qvgCMl+X/FHs?=
 =?us-ascii?Q?3L+s45LstdOD5fVBl3vtQZ0jF+lEchDsSgWmGMYJAC9rJ3gQ4AQZm14PCtg6?=
 =?us-ascii?Q?F2vQqD9nEyCQiFxjzvTkMFVjHQ74Jsin4KOxADmV5+/G7dkIR5mGx+TEyk+p?=
 =?us-ascii?Q?SZHtBGggwBjk6hSUqGfij/e4v260TW+IEsFQ2KliwkcWuc5NW9w2npX4A4J8?=
 =?us-ascii?Q?w08LUo7jtsEDphjQALMkxxLns9RIbgiitqcuZvnRmYjUk3LyOMLbbBGbTZuM?=
 =?us-ascii?Q?ZfpNpkCR11MqBL9Hkf0Q+Dobw5dn5tbXxVRKj+GWX/TnJ14RTvN7Y9lt/ycX?=
 =?us-ascii?Q?oWZrBM78SxkE249cB3bsO4hLrQ0I8PBaw0ktmO2dRiCAo5r3UEHqWWMKRnRi?=
 =?us-ascii?Q?NqImPbdgh88aPMLw92vb41rbVywusJ7ntqJuqmr7R46pZ6vNxvU8x0yC1MFV?=
 =?us-ascii?Q?xvifZLAi9w2Uf3mDz2GzV0N4D1GNuugCHX3/cpgnLEFcgjINfgZQkTw0cCmA?=
 =?us-ascii?Q?uQkWPz1DzQQ0AMVhsqNDJlnHk/4F9ZKawOnkObSvNoITeaH0KwuYoZSGvTrJ?=
 =?us-ascii?Q?ZhZ0muFLd76ras8ylMMNgSVkbYHwO3J+dLy49rlhnlBauZGmM9tgJVl7iDOx?=
 =?us-ascii?Q?A1MpGiNOw0OXqj610mE1ycs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDBBB199A0F8D94BB7F3418F9303B5BD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6429c6-8173-43de-254f-08d9e1d1a32b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 20:14:35.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0+t4Xs0G6VHnwbJKhAWfzJBny7hPr4+UJLD8KWhX1ffOqi3ppHs4mSP9y94tq9uhSmfSg3h5u6bFW36oKTjXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1251
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270116
X-Proofpoint-GUID: T3Dr_PusSL2GrFVw4aqR2r2PiFcVqC97
X-Proofpoint-ORIG-GUID: T3Dr_PusSL2GrFVw4aqR2r2PiFcVqC97
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220121 06:52]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Remove references to mm_struct linked list and highest_vm_end for when
> > they are removed
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  fs/proc/internal.h |  2 +-
> >  fs/proc/task_mmu.c | 73 ++++++++++++++++++++++++++--------------------
> >  2 files changed, 42 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index 03415f3fb3a8..45b132c609ff 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -290,7 +290,7 @@ struct proc_maps_private {
> >  	struct task_struct *task;
> >  	struct mm_struct *mm;
> >  #ifdef CONFIG_MMU
> > -	struct vm_area_struct *tail_vma;
> > +	struct vma_iterator iter;
> >  #endif
> >  #ifdef CONFIG_NUMA
> >  	struct mempolicy *task_mempolicy;
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 300911d6575f..7cc97cdb88c2 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -122,12 +122,26 @@ static void release_task_mempolicy(struct proc_ma=
ps_private *priv)
> >  }
> >  #endif
> > =20
> > +static struct vm_area_struct *proc_get_vma(struct proc_maps_private *p=
riv,
> > +						loff_t *ppos)
> > +{
> > +	struct vm_area_struct *vma =3D vma_next(&priv->iter);
>=20
> This advances the iterator.

Maybe.  vma_next() will call vma_find() which calls mas_find().
mas_find() will return the VMA at that address (or the next VMA) on the
first call.

>=20
> > +
> > +	if (vma) {
> > +		*ppos =3D vma->vm_start;
>=20
> This advances *ppos.

If the vma_next() returned the next vma, yes.  If it returned the one at
vmi->mas->index, then no.

>=20
> > +	} else {
> > +		*ppos =3D -2UL;
> > +		vma =3D get_gate_vma(priv->mm);
> > +	}
> > +
> > +	return vma;
> > +}
> > +
> >  static void *m_start(struct seq_file *m, loff_t *ppos)
> >  {
> >  	struct proc_maps_private *priv =3D m->private;
> >  	unsigned long last_addr =3D *ppos;
> >  	struct mm_struct *mm;
> > -	struct vm_area_struct *vma;
> > =20
> >  	/* See m_next(). Zero at the start or after lseek. */
> >  	if (last_addr =3D=3D -1UL)
> > @@ -151,31 +165,21 @@ static void *m_start(struct seq_file *m, loff_t *=
ppos)
> >  		return ERR_PTR(-EINTR);
> >  	}
> > =20
> > +	vma_iter_init(&priv->iter, mm, last_addr);
> >  	hold_task_mempolicy(priv);
> > -	priv->tail_vma =3D get_gate_vma(mm);
> > -
> > -	vma =3D find_vma(mm, last_addr);
> > -	if (vma)
> > -		return vma;
> > +	if (last_addr =3D=3D -2UL)
> > +		return get_gate_vma(mm);
> > =20
> > -	return priv->tail_vma;
> > +	return proc_get_vma(priv, ppos);
>=20
> So here we advance those as part of m_start(), which I think is wrong in =
the
> seqfile API. See seq_read_iter() in fs/seq_file.c how it handles a full
> buffer, around the comment "// need a bigger buffer" it will do a stop() =
and
> start() again and that's supposed to get the same vma.
> seqfile is tricky, part #220121

I've built, booted, and tested this as follows:

root@dev0:~# dd if=3D/proc/1/maps of=3Done bs=3D512; dd if=3D/proc/1/maps o=
f=3Dtwo bs=3D4096; cmp one two
23+1 records in
23+1 records out
12188 bytes (12 kB, 12 KiB) copied, 0.000114377 s, 107 MB/s
0+3 records in
0+3 records out
12188 bytes (12 kB, 12 KiB) copied, 6.9177e-05 s, 176 MB/s
root@dev0:~# dd if=3D/proc/1/maps of=3Done bs=3D3; dd if=3D/proc/1/maps of=
=3Dtwo bs=3D10; cmp one two
4062+1 records in
4062+1 records out
12188 bytes (12 kB, 12 KiB) copied, 0.0184962 s, 659 kB/s
1218+1 records in
1218+1 records out
12188 bytes (12 kB, 12 KiB) copied, 0.0062038 s, 2.0 MB/s
root@dev0:~#

>=20
> >  }
> > =20
> >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> >  {
> > -	struct proc_maps_private *priv =3D m->private;
> > -	struct vm_area_struct *next, *vma =3D v;
> > -
> > -	if (vma =3D=3D priv->tail_vma)
> > -		next =3D NULL;
> > -	else if (vma->vm_next)
> > -		next =3D vma->vm_next;
> > -	else
> > -		next =3D priv->tail_vma;
> > -
> > -	*ppos =3D next ? next->vm_start : -1UL;
> > -
> > -	return next;
> > +	if (*ppos =3D=3D -2UL) {
> > +		*ppos =3D -1UL;
> > +		return NULL;
> > +	}
> > +	return proc_get_vma(m->private, ppos);
> >  }
> > =20
> >  static void m_stop(struct seq_file *m, void *v)
> > @@ -843,16 +847,16 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
> >  {
> >  	struct proc_maps_private *priv =3D m->private;
> >  	struct mem_size_stats mss;
> > -	struct mm_struct *mm;
> > +	struct mm_struct *mm =3D priv->mm;
> >  	struct vm_area_struct *vma;
> > -	unsigned long last_vma_end =3D 0;
> > +	unsigned long vma_start =3D 0, last_vma_end =3D 0;
> >  	int ret =3D 0;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > =20
> >  	priv->task =3D get_proc_task(priv->inode);
> >  	if (!priv->task)
> >  		return -ESRCH;
> > =20
> > -	mm =3D priv->mm;
> >  	if (!mm || !mmget_not_zero(mm)) {
> >  		ret =3D -ESRCH;
> >  		goto out_put_task;
> > @@ -865,8 +869,13 @@ static int show_smaps_rollup(struct seq_file *m, v=
oid *v)
> >  		goto out_put_mm;
> > =20
> >  	hold_task_mempolicy(priv);
> > +	vma =3D mas_find(&mas, 0);
> > +
> > +	if (unlikely(!vma))
> > +		goto empty_set;
> > =20
> > -	for (vma =3D priv->mm->mmap; vma;) {
> > +	vma_start =3D vma->vm_start;
> > +	do {
> >  		smap_gather_stats(vma, &mss, 0);
> >  		last_vma_end =3D vma->vm_end;
> > =20
> > @@ -875,6 +884,7 @@ static int show_smaps_rollup(struct seq_file *m, vo=
id *v)
> >  		 * access it for write request.
> >  		 */
> >  		if (mmap_lock_is_contended(mm)) {
> > +			mas_pause(&mas);
> >  			mmap_read_unlock(mm);
> >  			ret =3D mmap_read_lock_killable(mm);
> >  			if (ret) {
> > @@ -918,7 +928,7 @@ static int show_smaps_rollup(struct seq_file *m, vo=
id *v)
> >  			 *    contains last_vma_end.
> >  			 *    Iterate VMA' from last_vma_end.
> >  			 */
> > -			vma =3D find_vma(mm, last_vma_end - 1);
> > +			vma =3D mas_find(&mas, ULONG_MAX);
> >  			/* Case 3 above */
> >  			if (!vma)
> >  				break;
> > @@ -932,11 +942,10 @@ static int show_smaps_rollup(struct seq_file *m, =
void *v)
> >  				smap_gather_stats(vma, &mss, last_vma_end);
> >  		}
> >  		/* Case 2 above */
> > -		vma =3D vma->vm_next;
> > -	}
> > +	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
> > =20
> > -	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
> > -			       last_vma_end, 0, 0, 0, 0);
> > +empty_set:
> > +	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
> >  	seq_pad(m, ' ');
> >  	seq_puts(m, "[rollup]\n");
> > =20
> > @@ -1229,6 +1238,7 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >  		return -ESRCH;
> >  	mm =3D get_task_mm(task);
> >  	if (mm) {
> > +		MA_STATE(mas, &mm->mm_mt, 0, 0);
> >  		struct mmu_notifier_range range;
> >  		struct clear_refs_private cp =3D {
> >  			.type =3D type,
> > @@ -1248,7 +1258,7 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >  		}
> > =20
> >  		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
> > -			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> > +			mas_for_each(&mas, vma, ULONG_MAX) {
> >  				if (!(vma->vm_flags & VM_SOFTDIRTY))
> >  					continue;
> >  				vma->vm_flags &=3D ~VM_SOFTDIRTY;
> > @@ -1260,8 +1270,7 @@ static ssize_t clear_refs_write(struct file *file=
, const char __user *buf,
> >  						0, NULL, mm, 0, -1UL);
> >  			mmu_notifier_invalidate_range_start(&range);
> >  		}
> > -		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
> > -				&cp);
> > +		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
> >  		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
> >  			mmu_notifier_invalidate_range_end(&range);
> >  			flush_tlb_mm(mm);
> =
