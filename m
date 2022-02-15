Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA054B6F11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiBOOpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:45:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbiBOOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:44:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB7310660A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:39 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FE032C005194;
        Tue, 15 Feb 2022 14:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pVCphHqZV2NQa7Are9gAYptAActOH5r+wQ8QgeIXiyE=;
 b=gRvRY28axt9GFIs4+XLO5iIgxy6I1DU/vkMAMW26hy4jxDXnggzHSgeX71s+xpaTvGwl
 wfEp3hQEgO/a/JVc1C6XHNDTkrvlSftcOdS1NVYsfVQDGh7xnzeELrvppwKsaolNYgko
 tX6xT+YA6is95xvYnWsLVmLB/IA8zvBkw02RteXqFn49OanzhzAzWfneo/lDukQocAI2
 k5PSQcX36MW3ZoDHEy6JWN1ZEzRHRuAEVAl+MM2nlH71S5EdQIMsk8E9UCQpl8zSVeZN
 CMbuNPnROtqGnvLH/Ykb0C5FoRh6iOrq2yxzg48DC36/PvKOj+8g0poPAk0YrXAwRrHF BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8570shs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeUFr145877;
        Tue, 15 Feb 2022 14:43:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3e62xeqejm-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvfVD0Bs/4HKsNKCDOyr8jGYToRZChvuH2gN1PSRB05N46FtRce1NcyA6/B+caCIi7TdriHzuQLfcYnkSOdVQRzeLJrGkcKHt6Pkvz3VbxwSLkGYTua7WvNYXBLPLIQPCEcGWVm8Jj0/0oNg/z48yjyn2jYlCUqSpMDBL+zwi+FXGxaWR/7VUBKhUKI+P4rxttXvZx38BV4PeJSfT7A5BUDw51k1Dh+y4zS/UDxUgwuaQj6HqtVQek04gTbtS8YesX9ZsRufnwLV2ZkOXrvQDog1N2IHDBIlbLCbl3dEPReVudDwLbpb1tvwFNk1s9Tceed87w7KphxwLxtsSnf2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVCphHqZV2NQa7Are9gAYptAActOH5r+wQ8QgeIXiyE=;
 b=itGmj5QUf85AhFVJoSG5WmfsQwZ6H4fWlv+q7Gjo6ZXCr4lmHMRceyaEHFGp04lVRMOVEFmYzZIq97iD+iwFf6v1eKd3mYSva5vByezvC8OXW7BAYlgZFq5YXtkiO8DsSqvAvs9fF3sY9PACliJzsiuLK3NC6tqZPF9vn4F+Yu4sPjsS9GCKceX1XrehO+QAUK6x47qWvNnSQTk6PD7NJMOPFI7dHlstbD6yRs8e+cPCvvQuBsg9oVD3/RzSlLRStFHnCciXqCjCrW39hbafhc6UUlh9mooYLatjP9yvWHpJQFmyw/KQKozWG4k7S2axgXkm8MDvVsoEV2w+FiHIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVCphHqZV2NQa7Are9gAYptAActOH5r+wQ8QgeIXiyE=;
 b=jkItXpvs6TH4khxUvP2Z9Gk130C4bT6Wipb/tv/2vEkwQxsRTjAJ41PqiDuS/wKTbwQwzjhl4m9mwG/VBV5qtrwvoqKPSb9Jtx5nr6HfIdWSgDn0ETFu4UFbA/B7AUHXZocZGfCT/xmQGBXR0KqVi/Yjf/2lRnY5jmdtR30QqA0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 25/71] mm: Use maple tree operations for
 find_vma_intersection()
Thread-Topic: [PATCH v6 25/71] mm: Use maple tree operations for
 find_vma_intersection()
