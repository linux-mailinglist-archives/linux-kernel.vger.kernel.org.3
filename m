Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF0B49B2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381613AbiAYLTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:19:49 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:58529
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379876AbiAYLQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:16:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMknvuhyBS81wySiQ/tfoSAbXYwUvEU/RO9KBlrYZMmcOgFVL1XRonfNcJSjWPIm3vbIOvMwlClQAOGvJFiSAvQ4JHloCMbIzShNSG0T4syos2QgsK+NDLedqoQ3y5i6P3JOInZcY6kzKe845uY/mEnENhvoFdopx/gbR7sf93M97rT7SFMWDmkTMHqrehWz05K1/MNiFPq8mOcb6w4AegSkVfpEAHCZxeO7TU4glYO/aneGGaT9HSnAAwtNKDfojq1KOR5pVkH/tF4I5AoddUw3DLSk9C4JZeUpifZh2vWjauiwn8epghTJDkmXWW25X92Dqdq+U4dAmbeL8k3OuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75ze25e9GtU/54Vy/lGDSb+qD3CLpkbFq71NH24TJVg=;
 b=HFocykOWANCGczYp3ZFVxNWC7K1wSxoAzgmDu0Gd4GY8+zpWAASdraGwmBaK5kjk9tAwOw32Aj8nWRMkx5c0o82aefGHzzTcjfrHcwvmLu+ngNUzTd8pxDjl6ziU7pCvSiWzKsct+Rt4ASb62FkvLG9iSuBgUAyvcHawTE1HVFrtvG4o4oBDqxztg2CfkIr41STg4zeYLaC0JyN+V8fl9xZRfa5dX4WCm8j0Bkk/ZX86x5UiyJTLXXwSfPGR1JgJfBevIjegYq98bPuF4h6WeqqTe97Rhdo+m8RNW96M25VOd57W8hy4PD8P7yWzyutEemyHbkWYRJPrdtSqNKfzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75ze25e9GtU/54Vy/lGDSb+qD3CLpkbFq71NH24TJVg=;
 b=IPZQ5IiXm2HMgQ4wCTxnP54OtVFz/lBSiwGYMvySUsw45Dcd29aEyCj42WdV2PaRfHujfazIXJZbu38DYDWy2TUVfPTHbyKcao4Yo2zUCuzShTuiEd8pB7ktd7ryn7o/AXo6qaKajf5pL3gTflsn33izbRHHin5OvGBLV8aYb/Y=
