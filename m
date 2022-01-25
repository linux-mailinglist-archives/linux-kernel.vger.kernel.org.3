Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8349BDEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiAYVhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:37:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2548 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231860AbiAYVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:37:31 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PJ9GNE003658;
        Tue, 25 Jan 2022 21:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JuSHzzTrktYAIaqsDNXwzKIRJRJxF7fUkAuPT6JwRuE=;
 b=tosnbL0WoNENsbXn2kxPa+r/ETAeScKMytT9YiZQ7ZJMvvWn8JnUohYbSd4Xp0ETQOJL
 lIsoL3rohyGCZsfUjmNujyHu9Uz1Uo40WA+rqoQOz0596GnLFTIJQNHCqf76zSxudk3Q
 5R1fOKCEiBaJYYH8eNwy87DGG4zKwKbbNWeQorS8PoAdwd7kTLt1FAmJx6vvOOL6ut1t
 P7vCDMZCiTkxB12J+MxwWcBXlf8xY2K4Qb9pCgnRNBSKIXUUhBNn3+rPgU9O/aLnOH6P
 /XUEyNMr9Z5rJ2wDjpEVlDM9jvfly6TmpRgcptRJJm3/EHQ6VazeVNK1uY4s+tYkmmUZ CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjcxtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:37:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PLaRPU138002;
        Tue, 25 Jan 2022 21:37:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by userp3020.oracle.com with ESMTP id 3drbcpsdwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur3jLLCLDYLXMu6aae2U9/gMGhoLoIBKNYB2AruM1wt6iAswb2FWQub3TYsP7p9v3I8XMPcXjhQnhYyaQAZcIiQRROhJAlyLCRxR96F5n4YAfdOWpxUMF8Pm2J04pT+fuWGTZoL5XZOBN1q1S/iFqyAeTsVAadiuqzxBIDp9GoYQTq3DKVIyl0K5nZ+FTeMkJ9shZh2QhPVgNcqwSbikpXqiRdgHyX8zPP90XehHnNilU1xSA/xGZO1oWfVdtac0YY/j0Gz0THKmOrc7Ej/+lyYtXBsyE/35ra8okOgf7whG6F2avmdXw03J751vlSbQPdM3WRKpd0VK12+cvbfqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuSHzzTrktYAIaqsDNXwzKIRJRJxF7fUkAuPT6JwRuE=;
 b=gUHIvXseLQCMSu30po+0kZ3ipSshcSSQUB6ymr13PSwQPi6g7oviugeN+5gsFHsRLvJRDDhdi/7u073Z0sPyhgbKhH7VR4+Y08TvQOdBd047oVL9lhyV5XTfkfVpm0+se5moX7LNyAI9HXPDACckXaJVxqK7wUON3dSU0kGoic8wDP7l1Q8jb4hExW+UKpA/1FijHVZTnX6T/ICfARK16gcJbl+XqoxFvn3viuO7wlGn5Z3NJviJmpfxOmjjch/5brOBkSp3AmzzC01bMfe3VBG8/CkWwV0AJ7Z9f+wSv3ehM+Y8+KpvK84B6a81g0CYYEZWJnGHcj4dQDNWE7B9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuSHzzTrktYAIaqsDNXwzKIRJRJxF7fUkAuPT6JwRuE=;
 b=aIS32KS5B2eqhBQRQVlPxqT25e34+ekxzza+ipue+m3I11EWb/xjQpT/HwfKYCeg3UfuEmLpcaVqjkHi95mIOQo8KtJAPvKTaufEh9r93M3Clba0nSU5XyHlq+oyU/x9vZ3amrPsPToBD8aQcGru8ycSgNs9zsnrSEgWosggtu4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM8PR10MB5479.namprd10.prod.outlook.com (2603:10b6:8:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 21:37:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 21:37:06 +0000
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
Subject: Re: [PATCH v4 49/66] bpf: Remove VMA linked list
Thread-Topic: [PATCH v4 49/66] bpf: Remove VMA linked list
Thread-Index: AQHX5r/zsqb9vHBNtU608kZJnpd2mqxq39EAgAm6E4A=
Date:   Tue, 25 Jan 2022 21:37:06 +0000
Message-ID: <20220125213649.dlmtd6mj6malcbo6@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-50-Liam.Howlett@oracle.com>
 <57e33b08-f578-b84d-664b-939d9100d54d@suse.cz>
In-Reply-To: <57e33b08-f578-b84d-664b-939d9100d54d@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5443aeeb-54cb-4ae0-2426-08d9e04ad5c4
x-ms-traffictypediagnostic: DM8PR10MB5479:EE_
x-microsoft-antispam-prvs: <DM8PR10MB5479D2B427DC9AB393696BB4FD5F9@DM8PR10MB5479.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9MwGfS/t5vAtKhgM32EWX7nz1lVhlFNWKiszodFBzylTpTvRHRMvcrNgys0nm55TcYUpBKpVOmeGcadEnRDgh0sjOnuj9OZL5f3Ch7da7hVhYOult0GaIgJnvk6gGW/gk2KCEt5ER3lZtA6nQnt8sy59LLqLipOlA7nJuw9J4wO//Hvh8MatdunhJbHZw1h0ygfF8pxxHJQowrCSyIaa5+nVYGnFhuZkT1wTkg7fE0o5I2fLa1oQFFm3eLJQzwXMy+97FDb7s3ssXa5tQx2CaJQ+E2muB+VOoFvY/vMHoizNL993dMqeZSg4T0XJlPirBL5wT/IJ+Dx5XOqlqow+PVIufGW55WUAuI89gNTqbm9TmvlNnr50liFr6tm227nOjEyKFdY17hT+A9wIdToJGHsZbnKr4wxKK6SZHBBmwKiEGY3iMSkmCoSimK+AIVAxnjaWRhpNGKFPoMnNnxVjGtF/AcgWs0loHGgN/hnaEw4uKoERTj5pdoxtq6XOmM6oQIIqzfwKoB4OudJ3ZZH3jyomZiBASW9adHybP5s3t6SRzfIJBKGFsqi6aP6i+tmnYURRTnWpLo+LYXXSKEVIywX0viLtcQNzw5HN7rY9DkaZuNjqg6R5TtJ8b0M64zwR2qfSTRLsDWXjY9f36mfpWOc5KM3xCA26frUMkEBoms/Pp7ObkmRPM20HkR6dWESTNtmHYNWqLOrVwqH1/3OuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33716001)(66446008)(66556008)(64756008)(508600001)(6506007)(66946007)(53546011)(86362001)(5660300002)(83380400001)(38100700002)(26005)(66476007)(6916009)(316002)(9686003)(38070700005)(2906002)(4326008)(186003)(6512007)(122000001)(8676002)(8936002)(76116006)(54906003)(1076003)(7416002)(91956017)(71200400001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K4iiWghSXPUQ02PT/dRNq30RsFHyGkBVCn3b05bpN6hWaOLfXq5ls+NDloL7?=
 =?us-ascii?Q?6RxrI2XEoieVTE9uofNgOCE/CWuTcIpVmjjVuBD/sTszlTj7vftazxbXOZS7?=
 =?us-ascii?Q?HgF/C9CnLiHq7qN2Gi/uIXrixWi5rYUaupoWYNuS3AFRxMzaeEzVdaJ7JBfW?=
 =?us-ascii?Q?VZqVydckYKo2Upn9D1BhDuIijyBR4KfebRztwie7J7fyS+zseEOLLvA66U25?=
 =?us-ascii?Q?l87LCTxNJ/5wEF66lrtTLdEN/wGuvzXYo675Zrhj11nCQyYE0Nh3BlUHZn+1?=
 =?us-ascii?Q?+rnBb21rEZRX6dg+yJbXxkIzg5a4cfYhVX/MRG/tf77gMAREAevo9IG1lyqS?=
 =?us-ascii?Q?SnRKEb0brepdyThr116GnRbOCkOXB5IyW0aXHYqndERft+IctiJgppB72OmR?=
 =?us-ascii?Q?qLfAfcD3pdjzCT9HhUTUlwrxsDn3haza8/n+VXG2cm3XVNvi1ptHnXHryMEc?=
 =?us-ascii?Q?OXCv8CxSDc18l5+se2MpQslrNLIPk7bEGgChiNDhe5EguNj8m3JhBPvQ2KlL?=
 =?us-ascii?Q?LhR+VptIVCNubNY/Wox7B+jgvWrWrh9cbG/hZfnaMFN/FXmJXjmLDvcSrEIu?=
 =?us-ascii?Q?tE6g7NFioYbsBh6IGj0nELxd1rSlkYrvF8o++uc7B/zojZ4benVy2NIHjM4f?=
 =?us-ascii?Q?2oSVSLVwh+z4ZWG8B62LT46NTohmXfvd/xmasAVAz13C2cEE/lMVuwhcwEel?=
 =?us-ascii?Q?Vi6rjcOnD43/orgQsySaGheo6bvMjomEbQ/9Uh0s7jUc3Vu0eskBqXi0+jEQ?=
 =?us-ascii?Q?TorcaPcn9kTVfkAE92S8m1MqwJ15L7bNIdeW6Skg3fH/oHq2f4XA2UpMTAOs?=
 =?us-ascii?Q?chjMpIu4ZNzv749Vdl40+hDJLOCZrMb1z+1sG8KZ9fuHa65QHABaauoOf/TF?=
 =?us-ascii?Q?hMyTpm9ABu5gF42Xjw0SmAYZXRvI5zkiotNKwMMHkdVWYtflciE/jRsGNMzN?=
 =?us-ascii?Q?7ymgd4kwJAs1ir3N5My3gseFQg6zscJSkP9x9woL66WODidNZF67FupKwy54?=
 =?us-ascii?Q?o5OhB24R3f5sZ/xFjl1E7btfRmPZcfhgJo3c2riItCsWqIXYOXofNNpvQk11?=
 =?us-ascii?Q?0RAmDQdfoeoD7Hs//ATXKpyQHdwDRX+JsDN6I6Vp6UfdB92cWmmC6ceoRZYt?=
 =?us-ascii?Q?Rgp8BMCMzDqDmb/487aluTLyrhLEfEiXKtivLsk7Ii6JW8FG7J/DsGRklHKb?=
 =?us-ascii?Q?cWdRIfbHYodwzhob0eGNAwxELpIDrF1mlpZMyoG+FoTxzIT9UneGkLxY3R/z?=
 =?us-ascii?Q?ddRI7cKhMDyVFjNL2sQ0J5w5jNmOuK8qy5dlXQ/R2mDa6P6JAeZ2idDzFLiN?=
 =?us-ascii?Q?Skd0G/JptnPpT3CaFYCPg8JXa1lic9HvjzQfJFYDTJ5QoYoeTqC/eBR7Xaa9?=
 =?us-ascii?Q?RJW0EvRNbPWCr0B/KMaP8Hh4nsmfamUSKB0o53MIaQwVa0Jqu6RkYHa/6+Zh?=
 =?us-ascii?Q?xSGnZfSQbsYiDzqDkfeHeIN2CAbjIPaSo59XwW5Y7RIWhfxbDUJLrynjnFhd?=
 =?us-ascii?Q?oYZCqc7NdO3Q0lPfVDHKllQiE/TEfVmmVfHVygqCBHg6YZDB2l4RODmZVBlu?=
 =?us-ascii?Q?JInykPYmuc80P2+DKIeY/sDSNdOEs0f2D/L+MQOwJ9P/GfFy6zOeMIUf4Zhn?=
 =?us-ascii?Q?ixdByiw3RMNFQCDUmJ2NC+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE0CEB9CB32D7E43BC3A8729B8083F7F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5443aeeb-54cb-4ae0-2426-08d9e04ad5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 21:37:06.7145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5R6Djdw0Wav4go0OVbxmOMXY8qiXBOFpYBLvK7u5Z2RJAg5psduv1O9i1KyawdwTpwHsXQNwCkC/r8p1M110Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5479
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250129
X-Proofpoint-GUID: e5JjwMnroJKavYISZu0SnLXr-N31-iMl
X-Proofpoint-ORIG-GUID: e5JjwMnroJKavYISZu0SnLXr-N31-iMl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220119 12:05]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Use vma_next() and remove reference to the start of the linked list
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  kernel/bpf/task_iter.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index b48750bfba5a..2d964743f1e6 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -299,8 +299,8 @@ struct bpf_iter_seq_task_vma_info {
> >  };
> > =20
> >  enum bpf_task_vma_iter_find_op {
> > -	task_vma_iter_first_vma,   /* use mm->mmap */
> > -	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
> > +	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
> > +	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
> >  	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
> >  };
> > =20
> > @@ -400,24 +400,11 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vm=
a_info *info)
> > =20
> >  	switch (op) {
> >  	case task_vma_iter_first_vma:
> > -		curr_vma =3D curr_task->mm->mmap;
> > +		curr_vma =3D find_vma(curr_task->mm, 0);
> >  		break;
> >  	case task_vma_iter_next_vma:
> > -		curr_vma =3D curr_vma->vm_next;
> > -		break;
> >  	case task_vma_iter_find_vma:
> > -		/* We dropped mmap_lock so it is necessary to use find_vma
> > -		 * to find the next vma. This is similar to the  mechanism
> > -		 * in show_smaps_rollup().
> > -		 */
> > -		curr_vma =3D find_vma(curr_task->mm, info->prev_vm_end - 1);
> > -		/* case 1) and 4.2) above just use curr_vma */
> > -
> > -		/* check for case 2) or case 4.1) above */
> > -		if (curr_vma &&
> > -		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
> > -		    curr_vma->vm_end =3D=3D info->prev_vm_end)
> > -			curr_vma =3D curr_vma->vm_next;
> > +		curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
>=20
> Are you sure curr_vma is valid here and we can read its vm_end? Because I
> have no idea, but lots of doubts.

I am not sure.  I'm going to drop this patch and take the more
conservative but safer v3 version.

>=20
> >  		break;
> >  	}
> >  	if (!curr_vma) {
>=20
> =
