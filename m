Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CEE48EAA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbiANN2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:28:15 -0500
Received: from mail-gv0che01on2107.outbound.protection.outlook.com ([40.107.23.107]:40288
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236344AbiANN2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:28:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ0jUqIiB9hC+Wixw8gZX5zaQhwyNNPeAIynuobYVt8UTJDxCxMnXTwNZTGpaK0iV6ShylZVvKOfBJTwsgQAqEuRzPhnyeL5Rhzb5uah60CHJ/CNWhAq4F/n8e7+1X4x3HQshWWlR6QPhFF77Y1K/l4VXmwaLFbcqVkDtUjGOckxCl+ZmGZ2zQZZ/5NzybxvdYGZElJIOBktF/ksZt/BUtUOsQowFiAfN2qRoJ78D21d3eUYiOVOnpdkL8v6BpTnboQS+D85Pq0JbDOwilS13SMvPWKWCtqSD30lv6BB1bqkHsin0pHZCmh6etyNehej9sg9d54FXrNf1ETOBEjxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nprsn/g9jkvVdflKuCBmKuHVZpO3Ok0Ac4n5h7/vM5s=;
 b=d7z8tiQIRNXghcgFtZWtw35g4WpDGQZw1dveUHsIHqmCjy93uYM3j3UF11Jv67Ob5NiJ7Kb3v8jVDEIqqFRtRqfEp3auYxJV+miba370uT/xylRUjpV5L16RN+m29KbLmAuD+Teu3ntELcFQZAoQAn2A6F6ZsSI1SCPGsU5xG/sz7FYqFyrZcfBK1M6ykh63muiX2zxVpvRMhjN6qOdtTMqq9/nc2BWK++gShruAigTTg83qRovHAsqkQLPlo47fVWQ0jmyNu3R2Qqk5LNszTw2ykxNwuMmIn2pNpJIBb8Uap3NAi9shz1UVxdNVKfWdg0G2MH90zAsRELajLNS6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nprsn/g9jkvVdflKuCBmKuHVZpO3Ok0Ac4n5h7/vM5s=;
 b=tMg3inbPQ7emnNKD5b2l+Vzh6cYx9J9j8qXMhJyNaG4ajfvEGwRk+Z1YKJqIDibU5PgKU6QFdN4MSHI5jn/KXX/MumnBXYsFoUIqEazIdZ2vOVE1BkbLqbbZejDGJOWbOexCEa8nYCrNr/444SO3e1X3aokHYqxGNFR4ptjFURI=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0074.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:19::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Fri, 14 Jan 2022 13:28:11 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7067:aadd:1aa2:85ee%8]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 13:28:11 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzk@kernel.org" <krzk@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alexandru.marginean@nxp.com" <alexandru.marginean@nxp.com>
Subject: Re: [PATCH v1 14/14] arm64: dts: freescale: add initial support for
 verdin imx8m mini
Thread-Topic: [PATCH v1 14/14] arm64: dts: freescale: add initial support for
 verdin imx8m mini
Thread-Index: AQHYA/EJr9AhV08EU0SgfK8cRQFBIqxb9Y2AgAaXtgA=
Date:   Fri, 14 Jan 2022 13:28:11 +0000
Message-ID: <5fd41ac1242e0cebbb77eb1a83c3f4350c34296f.camel@toradex.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
         <20220107180314.1816515-15-marcel@ziswiler.com>
         <c80ac4a7-d401-00c3-c6c2-61bc9a600590@kernel.org>
