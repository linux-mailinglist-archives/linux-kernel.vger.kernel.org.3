Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AEA4671C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 07:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378545AbhLCGFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 01:05:20 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:49604
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231182AbhLCGFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 01:05:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HREq87dPmh8K8uH9wrNe0rKucsC68DToAIhHjtpWvyL2KSczrHuBk0B8pp9BK06DdB/iIjjzvOeWYB6raE/tsXQGgpsmRaf4eTaLg1A7EKNd5gR9dUYDOvKqLqxGMATPBuA92VIKT0e5EsoditGDI/Jg3oc+x+oG/5GpIjkEOn0C/FIDMul32Q7FAlE7j8Kv0PA7jD8aXCf3vGV0hQERUCdoSQaf8EjSldvHdwJEbty6bpHpvAmA7EjXPMvfVk+RKOA4C/QCeWS/RbWtMBWhk4a69ynxnyieQctOelWkybj7XONLIwEX5VgISm2FHZt/MlOKoEEMfyyPl7CmckHgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/46iWpGwxgVxwOFiCrERzP5orf1wq98yMKgLDzCO6dI=;
 b=XVLr9/c8maXYMdq8dUoMlAiNtWXSvX1gRykqBhbyYm/9YxS5RxSVFSRFTXc5CpyekYjGfRL1xRQcnb22XOvK84XXH7M6tjL2NbnyGbb5zDjXh3jAFU2BNHQwbeki4otOP3LGuPwUfMSSxTrCGTIf0wcfpqKWGitwgxKJFXdoszb29IvFfvbGfeB9RAJ/hR4WiPfSyUrPa9owjC9t7Fb4g5iQtua7T7WEz8Cv+r6U2x6fB/bAjZsIuAnD9yL1aBx6Y5CUbc9WAcPJGDlJ8oCWuUYBNGFN4Mm0OdYJ3+PPWahw5ykVHS6lCVxu67u901QmBKicPT4lMTIrH/Kn7Hq5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/46iWpGwxgVxwOFiCrERzP5orf1wq98yMKgLDzCO6dI=;
 b=JJgCDXnWJaEbA46UpoJ155Tgu5TH3+B7RqzlQi5rM4Pc980LDhlaZ2ktct0n8j97xPepV4SBwWnlB0JEY/nTDg5VLAd8sEwRvwh2bZ0WyN3dA2mxGXINR12WxFhZPlurVSy+HOIhPWc9RvHUnInnra5a5eAvIimNfBJAMB14f8Q=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 06:01:53 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 06:01:53 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v13 08/13] media: amphion: add v4l2 m2m vpu
 decoder stateful driver
Thread-Topic: [EXT] Re: [PATCH v13 08/13] media: amphion: add v4l2 m2m vpu
 decoder stateful driver
Thread-Index: AQHX5c0LA8QwmwTrsU+sSndqn0F2gawgOGoAgAAIJXCAAAkU4A==
Date:   Fri, 3 Dec 2021 06:01:53 +0000
Message-ID: <AM6PR04MB6341537EBD82451CA14A5E3EE76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
         <9122e66af668c095548321d45dec33a3fd6ee77d.1638263914.git.ming.qian@nxp.com>
 <fceda1576bcb2fc4e576b59e09214ab1320558b3.camel@ndufresne.ca>
 <AM6PR04MB6341AC4C0057B09DB8A58234E76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB6341AC4C0057B09DB8A58234E76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc4cbd0a-ba51-426b-d19d-08d9b622679a
