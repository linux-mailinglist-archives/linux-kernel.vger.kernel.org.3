Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A884458071A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiGYWJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiGYWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:09:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2099.outbound.protection.outlook.com [40.92.23.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B02495B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHpeXlhABqiJD7ZdImvW5M8KC9VogopvQ9uaj2XkgppUFT5xYK3CmxhqvFGOF6BbGx7V68evtS+kkvBdA1IaeF0wqYfFq1gorcE60dyHh96G9OGkdS40BVbqMDnPf4CJ9c7kJ4lmdN2LjfGlw2gc8blnlpeIIoQTiPqUf8Sm1crG7uFz4kSCXDW//+f5gTo+NG0iikAM5gBNQcU1od0V0FY3k9vfbXqNMSmJrDpPzi39dV5a3i03a6YcNIjpScFnvoavn7FGIE39cQXfCSBBBloSSNO78GnJ7FYVUwg/vMo5kVvn/aVCieV3PrRJbD0Z/PiaXSinG8dhzwmUPtmXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq+3E6FYRkCt62T4viihl14i+/Ir0D/aCTdH4lA5tCg=;
 b=OqLo4UftkJpTtXsZci6fNhHcondWjJYzvw2dNwBh4Gh9EGjx44HbKy+AjzDwJms4hr4ZkMS7b5NjjnyEloJE9nsYADRM2QKQlRYz+REaQxrdtPlS8YsDDaoMHfH9I4OtLVwmLsOGXxTaZgDaCUBbRlL0CuLX0kwMUG/GKL8XPwcm+xNioLGCnd98xu3YN2vMIYIamDwnDOQo2QRpgReC7egpeNhXVNZjmsnrAOzasb0NtuOJ8qempo8Ol7chQu1laxFH7dkzyV1ze2HBOubv7owIy9LQup1enGtRurAGKka/MdREf+3LvWfGtPHA8JJENvzO07kEOMU00Lq+HTj3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq+3E6FYRkCt62T4viihl14i+/Ir0D/aCTdH4lA5tCg=;
 b=W19gdZlrGhnh6ktMqpV/R/9RYQtcEX1zAJTLMl2oi+akdZwWnLhIf9HFlLO3O8GytE/ZSc5gMjlP2ANUlEDlLLltRBi+Y/MYKHT7sN/aFEa5tvjkME7wHM9yLBmPaI3bsNl0/sFT5/sFZHX8zZ7DHLPXI5ZON83YQJ+BCws9wys9whKuXwDBGZwXDnSBI+IaQYNniT17UpKQqrZSbrtnAdcjrrV59roRK4uDBorH/voTbEJZcaHkjPfuZbheBPXF9YMKPYv+KOA+g6eCfl8J3D5wbbTTiuWP8A+/ZDRuu3HnFw4/zTiHZLaM4l9UQoWeASSmN6+ukRlcCPoUKpEgtw==
Received: from MN2PR17MB3375.namprd17.prod.outlook.com (2603:10b6:208:13c::25)
 by BL0PR1701MB2547.namprd17.prod.outlook.com (2603:10b6:208:7e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 22:08:57 +0000
Received: from MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba]) by MN2PR17MB3375.namprd17.prod.outlook.com
 ([fe80::3409:88f8:6069:ccba%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 22:08:57 +0000
From:   Vanessa Page <Vebpe@outlook.com>
To:     Yifei Liu <yifeliu@cs.stonybrook.edu>
CC:     "ezk@cs.stonybrook.edu" <ezk@cs.stonybrook.edu>,
        "madkar@cs.stonybrook.edu" <madkar@cs.stonybrook.edu>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Topic: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
Thread-Index: AQHYn+OlL8EDeVsAXEe8Sw4ix6TwWa2OiB5VgAEeYNc=
Date:   Mon, 25 Jul 2022 22:08:57 +0000
Message-ID: <MN2PR17MB3375207FA1AF24E6666BC95AB8959@MN2PR17MB3375.namprd17.prod.outlook.com>
References: <20220725045830.11502-1-yifeliu@cs.stonybrook.edu>
 <MN2PR17MB337506A10F6AF87BBC514F97B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
In-Reply-To: <MN2PR17MB337506A10F6AF87BBC514F97B8959@MN2PR17MB3375.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [WF2mHJRf1BTOUvEZDg5bWhht5B1BfQ+09YcD51HEuJBXwdEfU0cOklYJHZy2Cmdd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e31025-1619-47a8-4099-08da6e8a459c
x-ms-traffictypediagnostic: BL0PR1701MB2547:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4SNQM61C8JvhYiCDDa/G4fHlLG0baDIXhAqVAD9wlOKI4llhS5hSAF7jgVChS6uvsBsl5QB7Qj3owpx0Y2eUXJ0XrjP8VXg4UOdr6zfxygrYbRNbsIjtcle62lZQGeMttaTX+PkSRtPm2lQvH85068APatkEwdeif+eN+MiBIT0dMzjJSMBdg3wz4APxxiN+xYPE40gaCt7TBUaZk1ySRe7VnxEN5zZ+662uaT9JMgy5th8KPFnMKUYCc3Lfrg1pHYkEO+4SqeerU+yrJVfS+7QtoA70BXC6zs6TXIqqPSVi8lCdXDJYl4IEdYryi0FOYPGYdALZM6tjCoDldVOYgpCWe4hEploOZOA1NJjTZ2aZT2u4wjvfxkagctju3p/caoycUQWm9KEzY3Y980InyBFpbxIiBgFScv6mdicunauc+wWDGaNiiFoPx/zXu2lbvllXfljTgM8wVjr3vA8jgXCkiewZ7sGZKUGQMRbMMpjtyUCexFOG9IXE+uTYh1QkwkloEYyYp+5TSV6zeg9yRxNf+7jzdJPkejea+rAHLNuiamgagZSwOATdbQMPigzlHzWx73oacS4x5Bfz/kJjb4AtmeCHCq48vrKwR8WwnwL/JGL58ArmM6JoKiIUL/wQxTeNkj23XBo62FI689bdqlzh4qMCi8qPN7iPvE23fTqmQ1IdGEb3jEdZNKccRDZP
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTN6WkFtRnZYbW9Wc3phN2lsTG1rM2JRZ1lNcWVHS2trZUJqejRMU093Q3Zs?=
 =?utf-8?B?bWxGYUdDNzJHblZQNnVsME1BSWNKaTN2dnk2Mm5GSXI3cnVITFJhUnQxL3oz?=
 =?utf-8?B?c2xLeDlkdlBud3I4QnI2TWNkZU02Ykx3akZiY2k1dFFDakZaWWo1cXNJd0h4?=
 =?utf-8?B?QnFxLzJ6VStlTUR5RFloeW90eXZyYXJ5ZEthU2hTQXBSRWhmWDltY2ExdE1D?=
 =?utf-8?B?elV5ZUNrSDJYbGhBcHBlblZVYkFzalNZTmF2SkgxYmkxV0tCUUF2cC9XVXp2?=
 =?utf-8?B?Z0QzRWgydFlUdFcycjRsN1AwaU11ZU9nZVhSSlMzR3MvbWtKRDlzYVNHRWVv?=
 =?utf-8?B?N1ZKcDFoRDZBUHNjV3d3VzZXbUtSZjdNaGtMd0d3QXF6QTRSWmFybGhYeDk1?=
 =?utf-8?B?RlE3OWlUTEFIOE1neUk2eWF2TGtLbVV3L1hlN0ZXOHQxcGgzNVI2Ui9wbFZT?=
 =?utf-8?B?clltVzZZVmZxU2VZYmtVK2JzSkI4eXp5aFVmRkJnSitxOXRUTG94cHdrM3pH?=
 =?utf-8?B?RERYOWNpcFFtY2hCU1Y3dlp0UUZ3bUZBaHBBYWJ0NXZlRzFITkhuUEdmVHg5?=
 =?utf-8?B?VXplQ2NRQ3BkZjVlSThJa1ZIcklwdE94cHp4VnRNVXJPcTh2MnZJQ3NIdmYv?=
 =?utf-8?B?YTZtMmtydHFVbnE5Z3BxZUlLYnR0cGtpQVN3aXhOeGwrS29DZG9xOFVHbzBl?=
 =?utf-8?B?MXhFM1JXNTBMTzdhMVY5OVRDUDBmV2J2NXYrUEE0ZndUSlV1SHlydVhFZ2dp?=
 =?utf-8?B?STVITmJtYU91b3dWRWV0MFY5c21pSFBNT29qWEtkSHg3eHJDSVlCVkhnTkFy?=
 =?utf-8?B?Z1ExM1pLOUdySzNlSEEvSU5EeXpEU2t1VWxnMk5Hbm9HL2YwU2cyVmVQSEZz?=
 =?utf-8?B?dUxkSFNXZXVzT1dRYmVvRTZlb2ZvL3NxZTFFUFo3UzQrYkRwcitXZjIxNUFz?=
 =?utf-8?B?VW9hMTlJd2lPMk1zOHlzUkwzM09HVEZ5cEIyejdEQktDSGFGc2JQZVN0TDcv?=
 =?utf-8?B?MjBPOEdmWFZ6ZmxjUkF5eGFwK3VtMDc3RmhGd3FLRHFUdXhiYnpjYWw4eTlK?=
 =?utf-8?B?bFpTUENGZFgveFNYbE9RVWQ5QVQ1UU85K3FPbmxoWXhPSThSZEwzS3UvVUxW?=
 =?utf-8?B?emltODgxb3AybXNYeTVtZSswQURTTkVnWER5RG5tMFEwczMvTmpraXkvdEpi?=
 =?utf-8?B?N0s0WHljYmtUZFlFVWhRR0wxWERwdVJ3SGhCYVA2R3llY2ZhWW9mSjNybG1z?=
 =?utf-8?B?dXFCUEIzRXduemlZdFhNMkk2Rk9TbFJQVTB6UWNta2VldmozSjU4aElzYkRi?=
 =?utf-8?B?SHhFVGlHalFETHAxYWY1SmU3bFZuWEdHT1B0UTJ2bkxvYlpVZ0xmMUxXY0V0?=
 =?utf-8?B?N1lBL29GUUlKWkQrUGljMHZNUk1najg4VHNRMzNndU5qTmlhQndTRVJoeXNk?=
 =?utf-8?B?TDFnbWI4Yk5TeWlPWjZ1T1FSckFqSVVoODFsditnYmxMTk5TRm1JQUVRU0gx?=
 =?utf-8?B?WmcrRWtmQ3V1ZXR5R0ZVUzdvbXhKQTRMN3pIRlByZmtLbjd6RzlMaXlQTmUy?=
 =?utf-8?B?Q05IUEJYQ2lUYTRLNGZtdlhGWXVvRFhQZG9KYjU2Q21Hc2pLa1dFYkZlUzZT?=
 =?utf-8?B?TTh6ZDNJcld2L1FrenlEQkczRi9XRTQzZXNNVXdXd0VGR1NrUTY0L2pZeTBD?=
 =?utf-8?B?VXJkNkFqRlZXQThJVElQN3hUNklzV002Q3FJVzZBOUFYUVIzcERmb1JJZXg4?=
 =?utf-8?B?d2xoZjJWTTZkNGVvN2NoOXhRK0JXM00wVmFGNXBaVHFqZE44Y1hnQ3lMcncv?=
 =?utf-8?B?ZXJ4Vmw1QVlMTDk0RGVzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR17MB3375.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e31025-1619-47a8-4099-08da6e8a459c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 22:08:57.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1701MB2547
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WW91IGxhbWUgYXNzIHN0YWxraW5nIG1vdGhlcmZ1Y2tlci4gWW91IGFyZSBjb21taXR0aW5nIGEg
Y3JpbWUgYW5kIEkgaGF2ZSByZXBvcnRlZCB5b3UgdG8gdGhlIHBvbGljZS4gDQoNCktvb3Dwn5iC
8J+YgvCfmJHwn5iR8J+YkfCfmI7wn5iE8J+YhPCfmLTwn5i08J+RgPCfkYDwn5KB8J+ZiPCfmYjw
n5mI8J+ZiPCfkoHwn5GA8J+RgPCfmJHwn5KB8J+YgfCfmLPwn5iO8J+YtPCfmJHwn5GA8J+YkfCf
mITwn6Sj8J+ko/CfmIDwn5iD8J+YkfCfmLTwn5iE8J+kpfCfpKvwn5il8J+YsPCfpbXwn6W18J+Y
ofCfmKHwn6Ss8J+kr/CfmK3wn5it8J+Yn/CfmJ/wn6Wz8J+kqfCfpbjwn6W48J+luPCfmYHwn5ip
8J+luuKYue+4j/CfmKPwn5iU8J+YlPCfmJTwn5iW8J+Yo/CfmKLwn5ih8J+ltvCfmLDwn5iw8J+Y
pfCfmKXwn5i24oCN8J+Mq++4j/CfpKzwn6Ss8J+krPCfpK/wn5i24oCN8J+Mq++4j/Cfpbbwn5iw
8J+YsPCfpKvwn6Sr8J+Yk/CfpK/wn6Sv8J+krw0KT29pZ2d2a2xwb3VyZfCfpKzwn6Ss8J+krPCf
pKzwn6Ss8J+krPCfpKzwn6Ss8J+krPCfpKzwn6Sv8J+kr/CfpK/wn6Sv8J+kr/CfpK/wn6Sv8J+k
r/CfpK/wn6Sr8J+Yk/CfpKzwn6Sv8J+kr/CfpKzwn6Ss8J+ZgfCfmJLwn5iN8J+YkvCfmJLwn5iO
8J+luPCfpKnwn6Wz8J+Yn/CfmJbwn6W68J+YqfCfmKnwn6Sp8J+ls/CfpbPwn5if8J+YlvCfmKPw
n5mB8J+YqeKYue+4j/CfmJ/wn5ir8J+YpPCfmK3wn6Ss8J+kqfCfpKnwn6W48J+YjvCfmYHwn5ip
8J+YofCfmLXwn5iq8J+Yp/CfpKXwn6Sl8J+Yr/CfmLXwn6Su8J+YrPCfpKXwn5iT8J+kl/CfpJfw
n5i28J+YsvCfpKTwn6SQ8J+kkvCfpJXwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKAjfCfkqvw
n5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+YteKAjfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+Y
teKAjfCfkqvwn5i14oCN8J+Sq/CfmLXigI3wn5Kr8J+kkfCfmLzwn5i94pig77iP8J+SgPCfkoDw
n5G78J+Ru/Cfkbvwn5G58J+RufCfkbrwn5G98J+RvfCfkoDwn5KA8J+Ru/CfkoDwn5KA8J+SgOKY
oO+4j+KYoO+4j+KYoO+4j+KYoO+4jw0KDQo+IE9uIEp1bCAyNSwgMjAyMiwgYXQgMTowNCBBTSwg
VmFuZXNzYSBQYWdlIDxWZWJwZUBvdXRsb29rLmNvbT4gd3JvdGU6DQo+IA0KPiDvu7/wn6Ww8J+l
sPCfpbDwn6Ww8J+lsPCfpbDwn6Ww8J+lsPCfpbDwn5iN8J+RjPCfmI3wn5GM8J+YjfCfmI3wn5iN
8J+YjfCfmI3imLrvuI/imLrvuI/imLrvuI/imLrvuI/imLrvuI/wn5KV8J+SlfCfmJrwn5ia8J+Y
mvCfmJrwn6Ww8J+YmvCfmI3wn5iN8J+YjfCfmJrwn5ia8J+YjeKYuu+4j+KYuu+4j+KYuu+4j/Cf
mI3wn5KV8J+YmvCfpbDwn6Ww8J+YjeKYuu+4j+KYuu+4j/CfmJrwn6Ww8J+YjeKYuu+4j/CfmI3w
n6Ww8J+YjeKYuu+4j+KYuu+4j/CfkpXwn6Ww8J+lsPCfmI3imLrvuI/imLrvuI/wn5iKDQo+IA0K
PiBTZW50IGZyb20gbXkgaVBob27inIzvuI8NCj4gDQo+PiBPbiBKdWwgMjUsIDIwMjIsIGF0IDE6
MDEgQU0sIFlpZmVpIExpdSA8eWlmZWxpdUBjcy5zdG9ueWJyb29rLmVkdT4gd3JvdGU6DQo+PiAN
Cj4+IO+7v0J1ZyBkZXNjcmlwdGlvbiBhbmQgZml4Og0KPj4gDQo+PiAxLiBXcml0ZSBkYXRhIHRv
IGEgZmlsZSwgc2F5IGFsbCAxcyBmcm9tIG9mZnNldCAwIHRvIDE2Lg0KPj4gDQo+PiAyLiBUcnVu
Y2F0ZSB0aGUgZmlsZSB0byBhIHNtYWxsZXIgc2l6ZSwgc2F5IDggYnl0ZXMuDQo+PiANCj4+IDMu
IFdyaXRlIG5ldyBieXRlcyAoc2F5IDJzKSBmcm9tIGFuIG9mZnNldCBwYXN0IHRoZSBvcmlnaW5h
bCBzaXplIG9mIHRoZQ0KPj4gZmlsZSwgc2F5IGF0IG9mZnNldCAyMCwgZm9yIDQgYnl0ZXMuICBU
aGlzIGlzIHN1cHBvc2VkIHRvIGNyZWF0ZSBhICJob2xlIg0KPj4gaW4gdGhlIGZpbGUsIG1lYW5p
bmcgdGhhdCB0aGUgYnl0ZXMgZnJvbSBvZmZzZXQgOCAod2hlcmUgaXQgd2FzIHRydW5jYXRlZA0K
Pj4gYWJvdmUpIHVwIHRvIHRoZSBuZXcgd3JpdGUgYXQgb2Zmc2V0IDIwLCBzaG91bGQgYWxsIGJl
IDBzICh6ZXJvcykuDQo+PiANCj4+IDQuIGZsdXNoIGFsbCBjYWNoZXMgdXNpbmcgImVjaG8gMyA+
IC9wcm9jL3N5cy92bS9kcm9wX2NhY2hlcyIgKG9yIHVubW91bnQNCj4+IGFuZCByZW1vdW50KSB0
aGUgZi9zLg0KPj4gDQo+PiA1LiBDaGVjayB0aGUgY29udGVudCBvZiB0aGUgZmlsZS4gIEl0IGlz
IHdyb25nLiAgVGhlIDFzIHRoYXQgdXNlZCB0byBiZQ0KPj4gYmV0d2VlbiBieXRlcyA5IGFuZCAx
NiwgYmVmb3JlIHRoZSB0cnVuY2F0aW9uLCBoYXZlIFJFQVBQRUFSRUQgKHRoZXkgc2hvdWxkDQo+
PiBiZSAwcykuDQo+PiANCj4+IFdlIHdyb3RlIGEgc2NyaXB0IGFuZCBoZWxwZXIgQyBwcm9ncmFt
IHRvIHJlcHJvZHVjZSB0aGUgYnVnDQo+PiAocmVwcm9kdWNlX2pmZnMyX3dyaXRlX2JlZ2luX2lz
c3VlLnNoLCB3cml0ZV9maWxlLmMsIGFuZCBNYWtlZmlsZSkuICBXZSBjYW4NCj4+IG1ha2UgdGhl
bSBhdmFpbGFibGUgdG8gYW55b25lLg0KPj4gDQo+PiBUaGUgYWJvdmUgZXhhbXBsZSBpcyBzaG93
biB3aGVuIHdyaXRpbmcgYSBzbWFsbCBmaWxlIHdpdGhpbiB0aGUgc2FtZSBmaXJzdA0KPj4gcGFn
ZS4gIEJ1dCB0aGUgYnVnIGhhcHBlbnMgZm9yIGxhcmdlciBmaWxlcywgYXMgbG9uZyBhcyBzdGVw
cyAxLCAyLCBhbmQgMw0KPj4gYWJvdmUgYWxsIGhhcHBlbiB3aXRoaW4gdGhlIHNhbWUgcGFnZS4N
Cj4+IA0KPj4gVGhlIHByb2JsZW0gd2FzIHRyYWNlZCB0byB0aGUgamZmczJfd3JpdGVfYmVnaW4g
Y29kZSwgd2hlcmUgaXQgZ29lcyBpbnRvIGFuDQo+PiAnaWYnIHN0YXRlbWVudCBpbnRlbmRlZCB0
byBoYW5kbGUgd3JpdGVzIHBhc3QgdGhlIGN1cnJlbnQgRU9GIChpLmUuLCB3cml0ZXMNCj4+IHRo
YXQgbWF5IGNyZWF0ZSBhIGhvbGUpLiAgVGhlIGNvZGUgY29tcHV0ZXMgYSAncGFnZW9mcycgdGhh
dCBpcyB0aGUgZmxvb3INCj4+IG9mIHRoZSB3cml0ZSBwb3NpdGlvbiAocG9zKSwgYWxpZ25lZCB0
byB0aGUgcGFnZSBzaXplIGJvdW5kYXJ5LiAgSW4gb3RoZXINCj4+IHdvcmRzLCAncGFnZW9mcycg
d2lsbCBuZXZlciBiZSBsYXJnZXIgdGhhbiAncG9zJy4gIFRoZSBjb2RlIHRoZW4gc2V0cyB0aGUN
Cj4+IGludGVybmFsIGpmZnMyX3Jhd19pbm9kZS0+aXNpemUgdG8gdGhlIHNpemUgb2YgbWF4KGN1
cnJlbnQgaW5vZGUgc2l6ZSwNCj4+IHBhZ2VvZnMpIGJ1dCB0aGF0IGlzIHdyb25nOiB0aGUgbmV3
IGZpbGUgc2l6ZSBzaG91bGQgYmUgdGhlICdwb3MnLCB3aGljaCBpcw0KPj4gbGFyZ2VyIHRoYW4g
Ym90aCB0aGUgY3VycmVudCBpbm9kZSBzaXplIGFuZCBwYWdlb2ZzLg0KPj4gDQo+PiBTaW1pbGFy
bHksIHRoZSBjb2RlIGluY29ycmVjdGx5IHNldHMgdGhlIGludGVybmFsIGpmZnMyX3Jhd19pbm9k
ZS0+ZHNpemUgdG8NCj4+IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIHBhZ2VvZnMgbWludXMg
Y3VycmVudCBpbm9kZSBzaXplOyBpbnN0ZWFkIGl0DQo+PiBzaG91bGQgYmUgdGhlIGN1cnJlbnQg
cG9zIG1pbnVzIHRoZSBjdXJyZW50IGlub2RlIHNpemUuICBGaW5hbGx5LA0KPj4gaW5vZGUtPmlf
c2l6ZSB3YXMgYWxzbyBzZXQgaW5jb3JyZWN0bHkuDQo+PiANCj4+IFRoZSBwYXRjaCBiZWxvdyBm
aXhlcyB0aGlzIGJ1Zy4gIFRoZSBidWcgd2FzIGRpc2NvdmVyZWQgdXNpbmcgYSBuZXcgdG9vbA0K
Pj4gZm9yIGZpbmRpbmcgZi9zIGJ1Z3MgdXNpbmcgbW9kZWwgY2hlY2tpbmcsIGNhbGxlZCBNQ0ZT
IChNb2RlbCBDaGVja2luZyBGaWxlDQo+PiBTeXN0ZW1zKS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1i
eTogWWlmZWkgTGl1IDx5aWZlbGl1QGNzLnN0b255YnJvb2suZWR1Pg0KPj4gU2lnbmVkLW9mZi1i
eTogRXJleiBaYWRvayA8ZXprQGNzLnN0b255YnJvb2suZWR1Pg0KPj4gU2lnbmVkLW9mZi1ieTog
TWFuaXNoIEFka2FyIDxtYWRrYXJAY3Muc3Rvbnlicm9vay5lZHU+DQo+PiAtLS0NCj4+IGZzL2pm
ZnMyL2ZpbGUuYyB8IDE1ICsrKysrKystLS0tLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL2pmZnMy
L2ZpbGUuYyBiL2ZzL2pmZnMyL2ZpbGUuYw0KPj4gaW5kZXggYmE4NmFjYmUxMmQzLi4wNDc5MDk2
Yjk2ZTQgMTAwNjQ0DQo+PiAtLS0gYS9mcy9qZmZzMi9maWxlLmMNCj4+ICsrKyBiL2ZzL2pmZnMy
L2ZpbGUuYw0KPj4gQEAgLTEzNywxOSArMTM3LDE4IEBAIHN0YXRpYyBpbnQgamZmczJfd3JpdGVf
YmVnaW4oc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0K
Pj4gICBzdHJ1Y3QgamZmczJfaW5vZGVfaW5mbyAqZiA9IEpGRlMyX0lOT0RFX0lORk8oaW5vZGUp
Ow0KPj4gICBzdHJ1Y3QgamZmczJfc2JfaW5mbyAqYyA9IEpGRlMyX1NCX0lORk8oaW5vZGUtPmlf
c2IpOw0KPj4gICBwZ29mZl90IGluZGV4ID0gcG9zID4+IFBBR0VfU0hJRlQ7DQo+PiAtICAgIHVp
bnQzMl90IHBhZ2VvZnMgPSBpbmRleCA8PCBQQUdFX1NISUZUOw0KPj4gICBpbnQgcmV0ID0gMDsN
Cj4+IA0KPj4gICBqZmZzMl9kYmcoMSwgIiVzKClcbiIsIF9fZnVuY19fKTsNCj4+IA0KPj4gLSAg
ICBpZiAocGFnZW9mcyA+IGlub2RlLT5pX3NpemUpIHsNCj4+IC0gICAgICAgIC8qIE1ha2UgbmV3
IGhvbGUgZnJhZyBmcm9tIG9sZCBFT0YgdG8gbmV3IHBhZ2UgKi8NCj4+ICsgICAgaWYgKHBvcyA+
IGlub2RlLT5pX3NpemUpIHsNCj4+ICsgICAgICAgIC8qIE1ha2UgbmV3IGhvbGUgZnJhZyBmcm9t
IG9sZCBFT0YgdG8gbmV3IHBvc2l0aW9uICovDQo+PiAgICAgICBzdHJ1Y3QgamZmczJfcmF3X2lu
b2RlIHJpOw0KPj4gICAgICAgc3RydWN0IGpmZnMyX2Z1bGxfZG5vZGUgKmZuOw0KPj4gICAgICAg
dWludDMyX3QgYWxsb2NfbGVuOw0KPj4gDQo+PiAtICAgICAgICBqZmZzMl9kYmcoMSwgIldyaXRp
bmcgbmV3IGhvbGUgZnJhZyAweCV4LTB4JXggYmV0d2VlbiBjdXJyZW50IEVPRiBhbmQgbmV3IHBh
Z2VcbiIsDQo+PiAtICAgICAgICAgICAgICAodW5zaWduZWQgaW50KWlub2RlLT5pX3NpemUsIHBh
Z2VvZnMpOw0KPj4gKyAgICAgICAgamZmczJfZGJnKDEsICJXcml0aW5nIG5ldyBob2xlIGZyYWcg
MHgleC0weCV4IGJldHdlZW4gY3VycmVudCBFT0YgYW5kIG5ldyBwb3NpdGlvblxuIiwNCj4+ICsg
ICAgICAgICAgICAgICh1bnNpZ25lZCBpbnQpaW5vZGUtPmlfc2l6ZSwgKHVpbnQzMl90KXBvcyk7
DQo+PiANCj4+ICAgICAgIHJldCA9IGpmZnMyX3Jlc2VydmVfc3BhY2UoYywgc2l6ZW9mKHJpKSwg
JmFsbG9jX2xlbiwNCj4+ICAgICAgICAgICAgICAgICAgICAgQUxMT0NfTk9STUFMLCBKRkZTMl9T
VU1NQVJZX0lOT0RFX1NJWkUpOw0KPj4gQEAgLTE2OSwxMCArMTY4LDEwIEBAIHN0YXRpYyBpbnQg
amZmczJfd3JpdGVfYmVnaW4oc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCBhZGRyZXNzX3NwYWNl
ICptYXBwaW5nLA0KPj4gICAgICAgcmkubW9kZSA9IGNwdV90b19qZW1vZGUoaW5vZGUtPmlfbW9k
ZSk7DQo+PiAgICAgICByaS51aWQgPSBjcHVfdG9famUxNihpX3VpZF9yZWFkKGlub2RlKSk7DQo+
PiAgICAgICByaS5naWQgPSBjcHVfdG9famUxNihpX2dpZF9yZWFkKGlub2RlKSk7DQo+PiAtICAg
ICAgICByaS5pc2l6ZSA9IGNwdV90b19qZTMyKG1heCgodWludDMyX3QpaW5vZGUtPmlfc2l6ZSwg
cGFnZW9mcykpOw0KPj4gKyAgICAgICAgcmkuaXNpemUgPSBjcHVfdG9famUzMigodWludDMyX3Qp
cG9zKTsNCj4+ICAgICAgIHJpLmF0aW1lID0gcmkuY3RpbWUgPSByaS5tdGltZSA9IGNwdV90b19q
ZTMyKEpGRlMyX05PVygpKTsNCj4+ICAgICAgIHJpLm9mZnNldCA9IGNwdV90b19qZTMyKGlub2Rl
LT5pX3NpemUpOw0KPj4gLSAgICAgICAgcmkuZHNpemUgPSBjcHVfdG9famUzMihwYWdlb2ZzIC0g
aW5vZGUtPmlfc2l6ZSk7DQo+PiArICAgICAgICByaS5kc2l6ZSA9IGNwdV90b19qZTMyKCh1aW50
MzJfdClwb3MgLSBpbm9kZS0+aV9zaXplKTsNCj4+ICAgICAgIHJpLmNzaXplID0gY3B1X3RvX2pl
MzIoMCk7DQo+PiAgICAgICByaS5jb21wciA9IEpGRlMyX0NPTVBSX1pFUk87DQo+PiAgICAgICBy
aS5ub2RlX2NyYyA9IGNwdV90b19qZTMyKGNyYzMyKDAsICZyaSwgc2l6ZW9mKHJpKS04KSk7DQo+
PiBAQCAtMjAyLDcgKzIwMSw3IEBAIHN0YXRpYyBpbnQgamZmczJfd3JpdGVfYmVnaW4oc3RydWN0
IGZpbGUgKmZpbHAsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KPj4gICAgICAgICAg
IGdvdG8gb3V0X2VycjsNCj4+ICAgICAgIH0NCj4+ICAgICAgIGpmZnMyX2NvbXBsZXRlX3Jlc2Vy
dmF0aW9uKGMpOw0KPj4gLSAgICAgICAgaW5vZGUtPmlfc2l6ZSA9IHBhZ2VvZnM7DQo+PiArICAg
ICAgICBpbm9kZS0+aV9zaXplID0gcG9zOw0KPj4gICAgICAgbXV0ZXhfdW5sb2NrKCZmLT5zZW0p
Ow0KPj4gICB9DQo+PiANCj4+IC0tIA0KPj4gMi4yNS4xDQo+PiANCj4+IA0KPj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+PiBMaW51eCBN
VEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QNCj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbXRkLw0K
