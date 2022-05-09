Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7223B51FB1D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiEILRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiEILRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:17:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9B51B1F5E;
        Mon,  9 May 2022 04:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez6wMVfA3cddNk3S0gLBesngFVK8FMgGc7w6PPDs33/A8FR2SJBUZQWZOFIdIeqJDPECQHZjMcMbD4Ex+DUpLtdbHY4oVliMbss1QAZKZEPkbOuO+HvEvPMTdzhbQdz/CMfSd0t2G+/+SpumCFpfVSlslYfaLf57JHVJp4G0OXJZXcjFUUaLvLilzj3XQ30lo17tAMs/cuMhF9H+q3auXECttPKF3guPjM+Fc8MntH4NE8y2D88zMk/M/hPr2rdEboXKLxnKWLicm6hEiX3tG7y2/Gk1iT5pSP5fxeyvx78I0Co/dIecv7HBq5NJibhRT8V/73DGjM+H4rxfjif/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo85RRCKO1H5CsFkfUexaW3G+F449LY4kZPqJiIj/i0=;
 b=jJCkX0Yh5XDP35350peW4thHtZk9sdMtasLPB7v9/U9sO3k/WgJTds4+7U9gHr+b70EJugvQeOVmO1mcA66aioQKlsyaym+NLSOzU3/4RoejmITXMrSccouAThKEeeKkFqrptl0ffEIS63zmwtDtnt5arWegy2gRdvyQT7cjEc2PFjrhzFC2igsXIqUiqJsXBSmTH+OMwfRW2AmP/3RXUImJtEq27LzHkyPbwV8JfIsth32d19xb3qG4YiQoEohNEDXZ+QWs83xsy0MpZVudsLezw5MFBxlyxstqOpP1jYfcwqp4hDhZy+Lj6JFl4CtRMgEwEukZjl7LLtYuxd1byA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo85RRCKO1H5CsFkfUexaW3G+F449LY4kZPqJiIj/i0=;
 b=TL8bZKsC+KgvpRAL8zGBg7jxy6G+DvuLYGl05ko5nTfYVCDWS+FRg3HAwDgE20+FAVEcYj4Pe0DIQhu0uUbtKcu/C0OW9ZAcNINnKcxMi41WrTjjhL4oYqV7SQoqJOpEkdy301ikpP6QyE4XHQxjshT9GUtkp/ZmBaGFzbvRZag=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by VI1PR04MB6093.eurprd04.prod.outlook.com (2603:10a6:803:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 11:12:55 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 11:12:55 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Jesse Taube <mr.bossman075@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Abel Vesa <abel.vesa@nxp.com>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Leo Li <leoyang.li@nxp.com>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "clin@suse.com" <clin@suse.com>,
        "giulio.benetti@benettiengineering.com" 
        <giulio.benetti@benettiengineering.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v2 12/15] pinctrl: freescale: Add i.MXRT1170 pinctrl
 driver support
Thread-Topic: [PATCH v2 12/15] pinctrl: freescale: Add i.MXRT1170 pinctrl
 driver support
Thread-Index: AQHYW0nHOdkOOqoUhUqbdwP3Ify+eK0Wcz7g
Date:   Mon, 9 May 2022 11:12:55 +0000
Message-ID: <DB9PR04MB84770B71ECC558297AFD2FC780C69@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
 <20220428214838.1040278-13-Mr.Bossman075@gmail.com>
