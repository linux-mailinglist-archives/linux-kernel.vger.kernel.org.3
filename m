Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB9E5796F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiGSJ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbiGSJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:58:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD730F78;
        Tue, 19 Jul 2022 02:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/pNS0FURmaG6NZs+uPhI8AkR508COoCSMAFbqhEmFR8urVlZRQtIk/iJzekDsxfAYoJRAX1/cPIaSlMbs6eAKMzVErxbEU130VPvo3O9RkpU0cymcr3TXGlQiyfLy/o2B6AESm+xi66P+uL2uoaOCSgu5qTCb2D+FVUJEyTUgQRH5qBiUuC7bLDvSW9CKihKIGbBnsgka7E5BF/ODj0iwOfscgSUVm8fk4DHW6RhFDj0LNShsJWG8DZk615iScAF0O3YWiIzrD6R99HHGQ7u5LlBhr1mQlTvLyYPKMjHHE4GF/h9+7XgyFmWZtKe5P6sDXW51Q/fNM1FmpYOleZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E7nh8fiPtVFTSdsEwzzITSAP5eAlh2/SToHLEXL0ng=;
 b=LWqkZ3lr0ON6b8EEKjZ1NZ1zxwT7UOyZtdMI529ise9insrodvMG9OlSvuuLtEICNCjo9a0BFI8Ss7MNXuCUOKKTxIGFrMhdi67SDz7+X5mdEbx1b0ZNGPjuXeTZKo4Q6xXt5irCDeiwaTTPxUxHSd2kiV4kA2wKTu9lIwC/6t0UaxbDSQwXTPfs6jS3TZmfVp4iRiM5vcCjbP/f3wTf2jITBBkJ4JKceet86PeRTZvLN8IRF+KoCtDa3htYz2aJZRT5s+/i+qzFwtJySkhN1IjCmqBC1aW/XdyyrLSihUo+kSGqKrrKC5qd6dTHYexo203yccNZ5NDGYA0hUo7V4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E7nh8fiPtVFTSdsEwzzITSAP5eAlh2/SToHLEXL0ng=;
 b=iBXB5No97ZQKrhSnhQGi7h2uU4QYLP2Ej1B1YXTeoYhfpkqEctZ2xCAkq/7r70SCbm3LzgUOa6HsQSjYlsjuw6t9HQ4zUjJb6MGDl2ALX3q9rl8258WpLgdNGY0d+5Tau9BJksgD5I4tvnW6GyS/UG2J0PNi4KOWqYtcJb6FGjo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Tue, 19 Jul
 2022 09:58:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:58:51 +0000
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
Subject: RE: [PATCH V3 3/7] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Thread-Topic: [PATCH V3 3/7] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Thread-Index: AQHYmzNYr9TY0rleY0e1K+yrZnfuVa2FdHkAgAAAXsA=
Date:   Tue, 19 Jul 2022 09:58:51 +0000
Message-ID: <DU0PR04MB941796A54DC4932E5A58F4B0888F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
 <20220719055054.3855979-4-peng.fan@oss.nxp.com>
 <27ab24ec-61c7-cafb-6665-a16c58808649@linaro.org>
