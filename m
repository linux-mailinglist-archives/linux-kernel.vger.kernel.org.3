Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E63572A69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiGMAvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGMAvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:51:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96EBD6B5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ5sQNLDolAYTr9KAKZIMwFWvf3DAX4Tg8Xyun1EYTE3N7jH4jym+pXzW/tFYlc7YeB2aNavqIctalZDawLtU1iOhbWmZXNPhLa4VryWEpi/nGy0DbT/i03a04p9vo05MEpahyVoqKicxddFzje2Qz+VHmUWRjaaArbwwgP334+Abx324X8Ee+5mlp78U6iuYaczx+xtspvwle1RvbiKRoZDofXqbiIv5D1+GnJbH93Htmab6QL6Hc9qGRtzRrc4/q8ztF+mz8ppCPSsy34EF6KnWZkRUBBSr2l6sEupOIUG05d5TMVWmYBCEpdMqq38kW5TSlz1yJahrbLLaQDFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T11qpPm4g2BJ+SI+chnC1J6NnnsWh4RRyXkDSafXFOA=;
 b=l9pup/sn0eRvFZjdV6Wzlxheu5lYBT7g0DyA6P9CnHjIqbnkGex/S+QN8LONAQiNaVwSqM9gZpsYTiWWNmJ+XFfmU9qEdgRvYcueI6k/HsmFePEW07HXBXuOSQvEu4pZgbhHtEHa3CExJpjTouXJTQd2wC8ArfEU5y2Pd1BCHT6iBZrWcxSIobaIvi5Ncu2q/PFdoThK2MWtxUWDVj5YEGnXOE1FCJZTJ7Y4bWBuuoIXQuppWXcK/SgKmRjJj4wYF7IDjwcm86FBsCzmX/wlduYbsz+4zLiJSPicFeYK7OKi57Z2q3tRsmOnlXi0Il7xbeXkjtG5fM+rCH+aMLAjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T11qpPm4g2BJ+SI+chnC1J6NnnsWh4RRyXkDSafXFOA=;
 b=l1vVWmJ4RTrib7i4tTV1R+vWoddGFvDyMa0m4Bf8De5wYeAtNrwj3w74WnRSNlgB8tY4XPW+Q80txJWq2ldZWYStE/ebHxjS9ViKU5FJFRBpyPdcGEiRZ4OoTDMu3Ac2ATVT3zGtaFXyOrtyResZwKADAsfqFop0vskyH2OX9S4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BL0PR05MB5331.namprd05.prod.outlook.com (2603:10b6:208:63::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11; Wed, 13 Jul
 2022 00:50:58 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 00:50:58 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Topic: [PATCH v2] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Index: AQHYlPRIBVYGglwRp0y21cAEvAmJeq15cHiAgAIF64CAAASSAIAAAFyA
Date:   Wed, 13 Jul 2022 00:50:58 +0000
Message-ID: <16E81A47-8BCA-4E7B-AC33-9C12B7E7A9CF@vmware.com>
References: <20220710232837.3618-1-namit@vmware.com>
 <7672923F-D439-4867-9418-B1F44EE5CC44@vmware.com>
 <3DC1239B-FBE4-4EE0-B0D1-641B64697712@vmware.com>
 <b6bcd4c5-2311-451a-4792-6c2bc450b6@google.com>
In-Reply-To: <b6bcd4c5-2311-451a-4792-6c2bc450b6@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef6c20cd-bdf8-4164-4cab-08da6469c01c
x-ms-traffictypediagnostic: BL0PR05MB5331:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aDwPeQLlgwyY0A2Lub4SJL/XXnN53Q82xutkg56bQ5vBvgU1OiFahwgWAwnQe+MGI0SlqkKhkQk1rWH9THLoKs9311MtL4W6ZZ5mQ8fFvEOQkx93bonsmvR0fpSCtFCOkb1xWy+NFFoRoWeofddGjTuJiyS6j+ROo7x+NjQZzVipEDNPJla7n4aWO6FSUy/7vkg+0QWZv1PUc6ePjY9m7OcTHh1VB+/oHmSXZvpg9IH52BQNE8Fvl9kUtq6hKxiHzH7obrMpAWOj6sNblegQaAscZ/FiokK5s2T7kHVMjmv6bSPd/nLRYfsh/+0uzcTvW+yT8AZaqluIogN7kbEHKA1Ved6iY8QZ1epoCWwnf4kLDbn985ymZ5hEp0S6GWS2BL9sUJJEm/UzS/XCOi6CEEEn+GsBuE8ZOtDDT6YuqlgoKwVHl36aOdPDt2l3EJbxwOLyrM/puloKn2NGerRGJ7tiUUUSvcOPi4oVl0n0O+QRUSdkfK8If8W8L2vZW8qjnt98AgQqGVsz2WG0bgKC/FNOhZiO+qtr9jdoVwotFGpkp3nRzN7KS/v8CD6UpoK908PCABg2UK/OzIGJ01zbDr1MSOqGn0/HVp6qeqR/seDCA7YVJFgQ7VyIf93QfyQs2GUACil0XJ65w4ZM9xNG5n//yLN7Joefyk+BT8vMq+yPVOLm7VjQMlQ+VJaWj99cGuEdqzZTgdylSJxVfuI5qTpqew9U9g9WkJWLQqke3GdcUsZrePANf/RMR4MpGgI+NCzo3AV80TtyyU/P64BeAXBRdpGrWqUAv33eU3FRfS1ddnZUwzPxFoTAluota/Q24lQfig0vfJEMo4ehd0CGaJVUPwS24K00ZISyFVdP8og+Jn+oLw86TyvVsBDbxnr6KbAsfMjOtzdbVbBifwmc6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(122000001)(186003)(38070700005)(38100700002)(2616005)(4744005)(8936002)(7416002)(5660300002)(6486002)(478600001)(71200400001)(53546011)(2906002)(66476007)(33656002)(64756008)(66946007)(41300700001)(66556008)(26005)(6506007)(8676002)(54906003)(316002)(6916009)(36756003)(76116006)(66446008)(6512007)(86362001)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1ZRWFBTVUQzckgrR1NnVlpzYVRDb3laQjlMVksxWXRHd0pCbk1aVnFFOGor?=
 =?utf-8?B?V2ZkUGxvenNiMDNDcXNCS3cvb21aUTlZTDIzMWtiS3hHbHlsVWc2OFNuOEM4?=
 =?utf-8?B?RXdQZXhqdlFOQnZOanQ5SVh3aFV1anhNcGl2QUhJeHkrUk9aWTNxVjhVNTVR?=
 =?utf-8?B?R2J5Snh1RFVUb1F1WlNreHQzQzdWK3lEVGpOSDAvWGNwYk05UFlKajJEMXFW?=
 =?utf-8?B?T2xHOGlRMDU4RUZFMFNhbmo3QTUvbzVKN3ZFL2FGQTE3ajZpakkyZVBOTlZQ?=
 =?utf-8?B?SzNmVzVEK1h2RzlRSnUzQzIzcWtIdmNSWkc2NXR2QzU3RVJXU0NuRGloUUp4?=
 =?utf-8?B?Q2lZNHBTV0ZHWmRNTEU5dU5FZEtTS3VIcktxWG9RU2RVMTdDUjloaGlST2Uy?=
 =?utf-8?B?TlBRMEs3UnhUK1BnTTRrbk5aZHVFaFJWMXFKMWVnakwrYndVdkV5UFk0dktV?=
 =?utf-8?B?WEFBUEdEN3lHYmhDRWJrVEtkV3VHRUhNcFpHM3ZSQ3pkWFdvTlFWTTFqbFRi?=
 =?utf-8?B?OXBhMVZOMFBzZGIxaThBK2JPOWJab1VWNlZsczdlOHBQVit1YW5sbGRGV2Np?=
 =?utf-8?B?cFIyUU1pazRXdndpRFQ5UDB5MEpneGVIRm5LNU96cm9QVHlvSktPNTM2bzJB?=
 =?utf-8?B?dVhPaGFSMHcwRmwyYVFoNUViSTYwYWF0bUJLM3NidjgwZGdvNmZMY0tVMmZ5?=
 =?utf-8?B?andhaUQ4L0ZubDNpc2lONUhkVkh0b0JCRlB1QmlqcWFhREdXRnl4ZHhEN1E4?=
 =?utf-8?B?dEQrdlRIejYxakpRT1ErK1Rzc0pVZitHLys1eFhTYUJrNG9FWE9YNWk0SWd2?=
 =?utf-8?B?RnQreW93UG5FaVNOdnU4TmgwelJwN2txcDVvRzBEQjRZNmFONXBiT3hYNlds?=
 =?utf-8?B?Y052cUpqT3lpb3ZlRjFMdDRPNC9xa1VIMTZJTEhKVkpQSW9XUXRNMk85a055?=
 =?utf-8?B?aEdqRGpyUkxwTGV5Vm5TNXUveFFCeitDbWgwS1l4MUwzU21oLzFXSXFCOCsv?=
 =?utf-8?B?WEJEUmJUVEdrYUtqUE9wQ1ZVRlZuSnFJMElNY3VNUEpJdUJFTVphNi9pRWNO?=
 =?utf-8?B?YzBOK3dvWjEzamZjUFB6ai9YNXB5U0lCeXNTS2UvejF5QWEwNUEvaVBlTnJy?=
 =?utf-8?B?UThCWHIvNzc4YkJBTDhXUUZaS3NZQ2NhUE5KZlZ2TzBZQXNrc2taT2QwVlFs?=
 =?utf-8?B?MGVVdVlmai9wT3ErWDcyMTkza2lxYTVZaDBvNTdOelVWNFNrL1JQWTZ3c3FY?=
 =?utf-8?B?MUplYk9ER0hGbGZ2ZUJXTHlJMWJ2NmxpTXRINkJCdnBicG45Qmd2MU5qeDVT?=
 =?utf-8?B?L0hSRUtKMGlRSURVRUVCSWRCL0RDUzM4aGlWbXdoelJWVjJwNFNraW5DbFhJ?=
 =?utf-8?B?MTZvZnZ2d3ZlVEpMZkM5TjE3QXlnRU14V1ZlZ210K3RYNGFrZ1BmTUhzWERP?=
 =?utf-8?B?ZzZuc3MxNzZSbGh3YUpvZ2RUV2VKU1FhbFVDL0syYnRicXR0ZDRES2ZIclkr?=
 =?utf-8?B?UFBRb1JFWjF6a2VpMk95R0NyWTlHemNGOG50N2hCVDVOVkpLaWFPd0JJWXRM?=
 =?utf-8?B?VkJIR3k1SnBQUGlJUlVET1MrSHlDN0tJMkhpYTZQTy9scGJrU1FJNGE5MUw3?=
 =?utf-8?B?QTJQeUQ4YWVTQ1lDSDc0NXdHbndwOThZazQ2ZXAvVHhqTlBubUYrMEx5TXRo?=
 =?utf-8?B?cGJlbm5jZ09MU2JtdlR3QnowWUdDUlR5WUVQcENpWm1menpzaWlwUktjSDBS?=
 =?utf-8?B?Um12MU1QcWJRTlZnVG5ZY0krbUppK1BmVi8zY3NzYkhCUFIxRVpwSTNrc3pW?=
 =?utf-8?B?N01yQ3JQaEYwUzMrSkc1MEQ5ME5VTE83QUpEblNTWnhlQUhQenRtdDYreE4w?=
 =?utf-8?B?RU5pUmU1MzBDMk5nNUI0NkJBdUlmR1lpdy9UWjdFcVA5U3RQNENwY3pHdnhV?=
 =?utf-8?B?QU54S2haSXhDTHNrTW43dlVraCt6M2h2RGN3THBxMVpZNUdQY1loY1hmTU1Q?=
 =?utf-8?B?SXRlME1JdXkxZ3I1MzlIckhTTFdKUkQ1M3RtZ2Q2Szg1L09nSFFGdTQwejhG?=
 =?utf-8?B?N1ljM0RKK05Ld3psOWdqNHQ2YThJSGxYYVcrU2huV2xocXJaalF1K2NXY2pS?=
 =?utf-8?Q?lHbeAtJDqlsCDGHhiklgBo/8a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA5C0B9C7A69CD4C852B89E0D699EE63@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6c20cd-bdf8-4164-4cab-08da6469c01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 00:50:58.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5sbWf4s/H5umMbCqHi4bHV2haryEiWWQ1ILoSs2+sn3IzFvsByhM4SBVrSvF/vZDEfue569hcGBqL90B15/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5331
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVsIDEyLCAyMDIyLCBhdCA1OjQ5IFBNLCBIdWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5j
b20+IHdyb3RlOg0KDQo+IOKaoCBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gV2VkLCAxMyBKdWwg
MjAyMiwgTmFkYXYgQW1pdCB3cm90ZToNCj4+IE9uIEp1bCAxMSwgMjAyMiwgYXQgMTA6MzkgQU0s
IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+IE9uIEp1bCAxMCwgMjAy
MiwgYXQgNDoyOCBQTSwgTmFkYXYgQW1pdCA8bmFkYXYuYW1pdEBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4+PiBGcm9tOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPj4+PiANCj4+Pj4gQ29t
bWl0IGFhNDQyODQ5NjBkNSAoIng4Ni9tbS90bGI6IEF2b2lkIHJlYWRpbmcgbW1fdGxiX2dlbiB3
aGVuDQo+Pj4+IHBvc3NpYmxlIikgaW50cm9kdWNlZCBhbiBvcHRpbWl6YXRpb24gb2Ygc2tpcHBp
bmcgdGhlIGZsdXNoIGlmIHRoZSBUTEINCj4+Pj4gZ2VuZXJhdGlvbiB0aGF0IGlzIGZsdXNoZWQg
KGFzIHByb3ZpZGVkIGluIGZsdXNoX3RsYl9pbmZvKSB3YXMgYWxyZWFkeQ0KPj4+PiBmbHVzaGVk
Lg0KPj4+IA0KPj4+IERhdmUsDQo+Pj4gDQo+Pj4gQ2FuIHlvdSBwbGVhc2UgcmV2aWV3IHRoaXMg
cGF0Y2ggdG9kYXk/DQo+Pj4gDQo+Pj4gSSBmZWVsIGJhZCAoZm9yIGEgZ29vZCByZWFzb24pIGZv
ciBicmVha2luZyBzd2FwL21pZ3JhdGlvbi4NCj4+PiANCj4+PiBUaGFua3MsDQo+Pj4gTmFkYXYN
Cj4+IA0KPj4gUGluZz8NCj4+IA0KPj4gQXMgeW91IGtub3csIHRoaXMgcmVhbGx5IG11c3QgZ28g
aW50byA1LjE5IG9yIG90aGVyd2lzZSBhYTQ0Mjg0OTYwZDUNCj4+IHJldmVydGVkLg0KPiANCj4g
Tm8sIGFhNDQyODQ5NjBkNSBpcyBub3QgaW4gNS4xOS1yYzogaXQncyBpbiBsaW51eC1uZXh0IGhl
YWRpbmcgZm9yIDUuMjAuDQoNCk9oLi4gTXkgYmFkLiBUaGFua3MgZm9yIGNsYXJpZnlpbmcgSHVn
aC4NCg0K
