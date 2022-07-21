Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5A57C575
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiGUHjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiGUHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:39:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772D77CB4C;
        Thu, 21 Jul 2022 00:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658389181; x=1689925181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fbLgKt8YMdN1ec5Bh56SNHdbqkHVqDiVUHr7Hag1Bqc=;
  b=Vy47zNfrZ6NjZINYEeF5wo3m3FEvEgDRaC53avu25hanbO3GV1gm3qK4
   cMhZvyVs7Td+3KzC6knHm/zJombz0vladKYPuQjGwxGj4VlEspQNQ3IOT
   wXfQ/OHsqtWTI2+OMHnkpu5GyOWS7rX8SY5evQnG/PN4/8ynhYFE4v5Pp
   cU6AQXp5ZJQ3Z4joIvM9BPTB0l3tYZkchicMAcdbHVqSTEnJhQIipmLpS
   iwXJZ3anj+p7Q19uPVi2cjctFfVOV5pvp8v1ydsohj6zXem7RJL1qUFDe
   nVzQw/KDGrGX6hHb0/beP3f0g7TSPIjph7decI/wz82uO4Eotu/lAG1Np
   g==;
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="173219760"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jul 2022 00:39:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Jul 2022 00:39:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 21 Jul 2022 00:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKvddHmzo8gbGJDpg2TngVd0yP4Trc3LqeH5Kpr5brCJb8f1knAnMh/KKKzPpeNtqZlcVdXo5gYUIAbga6hBt6EInR2FwuB1vWvW42tx6gt/cp95s78jQwo/QHCUIvtNlQ2H6KhQ5iiql9gKuNqPgUJBvU4kP5hX5gMcaT/AQAKWzzmkSwBIGpJUW7qgXaRQDgaB6fvvANEzvxzKvoOk/Ii7Gt/Xkn5az/u/CyWaqrsIXtPn+SDqHdRxN+z/31ZSAvnv2UWLyrwZ/ULODANE0cbNnZMzpsxtrFCorn/P6DJ09+L3cUrov2O0r4gRa3jUSQG0092MYQFffesURhilKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbLgKt8YMdN1ec5Bh56SNHdbqkHVqDiVUHr7Hag1Bqc=;
 b=ZDDzcW/iWQoTvtZM5pIAxW7FC1xEUitn50GZAqKPXmgUtn2MdTyHz2vdUQnKV0zay6I/EF/AVI94DB79kITctglGKTigBewBGW/4vDepmnLUACQyEeuLi4b0LmGazbEhQfXIpev9besrp0tuvrwDCJdaJDd0eCrAWbEs9ngcOrbfqO8sN4wnK4ja4GKCkxwRF0A86g/I/K2jKZMm7RNe+y/D3GrF4Pu/0T6CNyMToqE5hkd7PfGdTVeio0+Cu3Xr34Bz3WAVncknTF8XFueX9R8gzzasUgTdmxh3S0t1wZTbSdfwuF5xfh23wblDNLwmyHBCYk9kMF/0SkEn9HXqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbLgKt8YMdN1ec5Bh56SNHdbqkHVqDiVUHr7Hag1Bqc=;
 b=V/ISbYkRytzcxaRDmH/XwmtDl5A31tDEr8mbXfh3uDhUUdjF2i5U9C4c5+J2uc/D652RoyOjXOsJirYDYkbvqWJzdq+zmnbHztEtYLY5I2sfLGZGKjPqubJIBdHNGc1nPSAXI0Z8TL8Tyq0344Mt4y/yfbJ4CJ6f4CJSFfgEmfw=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM6PR11MB3337.namprd11.prod.outlook.com (2603:10b6:5:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Thu, 21 Jul 2022 07:39:34 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 07:39:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/2] ARM: dts: lan966x: add support for pcb8309
Thread-Topic: [PATCH 2/2] ARM: dts: lan966x: add support for pcb8309
Thread-Index: AQHYnNUFBve2aq0Yz0WhSQ1jEgfOQw==
Date:   Thu, 21 Jul 2022 07:39:34 +0000
Message-ID: <89d7f6cc-a22d-b428-4677-f918df25901d@microchip.com>
References: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
 <20220720194904.2025384-3-horatiu.vultur@microchip.com>
