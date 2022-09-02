Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE75AA75A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiIBFnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiIBFnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:43:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0EFB6D7A;
        Thu,  1 Sep 2022 22:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662097384; x=1693633384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RI5IWgF0NlDdnH4pfBoje3Tn5l02Jj+23E4OE5feF7g=;
  b=W+2RWX33ebrs2GqW3QgiBQ78xgWG/qHEmnmtVo62hA459KPKSUmqcXKZ
   5P0YmmXyWQwSyx0GRLUkWocvN+bBi0lid+oQgKAAjisJnGRNdbVHWC86R
   /ThSSbFHmoDpbscz3oT2+NnD5/KkRkDnfW6i4qD0vggluLcWd+Z+bMwuP
   h03m627tY8OOvJuwUCMVImrUUX4BupJe+hhOyIC2t4B0tb0eHnOXlZmNZ
   Y1i00SOX3sLfRbTL/Wr1zFDNaD/8DVl1mLOTGsaRZjcGA4OokJfGDn6K9
   OYunuN0SkmwvV2csPCoTCdUJ+ZTq1r5JKAm+NBo3FudIJCMSyEFc/PoSg
   w==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="189116070"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 22:43:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 22:43:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Sep 2022 22:43:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5qRfMkEStoSgvSVt0t3KifxOiCOM+vFAM/3rZYtKfsCLLO3xWE2OEQqgVb4JdOQSXfEMf/ePLAEkemMyoG4QNpIMDMAk0tBqLCVyekBiiQk3rqcqdCdscHSrvmxEFPcwp5j3zFz64IsXR80voS/ZVOYt6Nx32lUkXchyVKgfQKdBtqQtPZhgYc5ldii4pAWK3blitcH8/9AP77aueZ693TvGrbWR1ko0ixTsQjttSYnfw0pn/osxCsJlPXjZoj4Ju54djJsKFOAYscVlfe88j/dX2ePSCwwYsSQKaSAk+5k1J0R/rLmVcxLP8BjX2v18IGaUdJjuLW1KrW3yHxngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI5IWgF0NlDdnH4pfBoje3Tn5l02Jj+23E4OE5feF7g=;
 b=ItI5URcx9XenIG3xzzIxrqTDiItwANsdEVmLjC3CqjeJFfn2SD+9Mhe0QUbWAT5M2LPrwGrxWlsQARhDYGYJwK4hvb/vYyglgQgbTpn4NZZGjeesv3RNBi9l1r+gRQY7jHYxOxU7yYDC6Z6+ndHttgq8N0nkQgI1rrD3OFBv874F+xliMLI9oqQWBp0PmnK9DUXIbv0Vkw5oM/k/hOBlNzL5FJ0/L/yIQAeYtAdmw2aeRwvQlasjUXP4dCKX6xXJ+8IWs8lUHZ+oWI55ZA0Vtf8P8kSR3hhGhDE5VjibJFu70zMcocQ6jqoI/1cbfZo2Zj+AZ52AfmJe+juN7PRJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI5IWgF0NlDdnH4pfBoje3Tn5l02Jj+23E4OE5feF7g=;
 b=pP2f9Wcdo8Q17S8WsnXF4a3S15SVcOh5PL6URjJHyrDdtGqPqCiGBLyWeFNR2a9cTiZNOHB3zrtTQUfE85JVkRQ3Aa9sG0alsXzWDjeRt4iPA+b/XGWDHu0rFFXkW+jIz/jqBDPnWYs6A9A8hxR0X4/EhDitK2pyXKfYP4bbo7E=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 05:42:59 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 05:42:59 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@dabbelt.com>, <samuel@sholland.org>
