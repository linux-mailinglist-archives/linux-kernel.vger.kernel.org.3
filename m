Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8FA4A6A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbiBBCnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:43:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50384 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243949AbiBBCmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120687w022144;
        Wed, 2 Feb 2022 02:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fpaQm34yUVm9NiSuon3NTmdABFzYxmG8nsz3o31qOno=;
 b=w+xJsv7yLLBHs/f3HhL+xr0VibqFFOvsHRN60m+ARGu14OQthHeZNtHZ8BBM1cWCpLbM
 v4yr5+LyWed6DfbcJnEAoBlZz1az/9V9b6Jpq9SeVErnaXhauMI6y52ZOrEnIbJ7tqtn
 EHQxYCpgHXTAwWn7MI+67pnZrF2pq0uuu+IYlyy3wODoxKNYc08HLrWluEfdAT+vR8sw
 +QIipd1NIb4p4vUyfxUPV2vdSmArH5N8SWys8pM/Ys3Smi9yPf6SxgEoi7J0YDcINoKW
 GuNk4YaxuTbPtiID/8szDBvhPR2RIGGRs/htDh31462jHGRydbKKaDUTHHqGQaHgORi1 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2m7q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZdSN126532;
        Wed, 2 Feb 2022 02:42:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 3dvtq1m94n-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f37R0DrRcVxoAedBUIjITsWDYTwJxIpikuxQWnAtW6L7YXcGN+rkh2N4pfhkYjppw6GuPbv9UmyVP9aM5e5AL2mbi93j/hy4HAql9DxFaOCeciqmTLRUnhpmcY433D4NA6aaO0plM2D0iWR+4ZPmIJBA2eRxkru54I20iGprz6XbKkC6ZPDFc8e9hpgqsA9wpB+xlcjD6GqNLDtGYOTGG+9ELSFOr7vPcP0KN0UUREUrZIpkceLbqSAVNsWy8Iv4cvgHgXznJTt94vzTSceFzEs3d4T8xn8elGXEmHtHMRCZUggb4D3tcxsgICEPiULHcVeIlsSqoo5EX4ljAd57cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpaQm34yUVm9NiSuon3NTmdABFzYxmG8nsz3o31qOno=;
 b=W0RzCmsX4weYw4lIkCStRxXaRg67W61pK+0QtvFZaX9DyZer366WyiW+9nWpV7g855ejh+8fbv9TdNjx5b4pN1mFhxGeEipFYmj51aJUK6c3UVqMJqRazXCueWzF2LQD+QD8nJgTycxVtCMxmEdmIM7clyVY0BwaYlIFLYx7R9oyVCWaYdIrkKxZSXpFgSY3H2fHxox2hwC6fO9zI+WfYBCZncYlBGlMT54YYTTYVPQPk/5ew9YzzOyTM8eH4N9wdA6CsZ1qRe3L66xpSMW2ZJV+KkTcDW8TbTtyiKeVmSsgjwq8ZMXX12V92Z2gj3/goA69nS4pdTmRy8ptRAP9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpaQm34yUVm9NiSuon3NTmdABFzYxmG8nsz3o31qOno=;
 b=H044WAfoR9eKNS0e3ddrPNIXzeemSFjMxNaty8nV78Y+NxhdPaMOb6ZULTI9Mpu6Dn644Z7W4sr1TdhNKG+OZROFfLjfNWmv84GDqszOwNXqcE905Xf0xE7g7p0zJsByLHZI7mLDjDSNh3CoPWJidDH5dEeFl4ofupkwmzh0JdQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 27/70] mm: Convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v5 27/70] mm: Convert vma_lookup() to use mtree_load()
