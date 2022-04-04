Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BFB4F175E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378284AbiDDOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378124AbiDDOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:41:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D23FDBE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dk3O4014690;
        Mon, 4 Apr 2022 14:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/VUOr+7QWdNY0BpJDzowPrLotaFxb9fjERKMaisGWR4=;
 b=MJYm+mlhEYuEHfoeF2xjXHQBbLlhfDi1dFDrKFmOOjzkZjbCvA0bKZ7N+b6PlADc1nEu
 WRTjERBRi7oGT02ceihvWIO0tuKxrwHv5PswnWW36X/OdGqCXloeht3VwHResmj26mPe
 E8r1zh51Uqu+VbX+89zvLJ8GZ7BDdeicDIvLtFqDorwZ9xdfrgkiLGwTgM5J3ptf5EY8
 EIlA2sDrRp5Ax5NMIG0l4HXw/yMMH8mifFV7y00CXePu440vDpdbj6VgoAU759BYlf5x
 1OdfvPwITnzYkP6Ets5vG8hv+Ei4LhKFBKIXcDBQa/NjtJ0Z9fPki6kFW+u8Pqs/AHbV pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EaJH3008393;
        Mon, 4 Apr 2022 14:36:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c9f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrVNKT6hDMuGSvwmb3kGs7FsgIb/dKQ7kjXS0pZxouhBKWSJ4epDMFrqmWy2EeWjdUC1Mh0aJwxOOnoYKKEj2pGarIu8IhfEccquTEmmCqGsOdYMGLDuVg76tXywsJtl5ef8s69CtjBg/oUS98F2jzw5akwSpJTcOmDnSZbfc3t16l/deVFyaFXjJWrFCKyCLq4TP6k+ZXuQR9F4XAIxfjIA/q4IMkvkGSbWDg7qv66xoHmOGQAMvCFpJBRi1d1A6USJe6aykKH18DIusu5CgItKBQf2kitGx28TjvPOx/lynw1G+5F2BGRUS1/7QjTYejgrHBhFKBmlgrgROXcc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VUOr+7QWdNY0BpJDzowPrLotaFxb9fjERKMaisGWR4=;
 b=FL08FxJLF5k34sYSPE+bZco1cC1VLxMtzUyRPwcIQTPSFxLRBLzPRRu2KsqE5R83HSNkQuu0ZYKby4cPN+yGxIqWVtDrzLawn2C6EMw/Gtb08SsZcqAhNtHSOdOdiPA45jjwdpM8I29xBUAf4VPvhfWJaruMvneQ/P1UAhAv/wZa3thqH44euKHYi8Fh5667ggtQXx6yaTK6rnC1VTpqUHEoAPcYQJXLsxdihD2CXWpEcExlr/Lz0JsNhRHPsKP/CurZH4W9a/LrOvxCfJUARW+UrfnUS8AlFPX1CJk6KXiizgjiBzGMbMDda2pOJkOkBAOiLNzcaZVC1Dcn5BsPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VUOr+7QWdNY0BpJDzowPrLotaFxb9fjERKMaisGWR4=;
 b=jl6bRmh/JQwKEKVGmZSFoScfRGU9z5YL0PKI6MsoLa+MzM6h4RsnRJgjSJUImqJPMeL0HcyzdBmhU4QywHMnJUl8lHpjpmhuIfRLJHFKaz7R4rzQLEwZgR4Snp8g+Pqz6093rhYjm+SYOAAaKX93NmfsM/M3tCnD/LWqRsVS304=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 56/70] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Topic: [PATCH v7 56/70] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Index: AQHYSDFKKyMWWp7m5UOs18ftH8Y/DA==
