Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC8852050A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiEITR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiEITRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:17:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B6353A57;
        Mon,  9 May 2022 12:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652123639; x=1683659639;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=RerzkWX5F4ZwExizs7aMZKOac6QUAfxzmJIjXXbrGrc=;
  b=gLD4m6JOpgOHrZrihg4RVy0tKmtEraZ0ZIENYUIvyAryhVYGQOjsA0y7
   +OBgqtDx3EZ05CkeUW37mXy7kzmsgoIqma2KSEQox0JZl9kmpMc24AShn
   I81AbFmSnSuOwUqQ1B1b5OTkFhxZxc/C78uto7DLXNHTqlb3xiUY2VVve
   aEE4jCsQrXRN8dOtF0Yo50hnf9aayyJhLu18jqTy5o2jM7t2IBCjPSyd9
   TsnjIGMcvOsKTWXSdkPhgUW/gYms8LXNPh8cGPFq+Ahke4pvta+o7lV4L
   J3aldCq0jIKMGjlt3/yYeUNP0fpFWzpGALq06TR+v2U1yUFr+JeP/eGHx
   w==;
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="158340436"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 12:13:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 12:13:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 9 May 2022 12:13:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bchs+pkuqZ4HbZ8f0MuYsrTZf/SDilv7OvK3W5b0aZGdu4KoOpo+i9wARfb/xYGwBzTsH3SsSE063gHrdGegmCNDIOZL/IR1SNEfWJvTkfauwM6GsL+CDhNx7fUDqCYE7a4M3UshPrY4uAk3AKlF7EB/0iGD7RvXVo0v5dF/kLIG1tt3sNp2HeadBxV46Jd1YSVlkT+ONX/48qCmF0RQRIfjDHoME3GVCNbV/zvmpDi7UDGhDpZv/QgRVK9dboY/3h5yrO8LhTBi24k4dP6wqkvgL6MWsZ9lEPvvM/xfv+76UgcLx+ckp+D05YET13bSnYvecOAKNLS5UAUga99awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RerzkWX5F4ZwExizs7aMZKOac6QUAfxzmJIjXXbrGrc=;
 b=Obo+5DOIRTBFPVHeSpZTLsiTZkKiTUiXwngMygdJK6klRmpKKinAtQWih31XniPzg3htC/IlYwVdxDRc+AbWVfHtuxc+Wyola8F1XNe9Ws+u1FRSo8+/BkBwrpL9tDRNB+mI3mLr4nPYbc3YxbbBZeNl7rkhyAeLZ14JklzZQt+E4tfXiQQySVITdHKdHL0ydKnj/aOcOTFA6OtjVNrKBp2beuawf9keFduYtKVljrhcsvKYdLbjkQFV1Syl6wzcW+bWTwRxSThTlzAQ8K6NvasXvZNZFgx8yyJ3uVNKUpENSeyMDjwzgAe2ul69Wtbl41YQFh6sfYid10ZxP2ZaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RerzkWX5F4ZwExizs7aMZKOac6QUAfxzmJIjXXbrGrc=;
 b=m+NfgpPeYg6DjXJwxeT0xfAiBovx95r1b9U2BfK3ZMMF4xKPrWmLqLIzUV4ufcjd0fjFIbhqbGrQSyHwTZaI3Ix9MUZCGSAvcxHNg3WL/kpqJw8fp/HadHyI/FpoX8Xd4a4h9TFyJIP3js0EX0mn3+A8J3vTbUHwYhrgWIXQy0o=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 19:13:56 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::8d13:edb1:40c1:b12d]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::8d13:edb1:40c1:b12d%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 19:13:56 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linmq006@gmail.com>, <mchehab@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <hverkuil-cisco@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] media: atmel: atmel-isc: Fix PM disable depth
 imbalance in atmel_isc_probe
Thread-Topic: [PATCH v3] media: atmel: atmel-isc: Fix PM disable depth
 imbalance in atmel_isc_probe
Thread-Index: AQHYMfu5n8UAijoUyUqrsrLblw9Tbq0XTeKA
Date:   Mon, 9 May 2022 19:13:56 +0000
Message-ID: <ab99de5e-fe14-6d1a-1fcc-d144a35880f8@microchip.com>
References: <8e4a35a4-1d8f-5aff-f577-2a2b87646528@xs4all.nl>
 <20220307081638.19733-1-linmq006@gmail.com>
