Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B0582646
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiG0MVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiG0MVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:21:18 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725813AB17;
        Wed, 27 Jul 2022 05:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHe3McSwEIF8rEdk0E5HHvf9f2r3QtTJElEhWr2/usXdhW+ZmXfNXqkujTFN4schZl3xtW5FCRIA/D0C/fQcstnUuaF44tJ9YitR6cjiJH37CIXpmx3Hgrp5kJMmP8lJZsFTtd0RIFPs4alrQLclKTC8pUXxZYSSHuMuZM6EU/UnKZb9qia0g03b7GZTK2SuyxT08HMNzDEirYgU+vXCaL7g1CGum3bx8inRVdrqVlxYt6WIotTyXpqFc2cwuKzjX5J+yJ33zigiJLTkO8wsKp+zS5LpOKigqva9o2gAUIH33dRzRQRKzNpqY0AvtGca7pTew9/znqWuyVJSkfyVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puVB+DHGg93+C7AVh7z8q82UI+6ly/rRnbI00n51GNQ=;
 b=fV6kKNzBr/o+MHq9RGcKhjizit/Hodq34ZTohscT+tZ9y5PCJNJ7estw/pwxEB089xavK2Gd+gSANcl50Z8snf17nDSieU3olWaKsxNjSDVbSznT53/ulykRsOcpqULUPF0A801xH42woGMVloM1GCP8MF06c/yRDuB3xaYhET6oSPHbmSnwfwa2D/A7Q+6NfN9cOogbmqMDOjb5sv4Y6Jiv0UQY4uFUVcSaVdnoABlhIqu0xgHzwLqy2ySxL1DtjzAjoAWFNiy+T+ab5iT35wSp/SBzBR73VDUkQpLMcRh2+31eKVO4wNbqoEw/mOzq8hZbzZxHvmC6p/w6oVN0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puVB+DHGg93+C7AVh7z8q82UI+6ly/rRnbI00n51GNQ=;
 b=JtIqkhLYVqy4LpTMUNjKYM8209uvga9pnbss0kXDlI8LgG3fxqEmR1HoWTplugsH0LevsIh63qzc5cCfp6roxxVTCwn33zsLAihQLm+Bfy2jNDqCipkkV3q18lMXBW0R2hoh2GobPLP8evFV09Fq27IxySRWIbuJxnhGnX5RG+c=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9354.jpnprd01.prod.outlook.com (2603:1096:400:196::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 12:21:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 12:21:15 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Thread-Topic: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Thread-Index: AQHYoRp+5i2kwB4v6Ue8zM4Y97KIiq2R6rqAgAADKoCAAA22gIAAAzUAgAAAzoCAABjHAIAAAfcAgAAJcsA=
Date:   Wed, 27 Jul 2022 12:21:15 +0000
Message-ID: <OS0PR01MB5922763582B836DA45CDFF0886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org>
 <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org>
 <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
 <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org>
 <CA+V-a8sX=Frs_cds9MriauTFRvcZUNCvoeZ+SaC0GUpL7L6qhg@mail.gmail.com>
 <9f32a4a9-66b4-ba2e-1713-436103c2faf8@linaro.org>
In-Reply-To: <9f32a4a9-66b4-ba2e-1713-436103c2faf8@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e243cae-51f1-4ea1-cec9-08da6fca8039
x-ms-traffictypediagnostic: TYCPR01MB9354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHX4FVOhvt8lH0Dl1AcXTGX35xqCHJkB6XmDxupo+ICMcohvoLVsl31G4ljxOsqfXyNOH0nqT9qtG/SM2ETGc3wXjPM4TMtKXJ9HDzrOP4O6eKNMdP5zzGsy+/Vn5iMzDFv/vrz4iwfoD9pQI9Xm5Vgpo4YQDCKbi/3Uq/ArA2sslnug2MuHv/AVzS9dimm2O10pLFyKaUiA0Q1BvTxcsc7cNUX65937lZAfHelIzTEVeNeHQrYdHlTrRBBWeGdQSVcJ2kFUaDesZIJLYZx+EQy96q2KYuj8f/oXdH9EX1MQ9yUioA2rvECa+0Gk9jFOtqaFhCDw7Q+ztrQhGBamVaFtNr63kwrgR4bSmyUsP/pEu+jERHxEIJxAO9EKdNDH3N2Ad2Z2zNTozyyerKihPqdRGgcubkj8rKQjcznp2aZLvmw3dWmv3GHXmLqjzd/IVC0N246DJNm77LfTlLpzNuiUFT2Og1gqRRHy1hfTADIBXHyEv0Ns99pyK9yoXPj5TATTBp4tfPnyQ02rwH2IV/SGFbW8H09G7k97wCMzTqHtrx/VaOaSMt9rzXwI8MWnh0Bgfntq0XTKqRaodwaoLjEYDfJ7798XeBSivOmM/ru1Y5JxRTGYb5zApgLHuoTsMkIhseLCYtGfdtJgO1nKIJ4qGhIvgBDpqRopWqQEKL9sLa/HvYHr7nM+t6Aovgvz1hTo4opdlEvFQ9KvQUdBpX/MOrZYqyPzDXOKa2LDGHQCrmCy6xyFJsBl3fJ3djTlD5nRcosDosSlu96uvLRhFjAvtt3r74KVA0cqwuNF0iSRNrwVgIswzCP//iRsI2og
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(5660300002)(4744005)(55016003)(2906002)(316002)(54906003)(8936002)(52536014)(110136005)(66476007)(7416002)(64756008)(66446008)(76116006)(66556008)(66946007)(8676002)(4326008)(26005)(7696005)(38070700005)(33656002)(41300700001)(86362001)(478600001)(53546011)(71200400001)(9686003)(38100700002)(6506007)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b21UTDIrRzFlRXdhMStsYTg2M0xGSEk2K3hnREJQbHJxL0I2WHNUN3M4RzEy?=
 =?utf-8?B?Vm1RWUdzUFE1MXk1UUhwMGt1bWlmRzd3b0ZSekcxbHF2aHFiRlQ5cjRwSjN6?=
 =?utf-8?B?NHJKV0dvWmtZUXpHNk52Y25VbGc5SFU0WkU2bGdSWTUrZThoQTE2T2crUUl6?=
 =?utf-8?B?a3Q4WGNLNUloRlFCdUdCbTBNOU4yRWMvbXpyNUFlZUZLZi9GdXhJcXROMUtt?=
 =?utf-8?B?K3orc2QvNGFyQ3RoZ0JUaEEwTEZRWkcveEMrWDZnMGppcEN4cSttcjBSOVhv?=
 =?utf-8?B?a1d4SWxPZzJLcVg4YVVtUGRKbnB6SkRvK3lmcnMxd3AyYklaWDJsMUxiL3VY?=
 =?utf-8?B?SDZmdWlRNEJyblZSL0JhRjJpUHhjcTQ2aTg1UVJhZzJoMjB0RVJjVzAzZGFC?=
 =?utf-8?B?RDdISVpYb3RyTFJCYnUzaCtnYmc1WU5ncG9CSmlNTmdTdHdkN244Zm9meXg3?=
 =?utf-8?B?TWw1NUlxL2lrY21YN2Y1Q2RWQ01UL3BMZDg3T3htTkMzVmNraUdUbGs2aG9F?=
 =?utf-8?B?OFh2QUwrN1dScGd6RUsyKzg2SDNGeHlJVU1ERmZTaWhhdU41Q2MxNU56aUkr?=
 =?utf-8?B?NjZSbGVHaVlLZDE1OHZQb2V5VHlhWkdSd2Vxaldpa3k3OHhKWHBqUDhFalNx?=
 =?utf-8?B?YXlOaGd3SzhSMWdVblhEUFhVZURWK2Zrd1Zta2dDcW1JOVhsOWxOWnhJR2RF?=
 =?utf-8?B?OFQ2bTVzdmQ5eGVwRmNLYmt1dXBubk10RUlGRDRnclQrT280Und4cmNzYTU3?=
 =?utf-8?B?cWRHYmNoM1A5cE51d0Q1SjFMc3BObTFBSkNiYVNFc3E5RDdKdHQrbmo2N2t0?=
 =?utf-8?B?TGFSS2tZbVRYYlRQNm92TDAyOGFJUnEwMzdzYmhYaEtiRDlkalBLTDZ6Yk5U?=
 =?utf-8?B?SnZuMzdFQlA4K2VCSmRQeCtGSGxDNU85dm1vY1oyMUhoamFudkZVT2ZsYlo0?=
 =?utf-8?B?djB5eGJDSTQyYUpnQ1k2b1d4Ri9ZZHQxZFB4YjRxQjVDMlBENnl1ZlJpbkZ6?=
 =?utf-8?B?TWU3cmlSc1lQdS8wWUZtQWJ0S2k3ZEVSOG5FQndVNFlWUDd4OStuUDlvMGYv?=
 =?utf-8?B?dEppV3cvQTR6YXNsSTdEaU9mWUhSaWdVZTRtS05hVXRNZG9qd0hTdkl0Y1pn?=
 =?utf-8?B?cEd6ME5kVzAvMHdvalB2RFZYbXdNcTRJZEZ3OXcxNDluRWplU2sxR1hUVEV1?=
 =?utf-8?B?V3dBc2FqdEJxY1BNZEg2RjdYSnJqSTJ6VHh5QnBSVThUWERSYlBZeHpuWisv?=
 =?utf-8?B?KzAvTlVvVzhqVmZGUUdCVkJreXFZVVRuNEZCUFFtRGo2aGVKMWppaFNqR0Vu?=
 =?utf-8?B?QUxCSHNmNytnQkNVcUhta2d0bmtTYmx3bDUvamppc2FrOS9xVDNGMldRY1Zt?=
 =?utf-8?B?Mm9uUTBTOG5WTG1heWw5RDA1ZkRqSHFwYVdQQWlISU9mUk1HdDJSVnRObGJt?=
 =?utf-8?B?TUMzUzlGYmlCaC9nbzVTQVFYSE5veUI2ZkVIQTJDUkNOQVkrbTVRU296Y1h0?=
 =?utf-8?B?b2xoS0h0UVhNS2FFUTA3ZDhkZ3hURW0xR2EvQVVmVkp5WTR2Qm5kNkc4R1Ra?=
 =?utf-8?B?SFUzOVFFSEFVVlFCZG5QdllBdzRMOXlpcllUNGZTUEhMQVVvTGtCRElYVk95?=
 =?utf-8?B?SXdGUWNKSnZqalhGbnViRW1CRWJZMXR4ZVFJMWUwMGw5V21JRE5pQ0F5THZ3?=
 =?utf-8?B?K21idkJMbUhVUWhkUGQ0ZjM2bGNDWmRDamhINnhvZSs4Z3RNcXVXRzJlWmgx?=
 =?utf-8?B?UGxVRTdaTTZCYjgxV2w1WFdKTUZxU3BFMkFlbmJaVG1YcmlJcTZ1TDdaeEJi?=
 =?utf-8?B?V01MMTJhNFV1QW1pWVRXUXlkMHlSUGJ1NjkyUXo3bWc3S1cySk8wVXlsSWY0?=
 =?utf-8?B?eSswZWEvRUE0cGNaak80Uk53M2tlYS9EMUR2ajJrS1lxc2hSUUtzZlZIZTdz?=
 =?utf-8?B?N0pJUkdwSWpydHNObHJPOWVmNkcxYTN1VmFCWWJRZ3c5Y21oWXJyWFU4cUlY?=
 =?utf-8?B?T0xYbW0zUG94MjF0MHVqelhPMXdxOGlpZ0dsYjRUbUJGMG5DMFd1ejhWVnh3?=
 =?utf-8?B?VjlIZ2xRcStHTys3TnM4VDdzVGlMRURhL3pOVXlNRzZoV0NEMGhnUThqbm4z?=
 =?utf-8?B?UTJDYVM3dHhKandyVXRlYjNBRnRObE52Y05FcEx2OHU2UGIweDNQdGNPUlIx?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e243cae-51f1-4ea1-cec9-08da6fca8039
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 12:21:15.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gV1JMYQCql/BDveGjlTSrvdtic01VAW8ZPkTiAViGku1DsskEwJdGNHthLW0AW9Zsvcks+kY6Ba1MCxSEOf/voZ6ckqcl0P+ZNUpywPdQCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9354
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzZdIGR0LWJpbmRpbmdzOiByaXNjdjogQWRk
IERUIGJpbmRpbmcNCj4gZG9jdW1lbnRhdGlvbiBmb3IgUmVuZXNhcyBSWi9GaXZlIFNvQyBhbmQg
U01BUkMgRVZLDQo+IA0KPiBPbiAyNy8wNy8yMDIyIDEzOjM3LCBMYWQsIFByYWJoYWthciB3cm90
ZToNCj4gPj4+Pg0KPiA+Pj4gSSBkaWQgcnVuIHRoZSBkdGJzX2NoZWNrIHRlc3QgYXMgcGVyIHlv
dXIgc3VnZ2VzdGlvbiAoYmVsb3cgaXMgdGhlDQo+ID4+PiBsb2cpIGFuZCBkaWRuJ3Qgc2VlICJu
byBtYXRjaGluZyBzY2hlbWEgZXJyb3IiDQo+ID4+Pg0KPiA+Pg0KPiA+PiBTbyB5b3UgZG8gbm90
IHNlZSBhbnkgZXJyb3JzIGF0IGFsbC4gVGhlbiBpdCBkb2VzIG5vdCB3b3JrLCBkb2VzIGl0Pw0K
PiA+Pg0KPiA+IFJpZ2h0IEkgcmV2ZXJ0ZWQgbXkgY2hhbmdlcyBJIGNhbiBzZWUgaXQgY29tcGxh
aW5pbmcsIGR0Yl9jaGVjayBzZWVtcw0KPiA+IHRvIGhhdmUgcmV0dXJuZWQgZmFsc2UgcG9zaXRp
dmUgaW4gbXkgY2FzZS4NCj4gPg0KPiA+IFdoYXQgYXBwcm9hY2ggd291bGQgeW91IHN1Z2dlc3Qg
dG8gaWdub3JlIHRoZSBzY2hlbWEgaGVyZT8NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgY3VycmVudGx5
IGl0IHdvdWxkIHdvcmsgd2l0aCB5b3VyIGFwcHJvYWNoLiBJbnN0ZWFkLCB5b3UNCj4gc2hvdWxk
IHNlbGVjdCBoZXJlIGFsbCBTb0NzIHdoaWNoIHRoZSBzY2hlbWEgc2hvdWxkIG1hdGNoLg0KPiAN
Cj4gVGhpcyBsZWFkcyB0byBteSBwcmV2aW91cyBjb25jZXJuIC0geW91IHVzZSB0aGUgc2FtZSBT
b0MgY29tcGF0aWJsZSBmb3INCj4gdHdvIGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzIGFuZCBkaWZm
ZXJlbnQgU29DczogQVJNdjggYW5kIFJJU0MtVi4NCg0KT3IgaXMgaXQgc2FtZSBTb0MoUjlBMDdH
MDQzKSBiYXNlZCBvbiB0d28gZGlmZmVyZW50IENQVSBhcmNoaXRlY3R1cmVzIChBUk12OCBhbmQg
UklTQy1WKQ0KVXNpbmcgc2FtZSBTb00gYW5kIENhcnJpZXIgYm9hcmQ/DQoNCkNoZWVycywNCkJp
anUNCg==
