Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C34CD7C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbiCDPaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCDPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:30:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22DF1C4B37;
        Fri,  4 Mar 2022 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646407789; x=1677943789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TkgyCAoofxKAjY92xZeEt+x+GWu2vxrJgsaOK4Rkjnk=;
  b=IB39+2MO+BTrItx/Axztvv+aOPqtoxTdNODKzm0dEK+6b4IGpsedHjQB
   umYzkOE9Fpabawb4ZQEEFvHCpX/sCqm3888gem1h+GHaUsho4Atv5Aa60
   fYrWH5OlodUSYcWiAd6OJOsWbkWjbuK7wrFqouXRX5uWOXbvpmtWAOiIt
   qa0uPxlSZN4sgsSJRHrJwnwSAosRQvpu3FSk62tUk1kw/t1MfxFLYlmM1
   PzN3d2dWebNJRBytwnUd2/AAjh8+FLjR7OWQqvEtO5s3BoNDy8S7QmuQD
   wXZ3U8oEwSPO4k3Iu2M2LUF1cwtdqkc4jbfi8ggpLWWegnoMK8NeCz7YF
   A==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="155280836"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 08:29:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 08:29:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 08:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA8IKIowdIl2xdhtBppUTQZ4w0GFy7ftbYxYnAr+P1rI+bS678pF5RRO+MIcPqZUXTyqMtDNmaqd+l1eYmEwi6/B4xtuE39OErVY1poHpIJS6hm/mj/kDlcB3nUpXI3Qh1mkMhibC5SEMj5xZy2NfnvYvd72qMuTptrrNSjZzFwhQzkuRNVo31W/bv9z/caXlcjNCGof/2L3I8fkKP16ZHib0bKhSaPSlxGLppjjxVZ69/MbPhOLh1mvQLcvPXB0mKwuoDQpsxrCdihaKjl6OBk01vtLdqgyEMMp3UT9Fcc1/IxLn/uEb8QWa2chnvxtQfD+jcM+cWRe1ePBhmJpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkgyCAoofxKAjY92xZeEt+x+GWu2vxrJgsaOK4Rkjnk=;
 b=ihxCofKQT0k8Jgn885DBClXP0GFS9j1dXDS6ILat60V+S3cHDaMzG1DQeEs67lrvcFjemO1cWb0AkZHkN3LlC+cSIbOuGhbzI1kdOWJD1NF2qNsYHy8FXA9g9ykff3wcZ4mghSgtabLjJuGHTA173xnQJPsYZrVuodw2atNCljusNsI+V2rG+P6I81dw/7hgjkwDzUPH2DlgRXprtMhOXOpBj8WBYMM+rm23VgLDHcJO8nsp5b19iBcGWb7+QF6qHSaAf2g2CwJwUC6Nq+iOi5nhtbXKw0M+gWbQOQpvJToxJvafgGR+o5mnW7dCv24UKkOQ3NSVk6GTjWxTOqQb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkgyCAoofxKAjY92xZeEt+x+GWu2vxrJgsaOK4Rkjnk=;
 b=pXZ9gXysToH5FCpQWkMxFs2NEssViD74jbOn4ABc7/ECfrK1xwAiORlUyD4xw9R2CwHHfumb4+RohCi6Dozz9ZhRw/D1Z10K2r3GmVqfVrQTTEPSYXuf7K6KUxOZiY5zl25XHMh0mcFDS2yPuDYD03WuXyXpg1sX+mdlRfjlgWw=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BN0PR11MB5728.namprd11.prod.outlook.com (2603:10b6:408:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 15:29:46 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6%4]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 15:29:45 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] ARM: dts: at91: Add the required
 `atmel,rtt-rtc-time-reg` property
Thread-Topic: [PATCH v3 1/5] ARM: dts: at91: Add the required
 `atmel,rtt-rtc-time-reg` property
Thread-Index: AQHYL9Q3Bk/B0Cdai02r8dJ3w/wID6yvT6YAgAAKC4A=
Date:   Fri, 4 Mar 2022 15:29:45 +0000
Message-ID: <8f5d56ba-1a51-f9ab-43a2-86d7c938fbe2@microchip.com>
References: <20220304142746.121947-1-sergiu.moga@microchip.com>
 <20220304142746.121947-2-sergiu.moga@microchip.com>
 <YiIn/NJyqeYlhV/z@piout.net>