In-Reply-To: <20220428214838.1040278-13-Mr.Bossman075@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fd866db-3fca-4937-a837-08da31acddc6
x-ms-traffictypediagnostic: VI1PR04MB6093:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB609324C4755DD691C6AA69A480C69@VI1PR04MB6093.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OaRqp4Uch5+x1zzDiqDyiL6BwjhfJeT7WzhTjDe3pkhrL9ggTivYWVPF9vMzF2vvhcYona73bSjFhxVe62KwWUbi57Nk4e+BGwKiZWUN1ktVM8AmHBxWF2B0m96lwCdQsS0wC8LxLHAQn/Q0ygePBW1zq3B67vAS59S5ixgnIwWlKvV2TN/kDd+7qaYXriAZwHF6V4Sz/GJevGXLSM2TIruDEzh0FNsxAYNq4cfLC5iNgQSaOeckBgUWfC6Z4zWICmrlP9zYwaCTtZubk9B/4xL9jT3UY4hd+KP7zI2IqtC1UoR0sZOApWbUstLYGt72g7qwa6Cs0yt/4AncVprk64t+mv/mZj7YP1EKN1SpSoEJ1W3WEOWkngjPStB7jjsofaWKhu11Fh9eKig2pZ7U60GBICgp9Hypwr6psJiuBIO5EREYp/ZM05JisBRtyif4CXMYlLdFWb3ilvVuvN0Z93IXhak6WUZMWZO/TJ9/Bik8KREvLk8cIkIE9CZuPnBRIax0cNtM2rdCWo3BSImT8OTA3SC1gYSJMFyjI7v/YurzVUiXTbliI5ghYYs2UYNSLyRYMUTPqshLQxT67OjJI/n/JVV0yyFE+HEg5ltkK/ijcRcvXSkIwTnbpNxAP11l/g1oPKBt9gZtqWOgJKcw+6TD8/XuT/TaOTY/arkNExNQP1/ShgbiLNoP4/PDKBy8myQGRhKoHXt4kvhN9uv//g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(71200400001)(6506007)(6636002)(7696005)(86362001)(54906003)(8936002)(33656002)(44832011)(52536014)(7416002)(4744005)(316002)(55016003)(508600001)(5660300002)(122000001)(38070700005)(38100700002)(2906002)(26005)(9686003)(66556008)(76116006)(66946007)(66446008)(64756008)(66476007)(110136005)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enVMMVI5MzNlYmlIY3JpR0Z4S1NBclJwd1dEUjZxNWtMc2NibzIrWkQ5TDRv?=
 =?utf-8?B?dTVmalcrU0U3Y0hWVW9yZktFV2JrSTJERjB2MitKZGJZYW16UW5OdVlKZTkv?=
 =?utf-8?B?ZU0zUkhPbXIrV25qeDN1bk9BLzc0Wit5QVQyRWFSdDZTZ1JiRDRuUFo0ZXpU?=
 =?utf-8?B?R0lobnQzMnlGVlZwTGx1Sks4WGhvQXhwNWlWYVZqWkFWdks4YXZYNXAwMUdR?=
 =?utf-8?B?bHdUdlppWW81dnZvSU1ySVJYYm5LcERkaUxoMDRlVVZha2dOSTI1M2ovZ1dm?=
 =?utf-8?B?RzJ0c1lrZUg5K0NsYW5xcjI5RSszY0pvUVp4aUlsWWhyUjRUYUpma2dnMjAy?=
 =?utf-8?B?MTJWcWJpUTAzSUFZN1luaDNxVG5NU2dQaWJnT3NpckV2Mko0c00vN3c0ZFp3?=
 =?utf-8?B?VEtZWSt5Sm82em9lM3VySFVZWVRIeDYrV1ZsZDRLNjBvS0Y4OXRVY2JJQk0r?=
 =?utf-8?B?K1pNdzNoa0JGV2IyQ0o1ZEZwSmwwYjJoVmlwQUVJdWFDS0pHVHUxcWlIcGJH?=
 =?utf-8?B?T3NnNXhCTmdkbFJtaGN1RkxtSWwwU1BmVUhOV25xSjBYYitJcUZlVE0yblN0?=
 =?utf-8?B?NVRIY3Vtcnp6L2g5ZkdIUDZpSytud0FRNFNZeVhwbEoxNUVscnhSR2JNTUFj?=
 =?utf-8?B?R1UzQ1h2REhXRFRJMWxYUnFoTm5ha0U2VmszZTdEK2JuUEpybmRuaDJoYTdE?=
 =?utf-8?B?alNNUHN0QzUvbFF5V1ZWSWZaY2U0ZHNNUVk5VEgxekkwWXdDenRwMDhaeGxk?=
 =?utf-8?B?TURvZTF5MndYNkI2NjdocDlRZzFlbzR2ZDVpZy9UUEZLZThETWZHRnlpSVFS?=
 =?utf-8?B?RFZEbDNPbEhscXRCY2FUNEQrSDlsc0xtR2ExNGR0bWg2T3RqSWdFSmcxU3JF?=
 =?utf-8?B?QUZTTG5CZ3hDaVRjUXVpZXNTTzgvVzdyaERPa0hyNXoxNGp6dnFoNFdDSk1h?=
 =?utf-8?B?MWNiZHZmNTZPaGF5MHJBTkVKMVh3NEN2MmxyMWpReTVJKzZDQXFUb3ZHMWZ0?=
 =?utf-8?B?YWNVRUVPTDZaSkhDOWN5aVJaSmJpQXFwRTR3Ukl4NVByY3NyRWxBY2NMUGlJ?=
 =?utf-8?B?OVZ6QVpEMFA5NWxBN2Jkb2tnZ1FpL3pGTWZCektIRWp5ZE84NVhIaHVvVWhL?=
 =?utf-8?B?NUU2OXNXa0FKYmZLYTUwYVBHSWRqaW94TUpIdUJkYWdIeEF2QUQzcEVxUmZU?=
 =?utf-8?B?SEc1YXBNcUlkaEFYbUJpNDB5MDh5R3ZiZ2ZneHpmMmd1aUpFY0VXSHkxY0lP?=
 =?utf-8?B?ZWFWdTN1bEhBU1U3S3hhTktpOWRNSkJ1NmdDdmUyRlE3WlBMbjRlL2c0bnRj?=
 =?utf-8?B?T1V2bGFPYWhaNDlJZEVRRmdYUXNNdzZkR2NSaExpWFhPSEFOczRaYmFPMWJR?=
 =?utf-8?B?NE9Ec1ZVV2h1VWxNek5hcnlUV2lKQmlJT2xEQXlMN1FaT1dVMlNmMm9hRm5y?=
 =?utf-8?B?SzZxM2huM3QxS3dYZll5bVM4NFl6aGZHekwrSEhpOFc5TFlaT1BXN2dWL2JG?=
 =?utf-8?B?TWxNTHYyUnJiSnlORUZqZGpEdzB6WFZLZ0dHVkluWjJpQ0ZVblQvWGNGb3lt?=
 =?utf-8?B?bkdJNHlBNHl2OG1WYWhUSHBSNUZxVzBNODNjaHlKU25peDZ3SkE2MUNwSnZH?=
 =?utf-8?B?alVFWFNxY3BIa1ZqUzB6SDYvZjBlUTg5VjVQbXVadDd2aHhrS1ozUlR0TUFu?=
 =?utf-8?B?c05LTWpPTzB4YmFVd0RFSjZoeTcxZkhPM1pTT04xb2hsSk01SXJxSmozV05a?=
 =?utf-8?B?T3FFWldxWUdETDB5VW14ZDFXUmhBV3pmQ3IzSmdFN2huaUI4NmI0ZWFqMEV3?=
 =?utf-8?B?bG9kMHlCOUJPeDNxYTQwaFVobUtnWk9XYWFVUGRGMlpRblR3UnpaK0pFZ29S?=
 =?utf-8?B?S0hIbUVQYTh1RTFtRDQvQTNHbDlFSWJIUElEUFpLUkw1OFQ1SUZucWZnWFlu?=
 =?utf-8?B?d0haTGFENytnNXRvaUttVUVOcS83cVNZcW1ZeDJMbWJBQS9HZ0M5L3VqM3RW?=
 =?utf-8?B?ZU5aeWZMYk9KOTg3VWlsMnRORklQYWJENDM1anZIeEpXNFN1UEZvOXVYbk44?=
 =?utf-8?B?NExIUEFDWjF1U3F5SEhsR0o2eFQ3djlBWnZqeUFFYXhld3EzS1pnaUt4elpD?=
 =?utf-8?B?cmlMakZ5emlOS2xsTEcyZDg1ODRIN3N0Mlo0UUlBOWZLK0pQMGdVRjN3WnVI?=
 =?utf-8?B?aW1kNCt6ZlgxaFV4VUdqMDUyVFN1QkZwZ0ZMaUgrdjJwWERhNmpIOENTU3RQ?=
 =?utf-8?B?TTZBeDRwQ25LQjA4YXYvSEVrb2RnQVg5R0lVbnZFN2dmN05LK1ZrRGFiYnMw?=
 =?utf-8?B?Zk8wZG9yRFFZWGZZRFZsbUdQek9taURTTDNJekJ4amdYRHF0aU1rZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd866db-3fca-4937-a837-08da31acddc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 11:12:55.0953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9TYUDo6/JkEUIIc4wRUfxHD+ergDE9yNrvd5OOwdEpjAuNl8E8jfVKjKVwnjFvTARXDIueXa+gqkD4UjDv0Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKZXNzZSBUYXViZSA8bXIuYm9zc21hbjA3NUBnbWFpbC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgQXByaWwgMjksIDIwMjIgNTo0OSBBTQ0KPiANCj4gQWRkIHRoZSBwaW5jdHJsIGRyaXZl
