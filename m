Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD7F599866
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348091AbiHSJSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348092AbiHSJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:17:55 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120053.outbound.protection.outlook.com [40.107.12.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82BFF2D5B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7nWnXgl6FIqikfCY/3onpT4jFHRbCAYeoVCXl9qswcxpAiLSHMODw0t+iW+XUdIiDcjlJ3CMpPIXdkPHK73Bts/qfnICa8pQjKWnBW2pE9gpaTMT1UyMLexxcUw+wCQ4OdVkKJm67lyN/pJXgj++GugtrJWrm3M5ATb5bMqY1M0tFJdDTG7b32acIjLuJW5cZ4seq1KJh1SqQxGNzT2BcbXxj6raYN8Lzur/3N7yQG11douX6oeJY/7lWNGreJ8dZkGA8oRLa8x2BreC4HhcawbLq3bxlt1nB8DkzQfFE9rAT65pPXRDitFdxby0odi2h8RtGL7cZbGsDdY0G+QHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIx5Ahe9xvW0F1WKdEXFZQ+ukGrV/wOgKsgfTmHyuyQ=;
 b=GaaDgw3X6L2Z8HBxQgph1CiJaKRofCIj8qB1izS9zJoY2+kyuSrLzztroQpbrcnQ1WUbK00mlZvCf8DvWKPWsi+oiSnrfu4WUkzPx5SeFvkh1X4UT1xQIQ7Z0vZFZWMb62RwHL8supkNhNFbF0FFJdSwWD/zb+8qovTtU/1LmHMXTRty9pFdSuBlxsWCHjR7tBCO5x0gJx/yd+Dm/oOaDe+ibAKJNNWTwmoG7UYovn4RWM423cvyNMKdmJEEGe5pKM/7Nq5gNdENqRK9z5SIJrYDOEQ8M5dHTyjmLg+b9jygIZmuQltGosYLrSIhB+v/cHYccHNI7JNS0jKe0vK2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIx5Ahe9xvW0F1WKdEXFZQ+ukGrV/wOgKsgfTmHyuyQ=;
 b=meqDHWOLnw3UIgDx9msNxt9Pt0alu4/ZiNQxwMcXXK5kDs5Qn4SlvOgNoEnJpfyIajuzXZQbbwlSk+G4Xn0Tbvokr9+MwlX1kiOgL09HjfrPy/yxsbQdEf7KDMQCOTvN2Tdc/rP2NrGRRsvwqlcgi7T99J8EEx5qEQLWaJ+dCOsEpCt4mKPlSh9R+s9WAGfru4KcbSWMUbgmRDGoxGL/iCBaaE3k2GSj0WePOOBXfhFM+flBIcKZ6g2sOw41/t3WCK/4RCQhACULEja2hh/6EvzfilQt6B/SvafJwCIEDQQzPGI15pIzAsMloxSiwEn7syUDDMZo6fE2J3oNIvTRug==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB4085.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:250::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 09:17:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 09:17:49 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dmitry Safonov <dima@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 00/23] Add generic vdso_base tracking
Thread-Topic: [PATCH v3 00/23] Add generic vdso_base tracking
Thread-Index: AQHYM9OLTa3qCxlr+U+sdKEFqnRDQay5IPoAgP3QdwA=
Date:   Fri, 19 Aug 2022 09:17:49 +0000
Message-ID: <ad912d91-c6e8-12ab-f309-d52b8cd9a92a@csgroup.eu>
References: <20210611180242.711399-1-dima@arista.com>
 <8bba9ed8-ae1f-7c98-fde5-808927935447@csgroup.eu>
 <6b2513db-7c31-8da4-38ec-0b9898c6589c@arista.com>
