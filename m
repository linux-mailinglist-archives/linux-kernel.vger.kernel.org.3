Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278174A6A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbiBBCqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:46:01 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56466 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244303AbiBBCnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:15 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120QIZj015788;
        Wed, 2 Feb 2022 02:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=udl56DNLtyTHz/srt+tyNwBTfvWFDlIXimZgRN2PeM4=;
 b=oeyCLX4mMlkuItQOmf9CIIPZBSyF90C7T4Oz03zdm4LRbsvNETeLQN0geVDSRksfFaQF
 7iqdjU/M00zN0mLYeg2eV/tpiE4LYYNh5nh8i7f4GumIWQHFxuQykyimwIQb9cZ1fLRO
 OWuNd5pzeRkWo7Jo89y7hezDgzrBBNMcOgOxIWe7mrecfZJKR09HAWnaaVYT7ApMsCwo
 WThcDKpggoEsQf3Gm0S6oXFFjvVTuXOsP3oPe3EzMzdbnP6iJG2NOSMObA94F4dVwHBI
 qAVSVOWBkeWccxrziq6q2jnlfTdtNXsQJhAkILzSDJ6Q7z8oTJq2w338lNsEfeETAiPx jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZsuA007633;
        Wed, 2 Feb 2022 02:42:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3dvy1r8aet-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du16nweyiD1QlFxL5zOZHj5J9IfZHaxGkRBL+NJ3kPjV4vMdzJJ6T3LEz0lRt7MhKNOjcXUkr0dgTyCFOHsdQ8qqw1IU4nfMoFh09vqAT1a/ynycwO4IXOz9Ir9KAYuDU4i/98R9qGYj1Sscayb7W4cgcldxKRaAsYf5PCdGhoDkUfqxvYN9zzqzBNKsCs/+6oJ1gCq4b2OHy2ftGvXlqJhnFJa7sDL0qHoKENt3lZZO6IoDbD2O5I9NxGMG/DKWqbypt7jKinbNGTfosTjsbMWmSD0ppJ38M+EwQDPlYt9xMN9ZbMBmx/0PLn2d2tSKPKIayc7GOiHdV8aOSgOPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udl56DNLtyTHz/srt+tyNwBTfvWFDlIXimZgRN2PeM4=;
 b=GfK3u69GWM48ARKrT/+fRpSYgJN5A/pR4aG4pVRmIoKBIQ0/DeRqR+sxguzw3KC/9PDVUOkkItwepG2739vkUBgJvtmhgXJkQvCHW9HPhruuE6b9bDx5WVCiPUOPfM2YEOC81PTiYD7V4AN2RtL/IiNdq8e+InTTyroRfiQOmlPvoPi/1MpDFggxcyacaVlSxDtpnqWIVYZl8b1R7V90iAh0wcGVi2zVfTxFFwLhmgr7fIf145wN8r3OAfBS74a6dmvPIx+w47VVENkeri65xN+n3vM3zAp/X8Zq3LhPzUn6JXQFQKopckHYzFChusOaY3ARdPCJFRxteSG8YRs3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udl56DNLtyTHz/srt+tyNwBTfvWFDlIXimZgRN2PeM4=;
 b=wcnsR9npEeyB2UdG2ozYZngnKzH5FneR/uunXF/j3ruB4j4Hu6TxuDQlc807S2kWQv9Nuo/ScwUMJgd8UklGPq10mMnEqX65A0IVkkBlsIqgv53L8YpHzGlI46NDdAWdkUHHBFy4WVmCa7DnxHIo15pBITi1D1NfL2NSbQ3LWWk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:42:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 46/70] ipc/shm: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v5 46/70] ipc/shm: Use VMA iterator instead of linked
 list
