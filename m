Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CAD49B905
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1584283AbiAYQiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:38:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20290 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352487AbiAYQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:32:49 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PG4gAd012970;
        Tue, 25 Jan 2022 16:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4O9qBJctzFBFU/310M3vHDhMewFGz5fJwgKkmfZIxcE=;
 b=xFkmULfj47VKVXh0MdMe//e++7ZynxfmSrZANBIGmWwTEQw5Rk6823wvaA2n5p06Q69Y
 US3mvbcFUdRLFrl1pDH3/Jviy2Ur8I8OWKsskFu4i9cNkfQlYHs8b6uSs5q/QN6QZRSp
 WLBKjZYFBES+jN+Ytew7l7pTuUKxA6ZQkv8vNmVuxiCjgIrqRM21mttTHtOzSfB61q0b
 PjPWtTFfcGe3bJV6knXBiI5kMdK2QxPrcpPLDnAo4tUmePcBE15UmSLJmuU58CIU4A7B
 OpXfwhwdYW2Uq1xTvoMS1IOKTlcPMtIRJbPO0526aSlMNc9YA5Cz2GuDWk7/RcDQWQt1 Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaabmtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 16:32:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PGPaHJ030057;
        Tue, 25 Jan 2022 16:32:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by aserp3030.oracle.com with ESMTP id 3dr7yg701t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 16:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/0F3Tvk2bxhw7g+tgMaTx/1Bd4RGVv0JmR+wB13nCGt7ZuCESx0YLQroTun10WqV2Wi4kWS4hIAEaCSu9yCYru4bzCWIFh33eV9SrC/LWEZ5XpVUByjbaOQkMUHnNvVo32eKAChsqzfm2tOy3dWINFhkO8hU+N9WLJ5fRlVG5j9G3/VWRO056czQ08bPRIbNAWaD7WEN9DZthoB6Xndqjaf5uVVVTk7eFOW18/82P2muom7eIMlarqSig8tyfDjVWwm2L+RYhA8FCZ3+aSWbVfuAotY6kTx9i53fnzAck087H8DwxwdaLsvGStmKn01LpqECjhWmQDvRCMWj0k9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O9qBJctzFBFU/310M3vHDhMewFGz5fJwgKkmfZIxcE=;
 b=HSJF9FxNh2FSy2SLhEXlAYzD20HHobs2P+xKnk5CVXBhl4X+BwuKVFvN9avNEeXI6RL4h0Mp94C2nr5h3z8a9sJ67YQMue3lc0qPd8PY69pQc7YXkPW78LCa7LKOiWclQVNS9Hiy6M1u8/yFGi4R8N1ewV5gZBhpZWA6fNLZwqEk6K61uzAIdTzOJfRv4dvH2Wlcmk0+ny0/gx+YZMQekUKijbTUKUuIc9Cl2KcDmFaG7vXNV4Se07T8K6qLaIlAHwBvSVZABbicbDgQQhesNndPoZozRC/iZzfg7OMWONbfft7031nd4yNZpQ4SkMXc1ghPMiG+qfeoZXwLpQ/b6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O9qBJctzFBFU/310M3vHDhMewFGz5fJwgKkmfZIxcE=;
 b=cbLpIU90VCmndRz6X6P7jDddF23L4ogsVz3fQ/Y6zRe8jyfB37hUvTgr25bJr/okmmHSADXVuQB67yiOqc0r7eZ2qamuTxbeBIAkbyvmDy8/fOtJGGsJwpFvPSgBX3iDix4BWfTlc8GVJ2VSzAZWlym2cHWSP8Q3xgzRMUZHJPw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4241.namprd10.prod.outlook.com (2603:10b6:a03:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 16:32:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 16:32:24 +0000
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
Subject: Re: [PATCH v4 34/66] cxl: Remove vma linked list walk
Thread-Topic: [PATCH v4 34/66] cxl: Remove vma linked list walk
Thread-Index: AQHX5r/vilgZfzMys0q49fGy7gPCN6xpArWAgAtCBoA=
Date:   Tue, 25 Jan 2022 16:32:24 +0000
Message-ID: <20220125163217.fhzjqkhr27tx2nbp@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-35-Liam.Howlett@oracle.com>
 <d2f2fa1e-6f95-b49d-a358-c8f01d08b346@suse.cz>
In-Reply-To: <d2f2fa1e-6f95-b49d-a358-c8f01d08b346@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d75122e3-74e8-4e44-0d1b-08d9e02044da
x-ms-traffictypediagnostic: BY5PR10MB4241:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4241AC5C25D98E6C0A39C7ACFD5F9@BY5PR10MB4241.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VWOJORDT1T2kdiNlnEiuKJg6OJteF6Wntgt3RPyzy617BGZn1fhxrmZEI3mZY2CmB+RyJ0hib2SLLQaE5cGUu91KsPvdHzG2XuhUDWgXyoU4vh0tsEvIwwLqS7lBqFjriGDV9Z+Ad7SeAND58vA9/IzMgeBsDfWpPLVvQ/l+UHsKDXXQkQzJDoiIZ+4n3zSUrB3KZ26N2D5QJiwfKlBI4BAnbeVV13JBHvVWxcIIm0JflHO/QjerGh4n5d8ktgzTTqmPacGs9NdfpfsV9zCJKAn8NRAHoyGIrTT5L6Kz0UMWcVFKR9WS5N1jLE38gjRtcdUFbhDSQNbGSE1DsM2/xSd0EgTL0MGZF2PC20D7FtCUL90XEh5YyDkaNeokX+pFFAbNHsx6t/ZGFCZDVfyC5sIF7i7H13ZgBGppy0MP2CZc93XQsL1icYadNyornhseIgnyQmZjdDjYHGRsxPa/nf5yCrGm1UNMhSiRCMTTOLfocgQH0RUsVsSTuspAtBAfkBAfv0xXMQrbPh1JVmmKOmu1BjF8TCrtGFgXdvmKeIJqyK1qe8/o5zQINYhdoNhjR54LfHfiT3beiI6F2H9OEPVhLpkEzqNLWWkSgpUViWDEgCPsEch8YkgeLQNvfak6z+R7Lg+OKl7aiEUP9QS4/d7zT5HsPHxqZcA43/AXLkJr65sxdGOGUx2LxcTZRFhAnSrnsydbIgKOyyGUNZGXXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(53546011)(1076003)(186003)(71200400001)(66946007)(8936002)(8676002)(6512007)(86362001)(26005)(44832011)(122000001)(54906003)(7416002)(83380400001)(2906002)(6506007)(9686003)(6486002)(33716001)(6916009)(91956017)(38100700002)(4326008)(38070700005)(66476007)(66556008)(316002)(5660300002)(66446008)(508600001)(76116006)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cgBMaxj8WQjgtBFNtnTVqrNagT00Dq2mrWhVwwTV8I404svczozxwvKY+VLM?=
 =?us-ascii?Q?HzsL5Hjt4fM6IAv7EvCD1rENZyqEqSj9EHNEXBZDqPituMXnCQgFlQidQO7+?=
 =?us-ascii?Q?9V7yTnbpheKoQ3X3I5IjR0gKOrK//dHMqU+GyVIbQIg7KbQTB8YwKgy11ybx?=
 =?us-ascii?Q?gQ0ubYY7SKXcgi8Pau4ywSCgxENsM/mtbW5XblHLfuRivD+RG0RHCNgC8qga?=
 =?us-ascii?Q?xjhSqtHSL94ZmamF0OQ0nfsEk6ZR04o/zVoIFwHJWPJh9E0fXe8ty7HDNE3G?=
 =?us-ascii?Q?yX9JDlHfBh/aDlYmm7ctkGHVxqICaGoRJr7bH1fMnjjKiRg5UF0ycgJNc5CR?=
 =?us-ascii?Q?cWOPJegy4hsY9lbKeV/DVAwiD3HUCrmsKePZrBhrL+br7Ry2dD7//+C4s5bk?=
 =?us-ascii?Q?XRzEOkeKAp0HRiFFQcbvgiEal0wRX+1htmNYts8NMWGoNo3Cr3bpatCoGUYQ?=
 =?us-ascii?Q?GimHrYgI9R9o7guK1yF2owA7d3rvQ1NFLeqLjzN5LydYEsNL7UipKS74y8Mq?=
 =?us-ascii?Q?dkqF0MrWST4kF4wh4cn/0oinr8fMVmIWGNYvK277VPLHqH5KvTxJrDdxbxfc?=
 =?us-ascii?Q?I/toyj8Zluc6CBBjFw0wu4Df26TwgkU0S3w5/2t2yOYPysNBtvyVWcblfMK/?=
 =?us-ascii?Q?7eAb1Kv3n+V7gyLfuFY9sy63XVvfBiNLBLm67bv0vM+Zsl7r+tUYzzO8iG47?=
 =?us-ascii?Q?goz6QHklWlkleGqAdElMs9+s55P9n9U35/vgKXkNeZisRBbkYVPyzJ9/uXEk?=
 =?us-ascii?Q?vbeGQyA9GBlJBbdDJyQye2YLLF5Kjr7KrFWJcC/mrsYaSJ+ld7JaYiqqhDq9?=
 =?us-ascii?Q?XXXp2YHEX7Hr2VqyUZ2ogKwiLd0wfHKy10QvWqTfUUvGS4iDct9LOrffm1tK?=
 =?us-ascii?Q?ZWds4Rbybl4gi86FWZGKTkJqoQncUHkd8hYoHm62yjmYAyU7wGWer5AOZ+6F?=
 =?us-ascii?Q?pRW1y3J8Pa7vIgMIChnHKf6EMj/D3RQ16uj1EDQuxyKT+sVb77nIDngnHgJX?=
 =?us-ascii?Q?7CjP6mjuF2hom9o8s+Ckq49W/mjAZOK2+nU6KWPVxITBPboPDF5tSmxPwbP2?=
 =?us-ascii?Q?64V3WW7PhzJgx1wE2xBa+SKpZVz+nYjAF58/9FfvCRX1igNXqpiCTW/EV9xQ?=
 =?us-ascii?Q?pfVKJQwRJYZbAHLg5jEePtdtrP+rzhLf6292FNnJqbbNiiUIwvypkuMf7WYP?=
 =?us-ascii?Q?rEIIg9UAzij5OEV99tbgXILNvQtmPFkhZwWUTmM5bgEn4og6WVS00RGHKYFV?=
 =?us-ascii?Q?UF6cfObTWj7q51QxJNsZ1XFuxguczNyqzwa9w4JQTmSdWXF9qYOieuzPkk37?=
 =?us-ascii?Q?2VpqhbrW2IGkSU+ZjKV7a6Niv4UvnTT3+UceeTFme52jBlhk6QoGSEd9s1ZP?=
 =?us-ascii?Q?+k5A7tuBaHUJt/ZrPuUhkJDKegnnj0oSxVYK9fiFNedTY1xYP4fOAoY5WnjJ?=
 =?us-ascii?Q?uE44tmPwOT3pBIX/gelOEOHhJX+u99EMqFtvyi5/ZncIHEV91YE/kOAP9tiT?=
 =?us-ascii?Q?u0QtfmmRsfoeMW5osjiY/DQaXTuQFUN2hThiNTFHA9pDNC5Zg5gYj9eaVGsM?=
 =?us-ascii?Q?iu0ayXrXRFcKKYqm+9VWH5wtzKmoESV4B+t6ei6EnWHCmdyBcBaGjsHo5SPX?=
 =?us-ascii?Q?qjMQArh0kkybBChjmX6M9ZU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED234EC62A86FB4D88604F29CFB93855@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75122e3-74e8-4e44-0d1b-08d9e02044da
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 16:32:24.7570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7nBTCI8cCcMIt4osttw3wGMgUomal7BX8brnfFRJd8gY64CcnsuO4bXDxKdkC+CMU1wP7dtw/smIqjvYQ0d2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4241
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250105
X-Proofpoint-GUID: 8VZ_cAntDn2z7_61Rdkws9WBAQVOfBvQ
X-Proofpoint-ORIG-GUID: 8VZ_cAntDn2z7_61Rdkws9WBAQVOfBvQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220118 07:37]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Use the VMA iterator instead.  This requires a little restructuring
> > of the surrounding code to hoist the mm to the caller.  That turns
> > cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
> > directly.
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  drivers/misc/cxl/fault.c | 43 +++++++++++++---------------------------
> >  1 file changed, 14 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> > index 60c829113299..504522a126b5 100644
> > --- a/drivers/misc/cxl/fault.c
> > +++ b/drivers/misc/cxl/fault.c
> > @@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_wo=
rk)
> >  		mmput(mm);
> >  }
> > =20
> > -static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
> > -{
> > -	struct mm_struct *mm;
> > -
> > -	mm =3D get_mem_context(ctx);
> > -	if (mm =3D=3D NULL) {
> > -		pr_devel("cxl_prefault_one unable to get mm %i\n",
> > -			 pid_nr(ctx->pid));
> > -		return;
> > -	}
> > -
> > -	cxl_fault_segment(ctx, mm, ea);
> > -
> > -	mmput(mm);
> > -}
> > -
> >  static u64 next_segment(u64 ea, u64 vsid)
> >  {
> >  	if (vsid & SLB_VSID_B_1T)
> > @@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
> >  	return ea + 1;
> >  }
> > =20
> > -static void cxl_prefault_vma(struct cxl_context *ctx)
> > +static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct=
 *mm)
