Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2235545CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbiFJHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiFJHNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:13:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E747C5E17B;
        Fri, 10 Jun 2022 00:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654845182; x=1686381182;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=VYs+I8qHbtks6Cnfk+Q6D/aq5z0vtzseY/R4rNzoGS8=;
  b=XFmWdLgRcJsOEcmrN82+2UOYltVPz9Bznnnxm8x60vhvm1Zm8SxPPvPG
   yttA4fuTGo2cpdMtJ+WlY0m2W9V6ZG+33VnPxKr4hjL9ARitzk12Gy5YW
   1+zVGalN/yrF2BCMtln7FTRIQRuQZnWqoqkd6QBXNOMa851gjmU9zohc9
   F7mBc5t3j3iBktHDiTAsv2FXwsX5Ih+iwyy+vKGjVb+TM+NFZcAZxxIFK
   gkbwtIjsTshq/f46gauNgBNypa8CK8fzgsNehXIZJPmoNje0io+r88p8g
   SSL//7B29zDxNTHR7GoCBSS499uZn8p/xU+cVTshldw2dRNaz+mTdDswE
   w==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="167874764"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 00:13:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 00:13:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 10 Jun 2022 00:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvTS0yLT8lmYXDtxAtEnxqt15myP++BGNNihiP9SkDJe6LgpmRqIH73yvE1GRRnj7906pfaeOO64cpvvawzK3139C4/djmsFIUaa19isXzDeyzVrfSfm7x/B3MRjSoXl1Ld1Oyw7lxK1FcwfjLZ63t5mNGof1vrcILFqi9a1HRUwrG+TeobHVgcg5Ub+p0flYptU1toEZ6XXpQtFOwrNrOyuVgxCRnWWTWwaPNi15n962LrbkSzn00HAPYxsHdRaWi5IlhglfHwGaaCD2nIS0aFpXe9sMWD0lyHxohpq/S+RBJbIiCQSmprOwvMrxc78v881YdfIcSYoB/hAdbE2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYs+I8qHbtks6Cnfk+Q6D/aq5z0vtzseY/R4rNzoGS8=;
 b=PDlLLPtPhkvYvGN5lRNnPGdR7jfZzIUBml/XHFo8JWdLB1XDZureH+FmWLK/IrUv9Lbm+rrZsTsX3/oUCuAkLh23wvRDv9twz4bi489wrNFP/UYDJI/GE3ZEC/1SD6WylgXc7mVJciM0v9SBibqD/cssHohKrq+7yaEsTlJb3HyiYf7m95oJ2Ts1XkIX9brRmrGhM4otOsGiETyaZNnq9UZLhBsfUiudXCjFAOQtDzgwXwgfPL6HIBolM3oGbz6/M6WYy8iKnzzgOf1/OAU286qyxZ+ryaiSITaf7f36IkfYpFPBIiOEDhZlMEnvpGBEljtApZR1xSTGwxHOrrb2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYs+I8qHbtks6Cnfk+Q6D/aq5z0vtzseY/R4rNzoGS8=;
 b=sxesM35BGsH/cCdCGaTqsjQylN6GVFa9KZx1QiO9CmkNWSxmKXAEAiPU1CwNiq7cr/WexqBjZ1BbzoyG2b9k54lv1cMhBHggfGzNXjp93tuIPkXi9DMgJSmgsy7rifbRkCN2JeZQFsncWfs/QTbwfDXOI5mMYfQzVgOlF5yptAo=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 07:13:00 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 07:13:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <arm@kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 46/48] ARM: dts: at91: drop unneeded status from
 gpio-keys
Thread-Topic: [PATCH v2 46/48] ARM: dts: at91: drop unneeded status from
 gpio-keys
