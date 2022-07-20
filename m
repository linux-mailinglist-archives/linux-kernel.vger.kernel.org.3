Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BD57ADCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiGTCWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241139AbiGTCVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6506C125
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1HGGn003844;
        Wed, 20 Jul 2022 02:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=76v21Z2JVV0DXNojyMGHN1ka5ATJuHZl9ratM4Ol8cM=;
 b=IY3HrY4J12p7llkfUnt4yeoSapVxaGC1gK2whEIAGUntimWTDV7u38aZ2PHqdpN/CQ4/
 UluTwKt8N9wwS2hYKh3YyMR7UMXhAu3xmcz5Gq8sE2CfC3Zfjn6qGK+416VWp/xpbsi1
 OF87pAtTu6bbdS4KFxjVcjKNMgLclC9LzmA6pGUsL3eE8FLfYvvNMr9TLwiHyvGyCbuC
 S2MVPyJt1z+uJGPE6dCpt1pEBgP+ogt+Sumz2oS/NVaukzrHJdGALoma7qAB7A1GV0TP
 fkHSdvArx9oOaZypYF4G4zu3331Y8YrKKSHIfvOLvAjrgaf1f2BYAJTZp1RRJ5ETjvwH 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs83ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAll002689;
        Wed, 20 Jul 2022 02:18:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I401Hs26k7ypVCnD3/5mSJy98EB/engf1CGRpYXNUl6ZOzt7wFt6JxD/0bgQQhVwtkinpnV2PO+xZFKPxwWQOvb/Mo31sZF4gK0paOlfNtTJfDrpmMR9aWibgNdVlQAhuf5tjy5CbAjmgn1HBRo2TWwAbx9si7UhUbjFfC9Q3NJgy/8YpffdwBFUhNrwiouw837pA/g/9ECleNRVZ/bVJh6HmjrGi+bbGAwWFK+3VHZUcsKAEz4iM84uSOzF+PlXSiGnv0LvNc2niQSa1N3RTrEqDGpDccEO9DGW35TKiqI1QsiqJSc4Pyu66OBbrEteS0h8GAAxviSSZtgUiyE1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76v21Z2JVV0DXNojyMGHN1ka5ATJuHZl9ratM4Ol8cM=;
 b=Wdamao739rqb5mPH6mHEh6LBzA8ypgG6SeQk+3mMZPifu9M3vflUUccTrn+8eqfJFBvywxpsPTq/ldbuISDsP28/TuLg1f+fWsE5rTF1f9xXYsr7cEKJMfUaeWrLtUsy5AswkmeDs16s7RaE3JWaicfWVdQVIR2Pz5qQJwD++bqpcJ/pX1vWp08BJMq6wTw1KDoSv/dlYgkmvb1gEo9kqmwCBtDByW7O8u5baW9zrHuTX6eW1UJTtFeEKW9iMaRVA7tQB8GpTSLJ8L0yfSw7MVBLu/K9gczhVIgj3JzC8zLd9Ag/jfeg45oXKOEIcg7EnOAUV6hlQR+UbEcNROH5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76v21Z2JVV0DXNojyMGHN1ka5ATJuHZl9ratM4Ol8cM=;
 b=LxgFBxChKhFc+RmDbycBu/pgjSZ8HiE4Ffrj00IzdSE8nYVzfEObQAg5ZljPzAXgaPz7DX1jhks7xq5LfkKv+MKDZD9908Qst3mAeD3GqhBQWGPZXq9t3LK/eJMS5ESXvSp3mTnnMkN2E35dHZnWPVcedPmRPMc7o1VRw4kETNc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 40/69] coredump: remove vma linked list walk
