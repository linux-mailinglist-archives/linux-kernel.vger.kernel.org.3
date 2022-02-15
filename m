Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3F4B7239
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiBOOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiBOOpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC44113DA1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:07 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhhOD030895;
        Tue, 15 Feb 2022 14:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rKZ/CLZXoDoQ0F3e5nAUn27R7xtiWxUWK31ya5rJ5N4=;
 b=vT45Sn7b3P4vB6vWiwd1ynvmZv7eIooSJ/ASwc12g73tUc8nrbDiAyYNooX9f59bx/6F
 mH3MEhzBjmdUFk7254EU/sJUTiPDYd7PC+HBDXCaexu4U7yYBH7Zj5o8bh1XRAu5Va1M
 nbqniUjVRIFC6Bdp9ADo9DxENVqasC2CD3Ch/C15LvcBm6BlXhR/7fTC3JtSj1Lov7nX
 26mZT6QWfxvaVjqMeVLcFmiOomR/+6oI5vmzW762VhGhQ0zaShApbyHjT8c76kT6624r
 PYV9JJY57FWhiqWQ6p6srDTkqdkae6VYUryt47lVkSyLz//mnEEcXiUgYTJw4b+dsUsY jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psatv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4P145723;
        Tue, 15 Feb 2022 14:44:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdcV4Pqwson1rkJ1W/05E/0ttPPD4PYOWNv+sXru6a6Fi8SX12APzpDdCaTKdDFEWnB63SdEEj65GU9+9idRkSzqFiPyENzfLn/UVRQmaaalHL/NvPkLE+zVbWGNXBJQ3wM85ok+BBgWR67Jpq5hZ//2I7M1H2XDKGooPzMp81OQ7unPdMEP0c9nhYrMFm+37D2t22fWwoICS4SBXX/onLaIjp95CXrEWS61B/fXXT0DeNtwH0H0G3cAHpUSF5+5KFvnmFKpe/YCImbt7vPGlFI/2JG2IQNt5jNbGmL525irM++Id8PcMzZ8uxABHR93rjpdujvtdiSoQc+raAH7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKZ/CLZXoDoQ0F3e5nAUn27R7xtiWxUWK31ya5rJ5N4=;
 b=ZyW8IFs9CreTRG/0ZpYPCOGaXn8GQrKlAgcq0340GA7hjSzlqT8dLOfBEhPNSGltIUOWfZ8+BBAcmsia1UNA+zN2/OWfOyxKXGqvbay1x7fi0YVhsGS9djqJklwuUrRiRhkrDBkVSg5jCX4YWT1DBZc3zXZng2ey1/GNpWK4HVu7TPxsSSpErZJc9casuBxFzKYPwfYbEB+HrKaH/hyUi00IfrSrZy2yFLk7xtJDseYsgQTqhyMVtl47nGfOCVou1ss4AJReeoFhdT4BFHrCeJH4XtSQog2kYGIdxPFQwF5NBYK+gBeBC79JhWbjBHoiF6lX4o6EtS13sJL8ogsIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKZ/CLZXoDoQ0F3e5nAUn27R7xtiWxUWK31ya5rJ5N4=;
 b=GdboLHV7EIK9E3hm7ucBuBBqOz4eiorBR96mJpDSHo6mBKCihnnISLp2oNSkbZvSZqogc0cVoed9mDj4Gfez+syr3h8zDpY0mjAOkY9vzarryKVHx5rLaIKwpsCXpbYXJ7vhmu0OLM4lfiiG/rlLgM+bxTpg7EkjGdbB2R4tGQU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 48/71] acct: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v6 48/71] acct: Use VMA iterator instead of linked list
