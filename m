Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A051C46BAB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhLGMJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:09:25 -0500
Received: from mail-sgaapc01on2105.outbound.protection.outlook.com ([40.107.215.105]:46688
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236092AbhLGMJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:09:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IldbjxjWSutVZadJMBDlyvlc5AjpAAm7RUHLFYuYqlk2U9j66WPSxUojgCWuEVX/LyPtmBuCY8PxjLn1L3aQ0TYyxtOekz179OuAeW0ApSQVTEBARbX+11WnZog0WhrEM3YhPRh/hUcGFsVisQrLKhexti5IxZoPOHeHErGu9E4CjQyWyi+ZJYzXA8SDpStn3D+zkG6zPf3FlO/LGFwjFikCfyEzp0VT2C3FWiXbrvsaRzU/sQolJqCPAKVQ4112s/+0IUGSH6FYnAozyFDGusERtdF9QqPj2dsw+zvAwXtOxX66vsTeiTH6FeqVmUseSCzRFx9PbnmzQ/OD4e8Fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K24E7+oqIoFSMeTzuNYwV/eFVz5WX7wTL2pcu+NNPk0=;
 b=PtR1ETTThVmfaYus27Mf+OwlW5wraGaojERfcX+nbvJIKT26kDP2iKqHzaQeEGV7+BAhYtMQsC6yWRpshft6vJemY0PufSB86tqNFQ+UfJJApdACzVPRno3qxGGeMgQWhY363qBXrE3hZNC+BOSL1JDG3BvkYCjuhTC1A2ncaNtT0pc8rMf/vBGbfdzlszvgiEHAgRoUemFVKgCpTdxCmwa0iHd1Eo0taZ5b0Lzz11TJ/pJqe52ZPJ1Gq5fBByUEAyAm+BgyXoKC4Tdp5zFHhGsa4q3Wl0G3pJ3SKDSJoYX4GoIrZw8uXaEByA6yOqvW0r4b0hyuMN/zMG3orgRu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K24E7+oqIoFSMeTzuNYwV/eFVz5WX7wTL2pcu+NNPk0=;
 b=dy5SHsMZuV2blKFRlKAwNbMfkhwi3bD3vCgxVlCdn8KmPI/PDS6xJEQszYTyGgk9rVlmF2yEUB7HsAyxKi3SiyCMyByyb4/vBMxHUbaJK6uf0+VZ2zd4JzB1UIfMrIV2bysaFMXwF885kndM6+XolEL2wqKvQAPXRPFDbRMuHEE=
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by PSAPR06MB4200.apcprd06.prod.outlook.com (2603:1096:301:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 12:05:49 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7%7]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 12:05:49 +0000
From:   =?utf-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
CC:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIHNlY3VyaXR5L3NlbGludXg6IGZpeCBwb3Rl?=
 =?utf-8?Q?ntial_memleak_in_error_branch?=
Thread-Topic: [PATCH v2] security/selinux: fix potential memleak in error
 branch
Thread-Index: AQHX6nGPqxxW7xodYEiiKFfEIQdsmawlLZ0AgAG7t0A=
Date:   Tue, 7 Dec 2021 12:05:49 +0000
Message-ID: <PSAPR06MB4021DF6A6135859C2332E5B9DF6E9@PSAPR06MB4021.apcprd06.prod.outlook.com>
References: <20211206071859.324729-1-bernard@vivo.com>
 <ACUA6gBiE5s2Bz1osLpmUqpi.9.1638781904329.Hmail.bernard@vivo.com.@PENBRnFaWE5zMVF6SGg2S2VrZzc2UGtnVUhrMWE4X2F3QjB4QnFELT1ZOXNIPWNZejVVUUBtYWlsLmdtYWlsLmNvbT4=>
In-Reply-To: <ACUA6gBiE5s2Bz1osLpmUqpi.9.1638781904329.Hmail.bernard@vivo.com.@PENBRnFaWE5zMVF6SGg2S2VrZzc2UGtnVUhrMWE4X2F3QjB4QnFELT1ZOXNIPWNZejVVUUBtYWlsLmdtYWlsLmNvbT4=>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21d6c5b9-a821-4434-02c0-08d9b979e8ea
x-ms-traffictypediagnostic: PSAPR06MB4200:EE_
x-microsoft-antispam-prvs: <PSAPR06MB4200F358DDBCB349836A1EA8DF6E9@PSAPR06MB4200.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oycsvc2A5Ojv27/3fiHRnB74gXPX0Yurd1mmZ763Eu+IxXeVOficTfgIhsYhsVVbtgkxoSiKg+h2L9cuMoyMCFdb6P5bh0e4NoRxFoTcLlxnH7f5uxeOOrWC9GU3S1WxoHnPYXeWw7T+6wg4GdMQxGnAM/pbGjxILMTOdf9IiA0FzNtODsThgr4YZXXN4S/Rt1Ic7duAzdyEsMWo3A0Inzii7NOSC0t5TQKsXYDPhyGh3NWhnTFkeyfVqzPigQyrdOmy7sABPHzebgQ2+OxF0XCwVLXS+7CT11zHnTHKMj4Uh5lrKSUkMdh3ZSOTWnFM49lr/5KiCSo7tmcacH9U8z8K+16UNYa4i5t3MlcpDKnrXUV2ufmxXf6K6B8PjZCEbB+aGKkSnTCtM7/Xsu2iqA4lXtzZVqeNFYxXq75eZQnoKx1o1vC1lYhHFA67EbWjzHR15LDPQNR9SQ4Xz0EYHPM4Je56nt7wqpDkr8zBzwBvbAiw+jYzsncy/1zHub2CjJXpGzVXhBarBipTx205jWGjI1a/0hrKOTv5ckLKd2CXvfKPgtYFsHDraC9WHL5kl028prKgLFFQkSh2Q5y9++KrT8MrizR/Thbnsdp0SWVwWAeUvE3M3NdNaovoyrfbT8B8yv4VtO+wnb1pVSezSWVLWN0CEFRGoFIugEWoxr670goW7Zsu1/XRYJWO9zbaEFL8SmB29igP1ND/pTesLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(83380400001)(54906003)(38070700005)(71200400001)(85182001)(52536014)(316002)(26005)(86362001)(15650500001)(7696005)(6916009)(66476007)(33656002)(76116006)(6506007)(8936002)(53546011)(66556008)(64756008)(66946007)(4326008)(2906002)(508600001)(5660300002)(224303003)(122000001)(38100700002)(66446008)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmgwcGJkL3dpYU9LTk5TMjV6UDM3dnpMcVBldzl1emdBY25mZitvNXlkMVFL?=
 =?utf-8?B?dFNZdEVSZUt3dEZFa20zc0F2dGUzZVUzUG8ybzdrNzd1MFhlNXM4aG82ZEJH?=
 =?utf-8?B?aFRsZ0hiTGRkVmVHNlNobVkyOHhnM2laZnBRSkVEQXZGeng2MVRjcW5BL3lr?=
 =?utf-8?B?cGZ1ZDZQQWJRTmE3S3N0RXJUYXZjK0tCbnBSb1JZR01IejNnUWFOQVV4TnFD?=
 =?utf-8?B?SDU3cjgzR3dOU1VGU2VET2dweWxsMGVtbkhJL2dDUTlaMEZ0WDl5Z2MvbVdv?=
 =?utf-8?B?S1ROb1hZaVZ1NVJnU2lQWjhZbTE0YWcwdk8vRlhJc3VvM0VnRk9HeVM0YVUr?=
 =?utf-8?B?Z0Zka0U2VlREdGlBdCsycXhzdFo4emhJZHJjc3R0VnBJdUo1aDJmcGFqR2R4?=
 =?utf-8?B?cHpDQWkzbE9zWm5HeWdITXM0OHhJV0gxc3NSV2NnbjhlSlBkbUpTbDRMd3hM?=
 =?utf-8?B?UjQvUzdCZUMxbENqWEVBN0V6NlUrV2RIVEloSFo4RWhicWRESVArUU5ZdXQ5?=
 =?utf-8?B?a2xpWFhjZzNNcGtWaWY3c0hmYUl2Vm1HWXlWN29yZFJHcDhXOGxwZnRlQW44?=
 =?utf-8?B?MHJrSHBOKzV6N0I1YnR1ZWY3Y1lCNmZ2Vllrb3NKOU5UT3VVYjVBWTRuRThG?=
 =?utf-8?B?ekNwcjE1eGY5K1NKUVNmUHRHeTkwR2tCcFl5OCtMUFBTVnBvY0c0eEt5MGdm?=
 =?utf-8?B?T1JQUDd5bjg3bVk2ZWEzUXkzQUxRbjYrdkpBZlZmaUZ0MHNJK25DUkNLMU14?=
 =?utf-8?B?NmVXK1B0WUwyWHJMUUlGa0NscGFKdXh4NENSZzRwS2Q3bVBMWUoxVUV4Z3lY?=
 =?utf-8?B?U3lkQ0ZYSnRQdXVibkhJdVQ3cFp0L1p6SFFuZVBxNVhsUTZINVprd3plZ1pD?=
 =?utf-8?B?VUdxNGtWQlY4b3V3K1NaNE94SVVCekhNRks4SG92THlJanlHV0o5STFpL25B?=
 =?utf-8?B?WTdJTzFjMlExMkRsMEp1bDJIZGZOMlRIeGsxVy9lNCszYlgzeDRNSEhyMCth?=
 =?utf-8?B?OXhDNFg4Q2NxWE1md3NTR2Nnd0hxTmFIa0h3K1hmcGZkSE9oUnRyOE9yd3BK?=
 =?utf-8?B?OHNlNWp6YjRxN1c0eitvdHlYZHJtT2FmNWo3bW9XOC9CYVo2U2pCcTBNZS9q?=
 =?utf-8?B?OExxRzc0RzJEbTZRTFgramFNTXpuVnJqRFRIYVFYQkM0QVRWd3lYUDRnQVZ3?=
 =?utf-8?B?bXEvbk5vK1JDMlNJcEorK0xHcXVMQ3pnRjVNS3RDenBOWnZEYnFpeks0ZVYw?=
 =?utf-8?B?UTNMNkE2dE5ZN0VMOTU1aEZSd3R2bzY4MzJxOURTNWpLZGhaMWlDdWJqSnAw?=
 =?utf-8?B?Q3M1L3prenVjWWg0SVBLYlliRmkzY1pHa1dlTTkwNnhtb1pZUUY1LzREWmxJ?=
 =?utf-8?B?RVFvcmRweVU3TEpqWlA1MFJNN0pxNzBLQTBGc0c0eVVJVUZwVWpoMENQUkY3?=
 =?utf-8?B?a013R01uejBKcklYSXNTQWdnYS9HdVJPc1lzbEg0cGRDdVAzRVJDRE9KelNR?=
 =?utf-8?B?MGUrV0ZXMVIySi9GekQrOXRTY2ZvcWsrcUQ3SEFwLzhlZENyWDJTcURXZmYx?=
 =?utf-8?B?MTYvL2Z0NW05V2IxaUozQ2EzUXpUWHZGbUVUZEs3cGtzMUsxejJRU1Q2Qnky?=
 =?utf-8?B?VjhiVHN1TVhoYkNFVG0wTkhFRUEzUlM5L1FQWTI0UVFhL0Y0aEU5UVpUdzMr?=
 =?utf-8?B?TXMrM0JSQTNlUFQ5UCtsM1dRbzNKWFZvcVJ1OWxtaEpvazdueU54QVFaUEVv?=
 =?utf-8?B?SGwydWhRZVlmamZJdXdZRkx4SmNaMGJXNGljVlpZNjZiRGxUT1JsTG40cjMv?=
 =?utf-8?B?cmovYUo3VEQ3UktnaEsyQlFtUEZ5cGtXNk84cjJLVElYTlhPSCtVVmJTQVBO?=
 =?utf-8?B?elV4bkh6Q1BJTGltYi82UzdkcWo3WERWQTBhTnJ3RExVOFA5L1F4Q05DWGxi?=
 =?utf-8?B?UmV3TmZMR2NkWXUzd3JaRDZHcnpSTVpwN1hZY2EvcXQ5NTNPeXBaSFlCZnNZ?=
 =?utf-8?B?ZmhEZWxzYzVQaE9VcTZ3Mit5S2EraGZVL3VDOE0wcWRwNDBXc01nb0FpbnEy?=
 =?utf-8?B?MUd3amhwMS8xK3NOc0Y1WTlNdUNZMmlrS0JENUh0YmRqeVBjWmZ2S2hEOU43?=
 =?utf-8?B?L1dNTDQreVJvNTluWXN3VEJiMXp1TEs5YTk2aUQ3b0VuZUF3bzBDWFVXQWxN?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d6c5b9-a821-4434-02c0-08d9b979e8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 12:05:49.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3tgQgTyRXZhGWF7wmCRTBLIwgLD/m3nEit1zvVqDEOv1VfIPiTIj5glWGB3pz4Y4cXCeQALW/A4JtkpIclZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBiZXJuYXJkQHZpdm8uY29tIDxiZXJu
YXJkQHZpdm8uY29tPiDku6PooaggT25kcmVqIE1vc25hY2VrDQrlj5HpgIHml7bpl7Q6IDIwMjHl
ubQxMuaciDbml6UgMTc6MTENCuaUtuS7tuS6ujog6LW15Yab5aWOIDxiZXJuYXJkQHZpdm8uY29t
Pg0K5oqE6YCBOiBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPjsgU3RlcGhlbiBTbWFs
bGV5IDxzdGVwaGVuLnNtYWxsZXkud29ya0BnbWFpbC5jb20+OyBFcmljIFBhcmlzIDxlcGFyaXNA
cGFyaXNwbGFjZS5vcmc+OyBTRWxpbnV4IGxpc3QgPHNlbGludXhAdmdlci5rZXJuZWwub3JnPjsg
TGludXgga2VybmVsIG1haWxpbmcgbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4N
CuS4u+mimDogUmU6IFtQQVRDSCB2Ml0gc2VjdXJpdHkvc2VsaW51eDogZml4IHBvdGVudGlhbCBt
ZW1sZWFrIGluIGVycm9yIGJyYW5jaA0KDQpPbiBNb24sIERlYyA2LCAyMDIxIGF0IDg6MTkgQU0g
QmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPiB3cm90ZToNCj4gVGhpcyBwYXRjaCB0cnkg
dG8gZml4IHBvdGVudGlhbCBtZW1sZWFrIGluIGVycm9yIGJyYW5jaC4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPg0KPiAtLS0NCj4gIHNlY3VyaXR5
L3NlbGludXgvaG9va3MuYyB8IDEwICsrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9z
ZWxpbnV4L2hvb2tzLmMgYi9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMgaW5kZXggDQo+IDYyZDMw
YzBhMzBjMi4uOGRjMTQwMzk5YTIzIDEwMDY0NA0KPiAtLS0gYS9zZWN1cml0eS9zZWxpbnV4L2hv
b2tzLmMNCj4gKysrIGIvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jDQo+IEBAIC05ODMsMTggKzk4
MywyMiBAQCBzdGF0aWMgaW50IHNlbGludXhfc2JfY2xvbmVfbW50X29wdHMoY29uc3QgDQo+IHN0
cnVjdCBzdXBlcl9ibG9jayAqb2xkc2IsICBzdGF0aWMgaW50IHNlbGludXhfYWRkX29wdChpbnQg
dG9rZW4sIA0KPiBjb25zdCBjaGFyICpzLCB2b2lkICoqbW50X29wdHMpICB7DQo+ICAgICAgICAg
c3RydWN0IHNlbGludXhfbW50X29wdHMgKm9wdHMgPSAqbW50X29wdHM7DQo+ICsgICAgICAgYm9v
bCBpc19hbGxvY19vcHRzID0gZmFsc2U7DQo+DQo+ICAgICAgICAgaWYgKHRva2VuID09IE9wdF9z
ZWNsYWJlbCkgICAgICAvKiBlYXRlbiBhbmQgY29tcGxldGVseSBpZ25vcmVkICovDQo+ICAgICAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4NCj4gKyAgICAgICBpZiAoIXMpDQo+ICsgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT01FTTsNCj4gKw0KPiAgICAgICAgIGlmICghb3B0cykgew0KPiAgICAg
ICAgICAgICAgICAgb3B0cyA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBzZWxpbnV4X21udF9vcHRz
KSwgR0ZQX0tFUk5FTCk7DQo+ICAgICAgICAgICAgICAgICBpZiAoIW9wdHMpDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiAgICAgICAgICAgICAgICAgKm1udF9v
cHRzID0gb3B0czsNCj4gKyAgICAgICAgICAgICAgIGlzX2FsbG9jX29wdHMgPSB0cnVlOw0KPiAg
ICAgICAgIH0NCj4gLSAgICAgICBpZiAoIXMpDQo+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVO
T01FTTsNCj4gKw0KPiAgICAgICAgIHN3aXRjaCAodG9rZW4pIHsNCj4gICAgICAgICBjYXNlIE9w
dF9jb250ZXh0Og0KPiAgICAgICAgICAgICAgICAgaWYgKG9wdHMtPmNvbnRleHQgfHwgb3B0cy0+
ZGVmY29udGV4dCkgQEAgLTEwMTksNiANCj4gKzEwMjMsOCBAQCBzdGF0aWMgaW50IHNlbGludXhf
YWRkX29wdChpbnQgdG9rZW4sIGNvbnN0IGNoYXIgKnMsIHZvaWQgKiptbnRfb3B0cykNCj4gICAg
ICAgICB9DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICBFaW52YWw6DQo+ICsgICAgICAgaWYgKGlz
X2FsbG9jX29wdHMpDQo+ICsgICAgICAgICAgICAgICBrZnJlZShvcHRzKTsNCj4gICAgICAgICBw
cl93YXJuKFNFTF9NT1VOVF9GQUlMX01TRyk7DQo+ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+
ICB9DQo+IC0tDQo+IDIuMzMuMQ0KDQo+VGhlIHByb2JsZW0gaXMgYSBiaXQgbW9yZSB0cmlja3ku
Li4gQXMgaXMsIHRoaXMgcGF0Y2ggd2lsbCBsZWFkIHRvIGRvdWJsZSBmcmVlcyBpbiBzb21lIGNh
c2VzLiBMb29rIGF0IHNlY3VyaXR5X3NiX2VhdF9sc21fb3B0cygpIGNhbGxlcnMsIGZvciBleGFt
cGxlIC0gc29tZSBvZiB0aGVtIGRvbid0IGRvIGFueXRoaW5nIHdoZW4gZXJyb3IgaXMgcmV0dXJu
ZWQsIHNvbWUgY2FsbCANCj5zZWN1cml0eV9mcmVlX21udF9vcHRzKCkgb24gdGhlIG9wdHMgcmVn
YXJkbGVzcywgc29tZSB3aWxsIGxldCBpdCBzdG9yZSB0aGUgb3B0cyBpbiBmYy0+c2VjdXJpdHks
IHdoZXJlDQo+cHV0X2ZzX2NvbnRleHQoKSB3aWxsIGV2ZW50dWFsbHkgY2FsbCBzZWN1cml0eV9m
cmVlX21udF9vcHRzKCkgb24gdGhlbS4NCg0KPllvdSBuZWVkIHRvIGF0IGxlYXN0ICptbnRfb3B0
cyA9IE5VTEwgYWZ0ZXIga2ZyZWUob3B0cyksIGJ1dCBpdCB3b3VsZCBiZSBhbHNvIG5pY2UgdG8g
bWFrZSB0aGUgTFNNIGhvb2sgY2FsbGVycyBtb3JlIGNvbnNpc3RlbnQgaW4gd2hhdCB0aGV5IGRv
IGluIHRoZSBlcnJvciBwYXRoIGFuZCBkb2N1bWVudCB0aGUgZmFjdCB0aGF0ICptbnRfb3B0cyB3
aWxsIGJlIE5VTEwNCj5vbiBlcnJvciBpbiBsc21faG9va3MuaCAoaW4gY2FzZSBvZiB0aGUgc2Jf
ZWF0X2xzbV9vcHRzIGhvb2spLg0KSGkgT25kcmVqIE1vc25hY2VrOg0KDQpUaGFua3MgZm9yIHlv
dXIgY29tbWVudHMhDQpJIGFtIG5vdCBzdXJlIGlmIHRoZXJlIGlzIHNvbWUgZ2FwLCBmb3IgdGhp
cyBwYXJ0ICIgaXQgd291bGQgYmUgYWxzbyBuaWNlIHRvIG1ha2UgdGhlIExTTSBob29rIGNhbGxl
cnMgbW9yZSBjb25zaXN0ZW50IGluIHdoYXQgdGhleSBkbyBpbiB0aGUgZXJyb3IgcGF0aCBhbmQg
ZG9jdW1lbnQgdGhlIGZhY3QgdGhhdCAqbW50X29wdHMgd2lsbCBiZSBOVUxMDQpvbiBlcnJvciBp
biBsc21faG9va3MuaCAoaW4gY2FzZSBvZiB0aGUgc2JfZWF0X2xzbV9vcHRzIGhvb2spIg0KSSBh
bSBub3Qgc3VyZSBpZiB0aGlzIGlzIE9LOiANCjExNiAgICogQHNiX2VhdF9sc21fb3B0czoNCjEx
NyAgICogCUVhdCAoc2NhbiBAb3JpZyBvcHRpb25zKSBhbmQgc2F2ZSB0aGVtIGluIEBtbnRfb3B0
cy4NCjExOCAgICogICAgIElmIGVycm9yIGlzIHJldHVybmVkLCB0aGVuIHRoZSAqbW50X29wdHMg
d2lsbCBiZSBOVUxMLg0KUGxlYXNlIGhlbHAgdG8gZG91YmxlIGNoZWNrLCB0aGFua3MhDQoNCkJS
Ly9CZXJuYXJkDQotLQ0KPk9uZHJlaiBNb3NuYWNlaw0KPlNvZnR3YXJlIEVuZ2luZWVyLCBMaW51
eCBTZWN1cml0eSAtIFNFTGludXgga2VybmVsIFJlZCBIYXQsIEluYy4NCg0K
