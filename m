Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6045B4C00BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiBVR7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiBVR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:59:00 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120053.outbound.protection.outlook.com [40.107.12.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C447917185D;
        Tue, 22 Feb 2022 09:58:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwADSGHFRP+fGXFIq7uXGlerLSn6+/63MC4tMwDHLL/UkQXN1zaaO4Pdcmc/HCH/B5DP3UwlO7Smioh2ttN0Y/jgTn17GfLs3fKRhPYogNRBaLVY3r8xT4wojMTWppaFN8jSg4sjQPDeK7A2X1j2Z6r8uUa0m9zvNLFcX/ZZV2GNyGryFG1bxIX+JYjj3o2QETVwYo2Yl9BjKkDdAgZhW/nHNCVZ8snDWkSA6puWPlU+07yOPfGRKaobDRhbxAzhZcpejvVFBDK3/ESWiKrm50VDLoZgSPQwShJDXv1oirq50LKsgysj+qR2EtXk83sqyzIkFtfSaKquLAOkttmc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUB/nN3naxVcBJOYljVeYRTfIMuOk1o4s5S8DDhmiOA=;
 b=bBjjLq7w0SZ3IRmDzdIItmEmimRE5u1u7VqrPnWk7kFzc2PFUvl8kFtaEH2ie+wLKtTA5Yrpujmmvo5OZBqmVFUQZbU0mTSNOHXyahgeYSF6Mt+wS1GWMkJZhF/J6gUnq26DcnOyWrPqcw0VzQ/GmbRvw+Pv4I7amY8nVkmvZpvJfPyP9Rky4gZYH7ARGGXNbsH5LiqjieSnNm7W4fYshRNbUO+S/+kGr365vJcQaNSqRqMEpdh7HA1Bwf0WPeUoeRlJPem+NBfR3recolpkkbzL/v3jM/nA3lBjZkq6dNM9T805fULzMXGmFn63Ka1MBLobLE3TPzhgndCM+pnh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3442.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:26::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 17:58:31 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 17:58:31 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v8 02/13] module: Simple refactor in preparation for split
Thread-Topic: [PATCH v8 02/13] module: Simple refactor in preparation for
 split