Date:   Mon, 4 Apr 2022 14:35:54 +0000
Message-ID: <20220404143501.2016403-57-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c89d6540-c6c4-431e-020e-08da164882d8
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5742100A63C1388A2DAFC6C0FDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7K2tJJ0jccoe34ukLtQA37up3WjwmCmDJpnUtE3LCrJw9snZja9hVseZX9LUKIz6qab9rFuZ5wSHtYONz8SYyne8NJRkGreVIv118TYEteUujf9cwl4DeR3wTZBT8seMb3JDpFs7hX/d88ZTG9hcajH4lsZK9xS69g0j2OkQOftFWXqCqaY/G28cHysI/GMzXghqo6PQXb9IonmMypk3GQm5iUfu4EAVWVRl+kVV76qZsyErGaR7RAcTBtPwHowWEqjgYIg3J6N8xKp3dpLsQamq6eS3c7TqLzXLgEPJONQViEi/8u8i/5M42JGzqRUdbQXBrGdZvHPm2dqkmvw9Tl7YnJTJtaopMfiRKSuPYl08QwDoYkvwLWhxyEICOybjhx9QMn1vI4E7/EuwVC/BcLvSqLS5Stbz9YaMSNraPPf47GdzOCPs4/Jd2PRuu/L92KcgEmNnP9YooJ2/p+t38FAY1ZnPvO3gUm+mwIc+GPz9Rv7ToVpRb8qvOlqJf1JNf9muHpQ6fxcQlkCbkzgbYbGaj8ZrY5txoNfGQmDNXaHT0u3XoqUom45Y6G26YfhNH/4yxlNDujruNmAPfYn1WaV08t/wSxB+U67ea7J8YfX4zmkCGCTal9iRzDEA9alBJMYW4uxR53MHbCKVpcKGxqQD/1/dGK+E3Amx4bQPiAosUnYRBL4ZyfxOJ2bQnDkOGQyjik5SqkAB331Epcgpvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vOH1J6pauyLZYHrp+13vd736thjlkNhicDr1L1FfB/Ea+I8R1ODTPhMG5g?=
 =?iso-8859-1?Q?uR2XFGTOBkHxUgRhGY0+T+9Re+Cn86MHsi4Cp+jeiGdXpL2/HCUZdvl3U1?=
 =?iso-8859-1?Q?f25ifxqKCNJ2D7Sppn/gaYKGLdgLslG4rKGO4K/a3glN+L1OrFnZymbQrM?=
 =?iso-8859-1?Q?bhlERt3ZamKhoAIEDzu2Q9W7XNOEdH/+Rwnd1tQWQsHiSQHrkqJCYFjUao?=
 =?iso-8859-1?Q?AQMPAttVUj3JLssD//RqI0nX4ND1RB3Xnj+cf/za04Uy/EHF6QQqGugYSD?=
 =?iso-8859-1?Q?TTMqjjJXBLkdh458D7k7jsd1v92j04u+GXVsyIwWzsMM6Rh1dYN3dyQXsQ?=
 =?iso-8859-1?Q?LzvnPNEKl+tpsHYvJx8F0DVA28OMxz9ciSjztt1t69swslODzo1l4eZrYQ?=
 =?iso-8859-1?Q?+IQeAECmmSJZ4sCALne5Am4QUrHcfXeXqM0g7SzQHp8TJZzGCWuDZy2m5i?=
 =?iso-8859-1?Q?rnjk2tWLXIAbasaA01JZIVGufGMvfuLOkYTcSG4yZz/fprJcyAx+dKvJoQ?=
 =?iso-8859-1?Q?45q85Ke3JkPSl56zJzjmX8DLYckCd+XqH8gsdaT98DCs7kcXdP3RXmi5rv?=
 =?iso-8859-1?Q?IgwKDiPu9OBAvGJFswsg81J12QFYRvW6BOZuFCCeMUHGmtrIs5eh/v744K?=
 =?iso-8859-1?Q?RewE0uFVfG3daxZsiTDHUjOWbD0gH8A2bY6FRbSsjHyEOWI4QeNUUrdulR?=
 =?iso-8859-1?Q?t4YoFtByzcoASgUdwotNPn+nQ8coFU+tHj/cAA/vMdFVfn0W/F8pp08B99?=
 =?iso-8859-1?Q?qVW+lyZdGJ+c6FxOapZLUClhjSWCohXt2Dwmbl0gjMSTTijSvQ8sHm05UI?=
 =?iso-8859-1?Q?V8TljMPTXk4jCBxKLBCJZOFR5JoVMEOQol2e+fkMZqYpddIp7KQGgBRWIe?=
 =?iso-8859-1?Q?VlqApyMWGPFcGRcSqvHzPsC7/LgeEfcVv+InwnhjQ8w+sQDbnTVW8I2ujS?=
 =?iso-8859-1?Q?Vt89UBYM1vZKzPdI9ZDuU8RZwW/raIr9R20nLF4rcwagrfTyrxUJkPtthK?=
 =?iso-8859-1?Q?SXAu5Ei9P4US6I5IsIJEt20DtMOASpuElNmC0obls0YbGuS/buTbv8YF1I?=
 =?iso-8859-1?Q?nxV/djAe69Ovccvxuh+8Z25jiR4Uk2pWz2SHGmGa8K2y6TAW6OVtJiIW5x?=
 =?iso-8859-1?Q?im0KtgsZtL8kZLatimLm4rpkC2GE3AyssA1dnlio4j+6bHzOux8KM4Tpdb?=
 =?iso-8859-1?Q?sel6ROvixoPI4xdZsdWR6GXAi33A42E88Tvqil7YfQQ1apMFPgATOS9K7b?=
 =?iso-8859-1?Q?V2hK8Pje/7Woe/HAT9LJz168Y62Se/YN1xzm3pOgA8S1LXGR+O+iNkSkLU?=
 =?iso-8859-1?Q?eMYeAV4CAoM5GB4vlCY1etd4mkRVKzs+P9HPWRIa6u4ptqKcKNslq+mWo0?=
 =?iso-8859-1?Q?y6/acd4dxAt1yXs5xUA344UlSn4+dzhRUvqHSo05WcgPJvEJ8Jpf8rfxOB?=
 =?iso-8859-1?Q?I4J7KEKZNnXUmQaesX1aVLozOfCcvgHYq5b+o8WxAperrAkW+Aj5GIGcMj?=
 =?iso-8859-1?Q?JjOJJZN/+O+rUw1rG5r9vxW9WIqIzD1B/dLjurbEbllidBCu9CQI/NvR4E?=
 =?iso-8859-1?Q?/mRTWV5Q3RBY8PCoI2Gtik4n5aolqY2uoK+3MUIdcpuyECFKxuJadBXMv6?=
 =?iso-8859-1?Q?XaedmVF6y0Z7fJ9eD8iW5LQZVcZpb8yrwInUkDGvf14Y90UVLPaV3KjxNf?=
 =?iso-8859-1?Q?7KYaMTTfB2on8QiPx6X5+E+oHCIuuDrKvvrnQl9k0RJxUC7biX8O0wYVnf?=
 =?iso-8859-1?Q?wOr8jfh1yQ1S9x3YLB6WAGL8Mpi9FWuPykmOZjjKzPUZ3+T1yarm3y/QOz?=
 =?iso-8859-1?Q?b95EFpn89sUnnRArUnAivQNH//lV5yQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89d6540-c6c4-431e-020e-08da164882d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:54.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6l3DxuuO565GpczYxwojQZg7vcxPQSd5g0wWhrOgSGgCuHFLTWrEIh65nUTo+DPrgiuTH1/emNg6Rvh3GttQ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-GUID: sCT6IvfddfZqNg7_8BQSrkmg1NZNM5pO
X-Proofpoint-ORIG-GUID: sCT6IvfddfZqNg7_8BQSrkmg1NZNM5pO
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

Pass through ULONG_MAX instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 725f76723220..114ba712a784 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5755,7 +5755,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6053,9 +6053,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.34.1
