Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676215AAB87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiIBJf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbiIBJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:35:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEEF4F6BD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662111340; x=1693647340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dgV+BrIB0E3IxHcYftXKnOZDAUWy5xZSceC7sJk3IdE=;
  b=A//kdCRkpUt90yj6+Xh2vwCfgjLzKSWmLgofuSU8fYccgY2c+Kw2Dxkb
   jrzp/Nh+oJcJswDqaMPu+sVOYWyofTENfxNyjcgSEQ7GBiugMp1r/FJpB
   c3eXRDiCb4PtgdQk/AydCvFOSWmT84d6wL3faU/FmzWe2hRcqgXxpJVWO
   J76evUJqE5pYVMKiOqUw7GUe7y4ma34TYn4NobCfQOirsTEdTVCstPrjS
   BAKf6rFyjKdl21xEe6iKlau7GvDLS4saAA5KAK5bXiqG9nRP661UZRact
   UiIxmOjFkJSR82WmXi4p0gLTlge3z6XZOQCemIaHZDE2oykVekruXirAN
   g==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="172111552"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 02:35:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 02:35:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 02:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBCQdcuiViTP9NXLoFwEZ4Dwsubr2Is5y/JUgp8qfRuikDniIkyNcXVNsG36o4/5yANQ+ISFfdlYVldN2lkn5xPk3t5PD32FHBB71cRN6zkMEGB4awzf0nhgRbkCs/H8LuC1ZHepfHFQ4Q7s7+oh1TMIFWau5er97jIMtpTmTx1mE/KfQPT8PxLn+KFCFlPU/UDBADKgtbqR5AL7cs73mxWUYcG/WBvbNKGfaN3vA/aJsVBjetWv/RVhBuBh3leEoTf05DdvTGQ9Ig0PrhKFW90+oXXyrbcs4hdwoTjQc0ZeH6I3YZU8b37ETjG2qIG2VjERkzoCgq+NUtdOAfNSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgV+BrIB0E3IxHcYftXKnOZDAUWy5xZSceC7sJk3IdE=;
 b=VoUdruVEjrLM1dvI1vg8FtUiSaIipj9leq8TTP+X0RpetuBNjqBDiv2xH8/3ifBkhmNeGuRj6Oq0IadiJPUrg93L1R54aqredEaZv2cEllDqKrTI4EMSrWvLod+vzeaIRYMrqNS3osxdFCq/25Vh70bNA6pfVCwxSaIO0gYs+48n+wdaCjTbOIEtP83Ytd4ZIkgbKznPCcXsBUXrP4/QoA58C3tk/c+c+tEdpH+gbdZdSGee7nAMx8KrksBdCwHJVkhs8rlp2elM4DIjSbyhWjkjOwUA52hOxMBqMn0hjf5WsGVACOSCzolfuQdIC92IQnaMLq5O+trX9MNDHfoWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgV+BrIB0E3IxHcYftXKnOZDAUWy5xZSceC7sJk3IdE=;
 b=UhL6LKfZkNWNRH16Zb7gKhxRkDwUgBT6oezD6XBi+KVhm6m/A9bb3dhs5N4JFGJpvnKfn5YLdXbXN/5ZTKukI3adV69uUK3oypBlQ6RgkR9m0KRUQUwQK3Mm8ql+NV7KQPqbPr2n6Jk3hPrQx0q+miy47yOp3aBBK8AaBZ66orU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2363.namprd11.prod.outlook.com (2603:10b6:3:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 09:35:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 09:35:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <guoren@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] riscv: use BIT macros in t-head errata init
Thread-Topic: [PATCH 3/4] riscv: use BIT macros in t-head errata init
Thread-Index: AQHYvlIz1Q6Z0RUZR0ytlPEcYglJ3K3L4d8A
Date:   Fri, 2 Sep 2022 09:35:11 +0000
Message-ID: <a713cddf-871b-de0a-d408-f38eaea42085@microchip.com>
References: <20220901222744.2210215-1-heiko@sntech.de>
 <20220901222744.2210215-3-heiko@sntech.de>
