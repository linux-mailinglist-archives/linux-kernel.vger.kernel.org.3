Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF0570371
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiGKM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiGKM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:56:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C35B2A954
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657544187; x=1689080187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H1NGFQDl1MDoEEK/sn2Q2LP5VJVYEJxTD0fTNT6cZro=;
  b=pJjgN1pO5Ip8Chfgje1/7cuoQL9yykeGA+nzdlHgLEGAmool/SAYByEJ
   O8FokMfkEZ4a6v6DFssPW76p8+f+/GQV89nkSJbE+rLMEn5vPTzkiUtmk
   gjmVjpcvDirsGD4LJIBFJe91N/6xxK9dKXfUDfn25gsyHAP/DfWDGUJuj
   7XoAyJHlGPFRoi45EB9vnjYCVEMN9c24tFxPT24sAOCUl23dxe8ivhNoX
   WaD9Q2lGOaGWvU+SSALPKuZyrKlJ1nxSQyRuc50X7PCz6xBrMx9us3B0Y
   x7581ITE0guZIUZHKUVwiHqi3BTGCpUlWse1WKn4pDAYgKNjA5iQyAyQ+
   w==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="167279723"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 05:56:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 05:56:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 05:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqEzoYew/FeAq2QPp/GbzQabAa/GHCAkSyHnQ8znPErUUlUsmqmMpTBLpJuIb7KNfiS5RnAU8UFm4tUO8ljm6EJQp4PoBrW6LZNlMWsPvMIKVqVcyDBDc+CHHUCAAo1s7w9TsZx4iaB/z2s+JET4GWM+VtF+RMqSynpP3j2767QUJWtQLCeT2ORC82vVV1DCKrgMK3mvnaHf8jDaKrNKGSx6Sv5uUg35iEAcjD7X8Mzru3oFomVr5KekDLU20ibk6niSKwtxlxrmoxbb7smnHoiwnn4FmIrIgQdIOkIIdwAiAHeEx4hBdMYOH8cmKS9CMvdV+cBjPH3Kmnr/rFlCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1NGFQDl1MDoEEK/sn2Q2LP5VJVYEJxTD0fTNT6cZro=;
 b=ARCpmyIGjdq32k6DVvihoYR4SJpW0lQYZfInayW5ht9+KBYysq0V1sm+0rept4vp4Fkab05EN9XGvylWJQTHCnFEh4NGym51MhOYtN4ZffhOE4XGT3FOcXWBfyBz58vx5jODTq2IIgW8KHCIaKjL0P/NG1UZoh1dbEeiUOvhlPVkRKgAuWy9mMKpB0ai9XDpJXJjxOTyh3wRzdJF8cp6U81GZi6QuFxvaM7t2UEx+CMF2qcWhHBUdlV+s9xBUd0efu6CVfT46IPFlg1cNwVoVveF359jQkTRFk4f3htwdK+AvIM/qnGBGX/dKzdrZrWD1bGramTUtq10/+U5V1Lnog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1NGFQDl1MDoEEK/sn2Q2LP5VJVYEJxTD0fTNT6cZro=;
 b=O3dm89B92f0M5zV08ken0c4JQeWxlUmeg5imvhhDztg4ra5gxqfWi7b2ORXS0/M+N6K1uMXomEj4MH+qvcWdEZXjzJeFmtaKAETyTZNU3GixO5btLTK3fng2Zn35P8o49Cs9FjuoR4SnJGvdDGhyGbax13bDCKznx2+h3xwbNzA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB4091.namprd11.prod.outlook.com (2603:10b6:5:197::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 12:56:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 12:56:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ben.dooks@sifive.com>, <Conor.Dooley@microchip.com>,
        <robin.murphy@arm.com>, <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <iommu@lists.linux-foundation.org>, <sudip.mukherjee@sifive.com>,
        <jude.onyenegecha@sifive.com>, <m.szyprowski@samsung.com>,
        <Daire.McNamara@microchip.com>
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Thread-Topic: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Thread-Index: AQHYlRyqCglqeptGyE+tRp+rve6Wy615HgsAgAAC/YA=
Date:   Mon, 11 Jul 2022 12:56:16 +0000
Message-ID: <762b3f80-a925-0a00-1386-b190fe17ea59@microchip.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
 <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
 <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de>
 <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
 <20220711103921.GA6542@lst.de>
 <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com>
 <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com>
 <fc216e29-7dfb-5265-33d1-b547b8b7bd52@microchip.com>
 <7906385d-d3f5-113a-4d31-8e9564c3c6ab@sifive.com>
In-Reply-To: <7906385d-d3f5-113a-4d31-8e9564c3c6ab@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b66f4dc6-59c9-47ca-bb03-08da633cbdf3
x-ms-traffictypediagnostic: DM6PR11MB4091:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRpiytuokVyiy8m+6I9x1NQyA+JiVT3RqeECFH46AYTJ+v0nSg79EjwHi28RctryS22rLZrQK639qXjYo9n/Zx7fxeDfzgQt88BqEvONnOw4f3odm2VUSIWQOalXhi1QsbjWP2YcbvRaAkxQQaRFUoGLloyufH27l32UaJ1tkAeUrAZ+4fe4GhtBWsEtkNmUc48qH2p2ceenI58SoAz3OrsdMW84eYSdu8Qb8kySLJ4Nx2JMWTmP2Kla03C9tUOPeqS4EEkfM915qLBfkZCi2H82KGYfN4ie1evJsx2G3S56rRTdg67DWQSl/CV363Dg4EsGiUdcGI3XAbccdTh7KTgYP694pDsJhZXrJGOwNYj6OHee50tqo0++jYei3r11cGFDObirhvVP6nZxQksuqoSNtVPlt4c4JlPjF91p7Wtdjs4886SPo4iPQAXkPQoRYpTbhZp3vChleUmq0VgpVrKrwqNmK/u2IDoG8E4wGHwTEr8P8urCvVw0TCsdTsfIj3d8mqjTF454O2o4V7lwDJOEXBg8jVWMQEFOE8C4OPMSBWn+EFrGTA0BK52fEu4GV5friddKECjlvfuuRS5e0xnZw34r4RuZOF4HjiRyAqB/89UpD6/WSqdxwcnpcTJApS2nb4zNXrTZcXKClBDFyZJF1dQ4GCcjZ/sDutwL2GXdYb/3pIG+nRgC00ofUWkdUk+HYHMVTm9/B8KaP6Axq/s6jOSzyEB28I0WzGaRu3o4QlwmNIEvZ1oJz77UaynrJZl2rrO00e/EeS8moG7UBVgwGywRMP3c52dsZcJ9g6TBmT5zvDdpjYQvBGRma82wEUieZ7zlzFqpemt0D/ZDotFnX7M9UENxQCbZxf1Gt0pBjMXNC7veYk+g8rq+Deni
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(39860400002)(346002)(396003)(38100700002)(186003)(122000001)(5660300002)(83380400001)(110136005)(66446008)(4326008)(71200400001)(54906003)(66946007)(66476007)(66556008)(316002)(36756003)(8676002)(91956017)(31686004)(64756008)(26005)(76116006)(6512007)(2906002)(31696002)(6486002)(8936002)(53546011)(41300700001)(478600001)(2616005)(38070700005)(107886003)(6506007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXVIc04xN1QxTFVXa2NLQkdXeTVrZnRIaUM2emlYNGFZRXlpQzBoSHNIVlEz?=
 =?utf-8?B?U0czTjRpUGFIWjdCeHJvMy9oLzBnWmhYdTFTK0Y2UHpMZUdQaTRJcTMzam5G?=
 =?utf-8?B?NnBPbExzUzNIVEpXR2VyVGVXS2s3TTZyQ09tYjBGTm16VE5Fa21ZR3Jkd0hz?=
 =?utf-8?B?NnlYaDE0OFdXanhZeVA5Sm50K2V5aHBqcWhDcUJyR3ViY1ZyL1dXbXpidmxQ?=
 =?utf-8?B?NGRpSzJJTm5GUlE4eE03MXplM0xmZHkyRCszRFVibU8xdjJnQkNsRXlaMVRq?=
 =?utf-8?B?L1R3RGV3NWt0R0dLbXlQQVFpYk9VR3F2Wk1RaEZtaG9nZVcvTGJXc3FPNWhM?=
 =?utf-8?B?czF1TWRmenIvREpNRitBVDN4a1dKc2FuaGJLR2VRc0hteEY3NXlTc1dNNDRv?=
 =?utf-8?B?ellGQStYK3lqN0Jid0VxNTljZ3hVM09WTjV0QlVjemhzWFJJUnVSUHlBeVR2?=
 =?utf-8?B?YVN2alBYM2J1VTM3YkhjMmE4bFAvUDIvU2dPeXRlbWZZaldJdVVNTTd2Yzg0?=
 =?utf-8?B?ODUzblAyMHBmN2NVdmJlUGFVS1ZWSE00dUdjS2NXK1FNbVFiQnROUktMQ0ts?=
 =?utf-8?B?TEJiTG9NMDh0WmgySEVCS3lvZ0IrTmFRcmtEUXZCdXo5R1F1Y2JhbGhySUZ3?=
 =?utf-8?B?Q2I4RnFsaWpVK0lZOHptcmFEU3dSdThEa2JWcG1pcWRJUzZGRzdCUTFxN1ZJ?=
 =?utf-8?B?angvalFGTGJ3ZlZCUW1iM3dBSzdSZ1IwOUI3RllPRUlyQVF5WUpaZFhWUVQy?=
 =?utf-8?B?djFIaStGTSt3cTIvUlExMDU2aTBqd1ptcWE5TDY1K1JPWHA1MVlKdGx4akdj?=
 =?utf-8?B?TEduNWt6dS9zMjVDckNFTVFpRjlLSzhoanR6cnIwSDNiWUlLVHVFZmYwNkJF?=
 =?utf-8?B?aTdDbE5tcGtKYmxENUxvcnQ2Q05ZYWYwM2laWDJoY3V1bUU1Qldma1k4dHVl?=
 =?utf-8?B?cHdxVHlWbk1jMTdhRzg2Q0l5UUhteUxGQUY4NEtRM2U4Y0gyRkpUU0RzZUZ1?=
 =?utf-8?B?UHQ1bk1DRGYzVE5jb1VCYXhpazZNanBOR3RzY251Yjl6OE1vZnljZWIyN0xD?=
 =?utf-8?B?NW1ubXdBWWFaVDdxYWNTQk1RNlBJdkNRZTZROTNWSmJKUTlMRWo2dGhkRzcv?=
 =?utf-8?B?VHVUbm1CL0pmdlVRZEEwMWJndWttd3BxaEtGdmhRcjNIblR0QjFvMDlEQm45?=
 =?utf-8?B?a2FyUklzRTFXeVp0dzVITjBWQ25USEJVeTZIa0plU2Fpd0NqbUdvV0lsQ2ZU?=
 =?utf-8?B?eTh2ZzJhTWFrTmh4SFR5OVdTR3RWQXMyd0FCbTZQbjZWbWhrcXJxRmgvT0c0?=
 =?utf-8?B?QlVVc1FqdDFTeThhRlF2V0ZQcUhvUTFKQVFNWkN4ejgzSjR5bkVPTVJpdklI?=
 =?utf-8?B?a2w1WFJDaGlYekJ5OHZlNEZYMEVDVmpQMURJczYyQ3U5Vm1NMHpHTEc1UlRp?=
 =?utf-8?B?dm9ic3dGOUFKaXhpVWE3L2RFaXhVOHlkcTJPOHc4LzRtbWFQOUxDcWVXWVNE?=
 =?utf-8?B?UVJic2lDaWpsMDkrYUIvaWdEdlJmR2JiWE9KYXg3ak5YbTQ2bVd6Ly9YZW9w?=
 =?utf-8?B?QmpTZ0s3U1Q5MDA3cnE4ZUJ5REpPQ3M2UXpidndvMFYxSS8yajZDOTV6LzNv?=
 =?utf-8?B?VEJGQXl6UWtjbjNrVmhpTm5hNTRHV3p4UE1LTncyOVdJOXBFRUxzYUxnQkM2?=
 =?utf-8?B?Q1QwYkxwR2JEeXptL29hZVZ1NDl3Wm9rYzRGYjNJclhCcWtiNzQ5dmF1cktP?=
 =?utf-8?B?YWtzd3lKSDVzVGZoYzdFZytxWjEzV3RVS2pnSENFWDcvMFRtbC9hWXBWU2Vn?=
 =?utf-8?B?eHljb1ExY2pjOEhvMkpNMVBTTC94U1VtMkxldnA2QTFYczd2a245amd4aW4y?=
 =?utf-8?B?cFNaNmtENXQyWXhVZGlCOHk5Zzc5VzVQU3pmcldtK0J3UEY1ODRtZUVnOGhR?=
 =?utf-8?B?TEtjRFBHcDNROWRuZ1dNb0dVUXhEcUJsSDNMTlhLTFkrR3ovZE40ZEdqTExn?=
 =?utf-8?B?ZXRGMkgyZFcrREg1YThDa3NyNHBJaW44M3lCMm1ERmYrS0tJb0ZXYlVvdXhU?=
 =?utf-8?B?eGFrMURGbTVSL1ZUKzlVSG1NVFp3SnNROGxWemlsQmszQWpUTlM3T28wYmdm?=
 =?utf-8?Q?Qj2BjTxwE8MhkpYysYr3xCjNS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8F44B6D6A230245B8C814109558AE21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66f4dc6-59c9-47ca-bb03-08da633cbdf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 12:56:16.1932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/IlROz4vA41Tt33TkgEQvVhxVPrqlAZ70sKXl5eU2uhxsONLcoysLNihVU0S3Q2dKzdp2PTLMNakjtOQY9zJg3+Ua8bPKErUPENTJir5NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4091
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDcvMjAyMiAxMzo0NSwgQmVuIERvb2tzIHdyb3RlOg0KPiBPbiAxMS8wNy8yMDIyIDEy
OjUyLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMTEv
MDcvMjAyMiAxMjowMSwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPj4+IE9uIDIwMjItMDctMTEgMTE6
NDIsIEJlbiBEb29rcyB3cm90ZToNCj4+Pj4gT24gMTEvMDcvMjAyMiAxMTozOSwgQ2hyaXN0b3Bo
IEhlbGx3aWcgd3JvdGU6DQo+Pj4+PiBPbiBNb24sIEp1bCAxMSwgMjAyMiBhdCAxMToyNDo1MUFN
ICswMTAwLCBCZW4gRG9va3Mgd3JvdGU6DQo+Pj4+Pj4gT24gMTEvMDcvMjAyMiAxMToyMSwgQ2hy
aXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+Pj4+Pj4+IE9uIE1vbiwgSnVsIDExLCAyMDIyIGF0IDEx
OjA3OjE3QU0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4+Pj4+Pj4+IElmIG5vbmUgb2Yg
eW91ciBwZXJpcGhlcmFscyBzaG91bGQgbmVlZCBTV0lPVExCLCB0aGVuIHRoZSBmYWN0IHRoYXQN
Cj4+Pj4+Pj4+IHlvdSdyZSBlbmRpbmcgdXAgaW4gc3dpb3RsYl9tYXAoKSBhdCBhbGwgaXMgYSBj
bGVhciBzaWduIHRoYXQNCj4+Pj4+Pj4+IHNvbWV0aGluZydzIHdyb25nLiBNb3N0IGxpa2VseSBz
b21lb25lJ3MgZm9yZ290dGVuIHRvIHNldCB0aGVpciBETUENCj4+Pj4+Pj4+IG1hc2tzIGNvcnJl
Y3RseS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gWWVzLg0KPj4+Pj4+DQo+Pj4+Pj4gUG9zc2libHksIHdl
IGhhZCBhdCBsZWFzdCBvbmUgZHJpdmVyIHdoaWNoIGF0dGVtcHRlZCB0byBzZXQgYSAzMiBiaXQN
Cj4+Pj4+PiBETUEgbWFzayB3aGljaCBoYWQgdG8gYmUgcmVtb3ZlZCBhcyB0aGUgRE1BIGxheWVy
IGFjY2VwdHMgdGhpcyBidXQNCj4+Pj4+PiBzaW5jZSB0aGVyZSBpcyBubyBETUEzMiBtZW1vcnkg
dGhlIGFsbG9jYXRvciB0aGVuIGp1c3QgZmFpbHMuDQo+Pj4+Pj4NCj4+Pj4+PiBJIGV4cGVjdCB0
aGUgYWJvdmUgbWF5IG5lZWQgdG8gYmUgYSBzZXBhcmF0ZSBkaXNjdXNzaW9uKHMpIG9mIGhvdyB0
bw0KPj4+Pj4+IGRlZmF1bHQgdGhlIERNQSBtYXNrIGFuZCBob3cgdG8gc3RvcCB0aGUgaW1wbGlj
aXQgYWNjZXB0YW5jZSBvZiBzZXR0aW5nDQo+Pj4+Pj4gYSAzMi1iaXQgRE1BIG1hc2suDQo+Pj4+
Pg0KPj4+Pj4gTm8uwqAgTGludXggc2ltcGx5IGFzc3VtZXMgeW91IGNhbiBkbyAzMi1iaXQgRE1B
IGFuZCB0aGlzIHdvbid0DQo+Pj4+PiBjaGFuZ2UuwqAgU28gd2UnbGwgbmVlZCB0byBmaXggeW91
ciBwbGF0Zm9ybSB0byBzdXBwb3J0IHN3aW90bGINCj4+Pj4+IGV2ZW50dWFsbHkuDQo+Pj4+DQo+
Pj4+IE9rLCBpcyB0aGVyZSBhbnkgZXhhbXBsZXMgY3VycmVudGx5IGluIHRoZSBrZXJuZWwgdGhh
dCBoYXZlIG5vIG1lbW9yeQ0KPj4+PiBpbiB0aGUgRE1BMzIgem9uZSB0aGF0IGRvIHVzZSBzd2lv
dGxiPw0KPj4+DQo+Pj4gVGhlIGFybTY0IGNvZGUgb3JpZ2luYWxseSBtYWRlIGFuIGFzc3VtcHRp
b24gdGhhdCBhIHN5c3RlbSB3aXRoIHRoYXQga2luZCBvZiBtZW1vcnkgbGF5b3V0IHdvdWxkIHVz
ZSBhIERNQSBvZmZzZXQgaW4gdGhlIGludGVyY29ubmVjdCwgYW5kIHNvIHBsYWNlZCBaT05FX0RN
QTMyIGluIHRoZSBmaXJzdCA0R0Igb2YgYXZhaWxhYmxlIFJBTSByYXRoZXIgdGhhbiBhY3R1YWwg
cGh5c2ljYWwgYWRkcmVzcyBzcGFjZS4gVGhlIG9ubHkgcmVsYXRpdmVseSBtYWluc3RyZWFtIHBs
YXRmb3JtIHdlIHN1YnNlcXVlbnRseSBzYXcgd2l0aCBhbGwgUkFNIGFib3ZlIDMyIGJpdHMgd2Fz
IEFNRCBTZWF0dGxlLCB3aGljaCBhbHNvICpkaWRuJ3QqIHVzZSBhIERNQSBvZmZzZXQsIHNvIGl0
ICJ3b3JrZWQiIGJ5IHZpcnR1ZSBvZiB0aGlzIGJvZGdlIGluIHRoZSBzZW5zZSB0aGF0IGFsbG9j
YXRpb25zIGRpZG4ndCBmYWlsLCBidXQgRE1BIHRyYW5zYWN0aW9ucyB3b3VsZCB0aGVuIGRpc2Fw
cGVhciBvZmYgaW50byBub3doZXJlIHdoZW4gdGhlIGRldmljZSB0cnVuY2F0ZWQgdGhlIE1TQnMg
b2Ygd2hhdGV2ZXIgdG9vLWJpZyBETUEgYWRkcmVzcyBpdCB3YXMgZ2l2ZW4uDQo+Pj4NCj4+PiBJ
IHRoaW5rIHRoYXQgc3R1ZmYncyBsb25nIGdvbmUgYnkgbm93LCBhbmQgaWYgYW55IG9mIGhhbmRm
dWwgb2YgcmVtYWluaW5nIFNlYXR0bGUgdXNlcnMgcGx1ZyBpbiBhIDMyLWJpdCBQQ0llIGRldmlj
ZSBhbmQgdHJ5IHRvIHVzZSBpdCB3aXRoIHRoZSBJT01NVSBkaXNhYmxlZCwgdGhleSdsbCBwcm9i
YWJseSBzZWUgdGhlIGZpcmV3b3JrcyBhcyBpbnRlbmRlZC4NCj4+Pg0KPj4+IE11Y2ggYXMgd2Un
ZCBsaWtlIHRvIG1ha2UgRE1BIGFuIGV4cGxpY2l0IG9wdC1pbiBmb3IgYWxsIGRyaXZlcnMsIHRo
YXQncyBzb21ldGhpbmcgd2hpY2ggY2FuIG9ubHkgcmVhbGx5IGJlIHNvbHZlZCAzMCB5ZWFycyBh
Z28uDQo+Pg0KPj4NCj4+IE91dCBvZiBjdXJpb3NpdHkgQmVuLCBjYW4geW91IHNoZWQgYW55IG1v
cmUgbGlnaHQgb24gdGhlIHBsYXRmb3JtPw0KPiANCj4gTm90IGF0IHRoZSBtb21lbnQsIHNvcnJ5
Lg0KDQpObyB3b3JyaWVzLiBGV0lXLCBpZiB5b3UgZG8gZW5kIHVwIGRvaW5nIGFueXRoaW5nIHdp
dGggbm8tRE1BMzINCnBsYXRmb3JtcyBrZWVwIG1lIENDZWQuIEkndmUgcHJldmlvdXNseSBoaXQg
bm8tRE1BMzIgcmVsYXRlZCBpc3N1ZXMNCm9uIFBvbGFyRmlyZSBTb0MsIHNvIEknZCBsaWtlIHRv
IHRlc3QgYW55dGhpbmcgdGhhdCB5b3UgbWF5IGVuZCB1cA0Kd29ya2luZyBvbi4NCg0KVGhhbmtz
LA0KQ29ub3IuDQo=
