Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE92A57C1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiGUA67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGUA65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:58:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C022AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:58:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L0cj5s004022;
        Thu, 21 Jul 2022 00:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=CufpSW5yy47N6DqX/duu0pgSsLWPYTlYb4upmh0Y8MA=;
 b=XbvzyYSfYmuOlvgY0iGy082L/0Ts7wqoYdnQnccyqXG7DMNYkZvpRFswi3bLFMHzsSKx
 5s8Fm90ejtATdYn4yJDLWygySxioCchT7FUmScXM/rVNyOlziborjO3yBgBjDNyd9SvP
 sl0dW1Mvu+ftIWYh9t4IvSATKFnmlBV4H6/Uf4CN9xOMR5m152KBgE5fBZesoK/YPqhP
 YNP7D9BuDzPMgwXH924WblSjZg+35ei0gAV3Utmc5KafAl7AZsyU8lCbrsRfioFf9TwM
 fKdeHof4a6cmYbDyduXzWhwrp62jqHXIHxxy6QPjoJ7Hhfp6TXfJGIqB/mBy2zcE2dZl DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx1353e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 00:58:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26KL4ieU016456;
        Thu, 21 Jul 2022 00:58:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1enwf1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 00:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECX+lhgU5OWRVfvoD5hJ8vRC0gmQNjAbK8p6/V1H3pL7uZ2AwwKMaORhYR6i/H+MFJqbvOk+LtXy0r6DvogmDAaahagv3+iWVAPcHHpWv6PpCSzj9Ta4cP6NXmK9ii4ewHbTwbwM0DOmpJgT9e3JrhivuFz9F8HIQuBv4Ze39cmo7L+mLV5JX9qvSQAb7kG0r+GTrR3/ZJ4/JOrgcAfReIcAoRCQvDa+0Xd/2BvdSvBgfNa3KJVfoLYgIJYj4Tlc5fthO49DgEDfwF273bDXdnLApzdoDsovtPvaNQ6mHKS+1CPxO4b3BANubzJiygy+ig/9GKDBtPbl/UsHDi7XwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CufpSW5yy47N6DqX/duu0pgSsLWPYTlYb4upmh0Y8MA=;
 b=TfYNi2SK6tLrEF8WfCthaBop/UQcJSCKrapcEc+n9r/orPhD3Xj31oLCkAIJqpr1MBsaT60YNo4l7c1A937NFpAGDWrORno8rvAbIV3bSsHC/UECFwQeYeSEfQk3spbPC1J601a/uWbdijqxus/pb3V8RMIEU+wgLB8SbYZLO8oyPczuy2AabmntKL0gxq9V2CstF3/FaPGVUXYKssiHPp0P7b3p2FaVWdQZ2ZWZbn1h2YVIBtes3ERXOuX45ALmL6KY6UR+3n9S/TJ8Zm2DVvhJPPzuVfkfqb+pINa5bjyY1hBF53wMTp44Ra4AdM8D3glun6m8Gj+rglxxeNTifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CufpSW5yy47N6DqX/duu0pgSsLWPYTlYb4upmh0Y8MA=;
 b=NPw0ksd/hN9DSJNvAy9Jpu4AkYfHMHu1l6HA/ui2w4UK++++b6mo7xYcg4PnUbfaxBtnv+25eVlUXrWy6skYWOzHmXuQdFPjYSjCF1Lrj23ZyQXPxp0cI6HebWFO+PCje4DRQW5HWBlYTxKfKjQBC78qnDqv/5JIlZKvtkONbig=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3392.namprd10.prod.outlook.com (2603:10b6:208:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 00:58:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 00:58:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH] maple_tree: Add a mas_destroy() call to
 mas_expected_entries() failure path
Thread-Topic: [PATCH] maple_tree: Add a mas_destroy() call to
 mas_expected_entries() failure path
