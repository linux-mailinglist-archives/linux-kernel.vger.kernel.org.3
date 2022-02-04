Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33704A926C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356684AbiBDCqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:46:31 -0500
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:34401
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234466AbiBDCqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:46:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+W4CuZRKHHd397FRvoKfrOhJFXi+Zh8XzbhjEYBF3DMJSDh2taBr02oLwzVyD2IS3S3WBnOF/yDq5Nk2M/z0qjNOm9b/44Lxh9hg5kLiU9J4yWFRXWq7mQUQuOQESQpYew99qi+YNEMrhq+iFnqwJSjpIgAb8rIP9Yr6LkzU6yy15GjhIfNu7vKA3cCu07pwR8doSxMzBHOkH9xb33WDixM4IkIEiTlJeRdkidq25eI2oKel6PKUkaGXXQ1r74cgtcQRiV0ACV2IlfsSMZa7GbGl/m8fL43EFOJk66Qj+Pip6aRnegs3I6WlnKnF/O8yQhseA8tP/L2ur7litqvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR6XdBHkNDBZXengkyNXOJMeKt77dQ0t+6FystvuvpU=;
 b=W6ZYJ+U1Q34M5d131EUtaUxS0hEdI1onOfUbklkoFdAZ+MQhr9fNjDWfgY1nylMxKTCinV5Y+EzDc9kDnM7+GBgR6bD1ettPISjLhdbUvmnZ7KxcYZhygJHo0u/lv++dcqJmJWdFsdVCwECz6yuYH/XkdZpL22v1b9EWSqmsDFi4VqdPhY54FTjNryvQT0z2DrrXIyNlaRIlWNhxu4u3gK6Qp3/ZgZj6Dpw5yR57FthMVrO4eg0ZoW/mbjGkZmM+1VtqZLKKmFMUj/jkH/h7znXb+WWrWzWc3JOR+eQquN68mOwUfREhrWpHt1z8K8eaiKGZ9HSGjfyII/qpsBIDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR6XdBHkNDBZXengkyNXOJMeKt77dQ0t+6FystvuvpU=;
 b=Sgr7ASnuhwTiXE0XpgAqRHjS6ZV8C+auGL8wK9+uyZtzHyImax5dMbyFfKbe+4yEBw+4F3MlD9SFfreasfAIusPAOT5daBDSfZqA5H84EY/c3v06n2+vT0me8WhXf6Hla3+ddUX1xtub0WumXwUSyr2PkyoZeDD9OMvwkjv1fKPhsRWNWjvMKiAzutAICykSRSTkyr65Nx0OimKQrV1tumxZAF2yhKYl4+n/VzXu+DQA+z6YliJ3WiCKjA3Yr4AVOe15Fo3Of66N03WAZedBvSIk0WwlBKKRuLSO6SFJ89XdHTGePtFbs2dh54x6KLiAfB7fnyCcslzS/LDZxN9+6A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (52.132.153.28) by
 DM5PR12MB1769.namprd12.prod.outlook.com (10.175.89.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 02:46:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 02:46:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [v6 PATCH] block: introduce block_rq_error tracepoint
Thread-Topic: [v6 PATCH] block: introduce block_rq_error tracepoint
Thread-Index: AQHYGTpVkG8xOIk86U2gPDuEJ97j3qyCsFwA
Date:   Fri, 4 Feb 2022 02:46:28 +0000
Message-ID: <302fa562-612b-0853-31de-a11399e5aa08@nvidia.com>
References: <20220203201207.1075933-1-shy828301@gmail.com>
In-Reply-To: <20220203201207.1075933-1-shy828301@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08fd6eaf-1384-49d0-9244-08d9e7888b28
x-ms-traffictypediagnostic: DM5PR12MB1769:EE_
x-microsoft-antispam-prvs: <DM5PR12MB17690F8F01D521DBC69C0B1FA3299@DM5PR12MB1769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRN1oO7k9iVXyy+ZhoHrXdMQQciCbuZe+cMplrwBFdbpGRiZssTrS/O2zwjVmytlTbuFQVu/GF8746NMxSz0KL3n4YNs+AyAX7JcwXj2R1fuMMiPGamTSvc+46bzsxMVCwzfK4VzBy+iWA75OynwCsS0VDF/0PbUW/E7RUCKioJ1WLE9/V7+r4BWLOWp5ysueUoZhjCQw2wzdjkG3dXrV51MVLorYIx4CRyxX6uJRIIKfFCdfwOYt+LWxiCiTnZkE9NhGmpHXXNsFrHaWIHpGB3hLTKzxusFy54bwHrPyRXLn8rOqu36m8yLmGnyH4pvmd2moxvOuwPXLpCt2QhmdCqslXtGNjGwYgAAAbuJGpmGGblm6IzdKy5fngN6v2chdJG3aLkDHeo0eTbM8D56D4OAwdTZ8avb6N4cRpT74YdWaOZjexS9sEhixiSSWPl6FUwfslg7wqY+vwUZ4XK6/bBuEj6Wd8p5xh7KoK0Nm8qpM5mUm6+A+wLOlXFwn2xWhKi1lkmbWoo7rXJlaATxP6uDQhlXAnAXEx0H62cE6R4+QsaMoIei75jUlBxiOna+DjeLawE8O0Q6OmAywg4D7TVv8h+2TTaqSbi0/PFzmLvoXUEaRE7hLpJEyPrAZF+UnRewm/hKnXpZws3iLKnDjySU9PIPV2tCJNDbeRCDIcZ4j0tnv44wlq+L2bH4RxzYnNg+i4e//ct25ZybKK6/I4x2uynEpx9e3eopt1x8bDF4xYQP9pPinXjGtFTcT66y6vb1rnZwsmiHXbsM+SutVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(83380400001)(53546011)(2906002)(2616005)(86362001)(31696002)(38100700002)(36756003)(64756008)(8676002)(508600001)(54906003)(316002)(6916009)(66476007)(4326008)(66556008)(38070700005)(66946007)(66446008)(6486002)(8936002)(76116006)(91956017)(5660300002)(31686004)(71200400001)(6512007)(186003)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWt4Y0FPdkZNQmtrTlF2ZzVqZlJhVFh6WTNWUE1NZ2xtYXhhbUhGVHFEU0Mr?=
 =?utf-8?B?a01WNnRZcUNzdS9wUnRHaVkwNEUyRlJJbGVlaHZBcy8vQnVxM3BPWm9PdTc5?=
 =?utf-8?B?bXlPNGhsTGpVUjN5eGhjQWpHaUQ5TjdvREg0Z3VUaGxUY0hzNE80c3RQOTdn?=
 =?utf-8?B?VEFmVGJDamFiUjBjK1BJcWJVR1VqSW9ZWXEyVHpYMlkyME5iN2JETE9UNWJ3?=
 =?utf-8?B?UGJtU1kyZFRUZkJwOWtDUUJFcVdsK2paQ2dPV2E4Y2RLY0g2dnhlc3dvb1hR?=
 =?utf-8?B?RUQyT3VWVko0WmplSkE4Y1lWWDRKYXptRzAvZTBxekMxcDdzZFdESFI0L0ow?=
 =?utf-8?B?Y2hlQTA3Z1h0UWl4dTNReHhHZVI2dlZrVmpmQWNLcEd2bXRKM3lXVTZqYy9W?=
 =?utf-8?B?OTVvMzhQbWRFeWxlRFhqNkFUbkZmRGFtWGtGYkt5MWh2aEZvRy8wRDlZc0R5?=
 =?utf-8?B?aHhsVUFTSG01MytYbDYyM3VWNDVpWnRzQnhPc1piNzdVbWIrYUxDdElGZTRh?=
 =?utf-8?B?Um5ZdzJyNGp5SjloYTZ4NjJpcFUrczB3WS9rQTZwTkZIVWdPQytyYllCcUFY?=
 =?utf-8?B?ZitxZWMrOWlzZHowMUJFNE9hU1F3ZXVYMFZKdXFYdTZQc0gvMkxxc1VMa0Jx?=
 =?utf-8?B?WUVPMjVNejlCKzZCUXgzQnpUaGNLQlBaYnU0MGxFbTN2N3BtTE5EU29VaVhY?=
 =?utf-8?B?MUlPNzVIa0o0eUN3UVZGQzJwVFhET1B3WXZXbkNvcktFRXR3b25EbGN3MEgx?=
 =?utf-8?B?TU9aRVhvY2NSZlNnOXpYbkZ4QTZMMkVaQ1R5b0Q1QWVMK2JwZnBIK3VaVHhq?=
 =?utf-8?B?ZUZIZEE2dWIzS0VBSHlYUHN5Y2dWKzFMYzlpSmg0YmR1VFJ2NkYwKzkxNzR4?=
 =?utf-8?B?bWlwcEtZLys5YXV0bnh3bWwwTUgvQy9BQWN1M0JHUTFmRVVqQ05wYkhrVSt1?=
 =?utf-8?B?cGVjQVVhbXcvQkQyZ1FkS2NlQmo1RXBDT05uTmx2RGJPM21yUC9zck41b2hn?=
 =?utf-8?B?ODN3d20wWlZHeUdCcjRLLzdtU1kwZ2ZWelZ3cXV3YjVBdkdHV1IvbGNEelp5?=
 =?utf-8?B?VTJ5bmw4cjRqaU5ic2dFekI1YUdQNHJNQ3ZLbCtoc1FEUUdqUWwrNlJ6b2ov?=
 =?utf-8?B?NXZ0MFV5WlU5ZjdiY0FTODRpdGFUR0VsRVkxNXB4Q0NuR2hleUFGMTd4NnM1?=
 =?utf-8?B?STFDRy9NVmVKa0l3dzBIYjZ2ZnBFVzJiRzNrZUFnbjlMb09FU2RCYVFMSnRU?=
 =?utf-8?B?aytlTTFGZ1ZFbitZKzU5ZEpXYzZmQW5IaTZEWWpsWjNwZEFGUGMyWXI2dm5u?=
 =?utf-8?B?UlpzTUZxRDVNYld2ZnFhMkRaT2txSEorUkRZb0dpTXB2Zlk2QmlPUUdHSUo0?=
 =?utf-8?B?MWx3M08zcE9YR2NkMmZuZDdGeFNkNGpxdXJ0cW9qK2RwbHRYUkZwUVBRQmtL?=
 =?utf-8?B?b0NmNFRNcEZrOTFkMjNBT1lsYldtRHFpVUtxMks0aFVpWG9UQjRyQ0daeWdI?=
 =?utf-8?B?ZjhKQitjUStZbUJpQkFDSFFKamN0b05hTWdHSk4yVlZrSGhYaHphY2hXSmJp?=
 =?utf-8?B?NWVLRHRyNVNwWGxVMWRWZ1dwckMrS1c5OE1XWXZoaC9kUHBuZG1QWEdUN0pG?=
 =?utf-8?B?bEtqQmFONXNEK1ZCMzNpVHY2V2pVV1RQSU9mbHpGZ0plYzhUaW4yeFFVRWZR?=
 =?utf-8?B?ZFBxVWd2NG1aYi8rcldzK00rN3o0dS9yVmxQaHFobVlHUk5LYVZKQUpTWStk?=
 =?utf-8?B?REZYMHVnVDVlTG1vVTFjb0JMd3ViRlVwSkJMb29xSHNITm5lTDdFYVArM2Na?=
 =?utf-8?B?OUdJbFBVdTZmRTBZZEw1cmgwSlo3cmZLdWdSZmVBVWxMOUdnQnNuRDRqWXR3?=
 =?utf-8?B?SGIxTlV1THJBQ29PeXJpVFhCMUxMSVIyOXQvcjVIdUE2cmhJcVV2bS9SQzNO?=
 =?utf-8?B?VytDc0JuNFJQZUpNcURFdnY4cHFWSHJCcEgyclFaVDR1eFJZeDBBV2NGNi95?=
 =?utf-8?B?emN5RlNqTVlmMXp4NDV2bWhLUi9RTW1uVWhFWUZablVMT2NPbmNENmdCanQv?=
 =?utf-8?B?MUFsdmNIbDlTd1Fjcnk5NmFNSUtxNU5rNHl5VlJKZ3BnUWNsWUpBQzkwdEo2?=
 =?utf-8?B?aS9kVzNRUWhRcFArL1J3blVaaVVESmF6bnFyTEpaRnhUTC9WeDR1dXFzSlVK?=
 =?utf-8?B?MnFrUlRTNjhGek9oYjYzOGE1M2FDQm9zcUlOV1loTnRlNldBL1dHUE5kOVc4?=
 =?utf-8?B?K2lCOGk4a2FUOVRLdW4rVy9vWFB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <828DA699BF022E47B98A9BC7936BE0EF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fd6eaf-1384-49d0-9244-08d9e7888b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 02:46:28.5115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xrm7jH8Eyg7EM1tN8fpWgXIKyAEaoOiXTaakstws5co3BZu8NfylRAcK4ATpssBXDWAlxpg3XRE1rz0TUfUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1769
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWFuZywNCg0KT24gMi8zLzIyIDEyOjEyLCBZYW5nIFNoaSB3cm90ZToNCj4gQ3VycmVudGx5LCBy
YXNkYWVtb24gdXNlcyB0aGUgZXhpc3RpbmcgdHJhY2Vwb2ludCBibG9ja19ycV9jb21wbGV0ZQ0K
PiBhbmQgZmlsdGVycyBvdXQgbm9uLWVycm9yIGNhc2VzIGluIG9yZGVyIHRvIGNhcHR1cmUgYmxv
Y2sgZGlzayBlcnJvcnMuDQo+IA0KPiBCdXQgdGhlcmUgYXJlIGEgZmV3IHByb2JsZW1zIHdpdGgg
dGhpcyBhcHByb2FjaDoNCj4gDQo+IDEuIEV2ZW4ga2VybmVsIHRyYWNlIGZpbHRlciBjb3VsZCBk
byB0aGUgZmlsdGVyaW5nIHdvcmssIHRoZXJlIGlzDQo+ICAgICBzdGlsbCBzb21lIG92ZXJoZWFk
IGFmdGVyIHdlIGVuYWJsZSB0aGlzIHRyYWNlcG9pbnQuDQo+IA0KPiAyLiBUaGUgZmlsdGVyIGlz
IG1lcmVseSBiYXNlZCBvbiBlcnJubywgd2hpY2ggZG9lcyBub3QgYWxpZ24gd2l0aCBrZXJuZWwN
Cj4gICAgIGxvZ2ljIHRvIGNoZWNrIHRoZSBlcnJvcnMgZm9yIHByaW50X3JlcV9lcnJvcigpLg0K
PiANCj4gMy4gYmxvY2tfcnFfY29tcGxldGUgb25seSBwcm92aWRlcyBkZXYgbWFqb3IgYW5kIG1p
bm9yIHRvIGlkZW50aWZ5DQo+ICAgICB0aGUgYmxvY2sgZGV2aWNlLCBpdCBpcyBub3QgY29udmVu
aWVudCB0byB1c2UgaW4gdXNlci1zcGFjZS4NCj4gDQo+IFNvIGludHJvZHVjZSBhIG5ldyB0cmFj
ZXBvaW50IGJsb2NrX3JxX2Vycm9yIGp1c3QgZm9yIHRoZSBlcnJvciBjYXNlLg0KPiBXaXRoIHRo
aXMgcGF0Y2gsIHJhc2RhZW1vbiBjb3VsZCBzd2l0Y2ggdG8gYmxvY2tfcnFfZXJyb3IuDQo+IA0K
DQpUaGlzIHBhdGNoIGxvb2tzIGdvb2QsIGJ1dCBJJ3ZlIGEgcXVlc3Rpb24gZm9yIHlvdS4NCg0K
V2UgYWxyZWFkeSBoYXZlIGEgdHJhY2Vwb2ludCBmb3IgdGhlIHJlcXVlc3QgY29tcGxldGlvbg0K
YmxvY2tfcnFfY29tcGxldGUoKS4gV2UgYXJlIGFkZGluZyBhIG5ldyB0cmFjZXBvaW50IGJsa19y
cV9lcnJvcigpDQp0aGF0IGlzIGFsc28gc2ltaWxhciB0byB3aGF0IGJsa19ycV9jb21wbGV0ZSgp
IHJlcG9ydHMuDQpTaW1pbGFyIGNhbGwgc2l0ZXMgIDotDQp0cmFjZV9ibG9ja19ycV9jb21wbGV0
ZShyZXEsIGVycm9yLCBucl9ieXRlcyk7DQp0cmFjZV9ibG9ja19ycV9lcnJvcihyZXEsIGVycm9y
LCBucl9ieXRlcyk7DQoNClRoZSBvbmx5IGRlbHRhIGJldHdlZW4gYmxrX3JxX2NvbXBsZXRlKCkg
YW5kIGJsa19ycV9lcnJvcigpIGlzDQpjbWQgZmllbGQgZm9yIGJsa19ycV9jb21wbGV0ZSgpIGlu
IHRoZSBUUF9TVFJVQ1RfRU5UUlkoKSBhbmQNCl9fZ2V0X3N0cihjbWQpIGZpZWxkIGluIFRQX3By
aW50aygpIHdoaWNoIEkgZG9uJ3QgdGhpbmsgd2lsbA0KaGF2ZSBhbnkgaXNzdWUgaWYgd2UgdXNl
IHRoYXQgZm9yIGJsa19ycV9lcnJvcigpLg0KDQpRdWVzdGlvbiAxIDotIFdoYXQgcHJldmVudHMg
dXMgZnJvbSB1c2luZyB0aGUgc2FtZSBmb3JtYXQgZm9yDQpib3RoIGJsa19ycV9jb21wbGV0ZSgp
IGFuZCBibGtfcnFfZXJyb3IoKSA/DQoNClF1ZXN0aW9uIDIgOi0gYXNzdW1pbmcgdGhhdCBibGtf
cnFfY29tcGxldGUoKSBhbmQgYmxrX3JxX2Vycm9yKCkNCmFyZSB1c2luZyBzYW1lIGZvcm1hdCB3
aHkgY2FuJ3Qgd2UgOi0NCg0KZGVjbGFyZSBERUNMQVJFX0VWRU5UX0NMQVNTKGJsa19ycV9jb21w
bGV0aW9uLi4uLikNCmFuZCB1c2UgdGhhdCBjbGFzcyBmb3IgYmxrX3JxX2NvbXBsZXRlKCkgYW5k
IGJsa19ycV9lcnJvcigpID8NCg0Kc2luY2UgaWYgSSByZW1lbWJlciBjb3JyZWN0bHkgd2UgbmVl
ZCB0byBkZWZpbmUgYSBldmVudCBjbGFzcw0KaW5zdGVhZCBvZiBkdXBsaWNhdGluZyBhIHRyYWNl
cG9pbnQgd2l0aCBzaW1pbGFyIHJlcG9ydGluZy4NCg0KLWNrDQoNCg0K
