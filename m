Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D648C4B142E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbiBJR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:26:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiBJR0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:26:50 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901AFC3;
        Thu, 10 Feb 2022 09:26:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA3SzaIIU4Q5/xivurRLyiCYWX5BYQYiy+reRe/Mij64rEqjfKn31nEBBu8lHZnyoA+CSJJHCAWiwGH9/Q+CPnnxJUbOS7rs1MxjFRylJVp07WPgdtMlwaPh3nur5MiLcs3VvJloqW01xpFVno6Am1GC4OAnwzP5MNLyn6+S8iXnctLUkOnqzKIEB7J/cKm9nH7bQlYet/0C0XV4SMGs84y5fK5HrhgEzWsiDQEjrGKwq2nmM8L87x1cMQ6V4j6ugh2UMtLykTwwE1ctVWduVtYametEv37rICx373I0btqL+s0b9MhcefUtr8HgVs/JAv452TcR1DI1FXLAhYX0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/ysZs4dGXuktGHV9gWkN4PbTzu05C5qMghXx15BSgw=;
 b=GwuOeKT5oq5cll3xAseR4NlYf3aLF1RZO/RCxVpUv58aQsDxbXrWcaSwnLLvidShRYCHfGTX2qw2wjTBQXLUk3NBBQnPr/JMVUOLCvmt86WrXVPjlgTeK1n3DKLHmcOygYofiA6fQPUv2rjfedLLPrCl93AsaY8TJopPo8YgsIFv6cX/F0lS5lpBTLrV/1otrka6Dy7aQY5UzYyVqLe71wD01OX+IhdhBDAa2fB1flTY5mscDZxlY6G54gVOzP/FOMzl0od+hkcpuHXiOtFdnau04DSCJOr3rxV9njghJi6kGjQawp5aeevm8lzhLjSPAkTX8g+Vq4lW/VIT6tMbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/ysZs4dGXuktGHV9gWkN4PbTzu05C5qMghXx15BSgw=;
 b=ZuENajV6v8UTy46Vq9PvLwyzMeMYA7lW8dOELqHDNBC9mRbweDByKApgbI4nSDnH5oV0OmSOi7D3cXaEJFlNITdRHArLSUjyKpMknJrw/JTyoqwonTKp+uvx7RCfL2+pb+dkjNQjTFJXCw3Q709hlbP6m1UrqWpCLAFtqYmpXsw=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0702.namprd21.prod.outlook.com (2603:10b6:300:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.4; Thu, 10 Feb
 2022 17:26:47 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e827:5c3c:bd09:4b15%3]) with mapi id 15.20.4995.006; Thu, 10 Feb 2022
 17:26:46 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "bhe@redhat.com" <bhe@redhat.com>
CC:     Petr Mladek <pmladek@suse.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Thread-Topic: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Thread-Index: AQHYBKVkQrNf9EVAnEWGrcViRN9sbax0B4Ih///IBICAA2pjAIABVVyAgBGhIICAAF8sgIACoMgAgAAMl9A=
Date:   Thu, 10 Feb 2022 17:26:46 +0000
Message-ID: <MWHPR21MB1593C36268FFB3FD654074A5D72F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
 <e2d39675-5df6-73fb-fa24-df906a97ee50@igalia.com>
 <YgMLd+avxyBplfk2@MiWiFi-R3L-srv>
 <7b45bc2b-f74d-8604-bd8a-4930f7b8f926@igalia.com>
