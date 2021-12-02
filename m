Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D3466049
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356394AbhLBJ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:28:09 -0500
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:40769
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356342AbhLBJ2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:28:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4QApopwkOi/O2mxUtN6A983SA7FfexzE3lcQ27PsR0aJQQl/pxMajkL8yHg4j6/1MtwTIr9vuMgwguOxVttIyJC8Q2y75cYpu7MhEADYfX89gXKYakcUk/eWBLiWuvi3nuXm2N+6tJkkB3X1CxPYa+3XxQ9KFqgAtYjZs/wxuCFwfS3eIFFLUkaBQlV54RCeSpZKnYqnkgUq2BBQSBFtPlkoOaqpTqiwLooFAva9wIrEOzdgz8J3Diy+lv/oHaX5tYYVCIRBDx2srxWD8YoSEBc9ttrVPTMQd+FbjhLtJiggJTeHVmudZGyxNrcv3cEyHIgWwOKISTUUvnBaRVpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yWkdvtnCGpkWq83O5+oMAQdUBM/kUyXmcKRZPsQ53U=;
 b=folhfBh8EaehI6tPb1dnHP3BIZ4nW+7xhb7QbE1FMlmiIaDAWktmeGkACM+Bn/s6PzlwTt1rjbLWw3KOZsB4DgnBKDbPPRsD+hMI3y1l/ui3TaC7KTGVSW9PWCzLiF01ouBKzbDkvh3L7mwNK1GnAwGsq2gNrGb9KW+jaiHlqlJclAp8Tt5hRkY5mpe6PuHkjzsLnNLwWIXOBgLXmEoPVo3mOZdoLaTZCQw4Cjp0ue1+tKDbob4MhMTYD57fmgTSP38m3V9yMS+A8aukLnDyaAq4a7+I15f5n//WiQowyyBch+VspiI6ACqG4CcCRqWx/gbHSx4SGkBPWbWZHQDF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yWkdvtnCGpkWq83O5+oMAQdUBM/kUyXmcKRZPsQ53U=;
 b=cqQNoX7JZb9RNrutT3S/fZcjvlM5KjWTpCFsdoLmJzgf/FdGnbRMXSSj/dK840Sli+npNF4Lvj95AqZ+fyuP5UINrZQL/GBoAXssfR8BVdSqQOGGI52DKdAaLh11ssPyWAK9LRoRb79Qd7R2rGkH9toYgyffvyAmNrwVtDI9fEQ=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3590.eurprd04.prod.outlook.com (2603:10a6:209:5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 09:24:35 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.028; Thu, 2 Dec 2021
 09:24:35 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v13 04/13] media: amphion: add vpu core driver
Thread-Topic: [EXT] Re: [PATCH v13 04/13] media: amphion: add vpu core driver
Thread-Index: AQHX5c0I/CqWIb6L10+FVoyKwJl1tKwe66UAgAAED1A=
Date:   Thu, 2 Dec 2021 09:24:35 +0000
Message-ID: <AM6PR04MB6341380F082DA9A9BEAB899AE7699@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
 <041cfcb9c52e2c3a4e8f5927e23f1b3c70ee44f8.1638263914.git.ming.qian@nxp.com>
 <1a73baa3-3cde-8f47-f154-683650e02351@xs4all.nl>
