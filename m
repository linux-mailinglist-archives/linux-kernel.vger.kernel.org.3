Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EBE469A8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbhLFPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:08:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42972 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345773AbhLFPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:06:42 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Dx42O023237;
        Mon, 6 Dec 2021 15:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aU3vYITWYi37m2Y65ddeWBb0nlcFagtDpPUSn7tkP9w=;
 b=kHt+UzgXll28jszRFpf4Q+ZC6SelNPFg59S1AQxS0MlM17T0H0huG7DNLc6uUrC9zReS
 3TC4tV/P4UWVnbih1Z8rXB1ZTENpA9f3SslFj/2gXdtzkB9fYMMI0bz3MFL5raV27MYD
 +hCFcgZKR1A0S2Z+vLLqxc1IUl5ml+woxqdk/XWsx1I6RX3E8vdIG9JNupiqzbZghOMn
 AQjtmJPMK+I6oek3g/ELkXVwsc13XaCdbJoEoefJ0EgQR0C6hRl+EZ4HdR6vtjH5Fvn4
 jFD9eXE++qRQverOI7Wc0UXLzq0JVESYoG4vAvP4oOtboFzihhwFLkqmpW7qF4Pmx2xS qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqjrvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6Ev63a091928;
        Mon, 6 Dec 2021 15:02:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3cqwew49s0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 15:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2Z1p1P8uJQ3Kp+K2UWS2Ry9tniqnhsN0o4/F8GT1ytqCXnTX4t4TC075//Bm3AiyEfq71/GH3HMzoJyKScMHWUhBvTLvxFD1TbGX02UPwB+9BbHJ7CmpCPs2HcfdIjDhucMc7EGqaxYzxxjZ5+P6vNjeVqOZy2bzkS/ViV4Tzbn6o9tmcYas+2jY13fDYDjUOAdbEjCskTj3/02VuXPQlSPVj5gMG1CmMFfJ4mQWx6kE0ipS/uACYfMXnnME9gLoz2b5da9HrE7+HKPzsOj77sU9XZ6tXiJEu5UEIx4TjF2MdUcvUHP2Phfz63iUwmxesbsi3bZayWVS3vldFNAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU3vYITWYi37m2Y65ddeWBb0nlcFagtDpPUSn7tkP9w=;
 b=akEoucZlDCE2ETwCCVFVPrvzJqBslJuO8dUYCCB0DCBVIxoyNJiEAC0iiIkF0vfiEB0mQK9/oAVngxeTsWQTjx4OuMNILeGxFa6+7jSZdfuQ7kgPc4iFR/nwGmNcORdrKYMcnBSHObSKQmqsH16dFC/wwjSRpbc+zVdvbKQM3CxYokKk4hB4TTmYtaTxxvP/Exd0VjVB/QQsdNttEequGImn+FyotFtDTJgUUpTUnYcSf7PmFerBmJ7/Rvwo0ZQ5EvnjE3VFUJfBElvIkKvL130mERgzoUqbtIPR1Y/MTNd8rut4UxkBxefPj+9e7KvZMad6nyielRDGaqbgVInYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU3vYITWYi37m2Y65ddeWBb0nlcFagtDpPUSn7tkP9w=;
 b=P8rhB1gBQwD1IM474vTb7+FsudaM/m+7HuPnEcQdbqMeIcOqQFU+yLqUbjJ/bj7kX3qKngpNJ7qdfl9ub1ERLtbv+8UNyM2flYQ2MVcPSivrLjGyRJykObRszTrZcLJS2Dd+23jCZO7n+SVMOdRCmZP2Mx/NivbJLAmoL16zA8E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 15:02:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 15:02:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: [RFC PATCH 1/6] ARC: mm/mmap.c: Check length of unmapped area before
 allowing MAP_FIXED
Thread-Topic: [RFC PATCH 1/6] ARC: mm/mmap.c: Check length of unmapped area
 before allowing MAP_FIXED
