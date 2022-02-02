Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4424A6A32
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244322AbiBBCpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42204 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244210AbiBBCnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:04 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120eEPi015797;
        Wed, 2 Feb 2022 02:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rKZ/CLZXoDoQ0F3e5nAUn27R7xtiWxUWK31ya5rJ5N4=;
 b=OHrsmOEPBWoK7Vrx5YXRYSD/AzOrgzyY24uY+8FEpP2F5UuohXo6QiN8lyjA5R4LizlD
 mtyb73RM2L1s7tXalfcOlcXmN6tAgtQpIXFRtEJibjwv6/3wsOZQY1KG3/eb5ajLwtI8
 z/nGycwtyU2PK6oKS3W0ENUecA6SquTWsxGmLRRacgIeXFm/MBaEHeTBpN1Xdacqks8N
 8V/Nr+RN6mu5ire+gQ3ujN1RERW+YlE9+gpblff7ufesFY+U/oZMukzbrPuTTgtEnI6H
 7L3m/L6I8QyaNagRkK2jwkVgUN1BVRyYe9FwXSXOhzsvY/4w6nmDIvqzVCkCPkQbAOAu 8w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcnwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122ZsuB007633;
        Wed, 2 Feb 2022 02:42:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3dvy1r8aet-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBlQUZkO4djl/iuXNLtYZXZKvRit37PNTpwo55h/L46d4iZK7GBIuTTDDsBS6ruE53GmRIuX4Jgyx1r9e5AfXhSQwCfDTKOsrptxzkmJBfMxcpzd+Zkcqbgc04gAI09OPFFJQQ3D2329yUy21z9gsDIxzSl+BQ3tRzgBt0+5du11EPVaogPBawJSJvQRTxgWPPoVcdltrwOPy/oZ52bujYYNmqolLz3rSUgYNOBnFKPDSRlCVCTTJ6FlkoQJ2iG+8aTKFK05+qm5lv5L1JPzqh7X65XKfJgM2CM5ZZre0VckBhNxl29V6FHsxJmOLPb+8foB+nnR1O4rR5Re0FRFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKZ/CLZXoDoQ0F3e5nAUn27R7xtiWxUWK31ya5rJ5N4=;
 b=X1x7lHT1iFHwKoN7342HyBkHZr4qvbs/UKWFq0rWaBAXDINjDjo/6hD9aC83Ma/yVDX4Hj43VpPlqK47OlaMsTDTkW6Rp3WOklJFjMj//YyVs8PihM4Z22vn4lZEkZjq4GIzF59YaE2xDNlpH7w5ssWd9vzZcVCRBZkh8HMv3OR3s2XYZVDSwkvz8XzC96jznCQxM1Rudr3S56cOSR6uyrA4HkQM4J0JNcdvxDy3eo0/eQF31ODzfY5Qi0FR1zHu7v0PJOIslUW8g/Uty2PwmvqTZo/Mmx2hdAbBcLRispjeDN4CQxvDEezIMo+DS7RaZX2xBLEyK+jd8txnMunFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKZ/CLZXoDoQ0F3e5nAUn27R7xtiWxUWK31ya5rJ5N4=;
 b=V+3S8IVmYNBGGUcm4QrwatgWXNLgXUMAakwG+YPsbm4h7XO3vslZ/BP3poK9U+qNfc++P2GRDaUFKvwcCOvTQQubHgAg4dk1kbxGkwqz55rKQOyaY3Xw7aFJMSsd/Xpqe8MtRbquam7nxwGRQ1W9uK+f30vvleXWxehmgzumszE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:42:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 47/70] acct: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v5 47/70] acct: Use VMA iterator instead of linked list
