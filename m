Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C333B46A6A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349374AbhLFURU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:17:20 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:48868
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349349AbhLFURS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:17:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKxDMYEK3uMK0pm9UBL8LAuDmHyFVYHEjctwYYilVixOdxgtm2EBoNdNqpSSaVh4+xHHvE3vvhLMZX136mzKM+VjquZ08uC5khxyTpcX+nvd7VPpUBWzRUSYTcvNMJQODnyx3iNiO4wPz19QuzRQcBEuqbYtjGPmJHKzCZGZF5AcCaY6sVK84B/6UVbhsR/me2r2RvYeQnssMzvGb2vLu2b3JrTSgDrH4C/uf2/bqYBjwbFaUveGmsLS0tvd4SfzrHjkQn1VlaoVKR+F5t3EUTCw1aDHI7DniDEyPaeKZPkOND+L6t3AySTmTPa0JvMTJc9u8YnIZECQiCiz0cGNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXvdnZF/+Fpig7WvRCAcmTJ8r1cZ4SybtxtmkYFxuVM=;
 b=CMurwFrUPN+mriOscN5mi+Yqpj4QF6etrfrfA6ju2hUdKGisqI5b3xYykN1YuojD/0yuy/LaixPVHbCLnaRZaM2U/0f6ZEderD6cnuFcTTkpimT5SKLEKrrT+gciIW+1/zvxf1T/VKAB8fjgmxvB9J38BJcGpen21QQ6ewXnJ4FcJ/Qic/alZXE0GIcKwNrUJ0c5NZ5VBDxO/4zQ33x5vXLjxaf61SKEGkso9RrXZZ90XbdS/4Q3v8I1aVasZov3gwvB16bXnxaS0SLbRKcQj0aUlg9A9DXesy6y6BX1ZkSPFEI3GugqTKgDIY5CJInBJ/isRLpv0zUoSKuykUS+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXvdnZF/+Fpig7WvRCAcmTJ8r1cZ4SybtxtmkYFxuVM=;
 b=Rz9g7LxfzHHdg/h32J4LG2ale4E1Hx9+yPyXiPoiaLATZMr3TGrH8LyvTEg78mIGge+ZZa2ciBwA/nKTdqgpj7hVN70KaccgwUTjoF9rWnazdUmJvbbJnJm+mbwH4tu4EavvyjJn2V97Ut8W5Wiqo94bjuzvFhXjNseU8NYpAvo=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR1001MB1207.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:66::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 20:13:43 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 20:13:43 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>
