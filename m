Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8857734A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiGQCtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiGQCro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2DB1BE85
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8OBa003742;
        Sun, 17 Jul 2022 02:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZK8TP0yYq77/UryDrwasG1ZBGXhgeu06+0bYNoI8rcs=;
 b=audJBxfinRUacgropzMNepUSZh+fI1SCqahjj6IxHw9kigwByQ40fZKH3RBrV1jFJmys
 Je6d5NqmzhgxNOUMBUAz5xB2yhO6UWIeKVVoO1feMJBN1Ja8u1h9aOAWdqLrJP5fZq+I
 6TeqFcObR0Fo34q3D/W3kYIUdkrvegum2fg3Ns3ASuujG+Bas9c/ZCUnjqJj+VxPJ646
 YlEaQjrwgTUqnXZF/9+wUQ7LHMz0G5KoCK462E1uzvDKhTdYCE76EGFk0NPFsa8ChMIL
 J9GbNK1m5rBVVIncQ/qqIMmq6ZHbM0m1UwWvcA682dR4Rwo0j1GTP7IAoO3360cz++2o xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImZ036151;
        Sun, 17 Jul 2022 02:46:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkg0trk8EtiIvM0DrUl9+343BrNqwADvNm3WtRjSNczC1LSVtyqgXu/7BftHtUejNXyxk56iZ1uB/CWIt4AoEgNf/r2PNQEJJwexBRC3Dg05zMBzmyxuk9Ff9YLMngsOg2MMI9OhsQsxpobCEcuWraX6r5GpgyOdk/WTWyC6FJjgkqzXMcE3Pq1xnar4JdMsFkeC2NVLgbLakauC6i+aPblf8iTIg/8ruNl4o7an9Vg6X2h49OUwAjb0H2i+cZqdV9+gAZ8sZK/a1NruHxgg94KplW9GMv2muEzla7woKsPXyRBq4Pw7To7nv7Vay5aNWSQooz/V3aDEEQzK3vyyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK8TP0yYq77/UryDrwasG1ZBGXhgeu06+0bYNoI8rcs=;
 b=LPlyfeacE5rsF/w5ZGokAqMFv9PaTQ6d+AX1XqfWHEst+3XWsLwylRkRmnA21T3D2GfQJuLGZjpEL/JQcUsliSHgRBK7qOXMpnKQ3n9QdXO4auPooRyvvmAFNKEzsmV9ygMoxbW7IcQDwvXyP8x2UZwKzStxITHEhen5myHayu5jdF8dwAMkPxKOlVxQ3ckMcknVClnlwMhzhDXYQg3XwKVCKP0YF+DnnYnlKb6r5MPJDcgQNF3/F0LXbGmNA7XV1sEGY9/rEplokKP9fKoC3p0aeQtP8GYq1vOHY73XiSIbmzI68nD5DOGtPFdKzHKjWNLs4P6LKEOH3y6UffpP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK8TP0yYq77/UryDrwasG1ZBGXhgeu06+0bYNoI8rcs=;
 b=ZeLFZtuKdT7EQEMtMPQAbdILo8R5kBvT71k3pSRVFUg0WnmzeRiMEiqtlJHhM+OCDQf62vpswFC5rzR3rKi6d4vOI8MZrUjTDkeFqgL30eaL7QI6XrZDBjqGjCU4+0jLfPl3PS4Fobm8s0gyz0BD3gCoQXxuSDl5iXltYA5tj4s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 18/69] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Topic: [PATCH v11 18/69] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYmYdyFewIvnM92EWO05qXvnfY7w==
