Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3F573200
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiGMJE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiGMJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:04:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED01C052E;
        Wed, 13 Jul 2022 02:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9T+z/klhtv/pJx0uvoauq4PcGEWu7PCblHhPE8mZz2kY1MD2OObmspkmwsZxk2FcnwjkTxthkSKN3dPD3qXuGIkMurtH5UzSE6bI2Ijfp92KMKlrKU5mley+1QG21o4FDlxVcBDojq3jbgNTFtrq588zqM6Nn2AO7Xs1QSmqq5jfMWeyoeNYCcEDf9piwHl0bN3LX7mYmtrX8CaVDo8SaxGKxUXq5thPpv1KMogNL8l3UbCPOLk0Z8TItj4SDyE9bm4DHuBoTPrB+V9yHYsVBvZ2iawNOtKNqwweghFkx8MJ6BQWt/1TJygBHoMyqXk/tcu6pKEGBOjlD4QH4NNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMf46C/t7nr5sB+yD58/4DHrRZEaXoua+zdAJTCj1+0=;
 b=N+DNE9xhtBeM4JWT3W4wSh6EQigraBeFZGbvvMxo191eRzI/p2ZTSVO+cXfp2ZSGTUkde6EYH0mkzblDX8gvX6lfQkbCnQ6g1rBxAn3NUIrqjFn2DpkJtX7iqrH33G+zBkH7aKYOiVdHZZ103EOSsVYQspEb6m1slBzhEwCZoVXHS4mUwexWd598zgyLKWxerqrrPYMCsjUR576SKlqBeYCzf3W6DmFt7q9foVZ0bQhB0XvOOK+sPma6gAMMYZHyepssd0Y2HbI/Qzlalqiw77NL3jB8c2KLoWGlghHqWWS5V7B6SsqY+6FetHdjXAj6oopCWT2zapYUzn5uFcYmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMf46C/t7nr5sB+yD58/4DHrRZEaXoua+zdAJTCj1+0=;
 b=HXlC2QNDr6573bXmc9LQCW1J30d4xc3cKZZzn5Xmt4H/5Zw0KEhADh07HJJIj5cQcIVzPpAnQlMreZR4oPD7ggu6GLRRKdLjMejYd2gdq2MU3+p512eHLwiow7oRjvYI4BSEXap1zdhV9KTLw+U/xOAcOyaL2kGl4iys10RpX6k=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 09:03:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 09:03:55 +0000
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
Thread-Index: AQHYloK947kv/SqebUO7q2Flj5l6V617+EgAgAAIoDA=
Date:   Wed, 13 Jul 2022 09:03:55 +0000
Message-ID: <DU0PR04MB9417D42EDC6FD08C10C164CB88899@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
 <20220713063653.2584488-3-peng.fan@oss.nxp.com>
 <52c0d236-49c6-7c31-abd8-2a083ca7ef8c@linaro.org>
