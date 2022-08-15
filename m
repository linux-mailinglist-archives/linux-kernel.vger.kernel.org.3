Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7F592A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiHOHGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiHOHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:06:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DB9BE2E;
        Mon, 15 Aug 2022 00:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660547163; x=1692083163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+yZ4UPq/zqDB4Wm0RcAQSkIUWHbSPObmZ7PxH6SsOCc=;
  b=lWvIo9CDIE9rvbYbKumPMyp9OxeGqFPirRWm5XtEYh/9eNb5SrJFsjXL
   OOOk8GAGCWgpdSELZRn3wNqJDYUTpVCjfKbIBKbR3Mn5cPZVy4U0g0MWE
   OPsMqbJXcWrlD2AjSGER49pLBzKeYyFQ8g2e6Z4Dpue7NydGpLjnWWrY3
   ckt4l431bBWYw/3tGoXv6lGno+a9/tPlndHAWSAN3zwdh58SAoqqV1GnE
   //d2GZvaO/KhgVCHZJ4SoL02YkJBB1lOU+SyJ6ER6MrL2Hc9qUDUNVxyD
   YH2TbjM/MTrt3KsoNrlAor1DxjF5TvykhTYa2MqX4fAwodQB9SJOfN0pD
   g==;
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="169265688"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 00:06:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 00:06:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 00:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gy1y364jo+V75qVxFU7+7/izcUNwEh297lkq9BRrWHZVvcozQtFsNx41EiIfmssNjRvoaFeeADZhZj2F1JFsnWdwsaQUgD4jw8+PmUWxwpPjQ9U99st+Z7Pq88cblkWnZLQH+zklvPfo+3Mpi+Cj3YHqGvAlHbPrBnFHgA1bSIuIYLVESYsWVMZhNuT+q3op5R6vaazZqPqMlVfv/bTpq3BOvKgC7DzksMCP3CpE4pu7Pa4bp1Omhucs0oK1GWerC+CA4sWf6jIr+0IRQj/zZgjMcleCsL+s+M1jlQe1ZBzACbQDS8mBW3zjWHlJeW45+1+zoD51JFnJirdToeDoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yZ4UPq/zqDB4Wm0RcAQSkIUWHbSPObmZ7PxH6SsOCc=;
 b=H3JreFcD1oyZGTi7P4mdZ+ttFHZ/T7DxCZe5dy7FwFEAc+RFr3GYiyogENCZgn/pnbcFy2Vp8AjymWmuh/vrHtLhhcRBz6d/LsuOsOYSthHZvZA1hP8bXCtafZqtkDAfE31PIy6QZTwo+NpeFYikkGzSNQdj0kxMZmMRohrannnwvrFGvKbkQ0kKpZXGdY2u2hGuqljfPSxid/mxOEM4jnGdGp0wyvvP7EPm57h+K+NvM9SN0E+3fy4hDs1b2MePY7c6b6LosRMB/UlZ86DyNeWj0JXMmqFoX7VQoXq6lTUaSrXYj3tyQx7z7wdbcrnrkb8RkVxa+5FCUwJC3pbZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yZ4UPq/zqDB4Wm0RcAQSkIUWHbSPObmZ7PxH6SsOCc=;
 b=Lk7h1vCkidvrpNQO6tJsuoRj5KwAWkxdtda9QgF9B7lnbb5X+HOv5IL43Lv2UolMWHfg85tKWvBJzogu/ptCmiqMPDepD3Rkh+dv4i48FGv1BFT1eWvyJ3W0sD0MfM3bZYkucGqALl0aPBKGjZEI6Rg3lASSURgEL9GYslbhyCE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB0043.namprd11.prod.outlook.com (2603:10b6:4:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 07:05:56 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 07:05:55 +0000
From:   <Conor.Dooley@microchip.com>
To:     <samuel@sholland.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <linux-sunxi@lists.linux.dev>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 00/12] riscv: Allwinner D1 platform support
Thread-Topic: [PATCH 00/12] riscv: Allwinner D1 platform support
Thread-Index: AQHYsGUX6yPEPkvFO0eCq9swdC/Ww62vig+A
Date:   Mon, 15 Aug 2022 07:05:55 +0000
Message-ID: <50dc816c-3129-f5aa-9777-99c6f0fa58f1@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
In-Reply-To: <20220815050815.22340-1-samuel@sholland.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf15097e-f176-46b8-d9ac-08da7e8c98ed
x-ms-traffictypediagnostic: DM5PR11MB0043:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AXQCLLtSOzgznupV9qjtH19lG86aoQ66MCugq4hNAtCuCCaE7B61UjiB8UEBMlUcPXKrUIpF07scfYEVfFoe7d7RPHkuWZS6B3/63B9WFOcDjpGZ+bgH9y37NrkDLKHRfKSCZ5liiiJcO4RbokYquWyIH8qul1pNLSk600WK7UiBLB8vfFUuDsYyzeEeM8rTbDn6uL6zEyTiITOhF//bUbvdQy4WX89uXR0vBqQP3zojGI09kU6aHAlYhL2V9hw77avTPnSbeSrVFkB7res0gfdA6EWQhek9EN3EFoSGyNRsMQx9fRFqzOM6+05EyTXZSQbf7SX5x2ZFvdl8qlbpBI6t8K0Kr+JKRu6w+2DbX0YTTw/LKhskeCLaIqOtd89IGLS4CIvnl4Afv8MZf46jCV2QFIEzRW04SPjGLU8xUOh653W/PPN07LLAUvOUCK77Ii7O9M1WF8F2TmgGQ0mzyaKTdJ9HhhsjlsQv7wMKJPJpVjFpLx2OpHG5DKpZIqYyI/zscsJKprkgzrbm4ydd6RICzJyXdiWHAWKz8QsYTe3Xvk/+RtZdLWwMKbiA7jmwj+W1R6DK80kLGV2wT+9skSTEwWDKV8UDBuHF+e3NGlHqqxK/d3Ba0tgIvAEM2wn0wwbOMdGVcvSKovBD/V4YXai2yShFnGczpchXGnHPSSwserF6pmiy5JGUg0sz12UXns1VJyHcESoI9dYW3p1M2VtBjyiDL+1tF3K41GQvkPQXatip4xB14ac7SjhBhozXQT80JeDlmG5t0WQMk0SiOg4h7XGJzx9LhQvo8mSYWdyCVVgtaTOESQsMbM1sKQGXCHRP53PEsR20o7VXs/axSzBRfNHhaXBxqajMHp4DIguydXxCJGtLGR6QgWA0hQaSIHmz0oK4aESugjdABclmgeAeywHuXiRSvOVAuxz1fhLfdUNBZcbzQk9IfbkG/LAR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(346002)(376002)(366004)(36756003)(83380400001)(38070700005)(86362001)(31696002)(122000001)(38100700002)(66446008)(66556008)(76116006)(54906003)(66946007)(4326008)(91956017)(8676002)(66476007)(64756008)(110136005)(7416002)(8936002)(2906002)(316002)(5660300002)(53546011)(6506007)(6512007)(26005)(2616005)(186003)(71200400001)(41300700001)(966005)(478600001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y05SVFdTMG00Sm5vdW95ZUhkZExrekJ2SHBrMlNWdTJUQTZMMnloUDZKU280?=
 =?utf-8?B?cy9WZlRFUzd2aTRyTG9VbFRXYnZNcDZmS0xmRDUvMExXbHdxVHJjOVBNbURD?=
 =?utf-8?B?aHFXVG1Eb1JNYjdLUWg0aTZzeG0rcVYrWE5heGVmd0p2SzkwSG9JU1VoNFZ4?=
 =?utf-8?B?SkRBcldNWGJmN3B1ejhpZXRxZW9yRTIzd3NvZlVOV3RERnVxb2k0R0xoSE9X?=
 =?utf-8?B?TDhuUjRtY3pHZ3VjYVhSNlFoc3B1dXBxN2ZiTk9MV1o0aFhQSTNGdTVxSG02?=
 =?utf-8?B?c2IyeExJZDRTM3ArYkJUYmJSbTgzZDhSMnlSOGlNci9NVEh3YlNhNGJIZmQ3?=
 =?utf-8?B?dDBVR1p0ajRnRzFIbEFsVmszVG1mZHpmdXlLL1FOTlZmcWV4UEhMV29lOEUz?=
 =?utf-8?B?VXBQWVNGdGF0VVZSbTl6SnB1bW5XSjJhcnBhVE1YNkIzaTMzRDNRVzhnQkUz?=
 =?utf-8?B?N0NvRnFsWW5ZMHJ3VUMveHpHUDNUdDF6NXpMWFZ6SklnYmZDZ1ZMcDc5SWRx?=
 =?utf-8?B?a0F6cXh4UFdvQ1gyTWIwQ2R4bUJIa2tMdzRRbzhRSExGSzA5ZVZqak5waHJO?=
 =?utf-8?B?cCtvTHlzNXhmZjJPT0JhK3lPcWFTcjBEZWNxa0o2Rm9RanpxMU94NUtYSlg0?=
 =?utf-8?B?VFNwbjBJS3ZFUkdvZnZ4VGNYMm9hZVFxSTRiQlZROStWM2VXMCtadkt6aW9C?=
 =?utf-8?B?cEpBWVkxb0pIWFU2RkROOWlXU2FVc3g5WWU2bXpVUUtxcmhxZzk2a2hyZWZX?=
 =?utf-8?B?ZTBxaXRIMmgxVGhzamFDT2tmTHlabDJUOFZKV3hUQjIrdnZ1ZUxsM0Q0Yity?=
 =?utf-8?B?ZU1vc2dURjZTYXUrK3JtaHAzL2tvdVNIUGk3bmJjckJQcm9oNTBHS1JlS3dW?=
 =?utf-8?B?RmMya0ROWHdlbUJYSXdFY0Y0U09nc1R6OFhmQmN2Q3pvTGtxL2ZHTEZzZ2hX?=
 =?utf-8?B?MlE5ZmNRazBvMDNpcFJoTlBZSk9IQjJsS0IrQjlJWE0rV1RlWkhKRzhVUlVC?=
 =?utf-8?B?UGtRT0dxYzZtc1IvM09iMHRwcnNMOWNLWlJuOVhkd1dGS1RZL3h1UUgzaUJh?=
 =?utf-8?B?YzdRVG11dElPaUsxNnZIdGVDR0hSUjA0amJubmh2Z3BsZndxNy9xZFdndlpy?=
 =?utf-8?B?Tm9LaGpIbDYzSkJOS3YwY2JJM0I0YUNFd0h2eXF5eWpiNEN3aFNtUHlrQTE2?=
 =?utf-8?B?MEVNWFNJMW5MMWp3K1FiSkJnQ25XSGNlaHI3S3VuK0x0WldPZi9JWVYzWGIv?=
 =?utf-8?B?K1U0RTd3cXlRekpBRU1Ka2FjUWx0ZFNVdGgyT0lta2FjVUQ2c0tQRGtvSjl4?=
 =?utf-8?B?R3dEZlpmVkE3SUgrQ01UaTByUmlGTUhGcURkckd4L1hOMGhwNFR1QVhhVWdD?=
 =?utf-8?B?NFBtc1VYY2dMRmJGSzBjOVJCcXpxeXIvZ1NrbjFycVlpM2lQM043M0M5NlJW?=
 =?utf-8?B?aGFOVzhTSU1pVDBPSjMyNEVncDM1UXQzdHBPREhRNzFmU0RYaFNMay9rQVRz?=
 =?utf-8?B?bjFKSTZ2ZVFKVHZFTWFvYS90anBZemNKNWNrbm1QSkRJbXZUbVYrYXVUVWlP?=
 =?utf-8?B?amE4cndaSTFINjdQSy91VUZJUnVscHdBbXU1ZVRIdmJsMjR1bDNyTXVlOEYy?=
 =?utf-8?B?WVBVMzVKbURBb1VSUTJYZXAzcWtCNXdZWkt4TWxCOFg5QWNBdlJxeERMaGRi?=
 =?utf-8?B?ZWM0ZCtpSmZVRFMrQ0NSQkh6dUNlUzkvTGc3b01LZ0FKZ0xGQzFmRVNYa21O?=
 =?utf-8?B?QWk4SXVES01MUklzY0w3aW5hQW5JWE83cXEzZDIvczdORGlUNnpnQXJkNkpC?=
 =?utf-8?B?Y0QxaVZPUW5PRHRoL3J2Wm8wVjFKZUNCaktiTExBWG00dVJjQ0I4dGZwZktJ?=
 =?utf-8?B?eGdQUWlxL1ZLb3pySng3Mk0ycGdqNkdXbkFKbVVINVBVWTkyZ2xZbkMxVkxv?=
 =?utf-8?B?dEMyV1dXTHN5L2I0dUN6bWhUQi80RGdISVgwWC9pSU9TaUdlUlNjd1l1a1ZG?=
 =?utf-8?B?Ymhxekd5OGtNREJYU2Rvc0dOUlVOc2xiVUVBR2RteFBkNkJJWVBJZEkyc3NC?=
 =?utf-8?B?QVVwck9JNWRLc1JTSHUxQ0NxM0pNby9ROGlpdGdlVEV1clIvL2JLZnBibzl5?=
 =?utf-8?Q?mk9Ige2yHmaP6Czeb33SgECKg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FE1BD6EFC08684C8611E47016EDCD54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf15097e-f176-46b8-d9ac-08da7e8c98ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 07:05:55.1967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMRTuaJ+OyGN+oBjm4qw3d6o9zikTKAspo+RQb6pMzEJ20tLiRAVsOaYX5y1doO6bXSfh5WZaAxtKKTWXBoATYariS/UdEvtIxoxNcuFCFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0043
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFNhbXVlbCwNCkFwb2xvZ2llcyBmb3IgdGhlIGxhc3QgZW1haWwsIHRoZSBmaXJzdCA1IHBh
dGNoZXMgaW4gdGhpcyBzZXJpZXMNCmRpZG4ndCBjb3JyZWN0bHkgbGFuZCBpbiBteSBpbmJveCBh
bmQgSSBza2ltbWVkICYgcmVwbGllZCB0byB0aGUNCndyb25nIGNvdmVyIGxldHRlci4uLiBJIGJs
YW1lIGl0IGJlaW5nIHByZSA4IEFNIDspDQoNCk9uIDE1LzA4LzIwMjIgMDY6MDgsIFNhbXVlbCBI
b2xsYW5kIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+
IFRoaXMgc2VyaWVzIGFkZHMgdGhlIEtjb25maWcvZGVmY29uZmlnIHBsdW1iaW5nIGFuZCBkZXZp
Y2V0cmVlcyBmb3IgYQ0KPiByYW5nZSBvZiBBbGx3aW5uZXIgRDEtYmFzZWQgYm9hcmRzLiBNYW55
IGZlYXR1cmVzIGFyZSBhbHJlYWR5IGVuYWJsZWQsDQo+IGluY2x1ZGluZyBVU0IsIEV0aGVybmV0
LCBhbmQgV2lGaS4NCj4gDQo+IFRoZSBTb0MgZGV2aWNldHJlZSB1c2VzIGJpbmRpbmdzIGZyb20g
dGhlIGZvbGxvd2luZyBzZXJpZXMgd2hpY2ggaGF2ZQ0KPiBub3QgeWV0IGJlZW4gbWVyZ2VkOg0K
PiAtIFNSQU0gY29udHJvbGxlcjoNCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDIyMDgxNTA0MTI0OC41MzI2OC0xLXNhbXVlbEBzaG9sbGFuZC5vcmcvDQo+IC0gTlZNRU0gY2Vs
bCBiaXRzIHByb3BlcnR5IGNoYW5nZToNCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDIyMDgxNDE3MzY1Ni4xMTg1Ni0xLXNhbXVlbEBzaG9sbGFuZC5vcmcvDQo+IC0gSW4tcGFj
a2FnZSBMRE8gcmVndWxhdG9yczoNCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDIyMDgxNTA0MzQzNi4yMDE3MC0xLXNhbXVlbEBzaG9sbGFuZC5vcmcvDQo+IA0KPiBBbGwgdGhy
ZWUgb2YgdGhlc2UgYXJlIHJlcXVpcmVkIHRvIHNldCB0aGUgY29ycmVjdCBJL08gZG9tYWluIHZv
bHRhZ2VzDQo+IGluIHRoZSBwaW4gY29udHJvbGxlciwgd2hpY2ggSSB3b3VsZCBjb25zaWRlciBp
bXBvcnRhbnQgdG8gaGF2ZSBpbiB0aGUNCj4gaW5pdGlhbCB2ZXJzaW9uIG9mIHRoZSBkZXZpY2V0
cmVlLg0KPiANCj4gVGhlIFNvQyBkZXZpY2V0cmVlIGRvZXMgY29udGFpbiBvbmUgc21hbGwgaGFj
ayB0byBhdm9pZCBhIGRlcGVuZGVuY3kgb24NCj4gdGhlIGF1ZGlvIGNvZGVjIGJpbmRpbmcsIHNp
bmNlIHRoYXQgaXMgbm90IHJlYWR5IHlldDogdGhlIGNvZGVjIG5vZGUNCj4gdXNlcyBhIGJhcmUg
InNpbXBsZS1tZmQiLCAic3lzY29uIiBjb21wYXRpYmxlLg0KDQoNCkkgdHJpZWQgdGhpcyBzZXJp
ZXMgb24gdG9wIG9mIGJvdGggNi4wLXJjMSAmIG5leHQsIGJ1dCBJIHNhdyBhIHNoZWQNCmxvYWQg
b2YgZXJyb3JzIGZyb20gZHRic19jaGVjay4gSSdsbCB0YWtlIGEgbG9vayBhdCB0aGUgcmVzdCBv
ZiB0aGUNCnNlcmllcyBsYXRlciBvbiwgYnV0IGp1c3QgRllJLiBUaGlzIHRpbWUgSSBkaWQgYXQg
bGVhc3QgcmVhZCB0aGUNCnJpZ2h0IGNvdmVyIGxldHRlciBhbmQgYWN0dWFsbHkgYXBwbGllZCB5
b3VyIGRlcGVuZGVudCBzZXJpZXMuLg0KL2ZhY2VwYWxtDQoNCkkgaGF2ZSBiZWVuIHRyeWluZyB0
byBnZXQgcmlzY3YgZG93biB0byAwIHdhcm5pbmdzIGFuZCB3b3VsZCBub3QgYmUNCmluIGZhdm91
ciBvZiBhY2NlcHRpbmcgcGF0Y2hlcyB0aGF0IGdvIGluIHRoZSBvdGhlciBkaXJlY3Rpb24uDQoo
VGhpcyBwYXRjaHNldCBjdXJyZW50bHkgcHJvZHVjZXMgYWJvdXQgNDcgbmV3IHdhcm5pbmdzKQ0K
DQpUaGFua3MsDQpDb25vci4NCj4gDQo+IA0KPiBTYW11ZWwgSG9sbGFuZCAoMTIpOg0KPiAgICBN
QUlOVEFJTkVSUzogTWF0Y2ggdGhlIHN1bjIwaSBmYW1pbHkgb2YgQWxsd2lubmVyIFNvQ3MNCj4g
ICAgZHQtYmluZGluZ3M6IHJpc2N2OiBBZGQgVC1IRUFEIEM5MDYgYW5kIEM5MTAgY29tcGF0aWJs
ZXMNCj4gICAgZHQtYmluZGluZ3M6IHZlbmRvci1wcmVmaXhlczogQWRkIEFsbHdpbm5lciBEMSBi
b2FyZCB2ZW5kb3JzDQo+ICAgIGR0LWJpbmRpbmdzOiByaXNjdjogQWRkIEFsbHdpbm5lciBEMSBi
b2FyZCBjb21wYXRpYmxlcw0KPiAgICByaXNjdjogQWRkIHRoZSBBbGx3aW5uZXIgU29DIGZhbWls
eSBLY29uZmlnIG9wdGlvbg0KPiAgICByaXNjdjogZHRzOiBhbGx3aW5uZXI6IEFkZCB0aGUgRDEg
U29DIGJhc2UgZGV2aWNldHJlZQ0KPiAgICByaXNjdjogZHRzOiBhbGx3aW5uZXI6IEFkZCBBbGx3
aW5uZXIgRDEgTmV6aGEgZGV2aWNldHJlZQ0KPiAgICByaXNjdjogZHRzOiBhbGx3aW5uZXI6IEFk
ZCBTaXBlZWQgTGljaGVlIFJWIGRldmljZXRyZWVzDQo+ICAgIHJpc2N2OiBkdHM6IGFsbHdpbm5l
cjogQWRkIE1hbmdvUGkgTVEgUHJvIGRldmljZXRyZWUNCj4gICAgcmlzY3Y6IGR0czogYWxsd2lu
bmVyOiBBZGQgRG9uZ3NoYW4gTmV6aGEgU1RVIGRldmljZXRyZWUNCj4gICAgcmlzY3Y6IGR0czog
YWxsd2lubmVyOiBBZGQgQ2xvY2t3b3JrUGkgYW5kIERldlRlcm0gZGV2aWNldHJlZXMNCj4gICAg
cmlzY3Y6IGRlZmNvbmZpZzogRW5hYmxlIHRoZSBBbGx3aW5uZXIgRDEgcGxhdGZvcm0gYW5kIGRy
aXZlcnMNCj4gDQo+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3YvY3B1cy55YW1sICAg
ICAgIHwgICAyICsNCj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zdW54aS55YW1s
ICAgICAgfCAgNjQgKysNCj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4
ZXMueWFtbCAgfCAgIDQgKw0KPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMiArLQ0KPiAgIGFyY2gvcmlzY3YvS2NvbmZpZy5zb2NzICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgOSArDQo+ICAgYXJjaC9yaXNjdi9ib290L2R0cy9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgIHwgICAxICsNCj4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2FsbHdpbm5l
ci9NYWtlZmlsZSAgICAgICAgfCAgMTAgKw0KPiAgIC4uLi9hbGx3aW5uZXIvc3VuMjBpLWQxLWNs
b2Nrd29ya3BpLXYzLjE0LmR0cyB8IDI0MiArKysrKw0KPiAgIC4uLi9zdW4yMGktZDEtY29tbW9u
LXJlZ3VsYXRvcnMuZHRzaSAgICAgICAgICB8ICA1MSArDQo+ICAgLi4uL2R0cy9hbGx3aW5uZXIv
c3VuMjBpLWQxLWRldnRlcm0tdjMuMTQuZHRzIHwgIDM3ICsNCj4gICAuLi4vc3VuMjBpLWQxLWRv
bmdzaGFuLW5lemhhLXN0dS5kdHMgICAgICAgICAgfCAxMTQgKysrDQo+ICAgLi4uL3N1bjIwaS1k
MS1saWNoZWUtcnYtODYtcGFuZWwtNDgwcC5kdHMgICAgIHwgIDI5ICsNCj4gICAuLi4vc3VuMjBp
LWQxLWxpY2hlZS1ydi04Ni1wYW5lbC03MjBwLmR0cyAgICAgfCAgMTAgKw0KPiAgIC4uLi9zdW4y
MGktZDEtbGljaGVlLXJ2LTg2LXBhbmVsLmR0c2kgICAgICAgICB8ICA5MiArKw0KPiAgIC4uLi9h
bGx3aW5uZXIvc3VuMjBpLWQxLWxpY2hlZS1ydi1kb2NrLmR0cyAgICB8ICA3NCArKw0KPiAgIC4u
Li9kdHMvYWxsd2lubmVyL3N1bjIwaS1kMS1saWNoZWUtcnYuZHRzICAgICB8ICA4NCArKw0KPiAg
IC4uLi9hbGx3aW5uZXIvc3VuMjBpLWQxLW1hbmdvcGktbXEtcHJvLmR0cyAgICB8IDEyOCArKysN
Cj4gICAuLi4vYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIwaS1kMS1uZXpoYS5kdHMgICAgfCAxNzEg
KysrKw0KPiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIwaS1kMS5kdHNpICB8
IDkwMCArKysrKysrKysrKysrKysrKysNCj4gICBhcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmln
ICAgICAgICAgICAgICAgICAgfCAgMjMgKy0NCj4gICAyMCBmaWxlcyBjaGFuZ2VkLCAyMDQ1IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zdW54aS55YW1sDQo+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvYWxsd2lubmVyL01ha2VmaWxlDQo+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIwaS1k
MS1jbG9ja3dvcmtwaS12My4xNC5kdHMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNj
di9ib290L2R0cy9hbGx3aW5uZXIvc3VuMjBpLWQxLWNvbW1vbi1yZWd1bGF0b3JzLmR0c2kNCj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9hbGx3aW5uZXIvc3VuMjBp
LWQxLWRldnRlcm0tdjMuMTQuZHRzDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yv
Ym9vdC9kdHMvYWxsd2lubmVyL3N1bjIwaS1kMS1kb25nc2hhbi1uZXpoYS1zdHUuZHRzDQo+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIwaS1k
MS1saWNoZWUtcnYtODYtcGFuZWwtNDgwcC5kdHMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJj
aC9yaXNjdi9ib290L2R0cy9hbGx3aW5uZXIvc3VuMjBpLWQxLWxpY2hlZS1ydi04Ni1wYW5lbC03
MjBwLmR0cw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2FsbHdp
bm5lci9zdW4yMGktZDEtbGljaGVlLXJ2LTg2LXBhbmVsLmR0c2kNCj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9hbGx3aW5uZXIvc3VuMjBpLWQxLWxpY2hlZS1ydi1k
b2NrLmR0cw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2FsbHdp
bm5lci9zdW4yMGktZDEtbGljaGVlLXJ2LmR0cw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L3Jpc2N2L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW4yMGktZDEtbWFuZ29waS1tcS1wcm8uZHRzDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIw
aS1kMS1uZXpoYS5kdHMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0
cy9hbGx3aW5uZXIvc3VuMjBpLWQxLmR0c2kNCj4gDQo+IC0tDQo+IDIuMzUuMQ0KPiANCg0K