Date:   Sun, 17 Jul 2022 02:46:42 +0000
Message-ID: <20220717024615.2106835-19-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 517d60fe-0bc4-4d64-0de7-08da679e96b2
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2eTu+EwQstrmyYiNj0RYRjdaxM5muPXWoU34t+NqFDufl1Ta3IDFDvXoGM1aBwtygk7iZa+F/HY+afh7Rt8W/4TJmxaPrl8azKjXSkdvHigcvGQZorn1WvbzqR2Gh0OTNjoYIDu5vz8+WDwM0F/ig5U5LumOEzpHXcBMxIqQQ7kF6m4Bo5bcYejyJQSoVnsyv7OUH9BykqzxpFg47wIj/nQP/lxp557fyv4xHCb+owkcxHgw2WkVgXTeNhPZi6PP5wbi/E1PNxnKqdDEnZCSdT0xmHW8MtAsv9D+t1C9Ni6mJd59MfC1VoskqOD4KcfZUta3R28D/sLrRkWchgXo0E5t7ydlXfQD94Dl5bL4cdf3UaNiEs3n9z4qt3Wk2Q1BbbzgLJUpObG/kdnk7cG/V3Y4Afn7OYsijDRnwDLHPtGF3EjWJxtulU1jYoMhMK9wNy6uEOLlwv7LXdruWiiRgFiU61DL6ych1/hnufrMRctBVxQl2EBB6cr8hEWJXdRe1OBU9gWBQHRuTXZZBBmkz9A5HkcwzmOxyvS9/vrzerFDtV4Lpz0fzEER6wnAcyg941eAIs/qyVcZHO3V+hcsmSwFalRkKy/KtB17y0bCTYcdwOe5+NHCwSpWuEFHjidyDPJAy3r9DzH1xUPcNvSzjy1PhGKb+ZSqwnAmP4cbARzhE1/AFZnRTX+UfG/3GCcQpCVu8rHhUCe5yvZKwK5eOqqAvbcLB822b3rjcsPrXzsIpvqqxd+bnh8bGSPmP5tAPrWADN3XfcOJguAkqSEzd7PG9iegurckyv40fEZkipMpP8+LXpgPsxstQs/rL7K6TAGe69XLjp8S3dNVTJz6qqXqlxrsov48a3IMMt20scc3RCvtcoTzT8HZ+n3ItG5qPlf+i8G5xsrxS8/h0yOAZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6RyGVUoQzK8rR4loJKwHCUDu+3qdaLgZy2ftrvb7/HURY0t6muZ7hocgst?=
 =?iso-8859-1?Q?A6ZQfVagCQfHhfGBhavC/FTdo6T5EjlHD62JU7eDgc3mO5krkXFP8eiTAk?=
 =?iso-8859-1?Q?vocDi0p/Jaqb4K7WBDNml1gVQhGL/0F5Aaftd4FB5yg2fddOMQeacrcRR7?=
 =?iso-8859-1?Q?QoqhN02vz6EJX6xwmy8vegZu/ZzbfhR7E6MXNwCcv74zS6OXRzqYPDCtdP?=
 =?iso-8859-1?Q?A8W8ip73ahJ3at+M3fBPwt/NJ7pX5lTaoAVnRak9S+eRUAiZv6FrydU3X5?=
 =?iso-8859-1?Q?kJggIoQpG9JBpNTMfwZYrkDTxQWvLkEwoLQD6NFsDbhNNx0J0hFacqQI7+?=
 =?iso-8859-1?Q?PUi43O2m2KCJ7+gbu/BTCBZHxydPcXLcDYkkOXWOGkiJbMIoGfrimDOTVH?=
 =?iso-8859-1?Q?a06ixPEKf2ejtVGnrFZghGnoKYY2hyZyPC2bfgcCBxpKFWhncQzQ/c8xM7?=
 =?iso-8859-1?Q?LlWxR8xI6ODfAABh2REo3bGbbDem3Q1MGkUC7SWmfFaOREWwODxrcRlxK/?=
 =?iso-8859-1?Q?OtZv3qNAI8dVZQjb9LE9XyjOk55zGWNgFuhH3BBKYz6pXJJQdv1XNsQlWt?=
 =?iso-8859-1?Q?lOtmpoenVLSaUDkYHqkSu5Pc3l1Bj5GyQjd8eXqlfglS4uuQUvbr1lDo1c?=
 =?iso-8859-1?Q?OBAU4jQxNWyFMxPW1lcdA2/eIXlkVjiXbz2M36LJgduNDWtnpUH6IaU9RB?=
 =?iso-8859-1?Q?cfKXdAITt97F9NFHsyXFXwm+XMfmfMMb4/2YXCGY9vQZlFULscapohHjxk?=
 =?iso-8859-1?Q?PltuU/r5fiH+rsrC8/DMBvTO7mnnOf/gY9n5RgYGS/2rQIWFUVYGI00DKX?=
 =?iso-8859-1?Q?T1KwRNSYBMkalAl/ZAyiOz5Y7HSDr06+cV3/KtnLIoBluFWRmlPfJhBssj?=
 =?iso-8859-1?Q?hg8/6FQqiBG5JnkOKJP0DsNszkcChxonaZW+G2GadFPA7dNHVpvmv2lROp?=
 =?iso-8859-1?Q?A6/D3Rr1xW3YagFJp4N0UXL3oLatH6EWuwgdJB/apvOVT5MmDeBdOhnlsU?=
 =?iso-8859-1?Q?JSCQfQndk7VYkOC16obtO0yuwn4UyfUYbH7KqvlPEhToG5TcJA2EcIErjp?=
 =?iso-8859-1?Q?nCuU/M005bGHplXe5GuyY2QEvuIWcU1AJ+/EZq35+ElLh2v+Qor3YLmgaY?=
 =?iso-8859-1?Q?fDiafS1tHxyLJLsdPaOakZsRcX/+Wz20HMsgSkobQA+tRtFYSh01x1JJ6y?=
 =?iso-8859-1?Q?1MdqsnmvAwec3ij2Uv1LDMK3eP2V0Of0WUJlIYA82MTVGDo9erDxUj9jn1?=
 =?iso-8859-1?Q?fEJBfsG5yw6U9/VphI+3nLlWRntKVEF8FQw74gr+ME02Lh2TfQVScnK66j?=
 =?iso-8859-1?Q?VFAVjqAuUZ3j0rJA1c70RmLYx0o9iwHcfU3Lc89VUBIsbvb3JcGnIT5fyT?=
 =?iso-8859-1?Q?5gNEK31S1XvOqoh73evBAXOrukyfdOADNRd5+MdSaPXsbqGbxxT44PGrO0?=
 =?iso-8859-1?Q?jfgoKiv4NqZAcFs2p5SC0mn7PNqOMCtDu6WDpQwJQhueZ4gCs7I3ZWE1i6?=
 =?iso-8859-1?Q?Iux506SpfN1/Pw+8QtMxp/hFnuwsjNOkAGJuxRxTTUE5H59mSnSzAaf5G+?=
 =?iso-8859-1?Q?8Y+389CQBtgwgnMJmjWzLh+IIFAey01F2SfrGfpTl9+9OhGZYDmVtVJFk8?=
 =?iso-8859-1?Q?u/2rkamHJ+V5UZzxAuN6sEX57D7vwyHJBRcXGJ8ge1TFuhZa87rv0Ffg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517d60fe-0bc4-4d64-0de7-08da679e96b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:42.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTVDhI7CpHJCNrJ9V6eZRXB2roWMPGO2oyfzwnk9rUlXHUYaG/kWb4kZPyV+SbnXkEjK5JkiWiUJj+uROXDEHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=925
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: WBiaWFVAG4rYqXS3Z0WohVNwcJM9scPd
X-Proofpoint-ORIG-GUID: WBiaWFVAG4rYqXS3Z0WohVNwcJM9scPd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

