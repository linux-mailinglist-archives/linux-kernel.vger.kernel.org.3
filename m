Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45EF491281
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbiARACJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:02:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47830 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231768AbiARACI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:02:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HHmmZg007155;
        Tue, 18 Jan 2022 00:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3iw9ef3uzli9xhuksER1xtMJOw4N77TxV4eDSWw2wDo=;
 b=RSZvVJHi7bg+gcpORzdymFo1lDvFHUXDtE3ChsWK0ovwjscIKnyUdV46ItbJ5/B6Hm2E
 /CxpVcH7YuAWw+Ah/l42X1vri7Q64CNIPgODg27Z09Fv7M03zP7X1li5BPmp9c5YTrpI
 asFCSyrrKTQoaUwlawT/1E6vEIc4jKaUJZHEQpOZQGcRYjn8nhaHP70tZCyzdMJuA8oq
 GaBx6bzH5nrLt3ceZSNbLZogQLAWF1wbY1rwI2p34V3k/gnVvfF7xl5otMygUok6SywE
 ro1I3Tv1R2gSwIcqpCP3kLvIqvolhd5NvfEObTrKicf72G/8oA8sh1YfRIjltocWPeo8 YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc518hgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 00:01:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20I00Vgm015029;
        Tue, 18 Jan 2022 00:01:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3dkkcwaudr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 00:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmAnq5gBck/TEJIx9XbYcTc72gg+P0oJP1KnuX23+JFsslLDCDT2fcivaYRaJDMwVuHRsh6rSwM1t5P8iVFbhZIUL+Z4Lr3dWQQi2Lgfd+hcEE9UP7JZv2jdndAiVxqupUWpVUDFRUQ4Dlf8ylucMFBti6fgyQv5HdKaYaRcxAzsaRLyFHzgNAx6VDWJZ+LH+yS6oaSO3jzDnuNAjDl7RAzNT5YerVrgaDVKapYranZ1mnf1tzrdBW+hhxfef1gySyqdA2Qn+DFyq0pDcG69s5OVyppwZZJO29aiw9GvFzvSumW8OsoDWTI5w65zuRlFe2GxgALaf+gb3AZ+QeOQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iw9ef3uzli9xhuksER1xtMJOw4N77TxV4eDSWw2wDo=;
 b=Xipgvm3ASA873UP1K3ZWsKORlBgnRa8Tg3R+NKsVz3WgoKrAw4dPM/OnFsBg+8zzR/KKWWGNZSqu/c8k5ge4W/0ezqUFeSH5fdBfqeoPiUdi9WTlsOgDlARIxTQuv/i2YPGduRHPAbWisgcsD8Jw75ej5VCFF5vIoxsc5OYvSYvLDzCIMYYq7mdNBrLolICcP0SeHneAfAmb2IlKBv7o0MqILuW8IbI+ihmmjDAlA+JWImELSTaKa9Whq0qRb30qFo8ysrdB/wynhamM8dUptEhhFi5vCqA3UiOnjtoo/siywrfAJW4aA4lTU17odzUva/aXiBnWsCFITxIpsq2/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iw9ef3uzli9xhuksER1xtMJOw4N77TxV4eDSWw2wDo=;
 b=C9n+sFSwzGihTc/A3rJCDA4zPfRRABQny1/MgqcjLyQeSYJOyqS83gZ4BT1tKATsf0MpUjQIQnwnuCSCrjDYAjYrRQHab8Lhs0XgE4cRkuMLYYbdALLGK/YR3AyAFWRtSLO0W0Qg95Won5FMCIzGz68zX/KlOaRDDzsjve/wi7k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2462.namprd10.prod.outlook.com (2603:10b6:805:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 00:01:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 00:01:37 +0000
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
Subject: Re: [PATCH v4 18/66] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v4 18/66] xen: Use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHX5r/qjpp+0jgwaEOlnE/9u8ULNKxfzbQAgAhh4QA=
Date:   Tue, 18 Jan 2022 00:01:36 +0000
Message-ID: <20220118000128.rxh2eb7mqr3s3v7m@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-19-Liam.Howlett@oracle.com>
 <705ac4ab-34fb-e60f-aceb-d46e1913a28e@suse.cz>
