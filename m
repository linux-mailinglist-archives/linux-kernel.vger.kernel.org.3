Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE3530C31
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiEWILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiEWILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:11:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF4EF3A;
        Mon, 23 May 2022 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653293458; x=1684829458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z0x854vRJbbjhg6Vec66LzHOkuQ6s8aAy7dgKq9S/y0=;
  b=hzqLpGJqquoiX46+dV6Qx+RVNiKH4EuCbsR5JYjd16Atsd6lj98sb/pr
   +y5Z+GAYSizM43Q089Fq2Ju2vdouSvpewC2af3hf/tKZMU3S2JyyoFlKC
   mq/z0ZKVZ3Eg7mKu12rx75dS79UIoOvqJTpzujrLOzC76NDLwYIvyT2tI
   LmSCs3Js5b45DbNGlmOiYk3Cd8Lb5NB1I7bgVucqA78NGEVQve5oyCTgP
   Q7vqwO36tY44N9gAuchf/snSI8Kn+XxRK/tH070aP53lyWU0OzgxedinN
   eVljm4JY966CPGzPHaL3FIy7lOfqHbyF74KqIY2SBsYwazCuVQyFqU7zU
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="96882395"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 01:10:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 01:10:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 23 May 2022 01:10:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsZB84K1xDVrRCQOV3H9xL+WlPr4dgWb55Zy8+DDedypUJuDwXhYdD+ieflu7u82u7jEhspa2IXeQNu6al6qAZx0p8vDfB6GqK2cv7yHmlvYAdHPt5bbinZ5oosLstKlWHitsdumwX8/6QJooD8Ul2c22u990Y1BWZtHfeSHZGL6ssT5v1MTq3Lyl7AG3hAUweL5zpDa1Ixab8a4835YJU18/Gnop9jFuEzwNP0q1G4SeyyoSew258Hzk4F4wty6VQXB8osqoWpa9cnDgZOvDu/NXb/proKQ1Sj/p+bq66TekAFJvawJ41AIbCi9pQJ1vjMmUBjQwr8L1+f4SApM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0x854vRJbbjhg6Vec66LzHOkuQ6s8aAy7dgKq9S/y0=;
 b=jQnYBQSXUhX43JHpWepJXjLkzNbHRlLmMSgYFxnxJgZeOm2s8NOJz3kkD4exQ4OjOV3Ao6Bb/23xi2h0TJdxk7OegObRokYzFQasMwkJ3AndNjNeI8EFnw9Yi51xCbJr/MTl8BQc6iTnZPN6NAAwyIORYqag+PJ9KKWC307+GK7TPEVDXE9LOWADUMpBDlC06x3rak5HGImHayrRlxv/9Ju8kqUVjJXVE6TXOXYpbMJi9XRp2m0N4tj+7VNu7SgzADQ651oXNlh/3XQt5VwXn/ad0NcljDupsKTKdq1K/LwenTVpmkSglQk6sfaIHsdpGfDfaiB/KaIPn5dE/rF4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0x854vRJbbjhg6Vec66LzHOkuQ6s8aAy7dgKq9S/y0=;
 b=SbbX+1ZGWlWHrQmLJsApt5l7SSQ/seKouallpAUz0XOakRtsLFyBaD/oLZtCj8/f/Qlsa8JB0BZlH1R19tSUfXCtFGJyeoOoKqoPtQbz64pthd9ic4NPSxk3+adzZA2TIr1nGbWqZf9odepytwnp8jIu4Z7mGL+8/xwjKHeKQdc=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB4990.namprd11.prod.outlook.com (2603:10b6:a03:2d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Mon, 23 May
 2022 08:10:52 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::816a:10bd:7c5e:355b]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::816a:10bd:7c5e:355b%8]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 08:10:51 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <herve.codina@bootlin.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Horatiu.Vultur@microchip.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Topic: [PATCH 3/3] ARM: dts: lan966x: Add UDPHS support
Thread-Index: AQHYbnyehwfMHp7pyUiVF3pJmm0BAQ==
Date:   Mon, 23 May 2022 08:10:51 +0000
Message-ID: <673f6106-6d0b-f8b8-9127-589d4891f782@microchip.com>
References: <20220520152335.352537-1-herve.codina@bootlin.com>
 <20220520152335.352537-4-herve.codina@bootlin.com>
