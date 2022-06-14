Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B554AE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbiFNKls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiFNKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:41:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F7403C7;
        Tue, 14 Jun 2022 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655203305; x=1686739305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jwc5LjXpSXIN8oqd8KJ918LRvGRJOyjxTGF2N3x9qAY=;
  b=y1+Cav3InRQIo3WKNVJSgPaw9JSUYi9kIxACAIAh2Y4S5Xq2xj2AZgK3
   +iucqh6W7AJ2sS7sgvBa3sTlHIrKzqZ/IoKuKqCVSm1unTuA1mBs+Oo+1
   ptE5K/66+lc0J6+D/uUFvaCz/Quf6uGkkXRu28icM537IqOYz6bYtDDqf
   gaZNFJGbrsc82GwPy7TAmr5t5bSc5rHsK3aCBJpyIKLVi+JrxuJu3Yd8q
   pWg0cIwzhXlXeYdb8f4h2MNuOlyZqOpUSCXtn73R4y6bZj5BJhYv04rH6
   u9IQ52+7ZnwhYhoEeKFVT64sX3RV2JkNb2c5MzGD19xrS1WkTdNHOHaCp
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="163257558"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2022 03:41:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Jun 2022 03:41:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 14 Jun 2022 03:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un6zUPotqswud6SIFARJ1Q9pAYAxl13HYolBYi9ycw/hAnJk0Ox+MndJKR7PU/iYQEzrWZYxSC/XwxHBtUFwrDNr05Es7kFg8XwSDo/jUYaQStGCKGs5BLJ+ysi7rPZ+sD1SCngL4uKMC6MqAFNg/noH/vy36vxKpD3x3kIf5wFqB6JMe/pwR3JIoUiDs8DNd+ekMRtEbbE5LzylbPAMjmXegIolx+IoVLZXesiFO64g9LYD6UiB+xIHZ06r7PaY8MV2JXgXLsIkXBuV3+CaNoaO5DPAi61QiapKX2Gfu1ILUb73OlczRi7S0KaDkq6WxoirvVS05PY8rm1wzVw3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwc5LjXpSXIN8oqd8KJ918LRvGRJOyjxTGF2N3x9qAY=;
 b=TGQTiqIeXrLxfho7YkLVMtTzafleLPcZc/M++tJ+lKKqQqnKdOySuWaa52z4hgxn0o8lX97+49nij1BG3cGrQNeFrN0HNXqnBjJKHH/k/3QXaJGoMag0CnoeEGhgATYti2IX09sHUAcwANdFSbaRK5r89d5iCS2yG/5X9FQ8mZUvhidKApgqeWyiYzVnM/8t+jDf/E1WQhuTN1ZsEsPHRsvz9tmxiMb4npNOEZf5c3n1+4IbVtWNJMShIQATbdXVxBV299obcEu8Ayenh1sqArxIRTohR3HkunANzs71WBZubqNGXhFBR0jtei98ExniwC7YS+55GK1mZkPSxFPiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwc5LjXpSXIN8oqd8KJ918LRvGRJOyjxTGF2N3x9qAY=;
 b=OoQJYDCFrF3wVk191qakHSS0driyuYKWpul8iXoNpMwLIMC/exTLlRmCVfbraOXKTQRkw42i+0AqxncmBMQI06h2tBo17o90+gUUJGw6TRNMHNzCzXJS1eKY7ikkZQra9QtLbNVpntTp9hoaf1wAhrHtdB4Bt9N+oCtBATJd4xc=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Tue, 14 Jun
 2022 10:41:33 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 10:41:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jic23@kernel.org>
CC:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/16] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Thread-Topic: [PATCH 00/16] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Thread-Index: AQHYf9tQZsVcqDdJDUmBm+n3+swU4Q==
Date:   Tue, 14 Jun 2022 10:41:33 +0000
Message-ID: <e6f98248-97df-03d1-d41a-ba5466cc069f@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
 <20220611191629.2a0f6d2f@jic23-huawei>
