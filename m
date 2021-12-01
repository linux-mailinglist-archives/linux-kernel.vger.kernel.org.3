Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7A464FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbhLAOhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:37:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58534 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243554AbhLAOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:59 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EP4nS018222;
        Wed, 1 Dec 2021 14:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nwht746B+aeUzMQMhwPtP4jHBJ+EWkfGiwdm1BJb4hg=;
 b=QZrDajPWCnnWJlvBz8b2mjSJ0JI7ibnflZTMQwsjZtq/wOfAdCpUT80uXELeCEd4dEdm
 QTxeMUff/kIifRmIl9Je8W2jHYBpahAiXdUdUk7jNu63Vggok3OS4ycIFn9zRjCT2ZZp
 +8q+CRgrnVaq/AyOhDMCm7JhMa/PmIVF2SaVo+/gmEA0deHL0s0WiPquUv5u1e7jtvms
 hLEFF/mgQN1npEhBNTGmqg3IXk5OdtX/9sQx79zsCdxAjirvtEY7U/NmpRrBttWbfvF+
 7QuRaVK5JIO/VyUysw/bN63Kr0ZJheUBI3svGjRaRsD0rh4RQ/ETIxqHTy1POe7ggpWK OA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyg1at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBlwX109866;
        Wed, 1 Dec 2021 14:31:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3cnhveqdaw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrZ6FX7+dxXD4Pnpq45hoXRoixogBmPXh6E30CRxh3aNhOCC893kxZ8yn5LtkZxv1gOJ5/BPMjh007c+oumDb99jJll6JAhdi9jmqtfFDyB7cMWGTF4rUj2vUiicp4k2v6I0EXmIvDmXYiSpNnJ8ZvhStwMEr0+wT4m2tsIYbE/CAxwM+c2BGCFdvq+w20Y3toEDQkF9ZdjU3KSqUop34kNTkZCX7rVnDZ3eXFxITMf9F+bhf4gAfetUpWIO0X1sG4r9wpi53JHE9LRH72h8x/bvHPmo2gFj+i57jDB3ze2mMbZL61kMJ1MJvX2gH6D5h3LJ+pS5PnULAnfTxnU6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwht746B+aeUzMQMhwPtP4jHBJ+EWkfGiwdm1BJb4hg=;
 b=BX5pbK9NW3eQLJ8sYerO4R9wdUVs+tWDM3mSI06YuXDlKhS5r1mfxbXKLo+6lxf57hSFbzdNsHv7z8Wo6RqQNGp1uP9q53teJIcrD2u+TXHoCu7j0YV0p0S3jYxbPQ8Xf/Do8mH7PKKNyOnmDxRFszK+8mJg/uiK+EkjrCPnyer0AFsOWKdm0K+FUYdsWJaQMyHZufuBk1fw5dE0grkEAkmCD11Gkta93liFIv0qERS3tjov+74lW8hiNGeIgt2KRiR/N2NQGvFuzdx/TsAZaITuit7Q3CKlTeVF0gCxHAO0rg/pOQFLvy0joel8pwYcLrubYezqaeak8luPNXuh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwht746B+aeUzMQMhwPtP4jHBJ+EWkfGiwdm1BJb4hg=;
 b=RXxm8EWYH7GbYATf2P0Z8iSfEnVol5gKr7OzcnGCK+Ovgbacs7eWGnn9glTfO+30LpTJyjG58vgTq7Vv92X1tKANGWDuSDLhDc+7PFcvCC6HXOJPps64++vr7KoLgg5KxqyTds3MCELJ+fjTT6u3YVf+XJ8ISlHQ4eaxoLC51Ak=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:31:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:31:12 +0000
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
Subject: [PATCH v4 61/66] mm/pagewalk: Use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v4 61/66] mm/pagewalk: Use vma_find() instead of vma
 linked list
