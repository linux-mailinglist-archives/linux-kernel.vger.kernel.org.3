Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12A4B6F23
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbiBOOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:44:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbiBOOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DDB105290
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDunif005201;
        Tue, 15 Feb 2022 14:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UdPCPM/TvAvt75OkVtNK7v/rDuEDGFNXN9nw2ShtPBA=;
 b=zbdcMuTZ3Uv2WmSKhEek2dUAgvFjjCvIxYY/M7UURK5j+6hrkw3TMS3oqQOnk655XV03
 BF3BAKFa5CZPklPTD8ahFHTebB9Zfgrx+3/GJ8/1B49RK5WsVmEwrmNRmKksJGNtYVn6
 Xu4tpScIaAoRut7PC/LLN6HrPJRHc4WG6x+Hn/vwiCOCPNIDZr9Xt4wRCDGUscbEf/hx
 CZ9jqU6QyvtLadCBZWtf+oqg8mgeMLlz+ZbOwzx5pyFPKrsF90WCb//aoDCC6vHH0eTg
 J1NCzAkJe+K9g0GKp8plToRoyJLIbnV/uAU8sAnwWaicDr2GF56aRL5M40I/u9fwpSR0 XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8570shry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeUFo145877;
        Tue, 15 Feb 2022 14:43:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3e62xeqejm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHKNHOLMLM3cbcD32F2Ke2aDnmThTuKQk1bkghbxQE+newfq29y2vLnNTGnioGhBsFYdONvNw/qTUPFrlze3TQHZEPmrTXAYykx1t7Jpzlc7I3ekhoQZYSawhdKwV7jCJtkZu4vjcQWfxYTShvSOlOexfYLr17NAY2eQg0yxdjNwMq4zLu8yZuPQOid0RzsEzwqmMimIRv5n31Vw06pQ2K7J1z384ZyPon2BmxQbzOUW2eT3Cqe3J5TRKWHQUOK6f3lI/XLC+dVUae/jrMcmWoK10BHbebBGS+zUAC72F+BchD0CTQ32XdpvMF+hRTwM6cr5jWiNlibO4VYfv+Yi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdPCPM/TvAvt75OkVtNK7v/rDuEDGFNXN9nw2ShtPBA=;
 b=FB7atJGNc2h1rBCFPfxzj3kt+lqYD+4mOpekjxmlfubzrSAjSachJL7qrZvqZuqzXOOIwUD3sRVn1Gc/BH8iwJsnFvw9GJp5OIOOp5IF76te9x88H+aHFKqYHe3KCB+quxBcSAvIKDKzpO3MQTFqPhEX6wwZ5DRfXhjoecU6qN5AykxFaMouf5cKVZWUj6il+htQ8L3m0ZSqjMt4PaxO1VmWMdwFDoiFBvxt0txfW2b6VpgqekD2XxVXPytXjCKKISah4KsEGCToHkqb1T7B6oj7MrJyJnD2cR3jy8qklDBXsA1AJZwUOTi5n9fA/Tfk3gi43nQ5hJvFiqnqn7XmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdPCPM/TvAvt75OkVtNK7v/rDuEDGFNXN9nw2ShtPBA=;
 b=yUSXxe+9AY19oy5ng6vVcQGx48NYVEmbaS7QCxCSNUk9M5y2HQ5x0qVdQQ+uow6fDan4vZDXmdfmCyrF3L8Im7ZW3eYAcIHHdx1Qbw3t6ObSHE5n/sxhvDkUv5AmB1D3YO4yPh8RD4Erlsk5nS6Mbkn0sQoKW2TdqyMvTlLIioY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 23/71] mm/khugepaged: Optimize collapse_pte_mapped_thp() by
 using vma_lookup()
