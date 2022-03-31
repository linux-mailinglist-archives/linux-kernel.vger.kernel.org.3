Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FBE4ED5B3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiCaIgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiCaIgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:36:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE261C4068;
        Thu, 31 Mar 2022 01:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy2x2ofsyda7dj0+MgWn4sHJsFrymqheDdrVal5et8Y605iEJIVEUc7vxbpkS2KPudxolMaeEvNlgDJQTO09SqI1SKCVmpmfJbEQrSa77rjRDqJOvLu9DfwomFgG2Pp8WIBUV2g06EXOKRp+Z6vosAn7hyOgqdhqIEI/ACU4XbFiTLsgxbdEmJ20AM5XCI6Fgxlxv+4j2qCf1ffQb4t3Juzc5FChnHE0AGxDclh+L/8k3G46rsyGNxVcRSCSnZWpQBclppit64FfvHt0O78TYF+Q9T8AUFRwADrEfcLiMKqg+3sj+5IDm9QwUInfmgph2dodGtLWmBqpAXh5hnSJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKxsjzWcy02Cf/iu8Bsv1ff72dyBWuX4xljHwF7nWXc=;
 b=AIDzMVfMm6J1E8F8oVUU/sCaJ7OwxdGNyr4jpQ6D69VEYHClLpWqMLzrF6GInG4V74PZE9L+fCUEr/PPTGIaSCYe863+EKK8AEet9mFYKCGMCJqpRdaVr2ihQn5Tjpo4kA538SOsKIwrbssK3e99mX7MfQ6MfUBC1AP4FUBFuDckL7fRGE72pAoKQCHGqbi5xH8W609RRVV1MiC5PYfwOyu4yQiD7+9CNlVLTP0Hyv02+AluUAnz1jzkTZc1a6bwjlDBR55/IJMwaRSfAN4vX+Z74A7W/s0gOlouQlgVxD0jygvNO+ufc17IUkqk9D1yT1LCVZjPpwDAMiLVQBaBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKxsjzWcy02Cf/iu8Bsv1ff72dyBWuX4xljHwF7nWXc=;
 b=o1/rQsaDX2L6I+Mp2rZickDn8vvB3OkFN3AokxTo3SKKFRF0rF/ENYK5QMOHtK6X/GVsgmD7HxZQRZoL1xRRogzgJRMGUpbhcmQqWXB0TrSM2z1jb/SG6M9PzvqdJtmPkPMBs7NyB6iIp4kydm8UigNxJlbMPqNll+uXKkGRKwrJ8+WePMraI0l3Qt77ovptOfWBqFPc2RU5581LIbYLGoRgWzPApcktkY5LqlYxXoMA7eGxEEneV3ZqGNvBZwfCXBIiegtvB1Czb74wWuSWbAIftRj7uDM7d8ILk3+LLcW/+I7tBHbcQhkOKbACIUt2E5yj4X/rtapvn/CYHWej4g==
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com (2603:1096:203:5b::22)
 by SG2PR06MB2714.apcprd06.prod.outlook.com (2603:1096:4:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 08:34:43 +0000
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::38d7:bb1c:a4f0:a327]) by HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::38d7:bb1c:a4f0:a327%7]) with mapi id 15.20.5102.025; Thu, 31 Mar 2022
 08:34:42 +0000
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 08/11] spi: aspeed: Calibrate read timings
Thread-Topic: [PATCH v4 08/11] spi: aspeed: Calibrate read timings
Thread-Index: AQHYQDBlhRJ1CVqB1EKLdmJgf4F2MKzX0z/AgAAL1gCAAObB4IAAV/4AgAAVxOA=
Date:   Thu, 31 Mar 2022 08:34:42 +0000
Message-ID: <HK0PR06MB2786142465433B7BAFB0FEE4B2E19@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-9-clg@kaod.org>
 <HK0PR06MB2786548534B370AE0C691C32B21F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <0ec477b5-e404-536f-ff60-39f43208c3cc@kaod.org>
 <HK0PR06MB27866B5CC29F46436A4F6230B2E19@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <d12860e6-cc56-6073-0bf2-bfae02cbbd88@kaod.org>
