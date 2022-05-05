Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD6C51C2E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380772AbiEEOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237688AbiEEOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:51:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705315AA7E;
        Thu,  5 May 2022 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651762040; x=1683298040;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MCJ7uiC5xwsC+tmnEtqtzhLDdZjHSuSpZSz3eteHGew=;
  b=GuAkEwdBDVzWmHbRXHBF7QIkw8h+1S74Ux7+ZWv8xUdwn9EkxK3Mv07O
   xjSDVfxqnX6OPrhFMNbn+kAS2jJiZKYvMThfD/u7ZGPTccRwwMrFrifbj
   XPIAi0rZdij+IQ0lQeX/xBXnsHAE1z9Y7w28KHwJDNfRmJzOp9T0pa2XB
   r+hIRVXDQCdUa2KoUMq3KSn6BvLl+58QFsSAyPAFIvJC92PpDC7kTecQX
   tDxbUvPe2P3qf+KD2U89oLOwODAUD20j4Bg4bAXbuSLLngBt1Uo4bDG80
   kZi68ds2vnvWYS2/ec5x4CdhMfDtizt0aI7iQcjOm5Teuoile/kL0zS9L
   g==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="154937663"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 07:47:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 07:47:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 07:47:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRCiqNcqRYQ9+6PGpYwk9uVECp/Nomdiad/FMOlHC7OBtINwfBrT4LDIfWJaKIyXGee63XKPuWXBdOppLsxSwYipx0c5htFIo7Uiqmh9gNUcrFcugHrFddvN7hyjjSlUiz2A5ut86G8cT4Etx9gHegPRXd10aYMhKpd6fJOOTQ9uPcVTaMcpFRnyjZ613B4jNFYyOm1bvsa2IjeH+4VSOZQ3oOTIKup+VOZPEaSlYuxAf7prN3F8URjkjM3tV8BkVXGGWVuzqnjlVCuLoprnQr8wy98++Xi1kzEMG5TmCZzgQV2+y2D68Qte1bhpXrv9NXWeV9DO1HKR8lGBLwR8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCJ7uiC5xwsC+tmnEtqtzhLDdZjHSuSpZSz3eteHGew=;
 b=g0Mneq0j6o8FvrJQ6HLGRDW8479ugMaVNYavzOYcwWCZLUXfGcOra3noniWBjfHD9ON9884YjtcBRI17X/jfcnzrhrK9I25fkm88dEl2q9fJqRXzO5sKmGypRZsHS34eMvLx2A75q8l97kXMj/lCVb7S1mQWkuTLhlkLga3i17eVJPALhpJ+Ii5aPgsvusG9QpIlnufV5htVMPd8B0FhAYJ+Xgbs3Iq/chh0dX5XPvn+08zx3z8BV8mdioMBXoyg1J3X2OXLIujNGwREb4XzcMU0MtezS9CADkisGXA0+EsOn2a0lOnR09KC+8QZuW6mzG1kR78zjImE5nLsRaRcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCJ7uiC5xwsC+tmnEtqtzhLDdZjHSuSpZSz3eteHGew=;
 b=FSSiQ59VtrXYvKxcp+0+aftHbyaRQHaPUyaO6eOinhNaIZGho+ptO33PZuItxJIsbjD0D8L8eh/Ce0qkkTrh8GioMJgDm4nYAVN4R1Qx1RBaBfpMno6nokH7HrV5zm6OFjpETupflOJ73C5+DZZmwmjpvaXlLlMUWF6FMljlAAA=
Received: from MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11)
 by BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 14:47:04 +0000
Received: from MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::3c24:30c4:ee81:9f1c]) by MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::3c24:30c4:ee81:9f1c%2]) with mapi id 15.20.5186.028; Thu, 5 May 2022
 14:47:04 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 6/6] ARM: configs: at91: sama7_defconfig: add MCHP PDMC
 and DMIC drivers
Thread-Topic: [PATCH v3 6/6] ARM: configs: at91: sama7_defconfig: add MCHP
 PDMC and DMIC drivers
