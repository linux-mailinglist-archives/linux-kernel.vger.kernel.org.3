Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797F04B72DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbiBOOsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiBOOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1CB115954
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:08 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEi0eF006569;
        Tue, 15 Feb 2022 14:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+4nU7Ofk1jrXrP4pqOdfm0N2E62lly6HrFJ1/GN1vsQ=;
 b=0054uSXeOgvt7ixZyHpzj9nO6D0S1c84sT1M5JmaNXLeUKEWurPIV0FZ+P43LMc9x/Q/
 BpUR0co1UciCmLnDoHue/IImMGUki47wN5s3ezT/h6JOIsKB2uvOhy8dVTVq9fOGv8c2
 1FgG/utDophgCbvmvnjbBRELWsi5NKeLbef3sTO7w6QYSu9XDJzXjO7yrYkwaVXt2S/y
 eZ5YhFg+IvPvvWxvLagCKtD/+EUGCIdf4JWPYHQ7/aovAM0CIVculcx+FRt30kRmIyQ8
 9fQHr2C2RdAqoBFhiVXg2wLXynSxsNproZorgJJE53Wt51CXkz1YARArZZ3TrdoYHQte EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0hgd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4J145723;
        Tue, 15 Feb 2022 14:43:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNei5QIZn/AZuX7q7chlg+s6Zcffin9GeR07o44c93u9EBfl/dbPksG6ngY0motUwMp1CT+2TnvF1WuA8Udi4l18lIOlwm6q3RTFOV1xIP+XMzcBdUN9o1oITHIiloQ+dUujo9Gz4pYfIrLWndADVgGXmbJrjZG6cexqoQuA5+IxvtKwZqX1PeialUSjTcD56bBXfv/XXrTU8STHXTm5hgJXVtaUhJfSy3TGYt2C0iNoRSJFjSTtjecQycsgzXxyMFKTRu2HfJWEM69xaofsnWdxxEdFpIC4DmX4KJUNfRBw8zynS4SYURHyqs4MrTbHJFL2axXZbWVJTk+yY9Zbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4nU7Ofk1jrXrP4pqOdfm0N2E62lly6HrFJ1/GN1vsQ=;
 b=OrH5TPT0ryLH+WCWfn3WIa/1nJAuw3blupRAf/4/R6VO5OqrRkcpsHCrjTYtXDnGgpG0FJemkQLBeIj75xoVy+ObqJ0/jvXBjemJf3xITKMaIJll+y4D/dbdRpWznfdUcOUZaTZ8UjNMSwSZQtCj9VhcrXJLdZESUfN7BCB0ienpLpCbBnkGAAPSYYri0ewJcDATHhzWmy9LiZrlTcfFLZHbtYB8uDqBFod/Z3UoRLRw+sys2W5k/E9FBaQcbtvCMrFJs9PGnZX/hIFSyl9qva68AGWs+L3F4MvRat8bujetDbajqOpLKg17anT06yKWtv/9k/RJD/wxpYqjH5zBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4nU7Ofk1jrXrP4pqOdfm0N2E62lly6HrFJ1/GN1vsQ=;
 b=lHNfikdhPqzNKV6v8dMBjlT8J4DnGJwCdIYDUd6NkOJx8IPHB078piZjLP0Lg9dzibAVayVLIK6vFDV40hz7p1BF+HQuaEkIlt2LuYdgVeCE5Uou6wwisDum8WOccHvdwxQ8BrG//lhvhLSAwzRFg4nN4HAvRChVIGRoxUEHT8A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 39/71] optee: Remove vma linked list walk