Thread-Index: AQHX6rJXf1YQfMIjYUuPLE2D2lg9jA==
Date:   Mon, 6 Dec 2021 15:02:52 +0000
Message-ID: <20211206150231.2283069-2-Liam.Howlett@oracle.com>
References: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211206150231.2283069-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8d1d9a5-59c0-43aa-6623-08d9b8c979fb
x-ms-traffictypediagnostic: SA2PR10MB4556:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4556A89EA7C30F2328876E87FD6D9@SA2PR10MB4556.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZi7fI7h4k+MSeTCjZKtYJEK+z3cTu9AffF2+c8Kfj7F+AWgQW/CZEQIsne+RkOHnk92TUeJV9DESMdPLWi1l/g8Ho4V7s5xq8JEh+/riH1acs/K13XlxVPcyunh50qr2s5U/nGbsYD8yC7FRMQJ+04Qc06mDYp28tKiPD1ipBBpvH8Y+onOLco+buH9lEI11KyezXHB9QnGGOm1d3C+X9AW/t+Zy8y9TE/YCiu2Hu4LLUPE8x2lvUdAtLv0xVFeB7HFAy6FfhxvVyE+VBFv/1IydtF3Rrhj7LBSYHNCuhamdIdXjL1bOPPd2tbf6X/4XU9GYJZzU7Ln1GrscnwOcMHs/OtZixr6PfJroIUr+ExSnNvOKQ05CmNXfR39cK+Abks4hOPfxAfWXwNQv2DWyZAXn1Wlq7ikOkN+65dWzFm3e2Oo9YkIrqJHXCET5fidpL5wQgDsPrlk7v6xU8+b4MwVN8HaL2s9vFn7JbLmuh7bS6JHRRNy1TElp9vRhIU296eEc+66McNoyx9isFsgZWhrz2fTlyr7CyfBrL2G2TQ/3qDRvx3iU6P7Sp08l/yzIxCj5Rpkkvo+J32VhlOAoAugH82f24TNYlQ48YPDtHNVd1V7yJU1tdMpwDxD3rokOxSMIYAqTGs8xsTq30PkUfeWSbVw1Q0SUhcpOVmJJWLp7yGF1XYNTHyRoIzAqZ9UVJuMMace9wazmzr0oAnxuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6486002)(110136005)(71200400001)(6512007)(36756003)(186003)(122000001)(8936002)(1076003)(2906002)(6506007)(508600001)(38100700002)(26005)(38070700005)(8676002)(66556008)(66946007)(2616005)(66446008)(316002)(86362001)(44832011)(64756008)(66476007)(83380400001)(4744005)(91956017)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y1e8JEaKsnl8zxt8Za9OjP+fMEIkq8eZe2QGWFyadpHCtR4p4d7iYsrQGS?=
 =?iso-8859-1?Q?xVjKI0UwsZe+u2k105+foY/GWH7NQbKfa9xBttwodKDj0kIJ9ZDJAbTb5m?=
 =?iso-8859-1?Q?DboDyQMjG5y98UReRgWj7zBIbl6Ab5EwYJ3996ZVVBp4W4PrCDxdAtTWNo?=
 =?iso-8859-1?Q?HzHvGfPASVTo6hV5oQE5oIdVysb+xcDc6CUb/OhkHfno8O0/5/RaoYmbpK?=
 =?iso-8859-1?Q?p8OvY0TNakLa11wEin/JiGVs1K3OZgIEN7hBGtr0N8cn8KEkJy++mKG/CY?=
 =?iso-8859-1?Q?cUz8wsGIEAp9Sag9rHDM7Z7gGZVj59hX0whDPnuLGq/xVswvyQzUxtc04B?=
 =?iso-8859-1?Q?xVixeEU2e77IQn5JQgKXKK7LKAOOsoMSDdP0xYmg/FZm5fwSzzjxOZRMc6?=
 =?iso-8859-1?Q?pYzTC1H0dMGzhXh/7y6+c8SjrP04Dvc+H/7/oyvwA+vfPZE2ubhcwMJIhT?=
 =?iso-8859-1?Q?PnFwnO/lGKemWZQMsLtvNzyiBdU3dmKobSKI0yVBQPMSoThvTVStkeMccU?=
 =?iso-8859-1?Q?K9NErglww3JV6KZNfhWKHaiom8KjyXg8cwGMZW04RvkGRN9L6o/xzMmeCK?=
 =?iso-8859-1?Q?Zwpm4LU5mFcXIr165wPAKw0n/w0Hr3pMBbWvM4A6U+DhKQG3SjmQv2WokU?=
 =?iso-8859-1?Q?Cg9taWQs/oqkQRpfNAbM8J3BZ2Iakifl0yAIUiOGjX7U33kWfr3v6p/IDu?=
 =?iso-8859-1?Q?Qwg08hTcIJE5OYJ4Iqe0eoxVNAmDbaE2LzgBkq3eYp4QlIizO5hd7ccBCH?=
 =?iso-8859-1?Q?AC3/Alh0AnBJwz5a7bMzts8w/D0dca5S65wb4KEU1BCKDIltLGlurvkBVG?=
 =?iso-8859-1?Q?DXLYfbw5wmjbMQFY+ytuEKicyKxWrvQs7TGNMNo1YqZupD5WiymbxNCdhT?=
 =?iso-8859-1?Q?jW1qnfmh0W2zXSytwfkHDgiDG4RGwqgnGnacskFXS0nhC9/zISC6ojfcky?=
 =?iso-8859-1?Q?k79Eexavl2fOJARwOV7oE6kkK20VlXLwdZrQlAi8XSpQOByUCaYBFwDBkI?=
 =?iso-8859-1?Q?oeWwwiIJ+6FgMs98xwYO1xBL9J3tM6fXcnZB9LYcfOE6sLYoOTep77XQ3B?=
 =?iso-8859-1?Q?Uf+1Vw5zLrHZQ4BB4osgXmoOjjojStPQ4vb73eQ4xNEoF2J8EH2u3WatXE?=
 =?iso-8859-1?Q?hrCpw1RrXhOLo+M+g4Y/4y1bdfZ3T2h0Z68bLebIvSXM9VwHDzdeUL0ewt?=
 =?iso-8859-1?Q?aNm77MKoFYovp7XzGTXD3j61fH8YriQU5WzSsNCnIjtqGOBMjIfhy092CY?=
 =?iso-8859-1?Q?DH9QcbNN+nurUaKHlZ+SZJXiv7U6edTUMFSB1trBU+9v2Ppw86rxfsibTZ?=
 =?iso-8859-1?Q?siKE0tkqLno48YYJxPudEotARmHWkMtZ1GrsfKMjE/RopQLKxhUAOYVL8o?=
 =?iso-8859-1?Q?tg+rLpVIjU7cQb+54TcWyI9SyOAHeHyvQxeir7bd2Gqv/n0T6CWsbfi3ct?=
 =?iso-8859-1?Q?xDwTqfwEQc4LQ3TmCJaY8lHRwuB3QIeyTvu1Ylx7DSKpqei2/I+kxI1PRW?=
 =?iso-8859-1?Q?I54at4h1lXONMEF5eHgD+MAGInfcthJJuNzpv265kpnA1WlkjmRUDuud6N?=
 =?iso-8859-1?Q?bdYqnJDmPEnbtgL9Xh5ctSOuN8/pbeddNOWFoWs+DsDzWBfe1/FLHRh11J?=
 =?iso-8859-1?Q?AarVkVMcAZofsxsqG/G6rqOsE3lqE/fo7And1ySs8IJ/TU0fXlU/lPkDiC?=
 =?iso-8859-1?Q?02zs9Pj0Lu8i8uSI0lQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d1d9a5-59c0-43aa-6623-08d9b8c979fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 15:02:52.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zDklR4l4BS/Oh6Lnncrk5wF+jQCuQdwkZqHDTTbiykmB1kxBVtMY1IdROOWubGIsO2Gc32vQOEGh/VvlIbgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060094
X-Proofpoint-GUID: mktskCB8dfxCH1j2xL-4gTLRRrStdDWj
X-Proofpoint-ORIG-GUID: mktskCB8dfxCH1j2xL-4gTLRRrStdDWj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_get_unmapped_area() could potentially allow a larger than possible
length when using the MAP_FIXED flag.  The bound check should come
before the check for MAP_FIXED.

Fixes: 5bba49f5397c (ARC: [mm] Aliasing VIPT dcache support 4/4)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/arc/mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arc/mm/mmap.c b/arch/arc/mm/mmap.c
index 722d26b94307..1d7076406c4e 100644
--- a/arch/arc/mm/mmap.c
+++ b/arch/arc/mm/mmap.c
@@ -35,6 +35,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long a=
ddr,
 	int aliasing =3D cache_is_vipt_aliasing();
 	struct vm_unmapped_area_info info;
=20
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
 	/*
 	 * We only need to do colour alignment if D cache aliases.
 	 */
@@ -51,9 +54,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long a=
ddr,
 		return addr;
 	}
=20
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
 	if (addr) {
 		if (do_align)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
--=20
2.30.2