In-Reply-To: <27ab24ec-61c7-cafb-6665-a16c58808649@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 648ad331-0fd0-4cd6-eea7-08da696d4858
x-ms-traffictypediagnostic: VI1PR0402MB3359:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZVWEUTI33QF8XENptkwZyAuUETU7DkVOTowu2I2505M9Aumc1giPwZb4h4hvDRyYWtwpYbXzLCD1YW42IbDTX1IRx/IGZdZn6vPgmmTIeDLyqeYEvTijY0TpvhJNrsA8Rh203EMY/W/wD7ydlS8uokqXx7JvEWjsRtHwASL5fasDwzLnvoVQlYL1NgVz0oJHwmqqO9TVgqE6mo9JaZxWYpD2iGjHtwxk1u629R5KE4ccXfWSBt71VtswEUd8qwGzUeF7x4BifxSBuCHSaa7m/uNPJB+Mr8kA6aYHn4jPz2VVOTgRvBD887EDTOhDd7a6Lpuydt5+fPuaXPjPUErmy+M5gp4KAZPPMLq5lFsrB591XjcYY7llFghPbWZbBvk072zBKBq2fmLy/SyMFVeasvD4ECvMZgu3iXruQic6o37DhKkUYFM4y81MRh6QYbiDHMvqDKMtyZs4mW64cjgFYTZsDJK6NZB9IRL+ELVQqJ5fQ+kQR5oDeQiyOjXb+u1n98JzfasOMq9zw2qC1afA7W3OPy3iFfKB5FcYQqGbt7ChAhq4gMIxeOaSFnBteVU1msq5bmSTXGWqmuL4/lEKSfJV3nm+eMLkMxQ/NZR2qDRf4ADP9mXzz2xrRjnczsbOFamIv9yD/6aVFeukITaW/7xBDx98B73VdauqV5EygVrgSieEWzXUPxcMn9EXF4/G5RKxRSfVCf1TK6okYOstoffsw4ygrbyDrbtzVtuJ8Lh2yNZxJmFFIb6Vso2+psuXC4BO09aWzqkcq9MXJVtt34NsPAPxF+IcptAoaCleuo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(71200400001)(86362001)(478600001)(38070700005)(9686003)(7696005)(26005)(110136005)(83380400001)(53546011)(54906003)(186003)(41300700001)(316002)(55016003)(66946007)(8676002)(52536014)(66446008)(8936002)(5660300002)(4326008)(7416002)(44832011)(66476007)(76116006)(66556008)(122000001)(6506007)(33656002)(2906002)(64756008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTVFdXJ1WGV6b0ZmcExIVnVUYWRTUU5DK2NVYTdBbXJlNUFsVnFqbVhOY055?=
 =?utf-8?B?UVhJaWRJUHVoVXV4Y3cyaXZpc3MzWTljQm9lOG1NSUFVUmxZUS8rK0pGWTlW?=
 =?utf-8?B?K3N6bEFlUzJtdUM5V1VYa01UZHNzK1hzdzczc3NqZjdPU0N1TUFZMW0ybjJu?=
 =?utf-8?B?ZE1IZ0dyWk13OGRzaWNxMnlSTnhaYjUvdVBTM2FBWllMKzBTajd6NUhiZVdJ?=
 =?utf-8?B?SFZrYWp4VkRPRjRvR1VucjNRcEk4QklvdE9MZURzOUJtRXJmT3p5dUZWY2R4?=
 =?utf-8?B?YWhHSC8zZEFSbkV3ZGdhRTVFTFh3VjVsYmY2bHRBOHp1M1BFMzQwZjhhNGVV?=
 =?utf-8?B?OGdhUmREWVduQTh3V21uazR1dUZMVytYY283T3J5dU4vaThJYmFzT3ZkOVdV?=
 =?utf-8?B?VS9tSDk2eFVYTmZuc1N3cnJxSHN5UGw4dGlBWWRDNnMwQUFYbXZsRVZGK21E?=
 =?utf-8?B?Qkpta0dkaStvZkloQ2RDY1JPa2JJVU9TemFjTzk5WlBMOWNXVTZ3WHpSVDE0?=
 =?utf-8?B?dmNNbFhiTytZbzNQa0oxZlJTcUtubjhXMlhDMW9jeGZsb2ZkdlEwMjNheUVh?=
 =?utf-8?B?UHd6NDNIOHptRFJtSkE0aCtCYjIxNjYrUTVKOGRLS1BhVWdJOHFNTXJUNTNJ?=
 =?utf-8?B?V2h6YnQyeGpiZTFEMjJqekFMRUJmcEhzd1ZXeFg4VEtpVURSOC9zRXR6aHBW?=
 =?utf-8?B?aFp4NzE0Nm5pdUZHRnQ2RTFackxYTkJqRE1paXNtbFhpYUJaQjJubTV0aEdv?=
 =?utf-8?B?ZVBGbTBqRnhoRWVkWjR4YTRxNGluVVc3ZlZwUU1ER05NZy9sWWFyRWoySkRq?=
 =?utf-8?B?WnpIbkFMcjhIU1p5dkU0TFRwWFNrZXYydCtGb2ZpamFGUTJRK1IzUnd1ditP?=
 =?utf-8?B?N0tyek1ZUm8yeEw2ck9haVNxdmNnOTc5UUNDZDRISEFpeENsdmdoODJEazQy?=
 =?utf-8?B?SU1DUEJwRXE2VFFlR05naEd0d1Q4S0xQM0p0SlFQQjdXMXZZYkIzN2FzWVFP?=
 =?utf-8?B?YklqRVNFMTJtRlpsZWtvaTA0QW9XTTlaT3RLOHAyRjduR1NjVTNqcGVtaWFi?=
 =?utf-8?B?WnRVSk05UFdYRllPZWlMcDIwUDlHTmZYQzAveHlVU2txQ2NXeEN1NkpyUjlR?=
 =?utf-8?B?czZvSmw4bTNUNFAzaHpWRzhlT0FUcUVTNFB1S3ZOazN5RTZGVFZsV0k4T2J2?=
 =?utf-8?B?bzZWdmw5VkRUYkJrUk5lM1V1SncvOTgzNXRsQXJpV1lISG9hem11bTlPK2JC?=
 =?utf-8?B?K0lNTS9yNGZZMitsUXNsUndFRnVDcXRya0pmOFNsNWVHSll6S0RMTDE2cStB?=
 =?utf-8?B?OFNrdExJU3FuRDBNZ3Z5TVczOGVWZjRnOGh4Rmx1blFqeEdLVWIyR1FyaGR1?=
 =?utf-8?B?RHJSVlV4Z1llTm12VVNYZW5BcmZiOGhYdlVJbDVPUC9iaDlVR09RR0ZBNTh2?=
 =?utf-8?B?ZU5oK0Mzd2doT0I4VU9pTXJPUXE5R2U1ZHZ3Sm1scHgzM29RblY5S3VlSmpv?=
 =?utf-8?B?M0c1SDdmbmRXVWNZVU56cHR1OFBmdDZ6aGl4OVBnQ2tUUUFyZ2hzWDZpdEFi?=
 =?utf-8?B?S1JIVGFLdlFhZ0tCK1c1VkNNTU9DdnV2ZHQvZTdldFNQY0VlTTkzMkVRVHdG?=
 =?utf-8?B?MWZDNkhhVUNzWUJNM3dKWE1rMi9Cakpqci9TVmgzZ0ZLQ0ZvOW5PRzAyMXBs?=
 =?utf-8?B?TlJQOGtJeW0wV002Vjd5dnJMWXlRZ21NRFp5WHU3WDFvb3ZPQWl4bGtWc3JW?=
 =?utf-8?B?Q0NkVk1EUVBqbTg0alA5eTNsU0Y4Q0FhUG1GUWhVekIvVkN6ZjZ3V1NjdVhF?=
 =?utf-8?B?THFSUG1CZHhnUW4xV25lN0d3RWNBekJ6OGNqak9NZVZPbTRmZUIyOHBqbUty?=
 =?utf-8?B?TWhvNFIwZmgzREMrdisyS1Q4LzFkMXpNTjRsTndhR2diVDY3MEp0Y2FEaVpS?=
 =?utf-8?B?ZjJSU0lFd2hGRWNJQmNIakxSSmVxb0pINDR5L0hPTW16eU1seVBYQWhmOHI4?=
 =?utf-8?B?VmZ3T1VBMmVmL0wvRVBid2lxdDJEUFcwQmpqZ0RFSEtUQi9ON3I2cHBXVmxn?=
 =?utf-8?B?aHAvd2dRU2lDdGkzN1d1NWFrUlNlT3BzbHVwaklCWjFPd0svZWlyeGR2MFcx?=
 =?utf-8?Q?WJHw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648ad331-0fd0-4cd6-eea7-08da696d4858
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 09:58:51.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSE9/C3GmgeF1daa1DUTZwLsoh2FMFLbbM5VTxpi3V4WIL5lSFAyIGqvqM3r105+2AMuUl0CL8N7nraFjxr7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMy83XSBkdC1iaW5kaW5n
czogc29jOiBpbXg6IGFkZCBpLk1YOE1QIHZwdSBibGsgY3RybA0KPiANCj4gT24gMTkvMDcvMjAy
MiAwNzo1MCwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOE1QIFZQVSBibGsgY3RybCBtb2R1bGUgaGFzIHNp
bWlsYXIgZGVzaWduIGFzIGkuTVg4TU0sIHNvIHJldXNlDQo+ID4gdGhlIGkuTVg4TU0gVlBVIGJs
ayBjdHJsIHlhbWwgZmlsZS4gQW5kIGFkZCBkZXNjcmlwdGlvbiBmb3IgdGhlIGl0ZW1zLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gIC4uLi9zb2MvaW14L2ZzbCxpbXg4bW0tdnB1LWJsay1jdHJsLnlhbWwgICAgICB8IDkw
ICsrKysrKysrKysrKysrKysrLS0NCj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9pbXg4
bXAtcG93ZXIuaCAgICAgIHwgIDQgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDg1IGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2lteC9mc2wsaW14OG1tLXZwdS1ibGstDQo+
IGN0cmwueWENCj4gPiBtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9pbXgvZnNsLGlteDhtbS12cHUtYmxrLQ0KPiBjdHJsLnlhDQo+ID4gbWwgaW5kZXggYjNm
YjUyOWIzOTljLi4xNGY5MjU3NDI4NmYgMTAwNjQ0DQo+ID4gLS0tDQo+ID4gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2lteC9mc2wsaW14OG1tLXZwdS1ibGstDQo+IGN0
cmwueWENCj4gPiBtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zb2MvaW14L2ZzbCxpbXg4bW0tdnB1LWJsay0NCj4gY3RyDQo+ID4gKysrIGwueWFtbA0KPiA+
IEBAIC0zMCwyMCArMzAsMTMgQEAgcHJvcGVydGllczoNCj4gPiAgICAgIG1heEl0ZW1zOiA0DQo+
ID4NCj4gPiAgICBwb3dlci1kb21haW4tbmFtZXM6DQo+ID4gLSAgICBpdGVtczoNCj4gPiAtICAg
ICAgLSBjb25zdDogYnVzDQo+ID4gLSAgICAgIC0gY29uc3Q6IGcxDQo+ID4gLSAgICAgIC0gY29u
c3Q6IGcyDQo+ID4gLSAgICAgIC0gY29uc3Q6IGgxDQo+ID4gKyAgICBtYXhJdGVtczogNA0KPiA+
DQo+ID4gICAgY2xvY2tzOg0KPiA+ICAgICAgbWF4SXRlbXM6IDMNCj4gPg0KPiA+ICAgIGNsb2Nr
LW5hbWVzOg0KPiA+IC0gICAgaXRlbXM6DQo+ID4gLSAgICAgIC0gY29uc3Q6IGcxDQo+ID4gLSAg
ICAgIC0gY29uc3Q6IGcyDQo+ID4gLSAgICAgIC0gY29uc3Q6IGgxDQo+ID4gKyAgICBtYXhJdGVt
czogMw0KPiA+DQo+ID4gIHJlcXVpcmVkOg0KPiA+ICAgIC0gY29tcGF0aWJsZQ0KPiA+IEBAIC01
Myw2ICs0Niw4NSBAQCByZXF1aXJlZDoNCj4gPiAgICAtIGNsb2Nrcw0KPiA+ICAgIC0gY2xvY2st
bmFtZXMNCj4gPg0KPiA+ICthbGxPZjoNCj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0
aWVzOg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoN
Cj4gPiArICAgICAgICAgICAgY29uc3Q6IGZzbCxpbXg4bW0tdnB1LWJsay1jdHJsDQo+ID4gKyAg
ICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIHBvd2VyLWRvbWFp
bnM6DQo+ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlv
bjogYnVzIHBvd2VyIGRvbWFpbg0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBHMSBk
ZWNvZGVyIHBvd2VyIGRvbWFpbg0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBHMiBk
ZWNvZGVyIHBvd2VyIGRvbWFpbg0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBIMSBl
bmNvZGVyIHBvd2VyIGRvbWFpbg0KPiA+ICsNCj4gPiArICAgICAgICBwb3dlci1kb21haW4tbmFt
ZXM6DQo+ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogYnVz
DQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGcxDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6
IGcyDQo+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGgxDQo+ID4gKw0KPiA+ICsgICAgICAgIGNs
b2NrczoNCj4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0
aW9uOiBHMSBkZWNvZGVyIGNsaw0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBHMiBk
ZWNvZGVyIGNsaw0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBIMSBlbmNvZGVyIGNs
aw0KPiA+ICsNCj4gPiArICAgICAgICBjbG9jay1uYW1lczoNCj4gPiArICAgICAgICAgIGl0ZW1z
Og0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBnMQ0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0
OiBnMg0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBoMQ0KPiA+ICsNCj4gPiArICAtIGlmOg0K
PiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAg
ICAgICAgICBjb250YWluczoNCj4gPiArICAgICAgICAgICAgY29uc3Q6IGZzbCxpbXg4bXAtdnB1
LWJsay1jdHJsDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsg
ICAgICAgIHBvd2VyLWRvbWFpbnM6DQo+ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAg
ICAgICAgLSBkZXNjcmlwdGlvbjogYnVzIHBvd2VyIGRvbWFpbg0KPiA+ICsgICAgICAgICAgICAt
IGRlc2NyaXB0aW9uOiBHMSBkZWNvZGVyIHBvd2VyIGRvbWFpbg0KPiA+ICsgICAgICAgICAgICAt
IGRlc2NyaXB0aW9uOiBHMiBkZWNvZGVyIHBvd2VyIGRvbWFpbg0KPiA+ICsgICAgICAgICAgICAt
IGRlc2NyaXB0aW9uOiBWQzgwMDBFIGVuY29kZXIgcG93ZXIgZG9tYWluDQo+ID4gKw0KPiA+ICsg
ICAgICAgIHBvd2VyLWRvbWFpbi1uYW1lczoNCj4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsg
ICAgICAgICAgICAtIGNvbnN0OiBidXMNCj4gPiArICAgICAgICAgICAgLSBjb25zdDogZzENCj4g
PiArICAgICAgICAgICAgLSBjb25zdDogZzINCj4gPiArICAgICAgICAgICAgLSBjb25zdDogdmM4
MDAwZQ0KPiA+ICsNCj4gPiArICAgICAgICBjbG9ja3M6DQo+ID4gKyAgICAgICAgICBpdGVtczoN
Cj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogRzEgZGVjb2RlciBjbGsNCj4gPiArICAg
ICAgICAgICAgLSBkZXNjcmlwdGlvbjogRzIgZGVjb2RlciBjbGsNCj4gPiArICAgICAgICAgICAg
LSBkZXNjcmlwdGlvbjogVkM4MDAwRSBlbmNvZGVyIGNsaw0KPiA+ICsNCj4gPiArICAgICAgICBj
bG9jay1uYW1lczoNCj4gPiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAtIGNv
bnN0OiBnMQ0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBnMg0KPiA+ICsgICAgICAgICAgICAt
IGNvbnN0OiB2YzgwMDBlDQo+ID4gKw0KPiA+ICsgICAgICAgIGludGVyY29ubmVjdHM6DQo+ID4g
KyAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogRzEgZGVj
b2RlciBpbnRlcmNvbm5lY3QNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogRzIgZGVj
b2RlciBpbnRlcmNvbm5lY3QNCj4gPiArICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogVkM4MDAw
RSBlbmNvZGVyIGludGVyY29ubmVjdA0KPiA+ICsNCj4gPiArICAgICAgICBpbnRlcmNvbm5lY3Qt
bmFtZXM6DQo+ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgLSBjb25zdDog
ZzENCj4gPiArICAgICAgICAgICAgLSBjb25zdDogZzINCj4gPiArICAgICAgICAgICAgLSBjb25z
dDogdmM4MDAwZQ0KPiANCj4gSW5jbHVkZSBpbnRlcmNvbm5lY3RzK25hbWVzIGluIGxpc3Qgb2Yg
YWxsIHByb3BlcnRpZXMgYW5kIGRpc2FsbG93IHRoZW0gZm9yDQo+IG90aGVyIHZhcmlhbnRzLg0K
DQpJIG5vdCB1bmRlcnN0YW5kIHdlbGwgYWJvdXQgDQoiIEluY2x1ZGUgaW50ZXJjb25uZWN0cytu
YW1lcyBpbiBsaXN0IG9mIGFsbCBwcm9wZXJ0aWVzICIsIGNvdWxkIHlvdSBwbGVhc2UNCmV4cGxh
aW4gYSBiaXQgbW9yZT8NCg0KQW5kIHRoZXJlIGlzIGFscmVhZHkgYW4gImlmIiB0byBjaGVjayB3
aGV0aGVyIHRoZQ0KY29tcGF0aWJsZSBjb250YWlucyAiIGZzbCxpbXg4bXAtdnB1LWJsay1jdHJs
IiB0byBtYWtlIHN1cmUgdGhlIGludGVyY29ubmVjdA0KdmFsaWQgZm9yIGkuTVg4TVAsIHNvIGl0
IGlzIG5vdCB2YWxpZCB0byBvdGhlciB2YXJpYW50cy4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiAN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
