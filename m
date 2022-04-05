Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B7B4F21AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiDEClS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiDEClJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:41:09 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2063.outbound.protection.outlook.com [40.107.114.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B40F2B5AFB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNsm+8k2iqYPG9QJYaSaRwY5hQMwuE0wwZJnk8GiLYFx5Popn4ejRZhcYHzsOph8cMvFcUZdzRwyr/cB5gJWC8bWau1cUlWqdgD+MDaKGeQXpeM7Bhu9Zyf0Pica5U3J2kPcimbpOmMiJE3aiFw8RL/KroMkpuIjB4GtZgzBEj17Uqx32BhmjsmhvEcWEE8tqpVIyCilTYIxHPA3FN4SKnlSfICB6IvmfP8H2IBz3gIypktBHnu+AvtblQLslmWPp95TVYtwujK7APLu3OM4RMGqp1o2Ykf7YRt0ETCsRG2WXlxlvNPaSQDYjlMg5pB3QqpGU687osqTxfnU/nfGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h38smAHqCvw12Oz9Qw55LA0a0zfLyNQnvznXnp0nNgQ=;
 b=IRRjHpvDUbkFbO598Y7kOWiCYlsK+gFtCVKgxD0YvcOITAi/BKlMIjdS0RiIww1cDn3F0XO7cp7wCFgiKFRN8O9k2+pypBfOB4ncMDT3182+4Seist0cVlB9UXNWviX4XadF0xSlVqdi9vBu4D8zaH6Ot3X/0zc7tUQRb7TXR8Rn4vUO1l8AiNuekZ0YD+S65CWYx+YwqhLDmAd22IUtFEwH9k57ZUWhv+qSit6yOzo5f9pLfEotRGeLWHoBJcauDiQ7//ALW/kaKU84E4skOJb+IBUQCKbg/DgBsUUTPn/cnDgbRlephpXg/yljkew062WzaZCuOitQiYAvYkn+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h38smAHqCvw12Oz9Qw55LA0a0zfLyNQnvznXnp0nNgQ=;
 b=gY9wcEvwE9XjP71GYL0DUBT33IJEj3wi4La1DMTctNJIUhNC9zt6FQDjRhwc4BQburQwam9xugFu+0iYEWt16f1sqmbQsz6971GQqUrI84FCNsC/tfYmwbIATLecB5K6UZSng8lytCg59cLdtvPXrXkdmsvYMUwXqrSDw9+jqj4=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB4356.jpnprd01.prod.outlook.com (2603:1096:604:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 01:45:46 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 01:45:46 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Topic: [PATCH v6] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Index: AQHYSAVstIN6BKn6wkSgRHHanLQNg6zgGoWAgABzKgA=
Date:   Tue, 5 Apr 2022 01:45:45 +0000
Message-ID: <20220405014544.GA2583652@hori.linux.bs1.fc.nec.co.jp>
References: <20220404092131.751733-1-naoya.horiguchi@linux.dev>
 <20220404115333.8cf80b9d3a7a55993ed60c57@linux-foundation.org>
In-Reply-To: <20220404115333.8cf80b9d3a7a55993ed60c57@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb067cbd-8637-4952-ea1e-08da16a600d3
x-ms-traffictypediagnostic: OSAPR01MB4356:EE_
x-microsoft-antispam-prvs: <OSAPR01MB43564CFD71291AE3CDD4CEECE7E49@OSAPR01MB4356.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJ2UMq4/TdKm94CZSzaVTATOuhShj3M3+mfHX5mJgnL7g8y5SSbo3QHgUS06vmUiabX8C1udg4gOqidJWnsFazk4OQCUTKu4ASfLTU7JOnW93ocD59g1mHU21zvny+PNOd5BmSEINP5MndG9iF+tQB9FCcegZWSDoI0rSfhO9Ubv+yyW0oeOcqNE4ZSQDQLpBH4uc/iOL+V0xgkXskqrTh1fOdGx2DjMz0GN4+zGJhNp/+zTpTlPjcIsdAS8VeAhZ/VgyV+GfPIdougkIe5ql4AccYk0q4B0mzCZ5ASjPMXj3hytjSCD+o45OM38gGmlPafD1I2O4r29JFRrt2p5RIzI/H3r96hbUHJdDLipHEidHHsfn1IwCY7NRoz4iHzXKGGEyc/pM0vl5DZAoHN3bp3Bbtm1u7050CSdkFetjRvfgdNkNkJQswklxHCWZn4jWTzEeQRWkBtbF+fa3v3hdckuWRMRXd5Mt0ciJgghS9RmDJF+Ko66sFuDTxq2qLps/Jc4FnK9X3Xpt0QS2NJ5mKniY7BQn29yu9LJ70F1VuJDYfo49a+MjN0Hy8UeqiMRRewg4InP22YkntScXLrtsp8jtcV2MEUsLCEtu1rRBkUW+Jk8/+T2VnkV22eznNtvmzrPwKLV0uKQIrCKMEumU+YEkvkHtfGed+6GM9RXAV2N2zUlqPRMFWExwS2QAd8aEpbCvgQqo6mGnjfCx3Rt+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6486002)(9686003)(6512007)(86362001)(508600001)(38100700002)(2906002)(33656002)(6506007)(55236004)(82960400001)(122000001)(8936002)(38070700005)(66476007)(66556008)(26005)(186003)(1076003)(83380400001)(316002)(71200400001)(85182001)(64756008)(76116006)(4326008)(54906003)(66946007)(8676002)(66446008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFBaYXR4L2JDWVcwQzNMMzVwK3hLbm5IYlQvZFRjOGxVbFl5ejhMMlhOc2o5?=
 =?utf-8?B?SE5MaWJIaklobm1RVEdMbEZlUFkvNzdrWEE5aFF4V1FiMlZ3Smx5YW54OEJm?=
 =?utf-8?B?cWp1Q1ZCOGxBSUNpNTF3aFdQdlF0aCs4VkFYb3NUMkxWc1BHczdiN3oweG9W?=
 =?utf-8?B?MXlTRlJhWHhVTDdCVHI2elRTYU5UMnVtYWR4RGc2MkdxYXJGNW9lV2RjSG5z?=
 =?utf-8?B?TXhQRVU0Ym5lN0gyeW9SUEU0OEM3QVpmS1FIT3ZmSCtCa2NmQzcyZVZybWE2?=
 =?utf-8?B?U0lCOWVhbG5HRnVLbnprdWZ2bGx5aEU5MW5pQVVUQTZUMWU2QTRyWTV5NGEr?=
 =?utf-8?B?OUFKa0UvYWhoL0VaRXFpak1kbWJkRFVRczlBSFNFVnovdENzVzBCU0pza1No?=
 =?utf-8?B?NDI2Z3lCd2pwN2NHUkZUcHoyU2o4QkIrK0FhL2hRUnVLSHZ4WXRlU2hJVDRG?=
 =?utf-8?B?ZTRJNTMwTUVDN1ZOTlhWcFg2NDZlMG5USGkzR0VLa2JyQ1F4SDU4bUpJOFhZ?=
 =?utf-8?B?cWtoUEI2c29tajd2UXBGcW1nczIzUnJkVWJXQnVNR3FQVHIyajhWOWZPcjRl?=
 =?utf-8?B?bjQwNzdIZjhKVEgxd0loRVdpT0NHblZwSW9MbVVUamV5VGIyZ0kvZWI1VCth?=
 =?utf-8?B?MmlGQmdSZGxsS0hlOTRTMTdObjJ6V2RJZTZsdklNU3JQWGxrbDBVdVpDdkNU?=
 =?utf-8?B?MGUzekVUcE9vTnlKeEJsenhjSDhZb085dGo5dllwSXliZE9Bd0x1WEw0aU13?=
 =?utf-8?B?MHpIZXRBSGhIMHhiVmFjN1NNOWhkZFppdTdwUjkxM3VOQmhsb2xsUi9qdGFp?=
 =?utf-8?B?bUk4ZnZySUppYnd3QXRRV2plU1RadlNtR2F4czF5V0EzSFRBeW1lNUxieXVT?=
 =?utf-8?B?RzV4RFAwWXYrd21jZ0lMbGRNUWhUUGpvU0g5QjV6V05CckVTcU9ycU1nRWdy?=
 =?utf-8?B?dVVmd1M5cS9uT2hJeW5HNG1EaFBnNDk4OU53ZDlNYkdWSThNUkh2eklZeldv?=
 =?utf-8?B?akVsWWFMTWZVeDR3ZEtFZVBtVXJ5YU5rVmZMSm5lZzlhRVdBR25BenNZajV4?=
 =?utf-8?B?dzgzaGx1QW93Ujc2TytzZ0lXZDV4aGZZcFdIZjR6SzFkaEhNRGJUTENDcGh1?=
 =?utf-8?B?bXkvME1Rbm9YaXgzNGJIYUVXSXBvVDBXTTIwT2taNnBOQmJ4dm5FRXBLQk5B?=
 =?utf-8?B?NzVvZitRSno3d1VNOU04a2trTk1KVk5kSytwb3ZnQ2w2bGxhV3AydHRKdFM3?=
 =?utf-8?B?dlRyN1pPMTU1SEJDT084UVZxZ3ZQcWhLbkdRc3VKUXpHc3hKMWV1MDBON2Y4?=
 =?utf-8?B?ak9LRUpCWUdDVjlHMHFhbnVrd01TMGlwZnY0OHdBazhKNnkzVTBIMWl2U3di?=
 =?utf-8?B?QkI2OWQ5dll3YkxyR1JMYnp2cEhnYW4rU3RKMlRSaUdmbGplWGJmTHZlUlhj?=
 =?utf-8?B?SnlwKy93KzNyc0E0STdCY2pxaW5nN2FVM3F4VjBxdjlUOWkrNDZNRXh4SHkv?=
 =?utf-8?B?dy9VUnlnRGVGWnovMEh2d1dWZzIzbVI2Q0ZmZEJhMnFRRWR6QTdKV2xEOFBk?=
 =?utf-8?B?bzBlSmVhQXRsNTQwbGxMLzRDdHVISGJLMmwyN3dwRFdnREV3cnlMZjBqTG1X?=
 =?utf-8?B?V1BnWWN5enhWVE5BSXJ1UnlJNkYreWtjeDhFdHhFZ2V4T0Voa2ZmYlZwMG1B?=
 =?utf-8?B?VFlSTnppYkM2Nk53NXFyT1dBaGlqUjFNZ3hDelY1OHhJZFd6YTBPREVvT3Jw?=
 =?utf-8?B?VU9Wbm82M1IyaklyeHRDaGMvTXh0ait0ZGRoMkNXQXRhQUV0RG5Td3V3R1Vw?=
 =?utf-8?B?M1lCK1J2TWlPVG1HbW1HMzJUMzJINWUvMWNsZlhVR1dJTFBCaTlLUEJqTG5K?=
 =?utf-8?B?TWxqV2c1cUxDOUlpVVN1SWJkejhCWThyb2hZQkJuSU04bkcyUk00VzUwTTJM?=
 =?utf-8?B?SnBaRWNkdjZ4NnZaMkFyTWdsTU5JYWZEenhkVEh4Mk1OTWs5cVhtb2Yrcjlh?=
 =?utf-8?B?RG5UUy9XQkI3OVlEblJxUlEwNk9iUXk1TzVQdFZlTEIyMzVvYUU5UXp5Umcr?=
 =?utf-8?B?a2FMWTBNTVo5MFN2RnJjc2hqVUNyN0tpK282KzZ5NUp5Y1FBeFQ4K0hnYkU3?=
 =?utf-8?B?Y0VGVlBsak1JNkJMNTBDVUs0K0FyNXdvUlFQN0RWRlp6ZkE2TEU5eEtZeUpB?=
 =?utf-8?B?MTZNOCtLT1dHQldrS1Y0dGNoVWhzUndFbVlPanh2cFFlWmxiS21oM1M0RHdx?=
 =?utf-8?B?S1lCcEJESDJGaEN4Wm5scHlKbk0ycmlJeFlHTXdzOS94c2FwQmJobW5xVjdr?=
 =?utf-8?B?VTZXWVpZQVY3QlZReEE5YzNsb1l2VHpPK3F4N2JsclR1UkZONE9ncTVMNkE5?=
 =?utf-8?Q?9v1YBk/wvimhqhb4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <950A72660F39F94AA2801E8B41DA6AEE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb067cbd-8637-4952-ea1e-08da16a600d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 01:45:46.0304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPRSN8EyORzbxm/fU8CgHFPML+/Vllo3Sk/wQE2iBUM3Mwpb8BZaGeAhpP98DxsHEf7nbn4HIK4BFKV68IQMTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMDQsIDIwMjIgYXQgMTE6NTM6MzNBTSAtMDcwMCwgQW5kcmV3IE1vcnRvbiB3
cm90ZToNCj4gT24gTW9uLCAgNCBBcHIgMjAyMiAxODoyMTozMSArMDkwMCBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBsaW51eC5kZXY+IHdyb3RlOg0KPiANCj4gPiBUaGVyZSBpcyBh
IHJhY2UgY29uZGl0aW9uIGJldHdlZW4gbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigpIGFuZCBodWdl
dGxiDQo+ID4gZnJlZS9kZW1vdGlvbiwgd2hpY2ggY2F1c2VzIHNldHRpbmcgUGFnZUhXUG9pc29u
IGZsYWcgb24gdGhlIHdyb25nIHBhZ2UuDQo+ID4gVGhlIG9uZSBzaW1wbGUgcmVzdWx0IGlzIHRo
YXQgd3JvbmcgcHJvY2Vzc2VzIGNhbiBiZSBraWxsZWQsIGJ1dCBhbm90aGVyDQo+ID4gKG1vcmUg
c2VyaW91cykgb25lIGlzIHRoYXQgdGhlIGFjdHVhbCBlcnJvciBpcyBsZWZ0IHVuaGFuZGxlZCwg
c28gbm8gb25lDQo+ID4gcHJldmVudHMgbGF0ZXIgYWNjZXNzIHRvIGl0LCBhbmQgdGhhdCBtaWdo
dCBsZWFkIHRvIG1vcmUgc2VyaW91cyByZXN1bHRzDQo+ID4gbGlrZSBjb25zdW1pbmcgY29ycnVw
dGVkIGRhdGEuDQo+IA0KPiBTaG91bGQgdGhpcyBmaXggYmUgYmFja3BvcnRlZCBpbnRvIHN0YWJs
ZSBrZXJuZWxzPw0KDQpUaGlzIGlzIGEgYnVnIGZpeCwgc28gZWxpZ2libGUgdG8gc2VuZCB0byBz
dGFibGUuIEJ1dCBJIHRob3VnaHQgdGhhdCB0aGlzDQpwYXRjaCBpcyBsYXJnZXIgdGhhbiAxMDAg
bGluZXMgKGFuZCBoYXJkIHRvIHNlcGFyZXRlciB0byBmaW5lciBwYXRjaGVzKSwNCndoaWNoIHNl
ZW1zIHRvIHZpb2xhdGUgdGhlIHJ1bGUgc3RhdGVkIGluDQpEb2N1bWVudGF0aW9uL3Byb2Nlc3Mv
c3RhYmxlLWtlcm5lbC1ydWxlcy5yc3QuDQoNCkJ1dCBhY3R1YWxseSB0aGlzIHJ1bGUgbWlnaHQg
bm90IGJlIHN0cmljdGx5IGFwcGxpZWQgKHNvbWUgcGF0Y2hlcyBpbg0KdjUuMTYueSBkbyBoYXZl
IG1vcmUgdGhhbiAxMDAgbGluZXMgZGlmZi4uLikuIFNvIGlmIHdlIGNhbiBpZ25vcmUgdGhpcyBy
dWxlDQpleGNlcHRpb25hbGx5LCB0aGF0J3MgT0sgYW5kIEknbGwgYWRkIENDIHRvIHN0YWJsZSBh
Z2Fpbi4NCg0KVGhlIHRhcmdldCBjb21taXQgb2YgRml4ZWQ6IHRhZyBpcyA3NjFhZDhkN2M3YjUg
KCJtbTogaHdwb2lzb246IGludHJvZHVjZQ0KbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigpIikgd2hp
Y2ggd2FzIGludHJvZHVjZWQgaW4gNC4xMywgc28gbW9zdCBvZiBhY3RpdmUNCnN0YWJsZSB0cmVl
cyBhcmUgYWZmZWN0ZWQuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