ciBzdXBwb3J0IGZvciBpLk1YUlQxMTcwLg0KPiANCj4gQ2M6IEdpdWxpbyBCZW5ldHRpIDxnaXVs
aW8uYmVuZXR0aUBiZW5ldHRpZW5naW5lZXJpbmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZXNz
ZSBUYXViZSA8TXIuQm9zc21hbjA3NUBnbWFpbC5jb20+DQo+IC0tLQ0KPiBWMSAtPiBWMjoNCj4g
IC0gTm90aGluZyBkb25lDQo+IC0tLQ0KPiAgZHJpdmVycy9waW5jdHJsL2ZyZWVzY2FsZS9LY29u
ZmlnICAgICAgICAgICAgIHwgICA3ICsNCj4gIGRyaXZlcnMvcGluY3RybC9mcmVlc2NhbGUvTWFr
ZWZpbGUgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3BpbmN0cmwvZnJlZXNjYWxlL3Bp
bmN0cmwtaW14cnQxMTcwLmMgfCAzNDkgKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNo
YW5nZWQsIDM1NyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9w
aW5jdHJsL2ZyZWVzY2FsZS9waW5jdHJsLWlteHJ0MTE3MC5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9waW5jdHJsL2ZyZWVzY2FsZS9LY29uZmlnIGIvZHJpdmVycy9waW5jdHJsL2ZyZWVz
Y2FsZS9LY29uZmlnDQo+IGluZGV4IDIxZmEyMWM2NTQ3Yi4uMTVhZjNkODBlMTE5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvZnJlZXNjYWxlL0tjb25maWcNCj4gKysrIGIvZHJpdmVy
cy9waW5jdHJsL2ZyZWVzY2FsZS9LY29uZmlnDQo+IEBAIC0xOTIsMyArMTkyLDEwIEBAIGNvbmZp
ZyBQSU5DVFJMX0lNWDIzICBjb25maWcgUElOQ1RSTF9JTVgyOA0KPiAgCWJvb2wNCj4gIAlzZWxl
Y3QgUElOQ1RSTF9NWFMNCj4gKw0KPiArY29uZmlnIFBJTkNUUkxfSU1YUlQxMTcwDQo+ICsJYm9v
bCAiSU1YUlQxMTcwIHBpbmN0cmwgZHJpdmVyIg0KPiArCWRlcGVuZHMgb24gQVJDSF9NWEMNCg0K
U2hvdWxkIGl0IGJlIGJldHRlciBTT0NfSU1YUlQ/DQpPdGhlcndpc2U6DQpSZXZpZXdlZC1ieTog
RG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
