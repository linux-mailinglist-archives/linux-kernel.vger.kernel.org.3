Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF27A519347
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbiEDBTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245011AbiEDBRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AA731527
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243NIL3N004092;
        Wed, 4 May 2022 01:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0nFIXDnQBt1NV0JRBPoWWdNPKRiYZYX33deYqogRPIo=;
 b=deRgtLKLtZ1yXd/EA2fS1bwcQjLlsiW33L0kWA1BsOb2VwBgPyMQxTG29FHA9/oEB6P+
 +rn22FCX1Ym6gCyvyZJdT1pYTsvceJqjFQdG/QVPqUuxiWLL8N35RjkIDpN93PyrN41c
 DkvsS1kDee1piujppWXhBLbdQ8dFAotQ4mSnv52erc3qlzquwcNQnInlF+BwNTYTieBx
 yd1NdBY5PnZSPgS7sE0D3NcdX0AiYdQ7Uz5XB7w4+wn+UJwSFgVpLoiHC13cTKObKvp+
 EbJohL1xm7mjYb25v9jdSpk6+NZxj4aMyxXwKdERpugjGFvZW96SeS462BZMyOzfMLAC Pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apy04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AxHs004437;
        Wed, 4 May 2022 01:13:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2w67b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5EnaE7GpJ0aaLW5xTEQ5PQ+xFHcQsFzl2bRy/AgK1hXzI1AA7Chi5UD0ALxMU719jAXgRX+IPXIDLbRQt0bDReTWioKwot3ygCbxbuqEoDpWsoowCf0/LnmWYyRwmABRYYZkHBnTJHZB7lma96QcIqHxsB9oy2o2ODGrMhx9u/xlZiA9twY6jn3w0FtqC4it6qjWo7hk9xhBSCQDjAlHGNnEsM0g/4Q1IFV+96xGuPOqWcvnczD6jhWqeVL3EW7fruV9lGzI8b3hB64e6n7bAFxN7emlw7MdW45X7ipj0qphBHrTE4oPBbgnRyo/psPOP9+/30ryMTPMlz06zX70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nFIXDnQBt1NV0JRBPoWWdNPKRiYZYX33deYqogRPIo=;
 b=furxcgJdlo3vZL52LrGL7IqK9YQ+pToBIdSYXniL5f87YJKGQIMphGR/sWXx7hhIPcUbHpqhxGJ0WObKZU28mFM5gphEyGFf0Pqj9OXTKwJ+vMlGvW6aWdwJGNhcb7kUf3F975dNqvv+/VcY8vpMcXUQmF7J2USKAky9aVDvPj9t2aBKOsE4psI7HA2xgunW95dwLp9/AiNKMQ4odxBH4UDCfM8OAQQtpDk7nIObiEUDDTGFecBk+vfDZYjqrpGiKVtrFln93MgJhkwHGvThJzK/TWgMfY18XlM6St5RpxkisVfxdQTL0XEXSLucaBgcBL7/xBdKpF7IhaeaSH9EGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nFIXDnQBt1NV0JRBPoWWdNPKRiYZYX33deYqogRPIo=;
 b=u9jEPKbcN74HKAt+1/AcGeOH8uOT+Dk7gktW91tqLdoeI0lKyLvCblrFty7a+Q9xvvHxHaX/TKz65h+eRDXXN1+bSD8wFcb7v0VVHTSB8cZDHsr4IhjQi+rP2ldiocg6xBmeNz2tJ9cp28FviHYe2Jaf8i6KtKYKQucSuShiPqQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 32/69] parisc: remove mmap linked list from cache handling
Thread-Topic: [PATCH v9 32/69] parisc: remove mmap linked list from cache
 handling