In-Reply-To: <705ac4ab-34fb-e60f-aceb-d46e1913a28e@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c437f23-425d-40a2-a33c-08d9da15b260
x-ms-traffictypediagnostic: SN6PR10MB2462:EE_
x-microsoft-antispam-prvs: <SN6PR10MB246257715DD02DCA58642860FD589@SN6PR10MB2462.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JO6IOju7lLCw9/eIELaAiq8efwe5srjFj5ounKZiRIWuT4B93rhWOCk9PHEWrUQR8GF30T6u9gsS1y3OEnxtWmwtjHiV0gyGxJHws+Fz9xjhHZC5kocAr6WLH3Q2R3mwtuxEtUnCWnDxEv9NFAU9g57+7G7fMXNf3X1lJ0anpI6evWGEOPwiYS3AeFWCfy9zoC4QLwiLXs7uHmc8iOYz9go7kpEz4/AEW+dDdG+NzEA/7w6ZbHvR4gSg3E2bIoGspjyNuX4KzPKgeaLY98xGC2tE9FQEpoOuxMGUhS4TNCMaX9MWa7BSaSv/bZW3QnBr65fwO4ZhZM/Pefayi7t/0itWWz5yBBh75YGkkmXdysZKLIwHHQtNFMnQ8o265MSwYwv7kKYOkI4Jv2cPWpWaSRzZpzHWNOQphMsBIVZ4tKZ96DGYe1OMutchjcoxtQAF+a4WwjxcVs0jvXGLfJM/genn2ytkUPIhtGRxkOUzBaMgcVHHTOB8I/0xOlPBeS7nA3cedJ40yeoes9NdbyBq/COqW13MisXVNLq0ML8iwKWzUsnM1TY07KFn3K9kwM/ehhmpmh1RKAPV5fMOWl7qo/rgyzyKdY5TSxN3E5erDO0ZcGkhJfOSLjAqPdGqx5pfDbuf0BKHTvLsxP40EYVzYd3+E202yilDbL9RCH++yKBCOJsJBUWPpQ6cBqAcBgghO+G1ghDw+by0MfzmqElMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6512007)(508600001)(66946007)(91956017)(76116006)(8676002)(33716001)(7416002)(9686003)(8936002)(66476007)(4326008)(122000001)(5660300002)(1076003)(186003)(38070700005)(6486002)(44832011)(66446008)(64756008)(83380400001)(66556008)(53546011)(6506007)(54906003)(71200400001)(86362001)(316002)(2906002)(6916009)(26005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VITl7wGPc+GwQ0d9Pu4nVyUdwDzkcvUeNTDKLIyVcaUuOfOWRsiNknSTJJYF?=
 =?us-ascii?Q?x6blnMXnlDF18lejSzhGdiXa6SIRCFgT2MMTIYyyXgBiSX+JLhcLzjA1cBOs?=
 =?us-ascii?Q?LCsxzhLKoWlnYpcfltMlsgxTeQqv7pka9YyyUG4MogIWautwaZ1/6LfmNcSi?=
 =?us-ascii?Q?GJc+bkk/LB9Qv/+a7Rp9jjCBjs7hROk/6KENGZ1UlWN0BM4Z4IqS/MtpvwHl?=
 =?us-ascii?Q?6XjseFIQI1SbVIEDbQKB14ydLtjqPwcIFbZ+KozDcjhngb0KSbwYCRkStXQc?=
 =?us-ascii?Q?ldPJGTjiNpwC9uGpyeiliys+0S5SDjvbLPMVNy0r/CjjrMpXKkJGKlUF4f9N?=
 =?us-ascii?Q?REpIFKFuq6fOifvZ8KtydpOHexQS0ONHn7yoJf6RQXxXFYSHMNTxRkC+h0vp?=
 =?us-ascii?Q?pkTmA6cgRuAHrTDO4ZeyfZIF6DvgxZlW7mYYMOtdBgK12aSg7qU0mSRzhh/8?=
 =?us-ascii?Q?7pNZkkXkn0bgDp/lpMUvD7XUft2lJkhIeEY3tQRRAif7COWC7a0HB6nVA0YH?=
 =?us-ascii?Q?ARkkKiXHBmr0BUTnkwUKXPTq6UOkLZkvrG7jAurVbZoV98C3sai2KFEv33h0?=
 =?us-ascii?Q?vP21C9wpcqOu3NnXrwZyzO2Q6AhjB555Tg90m2OR9vxyoCb/Kn/6nIdDSYOb?=
 =?us-ascii?Q?hwlMeIyILc40QASV6OLwg2JXDd0oz8615UpgMZedzLfGZmWgIJN7KQsBq9Ta?=
 =?us-ascii?Q?2Pwug0LegJ6dend70WBJAUq6tvzlVnDh+7V9BFOXyaAglBxLbed/vBxXgz8o?=
 =?us-ascii?Q?M+ewtZp5LNqpIGKj7zmWYEdhfshA/638yWbddzM3auGSLAoMbuP43Pcaq83z?=
 =?us-ascii?Q?JsbEwiADBA1O0SfUJxKNVat5q95JMOhSYdLwhvlN5s+C2VYYW/UgwaSDbVQC?=
 =?us-ascii?Q?myI7tJPqyRsum4DIiQDBYPEwVHfcEPa4VG5XfkdBaAVFl0VM6P8TD+eNCkPP?=
 =?us-ascii?Q?YwvOUX5wFv8AFXBF3cL35Gg7QEW0cQM+JJQkIKqG+UGkuECmb9Xo9R5zSZ7D?=
 =?us-ascii?Q?ub5CNwFjvULkOL8FhXRsEZZpJO0hh8v6Xs/JZHvtnoEywbtijgzxEBtVSwzx?=
 =?us-ascii?Q?x88ksezuac6IvpqPLZp1ddVq9DfT3KTXZEnnLHsggvZSCGjttIRyF+rDNX6l?=
 =?us-ascii?Q?6VYc5FsIXBV2JGnO9CBoLxYhWTo8sAr0pVrj5nVVlHsFTLPYlvxNthnaZ2DF?=
 =?us-ascii?Q?/G9+VYQidoAOEYP+F4F7Nb/3CJx0OrcWa/L85Righ9crqo4UvyLk/ha9ESDg?=
 =?us-ascii?Q?LtwjyJnB9UIZYMgqC6OGOjS9Rqh6Qjn3Cbvqexwc8oFN03jnN064Aznh8c1L?=
 =?us-ascii?Q?P7cRCMLrXDykk81RodbNzHYAhdqRY0WbtHh+XpJB4HMjyYNUAbnRhv8+j1jA?=
 =?us-ascii?Q?N890WVTqCMkg1dHdBYCpkZj9+LkCSQ0bO7Lh6jq3t39uqxShLJMEx7ZPpeiR?=
 =?us-ascii?Q?n249pVtKUJ0y/xU77kNet5xn46u17IX70LP04evbWBNnc2X/eFMh06/pgQQC?=
 =?us-ascii?Q?MPOdYIvkY7r92AEjZOPjdIulDZ0DOx7ma75KmO4K9Q+yfE+qM0w8wlavZK6e?=
 =?us-ascii?Q?ss54NLINQR0JyxkZfB8Sog5hYBxHOxxphwQwnKXRCuTiBajj6JqZXisv+6e8?=
 =?us-ascii?Q?c5kLO90lE5J2BEoqowA+Sig=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7D8F476C2DAC44DA18A7C24816EE7AB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c437f23-425d-40a2-a33c-08d9da15b260
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 00:01:37.0700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJzkI6wNWCtH659LSQQmKM1Uyw5MwWAP6vt9slvQXqHhM/nZxGgHBfstP+H0u2Vwg56DVWKs58/0w4TvSpW/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2462
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170151
X-Proofpoint-GUID: 2NQWxgZ_WLY5DwvaWeOSzPGBkvlNGKf9
X-Proofpoint-ORIG-GUID: 2NQWxgZ_WLY5DwvaWeOSzPGBkvlNGKf9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220112 11:01]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > vma_lookup() walks the VMA tree for a specific value, find_vma() will
> > search the tree after walking to a specific value.  It is more efficien=
t
> > to only walk to the requested value as this case requires the address t=
o
> > equal the vm_start.
>=20
> By that you mean the privcmd_ioctl_mmap() code checks msg->va !=3D
> vma->vm_start and thus we know it's never interested the next vma, that
> find_vma() can return if no vma covers the address?

Yes.  I will reword the commit message.

>=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> > ---
> >  drivers/xen/privcmd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index 3369734108af..ad17166b0ef6 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, v=
oid __user *udata)
> >  						     struct page, lru);
> >  		struct privcmd_mmap_entry *msg =3D page_address(page);
> > =20
> > -		vma =3D find_vma(mm, msg->va);
> > +		vma =3D vma_lookup(mm, msg->va);
> >  		rc =3D -EINVAL;
> > =20
> >  		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
> =
