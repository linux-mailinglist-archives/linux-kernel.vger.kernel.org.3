Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EF849C450
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbiAZHaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:30:10 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:50342
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229681AbiAZHaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:30:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzG+ob0P29GM+BRZ6rHEpJWk45SYu7yG8GMTz7ynms5CLA7hES+WjRNMYJdGs3QFyEc7eKutbGjv96ce6QrTktPXXh3cF3TvX/vzbq7beKm2bkPFnyI/7gV1PcODfPz0pl2h7omfXW9ql9Uwzjg8gwP5XXo8F+px5NAcdiSjl1Hutr3Putzg640hzwAUtOOZ+WzN95yVK7tFCtZL3x8Qvhw7pSxs+1qAQ6Ww7rrCBVC/TNiIbEi/qNTNk6Widyxx6/KhOn8mp0/ij0szKFim0pXaJkp+Zrzo3C/dzgwhrtgxOXIH0WZhs3yYrgMmpcxzHI+IsCFSg+oNmuJTYtX95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L4qLZ1yctHIUPAm2iYqJzSKsx5qfp2ae2ypvyRG+vo=;
 b=NvxTPX4Etn8A/JAwKeqWF95FrvgJcfKaiMYfJYaVTOwjl1ilYfCpyeOQehYiFvQPW0IvTABcT3DJ4xdMmNlRcGluUVPM0wJmatVGq3yOW+Pb69msZNmRxHiXgA2IDF1J/mhE2V2yCIJyJnxI3cxeUV13HxJNs9iXiC3+h1MdnEAEWWi35wXN4pMRR0mFwkXAyJlypWxvLbird6q8sAvfEvXTH19UfqWf0Cx4ByIkW+7YfI/o49QJ2ooP3VU3jh7UDiDaEEpFEdErF70T5fRMbgpusY3IH/YxB8rsTW1tA1hQmoCr2bWoRY0Mkp5kPG9WRxdjrB0Fz6vEpGAd4bx1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L4qLZ1yctHIUPAm2iYqJzSKsx5qfp2ae2ypvyRG+vo=;
 b=dW/XjECW6drKOSnvIIjCNV3t92tVU4adihD5dBOXgU+80cy/4RCRg8mivWbXLA9p6FaW8fi3P9UZ0cyFjfD5dnYJhcYVVgTL/qV4A2foqznwSCUcH3wrBKTZKvmawffIjLHUXSwaW8zVyN5km9iIQnOjwbWINutZNCm0CuAuP5A=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2810.eurprd03.prod.outlook.com (2603:10a6:3:f2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.17; Wed, 26 Jan 2022 07:30:04 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::833:be72:6b04:dca9]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::833:be72:6b04:dca9%7]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 07:30:03 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/54] lib/bitmap: optimize bitmap_weight() usage
