Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91FF54D6E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350582AbiFPBSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349989AbiFPBSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:18:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC31EAC7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:18:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FLcXru009908;
        Thu, 16 Jun 2022 01:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lmhWxVhmnXmxvHLPOyPtk7GraaRj0TzIN4wkdhlEmF4=;
 b=VCxlausvk3jlr1ZuwJ4Ak7rA838MtTSLFOcBQ5nBlWYQT1pELnwcfF9lsxpAehUUJP3B
 40fRYLm31bn3yT2nTdZyZRDKZkBIthShKv6oTyZ/dT18Uxan6M0t7bfBCm4p06ZWW22r
 QjdVBXxLA4Y5xch825y7rX+QobNLGM/QdbBzeHANWuWfotGL7k4QbezYk2Z3gRMme4rA
 rmxszt0mYGYHEv5RfFRG3ZacHwBFvrGGvWT4K5QkEU9m36PTgLk1JdJiwy6PO1tI/Akk
 LlH764pB7zK1JJzVdrqvNrX8rUp7C9MDIwdYDuZPyu0Ms8RzOTz6PyUvot46S0zGffl1 6g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkkthxps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:17:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25G1AY2q025240;
        Thu, 16 Jun 2022 01:17:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gprbsbqhj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWsuGYKX+/spARHYhH9fxNaoKIPuTofhdhwZOZpnw1SJr4nJVFFWvKdchyjx5PyiuJOET8vewsKD8l+H8l+/g8Ao9jOCvbHfQX7UYxTOdyE72cHVzKwQYVV/w3h0mIiAwvrvt3kr20n5viS9xVd82uRZIfcbhItBpUx0xIId2iJ0H7HR+312XZ28A5S+baCVl8h5K/jNbqIXobW6lJlabRNwgvZPEZLzVoYliAnX5ZajmcsStk8aaqQDtT7zxYL7CY6ZvrGTrQdXj3cmu5BT0SmNXZ5J1/+VnDUBtAsbyNEMxDJIvVekBAutJRkf2ItV+3y7I+mESjXoM/RN11dfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmhWxVhmnXmxvHLPOyPtk7GraaRj0TzIN4wkdhlEmF4=;
 b=LIEeP3eXBD7GVOdI0IUwlgbxayDJ+ZwMbQLoWTpFu3U03qUU2qRt3RymWF8wsJpU7vJNukyuEO46adojZbLbbiMdjX1WxmarXNbnunmEE9k9dnBEfX8+7dMoXDGKhKkv5u3UACjXDGK7Xaxm/zp+nSPLS2PLO55xwVHkAumWDTVBS/TKF+lqkDn97ZqrrVgEUdNk/P+wnqEhAGpKLqu/9iojuElazJOWma3uDI0MiLRAYbwQLOkAd4wwE4VasDnWueVRf8NOfkTtuNl+JvaUHjmPKJ3rwAo+5EIBA6bT5Y08/Z5ey6ewILQv7N2prPHJkRCMBl7N7/4W1c+5WBuddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmhWxVhmnXmxvHLPOyPtk7GraaRj0TzIN4wkdhlEmF4=;
 b=Xk8tLzMQJINJl1r9f61dIfJdpYqfThyPDb/UDpXCU27X4sf0ApDh3xQ264uibVf+DILcVVAXESWvpYKVB+/35tZOxoIdIGTqd6QX/tSHdbZlR+p8w5crq/kqNTLUoEN1L65GjvVIhoAnOYuExnlTVrYF/HnlwZKV/dlkhB9Gz5I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3456.namprd10.prod.outlook.com (2603:10b6:805:d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 01:17:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 01:17:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 Fix 3/3] test_maple_tree: Add tests for preallocations and
 large spanning writes
Thread-Topic: [PATCH v2 Fix 3/3] test_maple_tree: Add tests for preallocations
 and large spanning writes