Thread-Index: AQHYInpbxPcjlWTBT0ieLJ/slMT64g==
Date:   Tue, 15 Feb 2022 14:43:11 +0000
Message-ID: <20220215144241.3812052-25-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50ac3b4e-7b5e-4abf-246e-08d9f0918128
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689F0EBB9DA17BC73745EBBFD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHE/yJSZx4VtzEEy55hvjvhqeRdpNv2STurnMWlPucU8gHS1O8hmW8IoJ+ajGqPmuI//8FmFEUMgNkblae4RcTWDZ/EOfkLvDNXWubRvswxLADc9BYZeOBaEyfycWJ788PWYC+EgoYNEqVGfJBIM5dUq7fQ8Bu3rMsUwe7Tw/Iv423pWr2jKCPnbYL+4a15uHm89KpjHa9s1j4+K89oR/4HVZeFmuYkSrTxudGzY2U86qF0uZQSvhF5bcApiGy68cpxbvElmFRTL4TPPTU0VUVlk46/SeNSrgX71yCzTjTSXKbwx91XbvFSB8VxueqSMHkqEs9rLqncq/yyiqeoQM+t0JUZ+inZAPhKX94Bt3sOWGRclzD8hRuABkCQMszBPpHXfg5FOuiPKoYFZDrhjWJiiq2zKU4MrXUpomCoKSWC/c3gJJnb3FMlmnnlJTdcipI228SMo32X+P9DfckNO1ZkmkQK/9daEe5YVRj+BeV42khdlBe7fXKgh1Ps1Iogy6xu1fSvoa+HG/hZbEtaQSUL/xhVqBL/N0nUI1Iv3Gz66sGRToTQQZuhyUkrfvsDmqvOrPA8mp+yRiQdZRiZoQz7A6lq4sA74YBcFobH6Q5aWa6kAXpbsLK7Y/DzJScGywn97xuw29zMaXhkYZNb3QwMhnMuTAr/C2bOXUzsrbREatbDUCm3om9ikCeT7vpEIpshXeg6bbr0ihgvAm1fhZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6TaZtoCWfXpN1zOOf8KdbIMqRVznvoX1xilclFpy3dc6fvmiDzD/ye04Pg?=
 =?iso-8859-1?Q?9mvA8nc784UETQhH7j6H2r8xjskkqcDodZACRzWyfkYr7hzj/nAPI/1B/a?=
 =?iso-8859-1?Q?hDovZVnKd+UNcmYlOhH99ro7C0GL+sQoCc1Bh4sRRlysSoJD/nlg4e+KW7?=
 =?iso-8859-1?Q?3CakzqJsCmF7sib1zF7xWN6M2D0eRWNqB9zbgw6OgIo+yyPLFvRjRUvMTa?=
 =?iso-8859-1?Q?y3rwO0Xkh0UkOj/cf0zGHVjstDbPTdW1RVOZPeY4SM3THmyS6ADg9bMtTO?=
 =?iso-8859-1?Q?O2XFYXsZFP3KEY8vM2uokpS13nArTcs34aqIT8eCGmFyNNaSO8XNZGad2F?=
 =?iso-8859-1?Q?nsNCSLcLd8WwMe8PWKWhQW/tjHP8uc0J8IlIF+4fs5s++l+EXo6PY37Cv9?=
 =?iso-8859-1?Q?3WWdPLOmXufKsM73D6IZzcjFNYxkHx41DMK5YeQCsG+rIfTWnADmizPf1N?=
 =?iso-8859-1?Q?v+NvqUQD9JE0g5tKBs5tv6Zh/YKOsvOuvSSFhVGnwGG/fjd1i09zvCmn7g?=
 =?iso-8859-1?Q?hF5UoE6ncLFwX2f5uBtrK68wFWrTPTubKvkxT5RoUv9xeSc2UEVFn/KJdh?=
 =?iso-8859-1?Q?UT9SN0gMDeqoQ/EEOq3dAe6s7RVhHxhBQ9D0aGAjJlqFfaviw0aUUuPfaX?=
 =?iso-8859-1?Q?oak0yIuZb52MTTtkH7LMWUZUpHef9OpZbuAhRZ2GSkfPWYyyVUvje2cwzM?=
 =?iso-8859-1?Q?HRLDhmE2JfN0Eq74N+ej8l4PXJrj9a8fxUURQR6ikPmdl1kqBc81biQ3F+?=
 =?iso-8859-1?Q?Bjq+/k5rP/5WEHgEw7TRuxjDv2rv6mH98CENVzIetHUfm32QKQ/0F6zd3z?=
 =?iso-8859-1?Q?r40MfygVWu808uYZZv/WmUeSvr3tyBcJsfPbdb/nPjZXztBS6FAFgLynGF?=
 =?iso-8859-1?Q?DVGNRTb7lFK3plXUYnFC5FUHkPPFnFE/Ew64itkunmjoa30cRKyJCVXodj?=
 =?iso-8859-1?Q?mh9u4iW6wP/lJ1we5vW11KdZ7vmkP2ixl6+PYg5raJlaJUWWW6zpoHkNYI?=
 =?iso-8859-1?Q?bv2qosif48vNb1zSZJjFVFAyf0TfT3IdcPXPyP+QT26F5xL2r1NgM67MGK?=
 =?iso-8859-1?Q?CPuIcDSjx7eR0LvLjVDBpwZYGSQ7chQTtSe6R3ldeSIvQhMaqe8fGAD7c5?=
 =?iso-8859-1?Q?tnGtSxT5VaPsYkjrR1+uXnh/tunPNDEcS8m76KgoMZMkWSQ/4WRLhzdISo?=
 =?iso-8859-1?Q?Vyddq+2SxnGm+aRBe/UDwKuVzjau0LTbaPw5wBWFeBCnbFRJ6kTKSVpzas?=
 =?iso-8859-1?Q?CDCLM4na4WqKnaKLHV1k56x6ay18sPtoYMJKtz5nVuDP4FBZ8WYBJnHb4b?=
 =?iso-8859-1?Q?Nk0vi97EiMgOhA0hwgwlztzo7+BtjbnzpqOCatBxSfb1hzwIyZ8LMNmG2R?=
 =?iso-8859-1?Q?5KkM7ICiGqN+NoOGOB44dEo2LtqzueN0wydpcQ1ypqdiWuUwcTghUy4gPX?=
 =?iso-8859-1?Q?d+Qx4jD3/tRwpB9MUGgvnqS3HKocd8ubQwjlBgtnraPhs4GKOGDGxOjQcP?=
 =?iso-8859-1?Q?UMgwWRas1UM0QHOJ3MhqHPAmHJ34CXNNd3KR+mSoZIrc/IJYa4sc7ZkDO/?=
 =?iso-8859-1?Q?SgWiJ7Le6sJ8MQxz7HvC1O17dsw41X1vTxbN8tHAkJHSofxAzQhBpfVnYY?=
 =?iso-8859-1?Q?M1sTZLFewzOhQI/EhqBPCYQ4Yh26dyBz7ufNvpWwXNo3izSO8PxK+1fX13?=
 =?iso-8859-1?Q?9yj+E0vsbHk9/UoxdUg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ac3b4e-7b5e-4abf-246e-08d9f0918128
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:11.6518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+w/2QIYt1ST69cgRf+snTeSWc62TUqPqOAteeNFbM9oo2Wy8pe3BT/BWC9JGo1PCVartWa0R/RsC61ilrtTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: xa75wMmsGNKwHD3DwG3JbPLCZLtIKI3A
X-Proofpoint-GUID: xa75wMmsGNKwHD3DwG3JbPLCZLtIKI3A
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