Thread-Index: AQHYJ/ZTQttAsW+A00ePIvbeGZp2Jayf26wA
Date:   Tue, 22 Feb 2022 17:58:31 +0000
Message-ID: <df2eb4a4-36e5-a656-b127-1ab5591b6981@csgroup.eu>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-3-atomlin@redhat.com>
In-Reply-To: <20220222141303.1392190-3-atomlin@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d388c95-378e-4155-206a-08d9f62cefc3
x-ms-traffictypediagnostic: MR1P264MB3442:EE_
x-microsoft-antispam-prvs: <MR1P264MB34425E8CD82E9851A3544B69ED3B9@MR1P264MB3442.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FCk0GpvOoCy/mJ4i9JjDytN1OcV7MlggeLh2gjcAZ3cWfxb6SXmky3UC1HXzkMU31R5HUpd1xXmPpLMBNPwDbXwp76ygaJV9mS+nVpGE9dthZb3WcEIT53/oJUI00SKoyPY34kfIsUtUgd8VVGwg8EZBqmPh/sJWrHpMVvZ09jTOA9llcZ4kc9ULQ68MpPalzU02W4fYRlekAi3JpfxhbRllh5iTM6etD4xKgnWxOhCGN81X7/I1RDc+LB1Bv5pgvMIHR1SiE51slzz6OQIK6a7eqrm/m25pqjNmzhInA/YUsQYrnOraUM8FlKVTBsba/WSHLKJpVFqUG7nUh5/G97Ye9q7AybW4q7qf6ph0ziyDugLRJy6WVwMSjwtCo4wsOoeTZLk65p3QC+6WGMp4PioA+Zg29XLkqDmAVnXvXG4pgEApJfR5nXiFF1DyDoFrOiRbYkubzFQ5wfZsko1tCXb+8usfEsNa20j3fUILSTHFqd2koyIjk/1GdprtNvEx4x+ghQ6sdwgaN+1l8gx5YOyLiA3iZtjl74KIkfFUUNSoBLlfjb7Z3ZzcNCWbZZHA/4ary+UyLZgU77nNWU4coUFLl8oEtp3E5Pua0WU8jWVoY55ZejAi08dohMv+GRV8Qs6IQ+JTr/NU5c/kdXq93AlLbB9uFh7u6aGX0b+FljxcxXRvZG4bU5PCVNjAiupxeEQzaCZph/1v3aY8aesu8E4wgF+Nhr5fz0fSg6I3owPsw8FLieWtQPmBduqVMOi2xxbt6FY0VfgFgk6WztmwLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7416002)(508600001)(6486002)(91956017)(66574015)(66946007)(76116006)(86362001)(66556008)(4326008)(64756008)(31696002)(8676002)(66446008)(316002)(8936002)(71200400001)(44832011)(66476007)(186003)(26005)(38100700002)(36756003)(122000001)(38070700005)(2906002)(2616005)(31686004)(110136005)(6512007)(54906003)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWk5T2YwOEh0RVFBN0F5SWdFaHQ4c0tOdzczRlYrMFhDWktFREszakhYWEpW?=
 =?utf-8?B?RGl6dW5Oayt5T3UvRmVrMXd5ZWJwTTdnWnEwelhDTkhJR0RqNmtwS055T2pZ?=
 =?utf-8?B?MjJ4aXN4b0xrcWpFUk5QcGRINXlicTJZU2tnVzJldUUvM0xWdmZmN3U3WGFm?=
 =?utf-8?B?UWhZa0wwUWJzTkpGS3pFYU16T29veHFHbWZ2UlJnaWlrLzBBSkJMeENRTGpx?=
 =?utf-8?B?TU0yT0VUZVh1dmxIdE8wcFUxVGxwOXRzbEh1aVRtczBZVVg4OGZRK3JtNCtq?=
 =?utf-8?B?Ym1UNlN5ME96NUd5MWRZRVZjNmV2TmhOOURsMGxNUG5seVpKTU5YakNyMjFD?=
 =?utf-8?B?RmZUTlZJZkh2eXg5bUM2RUJNdFplYzRPMlR6b0lSOWgxaDRKWGtLaFYvRXFu?=
 =?utf-8?B?MmM5a1ErVHFJTlNWalpVVjc5L3RwaDVIaDNCQWJERWxNaFUwMnJqR1pYT1lL?=
 =?utf-8?B?RlRteGxZdVUzMUtHTS91SnpBbk1Ma3U4ZzdGM3I1Q1g2L3JkeWpobzROUTdz?=
 =?utf-8?B?U3pEWExwWVZVZzh4MHNsM2ovYzVOTndUeW1IWiszUWJDelgybW8xYmtGUXdB?=
 =?utf-8?B?MHlWZURxZ0lJVmg4OHFGZDNOc1ZvTkxJbjcvSjVUd3JJeVl3N0Fld1M5SEp4?=
 =?utf-8?B?TXRUcXJyTG11OVZZQkFJYUo3WFBSanJROGp3dFJyd0Y5TmMxVFNlN1grTjNG?=
 =?utf-8?B?cnBjSjg1OWQ2Q3Q5V1ZrYXhlbUxEbG50emhNYXJ0Ums3dEwwdnA1emN6NXIv?=
 =?utf-8?B?S2NVZkFZUVNwWWtuLythSzhPMHlGaFRyRGQ3dG1yUVprVHhpeGdEcU9tYjR0?=
 =?utf-8?B?UnNySjlGUWxSR2xqcTZublpPQzNXM0F2cnlESkJjQU1HK1lQbitxMEFXZzRq?=
 =?utf-8?B?bTdWWm9SMnVYVzFyWkhJb3hMbEdJZ1ZkWDVyV3hpRVFaR0h4bDU2b1I1Njda?=
 =?utf-8?B?K3Q3WWZ3NS9CKzJ0c0RqMVRpeEdzMWFpaUtoYmpoQzNtUk42eUNreUYyZ2lS?=
 =?utf-8?B?TkNwWmNiTEdYTllaUUp3WDQ1WkM4V3lwYkthZU1NQmNKNWREQmM2bi9rRVcy?=
 =?utf-8?B?MkZkdS9jMHA5MmRPRWt5dzZFRFJwQVJwY0JIRDJFZkZ2Sk5hdW1iV2syWjk5?=
 =?utf-8?B?K1dzQ3hvdm5kM0Mzc0ZNSWh5TEoyOUNhNng1VjhoV3NpREh6RC9RdlRLM1FE?=
 =?utf-8?B?a1MxUjZHZzFkeHZWNjNVR1poWVVzZldkd2JTdVE3MW8vMXJ1SklrMGhRU3Ru?=
 =?utf-8?B?aUoyWWlrZ2VRN1ZKWDk1KzNuaEkxZUVJZHBVdnNQYm5xRFZJamw3aUNNTVFX?=
 =?utf-8?B?VWs5VGJ2WUxQMmRTNU5UL055T29WczlYRnJoTWxXbUhjSklNSmltaldhTlJM?=
 =?utf-8?B?TCtFMkptamw3MVB5bzdkeXdJUEI3NkwwbWsxUWdDckI0Q1A3aWVkV2VzcnFI?=
 =?utf-8?B?RmNsZXNIb3pyTWZ2Vld5bFdCc3FvV050Rnpjcm5kT3Vzb25ZRGh6ZzZhWkpa?=
 =?utf-8?B?NTVvWEl0TkZ4allrSzlKZWpPWEQ2diszTUc0UnJ4Ukh3SXFsY0pyRUgyOWFE?=
 =?utf-8?B?dzFqZ1Bmc0VBN1RXNVRIZWl5SGk2d3l4b1hUM0NoOGc2T29waXFjVzMwYTZr?=
 =?utf-8?B?SE8zZ1V0SEJDdFllcHpUem1PYUM1UnMvdCtxOGhIZ2dIaWRETXg3a3ZabmxR?=
 =?utf-8?B?U1lDanRnK2xETmFXZ25IQ1g5WEh4V3pUTmVOaFlIM2pHOFJOSmtTLzczNCsy?=
 =?utf-8?B?VDR5VVdGVXVsL0ZuRm02NFpXd0pGcTJVMmRQR2dZMkowRHd3OFZGYWhqSHZQ?=
 =?utf-8?B?eHlZb29yTTBjN2VEbTdZSHVDTXp3K1VTWTUxcEVRdnRpdEZTUlBPOG1xRnhL?=
 =?utf-8?B?OHZTK3I2Wk5XYnFNa3JxcXhZeW54V3FDT2J1ajZ2VGxUNnRqbWVRTUFEc1lm?=
 =?utf-8?B?SkNaeU5oUTgrQUsvS0ZGZDE3YUNLZmE3YlZHbXlZREhkWmRIcGIwbVE4YUJZ?=
 =?utf-8?B?SFZzWERCV2dJSXhNZ2x2SUIvUnV6Q1RqdTdSZnBKRzc1V0xFMnhCNDFkZVNC?=
 =?utf-8?B?Z0NnYUZydzc4WUM1ZDl1R0dteml1U1o5SzlGaXdqRHlwVGJ2TG1lVEZyTTdp?=
 =?utf-8?B?Mm1FaDYvYTdDdjF6a0pZbmZlRG4wR0pseHhoOHZremFsUHlLQWJqUVNzZDYz?=
 =?utf-8?B?Q2tzVktrNHcrblFleFJrT2hGOWdnakpRdFJKRGV5THg4OGwvWkNlODVTUkdE?=
 =?utf-8?Q?XbxBhXdyd5nLcsDkJxmx4gkuDthN4Cb/XZVVzXe1PY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0038A705E77F9A49AA9DB15F78671C45@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d388c95-378e-4155-206a-08d9f62cefc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 17:58:31.0234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItHPjJCwWX1C3MPe93V0YnsidSLwhZIxMB3sQJYKC1usXrVQZC7LJ3LAtuHhe93H3i6H9veA1roWGG0OdhcXoyo/xwpmOcVok2MXzqtQ8rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3442
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIyLzAyLzIwMjIgw6AgMTU6MTIsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBO
byBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFRoaXMgcGF0Y2ggbWFrZXMgaXQgcG9zc2libGUg
dG8gbW92ZSBub24tZXNzZW50aWFsIGNvZGUNCj4gb3V0IG9mIGNvcmUgbW9kdWxlIGNvZGUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBYXJvbiBUb21saW4gPGF0b21saW5AcmVkaGF0LmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5l
dT4NCg0KPiAtLS0NCj4gICBrZXJuZWwvbW9kdWxlL2ludGVybmFsLmggfCAyMSArKysrKysrKysr
KysrKysrKysrKysNCj4gICBrZXJuZWwvbW9kdWxlL21haW4uYyAgICAgfCAyMiArKy0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyMCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL2ludGVybmFsLmgg
Yi9rZXJuZWwvbW9kdWxlL2ludGVybmFsLmgNCj4gaW5kZXggOGMzODFjOTkwNjJmLi5lYThjNGMw
MjYxNGMgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9tb2R1bGUvaW50ZXJuYWwuaA0KPiArKysgYi9r
ZXJuZWwvbW9kdWxlL2ludGVybmFsLmgNCj4gQEAgLTcsNiArNywyNyBAQA0KPiAgIA0KPiAgICNp
bmNsdWRlIDxsaW51eC9lbGYuaD4NCj4gICAjaW5jbHVkZSA8YXNtL21vZHVsZS5oPg0KPiArI2lu
Y2x1ZGUgPGxpbnV4L211dGV4Lmg+DQo+ICsNCj4gKyNpZm5kZWYgQVJDSF9TSEZfU01BTEwNCj4g
KyNkZWZpbmUgQVJDSF9TSEZfU01BTEwgMA0KPiArI2VuZGlmDQo+ICsNCj4gKy8qIElmIHRoaXMg
aXMgc2V0LCB0aGUgc2VjdGlvbiBiZWxvbmdzIGluIHRoZSBpbml0IHBhcnQgb2YgdGhlIG1vZHVs
ZSAqLw0KPiArI2RlZmluZSBJTklUX09GRlNFVF9NQVNLICgxVUwgPDwgKEJJVFNfUEVSX0xPTkcg
LSAxKSkNCj4gKy8qIE1heGltdW0gbnVtYmVyIG9mIGNoYXJhY3RlcnMgd3JpdHRlbiBieSBtb2R1
bGVfZmxhZ3MoKSAqLw0KPiArI2RlZmluZSBNT0RVTEVfRkxBR1NfQlVGX1NJWkUgKFRBSU5UX0ZM
QUdTX0NPVU5UICsgNCkNCj4gKw0KPiArZXh0ZXJuIHN0cnVjdCBtdXRleCBtb2R1bGVfbXV0ZXg7
DQo+ICtleHRlcm4gc3RydWN0IGxpc3RfaGVhZCBtb2R1bGVzOw0KPiArDQo+ICsvKiBQcm92aWRl
ZCBieSB0aGUgbGlua2VyICovDQo+ICtleHRlcm4gY29uc3Qgc3RydWN0IGtlcm5lbF9zeW1ib2wg
X19zdGFydF9fX2tzeW10YWJbXTsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3Qga2VybmVsX3N5bWJv
bCBfX3N0b3BfX19rc3ltdGFiW107DQo+ICtleHRlcm4gY29uc3Qgc3RydWN0IGtlcm5lbF9zeW1i
b2wgX19zdGFydF9fX2tzeW10YWJfZ3BsW107DQo+ICtleHRlcm4gY29uc3Qgc3RydWN0IGtlcm5l
bF9zeW1ib2wgX19zdG9wX19fa3N5bXRhYl9ncGxbXTsNCj4gK2V4dGVybiBjb25zdCBzMzIgX19z
dGFydF9fX2tjcmN0YWJbXTsNCj4gK2V4dGVybiBjb25zdCBzMzIgX19zdGFydF9fX2tjcmN0YWJf
Z3BsW107DQo+ICAgDQo+ICAgc3RydWN0IGxvYWRfaW5mbyB7DQo+ICAgCWNvbnN0IGNoYXIgKm5h
bWU7DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL21haW4uYyBiL2tlcm5lbC9tb2R1bGUv
bWFpbi5jDQo+IGluZGV4IDM0YTJiMGNmM2MzZS4uNWY1ZTIxZjk3MmRkIDEwMDY0NA0KPiAtLS0g
YS9rZXJuZWwvbW9kdWxlL21haW4uYw0KPiArKysgYi9rZXJuZWwvbW9kdWxlL21haW4uYw0KPiBA
QCAtNjMsMTAgKzYzLDYgQEANCj4gICAjZGVmaW5lIENSRUFURV9UUkFDRV9QT0lOVFMNCj4gICAj
aW5jbHVkZSA8dHJhY2UvZXZlbnRzL21vZHVsZS5oPg0KPiAgIA0KPiAtI2lmbmRlZiBBUkNIX1NI
Rl9TTUFMTA0KPiAtI2RlZmluZSBBUkNIX1NIRl9TTUFMTCAwDQo+IC0jZW5kaWYNCj4gLQ0KPiAg
IC8qDQo+ICAgICogTW9kdWxlcycgc2VjdGlvbnMgd2lsbCBiZSBhbGlnbmVkIG9uIHBhZ2UgYm91
bmRhcmllcw0KPiAgICAqIHRvIGVuc3VyZSBjb21wbGV0ZSBzZXBhcmF0aW9uIG9mIGNvZGUgYW5k
IGRhdGEsIGJ1dA0KPiBAQCAtNzgsOSArNzQsNiBAQA0KPiAgICMgZGVmaW5lIGRlYnVnX2FsaWdu
KFgpIChYKQ0KPiAgICNlbmRpZg0KPiAgIA0KPiAtLyogSWYgdGhpcyBpcyBzZXQsIHRoZSBzZWN0
aW9uIGJlbG9uZ3MgaW4gdGhlIGluaXQgcGFydCBvZiB0aGUgbW9kdWxlICovDQo+IC0jZGVmaW5l
IElOSVRfT0ZGU0VUX01BU0sgKDFVTCA8PCAoQklUU19QRVJfTE9ORy0xKSkNCj4gLQ0KPiAgIC8q
DQo+ICAgICogTXV0ZXggcHJvdGVjdHM6DQo+ICAgICogMSkgTGlzdCBvZiBtb2R1bGVzIChhbHNv
IHNhZmVseSByZWFkYWJsZSB3aXRoIHByZWVtcHRfZGlzYWJsZSksDQo+IEBAIC04OCw4ICs4MSw4
IEBADQo+ICAgICogMykgbW9kdWxlX2FkZHJfbWluL21vZHVsZV9hZGRyX21heC4NCj4gICAgKiAo
ZGVsZXRlIGFuZCBhZGQgdXNlcyBSQ1UgbGlzdCBvcGVyYXRpb25zKS4NCj4gICAgKi8NCj4gLXN0
YXRpYyBERUZJTkVfTVVURVgobW9kdWxlX211dGV4KTsNCj4gLXN0YXRpYyBMSVNUX0hFQUQobW9k
dWxlcyk7DQo+ICtERUZJTkVfTVVURVgobW9kdWxlX211dGV4KTsNCj4gK0xJU1RfSEVBRChtb2R1
bGVzKTsNCj4gICANCj4gICAvKiBXb3JrIHF1ZXVlIGZvciBmcmVlaW5nIGluaXQgc2VjdGlvbnMg
aW4gc3VjY2VzcyBjYXNlICovDQo+ICAgc3RhdGljIHZvaWQgZG9fZnJlZV9pbml0KHN0cnVjdCB3
b3JrX3N0cnVjdCAqdyk7DQo+IEBAIC00MDgsMTQgKzQwMSw2IEBAIHN0YXRpYyBfX21heWJlX3Vu
dXNlZCB2b2lkICphbnlfc2VjdGlvbl9vYmpzKGNvbnN0IHN0cnVjdCBsb2FkX2luZm8gKmluZm8s
DQo+ICAgCXJldHVybiAodm9pZCAqKWluZm8tPnNlY2hkcnNbc2VjXS5zaF9hZGRyOw0KPiAgIH0N
Cj4gICANCj4gLS8qIFByb3ZpZGVkIGJ5IHRoZSBsaW5rZXIgKi8NCj4gLWV4dGVybiBjb25zdCBz
dHJ1Y3Qga2VybmVsX3N5bWJvbCBfX3N0YXJ0X19fa3N5bXRhYltdOw0KPiAtZXh0ZXJuIGNvbnN0
IHN0cnVjdCBrZXJuZWxfc3ltYm9sIF9fc3RvcF9fX2tzeW10YWJbXTsNCj4gLWV4dGVybiBjb25z
dCBzdHJ1Y3Qga2VybmVsX3N5bWJvbCBfX3N0YXJ0X19fa3N5bXRhYl9ncGxbXTsNCj4gLWV4dGVy
biBjb25zdCBzdHJ1Y3Qga2VybmVsX3N5bWJvbCBfX3N0b3BfX19rc3ltdGFiX2dwbFtdOw0KPiAt
ZXh0ZXJuIGNvbnN0IHMzMiBfX3N0YXJ0X19fa2NyY3RhYltdOw0KPiAtZXh0ZXJuIGNvbnN0IHMz
MiBfX3N0YXJ0X19fa2NyY3RhYl9ncGxbXTsNCj4gLQ0KPiAgICNpZm5kZWYgQ09ORklHX01PRFZF
UlNJT05TDQo+ICAgI2RlZmluZSBzeW12ZXJzaW9uKGJhc2UsIGlkeCkgTlVMTA0KPiAgICNlbHNl
DQo+IEBAIC00NTQyLDkgKzQ1MjcsNiBAQCBzdGF0aWMgdm9pZCBjZmlfY2xlYW51cChzdHJ1Y3Qg
bW9kdWxlICptb2QpDQo+ICAgI2VuZGlmDQo+ICAgfQ0KPiAgIA0KPiAtLyogTWF4aW11bSBudW1i
ZXIgb2YgY2hhcmFjdGVycyB3cml0dGVuIGJ5IG1vZHVsZV9mbGFncygpICovDQo+IC0jZGVmaW5l
IE1PRFVMRV9GTEFHU19CVUZfU0laRSAoVEFJTlRfRkxBR1NfQ09VTlQgKyA0KQ0KPiAtDQo+ICAg
LyogS2VlcCBpbiBzeW5jIHdpdGggTU9EVUxFX0ZMQUdTX0JVRl9TSVpFICEhISAqLw0KPiAgIHN0
YXRpYyBjaGFyICptb2R1bGVfZmxhZ3Moc3RydWN0IG1vZHVsZSAqbW9kLCBjaGFyICpidWYpDQo+
ICAgew==
