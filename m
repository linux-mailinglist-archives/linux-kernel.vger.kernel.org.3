Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391AA50665D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349645AbiDSH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiDSH4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:56:34 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10051.outbound.protection.outlook.com [40.107.1.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332D27B38
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFLBYg4YIszi8b/lJy8ufGduYAs8xMvJQZyyFWEd0EhcQ3ydbjZfcrrhB75roC6mDQTD1k13N9oWULnUR/UaDOLyMvLkrpQ1wRusBdxOVqXKaPE3i7K/kaiqwPa3wV2kyEuGsTekOhzGPf358/E5uEhNO7kklT78EOS5VRWo2YJ5jb3Xk61i3UQPN6g6eHC8ZQ6WppJW7vRiHWvTdW/yBGPppn1LrR6EOACY53m2Pr3cm1DA6P8E0Uy92YCo+Nkf50aYqpjOWAIQLdcDsmc/OdL4DMj9SYJseL00QTbz3N73EIMeaut27Hs+LNJxS5rne435le9bdUaQZqJVvfHhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfUOdSyZTu2W9DJ6lAb5pO3CfYXN5sNgyZaRt1QxuFk=;
 b=Aqbp9o3e7OI50EINdt7lASPpZmY1ed/g5JKAH034SteLx3yh/gMheZiCrovbM9uBrTg6mQR4HmxhXiIa0y+FMF9ZZ/QUjyFvDBmVaUlgcLnOMt/j55TLsK2vyZhPIrs2zDd2II0bsVTx1r3E9vQgoXGjV/wOYl9qyB/TOttlv/BBd6Q26tzS9TCPpQlHCO2/LHjeodc7M3AFZF8zG+epnazE8AZsYpTXRjpcdliRNZfZmT5kZfnyTMVTi9Rfj0zrsB0m0HJE6aMS7hbi7l2F54/ZpgTAzvl+i26ST4ujk7F1nuGo0fnbGz1zlc8eR5nwd/VEIr2bkkiY2eMyTofBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfUOdSyZTu2W9DJ6lAb5pO3CfYXN5sNgyZaRt1QxuFk=;
 b=CKtCYDGaQDcaIphe4ODvAIW+z6Xz0u36UyR/8uE1nWvDrPjmvK2UZ9DeSxuCcN31zuyGH+34OHj1vQx5Kv+bRjVBOJTm+a3jLh4NxXY5frZsJ0sTuRQYjfl4XbW2mpsmtaxeM9zgtTyxAsTTfPkByXFmf2Qw2GBbKHPNTwb2+P4=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by VI1PR04MB5952.eurprd04.prod.outlook.com (2603:10a6:803:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 07:53:50 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 07:53:50 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH] extcon: ptn5150: add usb role class support
Thread-Topic: [PATCH] extcon: ptn5150: add usb role class support
Thread-Index: AQHYSZwctDdaLIQeZ06BuvStsTM0tqziq1kAgAAXF/CAFC5VkA==
Date:   Tue, 19 Apr 2022 07:53:50 +0000
Message-ID: <VI1PR04MB4333585DED292C3AC920B21E89F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
 <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ef11c42-cc8f-456f-d184-08da21d9bdce
x-ms-traffictypediagnostic: VI1PR04MB5952:EE_
x-microsoft-antispam-prvs: <VI1PR04MB5952D315D9D939A9A8A68A3589F29@VI1PR04MB5952.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3bIsiIps0pOGwffiSyMo+cxDz8ITu2lEhzxjOWLIIdIBfSLjv/c34Re+fTx45GtPZ1s91IRYnkafJ8Ugc9rVe9G9UEf3FHaB07u96NT7VFe6wKE85+bPZhiyGVd4IAV9DSTIrV+4iL36fXDvSsGTH+uc9CzSh04DbP4EgcCv6tBdoXezm9DGOWwJwYHRyrJ6FtP2WUchOq7HaMNgt0ce/u/aH2HETdZ88HReDUldcXDeO/fX+eCBR44WKA8QG/Rw9OMUizljsDAVxjMQDo8WBrCyWcsjH2Ymv1X2x22hA5G0ho+ugCsBdy9MQz0iXGniGKvLRtslkr+w8FQwPTF6CViqok/rBgBaQ15IbEaG3U6ufazMNKTo/VUYrNhufaxAu40Q9i/TKinFnMfyAS3qGZdFPutUayCxQwLZEekPcEM7Eqo2o3aT1l16uyjIdUwm3woAuUV4SlhIkGdQMLT228j7f2lcY1KIyOPOa7FJsKYpmk1zAJu4KvYa2I1A06moW4P6eJRP5xRpNP1Hd1qDii/r5NCMreKLowW/2Wb6wtEBXnlcqp/Taf5COftCB4EFrnenh/7mZjOtKSxioUa9p9CZxKleLiriZtX0eCMzqmIFjRU8cZZ3mHJ4oq9GvSRx8CQpSXUslVNnmS3x112IERNVQrxT4Iq17WpK5OpUwqBrETjboVFomlAvUD+OTg+vuKc+2psOZQe/hD0fpkzNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(38070700005)(44832011)(5660300002)(55016003)(4326008)(83380400001)(2906002)(122000001)(71200400001)(7696005)(9686003)(52536014)(53546011)(508600001)(26005)(8676002)(186003)(38100700002)(33656002)(64756008)(66556008)(66446008)(316002)(76116006)(54906003)(66476007)(86362001)(110136005)(66946007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzN0QkpaSElhLytEZ1ZiZC9GdmxjWU1WTUU0anUyZEorbDBvVXM3ZFhLWFRj?=
 =?utf-8?B?cnRaek1MU20yZEkyTWtBamdnZktyUURQMlMrQzFmdEdIZkJuaHRBRGxrZ2Jk?=
 =?utf-8?B?NERxRnc4VFZtUjd0K1RVak5KUlRGOHhQMFRtcFhCR3FWODU1NHlrUWxNV1FC?=
 =?utf-8?B?RkRmWHNneWdMeXZsRCszbWJOclgxRS9VeGNqMmdPajNYZk5oWS82djlSUG9V?=
 =?utf-8?B?N0Z4ZkRSS3dZNEJYNVhZOWkvdVV2UmNtckhQTzJ5UU5acVdtTWNRNk96RFVQ?=
 =?utf-8?B?aithaFJwa29CREw3SU8xN1ExcGlEUEtlUGFWaHY5YzZ5VFhHRzFGMjJ2Wi9R?=
 =?utf-8?B?QlN6MlhpZ01hUEFiRjJyd2N5SVZXa21RVnEwcWpFVjZReVozRUxkSEVkWFZo?=
 =?utf-8?B?ay84ZTVoakhvdWVnc2h0enRZckpWZmpoVE8zVDBROE53eXRVc1ZMZDQvQSs3?=
 =?utf-8?B?cmp1STF3NytjN1owZ2NoeVhybEhNV09uQU5DSi9mUXJ1WGtVSi9qbWN1NUU0?=
 =?utf-8?B?WDg4aTNpdFBpOW4yUUIxSWM0T3RHZ2ZBRTlMcTRUVjBiU2FtZVhxRzltM0s4?=
 =?utf-8?B?UlV0MW9nSHRwOXRkUlhuclBtUDJPejFKZjhtaTRsTStGdWVaREZNZnR1WUJS?=
 =?utf-8?B?YldjZHdNTVBzUWNMWEliUENuUFZoQWxqV2FuOGlIQ2VyMkxsYTZXY1l4OWNr?=
 =?utf-8?B?WHFzNmNSdmNUajVhN2JzdFpGWFFQMkt1RHg1cUhkRWl0bGNOUGwrRmRTamIv?=
 =?utf-8?B?bzZZVitxUEdVeFk1MUd4STZEb1YrT0ZjU2pVdXJmQVQ4Y1YzSXArUVFVZEF5?=
 =?utf-8?B?MkV0UStuNVFySEZ5alF2VVRJYTZzNFVDN0o5R3VrWWFaSFFidStaRUlOTHNM?=
 =?utf-8?B?YkQreS9YelRsWFh2ZFhjK1h6aFJPdUdBQ2cxeUZOZHh0MFovd2l5V3M2NWtk?=
 =?utf-8?B?dU9NZVJvektUcEgxeHMrV3pSdkZ5MTJqMGRyN0I0bldXYTVxRkNhQm15blJa?=
 =?utf-8?B?MWhGTkNMakNIMnpFRzQ1S2ZpTTFtWkFoYjVjRm5PWlhwaVdISzdtS3Q3ekp4?=
 =?utf-8?B?d002alArcHFDRjY4UzVPcG1zNnhDRHkrNlV0TFBRZ01RbUFXaERZaUZnem9s?=
 =?utf-8?B?b0pkRnUxMk9lNUVONkszMnJNOGpvekY3R2R0dTJ2WVJUV05GSG4xb1FUUGRh?=
 =?utf-8?B?TzBEQm9idy9ablFWejVBU2tOT09jSkhCY1MwUUN1MTJvcC80Qm1YWVpSb3JT?=
 =?utf-8?B?Q0pyUHI2Ny9CTkFsbmVYK0NtMFUzM21VN2xrZEtzclFhaE56VDJqUWlHV3dq?=
 =?utf-8?B?enI5L2V1SWxhUFFFY0ZtZ2Jmb1RaQkRMVzlCcExVSmhqM2tTamZzUUMwbzFO?=
 =?utf-8?B?VmRGeUcyellRTldhR21kZXA4WkQ0Y01kSmJRZlpXNTN1YnhmTEM3eHlKSGRv?=
 =?utf-8?B?QVpub3JqRzM3bkJiQjRMQ3V6Y2VvRWhzV2pSenJrcmJOL1pwT2dTOEpWc2kw?=
 =?utf-8?B?NkYzdWZKU1JMQUJPUkFVNkN3ZGJscHZKQ05LOTI0emsvU2Q4NnJRWjhBaXFE?=
 =?utf-8?B?eWZOUkZoZmxOQTlWaTJZNlhGWVJTem0xRVRjL0QraG9mV1VCNFJIRm9WTWpm?=
 =?utf-8?B?Rk1vRWRuU1dXdW9sNXJOemxaUDZzL2RLanRFaWN3dDdnTm5LSENzeEFPQk10?=
 =?utf-8?B?bDhKNHdIRG1ORWdMK20vc200N2NMU2FudWxMV1N2MlBzTk5XNTNvcmc1SjdQ?=
 =?utf-8?B?VDE4ZXRxMTZodHFLSlprNE5kUDIzbE9Od2Z1alZWRlZlbHpKamFoVUFqa3hr?=
 =?utf-8?B?bC82c1pSR0RFYVJmdnA4ZTFFY05ER3lrSzV5RmxDNHhPUXJ3Y3l0QWN0cjZI?=
 =?utf-8?B?NTllODdZb2ZLTlVCcTFhSldSODlyRkdiL2xtbzFUTXNEVGtBT0VMMUNDS2ta?=
 =?utf-8?B?R2pRdFNBTThrNi9CcUxLaGsvN0RUdkJ5Q0JkaW42OENZTEw3SjgyTVluTEpH?=
 =?utf-8?B?eEYrRHJrd05YV2g1eWljVjN4WHlLbDZYZVF6QUZuc1JmZllMQ0h4bk1wSkRL?=
 =?utf-8?B?NUsxbkVKNlQwTzJ0cjc0OWRrQUpQTGFwRmFCNFpIbjdKMXdybmRUOVluOUI1?=
 =?utf-8?B?eFptV1V5MVliS3drQi9IZ0xNRGNUblN3WHdmOGVaNUNMdThOQ1YzUzA4UmVF?=
 =?utf-8?B?T3hOM0VXRmZWTDZ4WjZ5ZHc4NFovVEg1dlZqTkVEYTl4d1VCMS9qRS81N1dv?=
 =?utf-8?B?OWFUODZOMTg1S0w4ZXBSZ2dyNDBqbGE0Vmd1U2dSbU1FRFBCYjA5NWgydVpM?=
 =?utf-8?Q?E6+vfPwHC1vOLZ97sh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef11c42-cc8f-456f-d184-08da21d9bdce
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 07:53:50.1633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2L2uDsjnJx6Y/kzFHA32xTSeiM7F5AgVpO0uDJd98hTkS1L1TgKkrV5eym2PnWN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVuIExpDQo+IFNlbnQ6
IFdlZG5lc2RheSwgQXByaWwgNiwgMjAyMiA3OjQ5IFBNDQo+IFRvOiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+Ow0KPiBteXVuZ2pvby5oYW1Ac2Ft
c3VuZy5jb207IGN3MDAuY2hvaUBzYW1zdW5nLmNvbQ0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBYdSBZYW5nDQo+IDx4dS55
YW5nXzJAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZXh0Y29uOiBwdG41MTUwOiBh
ZGQgdXNiIHJvbGUgY2xhc3Mgc3VwcG9ydA0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtv
emxvd3NraUBsaW5hcm8ub3JnPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgNiwgMjAyMiA2
OjE2IFBNDQo+ID4gVG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+OyBteXVuZ2pvby5oYW1Ac2Ft
c3VuZy5jb207DQo+ID4gY3cwMC5jaG9pQHNhbXN1bmcuY29tDQo+ID4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgWHUgWWFuZw0K
PiA+IDx4dS55YW5nXzJAbnhwLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBleHRjb246
IHB0bjUxNTA6IGFkZCB1c2Igcm9sZSBjbGFzcyBzdXBwb3J0DQo+ID4NCj4gPiBPbiAwNi8wNC8y
MDIyIDExOjQyLCBMaSBKdW4gd3JvdGU6DQo+ID4gPiBBZGQgc3VwcG9ydCBvZiB1c2Igcm9sZSBj
bGFzcyBjb25zdW1lciB0byBkbyByb2xlIHN3aXRjaC4NCj4gPg0KPiA+IFBsZWFzZSBtZW50aW9u
IGFsc28gd2h5IHlvdSBhcmUgZG9pbmcgdGhpcy4NCj4gDQo+IFdpbGwgaW1wcm92ZSBpbiB2Mi4N
Cj4gDQo+ID4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBKdW4gPGp1bi5saUBueHAu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9leHRjb24vS2NvbmZpZyAgICAgICAgICB8
ICAxICsNCj4gPiA+ICBkcml2ZXJzL2V4dGNvbi9leHRjb24tcHRuNTE1MC5jIHwgMzkNCj4gPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgNDAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2V4
dGNvbi9LY29uZmlnIGIvZHJpdmVycy9leHRjb24vS2NvbmZpZyBpbmRleA0KPiA+ID4gMGQ0MmU0
OTEwNWRkLi45ODI4YWRlNzg3YTggMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2V4dGNvbi9L
Y29uZmlnDQo+ID4gPiArKysgYi9kcml2ZXJzL2V4dGNvbi9LY29uZmlnDQo+ID4gPiBAQCAtMTMy
LDYgKzEzMiw3IEBAIGNvbmZpZyBFWFRDT05fUFRONTE1MA0KPiA+ID4gIAl0cmlzdGF0ZSAiTlhQ
IFBUTjUxNTAgQ0MgTE9HSUMgVVNCIEVYVENPTiBzdXBwb3J0Ig0KPiA+ID4gIAlkZXBlbmRzIG9u
IEkyQyAmJiAoR1BJT0xJQiB8fCBDT01QSUxFX1RFU1QpDQo+ID4gPiAgCXNlbGVjdCBSRUdNQVBf
STJDDQo+ID4gPiArCXNlbGVjdCBVU0JfUk9MRV9TV0lUQ0gNCj4gPg0KPiA+IFlvdSBkbyBub3Qg
bmVlZCB0byBzZWxlY3QgaXQuIERyaXZlciB3aWxsIHdvcmsgd2l0aG91dCByb2xlIHN3aXRjaCwN
Cj4gPiB3b24ndCBpdD8gSWYgaXQgd29ya3MsIHRoZW4gcHJvYmFibHkgaXQgc2hvdWxkIGJlIGp1
c3QgaW1wbHkuDQo+IA0KPiBPa2F5LCB1c2Igcm9sZSBjbGFzcyBwcm92aWRlciBzaG91bGQgZW5h
YmxlIHRoaXMgZm9yIG1lLCB3aWxsIGRyb3AgaXQuDQoNCkEgc2Vjb25kIGNoZWNrIG9uIHRoaXMg
YW5kIEkgdGhpbmsgSSBzdGlsbCBuZWVkIHRoaXMsIHRoZXJlDQptYXliZSBzb21lIHVzYiBjb250
cm9sbGVyIGRyaXZlciB3aXRob3V0IHVzYiByb2xlIHN3aXRjaA0KKyBwdG41MTUwIHZpYSBleHRj
b24sIHNvIG5vIG5lZWQgVVNCX1JPTEVfU1dJVENILCBJIG5lZWQNCnNlbGVjdCBpdCB0byBhdm9p
ZCBidWlsZCBicmVhay4NCg0KTGkgSnVuDQo=