Thread-Index: AQHYF955K+LM5DXoSkSbF7qlyQmqWA==
Date:   Wed, 2 Feb 2022 02:42:10 +0000
Message-ID: <20220202024137.2516438-28-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d487d566-997b-4585-7ea0-08d9e5f59db3
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129E83F3A603CC2452DCF3BFD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYzeImGfh7SvHrEXOsFI9RMysy/PEPQUlFbDjoWMldozgoJLNIe6EOaz+tNErTQf1TjiG5MKpczzrkZYroJ4CP0v8NQZxDqQjW3HKtgpkHTLE+AlGpazE/sk2NfLgtsvqBWUoeYz2pcxT3xGByF41k188aS9eKkkMrcRoPli2A3erMpAOX1Y6Xbqw2mQ20LhdHRXE6HDJH1wLYfEW1zW0MCJH5Fvk95bDSz/8c2oHyami9ERPKOw+X8wuzee5qN2U4bKxdf8X9f0jHedIHJuQq/RGPKQjOUTyoFmXkBIGf1R8VJhOGxMh6PtaxW+lxF3XwrO1c4bg2BsMGf7mcYVcuR3OQwG/KRrxC95XxHxvFMizlbMTl+ETG6EY7uDSzKcvFADwKO+9au2S8D6UZC2J3pDEKjCoP8u3F8SYHVIUb6givjT9zVLSL81svPOkmqYItqcXyZPZxqFOYUGHKoEwjgAiXlaVOvY9dpYkICZHbPVLwlmt+bipK6xBZ3p9nbCaJl56D5YeO4e9ls2eqzwNEeprs4fuy5+HmPSWGMUStQqvEWlNnUTytZN87ECyveFRphvHEmJJW7bNRcJra4Alm3SXuiKNX7xOtWSMR2IQzBd/b0gpfRUlI89eSprogY8FkxHJG9LGFASz52MunD9ZMNVtuiBDMSl4VdwUIDV+9SCi+K0o5UnjzAEK67IqdYGm9ZqQAinUd2+1yxVdCUDFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(6486002)(83380400001)(36756003)(1076003)(26005)(186003)(122000001)(38100700002)(110136005)(316002)(91956017)(44832011)(4744005)(5660300002)(2906002)(8676002)(8936002)(2616005)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(508600001)(6512007)(71200400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CGr2xMmTsrXCOdSJjK3VU/gMDVeCDHMIZu5xrP2doYXHhWHE+EmlEBIK9t?=
 =?iso-8859-1?Q?CdnykHALIK7//sr3RrODsptyQBPOcmz/cnc68o4Jf+TeCDO8nNy9+eDTHS?=
 =?iso-8859-1?Q?VNjGaSl281qU5RVPsts8nL6auVAfwYiLSBPUG2LhNXGxO7aqKZDFHdifTW?=
 =?iso-8859-1?Q?Jor//y0l9dsz3UXoMuxg3azvhuszGRSaBFNx9ijx6wt9pcz35YPGbiBNLy?=
 =?iso-8859-1?Q?LenNygAnYlkewSTxaY+BJfBTqvAGPE7rP1wQcMxS+sWAIPCUN4oiKG4P/3?=
 =?iso-8859-1?Q?EEglns7aYAL8SiPIgNKExwSLKtCHZMDlTrzJE0cxVNfgQUDK/SXVxugZWK?=
 =?iso-8859-1?Q?LWBlgyfZQugrpwyR0Z65J2P6yR/SviysWyDbpRTnU5k2fI17v8jZN/leoT?=
 =?iso-8859-1?Q?O560WzKabg3Rfi4fZ4/B+RgFTzsL1HnUJiSUFjV3Sk69LvBnTIPQxBWjUy?=
 =?iso-8859-1?Q?ASloyAAqrHfGxYqmrusiwRi0RKNLYVO+G+ZXfwmGoXaHRTARWcsd2MWpC4?=
 =?iso-8859-1?Q?vKzH3p1F9nwNRoTAplXdZi6dlfTsDNtHDXdMe9Br//4kE5FKxF+YvMlKjf?=
 =?iso-8859-1?Q?9x+MYrllcETF0vtZhlgGLtaU+/wAgdG5QBctxdDJWeJgbypY6vnvYoWH8m?=
 =?iso-8859-1?Q?o29aAsfvUuQJveyS/oaK9CNb4294eLiVFaHrhzlBhSQp/vFyMU2pAm7g/k?=
 =?iso-8859-1?Q?tqCXeTTmBHK7IdA8bJ9rtxXEtnT5VdCWY8xr9qgEneZlgZeZ5/AZfmPpuq?=
 =?iso-8859-1?Q?/jLIdC5hnSpVOLT8v/YIP5SY+o9f783fNvBpQ6vcrypL2PH7EGKClciYaZ?=
 =?iso-8859-1?Q?Jviy0lpTeG93XujVFW4weCgsr+1Krvl4eGKvblb5V8Fs44/Yhlb8fD9I1v?=
 =?iso-8859-1?Q?sg3KlTRvkBdJvnpfgO+xrjREawlh0+hSAWAaOYFwg5AiUN4OHyv7UwuPlj?=
 =?iso-8859-1?Q?FpaG/Q/b76pBYpPUt2oiOmquU89kkhJqepdIUdwjMmLhSx0pTXO8UJQ9ZM?=
 =?iso-8859-1?Q?ilWkb1IvnOaB9t5ApX+Ik/DtuwrlSvPGHTS0f1c2KB7YM7QehQvIHbie/B?=
 =?iso-8859-1?Q?7I2NUzb8xPls4rRFRyO9hCkse4pGZ6HAaKLTfsm2UtBHYjFQAiGNozOxH8?=
 =?iso-8859-1?Q?1D+M+UaUsgqoM7KQijvOOiVtmYxlrNXWAn7Lh/ZPl1UZnSQ/p/P16R1aa6?=
 =?iso-8859-1?Q?GkJzb3H3qGkhXqeC76jqUtyARp/DqUqNUcbG2jSORve1xxyu+TdhHyAyMx?=
 =?iso-8859-1?Q?VwHog7C4w4ICtL5sKWTMgBI7rDj6rQpikw+/0Rzr6sBKqaGDlgaHKnrd5r?=
 =?iso-8859-1?Q?FnXedfDewe0qOaY+4u8P2LJUdoFtLUgpEQtVGOG5qrsTJwua7YXNAYGjym?=
 =?iso-8859-1?Q?enCbzO0PEG8Ck2GeA+k5IvNTAVlrjigucH+GfwJKLQMBGsteZy6R/jXgB/?=
 =?iso-8859-1?Q?1qQgwOB7B2ripkNTeFdvFM1eSiT4GXiN+JV2wpHvND/jKTN10P0wI1+5w1?=
 =?iso-8859-1?Q?ycrexL2cEY7D3xv3ZVRPmQwJ6L9EHs4G+KSv5HL1ospRRpVOeBWRj3V2b3?=
 =?iso-8859-1?Q?b8e+A3ecyEIjnuEJNgueUbLh5KG4qT92UYTEB+x5pj/o7YbLY5XWC0w+Oa?=
 =?iso-8859-1?Q?0ZnOojyc1iUR5+/4aXOlv+yoPg6rOW9Yc7nYSLy+wYentlzhBs+5vrcYVk?=
 =?iso-8859-1?Q?EhGHBpZKh3/CVVr8tdA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d487d566-997b-4585-7ea0-08d9e5f59db3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:10.2671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gfVrO4v/Hc+GSXhAm1rYgDnaTDiaKVAJRKpBg3G+s+3k06glkaRb0H0nI/ZVO9XG/YGhrofOq1lbZT/e7ELxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020010
X-Proofpoint-GUID: 581Cnv-BoGnI4avHIRnCNqokYz4Huo9J
X-Proofpoint-ORIG-GUID: 581Cnv-BoGnI4avHIRnCNqokYz4Huo9J
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Unlike the rbtree, the Maple Tree will return a NULL if there's
nothing at a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 72654108380e..c57d23b9564c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2802,12 +2802,7 @@ extern struct vm_area_struct *find_vma_intersection(=
struct mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.34.1