In-Reply-To: <52c0d236-49c6-7c31-abd8-2a083ca7ef8c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 399d97a2-7491-4885-a5bc-08da64ae9d4f
x-ms-traffictypediagnostic: AS8PR04MB8993:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hutU/cfdtfDln8Y0X7ns0vywSYep4brAOQuOK+jGdeZ32mSC8UCttNWvsA5l42WPjVFXCvdjzNHbARUF3+xXwXmS/+QTR0nsOgwacHvru3NYE0ixnoeg9TVc9Avqvo8xaSkIxysRp3JhonjK7cxv/F0LFA1cIlbsrEoTm4nho/tZZBudwNmp9BfdU05nWaLJF7NlMpuUXYPa7yIIazIOaF7BuBLTJ6cnEDY1AGOW7zOPqjJQ1cPtJMaFuQXs4x8vJV27QueFw5mcYVN+UvN8gom/xcM0bmo9lW+rvNopJ0C4mDq3tYc27NfDdBGjeHMv6PNdPXkN+/TuAFykkj6rF7FRIgyLsOLSBs+zVA0jj6khfMw4k+smL3CKzw/Jo1dD/I+VR7x63ntX7PVLag+1LCQSiOUeRE/vRV8tnKwUJItoMLZGrH0BZjksvrUJ98ogTznFOG2QvmqqM6/eQ9auLUVQl0MgmNEkBEy/0/vuPl8AO4MusUbyoSOnMPqf4MUqhV5uFHj90O0KmGKBXY3Y4FZAXn8y/2sbeYp7IWdQ67AXR3GHV7YvXJ0c9My1CV0ohFamdYdWTpp0qlZ5JHFGkv32x0q6tpmddO5RI6zuPukzCcNICuxkU/6SPyQljClEQitRcrpNZvFtYy+ri8thvCBGKI90KGOaZlJlHaE0t6OCvycZoLlY5dPGk22i7FWnwqS+IknTf2z7AcKlS1u6O7+kvr3YB33j8TdUHMKt8Sd8Lp+8V3N3Gl3woEfY0F/QjqG3kZrVa+5N5CFNv3kz0ByKdD5YIBrL0QUYAI42QGuTctfHqGcf+pHQbGRj0egH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(122000001)(7696005)(6506007)(9686003)(41300700001)(26005)(53546011)(478600001)(8936002)(38070700005)(5660300002)(44832011)(52536014)(71200400001)(7416002)(38100700002)(66446008)(4326008)(33656002)(8676002)(66556008)(76116006)(83380400001)(316002)(110136005)(54906003)(186003)(64756008)(66476007)(2906002)(55016003)(66946007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE5oVUN3dmFySytIUlFnY3U4Y0lKL09RcUl2a05JN0swYVlIeFhWTnFTMmxO?=
 =?utf-8?B?QS8vemdCemIvbThzQTROYjBvQ1QxY3VtemlWckJUZnZBWkhJY3BJYi8vcW9k?=
 =?utf-8?B?SHVjM2N3b3lrVXU4d1luUHAwNkwzY283YW5NQkdvTlpmamtnMVZDTDdMQldq?=
 =?utf-8?B?WVlib3FEdE9kNHp2N3BnZHp0M0pDU0NvbGtPdDUzSmpLT0tNNDRMcDIyN0dK?=
 =?utf-8?B?VllsN2lGdytUakNadlpQOWhrNFhGNEl2cDhhbVBSUytNcGpZS2hhS2lMYjlF?=
 =?utf-8?B?YnBHQkNSWWUzMnFlWHZjV3k3YXV3am5FZHhmRnY3ZEN5VXdsKzh3VHIxdjhZ?=
 =?utf-8?B?c2lPZnBvTVZ2M0NqYkdCR3hPbWhNZGdpaDBwM2VOSktFQTNNSUpNVUtrMmdZ?=
 =?utf-8?B?bmpyaHpDeU53YXErOFVrSnhkTHVINVN2TEJWZ0lyNCt5VWNmTzB5d29hTFBV?=
 =?utf-8?B?L0NqZVU1MlFoRzhFT3NDTmpTZkRoaks3cjBUZnNrK004WERpeFFZT3BZaUsr?=
 =?utf-8?B?alJVRXI3MDMrK0J4c1RTc2FWa0ZnZGFIYU01enJwOXM4U21iYTRkYldrWEpp?=
 =?utf-8?B?emRaM3pnbkh1YmpLN3ZYUk5TOTZuelgvSlNtRFpGdjJoZzVhQUFCQm9NVGVE?=
 =?utf-8?B?cU5UTlByejVpNUN2RlI3MDh0TGtYZnFtNHIvOHM5TTNPbmpVU3FNa01TcUhi?=
 =?utf-8?B?NnNaQlZzOVI4SHpQT1k1UXFPVWwzeGZGcWRCaFpDakY2cjB0NXBiUTk1WmFC?=
 =?utf-8?B?bDAwUG1PSWFYUnBlalZnREFyOWV4SldsMk4yUXRWWDRGdHRPdDh4aXQwUFJ1?=
 =?utf-8?B?em5tM2E1N2VhaVB1RW1CZUdrc29ha2dxNHU4L20wVFY0bG16MWxqQnl1aEVP?=
 =?utf-8?B?WWtTUE1ZektKWlk3UGFUa1pGQzdaUXl0Y3lXenorWTZ2OUVITkkzVGFRc21z?=
 =?utf-8?B?M3daeDFjRWthYi9NcWNlbmtXL3cxQy9wYVNXNi8vamxhWHpyQXFjcTZrMUFW?=
 =?utf-8?B?YmErOWFNZW83N0tpbXVPZGc0UmVjd3N1SStRNnFLbWF6dWdvVnZ1Q0JxVmZG?=
 =?utf-8?B?Z3E3TGcwdnJMeG9zTzcvM3lKY2Z3Z1BIZ3JCdTZ6T2pCeXNwdmpMTVE5cTBS?=
 =?utf-8?B?VGc0SVJteWRZbURUcTJvNVRybUY5R0c0QWJGcGlDWGxIUkZWTXpSekxnb2xi?=
 =?utf-8?B?em02ZC8yTGthM2hWaEFocVUrb0hHRlJBQkpnRkdZdUt1Rkl5M2ZLUFBMclVQ?=
 =?utf-8?B?c3hjTDE0b2luOWFkTFIvWGhkNEs0cU5ZNXhRSTJralJzaTBuemFNSHNrR1hp?=
 =?utf-8?B?ZWhpTHYzL0VTa1VLMXhMNGpMSjNyQjV5RXY1RjMrN1lpZ295NWtxM2RrRGYw?=
 =?utf-8?B?ZnRMeSs2VC80N0tMR1gybmFtbWlsTEI0bFR5d01KVXRrVmJqTEZ1cDBmRExh?=
 =?utf-8?B?dUxjeWJJRXNmencrUUVvOVlvemhxRG94REJKL2lqTmd5TjRkMklLemxsRGxl?=
 =?utf-8?B?VW5sUi9SQnQ2aEFTcDhqdkdISXFlWFRlc3dmZG1RY2ZOUkQwcWVHVHRCNkFv?=
 =?utf-8?B?UUROeFVlRlQ2STJKVzkxKzBxcWdSaXNLQ0RrdmVOUnpWdVZrZFJ4U2dRYW4x?=
 =?utf-8?B?VEppeURlLzE4cElWakNBcFVOaG9RRDNNd3UrWGVtTTJrcTRQczVUb01KTzc0?=
 =?utf-8?B?azE0Unk0VkZ3ckZUaUI2OGxEWXZnUGFlay90enJYV0l0cm5MSUdUQi80R3hr?=
 =?utf-8?B?K2pzRkJ6QjZXdWsrWDc5RCtYbWJ0UmtHS1JoK2ppWnUyRDgvTlZvdUF0T0Ju?=
 =?utf-8?B?bTlZTDQ3K1pJcWRhWDh2YUpEQnV2SHZ0THJyK2NHZmpncTVGUnpaQzBSUmVl?=
 =?utf-8?B?S1ZLbUhEWmxiU1hQRjgrUFdTTHVPL080WlpQMC82NDJ4WUVWVllMZHplMngx?=
 =?utf-8?B?UGJiNC9aYjY3VDhwZUluQU1tWDNtUjBvcTk0Zi8xd0x4bzFtK1ViYXNkdzdL?=
 =?utf-8?B?dG5UbW1FU1hvVUJ4Mzc1M0tDaGgyalNaWjdleHN4S2RkZmFISFo0ajJ1cFl4?=
 =?utf-8?B?cGVxVjVwWHZndzZqN2Q3VVlOM0R4djA3ZXFqeTlHVWVPeDhjTFBXRjFtYmd2?=
 =?utf-8?Q?+mbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399d97a2-7491-4885-a5bc-08da64ae9d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 09:03:55.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nkPBG1duRzZhJiqJRsYAf2zrzGHScGGDj5W8ln6xuMIdUzD/rgBXUj7C7fBFVP/xXca1qCywA5obbxbbx4Ayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi82XSBkdC1iaW5kaW5n
czogc29jOiBpbXg6IGFkZCBpLk1YOE1QIHZwdSBibGsgY3RybA0KPiANCj4gT24gMTMvMDcvMjAy
MiAwODozNiwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOE1QIFZQVSBibGsgY3RybCBtb2R1bGUgaGFzIHNp
bWlsYXIgZGVzaWduIGFzIGkuTVg4TU0sIHNvIHJldXNlDQo+ID4gdGhlIGkuTVg4TU0gVlBVIGJs
ayBjdHJsIHlhbWwgZmlsZS4gQW5kIGFkZCBkZXNjcmlwdGlvbiBmb3IgdGhlIGl0ZW1zLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gIC4uLi9zb2MvaW14L2ZzbCxpbXg4bW0tdnB1LWJsay1jdHJsLnlhbWwgICAgICB8IDkz
ICsrKysrKysrKysrKysrKystLS0NCj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9pbXg4
bXAtcG93ZXIuaCAgICAgIHwgIDQgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDg2IGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9pbXgvZnNsLGlteDhtbS12cHUtYmxrLQ0K
PiBjdHJsLnlhDQo+ID4gbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zb2MvaW14L2ZzbCxpbXg4bW0tdnB1LWJsay0NCj4gY3RybC55YQ0KPiA+IG1sIGluZGV4IDI2
NDg3ZGFhNjRkOS4uZDA1OTMwZjYxZjk1IDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9pbXgvZnNsLGlteDhtbS12cHUtYmxrLQ0KPiBj
dHJsLnlhDQo+ID4gbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc29jL2lteC9mc2wsaW14OG1tLXZwdS1ibGstDQo+IGN0cg0KPiA+ICsrKyBsLnlhbWwNCj4g
PiBAQCAtMjgsMjQgKzI4LDE1IEBAIHByb3BlcnRpZXM6DQo+ID4NCj4gPiAgICBwb3dlci1kb21h
aW5zOg0KPiA+ICAgICAgbWluSXRlbXM6IDQNCj4gPiAtICAgIG1heEl0ZW1zOiA0DQo+IA0KPiBU
aGlzIGlzIG5vdCBjb3JyZWN0LiBtYXhJdGVtcyBtdXN0IHN0YXksIGJ1dCB5b3UgY291bGQgZHJv
cCBtaW5JdGVtcywNCj4gcHJlZmZlcnJhYmx5IGluIHNlcGFyYXRlIHBhdGNoLg0KW1BlbmcgRmFu
XSANCg0KT2ssIEkgd2lsbCBvbmx5IGtlZXAgbWF4SXRlbXMuIEZvciBzZXBhcmF0ZSBwYXRjaCwg
eW91IG1lYW4NCnNlcGFyYXRlIGFkZGluZyBkZXNjcmlwdGlvbiBmb3IgaS5NWDhNTSB0byBvbmUg
cGF0Y2gsIHJpZ2h0Pw0KDQo+IA0KPiA+DQo+ID4gICAgcG93ZXItZG9tYWluLW5hbWVzOg0KPiA+
IC0gICAgaXRlbXM6DQo+ID4gLSAgICAgIC0gY29uc3Q6IGJ1cw0KPiA+IC0gICAgICAtIGNvbnN0
OiBnMQ0KPiA+IC0gICAgICAtIGNvbnN0OiBnMg0KPiA+IC0gICAgICAtIGNvbnN0OiBoMQ0KPiA+
ICsgICAgbWluSXRlbXM6IDQNCj4gDQo+IG1heEl0ZW1zIGluc3RlYWQNCg0KR290IGl0LiBXaWxs
IG9ubHkga2VlcCBtYXhJdGVtcw0KDQo+IA0KPiA+DQo+ID4gICAgY2xvY2tzOg0KPiA+ICAgICAg
bWluSXRlbXM6IDMNCj4gPiAtICAgIG1heEl0ZW1zOiAzDQo+IA0KPiBTYW1lIGVycm9yLi4uDQpH
b3QgaXQuIFdpbGwgb25seSBrZWVwIG1heEl0ZW1zDQoNClRoYW5rcywNClBlbmcuDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
