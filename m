Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12754A9532
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357054AbiBDIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:35:07 -0500
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:57481
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357031AbiBDIfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:35:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1q72eUARLkX0pNfJirqeULk3XSUCbiwbNoR5byNZMt9YB1nRUpqvA8BxmIxrlK3idzA1yEYSt4PGXLX7Rpgg1x9Go/wCl/EsVFiUhUCwY8CBvaZ42VAaWLe8JalRyqhcLnd8XvE4YtY/2ZQsgWcpLZfmVLeKUSVP4hB5A8jbLHDZ0X2iUwpu3XbX9/FG/2R8cEe4rOsDeu0VKfUjaoYBHNs7guiB1SERIwU2cTsVzCjSqaEKAAUbAMFWK4CKOx8P8bAGAPuEg/Jpde51tbFn2rdTvb8d5DIJ+dudFUNNPYmWF8jJ7gTj1w1QDirgvo8X/SQeaasKYtrBgFXY2mDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55Qi6i9lgMa5b58ovNjWvW+I9NnA+XjuXR8A3Euab10=;
 b=WSIVSQyKYssVj3WEj56u9S0JHCSf+EwEqY7tV7S888gWFw/viTyZVeo6Cuf8L+b4d2e6MiFyiQ6kxxo6yjKIA0jPBmHwYgMWbdjWLDI5I/nqFZLY40Spf4iieMJZo/xzZVqamrQNa97KnBdlaC6n4cCJPg9pxt0NX7g6f7RksaY3loQrOpGTmnFWxhvWJuhVCZlCYjaJGS5DwBLzfWYO8NEb8wKOVkZoGHmeSyGxG0b6p/8h/UXKpk0fN4K4NWiMDNrMXZ1DaBrDPebl3g3wYiKTIFcInoz0JEa89KjY11dC8ckwX9/2KUx7rWYdsfKs0prpyjg1HTnO6yRXImk9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55Qi6i9lgMa5b58ovNjWvW+I9NnA+XjuXR8A3Euab10=;
 b=G9ZPGP+H/qbhu3Xt3cWeIjhLP/HqCHhYRtc+K8LuoEPTQi12ctcWd7802AIaT1i4vjdrl30V6dlPfh7pYCJjwPO8/INBQ0Hu9K1k88MSXC1cz1IZgPvR5G2zRNP+Bg6JJP6oUrQuNLyw53YVQeLM6at+4t/yaduOByqHK5koPuOAJPLqlLmRxDRfGkltzfEA8dw7CCE4QL30O1WNENDlfSrs6q/1xqwsCgP0R5vsUXHO/iDW9+CPDGfIXtf5DBpv0fL6YKTewRh8tWeZspENg9eNR8J6TNEEHdVRsfO9g+wZYcWspPg/79XNM+mP/UVKMc3DZbnpX2aCxdMizDZn+g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 08:35:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 08:35:02 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [v6 PATCH] block: introduce block_rq_error tracepoint
Thread-Topic: [v6 PATCH] block: introduce block_rq_error tracepoint
Thread-Index: AQHYGTpVkG8xOIk86U2gPDuEJ97j3qyCsFwAgABhYwA=
Date:   Fri, 4 Feb 2022 08:35:02 +0000
Message-ID: <ff0d4285-471b-7a33-15a5-3ce89443b41a@nvidia.com>
References: <20220203201207.1075933-1-shy828301@gmail.com>
 <302fa562-612b-0853-31de-a11399e5aa08@nvidia.com>