In-Reply-To: <20220720194904.2025384-3-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dcacd1a-994d-42f7-1b1c-08da6aec2828
x-ms-traffictypediagnostic: DM6PR11MB3337:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxpR2moTCSpE+hypPbUOJUJVY5/g4LZ7fLhXrMMvXf1SUfXV/ATwke73KylWC3zq1x2gFs0y+o9IxBoJ5V2Ne9MChy1mBPrY2LRXu5DtMy+XGDJAgsLWe9f0G/UHKDCDFehnDWE8ZjT71Nu2lQZFK/Hbh+j0TZoW6j2YurA6lcKnFlkOMINtEar/b6MomyAwAQ4odIKhiIzGD/evSPxA/udQQwZbPMyocAntkv2ItBBWSjhALXf9fJDzFzzNXsXaCcc48TIVwdeM3FvhOYoJpZrh5R0qBjJal652LtMM5yA3kgUocDwk5PEIdd+G1vlT/NFgiEjFciCy1l9BYwcOMu6K9ErqqRoNEVRMd5vS3zJOUbd+PfyaukiWPhNXTHhtZZHPGe3mlxr1Y9Wi+u1Z/0dY9ZuMT6I7Y8s9hIq512Zg2oUCxGq86wLEfoQYc5qN0D3t5N30bWKxOMrZr2LgqNM5CA6MpbE+uLyKdQuQgk4vY4yx0dFdgVwRBsgmLx3CgZ5dMqLctcMx2MsU7ed741yprV55T4P/tqz0dbj34pRFGFdGtUi4vVXS8+u8vHEn0L0e7WBWwRF56esFsT9HjxtI7t7QgkKUlfLU1yjMQKl+AR6cehZBGygUnKGrAW1jQYrqT+M2Qf8tiGpnVoQtUilt07lDXXgixSTVn4UuNS0m8bDjLgb0nUJBDEmtGyUjuC/rq1GKl1kS6jvobr8CkR+vLRX5j9JQ029KazYU9t44xXRSKkGDSTYAF+on86nz7Oo0oqkA0x+r3xA/1BgFaPXsBoTwwZHrUul74ivkNGFLffedxg/Tow+IXBfdllZGQ8VK/CYmj71VZPz1hR9VJN37hGoreRT3VHqb2BEd5gg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(39860400002)(136003)(376002)(186003)(478600001)(2616005)(316002)(41300700001)(31686004)(6506007)(26005)(6512007)(5660300002)(86362001)(6486002)(83380400001)(122000001)(66476007)(64756008)(4326008)(8936002)(8676002)(66556008)(38100700002)(66446008)(7416002)(54906003)(53546011)(71200400001)(36756003)(91956017)(110136005)(66946007)(76116006)(31696002)(38070700005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckdOWjhwZFMrYjRVQlhZNXc1a2pURnY1dWwxN1MzNm9xd0pDR3JBc0hhWTlT?=
 =?utf-8?B?SW1uaGNRM2d3aUZiV3FleENQUGl0ZFBlWVhsZDY3ekg4UW1nRXR4alNpdXFP?=
 =?utf-8?B?eWhtaVZpR0VqMXZrY3JENUxjWWVwYngyRmZEYUs1L2J6cUV3S09XM3hoYmhq?=
 =?utf-8?B?ZnIxS1RQRVdRY3UvWHo2UGxDK0NibWZ0Vlc4MHljNndOSExvY2xMdkYwM3Ur?=
 =?utf-8?B?VlBieTY4SXYyeWZ3VWhMRzcxQ3doZU5SeGlkenhKMnFQN0IwS25XSTRSWkpi?=
 =?utf-8?B?WlA1TllFSGdtNnlwekJzckwrdzVWOUhwSWQyM09jUkIwdSttaDNheklqR3Z2?=
 =?utf-8?B?WW9QZWVOa1IwNmNvTC9yQzNzdFpkZFE3ZThrYysrNEphUytZekJqMGNoZzNr?=
 =?utf-8?B?UWV3NjhWZGFIa2Z1cEN4N3kvQ0VGYTBWNCthT0FhYVhNZU4wK2hkVGh5ZVd6?=
 =?utf-8?B?d1VTdkFqUUN0NzhZYzZyT2VWVUNLc3BFQWVRd0FXSGlvMkYrV2k5TG5ncmNv?=
 =?utf-8?B?T1djS0w4N1kyS0d5K3RxR0crRnlURnhHRDFoREdFSFZSdktDVEFqUnJ2S3Ji?=
 =?utf-8?B?YnY4U1U1MkQ2OEsxM0lkSDRGNUpZRUdrVno0VStPMkdQRmpBYThnbGdsYWZC?=
 =?utf-8?B?L2lyZnBOYXpxWDhSdjNDRGFhT29oTWNpVTgydGFaaEFmTnFSVm5FbVZCOTdl?=
 =?utf-8?B?cGMxaUNkT3QvTCs1Z0J0WVpkQWhEWGhhd2t6Z3RqeUdQZDVidWlPa042QjF4?=
 =?utf-8?B?ek5kZlQyNnppb2ZhbjBVVlBaNzc0cjltcUtFUzJWamZtb0lzcmNKbXZZOHo1?=
 =?utf-8?B?bzlGOFBFZFovMzYwb2lCV0RoNkVNZVpMaE9jZXRjRTdkSU40OC96Z3B6OGQ0?=
 =?utf-8?B?UkRGbEVEU2kxd0U3K2JkSFRYWHQvdzhmMlRJU0prMitEaE8wczNyZHp2VTRp?=
 =?utf-8?B?VXBuNloxRnI0UXlxcm5qN2dIWWhCcjJJR3dNdzdiazZqcUlxWW9KRTdsMG5t?=
 =?utf-8?B?SFFMSkx3REhSbys2bG5nTFpsVkdyYVJUbkdaamltMzIxUUN6djFUZjMyV3lO?=
 =?utf-8?B?K0xxOXdaeHRZQWRkTTBPSVNycFg0eE1KbmY2L2xZVHNDa05mRDhhVnA0UUFj?=
 =?utf-8?B?K1VPc3hUMFQwekU2MWZKaDF0LytORXRJNE9oNnpsZWhmWlVaSjYzNjExSlRv?=
 =?utf-8?B?ejkrYjRLSWVRTXlzWmxNemhkRVRJS1liUVErWG5RT2tLS296ZkwrZFhaL3Iv?=
 =?utf-8?B?bUZmVTZQdTBJVUZWZDFBUm5MRFZjUDByWndacXRJYm5yWXVKd2hnejlnVldk?=
 =?utf-8?B?NlJLczNGVGVtc0J2UkdRSnNwVTlTWmg4MkY4RmlDZG1na25vK0JPNTVYOHcw?=
 =?utf-8?B?a3RsQ205TXhsd0szVkdPcVJqVnMxeGx2QzFoREI5cXIzVXBxaWExakR1YlVj?=
 =?utf-8?B?cnRHUTNsOG9RZHE1Tyt6bmFYUTc0SFcrTHZ6amcvN3grTkx6NXVmME1jbVEx?=
 =?utf-8?B?R2ZwSzhEMXUvbGxVY1hnd2dxcHBDQzFZWG12NklkcW9oaVI5eUJVMnRFSzVo?=
 =?utf-8?B?UCtHVWZEbnFJcXFWVDdkZ3d5MnEwMDhpWGpWSVo0SE5HSlZ5M2RHV2JodTBt?=
 =?utf-8?B?VHJuVlEzZktGeGVURlEraUJPMGlvbXdTc2dES21xbkgydFpjNjVQY1BFWU4z?=
 =?utf-8?B?SkxadlBQNkRHdmFnS0pZM1FONTFsZFlZOUhGZlNvWkVnTm01N3pOaWZ6enJp?=
 =?utf-8?B?aHJ1YW52TGVGSWZKUFp6Y281bFhyVWZyK1ZKVmhnQUdXR0dtMy9JU20zeGNu?=
 =?utf-8?B?a21IZkVMZVFBanE3TDNXWHVOcDc5YjBXQXlDcldaT2Q1ZXQvMi82ZlZsbnlB?=
 =?utf-8?B?YkpkZ3ZtKzNCTzZOVElBQ1l1KzNuaWp6ZlJ2d1BGWm5Xa1Y4RDhqRnBOdjRv?=
 =?utf-8?B?cHdaVGk0SGMxMUxMcW9PQXhWWDFHYzAybHR2b3JwN0c1eGxrY2w0SFFMQmt1?=
 =?utf-8?B?WXhHNnhUSnRNOTFjR0RZVXJjSktOYW1ScEJqK3BRYXUvVTdvU2Vpb3RLdlkv?=
 =?utf-8?B?K0ZYV2gzN3NmaWN6UVJYVWxuaUVPTnRUeVZ0MTB3bW5pYWtwRGlWSnQ5L1Iw?=
 =?utf-8?B?Q1luYXltQXMxVXFncld2eGM5NjYybGkwWmlheGZYVzlGM3pETGFSWlF0alI5?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4C63B33B704134C82F939F687DBB2A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcacd1a-994d-42f7-1b1c-08da6aec2828
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 07:39:34.4577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUclcQe/pw1c/nwb74JrYpLY//4oVi8kTAo90DJFcicevoMjD9OccUC+qDYRkrwoFE/PNzBnPDjP9vAm3dpu1/onbD/gO6qNGfeANxH4Xms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3337
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMDcuMjAyMiAyMjo0OSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFkZCBiYXNpYyBz
dXBwb3J0IGZvciBwY2I4MzA5LiBJdCBpcyBzaW1pbGFyIHdpdGggcGNiODI5MSB3aXRoIG9uZSBi
aWcNCj4gZGlmZmVyZW5jZSB0aGF0IGlzIGhhdmluZyAyIFNGUCBjYWdlcy4gVGhlcmVmb3JlIGl0
IGhhcyA0IG5ldHdvcmsgcG9ydHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIb3JhdGl1IFZ1bHR1
ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290
L2R0cy9NYWtlZmlsZSAgICAgICAgICAgIHwgICAzICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9s
YW45NjZ4LXBjYjgzMDkuZHRzIHwgMTg5ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDE5MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MzA5LmR0cw0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlIGIvYXJjaC9hcm0vYm9v
dC9kdHMvTWFrZWZpbGUNCj4gaW5kZXggMTg0ODk5ODA4ZWU3Li42YTYxNjZlM2E0MDUgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+ICsrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL01ha2VmaWxlDQo+IEBAIC03NzIsNyArNzcyLDggQEAgZHRiLSQoQ09ORklHX1NPQ19J
TVhSVCkgKz0gXA0KPiAgZHRiLSQoQ09ORklHX1NPQ19MQU45NjYpICs9IFwNCj4gIAlsYW45NjZ4
LXBjYjgyOTEuZHRiIFwNCj4gIAlsYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10LTZnLTJn
cy5kdGIgXA0KPiAtCWxhbjk2Nngta29udHJvbi1rc3dpdGNoLWQxMC1tbXQtOGcuZHRiDQo+ICsJ
bGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC04Zy5kdGIgXA0KPiArCWxhbjk2NngtcGNi
ODMwOS5kdGINCj4gIGR0Yi0kKENPTkZJR19TT0NfTFMxMDIxQSkgKz0gXA0KPiAgCWxzMTAyMWEt
aW90LmR0YiBcDQo+ICAJbHMxMDIxYS1tb3hhLXVjLTg0MTBhLmR0YiBcDQo+IGRpZmYgLS1naXQg
YS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgzMDkuZHRzIGIvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC1wY2I4MzA5LmR0cw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAw
MDAwMDAwMDAwMDAuLmVmNDQxMTk1ZThjMQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODMwOS5kdHMNCj4gQEAgLTAsMCArMSwxODkgQEANCj4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCsgT1IgTUlUKQ0KPiArLyoNCj4g
KyAqIGxhbjk2NnhfcGNiODMwOS5kdHMgLSBEZXZpY2UgVHJlZSBmaWxlIGZvciBQQ0I4MzA5DQo+
ICsgKi8NCj4gKy9kdHMtdjEvOw0KPiArI2luY2x1ZGUgImxhbjk2NnguZHRzaSINCj4gKyNpbmNs
dWRlICJkdC1iaW5kaW5ncy9waHkvcGh5LWxhbjk2Nngtc2VyZGVzLmgiDQo+ICsNCj4gKy8gew0K
PiArCW1vZGVsID0gIk1pY3JvY2hpcCBFVkIgLSBMQU45NjYyIjsNCj4gKwljb21wYXRpYmxlID0g
Im1pY3JvY2hpcCxsYW45NjYyLXBjYjgzMDkiLCAibWljcm9jaGlwLGxhbjk2NjIiLCAibWljcm9j
aGlwLGxhbjk2NiI7DQo+ICsNCj4gKwlhbGlhc2VzIHsNCj4gKwkJc2VyaWFsMCA9ICZ1c2FydDM7
DQo+ICsJCWkyYzEwMiA9ICZpMmMxMDI7DQo+ICsJCWkyYzEwMyA9ICZpMmMxMDM7DQo+ICsJfTsN
Cj4gKw0KPiArCWNob3NlbiB7DQo+ICsJCXN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgi
Ow0KPiArCX07DQo+ICsNCj4gKwlncGlvLXJlc3RhcnQgew0KPiArCQljb21wYXRpYmxlID0gImdw
aW8tcmVzdGFydCI7DQo+ICsJCWdwaW9zID0gPCZncGlvIDU2IEdQSU9fQUNUSVZFX0xPVz47DQo+
ICsJCXByaW9yaXR5ID0gPDIwMD47DQo+ICsJfTsNCj4gKw0KPiArCWkyYy1tdXggew0KPiArCQlj
b21wYXRpYmxlID0gImkyYy1tdXgiOw0KPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJ
I3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCW11eC1jb250cm9scyA9IDwmbXV4PjsNCj4gKwkJaTJj
LXBhcmVudCA9IDwmaTJjND47DQo+ICsNCj4gKwkJaTJjMTAyOiBpMmMtc2ZwQDEgew0KPiArCQkJ
cmVnID0gPDE+Ow0KPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkjc2l6ZS1jZWxs
cyA9IDwwPjsNCj4gKwkJfTsNCj4gKw0KPiArCQlpMmMxMDM6IGkyYy1zZnBAMiB7DQo+ICsJCQly
ZWcgPSA8Mj47DQo+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJCSNzaXplLWNlbGxz
ID0gPDA+Ow0KPiArCQl9Ow0KPiArCX07DQo+ICsNCj4gKwltdXg6IG11eC1jb250cm9sbGVyIHsN
Cj4gKwkJY29tcGF0aWJsZSA9ICJncGlvLW11eCI7DQo+ICsJCSNtdXgtY29udHJvbC1jZWxscyA9
IDwwPjsNCj4gKw0KPiArCQltdXgtZ3Bpb3MgPSA8JnNncGlvX291dCAxMSAwIEdQSU9fQUNUSVZF
X0hJR0g+LCAvKiBwMTFiMCAqLw0KPiArCQkJICAgIDwmc2dwaW9fb3V0IDExIDEgR1BJT19BQ1RJ
VkVfSElHSD47IC8qIHAxMWIxICovDQo+ICsJfTsNCj4gKw0KPiArCXNmcDI6IHNmcDIgew0KPiAr
CQljb21wYXRpYmxlID0gInNmZixzZnAiOw0KPiArCQlpMmMtYnVzID0gPCZpMmMxMDI+Ow0KPiAr
CQl0eC1kaXNhYmxlLWdwaW9zID0gPCZzZ3Bpb19vdXQgMTAgMCBHUElPX0FDVElWRV9MT1c+Ow0K
PiArCQlsb3MtZ3Bpb3MgPSA8JnNncGlvX2luICAyIDAgR1BJT19BQ1RJVkVfSElHSD47DQo+ICsJ
CW1vZC1kZWYwLWdwaW9zID0gPCZzZ3Bpb19pbiAgMiAxIEdQSU9fQUNUSVZFX0xPVz47DQo+ICsJ
CXR4LWZhdWx0LWdwaW9zID0gPCZzZ3Bpb19pbiAgMSAwIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiAr
CX07DQo+ICsNCj4gKwlzZnAzOiBzZnAzIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJzZmYsc2ZwIjsN
Cj4gKwkJaTJjLWJ1cyA9IDwmaTJjMTAzPjsNCj4gKwkJdHgtZGlzYWJsZS1ncGlvcyA9IDwmc2dw
aW9fb3V0IDEwIDEgR1BJT19BQ1RJVkVfTE9XPjsNCj4gKwkJbG9zLWdwaW9zID0gPCZzZ3Bpb19p
biAgMyAwIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArCQltb2QtZGVmMC1ncGlvcyA9IDwmc2dwaW9f
aW4gIDMgMSBHUElPX0FDVElWRV9MT1c+Ow0KPiArCQl0eC1mYXVsdC1ncGlvcyA9IDwmc2dwaW9f
aW4gIDEgMSBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwl9Ow0KPiArfTsNCj4gKw0KPiArJmZseDMg
ew0KPiArCWF0bWVsLGZsZXhjb20tbW9kZSA9IDxBVE1FTF9GTEVYQ09NX01PREVfVVNBUlQ+Ow0K
PiArCXN0YXR1cyA9ICJva2F5IjsNCj4gKw0KPiArCXVzYXJ0Mzogc2VyaWFsQDIwMCB7DQo+ICsJ
CXBpbmN0cmwtMCA9IDwmZmMzX2JfcGlucz47DQo+ICsJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVs
dCI7DQo+ICsJCXN0YXR1cyA9ICJva2F5IjsNCj4gKwl9Ow0KPiArfTsNCj4gKw0KPiArJmZseDQg
ew0KPiArCWF0bWVsLGZsZXhjb20tbW9kZSA9IDxBVE1FTF9GTEVYQ09NX01PREVfVFdJPjsNCj4g
KwlzdGF0dXMgPSAib2theSI7DQoNCkVtYmVkIGkyYzQgbm9kZSBoZXJlIGFzIHlvdSBkaWQgZm9y
IHVzYXJ0MyBhYm92ZS4gSXQncyBlYXN5IHRvIGZvbGxvdyB0aGUNCmNvbm5lY3Rpb24gYi93IGZs
eCBub2RlIGFuZCBpdCdzIGVuYWJsZWQgY2hpbGQuDQoNCj4gK307DQo+ICsNCj4gKyZncGlvIHsN
Cj4gKwlmYzNfYl9waW5zOiBmYzMtYi1waW5zIHsNCj4gKwkJLyogUlhELCBUWEQgKi8NCj4gKwkJ
cGlucyA9ICJHUElPXzUyIiwgIkdQSU9fNTMiOw0KPiArCQlmdW5jdGlvbiA9ICJmYzNfYiI7DQo+
ICsJfTsNCj4gKw0KPiArCWZjNF9iX3BpbnM6IGZjNC1iLXBpbnMgew0KPiArCQkvKiBTQ0wsIFNE
QSAqLw0KPiArCQlwaW5zID0gIkdQSU9fNTciLCAiR1BJT181OCI7DQo+ICsJCWZ1bmN0aW9uID0g
ImZjNF9iIjsNCj4gKwl9Ow0KPiArDQo+ICsJc2dwaW9fYV9waW5zOiBzZ3Bpby1hLXBpbnMgew0K
PiArCQkvKiBTQ0ssIEQwLCBEMSwgTEQgKi8NCj4gKwkJcGlucyA9ICJHUElPXzMyIiwgIkdQSU9f
MzMiLCAiR1BJT18zNCIsICJHUElPXzM1IjsNCj4gKwkJZnVuY3Rpb24gPSAic2dwaW9fYSI7DQo+
ICsJfTsNCj4gK307DQo+ICsNCj4gKyZpMmM0IHsNCj4gKwljb21wYXRpYmxlID0gIm1pY3JvY2hp
cCxzYW05eDYwLWkyYyI7DQo+ICsJcmVnID0gPDB4NjAwIDB4MjAwPjsNCj4gKwlpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgNTIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsJI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ICsJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsJY2xvY2tzID0gPCZuaWNfY2xrPjsN
Cj4gKwlwaW5jdHJsLTAgPSA8JmZjNF9iX3BpbnM+Ow0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQo+ICsJaTJjLWFuYWxvZy1maWx0ZXI7DQo+ICsJaTJjLWRpZ2l0YWwtZmlsdGVyOw0K
PiArCWkyYy1kaWdpdGFsLWZpbHRlci13aWR0aC1ucyA9IDwzNT47DQo+ICsJaTJjLXNkYS1ob2xk
LXRpbWUtbnMgPSA8MTUwMD47DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiAr
Jm1kaW8xIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmcGh5MCB7DQo+
ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnBoeTEgew0KPiArCXN0YXR1cyA9
ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZwb3J0MCB7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0K
DQpLZWVwIHN0YXR1cyBhdCB0aGUgZW5kIG9mIG5vZGUgZGVzY3JpcHRpb24gZm9yIHVuaWZvcm1p
dHkgd2l0aCB0aGUgbm9kZXMNCmVuYWJsZWQgYWJvdmUuIFNhbWUgZm9yIHRoZSByZXN0IG9mIG5v
ZGVzIGJlbG93Lg0KDQo+ICsJcGh5LWhhbmRsZSA9IDwmcGh5MD47DQo+ICsJcGh5LW1vZGUgPSAi
Z21paSI7DQo+ICsJcGh5cyA9IDwmc2VyZGVzIDAgQ1UoMCk+Ow0KPiArfTsNCj4gKw0KPiArJnBv
cnQxIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICsJcGh5LWhhbmRsZSA9IDwmcGh5MT47DQo+
ICsJcGh5LW1vZGUgPSAiZ21paSI7DQo+ICsJcGh5cyA9IDwmc2VyZGVzIDEgQ1UoMSk+Ow0KPiAr
fTsNCj4gKw0KPiArJnBvcnQyIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICsJc2ZwID0gPCZz
ZnAyPjsNCj4gKwltYW5hZ2VkID0gImluLWJhbmQtc3RhdHVzIjsNCj4gKwlwaHktbW9kZSA9ICJz
Z21paSI7DQo+ICsJcGh5cyA9IDwmc2VyZGVzIDIgU0VSREVTNkcoMCk+Ow0KPiArfTsNCj4gKw0K
PiArJnBvcnQzIHsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICsJc2ZwID0gPCZzZnAzPjsNCj4g
KwltYW5hZ2VkID0gImluLWJhbmQtc3RhdHVzIjsNCj4gKwlwaHktbW9kZSA9ICJzZ21paSI7DQo+
ICsJcGh5cyA9IDwmc2VyZGVzIDMgU0VSREVTNkcoMSk+Ow0KPiArfTsNCj4gKw0KPiArJnNlcmRl
cyB7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiArJnNncGlvIHsNCj4gKwlz
dGF0dXMgPSAib2theSI7DQo+ICsJcGluY3RybC0wID0gPCZzZ3Bpb19hX3BpbnM+Ow0KPiArCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJbWljcm9jaGlwLHNncGlvLXBvcnQtcmFuZ2Vz
ID0gPDAgMz4sIDw4IDExPjsNCg0KRXhjZXB0IHRoaXMgb25lLiBGb3IgdGhpcyB3b3VsZCBiZSBu
aWNlIHRvIGhhdmUgc3RhdHVzIGhlcmUgYmVmb3JlDQpkZXNjcmliaW5nIGNoaWxkcy4NCg0KPiAr
CWdwaW9AMCB7DQo+ICsJCW5ncGlvcyA9IDw2ND47DQo+ICsJfTsNCj4gKwlncGlvQDEgew0KPiAr
CQluZ3Bpb3MgPSA8NjQ+Ow0KPiArCX07DQo+ICt9Ow0KPiArDQo+ICsmc3dpdGNoIHsNCj4gKwlz
dGF0dXMgPSAib2theSI7DQo+ICt9Ow0KDQo=