In-Reply-To: <6b2513db-7c31-8da4-38ec-0b9898c6589c@arista.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d42f26b-7436-4117-2294-08da81c3afc3
x-ms-traffictypediagnostic: PR1P264MB4085:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pWdCvKDT30j7cca33D9bn5Z2y7c7H6YjN1/jHUQ7GOvxWmXXaxKFLGSLYgKHCOhmafGSr32QKxx5Rm9F6RdG03zN4OEvnrp7QORwekyCXMRmbkTL63IKmIGeTcd2OAPQ4zG4CXz5o22YzEy9Z5ktZosMwfMjWPFQQiHMW6MiOeKhoVFm1335U0CfPIrCaHhQy6YdPWHT4gGKoFmx1F+DSBCK7b+nCIjhtBDc8Xx7BE8m256ZpPFaAjh4qQAS5shT1pLP/0FIAUBdJ+QHx/B5IectkVNg6F5xbvdw4txODGbXb20SqOBdLqriWnzI5kSHGxB8AwPDRmz5xxHXH/J2YL86tVv7+nC50QyQ7yEcGkjgNR16LNGH714COASvwtgUkjTUOJHTDrvJa0rlAYesAZOE9cnQPVXbnnIej95bW85gevludtCbQWRRT6mpnL6vSP4cK/rcpMFBSq+Ixm1w21g68+eoLNII/fu7+OIgI8csMc3wPQK/weT0yDvmX5laDc+JZ/LalaPJJ8oMVk+feQAOurQMt7T9LReb0EGp9OkDByk6KaEnNaBXpwvNgZiJ6f9NBqzDi+9WJKM2FCl/wEbpCdUbptWiR6HyJ4I3OMtEroE2UBEmUEAUEfuHiopK+p6GU5Lxytv7gXCGIASAJZz7UvlO96ERmPkmxgd0r4fSIYrcg7buKC46jBOMCxn+ykxW3bsIJqnHanA0BEPgLTIeyZuqPKLmu56ejZTUpgL9DBiBIVqRxwkKsE3rlFiQD3emBkATewKY1lfatYSCmsywj/DBxCNHsMkr7/Ujxu4n1NCTF8NRrsrRWiTyVWtjRFqNIrbRUqejBIAILbrX1lBzwXjcvQhJ6JSO2xQxuMM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(39850400004)(136003)(396003)(44832011)(6506007)(66476007)(53546011)(66556008)(66446008)(76116006)(66946007)(7416002)(2616005)(91956017)(4326008)(186003)(41300700001)(64756008)(26005)(8676002)(6486002)(5660300002)(8936002)(6512007)(478600001)(4744005)(38070700005)(2906002)(31696002)(86362001)(38100700002)(316002)(36756003)(122000001)(110136005)(31686004)(54906003)(71200400001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1IxdWdGS2F5NHlnTXVVTDFVV09ZcGQwdkZmSzBHYisreEVUb2VrMS9sYU54?=
 =?utf-8?B?alRac1NWRDFNSldlT3R1S1hzMmZMK1JMMW5qelc2akJsODh5ZFE4Q3VKc0Zm?=
 =?utf-8?B?UHdWbi9DbnZsWG81QXZVVkpiOEtkT0ErcS8yQWJ5MXNqRG5GOGJkeGMxb3pr?=
 =?utf-8?B?ZVlLR21pYzR3d2hTd0lHd2FSRHlNWUlEUjhrOE4wMGx1ZkF1a0hnQXk3YnE3?=
 =?utf-8?B?T1R2SFg4VXpRVG5CN0kvNEtYSERhVnBneTJLODl0bkE5eUNXMXdVYnplb2ZZ?=
 =?utf-8?B?N3pRUUVuSmJwcFZ0V1pDc1QrTE5ONFc0S3lGekdxTlE3VVJSamJjZ1pEbGpN?=
 =?utf-8?B?RFAyZWtHanZFb2NOZEJ0WFNWd0Zwb1UvL1FuQVpqZEhBNlUyMkhvcUhlTDMx?=
 =?utf-8?B?UTdmUUNFb21HZGlyeTZnWFZoZktYVmRURnQxSkpmWDJRN0QzOGQ4MG5vQnNU?=
 =?utf-8?B?OXBKTlB2T0JHTC8vK3lDbGJWZFM3SmFDckw0UDlPQWY1M1JZK2xOdDFEUTh0?=
 =?utf-8?B?cXdRM0haK2Jzb1NmclExbFRFVmwrOFpDb29uc1NGNUR1SWdVTE4vU1ozeDh4?=
 =?utf-8?B?ODR1cjY4UGNZcXhtd0lpb2c5bUNuNWFhL0dzUTIzRmJkblFvK0txQ1puZXhH?=
 =?utf-8?B?Ny9TNXU5dVcxZ2RmdTJRMVB5NmU3NWVkSVBwRjNuZHVpZVpjRTBDOUkwenVD?=
 =?utf-8?B?TkRKWnlUMHlQUTloalpjQTVYcjg1cTI3NmhMRXdiVG1OZ0xSZFRQS01hSElp?=
 =?utf-8?B?bmg3ckhCK0lWa3F2SSt3R0JQWmw1YWpPOHpkbjhCWWRiUFdHc3NidjhnazJz?=
 =?utf-8?B?L3JkUUErR1Fsd0lTOWlGcld6TWtINGhMNzk2R3F1bVMwTDlVaEw1K2lzNVdl?=
 =?utf-8?B?N0tGQzRuc0tSM0E2dXp5R0dWb0RMSXdqaWNpTzNPZDFFcklWa0dDQmR4NXF6?=
 =?utf-8?B?QmdvU0lqQnJSSjZwUXJvQTFZTG96Uko1Q0NEZWYvYmVkUU4yMHpEWjNmSHRt?=
 =?utf-8?B?RGFmalN0bkdraFBoZVgzSzNUdmNZUkp5RkI3MTdiUW9zVFd4V010dXllUnJC?=
 =?utf-8?B?Qk5IajNhRXFpOGEvcklKSVFxSzZyN0xvSUhXaU1QTkNNZmRObE42TlNKSVJQ?=
 =?utf-8?B?NFNlQ293K2ttakFtKzJ1UmNLUkpvL2Z3d3ZKSWxEaXZqNGlYMC9IYVRTODEr?=
 =?utf-8?B?OWJ5Y1RtaitpSDMxOFE3L0JhV1NjSGdCRmpNQnJoa1JIQTFKRFgwNGsvQ0Nh?=
 =?utf-8?B?RmpNUDZGMzVBY1lEZTZ4SnZzU1ZaaUlPWW5JamE1aHZucysvekdwME00R0ZC?=
 =?utf-8?B?UGNzczVveEVJQVl0RDFTbHJFdGI0aU1IcnZVaENUVXlhbzdLNWY4OHUzaWNj?=
 =?utf-8?B?SUVHTm9KWFZUYzlJVGZ6aE1FWEtQeXFCN2ViRnVscHNobjhWTzRBZnlpQ0Fh?=
 =?utf-8?B?SU80dUtXUTJBaytGeEhSRWpzOEZSdXFsQnRhN0ZVRTE1c0E4dnhqM3R5ZXNZ?=
 =?utf-8?B?aFNTaXArbzdCMkxKV2Fvbk5NRzRIRkN2RlNEOTN3eVV6TG9PMTBKellkeFdz?=
 =?utf-8?B?OURNRGRqQ21iY1Y0TXFraW5kM1c5S2lZUU5hYVFEanpkR3NNMDBUdk10V05V?=
 =?utf-8?B?REdRbzdaREZ4K2J6RkEzNzk3RGlUZTE2bW5PaDBIbHQ4ZllnSzhDd2pKbk9G?=
 =?utf-8?B?b0Y4Ky83R0JobFRDYmtiV2pLTXVveGc3N1FVL3VlNDVuMFdDK3VvM2kzVEph?=
 =?utf-8?B?TXFXKzVxVFNIRS9WdUZWbzZwdkpkVDU0blMzYXd1eXJ4K3VDRWF5L3pGaGt3?=
 =?utf-8?B?VGx0U1hkdFM0TjBuTE8vNkxoRE9OaXVyUmJCRTlHS1dPVGE3WFVabFp6bFpr?=
 =?utf-8?B?ZVhEZXlrUFhTendRVUw3NWpta3VqSGpLYXhqZE12U3N1KzBKa0JObno1QXpF?=
 =?utf-8?B?RWtHR3VHOG5ibjVta3F0M2ZnTmx6UEdlOU1odnFNSW1CL282czdic2lCREtv?=
 =?utf-8?B?WVNsOWxVSVk0MnF4aGFDM0lJcXZwRFkwZlAyZ0JaL0YvMkRpR1ZRK2l0aUtM?=
 =?utf-8?B?NGVLdVd2YnpRNlFJUVBTUjhqQmplRFRRNXBJVlF2QUR5Zlpsbll3Mmp3M0tX?=
 =?utf-8?B?ejBoVzJFV3I2VTNKdm05Mm9CN0JGb2RvOU9hemxZRmdCT0VYUUFHZTlSd2xK?=
 =?utf-8?Q?4veb50lszi0CGmNhhb2N+aM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0401D76B9A8DC4C8DCB13A0863541C3@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d42f26b-7436-4117-2294-08da81c3afc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 09:17:49.3597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqREZvr3wxi1lx96yt0r/rHdnEpryVK4t7GWkDQsgp3u712bUZ52R6CEHWRF8k6zUaMdAiCpS+lINyf2AppPHGc6eOS7VVEcgW+YdTwAUCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB4085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpMZSAxMC8wMy8yMDIyIMOgIDIyOjE3LCBEbWl0cnkgU2Fmb25vdiBhIMOp
Y3JpdMKgOg0KPiBIaSBDaHJpc3RvcGhlLA0KPiANCj4gT24gMy85LzIyIDE1OjQxLCBDaHJpc3Rv
cGhlIExlcm95IHdyb3RlOg0KPj4gSGkgRG1pdHJ5LA0KPj4NCj4+IEknbSB3b25kZXJpbmcgdGhl
IHN0YXR1cyBvZiB0aGlzIHNlcmllcy4NCj4gDQo+IFllYWgsIEkgcGxhbiB0byB3b3JrIG9uIHY0
IGFkZHJlc3NpbmcgdGhlIHJldmlld3MuDQo+IFdGSCBoYXMgcXVpdGUgYWZmZWN0ZWQgbXkgd29y
ayBvbiBzaWRlLXByb2plY3RzIGFuZCBJJ3ZlIGxhaWQgYXNpZGUgZm9yDQo+IGEgd2hpbGUgdGhp
cyBwYXRjaCBzZXQgdGhhdCB0b3VjaGVzIGV2ZXJ5IGFyY2hpdGVjdHVyZSBhbmQgaXMgYmVzaWRl
cw0KPiBhIGJpdCBjaGFsbGVuZ2luZyB0byB1cHN0cmVhbS4NCg0KQW55IHByb2dyZXNzID8NCg0K
VGhhbmtzDQpDaHJpc3RvcGhl
