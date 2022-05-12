Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09B1524493
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348630AbiELEu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347465AbiELEuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:50:32 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2077.outbound.protection.outlook.com [40.107.113.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E727FD1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkNsXFnDGq8cwnRxpK4/Vzw9HijOgRMK8kTU6bb2b4SC39G8OVh2sK/4ooWDQu8Q6SNxsOyzPbm6aHM2cxqRkMQGZLWWa3bBHfoebgw5Wnk924UV2rojTmu/rCo1v6DzvcHU0N8p4XO/vgDEE1HOfWzY2QbYnIXhg5zBhkiCZ0UL5uwTufE44Jpkf0+++bj9XS25+wO9X1vllb7ogt6Tt/rrQFaff9XXKF/5RzPiLaJTs3crJvI7gByS7aQ8L91k9Yde3MWbwh5qiZuFjDMedHLQ3gSHqCpRCkUMvPKSiR8vdCWOameCQ65pkgCp3q1W8aiqRQsr8iJrbZnzs2WOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQcdoGdWcaJ+ndFmh02VXw9QdXKM+CAtB9jgDBBcEm0=;
 b=nct6cRIp/JCxNUEJCcBCEunw2oC1GVQUF4Xz72wcii3ofOF3NhKezme4c5kRDOH9rgj+f7r0tAB+7Wk9UW+sy4UcwvJsVSE8AN0XI3F2Ad6jdp8Vm+W4q+ih7b42YGwsr7GJjgiDhjwADjdmoa1DDAtPkz0to7m7nakPGT93ZTzuBKAuiHY7LvZD2bkTqSTiP+ip4F+D6xr+ggYWlKl1xBZ47ikc8wGtcfTuqMF6etMXTVC/4S/v/v+F4xefvxlP+qmnpnwIJF5p8WNEzDmkJJeMVLp5QLmOJNO+3yR1uwoW394RJFP4+PjQloFpj18zgWU3l2UzrbAPzoUAnYlvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQcdoGdWcaJ+ndFmh02VXw9QdXKM+CAtB9jgDBBcEm0=;
 b=djGUOWtfybUjrwO/UnfjNyDdia119g+CUGNoZcEMO5XPe3rvn8gq/6yLV9cizG19yPLSvnWQkzuDHLh/YDcjjZiNv6+2yctSGUxNSHYohqB5+j4tFCDkhfDZ2VS5NnLzP6UMH1uEsOXVd8OCTZexY536dDPRb3OokdDJJsAzSKo=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS0PR01MB5490.jpnprd01.prod.outlook.com (2603:1096:604:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 04:50:29 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%7]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 04:50:29 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Thread-Topic: [PATCH v1] mm,hwpoison: set PG_hwpoison for busy hugetlb pages
Thread-Index: AQHYZUq6jUL1RAg6UkGx4+LoCthdFK0aAVCAgACLMICAAAOMgIAAHPgA
Date:   Thu, 12 May 2022 04:50:28 +0000
Message-ID: <20220512045028.GB235456@hori.linux.bs1.fc.nec.co.jp>
References: <20220511151955.3951352-1-naoya.horiguchi@linux.dev>
 <f0da4fcf-a4af-ccaa-32ce-55d9fda72203@oracle.com>
 <d7f24648-2af5-3998-d265-c441538ce5fc@huawei.com>
 <f9236f0d-f70e-e078-84d2-9ea480060f27@oracle.com>
In-Reply-To: <f9236f0d-f70e-e078-84d2-9ea480060f27@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 612403a4-f310-49e2-d2b6-08da33d2f00c
x-ms-traffictypediagnostic: OS0PR01MB5490:EE_
x-microsoft-antispam-prvs: <OS0PR01MB54906FADDC289B14C94F406FE7CB9@OS0PR01MB5490.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sWpvnWvjgXOxab+mqS3QSS8BTftwCG7PVc+FAB9K298WU8ZECKw735RHXiBV5dMLTz+55OFHqF8Xkil3XpTQiAJmO7Xw7LS34dYiOZOQ0oG6XliVrCPwPqFYzlLgdt6XCJgWA8IWlA5ymxnH4FdrSzsSg0fy1h5OpJNLYUT5CRn/7UeDKj007LV/LUpQix+am1LFUunU4dyTXj1Qqx7zPTUq0ua6FaqlPm33VGiTizQquPXA/BxiYrzG4rYvUcP71NJXOrJ4/LjwRXjRzaHENk+sm4j/+rA1uMH/q7OwJngWTdD3t5NcIgdwQe97nazJWk3HHFnPHSJIt/Xa32gVZ9OnJ+2VZEnyY46jne2xW5IAvqosmEgfwDtpSDQDR1XNo5AQMjYYff2TPQb/xroFBDQxcW2pHnhBfYzJfZE6IkYW9Fq8rvh68Tp551MyG+y5TwS3ac5SR+ogfZtiztjYRRfulAf49iF1BHOr2sqHTLVroyc2lEB3DNUOPqM8clYGQJFnMJ1Ybg4ytvTEHXlktQ+LCCRu57HTnIAjaCmnHWU2R0u9qLV4pAASx83DeiwwiijfdkW6oCFcjGZPtkBzJMgpJEbwEE9wyuLZo4TFuAAqCuljyAtwEHW0jnbOKtBMIVSdSADNKoO7GjoLwoqXiWgkHvzkK6U7BwHatlXS+d2hh6T8QzhOT/P3T9ADfOUjHJFxN82x4fsDogI4bTRgPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6486002)(4326008)(6506007)(26005)(76116006)(8936002)(64756008)(66946007)(66446008)(55236004)(53546011)(6512007)(9686003)(66556008)(66476007)(122000001)(82960400001)(83380400001)(86362001)(54906003)(71200400001)(38100700002)(38070700005)(8676002)(6916009)(316002)(186003)(1076003)(508600001)(2906002)(85182001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUdCb1YrWFd4UjFUK3cyQUYvN2hrMkplcUNQTTMvUGlGbzBQbkdmaEcwcGNS?=
 =?utf-8?B?dm1FOW1sTnZaZVdSUEdoOURCUHhCM3pQRjJXZFdmQ2d2VUJTYUd1bENDc29O?=
 =?utf-8?B?ZldRUzh6bEdORjh5OXlQTzc5dUZySEUzYi9uSDFQaUMxYWoybE80ZXRmdmVU?=
 =?utf-8?B?WDNGR1BVaERGSzBzVjU3dVJMK0VINUJpWldWeGdEVVBXMVc3d042eXl4b3U5?=
 =?utf-8?B?WWMwODNlUFNIUHlneEVJTWdQdFJtUmc1eURCNGNjR1RlM2JUOWFCcUp4VFRo?=
 =?utf-8?B?OGJucHMzVFFyaUxpcy8vREl2cWlHWnhiN29oMFZ1ZEFaaDFmbFhmSFhqY2wz?=
 =?utf-8?B?NE9OQjUrWEpPdlozRGJxalNoN2drbjViK0Y5ejUzRUE1Z0V2aUpyU3NEbDlZ?=
 =?utf-8?B?NjRkWHMwQTRsVGtzMytTV3AzTGJiaHlPRzdIcUFKbFNVeHV6N09jZ2dtZGt2?=
 =?utf-8?B?eWFuN3ZWM0cyalhGZ01MdFhQRUxseE8rajc4WnUyV0x4NkdRM0FXTUY0REtB?=
 =?utf-8?B?dXBTN3cxbTlmNFV5VnY5V0pJVkNPYU5oOXhFM2dpQkc5bXhBQVN4TG45QW56?=
 =?utf-8?B?dElRRUFnOGpnZjhNRExYeitvc0REQzh2V01QbmVhOWVnbmNIaHdsN3ptbExs?=
 =?utf-8?B?OW1kVDRERzRnWHp1T2JQQ2JUdmtocG5sYXBWOHN4VlFabnFRSzZFU0d4RUVp?=
 =?utf-8?B?TWFmOExvSTZyU3ptZGNRdFpKWVpWZkhDanpWWWJQdnVHVDlFbnJkMWFVMGpH?=
 =?utf-8?B?QTVYMGhvZ0w3N256TUd0aEtIRVZEOUczc0ZiWUJuckhYRk9YTHZ1ZVYyWW5H?=
 =?utf-8?B?NkNFMjRRSkZDbXVXakRDTGMxZ1Z3QWtvMG95TVJhaFNubXY4UmR1Sk4rdnFB?=
 =?utf-8?B?azJpdnNiVCs3dTNxNGc5OFYwbjh3dHlsM2JKdEFpYVkxUXpzWmxTRzZqZno5?=
 =?utf-8?B?S2RpMkIxa3hYNjBrSzJwOXd5c3p2ZWJTSy9EUHdUSy9XNjRscGlOazNFK1VU?=
 =?utf-8?B?ZWdDZ3J4VUc1Qk4yWnF3MnB6b1lnZWx3bjZKWnVwM0hyQ2pZTnJpT0JZamhw?=
 =?utf-8?B?bDlMK1YvUDc1Sk5RVTUvR2hBeXd6bE1pU2tWdnJCVEx3NkZpcUIzN05TVW5U?=
 =?utf-8?B?OGU3THhTTi9oMG1BWEhvYkJ4Q0dwUXBOdmFFL3Y2S2Y4QmphRUxBcjJ6Ui9r?=
 =?utf-8?B?ekFuR2VjZ2JzSkFFVXRBYVhWdGlaTG91Wk1qMEtabmYxQnFBNUdYSzFjM3Vv?=
 =?utf-8?B?ZWpKVERZMHRKL1VPNVM2QkNWREY2YXVmbHhxUm9CeFp0U1hPU1dYaDhkdGJt?=
 =?utf-8?B?T05rQUM4OWF5YlIrckpmRytxZU13N0lac200N0c3VmpzQzExUDJySjlDY05J?=
 =?utf-8?B?TUVobVNWd1EwRFEvMVBvZEtXemNFZWo2QmJBYkNvNmdnQjRuMnpnL0pyOENG?=
 =?utf-8?B?b2lpR3Q3djVVRW5ES1RXZXZNZE9kdkMwQWNPRytVZnVTdjRtUU5pWnh1THR6?=
 =?utf-8?B?bWV3M1NFR0t2TWE0S0gzQWZSSnNnK0pubG9oUUx0YjJaMy8vZEJwRzNYenRw?=
 =?utf-8?B?ZkZDY2h6MEtGQkp6UUl2L01DR0VKRURDZEhCSHZUSDdRdzBJbzQwWjQzTnVY?=
 =?utf-8?B?eUxtc0tWa3pZK0VvYWhFWGZmQ2VRZ3JTV3JDZG9HTlFrTGJzTEovMHBpSWEv?=
 =?utf-8?B?NGJUWGgvMFdLQ3h4R0gvN1VNYTg5REJCUG5kd2pxMVVYcFFXZ0FuRUJNOWla?=
 =?utf-8?B?L1Y4NXhTa3pNOWsyR1lOZ2V0V0hKbEFBTlNnL0M4ZVNNNTQ5Mng4TWJDNGdi?=
 =?utf-8?B?ZDlSV211d1RzZ2IzTVZLZzZCbjdad0FiQW01MHdqbmsyOXdXUjhlMDZ2WU14?=
 =?utf-8?B?SkZxRmhxWmtyL2ZUb0lXc0IxMyttZjdtNFpIbjc2VFkrOHRRK0ZsaDVmNUdX?=
 =?utf-8?B?RFhpWEpxN2pxU2M5V3dGVWlrZzhGdG5QajZDR1VFVDNVYWtBYnloa2ZRNVNX?=
 =?utf-8?B?SHd4ZXV3S2dHMU03enZOcVlSazE0bTRKMmlrT2pDRDdYcCtoNGZIaDFoSXIr?=
 =?utf-8?B?UDdtNUJDeHE1NFZBc3oyRzljRkRLd2g4Ri9sUEU1blVYc2wvbWtHdkMvaEhH?=
 =?utf-8?B?bkh5LzRuZ1c2RXFKUnVzdmNDNUZQbjN5dGx1cTBjRndXYWpTQ3ExUVZORDFl?=
 =?utf-8?B?Ui9sZ1hycWFoTUp6NGdCM1NsQkorTFdtMWxKUUcySzJjU3N4U3d1SGpQaEJ6?=
 =?utf-8?B?UDREWUtGZTUwNzlVK3o2N0RlWFppSmh5VExYRWJCZkZPMTBqT3k2UDZnSFZh?=
 =?utf-8?B?OHFpWlhwaFVlSnREMkcrbzFNS0NhS25CRERTV2gwdW5jbUxMZGNIb1NMb240?=
 =?utf-8?Q?a3kulRBmXQg2EWGg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9B3288C1E1F8342A670D5830500C966@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612403a4-f310-49e2-d2b6-08da33d2f00c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 04:50:28.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXyEUgpo8BfZ/VpWwDBG5WNLW8GO5d4/kjaxPsSxVOhZrdGSIiUaAs5eg8fxLXz9Zzv6MjJFLIVk3xB4ZkherQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTEsIDIwMjIgYXQgMDg6MDY6NDdQTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiA1LzExLzIyIDE5OjU0LCBNaWFvaGUgTGluIHdyb3RlOg0KPiA+IE9uIDIwMjIv
NS8xMiAyOjM1LCBNaWtlIEtyYXZldHogd3JvdGU6DQo+ID4+IE9uIDUvMTEvMjIgMDg6MTksIE5h
b3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPj4+IEZyb206IE5hb3lhIEhvcmlndWNoaSA8bmFveWEu
aG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4+Pg0KPiA+Pj4gSWYgbWVtb3J5X2ZhaWx1cmUoKSBmYWls
cyB0byBncmFiIHBhZ2UgcmVmY291bnQgb24gYSBodWdldGxiIHBhZ2UNCj4gPj4+IGJlY2F1c2Ug
aXQncyBidXN5LCBpdCByZXR1cm5zIHdpdGhvdXQgc2V0dGluZyBQR19od3BvaXNvbiBvbiBpdC4N
Cj4gPj4+IFRoaXMgbm90IG9ubHkgbG9zZXMgYSBjaGFuY2Ugb2YgZXJyb3IgY29udGFpbm1lbnQs
IGJ1dCBicmVha3MgdGhlIHJ1bGUNCj4gPj4+IHRoYXQgYWN0aW9uX3Jlc3VsdCgpIHNob3VsZCBi
ZSBjYWxsZWQgb25seSB3aGVuIG1lbW9yeV9mYWlsdXJlKCkgZG8NCj4gPj4+IGFueSBvZiBoYW5k
bGluZyB3b3JrIChldmVuIGlmIHRoYXQncyBqdXN0IHNldHRpbmcgUEdfaHdwb2lzb24pLg0KPiA+
Pj4gVGhpcyBpbmNvbnNpc3RlbmN5IGNvdWxkIGhhcm0gY29kZSBtYWludGFpbmFiaWxpdHkuDQo+
ID4+Pg0KPiA+Pj4gU28gc2V0IFBHX2h3cG9pc29uIGFuZCBjYWxsIGh1Z2V0bGJfc2V0X3BhZ2Vf
aHdwb2lzb24oKSBmb3Igc3VjaCBhIGNhc2UuDQo+ID4gDQo+ID4gSSdtIHNvcnJ5IGJ1dCB3aGVy
ZSBpcyBodWdldGxiX3NldF9wYWdlX2h3cG9pc29uKCkgZGVmaW5lZCBhbmQgdXNlZCA/IEkgY2Fu
J3QgZmluZCBpdC4NCj4gPiANCj4gPj4+DQo+ID4+PiBGaXhlczogNDA1Y2UwNTEyMzZjICgibW0v
aHdwb2lzb246IGZpeCByYWNlIGJldHdlZW4gaHVnZXRsYiBmcmVlL2RlbW90aW9uIGFuZCBtZW1v
cnlfZmFpbHVyZV9odWdldGxiKCkiKQ0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1
Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGluY2x1ZGUv
bGludXgvbW0uaCAgfCAxICsNCj4gPj4+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgOCArKysrLS0t
LQ0KPiA+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNsdWRl
L2xpbnV4L21tLmgNCj4gPj4+IGluZGV4IGQ0NDZlODM0YTNlNS4uMDRkZTBjM2U0ZjlmIDEwMDY0
NA0KPiA+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9tbS5oDQo+ID4+PiArKysgYi9pbmNsdWRlL2xp
bnV4L21tLmgNCj4gPj4+IEBAIC0zMTg3LDYgKzMxODcsNyBAQCBlbnVtIG1mX2ZsYWdzIHsNCj4g
Pj4+ICAJTUZfTVVTVF9LSUxMID0gMSA8PCAyLA0KPiA+Pj4gIAlNRl9TT0ZUX09GRkxJTkUgPSAx
IDw8IDMsDQo+ID4+PiAgCU1GX1VOUE9JU09OID0gMSA8PCA0LA0KPiA+Pj4gKwlNRl9OT19SRVRS
WSA9IDEgPDwgNSwNCj4gPj4+ICB9Ow0KPiA+Pj4gIGV4dGVybiBpbnQgbWVtb3J5X2ZhaWx1cmUo
dW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncyk7DQo+ID4+PiAgZXh0ZXJuIHZvaWQgbWVtb3J5
X2ZhaWx1cmVfcXVldWUodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncyk7DQo+ID4+PiBkaWZm
IC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPj4+
IGluZGV4IDZhMjhkMDIwYTRkYS4uZTMyNjliOTkxMDE2IDEwMDY0NA0KPiA+Pj4gLS0tIGEvbW0v
bWVtb3J5LWZhaWx1cmUuYw0KPiA+Pj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+Pj4g
QEAgLTE1MjYsNyArMTUyNiw4IEBAIGludCBfX2dldF9odWdlX3BhZ2VfZm9yX2h3cG9pc29uKHVu
c2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQo+ID4+PiAgCQkJY291bnRfaW5jcmVhc2VkID0g
dHJ1ZTsNCj4gPj4+ICAJfSBlbHNlIHsNCj4gPj4+ICAJCXJldCA9IC1FQlVTWTsNCj4gPj4+IC0J
CWdvdG8gb3V0Ow0KPiA+Pj4gKwkJaWYgKCEoZmxhZ3MgJiBNRl9OT19SRVRSWSkpDQo+ID4+PiAr
CQkJZ290byBvdXQ7DQo+ID4+PiAgCX0NCj4gPj4NCj4gPj4gSGkgTmFveWEsDQo+ID4+DQo+ID4+
IFdlIGFyZSBpbiB0aGUgZWxzZSBibG9jayBiZWNhdXNlICFIUGFnZUZyZWVkKCkgYW5kICFIUGFn
ZU1pZ3JhdGFibGUoKS4NCj4gPj4gSUlVQywgdGhpcyBsaWtlbHkgbWVhbnMgdGhlIHBhZ2UgaXMg
aXNvbGF0ZWQuICBPbmUgY29tbW9uIHJlYXNvbiBmb3IgaXNvbGF0aW9uDQo+ID4+IGlzIG1pZ3Jh
dGlvbi4gIFNvLCB0aGUgcGFnZSBjb3VsZCBiZSBpc29sYXRlZCBhbmQgb24gYSBsaXN0IGZvciBt
aWdyYXRpb24uDQo+ID4+DQo+ID4+IEkgdG9vayBhIHF1aWNrIGxvb2sgYXQgdGhlIGh1Z2V0bGIg
bWlncmF0aW9uIGNvZGUgYW5kIGRpZCBub3Qgc2VlIGFueSBjaGVja3MNCj4gPj4gZm9yIFBhZ2VI
V1BvaXNvbiBhZnRlciBhIGh1Z2V0bGIgcGFnZSBpcyBpc29sYXRlZC4gIEkgY291bGQgaGF2ZSBt
aXNzZWQNCj4gPj4gc29tZXRoaW5nPyAgSWYgdGhlcmUgYXJlIG5vIGNoZWNrcywgd2Ugd2lsbCBy
ZWFkIHRoZSBQYWdlSFdQb2lzb24gcGFnZQ0KPiA+PiBpbiBrZXJuZWwgbW9kZSB3aGlsZSBjb3B5
aW5nIHRvIHRoZSBtaWdyYXRpb24gdGFyZ2V0Lg0KPiA+Pg0KPiA+PiBJcyB0aGlzIGFuIGlzc3Vl
PyAgSXMgaXMgc29tZXRoaW5nIHdlIG5lZWQgdG8gYmUgY29uY2VybmVkIHdpdGg/ICBNZW1vcnkN
Cj4gPj4gZXJyb3JzIGNhbiBoYXBwZW4gYXQgYW55IHRpbWUsIGFuZCBncmFjZWZ1bGx5IGhhbmRs
aW5nIHRoZW0gaXMgYmVzdCBlZmZvcnQuDQo+ID4gDQo+ID4gSXQgc2VlbXMgSFdQb2lzb24gaHVn
ZXRsYiBwYWdlIHdpbGwgc3RpbGwgYmUgYWNjZXNzZWQgYmVmb3JlIHRoaXMgcGF0Y2guIENhbiB3
ZSBkbyBhDQo+ID4gZ2V0X3BhZ2VfdW5sZXNzX3plcm8gZmlyc3QgaGVyZSB0byBlbnN1cmUgdGhh
dCBodWdldGxiIHBhZ2UgbWlncmF0aW9uIHNob3VsZCBmYWlsIGR1ZQ0KPiA+IHRvIHRoaXMgZXh0
cmEgcGFnZSByZWZlcmVuY2UgYW5kIHRodXMgbm90IGFjY2VzcyB0aGUgcGFnZSBjb250ZW50PyBJ
ZiBodWdldGxiIHBhZ2UgaXMNCj4gPiBhbHJlYWR5IGZyZWV6ZWQsIGNvcnJ1cHRlZCBtZW1vcnkg
d2lsbCBzdGlsbCBiZSBjb25zdW1lZCB0aG91Z2guIDooDQo+IA0KPiBSaWdodC4gIFRoaXMgcG90
ZW50aWFsIGlzc3VlIHdhcyBub3QgaW50cm9kdWNlZCB3aXRoIHRoaXMgcGF0Y2guDQo+IEFsc28s
IEkgYW0gbm90IHN1cmUgYnV0IGl0IG1pZ2h0IGJlIGFuIGlzc3VlIHdpdGggbm9uLWh1Z2V0bGIg
cGFnZXMgYXMgd2VsbC4NCj4gDQo+IEFzIG1lbnRpb25lZCwgbWVtb3J5IGVycm9yIGhhbmRsaW5n
IGlzIGEgYmVzdCBlZmZvcnQuICBTaW5jZSBlcnJvcnMgY2FuDQo+IGhhcHBlbiBhdCBhbnkgdGlt
ZSwgd2UgY2FuIG5vdCBoYW5kbGUgYWxsIGNhc2VzLiAgT3IsIHlvdSBjb3VsZCBzcGVuZCB0aGUN
Cj4gcmVzdCBvZiB5b3VyIGxpZmUgdHJ5aW5nLiA6KQ0KPiANCj4gVGhlIHF1ZXN0aW9uIGlzLCBz
aG91bGQgd2Ugd29ycnkgYWJvdXQgZXJyb3JzIHRoYXQgaGFwcGVuIHdoZW4gYSBwYWdlIGlzDQo+
IGlzb2xhdGVkIGZvciBtaWdyYXRpb24/DQoNCkkgdGhpbmsgeWVzLCBidXQgdGhhdCdzIG5vdCB0
byBzYXZlIGN1cnJlbnQgbWlncmF0aW9uIGV2ZW50LCBidXQgdG8NCnNhdmUgdXMgZnJvbSBmdXR1
cmUgbWVtb3J5IGVycm9ycyBjYXVzZWQgYnkgdGhlIGJyb2tlbiBwYWdlLg0KDQpUaGFua3MsDQpO
YW95YSBIb3JpZ3VjaGk=