Thread-Index: AQHYgR7olLQoMIs+6Emr+1dYSc2pSg==
Date:   Thu, 16 Jun 2022 01:17:55 +0000
Message-ID: <20220616011739.802669-4-Liam.Howlett@oracle.com>
References: <20220616011739.802669-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220616011739.802669-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb5ec49c-1b66-4969-c8c6-08da4f360b16
x-ms-traffictypediagnostic: SN6PR10MB3456:EE_
x-microsoft-antispam-prvs: <SN6PR10MB34569EE5E0BB477A4E0CE4F3FDAC9@SN6PR10MB3456.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqymvjYG+qz4k6S55NoNzXqAltlk85xmfjkFNArOLwvnHSgUiQdoBYeeCDAVnrQ6pEyEIExAVELlbE9JKcbRbmKB4FP/B7yYJsd8hR1q+3nuoG3NItWLgyvYKGBLmLYCFPSvxf6Rms5R9/fPfZsHHTMyCehF150W0vy8FAQYFov5b6OzBRSc4NNRopn9vHZRE3B4hkhfMQJPkfvsH7vltO2hf1nyBuW8KTZ8acvjpN3CfkNGyGfFJL8nUy344sK5BbeIu+kohI1X97mvlG0bmnMXMPKrwEHBgn2HwzMewFAzLJtrdVDx+0Y+uVjOeM+e9tqgovaiaYsCuUIgNcu6RAs5Wz3Yrzg4r7BCuOdtX4bRCkqt2w9tCgvmNAVM3fLYCs1Q7oGRMXckIU3DwvX8E9THBXLTQTbwSVQMauwyYrQSmiCxmKipvcAo6BUEUrkYA4SVvo1ioGIAGZorFe9PPAD7PuklNPkTBllXVjWAok8EDg1UtqliR50ErzgAFbNRdRU2c/SlvcQvvMb4zvgdSiOQiT3fTHkghkyg5UoArbXqk7o+zw5JgwagMPmp6TIqolGgzd+sV7/WB/VgY+1JTrM53Pzl0lqnF3qixj4hEYiT4FuS1JUmyZVZOKSiZWwB2p6VHJyXvN3qtaAQadZ/mxmRObzBhX/lhwuAGWwn9L3k3tQG/ocjoN6uMf1na9hXeQ1WlJQuJ3oochc7DQzckg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(186003)(66556008)(6506007)(1076003)(6512007)(2616005)(38100700002)(122000001)(86362001)(38070700005)(83380400001)(76116006)(91956017)(316002)(4326008)(8936002)(508600001)(6486002)(44832011)(36756003)(64756008)(5660300002)(2906002)(66946007)(110136005)(8676002)(71200400001)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6UVyFWhXt6iGLN6JiW/o8TiXaTiq2pFCAlNaoE2HBkeo/CrFnzZzlXjp6Q?=
 =?iso-8859-1?Q?IyQ8zpPsXmbc63jBwBnp0B4tslWyT3eHDsUYnZrzzJ51OY3U7ZtidiNw2h?=
 =?iso-8859-1?Q?JIqBXjTwUo6JLswca2jb9Wteh4FwG5oBlIQbmZFAmKKiohKJ8VyQSD8+VH?=
 =?iso-8859-1?Q?vKIPzm3Pu/c/yB7A+zkvzg6OCa/IC+i0CHmDHT6QxGXzwsH7DyoWGKUpyB?=
 =?iso-8859-1?Q?QliUPZfJOQBu/3OcfGyoNScBB3vc4tEF1Vm/VfOjnmjLEEE19enmT69/zh?=
 =?iso-8859-1?Q?J7P8lE1x6V5Zk2D7MyM2LUAsjYAXa97ylhi3Hq5bmEu6SttGIJ4UdOqYoi?=
 =?iso-8859-1?Q?ShccfmYkjBN2Jw0FnVYBWk+4ktC3SXwEak0uPoeCcOuVo2I5GyfxiZ9Cj3?=
 =?iso-8859-1?Q?tDbDXSfBgTK5S5IABpAs7G+EddDZq/abbH5HNC5+QErrx+XY7UxOdkKHsg?=
 =?iso-8859-1?Q?UynWwH9qbBOAvjW9xTB2n/FIMjtpqLT/5d+89fd1tUt5+Lv+jMZxtitgEq?=
 =?iso-8859-1?Q?mpTH0hNVX4pnaGkaHsHrB4PoIvh/0aisGfkHw4TyZkBJGnUALbTOVZm0nw?=
 =?iso-8859-1?Q?7Sn4wWFhJPg836KYAZeKMRhJq04H4avz8p7jMloFZ3PD5EtUhLFZ0oNT4e?=
 =?iso-8859-1?Q?JkpC8tfXVlXVNFeKsfxxoBrIo7NsKDb7clYgLPWxBSkUjhlskGp33mC2Y/?=
 =?iso-8859-1?Q?86lHUTEgypm/gQk1GP00DvUn9//qsn5jKQ2WOEqA17SdZmy7s796CKw8tr?=
 =?iso-8859-1?Q?O1+oDWp6P4FGun2f+jON88HBoydh8a+X4gIInD0CMRF07jKtbMVIDrR94b?=
 =?iso-8859-1?Q?L5qXY8rtkBT4BcOEV1ttUyksiQPTLBjzydV/m0DJti0jsQz5mp+M+qSCZ+?=
 =?iso-8859-1?Q?xMsdS+prM2P0uT2gN5wGW978kKPQ8kY/aTqg+yZgJZ70Bf9UUJQqvI6xdg?=
 =?iso-8859-1?Q?rpH/UDPDujJVUGueYOnQEgGFxsjpGzXbPrXN16kzNi7T+QrEtsDaVRptec?=
 =?iso-8859-1?Q?oaywCHeg5Hg+2ya/CXp2TOwJlns5IRBFT8wwAn3iqtxDOGFmZ81sNR7E1L?=
 =?iso-8859-1?Q?ht0dFuC9Q3T66ceP79lt1HQmtbnEBU2niq8xRiZykUVPRTzEK20AOf7pch?=
 =?iso-8859-1?Q?iWvNRy0AxMrem8OoN7rj9FWOXp3eM3GdJ7p7AsxoGZb+A3/T1PzKNwxlmT?=
 =?iso-8859-1?Q?RgAe+ped9bsIIgggWgsG0Uq1ZFb+AIlaSaoDAvFMu12AlFRHbsd+kwUx3p?=
 =?iso-8859-1?Q?lHLvUvNgltfQXc7ATFxctBUVjdYXzzKYn5gtGPe8TWcU+JZoeyfE4m3HGl?=
 =?iso-8859-1?Q?3rr1FA3DOzQocpo2OHGKL6qhw3WvXxipzPnmM54T00IefLrVNqlywXCbvN?=
 =?iso-8859-1?Q?tgECrCRIldio+9D6/uZPDHR+Dbbr/8y3wjhEe7hYhLoGGWFPYA+gygzCLt?=
 =?iso-8859-1?Q?61p0de1kIMuZA+b7q8PEp5fRQtuJJodNtvdZEwNtJdDG0VlSoOkLdIm0De?=
 =?iso-8859-1?Q?996ba/QXBn+2YjTYsddAMUg8uy9qb3a3WHI+qdi1ORXyFisw5T1MPeFSGc?=
 =?iso-8859-1?Q?immM0JD3FDSlYCrXnfnEj0S29vOjCUr6Ah4GejB5v4Ywgoxj6fuzduPL5H?=
 =?iso-8859-1?Q?8MbSanADgHXOBr+bwNrf3G9vg445RRRTs4Ik5lI6P875+99XY/5K1nu3b2?=
 =?iso-8859-1?Q?ee5R/r9cnZUQKp4oI5Vwr2QTuJelCZd/I1zvletmm58epLcDJb7k1whd0/?=
 =?iso-8859-1?Q?0M+JYItCAMexVuumRmQwMXW2ud5feOySfa9MxA1OJC+TCnAoKcfBGq+mm1?=
 =?iso-8859-1?Q?G4hUOcAc7FpG7dqaoinI7+VtzfUsrH8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5ec49c-1b66-4969-c8c6-08da4f360b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 01:17:55.9061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYLRgitQ0/NlnjoO2Fi0Z/a/dLrWe1TbSPq/IYAgO944CP9snPb8R48QlNSr0mu6Nhp3rbSMOsgk0Q/BLGCODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3456
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_08:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=988 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160003
X-Proofpoint-GUID: M-hjFE88NyI-UD6oC0F91KCQnpcybmwj
X-Proofpoint-ORIG-GUID: M-hjFE88NyI-UD6oC0F91KCQnpcybmwj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test cases to ensure preallocaion works.

