Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD8464FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350618AbhLAOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:39:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38562 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350018AbhLAOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:21 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDP4Y010062;
        Wed, 1 Dec 2021 14:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Q4b6QvIyY/MkFIABagamn+H2rp/KDrDlE7Vj0WkxI5s=;
 b=AlnmNQUgiBq8HRVIosv17MJxGMfEbHGYXrs7V+U+RF7uYILBzyjHjZ9l1H+zgmBfxDYm
 77lHhAiLR2WH6RqfW8yukbcBti8A5aqSIRL2PBxerqox04BVJeKSkF7Xx8jTErtGYAAP
 AqdKacIL1dcM+r1ebEuN1neum7FB0YatA4ockC3m8SWUC4gDVdNmmzLKo4ZfVVmp36Gr
 CfuTFvi6cqL7icPTS879gao7TDkYm1nBXvXqeaLMpP7xm3oRDKSBr8U+vQW6WFVptJpY
 2M0m6FIO2bDEszEK6a9Q/kYYoMgqfBHu/dCTccS+NnMezTthP0chykYvwYjyY4L4NwAN xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPU108922;
        Wed, 1 Dec 2021 14:30:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtPBtXO6s58o7LsjnegQBxkI/iqqEcY7Nxa2HqcmFk3vfWyCU5RzIDofnkcvIvJKjDcJnwxrbQYzoRsILaL2gwUh3UPJ+lJsmU6GssDMcMhm088PV0AkUUYWmJXlvvY4AEED7WJS9Je87PFozv/IZo9VlH/hYFi66nTNtMB9qzrY5X1Th7VtThMEJirf1/bKBMY3G0wicukYMKa1Jz9mlgBC/jd3VUm+P5jPzd3ocioNtxW0XfrvOIAMOprWxvdz0NyRmD8m2IFeJdYhqM1LMwTaMITHKqcmTRDRIP3h8MxBNbpQYZt88TKAFvni6lC56HeaMaNTK8/VKR8Gv1OHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4b6QvIyY/MkFIABagamn+H2rp/KDrDlE7Vj0WkxI5s=;
 b=XcEdmQmq+X9ndNjJVeYVa/BcEgaJmcIu19oTZ2/sISCz5cvFcD5vETaErD/AYaGDK/cuHoZxQjZ1t6elZlbEeKKKLCIx+gbObdegmA01sbMxGdAryEkIkAg9DnupdNqM0kJXGKZimE+JDN5CaEsWQcXB24ePK+0HiBKhyEuSh9u1+cBcXpOJ+E8Z7UiqvnbJ8xbfcZCCVQpYhU+E4JfaZ9I2jh+dwAxDE1Qo7qQlh/LJRth8dOkvFrBF1fv9DbbdWGP4qnwDVSjGMBTRujC9yYFVgjB5bbUDRPIIbZoZuqmUp3ybN8GHlHH93zQWm1c801zhMQDX2rgC9XQcKvog0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4b6QvIyY/MkFIABagamn+H2rp/KDrDlE7Vj0WkxI5s=;
 b=lJiXfTZ5Tr6EJ9Rykd6lbBh+BZC4pnyzgtbfFWKMfjwNoVvKj1mInU5dgInq/GXkqHw7WeYeyUBh8nnxuVgtyvwPTVmvuV1P/HQo0krmcRJnat84vhFitbAwu87O2Bfa4fB5RPDyFQwJseQpZdj70HlS96iv/ig6XwUjy+r8n6M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 39/66] binfmt_elf: Take the mmap lock when walking the VMA
 list
Thread-Topic: [PATCH v4 39/66] binfmt_elf: Take the mmap lock when walking the
 VMA list
