Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C244B6F58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbiBOOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiBOOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF771168C4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:16 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi0G1014250;
        Tue, 15 Feb 2022 14:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZQ/X8BXQRwstLp4ykq/d2u772ERGIUNQSJt669ccBVk=;
 b=LFf02OgMPMe4LZSvA91e6BfOTBDDJpzszOlrcq70NKQK8PgQHWJZvSADfc5RJC+N9PN7
 bajoaurf7blNXV3h/t5Ed40A7mJQ+WKkbemV7KszIYJDZ7sCUTvq/aknsvKLQpylQJHC
 oP/Df8Ps8uv+vGWkOc7zy/O/E31VueeoZvdtU+HXH2J3CbTMNd5PtArOojlcPTuY+4xS
 UYFY9bb2yOdb2XCB0QFrHIa55GdBWhXAA9zfzNdzSUaILGs2u2WcDEeGYVxj6V/ntxJ3
 JFvLf/46gjIem9QPgrViym5IVX2OYkugP4iF43aiZHj85fAsuh40y0jt+ZKLgwsfn7hv sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8570shtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEf8lo016243;
        Tue, 15 Feb 2022 14:44:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3030.oracle.com with ESMTP id 3e620x7vn0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6IuLau0zr6+cJKrCx43X8qzKS08H9iDDcd8VeFv08asuJoQ4LD0RyZf3RwHzMEp794vBzjTGa4BitEflR8hMQCQ5TSNGMHu+T1e4oKsDbkNLaJqBXLfetqK/QPSCH8U14NZo4ozux0RCX6vjJCx0Gh3clt72AjAsAp/idUCHwDmO4O9HQf2g7mh+PFBPM5o4SVks06eJH+qncv/cgAUfHAVtUjYtOh0Ko9GxXAQ8D2PI1be1XgXrQsSUwqjVOPTdf3njPfFRkc5lg/4aNCFX6ULX+AQ9X8wuc/qxlm9xrMkxWfMfRcHf5As+YS+9UmB9KqU92EvI02fN3upH//CPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ/X8BXQRwstLp4ykq/d2u772ERGIUNQSJt669ccBVk=;
 b=Emv3V2p8harGTNsNvFLks6hIKOrCbuVWrekJrMP8N6+/20y3IR0nxkX3/QoVLePkAUIBCCTQAfsZkMJfZCVyOIjCjWPyf2nB83kgiB/oleM1vaERROLCfr6UGSt5KN5Gp5I19/kIL0vT5Yb4Hj8UifC1yAzvfKo1bHrkdoLZTHDvTjfvw9aOQ7EQ+lUgpFOdRQCB011wZEg7EERB+8aCPvKnOiQ8qsVg3C77sN63jm75kCwJJRkq33+tqgOiXCgZLahLz6FdEeGcqZnVJhTJ2n5ajjNWeZzcX+rgU2FPbP09o62Tij3e4tgILDGvcr//hoTg6loLldkuPrLMTmKFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ/X8BXQRwstLp4ykq/d2u772ERGIUNQSJt669ccBVk=;
 b=noJ7zFoIKizWlh6P4PORMCLdZ9L2vJ77guciM+dTamakL84zZDOKImI8X8qLE1tdvtnmkvG1yDEbbpS4avFap4shKGiNzgIjskETZ2RXt/jdGfSEzem7YisobnmNR/EvNr9OSnLoNhW7GZPfzE7D5KD6zQ52BK1+QD1VfBg03Qw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 55/71] mm/ksm: Use vma iterators instead of vma linked list
Thread-Topic: [PATCH v6 55/71] mm/ksm: Use vma iterators instead of vma linked
 list
