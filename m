Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6E24CFD10
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiCGLfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiCGLfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:35:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E96297;
        Mon,  7 Mar 2022 03:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646652882; x=1678188882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J9Fd9dG/R2XPntSrlJZkFMae+p0Q9dV5Gbhw3VkAXZo=;
  b=LBVLcLw02nM2Ygi4s8RBTIS3Yw5SkiDvtqFUWjlgP/kt6pD3DwneCa7N
   K0EKyXuZGgX2aNSes9+JHOrAbQLzlKdI1r+tvam/1MN270DwGTggtZ+ew
   ZG+VeIsT2oupxwQplq6ObYXan3QW7uK/HokOc1VZmbCUWDW0Q8lZ+XfWA
   aFoG7UWNQnM1SemtHSkF2n9H/YTC7iKereSgcU2O3OGOGT5vh4wuMHGOv
   QX94LpBiZxBa0QHIug3L6Q8saWFIMgZ75kwESFcN5dJlxnX8QZUg9pA2P
   WjSw5huzXih6ytKNRlxcmPSDGulwb5/4PK/pqDcs98Ij7eOfhe3BoHP/X
   w==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155938490"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 04:34:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 04:34:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 7 Mar 2022 04:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJNNpfRDdJoqu9lpnTQ/Rost199G8m5BZC/tsd+C5Va98nc8CQhP740IjoZhAiWS56wkET5HciJDG5zByIqdh6VouEdJBCgVbs2XanUOrJYTbKGw7YC+wzExAFSz276sa20lBtHXuWlkZayDTxhw0N1jyoolj446nd52wFR8UD7vqhHDXMHeYO3IhFnxoDo50hKHOMtD6r7prdokP5Y4QzSduYknZRNLSkqycAnX0vK3RBZHKyR97kQPfqRfXewe67aupAPQ5HFja5wp1fthAx4PZcGNRcbiCEniiw6ff8Fp5a2b7BSpG/rcYQZNfNJYkTFxGtX3uPHdu7WFYancqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9Fd9dG/R2XPntSrlJZkFMae+p0Q9dV5Gbhw3VkAXZo=;
 b=lM4L9S4qJEF/hX4qokQjkyxh8EW8ZjHmxh4TqI78B/baE1vx+zo++qq8hRihV/ldKgEka0rY2JdfeoTKG5twTB8UsEG1DR/kbYx8oaebVNioEM9ciaoCiZlxPaXAEvt0S53yccMzLZfnsElhCHhRo+TZlqEifsPqZ8yn2FhmV8GqFqLCiaVIE0fU5rxlvww0HWCo4YGUwoZlUuh+0gdYS239dvSMTLW8nyR6s37NQXPJIYidNy4lBRHe+G8y3TLBCQVNRUehT/DdFBeEwl27ZI73zV+5GXKEuEy/D7L8OwdpCM9iZ6d4795nRGxq2HaanulkrvEMIl2agLxabZGkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9Fd9dG/R2XPntSrlJZkFMae+p0Q9dV5Gbhw3VkAXZo=;
 b=fOf4HP4u7w0evOoGAezmlfQIL3X5EJp8w5L2hBvd/RSvWNbiLL7PfcG8qVj1j2pM+vKPpnH6zWwKzaUQu2zfJXamsBr4xIfN6YaXsIqvI9zIXsMHK+2dIKg9/ZrONAxthAweUejKRB8lJReYUpwDOI8pgCJiyPNfMfERr90MdYk=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 BY5PR11MB4420.namprd11.prod.outlook.com (2603:10b6:a03:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 11:34:36 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 11:34:35 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 2/6] ASoC: dt-bindings: Document Microchip's PDMC
Thread-Topic: [PATCH v2 2/6] ASoC: dt-bindings: Document Microchip's PDMC
Thread-Index: AQHYMgsIeRF6oOqfs0WNMbNC9KoCXKyzxggAgAAEhoA=
Date:   Mon, 7 Mar 2022 11:34:35 +0000
Message-ID: <38975dd7-2f54-8920-af28-0a002f0faf5e@microchip.com>
References: <20220307100428.2227511-1-codrin.ciubotariu@microchip.com>
 <20220307100428.2227511-3-codrin.ciubotariu@microchip.com>
 <73c49f2b-ef2e-5ed8-f3d5-aa696f9af9e6@canonical.com>
