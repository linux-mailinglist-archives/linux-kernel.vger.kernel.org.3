Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756A4471F33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 02:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhLMBto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 20:49:44 -0500
Received: from mail-psaapc01on2138.outbound.protection.outlook.com ([40.107.255.138]:15328
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231196AbhLMBtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 20:49:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9PRS79GiNwKe2wIybMQWRQ+EjoWjSUYxbpmxMayoUnbNFRKv2jA+LoSW2w9P6Z9Oiczh3mpdmz5kUiiHTxwCrhQ0+Rbyh5pb8/kgK96pSV2uNkBGWI7F3NtT2+ffVFNLq3XFcTEU6sI+3ZuI9W7nhep+L3tcXcJgWwxWwpRS/Fu45yfSZnrnhQnP43mBpZqbJJValLl6Nap1SNVsCy0PouLK6vI2PPAOS92qscZRe+cuGCk4CdBvM8jbr7mxKKMxtDyN2+UweDOgw9swTjfrLc3vL/+TOcNEqLtRP7A9RY2CoCob56gHF8GlC1amTMR2ZjU+N+krVGsZz0/fnLrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQf2BnrfAoJPcww/lYHVV3QmyRKhVW3nmSq4F69areg=;
 b=c327++G7Cr6JE1ayAkNUb+OhKrmE73dezemeYIJdKM7egiFcU08HaG5wOp+KNETdgcoNh3IUFSy4aVa9S46qian49KdW/8ASZx0K8TDq8AFDzNvXGOAdYGaPsvedo7VR4UsC80zC3dTNXH/NCSFtdt3l8z5paV9reO0/dLLbGUO4TWvSNSXmo9svzjdZGVhxUnxMBzsz2V8uUNeUzeAk/s6z8i6eN/3H1relu0frXD5iDLLi3QuNKALRWl1y4VCx0V5ZJDQAQaLSKDNNbi530cLbs92JWmVMEO/zCE2aRqIC7r2xCobljlXDs4s8jd56sDJb4RT4m4ADFbVt8Va53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQf2BnrfAoJPcww/lYHVV3QmyRKhVW3nmSq4F69areg=;
 b=1z6jvMANx9R4rRJicpmGLL/DUIrGE1EUcjxTaHnCeaSugVeaxM/zKYIEfIwcSQuH1EYO2x0wbY+MZ+Gn6X4mBr1l2Q7Lvq16L3t14z2+KHhDVkEeJsxhhVkFvnrKfj9N+MRgyj/6JBU3rTj0ej0E5/KtJ8qT+r9lT3O+n6ZwQAXfnSqlb0UmvSjymLeFIka3kDVTlAChGy8WvVE7RfdqnvKy9DyZgPWxCzAr23FxZ3ymQA0mf4HrUHQOqSg+9loYek7lVPtC1IKHzDs4gPQFEi8m1UQKCGPymRW/IUNDBW/0moMw5zkl/quNRBDpLaCrgCRnrc47Q7R9kMUUaHMr2A==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2548.apcprd06.prod.outlook.com (2603:1096:203:6f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 01:49:38 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::7941:2fad:3c82:52eb%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 01:49:38 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk:aspeed:Fix reset driver probe from builtin_platform
 to core_initcal
Thread-Topic: [PATCH] clk:aspeed:Fix reset driver probe from builtin_platform
 to core_initcal
Thread-Index: AQHX78OvvR0AkHOyAUiNxiUKBKrwgg==
Date:   Mon, 13 Dec 2021 01:49:38 +0000
Message-ID: <E9DFB26F-F183-47D9-BE4E-6F739337F8CA@aspeedtech.com>
References: <20211005064513.27655-1-ryan_chen@aspeedtech.com>
In-Reply-To: <20211005064513.27655-1-ryan_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cecf4d80-43e8-4194-337f-08d9bddad2a7
x-ms-traffictypediagnostic: HK0PR06MB2548:EE_
x-microsoft-antispam-prvs: <HK0PR06MB2548979C8C13580157BAECBE8B749@HK0PR06MB2548.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZIUKM/disJSALo+9cqhsuvMrqv9IFCUEiZHK2xdCgCW8cfS0XwmkkX3F8BUGnnyn9pUn7SaoX3Lz1NE+aakl8/cQaukUaLQw1ZswMU/luCAzlieO7FBB1BMa3jBKL/BVV1p+1tHYLI96WsDsJbDG5UCSadmkUbZshq4Pv7/7liAwQWjqigCp1c1j5/Q1LamlbW4wPlvC/Za90M90G5oAp0bQr/sT+lQv08uSR2/Du19zChoApfXZe2/1Rx2LXltlflQP1+Fa5o1CCuD1/H8+3bTQJwT8Xfm+yhriWLwABSIJqx010f7D1zMTXpFgicBvDtAtoYke/wuRcS2Yurb8e/xeNa7e5VAGK61vh4sVjHlYANYCO1uRrIPaPwT2xH3bV6soMrvvdosYQXnsngvaphVTTG/4NXuFG4BP9Vl6APt7zGz0HZs2PxNrqzRlKkCbJ1v3PqB+HxzGNXbSbH2kIYv3UBXLGF2dLp/ztW90Yrez9UaXgTgHHbifZggVy0mwhCrvfhRdB/xlZdBdWoFjkS7EHJXUMJP7A0kCNOQnkUHROmoTdpd23gV2e0W5AMtf8kIhLyRcR2rPNAlKvFfjYx0gcXOrRwDOBi5rP9MjkUk3HJk/V9vueqsdMW0jmV8jByUw9vETBpCOK92E10PuVwxvFOuKEKXjIFSTO+P36M/lSpdHaaUr2/fXpH1XzuAx+vCTeGamCdD5I5CtAuMFUDwcwrOxQPcn9rVkBdQ2cFrPpQdZhTx4O47B5vfYIV+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(86362001)(36756003)(316002)(110136005)(5660300002)(66446008)(83380400001)(186003)(26005)(508600001)(8676002)(6506007)(2906002)(8936002)(64756008)(66946007)(76116006)(33656002)(2616005)(53546011)(66556008)(38070700005)(38100700002)(6512007)(6486002)(71200400001)(122000001)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU0va0MrN1JuR0k5TXdMUWcyamI1ZFcvVlZOV0ViUWR6WVVaRC9PanZTeFZZ?=
 =?utf-8?B?bGZWdllMSW1Ea0lqN01Qa0ZXUDFxMFBsWisvZnNlekdpZk12ZUVGRUg3NXNE?=
 =?utf-8?B?NzZ1aGhiNU9SY0w1S0tPdDgvWERUWWk5WitnRCtEcm5qM3NkUVRTbzlrNHl2?=
 =?utf-8?B?elc0NUczQlRpTElqSXNoSUVUMmcxUzExTU8vWTEvMEdLLy94d3hZTTZzM1F6?=
 =?utf-8?B?YzM2YkZZWi9LWklQdmFOdnhFSWo4eGRTRkZrRVF1bFZ0S05leW9LT3ByTXJr?=
 =?utf-8?B?dS94VHU1UXlxOFFkV1hSQnhRZG9hNHVPbjVEK0V6dDVwaUhJWTJNR0s2REtu?=
 =?utf-8?B?L2xOWC9MWDNPMU1lUXQ0NUlBL3RQNnBycjl4aTVTWXlxL2xRSy9GOWJQUmJ4?=
 =?utf-8?B?eldPcGRJb3ZvK3hOclNPWGxnN1ZmdUZjanJMMnN0Y0l1dVhNR1pwbmNSR2l4?=
 =?utf-8?B?VjhtNThZUXRDMEZEVzhpcTdMN3pjSmVxNVFmaENRdlZwRXBjY3pzdll3SWQy?=
 =?utf-8?B?cTIwWUpMZllXdFh4Z0lVOGg0WDJMMEs3dHhvNjNkbURMVFc4cUN0WEtzaFQ3?=
 =?utf-8?B?and5SHpqNG80UlFxOVVGSEpyejJCYnVhVUt0U3RoQjJMQjZHVnZ1TFhDczZp?=
 =?utf-8?B?S0N2NlR4RzlaZS8rb2s0RzJpaG9tSHAzdWRtUGFtRXpSNERRS2k5SmdaUkw3?=
 =?utf-8?B?Mk4xc2FodzBsWGM1WWFlZUlQVlBoc3hlTkM3d3hQbmRBU3NOSjVWNFhPVWdL?=
 =?utf-8?B?elJNS0trUHkrcnN4cGo3QjdzbjZ5Uld1VFRybkZqSE1rVXRWeERmYWxRR2hq?=
 =?utf-8?B?LzJvdFByUlJqNUczSnA2a3ZPeWxjdlZ0RFZ3UVNnSzVlS2cxb2tmTjFYbzF6?=
 =?utf-8?B?R2tFcFpsWnpZOGV2TEZMQ2xKU0Q4d2pqTHpGSGZXc0dNYkxoWVQ1NitYWDNt?=
 =?utf-8?B?ZWdhME9ud3doeWJxZ2d5QzNtT0RFYXUxR3NRam9DcXlIem5YZ29SbGlkU0xv?=
 =?utf-8?B?N3F5dnJPV3NSWjRMRTR2WVNJcmRjM0V2VWFsbktSS0luc0k4Uk5DekN3Mk1M?=
 =?utf-8?B?bHBNNjVZNlVCa1AzRlRaU1pTenUwTmpqYU5rcndBSk1EcjBpNHA3a1pJUWNv?=
 =?utf-8?B?QkJsVjIwRlBWZk5VZEhmS21mRFBEL3pBR1FlUnJXdWdlc1k0blBOUVg1dFhC?=
 =?utf-8?B?UEIrYkpmSzlSZ2JseW1uMGJieDZTSlowUExGeTZ5UVJMZEsyeHNUaGpabXo1?=
 =?utf-8?B?Tk41UUNhZkRDSmFSbjlCNnRGSW4rSjhmeS82MVBON0tmQTRkcWhGbUswdEhG?=
 =?utf-8?B?MXlNT005Ym9GQWVDbGtXU25JdndFdHlyWWxEUzlIR0NlNjRyekw2MXVqRHVR?=
 =?utf-8?B?Wk9CSVZsaGJERDlDcEZBemxvU3g5NTVlRDNuMlFIaDE0WU1hcCtkT3Z6NGlm?=
 =?utf-8?B?Z2ZpTjIyRm8xNTdDODczbWRZR2ZUYUF4VnBFNUhON0NEcXlSLzFzNGw5aXZC?=
 =?utf-8?B?dmZtbzFwL282UUh1UEtEYkFNeDN2ODVRdkN0VUFDSzBhUXhrczgxUlFqaGJT?=
 =?utf-8?B?Rnd3UEZWaFZIQlBOaGxoejJmR3hvRUJ3bTVPWlArQlErOUxlYys5K2IxMmVa?=
 =?utf-8?B?MmdmRlZqOVhtb29SLzdicDJ3OGIrSDI3NSswQkRmK3Fia1lsR3c5a0ZsMXVn?=
 =?utf-8?B?a1N5aWZQeElJOGVGV3Jvc2pWTmpJRXpzakN5RlYyWmN6NW1BOEQ0MXpPMDFL?=
 =?utf-8?B?OEpmcCtONEdqNVJ5M25Ld25zaVM5aVRPTmVwejdYc2FiNnFwcTNZZEpLVWtz?=
 =?utf-8?B?L0hNb09PMW45bUNIYVJTSTcvSzBhdVdyaVFrZHVxVk41NkNTUUtjZVhQblhn?=
 =?utf-8?B?WGFOZzFWWnZwdkRLUnlhcHh5SkdOcTNweVAybC9xR09oOHV6L0pUb1E4Mkhw?=
 =?utf-8?B?TFptTDlnNmpva1NDVjRSWFFVdnFLOUovZEdSbXhDN0FjTno0ZVV5OGtHb21T?=
 =?utf-8?B?bzNDS08xVG0xLzQxbysxU2dkTjJVdHpVOXBGcnk0ME8zNjdOMldVb1ZLbCtE?=
 =?utf-8?B?NWxyUGpZN2tuSjhPT3AxWXdYQlNHZ3hYNG0yK09pSmZpTGQ3UVFLRU9keFFo?=
 =?utf-8?B?Qm9FRXlRTTZualFmZXRXZHZldS9QRUVmclBNT3pkci9rVlpDZ08weUpkcmJQ?=
 =?utf-8?B?alNpS0pIbmVTemIvemNNSXdRUTk1Z1pNTVNOcjVBOUoxQURXa2grcTdGRXY0?=
 =?utf-8?Q?tOrmUdrkgaOpydWIZlos5kspJ+B5f5pPbRswINJNQw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BE20F05F1B92042A2468AF0A9590980@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecf4d80-43e8-4194-337f-08d9bddad2a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 01:49:38.2540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXtMSysjYUU1wDS3eGM2NqqjwwN+Sr+2DaOggWT5pNmdp2vjm+ttgiYZByESUGUpc+WdQ/5aE03UifvI2aRVlDaK03ayGUGnb860VGUN/VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2548
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMS8xMC81LCAyOjQ1IFBNLCAiUnlhbiBDaGVuIiA8cnlhbl9jaGVuQGFzcGVlZHRlY2gu
Y29tPiB3cm90ZToNCg0KICAgID4gICBDaGFuZ2UgdGhlIHJlc2V0IHByb2JlIHNlcXVlbmNlIGZy
b20gYnVpbHRpbl9wbGF0Zm9ybSB0byBjb3JlX2luaXRjYWwuDQogICAgPiAgIEZvciBhdm9pZCBz
b21lIGRyaXZlciBpcyBwcm9iZSBidXQgZmFpbGVkIGR1ZSB0byByZXNldCBkcml2ZXIgbm90IHBy
b2JlLg0KDQogICAgPiAgIEZpeGVzOiBkM2QwNGY2YzMzMGEgKCJjbGs6IEFkZCBzdXBwb3J0IGZv
ciBBU1QyNjAwIFNvQyIpDQogICAgPiAgIFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9j
aGVuQGFzcGVlZHRlY2guY29tPg0KDQpSZXZpZXdlZC1ieTogQmlsbHkgVHNhaSA8YmlsbHlfdHNh
aUBhc3BlZWR0ZWNoLmNvbT4NCg0KICAgID4gICAtLS0NCiAgICA+ICAgIGRyaXZlcnMvY2xrL2Ns
ay1hc3QyNjAwLmMgfCA4ICsrKysrKystDQogICAgPiAgICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQogICAgIA0KICAgID4gICBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jbGsvY2xrLWFzdDI2MDAuYyBiL2RyaXZlcnMvY2xrL2Nsay1hc3QyNjAwLmMNCiAgICA+
ICAgaW5kZXggMDg1ZDBhMThiMmI2Li42MjkzZDhkMWE2YTggMTAwNjQ0DQogICAgPiAgIC0tLSBh
L2RyaXZlcnMvY2xrL2Nsay1hc3QyNjAwLmMNCiAgICA+ICAgKysrIGIvZHJpdmVycy9jbGsvY2xr
LWFzdDI2MDAuYw0KICAgID4gICBAQCAtNjg2LDcgKzY4NiwxMyBAQCBzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBhc3BlZWRfZzZfY2xrX2RyaXZlciA9IHsNCiAgICA+ICAgIAkJLnN1cHBy
ZXNzX2JpbmRfYXR0cnMgPSB0cnVlLA0KICAgID4gICAgCX0sDQogICAgPiAgICB9Ow0KICAgID4g
ICAtYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIoYXNwZWVkX2c2X2Nsa19kcml2ZXIpOw0KICAgID4g
ICArDQogICAgPiAgICtzdGF0aWMgaW50IF9faW5pdCBhc3BlZWRfZzZfY2xrX2luaXQodm9pZCkN
CiAgICA+ICAgK3sNCiAgICA+ICAgKwlyZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZh
c3BlZWRfZzZfY2xrX2RyaXZlcik7DQogICAgPiAgICt9DQogICAgPiAgICsNCiAgICA+ICAgK2Nv
cmVfaW5pdGNhbGwoYXNwZWVkX2c2X2Nsa19pbml0KTsNCiAgICAgIA0KICAgID4gICAgc3RhdGlj
IGNvbnN0IHUzMiBhc3QyNjAwX2EwX2F4aV9haGJfZGl2X3RhYmxlW10gPSB7DQogICAgPiAgICAJ
MiwgMiwgMywgNSwNCiAgICA+ICAgLS0gDQogICAgPiAgIDIuMTcuMQ0KDQoNCg0K