In-Reply-To: <7b45bc2b-f74d-8604-bd8a-4930f7b8f926@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f6e5edd5-5b15-4751-983c-21c480cbb756;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-10T17:24:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c95b3db-a8cc-45a3-76cb-08d9ecba83d1
x-ms-traffictypediagnostic: MWHPR21MB0702:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MWHPR21MB0702DC975DE1FA09C1F39A1CD72F9@MWHPR21MB0702.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NGwaeYhUuejf6wjDpgXcaSwVgFgU+Ix43JJDhBP8YWFuSbesJoQaYPFWBZtNZwzb40kIbG3gxB01XBLJ7CxVdAdItAltmwNBTm3kijdxnVXIa/L6C82wOm0G2mc7xwocVXALfQIe+BNOWKtkXcsbW/qGp1r/PK27t3Q5USojaAEiZtiWNFsYzfGpRy8UQ9S0dRoTLS1rNTOm20qJ1zSUv2VgqsYt1dW7n62xnBOy0+ZEeGBaDMRcYAucSGaExV623ZIj96i/6QkJjuyJFW/nmlsKNx0KsGnPHkvsop9AXLmfBBJCgSuSxiG8CVbsT4jnsKLG/GoUlkSbfVJydQTsnzAJ0uEO8vFFa+4lfhGctouvwZhE8wU1N1E3a3W/hXmaxJxZLu6J/Hvfn0OQPEV0rCLpCaTdhpY4HbQ3vciUfD6vl5aMteG3vMtReHOYJJ6rnzOOdzFB8U+4WirI/2EQhImgGeIducFxmdtcQ7rRBvlGJnkjwKW10Z6SPkNBYx3kcLtOIyieI0B7P7PP0uANWzk1r+ZkD5eGsThRJ401CPRzQv36b9htGYO2XrrbccnMsYGtWnIQgFboV6WlM9hOj5pS9kKgAgaDwVsx9LAelf0UeDOqZw5DszZ1OgbdyYnz8N4oVsMwl2/ZTVUF/6OkGwMiY536QnfyZp1TLh2yFHP72dLUMF+gvz4R1PshkFKI/kv15muEZSSBvZ3rUMvu2KlRcTEty6uipAEb/Pcfw/BnGT9Ii2MU/Q2VoXk1g/5t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(122000001)(7696005)(86362001)(83380400001)(6506007)(110136005)(26005)(38100700002)(186003)(9686003)(82960400001)(82950400001)(64756008)(7416002)(8936002)(4326008)(66946007)(5660300002)(66446008)(66556008)(8676002)(66476007)(55016003)(33656002)(76116006)(71200400001)(508600001)(2906002)(10290500003)(8990500004)(52536014)(38070700005)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q21MN1VQRWp2dlhkeHVPM3Z2UElpNm9SU2ZKcis1UGZOSFo4K3dsYitsV1lO?=
 =?utf-8?B?aWU1ZUN5N3JPSDJRZUxYYXhDNWd1b29WMm54K0Rza2VZaGh1b00wMTBSZjBo?=
 =?utf-8?B?b1ZJYTkzVUY5ZzdDb3NxL2Y2czdOVlgrdWdOWFFlL3Z2YW81TnhEa3Fvdlp0?=
 =?utf-8?B?bkYwTTBLZXNCWHRURUpubDlpcEo5K2Q3R3VhZXpnWnpzR0dwL3RlR2JybVla?=
 =?utf-8?B?U2FsbTRPcy8yQWk2T20rU0JSQ2dPclhyY0ZwTVNMVlpLMXNSeHUrS2pGUm10?=
 =?utf-8?B?RHVXcWp2c3dIaXgzclAxMmgrYUR0NTNxTjY2UjhGem1HSS81TkltUW5jYmxR?=
 =?utf-8?B?V3VMdWFWbzJMZC9RYUlhbTlYaWJ2aVZvd1hheFdkWnM5QzlsUU5xMERaSTdJ?=
 =?utf-8?B?MERUQ2Rhc0pYcXc4VmVYZFNZYUpZM1MzQ3RFWFA0NTZybnNlbW5RZTBGaytH?=
 =?utf-8?B?enZCby9VVWdIVENMRTBkeWJ4cGNuVitsbHVWQTlHRTRGQXZkOHRpc0JKb2k4?=
 =?utf-8?B?dTE3VnFycGQ2MGViU2ZxRXRWbzdtbmQzbWtGUkJzYVI5KzJHUjE4OVN4WWdl?=
 =?utf-8?B?SzVVV2RPWkpHeU50T3NiZzZZRWZkcDN4cXViRmtsZVhBYVhtT2RyVGNiMEFO?=
 =?utf-8?B?QnUrVXBJUThPWW1oaWZHNVZBZFoveDZxZ3R4Z1NJYmVoLzZRQUVaa1Y3b0dp?=
 =?utf-8?B?aGZCTWt6U1B0TmE4SUZKSFpQTHlsZ3BaTU4zdmhpOWlMMGEzcEZtUTBMbGFx?=
 =?utf-8?B?TzNuQW5VY2V2TTEvSVJSYjVLTVhQdlA1VUNqS29aMS9rbXdyRHl6c2tNTUtw?=
 =?utf-8?B?bXJ0RTRWbkNIUk9QTWVJTHhkTUdsZXpnM2ZDSlpyaXlheUFvOUJ5RXhuWEhh?=
 =?utf-8?B?WFdrMGpEdXd6OUE3cERPbDI1Q2lqa05XNzNSMUJNZ3NwK3MwS3BoT3F5RjNR?=
 =?utf-8?B?d2t6NEVUcEtVbE1tY0IzZmxuNkI3OUFESGJsQlpmK0M1OG55ZjJCT01tNUxz?=
 =?utf-8?B?ZnF3SVJVem9XU2FpYjVUNzIwNjZUZDVoZUNRWU84R2lJU1Jsb0E2dkM2UXd1?=
 =?utf-8?B?TVVMSnlFUFlNS3J0R04yRkZQWTBkd1NkRitULzNERkcvTGMyNXdCQXB1NGQv?=
 =?utf-8?B?U284TWY0MXVsTVN1bk5qUWl1dllPUVlXODRQOXE2M25yREVvVzFTemwxNkJp?=
 =?utf-8?B?ckc0aDRiZ296cThlQzFaNUQ5anVtaUVLWDRpV0FzempvVGIrMy9zamJWVisy?=
 =?utf-8?B?UG1Fc1kwYVpVTFQxSlN5cjdMMUozOHZ1Z1FzMzd0SjdMZjFES2dwalA3OTRO?=
 =?utf-8?B?NTZiZDArRWRtWGZzMUI0WjRvTXljK0daUzBKemFURmdCT3ZUOXY0M1NZRWkx?=
 =?utf-8?B?c0VNazdqSEkrYUw5SCt4cUlYalNWVzRsRlVzbHp6amphNlhiTHZLMVFUblF3?=
 =?utf-8?B?RFhZTUJqRkFET1NVVDJsTlo2NVJ2cXNzak1IU3czbVdYZUZObG1uaTNOL3Vr?=
 =?utf-8?B?VzhEWEt6RWtBNENBeDB4M3FpUk01d1lVMnpsc0hrWjVnZEk5NFRWVTFSZDND?=
 =?utf-8?B?YjZDMDkyQks2ZXN5SGM5S3FzbG9kcTV1L2x3OVpWQWNPcHc5ZHlLWVRORjh3?=
 =?utf-8?B?MHRIRVgxUnJGTTZvQmc2azd3ZEVra0ZQM1hxSkRJdUE2NDVvQ2RjdTBISFFV?=
 =?utf-8?B?S2xQRkNyUlBQUDVtRUZZSjdrb1FQY0twdzIrSHJRM1ZuYi9sdWJwSkZzeW5l?=
 =?utf-8?B?Z3QzeFhweS9YTFgwZG1nVWE1S1owejRpWWpzRTM1b20zdzZQeFlaWmFFSUgv?=
 =?utf-8?B?bloyVmFKYWtoSEJnWlc3dlo1VXlGb0I4QTlZZStzZUFicHR6NU1KTnJ2MUtZ?=
 =?utf-8?B?Rnd0ckQ5aWtMNFpoVGZqeWlBL05RTEZ6MWRtY2JKZGIrM2wva0hoYUZXaFdR?=
 =?utf-8?B?QXNjdWZRd0xGeHhVWDNoRGtwUkV3R3A5Q0FhaEVvQWNPR1lYMkpDZVVEYlVB?=
 =?utf-8?B?U1h5NHU2THVNWHBtd2lTOFBYVmJwd2JGZWpacko1TkhSS0Q4ekY0b2dTcWtL?=
 =?utf-8?B?S2t4Q25kVjZZRnZrNUYwU1I5ZUNzenNjTkJSN3BqeVNBUGZ0ZVFuclFvMlBH?=
 =?utf-8?B?S2ZUT0FsUEZLMXhVbE82eXJubEErMERvYVNQdlA1aDdFYjh1bEhZaUtDN3A1?=
 =?utf-8?B?MHExbGdWMUVJbTRPa2lsZzAzeDlHSXllTjJtTXBTQkhGNSt2ZUlrREQxa05k?=
 =?utf-8?B?UkxOd2NVL0hITUVPek5LdFZzSHpBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c95b3db-a8cc-45a3-76cb-08d9ecba83d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 17:26:46.8557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrBjR2Y8hKGmREvqcDN2eoMYPai3Z56XDNtU8moRfN0vb0asrd2sJAqqRb5DYkf56uSi2vt8Yo7Wd+jhR9WwkcTCzusskCxjyBhddXiukzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0702
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR3VpbGhlcm1lIEcuIFBpY2NvbGkgPGdwaWNjb2xpQGlnYWxpYS5jb20+IFNlbnQ6IFRo
dXJzZGF5LCBGZWJydWFyeSAxMCwgMjAyMiA4OjQwIEFNDQo+IA0KPiBPbiAwOC8wMi8yMDIyIDIx
OjMxLCBiaGVAcmVkaGF0LmNvbSB3cm90ZToNCj4gPiBbLi4uXQ0KPiA+PiBTbywgd2hhdCBhcmUg
dGhlIG9waW5pb25zIGZyb20ga2R1bXAgbWFpbnRhaW5lcnMgYWJvdXQgdGhpcyBpZGVhPw0KPiA+
PiBCYW9xdWFuIC8gVml2ZWsgLyBEYXZlLCBkb2VzIGl0IG1ha2Ugc2Vuc2UgdG8geW91PyBEbyB5
b3UgaGF2ZSBhbnkNCj4gPj4gc3VnZ2VzdGlvbnMvY29uY2VybnMgdG8gYWRkIG9uIHRvcCBvZiBQ
ZXRyIGRyYWZ0Pw0KPiA+DQo+ID4gWWVhaCwgaXQncyByZWFzb25hYmxlLiBBcyBJIHJlcGxpZWQg
dG8gTWljaGFlbCBpbiBhbm90aGVyIHRocmVhZCwgSQ0KPiA+IHRoaW5rIHNwbGl0dGluZyB0aGUg
Y3VycmVudCBub3RpZmllciBsaXN0IGlzIGEgZ29vZCBpZGVhLiBBdCBsZWFzdCB0aGUNCj4gPiBj
b2RlIHRvIGFyY2hpZXZlIGh5cGVyLVYncyBnb2FsIHdpdGggcGFuaWNfbm90aWZpZXIgaXMgYSBs
aXR0bGUgb2RkIGFuZA0KPiA+IHNob3VsZCBiZSB0YWtlbiBvdXQgYW5kIGV4ZWN1dGUgdy9vIGNv
bmRpdGlvbmFsIGJlZm9yZSBrZHVtcCwgYW5kIG1heWJlDQo+ID4gc29tZSBvdGhlcnMgUGV0ciBo
YXMgY29tYmVkIG91dC4NCj4gPg0KPiA+IEZvciB0aG9zZSB3aGljaCB3aWxsIGJlIHN3aXRjaGVk
IG9uIHdpdGggdGhlIG5lZWQgb2YgYWRkaW5nIHBhbmljX25vdGlmaWVyDQo+ID4gb3IgcGFuaWNf
cHJpbnQgaW50byBjbWRsaW5lLCB0aGUgaGVhdnkgdXNlcnMgbGlrZSBIQVRBWUFNQSBhbmQgTWFz
YSBjYW4NCj4gPiBoZWxwIGNoZWNrLg0KPiA+DQo+ID4gRm9yIFBldHIncyBkcmFmdCBjb2RlLCBk
b2VzIGl0IG1lYW4gaHlwZXItViBuZWVkIGFub3RoZXIga25vYiB0byB0cmlnZ2VyDQo+ID4gdGhl
IG5lZWRlZCBub3RpZmllcnM/IFdpbGwgeW91IGdvIHdpdGggdGhlIGRyYWZ0IGRpcmVjbHR5PyBI
eXBlci1WIG5vdw0KPiA+IHJ1bnMgcGFuaWMgbm90aWZpZXJzIGJ5IGRlZmF1bHQsIGp1c3QgYSBy
ZW1pbmRlci4NCj4gPg0KPiANCj4gSGkgQmFvcXVhbiwgdGhhbmtzIGZvciB5b3VyIGNvbW1lbnRz
Lg0KPiANCj4gSSdsbCBuZWVkIHRvIHN0dWR5IHRoZSBIeXBlci1WIGNvZGUgYW5kIGhvdyBpdCdz
IGRvbmUgdG9kYXkgLQ0KDQpMZXQgbWUga25vdyBpZiB5b3UgbmVlZCBhbnkgYXNzaXN0YW5jZSBv
ciBleHBsYW5hdGlvbiBhcyB5b3UgbG9vaw0KYXQgdGhlIEh5cGVyLVYgY29kZS4NCg0KTWljaGFl
bCBLZWxsZXkNClByaW5jaXBhbCBTVyBFbmdpbmVlcg0KTGludXggU3lzdGVtcyBHcm91cA0KTWlj
cm9zb2Z0IENvcnBvcmF0aW9uDQoNCj4gSSBndWVzcw0KPiBtb3N0IHBhcnQgb2YgdGhpcyBpbXBs
ZW1lbnRhdGlvbiB3aWxsIGJlIHN0dWR5aW5nIHRoZSBub3RpZmllcnMgd2UgaGF2ZQ0KPiBjdXJy
ZW50bHksIHNwbGl0IHRoZW0gYW1vbmcgdGhlIDMgbmV3IG5vdGlmaWVycyBhbmQgY29tYiB0aGVt
IGludG8NCj4gcGF0Y2hlcywgc28gdGhleSBjYW4gYmUgcmV2aWV3ZWQgZm9yIGFsbCByZWxldmFu
dCBtYWludGFpbmVycyAod2hvIGtub3cNCj4gdGhlIGNvZGUgd2UgYXJlIGNoYW5naW5nKS4NCj4g
DQo+IEknbSBub3Qgc3VyZSBpZiBJIGdvIGRpcmVjdGx5IHdpdGggdGhlIGRyYWZ0LCBsaWtlbHkg
aXQnbGwgaGF2ZSBzb21lDQo+IGNoYW5nZXMsIGJ1dCB0aGUgZHJhZnQgc2hvdWxkIGJlIHRoZSBz
a2VsZXRvbiBvZiB0aGUgbmV3IGltcGxlbWVudGF0aW9uLg0KPiBTcGVjaWFsbHkgaWYgeW91L290
aGVyIGtkdW1wIG1haW50YWluZXJzIGFncmVlIGl0J3MgYSBnb29kIGlkZWEgPSkNCj4gDQo+IENo
ZWVycywNCj4gDQo+IA0KPiBHdWlsaGVybWUNCg==