Thread-Index: AQHYnJ0F6sy/qDx3PESlOFGScMcSqw==
Date:   Thu, 21 Jul 2022 00:58:43 +0000
Message-ID: <20220721005828.379405-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 312530ca-9be6-4549-23f0-08da6ab4287c
x-ms-traffictypediagnostic: MN2PR10MB3392:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hRf4rT6X6rM5oLAhG9mvXeE7XX3uZSpztImxcMW/gvULumLSkloxsqNLY6wubwGPxTG7yTgdw9rwveQTll6yhjU4zGe6HsmZ4x+EDZwlWHk3awzMBbyhjHOTtbODBqUZUmWFyGqRAfY+QtRt1iJbNld+KyLcQIin6PFBnVyS9t26qV9+YvmglvjepyOvdo9O4WW9n+mVbjkvkgTKtr9cFBkvJB9mmlGaXGGGVHbSc8XtjyBEmmtQrG7UKbjn0cIqNzvVVOolNpuwtm0uvUvRwFkKf8O/3yY+H58Fy+tIkWzsW2xdfeTb8tmue9RFaCAszM9YS2ulG/JXvcmRYfAJHqOEt5AqY9WplAwSnwbhkXxqOyEka3IohtXlqtNxUV4AJpv5l2uGgRZ5GMMnKVZ33av5S8V+7/g/e8mjP4Ns0DmCGrHczfT2BmUThhHZw4aGA/b4qLSNdPtBOsK40NC0n3+KdQJWIWYPx0Y/XkcJ5ceMc0inrtNNv7KakZWd/pfGuWT2OTyTh1nEThLxSbf6RvrAR1s0i+ZpheXsltN6zRCAe7pJJ6DFD7T3qmZ7Sp/g006aEnmjBNFbaO39K44HeN+DzVz4kR64V3h/ScahZZDUsjCIhkd1up7OKU2UsEMYrbdNgmJpYAJwJgVjSGPYBsaj+X3TStz4tgk/Wx8ffjxFJTsTKNvYghIANh70dtJWsNAj6gPA4xV8SdwrsmRSgvOU6Evry+hYxKky9GSH0++dhOTYR9HBPWbiAnSvAiVm4w1I5fxqHTpW5P2eGcBYY9swMoQxcYlQsWebzGA0wOxVrVMChAbv6ktct4hOSVEp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(396003)(136003)(376002)(6512007)(86362001)(71200400001)(38070700005)(1076003)(478600001)(26005)(186003)(6506007)(2616005)(110136005)(6486002)(66446008)(41300700001)(36756003)(38100700002)(5660300002)(316002)(64756008)(2906002)(76116006)(66946007)(8936002)(4326008)(66476007)(8676002)(83380400001)(122000001)(91956017)(66556008)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ja7IM75OhmXxjS3qsD1oo2WdzTUs9KUxTXbiR+lFXs7VBOR2obntQQ7wuN?=
 =?iso-8859-1?Q?DqrghSD/Sq9F46oQymBBL8aDzA9DqD5Bk1u4qrFFddkJiD8ZmFP2bu3QmZ?=
 =?iso-8859-1?Q?TXo33QEozNkSkTSBgGytSbirWy/OIGppAVGYDtNdLuiu/xi90ArsYs8lRu?=
 =?iso-8859-1?Q?xR5fy3BK7L8UqcwRZSkwcbLg8sUlqux3rWfkc0VExn6WDF8cLy6mAgN3M3?=
 =?iso-8859-1?Q?Pc6403F9HGSVPKHbV1n4gFcBpyOMCfi48KhRf06aXonksF+gdyiPrQlewo?=
 =?iso-8859-1?Q?5zzJH7GFTW48zEQZNbveLJNOu2R0cGhsXXBN2dBPnUmloP2fnxJyJC1Fhg?=
 =?iso-8859-1?Q?Qf1DhOL5tNurwq3BJD0K6JNoHL8oVDy95EHU26c4Ng62SjfdE1m473Y1fk?=
 =?iso-8859-1?Q?0spI9Ip30LsbbDyHYVQ5ZttiNpiDW3SJrlmHERAAq7pDiuQAT/WLB/Obpg?=
 =?iso-8859-1?Q?XoOfZSSL27J+XUbI6qeJFFq+5lTcQ8Dz1ZeL7q+vac/X0FPSmpEzWKbPY5?=
 =?iso-8859-1?Q?hGx2NoQxWVsW30hb+3KULtTZozWV6CUxu7Z1ys0JLdCaBH9AcumY7LtgEc?=
 =?iso-8859-1?Q?eajqEaw0q+SJpMbQ2O0pYHDj0lEnPMuIx6AuPoh4vD77RgsGpWtV9lvOCb?=
 =?iso-8859-1?Q?ywj6jgcu8nf8i3FHsqoPDlYtThKn4wYhasTBCLooWyaDju8Wv7fPjD3lon?=
 =?iso-8859-1?Q?wi2B92d66GB3GMR4f/ysO8SCKs72V5/Jp81LxQbioGK2eghbvUZ2GxUFhY?=
 =?iso-8859-1?Q?dp2BRS/rRjRo5zsux/6v9J8PEGySMcaTZH1buOZuuzevbnh8l6hZT+GDHf?=
 =?iso-8859-1?Q?HyhTCKxMzguWsKI18JDgc1E5+p3gqTqTeWUd6OqlfhQpwr5ExnC03yixk5?=
 =?iso-8859-1?Q?bj28vxxNrpPfQTwtL+9Jq4O8znH2zeRUZ6SVmtqtCzd8HJTDrAQnwNVX6F?=
 =?iso-8859-1?Q?c67e50YsJSdtXoqRM1JiK0EoWPMsNz6OHeS/AGe6ZToN/r7zmnK4BxOhbb?=
 =?iso-8859-1?Q?q4ZMNN+7O7yL/Az0OI44zymUle5DmB+9+Svu+OEwKyZkNNor235tIsA+xu?=
 =?iso-8859-1?Q?YRxkx6JSrGeL65el8QSETGFTcmsxmcDc2EqBbc0Q+yGgbEr+UtfwLhHOxl?=
 =?iso-8859-1?Q?wL5XP8w0hQ5P+k0BCZVoBTsgfLKZTA74+A5KCS2JV26gcUvZ281gZbRelC?=
 =?iso-8859-1?Q?0dBqWsfFx5N72wcMjxZzTV7aQydOuZeb+BJol4/Q3RexwN2NOai10Pi9mQ?=
 =?iso-8859-1?Q?U4CUHXDdV+HxOnN+spqBxEtcWVbn0WcIW4WjMDt4s/oI06PtX1RSiIgjkw?=
 =?iso-8859-1?Q?8yYIwWIV7YJN9dfaXlwWms1z9zxzEw2R9tA04XFMGo41JZn0MO9+h8l9ew?=
 =?iso-8859-1?Q?ae+dWehQZ8YOJ0ZpiTbXWGO8Tkxlhdjg/ZDV0y6RehSmrbHvN4VzNjbGyD?=
 =?iso-8859-1?Q?fEHvN/At5x/LS8gtvQ7YcF6G8kR9FANFoFBtZEIFT7NAaPrDDqBq8YbZr7?=
 =?iso-8859-1?Q?8dBisOT/nKNKv8OgigYHWd7uTiu/gjsu9NLE6uzs+dzt3/etvNaEdfC6SF?=
 =?iso-8859-1?Q?PSbaYzG1+CTemY0KKgAAAQZzyXTbZBgDCq2Uix69bmHtmLnnQFYPXFrhIo?=
 =?iso-8859-1?Q?ulTi9lvtz/2MkVnVTpma1bRwjIgfUbBuqbJvkiIeMaamc0NiQxGz41Ow?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312530ca-9be6-4549-23f0-08da6ab4287c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 00:58:43.2072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLj14nVZkS3L0aZEn0oCSTTAefl55dQYxsRGAOB5OOV78YeatXktqbX+vRqjY8TvvgyCN6S8ilmW3E+khfQ7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=953
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210003
X-Proofpoint-GUID: AZ4p-ZvOCHWboSG36lIQu96y3qXrqNv1
X-Proofpoint-ORIG-GUID: AZ4p-ZvOCHWboSG36lIQu96y3qXrqNv1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an exceedingly rare case, there is a possibility that allocating all
of the nodes may fail in a way that the maple state is left with some
allocations completed.  This would happen if the single allocation
succeeds but bulk allocation fails, or if multiple bulk allocations are
required and somewhere along the way one fails.  The partial return is
already cleaned up, but the successful allocations will remain in the
maple state.  When this happens, mas_expected_entries() may leak memory.
Fix this by moving mas_destroy() above mas_expected_entries() and add a
call to mas_destroy() to clear out all allocated memory.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 89 ++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4c383c780162..d00ad50b258e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5717,6 +5717,50 @@ int mas_preallocate(struct ma_state *mas, void *entr=
y, gfp_t gfp)
 	return ret;
 }
