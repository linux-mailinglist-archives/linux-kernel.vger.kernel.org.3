Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01A3489032
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbiAJG3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:29:21 -0500
Received: from mail-sgaapc01on2099.outbound.protection.outlook.com ([40.107.215.99]:38593
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239019AbiAJG3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:29:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMb/l/tBfGhRarvNRZZgZXsm5KyszxFhJncnejaIS+bCEZwSerBOH9eiR9xdTRvcTX5nGuqpaidkgmPLleie9QuCJ9AjllpRIPvclzcZqPtGRRqPYN8BAaapWVuFqaHMYbjQyt1jZYCtwb8NJTsESQbPhjXy3oLVUdLNLQVz7WieI09L5EMIRmnpev7YpVwuYM970VSWzb0XilvRCVUASjE05ZZ4rZhl4BmBRkZwIu0wFDP8JVjYjkZaGKJtUy+jKr7dtWgjrBg3C9vhKGxSAj54yTwnJFPS1rFcIxy1mGL2HSG5QIvGvpgsiWY7rbk0VU7oSuKbzwTvbLLGiiFl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb+1c0Y8F4MYcg0hv2w6o4xzfxcsxst/DHDWqd7Ncy8=;
 b=hbMRBABM6et5QIwkHXuaWZl0wRyEKry2FtY4kFTWpXiWFgM1K4aFwNiP22kYpZef3gBbHHzZfoSo9+cEnsevmmkP1I5hOdj+RYzl+XBIiHuzAd5MzCjDq3qHAX0Wt3FpVF+ilDMARg7lSMCQl2TFVVaTOTu1hdzndqDS8KVZNHq8PDNfTXa7vja6RTDiUIZsf04X2HzHbp/VUpQCSkI1jue32AnITnnCNPEFHstOg0Q9U18LtD+oWFmq4HfqvxLTOCRv6htD+UHGq35XN7Qm7m+eZid3E3n13uUycJcV13aKpDtV/zu6pz9xYoUJgY/Rli+K+kVU4LxjMlK5ErBpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb+1c0Y8F4MYcg0hv2w6o4xzfxcsxst/DHDWqd7Ncy8=;
 b=lphx3QjV8GMyUya6j2Giy5ENNlXld+oh0NcuqGYJMcjO0eZq687ZIMV8Yq+sA4fIQacSOBMPpC/LuEy8jP6yWa8Z3ySprSuj/tA6gegLTaF6/iJ/dE3hIWsHfS3w/rnGvVdFjbcsR0pzg6H9WEeqWrt34Bmow7e+X5Mq22qgxLCSdbfGMQVGL701bR9aOiaStpYevr+GQynNw0ej+rso+P0wzKt0NQQDiDLu8owicIqUT+rx4NTkLjY8Sx3waT45d8VqRvHqqwFwu7gui3ZCnetnyM2uVeiUySlxDmPPv8QKX5IlJDvBJXJc0RtonMSJUpy5fn/JBxl5e+bn7CyIDQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB3649.apcprd06.prod.outlook.com (2603:1096:203:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 06:29:15 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::6d89:70e9:fcfe:e126%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 06:29:15 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
Thread-Topic: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
Thread-Index: AQHX7BszI/63d6+3yEiIx/+xfvXqSKwpSLsAgAAkTICAB+FNgIAJaO9ggAr6yUCAFkw+QA==
Date:   Mon, 10 Jan 2022 06:29:14 +0000
Message-ID: <HK0PR06MB320263FDED955EA4B6E0557480509@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
         <20211208100545.1441397-3-neal_liu@aspeedtech.com>
         <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
         <HK0PR06MB320271524E51BDFA922F070780709@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <0888eb83c8b2bd53d4c3e2355019052d0ab40db6.camel@kernel.crashing.org>
 <HK0PR06MB3202051E7C15E84006DF55C0807B9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <HK0PR06MB3202796B4DDF471856149B1480429@HK0PR06MB3202.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB3202796B4DDF471856149B1480429@HK0PR06MB3202.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56ec947e-e1ef-43ff-a1b8-08d9d40285dd
x-ms-traffictypediagnostic: HK0PR06MB3649:EE_
x-microsoft-antispam-prvs: <HK0PR06MB3649ADD5A368E88A8DADB78580509@HK0PR06MB3649.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9XLxXNgOpdRXDISDnWj8T/srMBalBLVHjh5QM0QLoj3Kpwa/dfsyp11nGFHG3Zt32eZzu6KihVTF3xM3wFDsN/l/BwXlKsXjJd8RKwQaCBZxdf4c7R7iGXPjkhAKPsDwuXH8d9s36mEY3ZgmgUAns8COgijG/o6TpXwmk8E/VcOWkj/JOwDgppbIDhsraSDsOOyvJiWmIeAPWHp7QrNmTsMmrElfQrM+y0uGbZXG/DEk10LMf2iHXnOMXVg3qoO5L6rntQWOSM5X3/vkpQR4VTWorDstnyHvEV78IOqzpjFdDrDxGv085hEQfGzmjKgMpmZK8k3Y5YJYYA5S0WeJp+wU8lCU/0MRae3vP6pZs5/PG7YTXhm4TldbPyhYtzPO777T0MvbjcGat7+tQdXeCqyzo+P/EOrWtJcJpRj3GTcHY5dce07valjBK63U8CByuCIUOEXZBdCQN0YwIjV/tKXKfXy3i9ciSMK3max5UtBLnaSkT0GXH9y56JkAnNOQ3hIf/vHytKh52PTpPk0tQfBdW+JcwVi+T7nRiTxZGi7lTKBShIGktMDR2zzgxFrnnDwON0rQVBaQw4V8oEEOhodzgJ3f/6SxCqoR/ukhtMtIUfsgATYEWH2yPxH69az5p+8cdH7tzXyJhPrNJ3E6CXUG31KEmM6m4/Gi4pteELl6tzS1+fV4ZOA5wCQlDBNmrLfnnl9xrFtoCaZyjqfXLLgkS99vra+kMUQ9hA4V06o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(136003)(366004)(376002)(346002)(33656002)(122000001)(9686003)(110136005)(38070700005)(921005)(508600001)(66556008)(66476007)(55016003)(66946007)(64756008)(66446008)(76116006)(5660300002)(8676002)(186003)(8936002)(2906002)(52536014)(83380400001)(26005)(71200400001)(86362001)(316002)(6506007)(7696005)(53546011)(7416002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU9QZmk1dTQrbitYZ3Q3akNxOHpIWGl1MGcxYlBjSkZUcHB0TFRWcWhqVlNn?=
 =?utf-8?B?aGV4cmNEV251UWRoQWV0c2lucC92ZWR6c2lDc2FERTJFTU11dkVkQzk4bDQz?=
 =?utf-8?B?SnhXRDNkK2RRVGNoWmNjQm9wMlpyZnlyOHZrTG9QNCs4ZnAyQ1J2TzNkUW5D?=
 =?utf-8?B?REx3bkVvSE8yTTA2bWprbnJUcXFUQ3c2YWI2aHZaQjhlNmZ2K0RBSG51bFR0?=
 =?utf-8?B?ejg0cHhaSFBXcTVVNVRkTWhjL0RUcm5XaW02eGkzZjNnVmNHRUNjMXJmL1ow?=
 =?utf-8?B?Sjc4dUgvMjdWTzFlaEJ3bXBtSnZzT2tmakJFN0VsZG1ONzB1MkJLd0tsQlFP?=
 =?utf-8?B?RFU0SFZkaGlpZC8ya1U4VmZyZ2Z3VDZvelAya2RGbVBYY05LNGVwazl2UEdY?=
 =?utf-8?B?OU9IZmhqRVROdmlXTDZRRWhCb0ZlYmE5ODNHRjR2bllMSCs3S1dpZ0p0bDlq?=
 =?utf-8?B?RWN1dUZMcVduUHBDdFRPTFZWbTY3b0tVVXFxaVBEZUhBdkIrMkxIeVFDaWZI?=
 =?utf-8?B?SDlCRUNKZHlrdDdDY2d0ZU9WVGE3bDB5RTJPUklZbTk3OFQzUFNkN3lQaHUv?=
 =?utf-8?B?UGxRazNtWGd1dU5mUHJ3Y3JxYU1uM0NBY2UyTzYwazVXb3NEcm9FUGdsak1n?=
 =?utf-8?B?QTNONk5zTDZPQVdhZ2x1QzdIenA1ejBySXhiOWptd0ZzVVhza1hGZTRhNkdU?=
 =?utf-8?B?VXY2YzFaUWdwQVhJNk4rQjV2QjFlOVpTeVRpeVdzL01iUHU1Vm9xOXEvcS9Y?=
 =?utf-8?B?MmoxVmJPVFRRbDd6ZFNMbTB2aHFaZWZlRkpNQzFrVFhHNGNQL05qTDcralhj?=
 =?utf-8?B?eVVocUgrUUZYN3pVSlBhTVd0RVhvY09iRWl1dHUvVjBFTDQvQXg4Mk53akFJ?=
 =?utf-8?B?RC9SNG1qNHlaMU1RNTd0T0JkSGg4TEtRMkRBZFd0T2dqS0tKdGVHbGVvZG5t?=
 =?utf-8?B?Zjk5bkVocUV1M2FXdk9mWTFSUlBVSW5GRFZUekYzdjJRcXNSSFd1N2JIMHFU?=
 =?utf-8?B?TU5Vbi9wZ2RyeEZNVlFrUVlvdk1xQWp5dHVzMlZCZmJ4RERwQXZJamhjSks5?=
 =?utf-8?B?QzZCdlFucjc4bUhpMVF0V3ZXUVk5U1Q5VTVYZUdQbVBYYjlTRlMvTjJqRkUv?=
 =?utf-8?B?b3JmZEk4R2N6Q0hWbGhZV3hWTTlvcXMyQTdLNlM2bUJTNERUTTIxby9vaVlH?=
 =?utf-8?B?TDVDRGdSd1B5end1WmVCY0JFSS8yR2xrZjB6TEFpc3JSMXBqa1lFV2huYnNL?=
 =?utf-8?B?VHJoY0ZnQmt6YSt6RlBhdnBOM1E1ZDVNaUhZN1paR29jcndPWjBQZmsvN0hV?=
 =?utf-8?B?N0R2TU5sVXBMMDYrVXdML0tFOWJUeUpLRDAwSmV0bFltdENRZUM4elV3ZDNy?=
 =?utf-8?B?c2dWQ2JKcWpJRkxKS1J4ejFXTFkvQ2hBdS9lQU5KbVNNYXVLcUZFbUY5Sll1?=
 =?utf-8?B?R0czRnN5ZXZUQjhwVmh0Y1BTMFR3b3BTeGhwcmpacEJzRCtLOXdrYUlSUFRR?=
 =?utf-8?B?MmhqR1A3eE1iU1NuU1FTK3grcEprSjFoc2FCVTZkbDFoOUxNR0NlVzhOckl4?=
 =?utf-8?B?L2NtMHZObU1wdHAxRTlSM0ZleGdVRERCeEYram1vZUR3NHlHdC9FN21TN1Va?=
 =?utf-8?B?Y1NOWW00WVU5WHpEaG42RW43NmVvMDdHelU5eGtCeGkvU0FrQy9WK3hmdmdl?=
 =?utf-8?B?QzBEaGt5V2xJZjRPUjB0RmxBTHFnNW5Fbm16MjZ3V0hyajZtaTg5OVlEYWZl?=
 =?utf-8?B?bkx3Qno0RzJUMzJ1RkZmNDIzcVp2aEJ0NU1WTVVYNTBTaUxPWk9OV0JlbTRF?=
 =?utf-8?B?L1l1Vm1RSng0b0xyNGFvd2lOOGxsZUhWKy81Z1ppeE16dUF3OThQc2drYURk?=
 =?utf-8?B?TmJnQ0ZWcUFEMHNTRnRMcjlsNDRvUFpwQVBYalIwSDhWSUdaNDZUVkJMeXpG?=
 =?utf-8?B?MUFWWVNTZFNsV3ZuanBrcGxOMTFzSWJreWFzMml0UUFTTGpHcHRlTGRpbHpm?=
 =?utf-8?B?S2p1aXFiY3UrZTVPdnd1b2dkeXJuTVRjTlRHVnZhZS9yUjRjdFE5SUJJeVZ3?=
 =?utf-8?B?Vk52UUlzZUx1TVQvSmNZREtGVVdPbmh4ZStldG9sSG4rdHdYTHVZNHZ6US9s?=
 =?utf-8?B?SmNJcFhzZDFDb3BQbUIvYnp2aGZkWUhLSTJZNGwrUm9oZHZqb2xKZTNMR25E?=
 =?utf-8?Q?fm9A7uTxXVkCIm/c3bJScUs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ec947e-e1ef-43ff-a1b8-08d9d40285dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 06:29:14.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+bFOyxdL/YBx2kMSYlt4//fWaN9O4E5XWK+JUO9G19Yi0SG1REX/YanmURKpHYm/tTBoywobgyB8cQ0AJDlGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3649
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIExpdQ0KPiBTZW50OiBN
b25kYXksIERlY2VtYmVyIDI3LCAyMDIxIDEwOjA3IEFNDQo+IFRvOiBCZW5qYW1pbiBIZXJyZW5z
Y2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+OyBGZWxpcGUgQmFsYmkNCj4gPGJhbGJp
QGtlcm5lbC5vcmc+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPjsgSm9lbA0KPiBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5IDxh
bmRyZXdAYWouaWQuYXU+OyBDYWkgSHVvcWluZw0KPiA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+OyBU
YW8gUmVuIDxyZW50YW8uYnVwdEBnbWFpbC5jb20+OyBKdWxpYSBMYXdhbGwNCj4gPGp1bGlhLmxh
d2FsbEBpbnJpYS5mcj47IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPjsgU2FzaGEg
TGV2aW4NCj4gPHNhc2hhbEBrZXJuZWwub3JnPjsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZw0KPiBDYzogQk1DLVNX
IDxCTUMtU1dAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMi80XSB1
c2I6IGFzcGVlZC12aHViOiBmaXggcmVtb3RlIHdha2V1cCBmYWlsdXJlIGluDQo+IGlLVk0gdXNl
IGNhc2UNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBOZWFs
IExpdQ0KPiA+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMjAsIDIwMjEgMTA6MjMgQU0NCj4gPiBU
bzogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnPjsgRmVs
aXBlIEJhbGJpDQo+ID4gPGJhbGJpQGtlcm5lbC5vcmc+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gPiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlk
LmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT47IENhaQ0KPiA+IEh1b3Fpbmcg
PGNhaWh1b3FpbmdAYmFpZHUuY29tPjsgVGFvIFJlbiA8cmVudGFvLmJ1cHRAZ21haWwuY29tPjsg
SnVsaWENCj4gPiBMYXdhbGwgPGp1bGlhLmxhd2FsbEBpbnJpYS5mcj47IGtlcm5lbCB0ZXN0IHJv
Ym90IDxsa3BAaW50ZWwuY29tPjsNCj4gPiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+
OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiBsaW51eC1h
c3BlZWRAbGlzdHMub3psYWJzLm9yZw0KPiA+IENjOiBCTUMtU1cgPEJNQy1TV0Bhc3BlZWR0ZWNo
LmNvbT4NCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIHYzIDIvNF0gdXNiOiBhc3BlZWQtdmh1Yjog
Zml4IHJlbW90ZSB3YWtldXANCj4gPiBmYWlsdXJlIGluIGlLVk0gdXNlIGNhc2UNCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEJlbmphbWluIEhlcnJl
bnNjaG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXks
IERlY2VtYmVyIDE0LCAyMDIxIDEwOjM2IEFNDQo+ID4gPiBUbzogTmVhbCBMaXUgPG5lYWxfbGl1
QGFzcGVlZHRlY2guY29tPjsgRmVsaXBlIEJhbGJpDQo+ID4gPiA8YmFsYmlAa2VybmVsLm9yZz47
IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Ow0KPiA+ID4g
Sm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWou
aWQuYXU+OyBDYWkNCj4gPiA+IEh1b3FpbmcgPGNhaWh1b3FpbmdAYmFpZHUuY29tPjsgVGFvIFJl
biA8cmVudGFvLmJ1cHRAZ21haWwuY29tPjsNCj4gPiA+IEp1bGlhIExhd2FsbCA8anVsaWEubGF3
YWxsQGlucmlhLmZyPjsga2VybmVsIHRlc3Qgcm9ib3QNCj4gPiA+IDxsa3BAaW50ZWwuY29tPjsg
U2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPjsNCj4gPiA+IGxpbnV4LXVzYkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC1hc3BlZWRAbGlzdHMub3ps
YWJzLm9yZw0KPiA+ID4gQ2M6IEJNQy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPg0KPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzRdIHVzYjogYXNwZWVkLXZodWI6IGZpeCByZW1vdGUg
d2FrZXVwDQo+ID4gPiBmYWlsdXJlIGluIGlLVk0gdXNlIGNhc2UNCj4gPiA+DQo+ID4gPiBPbiBU
aHUsIDIwMjEtMTItMDkgYXQgMDI6MzcgKzAwMDAsIE5lYWwgTGl1IHdyb3RlOg0KPiA+ID4gPiBJ
J20gY29uZnVzZWQuIFNpZ25hbGluZyBXYWtldXAgd2hlbiB3YWtldXBfZW4gaXMgc2V0IGlmIGl0
IGhhcyBhbnkNCj4gPiA+ID4gZXAgYWN0aXZpdGllcyBpcyBub3QgZXhhY3RseSB3aGF0IHlvdSBz
YWlkPw0KPiA+ID4gPg0KPiA+ID4gPiB3YWtldXBfZW4gaXMgc2V0IG9ubHkgaWYgaG9zdCBhbGxv
d3MgdGhpcyBkZXZpY2UgaGF2ZSB3YWtldXANCj4gPiA+ID4gY2FwYWJpbGl0eSBhbmQgYnVzIGJl
aW5nIHN1c3BlbmRlZC4NCj4gPiA+ID4NCj4gPiA+ID4gTm9ybWFsIGVwIGFjdGl2aXRpZXMgd291
bGQgbm90IHdyaXRlIHRoZSBNTUlPIGJlY2F1c2Ugd2FrZXVwX2VuIGlzDQo+ID4gPiA+IG5vdCBz
ZXQuDQo+ID4gPg0KPiA+ID4gSHJtLi4uIEkgZGlkbid0IHRoaW5rIHdha2V1cF9lbiB3YXMgbGlt
aXRlZCB0byB0aGUgYnVzIGJlaW5nDQo+ID4gPiBzdXNwZW5kZWQsIGJ1dCBtYXliZSBJIG1pc3Jl
bWVtYmVyLCBpdCdzIGJlZW4gYSB3aGlsZS4NCj4gPiA+DQo+ID4gPiBDaGVlcnMsDQo+ID4gPiBC
ZW4uDQo+ID4gPg0KPiA+DQo+ID4gd2FrZXVwX2VuIGlzIG9ubHkgc2V0IGluIHRoZSBjYXNlIG9m
IGhvc3Qgc2V0DQo+IFVTQl9ERVZJQ0VfUkVNT1RFX1dBS0VVUA0KPiA+IGZlYXR1cmUgdG8gdmh1
YiBkZXZpY2VzLg0KPiA+IEkgdGhpbmsgdGhpcyBiZWhhdmlvciBvbmx5IG9jY3VycyBkdXJpbmcg
aG9zdCBpcyBnb2luZyB0byBzdXNwZW5kLCBhbmQNCj4gPiBzZXQgdGhpcyBmZWF0dXJlIHRvIGFu
eSBkZXZpY2Ugd2hpY2ggY2FuIHdha2V1cCBpdHNlbGYgYmVmb3JlIHNsZWVwLg0KPiA+IFRoYW5r
cw0KPiA+DQo+ID4gLU5lYWwNCj4gPg0KPiBXb3VsZCB5b3UgbGlrZSB0byB0ZXN0IGl0IGlmIHlv
dSBoYXZlIHNvbWUgZnJlZSB0aW1lLg0KPiBQbGVhc2UgZmVlbCBmcmVlIGZvciBhbnkgZmVlZGJh
Y2suDQo+IA0KPiAtTmVhbA0KDQpHZW50bGUgcGluZyBmb3IgdGhpcyBwYXRjaC4NClRoYW5rcw0K
DQo=