Add more tests for spanning writes which alter tress with many levels
and covers more corner cases.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 277 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 8277464e182c..9fc0618f4ae7 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -35537,6 +35537,275 @@ static noinline void check_root_expand(struct map=
le_tree *mt)
 	mas_unlock(&mas);
 }
=20
+static noinline void check_prealloc(struct maple_tree *mt)
+{
+	unsigned long i, max =3D 100;
+	unsigned long allocated;
+	unsigned char height;
+	struct maple_node *mn;
+	void *ptr=3D check_prealloc;
+	MA_STATE(mas, mt, 10, 20);
+
+	mt_set_non_kernel(1000);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mn =3D mas_pop_node(&mas);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
+	ma_free_rcu(mn);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mn =3D mas_pop_node(&mas);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+	ma_free_rcu(mn);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mn =3D mas_pop_node(&mas);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
+	mas_push_node(&mas, mn);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
+	mt_set_non_kernel(1);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) =3D=3D =
0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+	mas_destroy(&mas);
+
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
+	mt_set_non_kernel(1);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) =3D=3D =
0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+}
+
+static noinline void check_spanning_write(struct maple_tree *mt)
+{
+	unsigned long i, max =3D 5000;
+	MA_STATE(mas, mt, 1200, 2380);
+
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 1205);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store that requires a right cousin rebalance */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 0, 12900); /* Spans more than 2 levels */
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 1205);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test non-alloc tree spanning store */
+	mt_init_flags(mt, 0);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 0, 300);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 15);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store that requires a right sibling rebalance */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 0, 12865);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 15);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store that requires a left sibling rebalance */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 90, 13665);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 95);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store that requires a left cousin rebalance */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 46805, 49995);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 46815);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/*
+	 * Test spanning store that requires a left cousin rebalance all the way
+	 * to root
+	 */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 32395, 49995);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 46815);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/*
+	 * Test spanning store that requires a right cousin rebalance all the
+	 * way to root
+	 */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+	mas_set_range(&mas, 38875, 43190);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 38900);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store ending at full node (depth 2)*/
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+	mtree_lock(mt);
+	mas_set(&mas, 47606);
+	mas_store_gfp(&mas, check_spanning_write, GFP_KERNEL);
+	mas_set(&mas, 47607);
+	mas_store_gfp(&mas, check_spanning_write, GFP_KERNEL);
+	mas_set(&mas, 47608);
+	mas_store_gfp(&mas, check_spanning_write, GFP_KERNEL);
+	mas_set(&mas, 47609);
+	mas_store_gfp(&mas, check_spanning_write, GFP_KERNEL);
+	/* Ensure the parent node is full */
+	mas_ascend(&mas);
+	MT_BUG_ON(mt, (mas_data_end(&mas)) !=3D mt_slot_count(mas.node) - 1);
+	mas_set_range(&mas, 11516,48940);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning write with many many levels of no siblings */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+	mas_set_range(&mas, 43200, 49999);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 43200);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+}
+
 static noinline void check_null_expand(struct maple_tree *mt)
 {
 	unsigned long i, max =3D 100;
@@ -37678,6 +37947,14 @@ static int maple_tree_seed(void)
 	check_new_node(&tree);
 	mtree_destroy(&tree);
=20
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_prealloc(&tree);
+	mtree_destroy(&tree);
+
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_spanning_write(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_null_expand(&tree);
 	mtree_destroy(&tree);
--=20
2.35.1
