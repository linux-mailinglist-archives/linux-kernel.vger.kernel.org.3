Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9AE5684E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiGFKLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiGFKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:11:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA7DEE04;
        Wed,  6 Jul 2022 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657102296; x=1688638296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wvhnq4Byl8tOAFh2kFk5YPG2ecT78CoeUeXCPq99jd0=;
  b=z//nm6+5tU9ma2ErDcgdVSTLJnX5a3ummMkgc7iRPegxvUeqJik3f2Zq
   iVFHXpfuqwKZjETtxwJGQGow/lBBidK7DbyGUceNd1x9XOjYF63AI8zrD
   0P5enFGKqS50H9dvan/PQbauP3YbD+3e7erUwO80vHDlq/s4hgZ3/gJAk
   0FLLsBx6Or+kZkHm5ev6PSmQPnIXfDxc60BntljhimKSgpexYnhHPxNt7
   uk7Xocahin5hTxDKuubN5+NhVJGSKrYh/WWC11Sus6ICHGXtNyZ3kPfAP
   4sUWtAxVhOty56Lv6buqrH0aupSQqJMINnT5eyo38t/ajMrQfZnHIzZyK
   g==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="180957718"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 03:11:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 03:11:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 6 Jul 2022 03:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceH/wr84mcVCFxSBaSERJpeH95k7MkNewmkSz2pR3hqA/iY5Czfe0sdguRjllrOBPoWD4wGdit+IdoOYi/BdbfJ5cEFTYUiXft1RUvsoHnPfHxuhJXqZo/kNmp1SAbPykYgmcIFI4TI/M8nN0oK2iqPj9rhpUi3NHzNugs0tBxjtiS0iwoPxTgLQFZcSMGw02UwxPIPjKEYCN+3BT7Z4cW3kn6WGiLWjmDzTxEFMDuc7frKf9m/dn1zixs6SbIKwN8MF9S450RE4FK+eslMBNj9PK2xUnS5RTKKndbt+7/6rrvz3ejmJHCPiqNqiA7hEDE+Zl1sVHjGb/MES0/czfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvhnq4Byl8tOAFh2kFk5YPG2ecT78CoeUeXCPq99jd0=;
 b=HiqFxbmc5EA/adX2RTk68sSlQmGdh2zFwVcC/mes4D4s5GhIhzrXRwWwb+6Sh1K4tkJpB0mXBebNOWjlSRoZsNEpYghVjG8ea7vMEv19OaODg+z4IBcO8nActxVxYlpiHa6QresW8O6VA/hjyuEoBradqelSpG442BnKJhA4okOOM/4KJn7FQWDTHkDBkhh1VWLICUNs4b0eSho172HEeNdrPGJ8qWXR8qu5qi6kgNJOd9qBvq9Dde+kYkI3bhj1sykXWmh7gCpLFJtiWeylfOiAH79Ww4irPuct14LrHSpgE3QdacNeT3uVVyOaOe/gi7Zl8yjjA+K048XKZr2PVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvhnq4Byl8tOAFh2kFk5YPG2ecT78CoeUeXCPq99jd0=;
 b=MmTI32Au8Kfa/442U+V2YTRtkx1DsU92bmR6RjHE+Vlo6Wkndr/AS3FFlJrwgxnQB9vuIe0is50Lo8w2DJNOV+NUOsCj7Xp6WegbViwWE6eoIfgwI83CFbX7ZuVbuh0dYBJ2/fEArymVu8flQnPr0YZRBTr2225fzracfX0ZKno=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by IA1PR11MB6444.namprd11.prod.outlook.com (2603:10b6:208:3a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 10:11:31 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%8]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 10:11:31 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <Conor.Dooley@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Daire.McNamara@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Brice.Goglin@inria.fr>
