Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD6E469A81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbhLFPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:08:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6366 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346414AbhLFPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:06:28 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6DpixY023254;
        Mon, 6 Dec 2021 15:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XCZdiR4WCFJQRI7RkalA9D3uGxyHKK/y3UCV/n1KV2I=;
 b=iMSXEGQB5exovKsDCwxG5qvJ/N/2aeU7vnOBexQ7WeP7zFTUmVAf5uvnQp6JlVpUajlA
 hHJWQirC3UKySI8AmKScU4W95lbQ5q9929Z2dH68ld/BiRFFRzC7G91UL+ISkmjFvT4G
 T9J5JKSxnw2Xp9LidWLc0Vbz2IiXCqCr/bPUe4n8cvyA4dGZKS/AGCx8pvEQbjvRpGpJ
 wKmeP3e+bTZAZgdA0pqqRPUTxtu3wfFMnLvq1HsI8P2dM9tQlnoxS4IZMuF4yZkpo9+/
 F0aWxMHEwzCiSRmi4LxyIR1gjDVXGw+61denELHrpbhsJWgVEJCCceLkUbkpyJb5rWGx UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqjrw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Ev91i065229;
        Mon, 6 Dec 2021 15:02:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3csc4rvn0a-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdVzrIxuOZ7JLeW2t0JI/JBFoNWMnAJCTH0dgjAX7PPoo4216Vb0cqJfwmLj9jFCrlTTD04ftbXMNT8YU0BjBh9xbUtxUdY5COfcUU2rFUEXuZjz7cZQi9XHxtucO+xsz2xVi+c0WdQFsy8PmCE9a8QAvrJ3XsdLykyMmZ2w8wPAFuLeUXELB199kWXHgoDsc+jVkllwQItJLl34c2BV/7CJxf4UCD/qtmBBPFKWtRmqAP1lQfcO0mqrP3toFJOluvbsSBey5FACLF5xW77crc1xwTk3ZPxRy6a7TD9NgE+crweXBnA7pXb4pO1vk53I5FBN1G7hvhOc9GaQ+WRZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCZdiR4WCFJQRI7RkalA9D3uGxyHKK/y3UCV/n1KV2I=;
 b=Mn3aErDVpSsj+nE+APumo29566BvcW/5uaI/IwL1t1P5zhd/7+1QzlH4QEXQ11p9cusbqUwS40pC7Ck6O7F54OD4M3YDjVUnmS3vOyACdhAusI1QUuDdscyyjEqCGL7BkiJ1TpgMm+mOYHNirEjgsbWjE/ZjPrLkjhudy94ocVx/q96tubs0t9lHwVlqoVQixLD+s7o6jN7F1ouDmGzCCHWEWSf7oR4x/qNHFRF3vkp7r1fLu8ZaAP1D7DJKp2LcgQNt1f4qIVBuPs34yJqXGTQmm8Bb2B2/CkdJaz+6YtE3CtZaCLHB/BMv140hkuO7KDz9aW9DU+wiCi3T801pdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCZdiR4WCFJQRI7RkalA9D3uGxyHKK/y3UCV/n1KV2I=;
 b=r5VXvoul7lbPdgdnOhrgmxc5ARFej/mBI+j6ymZkPyY8gCOKptvphugAYEOjJ30NqSPaLtHTV28mWaqoFfxHlSxtk9qBle88rk8wBsGncRvCrtTz9x+KM6vbzIN2TH2BOwSIeBXzXYxxLjRJqVH++1yfNU6VOs5FGBMFMBH1rOE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 15:02:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 15:02:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 5/6] sys_sparc_32.c: Check length of unmapped area before
 allowing MAP_FIXED
Thread-Topic: [RFC PATCH 5/6] sys_sparc_32.c: Check length of unmapped area
 before allowing MAP_FIXED
