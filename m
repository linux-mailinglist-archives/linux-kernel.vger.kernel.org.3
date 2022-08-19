Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910E2599471
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbiHSFZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbiHSFZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:25:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2082.outbound.protection.outlook.com [40.107.113.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB7D59B0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7OMD1s2HsCqKVrCzB7/mUQsCKGVMYGUcRdH+pLnOp7dVByL6mmcLit9QwDawZEEvVbI7ZwC6JdGUJHovTdvl+oV/sWG6u15CoxE657kEyua33tA+Rnh18Nis9X4Y2sPcByVAqTA7vbq590PyLF1olvwe3eurAzyWTMXjW30zIgzSgGOQEhqzqiOIyzrxGS9EwZM7HXEKu8GZmCHfiTQXLTl00oGpyk2O6TfE2cTM+RUPJ3RmncrkUupfX/AL4ED3ivr35F+kmDWu0/XfgfNiHMW24pwqkAHzbRC+ZpFXT/NJnIJINN2FFDMvQCf8myQTcP0RCkzGzlh19LhmJ5CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sB3fYP8MFKzlYxjOc5b3D/TqGgNBFzglbQXHrT9BvU=;
 b=jLr87RiLBH5awQ9Y2Greo/kZ9outsPe0KxgCpuHXVZBozXukXd1la6nafHDP/knk/w7zjAmu/mJBakZStGZGpsuyCgUVRJ3zOTAL55vnRTeF/KStAR8Um59wKsG2Bg899sHKqgw7oN4NneNlhzE4cRR6orqYja9php8ZHAUJCQRVMe3rKlT8rSs5iogpN3vAjVVZvLidHkaaoWi/Iph6h6GOhApWmvLrPtKS2zdJ07RTQ3nJdkqFV7uxLtP6bY/t9xajiqMM+ZeazKOEveQFV36w4pymLTQgS/Hh+m7e92gTjA3wVc3RkeyH8IcIiFSaYTaUQFdKTYeuQUmIExjIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sB3fYP8MFKzlYxjOc5b3D/TqGgNBFzglbQXHrT9BvU=;
 b=NDp0uElmc1AzzSoeiGbSyWjSLZUUtLSOpDFp+EXHBY4jZ6yvd6ZuF0Mtfz3rwvcud6OS5rQxwDA8tGEwWAdbcOfXZoh6WJGfg8qCg7e1YQjM0N+Rx81cNRSkuIN12oq5l+rqHcs/6yvf/8MNNpUlnyymbU50TfaE7PlPt6YG034=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB3460.jpnprd01.prod.outlook.com (2603:1096:604:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17; Fri, 19 Aug
 2022 05:24:55 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 05:24:55 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] mm, hwpoison: avoid trying to unpoison reserved page
Thread-Topic: [PATCH 6/6] mm, hwpoison: avoid trying to unpoison reserved page
Thread-Index: AQHYswKNlvzrHJR+9UGsu7Mby/jdha21sgKA
Date:   Fri, 19 Aug 2022 05:24:55 +0000
Message-ID: <20220819052455.GF613144@hori.linux.bs1.fc.nec.co.jp>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
 <20220818130016.45313-7-linmiaohe@huawei.com>
In-Reply-To: <20220818130016.45313-7-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d4318d7-ddc2-4e57-2d7f-08da81a326ba
x-ms-traffictypediagnostic: OSAPR01MB3460:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3wVWv3ZjRqkv1LI8ValKPQtWwYa6muOPNw09zRowg4xrp3Y8DQ/VWZlFpNg5bUKgWFZJz2qS5yIJcfnsWaeDrbu1Nop6MU4bXnzAqyqL/qNqXlsC7on6iIEWe14GA+4GNl9hmn1EnDiug376XfRtSHvUnIkdNfOHkn18Kh47HKCAUDFQBBMy2y0Ql9d0coJQB3Wm8SbybhGCxp3IMaZcGsfGrJbShMkG/eM3gE1AxLN9HHB/ma6RQc39QcV6Uj9EXeooWGs42fABg6le8V2ENjKNXY6P0fhBG1r4dMcetb7bmuXybqt+yF5B8qikKd1tZdAmJwIWkZDJPYzsCPb0tP0C+gIKGSvO7/YkKHnIqLv0lLFLoLvhGFOcxQjvqkOZ4suY37kGz7Lkc+pmiHdk0kU90P0IXmdWEd4kq9poU/Kf72yK8KMqy9EchkM5lQAnWmV8jkmviWY4loCIAUDMVXclrQBATjr/Aug+87bvrSZ4LwB6YD4PM1NCkCK1nbihu1PVD8JdV6apjl9ELZvyVvA6Tco+tp4fira46xUn0E/QaHcbHRGHOd5eRDCNZmVia/WAY0HrULQm7Zf9U3z3dRS7lT2i4QW9OaXl49G4b2+YcTw9qJqaWA0cUHSqSVrqeaYrLdIJNy4SL3LlGsEzgI0tOpgAlo+mXIBYc1Hvp+fiXo+3hU5JRUPp2M51+bWEBS94rWEVgM4zYjoNIzgB3YMHq/eq1x7i8cI9O4384XDnWJJl7hHPeOD9gfT9W3HZBEtrtrXBGVFm/LplGBtTwY98PEIg8Z0Oqk1/ltwXH2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(85182001)(33656002)(86362001)(38100700002)(55236004)(83380400001)(9686003)(6512007)(186003)(6506007)(26005)(1076003)(82960400001)(38070700005)(54906003)(41300700001)(6486002)(478600001)(71200400001)(4326008)(6916009)(76116006)(66446008)(64756008)(66946007)(8676002)(66476007)(66556008)(5660300002)(2906002)(122000001)(8936002)(316002)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3FVQUl0SkFNcmtPQkRGSy9MNmM0OXV5SlVUTXg4RnNLN3ZLMWtLTW10Wklv?=
 =?utf-8?B?V1NDbG5SK1RkeWRwTGpXM29yWnorZDd4WU1nY0Z4T1lUM0dWZVFCUHZ6cWtp?=
 =?utf-8?B?dHk5eHBvcGxINzBKQ0xVU3doL05RME8xTXpVQWc1YVd0d3Iva3ZJc0NaaWUy?=
 =?utf-8?B?OW1vRHpoUFIwWXZ2bHdCTUpzeTI4aXk2VkpZTGV0WXZmdzVoaVdzS1E4TmRG?=
 =?utf-8?B?MS9meXpzTng3RWVSMmlVdFhIMUdRRm80aU5FYWFGMWR6VGExTGtoWDY3QXVS?=
 =?utf-8?B?a0lENldMWFh1UENxWXhIUzk3V01WcW1BSS9YU24wbVlQdS80UEZHQ21taVNU?=
 =?utf-8?B?dlpVVTI2aGg0ZWkrY1VYcy85anpEdHFYd0xSMitUOE0xY05nWFBXU1BjU3JY?=
 =?utf-8?B?dWhQVndiSjdLVGcwUGpodUtRYzkrMXNGY1lncDR2TUZPUEJsNDJpeS9WcnJk?=
 =?utf-8?B?ZjV3eHJiVTNhbmp0NU1UMzFSeDRTazNzbWs1TVo1RXdRSG1va0JUUEU1MjRZ?=
 =?utf-8?B?MHhXSW16S0hteXN6K1YxTENmRHpnam82V0ZBcGRPWEo0ZUJKWHN1R1FkYnRh?=
 =?utf-8?B?SXdpZTVBbmlsa1gwTnI1WXYzaVJBMmxEQkliZnBFd3JPS3ZYOTg2WGZMeG1D?=
 =?utf-8?B?RnFJd0pMWEdCMGxLS1pKby9GOUhGZUN6SHlTWlZseUZmOEZCWlNXTzUrN0JD?=
 =?utf-8?B?R2VibHNERUJWTXAvSFg2T1lWU2RYamI1RWdWMzZDSU9HNXJDaFhDR1JPanZS?=
 =?utf-8?B?eXBPODJSTTN0UmV5TmJnbjI0Mkc2ZnBhSVB1TG1Ld3FZY1l4ZHBjNUo3c1l1?=
 =?utf-8?B?VERIREdiNThyMWdBUW5ubzE0MDhiR2FMSVRDQm9yYjJ4eVpvVWNndVhlNGNt?=
 =?utf-8?B?OUpUWHYzRVptcEtZOExENUNGSFVSM0Q2OXhrNWppaUZiai9iWDRBQ0pGV3Zr?=
 =?utf-8?B?Wkh2d2VPVWRWSFpKMXpZSWVNOHdUQWtNOGhRUi80bksvRG9QYjk0bnAxZklE?=
 =?utf-8?B?VytXQUNNSmVrcU84TnRMVEtCaWtCbEJmL2srTzhvTmRlNjIvL2wxM3YxdTVh?=
 =?utf-8?B?bG1VSyt6d0Y1R0VGYUdsU3pFdXBPc3J4b2dWMTViYTd5MFB2ZDZ1K3NpQ292?=
 =?utf-8?B?Y2s2MEcxV3hTdHhwbHpVWWJGUHd2UmdmTDRjTzN2ZkorM2l1c3lDWUJrMVpU?=
 =?utf-8?B?RTVsT1FpTHBoNVpTeVhlNlNXN2hKRy80ZTAwQm4vYS8zdEpsdHRibDlEMW1r?=
 =?utf-8?B?Z0JKY1phZ1htck9Ld1VtMmpodEM5Z3pYOU52d2VsTFRocjBIYkFGQzdGRnN2?=
 =?utf-8?B?a3krMi9ZRmZKL25kMkh0b05mK2Y5WEM3amdyVmVlb2oxSmRQNnNJalJaNkNZ?=
 =?utf-8?B?dmxlNHJmak9UTGRPVjBzWVB1a3JmS2h1YXJEMG5ST2FGa3I5SUFXbVBpN3JV?=
 =?utf-8?B?L0lyblBleVlwcEVUQzRnWWZtKy9kbmtyaFBJaWdMV0hRTTdTcnYrWHhXdEVo?=
 =?utf-8?B?QXJzcHlBNTB5K3JEcjBHNU9mcmFxR2h5MHVoZTJzREtJeXN2THFOUkYxdkNE?=
 =?utf-8?B?cXMwRFM4ZzB3Qk5ZbHllMmE0ZVc5elF0Sm5Yakp1NG5ZenJSQTkxTDRwd29s?=
 =?utf-8?B?a05ZbFZ4emVvYk9kMmUzUEpyS2l0TGpKUHUrNUpFRGZTVUljWGROZWlhdWNY?=
 =?utf-8?B?V2pQb05GdGk3SmZsMW5lNjdQMmwzYnFXYnNZc3hXZjVPcW96R0NHMjhmQXc0?=
 =?utf-8?B?NTJEM2V2MTVPYjI2ZHRqeEdGd2dBZnUzSkRMaHAvT2ZNQVhVTGI5R0hYUTF4?=
 =?utf-8?B?ZHdFejRxbXJvVjFpRWs5SytCUTQxNGhvZ2tESUw2bUtBcUZkVUgzVnhGcXVt?=
 =?utf-8?B?amJxRy9pMW1WYWxXV2xJRE9Yay9UWjhIWWRqY3NNTnFEaG52MktScVVGbUVw?=
 =?utf-8?B?ZE56SC82Qm9oMDRpWklZTGlUOFJtQXhJL1ZHY09Sa2EwdDJYUWt0ZEVKaVFT?=
 =?utf-8?B?R1hxVitwNTFFeU1DaWVBeVpaSm5HY3plMDNkVm1LL2EzdGU4alphTW9WVUNS?=
 =?utf-8?B?Wk1WVnFSMXk3ZHJHR3pwYzRKK0xxTzNhRTA3OWJLRVVwb2tIN1pJZkErYUFR?=
 =?utf-8?B?aFZNVk1MOWdsWVJPL0gySmx0SFM4S2owTHJlZHRDamtJZ0NyaGkyWjl3RTlN?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81822FAD0F4BBA4486109F2B742A3216@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4318d7-ddc2-4e57-2d7f-08da81a326ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 05:24:55.5578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyVQVMkd9D1hBhoeBDrWVpYB1qrkcVxoYxcP1gGtuPYVVqgI61K+GkgXm6hsKGScwe1FfLngimdEaEWLKSQ1Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3460
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMDk6MDA6MTZQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gRm9yIHJlc2VydmVkIHBhZ2VzLCBIV1BvaXNvbiBmbGFnIHdpbGwgYmUgc2V0IHdpdGhv
dXQgaW5jcmVhc2luZyB0aGUgcGFnZQ0KPiByZWZjbnQuIFNvIHdlIHNob3VsZG4ndCBldmVuIHRy
eSB0byB1bnBvaXNvbiB0aGVzZSBwYWdlcyBhbmQgdGh1cyBkZWNyZWFzZQ0KPiB0aGUgcGFnZSBy
ZWZjbnQgdW5leHBlY3RseS4gQWRkIGEgUGFnZVJlc2VydmVkKCkgY2hlY2sgdG8gZmlsdGVyIHRo
aXMgY2FzZQ0KPiBvdXQgYW5kIHJlbW92ZSB0aGUgYmVsb3cgdW5uZWVkZWQgemVybyBwYWdlICh6
ZXJvIHBhZ2UgaXMgcmVzZXJ2ZWQpIGNoZWNrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlhb2hl
IExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQoNCkxvb2tzIGdvb2QgdG8gbWUsIHRoYW5rIHlv
dS4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
DQoNCj4gLS0tDQo+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IGluZGV4IDVmOTYx
NWE4NjI5Ni4uYzgzMWM0MWJiMDkyIDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5j
DQo+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gQEAgLTIzNTUsNyArMjM1NSw3IEBAIGlu
dCB1bnBvaXNvbl9tZW1vcnkodW5zaWduZWQgbG9uZyBwZm4pDQo+ICAJCWdvdG8gdW5sb2NrX211
dGV4Ow0KPiAgCX0NCj4gIA0KPiAtCWlmIChQYWdlU2xhYihwYWdlKSB8fCBQYWdlVGFibGUocGFn
ZSkpDQo+ICsJaWYgKFBhZ2VTbGFiKHBhZ2UpIHx8IFBhZ2VUYWJsZShwYWdlKSB8fCBQYWdlUmVz
ZXJ2ZWQocGFnZSkpDQo+ICAJCWdvdG8gdW5sb2NrX211dGV4Ow0KPiAgDQo+ICAJcmV0ID0gZ2V0
X2h3cG9pc29uX3BhZ2UocCwgTUZfVU5QT0lTT04pOw0KPiBAQCAtMjM4Niw3ICsyMzg2LDcgQEAg
aW50IHVucG9pc29uX21lbW9yeSh1bnNpZ25lZCBsb25nIHBmbikNCj4gIAkJZnJlZWl0ID0gISFU
ZXN0Q2xlYXJQYWdlSFdQb2lzb24ocCk7DQo+ICANCj4gIAkJcHV0X3BhZ2UocGFnZSk7DQo+IC0J
CWlmIChmcmVlaXQgJiYgIShwZm4gPT0gbXlfemVyb19wZm4oMCkgJiYgcGFnZV9jb3VudChwKSA9
PSAxKSkgew0KPiArCQlpZiAoZnJlZWl0KSB7DQo+ICAJCQlwdXRfcGFnZShwYWdlKTsNCj4gIAkJ
CXJldCA9IDA7DQo+ICAJCX0NCj4gLS0gDQo+IDIuMjMuMA==
