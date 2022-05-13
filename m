Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B8525B33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377182AbiEMGMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348025AbiEMGMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:12:17 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2108.outbound.protection.outlook.com [40.107.114.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CAF26CC5D;
        Thu, 12 May 2022 23:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRDeqmq+jDww4SMQ5Kp+JloQpBzn5BHceWYbE9ux4ZGR0O2hV6V/5MB8a9t4qAffIylFzJAdTTbNn+jJAmaEJZ11DmW7C03gk8A90KF792x3RKwBq/X8AmwWEy0PLsJyJynlhdWPyXufLk2eCDeABjIQuVAp6kJOoBeQQVJLfuuAKxQ2hWKfFeX7uGJYnjsFkYs+ge0bZxree76fMv8HbC0OS5erPwl1iq/dBVO4LSE/xp2kB+pCCijCyKXJZSfMcvCYkEcvTAfNoCu+Zbyt6Pm/lOgggOKCw0ZbFmOUhtyW1/Vh6QhGABjK0JW1EzCII/ZCaUIr6LvS8pxaDueLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EesCUVPUXrSQyQMqcv87eYwq6NuwQKGM5DgPF1HSwf0=;
 b=VttsXWYm+jVFXF2/8hmje01rKMhjd66XX2cyDMnrbFrX28aUrarT4SU1vWWZepRHU7xil906GziS3QvDP35FhUhN+U6xKssdYC+MwwhNE2NH0Uw2QY+Jano/4ORkAF/hzHPbp4gBsURVuv/P0Ow0cmHNFGcA11xUhxOwKPsbxyZGu1SnoBbjk/IcDs7VrElzkM19Ems7Hwd0XFfFKJgP0ApMlc3uZCGD0dDNpJpOs9ouLP/Hg0nMYlTLGcHgi+g+E6BPLUh3JoxarfXV+9WUUJ1oCM3vmzQxw6mAuZlWrwCTS7b03UvwIDj32cmEtHApxK56Vpt8bTpsdUjWfCTzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EesCUVPUXrSQyQMqcv87eYwq6NuwQKGM5DgPF1HSwf0=;
 b=Im3NHhvwlLaW9gbJmrNaPO0vM8fRDxdCJV+kQVZ3UPI/fa5u38sZTevWobg5vtKy+SLBqB3BYbMH4YB05xUmTt9O7iglfYK2TNntI6pHn43mV6jts1vAUaeu2dft/rVWArRRyBE0BoqHWJNGZSnI562vnTVwoovomR28iQYbXlQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8734.jpnprd01.prod.outlook.com (2603:1096:604:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 06:12:13 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 06:12:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
Thread-Topic: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain
 to handle GPIO interrupt
Thread-Index: AQHYZWWEBd/euhXmSkarEpD10nkci60auG0wgADMZYCAAAM60IAAzMDA
Date:   Fri, 13 May 2022 06:12:12 +0000
Message-ID: <OS0PR01MB59222A7E4DF42FB7557F757886CA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB59221ADFC86483FE2C8765C486CB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s4RfNSXCHG5xo4LhkHw09aj2wFnH0iCDos_ysunV1+5g@mail.gmail.com>
 <OS0PR01MB5922D4C79DE916F5715B610E86CB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922D4C79DE916F5715B610E86CB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c86161ad-d27b-4183-c11f-08da34a7856b
x-ms-traffictypediagnostic: OSZPR01MB8734:EE_
x-microsoft-antispam-prvs: <OSZPR01MB8734F11EC9905420CCBC381E86CA9@OSZPR01MB8734.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ebg/Rc3D1OfRSZo2uKCAhtSSyNa8m4juMsKgIqeyqAOPwcqDGm4rNQRuh5w5ZeEV4LbAm1ZAR2atinsfGfPNGzNpqdlDuKCwwWfWbMsyKB2psgzGbQ95U2QYy5sNWwI1gyp6cNszzvdC09fm15TiwsPW3dwXPCytXeU5lFBnjHn5j8mw5fjcMfLGrIVV00+laTSO7KNYfmuTYLfJ3efLtErRuTZFOoP+qv+lEwBC2w0b3cbqJ5bJcETkupjBIQdR0HzNIRjJ0EmJp/fz4F9+7elR9UWQXjVwtGxdAFQnuyfPPQVboikSpxUrk1v9DJ51V1+TSsgRNPpZoBp+mZg8YID7EFXyV4+fMkpofIV1jgMkyGzMWzF2YsHwB38dWdLjMSbSBtROMTl/hKzZSFO4EqLSO+6McIg2wV9lU0RV3zzuykGq4jPIHxB6pMID/Ny4HCi/3eQ9fdxwkl7F5NgL3DLjCkcQHiXKtjHYnZCZfjU7aP9egmq3Av1MzgUB9Trncsrdn2xCRWv07PiobrLF9a/kIJEwQXky/LLdFBGISFxX3OesYYv2LH+fb7GVG/raD2AjllVnk/rSW3tl0vi6RNNuvg/M1yHSfDke1+wg46gan//26GKv/Q3qZ0vgtCN8cWYrxvgyrD2wJ4MQmqPVwdksMYw4BuGOIgspO3JNTdpSkRgKXDtckYsnIZpfAQpR47esWTJnga/HUO1NX/HbT6G8JZB5TEH10hW23D1Nf+QgabjOLDeZ5sBhqNH66YutNXsgQf08vKnGbbjelY9M4LtrvPLbH6Cj6lgj9hlJSPs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(64756008)(66556008)(66446008)(66476007)(2906002)(5660300002)(52536014)(66946007)(76116006)(71200400001)(33656002)(55016003)(508600001)(26005)(4326008)(38070700005)(9686003)(8676002)(966005)(6506007)(53546011)(122000001)(54906003)(186003)(83380400001)(38100700002)(6916009)(8936002)(107886003)(7696005)(316002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDYzb1JxdWtLa3g1amU1SjY3Yml2K0dBYVZNbFhQNitKdmxRRkw0VGoxdXdZ?=
 =?utf-8?B?VERGb3V1TTZMaXVUaVl3T3FHRGVXU0pzSU1oSjdZd3FHR2oxVDhwWmhwMHE2?=
 =?utf-8?B?bExJdVpmV3YzRWRCWGhyQkVBSTlDRW9Nd1FVMTBSU3VBNFdyditJbDl5bHZD?=
 =?utf-8?B?eHdNc3Z1WXo5MG5jT09PSCtYTGNLVFlyazV1Z3BHd0FBUVVZaTRxU211dUdx?=
 =?utf-8?B?SWVMOXpaUFc5TmNWQXJOT3lYWVpYTExQTEFLR0h5ZXQ2Mkc2TE1KVWlzK1VX?=
 =?utf-8?B?bVFjNGpnZStLUlo2Rk9RYitlQisybzRwSkF1S0ZVcithVjc5eERFNEptMk84?=
 =?utf-8?B?UzJNRGtTMUlBYnVBRVFQOW55K3dNYmJydDVuT0x4cUpUQzV5R1kzOHptSVdi?=
 =?utf-8?B?Mk00NTRJS2w5RVhqckpXM0ZKL3J1aGNSOUFHb0N3RFhxOHI3bGROOURSaXZL?=
 =?utf-8?B?eWFtdC9raTNXTVpHVitWZDhraUtzQnFQd01TMUdCb01scFJNN2JOSHg3Zjkz?=
 =?utf-8?B?c0hwelpYb09zdXFQSkVwdG9aL2s5TWhwSjFqU1lyMERqUjJCNVpUSDU5TjZj?=
 =?utf-8?B?ODFZTFZXZmt3QUl2NHlMZEIwZzREUy84cXhJTHhKY0dIb0RiWlM3YngzbW9G?=
 =?utf-8?B?eFBaU0xjM3RDbitlY0R1MlVWMmxFNVJ6UHNFVld2ZklIckdPeS9hRWdENGZM?=
 =?utf-8?B?KzRvRTA2RFFZbVlUSUJMdFlYRm9sd2k1VkE0alNIdEJzek5SRWJJeHhWdXZa?=
 =?utf-8?B?WTFOOUp0Y0dQdWJzZERFbWpZUGQyNUtnTTBoVnVjeEFKb1o2bnZwc05lNmJv?=
 =?utf-8?B?ZXBJT1Z3NFRrSFlCOGxsWS9JR1h5dmpyUVdGSlJ2OGsyZnBiNlVVN25HYXRW?=
 =?utf-8?B?d2hOSHVpZVJ5d3IvRWNoanp6Q0ptcUU2YVR3VEwzYWZxMGhHNDd1cFNmT2dP?=
 =?utf-8?B?UnZJdFIvUEw5TEJORmFJejA5aE52cGJ5VFY1Q2VWZ1c2MWtkbmEyZXNZTGNB?=
 =?utf-8?B?MjlJdnprS2xQOWw4Y0VFL1BsZzF6NWplOUFQK2p0WHFuaTBJQTZJbDlvcSto?=
 =?utf-8?B?Y1ZzR0p0SitrZ3BUUXV1K2JYYjdDSk9qOWt4YzVSRUxReFg0Z1gyamlMbkJv?=
 =?utf-8?B?U2twdDdLWlRDUC9xd2dMeStyMDdZZlhIUXBHaDdzRVljRlAxZktlVTJIQXJ6?=
 =?utf-8?B?dWJ2Y2Z0cGhCYWhmcEt1RmJRajZEbHAxSG1OSm85eG5Va3R3bXMyWlE1aTRt?=
 =?utf-8?B?cXFlYXQ3aWtYK25uU0VTWm9oWDlFYkRITDUwdDU5MmI2WjlobHRTUUxDbWwx?=
 =?utf-8?B?RThHeHY4TWNBeDMzekhXSXNUZDgzVFBDSXh0cDBXTUN0b1FtQXFCM2ZHNENu?=
 =?utf-8?B?aU9BUzJHc250SHQ3dCtYYU1xcWJNT0oxYTdhaGVWbXNEV1FKSEt1bDI0cG5D?=
 =?utf-8?B?eFlzWGRKRmQwMHFiUkI3NkpKVVRTZTB1T0M5MjFSSnQrb3MzL05tbFdkVG5V?=
 =?utf-8?B?RzYybG1iZ2tzQ3MrZThBY2lld0Z1S3FSdDcvdzlOam5XemdXWmpwQnAxbEhL?=
 =?utf-8?B?cFY1ZDd6TlJmamtsVUFHZjdjRFR2WDZzMkVIdEszcDFyREYwU2xUT3pTRjZy?=
 =?utf-8?B?LzhDOGxPNjZFeW5meWh2VmljUmdMdmxyZDZGaFYwaHJ2K0lpM3A4ZC80emor?=
 =?utf-8?B?NlBrWWVaWTNiMHJiYWJUcERiZXd3enFvam16Y29NaVNJWDZsaHpvVUcrcDlY?=
 =?utf-8?B?WUx3dlhWY0RUSjgyZjYwWENWNm9QUERBeVE4SGw4VGtuWGNPZzZCVDFZaEp0?=
 =?utf-8?B?cE5NRDNuSXBvS0h3d3VmMlBTRHRRcG5TN1NuUGcvTEQyem80Y2hMcCtUQ0tF?=
 =?utf-8?B?eitmQWY2V2dIc3ZieFRteFY1VkYwMzcwbUtXRkdHY1EraXZjTU1jcFROQTc5?=
 =?utf-8?B?WFlPZ0Ric0k5QkowQnZXcUw1TU1BRjE5N3JyanpaRXZOSmlhdXdrdndUYmJC?=
 =?utf-8?B?Vm5UdWNOVkI1OU1JSFVIb2Z1eXkyeVNqV2Y0Mlh1cDRFOVYxdTdXVE1WWWFj?=
 =?utf-8?B?WUxKL3gxY01vWktPak9QQmM1RUhIVmtGRzkxQVY3MjVUelBML2tqbkloYWVZ?=
 =?utf-8?B?b0RUQlErVnQ3OUliQUVSWGdnT1puY3dKYWZhUXEvVGViTk1ack84cXp2NXN6?=
 =?utf-8?B?NHV5QU44OGs0TlJTV0JNZlpEZDEwd2N6L2xyOFVjS0oydmhQWFc4REdrVlhz?=
 =?utf-8?B?Q3pNL0s3WS95L0tRNEVzMVNNWjc0djZDd0dER3Vab1NTeU9oTlFkUUF0QzYy?=
 =?utf-8?B?Zm05RENVOGhiWXltL3RRV1RmWTRQZytPMHZkQTFsbzlZQTVLeUU5SnNxT2w3?=
 =?utf-8?Q?vGwewOs8oNi0/tx4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86161ad-d27b-4183-c11f-08da34a7856b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 06:12:12.8335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLZVE1ovyAiZNfh0WZSns0Mj9rpw0oP4hix/lEtfghjeeg2rabq2L36LJ7UxrQv4F1Qlfk8giGX+rhHvy88rsv3jnuYXWyInGmxdxZDdOxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8734
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMNCj4gU2Vu
dDogMTIgTWF5IDIwMjIgMTg6NTkNCj4gVG86IExhZCwgUHJhYmhha2FyIDxwcmFiaGFrYXIuY3Nl
bmdnQGdtYWlsLmNvbT4NCj4gQ2M6IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1h
aGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPjsgR2VlcnQNCj4gVXl0dGVyaG9ldmVuIDxnZWVy
dCtyZW5lc2FzQGdsaWRlci5iZT47IExpbnVzIFdhbGxlaWoNCj4gPGxpbnVzLndhbGxlaWpAbGlu
YXJvLm9yZz47IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgTWFyYw0KPiBa
eW5naWVyIDxtYXpAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+
OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5v
cmc+OyBCYXJ0b3N6IEdvbGFzemV3c2tpDQo+IDxicmdsQGJnZGV2LnBsPjsgUGhpbGlwcCBaYWJl
bCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47IGxpbnV4LQ0KPiBncGlvQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmVuZXNhcy0NCj4gc29jQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IFBoaWwgRWR3b3J0aHkN
Cj4gPHBoaWwuZWR3b3J0aHlAcmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMg
NS81XSBwaW5jdHJsOiByZW5lc2FzOiBwaW5jdHJsLXJ6ZzJsOiBBZGQgSVJRIGRvbWFpbg0KPiB0
byBoYW5kbGUgR1BJTyBpbnRlcnJ1cHQNCj4gDQo+IEhpIFByYWJoYWthciwNCj4gDQo+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyA1LzVdIHBpbmN0cmw6IHJlbmVzYXM6IHBpbmN0cmwtcnpnMmw6
IEFkZCBJUlENCj4gPiBkb21haW4gdG8gaGFuZGxlIEdQSU8gaW50ZXJydXB0DQo+ID4NCj4gPiBI
aSBCaWp1LA0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KPiA+DQo+ID4gT24g
VGh1LCBNYXkgMTIsIDIwMjIgYXQgNjozNSBBTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGkgUHJhYmhha2FyLA0KPiA+ID4N
Cj4gPiA+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KPiA+ID4NCj4gPiA+ID4gUHJhYmhha2FyIE1h
aGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4g
PiA+IFN1YmplY3Q6IFtQQVRDSCB2MyA1LzVdIHBpbmN0cmw6IHJlbmVzYXM6IHBpbmN0cmwtcnpn
Mmw6IEFkZCBJUlENCj4gPiA+ID4gZG9tYWluIHRvIGhhbmRsZSBHUElPIGludGVycnVwdA0KPiA+
ID4gPg0KPiA+ID4gPiBBZGQgSVJRIGRvbWlhbiB0byBSWi9HMkwgcGluY3RybCBkcml2ZXIgdG8g
aGFuZGxlIEdQSU8gaW50ZXJydXB0Lg0KPiA+ID4gPg0KPiA+ID4gPiBHUElPMC1HUElPMTIyIHBp
bnMgY2FuIGJlIHVzZWQgYXMgSVJRIGxpbmVzIGJ1dCBvbmx5IDMyIHBpbnMgY2FuDQo+ID4gPiA+
IGJlIHVzZWQgYXMgSVJRIGxpbmVzIGF0IGdpdmVuIHRpbWUuIFNlbGVjdGlvbiBvZiBwaW5zIGFz
IElSUSBsaW5lcw0KPiA+ID4gPiBpcyBoYW5kbGVkIGJ5IElBNTUgKHdoaWNoIGlzIHRoZSBJUlFD
IGJsb2NrKSB3aGljaCBzaXRzIGluIGJldHdlZW4NCj4gPiA+ID4gdGhlDQo+ID4gR1BJTyBhbmQg
R0lDLg0KPiA+ID4NCj4gPiA+IERvIHdlIG5lZWQgdG8gdXBkYXRlIGJpbmRpbmdzIHdpdGggaW50
ZXJydXB0LWNlbGxzIG9uIFsxXSBsaWtlIFsyXQ0KPiA+ID4gYXMgaXQNCj4gPiBhY3QgYXMgcGFy
ZW50IGZvciBHUElPIGludGVycnVwdHM/DQo+ID4gPg0KPiA+IFllcyBpbnRlcnJ1cHQtY29udHJv
bGxlciBhbmQgaW50ZXJydXB0LXBhcmVudCBuZWVkcyB0byBiZSBhZGRlZC4gSSdtDQo+ID4gd29u
ZGVyaW5nIGlmICJpbnRlcnJ1cHQtY2VsbHMiIGlzIG5vdCByZXF1aXJlZC4gSWYgdGhlIHBpbiBp
cyBhbg0KPiA+IGludGVycnVwdCBpdCB3aWxsIGJlIHBhc3NlZCBhcyBhbiBHUElPLg0KPiANCj4g
SXQgaXMgc2FtZSBhcyBleHRlcm5hbCBpbnRlcnJ1cHQgY2FzZSByaWdodD8NCj4gDQo+IEZvciBl
ZzotIEV0aGVybmV0IFBIWSBjYXNlLA0KPiANCj4gICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZp
cnFjPjsNCj4gICAgICBpbnRlcnJ1cHRzID0gPDMgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gDQo+
IGlmIHlvdSB1c2UgR1BJTywgaXQgd2lsbCBiZSBsaWtlIHRoaXMgcmlnaHQ/DQo+IA0KPiAgICAg
IGludGVycnVwdC1wYXJlbnQgPSA8JnBpbmN0cmw+Ow0KPiAgICAgIGludGVycnVwdHMgPSA8UlpH
MkxfR1BJTygxLCAwKSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KDQpGWUksDQoNClByZXZpb3VzbHks
IEkgaGF2ZSB0ZXN0ZWQgQURWIEhQRCBpbnRlcnJ1cHQgd2l0aCBiZWxvdyBjaGFuZ2VzIHdoaWxl
IGludmVzdGlnYXRpbmcgWzFdDQoNCmludGVycnVwdC1wYXJlbnQgPSA8JnBpbmN0cmw+OyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQppbnRlcnJ1cHRzID0gPFJaRzJMX0dQSU8o
MiwgMSkgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsgIA0KDQpbMV0gIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0
Lz9oPW5leHQtMjAyMjA1MTImaWQ9MDRiMTlkMzIyMTM2NTRlNTRlYzgxOWI2YWMwMzMzNjBmMTU1
MTkwMiAgICAgICANCg0KPiANCj4gQ2hlZXJzLA0KPiBCaWp1DQo+IA0KPiANCj4gDQo+IA0KPiAN
Cj4gDQo+ID4NCj4gPiBAR2VlcnQgLSB5b3VyIHRob3VnaHRzID8NCj4gPg0KPiA+IENoZWVycywN
Cj4gPiBQcmFiaGFrYXINCg==
