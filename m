Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CD455220C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiFTQPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbiFTQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:15:45 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299E521248
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUWq2hMY2Sgk9AuX2SyxQXwZcj2rJsleNHSCSAKhAZFF7U0QJb3hW+MkzJIlwEEt8Y2tjiOtP0klZDICluP8lT4tLt4LQ2jq6N0raZ7R/i9sx4imwApewj+VE/Z16bfxYszgra/jSBC9q08cVuHxRDxBPPTYoH8mnJ2QJJnHaRxFuMt1btX27PYSu2HXXB0yCGoMSeeBsi57BEMC/Og/k0nh3HZkw36ilh7sdsU7EgtTJZ+0AuZvWlETFV8orq6UvU1LzzN682Ye9lSfTZ24hZ8OzPSZ3DI26tMLWU81Y1lpv+JB/lKQdy5tEgLV7gtS6snwhi30VTrWkkX2uDmNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCiWPqcaC0W0R6JtIxcinMVm6aDTHh3ffikJy2y6wEo=;
 b=TkyRrl8lrz10gQp4iU8Km14Hm0XXnVdN4nZIk4Dgi5QndL3AsYNOR1zBSrKcWunvVCHHST7CaMcs4seBfW2+BkUJFxg4AmEsluffFRb9WdYXTiyWF5Z3jxp0icweKOKAOCMhZ8gGLn0qpBcZDCiSOXymrObUuesrkf7kkh2YE4MsSqG1BEYSN7zEPlXYieTp+3M+FGQHKG2BZl6AciKiZsLGLMMGbPgKtUUX5BHuPnwmFxOQRQVq8K9jT8Heibdq5S20pfebpu5amo2ZgoJWY5l/zipTpUR4Jz/ZPhh66tRL4PAB8XKc05TTqCwT+HKjfYmt+WuDj7M3iDbsSGGHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCiWPqcaC0W0R6JtIxcinMVm6aDTHh3ffikJy2y6wEo=;
 b=UJQ869w0/dbymOShF8lOsw0h9Xfsntf51eaLpcmUVZGrsNRYGZIswsHrRMfw/KWX7vNot9OWwBWCaqi4b4TcpoSk1Lbhm8TbCVdr0T3p3bTDNBhaMIPQfWVANkGgFnRsHh2zeC1nLMLRtwHE/R0ohN7UoG46Ha068U7/yNPHO30=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (10.242.27.107) by
 DU2PR04MB8744.eurprd04.prod.outlook.com (10.141.108.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.21; Mon, 20 Jun 2022 16:15:40 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1942:6123:5468:bf72%7]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 16:15:40 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Topic: [PATCH RFC 1/2] regmap: add option to disable debugfs
Thread-Index: AQHYhKwihmmQwo9gZ0uCTra8XCwz/61YZSEAgAAK2aCAAAFvAIAABRJA
Date:   Mon, 20 Jun 2022 16:15:40 +0000
Message-ID: <DB9PR04MB8477CD99D5847291A629994180B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
 <20220620134758.1286480-2-aisheng.dong@nxp.com>
 <YrCM0reni+x/KWsG@sirena.org.uk>
 <DB9PR04MB84779EF2842D789FA66094C380B09@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <YrCXILblKsp6DuN3@sirena.org.uk>
