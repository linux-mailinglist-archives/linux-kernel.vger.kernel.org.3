Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9D47F9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 03:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhL0CHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 21:07:08 -0500
Received: from mail-psaapc01on2109.outbound.protection.outlook.com ([40.107.255.109]:56288
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhL0CHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 21:07:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7BpJpilRPBYxm0z+OerctMaxZwHtQ85AfoWQM6qpPpB2rDuKVXifcSTko2QkrGevVs6RgoD3bDFoUf4Fh2oXPZ7wHkodh1R/uj2n3mtcfE1BzTh0LkNrzyQNwkou9HwU5TdsrCwoPKRpBWKWuLqtqRcnLM6RSAPLAc4bCOUWI3O4ip0y6WY5DOKdPkyrnqSKqdRt4HtB+JxEf1LsnYT/CnNCa+p0KIsKV3pziC62plD23rSpbqTwHWhc0d/vAlE0QWhlLuOZyCUHUG1RG0Dhc6J9/shbuql34Wnri0+S46PEdJ1pd62T/7gDnvM3r+hTMYmg/PLO8ZzY4UO6PUlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sae5YwVFMEV9PoQksSLb7bgJlD/R0A4uxVCQfxHJd9g=;
 b=D20vk7VhgWL3+T5dthNMAb/TT/4DhfXIAVskrTnINoaro9gAh5TtMTtwgmaRT3/RWFBw6ISAwZJ0KBcSYGOORbRaayPzvi2NaR7wTo/qyVAXVlKdSRvjKnCqDwAsyqyaUJLnXri3GvskD1k9uR9H0X6opCfFK+T5MfQjYQJt0BeL0JmRy05dbevpIfLPZPqmTVFt+UbClIKeflwV2+MobvPARBddPKNQbNsHaygu/Yb8B5Uu2xbMQpk4rkiN+rriAUmnPzeQKr0Yn1gmjbBbRa8SfJuwfNHDuQedQwZnOF5no/DdxnvnU3oPDwwgsV2HB728Lrn+86kwyC79VDvqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sae5YwVFMEV9PoQksSLb7bgJlD/R0A4uxVCQfxHJd9g=;
 b=LAW3A5bwzoH+8zNjhQD16tF6DtdaIbQKnSKZFmOpL+EjtdP7QZ3SItKQJjCgojNPvltRrEYg6LkwIDKzRbUrcQ8rwg0EFi5A2ClnAmmQq2xo9y2waAdiVVMQNqKYksbsDs2kHs+cIU3I/AvX6UnT5fTqpP9rqLF81iZBEV7XJS0fIrBq8miR+FtNGKi0fZeBMzBmWlJjIdaO2rH+/6VyOEZeCpTECZti3Xh7RK331i/dOHUOP09c0xi1hkBE4g7CilTfLIn/QmaiP6/YnFuWw60FZeePCEFFFIhegV70ztfUbCiUZd7RC1qESWzGCh96E7cjX/PeGcGvJXPYOmo0MQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB2577.apcprd06.prod.outlook.com (2603:1096:203:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Mon, 27 Dec
 2021 02:07:02 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126%4]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 02:07:02 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
Thread-Topic: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
Thread-Index: AQHX7BszI/63d6+3yEiIx/+xfvXqSKwpSLsAgAAkTICAB+FNgIAJaO9ggAr6yUA=
Date:   Mon, 27 Dec 2021 02:07:02 +0000
Message-ID: <HK0PR06MB3202796B4DDF471856149B1480429@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
         <20211208100545.1441397-3-neal_liu@aspeedtech.com>
         <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
         <HK0PR06MB320271524E51BDFA922F070780709@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <0888eb83c8b2bd53d4c3e2355019052d0ab40db6.camel@kernel.crashing.org>
 <HK0PR06MB3202051E7C15E84006DF55C0807B9@HK0PR06MB3202.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB3202051E7C15E84006DF55C0807B9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f4348c0-57fc-4865-6894-08d9c8dd92e4
x-ms-traffictypediagnostic: HK0PR06MB2577:EE_
x-microsoft-antispam-prvs: <HK0PR06MB257771DD7D014DC9A9535C7580429@HK0PR06MB2577.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXemQ+8EHoxt0pml/twB7aKZJ8tEAiPq02xbkpXTLOgwfImyvg5AybE4MiHjq1+eLJqHKxmEo2iDM8X1/L+NT1iPaavt6txk1NaPBo1tCgE7XbnQWAmG1dLd2pbwwp1rz5dJOBGU8Fujb3qCrVoJETrMB6uRavoRMOMz9B1QJhmzjF3ysst6o7NtKxnyNIBf6+XW+H/P9vf7rNaG5wlHt/fjuppTXyPaYX1M3jDBdXyhRmXVniiISW3s1DMaHfbdX1i7MWHDaDNyp2BW57LzRNnE3yYZuAFLQ0ZPRqabZB+q5b5+bZWbkmRdyDUB71k7SjJGYEcqS5TRnyqnQUpq3A7RgYW4YLicQVlDGK9rrN0yDaTn4DxmfS4FziR35flTdbaBe2nSK5p45uwfixxq5UaDphx5QI8RVyF2xbIrX1TYPdCEgv8H1/xtJjvCRgyjJ+S9Jh0ihMvw2kC/F2ZMm9SmJeBPhKcU9dhcZXyhPS0/2ACbWCh5EptcccI9SsVtjuFegBl2q7D9IqAWak2sBoMeYR7e0EdA/qRElWXlhqi4EbFV3d7zDJZ+dH5XjrGyrG3ceEhY9c6MydAlly1YEZgsIsmSQXagZIX14GfEcn7llV4sjeQJGvW27jMgli+G0MOwcMtyCukMQczQdu6wn5YbQDBFZ5mPmImPBySzt7A9xSmYOyojgM9hz8fQJbWas4aEtJ0n5pRSaBu1XddBFsyObCRI2+8ygBSimVfphZE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39840400004)(136003)(376002)(346002)(86362001)(33656002)(76116006)(83380400001)(38100700002)(122000001)(107886003)(55016003)(38070700005)(4326008)(110136005)(316002)(921005)(66446008)(9686003)(26005)(2906002)(186003)(8936002)(71200400001)(8676002)(64756008)(66946007)(53546011)(52536014)(66556008)(66476007)(6506007)(7416002)(508600001)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEdLRWRaSVJrOXgvV09HTDRhWHU1ZzNJenpSNHZrWVZzM21naDFXd29xa3JK?=
 =?utf-8?B?Y3pzTHVXR0Y5M3BtclVBVWtrZHkrd3M1SU5zcE52YTJHbDBkb3gwTEdpeU5r?=
 =?utf-8?B?bTQ1Y1BkTTVGOXNpOGpQQk9mdTJYMXF4TXhpTU8zc1BNNHBDZFBYMWZ4TDFH?=
 =?utf-8?B?Zi9GalN2KzFwR1dTa25LYU9iN1ZPVEhRcGFNREZoQlYvOHBaZ0RtVUNBQVA5?=
 =?utf-8?B?L3NKblNHN0l6RS9XSmxYS2VHUjZFbXo5RHR4QW1BckFxZzgrU2s3UGtmRjY4?=
 =?utf-8?B?SlRpcndyOXZ4MU5Rbm9STGVqd0pFcGJhS3UycC9mbm9zaEFPeEVib1dxSWpi?=
 =?utf-8?B?VktpSWowdTMyUGE2ZWs3RWdTWWZ4Q1JWMnZudEdYaHF1eDkxK3BEYmtKWGJM?=
 =?utf-8?B?REwydnBGamRvMThlZGZaNXdhdEVxeVB5R0hVenN3ejdtNDVFRWNQeThQNjUr?=
 =?utf-8?B?Y1RxajhXUVZ4dE1FVWlhR3JjV09EWEdxVHI1SjBQRk9ISWo1OGpJR2R3S05I?=
 =?utf-8?B?SU4wekVtWTlCTHE5Y09lSE4rc28rUkNiR1FlWjllS1JLZXMvWk8yWVJpOWZv?=
 =?utf-8?B?YkR6U1BTemZhZi9Udm93Q1JEZGEzeVlYMHNVVVIyN2VBOTZzL0dReVFENUZh?=
 =?utf-8?B?UjRYK3FTK1p0Y1gzSm5GclRIWHNSZVZWRmZZZzNsNEk2NlQzejBYMTVibjNH?=
 =?utf-8?B?OXduM3FDZkR1TCtOUVc4Nk9Vak0zc3ZOUGR5QWdLaC8xa0ZSYVFseENpSXJV?=
 =?utf-8?B?bC9jOEdwaU5Bc3J0V1JqTTdwb01CWUhYYkgwWkVvUktnVEErZGxEaitSSE52?=
 =?utf-8?B?UHJFaXhpcEU5RGdHWHAxbnMyRkRCUWthV3BhV015S1NSeVZxZEV4RVlzUDZy?=
 =?utf-8?B?SlRlbWRqcGpVYWo4RnNFYkdxSmduVjRrZ1VmNStaakxLVzgyZW0wSE9EK2R6?=
 =?utf-8?B?ODMxUnZYN2dQLzY1NlhIYXpIQkxiS0tpRld5T3g2TC85R3plQnVDVzZQUVlj?=
 =?utf-8?B?aGdsZEtBbWZUQy9jaHY1Z3c2aFhuUFBadi8zUm02c2FMOUh5MzIvcVNQS0po?=
 =?utf-8?B?SGpZM283ZFZpc1piVFk1eGhLZmZ5M25MSUtBT2lUU0NxZ3duM2ZPTzJhM3Zh?=
 =?utf-8?B?Vkl0TThLMi94T3hWL2o2L2RqTmZSWUZIUCsyVDlWNThPM1liSFhDVS9tQUpX?=
 =?utf-8?B?TjhQd3dWbzJyOG9KdjVua1pDVndaa0hEV1dqNTlPQWVOYjdJaDZzSnZPbEVN?=
 =?utf-8?B?R21ZdE0rYmNUT3FQVTRIbzdqMnErSzZIc25aSU0rV2p4b1IzVHhIUFFNQU8v?=
 =?utf-8?B?VmZ3ZGloTkFsMWtoZTBxZVFOR3d5UjVwSmhEQUVhdUJJYXR4SE9XaGZmMUxT?=
 =?utf-8?B?K0VYc2xMWWN4bWNqWEtPbmpSdGpmL0ZJRWI3UUhpdmxYNWZnMlQ1VCttSDMv?=
 =?utf-8?B?V2F3ZUNEREp2NGNWakhrRTIwL3pPRzJmS2hCT2FvNXkvNDhzY01CZkpOQi9Y?=
 =?utf-8?B?NnBnaVREY3N5MVRGMUZWbklwTTBUNEhIL00vNVhSWFRTUmc5NnljU2JYZmhh?=
 =?utf-8?B?WkpUd0JDTEZUNlQwVGN6Qm03Y1BGMUMzVTkwLzBKSmh5eTBYRW1mUlNDckdO?=
 =?utf-8?B?LzhwQ2xraEw0MjUwTklqWnhoSWtDWHpXZjF5dm1jM2V2MjhHbVJMc0NMZkZO?=
 =?utf-8?B?M0dRVVFtT3hiUlJXbGtTWVlwMmM2TTVCY3lrc0ljVE42anMvSkgzdDZENEtl?=
 =?utf-8?B?YjErZVkvWWN1SE5sWXJ1L0hwRW10YWlMNG83TnA4c004M1drN3dOd1A4a3J1?=
 =?utf-8?B?WnU2VFFETjlWS3hkSWtMQnczcVc4K2JFODJvN2FIMXNLeHlhdWhkcGhPeGIv?=
 =?utf-8?B?Ny9kdWhHVFhmbUh1ZWpkNHBYZmxWTEpaa2xrWUI2cmxCOWJ5ZDd5TDd2anJQ?=
 =?utf-8?B?WGNYOUdIZlZScmsrdXZ3a3dqZU02ZFg4WDVGL2xXWXZWMlZYclhxYVEzZUNI?=
 =?utf-8?B?VmRtbDJCSTZJbGE1YWJkb0xicHFCMm05b3BPd05ndjBRQkRJekxWOU5DUmM3?=
 =?utf-8?B?R2JWR2NHZkVjYjVMeWFhTHJvMElhVzFWSitUV2c3dXJaKzJxNmxlaGdRSG5J?=
 =?utf-8?B?NlJha1hTZFJWcVR4MXNsaWFsdCt4UlZqUnhFNkdGSXdyTFpTYnZmOWQ0RThn?=
 =?utf-8?Q?dIQZF6b3lmAnynecLJehjQA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4348c0-57fc-4865-6894-08d9c8dd92e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2021 02:07:02.5687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KAnZAV+eeI/v0aec+YJxRSRt9S9cAuTJlngX9En7kPooSy/4silOC8oIPGGwsgTw/Pq8jQXyxxvvpmSPceA5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2577
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIExpdQ0KPiBTZW50OiBN
b25kYXksIERlY2VtYmVyIDIwLCAyMDIxIDEwOjIzIEFNDQo+IFRvOiBCZW5qYW1pbiBIZXJyZW5z
Y2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+OyBGZWxpcGUgQmFsYmkNCj4gPGJhbGJp
QGtlcm5lbC5vcmc+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPjsgSm9lbA0KPiBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5IDxh
bmRyZXdAYWouaWQuYXU+OyBDYWkgSHVvcWluZw0KPiA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+OyBU
YW8gUmVuIDxyZW50YW8uYnVwdEBnbWFpbC5jb20+OyBKdWxpYSBMYXdhbGwNCj4gPGp1bGlhLmxh
d2FsbEBpbnJpYS5mcj47IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPjsgU2FzaGEg
TGV2aW4NCj4gPHNhc2hhbEBrZXJuZWwub3JnPjsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZw0KPiBDYzogQk1DLVNX
IDxCTUMtU1dAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMi80XSB1
c2I6IGFzcGVlZC12aHViOiBmaXggcmVtb3RlIHdha2V1cCBmYWlsdXJlIGluDQo+IGlLVk0gdXNl
IGNhc2UNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBCZW5q
YW1pbiBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+ID4gU2VudDog
VHVlc2RheSwgRGVjZW1iZXIgMTQsIDIwMjEgMTA6MzYgQU0NCj4gPiBUbzogTmVhbCBMaXUgPG5l
YWxfbGl1QGFzcGVlZHRlY2guY29tPjsgRmVsaXBlIEJhbGJpDQo+ID4gPGJhbGJpQGtlcm5lbC5v
cmc+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4g
PiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bh
ai5pZC5hdT47IENhaQ0KPiA+IEh1b3FpbmcgPGNhaWh1b3FpbmdAYmFpZHUuY29tPjsgVGFvIFJl
biA8cmVudGFvLmJ1cHRAZ21haWwuY29tPjsgSnVsaWENCj4gPiBMYXdhbGwgPGp1bGlhLmxhd2Fs
bEBpbnJpYS5mcj47IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPjsNCj4gPiBTYXNo
YSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOw0K
PiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZw0KPiA+IENj
OiBCTUMtU1cgPEJNQy1TV0Bhc3BlZWR0ZWNoLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDIvNF0gdXNiOiBhc3BlZWQtdmh1YjogZml4IHJlbW90ZSB3YWtldXANCj4gPiBmYWlsdXJl
IGluIGlLVk0gdXNlIGNhc2UNCj4gPg0KPiA+IE9uIFRodSwgMjAyMS0xMi0wOSBhdCAwMjozNyAr
MDAwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gPiBJJ20gY29uZnVzZWQuIFNpZ25hbGluZyBXYWtl
dXAgd2hlbiB3YWtldXBfZW4gaXMgc2V0IGlmIGl0IGhhcyBhbnkNCj4gPiA+IGVwIGFjdGl2aXRp
ZXMgaXMgbm90IGV4YWN0bHkgd2hhdCB5b3Ugc2FpZD8NCj4gPiA+DQo+ID4gPiB3YWtldXBfZW4g
aXMgc2V0IG9ubHkgaWYgaG9zdCBhbGxvd3MgdGhpcyBkZXZpY2UgaGF2ZSB3YWtldXANCj4gPiA+
IGNhcGFiaWxpdHkgYW5kIGJ1cyBiZWluZyBzdXNwZW5kZWQuDQo+ID4gPg0KPiA+ID4gTm9ybWFs
IGVwIGFjdGl2aXRpZXMgd291bGQgbm90IHdyaXRlIHRoZSBNTUlPIGJlY2F1c2Ugd2FrZXVwX2Vu
IGlzDQo+ID4gPiBub3Qgc2V0Lg0KPiA+DQo+ID4gSHJtLi4uIEkgZGlkbid0IHRoaW5rIHdha2V1
cF9lbiB3YXMgbGltaXRlZCB0byB0aGUgYnVzIGJlaW5nDQo+ID4gc3VzcGVuZGVkLCBidXQgbWF5
YmUgSSBtaXNyZW1lbWJlciwgaXQncyBiZWVuIGEgd2hpbGUuDQo+ID4NCj4gPiBDaGVlcnMsDQo+
ID4gQmVuLg0KPiA+DQo+IA0KPiB3YWtldXBfZW4gaXMgb25seSBzZXQgaW4gdGhlIGNhc2Ugb2Yg
aG9zdCBzZXQgVVNCX0RFVklDRV9SRU1PVEVfV0FLRVVQDQo+IGZlYXR1cmUgdG8gdmh1YiBkZXZp
Y2VzLg0KPiBJIHRoaW5rIHRoaXMgYmVoYXZpb3Igb25seSBvY2N1cnMgZHVyaW5nIGhvc3QgaXMg
Z29pbmcgdG8gc3VzcGVuZCwgYW5kIHNldCB0aGlzDQo+IGZlYXR1cmUgdG8gYW55IGRldmljZSB3
aGljaCBjYW4gd2FrZXVwIGl0c2VsZiBiZWZvcmUgc2xlZXAuDQo+IFRoYW5rcw0KPiANCj4gLU5l
YWwNCj4gDQpXb3VsZCB5b3UgbGlrZSB0byB0ZXN0IGl0IGlmIHlvdSBoYXZlIHNvbWUgZnJlZSB0
aW1lLg0KUGxlYXNlIGZlZWwgZnJlZSBmb3IgYW55IGZlZWRiYWNrLg0KDQotTmVhbA0KDQo=
