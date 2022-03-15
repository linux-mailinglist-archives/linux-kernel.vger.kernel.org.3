Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C34D9BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbiCONMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiCONL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:11:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758933E97
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECkLI9pOI+tss++zkT5yJH8Iq86Nq0wXHUJMFNwNL5Gujp5ODSG27X+F1r0/JmsMWfS5S1KLEkzbGiXqq2ODZYV9sJcHE49mxPxmXO3LT5eM3pLb/tzu6uYxAQMcLVrt4qnwFTl0PAju1/JqRGNvQprehfRWqy/g2iLwRqQR1wSWFTQW+MkX5xdS/U3jFyO2ICWvCI/+sJAoWItykEsm9Bgt0L7teYIRt6I1J9wv9DK3RmU4N8dHD3Sufi7CczqTYE/kmzN/zwe2glujbVAMImvzX7PqCVpsFxeqvfCMBlnp4mkXUVeh4CZA56q5qC+RLttTDHfP3DAK1/kdnUJ40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tv9Br6HyOSXnw8IiPox/zwkoAiyH0R44V7tiijDYc8=;
 b=jzThEGnOJcvS4w6KZ9iRgT2Nm2RFGCxb5xsgMj/bZxIbuorxea51yovQYieto5VukXbJCKfwalR52BWZxATTnuy7miTLyRiR8/U9Fg1izGKoAOhMl5wE1YS0XqF5t4kQamlBZCLRhNy6KN9ov8+TSB2DrnPCA2YXdi2GoKnyyd+ii+KphpNLFibswAEwtN7x5xY+m90xwcOuIHL3N96zaVCawfgOYvJ5YvdCsHs0LEDx664yKOKzupM6CwnbxmobIj4C3VwF2nfptU9xo/pP1gQh8FcW2aAlG1CSgo8oKqaKWmCADH+uR6CUHWLksiZD3TBFNw3brMu5YBTsV+Ae2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tv9Br6HyOSXnw8IiPox/zwkoAiyH0R44V7tiijDYc8=;
 b=D38DIUgxob9gN58Upsh5Yg/3Ie6/E47CQ8OTCmNtETVXJ8BkR+TTabWNMsMQbwSab6MdtEGPWjlTa2chqu866iq8S3XQc7GuDw+9PytDIiQxDldjiw3HA3zbH/xUS6+Oi9z/fc8uw+lnV6rEcZsQczVw0P/ouYnvRAWWeEb7x+8=
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by AS4PR04MB9549.eurprd04.prod.outlook.com (2603:10a6:20b:4f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 13:10:44 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::1c10:3051:5818:abaa]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::1c10:3051:5818:abaa%7]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 13:10:44 +0000
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "arnd@arndb.d" <arnd@arndb.d>, "mst@redhat.com" <mst@redhat.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Thread-Topic: [EXT] Re: [PATCH v2] uwb: nxp: sr1xx: UWB driver support for
 sr1xx series chip
Thread-Index: AQHYOFrTQZfYoxe/4U6A6W9KrdU6tazAUH+AgAAa8oA=
Date:   Tue, 15 Mar 2022 13:10:44 +0000
Message-ID: <51423ae8-66ed-7aeb-8131-7741a3804013@nxp.com>
References: <20220315105205.2381997-1-manjunatha.venkatesh@nxp.com>
 <YjB5ue4nHUUVOW/8@kroah.com>