Thread-Index: AQHX5r/2ZX6zv31qSk2BqIZFE6+7iQ==
Date:   Wed, 1 Dec 2021 14:30:19 +0000
Message-ID: <20211201142918.921493-62-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 790e6b0e-1ecb-4963-cdf2-08d9b4d739c6
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB246455ADBBEE13658830654DFD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gCK12KqUjj+FRk7zxKK1dxjleh+BF7EV917zxyrYG4rcAlGRofB7Sl/PcMkGSwx5z99ON3kpiEGzQWyiHhHdOAfUtrJcclh16v4+9qZ0Nvb2PgjtQblIAI/iFj3BerTSHifG/k4iW4DYO9BaTnfDtaidqlSo0xXwA+GY/icQxcPstShTBPL3pQL2AOcMwa5pqWKKa3ut7e/LZWLyJmb6Q+kasKH4by8UWEz+mP/DSPrgol9yk+1HeT8ZcAI6L7/LuVUVKWc056rvIRRlO5JdbcuApqcnzg4kzQRA4vSBXVT1dUG2t7tnxjAFhHdN/UaocoQfiE3KYSZH0O2Ax6DCrqdlPqeTXC2Djz8ElmvodsyoFcE6tB1JvwJU6OS0fQctssNebXdXXpFZ1a6yXgE+0jVG/udWpyf5ftBm6VBS8aKGZzs5KJbxl6lywkEKrj880vvBoiuV3fGX9jXqMywZnQS/+6vPnf+x1PJ/oLg2ySOO4iSDwbM/+eVQleWWREHvT19+s5W7YDzn5jU9z5316on17z2IkyBIbFqacMVf8jBg+Dkj/Z8Imsp3IujRxDJjDk2KjfpFZXTtpNpCQdiTnO+qqadWpMY7RKY5KZQEIiMAQjgtiUC+BR3g91U0jsXlxErdrQ3IP/opXvPgBxmRrf3WIzAGoSdCRWLozhgCWC+tR/bpCtbEv/hU0zcHHGsG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(4744005)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2/WuSNT5D1LSEV8nnKvOOchIsVM1MDuV0Kv4pdCjKBLj3vi1lO0Iur0Vqj?=
 =?iso-8859-1?Q?SPYCttFoGiOGogDN4lPvmK/uieyiluG4H+KbtHHylOfLOZ9xHXRukQrVFM?=
 =?iso-8859-1?Q?uZhUQd6AXmIRjLs6lMrdZJbFzVWph7lZpG4cpq0aqgthC+cWNKLuVvXytx?=
 =?iso-8859-1?Q?mMQQh0PVuwDM2IFCYBZ5Db9AkM357eOSnp9J/+2AUHt4eUDQoB8mAHS8Fn?=
 =?iso-8859-1?Q?IzUs8ll4N9CmuNkzajVqwIKdSwpHscVmORoR5lYTuQWJ2MG8pcxSLFkBJQ?=
 =?iso-8859-1?Q?001+hbcTW/8YCPB/dm+RjVxIqOCecJYC0UIPRrYNQmmqO5NaUqEq37fEjP?=
 =?iso-8859-1?Q?WZWpYYatdoSCvWzUIAOwlwQrpNJhJNTOfpVt5VB5J+jO6wXVomIo1prudK?=
 =?iso-8859-1?Q?Iic91QnbWwmyp2DiUS7elfyNWqk/Z8KjlY0bLRMSlEo57CWK74TvESYwwC?=
 =?iso-8859-1?Q?EXrPPFB7N0j0kuMRk0hzqFBFvbY32++lhdgD3OrTeyUpkhUnqec/7zenlP?=
 =?iso-8859-1?Q?GcRz9lj8RTcoArrBoFgbolAhD8zd3rZe8kJ4PbDgaI5R/25Y8wm2MeDPy5?=
 =?iso-8859-1?Q?OUd6GYesIZTHR40jomaNEQBgTbfYaqoYIr1eNdF3rrOBh5sl53stSF2phi?=
 =?iso-8859-1?Q?g3aQHP1g4s9AvCvEirqUIGZzp8yzmcnOotTa7A+2qgqNkmcKjZu38zp/AE?=
 =?iso-8859-1?Q?JpnaN1VLN1g+5Kgko/HHV+CsP7Cm59ricmRrpCnIci8gkT24fI7Fd1zWKH?=
 =?iso-8859-1?Q?yi/lZul+ctPOqYljF4V0g3fSSOLjoXFC7cRlqjUJx3YWg4bHNl+Z54qKqZ?=
 =?iso-8859-1?Q?X5da2df/kO/Z/wEd3PwTz1upXWp5y6CgoPGWdmESrET2fD79CY6xu4OrAs?=
 =?iso-8859-1?Q?XSm2Xvv2anUYph7DmhmAmU9vIQ8fQbDvoxLeC1ul5ufTIfLHYkFKCuGxc6?=
 =?iso-8859-1?Q?Ifj2NJe9jl1eAJQZPv3x9/A+7oDI8z0twym76rpcN0WrbUFvsK/BukhSbA?=
 =?iso-8859-1?Q?HZF14PbCgFQt1xU5Ij/EfZQgIzbUg3tIG0DLmdWdoQ8Y8tfKa/GCcXsYGy?=
 =?iso-8859-1?Q?Mxn+3iHdCod9wTHLIL5/6dl1QHAb48gnZGmMbBn42sJPaBN0fEBF0rz5Ze?=
 =?iso-8859-1?Q?mPEPH6PV/JUautikoRMlSKl8CBYbsAiUXMP4K/L7Oz2xPYNHWG7jUTHbFf?=
 =?iso-8859-1?Q?oFIureyAKDhkGprfhedrKWG7D5QoeUrkmhFnxZN/2xqn0nCJqchpJJGlWL?=
 =?iso-8859-1?Q?RJ8qsZEY870JrBlqRAeoGFadp6vAM1R+Lbw8L2cjIEXH4sjs7HFp4AvaNQ?=
 =?iso-8859-1?Q?AyCJ6zF4Qg649016Q41FtVnt7CuNvmBE+FXfQxTPmoaeg8s2XbJ8hnPcHX?=
 =?iso-8859-1?Q?C6fBPDw/Zi9CGmJP8/fyF8GAvCxOJP+uHyFTmA/2Zc0QhhFvBMXFDddp8+?=
 =?iso-8859-1?Q?KDDURGfZcBSA2I1KXTtlF28+lbWt3ySbrYX4X261y+crno1HcrJQiPThJG?=
 =?iso-8859-1?Q?Wa9M1fK+iqlYm1uc5BZEIvZMdrOFYCYQjHzgFGqtxXxPBcFyfvRnC6FsFz?=
 =?iso-8859-1?Q?jou0o4bf/R2w1zDVmG5UolM1IpQRY2wXWzS+GgGMDmwrtRPf5dNyY9NWSo?=
 =?iso-8859-1?Q?dXeGbtP+sGwou7sCFxl0jnouJ0X6WdJYrspx4kYqpfnCsq3apxXbfnOI/v?=
 =?iso-8859-1?Q?jE36F6fZ6+l6lT0gkzw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790e6b0e-1ecb-4963-cdf2-08d9b4d739c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:19.0761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xBxuu0RUbkTP3umX7I5MPBRGKK1sCx+VO0Ja3kYJcdsPqNTv0vQuPQ5qR3smCrfrd4s9aez68YPUZmAJv03fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-GUID: vWewliKzUNpwNn1RfiWSeBYm-WWCW8at
X-Proofpoint-ORIG-GUID: vWewliKzUNpwNn1RfiWSeBYm-WWCW8at
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..fdfea080c5ff 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);;
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.30.2
