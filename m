Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216F15660CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiGEBwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiGEBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:52:23 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130079.outbound.protection.outlook.com [40.107.13.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A9E10FEB;
        Mon,  4 Jul 2022 18:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoNqhTZeJQ5mpb+w4CPU1D6ND10Q+ANEyFlPrUXS9m2Q75xaa5U4rH/jC/YdZR30BQx35M5xGGjJFfG5U1RWCFkxzz5AyaUdEgQ3eYun86dRKq6BOTvpqKR+dlnNCT5CnUIodtGBeQoeZy6KuQxNkkRoRS/HXBM0ivw8nDhzSon5HzTDae3bzI4D+QOqB6pjM/JOXoa4mJ9/xu8ucn6h+kyVoMaSHPu6CPmKFigD+x12RAj+MTdii/Iff3FyUfoWTyml7nmkEwEmZ4oXXfz+FzZ30ncYo9FRNOwxjdV4LJ/1zxSmD9N+pTJHwAe11Oq57U7vDLg9LwhKlX+lfyPnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znCTNzI98W8vtzcNhalyNK1Eq2LpmHTHccL57FhFgVM=;
 b=PXuP5N6DJc7B0HKo2pbUjOfTlsS6fccQF+6KlnjWqtDaJy/ac8vdHRmCJio5YBUgtGOnaO6M1AR9egSclososF5IGa/05lzrrujaw1SO/P4vIRLc6VeyMu+n0g601XhCkvtyPIY9n/E/7onSGQSOcmlByk4N9D4IHTrqWgMKBBfh3j+P7Iza2t3uXDpuHvUK7nytDFWPalZAJHII5X/U4BCfuILD4yon7i9lmucQGDLNd+uA6a5L70xYl+Xul/fnMGCUC80uUadnH7qSvGql2x/9Tiqs4pFij95QaYG2vTY/d6+bMzDBcczjRJQlM7whFn1n9duyH6WPaqpOIHkv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znCTNzI98W8vtzcNhalyNK1Eq2LpmHTHccL57FhFgVM=;
 b=oEyyHApwMep5Ujrql5wJtoZ9lJ/TjtG7hGaFOLR0lPCUViyq8i+rySdTBlqY9Bs5z/yEGYmjqh5aOEvIDXXbRlxSHdw7ABCgzMYXMPyLYB9zbL/orkCOaJoEaFLOB+78ItTZfwDBCkTiH5fsYpnsCx7VCU9GIa7my2lZ2ipuMYk=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB9013.eurprd04.prod.outlook.com (2603:10a6:20b:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 01:52:19 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 01:52:18 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_CODECCONFIG
 flag
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2: add
 V4L2_BUF_FLAG_CODECCONFIG flag
Thread-Index: AQHYipWDeE/RzjQxDUeRnOJpMoOdSa1uZxMAgACkm7A=
Date:   Tue, 5 Jul 2022 01:52:18 +0000
Message-ID: <AM6PR04MB6341FA1173A9C5645554F882E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628021909.14620-1-ming.qian@nxp.com>
 <a834a00ba3c4fa8a08290c55d264307fdcf6fabd.camel@ndufresne.ca>
In-Reply-To: <a834a00ba3c4fa8a08290c55d264307fdcf6fabd.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c744d298-fa69-45a5-8ef2-08da5e28fe7f
x-ms-traffictypediagnostic: AM9PR04MB9013:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9zMI1pN8trYS/rhoRwaQspsNm96h+4dJGCXthJRwJvACvxpb/IYRza9MWHlgJrkSReHEaO9d/5OofelsubGZ7R7z5ghFH66g/bme4zduitpRT3Xwk3ho0cO/3FDFbb0U1R2FX56Sx8VaE6rzr4wqVtL0zgSCPyudjm5VLROGX3cTaBg+nBxNpBlq1ENyvctwOXGGYubpXKujlm0E0gJRwWdGgByE9kCMoCQfie5c9Evy1evt1kNVExRDkR/mvMN2R02gvTfIUBhaWVdZaFMfddoPqBda1HYSzLxUu972SLL0pv3X5eUzew511dJA2aAJ6xtyZDR2bTBaD9MdH4f486PR7X6zZUnZ/bfL4ZCj6eg5e596g66o8oDNUGvUXbSL1+G9R1jSpyjx9nccx+lc9DSui8neINuE+mq1Jqsk66y0M8icJN/sfuoO54TvqrWAFaT4xjThGIgcuzXGBqCDV0OQGNK4vwaYNcfKEvRRMq+M+DXlpcxMM84qn2pHDR8qlZDkFzj1ozZ68WQQKe3q7paNGaT9qVql/abFzZ/Q4XSoma2x2dRxw4LnYO7tBVS8F21qSu7pBueR5RH2F5k/2ykLiKQqsb5P1FuXYKVFRJe4fYCEEGNodovZYDibtibbIiM2pPFwDUtyf2dLVray7QJ2iIKKbjsoPAvIHmzxN4PjsMnocyFeSqUuXN59skb61cJNhZwciHuu7x/N7gbeM7XRGiJ+iIZoEoO/0z3wOqVzvP6G1nTOeLdZWSLFpMCQ4dM90xMvXC0uEQ4jDgcqq3RCtdhZbcwVrvt49ZoFlQXYcWJ/1PQcHydVFa+TBPV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(110136005)(316002)(38100700002)(122000001)(44832011)(7416002)(38070700005)(54906003)(55016003)(2906002)(26005)(41300700001)(9686003)(66446008)(4326008)(76116006)(66556008)(83380400001)(66476007)(8676002)(64756008)(66574015)(66946007)(186003)(71200400001)(5660300002)(53546011)(33656002)(8936002)(52536014)(478600001)(7696005)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWhrRlNiTjcrUkZQRjk0NDBQL08rVS9SQmFReEVvSmJnVEE1QWxqL2kzbERx?=
 =?utf-8?B?YXJKU0xacHFMZ3VHYmFvWTdIMVR3Smc3WlZqekZqMXJQTmo3OVR5eHZndTVp?=
 =?utf-8?B?dEt6c05uVlNVd1Q5TmtqSWhKdkxWZmtpYmZPalcxL1pvMHhnSjhiNVZzb3U2?=
 =?utf-8?B?Z01GOGgxK1NlaS9kNGlPZk1aaEhubWtzTEZycDR3eFZwcEdkVFYzaWpxTDhT?=
 =?utf-8?B?YUw0enVuQWhXMUNpb0RlODY2Y2lIcWlCZ3RNVFpVRXUrN091WGZZaUZKQ1lp?=
 =?utf-8?B?OXIxQmMrRGk4TFJTTFEyZjR4NUVLSGlWOUdEa2p6NXl1THlCVkJ1WXYzd2U1?=
 =?utf-8?B?Q1YyOTVCUTRJVU1FcDg3NFlpeUxsbGpwZjU2MDNsT0VQbEJRMEdyQ05UZWI3?=
 =?utf-8?B?elF3bGt3N3FnYVFDMmwrZWtJTXMrWnRJOXBJTEM3V3BKcVRNNjZaUjV1eGZ4?=
 =?utf-8?B?ZWdYMEhTTGdnOUt0bHFUWnY0R3E5T3NRRWk0ZUY4WkErZlFTWGdScVpjYWRo?=
 =?utf-8?B?bHpzclQzSDRWc1NRRXZZbGMyMjFsa3NtdXFRZzI3cTlJVmRBMTlXa2NRa28w?=
 =?utf-8?B?dHNnOUpQUW8zczlpUHF5SW91aCtTVnYycUVsS25XMG42UndzK2VxVHQ0d2du?=
 =?utf-8?B?VVNabHZBL0JzZktIVlZFakU2TjNHL3hWMS9MNlh3akJscmxpbm5YK2dwaXVM?=
 =?utf-8?B?NlAyK0puSnkyUGh5bHphMU1SbjN1U3NoaHl0OFNCeGtSOEt4Vmw0K1czWjZP?=
 =?utf-8?B?ek9Vdjd4YVRTbm1NK09KQTRXeEIzS0liQXVNWG9lVlNRZDBaZEJ1ZTJWeURq?=
 =?utf-8?B?cFRsNTNodStXdW1EWFk2NkQvN2pxSjFRd3lSNGduWEd0UjFoQUhFdzZ2MDZY?=
 =?utf-8?B?MmxmWnZPS0FTTktNQmJzeW4xNEY0cVR0bzYzcVhueGlWSzZ1UnBrTUJLK0Vi?=
 =?utf-8?B?RzBhbUhKaUxQcjdTQUxqNUEzT1V3L0kydk85RVRwRHlRSk4wWFNOQVhlOWpx?=
 =?utf-8?B?R25Ja0tHdmp2RmxJQVBtdk8vdjdRck5RSmlnT3Q2cFBwTnR6aTBYQU5ML1RH?=
 =?utf-8?B?R09iNm54SjBjMDRGQXNYcFhpaEVXaXgvTHVsQUNwMlRXWXBDKzFyb2NLZGdQ?=
 =?utf-8?B?bTV4ZDBYTGxSdU4xRWhWWE1Gb09HU04zZ1JNYi9xNmN2NmVuMWJEREgxNjhP?=
 =?utf-8?B?QVhrNjlWVFprdld5WEo4ejFyS3h3bXN3dWZxQVhBNWU5L2VGY0NLam1HQXFE?=
 =?utf-8?B?bW5yVXZzNEdjWDRObnNrMHhoMVRCc2V0ck5iTmtUWVh0VlcvSTFrS3FCUGN3?=
 =?utf-8?B?a1JCL2hVNlYvZU1jY053VGMyRFBiemhBQzNSd0NJTk1BY0FjSmtmQkRmamxW?=
 =?utf-8?B?NW81VmVqNGx5V0YwMGo5Y0JISWFYcDNaaVhhMytBekNBZGJ4eGZCbk9xWkdu?=
 =?utf-8?B?UWZhbkFWUC90Rks3bUNmNlplSndsMDVhaU1MWDR4TzFBd3B3RDE5R2J4MzMv?=
 =?utf-8?B?MjFWM3dFdzlDeUNLVC9iWGQrdTZEWmhQYUtGMHFXWXQvc1ErQ3habEthV0hD?=
 =?utf-8?B?M3RNTm5NY3hUcmZTM0FRTmN4aEtCUi9rK013ZnJib2hSV3Uwa0JmajNaSzAz?=
 =?utf-8?B?RDdVQWtvQU1NczhSNWNzblJpN3BKNEVZdnBYM1pmZDhwUlQyNW1Xd2JEOThh?=
 =?utf-8?B?UmtSK1VEOHlKWGYwS2YxVERQTTJWTmRHSS9yd2lGeEs0Y0tiVWNheFBWSDdV?=
 =?utf-8?B?a05aazJFOXFJNTlsRStxekVXSCtVcng0Ui9XTlhLNXBsYkkxWFNRWWdGNkFP?=
 =?utf-8?B?aEpFK3BCdTkxWEQvbEI0dlNScENTQ1d0L3VjSDNFa084TXZ3T3NwNWFNZFRl?=
 =?utf-8?B?NmVPaEJUbmpYMHNPeW1FcCtETXJqbUt6dVFlZXAxd2RPUktyKzFrd3YvcHd1?=
 =?utf-8?B?ajEzNW5Xb1hqSGxjUFhVTXJaWEtaSDQvcXp6S2lrZ0ZkaS9GRlRQQUJ4OHFv?=
 =?utf-8?B?Z0tJcnplYklUdWlhYVFoMkRDdUtnaW5NWjVWaEJXNGNMSWpPRkJpMzdjaDZP?=
 =?utf-8?B?TGRvVFBGWGxvZjErNUpoWGgzK2FVYU81WXdtRStpUmZZVkJPRCttT0pSSmky?=
 =?utf-8?Q?P6zs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c744d298-fa69-45a5-8ef2-08da5e28fe7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 01:52:18.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNAMPctoO70DdqS8SGNkb16wQxXHdSs/nGIvhVlYTpzZzMwZA+YFpu2ZCXMVC6sBtNMIMtR60SFiV0nORcOvwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzQG5kdWZyZXNuZS5jYT4NCj4gU2VudDog
MjAyMuW5tDfmnIg05pelIDIzOjUzDQo+IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29t
PjsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPiBodmVya3VpbC1jaXNjb0B4czRhbGwubmwNCj4gQ2M6
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRy
b25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRs
LWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBtZWRpYTog
dmlkZW9idWYyOiBhZGQNCj4gVjRMMl9CVUZfRkxBR19DT0RFQ0NPTkZJRyBmbGFnDQo+IA0KPiBD
YXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IExlIG1hcmRpIDI4IGp1aW4gMjAyMiDDoCAxMDoxOSAr
MDgwMCwgTWluZyBRaWFuIGEgw6ljcml0IDoNCj4gPiBCeSBzZXR0aW5nIHRoZSBWNEwyX0JVRl9G
TEFHX0NPREVDQ09ORklHIGZsYWcsIHVzZXItc3BhY2Ugc2hvdWxkIGJlDQo+ID4gYWJsZSB0byBo
aW50IGRlY29kZXIgdGhlIHZiMiBvbmx5IGNvbnRhaW5zIGNvZGVjIGNvbmZpZyBoZWFkZXIsIGJ1
dA0KPiA+IGRvZXMgbm90IGNvbnRhaW4gYW55IGZyYW1lIGRhdGEuDQo+ID4gSXQncyBvbmx5IHVz
ZWQgZm9yIHBhcnNpbmcgaGVhZGVyLCBhbmQgY2FuJ3QgYmUgZGVjb2RlZC4NCj4gDQo+IFRoaXMg
aXMgY29waWVkIGZyb20gT01YIHNwZWNpZmljYXRpb24uIEkgdGhpbmsgd2Ugd2UgaW1wb3J0IHRo
aXMsIHdlIHNob3VsZCBhdA0KPiBsZWFzdCByZWZlciB0byB0aGUgb3JpZ2luYWwuDQo+IA0KDQpI
aSBOaWNvbGFzLA0KICAgIERvIHlvdSBtZWFuIE9NWF9CVUZGRVJGTEFHX0NPREVDQ09ORklHPw0K
ICAgIEknbSBzb3JyeSB0aGF0IEkgZGlkbid0IG5vdGljZSBpdCBiZWZvcmUuDQogICAgQ3VycmVu
dGx5IHdlIG9ubHkgZW5jb3VudGVyIHRoaXMgcmVxdWlyZW1lbnQgb24gQW5kcm9pZCwgSSdtIG5v
dCBzdXJlIGlmIGl0IGhhcyBhIHJlZmVyZW5jZSB0byBvbXguDQogICAgQW5kIHRoYW5rIHlvdSB2
ZXJ5IG11Y2ggZm9yIHBvaW50aW5nIG91dCBpdC4NCg0KTWluZw0KDQo+ID4NCj4gPiBDdXJyZW50
LCBpdCdzIHVzdWFsbHkgdXNlZCBieSBhbmRyb2lkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlv
bi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9idWZmZXIucnN0IHwgOSArKysrKysrKysNCj4gPiAg
aW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oICAgICAgICAgICAgICAgICAgIHwgMiArKw0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2J1ZmZlci5yc3QNCj4g
PiBiL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvYnVmZmVyLnJzdA0KPiA+
IGluZGV4IDQ2MzhlYzY0ZGIwMC4uYWNkYzQ1NTZmNGY0IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvYnVmZmVyLnJzdA0KPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvYnVmZmVyLnJzdA0KPiA+IEBAIC02
MDcsNiArNjA3LDE1IEBAIEJ1ZmZlciBGbGFncw0KPiA+ICAgICAgIHRoZSBmb3JtYXQuIEFueSBz
dWJzZXF1ZW50IGNhbGwgdG8gdGhlDQo+ID4gICAgICAgOnJlZjpgVklESU9DX0RRQlVGIDxWSURJ
T0NfUUJVRj5gIGlvY3RsIHdpbGwgbm90IGJsb2NrIGFueW1vcmUsDQo+ID4gICAgICAgYnV0IHJl
dHVybiBhbiBgYEVQSVBFYGAgZXJyb3IgY29kZS4NCj4gPiArICAgICogLi4gX2BWNEwyLUJVRi1G
TEFHLUNPREVDQ09ORklHYDoNCj4gPiArDQo+ID4gKyAgICAgIC0gYGBWNEwyX0JVRl9GTEFHX0NP
REVDQ09ORklHYGANCj4gPiArICAgICAgLSAweDAwMjAwMDAwDQo+ID4gKyAgICAgIC0gVGhpcyBm
bGFnIG1heSBiZSBzZXQgd2hlbiB0aGUgYnVmZmVyIG9ubHkgY29udGFpbnMgY29kZWMgY29uZmln
DQo+ID4gKyAgICBoZWFkZXIsIGJ1dCBkb2VzIG5vdCBjb250YWluIGFueSBmcmFtZSBkYXRhLiBV
c3VhbGx5IHRoZSBjb2RlYyBjb25maWcNCj4gPiArICAgIGhlYWRlciBpcyBtZXJnZWQgdG8gdGhl
IG5leHQgaWRyIGZyYW1lLCB3aXRoIHRoZSBmbGFnDQo+ID4gKyAgICBgYFY0TDJfQlVGX0ZMQUdf
S0VZRlJBTUVgYCwgYnV0IHRoZXJlIGlzIHN0aWxsIHNvbWUgc2NlbmVzIHRoYXQgd2lsbA0KPiA+
ICsgICAgc3BsaXQgdGhlIGhlYWRlciBhbmQgcXVldWUgaXQgc2VwYXJhdGVseS4NCj4gDQo+IEkg
dGhpbmsgdGhlIGRvY3VtZW50YXRpb24gaXMgY2xlYXIuIE5vdywgaWYgYSBkcml2ZXIgdXNlcyB0
aGlzLCB3aWxsIGV4aXN0aW5nDQo+IHVzZXJsYW5kIChwZXJoYXBzIGdvb2QgdG8gY2hlY2sgR1N0
cmVhbWVyLCBGRk1QRUcgYW5kIENocm9taXVtID8pIHdpbGwNCj4gYnJlYWsgPw0KPiBTbyB3ZSBu
ZWVkIGV4aXN0aW5nIGRyaXZlciB0byBkbyB0aGlzIHdoZW4gZmxhZ2dlZCB0bywgYW5kIGp1c3Qg
Y29weS9hcHBlbmQNCj4gd2hlbiB0aGUgdXNlcmxhbmQgZGlkbid0IG9wdC1pbiB0aGF0IGZlYXR1
cmUgPw0KPiANCj4gPiAgICAgICogLi4gX2BWNEwyLUJVRi1GTEFHLVJFUVVFU1QtRkRgOg0KPiA+
DQo+ID4gICAgICAgIC0gYGBWNEwyX0JVRl9GTEFHX1JFUVVFU1RfRkRgYA0KPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmgNCj4gPiBiL2luY2x1ZGUvdWFwaS9s
aW51eC92aWRlb2RldjIuaCBpbmRleCA1MzExYWM0ZmRlMzUuLjg3MDhlZjI1NzcxMA0KPiA+IDEw
MDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaA0KPiA+ICsrKyBi
L2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaA0KPiA+IEBAIC0xMTMxLDYgKzExMzEsOCBA
QCBzdGF0aWMgaW5saW5lIF9fdTY0IHY0bDJfdGltZXZhbF90b19ucyhjb25zdA0KPiBzdHJ1Y3Qg
dGltZXZhbCAqdHYpDQo+ID4gICNkZWZpbmUgVjRMMl9CVUZfRkxBR19UU1RBTVBfU1JDX1NPRSAg
ICAgICAgIDB4MDAwMTAwMDANCj4gPiAgLyogbWVtMm1lbSBlbmNvZGVyL2RlY29kZXIgKi8NCj4g
PiAgI2RlZmluZSBWNEwyX0JVRl9GTEFHX0xBU1QgICAgICAgICAgICAgICAgICAgMHgwMDEwMDAw
MA0KPiA+ICsvKiBCdWZmZXIgb25seSBjb250YWlucyBjb2RlYyBoZWFkZXIgKi8NCj4gPiArI2Rl
ZmluZSBWNEwyX0JVRl9GTEFHX0NPREVDQ09ORklHICAgICAgICAgICAgMHgwMDIwMDAwMA0KPiA+
ICAvKiByZXF1ZXN0X2ZkIGlzIHZhbGlkICovDQo+ID4gICNkZWZpbmUgVjRMMl9CVUZfRkxBR19S
RVFVRVNUX0ZEICAgICAgICAgICAgIDB4MDA4MDAwMDANCj4gPg0KDQo=
