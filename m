Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE7532621
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiEXJIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiEXJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:07:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808CE8AE55;
        Tue, 24 May 2022 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653383277; x=1684919277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BtpxMMnupYkHx8WoHXf53hXBNIAbH4rx8lCkV1DIYb8=;
  b=Xxgp0MZmY/BLSBAHMgh038wamZJRXTj+UODUr++Jv/o+/xt4bzh6GbDH
   Ts0BPg4xG8S7TQNSuu+ZZHEzLy6f7UTGkrisfdhXUagbykAGPe/zhJjuZ
   jQUiAxxLvtTpaaIKjcXvUytk8l6ZMP5EPmWVKxBu59xMpCXy2TB7bRQ+5
   U6vLfEBxrQWoySPoxeDedsFR+s7Btb2E+OO6w5NPA87WLdRh6l7l5FJxO
   Ibefq3e2oa9RtpwgsiUKi3n9EAwCzo2N7X28spwWYlT1y4PjW/uoc2jMF
   8EI7U5naW6DHlC+h231nJLtb0o6kyT+en/vc1keWX79ZqTP+cflYfNvSZ
   w==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="157324943"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2022 02:07:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 24 May 2022 02:07:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 24 May 2022 02:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b57Vn/8VEa+MHO1FCCdklMd8B2rb3Kj/EBExyMc63w9wBB7rpvFv+ggUspeO1xuNRSdbpMDTktqe2+Tk+vTjrxnN/DQV2+thcTcVzKXJh1Ys8IGqNwTSMhlHgjAOL4zMwOdwEU2ykzo0QRNQNSlo9j1WFeXSdyoNgjwdQTG/4i/e/PFO62y+8brOLW25n7XvGrxEZxpDBi3VU+Y7BGZJQKrV4RnfkIFw5Hc8MivipZ+PYs6TPPSvreOBHGnd+bVVhYKrZK8HBNMFI+y5/sMZ7ehPCma8vuuFY+m5YRDsoqvO1GFfjSsAxaLtLidic2cN9UJHeuFS/ztV9UXc64gUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtpxMMnupYkHx8WoHXf53hXBNIAbH4rx8lCkV1DIYb8=;
 b=MUczPa4L8lNBJtx9pYuuQNSGdfncgQP8f4xOS+ITR7wBT1TaRzM6tfTCg41o5r9khXwTcgVaxDYicv5T4282nUg9y5x0jMs9ZhXnj1cnQ3t26GB9DJGkwOn8byqd0mIAQCSoaN6m1O+thPSLn2ga5xs6n3rX43MENdPQbw87NNXkESbW0KdA0zDuscRvSnCIT3b8yqYfLNBz5oRW6gh3QTUOZ0ouSlHaUSsM6xwfmx3pHWsvTm6Z2MbbEA2m81lULd5dib9ndlYVrLW4inkIfmaUcSv6AR4RHIMxZSVogS60G2OmRy5E3ObTuXLV808hg+RGIRcl7fbAd2hBHHOM4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtpxMMnupYkHx8WoHXf53hXBNIAbH4rx8lCkV1DIYb8=;
 b=SVAl5SQYe2vbIl9shO22ldmo2KZy2/k5arfDFolxw6anOAbziCHM1OpK4eIsRO7xtvjKOM3EuECNWkg5ey5ufUqXzaws0Tk+JGKgHEMld80PMY53YeHXIRUNenlfYArl1mT83K3IMYvFUE/K49i+jEZ8ZsBFiLFVSRlch7TEwOU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB5939.namprd11.prod.outlook.com (2603:10b6:a03:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 09:07:54 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::816a:10bd:7c5e:355b]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::816a:10bd:7c5e:355b%8]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 09:07:53 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <broonie@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
