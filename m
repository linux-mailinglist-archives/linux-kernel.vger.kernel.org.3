Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB44C00BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiBVR6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiBVR6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:58:50 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90080.outbound.protection.outlook.com [40.107.9.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793CF171282;
        Tue, 22 Feb 2022 09:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtbEAzBBppBvaeN6eteyrINO3pCgjtf1UWTugbnCbhtmF5b1D1RIJngB6/hek5J5lGFLc24zDwsMUKu2FNCTsrAQe55TXmTRYgg0+WqN1fdpvTHEUcAXO9T4jB0liHt+PRBDkpqjdTknFrbF6LjN70s2U3xvuBxjaf39icRg1ycL1hrzroQqWNejSk63Y9jOYBxEdJrpPnXJNnmW1l74hr86PvlBXEvi7OZqXa0Vcv0abTKr280v6hVp/97BajHlPMTnE8OxIaS0FejeQJy0nBFRGEnq2fJFmYJPurtefsshqAQrBt28blOcK498+A/zdxDgihngyCsQdyyalp+C8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pMgN14MPELzVJEphIm4ujS0imHXaJclMiHAmmLeKzc=;
 b=Mc3lvpa3TTXNeUVaPtyx2jXecOWavZGxycirJfDdH3cuyHChr3npKuNKBo2uWZu2MzYwBPTzP0z0+8mFA0JrSyfJ644sXSDgI1CdU37C8NBbRZqbi2UWHQ9Jb2VqKFvjxz3ZU32ETFnLYKJLCzW8Eu4SAxZOCdjnNuPgafwPSVC8vt/BMp58Ai9z8YXa/NT5Gls0UG9M7XoQW3QTCXMm3zQVjm7cX7wgWR0AXfgGIGRYdNzxgwN84nq1NNI17P5Vn1IJHb9Xi1bP+FdITCfqFyE3ODz6kiFglqjYvfRLhtJrxMNYrw0hr0XZVY5ApzJUD1xjhXZdLeVBv9QbCOjdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3442.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:26::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 17:58:21 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 17:58:21 +0000
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
Subject: Re: [PATCH v8 01/13] module: Move all into module/
Thread-Topic: [PATCH v8 01/13] module: Move all into module/
Thread-Index: AQHYJ/ZS06ClwkPtikKRORcRq6MYYayf26AA
Date:   Tue, 22 Feb 2022 17:58:21 +0000
Message-ID: <06f5693f-9820-41ab-f1ff-0fa13d3037b4@csgroup.eu>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-2-atomlin@redhat.com>
In-Reply-To: <20220222141303.1392190-2-atomlin@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 456d984c-2d4b-41be-7ca6-08d9f62ce9fc
x-ms-traffictypediagnostic: MR1P264MB3442:EE_
x-microsoft-antispam-prvs: <MR1P264MB3442AD8B04B17D86CB9F48F6ED3B9@MR1P264MB3442.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8GLQitGRu/F8XelLUlSlI+CaT4EEeY6b80ckOAFUjRPqyDD7msW67oTf+XWaQzCqvkKwawNeq1TCKWi28BcvEkAu2KXWCX6ivCbhu0GwyURnVhJsHITqbNWSSxaHdF6Kt2Dna+ZDj02HBqRfIZSkRJ+laNaSKZ/7bsk7Cj9O8wQz4OA9F+BRiFgli1Pi2/P6IAryS9M/iRjIDDWOKFPjSX78MJiw9NqlXdqIOX9TgwHB/XxWByOFDxQV08e5hOaXK3pX6WCstWZlyvo6EvxlUkGHma9lfHeTz6gh6PgQIAsOvMiwjnXP/6CLl6Rr+z1oNMH1mlH1WiqSOePtyZLXh/gl79WTsnnvh1axlTTzAI7axgEhtVpmMzIpfxNALCBA+ChIle6GL/lgKYXF7LC/T228EjLNrYw+vHZvBaeuDi6Swdo2PceHfOz+rE7NeWWfF63+Hw85xfMfLRdESVJ7abvwiSwe7iEvGyci5Uqy0tWMUSMc7HqFkH0J5P9L+nlu+QeQibB1r0CPrlQLiX/oMALJktKOa8ojX6+/oEMTcFfMDRL6I4cU7kvGHa3SeKfqM+sJMJqjGNmGHXLYM+hvzrwP80kuNdJ+C/Wq485hMecO0KesjQxI7b8wPgT/hziYYxWkU7ZTOb91/02Y2ODLqPpwsDHIZtq43tImni8SQp4a+HmqJve95A14pi7HgXYGBfx/7B95PO2Q6p5mFIpUo+nKo4WVjE2xt9FtltfezT4DLU2lX/SjiTwwi5inIRAzHg747ZbixU27u/jAVxY0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7416002)(508600001)(6486002)(91956017)(66574015)(66946007)(76116006)(86362001)(66556008)(4326008)(64756008)(31696002)(8676002)(66446008)(316002)(8936002)(71200400001)(44832011)(66476007)(186003)(26005)(38100700002)(36756003)(122000001)(38070700005)(2906002)(2616005)(31686004)(110136005)(6512007)(54906003)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2NNdmpDeUk2ODFWYzNudEZSTXZxbDFIWGhRalVwcHd0d0lDeXI5a3QyWktG?=
 =?utf-8?B?c0swMVBFa2paUUN4SWVxVThDeWRsclRiWC9xTTFqN1RVNjlNbGJOUVgwVjhR?=
 =?utf-8?B?MDZVdW1laUxFYUdvNkdramdsajgzRlBRR3Nyek02Y1g0UVRuSzlXaktESFF4?=
 =?utf-8?B?QUkweGFVc1JxanJrankwRU9yOWwzQWl2c1E2akpzVWU0Ymo1UEFGL2RKSUdr?=
 =?utf-8?B?SWJuN0FneDV3akl5QVpRMm4zckNwQnR0VzN6ODc4RlhUaWZJTzFKaUFjZnNV?=
 =?utf-8?B?elgrOThIOUtOTk0vams5N0NPRXVTbE0vZVhKUVhkOXhOdVZ3MW8veDlyakN1?=
 =?utf-8?B?MXUwNmRxOXhDY2dJTlprbEs5emF2QkJtTUF1MmMycTZXSGNDNkt5K1NLSGc5?=
 =?utf-8?B?SXhoVEJHR1M4dlRFbCtlLzlXb2JrOFhZekliQWtsaXNQZWpWbjQyenZlTWJr?=
 =?utf-8?B?SFZ6TFhRQ0lGNDFrTUVQRXltbHp0dlprT1k5bGJLMW9obzR6ZWJuaEUrTlhE?=
 =?utf-8?B?R0V5ZW1WUy9KbkNtSThSY2JBY3E0cHdMR2lwMUQxVGppTE8wMjdsQldSdEtI?=
 =?utf-8?B?WVgrOXlCbUloWVp4NCtLdnNITEZVU2ZadTF0d3NvUGlOd1l4VzZmdklOU2Vl?=
 =?utf-8?B?VjNaSDBhc1NValdGS05wcFpxYWlpalJEV3lDcHFmYVRHWWZwSmErU0lSL0NL?=
 =?utf-8?B?N3g1OVA3VGtua1RYUEdMQUNURHZjTWRabVNEZGxoM1RNRVZqQ01KTjBoYWor?=
 =?utf-8?B?cTloWjNZRDdEcVZJQTdGTU5SUkRHYWFEQm1pRFdtTDR2Um1PYy8yWThSMzFz?=
 =?utf-8?B?dWV4dUlvSG1IUTRPRnRZOVFHVmxJaUdNczh3K0MvNkdiMms2OHhqVlI2NTNa?=
 =?utf-8?B?dyt0Y2xWYkRlQXBYMTROZkdRTjd2dFQyRkVsNlBkSmJka0U1bHdEdWZPdzJQ?=
 =?utf-8?B?N0NZY1RVM1cweWF6VDRFaWVuaTY3QmFvN0JYc2R4NVBBeWhPSmp3V3FKTzA1?=
 =?utf-8?B?d082dHdxM21OSFd0TVAxUno3dEZtcFdsSTIraHhUOE8yeDU5OVZyVi9ubTJm?=
 =?utf-8?B?VUhiYVlRMEFibk9PNW0zYnJHbXFtSnJwbHJxN2xIbVZxWDNrbmdqdWlxQjlq?=
 =?utf-8?B?VVlYZmgxQ2VIRFpIQnFZaEhQSTFsS1AwanN1ZHFJb0tsYVY1WE5DR3c2RHky?=
 =?utf-8?B?WGFjSk1SYnd3cG5XNmF1VE5ndWpsdFVmVGNUS2FMN0NqNTNQaGFqMW9oRXJR?=
 =?utf-8?B?RXVDeTFNMEU2WWt4dEV3Yk9kL1IvR3k2VlpzdzBvRzNZdEZNMndvb1h3TVFO?=
 =?utf-8?B?eHhJUXZKWTBkSXE1a1FFMjIvU1IwOGhnS3l5Q1FXbHNvTm9ncXRzVld0NVpL?=
 =?utf-8?B?UHlZMWhLeWtBTGIxWmhZM3dnWFhYOUhDeVFRN2ExT0hCdklYbCtNaEQrbDBp?=
 =?utf-8?B?NFRuenc1cTRBWVA3cDR3OFZnbFRpZmxjZVptY0V3RmVjaWhoYUwvTUZhRmRQ?=
 =?utf-8?B?bmZraHJBVlZHTDhLUzlpU0V6V3VneE5PUjdFRG9JT213RHJVaFZTMVdEYU9S?=
 =?utf-8?B?c2UwdklUTHNUWnRCTkZLdzkxa1E0bWNLM0tMNklEb1VGWTVEakx3NUVtdm03?=
 =?utf-8?B?UWdmSXNrbG93VCtjVDJyb2VIa0dXK0kybFk2cEFjTFdsYnlPRTFjY0hPY0RB?=
 =?utf-8?B?ZHl0THFwL01tUnBGL1VpNXpuQ1lhM3dYcWNNODBZNitMelMwdzFFVjg0MWxJ?=
 =?utf-8?B?U2krYStwMFErZGZDQmc1WDBSNVN3cFRiUFdyT2VQSUNaK2NqSGJJL3VXR3B1?=
 =?utf-8?B?WnBtblhvVVJ1cERZUzlnaWloMjBST3hyOVMvQUdUZm8wZTFxQkIzZVBFT3pJ?=
 =?utf-8?B?Z1RWd2dFNURuUS9IbDg5Mk1mOHRLUDFZU1pKdGFvekxEMHZOZEdqd0lRQlFW?=
 =?utf-8?B?a2doYythREdDajR1RHBUOVhVbHlmM2NSeHJvb2t2QjArM1hVZlhGd2lQekNX?=
 =?utf-8?B?S2Mxb2ZxNVJmSTNvYXU3eUdPYktSZkYvTTk0NUh3RUJKOUNOdFBMZ3IrajBR?=
 =?utf-8?B?SG9STFp3YXZDZmFvNkx2SitvOFZtNVFLUUg5WXZiNUtIaHpHNHMvNlk0eWc2?=
 =?utf-8?B?YkFKZG51YlZvb0NKS2ZtVWtUMkc4RDhQZUVaRWhtbDZIcmRSQndGVkhOaW9x?=
 =?utf-8?B?aHNUUFBYUVNNSGF5eVlhaWlTSURDTzVnRW12YjBuN0dmaTkza0dmeW0vaTBC?=
 =?utf-8?Q?KBvvcRLUuIB88PcwCfLyaW6eZM9kN1K5cQ/AmGrNn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3629F9B46E725D4F84EC161A043E5C61@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 456d984c-2d4b-41be-7ca6-08d9f62ce9fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 17:58:21.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjFYupDf14iUyAIst13E2L4c9niBX56mUnGhEtWkNbvChYkXfMPFXnCZwaMuikkwaNtDymGpBK083Lljji2ElyOop4MisagIy1S6Zg4SrKc=
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
byBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+IA0KPiBUaGlzIHBhdGNoIG1vdmVzIGFsbCBtb2R1bGUg
cmVsYXRlZCBjb2RlIGludG8gYSBzZXBhcmF0ZSBkaXJlY3RvcnksDQo+IG1vZGlmaWVzIGVhY2gg
ZmlsZSBuYW1lIGFuZCBjcmVhdGVzIGEgbmV3IE1ha2VmaWxlLiBOb3RlOiB0aGlzIGVmZm9ydA0K
PiBpcyBpbiBwcmVwYXJhdGlvbiB0byByZWZhY3RvciBjb3JlIG1vZHVsZSBjb2RlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQWFyb24gVG9tbGluIDxhdG9tbGluQHJlZGhhdC5jb20+DQoNClJldmll
d2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoN
Cj4gLS0tDQo+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDIgKy0NCj4gICBrZXJuZWwvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNSArLS0tLQ0KPiAgIGtlcm5lbC9tb2R1bGUvTWFrZWZpbGUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEyICsrKysrKysrKysrKw0KPiAgIGtlcm5lbC97
bW9kdWxlX2RlY29tcHJlc3MuYyA9PiBtb2R1bGUvZGVjb21wcmVzcy5jfSB8ICAyICstDQo+ICAg
a2VybmVsL3ttb2R1bGUtaW50ZXJuYWwuaCA9PiBtb2R1bGUvaW50ZXJuYWwuaH0gICAgIHwgIDAN
Cj4gICBrZXJuZWwve21vZHVsZS5jID0+IG1vZHVsZS9tYWluLmN9ICAgICAgICAgICAgICAgICAg
fCAgMiArLQ0KPiAgIGtlcm5lbC97bW9kdWxlX3NpZ25pbmcuYyA9PiBtb2R1bGUvc2lnbmluZy5j
fSAgICAgICB8ICAyICstDQo+ICAgNyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA4
IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBrZXJuZWwvbW9kdWxlL01ha2Vm
aWxlDQo+ICAgcmVuYW1lIGtlcm5lbC97bW9kdWxlX2RlY29tcHJlc3MuYyA9PiBtb2R1bGUvZGVj
b21wcmVzcy5jfSAoOTklKQ0KPiAgIHJlbmFtZSBrZXJuZWwve21vZHVsZS1pbnRlcm5hbC5oID0+
IG1vZHVsZS9pbnRlcm5hbC5ofSAoMTAwJSkNCj4gICByZW5hbWUga2VybmVsL3ttb2R1bGUuYyA9
PiBtb2R1bGUvbWFpbi5jfSAoOTklKQ0KPiAgIHJlbmFtZSBrZXJuZWwve21vZHVsZV9zaWduaW5n
LmMgPT4gbW9kdWxlL3NpZ25pbmcuY30gKDk3JSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJ
TkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IGJkODZlZDlmYmM3OS4uNDYzYmRiODI5ZGI0IDEw
MDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMTMw
MTIsNyArMTMwMTIsNyBAQCBMOglsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ICAgUzoJ
TWFpbnRhaW5lZA0KPiAgIFQ6CWdpdCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvbWNncm9mL2xpbnV4LmdpdCBtb2R1bGVzLW5leHQNCj4gICBGOglpbmNsdWRl
L2xpbnV4L21vZHVsZS5oDQo+IC1GOglrZXJuZWwvbW9kdWxlLmMNCj4gK0Y6CWtlcm5lbC9tb2R1
bGUvDQo+ICAgDQo+ICAgTU9OT0xJVEhJQyBQT1dFUiBTWVNURU0gUE1JQyBEUklWRVINCj4gICBN
OglTYXJhdmFuYW4gU2VrYXIgPHNyYXZhbmhvbWVAZ21haWwuY29tPg0KPiBkaWZmIC0tZ2l0IGEv
a2VybmVsL01ha2VmaWxlIGIva2VybmVsL01ha2VmaWxlDQo+IGluZGV4IDU2ZjRlZTk3ZjMyOC4u
NzE3MDc1YjY1ZGViIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvTWFrZWZpbGUNCj4gKysrIGIva2Vy
bmVsL01ha2VmaWxlDQo+IEBAIC0yOSw3ICsyOSw2IEBAIEtDT1ZfSU5TVFJVTUVOVF9zb2Z0aXJx
Lm8gOj0gbg0KPiAgIEtDU0FOX1NBTklUSVpFX3NvZnRpcnEubyA9IG4NCj4gICAjIFRoZXNlIGFy
ZSBjYWxsZWQgZnJvbSBzYXZlX3N0YWNrX3RyYWNlKCkgb24gc2x1YiBkZWJ1ZyBwYXRoLA0KPiAg
ICMgYW5kIHByb2R1Y2UgaW5zYW5lIGFtb3VudHMgb2YgdW5pbnRlcmVzdGluZyBjb3ZlcmFnZS4N
Cj4gLUtDT1ZfSU5TVFJVTUVOVF9tb2R1bGUubyA6PSBuDQo+ICAgS0NPVl9JTlNUUlVNRU5UX2V4
dGFibGUubyA6PSBuDQo+ICAgS0NPVl9JTlNUUlVNRU5UX3N0YWNrdHJhY2UubyA6PSBuDQo+ICAg
IyBEb24ndCBzZWxmLWluc3RydW1lbnQuDQo+IEBAIC01Myw2ICs1Miw3IEBAIG9iai15ICs9IHJj
dS8NCj4gICBvYmoteSArPSBsaXZlcGF0Y2gvDQo+ICAgb2JqLXkgKz0gZG1hLw0KPiAgIG9iai15
ICs9IGVudHJ5Lw0KPiArb2JqLSQoQ09ORklHX01PRFVMRVMpICs9IG1vZHVsZS8NCj4gICANCj4g
ICBvYmotJChDT05GSUdfS0NNUCkgKz0ga2NtcC5vDQo+ICAgb2JqLSQoQ09ORklHX0ZSRUVaRVIp
ICs9IGZyZWV6ZXIubw0KPiBAQCAtNjYsOSArNjYsNiBAQCBpZm5lcSAoJChDT05GSUdfU01QKSx5
KQ0KPiAgIG9iai15ICs9IHVwLm8NCj4gICBlbmRpZg0KPiAgIG9iai0kKENPTkZJR19VSUQxNikg
Kz0gdWlkMTYubw0KPiAtb2JqLSQoQ09ORklHX01PRFVMRVMpICs9IG1vZHVsZS5vDQo+IC1vYmot
JChDT05GSUdfTU9EVUxFX0RFQ09NUFJFU1MpICs9IG1vZHVsZV9kZWNvbXByZXNzLm8NCj4gLW9i
ai0kKENPTkZJR19NT0RVTEVfU0lHKSArPSBtb2R1bGVfc2lnbmluZy5vDQo+ICAgb2JqLSQoQ09O
RklHX01PRFVMRV9TSUdfRk9STUFUKSArPSBtb2R1bGVfc2lnbmF0dXJlLm8NCj4gICBvYmotJChD
T05GSUdfS0FMTFNZTVMpICs9IGthbGxzeW1zLm8NCj4gICBvYmotJChDT05GSUdfQlNEX1BST0NF
U1NfQUNDVCkgKz0gYWNjdC5vDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL01ha2VmaWxl
IGIva2VybmVsL21vZHVsZS9NYWtlZmlsZQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRl
eCAwMDAwMDAwMDAwMDAuLmNkZDVjNjFiOGM3Zg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2tl
cm5lbC9tb2R1bGUvTWFrZWZpbGUNCj4gQEAgLTAsMCArMSwxMiBAQA0KPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ICsjDQo+ICsjIE1ha2VmaWxlIGZvciBsaW51
eCBrZXJuZWwgbW9kdWxlIHN1cHBvcnQNCj4gKyMNCj4gKw0KPiArIyBUaGVzZSBhcmUgY2FsbGVk
IGZyb20gc2F2ZV9zdGFja190cmFjZSgpIG9uIHNsdWIgZGVidWcgcGF0aCwNCj4gKyMgYW5kIHBy
b2R1Y2UgaW5zYW5lIGFtb3VudHMgb2YgdW5pbnRlcmVzdGluZyBjb3ZlcmFnZS4NCj4gK0tDT1Zf
SU5TVFJVTUVOVF9tb2R1bGUubyA6PSBuDQo+ICsNCj4gK29iai15ICs9IG1haW4ubw0KPiArb2Jq
LSQoQ09ORklHX01PRFVMRV9ERUNPTVBSRVNTKSArPSBkZWNvbXByZXNzLm8NCj4gK29iai0kKENP
TkZJR19NT0RVTEVfU0lHKSArPSBzaWduaW5nLm8NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9tb2R1
bGVfZGVjb21wcmVzcy5jIGIva2VybmVsL21vZHVsZS9kZWNvbXByZXNzLmMNCj4gc2ltaWxhcml0
eSBpbmRleCA5OSUNCj4gcmVuYW1lIGZyb20ga2VybmVsL21vZHVsZV9kZWNvbXByZXNzLmMNCj4g
cmVuYW1lIHRvIGtlcm5lbC9tb2R1bGUvZGVjb21wcmVzcy5jDQo+IGluZGV4IGZmZWY5OGEyMDMy
MC4uZDE0ZDY0NDMyMjVhIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvbW9kdWxlX2RlY29tcHJlc3Mu
Yw0KPiArKysgYi9rZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYw0KPiBAQCAtMTIsNyArMTIsNyBA
QA0KPiAgICNpbmNsdWRlIDxsaW51eC9zeXNmcy5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC92bWFs
bG9jLmg+DQo+ICAgDQo+IC0jaW5jbHVkZSAibW9kdWxlLWludGVybmFsLmgiDQo+ICsjaW5jbHVk
ZSAiaW50ZXJuYWwuaCINCj4gICANCj4gICBzdGF0aWMgaW50IG1vZHVsZV9leHRlbmRfbWF4X3Bh
Z2VzKHN0cnVjdCBsb2FkX2luZm8gKmluZm8sIHVuc2lnbmVkIGludCBleHRlbnQpDQo+ICAgew0K
PiBkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS1pbnRlcm5hbC5oIGIva2VybmVsL21vZHVsZS9p
bnRlcm5hbC5oDQo+IHNpbWlsYXJpdHkgaW5kZXggMTAwJQ0KPiByZW5hbWUgZnJvbSBrZXJuZWwv
bW9kdWxlLWludGVybmFsLmgNCj4gcmVuYW1lIHRvIGtlcm5lbC9tb2R1bGUvaW50ZXJuYWwuaA0K
PiBkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS5jIGIva2VybmVsL21vZHVsZS9tYWluLmMNCj4g
c2ltaWxhcml0eSBpbmRleCA5OSUNCj4gcmVuYW1lIGZyb20ga2VybmVsL21vZHVsZS5jDQo+IHJl
bmFtZSB0byBrZXJuZWwvbW9kdWxlL21haW4uYw0KPiBpbmRleCA0NmE1YzJlZDE5MjguLjM0YTJi
MGNmM2MzZSAxMDA2NDQNCj4gLS0tIGEva2VybmVsL21vZHVsZS5jDQo+ICsrKyBiL2tlcm5lbC9t
b2R1bGUvbWFpbi5jDQo+IEBAIC01OCw3ICs1OCw3IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L2R5
bmFtaWNfZGVidWcuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvYXVkaXQuaD4NCj4gICAjaW5jbHVk
ZSA8dWFwaS9saW51eC9tb2R1bGUuaD4NCj4gLSNpbmNsdWRlICJtb2R1bGUtaW50ZXJuYWwuaCIN
Cj4gKyNpbmNsdWRlICJpbnRlcm5hbC5oIg0KPiAgIA0KPiAgICNkZWZpbmUgQ1JFQVRFX1RSQUNF
X1BPSU5UUw0KPiAgICNpbmNsdWRlIDx0cmFjZS9ldmVudHMvbW9kdWxlLmg+DQo+IGRpZmYgLS1n
aXQgYS9rZXJuZWwvbW9kdWxlX3NpZ25pbmcuYyBiL2tlcm5lbC9tb2R1bGUvc2lnbmluZy5jDQo+
IHNpbWlsYXJpdHkgaW5kZXggOTclDQo+IHJlbmFtZSBmcm9tIGtlcm5lbC9tb2R1bGVfc2lnbmlu
Zy5jDQo+IHJlbmFtZSB0byBrZXJuZWwvbW9kdWxlL3NpZ25pbmcuYw0KPiBpbmRleCA4NzIzYWU3
MGVhMWYuLjhhZWI2ZDJlZTk0YiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL21vZHVsZV9zaWduaW5n
LmMNCj4gKysrIGIva2VybmVsL21vZHVsZS9zaWduaW5nLmMNCj4gQEAgLTEyLDcgKzEyLDcgQEAN
Cj4gICAjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3Zlcmlm
aWNhdGlvbi5oPg0KPiAgICNpbmNsdWRlIDxjcnlwdG8vcHVibGljX2tleS5oPg0KPiAtI2luY2x1
ZGUgIm1vZHVsZS1pbnRlcm5hbC5oIg0KPiArI2luY2x1ZGUgImludGVybmFsLmgiDQo+ICAgDQo+
ICAgLyoNCj4gICAgKiBWZXJpZnkgdGhlIHNpZ25hdHVyZSBvbiBhIG1vZHVsZS4=
