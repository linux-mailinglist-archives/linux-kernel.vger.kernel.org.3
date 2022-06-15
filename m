Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C8F54CB20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiFOOUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347340AbiFOOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:19:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E84A3EE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:19:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FE3BvQ000856;
        Wed, 15 Jun 2022 14:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Lpeynluy62OchTcRR8nKZ47lIvc8NwMiD57bg/MEgmw=;
 b=vnMNxIfu5ikN9V6qoSeJ1TkSPDBuDoDkWIrccXijmhuDngEsavPvrUPUjRxLz7fS+9og
 mCy4vmCQfk0bG0hUb4qgKImbS3T8KO6O19XCEOKkHS2yiwY3E9ZscsmzFFgxL5s5Ci55
 USpHIshjM/zAsGDLTK5Jii2uiZHTzeEemq1ZCJkIVBqcDoKJTeMC5twUkoMe/q0J8MZg
 5OKxfPBSb1gT0yStgWIFe+6ukjrpM9+hmBSoq8OcIx1LJaPMoejGp1sDQVscCUd8DmAq
 hdvHwBuuAiVuQK7iXcl7EUC0ILnmnpQ6hTq47TM6uliuHG0UYTJXk7BCMUSnD3zeUUk6 Yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9gjhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:19:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FDtwuT008028;
        Wed, 15 Jun 2022 14:19:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr25uq1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:19:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3oplxIuEHCcXthCcvtbnvkkYNkzzqggSU9SD83SgenMVaKFQyn5nd+EfdN9uciNrKENm9FqGXtur2JR3VisKjXXrnyCjdwT9zrO6T6fEaS0kDnHvEH4bFPEepacLA2i2qSO1QWBfTD3yCWPmfW4cl/1AzOcSy4FaX6yhiPnPOjCzkTUTcOcwG9KGCANlTtj7VgLsf6kijaivDtOm6CRL9JKUizIgd1/CmvDaAuJ4gFGMHF+1JZL+plC+9R3fIqBX2AMXuuQYG/zLxCN0I1Yqfyf584Ou8ZIaElINk82fepOlPMZsvZCAFnvsf2QINZoJsZzJl39SDlFkpmzn7MpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lpeynluy62OchTcRR8nKZ47lIvc8NwMiD57bg/MEgmw=;
 b=V3lzZe9NsYc2BgLB+Y60b91aCzRK9RPRbSqNBca4JRxEMoyFoLx4HJvD7tgqAi8AO5QKotlZ8ct5IHdukaSKvko5vBA4wbnlyY1op4t4cKDiMk/qV3Dx0MbcKrbjdfKNEAfwVT/xI3Xh1uHoarvlSTYoiJC3JpZx3ZRfvsswukZMdCwVXAOSAcfIVFGwNUOgsQU9yx7p/CueIJg1EMqQmqvTHux4mFTMpBCdNDpg43UUWvGEWrq2n/aa1yD1KpQvYenjtK+xG3maXxo60RVvKpFWaIYv4QZ1/S6dPAncovrwQvOSQdKuhz2jvtZbzRi9C9Iui62XmzoMWnd72fwM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lpeynluy62OchTcRR8nKZ47lIvc8NwMiD57bg/MEgmw=;
 b=wDW5G0Ublj/Emy+kDXiSrdiAdF8gU3F5nQt/mOpWgONVzEZQRkl2FBiEIvGBHgycfzI3ibzi1uf5siyuEmpxGPK7cf41baybbf3224bntfXtju5UG9HwDJeGuMBnkZmpyt0rPMql7WLXQhF2ZlZMgx/PeOAC3Y0m5nWpLA1kDZ0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3342.namprd10.prod.outlook.com (2603:10b6:208:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 14:19:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 14:19:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH Fix 2/3] maple_tree: Change spanning store to work on larger
 trees
Thread-Topic: [PATCH Fix 2/3] maple_tree: Change spanning store to work on
 larger trees