Thread-Index: AQHYMh4rISj+T8AMLkuRkvsVTHdSE60QrC8AgAANi4A=
Date:   Thu, 5 May 2022 14:47:04 +0000
Message-ID: <77c2b348-b7a6-458d-21b6-68c54efc317f@microchip.com>
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
 <20220307122202.2251639-7-codrin.ciubotariu@microchip.com>
 <d84e0e48-cf35-ae1a-e384-067d361457ba@microchip.com>
In-Reply-To: <d84e0e48-cf35-ae1a-e384-067d361457ba@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79ccd753-dddf-4b9c-7700-08da2ea61ef1
x-ms-traffictypediagnostic: BY5PR11MB4165:EE_
x-microsoft-antispam-prvs: <BY5PR11MB41651CFC826BEF65C64189A3E7C29@BY5PR11MB4165.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hH45HwC4OXYJoOy5ARIkF/CdSXLnMhjVp2PtdfsKvIPgJFFMsnohBCfmouOm95Bk5dnIeJSC2ycUuQG5FVxeI3z68kPonXOLdDvsaVmVeVicnmYNA95oCDhE1GQIs/L2THHPD+FtaKCx/NDFTbsciwWKB4BTbA5RamP3Pc80zpFvkZ+UliErJ0e6pk1MK70Y77gXq3ZsdEbMzuMv19V3IcX1oJpECigN0WPVayeVCeZb5Hz2pVoQ595T2nc6pWzMgzTDjiztUi8w/Bla7YxAhwcXf+RiwzkEP/HNKKhpsQcJGo6OVwn8u8C8o1ux/NncRC4qnauSDayGo1+g7NXaYrkcSggH+LYa54n/wyjXCSblYdeUUbcSvKl/RMCf63fxY08zVzRx62+a20nR0q0Z9B3ef3aJ+TWv+j6mFjqNhpWx9Rkruc3xvN+L7v8Lmjs/72lTSEj2rQpedQRrPcWyIIhgwDiIxOufJT4uiSvrmeembtP82XdtBQgWfCo5FwtMQsiwYR/Un3V+5T8lUtK6CZOJ9ok40xIIw5jKOfekyES1DIEMi/ah81Flx0b9Wc4xMDOEP7M+ungQl9m+KFW05ylriAWHH/kwjfSw78I+O9eZ20O1azsdLIQR77DUitkssf8bMsq0yeuMggWMAm1zHK7i5pctS0ciGQvHs/o4/Rr5cvX6Oc8L2/hvWe990j9RcxjsbEEDses1vCU2jC+QAllEYL+BEdqgq5/SPfUX+GsbrILjGs4ZTxXtCL9xMlw8tUAwlOYHr5Udd+UPasz1RA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5936.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(36756003)(71200400001)(2906002)(5660300002)(2616005)(6486002)(38070700005)(8936002)(38100700002)(110136005)(54906003)(508600001)(91956017)(66476007)(66446008)(4326008)(66946007)(66556008)(76116006)(8676002)(31686004)(6506007)(53546011)(86362001)(64756008)(122000001)(186003)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUQ5OVd2QjJRekRSbGdvUEpIc2tKZ0haZm5rNzZTNHE0TGxnYisydXgvWmQx?=
 =?utf-8?B?UEI3QVBqdWVLZEE4VHkxSmRhblljMTBZTGZwM1FpaDU2K0JNbndENWU2UzJu?=
 =?utf-8?B?YmdROGNSczBnbUlENWpGWFdCWnZ4N0ZmZzdTOTF5dnFYdlhyUEVrT1NYOU1P?=
 =?utf-8?B?WGpELzhqczVGQWM2OXVEQnVWb09FcnpPaE83aENhclphL1pXbHRZUGdLc2xM?=
 =?utf-8?B?UDlwMjlJN0gwV2llcEF0dk5TbkFaamozbDdMUmJqUjd0SkZDcWd0YUVVNDhZ?=
 =?utf-8?B?RGdid0VBYmFjd2VnbVdpb3p3Zmh6M2NGKyt2aXYrY0FSVHdJSjVRazlCb2JF?=
 =?utf-8?B?L2lsK3Q5VEtORHM4TS9adTJYWVE0aStMVUZOZFVHT3FRcFJNd3JqUjJKeHFB?=
 =?utf-8?B?bFg3ZXRWSEdmNHBhbW5aMGxZMUhDYlhQSW85ZGE3NFZjTG9QaHNEMGw1WTV5?=
 =?utf-8?B?aHZ4S0hkNjczeDFURFBTWkJZNCtzdlBnTDFzRGtnM0dGQkFneGp6UlQ3TXJZ?=
 =?utf-8?B?OEVGWHJCOUcxRStPUGxOSGh5ZEhIYk1zUnNSQTJrNVhzVVJZSGQ4YVNkbWJp?=
 =?utf-8?B?U1BBV2g1VlN3V1ZLRTlVVmp5RmpRM2UvMGNLeDh6cjM3ckNKWXA3cmZzc3hy?=
 =?utf-8?B?aHozbVN0dnRVbzBxVFRXMXhzaU5IeFpoTHlMTzhKbEpmVU5Jb01Kdjc3TDV2?=
 =?utf-8?B?THFxZnQxa2JoUEhkcHorYWFmVHV4bEswcjVvNWdEek1rSnpRUVRhUG9BQmhp?=
 =?utf-8?B?SnpnTEdacVc2dWFaT0VEZlpxbExMQXBUSnptSm5DaFQxcGcyT054M3U1YXd6?=
 =?utf-8?B?S3RJSUZlYUZ3TTFJaXlJYlZXbzlMZUt2ME9hU1BJdHp5QjJ5bGZTMndlY1RC?=
 =?utf-8?B?U29GU0dlM01mbWo1ZzVZYzNYdFNmR0lHR0R2dFpRMmdqRWpNVE9vQ015VG1Y?=
 =?utf-8?B?aTJ5akV3NkZIcFpHNEoxa2s4SzJyL3JZekVONzBmcUJLRTZDQVBka3R0bHNJ?=
 =?utf-8?B?L213NGFaK2x5TjFDQmFkVlUraXo1WGttY3pRakdmUmRoK0JJdWtBVzh4Z0dG?=
 =?utf-8?B?MjYzNUJCSmpOb3MxTCtMc0RGaDdSeWZnbHl5Uzl6QWpiRkZoSk51RWtPOS9t?=
 =?utf-8?B?SE1RNVpIblFTMjJWN0NrYXkxVWdEaXRRYnBGRWhOUmpIWTRDbWVtUkpRWEl5?=
 =?utf-8?B?UE52dDRPREgxOEJNVTFlNE1jdkxqSmFQWTlxS094WENQZ2Y0MUorbkpaTnJX?=
 =?utf-8?B?Y2VNc0ZJYlVuaExwYkRnK2NqQnZFeEJ6cndSNWlRSC9IRHhFNWU0czYzVytp?=
 =?utf-8?B?alQyM05xMExUZzdkM0dVeFA0RGV4UHp4cWpKSkVGRlVhVUh1RmlyVHVUZjNH?=
 =?utf-8?B?TmZVMzN1Ty9RZU54cHkzM3pMbWhtOC9zajdnL1p6UVFRWldOdFU3TlRORXIw?=
 =?utf-8?B?RlB5aE1ZSXZsM2FUM2RpZXVtc0dyN3hSeXpuVDlITUlkOGNibWpraEZ5ekh2?=
 =?utf-8?B?NzZwSFI4RzhQV3VxKzJKNklTZGdkZUhkM2IxRE9iSDN0d3hoY0QvM29qclJs?=
 =?utf-8?B?MGxvN3pGZ01PR0U0WXgvVCtHWEJlRm9XTFdXSzdUaXNMaFoxTHQyWmNaYUQr?=
 =?utf-8?B?d2IyMThyV3FOOXRsVk1zZVc2bmJoWEdDRzU0TmtoZVlMQlZXcFBDNzZtRlpl?=
 =?utf-8?B?b2xJc2NIYlZPN0tPaTZ1UTZNR2ZubUJUWTRzTWxFNEdhTTJPdjdzbWlDd01Q?=
 =?utf-8?B?dmFjdnE4ZGJXZ3lzZUdob3JzSjM4WjB2N3NJSlVqeUlXaVVyL2R5NWJNYlVL?=
 =?utf-8?B?RmdOdCsxUWJQcnVZUHBOa0NDcXdWT0U5V1ZFZjQvQ2JFZTFIakN0UnhoZDkv?=
 =?utf-8?B?aW8xVUluUnFJTXRKOUdYU0o3TGFIVHp6NkRuSTlDdWFvNzNVd3BOYWdmOUVO?=
 =?utf-8?B?d0ozc0haOVg5RkwxZjRLeW9nTjh6OWRVN0JkbytoR0lEcWpmT29wMG1lbEVX?=
 =?utf-8?B?dzdRRXhxRml6SFNiRjdybHdHQksvRFNNSkdVV0EzN0M5TWtrcUF3YkxvZlJR?=
 =?utf-8?B?dkVKRW9FTy9CdnZmL0lCRE9pOFloZWZnSE13cEkvdk53RC9yOXo3VmRwQ2Jw?=
 =?utf-8?B?ejRFbE55STVUU1lCZ2ZLZnBwMnF3amdsYW9jek5QZTlQZEJsdkxjNkRGVWE1?=
 =?utf-8?B?TW9kQm1rOFJuNzZ5a25kUEZBRzNSUGVTL0hycElXOFhJakVsZmRuZno1YUtO?=
 =?utf-8?B?U1UrVGZGSW44c1JoY2FDUHg0RzlWZzJHdDZidWNqbElFUTlzMzNJOE5MakdJ?=
 =?utf-8?B?VDkxT0JVSTUweGVqTGdHTEh2ZWFUM0ZXRzJ5ZThGQWdYWlM2dDdBNFdNdm1R?=
 =?utf-8?Q?lH4Tss+W2NBwhSEswSB2JBovIQhS7Vh9GbZuEYIGPz9kQ?=