In-Reply-To: <c80ac4a7-d401-00c3-c6c2-61bc9a600590@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1dd0518-0e19-4e22-0b8b-08d9d761b5cb
x-ms-traffictypediagnostic: ZR0P278MB0074:EE_
x-microsoft-antispam-prvs: <ZR0P278MB007471EAF1B61E1F55B8E49AFB549@ZR0P278MB0074.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQ8sbYooq2uZpDp6n0iAK1IhWq8r3NGPYgfNWllF9myf97pJjKaSMgtqMlTtqdugwmmbgNFSEZB2h6zd9D8YMbzBjbHGPVWZIuXVbGzmNGV8TjOTQm43Q2JIynzc4xGJjVFO+IyW9hx3Hxz+x0qykYph0D9ZeDBVB1jSIz4irDMmg6s5dmLefpaNcGWhYVH8b9X5VSqCk67JARAen6MfggmNW6uA7Kxe1xQh08Oyyk45JP5Yn4qwZD9PN3b0sj9uM5SMlurmBOVjHrBS4rGBFVYpntrAp4+GuwT5g76AE/sjMMm0OzRoS/xuECl/DVn9GmXcBXTLOE369PYQTkpxib+vT0YsvlBAvXFRmgQ2HNnJgCg3wmN8JQ6bSQtTofo689S1H1fBOY62jWGxvnkjgytgFQKsEHqohjV3xS1S0Q6PLCKXUlBzZqct1rodzMVv16NinI8RuHGPObAFcHK0PxVA+CYpz+vkNkvo7w3at3nSWkd9lSYYRFGSKRbS9YYWWmy3kesqbWaAJzbuh174JG/Nezrorg9itMNUEZze3C7uF5w8mu9RHA1UIQu+xuziZkv/OvchmLR3UT4xFhNbFqhMgbnT8l6OcZgcfUt6SYpXkaOYNyo845nlQMojhVIEmky8BYh1Qf9M4E00o23A0FomW8gqE2ebVVohZmQsLYpMFBbIfxW/vW8pu1APQ9/B4ddES72CTu9HR/10ksr4dIu4ACHVWa2a9NV//iqtGE0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(396003)(366004)(136003)(186003)(26005)(2906002)(508600001)(7416002)(38100700002)(5660300002)(44832011)(8936002)(54906003)(110136005)(8676002)(316002)(71200400001)(66476007)(122000001)(4326008)(53546011)(6506007)(83380400001)(66556008)(66446008)(6512007)(6486002)(2616005)(36756003)(76116006)(86362001)(66946007)(64756008)(38070700005)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzJESmlmWnpsaytyTDF5WXlXL3h5UlNxRVA0eXhJUHMxbGtqSGNicUhNOTdw?=
 =?utf-8?B?Q3g4NUg1U21sblp6Mm1XMUg2QkU3dHk0YnVVWkc2emxZVGxhZ29PcUhJTzJ1?=
 =?utf-8?B?TnhYbENzbWFJbGt6Wm5YSms3WFcwZFBpdWlqc3JDRjV2dGNHbmxPbjhCcTJE?=
 =?utf-8?B?M1gvSXhQRDVOVXZKUElzb2trbWtlNUUwak11ZU5IdHA5N210OTVWejBLZ3g1?=
 =?utf-8?B?eWppVFRKeWpoZ2FOVUdrTjgveEk3emkrbEVxYnM4cmZwUGcvdWRyL085U3VB?=
 =?utf-8?B?MElHTFh4UEpPRXRMa3dQQU4weTVYN0RNamZVY2VDczl6M0pPNXNCYWU4V1VT?=
 =?utf-8?B?OUxCRVdUNFU5QzRtQVlCKzJzYmRCVzlNdFNXWUYvblNIS3NxbHh2TUxDNzMz?=
 =?utf-8?B?Zzl2UEZ2MXZpa2xodzdCUGgyVEZNeHdpQXpmWTJKa1ZGMWlFYkc4T2w4SThN?=
 =?utf-8?B?WjJzUFBLSTVVNmlkYWRYdnZHU3NXdENIbU5DVzlZa1hNSVJCS2kzWis3TnM5?=
 =?utf-8?B?WDdUcEJuanZIMkUvQ2o4eTh6V2pwV3l1NXQ2OTA5RG9lenZQcFF6QWZ5SGtP?=
 =?utf-8?B?K0RPNXpzblVHZTBIWktnQmFJbUtDbENVUTNmLzFoMUFuTkdJems4SjU3NVpo?=
 =?utf-8?B?a3BSejg0L3lmRm44WlBNNjFyRGR3MXZjL3M3S0NCUnZPaHhpcTJRVm1YVk1k?=
 =?utf-8?B?M2RkNEh6YitPbkVxOExXL0ZqSGNPQm4zcVFIajAvc1JIa3hTYmZvWnkvZ01B?=
 =?utf-8?B?M3hJNGJIcGlhNzY2MzFLcytBN3BuWnp4NzdmamRYbnJtM29XWVVCRjExLzhk?=
 =?utf-8?B?L3E5T25oYTJubkJQZWQrZ3pMbTNSdllmWDA3dG94RFViSDZIb0VCRU5vMGph?=
 =?utf-8?B?L0ZXMFJtNnhWdzZiSVdUc2pDa2x1aDVKNFFmMFBrN1puT2duYWMzY1pjWnhR?=
 =?utf-8?B?eklMMjlVUWZRT09YbUt1dEhwVEtacW1ucEFiTi9LNHZKNG9qcGRVMWYzOVhj?=
 =?utf-8?B?T3hVZTVlZHNmS3pnMTBUcGd2YkZMTW5KeVhYbldmcUp0dFNhWTk2aG81ZzBM?=
 =?utf-8?B?dkFhTHhGR0VGclNSQi80QUZOaXFoS3FPZWpHRmxhWkFJOWJNdzV3YTAwWGw5?=
 =?utf-8?B?Tm1SaGJ2YTlqSVNrN2JzRlkvNnRibXg2NDEvVnZoczU3SmxaQU80Y21TY2ov?=
 =?utf-8?B?UXhRay9pM0hOWVZ2QkJNTjAvYWdVakNQY1hXaFpidHA0LzRpZkFPc2NFcVZh?=
 =?utf-8?B?elBIYlh3OFhlb0tFY1k2UHlHZ1BWdENwTC9lSXhVL3FNQ3RUQU1iZlR6NTVl?=
 =?utf-8?B?VHdwUUc2TTJuY0pZamJPLzdtdllZbE1rZW13Q1JyTStpczVEdElxbzdYWmxF?=
 =?utf-8?B?M0dZUlZtUXpQUzBlb25LV2N4cGpneldTeWpERG80bEdLMnc4bFRUVWZaMC9J?=
 =?utf-8?B?bjR0M0VMUnVLMTVwZWI1YjRaNDlaWlRCOW1wOURVVzV5cDNRb3JSWjFQZDFy?=
 =?utf-8?B?b1VzSXhjcSs4b3FEZkVNSk5TRmFqV0JJT3RuZ2lDK2RsaG9wL0lqRHNzV3pI?=
 =?utf-8?B?dFlkcjJDcyswRjhDM0FrUEcvbjllYmJtVGUyWGNJMGpCNzdlbGFaRGF2aFdv?=
 =?utf-8?B?VjNCU0w5RjhUa0ZyTnptczJPRnphcDZhUFNjbDcvZFEzck1ZMjZPYnlkdjNE?=
 =?utf-8?B?KzNTT1pySGFtdjYzc0trR0hZRzlNK0c3eU1XV1pPN3FwYWRRM2RVR2VDTWcr?=
 =?utf-8?B?L0RWVHhUYlZNOFYxMUpteDA1d2ltTlh5bkltUUFlYmtyalg4UllqREk4d0Jz?=
 =?utf-8?B?K05lMlowWjhmSE5nOVdJOXhBSHIvRmlOTEUwNVdlbEFLTmNvSWxvSkJBa2Jz?=
 =?utf-8?B?VTA3dTk1dWIxRDE4cm9PSWExYjM3S1VoQW9RZjcrL0VXNFpWOCtSM3FyUTR6?=
 =?utf-8?B?U0hZSlBGRkdVUTkyVHlCOEk2bXRTVkNoQ29kMmJ4cWs4cEttSDhPV2g3YnB6?=
 =?utf-8?B?NERDL0ZSL1RRMC80S2E4cVNpVkNrZjg2TDJXakl0WDV1RFdKdVgzSGV4aVJ3?=
 =?utf-8?B?b0VRVnVlamVwOFFhMHFqMXNFWExBcnliUUtPR1gxbm92d2JtL2ZQR0hzSWZW?=
 =?utf-8?B?SUNHdnFnRFJLVzdBNytmdEpFV3A0Y0Z5SGxXZ2pQbGJkQlViWWRhTXlnSjk4?=
 =?utf-8?B?eHBXNXdDcWk1K1ZmYmdqOWswWE5zT3JsOGNzRjFucytUb3hEUUZ2MHhGMWl6?=
 =?utf-8?Q?82ynRiJDPuqtjIje/biR7nBJ+vpfUHg9hYOgVrl3CA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06D6338D32DA3F438B0467CD7EE08092@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dd0518-0e19-4e22-0b8b-08d9d761b5cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 13:28:11.0792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjsrbueEhRrRumxhBYFcqxmteMRMdXREdIHquNQXGbPuVWDo5c8Cl3seXu42l4kJ8tmecbMhNUrFz0trhSG/ADCVINTImxyes/vsfOWyimU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTEwIGF0IDA5OjQ3ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwNy8wMS8yMDIyIDE5OjAzLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
RnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
DQo+ID4gVGhpcyBwYXRjaCBhZGRzIHRoZSBkZXZpY2UgdHJlZSB0byBzdXBwb3J0IFRvcmFkZXgg
VmVyZGluIGlNWDhNIE1pbmkgYQ0KPiA+IGNvbXB1dGVyIG9uIG1vZHVsZSB3aGljaCBjYW4gYmUg
dXNlZCBvbiBkaWZmZXJlbnQgY2FycmllciBib2FyZHMuDQo+ID4gDQo+ID4gVGhlIG1vZHVsZSBj
b25zaXN0cyBvZiBhbiBOWFAgaS5NWCA4TSBNaW5pIGZhbWlseSBTb0MgKGVpdGhlciBpLk1YIDhN
DQo+ID4gTWluaSBRdWFkIG9yIDhNIE1pbmkgRHVhbExpdGUpLCBhIFBDQTk0NTBBIFBNSUMsIGEg
R2lnYWJpdCBFdGhlcm5ldCBQSFksDQo+ID4gMSBvciAyIEdCIG9mIExQRERSNCBSQU0sIGFuIGVN
TUMsIGEgVExBMjAyNCBBREMsIGFuIEkyQyBFRVBST00sIGFuDQo+ID4gUlg4MTMwIFJUQywgYW4g
b3B0aW9uYWwgU1BJIENBTiBjb250cm9sbGVyIHBsdXMgYW4gb3B0aW9uYWwgQmx1ZXRvb3RoLw0K
PiA+IFdpLUZpIG1vZHVsZS4NCj4gPiANCj4gPiBBbnl0aGluZyB0aGF0IGlzIG5vdCBzZWxmLWNv
bnRhaW5lZCBvbiB0aGUgbW9kdWxlIGlzIGRpc2FibGVkIGJ5DQo+ID4gZGVmYXVsdC4NCj4gPiAN
Cj4gPiBUaGUgZGV2aWNlIHRyZWUgZm9yIHRoZSBEYWhsaWEgaW5jbHVkZXMgdGhlIG1vZHVsZSdz
IGRldmljZSB0cmVlIGFuZA0KPiA+IGVuYWJsZXMgdGhlIHN1cHBvcnRlZCBwZXJpcGhlcmFscyBv
ZiB0aGUgY2FycmllciBib2FyZC4NCj4gPiANCj4gPiBUaGUgZGV2aWNlIHRyZWUgZm9yIHRoZSBW
ZXJkaW4gRGV2ZWxvcG1lbnQgQm9hcmQgaW5jbHVkZXMgdGhlIG1vZHVsZSdzDQo+ID4gZGV2aWNl
IHRyZWUgYXMgd2VsbCBhcyB0aGUgRGFobGlhIG9uZSBhcyBpdCBpcyBhIHN1cGVyc2V0IGFuZCBz
dXBwb3J0cw0KPiA+IGFsbW9zdCBhbGwgcGVyaXBoZXJhbHMgYXZhaWxhYmxlLg0KPiA+IA0KPiA+
IFNvIGZhciB0aGVyZSBpcyBubyBkaXNwbGF5IGZ1bmN0aW9uYWxpdHkgc3VwcG9ydGVkIGF0IGFs
bCBidXQgYmFzaWMNCj4gPiBjb25zb2xlIFVBUlQsIFVTQiBob3N0LCBlTU1DIGFuZCBFdGhlcm5l
dCBhbmQgUENJZSBmdW5jdGlvbmFsaXR5IHdvcmsNCj4gPiBmaW5lLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
PiA+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
TWFrZWZpbGXCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDQgKw0KPiA+IMKgLi4uL2R0cy9mcmVlc2Nh
bGUvaW14OG1tLXZlcmRpbi1kYWhsaWEuZHRzacKgwqAgfMKgIDE0MyArKw0KPiA+IMKgLi4uL2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLWRldi5kdHNpIHzCoMKgIDY3ICsNCj4gPiDC
oC4uLi9pbXg4bW0tdmVyZGluLW5vbndpZmktZGFobGlhLmR0c8KgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCAxOCArDQo+ID4gwqAuLi4vZnJlZXNjYWxlL2lteDhtbS12ZXJkaW4tbm9ud2lmaS1kZXYu
ZHRzwqDCoCB8wqDCoCAxOCArDQo+ID4gwqAuLi4vZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGlu
LW5vbndpZmkuZHRzacKgIHzCoMKgIDc1ICsNCj4gPiDCoC4uLi9mcmVlc2NhbGUvaW14OG1tLXZl
cmRpbi13aWZpLWRhaGxpYS5kdHPCoMKgIHzCoMKgIDE4ICsNCj4gPiDCoC4uLi9kdHMvZnJlZXNj
YWxlL2lteDhtbS12ZXJkaW4td2lmaS1kZXYuZHRzwqAgfMKgwqAgMTggKw0KPiA+IMKgLi4uL2R0
cy9mcmVlc2NhbGUvaW14OG1tLXZlcmRpbi13aWZpLmR0c2nCoMKgwqDCoCB8wqDCoCA5NSArKw0K
PiA+IMKgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLmR0c2nCoMKgwqDCoCB8
IDEyNzcgKysrKysrKysrKysrKysrKysNCj4gPiDCoDEwIGZpbGVzIGNoYW5nZWQsIDE3MzMgaW5z
ZXJ0aW9ucygrKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbS12ZXJkaW4tZGFobGlhLmR0c2kNCj4gPiDCoGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLWRldi5kdHNp
DQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLXZlcmRpbi1ub253aWZpLWRhaGxpYS5kdHMNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLW5vbndpZmktZGV2
LmR0cw0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtbS12ZXJkaW4tbm9ud2lmaS5kdHNpDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXZlcmRpbi13aWZpLWRhaGxpYS5k
dHMNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bW0tdmVyZGluLXdpZmktZGV2LmR0cw0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS12ZXJkaW4td2lmaS5kdHNpDQo+ID4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1t
LXZlcmRpbi5kdHNpDQo+ID4gDQo+IA0KPiAoLi4uKQ0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXZlcmRpbi5kdHNpIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLQ0KPiA+IHZlcmRpbi5kdHNpDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjIzZWI2OTVhNTI2Ng0KPiA+
IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0tdmVyZGluLmR0c2kNCj4gPiBAQCAtMCwwICsxLDEyNzcgQEANCj4gPiArLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgT1IgTUlUDQo+ID4gKy8qDQo+ID4g
KyAqIENvcHlyaWdodCAyMDIyIFRvcmFkZXgNCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVk
ZSAiZHQtYmluZGluZ3MvcHdtL3B3bS5oIg0KPiA+ICsjaW5jbHVkZSAiaW14OG1tLmR0c2kiDQo+
ID4gKw0KPiA+ICsvIHsNCj4gPiArwqDCoMKgwqDCoMKgwqBjaG9zZW4gew0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBib290YXJncyA9ICJjb25zb2xlPXR0eW14YzAsMTE1MjAw
IGVhcmx5Y29uIjsNCj4gDQo+IGVhcmx5Y29uIGlzIGEgZGVidWcgdG9vbCwgc28gc2hvdWxkIG5v
dCBiZSBwYXJ0IG9mIG1haW5saW5lIERUUyBieQ0KPiBkZWZhdWx0LiBFbnRpcmUgYm9vdGFyZ3Mg
cHJvcGVydHkgbG9va3MgYWN0dWFsbHkgbm90IG5lZWRlZC4NCg0KWWVzLCBJIHdpbGwgcmVtb3Zl
IGl0IGluIHYyLg0KDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0ZG91dC1w
YXRoID0gJnVhcnQxOw0KPiA+ICvCoMKgwqDCoMKgwqDCoH07DQo+ID4gKw0KPiANCj4gKC4uLikN
Cj4gDQo+ID4gKy8qIFZlcmRpbiBFVEhfMSAoT24tbW9kdWxlIFBIWSkgKi8NCj4gPiArJmZlYzEg
ew0KPiA+ICvCoMKgwqDCoMKgwqDCoGZzbCxtYWdpYy1wYWNrZXQ7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgcGh5LWhhbmRsZSA9IDwmZXRocGh5MD47DQo+ID4gK8KgwqDCoMKgwqDCoMKgcGh5LW1vZGUg
PSAicmdtaWktaWQiOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHBoeS1zdXBwbHkgPSA8JnJlZ19ldGhw
aHk+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVl
cCI7DQo+ID4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZwaW5jdHJsX2ZlYzE+Ow0KPiA+
ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmwtMSA9IDwmcGluY3RybF9mZWMxX3NsZWVwPjsNCj4gPiAr
DQo+ID4gK8KgwqDCoMKgwqDCoMKgbWRpbyB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGV0aHBoeTA6IGV0aGVybmV0LXBoeUA3IHsNCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAiZXRoZXJuZXQt
cGh5LWllZWU4MDIuMy1jMjIiOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzE+Ow0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0cyA9IDwxMCBJ
UlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbWljcmVsLGxlZC1tb2RlID0gPDA+Ow0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDc+Ow0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoH07DQo+ID4gK307
DQo+ID4gKw0KPiA+ICsvKiBWZXJkaW4gUVNQSV8xICovDQo+ID4gKyZmbGV4c3BpIHsNCj4gPiAr
wqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICvCoMKgwqDCoMKg
wqDCoHBpbmN0cmwtMCA9IDwmcGluY3RybF9mbGV4c3BpMD47DQo+ID4gKyNpZiAwDQo+IA0KPiBQ
bGVhc2UgZHJvcCBpdCBvciBleHBsYWluIHdpdGggYSBjb21tZW50IHdoeSB3ZSBuZWVkIGRlYWQg
Y29kZSBpbiBMaW51eA0KPiBrZXJuZWwuDQoNClllcywgSSBhZ3JlZS4NCg0KPiA+ICvCoMKgwqDC
oMKgwqDCoGZsYXNoQDAgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI3Np
emUtY2VsbHMgPSA8MT47DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBh
dGlibGUgPSAiamVkZWMsc3BpLW5vciI7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJlZyA9IDwwPjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3BpLW1h
eC1mcmVxdWVuY3kgPSA8ODAwMDAwMDA+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoH07DQo+ID4gKyNl
bmRpZg0KPiA+ICt9Ow0KPiA+ICsNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=