Thread-Index: AQHYF95+F5CDCUbjJESPHkKMRZ0nDg==
Date:   Wed, 2 Feb 2022 02:42:17 +0000
Message-ID: <20220202024137.2516438-48-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0a89e29-ba06-4daa-7cfe-08d9e5f5b612
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4801B23B5243B85582432CD6FD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPo0Ej2MrJhUxEC6MaStjNjyafVNYrR2jaEVq9gapJ3pPWiKxULZDIF5reECCxeH8sRN8E21YPvejYWRiOGFplJqmhp1B+2eoPodirZFsI59xwE1IBsaOF6DR1AWTUDYs6Nh2lKwqFatm1us6sOQYXp1XjsdhSOs8vk3CaYdnMHWkA4gGWv+NW4WjghSKzPhKxZ17szNI2duMQdrUYFU7alDtIiHAB4MLHhCaAC0WHAiMK6KdpishFI0GveFW9nFKv6AJIgSeMIGr9YltyLACgmEArFmWSubGA3HjhS2CqSYU64bAaZk7KSjFXl25bB2mlh5XI3E9Wvygoy5WHutuQ8gWJC8iipI3PNqjlRviCeToUZoQfapU0OX6YonARx3DIplcvxyQhzPEYfwIgM6EqMJUFvS2GGOp6Y4bWEEUEzrC6AOAB9+aWzZKCJRIUCCDR/rDo1EEqUvbwu9gEd8xFXyvnvQNzOSGi1IwgkuVrPZK+8CeFRhjKb1N+VqKMCW2kXWnipwkD8Vv7BfpGlP0TYxSw24F3763ZitMfL+9h+G9Bd3t5yTeFvmTQoyQ1Clw8DCNUa1/tL6Ulp4gmWSdqMmLfkgnfS3WyQYeksVz+WlV0fZp5rt3YM5qEHrrUO++IAm6YKg/jN8O0M1sZv4/Ly4Xcg9EtHcKS4NOl8s5/06pzX9ldYApVVHRZE3AEdBlVL5SdDMFsMashxPoM5/mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(4744005)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0G/dox8QMC6a+ynytfDn50IY8UaYRmvxRmOShFQ4sfr4bTSjpwCj+Le+WV?=
 =?iso-8859-1?Q?3UcFdx007oIpSiYNgo1yAYXW8nSuDV+BTJGu7CQNx2SE3FhzA03xAzTQn4?=
 =?iso-8859-1?Q?oyotKrRWW6num5jJTONNYLpNihTRb+KsSiavFKeqGOM7LzBUmty82UTwkn?=
 =?iso-8859-1?Q?9IkS5diOvJ9TBnJoPEYmaWBrXKenj0Vmua2iM4uuxU6CYReKrWbPUJVcF9?=
 =?iso-8859-1?Q?51xO58P0poU3kBSEaBxXDYxXNCp8TFgTJAHEDPVv7pN1zUGEIdnpB5tV5d?=
 =?iso-8859-1?Q?J3pvQwIh9ln8TP3muRWYCgk0SAW0tlU6OkvCNCUUedB1JDWrzHytJutRxu?=
 =?iso-8859-1?Q?u38NlPXt14d52bTeOV4tiGfdS9YrMuYl3qqteOn0srzwPE7nQ42N8CVfUC?=
 =?iso-8859-1?Q?Hzvy+gbel6+isWLInOcDyD5UID8sB4BR0xjqz1Gb3l/JqKQT2x3T7fUqay?=
 =?iso-8859-1?Q?OkGeY7rFw76cITQIK5dfMTWgK4HG2prmNfpcZl/qukJRftJGc01vClJfvz?=
 =?iso-8859-1?Q?IQKrt3LDA2f6yrZ0f0rqLZSOu2BnnSptgitPUQd/l1bin+d8nDzzuhrDSS?=
 =?iso-8859-1?Q?N3yMT52K5GQJ/2NWHw6de9LMz+uvzQi6J8m5JVj+UhE721BQQIlehaxFCz?=
 =?iso-8859-1?Q?ikKts9AufG0fv3lbkCXJvYlzn5ZFoTQ9Bavwy5IBAgxgfBqoHBup5c2r65?=
 =?iso-8859-1?Q?p0Xtnef8KLu8p8P6aiTj+YZtziwFNX75uMp70vB1H6xPDuWEgfHad0Geho?=
 =?iso-8859-1?Q?uXtHTdSeAtUaWveMZvzoDluxFDWLhVldMEup/oPVdFcQlkRoQIE0OBctpI?=
 =?iso-8859-1?Q?ysst7I9ZxYYukcNRA/4mvACeZuFCa3+5w6FH4DRw7W1mnjTw5rVsPq47nF?=
 =?iso-8859-1?Q?4REorqq7QOSscjw466l0K09HWiOW8GHdJjzHydeJ890WBGViRpaZuke06v?=
 =?iso-8859-1?Q?sni37fNN/g/QRQZUMwgrE1gHw7u5Q4Ut0kjMLwmuAXL9cWSoovimlXqxmE?=
 =?iso-8859-1?Q?Ru2y0Eh26BOTC3ObxVOyRQxCj8dKEgGUHPUouqeqM35yBsO1DV80qlDYu6?=
 =?iso-8859-1?Q?57zIz8FFJx1MR1eGlrBcFsXvN0kXW6ZHpsDhMcEJs9oiUZSmP+8s+KuFPA?=
 =?iso-8859-1?Q?K8x352fadyJYABsJPNfwGfbtXsywoORcYzOPhf8oTEhyeQfB2SVXv+r4Rz?=
 =?iso-8859-1?Q?VR9UJS6hqaf2huEdU3SFqylRQxVECcgM4fjfnm9hQ+hXKTOUlbtPTy97Tq?=
 =?iso-8859-1?Q?tom3GulJc5LUOy3hsuS/q9PuzN6pP2lwjO4vgoC1rxe6EYpHh0/9QMGYrA?=
 =?iso-8859-1?Q?HIdI0DnP1zbpEJ5tLpjZKbnLQqGcEt6RO9YKOrNOk2Klj5V/Po6rf2/m5i?=
 =?iso-8859-1?Q?1yQTMeURPbwrscusqkyJdWHVlsiyoR/ACF5SAc08sbkqg8t1Eu2f8CMbZJ?=
 =?iso-8859-1?Q?BQI9bTKx+ciXbji3fIUC+GSn+3CgPWKKbk6Y9iIeXm0nELI/2WnHmocDyF?=
 =?iso-8859-1?Q?nuNpbw8I1tG2X8SxAyphNSM5ujM8xpGEGpslFrq1cAF43ilJ8ySRZt5H8S?=
 =?iso-8859-1?Q?Es/AmMCiSne+eOZyxs6lVyCVSWSfsKu6fciECdmkPGM7Km3ucQLqCUF3Cd?=
 =?iso-8859-1?Q?4lE/lJLrSn8rYH9H+9/i0+Vtw2gUkKciWMA+e1N16tf9n5M+aw9C6gTeLW?=
 =?iso-8859-1?Q?LHido5JBMrWkmbxf7Bg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a89e29-ba06-4daa-7cfe-08d9e5f5b612
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:17.8604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tp+/f/jdVchK9irPhE+TqbKVEgfG/cKvGhWFy+OdZWay8Mui5OeKrRPeuuczqtSZzNyPqhjG1ve26fPBHqJ40A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: lHrJg2C1QEtdogMNNgiUKJwMJHbYzBbx
X-Proofpoint-GUID: lHrJg2C1QEtdogMNNgiUKJwMJHbYzBbx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/acct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 3df53cf1dcd5..2e7bf8d41f04 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -535,15 +535,14 @@ void acct_collect(long exitcode, int group_dead)
 	unsigned long vsize =3D 0;
=20
 	if (group_dead && current->mm) {
+		struct mm_struct *mm =3D current->mm;
+		VMA_ITERATOR(vmi, mm, 0);
 		struct vm_area_struct *vma;
=20
-		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
=20
 	spin_lock_irq(&current->sighand->siglock);
--=20
2.34.1