In-Reply-To: <20220611191629.2a0f6d2f@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd4b4167-124b-47e9-1323-08da4df27310
x-ms-traffictypediagnostic: DS0PR11MB6493:EE_
x-microsoft-antispam-prvs: <DS0PR11MB64931274731A3591F09701B387AA9@DS0PR11MB6493.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9LNQA0eXLWYVh1wArQ70lTJylYE3lqoN1LSLmkJ42gQKiDvt6HzTu95OsAgJ/W/mwz81dCsu2WbmntgG00y0uzXLQeC+RZc5HzzAppRfYfzoxIoFc+y1hUm1rhGPao34zyCxyGDXdDsEs/s2jyp4SyvGK3KVWi2AjnaWYzZvUT12z6IvS/DrV/VdO5jcdRG/6/OOCT6+cWPASy/H4JELD/iy0AkxNaR7K+rKhl9bWlRGxkuoB8dfe+nCkEdOfMsqCNfCGItEoOziPp1bo2RNHbcn83wQyT753Qlgq6OEn+98PEavnMivw7PfiPSES2DeW2h7jdhotdjAVAK+MyzpT8mx4k2gMlb/3tIKJj2COm5iO7Bl1sPy5P5xdGvJgTPqTWKXVp8P9Ff46362U74vazdZ0R5px59ZVnBLhHBZn3RoMULQ8UoG5aOARYRV1Vpq2JPI+GuE4aRcLS0rOGyOpF9kBieNwvZFtYpQ5vBAS/8gp8buLV495byj+0fSj0xdVtyjU0dQuHEv/2e8PXZuPLvq8ntaDOF1A4JggToEVhA+kznLg7QVirj8WFjedxhbLHyia4htMtdKyTooqw0jA9AcEWwsKRL7r9fNV/dJRJwvvBOPLNCURTSkDOy0mKC3c5Hn4O8hwhOB8uCRyE5WtFn6brhGE4mT5C088Xg//LdWs+njzyrePSMJtpR0o64iS0zcP3s851Vg3/vn6D5Pse0JIoZBIPC7WvYs4L8DIXaNzbktHM2nv+zFbtmKmw1pZNS9giMKg2gPBb7p+yN/rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(31696002)(186003)(83380400001)(86362001)(38070700005)(6506007)(38100700002)(122000001)(36756003)(53546011)(6486002)(316002)(91956017)(508600001)(26005)(6916009)(2906002)(66476007)(2616005)(4326008)(66556008)(64756008)(66946007)(8676002)(54906003)(8936002)(6512007)(7416002)(31686004)(5660300002)(71200400001)(66446008)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3ZtR3dnMSsyRjFaUjJPNjR3aUpxVmNjVnJRR0tqeVU4eVVLbGlhbVNybE5C?=
 =?utf-8?B?UVhTcUY3NWJ3RWVhYk11MG02bFhxN3ZYc0Y3c1ArbTNoaHY4aVFXakZmR25o?=
 =?utf-8?B?SnFLOG1mOEhuQ1p0TGwrSEZwSnE3dVJxTjA5TUFpS2JlNHUxWDlScjJ6eUVE?=
 =?utf-8?B?RlRYV1JGaDFDTkhURjMvWDNpd0t1OVQ5bVBKQXY2cEFyOG9JOFZqWjZSakRS?=
 =?utf-8?B?K1M5TFlLY1hYZkNJVmJBSklGMFhpcFR6a1VaYU1DakhHUVl0MXUwaXJaUGR6?=
 =?utf-8?B?Q051bXdSdVJkMVZ6YWdGMnFUSDNoUEF2RTBVd3JhSWNELzNyWUEvTFl6UGpP?=
 =?utf-8?B?ZTViYjVWdCtIS3pVb2J3RlJvYnhtT3A1L2wrdkprTjNiZXRrWU5lRTJFNTEw?=
 =?utf-8?B?VHF6elIrNkgvUWZRd1k4Q29sNGhyaGVHdWI4SEVOZFBJSGFXc0ViMTRod1Iv?=
 =?utf-8?B?MjJQREtYQTZONkhyc05ER1lsTHVvYnFWMkJNM0xrSUY1Qkl2VGQ1Zm9pQlNG?=
 =?utf-8?B?UjJNais4U3NUdnpON09uRWNmMDQwT0wvYUtZVmdFWWMxT3k0TjhqcENMWFFx?=
 =?utf-8?B?ZXNRUG1XWUlrY2NUV3c2NU1DZGRRdFIwYWxJdWlML0VGcTF4MHQ1dWtDTUpU?=
 =?utf-8?B?K0pWaXR1SzlpOGo5TVROdEJsbDRyeDF3dHJVSmpyS2dSaVg5Q3pEenBFdW5i?=
 =?utf-8?B?TnZiNlA0SVV6UFc3cFV1cjlXcnN0cDByallERnpVYTV5aW9Cdnp0Q2Y4Z25y?=
 =?utf-8?B?TmVFeVBhdGVHeHBWSlphUlJ4RjYrNVk3NXVOUjFZN0Z1R2swSm4zMUJOY3pK?=
 =?utf-8?B?dVdYRzdOQ1hsM2JWMWR3Y09wYlFUUFY1V016Y0ZhdDlYRHh5UlhRV3lnNkQz?=
 =?utf-8?B?eG1QQU81azBlcnkzNFlDM3E1TDlsTkZPSHZoMVMvTlpmaHVsUlIwc1dyRXJF?=
 =?utf-8?B?cGpjV1AyK1dCdURQZDloSlFvNFRwQlZ1TVBONDRqWko2YXhZVFBXMWZWMk1i?=
 =?utf-8?B?QjVONW5iK2tIRDdEeVlycWNFcWsrcUM2MXNHY2FrNXp0T2Y2ZURhdy9IWjhy?=
 =?utf-8?B?MGtmd1J2QXV1QkkzZkxrZ01FTTdKdHZpTC9BZ3U1dmtKTkQ0Ukc5b2ZhN0U1?=
 =?utf-8?B?RmFreXpRZzNZQXl1UXo0RXZnN05hemNqeWxjMXpwUUdza3VoSkR0MFk4TXZZ?=
 =?utf-8?B?TFBsVDZhUnBhSnhCcW1RYlVzQ2tneU5tREU4azNaUC9QU1MySWNqdjRjMDVm?=
 =?utf-8?B?Z0lhSG9tL1hJN2RBYklJblU4MHlUbDZ3U0FYckFib1M5NDRrTnhCcm9oaVcx?=
 =?utf-8?B?WFArSWhpdU5ZdHNmbkY0NCt6M1VSelFlWjd1TGdmZkVoYzdlM2VlSTloUkl1?=
 =?utf-8?B?WmRKRUZnWU8zTkQrYVNWd1hTeVBrNGVpSnBZOTZoOUl3QUFTS2FLOVhXY3Bw?=
 =?utf-8?B?c3I0dS8wK2tsNHI3aVdPK25IRVBPWFpONThIRVNmOTFUeEdrdHNhN1JyTGt2?=
 =?utf-8?B?dmx6T3NIYWgwRG9OV2s3S0UyaWhJRmwvclJGblp4Z09LTFJ3MlhwbGZQY2NX?=
 =?utf-8?B?bDkrQUNLczg2VGJ1Q2w2QTUvV0xiMGNzeGV5VmJuTndFcXpMaTEvN2JMRDM3?=
 =?utf-8?B?NEtBdm1aQzZJQTRodTBGS215OEsxQzhuSTF5bUpFNE5UKy9YdDhCNnA2Q2Q3?=
 =?utf-8?B?NmRWVHhsVEJEdmt3ZjFHZE84NE91TFhDWW52bjhiVTFIeTJWZjhkVG0rTmlX?=
 =?utf-8?B?Rk05TnA4Z1M3RklsQnJ1dDdpME84NXJtVHZ5K3dHaGpib0YrLzFkUGQrRTlV?=
 =?utf-8?B?dmVSS0djUGptaXFYa2FUMUtVa2o3V1B5TlhHMVM4bjYweTdhYWVGN0VEUHEw?=
 =?utf-8?B?dnIvZGMzWDN3eU5hY2RSSDZOdDFFSFJrSzdockZJSVBIS0Fuc1JBUWxsMmR5?=
 =?utf-8?B?ZTlaMnZkSERwd2FKTnpiR2Vqam5BQ2xFYnhMQkl1SEpGSEJ6cU5veDl0azhm?=
 =?utf-8?B?NUUyRWFPcUlZZmd6amh0MjljaW1SZHAyMExWWHpLTmdjSHNmRStXQ3Bqckx6?=
 =?utf-8?B?L0Z6SlNWYjJ2cEYzUHN4N3Y3Z0dGVGdnWFlJZ1dUaXRZYlhQaHNQZDgvU2k0?=
 =?utf-8?B?K1VKd201TG1ZT3VkYnhuUGVmMThiME9MSXNXT0Y5UFkwdlZTOEV3N2xvZlAy?=
 =?utf-8?B?d2FlZ1NVNHFycGhNa3BtY1lOQjhraWR6MGxob1RHYU81b3YwVHRNcmJlSm1U?=
 =?utf-8?B?SSs4bWk0S1pBYndDZ25yYXIvSFd4aGdTbVJBaDBkdjJYU2duWmFMMWQ4UTAy?=
 =?utf-8?B?ZjNjNy9QaHd2ZUF6dkRZdXhrNWxtbWh3Nisxbnhqak53d25kUitUNEtqbjh1?=
 =?utf-8?Q?6dsaKN0OdsyE4/dE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0555FC2FDB570748951863B06BB6833B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4b4167-124b-47e9-1323-08da4df27310
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 10:41:33.3579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIz/3MFRSqMDuda213TzfdK7xtMOQdQ39gXPjKPZnP9x7IejMPSOXSyXny/aJOjMZlL294rmHbPVagkKzMel1mk37Nfmb8Ivb1NhTLDLnOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMDYuMjAyMiAyMToxNiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDkgSnVuIDIwMjIgMTE6MzE6
NTcgKzAzMDANCj4gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
IHdyb3RlOg0KPiANCj4+IEhpLA0KPj4NCj4+IFRoZSBmb2xsb3dpbmcgc2VyaWVzIGFkZCBzdXBw
b3J0IGZvciB0ZW1wZXJhdHVyZSBzZW5zb3IgYXZhaWxhYmxlIG9uDQo+PiBTQU1BN0c1Lg0KPj4N
Cj4+IFRlbXBlcmF0dXJlIHNlbnNvciBhdmFpbGFibGUgb24gU0FNQTdHNSBwcm92aWRlcyAyIG91
dHB1dHMgVlRFTVAgYW5kIFZCRy4NCj4+IFZURU1QIGlzIHByb3BvcnRpb25hbCB0byB0aGUgYWJz
b2x1dGUgdGVtcGVyYXR1cmUgdm9sdGFnZSBhbmQgVkJHIGlzIGENCj4+IHF1YXNpLXRlbXBlcmF0
dXJlIGluZGVwZW5kZW50IHZvbHRhZ2UuIEJvdGggYXJlIG5lY2Vzc2FyeSBpbiBjb21wdXRpbmcN
Cj4+IHRoZSB0ZW1wZXJhdHVyZSAoZm9yIGJldHRlciBhY2N1cmFjeSkuIEFsc28sIGZvciBiZXR0
ZXIgYWNjdXJhY3kgdGhlDQo+PiBmb2xsb3dpbmcgc2V0dGluZ3Mgd2VyZSBpbXBvc2VkIHdoZW4g
bWVhc3VzaW5nIHRoZSB0ZW1wZXJhdHVyZToNCj4+IG92ZXJzYW1wbGluZyByYXRlIG9mIDI1Niwg
c2FtcGxpbmcgZnJlcXVlbmN5IG9mIDEwTUh6LCBhIHN0YXJ0dXAgdGltZSBvZg0KPj4gNTEyIHRp
Y2tzLCBNUi50cmFja3RpbT0weGYsIEVNUi50cmFja3g9MHgzLg0KPj4NCj4+IEZvciBjb21wdXRp
bmcgdGhlIHRlbXBlcmF0dXJlIG1lYXN1cmVkIGJ5IEFEQyBjYWxpYnJhdGlvbiBkYXRhIGlzDQo+
PiBuZWNlc3NhcnkuIFRoaXMgaXMgcHJvdmlkZWQgdmlhIE9UUCBtZW1vcnkgYXZhaWxhYmxlIG9u
IFNBTUE3RzUuDQo+Pg0KPj4gUGF0Y2hlcyAxLzE2LTMvMTYgcHJvdmlkZXMgc29tZSBmaXhlcy4N
Cj4+IFBhdGNoZXMgMy8xNi0xMi8xNiBwcmVwYXJlcyBmb3IgdGhlIGFkZGl0aW9uIG9mIHRlbXBl
cmF0dXJlIHNlbnNvcg0KPj4gc3VwcG9ydC4NCj4+IFBhdGNoIDEzLzE2IGFkZHMgdGhlIHRlbXBl
cmF0dXJlIHNlbnNvciBzdXBwb3J0Lg0KPj4NCj4+IEFsb25nIHdpdGggdGVtcGVyYXR1cmUgc2Vu
c29yIHN1cHBvcnQgSSB0b29rIHRoZSBjaGFuY2UgYW5kIGFkZGVkDQo+PiBydW50aW1lIFBNIHN1
cHBvcnQgaW4gdGhpcyBzZXJpZXMsIHRvbyAoaGFuZGxlZCBpbiBwYXRjaCAxNS8xNikuDQo+Pg0K
Pj4gVGhlIHJlc3Qgb2YgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcyBhcmUgbWlub3IgY2xlYW51cHMu
DQo+Pg0KPj4gVGhhbmsgeW91LA0KPj4gQ2xhdWRpdSBCZXpuZWENCj4gDQo+IEhpIENMYXVkaXUs
DQo+IA0KPiBUaG9zZSBwYXRjaGVzIEkgaGF2ZW4ndCByZXBsaWVkIHRvIGluZGl2aWR1YWxseSBs
b29rIGdvb2QgdG8gbWUuDQoNCkhpLCBKb25hdGhhbiwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJl
dmlldyENCg0KPiA+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPj4NCj4+IENsYXVkaXUg
QmV6bmVhICgxNik6DQo+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBmaXggQVQ5MV9T
QU1BNUQyX01SX1RSQUNLVElNX01BWA0KPj4gICBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzog
bG9jayBhcm91bmQgb3ZlcnNhbXBsaW5nIGFuZCBzYW1wbGUgZnJlcQ0KPj4gICBpaW86IGFkYzog
YXQ5MS1zYW1hNWQyX2FkYzogZXhpdCBmcm9tIHdyaXRlX3JhdygpIHdoZW4gYnVmZmVycyBhcmUN
Cj4+ICAgICBlbmFibGVkDQo+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBoYW5kbGUg
ZGlmZmVyZW50IEVNUi5PU1IgZm9yIGRpZmZlcmVudCBodw0KPj4gICAgIHZlcnNpb25zDQo+PiAg
IGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBhZGp1c3Qgb3NyIGJhc2VkIG9uIHNwZWNpZmlj
IHBsYXRmb3JtIGRhdGENCj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGFkZCA2NCBh
bmQgMjU2IG92ZXJzYW1wbGluZyByYXRpbw0KPj4gICBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2Fk
Yzogc2ltcGxpZnkgdGhlIGNvZGUgaW4NCj4+ICAgICBhdDkxX2FkY19yZWFkX2luZm9fcmF3KCkN
Cj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IG1vdmUgb3ZlcnNhbXBsaW5nIHN0b3Jh
Z2UgaW4gaXRzIGZ1bmN0aW9uDQo+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiB1cGRh
dGUgdHJhY2t4IG9uIGVtcg0KPj4gICBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzogYWRkIHN0
YXJ0dXAgYW5kIHRyYWNrdGltIGFzIHBhcmFtZXRlciBmb3INCj4+ICAgICBhdDkxX2FkY19zZXR1
cF9zYW1wX2ZyZXEoKQ0KPj4gICBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzogYWRkIGxvY2tp
bmcgcGFyYW1ldGVyIHRvDQo+PiAgICAgYXQ5MV9hZGNfcmVhZF9pbmZvX3JhdygpDQo+PiAgIGR0
LWJpbmRpbmdzOiBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzogYWRkIGlkIGZvciB0ZW1wZXJh
dHVyZQ0KPj4gICAgIGNoYW5uZWwNCj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGFk
ZCBzdXBwb3J0IGZvciB0ZW1wZXJhdHVyZSBzZW5zb3INCj4+ICAgaWlvOiBhZGM6IGF0OTEtc2Ft
YTVkMl9hZGM6IGFkZCBlbXB0eSBsaW5lIGFmdGVyIGZ1bmN0aW9ucw0KPj4gICBpaW86IGFkYzog
YXQ5MS1zYW1hNWQyX2FkYzogYWRkIHJ1bnRpbWUgcG0gc3VwcG9ydA0KPj4gICBpaW86IGFkYzog
YXQ5MS1zYW1hNWQyX2FkYzogdXNlIHBtX3B0cigpDQo+Pg0KPj4gIGRyaXZlcnMvaWlvL2FkYy9h
dDkxLXNhbWE1ZDJfYWRjLmMgICAgICAgICAgICB8IDYzMyArKysrKysrKysrKysrKystLS0NCj4+
ICAuLi4vZHQtYmluZGluZ3MvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmggICAgfCAgIDMgKw0K
Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNTQ4IGluc2VydGlvbnMoKyksIDg4IGRlbGV0aW9ucygtKQ0K
Pj4NCj4gDQoNCg==
