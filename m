Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BF354D6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346611AbiFPBS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350156AbiFPBSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:18:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3651EAD4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:18:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FLpV62029748;
        Thu, 16 Jun 2022 01:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qCoqAd0xRUtkgvsdwZpRdfZP3PnguNS3NPvBRCHvxl4=;
 b=EOe1C5P8fPO25PscGBvxzsPTSP5ZjRhtdq+1IolOPPrwbqp4KCj5nsztfIk0Xk0vGNzG
 Tfh1QbRZHFoKsb+DSEzjHJSrS8npzvjl4YtHfTmaLz6QOuBzFIRgeHcYwayBvZAHEXI+
 v3htFZ19CYWalnI6S5Z8kEMhtriFy1u+6ftLrcZ1lNshPMyPQ6hKMRHikX2ouhHvOsj3
 /J40CxL5yaZYYx+qb/IOBOp3xK66zlvmteEwkVZEPrDHMWMR5HUr547GV8eGRYfFLDAD
 rj+GPr9afLI7TaQ4Sl+Y3yJ3N20JGU949/HPYvIbLqq7/NMozhgSkaR7KtHciEnItUtL LA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9hr0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:17:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25G1AY2p025240;
        Thu, 16 Jun 2022 01:17:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gprbsbqhj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMSczQNKh0d9G5UIEk0mPTp6pleC9ZhTG4OJeWru6bXMjTsM2y78P5R0Ed9yk8irx5JeNWZERL4bWGBsBG+QlCMY7d2OTHVetZM+UOlrtSRoFpyYAxMpc/4HLBpvFDbMniEmZPlCkQzWPGcZYO8/2/BmZ4cQOrhwgiMIS6D+wdZ9ijpd6Rmc9P+wxjL4y9DTupfhy7f0KDY4rBXTXD9AP7DerGJ6Bwc4TPn0XkZQ/IdspCPAp1pf4Y60NEbjRq3If4MXVb6U+w86RqyP/H58yvYUWxBExaE+DoIyaDYOfD4awPb0g/egUEHhDdLQ0z4Zv0my2DXUpZ9U45Ti0vWhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCoqAd0xRUtkgvsdwZpRdfZP3PnguNS3NPvBRCHvxl4=;
 b=T4NMF1kXUbrBJl3FaYgKMGwMyiTGsROawTC1okxlEt5sWBh+TZyfyjrlFmmB4pX4DinXAPQrWCaCMT7wDZA4sc5xMxtaAMWD0ZVu2rG7FdMVp2kj7Wfp1TrzQ4yKCgPRi1AJ3YxEXqgrdHVOuFq6VobLGEq+AZc45cBT7eaN3R8zI8YUzMFSQXfF67EtrcvdM+zv1wQX/YQbHvfv6gg24VOuBCMmvuC4q1o43LWjPEr+UDg4WL6UboXZ8tWyYKk7M6nUMUj2LRJPIbJuZLWDXq2PE6KMIEwGp+McPflKc8y+gNOWoMctV0U9TsssYiVM2uHjJauVQtZtsTDF8i1SKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCoqAd0xRUtkgvsdwZpRdfZP3PnguNS3NPvBRCHvxl4=;
 b=IIMWmo3q45g5Rh6qNSaTbkiVJwmFVj1MMbuZWhy2RrrjaAiPxXB4aZf7ZsVliLoBDYJZfgZfLdHtWidcg4ODXCBOUpkoKi/kM+Sc56KnzLo4lN4ZOT99p/jcreaxh3IAgAmmSjy4tPyABob8tGXR1eY+u2S74VViY3Kw0p6WRxo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3456.namprd10.prod.outlook.com (2603:10b6:805:d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 01:17:55 +0000
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
Subject: [PATCH v2 Fix 2/3] maple_tree: Change spanning store to work on
 larger trees
Thread-Topic: [PATCH v2 Fix 2/3] maple_tree: Change spanning store to work on
 larger trees
Thread-Index: AQHYgR7oSXwS6qQ3XEyxNkDHS/25dg==
Date:   Thu, 16 Jun 2022 01:17:55 +0000
Message-ID: <20220616011739.802669-3-Liam.Howlett@oracle.com>
References: <20220616011739.802669-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220616011739.802669-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89aa1da0-7efe-480c-1a86-08da4f360ae7
x-ms-traffictypediagnostic: SN6PR10MB3456:EE_
x-microsoft-antispam-prvs: <SN6PR10MB34569960C7D214C0852D9D57FDAC9@SN6PR10MB3456.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tAxg+d1l7DxFqWCd3fHsgu4LEK9x5FK2PeKr9pKa9Lj1AKeF+6coXjnOLxO00FZpRB7SEKgAjjRXrB2DC5iUcuDAdfsis3iSaha8JW4/iCl3lDC/kX2UpHVJqU2OIcOSIPFOff+JrGtA1eG1bTGnakCjQzWiJw9akFJpHhkYyNfttxI2Yx0OcGuMnW3U8hOiqrYsg50uVrN/5seWReHuIvm9qtLpDZSnySNP8cjf5X/KDoR9qlcR+29LGr/t2nGB3KoI7LZk1HI+KbKzUdI1Qj/Dnu7gSuuxPovjVyOEqMs1lnRh8WHYVRGZXR0mMx0kq2WZLG11t7kwuzbj5xMZ2HswszLK8++T67dQ5/DBq6FtW0Up6xmTIYXnMujs1Vl9TYHdIZbtz4vD79CA+YSRMNJ2d0FQ9SQkAVaGFv0/J10ouYivbZH0j8UKw3yJgWlsAQSozGycdxxmfuTRzm0v7vnMBE70uuXtKrAwshGygl07jK8ERlY24mR9oIkXJf8hP0ThLm/cXmgdcwHyPCTUkJVugWXwp1AW6qVT79P9ExZWIoJx/5DQq6HbIjUVCs6Mw1HtqMbFmvFyFppM6f4sj1kdwbzHZ9w692BtMr8TG1z4KDMlBDoZgtgnZDcJJOvH+mgymsjzxRVu8ZGId1t32tbvcojoFZ6vmaeb4ihSFjtF+J8OWI8an75SWRSNpsAkc5Ye8O6PXKy5HDp0TEO/sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(186003)(66556008)(6506007)(1076003)(6512007)(2616005)(38100700002)(122000001)(86362001)(38070700005)(83380400001)(76116006)(91956017)(316002)(4326008)(8936002)(508600001)(6486002)(44832011)(36756003)(30864003)(64756008)(5660300002)(2906002)(66946007)(110136005)(8676002)(71200400001)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2XB+ADGmeWvP3IYouK/QWm2Dqy1blBR3OVDMKflZuQcpWmKMMvVXlSEfIc?=
 =?iso-8859-1?Q?dPKBbS64u3vzRHKgkJtSjrXOI3viLaznnKPFnBloZXMg8J1I+QRSnpgChz?=
 =?iso-8859-1?Q?Hp4WAFjSp0wDfwE8X/pRzNR0IOk9sTbRC/EIqFkiUYxqYSTVcx6dj9y7An?=
 =?iso-8859-1?Q?fXoMOXfKZJtoYJlrzWwjOBDb0KRNuZZ89tdoIUYWPEANjwqtw863UJpbyf?=
 =?iso-8859-1?Q?C51jUnOFO34rUF5nueL/fqGH+cgcMJ2Eg42KuYOH7D2rCB1OExXGWOjSRb?=
 =?iso-8859-1?Q?xmf/btDUEBSe1+iAXzY6KN+6qQ5jlQHc5bsKpfDkjMzSFqsKqqS8gD7qzt?=
 =?iso-8859-1?Q?HheaRV0VDj9D10X66kxJEbgU6VRTAP6FOSy8u2PSv/KCfM8LzsB7nWJ64r?=
 =?iso-8859-1?Q?2dX48eBC82tbHey31DnJU0KMyzKDlRP/uMzyxoEtQKLir+19hoRk7PjCjW?=
 =?iso-8859-1?Q?N/kU9wrKqJXTXuMuScFqzB8uCiCXXy1mk6wrfyY84b3myDKDf6awiUAxyn?=
 =?iso-8859-1?Q?M3277NU2bjlwoUaebhHcaMtJPYqlzjkbjAG3mMvXBbkE1rwspWvAJmXtWH?=
 =?iso-8859-1?Q?FI4yx8yUKe2B53MAQcCYwWg2V8qXf1i6GsZ/s/cbPtJR4RwjHVYnOSNkDk?=
 =?iso-8859-1?Q?FzdE3Wg8MLqZy+Ky19zoY+KXN0iJiZGPdKoSL44591O3E1HlIfZAbFLUve?=
 =?iso-8859-1?Q?MkLrafeejJ4/PrGXcrrsmlRT3aI9yCT6nUPM9fplyxECaoypWXKwLJGHAB?=
 =?iso-8859-1?Q?zqDx42mFIjilvDpQOfYnDVEDFR/7R+y0UwqPtmMAtoI96vR9DoQidEtVrV?=
 =?iso-8859-1?Q?IjfQnul4PnqLjIO0JrH4Gxgd3zz4JVKC0iLYCV+0Q8RZVCbIVkiWnI7fKp?=
 =?iso-8859-1?Q?TfHgX+yUtODFyd+FMnaBewzoE9p2m8ajp8Wn/k9kPL3nTzwhznrGfWxNi0?=
 =?iso-8859-1?Q?ofs9hM0tQjNMGtYop6Vgv4h5cUkypEKnAY8YUAwg7en0Iw+ohSTjEnNwzl?=
 =?iso-8859-1?Q?TWKEl7VSZnak0yUsUXT9NA8hY4rd00fDCf/f6nfR715I7FaPP3hcf7NHg+?=
 =?iso-8859-1?Q?91Pe3PxBMWzmSNQuP62mzFZqcj3NwKkDQKyYeD+g1xjyVq29yDPMyICpTl?=
 =?iso-8859-1?Q?hzBIkRPRnP+ZvDQsZCw771zBiAAhRO/JRIozbah7T8ThhFIQsoSG/NkO+X?=
 =?iso-8859-1?Q?jfeDT52ENBuUwsvUo0r+Cyg7M+3GxeK4dVqHbBg+uOAEyepZLt9xYp73MS?=
 =?iso-8859-1?Q?Yo4vrzOcjsIcGJQ3oIVo3kLEIJ5JH6mLIk0QszF7RqqYvPxfzzmLtPPt8L?=
 =?iso-8859-1?Q?AvO0AO+NvmNEwdx4AbuTJHxH0jLle8uL2BnKn0eLIXeZCzqQibN/XHBELn?=
 =?iso-8859-1?Q?38j4B/QwUuxsSut3QUuIADbWpGXYbJjsDanCd8nWkCGOXnNeQM5QRWZR+7?=
 =?iso-8859-1?Q?sZYMFzN4EQdXqj0saZf9VnkPF13AJDoyWgVmMK95eGWQY1Wxlx1xn70aZW?=
 =?iso-8859-1?Q?9t9B5/6s5wG4uERe6TqZ7HPl7CjpEeHLjESu9xe5hhjBcBeqUQn6llJc7A?=
 =?iso-8859-1?Q?fPRgF/niyfCPJvCobftXY87dYTzPAKzf3YjMbfQWkI2kM8JB/j7opYsaUx?=
 =?iso-8859-1?Q?AQNNBXvM5SL+VjWNKB1EZdfg8GwDOZuF9cORNAKTI+mfdoMHrputYQRdhB?=
 =?iso-8859-1?Q?U7aeFiyKCdKnynRfXlDi/ypyWLWFjj2WKQDKJQO0fHHtWqpZkyaYcRrJu1?=
 =?iso-8859-1?Q?yiCtG4/d2E6Mx/24CY0LTMOEoSdRPpBMXxEc1APO08nxukDogyVvMI13jM?=
 =?iso-8859-1?Q?ddsn+AU1xjzZgbCI5CTh37oNeahQHSE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89aa1da0-7efe-480c-1a86-08da4f360ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 01:17:55.5936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/jASo+EtUbCN3RI55bMEBoTM9ACcbDCSWjIL9MBDU57Vpy/SkxS4tIAspfIKfJ/wiHYyhkS58KW1yo1+kJh4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3456
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_08:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160003
X-Proofpoint-ORIG-GUID: F5WYu6-QOJIss5LJnAxC74WhCiVmkRhG
X-Proofpoint-GUID: F5WYu6-QOJIss5LJnAxC74WhCiVmkRhG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spanning store had an issue which could lead to double free during a
large tree modification.  Fix this by being more careful about how nodes
are added to the to-be-freed and to-be-destroyed list on this operation.

Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 309 +++++++++++++++++++++++++++++------------------
 1 file changed, 190 insertions(+), 119 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a1035963ae0d..aba5763bc7a1 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1388,7 +1388,6 @@ static inline unsigned char ma_data_end(struct maple_=
node *node,
 /*
  * mas_data_end() - Find the end of the data (slot).
  * @mas: the maple state
- * @type: the type of maple node
  *
  * This method is optimized to check the metadata of a node if the node ty=
pe
  * supports data end metadata.
@@ -2272,6 +2271,31 @@ static inline void mas_wr_node_walk(struct ma_wr_sta=
te *wr_mas)
 	wr_mas->offset_end =3D mas->offset =3D offset;
 }
=20
+/*
+ * mas_topiary_range() - Add a range of slots to the topiary.
+ * @mas: The maple state
+ * @destroy: The topiary to add the slots (usually destroy)
+ * @start: The starting slot inclusively
+ * @end: The end slot inclusively
+ */
+static inline void mas_topiary_range(struct ma_state *mas,
+	struct ma_topiary *destroy, unsigned char start, unsigned char end)
+{
+	void __rcu **slots;
+	unsigned offset;
+
+	MT_BUG_ON(mas->tree, mte_is_leaf(mas->node));
+	slots =3D ma_slots(mas_mn(mas), mte_node_type(mas->node));
+	for (offset =3D start; offset <=3D end; offset++) {
+		struct maple_enode *enode =3D mas_slot_locked(mas, slots, offset);
+
+		if (mte_dead_node(enode))
+			continue;
+
+		mat_add(destroy, enode);
+	}
+}
+
 /*
  * mast_topiary() - Add the portions of the tree to the removal list; eith=
er to
  * be freed or discarded (destroy walk).
@@ -2280,48 +2304,62 @@ static inline void mas_wr_node_walk(struct ma_wr_st=
ate *wr_mas)
 static inline void mast_topiary(struct maple_subtree_state *mast)
 {
 	MA_WR_STATE(wr_mas, mast->orig_l, NULL);
-	unsigned char l_off, r_off, offset;
-	unsigned long l_index;
-	struct maple_enode *child;
-	void __rcu **slots;
+	unsigned char r_start, r_end;
+	unsigned char l_start, l_end;
+	void **l_slots, **r_slots;
=20
 	wr_mas.type =3D mte_node_type(mast->orig_l->node);
-	/* The left node is consumed, so add to the free list. */
-	l_index =3D mast->orig_l->index;
 	mast->orig_l->index =3D mast->orig_l->last;
 	mas_wr_node_walk(&wr_mas);
-	mast->orig_l->index =3D l_index;
-	l_off =3D mast->orig_l->offset;
-	r_off =3D mast->orig_r->offset;
-	if (mast->orig_l->node =3D=3D mast->orig_r->node) {
-		slots =3D ma_slots(mte_to_node(mast->orig_l->node), wr_mas.type);
-		for (offset =3D l_off + 1; offset < r_off; offset++)
-			mat_add(mast->destroy, mas_slot_locked(mast->orig_l,
-							slots, offset));
+	l_start =3D mast->orig_l->offset + 1;
+	l_end =3D mas_data_end(mast->orig_l);
+	r_start =3D 0;
+	r_end =3D mast->orig_r->offset;
+
+	if (r_end)
+		r_end--;
+
+	l_slots =3D ma_slots(mas_mn(mast->orig_l),
+			   mte_node_type(mast->orig_l->node));
+
+	r_slots =3D ma_slots(mas_mn(mast->orig_r),
+			   mte_node_type(mast->orig_r->node));
+
+	if ((l_start < l_end) &&
+	    mte_dead_node(mas_slot_locked(mast->orig_l, l_slots, l_start))) {
+		l_start++;
+	}
+
+	if (mte_dead_node(mas_slot_locked(mast->orig_r, r_slots, r_end))) {
+		if (r_end)
+			r_end--;
+	}
=20
+	if ((l_start > r_end) && (mast->orig_l->node =3D=3D mast->orig_r->node))
 		return;
+
+	/* At the node where left and right sides meet, add the parts between */
+	if (mast->orig_l->node =3D=3D mast->orig_r->node) {
+		return mas_topiary_range(mast->orig_l, mast->destroy,
+					     l_start, r_end);
 	}
=20
 	/* mast->orig_r is different and consumed. */
 	if (mte_is_leaf(mast->orig_r->node))
 		return;
=20
-	/* Now destroy l_off + 1 -> end and 0 -> r_off - 1 */
-	offset =3D l_off + 1;
-	slots =3D ma_slots(mte_to_node(mast->orig_l->node), wr_mas.type);
-	while (offset < mt_slots[wr_mas.type]) {
-		child =3D mas_slot_locked(mast->orig_l, slots, offset++);
-		if (!child)
-			break;
+	if (mte_dead_node(mas_slot_locked(mast->orig_l, l_slots, l_end)))
+		l_end--;
=20
-		mat_add(mast->destroy, child);
-	}
=20
-	slots =3D ma_slots(mte_to_node(mast->orig_r->node),
-			     mte_node_type(mast->orig_r->node));
-	for (offset =3D 0; offset < r_off; offset++)
-		mat_add(mast->destroy,
-				mas_slot_locked(mast->orig_l, slots, offset));
+	if (l_start <=3D l_end)
+		mas_topiary_range(mast->orig_l, mast->destroy, l_start, l_end);
+
+	if (mte_dead_node(mas_slot_locked(mast->orig_r, r_slots, r_start)))
+		r_start++;
+
+	if (r_start <=3D r_end)
+		mas_topiary_range(mast->orig_r, mast->destroy, 0, r_end);
 }
=20
 /*
@@ -2329,19 +2367,13 @@ static inline void mast_topiary(struct maple_subtre=
e_state *mast)
  * @mast: The maple subtree state
  * @old_r: The encoded maple node to the right (next node).
  */
-static inline void mast_rebalance_next(struct maple_subtree_state *mast,
-				       struct maple_enode *old_r, bool free)
+static inline void mast_rebalance_next(struct maple_subtree_state *mast)
 {
 	unsigned char b_end =3D mast->bn->b_end;
=20
 	mas_mab_cp(mast->orig_r, 0, mt_slot_count(mast->orig_r->node),
 		   mast->bn, b_end);
-	if (free)
-		mat_add(mast->free, old_r);
-
 	mast->orig_r->last =3D mast->orig_r->max;
-	if (old_r =3D=3D mast->orig_l->node)
-		mast->orig_l->node =3D mast->orig_r->node;
 }
=20
 /*
@@ -2349,17 +2381,13 @@ static inline void mast_rebalance_next(struct maple=
_subtree_state *mast,
  * @mast: The maple subtree state
  * @old_l: The encoded maple node to the left (previous node)
  */
-static inline void mast_rebalance_prev(struct maple_subtree_state *mast,
-				       struct maple_enode *old_l)
+static inline void mast_rebalance_prev(struct maple_subtree_state *mast)
 {
 	unsigned char end =3D mas_data_end(mast->orig_l) + 1;
 	unsigned char b_end =3D mast->bn->b_end;
=20
 	mab_shift_right(mast->bn, end);
 	mas_mab_cp(mast->orig_l, 0, end - 1, mast->bn, 0);
-	mat_add(mast->free, old_l);
-	if (mast->orig_r->node =3D=3D old_l)
-		mast->orig_r->node =3D mast->orig_l->node;
 	mast->l->min =3D mast->orig_l->min;
 	mast->orig_l->index =3D mast->orig_l->min;
 	mast->bn->b_end =3D end + b_end;
@@ -2367,68 +2395,116 @@ static inline void mast_rebalance_prev(struct mapl=
e_subtree_state *mast,
 }
=20
 /*
- * mast_sibling_rebalance_right() - Rebalance from nodes with the same par=
ents.
- * Check the right side, then the left.  Data is copied into the @mast->bn=
.
+ * mast_spanning_rebalance() - Rebalance nodes with nearest neighbour favo=
uring
+ * the node to the right.  Checking the nodes to the right then the left a=
t each
+ * level upwards until root is reached.  Free and destroy as needed.
+ * Data is copied into the @mast->bn.
  * @mast: The maple_subtree_state.
  */
 static inline
-bool mast_sibling_rebalance_right(struct maple_subtree_state *mast, bool f=
ree)
+bool mast_spanning_rebalance(struct maple_subtree_state *mast)
 {
-	struct maple_enode *old_r;
-	struct maple_enode *old_l;
+	struct ma_state r_tmp =3D *mast->orig_r;
+	struct ma_state l_tmp =3D *mast->orig_l;
+	struct maple_enode *ancestor =3D NULL;
+	unsigned char start, end;
+	unsigned char depth =3D 0;
=20
-	old_r =3D mast->orig_r->node;
-	if (mas_next_sibling(mast->orig_r)) {
-		mast_rebalance_next(mast, old_r, free);
-		return true;
-	}
+	r_tmp =3D *mast->orig_r;
+	l_tmp =3D *mast->orig_l;
+	do {
+		mas_ascend(mast->orig_r);
+		mas_ascend(mast->orig_l);
+		depth++;
+		if (!ancestor &&
+		    (mast->orig_r->node =3D=3D mast->orig_l->node)) {
+			ancestor =3D mast->orig_r->node;
+			end =3D mast->orig_r->offset - 1;
+			start =3D mast->orig_l->offset + 1;
+		}
=20
-	old_l =3D mast->orig_l->node;
-	if (mas_prev_sibling(mast->orig_l)) {
-		mast->bn->type =3D mte_node_type(mast->orig_l->node);
-		mast_rebalance_prev(mast, old_l);
-		return true;
-	}
+		if (mast->orig_r->offset < mas_data_end(mast->orig_r)) {
+			if (!ancestor) {
+				ancestor =3D mast->orig_r->node;
+				start =3D 0;
+			}
=20
-	return false;
-}
+			mast->orig_r->offset++;
+			do {
+				mas_descend(mast->orig_r);
+				mast->orig_r->offset =3D 0;
+				depth--;
+			} while (depth);
=20
-static inline int mas_prev_node(struct ma_state *mas, unsigned long min);
-static inline int mas_next_node(struct ma_state *mas, struct maple_node *n=
ode,
-				unsigned long max);
-/*
- * mast_cousin_rebalance_right() - Rebalance from nodes with different par=
ents.
- * Check the right side, then the left.  Data is copied into the @mast->bn=
.
- * @mast: The maple_subtree_state.
- */
-static inline
-bool mast_cousin_rebalance_right(struct maple_subtree_state *mast, bool fr=
ee)
-{
-	struct maple_enode *old_l =3D mast->orig_l->node;
-	struct maple_enode *old_r =3D mast->orig_r->node;
+			mast_rebalance_next(mast);
+			do {
+				unsigned char l_off =3D 0;
+				struct maple_enode *child =3D r_tmp.node;
=20
-	MA_STATE(tmp, mast->orig_r->tree, mast->orig_r->index, mast->orig_r->last=
);
+				mas_ascend(&r_tmp);
+				if (ancestor =3D=3D r_tmp.node)
+					l_off =3D start;
=20
-	tmp =3D *mast->orig_r;
-	mas_next_node(mast->orig_r, mas_mn(mast->orig_r), ULONG_MAX);
-	if (!mas_is_none(mast->orig_r)) {
-		mast_rebalance_next(mast, old_r, free);
-		return true;
-	}
+				if (r_tmp.offset)
+					r_tmp.offset--;
=20
-	*mast->orig_r =3D *mast->orig_l;
-	*mast->r =3D *mast->l;
-	mas_prev_node(mast->orig_l, 0);
-	if (mas_is_none(mast->orig_l)) {
-		/* Making a new root with the contents of mast->bn */
-		*mast->orig_l =3D *mast->orig_r;
-		*mast->orig_r =3D tmp;
-		return false;
-	}
+				if (l_off < r_tmp.offset)
+					mas_topiary_range(&r_tmp, mast->destroy,
+							  l_off, r_tmp.offset);
=20
-	mast->orig_l->offset =3D 0;
-	mast_rebalance_prev(mast, old_l);
-	return true;
+				if (l_tmp.node !=3D child)
+					mat_add(mast->free, child);
+
+			} while (r_tmp.node !=3D ancestor);
+
+			*mast->orig_l =3D l_tmp;
+			return true;
+
+		} else if (mast->orig_l->offset !=3D 0) {
+			if (!ancestor) {
+				ancestor =3D mast->orig_l->node;
+				end =3D mas_data_end(mast->orig_l);
+			}
+
+			mast->orig_l->offset--;
+			do {
+				mas_descend(mast->orig_l);
+				mast->orig_l->offset =3D
+					mas_data_end(mast->orig_l);
+				depth--;
+			} while (depth);
+
+			mast_rebalance_prev(mast);
+			do {
+				unsigned char r_off;
+				struct maple_enode *child =3D l_tmp.node;
+
+				mas_ascend(&l_tmp);
+				if (ancestor =3D=3D l_tmp.node)
+					r_off =3D end;
+				else
+					r_off =3D mas_data_end(&l_tmp);
+
+				if (l_tmp.offset < r_off)
+					l_tmp.offset++;
+
+				if (l_tmp.offset < r_off)
+					mas_topiary_range(&l_tmp, mast->destroy,
+							  l_tmp.offset, r_off);
+
+				if (r_tmp.node !=3D child)
+					mat_add(mast->free, child);
+
+			} while (l_tmp.node !=3D ancestor);
+
+			*mast->orig_r =3D r_tmp;
+			return true;
+		}
+	} while (!mte_is_root(mast->orig_r->node));
+
+	*mast->orig_r =3D r_tmp;
+	*mast->orig_l =3D l_tmp;
+	return false;
 }
=20
 /*
@@ -2462,18 +2538,16 @@ mast_ascend_free(struct maple_subtree_state *mast)
 	 * The node may not contain the value so set slot to ensure all
 	 * of the nodes contents are freed or destroyed.
 	 */
-	if (mast->orig_r->max < mast->orig_r->last)
-		mast->orig_r->offset =3D mas_data_end(mast->orig_r) + 1;
-	else {
-		wr_mas.type =3D mte_node_type(mast->orig_r->node);
-		mas_wr_node_walk(&wr_mas);
-	}
+	wr_mas.type =3D mte_node_type(mast->orig_r->node);
+	mas_wr_node_walk(&wr_mas);
 	/* Set up the left side of things */
 	mast->orig_l->offset =3D 0;
 	mast->orig_l->index =3D mast->l->min;
 	wr_mas.mas =3D mast->orig_l;
 	wr_mas.type =3D mte_node_type(mast->orig_l->node);
 	mas_wr_node_walk(&wr_mas);
+
+	mast->bn->type =3D wr_mas.type;
 }
=20
 /*
@@ -2881,7 +2955,7 @@ static int mas_spanning_rebalance(struct ma_state *ma=
s,
 	struct maple_enode *left =3D NULL, *middle =3D NULL, *right =3D NULL;
=20
 	MA_STATE(l_mas, mas->tree, mas->index, mas->index);
-	MA_STATE(r_mas, mas->tree, mas->index, mas->index);
+	MA_STATE(r_mas, mas->tree, mas->index, mas->last);
 	MA_STATE(m_mas, mas->tree, mas->index, mas->index);
 	MA_TOPIARY(free, mas->tree);
 	MA_TOPIARY(destroy, mas->tree);
@@ -2897,14 +2971,9 @@ static int mas_spanning_rebalance(struct ma_state *m=
as,
 	mast->destroy =3D &destroy;
 	l_mas.node =3D r_mas.node =3D m_mas.node =3D MAS_NONE;
 	if (!mas_is_root_limits(mast->orig_l) &&
-	    unlikely(mast->bn->b_end <=3D mt_min_slots[mast->bn->type])) {
-		/*
-		 * Do not free the current node as it may be freed in a bulk
-		 * free.
-		 */
-		if (!mast_sibling_rebalance_right(mast, false))
-			mast_cousin_rebalance_right(mast, false);
-	}
+	    unlikely(mast->bn->b_end <=3D mt_min_slots[mast->bn->type]))
+		mast_spanning_rebalance(mast);
+
 	mast->orig_l->depth =3D 0;
