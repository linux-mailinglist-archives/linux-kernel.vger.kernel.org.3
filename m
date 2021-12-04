Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCDA468207
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 03:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384109AbhLDCmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 21:42:53 -0500
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:37966
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239083AbhLDCmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 21:42:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tgu1c+/ok3adSRm7niS2geO11QZFmNWGL3JoB7sLdt5aoWceXRMuCLUKql2cLZ8gmNBJyCIJcgu3auew7lc8DM8iwkReF5J4QirjM8b4G/7GTrRmBbT6WKhe5jsCEz3G0hVwybzG72fW1+kv0qFQDOCAaDDyRND6xzJNZ+Yyf/ZXBuT8tXTPX7P+LC7JQhztp9i00vV1wQndzD9GABlSH7Iwe1Lz4NvGaaOh+PLTFUHSfRg51JhBtR/vBrPOFw8SkdFyDzogiSjszQfixYh1z1XkV4psup2RZPawzkxfvrLCw3Xbn8OF4fTtErU3CD3TIHU2BP6bQqID93GaUxEX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/e6qkjAMjEWAru6EpyoOB+kJV6j9cA1HLE6y2RgO1Y=;
 b=FOLdNYnVa4faL5TQ4V8Wd+C0niW9fCgex5sQPKFIseLx5ys9VMT6rEN46DTmulTohKLVxeNqXubHHUbly0VnnpPsbC5IunXhEBwqXSRHGxUtLH1TsfLSCEjzkFonFfWa1xbXQEDLtva6WptdtjNGii5mIzGI1HzwPCkmA/udfwU+k4FpMFxL/kYewmevYFV5bSi3XS/rQ1xgh25YBtJP6tKNDlY3r3zRmrPcZdz9KWMvQnY3a3dY3bi4IXvezp0tpezqPGVSc+ydcWedPXWHASg1KjxSQrcXCJcFaNo0ZK7D1yEB+ft4q6zcLK7VedIjZv8EcP32qwHZMZTRP9ngZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/e6qkjAMjEWAru6EpyoOB+kJV6j9cA1HLE6y2RgO1Y=;
 b=Tk2b87zs4B9+ckKGsO4mw4WlH6bwSFOwu/92f9d7vrQQT7hQ3Ht2EsC2V2sd5jAOq5895DMbMaBRK3xWShQ8EjH1U5vjyEOA2LhPp4pXE9+yCpog8YBTcHbgabTQe+6Ev+ObQPg3s+VSByMaAV4rdgy9i8Nd43iMdElpHwHSLK8=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR0401MB2435.eurprd04.prod.outlook.com (2603:10a6:203:36::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sat, 4 Dec
 2021 02:39:25 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.028; Sat, 4 Dec 2021
 02:39:25 +0000
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
Thread-Index: AQHX5c0LA8QwmwTrsU+sSndqn0F2gawgOGoAgAAIJXCAAAkU4IAAmmiAgADAW3A=
Date:   Sat, 4 Dec 2021 02:39:25 +0000
Message-ID: <AM6PR04MB63410E8101984945F6F1442BE76B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
         <9122e66af668c095548321d45dec33a3fd6ee77d.1638263914.git.ming.qian@nxp.com>
         <fceda1576bcb2fc4e576b59e09214ab1320558b3.camel@ndufresne.ca>
         <AM6PR04MB6341AC4C0057B09DB8A58234E76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <AM6PR04MB6341537EBD82451CA14A5E3EE76A9@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <7e63c1665c96feccadd9c05dc603349b3a93900d.camel@ndufresne.ca>
In-Reply-To: <7e63c1665c96feccadd9c05dc603349b3a93900d.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 269d4251-be44-41b2-c793-08d9b6cf492a
x-ms-traffictypediagnostic: AM5PR0401MB2435:
x-microsoft-antispam-prvs: <AM5PR0401MB243580C0C9805771B466A7CBE76B9@AM5PR0401MB2435.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 32qK7Ezc1drjkDXw95pQm0gJv9bIqKQGSmqA8cgfYk6nELnxzGZNxF7moyYjuK56rP4qgrWf22ALeyx8597UgUQVbSMuuRIffNcEAqJTk/APHT92kfCLzMd3296VX+bLQ7nnd9rG32hvXb+X3mLoaNMbQhNQQHtFWUTlBxekzM44r/tPdVbcSQvLNiTcn2ALhF8jjqwYMtcYam6UK+TP5J1h4vrpPggYbA+ULTifizYQvV73VO+M8f1xYm7h/8Rgyd7jFIgwfah9RVYJxNtrTFgsWeTigS9sxT7J+4Tt4mq9DofR82uJKo144117HsNHi4THp97EjpnByKPgOtseTrm79KG0uiAqAXye46BEgz5RpnUrekHJOp11036C7FgUsltOVU4D5sDCiPThxqUTGygwShQNBqPBZup2oK71eF0ijWD1pjGbZ73130ieUnia1KRi/gc4f876t1DHFXr3gYz01mLMyYrSDycxUofwydT4bqxJUDmt+o1yoyNW37ZJWia7RcpIdBXns81aIpJ9SQ5G9WWEg3Qh6biofe7mweeNhdKAm3/CWcjEbxYx7s9e7O5wjVuWk+xqBDJeyo23Y07P96RAxzdDi+v/dKwUH25KWjALxoduLPfTa9tpoBArH7YN0aNOUeIj8rhIKe9wPFG63IiU4L+tSN18eAiZvpzurY+xYg5EXluULqTEysGcQq17Qj9VLY+py2uFqvYiBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(38070700005)(122000001)(9686003)(2906002)(508600001)(5660300002)(44832011)(6506007)(110136005)(53546011)(52536014)(186003)(26005)(66574015)(8676002)(8936002)(55016003)(83380400001)(7416002)(54906003)(86362001)(33656002)(4326008)(76116006)(66946007)(316002)(71200400001)(7696005)(66446008)(66556008)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEM2ek1LQzYxRHZOWVpwOW5xQXNwYnhDdUZaZWhJY2V3VHdEeGwrS2JSQ3E2?=
 =?utf-8?B?Ry9id3QzTDE3dFBOMmNZRS9DSEJ1K1RnQ0NHOUNoV2RnZEpJcTI4dWNlQnds?=
 =?utf-8?B?M01ManNNVlBzVmppQWdyenVqYnEzemVoVmg0TXZweFF4ZzJla29LZ2VZY09W?=
 =?utf-8?B?VW5adWlwTUlxakZoTEZLQ3V0Uk5aNWlzWVo2T0tYZWF6YnFlY1lJa1B2aTZn?=
 =?utf-8?B?N2tEUkI2SmFiMHFrMTFtM1BvVVIzQitCdEFsOUZFaDVCYjNwbCtJRnNYdDl0?=
 =?utf-8?B?RTgrbVRmSFBYMTExeERUZWJITUE2ZmJnU0k0U2oyV3I1R2lnK3NFM0NaVkVW?=
 =?utf-8?B?cW1YQnphbmttVHVydnhtRzZRVXEzbERaVXE3ZWFlV0FwREtudWppZFZkVExv?=
 =?utf-8?B?ajQyZVFUdDlTc2pYUnN3bVRTbWZad3JpQ0RaL05LUUxQRTV5dmx1M25CM3dw?=
 =?utf-8?B?WDlDNG5KWkF5TXQ2UWN2OVFJOW8vdnIrOU1rTHZBbGtOMXVOaHdKQnE4TUNB?=
 =?utf-8?B?ZCs3cE52Y24xbGI5NHEwN1JBZU0vREdKMEVCRXZMenh6NFlRdDVxVnYvOE5x?=
 =?utf-8?B?VVYxblpvdzlEMXNXRVdKUEdTZWtnUkM1YTFFZUw4SU96aktrRnEwa0VOUzBp?=
 =?utf-8?B?WGdNN09Yd0RwZVpYM1I5eFlQS0JCbEk0S1RDTi9CVnN4dW5VcEVrZExXdVRE?=
 =?utf-8?B?UGdvLzRoSEJKeU8ydTNIZkwvZlViRWJuZjlTN0o3dlRtaWNZVmNXbnlWZTZp?=
 =?utf-8?B?V2liNU1VRWd0Tm9wYTNuenppR3VNakZ1cE9aS3hiLzFxdEtrTEhlRk53MkdQ?=
 =?utf-8?B?MjVvNjB2SU9DUlNiaGVMVDYvVDJ5d3ZMYVJRbmhMTytGS2dpM2pQWUk5SkFi?=
 =?utf-8?B?eWltYm84emE2U3duTTRuWWxTRy9IYVNWeEdEVDNldldsVXN5UzNhOFNMM082?=
 =?utf-8?B?RXNGWFcyVXdoM0tXYU9TU05yaVRTNVpJeDVkVlZxTk94dGlsNHNxeXRYTVFM?=
 =?utf-8?B?dnl4SkorT3RiQXh4YXJYNGcxekg4WUx5ZGRGem44MHRiY2RLelZvUThxSVVJ?=
 =?utf-8?B?ZlZmZ0RCZ1pHVkhDNWNzc3pMc3hJQXNnUWprNkMzQ0JUU1NhaVJ5cE1vNHc1?=
 =?utf-8?B?alVYV1Z0OE5vb2FDRGd3WGdXNUpMR3RhbGNCZ0Jjd09vbkVFbUNaTnJvb2M2?=
 =?utf-8?B?VDA2U1ZQTUNaUUcvdDlpYklrdHlPZnJJSVN2S2s0aU5qdGRuRHI2Kzd5Y1lL?=
 =?utf-8?B?VkJPeDJ0YUZhVHh2VmdaT3I5V01HUnNCQ1dDdU5EMmNkUkdkR0ZBTUpiUWtv?=
 =?utf-8?B?NlJWRVA4ZTk4Rm9FNzFtZlc1ekxwS2x4ZFRJSDhZMllhMGhSeFJ1eXUwZEdx?=
 =?utf-8?B?eGQ4d0ZTbVFmQ0Fra3ZYcHRhdWYxUGRSSmlTSVQ1K2xRVGR6bkFTRGNpQUlz?=
 =?utf-8?B?TUZhdVkrWVBjR3g4enJhaUFlc0hodGtyY0lGajZTdE9UUTdZSnJtbzA3RUZ3?=
 =?utf-8?B?TDdlQVlubVFDRnFDeVFvRTBPaHBNVXNSdWd3dExPaU9xUFMzQTZVMGJRZDRK?=
 =?utf-8?B?ekw1S2dIQit1SlZqbXM1L0Y2bndYajBtb3doN1g5QUNiYzNaWlNkdG8vZWNp?=
 =?utf-8?B?eG9ydnBnZzcrWjZYL2U3aVZ0cWVSQzh3NFMvM0lDT1NzRnZDYWhsaG05SVBS?=
 =?utf-8?B?TUVXVGM3QnhRRzBYMG5nNzloWXBEMXV0NDJaVi9SeXJySjhnSFNOWUM5SmJG?=
 =?utf-8?B?MkE3UUVxYXBZbVFpVy9qOVd0Umdpajc1eEVNd01raXJWQnNuWWRoRDVYcTU0?=
 =?utf-8?B?Q1YvQTFBWDQ2eGpMckFVSWo0ZzduSFllQVphc1M1MXRTbnpKaEFGQ3A5ajBl?=
 =?utf-8?B?ZWM4OVBlL2grOTZXYnBvMnJCNjQrdlNkdFFCVDg2aFduZm5ES2UvSTNnamxZ?=
 =?utf-8?B?MzFtbGhINEM1a1Q3RWdqZEQ2cFlzV3FKNm5USzhTa1FteGY5TTd0Zm8wYkZN?=
 =?utf-8?B?b29jVE9LMlpjeFRnZ3VGWGVkL29IK2VVMThkdVJDZWxpQ2liZWpOTGJoeEN5?=
 =?utf-8?B?d1I3R0ZQQ0lqclFhYUpXa2FYNlduZDVQa2RHTjd1UEcxbDBkWmpHZU1LS1Vp?=
 =?utf-8?B?SXlNWE9HbGYydGFTcVVZOU5JYlhnNC9EaUlTakRIaEJJRjVnUU1ZS1lJbC9S?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269d4251-be44-41b2-c793-08d9b6cf492a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 02:39:25.0612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChTT/FPZES3b8yaCIvhPGUSnbrutzPUehUERm78d2yW7qs3KCkCel7I6kNw7nGi+BETiX1RLyj8A01nLPvbQTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2435
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5pY29sYXMgRHVmcmVzbmUg
W21haWx0bzpuaWNvbGFzQG5kdWZyZXNuZS5jYV0NCj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAz
LCAyMDIxIDExOjEwIFBNDQo+IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPjsgbWNo
ZWhhYkBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5v
cmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4gQ2M6IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5u
bDsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGRsLWxpbnV4
LWlteCA8bGludXgtaW14QG54cC5jb20+OyBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAu
Y29tPjsNCj4gbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYx
MyAwOC8xM10gbWVkaWE6IGFtcGhpb246IGFkZCB2NGwyIG0ybSB2cHUNCj4gZGVjb2RlciBzdGF0
ZWZ1bCBkcml2ZXINCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gTGUgdmVuZHJlZGkg
MDMgZMOpY2VtYnJlIDIwMjEgw6AgMDY6MDEgKzAwMDAsIE1pbmcgUWlhbiBhIMOpY3JpdCA6DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWluZyBRaWFuDQo+
ID4gPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDMsIDIwMjEgMTo0MyBQTQ0KPiA+ID4gVG86IE5p
Y29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPjsgbWNoZWhhYkBrZXJuZWwub3Jn
Ow0KPiA+ID4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlDQo+ID4gPiBDYzogaHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+OyBBaXNoZW5nIERvbmcNCj4gPiA+IDxhaXNoZW5nLmRvbmdA
bnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gPiBTdWJqZWN0OiBSRTogW0VY
VF0gUmU6IFtQQVRDSCB2MTMgMDgvMTNdIG1lZGlhOiBhbXBoaW9uOiBhZGQgdjRsMg0KPiA+ID4g
bTJtIHZwdSBkZWNvZGVyIHN0YXRlZnVsIGRyaXZlcg0KPiA+ID4NCj4gPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogTmljb2xhcyBEdWZyZXNuZSBbbWFpbHRv
Om5pY29sYXNAbmR1ZnJlc25lLmNhXQ0KPiA+ID4gPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDMs
IDIwMjEgMTI6NTYgUE0NCj4gPiA+ID4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+
OyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+ID4gPiA+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHJvYmgr
ZHRAa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiA+ID4gPiBDYzogaHZlcmt1
aWwtY2lzY29AeHM0YWxsLm5sOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiA+IGZlc3Rl
dmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcg
RG9uZw0KPiA+ID4gPiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBsaW51eC1tZWRpYUB2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcNCj4gPiA+ID4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MTMgMDgvMTNdIG1l
ZGlhOiBhbXBoaW9uOiBhZGQgdjRsMiBtMm0NCj4gPiA+ID4gdnB1IGRlY29kZXIgc3RhdGVmdWwg
ZHJpdmVyDQo+ID4gPiA+DQo+ID4gPiA+IENhdXRpb246IEVYVCBFbWFpbA0KPiA+ID4gPg0KPiA+
ID4gPiBMZSBtYXJkaSAzMCBub3ZlbWJyZSAyMDIxIMOgIDE3OjQ4ICswODAwLCBNaW5nIFFpYW4g
YSDDqWNyaXQgOg0KPiA+ID4gPiA+IFRoaXMgY29uc2lzdHMgb2YgdmlkZW8gZGVjb2RlciBpbXBs
ZW1lbnRhdGlvbiBwbHVzIGRlY29kZXIgY29udHJvbHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFNoaWppZSBRaW4gPHNoaWppZS5xaW5AbnhwLmNvbT4NCj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBaaG91IFBlbmcgPGVhZ2xlLnpob3VAbnhwLmNvbT4NCj4gPiA+ID4gPiAt
LS0NCj4gPiA+ID4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZkZWMuYyB8IDE2
ODANCj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4NCj4gPiA+DQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCB2ZGVjX2luaXRfZm10KHN0cnVjdCB2cHVf
aW5zdCAqaW5zdCkgew0KPiA+ID4gPiA+ICsgICAgIHN0cnVjdCB2ZGVjX3QgKnZkZWMgPSBpbnN0
LT5wcml2Ow0KPiA+ID4gPiA+ICsgICAgIGNvbnN0IHN0cnVjdCB2cHVfZm9ybWF0ICpmbXQ7DQo+
ID4gPiA+ID4gKyAgICAgaW50IGk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgIGZtdCA9
IHZwdV9oZWxwZXJfZmluZF9mb3JtYXQoaW5zdCwgaW5zdC0+Y2FwX2Zvcm1hdC50eXBlLA0KPiA+
ID4gPiB2ZGVjLT5jb2RlY19pbmZvLnBpeGZtdCk7DQo+ID4gPiA+ID4gKyAgICAgaW5zdC0+b3V0
X2Zvcm1hdC53aWR0aCA9IHZkZWMtPmNvZGVjX2luZm8ud2lkdGg7DQo+ID4gPiA+ID4gKyAgICAg
aW5zdC0+b3V0X2Zvcm1hdC5oZWlnaHQgPSB2ZGVjLT5jb2RlY19pbmZvLmhlaWdodDsNCj4gPiA+
ID4gPiArICAgICBpbnN0LT5jYXBfZm9ybWF0LndpZHRoID0gdmRlYy0+Y29kZWNfaW5mby5kZWNv
ZGVkX3dpZHRoOw0KPiA+ID4gPiA+ICsgICAgIGluc3QtPmNhcF9mb3JtYXQuaGVpZ2h0ID0gdmRl
Yy0+Y29kZWNfaW5mby5kZWNvZGVkX2hlaWdodDsNCj4gPiA+ID4gPiArICAgICBpbnN0LT5jYXBf
Zm9ybWF0LnBpeGZtdCA9IHZkZWMtPmNvZGVjX2luZm8ucGl4Zm10Ow0KPiA+ID4gPiA+ICsgICAg
IGlmIChmbXQpIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIGluc3QtPmNhcF9mb3JtYXQubnVt
X3BsYW5lcyA9IGZtdC0+bnVtX3BsYW5lczsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIGluc3Qt
PmNhcF9mb3JtYXQuZmxhZ3MgPSBmbXQtPmZsYWdzOw0KPiA+ID4gPiA+ICsgICAgIH0NCj4gPiA+
ID4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgaW5zdC0+Y2FwX2Zvcm1hdC5udW1fcGxhbmVzOyBp
KyspIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIGluc3QtPmNhcF9mb3JtYXQuYnl0ZXNwZXJs
aW5lW2ldID0NCj4gPiA+ID4gdmRlYy0+Y29kZWNfaW5mby5ieXRlc3BlcmxpbmVbaV07DQo+ID4g
PiA+ID4gKyAgICAgICAgICAgICBpbnN0LT5jYXBfZm9ybWF0LnNpemVpbWFnZVtpXSA9DQo+ID4g
PiA+IHZkZWMtPmNvZGVjX2luZm8uc2l6ZWltYWdlW2ldOw0KPiA+ID4gPiA+ICsgICAgIH0NCj4g
PiA+ID4gPiArICAgICBpZiAodmRlYy0+Y29kZWNfaW5mby5wcm9ncmVzc2l2ZSkNCj4gPiA+ID4g
PiArICAgICAgICAgICAgIGluc3QtPmNhcF9mb3JtYXQuZmllbGQgPSBWNEwyX0ZJRUxEX05PTkU7
DQo+ID4gPiA+ID4gKyAgICAgZWxzZQ0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgaW5zdC0+Y2Fw
X2Zvcm1hdC5maWVsZCA9IFY0TDJfRklFTERfSU5URVJMQUNFRDsNCj4gPiA+ID4NCj4gPiA+ID4g
QXMgYSBmb2xsb3d1cCwgdGhpcyBzaG91bGQgYmUgY29uZGl0aW9uYWwgdG8gdGhlIGNob3NlbiBw
aXhlbCBmb3JtYXQuDQo+ID4gPiA+IElmIEkgdW5kZXJzdG9vZCBjb3JyZWN0LCB5b3UgcHJvZHVj
ZSBpbnRlcmxhY2VkIGlzIG9ubHkgcHJvZHVjZQ0KPiA+ID4gPiBmb3IgbGluZWFyIE5WMTIsIGZv
ciB0aWxlZCB0aGUgZmllbGRzIGFyZSBvdXRwdXRlZCBzZXBlcmF0ZWQgaW4NCj4gPiA+ID4gdGhl
aXIgcmVzcGVjdGl2ZSB2NGwyX2J1ZmZlci4gTm90ZSBzdXJlIHdoZXJlIHlldCwgYnV0IHRoZSBW
NEwyDQo+ID4gPiA+IHNwZWMgcmVxdWlyZXMgeW91IHRvIHBhaXIgdGhlIGZpZWxkcyBieSB1c2lu
ZyB0aGUgc2FtZSBzZXFfbnVtIG9uIGJvdGguDQo+ID4gPg0KPiA+ID4gVGhlIGFtcGhpb24gdnB1
IHdpbGwgc3RvcmUgdGhlIHR3byBmaWVsZHMgaW50byBvbmUgdjRsMl9idWYsIFNvIEknbGwNCj4g
PiA+IGNoYW5nZSBWNEwyX0ZJRUxEX0lOVEVSTEFDRUQgdG8gVjRMMl9GSUVMRF9TRVFfVEINCj4g
PiA+DQo+ID4NCj4gPiBIaSBOaWNvbGFzLA0KPiA+ICAgICBTZWVtcyBnc3RyZWFtZXIgZG9lc24n
dCBzdXBwb3J0IFY0TDJfRklFTERfU0VRX1RCIHlldC4NCj4gPg0KPiA+ICAgc3dpdGNoIChmbXQu
Zm10LnBpeC5maWVsZCkgew0KPiA+ICAgICBjYXNlIFY0TDJfRklFTERfQU5ZOg0KPiA+ICAgICBj
YXNlIFY0TDJfRklFTERfTk9ORToNCj4gPiAgICAgICBpbnRlcmxhY2VfbW9kZSA9IEdTVF9WSURF
T19JTlRFUkxBQ0VfTU9ERV9QUk9HUkVTU0lWRTsNCj4gPiAgICAgICBicmVhazsNCj4gPiAgICAg
Y2FzZSBWNEwyX0ZJRUxEX0lOVEVSTEFDRUQ6DQo+ID4gICAgIGNhc2UgVjRMMl9GSUVMRF9JTlRF
UkxBQ0VEX1RCOg0KPiA+ICAgICBjYXNlIFY0TDJfRklFTERfSU5URVJMQUNFRF9CVDoNCj4gPiAg
ICAgICBpbnRlcmxhY2VfbW9kZSA9IEdTVF9WSURFT19JTlRFUkxBQ0VfTU9ERV9JTlRFUkxFQVZF
RDsNCj4gPiAgICAgICBicmVhazsNCj4gPiAgICAgY2FzZSBWNEwyX0ZJRUxEX0FMVEVSTkFURToN
Cj4gPiAgICAgICBpbnRlcmxhY2VfbW9kZSA9IEdTVF9WSURFT19JTlRFUkxBQ0VfTU9ERV9BTFRF
Uk5BVEU7DQo+ID4gICAgICAgYnJlYWs7DQo+ID4gICAgIGRlZmF1bHQ6DQo+ID4gICAgICAgZ290
byB1bnN1cHBvcnRlZF9maWVsZDsNCj4gPiAgIH0NCj4gDQo+IFRoaXMgaXMgY29ycmVjdCwgSSBo
YWQgbmV2ZXIgaGFkIHRoZSBjaGFuY2UgdG8gaW1wbGVtZW50IGl0LiBTbyBmYXIgSSBvbmx5IGtu
b3cNCj4gSU1YNiBjYW1lcmEgcGlwZWxpbmUgcHJvZHVjaW5nIHRoYXQsIGJ1dCByYXJlbHkgdXNl
ZCBpbiBwcmFjdGljZS4gV2hhdA0KPiBtYXR0ZXJzIGhlcmUgaXMgdGhhdCB5b3VyIGRyaXZlciBk
b2VzIHJlcG9ydCB0aGUgcmlnaHQgaW5mb3JtYXRpb24gc28gdGhhdA0KPiB1c2Vyc3BhY2UgZG9u
J3QgZ2V0IGZvb2xlZCBpbnRvIHRoaW5raW5nIGl0J3MgaW50ZXJsZWF2ZWQuDQo+IA0KT0ssIHRo
ZW4gbm8gcHJvYmxlbS4NCg0KPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gKyAgICAgaWYgKHZkZWMt
PmNvZGVjX2luZm8uY29sb3JfcHJpbWFyaWVzID09DQo+ID4gPiBWNEwyX0NPTE9SU1BBQ0VfREVG
QVVMVCkNCj4gPiA+ID4gPiArICAgICAgICAgICAgIHZkZWMtPmNvZGVjX2luZm8uY29sb3JfcHJp
bWFyaWVzID0NCj4gPiA+ID4gVjRMMl9DT0xPUlNQQUNFX1JFQzcwOTsNCj4gPiA+ID4gPiArICAg
ICBpZiAodmRlYy0+Y29kZWNfaW5mby50cmFuc2Zlcl9jaGFycyA9PQ0KPiBWNEwyX1hGRVJfRlVO
Q19ERUZBVUxUKQ0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgdmRlYy0+Y29kZWNfaW5mby50cmFu
c2Zlcl9jaGFycyA9DQo+IFY0TDJfWEZFUl9GVU5DXzcwOTsNCj4gPiA+ID4gPiArICAgICBpZiAo
dmRlYy0+Y29kZWNfaW5mby5tYXRyaXhfY29lZmZzID09DQo+IFY0TDJfWUNCQ1JfRU5DX0RFRkFV
TFQpDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICB2ZGVjLT5jb2RlY19pbmZvLm1hdHJpeF9jb2Vm
ZnMgPQ0KPiBWNEwyX1lDQkNSX0VOQ183MDk7DQo+ID4gPiA+ID4gKyAgICAgaWYgKHZkZWMtPmNv
ZGVjX2luZm8uZnVsbF9yYW5nZSA9PQ0KPiBWNEwyX1FVQU5USVpBVElPTl9ERUZBVUxUKQ0KPiA+
ID4gPiA+ICsgICAgICAgICAgICAgdmRlYy0+Y29kZWNfaW5mby5mdWxsX3JhbmdlID0NCj4gPiA+
ID4gVjRMMl9RVUFOVElaQVRJT05fTElNX1JBTkdFOw0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4g
Kw0KDQo=