Thread-Topic: [PATCH v6 39/71] optee: Remove vma linked list walk
Thread-Index: AQHYInpe5DjP0pd0X0y058OZnDV7Mg==
Date:   Tue, 15 Feb 2022 14:43:17 +0000
Message-ID: <20220215144241.3812052-39-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37543f4f-d7c8-417b-783a-08d9f09196a6
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB55788351E1112DA382AE2564FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kF03VONjTrIcPAR04DzKr5lWsGCdv4YTQgbWhSqgRwWNUAYM6cw0P3gZgKNn7ENeXrdVdo8k1aY+2PKuYd5OHmzi/RhIyIMIHrwWkINXuVSMlD0Wdwl9Of3njJW9/tdePHfCy5EyJqAA//Z8isVogRsCk86RVZzK79yB1APzjzfXsx42T6esieuDRbVslZbmr9jHJM9Fx+keWtQRiZUbLDOzfnnvwQ9jGrzJRGoq/FNz7qs/q9fRiqAj4b52DH1zcI9n66Gh24+vHE3rRbu2rKIBMLpDJu5Y8AI8uECVydO7Ha+DnUaEnIsobYxdkqy7cP5zHX7wXDaIx66j8K6pGXxNhg7Thk1eEMz8pgNvkHAfdODlmKtuj5VSwTqN0mh0urZgOwFNn6PR6qk+N9EtyowagYBHFLh2dqrNDKY93K49v0Eux3wqkFirM9Dm4FSiWxCqPH32852FQOSReggro5gOyhc8AxWqWe1CDQH+3LTVxVYn2jZEGKZXanzooBb+S+eU5YTITLVgCSqHNEBTIE3IzjWVBbwTejMxgaVml41gMgCZ3SObHmkRA4GWw5VflmRFe+wFJKpLOnBsVDS8MAeUN/W5Shs3EfIJA33UZdWuiZNPu3+IOvDj32kLl2h1RCtStyBB19u1EUFGzDMcAloBlu+zJiJdacwFnLo4LMAC7UFP14jBb/kigTEKVuAu/HoXkpEO/Rv1V5DDk+5VZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ERuzJroATcEBYs1wpRjdKjmc8/rmuN3KmM9jbT639g0UbuSvqbiizgINrM?=
 =?iso-8859-1?Q?FRvDNE8DAoiON7DZFqX8fBCJXWV65uGrSXLSuJLBOWEkA37ZlqOyN7l9n0?=
 =?iso-8859-1?Q?qif3ZGkZnCeCpImkbt1cHeWLrnpD09XZSrQFMzPfNAeRdz46VeRKWVdThR?=
 =?iso-8859-1?Q?sDoXkwGaGyw/Sk3CIVaPV4aC8H7NIh0W3YTwPCJorAg/VkVp9Puelh1RN3?=
 =?iso-8859-1?Q?g8wtW6w9APF9dURIpb8vPeg0al0glqHaEzBgruOh56t/FfwpNfvUsljN2u?=
 =?iso-8859-1?Q?Fv948VjyjMN+ghvxMXqldYLPv+47+Z+fGJc7YmQOk4g/gEI3cZptpOxltK?=
 =?iso-8859-1?Q?rc2sBme0hcrX4VsV3heG+zliTi29upjlGoafhPD3/GqLR1Ici+raprjgJH?=
 =?iso-8859-1?Q?QRTYSS4bdHBtbMAfjzM0+b4E1GFYHxKZfEsQ9w7dScjjtFg0S29gc3a6lM?=
 =?iso-8859-1?Q?dScvro35jFtQ//O2HNa1VgglGoTY+D9zsRsY8zCXkQIgLA79CQPDY/A9Pi?=
 =?iso-8859-1?Q?btv/+IKRlyILHXQq924Nz2SCDU+9/QZbbXUhPPC+Wa36WRhOVaD2ZZgubn?=
 =?iso-8859-1?Q?Jm1G7FufXGXF0azMCCy2aMIlhTHknwk/XgqDsHwTDyln0sCd0/IoUkgMi8?=
 =?iso-8859-1?Q?8QFs3cR2HWYfbrGQLZMsW5/cEGKDRFgvoe79xBroEPU/0oJtyAAlPnidk5?=
 =?iso-8859-1?Q?BMcFjZwIyJG7iyN15UJgL9HZFml5la7/R95kAgHzTsWkFFEPIOqnxgWPC4?=
 =?iso-8859-1?Q?MQrmcL3oWoE9umbrMPjBe41QDbt/bhaxy0Xma/0Bag25wMCzXlBxvByuM9?=
 =?iso-8859-1?Q?4+sbTe2+FX8QYBcXVGlDtcEntDSWxNfn86Rc3A3P3oOhhAMweVNqQeu12s?=
 =?iso-8859-1?Q?t2wyM8du1amQZdDj2xpzSv9EighQwFNlRsYQGvnaKm0vGq2VwiToHDPye9?=
 =?iso-8859-1?Q?Nwn7fjK9BzyD2OL+JbAqYdEE74VhiVbE288wK3RxOwO8WceHcX0B1TX85o?=
 =?iso-8859-1?Q?bJh5ZjlrHCXMw9t3KXit1dB+2P4PPvXDnnLcw39uCj9zBPW91MCuvaEi7x?=
 =?iso-8859-1?Q?iktJKpva2uEkE389qdyH4E/+aU75EpmSYcxScC2YvjlBkp41kvBmSpCzyH?=
 =?iso-8859-1?Q?KYi2holj4HszZwq3XJKtihy3yIiOrMZvkarFXQz/Urj8jhjjvnrFtqPEut?=
 =?iso-8859-1?Q?vhjSNRmnrXQuQ/XK7D+DVW44DO8Zv/ZyXc/LMqFXTEBBvnsUuBs1HYOhdk?=
 =?iso-8859-1?Q?ScbpxBuIeJCTm+Mch+lyk+OfXMHLmZcdQl28Nh1lUsTVfcWYDDMGeFr+x+?=
 =?iso-8859-1?Q?XduSkKjZNl35Ryd6crfGNjXnsEnfXVCvgdhq2tELCyyY8UOzec+gfzTdCC?=
 =?iso-8859-1?Q?rdHlfbVlOjR2itchvrOTRul40mONRjNZnT8JiYUDlvglJnQ4OaD+ChgGMS?=
 =?iso-8859-1?Q?VSiD+XFg41a+SQ9mvdBLNB/yOfrdcSZ3AcNlu4cNeYrHM56neUl+4LmTrp?=
 =?iso-8859-1?Q?T+2+WUun+xn9cWoAe4qTFRwrDje+CN4sA+V+pXdZhvtFCUozLNfd97f5pu?=
 =?iso-8859-1?Q?A/83/OB44znBAT0zxqXYtv9nPMuFLqza6iwFrdmWrebF2L0aWXUlsU6XFI?=
 =?iso-8859-1?Q?ZYA9Toy+v2bucsxaDr1XNQ9OEb4W5DtxKo4iX2a6FoM+4qMjsWTxxaKweO?=
 =?iso-8859-1?Q?8WabGOKudyk/GT/vb28=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37543f4f-d7c8-417b-783a-08d9f09196a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:17.4326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7IcQBwcfIE3l5khDR1qrpu6ZgvSgQzW4El4nZmuTH44IezTA4h3VKOrSluARa3BkuWR6deG5fI0w6AJiqwh+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-ORIG-GUID: fA-Dj_OqZmUGAzHdgxNkTbgThso14vZx
X-Proofpoint-GUID: fA-Dj_OqZmUGAzHdgxNkTbgThso14vZx
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

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index b25cc1fac945..177575c445de 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -342,15 +342,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -366,8 +369,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.34.1