In-Reply-To: <YiIn/NJyqeYlhV/z@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a61db12-3d78-422e-31b3-08d9fdf3cfed
x-ms-traffictypediagnostic: BN0PR11MB5728:EE_
x-microsoft-antispam-prvs: <BN0PR11MB572829F5A5162A728E1445F5E8059@BN0PR11MB5728.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3xV9N4K2r3a8btKHq409bhikjiKbADUU9Mfrp+Ojcys+/e1zVxRzgF2rd7VGZbDXrTwnv3G/QUAw1BgzNGQ5C3DjEg3y9X6MQp4IXixAVo0199g/DstIrh9WJo5EOD4zZss3diecS5fDt/2+hl1Zs3UHBLWEHJoo0CW9a5nSb5pFv55hrCMXwd1LePqLMv3TACKw0jeP3pjxNwN5eDvIDzY9tZgX8hmgvGsC5l4Twz1IwtOUclqab9r8TesbeuKCfKnuHNuAGxqffz/eX1GD1ZstqtcfNFoMTjCTelKN2agN/aHwkZoR7dK9bqYa1SC4D0pAHGmNCCK/3uJveLwu7HIHCqYWxWob79x9pXoJMIFsZTT6N7NKhbi6ulK1ptcZgPWrFPWEAonAQhu8LZikPEr2AY5gluQ1Ferts5uiIYAFssyK6KOrY0TuV4K95XsV3cg4u7bPRX2yjQvcuVpSS0A46hPe+LvXdveYycEdueKk1oQgx3k/TZAHWQ1hRB0GqnNDoylJKwwEGRLwyl8Md0j3G9J3FBI5Z+PR05CjV/yVnlt0Tkia+fLYEAntk3t5a6pwB7cFQ1yfGYpYOpf+LUNwWNEJfiaOCUv5CX0CUS1UbjZWpxF8bgfvMCel0WSBwXCXX40St7R+YCqSvdhhAYI7g9STuu/4cgMkY9LyHHT3HcsbQ0Hv/QsUSaRNUulkdF+xlc16N1nwK46p4+sc7N6uQgo/mkjthApVBM+NppafELX/CZJMj36+u60wYR+rRnMMRScxooMKDE5Jo2EHV+gKBhq7fPda9clED0bkaox/k7miysHEf4pxeqTO+3MCJmiD746TrQPlj+hCWSABa5/zKUWhj50Y0bmZ0euu0Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(26005)(6506007)(53546011)(38070700005)(6512007)(2906002)(186003)(2616005)(86362001)(76116006)(38100700002)(83380400001)(122000001)(54906003)(6916009)(71200400001)(5660300002)(31686004)(91956017)(4326008)(8936002)(64756008)(966005)(508600001)(66446008)(66946007)(6486002)(66476007)(316002)(66556008)(36756003)(8676002)(81973001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elh4QTFnVkFld21qS2pWZlJJVWVSWXVUdzFCMVJ1TkhDZm44NVUwT2wvakFu?=
 =?utf-8?B?NGVLaldPTlVIL1FzQWNtS1IxOE1sVkpPSTFOZ3NHQlZTYnFjK1dhNEpOeWJD?=
 =?utf-8?B?dmZQajBVOFhyTjBKRGZXWmtNejQyWUZaQVdLRnVFbzlFVWhUc2IrTUZ2ZmNK?=
 =?utf-8?B?aU83T00yR1cvMWFkb215eEtJMW5GczBTYTBvMlQxV1p5L2dwZlpya2FqVEpQ?=
 =?utf-8?B?eHlVNlVuZW5rb0hzRFE0SHVQWDcrSFl0cWxaN1RUUHZ0YTFhZWJGUkZaWWtB?=
 =?utf-8?B?VVBsU1hHaFJ2SThWcEY0TnVVT1RaQVhGcmtac0ZxY242KzgxNmFXQmswSzY4?=
 =?utf-8?B?Ujlmcm53Wk1IUDRCcEl1eThLcnMvM0FpelN0QWhzTzVpVFFQY0trdHhxRGNB?=
 =?utf-8?B?Q09NYW1yZDgvUVNKZDRPUmNIQWd1RXNrNUt0Q0JMSCtPUjNUVWtkMjM0MFFi?=
 =?utf-8?B?bUpLKytDQmhjbnJGL3RLVnd0SVJZcUhxcHZZVk1zcGhyaU9TY1dFT3B3cU5D?=
 =?utf-8?B?bVpIekp6N2FjNjBKQUYrUDZyRmlTOVM4NUJob2EreWhmS2dWWExBQTNxWDdJ?=
 =?utf-8?B?YytrOG5HVkVWTHpRV2xLVmlIb3d1ZEF3RkZUUjdKaTdKdnAwNzR6YkYvSjVj?=
 =?utf-8?B?NW1xKzZlejlzemEyU21TL28yQTZDZUZTVHpRWk44YUx5ZFBveCtVQitkUkNS?=
 =?utf-8?B?U3BLdmdxbTM3b2V2SGh1YmR4Z1AwZHpjc3F2Q2ZpOWFCNFRJTkdZcHZQNHRT?=
 =?utf-8?B?YzlvVVF0M3VqSDNCbWxzQ3RaUVNYS3ZLN0RtcjIvcXh3c2w0ZFFXTGEyc2lw?=
 =?utf-8?B?cW1IQmE1UVFtRHhOU1I3RnU5TXQwc1pEMTVFWmRtaGJTc0Z5TGlLYmVIbGRz?=
 =?utf-8?B?cG1ZT0hxcEltMDE4WTNMVHNtRXVjZHdlei9BVWQxM1NrR29xdEwvbTludG43?=
 =?utf-8?B?N3ZaMyt4c3FmS3huVmpKYlNjZmp5T2huZXJjN210NDBld3pDTSsrSFJCTnpy?=
 =?utf-8?B?R2VCSlBrcVhndEdmb1RjUCt6eldOTXlISHp5OXExUk5OQVZrZjVqQ2ZFOW4r?=
 =?utf-8?B?THJRUFY3ODVVVDNzK2M0NVVOTmwyWVZ1cXNaM3BvRUE1eCtKRGdXcFBpN1JL?=
 =?utf-8?B?NGpreVU3VS9ZeFJVdWVYYjljOU8wcmdFN2ZYUnFoby9kMDNmK1hNUEtUa2wy?=
 =?utf-8?B?OFJhODBnRGNrbk1qeGFWMFZRcXlpRFFQY3IzaUtjVGZ0R2YzTTR0VnRsUzdl?=
 =?utf-8?B?MzFMU3ZmOWYrMnltSVJvbTZrcWZzdW5PcStxNTIyWVN4cGx3REl4TzFDalg3?=
 =?utf-8?B?UlVySWFrTkFIY2MwcHRZN3JaSFpJeXJKTm9ENEIwQ0VZTHdTa2pmQ0lLS3o1?=
 =?utf-8?B?NFQrcDhyaGt5Zmd0NjNoZVkyMmU2cnMzY2N6dUNwZEFwTCtmNURvT1Nta1BC?=
 =?utf-8?B?RmtVS3hMS1h0aFRxeERaU1ZhMGNHRXRSbTg5WWozSlgyczlmRFlXZ1EyNGFx?=
 =?utf-8?B?SkN1d3dRQjMrUGVLZitzTGQzMEtKNXgvMWZEcmlabmhqZWcwekJkZ1BaUlR3?=
 =?utf-8?B?aFRKS1VEeUtWNm9MaktrRUttM0RsZGdiNjdzZFAzQlJEVkdEaUlVMDBhalQ3?=
 =?utf-8?B?bi9FNnAzRmd3Y2NmVVBrTzhaVlhyVTNpU2o5NWhHTUhDbEFucjdoMFVzbzdJ?=
 =?utf-8?B?UlBpWjBFanZPNyt2YWpMYmN1VFBOTlhxYzM2MlpDSWhXcFc0MVhhRVc2em5U?=
 =?utf-8?B?VHVXTUFmWis2d3lET3NhdEE0bm9DQmEvWDY3bWdmc2JsbGI1WFRyYVZFUjVR?=
 =?utf-8?B?a2haZWRpN2JsVFdSVDErNG5FQlRnQzIvZHF2dVdwUVVEUTRxRW5YTjJ6dnE3?=
 =?utf-8?B?dlNzR1JPQ0k4NnAwcUZCUUtjeG1SUVNRYU55QWZSbTh3ZFlLK0hPK0xBb3Zt?=
 =?utf-8?B?WWh5OG1Sa2VndVFlMzc4QmorV3RpSjNBTW5NdWRXUGkvMnZaVzM0cWd0bERE?=
 =?utf-8?B?bzlzQTdOL2F5VlRzeXFWRmhvanZ1K2NBQkxLVmdaQlJNVkJHQWFIRlpPUHda?=
 =?utf-8?B?Snc3bm1ncHNmTzRCZnh4Qm5HTE9LcGtNb3F1MHVnNXoxdHpKNW80UHdsekdQ?=
 =?utf-8?B?WkxORU5uaU4xbXlCSkxBdWdwWklzUTRHdzNFNG5hWXRZeno3VkdRc3gzY2k0?=
 =?utf-8?B?aU9GcTFTdFVBNDlCemJGUFJoVVd0cmNZVDFxRkFWR0xlVzEvQ2ZpWmtXTmdt?=
 =?utf-8?B?ci8vRS8yeDlmemJ4QU5qUVBlUThnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A7BCCF83C6E4D418AD33D667595BDD0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a61db12-3d78-422e-31b3-08d9fdf3cfed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 15:29:45.5694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRqpi24RwySxwbpsrfMBbCx1u5RrF0Glg++bD//K3MnsS/oBlAvRmd8nVKMeZeJ2uPY3p2X1elyz+9fb+cnb5pSmnAvXP5vw+n/kmY1J3i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5728
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDMuMjAyMiAxNjo1MywgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IE9uIDA0LzAz
LzIwMjIgMTY6Mjc6NDIrMDIwMCwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBBZGQgdGhlIHJlcXVp
cmVkIGBhdG1lbCxydHQtcnRjLXRpbWUtcmVnYCBwcm9wZXJ0eSB0byB0aGUgYHJ0dGAgbm9kZXMN
Cj4+IG9mIHRoZSBib2FyZCBmaWxlcyB0aGF0IHdlcmUgbWlzc2luZyBpdC4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9jaGlwLmNvbT4NCj4+IC0t
LQ0KPj4gICBhcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2MWVrLmR0cyB8IDQgKysrKw0KPj4g
ICBhcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2M2VrLmR0cyB8IDggKysrKysrKysNCj4+ICAg
YXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTlybGVrLmR0cyAgfCA0ICsrKysNCj4+ICAgMyBmaWxl
cyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2F0OTFzYW05MjYxZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTky
NjFlay5kdHMNCj4+IGluZGV4IGJlZWQ4MTk2MDllOC4uM2MxZjQwYjRhMTNlIDEwMDY0NA0KPj4g
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTkyNjFlay5kdHMNCj4+ICsrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYxZWsuZHRzDQo+PiBAQCAtMTc4LDYgKzE3OCwxMCBAQCBk
Ymd1OiBzZXJpYWxAZmZmZmYyMDAgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0YXR1cyA9ICJva2F5IjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4+DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgcnRjQGZmZmZmZDIwIHsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGF0bWVsLHJ0dC1ydGMtdGltZS1yZWcgPSA8JmdwYnIgMHgwPjsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICB9Ow0KPj4gKw0KPj4gICAgICAgICAgICAgICAgICAgICAgICB3
YXRjaGRvZ0BmZmZmZmQ0MCB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Rh
dHVzID0gIm9rYXkiOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYzZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9k
dHMvYXQ5MXNhbTkyNjNlay5kdHMNCj4+IGluZGV4IDcxZjYwNTc2NzYxYS4uMTIwOGJiNTgwZDE0
IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTkyNjNlay5kdHMNCj4+
ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYzZWsuZHRzDQo+PiBAQCAtMTAyLDYg
KzEwMiwxNCBAQCBtdGRfZGF0YWZsYXNoQDAgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH07DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+Pg0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgIHJ0Y0BmZmZmZmQyMCB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBhdG1lbCxydHQtcnRjLXRpbWUtcmVnID0gPCZncGJyIDB4MD47DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgfTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBydGNAZmZmZmZk
NTAgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXRtZWwscnR0LXJ0Yy10aW1l
LXJlZyA9IDwmZ3BiciAweDQ+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgIH07DQo+IERvIHdl
IHJlYWxseSBuZWVkIHR3byBSVENzIHdpdGggdGhlIGV4YWN0IHNhbWUgZmVhdHVyZXMgb24gdGhh
dCBib2FyZD8NCj4gSXMgdGhlcmUgYSBjaGVjayBmYWlsdXJlIGhlbiB0aGUgcHJvcGVydHkgaXMg
bm90IHRoZXJlIGFuZCB0aGUgbm9kZSBpcw0KPiBkaXNhYmxlZD8NCj4NCkkgY2FuIHVuZGVyc3Rh
bmQgeW91ciBwb2ludCBoZXJlLiBObywgaXQgaXMgaW5kZWVkIG5vdCByZWFsbHkgbmVlZGVkIA0K
c2luY2UsIGZyb20gd2hhdCBJIGNhbiBzZWUsIHRoZXkgYXJlIGJvdGggZGlzYWJsZWQgaW4gdGhl
IFNvQyBmaWxlLiBUaGUgDQpyZWFzb24gd2h5IEkgYWRkZWQgYm90aCB3YXMgdGhhdCBJIHRob3Vn
aHQgaXQgd291bGQgaGF2ZSBiZWVuIG1vcmUgDQpjb25zaXN0ZW50LiBEbyB5b3UgdGhpbmsgSSBz
aG91bGQgcmVtb3ZlIGJvdGggaW4gdGhpcyBmaWxlIGFuZCBrZWVwIHRoZSANCmNoYW5nZXMgaW4g
dGhlIG90aGVyIDIgZmlsZXMgb25seT8NCg0KPiAtLQ0KPiBBbGV4YW5kcmUgQmVsbG9uaSwgY28t
b3duZXIgYW5kIENPTywgQm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2lu
ZWVyaW5nDQo+IGh0dHBzOi8vYm9vdGxpbi5jb20NCg0KVGhhbmsgeW91IGZvciB0aGUgZmVlZGJh
Y2suDQoNClNlcmdpdQ0KDQo=
