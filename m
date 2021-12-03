Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3674671B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378511AbhLCFq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:46:26 -0500
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:27719
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231182AbhLCFqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:46:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA7pzFHQ3qg+ivAogkxZQKWV1FjBbnsdfyDBfrTjP1xKlLswHjQWvXDcAtN+0nrc1JPQmtr45aDrBqvnhgY/XeY5oAQ3+aAn4jOvj//g+Wy3QEBZ++SrkzgbvaNQFouim8r4HtymMsL0NP26p+urMGnZc/UWp5XuDaGdmb6FDjz+b+n2869lKRYmSBTyOcMVGvsk7Q+67nn+0pLXMfKuaVGndEYF14h6AhJ5IzUIcNXTSqhAvHLOcTISE/Jo4WWlpxcqNHJ7VLuxlXRgOKf7xvQ9Dr+e+qGWUkkf4FBXBf9yuPbvW7aZCsngUmgWt5kGL8lxdGJNfn19lorkZ2wltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ9O1A5z0qxQ5Gj2aoQb/vWfEJti/ga/VKv1+f1Jdc8=;
 b=k3LqDYkaCb64gvZjlq1kQPIuNDNhCdYrmTxZIlhrQ5bCXv27UnLxuO16/4sRmg0aaJuKakaFtAw1TI69DoYp8uHSWitJp1V91rZUwNs1duLHqdg/gS7cAveyaDQrRq8vd6N2kaXyxSY3Z9qErWVvqqM0FJwTWH73chuPDvyS8TGniMmvs6Vfd0ib9VW5QpsmQA7jdT5gEsMxNDScVLiUl8u1JTAFCGqFwy1HAPLb2QLphP/w+5YBdflFxt9rUTL+u2Ept4TmMLo9i4MW7tCtemL9gtfl6LkcI21mIvO+/X0L/hSkRK8IdjALpsUlp0ZnoDRDn5ashpn4o5Xr3b2JDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ9O1A5z0qxQ5Gj2aoQb/vWfEJti/ga/VKv1+f1Jdc8=;
 b=MKsgoAN2ZXAQa7HkhBRHvfd+zb14u5u7zmy5GRUCl4N/wGOExQhApP38Sg3K8O4ISIkehx1YzOUqroK5IGtvLnOzcX603oehwu/Glp4mhFe3nvthHUy2BAWvlxjj/mIRgfXMXOGWF8a9hiRE5Jq1gb88k9bI4inDX4/zEsy3HYY=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR0401MB2658.eurprd04.prod.outlook.com (2603:10a6:203:37::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 05:42:58 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 05:42:58 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v13 08/13] media: amphion: add v4l2 m2m vpu
 decoder stateful driver
Thread-Topic: [EXT] Re: [PATCH v13 08/13] media: amphion: add v4l2 m2m vpu
 decoder stateful driver
Thread-Index: AQHX5c0LA8QwmwTrsU+sSndqn0F2gawgOGoAgAAIJXA=
Date:   Fri, 3 Dec 2021 05:42:58 +0000
Message-ID: <AM6PR04MB6341AC4C0057B09DB8A58234E76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
         <9122e66af668c095548321d45dec33a3fd6ee77d.1638263914.git.ming.qian@nxp.com>
 <fceda1576bcb2fc4e576b59e09214ab1320558b3.camel@ndufresne.ca>