In-Reply-To: <d12860e6-cc56-6073-0bf2-bfae02cbbd88@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eee45f0-1c0f-45f4-8ed3-08da12f14de3
x-ms-traffictypediagnostic: SG2PR06MB2714:EE_
x-microsoft-antispam-prvs: <SG2PR06MB271482582420EEC9DDCED3D9B2E19@SG2PR06MB2714.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qlOelOrXKyuu77dcdxacu+HeCCOhpyDNWbHiy0dQslJAJU/jE1ve6Alrb8rsFzIPwZ2dM9/skr3onepBu3N0hWQSKQ+/zuaVMyWs0i0yVps7VDK+lZM8tdARd7v6FKBm1xlCR5tBFiGx+TUz8nTFbykXj5A4SoQoRe4eGBnFo2lDao1s6Z9fUMluOOkgC5dRpw9lQjapUJH7t7Ft8vI+yaA5MX0qd0BzDaLk5Uw398nb9QI3tU6BsQiQZSyPcnt8R45IUAq9s7EAs/iN3D6OX4RrLvzoUopN72p421v0p72yYehZkiy5lfwZG9Ke4WFpiOHiBKCPLPlNHqK4DHUjuA4J/TW/JAodZkXuk8mhp2zfvqaxyzMSdDy0e5DAhW+5AKNng4pKpuZtXW+lBRVLQhaZ8D+p1bL4Wv88mmGYPlXrfYjC1F4GsRd6ZSAkfl+0LL3S+o59Y4bTCX6rAIqEvxYtvKL1ZVBx3f2w2AvjbCyt7nUtSJqBOJNvfVmJeQCD6j330kZ1zkIBreC6OvVm5pXjyDMeQ20ca7ApUthK15ap//F/dpapd82zdvXlweV08RQNLtFLz+PsDWX02pbx2Qh0W5G5NeJLpL53h5MtlwmfueGv+cbAUjimWvNFUrYyqmOIYLIlqRwHheD1fOsguTwtcw2wofpOKwujwDCI9JziHr3fj9F8Zzj5AFuo+Hd1dyF1g1gAVmjDQNYGDuJO1fPaLmR2PtsBQ42bJQyunWptbeMeGYdgkb2qOEANB9qF05cEnttRTyOMB+38szpKFB1fLxYNktONatYOQ5iWCU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB2786.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(366004)(376002)(39840400004)(346002)(136003)(66556008)(66476007)(66446008)(64756008)(5660300002)(76116006)(66946007)(8676002)(2906002)(38070700005)(122000001)(316002)(52536014)(86362001)(54906003)(38100700002)(8936002)(6506007)(53546011)(55016003)(7696005)(83380400001)(9686003)(4326008)(7416002)(186003)(33656002)(71200400001)(110136005)(966005)(508600001)(66574015)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTZaTzQ3REdraG1tRWprKzl4VFc1Y2RaOFJjYzZzdC9zZ1U5UG8vQzR4Vk5C?=
 =?utf-8?B?UFpUNUliZnQ0VEhnNVZ4MzhuQmFOamV1NjhscEN1WG43dVFsSVpoTE1nZHp5?=
 =?utf-8?B?YTVMTDhYWE1xanFaL1dXS3hPbjlOcGtoelBGQWtFWmtQWGE5TTR0MjBVbS8x?=
 =?utf-8?B?ZkxOS2VjQncyNldjRDVMQjhwNFM4YUMzZ0p1eG9vam9vNTBQbFR5VVJCaXNl?=
 =?utf-8?B?QTE0dGExdkZYcTQyOEVEbUtEMWV5bGRwRXdqYy9McW9wejRtaGhscE91UUFZ?=
 =?utf-8?B?Y25GbGdPVnk1UUdBdW5wN3NQRjBEaWtFSGFxVFArNE10azExbDRGaE85NUFK?=
 =?utf-8?B?V0FlVHVLVllmY0x4Z1VZcnRkVFhLTEt4ZUQrNnRUWk1mZ0twSllFYnBGWWdn?=
 =?utf-8?B?R3dOc2Q5VmJJOTVrVUpmRzI3c0RXbmY0RXZ0ZjUxOWxWQUtFRUxsYTgyRFQy?=
 =?utf-8?B?MjNvdjRFNFRGWEVvbUxpclJ5aVdMS1Z4dWczV2RpOWFxUXk5Q1Jid2hZaHFz?=
 =?utf-8?B?eW51ZWt2cStyc3VvL3RSQWI4elFpNXVBWDhFaURsT2R3YVpCR01vYml1WFF0?=
 =?utf-8?B?R09VUE45RU5KNitOQlkyWHJwRUNLWkdpREVoOGRzcDJTamZXQXlYVXFXTUJW?=
 =?utf-8?B?WGozNFBObDBxaUJTYlpJc2ZzWjQ4M3o4enFBNVI5M0VGaUFNOTltaHo2Q0Uy?=
 =?utf-8?B?MnBYamVGL1NFTEtqaDM1cmw3RVA2TVFYR2RpL3JsaHJNWmd0ek1jeGRrUis2?=
 =?utf-8?B?b1RVOStPcFhaUS91eVlBcTR6RnhXREVNWEtoZ0poUVBJM2ZVTWs1bFNSK2R5?=
 =?utf-8?B?d2hMdUphQTV3Vm1ydEZhRnZFZ2hiNCthbFF4MFd3NGkxOGNrNUhUWk9KSzN1?=
 =?utf-8?B?UloxNDk0R0tnaHYwZWhweXB1UmwybVprcUNkZUN3d1NuU2YzcS91L1dQa3Y4?=
 =?utf-8?B?clNJVkFMbG4yM092emw1YUdnNXZ1ZGJQVkwwK2plU24rMjMra3MyQmFXNTRF?=
 =?utf-8?B?aXZhMVZ0SWQ0cEFLL0ZCQ1Z0RGNkajJjQ3pIUHRIS0d0a2pxRUR4V3V1VkF6?=
 =?utf-8?B?M2gwZnJFRFVoUXRKSG8vTFFhS3F5NjRxMi9tTnlJTVFPSEpsU2I5V1RLWjg0?=
 =?utf-8?B?T3Y5THROS1ZlREV5eVJwdEt4bTBEbFlIUDBWK2Z4V3FWZU9QMEtrMno4NCsy?=
 =?utf-8?B?V0Nza0lOdFdPSUd2TkVZTW9kSnJ5OW9qVVdyVm5oNVB6dmpZRjRhR2JOMm5K?=
 =?utf-8?B?d2NFWDZSVSsrT1BrU29Wb0tWWER6Yi9ZNnZxTjNKOGpCSzYvZU1BbXRwK090?=
 =?utf-8?B?QURNTGJwY0J5MnlnbGZrV0dwcjVxSWFPMFVhNDdhQ04xeDg5OWhyaWpLUzla?=
 =?utf-8?B?b1NlMWVnaUp0UlA3ZEJiTmQ4eHJsT3R1UXIwU1c0dG9QdEpmU1dqaXdGNVhl?=
 =?utf-8?B?cGxIMUh2cGpLc09SQVpaV1Y0QXZsbnNqZ1dCUXg0bWpkY3QzYlVncFRyRXlD?=
 =?utf-8?B?TGtUWlBuRUJ5TlViTnhtblRUdktIcW4vdFRoTjZjeUNtWFg0eVNNcmF6cC9Z?=
 =?utf-8?B?M3hDZWtrOHExWWQwRUJjWmlJempPOVA2V21GR05FQ3dIVzdYM1g0MVo0cnFY?=
 =?utf-8?B?UHlrUkduMVQwUXB5aFFjNy85T0N2a1VFZnNka2hrNSthZmpvTS9TVU82Yk9x?=
 =?utf-8?B?Z0JUT0ZHMU1aa3V2bFpzM0lMVDdrYWhGckxrQkFURjljY3Qwa0xqRExTZlcw?=
 =?utf-8?B?V2VBRlgxdUYwbG1SZjRtaHhCMzh0bE56d3locThvUHFtKzI4bUoxNFFnMWVm?=
 =?utf-8?B?dmNMcERqSllKRzl0RjNEeENQOTFGWVFWdWkxdzJyOXU5RDlSWklQSUh5VG1Z?=
 =?utf-8?B?TU41K3ZPbGllNWRzNTNpdWhOSExxbTZyZ0ppRDVLNmQ5Tk5JNHc5WWNpRzZL?=
 =?utf-8?B?d29FZndJS3BmYWJPQmxCaVMxZmFnOUtaOUN0Q09PSnl0dVN1MGg5SzM3Q2N5?=
 =?utf-8?B?OC90QXRNcGd3eXJDcjdxUTZOcW1XbGxYVlR4bk5ZWFE4Y2dTeUlBWHY5MmNk?=
 =?utf-8?B?Tk1xSnd6aVhybnlYOGVpK2JTV2ZuZjdOSzlFeXZVZUcvaXVRRTFzVndleE14?=
 =?utf-8?B?NEw3ODUzenExT1RRVGZHMjVhclFIb2tnRzlwcE1VRXNJWXNQZlR5dHZWRkxi?=
 =?utf-8?B?cXl2ckdMUFN6Q3R0UjF1bzBlN2JCVHZUWXNLYkZBOXRVeGpqL043c3FRbnNV?=
 =?utf-8?B?UXp6azdlSStkWlZVa0ZmSkpZSUU5QmhVbnVsN2NXSmRpdXIzZDVTUU1LeGZu?=
 =?utf-8?B?N3BmdEpENTh4Sk9xRStDQzZ1alNSUmhvZm5wSm9jcmdWL3J4VWVRdElUVnh2?=
 =?utf-8?Q?D+bNR+0NScEOVm/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB2786.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eee45f0-1c0f-45f4-8ed3-08da12f14de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 08:34:42.8273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYyRQJZSZQK4YXbkzLuTsVDUS/Cj3HjO64KhWeNy9I0pnFC6QrDnDB1HP4WIVMtCrcQnNNen3quZ3Lv2dWkhV8B4AT2Jq7yxbAS8GbZhKEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMzEs
IDIwMjIgMzoxNiBQTQ0KPiBUbzogQ2hpbi1UaW5nIEt1byA8Y2hpbi10aW5nX2t1b0Bhc3BlZWR0
ZWNoLmNvbT47IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LW10ZEBsaXN0cy5p
bmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDgvMTFdIHNwaTogYXNwZWVk
OiBDYWxpYnJhdGUgcmVhZCB0aW1pbmdzDQo+IA0KPiBIZWxsbyBDaGluLVRpbmcsDQo+IA0KPiA+
Pj4gLSBNYXliZSwgaWYgdGhlIGNhbGlicmF0aW9uIHByb2Nlc3MgaXMgbm90IGV4ZWN1dGVkLCB0
aGUgZnJlcXVlbmN5DQo+ID4+PiBzZXR0aW5nDQo+ID4+IGNhbGN1bGF0ZWQgZnJvbSBtYXhfZnJl
cXVlbmN5IGluIHRoZSBkZXZpY2UgdHJlZSBjYW4gYmUgZmlsbGVkIGluDQo+ID4+IEZNQzEwIGlu
c3RlYWQgb2YgdXNpbmcgZHVtYiBzbG93IG9uZSwgMTIuNU1IeiwgYWx3YXlzLg0KPiA+Pg0KPiA+
PiBJbmRlZWQuDQo+ID4+DQo+ID4+PiAgICBGb3IgZXhhbXBsZSwgZXhjZXB0IGZvciB1bmlmb3Jt
IGNvbnRlbnQgY2FzZSwgdGhlIGNhbGlicmF0aW9uDQo+ID4+PiBwcm9jZXNzIHdpbGwNCj4gPj4g
YmUgaWdub3JlZCB3aGVuIFNQSSBjbG9jayBmcmVxdWVuY3kgaW4gdGhlIGRldmljZSB0cmVlIGlz
IHNtYWxsZXIgdGhhbg0KPiA0ME1Iei4NCj4gPj4+IC0gVGhlIGZ1bmN0aW9uLCBhc3BlZWRfMjYw
MF9zcGlfY2xrX2Jhc2ljX3NldHRpbmcsIGluIFsyXSBjYW4gYmUNCj4gPj4+IGFkZGVkIHRvDQo+
ID4+IHN1cHBvcnQgbG93ZXIgU1BJIGNsb2NrIGZyZXF1ZW5jeSwgZS5nLiwgNE1Iei4NCj4gPj4+
ICAgIEZvciBBU1QyNjAwLCBTUEkgY2xvY2sgZnJlcXVlbmN5IGNhbiBiZSBjYWxjdWxhdGVkIGJ5
DQo+ID4+IEhDTEsvKEZNQzEwWzI3OjI0XSArIEZNQzEwWzExOjhdKS4NCj4gPj4NCj4gPj4gQ291
bGQgeW91IHBsZWFzZSBzZW5kIHBhdGNoZXMgb24gdG9wIG9mIHRoaXMgc2VyaWVzID8gSGVyZSBh
cmUgdGhlDQo+IGJyYW5jaGVzIDoNCj4gPj4NCj4gPg0KPiA+IE9mIGNvdXJzZS4gSG93IGRvIEkg
cHJvdmlkZSB5b3UgdGhlIHBhdGNoPyBCeSBwcml2YXRlIG1haWwgb3Igc2VuZCBhIFBSPw0KPiAN
Cj4gV2Ugc2hvdWxkIGRpc2N1c3MgZmlyc3QgYnkgZW1haWwgb24gdGhlIG9wZW5ibWNAIGFuZCBs
aW51eC1hc3BlZWRAIGxpc3RzLg0KPiBQbGVhc2Ugc2VuZCBhcyBmb2xsb3cgdXBzIG9uIHRvcCBv
ZiB2NC4NCj4gDQoNCk9rYXkuDQoNCj4gVXNpbmcgdGhlIG9wZW5ibWMgdHJlZSBzaG91bGQgYmUg
ZWFzaWVyIDoNCj4gDQo+ICAgICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9saW51eC9j
b21taXRzL29wZW5ibWMtNS4xNQ0KPiANCj4gPiBCZXNpZGVzLCBJIG1heSBhZGQgYSBuZXcgY2Fs
bGJhY2sgZnVuY3Rpb24gZm9yIHRoaXMgcGFydCBkdWUgdG8NCj4gPiBkaWZmZXJlbmNlIGJldHdl
ZW4gQVNUMjUwMCBhbmQgQVNUMjYwMC4NCj4gDQo+IG9rLg0KPiANCj4gR2l2ZW4gYWxsIHRoZSBy
ZXZpZXdzIGFuZCB0ZXN0cyB0aGF0IHdlcmUgZG9uZSBvbiBBU1QyNDAwLCBBU1QyNTAwLCBBU1Qy
NjAwDQo+IHBsYXRmb3JtcywgSSB3aWxsIGJlIGNhcmVmdWwgbm90IHRvIGJyZWFrIHRoZSBleGlz
dGluZyBwcm9wb3NhbC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo=