=20
+/*
+ * mas_destroy() - destroy a maple state.
+ * @mas: The maple state
+ *
+ * Upon completion, check the left-most node and rebalance against the nod=
e to
+ * the right if necessary.  Frees any allocated nodes associated with this=
 maple
+ * state.
+ */
+void mas_destroy(struct ma_state *mas)
+{
+	struct maple_alloc *node;
+
+	/*
+	 * When using mas_for_each() to insert an expected number of elements,
+	 * it is possible that the number inserted is less than the expected
+	 * number.  To fix an invalid final node, a check is performed here to
+	 * rebalance the previous node with the final node.
+	 */
+	if (mas->mas_flags & MA_STATE_REBALANCE) {
+		unsigned char end;
+
+		if (mas_is_start(mas))
+			mas_start(mas);
+
+		mtree_range_walk(mas);
+		end =3D mas_data_end(mas) + 1;
+		if (end < mt_min_slot_count(mas->node) - 1)
+			mas_destroy_rebalance(mas, end);
+
+		mas->mas_flags &=3D ~MA_STATE_REBALANCE;
+	}
+	mas->mas_flags &=3D ~MA_STATE_BULK;
+
+	while (mas->alloc && !((unsigned long)mas->alloc & 0x1)) {
+		node =3D mas->alloc;
+		mas->alloc =3D node->slot[0];
+		if (node->node_count > 0)
+			mt_free_bulk(node->node_count,
+				     (void __rcu **)&node->slot[1]);
+		kmem_cache_free(maple_node_cache, node);
+	}
+	mas->alloc =3D NULL;
+}
+
 /*
  * mas_expected_entries() - Set the expected number of entries that will b=
e inserted.
  * @mas: The maple state
@@ -5770,54 +5814,11 @@ int mas_expected_entries(struct ma_state *mas, unsi=
gned long nr_entries)
=20
 	ret =3D xa_err(mas->node);
 	mas->node =3D enode;
+	mas_destroy(mas);
 	return ret;
=20
 }
=20
-/*
- * mas_destroy() - destroy a maple state.
- * @mas: The maple state
- *
- * Upon completion, check the left-most node and rebalance against the nod=
e to
- * the right if necessary.  Frees any allocated nodes associated with this=
 maple
- * state.
- */
-void mas_destroy(struct ma_state *mas)
-{
-	struct maple_alloc *node;
-
-	/*
-	 * When using mas_for_each() to insert an expected number of elements,
-	 * it is possible that the number inserted is less than the expected
-	 * number.  To fix an invalid final node, a check is performed here to
-	 * rebalance the previous node with the final node.
-	 */
-	if (mas->mas_flags & MA_STATE_REBALANCE) {
-		unsigned char end;
-
-		if (mas_is_start(mas))
-			mas_start(mas);
-
-		mtree_range_walk(mas);
-		end =3D mas_data_end(mas) + 1;
-		if (end < mt_min_slot_count(mas->node) - 1)
-			mas_destroy_rebalance(mas, end);
-
-		mas->mas_flags &=3D ~MA_STATE_REBALANCE;
-	}
-	mas->mas_flags &=3D ~MA_STATE_BULK;
-
-	while (mas->alloc && !((unsigned long)mas->alloc & 0x1)) {
-		node =3D mas->alloc;
-		mas->alloc =3D node->slot[0];
-		if (node->node_count > 0)
-			mt_free_bulk(node->node_count,
-				     (void __rcu **)&node->slot[1]);
-		kmem_cache_free(maple_node_cache, node);
-	}
-	mas->alloc =3D NULL;
-}
-
 /**
  * mas_next() - Get the next entry.
  * @mas: The maple state
--=20
2.35.1