CC:     <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <linux-sunxi@lists.linux.dev>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 00/12] riscv: Allwinner D1 platform support
Thread-Topic: [PATCH 00/12] riscv: Allwinner D1 platform support
Thread-Index: AQHYsGUX6yPEPkvFO0eCq9swdC/Ww63K+16AgADBj4A=
Date:   Fri, 2 Sep 2022 05:42:59 +0000
Message-ID: <9234d061-bab5-d8ac-cf5c-f90bb942dbf0@microchip.com>
References: <mhng-d98d3324-5f4b-4cb0-a116-522b124dcdea@palmer-ri-x1c9>
In-Reply-To: <mhng-d98d3324-5f4b-4cb0-a116-522b124dcdea@palmer-ri-x1c9>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff10d81b-34d6-4b3a-57d9-08da8ca5fea3
x-ms-traffictypediagnostic: DM6PR11MB4577:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNOjVfnpcyovFrJi9dsKa9JPjpVT2Pan5soxqi4YDEhyR26ryRFDeIPZlK23lohKW8xtsMEQdtluyKcqOM+sP1qyIlE/Q4+Bzf4IUEGoQA/1V7T+5TRoA6kdp4m1OeIfxNvzVZsjXzdLLb6/tyeB8fvCwOBbDBxa6GajKPcbBnQ3EVJi2P/OxHltbGo5joZCQCncd/J0v8z1bitoPLTfMU4SBLBW0+pTRChQqo38gogHRiQsc9830G302uNLh8jerECVpTqMqmR/r0PQBzV+m40f4sL+MmbsqcSJZ4tTWLoDjagnj8c+PPfiPFWlCyBEuo5m9fONDo+OavZ+KdofzzpsXvXvsYsCBQ4MgiVbRDcNtDg3DyIXqq4YJSl6veV/RWqA3fjGrIxiePO8NfdCykgMiV/eTvMno7+fzrifHzOOVA+JzR72Zt+QCRwwGytG2D+ycaeJZ7idqbdF78FleKn9I/kzu3v4V1zO08LdJgW3sPmkCuUdRjrQtBA/rN/c/XTkdO/HEJ1n1FKCRmlDNyKqPUy3hVNsrh/iCpuOFMB94DOD3H5oegP60ORMHbMvHG3DvBSm6CfBbpoooKOiTdz+yY1JyIvPANW3joBURFzBJMwQhLJtCvYcv0LYbFjq6LJk2banzDwR565rTL9q4GpWUfDqOwvDz8mL7Ksb84GbcPNxo3zKn9v7tgqF1yfvbFqbR0oo1U5sBLnOunxIc7zHDUljlklg1eXKX/NPeJjlo9kW0x4V7CanoG0I4RCd13CZei9gMpiYkWlAJ2otJYpgR+1N+QwSd/A+Ed/0AfCurDf2aqzLSgvFAYJRFKnVzz9+jVUGWH6iQzxoznjpzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(396003)(376002)(136003)(2906002)(186003)(36756003)(7416002)(4744005)(26005)(31686004)(6512007)(2616005)(38070700005)(66556008)(66946007)(91956017)(66476007)(8676002)(66446008)(64756008)(4326008)(76116006)(5660300002)(8936002)(86362001)(31696002)(316002)(54906003)(6486002)(110136005)(41300700001)(53546011)(6506007)(122000001)(478600001)(38100700002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUlUVW5pdDZwT1ZFazJGK3hheGdMbTNLSDRDOHMrc1NFaHVaQWh6Sk5ra25H?=
 =?utf-8?B?UlZ2aWE2VUZPQi81MW5sVkEvTWl1bEZHNzF1Z0JmV0RqcHZ5eVBtTXhiTlZu?=
 =?utf-8?B?eDdIWWNub2NOYmFXWGJPUnIxQk9tZDhjNjVGL0tZVEVzbGhmdnF6azNUdThH?=
 =?utf-8?B?SzBmVFozcFdadFpYUko4N2lQSGlXeHdJQ0Z5czV4NEpVZG9HNmlEUy8xNFFD?=
 =?utf-8?B?dHROb0FIWjF5emt0SitUR09KSVFQMzNaaDBseUZreWZXWmovTG4vUTNWS0Zt?=
 =?utf-8?B?MHl6cmtmU1pRWCtyMWhoU1NvYVRnUVA1VmVrc0RiZUYwWXhycXd3NTd1Wmla?=
 =?utf-8?B?SDdoWFJUNkNYR3hldTlCR1A1SWo5SmlzTTI4VzRLeUtrNzN0cVF0VW5PaCs1?=
 =?utf-8?B?bHV3RzVXOW5JNVpJZ2ViM2dtelFOZEZJZHVyMzJ3SWtiV3BqRVovaTBMcFNY?=
 =?utf-8?B?bEdEb2xJbkVTZlZHckV0Y0d4VkltTGU1enNPU2NkZThLQUFDSmZLaW1JaXkz?=
 =?utf-8?B?dmNjbXpmM0NFSzY0ZUxGckZnajV0NTMwN1F1MGdRQi9iU21KYWptd2hYdGJz?=
 =?utf-8?B?M1NvNk9PR1l2NTk2Y1NuenVJcW4ycDd1RU9XTEVFSVIwVFRNNHB0S0ZGQ2pz?=
 =?utf-8?B?ZzNoZ0N5OUJMZmEvQVhVSUVwWFYrYWZQSzFGQ2tPcWpXNHJjZWFQRnJLbG5j?=
 =?utf-8?B?VWd5OFBEMTNRMkNSZmZNZFlScEpZUzA2MmkwanVWeHBxVWFPRys4cmRybWtW?=
 =?utf-8?B?MkJ5T3VwbDZ2RDNrN1ZKU3VsdXJwcFgyekZXNXlpQ25kclRXRVRwd3p4dFND?=
 =?utf-8?B?WVdhRGpnVXhoVXU4cEplVlNxMmMvNEg2dFd3OURidis2aTYwL2NEN1JuNlU1?=
 =?utf-8?B?dmhoQTVEd2JrcnN2RGQ2Nlp2YkdHeGlIaHc0MW1jZ1BHYm5XTXBYS3RSZmNO?=
 =?utf-8?B?eVp4L0pZc2pPZ0o5aTlraUVjSEYxMTRqM3FOZ0lhcnFIeEZMdHFiUlY4OE5O?=
 =?utf-8?B?bUlqYjd4MnhDdUZqK1B4aUZQOU96YkhKd21TRTFCQ0kxbjR1YUVlRy9uZkZ3?=
 =?utf-8?B?Wm5nKzJIZnlPYllTTG5CbzU0bHlyWUNKMk1UVzNOSi9XMkl6TTBUZHFmakhr?=
 =?utf-8?B?b010UktzMXJ1MEZ1NmJDbXNGYm5lVms0a0hHckduY2J4cGZ0aThJL1U5Q0hl?=
 =?utf-8?B?V2RBRWdUM3YyMVdMTUVsVmtxa0N4Y2NyZ21oNlVQWHlVRnhDVXVVMTN3Rk40?=
 =?utf-8?B?RElQc0d0bzFMWjZLQjlMVld0dlFkNFZRaGFXZ25qUkJjczJzeWJUOStZVDRw?=
 =?utf-8?B?c1BBVXVkRFNzVkV4UEdJc3BabERnQyt1RHBKd2RIMk9EVStWaVdTdGZZMGMw?=
 =?utf-8?B?aTZIbzNSUGw4R05EVFdvajE5SnNNdldrRDRZUnU5NkQzM2tqT3pqeXBZejVZ?=
 =?utf-8?B?RXZtRWJVelJFV1hVcUdOa2t4c0ovcGFYcnZLM2VJVWlmOThkbjhtT1RRbGpT?=
 =?utf-8?B?Y2hwZWdZZDZFNWdEczBIcng5MXk5TzI0cFovTUZsZERWbzJRcjRTNUYvNkJH?=
 =?utf-8?B?Q2JPMXNLd3NuTG43SnBqL0c3MDI5cmtBTlMzNExNSG1UdjRIaFNNZzFiOEVl?=
 =?utf-8?B?SGRVeWRqUmZoL08vOXVjeGhpbHZXekRadFZpUVBZS25QVldMVHNiQ2RBbzJu?=
 =?utf-8?B?MDRtTkEwNDdHaDEwRmp2SU5kb28xVjNudkhVWkdmMnIyc01heEthckFmdXNK?=
 =?utf-8?B?RnpKeXN5Y0ZmR1JyMkhrMDVnUHhNb1dmZmI4UllsbDNkUjJib0VwdFlzNWcz?=
 =?utf-8?B?Lzh6M1NTR3MxYzVnMGt6WEFvY2VqcklpNlFyck5wdmpDbGtSZTEzaG0zdHls?=
 =?utf-8?B?Z05xeWpWNTQ2dzZkK0t1K3hzRERXL0paRlBLMENlZllaZUEwTE9rNU9WbW1M?=
 =?utf-8?B?WU9PYzUxUmk2bTRhTHlGL2lUZHZ1aDhONkdyQTN0UjNzRkRsL0FOVjhoVlky?=
 =?utf-8?B?QkJnTXpkYm56bDFMWStnUjlnRGowSEVMTVNlVkdkNU90aFFTM2theEtLYXkv?=
 =?utf-8?B?QmZENTRVZHQrc0t3TEg3MXl6Z2NtUEZsUHhFSy9wby9PMGdjekRtckZ0Mm9D?=
 =?utf-8?Q?9ZCbwWeY5HKI6VqhUxZicVm0J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1BD8B3311A814B942687B284E28C8E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff10d81b-34d6-4b3a-57d9-08da8ca5fea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 05:42:59.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ndl/Ohh/lFVyzbUrzrl+rtux43wSyl9uv5t0xNINDgiHNlzUEcoHAkjmQAqXg8mBLFeyl0ozwG/BDi5Z7HZ00riCvHSf4w7jxznaDoZZe3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDkvMjAyMiAxOToxMCwgUGFsbWVyIERhYmJlbHQgd3JvdGU6DQo+IE9uIFN1biwgMTQg
QXVnIDIwMjIgMjI6MDg6MDMgUERUICgtMDcwMCksIHNhbXVlbEBzaG9sbGFuZC5vcmcgd3JvdGU6
DQo+PiBUaGlzIHNlcmllcyBhZGRzIHRoZSBLY29uZmlnL2RlZmNvbmZpZyBwbHVtYmluZyBhbmQg
ZGV2aWNldHJlZXMgZm9yIGENCj4+IHJhbmdlIG9mIEFsbHdpbm5lciBEMS1iYXNlZCBib2FyZHMu
IE1hbnkgZmVhdHVyZXMgYXJlIGFscmVhZHkgZW5hYmxlZCwNCj4+IGluY2x1ZGluZyBVU0IsIEV0
aGVybmV0LCBhbmQgV2lGaS4NCj4+DQoNCj4gSSBjYW4ndCBmaW5kIGEgdjIsIG5vdCBzdXJlIGlm
IEkgbWlzc2VkIGl0LsKgIE5vIHJ1c2ggb24gbXkgZW5kLCBqdXN0DQo+IHdhbnQgdG8gbWFrZSBz
dXJlIEknbSBub3QgZHJvcHBpbmcgdGhlIGJhbGwgb24gYW55dGhpbmcuDQoNClRoZXJlJ3MgYmVl
biBubyB2MiB5ZXQuDQoNClRoYW5rcywNCkNvbm9yLg0K