In-Reply-To: <YrCXILblKsp6DuN3@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae160335-df55-4c05-dd9f-08da52d81e9a
x-ms-traffictypediagnostic: DU2PR04MB8744:EE_
x-microsoft-antispam-prvs: <DU2PR04MB8744D412BFB160E3BCA056F880B09@DU2PR04MB8744.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7VkLPbFaCgCT16P+cMobxVvPgoEk67cLTxrQXkl54KbYSHt55vwGBMOlAxr9e2isktbr8J4i7P1+shQQ1goKCdtPD+WLcbx9rp85vuziHJEVY3mMV1A+35La45vOVkIOuJF29Nh6C0mMrlT82czENbgLR4XmQ6hFbDL3vcTXV0TxS4caaObX920QfpGJ+wkQY60xkeOYvYc0jP/Md5CntrcWl6TR8x6uFco+jrpm087drluKkXpRafPrxoW0Zz4JlibLdBTdZbmc8dYpIFMowMlaSjJMbbcNVNZg5G1As+RhYvShkyNonyz7ODmJ5u5yQKGAx/K1/pSC20bGaqyvuUeTgUoa1LUlid+Pm6Gu5duRw7duIUff8uk6G9uOe4B+Cwl5KlLQ85ziFOSjPleP0/hsN0rY2i+vTjfARGGmeZDrugxyrhycnqtVJ+ltlnjMX8czFRmHOShprp41hfJOTR8yC7c+hF0RKJ89YC6f5nX3axO23p8YlUiH/6pAfjizNS/3quq1q1tRtgExEvTsOto41acnSyXPWqKT7ohPCHHYZHZFmuEFhC9e5wIL8RkN+UKuM7n7mZopp4x7jGW2nL8SYfJIoQK9ldBXDoONw/OH/jq/IjZ3k76uiVtBIm81As9ep8ciD2bLUHI6A0ajcNWGmS/MYe4JrC3tJQajGNCZT9yZr4TSV5Cau6xsirT6BsxuQJNV128GlEs1ShwgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(41300700001)(83380400001)(55016003)(186003)(9686003)(2906002)(26005)(33656002)(38100700002)(6916009)(66476007)(122000001)(86362001)(66446008)(6506007)(54906003)(5660300002)(66556008)(44832011)(8676002)(7696005)(38070700005)(66946007)(76116006)(316002)(64756008)(52536014)(71200400001)(4326008)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bStRdWdRZFpYQzVsZlVLUms1eVB4WGQzMXBwN3JOc3Jkb1kxVDR2WEVLS1Mr?=
 =?utf-8?B?NHU3WGIrUCtJZHkyYXoxZGFRdmlROU82V2U3VUs5dFJjc1ZMNEhuMjFiazNw?=
 =?utf-8?B?TElXeFdCZkZSRUsraG9yaHljcFY5RTV4UWc5MlE0TWRpVjZCSTJuWkxaWlB3?=
 =?utf-8?B?Z1pJamxsSVcvN2E3T21kUnJ6Y3hvSVlJNzA0RjU3YUp0WTVSQi9lVE9VZGwz?=
 =?utf-8?B?WlYwZnVGUzlkanFnVmlaR1R0V3JrYkZmcjRwQjAwMVRKUFdZdnZpWVB2aGlP?=
 =?utf-8?B?dmpRVENHcktXNUV1aFI3Nmk0cnlXcFVHUUZKWGRhZkR5bFVxT0NVVit1UmFZ?=
 =?utf-8?B?R29LUnlpTHRjUFRFTFhiaGJBaW9hVnlCZXhuVzdvQUc1b3lRRzh1b3FNSW9y?=
 =?utf-8?B?ZW5QWTBqam5kbjNVNFJHMlB6YVFBNHY1NEFxcjZTakRqZnYvTHM1UHAwMGpR?=
 =?utf-8?B?dXZyMDBmemlNUThUbndURVVlakEwZnQzOFB4T3A3enFDSmMzNW96TUJkb3Rn?=
 =?utf-8?B?MzNIRm1rMVM3R0J5MVRSVytxYmF1eEhHMEg3N3N0b2N2OFoxa0tkazloazNI?=
 =?utf-8?B?K25tcTdjdHNpanppVzVXUTVIVDdvQTQ0YVJKMFV1Yi9xTVF6TGxkTnM1ajdR?=
 =?utf-8?B?QzI5ZzRVallORnFyOXFLcXR2M280RWtHTzBrNitIU0ZOemF4RlcwbXZKM1J4?=
 =?utf-8?B?cVkvZFdqWTExSEx5dm1mSnpBVXVmbG9JOWdCZ0NrQkVKcXN0Qllhb1lOVWhp?=
 =?utf-8?B?UzNXeWF2eHU2c0RkandCc1E4OTNlOC94MUY3Q2RSY1daZHFtZHJ0VWUxNXpz?=
 =?utf-8?B?c1EwdTVMZGNUMkNMcFhmbjRnMDNFT2t3NXBKeXZ3RGt6bzcwSFNiTmpVbEJO?=
 =?utf-8?B?MW41MHBDMnczazNFMjhxQTBYUURJeHlqTDZPR3BOVUt4U0hpOENCMGVEejll?=
 =?utf-8?B?R284SmVsczRETE9kWmFKSmx5MVZacTBMZnJIdDU2R3NWbVhIa3FEUGx6OFlz?=
 =?utf-8?B?TFJqM21jUnprSThBSE1tT240bElqTVZja2tjMUpFQ05FRGhXbWJTaGNRZ3p2?=
 =?utf-8?B?Q1doZzMwSTYrZzhpMTE3NVdtNUpXeDlmcklwY2RpcmtjZ2xleXNBeVBUMzVi?=
 =?utf-8?B?aE1iK0pCQi9PQW9PcWJRZFFFK2YveHhUWXNDQVhvd0kxbyszOTQ0a2xqNDhP?=
 =?utf-8?B?WWNXUWNJa2h6MXorYkUweVdjQzBGMzFmNWJUenVDTXFveG0rQnlaY1RyNkx4?=
 =?utf-8?B?SnU2YmVQMmkvSzBXV1RRN09iaFVxMmlBUFR2dDhYVHdGeHR0S1dKQ2tiTmRD?=
 =?utf-8?B?UFRNellrNTBaT21kMnJWaWFWZCtNVDVnU1hKSURlUWl5RVJHSXlQc1hwQlZG?=
 =?utf-8?B?RHVuMmQrOW83N0VNNmRnWEUwUXpaOFROZGx5ZTg3VmZOYjJCdGJsYS9DUzZI?=
 =?utf-8?B?c3VidnBoYlB6ZmttSFVObDBhdGcvdXp6MkxFdEFsRGllTWVaenliR1h1Tk1y?=
 =?utf-8?B?Njk0cXcwQlhTRkFFL2hkQkIwQ2VWM1Rwcy9aNnBFU0c0TWNNTE82UG9Eemdu?=
 =?utf-8?B?Z1V0NGZlMXp6OGpPSzRpUGNXRUhSaStFc0pybGxWRkVrT1YwSHlNaU04T3VF?=
 =?utf-8?B?ZmlNaVFHNU5KSzZHaFJkOFpsVFpJNUhEZXpzZ1FnaDZ0YjRuTWpMYlkvVXZ0?=
 =?utf-8?B?YVVJTUNWeThpenRVNmtsNThyNThQWHZUcmdHRGVQRnlxaGZlUWpraGRtRnlK?=
 =?utf-8?B?YjRlSjgyRmQvZFA3RmExbktsU0wwNE1XZUFpMVo5bWVCZ3VFaHBaUzVmbmJp?=
 =?utf-8?B?bTFMM2lwWW4rbnhhVHFLdk13ZWVKYW1xR3ZvZ0I4cjIyWHRFdDBHZnlNejQv?=
 =?utf-8?B?ZTBpWnJMK0hsRWF6ODRkUmUwbUJIZFBpZVRhdTJPcHdUYUljNStPRDBlaWwr?=
 =?utf-8?B?SGJ4RlVCUVJna2FYaEdvb2pKNERRdG56czNMa1dOd2NlcHVwNktvSFJtNXQ2?=
 =?utf-8?B?TVB6SkZRL1N1cTJCVTB1MW5KNXdtVTFON3hSdWltS3JuYkJiL0ZvS2NXV0tB?=
 =?utf-8?B?bWVMQ1ZRYysyRGV3M1VlVzd1Zm1wSVdnUHpuL1IyNkRQLzZsVXBtSXJ6ZXYr?=
 =?utf-8?B?Zzh0Wjh4bXJJcU16aDRMakd5a1d3eE5la3h3VDRoU0lNSzA0SFRFeTVnamE3?=
 =?utf-8?B?VHVnTnZnZDQ0cGtWRVJ2YXFDUkpuUjNTbmNWZ0tVSm85QWd1R1R5SWROUEJr?=
 =?utf-8?B?ckIyT1lRd1VTMktZVk0zNEwvclY0bllCT1I0YnZ5Q3hNTzBxVTFVcTA4bUM0?=
 =?utf-8?B?dEVacmhORjFLTWJKMit3NEhyd0J4QkQ1SDJQSDIxdkpyaVY4QWI4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae160335-df55-4c05-dd9f-08da52d81e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 16:15:40.6069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyhQze2Q3ET8WWExLNgVZO8JxwoyYEXXhmCC1izTBuP5HGL9qqOclIx2Ru4166IHIfXMEj+bIYufUtXUfsCWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwg
SnVuZSAyMCwgMjAyMiAxMTo1MCBQTQ0KPiANCj4gT24gTW9uLCBKdW4gMjAsIDIwMjIgYXQgMDM6
NDc6MDVQTSArMDAwMCwgQWlzaGVuZyBEb25nIHdyb3RlOg0KPiANCj4gPiA+IEFzIGluZGljYXRl
ZCBpbiB0aGUgbWVzc2FnZSB5b3UncmUgbGlua2luZyB0byBoZXJlIGlmIHRoZSBkZXZpY2UNCj4g
PiA+IGNhbid0IGJlIGFjY2Vzc2VkIGl0IHNob3VsZCBiZSBiZWluZyBwdXQgaW4gY2FjaGUgb25s
eSBtb2RlIHdoaWNoDQo+ID4gPiB3aWxsIGVuc3VyZSB0aGF0IG5vdGhpbmcgY2FuIGRvIGFueSBw
aHlzaWNhbCBhY2Nlc3Nlcy4NCj4gDQo+ID4gSSB3b25kZXIgdGhhdCdzIG5vdCBhIHN0YWJsZSBz
b2x1dGlvbiBhc3N1bWluZyB0aGVyZSdyZSBwb3NzaWJsZSB2b2xhdGlsZQ0KPiByZWdpc3RlcnMu
DQo+ID4gSXNuJ3QgdGhhdD8NCj4gDQo+IFRoZSBkcml2ZXIgaXMgZ29pbmcgdG8gbmVlZCB0byBw
b3dlciB0aGUgZGV2aWNlIGJhY2sgdXAgdG8gYWNjZXNzIHRoZSB2b2xhdGlsZQ0KPiByZWdpc3Rl
cnMgc28gaXQgY2FuIHRha2UgdGhlIGRldmljZSBvdXQgb2YgY2FjaGUgb25seSBtb2RlIHdoZW4g
aXQncyBkb2luZyB0aGF0DQo+IGNhbid0IGl0Pw0KDQpTb3JyeSwgSSBkaWRuJ3QgcXVpdGUgZ2V0
IGl0Lg0KVGhlcmUncyBubyBwcm9ibGVtIGluIGRyaXZlciB0byBhY2Nlc3Mgdm9sYXRpbGUgcmVn
aXN0ZXJzIGFzIGl0IHVzdWFsbHkgd2lsbCBwb3dlciB1cA0KZGV2aWNlIGZpcnN0IGJ5IHJwbS4N
CkJ1dCBmb3IgZGVidWdmcywgZnJvbSB3aGF0IEkgc2F3IGluIGNvZGUsIGlmIHRoZXJlJ3MgYSB2
b2xhdGlsZSByZWdpc3RlciwgX3JlZ21hcF9yZWFkKCkNCndpbGwgYnlwYXNzIGNhY2hlIGFuZCB0
cnkgdG8gcmVhZCB0aGUgcmVnaXN0ZXIgdmFsdWUgZnJvbSBIVy4NClRoZW4gc3lzdGVtIG1heSBo
YW5nIGFzIG5vIG9uZSBwb3dlcmVkIHVwIHRoZSBkZXZpY2UgYmVmb3JlLg0KQW55dGhpbmcgSSBt
aXNzZWQ/DQoNCnN0YXRpYyBpbnQgX3JlZ21hcF9yZWFkKHN0cnVjdCByZWdtYXAgKm1hcCwgdW5z
aWduZWQgaW50IHJlZywNCiAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAqdmFs
KQ0Kew0KICAgICAgICBpbnQgcmV0Ow0KICAgICAgICB2b2lkICpjb250ZXh0ID0gX3JlZ21hcF9t
YXBfZ2V0X2NvbnRleHQobWFwKTsNCg0KICAgICAgICBpZiAoIW1hcC0+Y2FjaGVfYnlwYXNzKSB7
DQogICAgICAgICAgICAgICAgcmV0ID0gcmVnY2FjaGVfcmVhZChtYXAsIHJlZywgdmFsKTsNCiAg
ICAgICAgICAgICAgICBpZiAocmV0ID09IDApDQogICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gMDsNCiAgICAgICAgfQ0KDQogICAgICAgIHJldCA9IG1hcC0+cmVnX3JlYWQoY29udGV4dCwg
cmVnLCB2YWwpOw0KICAgICAgICAuLi4NCn0NCg0KT3IgeW91IG1lYW4gc2ltcGx5IGZvcmdldHRp
bmcgYWJvdXQgdm9sYXRpbGUgcmVnaXN0ZXJzIGFuZCBsZXQgZGVidWdmcw0KdG8gcmVhZCB0aGUg
c3RhbGUgdmFsdWUgZnJvbSBjYWNoZT8NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