In-Reply-To: <20220520152335.352537-4-herve.codina@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a377b47-b23a-43e1-5000-08da3c93c0bb
x-ms-traffictypediagnostic: SJ0PR11MB4990:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB499099DE60BDC72B0D0ED7EC87D49@SJ0PR11MB4990.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ungjYz6JdcuD6HwBKGZtAf7KGG5ob3kL3FONWK5jVZaYNxvV7uFYgo1edsq84Up7sojJSLZh1wAn4LZYLeQ5z86QzJZMA5RHzoTIGFDwLTP1m9Xi+lwz+sAmtvLQGNjWiKg95c+zBvLyGlhUdh/k9yz0aD1LQxR/uvXxqXTRZk0U2lZDgC0kTEa1AHTz9TNUxG/R/UkPKTp88SogokNiX9wLS3cnQAZelAo985CzaDRaG1bI2PgRf5Xo9dR8W2Xu0asva+mvlDCMAv/8zUb55cP7geEuyb9lfQxNRghlP6BMTPTCmOV4wNvYSyDtOZRx1Awhnj8LAHfjFTDgVIweniYxRwliTk4rtWJ5+5bnN0Wga6Y5+aCTii6N/EQrDrhWA0HugKpbhHHYeLMfE6htvGRWbSok6FmSJzhOq7YqMVBRxR9PLwB/bhHfNFbNYRM5gSD+iOY2QCG6G9yVTtJBCnTpIF1SLq/qZEGZHkpKXmiWVEy4D5opkD7cMDt42xyVgN6aUqfTLd4/NrEpe+c6FTgjRq/gJcnfBjXlx1rSe7umWfgB35TKq7klRCkNZsBhC3BW0V8vZVQRp8asNDZVL1pAXxmfsARGpA+LeiL/5jjA9qA5yfhcAvc5yZw9oTlmIv/BgkmVI/YJKEBph8UoNo6TnOnUovSygPjsv5uP5Gtwcbwb71kWMtr/4zX50KWnhpEF03gIykApIGAF2AFqjWgurBBHMr/6V1bdEbY5ylsPWwiBC2yTV72bXrTTgtwCEda3hTyDNehPyFZ8Od7ecQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(6636002)(53546011)(6512007)(76116006)(66476007)(7416002)(66946007)(122000001)(64756008)(66446008)(66556008)(26005)(6506007)(186003)(110136005)(54906003)(4326008)(8676002)(71200400001)(2616005)(38100700002)(38070700005)(8936002)(31696002)(5660300002)(86362001)(83380400001)(36756003)(31686004)(2906002)(508600001)(6486002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFBuSWcwZlJxeXpwOXNBV3N6U09kU01uN1A0M25rZ24reDhmNHE5eEszaXBI?=
 =?utf-8?B?ZlpEZmkzU0Yzdmt3V1ZvK1AzUzUwOHZyWktOZHA3T2lTK1UzZHBqWXBXVW5W?=
 =?utf-8?B?YmNFM25UcTlyaURzYWl0bDErV2NqZFVqOWpqQy9vWFgwNEtIRGVYaDhDUnll?=
 =?utf-8?B?cDlGK25TMkJWdWFLV3lSdTZnVGlWNUhOcFkxS2lJMWxZQTRoL092ZGplOVZx?=
 =?utf-8?B?UE5ZOGN3d1pPMzh1NFRtWlB5SWY1Y3FKM3JsY201WlcvQ21saEU3NkV6MlJQ?=
 =?utf-8?B?djRIV1hqaFhoWnU2TUF1TGM1SmRnM2RBMVVUckhTYXRHV1pycnJTVEJscXhC?=
 =?utf-8?B?QnJ1S3BiUmhhUkQzU0I5ZlhDUE93VnpTTlVyM0c3dXlzZGp6WWR2elpJT0hU?=
 =?utf-8?B?SVBQOVdpV2d6YkUrN2dUUW5JNVR6MlJ6Z3BhcVlBeVFOQWNTUFlwT3Fzam5Z?=
 =?utf-8?B?bExCM1dib0gzVnRIckdpZk5GdUpJcVU5SFo2SVZmdHFuTG9QczBGVGdBT1JR?=
 =?utf-8?B?elZxV0tTZ3YyTmdTeDREUTQvZWcyUXoyTWNFSmFwaGZJOXVJdXpHWVM4OWZH?=
 =?utf-8?B?NllBbEsrdThRbDFMVFhnRmdFTHhUYVpFYmVwb1J3SW5Sa2hMM3ZONURrZWpw?=
 =?utf-8?B?R3hqU05rUGxTUE9UenBwdXREV1pZcUcxVUtIODRhVGZMcnZMMnhBSjlMblRW?=
 =?utf-8?B?TzFMQTFMUjhFazBlN1ZnaitEYnBkQThlcGpuQXZPWkU2alVyMmJpN3pPRkdR?=
 =?utf-8?B?VFcxNkN2ZkdOUFBoSHVjZjdWcHAwcWd0S2RZRDIrSzFqeS9neWhGaFM5Wmcx?=
 =?utf-8?B?TWQ0bU12aGVldXUwZU1TWVVkZHk2a0MyckhXOGF2cjEzSmxQUGF2aHMyYXNs?=
 =?utf-8?B?UDdmcjdodExtcGloVjhHV3ZXVXdlY0FUQldydDNGMzAyVWNOTXBVSDl1Z3oy?=
 =?utf-8?B?dkNMa1dBalBBckJvOGNlRC9QT0NETVdoWDRRY01JRGFjRFFLL3dsNVhqWk4y?=
 =?utf-8?B?OTRsblprbjM2ZjUxdVM0OU0zL1pnQUhSR0N3SnhVTllodGFXVHhnUVZRSVkw?=
 =?utf-8?B?aFRhYm5LR3ErZW1nanhlaTdudzVUWm5xS29uaWFPdjdrSzJZWUZ6NGlYVE13?=
 =?utf-8?B?bnAydHFob3dOdW1RWUF0Qkd3VzRVZHFXU0Ntb3A1b1IxdGxyZVdObEpIaDJw?=
 =?utf-8?B?ZkVwYmovQkh1ZHN3ZkFqRjlLT1F0N1MrVmlINVRDNThKUnd2OFRGQXFoNy9r?=
 =?utf-8?B?NWFTempRdndGTHVlRk9XZmNCRnd5Nlkyd0NUOFFJeHpZMk1rL1MzcHhXQW5z?=
 =?utf-8?B?STRMVU53K3hGeU5lams3cjFUK2RnVmhqT0RHLzI5TStZdlVvUlFJNHhlc0Iv?=
 =?utf-8?B?Ykh2bmc1OEx2ZVkwd1lVWXBkZkM3SUJkRHFiYXg5eTJRZmVGeWlxeHQ4UWpR?=
 =?utf-8?B?RlpBSE0wNC9VZnpmTkoxSXVHYjRuZmhreGlySmlPbTVGZ1NTSkdrVmRQME54?=
 =?utf-8?B?dVNzNytUYkVIWUQzZWZiMmlwblZQMzRZM2ZWZWVzOXdRaXhIMU51NlYxZnhr?=
 =?utf-8?B?RlNVRWJlRU5tNXZrbEZzY3E4TlArYVgvc1RpNDZKWUZVUmpUR1FLbWVUS0Fl?=
 =?utf-8?B?b1hFZlZVOHBlc25OWlFnR01HOVJ4cVJodlNaczh0UENyaDdiWi9PMjJoendk?=
 =?utf-8?B?bFRqYU5GcERRRzQ1TzhGVW83NTNEa1BLcnU3YTlVd1JIaVZ4RWl5NFJ1VVZP?=
 =?utf-8?B?Q1pZc2IyVCtOdWNGMjJCNGwxQ0NmeWFpbnVMK2hZVDdFU1o4dlVkcW1UNDQy?=
 =?utf-8?B?R1dyUElwZUlBa2tNTzdOVE92MUN4elhCOEUyM1h1QldpVFdYSGFqd1FIanIv?=
 =?utf-8?B?Q2Rad3Z2ZFlYZmdabGtBQzgrUkhzUHgrYWxCRlE5eUpVb2J0Qi9BODlTd1hL?=
 =?utf-8?B?WFZRQlZHYnNKL3doZ3hsMXRlNy83bUh0QnVtR2J3STNNVTAyOS93MktJTFhF?=
 =?utf-8?B?VXJkaHo5VWM5VWV1Q0Fna3QxRTltTmdjaVVMdWRDVWtDU2NhMjJvMEFRL000?=
 =?utf-8?B?OXUyTFdPWFBtQXBEa05wUkF6eDFwYmhXczlpRTFNdHRVR2pyc3dGdkFnN3RC?=
 =?utf-8?B?ZzF1MHkzNzN0anpucXhvWUwrMDgyVDlNVFNjQlZ2VEM4OHJsZ2lzRkYrWHdm?=
 =?utf-8?B?ejVzVzRpdWVZSFlQNE5GdzI4cFpXSGs1VHFMcFpJNHJGWWlpNSs2d1FMSWdh?=
 =?utf-8?B?Mi9rYmNvVkl5cW9ERlkzWXZWeGxubEVWdC9vbnFRb1cwTVBuc2xKVkVNZVNE?=
 =?utf-8?B?Rk9HMlY1dW9vK0pIL1FYaWV0d1lTNHJuS0U0Zzc2ZngzUnpUTnJvUktJVVhK?=
 =?utf-8?Q?lI6S45JsV0H5SKuo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D19A67FCAEFCA84D9180C6D379CA0B22@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a377b47-b23a-43e1-5000-08da3c93c0bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 08:10:51.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQaPv0yr8SXwWsZDwu1rUTQLipvVvJEVKegFDEm2uhz4dZ1pCnAVZCZY1z1jE61VS62N29FRnDrAh2+44l3wiqiPEM0JRXqFpeNGDan2SpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4990
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMDUuMjAyMiAxODoyMywgSGVydmUgQ29kaW5hIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCBVRFBIUyAodGhlIFVTQiBIaWdoIFNwZWVk
IERldmljZSBQb3J0IGNvbnRyb2xsZXIpIHN1cHBvcnQuDQo+IA0KPiBUaGUgYm90aCBsYW45NjZ4
IFNPQ3MgKExBTjk2NjIgYW5kIExBTjk2NjgpIGhhdmUgdGhlIHNhbWUgVURQSFMNCj4gSVAuIFRo
aXMgSVAgaXMgYWxzbyB0aGUgc2FtZSBhcyB0aGUgb25lIHByZXNlbnQgaW4gdGhlIFNBTUE1RDMN
Cj4gU09DLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFA
Ym9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIHwg
MTEgKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IGluZGV4IDdkMjg2OTY0ODA1MC4uODMxM2U3MWVjYzM3
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IEBAIC0yMTEsNiArMjExLDE3IEBAIGNh
bjA6IGNhbkBlMDgxYzAwMCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ICAgICAgICAgICAgICAgICB9Ow0KPiANCj4gKyAgICAgICAgICAgICAgIHVk
YzogdXNiQGUwODA4MDAwIHsNCg0KUGxlYXNlIGtlZXAgdGhlIG5vZGVzIG9yZGVyZWQgYnkgdGhl
aXIgYmFzZSBhZGRyZXNzZXMuIDB4ZTA4MDgwMDAgaXMgbG93ZXINCnRoYW4gMHhlMDgxYzAwMCBh
Ym92ZS4NCg0KDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9j
aGlwLGxhbjk2NjItdWRjIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJhdG1lbCxzYW1hNWQzLXVkYyI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
eDAwMjAwMDAwIDB4ODAwMDA+LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHhl
MDgwODAwMCAweDQwMD47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8
R0lDX1NQSSA3NiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgY2xvY2tzID0gPCZjbGtzIEdDS19HQVRFX1VEUEhTPiwgPCZuaWNfY2xrPjsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAicGNsayIsICJoY2xrIjsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKyAgICAgICAgICAgICAg
IH07DQo+ICsNCj4gICAgICAgICAgICAgICAgIGdwaW86IHBpbmN0cmxAZTIwMDQwNjQgew0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxsYW45NjZ4LXBp
bmN0cmwiOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHhlMjAwNDA2NCAweGI0
PiwNCj4gLS0NCj4gMi4zNS4xDQo+IA0KDQo=
