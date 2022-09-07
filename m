Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5105B063B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIGOPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiIGOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:15:44 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90054.outbound.protection.outlook.com [40.107.9.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B91838B;
        Wed,  7 Sep 2022 07:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIDOs2XhJTzPUY7uRUmCVz3MNinP0IRKSNewEkMTBRWh+tFVFUQ6ZvYUflN7ufmZxzMdThDXGBI1GCBy0ZccVuqOPwOjlnQw+1bfQ4QMlrTy4yi4Nyn5LntBO8IwuvzqufOh3nlqQhftIHZLELTh83cFXyp8TnfkhCFQ3CV85ZL1dPGhmhwX4J4otDT9aEwAZwVz0ux9f/bUKuyikRKf8rHODRlFfj2GM5z/H0ICmK8mI2sr7dBe6whdAEnUdgoYyU0Y76Y/pQxmC9MvM5PbILgbqHApgvdZlu8YlKoCFn2Cvlz7SAdeguboyVGVVKWLw9WCLLEuKvtZlFFpK+kL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G84Xnw+wzMS9yXpTtC3KRk4Q+S/lipObz/6BxSxh4E=;
 b=FJJTsLnlBAucMbvkbYrGcPdz48IuCqq2ga7aa6I3vjQM/sjibo/t69BI4Doz9yQwTHFYWgdwVt7ik+zoOIkT2YGiirwpnNn6KVAGo/26EckwR/Q7eWO4h/dlw8iA4oLL+fpf/dsuq6dwfWv08J+XcA1PkTq6uKNpJeE2tWYtxSUnSNEMBOhzpFWpbRFmM8hzyORDoa5cS6LMqDSMzjUmYLXTB5QJv1f1StcizuPdzUnec4vQK5iOihHVBKMQtP2nbVkzGodAkIr6BxuIKaKptCeD4BJrAEsRi1bWHtCF4tdE3yiyeKBUYvK0wC/Q9U2GippWgiFW9U61/e7oXAOTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G84Xnw+wzMS9yXpTtC3KRk4Q+S/lipObz/6BxSxh4E=;
 b=fTEMdg+zth3OfyaoFGbsgYJ0X5iSRTQ+YjYTSMPux9bkCsevygbDuBRyFPfgGt49vNNmlnLrJQzy/BCDzi0WM9vTs064BmfIUCDtl3iNZmUAVYI9XGx0v7T+Kudd6raM/hp77OhalG/qcKrFbgzg9ZcV9ea3vDQ+tUjms160mdRlUFzXdfT8TNNz2FpRtlOkMf1LGxAxs1XxkH3s7gT9kdO9JZn2n7qQkku99xF+Z6TjNRq52M4EwiT9fJbRc/P0Q5/pM6bpp9eHoOJaLC/IXBV2r223DPvm3mZO+jMzd7htSORzx/t4njrCWhXrXcuTIjGJmU/Gcx/j3i5qcnjxqA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2282.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Wed, 7 Sep 2022 14:15:40 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 14:15:40 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3] spi: Add capability to perform some transfer with
 chipselect off
Thread-Topic: [PATCH v3] spi: Add capability to perform some transfer with
 chipselect off
Thread-Index: AQHYswqO8Kc9VdcRcE2LGLJ+oumCL63T+DsAgAAqSAA=
Date:   Wed, 7 Sep 2022 14:15:40 +0000
Message-ID: <b8f85b72-5313-affb-3402-70e2102d1383@csgroup.eu>
References: <fabbc87627e5ddc2c913b368ae99386668d8dcfb.1660830866.git.christophe.leroy@csgroup.eu>
 <YxiEEP3krNUiUvlg@sirena.org.uk>
