Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C28F58670E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiHAJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiHAJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:47:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01EF2BB06;
        Mon,  1 Aug 2022 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659347221; x=1690883221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EJZJ6du7mhop/vnzSOjNtOGgR0Ivm4yRxBH+FPLbtwg=;
  b=aXz+A/ciOS5yNP2b7CXTLw1c0Zup7Omi1gTRHvq999UzqV3uBEGaRf29
   jxmm2M3liCHP/+69S4Bhkd2rTNgQTmsx5stcpGAg4sQhj9t6V/w0xg0gv
   s+sPO+t41pshXaT9e410ycRF37ftgnWF5AEjUmyM7smt78pxJfB1kKh8L
   mKbv7NOITd7DgkUdb8eJtKtSq947i5GQoyz3odt8UlMi3pD4Pr8FnHo5Z
   HsF5NQLRVWoFjiuN5B/74gsN7HoXizezrfK8TJsHbmG2WdDf32R0GQ/Zd
   wjSqmHigu8EBqj24jMs9pypbgSjEVXzS+gxkVWRw72hQOk2+mX/94yRm3
   A==;
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="167246839"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2022 02:47:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 1 Aug 2022 02:46:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 1 Aug 2022 02:46:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wi5Km/wOxqX7xk/Um2KyBZJLXbNBrwvSJS0kuSnKejAWRQ1MKyDWKiMv78TaMHqRPnrE5Kug4UZyTBWDczyRcZUibnHXexbWJiBhVUAqVCRHYgZRcxs+kBWBkJ+CPDUePmV/Kh9U/frcigRILmMAlyMVfBdpZQnV4NVuhUE1aEPLvSPGasneodelVNqZxTsogADiugMlRX7dxeWeKt3X/WZ+HrRzo1ZIhTIEoTMMOMuHZXaLT9DvMI1O5gljUIPqHQw3AgxXeN2OYsZxQTyyWL7sUmnmpYv/Pi4PdPnz2Gj1OB1S+vJbb9Y77nGaikYvMa/9OAbf9wUM4YFMwSe5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJZJ6du7mhop/vnzSOjNtOGgR0Ivm4yRxBH+FPLbtwg=;
 b=G7YmiHPnwNhYQnfVM3Bd2LfIBaQsuBW7SS/udYqZ7WhBIthBrS3J1nt29MjplfJRQCN1Rbrn6hkl2qVge8NQOBYTS6E5gYqvOtejpMeIA2UTSlLQf3OerUapvcWYLdH3XtybDC5kJ0ihuEV8HDBD3k7rlYAt9bMIKeRrFN0MHS3j8kvRSQKJHBlGE+bMuMTzXctRGvT0Kjydk7tSnePoENW3UgH+wB423J4JmIyExc8DOBQqBXhV84AL0usiXLzbWwRMkF7uZu6LUvgFs5E5c37SmUDPm9OsmWAmlKqAtbMVMr88N6eHq3g2RRzcrawXXZ3+1Dh/0b0yJtni8X47oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJZJ6du7mhop/vnzSOjNtOGgR0Ivm4yRxBH+FPLbtwg=;
 b=UdCE3GqwG/aHhEa2lfsyzXnxMjOjXl/FCUOF/0cv3EALek4m2rIRue8jbe8QBpkIy+WjuacMzyvfJeILc8lMRrXtLkWZ/EIu4RlWcFL40QV4a+hhIsHvSWhVD/jHzQPq9EMnpKIOtkucCgWIEw0tb4wrbK2qPHVNnZwR2ZCUIEE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 09:46:57 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 09:46:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jic23@kernel.org>
CC:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 00/19] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Thread-Topic: [PATCH v2 00/19] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Thread-Index: AQHYpYujfuYmEdrMxEKQa2/KlwzRGg==
Date:   Mon, 1 Aug 2022 09:46:57 +0000
Message-ID: <33008bfc-81f8-6943-0e72-70a1e91a10bf@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
 <20220716174249.687af22b@jic23-huawei> <20220731211351.072e3334@jic23-huawei>