In-Reply-To: <302fa562-612b-0853-31de-a11399e5aa08@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89cef032-2263-4635-af9f-08d9e7b93cf8
x-ms-traffictypediagnostic: CH0PR12MB5027:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5027B9A58FFBB0C80CB63745A3299@CH0PR12MB5027.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iNpDB/u4+d3R8dd7WEXafxTj2QHAwRktZA9R2o4Tq43pI2cwRIKl8myYPThKrYHr01FEVFaIxgQzlmmmJZf/EGyGN0QD37Njaay1xemhg3sCgxovfrh96G08xjNtW8HXmL0Chtn55mCjDdf5nHvQz0fOeo8FZakhSPNGN3Y6/xcUcXZf8h9iN2U7iG/zsmVD7rz6CQ7mDSYdmwhs5H7Na9klErPswJfmbONO+nVelsfCeMRAgDcNT+1NsVCH1jUgPdE4xNIwDuERI0ljzP8Y4AhW8onXWh+dnzXpdNlSz193k8HAwvxGkY0hpCv27M14anR8BzAS3oriTLrurRhJQLHLzBg7HBby/FegJ/CpKOpv/2+wLuMCgfeH47L7FquwYVuPSFYGSqgWdWkzKsCm6NyswvJCWvcQr/QuP2p16Muk9RZcf/nwcwu3/Gk1WLLLsEXaN3bHZSVWemRhI8LMplOCjHlSGGNwNd929j+xKcVonbveqw0+GFGd30MW0jRKA0Lnu2DpEx1W+Xbr+khn63latxT5xnkQfSIq6GL2LcLELyUBpgTFeDhJ0IJUtCBGZfm+GutkAmslDzkSWpoLf+EHjsi8O2qpNuE1hM2V5u0ZphuD5U73GxQrKQSzyfXg8v/ESU9AA6mQhLTac32Ls5gV3dyXGRJHJO6ZAFy7Or51EUXHflpPQE13CHeumHgWZVSJKV3A6zC0pllDCvAjmb69AAXjc4yKq0GavYF1rI7gjlxpN9Xl4EgBKG8OIRg9now0rrnIJs3faT5EZFpsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(5660300002)(186003)(2906002)(2616005)(38100700002)(6916009)(83380400001)(54906003)(36756003)(31686004)(508600001)(4326008)(8676002)(66556008)(66446008)(66946007)(76116006)(71200400001)(122000001)(316002)(86362001)(91956017)(31696002)(8936002)(6512007)(6506007)(6486002)(64756008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wm1FWTBObFo2NktWUXFYQmwxbzRwclZPeUVYNm8zWXhHZ2QvazY1Y2hvSjJu?=
 =?utf-8?B?UDZYRkFQWnJJWWhiLzErbFRtZVJYRENONHpJOGtURTcxbE5kMlZtNVBObTNX?=
 =?utf-8?B?eXVEcURlOWFPQU1ObkZOK0luQWp4b0IrZUszb2pwVXlqWnN2Mjhrcjl4TElE?=
 =?utf-8?B?bU1JTVhWUWJUUnFKNjNyTWZTMnFnUmhMelhGbzRrZEZlNEo0aHFRMXBBTnor?=
 =?utf-8?B?emJrMWcxQ0M4WCt5Q3RvdUFDenNyWGtoSzY2ZXltN2s5OWpQUXBZQ2tjS1cx?=
 =?utf-8?B?NVJEbndILzlVVHdBajJkV2UrVWZJMldmcjViZVVrQU83a1JoclpZZlJ0ZHlm?=
 =?utf-8?B?bVFFcmM2VjJsVDU1dER2RWV4cUY3NEZ4YXpFaWdDN1Q1UWZ2aTFNcElOQWR5?=
 =?utf-8?B?ZEx0UDRtUk8vY2NpK3R6Y3NuTTdMQWhpSzJEZW1XY1gzMFVva3FKOWtneXFI?=
 =?utf-8?B?dU52aDI2TkthSUZhQWpLOTJlYjR2ZTVSS3lTRzdHRXFRdXUzU3BDUlNRN3BD?=
 =?utf-8?B?MkQra05aaUZsazdMcVFVdnM4bXEwSzdyYk9PY0RwaWo0MGZLaUFCYjljei9X?=
 =?utf-8?B?Qjlpbi9hVWsvR2VBNGo0RUpWUDBaeEpFQVFRZHVKMDVRcU92WnJpMTVMbytv?=
 =?utf-8?B?OUtrWXlPR1N2aTFnaXM1YkNMalFYdmc0aGg1RGMzT1AwdjB0REc4UjhCcUpj?=
 =?utf-8?B?MVVUaVM3V1BBdStvVzl1QURiYllhSENBWnNBcmJtWkFaNjg1bGdGdnNJYzJ2?=
 =?utf-8?B?QURqaThBeU4wWlZjdmViR0hxVXlSbGJlaTFOMVZLQjExTmRiRDI4RzA3eG1X?=
 =?utf-8?B?Zyt4THNSeFgxSzQ0aVJ3ZndwVHRrREdQeDE0azlqWEZVMGFzeWViKzI1b2Fs?=
 =?utf-8?B?d3JXUnFsdVRCQUF3NlhnOXJnT2lYTDlxN0IxTkxsTExsUmZsSVlsY2ZMTXZy?=
 =?utf-8?B?aGJkdGtjZWROeG84NGgzMGpJWlFlaTFnbzdSOEpKZ0VKcDJSRVl1WEhMTDFi?=
 =?utf-8?B?NENCWFFrc1JQaTBDak5uRGhIU2JlUVVqTHkxQURGQ3JvUVhPeERWckZXOTlV?=
 =?utf-8?B?KzlEY2F5Q0JqeHFBa05Za1VkbXZUc04wZVJua1paekgyOHBTdTl4OHdBUGoz?=
 =?utf-8?B?UWtPeTBiL3FFL21aRW9qS1k1SWRFM1h1MEVTeXRJbk8yVXhtQTVzUktKbWtG?=
 =?utf-8?B?Y2s2QnY1c3dCZnNsTC9KRXhPS1Z5TkRGWmtBZEJKTWlPMTZqdVk1NnRQMXFC?=
 =?utf-8?B?ZjJUdmc4ekY4d0hsMmNqOTJELzNYeG1xYlo0cDBQNUhCaGZKZG43VmJYN2ZH?=
 =?utf-8?B?NUVhSUdUejY2ZUhCSm1ZZC94Wi8rZWNCMFFUUGZDZ1p6VGFmaEh3ZTJNWE54?=
 =?utf-8?B?RjZUU0dIUVMrbWwrSVlwNFcza3JYZHNQaVA5eFhQaVM4TG8zMlptZDhZUFA3?=
 =?utf-8?B?U3Z6MzN0eEx5UVdMQ2ZvUXpFSDB2UlRJNG50S1lsNnNBQnBjRjlZVWxHcHRP?=
 =?utf-8?B?MjVUdnlzUWZWTkNMZTJibkRwUk1xYk5PNllxeTVLRTlpVDhpQ0R3b1VoWjAv?=
 =?utf-8?B?dmF4UHM3blM0bkxsRTJFRkpHbUMrcWhlV2JxV3ZYSFhETmhubEE3b3lMZE5l?=
 =?utf-8?B?emh4Q2tKQ21HbEUzRnl0Mnc5ZVVTbk40OVNYTWhrMlppWjlvT2RVODN6MG1t?=
 =?utf-8?B?VUhRMkM1MUJmaDVTVjJUT1o4VFRqUXNlc0NtUm0wRWg2UXQ1TGQ1ajAxUEhI?=
 =?utf-8?B?VUZPV2I5dk5wNXpiRSs4Z0pzMEVGUU1RajN2UndUREV4cnJISFdZWEhQbnVk?=
 =?utf-8?B?WndBQlNCaWx4eUl6eXJXMkVTeXhCZFdzbkdCTnpPL1B0TzR0MTRCQVIxbmt5?=
 =?utf-8?B?U3J0RG50U0VWTjg1S3VWV0Y4WmIwSWwwUkwvRkN6cUswS0RjcTZ0dnMxWnJN?=
 =?utf-8?B?NFlTb3J6dldweUhINHpjVDMveHN6RTJSc2VFdGVlVEdVNDJ0QUFWYnJSMDUz?=
 =?utf-8?B?VHJxc1FzQi8xb2NoYVNvSUtYUm9VRmFJVm01aU50d0E3dS8ybkx1bVZhRzNI?=
 =?utf-8?B?WE9oaTJMbmd0MG16RlhXNWxhNDBYa2cyK29WdGVoMG9scWpLUjRJbDJteHFO?=
 =?utf-8?B?bG4zQ05rMEsrUGZOUTBKUWt2MGVWZElaem8wRkJiR2tyazFOejF3QmRJNnRK?=
 =?utf-8?Q?m1E6PShNFCvPRzznfiBmp4oprTtD2yXZKB+A6y0BFg6M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <717FE8E0911CD0429CF6543DABCBDFB4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cef032-2263-4635-af9f-08d9e7b93cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 08:35:02.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgXPWHN06FShqM46AkRmhYvJf+xOckK21aLwk0LYdwF6zZRB+iRVn2F9X3ryfTYvmeVLWyrUb9AEb14VA1nB5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWFuZywNCg0KPiBRdWVzdGlvbiAxIDotIFdoYXQgcHJldmVudHMgdXMgZnJvbSB1c2luZyB0aGUg
c2FtZSBmb3JtYXQgZm9yDQo+IGJvdGggYmxrX3JxX2NvbXBsZXRlKCkgYW5kIGJsa19ycV9lcnJv
cigpID8NCj4gDQo+IFF1ZXN0aW9uIDIgOi0gYXNzdW1pbmcgdGhhdCBibGtfcnFfY29tcGxldGUo
KSBhbmQgYmxrX3JxX2Vycm9yKCkNCj4gYXJlIHVzaW5nIHNhbWUgZm9ybWF0IHdoeSBjYW4ndCB3
ZSA6LQ0KPiANCj4gZGVjbGFyZSBERUNMQVJFX0VWRU5UX0NMQVNTKGJsa19ycV9jb21wbGV0aW9u
Li4uLikNCj4gYW5kIHVzZSB0aGF0IGNsYXNzIGZvciBibGtfcnFfY29tcGxldGUoKSBhbmQgYmxr
X3JxX2Vycm9yKCkgPw0KPiANCj4gc2luY2UgaWYgSSByZW1lbWJlciBjb3JyZWN0bHkgd2UgbmVl
ZCB0byBkZWZpbmUgYSBldmVudCBjbGFzcw0KPiBpbnN0ZWFkIG9mIGR1cGxpY2F0aW5nIGEgdHJh
Y2Vwb2ludCB3aXRoIHNpbWlsYXIgcmVwb3J0aW5nLg0KDQpXaGF0IEkgbWVhbnQgaXMgZm9sbG93
aW5nIGNvbXBpbGUgdGVzdGVkIHBhdGNoIChhbHRob3VnaCBpdCB3aWxsDQpuZWVkIHRvIHNwbGl0
IGludG8gYSBwcmVwIHBhdGNoIGluIG9yZGVyIHRvIHBvc3QgaXQpIDotDQoNCmRpZmYgLS1naXQg
YS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9ibG9jay5oIGIvaW5jbHVkZS90cmFjZS9ldmVudHMvYmxv
Y2suaA0KaW5kZXggMjcxNzBlNDBlOGM5Li43ZjRkZmJkZjEyYTYgMTAwNjQ0DQotLS0gYS9pbmNs
dWRlL3RyYWNlL2V2ZW50cy9ibG9jay5oDQorKysgYi9pbmNsdWRlL3RyYWNlL2V2ZW50cy9ibG9j
ay5oDQpAQCAtMTAwLDE5ICsxMDAsNyBAQCBUUkFDRV9FVkVOVChibG9ja19ycV9yZXF1ZXVlLA0K
ICAgICAgICAgICAgICAgICAgIF9fZW50cnktPm5yX3NlY3RvciwgMCkNCiAgKTsNCg0KLS8qKg0K
LSAqIGJsb2NrX3JxX2NvbXBsZXRlIC0gYmxvY2sgSU8gb3BlcmF0aW9uIGNvbXBsZXRlZCBieSBk
ZXZpY2UgZHJpdmVyDQotICogQHJxOiBibG9jayBvcGVyYXRpb25zIHJlcXVlc3QNCi0gKiBAZXJy
b3I6IHN0YXR1cyBjb2RlDQotICogQG5yX2J5dGVzOiBudW1iZXIgb2YgY29tcGxldGVkIGJ5dGVz
DQotICoNCi0gKiBUaGUgYmxvY2tfcnFfY29tcGxldGUgdHJhY2Vwb2ludCBldmVudCBpbmRpY2F0
ZXMgdGhhdCBzb21lIHBvcnRpb24NCi0gKiBvZiBvcGVyYXRpb24gcmVxdWVzdCBoYXMgYmVlbiBj
b21wbGV0ZWQgYnkgdGhlIGRldmljZSBkcml2ZXIuICBJZg0KLSAqIHRoZSBAcnEtPmJpbyBpcyAl
TlVMTCwgdGhlbiB0aGVyZSBpcyBhYnNvbHV0ZWx5IG5vIGFkZGl0aW9uYWwgd29yayB0bw0KLSAq
IGRvIGZvciB0aGUgcmVxdWVzdC4gSWYgQHJxLT5iaW8gaXMgbm9uLU5VTEwgdGhlbiB0aGVyZSBp
cw0KLSAqIGFkZGl0aW9uYWwgd29yayByZXF1aXJlZCB0byBjb21wbGV0ZSB0aGUgcmVxdWVzdC4N
Ci0gKi8NCi1UUkFDRV9FVkVOVChibG9ja19ycV9jb21wbGV0ZSwNCitERUNMQVJFX0VWRU5UX0NM
QVNTKGJsb2NrX3JxX2NvbXBsZXRpb24sDQoNCiAgICAgICAgIFRQX1BST1RPKHN0cnVjdCByZXF1
ZXN0ICpycSwgYmxrX3N0YXR1c190IGVycm9yLCB1bnNpZ25lZCBpbnQgDQpucl9ieXRlcyksDQoN
CkBAIC0xNDQsNiArMTMyLDQxIEBAIFRSQUNFX0VWRU5UKGJsb2NrX3JxX2NvbXBsZXRlLA0KICAg
ICAgICAgICAgICAgICAgIF9fZW50cnktPm5yX3NlY3RvciwgX19lbnRyeS0+ZXJyb3IpDQogICk7
DQoNCisvKioNCisgKiBibG9ja19ycV9jb21wbGV0ZSAtIGJsb2NrIElPIG9wZXJhdGlvbiBjb21w
bGV0ZWQgYnkgZGV2aWNlIGRyaXZlcg0KKyAqIEBycTogYmxvY2sgb3BlcmF0aW9ucyByZXF1ZXN0
DQorICogQGVycm9yOiBzdGF0dXMgY29kZQ0KKyAqIEBucl9ieXRlczogbnVtYmVyIG9mIGNvbXBs
ZXRlZCBieXRlcw0KKyAqDQorICogVGhlIGJsb2NrX3JxX2NvbXBsZXRlIHRyYWNlcG9pbnQgZXZl
bnQgaW5kaWNhdGVzIHRoYXQgc29tZSBwb3J0aW9uDQorICogb2Ygb3BlcmF0aW9uIHJlcXVlc3Qg
aGFzIGJlZW4gY29tcGxldGVkIGJ5IHRoZSBkZXZpY2UgZHJpdmVyLiAgSWYNCisgKiB0aGUgQHJx
LT5iaW8gaXMgJU5VTEwsIHRoZW4gdGhlcmUgaXMgYWJzb2x1dGVseSBubyBhZGRpdGlvbmFsIHdv
cmsgdG8NCisgKiBkbyBmb3IgdGhlIHJlcXVlc3QuIElmIEBycS0+YmlvIGlzIG5vbi1OVUxMIHRo
ZW4gdGhlcmUgaXMNCisgKiBhZGRpdGlvbmFsIHdvcmsgcmVxdWlyZWQgdG8gY29tcGxldGUgdGhl
IHJlcXVlc3QuDQorICovDQorREVGSU5FX0VWRU5UKGJsb2NrX3JxX2NvbXBsZXRpb24sIGJsb2Nr
X3JxX2NvbXBsZXRlLA0KKw0KKyAgICAgICBUUF9QUk9UTyhzdHJ1Y3QgcmVxdWVzdCAqcnEsIGJs
a19zdGF0dXNfdCBlcnJvciwgdW5zaWduZWQgaW50IA0KbnJfYnl0ZXMpLA0KKw0KKyAgICAgICBU
UF9BUkdTKHJxLCBlcnJvciwgbnJfYnl0ZXMpDQorKTsNCisNCisvKioNCisgKiBibG9ja19ycV9l
cnJvciAtIGJsb2NrIElPIG9wZXJhdGlvbiBlcnJvciByZXBvcnRlZCBieSBkZXZpY2UgZHJpdmVy
DQorICogQHJxOiBibG9jayBvcGVyYXRpb25zIHJlcXVlc3QNCisgKiBAZXJyb3I6IHN0YXR1cyBj
b2RlDQorICogQG5yX2J5dGVzOiBudW1iZXIgb2YgY29tcGxldGVkIGJ5dGVzDQorICoNCisgKiBU
aGUgYmxvY2tfcnFfZXJyb3IgdHJhY2Vwb2ludCBldmVudCBpbmRpY2F0ZXMgdGhhdCBzb21lIHBv
cnRpb24NCisgKiBvZiBvcGVyYXRpb24gcmVxdWVzdCBoYXMgZmFpbGVkIGFzIHJlcG9ydGVkIGJ5
IHRoZSBkZXZpY2UgZHJpdmVyLg0KKyAqLw0KK0RFRklORV9FVkVOVChibG9ja19ycV9jb21wbGV0
aW9uLCBibG9ja19ycV9lcnJvciwNCisNCisgICAgICAgVFBfUFJPVE8oc3RydWN0IHJlcXVlc3Qg
KnJxLCBibGtfc3RhdHVzX3QgZXJyb3IsIHVuc2lnbmVkIGludCANCm5yX2J5dGVzKSwNCisNCisg
ICAgICAgVFBfQVJHUyhycSwgZXJyb3IsIG5yX2J5dGVzKQ0KKyk7DQorDQogIERFQ0xBUkVfRVZF
TlRfQ0xBU1MoYmxvY2tfcnEsDQoNCiAgICAgICAgIFRQX1BST1RPKHN0cnVjdCByZXF1ZXN0ICpy
cSksDQo+IA0KPiAtY2sNCj4gDQo+IA0KDQo=