In-Reply-To: <1a73baa3-3cde-8f47-f154-683650e02351@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10fd75e0-73be-4540-ac14-08d9b5758ead
x-ms-traffictypediagnostic: AM6PR0402MB3590:
x-microsoft-antispam-prvs: <AM6PR0402MB3590751825D40B473E5ABFE9E7699@AM6PR0402MB3590.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUpFw3cEqyf+NrZyPhoyg5JQGSZrnlAjdytlqg8WAE/1jRP7GzCUr0i6qksV/xSLnRDQMOXLtvoI1pGjaHScQUXHOedxvUNq0gJMz9Ryb3W5RW0T02+yFtwFrENGS/Ea/kvFlSU++aa/CnTDG92BP2yNXIRW3nPOKYQum1s/B+6WVxAm0C1tLUDZWqxDj+nA9MAr/7UJAUuFuJHu6n7D3f0EUDjYs2+icNzABugsTeQyClTI2sTjebx8xk3bcc6w3ZrvG/wENofd97SiFR8yBAimGsLniLrnlUv05iuIyB8xVmCgneTlrfP2nwYLVKmBCogSVkUNLxyljdikJ4xPvv7pLzpJGtvNCcJCGFCNFpzcXsK7Ubvjt1semRTGlMVtQPCRhG7DBevUmoGHXQG56gUfWy5z4lEDfu/OAw2HLM+SZw/sQAR/G1pHDDSx1zW/VEOVfIK4UjQXq25dCD4SjnKkYyWJqLhUVkzfDlavLSdwqIntXi1ki9RQ7c4ExWx6snI+G6e0XnKFxK2Ce/d4b29LvA47dswjzqfnQQgoQZNPPMBuOzlznD02+xDbOETFFrKTnGmeQKWD/1v58Xf/mXQO12PdtRAaron+TuHJb6sDaqdPP0HYXXx85FXjyyYnF45ay2aoXj34hXv/+yJ3B3Oo37aZuYsTGnXLRy9XkCdXh82Fx6gEN3jZD6IJXvbff5yPr4zNHGBAYgxlbYGrIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(9686003)(54906003)(53546011)(8936002)(66446008)(66476007)(64756008)(86362001)(122000001)(83380400001)(38100700002)(6506007)(7696005)(8676002)(26005)(33656002)(52536014)(2906002)(508600001)(38070700005)(76116006)(44832011)(71200400001)(110136005)(66946007)(316002)(55016003)(186003)(4326008)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXl0V0JnWS9HNWs3dFJweTNnM0thcVRKc2pkVktjUE9OMmgwTjVtbk90OTE1?=
 =?utf-8?B?OXNHZTBtT3Fld1JOMzdxWXRKcjhXV200ZTJibmFkYmx1V0FCWHJOWjFtTjJB?=
 =?utf-8?B?MUQycTF1ZytyTlUxNHpJS1R3dGtVL3ozcUw4SGM0L3ZrVHo3cyt2L1htTXZP?=
 =?utf-8?B?cUR3Y29rMjRmL3F3ZEtraEY1RCtuVmNHaDJGeUhVVi94R3FPOGg0ejF6eWhH?=
 =?utf-8?B?UjRkaXFHU3VHM09mcWlQcEp3bmdBWERWUElZbVpKMzdqVTdXbk5MNzdqdzQ1?=
 =?utf-8?B?VWZaSHBXb2FNSGN0LzZUL1lJWmRaNHNQYzgzT2tSUmRsYUxGVmJicTBrQita?=
 =?utf-8?B?MmNNNjhaejB0MTRxdzVLc1J2YTFYWFBWT3B6em13Q2pmelhmdlcwWlpybk9q?=
 =?utf-8?B?MjE5TURqTnRGWEt5TG13Qk5kQUt0TzJOZy9xczhveVN1cWdHS0owNVlTNlhp?=
 =?utf-8?B?aUZYUzVwS0UvazA4ZTJqaWVPcDFrTytoK3FWeXY1WGo2VTRScWdoYlNBVm5X?=
 =?utf-8?B?c0Vza3hjZUJONi9mWWU0MXhXUi8vRGEvOEJWdlZZRmN4N05jVnhUS0IrL1pY?=
 =?utf-8?B?NVExWFgyZzVJcmMrU3piSzZzWXZYTkw5ekF3Tk1QRWRPNGl6aGw4Ykt4bE12?=
 =?utf-8?B?b1pmTndkeTFCS2JnU1dzMGdLdytHTElKWXhMU2ZaalRTNDRMNXQ0RjdUTmlm?=
 =?utf-8?B?b3hHeWJiclVmdTIvRy9rdWkvUGVOZFZ4dk9yYUVMM2hrMWV0dWRrV0ZON21x?=
 =?utf-8?B?M21wT2kzamtFLzZMOGlvSThOaStnTDUyRnVrdzBBSVcxUXJITjFRaDNrY1Fo?=
 =?utf-8?B?YkJCUkg2M1VFZEh0dmRVdUlVLzNCelZybFA0d3NvT2ZUL2xMUGNhUHMrYjNr?=
 =?utf-8?B?Q0VjUHdnSCtTYTU1U3lmZkxvd09ZTTFwY0xSdTMvcCtCbUxhSHk5OFNWRFQv?=
 =?utf-8?B?eVE3WHNLQ1F1OU0zM1VhWmJ0aE8wTlFHeWk5MFIya0FlT05vaFFsZm9qTEl1?=
 =?utf-8?B?REU2ZHI5cW5XaGJ4ZjNEelBYVUt6QVArTUFhQ0hybktsb005Q2RoZEVsUWxD?=
 =?utf-8?B?Vk1FZ2RBWlMrc0djYldDb3F5aWx0N3RnK3JaNjZBSU52TkJRWFJXR0xpU0NX?=
 =?utf-8?B?Z3BHZnFEVEFybXdnYkNrVEdOUjQ4cDhYVlEzVGUvN05kOUdycFEvUlN2TWZm?=
 =?utf-8?B?ZERaWm1VNUh2dk0rS1NNNEJDQ29FdWtBS3hSUDc2RXJUU2NJK200c2pUNVBH?=
 =?utf-8?B?YmdBV0lVck9MakxxU2x3alk3TzRnZDFRczZqSkNlQWZxUU5YRC9HaDdZN3Y0?=
 =?utf-8?B?YisyRERGM3JsZUt0NGVOZm5YU3Mwc2FpZkRTL0t3VG4xMzZJcStLSG96VWRq?=
 =?utf-8?B?ZHFXVWZEelppSWhkbmtjU0tKQ0hqRUMrVUNRb0RIblNVWFlYUHVuUldLa3pm?=
 =?utf-8?B?WURnTnRSejVXRU9Lc2gvbHZ5ZFNjRHY4UkZrMmpwMHNuY0NZUkZNbFpnQ2Vk?=
 =?utf-8?B?b2VPRS9NeWpURzNUY0dZUS9hSTdWWjEyaDA1ZHpEdGYrNnU1SVgxSFlYRFhi?=
 =?utf-8?B?MFdqUndOWGVGMGlhYVNtZlc1VkMvWDdTK0JQbXk5cGNCWVVKWWRtSmlwcitL?=
 =?utf-8?B?K2NYUHhVbjJmQ2pEbnI0NHVLY1hOTGF5NlFtMEpBMGY0bDFVYXJMQjlJR3dy?=
 =?utf-8?B?QmZQdW1Wemh6cGJORWhDcVpxVTlHSThnTUJoYXdTWCtPbGcwNUJQYzVxenRY?=
 =?utf-8?B?MUN5dzU3czBYL0RyZGFHUVVLTFBDRHZENWg1Rm90OTJ1T1E1SDhWaTZiZ1hj?=
 =?utf-8?B?d3NIcEhKM0Z2UE9lSDNKYUJtbXZsQmRyY2pxMFgxQ0hUZ1hNMEVuallMdU5P?=
 =?utf-8?B?bUs5akhWUVFUV01CYkJnN3RqMjFweXcraWFEYk5aa09IcDlHV0lzWmRDTmdl?=
 =?utf-8?B?YUljYThEZU9jS1lxVHZkTkg1aTJ3S3YvcC9uZXRvSjltbm0yRHMyRmorYmQ4?=
 =?utf-8?B?aE5NQk05S211emQrT25iQ1E0TmlRUU5nbGpMTUtMNzZ2MDRzcUxmWFV5bGg2?=
 =?utf-8?B?cWMzWnFQS2lBQjZTd1lZWnVtb05OT1NaSHNyZGk5NFdvcFBTZWs0WVdIMGl2?=
 =?utf-8?B?czdOTVNOT0p3SkV3ZzJEM2ticFVhSEtWY0xhTm95OVQzd3J4MktFS0l4NG1B?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fd75e0-73be-4540-ac14-08d9b5758ead
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 09:24:35.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xo9aPErQkU5k9blA+MDN1ByDAneCcId5WQUP2uCj6MgYw+Mz9qDz1qi2q9nbvCwFmSz/YRO1EA1MKpsTNSzNUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3590
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIFZlcmt1aWwgW21haWx0
bzpodmVya3VpbC1jaXNjb0B4czRhbGwubmxdDQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAy
LCAyMDIxIDU6MDUgUE0NCj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hl
aGFiQGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9y
Zzsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBm
ZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBB
aXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsNCj4gbGludXgtbWVkaWFAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1
YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjEzIDA0LzEzXSBtZWRpYTogYW1waGlvbjogYWRkIHZw
dSBjb3JlIGRyaXZlcg0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAzMC8xMS8y
MDIxIDEwOjQ4LCBNaW5nIFFpYW4gd3JvdGU6DQo+ID4gVGhlIHZwdSBzdXBwb3J0cyBlbmNvZGVy
IGFuZCBkZWNvZGVyLg0KPiA+IGl0IG5lZWRzIG11IGNvcmUgdG8gaGFuZGxlIGl0Lg0KPiANCj4g
Im11IGNvcmUiPyBEbyB5b3UgbWVhbiAidnB1IGNvcmUiPyBJZiBub3QsIHRoZW4gd2hhdCBpcyBh
ICJtdSBjb3JlIj8NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiAgICAgICAgIEhhbnMNCg0KWWVzLCBp
dCBtZWFucyAidnB1IGNvcmUiLCB3ZSBvZnRlbiBjYWxsIGl0IG11IGludGVybmFsbHkuDQpJJ20g
c29ycnkgdGhhdCBteSBzdGF0ZW1lbnQgY2F1c2VkIGNvbmZ1c2lvbg0KDQo+IA0KPiA+IGNvcmUg
d2lsbCBydW4gZWl0aGVyIGVuY29kZXIgb3IgZGVjb2RlciBmaXJtd2FyZS4NCj4gPg0KPiA+IFRo
aXMgZHJpdmVyIGlzIGZvciBzdXBwb3J0IHRoZSB2cHUgY29yZS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
U2hpamllIFFpbiA8c2hpamllLnFpbkBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpob3Ug
UGVuZyA8ZWFnbGUuemhvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2FtcGhpb24vdnB1X2NvZGVjLmggfCAgNjcgKysNCj4gPiAgZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9hbXBoaW9uL3ZwdV9jb3JlLmMgIHwgOTA2DQo+ICsrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2NvcmUuaCAgfCAgMTUg
Kw0KPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2RiZy5jICAgfCA0OTUg
KysrKysrKysrKysNCj4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9ycGMu
YyAgIHwgMjc5ICsrKysrKysNCj4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3Zw
dV9ycGMuaCAgIHwgNDY0ICsrKysrKysrKysrDQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgMjIyNiBp
bnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL3BsYXRm
b3JtL2FtcGhpb24vdnB1X2NvZGVjLmgNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfY29yZS5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2NvcmUuaA0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9kYmcuYw0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9y
cGMuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBo
aW9uL3ZwdV9ycGMuaA0KPiA+DQoNCg==