Thread-Index: AQHYInpgRITBAzEk6kaVNq/e8zg3ZA==
Date:   Tue, 15 Feb 2022 14:43:21 +0000
Message-ID: <20220215144241.3812052-48-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d5e9c69-07f0-466b-54d8-08d9f09198d4
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5578D6658C07C35214425293FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TiCR1BUuSlaBC7UpKDyjo/PKK+BcVpPz5Sv0LiI3It7QeJmE4LBdMtVXgL89rKKGmAznnEUuC0IKgLsXp+ZCPNq7SDz3ge5nenWtQCX8ZQozj8z5tdaJ5IqVUKF2/8IscLVO6uJBE3dCEuMEicN5f3wy00lurJcUWp6gYJyyu+AEsgJxV826LdH/V+jwrCsdLEazX0UnR1dmHozbMALFMCnZhky4NGsrCq+VvWDfP1FBe+FN/zAskhz2fG76YOUFzjeP11s3D399CR+vTyiBP6tKaByEfC4p5HbB3FA8zaELk1j7L59L1PKdqrJ+JZgKp2QjGDKuwowQ6gpNELoK4xyx5dZxxdLvR+1shLtv59Oq6za4EG2CG9pNIbGNkiV4PAUSp9w00M6HLTSvDxU+eDnlD3Hk3F4IGXqFP+i8gFaiwRH1+G5GZHyM80xKWEGPdQHSENWHLFV28/JQd913LFcJ+TuY9gWsIWMFuVRb8VCxGHMcvDf3YYvaFju4TdccJSIGGcqy9MbpNgwCoOYsbxorvq/fJoRDF807hO9qPyyofOnzspdZ/82V1j5HlMX/Ubz1wNdHhdkCmbaRiwhBEotC2Xs27XuAYiAgyGq9JYDgLfLn8mWtUI9VjnclIBQS/nxGq/M6QLKBYwppP2q5f6v512LR1Sqmd8pBF+uwqsrc9Dtpojakfqa9onu3MWk4KJTSKDy/eFo7dOt6qpEUlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(4744005)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n7D51IwT3wUQQHJ13pb1TBV/9DEmwew69Yhovau6eTQ6yS1R9QUbIMx146?=
 =?iso-8859-1?Q?bAm+XlbD2UvldFzfGyDCgcBx0UM2grcuW075Js+FOL7hjVa/ePCefxtW4f?=
 =?iso-8859-1?Q?L/JWknql5aoJszlChmWSqhHy9l0swah2RiZkjV+i4ZhN+5CjBues0HdL8H?=
 =?iso-8859-1?Q?++4XHUG3JCdrQpKxMHOB/X6shCoJv9eomKHeXyJLfGd0Za0DhgsFVkh4Yi?=
 =?iso-8859-1?Q?Fgp5n5JTtVO2HiXfyb8aMn2uTJvcqAgYTuXXGIkgERE0SNorIvZk2Ctsug?=
 =?iso-8859-1?Q?QDjkTLO2ZPHP0LzLCRS51SZYdWnV1Vb3dgRf8RCf73K/zFGIgNc4ZVsMvd?=
 =?iso-8859-1?Q?53eEfdp0c5kR8IWBMkEOrR3I53t2Dli7zNF8OI64MATgNrMNswIplABCkI?=
 =?iso-8859-1?Q?YBaiu1jZmbauH7aZ+fyp+8Rd8nD/08CadMy8BM4Att4gIQmd1EYiHKJSqo?=
 =?iso-8859-1?Q?/uIfR0u24GuC4AhZ2/VJgukep6oCiv00hPNBVE/UhEKn6htvweJBmRzJk7?=
 =?iso-8859-1?Q?D8CD3GH32UmmPx/Kc3RuXl6zr3qHmBqHRfYeHilRMx5safO+K+G8QGhHsu?=
 =?iso-8859-1?Q?9QR+K5jNz6YKUCYkPNITWQfNWS2v56DN/2DV5sPtqZrYjspdqs7serdS9J?=
 =?iso-8859-1?Q?Iq2Ko4kzRqFVaKZthyH3I4Puup/z80PqcdH1JBU9OXxGz1NEthtWZh12xn?=
 =?iso-8859-1?Q?bRkJ8OaPLri1qxwP4EeOHqG+tC3jv+NAVwjucV8vjMy0mLzhqGj6ct2ME2?=
 =?iso-8859-1?Q?RV7eVZhEBi7bUFY62JLwYm24iym4RC5yBPPh7B5a5yP93bYKmlzUyELa1c?=
 =?iso-8859-1?Q?Pazy9YRZkUJ2uhIMxp/A4eQW0DX4uXdPBer8dcjFUELkqZyxZiTtmTEhYi?=
 =?iso-8859-1?Q?Kqxv6Fgbo18D7BD82LapSmFG9ZwQeV2YLp1gpCRycpZSCNWOOPfpAb2LID?=
 =?iso-8859-1?Q?uMwqAm3A2Xog5+qr0hO55ECvITsA+c7q/WzQYktGoat9l1+DgmpGL4ccBB?=
 =?iso-8859-1?Q?Zvffpp4gHJ2xm7W3gqvlh0hsbUeqKnUOn+lquscIvWOdEIy4zExm9NNyh0?=
 =?iso-8859-1?Q?zvExG3MDfeiZ8/a14NxPNyvpHfB0rYCsyPV1+zeOpCfvu7F2UeZaXkpX+M?=
 =?iso-8859-1?Q?7zccvpbNEzjavCwJ+N7fMVJguEPPs5h6+bzTIIZwK2tGFRBvs2JhRGamxb?=
 =?iso-8859-1?Q?bPZDrTFwUNgBNN3C2HpG42xKKDrreugZgPggkaI2hgsHHHfAFdvcLpp8XU?=
 =?iso-8859-1?Q?3gEKxovgRDjJb0x6cDXZiDVz7CSG7uios/GV86DO6WIOmpWK+fIozS9DP3?=
 =?iso-8859-1?Q?lYU45IkyO/NfhAJZW75ql5gpr+OGWB0Pq6S2erKLgA5eXwej5ySvM9S5/q?=
 =?iso-8859-1?Q?VM5dRHMY3FdJ9cttghQOTcmEDvaH83G1Vl7BzshvB3fgidB1ey4weXZiAJ?=
 =?iso-8859-1?Q?TDYveeAcUBZFskE/Uf2szQrJQMH1/vdAM90Wi6vAaqnxVfuQLx3TXUlh9q?=
 =?iso-8859-1?Q?MlKz4ECGbu9jk7kXhpRyzBFxhJnZzhqMyv/a1CvFQvNDjIlJn1jc4LOhT7?=
 =?iso-8859-1?Q?lFmJ5b8UW2lB94W6sSym7WrfmE044VcqC6S0ElFhzrgA8Nu/y/1iZ9yIr7?=
 =?iso-8859-1?Q?d+X2DGc/tB5oPmdmbP4Ff73p5tcUVpoX8ctiS6xOlX7R7tHc3OZAX8EljT?=
 =?iso-8859-1?Q?ouqBrqg06Uq4UrvLtnI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5e9c69-07f0-466b-54d8-08d9f09198d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:21.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29ogDXyp2ArXUhcP9d2Iq3auip1EvWuKd8Hya17liXZxaHtYi0saW2J4Xtov45slcwyxk7QgalLogKyUQ6tTUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: dZuWo_-_B0jI0nqGYLrfBTL0pE1lRAQJ
X-Proofpoint-ORIG-GUID: dZuWo_-_B0jI0nqGYLrfBTL0pE1lRAQJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