In-Reply-To: <YxiEEP3krNUiUvlg@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b33e8a48-ce1f-4c3e-f2e1-08da90db71aa
x-ms-traffictypediagnostic: MRZP264MB2282:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eK4esa2duVfq9Op3D9s8ys9hHh4kcLg5DLDm5o8OlzDAj7+acMxiVzO3FVYazTPvPLxzBF1/iJE6ywO0rol8AbKs7mE/Br4ECwh9uTuhtds8ILcQ/vgWyePLq+rm2zeQr8Z5+Fa75T/M59et0tSeeHoYADK5RR9YrD9bRxISaJaXysbtQ9ScKHww5W1/vlnWUAFAcQ/OlB0Dtmdlmw17lOFH8ObFu2wkAnJJTgAYE7OkNrHW/fSQcVMb8FQYjyMjBaFM+7hWj+qFzez9tuOrxlrhjoaZEcmzhfTsoauPHmMlrq0UkWTW6y+5i7vAU2J8v20IgMOlAoutga5uDIut6Xiv9lYjlmxH52z0S0xtDUgG8brPd/Nlv6PHzSSFYFojOENNnITwXF0AqmSMi+D6XHiOV/FYhcoAWXlFCbpYQr2T1FlO+QdSSOtMES45FBQ1U9xS5yytdQOS62oJ8ihUEyUCNFEg6EcLF+6ppwoQFJ/mkNmeYDxS25JcoKQACzS17FMMSVWEbI302g68OTHMeqeVPlZ4RGHZwmxuHUIE2IGUxN/tFfXaFr5AjA4iuJxDNqWHPeJX81AfM5F7iljEFHElNlcDFLZccG3vBnTGm3Hk0u1bHHPrHQVJPedHfC7ST4Y0eA9c2xuBPcqjD1E1THzwJYaOy7q8V789vaB6/RVJCQ0Uo2O5ZjDdU/TPX6fh2QKwzWrltTi8WysNwL3bUXVbUfI78DDluaOZUwKqdQRHEFZhIQw5tQVWPsYi6qsDnowi6IcPw3eGlVt4ZDvpa811PtpXgX6tAYO0tG3jbdc2MItVDi4Zv9QDFSQ6unrx/+mTYHNmz0sFuwTtCLbZyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(76116006)(86362001)(31696002)(316002)(54906003)(6916009)(6486002)(71200400001)(38070700005)(6512007)(41300700001)(6506007)(2616005)(478600001)(186003)(26005)(31686004)(4744005)(2906002)(122000001)(44832011)(8936002)(8676002)(66446008)(64756008)(36756003)(91956017)(66476007)(4326008)(66946007)(66556008)(5660300002)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjBOQkFhWE1kQ3FOeXd5NkQzUm5OajNWa2tYVHQzVHVCY1lua0Fib3pLa2U2?=
 =?utf-8?B?WXNYUTIvbXk4cmR0c0NBeGRUWEFmZmQyeHJtSXZyWU00eTdJYU5kSzJSN21W?=
 =?utf-8?B?Y0NqWVBIc0dVbGY1QUZFMTVYMXhtVnBCaThnRVRnRkczSTZLSnFnRXd4bUtk?=
 =?utf-8?B?eVU4c0RUSENuUVRtZmQ5VzJUUzZTYkg5d3l3ZHQ0WVFtRTEyNHpkSmhiaita?=
 =?utf-8?B?NlFidnRBdDFwRkFoYjVYeHNxaE9JZ1VRSXg5d1lVSkFVWUtZbzZCS213Q09r?=
 =?utf-8?B?RTkvQ1BuMmowUzY0bTBhaHdLM2JtT2dsMW5mSXM5VVN1VUZqS2VRd05BOW5N?=
 =?utf-8?B?bDEzbHhJc21wb05ITG1LbCtZTXk4K0Q3cEd0SVhnQkMzY2RzTThBNTVMNWhR?=
 =?utf-8?B?UlJKaGt2VWRGaC9hcnBLSTczRVN1Y2FFY09tTGZENFpNd2R6andjNmYzVkNC?=
 =?utf-8?B?cElYYjlnNkZQY1BrZUtDOTVhS1JGaFNmUWJBUzR1dHR3MURNUVptSTZyQlAz?=
 =?utf-8?B?ZFA4OW45eDIrL280dVZ4UXBPZHJaaDU2cUkvLzhGcExudkVDNGRMdUh1clR6?=
 =?utf-8?B?NjhNSXdNRmwzcFNMUVZVekxqQkE2d0h2OWRwSUNXOGc3OFl2S2ZvOFBJbmJX?=
 =?utf-8?B?bDZsVG8vV2VyTUpRT0UxeDNOL2xFbGdBUFU0UndrWTNUV3p4dlIrNGZnczAx?=
 =?utf-8?B?cTNtdWxIck5LUHp4NlpWSmNvMHdpN1dGbENsSVFwdE81b2RSckRlR0RCa1d3?=
 =?utf-8?B?a0NjZGZCa0pEaFcrcGdzYUVSYW5makIzS1RLMVVEMytoM3B2c1Z4Y3VzalhL?=
 =?utf-8?B?L0hlYXJhajBqelk4aGZMSm9sNVZITW9DWjRmcjBTYjJ0Q1ROVXR6MXRvNDcv?=
 =?utf-8?B?bHZtMVhIaFM2RnhoUzE0ZDVaZ1ZFZzZHQWh0UlRFb2dyTWJOYWZ0WVdvWFBs?=
 =?utf-8?B?TTYvOHIwRTcyYVM3Vk0wYnpPWmFDNGIvb2c0aGRwNFQ2ejFKd3RBTVErZDJr?=
 =?utf-8?B?VjdtOUp5aWlZK1pxSTRMRTlhRmxpMjdYaU9yWWRWV1dQalN2UjgrNTZGMElT?=
 =?utf-8?B?T0FFQm1aQ2VtUzlhTmQyS2pmVzlFbFo0YmJrZGFqZXMrRU92cXovQ3BCZzkx?=
 =?utf-8?B?L1JQOGcyVUFTSzdYeDVPaDR6MHdncmZYKzN1ZDFCSXhUMmxWSzdhWFQra3ZN?=
 =?utf-8?B?YldmbzV6cEVUNElsMFJhbmdCSSs0S0kreHh0NzB2RE40UlhQUDhsRlNqZjYy?=
 =?utf-8?B?ZWdsUmdENEtVRHVpc2NNT1dSODRWMzlIekpjOW1vY053OVJ0RXVjaVlIQ05E?=
 =?utf-8?B?eVg0QVk1Z2hLdVJsa2F5ZUl1ZzNiZWRtT2NWbFoybHBPcFNmcjFXTEZLbk9W?=
 =?utf-8?B?V2lON0tGZFdzNldkTUlGWVVvMzQ1YkJodnhhbm1oN3lHTm0vODFVR2hDQlUx?=
 =?utf-8?B?RU1TdGYvRXJpcDMyOGQvQVdWcENnNWRRMTgwZVljajJQNTBoRjlyQ3JpOXU1?=
 =?utf-8?B?ZE9rZnNmRFB6Q091dEVSZStRUEFwbm5HTlFqRnV6eENpeUdZV1BlRXJLbEpT?=
 =?utf-8?B?RmZJRzNWMGI1Wmo1TXZCWTRsUnFWV0Uwd1haeGxFaytsUDJtYjJqU1lQYjFN?=
 =?utf-8?B?VGVaN0Nwd3VUSkIyTFUvRHhZdUhtTEZyUVVHTFUvZmxWVWd5azJ0dGhpQmRP?=
 =?utf-8?B?dVFaajF0ZElQd3FNVFVlcFdqRlQxVVRRRkdRb29PVkppazhqQ3hkUEJ5dU91?=
 =?utf-8?B?MlZ2aDRRTTNBUlh0NXZWUlR4QzFVT2IyYzlUR1RUWkpndU15QTY5NTdac0Yr?=
 =?utf-8?B?dU0wb2Z1V2gycHFOYm9hUVQ3bW0zZFpnZ3hjZmtZN2h2N2gyRGsyWmNLbXVl?=
 =?utf-8?B?cCtNa3N0Yy9iZ0N6UzdPM3lNbmdIcm5TMDMvSVJEYmEvejFQWnFNK1JKWWl6?=
 =?utf-8?B?c0QzWW45MDFlMDhsM1F0Rnk0bzkwaFN1N2wvdjJ5Z3hMdWtjNzg5VlU2dTRk?=
 =?utf-8?B?TTJFVXdzN0NjRGc4ZXZwMDhPTlRudGlEZ21GRkdqblBNT2JZUUtoYUtwZmJK?=
 =?utf-8?B?c2tVS1dzaWc5ZFVHWjI1N1prNXZ2eGYvL08xRENXN2pUK2w5Qkk4bWthS3Vn?=
 =?utf-8?B?SzRtSFprSzd6STNvNU10aUVUNlFzeUNjc3dTZFhuT093SjZvc2M5R0tQTmF4?=
 =?utf-8?Q?hcreO1QHAN4+9ZJLgdr7/YI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E85D6CBC1604D4AB8F82B5063C6EB40@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b33e8a48-ce1f-4c3e-f2e1-08da90db71aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 14:15:40.5456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Be1i3QXW91HtaHl8z/i26P+1Q7ph3N2uw4Lp3a8LoJOBFh9YuAWdunZekigCOJ+13lV7APOITUjEHPAwPalkQ61ClQNL6bShsK4mGjm4LUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2282
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA3LzA5LzIwMjIgw6AgMTM6NDQsIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gT24g
VGh1LCBBdWcgMTgsIDIwMjIgYXQgMDM6NTc6NDlQTSArMDIwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+IFNvbWUgY29tcG9uZW50cyByZXF1aXJlIGEgZmV3IGNsb2NrIGN5Y2xlcyB3aXRo
IGNoaXBzZWxlY3Qgb2ZmIGJlZm9yZQ0KPj4gb3IvYW5kIGFmdGVyIHRoZSBkYXRhIHRyYW5zZmVy
IGRvbmUgd2l0aCBDUyBvbi4NCj4+DQo+PiBUeXBpY2FsbHkgSURUIDgwMTAzNCBRVUFEIFBDTSBD
T0RFQyBkYXRhc2hlZXQgc3RhdGVzICJOb3RlICo6IENDTEsNCj4+IHNob3VsZCBoYXZlIG9uZSBj
eWNsZSBiZWZvcmUgQ1MgZ29lcyBsb3csIGFuZCB0d28gY3ljbGVzIGFmdGVyDQo+PiBDUyBnb2Vz
IGhpZ2giLg0KPiANCj4gVGhpcyBkb2Vzbid0IGFwcGx5IGFnYWluc3QgY3VycmVudCBjb2RlLCBw
bGVhc2UgY2hlY2sgYW5kIHJlc2VuZC4NCg0KTG9va3MgbGlrZSBteSBwYXRjaCB3YXMgZnJvbSBi
ZWZvcmUgdGhlIHBlcmNwdSBzdGF0aXN0aWNzLg0KDQpJIGp1c3Qgc2VudCBhIHJlYmFzZWQgcGF0
Y2guDQoNCkNocmlzdG9waGU=
