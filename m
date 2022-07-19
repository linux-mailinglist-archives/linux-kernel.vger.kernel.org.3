Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48A757A81E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiGSUQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiGSUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:16:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F03275C7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:16:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JJe047031774;
        Tue, 19 Jul 2022 20:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=BqrbvmtJ7Z16auWorTnMmj+CvW2PnCAzr/dZ8U2csyo=;
 b=zCuN16w+cnqUSKM3BTEcw49EjAkfu+bLR6TQh310ORjU6sH6gmTNoWQNOpP53mCXJ68F
 sOwM+xPIi91gVV18Zvs2arXfpAusx/Z1knYxT4ZMef3ossMKQnIgnNMY5My1K3Ts2a+0
 BhWYzcyhw380pxc6v8Wm1XDU0yXKWnx6nuSHEyM7Ke9CDtXj6p+PhDWZF+P6ai3r4Jx3
 FitjBlRIm4YTT+H5HSpmCOlh5MKcN7rsz2yMQcyp3Pg7YCBKNzq5PORXuhpLxUBYmPZp
 e29epGgdEUsGTV6YwrOXIN+Ziu+cSJ1T33Uue2bq/SiqcHMUR1iDeyzunREE7EmDHaKy 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtfnmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 20:15:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JIH4aI022162;
        Tue, 19 Jul 2022 20:15:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hs7s1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 20:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb64IKUSZjH5aLoEKAS7uHlNZrasJ1B1xbcyQYrsKactd1OZM6U07g1xCGZFXSUYT5I6HjIHu0auR4q/mUcJkYhLgo4ylFSc6XfQP73WJ3EFkvsSn1h/G8gCSyBcmHmy7PTaomQ+iKJd1xwT5QqYYzkG7FOmE/TXercuU+7JWBGs2oM2QOfFIxj+psXSqVhFvfoLdwAR93vKqMcxmJRzYc7eNJDJpObcUHJMCfvT7qs60rDNrPuaUuK6XINOvWX7SFzV9/y/eH7pvQeIE0QVU9MrcdDj3ohjjopgboDsx3DaG20p1IoyG15lOI9quV4s5Dswk/oyy45uWVMbfymJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqrbvmtJ7Z16auWorTnMmj+CvW2PnCAzr/dZ8U2csyo=;
 b=dgpTNmdyT/TrI3ydHu8NPZlc00kf0fijAC6q1QoCt002duQMm282HtNbrT3i++owtR04tckCas9CVmhJw0TT7q4h1Gsn5JcerBG7i/+x5bV15sKKS2rZIKzVQZTD2QbLrJP0fLRj7Rl6yqwOlSLKK8UV68mLx6CEPWu48rACL4KLJ18Vxmxud7zzDVzk4sPOe879KN6M1V404ay0c0fNF8ksZUHH4Cm8kRph3Nk9XvNu0RIIrRuoa27Fk2yfamn+L42UG9xtJhZ8vAt51+p3mIgUBpK3h3s7vbqT+GFV2i36utul14c6nZQXRu2n4qiHWT0szVeH4XhDX/Lyp5CXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqrbvmtJ7Z16auWorTnMmj+CvW2PnCAzr/dZ8U2csyo=;
 b=kY6P4K9MLSDGS8G8DM2x2wrJfZ4Q60c9C8nXArR7FSM6XaCmZtQVjGrkg4GBxfu7vIVA/ryVynMr80NfG5/c27ehHznC6YRrVAZ+Q6WF46/NcmHrOjMiBJl8ret/SnPlsZsfV8UaLefvT9BwEm6DNWmRYaJdzoSn5PZmQVT27vE=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BN8PR10MB3411.namprd10.prod.outlook.com (2603:10b6:408:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Tue, 19 Jul
 2022 20:15:42 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 20:15:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: [PATCH] mmap: Fix hugetlb accounting error in __split_vma()
Thread-Topic: [PATCH] mmap: Fix hugetlb accounting error in __split_vma()
Thread-Index: AQHYm6xRfBPkMQPRLkigWqowdy0vxw==
Date:   Tue, 19 Jul 2022 20:15:41 +0000
Message-ID: <20220719201523.3561958-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea0d0cc9-f17d-41b7-80d5-08da69c3746a
x-ms-traffictypediagnostic: BN8PR10MB3411:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pYwsDqy2R2VSD5+8xKRA4/4/yHeqNaG/xmBzdcURfSmbMV9sgzuFjBL1mGEJW211CTq+yY+bxLB1uLJoNmDD999YbnrAq8FX+mJlWu6FLcfEU5Si/GRLYoJRGZ8OwB5gKVMEQlWusGT8APiOxb8Xyv/aqF8fV6/csZLzvy91FXKyJnpBb3T8d7NAQUOuVIugI4/G8OynIdxUrRz+GTMh7cGUSjzZmzKH+paGqnZ8s4u+79+U0LOLPU4Lq0r4ArMk4y05m5xaXmgOURRXIZJoruwubjkGUP/WOiKvpgxLF98sNDaD/F1JcUz+9FZj/QFdezsyPEq5oUhlYOFi68BDbYE6HXOiiQNQS97dwAamsUFvmGKGbArrkQ1TACXdblHsyarZrROV2lJnp9T1Pkf13+gNQdPYwLb4hQfCXp+HWHlZqUHIZuNutcjXOS3mKcdk9FmCVgQaaCdWMfTdw6ztWM7R7ClOHL1tkop7GxtSnO9c0zXwmDr6mIXdqKICIHP3PKSkAWP5xgW6k/ge8+HYZfrD1PYqrlXgxrDg+b8NbkOCIKtvNGeY2cR0e56gWMK8PtKZTgPvS8SwgLO9o1R8ymEWqo8c8yqGwq2PLeUM6VBYPxRNgHokl9zqrEi4BZpydzqi8fmMu1G+Dz4ydlmmeUSKWxgppycZlfHK9FO5or+P+vEUtxs9pLADmVPbdGHOY6Tkx/QQ+sl0XK9zeYPYPAybYTZ6XQX+4IOAYw7CZNnf1ZJsmKhR+ie8fnFt28S5oB0KAUrsvv/A6C/khxPpCoSvWrNAwsBZMEZ8ABuW7kj45NC7dGJimsH6qP05VXrz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(8936002)(86362001)(66946007)(66476007)(8676002)(66446008)(64756008)(66556008)(38100700002)(91956017)(110136005)(38070700005)(76116006)(15650500001)(6506007)(36756003)(316002)(41300700001)(44832011)(122000001)(26005)(1076003)(2616005)(186003)(478600001)(83380400001)(5660300002)(6512007)(71200400001)(2906002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7KhiRE5EeZBOomnbRHpjjq9XqwWwcqJ3mZRVxp47ELLvLYo0oPNY911sJs?=
 =?iso-8859-1?Q?sGCu0eMI0iC1xwvIeaUxuegG5aHxLWJHMN6JrZuxt1CQoPzNgvC2ZaDICj?=
 =?iso-8859-1?Q?itrdawZRTF3TuoW/jNCzhlnSNrl3gUtxa6ZymY8eXefTQY4St3kVGOCCTa?=
 =?iso-8859-1?Q?4TltuhxF6SD1ldCu4SgzsOYFTy3uNnW0tPNtGH0QpIaOk2r804X5tu7FRq?=
 =?iso-8859-1?Q?RVIm4b4fiLmxt6CDIifLHrSsh9y64yZxIzZYQiZHQPWOUs5/uw9uKP8T0t?=
 =?iso-8859-1?Q?em02QJAYnmHjvsCCFJmc+9/Ov3CLJNH+VcEGOISweuK5yum8Jv1TiaWPf6?=
 =?iso-8859-1?Q?NyqoXt1IZGnYhivFiAeZ1US7V5GKA5sWSgdQqYJxjKiWV04Y7Et8rxabk6?=
 =?iso-8859-1?Q?+llEchoZAwW6Lkqxf7qVLBN6aFAThbsQxFR3r3KPPXa5r7QQ2ztOgEcc1S?=
 =?iso-8859-1?Q?mMBMZTZSdsCcvJdzZFFVHrOO0cK0rJOwTElWv9QsNJDuNW92raT3dSAW9q?=
 =?iso-8859-1?Q?qluJKLs7c+++rwgsa1XOGnRLHf/BcYCIuBoKgC8SYoUR1/7feoKk8PeZsm?=
 =?iso-8859-1?Q?i7H8Z8MwDFstPN0jYtlIlr9T67sPCpneiOtVnlGGjI5DEa6mC4VBwHXlXo?=
 =?iso-8859-1?Q?NJLLblCm/zicK62zGKioHTriWOl83O4dDSZejZ6g+1UgsXmrX+7AUjcoch?=
 =?iso-8859-1?Q?P/RIUq2K7KrumO5ywIJpxdxkNaCVDU+iF8pALAaGCfImIh4E1Emo79LGY7?=
 =?iso-8859-1?Q?3L+tKJGcEgx8zr4vEhHxvT7a5iyuaZt26RJKBMOrllO91wAzPlRG0OGwap?=
 =?iso-8859-1?Q?ZwFBf+dcYsccxbTg9ADIYDOdlWq7wIMoPGNff/x1L8CDDPkPBHs92pnMhA?=
 =?iso-8859-1?Q?/BgXallgH5Bnb/EklgGx7RfxFuCqi33Z4tKDxVC141mhfVDEkGsrtkZ1SJ?=
 =?iso-8859-1?Q?GWSxM73BP7z8I7uFO9ZFb6HzZ1E90SALdNjWk5w3pz8oJRyj3rcwRi+d5R?=
 =?iso-8859-1?Q?UKud2kNsk2vLyCYRttvR65Abmn5BvG1MedDm0WaV86sp0anBeLQ+z6puCp?=
 =?iso-8859-1?Q?gnoZX5QhP55EkxpfDdTpBA/3/re165CdL0OSpftV5cVKvcqP+RPpOJLAOr?=
 =?iso-8859-1?Q?4cMOXnw9AI8u70bYfXnfnYxNoDD/UwwaWAUR5t9+Ke4t9vXEFiVkd3JNrf?=
 =?iso-8859-1?Q?roeRPKxW7ROf/HS+cNsBe9uCYjsrOeemLY8uih0T/e3tZhxdqcsa3LIp6z?=
 =?iso-8859-1?Q?aH6ICxWNjlPhnBfVzMpDZB4+1hA4Jn8Niq4YkbI0kfBUCs5U9yh39KNw1I?=
 =?iso-8859-1?Q?UGnirLxeOTfzQgPiat38Aoh4MCHNaWgNBXVmQmnmNPBLZJFjNigFcWoU+6?=
 =?iso-8859-1?Q?mSA+fBEuqeV2SOSox9Kd7h4uL1sHep6osytqRpeHh2UD2W25ZZHiZpqMHY?=
 =?iso-8859-1?Q?oaKSm36YglmUltmDTHfE/cMOzxzTiXvi52r+g5m2tYp9PAA1iqxBckGC9G?=
 =?iso-8859-1?Q?veviG7lx/d6Ndc7hnN45QO51avVuwV7DxTBlxNV1mlwlxHHrMgn55zYh40?=
 =?iso-8859-1?Q?VwWlvm8qs0MR+sGKFvLFKsipPe3RFKxCSdb2Dd+7n5CUBWcIcDPzcz8D6H?=
 =?iso-8859-1?Q?XtjZpqU9emhSXgiR4FahPU/UQ6jKae3DLFZMDL0EGN0WntvLfuZ+8g9A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0d0cc9-f17d-41b7-80d5-08da69c3746a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 20:15:41.8397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94wkUVBb4eCsb6cfIyMZ2PRT+ws2ZUZUQQvc24twif6mqSY3dA5PRaTk/agXdbd0Agc/uFV8cWvfp9yRMQwZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_08,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190084
X-Proofpoint-GUID: 7_pQDzLRRUE8AY5AoebuicnsQqroqEch
X-Proofpoint-ORIG-GUID: 7_pQDzLRRUE8AY5AoebuicnsQqroqEch
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When splitting a vma fails due to allocations of the maple tree nodes,
the error path in __split_vma() calls new->vm_ops->close(new).  The
page accounting is actually in the close() operation for hugetlb, so it
accounts for the removal of 1/2 of the VMA which was not adjusted.  This
results in a negative exit value.  To avoid the negative charge, set
vm_start =3D vm_end and vm_pgoff =3D 0.

At the same time, move the vma_adjust_trans_huge() call below the
allocation call for the maple tree to avoid any other issues that may be
caused in such a scenario.

There is also a potential accounting issue in special mappings from
insert_vm_struct() failing to allocate, so reverse the charge there as
well.

Reported-by: syzbot+28eb226ee1d37f08087a@syzkaller.appspotmail.com
Fixes: 2ee236fe53a8 ("mm: start tracking VMAs with maple tree")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4d7f7a39b926..fa54d3c2f0f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -758,10 +758,11 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 				return error;
 		}
 	}
-	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
+
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
=20
+	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
 	if (file) {
 		mapping =3D file->f_mapping;
 		root =3D &mapping->i_mmap;
@@ -2283,6 +2284,9 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	if (!err)
 		return 0;
=20
+	/* Avoid vm accounting in close() operation */
+	new->vm_start =3D new->vm_end;
+	new->vm_pgoff =3D 0;
 	/* Clean everything up if vma_adjust failed. */
 	if (new->vm_ops && new->vm_ops->close)
 		new->vm_ops->close(new);
@@ -3168,11 +3172,13 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
+	unsigned long charged =3D vma_pages(vma);
+
 	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
-	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
+	     security_vm_enough_memory_mm(mm, charged))
 		return -ENOMEM;
=20
 	/*
@@ -3192,8 +3198,10 @@ int insert_vm_struct(struct mm_struct *mm, struct vm=
_area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	if (vma_link(mm, vma))
+	if (vma_link(mm, vma)) {
+		vm_unacct_memory(charged);
 		return -ENOMEM;
+	}
=20
 	return 0;
 }
--=20
2.35.1
