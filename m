Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B3573237
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiGMJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiGMJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:15:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912FE0F4A;
        Wed, 13 Jul 2022 02:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChFuJkzmYTGbPqdaMsD2bnKlG/R+zsz4uCYxEfvTQN3Nec7ZG7k2iFh8jt7oxH5bB0aJsuGDA2GUDO/LzOPxbxH90lB4gSBPxPU0u3euG0ptXsno7VPb+xFgivKYC0uesd9ue5PlkLPBVHEEL4d0nlcHr0LClUt0mqUuJDr7LIPiHuRbSzOWF6tfZim7Utth9VcMnTwH+2f/4dvUvKAlF419PMRGVJI63NcCzhi96iMGF+V29zXBWkjgNkeaYJ3nS/AL4fALpY2dmGQTHuFikVgyRTZeHflqOoSquHCsiWR9ytsfCNGf17ZCYVci5hls/eDZ6eZJxETxb8pIjAUC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwhP8Yt+6aL2d7xq2W7/dyMtN1P6qkMvsQ+b9tZmX0w=;
 b=G+uoORkmoJwnAUX34Yc4kurx+EsF399OnaKTxYUOQdLYZNN/QYUaKDPnc9N6GwSqYsik/e137F+XUuDdinyeIGe+bBeoZ4adtZqM1OJ5hq0AQ7GT0Axj8NN1ezRR69CggbjX7J2xDOExSUPdTsADu/w+scafvCqyn7ztERmtcRemcLVvFZ89zK8/cwDtmaPE2lph+IMSapcPch31waRbJtpMZX1KNdF5ji/1yWTuRapMBJCBYMeBXjq3uHfAZFtmBABaus23LGOKzE/H3TBFDLe28yeTMfz0SlJkADTYV4akijxV5lpDk4zW8h+/6J63eff02eAh4bKNKJ83tp/10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwhP8Yt+6aL2d7xq2W7/dyMtN1P6qkMvsQ+b9tZmX0w=;
 b=RLOmoaMJrfNzGPsdz6nJigG+yWyAn/21LiOBd5z2j2AZF/06BGXhidOgsWSbYh1+WPBw/ewvbjTunGt2a6VSpwmgxKk7bpzNETMgoyBYIIIAqn/5HX7pUrnZKUK76l2JCa1HlDSpVJ0v8ySbYwJgFXmCNqLgkbEi0tCzvwgmucU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4552.eurprd04.prod.outlook.com (2603:10a6:20b:1b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 09:15:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 09:15:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V2 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Thread-Topic: [PATCH V2 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Thread-Index: AQHYloK947kv/SqebUO7q2Flj5l6V617+EgAgAAIoDCAAAM+AIAAAGgQ
Date:   Wed, 13 Jul 2022 09:15:35 +0000
Message-ID: <DU0PR04MB9417373C67EA8CF87E3D985788899@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
 <20220713063653.2584488-3-peng.fan@oss.nxp.com>
 <52c0d236-49c6-7c31-abd8-2a083ca7ef8c@linaro.org>
 <DU0PR04MB9417D42EDC6FD08C10C164CB88899@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <9ed772a9-ad01-55c9-fda5-5b3f8082bc7e@linaro.org>
In-Reply-To: <9ed772a9-ad01-55c9-fda5-5b3f8082bc7e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfbf34dc-55f8-453e-84d7-08da64b03eb7
x-ms-traffictypediagnostic: AM6PR04MB4552:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KAujo/oRL217dGYw8Pv5x0jQ4O5GJg5kpO10/Rm5Ray5WD4YbOB8BRLyqCZwbHjlUVrHzwvPqPbJMUcaUhChdSrsMDTpPFimtupYOMprooyuPmtxwjHxe9Ww/rETf96TtiT3IhekbWTx9CGp+xv3bpnMS7j9/iT9kHU33ixi2VmKPMylDSE/AQ/oRo/dQugNuTVlKUiaCFfA9H/dilncsTQUudA3zS0cTCEJOd9TOtEz5IobvMSwn9NmEnYfDRgTqBB0/xIapSBihKa4l9ESXc78StbFgUUHVfHKFKjlrziGBF2BLdMbV0GHC641Yjc4pHFtzin+9OAj+FPVLrEq5sRBa/ofZiVNKozzW+jrVqmW1Us2owSO1jMU5jpW7w/ztFR4IwhSqh1BLBc+M28WRj97xjXYzOn4w6eOQQLCO4UNvzgVse/RlZ0ZU3Yu/e83VxCUzjQ1lJfbf7Z1CM1IDznc4PSzw/gctlhUaFv/RQWClq0CQuFP4uZ+CTh+Mhk2AqGSE3EL9vHV9TuSg0gqfTCZrlgbTemaImNtvXW50t9Vc4zS06i0y3qJzepoYcFFIIhYbLI0tbl0fxHIOMU+iOyho6C7X0RAO0EJ7ZCdf06wQXoK7o3W/KMra4ZsXswF+A9Jy2qsOUoVwr3jvGYL3tB+LDMPLv13ahMiRPX3tuLItwLj3ZQKuNG7LU7nlUJ8RCT359xHhIMpSX2TRZ13s/JKARPXNjOS6t3KwC1nzvDu9D8BMydWU7+6inIhKzbuXcMoNZaDUwYpRP7jdrxD2Z3NXfV5MM0SYrGM3DrILJV79HJG6KsWbgcIh4DYyloX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(38070700005)(186003)(38100700002)(7416002)(2906002)(44832011)(55016003)(8936002)(5660300002)(33656002)(52536014)(71200400001)(8676002)(76116006)(66476007)(66446008)(66556008)(64756008)(41300700001)(7696005)(6506007)(9686003)(26005)(478600001)(53546011)(4326008)(83380400001)(122000001)(66946007)(86362001)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um94T1VtUHhxdGl2Zy8vWFUyanpaUUVUTHMyTkI1dmhiVkthcU0xQTdTeGNS?=
 =?utf-8?B?am9zYk5xZmlpMmJQSGxuYk5uSUZ4dnVxL3dLSjJhWXFQRWJkOTEyeWpPMlBz?=
 =?utf-8?B?QjdKV25DUHZQejlGRWFLd3BVZnlsbGlrZGJma1oxSHV4MTVuYTJHSjVUWVc1?=
 =?utf-8?B?QmkwSzVQYkxYVDFHZWVoTkZtVkpMZ2tTUmdNSU1YUEZNb0xXV1V1eFpQWmNr?=
 =?utf-8?B?SUhMU0doaWp3RUN5QTB3SG1MdmNIUm9uK3ZlN2R6NGR6MVI3SlNaR3FqZFdE?=
 =?utf-8?B?NEQ0WTFnZllpRzZGOEduTEV3eTFhMW9xRnRPdVVWL1hQV3NCMjQ0ZnpxRUNx?=
 =?utf-8?B?enI3ejZoT1F2SEQ3aUpxQ0oySzc5MUsxUVMreUZKR05zUXh0OVVQeG43LzJ0?=
 =?utf-8?B?c0MxMGgrWVFWN0swY2szTUlCekNiSGFjNHh0TlBFVGNSb2tPRGxHUlhjVXpv?=
 =?utf-8?B?dzZFZXl5MmkvZEV3OEtkRnNPaXhkRzlUUjgwK05XRlk0Tmpvd0k1OEk2NEhL?=
 =?utf-8?B?Z3B5YVNnMUs3a0xIYzNteUUvVnNqZDhBbFVEK3Zqc3I1Sm1CdVJjVkZvTnZQ?=
 =?utf-8?B?bUNDVHVlZmp4aXFiWWJ2bDlNbms4M2RJTkFkdHdrK0NReElWRk9SRENVbGRo?=
 =?utf-8?B?dHZJRnNwbW11eFBQZWJWbzdoUVV2RVgrWitWcWgvblM2TXdRdTNsYTRNT1Ji?=
 =?utf-8?B?VlZwV0JTeHZPZjlacEczWGxXY0dtemNNS0VMbDJlZHoyTXFteEVxY2lYQWIy?=
 =?utf-8?B?VGU1K3ZjRlA4OHlTTm1CRyt4dFBNMWlNVXg1eWJPRDNUcStoZjJMdnplNjQy?=
 =?utf-8?B?QnhjcFJ6M2dBRG91VWUvSzVGNG9vMVNiVUY3bmxWbTdrTzcvMjkzQ2NBWk1M?=
 =?utf-8?B?OEhPNHhoaU1yYzJTMVpVbDk3YlM0UjRpaG85ZWlNUC91RTMrMUVMTEh3cWcz?=
 =?utf-8?B?S1J3L3hVcGJZOEg0MUtVbjltcU9EUFdMN0FzZjliNko0Y3Raajg2ZTAxMmRF?=
 =?utf-8?B?ODNkblV0c0Zjc1NzN1YxbXhId1l1UVlseDU4NlhQa1k3ZDhkOXRkM0NoMHVV?=
 =?utf-8?B?L3NncUVIckN5RmJsOHI5NFFNYWFHb0p2Y2tOVnZJeUZXRTVRQXVIL0hVdlBC?=
 =?utf-8?B?VmRCVGNCSkJzaXBHV2J0cnJNc1RWTWQ2QnlnS0tjSGZpMFlwZFp2UHhuN3lG?=
 =?utf-8?B?cGxMN2VRKzNBSjJVd05XaG1aQXJJK3h3OVlUM1l4ZUZMNDF5U2xtZFlvbko4?=
 =?utf-8?B?ZU1lbzlEOWxYamhXSGtrRWQvSGZVa091NnM3UnRac3R4YVlCWVhHS2dLUlFT?=
 =?utf-8?B?UHIrRGxwRGx5YTY5OThEaXBieGRuZlBONVFiYmhBTm4vdUNnWkxpMnlEUDAy?=
 =?utf-8?B?cEFGbUtFYUpoeFRpNngvRk8zOEw4NHpKc1FBZmdvSlNQSC9CWGd0UHZ2bE14?=
 =?utf-8?B?RGk5Wm9jUEJ0SFJ2OEFRMUNOMFgzcHF5eW81MmRCMno4dzB0NndpTlFGUVh0?=
 =?utf-8?B?QWhEUklzSEpnVzJxeE1vblE0ekdjL1YyRWZFQ1RwMlgrQnNvZHlKT3lJQ1Nn?=
 =?utf-8?B?OHdpam8xcHpKWi8xRmVGVW8rY0RIQ2tndStCaDE0dTJkUkpFOHNuek5aVFls?=
 =?utf-8?B?b3l1WXpGTlBFYTJ4TXVtQnZkUUtwbkpvRUlWM0x2Y3dYZUpiTUxMRXA4MkZW?=
 =?utf-8?B?NUQvNlVoOE9hZWtjeXJWekJaQVpZQ1F4d2pOSVdzYmVKNnBteHhpVitlWFc1?=
 =?utf-8?B?d3dqWmg2RmlWQllncTRBQ3lvaTJRcTFxaGV0SldKTUtGdDM3T3NUdjd6dTdT?=
 =?utf-8?B?QUNOWXcvQXBqaFA0dzU0NlJCcDB3blQyMWk5bmF2QUNneUkxeHErTzBxdFpj?=
 =?utf-8?B?Vi9wVTcxVm1abDZoZlBXdWNaY09vN0U3YThocXZQQlJJRVptTEQ5NWJiVVda?=
 =?utf-8?B?dE9FNUtMUXpqSmQrK09pLzF0VWxFSnVWclJFOWJ6YnF2cVdkTitEOWFMNkFV?=
 =?utf-8?B?V2IxczJ4MWF5NDUxemRBSzJpOExENkNyZjMxVjVlSk9FUmZvNHpLUkNyM3JB?=
 =?utf-8?B?Q2NJaHFVS0ZEbDF3OUZVQkN2MFUvNFU3SlhtTExwMXMvbXg5QTg3ZWpPODc1?=
 =?utf-8?Q?2nOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbf34dc-55f8-453e-84d7-08da64b03eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 09:15:35.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItpHuacKuwUNFW0Hb9kJG1IgUUq98OlzqxPT4F0jSQtY3vxHf1sLBaf8sn0t8uZEiok3pdYQvJQGJmqKJ4AK3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvNl0gZHQtYmluZGluZ3M6IHNvYzogaW14OiBhZGQg
aS5NWDhNUCB2cHUgYmxrIGN0cmwNCj4gDQo+IE9uIDEzLzA3LzIwMjIgMTE6MDMsIFBlbmcgRmFu
IHdyb3RlOg0KPiA+IEhpIEtyenlzenRvZiwNCj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENI
IFYyIDIvNl0gZHQtYmluZGluZ3M6IHNvYzogaW14OiBhZGQgaS5NWDhNUCB2cHUNCj4gPj4gYmxr
IGN0cmwNCj4gPj4NCj4gPj4gT24gMTMvMDcvMjAyMiAwODozNiwgUGVuZyBGYW4gKE9TUykgd3Jv
dGU6DQo+ID4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4+DQo+ID4+
PiBpLk1YOE1QIFZQVSBibGsgY3RybCBtb2R1bGUgaGFzIHNpbWlsYXIgZGVzaWduIGFzIGkuTVg4
TU0sIHNvIHJldXNlDQo+ID4+PiB0aGUgaS5NWDhNTSBWUFUgYmxrIGN0cmwgeWFtbCBmaWxlLiBB
bmQgYWRkIGRlc2NyaXB0aW9uIGZvciB0aGUgaXRlbXMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAuLi4v
c29jL2lteC9mc2wsaW14OG1tLXZwdS1ibGstY3RybC55YW1sICAgICAgfCA5MyArKysrKysrKysr
KysrKysrLS0tDQo+ID4+PiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9pbXg4bXAtcG93ZXIu
aCAgICAgIHwgIDQgKw0KPiA+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdA0KPiA+Pj4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2lteC9mc2wsaW14OG1tLXZwdS1ibGstDQo+
ID4+IGN0cmwueWENCj4gPj4+IG1sDQo+ID4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvaW14L2ZzbCxpbXg4bW0tdnB1LWJsay0NCj4gPj4gY3RybC55YQ0KPiA+Pj4g
bWwgaW5kZXggMjY0ODdkYWE2NGQ5Li5kMDU5MzBmNjFmOTUgMTAwNjQ0DQo+ID4+PiAtLS0NCj4g
Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9pbXgvZnNsLGlteDht
bS12cHUtYmxrLQ0KPiA+PiBjdHJsLnlhDQo+ID4+PiBtbA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9pbXgvZnNsLGlteDhtbS12cHUtDQo+IGJsay0N
Cj4gPj4gY3RyDQo+ID4+PiArKysgbC55YW1sDQo+ID4+PiBAQCAtMjgsMjQgKzI4LDE1IEBAIHBy
b3BlcnRpZXM6DQo+ID4+Pg0KPiA+Pj4gICAgcG93ZXItZG9tYWluczoNCj4gPj4+ICAgICAgbWlu
SXRlbXM6IDQNCj4gPj4+IC0gICAgbWF4SXRlbXM6IDQNCj4gPj4NCj4gPj4gVGhpcyBpcyBub3Qg
Y29ycmVjdC4gbWF4SXRlbXMgbXVzdCBzdGF5LCBidXQgeW91IGNvdWxkIGRyb3AgbWluSXRlbXMs
DQo+ID4+IHByZWZmZXJyYWJseSBpbiBzZXBhcmF0ZSBwYXRjaC4NCj4gPiBbUGVuZyBGYW5dDQo+
ID4NCj4gPiBPaywgSSB3aWxsIG9ubHkga2VlcCBtYXhJdGVtcy4gRm9yIHNlcGFyYXRlIHBhdGNo
LCB5b3UgbWVhbiBzZXBhcmF0ZQ0KPiA+IGFkZGluZyBkZXNjcmlwdGlvbiBmb3IgaS5NWDhNTSB0
byBvbmUgcGF0Y2gsIHJpZ2h0Pw0KPiANCj4gSSBtZWFuLCBhIG5ldyBwYXRjaCBkb2luZyBjbGVh
bnVwLiBZb3UgY3VycmVudGx5IGhhdmUgbWluSXRlbXMgYW5kDQo+IG1heEl0ZW1zIHNldCBhcyB0
aGUgc2FtZSB2YWx1ZS4gSW4gc3VjaCBjYXNlIG1pbkl0ZW1zIGlzIG5vdCBuZWNlc3NhcnkuDQo+
IFlvdSBjb3VsZCByZW1vdmUgYWxsIG9mIG1pbkl0ZW1zICh3aGVuIGVxdWFsIHRvIG1heEl0ZW1z
KSBiZWZvcmUgYWRkaW5nDQo+IG5ldyBkZXZpY2Ugc3VwcG9ydC4NCg0KVGhhbmtzLCBnb3QgaXQu
IEkgd2lsbCB3YWl0IGZvciBhIGZldyBkYXlzIHRvIGNvbGxlY3QgY29tbWVudHMgb24gb3RoZXIN
CnBhcnRzIGJlZm9yZSBWMy4NCg0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0K
