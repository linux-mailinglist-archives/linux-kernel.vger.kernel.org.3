Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC675674C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiGEQtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiGEQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:49:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A031D30F;
        Tue,  5 Jul 2022 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657039748; x=1688575748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LDRjK5ffkKm0J9hmbWVxMb/nFdiOExXzwDWJ6ucIasM=;
  b=k+wmAq5Hsa0kVjhcA+8hR1SXw0AHnpED2KeDmu9Cg4yDY1CodZUdxyMr
   IRoRnTIJXZp+Hgo6Kd7kgQtJ5WsyW/el8xgvzPcKrs7DvG8iIx6VkAXJ9
   CxRFJFteJeJ58E3IZDuIRd3C8EURDmyTeIJ0/WJXpFAwJYu1duEqVEbxG
   wNCcf5Yto8FIWvDVGJ69ZyOugCTMXtVicFtTITsa5YfGbkf79gvAKODNL
   hpmIs2g12e7YaDQkKzZYzOpdrqo6ggoMl545x/afhqkMSCT+5uSgWbM00
   +FQq9TE/z/htiX0hpFIb/6NX/8CJ6xHXVP/7BpzfpcP2oYaG717TYtrwp
   w==;
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="163398388"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 09:49:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 09:49:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 09:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAN+GPd4RexvhNG62VlO6fplkHUJfWaQwX/TTxvieHghUdNXPOdyc78FaKye5p23xYFdreUlZ8zUrTJYZioAYRohTIlpnuRnJ8gOWVmybyz2491DbmGHpYRYHRTTElbNYhLlMCINaeqfkrdhWFqbxBcCWX6ZjtESZ5xntPeJV9/xP4EydKAGeKJI5tEBQw6dRgN6yy5bGS+sXoYc6dLIdIGNJ5EKz2vRC097ohplSoWgaE7mw3pwLHaVCcX4j5BDX0c9Jz+hAcV5u/O7EBXrIm1LQDm31/jatn3m4HR5jeIq7fP3swUGJ37kOZbsSpowu/dxV44hyDByhmphklhwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDRjK5ffkKm0J9hmbWVxMb/nFdiOExXzwDWJ6ucIasM=;
 b=ZiOrUe793GXqmFPHNPshNrxRMYeeexAMxhPZd4Jb5DIHG4RHSfXoiyBp2W83/ILrrIxGQ6JczGC+0YVlZhZfEvPp3SP6rf95jZWhgMCjaFi+kBlZlnohlv+yF2Z7BApYxqL81HOkOmfWpOwC9GIP60pqzYpxx0kA5C8AGX3wLRXLEPWrwwWXjzTlUmoFklAd9nG1esD0BTQWL0xMswkfmwEGwYLGJekQQCoXPUQk/kRHV56IgKwSOSy0anIFSVpH4XYR+DLoJEivfj7k2uUIzGHRYyINJ73tY2UStMGo6xxBN5nFW4YtcrHDNS5UW1tgsNpfOhrgYvadhg71WLfl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDRjK5ffkKm0J9hmbWVxMb/nFdiOExXzwDWJ6ucIasM=;
 b=JN6cEk52n83/qdpRH1/u5OZCcp8f17AIKDA8ly5FeLyjPgm7ZAz6FhkUYKv6mZc5MD2ge+dKyTkaCyzpW/8+TgzrEJCbHvfvqrmi5t9hyx3tQv2vi6Njm1/ryLg2JPVmiZ+WRQQdhSGNP4V14R0KdUSgxwl/IO62fZF4sxnKR2o=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1426.namprd11.prod.outlook.com (2603:10b6:405:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 16:49:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 16:49:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Ryan.Wanner@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Alexandre.Berna@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2/trivial: Fixed typo in i2s1 node
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2/trivial: Fixed typo in i2s1 node
Thread-Index: AQHYkI8grTwQjAFo/E2H2eYuJ3fXlQ==
Date:   Tue, 5 Jul 2022 16:49:01 +0000
Message-ID: <778dbfe3-6f52-e092-9bb4-b4818b523510@microchip.com>
References: <20220705164250.19636-1-Ryan.Wanner@microchip.com>
In-Reply-To: <20220705164250.19636-1-Ryan.Wanner@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca773a33-c842-45dd-abd3-08da5ea6436b
x-ms-traffictypediagnostic: BN6PR11MB1426:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4UzjHx+vkPqbXA8nw2tc1AtQKd4sEzTQxzZwP00QicTHAamTc4mGdQLoCwtVB0bJ0nAfUUaPK74fngztVlO5XM9nujQEUpll4x+7uAGTLakvzSK12Y9lAh3xBW6DQpbbekxXswO9QZUvwfvZnvydDANFMWoT0/tVAv8quCpwsguhGUJCJtGgQ1cDWuXvYevJ1t/SLwEjXNMlj8G9c8nnJ7gLG5V37lB9q360gT4LVRFF3g7AjOqWXjNBdujEf/5edUZDAmypJlWTtKxhdSEXrF/By5nSIlW5jUeIenmcvx8gk27A0IsTmoPWySu/LaOPu8+EjzwXewc8LPAXK6gDfgwn26uc2EPuukZsDZjj8jTl5GezJktsI7UYtAiDHAr7XFRCuS/eNy6cMJPJdHH5X+7fq+djz5u8iKnWYR3lye2AuH0Jl96YmWeD4QlAEkcYMRlzHiEcr+e0gNSeNaqDd8+ea+nsXX8942aV4KcPks1kZ1oqLNdDQUNfFb7uk6BuAnYtcEaaeVLKf4CEjC++lWtsIauRFTBYZTh7GdFv07Ec9CSOK5yvb+QRCfAn/EAqxOYJo556rf9+3GNiQnddvYf57FzvZeRKqgADsvjVV65kfSaSVN5WH7o2i7fUG4Q7cTNSzbmm9ukliUu476rOVlocb4SZw4tefjQAhX0t6VVVegDXZAad9RaKd5FDXjJieIBfatY2KKsPDCpeFSf0znyiX9wfO3QEz9HhQI1xnqvU/fFA3LKwUNQYbRqwKgJf0415YClR16XVxdlCYREe/BcYDWQHiW/KibsVCPERmQE4/gORrRPpEsd+hsdM+C4WCLy+f3kZuKRiWMEtL0y2jGoLApndpNsOrAdV2tp4dJbHk8PAvMitQ9AOupky4FK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(346002)(39860400002)(83380400001)(186003)(91956017)(71200400001)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(4326008)(66446008)(478600001)(86362001)(31696002)(6486002)(4744005)(8936002)(5660300002)(26005)(38070700005)(122000001)(6512007)(38100700002)(41300700001)(2616005)(53546011)(2906002)(6506007)(110136005)(54906003)(316002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a21MMmQvc2hjSlhXWVRxQlhkOWdwZEQ3Q0NVbktyektUdWhJU2k1NHdtb0VF?=
 =?utf-8?B?emMxMTVlQjBCQWFpNVk4bDg2dDBxZTBWUHNPSHBOZmZJQ3hWUFJzREpPaXBt?=
 =?utf-8?B?dkM1TnZCSTdEK3MvV005NTA3SXpmdHoyRHhqZGFGS081ZmNWR2ZFUTNPTUFI?=
 =?utf-8?B?WWVQTE9sV241YjFMOFVDWkpMMUp1WlRDNnBCbkg2c2lXVnVaUFVNQTQ5L0Ix?=
 =?utf-8?B?M3dNWE9CWmNJYmx2d1dPTjVxTXdycllBaXNKaHlkTWl6SXgwNCtVUStaY0dm?=
 =?utf-8?B?YnRWRlVYRXZDQlJMajI0YjR6dmRYdzMxOTQvRkNURE9wRWt3MEpGT09ISjZa?=
 =?utf-8?B?cDVlc1BibU9KcENIalJOaUtvYlZzMmNuWGN6b0NlR1dlTnhzSi8rdjY1b1Vp?=
 =?utf-8?B?ZDJnSFkreFJUVGxpSnl4TXpjdDRJK2N6cjB6NzQzTzV2eFdZYmw0bXZvQ01w?=
 =?utf-8?B?Z2hlL3loQlMyUUVmOGl3ZTJ5cS9ocW5RVWJUbG10VnM0Z1ZvQjIxYnJQeGpS?=
 =?utf-8?B?K294M3ZGNERBclhVc213cnhvRHNrNGZkYWltbllZSXRPemJocEoxQm00aTVo?=
 =?utf-8?B?WHVyaVgzVGw5UjhOVnVMd3JjdmN6K2IzbWwwL3JwMVIvVjNIU1ArVllpMVFa?=
 =?utf-8?B?TU42U2dLZDZLNnYveE5FeEt0ZDRiakY0QkJjUEJSa0lleVdCQ2dvUVV3RHpT?=
 =?utf-8?B?aUM1aE9TenlkOFo4V000bHdVcFlqbERaTVg4YS8rc0JqN3F5b3pQSW9wVmlJ?=
 =?utf-8?B?dlFxcUUxdTZ3V3ZHU3hQdmo1a2lOdENQQWljRDhWTHRMMXUrUlQ0RTB3K0Y0?=
 =?utf-8?B?Z1U4eFFOSzljdG9xMzJ4OTVtTlAyN1h1aHgyazhveHNkcXQ0NkY4NkRPUjdu?=
 =?utf-8?B?SmdMRkdvZEUvUHlFMWhRbWh4d1ZzRmcrRlJlY3huRURsenpMWUV3VVNBN3pu?=
 =?utf-8?B?SHRiOURPbXZ4a3lFKy9pcHRZbkJWaGxqeVEvL1pBYVhhdUREVzEwNUhEYlhO?=
 =?utf-8?B?eURwdnZBTzNPdkdLazQwdVczVURPMXY5Rm5hTEwzeGNodHUrSGo1OWZuR1Bi?=
 =?utf-8?B?TzFUQVJ6UHRGMHVETkNUVkkxMElXOGQ4bEliK1RsWGc1L0hacnEzSW5Cc25T?=
 =?utf-8?B?WUpQNzROYzJWUEZtclJreGVwbHhwUDg2NW12akIwaGxWUmNMQkt4My9XR0x5?=
 =?utf-8?B?Y2EyZ29zWmRXdUZwbk9jZGhZa3VUejUrV0RDZTBnWHlyclVmR3QwOWFFVGY5?=
 =?utf-8?B?M2RkakU2WjFFckFwYlVSdFo4VEJ6UEZwTXJ3SThTSEhrUzd3Rm4yVkRHM1FR?=
 =?utf-8?B?QzhoSFdtYUFiSWZRWXkzYXZrbmhsNVVCd1BiZGRvQVhJOHNzby9GYk9VYmR6?=
 =?utf-8?B?cENvUEwrekJ0eHJuQW03T3RSQTlNc282TXNlUVJhUEZsYmJJTHpPdjBraEsv?=
 =?utf-8?B?UWtGYkFueVRJME9NV1Rwa2xGSmhjZU1HV2NmR1hqY0p4TEx5UFZlT3VhVkZW?=
 =?utf-8?B?VjI0YlV3RXhwNm1uZEpmdm4xSzh3bWo0V3JKc1dybnp6RVJTYXFwQTdNS3Nk?=
 =?utf-8?B?V2hadVJQcHllMTB2SGNrM2tYMWZpcTdIQjVYbGdVWFlyUWdJUmFuNXBqWm1X?=
 =?utf-8?B?TUdzNmJhZDRMUjVrcHZWN0VnMmw3RlRMcTRLeDhoU0pYcDBPWXZlSVVUaExL?=
 =?utf-8?B?QXgyY0dyanhXdng1MzBEV1FWUUhQekRHQTJUd3FVU0JURGtwZ1J6V2hzMEsy?=
 =?utf-8?B?OGFQSkpCZk1XVUljTTB2SU5iMkhpNlVoMEZIV1ZDWWRQQWs2ajhLUFYzMjVD?=
 =?utf-8?B?OTltNzlFNE9uVmhPcjBWVTg0OVZXdFQzb0hXNFdieFFsQU5hRlYrMFBYSE4x?=
 =?utf-8?B?M2sxZkppMDlGVWFNQU4zczBsY3FGK0ovR3NYRXF2dDJpZ3VBY1pOM1FyTFp3?=
 =?utf-8?B?NDkvUW5YeGU2NjRBejhEa0EvNXN2QVAxc3lRWFIzV1pkTURuM25vd2hscGVu?=
 =?utf-8?B?OVJwVklCSVViMFFNSEFEeTJLQ0F6UFI1b2JvaXpvNU9ob3dzRU1xb1E0bUg4?=
 =?utf-8?B?S0lXZWNoQ25MUmlhR3pCWmhSMlZUNENyU2RvenR2eVZFczgyVysvK3dVeUJz?=
 =?utf-8?Q?Ovuj6FAVu9RPyHrRkjDHXjpv+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <328EDFB86173AA49BC9675925A35DDBD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca773a33-c842-45dd-abd3-08da5ea6436b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 16:49:01.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/wCQY75wXPyAfpIRJWcmfz27FzZ9+Y5qboHibFM53dyg3QfLGUF0JE5gvP1YDKnLKrAuXSOPFpMALso7SKBq2QmRZYACRTc22m0CcgJTcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1426
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDcvMjAyMiAxNzo0MiwgUnlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4g
RnJvbTogUnlhbiBXYW5uZXIgPFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBGaXhl
ZCB0eXBvIGluIGkyczEgbm9kZSB0byBtYXRjaCBpMnMwIG5vZGUNCg0KRG8geW91IGtub3cgd2hh
dCBzcGVjZmljIGNvbW1pdCB0aGlzIGZpeGVzPyBpcyBpdDoNCkZpeGVzOiAxY2E4MTg4M2M1NTcg
KCJBUk06IGR0czogYXQ5MTogc2FtYTVkMjogYWRkIG5vZGVzIGZvciBJMlMgY29udHJvbGxlcnMi
KQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIFdhbm5lciA8Unlhbi5XYW5uZXJAbWljcm9j
aGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9zYW1hNWQyLmR0c2kgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zYW1hNWQyLmR0c2kgYi9hcmNoL2FybS9i
b290L2R0cy9zYW1hNWQyLmR0c2kNCj4gaW5kZXggODljNzFkNDE5ZjgyLi42NTlhMTdmYzc1NWMg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaQ0KPiArKysgYi9h
cmNoL2FybS9ib290L2R0cy9zYW1hNWQyLmR0c2kNCj4gQEAgLTExMjQsNyArMTEyNCw3IEBAIEFU
OTFfWERNQUNfRFRfUEVSSUQoMzMpKT4sDQo+ICAJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVf
UEVSSVBIRVJBTCA1NT4sIDwmcG1jIFBNQ19UWVBFX0dDSyA1NT47DQo+ICAJCQkJY2xvY2stbmFt
ZXMgPSAicGNsayIsICJnY2xrIjsNCj4gIAkJCQlhc3NpZ25lZC1jbG9ja3MgPSA8JnBtYyBQTUNf
VFlQRV9DT1JFIFBNQ19JMlMxX01VWD47DQo+IC0JCQkJYXNzaWduZWQtcGFycmVudHMgPSA8JnBt
YyBQTUNfVFlQRV9HQ0sgNTU+Ow0KPiArCQkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnBt
YyBQTUNfVFlQRV9HQ0sgNTU+Ow0KPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJCQl9
Ow0KPiAgDQo=
