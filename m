Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145AC573C22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiGMRod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiGMRob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:44:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD442CCB5;
        Wed, 13 Jul 2022 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657734267; x=1689270267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IwVwahZzpQ1N8ll0hnE/mDJqM+M1Dz3QCQsraghctSI=;
  b=GOg1bFMx0o9+BdBHoDnaHfoAHVc+MkcAQom2d+R1jfQ6p7U2c1lVkjIP
   IFNmX2tIuM2zGelybx5diZsRys2wsvr0O22RdrDG9NM7lxylxunNy0HEq
   ZrhTOTe12jW88ZT8UF9ra1a7cjliIsrg51N4pIrMohI8chCHSQ395sJP2
   jEoWPmuJKQwFyjZet03meDph60rznUiM17MFEYFyfRW9SD79aaddJ/7Gg
   1cNzeQxfnXXQ8fWX5io9odPWF6vtqfur2RIZGl81DASF92/cpyDsA+myb
   POEPf8+Kqvx59FK/qt+AQ3wOaVY3RgcbDj4XbZaU5sm79bM8EfI3QK/Oi
   w==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="104322994"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 10:44:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 10:44:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Jul 2022 10:44:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd0+xm5TlC5JhyNAo+WoPMKekPT8pkZ1rw2sryivoN1qeaGT1RUbAaH7x6Dw5xWOlapvUJIF7J5MpruzjpCifO6h2esdidAApkpKJjyF5rRg0h6BiWylFfi2nHVw8fIWYH4lmMyDMLN1IG06jjT6Vxp7966ZdQ8/5xRI98IdsbGmguM7rsrbOYMKOuTQ83JNRbRT2ZrcYww8e1jszwFmHehbbadZf8MiRkZWE1bCQ+HQDf8WHBCluqIv+fx3VcKkqsv7nHJ/hbH6+ReoUvonUfb0Ex4F2fprfQ/tO6meoEgyzBalqYGoG5CQa+ti6pJvR9e6d7D0OqUM0y6/yQa+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwVwahZzpQ1N8ll0hnE/mDJqM+M1Dz3QCQsraghctSI=;
 b=XQ30TnCrhkffZbOlsVdJZ7oqo10ISKSlWDlO6N1MyfMdI5vfsQsAgR/aFVJOIJpJG6Lfn/EVt8QEP1f0J8WRepfS9EkJaLGhOEHsCJhCFw9CIJqTyuAab2O4kOtztli55Fk7cW38nsdt4eWzgjP732chL3WfCsp8NBn3SH4Qu7o5IO2oXeSo9QNKRq3Mw4mT8s306b6RqONuxffCqUpR9RVjznrxBm/OwWdayGVQ0gu5pvJadChrPLa79n6zKq9GbrGL5ZCWkWUd44LrYwYicF8X3/bJbrYa3l5ZltQTPaaJ47ZrtzRvuZy1AH3iqDgwi3Vymnc6pi4su9BPfnuynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwVwahZzpQ1N8ll0hnE/mDJqM+M1Dz3QCQsraghctSI=;
 b=voKnBiGBDp3xPMk3DRonkyFrVPXHno7/a09tR9J1jvS66fM9CVDonOFlhvvEKFlNWvyctufb+xs01PkJC0295mnSU5s35uLQBvuLUU2xnXWPTL3DYrxxWBNRrr1gvroNaGeeuer3nyrGjlsaRQ0gwB+QlFUcUso1M5cHT2J/UWk=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by BYAPR11MB3221.namprd11.prod.outlook.com (2603:10b6:a03:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 17:44:17 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 17:44:17 +0000
From:   <Conor.Dooley@microchip.com>
To:     <andy.shevchenko@gmail.com>, <Lewis.Hanly@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <maz@kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYlqemVrcQOBoUV020qkXDgR8Pgq18MrcAgABgUQA=
Date:   Wed, 13 Jul 2022 17:44:17 +0000
Message-ID: <debb6cf6-65f8-53d2-d8d7-3ed1c3d5a8c7@microchip.com>
References: <20220713105910.931983-1-lewis.hanly@microchip.com>
 <20220713105910.931983-2-lewis.hanly@microchip.com>
 <CAHp75VfGTd02jKYsFq94BF_Gqro2trk3iyyALBatS1Bps3HYhw@mail.gmail.com>
In-Reply-To: <CAHp75VfGTd02jKYsFq94BF_Gqro2trk3iyyALBatS1Bps3HYhw@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a02a106-8ede-4adf-e240-08da64f74f26
x-ms-traffictypediagnostic: BYAPR11MB3221:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSJYZLEm8XYzVK0PlYniWcuFzUlOKcBfuWy8+sGQqaTavYLj5Qkq3nNBF4vOLXRWvdQtQ8gMOIR8Riea2nlx0mg725uVJQkjWBaedvMHThaBrVh4RM+UpHPeBWp92pTbhnCkYtw8cDZHVEk8tZIrcTyn3nrWK5Za0Up+5krzdWoPWpBzuxnLgAHBThy3Pw3lMRbcQjlAiW9P62l+nsb9sTN6HVJKo+SPvLNikqK+8ZVCbfQBsCWXtlM3RjMSuFxFEo892BB4h1Fyao+kzROMPY7EVELAeEGtb8ofFyjPu6l/2RpD5d2BFwQ92ssbUeLbOcC9DH8XgMO+CeLfAkQN7yx+2bX6VKFL2YS2SzY62DWE40sxH6shQOQe3praHVxRdx5Qv3XS1toiLr1cJj8mAjZO7JVCqntlpeh6I1KgdvUy0Bq4PuuPU39LtmXxHmvzCfI0qwRQK+SfbszSuEsngeWXk0BbF/y9fxFe3kMTZDBMj+5NpUY6UdHKRyol03RJFfceOMP0mLGw4iAHqJ0EpCFdNU8zz7ajRAZCbxR7KLYUal2Prj1/gyTZ8jefccCXLWJmKyF7uPk7kjaOwvTXiXLFlVZ+/xTmV8pN9QWFFAlXuu5B/vGhZ2wMVGos+TXdpzD4cvTJcS3e1n2EvsztNGmSIe4WauYFQpf5fQpB2mq24Z8GKi//bzl9+vz7aflspAHhunEVh/Ul87/eWqdnsXByk+dUjgmgd+ZcrcfCurjJEXA09qw1pn+ZbB5JN9BR/283WFM21Sgp9LBkCvXJB722dzBfQ2EVoU2SiMZSpHOLmfy6x27zpsC5Z2pLMFppkGy7ksKbSHlcnazCLyZ1CPBW7agimVqtpt1fxyIS84jRm9RkTKkGUYYJJhRvX8bm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(376002)(39860400002)(5660300002)(110136005)(6636002)(53546011)(76116006)(54906003)(66946007)(71200400001)(41300700001)(2616005)(91956017)(316002)(6512007)(4744005)(31686004)(6486002)(186003)(478600001)(26005)(2906002)(107886003)(6506007)(31696002)(122000001)(86362001)(66556008)(64756008)(36756003)(4326008)(66476007)(8676002)(66446008)(8936002)(38070700005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekZ1dlR2SERQWitYRVhyeVhLYlVXNlh1bEkzNHUyOWVQUkFuNWRIM25wR0pp?=
 =?utf-8?B?NTdNYTE0dTNwK1ZobVlodWF6RzFuWUpPK0hTdkhONytIOVVpNGl0emlmK1ZD?=
 =?utf-8?B?UFZmRFpnK3YyMmpYUnhBbG9tb0xWWXZPVjVWQjdaRzJCdGROZGQ4OGM4dG5W?=
 =?utf-8?B?MHdNdWMzbjBTNkE2WERLWnlPS0xBT0VyZjN0M1l0TVhobmN3SVNJKzdVcEZ1?=
 =?utf-8?B?TW5lUTBFUkgvNkpESVYwbmlveEZFT1RkRlgxOXJhdjlTdzdnNytpYi9ZL3ow?=
 =?utf-8?B?VVZOTUpIdUp3bThSVVkvUVpTRHFVUkllaWxVRGF0c0svMEJiSEp3VTREdXJK?=
 =?utf-8?B?bEJmYXFDNVZUZEZqVjZVOE5GczlVNkltRjEyWjV2N0Q3UnhsYjRqWHBSb0Mx?=
 =?utf-8?B?RTA5YmcrQi93UG1EL0xnSkZaVVZBSVlWU0lORU5tT2c1WE1VRnBkSExjcWZG?=
 =?utf-8?B?b0M0Zm9heWc2aGJxRXRldGhxd3VyVW9UcjdWei9wejFXMnhrV2pOMm9veTRJ?=
 =?utf-8?B?d2NONjdsaHlkZEhVWFljQjJMbEgvYVBXbVJOTWJTRlhMZVhYWFRtRGNDQTFP?=
 =?utf-8?B?SjdVRmFUK1dHbndVaFpzMTFyV2hPU3RMdlErYVFmVkFqYk5WQ2c1Q2hQeGdr?=
 =?utf-8?B?eXN3eUNBcUw5TW9FRlAxc3k0OElCQlFQNUsxUGpxMTJMYXdncThTQ2ZqdXVP?=
 =?utf-8?B?NUphMThFbXZBbXRmajcrQ291eFI1dmxsZDhJTmNGUVFZdW0yaXdQVjNjYWZU?=
 =?utf-8?B?djJhdzJjYmk0NE5mUXVxeDU5UUZRd1poTERuOURjM1NlN3J6ZU13cFQvYWtG?=
 =?utf-8?B?VklLZ0ZlOGk5Q3NPWlBmSUh5WHNXTTZ4cFRVeko1NUg4ZEM3cFA0aFVtdUt0?=
 =?utf-8?B?K2EvMElmRlRyUUkwa0RZRGpOdVhLN3pSbzlGekxMSlFIZkF6Mjlja3hPdGhS?=
 =?utf-8?B?bmtVSDZuN2NNUUg5UW54MStHUmtLc3ltelBsdWdVaHA0OW5BNFc3ZjA0aGxs?=
 =?utf-8?B?bXdIZ25nQlNUSXRTZk1vQjBEMnNDNjJZenNwNktaNjBvN1JpOTNlbkJYbnFn?=
 =?utf-8?B?dWxWbi9sMW4yYTlUYXhWdktnRWxQSi8vSUVqdDNTUUhQRFFkck1ReGxYRDdG?=
 =?utf-8?B?TktVemd2bG1lcFBNdDZqVVArbEV6b0JiV3BOVWpaOWE2REVEWlFDcENlZVpr?=
 =?utf-8?B?aWtuaXlsN3B3V1hkMWFZNTdJYTlzM0ZsVFMxNzFMNUFRSmxWQkladThQZzdU?=
 =?utf-8?B?NTdnMG9QNTRWaHBuZThISmJ4VWhlc2ZPRHArZ05Pa05GVDg1cEhOa1BMQVVt?=
 =?utf-8?B?SWk2VHpKTTE0UUhjbDFaY21hWEVTWU5LVzBFaVo0QVhSbGhsVVNHdjdSQjdE?=
 =?utf-8?B?U0t1VUpUQVExNVJhQVNjbWRUY3hDUTY3YVN5SWc4Z08xWTU3enJEUTRHd2Qy?=
 =?utf-8?B?MzJlei8zNjFCS3dYb3Z0N1pyQm9Yc0ltMFdxeENsWTZqdWZkV25QRlFIeG9s?=
 =?utf-8?B?Y3pDR1hJanN2UmZ0NFJOUytuNE5JUWxCNEJ1UG1EMUFrSXMvQWpzLzJDSlhh?=
 =?utf-8?B?Z3hjQW1GK2syeUR5QTRvMjl4dTkwVGl4TjBNWU5mVUd0L0NIeXEvZnZOYmJp?=
 =?utf-8?B?a3J3czI4ZUZhRENYeEd1RUNXejRZaUU2RkNDRVdENlIxdGEwZHBrREljbGV5?=
 =?utf-8?B?TWFCVlg2dlJQOE56czlDQkpkUG9icWNBYXNPcE00UERreGtvYmZiVVJ3NEo1?=
 =?utf-8?B?WEVPUHRJTkJ0RnQxaHBESFN0ZFdGZi83NEZKZ0tIazRjTE0wdHRURjM4VmRI?=
 =?utf-8?B?Z05QeUdCajVId1RiM2VUVGxLQ1pKNGVma1NRT0d2bUhJaHFScTRnYVliNnBk?=
 =?utf-8?B?ekRjNy9yZnlZdzVLQmVxRHhpTlF0dm10N01iRTg4NjI3SER3ZkN5MmM0QkJi?=
 =?utf-8?B?SDVCZC90eFlTZ3pVK01UemhzUFBrVFN1SzFjUkYyNHNKWWltL2QxbXBpZnhB?=
 =?utf-8?B?ZS9kK01qdmk2aC92bzU4VzVnMFB4eExsdGpaSVBTOWNmbituUXRHS1hIOERH?=
 =?utf-8?B?VEZyZGg5ZkNSQ2ExVlJjdnVEQTBCUEVLRzNhR1M3TlFUTDErRDZVa0YzakRu?=
 =?utf-8?B?a1d6K29oMmFZT3ZYTkN1V0QwY3NNOWEzaG1KZUJUSmJ4d295bkM2UlVCVEZ3?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <032FAAA89541DD4CAAC1BBDBD5618552@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a02a106-8ede-4adf-e240-08da64f74f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 17:44:17.3369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGjMt8qoJ73Od3GkzrpDSzdpPawP5q+lAY8PaKLz8TR+cNtuDOggHHNk52oG1inFaM7F66eLYDOnHtjL/m0nec3HN2bwMkAV59SXlwNZ7Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3221
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDcvMjAyMiAxMjo1OSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IA0KPiBCZWxvdyBteSBjb21tZW50cywgSSBo
YXZlIHRyaWVkIGhhcmQgbm90IHRvIGR1cGxpY2F0ZSB3aGF0IENvbm9yDQo+IGFscmVhZHkgbWVu
dGlvbmVkLiBTbyBjb25zaWRlciB0aGlzIGFzIGFkZGl0aW9uYWwgcGFydC4NCj4gDQoNCj4+ICsj
ZGVmaW5lIE5VTV9HUElPICAgICAgICAgICAgICAgICAgICAgICAzMg0KPj4gKyNkZWZpbmUgQllU
RV9CT1VOREFSWSAgICAgICAgICAgICAgICAgIDB4MDQNCj4gDQo+IFdpdGhvdXQgbmFtZXNwYWNl
Pw0KDQpEb2VzIGJ5dGVfYm91bmRhcnkgZXZlbiBuZWVkIHRvIGJlIGRlZmluZWQ/DQppcyBpbmNy
ZW1lbnRpbmcgYW4gYWRkcmVzcyBieSAweDQgbm90IGtpbmRhIG9idmlvdXMgb24gaXRzIG93bg0K
YXMgdG8gd2hhdCBpdCBpcyBkb2luZz8NCg0KPj4gKyAgICAgICBpZiAoZ3Bpb19jZmcgJiBNUEZT
X0dQSU9fRU5fSU4pDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIDE7DQo+PiArDQo+PiArICAg
ICAgIHJldHVybiAwOw0KPiANCj4gRG9uJ3Qgd2UgaGF2ZSBzcGVjaWZpYyBkZWZpbml0aW9ucyBm
b3IgdGhlIGRpcmVjdGlvbnM/DQoNCkZXSVcgTGV3aXMsIHRoZXkncmUgR1BJT19MSU5FX0RJUkVD
VElPTl9JTiAmIEdQSU9fTElORV9ESVJFQ1RJT05fT1VUDQpJIHRob3VnaHQgc29tZXRoaW5nIGxp
a2UgdGhpcyB3b3VsZCBzdXJlbHkgZXhpc3QgYnV0IHdhc24ndCBzdXJlLg0KVGhhbmtzIGZvciBw
b2ludGluZyBpdCBvdXQgQW5keS4NCg0KQ29ub3IuDQoNCg==