=20
 	/*
@@ -2961,15 +3030,14 @@ static int mas_spanning_rebalance(struct ma_state *=
mas,
 		if (mas_is_root_limits(mast->orig_l))
 			break;
=20
-		/* Try to get enough data for the next iteration. */
-		if (!mast_sibling_rebalance_right(mast, true))
-			if (!mast_cousin_rebalance_right(mast, true))
-				break;
+		if (!mast_spanning_rebalance(mast))
+			break;
=20
 		/* rebalancing from other nodes may require another loop. */
 		if (!count)
 			count++;
 	}
+
 	l_mas.node =3D mt_mk_node(ma_mnode_ptr(mas_pop_node(mas)),
 				mte_node_type(mast->orig_l->node));
 	mast->orig_l->depth++;
@@ -3042,6 +3110,7 @@ static inline int mas_rebalance(struct ma_state *mas,
 	mast.orig_l =3D &l_mas;
 	mast.orig_r =3D &r_mas;
 	mast.bn =3D b_node;
+	mast.bn->type =3D mte_node_type(mas->node);
=20
 	l_mas =3D r_mas =3D *mas;
=20
@@ -3855,7 +3924,7 @@ static inline int mas_new_root(struct ma_state *mas, =
void *entry)
 	return 1;
 }
 /*
- * mas_spanning_store() - Create a subtree with the store operation comple=
ted
+ * mas_wr_spanning_store() - Create a subtree with the store operation com=
pleted
  * and new nodes where necessary, then place the sub-tree in the actual tr=
ee.
  * Note that mas is expected to point to the node which caused the store t=
o
  * span.
@@ -5387,6 +5456,9 @@ static inline void __rcu **mas_destroy_descend(struct=
 ma_state *mas,
 		node =3D mas_mn(mas);
 		slots =3D ma_slots(node, mte_node_type(mas->node));
 		next =3D mas_slot_locked(mas, slots, 0);
+		if ((mte_dead_node(next)))
+			next =3D mas_slot_locked(mas, slots, 1);
+
 		mte_set_node_dead(mas->node);
 		node->type =3D mte_node_type(mas->node);
 		node->piv_parent =3D prev;
@@ -5394,6 +5466,7 @@ static inline void __rcu **mas_destroy_descend(struct=
 ma_state *mas,
 		offset =3D 0;
 		prev =3D mas->node;
 	} while (!mte_is_leaf(next));
+
 	return slots;
 }
=20
@@ -5427,17 +5500,15 @@ static void mt_destroy_walk(struct maple_enode *eno=
de, unsigned char ma_flags,
 		mas.node =3D node->piv_parent;
 		if (mas_mn(&mas) =3D=3D node)
 			goto start_slots_free;
+
 		type =3D mte_node_type(mas.node);
 		slots =3D ma_slots(mte_to_node(mas.node), type);
-		if ((offset < mt_slots[type])) {
-			struct maple_enode *next =3D slots[offset];
+		if ((offset < mt_slots[type]) && mte_node_type(slots[offset]) &&
+		    mte_to_node(slots[offset])) {
+			struct maple_enode *parent =3D mas.node;
=20
-			if (mte_node_type(next) && mte_to_node(next)) {
-				struct maple_enode *parent =3D mas.node;
-
-				mas.node =3D mas_slot_locked(&mas, slots, offset);
-				slots =3D mas_destroy_descend(&mas, parent, offset);
-			}
+			mas.node =3D mas_slot_locked(&mas, slots, offset);
+			slots =3D mas_destroy_descend(&mas, parent, offset);
 		}
 		node =3D mas_mn(&mas);
 	} while (start !=3D mas.node);
--=20
2.35.1
