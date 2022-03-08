Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D44D174A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346819AbiCHMbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346727AbiCHMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:31:19 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80104.outbound.protection.outlook.com [40.107.8.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FEF3BBCC;
        Tue,  8 Mar 2022 04:30:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/XWRfLf3jTqkq+4FDLZdbhHcSOo4727LlufKrAt9B5qwRtmxSHgnWEFOLJfRLyoCmywzHBYFX3Yq7gnAN75U2VNT8nY4qjS0t3qzKQpqkKJHaYmh2QzLyyr+T03XgnjNM5PqlUPWorSJGblYlejOVzlbijU4o2tb/lTsN/LXTlZTGImZNDTRPAEowkOoAC7kPFOYHMl0XhFCH414W22BuSJ9UGogTf2I+GjsNEvX2dqrLw/EPi1uYnZKdt7IyHdeI+yyHD+ixT5Bh1+9nsnAZrjVuRf1i/2cQGvoD2ui5m/ghhjil3pNW/RjoMUi3SvEdJvJDesDCWhlX75rK1LRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGNhvjVehlaCAmyFnuwJX93YPvrYd7gB5aoc5ORG5PE=;
 b=DI1seaxi8ek+q+isU/uqWwdjz0jvgPv8Z2W7UpYUsNB3YBztOKUSZ9Je0w7B4TL4M4FgExsUoATdteUf52edScKyZa19XWnXHhhoWZqK3Jpes/POQqketP5TG1kf970hABBrsQMhgiB1fRkstulIiCuavEyxmiruFa/FW50Fql/c8hj861XjKkaheOzJuAxijZ3yUPQVYlqY6XiAms/lzk7Coka0VGeJqe3NWWPq20eY0YhihFU6zhenl3K33q+yCTNg7c5WCI6yKivpM2TeVbZRjBn9eEx5xAstnpTGGg3sWkp/nkfx8KkNpeXGgtDqV+UP0Eo84LPDu8Al88Lc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGNhvjVehlaCAmyFnuwJX93YPvrYd7gB5aoc5ORG5PE=;
 b=CzJb7XJohXwIPljvZWHDhhKxgIX8YFLVw3lkAlqDBwszIaCtp7+CNbsh6INP9xfmNtTANrbJfNUVFrN0l0r/GxYhgfyXprs0p6ZFC1BWwQ3wxsN16GvI3WeyL1eKUJPN5t5Un5Dy8YbgcWuzODCIBYDE35EKM5TnAHVkvDMLTMI=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by VE1PR03MB5807.eurprd03.prod.outlook.com (2603:10a6:803:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 12:30:20 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::6123:22f6:a2a7:5c1e%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 12:30:19 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] usb: typec: add TUSB320xA driver
Thread-Topic: [PATCH 3/4] usb: typec: add TUSB320xA driver
Thread-Index: AQHYLW8v7KcQSACO90u5wFrwbstD/Q==
Date:   Tue, 8 Mar 2022 12:30:19 +0000
Message-ID: <871qzcd3tw.fsf@bang-olufsen.dk>
References: <20220301132010.115258-1-alvin@pqrs.dk>
        <20220301132010.115258-4-alvin@pqrs.dk> <YiYYa7GkknJ+CAuL@kuha.fi.intel.com>
 <87lexlcsrj.fsf@bang-olufsen.dk>       <YidCx7Vi3ob8vquD@kuha.fi.intel.com>
In-Reply-To: <YidCx7Vi3ob8vquD@kuha.fi.intel.com> (Heikki Krogerus's message
        of "Tue, 8 Mar 2022 13:49:27 +0200")
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8df2fcdb-c75d-4537-97a0-08da00ff68a7
x-ms-traffictypediagnostic: VE1PR03MB5807:EE_
x-microsoft-antispam-prvs: <VE1PR03MB5807201CF8C85DF18C67359E83099@VE1PR03MB5807.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GAw6gJvANLD45BIvvzgugk9tbNXuIF9sy18QrBhV2We+u+mPXl2cieGznXTupScNYzznFZCYNDX5fYghqL1xW/Sdv86rQjxmwz23b3wMftL9RHdc/LFr/dHtTGfbLb7M/bHFuB5uobBfs21nYGUaimWt7nJW9ZrdwfLwKkhaozUKArhZWd9GbUtgaL4k4P6yY9qVLlTCAeGHxW69L5ugwdZauw3qsIe0G+ptc7L82ViW4MdpTgfSghdoL8AdMstHFHVbuECi6wS2sQmshcVDEeYne0eo/tf5Vu3nv+N+Gayp0iHOIlKHgdz7sCFxTfIIj9lZqb0KutTW5oAUhZUuFhvIRzjmjpZsGEG0PGYuV+EwA0J4ND1NG1laASQ4U7c5GHVmzAp2AqcNrWF9OdE8qZDgkrc7DWur/uARLpzT0X6fsdse+g7QEIKCT39t/DSySl8xX64WczBA9oFQRyXm19Jlui0RXZooxzH0kepBlFbQeWvGRAIKO0F0y57yYRitpqi7uJ9vpVXIlZG5Db63hRFdb5BNiGwibCP7TWjSVVW5iOAyvVYmVygo4/V+T5Rc80CGq/Ka7uk2j87wu6OpMmZU/8gSYdhqhAgDqfGJS3u33uK0dGnBsBk/pJYrgzX3d1xgSUk9ITRSaDSSNB3SoHKeAOlKz6naTj8lWmKlBnul0YmCmcznkdHoWUfTpZm2oo4Co5HB6GRs/Ozd8EEluw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(71200400001)(2906002)(86362001)(5660300002)(4326008)(6486002)(2616005)(66574015)(38100700002)(38070700005)(83380400001)(26005)(122000001)(6512007)(186003)(6506007)(8976002)(54906003)(66946007)(316002)(8936002)(85182001)(8676002)(66476007)(6916009)(85202003)(36756003)(76116006)(91956017)(66446008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlkwV3ZncEdPNE1JeWNieEJOWDh0T3hDSUxBV2tiT29zOXJNRG9kTDE3a0dE?=
 =?utf-8?B?NjJZc0NYWW1HUC9naWdXVGMwSm1iMFVYRlhEb2c3RFJ5WkFxN3l5Vmh4bjZL?=
 =?utf-8?B?U0Z5ZzRLOEdZVEdJaXNPRDFTNWNmOTZ6WlF1aU5xdmNTa280Qnl3NVp6QWlX?=
 =?utf-8?B?WkZQdlV5TFRrcHpXcUpQY2xBZjBDakZ6c0tobmxUOENWMVp6WHVQNFNvajhZ?=
 =?utf-8?B?RlViRzZ6YWJFLzJkbHZCdEF3Kzlqb3A1R0dlUVgvVitmYkx2YXVWOWtqeHNH?=
 =?utf-8?B?djI5S25idGgxQk0waXdiUUJaVDJkRFRlazZzeGNTbDNwWUlHSWR5OHBBcGtx?=
 =?utf-8?B?UFpjSndCM0hVZ3JsVmptMDl0UmJYRnhQS0RleDFXcHVrcXZCQ0NNa2VpWk1y?=
 =?utf-8?B?cXYyMkJ5T1h0Z1Bsb2Y1NmlWV09kQnZnSnlZUkx1SlpGcHdyL25OUVhWcEpH?=
 =?utf-8?B?U1NZbldSdFZvSHlTWU4rbUhxZHQxeFp6NFU1WXJvQ3hRZ2NNZHphL2NxSFFq?=
 =?utf-8?B?ejFEYUJ1bXYxS0J1OC9zbE90SVR0WWFRRDBGcnBaZ3pCV0pBYVE3cllVYlVB?=
 =?utf-8?B?ZTNQV2JpMnFIdUhORENvU1FBMDlIVnRvT2lMVHV4TEhUSzlOSEd3bTVJTFBP?=
 =?utf-8?B?VVh5Sm5EZHJURjB6UVl4OGkvZUtEcW9tMGpYNTU2Yjl2VWdlU1FFcUZHdWhI?=
 =?utf-8?B?SkxoeGFEK0IvOUdSVlRGaXFDWXRMK2dYNFE0dEVLc2VQWGtEWVFwVE9jSmVy?=
 =?utf-8?B?QTlEaEVDeXJCRDhwekREWGNhQm9ucnZ6SWpWc3NweWM0aCtyM3lnQ3NPQTIr?=
 =?utf-8?B?dkhFQUlSanl6SnI3Qmx5N3JEalFINU5pbXUvZ0R3aG82S0VnN0l2UnExNjE2?=
 =?utf-8?B?TGlFZVZjZHZPNjFta05mdzQyQUt1ZHp2d25BWVJPZGxOcC9vZ1VIVnZKOUIr?=
 =?utf-8?B?SWNoNVhrQ2hGWW9HTjB1UXhqcy9aa0VmL1lQQXhGQkNRQllmMC9hMTRrMzdi?=
 =?utf-8?B?VHVMa3F1eFNHb0toV3BJZ3I1SE82YUQ3dUV5Nzl0Y0xSSW5SWE5KNTZvbk55?=
 =?utf-8?B?Y2s5SXRmcTRsMDY5ai9VTHg0eVRYME9LNGJ2QTdORFVuRmk1Z3Z6amE4YkJj?=
 =?utf-8?B?aXNCTnliUGRVNHhIV2tqZnpibGxPSjByMXFRVlZzc0hsSDR5MFFjdWFmQ244?=
 =?utf-8?B?TU1yWmx2UFpVcEtBalAveXExUlRLbnpUdnVhZzljZWpoWkxLeXFUemdzWk9i?=
 =?utf-8?B?Z0xDQ1JmUG1qWVdBYmJvTFZkNWdZOUFzaFdrbjdhcnBMdWVGenRyRVRUVlRY?=
 =?utf-8?B?MUYzQXdoYjhVdTYvM2VSVnZQTzZTcTJiRUtYZ2JURWFseXVha2xBWlFRQzRR?=
 =?utf-8?B?OWFEcjFZRVpJZU1zY3JFWWpSQWNXR0orNUd2eUFHNnBWU1V3NUJtY0ZFRmlY?=
 =?utf-8?B?Z3RNWVp2NC9NeEd5b3FacGdtalFqellKUlBYTUV5N0dlcEZ6emJSTysxNFVP?=
 =?utf-8?B?YmJlSjlHY0JneUdmU2dKaVlKU2RKR0twMFB4Vk43T3NNOVVqUUc3UDg3L2dC?=
 =?utf-8?B?S2g1b3crM2w4T0tGcTc1dU41Smw0eFF6SCs4VHBCVTJnWHFyZmdxZ1hQNzMx?=
 =?utf-8?B?STFUVXAweTBkRGYvUkgvYnRHZWh0UUlxVS9WQUV0UzVkcFE5QVJrWHUvSGZQ?=
 =?utf-8?B?Z0s3Z29sYWF0TW8waDBNK0VRZE1IdnVyblB4bUZpNlNiT0NNcnloa3gvcDFk?=
 =?utf-8?B?U24wY0pxeWlJd3BndjF2clY2YWNDdUZQZ21hWGJ5VU9ITkRzbnV1VWx5S1dB?=
 =?utf-8?B?aTFKc1RTTjJNYkhVQm9wTTlNSXVEY0d3c1JVVXhXd1hkNCtqaVE0UDBTWU8z?=
 =?utf-8?B?V2VzK01OSFcweTA1N245VXdVbXFQWHh6Z2dJWWFNcnlKZWZsNG9FL3E0Mnhp?=
 =?utf-8?B?YktHU0t0dEtHeWU2M21NUHlCMjFXdSsyNzJuSTJjNFpYekxZL0Y4dC92SnA1?=
 =?utf-8?B?YWpqMWpTbGxWN0FuSVhjS2FKUVlua0ZKT3MrUFp0bkVoM2ZFT1pBQkFjM2RM?=
 =?utf-8?B?QXJmZ3hoVFJXeElsK3FsNmF2dlVKbDFaYnNzNm9ldEc4aUZHSEhRTkw3cVJa?=
 =?utf-8?B?NUp5MDJqYnNndE96SWtGeitTMHM2QktPR1UwRWFwd2d4ZmRPWU1yZDkwQlR6?=
 =?utf-8?Q?QV6WuFqI1EoOZ3PcOKlYsIQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F490C88074F214A987CC3EA8DC34CBC@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df2fcdb-c75d-4537-97a0-08da00ff68a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 12:30:19.8195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/fDMEB1Gg9XIBPCbOm01UPDSthCoFZu86LtRqxS0y6+k1KkEK76b//LF8i3SmDgZf9LVXy/9AwMiMTw9qBScQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5807
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVpa2tpIEtyb2dlcnVzIDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPiB3cml0ZXM6
DQoNCj4gT24gTW9uLCBNYXIgMDcsIDIwMjIgYXQgMTA6MTc6MDRQTSArMDAwMCwgQWx2aW4gxaBp
cHJhZ2Egd3JvdGU6DQo+PiBIaSBIZWlra2ksDQo+PiANCj4+IEhlaWtraSBLcm9nZXJ1cyA8aGVp
a2tpLmtyb2dlcnVzQGxpbnV4LmludGVsLmNvbT4gd3JpdGVzOg0KPj4gDQo+PiA+IEhpLA0KPj4g
Pg0KPj4gPiBPbiBUdWUsIE1hciAwMSwgMjAyMiBhdCAwMjoyMDowN1BNICswMTAwLCBBbHZpbiDF
oGlwcmFnYSB3cm90ZToNCj4+ID4+IEZyb206IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1
ZnNlbi5kaz4NCj4+ID4+IA0KPj4gPj4gVGhlIFRVU0IzMjBMQSBhbmQgVFVTQjMyMEhBIChvciBM
QUksIEhBSSkgY2hpcHMgYXJlIEkyQyBjb250cm9sbGVkDQo+PiA+PiBub24tUEQgVHlwZS1DIHBv
cnQgY29udHJvbGxlcnMuIFRoZXkgc3VwcG9ydCBkZXRlY3Rpb24gb2YgY2FibGUNCj4+ID4+IG9y
aWVudGF0aW9uLCBwb3J0IGF0dGFjaG1lbnQgc3RhdGUsIGFuZCByb2xlLCBpbmNsdWRpbmcgQXVk
aW8gQWNjZXNzb3J5DQo+PiA+PiBhbmQgRGVidWcgQWNjZXNzb3J5IG1vZGVzLiBBZGQgYSB0eXBl
YyBjbGFzcyBkcml2ZXIgZm9yIHRoaXMgZmFtaWx5Lg0KPj4gPj4gDQo+PiA+PiBOb3RlIHRoYXQg
dGhlcmUgYWxyZWFkeSBleGlzdHMgYW4gZXh0Y29uIGRyaXZlciBmb3IgdGhlIFRVU0IzMjAgKGEN
Cj4+ID4+IHNsaWdodGx5IG9sZGVyIHJldmlzaW9uIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBzZXR0
aW5nIHJvbGUgcHJlZmVyZW5jZSBvcg0KPj4gPj4gZGlzYWJsaW5nIHRoZSBDQyBzdGF0ZSBtYWNo
aW5lKS4gVGhpcyBkcml2ZXIgaXMgbG9vc2VseSBiYXNlZCBvbiB0aGF0DQo+PiA+PiBvbmUuDQo+
PiA+DQo+PiA+IFRoaXMgbG9va2VkIG1vc3RseSBPSyB0byBtZS4gVGhlcmUgaXMgb25lIHF1ZXN0
aW9uIGJlbG93Lg0KPj4gPg0KPj4gPiA8c25pcD4NCj4+ID4NCj4+ID4+ICtzdGF0aWMgaW50IHR1
c2IzMjB4YV9jaGVja19zaWduYXR1cmUoc3RydWN0IHR1c2IzMjB4YSAqdHVzYikNCj4+ID4+ICt7
DQo+PiA+PiArCXN0YXRpYyBjb25zdCBjaGFyIHNpZ1tdID0geyAnXDAnLCAnVCcsICdVJywgJ1Mn
LCAnQicsICczJywgJzInLCAnMCcgfTsNCj4+ID4+ICsJdW5zaWduZWQgaW50IHZhbDsNCj4+ID4+
ICsJaW50IGksIHJldDsNCj4+ID4+ICsNCj4+ID4+ICsJbXV0ZXhfbG9jaygmdHVzYi0+bG9jayk7
DQo+PiA+PiArDQo+PiA+PiArCWZvciAoaSA9IDA7IGkgPCBzaXplb2Yoc2lnKTsgaSsrKSB7DQo+
PiA+PiArCQlyZXQgPSByZWdtYXBfcmVhZCh0dXNiLT5yZWdtYXAsIHNpemVvZihzaWcpIC0gMSAt
IGksICZ2YWwpOw0KPj4gPj4gKwkJaWYgKHJldCkNCj4+ID4+ICsJCQlnb3RvIGRvbmU7DQo+PiA+
PiArDQo+PiA+PiArCQlpZiAodmFsICE9IHNpZ1tpXSkgew0KPj4gPj4gKwkJCWRldl9lcnIodHVz
Yi0+ZGV2LCAic2lnbmF0dXJlIG1pc21hdGNoIVxuIik7DQo+PiA+PiArCQkJcmV0ID0gLUVOT0RF
VjsNCj4+ID4+ICsJCQlnb3RvIGRvbmU7DQo+PiA+PiArCQl9DQo+PiA+PiArCX0NCj4+ID4+ICsN
Cj4+ID4+ICtkb25lOg0KPj4gPj4gKwltdXRleF91bmxvY2soJnR1c2ItPmxvY2spOw0KPj4gPj4g
Kw0KPj4gPj4gKwlyZXR1cm4gcmV0Ow0KPj4gPj4gK30NCj4+ID4NCj4+ID4gQ291bGRuJ3QgdGhh
dCBiZSBkb25lIHdpdGggYSBzaW5nbGUgcmVhZD8NCj4+ID4NCj4+ID4gICAgICAgICBjaGFyIHNp
Z1s4XTsNCj4+ID4gICAgICAgICB1NjQgdmFsOw0KPj4gPg0KPj4gPiAgICAgICAgIHN0cmNweShz
aWcsICJUVVNCMzIwIikNCj4+ID4NCj4+ID4gICAgICAgICBtdXRleF9sb2NrKCZ0dXNiLT5sb2Nr
KTsNCj4+ID4NCj4+ID4gICAgICAgICByZXQgPSByZWdtYXBfcmF3X3JlYWQodHVzYi0+cmVnbWFw
LCAwLCAmdmFsLCBzaXplb2YodmFsKSk7DQo+PiA+ICAgICAgICAgLi4uDQo+PiA+ICAgICAgICAg
aWYgKHZhbCAhPSBjcHVfdG9fbGU2NCgqKHU2NCAqKXNpZykpIHsNCj4+ID4gICAgICAgICAuLi4N
Cj4+ID4NCj4+ID4gU29tZXRoaW5nIGxpa2UgdGhhdD8NCj4+IA0KPj4gSSB0aGluayBpdCdzIGEg
Yml0IGNyeXB0aWMgLSBhcmUgeW91IHN1cmUgaXQncyB3b3J0aCBpdCBqdXN0IHRvIHNhdmUgOA0K
Pj4gb25lLW9mZiByZWdtYXBfcmVhZCgpcz8gSSBjb3VsZCBhbHNvIGp1c3QgcmVtb3ZlIHRoaXMg
Y2hlY2suLi4gSSBzZWUgaXQNCj4+IG1vc3RseSBhcyBhIGNvdXJ0ZXN5IHRvIHRoZSB1c2VyIGlu
IGNhc2UgdGhlIEkyQyBhZGRyZXNzIGluIGhpcyBkZXZpY2UNCj4+IHRyZWUgbWlzdGFrZW5seSBw
b2ludHMgdG8gc29tZSBvdGhlciB1bnN1c3BlY3RpbmcgY2hpcC4NCj4+IA0KPj4gQlRXLCBkbyB5
b3UgaGF2ZSBhbnkgZmVlZGJhY2sgb24gdGhlIGRldmljZSB0cmVlIGJpbmRpbmdzIG9mIHRoaXMN
Cj4+IHNlcmllcz8gUm9iIGhhZCBzb21lIHF1ZXN0aW9ucyBhbmQgSSBhbSBub3Qgc3VyZSB0aGF0
IG15IHByb3Bvc2VkDQo+PiBiaW5kaW5ncyBhcmUgZnVsbHkgYWxpZ25lZCB3aXRoIHRoZSB0eXBl
YyBzdWJzeXN0ZW0gZXhwZWN0YXRpb25zLiBBbnkNCj4+IGZlZWRiYWNrIHdvdWxkIGJlIHdlbGNv
bWUuDQo+DQo+IEkgZG9uJ3QgdGhpbmsgSSB1bmRlcnN0YW5kIERUIHdlbGwgZW5vdWdoIHRvIGNv
bW1lbnQuIEknbSBub3QNCj4gY29tcGxldGVseSBzdXJlIHdoYXQgaGUncyBhc2tpbmcuLg0KDQpP
Sywgbm8gcHJvYmxlbSEgVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQpLaW5kIHJlZ2FyZHMsDQpB
bHZpbg0KDQo+DQo+PiBJIHdpbGwgd2FpdCBmb3IgbW9yZSBjb21tZW50cyBhbmQgc2VuZCBhIHYy
IGluIH5hIHdlZWsuDQo+DQo+IHRoYW5rcyw=