Thread-Topic: [PATCH v12 40/69] coredump: remove vma linked list walk
Thread-Index: AQHYm97tVmhm50uyL0mCV4D3gnNhOw==
Date:   Wed, 20 Jul 2022 02:17:56 +0000
Message-ID: <20220720021727.17018-41-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 537d0cb5-0566-4469-16b6-08da69f6256a
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kffygoXjw33bQg+f06IUCNJzp+hiisSuAU22c6UHBBVavQqi0S6HLFuN76Rz1pHIFQyPDTA55iO00lVuNNDhsTn6noFfDRSW6Uzxw/Uhd1IrTdCnwOWMHgFvDXSkwYQsebM231qEl04gxB0d8CaHmGcYvtzPomqsc8fdjKFIKTjrw8pDbKuZqPn9gKUHfYajC0J1uEam5oVFLYWSR+yZT33kiwjr9SPQv1HeQkJ4I9CgmPqH9xhMt+UM65fp8ohIrYShBHlNndQ5PrT7/KheoKMtlHi5YQBOHhcHKLEbCyS1XO9lrNKSjus0YD/4pIbHORRVOph8x1NuYCPd6nUOcwBxkUyrSsNrus9R13TdMpgpeuHRb2vsEkYaIrNBoQTAVCuTtmiBAjSLIwL5cmA87iXoHt1RzWd5v+YDfeFlDJONkWrp91SDq6NokDnhXRVEdUzhwEfMA0opuEAsguc8gmniuR7xgDH7b547zNx4SvpbYoYWnmFeV07+p1Gj3AlGbJc0UuoxhtsDVZ/a5pii+uEbduHYQywWd8xkrKCWt2shER0bx/g0oi0LF/XQlJ90L/MO0CYuaAGeJ+AMeiwnlocVKNNmoYgWqBOsNh9ACucduPd+vSJ4zpa/4z4VFwfF748vngSTQugF5JoW78OT+lpUbgQZy39ja9rrSicN/yyhrKndiloivzlAGvYWKr3Ic7ZDf07qcDQjrsbgOQxzCrq9RPx69CjwZrf2epOiB4/9VsMaVSvP/C3LJV0/L/Mh4O/PMy9q0RyVcypcsQNW/PuR8DC0XV1ZZ80gv1YYU+4tv+A10zRr0yL7z0C9ruEtmeflQ7M83eoUM9vqEPHgeiubqUO46Y0B38zTN70dcPzjSNcgQcA/iS7hFC7AqtOc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RyS45txTCS1rsJfB18dt650FPuX2uQB0x5c9hq1N8vEkbKNN38/aO3u7UQ?=
 =?iso-8859-1?Q?5prz39dOoM5Epe9CKI0Db5JRpZGy8nmO1rx2WKAOHcj/ujcKHWWNJja3+a?=
 =?iso-8859-1?Q?LSnKesG25ULDKRr694N5yRcSlj6pch1DNwcMTfqif2QVt9gKX6foca4FOv?=
 =?iso-8859-1?Q?mfCd9IoiBvFszWyMT3W7IiZvi1bqJR0Xe0Z+Kod/SJmtdYYG3JMrbTSS0Y?=
 =?iso-8859-1?Q?/pls83opkGE0ri3y0JpH8ayDtOqvcZJN+llGnowL/dU0nuygogdn4yU1xv?=
 =?iso-8859-1?Q?BtYje2NTMVCy8cRfuhrG31yJ7zyFM8e13UrOrGwQbJ5YoW5yd8aQcHAXlR?=
 =?iso-8859-1?Q?2IUdfb0OYgnSYe5Gp6UkFRibSnN0WDIXEJ3Gy+X1772gbtnESQzcki4/Jt?=
 =?iso-8859-1?Q?KHmsEfYqgwOqyuM2IZJmltw7PsGS8QVF3zv/SQko9dcFJ0W6iuT8rcTDs5?=
 =?iso-8859-1?Q?nMg/R4psPBEPpB0jVxHBNw5I+CYZQZy5yLnLOPmoXBDQVuexlg7yn6jdOg?=
 =?iso-8859-1?Q?BAwIbf4yr1H2Cv944TIvhHZvZobwaGJBIWDt0FpeZgdmtQXg1o3+6ZXyNv?=
 =?iso-8859-1?Q?JyOoTlEx8JgolHWcZUwLF90HmTIAhEwS9fRmSSTEqUbygR1rSLh+chkis+?=
 =?iso-8859-1?Q?iHmC4NgAvnHyudkom+sx0zptO4KnhSb9kdTaWsbHu8e6N/j6oqdk1O3w2H?=
 =?iso-8859-1?Q?UupOUog4MWpwRSpwN13UMJYYEELAU22zxT0TOP0PmBblqz+aINLn9v5n7o?=
 =?iso-8859-1?Q?vod+IOzEBFKMlXJQll6gEh2k07Vxxu6SXJ6P8CgGCc0yApE6BQowzweex2?=
 =?iso-8859-1?Q?tXEDteHL0aULtmlFlG0iCxxkHuTb2tX5y9k6sNPgYhUy09ZIJvvJ5lubj1?=
 =?iso-8859-1?Q?2icozM531O5vEWM+a4jAyt1eZpR+OY4DO59sV7OIS3abgrR8J1X9nMO/Ge?=
 =?iso-8859-1?Q?fI5XpI60g8hIIDmpPtueYzk5uRufhdLBb7xOo7kpNlZaCura0fvaEjZo/7?=
 =?iso-8859-1?Q?YoJI7eUjpWlLrofInBgx5tCeTClvprzu4RL7BHzsP4GKGg9bi51HqDh1n7?=
 =?iso-8859-1?Q?Lcq0yAE47mxvrvjU0IyBvwWRk6yk+l+WYasBq9OQWAi8WZtNH7glIsOSwa?=
 =?iso-8859-1?Q?/v51u5mowdsOl8Lv5n+96tPWj/ULXinbDmWG1Yr15kXCNO+KkbEAu1OG9Y?=
 =?iso-8859-1?Q?nOUEDt+yEeBaBzQseoeKeU7z/EDWqKK1+wdijgITxLwcqjze8AnxFRMHHI?=
 =?iso-8859-1?Q?6yAuBxDYrom9g46RysVPo472sakFN9rme/qVb/BKFLWWaC8jIdg+792eKa?=
 =?iso-8859-1?Q?TEdjEyQJ2ywA6u0fIaljIwEcswn2C7u0Yw9fZPJ4ZsdD1+tDPf1Ax893UA?=
 =?iso-8859-1?Q?aRcyF6rLlZ51VenusbHeK60b74XIOPuEDCU+4Bv4IwmLwA8AoFUm2GZqLF?=
 =?iso-8859-1?Q?vjDKJkvM1inDCz8UbIz6j757EurTL8C+aJ/sj5eSNQmrgH70Ch5Vh/fAm9?=
 =?iso-8859-1?Q?NPVTBmWE0Y8If3CgwC/XoBejgtwivGYgZCjUCABDOH6wo8ZMLBp2x2BR1N?=
 =?iso-8859-1?Q?7sq8olXdCBcCadHBbb9k2BIPHz4kVoxKG1sexn36YKs3IpaaOrpsKTFht5?=
 =?iso-8859-1?Q?xws5JeHjJOpkfdROVUrGykXGP50RxZvJ7q4QxG594Hf4yuPS07uBb7HA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537d0cb5-0566-4469-16b6-08da69f6256a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:56.9304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vO+A2fd6RY/CqUQ/OG6N21rhper/Rj2kwFRSwERYrmCLBS1876KbhovHKOtMrStCjlAccb7dIqj8ttuM2k1MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: Mhk4xJ5JQnRq2Z2aY0D9evF8A13ZUVMf