x-ms-traffictypediagnostic: AS8PR04MB8198:
x-microsoft-antispam-prvs: <AS8PR04MB81980F5A99B62449C430FEA0E76A9@AS8PR04MB8198.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 37CbWnqWWZgrl5RgGLeAc9M72pcSQlgSgRT6kA8NJYXzJw8sctoiVQsioOimK+PUqALX6AVuQmFqmh2aBhdfkp1OjHvKpUGgBPInORKl3lsB9j/UjtEyfd9NYMS2qB1abi6LasQuCujtGlL+eqTcIWCyq4itl25RKXDKd7OoZkF92N6z/W68DpS8bPoBZ0P+cjNxL9UOhLNZHSep98CVK8V5XloRgQBiIvkVCxD9Y3EzYYfFoP2A43QqstRq/iSptHOr5WJ1zgiXL4jn87Kz1hSRacy9PJq2a7qSBbT1nFBOe/k6wm9V9/2ChgkOvQDBgGHvZYkqy7i5CTmwrvNwOONNrWhppKrv+CkIrvhDTX3MDK1lNSOwb3XsAo+CKYVg7DxshN1CoHLC+VmsBK4AEjPBwpy4ljnPF+PKgs37ezd0fhW1UNyfpIdDzzMPqZQvJR8ykqDyFPNuTpAEXoKMmaV0zrL9P7/ShNW9fhlJOuwWocaqFXWEIVZTuqFUo3z50+uAlIzungZ31DKw/MHiFollY3azc7ZSn/su90V2wBEc2NYRCZyUIE0I6YBmunKAilfRf5On0ssZSjs0hsJYXCwPFR7lTGHMEnc4ZhBhtmQSppiStCMlbp2sb6raJtnH2XXvucrejJIzJn8Jih7N3THaaP9L0GCUvhxXGN0hOwMsob6ZwxaHdZasNsby+tDdx/kxnNQJj6UlLUrtsykX6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(110136005)(186003)(66946007)(8936002)(7696005)(86362001)(8676002)(53546011)(122000001)(6506007)(38100700002)(9686003)(33656002)(66556008)(5660300002)(2906002)(44832011)(83380400001)(55016003)(54906003)(64756008)(52536014)(4326008)(66446008)(66476007)(7416002)(508600001)(76116006)(316002)(2940100002)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzBwQmVmWEdvZmJuYjNNV2JEZ2x2eFdKVklIWkFBN0hEZ0pkMk5GMHozODBK?=
 =?utf-8?B?bWt4VFhSU1NUUWdqdWlkeTVTT1g3K1hrZWovWnZsRm5mbGlVZjBpQ1Q4WFhy?=
 =?utf-8?B?UXRrcXErbEtpRmtaL2NKN0lDS0JPb1RJZGxNRitYUFNlREZqMGttQnVGd1dw?=
 =?utf-8?B?aHRtcE1acCtqUjVUenJxak5Iamo1bTJxTkVtTzQ1Nis3TkFHMmxZN2ltL0g2?=
 =?utf-8?B?WitMYU1HcUJJRTQ4K0xLWXhPT3FPSWxEOEN5Y1ZWRnlVV2JpbUo0WVlOSjNm?=
 =?utf-8?B?bVByeGRHNE9nRGVNRERxa3pnMENaWEVTU0NWbGI2Ky9NUDhmUzRWVU1wSnBx?=
 =?utf-8?B?K3JaUkNWbi9WT3hyTW00V3ZFNzhDQk5zVnJuc24xTVBVcWRlMWpOc1NGK1Vl?=
 =?utf-8?B?WHNYRHZlR1R2TmJHOVl3RnpRY0p6eVdsTFBmeFNoZW5nUHVyZTdzMGtoZzRB?=
 =?utf-8?B?eUpPY1JkVUdMdjJXK0I4K2VNYnBnTG1MZmVvTWxSbVpsKzlHdkRlSVc3Y1Z5?=
 =?utf-8?B?YVRXWDBpZDhSV0t0ekkyaHpFT256ZHVqU0lMOFRXWEJ5UXRDMVRRakhQR0pl?=
 =?utf-8?B?K0gvUU93NjN0WWRnTVlWMkc1MHhRUzdVcFpENkpiY0tVYVJLVm9WY3JHcGlQ?=
 =?utf-8?B?ajdlblpER2VGZmM2dW5LcERFOU1jaTNYdkJ3c2d3Si9TQUZsd3d1LzJxTE5l?=
 =?utf-8?B?TllUQVd6ZzNXcU10Sk1Jc25uaG82TEIwRnJOZ1AvenRmbHB2dUoxdjRiQjFw?=
 =?utf-8?B?bElCVytRMko5UThSWU4wZHpyOFZYOHFJWDdaYklIa1d5VmpZNjhPWXlxTktT?=
 =?utf-8?B?S3pUZmp0UzhDdldLV1lpTFpURTNjL2FrMkhXSTUzRC9jVUo3ZmtrMW5yRjRm?=
 =?utf-8?B?WDYwWHZJTVFzWlRiL0NXaUdpUzcyR2RoVXE3R1lya1pYUjlsdmRxRnBxOFJH?=
 =?utf-8?B?Y3F5OS85dDZ5YkZEOS9hU2ljNGZjdGg2bXZHV0lnZzQ4eS91Tk8vbmg0OHVE?=
 =?utf-8?B?NU9QcFBxUjM1cmJTU08rR1hWVXY4MVVra2xCWnViT01qRTlPODJqTE01VEM1?=
 =?utf-8?B?VVNYRW05T1ZNQnNFblBnOUpiaktIeHl4K1JuOXdXcjNlbHNpWkw0OTZ1UlZ5?=
 =?utf-8?B?WUpNTnFtU3JkSmhpQ3JhalZBb3NWUzlJbjFsMHVkcGxDM08wT1MvMHg4VXRP?=
 =?utf-8?B?c1ZmemYwd29GeVBFR0lmN2I2L093MEN2TW5Yc0dYaC9HekNibURjU3VkdERS?=
 =?utf-8?B?R3lJQnhvcmtaWHRCczdhVFMzQTFhc3QyV3U2bG1xanhlWmE5dVhRYnNOMkNm?=
 =?utf-8?B?RFZMbGlEazR0V2pzYkFrQ1VFWGFKNjhONFJiTTNKTDArT1U5am5JSnJNSmpk?=
 =?utf-8?B?OWh6dUVFV09aN3BIZS9HeGgzaGVURnhyck92aHp5djFoVGo2TjFINFJMWldQ?=
 =?utf-8?B?MUdLRytKcWtvcjQ1aWFORHZLNGNoc0tLQ0Y2elozejRaMlp0SjhNOElMNUpI?=
 =?utf-8?B?azhhbys3ck9MZlVQQTJyYjRDZkhpbGIxNE0wUWxBbmtaQTZQOXNBSnhyMTM5?=
 =?utf-8?B?NjFya1hibWJVcHZJdy81am9CcUF1WlNCUjc4VWY0Y0lvTnhpYVd0bnRzSTYw?=
 =?utf-8?B?K2k0Vjd2TlZFQmZZQ2xabWNidkJxcmZ1d2lXS1BWOFNPeE11VXZQRFR4eFdQ?=
 =?utf-8?B?akFSS3BMZGRuRTB4RWlHalJWYTVaNjVqalFQU0pkSE1XZ3lJdXp5dFYxaGRN?=
 =?utf-8?B?dDc3S21sRENva3cydUNIL3pqaHVBbk9SNkpSUkRCM1dzb1piRTRRUXBXM2p5?=
 =?utf-8?B?U0NJSGNrRkdCTHphbGtBemN2bzQ2M0tWc1RqME9uYnNtazVWcjNwNk82emlt?=
 =?utf-8?B?OVZKeGMyenMycThQVVY5Y0pGZ3I1TTV6QkN4bmxyandiSVcvOUJPQ1hJbnpO?=
 =?utf-8?B?dUJxZjl6K2VZMWV2QkNyeWhFOTdRSy9LbEFtRWEzSG5VaEptZkFxdjR5azBi?=
 =?utf-8?B?cWU2TzJBSzVpRE1vbnIwbmdEUzU3UkRmdHpEV2p6VnE1bFEzL3pVY2k3VWYr?=
 =?utf-8?B?c1d3Um9hbEpyV0xRN2dxT1VGLzcwYnN1TGl1Q3RPSWxVdHpoL3FrdHdNbE5x?=
 =?utf-8?B?cTZNVVBDbVdlVERuL0dFVUtWTUhVak91d2Vkb2U4bzFsWHRQbnNuMkcwUFJG?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4cbd0a-ba51-426b-d19d-08d9b622679a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 06:01:53.1959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fW+h0Ib29k5HqAMEE08MV36zzSWp1m+PoLvSjMIViJlITpfrlE5kBxbh6RNd0kg+tnDmMKoXNao1pEwElhsl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8198
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaW5nIFFpYW4NCj4gU2VudDog
RnJpZGF5LCBEZWNlbWJlciAzLCAyMDIxIDE6NDMgUE0NCj4gVG86IE5pY29sYXMgRHVmcmVzbmUg
PG5pY29sYXNAbmR1ZnJlc25lLmNhPjsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0Br
ZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4g
Q2M6IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubDsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0
ZXZhbUBnbWFpbC5jb207DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBBaXNo
ZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsNCj4gbGludXgtbWVkaWFAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1Ympl
Y3Q6IFJFOiBbRVhUXSBSZTogW1BBVENIIHYxMyAwOC8xM10gbWVkaWE6IGFtcGhpb246IGFkZCB2
NGwyIG0ybSB2cHUNCj4gZGVjb2RlciBzdGF0ZWZ1bCBkcml2ZXINCj4gDQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBOaWNvbGFzIER1ZnJlc25lIFttYWlsdG86bmlj
b2xhc0BuZHVmcmVzbmUuY2FdDQo+ID4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAzLCAyMDIxIDEy
OjU2IFBNDQo+ID4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hlaGFiQGtl
cm5lbC5vcmc7DQo+ID4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlDQo+ID4gQ2M6IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubDsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcgRG9uZw0KPiA+IDxhaXNoZW5nLmRvbmdA
bnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BB
VENIIHYxMyAwOC8xM10gbWVkaWE6IGFtcGhpb246IGFkZCB2NGwyIG0ybSB2cHUNCj4gPiBkZWNv
ZGVyIHN0YXRlZnVsIGRyaXZlcg0KPiA+DQo+ID4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+ID4NCj4g
PiBMZSBtYXJkaSAzMCBub3ZlbWJyZSAyMDIxIMOgIDE3OjQ4ICswODAwLCBNaW5nIFFpYW4gYSDD
qWNyaXQgOg0KPiA+ID4gVGhpcyBjb25zaXN0cyBvZiB2aWRlbyBkZWNvZGVyIGltcGxlbWVudGF0
aW9uIHBsdXMgZGVjb2RlciBjb250cm9scy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBN
aW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2hpamll
IFFpbiA8c2hpamllLnFpbkBueHAuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWmhvdSBQZW5n
IDxlYWdsZS56aG91QG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2FtcGhpb24vdmRlYy5jIHwgMTY4MA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gDQo+IA0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyB2b2lkIHZkZWNfaW5pdF9mbXQoc3Ry
dWN0IHZwdV9pbnN0ICppbnN0KSB7DQo+ID4gPiArICAgICBzdHJ1Y3QgdmRlY190ICp2ZGVjID0g
aW5zdC0+cHJpdjsNCj4gPiA+ICsgICAgIGNvbnN0IHN0cnVjdCB2cHVfZm9ybWF0ICpmbXQ7DQo+
ID4gPiArICAgICBpbnQgaTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIGZtdCA9IHZwdV9oZWxwZXJf
ZmluZF9mb3JtYXQoaW5zdCwgaW5zdC0+Y2FwX2Zvcm1hdC50eXBlLA0KPiA+IHZkZWMtPmNvZGVj
X2luZm8ucGl4Zm10KTsNCj4gPiA+ICsgICAgIGluc3QtPm91dF9mb3JtYXQud2lkdGggPSB2ZGVj
LT5jb2RlY19pbmZvLndpZHRoOw0KPiA+ID4gKyAgICAgaW5zdC0+b3V0X2Zvcm1hdC5oZWlnaHQg
PSB2ZGVjLT5jb2RlY19pbmZvLmhlaWdodDsNCj4gPiA+ICsgICAgIGluc3QtPmNhcF9mb3JtYXQu
d2lkdGggPSB2ZGVjLT5jb2RlY19pbmZvLmRlY29kZWRfd2lkdGg7DQo+ID4gPiArICAgICBpbnN0
LT5jYXBfZm9ybWF0LmhlaWdodCA9IHZkZWMtPmNvZGVjX2luZm8uZGVjb2RlZF9oZWlnaHQ7DQo+
ID4gPiArICAgICBpbnN0LT5jYXBfZm9ybWF0LnBpeGZtdCA9IHZkZWMtPmNvZGVjX2luZm8ucGl4
Zm10Ow0KPiA+ID4gKyAgICAgaWYgKGZtdCkgew0KPiA+ID4gKyAgICAgICAgICAgICBpbnN0LT5j
YXBfZm9ybWF0Lm51bV9wbGFuZXMgPSBmbXQtPm51bV9wbGFuZXM7DQo+ID4gPiArICAgICAgICAg
ICAgIGluc3QtPmNhcF9mb3JtYXQuZmxhZ3MgPSBmbXQtPmZsYWdzOw0KPiA+ID4gKyAgICAgfQ0K
PiA+ID4gKyAgICAgZm9yIChpID0gMDsgaSA8IGluc3QtPmNhcF9mb3JtYXQubnVtX3BsYW5lczsg
aSsrKSB7DQo+ID4gPiArICAgICAgICAgICAgIGluc3QtPmNhcF9mb3JtYXQuYnl0ZXNwZXJsaW5l
W2ldID0NCj4gPiB2ZGVjLT5jb2RlY19pbmZvLmJ5dGVzcGVybGluZVtpXTsNCj4gPiA+ICsgICAg
ICAgICAgICAgaW5zdC0+Y2FwX2Zvcm1hdC5zaXplaW1hZ2VbaV0gPQ0KPiA+IHZkZWMtPmNvZGVj
X2luZm8uc2l6ZWltYWdlW2ldOw0KPiA+ID4gKyAgICAgfQ0KPiA+ID4gKyAgICAgaWYgKHZkZWMt
PmNvZGVjX2luZm8ucHJvZ3Jlc3NpdmUpDQo+ID4gPiArICAgICAgICAgICAgIGluc3QtPmNhcF9m
b3JtYXQuZmllbGQgPSBWNEwyX0ZJRUxEX05PTkU7DQo+ID4gPiArICAgICBlbHNlDQo+ID4gPiAr
ICAgICAgICAgICAgIGluc3QtPmNhcF9mb3JtYXQuZmllbGQgPSBWNEwyX0ZJRUxEX0lOVEVSTEFD
RUQ7DQo+ID4NCj4gPiBBcyBhIGZvbGxvd3VwLCB0aGlzIHNob3VsZCBiZSBjb25kaXRpb25hbCB0
byB0aGUgY2hvc2VuIHBpeGVsIGZvcm1hdC4NCj4gPiBJZiBJIHVuZGVyc3Rvb2QgY29ycmVjdCwg
eW91IHByb2R1Y2UgaW50ZXJsYWNlZCBpcyBvbmx5IHByb2R1Y2UgZm9yDQo+ID4gbGluZWFyIE5W
MTIsIGZvciB0aWxlZCB0aGUgZmllbGRzIGFyZSBvdXRwdXRlZCBzZXBlcmF0ZWQgaW4gdGhlaXIN
Cj4gPiByZXNwZWN0aXZlIHY0bDJfYnVmZmVyLiBOb3RlIHN1cmUgd2hlcmUgeWV0LCBidXQgdGhl
IFY0TDIgc3BlYw0KPiA+IHJlcXVpcmVzIHlvdSB0byBwYWlyIHRoZSBmaWVsZHMgYnkgdXNpbmcg
dGhlIHNhbWUgc2VxX251bSBvbiBib3RoLg0KPiANCj4gVGhlIGFtcGhpb24gdnB1IHdpbGwgc3Rv
cmUgdGhlIHR3byBmaWVsZHMgaW50byBvbmUgdjRsMl9idWYsIFNvIEknbGwgY2hhbmdlDQo+IFY0
TDJfRklFTERfSU5URVJMQUNFRCB0byBWNEwyX0ZJRUxEX1NFUV9UQg0KPiANCg0KSGkgTmljb2xh
cywNCiAgICBTZWVtcyBnc3RyZWFtZXIgZG9lc24ndCBzdXBwb3J0IFY0TDJfRklFTERfU0VRX1RC
IHlldC4NCg0KICBzd2l0Y2ggKGZtdC5mbXQucGl4LmZpZWxkKSB7DQogICAgY2FzZSBWNEwyX0ZJ
RUxEX0FOWToNCiAgICBjYXNlIFY0TDJfRklFTERfTk9ORToNCiAgICAgIGludGVybGFjZV9tb2Rl
ID0gR1NUX1ZJREVPX0lOVEVSTEFDRV9NT0RFX1BST0dSRVNTSVZFOw0KICAgICAgYnJlYWs7DQog
ICAgY2FzZSBWNEwyX0ZJRUxEX0lOVEVSTEFDRUQ6DQogICAgY2FzZSBWNEwyX0ZJRUxEX0lOVEVS
TEFDRURfVEI6DQogICAgY2FzZSBWNEwyX0ZJRUxEX0lOVEVSTEFDRURfQlQ6DQogICAgICBpbnRl
cmxhY2VfbW9kZSA9IEdTVF9WSURFT19JTlRFUkxBQ0VfTU9ERV9JTlRFUkxFQVZFRDsNCiAgICAg
IGJyZWFrOw0KICAgIGNhc2UgVjRMMl9GSUVMRF9BTFRFUk5BVEU6DQogICAgICBpbnRlcmxhY2Vf
bW9kZSA9IEdTVF9WSURFT19JTlRFUkxBQ0VfTU9ERV9BTFRFUk5BVEU7DQogICAgICBicmVhazsN
CiAgICBkZWZhdWx0Og0KICAgICAgZ290byB1bnN1cHBvcnRlZF9maWVsZDsNCiAgfQ0KDQo+ID4N
Cj4gPiA+ICsgICAgIGlmICh2ZGVjLT5jb2RlY19pbmZvLmNvbG9yX3ByaW1hcmllcyA9PQ0KPiBW
NEwyX0NPTE9SU1BBQ0VfREVGQVVMVCkNCj4gPiA+ICsgICAgICAgICAgICAgdmRlYy0+Y29kZWNf
aW5mby5jb2xvcl9wcmltYXJpZXMgPQ0KPiA+IFY0TDJfQ09MT1JTUEFDRV9SRUM3MDk7DQo+ID4g
PiArICAgICBpZiAodmRlYy0+Y29kZWNfaW5mby50cmFuc2Zlcl9jaGFycyA9PSBWNEwyX1hGRVJf
RlVOQ19ERUZBVUxUKQ0KPiA+ID4gKyAgICAgICAgICAgICB2ZGVjLT5jb2RlY19pbmZvLnRyYW5z
ZmVyX2NoYXJzID0gVjRMMl9YRkVSX0ZVTkNfNzA5Ow0KPiA+ID4gKyAgICAgaWYgKHZkZWMtPmNv
ZGVjX2luZm8ubWF0cml4X2NvZWZmcyA9PSBWNEwyX1lDQkNSX0VOQ19ERUZBVUxUKQ0KPiA+ID4g
KyAgICAgICAgICAgICB2ZGVjLT5jb2RlY19pbmZvLm1hdHJpeF9jb2VmZnMgPSBWNEwyX1lDQkNS
X0VOQ183MDk7DQo+ID4gPiArICAgICBpZiAodmRlYy0+Y29kZWNfaW5mby5mdWxsX3JhbmdlID09
IFY0TDJfUVVBTlRJWkFUSU9OX0RFRkFVTFQpDQo+ID4gPiArICAgICAgICAgICAgIHZkZWMtPmNv
ZGVjX2luZm8uZnVsbF9yYW5nZSA9DQo+ID4gVjRMMl9RVUFOVElaQVRJT05fTElNX1JBTkdFOw0K
PiA+ID4gK30NCj4gPiA+ICsNCg==