Thread-Index: AQHYF95+BgCkZZ35OUO+v5crkhoqSg==
Date:   Wed, 2 Feb 2022 02:42:17 +0000
Message-ID: <20220202024137.2516438-47-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4af3700-3fae-4264-0c22-08d9e5f5b5bf
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4801444E6882F3E1EDEDC0DCFD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbJmauyvPEHu2G9RLGicxp20MRy75aa/BV4wPuXl2aMvrn/8J7V9ThYFBKSVUh5PkG+IKQyYKjQZq7VY43BfB9HvEKECqUQUya8MxsCZMgwoWm0kjjJr8gqzxOdgt76LDlG/8DmIbb+GxtwmGnIC6wZvZ/Av0VKPUkKTzmlCj3iop8CMpnGYHA5MsMTTge+yq4DP6EQ0vB76j9B6nJ02qI+SWKRB9+sU1If4WEL6QSgbn/26MucBzIQmQPV5rDeXi1OF8I1He6KE+ipooLl+CjIyauebk3G6R5GefsaiOFAZUvTpRnazAJa+H1Fu3JVvpjD7ksdA46gxZmOGc2EvUZ1Ma4878fkNaPWzmQYMhZ3DeOQl99+nr+PvPDnDwNb7MVgUuWntvatGalx/QRO2Rz3REU8FarDKUWmj7EtTVzFdL/Fnn+wDLpdcbOoGOMRVXeI4o4oYq5D/lZyx8rScIq8fUNzsy+74cWVsoLr9InLmfBYck43QxaqKtswyZCAjkadNNQUmmbxZ7kh0b7ZOHB+HNyZiflmRyq/2uxcN0WStchnenKJEwa4eT6b1VZHCLytHrMuc8CQUIfqmj9Q0SAlJvLr9TcKhQTXngVNfPy0ogNyWLOinayoaMKyScNCMv+kqMlT6XG6vfxpRWqf2XecL4J4H9+oAbGS+zVo4OeYX9cXNJ0SbjCLyEqPsA3R9/LKptBD1vq27+vvCwNjWXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?75+MS/U9PMGBYvHUNmRDm/Fv+ppEOD5fa3U6/czVbpc/EuReBlAl8Pf/LJ?=
 =?iso-8859-1?Q?oGz7ZpPq4L20N1DoT+0x+gcVDgfYpbTNYCzgE1hnSjathe0zj5C/E60Zu/?=
 =?iso-8859-1?Q?AB3xd1gp8Lxku0eV+f6f6KcXjQGzLo0p99HBf/mDpU/Cxm4ZBGmpVEB4UA?=
 =?iso-8859-1?Q?Z00XRGDfym36UTcy526/2lsINUke3yZw7We59Or4SQ/24yOGIUi0ZzHIAe?=
 =?iso-8859-1?Q?FEF2Z8L5t+IDJRJoG5S+sRLSvuUldWnDCUy6ar1pRAyv9WXBD81jby1pML?=
 =?iso-8859-1?Q?eljxX+Wu5BjeFe0m9mX9iueBWr03vIDvP9QxnkyuwcUOWtGyqyPGbYzm7i?=
 =?iso-8859-1?Q?oDLJll9QRyJh/2gOCxkp7JgAlkhIC6CeeQq+3xUqa5MEE+w65xhloc13vt?=
 =?iso-8859-1?Q?s4wVjrEUfYXzHFZsUsAgCFZAzT3PeKnVK8ch5HHhhLmS78TpKuewQnjrBd?=
 =?iso-8859-1?Q?AxrbPfhY/VE1gfTNeUOy16gZHSYD8DAWpbKMaXRM2sOdIzfWnyex0s9UP0?=
 =?iso-8859-1?Q?2POJ2AiB9deP4ONPZz76BibDTEwas2098Jxh91k+oLsMPTWqxK9zbn6PR0?=
 =?iso-8859-1?Q?UeMugbQj/jQ/Ov0YpPdZ+p9sT7M1Kmzwt5hMwpdzQNlIR6wkK19eNL6DrN?=
 =?iso-8859-1?Q?YREUGFA52JFniJzmPdoFp2TpRq3ZnB+KL/gpfl/M+Xjwjd89+pzxCoAYxE?=
 =?iso-8859-1?Q?wTcHfZSO/yR4sST2euDO8xA8DD/g2r6nMJ92LhjEVTqOtg2xYZdLJwb1XD?=
 =?iso-8859-1?Q?ug8KYpHGXQZpU6SRuxHdkI48Dg72zxRjEF7Rp2oIt2wpKN8dEhocnSBCq1?=
 =?iso-8859-1?Q?/cQZ8LJQbt3+22x9GmxegpSKLZDpcplAQ8ljakqgiFloIpHzU/YX13mDSR?=
 =?iso-8859-1?Q?OYmhYOwNITBv1KNQ6euNILKo6peGbFlw+ZHlQZnGrvX9ughcBxHYqOx5Ci?=
 =?iso-8859-1?Q?ccUbjdUsAUF3NKjnRPsaZvupTYmkVCVlXeXpeI1xWTNXZm9LTlMdbsWTEy?=
 =?iso-8859-1?Q?YtEWkyi1pOhBcS1VCVygNIWZdOgJBE8q2+IZuJ6rfboRDoH55ZYmBT/XoM?=
 =?iso-8859-1?Q?olljoHoI2Bl3j4+0H1oLv/Cyx4fNygs0LHAwga83DEiTnhPKz87jdvjnWK?=
 =?iso-8859-1?Q?eDJ7iHGfiLjrtCUX2oJ0gP/YptWt7zCK9kghnZhXbcTlecTTjnddDH8Y0a?=
 =?iso-8859-1?Q?m+m0Gbki7ZAXZYXNnYG9Mw0mLe/O/aaatQ63Rl/A0pvx48ZhUHncA42+UW?=
 =?iso-8859-1?Q?AYArSk4oGVvgHtXL9omZbmHK+4V5af8DSprzly/OTGY9z7tmQIlyc+yzGH?=
 =?iso-8859-1?Q?ERLMHjQsj07xrOrmECFep0OF5tMwYBXDhi2WRxtW/sVYC3RAoUiErr2PBH?=
 =?iso-8859-1?Q?lBC0VbH/Mri//m14oGxQLXuU2FDlQysnjXtRnIGseRF75toGlM2adbk62o?=
 =?iso-8859-1?Q?sthZ8vDCbzNTTl5D4d74XVaQNxRTC0wneFYwzmzLIouK/unpI4GERdE+vE?=
 =?iso-8859-1?Q?yvn3mse9+9CuaxDnT1rd6XjBnlMhgk2bdMh83CVpKNoiRJqMSv3AmG1T48?=
 =?iso-8859-1?Q?nTJF+eXSV61sf91L8JwNo+WJi56kH414KsmbU9JMONUCW7USDvD3KDrVHO?=
 =?iso-8859-1?Q?QsL7MuQsAdPSlEwueXlEUttximzVoyIRwBZbVxXrHMfqHLgXLbvF8RgF0j?=
 =?iso-8859-1?Q?J7ZIGVWwPr7ceQiGK88=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4af3700-3fae-4264-0c22-08d9e5f5b5bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:17.4698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQ/5USEviTdfJvGrMDhzmSdjeOiihf1KI/zpVf13RNmKzttjZWogXv9nmLDjPYUJtiTqwCw8BMlPSL4aV1C1SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: 9IQhDarjRR1kWNRiAqw-rK3JCi8UpunV