Thread-Index: AQHX5r/wBRw8/eAyxEKQw67sBbOung==
Date:   Wed, 1 Dec 2021 14:30:08 +0000
Message-ID: <20211201142918.921493-40-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c7eaea6-5e0d-44b7-f5fc-08d9b4d724ca
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508A30579ED0698B0624734FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNUMmE+Q1MCjgpCeRBLCUSWFo08DOm5YPMLkLbWTzldG6m7oaVXWcj3t11Ex4z21q8IriFCKioRCzlaAhT+gPSa0drlD9rC/PFpNgpbfehRZOUuvzSlXjnF2CPWt5te0vNhAORv1yjkqYuJRvmvfxnISEejJdAnxiIwntp7+G+Gc5aoNOkb/BLWLe3g0e9wjdCqCQYdKmCRhhHyIriAQpPu9LQXjBanJyFrYxVh7OdJXLFZAyeLIcdiPeK5EPySr3o3WQAOBNo/zy9Y385/14mcZnzwhe2XW+8f6Okyb2DrY3oOKSP2fOCkUHvH2i8q8vRYV/AMqSDdhgLkL36/viU7TpqDiFPzdzGpxYh/4CgKFT5laKZLwTErJo8360YgjeWy1OI4er2RxEiByr4/28fuBgIhOM5LPKPglWSj+7dNVjYX3zar+IHtOkr/ZtdvHBDBqu32uaS07Um3yForRV13vO543Qrn9wtBVx6jBCjsBT+nFJqr3cuPl2TcXDsw+YNVrokbXXxkYBm5bgHEEWU6UwS/e1id9myVT5stkA/DSqnfSo7vULgg8knXQoiGrGZg26YaIrpnX9RDUoPZGKKIHGeTGd566py5EViscO+YwSODR1IHEviWMLsd4i1cjNmKmJEeDXsZniXDOPsP7v7aAu1cClKgHck/X/WgHU5hqrWpysllgTCaE56iB+71rxIXoYi2t1IJr/R/3cnqIEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F/gWjr3Fgi41jfDDubAaA7MWbqVi9EHILmHEkseVqgA21Yj/XnsVVuxTQi?=
 =?iso-8859-1?Q?LkhfECAVDqDMMvUCg7YN/SaBHBBNBMnUy/PbWCB0wqz/shuf3KXzq9M3sw?=
 =?iso-8859-1?Q?4oyoDTRm7rGQnnadMhwT5GDzDLWCt3FgvskJxSsM6RI7veMUSCmUGFZa7R?=
 =?iso-8859-1?Q?f3i/E8nwAneiGdId4cY3SdMfmjCEb0/WM7Blr/92pxij/foEJLUtr/C3e+?=
 =?iso-8859-1?Q?wOs6z8b7UVPlvu3AidIBSJeEiRZ3hpxXiNGW3nnmtUVTOaurTiJ+Ie8OQ3?=
 =?iso-8859-1?Q?IqHxJouAROrEYonDzPKBbZwt9J9oLncq94xB+5yaDzoNIoECedUD0NDMVf?=
 =?iso-8859-1?Q?EAfcMaVIGk9lpQKFBg488mAR4jDUyRybXE+ENf6hQXDNyzvAdNQpJNb7FS?=
 =?iso-8859-1?Q?ohf/VcNm9dFHHx7R3q+Ob20CAIuNtJr3Rg/FtDQYiCfIJxlAWVfK2XAbEM?=
 =?iso-8859-1?Q?BViCteqq8I1rduNKTRC2G+2272b1egJH66f9bzVEKRIhRmiCNIJXVUL17i?=
 =?iso-8859-1?Q?2YVKsNTs7kuxIuHuZyzT2uHsv63SG1baMSwv79dgV6e8R3Jll0K4Gd4tty?=
 =?iso-8859-1?Q?XHm3kU4eyuVICIIJRLpDdgCFJQwSBy0bwC5jCLORhYu4znnV96PMDq1H/n?=
 =?iso-8859-1?Q?+TZg/JWtxCPYAPDBMDYamMIJr4UvuX/mAF3tWsn9CyjlQvVM7x1GKWSEHX?=
 =?iso-8859-1?Q?Ybk0xa7RACzugKMC2RbA2/ovw7kbYh7wBYju4/lImAYJCfV2m2uHDAwYy4?=
 =?iso-8859-1?Q?k37f0eRqwd3x1Ly3eYO/znqCaNzPGi2WDxo3mE14BVeUr4/20nUefsxR3I?=
 =?iso-8859-1?Q?MUbH4eo82fDJU7+nlNzEhdQuGkAN6yh0Wmbclkvd0Lv+HccTabPJaqKEye?=
 =?iso-8859-1?Q?Y1KSiwCEG9JcTCHSqymBJRqcubZTUoEbHIRpMJ0vDgbUK/UzPwUAjC8Q4R?=
 =?iso-8859-1?Q?eoX1YSBr5JIHRK0YK5zX8E1ABidOkqFnk9ba9idsVW8Zv2keTjLUxYG6nv?=
 =?iso-8859-1?Q?c7MvpqQhKbBvN9XT+B03hL7eXiDODBodgRwbiw5pjoc8WuK47aZD7UPAWC?=
 =?iso-8859-1?Q?4Ctdd3XzmT1gR626RprTKA7tIqMAOgan+q6cCpIRmMKDFfx9wFJw87ZGW8?=
 =?iso-8859-1?Q?EmQUZSBVDMp89zWRdRF9ghOprG9usFKP4mGSaT4idz3c0kKdoLbZDMvh/i?=
 =?iso-8859-1?Q?RjNGXc7xL/Ae82GF1zaOMgTyr/OIHoxSXepT3EQ+60Jut5VcT87ZwLsBQL?=
 =?iso-8859-1?Q?OHYEjkQTAIP7g1CO2v9g7A5E/wcUyN7UUhG4epTkK0GpOUI7wc5mgVm8BV?=
 =?iso-8859-1?Q?sk6E4s7XUs/CGxU4eI5mWEDBmRIs9vOdh/P0lfAuF2DNy59TF5KKU/oUtW?=
 =?iso-8859-1?Q?Wfw1ZHArWkc/t5eHKmk1jjVQsyyHaCykD2GwZLwZjKjybYkD01HnVo+2VX?=
 =?iso-8859-1?Q?THwvSUbrp/Hgy0nF4nvgH/yaTcnwIfR8pC4tVsYjTd1941K/46rkFiHs0i?=
 =?iso-8859-1?Q?PbzEtIzBneBD0P6JSG1H8ucmWqcC1/ZAo1sMUKTgp8nqjariW0g0iHdPjk?=
 =?iso-8859-1?Q?IRyQ9USHKccfum2Z3ftn9cdeX+q+Ewh2cS2hQ6vaxgFJeJ4hmWvhyjOeAK?=
 =?iso-8859-1?Q?Y0MM+GMXDZ4mjGydqEBZ0z3AtiSwUWBJO3kSAXc2P3eSgPv6IaJoue454Q?=
 =?iso-8859-1?Q?tY2S+fEcMOY51Rl/yzc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7eaea6-5e0d-44b7-f5fc-08d9b4d724ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:08.7001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /92kTXRVZ0HyzfRwxoO2NwMGAYn8I19mwOkZPPWDftbk7IbXKBxiJCJd91kNcD46Zh2HSo3r8BapVUg2mxDN4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: LgCvU59Q29ruCOtUPqSdgZjuFK2FD1-r