In-Reply-To: <20220731211351.072e3334@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: febbc697-5cca-479e-ac42-08da73a2c617
x-ms-traffictypediagnostic: SJ0PR11MB5615:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnkklaLG9I0WjwyuiQC5jte9iJpOPsjGceIpE3xsWxMZqyT0CSFFV2Xl4gM0dkTs42APbWsXg/uWTlBGvnPi/tDawRksLJhnob5030pagQ7xYPevY2Q7pziMvSKBK8aD/uRJahQw+3Vc65MhYZ6hqHCYzfE6qcDJdehSIStZFFIwLbxTZ7Br9h1EE9Pyv7eWfzYD9ojWHT/5VbWGjJpAVGo3vHLIbir8pRdvCYjo/kurV3OT4hOxCq1UG7rBWBN9VI9kq9Pu5kcq2yNViczVrnHgiIAhe24gPJKCx0jRGFJCuQ5UNVNYNTSHVoq/X/de/1M75NPmfLLCr2TERQndlGPC8h3UxoAZIgtLOWC74L6E4SiEAGu9pOHt3FwT/iM6yzVOM3AZ+0ol1sMoLsky8230azu5wcCmC8nhGVR7neeXnl9ZXsJlF0Ofsq9nlMEDvhNOR6MX3U1ogDXpqenroYn2RKSzyszYhq8oHSv14W05S2d3NpLaTEcRojR8wsIwQOpnlLfqXxenhyzNo8qWkkCGqnt0T0s2dVxZ9rA0IxeWAd7gt3BR9uDpDFzisa1170G7voSZN0jGK/TLUwYAKn1tBwQaiX9rjnPXSywzVw6bk/LNB566zU1eh2GGioL7iPTUbmev1X+T+RdcgUDHRRKhBt3V7Stul9r1C8GO7UhNVi2fkWkjb36ThrALhtWTVN9OgE3eQ8APl6Y8Op6wRPvrWmVlueWfCta9rxxrzhrKzzSWjyUVx4xFo3QmGA9o2h5rAqgHDwqjol/g9tCO5M491fZS/fTwH+7MgzevcdYNIPMydVjEHGQxXtjpLaj3Vs9m8tdDDUNAz1D+tkBDhUifzRfANlGor+Il2WEhWQQ3dOMCjJXGRG/LgIZvFu6vGDE0sstPj/U3uDN265ZEww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(346002)(396003)(376002)(5660300002)(36756003)(8936002)(64756008)(8676002)(66556008)(66476007)(2906002)(76116006)(41300700001)(66946007)(91956017)(66446008)(31686004)(316002)(4326008)(53546011)(54906003)(71200400001)(6916009)(478600001)(6486002)(966005)(122000001)(6506007)(38070700005)(6512007)(2616005)(186003)(38100700002)(86362001)(31696002)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2NLbTZVOXd4R0ZrLzRDSFp0Q2h3bXVDUFRyUzFlT1U4R01jMzR2WlgvbFlF?=
 =?utf-8?B?WVBsRS9vL1VHNU1zbU5VZGVsQVhKMVBQOTVkK0lnUXZkZGtLR2ZCeERDWnZJ?=
 =?utf-8?B?QW80T3RKaGI1Q2hhNzRNdktta1N6S1pTWUgzUGNqKy9SdUVNMm02eGc3MWRK?=
 =?utf-8?B?dHpVUW4rQUxyYXQvWWFibHVXSG9ZTkpXWEw3NWZPakUvODFScFlDb0dKc3RR?=
 =?utf-8?B?M2x1NWJkd0h0STIvay9OMjgzcVZrNklFbjkzQm1xZTk2ZVhpcFdHN25oRzVM?=
 =?utf-8?B?Mm1PYkdURkZDdUNrYXVhVmZmemJ5WUpQTVhWekpQUkhNbStwUS8vZEw4TlFK?=
 =?utf-8?B?cFl5VEFTWnlvZE9hWGh5UFV0THFSTFpMOEl1Nk9IRUZXM0g2YnpoWiswZ093?=
 =?utf-8?B?K1daZ3JobXU3d0dGeFE1M2VZZkhBY0JhYmgzbHQ5WTMzajcxSVZ0TDJPZ2Nr?=
 =?utf-8?B?bGR4NS9UUGlhSkdsaldWVkp0Y3kzOU9ZWEkrRGxXSFBxdFRjY3c4V2hsTm9q?=
 =?utf-8?B?Nno3RlZKT2w2RnRuTmF3NFdzWGlVMDBxb1E3cmFMUEV4WUR5VEJCMm50Y0Nn?=
 =?utf-8?B?VU16Wk9MZkRXTUlRNWd6emlMVVhHeis1dDZWVkpMQ2l4blF1ejYxN25ybFdP?=
 =?utf-8?B?YXRxL0xtY3laUXJ2d21mcUdOYnNSa052RVhlaTFvNDRKaUN2SVltclhVcW0v?=
 =?utf-8?B?ZzkwOEFSaHFUSFNNSUlLejNxTngwOHczdFFITlc2ZWpvSUxKcEFKcEc4eFkr?=
 =?utf-8?B?eFZuYzJXZzE0UFFGeDdIWEhHdFd2SDhzVmhrVE1odkd3S0tRdDRUV2VrTzhx?=
 =?utf-8?B?R0xwNGtUQU9SeGdsTm9ZUmpscng5b1Nod0lNMzg2YXZiU3lUYUZlQWM5QTBC?=
 =?utf-8?B?OWFhSzhlZDNVNGxQOXNMWDVWUmxkWFplbWRwZW9DUjhhVUVFcEthVk5MY28x?=
 =?utf-8?B?U1dTNzNOK2pTVUxyWWsvenFZTGJENkt0eVRVQ2ZldnRLQTZCZ3VvOVk5aWdL?=
 =?utf-8?B?dCtldnRDUThXSUFEOUJTdTg4N0k3UXJ6OGJWMHZOc05qbTVVZ2lqdDlUMi9U?=
 =?utf-8?B?VUwyaHl0VGNjM3c0NTlVUjRIMmNEMFFsOHBPUVJGQXB4cytrMFF4RzhGd1RR?=
 =?utf-8?B?c25NekJOdVh6MWMxN3lXSkFveFlKRnJEQVJiMDVycUFlNjYvRStTVmlKZW1Y?=
 =?utf-8?B?K2VUR0d2b3lxMWJFbFh6Z3pjamsxMFZjeGU4Vk10Tk92czV6WUNFeVVhMklx?=
 =?utf-8?B?NDFHNnRDSHZQQTBhb2N6cTV2U3hHdy9ObER2Zk56OTRjUmFnUzBMT3MrMlZ5?=
 =?utf-8?B?OE1xY01YdFVuZGJDaW5RYXlKdlg3ZXpoRjdaY0JNMVB3NStpMlZHT1lqYnRk?=
 =?utf-8?B?VnFpQ0gxVmNDd24yUHV4d3RPekpBS0VSdzNQUGFwbk8rNDZNTk56dlJvMHkz?=
 =?utf-8?B?MmNiRVpLYmIxT0JicndQblhsQitqN1o2eWM2Y2kzTzZvcC9tckZzZHh4dmYz?=
 =?utf-8?B?MTc0Q0htcks1OC9OVktuQk9sbExBcmhtZHFPMi9SRFRJV1FnM3lkN3JrYm54?=
 =?utf-8?B?WjF4SlFlb2ozZnlWOHBqLzIzZHZhM0hWSEVyWjdDb3FaVVcyUTMxdjQ1Qmd6?=
 =?utf-8?B?SVRJem5NZEhRWFFyS0tFc1VBNDQ4WThNMjhWWHc2cTFsYjB4T1lNVnU2ZC9p?=
 =?utf-8?B?cTVoOGRhTUFlMHl5L0w4QWtxcFpaOWJJdjBHSHpXMDM1elpGNCtYVTFXdC83?=
 =?utf-8?B?Mlk2SHh2U1cyOEp0WWFkREh0K2FaV3RqSzhkaUhyMndHMmd2WWQ2c25GQW8w?=
 =?utf-8?B?ZnVmZWx3SEdId0EvSVZRNWZaalQzdjZ0cXg4bkpLN1JNSnBvdGNmdFVLOTRu?=
 =?utf-8?B?bnFiT3pzU1hHWjlPWTRwVktJdVM2ZGIrT2ZGY2ZmSVg0Q3lpRmc2TkZjRHZi?=
 =?utf-8?B?NkRIWDhub01IWWVQZzF3QjJGbm5Nd0hwWXI2WTA3NFQ1ek4xWVM2VWFiUEF1?=
 =?utf-8?B?TXRCeDhoNk5lNy93RTZiNjhDNng4bnpQMkl5dWFTUyt1SFFyelhWVmtMdWdl?=
 =?utf-8?B?aDNCNnFWbWJIK1ZqZ29PVDg2bW5pc2tqRXZzUDI1eGFuSFp3cXJKSm8zQk5m?=
 =?utf-8?B?YUJsdUQ5QS9pSUZPK3JkZksraXpNcU1USUpYakxZVExwa1ZPUndndGEyTlps?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F81B1F2DFE0E9D49A76A7D41A4EFC6F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febbc697-5cca-479e-ac42-08da73a2c617
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 09:46:57.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ny37y4Acm6cg6WPxu9RAozr/TDl/yjx4tcDET0DBNoj2eqFy7vWrz6rVjA/OHT9MclGLCw7CQgzG7gGlKhrTItEvVsCeq++pi0Yyc77fV28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDcuMjAyMiAyMzoxMywgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBTYXQsIDE2IEp1bCAyMDIyIDE3OjQy
OjQ5ICswMTAwDQo+IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IHdyb3RlOg0K
PiANCj4+IE9uIFR1ZSwgMjggSnVuIDIwMjIgMTg6MTY6MTIgKzAzMDANCj4+IENsYXVkaXUgQmV6
bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+DQo+Pj4gSGksDQo+
Pj4NCj4+PiBUaGUgZm9sbG93aW5nIHNlcmllcyBhZGQgc3VwcG9ydCBmb3IgdGVtcGVyYXR1cmUg
c2Vuc29yIGF2YWlsYWJsZSBvbg0KPj4+IFNBTUE3RzUuDQo+Pj4NCj4+PiBUZW1wZXJhdHVyZSBz
ZW5zb3IgYXZhaWxhYmxlIG9uIFNBTUE3RzUgcHJvdmlkZXMgMiBvdXRwdXRzIFZURU1QIGFuZCBW
QkcuDQo+Pj4gVlRFTVAgaXMgcHJvcG9ydGlvbmFsIHRvIHRoZSBhYnNvbHV0ZSB0ZW1wZXJhdHVy
ZSB2b2x0YWdlIGFuZCBWQkcgaXMgYQ0KPj4+IHF1YXNpLXRlbXBlcmF0dXJlIGluZGVwZW5kZW50
IHZvbHRhZ2UuIEJvdGggYXJlIG5lY2Vzc2FyeSBpbiBjb21wdXRpbmcNCj4+PiB0aGUgdGVtcGVy
YXR1cmUgKGZvciBiZXR0ZXIgYWNjdXJhY3kpLiBBbHNvLCBmb3IgYmV0dGVyIGFjY3VyYWN5IHRo
ZQ0KPj4+IGZvbGxvd2luZyBzZXR0aW5ncyB3ZXJlIGltcG9zZWQgd2hlbiBtZWFzdXNpbmcgdGhl
IHRlbXBlcmF0dXJlOg0KPj4+IG92ZXJzYW1wbGluZyByYXRlIG9mIDI1Niwgc2FtcGxpbmcgZnJl
cXVlbmN5IG9mIDEwTUh6LCBhIHN0YXJ0dXAgdGltZSBvZg0KPj4+IDUxMiB0aWNrcywgTVIudHJh
Y2t0aW09MHhmLCBFTVIudHJhY2t4PTB4My4NCj4+Pg0KPj4+IEZvciBjb21wdXRpbmcgdGhlIHRl
bXBlcmF0dXJlIG1lYXN1cmVkIGJ5IEFEQyBjYWxpYnJhdGlvbiBkYXRhIGlzDQo+Pj4gbmVjZXNz
YXJ5LiBUaGlzIGlzIHByb3ZpZGVkIHZpYSBPVFAgbWVtb3J5IGF2YWlsYWJsZSBvbiBTQU1BN0c1
Lg0KPj4+DQo+Pj4gUGF0Y2hlcyAxLzE5LTQvMTkgcHJvdmlkZXMgc29tZSBmaXhlcy4NCj4+PiBQ
YXRjaGVzIDUvMTktMTYvMTkgcHJlcGFyZXMgZm9yIHRoZSBhZGRpdGlvbiBvZiB0ZW1wZXJhdHVy
ZSBzZW5zb3INCj4+PiBzdXBwb3J0Lg0KPj4+IFBhdGNoIDE3LzE2IGFkZHMgdGhlIHRlbXBlcmF0
dXJlIHNlbnNvciBzdXBwb3J0Lg0KPj4+DQo+Pj4gQWxvbmcgd2l0aCB0ZW1wZXJhdHVyZSBzZW5z
b3Igc3VwcG9ydCBJIHRvb2sgdGhlIGNoYW5jZSBhbmQgYWRkZWQNCj4+PiBydW50aW1lIFBNIHN1
cHBvcnQgaW4gdGhpcyBzZXJpZXMsIHRvbyAoaGFuZGxlZCBpbiBwYXRjaCAxOS8xOSkuDQo+Pj4N
Cj4+PiBUaGUgcmVzdCBvZiBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIGFyZSBtaW5vciBjbGVhbnVw
cy4NCj4+DQo+PiBPdGhlciB0aGFuIHRoZSB1c2Ugb2YgTUVHQSBpbiBwYXRjaCAxNywgSSdtIGZp
bmUgd2l0aCB0aGlzIG5vdywgYnV0DQo+PiB3b3VsZCBsaWtlIHRvIGxlYXZlIG1vcmUgdGltZSBm
b3IgRXVnZW4gYW5kIG90aGVycyB0byBjb21tZW50IGlmIHRoZXkNCj4+IHdpc2guICBHaXZlbiB0
aW1pbmcsIEknbSBhZnJhaWQgdGhpcyBpcyB2ZXJ5IHVubGlrZWx5IHRvIG1ha2UgdGhlIG5leHQN
Cj4+IG1lcmdlIHdpbmRvdyBhbnl3YXkgbm93LCBzbyB3ZSBoYXZlIGxvdHMgb2YgdGltZS4NCj4g
DQo+IExvbmcgZW5vdWdoLiAgSSdsbCBxdWV1ZSB0aGlzIHVwIHRob3VnaCBmb3Igbm93IGl0J2xs
IG9ubHkgYmUgZXhwb3NlZCBhcyB0ZXN0aW5nDQo+IGFzIEknbGwgYmUgcmViYXNpbmcgdGhlIHRv
Z3JlZyB0cmVlIG9uIHJjMSBvbmNlIGF2YWlsYWJsZS4NCg0KSSBzYXcgdGhhdCBrYnVpbGQgcm9i
b3QgZm91bmQgc29tZXRoaW5nIChyZXBvcnRlZCBhdCBbMV0pLiBJcyBpdCBPSyB0byBqdXN0DQpz
ZW5kIGEgcGF0Y2ggZml4aW5nIHRoZSBpc3N1ZSBvciB3b3VsZCB5b3UgbGlrZSBtZSB0byBpbnRl
Z3JhdGUgdGhlIGNoYW5nZXMNCmluIHBhdGNoIFsyMS8zMF0gaWlvOiBhZGM6IGF0OTEtc2FtYTVk
Ml9hZGM6IGFkanVzdCBvc3IgYmFzZWQgb24gc3BlY2lmaWMNCnBsYXRmb3JtIGRhdGEgYW5kIHJl
c2VuZCB0aGUgd2hvbGUgc2VyaWVzLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQpb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwODAxMDc0NS5RWlJZQ2lodS1sa3BA
aW50ZWwuY29tLw0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4+DQo+PiBT
b3JyeSBmb3IgdGhlIGRlbGF5IGluIG15IHJldmlld2luZyB2Mi4gUGVza3kgY292aWQuDQo+Pg0K
Pj4gSm9uYXRoYW4NCj4+DQo+Pj4NCj4+PiBUaGFuayB5b3UsDQo+Pj4gQ2xhdWRpdSBCZXpuZWEN
Cj4+Pg0KPj4+IENoYW5nZXMgaW4gdjI6DQo+Pj4gLSBhZGRyZXNzZWQgcmV2aWV3IGNvbW1lbnRz
DQo+Pj4gLSB3aXRoIHRoaXMsIG5ldyBwYXRjaGVzIHdlcmUgaW50cnVjZWQgaW4gdGhpcyBzZXJp
ZXM6IDIvMTksIDQvMTksDQo+Pj4gICA4LzE5LCA5LDE5DQo+Pj4gLSBydW50aW1lIHBtIHN1cHBv
cnQgaGFzIGJlZW4gYWRhcHRlZCB0byB3b3JrIGFsc28gd2hlbiBDT05GSUdfUE0NCj4+PiAgIGlz
IG5vdCBlbmFibGVkDQo+Pj4gLSBjb2xsZWN0ZWQgdGFncw0KPj4+DQo+Pj4gQ2xhdWRpdSBCZXpu
ZWEgKDE5KToNCj4+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBmaXggQVQ5MV9TQU1B
NUQyX01SX1RSQUNLVElNX01BWA0KPj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGNo
ZWNrIHJldHVybiBzdGF0dXMgZm9yIHByZXNzdXJlIGFuZCB0b3VjaA0KPj4+ICAgaWlvOiBhZGM6
IGF0OTEtc2FtYTVkMl9hZGM6IGxvY2sgYXJvdW5kIG92ZXJzYW1wbGluZyBhbmQgc2FtcGxlIGZy
ZXENCj4+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBkaXNhYmxlL3ByZXBhcmUgYnVm
ZmVyIG9uIHN1c3BlbmQvcmVzdW1lDQo+Pj4gICBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzog
ZXhpdCBmcm9tIHdyaXRlX3JhdygpIHdoZW4gYnVmZmVycyBhcmUNCj4+PiAgICAgZW5hYmxlZA0K
Pj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGhhbmRsZSBkaWZmZXJlbnQgRU1SLk9T
UiBmb3IgZGlmZmVyZW50IGh3DQo+Pj4gICAgIHZlcnNpb25zDQo+Pj4gICBpaW86IGFkYzogYXQ5
MS1zYW1hNWQyX2FkYzogbW92ZSB0aGUgY2hlY2sgb2Ygb3ZlcnNhbXBsaW5nIGluIGl0cw0KPj4+
ICAgICBmdW5jdGlvbg0KPj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGRyb3AgQVQ5
MV9PU1JfWFNBTVBMRVMgZGVmaW5lcw0KPj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6
IGFkZCAucmVhZF9hdmFpbCgpIGNoYW5faW5mbyBvcHMNCj4+PiAgIGlpbzogYWRjOiBhdDkxLXNh
bWE1ZDJfYWRjOiBhZGp1c3Qgb3NyIGJhc2VkIG9uIHNwZWNpZmljIHBsYXRmb3JtIGRhdGENCj4+
PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBhZGQgNjQgYW5kIDI1NiBvdmVyc2FtcGxp
bmcgcmF0aW8NCj4+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBtb3ZlIG92ZXJzYW1w
bGluZyBzdG9yYWdlIGluIGl0cyBmdW5jdGlvbg0KPj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVk
Ml9hZGM6IHVwZGF0ZSB0cmFja3ggb24gZW1yDQo+Pj4gICBpaW86IGFkYzogYXQ5MS1zYW1hNWQy
X2FkYzogYWRkIHN0YXJ0dXAgYW5kIHRyYWNrdGltIGFzIHBhcmFtZXRlciBmb3INCj4+PiAgICAg
YXQ5MV9hZGNfc2V0dXBfc2FtcF9mcmVxKCkNCj4+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJf
YWRjOiBsb2NrIGFyb3VuZCBhdDkxX2FkY19yZWFkX2luZm9fcmF3KCkNCj4+PiAgIGR0LWJpbmRp
bmdzOiBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzogYWRkIGlkIGZvciB0ZW1wZXJhdHVyZQ0K
Pj4+ICAgICBjaGFubmVsDQo+Pj4gICBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzogYWRkIHN1
cHBvcnQgZm9yIHRlbXBlcmF0dXJlIHNlbnNvcg0KPj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVk
Ml9hZGM6IGFkZCBlbXB0eSBsaW5lIGFmdGVyIGZ1bmN0aW9ucw0KPj4+ICAgaWlvOiBhZGM6IGF0
OTEtc2FtYTVkMl9hZGM6IGFkZCBydW50aW1lIHBtIHN1cHBvcnQNCj4+Pg0KPj4+ICBkcml2ZXJz
L2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jICAgICAgICAgICAgfCA2ODMgKysrKysrKysrKysr
KysrLS0tDQo+Pj4gIC4uLi9kdC1iaW5kaW5ncy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuaCAg
ICB8ICAgMyArDQo+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNTY2IGluc2VydGlvbnMoKyksIDEyMCBk
ZWxldGlvbnMoLSkNCj4+Pg0KPj4NCj4gDQoNCg==