In-Reply-To: <20220901222744.2210215-3-heiko@sntech.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71872566-a9fe-4171-f434-08da8cc66ee3
x-ms-traffictypediagnostic: DM5PR1101MB2363:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y1x9mWnWxoLcjtUIYWPlMxAqDbDDUIdI8RkbiUPTtR0yU46cH7b4xkctFTy2I5AGxKxeh6knU1ctvTY58xTLEnIHL9EpP6FW7Y1TD4zPsBtjFDllRRSKIdWVGBBWDK2FAdylKTN8+WuUPpe7ZkKXyzejoFvtWg5uzpAUyrPwfkbrMsIt2HZdCzX1uIryD5B028HDncM9s728mfnJuD6nOksIzl/6CojoO4/ut480qfK5UA4zmOkK2SiuR1liseesfKOPpZEUHGW+g5kFsHKGnxZi/FEb4cuZWhIDgyNdVukOgk6V4u10Jo9R0D6x0yAeW88eAS/F88Tugum5dkxmJzgl6T7mRtgHpYoMvK4SNvzfVWPixcy0FpKXYD61qNHTlRwRiPPT+eDrOyqRjbH+EP9BLFuSFK0E2lHZU0tF6v6X50ixT8tk87A96pusOFQZGD5avIj2KAgo6rkTzCMhtVPGLzBFp11WgmypbpXz5R+G/pDyxXfxtxqbUa26qwkeoEFNxihO38rbw+xB0nAyY4pqqeeAaTmYoDAYh4U6qu6Q0gI6k2P1sJkganfrD7c9WQyfr8lTABPF5Pb37BriAwP0/+D/jlcf9eQa+FBMsSr/L/CTjhBmiVak0mxni6NnUHBxEXnA4P9DIphkCs1oh6/mJC8B4vZdnqn4jAofRYJycO3e/P/kve0msXUZt68CBXO/3X9JHO/Hvx/PeE4aBIVIndimH0rPLsxyg8XJQkxGeDAPOG6faWZKyWm727ugYNdBeCVJJF2u5JncjemzVJbyJnNsbVwDAcP2maFsjRSBjhTraaC6BWEouW3mzBhW1Qvpdnt31YBvfrgWfopXqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(136003)(346002)(39860400002)(31696002)(38070700005)(83380400001)(122000001)(38100700002)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(110136005)(54906003)(316002)(2906002)(8936002)(5660300002)(53546011)(6512007)(26005)(6506007)(186003)(2616005)(71200400001)(6486002)(41300700001)(478600001)(86362001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDlEc2FVYlJCdVlQeElFZnVSRGNjdTlhRlA0aU4vcEdicWduVmpjR3FSL1d1?=
 =?utf-8?B?NTV5UDNZNTFzbXVlRVJNTXBycXZ1enRKNFkxU2xhRDlqWGlOUzN5UExYT2dk?=
 =?utf-8?B?L1laOWt6SmlYU0Vic0JnL0hlSVU2MmY2QWVmR2tWN0RIVE1DbzZVOTVpWWE4?=
 =?utf-8?B?WU1KSUtMQ2FtMk9FdExqbnNGenJNc3p4UTVMSkhDK3JuQ3F6ZHNRQTdxUHJ4?=
 =?utf-8?B?SDc0bWtkblRJSWpTRHA5SWpoZ0dlbHNvWlpEdGJxZi80bG9nRWxqOERHU0Fa?=
 =?utf-8?B?YXhTbUVhN2JHR2N3UnVBZXozWEcwNzcvajEvM2N6T2t3Q2tBOTZUZ244UDk2?=
 =?utf-8?B?YkFoR1NsUUw2b0oxVVhXWEtza3BsWnFmcnNzWStKaUtVeHc2eitJR2Rid0FV?=
 =?utf-8?B?WklMVC9mUEJxaEpRbFgreDN0Wm9TYjA1aTJrZU1oL043YmdXc2FTejlwUzVE?=
 =?utf-8?B?ZDRwWCt2UlNNNGxsbzFvMmI1K1E2K2MrbkE1bksyaXFqNi9QeDlTckJ2ZHFT?=
 =?utf-8?B?WGVEWjRNQUtqaHM1QnNFY2dJeGJYZWhEcXVJaTkrT2prcExYaTBmVEhZY3dZ?=
 =?utf-8?B?R3lJL2NIS3J5Y1hjc0RUMmp6aXFmK05NVVFjcUNTYUE1cGVhaitlVHc3UWlx?=
 =?utf-8?B?WUhCL1gvREUxbkN6b2VyTW9QYWZCcVB3U0NNYmRrRW8wdlNCZ3JBVTlOYk9S?=
 =?utf-8?B?VE5XbU1rSXJ5VytLd0FzeGlORDZHSTU3TmpkVWcxNEt3bU50dk5TUmg5SjA5?=
 =?utf-8?B?NEV1Nzd3Wmk5NDBpdDNBUFk3UFhBS2ZRVW11dG42Y1R4aXMwL1ExSHd0d1Q3?=
 =?utf-8?B?NzF2ajI3cmxpR1FGRkFVZ0lObHdZNW13Yk1YU0VCTmxRcVZxeHJEemFSRXRa?=
 =?utf-8?B?bU04Yno2TEF6R1ZWZlN0Y2FTMUQzZXFWbFVmVXF0K29yazFER25WOHRsK2o5?=
 =?utf-8?B?NE5sdGJZWWRoOGVpd3p4Q0pYWmhIQ1VFTERSRVlpZHNjRElGNTFiTm10bDBT?=
 =?utf-8?B?RFBzd2pNd1dXK2szQlU0eXRFWTBkNUxFNXFOSnlhUEh5aGM4a0NYV2NVZzlS?=
 =?utf-8?B?NFNadDZha1FzWVBCWXJRaTl3THh2d1lmVE9xM3hGV3BTRXJabncwdUo1L25E?=
 =?utf-8?B?RUZmcTY0eUNsM05aMkl2TWZoQlZIMjE4TTgwU3ppSDJYQmpsRUFLU0t0K0pU?=
 =?utf-8?B?N08xUlVEVlV6RHowYlUyN3hBYzF3Y1VoTlR1WlhYRktDNHlPK095aFU1QUUw?=
 =?utf-8?B?NWVtcE9vQXgzS0pabS9VSWFNVHRPaGhpa284Nk1TbnN2UExKMXVmR0l2ZkRn?=
 =?utf-8?B?aUpxN3R0Z2JuYUxUVmw1blgwaXA3MUtlUXlERC94bHkyc2VteVNVMkdIMDZn?=
 =?utf-8?B?V0VPOHFEZm9BVG55TUZNYUltcmFQeTVGRDZwZVg4NjFUL09scnhNV2R5aHdr?=
 =?utf-8?B?cjBwZEFDQWR4TGxQU0xzWmh3YmpsZmp4empyMUR0ZHBKWGtnUjVpT2VIb3Ro?=
 =?utf-8?B?NW9ycDVHMmlrZm1nM094UGJ4ZHJ0ejBzeHJTbi8rYmJWeTJYOFoxQ0VRaUxZ?=
 =?utf-8?B?clc5RTdXNHlKMkJEalVlM0VXN3g4TkJFTmx4VTBtQko3U3lHYklGVkxWRGpJ?=
 =?utf-8?B?WlA3cVVGYUxMMlZsT1Zmc1E4TVk5aXM4UCtQSHFlcUo0cndUeGU0RnlpMnBI?=
 =?utf-8?B?eFA0emIvV1dIa1dmQngrZnZ2M29KNUFkdFAzOHFUZU5MR0FOUTROSGwwNzh4?=
 =?utf-8?B?dlJ4SFN2ZXhzRjFOckNvd0xpRXdlVkx6ZjZIT2M1d0lURGtBenN2cVpPQ1Rj?=
 =?utf-8?B?bTRWRy92UWZ2MUlHWE5Qbkc4VzJKSUYwUXhWYS9KQWdydmo1YkEzSzRpMWNY?=
 =?utf-8?B?UHJpR0xIblZzWnIrcjM2dG5GRGpiU3pSSi9Bd016TXh3YWpJZ3JuV0JwcFlT?=
 =?utf-8?B?TWg3T2ZWbHlHdmlEbW0yemYyQUZFczVLREJPa2NwTVYySUFpdG1HSGpBNmNk?=
 =?utf-8?B?YnhNNmxLdUtQK3lFWXdTcmVXanpCQU5udmN6MWt1SmJzWjg1MnJ4MmN2ZkEx?=
 =?utf-8?B?cjBzRUVOMkQ2OUhDTnErallpbGlhQUxsb0FubTI1cUp2S1lVS09KSGpXMFlr?=
 =?utf-8?Q?Rpc5mIHfBHm3k5CfNycQ+R2es?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <646452B4E23EDB48B23D0C00C43C9782@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71872566-a9fe-4171-f434-08da8cc66ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 09:35:11.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJMjQRKH0zr1uf4deTxg71t18eVCO+KjxLIOXYKs2E7Z7+1oLN8Z7szbPl566ogHK0kN8yDTre4mlvV+Va4jLKaZjhneNyKAQtTk5898EVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2363
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDkvMjAyMiAyMzoyNywgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVXNpbmcgdGhlIGFwcHJvcHJpYXRlIEJJVCBt
YWNybyBtYWtlcyB0aGUgY29kZSBiZXR0ZXIgcmVhZGFibGUuDQoNCkFzIHlvdSBtaWdodCBpbWFn
aW5lLCBJIGFncmVlIQ0KUmV2aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1p
Y3JvY2hpcC5jb20+DQoNCj4gDQo+IFN1Z2dlc3RlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5k
b29sZXlAbWljcm9jaGlwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGVpa28gU3R1ZWJuZXIgPGhl
aWtvQHNudGVjaC5kZT4NCj4gLS0tDQo+ICAgYXJjaC9yaXNjdi9lcnJhdGEvdGhlYWQvZXJyYXRh
LmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvZXJyYXRhL3RoZWFkL2VycmF0
YS5jIGIvYXJjaC9yaXNjdi9lcnJhdGEvdGhlYWQvZXJyYXRhLmMNCj4gaW5kZXggYmZmYTcxMWFh
ZjY0Li5hNmY0YmQ4Y2NmM2YgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvZXJyYXRhL3RoZWFk
L2VycmF0YS5jDQo+ICsrKyBiL2FyY2gvcmlzY3YvZXJyYXRhL3RoZWFkL2VycmF0YS5jDQo+IEBA
IC00OSwxMCArNDksMTAgQEAgc3RhdGljIHUzMiB0aGVhZF9lcnJhdGFfcHJvYmUodW5zaWduZWQg
aW50IHN0YWdlLA0KPiAgICAgICAgICB1MzIgY3B1X3JlcV9lcnJhdGEgPSAwOw0KPiANCj4gICAg
ICAgICAgaWYgKGVycmF0YV9wcm9iZV9wYm10KHN0YWdlLCBhcmNoaWQsIGltcGlkKSkNCj4gLSAg
ICAgICAgICAgICAgIGNwdV9yZXFfZXJyYXRhIHw9ICgxVSA8PCBFUlJBVEFfVEhFQURfUEJNVCk7
DQo+ICsgICAgICAgICAgICAgICBjcHVfcmVxX2VycmF0YSB8PSBCSVQoRVJSQVRBX1RIRUFEX1BC
TVQpOw0KPiANCj4gICAgICAgICAgaWYgKGVycmF0YV9wcm9iZV9jbW8oc3RhZ2UsIGFyY2hpZCwg
aW1waWQpKQ0KPiAtICAgICAgICAgICAgICAgY3B1X3JlcV9lcnJhdGEgfD0gKDFVIDw8IEVSUkFU
QV9USEVBRF9DTU8pOw0KPiArICAgICAgICAgICAgICAgY3B1X3JlcV9lcnJhdGEgfD0gQklUKEVS
UkFUQV9USEVBRF9DTU8pOw0KPiANCj4gICAgICAgICAgcmV0dXJuIGNwdV9yZXFfZXJyYXRhOw0K
PiAgIH0NCj4gLS0NCj4gMi4zNS4xDQo+IA0KDQo=
