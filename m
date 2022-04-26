Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C156351019B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352298AbiDZPOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352192AbiDZPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3CA158FA7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2PO015535;
        Tue, 26 Apr 2022 15:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=34YuEHpGJ2oB1SxnC5KGn7Y8KrBawlaz8b+7FICQGbs=;
 b=AMI3sfWm03zTYxACW5Kih9lD6Se9H8m+QFSBov35iwbIBwb3peNKLlMCOl/xf8Xd9BcB
 Zr26ZzZjLqPthX2C5gzGBqHBGmZ4tmNVBh4nGR3y7xwGAiIpj+xds1OwyQ4ZzDORcOKf
 qo7VR5asB65QgM0S+UFO6d/VOcYBz2pEe6lyHks/WRLDaFbxS/Q1glE7K8DHSGEPiEN0
 X6BTzjEFBUlVkmQsMwyxeO88MOxDl02zOrMiVcb7flLKtY1y+mCyN08sWx8U9AsFbcab
 elKG/vk2vLPdXX7c1Jz3uxG05DpyVvl1NRiPmkQmZHrS3UoDE7ov3Kaf6UdyZi951BQe uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6USX037884;
        Tue, 26 Apr 2022 15:07:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkuq9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfjRi3BRTbr3cnUE0W9azd7OLVyO21z5SW0x7aHJT9lVDezcO49TDWnUsKKK9g8Zoeah/VDBcJH117jfqTEFSN+5RMKblFizhJkhwedaMzzuxRUCbS7+eNNGeH4YF/vhriQaNd++jI6ORkhloHawn84uVpszhJhSCaPgOpDKrA91X5E0lfdnht82JD69CSJqmt4BB/672kpD5KMITULmCIgiE9D0Cko4BYgLcVc/nEa9mzFprGp1M57oegO9riBrfHTnygteM+mk1BsYTQZ7vEk1kGuKfCezBs01KQ8dhXZE7gy6QQYuvG3/GyDlgANZlL++qc8Rn52VTclNBXT1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34YuEHpGJ2oB1SxnC5KGn7Y8KrBawlaz8b+7FICQGbs=;
 b=apzAqXW826WP2+yWd2T+eHGGDEZCC3+ZZ30szQcSqJeJRelAcC6uABxyz4zEzFlMtNyJ3/nqHUUeFpYCmd8g822xzkPtO7/RCJeBsnNH6/fCq9dAKQ10/yNA0hvsw248igFA3fTHczEevVqtORqIjbp4i6XgOX7pT12M+wRZT/vC0BuTSTgZjJ3HD0SIqhQMZgKwSUx5XOOffvf+Ol3PCUIHAdGRZicM5rOFUR5SnUYnLgoz0NRPqkHdyS7MTBa0NcHHbIlQxcSxscOrUDh8nU2/I3rv6Wn8+gzcviVCoAIPDGE1N/QTxWSER9ZEeBZrzXNMn74s4VhlaP6Rk2gNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34YuEHpGJ2oB1SxnC5KGn7Y8KrBawlaz8b+7FICQGbs=;
 b=MmEk2w9qXTxP7OQNJxkz9UhWGX0838R+QsrfImQsYGO6alXXLjKTM/tZwLSroIaJ0lNgd/SgOSGApXcFV50Rwi2+tQhfSvm/c5gpwJeZxe+X7ls81mJ+msHg6X0KyujhA3DAZSgZBkIetOskZzMLXVG5EjY0p0iuDVISK/t9X5A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 54/70] mm/ksm: use vma iterators instead of vma linked list
Thread-Topic: [PATCH v8 54/70] mm/ksm: use vma iterators instead of vma linked
 list
