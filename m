Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2865855217D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbiFTPrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiFTPrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:47:09 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492981ADB5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcGv718ykbA+37i6YgO/+8t+QIxSuWfbAYxzTLXoWfHRLI1ug9lhfsaYNOMoadPx/z1dQ/Tu6jZgzEuz8rGoHOb/I3LwxbT6kA30s+OyUKWhM6S5PHgpKqzUlD3UY4tjxEZuqaEjS1Ba+3GUKkHXO/2f9m+9L6TlpEt+ebxkc7keS4qHdPZSztxGLTH54Mz/3zgm4cXGX2HTSBWME5QxFzeOKcT6DjQFDubhLaJrwoXdQ7hcYPYsKrDd7wEyXqv6KKgMt2zdeKqS4vpuxjUAsXgWK7NF9L5LvjmZnEaqOlF9mlGqzMEXrDtzOWaHcAfv7YNxZxObq+RIaRSytKwvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjCqTZGqDaJPoL+Ln1xfgV/OwPvjRuvNv10P6jtYOZI=;
 b=ClOF0N3UFsN5ZelGQZBkCoLXSfLwv07DECiu6FB4mSJ+uITQE8Ii1idLyf1dR8LNlORRsYchRN1sqZKdeILbosCTGqZSAwxqX5TUNm26dLvxvz2H8h/eCjMa1uCyPO4vCuStPh/9zhdJTQ8IRuBjBplr4htL37RJXWvMhtHtWn7Jp6IN7erlvjqjfnSTvbCiXh8/yfTBDLk9b84VrYyA1xyJpEXe7V9lE3bOT3Lciqi33j1suubEwGCki7qKxXhTgGPrSpXL6h8YZXVB/nfI2Jb1kgTc4m96raza4FlaSIKTzvOb5QpCpYszpUPPloz25tKoI6cYY14L1vzTV/2P5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjCqTZGqDaJPoL+Ln1xfgV/OwPvjRuvNv10P6jtYOZI=;
 b=TFQWP4P+MefeF9e/MmuV/wSF+ZmumuC9e3S/2khlfw6mlzgb2XcpAB6pigja8ZF/J0DDE9PqZEhskyVkhbZYualcW3MZnRVDWwGRm2DWWAJPP6+X4Ml74LlnNoaJ/EDUW/0nkwwke+2BXjlzeCwCNKZwXXsWh+3eK1IQcisNtqk=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DBBPR04MB8041.eurprd04.prod.outlook.com (2603:10a6:10:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 15:47:05 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72%7]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 15:47:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Topic: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Index: AQHYhKwihmmQwo9gZ0uCTra8XCwz/61YZSEAgAAK2aA=
Date:   Mon, 20 Jun 2022 15:47:05 +0000
Message-ID: <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
 <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk>