Thread-Index: AQHYfJmE7TjVR0sHJEePelr5AQvrOw==
Date:   Fri, 10 Jun 2022 07:12:59 +0000
Message-ID: <f3f1d971-45a3-46ac-62d3-4206acc3655f@microchip.com>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <20220609114047.380793-7-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609114047.380793-7-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d69c13ef-e9c3-4de5-c340-08da4ab0a6de
x-ms-traffictypediagnostic: DM4PR11MB5247:EE_
x-microsoft-antispam-prvs: <DM4PR11MB52476D5A8C3695CBC4BF029D87A69@DM4PR11MB5247.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PO98JiA3CbuYlScX4och9jeCS6NjQB/FcvNByDiypcWzy6OX59F1BSf/MO5nf/GksrkrG+liJfLFcNAKDn1kqvuB20P5vAfhHJICAj6f5Ppp+mYfbspucJGz5cU+qFKZ9nG3qHmNMi+/inUFEMTt+rPjSy5M+SaLXEIhfEZ+v54rImdvrQZOQKlEN83W3P/birde3v02BNWEcJjCWxzjBFMtLuCPjwlooVusNz38Kwr4q/6AtON3vSatDbAPEHmmV9VrMr5204d7uXT1hSMvA/MpYYiRMJGS7Tl9Kqa5XmFZhaYcC3R0QTLMohe/79XKH/pxPs0mcjXxpoAzVVWcs4c2JekfEiW2lRQfnE6d6cNTomqE9lqB6sEzIJyjD077kvZbOrCVWymtsIOh+jhdHYXLaENQOzfbU4/Y5Tv4cnLeP2BclnAE+aC8ivpDuARdFt0rTJ5jNbilnmaT01KVP3x5PIXnOGew/Pp1djsJantRogbfeolYkUoQAyYfQP1T0JjV0qfugU5Xa3Zkm1ggGc/kJTeirqQ4B6ERQlA+Vx20AAsF0cKvyRg4NcHPtP4prQmAn34c+Gs1pvTF6O2pWPDGETQuiCd0VvdGZkHShbbjPaixap2wdlJ1AB+/xLJG66gnDV/XkTmvd/La5K+QhJ6BF9POhvgLDnUN9PwJQpUrQBTEZJgGQOExOEU+DqpnVq0ec6PcbY10G14Tv9RLx2kLaY+oKElvP5vjmH2e+Imsi7iJVUv6fYqQtPCIix/4L+AwISgxMgEd2JCOi1HMpkunOidQvKKS1/mkgm95h/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38100700002)(36756003)(53546011)(2616005)(83380400001)(31686004)(2906002)(316002)(38070700005)(8676002)(122000001)(921005)(66446008)(31696002)(5660300002)(71200400001)(64756008)(6512007)(6506007)(6486002)(508600001)(186003)(66476007)(91956017)(66556008)(76116006)(66946007)(8936002)(26005)(110136005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmpDemNmU2xhc1lpZG1xdUhVN1hjMHBVWDdsaVdldDdRZ2xLWFFrQ21xVTBF?=
 =?utf-8?B?ejRUTld4VjRHYWVFMWtEMzFZcUw4Qjd2M1FSa0hadnZrTzMzanpqaUUzbTQv?=
 =?utf-8?B?V0RTRVNCZ0E4UGxjczVxYVY3c0dCNzBlUGZjVC9EaGc5WXd0Y254bDEweWZ2?=
 =?utf-8?B?TlNQTDFWRzg4ZUQrRzNCZFd6YU5UYlpwTzRSblpYWVpacm9yQzFyb2ZiTTBR?=
 =?utf-8?B?V2JGbU1WSFFWRE85UnBJL280L1U4VStGcHEwUlR6M3R4enhtTlphSzZQaVNH?=
 =?utf-8?B?dXlVMUJuK2JEZkVKN3hzeG80c3BYTnFRdXg4UEVqREFsdm01NE5vZ0tBRVd1?=
 =?utf-8?B?SlVuLysrOVN6MHI4ckRmWG9NQUVVeGdoNThqZG93TVN6S0NtMTFvWnBwc0xu?=
 =?utf-8?B?Q0lpbld2L3dYclNtM2g2YXhldUF0TEgzN2hMR1hsTlM5ZEV6b05yN0paVU5k?=
 =?utf-8?B?NTl2aHgveStJY3ZtMWRFZHh0V3RQc1NzUjlaUGVuS2RjM3V1L3BxbXJyNVFP?=
 =?utf-8?B?Q0x5WG1lQlJvWTFMRHB5SXhHcGhyQ2tMNVVLNVpjTnIwUFJaNnZIaE1oWmk4?=
 =?utf-8?B?NG5oZy9ZbjZiUjlJU3VsTGJja01wYWladzNqYU9OUkxiQjM3ZFFjSnRjZWV3?=
 =?utf-8?B?ODB1TVJ2T2FIOFJHRHVSekp1aE03Vytib05KZE5wSHJBZ05Qc05IWHJGMXg4?=
 =?utf-8?B?L0p4U3ZaWmd2WUdqZ3dwZlBScTJpTlNIcGxRU3RoZENSdXdNY1Naa2hGc284?=
 =?utf-8?B?SlpTK1c4N2xUQS9RUUhiUjRUNXQ0SXBYL0U3WlZUbjB1VHQ3bzY5OFhmSkxw?=
 =?utf-8?B?T3RjcTBhRW0xaTZKQWNDTXZpU3EvMWVpNGg3SFRmZ1Zac0FOM0ZVUU8weTdy?=
 =?utf-8?B?ek5zeitnL0N2RUhZc2pvcVpIRVBUdVp4dDM0QWU5RkkrTDdxaGhFWWJpVkp6?=
 =?utf-8?B?UVNWby9NbU1MZ2F0UU5pcWQvUGhvb0Q4bEVCb0hMK2lTbDlxNHJ2bTdPNVNI?=
 =?utf-8?B?OXNvWCtrbDB1T2ZpamptL0YxU1dhakJRY2JXdXZac1VQN2NsekxFRTdFZ3dO?=
 =?utf-8?B?S3daQWl3YUdyM0IzcXNsMXl3enRaNW9udjUvb05WNEUxZ1h2bWFhcGRia1o1?=
 =?utf-8?B?aDFOY1dSK3FXWmhhak9PenJnTmZIR2treG1wZXAyMlpqM1V6bWUrUVlpeTBX?=
 =?utf-8?B?cEpEUm4vWnJqWlBTNW5GQXcyVEZPUG4xdVdPM2g1QlF0dFdXbjZuRGs1SFpP?=
 =?utf-8?B?WXJlcXlvN3dIeXk2Q2crZzV1VHAzdzNXeFlDMllOSTJLb242Z2IzOEx1bXhM?=
 =?utf-8?B?MHBOUkNUQXpyWmFsUVlNeWNINTBFRUxzUlI3YkZ1ZEVkOGtieGFHTkFqZjdo?=
 =?utf-8?B?c0cwRDFBY2hjYURTOEpwMFZYTFJONWtwNHIyZ3dIa2dmL0NSbW9iRjIwemkv?=
 =?utf-8?B?WjJwOGFZYm9KaTVNZjluTzNRbFlWSWRQNTR5TkRxVmdMVyt4VUFjNkZQWC83?=
 =?utf-8?B?b0pIMEdHdHBRbWZKNUhwWnluMnhuZmIxdzVzMGpJM3p2bWQ5bXQ1SnZNelBP?=
 =?utf-8?B?QVVQSkllckRnc25PSU5odVM3U1Nua2gzZnRXZlQ1OVpLdGFpN1FqYlE3MktH?=
 =?utf-8?B?aERhNURvam41MWRRRlVxTmw3MHdzUml0VHM0MnpGY0FnZHhaWUVhemFkSmly?=
 =?utf-8?B?QUhpdndsWmROblU4MHFqN3g3eHZNeDkvckw1VGtmQms2bEpqalRvZDdTQ09i?=
 =?utf-8?B?UW5XWkVsWmw2N25GNmc1bk5zaVRieDc3QmFOMDNBTytMbFM0SVVUT0dybWpa?=
 =?utf-8?B?RzZyVFJweDhwbHJhMG9uSFB6ZnZQb3p1a0pXbnV3cm9UdzNhbVdVV2JJSzhw?=
 =?utf-8?B?OFBuVWI2RnJzaTFsYkljZ2R6VnkyK1FIMHpqZ0ZheWtsdzg0RGNTeURWS3V1?=
 =?utf-8?B?cEhSZ3YrZ0E3NW9rTXp5aUVhdUZsVW5NanlFSktHMjJvR1FzbFJ5RzNXdlFa?=
 =?utf-8?B?R3NiQkFHK3VvbVJ5bE1FYU5GT3ZpY0dmZVpFM1o4WDFPM1VsdzVaNkpyUndw?=
 =?utf-8?B?NDhSL09BeGtLMWw0NVFrWVlReXBRb1dpVUwrcnJGYzkyOTA3dWNMKzRCUUhI?=
 =?utf-8?B?Si9heTJGTkt1TzZua2hzMC9OMTM3TDloMWJDUGZibzU3S1BHd21nU0dqNXBK?=
 =?utf-8?B?MlBqZ0l2ZDBrN1QxMWUwTUtpRlVkTnh4K25iOG04VnpYVlNrcmQzU0MvczRI?=
 =?utf-8?B?anJLM0NCZkdiM3dRdUF4ZlBIRWhSQ0xnRlBiNWFnNElFdVgvMnBiN0RocG0v?=
 =?utf-8?B?dUlSZVc1QzIrVkU1WXFhblBkY3B4T3F4d0FYUW1yM2NuREFrZDlPa2dOcytl?=
 =?utf-8?Q?U5hvB5Z/WrgLjGfw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C39A18EC0ADD8A4ABA99A926F4BCFA58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69c13ef-e9c3-4de5-c340-08da4ab0a6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 07:13:00.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdCfIuGX1Uo117IKIfGIDs78f75tB5Juh4OXOwVkm/JWGnYRjj1J1lIuIZnovsfkV9InWIRelEugQLqktur+5xrU2Hh5Ss4P7qo5eBTwCGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5247
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDYuMjAyMiAxNDo0MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBOb2RlcyBkbyBub3QgbmVlZCBleHBs
aWNpdCBzdGF0dXM9b2theS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IENsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICBh
cmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgICAgICAgICAgfCAxIC0NCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMjdfd2xzb20xX2VrLmR0cyB8IDEgLQ0KPiAgYXJj
aC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX2ljcC5kdHMgICAgICAgIHwgMSAtDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05
eDYwZWsuZHRzDQo+IGluZGV4IDdiZjk5YmRiYWZjZi4uYWRlMDdiOWViMTAxIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IEBAIC04MCw3ICs4MCw2IEBAIGdwaW8t
a2V5cyB7DQo+ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImdwaW8ta2V5cyI7DQo+ICAg
ICAgICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgICAgICAgICAgICAg
ICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2tleV9ncGlvX2RlZmF1bHQ+Ow0KPiAtICAgICAgICAg
ICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiANCj4gICAgICAgICAgICAgICAgIHN3aXRjaC0xIHsN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAiU1cxIjsNCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMjdfd2xzb20xX2VrLmR0cyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2F0OTEtc2FtYTVkMjdfd2xzb20xX2VrLmR0cw0KPiBpbmRleCBkNTY1MmM5NzQ3
NDguLmJkNTQyMjQ5NTMwNiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1z
YW1hNWQyN193bHNvbTFfZWsuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2Ft
YTVkMjdfd2xzb20xX2VrLmR0cw0KPiBAQCAtMzEsNyArMzEsNiBAQCBncGlvLWtleXMgew0KPiAN
Cj4gICAgICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAgICAgICAg
ICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfa2V5X2dwaW9fZGVmYXVsdD47DQo+IC0gICAg
ICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+IA0KPiAgICAgICAgICAgICAgICAgc3dpdGNo
LTQgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJVU0VSIEJVVFRPTiI7DQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfaWNwLmR0cyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl9pY3AuZHRzDQo+IGluZGV4IGQ3YjU5ZTE2YTA4
MS4uMDAyM2I5ZDc0NjUxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNh
bWE1ZDJfaWNwLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfaWNw
LmR0cw0KPiBAQCAtNDcsNyArNDcsNiBAQCBncGlvLWtleXMgew0KPiANCj4gICAgICAgICAgICAg
ICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAgICAgICAgICAgICAgICBwaW5jdHJs
LTAgPSA8JnBpbmN0cmxfa2V5X2dwaW9fZGVmYXVsdD47DQo+IC0gICAgICAgICAgICAgICBzdGF0
dXMgPSAib2theSI7DQo+IA0KPiAgICAgICAgICAgICAgICAgc3dpdGNoLTQgew0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBsYWJlbCA9ICJVU0VSX1BCMSI7DQo+IC0tDQo+IDIuMzQuMQ0KPiAN
Cg0K