Move find_vma_intersection() to mmap.c and change implementation to
maple tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.

Exported find_vma_intersection() for kvm module.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 25 ++++++-------------------
 mm/mmap.c          | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 110b1dcfb036..72654108380e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2784,26 +2784,13 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/**
- * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
- * @mm: The process address space.
- * @start_addr: The inclusive start user address.
- * @end_addr: The exclusive end user address.
- *
- * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
- * start_addr < end_addr.
+/*
+ * Look up the first VMA which intersects the interval [start_addr, end_ad=
dr)
+ * NULL if none.  Assume start_addr < end_addr.
  */
-static inline
-struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-					     unsigned long start_addr,
-					     unsigned long end_addr)
-{
-	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+extern struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+						    unsigned long start_addr,
+						    unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index c080ea65215d..80ff8be0631b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2030,6 +2030,35 @@ get_unmapped_area(struct file *file, unsigned long a=
ddr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
+/**
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
+ *
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
+ */
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	struct vm_area_struct *vma;
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	/* Check the cache first. */
+	vma =3D vmacache_find(mm, start_addr);
+	if (likely(vma))
+		return vma;
+
+	vma =3D mt_find(&mm->mm_mt, &index, end_addr - 1);
+	if (vma)
+		vmacache_update(start_addr, vma);
+	return vma;
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /**
  * find_vma() - Find the VMA for a given address, or the next vma.
  * @mm: The mm_struct to check
@@ -2038,7 +2067,7 @@ EXPORT_SYMBOL(get_unmapped_area);
  * Returns: The VMA associated with addr, or the next vma.
  * May return %NULL in the case of no vma at addr or above.
  */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
 {
 	struct vm_area_struct *vma;
 	unsigned long index =3D addr;
--=20
2.34.1