In-Reply-To: <YrCM0reni+x/KWsG@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7dcdce2-7585-46f3-57ce-08da52d42036
x-ms-traffictypediagnostic: DBBPR04MB8041:EE_
x-microsoft-antispam-prvs: <DBBPR04MB80414A835C51F94566A4B0D780B09@DBBPR04MB8041.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gwDG5qEIX9i1IL/99nXr6l2w5LYhBzpU8CPUhGFBqJbbS2MfzeaXPiAwLsQbWoijbefggPphkywYCsry4HwTiGJI1bhuQI6h2uf6urFw2ZqhWPng4eeoe7St2u6oCxM7lyZY549TiHAhiDc3bt4XKvZnKyDV3V8tIerUy9RDFp3FCzcdTwTIeDJJPAMIQz40NWkCefb/rYaTr1WOvUuKzAfrQjt/H8ZdS2DSGLwWgArK7yI+8WA08XE8gkJwXqqPcWHTvrGRL9ypip3fj0OuC0MEf9JqA8N/OiYu2r2A3O8fq2bltWf4CAkekrTaP7Hb75ql7sVFVL7sCzQSdEpo62MgVNDufd4iiwR5T7HYNLxC6/T40iQzLJtHHwrILLVjxviFaHJ4Z9m053oab0buk/BOZA3zQx6ZCADjU4LTROYZGsftjPZ71IjAgGnC8bgobPo/IAt7FqIzA02kmWnipYsFZrxss87phdXpN2gq4WYEA+deD3a+bIQ+j8Sjv/FTGfDy8Eyke/JfQ2OiilIMwcN7Yp/n8HhnSdS48wGCzDSneywTzQ1b2/SH5l8a8YuiU9vYi+hhgRAfGFOWswDc6BTBjIP2desVbofmJcXX0Ega+1aEJu9Nm5eOsLRX079fl60vyAPL7Ge/Pl/3wOnPE0N/DFtTqDf29kxeTaLZpS83XP2MmPQXksUIQfJDCq4hQQma8x0CCzH2/ToZgPHG83GKqih/7S/wjXeNkLTR6SycWY7TxwMkw7wClYVRMtM9JVThKfEh4WPEYKxpfdLZ8nEk3DNz/sZ3c4Eh8i709DA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(38070700005)(186003)(2906002)(55016003)(4326008)(8676002)(9686003)(33656002)(64756008)(66556008)(66476007)(5660300002)(52536014)(76116006)(66446008)(6506007)(7696005)(54906003)(26005)(44832011)(66946007)(38100700002)(122000001)(86362001)(71200400001)(41300700001)(83380400001)(6916009)(8936002)(316002)(966005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFkySTdiMWVnMitBUW1ROWRSbFl0ditRV25uVXRnMGZ6UHNHL0lReVl6VUJr?=
 =?utf-8?B?VzRuUVdkV1Q0VWpoZVprbXF2ZHBscFhZemtWN0Y1WEh1ZGsycHliU05JVmo5?=
 =?utf-8?B?NjlVM1FtZytSWldzVUY2dTRGOEcwRmVlWnpSNCtvaTZtYklyaVFOZzhrbDAr?=
 =?utf-8?B?UDVWYUVjaGFTRFdKaTR1L0JvVUhoNFFHOUZzNkluQXlRbWZtTzJDMVpBMWFr?=
 =?utf-8?B?NWE2eS83OXdjK2hGTWlGRVREKzcrVFF1ODhveldWT0JDSk5YNzVkdHVtZDI1?=
 =?utf-8?B?VVUycnhyODAybDRuNmQrV0t5NURCbE1JNm1nQks3Ui8zQmRRdS8wNkhlQmhk?=
 =?utf-8?B?Y1Q5YWdIcU1weS9ER2laMThZTTB0YWVPNGZnYXdPbVhlVmZkMEUzTGVkUTBQ?=
 =?utf-8?B?ZmhFL3RaZGVIdVJoYnV4QzZtaE9SS3hRVE1CcVRLaHp5NlBNS1lXNEtTQmJC?=
 =?utf-8?B?RVhZNEZEeFZDVUdVdEdLeHZtUFBBQ1NZbklLOUlLdTExcURVUWRLYUdOK09U?=
 =?utf-8?B?N3JZZHNrOEpCaThKUDZ2Vy8zMDV0a3NKYTJMWHA5MjRkQkFMUit0OHBXQlAw?=
 =?utf-8?B?ZGFxb2l3R2hwczM5cFR2b2wzdWNCejIvTWpETTNOUUE5TEtOeGt4RzZuc2xT?=
 =?utf-8?B?M3VSK2lhbTVBcnN2a2k3VWEwQ3J6UHB4ejJHTmt1UjlLMXlqWXgvNmtXWGt5?=
 =?utf-8?B?U3M2OEMrbkllU1BSbHEzRHRFNU5oN3Jrc0VBMzhUQkIyOXIxRXhDZllEQnh6?=
 =?utf-8?B?ZUFVZ3NjRDZ6ZGdHUHpNbU82R0J3Zm1ucDQrOVU2RWxRcEVHVVdZSjlSVXQy?=
 =?utf-8?B?cy91endUNVJCUWhFZGtqekkxOTZxZnMxSGt1YnRFQ294enhkMU9kYUt2Vmwz?=
 =?utf-8?B?UkdvTnBGREpFWG1lR21YRWc4N0tQdE5YNExwajNCVGVuTkZ4YzdzOUQ3V0s0?=
 =?utf-8?B?aVpQQXZTMWVaZHJoT3RjbWI3WEdnZDZEUk5FalJ0SmRVWE1KZXplZUp3WHdi?=
 =?utf-8?B?Z3hFVzJ5NzJVRS9xSksyZzJhRnYxekYxeG9iVy96TWV1SGlXNlVyRXZKaUN4?=
 =?utf-8?B?d2x4OUlibGJCWlEvdkY4V0FBVmp6bXRsQk9KKzNOenJwNUFjeXE4alMxYUgy?=
 =?utf-8?B?Qjc3dmdHN3RrM3J1NSs4YXdjMkFjbEw3b3FDUTNHQ25GQ2h6dExLaGdRVFR3?=
 =?utf-8?B?QTE3Mk1hT3ZiN2FFS045NE5INTI2Nlk5SGZnM25QczNpOVRCWEdBL0tiODFl?=
 =?utf-8?B?NnJtWHNkckdxMGNFQmsxSGp4Wi9nWVhrVGxVUWF2eEU3bmFzQkVWZFR0Q2tl?=
 =?utf-8?B?ZmhQTEpkMnRTWi82elJwNngvM1lFdkEzUjd1VDh1VmRFQjd0R282cFIzNjY1?=
 =?utf-8?B?NTlsekZINFBLZVVLYU1vL2dPVllBUTVEc0dlMkQ0cHJGYUZuMnNvV3hleWpU?=
 =?utf-8?B?MHhEOXRxbDRiS0V5TWdWenFMYmo2akpQMTBJcXk4NVZYNGFvZTJRTXQ5Q2JH?=
 =?utf-8?B?YXJBaC9jUENRUnFocHV0dTZpMHJkNW55a1QyOUFsWG1BRU1mZFhIUWFYRys0?=
 =?utf-8?B?UDgwQW1aZDlFZlAyZUMxVGRqVHFwUUQxcjFTN3U0NVlnQW9VSWg4UVEyZ3BR?=
 =?utf-8?B?NDN1TXN6a1dhMHNUTUVzL1ltK05HZzBmOG1EYmh4ZVhYSDhaKzlzYXp4aTVU?=
 =?utf-8?B?STlDeVcxVWFkOUJCN0d6Q2kyc0Vrem1BWGRNVHp6L0VUZVBocFBKZnA4L0h5?=
 =?utf-8?B?WThZK2tVS0xzZTRHQ25lUUhPK0lhS2NYOW1pclBJN2gyQ1ljMjBCUjBNSVRZ?=
 =?utf-8?B?RGR4RnpnaitpNEh2dGVlMUFQSTNJbGFUd1k1KzlmRTJHQ1BibllOS1lxQjF3?=
 =?utf-8?B?Z2hBZ3FuRzA3M25HUml5aG1wUjNHRWVrak94QTh4Q2loM2VwNGRlZjFoUThM?=
 =?utf-8?B?N2QwbFBQNkJiNmIvVHZFdEo3WTN5bFQ2MEg0VDlGQ01aVDQ0bFJ6b0UvREh2?=
 =?utf-8?B?Umxwc1RWK1pFaElESUVobUZpeXJmTXdNVHBoQzRmQnNsYW1tWEFyWlZiVnQ0?=
 =?utf-8?B?NlE4VlFpRGVuMVFybTFnZFYrd0p3K3A0QTNFU1EyMDZ3SVNySi9IRXJGcHpD?=
 =?utf-8?B?Z1ZPdm12MU9QVjNUOHJ5L254UWZmNkJMLy9SUUxnSDZBZmo5VVNzZmQrdjZP?=
 =?utf-8?B?U3V0ckRtNkZpT2E5bEU3S2FINTRPbEZmWGM3bEM5S3dLbnFWbHV2ZXpkdTZW?=
 =?utf-8?B?ckkycjlja2hqS2RiL3ZQV1VxWXFLM2w0ZHErczFiaXVteHAwS3ZySmdBbCtS?=
 =?utf-8?B?ZnVKa21mQjRBSnZKWE55dFFFT2JSTVZtaEozRXhkaExTSU1mRW1PUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dcdce2-7585-46f3-57ce-08da52d42036
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 15:47:05.3010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ZSz7h5OKI8q6C8zy9twTSvx/f8d0Lf7+rQj7lXGyspFczvbxbqrNMyhEI47i5EyeI+wu8nMozID9PT1wzQSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8041
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwg
SnVuZSAyMCwgMjAyMiAxMTowNiBQTQ0KPiANCj4gT24gTW9uLCBKdW4gMjAsIDIwMjIgYXQgMDk6
NDc6NTdQTSArMDgwMCwgRG9uZyBBaXNoZW5nIHdyb3RlOg0KPiA+IFRoZSByZWdtYXAgY29yZSB3
aWxsIGNyZWF0ZSBkZWJ1Z2ZzIGJ5IGRlZmF1bHQgZm9yIGVhY2ggaW5zdGFuY2UuDQo+ID4gSG93
ZXZlciwgaXQncyBmYWlybHkgcG9zc2libGUgdGhhdCBzb21lIGRldmljZXMgbWF5IG5vdCB3b3Jr
IHByb3Blcmx5DQo+ID4gd2l0aCByZWdtYXAgcmVnaXN0ZXJzIGR1bXAgdmlhIGRlYnVnZnMgZHVl
IHRvIGl0IG1heSBiZSBpbiBzdXNwZW5kDQo+ID4gc3RhdGUgKGUuZy4gUG93ZXIgZG9tYWluIGlz
IG9mZikuDQo+ID4NCj4gPiBDdXJyZW50IHJlZ21hcCBjb3JlIGRvZXMgbm90IHN1cHBvcnQgcnVu
dGltZSBwbSBmb3IgTU1JTyBidXMuDQo+ID4gQWx0aG91Z2ggdGhlcmUgaGF2ZSBiZWVuIHNldmVy
YWwgcmV0cmllcyBbMV0gaW4gY29tbXVuaXR5IGJ1dCBmaW5hbGx5DQo+ID4gZGlkbid0IGdldCBh
Y2NlcHRlZC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhbiBvcHRpb24gdG8gYWxsb3cgZHJp
dmVycyB0byBjbGFpbSBubyBkZWJ1Z2ZzIHN1cHBvcnQNCj4gPiBkdWUgdG8gcG9zc2libGUgcGxh
dGZvcm0gbGltaXRhdGlvbnMuDQo+ID4NCj4gPiAxLiBMaW5rOiBodHRwczovL2xrbWwuaXUuZWR1
L2h5cGVybWFpbC9saW51eC9rZXJuZWwvMTIwNC4wLzAxNjQ2Lmh0bWwNCj4gDQo+IEFzIGluZGlj
YXRlZCBpbiB0aGUgbWVzc2FnZSB5b3UncmUgbGlua2luZyB0byBoZXJlIGlmIHRoZSBkZXZpY2Ug
Y2FuJ3QgYmUNCj4gYWNjZXNzZWQgaXQgc2hvdWxkIGJlIGJlaW5nIHB1dCBpbiBjYWNoZSBvbmx5
IG1vZGUgd2hpY2ggd2lsbCBlbnN1cmUgdGhhdA0KPiBub3RoaW5nIGNhbiBkbyBhbnkgcGh5c2lj
YWwgYWNjZXNzZXMuDQoNCkkgd29uZGVyIHRoYXQncyBub3QgYSBzdGFibGUgc29sdXRpb24gYXNz
dW1pbmcgdGhlcmUncmUgcG9zc2libGUgdm9sYXRpbGUgcmVnaXN0ZXJzLg0KSXNuJ3QgdGhhdD8N
Cg0KUmVnYXJkcw0KQWlzaGVuZw0K