Thread-Index: AQHYX1Q5hM8B6ViD/0OON0UzDeXmEA==
Date:   Wed, 4 May 2022 01:13:55 +0000
Message-ID: <20220504011345.662299-17-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42617848-440f-40b0-a87d-08da2d6b5c33
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB5830B4047C3C89156355C3D7FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /52bx6TbvjX34WUOQ9EM2DpbhC0nsNx6w2g7JFDSPd8hE3QYlkGY991foR3+tTRHKmbtu/7uyAfyXyTiKSm9CRKQ6Cjkq4HP5benRNs/PfeVLZCp/UL864QohtK9ZPuJdFd8qk+eMfh4HuhOXQ2L5bPKMMtonz0dwbs8qJFt8n4TOxO68fymzH+i6bxhS5tGJ2NIkGbcLGtCLaPzOu4ikyEqsM/1HLF8jZ29qlOnbCkBzgdu6v+C/2b3TFa3C+CyHt70seprNwBM5vPWKcQV9Z/7fo6XbDshehAaNIKKo2JCCrNVvEePYogXh8LZ4KOs8fW2UlT93Bk+K8OWpGIJCf7oNg2lJHwbdiy652SGj1asNvaTWRtYWcDVIIgbMv1DjAXd2oU+ZXNaDpb3qrlXNg8urlUGLA5BqolxpSqyvJMwSCBQj4XxvG7q3ZddJ4+FHY2sYuQ4YDR3oTzmjZJ+DpPxZlg0yA7Jt/nWV2kd6pz0hjjUo2JCzC7x4RxiJ1NclSpUNSaVtk8gvPtKOvfEGfM2xuZ8vsaUY817AjaAK0CWuIc6bfUvvlqOZrHXk/24uEd8t61JAj4Okm3cnT5uu+og4ypOPbmlJTjQW2MQOT/5vxz7f1iBpcepAOSfR9a+3l5ROY4unD/HdNjsBzt2fOdo+y3KmuEIfqTZZqiRVNQvl1VefpiIUl2rkoPRpYJ3EbydFk0hzm7TP71tZ02XjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EoQfNsZqYKZm8gBF3v70zuLbSqzXykz4a67Q5aVJkRqTQqwzD/noaLZotX?=
 =?iso-8859-1?Q?WwOQ7/smIsLtWBKjVIuHHC7i/uMTJwQi6KWRe0OwUWJ8z+ihdiTXsgL21l?=
 =?iso-8859-1?Q?UGVA+tT2XM31wWBRDZsU/IJl4cJe4YxqOTZAdZhUmFyn9KrvrfgiiKKmPW?=
 =?iso-8859-1?Q?ZyIgTS3QFI/kvkthQLn6RwavXmh6fmTcgSkUZvU8gKJaKtSn536OUj6tJ2?=
 =?iso-8859-1?Q?DE6Ezbi69oEhCbdFJX2KQTbHQIjpm5CTf39V+BbJBRFI+xJI3I/AYmKGqZ?=
 =?iso-8859-1?Q?vPk0B7EPj/aHYfPj4g21q7LOfkWcWbHdSG5HWL0RhfNFHH5sKPHOItVuYK?=
 =?iso-8859-1?Q?/5Z0EtksEHpsJOt7AKgF1dOijBAJ8vuKfpJPVeIBVwTJvKaz2pf+ORlVMF?=
 =?iso-8859-1?Q?XgUuymdJbH6dF5E7xvT08Bo5vR1sBH7RuY3C9HIdYjdF14hVG8F2W45kPH?=
 =?iso-8859-1?Q?4zBTKSMFXMdnI+3HGGGi2cV49Q+E8budnluHaui3FzaFeVHF7pKK6DUaqZ?=
 =?iso-8859-1?Q?oGcelawr6x8znSQqp/5RS1/OZ9ofbJdrD1h/IoCWGWF4yGx/z3ogKfD6fO?=
 =?iso-8859-1?Q?0dZoaJyE4cukvBiGYN5yhE1Pc5vXBTgFT6DBufa34SpLT2gQgdxMAqIyZl?=
 =?iso-8859-1?Q?Gsmv47sMogXADt+KupUnkltVIX5Av5uw/xUvgiT1/sPQpBuFCAFDjwXu4S?=
 =?iso-8859-1?Q?bhwSUv8G5NQfF9FgxNQIeQp+M+k5QXUCSduht6ZoeM/4bKQKyvGVw57Vr8?=
 =?iso-8859-1?Q?1HMMD8ew35rWRUecpQDmiNmYQMQwBaNT57nlImk+2qZA4ZSd52dlnyk+rE?=
 =?iso-8859-1?Q?5OFF+0letbYA721Q+j/rmnyVB/85mhhLdqEiQQExfr7M1qeewu2Zx1W7HT?=
 =?iso-8859-1?Q?vfm5eNtHYyvxZUUIwvanPQ40RY67+BifrM+02DYIYx5uuZPPTkfoZcIpcU?=
 =?iso-8859-1?Q?Xc3a95DawOG/fTDJ4+mrC3mBXI5jeH/pwXnzNQMUvhRmN/HGe4rrzO+S98?=
 =?iso-8859-1?Q?6W2/5jkZfZsM6ugW0Kews8UslmLIJtj8O01ywYe2p5/Fb/2l+IWl65Rj4N?=
 =?iso-8859-1?Q?32ik/r8gTbZBOvXS7xE9fLTVGLBJh1lBjKUoHsa4s8erTanb2Q1H+gEupc?=
 =?iso-8859-1?Q?jEjnGGn0LvDVuCb37b1PPaZOZmqLg9mvtlXgxN9rMV42JWYykfSDC48VkW?=
 =?iso-8859-1?Q?34WDDODKTIxQcYXAASThWaRlLGi22eBrml/2jla2PQ0rwcnwGulpx3HImR?=
 =?iso-8859-1?Q?kFE9oX6JJLm6DBeZYXD1yLJpyA/Wja8FueQLB6Uds6eGM2M0TcdxQZOucJ?=
 =?iso-8859-1?Q?SFCVZjP8Dzs4AjOVdqxhPDxr7WaVGCzuvnhQe2YqMXt2i0CxEVV+GlSea9?=
 =?iso-8859-1?Q?rdox9E9D6b0AHPecaoRfMDN5CZXzch1J7GJB+EJ8gZhYeRTjcZIaQAhPFk?=
 =?iso-8859-1?Q?6PAfjM8J0qXuV11Lm6/tvVHD6xr1/efGC0nnhR37Tp6Kr8zqv8Sw8BFwmz?=
 =?iso-8859-1?Q?q4ELXWR5+/M92yuGhnOU3SDnC7kANNb075sFqpfwqBMCUXYHBENHy0ExbT?=
 =?iso-8859-1?Q?LCd7XzBZaxCk6ECrUziQ36VPY0gckhM58JgHrT9v5miX01hff0M9Dq2XV6?=
 =?iso-8859-1?Q?/6+iZ7LNw6UM62AVdPYZKaefKRlrQDaHCs8ZD6a7i344YMwI+OcvDtI7nx?=
 =?iso-8859-1?Q?MekoW8EGub7hteRj9FN9B5T7TXyQixCe6zBLW58mBwlrU6G+buIg7PgsoA?=
 =?iso-8859-1?Q?DHPrtULuUIT9scde1Pc5eScIujjLbiLqgPsI2ftEiZWTJZ3AOgkHGGWF2c?=
 =?iso-8859-1?Q?85pgun1jwIvDO4lZALs0+BVoZ/3vmTg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42617848-440f-40b0-a87d-08da2d6b5c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:55.3143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nAXCp8nl/npaluOMRLToR9BqCv7OWTiHVHABa/c8jVFC/Hyy8R+VMzaTwrM9lAPtK9jVWXmeFDoJv5vIJtzwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040006
X-Proofpoint-GUID: xkuWwLAQo6P737I1SjiYBRizn7aBr-As
X-Proofpoint-ORIG-GUID: xkuWwLAQo6P737I1SjiYBRizn7aBr-As
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/parisc/kernel/cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 23348199f3f8..ab7c789541bf 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -536,9 +536,11 @@ static inline unsigned long mm_total_size(struct mm_st=
ruct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		usize +=3D vma->vm_end - vma->vm_start;
+
 	return usize;
 }
=20
@@ -578,6 +580,7 @@ static void flush_cache_pages(struct vm_area_struct *vm=
a, struct mm_struct *mm,
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -589,7 +592,7 @@ void flush_cache_mm(struct mm_struct *mm)
 		return;
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, mm, vma->vm_start, vma->vm_end);
 }
=20
--=20
2.35.1