Thread-Topic: [PATCH v3 00/54] lib/bitmap: optimize bitmap_weight() usage
Thread-Index: AQHYEIibF1L+JjO3XU+wI1PaUvR73Kx06/+A
Date:   Wed, 26 Jan 2022 07:30:03 +0000
Message-ID: <d7dfe129-157f-f7ae-0fdb-f5eafef1f627@fi.rohmeurope.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77ba34f7-6175-4210-1122-08d9e09dab67
x-ms-traffictypediagnostic: HE1PR0302MB2810:EE_
x-microsoft-antispam-prvs: <HE1PR0302MB2810340F77898AD3FC3A425BAD209@HE1PR0302MB2810.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RyZIc0SvEdxPRELXpUgf9q1xCI1x6Dmss38zZsjokQkfHLXLwn6rfcrWhfjDO87Iuy8dtno7Cp/loUTN5QyXPz1Ni6RptpR5AlkZkR6QOpFViuZbRyyM/JBb2srirXkKwwEEV0xrmZYJwQbHXVVvA1NlcawcdFovataKxFTsOHmGGocJW3DbScONXvSYT70LkHvBSslRfaYzqUHNHfPga0/5RGqEN0/kONgyFAjNZQCgZ5ab0opRsmCk5VZU8e2p//NpLWJVYYhJ97Xx1O1qOTXksXGXVobmNys2Vz16gs6xfrJuCQstEM+ntc/rY332Rc1CRCbYgSET93FCz8m+cD2AoQw/RR9+eAgJndpahRXEP2xZTlXeQgVyK8C4NirlAtys2knd5YW7ncmWoX1NaXKzrQsMK1Y0JGi+JCC3xTk4Ma9JgVsNc9Kb5p0H0A0omYlnGmTKjo+d1HosqeCMrNuFK14TQHsWOFtYrsUUyp0G+aFAZ/xwqTyANJqaFySH3l8p+RnxE9m87VfeIcnMjI+awsGOum2TqRogYS8/Y9GBJzgzYwNy2/elNBzjfCj9/pMYonH9L1o+VxzXA1qHQ4U3PGvaQ0d+F2U3jgpGxIhSpUOKgdoltRImnuOEVIDeoTvteWeDXsj56Jq2yCEBFi7k8DGB47eM6oNhL7DWrWaqoSRYJEnQhDrrFmGfQmCz5CrwrF8zU563yELIxLkAKVkgu7wTHgNckQgAsIn6CkoZAkeENmzOOPCJSgEUEkQFvK0SPZBMl2Sjcp1AN1hHoOJT5ZcwXDlDzgDX7shnOBSIpfy/+PtTFv/9Ftj++zps
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(86362001)(110136005)(66946007)(6512007)(38100700002)(2616005)(6506007)(71200400001)(8676002)(7416002)(921005)(186003)(83380400001)(2906002)(498600001)(8936002)(53546011)(6486002)(66476007)(5660300002)(66446008)(66556008)(31686004)(38070700005)(31696002)(122000001)(64756008)(16393002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkZIRUVYcFBHRUdESEFyU0dHS0hsdVNwYlF1QkNIS3JNd3cwTTcxTmlKaktP?=
 =?utf-8?B?aXNZZ3BMN2NUekNtVVVkLzlrZkpVRE10ZXA3VGxyQ3JISy95NzBYSUwyckIx?=
 =?utf-8?B?RHBMSU5jeVJML0FCTm0xblJ3MFNMRmp3R2FHeGM1LzNQNWVpTEp1L0YwelRr?=
 =?utf-8?B?bTZhNTZ0bThJRStpVHdtbjkweTc2UzJXMkxpWlgwMzh5QVlhcHkwSTVMWDVG?=
 =?utf-8?B?NU4wY1Q3TlBrTGJuZmdIS0dPbE9YbHJkRkVwVVhzZHN5WkxqUUZ1Mlo4aGtT?=
 =?utf-8?B?QUJjTzMraUZsMmo0VnlPRmVRcVdKaXdSbDQ2c3pIVXR0UDAvdTYzL2Izd1ZD?=
 =?utf-8?B?NzZkbHNqRjZWWHlUUkNibW0yMzVUcTRyRVJEMnNVVHRKNG5NK05EZDhyU3Bv?=
 =?utf-8?B?QXlFVExuNSsxblNHZG5vVERjN1JNdWZqYjJQblczTlBEODQ5MDVuaGNmOUQx?=
 =?utf-8?B?bU5JUk9La09lelpjWmJ1bGNwZEpmS2ZXc2M4eDVqY3BYM1MwOTRrSXNvbFhK?=
 =?utf-8?B?eHZTbWQvUkUxWHM4NkxxWmZRS0YxS3FHWjE0c2ptZ1R6OS9QK2s3STV1dk9M?=
 =?utf-8?B?WlYzQVhFYTJyZUl1YUZRRG5GeU1ZR3E4UmYvRkozMzZxSjhlRmZKZ3FGUHUv?=
 =?utf-8?B?WlZjSEV1SnVwRXNrZWY4US8vWkhuaVJobVN5OEVna2ZLMGZBbVlubnBBNVc2?=
 =?utf-8?B?WVFaMGI2QzE4bkFlY3NjNFR0VTRzbFluWkZyWktDaEZuV0pETDRmV0FvVHg4?=
 =?utf-8?B?QkFNTk9MVHZOQ0w4R1pDWjNEam1XZzB1QldOQ1NTMXp4dDgybVBVbHlYL1p4?=
 =?utf-8?B?dHpyK05EU0NmMkVrWDVzK3lLTWVHaGNXTVdsV3J0N0JWaUk1enBJS2M3d0FB?=
 =?utf-8?B?Z3FEdERjUkdYOFBtZk5nZXIvaHFCd0J2cWpmRERPRWdoZUhuRlNYVFZDeEpE?=
 =?utf-8?B?aitEWDk5ekgxWHZuQytWVGVDbVVzOGtRNWcxT1JQWXp6TTZwVW41OVVxei8w?=
 =?utf-8?B?bU1Vc0JHdlJ5L3BOVFJES1kvQUZlNHFuZnp6dlYrSHk4OVFqVjdpSHhTTXUz?=
 =?utf-8?B?aHFQNFRYN3ZKRUZpa3FOYTJrYldkbDIyS2JBTE5KeEN1bkFKcEIveDQ4MDNv?=
 =?utf-8?B?Y2Z3VEhreWg2Q2pXSEp0bllXcHFlUUV4VCtOM2JOQ0dJRE9SZktFTGlUbnNN?=
 =?utf-8?B?ckZ0QkxZWWFTZS92dHhKdDBGWGtpSzJzRW1YQ1Iwd083elJ1Z2ZJQjFxWVNQ?=
 =?utf-8?B?VTdFRGdSNjZ2N2FFOHBDaVNCOUo3Z0RrUW9FVG9mU3EyY1RjQTRaRDZYRVpW?=
 =?utf-8?B?VUZqamJLdCtWVWhvM1lsYzJGVWhrZ2lyKzlhMllIai8vMTFyMG83eVVBbmov?=
 =?utf-8?B?bXNsK3R3aGNwZld6STE3TlJtbEs4S0l0aTR6YVliN1BpR1BEaUMwaHNiWnNl?=
 =?utf-8?B?VjE4Vml1eURuNk0vMEptZnhBc1Y3Nm1xTkxJMzdIN0lTQzhOYlpVeHNHck5j?=
 =?utf-8?B?THFibmJwbUk1L0hWMnRSejdWeFFZVFlqZU5qVG1VVGtXZk4zRXhlOEFlQmM3?=
 =?utf-8?B?a3FndDlBclU3akhVTDFpako2YVVIUGVVektySzVHSzAxRytuL3ZRbHc4RTkz?=
 =?utf-8?B?THk5R2dOdHFvN1lDVUhlUnZOWHFkZVBtbEJXcUpCUjBUblhkOTl3RzM5KzRa?=
 =?utf-8?B?REdUTExmSks2eTJxRGllNTEzZm9FbUhlTWd3RUhBQm02ekk3QXdXR0VYeVFj?=
 =?utf-8?B?QXhwanJqR1JUY0RFdDcyYUhVM3Nqb0hYL0FlVVBJSlZTcDZyM0lPR0dRV0h5?=
 =?utf-8?B?US9SaW5oTkNGZWVXOVdUQTRYVFprRXV4MEV4RHVxZFB3U3JTSWw3aWNuZWZC?=
 =?utf-8?B?NHpVOG5XZWs3RHp0WktRYlZYOVFCa20yWmFyNG4rN1J0eFlleUo1bUtzaVUz?=
 =?utf-8?B?WXpQbHcxOElkYnJNbGcvWnBkazlHdkxLRmgraVFwd1NESS9jYnZuY3VNNERQ?=
 =?utf-8?B?NmxERnozbno2K2RHM3hHZ3liSkhvaTZSZ3FJUFZKdHRGRTRWRUdJRVQ2ZHo4?=
 =?utf-8?B?WFR5Y3oycndUVHRiVWRGUVdtTmIva3ljbjFOcllhZ2tDYjZuNXo5eFZjRVda?=
 =?utf-8?B?NllUQlhoa2sxSk41bWUvTGFLVkFZYitBS3NaeTczbHNFMW1OM0lEUm9jNWhL?=
 =?utf-8?B?SXU4eEhmQ1Q0Y3RUZHhyVithVHh5OFR3RlBtdklFL0ZpdmpMNCtLeXdNOWZy?=
 =?utf-8?B?aDllVmVBM2Q5NkszRjFoS0ZVdldDVnNZOFluWFhIdjZvcE15cjByK05RQ09J?=
 =?utf-8?B?a3BtK0VkcXptRzViUFhockJaZUZGT01sZXF2SGlidStTNFlsSS9ydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74AB4FC418A24B48860CE57739154F4D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ba34f7-6175-4210-1122-08d9e09dab67
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 07:30:03.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pi48fE03lTCqSyFN3fHKN1m04JZjQk9K1K3CCPVPLlpZ2iE0RYXj4/D6uWcjc5Gi/BpLWXGKIsWazB0QMR4u3yKz+78yL7+I+w1A0tT0G+UtB6+8NISXYXKofZwT3Vx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2810
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMy8yMiAyMDozOCwgWXVyeSBOb3JvdiB3cm90ZToNCj4gSW4gbWFueSBjYXNlcyBwZW9w
bGUgdXNlIGJpdG1hcF93ZWlnaHQoKS1iYXNlZCBmdW5jdGlvbnMgdG8gY29tcGFyZQ0KPiB0aGUg
cmVzdWx0IGFnYWluc3QgYSBudW1iZXIgb2YgZXhwcmVzc2lvbjoNCj4gDQo+IAlpZiAoY3B1bWFz
a193ZWlnaHQobWFzaykgPiAxKQ0KPiAJCWRvX3NvbWV0aGluZygpOw0KPiANCj4gVGhpcyBtYXkg
dGFrZSBjb25zaWRlcmFibGUgYW1vdW50IG9mIHRpbWUgb24gbWFueS1jcHVzIG1hY2hpbmVzIGJl
Y2F1c2UNCj4gY3B1bWFza193ZWlnaHQoKSB3aWxsIHRyYXZlcnNlIGV2ZXJ5IHdvcmQgb2YgdW5k
ZXJseWluZyBjcHVtYXNrDQo+IHVuY29uZGl0aW9uYWxseS4NCj4gDQo+IFdlIGNhbiBzaWduaWZp
Y2FudGx5IGltcHJvdmUgb24gaXQgZm9yIG1hbnkgcmVhbCBjYXNlcyBpZiBzdG9wIHRyYXZlcnNp
bmcNCj4gdGhlIG1hc2sgYXMgc29vbiBhcyB3ZSBjb3VudCBjcHVzIHRvIGFueSBudW1iZXIgZ3Jl
YXRlciB0aGFuIDE6DQo+IA0KPiAJaWYgKGNwdW1hc2tfd2VpZ2h0X2d0KG1hc2ssIDEpKQ0KPiAJ
CWRvX3NvbWV0aGluZygpOw0KDQpJIGd1ZXNzIEkgYW0gcGFydCBvZiB0aGUgcmVjaXBpZW50IGxp
c3QgYmVjYXVzZSBJIGRpZCB0aGUgb3JpZ2luYWwgDQpzdWdnZXN0aW9uIG9mIGFkZGluZyB0aGUg
c2luZ2xlX2JpdF9zZXQoKT8NCg0KSWYgdGhpcyBpcyB0aGUgY2FzZSAtIHdlbGwsIEkgZG8gbGlr
ZSB0aGlzIHNlcmllcy4gT3ZlcmFsbCBpdCBsb29rcyBnb29kIA0KdG8gbWUgLSBidXQgSSBmb3Ig
c3VyZSBkaWQgbm90IGdvIHRocm91Z2ggYWxsIHRoZSBjaGFuZ2VzIGluIGRldGFpbCA7KSANCklm
IHRoZXJlIGlzIHNvbWUgb3RoZXIgcmVhc29uIHRvIGxvb3AgbWUgaW4gKEVnLCBpZiBzb21lb25l
IGV4cGVjdHMgbWUgDQp0byB0YWtlIGEgbW9yZSBzcGVjaWZpYyBsb29rIG9uIHNvbWV0aGluZykg
LSBwbGVhc2UgZ2l2ZSBtZSBhIG51ZGdlLg0KDQpCZXN0IFJlZ2FyZHMNCgktLSBNYXR0aSBWYWl0
dGluZW4NCg0KDQotLSANClRoZSBMaW51eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2VtaWNvbmR1Y3Rv
cnMNCg0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29u
ZHVjdG9ycywgRmlubGFuZCBTV0RDDQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpG
SU5MQU5EDQoNCn5+IHRoaXMgeWVhciBpcyB0aGUgeWVhciBvZiBhIHNpZ25hdHVyZSB3cml0ZXJz
IGJsb2NrIH5+DQo=