x-ms-exchange-antispam-messagedata-1: DmeSfaB0bg2OkgOoXFc9ATHJQEaxjiJ+Xwk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D89D3F722AA73C4BA7092D74330E1007@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5936.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ccd753-dddf-4b9c-7700-08da2ea61ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 14:47:04.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBcmgtLWVDDxHxBv4beGkspqIHmwmdNYofIyZo7TekRQHP8V3Rfvq9Ls1IrNYNe8OuqGxCJlxZkqEn3Jgak7PWWKPBVN8E/r+XIU/LVMOeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4165
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMDUuMjAyMiAxNjo1OCwgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4gT24gMDcvMDMvMjAy
MiBhdCAxMzoyMiwgQ29kcmluIENpdWJvdGFyaXUgd3JvdGU6DQo+PiBFbmFibGUgZHJpdmVycyBu
ZWVkZWQgZm9yIE1pY3JvY2hpcCdzIFBETUMgYW5kIFBETSBtaWNyb3Bob25lcy4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90YXJpdSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9j
aGlwLmNvbT4NCj4+IC0tLQ0KPj4NCj4+IENoYW5nZXMgaW4gdjIsdjM6DQo+PiDCoCAtIG5vbmU7
DQo+Pg0KPj4gwqAgYXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcgfCAyICsrDQo+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2NvbmZpZ3Mvc2FtYTdfZGVmY29uZmlnIA0KPj4gYi9hcmNoL2FybS9jb25maWdzL3Nh
bWE3X2RlZmNvbmZpZw0KPj4gaW5kZXggMDM2ODA2OGUwNGQ5Li5iYzI5YmFkYWI4OTAgMTAwNjQ0
DQo+PiAtLS0gYS9hcmNoL2FybS9jb25maWdzL3NhbWE3X2RlZmNvbmZpZw0KPj4gKysrIGIvYXJj
aC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcNCj4+IEBAIC0xMzgsNiArMTM4LDggQEAgQ09O
RklHX1NORF9TT0NfTUlLUk9FX1BST1RPPW0NCj4+IMKgIENPTkZJR19TTkRfTUNIUF9TT0NfSTJT
X01DQz15DQo+PiDCoCBDT05GSUdfU05EX01DSFBfU09DX1NQRElGVFg9eQ0KPj4gwqAgQ09ORklH
X1NORF9NQ0hQX1NPQ19TUERJRlJYPXkNCj4+ICtDT05GSUdfU05EX01DSFBfU09DX1BETUM9eQ0K
Pj4gK0NPTkZJR19TTkRfU09DX0RNSUM9eQ0KPiANCj4gSSdtIGZpbmUgd2l0aCB0aGF0LCBidXQg
SSBzZWUgdGhhdCBzb21lIEtjb25maWcgZW50cmllcyAic2VsZWN0IiB0aGlzIA0KPiBTTkRfU09D
X0RNSUMgZGlyZWN0bHkgKGFtZCwgaW50ZWwsIG1lZGlhdGVrLCBzdG0pLg0KPiBJZiBpdCdzIGFi
c29sdXRlbHkgbmVlZGVkIGZvciBQRE1DIHRvIHdvcmssIHdoYXQgYWJvdXQgZG9pbmcgdGhlIHNh
bWUgYXMgDQo+IGl0IHdvdWxkIHByZXZlbnQgc29tZSBicm9rZW4gY29uZmlndXJhdGlvbnM/DQoN
ClRoZSBvbmx5IHdheSBpdCBtYWtlcyBzZW5zZSB0byBtZSB0byBoYXZlIHRoaXMgZHJpdmVyIHNl
bGVjdGVkIHNvbWV3aGVyZSANCmlzIGluIGEgc291bmQgY2FyZCBkcml2ZXIsIHVzZWQgZm9yIGEg
c3BlY2lmaWMgYm9hcmQsIHdoaWNoIHdlIGtub3cgaXQgDQpoYXMgUERNIG1pY3JvcGhvbmVzLiBT
aW5jZSwgZm9yIG5vdywgd2UgdXNlIHRoZSBzaW1wbGUgc291bmQgY2FyZCBmb3IgDQpvdXIgYXVk
aW8gaW50ZXJmYWNlcywgd2UgaGF2ZSBubyBwbGFjZSB0byBhZGQgdGhpcyBzZWxlY3QuDQpUaGUg
cmVhc29uIEkgZG8gbm90IGxpa2UgdG8gYWRkIHRoaXMgc2VsZWN0IHVuZGVyIHRoZSBjb250cm9s
bGVyIGRyaXZlciwgDQphcyBzb21lIG9mIHRoZSB2ZW5kb3JzIGRpZCwgaXMgYmVjYXVzZSwgaW4g
dGhlIGZ1dHVyZSwgd2UgbWlnaHQgaGF2ZSANCmRpZmZlcmVudCBQRE0gbWljcm9waG9uZXMgdGhh
dCBtaWdodCBub3Qgd29yayB3aXRoIFNORF9TT0NfRE1JQyBhbmQgDQptaWdodCBuZWVkIGEgZGlm
ZmVyZW50IGRyaXZlci4NCkkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBvcGluaW9uIG9uIHRoaXMuIElm
IHlvdSB0aGluayBJIGFtIG92ZXJ0aGlua2luZywgDQpwbGVhc2UgbGV0IG1lIGtub3cgYW5kIEkg
d2lsbCBjaGFuZ2UgdGhpcy4NCg0KQmVzdCByZWdhcmRzLA0KQ29kcmluDQo=
