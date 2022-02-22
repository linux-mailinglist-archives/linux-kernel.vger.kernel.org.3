Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3F4C00E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiBVSG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiBVSGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:06:24 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90075.outbound.protection.outlook.com [40.107.9.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE31728A5;
        Tue, 22 Feb 2022 10:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2oaBGkW9L5oVq2/4Z7GiurklDSVD3iGPXceLX+R13bcv+M85+cEb0im7eD5zsjx8VndCmQNUStYF0plpQgxlh+4Fv3FJxiLll7UCEQ9bfjU2mGkiWtsoeq9lFXBX8Hu96mXeDZ1r1EBCZDLvoeQL1JiPgx2JKlUfGbOLk3a/nXXQMSfYWgxD5Kg/MmTeWFKk8buexePLhwt7Jghk3VqyCAyBt0ydilG8sIgpNwuWZKqcD5Tc/wm5lNs1tDX53RGQHpJGZmyBll4pRoamm0vhtP5nQmbgVw2jWgYgc3j3I2FigWj3h2MhiEH4T6NzpDzZE4Eu6QeGRwwYFLyLzW9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGAZ6PQQc7PnvKXWX474PrSUSO+kxkRBcSdQuU4DNFU=;
 b=El2FcujmoGz0jeFU050xv8wrEcRndTasZkv/et8+jYtSIhXMKCp5KtqxFKbukLDo47K9RTSGuecVG0ABIdhAPZqfXOk24gfp62tcxeOEcFQjj5YsmK7VT2Nw2kVjtp2j2QU9nokrVMagl1X1DhNx9tCQnaG8VXyfdkElsI6VnfgpHcPfqVhqDuv2aGPECxLRPbHLz400ERInTbxRPNqjAY5NXqmhZkGPmM8DvlVQ9nykPVqwqBo6DhnbuCRaEWdnDVl9qhzGNdqXXMzpPmfi3c0qso/QdEi7ocDBpKdvhVIOdK850fZbQp71yF3UP8Rk0ErcJ4oOH09gKlxFIHREjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2807.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 18:05:56 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.021; Tue, 22 Feb 2022
 18:05:56 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
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
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: [PATCH v8 12/13] module: Move kdb_modules list out of core code
Thread-Topic: [PATCH v8 12/13] module: Move kdb_modules list out of core code
Thread-Index: AQHYJ/ZaRNCo1Fl4ok+6H8+9Ysg3wKyf3b+A
Date:   Tue, 22 Feb 2022 18:05:56 +0000
Message-ID: <a0d3daf9-a7ae-21c4-c260-bd0dd483b92a@csgroup.eu>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-13-atomlin@redhat.com>
In-Reply-To: <20220222141303.1392190-13-atomlin@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 830e9087-cca4-4d5f-9e91-08d9f62df916
x-ms-traffictypediagnostic: PR0P264MB2807:EE_
x-microsoft-antispam-prvs: <PR0P264MB280731C9AA0DC550F0717B41ED3B9@PR0P264MB2807.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkKwtqtoNcnHy7wmu3CHZ/1EAShRGS6U37yfQUuS6c1OZzirZLoy88aZZTN8RtxxNMP97Q9mgGp8K6BG2ZlItDPshJh/7xge4u7MryoEab8xlkbtnbj3HhFU0kKNiRL3fO3TlWLBDCvQuGSRJLGRiuKLW+m+XKq1VuRSZfdNZku1/un0UNZFjb8kdWhaLxZGjfXQomMk01Px27HdWj0P/sahmWW9ZYb4s0R2+7E/wHjVAiVqxPQchjofNU/lh0ckac3fytkh/DNvkJUGj5NHYH3A6MWbvSqvV6LQr8Z1YEW0IXh1nkohaZr8vtn4DLZbY1B691RI2nrCRfoYdt4FHeaQyLstvz3KTwPmmtqQYEFxGqpPQ6BFhaNeY0I2BbAaeKVkTDlpUOFAR1nfFHeGgCNXWyMYZxRhRhdYc+IpMYQLmxKwWeOVsQSKNZBl9NwKPJ2C5iGdbnVfOW77SvFG4nl+dZQg4t91wZs/0bld8Rq2ljnvMYMklRmKF8o6NKZqiI5WjQXJbGBqcr2niRBbEKDld+0QiT58hWBjkBzuPu599K9LypxOCE1j61oUdp9yZvvmj8x4toT3qi40e5+uDQHPpMazDJz4Ff+v9nNMpYhwSg+EMG5cvgrkN0FnRgYO1DaSEifHI+AYBFLt6Zi7J5xTZPBIX6UBKZA1N54HCm7rHs93UxhwAa9JZ1DKN+MjThdLpMh9VlMInKhYEYiL7kVAiI2AIBpxLth7Qz3RkUwCxhSEHAWfiycndAhr2IiCzdl72UTof/ZtWg3jsPtyp2MSgDtrQtoVClKEB1DQarl+vQS6sU1Qsmk0Lem0Ndi4nJVnI5XhzoNBiTY30X6M1flT9AJD0XhRbIVQas4et2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(186003)(6486002)(26005)(110136005)(66446008)(66476007)(4326008)(8676002)(316002)(31696002)(122000001)(91956017)(66556008)(76116006)(86362001)(54906003)(66946007)(2616005)(71200400001)(64756008)(66574015)(83380400001)(508600001)(5660300002)(6512007)(6506007)(7416002)(44832011)(2906002)(31686004)(36756003)(38070700005)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFJKdCtFMTlxUDZ5RDYvdjJ1Tjlab1Q4LzlIY2RDMW45bEpsN1diTXhDVUlj?=
 =?utf-8?B?a1d5cm11WmhYalU2SS9JT1ZvNGxrUTlUUXVRRHR1WnpwTGo1dWZsRTN2cVM2?=
 =?utf-8?B?VXFqN1U4ZEZwVng3OUgzcTFaOGpwOEEvdXA1VitRd01vdWhJckNRbDVEdm53?=
 =?utf-8?B?WmZOV25DakdEL3RHQlhsTk82dGpNTFlERjg1V1dYRDlHWHVkOEJzd2V4UFp3?=
 =?utf-8?B?eE9yMUprdGRtNHhGUTB4b2o2d0cwOGF1NkROYXkxTkQ2VHJPd0hDb01tUkxQ?=
 =?utf-8?B?ZVcrdHV2aHJ2aWFzblVETk1taEZmTU05bTQ5UE0zMFRIWG9zVWxxamsydng5?=
 =?utf-8?B?YitjQ09Lc2lSR3UvSzNtN3lxa3huWFlsQS9MbHI2MzY3TEJTSEQwRzVLakMv?=
 =?utf-8?B?TEdOZDllc0hJQ0ZIQ0lOQzRhUWcvQk54aEEzZnZEcDVoclJ6VW1iVXZQOUJm?=
 =?utf-8?B?eG5kdDFDU0h4Vzl6RmdiOVhXRkJPTGJMV2E3a0JWYnppME5kWGF0M1NoZGlK?=
 =?utf-8?B?dHZQTlZZWnZtcDROME9JYk02RHRMQ2N2UmhoUUxBT1ZNWWpHRDgyM0VpeDMy?=
 =?utf-8?B?T01uRW03UXMybXdzeTYzeENVU1VkSHRoa2hoenBQd1RkOTNmcE1JS1dGZm80?=
 =?utf-8?B?SDNlNWlzamthN28yMTBlVEdmbkthdUhQdHF2STY3ZlJ6dHRQOUJmUE5UODJQ?=
 =?utf-8?B?azI0UTRYWHgyOE5VMFJQTWFlQ0JnWTNVYTgwV0RDbEVTZk5waXJxcU1iSVkv?=
 =?utf-8?B?NC9IdGtXM3c1L3lHdU11SmFmVzdkU0RuSzBwOTZ4Rkc1YmlsemIwZ2JGVU5w?=
 =?utf-8?B?dVJGU1lOWk9sMWlLLzJiMHM3UUo4NStUTlpITzNkaXNHcFdGTkxHR1FSV3R2?=
 =?utf-8?B?bi95ZGMySTJTbkgrNDdaSE5iQWl2RXBiWHNmYUtNd3g3RkR1R1J0NU92OTdV?=
 =?utf-8?B?QmJGek1NemdaOGRGZlRMTEFvU05mZ0haQjdEaEF5Z3E3UlZhRnBzODJ0Yjdm?=
 =?utf-8?B?V041WjdDWTR6alV5MlltakpZQ21vMHNSUVNFeUxGMXF3V2s3TVY0RGE2NEJn?=
 =?utf-8?B?VktiZzZNSHh2MzQ3RlFnVEJsdFUxZDVnTGZHekNEWEpjZ0JONCt4dm8zMG52?=
 =?utf-8?B?S000RmpkRHlOMWtwSFhJUDVjNTBRL1VCWWFJZGsrY3dFcjZRbjZNVW52aHFH?=
 =?utf-8?B?cXZQck0vcE5nZmhzc3RnUzUwbFUxQkFuTWxpL1VFMVpjMHFqKzBodEVZbFk3?=
 =?utf-8?B?akhDK3RjQ2RCclJmZDhVZ1gvQ1FnMW5PK3RURDZ5Nml3TEZ6Z0ZKbUlCbml5?=
 =?utf-8?B?N2t2cUpOQjlZY2JWNDR1NmRBL3pvcWM1REV5OWNZVitLVmxUaHBQdTZUcTFx?=
 =?utf-8?B?RzhQWWNBZG01eVdCeUR6SkdiNjJaQnNhUFpRRVFWL0JVMUVsUTZ4YzgxbEZP?=
 =?utf-8?B?K0RXSGYzSUg5ODVuaHRLd0Zla0ozNVFpTzQyU0RxeExGZkdJUWFpRWlLcklp?=
 =?utf-8?B?QXBrK3NKaFdxUWgzY05vTEdHS2tTckRBdzRkbDBSaVFqeXFra28xQnZIRmJG?=
 =?utf-8?B?S1hSaXBpQ21uZ2NhdGlhV25TMG1CNDh1NVJjcHJua0pYWVkrb3FkS2c5cDZG?=
 =?utf-8?B?cVlLL1hDZjFYMWkwTE9KMEtiOFg3bFBpUFBqalBkYUFCbndQd1BtVTBkbW56?=
 =?utf-8?B?elMvV2pQbXFqcGYxVVZsVTRnbmZ3dVhhbXhrREhseUNBOHNYbEYwRm9jMzQ1?=
 =?utf-8?B?bXF2UDhuVUdvVlNOY081SFFDWTd3S2pNeUUvd0IzUnN5bWpuUmFqanBOOGtR?=
 =?utf-8?B?SG9Id3hDV21ieHNsN1V2Z3BWVFNoSkZrcW1sT09yb1VoR2R6V2djOXR6VENp?=
 =?utf-8?B?KzlqMGU1Z3NOT3MrVENrRlI1ejdLd3RiYThOQS9mZHpXK001TS9pUldnYWJm?=
 =?utf-8?B?Zml3RzVTclNWUjd6ZHZ6WGdQeXRtd0RxdG50U2dQKzNpQ2lMVUxLdDl1dTFk?=
 =?utf-8?B?akpPUGV6cXlMVGRvZ2tCK2RkY0xLVjVhekFoZE1vSTB6UExrQ1lEQlVOSk01?=
 =?utf-8?B?cTRUMm42Z1Rtbmk1NzNxeitzVmd6TjZ0UVIyZjFWWTduL1c3RVBwN3lTbGFh?=
 =?utf-8?B?ZStGRHhqU01wVGxkYTRKQVhzbEtBNzVYOS9kUUl2eFVxK0xRd0pXdDZSM3NM?=
 =?utf-8?B?LzBGTUdSOXA1V285a3poV04xZ1haRGt2KzIxaTVjRTFYWGVxZk9jVUR4Q2cx?=
 =?utf-8?Q?pV463fjsdIajJDRZ5iy8OtIxXYvl4DpVrsF89pHa1k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA121B13E798804186E26C751A4C2B90@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 830e9087-cca4-4d5f-9e91-08d9f62df916
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 18:05:56.1512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epu1oQI+7DaCIu0Co1dwnE59HbtBTOPa7uIlT3nR6jvhAyT+jphux/FFF1y7repRR76EMd4AVhmhiyxrIfpcd8ClzwQHJLzpQ6tXdrE6tGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2807
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBEYW5pZWwgYW5kIEphc29uLg0KDQpUaGUgZnVsbCBzZXJpZXMgaXMgYXZhaWxhYmxlIGF0IA0K
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1vZHVsZXMvbGlzdC8/
c2VyaWVzPTYxNjc0MSZzdGF0ZT0qDQoNCkxlIDIyLzAyLzIwMjIgw6AgMTU6MTMsIEFhcm9uIFRv
bWxpbiBhIMOpY3JpdMKgOg0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFRoaXMgcGF0
Y2ggbWlncmF0ZXMga2RiX21vZHVsZXMgbGlzdCB0byBjb3JlIGtkYiBjb2RlDQo+IHNpbmNlIHRo
ZSBsaXN0IG9mIGFkZGVkL29yIGxvYWRlZCBtb2R1bGVzIGlzIG5vIGxvbmdlcg0KPiBwcml2YXRl
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWFyb24gVG9tbGluIDxhdG9tbGluQHJlZGhhdC5jb20+
DQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3Jv
dXAuZXU+DQoNCj4gLS0tDQo+ICAga2VybmVsL2RlYnVnL2tkYi9rZGJfbWFpbi5jICAgIHwgNSAr
KysrKw0KPiAgIGtlcm5lbC9kZWJ1Zy9rZGIva2RiX3ByaXZhdGUuaCB8IDQgLS0tLQ0KDQpUaGlz
IHBhdGNoIChhbmQgdGhlIGNvdmVyIGxldHRlcikgc2hvdWxkIGJlIGNvcGllZCB0byBLREIgbWFp
bnRhaW5lcnMgDQphbmQgS0RCIGxpc3QNCg0KWW91IGNhbiB1c2UgdGhlIGZvbGxvd2luZyBjb21t
YW5kIHRvIGZpbmRvdXQgd2hvIHRoZXkgYXJlOg0KDQpbY2hsZXJveUBQTzIwMzM1IGxpbnV4LXBv
d2VycGNdJCAuL3NjcmlwdHMvZ2V0X21haW50YWluZXIucGwgLWYgDQprZXJuZWwvZGVidWcva2Ri
L2tkYl9tYWluLmMNCkphc29uIFdlc3NlbCA8amFzb24ud2Vzc2VsQHdpbmRyaXZlci5jb20+ICht
YWludGFpbmVyOktHREIgLyBLREIgDQovZGVidWdfY29yZSkNCkRhbmllbCBUaG9tcHNvbiA8ZGFu
aWVsLnRob21wc29uQGxpbmFyby5vcmc+IChtYWludGFpbmVyOktHREIgLyBLREIgDQovZGVidWdf
Y29yZSxjb21taXRfc2lnbmVyOjExLzE0PTc5JSkNCkRvdWdsYXMgQW5kZXJzb24gPGRpYW5kZXJz
QGNocm9taXVtLm9yZz4gKHJldmlld2VyOktHREIgLyBLREIgDQovZGVidWdfY29yZSxjb21taXRf
c2lnbmVyOjgvMTQ9NTclKQ0Ka2dkYi1idWdyZXBvcnRAbGlzdHMuc291cmNlZm9yZ2UubmV0IChv
cGVuIGxpc3Q6S0dEQiAvIEtEQiAvZGVidWdfY29yZSkNCmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcgKG9wZW4gbGlzdCkNCg0KDQo+ICAga2VybmVsL21vZHVsZS9tYWluLmMgICAgICAgICAg
IHwgNCAtLS0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2RlYnVnL2tkYi9rZGJfbWFpbi5jIGIv
a2VybmVsL2RlYnVnL2tkYi9rZGJfbWFpbi5jDQo+IGluZGV4IDA4NTJhNTM3ZGFkNC4uNTM2OWJm
NDVjNWQ0IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvZGVidWcva2RiL2tkYl9tYWluLmMNCj4gKysr
IGIva2VybmVsL2RlYnVnL2tkYi9rZGJfbWFpbi5jDQo+IEBAIC01OSw2ICs1OSwxMSBAQCBFWFBP
UlRfU1lNQk9MKGtkYl9ncmVwcGluZ19mbGFnKTsNCj4gICBpbnQga2RiX2dyZXBfbGVhZGluZzsN
Cj4gICBpbnQga2RiX2dyZXBfdHJhaWxpbmc7DQo+ICAgDQo+ICsjaWZkZWYgQ09ORklHX01PRFVM
RVMNCj4gK2V4dGVybiBzdHJ1Y3QgbGlzdF9oZWFkIG1vZHVsZXM7DQo+ICtzdGF0aWMgc3RydWN0
IGxpc3RfaGVhZCAqa2RiX21vZHVsZXMgPSAmbW9kdWxlczsgLyoga2RiIG5lZWRzIHRoZSBsaXN0
IG9mIG1vZHVsZXMgKi8NCj4gKyNlbmRpZiAvKiBDT05GSUdfTU9EVUxFUyAqLw0KPiArDQo+ICAg
LyoNCj4gICAgKiBLZXJuZWwgZGVidWdnZXIgc3RhdGUgZmxhZ3MNCj4gICAgKi8NCj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9kZWJ1Zy9rZGIva2RiX3ByaXZhdGUuaCBiL2tlcm5lbC9kZWJ1Zy9rZGIv
a2RiX3ByaXZhdGUuaA0KPiBpbmRleCAwZDJmOWZlZWEwYTQuLjFmOGM1MTlhNWY4MSAxMDA2NDQN
Cj4gLS0tIGEva2VybmVsL2RlYnVnL2tkYi9rZGJfcHJpdmF0ZS5oDQo+ICsrKyBiL2tlcm5lbC9k
ZWJ1Zy9rZGIva2RiX3ByaXZhdGUuaA0KPiBAQCAtMjI2LDEwICsyMjYsNiBAQCBleHRlcm4gdm9p
ZCBrZGJfa2JkX2NsZWFudXBfc3RhdGUodm9pZCk7DQo+ICAgI2RlZmluZSBrZGJfa2JkX2NsZWFu
dXBfc3RhdGUoKQ0KPiAgICNlbmRpZiAvKiAhIENPTkZJR19LREJfS0VZQk9BUkQgKi8NCj4gICAN
Cj4gLSNpZmRlZiBDT05GSUdfTU9EVUxFUw0KPiAtZXh0ZXJuIHN0cnVjdCBsaXN0X2hlYWQgKmtk
Yl9tb2R1bGVzOw0KPiAtI2VuZGlmIC8qIENPTkZJR19NT0RVTEVTICovDQo+IC0NCj4gICBleHRl
cm4gY2hhciBrZGJfcHJvbXB0X3N0cltdOw0KPiAgIA0KPiAgICNkZWZpbmUJS0RCX1dPUkRfU0la
RQkoKGludClzaXplb2YodW5zaWduZWQgbG9uZykpDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9k
dWxlL21haW4uYyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+IGluZGV4IGI4YTU5YjVjM2UzYS4u
YmNjNGY3YTgyNjQ5IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvbW9kdWxlL21haW4uYw0KPiArKysg
Yi9rZXJuZWwvbW9kdWxlL21haW4uYw0KPiBAQCAtMTA4LDEwICsxMDgsNiBAQCBzdGF0aWMgdm9p
ZCBtb2RfdXBkYXRlX2JvdW5kcyhzdHJ1Y3QgbW9kdWxlICptb2QpDQo+ICAgCQlfX21vZF91cGRh
dGVfYm91bmRzKG1vZC0+aW5pdF9sYXlvdXQuYmFzZSwgbW9kLT5pbml0X2xheW91dC5zaXplKTsN
Cj4gICB9DQo+ICAgDQo+IC0jaWZkZWYgQ09ORklHX0tHREJfS0RCDQo+IC1zdHJ1Y3QgbGlzdF9o
ZWFkICprZGJfbW9kdWxlcyA9ICZtb2R1bGVzOyAvKiBrZGIgbmVlZHMgdGhlIGxpc3Qgb2YgbW9k
dWxlcyAqLw0KPiAtI2VuZGlmIC8qIENPTkZJR19LR0RCX0tEQiAqLw0KPiAtDQo+ICAgc3RhdGlj
IHZvaWQgbW9kdWxlX2Fzc2VydF9tdXRleF9vcl9wcmVlbXB0KHZvaWQpDQo+ICAgew0KPiAgICNp
ZmRlZiBDT05GSUdfTE9DS0RFUA==