Thread-Index: AQHYWX9Ajk/XvAIAwkCCUNc7mLgaaQ==
Date:   Tue, 26 Apr 2022 15:06:48 +0000
Message-ID: <20220426150616.3937571-55-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b89a1932-9613-4603-5004-08da27967cd2
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB237776DB60A0D939DE617D0CFDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RCZBjyD2T8ThMfZXPmPiofobe0JGXhqIQD4kdK+G95MQnUZQV77OENN5s060msX5lmU1i1+bmKyNHsDWgclRNIyMJ+7PHnPwnDauCn+pxnXJ46mNQi0H82lspsTOtQN0PujSitbMXTcjUw+wJmaCy70Np3/ISM3W+OcPE5+pa7BqaGDCvEDqqYvpl/MA/KRUH24sEqpswoaQNAUWPUfKn/WprtlS+5fb94NvaLEq9Kj1MCWOtOelk0Z7TYeDAwgx7iGVn9OXnGfBz1l8HIZX6JI+vQhVSdD5WjkrK/0eGWZ25V7qN6/P8L0993LiIVRwxiAmveaNjqN2VVULPKCQYib3+zbtiBtAdnjbDGuQ/70toFrF/pemS8Vcj3ictJ934kZ1fPegWR+uLj9963AjoKlXDwLiYTRRMOTII5hZ/vPkdaGHg4ZC8JfcOue+OhM29s44h1CEi3s4L9kleM7DWTVSvw5Cu7Si3b6qbFF8WfcggBqcS8ISH1ivdbisd9XD6ZvlkOlCanvQ4xLNQrnaxtFhL2WBDktCAUbRugKhbmGqjSahvK15XU2fRhpQKizx2CWMOHGq8Xqp1RTPPw0ywgarlH85MjTedcvW6hftCmbq0wtwKifeAofMlNHW1g3SbQ5fzhRgQ8235KHMvnhlC+73M859RoQ11VsB2AFj1FwYnQA2zn/dqB6qd9cGmzYh/ig/QZvBI8IJN4XEls2bBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jv6LJknzKiMvH/TOn59SyBC4KVMeC7j67R9G66uLNSRviyVY15JUtCwVu/?=
 =?iso-8859-1?Q?BSDdoCITIj9rMFh5a3Yaitb+NG0FD2KAEmCQbpQ12sAo2BpQ0+oQDBNFIW?=
 =?iso-8859-1?Q?Ws4esgXKS00cBr/apYVfPBnjNvusrKMU+SH4XgX+SCUnV2L/8jutEpPNTj?=
 =?iso-8859-1?Q?EgTYiqEXGtmnPGb4G6Cak7Hi9JNH12NBuB+hKoh+ZUEhGFT5UyJXVUD0u7?=
 =?iso-8859-1?Q?Q2jdtX9jwVA/Gvp4JnTVIVZSH26TIOs2vUaSe32yQ9q4c2Dp/L9TSejbmH?=
 =?iso-8859-1?Q?f/2QdC2A4AdgqkKcQf5SI1GUrD3Lzu1qgpXKdjSDKWaj4+Dz8Mc3q9NC5Z?=
 =?iso-8859-1?Q?0FzhSLL5UDEhyjx0UMOevqEf5EwmjUYCQaCN6Fnu0892fas8ui3T1m9nSE?=
 =?iso-8859-1?Q?nrTRBW7mD9V+5K0eWKp3NsyTUIRyGYYrSejfAfkOg1omg6D3JXlnHntzZ0?=
 =?iso-8859-1?Q?kWHfO8pEJA5lZsjagGbJyjuboC2vbqgOsd5kOQcUTbcdxf9o6gaVRrIji5?=
 =?iso-8859-1?Q?wiCx5x8M5aCEmIJudXPQEOhYyFzrbCpkyXnRpMapFWqrKih1HP7oXD4ZS8?=
 =?iso-8859-1?Q?IejkiXpL6dw2W1yyrEyrSTeKtMunU8cieHhX/T+ozJfBpCjq8RFmtJ1Xhb?=
 =?iso-8859-1?Q?oxeCNwNoU38K70jsyT1sOsuI/hvUKOSI7eV+rEyqBNGXsy8IXPMJ47u+Ia?=
 =?iso-8859-1?Q?0QKE70p7WZS1kDqioTR+i9jLbMgZfhg2wAjReOds/IK9eArVkiZwYjudi3?=
 =?iso-8859-1?Q?kSYt+241MP7Z/4+kT+x4RammEIVAYlM+5JJayCzMAbOJBI55yo8vIeK0FJ?=
 =?iso-8859-1?Q?Xi5GNxk97OmDD6OT07jx9R/DO/Cd6iAOZOmayuOX2mWglLuZsLH4GNdGju?=
 =?iso-8859-1?Q?adHJUujJdKkq4vtFCB4kx8H6hhEIx+Ayx5jq57ut52HcjBOXa4GHxcx3hN?=
 =?iso-8859-1?Q?VXqdkJmjwsDaDf6V49NNSOYrA+fNah+XGGq0t1DBrJEsnJGuicF5gVqRKI?=
 =?iso-8859-1?Q?JUMDGKZpbpg3w72ljpKMNaF83rm5uhS2oNLMlxnk50NBOBG1n6ZMbwtzIQ?=
 =?iso-8859-1?Q?jFiNqhkTSu4IiDPU0TKRc+0pV/kh3Rr1Y4tydeJx8cSjTnEJtVd5TVKlSg?=
 =?iso-8859-1?Q?xKdUwtrASqodcjNa+yq2xT8hi5+/msmceJY16+db+ewMEldrfhU2Zcf66I?=
 =?iso-8859-1?Q?pQP1sDPLOqOhgBI7FDq3Fer9fcBdgKOnS7SJvt/vq88SsvpmBlciympXQJ?=
 =?iso-8859-1?Q?OVpMZtbSoltWERpsiy3rRuwLA43x/g98YzW3+kMNCwXMjKwVi5liaKZTXs?=
 =?iso-8859-1?Q?9VexhiedhmkxhTn7okklsuvBVA3M8XSeF6JlyQmOE9wcsK85j639Yt/AXd?=
 =?iso-8859-1?Q?8Qpd4FDdGO4b1zroOeqj9mmPv0Y6EdaIL8dE0yoKLv57Dksp9KA2D0YgJ8?=
 =?iso-8859-1?Q?qKCwC+TqBPjMWDHGHwiQvuq9SCxcyT166FBN9tmtNAbA1FhWVC9CByW9wd?=
 =?iso-8859-1?Q?T7aG72rw8jXgD6pSgoX7lCjuHzEvLyg6bGZh7TaYkpgWqIUJMmGTlSSRAc?=
 =?iso-8859-1?Q?ndCpPr5iNlWcEDZJ9MakxGkUFD/cwjWe6DHdsKTyDuyWlmKmJghk0K29VF?=
 =?iso-8859-1?Q?PnaIGaP98pdnQXjchFcyNBb01rPVu8fVFj+c6zdptaExVIgbf2b9pHz2TS?=
 =?iso-8859-1?Q?8tF9olIdylSgHk12f+9aRlyrfJLEx9jMgPXj4TbH2aGmT56AcGvJ+mxK35?=
 =?iso-8859-1?Q?Be7JZGz1XZrcs7Yqn+w3bIJj3rj3u5xVdb6EPqKZ1sD56yIuTH0bSSQjB7?=
 =?iso-8859-1?Q?pZ/hGMrknHrS+fEUUMWSiYu0jrkowUg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89a1932-9613-4603-5004-08da27967cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:48.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljbJBdzYKCrlAELloqwV9sR73GBMVfMkEicM8KLQ2ZmxLc7hdGfWYRaqvN1Sz5DyoakOV80UoVgR4kndllLYvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: o2QfEiXlrReXHTUU4wvlKEOEGJNf4wgj
X-Proofpoint-GUID: o2QfEiXlrReXHTUU4wvlKEOEGJNf4wgj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove the use of the linked list for eventual removal.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8d5369425c62..fcdceb28d072 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -975,11 +975,13 @@ static int unmerge_and_remove_all_rmap_items(void)
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
@@ -2224,6 +2226,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2282,13 +2285,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
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
@@ -2326,6 +2329,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.35.1
