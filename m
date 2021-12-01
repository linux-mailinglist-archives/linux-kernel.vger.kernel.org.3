Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E90464FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349984AbhLAOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:37:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56050 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349970AbhLAOe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:57 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Dw8q9002530;
        Wed, 1 Dec 2021 14:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CuULBkn2Pl8djzGFQH5bOeThVP+8EKOAvPiPTs2WhLo=;
 b=aGfSFED5UWSpl9i5p6Z5TXNcqYPa30yK8tI+h9FibUiaERq+9JP5TfPh6csj2hyn4cdB
 bSi1xchioLxhCaexDU2diLy7QlBoEUrD8oUe6IxtiK1n80NvirUQk8pJ8FfFsXxvHf+l
 oEP8Fw7rhAAMPtaR/AswKF67nHEXyZw5nAzEUt+NyW5+Ffk0t28GU947Xf4OCJv+kcDj
 q7YBAd1t1mxgh06DfCY4C8L8ROA0wlPnoZ7XzbaGiIyo0hRK3qE54d5FzKotIh+2LzUB
 gBmOnQMsTC1IpY/ri6vKyLoZKh6QkP2zTZ1hoSp/Js/BAOMI63l0S8svOZy4IsCZ4xac JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmx21t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFM049269;
        Wed, 1 Dec 2021 14:29:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1elDTZAf50rJJxLh5St8TbgTQ3vIaQmrarq7iiEy6pZS3wX8Ox1KjwEODNfy0OIjCP2PuVOyBcaEr3XQMWCCXZW3A7o8JGwZfJAhiXNMJaN3iVhPWHWQp9+jgr2wpAwhRUO3U8bNZXlzZiYMkkoX8eZIFdlTRDwP2HxQ+LUj9YwFR9Ih2Kli52d9y9WOOU6XQeowmxNMBr61cFZF6QzKGPuz6ZnojokF/X4pg36wj+rjSJxX2gfepQL0HqeGHwG5zVRL7NY/FVpXaDm3xQpefiQUozRzIjLLizvMcHtGc+F03m3VdkhjFiIHwyByrTZl/bvFXDM9lQfvf+ssWayaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuULBkn2Pl8djzGFQH5bOeThVP+8EKOAvPiPTs2WhLo=;
 b=BRauJkjmjvNsZBobhWtQof6diKY5c4VRAPCWjNxtSX663d2qpBlFx8wU72O6ONSeeYPonMWBdKuECiWVmbZ/F/+2ggklZKgTrzK49mHBXEyRBbJRPpJ5qeGsOF9yvzcnoitEbMJa08pOLAE4vvN2C280rQHKEv0RkO3Sa1HIPSxR7CJCIXxjIC37RY4DWl4stHkIYVKtMWhdlT3LrBbaEvt2MgZeTehc6iC85drlrb+L44CfjP34QhBA7jUz/+UpzvSE+JsSYaqq2ZGCh1edxOuCtzCPybz/N66co7ll3KjVqBcNVyRM7k++or4FJQH3bJji0DIrj7+fvEfR8E7zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuULBkn2Pl8djzGFQH5bOeThVP+8EKOAvPiPTs2WhLo=;
 b=sJP++4jLvFtLtfyzzAuv1yjbSsXF4++/4xiYhjpso4xAsh6BUhL31i7rHxD27tHbD54cQorsXWEIDhu9lWE1qy2nACwmGHo58+d0QQV5YlEiAMpo1BwRbakA6Zobk/cmYHxdPhcB/7UEMf3bypatKAaPeAK5JxGBETbvO1TU/Ng=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:56 +0000
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
Subject: [PATCH v4 15/66] mm: Convert vma_lookup() to use the Maple Tree
Thread-Topic: [PATCH v4 15/66] mm: Convert vma_lookup() to use the Maple Tree
Thread-Index: AQHX5r/pa/3zIKn30USZuCbXNikPEA==
Date:   Wed, 1 Dec 2021 14:29:55 +0000
Message-ID: <20211201142918.921493-16-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6e84d2e-28f1-4b8e-89fa-08d9b4d70bf1
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB276855A8A9565290BA99D717FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qfr08IwVPYP3842GJHMAzFkk+NAia07etXa3r1JKonKaYDF980mfYI4YzJuebN176mIoGrGmY6IzAEwx8+aF2S2V2w9llfEERgM6nMmkxslnNAy9pIhZlXkpTCMdFk4KueOeankg473umGFr5qIabyWfrHkLfDTMhmsKMjSr3lxEWrwZFpRqDgtb8doZhVLR8CxK8FwYGA6Kq74+zdDquAw+rrJ4YMwh6TSxzBGR4Zc9iIB47q4MqqnzepaW0Ak5328E7JdM5xg//PNMHwu076CNaW28DlORXkv8vj2miCQ1HikY/cAgEI0ufOdOqDMgN+3VlpZJvnBumhfsjrPFX1xBF4mdaKRGt16NxqdNp0DeEAbBUlUyZMZvtcJb3gocz8O/nziyuG0XTj/lNSViYbfymNhNLWcJk4OUw31DHW7/QDZTBnmgpzZvl4j3MIpF1gqAQK2IkdquEemcS+R8kiaB1Fii+QX9BWU+eOqliQY3sx/DiOeS9Q/Jf82rlH9q46XETVg7DMFpXoR/0y0SvK4nn0fhWR1vJtpd2H6hAxmRhfQz5LrfcmmMbOrYRZNCZv+U75JRBEmQP/r1Z1kJ5HSbRbuIoU7HWgnh6uIuCSOvwPnNFjxpEhpUlykANUPlL0TdZD43RRdp8xjJg0wRpxum5iooXC/nCIQwqodQG2VS+PTJ5YzxZclzExuoL/qrDE236Hiehv6FPjBoTijRMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(4744005)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jZJLxFK1Nh2jW1bJh2DomCvkfAZFEU5WYsyrRgplGUu/nrzY5scAoIa5VL?=
 =?iso-8859-1?Q?pKc/6RrWzRGWcT7RHqzUhREWR2aU5Sy+qnPmvHIfrBWoMFjBgTypKO8Iyj?=
 =?iso-8859-1?Q?OeQBw48MAnw1ua/CeU0Aaw6iZ5AcggBzr24g2TGYZ9IWvKs23RpPhCXt2l?=
 =?iso-8859-1?Q?OxBQYH7d6k1qcsbdhyW+MUml7zWFhKk1ms1518yDaXw/htOfXCC4F/zCzJ?=
 =?iso-8859-1?Q?8Pdwu4z/9A3FkHjMOuJl/pF9S/3qmObZQOW3KgUwnUGn20GAwD0AoNyg+D?=
 =?iso-8859-1?Q?iYeRm0VLvIMMyQh81MBPxzxaHrFk2YgkyM4c4b5R5ZXWg3WktyylKHKVVx?=
 =?iso-8859-1?Q?dMPXJ07jhMI9R2U33+JV8YaD1OGzKapeuoLk3fP/S6/uGF0oR2OC+VJvMa?=
 =?iso-8859-1?Q?7XRD4dRqeBaVa9ToDB/U94HMKuTjUI5QpBMwnvAkVJhufeDRcu1fnZA22R?=
 =?iso-8859-1?Q?Aa7PN9CsGS3c/ExOHErsyQpGzLsJExhVsJmDz857jBxXTQf6UencXd5TDZ?=
 =?iso-8859-1?Q?exkYbj+6LygGOmF5+OCGy/wcwpFlBLysm6h+6clVE3obvv8FUqoFbjxPMS?=
 =?iso-8859-1?Q?GrPedcxmNLs0nlZoHBAqTewWC1VBZk5pbkk/Iaq6FP3GKDqu85+EJeWQL8?=
 =?iso-8859-1?Q?iXBnKsiwQ2EEvA6uo7eDs4arwgq9/BPi9miGzzWpcvc2cKA+gSciTtqg0J?=
 =?iso-8859-1?Q?5dgE8SdcUNNEMz5rWN+nS1/PWFYNL4aCWuXq/zOu9JwdUx81MxpgQ7Hfid?=
 =?iso-8859-1?Q?2oF8J5zd8WBRiMcAx8G4GJ2UoKL5U0JwXYX3pVYv/Kh2jvwVeWKMJF/Jej?=
 =?iso-8859-1?Q?auI2F0iwOH6sgAgO0LSopmn+TgLJlL4c0lJLh0ImuXxWscD73h6gLB4c8s?=
 =?iso-8859-1?Q?7WUVR2wH3FO+xtZp69duu561RlBAlPhVgUWM4gATTgs+wSJE2VbBmKU9YQ?=
 =?iso-8859-1?Q?fWFZmG6KGTpRIOePEnNQOM43tKTLSQcV0yd6H6wgEkTBgdDCA7woaeU+lc?=
 =?iso-8859-1?Q?EDQOKF8rcOaj3GiOJeMaA67+nB9qK+xMshIn8yanlUNdJ0WMW4zfHAyEWc?=
 =?iso-8859-1?Q?r8JMpB6dktLeovHZMuNg2KdNBLJomjsr7vHVk7Bpa47wQ37owv6OEPPXuG?=
 =?iso-8859-1?Q?tZXRHT/UdmrBwu9g2OPa68ldPi0+edT/O7tfh2rx3mld58KSLs9hmpFIdO?=
 =?iso-8859-1?Q?rguEaFoOJ/mZd86rbN0Pduje6J+8lPWC3F+mSQQ2ASQ3cEfGLaJd2/AKHP?=
 =?iso-8859-1?Q?D/Ynm7aK+mz9DZhF6Ee0USe7pdWOITJOFL9V6wetvZC+qMUq8k8XIMepMb?=
 =?iso-8859-1?Q?6jIbGPxdXm3ZiEjR4bm7UBN+cwyygdSE8cLXguzpc0eJNc0411T88jQtBZ?=
 =?iso-8859-1?Q?i8uMMHLjDJi6Uq1u+MW4PYJjrN2NFZv/kJp4jGJH2uJCWPMocFISSmMcVE?=
 =?iso-8859-1?Q?PfIDaMQtQds4vrlcgLenRNCNSoMggLl1YceJHJPcnQjVQ7fnKmRQnLsnpV?=
 =?iso-8859-1?Q?1q66esqBWyXdnEAyb8oChwJkhEdgY8bmcn416rgC8Q3nGdrOaewmw/y/a+?=
 =?iso-8859-1?Q?/ajaz/NwI1bnzF1jN0hpRM5wTIEwfvT/ZyLU0Ijidk/IqxPZAQnUUAoG3V?=
 =?iso-8859-1?Q?dNsO8oi4acb3SCLrCzXk+R09F1l6ULZYIcrnEIJDBsZ4w2SyEa1O9qhOsm?=
 =?iso-8859-1?Q?wBdzFj2P0KK6Ziwhskk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e84d2e-28f1-4b8e-89fa-08d9b4d70bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:55.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZF4BQbC53/Peca+TJ+XBZrMNwENCLuk0UIxeQP3XTDMX12Dt/VAeguaDWoJUY4aV9vJ5O1n2EThYGXNo+AtFiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: aeWkCtuyAcigBBU0FRwIaOo57-endqkc
X-Proofpoint-GUID: aeWkCtuyAcigBBU0FRwIaOo57-endqkc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Unlike the rbtree, the Maple Tree will return a NULL if there's
nothing at a particular address.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d5ab70b1f6d..c28bd97a4ecd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2845,12 +2845,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
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
2.30.2
