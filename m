Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50BB5275CC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 07:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiEOFNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 01:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiEOFN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 01:13:29 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2116.outbound.protection.outlook.com [40.107.113.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E41835F;
        Sat, 14 May 2022 22:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWLEcQBJwl3G7pmlDf3dRVjqaeOiJ1J/M/+RW7UMcI0v7qkHpWHFjxsmOw3uSVnNKlSrgKYk+XiyJUzLv432TVxbhEnX3qkJiyewpS41WjcySlippzlbm3Yv4x9yy1Lciy8Apf6rsM1/g/zUnlfrXibhS5kULARqZqcil2N5pN+BNi1v/IuZ6BIxwki90tVIodgXwIlkB0nHrTlf3rVSvaXs3sO1HH7llhPcRAacRgiz42HM5+pF2cpaPaCoqplw7NxOiTbAjMkOtaxJDZlTO2dABcYVfLEuwfzP82euDeFNW1cq3O2u+9321KsNCvPZs77pkGVrYH7scmyaUk4cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es2rxCjibuPBgQTrmvRb9qY+7onBkkSTCFnCuiY0yjA=;
 b=fRQAdgUpntFNKBEyrzMDoesHjTrR3u1oyxcMpxK54CQXuEusEbI7Q9DyE6EkbCMrg873gmOhOc57xVAkJV14Gh4DomiU2R7FwrN4HT6yEBQg5FdcDOVI2+J1XE1Apq3MM9xSP5Oo4y70W1o4yXDQPSZKyMEiQZ/TObpe6QObc/taUG46WvWXS52jiLRp3xD9H5h4oMV7+tJ2ZxSiNtcepGGkQuhBLUWTevqKWM1wFL7F0wEJohicnw2bh20yunWvhLLuE3FlfJJNAgvwDmWMoBMPlOWrV9AA59FZEXI8j8JX2Gr8soWB8t85i06mU/u0b68nMAUAgftLJkYwiq/v2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es2rxCjibuPBgQTrmvRb9qY+7onBkkSTCFnCuiY0yjA=;
 b=QKI+1TYHvImCmgc8Ex9rPbcHDb5aBn0E9UkM3EQUYa9uoO+Wyw8DyR17s6sd2FxQv/wmBotG1tcW3Cl0fwxxQxbXkfM6uAMUkTVBIlkJfv8eiSkbXFk0H4fX/VjOYMZ9/3aCTUAx6WBcMcQsZ1RYyzanvmL+eOhxMAmbMz/WpRM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB4093.jpnprd01.prod.outlook.com (2603:1096:404:c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Sun, 15 May
 2022 05:13:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 05:13:22 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
Thread-Topic: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain
 to handle GPIO interrupt
Thread-Index: AQHYZWWEBd/euhXmSkarEpD10nkci60a2/SAgACm0QCAAN7IAIAAdeAAgAAJi4CAAD6IgIACRgWA
Date:   Sun, 15 May 2022 05:13:22 +0000
Message-ID: <OS0PR01MB5922C5DD97F922396CFDA6BD86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
 <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com>
 <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com>
 <CA+V-a8s2Gf22MPLoZMJS_5uDwzOboJ2i8rZ3KdRFy7a7wv8pGg@mail.gmail.com>
 <CAMuHMdXHJ385isGd-x8u4sFm1w=rxOC89SUryYbSd34bijkb0g@mail.gmail.com>
 <CA+V-a8uXakF45TLvpsfeAY_EZKDGHr-wfgqLR_LTz1ZAo8FYmg@mail.gmail.com>
In-Reply-To: <CA+V-a8uXakF45TLvpsfeAY_EZKDGHr-wfgqLR_LTz1ZAo8FYmg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 940989a7-6f1c-4159-2519-08da3631a1c8
x-ms-traffictypediagnostic: TYAPR01MB4093:EE_
x-microsoft-antispam-prvs: <TYAPR01MB40938B5A0140660D8300571286CC9@TYAPR01MB4093.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkiF+lwBJNarkmgXxDJH+WdQl2KDUe0EAtPSM6ezCOqRYhLtclTTEfeRqV26p/ONj3gyZZSAdvhjoGonQzCpdyWWUO+L2H5ohZrIwtVg4ALFOnka1GNXfq2DCT1aQbD23fcGk3hedBzTuhoayhl8i2lFsV8RT3YHQeRzZ365C6bSYIkZUgYVcqI8p4OxxLJrRwdmAI8983Ws4wkJdKGZel6R8DXfMopmVZ2+1ayagx3HG96pltkWjPp+COMbPJ1TMI93BNU7FN6PnJhwFsRqd5915u7rAcUeITvdhw9lkufWFIXYHSljABz5j7Xsl7y8fCRGC9qGuNQH+EdfyMsBC+MgMt1NO+wdj8frrD4rlnqYYxJP1Wo83ccahAxnTJn9L3ZWOIjh8WGO46xd4lEgmpbgyQHkTqZAuB2In+RMYeSZKDkn80xQg1UndMMvmNLUADnIGLjcvKs7Exqo0QsTU4tUtQ0AfjrnOYmADV/55ETQzqwmkJomuyQctpc+KJ9/xQpSDmvbBM1G/wkOabMiPel32rhwMo1A1thLddcrrVtXnG3aZhrOakNF5VlK109QKwkcl+dk8zzwwGKdv/pDkAn9RPaUbrNLZCiDkokXgcJbhCsy11pTsR8M0CN9vs68nIHEE92K7QqHGCFI8dxeivAwaNw1hN/830Vmy2W9Mw3QAQy3AclLn7zMe9OM9DW0e7HDilw+bcrZ0A6dbCMXSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(55016003)(83380400001)(316002)(76116006)(64756008)(66556008)(66446008)(54906003)(66946007)(66476007)(4326008)(110136005)(2906002)(122000001)(9686003)(8676002)(6506007)(71200400001)(7696005)(186003)(86362001)(52536014)(508600001)(26005)(8936002)(7416002)(5660300002)(38070700005)(38100700002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWRGamtxNmdRY0NkNXZhZmNqcUR6Q1VobndvQW5tSlVRcUhVOGI0OXJLRHRG?=
 =?utf-8?B?Z3kxZVhwVkJxV1RyeWZxU0FHcjNwb3AwM3AyL2tCdnpRdWh2T0d2aHltSHVq?=
 =?utf-8?B?L0d3OUZYd1B5Q0NUUEtXTjRka01xNVFwa0hzeEZ2T3ozVkNkOStuTHlWaGpC?=
 =?utf-8?B?OUZsWVNwSFVxWFZ0c3pJQ1cxelUrK1BuYlZvMlpJZ3dKa3dsQ29yZkVyYlky?=
 =?utf-8?B?aE8wOFJ0S2NpOWFUdGc3ZVRUdmI3UkZOczVZbEZuR1lMSlZsUEhqUnRNOENs?=
 =?utf-8?B?WFBOSUJIYWN3R0Z4ckxQSGxsV2xoYnFnanJzMWlCN1N0R3lkNjNoZytrMUds?=
 =?utf-8?B?M3Zsd0hqU2x1T0Zwa0RxQmFtU05SM1YrSnhLOHRYS0FaQnZJeUozamJyMjV2?=
 =?utf-8?B?eHFlOEhkUm5OdzYvWHBRcU0waGw0QnExUkJJMGhLWmw3SVUzb1lPdG15S0dS?=
 =?utf-8?B?VXZRQWFQVW84RVlLZVRWdi94ZXRTS05EeGVtc1lxRElvN0dBM09KUHVjZGNU?=
 =?utf-8?B?bXZyZVFKWUhISXJzZGo4Z3FkMlg1NlFYVjNkMW1RWVhCMDY4UmpUU20xZlor?=
 =?utf-8?B?cXkraFJTQkJVMHFHNTNQTCtYUy95bVIzOWs1SklBQ3ZuYVUyT3VNdDI4M1JY?=
 =?utf-8?B?eTVFUHF0elhxN2lxNW9uejV1OUx1VGZoYTNmbXZpOS9zOGRmOEQyR3FvaEQw?=
 =?utf-8?B?YUJ1KzZ5S2psK3pFUDlHcWd3dDVCVkJyWlZNK3I4WlZqWmoxQXhEcEdvK3ds?=
 =?utf-8?B?WWFTOWI4d2NxM1daMUxMSWp6aUlDcit5VzBmMm9rM1BaS1c3ZS80anVpYWs1?=
 =?utf-8?B?UHUzSzJiOFFFdDF1cHJPd1J0RU9NdWZPWlBTcWU4WXBtYXN1K2UrMGIwVzhL?=
 =?utf-8?B?eFNuTTBtd0E3KzZBbE0wTFk3THYybVlzd1B0YjRtSE9scThSckJsbTRBWUtF?=
 =?utf-8?B?ZVh4M1NIa0RISDJWa3IxOXhicTJLK1FEMG1zQ3FydHF0NVhyUm9Xc0Q0THgw?=
 =?utf-8?B?T2NNR1c1dGNHY0trNzk2ODN6cXZIUmNkZWgycVVLMGpadll0RXR2ejRlQXRr?=
 =?utf-8?B?bkJBazl3VUtvbHdyOG1NN1l1VUorS1VNYTNHeU5QcllWcGUwcC9TTm9YQThn?=
 =?utf-8?B?S2tEZUwwaTY0Z3AyMkUxekNwUGNBK2dnTmphcURKOS9tTnRNWUZ2VWxxUGx5?=
 =?utf-8?B?UlRHcW1xT3ZQS0krK1lwQzJ4S2pHRmpjMS80eFpkeGJUNFNVVjlsdk52RUxq?=
 =?utf-8?B?aGR0MUsvVnhCWS9ueUROTmNkNlhpQndSNXAxK2lENEdad3doTy80Q0Q2RzJH?=
 =?utf-8?B?RlRFKzdZTVUwbGdtMGMyUkVtN1lJQjhSSmxlenJSenhVQ3pUd3lERDlRc1VY?=
 =?utf-8?B?ekNxZWxTYXlUM3VYNXUwN2tYQTAzdDZjakhnYzNxc1NrWUJzZW1LWEtPeG9j?=
 =?utf-8?B?dkFDYnVKc1VWUml5WDFFek93TkJ0cTkvNzd3USt2Zm1uUVBJNnA0V3JQY3RO?=
 =?utf-8?B?K241b0IvbzNHZmxvbDBoY2VUZVI2TWZJU2JQK3BaaldBN1pJYnd5ak94VmVh?=
 =?utf-8?B?anJFTTBUY2RIRUFxQUNnc0g1L1dKeTJuZ3BjREpVMlhIVmpqc1EzQjBTM2lU?=
 =?utf-8?B?ZWZFMlN0V2txK2ZTRFlCUElBaUxDOTRkb1J2M3NrUmsrOUxjT3JoWEJRemxS?=
 =?utf-8?B?cURSUmZPd0YxNlJKeEdoUzRVSU92amNKUmlZUk9DNnhINXBmam5ESm5NeDI0?=
 =?utf-8?B?NTNLTTJZNFplQnpBOWs4UEdUQUFoOFh2TXhmeFVzSnd6dXFQbUlDL1RXWUdm?=
 =?utf-8?B?VFBQYWJuaEpibmZ5cVIxeGJQK1IvbThwSENXbHFldlVGeDNodTBPd3QyNlY3?=
 =?utf-8?B?cDcwV1B3Vi91VW9FSVhHdHBZV3dtcmdrWkI5VytSeGs5bmNPMnRDemZUUlZC?=
 =?utf-8?B?Tk8rM3RLMlVTS29SdUtOVXF0Yzg2aWwxZE9GcUgxdmpFbytORlA3NWhGU2pr?=
 =?utf-8?B?NDErR2prcExDOUpUVVc2bDRjcTkvN0lManV6WWZ0Q3p2WUVybzN1b2RLamc5?=
 =?utf-8?B?NjNwb2FsMWV3NWUwbHlyUmcxRVBCQUdSNThoT2RNOHpKSlM0b2Nua2NuSG9V?=
 =?utf-8?B?bGhTYzFnZktxdlhiTDZRL0hGaEljSVp6OHo4RU4yYm15cXdiTG5Oc2xnOEdy?=
 =?utf-8?B?TFVvRzVjYVJyMTltMllFYkdvOXVHb0FNZUQ5Y1c3akk5Qi83UWlhOElnbkYx?=
 =?utf-8?B?NEUxTUhuMEtadkJlNkVqbkN6ZXJSRVA4MFhoMlI2OVNWZDBaeDBRaXdtdlpo?=
 =?utf-8?B?UVc0NWhJenk4N25SRlFjL1VtaUhoc1VIUm56VVVwdThWRDhXOGxlT3ZQMlR4?=
 =?utf-8?Q?OelAVR35vnb3oqqo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940989a7-6f1c-4159-2519-08da3631a1c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2022 05:13:22.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNSq1pqNjnEMEdSg9q8UA03s0JbmkRwWQEL+J7TxEEwiW6bJ+ZLT6qv2lPkn/q/M55trDUsiMn4vViV/R/NxYxtBa5EUh99r0gmYUxBG94s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhYmhha2FyLA0KDQpUaGFua3MgZm9yIHRoZSBleGFtcGxlLg0KDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgNS81XSBwaW5jdHJsOiByZW5lc2FzOiBwaW5jdHJsLXJ6ZzJsOiBBZGQgSVJR
IGRvbWFpbg0KPiB0byBoYW5kbGUgR1BJTyBpbnRlcnJ1cHQNCj4gDQo+ID4gQnV0ICJvZmZzZXQi
IGlzIGEgbnVtYmVyIGZyb20gdGhlIEdQSU8gb2Zmc2V0IHNwYWNlICgwLTEyMiksIHdoaWxlDQo+
IA0KPiBUaGUgIm9mZnNldCIgcmVwb3J0ZWQgYnkga2VybmVsIGlzIDEyMC01MTE6DQo+IA0KPiBy
b290QHNtYXJjLXJ6ZzJsOn4jIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9ncGlvDQo+IGdwaW9jaGlw
MDogR1BJT3MgMTIwLTUxMSwgcGFyZW50OiBwbGF0Zm9ybS8xMTAzMDAwMC5waW5jdHJsLA0KPiAx
MTAzMDAwMC5waW5jdHJsOg0KPiAgZ3Bpby0xMjAgKFAwXzAgICAgICAgICAgICAgICAgKQ0KPiAg
Z3Bpby0xMjEgKFAwXzEgICAgICAgICAgICAgICAgKQ0KPiAgZ3Bpby0xMjIgKFAwXzIgICAgICAg
ICAgICAgICAgKQ0KPiAgZ3Bpby0xMjMgKFAwXzMgICAgICAgICAgICAgICAgKQ0KPiAgZ3Bpby0x
MjQgKFAwXzQgICAgICAgICAgICAgICAgKQ0KPiAuLi4uLg0KPiAgZ3Bpby01MDcgKFA0OF8zICAg
ICAgICAgICAgICAgKQ0KPiAgZ3Bpby01MDggKFA0OF80ICAgICAgICAgICAgICAgKQ0KPiAgZ3Bp
by01MDkgKFA0OF81ICAgICAgICAgICAgICAgKQ0KPiAgZ3Bpby01MTAgKFA0OF82ICAgICAgICAg
ICAgICAgKQ0KPiAgZ3Bpby01MTEgKFA0OF83ICAgICAgICAgICAgICAgKQ0KPiANCj4gPiBpcnFf
ZmluZF9tYXBwaW5nKCkgZXhwZWN0cyBhIG51bWJlciBmcm9tIHRoZSBkb21haW4ncyBJUlEgc3Bh
Y2UsIHdoaWNoDQo+ID4gaXMgb25seSAwLTMxPw0KPiA+DQo+IE5vcGUsIGxldCBtZSBkZW1vbnN0
cmF0ZSB3aXRoIGFuIGV4YW1wbGUsIEkgaGF2ZSBjb25maWd1cmVkIHRoZSBncGlvIHBpbnMNCj4g
YXMgR1BJTyBrZXlzIGluIERUUzoNCj4gDQo+ICsgICAgICAga2V5Ym9hcmQgew0KPiArICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJncGlvLWtleXMiOw0KPiArICAgICAgICAgICAgICAgc3Rh
dHVzID0gIm9rYXkiOw0KPiArDQo+ICsgICAgICAgICAgICAgICBrZXktMSB7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGdwaW9zID0gPCZwaW5jdHJsIFJaRzJMX0dQSU8oNDMsIDApDQo+IEdQ
SU9fQUNUSVZFX0hJR0g+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBsaW51eCxjb2RlID0g
PEtFWV8xPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgbGludXgsaW5wdXQtdHlwZSA9IDxF
Vl9LRVk+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICB3YWtldXAtc291cmNlOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJTVzEiOw0KPiArICAgICAgICAgICAgICAgfTsN
Cj4gKw0KPiArICAgICAgICAgICAgICAga2V5LTIgew0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBncGlvcyA9IDwmcGluY3RybCBSWkcyTF9HUElPKDQxLCAwKQ0KPiBHUElPX0FDVElWRV9ISUdI
PjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgbGludXgsY29kZSA9IDxLRVlfMj47DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGxpbnV4LGlucHV0LXR5cGUgPSA8RVZfS0VZPjsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgd2FrZXVwLXNvdXJjZTsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgbGFiZWwgPSAiU1cyIjsNCj4gKyAgICAgICAgICAgICAgIH07DQo+ICsNCj4gKyAgICAg
ICAgICAgICAgIGtleS0zIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ3Bpb3MgPSA8JnBp
bmN0cmwgUlpHMkxfR1BJTyg0MywgMSkNCj4gR1BJT19BQ1RJVkVfSElHSD47DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGxpbnV4LGNvZGUgPSA8S0VZXzM+Ow0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBsaW51eCxpbnB1dC10eXBlID0gPEVWX0tFWT47DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHdha2V1cC1zb3VyY2U7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGxhYmVsID0g
IlNXMyI7DQo+ICsgICAgICAgICAgICAgICB9Ow0KPiArICAgICAgIH07DQo+IA0KPiByb290QHNt
YXJjLXJ6ZzJsOn4jIGNhdCAvcHJvYy9pbnRlcnJ1cHRzIHwgZ3JlcCBTVyByb290QHNtYXJjLXJ6
ZzJsOn4jDQo+IHJvb3RAc21hcmMtcnpnMmw6fiMgaW5zbW9kIGdwaW9fa2V5cy5rbyBbICA5MjUu
MDAyNzIwXSBpbnB1dDoga2V5Ym9hcmQgYXMNCj4gL2RldmljZXMvcGxhdGZvcm0va2V5Ym9hcmQv
aW5wdXQvaW5wdXQzDQo+IHJvb3RAc21hcmMtcnpnMmw6fiMgY2F0IC9wcm9jL2ludGVycnVwdHMg
fCBncmVwIFNXDQo+ICA4MjogICAgICAgICAgMCAgICAgICAgICAwIDExMDMwMDAwLnBpbmN0cmwg
MzQ0IEVkZ2UgICAgICBTVzENCj4gIDgzOiAgICAgICAgICAwICAgICAgICAgIDAgMTEwMzAwMDAu
cGluY3RybCAzMjggRWRnZSAgICAgIFNXMg0KPiAgODQ6ICAgICAgICAgIDAgICAgICAgICAgMCAx
MTAzMDAwMC5waW5jdHJsIDM0NSBFZGdlICAgICAgU1czDQo+IHJvb3RAc21hcmMtcnpnMmw6fiMN
Cj4gDQo+IEluIGhlcmUgODIvODMvODQgYXJlIHZpcnEgYW5kIDM0NC8zMjgvMzQ1IGFyZSBod2ly
cSwgd2hpY2ggY2FuIGJlIGNvbmZpcm1lZA0KPiBmcm9tIHN5c2ZzIGZpbGU6DQoNCkZyb20geW91
ciBleGFtcGxlLCBMb29rcyBsaWtlDQoNCkkgYmVsaWV2ZSBmcm9tIGludGVycnVwdCBzdGF0aXN0
aWNzIHBvaW50IG9mIHZpZXcsIGNhdCAvcHJvYy9pbnRlcnJ1cHRzIHNob3VsZCByZXBvcnQgYWN0
dWFsIGdwaW9pbnQgbnVtYmVyICgwLT4xMjIpIGNvcnJlc3BvbmRpbmcgdG8gcGluIGluZGV4IGZv
ciBTVzEsIFNXMiBhbmQgU1czID8/DQoNCk1heSBiZSBhbm90aGVyIG1hcHBpbmcgcmVxdWlyZWQg
Zm9yIHBpbmluZGV4IHRvIGdwaW9pbnQgdG8gZ2V0IHByb3BlciBzdGF0aXN0aWNzPz8NCg0KRnJv
bSB1c2FnZSBwb2ludCwgYW5vdGhlciBwb2ludCBpcywgd2hvIHdpbGwgdHJhY2sgZ3Bpb2ludCBz
dGF0aXN0aWNzLCBwaW5jdHJsIGRyaXZlciBvciBmcmFtZXdvcms/Pw0KDQpFeGFtcGxlIFVzZSBj
YXNlOi0gY3JlYXRlIGdwaW9pbnQwLTMwIHdoaWNoIHdpbGwgZmlsbCB0aW50MC10aW50MzAuDQoN
ClRoZW4gaW5zbW9kIGdwaW9pbnQgY29ycmVzcG9uZGluZyB0byBTVzEgYW5kIHRyaWdnZXIgMSBp
bnRlcnJ1cHQgYW5kIGNoZWNrIGNhdCAvcHJvYy9pbnRlcnJ1cHRzIGZvciB0aW50MzEgYW5kIFNX
MQ0KVGhlbiBybW1vZGUgZ3Bpb2ludCBjb3JyZXNwb25kaW5nIHRvIFNXMSBhbmQgaW5zbW9kIFNX
MiBhbmQgdHJpZ2dlciA1IGludGVycnVwdHMgYW5kIGNoZWNrIGNhdCAvcHJvYy9pbnRlcnJ1cHRz
IGZvciB0aW50MzEgYW5kIFNXMg0KVGhlbiBybW1vZGUgZ3Bpb2ludCBjb3JyZXNwb25kaW5nIHRv
IFNXMiBhbmQgaW5zbW9kIFNXMyBhbmQgdHJpZ2dlciA3IGludGVycnVwdHMgYW5kIGNoZWNrIGNh
dCAvcHJvYy9pbnRlcnJ1cHRzIGZvciB0aW50MzEgYW5kIFNXMw0KVGhlbiBybW1vZGUgZ3Bpb2lu
dCBjb3JyZXNwb25kaW5nIHRvIFNXMyBhbmQgaW5zbW9kIFNXMSBhbmQgY2hlY2sgY2F0IC9wcm9j
L2ludGVycnVwdHMgZm9yIHRpbnQzMSBhbmQgU1cxDQpUaGVuIHJtbW9kZSBncGlvaW50IGNvcnJl
c3BvbmRpbmcgdG8gU1cxIGFuZCBpbnNtb2QgU1cyIGFuZCBjaGVjayBjYXQgL3Byb2MvaW50ZXJy
dXB0cyBmb3IgdGludDMxIGFuZCBTVzINCg0KVGludDMxIHNob3VsZCByZXBvcnQgMTMgaW50ZXJy
dXB0cw0KZ3Bpb2ludCBjb3JyZXNwb25kaW5nIHRvIFNXMSBzaG91bGQgcmVwb3J0IDEgaW50ZXJy
dXB0DQpncGlvaW50IGNvcnJlc3BvbmRpbmcgdG8gU1cyIHNob3VsZCByZXBvcnQgNSBpbnRlcnJ1
cHRzDQpncGlvaW50IGNvcnJlc3BvbmRpbmcgdG8gU1czIHNob3VsZCByZXBvcnQgNyBpbnRlcnJ1
cHRzDQoNCkNoZWVycywNCkJpanUNCg0KDQoNCg==
