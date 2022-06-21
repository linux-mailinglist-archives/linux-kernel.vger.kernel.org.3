Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C76553C20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354920AbiFUUwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354715AbiFUUsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384682D1F2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LIxkdv007500;
        Tue, 21 Jun 2022 20:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5DLDHKfMruILMmE7X+VtTlaoYhXFJpMN5fM8dsMlghg=;
 b=Tgmx7N/3ALMOMHczKtL0opWDZhfyW7LRdFgpaV5Hct0aCIzhwMJius1w9cP9VoQ2S1QC
 GUbr8Fwv1cY5WesUDheCYwbSvOq3L2yzU32NQP2ixWGrbVqBlSV2Wlbhsr4oNcV5kfQp
 5m/61uZjbKjKDou+5GvnEa0EtkCmtjJTJVDS8Qz2s17pkbepdul0hPO8qsh5LK/pCR9V
 NBib0whvPxLLG26Pi0o0DlemSDJl0FPVbNTzEbfr1tfa0j/P7L6bwpRtrI85nCBtMRPk
 WOFgCb/zpvjNcj13qXv8prS2Vx53e8oZ7G0nvTcSh02h9cjZQF5zxGfUOQ2KWtaKkJk/ RA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1xr98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKelef037913;
        Tue, 21 Jun 2022 20:47:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5us974-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnCorvGXLgOO7xXccAvMkFk69ZiOrg16UFM6203xGdp2NsqoCMen8AzPv1Ga0T0fVZS0wFpyK8Znzwv8xBHeIco+UE5mRnoknfb2DAri2AHxj5wowhFGgMHZDXqAkkezj8UvefTaFlNbbi9TGbWaFaa/J6TtgI0U12UPpQILRD824AinzJ9NOk4f3lGa/9Jltc/lg/ZjIzOZ3TcPVFkWWdwtlNANzeny0ZEtUxMFBuXQ1DmkUMksDsZS5zUXuflZMKjWs/JT306sV1t/RF9WsGu4PSaLajSaJ8XUA1daJf36h4S89xH9/wybEexRbgAkf57xYDhTCpF4JGn4lESbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DLDHKfMruILMmE7X+VtTlaoYhXFJpMN5fM8dsMlghg=;
 b=Ngs5SCOgpmFYsZWCmvO4rYug/TBPyKA5KoRWemNVBIEYNRLpjFzIGyqO5LrSb/zXakV4R84zyrI76F7vRCnysRYPw2u2I/E1A94F3BfLjXCqrJssyT8vUwMVw0mcHvnqqOTGTbtNkke9HhLQH8RvFjml/YcTWnSybuwPGgfwg6ZsT4yYhsbZgkkjVujvifbHjSxsCzBY8ow6FWJtGHy+IdFWsNPmTTV2mVLQ3GXI7tBNSOuxmXQwchnJOOvUka6lWRg4qStx8YWCcO3YbSpKDXB2TF4cJi4QOdheYtZLxVR+H6juGEY2wim9KAYCllVBRPIX+8aFq3wGncIVxTzWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DLDHKfMruILMmE7X+VtTlaoYhXFJpMN5fM8dsMlghg=;
 b=YYAFqR5N1hxywT/q1YBB6H8lR/2MYo9c0VW/satLJ2kaRXbvp+UTMZpdYmVtYmLe0q74Mm2z5vcJ0bKSaEsKsGQ2w5pFW9ryGXH7qT00JlBpPwKlTT4KnLLW0ogl64YAzCz9fUeL3hKhIbP+l5inxQAJTMkPToiqnjxPRDWY7Ws=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 59/69] mm/mremap: use vma_find_intersection() instead of
 vma linked list
Thread-Topic: [PATCH v10 59/69] mm/mremap: use vma_find_intersection() instead
 of vma linked list