X-Proofpoint-GUID: 9IQhDarjRR1kWNRiAqw-rK3JCi8UpunV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b3048ebd5c31..7d86f058fb86 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1721,7 +1721,7 @@ long ksys_shmdt(char __user *shmaddr)
 #ifdef CONFIG_MMU
 	loff_t size =3D 0;
 	struct file *file;
-	struct vm_area_struct *next;
+	VMA_ITERATOR(vmi, mm, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1751,12 +1751,9 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
-	while (vma) {
-		next =3D vma->vm_next;
-
+	for_each_vma(vmi, vma) {
 		/*
 		 * Check if the starting address would match, i.e. it's
 		 * a fragment created by mprotect() and/or munmap(), or it
@@ -1774,6 +1771,7 @@ long ksys_shmdt(char __user *shmaddr)
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			mas_pause(&vmi.mas);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1781,10 +1779,9 @@ long ksys_shmdt(char __user *shmaddr)
 			 * searching for matching vma's.
 			 */
 			retval =3D 0;
-			vma =3D next;
+			vma =3D vma_next(&vmi);
 			break;
 		}
-		vma =3D next;
 	}
=20
 	/*
@@ -1794,17 +1791,19 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file))
+		    (vma->vm_file =3D=3D file)) {
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+			mas_pause(&vmi.mas);
+		}
+
+		vma =3D vma_next(&vmi);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D vma_lookup(mm, addr);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
--=20
2.34.1