Subject: Re: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Topic: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Index: AQHYkKIdHc6oV2H//EKJV+LfcdW+Dq1wN82AgAAD8QCAACn8AIAArIoAgAAGDICAAAW4gIAAAj4A
Date:   Wed, 6 Jul 2022 10:11:31 +0000
Message-ID: <c6829146-1a5e-6132-1e8b-bcb39f8a904e@microchip.com>
References: <20220705190435.1790466-1-mail@conchuod.ie>
 <20220705201931.nfwi5rlku7ykmydr@bogus>
 <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
 <fb7be22c-cf19-0e06-f231-bb5b9167e179@microchip.com>
 <20220706092126.k6zaknwcwzyg22ak@bogus>
 <9f26cd2a-b389-3f4b-b7d2-06fa5c2d7016@microchip.com>
 <20220706100333.7n35rfnbdrnz6mh5@bogus>
In-Reply-To: <20220706100333.7n35rfnbdrnz6mh5@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f7e2466-cfcd-4f4f-bbf0-08da5f37e5ef
x-ms-traffictypediagnostic: IA1PR11MB6444:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4sCkCdPvGR4WGTGtjA/Rr6eLAPkFAywwB11SUlBhKx3X3UlzWTCjmiBLtlAv+cqVEIeWAUzNestSOnz1JlDiOKYbcUfX1cUyII1Le/GnJz+vnXViy/wF+5ANSFKSPnZjhTIyxz+5XOMpExXjI6knAkNUAbABM8NfKYTMfmlj6YNNsqgB+/ZX4y6Flvk57yMxuAiY4OPsR/I9oBKumqyq+aG1nbmvcxJnaLTFifZRAtUJGO/sgGM9GI5DxF9JYiwrGCo9a17OWL8EUAFl/qMLRRGUFYkdKJvm2xVsd6IyvKoO3S7bKGPNGrE6yEdrkooQkWoFsplo7hU6IMgD2ruwVLlWDoO4OXyTO2mWkbdZ/xN2bOdZzPH13AjxnROP1QfWAsD0W5REjqIUfdTzgCF1b/SUxkfMSyESMfHO3vMST/fIohu6BTtM3nTZlTCYbJXQhH7OYcgKRpJRqKCUUIM9OQiAZFbLqNvk0fcUMbYGQOeWsrpZra0XDSgry1oLsapvzLtBm7WWMrx9Bn3MG8eaczwW7/IplyVKWOqnnEBYJWAc8LCj4wFq4t5+zYz0HA0bML1QhjwNjP0d5wg0pmg5HksL/kqig+YqEEtOdGwlzcF56mT43G5joNxrNVFM8JZiOsU474vg2f/mlxwrOYY4MZTtn/g/EEIWnHDJLKQYrdsMkcSPMHD/xjJMY6g5rY8B/eXYhtMD3U76ibsh0mxx5J9BCCOWEvpwd9jc8PK8pmStchxsPKhGO4fUltB3MIDELKTbu3WKLICWkwG999CCbkv7YXH+8rxndyVh/VkXtgWwTyb5C2kid3aep8E8RCN9GC3gdOCeHHaqQCosYGlNC5VWbpwtROYdi/NXEt4i7kIf/0+J+C/LJ1sj9uLXWooR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(376002)(136003)(396003)(66476007)(66446008)(8676002)(66556008)(4744005)(64756008)(7416002)(66946007)(38100700002)(36756003)(8936002)(4326008)(110136005)(316002)(76116006)(54906003)(71200400001)(5660300002)(91956017)(31686004)(478600001)(6512007)(26005)(6486002)(2616005)(41300700001)(53546011)(186003)(122000001)(38070700005)(31696002)(86362001)(6506007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmFoQUY3UEliYWMzRnRqeGZ6VnNEam9zRmJ5a2VsNVUvVDZOUFZyeFNKQ2hO?=
 =?utf-8?B?S2huc2ZzcW9lclQwUVpvbGtBSWpWejlIbEZMdUUxS3J3NG5Ma2dmUDk2emdq?=
 =?utf-8?B?N3JWS2IxajhOSExYZGhIbytKOCt3WHNUUmxjUXBRMm1kL09ETUljV3hUbkQx?=
 =?utf-8?B?cHB1MGFOZVNDZDRBVWJYUXNGQi9UYi9rTUpnYlViRjExRFBqcFNJN0YrSFFQ?=
 =?utf-8?B?NjZMMXR3alZaSHJHbG84cEVmVXBZWjBJbWltOWlwRnJxV01uYkpDWEZ4SjR3?=
 =?utf-8?B?Y2tBejhhOThXRGE1NVY1MVRKZkx2VTFTY0gwbG13R1ovRUZYL0U4WHRhL3Nk?=
 =?utf-8?B?U0l4WUdhajJkVGNVNjNYdXB0L0ZQQ2I0QjhINmE4Ly9lMEZSWmRYYmVYSFhX?=
 =?utf-8?B?RzFtL2xuVVpxK2cwZVZuWlg3clEwcWlPdUUzSzl4bkozUUFRRkRuOWpWSWZ2?=
 =?utf-8?B?V1ptdFpTWHF3N3VOWGo3Sk45aEVZYzNKRFZmenQ2K2NxZHd5R2tMU3FBQTBO?=
 =?utf-8?B?RmxxazRBdVRqaG1MTHBQbkJvY2dQVGp5STFrRlQ3c1FvOTZ6cSs3RDdVdERE?=
 =?utf-8?B?UVNPdnl0VFRPalg1QzdUQ1ltU20zZzh6bXJSY2J3M1puSHBmODBwdjBxbFMw?=
 =?utf-8?B?Y0VZYjdOdFpaRHJvemdrOWRlaUlNTms2TzBzZkN3eGMyWG1UTzZ5bm92MUJh?=
 =?utf-8?B?UHFxQ3Nvb3BvQkVoN1AxcGxlM3oyQnJnK1pqdGZYcTV6UWw5emFabGJ6endY?=
 =?utf-8?B?RVA1eGF0NU9RT3ZVdysxbjJvSWxBa0VRRXI5VU5mOGhvTDNhQUM1dW1XNHB3?=
 =?utf-8?B?SnVmK0Y5blQxRFBkYS9rQTM2ak9VMjlxUXRPMGtYcTNJa3VMU3hhdTk5Wllz?=
 =?utf-8?B?Z2tyQmFVZDJEa3N6L1VESWZQMmFDQUtTV05DaVlVMlVBSGZzU084dXNIdzJM?=
 =?utf-8?B?YUU1dTY4L0tBMGkwSmF3Nlp1TVovcUlBaWZZZDBWNFFCek9vc2YxbGFOZk4r?=
 =?utf-8?B?bXllMkkyQ1p1N0JsOWZaMTEyaDVEZEVTclRDVUQ4TUxDSjJ6a3VsU2FNVDJQ?=
 =?utf-8?B?ZUxwSGNMcnIwek0wQ0xQRTFFZGlOOWMvREgveVFUZ29XbVFiamJtMmJ2K2Mx?=
 =?utf-8?B?UGJmVHNmd0V5QXFMWlVBWHE5U2dQUDlxVTUrdXBkcjZvcDFtM3hBQUVPTmdQ?=
 =?utf-8?B?c0xERlMwMENmY0ZNMHFKU1FVd0dvL002YzFwNzFwcTUxSUlHMy9LVUdqWTAz?=
 =?utf-8?B?SC8ramtiMWx6L2g4TTNleWoxc2hSZWlLZ1RrVXgzOW9tWnRhWEpTakdHUWl3?=
 =?utf-8?B?WXY0YUxJUUx2NE1TT1UyRjNMV1pSSXkxZktQUXFvc3lOaGxkYThCekxVTHNh?=
 =?utf-8?B?UUlyTEZMUkJrdEtpZWZOUG1mcWpPQzJra25OTjdHSnppZHdMNzdwK3FwWDN3?=
 =?utf-8?B?QVNVME1lRFRKYzRSRmt5R0lYdmVRbFZySkZyTVJkT3BhYU1ZTDg5b2FGalhl?=
 =?utf-8?B?UFVvTkQzbU9Ham9RQTErenNGZ1c3S3lKeHZaOGZoRVI3S0EyVURWZC8wTS8y?=
 =?utf-8?B?dExqeTFyRFF1eWtjRHg1Yml0dWZxc0cxRmxSL0phYy9WQnhLQ2lWT284bTMy?=
 =?utf-8?B?TUFVeTE5NGFjdEtMY0M1TW1GenlldTNQdlFhUzQ1cnQrbkJNRkxBNStsSzZh?=
 =?utf-8?B?dERRamtxMlhHS2JINWJGTVQ1b0NLZ0dRUTd0MDFOamVUOWsxdmttZFM2cTUv?=
 =?utf-8?B?ODB2QjFtZmtORE44Zjc2dHZzTmV0UFgyQWgyQmJBeGJONERWNm83eWVpQ0cz?=
 =?utf-8?B?c3BkcU85RU9STm5HNVdNdmk2WW9VRU5nQ2x3WFJGQlZvNHluSzB6VEYwc2JD?=
 =?utf-8?B?TjA5cG1DNm1NSlFERnBtRkVDaE9jNGo5RzJGckc5b1JVL05XVXBISHdNUVRG?=
 =?utf-8?B?aFlQSVEwbGk1c2RZeWt4WVNjaDdyTFMwZlIzSDcwTW9oVDdSZ1JlWDFDZVJv?=
 =?utf-8?B?RDJyV2tQRTdwUnVza2pqOG1MRnhDdCtDdmtYMm9nYW9xRkw3VkpsQnovTzVt?=
 =?utf-8?B?ZmF2ZGxCUzdHdEZvRjFmUmptUkJidTdIVlFTb1BFaDRrWm04UW5VcmNYZkM0?=
 =?utf-8?Q?jvCFdkPJYTCsDMJ7y+wu3LCZZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6C56FA3EA34A14ABF9C1D78F96712E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7e2466-cfcd-4f4f-bbf0-08da5f37e5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 10:11:31.1567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXgFPXIEpaHd2lscAtCwpJ7fHp8MyWnD6qrl5RGj+jx3U7xWIRsw3O4V7FUHqDBvh2BIVLEWgpTO5ispWyGWB5OL2WZHFrUIb6fK3DH2Jgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6444
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA2LzA3LzIwMjIgMTE6MDMsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gV2VkLCBK
dWwgMDYsIDIwMjIgYXQgMDk6NDM6MDJBTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+PiBDb29sLCBJJ2xsIHJlc3BpbiBhIHYyIHdpdGhvdXQgdGhpcyBpbmNsdWRl
ZCB0aGVuICYgZ2V0IHRoZSBzZXJpZXMNCj4+IGJhY2twb3J0ZWQgc2luY2UgdGhpcyBpcyB1c2Vy
IHZpc2libGUgJiB3aWxsIGZpeCBhbGwgZXhpc3Rpbmcgc3VwcG9ydGVkDQo+PiBwbGF0Zm9ybXMu
DQo+Pg0KPiANCj4gVGhlIERUIC9jcHUtbWFwIGlzIG9wdGlvbmFsLCBzbyBJIGRvbid0IHRoaW5r
IGl0IG5lZWRzIHRvIGJlIGJhY2twb3J0ZWQuDQo+IA0KPj4NCj4+IEknbGwgc2VuZCB0aGUgdG9w
b2xvZ3kgY29kZSBjaGFuZ2VzIHNlcGFyYXRlbHkgdG8gYXZvaWQgaXQgZ29pbmcNCj4+IGZvcndh
cmRzLg0KPiANCj4gVGhpcyBvbiB0aGUgb3RoZXIgaGFuZCBjYW4gYmUgYmFja3BvcnRlZCB0byBm
aXggdXNlcnNwYWNlLg0KPiANCg0KVWggc3VyZSwgdGhhdCBzb3VuZHMgbGlrZSBhIGJldHRlciBp
ZGVhIChidXQgbW9yZSB3b3JrIGxvbCkuDQpObyBuZWVkIGZvciBhIHYyIG9mIHRoaXMgc2VyaWVz
IHRoZW4uDQoNClRoYW5rcyBhZ2FpbiA6KQ0K
