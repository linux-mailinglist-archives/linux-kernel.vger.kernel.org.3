Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3275E486347
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiAFK4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:56:17 -0500
Received: from mail-eopbgr00093.outbound.protection.outlook.com ([40.107.0.93]:39527
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238102AbiAFK4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:56:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaWx8UDMVK2w8cnkZrdc8HNrK7iFDe7g35NWtgLPqyJ+aQ5pHJdMPA9FQW5qd7J0zrO+NLBCAIbOmTHwHauEQDDQdpCu6uogOAXRxsV0dyLBDOYJf77z2WZ9A5bbyJh/h9DPaasEM0zQEcAQKG+gzrCBbtVcDN3WrXeVSgeeNKb2RiCKRCrCyqBHPxjjbE3eehsGKZDTIY7YEFiw9oAGHMMTPb8VBRDqN95FoKYN37D4Uv8n8c+rMjcZBRx9ebrQAzQgyxw/w25PjKl+sMrn333x2ij4fUsI3gqupn9iDUUB4Kr9dESLDu3rEGU24g8EGAso6lgdyAlrGn4pTR0zsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4oiqb1/rjkf6wMntlqEe5msTanO0gmxyJUQKdq3V3Q=;
 b=Rbc93NzpdRiDgt5sexEbVaKkiFJNoVAuoJeX0FkNevkykkDr1jjDXbkynWIFRWLynhLp6pWzIrQSixeEYtRvAwWOKC+RrLnqbfmvuPpxoeBmk0eBkiympSHK7LoCCGz2LoySGlhBTdtHo/g2X3/61YI71IFN1GGi7m/I0ZgfkVK5k56GqC4/KzsxAkMiaf7b0UjjPkFYqEQvmr7+1+k0CmjwpbBzFZ6I6EO7za+Xg/NcGYU+6H8LPtIXV3sX83rnNuGAbcUC4uFLWvDYytM+mQmun7acLVeDJwIR/fle/zD5cbCNFiMYvdWuXpoC85QH4b7eQLteda8KcbZUEIqiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4oiqb1/rjkf6wMntlqEe5msTanO0gmxyJUQKdq3V3Q=;
 b=aKJKDpQpeE0l00apFtBtrk5laYuhqfchtU/C8txOtnHAYBAuuEtV4QIT6uuu1WsCN5aO24gHPvoqvdcz9q2qUMSupt4ZGno/TJQWZnZ+WZZX8OnyddweAVx0IbagdjIHCXTtWw5op8bug36TeikMdy3xL6PnBC0eAQNcE3+2u5M=
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com (2603:10a6:20b:37::25)
 by AM6PR06MB4648.eurprd06.prod.outlook.com (2603:10a6:20b:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 10:56:12 +0000
Received: from AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::8cee:862c:c31b:fa97]) by AM6PR06MB4691.eurprd06.prod.outlook.com
 ([fe80::8cee:862c:c31b:fa97%6]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 10:56:12 +0000
From:   ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
To:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "alice.guo@nxp.com" <alice.guo@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>, "marex@denx.de" <marex@denx.de>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: RE: [PATCH v3 0/2] CAAM Driver: re-factor and set proper JR status
Thread-Topic: [PATCH v3 0/2] CAAM Driver: re-factor and set proper JR status
Thread-Index: AQHX676JdKhASpnMmUOrzOCY6m49XaxWAItA
Date:   Thu, 6 Jan 2022 10:56:12 +0000
Message-ID: <AM6PR06MB469129E72ED6FBE0B33C693DA64C9@AM6PR06MB4691.eurprd06.prod.outlook.com>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
 <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
In-Reply-To: <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0be5c716-8a09-417e-e541-08d9d1032771
x-ms-traffictypediagnostic: AM6PR06MB4648:EE_
x-microsoft-antispam-prvs: <AM6PR06MB46481AEFC9ABBDF379EF3FC7A64C9@AM6PR06MB4648.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Okp8lGgoPHNA8XXBRVHibqiZ5xwZX0byKRxOvVkOpTE6n3sxANHUmwa4pzvn2jTlUjgAboN9yqQzBXQNzgFaJ3dby0r1ER15Z0ID+WxAzN/GAcwjyGg5QuchAzfm0AaUcUojgKijBTZHLHO93P/qdf2QGtAqfx0kSbXehMv/gjEsZKvWJZq7zwpp+F3RoaVKyFUckthGz7d7BDp6VVcAu5w6JLkYYgGBHGuRc+v2iXcSUtvjh0qYNnTNmqMPHEQ2CLqNMuln4QEU63QKFWsIqHyxJicNte6/TktDbe2rSY+776rOKzW4K742WwuqizPMPb+DcpNU9PR/R9awBHAPCSijbqUMItGzSzi9Ro9SOeCt91LGcAZGlcAXTzuuKjIGj5LWWhLD4dpPevwfmz4O8x8IKudAcDgcXCcACOIBZcBJK2bVbEzlRcQMpb11Nl/Epenthz6n+P3OCN2CvnMOFe0v1GgPFuRnloIxxPf99M5UjNyIrTHYvqc+oTmYVPCkkWDkGcmIAp2bC5Q2FJKDNwBzDHMCV20TP59txxFUVaRnaQSgYstoxR0CJpYXv3KFBkCYifB8maPx3KQpW488MTt97H1uMbqWAJ7P4QeJYraCK0zieBSEhCEU39R7GKXVz2q+cnsGfiKI6q6hPq97hX84KNEJ9JW4vSjxrmTiOKtMfwWWFckXfw/BfAOZpK1uSa0Tw/1mGPCBi1IMfPNVFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4691.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(83380400001)(316002)(33656002)(38070700005)(2906002)(38100700002)(9686003)(52536014)(186003)(7406005)(55016003)(71200400001)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(8936002)(66946007)(122000001)(54906003)(7416002)(26005)(5660300002)(7696005)(53546011)(6506007)(86362001)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWlGNzhvWlpCcGtaV3NSV0wyV0F4OWlNT29DVXNjWTBRdU9ld0dSNHFlZTVo?=
 =?utf-8?B?L3pkTDFDNjBlUGk3WkxJNjRSVWZBdEVhY1pZTG1UenY1Ym0rSjZmcDlobnhZ?=
 =?utf-8?B?cndjSW9MM0UrRTJPMHVETklMT01QMmtEYWV5VW10OVhMQ0ZkNnY2NU1yREdM?=
 =?utf-8?B?eENSNlRQc0luUGY0SmVJRklmSGN1c2g3VmY2RDhuemV3Qm90YmovVmJ0ZGUw?=
 =?utf-8?B?RnQzdDMwMnphbmkyRlI0bjdvS0ZuQUd2cVp5d1VCUnVLSjkvaUNocllyNVo1?=
 =?utf-8?B?N0NodnhkK3NjU0ZsL2VuTDVLUVFORHR6VjVsSXdXY1NEM3p3K1Rjb0MxRkJs?=
 =?utf-8?B?UkFCcC9PWWNiSUN4SzhuZWVvUHdJallBNEQxSFo5Q0FZS1hrcEpCZXlNUjNH?=
 =?utf-8?B?SDFJNHpTOHkzZXRWdmdhMmc5c2crU0I0M0dDa1daV2JNWmlITk12YThxOTlD?=
 =?utf-8?B?R3RmYjFUaTdjSUwyOGxBSGdZTVFteTljWTNXYnA1Z1FNbUQwUEhhVTZ1T3ZP?=
 =?utf-8?B?dUI2b1ZjU1RZZTFLaktXK1Q2cFNsSGZNaHpJRTRLcUkvbUhDZWtFZ1F0YjB6?=
 =?utf-8?B?SUhCcFZiOXlTbWQ1QmozYVBVVU1ISnU3VXZZaHA5Mlo2aTJWcjIzRk42V0hD?=
 =?utf-8?B?cjJodk1WVE83VGFrNTVDNXl4eXRSbFZuUWxZdWtodUZscStXRUxScFJ5ZU11?=
 =?utf-8?B?R3BXODNHR21sVy9BWFptNzAxMnBRUktEaW5iUVgzenA4QTdyeTZTM1lSR0Rl?=
 =?utf-8?B?UG1zcUxBVEFJY1hkNXRjcWE4MyswenowL0U2UjM2bC82Zml1cmVhNm10YVdh?=
 =?utf-8?B?dUFNaERER3UweFpvZzkzcFR1RGdPeXRTTzVRM1I0VEJQaW8zNEFnakptaTNC?=
 =?utf-8?B?bjZkSkE5YXFIZDJiNDJkSzNiOW51cktjaHVEbEc2azBtQVNMK0F0bEcyNUVj?=
 =?utf-8?B?OVZiaFMvbGNTQ3E1cXlZRkRhTVRTallLLzZ2L3FndkhXaWtjRGRlODJrUHNX?=
 =?utf-8?B?L21sR2hidGV1TDFld25PeHY3QitwZVIvRkt3azBLdSs1ZFBlVWVuTHNtaER1?=
 =?utf-8?B?RUVCQkk2aG9XK2wxVXAvbVRjVENOV2Z2QUdvVWhCODh0UFA5emVFWjVmL205?=
 =?utf-8?B?SzV6TndLSzA2M0NNY0s5b0VBTmp3SkRNdERNOUJsVW9COG1MZzJtck9JekI5?=
 =?utf-8?B?dFIrd3dRREJVNVZjREtiUGlmaElMdE9UcktuWkRXQnd6bklGNlRpOE1wenpU?=
 =?utf-8?B?aENJekt1SUs4eGZXTStWaVVJZzdpcXVBVmZXa09DdE9nTWxxNXd0ek1XMGlj?=
 =?utf-8?B?Q1JtVFk0TVpBMSs1NGM0SHNEdVphWWNMSzl5amxyRnFYeDNqN3JOc3VDQmdU?=
 =?utf-8?B?a0ZvUDh6Sk0weWJyczY3QmFUR2RjRVdLeExWaG9ycmlOekR4OFY1WnN1dm5X?=
 =?utf-8?B?VFY3bXNULzA1ZXNUcG5nY2FpTGljUnBXbEtjZ2p2M3ovWi90YUd4Wm92bFFk?=
 =?utf-8?B?WTV6MFduSDhSY0FuQW10b3p4NENCVTFzdTIyOWwzOWNOUWNGckdWeW5WSU5w?=
 =?utf-8?B?cEkzT1lnRyswOGdKaWwxdkc2ZVIzRGRvL2VOZnBLTzViQnpkUDZja1BXNFA1?=
 =?utf-8?B?ZndtZDRNOE5SZGNFUURIYkxGZ1NheWZDR2pHb0MwMHlZbGlDaU15TTRoS1N0?=
 =?utf-8?B?S0YxNGgvTFVqN1ZHRHpTaUpqWjhueHVHOG0rSm4wdHlJU0ZsV0thRTkyQkJt?=
 =?utf-8?B?dXB0Nm90SVY0ZlRTbnh1Zm15c1lITzBZaUt0WWxLdmJwQ3VpZ0FLSy9TdmZ6?=
 =?utf-8?B?a2twRVNnVWdwKzFsWGFIMi8xaWJQVHBpdzdyWVhBYjQxTWU4dmVMUTRTaFha?=
 =?utf-8?B?MlJ2SDVTd3JFRVF6TlpBdUJ5ZE1FNzR2d2Nqa3ZVYSt1TWpNK0xQeGkzVXRP?=
 =?utf-8?B?TjAyZ25FL3VsMHB6R3E0cEljK3dMZmVmTDBwN0orK3B1UXdvZWtaclJvaUN5?=
 =?utf-8?B?Y1JJalpMK3lTMWFheERpcG5TTWpnalM1Q2ZxUTBTamxBV1huUkVGQVFteStt?=
 =?utf-8?B?SjJKaTE4enFSMnIwdmJtZm5UT2xlcTIrTGNacmt3REF4dVRMVlZkbGhuMVFY?=
 =?utf-8?B?RWk2Zmx3WnhCd3BvTkZVT0c3d2hLZlNyUmpqNkJxYnNaNkgwR05XV2lCVDg3?=
 =?utf-8?B?K1FkSnlvem5oQ0JkUld0dnFyWGZiOWViQVNOK1hnYWY4S3JKSmxGWWlkamIw?=
 =?utf-8?B?b1hOdHlYb2cvR2NBU1hYVEorRjNLZUl2NXdyTEpnUURxUkdxd3JMeXFnU3pU?=
 =?utf-8?Q?e3k4+iFL53jp/v1XwO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4691.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be5c716-8a09-417e-e541-08d9d1032771
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 10:56:12.4809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZtSxuorJAuMUrzG6KNHmexFKbQuz2b57PigbcAUaAr9eJ5c7euHDv2bJtlx8bj9LIYXVrna39HIcxyTf3fLbEjuq9o4a4Xr8nQhXgMieKGoJ5fLNNnOtO/wW4jdxWuY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4648
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSGVyYmVydCwNCg0KR2VudGxlIHBpbmcgb24gdGhpcyBWMy4gSSBzZWUgdGhhdCBpbiBQ
YXRjaHdvcmsgdGhpcyBzZXJpZXMgc3RhdGUgaXMgc2V0IHRvICJEZWZlcnJlZCIuDQoNCklzIHRo
ZXJlIGFueXRoaW5nIG1pc3NpbmcgaGVyZSB0byBwcm9jZWVkIGZ1cnRoZXI/DQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV5IFpoaXpoaWtpbiA8YW5kcmV5Lnpo
aXpoaWtpbkBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJl
ciA4LCAyMDIxIDEyOjAyIEFNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IG1pY2hhZWxAd2Fs
bGUuY2M7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
ZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC0NCj4gaW14QG54cC5jb207IGhvcmlhLmdlYW50YUBu
eHAuY29tOyBwYW5rYWouZ3VwdGFAbnhwLmNvbTsNCj4gaGVyYmVydEBnb25kb3IuYXBhbmEub3Jn
LmF1OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBxaWFu
Z3FpbmcuemhhbmdAbnhwLmNvbTsgcGVuZy5mYW5AbnhwLmNvbTsgYWxpY2UuZ3VvQG54cC5jb207
IGFmb3JkMTczQGdtYWlsLmNvbTsNCj4gZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlOyBrcnpr
QGtlcm5lbC5vcmc7IHNoZW5naml1LndhbmdAbnhwLmNvbTsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc7IHBpbmcuYmFpQG54cC5jb207IGRhbmllbC5iYWx1dGFAbnhwLmNvbTsNCj4ganVu
LmxpQG54cC5jb207IG1hcmV4QGRlbnguZGU7IHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tOyBt
YXJ0aW5rQHBvc3Rlby5kZTsNCj4gbGVvbmFyZC5jcmVzdGV6QG54cC5jb207IGhvbmd4aW5nLnpo
dUBueHAuY29tOyBhZ3hAc2lneGNwdS5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBjcnlwdG9A
dmdlci5rZXJuZWwub3JnOyBvcC10ZWVAbGlzdHMudHJ1c3RlZGZpcm13YXJlLm9yZzsgQW5kcmV5
IFpoaXpoaWtpbg0KPiA8YW5kcmV5LnpoaXpoaWtpbkBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIIHYzIDAvMl0gQ0FBTSBEcml2ZXI6IHJlLWZhY3RvciBhbmQgc2V0IHBy
b3BlciBKUiBzdGF0dXMNCj4gDQo+IFRoaXMgVjMgc2VyaWVzIGNvdmVycyBwb2ludHMgdW5jb3Zl
cmVkIGR1cmluZyB0aGUgcmV2aWV3IG9mIHRoZSBwcmV2aW91cw0KPiBzZXJpZXMsIG9uZSBtYWpv
ciBwb2ludCBiZWluZyB0aGF0IHJlZ2lzdGVyIHJlYWRvdXQgc2hvdWxkIG5vdCBiZSB1c2VkDQo+
IGZvciBkeW5hbWljIEpSIGF2YWlsYWJpbGl0eSBjaGVjayBkdWUgdG8gaXRzIHVucmVsaWFiaWxp
dHkuDQo+IA0KPiBJbnN0ZWFkLCBKUiBzaG91bGQgaGF2ZSBhIHByb3BlciBzdGF0dXMgc2V0IGlu
IEZEVCB3aGljaCBpbmRpY2F0ZXMgdGhlDQo+IGF2YWlsYWJpbGl0eSBvZiB0aGUgcmluZyBpbiBO
Uy1Xb3JsZC4gVGhpcyBzdGF0dXMgaXMgYWxpZ25lZCB3aXRoIHdoYXQNCj4gQm9vdFJPTSBjb2Rl
IGNvbmZpZ3VyZXMsIGFuZCBjYW4gYmUgbW9kaWZpZWQgYnkgYWxsIGFjdG9ycyBpbiB0aGUgYm9v
dA0KPiBjaGFpbi4NCj4gDQo+IFRoZXJlZm9yZSwgcGF0Y2ggaW4gVjIgc2VyaWVzIHRoYXQgd2Fz
IGhhbmRsaW5nIHRoZSBkeW5hbWljIEpSDQo+IGF2YWlsYWJpbGl0eSBjaGVjayBpcyBkcm9wcGVk
IGluIHRoaXMgc2VyaWVzIGFuZCByZXBsYWNlZCBieSB0aGUgcGF0Y2gNCj4gd2hpY2ggc2V0cyBw
cm9wZXIgRFQgc3RhdHVzIGZvciBKUiBub2Rlcy4NCj4gDQo+IEFuZHJleSBaaGl6aGlraW4gKDIp
Og0KPiAgIGNyeXB0bzogY2FhbSAtIGNvbnZlcnQgdG8gdXNlIGNhcGFiaWxpdGllcw0KPiAgIGFy
bTY0OiBkdHM6IGlteDhtOiBkZWZpbmUgcHJvcGVyIHN0YXR1cyBmb3IgY2FhbSBqcg0KPiANCj4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgICA0ICsNCj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpIHwgICA0ICsNCj4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpIHwgICA0ICsNCj4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpIHwgICA0ICsNCj4gIGRyaXZlcnMvY3J5
cHRvL2NhYW0vY2FhbWFsZ19xaS5jICAgICAgICAgIHwgICAyICstDQo+ICBkcml2ZXJzL2NyeXB0
by9jYWFtL2N0cmwuYyAgICAgICAgICAgICAgICB8IDExNSArKysrKysrKysrKysrKy0tLS0tLS0t
DQo+ICBkcml2ZXJzL2NyeXB0by9jYWFtL2ludGVybi5oICAgICAgICAgICAgICB8ICAyMCArKy0t
DQo+ICBkcml2ZXJzL2NyeXB0by9jYWFtL2pyLmMgICAgICAgICAgICAgICAgICB8ICAxOSArKyst
DQo+ICBkcml2ZXJzL2NyeXB0by9jYWFtL3JlZ3MuaCAgICAgICAgICAgICAgICB8ICAgMiAtDQo+
ICA5IGZpbGVzIGNoYW5nZWQsIDEyMiBpbnNlcnRpb25zKCspLCA1MiBkZWxldGlvbnMoLSkNCj4g
DQo+IA0KPiBiYXNlLWNvbW1pdDogMDRmZTk5YThkOTM2ZDQ2YTMxMGNhNjFiOGI2M2RjMjcwOTYy
YmYwMQ0KPiAtLQ0KPiAyLjI1LjENCj4gDQoNCi0tIGFuZHJleQ0K
