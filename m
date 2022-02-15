Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C724B6F48
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiBOOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbiBOOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E64A1029DA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:07 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCMIxD024475;
        Tue, 15 Feb 2022 14:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dBdhm+YnXrWbs1iG91fTn7BBfl+A9Xpf++2rnZtOmZY=;
 b=oO7nOPWkZ5ikxXvIlKGZ8LyF3ZK/kRmzzKwOhGeqZZJ7BXb99+8WMtzqdC4uEW/d/C+a
 YzexX/yD1iLRsAWAS1h6hoxkV1mUSlbC9ClZn3jUVi9Afp0eTWpMM2Mbo/H14TZhY0NB
 BhiBIUSeKldd3CLw08zljipRiK60+laf5kHuDts8VEIRMHihfwKvk9Y6QWH1FsebGuSC
 KoU7IEQGxKwwtAnTeMI+0JZhAfku58Gv4ZXDn2x0e/j8UBtDg2MMXg9Q4M4TIax13bpp
 9XdDaC3o2LDj7wE0YOgB63YTvcDWN9Z/7R8aAQD37xPV0RUHY/23Bixpbo++E1dlS26B eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psaq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVcX085745;
        Tue, 15 Feb 2022 14:42:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 3e66bnpj23-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:42:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa4J64YRZSmixUdN/E4wR9enGio6lB7/hW9f0DTR/WwvHGBHYwelhJOceNYeFUZacziIgmp4TBt5Ret/apMQEV50L/PCuzUEddz22lmYvRnWZHP8Cb07atLn3hWUcH7HQQFDVJp1ATa0JUBqQ6s6CWlQsQSJUulTyFSNSE97z6yjhqOO+O9o8GmKYoB+84CdoSPQAj1WxE2CaSJ9YfsV4z/SapPZ5gibP7STsBG3nzkMhbjZsacRCSKgzhLgwqToWdK+l7+BPoWCHED4+R1SN9APjcKStig7I3PIXzxbld7WxMYq89szVnoynZKVwldFqQobTX+gQ9yvspPeqSzJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBdhm+YnXrWbs1iG91fTn7BBfl+A9Xpf++2rnZtOmZY=;
 b=a+dosfMD7DtFvgTuIMs4cmNeYktSDfEv+YCrbJ3XjYfKho6zq5E0YZ+x/GJ8J0PJ4aOJiMOUjE02xTlBERbGlXtWjY8uyQ7JcBVpG7KPu4k/7XdmM7PXcGTGwvLI+5EVMt8YsgohSBH6dmAR7XWsuekHvv0Y+opqhrLbCu2j/oz2t9P49KR9n6nks0p294aSYS78yQVlLquOrEUEJrPVHDbEyDhoKjklWyEEPAat73anzLEbdfFP7hACf5zItmYFdZPXor9RVCB2XjlvkFrCsKQoeSIBvFhik9a0iQ/JK4zwtGw6xmn/UL3cIphtsOCPyu/88VRSXR3atoLzjitJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBdhm+YnXrWbs1iG91fTn7BBfl+A9Xpf++2rnZtOmZY=;
 b=GaIElAJFfKGOamNA4INfEUM8npVasrvui63EZ+IVif3WDNOBYw1xzrTihGvxi+cVbyW4AbIBTuMJIozDllPjILuOJ+po6Ji/XjmWfzu3lngqzVQ28xI+cpCrIKfhGqPR451fHhncGDfEYkg6NAZwznwZ9zvW2FaAo78nhbOolMU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:42:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:42:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 02/71] xarray: Fix bitmap breakage
