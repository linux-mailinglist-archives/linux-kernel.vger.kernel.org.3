Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED65B1FB0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiIHNyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiIHNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:54:09 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2114.outbound.protection.outlook.com [40.107.114.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67AF824A;
        Thu,  8 Sep 2022 06:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfe6nFcPGwLpIGSUxGd6zbrWXJobJmjirTej9y16Ls9h+X3mQ4ZkPExaNxr4wCiroWp/G092ptxMosASGhmArA3iwKaLPgAJgThPJ4r3A4JH1OyMcAxEU5Ux5wmgJJHk389PiUZW/DOS9C/hMB+08niiinpOAx+ZFo4eWFsamZ9M210LXTCc6MoiluEqlTxXPPqoKoVlX4ugtm/T1VzHmAbfOhveypRq2zImn2GgF8QCnb2YILy0kYthDhxgEQyk2FCHjiihEPq7YHl+w8wgy1n40SV9GRZId9BCgrpJ859wXTj5puXxccSyPsdgxWCZsRH6lMo9pXYpJIvU8euWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdyUD+/PvFrW5lmefP2kvAnJs4ey3ghnGmZLsP+Ekfs=;
 b=WAHyCCNS9WXL4rkl+tvgJbZj63N009tAyqa0g4ktRGsXVl7lZpPdf6VN2/Ghml/Ahdfgj2jyL14ofmgFJ0ciTM8pt8vLm1l3wikiVd3hb2iQ4tiYm5JxfLQY2ClCbxyE9kYFd1QGHCCk8GySSCZxUmOlUNqHX9OMzMQAl4Wo6bQVJCWd9noxcLQMkuKZR3XQgm9kfgglKInFXUH61VHd68va/Ao+mDIrZ18KC9GeX+qMkR9S44S38sohFxFN/xad+/jCWWWFBjgR3jsmLJ1FECqtpCjZguCwPG4HPJ7Q6tGIDJ17ivDP4rqelVUMrSswybk9vcWi1mg82DSHSHaN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdyUD+/PvFrW5lmefP2kvAnJs4ey3ghnGmZLsP+Ekfs=;
 b=KGvRIilGpcAzYtCBa313TpBZCyHVGKrw168R3oKeMPgs61Zmye7Y3xSqUTQo+V2SlEaIkMEpcAEuJp1AwYk73p6jRnaQ7Uj2HZqGHXjJEmSrG+WW6jk3U68v+/vFHS5ipeaBcNNu1QkFzm/kMKOQXGTpr308RmwHMlqeo+e4EYE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9413.jpnprd01.prod.outlook.com (2603:1096:604:1ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 13:54:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 13:54:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "guoheyi@linux.alibaba.com" <guoheyi@linux.alibaba.com>,
        "guoren@linux.alibaba.com" <guoren@linux.alibaba.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "prabhakar.csengg@gmail.com" <prabhakar.csengg@gmail.com>
Subject: RE: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Topic: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Index: AQHYwdqJJqv+SV7oQUWARHgAT75zHa3SNg6AgAJOjgCAAB1VgIAAlHqggABG7gCAAACJQIAACduAgAAIE3A=
Date:   Thu, 8 Sep 2022 13:54:04 +0000
Message-ID: <OS0PR01MB59220F722262A76983D6CEFD86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
 <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
 <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com>
 <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <5e894d87-8abb-540d-fbd6-8a1d6f9d0e91@microchip.com>
 <OS0PR01MB5922F6CC81114BCE7696BEDB86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXyvVas51e1ozxyYG4_NnVYAMZ1B30raGgaj=FDPeOL2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXyvVas51e1ozxyYG4_NnVYAMZ1B30raGgaj=FDPeOL2Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB9413:EE_
x-ms-office365-filtering-correlation-id: a9f0c84c-e435-43ed-1a3a-08da91a1976b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GGUpwhz7qNgiyccqdu+ILJQqVsRcnqWqRpYItrFXe3UEE/pnkP+2L/7rCKkbTcT94KQH0JysVUxzRyMA8P4jm5uzSY4PF/Qf0Xb82ywSvg15wU012g5BesJJMs10dXJW0VG8zb0V8EUBrdQGVBmWihhW3TYlmXAIAL0u5L1bb9ga51BXF5zCeHUFYdpEm6YM6/q4ZS+Zi/vsonBczeiGl1B4hWrvg0WT4dfH6QI8ac6EC00EhA9tLcLWzF/O03vXfwVV2RPz0vljpYI6FiEigDxvfMBb+vJ5YtnSKg+3jjuSUn7mNd92N2EkAOHdDAOr+SpNXKFoY9PX5Uj+Ze7e9AmTZ7FX4gv0q532drrlZrCaLnFo3JzVUljo9fdj2jr7t6SQ/8WnJfhDtfniIZRDLy4LBXWnrXXu2O9w/vMIklERouaFUCwv4T29WxD3oTxDKO/gt8jvg13krtcBKjRzJ6tV9FcgXx+WtrR5JuhNvj/DBI8qs5HlLZojBVI28QK9r4mT2dsU0seeT3YmGUbwwmHS4WeSJOePF7IaV0yyxdHVcL9VrmlO7mAZpJGP5wstDaGTX3I9qvE3LFShM4G6TdUmk50zKp6LBQ2G7DBy0yvEtwXHMGjkXxa3akGxcXqfSCJSoEKeLroifDC+siVmZnhbqMQIFcb4swiQAK67HO+YweoOXRfSa+NdlfGwVYk8ETyCMbB18SOR6kzIuSiuL8LGnFKcAdmeIKVMT511jFH6XhyViOOXPGGTcIlIe8CGHDnTJQjrHkdzzhK1AQ8oZvzOQp7IGlKjJDkiR9xfEtw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(38100700002)(122000001)(55016003)(38070700005)(86362001)(66556008)(478600001)(66446008)(64756008)(4326008)(8676002)(66946007)(76116006)(66476007)(52536014)(41300700001)(8936002)(71200400001)(966005)(6916009)(54906003)(316002)(5660300002)(186003)(33656002)(83380400001)(9686003)(53546011)(7696005)(6506007)(26005)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1hsaXk0SzE0WDVTb1J6LzJBc3F2STNLVkJkTXdzVmJuZm5MbTFRT0VhTnFw?=
 =?utf-8?B?U2YrT3JBWWFZc1BscGtiN1poSDNSVm1xYllMY1ZTTy83TkdQNkRoTTFLbXY1?=
 =?utf-8?B?amhTWnZiV1NEYi9TWWJDYXdhY2VkZnRrMi9HazBzdDNZdDIxNEFxbDJtUHVp?=
 =?utf-8?B?YWxFTFA3SEVzQlk3THdrYVAzODlZNlJBYS96QXBtZjFCV29BVGJXOFZKbzFM?=
 =?utf-8?B?N01MNUNJbWNtTnY4dUdQbjlaY2lETm5vNWVSc2lzVmJnNzNhdFpHQ21VQmlz?=
 =?utf-8?B?YUsyUDBKL1VFT2ZoTmc2N2xpNkdDNVZKMERET25Lbmo5Rmk1Q0xVRTgzMnRW?=
 =?utf-8?B?b1VMMTFWdS9VMGFTUG9lVGVWODVVWHMxcUs5R1loaFFsTG1PTnFFL2hxN1Zy?=
 =?utf-8?B?QmZsMHNoTGlUMmRRb3M3Um9vNEVXNDF4SmdhRE9xSitIcmpCUHZydG1WaTBQ?=
 =?utf-8?B?c3FtbUtaQUx0Z3l1d2E5aGM0dmVJQ3BaNWZRdllVcXNsNXFadS9tZGdpTEg2?=
 =?utf-8?B?bTl3K3VDYnVmbEJiRysycjR5TXpjelRxendTbU1hcTluL0JWbUJjUFhLZFVu?=
 =?utf-8?B?TTBkU2ZIVnQ1V3VKK1dEUEtIdnYxY0NKZHVDZ044aDNuS0NOUG55QTBJZFRw?=
 =?utf-8?B?WUFFWnVCelZLamdjQVZVL21CcXlxejZTQmxJSGNXM2ZnUjB4RWJUYVp5Rjdr?=
 =?utf-8?B?RVNmVGE3dDRGVmRVeXVNMjZtMmlKdzJYMU0yN0dMRVk5OGJ4L2duMWhLWWpv?=
 =?utf-8?B?MFdvdEJLclJjNk1vcUN1MUtKNVNPakRUWVYrK3Mvck9yUzAyd1BrTEhvbDdI?=
 =?utf-8?B?U05wbTFGQjA0Y1hIZ0gwWDdwSjlWTktreFgvei9MYks4c0hMY2dpdUoyMGFR?=
 =?utf-8?B?empoandiWkx4bGhKYm1vL3ZNNlYxMk5rY1loYzA3SklXWVFNOVJ5T3RWNWN2?=
 =?utf-8?B?MDlGOUVYenI5QTlET2VoUysxWThpK2tJSkh4SGVrdFpTUy8rbFpyTXJSczRT?=
 =?utf-8?B?ei82OXVrQjVPenpZYStRZ3NKV0pkR0ZhSmJwOXc1SHd6SUpMcGM3WVozR0Fi?=
 =?utf-8?B?UzExMWc2NmlOYmM2VG81WjM4d1ExcjBsTmRidGFaWmdqcE9vNGlvQkovQ0No?=
 =?utf-8?B?c0RlbEx2blUveW51dmxlNmxkajVlS0IrS2FVNFphbmNMM0FkMGxVd0NHWmg3?=
 =?utf-8?B?R3Y3NTlnRDh0SXhCK2VPR010VHVSZjVFZWpLQnRlMlU2RWtWRGZjZURPbW5h?=
 =?utf-8?B?Q3NpY3RselR2TjVYV0I0ZVp2ODNPWVBGNHIrV2MwRjh1cndKTTdFZklQbith?=
 =?utf-8?B?K2tlVFlMSXMxa2JyNXNWMHgxRzRmMmdLR1pUNG50Y0lnZFRPQlNWZVRVY0lw?=
 =?utf-8?B?SVA5MUJHbm9KcWFkVW9uSkVwUWZWeHp4cHg0dXBvR3BqcFRlcCtWL2tSM0FI?=
 =?utf-8?B?NGx6QUYveis2ZWY5bXRNR0pLbTdxUTNLeGhsMlBGZFo4UEQvUHhOWWU4NVl5?=
 =?utf-8?B?anFLSldvVVplWTczbkhlTVBQc0JXSUg5OGF4MC80THE5UG44N1VKMFFTa3Fr?=
 =?utf-8?B?NjFqM2xkTjFiQXVPd2NRNHB2emMrSHE0ZlN6QWR0cy96ZWNNTjRLM1BwbjRY?=
 =?utf-8?B?N3NaKzA2VitaZ2lkSVljWGpzeG1rRnNjd093WmNNalp4WFA5SjNkQmZQVEtB?=
 =?utf-8?B?RG16SVV3czdvbExGTm5xZWg4b0hvSlpiV21zMXZuYmlTUDhFUEJxbjNDT2kv?=
 =?utf-8?B?dEVDRnlQYjVGN0N4RTI4WHB3YnNBL0FRbS9RZEVsc0RweEY4bW1NM2l6THdt?=
 =?utf-8?B?L0xLS3hvbWR2UzZYczVpai9IR09CUGlxMkdRYzR3QVpRYjVjQmc4TFZFRlRo?=
 =?utf-8?B?eHNYc0hEQXYzSVNGQllMenE2Q0JSbFMwa0xWa2VFdmhjcDI2L0h2ZXE2dktF?=
 =?utf-8?B?cm9EYWpraTg1R0c3WWlVSjNLbHRpRGdDK0JSbjdjQ1J5N0pGWVEzQVNoblVP?=
 =?utf-8?B?L2ZZQWxkZmM0dnZ0dzVjaDJQSFgxWkliaUpkR1lhU010SmdNZUtKaFMxcHlK?=
 =?utf-8?B?Ym9RRnI5RHBiNUdxVVBXMkEyVHFpZkxjcE5WNklJM0hRdzB2SzRTN1BjMi8z?=
 =?utf-8?B?ZGR6SVNDcHpkVDVsMmQydEt6V1UwN1hqYnplM2tqQ1lhRG1Ma01iT2l2Z1Jp?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f0c84c-e435-43ed-1a3a-08da91a1976b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 13:54:04.1862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bpf7L9/RYDHs3RcaMmmzxB1ID7y3+5XfiLH0QXZ71ohNd1vn+p4DDA4YTMXXnyFqOlTaU65EdeCsBYbbG8Ajn6yVMZp1m2DJ/axdNAaBwLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9413
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBHZWVydCwNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDEvMl0gcmlzY3Y6IHZl
bmRvcnM6IGFuZGVzOiBBZGQgc3VwcG9ydCB0bw0KPiBjb25maWd1cmUgdGhlIFBNQSByZWdpb25z
DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gVGh1LCBTZXAgOCwgMjAyMiBhdCAzOjAxIFBNIEJp
anUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiBTdWJq
ZWN0OiBSZTogW1JGQyBQQVRDSCAxLzJdIHJpc2N2OiB2ZW5kb3JzOiBhbmRlczogQWRkIHN1cHBv
cnQgdG8NCj4gPiA+IGNvbmZpZ3VyZSB0aGUgUE1BIHJlZ2lvbnMNCj4gPiA+DQo+ID4gPiBPbiAw
OC8wOS8yMDIyIDA5OjM5LCBCaWp1IERhcyB3cm90ZToNCj4gPiA+ID4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4gPiA+
ID4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4gPiA+DQo+ID4gPiA+IEhpIENvbm9yLCBB
dGlzaCwNCj4gPiA+ID4NCj4gPiA+ID4gV2hhdCBSSVNDLVYgZGV2aWNlcyB5b3UgaGF2ZT8NCj4g
PiA+DQo+ID4gPiBBIGJ1bmNoIDspDQo+ID4gPg0KPiA+ID4gQSBfX2NvdXBsZV9fIFBvbGFyRmly
ZSBTb0MgYm9hcmRzLCBIaUZpdmUgVW5sZWFzaGVkLCBEMSBOZXpoYSwNCj4gPiA+IENhbmFhbg0K
PiA+ID4gazIxMCBNQUlYIHNvbWV0aGluZyAmIHRoZSBWaXNpb25GaXZlLg0KPiA+DQo+ID4gSWYg
c3RhbmRhcmQgRE1BIGFwaSB3b3JrcyB3aXRob3V0IGFueSBpc3N1ZSBtZWFucywgb24gdGhlc2Ug
cGxhdGZvcm1zDQo+ID4gSU8gQ29oZXJlbmNlIHBvcnQgaXMgZW5hYmxlZCBpbiB0aGUgaGFyZHdh
cmUuIFNvIGFsbCBwZXJpcGhlcmFscw0KPiA+IGludm9sdmluZyBETUEgd29yayBhcyBleHBlY3Rl
ZC4NCj4gPg0KPiA+ID4gPiBPdXJzIGlzIFJJU0MtViB1bmlwcm9jZXNzb3Igd2l0aG91dCBJTyBD
b2hlcmVuY2UgUG9ydC4NCj4gPiA+DQo+ID4gPiBXaGF0IGRvZXMgIklPIENvaGVyZW5jZSBQb3J0
IiBtZWFuPyBaaWNibyo/DQo+ID4NCj4gPiBUaGUgSFcgd2lsbCBwcm92aWRlIGNvaGVyZW5jeSBi
ZXR3ZWVuIENQVSBhbmQgcGVyaXBoZXJhbC4NCj4gPg0KPiA+IElmIFppYmNvKiBpcyB1bmlwcm9j
ZXNzb3IsIHRoZW4gaGlnaGx5IGl0IG1heSBub3QgaGF2ZSBJTyBjb2hlcmVuY2UNCj4gPiBQb3J0
IGVuYWJsZWQgaW4gdGhlaXIgZGVzaWduLg0KPiANCj4gWmljYm8qIGlzIGEgc2V0IG9mIGV4dGVu
c2lvbnMgZm9yIHRoZSBpbnN0cnVjdGlvbnMuDQo+IFRoZXNlIGNhbm5vdCBiZSByZXRyb2ZpdHRl
ZCB0byBleGlzdGluZyBzaWxpY29uLCBidXQgcGVyaGFwcyB0aGV5IGNhbiBiZQ0KPiB0cmFwcGVk
IGFuZCBlbXVsYXRlZD8NCg0KVGhhbmtzIGZvciBjbGFyaWZ5aW5nIHRoaXMuIEkganVzdCBnb25l
IHRocm91Z2ggUklTQy1WIENNT3MuDQpodHRwczovL2dpdGh1Yi5jb20vcmlzY3YvcmlzY3YtQ01P
cy9ibG9iL21hc3Rlci9zcGVjaWZpY2F0aW9ucy9jbW9iYXNlLXYxLjAuMS5wZGYNCg0KQ2hlZXJz
LA0KQmlqdQ0K