In-Reply-To: <YjB5ue4nHUUVOW/8@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f054958f-e800-4d60-046f-08da068536ab
x-ms-traffictypediagnostic: AS4PR04MB9549:EE_
x-microsoft-antispam-prvs: <AS4PR04MB9549E7B8A6EE85223DD497098F109@AS4PR04MB9549.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gOupWwX+9DIKx8jLaHkSdPSefw+rngxuBa4627t1HzPoV8JYun0l8XaaavZ5FpJHSQVxLr1b1qzs0QjGlhSh7p55ZK+gDX/u/YpMGAmzKiSDYbfpYw6oNzBlfn16t7VkfIYf1GLku1/nZiP+hKU8sPTlBU/T4C46hwptF+e9OaRSPAq/kHPyDJ5/oLP4mECDLnPtZlnpTKie/Zi8Mc3xS8gdxtvt9VdwJNUJ/2Z7HIGam1pucuyD/c6y+Ai+gfESSP5d4yVYBMK1G057tvjZ2kRuf46GSojL6CKlU2VQVIkJj09xt0raCtP/yFziZpYxvAHMzxjg1WLdIpYRvt+xU3I42UVj80C+AwribsimePvFRAYjUPmNgBtvil/soWMJE5L9OSUl+7hfBQtewc/hICxwnvYJ0rSsyQdHvQHWvP3Xu1x7piqbnED1YnFbtGiMESHiNJ6w77/A5jkVdUpzesB5qGB4O8YMv6raz7tc7r4AQRfU2eWH8NowkMTEubg6UdZQeIbeXpM7bO3U6DqJtoynDjTf/LrJWjc+vI4VwOGQFWKLrDgEL6nQY7f/926XsTCgyRHwWab5efCflGWD4mt1p2t/pRcV7jK/2QqzH3PvQAGaB3wL7TwJ7P716Cj9UKKUmnWo88nGGl7MGqOlLcX7M3UR6WHpUNTVZ8+dPoCNw5xHi/iy194y7m23JlIaS8TvolbIQR33dSV+dvudyCGwk4JIxDHxThaRZPC3cTJ1aaS9ZjmkmMFCe7BerrSHdPZWJIV1SO08dZbTJmcZNyDIIOHtkos34UzGo7YDkthgtFV27yzFvYEoqnnJsF9jLH41oLqz3nHToVMG6Lk73ppITdKBy9YZnpTuOhDXE54sPIDflq1mOvsMC67s7vWv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(54906003)(2906002)(91956017)(66946007)(76116006)(498600001)(36756003)(38070700005)(45080400002)(71200400001)(66476007)(44832011)(966005)(6486002)(7416002)(5660300002)(8936002)(38100700002)(64756008)(122000001)(8676002)(66446008)(4326008)(66556008)(31696002)(86362001)(31686004)(6506007)(6512007)(2616005)(83380400001)(186003)(26005)(53546011)(55236004)(32563001)(45980500001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhpK3ZiM2ZEZDRuWTNiYmIrWkxiNlh1eUkxL3kzQkxUakxhNGljRHZWbHNH?=
 =?utf-8?B?bnVrc3FiV3N2djZhTUpCdE00OGtGNjRxVndubFR2bGlrS0d4N0hzMXpSa1dp?=
 =?utf-8?B?cncwc0FvTGdNV0o5WUpBMnZrbzVVNEZIenNHUUYwTmpSTG1iYzR0OWRCL293?=
 =?utf-8?B?anMrUXVDZkt0OVpHSC9DVk5GdG5kaTVuTVRNVitPOGhlQ0w3WXcyOHc0Q3NG?=
 =?utf-8?B?UW1NTjBHaTNNaFZTcjhmcUpjT3I1WXFvS1hrQjVNNUY4ZFFJVmNVaEtQOWlW?=
 =?utf-8?B?VnpkVkRjQzFNSlYrUkZGRWU5TnlIMmxEMm9URThZZUxiR2FwaEQyT2U2akU1?=
 =?utf-8?B?aDZiUDJROHlRbjQrMEdWSjlDSExGUlNCSmMwYUVpekZIWnM4aE5mRDRFYjlP?=
 =?utf-8?B?a0VyaTVoOVVsS0tQSU9FTFJ4UjQyZXU2REhkZkRoUm54VDdBaG42TTI3bVgw?=
 =?utf-8?B?VnNKRU52QkZCRGtLbng3c04zZWg1VFpiM1Noc3l3TGlieUd2ZlE5K1hIdFB2?=
 =?utf-8?B?THR5a0FvODA1RURuVEM0aCtUdExQaTlESXU5SzVqTmltWEVRSHV6L2xCMHRx?=
 =?utf-8?B?dExlRUJXTXR2d3dwSzJ3WFhQL3hVQ0JicXlXM3BjMEdKWVJkTTNITjJQUkJE?=
 =?utf-8?B?dVNBWWg5NzFEY3UzODVVcHE1VFVjemxiT3kzTDNzTjFLSDBlcGpUcGE0WEhQ?=
 =?utf-8?B?UElVQnlzTjArSXNSak9oT0YyTElhcGVTVnJtNVFxbS9ZR25IWnJRek5yNEkz?=
 =?utf-8?B?cnZBL2ZabFhYV2VteUE5WVNnMy9tUEhIU3BRSzhEa0ZVU2E0aXR4Y1lvY29w?=
 =?utf-8?B?QmI5cGFPUE9ybG93WUJUNHZYYlB6WkZFTDlmaXRvNEx6eWlCVXJsN00vQlc2?=
 =?utf-8?B?cXNiZ2ZFZUwxcm54d2poRXo4VEpuclVMVlFERW4xZGl2Zmd4WFdHRmpqQ1lB?=
 =?utf-8?B?ZVQzUjFTQkoyRHUwbGdDemgvWThRTmdZa2oxUHFvSG1XZ2RZTVE1a1JZNFEz?=
 =?utf-8?B?Uzk1MFZ4YzEzY29aeWRTSGdrK1dxTkZrKzliQUFaS0FxTUtTdFpNOCt0TEY1?=
 =?utf-8?B?Z3VPemQ3M1pHWDNuOUJ6eCsrUSs2T0FWUlgwSHRTTk81eGR1UG45eTNBWC91?=
 =?utf-8?B?MkIyT0R6Y3pmV2pLd2xQdlQrRXZzanZNbU9XL3FMZWo1VXdpeE90K01MczNC?=
 =?utf-8?B?cVZYL1hDdEwvV2diTzNXNitteHJVb3JVeHNBY2JUd3RrajR2YWh2TEtsNnNz?=
 =?utf-8?B?blZtSU9wZzRkZmFXeDBhWU9PZjYzK2R2OWU3enNkZkNUckhCdjdpTlVqTlJY?=
 =?utf-8?B?cW9jRHpkVm1ac2J1ZDl0aDVWanVKUzZIL1hHcXNaYWZDdmUwODdHam5uclpT?=
 =?utf-8?B?eEZ6R0xaeFNiVEZwTGZ5Rm1ydlA4am1lS0RvNUJqNm9XOWJyT1Y5dWx2TTNy?=
 =?utf-8?B?TmZCRWFtNDFUZDYwcVQwaThFNjhoQ05MaE9RRCtTZWZ1SmgyOW84UzNEOHh3?=
 =?utf-8?B?WUY1YWVqNGhiaUoxdGFlR2JIdHhEWDI5WVF5QVB5eXF6TTQ5K0wzZUdUSXcr?=
 =?utf-8?B?dk4rU0ROeU5PSy8yRnZraVl0cU5NSW5DUDFLeGFuM0FjemNLKzlHWEVVaDMw?=
 =?utf-8?B?eWJpNlRmZHIwNUlaS2dKdHNVM21RUUdQNEJieVpvNUZVT3RTM3NHNFI4KzNN?=
 =?utf-8?B?b3QwYTAydFNIVVcxQXE2a1U5emhETlFpc0hKU1JsUnF4SXQ4L2Q0T2ZWUlN5?=
 =?utf-8?B?ZzJNck8wa0c5OXNjTkhCdE5TRFdmRkd3bzVZMFp0QVZJUFdDNlh0bHM3MDF6?=
 =?utf-8?B?dUJZS1BBdU5BVkZHWlJSeExOR3J4TnFtL29UQSt5OUUzTEdveXlIRy96ZEZh?=
 =?utf-8?B?WlIyKytXaksvSmo3bW1WU0c0TVB2QVZEcGhTQ1pQQjlWYnpoZ09BV3loM3hi?=
 =?utf-8?B?QUhNSXVETWhpMlU1R05FNlFhV2tGcnNMNHE3U3Z6R2F5Q1A2WFdJNlFCQjd0?=
 =?utf-8?B?clo5a2tXSlpRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D75D0E00D300F45A548598DBF23143B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f054958f-e800-4d60-046f-08da068536ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 13:10:44.3472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0QenL+GvCOcpWDQxxFv8v6zMGSjPkUiO2fybtk9IoW9KQwVMmTiWeKqh3BJFFtA2CDxyv44Xjzu3w84WTgblmqwtTTIzQE/xf47zeiDzKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9549
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8yMiAxNzowNCwgR3JlZyBLSCB3cm90ZToNCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+
DQo+IE9uIFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDA0OjIyOjA1UE0gKzA1MzAsIE1hbmp1bmF0aGEg
VmVua2F0ZXNoIHdyb3RlOg0KPj4gVWx0cmEgV2lkZSBCYW5kKFVXQikgaXMgYSBmYXN0LCBzZWN1
cmUgYW5kIGxvdyBwb3dlciByYWRpbyBwcm90b2NvbCB1c2VkDQo+PiB0byBkZXRlcm1pbmUgbG9j
YXRpb24gd2l0aCBhY2N1cmFjeSB1bm1hdGNoZWQgYnkgYW55IG90aGVyIHdpcmVsZXNzDQo+PiB0
ZWNobm9sb2d5Lg0KPiBUaGUga2VybmVsIGNoYW5nZWxvZyBpcyBub3QgdGhlIHBsYWNlIGZvciBt
YXJrZXRpbmcgY29weS4gIFBsZWFzZSBqdXN0DQo+IGRlc2NyaWJlIHRoZSBoYXJkd2FyZSB3aXRo
b3V0IHVzaW5nIHdvcmRzIGxpa2UgdGhpcy4NClN1cmUsIHdpbGwgdXBkYXRlIHRoZSBkZXNjcmlw
dGlvbiBhcyBwYXJ0IG9mIG5leHQgcGF0Y2guDQo+DQo+PiBJdHMgYSBzaG9ydC1yYW5nZSB3aXJl
bGVzcyBjb21tdW5pY2F0aW9uIHByb3RvY29sLiBJdCB1c2VzIHJhZGlvIHdhdmVzIHRvDQo+PiBl
bmFibGUgZGV2aWNlcyB0byB0YWxrIHRvIGVhY2ggb3RoZXIuDQo+Pg0KPj4gVGhpcyBpcyBhIG5l
dyBkcml2ZXIgdGhhdCBzdXBwb3J0cyB0aGUgaW50ZWdyYXRlZCBVV0IgZm9yDQo+PiBOeHAgU29D
cywgZXNwZWNpYWxseSB0aGUgc3IxeHggc2VyaWVzIGFuZCBkZXBlbmRzIG9uIHRoZSBTUEkgbW9k
dWxlLg0KPj4NCj4+IFRoaXMgZHJpdmVyIHdvcmtzIHdpdGggTnhwIFVXQiBTdWJzeXN0ZW0oVVdC
Uykgd2hpY2ggaXMgRmlSYSBDb21wbGlhbmNlLg0KPj4gQ29ycmVzcG9uZGluZyBVQ0kgZGV0YWls
cyBhdmFpbGFibGUgaW4gRmlyYSBDb25zb3J0dWltIHdlYnNpdGUuDQo+Pg0KPj4gc3IxeHggaXMg
Zmxhc2ggbGVzcyBVV0JTICBhbmQgaXQgcmVxdWlyZXMgZmlybXdhcmUgZG93bmxvYWQgb24gZXZl
cnkNCj4+IGRldmljZSBib290Lg0KPj4NCj4+IEludGVybmFsbHkgZHJpdmVyIHdpbGwgaGFuZGxl
IHR3byBtb2RlcyBvZiBvcGVyYXRpb24uDQo+PiAxLkhCQ0kgbW9kZSAoc3IxeHggQm9vdFJPTSBD
b2RlIEludGVyZmFjZSkNCj4+ICAgIEZpcm13YXJlIGRvd25sb2FkIHVzZXMgSEJDSSBwdG90b2Nv
bCBwYWNrZXQgc3RydWN0dXJlIHdoaWNoIGlzDQo+PiAgICBOeHAgcHJvcHJpZXRhcnksRmlybXdh
cmUgRmlsZSguYmluKSBzdG9yZWQgaW4gdXNlciBzcGFjZSBjb250ZXh0DQo+PiAgICBhbmQgZHVy
aW5nIGRldmljZSBpbml0IHNlcXVlbmNlIHBpY2sgdGhlIGZpcm13YXJlIHBhY2tldCBpbiBjaHVu
aw0KPj4gICAgYW5kIHNlbmQgaXQgdG8gdGhlIGRyaXZlciB3aXRoIHdyaXRlKCkgYXBpIGNhbGwu
DQo+PiAgICBDb21wbGV0ZSBmaXJtd2FyZSBkb3dubG9hZCBwcm90b2NvbCBsb2dpYyBpbXBsZW1l
bnRlZCBpbiB1c2VyIHNwYWNlLA0KPj4gICAgRHJpdmVyIHVzZWQgaGVyZSBpcyBraW5kIG9mIHBp
cGUgdG8gc2VuZCBkYXRhIHRvIFNQSSBsaW5lLg0KPj4gICAgRmlybXdhcmUgYWNrbm93bGVkZ2Ug
Zm9yIGV2ZXJ5IGNodW5rIHBhY2tldCBzZW50IGFuZCBzYW1lIHRoaW5nDQo+PiAgICBpcyBtb25p
dG9yZWQsaW4gdXNlciBzcGFjZSBjb2RlKEhBTCBsYXllcikuDQo+PiAgICBJZiBhbnkgZXJyb3Ig
RmlybXdhcmUgZG93bmxvYWQgc2VxdWVuY2Ugd2lsbCBmYWlsIGFuZCByZXNldCB0aGUgZGV2aWNl
Lg0KPj4gICAgSWYgZmlybXdhcmUgZG93bmxvYWQgcGFja2V0IHNlbnQgc3VjY2Vzc2Z1bGx5IGF0
IHRoZSBlbmQgZGV2aWNlIHdpbGwNCj4+ICAgIHNlbmQgZGV2aWNlIHN0YXR1cyBub3RpZmljYXRp
b24gYW5kIGl0cyBpbmRpY2F0aW9uIG9mIGRldmljZSBlbnRlcmVkDQo+PiAgICBVQ0kgbW9kZS5I
ZXJlIGFmdGVyIGFueSBjb21tYW5kL3Jlc3BvbnNlL25vdGlmaWNhdGlvbiB3aWxsIGZvbGxvdw0K
Pj4gICAgVUNJIHBhY2tldCBzdHJ1Y3R1cmUuDQo+Pg0KPj4gMi5VQ0kgbW9kZSAoVVdCIENvbW1h
bmQgaW50ZXJmYWNlKQ0KPj4gICAgT25jZSBGaXJtd2FyZSBkb3dubG9hZCBmaW5pc2hlcyBzcjF4
eCB3aWxsIHN3aXRjaCB0byBVQ0kgbW9kZSBwYWNrZXQNCj4+ICAgIHN0cnVjdHVyZS5IZXJlIHRo
aXMgZHJpdmVyIGFjdHMgYXMgcGlwZSBiZXR3ZWVuIHVzZXIgc3BhY2UgYW5kIHNyMXh4Lg0KPj4g
ICAgQW55IHJlc3BvbnNlIG9yIG5vdGlmaWNhdGlvbiByZWNlaXZlZCBmcm9tIHNyMXh4IHRocm91
Z2ggU1BJIGxpbmUNCj4+ICAgIHdpbGwgY29udmV5IHRvIHVzZXIgc3BhY2UuVXNlciBzcGFjZShV
Q0kgbGliKSB3aWxsIHRha2UgY2FyZSBvZg0KPj4gICAgVUNJIHBhcnNpbmcgbG9naWMuDQo+IFdo
ZXJlIGlzIHRoYXQgdXNlcnNwYWNlIGNvZGU/ICBIb3cgd2lsbCBpdCB0YWxrIHRvIHRoZSBrZXJu
ZWw/ICBXaHkgZG8NCj4gdGhlIGV4aXN0aW5nIHVzZXIva2VybmVsIGFwaXMgbm90IHN1ZmljZSBm
b3IgdGhpcyBvbmUgcmFuZG9tIGhhcmR3YXJlDQo+IGRldmljZT8gIFdlIGhhdmUgc3VwcG9ydCBm
b3Igd2lyZWxlc3MgZGV2aWNlcyBvZiBhbGwgdHlwZXMgdG9kYXksIHdoeQ0KPiBpcyB0aGlzIHNv
IHNwZWNpYWwgaXQgbmVlZHMgYSBjdXN0b20gaW50ZXJmYWNlIGZvciBpdD8NCj4NCj4+ICAgIEl0
cyBJUlEgYmFzZWQgZHJpdmVyIGFuZCBzcjF4eCBzcGVjaWZpYyBpcnEgaGFuZHNoYWtlIG1lY2hh
bmlzbSBsb2dpYw0KPj4gICAgaW1wbGVtZW50ZWQgdG8gYXZvaWQgYW55IHJhY2UgY29uZGl0aW9u
IGJldHdlZW4gd3JpdGUgYW5kIHJlYWQNCj4+ICAgIGR1cmluZyByYW5naW5nIHNlcXVlbmNlLg0K
Pj4NCj4+ICAgIFVDSSBtb2RlIFdyaXRlIGlzIHNhbWUgYXMgSEJDSSBtb2RlIHNlcXVlbmNlIHdo
YXRldmVyIGNvbW1hbmQgcmVjZWl2ZWQNCj4+ICAgIGZyb20gdXNlciBzcGFjZSB3aWxsIHNlbmQg
dG8gdGhlIHNyMXh4IHZpYSBTUEkgbGluZS4NCj4+ICAgIEluIFVDSSBtb2RlIHJlYWQgYXBpIGNh
bGxlZCBmaXJzdCBhbmQgd2FpdGluZyBvbiB0aGUgSVJRIGxpbmUgc3RhdHVzDQo+PiAgICBpbiBv
cmRlciB0byBhdm9pZCBtaXNzaW5nIG9mIGludGVycnVwdHMgYWZ0ZXIgd3JpdGUgc2VxdWVuY2Uu
DQo+Pg0KPj4gICAgVGhpcyBkcml2ZXIgbmVlZHMgZHRzIGNvbmZpZyB1cGRhdGUgYXMgcGVyIHRo
ZSBzcjF4eCBkYXRhIHNoZWV0Lg0KPj4gICAgQ29ycmVzcG9uZGluZyBkb2N1bWVudCBhZGRlZCBp
biBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXdiDQo+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBNYW5qdW5hdGhhIFZlbmthdGVzaCA8bWFuanVuYXRoYS52ZW5rYXRlc2hAbnhwLmNvbT4N
Cj4+DQo+PiBDaGFuZ2VzIHNpbmNlIHYxOg0KPj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGttbC5vcmclMkZsa21sJTJG
MjAyMiUyRjMlMkY3JTJGMTI1NCZhbXA7ZGF0YT0wNCU3QzAxJTdDbWFuanVuYXRoYS52ZW5rYXRl
c2glNDBueHAuY29tJTdDNzA4YTc3ZTYzYjdkNGE1YWVjYTMwOGRhMDY3N2MxOWUlN0M2ODZlYTFk
M2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3ODI5NDA4NjY5NDc3NjEwJTdD
VW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAmYW1wO3NkYXRhPTU0dkloajNu
YWFUNE1SWHZYN25VWGJhVGd4JTJCaUxvRzNOQWtoMUtxSzhWNCUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
Pj4gLS0tDQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgIHwgICA3ICsNCj4+ICAgZHJpdmVycy9L
Y29uZmlnICAgICAgfCAgIDIgKw0KPj4gICBkcml2ZXJzL01ha2VmaWxlICAgICB8ICAgMSArDQo+
PiAgIGRyaXZlcnMvdXdiL0tjb25maWcgIHwgIDI3ICsrDQo+PiAgIGRyaXZlcnMvdXdiL01ha2Vm
aWxlIHwgICA1ICsNCj4+ICAgZHJpdmVycy91d2Ivc3IxeHguYyAgfCA4NTcgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICA2IGZpbGVzIGNoYW5nZWQsIDg5
OSBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3V3Yi9LY29u
ZmlnDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3V3Yi9NYWtlZmlsZQ0KPj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91d2Ivc3IxeHguYw0KPj4NCj4+IGRpZmYgLS1naXQg
YS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+PiBpbmRleCBlMTI3YzJmYjA4YTcuLjMxYzA4
ZWNjMTUyYyAxMDA2NDQNCj4+IC0tLSBhL01BSU5UQUlORVJTDQo+PiArKysgYi9NQUlOVEFJTkVS
Uw0KPj4gQEAgLTIxNDcxLDMgKzIxNDcxLDEwIEBAIFM6ICAgQnVyaWVkIGFsaXZlIGluIHJlcG9y
dGVycw0KPj4gICBUOiAgIGdpdCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0DQo+PiAgIEY6ICAgKg0KPj4gICBGOiAgICovDQo+
PiArDQo+PiArVVdCDQo+PiArTTogICBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4NCj4gSGFoLCBOTyENCj4NCj4+ICtNOiAgIG1hbmp1bmF0aGEudmVua2F0ZXNoQG54cC5jb20N
Cj4+ICtMOiAgIHJ2bWFuanVtY2VAZ21haWwuY29tDQo+IEZ1bGwgbmFtZXMuDQo+DQo+PiArUzog
ICBNYWludGFpbmVkDQo+PiArRjogICBkcml2ZXJzL3V3Yi9zcjF4eC5jDQo+IFRoaXMgbmVlZHMg
dG8gYmUgc29ydGVkIHByb3Blcmx5LiAgUGxlYXNlIHJlYWQgdGhlIGZpbGUgeW91IGFyZQ0KPiBt
b2RpZnlpbmcuDQo+DQo+IEknbSBzdG9wcGluZyBoZXJlLiAgRG9uJ3QgYWRkIGFueW9uZSdzIG5h
bWUgdG8gYSBNQUlOVEFJTkVSUyBmaWxlIHVubGVzcw0KPiB5b3UgZ2V0IGV4cGxpY2l0IHBlcm1p
c3Npb24gZnJvbSB0aGVtIHRvIGRvIHNvLiAgT3RoZXJ3aXNlIGl0IGlzIHF1aXRlDQo+IHJ1ZGUs
IGRvbid0IHlvdSB0aGluaz8NClNvcnJ5LCBOZXh0IHBhdGNoIHdpbGwgcmVtb3ZlIHlvdXIgbmFt
ZSBmcm9tIHRoaXMgbGlzdC4NCj4NCj4ge3NpZ2h9DQo+DQo+IGdyZWcgay1oDQoNCg0K
