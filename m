Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0CF4EA5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiC2DZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiC2DZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:25:28 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ACBD4C9D;
        Mon, 28 Mar 2022 20:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O34U3tq4fzs56Isr3zKj9mbXhB40SdvkxbEUvjzetTi4vEw4CV/NxVU1hzwkKVgJsxd88FOZ2R3wLmltioxSB4QNmuHhvbHXFm9QfMAdvXCENaa9neWkoWu57jD8wnh9zqBvhgIIRPFwQ+Pb01a2l3LDY5Tcj9SJ5FCtm4wZY3L9SuGlMjOIypGMKe+kx1LrTOHGOHycNX9GTZOwxCHjn3laN3xKqhpq3Zhzx4vnvFMEVzQ2Kl7lUFoXdZMHfbHNJlkQ/dBim0T9heKKHz81ltkCex/it4D1v2YYlflSszhqCPwmcxkvSlivckayoiXWiAFycFCmSi4YCVOkeBQkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUB7Hhz/iu8qqVGZwmZ8NBP2H18dhgZH7zjbPu3G9zo=;
 b=YwU5dOiehnn9WhbTBMNb5hYlhUdCBJ3d0jifvPKZ3koYcMBgFb/ASf/VRDTmBCa8HPnKTfrJKycug8AkTf93rY+5lj37GJs9UM2QkYDGNo7Z1nzOHPhigysiR1BSAbIHgdL4Z1BCIGLQrAypvxuIBnz+dfLZdadYyzhkBzGUV/qcuGnbOJlJVkxZigoEvviZFyBLscGYIrU4HVJ12mTADuVozaeoFCD0g3Njnf/ipFcESsJ/FuycoQc4kCIr3m3pyT9CmLa/WQKXW5PSjUVssK3W8yvLyUNe/+YpFY6YO2DKXxZbDzGtf9CZMTgtpffq2FVcFNrM6VTH7KoaFefpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUB7Hhz/iu8qqVGZwmZ8NBP2H18dhgZH7zjbPu3G9zo=;
 b=xut45TfK+FWok9saiNWfPysgwBkOJendOG38pNLR45CxiTW+/o1CzIDInpfe1bUNoHyhh6FL5I2p7+g5ZKrHoCpH96sNgWlu77qqrQbmYoY5bzSIdtcdffCwoRGMFdr+DmBO2CzEuHfYf1pgn3LiE3M0ENc0XQGVJqBH2Zj5aYZleblBE1DycltDpNxLznZSjmorcrKVPD5K+8peCz6IaR4FlMYHmWd5iyE12+8+rb/sbICgOQhkYwDx1UnADV+H/Egpy0rLymXBZghq1vjfYA6jqbEady0HoVerjmjC4hHi10ByOC3OmKGwijijGRPxVN0RtQuRYKaKvn6nXUpJGg==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 SL2PR06MB3130.apcprd06.prod.outlook.com (2603:1096:100:36::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Tue, 29 Mar 2022 03:23:35 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::69db:d6a9:d891:e1fc%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 03:23:35 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 0/3] Enable ast2600-evb KVM