> >  {
> >  	u64 ea, last_esid =3D 0;
> >  	struct copro_slb slb;
> > +	VMA_ITERATOR(vmi, mm, 0);
> >  	struct vm_area_struct *vma;
> >  	int rc;
> > -	struct mm_struct *mm;
> > -
> > -	mm =3D get_mem_context(ctx);
> > -	if (mm =3D=3D NULL) {
> > -		pr_devel("cxl_prefault_vm unable to get mm %i\n",
> > -			 pid_nr(ctx->pid));
> > -		return;
> > -	}
> > =20
> >  	mmap_read_lock(mm);
> > -	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> > +	for_each_vma(vmi, vma) {
> >  		for (ea =3D vma->vm_start; ea < vma->vm_end;
> >  				ea =3D next_segment(ea, slb.vsid)) {
> >  			rc =3D copro_calculate_slb(mm, ea, &slb);
> > @@ -337,15 +314,21 @@ static void cxl_prefault_vma(struct cxl_context *=
ctx)
> >  		}
> >  	}
> >  	mmap_read_unlock(mm);
> > -
> > -	mmput(mm);
> >  }
> > =20
> >  void cxl_prefault(struct cxl_context *ctx, u64 wed)
> >  {
> > +	struct mm_struct *mm =3D get_mem_context(ctx);
> > +
> > +	if (mm =3D=3D NULL) {
> > +		pr_devel("cxl_prefault unable to get mm %i\n",
> > +			 pid_nr(ctx->pid));
> > +		return;
> > +	}
> > +
> >  	switch (ctx->afu->prefault_mode) {
> >  	case CXL_PREFAULT_WED:
> > -		cxl_prefault_one(ctx, wed);
> > +		cxl_fault_segment(ctx, mm, wed);
> >  		break;
> >  	case CXL_PREFAULT_ALL:
> >  		cxl_prefault_vma(ctx);
>=20
> Need to pass mm here, compile tested much? :)

ack.

>=20
> After fixup
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> > @@ -353,4 +336,6 @@ void cxl_prefault(struct cxl_context *ctx, u64 wed)
> >  	default:
> >  		break;
> >  	}
> > +
> > +	mmput(mm);
> >  }
> =