In-Reply-To: <fceda1576bcb2fc4e576b59e09214ab1320558b3.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a7a9683-d26c-45f6-094a-08d9b61fc32d
x-ms-traffictypediagnostic: AM5PR0401MB2658:
x-microsoft-antispam-prvs: <AM5PR0401MB26589700BAFFDFE73D422398E76A9@AM5PR0401MB2658.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0FDxf1I4exFnBtz4RZLUNOi0LOSGnllcETArfyN2Mtiql+T4o9wD0YMVrYs4/qhXX9q4eB9jpJ0y5AlzDWfzIUvpl/mUsV69Opji3hVwrRZ7zAvWgmRijwemXPrbzl/MN06ZHdTUOwrhnIc4+iPXg3CVUHzWD+iM2bDQ3gcVa6pGx3XggnFyZcMpoAM2dTOYE64b3U2X9kTKmB8ZSqAbIk89LaGu+8mOylPAWMSa4eYU41F6TDD9+yu3NnbXKifDyU4XaXzAsOOaXt/OnlwvfGKTDXLVbMVMAi6LSVgEytZ+VWkid04xSZPUV1Hjvpgs2Kz3OK2NpGdvpgcNwHUUCIVaCqhUB4t4eDFZuc2o50X8I7Qf+2H6ygW0lSK8KhzlwHF8c6sxlULzXmKmAoseINZvvxGPLLm+khvES8Is9Z9GhpjEhU3z0O/hntzC1oPyzPChfTXO/cTNdVdlHdRC6IufCekMo/DYfOS2Vd5tFZkxfP4oCSTtFu8sk16qVyFeQI7Kh0odBBGS3foGfzVAuDDn9hV66hSe+ibvc6Jm16uhV9NY7SAliExDLWB9aTeEL9cZpUOnxHD0/TL9IsI/1QVPEQqjO720oq9xrYe9eVfg+q0g4sBMQCpHmi86AdFGwfFFZONquedLR96lpBO0RaLHSPTzNKNlaU4ZxRSzvp/jr0/VoV6UxcMiWh092pA3LKerDjlHRkaKIiQaObZwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(186003)(8936002)(26005)(83380400001)(6506007)(66946007)(33656002)(53546011)(7696005)(66446008)(7416002)(508600001)(76116006)(66476007)(55016003)(64756008)(66556008)(9686003)(38100700002)(122000001)(110136005)(86362001)(5660300002)(8676002)(71200400001)(54906003)(316002)(44832011)(52536014)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlNOSFVsN0NuL2RBRTR0Uzkra20wa1Z2aTF0SlBSYk9yZWpmTXFuSjIvU0Rq?=
 =?utf-8?B?R1FQTzZWMlU1V0gvU1hOcUpjdFJHblVzc2tLZEN0c05Lc3NweGpNa20vd0hW?=
 =?utf-8?B?Q1FYZkhkeXhpKzE1WXMvOFpEbEhDMjYrZld6R01OTHBJK09ZZXNiakxlT2tn?=
 =?utf-8?B?Vk5OTVU2Y1p5eUNpMERqcTY3NFIvU01meS96NVBwNVdNcFBJalZWblQvWDNp?=
 =?utf-8?B?U1k1b3pOUkdKaXA2Rm5Va3hLSDJtM2ZaZVI1M0MvQWVIQlQvT2xOZ29nOXB3?=
 =?utf-8?B?UlVaRVBvWnBrWEg4U0ZFRHBDdDJjUnE3a2pIWEFlMGdOL2VxWXFLQmxkdVRw?=
 =?utf-8?B?SHhxVFVvK0Jja28rUEhyYXFhZzJoVWxaYmQ5YjFIaW8vN1IyVzVFWGZabWNo?=
 =?utf-8?B?K250THZuOU5QZThvMHFiZnB1RkQzS3h4MnNldEtyM3I5TXVUc1RmWlN3OVcw?=
 =?utf-8?B?cTF6L1YvbTNZbGRiT1ZtT3U4UkkyRWVZSkY4TmpubzA0S3JxcnBvSWl3Q1lN?=
 =?utf-8?B?ZnJHQVZMVmJsVEwxWWJOWm1kVlU3RWNUOFRsNzQ3Ym1DbE9WeVp3OStQYk5s?=
 =?utf-8?B?a1IydjY0QXZYYkJHQ3JzamdrbDU3czBMV2w1UVRFQWlORzFCT1RoczN1SW5j?=
 =?utf-8?B?Uno0V0ptMmxaQkJyZGV0SncvUlFOM1JaZGoxdy9DRTMrTWJHc3lBMUVjZjVF?=
 =?utf-8?B?UWQzM2VxeHBVbEhGZTVrU2dEYjlOTGJiQ2pHRlNpQjhKTHllaEwzbmxIZndO?=
 =?utf-8?B?QS8ycFllUUtQODVHTWd1eUFNQkZhdThCaHN2cHpNY3MySnBUMjVOVWg5VUZJ?=
 =?utf-8?B?NWJ4UW0rbW03RUpKWjJPYmVUWnBIUStxUkZZbFVidStSWTQvZUZQeCt4UWxQ?=
 =?utf-8?B?L1hFWG1KNU1waFh5ZkxZS25hYkQwb3BDUnZxUWlLR2FtQlpCY2l6TXJCMU1H?=
 =?utf-8?B?TzhpMTMwd1BsMCs2VGN4MnFlQ1p0TncwaXIvZmc2UjY4c0FOOERadnYwMnAy?=
 =?utf-8?B?SWdHb1VEWlFzNE9YVHRReElXM3Y0RTNVYm5nU2Nhb0tkd1R6RC9rWXozaGlT?=
 =?utf-8?B?NFRLaVh1K3BaODdGTW81c1JQek11Zk1xU25ubFgxRWpBWjluUHdnU0dpZ3A1?=
 =?utf-8?B?Q2JZVHE4L1BwZERCbkgzTm9zZzZSTEIvV1VuYVR1amJQYVpZak82dFlTZnNu?=
 =?utf-8?B?SUw3aG80RFl6YmNsK0QwQ1RPQ0VIUVdMR09uWDFzMkN0eStrSHVlR1Mwdlpr?=
 =?utf-8?B?Z0RzcnlpTUhWWWg4anpibkRqVWZ4S0xCRDZpZzROTm4wa0ZDNFdKbUFLVlNo?=
 =?utf-8?B?aFVDVlBhRzBhZmhLdThQSTNsc09tS2VNN0FMd050MGdKU0oyeHcwa3VVUGZM?=
 =?utf-8?B?MlV0MVlEVHNET2dmc0tJK1JKYXdCVWhhandUWlY3blZ0WVYwc3czVFNVUXJz?=
 =?utf-8?B?L09yMXhuZG5pNjVoeXhSUHBSVXIxQ2sweXdmYnhmTDl0QnpWalRVWjd1ZDJl?=
 =?utf-8?B?QlhYZEEzdCt1d3dlMlg0MmRnZitKWisrbEo5ek5OTTJndWVydS91RjFTK1M4?=
 =?utf-8?B?a05BZVdIb0hmUWJjOTRLUE9jNFM4NGVYWnYweTFybTVhdWwxZWl3ZGJpZTJr?=
 =?utf-8?B?VUxUdmIzUTVGeTQxSEhUa0dST3VLMG1PL09XK091SWhRcjNLM0RMYWZKVGFw?=
 =?utf-8?B?QjM5a1R0aHU5bElGeTdwbGJhOEVRS3A5Q1ZOdTJseTNCbTB5MUVScER2Q2wz?=
 =?utf-8?B?SEZNL1IrRVZleG4rUWI0QnJRSFY0RWE5Nk1DRU5qR2o3L0RCbDNGaVFIYllL?=
 =?utf-8?B?Q0JTMGFVWGZDMnU3WTBIL2Z4NFFDR2lhNnN4OGtoczBidDdwS21DczBwTndN?=
 =?utf-8?B?anZtWkF2SlJ2N0RrN0VuYnlLanYyajBBZVp4Q3RvenBTVEZJdEJkNm9CRnQr?=
 =?utf-8?B?eWVWclNsVGF4d1hrQ3MyNlRDTHhqeHZzWlVCeGNDRFZqQmo0Z01Nem1ONElN?=
 =?utf-8?B?SG13YXdvWGpnVjY5N2lVUVYrVDAyRFBrVGF6V01KNWNFU0t1MjhVeDZGMTlG?=
 =?utf-8?B?dG15amdIK09iYWlmSW5YYm93Q2M5Vm9DMWJTQmNZRUh6L05GeWZUOGVtOXBk?=
 =?utf-8?B?eC9oT2xGbk9Bb003TVBibDlwTU1QWGsyNWJIdmxoaWFod0c5YytyRHFjTS9O?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7a9683-d26c-45f6-094a-08d9b61fc32d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 05:42:58.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v32tRkWyk5R5dTzK7AA1NTTet67f1wDxYbjfYnpmrOhT6nCsVYZ6amYp4u2F9hbqsJypWi6XVHAKgmT0oV/vVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWNvbGFzIER1ZnJlc25lIFtt