X-Proofpoint-GUID: LgCvU59Q29ruCOtUPqSdgZjuFK2FD1-r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
is very careful to take the mmap_lock in write mode.  We only need to
take it in read mode here as we do not care if the size of the stack
VMA changes underneath us.

If it can be changed underneath us, this is a potential use-after-free
for a multithreaded process which is dumping core.

Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contain fi=
le names of mapped files")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/binfmt_elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d41cca755ff9..5915518c8a1d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1652,6 +1652,7 @@ static int fill_files_note(struct memelfnote *note)
 	name_base =3D name_curpos =3D ((char *)data) + names_ofs;
 	remaining =3D size - names_ofs;
 	count =3D 0;
+	mmap_read_lock(mm);
 	for_each_vma(vmi, vma) {
 		struct file *file;
 		const char *filename;
@@ -1662,6 +1663,7 @@ static int fill_files_note(struct memelfnote *note)
 		filename =3D file_path(file, name_curpos, remaining);
 		if (IS_ERR(filename)) {
 			if (PTR_ERR(filename) =3D=3D -ENAMETOOLONG) {
+				mmap_read_unlock(mm);
 				kvfree(data);
 				size =3D size * 5 / 4;
 				goto alloc;
@@ -1681,6 +1683,7 @@ static int fill_files_note(struct memelfnote *note)
 		*start_end_ofs++ =3D vma->vm_pgoff;
 		count++;
 	}
+	mmap_read_unlock(mm);
=20
 	/* Now we know exact count of files, can store it */
 	data[0] =3D count;
--=20
2.30.2
