Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885AA571304
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiGLHWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGLHWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:22:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B5D8AB21;
        Tue, 12 Jul 2022 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657610542; x=1689146542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mi/tY38nBCPaOqccl66N9QuNZdJIy7PPiKjroOIme3o=;
  b=Mt/YBpgIF2M7QX3clhvkCqJY6enKH/vZujy/nhLZm+y+zur67WFaavDz
   zJVZvL2CdTf47jHqUvDVEQe/NoiOTwwIrhY+/cFLC7H7GCDVI87YB4Xgg
   rUtlkt9mosHyo2JXe84uowj226tfckFTNSD4pyl9TSaT/NgqmyC9c3Jrr
   7+nPOIWHF7PtD7eqJFt1airmNpKky7bXvUfsR17Y2wsWY4T4YHYil/Ipl
   NW9V68Rv+nyNPfiFROJmtuHXx533n//pmj4qCA+yd7RMKzVAjThQJXh9A
   PbDdcoLb+fOUp9ljrxADXNB4+Bzk/WKkogmQlKxy1UAJfDhuvdZcyYVxt
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="171711756"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 00:22:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 00:22:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 12 Jul 2022 00:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJAQ3nqT/JCcM0FoaTLOc3cTdOO4E7O9oxzDgdpIVSCtOpRThVcFUJ/qoy2dP+/D7hJE+vlSluC3ZpeORbqhdnDuJJcOMFCBzFa+emNDtDxgTqyPkkWpAml/VzZkeyzVEYBGxhJAstW9KaYgtv4fisa1h5/2DkNx2xkHd8gmU6lGG4Nx19N9/Bcz2khew0eoREsjji9CZ2h3HIBGTS27Xf16UVo8Jki4v7TYeS1BjEsJXa7vQ1/NqSVDMppShLzJsWfwdJt+LiGKAaHFPAw9oJ10F5kA3r6mYF6R/f5tYDA3rKLIKNTJcplUVgdfsPXog39U0ElYO+ZpiSQLXgS/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi/tY38nBCPaOqccl66N9QuNZdJIy7PPiKjroOIme3o=;
 b=ZBBYQIiGDJFo1nMV5k2Z02w8sPUmYp8G6Uz2fCKLuWljmWsKsQFDSwampTdpkrUzp/PdCGuNrqaLpta/sQRzpiach8l1l3VSYKeNiNuGRrYgW+pYGwTpLGMO8M1yIfDYncdypD+DRfoARLBDacyt+VTYrQmrojY9sIMf+yPuRPW0OeCgWwLaygm1VVcNvLmhiVgkfWkB2iDs8ZslDnx33Lppn0jBn3LWEg4q49nFBESDJ5KM2baEXYZVoF44pet2M5EcmuLBM1ZXM+74GCdmfduH3xtKCJY1Z2MSIogMsPZ/Zs78WIUZ5px9LtEVotOmuHz1Tl2gIii2LJq2l2ERhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi/tY38nBCPaOqccl66N9QuNZdJIy7PPiKjroOIme3o=;
 b=BWl1iGM5TQ5ast/kCknJbwwou86UfNTRszP0vtnCFbh6EWQySzz/q10MkE3sHaPeIQ+28zVfurtw5v4mV+VBN9MGrctTGC/Eqqe/v/M0vrK2V3uB4tTgHaUq9ll+c1wDv2NqaS3TlVOxO/liQ36uA2C4lGEKlGinbZ2S+wD0Cyk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 07:22:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 07:22:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: lan966x: add clock gating register
Thread-Topic: [PATCH v2 1/2] ARM: dts: lan966x: add clock gating register
Thread-Index: AQHYlPX1nrnmxLeOAUSFrDL+ar5dna16VksA
Date:   Tue, 12 Jul 2022 07:22:15 +0000
Message-ID: <07af76d1-3aa8-3067-f92d-120ad385b698@microchip.com>
References: <20220707132500.1708020-1-michael@walle.cc>
 <7ee463db-3cb5-c340-ac1d-1dfcd2b87dcd@microchip.com>