Thread-Topic: [PATCH v6 02/71] xarray: Fix bitmap breakage
Thread-Index: AQHYInpR3DGXDgQ6v0ayWYU7LqRAGg==
Date:   Tue, 15 Feb 2022 14:42:56 +0000
Message-ID: <20220215144241.3812052-2-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54a80e3f-bf07-43df-88d2-08d9f09174eb
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB219793CAF812851CA87CD57BFD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lr+Oq72vUqdfes5QBJOQf3K47hng1JScNNiIFUeLeFEqUrETVN4fYJ+30TnEYOJmPesSzKBi/bM90MBQz7t7kuOcl1ONVayNcWHmrbdjthFqdqdsuEIAl1JS+C9mQYY+Pofs1qGCT1asvz6BOJcrFtvoSh4v9XvXyIDEOtFUdyaUAfDJkxW6pAps0paTxaBjfFme/rtJsrXKRu9eOd5kl8lfjKnqsM3n7hSSMZqkvH0m9tIUm/s29uaxLkqQB4QagDf3VAq6zNQiSZPvl0Bnx4NqNzYxXlYrTds7d1ziQrwMutTz7fGCVbEYfpKuOXZ9MO77J9sMcjH51MBJEER7M/NQ8XSJoErSfJ6ydhOVL4VXloPEFfydB13/jbedZcWECOxAzLIGidKr9byOWxpwVJ4i6p6kBNxge0rL4hHXftLQo+IztYHrkrnR4J0GuqxMaQVjzboO7NS54pgusH0ZjRbLLZWaZ8jgyLbLGlXlhfIVd1pZrQEw5t/E32MCoJ09GiHTYfzKARM7c68QAQRAUJ6ZL9x/f1znDw0d/mf57rm0fCq+7e790YUiPMyZcykdSNwPZqqllmE6HUO/DNrACPo3+Xh5Yi7zI0w9G0UTsB1YnsOFowpabLK96kPTMgcdAUNM61bX30tEXfsHo9OKCzuZ0SZIE79LIr7aOFAuiqbcNmz60pj21J4rRO78+LVWAVgbEJbd/w4vUId2rLM+3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(4744005)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tLQUw0IgMic1oJ12EZs1PCYjB/POmKzRCLELSF5kUtWAmgfZPpRpy+in4g?=
 =?iso-8859-1?Q?cAFZh0wEEQkwWklVIqY7ntSCXYXkEr/NAeSKt8oPaEhh9WBDSUNd7Lm6LK?=
 =?iso-8859-1?Q?NWrZjotutzoiXD7RA6T4dLi96stGSrLlVhV19nk9LiyvBO47uR7OlSYLnG?=
 =?iso-8859-1?Q?MqHaNO37LP1w0ldCAKyIHXhKMvUMtPAHFDDeI7632f9DPuSeyIufobRnR0?=
 =?iso-8859-1?Q?fJu0/8uPgY4DsW6t6FxcqVB99txHzTLIIgQaz66hydajFxJ37/UbUdlutk?=
 =?iso-8859-1?Q?iSyQbPrwOCF6cGPp1HZ5dRy9HTjlG5igJXGLlksPeVi5OawxiwD+/i166p?=
 =?iso-8859-1?Q?ekOuAj8n2WXX7IHLsKXDMLtWeK8upBzCHzDs5fIFvgskAQcslYiWrZPZrz?=
 =?iso-8859-1?Q?4+9wM68rW6UZUnVUmqfr5i9fFbU4fPyfyEz3svqFR3nR1FWzrSvuWG4mOP?=
 =?iso-8859-1?Q?RS0SdRWyXfG8bBLL8q1X/vIA1TGlWc2EG6n3n/97oLxskS+ek08Z5u52Sg?=
 =?iso-8859-1?Q?oBnNqSkELC4F4A0MNfneAeGhwe+YvCzXOR00pUKrrSOaMFHBBXwWpaO+44?=
 =?iso-8859-1?Q?YjyltX45JFGNRcl486MJgHkDGf/wVmigFu3Sp1cIOC2QFqPLjn1L/YAlsy?=
 =?iso-8859-1?Q?qRl79S6/ut6r1rB2ec9kp5Kj73wS6ClMz0csmRqhqzXq1hTzDVHN2Kdy1h?=
 =?iso-8859-1?Q?MQsJLSoxTDYBeFOXIn6tlQqK3VI5lN7LS7kyEOIp3r/Ypv5/RVHPbX/Aqu?=
 =?iso-8859-1?Q?xufvwUc9fci6v/DhGnp/BO0AZnLPl/l/MTCJnRaGYhSeDackRULi5FFtH5?=
 =?iso-8859-1?Q?SNOR0lui0xEPkXAKvhUqmKKb6Ih6poa0OnR7fR/b4a3m+or7DvBLDirMFK?=
 =?iso-8859-1?Q?RJdN25RQUC0i1TSGwHFp0h80T0+hpCA7sa9JjnRZcttw2nu94xwIf+3bXX?=
 =?iso-8859-1?Q?njlxWSbFZwpZIGS26Hz+Dyv/8SiUnQd1QASr2ZMrRL2jS4JfSbgUc9aVw6?=
 =?iso-8859-1?Q?sUQFkc2zCtolcwemtK2Wj5r4b5zeEN9+tZVwXiKjkyewfD/Te2u1QkkWuC?=
 =?iso-8859-1?Q?LNsgmLfMZug0ne2azROXmZjoj2ZquEFlzocyzYGhCSgFL/9Mo0hVmsRvJF?=
 =?iso-8859-1?Q?Lfud1WjTUXJn+IQlJWDprm+AXq7GXr8boC1aYKfZ1SSHYxZ24tilj/UF6C?=
 =?iso-8859-1?Q?YPnynP1RbqAqgpx1aEv0G/E3OefoHTHNsUTJESPFxuklrjNDKb+0NJPtm+?=
 =?iso-8859-1?Q?mAc5IqpAvzb3k8+BNitb9fzRCaO1tN4W9CxeK0Le1IC0s3ayZ9LImxr8v8?=
 =?iso-8859-1?Q?XH4uUtX7n+MWF6JmtwCOdpoCWbg6AOQ/Azk4Qvb0K2Z6WbgBMQ+1B2ft9Z?=
 =?iso-8859-1?Q?rEnYvXAfgO/6yo6yxIU5UcV01zH6xJmIyWleYSnx6jE6CcO3ccpoHvX8um?=
 =?iso-8859-1?Q?HFt7YnsZRDbutQ9SiFauQIkJJS28btjkf+BDf0EKC18tfdQ+NZhAAk7EAN?=
 =?iso-8859-1?Q?C9TWj+qGtMP8t4WlYwveOFg2LXsyTpsSOimAifkOdQrFTv99xwbGxz5NIO?=
 =?iso-8859-1?Q?okGl7p4Zk3/GsMVLtKx6sx4rIHtBkt2EXGl2h5l4MhZHjMZd6TJDIoldoV?=
 =?iso-8859-1?Q?l914Wgaa3mjAjhbS+q/ObT50GnvCYeH/5XEfR8RT86EIu9ZjXG9YNVDhZT?=
 =?iso-8859-1?Q?CPRhsErAIXe3tj6cwFc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a80e3f-bf07-43df-88d2-08d9f09174eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:42:56.0278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RX8tZvQNudWb2OfI37N/0JSvZAyTvNuE54TYifULCA4nOTOC/6Jp6v+8/bY+aVZfEO5Dzq/h/JfAFL/jDxhr6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: gm-dbacDoKiZ1Hs-nst1RqUuFNEC_UIK
X-Proofpoint-ORIG-GUID: gm-dbacDoKiZ1Hs-nst1RqUuFNEC_UIK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap header changes broke the testing code for the xarray.  Fix the
issue by directly including the header into the actual xarray header.
This should at least make the error more pronounced in the future.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/xarray.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index d6d5da6ed735..66e28bc1a023 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -9,6 +9,7 @@
  * See Documentation/core-api/xarray.rst for how to use the XArray.
  */
=20
+#include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/gfp.h>
--=20
2.34.1