YWlsdG86bmljb2xhc0BuZHVmcmVzbmUuY2FdDQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMywg
MjAyMSAxMjo1NiBQTQ0KPiBUbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47IG1jaGVo
YWJAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3Jn
OyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlDQo+IENjOiBodmVya3VpbC1jaXNjb0B4czRhbGwubmw7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPjsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT47DQo+IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYxMyAwOC8x
M10gbWVkaWE6IGFtcGhpb246IGFkZCB2NGwyIG0ybSB2cHUNCj4gZGVjb2RlciBzdGF0ZWZ1bCBk
cml2ZXINCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gTGUgbWFyZGkgMzAgbm92ZW1i
cmUgMjAyMSDDoCAxNzo0OCArMDgwMCwgTWluZyBRaWFuIGEgw6ljcml0IDoNCj4gPiBUaGlzIGNv
bnNpc3RzIG9mIHZpZGVvIGRlY29kZXIgaW1wbGVtZW50YXRpb24gcGx1cyBkZWNvZGVyIGNvbnRy
b2xzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGlqaWUgUWluIDxzaGlqaWUucWluQG54cC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogWmhvdSBQZW5nIDxlYWdsZS56aG91QG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZGVjLmMgfCAxNjgwDQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysNCg0KDQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCB2ZGVj
X2luaXRfZm10KHN0cnVjdCB2cHVfaW5zdCAqaW5zdCkNCj4gPiArew0KPiA+ICsgICAgIHN0cnVj
dCB2ZGVjX3QgKnZkZWMgPSBpbnN0LT5wcml2Ow0KPiA+ICsgICAgIGNvbnN0IHN0cnVjdCB2cHVf
Zm9ybWF0ICpmbXQ7DQo+ID4gKyAgICAgaW50IGk7DQo+ID4gKw0KPiA+ICsgICAgIGZtdCA9IHZw
dV9oZWxwZXJfZmluZF9mb3JtYXQoaW5zdCwgaW5zdC0+Y2FwX2Zvcm1hdC50eXBlLA0KPiB2ZGVj
LT5jb2RlY19pbmZvLnBpeGZtdCk7DQo+ID4gKyAgICAgaW5zdC0+b3V0X2Zvcm1hdC53aWR0aCA9
IHZkZWMtPmNvZGVjX2luZm8ud2lkdGg7DQo+ID4gKyAgICAgaW5zdC0+b3V0X2Zvcm1hdC5oZWln
aHQgPSB2ZGVjLT5jb2RlY19pbmZvLmhlaWdodDsNCj4gPiArICAgICBpbnN0LT5jYXBfZm9ybWF0
LndpZHRoID0gdmRlYy0+Y29kZWNfaW5mby5kZWNvZGVkX3dpZHRoOw0KPiA+ICsgICAgIGluc3Qt
PmNhcF9mb3JtYXQuaGVpZ2h0ID0gdmRlYy0+Y29kZWNfaW5mby5kZWNvZGVkX2hlaWdodDsNCj4g
PiArICAgICBpbnN0LT5jYXBfZm9ybWF0LnBpeGZtdCA9IHZkZWMtPmNvZGVjX2luZm8ucGl4Zm10
Ow0KPiA+ICsgICAgIGlmIChmbXQpIHsNCj4gPiArICAgICAgICAgICAgIGluc3QtPmNhcF9mb3Jt
YXQubnVtX3BsYW5lcyA9IGZtdC0+bnVtX3BsYW5lczsNCj4gPiArICAgICAgICAgICAgIGluc3Qt
PmNhcF9mb3JtYXQuZmxhZ3MgPSBmbXQtPmZsYWdzOw0KPiA+ICsgICAgIH0NCj4gPiArICAgICBm
b3IgKGkgPSAwOyBpIDwgaW5zdC0+Y2FwX2Zvcm1hdC5udW1fcGxhbmVzOyBpKyspIHsNCj4gPiAr
ICAgICAgICAgICAgIGluc3QtPmNhcF9mb3JtYXQuYnl0ZXNwZXJsaW5lW2ldID0NCj4gdmRlYy0+
Y29kZWNfaW5mby5ieXRlc3BlcmxpbmVbaV07DQo+ID4gKyAgICAgICAgICAgICBpbnN0LT5jYXBf
Zm9ybWF0LnNpemVpbWFnZVtpXSA9DQo+IHZkZWMtPmNvZGVjX2luZm8uc2l6ZWltYWdlW2ldOw0K
PiA+ICsgICAgIH0NCj4gPiArICAgICBpZiAodmRlYy0+Y29kZWNfaW5mby5wcm9ncmVzc2l2ZSkN
Cj4gPiArICAgICAgICAgICAgIGluc3QtPmNhcF9mb3JtYXQuZmllbGQgPSBWNEwyX0ZJRUxEX05P
TkU7DQo+ID4gKyAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgaW5zdC0+Y2FwX2Zvcm1hdC5m
aWVsZCA9IFY0TDJfRklFTERfSU5URVJMQUNFRDsNCj4gDQo+IEFzIGEgZm9sbG93dXAsIHRoaXMg
c2hvdWxkIGJlIGNvbmRpdGlvbmFsIHRvIHRoZSBjaG9zZW4gcGl4ZWwgZm9ybWF0LiBJZiBJDQo+
IHVuZGVyc3Rvb2QgY29ycmVjdCwgeW91IHByb2R1Y2UgaW50ZXJsYWNlZCBpcyBvbmx5IHByb2R1
Y2UgZm9yIGxpbmVhciBOVjEyLCBmb3INCj4gdGlsZWQgdGhlIGZpZWxkcyBhcmUgb3V0cHV0ZWQg
c2VwZXJhdGVkIGluIHRoZWlyIHJlc3BlY3RpdmUgdjRsMl9idWZmZXIuIE5vdGUNCj4gc3VyZSB3
aGVyZSB5ZXQsIGJ1dCB0aGUgVjRMMiBzcGVjIHJlcXVpcmVzIHlvdSB0byBwYWlyIHRoZSBmaWVs
ZHMgYnkgdXNpbmcgdGhlDQo+IHNhbWUgc2VxX251bSBvbiBib3RoLg0KDQpUaGUgYW1waGlvbiB2
cHUgd2lsbCBzdG9yZSB0aGUgdHdvIGZpZWxkcyBpbnRvIG9uZSB2NGwyX2J1ZiwgDQpTbyBJJ2xs
IGNoYW5nZSBWNEwyX0ZJRUxEX0lOVEVSTEFDRUQgdG8gVjRMMl9GSUVMRF9TRVFfVEINCg0KPiAN
Cj4gPiArICAgICBpZiAodmRlYy0+Y29kZWNfaW5mby5jb2xvcl9wcmltYXJpZXMgPT0gVjRMMl9D
T0xPUlNQQUNFX0RFRkFVTFQpDQo+ID4gKyAgICAgICAgICAgICB2ZGVjLT5jb2RlY19pbmZvLmNv
bG9yX3ByaW1hcmllcyA9DQo+IFY0TDJfQ09MT1JTUEFDRV9SRUM3MDk7DQo+ID4gKyAgICAgaWYg
KHZkZWMtPmNvZGVjX2luZm8udHJhbnNmZXJfY2hhcnMgPT0gVjRMMl9YRkVSX0ZVTkNfREVGQVVM
VCkNCj4gPiArICAgICAgICAgICAgIHZkZWMtPmNvZGVjX2luZm8udHJhbnNmZXJfY2hhcnMgPSBW
NEwyX1hGRVJfRlVOQ183MDk7DQo+ID4gKyAgICAgaWYgKHZkZWMtPmNvZGVjX2luZm8ubWF0cml4
X2NvZWZmcyA9PSBWNEwyX1lDQkNSX0VOQ19ERUZBVUxUKQ0KPiA+ICsgICAgICAgICAgICAgdmRl
Yy0+Y29kZWNfaW5mby5tYXRyaXhfY29lZmZzID0gVjRMMl9ZQ0JDUl9FTkNfNzA5Ow0KPiA+ICsg
ICAgIGlmICh2ZGVjLT5jb2RlY19pbmZvLmZ1bGxfcmFuZ2UgPT0gVjRMMl9RVUFOVElaQVRJT05f
REVGQVVMVCkNCj4gPiArICAgICAgICAgICAgIHZkZWMtPmNvZGVjX2luZm8uZnVsbF9yYW5nZSA9
DQo+IFY0TDJfUVVBTlRJWkFUSU9OX0xJTV9SQU5HRTsNCj4gPiArfQ0KPiA+ICsNCg==
