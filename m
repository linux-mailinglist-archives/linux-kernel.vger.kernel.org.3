Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8165997A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346722AbiHSIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbiHSIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:39:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB942B247;
        Fri, 19 Aug 2022 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660898313; x=1692434313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/jk6Ir90Y9B6bLitWBq8arOPX1/7uZT2lxl+IZPtZto=;
  b=SzVfrp7Io+3fNPM11ELlEodbektCAJH3pWol0b4tmUHA/Z89ydopV8/L
   RRzvSTsSTM+12FdOKS1QbjcArXYqSPRZj5Jrijddm+trbiX6q4YMV6pX7
   csb21Mlqe4gZ0dfyu9Qtj9CVvtbLAeoq4T7u3etAPUBzp/lbKrebiN1p0
   8ZF/HI8nFUAvRa1q8hA/DsuzEu3saVcBsGzgziH1lo7bzqhcpMULsGVTV
   4mdXIkiUDUUzU6pwr+djKzBRa+OhstXfI+Q2O75n+KXw+CQvq75l2GABa
   UlgTuCcvK0OFGhxJY14PlJ/gQrFxclTs+c7FssQmKBYp2QboUnasuPC5e
   g==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="109762126"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 01:38:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 01:38:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 01:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXBKp+l4OUbg4zBTlzqO4xUmyzBKWp4sxWwZmP0UOBJeQWcG/vKA0asZFKqspzNuChg3Z8nLAZgpsTvzHPJOYVxq2AusbkPPA15re+7XtByZIPcc6aDwuCZKkQuXKk/QOXN7mlYfUmRMY2aA9L6HJ5GaUyE9NdIYelYN0J7FcMThqf8E6xwYiH51I7DlS8qEcOWPByW9NTNtCrCJqWKGg2B198FDRCgKS9bWEtiTGs1sQG/P8zgyRgMRWtkClAV+sxwLlJGhkcusOKHfPoPQkPBOFJLyiqAgyakhBaBZwRRURstgjx0F5ubppnrGjpGfJ1+bIM1w0NSrxQjbP4oLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jk6Ir90Y9B6bLitWBq8arOPX1/7uZT2lxl+IZPtZto=;
 b=NJKo8CbDbb0MxnADYiLFapjAFej14ixyK09kz875FxsacerREmnKBiegzwAfr0ZhYy2RVg5H7IACoIkVjBHWbX6Qhg+H//wsRGBwwCa5xIrYwDZgaU6ys0cu7mU4gHyZ9yUY1R555m8Nq4LYBr8habvtqQTkcj6plIVAlIlWamj0WWoOcufy5mJXL0wd814NSTzuKQUsu/GVOMXqetXceRBeHfIhbMZwNbXXXUA6T2ekQg0X4knnefHYERuMChVRcbqTamPTtiGwep3Pw/9qpnPUFCTCDDm2KYMJ5H5yNmm5ounzy2f9gz1KncZOOl5iMTSi5vt8nUzW3RenMLR1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jk6Ir90Y9B6bLitWBq8arOPX1/7uZT2lxl+IZPtZto=;
 b=WoDXEwqS14IJlxLQBM2acOf+21mVg3g7hBXt5GJUBmHU/+q04WwOHqXcwTU3Kf/ibV88wDvt18z0jrbtsYBZPzDUd+U9OVq2YJOuQwDZagJXxTB5daTlqiZ7I2JJIIX+Zwo1vESXlF/YP2r0x3Lq6foaIczX+kuTKPZhnm7GVCU=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by DM6PR11MB3354.namprd11.prod.outlook.com (2603:10b6:5:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Fri, 19 Aug 2022 08:38:24 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 08:38:24 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <radu_nicolae.pirea@upb.ro>,
        <richard.genoud@gmail.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Topic: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Index: AQHYsg/cwUZrhBU4AEegbceOuhne8K20V+AAgAGSGIA=
Date:   Fri, 19 Aug 2022 08:38:24 +0000
Message-ID: <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
In-Reply-To: <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f8fb343-f4a5-45af-34e7-08da81be2e3b
x-ms-traffictypediagnostic: DM6PR11MB3354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4qX46a/CWFUpS/iwAh76PZTfcP0wma0X42LEsSVVCKwIucdirutw2EsgK6GpgPs2WI/+6989t/qHnEsI5GbtoXxeXKghBc/71iQh0CfsjmzMjota31HXUeM1+kbl5xYS6tuUSQugBqHNlE5qIs5XHCnfxVz5MkPF4fyg55bnGp9+bj3cIy92p0wMK3Uwf9FNuAiaV4cSgXnqZdM64SSPKsI9F1V8j1Fdd9f8Dcj1utKtiBvRycY4kwJVx9peEAQvlzDdPapiXxBBUoeBgywMthU6OHzCpUrA3em3xuXUVSz44XXYDPEzqJcWh75ozNCv8ZGO2ctygevM/4G9ToAcCO3wypJRoi9kSsNcY3nU/oTs21T97jv3fpx5E4Dhc9Gz82R6dbHENXSW80tTYrs2yHDFZfD6heQM+EHVBACU6c8z9+fnPw1NC6D07zrfqhFsVTtb4npquhw4TCSM0Df0Re+RcnOXCHmHinHeKizyWZZHd55kiHw4XnI2LchpduqErC47RnfFLqiqj7l3Bkk6wC+uYvotWwOgAqY0DU3I1Im89VfKCBaI37udJkpCWUtCZ9FCE//Q7zqxu2BfeDtA4tfTssgKp1G9NhYJ8gCe2GfolKHmTmJVZXPnVF83JnpB02pOkSpngUDxGYhEpC3cRcVy3Aa9EdbB4yqLUYFR81h+PcQziEvcsp7stQYXMbfyEZdu3zJdAvNNYBz9JVxBNw6bmtnYk1W2PF6je0dYkWhywyOzH6r08ioXk3RS3mqem1rHaExxdf6pvgJdpdLQa0cyildSuoisFuuSLkIuAPEXnhTn54oaiuv7IZFjT9W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(376002)(136003)(396003)(36756003)(86362001)(2906002)(31696002)(316002)(38100700002)(6636002)(71200400001)(110136005)(31686004)(54906003)(122000001)(91956017)(26005)(4326008)(186003)(66946007)(5660300002)(8676002)(6486002)(66446008)(6506007)(53546011)(6512007)(76116006)(66476007)(2616005)(7416002)(64756008)(921005)(66556008)(83380400001)(38070700005)(478600001)(41300700001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFNNYTNtN0RxWU1zeEU4blZ2NWl5dzVyS0pFVGJvSmlSQjlKSmJ5T2krckxR?=
 =?utf-8?B?U3E1YllaWGxNbFhIRlBRbTYyR0ZTRmM4MHIvODZ2NkFtbHhoVlM3RlNocWtt?=
 =?utf-8?B?NCtxSmFlT0pDSU4xUm1sVEpoZ2U4Q1p5YlYrYlVWVVVwMVpQLzMyUVZ5djYv?=
 =?utf-8?B?SnRuUXpNVGNRUjNteUNTN2dSa0ZvaHpUYnI0S3dEVFdkTGZ2cWVmSlNaYmNB?=
 =?utf-8?B?d3d3YXJ6RGJNeDZkYVJmbmsybVIyMUZ0WHRlY2VTMzZyUzJ4YStnN2FPVVlI?=
 =?utf-8?B?VzhVc0xLL3ludHpkNzc4SnpPeDJkZlNKMWJIN05YV05pYlAvRXNUZVFxZWw5?=
 =?utf-8?B?Mit5ZlFLQmoxWHVDUTFQbTcyU3doTkhwYzNsQlRaUVJUZ1hZNnQyaFhwRlZs?=
 =?utf-8?B?VlJzTFExTFhkbU5mNTd4TmxGVTlBemF5M0JjOVoxWVpZemxWd203Y0hoeGVm?=
 =?utf-8?B?cTJSR2JLZnUxM0IwWXoxZG5acURJQXliWXUzMytkb1EwelRFaDZtNElsNTha?=
 =?utf-8?B?UFZGb2szL0g2alhWamZoNVp6Y3BBOWlYNWR0eW5XbndYdjUvRlAvQlVPVjdK?=
 =?utf-8?B?TTFhcEgxYVVMaFhIZzE1RlF2UGhReFUydEU2dmExU1JJaXcxRXRvMUhGU0ZB?=
 =?utf-8?B?b2hwNkpScEY3L2sreUlrZlBJTlBUd0grY2JxcTdTcjZrOUg2WEZMRDV1OUNR?=
 =?utf-8?B?MzkzMjhzZGV4QUpNZ0duN3pkcjdIRDA0cHRGdWFVc2k2RzNXRitUQXUzY2sv?=
 =?utf-8?B?Wi9INE90K0MxRTdBZlgxbzdWaVIyNEQyZU16c0s4L2NCcm04WE9uei9XbFNx?=
 =?utf-8?B?c21TSkxCUmc3N3hjSE9Nd2MzV0tzWWxHN1BzYzlSQkhrb0JZYTVFaDRnbkdp?=
 =?utf-8?B?VEhmRTkwREJqSmlhQU9iOWlVQ1R2LzZSb2JocDZOT00rd1hGaWozb1NJYVZy?=
 =?utf-8?B?R2lraFB0RGhNTE5vSVBiYlpwOHVZTWxHZWtIdVc5d3o3blpxd0JYbmU4ZFZy?=
 =?utf-8?B?YXNlZzZtMGt3UmhqdW5xSXBpNE9pUlM5b20ybGdZQW1lNTB4OEViYitORGxO?=
 =?utf-8?B?OGMrTzJTYkFLZngzRS9sR0p5bkRHRURVdjhKVVAwem9WTFpoTlh2cDZGdGxM?=
 =?utf-8?B?Z0hXU3ZTTHJlR3ZXaXZSRUZIVzduQTJRRlorTWhYZFN3d3FmajZ2eWlQVCtS?=
 =?utf-8?B?ajRtTVdQd1FGMXpuazVlQmhDVDFveXIyb3NVTi9DM2paMk1oOEVCaS9LNHJK?=
 =?utf-8?B?eG5nQWVTUVA4WTR3ZFZVSS9KQ3RwUEZNT2kzalc0M2pwcG5sL2pQdi9Gd2pP?=
 =?utf-8?B?dWQrWkI4NWtrMG8zeUhRTHpYQjRya1M2SnIvV01pZ1YvdkQ5NzVLeUxlS0RS?=
 =?utf-8?B?eDF5RzRzdTkrODZ0YWo4NnFkY1ZGWm41VXhHaGtlWG9HRXVXN1haOVFiYzg4?=
 =?utf-8?B?Q3BDZWNST05vekpXaGZrdzZKNmw5WU5qUXdGakVCQ2RjRUk2QjNnTVlUMnhy?=
 =?utf-8?B?SVNuNU1aUmFLT3Qwdm0vUFFTU0NVeERjV1hnTmU2MmlJSjNrVTBDMytmOFhG?=
 =?utf-8?B?QTIvVG5wTllTVkt6cjJsK0ZDUUwya2ZNWi94eng5UU9xWjlSdkxUWHo0MWhE?=
 =?utf-8?B?LytpWVlscU5xNXV6MHc3WVlkNk4rcHVMUVZZL3d6MW1ON0JRSGZscG94UU1I?=
 =?utf-8?B?eTkzQmxiR0xjQWp5UmxvVFVYQ0prN1lBT0YxeW1QSWxOTFNYNGV0V1ZQd3dV?=
 =?utf-8?B?SE5MeTdxbklWNlFVUndiVnZMcnJENjlHSEhNVWY4K09QaDVuNU1JbkViYjkr?=
 =?utf-8?B?bUJBRDNFS1dqV0ZVYzJXRnZPblJxVkZVRkRpVFhqdFJXMlpUeENOTkpOOG9i?=
 =?utf-8?B?WGdraGlyNmJkVkdEbzJkY0JobzVVcVJwL1BMSjRBejAxUkRDOWovdWJXRWdL?=
 =?utf-8?B?TzNFVWJFVjUwT2JURERsdjROVWlnckhsS1Q0NUtXMTVoWFNvcFRDTnRoVk85?=
 =?utf-8?B?c1JxdlRZWnE3Vkk3YTczZGN6QXl4SWRLb25wUGFQQm5JVDFVTTF0R3FpZHRa?=
 =?utf-8?B?RGhvWkFFeGNudjFvYnhIN1d1ejExdWo5ZnhVTVFrbm54cStPeEFFT1kxRXFN?=
 =?utf-8?Q?MJe1c+BMSPUMLV/HoXsXMyFnz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <921D9922C691F546971062BBC237F6D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8fb343-f4a5-45af-34e7-08da81be2e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 08:38:24.5591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/Qg87PO3Q/khobiuEPevYAPhYnflQfctzzitf4uyTewKhByBMTLrsuqf68cLKUj81SDkYOnIVi/zrntUpcGrRR1hZijtIPEb+85lyXRGqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3354
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTguMDguMjAyMiAxMTozOSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IE9uIDE3LzA4LzIwMjIgMTA6NTUsIFNl
cmdpdSBNb2dhIHdyb3RlOg0KPj4gQ29udmVydCBhdDkxIFVTQVJUIERUIEJpbmRpbmcgZm9yIEF0
bWVsL01pY3JvY2hpcCBTb0NzIHRvDQo+PiBqc29uLXNjaGVtYSBmb3JtYXQuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+PiAt
LS0NCj4+ICAgLi4uL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwgICAgICAgIHwg
MTkwICsrKysrKysrKysrKysrKysrKw0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQv
YXRtZWwtdXNhcnQudHh0ICAgfCAgOTggLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwg
MTkwIGluc2VydGlvbnMoKyksIDk4IGRlbGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0
LnlhbWwNCj4+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQudHh0DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsYXQ5MS11c2FydC55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwN
Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmNmMTVkNzNm
YTFlOA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4gT25lIG1vcmUgdGhpbmcgLSBJ
IHRoaW5rIHRoaXMgc2hvdWxkIGJlIGluIHNlcmlhbCBkaXJlY3RvcnksIG5vdCBtZmQsDQo+IGV2
ZW4gdGhvdWdoIGl0IGluY2x1ZGVzIFNQSS4gTUZEIGlzIGp1c3QgYSBMaW51eCBuYW1pbmcvd3Jh
cHBlciBkZXZpY2UuDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCkkgd291bGQg
cmF0aGVyIGtlZXAgaXQgaW4gdGhpcyBkaXJlY3RvcnksIHNpbmNlIGl0cyBjb3JyZXNwb25kaW5n
IGRyaXZlciANCmlzIGFsc28gaW4gdGhlIG1mZCBkaXJlY3RvcnkuDQoNClJlZ2FyZHMsDQogwqDC
oMKgIFNlcmdpdQ0KDQo=