Thread-Index: AQHYhbAUmkAJjxrL+UeUWHrPJGAscA==
Date:   Tue, 21 Jun 2022 20:47:11 +0000
Message-ID: <20220621204632.3370049-60-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d3fe584-13ec-4162-5a2c-08da53c751d4
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB539261131FF6C4B55F1D3A9CFDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wF/bVLSzXGQ5gtrWA9dtl32AqYBUVdIN+E8TtR7WHx1eh6dMJAl5wpCJFaRL76HhfRZ0smsUcEJ4aNKEq/gSJO8u4IFmPZZaOBgoC6s9SU2LMRpmpDNyZDiIpJxqWLWwg+3W37u1uqof77Bs1uyWVe1QmCt/RVEeyh9vJ3EaHWlicLtxdeuruwTR9IckJz9QCdxMnG8xoQQ+U//e4pKcUrNhZGYkyIZTjuYyBrn9Z2MQX9Uo2BzzUXaFscsYekRoaWeSx+qf8lYCAiWtDjw5TLYcV0cm3jT7RyPxwDS42UtvZfzr1jPkiZZVNl+2H+PKKMC3umiRPLkotTYVCY1w5UY5X2ZF1Hth2qWCiACLYEsvrph+MBMwaRQbXjYeIHsqQ0Zd3pChqcyRws9/I/GHM7FCaRtoYtsZdrLyp6iBe+kJn3MMX0VOauADRyefsuE7G5/e2C7X5NMFBBU8MA5Rb+ymS/qVXAUZCk3LaV/NXiYkNbwK1W47n+zzkWrIQEOPGevFyTr+F94miSo4ncR/aRPv4ZllJfEN5ig8qzxjtngM3W0VqEYGS4XhBUU4vhgudPA4WMsde57pAfC8dvEaI3LyIIMko8X3Tks0aDcBgdEMGAMpAPp+WC9OYbUcWEwRNrIVw3PHOaJhWaMAQWZAGWFED88DCr6Z7f1c2YG4G7OSVXRGXlUkcOseFkCICUZz85J8SI8zdxv/hFzQI4MGLh9BNe+/h2pB7Cb+M3WZrCKOBGBHXtSbKoPR0bYfsA+QrIsFLTDNC+l0wfkBNyQQyErVQ5YTiVso4XjuO/p4j2c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?galYUIAR9um36F1kRjUeUS9m8BALNctgWn6nha1YlhhA19cWCN3/pgb+KE?=
 =?iso-8859-1?Q?T1aL9TxqF8h/Fg7vAbCMAgEyDVOGrxb1cME0lQz8zU9LLhuTqyHlaTDe3c?=
 =?iso-8859-1?Q?7w5Qo3m+kUptOJBhjVi51uW1T480+w4mJX6xelr9JBtq4OUrivx9ydQ6rc?=
 =?iso-8859-1?Q?XFGLERNAZI0/p/hlhixNyErQfkQqDPr9nARSB9R61cdnor1cNeqfAGAw8W?=
 =?iso-8859-1?Q?UDvqPjcWW9KKnqpRFdLB2UdRavOhKDzXw7Elh2suvzrdL8dpJDkUvv/FCz?=
 =?iso-8859-1?Q?KEDQZpCTIVvUccMWE0/fQ+yv69nHMWeTBciSmjBEF16emCreRTTCLYyfkz?=
 =?iso-8859-1?Q?zcGc4/xgykk30lQKGR7EPcTdzogksj+shQQZI1UngCtWxt/8vxlY98U65l?=
 =?iso-8859-1?Q?na6GMjilkfGp0n3btnwFwFA5Fu0tL2usrj1uDWTT10fqlAWxOV+TlbULP6?=
 =?iso-8859-1?Q?XhWFlr5/4Ap5khqz3WqO+YYDu8oRuxugG7ydWsnXVJO9NF6asUP2nyhOQi?=
 =?iso-8859-1?Q?I1wtie7FiKnUy49KOlEleiXr7fRBejVsHuwDR6utlHl9JN8qEPHyDtKKsg?=
 =?iso-8859-1?Q?kyzBe9wTrge5dhej9UTtkBxAqQtzEasynG0FQu0NPVtEFL2H9FSjdvQ6wc?=
 =?iso-8859-1?Q?ILCUz7mhAbIM0ScgCEJR+K7Wy6WcuQp9rGyesVwTfN5nW7ftNf/xFQKgZw?=
 =?iso-8859-1?Q?urrmRnqTfLV3qF8ekstod09VCU78e7y9idkYAmI0l94P32ldKPlQNdG6UR?=
 =?iso-8859-1?Q?vHEjh86H6Vif6lBYL8Nr4GbOicGrFZpTSlkVe79QeVUvQlIidvpEDfxrKE?=
 =?iso-8859-1?Q?sRNqqBKvFxn+LkH+0t3L0kWFyUygxMOtFMBRfSeJlf3vkgfAICe2el9J/h?=
 =?iso-8859-1?Q?SPldgaqrhhiTjiON31NoqRrVTv85onbfcd3Mwujq7OCKQdKUMvP2V0/U/P?=
 =?iso-8859-1?Q?WlttpZctaENTmY1846uo/zxgBKOSLLNwSLrcz0BWPX3HpqMLsLOPrZCuQO?=
 =?iso-8859-1?Q?tT7g/T5VvPEPCJn2vzU8KVEbIuSjqcoTE5wHoRRFuD5nBwCj69Cr/hIjO9?=
 =?iso-8859-1?Q?uQQarXqVYmGaNJIBJXtG5WRh+Y8SMWbl7g19SKT7EgocNI/8NutNpHkWKY?=
 =?iso-8859-1?Q?8djB7qkLoRCJ7NkpxgZKZc7usDS0tsp+mRorpGU19K3gRoN5S39QXjIket?=
 =?iso-8859-1?Q?2nzMHnmsQod69IeoR0JmKM2NND8HhuM3Otl2BTwQYdc908UoEUwqc8ookx?=
 =?iso-8859-1?Q?FoY+O4EXq6KbETfIQ1qXi5KfFBJjuGgrvClmkZH9GV/3BFr506bL4/jU/u?=
 =?iso-8859-1?Q?0/4SjyK+OJhjCHPDB981++lpE8YX19akgrBtcu0fa8tjI8/HkqpLlKuH0d?=
 =?iso-8859-1?Q?IvJi/w3ueveKNDENf3u2QpXtRaCanFXpqh/3SNHH0tvijjPfp0OszqO5CF?=
 =?iso-8859-1?Q?EqBqcZpNSW42N3re8smNrkvO+yXdLr7fK7PMw9WlGGPcY64eaULFHafYTL?=
 =?iso-8859-1?Q?8fy21mDkx/TIhh/tHoBTeZ9VZaw3yEn+103EWn1RQ4CNQVTBqJ5mk5SaqU?=
 =?iso-8859-1?Q?ZZ+72BkxzAg4lPFq5b/YgV9UKHXIHwTjeqTzPhel2dAW7soqVoqI1bPgSr?=
 =?iso-8859-1?Q?sk9ORonc2siMABy1Ra9bcm184WYOogAdZYs9DDeM65Y16Di5jjjjQJ4VFx?=
 =?iso-8859-1?Q?ZufrXd/ecP7lcKwcd+nXy0FcwyyMRVPASgUfth3C7KVTntcuhO07iqBXdV?=
 =?iso-8859-1?Q?l/SXo8ynaWMPedpDQAOGI3Pd7fzS88bZXk+vpV4ducW4u3N6rJ6aKPoRCB?=
 =?iso-8859-1?Q?qIblLgRkJnP16s/bqXaew54dqyl68LE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3fe584-13ec-4162-5a2c-08da53c751d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:11.9407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lror46rX08ForfhFuh9PrIyouhB0xPXwWm0yS+hDyRXGkZ1ummZFYx52YPcKdFF3vyu5Hfjl1pIvB9psc0NeCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: rCmY43jOwMhm0ZsZU4sixT5irxL4_oJB
X-Proofpoint-ORIG-GUID: rCmY43jOwMhm0ZsZU4sixT5irxL4_oJB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Link: https://lkml.kernel.org/r/20220504011345.662299-44-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e0fba9004246..8644ff278f02 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -716,7 +716,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -866,9 +866,10 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	if (find_vma_intersection(vma->vm_mm, vma->vm_end, end))
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.35.1