Subject: RE: [PATCH v5 1/5] mfd: da9062: make register CONFIG_I writable
Thread-Topic: [PATCH v5 1/5] mfd: da9062: make register CONFIG_I writable
Thread-Index: AQHX6m0sOxzGhIFJw0ykibdS1Aiua6wlrA1AgAAHu4CAADLecA==
Date:   Mon, 6 Dec 2021 20:13:43 +0000
Message-ID: <DB9PR10MB46522898DCCFA0029638753E806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <DB9PR10MB4652F10355222D5DD1A65E50806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <83fad886-541c-987c-1f38-7029aca41892@roeck-us.net>
In-Reply-To: <83fad886-541c-987c-1f38-7029aca41892@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f0eaa43-878e-4d92-3547-08d9b8f4e6f8
x-ms-traffictypediagnostic: DB6PR1001MB1207:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR1001MB12074BC455B95415EFDA0FAEA76D9@DB6PR1001MB1207.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yAAK0kYPc5swk5dCFzfSlim7QgMJXMHHc15cPrQ/Lz8yUssYVgj5mDSf42t6L4zmzMg/NHBnnvFBvVnuBD/FJ1mg1psy2DP+J2mMG9Bqoqe2MOo6fTEujFfJ9Nzq3o+8o7z/baPUev31AmZ3Tp2mreti16DR5l5BKK5evV901eHhWOrCi1pGZZqtddNl2Ee6USQEkyokPQsAY0gtrUMTivP4jqv9B9qoVHDUgF1PCrQ1xTEFvxVKkTEu1AmwMgLx9R5B8nt6m9HDaE/bxMauUcoMKdx977Jd5VzjrcrMQDR4OGuBh7eCRxUapbYjKAHOl11Q1dVJniBTSSITmoCENyZymsNDKydQuX1p3cDjw/QsikgAngNGorLEd8JP9BSIcbU2hLfKMUEbtBxyJwRovL0P61743hw3fkmzb/sTCDXTz/uvFJpvaV/0EvELVbbDH9aAska8Jw/2iN40XsZ+752mcppFcrpR1S1Enl+wZiqnzy5HSjWqcvN6Ss0De0CZ65D4v1kkD4EppT6ydUnExAvr3WJUTbGpxATSvP8e+IJm00dfuSAM1bmKcqNLGzp+FOmIrFpE4D9+85dlBjanpKfZeYkh9TaS+IHR82wy9/BENFiUOsI9JLl6b5Q/GBKEhwOfY2Nofj7b0TrHyZcrlUf0BjLKXhcuFp8c1jbFS/lo2Vjb7ONpWIx4NcWzSxz0g/TL2cPSIrLcKgAQdlrSIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(86362001)(122000001)(38070700005)(8936002)(64756008)(26005)(7416002)(76116006)(66946007)(8676002)(66476007)(66446008)(508600001)(38100700002)(5660300002)(66556008)(71200400001)(4744005)(52536014)(316002)(7696005)(6506007)(110136005)(54906003)(53546011)(4326008)(55016003)(33656002)(2906002)(55236004)(83380400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RitxNlVLNzgxd1JLSllhRXBwNkdxNnZEdE45Njd3VmMyZnpNcnA5Qk1PWW44?=
 =?utf-8?B?WXZwNzRDbjhnWFlOUlFESUNobW8vL2JuOXhNOFNRRjk0WTdGRzZTMjRUOEp6?=
 =?utf-8?B?dTUybWFtSzdJaFV0d2hyK3Z4NUFBUC9QbnRiOExqVU90MXpZNkJ2dHRCVXNQ?=
 =?utf-8?B?d01mc1hpS3JZRkJyMTl0YWdOQmdUT2lzOEVTTzY0aDMzYmdFNHBUSzNJdmlC?=
 =?utf-8?B?QmVBTUJiSTduc25vOVlyYnplVkVJYnBFMzFaMDR0RVFhRGprcmNqMzFRNytt?=
 =?utf-8?B?bG8ybEdWNG5XeDV0VUhsQno1UXF6VVRIWEpqMlFJVTF1disxcTUyYSs0VTRv?=
 =?utf-8?B?ZW9aaS91VXY1K2RZZkJmSkdNSXRtdXFoSEVpS0R5bnJoVURBeS9jQnV1SjN2?=
 =?utf-8?B?WVdLZXN2QWt2ZVJKQkRKSzhRZDJSRGJnTmVUbk01ajNvaEpURnBvRjJEdk9N?=
 =?utf-8?B?VUtzc0VWOWVrRGZxOEJrcW40alc3Q2xFWG9ZWmREQXVDVVJYK0JXVlY5ckNB?=
 =?utf-8?B?WUNxd0w5cFAwa01YcmJZR2l4RUpHK290eDN1SHpyVG9maE9BNHpxS3MvV3Bh?=
 =?utf-8?B?RTJERU9sVTUvQnNMaG1XMWxYUjRZVURIdk9RcTNoNHRBSjBnQ29nWUl0blJL?=
 =?utf-8?B?NGUxKzZTTlBSTXlmc1pSTFJueExPekJrNFNWbzJQWHJ6UXgrRzVSeC9rSk5q?=
 =?utf-8?B?NjM0T1pnOENwWE1QaTk5d2ZWZ2ltcUp6VUR6am9GY3BKdmo3K0hhU3F5L0M5?=
 =?utf-8?B?MHR1Mm44TTc1b2pFVHo3UE5FcXhSZlVpYVFkMHFYK3RMZW0rNlo5SlVISjY5?=
 =?utf-8?B?M055NkFIcGk0cVZWdXdwQkdBU3lhdk03NkxLVU5wQlRSOVJ4eDFzRkZySXdT?=
 =?utf-8?B?VGpLSTVKZUlPc2ttVktHUkl4TGcrcC9zWUlaU05EdXlvaWFvbDRKWHBqUFpk?=
 =?utf-8?B?dHMwWDFGdDJPUFI3V282N3BFRUtmR29pMkNJNnMvT0o4MzNlSDdSckxZeHZz?=
 =?utf-8?B?YUFJdHkwUSs4WmI0YXJaT3dqdFJkNXZLMC84c2k1blVkZU96NFNsRE5Vd3Jj?=
 =?utf-8?B?aisraWI4ZldiSUF6U2JnY0swOFdsdldhMlFEOGFSclMweU91Yy8ycElvOVQv?=
 =?utf-8?B?RnJpS3lWK1FmY1QyS29FU3JaRHNJalZab3YwdWlMalQwNlBxRVNhN1BoR3lm?=
 =?utf-8?B?dExOZFFZYXIxK2FqbVppOTFDeENNN3dHQk1RR041YjNqTUx2YTFmcXhGS0Jn?=
 =?utf-8?B?aFEwcnFOZFZDM1RZbHIrWSsvY2hjUFVGM21pQklCWmNOS3RabzVyMFN2VHov?=
 =?utf-8?B?Y1VRNlBPbFcwN3lWU3ZXWTBPbUJRMVAxNFdramlFYzhRMWcyVE5VS1ZnQW1L?=
 =?utf-8?B?a0N6cGI0WURQK2NFVmp6WUNwM1pWNitXVW1ySlFrVFFZVlFmWXAvbXI1K283?=
 =?utf-8?B?RHNiT252ek84aThnbzlpdHU0WENsRVlDSUh4MzNEZE9sdksvbVIreU9UMTNJ?=
 =?utf-8?B?alhzZjFXa3M1RllaelBuTGpnc3BOZ1ZlemEyK01SSERYNHA4d2kxZ0tWRW1J?=
 =?utf-8?B?ODE0L1ZrYWNTczZBams2NVFMZktRMnFrNnhRQ211d2pNY2RKcTNEK1lra2hP?=
 =?utf-8?B?bXVIZHdTWHhDSkR5YzArVlUwN0xIQi96QjRhNjFmcitTNG1sYTJDcEZsUGpH?=
 =?utf-8?B?YjRqT2s1U3kwYXF6dWJoN1pHb3hKRUtnVkhGb0p6dldnMmhTdWRIWEd6b05o?=
 =?utf-8?B?Mzh6RXBBVkNoZGdkbVBzSG54VTM1Z2lFbHdlbElxdXZjNDY3TmllMDBFUWlI?=
 =?utf-8?B?S3RMeHExZ0p1TkZCeDRNRjZGaS95ZFlxaVQ5bklZbU9OeEYweldnQnBuRk1s?=
 =?utf-8?B?ekF2b2gvVzlhd0FFM2xxcmpwZXVjK21uT2FjQnIxcktDUlpCaDY0THU5ZzlM?=
 =?utf-8?B?RHlGUllCWitRbVlNQnVaYjg4NEpNVTVIVmtQKzdBeWF3dnU1dlMxV0xseDkz?=
 =?utf-8?B?UWNuOXhLaEswc2hiRzZJRXNDZkduLzhhRWdCdUN3WmxzeVRCRFBTWlRvb3dl?=
 =?utf-8?B?ZWMwRktiVWRaTk5yYWlocUJxSFRtcDBqamdSL3FTeWdtNDhMNkYwR2s5Q2lC?=
 =?utf-8?B?MktjaGxXVDBFUDZZTTE2c1NYbnNlL1VzZEw5dkZKcFB1K0p6ZXg3ckpBYmRk?=
 =?utf-8?B?bCtrRDN1WkRRbG0rZUl2OEVCMGxwaHVMM0E0S0MyWklTMjBHY1Nmcm1HMGFJ?=
 =?utf-8?B?WmZjMm1RTU5pemhhbTFnc01KZEtBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0eaa43-878e-4d92-3547-08d9b8f4e6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 20:13:43.5237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2MjewflRkGx8xL/W6eEYJluYyy29Q1ZiDywEc8lLG2bb35sjozl+CqCsn9ORLgAPU8QeyXShIw5jUIzyIjyzCgpOqMPa9kUouBxJnT4TJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYgRGVjZW1iZXIgMjAyMSAxNzoxMiwgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiBBbHNv
LCBJIGRvIG5vdCBsb29rIGludG8gb25lIHBhdGNoIG9mIGEgc2VyaWVzIGFuZCBhcHBseSB0YWdz
IHRvIG90aGVyDQo+IHBhdGNoZXMgb2YgdGhhdCBzZXJpZXMuIFNpbWlsYXIgcmVhc29uLCBvbmx5
IGhlcmUgaXQgaXMgd29yc2UgYmVjYXVzZSBXaW0NCj4gbWF5IHB1bGwgYSBwYXRjaCBmcm9tIHBh
dGNod29yaywgZnJvbSBhbiBlLW1haWwsIG9yIGZyb20gbXkgd2F0Y2hkb2ctbmV4dA0KPiBicmFu
Y2guIFdlIGNhbid0IGhhdmUgYWxsIG9mIHRoZW0gaGF2ZSBkaWZmZXJlbnQgdGFncywgc28gSSB0
YWtlIHdoYXQgaXMNCj4gaW4gcGF0Y2h3b3JrIGFuZCBub3RoaW5nIGVsc2UgKGFuZCB5b3VyIHVw
ZGF0ZWQgUmV2aWV3ZWQtYnk6IHRhZyB3aWxsDQo+IG5vdCBhcHBseSB0byBvdGhlciBwYXRjaGVz
IG9mIHRoZSBzZXJpZXMgYmVjYXVzZSBpdCBpc24ndCBpbiBwYXRjaHdvcmsNCj4gZm9yIHRob3Nl
KS4NCg0KVGhhdCdzIGZhaXIgZW5vdWdoLiBJJ2xsIHNlbmQgdGFncyBhZ2FpbiBmb3IgdGhlIG90
aGVyIGluIHRoZSBzZXJpZXMuIFRoYW5rcw0K
