Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040284B6F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiBOOnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbiBOOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386B410335B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:07 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FCMIxE024475;
        Tue, 15 Feb 2022 14:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sqe8IuvA7gq6O4pyFA/597HFCPbJXLgXKUqrcPe7IR0=;
 b=zG3A+0ycCr22dLJ38fUREFjIZUl0ewNsSr/GsB5zOn4SGwlTiCi1zA/Yl9iBm3wzvE5L
 RetM3wZ2/XSn8MdNBDr7FCSMfJ1MeF8qNeKo+mzxB+chYUyAdzRb4XwXs46mZbRaWTcK
 THotsDv6FJChHpUsc2OG1qlxZhcURYhKZdMIS05waiaj7vME0lQxP8g+cdxovUwrZL7V
 qf/qioudQOO9W6uW6plYWp/8Y/OWPR/bFzyaFKGUV7fYuviuVJMEmpEH72OdNZ1iTIB9
 V5sCdWOHO3sMxBFxvXgP9IBvp1WKvG0vLVQFMZufc1gT7jylt3Jv+Yqj7dPcdlKok7Go bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psaq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVcZ085745;
        Tue, 15 Feb 2022 14:43:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 3e66bnpj23-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:42:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjBId8uB8aMPjHDViqpsq0/QVe4b5rC4t5EkmnrEmbnDytVYrCI5LO9MJMvNkuAyXB3VTdbTn3+LTg1D+Mym5VXMjXyL+eIx+CeLTVNv1242Cor3PPny+XjWkjep3Tt12+gmVJCbEBkWkaASo9VbhztNTiL2UZl2dCCmR7Vco0JqRVA1IP9MAZA8NEOAkAFcdPDcAJRoGfJFFyHdGHqUYS/IsmWeX26QUbSEDqLKDkoBQYJ++x0/trBlepyMVK/9g23N3lSukAX6ADPa13pmHaNDQlSMkpS8xX5t+ctO7eKugEkEkvr8mxMWIjTua+p8Re9kOa1BT8sL0tnT+mg3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqe8IuvA7gq6O4pyFA/597HFCPbJXLgXKUqrcPe7IR0=;
 b=d1P+xzOPGkIvpPaP1rZHuaR9mGvkopPbnl5M1ZEra1KSTlD+9Kl366QMF8p/W0v/0wgutpwMacSAlzylxJ0Yv5YeGJnvaLJrDTdanVR5g13XiVYyPNekMx239LQVkxYDaJpVXDP7UALfZfHAAVc721Cc6yxMkyOrKXXsJkgY1NmdCeCyQS/pXMxDvfMAxCy/gdUmaIxxva8DtdtJ89OS9BlTABLEi4KS5vBQ5vKa0kX6bsV8T1PdEG6Fr2M3eYIxETgvP+/ZayfmMFuHBqN9Isb9lHLInkGZe8PmKfYxk+8oO156LDCAD0cGZGnn3J/iQORVdCKDcyIkBzY91vcLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqe8IuvA7gq6O4pyFA/597HFCPbJXLgXKUqrcPe7IR0=;
 b=Qwlvl/b4y8ilTy3VxcF0AWA2J0tj3CVcfdMceTD0HWqvA0m38yXZZBGudJ1iRxX4hlzJ0+bRf8jWmOJRRAIMgOj7zlQXTLDjC6Yqq0vEEFfnZGs+wX/lg9gKfO5bEsFdyywMz89xCDgvPtq4J+Ze/yEfGIulLiv+TQXnHCWUQ7M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:42:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:42:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 04/71] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v6 04/71] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYInpSXIKTjb68IUqVhJeyD2af6g==