X-Proofpoint-ORIG-GUID: Mhk4xJ5JQnRq2Z2aY0D9evF8A13ZUVMf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the Maple Tree iterator instead.  This is too complicated for the VMA
iterator to handle, so let's open-code it for now.  If this turns out to
be a common pattern, we can migrate it to common code.

Link: https://lkml.kernel.org/r/20220504011345.662299-25-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-41-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/coredump.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..3a0022c1ca36 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1072,30 +1072,20 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
-
-	if (ret)
-		return ret;
-	return gate_vma;
-}
-
 /*
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret;
-
-	ret =3D this_vma->vm_next;
-	if (ret)
-		return ret;
-	if (this_vma =3D=3D gate_vma)
+	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
+
+	vma =3D mas_next(mas, ULONG_MAX);
+	if (vma)
+		return vma;
 	return gate_vma;
 }
=20
@@ -1119,9 +1109,10 @@ static void free_vma_snapshot(struct coredump_params=
 *cprm)
  */
 static bool dump_vma_snapshot(struct coredump_params *cprm)
 {
-	struct vm_area_struct *vma, *gate_vma;
+	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	int i;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int i =3D 0;
=20
 	/*
 	 * Once the stack expansion code is fixed to not change VMA bounds
@@ -1141,8 +1132,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
@@ -1150,10 +1140,10 @@ static bool dump_vma_snapshot(struct coredump_param=
s *cprm)
 		m->flags =3D vma->vm_flags;
 		m->dump_size =3D vma_dump_size(vma, cprm->mm_flags);
 		m->pgoff =3D vma->vm_pgoff;
-
 		m->file =3D vma->vm_file;
 		if (m->file)
 			get_file(m->file);
+		i++;
 	}
=20
 	mmap_write_unlock(mm);
--=20
2.35.1
