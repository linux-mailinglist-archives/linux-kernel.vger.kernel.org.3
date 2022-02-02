Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F39B4A6A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbiBBCpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35862 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244180AbiBBCm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:57 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120bDdo015804;
        Wed, 2 Feb 2022 02:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/U9KUJPKrCbdxew8JaJvpQqk8Bmz4Zj9QXYMkUJMPNg=;
 b=KdO6pTG489prLvj/PuSvFwuxFzE8Jn8WQ9Z9apaWk49l7z2HPHifqYq2I18yhiRkgpql
 dOqUJHr82fF4wwD913FHN2rgFwWIbJeV0r3i8tYJ0WBtHlIPCJouE0JIdmOcWQQaNTCV
 7a31c04pkmbNYrXyL7axr4UIcSpHWXWDu4wF0KlfavCI8hIkrQ7dVvLoD0d93l+Fj/iQ
 BwVSS91TQKvxdaM6ik8aRSfPa4P98Er0qm2OS3zx0vkfKyvzndP1H+CFBISiQb+aGeAY
 Pk/URZrZ3qEes2rqZexQ2+0q0Fp6WN4cMoLzSL9I/l2lr83dW4xfjQISyorSskl7+bWn XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwed015318;
        Wed, 2 Feb 2022 02:42:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q455tEIzVNKYw44o8HYwQv3v6/AE7wTl646lac3U9VYxRA/HmqclA2lA3hJH4CAQFYZeDy83oRu9KQz9+sqrCBmJ+7k0SGPzXdPAXNXeGnZk59jVlk7eCJNQTNy1H0QidjSlzT4tzEca96bcDFhEPLY7C0uEik1edqsyyrDi/rJNYai3eNTYnqTq/1eyg/88bdv5htHR7LlXm7+yOSt7CuuTLfNTiM0ZofTexRHpY0jTkeilRAWv1iYYcesJ2TQjA4sxo8j+C75qG5rGhBvFg/qbi2mWRLXbU6oZl90AjZi2J9RYpMsSDsi1m8kg8adVbolbEn6kT/4BGXVS781NhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U9KUJPKrCbdxew8JaJvpQqk8Bmz4Zj9QXYMkUJMPNg=;
 b=ADbn6Jl0zn0RTyd3r6zekVznwUV7LETfrRWBPWRr3/r7xlT+U8Y8TbrrFYxhseO38Fe+hj3hA9VkHaJp0sicFXzbLL3tX9ZnlNoRX0GPy5gLOySlFhUjU2COXKdFMl50Wi/5c8UMX0Hc1AYMkdDHXN1lNSFy92pAC8nxedKIjGoQg/vRULdutG6C252ge/jTEToZ2mvAMl7/Kr6I5jsF14pGo6pZ6QsfDB7DlgBxw86vtwuJrBDzACcH8xsgj5pxp3P4qhWkTLsOGdnmWYlPu3Ok5HOu+WS6gz418Y38O8jvbYnn0QDvKfYFFYJ0w63FmkTFl/s4xcD1KZ9J78+dlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U9KUJPKrCbdxew8JaJvpQqk8Bmz4Zj9QXYMkUJMPNg=;
 b=rxxMST3rwn6zFgwoeHxECQxEa0oG9M+9gsFuWKELlsJRb22OsIi0FYPrmClZiXBvHfEwjOh79xIH2Gh7ni+spjvUMiqU4cZPa76WuUxsM1ARPAQeyocyQJpaKb/X7JbXRpMs1294DC0aXbmfA/uq6bouHnUy4B1iTkKqq6dsfbM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 36/70] xtensa: Remove vma linked list walks