Date:   Tue, 15 Feb 2022 14:42:57 +0000
Message-ID: <20220215144241.3812052-4-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ed0fd3e-3ac8-4e8f-7d23-08d9f09175a5
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB2197412E173CEFD94015994CFD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TAgiu2niMntuzRsJfB7kKKagiiOi8H/RICkZNA2rs44tLUwG+ioshqE+4/YlZeX7gOUza7vq3GgWdRE9eyhcF3nDh1Cekz6fAii4jdZUPmfDBJ9mTGil6SUjajDxy1GnN2wNsjXhWKy9tZjImN36g7MI+wxv8tYs9AT0taLqrZ8pTo1rcg6KNAXxpauhEd5JZx3qygF9V+M8ltPZDGOUqOiKQYoqNJYvfDPMRsd+nSWRsi+Z7uO39YLh7kpf8EQn4Zx/8qEASvF1xuJvDhjrxKdjBzWqkwuok45dpFc76Ohe+j5LMTOxj3dSvqcUOGLucBov0dBN+yPzJObU1kY5UFoBTecBf/7MVv6fKZKVapT1Z5xBZA9DUTqPs7/7lM3coKXjAemV/H7MtWOSkfvfi1fSvWidYCJs+Y1gBifydgxJkvtUusw2XIp0G7sDGb3A1Y4kS82qohpNi6Xbby1kOLopxa7/3EhuetsTaD6+rG9zI3ubiSm54WzmqEMo7xvYgKew5XAcd8yRRFQtA2167QfCtElUdrfDKfKpr1Qqx5j/yJRKj3WBMPstwlHSUR88+9RuWz346I0ZdDSJFP9Z4lasUHB7EynboGwmZ8LAAFNktaTHT0UVTaoWhdPPiXH8vs4Z7vvEiJRcgouvN/l3JWg5D/5VXsM7rW8vrpqMqR8UNivzihni2xaEYaxBsTCI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QFAK2mTMQwuEsWnhG5xSb+svbMguu0QrDvBsPbpfTUhgPOV6DfyEt4Sd2O?=
 =?iso-8859-1?Q?KxpZX89IcTK1erMpfo/7T8nrp2nNDNlio+ycGHCDlk7fiqo47+/QZA7LwG?=
 =?iso-8859-1?Q?rgnm1fJB/MWyMBoJLPgAXDc0GW3kfOGFe8kYqAJanwjp01ZNVr6l02Stkz?=
 =?iso-8859-1?Q?/j99czfCgy4zk4sXUv6+xLH+bXH3FoWAJ/QX4lKnRqx8NPExblUheAU+07?=
 =?iso-8859-1?Q?xJoWyksazJfG1kOWOfw9cLgkVX9sgNZHr5jUdG5pl35vY2NSLJcyVjhTVg?=
 =?iso-8859-1?Q?WMI5fooVosDdfbKHXW/+QsJXsHyD0NB866uQDpbrlpHSLluwufPpa0cmTU?=
 =?iso-8859-1?Q?sRJmc4YhOh0kRRmHB11VvXX74RG2lohhByn7JDgH2vwubotO1BsLMueJcB?=
 =?iso-8859-1?Q?oqX5/xE/Ma+0cV6h+K8LOy3XPsqtkEsHHG4OX2M5/XFO2NJxRpuk1lIQSl?=
 =?iso-8859-1?Q?cYz1cWnKprDRcH6CVUNOEwZzmK3bFkoiidUg0PnS8hPrV8THcxiQJmObbV?=
 =?iso-8859-1?Q?WJLs9nRL48HPyGeGdX/FVuzjl+0MOZIVHSR4Ut9NsXs2/2R5zcKkGe4Jfn?=
 =?iso-8859-1?Q?ztJiTh9fGjX3AkjBb2FPxlfj/hIgkNgC6/6rb1jYmueJKgAi3bKcoOSxmu?=
 =?iso-8859-1?Q?yu3bGr9/+LBntWqoycPSITf/7vgDBUxtDwLsOI8gIlYh56m3rA77pBB3ds?=
 =?iso-8859-1?Q?ytT0HW0jt1L8uLjAaWpmNRp8/+6ymp4Od1QnU1fOy5qCG1pp6CJdkT9a+/?=
 =?iso-8859-1?Q?HskRzSwfOkTGPObn10ljIF7cr6DVO9RFMpjVLiko8Ks+u5mEfK05NYG3ej?=
 =?iso-8859-1?Q?lbslAnVGNPUS5xEVrZG+n77ZFniAdJxCxW6snWz73pUZtm1MAw6DNri39q?=
 =?iso-8859-1?Q?r4yARxj8QPKUi3qPFHNNgZQhspY3i4VtWIOXhkv7ftQYtQxVnEIWIJWp78?=
 =?iso-8859-1?Q?YdLIgpJxkXLU/epp0Vr0OgHa9n7twirX1Uu1nkWAYZ7qpy/YeEtQ+w6jHI?=
 =?iso-8859-1?Q?6+67MRwrcPVs3S78joN1lik7TnyORUnFZDRL8xYdfBWpQ62eua2gYGHr02?=
 =?iso-8859-1?Q?FumKk2xiJcOiYfeL+89GuxvdyM42seg3XzEW77nbDOORQAM6ghBMO3HXls?=
 =?iso-8859-1?Q?jpeRy9dDeG9/ReiiGqgZOAei1a0lPq9kAPnj7kPgh8+fOIiwoj1xHBPn6c?=
 =?iso-8859-1?Q?IPOT8LmLbaL0/tlzY11Ydw0q+BHW4vhzl+OwxTxgy0PevaaeRkoJ+1zwtv?=
 =?iso-8859-1?Q?HTUBNxOSqBOrlPB6FxJtQi1fXDkw2eksEGXpXtRVVI1MNZPVZeOyCSLJIH?=
 =?iso-8859-1?Q?a6cBDrGUo7Xb39FneVD1czWJJ4wGto3eYmSa0E/6CN0NGuUT+rmeVL5OES?=
 =?iso-8859-1?Q?vQXk2Zg6sPhggTgaRnuc/dEVBSe9hhNiNT3/iMXnOZpzu7PmMUDHNrYXJs?=
 =?iso-8859-1?Q?PqG44+h2zU7nojlq0q9p6d5mjh101zJuXMO6mb6rJ6iO54gDBuLVmAGCPA?=
 =?iso-8859-1?Q?UO8eTKYnF20NRsXLpsSMXPBy38oiYIv16kGhCfWIyrjG6T+rLOtrqTPPBy?=
 =?iso-8859-1?Q?i+u3RJhJGvJgpi8SwPgMwLdTGOfC3Y498Hl1Wn/5ybh7az+VASNM7cATkU?=
 =?iso-8859-1?Q?V2fXcAieG9LtQ5sGVZC/pl5ybQC2raXOSmRst3M314BYIc2p+BGgJ5vai5?=
 =?iso-8859-1?Q?+H3AKT/2xyWdSHuOZ2c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed0fd3e-3ac8-4e8f-7d23-08d9f09175a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:42:57.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXBMhnFAlQcpEEarr4CkN/VCxavXpGOGg0IhC1cjuljkzj1sOqjY6S82O3HygxjLQxP6+lW8doqDMYyY6c6OzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: fdsZKKY2EGHVKuO_gz8UtLD0AQ984laJ
X-Proofpoint-ORIG-GUID: fdsZKKY2EGHVKuO_gz8UtLD0AQ984laJ
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

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 2d9c59df60de..00ee01a14652 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,14 +24,24 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
=20
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
+{
+	cachep->non_kernel =3D val;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (!cachep->non_kernel)
+			return NULL;
+
+		cachep->non_kernel--;
+	}
=20
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
@@ -116,5 +126,6 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.34.1