Thread-Topic: [PATCH v6 23/71] mm/khugepaged: Optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYInpaHsAYvsWYxkyjvMhPkhVLjA==
Date:   Tue, 15 Feb 2022 14:43:10 +0000
Message-ID: <20220215144241.3812052-23-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c625f885-9624-4a58-551d-08d9f0918094
x-ms-traffictypediagnostic: CO1PR10MB4689:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4689719E3B7818B29011B138FD349@CO1PR10MB4689.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nmi47OuyOqhQ1btMyqfOYmd68469VcSAy54Z6y7wHIaw+YxBIYze73EdaIMKVeljPy0A3xw17n5Rn8qitlIf5vCoDcipeHxRQnK7qT+bXEx14cFsHxIVgTsGIRF6v7n5dLOaaTrFJaxwhOac30uy7MKZydDRhbU/coekbc4R/soLjUy85afb2ezEKLWLPQ9rt6tZ3wbx2L+DPvqYZ7/fMDyMuAfqESNvadaQVlFAK+EMmux1gFxF8NWTQY3oNqHyqrmpeeZ/RlbxWrUn3ZVG/GjfjbYu2OpMES38T08PUHHjBUSGVr+aEGPG92ZxUfsnZ8DVD7cSAaG7rFuePZWiv8MLR/nCBlts961XXhOLDpI2dXADrCNPZ5XqDKoHwUMvtQPURgrp0/EA1jvPJDij8wp0HNTgJlK9gnmSfuXLQDS8D5Bdh4V4BXxioA2S1WGu9ZCJM76vNJVsnRmFGd/u3Ms7R/YQqkEMgUjlUTisXBQcxTszvhsa92S5u1s+wdrUvbxL4ETjgd2hj42zWiV0LnWcBjV99JLn/k05IjmZbeuyG7534EDTuxxJRSSnRnXnghXE32TAaGEHUP8B+XKQa91F3NH/62gF5dg/eYWMFTtO5x6NutwMfh8AFwmwAkpK/B37T9zW8HZtQu9G+8Aa0dFGmbZNO2zQ3ugMOoxfWn3AVH7vgQAraYJKsckv6yJKQ8dAme4JgSRnZkt4AjNb+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(91956017)(8676002)(6486002)(8936002)(86362001)(316002)(110136005)(38100700002)(122000001)(38070700005)(2616005)(6666004)(6512007)(44832011)(36756003)(4744005)(1076003)(26005)(186003)(2906002)(5660300002)(83380400001)(6506007)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8Gna+mbx3zbBCbM6FDrP2LibYOPo0HoSg/XhqxEglMZb2O3Mi8gdB+ilyS?=
 =?iso-8859-1?Q?6RzcQu1XmZ2uTpt0E1qo9DCdIZZGV/7L3cZ2QINCAJNjyKyiklfjCOYZp3?=
 =?iso-8859-1?Q?yfesTVkxj/RAAE//3A6AZrEzngsfB8O/qnMvmVl4LcC6GnAMf+TfN5OblQ?=
 =?iso-8859-1?Q?WYWpb1I9tXOTvxbmVRxwZAun+GuTFs+hiRoUsEhgW/vwRo1lJNCPwX460Q?=
 =?iso-8859-1?Q?5T80B+Jou2l8n+HBSEjqsuCDwnD5CcTjyRpOJt0ziK6t78WYzjTH4COdTh?=
 =?iso-8859-1?Q?zYO5rTQbeR7hB+6Msbt/GXkT7y8FMHUNNQTKvNEGn1jxoKemLSOJz3N8cD?=
 =?iso-8859-1?Q?/CblTAStVlMV5bC+DHoaa89ar+SvXlzB3bBv3vgbXMxwSmTtspV3oKzoNX?=
 =?iso-8859-1?Q?tqCge6F0gvRGYm8XmN89g7Fvv//2m6PqoeOX7b2yfkJ8D6h2P8xmxyz1eY?=
 =?iso-8859-1?Q?y0cCJPknqgE4Js/N+2PuQX3268xp6z/UkHpu4Ox5yC8yA+Bsgk5CURl49U?=
 =?iso-8859-1?Q?GW+aBjMhIoA/SRU8pWS6WVmea7zK2k051EBndVtWNQz06eqdh37iAlB8rm?=
 =?iso-8859-1?Q?4UpANq81YMzGY1ueYDxAAp/Xn6rCpRWgRMN7c8Qw2bS6LtPCg3uLpgKyWI?=
 =?iso-8859-1?Q?hbgn0ks8DK2kFpfOP6VzBS0G4wK6V+3tqUIYZMwuJLAHLz0AuuuPkHpECY?=
 =?iso-8859-1?Q?PeHKC0Q4joSKTwskLdyqMsxtjauaPa/5okfeP29a4UfugsjE2UxOeOlrq6?=
 =?iso-8859-1?Q?YuzLmyl9umKa95dvv2QgijfM7DBX4UFapTlDGIYJFgPfa2YkNRYzHwXJs6?=
 =?iso-8859-1?Q?KyydpGxiSYSHVErLKBYHaSxgqGqvoOD2fc/4/KMJbur2atp1jO9kh4PT7u?=
 =?iso-8859-1?Q?I5iZAx6EJXBJEUZUdC6te2O0AnmeudiBtR2lRKSY4WcKIEqIij0xXt/Ik8?=
 =?iso-8859-1?Q?zb2t6BCp/cqGTZ3oKxK0H9xTi6lkI95bdbZ/5tfyec29HG2uLha5OAbrah?=
 =?iso-8859-1?Q?yM6b6f/xfGPX5czsfNcFVduDC0RuTH3txzNOtgjrcviNexpawyEosNxtcG?=
 =?iso-8859-1?Q?9aAR0cH25UgrwmgVK1WRW4RJCy9ohjt0619Pp6gjp2NltE60EVDsExlv91?=
 =?iso-8859-1?Q?WBJZ8+ihiLKtgiatmIzqBIpEIm8RlUsVgi+CiLu0ktvzWAZFL4VrBr8qsH?=
 =?iso-8859-1?Q?kCFg7/BnukYs9ldGBEGSNGCX48lMzo+m4UsJI6J4uK3ratL60lD6UtQXlF?=
 =?iso-8859-1?Q?yfmQvxmtKAnQ7B0Hf8CpsiPe/ItaPlxjmZyjOZxd3PuLjCKPYMGhxWPt/Z?=
 =?iso-8859-1?Q?BAnwTAhNubw4RZGdiE5ZLXwyLo4TLsTDUduQZZbjsT5pQHRLFvaY4m5+Gr?=
 =?iso-8859-1?Q?PTzejVw2exB1a8ZujMXW1MJLf0SBxzdS9T3EJjc2v1e8VFjobHzoSYaCt7?=
 =?iso-8859-1?Q?4Vi5Iva60J1S8p+ca8fgSXM5Fhk4tqOiN9DDLq35q6MV4m4rgco16+MJjH?=
 =?iso-8859-1?Q?VFAC/4mO1jO/LiRQGkfW5ZMDdxyw0sYmkBtXO9ggcSEeyWnxKBLEwx1KpU?=
 =?iso-8859-1?Q?tjJu+MExLjeOsInAdFQbGkIjjCUvm+AY197Yf2aSH/upOBBi77pvQr+jta?=
 =?iso-8859-1?Q?LapkjsU2xmb7imElv3MoSMnmArglZwPVb4yzaetNGFE+PUB2GTORSJJul0?=
 =?iso-8859-1?Q?mT6S9bG7xi8G2z6YFIM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c625f885-9624-4a58-551d-08d9f0918094
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:10.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXeN1ibAXs4L9/mLGgKt3eS8OyeSKdJTAmxWNjG/dQQUF5N5PcponyaF4+ilWhBcP+gYsnrSrGJSBAwUVnV2ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=898 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: CEz8x8w0VGe6IEugnt34_MH5kjnhHVar
X-Proofpoint-GUID: CEz8x8w0VGe6IEugnt34_MH5kjnhHVar
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

vma_lookup() will walk the vma tree once and not continue to look for
the next vma.  Since the exact vma is checked below, this is a more
optimal way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 131492fd1148..7507b786f1a0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1446,7 +1446,7 @@ static void collapse_and_free_pmd(struct mm_struct *m=
m, struct vm_area_struct *v
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
--=20
2.34.1
