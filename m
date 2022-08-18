Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E544598B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbiHRSfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbiHRSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:35:43 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90088.outbound.protection.outlook.com [40.107.9.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C7120BB;
        Thu, 18 Aug 2022 11:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjvGcKn7LFKOi6sJ6gkiqwwfSpdr6nBmJoXh2y1J1CH7aCqMx2EdBaeQ7jufGJaTsTN7WEmSE6Zl0qa9sWO5LTkQj/agjFHx2HywqmjIJNWvRbYyMRBMhwsYfiTTBQkIFJyc9zP4gh1SwEUfYh9Rg9DkwG7qvU32Ix4xpB3DPmWtM3nKBfBtwWjGNIOSPY8OAYYPoYCBrtV/dyUR5WDgG5E819RjnSOKfXb8/m55E1470DETqHDkJZvey3Pl7INOjTzuiujhbtBEpJ6lwuR0Ry/YS3DzDKEBjrC5GMRNqwYIqXtPsMVjnoxmdwP6AtFgrxAmC2uBsliN63pBchGCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c2wU4D2o1Ctiy8ee5Vpp8WgUa162hLhFwxigFwIkbA=;
 b=R9P6asXKRotTPKSTMY2aq3IW7NAfar+2Wr2N0YC8VWNxS1FYro9uAlf2D8A7Mk0KQ5olcfISpAKhjnvlk0KndsC6sXAPwbnnE3YqEZpqPbaLccN054yqnyE/JU8XRcBcz5BgCvOPg4sA8+Wn5/2j081Bg/Ahk6NFaxYRJYvVve7EbHvRwNTvGHzhsdFKUC8Z5yyiMC1+aeHa/4hJ6xl9yBPyFqzKLy7RDZirSS86WECzg2oq/4eQwjNjGMzD7Bv9WiWyy6wPgR2MJHNUZfO7ovS++d3ZBDacpeBLKOg1jZtPNSxmupETa4DOHY0gNia3SgatNE92XCpwfaYx4HUPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c2wU4D2o1Ctiy8ee5Vpp8WgUa162hLhFwxigFwIkbA=;
 b=uOecmgLjzOWKC9fOi6IC78RkC+g93qYH56SHICZ5WemVzhTCz5g9oYV8PjLKfTle5DmV5piqUTQxJYOPPlWJB84aj83HS7HQi8eIA3gXbMies3sPYRTgyIpWTTOtX6Un8MEyCZj3d1BTDWpYQtrCA4PpNJTKXM7FQB2CvJ4++TV9+ni7LRxaisc8FxPXZarP3rARh2riM8VnVVp76816ixUgOkRFsU0Bdnc7AZ9vwvVRg9ovtZmdH0w5t6C5vDAvUHVZqiNKgdjCarxN9Cx2N/Jwp+UFJz91xJZkRWp1vyd7ttkI/hZSt/ZO+qaDargPt8Bpd53/RjWRQxLXwJhVBg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2780.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:19::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 18:35:39 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 18:35:39 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Thread-Topic: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Thread-Index: AQHYLLYaFbn8bOSg7kWQHVbhv1kp1KypFp+AgAAJIICAAAN6gIEM5foA
Date:   Thu, 18 Aug 2022 18:35:39 +0000
Message-ID: <f9046e68-ff22-2652-48dc-d277b4af75dd@csgroup.eu>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
 <YhzqbYW1q5bPNWXn@sirena.org.uk>
 <7afaab3d-50e0-4716-18d4-41eabc2a9cb9@csgroup.eu>
 <Yhz0/1kiAy7Mlgtv@sirena.org.uk>
In-Reply-To: <Yhz0/1kiAy7Mlgtv@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5808d10a-007a-42f7-1375-08da81487300
x-ms-traffictypediagnostic: MRZP264MB2780:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nc0MVqYbAcEUlnVtMEicQTfijb5Acaoru1LdYbKJLHGWQEGY5Q6lgCq/dMmw2/agGptm4+zuyKNeIki3WJGikJGVDKhbTyLGkvRy3zoGQzdeMy3LA6DK+UsAJN/MKubEP54xdn7vaFZQ30u3m2wDtyCGMriBF4XXQSfbzHy8f+HQgLp8WIFrhpNtwIiqrGZg5ojdfS0Ar/MeB3UO4FN5wiGhQkkf9FZNCZpHq2DTmq4yHU9Mt+7HogC+i5vmitu0g/CfJD1ZLdX9IS+wcne5o3NgAI/cbk3CDTIUQkZQtfArPnvrI3psNiTtvT3UJLgucNjn20ixrn+cZv2oKzgNHy/x9w0ESbA6oOdlOGuTP/Bz8+KAkDp97+oV09OV0+RfqyZs/rZ5cV8LEYyCFv7ySnueywc6hGRSqYTME6+iIxIwldDsX403wlkrw5Q6aMXdhjYBtMnVRX4DCEgFfarLqWrMgPP07jM95Tm9DLyFgCwG0pUAfK7TqzG5fi+K2CWZkXE6wHHiFbS5El6b0J0PcR/s2rxXdV2gRPLoVs9SNM6vIGuXzEBocdq4vwUvodPFrML2lqkXvC2FnyzrCpOAir3sygDPj1NY5F9CEhQZlIXC+Ur0dlYGzKUCLNMCNsLzdUY265QQsOy06+y4rRt8mIwe41jiZawes13AZrkSLHyLfAuNQt0HU5oFVpkKxxbDmhoqodyLltQQsWOnVWXZhmzOyVaX9tLVtzb+xtkhCLCqKJ9vDSi8QvXYV648l0PuXbVNiOvDWY5w5SIwTkhUHdl2B+wjh1t3OnHJq45RP+N2rh40x78TA5G9mUa3S/OSVsr+XayNeRENa2Fg9GFezTZOom7NO9sBss61vTlSklo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(396003)(39850400004)(86362001)(31696002)(38100700002)(66556008)(76116006)(2616005)(44832011)(91956017)(8676002)(66446008)(64756008)(316002)(66476007)(122000001)(4326008)(66946007)(966005)(38070700005)(6486002)(478600001)(83380400001)(5660300002)(8936002)(6506007)(26005)(71200400001)(186003)(41300700001)(36756003)(6916009)(2906002)(31686004)(6512007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3N3cCtVVGgraXl0eGdvSllFMzZ5OTVXZzI4UW8wSUx4cExwemRaL3Q2M21y?=
 =?utf-8?B?d0FaM3NCcWtQRlBHQ3RXcUtDT2RodElhWlI5dG9mM2dBNGUzTjZqaEpnWE83?=
 =?utf-8?B?NXVGK1QyT1ZtUU11ekcvQjdxR09hZ3F1VllWOWo1N0Y1RWovWkdVMkI1Nm5o?=
 =?utf-8?B?WmkydzdMS0RRR2ZzWHh6b0RyWUprQyt3TGZHNmNGSTQzZkh1Z2Z6eE5yMVVa?=
 =?utf-8?B?NHg3RXlERDJBa2pFdEVNNUZZSVlray92dyswYVlRN3A5d3Y5VEpYaWJFN01t?=
 =?utf-8?B?SXA4M3lsUUU1ZEcybVJlYkZZUWc4MTFCVGhqYnhJNmtnS0owVmlseis1UzRS?=
 =?utf-8?B?MnVHbkdwK01HamZtMEVBb2FsZnE1S3JEMk45djRXTmc4S21pMEtXMzE3TU4v?=
 =?utf-8?B?Qk5aTEdCS2gwcUowSkJWZXRYKzVOV2U4WXVlR1RVVlVDcE9VcnFhWjVwWmNB?=
 =?utf-8?B?MHVmNmtxNkhUY29YZWNSYVBBV2ZkOUR3UEVYZFRmK0hieXRkVk8yM0VtTDh5?=
 =?utf-8?B?bnQwWHRVZHE1Q08xcGZ6T2loczdSbGVGVEFsdWJoUlVadU0yblplclY1MS9S?=
 =?utf-8?B?TTVoS21ZS0t2cmtNMDBOWWVsT3BGRzBZcGY2UFRQNmNQZm1VQWU0aGU2cW14?=
 =?utf-8?B?czFHN1hsY1BJQUJJQUdwM2lpV0RZN3FIcUlkemdkSG5zMm9zR2NtaGpEMUh3?=
 =?utf-8?B?Q1lzd2ZmcG1hU095ODZiRFc5YThLdlk3ODB2Zk1XdHRENnBFeHEzSUx1UHJx?=
 =?utf-8?B?OXBoc0l3eVFVTzVNWTRVQ0haM1NiN3JvYzhtMWJET09UTDZRUE1abjZobWlU?=
 =?utf-8?B?SnRyeG5JbjB3dEJiZUs5TGVKbjkyaXAvN2szWFh5M0pkSVpJN3NjUGFEV08r?=
 =?utf-8?B?aVM5ZjFhQUJHUXBxTlZoWStBWFB6MitvQ0tYZHlLZXY2dTJOcUNEMkxvNEpU?=
 =?utf-8?B?LzB2NTdHL2VJbWhOWGUrejQycENoNFNEdHFzeWNNUEJaOEYwME91a21DVUtt?=
 =?utf-8?B?MHdjVWlGSHRBYmRmMTNpTi9tZjdGT2xxRUVNMEE3ejU5N2ZLSVJ4ejNzL0N1?=
 =?utf-8?B?c21tM2VMd1o3SkpWSGJaM0Z2MEpqYWQwT0NVeEJZclROOGtxN2RhclREbkw1?=
 =?utf-8?B?aE5QdjNjcEdhTElmK2c5ZnRMdExXMlY3amYrSFpPL25SMGZrRTZmRm45YWtV?=
 =?utf-8?B?Z1U0TjZudGhxZFNFZUR6ZVZmSG5WU2ZGQkcrOXVBeFQ3WjhxV1hvUG9KTEd0?=
 =?utf-8?B?ZktiZU42OHlpaHNVZW9qcFNMMWRDeGwvanVqd2xQaC9reXA1NHlzMk5CUlQ4?=
 =?utf-8?B?QU53Q0daQ0wwYVhOYktPTEZQVmx4OFNWTzVVY1pJcGI0WS9QbXpKc292a09X?=
 =?utf-8?B?MkpiQW1lRzBNNTNPYTY5WGIwbW5yYjlISG41MmZBZU4yaEwyclQwaVUzSTdV?=
 =?utf-8?B?YVh1TzBVNmNOWlJENVBLTVhYUUpidXVTUEdkcEtOSlVTZ25PSDU2RVJVVGJ0?=
 =?utf-8?B?QmtYY3gvd2QybHQxQUZ3S251L2o4MG51c1JvWE9TaW1KdzhnYnFYRWNxcnYw?=
 =?utf-8?B?dDFMUnVxWW5EQzBSK0JJTWh3M3Y3cnhQVDloMDd3SG5xQXJQd0F1KzI4cG40?=
 =?utf-8?B?RHVtWGhTbnowOVg4T1pCSStVcEdZVVp6NlN0YVU0WHdld0FkTklLamFpaFpm?=
 =?utf-8?B?aS93RTZEUEJxU3JDUlJVR3AzeE12aUlaYUlndFNxOGRuc2VLT0l5V21qWlBz?=
 =?utf-8?B?dzM2azQ3YjE3NGpXT3pRUmdJYnArV011Mm8zZXBvRWsrcFRnaXVZQjVyQWt1?=
 =?utf-8?B?YjJWdzgyL3hEVnowV3R1Yy9FVU14Qnc1OUszeWs2a3FrVEg3VVNOUmlYQXp5?=
 =?utf-8?B?Y2crVFJ5TStCL2dtRFJ1UDJBVm9MWXh6YzY3MWxjVkEvZFMzVFloc2ZZTmcr?=
 =?utf-8?B?b1BFdTNpUmNoMmJiWUlqcWFMR1k0a1lraTd1NXA0K0gxODJJNlVLWjhURUxa?=
 =?utf-8?B?Y0pOd2VMVGlnaHNmQzd2b2ZzamdVZ1lzajY4SVRKQmh5ZzA5dGJlWXNxYjBO?=
 =?utf-8?B?YnJnc0wzalZHclFhUnJKNnkveFd6KzBWaDI1TDFoN2dNT25QSWNmZDkzZWh2?=
 =?utf-8?B?UHBMQ0xKSnZhdWhLZVdMZFE0VkZYbk9QaDFvUTRuT3FpWlY2d1E5QlZaTHVM?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C13B630D692ED44DB941AA5B41D4018A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5808d10a-007a-42f7-1375-08da81487300
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 18:35:39.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctR4GeWz8Zqc1hPNuBK+Z0Rq41i5BcMr4Ar+JtfA2xWCJVBJs8EIzsryKRcUlxWOJyPZ9PmgLT5STsJRRmZy176gC6JmZ7DIP23kbeM/kBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2780
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI4LzAyLzIwMjIgw6AgMTc6MTQsIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gDQo+
PiBXZSBkaXNjdXNzZWQgdGhhdCBiYWNrIGluIDIwMTYgaW4NCj4+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXNwaS8yMDE2MDgyNDExMjcwMS5HRTIyMDc2QHNpcmVuYS5vcmcudWsvDQo+
PiBhbmQgbXkgdW5kZXJzdGFuZGluZyBhdCB0aGF0IHRpbWUgd2FzIHRoYXQgaXQgd2FzIG5vdCBz
b21ldGhpbmcgdGhhdA0KPj4gY291bGQgYmUgZG9uZSBhdCBjb3JlIGxldmVsLg0KPiANCj4+IEJ1
dCBtYXliZSB0aGluZ3MgaGF2ZSBjaGFuZ2VkIHNpbmNlIHRoZW4gPw0KPiANCj4gV2hhdCBJIHNh
aWQgdGhlbiB3YXMgIml0IHdvdWxkIG5lZWQgYSBuZXcgY29yZSBmZWF0dXJlIiB3aGljaCBpcyB3
aGF0DQo+IHRoZSBiaW5kaW5nIGRvZXMsIEknbSBzdWdnZXN0aW5nIHRoYXQgeW91IGFsc28gZG8g
dGhhdCBmb3IgdGhlIGhhbmRsaW5nDQo+IG9mIHRoZSBpbXBsZW1lbnRhdGlvbiBhcyB3ZWxsLg0K
PiANCj4gQWN0dWFsbHkgbm93IEkgdGhpbmsgYWJvdXQgaXQgcGVyaGFwcyB0aGlzIHNob3VsZG4n
dCBiZSBhIGJpbmRpbmcgYXQgYWxsDQo+IGJ1dCByYXRoZXIgc29tZXRoaW5nIHNwZWNpZmllZCBi
eSB0aGUgY2xpZW50IGRyaXZlciAtIHByZXN1bWFibHkgYW55DQo+IHN5c3RlbSB1c2luZyBhbiBh
ZmZlY3RlZCBkZXZpY2UgaXMgZ29pbmcgdG8gbmVlZCB0aGVzZSBleHRyYSBjbG9jaw0KPiBjeWNs
ZXMgc28gdGhleSdsbCBhbGwgbmVlZCB0byBhZGQgdGhlIHNhbWUgcHJvcGVydHkuDQoNClllcyBp
bmRlZWQuIFRoZXJlZm9yZSBpbiB2MyBJIHRvb2sgYSBkaWZmZXJlbnQgYXBwcm9hY2ggOiBhIGZs
YWcgLmNzX29mZiANCnRlbGxzIHRvIHNwaV90cmFuc2Zlcl9vbmVfbWVzc2FnZSgpIHRoYXQgYSBn
aXZlbiB0cmFuc2ZlciBoYXMgdG8gYmUgDQpwZXJmb3JtZWQgd2l0aCBjaGlwc2VsZWN0IE9GRiwg
dGhlcmVmb3JlIHRoZSBjb25zdW1lciBoYXMgZnVsbCBjb250cm9sIA0Kb2YgaG93IGFuZCB3aGVu
IHRvIGFkZCB0aG9zZSBhZGRpdGlvbmFsIGZha2UgY2xvY2sgY3ljbGVzIGR1cmluZyBhIA0KdHJh
bnNmZXIsIGFuZCBjYW4gZXZlbnR1YWxseSBhZGQgb25lIGF0IGFueXBsYWNlIGR1cmluZyB0aGUg
dHJhbnNmZXIuDQoNCkhlcmUgYW4gZXhlbXBsZSBvZiB3aGF0IHdpbGwgZG8gdGhlIGNvbnN1bWVy
Lg0KDQoNCnN0YXRpYyBpbnQgaWR0ODIxMDM0XzhiaXRfd3JpdGUoc3RydWN0IGlkdDgyMTAzNCAq
aWR0ODIxMDM0LCB1OCB2YWwpDQp7DQoJc3RydWN0IHNwaV90cmFuc2ZlciB4ZmVyW10gPSB7ew0K
CQkudHhfYnVmID0gJmlkdDgyMTAzNC0+c3BpX3R4X2J1ZiwNCgkJLmxlbiA9IDEsDQoJfSx7DQoJ
CS50eF9idWYgPSAmaWR0ODIxMDM0LT5zcGlfdHhfYnVmLA0KCQkubGVuID0gMSwNCgkJLmNzX29m
ZiA9IDEsDQoJfX07DQoJaW50IHJldDsNCg0KCWlkdDgyMTAzNC0+c3BpX3R4X2J1ZiA9IHZhbDsN
Cg0KCXJldCA9IHNwaV9zeW5jX3RyYW5zZmVyKGlkdDgyMTAzNC0+c3BpLCB4ZmVyLCBBUlJBWV9T
SVpFKHhmZXIpKTsNCglpZiAocmV0KQ0KCQlyZXR1cm4gcmV0Ow0KDQoJcmV0dXJuIDA7DQp9DQoN
Cg0KDQpDaHJpc3RvcGhl