Thread-Topic: [PATCH v5 36/70] xtensa: Remove vma linked list walks
Thread-Index: AQHYF957lNjiLluBEk+xdDx8+Wi/Dg==
Date:   Wed, 2 Feb 2022 02:42:13 +0000
Message-ID: <20220202024137.2516438-37-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8f3a969-4999-4f82-9326-08d9e5f5b24a
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB41293B3AB0A08CEB10672D78FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRQA77dnUJ3hBKSelXGFcIPizMNJ4c07wV2V75nveRjhxalMgIKB6m7IzGFpYoDnA7lx39yTuhgzZg+NpPle9f80pHvuN4wx3chaovnN9pTghHohIyK4oXgDRURMBgkSNZfKN4TYE8PGAxnWZX/I1RkA+on7Ie1yDmJ7KDIaZB3SCWYHObOwiUmd3H5rFzbx7LIpiLH9C6lYMogdmdVt1TN8dbVyJa/DAIJ8DehcuZtG3aXplgvOi1SZmzIotrQih9vChlIdDhjrLyqKePu4Hgya9RixYoOCcClppdmsNAiAJsNSf5BlPAv8O604YuvXDDZWFNHtZwPp6tYdpFUC1XjSm9dGCqCr5vMaLH/j96J7n2Wl/DcrT1PhP7zDiW9p58ofqhXyXpII9AgEEHCg+ZmfH02PnumXAqCOWg5TVS0tbJvuiuijr0k2i1V9tXzjlWwvUIkyRNDFerqcOM24Syb6W259zjVAhbNWZ4/Uux0Rot0BxH/VzhmSCxSmG3Q65VMAbNDQ3PpXJ88w72L+a+jjIrqkYvV0wRsUJAmEvqtBi1PSkv5LkwVYdml6+xtWipOvwPSbS8DTX8v5ALEoSnMMfm3Y5WuAQGqld8lLbgPwLLF4Ub/+uiu2U8Oaj25hrigZ6DRGm2aY3L7W0/SIYN8xC0Kb0YB2rGrpPT1qmVnyf8XYvY966wfaN+bIUaLL2kyoa/JvQgGwZa5+/Yp4DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WwsWXwm0QF42xExM10glbcFm575YhsSkovA9FobVWxGG3icrt6k6pUOn/W?=
 =?iso-8859-1?Q?MTHjQym0aV+qZ1kGA39HJGh/tYg07DOdqNFO44pgRujPbXNPSpmjLyPurw?=
 =?iso-8859-1?Q?KMCHKUdE+TxBNw8U99B3H3UB7ZXXs67OaVTlsKD1su83ZzfbNbga4YIFD3?=
 =?iso-8859-1?Q?oJpVvgmJo77LGRPRSAvHCHVDhCfzK6t5fnomUoCjXgUuVfs+SQvhXFq7sn?=
 =?iso-8859-1?Q?3EYFRdzg3faLeUwoell3q0CxTExxZjyPyVT1UVX9no1B7NLD7fOBtFgXaf?=
 =?iso-8859-1?Q?lTeTQdrEYHgLmolt/uynABoxG5VuXAWIxViFh6jO0msG8C3kagsYW+pGn9?=
 =?iso-8859-1?Q?nl1cu+/K1HxI5LKkR+KZHqD4J/fEzOuBwZoi9ONcIaqQtar1giGcvhVGao?=
 =?iso-8859-1?Q?kmLm3vMMmlKkBygODdjcWtl3HBy2F1pBExfl7zI5hEaGwoQ3t1xggzO4W3?=
 =?iso-8859-1?Q?u07KL8NiLStWetzU+pQm9W99i2YDNu31OnqI3Cv8cWXB9KVAYC08zbx7Ff?=
 =?iso-8859-1?Q?qxoLX5m38/NfUtvYaMFzz3gY0ywlAuRCCA0Lt9oW00iz5OGtUXr0T8CdI/?=
 =?iso-8859-1?Q?7+5ySMgAwNm73jkJxIGaaVcIu2fREtTerEjychQdY+b8z/DjQEJPTwNmon?=
 =?iso-8859-1?Q?pNazUsR54XrUYr60THkQdFku8XF2sZQXe2aUmZRucdS9HDew9Tij5NPy5m?=
 =?iso-8859-1?Q?+Rk+imGOQ9uIkVadrssWizZ7/I6WnozmWU2ywMuCY8EXsNPtvIoRe9Gh7a?=
 =?iso-8859-1?Q?sR4JHkLhJrgkIiH4icfMJD9tEMkCLh0C16uAtPx5zQ9EJa7aGMSR2bJBQa?=
 =?iso-8859-1?Q?uw63hPLtSiUT/932VT1345aGi1+OPOVQM4iexTHEJla5dfm94jf5v1xdSg?=
 =?iso-8859-1?Q?eHPNTsqWPhPKQ6r2WYKkcBQdPbs/yHCqgZ7JrqO6TyATTqtLXjYTkMNliA?=
 =?iso-8859-1?Q?fPdne3bcibuEuPSK+Hs8axp8uhjQo5MsSFhp1OiVYL3M3Pn0SBQU79TvmD?=
 =?iso-8859-1?Q?CD0eBGGw5Qm4CJFqspJK+Pe1i+3itWIkG8RUSwX75MjXjxWCkeKkJF9Ofj?=
 =?iso-8859-1?Q?lzzbAvX6oPkXOjFajT9pk9MwAazKXdyh+s5SsYe99gAz1xE/UyyQWTqLM8?=
 =?iso-8859-1?Q?4qtJGraBBuf3Bjzq55HUsG7io4flSd5yM52/g3/DWif8H4jrpRYA/u6/K/?=
 =?iso-8859-1?Q?2iZU9bXuHsACs/kJDy9aVTcaIR4SqzoVMK/BfrLp9el1ldDmnmAMuTUAbr?=
 =?iso-8859-1?Q?lL0B6lM84Fsbup+sf4SzFYihXiLyWr1SB3JW2LtiTAsaEhtKMQSzoe4kJd?=
 =?iso-8859-1?Q?1EO7LnYmoPc3Wmd7Ac8GD8tsAxdjkIp9l+I6Ztigkbt7+Bmy8Jm3P0N/VR?=
 =?iso-8859-1?Q?/57XNIwbQ6FwQgimzOziAyfs8figBYBaosMFRQMAFrXBs1v6iBcqfITNp4?=
 =?iso-8859-1?Q?RUmP2p+0dCWbzqVt16AHetfBcjWjeSsVIAVS01pIyuYiIVAiMoy7PNoP11?=
 =?iso-8859-1?Q?eLKmkNw62CHQJsqkahBlXI3VdMnclhBBpKf12mnoOCWBpHLj6hywnNR3QE?=
 =?iso-8859-1?Q?JIe8PY2MCUiErSOHSfvrPIMbUw+sKXFgzbvfwyW+lo6d/hZnHinvuw203B?=
 =?iso-8859-1?Q?hPojht6iSN1NwJxeStNY5SD+WVJCqmFdzDCOdTOzdyNO1+RISIKQbcuIUw?=
 =?iso-8859-1?Q?AD9LirpMNi6PdLFHjyI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f3a969-4999-4f82-9326-08d9e5f5b24a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:13.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgXjJ3e1QygaxTJBdJLOv1or07H3ATfyKysHSvA/xo4nnacwFBYDmpVZhJJoD1RbU+qFbRbGOXhBeew/KvJdyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: luNd0RWzitfpxLMPDyakIoYyxAgcGvMg
X-Proofpoint-GUID: luNd0RWzitfpxLMPDyakIoYyxAgcGvMg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the
loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/xtensa/kernel/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..b3c2450d6f23 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct vma_iterator vmi;
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,15 +80,20 @@ unsigned long arch_get_unmapped_area(struct file *filp,=
 unsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <=3D vm_start_gap(vmm))
-			return addr;
+	vma_iter_init(&vmi, current->mm, addr);
+	for_each_vma(vmi, vmm) {
+		/* At this point:  (addr < vmm->vm_end). */
+		if (addr + len <=3D vm_start_gap(vmm))
+			break;
+
 		addr =3D vmm->vm_end;
 		if (flags & MAP_SHARED)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
 	}
+
+	if (TASK_SIZE - len < addr)
+		return -ENOMEM;
+
+	return addr;
 }
 #endif
--=20
2.34.1