Thread-Index: AQHYInpirjlP/mmFC021RC47da2u8g==
Date:   Tue, 15 Feb 2022 14:43:23 +0000
Message-ID: <20220215144241.3812052-55-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ebfe8a4-3e8d-439c-e772-08d9f0919ab5
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB18639DEDD85BC23BB0B87F64FD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WE3bFopJqEOOS8+OvC0ahWvRzYc1n9hqmTputPS7pDUc2LQYGIduWOe3xH3x+li6+lJzbeSYVpRKlrnTZgdcMLzliNLuCtV3EKvPgwtV7vI9hz057oxK7T824DI3q9lP8jTtAxvTpqs8RRD/1EWoDCVvxH8oUtMdzEaJJy9wnlXY1OBQW5sw+TvGljPDQV+QQ2+WJMt2wR4BoCSszM7c3Ov31bfziz0HsNNfK4S2u1n3/HMPUpI0iG0dAwQcvxrVB8E6o2t8Rl9iTKol7Ga9WW1AYxyxkORcpKAqu5sSte77DceJZQf4MEw3MsOd3+mZnM1Z7e0MOn+XVGdWyCJz3nibKunq1rQz8z46YfSt+IYZle7mW6TSC24iOIKEqs+1fJJWGeh9eWmznj7BZYJPiVDVZFYf49vRjgEan6aEHQ/y6e1CudFMiGVehobbuDkOTAAFwQKFr0yhm7k84seW24ky6hCQVArXCBA9D0Z2POhEY0gtuwfPqMXdtI9E8NwWFWOWXtPBZyY7JSRTf7yKeVWN6456AlqIPPokU9mN8qujPT4bZt1qH2KjxGMKsshhZilC4W3wioucNMT79t/8cRgUyGC3cra9Wl2PvNs+oXPLeR4sdU5UqdGZ1Pf+urfbiQxjaPaB/csVN1yfCrhHC55MacpGvbFtDnFD+HjSOfuTcXwKC84q/zb1Pavym58yOE/gFHRtBNoZ0XXMa1qyrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nQwiTjCGybjcgmUWnoKUxQwDzCLaKVnv8wTLkogXdbgAQKc3oqj0pnXE78?=
 =?iso-8859-1?Q?UbOkbxQzrDXxZ5wKgr2LeTmRoEBLykJGXFTa7BhkgxWW7V34JcTxh38cXy?=
 =?iso-8859-1?Q?tFkhwB4ESp1FcIh3L5ntXS3nOmzKBsfGA4jNnUI3wQ8KC3u6Q+6d8cXpX6?=
 =?iso-8859-1?Q?iJSiDQyskqeOmS7IWkOt7kDZimuHolhQAuNZSjRQwEKiQ/yNgwUlatdskj?=
 =?iso-8859-1?Q?vKDH+7/OCS9MRGgwEVD06D0dhSjikgw0TyTH0j7bgyCwPhHhyUPePvM3bU?=
 =?iso-8859-1?Q?tEv9VLmg+wfFQirZvfSjjWZleDuxm8/Z8/zB+klEDonb4FcAzGqwcqzXur?=
 =?iso-8859-1?Q?HV6G/b/Q2aJG0h7kqeUCykklgJW51s/9hmYUIgYA3OOBpjXyGFcYEXxTCl?=
 =?iso-8859-1?Q?GnkFrI/6ZJkNff5Yd/kxTX+CIwO8hzIANUGsUc00WG9oLfl6xaeIgzClQV?=
 =?iso-8859-1?Q?aud7IssWiKWACkA9eQQvTSx1DeW3Rv0Z/UPV6xfbvrl1GMocr+JrtMPVmP?=
 =?iso-8859-1?Q?xNutvnTpf6gnzxOGANADqToETpZAUWNGRVHZ/yw98WPsJBNbj1YKaQTy6u?=
 =?iso-8859-1?Q?lIqV7eUdENg922695D5eyvUmw8nrwq6+bdRsV4+zWFCGxSynS/HusGeZVF?=
 =?iso-8859-1?Q?cCgzbL/zX+u5NF3fqiiD48RR829vJ8ZKF3Ief2dTaR604zToS0bawxnAth?=
 =?iso-8859-1?Q?yc59UTuqwK6CqHf06QsO1ue9z27PT6Fhzxkmu23c+q+iGzW7q00ft3U2Xz?=
 =?iso-8859-1?Q?ay55xGmXeTuXsEO31RNZuwefc9O+8WlcsGC5GKpvFKDt1a7RQ5HmC7VlFY?=
 =?iso-8859-1?Q?88xfbpZ/KCiZu26Y6DYnvJZVh7nAfO1WznZjweMSzWOIbkF+tpD7f1NzhO?=
 =?iso-8859-1?Q?QXuEAQ4T0n03lHWpD1dZm2CamSlYrKxzWh40cXFkTj7sRZ6jcmoQiGrB5R?=
 =?iso-8859-1?Q?KI6n4Mg2l/bWL03/4oh8OFgn0/rhuUgMuXmV77aDk3wDwCmJtJeL1CcvUx?=
 =?iso-8859-1?Q?uhVGuwmH+x76bYtUUzuFBCMAV/Hvt/pzbQUQonwpS7oQEoEtEo8gxUuQ3V?=
 =?iso-8859-1?Q?JrzMlEHa/naFUFDhRsDqgziP67+wFKVJqU0cxOfjjl0hdmA9t5lrXxauee?=
 =?iso-8859-1?Q?dSR9YRx7PmFocxSn8QTfChYD4UMhTlEyiQGdAw6eInzSBeSi7E0NqUpq+h?=
 =?iso-8859-1?Q?vfS0krkkfB24GYKC76/ns6T1pPrExJR9WwMqVdIiz7nz1Oo+QBHl2PEDKq?=
 =?iso-8859-1?Q?jnVMTDvccrujCOBbkk/IPyaRUbIBz29pQUKl3efvRZPLUyEN1cvydAspIc?=
 =?iso-8859-1?Q?A6e/u7m+yVKGfqVgSLKbGEcIUk0oRGDmACyx6t4/YLvdKidCKpvyv74fgm?=
 =?iso-8859-1?Q?AQOdjzxcyXa34lemn4tzYybBJ3UqMOFCpWba5m9mvmoviQhpnJxdvFfGKC?=
 =?iso-8859-1?Q?l8oXV2rnmM0wcGZhUAbayDSDF1jhbPvAMDDlxPp1BEKJYh74ocJucDiBrB?=
 =?iso-8859-1?Q?agCpDf77e0k6I5h+pARVi4y2DyznpztQD75lWlQTAKPx0pjkHK6LwZwS5E?=
 =?iso-8859-1?Q?GwnTjns5b5pBK7l5rBAHifJz+o1npKFp5SVQiY0dADVUBa1AgSsVOL7s3N?=
 =?iso-8859-1?Q?nFMXueAscyl86tHdhBiboaldwG/LX63XoOtCnN8Nj5L3X+y7id1Y9vnfk7?=
 =?iso-8859-1?Q?56G19pN2gQYB5MjYblQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebfe8a4-3e8d-439c-e772-08d9f0919ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:23.6666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Yuv44TPW53m+y782flHJlCM3U4Ghfe/pmCarQHrkSmc2cLxUgl5Ra92o75lcverfkxV+FQ/49FLXT29QNXZyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: sUR0OZv4-sCEIUuQZIcpItotVMlXd-xp
X-Proofpoint-GUID: sUR0OZv4-sCEIUuQZIcpItotVMlXd-xp
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

Remove the use of the linked list for eventual removal.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c20bd4d9a0d9..487e62532459 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -974,11 +974,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		VMA_ITERATOR(vmi, mm_slot->mm, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2226,6 +2228,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2284,13 +2287,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2328,6 +2331,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.34.1