Thread-Topic: [PATCH v4 0/3] Enable ast2600-evb KVM
Thread-Index: AdhDG9LhFJJLJgC7ToyxS/CiFRGSBA==
Date:   Tue, 29 Mar 2022 03:23:35 +0000
Message-ID: <SG2PR06MB23155BD5153975DE8D863DBCE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ea3060d-d962-45e4-5ede-08da1133823d
x-ms-traffictypediagnostic: SL2PR06MB3130:EE_
x-microsoft-antispam-prvs: <SL2PR06MB3130C5EAD86DD34C067CB2E9E61E9@SL2PR06MB3130.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sTsBan9oiuJbfXezcLmsieOXTG56KjVhDg7L9cgfGQtqB2GggCPEcVa/Uqtrw2GcHmoDLjVJNwokVnfw6LNAf0FzEmVeFkZAOSe2OtvJf7v6i1Ci7cQ4j7gzCji2L0PfW16w5rNA21/dz9sYlJe6zYYSt/2c8Aadnd+byqTeevLLsbGIB45vBF1s6eCCBnvuQQICskmm1rYlaV/wVGP3m60HeDzi105hRgGBx+ABLWTfeShPBt8wp3119NUG0bzHF/bClN1rJVQbSpf9Furl5iHyp7oi54/NXBb4b3MVKE8wBuNZSdiWOuISOYt/H/+aV08oUtMCvaN5FkQGA7UHjqtl8NKs+xrjnHpynsKA3C4EQ6kEs9V1gW1miOz8AUn3ag1C0MqZPGwHhzS7Zx/21dGJ5vSy9Ncx77m6qV0Ww9cTQs5+Et9H7FPyBFu+wShsFXhayo9ZUeaEEi+HOibcPS0DeIqx3kSaUwgpi+p9+srRHwdDC9C4GOZ5q16CO6qjdz3IuheSEKvVQMyuAwra5S+Mz7l2OortzyQ3tYAx9xL3+olTMjxaVPhstKrnbRkAqJxICPHti59Ks6CGTa9PN2lRU+iN0XhwLoaBhB1CFTLCYvNvgvQfcVI1v+BtqiDXu8Onas43reujpSmF7jZCFPef9tl4H8D626O2ZSFqb5OG+oEALwvkFhr9cModf1W31QNilPLndFA7xapCvUqqUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39850400004)(376002)(346002)(136003)(366004)(396003)(8676002)(66946007)(107886003)(4326008)(86362001)(66446008)(33656002)(122000001)(71200400001)(508600001)(76116006)(64756008)(66556008)(66476007)(6506007)(7696005)(55016003)(186003)(2906002)(38070700005)(83380400001)(52536014)(316002)(9686003)(5660300002)(8936002)(38100700002)(110136005)(26005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Elrpk0dMV+6UtDngOfXPJ/v9Y38zGrXJWuf3gRO2FcLJrK1od8asUUYgwog0?=
 =?us-ascii?Q?zMjApImktZcoAfweP8exKgF3orRBFuA445J/Wlx4DQSxMubCjG3Pzyy5iQeF?=
 =?us-ascii?Q?WjDtZtVkGIw0Skftdy577q0IpWLIyYM2t3tjYIxnP8dSKPyNhc/pv01cpTPt?=
 =?us-ascii?Q?JrJcqFGe6l6TqyszjuIs7gQbI03eyMcYj3vtswrT31YuumpW355gDeNHxRfN?=
 =?us-ascii?Q?ikMvwWBVsjytiqJAVo7qSd/iFsBbtMlO8jx0cwED9/qDHnnwUPjvwRELF8Pw?=
 =?us-ascii?Q?oj/wwv2srqLuzLr61+jAAicadwrlLsJPeISdlnyU1ujx0YCAOYYo1If+jURa?=
 =?us-ascii?Q?LnyL+i292ES5macaDGAF7mfHkEYDVQNMQKfvTgipxK9mx0ywzTxEcbTF2taw?=
 =?us-ascii?Q?iy/z/55flVFHNTDHjvex7td4AACzhqQaQGUU6I2QOgRa6Wj5L8785X6/lz8c?=
 =?us-ascii?Q?QAD7JLc8w6d3Ia2IJ7mb5J+UBkdZVcEsV3uyAF+bATTKcqziUsnDIRA/aa0o?=
 =?us-ascii?Q?7/UjSCS1Ym5YZJA8DkZmHxwq0odIdzau8ZmNHTQzC1T0+HiYPxUggRekVNa8?=
 =?us-ascii?Q?hdJUk2jhXdvWBBQ9R+/jPn45M7blQVYUKRPSfvgP5mlceWPMXr5txtD3zsx1?=
 =?us-ascii?Q?tfaEO1CYodl3IvOGRzgV/uXsKqPOhYXL6iSmLvRTVRGcWV8YRyFh9QT4RXwQ?=
 =?us-ascii?Q?c93e6Htqp2LxQQKDuk2oBs8vJFsjQqDS63iu+CQHgeNoHdakTBQ7gI+WI4p0?=
 =?us-ascii?Q?aWenKkPShbQXd4gOLqpVK/wDpk2Tvm9Njsoq17iVPvc5EYBF82hwlwLWS2sg?=
 =?us-ascii?Q?LR4D4+NMQML+67hEo2MlKNieIKIGPZInUa23lfKIDrsE2rXUzZAAyy+90wQ+?=
 =?us-ascii?Q?ECvMmTlet/5g00RIjkgXcMuk18YftETBclL2/t8svWJhGQeoNleL9zJ+tUxG?=
 =?us-ascii?Q?tbzJ0E+xKuvm+HV7XcLc8PY8Opre12qo8DZpqqctvvQW5OOezynDM4ee3l3v?=
 =?us-ascii?Q?MXKAH9EZgVN/goYmhb4+ikqhxy3+yr3LYLmRfLbDZBFvxYKTkF2iO2DZCLG/?=
 =?us-ascii?Q?I96jRd4KZ8Z25XN5y8yHJzZHae5tGFJ85WzpKwLuj36mD6rGHkt7J0TTAXER?=
 =?us-ascii?Q?m89dVHMs0eAroema8/cn1T0uXy6rQ/sMgJNLH9CfWWvjvqDNBeKLwpfD5D5t?=
 =?us-ascii?Q?kIhoeOjBVhb4DVXtD22UAxCvWJb0AT9dguSqtoBOCYPAVndJdI1JoG088xha?=
 =?us-ascii?Q?j/a38CLAjedlxfz202dYq15Y9Pl449dvWv0/PSMgupVC+0a+F9LwU0eRd8CT?=
 =?us-ascii?Q?SSgyv/2D/SYk2yDu8EvCLWRfwtrNZDIhgmAz33t52fWa2lxsvhxR5EjVMq5Z?=
 =?us-ascii?Q?IXZbBMP5IFrMGp57pazclXHneYDrZhl4YpGhniZyksGkWEo3UKVUvQnPnfRb?=
 =?us-ascii?Q?fpiK3KkQaveRERdBqs1ZiP49hAVYjjRHfMkkRPQl53zCsBj0r7LGNPKJO729?=
 =?us-ascii?Q?mWLEqi0Mw+VtSdUTy3KbYp13Z7zSgz4+q/8AbeD67j0PKCxK5AXur81VvHXk?=
 =?us-ascii?Q?KELNPxU2TJYEeRKupYAncLgzFYKS0kH2pWncZwwg03/X7qfhAlcMGK53CV7M?=
 =?us-ascii?Q?OSzWKBzNaGdR4zR8CHQxvAnYEfmOcb5DjIi56isZSKjzZNjiuWzVXfyeOf4r?=
 =?us-ascii?Q?+W3o74iS1l/HaxQMc9nHIvC+OEJdWnsHoKtbz0Fhm973iYRzKa9EICbV4gDQ?=
 =?us-ascii?Q?WXAGMEVjKP8EPurn8S2Q/WdcnYcA2fU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea3060d-d962-45e4-5ede-08da1133823d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 03:23:35.0848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRxKcOLzs/Tq4xSBQo5kIHfSvF3asnD9NKek2BXCk/iyRZJspViewSN8nuxl+6SvL1XIXVJRDiPNk6MVemA/l9H1ro/j+6dF7Dn1oBjZ8zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v3:
1. Revise commit log
2. Split video engine and HID support into two separate patches

Change since v2:
1. Add video engine node back which was removed by commit 645afe73f951 ("AR=
M: dts: aspeed: ast2600: Update XDMA engine node") unintentionally.

Change since v1:
1. Remove video engine node which was added by commit bcee38919fa0ae47c4a80=
ffc7ee751039fe159bf ("ARM: dts: aspeed: ast2600: Add Video Engine node").
2. Remove reset definition because the reset is handled by clk-ast2600 driv=
er currently.

Howard Chiu (3):
  ARM: dts: aspeed: Add video engine
  ARM: dts: aspeed: ast2600-evb: Enable video engine
  ARM: dts: aspeed: ast2600-evb: Enable virtual hub

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi         | 10 ++++++++++
 2 files changed, 33 insertions(+)

--=20
2.25.1

