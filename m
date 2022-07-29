Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5C3584CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiG2HtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiG2Hsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:48:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5517814B5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659080903; x=1690616903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vQ7WnJ2C+X5w9BGWX4xVMTFDP1BbvUuzzyaucUzBzbU=;
  b=eAie8rfqKIZLpb5AQrFu3e9xCm+Uc3fMNA5NLtWss6QysQPr7yiizks9
   jo3c7zbyjWNqoHI0i7hjFPfxP3+kFqGOv+Lcej6au0yl3/dMnHXMMp24X
   VFZ/3z+gGppt2/a4xdspseutowGRDjlf0a75n62cfcswBs3amexYfrEXO
   PLwMP4vFjt4qvdGuwP5N3VWvCQhsvX3x0PdpZPqOjsjyQ8pOlVHZGnx77
   rdfPyshlWTzao9Nf8qmRZpUZghbwEj8ebHYvQ5itKmSy5yVxJ3qWR96AJ
   wTd5Vi6VcsI3r/dLd1rqQfSYPHKe2hq+Vj+CsODdFc/QVYfDw/4NqEuDd
   A==;
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="106664040"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jul 2022 00:48:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 00:48:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 29 Jul 2022 00:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myUXCOqs1XnDRglbm5JmeXBWZi2D1W7e7fTx4snkGMk5o7jGgqrSppWJME2NYf8CU551+cv1OgeHjWp/JEGP8r3q8+E6FvTkkevSWV5P2nxJjO/YgqwwqrooIqDoDA6PUnweU1/kdPN31zRgjnsY54plC2wNbHo5MTI3b45RoYaytDXtnYvJuqsVboZ99nhpAFfDB/8eUiBABWvednpw9d6GgF8lVBBDuxk/G1K1jvMUXBgX1unZEAM4yksxTQRBHKWyECTY90bjT3h6LngesWKAUBPySI41ed/3n6m/e+jG2nf4NcEqauURAgpxXx1m84aLpAZpQk1tGYcVj/6VRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ7WnJ2C+X5w9BGWX4xVMTFDP1BbvUuzzyaucUzBzbU=;
 b=HuFCkXXeDpgxYDPpmjMZtcrgp24pIUAg8WTX/sZM9nG017C+aWbNcJaq/Jz9B+puU1wv9xYWwFdPl4thmR1jsdAreNIs3bD7U3U2xuA8Zt/0+J5wL4rGYZSp6VLLWLtxuBFG1Dz4xXPIJiCDUaYhWgSvqX5U/6J4Sif45LyV82TYriMGpQa9CdGHPYtk0QIKTF0Swj1WbmspMHpw2mJjPSUNGnVOySz1WzpZQJXWJIiBfzTVneTRwAJppUNHhvMftcgHpAnZGq6ZUJr+GQoYFwj2OepG3Zvx1/TF/60WM4IEYwF1QHBH6pGFmgf0SVi69bW6Jr1eWSunX7L3CifDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ7WnJ2C+X5w9BGWX4xVMTFDP1BbvUuzzyaucUzBzbU=;
 b=lAzQUtw7RjrKDSNV7Vlos12oZdYSp4R2LIe57fdvQqaqRZef5deo33XO0BiLB6d1E3tyKGlCAaGRCe3Z/m73JdAeXNwVTcfm1r5MM8LsPi9MMvbllclz0Fg97YAbkUrfthFFe1uWqSpy8Djd3U+Q23OHVfW80o8zqMni0+43wK0=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 MN2PR11MB3901.namprd11.prod.outlook.com (2603:10b6:208:138::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 07:48:14 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Fri, 29 Jul 2022
 07:48:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sudip.mukherjee@sifive.com>
CC:     <p.yadav@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <greentime.hu@sifive.com>,
        <jude.onyenegecha@sifive.com>, <william.salmon@sifive.com>,
        <adnan.chowdhury@sifive.com>, <ben.dooks@sifive.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to
 no_sfdp_flags
Thread-Topic: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to
 no_sfdp_flags
Thread-Index: AQHYmsgjen1JGDoDVkiRJKdzpaguzQ==
Date:   Fri, 29 Jul 2022 07:48:13 +0000
Message-ID: <d5662307-200e-171d-58fd-8f26dc02c771@microchip.com>
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-3-sudip.mukherjee@sifive.com>
 <3a9877d0-3cc5-6452-764b-d07b38c72b00@microchip.com>
 <CAHyZL-fK-d+dPWG63dcFUz17uP-sG4bnSFVW_gt16snnOVTzpQ@mail.gmail.com>
 <CAHyZL-c9iSd8=CaQ00Nptea4cqp9f7oqS5VefT3vfcr2J3hmSQ@mail.gmail.com>
In-Reply-To: <CAHyZL-c9iSd8=CaQ00Nptea4cqp9f7oqS5VefT3vfcr2J3hmSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 202b6077-a649-493b-004e-08da7136b118
x-ms-traffictypediagnostic: MN2PR11MB3901:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSesmqcmmrM8n6oSZhC5+IXVG3AxzDfblai01OHPY1O4fYUD6JUcxMxaNxH2/ZE42CIcZN3y9YNila0LsOyLjXP96gJZJzolKV6ItPIpxh3u2bZF+yijSYxEZ5N9MdkdPv/OAL5jeHYOeJ81LX8RDYX9WQaiwKW0AgreYgi31e0IDFkKj11KvWVmbJK4aw9cEoQFJ9QDixgpOFaSUaU9a0rVvO9uWwkmr2CaaYv/Pn41tAzwGhiQFUrJ3DrSyQXN53HpGGg60hnYFtB3nYeXOKBiW0OyS97ZoM4aYhjib1K+yJGZvHuMt8k5LVl7S8awxwcuDc9HzgaDs2zEgaXhi9fmsiRqDhc3MJxmhWDQkc/QEni3E+N+dTxoPV7WeT4AoiZFSf/xfEX8yjnxoZFfFicmSQUa+Qe9cT3vAarPQPHBINbzIW6HCYbWO377rEGUY0A4OjFRiMCkPDMbyTDUMOHKraWTbgN5tcYCm0Eij1cqU84O06Fy7NHVTY+1Eff9etL8Tode+n2JoMfF2IUP5Ivfx1IgFOhAuvYhY5ktYcjLxEWYQQsJXHpyrHWTmJWnVnet9b8fz7s87XrM5qKauqDS88a/b2puP+j3/9nkvaNhJZs9Gu61HZoshKa55BB0RPeCu2KziIPfZenMezUbl5Re+cy7+6H8KWKd5AcesqxPaJ8YUkqPFRrWICwUFsb10Nh9sgR/0WmFzRyScKMENHWgTHVpj9ahIqQJb287Fka35BAgzab/XuMrjW2hyfN3CXdd6LgmbemjM1iIWx4gGrc4bV/pj5ySKp1q8D1BbZ99i2NVeMGS3K/qZuz0BjuBvl6wnWwzAExNgvRyZlNd2mOVTVhFwiDxk4eWdIYGOBpPmVy4oNp/Wwe3DM/+yhFU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(346002)(376002)(396003)(966005)(6486002)(478600001)(41300700001)(6512007)(26005)(6506007)(2906002)(53546011)(86362001)(31696002)(36756003)(31686004)(316002)(6916009)(54906003)(71200400001)(122000001)(186003)(2616005)(38100700002)(76116006)(66476007)(66946007)(8936002)(66446008)(7416002)(5660300002)(8676002)(66556008)(4326008)(91956017)(64756008)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0k0K2lRMm40dHpNaG04ZFU0Zk4yWXNHYVVERmpFZGczOWRpbFVZMG1rNTZY?=
 =?utf-8?B?K1lEK2FpYkVhOCt1YUNOQnh1YklLNUlmR3c1bjVlZnczME5jRm9DOGN1NTIz?=
 =?utf-8?B?TnEyNVFraFpINDA5MkdoS0dRbDMveE12VEY0UzREd1R4cHBMejBnZzlZeHJO?=
 =?utf-8?B?TDBzaGN4WVVMWmd1UGxReHVVZU9zWmp4ODZJS3FVTkJWZGJWY204d2F4NUll?=
 =?utf-8?B?ZEx3Vy9GUjgrQnhEdVlVbjdvbGJjVmdHU0E3d2VuVStHbGR2UEZROTB5NkZY?=
 =?utf-8?B?ZlVzbEVjM09oKzFUZU9kZ2RlclpaVnR6S0R2ZGpGQnczZ2xJTmtibHpRK0My?=
 =?utf-8?B?RzBFZXJ5SitncWFYUHk3WHBwZ1JtSEhjeWZLUnBuYmJYSWRIcEptbDZrZ1Yr?=
 =?utf-8?B?WXRzRk93d0grcFdmOFNHZ3FMaU42RFpGU2h3T01scWdYcVNZNDM2M3pjRE1m?=
 =?utf-8?B?WmtFVm5mSDVIQ1lNbmxmY2VaT1ZnbldqYzZtSDBrS2JpRFQrTEJ5N3dpb1Fl?=
 =?utf-8?B?NERvOS8ybzhjSHlyUHFQMFM0RkNUaHgrQ1hOTVJhYVcrQklyVkR5U1JTU3Nz?=
 =?utf-8?B?NmV3bjJtN2NVenFCMVhwUnkweE96VFJ5U3hjaGdLZ2NFa05wTHV2RzRBL3Fa?=
 =?utf-8?B?SXJkMDkzNmUrQzRBYWppSGl2T1NtYkVhWEdmQ1NOZFQzUnpSaFo3QlJjRXpN?=
 =?utf-8?B?RWlsRTE2enhRa21GU2NoWDZQVmNOeHRHZUhWdHBaM2d0WUJEZWl0YzdEdnNP?=
 =?utf-8?B?WGEwUnVRRExqSTV6NHdOSzIzNGh5Y3lrMDNZQ2lhQWlqbjJ2SE4vdnViUHVi?=
 =?utf-8?B?dW0vVXE0NTVuODJqaXJSaFdLTEFwRXVVclJWaFJWU1U3eXc5ZmgvOUVZY29L?=
 =?utf-8?B?cW9kZXAxMDBjZ1F5aHh0MGhwZm9FSUtyclJsWEVGb0h0TzlUVVgxZGQ5ZThH?=
 =?utf-8?B?a1VWTFJTUG52TG5UREZiQ2FoUWorTjNid2tZYUtLT29rejFkRmhsUHVSdEFu?=
 =?utf-8?B?LzFScXUrNFpNbmt6K1h6M3F4QkE2ZjZablpUQi8veTliTTB4TjEwUFg5WTFF?=
 =?utf-8?B?VW5CVXdpSW9WcUZPaXBocThTc1diWWJXaFNtRjk2cFIvSzJSSnVwdENoWC9N?=
 =?utf-8?B?SGI4K0FRQ0pvK1lYZHA0Qmdqa0tvR2lUUzFUR0JDWm9Rc1h1THdObnZlRmVV?=
 =?utf-8?B?WGZ0OE9GbGVLRmVoNTZEc1BsczI1cFRSZGl0U0ozaS9HcmlPVWs5WmZRaGFx?=
 =?utf-8?B?RFlnb3FHdHgwRmg2QzVjb1NyYVV0RWIwRHVTWDcyRmVtYkVnRERiaEZYNVhU?=
 =?utf-8?B?ZFJNeHp6SUxtU3JPQzZrOVFOTVZzbWNQVEdoa2VVbkp1N21RL3VGeUVHc0Js?=
 =?utf-8?B?YXpGQ0hKM2lkU3BKejhvL21wbldHR2JDc3FIdXRtSWtYMjJxblJXcndFYWt3?=
 =?utf-8?B?c3lsNzRsYmZoWVVCZFdJL3ZTMEtQYWhwZWlYM3FzUEpIZTJ3RnlFWXFCNE1u?=
 =?utf-8?B?cG8wVnZEdkNJTjNsUlZjKzVyRjVKQUFoZTE2bWQxWG1vZHRSV056cytKTVph?=
 =?utf-8?B?N0FjZ1orQldFTTYyQzk3Wmh3NHZvdXVkUXg0VFdBYXEydS8rUEJpVXF0b1Vi?=
 =?utf-8?B?MHdzV0RMM1lPdmVLSnU2WkpoendEUHZ5ekdmY1daWEVxcExZdGRiMXpwMFkv?=
 =?utf-8?B?R2hxb3N0Nkk2MzFmTmJKMnlUQ2lYODk4YlhuUXNiblR3YUxBZncvNXJIQmVQ?=
 =?utf-8?B?anBpZzhhOGFXSlJSdHRLMlp6c3M4S3hOTVdkT002cExPanFvVXljbWxubXNx?=
 =?utf-8?B?YlVhaUpwYkRQUThmdklhZXgxbGZ1WFhCMVExc1RZV2FDVkFBSFpsSUpDWmw0?=
 =?utf-8?B?UFQvWlJrci92V2NqZmZRcGgrd3lwOFJQckNRem9LUG84NkpvVWk4UmpubTYr?=
 =?utf-8?B?S1drQUlhU1FXdGtTMzh6TkVJNDNsZS9LeGZDR0VCWm1BdjQ5MUFxaENYTVR6?=
 =?utf-8?B?K0FTdzBIbDkxaFdkY2Vhb0R5S0xTVVFwdXNjbmcxQzI2QnRQRnptdkVjcmh6?=
 =?utf-8?B?QUlkektEYkRDbTVhTy9NaVQxZkZ0OHlHNGszazVkdC9CWHZVZldJY2M1TnZa?=
 =?utf-8?B?b0JOcEpyRGlIdkY0NVFVSXhscjlkQmNLaXREM2Jtb05RR3d5NmlmRUVUL2hK?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE7569B8536BE8468F32B1DC6A71EAAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202b6077-a649-493b-004e-08da7136b118
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 07:48:13.9034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vkdPXghJSJxbB1m/Zho1A+ynkAAtoHoU3z171mQL7W5lCKGolHzx7gEBJnh4u1wIoqi95FiAp6El9Bp6hFxFAMQS8qxws9buI1kKMdlvr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3901
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yMi8yMiAxMzoyNCwgU3VkaXAgTXVraGVyamVlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFR1ZG9yLA0KPiANCg0KSGkhDQoNCj4gT24g
TW9uLCBKdWwgMTgsIDIwMjIgYXQgNzo0OSBQTSBTdWRpcCBNdWtoZXJqZWUNCj4gPHN1ZGlwLm11
a2hlcmplZUBzaWZpdmUuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBNb24sIEp1bCAxOCwgMjAyMiBh
dCA2OjAyIFBNIDxUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4+DQo+Pj4g
T24gNy8xMi8yMiAxOTozOCwgU3VkaXAgTXVraGVyamVlIHdyb3RlOg0KPj4+PiBbWW91IGRvbid0
IG9mdGVuIGdldCBlbWFpbCBmcm9tIHN1ZGlwLm11a2hlcmplZUBzaWZpdmUuY29tLiBMZWFybiB3
aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklk
ZW50aWZpY2F0aW9uIF0NCj4+Pj4NCj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pj4+DQo+Pj4+IFNvbWUgZmxhc2ggY2hpcHMgd2hpY2ggZG9lcyBub3QgaGF2ZSBhIFNG
RFAgdGFibGUgY2FuIHN1cHBvcnQgUXVhZA0KPj4+PiBJbnB1dCBQYWdlIFByb2dyYW0uIEVuYWJs
ZSBpdCBpbiBod2NhcHMgaWYgZGVmaW5lZC4NCj4+Pj4NCj4+DQo+PiA8c25pcD4NCj4+DQo+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5oDQo+Pj4+IGluZGV4IDU4ZmJlZGM5NDA4MGYuLmRkZTYzNmJkYjFhN2MgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+Pj4+ICsrKyBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+Pj4+IEBAIC00NjIsNiArNDYyLDcgQEAgc3RydWN0
IHNwaV9ub3JfZml4dXBzIHsNCj4+Pj4gICAqICAgU1BJX05PUl9PQ1RBTF9SRUFEOiAgICAgIGZs
YXNoIHN1cHBvcnRzIE9jdGFsIFJlYWQuDQo+Pj4+ICAgKiAgIFNQSV9OT1JfT0NUQUxfRFRSX1JF
QUQ6ICBmbGFzaCBzdXBwb3J0cyBvY3RhbCBEVFIgUmVhZC4NCj4+Pj4gICAqICAgU1BJX05PUl9P
Q1RBTF9EVFJfUFA6ICAgIGZsYXNoIHN1cHBvcnRzIE9jdGFsIERUUiBQYWdlIFByb2dyYW0uDQo+
Pj4+ICsgKiAgIFNQSV9OT1JfUVVBRF9QUDogICAgICAgICBmbGFzaCBzdXBwb3J0cyBRdWFkIElu
cHV0IFBhZ2UgUHJvZ3JhbS4NCj4+Pg0KPj4+IFlvdSBkb24ndCBuZWVkIHRoaXMgZmxhZyBpZiB5
b3VyIGZsYXNoIHN1cHBvcnRzIHRoZSA0LWJ5dGUgQWRkcmVzcw0KPj4+IEluc3RydWN0aW9uIFRh
YmxlLiBEb2VzIHlvdSBmbGFzaCBzdXBwb3J0IGl0PyBDYW4geW91IGR1bXAgYWxsIHRoZQ0KPj4+
IFNGRFAgdGFibGVzLCBwbGVhc2U/DQo+Pg0KPj4gTm90IHN1cmUgd2hhdCB0aGUgY29ycmVjdCB3
YXkgdG8gZHVtcCBzZmRwIGlzLiBJIGRpZCB0aGlzIGZyb20gc3lzZnMuDQo+IA0KPiBJIHRyaWVk
IGRlY29kaW5nIHRoaXMgU0ZEUCB0YWJsZSBhbmQgSSB0aGluayB0aGUgcGFyYW1ldGVycyB0YWJs
ZSBzYXlzDQo+IGl0IGhhcyAiMy1CeXRlIG9ubHkgYWRkcmVzc2luZyIuDQo+IFNvLCBJIGd1ZXNz
IHRoYXQgbWVhbnMgaXQgZG9lcyBub3Qgc3VwcG9ydCA0LWJ5dGUgQWRkcmVzcyBJbnN0cnVjdGlv
bg0KPiBUYWJsZS4gQW5kIHRoZSBkYXRhc2hlZXQNCj4gc2F5cyBpdCBzdXBwb3J0cyAiUXVhZCBJ
bnB1dCBQYWdlIFByb2dyYW0gKDMtYnl0ZSBBZGRyZXNzKSIuDQo+IE15IGV4aXN0aW5nIHBhdGNo
c2V0IHdvcmtzIGZvciBRdWFkIElucHV0IFBhZ2UgUHJvZ3JhbSwgYW5kIEkgY2FuIHNlbmQNCj4g
YSB2MiB3aXRoIHRoZSBwcmV2aW91cw0KPiBwYXRjaCBhbmQgdGhpcyBtZXJnZWQgdG9nZXRoZXIg
KGFzIHlvdSBzdWdnZXN0ZWQpIG9yIEkgY2FuIHRyeQ0KPiBlbmFibGluZyBzZmRwIGZvciB0aGlz
IGNoaXAgYW5kIHRoZW4gdXNlDQoNCllvdSBzaG91bGQgZGVmaW5pdGVseSBlbmFibGUgU0ZEUCBh
bmQgZ2V0IHJpZCBvZiB0aGUgTk9fU0ZEUF9GTEFHUyBmbGFncywNCnJlZ2FyZGxlc3Mgb2YgdGhl
IDEtMS00IFBQIG91dGNvbWUuDQoNCj4gYSBmaXh1cF9mbGFncyB0byBlbmFibGUgIlF1YWQgSW5w
dXQgUGFnZSBQcm9ncmFtIiB3aGljaCBJIHRoaW5rIHdpbGwNCj4gYmUgbW9yZSBjb21wbGljYXRl
ZC4NCj4gV2hpY2ggb25lIHdpbGwgeW91IHN1Z2dlc3Q/DQo+IA0KDQpGaXJzdCBJJ2QgbGlrZSB0
byB1bmRlcnN0YW5kIHdoYXQgIm11Y2ggYmV0dGVyIHBlcmZvcm1hbmNlIiBtZWFucy4gV291bGQN
CnlvdSBydW4gc29tZSBzcGVlZCB0ZXN0cyBwbGVhc2U/IG10ZC11dGlscyBzaG91bGQgaGF2ZSBh
IHNwZWVkdGVzdCwgb3RoZXJ3aXNlDQp5b3UgY2FuIHVzZSB0aGUgaW4ga2VybmVsIG10ZF9zcGVl
ZHRlc3QgbW9kdWxlLiBQYWdlIHByb2dyYW1zIGFyZSBzbG93IGFueXdheSwNCnVzaW5nIDQgbGlu
ZXMgbWF5IG5vdCBtYWtlIGFueSBkaWZmZXJlbmNlLiBCdXQgbGV0J3Mgc2VlLg0KDQpBYm91dCB5
b3VyIHF1ZXN0aW9uLCBpdCBkZXBlbmRzIG9uIGhvdyBjb21tb24gaXMgMS0xLTQgcHAuIElmIGl0
J3MgY29tbW9uIGFuZA0KZGVzaXJhYmxlIHdlIGNhbiBpbnRyb2R1Y2UgYSBmbGFzaCBpbmZvIGZs
YWcuDQoNCi0tIA0KQ2hlZXJzLA0KdGENCg==