The change requires a custom search for the linked list addition to find
the correct VMA for the prev link.

Link: https://lkml.kernel.org/r/20220504011345.662299-3-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-19-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e50e989b7aa4..973512b14d55 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -614,11 +614,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma,
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
-			       struct vm_area_struct *vma)
+		struct vm_area_struct *vma, unsigned long location)
 {
 	struct vm_area_struct *prev;
=20
-	mas_set(mas, vma->vm_start);
+	mas_set(mas, location);
 	prev =3D mas_prev(mas, 0);
 	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
@@ -648,6 +648,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -778,15 +779,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
+		if ((vma->vm_start < start) &&
+		    (!insert || (insert->vm_end !=3D start))) {
 			vma_mas_szero(&mas, vma->vm_start, start);
-		vma_changed =3D true;
+			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mas_szero(&mas, end, vma->vm_end);
-		vma_changed =3D true;
+		if (vma->vm_end > end) {
+			if (!insert || (insert->vm_start !=3D end)) {
+				vma_mas_szero(&mas, end, vma->vm_end);
+				VM_WARN_ON(insert &&
+					   insert->vm_end < vma->vm_end);
+			} else if (insert->vm_start =3D=3D end) {
+				ll_prev =3D vma->vm_end;
+			}
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
@@ -833,7 +846,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, &mas, insert);
+		__insert_vm_struct(mm, &mas, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
@@ -920,6 +933,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
+	mas_destroy(&mas);
 	validate_mm(mm);
 	return 0;
 }
--=20
2.35.1