Thread-Topic: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
Thread-Index: AQHYb03AEFKWREbvSkuCYAxCaZRxlA==
Date:   Tue, 24 May 2022 09:07:53 +0000
Message-ID: <a4ea35ec-38c7-b3c9-b0ee-6cbd822a53f9@microchip.com>
References: <20211214133404.121739-1-tudor.ambarus@microchip.com>
In-Reply-To: <20211214133404.121739-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78837d24-f8f1-42f0-c661-08da3d64e2da
x-ms-traffictypediagnostic: SJ0PR11MB5939:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB593926BB381FB747227E99FE87D79@SJ0PR11MB5939.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D294gbXgjsXgsJ72vOzowK9qYPHYj9dvpBNJ1ZLtHQZKspsRLMi5GSQsuANgEAlrs52F48WAIE7cBoFmRQ6chl6TjeUG1ECMGPCMw2c4CGVj1qnd0mU4sUZvK3WPthsPUCny9lqkdT2syp7bXBT08BMvIGPAQI4LF9z7TtdNTz1lAPAXax6L5n2mS/2QeR2JAdb9qNH2Fpd4FNm1KtpPrGyBe9j3em+8Ee2HH5/Penmme2qlFmXFzyOttWuT8TahXafgeG4BvtjcGXrD2Aq9lc5Bl2fhUm2927CoWqZ1ncwFMCeFrynFZ+tKbFT+CnDgZh3P0FoFxXwJMxfADkcy7jKOhett0+E/CHK7LGhjd2esU5aQKnie+BO1wXbvnIhR5BH3jGOSPUk7zXbM1Ag3nMgBUmRqXJqmWW+5WuzMI7H+7Vg3gyOKtuYuoGDq/dgWU5lduAz8KD7S1/Bq1jnhHVS1TnoICBKbKkD/FWudBDGswN9ikEg50VNNKMoBu2NYnlqSrcFxHsMmNHaB191B4fY3SBUGUEUo5yMJCsvgtdSoLSIX8pIgIAbvV+C2Z8e/bfWHnAyUhgDFke2ZbKE27OEaKMcNNrsVu1tIKaOYeF6XfD/mjGE2Z1Na2XY2EoQpSTKMzeTtbigD8HooTyNDpdAxSmCnUpXUzk6Vmc5COlm6wRRubZxnUi4jmOYPVzF/NXjNm6cSbHuIGlenGZi5yhPCcII5hob8k8ZIo9pIvrTk6vHaLR7gMZCxZ52eK4uZLhkNhKMxApkb5UQhYb6flNQJHugWQKUTmh3pnUYLYfQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(64756008)(122000001)(6512007)(8936002)(26005)(31686004)(71200400001)(508600001)(316002)(6506007)(53546011)(6486002)(110136005)(54906003)(36756003)(38100700002)(31696002)(91956017)(2616005)(76116006)(186003)(86362001)(66476007)(66946007)(66446008)(66556008)(5660300002)(2906002)(38070700005)(4326008)(8676002)(87944003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y09xelhJOGhJMFdhQXF3ellyWWFvdVFnZHplb2wvc0FpeXNkcEtOQ3FSVlYw?=
 =?utf-8?B?UHlUTWUvOUo2ZjhhT3lpVW1LMUN3YVJydWkxbmdRRHpUNyswWnFHUlFVaVl0?=
 =?utf-8?B?ckFCTGlRRnAzUmU3V3B4WW1HL1p2RkYvV2pkaE5BOEdpRGNBL3NTTmI1dm1L?=
 =?utf-8?B?R0p4a3QwK0J6TFBtdWppWUNjLzA2N01pMThrai8va1dWd0trVmhWRlIvVXB0?=
 =?utf-8?B?UlpsWS9UWWZOci9mZk11cVBNOEFIb3lSN3dJb0ZFMnpjQW13eFZ5cEJrRWMw?=
 =?utf-8?B?YmxXTkcxM2kycENmdURRSGE4M3ZZbmVrays5bGM0ZHJmd3VCeTgxdWszUkh3?=
 =?utf-8?B?S3lMTGNUL013RE5OKzBzZVVOTUVJZ0sxT3NocWF5WCtDcEJsY1dscDYyaUFl?=
 =?utf-8?B?Q0R2VDgxTkFGelN0Wm5zN0VhdThPMi94VEEwWUc3M0M5Ukh3WnRpaURPaXM3?=
 =?utf-8?B?N0hqTXVCdVFyb0pmT2s5SkR4Z0ZqTm9lbmRxdUNWTEFwcEJxTTE3NkFUWkRE?=
 =?utf-8?B?SDJvU2pqOGFUTzdCOHNxY1R5dVhXVDA4cFlTMXdJeUFFNnJRRE5QYU4vTlVs?=
 =?utf-8?B?M2R0ZDVoU05aaTBzSW9ocHVSL3U3d2hFRTFVSTRYNjVpcitvQXhEczFka3h5?=
 =?utf-8?B?QWhpOW8xUzNPMXJrUms0ZzI0VkRRSWNXaHFUeVV3TlBUVzB1YmR4UGNuZWky?=
 =?utf-8?B?WCtvRWhNdWllVGw4T0RWUmIrRXR2ejBnK094SVhHcmtqKzRkRUJrcWs5NDMz?=
 =?utf-8?B?M0Z3TW0wN3NYSWtPVnI0aW13cHc1T011V01ja080Sld2dldjTUNST3huOVJo?=
 =?utf-8?B?NTErUTlHM2padURXSG5yQTk0VkFhVnRqbllyT2E1VDBxVE9jSStzWTlZWmpx?=
 =?utf-8?B?dHYxNFdNa2YwQW9EaDNhWTEvL0JiL1VBaS9Wcm45YU9TRi9XRCtRNWxGZXhE?=
 =?utf-8?B?eU1ON2VWTnJZaTBYTUNXQ2RHT2dhRFhmU3FnWkEycGZCNS9GUWFOQ0paN3pn?=
 =?utf-8?B?VmNINC9UYXNHWnJ5SENiK2x5akYvQkhwK3hPS2FzV050ZjZ6bTNLRnFCY0FQ?=
 =?utf-8?B?Qys1Zlh5cHFhVFVpWTFCQ3NsbjBBaHV5ZDJIMGtRcWx1aXF2QnpTbHFaeDBk?=
 =?utf-8?B?YkpXbCsvV0NhbnhKdDJSZm1WOU85ZUhKYTJXL3hZaktaOFg0TEhnZU5OV0p1?=
 =?utf-8?B?NGozWDBDV0M3TnBocjlsRnhaVVZ2aUJpOUVOVW44MXgwdzAwR2xPV21KM1Ri?=
 =?utf-8?B?b291UDI5NlZWcytGSG1NaDNwd0xFS2RIcnpIbms0Nm9XRXVTVlJPTUlhaFRQ?=
 =?utf-8?B?Ym42WkZzTmJYWDNibE9sVktKK1RFdVRHVE92YmYvQ2hWM1gybCtReGdEb0JT?=
 =?utf-8?B?Z1A3N2g4eE1raGczaEw3akFOajZIbU1oZHNZdE1xQ2dleDVselVHVVdLK1lr?=
 =?utf-8?B?OFNiYzcxWnRldWhJVWxzNWJVNU1hQ05kQXhETXBmTmhrOXYyWXVBeGY5WTA5?=
 =?utf-8?B?UEhHcXVEdGF3cURvd25RV21WZmJocXJ0QTJaNG5IdGw4ZVNySlcvMjlQcWxj?=
 =?utf-8?B?V3BCNm5Tb051RHVzSGxUbkp0WGh3a09UTGRlTlBPNnAvSDB0WFlmNnNEckg3?=
 =?utf-8?B?UFVEVVFwYUFQc29XcGlDSko0a2wvd01Ob0t6Z1FIZjF0NVorL21mQ1J5SWU0?=
 =?utf-8?B?R3JtS21DSWhSUjc5OGVKa0dOQ0VwQWhoRFV6Nlh1ZTNBL1JLN2szK2JpamFt?=
 =?utf-8?B?OW1lcEo3SzZTREh3L1RwVjlSbmZnZ1FyUDdyMWwzUmVUZFNqSkFGd2VnZGpp?=
 =?utf-8?B?OUpWZzFBMWkyN2tEeFd4bzg2NUFWaThIOCtJVU45S21nZ3dOekVUbWJveHNU?=
 =?utf-8?B?Tll2M2tWWmRMbDkyeDI2TUVYbGRFcTNTMlJFQlM2VTNRQmRnbjBENGJleUo4?=
 =?utf-8?B?Y2dYVmFjc092Nmh6ZkZKSndZaStRQm5iQ1B4a2NFZGpEREd6emJFcnNaMHNq?=
 =?utf-8?B?SmU4WE5uWVVweFp4TStZaUg3U2lOS05na3R0SnlWMFZEZnF6VmsxLzBaSUdN?=
 =?utf-8?B?WGxYSnNKS0NyMGpVVHFETDAwRHRmTy9OUy8zRGFHWlJCU25udldmR0hZWU55?=
 =?utf-8?B?eUN1anVSUUNvay8zR0F3VVptV3A4YUhrQlRlemtLQitIK0IwV0N3VXh2TlI2?=
 =?utf-8?B?SWh4Y0ZzWkdmK2xZWXRXNnNublg0emJ2MlRlRlcrd25hUW82VzZnWjVsS2Qy?=
 =?utf-8?B?Q2ZXZ0pxN21FOWlDU2d5SUQwUmQvRGFrWityanZHMEEvTHZBOGVEYmY4elVy?=
 =?utf-8?B?bzNHVU11ay9ja0VaRkRSbUxTNmxrN3hUTWh3YWpDSGQ3ZFdmZG9pK1BLbmxp?=
 =?utf-8?Q?+IMvUiFB5t7Z8Ei8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2507F267CD06E478887A8AE3C3AB106@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78837d24-f8f1-42f0-c661-08da3d64e2da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 09:07:53.7733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hW9iuCFRjQLy1YMhHc9kSt1Ku/Pva7WJtmdIrxebcy+C8pZdQc2ZegHN91aJ7dQKLxZfP+7PAWQLuZTM75ldVHl5BFdTToklIbGZuK8BnMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5939
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFR1ZG9yLA0KDQpPbiAxNC4xMi4yMDIxIDE1OjM0LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBzYW1hN2c1IFFT
UEkgY29udHJvbGxlciB1c2VzIGRlZGljYXRlZCBjbG9ja3MgZm9yIHRoZQ0KPiBRU1BJIENvbnRy
b2xsZXIgSW50ZXJmYWNlIGFuZCB0aGUgUVNQSSBDb250cm9sbGVyIENvcmUsIGFuZA0KPiByZXF1
aXJlcyBzeW5jaHJvbml6YXRpb24gYmVmb3JlIGFjY2Vzc2luZyByZWdpc3RlcnMgb3IgYml0DQo+
IGZpZWxkcy4NCj4gDQo+IFFTUElfU1IuU1lOQ0JTWSBtdXN0IGJlIHplcm8gYmVmb3JlIGFjY2Vz
c2luZyBhbnkgb2YgdGhlIGJpdHM6DQo+IFFTUElfQ1IuUVNQSUVOLCBRU1BJX0NSLlFTUElESVMs
IFFTUElfQ1IuU1JGUlNILCBRU1BJX0NSLlNXUlNULA0KPiBRU1BJX0NSLlVQRENGRywgUVNQSV9D
Ui5TVFRGUiwgUVNQSV9DUi5SVE9VVCwgUVNQSV9DUi5MQVNUWEZFUi4NCj4gDQo+IEFsc28sIHRo
ZSBRU1BJIGNvbnRyb2xsZXIgY29yZSBjb25maWd1cmF0aW9uIGNhbiBiZSB1cGRhdGVkIGJ5DQo+
IHdyaXRpbmcgdGhlIFFTUElfQ1IuVVBEQ0ZHIGJpdCB0byDigJgx4oCZLiBUaGlzIGlzIG5lZWRl
ZCBieSB0aGUNCj4gZm9sbG93aW5nIHJlZ2lzdGVyczogUVNQSV9NUiwgUVNQSV9TQ1IsIFFTUElf
SUFSLCBRU1BJX1dJQ1IsDQo+IFFTUElfSUZSLCBRU1BJX1JJQ1IsIFFTUElfU01SLCBRU1BJX1NL
UixRU1BJX1JFRlJFU0gsIFFTUElfV1JBQ05UDQo+IFFTUElfUENBTENGRy4NCj4gDQo+IFRoZSBP
Y3RhbCBTUEkgc3VwcG9ydHMgZnJlcXVlbmNpZXMgdXAgdG8gMjAwIE1IWiBERFIuIFRoZSBuZWVk
DQo+IGZvciBvdXRwdXQgaW1wZWRhbmNlIGNhbGlicmF0aW9uIGFyaXNlcy4gVG8gYXZvaWQgdGhl
IGRlZ3JhZGF0aW9uDQo+IG9mIHRoZSBzaWduYWwgcXVhbGl0eSwgYSBQQUQgY2FsaWJyYXRpb24g
Y2VsbCBpcyB1c2VkIHRvIGFkanVzdA0KPiB0aGUgb3V0cHV0IGltcGVkYW5jZSB0byB0aGUgZHJp
dmVuIEkvT3MuDQo+IA0KPiBUaGUgdHJhbnNtaXNzaW9uIGZsb3cgcmVxdWlyZXMgZGlmZmVyZW50
IHNlcXVlbmNlcyBmb3Igc2V0dGluZw0KPiB0aGUgY29uZmlndXJhdGlvbiBhbmQgZm9yIHRoZSBh
Y3R1YWwgdHJhbnNmZXIsIHRoYW4gd2hhdCBpcyBpbg0KPiB0aGUgc2FtYTVkMiBhbmQgc2FtOXg2
MCB2ZXJzaW9ucyBvZiB0aGUgSVAuIERpZmZlcmVudCBpbnRlcnJ1cHRzDQo+IGFyZSBoYW5kbGVk
LiBhcS0+b3BzLT5zZXRfY2ZnKCkgYW5kIGFxLT5vcHMtPnRyYW5zZmVyKCkgYXJlDQo+IGludHJv
ZHVjZWQgdG8gaGVscCBkaWZmZXJlbnRpYXRpbmcgdGhlIGZsb3dzLg0KPiANCj4gVGVzdGVkIHNp
bmdsZSBhbmQgb2N0YWwgU1BJIG1vZGUgd2l0aCBteDY2bG0xZzQ1Zy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgfCA5MjEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgODY5IGluc2VydGlvbnMoKyks
IDUyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1
YWRzcGkuYyBiL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KPiBpbmRleCA5MmQ5NjEwZGYx
ZmQuLjg5ODBhNzI5ZGQ1MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNw
aS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KPiBAQCAtMTEsMTEgKzEx
LDE1IEBADQo+ICAgKiBUaGlzIGRyaXZlciBpcyBiYXNlZCBvbiBkcml2ZXJzL210ZC9zcGktbm9y
L2ZzbC1xdWFkc3BpLmMgZnJvbSBGcmVlc2NhbGUuDQo+ICAgKi8NCg0KWyBjdXQgXQ0KDQo+ICt9
DQo+ICsNCj4gIHN0YXRpYyBpbnQgYXRtZWxfcXNwaV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0cmwg
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gICAgICAgICBzdHJ1Y3QgYXRtZWxfcXNw
aSAqYXEgPSBzcGlfY29udHJvbGxlcl9nZXRfZGV2ZGF0YShjdHJsKTsNCj4gDQo+ICAgICAgICAg
c3BpX3VucmVnaXN0ZXJfY29udHJvbGxlcihjdHJsKTsNCj4gKw0KPiArICAgICAgIGlmIChhcS0+
Y2Fwcy0+aGFzX2djbGspDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gYXRtZWxfcXNwaV9zYW1h
N2c1X3N1c3BlbmQoYXEpOw0KPiArDQo+ICsgICAgICAgaWYgKGFxLT5jYXBzLT5oYXNfZG1hKQ0K
PiArICAgICAgICAgICAgICAgYXRtZWxfcXNwaV9kbWFfcmVsZWFzZShhcSk7DQo+ICsNCg0KVGhl
IG9yZGVyIGhlcmUgc2hvdWxkIGJlIHJldmVyc2VkLiBPdGhlcndpc2UgRE1BIGNoYW5uZWwgd2ls
bCBub3QgYmUNCnJlbGVhc2VkIGluIGNhc2UgYXEtPmNhcHMtPmhhc19nY2xrIGlzIHRydWUuDQoN
ClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQo=
