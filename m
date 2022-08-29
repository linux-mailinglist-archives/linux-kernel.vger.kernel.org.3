Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28BE5A406C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 02:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiH2AlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 20:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2AlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 20:41:13 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20086.outbound.protection.outlook.com [40.107.2.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED36F5A3;
        Sun, 28 Aug 2022 17:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKRMA+xSh4kjB73XJMmgOBItV0XqAnLc2EJcKYfuvFrI8imV1/me/Na9yQUVi3E9RlbJB3WL7PU+Ksb1cJv4J2AGkVtQ2OK6SBQL2qwf8D/uK3bv3hWUyRWBL4m5ORvmbhAbOYq+QoqHR25CVpETENejtsofmg/bqc+7ehvG8xiEmAyICUUXphA6li7g6eaSZwNQUK7QCuaRr40AW0QXDIuWepi8IKuBuqVV2CoxzLeCP8QZaltjowX5zZVBAH2YRoQFmfoyKSCi4XCQdvLUF24Is+IpLiXJ/hJ8PMb5fEiQhHhZllHSokxjCfUVrht+B0b+x9dVWnE8BDqhSD/1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWFCMmEw9MkVOILmMXHkKVU1omfHgE9Hl7oP1BSOihI=;
 b=BPjVch5lLrMcEf91MCiLM7mGPJyYJthxhxM79DRRXvsnVUTpYdIkPIdHd4Dhm/Df3aYfNhXRBrtvh53I9iT4aqE2IvSeXedrYcfLA18Lhp1YXZCslXbq7DVPR9IGX1EOhrt1WpMBHD1CkF+csemESk2YkuvLYZxPjnNMe//96I6lSXLJZgdroBWGPaKFuWi3nTysa1vD8ZkD8b/LU9E8iz6lJdjo32iGzaPwHfnrSJbpU+6PB9uvVGlgmd8SXI4yDaQ82YUSs0ZN2LISZ1ZTI4tfZrhiw8kAPuZFEvb87dio352GlE9T1DVFFNM0Pvo4gACRZxQnSe7XPbcM46bdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWFCMmEw9MkVOILmMXHkKVU1omfHgE9Hl7oP1BSOihI=;
 b=F9lDLdXE3sPV1t0WPenS1squaXY1FtcTv6O2qpUedUw3LJvlEhcCsFhC8cms0e7b3gXAvElij9I07KdX8cGlvyzRVONrRnHBfEnzDPmGweXaD+ZmQ33V950Lo4L+PhDnI7J9MgK/whwBIfGRvULHBe1STebNWyOAcPiYH/WQ3h4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8844.eurprd04.prod.outlook.com (2603:10a6:20b:40b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 00:41:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 00:41:05 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ying Liu <victor.liu@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2 2/2] mailbox: imx: support RST channel
Thread-Topic: [PATCH V2 2/2] mailbox: imx: support RST channel
Thread-Index: AQHYgLehFUFmH73XBkeqH/pff2lp6q2+OGiAgAdFt6A=
Date:   Mon, 29 Aug 2022 00:41:05 +0000
Message-ID: <DU0PR04MB9417A23137D0B335CFC9E21688769@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220615130009.1457986-1-peng.fan@oss.nxp.com>
         <20220615130009.1457986-3-peng.fan@oss.nxp.com>
 <4fdef6f22ba6fe734ee11601aacc884da2b9820b.camel@nxp.com>
In-Reply-To: <4fdef6f22ba6fe734ee11601aacc884da2b9820b.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b18a3b8-474d-48a0-368f-08da89572816
x-ms-traffictypediagnostic: AM9PR04MB8844:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcIO13B/jIxlvjikdgtZ2x7x/2LKnFu3VdP3JVbLZXzusD7mxYbUabgp/bMx2hPBxr7fkfBi0uV+5z1lZRAj98/Lgi9VYdGWkVSPX3CoZZUD5jliVSeSQxm5lRngOJ+8rnAcXOn0ClS1a85Mc2IzUyk03vJ3sZikL2i0y+E91DHf3BWOgeZFH8RZPn4azkakxMMAg8ntTzzeQBZaKtzl6C5Xa/LuYiRwvKBtRhhI5If9InykIH9DCQCZNK/QkzK0Kcl85o7MGY8xBGa2XjR01y+KQZISFQ9UWuaSoFTAvRAb39Jk2Y5dhrpqczZYoxo/62pkw/e9EC9kovpKZFCmXhwpsekxz5p3Dq9Xwb9JYfPnc6scl8qxfGFJ8MDo3tYNSxVkwgGmTHeFXLPQ72isMi3Mw2gLMGWC8B9CjAuhn52hGwalRnBOpW+UXVtwaCYiR2TndP3AIWVZYGrCjCC5SeC1CEIPLjjvjKzHi7KNIahdYorIIrqnhRNjHKIqaIb5wpouqYGG0s9dJ5vMlitgs2BHIJzXTYPNOg1DqaSyKCSGEVf294ANDZUB/pG/ZW4y3yehfvZzA2AsHFeHTg2lFwSZHpjinqrCo0BRoyC9kLEQafkponSUMhYOJ2FHQ/9TkFmiyfrFDEv2ZtSxurAEObQ6ZEP/6nYoM0LplXYGhTdDXRxojdLipoxWNRdmCSRf5S51Gp/+ryjL7fFrl3zasxpxXYwczlPEJ/3MvcidxUGQ/hEg6/2DT6u0Fw8fZxK0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(66476007)(110136005)(66446008)(64756008)(52536014)(66556008)(5660300002)(66946007)(8676002)(4326008)(15650500001)(8936002)(44832011)(33656002)(7416002)(76116006)(316002)(54906003)(2906002)(478600001)(41300700001)(6506007)(7696005)(26005)(55016003)(86362001)(9686003)(71200400001)(38070700005)(83380400001)(186003)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWRxS3AzanpiWHRXVXhpZTI4N1hjbnZTY1J6eUpNRUdiTUxQcW9nSTF2dmtq?=
 =?utf-8?B?Lzh0TGVwWlNhVjJXdzAxeTR6ZTZJVTE4S2xBS2IyQ28wcjYwbWRxU2JUZFRp?=
 =?utf-8?B?VU1yVGdPYjJ6YXYrWnkwblhHYVA0QkRaRVVvVWRySEkxdFlTY3NJVVRwNm5T?=
 =?utf-8?B?UCt2UER4K084OUpuQnR4UDdCeTVBRVloSkNveERvbklqQk9tcFN2ODdTRzZw?=
 =?utf-8?B?V0hIdGRscXVMMTRHczYycGIzbGlvS2k2ZnhTd3BkQktmeW5kYnRKVFpRZHN4?=
 =?utf-8?B?em1yUGRzSncralovYnhxSklXR0dSZnBKVS9iZ1FWV1IybDM2bVI3SHYwNDEw?=
 =?utf-8?B?dWY5dmkySmlRemczRzBMZmtmYTRmYlV6a1RmOXkxQnF2aEMybjRoOXAydG1s?=
 =?utf-8?B?TnhibHZGRUJPb292Uldrek5vOFRQMHBnWnNSSTNaNzF1R090ZjAyKzJ1L3dm?=
 =?utf-8?B?WlJ1b3Y1dm91b1ZzWUJQRm9Na2RIaWFoemZqT29FdTlpRElrVnAxelhHdSt3?=
 =?utf-8?B?ZDFqR2Jxc0FuOUxCM1BxZUtkR29YYmZELzBkaXBNL1VoMXRvcElHUzRKOURJ?=
 =?utf-8?B?eGJlZ2QyRXU0cnppNXAzZUU4U2ZxSXlqOVcrQWN0QXpqNmdsRXQvdFJQbTJi?=
 =?utf-8?B?bGcwbWJGV0dUT1FRSFJWNlVhVExRQmF0MGwrUFBscWJISjJJNEt4VnVrOUU3?=
 =?utf-8?B?cGxOVWdtYm4yOU4zQVllOEtmajI4UWRyK00wbGx6bmNSODNSTHhKZG9VajNZ?=
 =?utf-8?B?eFpBbXBzNGkvQW0raG96Wld4eWpxYTlYZjA4Rmx6S0VlNzN3empPL2EybGVn?=
 =?utf-8?B?WDFXcTRkZ2VORWx4T1dUY0g4K1BLa0JZcHJqMG5PWWVSS3JZN1MrOHh1VFFR?=
 =?utf-8?B?UkExNFM5bzZTK0Vxcjd6RXdBRnZZNFg4d08rVkhoZGRIS0FBZ3JCbTlvcUg4?=
 =?utf-8?B?dlZtRVRQci9sMVJ6OU1xelN4S1FER0pwUUZxMEJ6TFZUN1lSeHU2Zm5VeXFC?=
 =?utf-8?B?aXcxa1dyeVgxZm92MVhOay8wMWlwZGplVDNRMnBSVXpqRW50ZW1UMmVPaWJq?=
 =?utf-8?B?S1E5cXUzckhPc01DWTNRUXIxL2hEckVFd0tXRG5JMm9LU3QrRXJxdllxTDhR?=
 =?utf-8?B?dVEwcWwza0E5WTNlUEh0WXBibnpyd013b2hoRVVwbkYxWHNtUGRFSEpCZGpE?=
 =?utf-8?B?TE80T2h6SkZ0SWk1WFNBd2d5aEhSZE02bTNHT09Ob2FISXE5R0VkRXhsRTJP?=
 =?utf-8?B?VGR1aWNhOGhqV05RbFhIb0xUS3diRnpSZXJPK1o0L0lkTFRKaXl1dm9BUmkx?=
 =?utf-8?B?dUdPbkFtbmRYYjA0RG5lQkxESHFTQTNJTGdRWlVNR0UyWWVjN2d6VVZyQ0ZT?=
 =?utf-8?B?THBnYWQwVTVKVmNOV3Y3d1Y0WVR4QkhZdWxGbHFzZVgzRkVmTzJaNCtuY0lE?=
 =?utf-8?B?clpEcWFHWU1hbjQrQjJxQ3QzVVp3ZjF6Y1p3MU5iSUxuYXRBN2JZNEV4UXZJ?=
 =?utf-8?B?WVJtNldIT2dGL1loSzRxV2F1UEFDUXF3STRONU5wZnpXbktPVFUyUXpicHZn?=
 =?utf-8?B?R01QZVpxQWRaYkRYYWZZSURBZlZqWS9XY3huWE9CRkRwL2UyS0lsQ0tQaUFX?=
 =?utf-8?B?eERVT3NvNWhWYkZ3MzlnN3FVZTc4Kzd0NHl6alhGMHorZU94SEhBS1luVXpN?=
 =?utf-8?B?WE5xWlpGNkU0S1NVNStFTmE4ejlhMzdCdmpPM1lnWE5udTZwbzgvVkJSNTI0?=
 =?utf-8?B?TmVnVHkvanU0MkpqQlZFdzZrbjFINjlqV01ucm05REFyS3hXOW5YelFKaWU4?=
 =?utf-8?B?VE5pVzVNN3ErSTdDSytYa3hyL0poYkVxRU1SeElwZktVNE5mRFF4TFVKN0lq?=
 =?utf-8?B?VnpwTjBJdmozTDg1TEw5VE5Dci9uc1RSWWRKQVZEZlFtbXY4RmNQdDBDWFVQ?=
 =?utf-8?B?VmRmK0NjOUIvOFN1K3kwdHFoKzVTUDVzYmFGSlZqTkxiTUpxVUhpRDc4V0JL?=
 =?utf-8?B?aWxJZzZ2RHgxYjhwK24zYnUwVlRXaTNZUUl6TXUyWDBEM24zdEpjL2YxV1pY?=
 =?utf-8?B?ZmxlY3VZT2NSWm1wNVFLNlBGQ3E5ank3emZFT094S09nVmordm02cW1ldnlx?=
 =?utf-8?Q?D90E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b18a3b8-474d-48a0-368f-08da89572816
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 00:41:05.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/apUv3yy2/P9aY31SFq2MfjqqXueium2pmYuVu9dN+xL9qqPQrsmawqpS4rx6jW9GQ0wZo5hp20OtI48lHs6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvMl0gbWFpbGJveDogaW14OiBzdXBwb3J0IFJTVCBj
aGFubmVsDQo+IA0KPiBIaSwNCj4gDQo+IE9uIFdlZCwgMjAyMi0wNi0xNSBhdCAyMTowMCArMDgw
MCwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4NCj4gPiBpLk1YIGdlbmVyaWMgTVUgc3VwcG9ydHMgTVUtQS9CIHJlc2V0IGZl
YXR1cmUuDQo+ID4NCj4gPiBXaGVuIHN0b3Avc3RhcnQgcmVtb3RlY29yZSwgTVUgaXMgbm90IHJl
c2V0LiBTbyB3aGVuIExpbnV4IHN0b3ANCj4gPiByZW1vdGVjb3JlLCB0aGUgTVUtQiBzaWRlIEJD
UiBtYXkgY29udGFpbiB2YWxpZCBjb25maWd1cmF0aW9uLCBiZWNhdXNlDQo+ID4gTVUtQiBpcyBu
b3QgcmVzZXQuIFNvIHdoZW4gbGludXggc3RhcnQgTWNvcmUgYWdhaW4gYW5kIG5vdGlmeSBNY29y
ZSwNCj4gPiBNY29yZSBpcyBub3QgcmVhZHkgdG8gaGFuZGxlIE1VIGludGVycnVwdCBhbmQgY2F1
c2UgaXNzdWVzLiBTbyBuZWVkDQo+ID4gcmVzZXQgTVUgd2hlbiBzdG9wIE1jb3JlLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiBJdCBs
b29rcyBsaWtlIHRoaXMgcGF0Y2ggY2F1c2VzIGkuTVg4cXhwIE1FSyBib290IGZhaWx1cmUgd2l0
aCB2Ni4wLSByYzEuIEFmdGVyDQo+IHJldmVydGluZyBjb21taXQgODJhYjUxM2JhZWQ1ODk1Yzhi
MGU5OTE1NTdhMTJmZDM4ZDVmMjVmMCwNCj4gaXQgYm9vdHMgb2suDQoNClRoYW5rcyBmb3IgeW91
ciB0ZXN0LiBJbmRlZWQsIEkgb25seSB0YWtlIGdlbmVyaWMgTVUgaW50byBjb25zaWRlcmF0aW9u
IGFuZCBicm9rZQ0KaS5NWDhRWFAgU0NVIE1VLiBUaGUgZm9sbG93aW5nIHBhdGNoIGNvdWxkIHJl
c29sdmUgdGhlIGlzc3VlLCBhZnRlciBtb3JlDQp0ZXN0LCBJIHdpbGwgc2VuZCBhIGZvcm1hbCBw
YXRjaDoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jIGIvZHJp
dmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCmluZGV4IGYzNmNiMDA0OGNlNy4uZTM3M2VhOGI0
NzA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCisrKyBiL2Ry
aXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQpAQCAtODkzLDcgKzg5Myw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaW14X211X2RjZmcgaW14X211X2NmZ19pbXg3dWxwID0gew0KICAgICAgICAu
eFRSICAgID0gMHgyMCwNCiAgICAgICAgLnhSUiAgICA9IDB4NDAsDQogICAgICAgIC54U1IgICAg
PSB7MHg2MCwgMHg2MCwgMHg2MCwgMHg2MH0sDQotICAgICAgIC54Q1IgICAgPSB7MHg2NCwgMHg2
NCwgMHg2NCwgMHg2NH0sDQorICAgICAgIC54Q1IgICAgPSB7MHg2NCwgMHg2NCwgMHg2NCwgMHg2
NCwgMHg2NH0sDQogfTsNCg0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X211X2RjZmcgaW14X211
X2NmZ19pbXg4dWxwID0gew0KQEAgLTkxNiw3ICs5MTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGlteF9tdV9kY2ZnIGlteF9tdV9jZmdfaW14OHVscF9zNCA9IHsNCiAgICAgICAgLnhUUiAgICA9
IDB4MjAwLA0KICAgICAgICAueFJSICAgID0gMHgyODAsDQogICAgICAgIC54U1IgICAgPSB7MHhD
LCAweDExOCwgMHgxMjQsIDB4MTJDfSwNCi0gICAgICAgLnhDUiAgICA9IHsweDExMCwgMHgxMTQs
IDB4MTIwLCAweDEyOH0sDQorICAgICAgIC54Q1IgICAgPSB7MHg4LCAweDExMCwgMHgxMTQsIDB4
MTIwLCAweDEyOH0sDQogfTsNCg0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X211X2RjZmcgaW14
X211X2NmZ19pbXg5M19zNCA9IHsNCkBAIC05MjcsNyArOTI3LDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBpbXhfbXVfZGNmZyBpbXhfbXVfY2ZnX2lteDkzX3M0ID0gew0KICAgICAgICAueFRSICAg
ID0gMHgyMDAsDQogICAgICAgIC54UlIgICAgPSAweDI4MCwNCiAgICAgICAgLnhTUiAgICA9IHsw
eEMsIDB4MTE4LCAweDEyNCwgMHgxMkN9LA0KLSAgICAgICAueENSICAgID0gezB4MTEwLCAweDEx
NCwgMHgxMjAsIDB4MTI4fSwNCisgICAgICAgLnhDUiAgICA9IHsweDgsIDB4MTEwLCAweDExNCwg
MHgxMjAsIDB4MTI4fSwNCiB9Ow0KDQogc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfbXVfZGNmZyBp
bXhfbXVfY2ZnX2lteDhfc2N1ID0gew0KQEAgLTkzOCw3ICs5MzgsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGlteF9tdV9kY2ZnIGlteF9tdV9jZmdfaW14OF9zY3UgPSB7DQogICAgICAgIC54VFIg
ICAgPSAweDAsDQogICAgICAgIC54UlIgICAgPSAweDEwLA0KICAgICAgICAueFNSICAgID0gezB4
MjAsIDB4MjAsIDB4MjAsIDB4MjB9LA0KLSAgICAgICAueENSICAgID0gezB4MjQsIDB4MjQsIDB4
MjQsIDB4MjR9LA0KKyAgICAgICAueENSICAgID0gezB4MjQsIDB4MjQsIDB4MjQsIDB4MjQsIDB4
MjR9LA0KIH07DQoNCiBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9tdV9kY2ZnIGlteF9tdV9jZmdf
aW14OF9zZWNvID0gew0KQEAgLTk0OSw3ICs5NDksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlt
eF9tdV9kY2ZnIGlteF9tdV9jZmdfaW14OF9zZWNvID0gew0KICAgICAgICAueFRSICAgID0gMHgw
LA0KICAgICAgICAueFJSICAgID0gMHgxMCwNCiAgICAgICAgLnhTUiAgICA9IHsweDIwLCAweDIw
LCAweDIwLCAweDIwfSwNCi0gICAgICAgLnhDUiAgICA9IHsweDI0LCAweDI0LCAweDI0LCAweDI0
fSwNCisgICAgICAgLnhDUiAgICA9IHsweDI0LCAweDI0LCAweDI0LCAweDI0LCAweDI0fSwNCiB9
Ow0KDQogc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaW14X211X2R0X2lkc1tdID0g
ew0KLS0NCjIuMzcuMQ0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+IFRoZXJlIGFyZSBhIGxvdCBpbXhf
bXUgYW5kIGlteC1zY3UgZXJyb3IgbG9nczoNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS04PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBbICAgIDEuMTY2
NTY3XSBpbXgtc2N1IHN5c3RlbS1jb250cm9sbGVyOiBSUEMgc2VuZCBtc2cgdGltZW91dA0KPiBb
ICAgIDEuMTcxODQzXSBpbXhfc2N1X3NvY19pZDogZ2V0IHNvYyBpbmZvIGZhaWxlZCwgcmV0IC0x
MTANCj4gWyAgICAxLjE3NzIyMV0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogZmFpbGVkIHRv
IGluaXRpYWxpemUgU29DDQo+IGluZm86IC0yMg0KPiBbICAgIDEuMTg0MDE5XSBpbXgtc2N1IHN5
c3RlbS1jb250cm9sbGVyOiBOWFAgaS5NWCBTQ1UgSW5pdGlhbGl6ZWQNCj4gWyAgICAxLjIzMDYw
NV0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAg
ICAxLjI3MDU1OV0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVv
dXQNCj4gWyAgICAxLjMxMDU2MV0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQg
bXNnIHRpbWVvdXQNCj4gWyAgICAxLjM1MDU2MF0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjog
UlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjM5MDU2MF0gaW14LXNjdSBzeXN0ZW0tY29u
dHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjQzMDU2MV0gaW14LXNjdSBz
eXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjQ3MDU1OV0g
aW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAx
LjUxMDU1OV0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQN
Cj4gWyAgICAxLjU1MDU1OV0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNn
IHRpbWVvdXQNCj4gWyAgICAxLjU5MDU1OV0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBD
IHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjYzMDU2MV0gaW14LXNjdSBzeXN0ZW0tY29udHJv
bGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjY3MDU1OF0gaW14LXNjdSBzeXN0
ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjcxMDU1OV0gaW14
LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjc1
MDU1OF0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4g
WyAgICAxLjc5MDU1OV0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRp
bWVvdXQNCj4gWyAgICAxLjgzMDU2Ml0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNl
bmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjg3MDU1OV0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxl
cjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjkxMDU1OV0gaW14LXNjdSBzeXN0ZW0t
Y29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjk1MDU2MV0gaW14LXNj
dSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAgICAxLjk5MDU5
Ml0gaW14LXNjdSBzeXN0ZW0tY29udHJvbGxlcjogUlBDIHNlbmQgbXNnIHRpbWVvdXQNCj4gWyAg
ICAxLjk5NTgzOF0gaW14X211IDVkMWMwMDAwLm1haWxib3g6IFRyeSBpbmNyZWFzaW5nDQo+IE1C
T1hfVFhfUVVFVUVfTEVODQo+IFsgICAgMi4wMDIyNjJdIGlteC1zY3Ugc3lzdGVtLWNvbnRyb2xs
ZXI6IFJQQyBzZW5kIG1zZyBmYWlsZWQ6IC0xMDUNCj4gWyAgICAyLjAwODI2MF0gaW14X211IDVk
MWMwMDAwLm1haWxib3g6IFRyeSBpbmNyZWFzaW5nDQo+IE1CT1hfVFhfUVVFVUVfTEVODQo+IFsg
ICAgMi4wMTQ2ODJdIGlteC1zY3Ugc3lzdGVtLWNvbnRyb2xsZXI6IFJQQyBzZW5kIG1zZyBmYWls
ZWQ6IC0xMDUNCj4gWyAgICAyLjAyMDY4MV0gaW14X211IDVkMWMwMDAwLm1haWxib3g6IFRyeSBp
bmNyZWFzaW5nDQo+IE1CT1hfVFhfUVVFVUVfTEVODQo+IFsgICAgMi4wMjcxMDNdIGlteC1zY3Ug
c3lzdGVtLWNvbnRyb2xsZXI6IFJQQyBzZW5kIG1zZyBmYWlsZWQ6IC0xMDUNCj4gWyAgICAyLjAz
MzEwNV0gaW14X211IDVkMWMwMDAwLm1haWxib3g6IFRyeSBpbmNyZWFzaW5nDQo+IE1CT1hfVFhf
UVVFVUVfTEVODQo+IFsgICAgMi4wMzk1MjZdIGlteC1zY3Ugc3lzdGVtLWNvbnRyb2xsZXI6IFJQ
QyBzZW5kIG1zZyBmYWlsZWQ6IC0xMDUNCj4gWyAgICAyLjA0NTUyNl0gaW14X211IDVkMWMwMDAw
Lm1haWxib3g6IFRyeSBpbmNyZWFzaW5nDQo+IE1CT1hfVFhfUVVFVUVfTEVODQo+IFsgICAgMi4w
NTE5NDldIGlteC1zY3Ugc3lzdGVtLWNvbnRyb2xsZXI6IFJQQyBzZW5kIG1zZyBmYWlsZWQ6IC0x
MDUNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTg8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+IA0KPiBSZWdhcmRzLA0KPiBMaXUgWWluZw0KDQo=