Received: from DM8PR02MB7926.namprd02.prod.outlook.com (2603:10b6:8:31::9) by
 MN2PR02MB6768.namprd02.prod.outlook.com (2603:10b6:208:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 11:16:02 +0000
Received: from DM8PR02MB7926.namprd02.prod.outlook.com
 ([fe80::1da8:d2cc:796a:2879]) by DM8PR02MB7926.namprd02.prod.outlook.com
 ([fe80::1da8:d2cc:796a:2879%8]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 11:16:01 +0000
From:   Amit Kumar Kumar Mahapatra <akumarma@xilinx.com>
To:     Michal Simek <monstr@monstr.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Olga Kitaina <okitain@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Naga Sureshkumar Relli <nagasure@xlnx.xilinx.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mtd: rawnand: arasan: Fix clock rate in NV-DDR
Thread-Topic: [PATCH] mtd: rawnand: arasan: Fix clock rate in NV-DDR
Thread-Index: AQHX5ou2Bf7LXMmLqE2BkrzECsGUyqxz6uWw
Date:   Tue, 25 Jan 2022 11:16:01 +0000
Message-ID: <DM8PR02MB7926290BAD4269B690A3C074BA5F9@DM8PR02MB7926.namprd02.prod.outlook.com>
References: <20211127180758.30884-1-okitain@gmail.com>
 <20211129095559.01aa63a6@xps13>
 <3da5dff5-53d4-15db-075d-9b195f2f75dd@gmail.com>
 <20211130082017.1400f24b@xps13>
 <fb6a4b49-7c10-4ed1-7054-5dd8ce2d8073@gmail.com>
 <20211201090941.73e67f65@xps13>
 <734dfe79-6e3f-1e68-c167-bab3ae9e8d52@monstr.eu>
In-Reply-To: <734dfe79-6e3f-1e68-c167-bab3ae9e8d52@monstr.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd18779d-39d1-4450-0a1b-08d9dff4121b
x-ms-traffictypediagnostic: MN2PR02MB6768:EE_
x-microsoft-antispam-prvs: <MN2PR02MB676849ECB518EFFB6758451FBA5F9@MN2PR02MB6768.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9b1uqcporAlpJvEYvwebSty+EhwBwSAIOk9+fxvwmLAjKWe7x6bcKAoyEuglG9A+iGR1RKSnqxIBb7kyafAKU6/vv0nhmeMceP5CvNLZlFIyutcqFBkpfnIyDxDcmiTTx8ozyhmFOMAeWqPx665Pol4Gh1hBjLOjnBnVEnnw82diPm4xHOTFtTiZzvEy3TUTg3CaeTaaT8HVi6EVkBkHYFwquE3yO5rdv/M2LrN2aQguur8jra7asamKm0GRhe7+oGUmFQgcDoKgNPKq/BFMIn5nCKmFGTL5dHRrTcF6g/MOpuhsOYpLX33oV5Y2Nzw1z80WjsXjlL4EKd5u5ysEdUzWX0RC0lyk0tmyL8IRGX7hc+jZwAW4FABU1m83DWDrZxdOhpIuDBc3os965hFdllDXZUPFy6c3qGUmPqovmJzQDmlP80x5Ft0/rZQKupMDxBYWsG/kOQ78DuTyQrw2TbM/4k4SD4NZaLa/4OkRHb1QOzd2FWQQLH1x9nGKIyAAyLGfHrA2xNYn2XxsyVIfX3USRKnad1qh8oGlUJjezJDTqwVxHpnqgqpVGGN1Q585bJGZ74My8qLwVQ3p8HnGmP9RZTfsKMqy7hjkDXFBkd97lePuQWXmvwTphATK+mjsQ4yyF6d1Ziu4ozGuLOdfz3G4UnYs/oTj3cHGBvCZFD8iAOPmcfbvXLBwycSujeHWCR6rpn7nr/UAyff4bJQHsd0wB/HyIHCW3F8PB8l989W7xil7mLUFC1ZrB+Ia+hCyRXKPsoV6SCeDLdTscl9bFzthe+MynF+AbC8NkecUbM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB7926.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8676002)(186003)(8936002)(4326008)(71200400001)(66446008)(64756008)(66476007)(33656002)(66556008)(66946007)(76116006)(54906003)(316002)(38100700002)(26005)(508600001)(86362001)(15974865002)(122000001)(110136005)(52536014)(38070700005)(5660300002)(7696005)(2906002)(6506007)(53546011)(55016003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZ0eCtvL21SSDU2ai9QSjluY1Q5aHZTenFnazdSS1hGdU54U21nUUcrbTRR?=
 =?utf-8?B?a0lHenBlSHk3Z2xmSkhJbjVTWmFqUmlhZFY4bG1Bc1d4K2RFS3NCL2c4TzZq?=
 =?utf-8?B?YkhwS3BjZmJqVlV3Wk5mdzgyYndBM0VZMDhTZjhBbUkxSEFyQWJEaFQ3YlNO?=
 =?utf-8?B?L1Z6WW5XS3RINE96SFh0TU53SW5scEtVWlJva0srSWlpVTJDbFp1NUxMWnV3?=
 =?utf-8?B?M1BDejFtRFV1dmxObktVNFYvS2FmZjN4V1RTSTNFeURPWlZJMFFZbFY4K3Zo?=
 =?utf-8?B?UGY5WlJjNXNqVDN6S0lVaTM1WjNPUTdwbURCajlZS2NOUU9tWWY3VmI1Tkc3?=
 =?utf-8?B?UHFIdUltbE1meDFibVVXeklsRmFTSDRsVXMvMlV0MUQxbU9OdkhMN3RSQUZp?=
 =?utf-8?B?dWh2MkQ0VlBTNXR0QWJiT1RiZ0EyYVMrU0cyazMydXIvUHlQSlZrcTZ4UzBo?=
 =?utf-8?B?ZXBXQzVHQlBVRXphSW1YWC9Od0tBY1hCWGp1NkE5SFZjbml0Um80SzROQmN0?=
 =?utf-8?B?b1AxSCtUVDBvVnZ2SlVLUUMwbFJrNHhZWHVxRVp6cVVaZVd3RUJtRVNRV0c0?=
 =?utf-8?B?cVg0WndKRnNSWFF4YUtieFlmazZVRzBtRXRwQWFDK3RLM1RpdzJRRVY3K1Bw?=
 =?utf-8?B?ZnVRczZQWWZoMEd1ZUl1MjZxemNaaEQ4Q2JIZWlPMnlVcjhTUWxldlE3b1Ba?=
 =?utf-8?B?OWZGR2RJWVVOWDU2bFFSRndCQWhPVExTVngwdUczaDZCeUtZSW5lT0dyN21X?=
 =?utf-8?B?WXFEc3JYcWd6U0hSYmFSd0lKVXUwckh2SjZNaWVuS0pDVGlGMjhzNitEY21i?=
 =?utf-8?B?NzYwVEp3cjJoQVlOWnhOdXo0SzZ2a3NiamN3SnFmQndoTTRBNVVQaDJhLy8z?=
 =?utf-8?B?U2ZLZ1ZCQkRkbHcyTWFodDAydkxIZ29TRGRSZUlhTVU2MnlKVTV1ZmU0UnMy?=
 =?utf-8?B?Sjh0T0FzZWN4ZkoySU9vMkFjeHJ4N3dmZlVjT0JrUkxGVGJXOVZCWU9WTkhT?=
 =?utf-8?B?cVplUEtHblVieUpIRnNtdUxSZm11Ny9CMkszR0hZb0FTWmRuaWN3R3JQMVBi?=
 =?utf-8?B?SnlBL1A1Nlc3bDhaWUwwa0JvTFQ2TTczVThEQnA2emhvRU5zemhxZElXNGln?=
 =?utf-8?B?eVFCTEI2TnFlT2JMRDZQVHZqUzJRaU1UbStTNW1yMlZRMlFkSCt3QkxUVlB3?=
 =?utf-8?B?YkNxbytYREpvdDlFQUd1OEEvRXVrZkNIaVY3RVdzNUhJRVdLV09HMldVTktU?=
 =?utf-8?B?eTc0V2hON3ZlcXRMRkVIblhKSjByT3dPcys2dnZrdUVCWmVQV0Y0b3FZVkV1?=
 =?utf-8?B?SzFQRmF0QXJINzc1UlRlSkFBSnhuQkRpR0NzaTkxaUlaSmZHUC85aFA2VFND?=
 =?utf-8?B?UVVXNlBHemhWWEoxZDhQZzRLeG5LK2JYWDJ5TDJGSDcycFA0dVVhZFFmcUFU?=
 =?utf-8?B?MGZFTVFDdjRzaXJUYnRjR1V6K0dmc0NkNmU3TnVpc0FEWEpvK1kwQlB5Smsv?=
 =?utf-8?B?bzJSbUlraWZUUTI4bTRKdGJySXIzRWk4TkJjNitXOTZNWE5VS0pZTEJ2Q1Ay?=
 =?utf-8?B?d3R4SUR3amwrZWtKZ3UzQkcwdmN6WXNZTHRxL1ZtQktIUzNwK2RuMGhGcitl?=
 =?utf-8?B?UjhvNGtSZHFRczZHZCt5TmVvdXozQytYempWT3dhZUcyZFNoeWVSbzBBdXRv?=
 =?utf-8?B?T0hvbTRZSGpuWitXL0xvc3JrRjR6c2xJazdFbGZhSWM3RzZZVE5jTFB3anNZ?=
 =?utf-8?B?eGYvdlY4Ym1aWTcwZkh4VlZqbThoMU04clZSdDk5RjFQdnlhcWV3VWwwV0ZB?=
 =?utf-8?B?L2xnQmd4L2VRUDFvdklzaVFuVnpSY3hjbVVhbUZOWnhveVZFQUFaR3p3S05S?=
 =?utf-8?B?OENlT1UwdDUzNFJpanV0dXZ0YUJSeWhFcSs5ald4bTVVVEdEbThxUVBZdUpS?=
 =?utf-8?B?ZW4vSUtiUWpaM1VNL2owUVl1VG1hRGo1Ym9TY2lNTGxqanJUMGVVdWgvV3pN?=
 =?utf-8?B?b29FU0pvSk1lYnRGRitocHFGYlJCaVI2ZkVyQXp3VFZsbE9NSXhwS1F4bklP?=
 =?utf-8?B?UXpTeUQ2VG5MTzBIMGlQN1FoWDFaZkJyMHNUNzZYUmlta0pjZFdNcGVla05G?=
 =?utf-8?B?Y05sTkZRUzBzcFdqbU9Fc3hSdGNCYVZCUmttZC9IZXVwNHUyV0lFV1lYSUsr?=
 =?utf-8?Q?e2A1u8PwLvSyknAH8AUQDAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB7926.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd18779d-39d1-4450-0a1b-08d9dff4121b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 11:16:01.7318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBW/pSyOG2aoy3G/W6zdpSGDN07b73WeF6g3JVZdzXgcDXn/MS6618modPrLyLs4TOWo1RCtNnr9lfz6Iamllg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6768
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gT2xnYSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNo
YWwgU2ltZWsgPG1vbnN0ckBtb25zdHIuZXU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIg
MSwgMjAyMSAxOjQ2IFBNDQo+IFRvOiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3Rs
aW4uY29tPjsgT2xnYSBLaXRhaW5hDQo+IDxva2l0YWluQGdtYWlsLmNvbT47IEFtaXQgS3VtYXIg
S3VtYXIgTWFoYXBhdHJhDQo+IDxha3VtYXJtYUB4aWxpbnguY29tPg0KPiBDYzogbGludXgtbXRk
QGxpc3RzLmluZnJhZGVhZC5vcmc7IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gPG5hZ2FzdXJl
QHhsbngueGlsaW54LmNvbT47IHJpY2hhcmRAbm9kLmF0OyB2aWduZXNockB0aS5jb207IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG10ZDog
cmF3bmFuZDogYXJhc2FuOiBGaXggY2xvY2sgcmF0ZSBpbiBOVi1ERFINCj4gDQo+IEhpLA0KPiAN
Cj4gDQo+IE9uIDEyLzEvMjEgMDk6MDksIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+ID4gSGkgT2xn
YSwNCj4gPg0KPiA+ICsgTWljaGFsIChwbGVhc2UgYWRkIGhpbSBpbiBDYyBvZiB5b3VyIG5leHQg
aXRlcmF0aW9uKQ0KPiA+DQo+ID4gb2tpdGFpbkBnbWFpbC5jb20gd3JvdGUgb24gVHVlLCAzMCBO
b3YgMjAyMSAyMzowODoyMCArMDMwMDoNCj4gPg0KPiA+PiBIaSBNaXF1ZWwsDQo+ID4+DQo+ID4+
IE9uIDMwLjExLjIwMjEgMTA6MjAsIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+ID4+PiBIaSBPbGdh
LA0KPiA+Pj4NCj4gPj4+IG9raXRhaW5AZ21haWwuY29tIHdyb3RlIG9uIE1vbiwgMjkgTm92IDIw
MjEgMjE6MDY6MDUgKzAzMDA6DQo+ID4+Pg0KPiA+Pj4+IEhpIE1pcXVlbCwNCj4gPj4+Pg0KPiA+
Pj4+IE9uIDI5LjExLjIwMjEgMTE6NTUsIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+ID4+Pj4+IEhp
IE9sZ2EsDQo+ID4+Pj4+DQo+ID4+Pj4+IFBsZWFzZSBhZGQgYWxsIHRoZSBNVEQgbWFpbnRhaW5l
cnMgaW4gY29weSwgYXMgcmVxdWVzdGVkIGJ5DQo+ID4+Pj4+IGdldF9tYWludGFpbmVycy5wbC4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gb2tpdGFpbkBnbWFpbC5jb20gd3JvdGUgb24gU2F0LCAyNyBOb3Yg
MjAyMSAyMTowNzo1OA0KPiA+Pj4+PiArMDMwMDoNCj4gPj4+Pj4NCj4gPj4+Pj4+IEFjY29yZGlu
ZyB0byB0aGUgQXJhc2FuIE5BTkQgY29udHJvbGxlciBzcGVjLCB0aGUgZmxhc2ggY2xvY2sNCj4g
Pj4+Pj4+IHJhdGUgZm9yIFNEUiBtdXN0IGJlIDw9IDEwMCBNSHosIHdoaWxlIGZvciBOVi1ERFIg
aXQgbXVzdCBiZSB0aGUNCj4gPj4+Pj4+IHNhbWUgYXMgdGhlIHJhdGUgb2YgdGhlIENMSyBsaW5l
IGZvciB0aGUgbW9kZS4NCj4gPj4+Pj4NCj4gPj4+Pj4gSSBjb21wbGV0ZWx5IG1pc3NlZCB0aGF0
LCB3aGVyZSBkaWQgeW91IGdldCB0aGUgaW5mb3JtYXRpb24/DQo+ID4+Pj4NCj4gPj4+PiBUaGUg
IkRhdGEgSW50ZXJmYWNlIFRyYW5zaXRpb25zIiBjaGFwdGVyIG9mIHRoZSBzcGVjIGNvbnRhaW5z
DQo+ID4+Pj4gdGltaW5ncyBmb3IgZmxhc2ggY2xvY2sgc2V0dXAgaW4gTlYtRERSIGFuZCBOVi1E
RFIyIG1vZGVzLiBUaGUgInRpbWUNCj4gcGVyaW9kIiBvZiB0aG9zZSBjbG9ja3MgaXMgZXF1YWwg
dG8gdENLIGluIE5WLUREUiBhbmQgdFJDIGluIE5WLUREUjIuDQo+ID4+Pj4NCj4gPj4+PiBUaGUg
c2FtZSBjaGFwdGVyIHNob3VsZCBoYXZlIGluZm9ybWF0aW9uIGFib3V0IG5lY2Vzc2FyeSBzdGVw
cyB0bw0KPiA+Pj4+IHN3aXRjaCBmcm9tIE5WLUREUiB0byBTRFIsIHdoaWNoIGluY2x1ZGVzIHNl
dHRpbmcgdGhlIGZsYXNoIGNsb2NrIHRvDQo+IDEwMCBNSHouDQo+ID4+Pj4NCj4gPj4+Pg0KPiA+
Pj4+IEp1c3QgdG8gbWFrZSBzdXJlIGknbSBub3Qgc2hvb3RpbmcgbXlzZWxmIGluIHRoZSBmb290
OiBhbSBJIGNoYW5naW5nIHRoZQ0KPiByaWdodCBjbG9jaz8NCj4gPj4+PiBUaGUgZG9jdW1lbnRh
dGlvbiBwb2ludHMgb3V0IHRoYXQgd2UgaGF2ZSB0byBjaGFuZ2UgZmxhc2hfY2xrLA0KPiA+Pj4+
IHdoaWNoIGkgdGhvdWdodCB3YXMNCj4gPj4+PiBuZmMtPmNvbnRyb2xsZXJfY2xrIGFuZCBzZXQg
dXAgYnkgYW5hbmQtPmNsaywgYnV0IGl0IHNlZW1zIGxpa2UgaXQgbWlnaHQNCj4gYWN0dWFsbHkg
YmUgbmZjLT5idXNfY2xrLg0KPiA+Pj4NCj4gPj4+IEkgYmVsaWV2ZSBJIG1hZGUgYSBzZXJpb3Vz
IG1pc3Rha2UsIHJlLXJlYWRpbmcgdGhlIGNvZGUgaXQgZmVlbHMNCj4gPj4+IGxpa2UgSSdtIGNo
YW5naW5nIHRoZSBzeXN0ZW0ncyBjbG9jayAod2hpY2ggYmFzaWNhbGx5IGNoYW5nZXMNCj4gPj4+
IG5vdGhpbmcgaW4gb3VyDQo+ID4+PiBjYXNlKSBpbnN0ZWFkIG9mIGNoYW5naW5nIHRoZSBOQU5E
IGJ1cyBjbG9jay4NCj4gPj4+DQo+ID4+Pj4gSW4gdGhhdCBjYXNlLCBkb2VzIHNldHRpbmcgbmZj
LT5jb250cm9sbGVyX2NsayB0byAxMDAgTUh6IGJ5IGRlZmF1bHQNCj4gbWFrZSBzZW5zZT8NCj4g
Pj4+PiBUaGVyZSBpc24ndCBhIGhhcmQgbGltaXQgb24gd2hhdCB0aGUgc3lzdGVtIGNsb2NrIG1p
Z2h0IGJlIChiZXlvbmQNCj4gPj4+PiBhIHNwZWNpZmljIFNvQyksIGJ1dCB0aGVyZSBhcmUgdGlt
aW5nIHJlcXVpcmVtZW50cyBmb3IgdGhlIGZsYXNoDQo+ID4+Pj4gY2xvY2ssIGFuZCBzbyBzZXR0
aW5nIGEgc3BlY2lmaWMgc3lzdGVtIGNsb2NrIGZyZXF1ZW5jeSBzZWVtcw0KPiB1bm5lY2Vzc2Fy
eSBmb3IgbW9zdCBkZXZpY2VzLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gUGxlYXNlIGNyZWF0ZSBh
IHR3by1wYXRjaCBzZXJpZXM6DQo+ID4+PiAxLSBTZXR0aW5nIHRoZSByaWdodCBjbG9jayBpbiB0
aGUgY3VycmVudCBjb2RlIGJhc2UgKGludmVydGluZw0KPiA+Pj4gYnVzX2NsayBhbmQgY29udHJv
bGxlcl9jbGsgd2hlcmUgcmVsZXZhbnQsIHNldHRpbmcgb25lIHRvIDEwME1IeiBhbmQNCj4gPj4+
IGxldHRpbmcgdGhlIG90aGVyIGFzIGl0IGlzKQ0KPiA+Pj4gMi0gQ2hhbmdpbmcgdGhlIGRlZmF1
bHQgTlYtRERSIHJhdGUgYmFzZWQgb24gdENLIChiZWxvdyBwYXRjaCkuDQo+ID4+Pg0KPiA+Pj4g
RG8geW91IGhhdmUgdGhlIG5lY2Vzc2FyeSBoYXJkd2FyZSBmb3IgdGVzdGluZz8NCj4gPj4NCj4g
Pj4gSSdtIHNvcnJ5IHRvIHNheSAtIEkgZG8gbm90LiBUaGUgU29DIHRoaXMgcHJvYmxlbSB3YXMg
aW5pdGlhbGx5DQo+ID4+IG5vdGljZWQgb24gY2FuJ3QgcnVuIGxhdGVzdCBMaW51eCwgYW5kIGV2
ZW4gaWYgaXQgZGlkIEkgaGF2ZSBubyB3YXkgb2YNCj4gYWNxdWlyaW5nIGFuIE5WLUREUi1jYXBh
YmxlIGZsYXNoLg0KPiA+Pg0KPiA+PiBTaW5jZSBCb290bGluIG1lcmdlZCBpbiBOVi1ERFIgc3Vw
cG9ydCBpbnRvIHRoZSBrZXJuZWwsIGlzIGl0DQo+ID4+IHBvc3NpYmxlIGZvciB5b3UgdG8gdGVz
dCB0aGUgbmV4dCBpdGVyYXRpb24gb2YgdGhpcyBwYXRjaCBzZXJpZXMgb24gTlYtRERSDQo+IGhh
cmR3YXJlIGFzIHdlbGw/DQo+ID4+IFNheSwgYnkgcHVycG9zZWZ1bGx5IHByZXZlbnRpbmcgTlYt
RERSIG1vZGUgNSBmcm9tIGJlaW5nIGNob3NlbiBpbg0KPiBhbmZjX3NldHVwX2ludGVyZmFjZSgp
Pw0KPiA+DQo+ID4gSSBkb24ndCBoYXZlIHRoZSBoYXJkd2FyZSBhbnltb3JlLg0KPiA+DQo+ID4g
UGxlYXNlIHNlbmQgYSB2MiB3aXRoIHRoZSBuZWNlc3NhcnkgY2hhbmdlcywgdGhlbiB3ZSB3aWxs
IGFzayBOYWdhIChvcg0KPiA+IHNvbWVib2R5IGVsc2UgZnJvbSB0aGUgc2FtZSB0ZWFtKSB3aXRo
IGFjY2VzcyB0byB0aGUgYm9hcmQgdG8gdGVzdCBpdC4NCj4gDQo+IEtlZXAgQW1pdCBpbiBsb29w
LiBIZSBoYXMgYWNjZXNzIHRvIEhXIGFuZCBhYmxlIHRvIHRlc3QuDQoNCktpbmRseSBzZW5kIHRo
ZSBuZXh0IHZlcnNpb24sIEkgaGF2ZSB0aGUgcmVxdWlyZWQgc2V0dXAgSSB3aWxsIHRlc3QgaXQg
YW5kIGxldCB5b3Uga25vdy4NCg0KUmVnYXJkcywNCkFtaXQgIA0KPiANCj4gVGhhbmtzLA0KPiBN
aWNoYWwNCj4gDQo+IC0tDQo+IE1pY2hhbCBTaW1laywgSW5nLiAoTS5FbmcpLCBPcGVuUEdQIC0+
IEtleUlEOiBGRTNEMUY5MQ0KPiB3OiB3d3cubW9uc3RyLmV1IHA6ICs0Mi0wLTcyMTg0Mjg1NA0K
PiBNYWludGFpbmVyIG9mIExpbnV4IGtlcm5lbCAtIFhpbGlueCBNaWNyb2JsYXplIE1haW50YWlu
ZXIgb2YgTGludXgga2VybmVsIC0NCj4gWGlsaW54IFp5bnEgQVJNIGFuZCBaeW5xTVAgQVJNNjQg
U29DcyBVLUJvb3QgY3VzdG9kaWFuIC0gWGlsaW54DQo+IE1pY3JvYmxhemUvWnlucS9aeW5xTVAv
VmVyc2FsIFNvQ3MNCg0K