In-Reply-To: <20220307081638.19733-1-linmq006@gmail.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eda385ff-27a3-4e2a-a6c3-08da31f0104e
x-ms-traffictypediagnostic: CO1PR11MB5009:EE_
x-microsoft-antispam-prvs: <CO1PR11MB500951CEA44FDAC55531702EE8C69@CO1PR11MB5009.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWlOwlIcDIb+j8WGYAgpz8Mj6YmShwjRgpSJ0X74+8GI95cXVpvbBVpRCksIL3OEUvbjLyW8j08rHAg+eIpkObBNBAuIVB1jkOTDOYJ7zo+uY3V2WujhSkZE8mzoh9jFtaH9ogY9cmQc0z+faiH1SdXV2qCJbJfQD1Zw+Gx4mzZyxxo9C53jVaLLe9o51kbru3l1RZOmSj7sQSctvb9fIrVh4dRaYfsHm1iAEERVHSK7HWoMXymBtKVOHslFX8g7BZOj3M8b2wkaZc/VLWOzIVQbAfqfXEUMsj9G9qkUZkv0Z7wWiXI5jrCcQIunVAiIjKc2JzpxtkS+5qHeQR/vDH6zdku9NH5/xl0j9/CIGiXrczRaNMKgqWuMHbviZddTbhsfBffkecH272LadOnbpDuh7nIuIKAyQLyXi7xLRfcXq+YU6giCY5b+KRdW1dtTLEDy/1O2LoJjfAjTD8iI3GAKYzU4p7TQECQ770OTWUkwLQza+V+8YtdSGLqBbKsEQIJW/E+LHMo9dwfMv9RpC7FSLeFFmceiac2ZP20Y9QgkNnBg2+Kwz0z00vG8R2tCck/v0DVab5CUGbAtdEM7u3SAjRJxPtLCVIMw+8dqo8couVgEfryZj7mydGvrwZbuD9+QSmIFL+WoKjTMMkNjIBftRzZq0ik7JggX/6g4Ibc0+235X5VpT2t47KnskINkE9fdoC4syYGuAgK362HI54JE3XT8cefaWlOtcv9YbnCfea3i0PE4Ksy4Y//p3qusCvZMBqS/1ozZINjWbffzlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(508600001)(38070700005)(8676002)(66556008)(76116006)(6486002)(5660300002)(186003)(36756003)(31686004)(83380400001)(66446008)(66476007)(8936002)(91956017)(110136005)(316002)(64756008)(2616005)(86362001)(66946007)(26005)(71200400001)(122000001)(53546011)(6506007)(6512007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHF4OEdHSVV6VTZUaVd0ZGdWTTNkRmV0dndkb2U1NmhwREk0dkhhbjhGTUt2?=
 =?utf-8?B?UWxTVE5mbWlncStPMVMrNUl6OTlicDViTjdLeXo3UDFOTXVBNGd1NGdpZDBv?=
 =?utf-8?B?WFQyNzBtbmQraW9HNmI1bnlSQ3hBQy9NTHpscEtrTWVlNzVJb3UvSE92Slhk?=
 =?utf-8?B?a3pVOFVhSEVsU2tPRkhWUHB0M3F6Y0tRNGJiMW1LM1JPVmxGQ0hpMDNUVHVw?=
 =?utf-8?B?emMvb2VvR3JMNStzRjI4SXpIMnEzeG4wNHUyNHA5Qy9CMVFzbVRtbHBQYUVx?=
 =?utf-8?B?UFF6ekVoTmZOL3hYalZQdTdhOCtLaXB0d1FPbmxsbThqVFNvMzJKV2JucTZ6?=
 =?utf-8?B?QkpSNGJzSUNVdnF3QnNPcEVUS1RRNTZUc3hTc3l5Lzh0WHd3TGxQSGtPemJH?=
 =?utf-8?B?UG9zcnpIdUVVWXpMZ1I4eVhCNHd0ZmFZZkp4emdRd09GQnAwMzA5TklXL3hO?=
 =?utf-8?B?V1ZTWkZMS293aU85TGtjQzJGU0dLTEIzWlFuYTV1VUVsTzRxNitGQmFEZnhu?=
 =?utf-8?B?N2d6a3V6bng2V29BME9tNW1GdFFHUCtBMG5BejlhS2YzbkxPM1NMaU5EaG9m?=
 =?utf-8?B?ZUVRdXp5V3I3aDhwbVBoZVQyQTFGbE9WRC91VjhIRDJ1KzNHalpkVEhVWU9C?=
 =?utf-8?B?U1ZjZXNjSVRxZEkxZjcvS2NXelJpc1hpQ0graDdJTjRKVWkzczVVLzg5SS9S?=
 =?utf-8?B?RHRPSlVGTitoRlFPNXlmdTR6TVJKSlpxSnBzblJNZWVHSStNQlhKdmxJV1dn?=
 =?utf-8?B?R0o4cVpJSFNjeFJLRnVCaFdMTHhZZUdYT0FEdVN3OUFabVBFbnBSTkVDS001?=
 =?utf-8?B?UEtXV1Q3djZoZnB6SkRkRHYyMDJhanJ4dWJ1QzZDd3E2YWl6WnNrVWw0dmJj?=
 =?utf-8?B?SHFEU0Iwbisrc2plUzl5dzdaM1VkSlI4WEh0MitaeFIvV0pFYVp2dVhENG5l?=
 =?utf-8?B?T3pJNW9sSk1OOWhwVXU2blRLUkJCZzFYeXhDMVBDYjN4WGlVUUJpdjU2RHp4?=
 =?utf-8?B?bXhnc2xEY25lYXdEWlRJbmN5czJZNGhIbHdDckFMZFdKSWxEUEJ1QkZyWFFo?=
 =?utf-8?B?TTYxQVhNOExHYUprQTNlZGtYbFZFbXZDYWxIYmYvUDRYQ2c0TlpyMFNPbk5u?=
 =?utf-8?B?NXg2QmwvdTI0OVUydzFFYi9mZlQ0NUJXdmJvOUY2Q0NoNjE5UzhVRDJodVZG?=
 =?utf-8?B?Vm9vNVZhVHJkWG0waFhQMXdtcUJ6MDQwMlhXQzZqWjRoQUYyN29TM3k5T3Fh?=
 =?utf-8?B?bkxGWGtSU1VVdzJSUFZOQ3VDUHhaTGx2S2M4OXBURE5vZFU2SFFFREdCTkx1?=
 =?utf-8?B?dXBkMldBRkdVQ0Y2TklLOXVUaGc5bVY2TkVJSEFOeXF4dWNhbmdLM2Y4Zmw2?=
 =?utf-8?B?YXo4YWR5azU1emE0UjlDQS9jUTR5RENKcno2UFZ5YmZDSXM3YnUxMHZLWmFY?=
 =?utf-8?B?M012LzJBNWhuZVlsWHZpM1ZhM1pBRmw1ai9KVkNKYWpFQUVDR3hvRlJzS1ZZ?=
 =?utf-8?B?YUNlUEpNVkZVaG1UOVd4R2hLc0ZPdXl5TGhPcjJSelV2V2RXTE5IUlBUYmVn?=
 =?utf-8?B?VWhPbCtWTm1YQ2lmMGNyeHdTQnVOdW1NOU4yZFprczZ0bnhzazVwOHN4QmtO?=
 =?utf-8?B?a29KRDFzVlZLNnc4T29tNCtBcXo1SjI5YjU1UGZHSTI4MzRZVEcvNTV2Ukdk?=
 =?utf-8?B?Rk02d0RMUHU0T3dCTlJvNWd1RVNKRUZvYXZMWkRmY0Z5WWFBZ0ZZOUJ0cFE2?=
 =?utf-8?B?dnBkZjUwdmFSUC8vVlFwb1M2KzVYbjlVcjJYL3J0Y3JhWnQ0dDZqQUpuRFdY?=
 =?utf-8?B?TXZ2d2paNUc5U3VpWE9yc24rZEE1MzRtSEphMFlKdE9MYXRBRWZmVjVaSUhF?=
 =?utf-8?B?RUpSSUozS0lIeWZ5dWQ1THA4S0dXQjJjSWxraDg2akhVNWRPak10Vzk4OVhm?=
 =?utf-8?B?YmhSZjREZHdmdzY4K29wUFNyYzl4V1RpVzdmdG9xMGtCQUpoZW8rOTdyQm9Z?=
 =?utf-8?B?bVRReXUra2pHTDhMNlVvZTZWODRPNDV4RXVNWkVtRUFROUpIbUl4MUdYRFpo?=
 =?utf-8?B?WnJYeEQ2cVNYMW9sQzM1eXZXZnk1UXpjeVRDeVVrOWRjR3g3c1dtY3R6QzdD?=
 =?utf-8?B?MGphNjZJc0VCamVEQzM5RVZndFl4MDl0ZzRkb0pLZ3JkMDV0ZUp3SkJPN3E0?=
 =?utf-8?B?ajhsb0RDMThkTUZEaWpzR2RaYXVTQnpnejVHVDUxTmhRUGQwRkFYZE9xRzYw?=
 =?utf-8?B?TjI5cmVrUnlsYmQ4Q09nVEE4blY4T0N2WStmNGJKYjArODgyYmZXNXNvaTBS?=
 =?utf-8?B?dWt5L0hBOW9iVkRjVkx5WGtwUDB1RTBVQnNJbTNiSnpOYndzbFlqd1ZrWjhQ?=
 =?utf-8?Q?yn4gpmUomly27QG0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9122CA5B36E96F488A34EAEB0E9758EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda385ff-27a3-4e2a-a6c3-08da31f0104e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 19:13:56.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbM2rLiqwKVMfUGs3xxXnVMOHXcvUJ4pQ+R7OOdrk03x1ne3GFxf1gyVhVqJvCTdjMBsAMbZYyJr/dhnsL4qr5Y+V0y6kLcOkQESrYiWkEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5009
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy83LzIyIDEwOjE2IEFNLCBNaWFvcWlhbiBMaW4gd3JvdGU6DQo+IFRoZSBwbV9ydW50aW1l
X2VuYWJsZSB3aWxsIGRlY3JlYXNlIHBvd2VyIGRpc2FibGUgZGVwdGguDQo+IElmIHRoZSBwcm9i
ZSBmYWlscywgd2Ugc2hvdWxkIHVzZSBwbV9ydW50aW1lX2Rpc2FibGUoKSB0byBiYWxhbmNlDQo+
IHBtX3J1bnRpbWVfZW5hYmxlKCkuDQo+IA0KPiBGaXhlczogMGEwZTI2NSAoIm1lZGlhOiBhdG1l
bDogYXRtZWwtaXNjOiBzcGxpdCBkcml2ZXIgaW50byBkcml2ZXIgYmFzZSBhbmQgaXNjIikNCj4g
U2lnbmVkLW9mZi1ieTogTWlhb3FpYW4gTGluIDxsaW5tcTAwNkBnbWFpbC5jb20+DQoNClJldmll
d2VkLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQoNCj4g
LS0tDQo+IGNoYW5nZXMgaW4gdjI6DQo+IC0gcmVtb3ZlIHVudXNlZCBsYWJlbC4NCj4gY2hhbmdl
cyBpbiB2MzoNCj4gLSBhZGQgZGlzYWJsZV9wbSBsYWJlbCBhbmQgdXBkYXRlIHJlbGF0ZWQgJ2dv
dG8nDQo+IC0gdXBkYXRlIGNvbW1pdCBtZXNzYWdlDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vYXRtZWwvYXRtZWwtc2FtYTVkMi1pc2MuYyB8IDUgKysrKy0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1zYW1hNWQyLWlzYy5jIGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1zYW1hNWQyLWlzYy5jDQo+IGluZGV4IDFi
MjA2M2NjZTBmNy4uOTQ5MDM1Y2RiODQ2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2F0bWVsL2F0bWVsLXNhbWE1ZDItaXNjLmMNCj4gKysrIGIvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9hdG1lbC9hdG1lbC1zYW1hNWQyLWlzYy5jDQo+IEBAIC01MzgsNyArNTM4LDcgQEAg
c3RhdGljIGludCBhdG1lbF9pc2NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gICAgICAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGlzYy0+aXNwY2spOw0KPiAgICAg
ICAgICBpZiAocmV0KSB7DQo+ICAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQg
dG8gZW5hYmxlIGlzcGNrOiAlZFxuIiwgcmV0KTsNCj4gLSAgICAgICAgICAgICAgIGdvdG8gY2xl
YW51cF9zdWJkZXY7DQo+ICsgICAgICAgICAgICAgICBnb3RvIGRpc2FibGVfcG07DQo+ICAgICAg
ICAgIH0NCj4gDQo+ICAgICAgICAgIC8qIGlzcGNrIHNob3VsZCBiZSBncmVhdGVyIG9yIGVxdWFs
IHRvIGhjbG9jayAqLw0KPiBAQCAtNTU2LDYgKzU1Niw5IEBAIHN0YXRpYyBpbnQgYXRtZWxfaXNj
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgdW5wcmVwYXJlX2NsazoN
Cj4gICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlzYy0+aXNwY2spOw0KPiANCj4gK2Rp
c2FibGVfcG06DQo+ICsgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ICsNCj4gICBj
bGVhbnVwX3N1YmRldjoNCj4gICAgICAgICAgaXNjX3N1YmRldl9jbGVhbnVwKGlzYyk7DQo+IA0K
PiAtLQ0KPiAyLjE3LjENCj4gDQoNCg==