In-Reply-To: <7ee463db-3cb5-c340-ac1d-1dfcd2b87dcd@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce19ef2e-136c-428e-2163-08da63d73f07
x-ms-traffictypediagnostic: CO1PR11MB5140:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hivP6pGd65kqML4DwheqQMwqX3JGlqUKDhigIJWZkVJPvETqcsCkk1QuPG5O2R2rf7tbqoLL3d4d2xH7Cu3aavW8DCm5yOCeZ54AgPgt9PSsB51HJJCUS1H2if5qANseQtJx8G+Dwl9Ndp0gJjcT5TskhyM5TQDWrs7kowzI0cAGBXkjwKffgwJmUS3ThhxOM/+0eqmrCP3OM2zFko6xnyeORIJENihSdtqvi/OoqrknvzS0a3dTRkiyy4Yr3MvhhRsQ2vRR21lyVSLxzkUGKQREUWgdL5Qem+BW2cK+acV8NE8FfZhXauzdE3zl7jZKkyEXMFZkCdr3QZ94rzWanrHodDceX3ulPxBJQBmDV9BQcg6xQ2EG/Y6HYxyv+IyNFPyxQi6e3dqVEos/yUKy/i/feandJ2AY50Vfthst7wxt3SIbPbk438viF06/xVg3H/b2SojExVYHKLy+ZO3R+g3FyUzQ0eaNnZ5bcJIi7PrE8HVfE8LzNaWdK7tZtB83H0Ql0CliV4JYwZPaH2E30UNvm4MeLnroPuhf8ghlABpO0ak3It4bBJMwmLUZSSSHE6DbJGKXbG0At4oBYf6VmW+xerzwlj7hu22OtnzNQSQnQxfBUZVGgr2hLK+Rqr0ERxKOBjX8nI4Ou0j61pQ6rejLvINfNiVpT92nS2T/FpkwJEyDxIZEacNhxLElQAyf59QYRTWERzTWUGiaZnyEHn6c9DZTIz1SZyr21AWy2udp5QAQByW2iRx0shZc4GicbtyhvSjRj4HqQg7s0eJniWhLkG3I+EBko7fTZJl2exmH5z8pDlfdCgxYQ6m+YC8jxOE0NCN5EUnbGm58WS0tTM7O9gHn+xoJrOWNpYzFbMY88T8Pf6+/E/3euPWIw9CpB0HVRx7pIgc2cF5GtYptHWmEysn+Ka8E9R+bevrLJpk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(376002)(346002)(39860400002)(36756003)(478600001)(38100700002)(83380400001)(66946007)(8936002)(66446008)(31686004)(64756008)(76116006)(5660300002)(186003)(4326008)(38070700005)(2906002)(66556008)(26005)(31696002)(2616005)(8676002)(110136005)(966005)(86362001)(6486002)(53546011)(6512007)(54906003)(41300700001)(66476007)(122000001)(91956017)(6506007)(71200400001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajljL2Q2dkpGRFpYbjBjakx1aWkrdWxrMjBQNU56RHhCTHFIaG5rTDNSamdW?=
 =?utf-8?B?WVJ0KzNBS1VNV25YMCtvWm1yblRaaDc5ckh0V1dzcGVxQkRPMjRmUGp0T2tq?=
 =?utf-8?B?b1pBYnNRVEhMUzZQM1JINGRUMHo2a1VWOWNnU2o5eUlmTVJaN05kcFg0eDIz?=
 =?utf-8?B?NmJnRERoUCs5THBhY3ZMc01OYmhQWHU3OERNejdQOVhNODB1S2Z6NnRjWWI5?=
 =?utf-8?B?d25LbERucXlwUlFEM0FSTWgxQlgyU0RReGVid3AzWklZZWxKZHpjWG5namNv?=
 =?utf-8?B?dkN4SkJjaVlsTGdGUUkzc0M4bkIycUhLVEQrdURvOVlXOXd1MHJaOGVGMTFP?=
 =?utf-8?B?RjNjajRlTDAxSTVKdmlZYkR6ejVTSUJDVThDQkMwcFJldk0wZkFIeVo5ZUlK?=
 =?utf-8?B?QVpTRStzOXlkSXFmRUY4SVcvcTZLL01jY3c4TUw1WXEzd29taFhsOGtPWStO?=
 =?utf-8?B?UDUvNHN0dHcvR0ZNVzRpMEdyeUU2VVlFdEhBdlpWdEd1d0xMNk9ZRXk3MHZM?=
 =?utf-8?B?U3MvSzlVb3UyZVJzUmNXc2p5SmloQzJrVkorYm1aRVlueEM5MTAxdVpmZ1VP?=
 =?utf-8?B?YWhvN2luZVpTeW1sRFVVQk9wV1UxRjBYNG9iOFpoZFE2bTh4QkdDYkxPa3RZ?=
 =?utf-8?B?ZEdmNytaakFBWjhhbmVFQTZETDJZWjlHQnBDVlpFaUVRaEZBd2gzd0k0U3dk?=
 =?utf-8?B?UW5oU2toVzdsTFY3QUg5Vnp0RDFRMEF1dG1JeU1rOS92WU82NmJRbVdKQzhH?=
 =?utf-8?B?UGhRRXkyWUpMSWYvSzFtT2JXaWpvZE5IeFBpMHVsN3NKS3EzaEdPZVFDNVhT?=
 =?utf-8?B?N1lLQmlma1NUTlVtYlhoTnR0dmtHQWU2bUdPSzlHNC9hNnd2TWRlOUdTUE5V?=
 =?utf-8?B?OUJXL1BvNWUvSnhMNVdJTjhYdzE1YVZTcXBLVlhZd0VLb1FSYzg3TWxiN0py?=
 =?utf-8?B?VEhpM0Vvb0JUek55WnR1VW00S2dLVE9CeTgwUmRmTGNnRFhXYWlnYWNTT0Fz?=
 =?utf-8?B?SUJGTjVaNmVmcXA1MHhrdFpVVTJyVEVmdE43YTlPM0FMTHIwMjFKN3luaG9v?=
 =?utf-8?B?eUZtU0RKWW1TV0hueEZORWRoeksreXlyZDFBSnRoTjY3a0IvVExXVkx4TVBW?=
 =?utf-8?B?Z1AxbEErbUl6TDRsQXFrVXBRZXJDMGwxZHpPTHB6Wjd3RCt0ZHovSjc1Ykwx?=
 =?utf-8?B?dUh6VzlWRTc2YmNiNVhRY3JHUExvUkdsT25VWFZQMzlTOXdabmxMam9Sa2NJ?=
 =?utf-8?B?elZaTEZuTnZvb3o0TytqVVpDa0EwU1h5UStaMk11eXdsdGRMNGt6UzlUZ0lr?=
 =?utf-8?B?NmZ2RDNleVJRbTZUUjdtZE16OVowRk03ZE1hQnRFcUc3dEUwUytoYjcrcnpp?=
 =?utf-8?B?VWtIZVBYK3lDOXROaVVuUVVPSGdIYVl3L0ZXYmtydlJOcE9ockJvUGJpbHRP?=
 =?utf-8?B?dEZpSHFyVmZLM0pkS0ZaRmNrWm5GbUZ6MVFwZDVxMS92VFdSai9jbVp2U2dI?=
 =?utf-8?B?VVFpOFFIRkJITnJlUmdsdFNaNUdBeWVQNmp3Y0VKZTNTaHg0Q0Y1eHdIQmJ2?=
 =?utf-8?B?SVI3ZzdFa1VIVmpZc3ozQ1k3dVNKNVhwc0lWb2NkbkhqelZNb1VmV3VjbmZr?=
 =?utf-8?B?RGljZEhYYlBFNXYwZkd4ekROMlBiN2w3b2lnQ2FGUmN3MERCaU85c01ZVkxZ?=
 =?utf-8?B?ck5WeXowbFd4RVBjYzNTU2d5bWpWMGhjWVRoZjhFMjFYdmY3ZW1KbDd2YjJZ?=
 =?utf-8?B?ODNJdSttd21WcGpUR2ZIbzIxNC9hOWE3ZTN3K3pRbUlOczRUa2djaTZuc3hO?=
 =?utf-8?B?T3lQaCtOYjkxVWdiakR4RGhGbnh6NGcwbG9GamRpTkhtSUJETVo1UXVwbzlV?=
 =?utf-8?B?RE8yN1RPeEF3RWFYTGpnOHhTbkpOL0ZpeUVrM0JuWS82d0lYZHZJQ0p4OE9H?=
 =?utf-8?B?ek1mNUZyUzZrWEZwSURBOWFUN0h4K2phM1NUK1hiSmF4bEFtc1VXOFlJVnpB?=
 =?utf-8?B?SU9ZQ3l0S1A1L1AwU0ZjdEVac2VjcWwxUGFTSlVKK0wyWVgwckdlejkzNjMw?=
 =?utf-8?B?V0lqWit6bDI2dml0YVkzR0JpM3dyWEp1L1lvaHZ2RkltaHQwcVI1N2NBRE5D?=
 =?utf-8?B?YldzenArMHg5dVdtb01WVjgyZ1ZLaEF0TW90eUVHQjY0SjBwOVJzTVdTdUpw?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BE76B8855A2DB45843918F26B43FE1E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce19ef2e-136c-428e-2163-08da63d73f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 07:22:15.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hsVtEWOJemHTRXeM1+WT9eLafGGFVoA4H7YuFWXb9CsowBCFghqBtbhNLFyU07SHvgLgnLM+29Cr8yWFIlodjh8PbdPnbPKgYtYTQUIueE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1pY2hhZWwsDQoNCk9uIDExLjA3LjIwMjIgMTA6MTUsIENsYXVkaXUgQmV6bmVhIC0gTTE4
MDYzIHdyb3RlOg0KPiBPbiAwNy4wNy4yMDIyIDE2OjI0LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0K
Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pg0KPj4gVGhlIGNsb2NrIGNv
bnRyb2xsZXIgc3VwcG9ydHMgYW4gb3B0aW9uYWwgY2xvY2sgZ2F0aW5nIHJlZ2lzdGVyLiBUaGlz
IGlzDQo+PiBuZWNlc3NhcnkgdG8gZXhwb3NlIHRoZSBVU0IgZGV2aWNlIGNsb2NrLCBmb3IgZXhh
bXBsZS4gQWRkIGl0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hh
ZWxAd2FsbGUuY2M+DQo+IA0KPiBBcHBsaWVkIHRvIGF0OTEtZHQsIHRoYW5rcyENCg0KQWN0dWFs
bHksIEkgd2lsbCBwb3N0cG9uZSB0aGlzIHVudGlsIFsxXSBpcyBhY2NlcHRlZCBhcyBjdXJyZW50
IGRyaXZlciBtYXkNCmZhaWwgaWYgdGhpcyBwYXRjaCBpcyBhcHBsaWVkLg0KDQpUaGFuayB5b3Us
DQpDbGF1ZGl1IEJlem5lYQ0KDQpbMV0NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC11c2IvcGF0Y2gvMjAyMjA3MDQxMDI4NDUuMTY4NDM4LTItaGVydmUuY29kaW5h
QGJvb3RsaW4uY29tDQoNCj4gDQo+PiAtLS0NCj4+IGNoYW5nZXMgc2luY2UgdjE6DQo+PiAgLSBu
b25lDQo+Pg0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSB8IDIgKy0NCj4+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC5kdHNpDQo+PiBpbmRleCA1N2NiNjdhMTgwZWMuLmJjMTAyNjc3ZmY5MSAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPj4gKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+PiBAQCAtNjUsNyArNjUsNyBAQCBjbGtzOiBj
bG9jay1jb250cm9sbGVyQGUwMGMwMGE4IHsNCj4+ICAgICAgICAgICAgICAgICAjY2xvY2stY2Vs
bHMgPSA8MT47DQo+PiAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjcHVfY2xrPiwgPCZkZHJf
Y2xrPiwgPCZzeXNfY2xrPjsNCj4+ICAgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJjcHUi
LCAiZGRyIiwgInN5cyI7DQo+PiAtICAgICAgICAgICAgICAgcmVnID0gPDB4ZTAwYzAwYTggMHgz
OD47DQo+PiArICAgICAgICAgICAgICAgcmVnID0gPDB4ZTAwYzAwYTggMHgzOD4sIDwweGUwMGMw
MmNjIDB4ND47DQo+PiAgICAgICAgIH07DQo+Pg0KPj4gICAgICAgICB0aW1lciB7DQo+PiAtLQ0K
Pj4gMi4zMC4yDQo+Pg0KPiANCg0K
