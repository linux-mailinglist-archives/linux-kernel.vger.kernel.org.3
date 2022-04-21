Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42967509B91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387233AbiDUJEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383050AbiDUJD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:03:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70088.outbound.protection.outlook.com [40.107.7.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D31D0FA;
        Thu, 21 Apr 2022 02:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBs9hk9RfEoj42GjbaRbiSLg7ou8+xbe80bYetBjmcWo/6kY4jeD9OdgBroTeL/IX0Lzwi9vhJoUYg96d6tUfjBqQU/yRrxdquoGoO8ZX1WIHTnR0sfn69LUpO+chyyCOv18c7bMIo6rDdM5IkG4OHskRZ3b3VxAFU+A0rlVNw6WCbf1BqC0MhKndiWzEqx8K7WNg81vQrOZJeYAeCw2wMFMmHQcVFFro68BuBKba9WEq1Ib3vYP1CDWYctxX3XfKFsoGXpWaqT4deIOaJdJognJYn3aN1suInBU9kZJcSbQWP5uwFO70ROcbHaMzskwi7PJuFdblRMfsiSM7VJPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3qE2VOTZfvdi2oaV+PEVMbiKRl3kNur4oodmbRdAPM=;
 b=ZEQFCVWws+HdUMP4Hjm7DatX3ybCJubg0BWfN4LvssHZZGPvxVCMow0hXf6oSSRxs61AshPLJdOqUGXPwMHVdy/3jAyzHroMoVCtn2z6g6HTN2c3IVgdS2NlZlQjsyxG5Xh3vfdb8xglqP9zSPm5vfIDfTNRnqJxTC+IPLf8gcjjAIuNE5m17ZHCpojtk07rifR710cwLPpKWXKbA61RS+XZwaYMOO3Nb0Wuk+r6vWoLKeGoU7q2tatevQ0bk4QP7Bsy1F4B2hsfjFi2kggeeuFS0HzikW1mDnC9kxjb+Z7GOJmXCYR2ry5qTPiY8IQMSsv+muuwAbfXdewbihpY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3qE2VOTZfvdi2oaV+PEVMbiKRl3kNur4oodmbRdAPM=;
 b=ZX9ZOqTh3gAJKLLROHdXcEccSDqriUzTI7EFRbciWykdMA0tbMeVdYcYeKJQPlqLXWr2tR3Z/KHQZ6ELX7rx1mAwHVs54CYuTMQ0CaFKpCDo/kXj2vpEuXGRYo5EREkz1uCjpz+3dM2nw+g3+ond5RbZd/lNehgYNUpBvQn3hFM=
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM6PR04MB4520.eurprd04.prod.outlook.com (2603:10a6:20b:24::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 09:01:04 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 09:01:04 +0000
From:   Jerry Huang <jerry.huang@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/2 v3] dt-bindings: dspi: added for semtech
 sx1301
Thread-Topic: [EXT] Re: [PATCH 1/2 v3] dt-bindings: dspi: added for semtech
 sx1301
Thread-Index: AQHYVGnSQhvhLRlwf06WwedkAAajtKz4qkKAgAFnrfA=
Date:   Thu, 21 Apr 2022 09:01:04 +0000
Message-ID: <VE1PR04MB6477F05096589AB8DE2C0555FEF49@VE1PR04MB6477.eurprd04.prod.outlook.com>
References: <20220420035045.33940-1-jerry.huang@nxp.com>
 <20220420112657.270293-1-michael@walle.cc>
In-Reply-To: <20220420112657.270293-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7c972d5-bf1e-498f-4dff-08da2375775a
x-ms-traffictypediagnostic: AM6PR04MB4520:EE_
x-microsoft-antispam-prvs: <AM6PR04MB4520448D6961F5154DC4A793FEF49@AM6PR04MB4520.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6ZEX5vRN36yLg2gUPZ4jlTLrEbLdUC/5EkySZng2b35esOHdWZnnzSP1HT52qoIw0nGFgDTQrLWE7CTvTkKc5iFXoHtbAjRqdNMOMrM7E6I05u+22rJ/t13o/Xb5PI4kOcWW0nyAdFy6f5fULSNA7pzlSDFSLZ+18sVc+u7Pe1wPNP66ArsyHoBPFyx1D92EnExmVYKPahNZZsOni/D0XL/Bt7k9awRDMxLgYPd4EAxvyKA0cS3wK1Il/+EhAvAzfqQCZ+oS76x8Lm+/75ydPLTgcpCck9lu7/vg7mg4LRIHNNvsERn2iQlZ8/IIkNHaDUnoWE9YfoKXqZB78DZY7zT5FOddQ8DnMpmptctClUzQyXpww0gz8CwDv57m7Kq5yCgMRyH+dszwX+CdmDzJkXygVNpUNoY0kWAPwYHUyfbIKTXH3+64k68k7gHEYicutN42WHw90LcBLFG4QwnBe99yXh1G5ALSQas79KV/xSWCeovOSPcjw5NPqzue1B8oDMV8eUJjOZVKVAZCZQivakUWAx2TaAuf5CoSjvkAGx/shZI5EgN2CCQomlKJXztheoWU3olHnUrI/W/5ieMxEgvaS6he3WoKl1cDbU4V2nsktEqgA/trB5wwwRevD9weKMNA4xj1zDGlaqD+1fWyR0q5xmtPJku+Qyl9UirHv6luAHehYWiTmLsdPwbpG3VExlO8HpkAeYPSs+KEnaRldlhagFrhraKe5mCuU8RbkhMsm4dbd3O6yMLgyPg4wd0CtQ0Uts+3/yRVc8b3toycmsiZTyY/MfjO/Vnu+Q/Oi8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(83380400001)(186003)(38100700002)(76116006)(71200400001)(86362001)(38070700005)(33656002)(44832011)(52536014)(122000001)(8936002)(4326008)(8676002)(26005)(45080400002)(9686003)(53546011)(66556008)(64756008)(66476007)(55016003)(6506007)(316002)(966005)(508600001)(66946007)(66446008)(6916009)(7696005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?U2YzR2xOZUVDOVNtTzhFVmYxR05HYTlUaDZDWk1VR3dCWUhoR2VrYnVwdGpG?=
 =?gb2312?B?THJxMWQ4RDhiVmxMRWx1NktvYmxwbU94UCtTOG1RM2pCamZQcVBGN0lxOFI1?=
 =?gb2312?B?SnpzMVd4ck0raGRCN3IzNTdXamgvZEJUZFhMdzBodVRYbmVHODZ1UWpoT3Uv?=
 =?gb2312?B?dGR1ZmZPMTlTa0FFUGNyM0VMQktnMStDQTRhalhxekVQSjZlWUlrb2w5R1FF?=
 =?gb2312?B?dFErYm54M3Rva0V3MWNrV2JmNFdDRW9BSkZEMmx5YWM4b1ovdExMSnFuUmtU?=
 =?gb2312?B?WG1xdE1hVmJVTDZOVEJSQStCaFZTUVFjMUJ6V1pGSlhlLzlEUGQ2VWhGdmFv?=
 =?gb2312?B?MGxxUjUrNm5mWjV6Q0FJNVBucFpvSnFLdms2anJDYnZaWHYzMmswRDJ6eWVj?=
 =?gb2312?B?cFM4NG1tU3hOcmkrM3ZBdHRSWVA3TTZxbXRBYzFXYjNWL3ZKZStsWU8rTkZN?=
 =?gb2312?B?K2Z6MGErU0VKMHp3bGtTanBPVEVDWlJ5NllDNmlud2FmUFhKcktMVTAwcFZu?=
 =?gb2312?B?L2doSTFBdGl6WjlMOFZoNm8wQ04yVjUwRndNNzRwaTNYREo5end6U3NKY1RB?=
 =?gb2312?B?M2ErWDd3YU1xT0VuOTZrREV6MzE5aDZNUng0b2grZjVEbldTNU9kdVpTN1R0?=
 =?gb2312?B?VjA2ZTdKWkl4L1g3UDhaM2ptbkp1cU5ranhnb2VZT1VRanZtaEc1bzZwUUp4?=
 =?gb2312?B?cUxtbXNuRitxNXBXUEFxczhrQTRuK2VISExyZnpkS2dFS2hOL25Pc3FGL0FM?=
 =?gb2312?B?bkxtTENSaVFneWdSWmhlMEMzQ09YdTJ3M0VKZUkwWHlianh6TnNpc0JJRXFE?=
 =?gb2312?B?ZncxanlLdHBINkJFNldjWDA1LzQ1NWEvZ01adFhCQzJRZDRTSUdvWHZHdnFx?=
 =?gb2312?B?NERjWGNUNUdDREhXZlp2ZFV3Q2hSN09oZS80QjdFUUxVMlFsbUFJN1Q3QzFP?=
 =?gb2312?B?Smg3bWtpa0VJcHp6NnMydEVpVUM3ZkJURmpmeS8zdHVVaVJrREFJb3llY1BU?=
 =?gb2312?B?bEk4MFh5YUk1MzFEVnNUcUlZVzJ6RlpVRUYyRFhORTZjRGY1R2tMakQ4bEdx?=
 =?gb2312?B?RXBMTno4ZVlhTFZEU0VkdnlMYXFFaUZoeWdibi9TQTJOQmV5OTlDZjVGY2k0?=
 =?gb2312?B?bTNwVHYydHpIWEVNR1Z4c1Nuci9CU2F1d2xXcG9ybVRTWHlYRCtPY0hXMHdj?=
 =?gb2312?B?bFo4ZUtZaWZtQkhRZDFrNFBVR0hPRzlTODJLMk5CeFE1SXpZRHdJV2YvYW9I?=
 =?gb2312?B?dGZpdHNyR2tIWFZOdm9Gc0xlQmdmQ3VQS1VLMHE3UjZMZi9KYVlVcWxudWJl?=
 =?gb2312?B?SGt3QVU2ME11Rm0vSGZTYjJDUXFXaE9DUnExNW5FTEYyUXVDeEsrUjR1WmFq?=
 =?gb2312?B?aVNMdlNzVWJtMVMzTXpnZkp4enIrb3JVMXVlbUk4L2xNRUlSSXIrNjJmKzlQ?=
 =?gb2312?B?b3VqMVcrUHJDam9GMzVBOUFudEJkV050QzEzYUdObXA4Z1lJVUZqOXVUby92?=
 =?gb2312?B?QkdwREtVcnBuMUJjeS94SWhPVk1CUVZ2QnBIQ0NqWndPWC9NZkhlcElEdTYy?=
 =?gb2312?B?Z3YwR2J2YzZRZDlDNHRXY3NBQTZDWENIR255aVJnS3pnU3EvYjYyRFJqVWVj?=
 =?gb2312?B?QStRdkUyR2MwcFNwaHE0OHRQUXg1b0RYd29TQWJxckVLMTIwMEJldmFnblZi?=
 =?gb2312?B?dFd6WkxSV1Zic1dkV0tqLzlkQ2kyNnlZdzZNNFF5aGpTamRhSVZWTzBjdWpt?=
 =?gb2312?B?ejduR291SWUrZGExaE5iN2tvaTc4K1RjOVRqRmhWeUdBanNpSTlkOG1wS0Vx?=
 =?gb2312?B?UGpJTGZWMWFWc2VpQkYzV0ZIUXNMaStnaGVzMndWdTVFUGhjRlZobmtDd28y?=
 =?gb2312?B?TkdmdWhFM2pHWnlQc0Z6ajI2VmZTUTZNR2I4ZGtPbm8rTjh4dHg4VVdEbVlv?=
 =?gb2312?B?VndWQWN0S1d2eWliSXYvZzBMNndXQjd1Y0lkcWpTL2tIWmNZcVBUSWNOaDU2?=
 =?gb2312?B?TU9LMVFkcE15Y0diK0ZZOFEzSGp0bEl3NVRMY2RNcWE0NWdtRzdNV2sraGpQ?=
 =?gb2312?B?M2lXWXhUYUpURDFsd1dLVEJ5UlRKMlZUM0ZUQ3NYR0dBSG84bVNScUZQRjBU?=
 =?gb2312?B?aTJJQnpBcWpLS2x4TUNSdEhKanl3Tm5zNktxT0FORy93K1VVcWVqV2lodWov?=
 =?gb2312?B?aWZiVFdUbStaemN0cGpMcXljSGJCRVBwVTBWM3V3UVpqVkltWGlscFhRWEUy?=
 =?gb2312?B?RFhiMXRoQm5HdTF5UFQ2Mk1rcGJydk4ybGlsbk4zNm5oZWlvb1hIU3Z5WTZx?=
 =?gb2312?B?UklUb0o2VlY3bDZ5eWNKTXp1UHhEeEx2eDVjM0dWTzF5SjdEZjNwUT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c972d5-bf1e-498f-4dff-08da2375775a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 09:01:04.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erTJbO3MjJP/llTwMQDwOP08g/fC9olmKxrvO/dBcsbvXLmiatJHTePiY440eioksIC4txe/bLk3w4Lhvf/WEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4520
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KQmVzdCBSZWdhcmRzDQpKZXJyeSBIdWFuZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4gDQpTZW50OiAyMDIy
xOo01MIyMMjVIDE5OjI3DQpUbzogSmVycnkgSHVhbmcgPGplcnJ5Lmh1YW5nQG54cC5jb20+DQpD
YzogYnJvb25pZUBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsga3J6eXN6
dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3Jn
OyBzaGF3bmd1b0BrZXJuZWwub3JnOyBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0K
U3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCAxLzIgdjNdIGR0LWJpbmRpbmdzOiBkc3BpOiBhZGRl
ZCBmb3Igc2VtdGVjaCBzeDEzMDENCg0KQ2F1dGlvbjogRVhUIEVtYWlsDQoNCj4gQWRkIERUIEJp
bmRpbmcgZG9jIGZvciBzZW10ZWNoIHN4MTMwMQ0KDQpQbGVhc2UgYmUgYSBiaXQgbW9yZSBlbGFi
b3JhdGUuIFRoZSBzeDEzMDEgc2VlbXMgdG8gYmUgYW4gU1BJIGRldmljZSwgc29tZSBraW5kIG9m
IFdBTiBkZXZpY2UuDQpbSmVycnkgSHVhbmddIEkgZG91YmxlIGNoZWNrZWQgdGhlIE1pa3JvQnVz
IGRldmljZXMsIHdlIHVzZWQgdHdvIE1pa2Nyb0J1cyBkZXZpY2VzOg0KQkxFIFAgY2xpY2s6IGh0
dHBzOi8vd3d3Lm1pa3JvZS5jb20vYmxlLXAtY2xpY2sNCkJFRSBjbGljazogaHR0cHM6Ly93d3cu
bWlrcm9lLmNvbS9iZWUtY2xpY2sNCkJvdGggb2YgdGhlbSBhcmUgU1BJIGludGVyZmFjZSBjb25u
ZWN0IHRvIGxzMTAyOGFyZGIgdGhyb3VnaCBNaUtjcm9CdXMgaW50ZXJmYWNlLg0KU28gdGhlIG5h
bWUgInNlbXRlY2ggc3gxMzAxIiBpcyBub3QgY29ycmVjdCBmb3IgdGhpcyBub2RlLg0KDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IENoYW5nbWluZyBIdWFuZyA8amVycnkuaHVhbmdAbnhwLmNvbT4NCj4g
LS0tDQo+IGNoYW5nZXMgaW4gdjM6DQo+ICAgLSBhZGQgdGhlIGR0LWJpbmRpbmdzDQo+DQo+ICAu
Li4vYmluZGluZ3Mvc3BpL3NlbXRlY2gsc3gxMzAxLnlhbWwgICAgICAgICAgfCA0NSArKysrKysr
KysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKQ0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Bp
L3NlbXRlY2gsc3gxMzAxLnlhbWwNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zcGkvc2VtdGVjaCxzeDEzMDEueWFtbCANCj4gYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NlbXRlY2gsc3gxMzAxLnlhbWwNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mNjVmYjU4MDkyMTgNCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Bp
L3NlbXRlY2gsc3gxMzAxLnlhbWwNCj4gQEAgLTAsMCArMSw0NSBAQA0KPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArJVlBTUwgMS4yDQo+ICstLS0NCj4gKyRpZDogDQo+
ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cCUzQSUyRiUyRmRldmkNCj4gK2NldHJlZS5vcmclMkZzY2hlbWFzJTJGc3BpJTJGc2VtdGVjaCUy
Q3N4MTMwMS55YW1sJTIzJmFtcDtkYXRhPTA1JTdDMA0KPiArMSU3Q2plcnJ5Lmh1YW5nJTQwbnhw
LmNvbSU3Q2M0NWQ5NzY0M2Q2YjQ2MzlkMDA1MDhkYTIyYzBiNTM1JTdDNjg2ZWExDQo+ICtkM2Jj
MmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MxJTdDNjM3ODYwNTA4MzI3MjkzMjE3JTdDVW5r
bm93biU3Q1QNCj4gK1dGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVN
eklpTENKQlRpSTZJazFoYVd3aUxDSlhWQw0KPiArSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFt
cDtzZGF0YT1iM2dhZXJWRE9JMUYzbWwzZlVsVEo0N0QyWWNEcWo2Y3RzDQo+ICswWUtDWVhxT00l
M0QmYW1wO3Jlc2VydmVkPTANCj4gKyRzY2hlbWE6IA0KPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ICtjZXRy
ZWUub3JnJTJGbWV0YS1zY2hlbWFzJTJGY29yZS55YW1sJTIzJmFtcDtkYXRhPTA1JTdDMDElN0Nq
ZXJyeS5odWENCj4gK25nJTQwbnhwLmNvbSU3Q2M0NWQ5NzY0M2Q2YjQ2MzlkMDA1MDhkYTIyYzBi
NTM1JTdDNjg2ZWExZDNiYzJiNGM2ZmE5Mg0KPiArY2Q5OWM1YzMwMTYzNSU3QzAlN0MxJTdDNjM3
ODYwNTA4MzI3MjkzMjE3JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5DQo+ICtKV0lqb2lNQzR3
TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdD
MzANCj4gKzAwJTdDJTdDJTdDJmFtcDtzZGF0YT12ODhlVXVGQVZmVGVvQVd5QUROWUhKOE53Rmph
NUNrWXJxV2VDbmRsYXlZJTNEJg0KPiArYW1wO3Jlc2VydmVkPTANCj4gKw0KPiArdGl0bGU6IFNl
bXRlY2ggc3gxMzAxIGRldmljZXRyZWUgYmluZGluZ3MNCj4gKw0KPiArYWxsT2Y6DQo+ICsgIC0g
JHJlZjogInNwaS1jb250cm9sbGVyLnlhbWwiDQoNCi4uIHRoZW4gd2h5IGRvZXMgaXQgaW5oZXJp
dCB0aGUgc3BpIGNvbnRyb2xsZXJzIHByb3BlcnRpZXM/DQoNCkFsc28gKnNvbWUqIGtpbmQgb2Yg
aW5mb3JtYXRpb24gd2hhdCB0aGUgc3gxMzAxIGlzIHdvdWxkIGJlIG5pY2UuDQoNCkFueXdheSwg
SSB3YXMgYWJvdXQgdG8gY29tbWVudCBvbiB5b3VyIHBhdGNoIDIuIEJ1dCBtYXliZSBJJ2xsIGp1
c3QgbGVhdmUgaXQgaGVyZS4gT24gdGhlIFJEQiB0aGVyZSBpcyBhIG1pa3JvYnVzIGNvbm5lY3Rv
ciwgd2l0aCB0aGlzLCB5b3UgYXJlIGdvaW5nIHRvIHNheSAiaGV5IHRoZXJlIGlzIGFsd2F5cyBh
IHN4MTMwMSIgbW9kdWxlIHRoZXJlLiBXaGF0IGhhcHBlbnMgaWYgaXQgbm90IHRoZXJlPyBXaGF0
IGlmIHlvdSBwdXQgYW5vdGhlciBtb2R1bGUgaW4gdGhhdCBzb2NrZXQ/DQpbSmVycnkgSHVhbmdd
IHRoZSBuYW1lIHN4MTMwMSBpcyBub3QgY29ycmVjdCwgSSB0aGluayB0aGUgcHVycG9zZSBvZiBp
dCBqdXN0IGlzIHRvIGludm9rZSB0aGUgc3BpZGV2IGRyaXZlciAoLi9kcml2ZXJzL3NwaS9zcGlk
ZXYuYykNCkkgd2lsbCBjaGFuZ2UgdGhlIGNvbXBhdGlibGUgbmFtZSBhbmQgYWRkIGl0IHRvIC4v
ZHJpdmVycy9zcGkvc3BpZGV2LmMgZmlsZS4NCg0KTWF5YmUgS3J6eXN0b2Yga25vd3MgYmV0dGVy
LiBCdXQgaXQgcmVhbGx5IGxvb2tzIGxpa2UgeW91IHdhbnQgdG8gaGF2ZSBkZXZpY2UgdHJlZSBv
dmVybGF5cyBoZXJlIGluc3RlYWQgb2YgaGFyZGNvZGluZyBleGFjdGx5IG9uZSB1c2UgY2FzZS4N
Cg0KLW1pY2hhZWwNCg0KPiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBDaGFuZ21pbmcgSHVh
bmcgPGplcnJ5Lmh1YW5nQG54cC5jb20+DQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBh
dGlibGU6DQo+ICsgICAgY29uc3Q6IHNlbXRlY2gsc3gxMzAxDQo+ICsNCj4gKyAgcmVnOg0KPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgc3BpLW1heC1mcmVxdWVuY3k6IHRydWUNCj4gKw0K
PiArICBmc2wsc3BpLWNzLXNjay1kZWxheTogdHJ1ZQ0KPiArDQo+ICsgIGZzbCxzcGktc2NrLWNz
LWRlbGF5OiB0cnVlDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAg
LSByZWcNCj4gKyAgLSBzcGktbWF4LWZyZXF1ZW5jeQ0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVy
dGllczogZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgIG1pa3JvYnVz
QDAgew0KPiArICAgICAgY29tcGF0aWJsZSA9ICJzZW10ZWNoLHN4MTMwMSI7DQo+ICsgICAgICBy
ZWcgPSA8MD47DQo+ICsgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwPjsNCj4gKyAg
ICAgIGZzbCxzcGktY3Mtc2NrLWRlbGF5ID0gPDEwMDAwMDA+Ow0KPiArICAgICAgZnNsLHNwaS1z
Y2stY3MtZGVsYXkgPSA8NTA+Ow0KPiArICAgIH07DQo+ICsNCj4gKy4uLg0KPiAtLQ0KPiAyLjI1
LjENCj4NCj4NCg==