In-Reply-To: <73c49f2b-ef2e-5ed8-f3d5-aa696f9af9e6@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f939842f-0cb2-4d54-3463-08da002e752a
x-ms-traffictypediagnostic: BY5PR11MB4420:EE_
x-microsoft-antispam-prvs: <BY5PR11MB4420B37EDA9AB90AE75C31FBE7089@BY5PR11MB4420.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OD1bSYAwaTMXx9VL1spg6F3yIOYcQrqo4W/wVfzcycD6+EzDpyyaRC1SLEkk4Req1EvOS6BaBpMfa3wsy69KmtLDKgZfpXa2IFLNcq4melkQeURsAwqjoR/3bmS61e59nVxsCezu+6+FzXvea8uFNyhptmyu7KNfgaHbrzRszGPf3knHGsRaUJdupNEil+b/swiSVAdMtkdIra4lRazJY99NcsQPUxdl89DURZnaulvkQsrEvhwKssDEXtYNUII3837Eo99V+4XGFubV9CI4TIOehMqevEyct2kwGdWl/VDgiq2L4ACiZ981HdQWHHbNcs0GaaS9EykUvlIri7GfIl2zCOn757i2GSrApSJBHfpIFMSViQXQ3KwiLeHRYOUs/igKADRDVguQ0jx4+YNFewD+MWyrJjOpMKKHRFBaF1pNzA6y/6tNZaQXxUFRN+xos2SLAKfl3LPFsRE5YQ2kL3dLpoH6UGqIWAKXq64h7FJClXKyvhyAYVrhKWnFXxX3xK5zD1T3Qjup/ZK0gMDPU88DZvYMSmEaA5Fq69RVUx90MBOk+lnGN52TbmiyPg0JPd8McoVPOIwnv0td4KwaJnxZUVvN1zW2uW948ybo15XRWsnXzdvjbO3jCHVttqeFJXssWpxi4woLcY/uvDvVSSQZhgZi3USkPCvxKA+2q7kJGhpULptPATcTD1C0cDCGdPrKg+4+edzRQmCt82gLx0Ece0GdCjGkpK0sm6Vrt7bXF9TtmVVZ8/bPdtILIK5ArVbTdkXJKqlJt1gNRSb0xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(316002)(86362001)(4326008)(66476007)(66556008)(8676002)(64756008)(38100700002)(31686004)(31696002)(2616005)(26005)(186003)(107886003)(53546011)(36756003)(54906003)(110136005)(71200400001)(6506007)(6512007)(5660300002)(76116006)(91956017)(122000001)(38070700005)(6486002)(66946007)(8936002)(83380400001)(7416002)(2906002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFhEeEM2T2VRc2U3UkxCdGNCWllwYnVpcS9RK3NpakxUck1UUWJyeFR0Sldn?=
 =?utf-8?B?ZWsyNFQwWUZ1VmUvbElpTDhZNjVsWnlwMGdyOTdod0JKakFFRldFbzN5MzlJ?=
 =?utf-8?B?c0UrTG9KN21WRjNxQnl3Si8vL1cwcXNwcjIyc0ZOdDJEZHU4U29taEp0TDNt?=
 =?utf-8?B?T3dMSDNhQ0R5eUh5ZEZrcFBaMElLSGViL1d1d2p6ck94UFQ0L0ZRSWRudGdB?=
 =?utf-8?B?cHcxdlRBdnBmM0h1YllGalhuejJlMlF4YWVWQVR3Z25Wb3Q2TU9xdmpSblhq?=
 =?utf-8?B?ZnB0bWF5aXV0L3p4QlppK0NGRHJOMUxBZnA1UjFKbnRrUTFLV21wOG9mTUVL?=
 =?utf-8?B?Rm54N1RFNkEzMkZhNkRqd0Fma3JuMm10Tzh5UEh4M1E2QTlqZjFyWW5maDZF?=
 =?utf-8?B?bmVwNHN0QjMxdi8zM0RXbkxSOTBISlI1SkMwclNMSHM5Vng0UDJrZXp6aVdR?=
 =?utf-8?B?eTlwbEoyNXp6OE16Q05lQzNTOWxpTXR5V3FpdlFtQjIvdE4xR0JaQno3c0l4?=
 =?utf-8?B?aWJFNHVNbWVJaTZjNDgwbGhTMXhjMVF1Y2QwQTZTdXhaKzV5dHBZRndzWjBq?=
 =?utf-8?B?YzdzMUdmWkh2M2NYcWlhcUp5ZmYwdW1SZ2w0Lzd1S0Z3a0RBN1JDK0dLeWdE?=
 =?utf-8?B?UHhwMVNBcjR4Y1B4TVNWTU1ZY3dTNm1heXAxUkNuRUxzazVRWHFZb1lWKzVi?=
 =?utf-8?B?cnRGcUxBQnkrbnpENUJoamc5bG1xVWtvalhXTFVoQmU3U0FFVk41V0hJb09v?=
 =?utf-8?B?RjczK21GTXJmdG9CZmZCQ2hQUnhmWm1OTzdXWXFodUo0U0taWnVHa0RpTDF3?=
 =?utf-8?B?bUJlMzU3b2FWUjFJVlNmTlgzZU1aWDFHZlFkRjlaQytQV0hlaUNFc1JlT084?=
 =?utf-8?B?N0dYSWZFYzdiS3ZtMDhtVUU2d0Z5L1BQcGcxWVpNZDdYQ0ZGZG5kNzNPMlN0?=
 =?utf-8?B?YldYd2cra1JKQWozVk9rTHczYlpvbys5UnI4S3pIVzRtWVNlOC9ZKzlHZFZR?=
 =?utf-8?B?SHVNR0lpOEdaQWRIVFNDOTVPejRaWXhqQ2RkcTB1bHJhVXovcVdCRGZjc25a?=
 =?utf-8?B?MnNEcE9Ra3RmVStwZWVvQ0xzdEg2LzBhdjIzTVdxd0NIZDd6Z0MrL1BSVXdR?=
 =?utf-8?B?czNxZndOaFhCSG83bTU5V2dDN2FEeW84OWU4N0svbXJmZnJDV1FTRTM5Tkkw?=
 =?utf-8?B?V1FKOW55Qy8wbnpGbUxGaVlSY2RQZFRwcHpOL2UxY0tlTGJaSUhZRElDU1RV?=
 =?utf-8?B?bnRMckVzNTUyT0hmcUluZ0g1N1BRa2Q4YTgzSTdhZW0yOWZLSUNEV0hBaysv?=
 =?utf-8?B?dDNtTTF0Q3F0QUI5MWhwbTNDK3ZnTWdMK0ZuQXRNNHJNbU5GV0pVT3ZoejFV?=
 =?utf-8?B?OVRZMU1PRENUT05pWEV5WVhtWUtaMHc3UGh6UmNyQ0xmQXhyQTc2bGM2KzJF?=
 =?utf-8?B?RVFGbDZNM1pTaU9qQjFkVWlFOXhoeXJNTWsvUTdNK21valJNVEJnTHd5K0Rl?=
 =?utf-8?B?bHEyS0lNTGxWa01ZMGtjd3lGYVBzMkZqWkJDc2Z2clBGajBLV0RKU3ExcEVq?=
 =?utf-8?B?aDB6RzVjUWVTb3pyYmwveGRycDlOM3p6Zjc1YmZXRVJxekdlTmEzWEVma1R5?=
 =?utf-8?B?YS8wVjZFWG9GaTBkR29VcjRWenJRVXFHRHVFMDJNUkVsOW9RZXgzMkwvSWFa?=
 =?utf-8?B?ZE5yaDVoU09CMkc3QkFyNkJGRzQzY2tEK240K2pGaUM1TDUvUWtsMnF3R2pi?=
 =?utf-8?B?bU5IWkhjcFdHb0hBeWdnVGpZT0pKMExtRWJzZDg3cHEvQytkUTZDRzVMMlha?=
 =?utf-8?B?R0Z4Vlc2MlR1ako1eUlMQ0lkdFdzSzNrdTcybFA4Q1lLNzRORWIrOG8yOFpO?=
 =?utf-8?B?QkNxZUpkaU9HWE5yN29VRXE3VjJickNpaENtVnVGUEtQR0F2MHJEUFNiL000?=
 =?utf-8?B?LzFaQjVXdUNTcy9URXVhRDd5d2hrOGRBa1lrQ0xaVXp4cmNmNGlzczM2WG5B?=
 =?utf-8?B?Qjk0ZHloT2RuMWhDbmwwU1hLN05IR2IzbUdXTExrTVFqNjAwT2JUVUxLOGNv?=
 =?utf-8?B?d2p0NTdOQWp1Z0Rnc2xKK3pSRjNOZEZIdCtRYzdEVUhqamhHTGcwZjJKZnl1?=
 =?utf-8?B?UnNMOWVvT3ZDc3l6dldlV3lYUzFmcE1uNDRtT09FK0h6RStUUzNnLzhjeEt2?=
 =?utf-8?B?S3IzR1R6RFZieDhCL1BrUy9RUmk2dm5jS3Q5UmRLM2NkYUYwTUZQRkhJQm9R?=
 =?utf-8?B?NEtPNFkrOU1xRFFuVUNyNXlCRHFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD73BCDF98BEA74CA638DBD8F16EA550@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f939842f-0cb2-4d54-3463-08da002e752a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 11:34:35.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSbme614zhiLgueOIW3P2DjuTCjzX6Ws9HiWxPTJHQVDWe+oD1Kof3DDW49WUWETOgZhweedBgOWZ4/ziO/lsSZxzuMhjq+bEtuj3Z9+T2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4420
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDMuMjAyMiAxMzoxOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDcv
MDMvMjAyMiAxMTowNCwgQ29kcmluIENpdWJvdGFyaXUgd3JvdGU6DQo+PiArZGVzY3JpcHRpb246
DQo+PiArICBUaGUgTWljcm9jaGlwIFB1bHNlIERlbnNpdHkgTWljcm9waG9uZSBDb250cm9sbGVy
IChQRE1DKSBpbnRlcmZhY2VzIHVwIHRvIDQgZGlnaXRhbCBtaWNyb3Bob25lcw0KPj4gKyAgaGF2
aW5nIFB1bHNlIERlbnNpdHkgTW9kdWxhdGVkIChQRE0pIG91dHB1dHMuDQo+IA0KPiBUaGlzIGV4
Y2VlZHMgODAgY2hhcmFjdGVycy4NCg0KSSB0aG91Z2h0IGl0IHdhcyByYWlzZWQgdG8gMTAwLiBj
aGVja3BhdGNoIGRvZXNuJ3QgcmVwb3J0IGFueXRoaW5nIGFsc28uDQoNCj4+ICsgIG1pY3JvY2hp
cCxtaWMtcG9zOg0KPj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPj4gKyAgICAgIFBvc2l0aW9uIG9m
IFBETSBtaWNyb3Bob25lcyBvbiB0aGUgRFMgbGluZSBhbmQgdGhlIHNhbXBsaW5nIGVkZ2UgKHJp
c2luZyBvciBmYWxsaW5nKSBvZiB0aGUNCj4+ICsgICAgICBDTEsgbGluZS4gQSBtaWNyb3Bob25l
IGlzIHJlcHJlc2VudGVkIGFzIGEgcGFpciBvZiBEUyBsaW5lIGFuZCB0aGUgc2FtcGxpbmcgZWRn
ZS4gVGhlIGZpcnN0DQo+PiArICAgICAgbWljcm9waG9uZSBpcyBtYXBwZWQgdG8gY2hhbm5lbCAw
LCB0aGUgc2Vjb25kIHRvIGNoYW5uZWwgMSwgZXRjLg0KPiANCj4gVGhpcyBpcyBhbHNvIHRvbyBs
b25nLCB3cmFwIGF0IDgwLg0KDQpvay4uLg0KDQo+PiArICAgIHBkbWM6IHNvdW5kQGUxNjA4MDAw
IHsNCj4+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbWE3ZzUtcGRtYyI7DQo+
PiArICAgICAgICAjc291bmQtZGFpLWNlbGxzID0gPDA+Ow0KPj4gKyAgICAgICAgcmVnID0gPDB4
ZTE2MDgwMDAgMHg0MDAwPjsNCj4gDQo+IEluIERUUyBzb3VyY2VzOiBjb21wYXRpYmxlIHRoZW4g
cmVnLiBJIG1lbnRpb25lZCBpdCBpbiBwcmV2aW91cyB2ZXJzaW9uLg0KDQpyaWdodCwgZm9yZ290
IGFib3V0IHJlZywgc29ycnkuDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KV2ls
bCBzZW5kIHYzLCB0aGFua3MgYWdhaW4gZm9yIHlvdXIgcmV2aWV3Lg0KDQpCZXN0IHJlZ2FyZHMs
DQpDb2RyaW4NCg0K
