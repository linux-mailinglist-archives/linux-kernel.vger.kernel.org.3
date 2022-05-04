Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B20519327
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbiEDBLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244886AbiEDBL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5274231345
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:07:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LIGp3026258;
        Wed, 4 May 2022 01:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/eX6NLsXus/aCvKX6/hTA8FBB3wGYhEify+xnO2FUW8=;
 b=pp+qI0IXpXhjCgtPB7kBYN25vc4kNC/DKehVHFIQ30Qdsy0C/OapRid+dYci67ZFmW5P
 yG21mDadT9sFsdzx0MS/XlpnLZ5z0PLleVLl8bhkRZ0mNteTWcoRIX0mMz5RKQuIyzSW
 SBPIXByHW0uERmfxbDbDx0tJytDTx01LcpS4BJGdJqnMosaqeHBEke4NdyBTUBH+ZUtt
 eSzdLXrFYMOAZHNmpH/xmSeOWBv8PQ/k73ct4a95cxAlhgsbBib/otVf0LdUbg2zWhy7
 Ii0iKtbUgcuJBm8DuNWa0idBusY68SVhdeMoj0mhHyjUcdllvYobCMjmS3mRNhbbqrBR Qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SuD039134;
        Wed, 4 May 2022 01:07:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdk7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBaM4Gx28YGgXWkUm7G1M4+VFgA/QRfJ0BJMdJDhxa49e0l/QAIfgIRHwJAHubHqvIPx0fw+ZkHmYP6+HAALvKxK0damN7mg3TtF7wc5s59FHPGidbLa0qod+d4GTJhnOShrd/iNPyDYUmQfHKL3qRVLkbGjuHhyYEHKal7y4RdSISmgfdEXORZfZjcKm3XXyO9cqpA6R8OhRgd8cVvguJn5ud9dNmcK5UxD3lFIGm3nidjPz+HJinFDWjrRrehRQMm52o/arEjDAz9oq7xg/TkHlRsZb38S+iki1gDqiq010+q8S14/BYlDHxNW0n5E3nIw/n/Xkgnhp6xE4EZ4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eX6NLsXus/aCvKX6/hTA8FBB3wGYhEify+xnO2FUW8=;
 b=DLGng/cuucbjT95QkH7sHhPDr0+6J5h2aMBuVkMcAU1+v6f0g+6w5YPWNwWHiR5EkyaREqHtncG2HNYDb8l67cpwcBiuBGEZvpDeeDxooO7za16KfIc/97WmkedRNAjpYd56O27r9oiBQsjEgnB2/zUylpFZXm7nvWOKu3+GIu6TlW8bd5ysj0vhEBu18WjluA2gz5xkW96xZxbCa3rQWyBvNO8AdTYPelL3D7ndU97ki8zPF0TVlyDseEa2sUxlxxYbRrIosrbU1WTshrt0LK5GV89/EDeMG45ByaWfQ/5b6iWvTjTa8S9lR3qLCegMtdORNBTJAFuzJxNuPOfiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eX6NLsXus/aCvKX6/hTA8FBB3wGYhEify+xnO2FUW8=;
 b=MWnUH3zycjELkCMgoRu0wvNqjXbB9iUlnAATFRjZlDQjkUsalDWIy+MKNrUTkumRzpVo5o/lyyvvrQ5//phXsCc+TYTOh/VWBLM+0y9FuHPgaQYf3WZ2wQP3vFL9dVFsBuyfTrIa90ta/xmGpFkLMUfT0Ntx+PQfmYI22DOJyPY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM8PR10MB5445.namprd10.prod.outlook.com (2603:10b6:8:27::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Wed, 4 May 2022 01:07:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 03/69] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v9 03/69] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYX1NbAJDDSBeQz0quSojrWOExlg==