Thread-Index: AQHX6rJYFwQooBX0g0aVVJKGE5ChAQ==
Date:   Mon, 6 Dec 2021 15:02:53 +0000
Message-ID: <20211206150231.2283069-6-Liam.Howlett@oracle.com>
References: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 562a82e6-ce5d-4aa7-cd32-08d9b8c97ae9
x-ms-traffictypediagnostic: SN4PR10MB5543:EE_
x-microsoft-antispam-prvs: <SN4PR10MB5543CB432F61677281C7EC7BFD6D9@SN4PR10MB5543.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufutQ96VWQeCRjP9e97GuQXRYMtckT+wZovqr/IuZyfNi62KeCsqR/NUZn0fwj0+pQbhUxnul9br789dYY7CqSaAelC9YYWTfS2czIBZcbaJ/0IUCKHsMdDbYcYbySjuUAGvOeTOpsNtK9tk9zC2EkJfrvReXlRcZEaGbSwEYI/ADdIby7mPF1NWz8mrq+wj7Bo2XQGUS3lNP+FWcZtoX+IMYAFzxpZ35Kanr+lQZJ1pMPR2kv673EWjK5w5AjEbiiP9vhfvbx1OJL8Dy0E1bSeSHOX3Ooe3ltrNl8r3rVDDrh95/dZ9C1LdXcfb6kNiTXy7vvyFrPDfoUScJ0/nefCx9inystHCELT+ge3fSNiK3ecHelH3j/JZUXNInUniseKrkuUYIMbmdkgj6Zl0ejGVYJ3soc/VP8MfiI61j0AArY3FSdKJVzF4VyDrquxnD6QuUHrhjeHELMU0Hg+BLMp7XXdEFdnmdKnrB7IQOOJfJfT2N044yA5Ms95cRrtyJIyIFMbrKBFvdxCWJWxuyOPJWR4iyKFOO2p3jP9LwoH7RAs7FSh58bJsu1jRrf1IdOOVsQtcTjpIwLwTj2MmmmpCJ37F2+5jKYoUAhgho8jZ+ak/EnARjECWmrjJu2HyTRcvYSrITkhcuYATWyzDqw9BmTqilZxfoljvgHE9m9ajdoU4N8PFqb9sfpBI6urm8LqWNtT0U9MjGOkaHMqLtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(1076003)(38070700005)(66446008)(6512007)(86362001)(36756003)(2616005)(66476007)(316002)(8936002)(66556008)(64756008)(26005)(186003)(6506007)(38100700002)(91956017)(76116006)(71200400001)(8676002)(508600001)(66946007)(5660300002)(122000001)(110136005)(6486002)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FCUr7SnXBqjMxnIwH0W7NB7l3Zf04EXYooyw1HIem+WNZ3wxYiSQZ5Iqxj?=
 =?iso-8859-1?Q?RIR/+ZLGBYhEzLZxCLnt0AaHi0o7FrbbP+5Eho64NQxIXlh4/He0fKmg9m?=
 =?iso-8859-1?Q?JeocJC7tDmTdTwOOUMy93BfeUEZzQ95LVxVkGluLcydLrYEa+e96mm3NKA?=
 =?iso-8859-1?Q?6/RZjSzhjr5cnS58rrH4dGNIHzUZK0wCtETucLKEVLVEOujzOLoxwopLKy?=
 =?iso-8859-1?Q?BVWKZ1CsznnPw34XIUygJBzQZ5E9R3ermYTvO9s5k331K2HonbYTIO0Z7l?=
 =?iso-8859-1?Q?XexEiIkiEkKFyo9Jtiat2TZu2e4db27ui9k9C+hZenwxFVbFob/FCoXiYZ?=
 =?iso-8859-1?Q?12ahSWBjrfUXB5lELAtaEy9oabfPNp3npedQMM7EQMud9di37Ryw2k7J43?=
 =?iso-8859-1?Q?rTHbz3IRohhnmL0JgSE7uAOYMGAqEmbPnsTV0hrhNuaTzHJUTxXH2IQ5OY?=
 =?iso-8859-1?Q?p8+yc2niHxNSWExxZ2F6mm9YwYKuRlcSqsqpeDAUzLvBqzKGDl4Ug9MZse?=
 =?iso-8859-1?Q?/7LkhH6EnI8AzcBrG8to/7jueu0EFfinui1u8S56UCOJK/m07HyRqpytxT?=
 =?iso-8859-1?Q?LeFDF62XKgtXr+d2wRKZlPpJfi7XLuuyQiTA56FSLk2yuyKez+Uyb2CCpp?=
 =?iso-8859-1?Q?slNXsX3fAcGzDYwA6y5KINskRQ3bgkrgge4Be03ERjJY79EHjVnYQNDALe?=
 =?iso-8859-1?Q?fIT+SgRo9/jHlHPbNVpxVKha2JR1XDBryXiJXY1sDDNeOo9RFSRNltu59u?=
 =?iso-8859-1?Q?k24SED4pnxaZU/pVLttyd6ICXjD+I27o9//o6M9aHcsn9hxi1aQA+Lj2PM?=
 =?iso-8859-1?Q?uYT7xsPiO5slkXEyI1Qk3/3IZyzjKom7t58lLDduQpI0eLraSLWMgHn/3t?=
 =?iso-8859-1?Q?y9ziiCYmP6+y78frg7M+A40ff3oUwak6vDPKL+7aUajRjVFc0+85trtuS/?=
 =?iso-8859-1?Q?3szzUh6f78Hjp7uD7v+oTNCNbldGt3TXcjBlGPq+bagMfdBfR6i75jxdOx?=
 =?iso-8859-1?Q?oY9AFcDqZmhJXXf9tr4/ovTE/fmQdBcfZYxpGNp+PtS2zLfhHhcmg+n/s/?=
 =?iso-8859-1?Q?cur6UoBUqNC/0Waq1f09fvQiop2c6vHcFgZq7mab77D0Qn+vmFMQUoBgar?=
 =?iso-8859-1?Q?mx291JsX1Dv7kTBDHLGqCufSEfoqEdsIM3ZPCLtMjcE8oGRQAYG1CbY1Rw?=
 =?iso-8859-1?Q?7Os7Ow0CBYGpTKaGmhbcUXXb3WkB+Gt1l/CHEVL7S2fls/DS7tqlHqabTp?=
 =?iso-8859-1?Q?6xclTQjAuPHpKfZf4ibhuPirj6tMtccKyP2smsPPZJJElPxRCJn0QMSOVf?=
 =?iso-8859-1?Q?oRpNgL/sjDPx9KHPmfDiGuWbR4A3SNM+tfqLedt34qzjzyeo0CEOrXHdPT?=
 =?iso-8859-1?Q?FZgHZ9p9y3GwFz+a+Y1gGtrbqZXoUPeLVALoJrxp+N47NnwQYQErN0XtiI?=
 =?iso-8859-1?Q?shFNJM6u2QcObbrwEXoLivMxE0Yi+F0ZVS8Nv0DupXX6sAcKM23lZsgkP8?=
 =?iso-8859-1?Q?f28/qR7KNwoaqIoPGjISQLbbx6v4YSrQ7+cUbocDpEJ9a6iqxg5kFZVEkp?=
 =?iso-8859-1?Q?KCJaz1nBZrKaQO0+Xdp3+pUyBkx0eQVPNT79NDWY5FuwosVKRzAeeshG6d?=
 =?iso-8859-1?Q?g/Hbw8MhvlxPHQKsbnUimSXNDLQyngbOBzwG2cFGwD/ezDdLMz8N5G5aUX?=
 =?iso-8859-1?Q?DbxMCFs/ZZRjYlmfTQo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562a82e6-ce5d-4aa7-cd32-08d9b8c97ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:02:53.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42YJh4dl2nVfTMmkMczSA+2rrrK5n3tpXPdOUU2L362TJUJrKLLLTbJgq3v91LlkvtTEBL24I1O05EaVsbopZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060094
X-Proofpoint-GUID: -ds-Ux7yxpZFPH7ji0NivijnOnGPnjn5
X-Proofpoint-ORIG-GUID: -ds-Ux7yxpZFPH7ji0NivijnOnGPnjn5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_get_unmapped_area() could potentially allow a larger than possible
length when using the MAP_FIXED flag.  The bound check should come
before the check for MAP_FIXED.

Fixes: ca56c8ee6fa0 (v2.4.3.2 -> v2.4.3.3)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/sparc/kernel/sys_sparc_32.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc=
_32.c
index 082a551897ed..2e0e35420fa3 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -43,6 +43,10 @@ unsigned long arch_get_unmapped_area(struct file *filp, =
unsigned long addr, unsi
 {
 	struct vm_unmapped_area_info info;
=20
+	/* See asm-sparc/uaccess.h */
+	if (len > TASK_SIZE - PAGE_SIZE)
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -53,9 +57,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr, unsi
 		return addr;
 	}
=20
-	/* See asm-sparc/uaccess.h */
-	if (len > TASK_SIZE - PAGE_SIZE)
-		return -ENOMEM;
 	if (!addr)
 		addr =3D TASK_UNMAPPED_BASE;
=20
--=20
2.30.2