Thread-Index: AQHYgMLyLu7LYBVCJECcWBJ+FZIYSQ==
Date:   Wed, 15 Jun 2022 14:19:39 +0000
Message-ID: <20220615141921.417598-3-Liam.Howlett@oracle.com>
References: <20220615141921.417598-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220615141921.417598-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ca0a7aa-f9c7-44cb-cf07-08da4eda156a
x-ms-traffictypediagnostic: MN2PR10MB3342:EE_
x-microsoft-antispam-prvs: <MN2PR10MB334273F17DFD177E975F35BBFDAD9@MN2PR10MB3342.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lyDtuSjJcML8Z4a39O61l4wKa9n7YFwpo3hZ5u8IOHqd/jy/3qVNFR11LSmkYHkEZuHb5XUHOihZKiq3bqDSyR6/HsYdGATflmNQF55nWMheILsSTjLlWZdqpNRtdHozLjq2JjqaHmwvFvXGvhT/KpbrtCGdLl0KFDPdIXQgwdb3l79muVr5D0P7lY8/NsfYOudWER9IBFtwVx+YBiPT2QkJssw1vt2ppqxFZy6ZsIT8aDihr9RSNtv/s1EFzB16t1/kZeHiM0qlNTJD1lKgxKeTer1gDlgNWHyR9XwT1rqrMYWc6/kN4C5yhlBhhwnb4rHlHmJNHk+HJYlunN6MRzjxNwSoAhUgOnamEs1ezGtrIlJstpjgYnm0SHHdK77P0QpUto9qetoJNOFlE/4E0XTXUtFCVru5tOZRn71MJDEuGw+hK79PBzW0tngxPjEd1Jl7aVDR1MOtN0gFifguab1hKdfUBQGkWsdtLVCDd4RYRmXTqQCn27+6MZY6EpopuQasfwN3GL21YDp3q1j/lIPHZ6FkuOqsrfWbJa3wlWsAa0oHTtJmOJnkBqASshDq+ZRm/hdPckORDNyx+qLnU24jkLDoklMr3XLhBUqCVmFlLQcP2uDLkMWdAEbO0kW6I+tMuPEXD3Iqbk3wFmm/iOIDNLIeh+MkkuUiGN7EDnIWMYOqalxJsbFtJIrV3s1SO+LXqAo/xlui65ZeLA3RvSpIxeAWv0CUt2M9xWC75mU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(30864003)(86362001)(316002)(122000001)(110136005)(38100700002)(186003)(5660300002)(4326008)(8936002)(2906002)(71200400001)(38070700005)(66556008)(64756008)(66476007)(8676002)(66446008)(6506007)(76116006)(91956017)(26005)(6512007)(508600001)(83380400001)(6486002)(1076003)(36756003)(44832011)(2616005)(66946007)(239114007)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2mmM10LCmX7kaWDEGQGkBeSc4Hu0xJSgFXg7ALVI/OYlNK4ZASo3UqfThO?=
 =?iso-8859-1?Q?H0KblJ+1k0vacCZoapl72WUjMLYHuXaP/B8nP2eBRbY+1yPG/Kd8doV1P/?=
 =?iso-8859-1?Q?j9ap+c090BdFk/Q+edMF1S+tzV2/39EaGvDnsM9tKItjTH8jA0r4hg1BDh?=
 =?iso-8859-1?Q?v42Wwp8Fu5vDbPlzZVQK4Qg69K/BwN/iNwPNU+hssCA27lnj7Wg/+UQy1X?=
 =?iso-8859-1?Q?Jsbz57iux27IenI4AvDuMn3R5hDRrMdVoZ7De4Gf+z7FnC+66qXjJsiLyA?=
 =?iso-8859-1?Q?uOfG0NpYyqVmB1h3GfeheF+cRGwndcoIN6HMmI4WTEORRDNkQSG42rs47V?=
 =?iso-8859-1?Q?zL6GPOCS+MVx3xS68zQQV+QLzkj3rGj8wVxym7Byt371Sw7Sh9pg3jnZj+?=
 =?iso-8859-1?Q?XrJaSoTr2xpUfYX+hC1Frz4qMtohmmxbU5HSlpUKHNt86qrkeJGiGOqKt6?=
 =?iso-8859-1?Q?NLZqslU7YNBq7NeejXj3WiIK1B8dThWQPoOUdQcQycY2WDIpXgRRB/ZWx0?=
 =?iso-8859-1?Q?oEveZQ0C3thhxIzncFfoc6PbmTEXHpL0pW7vxDlIjpN+3GKre9sVqZuffr?=
 =?iso-8859-1?Q?7U7x+hBI/Hkvrrw/760IqU5BOxQ0ETq1I9Zq+gpb4ehFiF1vwWWhQ9yJNY?=
 =?iso-8859-1?Q?G06uv7NBuEys4QMn3qTQreFnA6J1pargpX5CuGPWQKb3HMzURXp/blMERb?=
 =?iso-8859-1?Q?0tDeh+28ZqmHmt8HIGnxnJ+pzQymwY/HPd3KY9ogrjo/0NanMQKDmYWQaT?=
 =?iso-8859-1?Q?DWRTv+pgkXMVBUv8ENxUbjOJIf0FfaaqhRlnEitxOV1K6CBrWnQkm8C8HW?=
 =?iso-8859-1?Q?ouzwfS0WVo7OOhh2aXgobYl+Qb4V/CRlKpL7HsTPEbQoelMU+XLLzYQfsr?=
 =?iso-8859-1?Q?DZ5qe4wpsmAb3eGmpkH7+wwmzxxH82OdGXfN6++mf+NIiZWTm5TRKWkcu2?=
 =?iso-8859-1?Q?q5igT2DqkTt0rXgiNutgDqL9gcxdqM487qX17jrwUq30lDY0OwFAFhvoJn?=
 =?iso-8859-1?Q?QXNvTh/R7J/ScmEKyQSlD+/rgf+f3HC8lmBPjYzVzXF7yKdFjkJ6+UfTdR?=
 =?iso-8859-1?Q?kom4/pe0tTCReEAokdzlANwDipFD4IshBojLgnQ5JShnEBQtw5KB2YmbBp?=
 =?iso-8859-1?Q?2UwMAhnNCC3gwgTwrXsUrH/SeDzzDRk1hsLr8sZ1Nuf2XUTJiLVVLgcZEH?=
 =?iso-8859-1?Q?FdmhhUwmfb8eejLOS7ig+XR03R1UWfYdQ4+Ell00AmViQuVOlqoI6UVufA?=
 =?iso-8859-1?Q?BtHCqeWHcAlRvMY8H6an1M/t+oOSBh8dlDuZxyD3XkR+NCWR+P5FNTwlC0?=
 =?iso-8859-1?Q?edgAeCus0vBBckZDbtjKptAnH+UhhWXiGmM9AR6vF5DLt1YfpLxnnmCaZo?=
 =?iso-8859-1?Q?+j6XfLcJ0DsLfmkLB4hXKzERJCV2aHDHg/XiZUxVHwxBvMs98isfJMVmoM?=
 =?iso-8859-1?Q?ptgkfcTq3w3dbNLujD38BxIp2Fx9Uj/L6/UzLta7Su/obkTvR9PQrm59Ld?=
 =?iso-8859-1?Q?Ai+cLRTxEAWcbaQwQzcDAEGERwx5HJ3inG6AtXZKd4VMCKNVXYLYvEhTwR?=
 =?iso-8859-1?Q?ALOZf54XEgGdYrdsMdYJYrjZa+UIPKi/TEZniTdXH9ICwBDn78myLJoDiG?=
 =?iso-8859-1?Q?CX7DVOzp5FskZU0SVnqdJtLEuRVXlhn8W4IfiIIq3cTGQoSyv1iF1ndybE?=
 =?iso-8859-1?Q?LKWJDAeKso0qMHTzR5/8EYJEUw3kfy2FIEqTIzV6Nu0lpKgYew4E0WeYPI?=
 =?iso-8859-1?Q?E+hAJTZtbwQivSHRh+oF6AhZRUvVD797lGccG/4ENj89J9v1+Q76vTSHZ2?=
 =?iso-8859-1?Q?JdmIObtIumfRFvNUnR0Ttuo+N5hUERM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca0a7aa-f9c7-44cb-cf07-08da4eda156a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 14:19:39.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oV/sFbOQAb9mgUAH9JcLfftQe7earuxHlRVQgLLetjOtIr9se9RVKdrm84WAfFpX9gm7aNcbTZFwbTFZjPFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3342
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_04:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150056
X-Proofpoint-ORIG-GUID: gY37B8czSuKhRK3YqwfeHbpYHznM4pCo
X-Proofpoint-GUID: gY37B8czSuKhRK3YqwfeHbpYHznM4pCo
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
 lib/maple_tree.c | 325 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 206 insertions(+), 119 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a1035963ae0d..f413b6f0da2b 100644
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
=20
+	if ((l_start < l_end) &&
+	    mte_dead_node(mas_slot_locked(mast->orig_l, l_slots, l_start))) {
+		l_start++;
+	}
+
+	if (mte_dead_node(mas_slot_locked(mast->orig_r, r_slots, r_end))) {
+		if (r_end)
+			r_end--;
+	}
+
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
@@ -2948,6 +3017,15 @@ static int mas_spanning_rebalance(struct ma_state *m=
as,
=20
 		/* Copy anything necessary out of the right node. */
 		mast_combine_cp_right(mast);
+		if (mte_dead_node(mast->orig_l->node) ||
+		    mte_dead_node(mast->orig_r->node)) {
+			printk("FUCKED.  l %p is %s and r %p is %s\n",
+			       mas_mn(mast->orig_l),
+			       mte_dead_node(mast->orig_l->node) ? "dead" : "alive",
+			       mas_mn(mast->orig_r),
+			       mte_dead_node(mast->orig_r->node) ? "dead" : "alive");
+			printk("Writing %lu-%lu\n", mas->index, mas->last);
+		}
 		mast_topiary(mast);
 		mast->orig_l->last =3D mast->orig_l->max;
=20
@@ -2961,15 +3039,14 @@ static int mas_spanning_rebalance(struct ma_state *=
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
@@ -3042,6 +3119,7 @@ static inline int mas_rebalance(struct ma_state *mas,
 	mast.orig_l =3D &l_mas;
 	mast.orig_r =3D &r_mas;
 	mast.bn =3D b_node;
+	mast.bn->type =3D mte_node_type(mas->node);
=20
 	l_mas =3D r_mas =3D *mas;
=20
@@ -3855,7 +3933,7 @@ static inline int mas_new_root(struct ma_state *mas, =
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
@@ -3941,6 +4019,13 @@ static inline int mas_wr_spanning_store(struct ma_wr=
_state *wr_mas)
 	mast.bn =3D &b_node;
 	mast.orig_l =3D &l_mas;
 	mast.orig_r =3D &r_mas;
+		if (mte_dead_node(mast.orig_l->node) ||
+		    mte_dead_node(mast.orig_r->node)) {
+			printk("FUCKED.  l is %s and r is %s\n",
+		       mte_dead_node(mast.orig_l->node) ? "dead" : "alive",
+		       mte_dead_node(mast.orig_r->node) ? "dead" : "alive");
+			printk("Writing %lu-%lu\n", mas->index, mas->last);
+		}
 	/* Combine l_mas and r_mas and split them up evenly again. */
 	return mas_spanning_rebalance(mas, &mast, height + 1);
 }
@@ -5387,6 +5472,9 @@ static inline void __rcu **mas_destroy_descend(struct=
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
@@ -5394,6 +5482,7 @@ static inline void __rcu **mas_destroy_descend(struct=
 ma_state *mas,
 		offset =3D 0;
 		prev =3D mas->node;
 	} while (!mte_is_leaf(next));
+
 	return slots;
 }
=20
@@ -5427,17 +5516,15 @@ static void mt_destroy_walk(struct maple_enode *eno=
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