Date:   Wed, 4 May 2022 01:07:42 +0000
Message-ID: <20220504010716.661115-5-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7e3ce49-0ab8-4433-f23c-08da2d6a7d9e
x-ms-traffictypediagnostic: DM8PR10MB5445:EE_
x-microsoft-antispam-prvs: <DM8PR10MB5445C64D4B8802F26DD897BCFDC39@DM8PR10MB5445.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99vmaje/2wPaDXZ8okv1C0n1WqhmgVE+ccJg9keWiuZvzELpOgsy9K/bRzFyV4uBhwK4EWb3V6iA4D7/lHnF+Sj7vGkjjMM0RC142PUmM08+b73WiKgcjljoeFw4KlXGhKpzW2UpZ5wVoJ/27/DzxKS6NGVKxU41pdA30LDFZDXKQ1ulCAshdyIp2Zh9RocUhz2aS31ahOihd1rBMutvroTrih8UksTp46sndCB0Ld7nWwAp+B5IgwH4fYpcedHEni0Oi4O4TEtCd09XXcw1PpGvUTIylPfsR0+GqVHCArQOShYB6Ewo4c3xQjZI2K8DaVUyCRcUxG7Qmk6jcFWoxpEuOzS5ZreKV3VswJr4ciL0iFXYNt/WmmErs05CXdrL5PUf5El3Xo1S2Fl5v5+unmhqx9USI6nBEKJU1pv8SRyB9TyeMwZZFXO1W4iUiK2EUgb1HhqbG2C5y/WBGrakfhAVaTgXXTmQF0xEEBV/q+JuqgzX5plRpUGCgllFZx/OMGaHHzP2uSB1PBMVTznkdEKrLWaLmLg0TEVnb0G+m2/zu92qW+kH1M2xUVwVWNczXcXtyTX0ZNlCBcKcoyXa5dbSpyB43iqBzTzr/yMdT810YA2EhyNRDmYlMVOGbsbElK5HjGbjvbm56foRNLgLfiJ4jM5iWJZ80edorR/JO60qduOxDSx4QZYkkhXS9PTT8ZHGj0rHS/siqLG0WRS0cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(83380400001)(6506007)(26005)(5660300002)(36756003)(6512007)(1076003)(6486002)(508600001)(8936002)(38100700002)(110136005)(64756008)(66446008)(8676002)(71200400001)(66476007)(38070700005)(186003)(44832011)(122000001)(316002)(2616005)(76116006)(66946007)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LU+dEn487n61WTU6ZKpT6k/8svy/32q7LCNF2qahAtZOnMCMwWT3A79Hr+?=
 =?iso-8859-1?Q?6mxfjentLvUF94URpp9T/15Cp8Es1IU0910izFSypU+XdzdhLKeph2/tVc?=
 =?iso-8859-1?Q?9FEhH23hvy7gdKH9FsC9DnEp7y6zXjEbVaz/l2KOHl7iHcQfZ6HwXWgR83?=
 =?iso-8859-1?Q?hXzWvb8+rdLrBQsbnxg5DgqRa/L7QNZgJKe5RXi+zkcTIASn4J7cNlO2eJ?=
 =?iso-8859-1?Q?8cqqxMwz7yeorIWfjPpE5QOwOFL6FK0zncbwX11SQdB0RC6M5eOh0iHmZS?=
 =?iso-8859-1?Q?xSkiTZNsVQrHu87KOwdO4SvJ+j/pUFghXfGAPf776JLUQkWhjHiGLzhNsb?=
 =?iso-8859-1?Q?xdmpqCOfSEASsv05NMfQ7VrKO+t8hdBFDhQT2Nfp94ohqefMzpWgj/Q1e2?=
 =?iso-8859-1?Q?2rAniXAX3wUtPr2UOK5Cm2cwl7Rxiah/1+eiwDOIFcm+hGP8pUFZX7oLBC?=
 =?iso-8859-1?Q?7e3QavBe495sNSSNSXmvyTCPzmuHkQw/BZWoMF/wN2qjYE+gbvOMNAXzUc?=
 =?iso-8859-1?Q?2FaLV8JlpU4Q4Dh2vFwpIMh9mdEuQRnTZelRXapIjiMUxGB4a/h+59+e52?=
 =?iso-8859-1?Q?onasTTe1ZCMK5cAMuQhBOIbCP/mcI6XtanFrV7GthENpplwV1wDY0P8LV8?=
 =?iso-8859-1?Q?rOJwX+VN6H95XbP6Txsh1CJ0lvd45Bm2W3LKwKmkR7DGc42pn4tVbR8yMn?=
 =?iso-8859-1?Q?NyA7sNpNtmM2tNNwAYs3o5UBY1MXVfnte12piDiTXhSNa9IckbIkh4XdBi?=
 =?iso-8859-1?Q?25UBTccBbhAkrAdjnTc+t6AUQPcr8BP3EZiMl4NSTe2uRbIgqJf8OqYKcC?=
 =?iso-8859-1?Q?lsl6iDbBbx1w+YtgB/ecR2tOU+cLJGFi7uasYOy5vkL5scz5SqQI/33Mfh?=
 =?iso-8859-1?Q?9Igi/9e4RX4I4A6bifONnhcLa81vUqWsoC1bk1aOhjjncsgHM+vMktEDxK?=
 =?iso-8859-1?Q?m3nVnXg0PmTHomdMbljPRN9d0ZMrExMUIutDFuVsO9Km/qu1f9DAlWQGQG?=
 =?iso-8859-1?Q?N+Z3cCSJytEkuS4zslhDb5tOtOugmnYFKILsKiOZuEzyEd+EPznr4Fn8gI?=
 =?iso-8859-1?Q?odzz+C3aVsZ4X/hDP2cbpZ2kJ7gvUcqgVFu0oVlMj5q+x7oiASTfSRPTPC?=
 =?iso-8859-1?Q?ralKEa1S5Cz/xH/oBhtBhRcikVOtZId2cYK+8+BgWbTwqp9jb/df7Ek0OL?=
 =?iso-8859-1?Q?hkw+XPl2MThxXUQnXtNQvmOKWTDtyKqGPsWew7ouJOcNjOr4HVGcNVyAm1?=
 =?iso-8859-1?Q?j7njbe3TwPPN/B7t0wS4PVJN+GYcvpIhvMi3ykCJFyzEzDOFXwK8pdwyJc?=
 =?iso-8859-1?Q?s1H1X38LEWXNXBFtE6oKb0C88ygZbbOUYBH/QkKKrvK1VkRlcBlX5AP6lx?=
 =?iso-8859-1?Q?rB4Pk+xm2/JkVsd7JiiUtDroWkJT6trij29RJV6cmvwfMIADRkuOKwyDei?=
 =?iso-8859-1?Q?RAv1wlo+VhU/ua1LsI7DjjS2UenKTydQDo+jubCp66oaK9oanARMde8P4Q?=
 =?iso-8859-1?Q?nnFxCIoUWQk5JnX/EHw0du15xCegHRWzEJvwp6oBAKwwdgtSegKg2ddAF5?=
 =?iso-8859-1?Q?SVTD9l0H6aPp5EMR1ok0CCZ8IzyLuBHAo/aPm2xG/raP34zGQxFb0HEWjY?=
 =?iso-8859-1?Q?sAyAPm6fFcY7nyofn9RpHsHTHs0Ag9m53rLG9Dhl9lYaOTXOHQ0fAVbMWY?=
 =?iso-8859-1?Q?8O8pwxE54rejflVMBx1iJpZEDALzMV1E5FxzW7eIFgTAaTaEh+tCHgWxCq?=
 =?iso-8859-1?Q?Wxgg0YHO9YYtzVxyJmBKVRl8yGQoBhMTSu4kcZ/5i2km+JxJYO6dzO1IBW?=
 =?iso-8859-1?Q?YYae0mfjDFI6Ut7OujWTHHm1BB/GXBg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e3ce49-0ab8-4433-f23c-08da2d6a7d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:42.2292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRmQtFC/LqIKy0iiA81A+H7w4PPtVX5BQ8ODqTVuDC9VKNkDT7fqIK9n77VTIuprP3huJhldlySSLtt9iS6vHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5445
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-GUID: 2PHibPb4ZW3sRyJKYG4Y-pJKpOU9xrT-
X-Proofpoint-ORIG-GUID: 2PHibPb4ZW3sRyJKYG4Y-pJKpOU9xrT-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index d5c1bcba86fe..277aa8b70abc 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -23,15 +23,26 @@ struct kmem_cache {
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
 void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru=
,
 		int gfp)
+
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
@@ -90,5 +101,6 @@ kmem_cache_create(const char *name, unsigned int size, u=
nsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.35.1
