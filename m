Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66865B0E61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIGUnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIGUnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:43:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3308AF48E;
        Wed,  7 Sep 2022 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662583397; x=1694119397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8G+icUka9hWhQWHpS0EIdJL34gkm63S5OP7SP4oZsGY=;
  b=vUXfIeWWGxtevuo5LVCDJjRjiPYn2XzRU+Zp/oicXjoaXrDQfMDVo7Ey
   wVwFRo1Sdl0UjF/Vdmkj4enHJ94fJiCA7zYyRlHdl0l74t+Q0mU+31iUK
   PoJAw0RfGA7ZebsEb1At7l3DOS38xCuoVW10ENBkhf74PhayL/cL5IYpt
   hto8Yiii96Ckt1e31oHZD58wPJLLAtu8PsG+1o/nqSxmOFfSPKyVZuxJM
   iheEaC6XGGbR2vNH/DZ60pPnR5U172cvnh3YG/5vOpUzjuSNFjqDnGx+U
   6zrScbuGdPnNZlJjcF7iG3eencdWFCIbUFUiVIAUVncp6eD74J693IBub
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="189875554"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 13:43:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 13:43:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 13:43:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMWUo4vEHMe5V/aZdO24usY6OlQ5ytMoOP5Q7bKQ2JcwkKy7bWdmp6QnriUBIVpqEmMVswpd/a/Q2M+peIpKUL2ewHLTreX1DEt92mmsDjliA9huoFJkcZ6T4L/c6PFRUwOHRndj9+qBTlAk6u7xMpckaaZ4FauQ91jrA8A+VIH7F06F1Altg+U2dpSi2Uibq7Z8Uww76pv3zGogmPg6G08T3wkg/4oioVnFU4LgSRyTUmWlDLVwnvAUG8X/mqe+fgoRfyvS32uPRlpsE4vl/XUDs/uY92wqo/ZL/OtgHhG6fyKnAMSg/Tz56ENfLRtQRnVLvHILOOWUGLAhcpn04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G+icUka9hWhQWHpS0EIdJL34gkm63S5OP7SP4oZsGY=;
 b=C6H7vpLWfEbpwtoHT38mC+gkPM5QPrEkZ1uSWsuZQ3clx3p7YK/kGIXviU730UpCBjp7FG9E/Np+xnKpocHZZt44lXMCkga0EwwMorMabnMERs9ZOx395bPvkWiGfuOKBibHmYtdytE7BTaFI9ppMDOnmH8BC3PSwrCmlpFQb3xLpYNf/SYCexmVI0bHSQp3/lb5FmhZ4LBseZzwjccHqAvSiXoI0v9qAgvTBNs3uOBntkQ+3T5+sEkhaveWUJiv7ayBFOvrbsodHvqx7ZYPk7iGWEaCHy7paS7ZjUQzSGRifITlfnhao1YUZCQrwyJd8tFadDxV1DZbbC+KX9sJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G+icUka9hWhQWHpS0EIdJL34gkm63S5OP7SP4oZsGY=;
 b=awx374UDSuG9sbtM48hhX28Q8bKbvbmoCwm9YL/MS16mQ9Ck8XXnavEpv8rfpirVttNVuXDRNPSin89ImO5FTb4eVV0DfwVzRiBgEj82GMyaZPptKklsKE5C80AHeEQB2zHrEDoeGY41dxq/ND2yHQR3r8m4v+J3P47JhZ1PvVU=
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 20:43:10 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220%5]) with mapi id 15.20.5588.011; Wed, 7 Sep 2022
 20:43:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
        <palmer@dabbelt.com>, <geert+renesas@glider.be>
CC:     <wens@csie.org>, <linux-sunxi@lists.linux.dev>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 00/12] riscv: Allwinner D1 platform support
Thread-Topic: [PATCH 00/12] riscv: Allwinner D1 platform support
Thread-Index: AQHYwvpxfKxttznj2k2qHIUOyg7r/Q==
Date:   Wed, 7 Sep 2022 20:43:10 +0000
Message-ID: <84f28dc3-3b65-ea70-4fa4-765d0c773c28@microchip.com>
References: <mhng-d98d3324-5f4b-4cb0-a116-522b124dcdea@palmer-ri-x1c9>
 <7423117.EvYhyI6sBW@kista>
In-Reply-To: <7423117.EvYhyI6sBW@kista>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f8c6bb3-d9ee-422e-04e5-08da911193b4
x-ms-traffictypediagnostic: CO1PR11MB5138:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXjfgx53qMLQ2ZHCgoRozMVQCriHWZweJ25+C5O3axYgzY58LAaHDWNEMTz7VnueKAHVFom1Um5iAaQLGKAPFB8oshYEzGWfgBikJPRaBJF97j08tkoyipWHIWeAgEZwDVOMrBrc/p1lsiPQgwAYRIimHT7h7Iz+8ufY4cG1APLQ2sq1SWgVHJToE2tW1hxKFGyTUtKCTz0o+vJyyS0SfXm4Y6SLVv9d7JY0dP8eOQc2zERY6GjkIwSgoyB436qt8Aj62n36wt2bD1MPtjG3oKsZ+vVLKokJPWzh7gR9WDTQ3bRU3DKTDsVTfMht33Cm+eia/cqIPqvAQ7N2g4yHKZjWLxVjmpKBPy4KO1Bn7Zjk/S22ux6YLN8aNU4X0Qh5lPlbfKeOCP42VjgZh9aAADT6mpQzn5g8HXLZfMGjF9oHqUXeIr3/OVH95N18hxGCH3KEx4Cy7rH8ei0GZETAkj0gZ8T7ES4s2hRD1bNHSS2FuN/F3MJilCnL8+k3cNYrycphH+2yulCSzxo8JDwxolPsu8x68uDOvfDmD7hlwlVxvZnz3sH7l3TzpVQMOAP/Doxsq6Ug5wnTOdoAQ5zbSkG7X76HiLH9ctD/hc9JQ4Yhlz/0VrUrmK9jL/uL0x6BL+1QvT/ooK7BQ8mTMT5QgbMRL95PFFShGlavBJ4K+Dm6Q/kz1Ear36uWXT5hY1JueggjUnKaIT+dPkq4pApubmHwvI5fudlePNpL2/TRU8IBx6DA+ccqM9ug6jpRnyf8WK5zz/sUPmklPTYF7R2Kk4MJPpoWrbzT54X9FkGSpCzAuMKfj6r2TQZU4GocjuPiNIJUgg7E1QsPoHuO+k7RPOnvU2JQRYFGaqej0j/03muw98sAGMCH4hAC1TkfVIG0Uo4Hp8xGViZUrZ3tZbKODA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(136003)(39860400002)(366004)(36756003)(31686004)(316002)(83380400001)(5660300002)(8936002)(110136005)(54906003)(2906002)(4326008)(8676002)(66946007)(64756008)(91956017)(7416002)(76116006)(66446008)(66476007)(66556008)(66574015)(478600001)(26005)(41300700001)(6486002)(966005)(31696002)(53546011)(71200400001)(2616005)(186003)(38100700002)(38070700005)(6506007)(86362001)(6512007)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGI0Z1hGYUlFUE5XVjBLZGZKOVRHSFlSZU5wRTYyTSsxZ2Y0VU1nYmJaWVk2?=
 =?utf-8?B?NGdCZjJqeGZSbElYcVhDZ2taNTN0ME52R3k1RlJMcHEvU3BOVzE1MGtPcXJV?=
 =?utf-8?B?NTJYeW9zVDkyajFPWDRjY0laeFV1OGxYM1ovWDFadFRZbGNBam5NNHU1L2Jk?=
 =?utf-8?B?cW9EUWQzVUlKM1FNRy8yVlNDa2FiemZtRDRtbStkQ0g5L1pRd2tvV3VadW5O?=
 =?utf-8?B?dkF4MzFLYmVKZ1ZubU94UEF4U0lKVkFJYnFSNDRmU1BuajFpeFdkdjQ4dnFH?=
 =?utf-8?B?SGJiams2d2lVVldMUHBhNWhQVDhoM3RyTWNKcDhraUxFbGxaK0NGV0VQVW0x?=
 =?utf-8?B?UEtCTnVxUHltWGlLSC80OFJ5WjVMeDhZOGZnTmZ5Mjdsdmk5UUtJRkVWcHQ1?=
 =?utf-8?B?K1hzQ0YrSXI2SjhvZmRKVDRWMkw2eUsrYzlZbkt0bndTVTVoZ0FRZGtpYTYz?=
 =?utf-8?B?S1ptOWxMMURnOXdxTEs2d01hL2paOTdXWFExalVRRjdsOGpzdGFkMFdPdHRN?=
 =?utf-8?B?RU9hQ1BtYlBkSmhmT3hmaDVkeEVKYzJneldEKzJpVnFEM1YvVmVWZVdHWEVm?=
 =?utf-8?B?QVVNN1I0bnJwWFVYeGNENDJCWldhSVJKcmo5RWFrck9HRWJJODg2WDRXRGcv?=
 =?utf-8?B?TDQrWmlxc29EYnR5c1AxN1NFWitKTE9CNk5qR250dmdyV1lWWERBQ1NUNG5U?=
 =?utf-8?B?SXJXRGEzeUVpelNyc1ZVaHFCZDRUdmx5NjZJbXVtRjZaTHprQnFEUTZQWThz?=
 =?utf-8?B?cjhYWmxFNzBZVnpnM1MxWXRQV3psUDJaVlY3clBUMmlpcjlSU2plR2VxMXpR?=
 =?utf-8?B?aXpjOEtpZDZkaVkvVjVUUVdvUmp5VjFjbE5ZZEMvajBpSFMxQWJ5TlVlLzhW?=
 =?utf-8?B?YW1wRGUvOUVTVndGZEF6TXpEM2dVbjhYdjdWUHV0bSszMk0yZnZaampDY1ZV?=
 =?utf-8?B?ZkJNN2JteVh3WFpDdmRnNitRNjYvS3MyZXJzbDNxVmRxcTJzMmxXZm9tV3M2?=
 =?utf-8?B?RC9iVndEWU5mZXNycElIYjRoQWQwUnFwSEkwbS9aenlibE1lRW1vb245dW5R?=
 =?utf-8?B?dFFIY1pMaXpDSkRlUjBacTZDOHVwRmpPZ3VwU0RPNDNYQ0tYSmo3TmJtVFpy?=
 =?utf-8?B?M3hsRTYwQS9xeTEwK29TTHJkSWgyekFhODJ4WUIyOHdnVmZwNEdUV3pMMSs2?=
 =?utf-8?B?dXRtbkNCMjNhWk9ZODNlZTBSK2oyRkFMRWRwTVJpWXA3clovSGtjVHZuSkh0?=
 =?utf-8?B?TTBKcWVkTk1Qd1ZBZEI5SDk2ZDl5VWEvWHdKOGsyZE04bnhSeUJhUHdiVGFo?=
 =?utf-8?B?TFNLaXplRWFpaVA4aC9IUS9FbThBVmp4QmZlOHNkM1JuSXFqMzlYZE52Wjln?=
 =?utf-8?B?Skx0cjIxREd0MG9SY2IvOVNGSGxlTm9nV2wxeE9GeGVXb0VINTRoVnpoVkR6?=
 =?utf-8?B?dG9KOGlOalhKMDFHdXAxSERFRjJZd2xIZDlETkxPS3VHbGtVUy84ZjNFcy9L?=
 =?utf-8?B?TEQ1REZiUWdJaldSSEhxVUxqTERqN3pBNDNwdTNjMkhMaUd1bXErQVVoVzBy?=
 =?utf-8?B?MlpoMHJ6YVBvZEczR2NNRkI4Qm92WmFiT0t5SjU2VHF1MUVlenhYSm1OS2NQ?=
 =?utf-8?B?QzhhdE0vankyclkvOUlTbGpWU29jL1RpajN1UjZJMVdxVFdEUlh3cktPa2ph?=
 =?utf-8?B?eHlQZktPQzRReE1pMHQ4QzRuenhqMkxrQUpGMjdFZGtISHlGZGR2NGtNWUFC?=
 =?utf-8?B?YkFrbXY3SDNUMzl4Uzc0dDRTa2g5SE5jU2NWTjJDMjJmRVpsQ3FoS1k0NW1E?=
 =?utf-8?B?WmNiNUZVV1kyYiszWFo1RnFaQVUrVGN5ZlZDeG9yTnE3aFl3bnVuRFkxRVMw?=
 =?utf-8?B?Vm5Za2pWUStScUNjNEh4dU1zUDBLVnRtNjF4RVdManhJUGZJYU1rSlJIQi9w?=
 =?utf-8?B?ODBlbFp6Znc0dHIwWTZ2Q0Q0MjVFUkJuY2Q3d3pjRy9tY0w3VFRVL2NpelFS?=
 =?utf-8?B?Y1JqdFNyL0d1elR3UTRYQlo4bEhYUnRXQjhBY1dzNmY1RHVKdVZIYnFMOHRK?=
 =?utf-8?B?SGhLbWFpa0F5Q2V1QlhrcXRucTdPbVdySUlzYzVXRTN2Yk5KWmhoa1ROSjc5?=
 =?utf-8?Q?TNyodzsR2FgZPx5DyuDx+FOEn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84131E511918F948A150A9440FBA607A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8c6bb3-d9ee-422e-04e5-08da911193b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 20:43:10.4554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzrZhNwM+Ja7tcosMsAjFnli+VqqY0l1q82icXFkn30qtFuZflz/0yDT7vQyRHgQM7/oGQJfl2X7j/I5jYc5V6lw7mLZn1BnrHj1ImLEazM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDkvMjAyMiAyMToyOSwgSmVybmVqIMWga3JhYmVjIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IERuZSDEjWV0cnRlaywgMDEuIHNlcHRlbWJl
ciAyMDIyIG9iIDIwOjEwOjEzIENFU1QgamUgUGFsbWVyIERhYmJlbHQgbmFwaXNhbChhKToNCj4+
IE9uIFN1biwgMTQgQXVnIDIwMjIgMjI6MDg6MDMgUERUICgtMDcwMCksIHNhbXVlbEBzaG9sbGFu
ZC5vcmcgd3JvdGU6DQo+Pj4gVGhpcyBzZXJpZXMgYWRkcyB0aGUgS2NvbmZpZy9kZWZjb25maWcg
cGx1bWJpbmcgYW5kIGRldmljZXRyZWVzIGZvciBhDQo+Pj4gcmFuZ2Ugb2YgQWxsd2lubmVyIEQx
LWJhc2VkIGJvYXJkcy4gTWFueSBmZWF0dXJlcyBhcmUgYWxyZWFkeSBlbmFibGVkLA0KPj4+IGlu
Y2x1ZGluZyBVU0IsIEV0aGVybmV0LCBhbmQgV2lGaS4NCj4+Pg0KPj4+IFRoZSBTb0MgZGV2aWNl
dHJlZSB1c2VzIGJpbmRpbmdzIGZyb20gdGhlIGZvbGxvd2luZyBzZXJpZXMgd2hpY2ggaGF2ZQ0K
Pj4+IG5vdCB5ZXQgYmVlbiBtZXJnZWQ6DQo+Pj4NCj4+PiAtIFNSQU0gY29udHJvbGxlcjoNCj4+
PiAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjA4MTUwNDEyNDguNTMyNjgtMS1z
YW11ZWxAc2hvbGxhbmQub3JnLw0KPj4+DQo+Pj4gLSBOVk1FTSBjZWxsIGJpdHMgcHJvcGVydHkg
Y2hhbmdlOg0KPj4+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDgxNDE3MzY1
Ni4xMTg1Ni0xLXNhbXVlbEBzaG9sbGFuZC5vcmcvDQo+Pj4NCj4+PiAtIEluLXBhY2thZ2UgTERP
IHJlZ3VsYXRvcnM6DQo+Pj4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIwODE1
MDQzNDM2LjIwMTcwLTEtc2FtdWVsQHNob2xsYW5kLm9yZy8NCj4+Pg0KPj4+IEFsbCB0aHJlZSBv
ZiB0aGVzZSBhcmUgcmVxdWlyZWQgdG8gc2V0IHRoZSBjb3JyZWN0IEkvTyBkb21haW4gdm9sdGFn
ZXMNCj4+PiBpbiB0aGUgcGluIGNvbnRyb2xsZXIsIHdoaWNoIEkgd291bGQgY29uc2lkZXIgaW1w
b3J0YW50IHRvIGhhdmUgaW4gdGhlDQo+Pj4gaW5pdGlhbCB2ZXJzaW9uIG9mIHRoZSBkZXZpY2V0
cmVlLg0KPj4+DQo+Pj4gVGhlIFNvQyBkZXZpY2V0cmVlIGRvZXMgY29udGFpbiBvbmUgc21hbGwg
aGFjayB0byBhdm9pZCBhIGRlcGVuZGVuY3kgb24NCj4+PiB0aGUgYXVkaW8gY29kZWMgYmluZGlu
Zywgc2luY2UgdGhhdCBpcyBub3QgcmVhZHkgeWV0OiB0aGUgY29kZWMgbm9kZQ0KPj4+IHVzZXMg
YSBiYXJlICJzaW1wbGUtbWZkIiwgInN5c2NvbiIgY29tcGF0aWJsZS4NCj4+Pg0KPj4+IFNhbXVl
bCBIb2xsYW5kICgxMik6DQo+Pj4gICBNQUlOVEFJTkVSUzogTWF0Y2ggdGhlIHN1bjIwaSBmYW1p
bHkgb2YgQWxsd2lubmVyIFNvQ3MNCj4+PiAgIGR0LWJpbmRpbmdzOiByaXNjdjogQWRkIFQtSEVB
RCBDOTA2IGFuZCBDOTEwIGNvbXBhdGlibGVzDQo+Pj4gICBkdC1iaW5kaW5nczogdmVuZG9yLXBy
ZWZpeGVzOiBBZGQgQWxsd2lubmVyIEQxIGJvYXJkIHZlbmRvcnMNCj4+PiAgIGR0LWJpbmRpbmdz
OiByaXNjdjogQWRkIEFsbHdpbm5lciBEMSBib2FyZCBjb21wYXRpYmxlcw0KPj4+ICAgcmlzY3Y6
IEFkZCB0aGUgQWxsd2lubmVyIFNvQyBmYW1pbHkgS2NvbmZpZyBvcHRpb24NCj4+PiAgIHJpc2N2
OiBkdHM6IGFsbHdpbm5lcjogQWRkIHRoZSBEMSBTb0MgYmFzZSBkZXZpY2V0cmVlDQo+Pj4gICBy
aXNjdjogZHRzOiBhbGx3aW5uZXI6IEFkZCBBbGx3aW5uZXIgRDEgTmV6aGEgZGV2aWNldHJlZQ0K
Pj4+ICAgcmlzY3Y6IGR0czogYWxsd2lubmVyOiBBZGQgU2lwZWVkIExpY2hlZSBSViBkZXZpY2V0
cmVlcw0KPj4+ICAgcmlzY3Y6IGR0czogYWxsd2lubmVyOiBBZGQgTWFuZ29QaSBNUSBQcm8gZGV2
aWNldHJlZQ0KPj4+ICAgcmlzY3Y6IGR0czogYWxsd2lubmVyOiBBZGQgRG9uZ3NoYW4gTmV6aGEg
U1RVIGRldmljZXRyZWUNCj4+PiAgIHJpc2N2OiBkdHM6IGFsbHdpbm5lcjogQWRkIENsb2Nrd29y
a1BpIGFuZCBEZXZUZXJtIGRldmljZXRyZWVzDQo+Pj4gICByaXNjdjogZGVmY29uZmlnOiBFbmFi
bGUgdGhlIEFsbHdpbm5lciBEMSBwbGF0Zm9ybSBhbmQgZHJpdmVycw0KPj4+DQo+Pj4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L2NwdXMueWFtbCAgICAgICB8ICAgMiArDQo+Pj4gIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L3N1bnhpLnlhbWwgICAgICB8ICA2NCArKw0KPj4+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbCAgfCAgIDQgKw0K
Pj4+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIg
Ky0NCj4+PiAgYXJjaC9yaXNjdi9LY29uZmlnLnNvY3MgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA5ICsNCj4+PiAgYXJjaC9yaXNjdi9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
IHwgICAxICsNCj4+PiAgYXJjaC9yaXNjdi9ib290L2R0cy9hbGx3aW5uZXIvTWFrZWZpbGUgICAg
ICAgIHwgIDEwICsNCj4+PiAgLi4uL2FsbHdpbm5lci9zdW4yMGktZDEtY2xvY2t3b3JrcGktdjMu
MTQuZHRzIHwgMjQyICsrKysrDQo+Pj4gIC4uLi9zdW4yMGktZDEtY29tbW9uLXJlZ3VsYXRvcnMu
ZHRzaSAgICAgICAgICB8ICA1MSArDQo+Pj4gIC4uLi9kdHMvYWxsd2lubmVyL3N1bjIwaS1kMS1k
ZXZ0ZXJtLXYzLjE0LmR0cyB8ICAzNyArDQo+Pj4gIC4uLi9zdW4yMGktZDEtZG9uZ3NoYW4tbmV6
aGEtc3R1LmR0cyAgICAgICAgICB8IDExNCArKysNCj4+PiAgLi4uL3N1bjIwaS1kMS1saWNoZWUt
cnYtODYtcGFuZWwtNDgwcC5kdHMgICAgIHwgIDI5ICsNCj4+PiAgLi4uL3N1bjIwaS1kMS1saWNo
ZWUtcnYtODYtcGFuZWwtNzIwcC5kdHMgICAgIHwgIDEwICsNCj4+PiAgLi4uL3N1bjIwaS1kMS1s
aWNoZWUtcnYtODYtcGFuZWwuZHRzaSAgICAgICAgIHwgIDkyICsrDQo+Pj4gIC4uLi9hbGx3aW5u
ZXIvc3VuMjBpLWQxLWxpY2hlZS1ydi1kb2NrLmR0cyAgICB8ICA3NCArKw0KPj4+ICAuLi4vZHRz
L2FsbHdpbm5lci9zdW4yMGktZDEtbGljaGVlLXJ2LmR0cyAgICAgfCAgODQgKysNCj4+PiAgLi4u
L2FsbHdpbm5lci9zdW4yMGktZDEtbWFuZ29waS1tcS1wcm8uZHRzICAgIHwgMTI4ICsrKw0KPj4+
ICAuLi4vYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIwaS1kMS1uZXpoYS5kdHMgICAgfCAxNzEgKysr
Kw0KPj4+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW4yMGktZDEuZHRzaSAgfCA5
MDAgKysrKysrKysrKysrKysrKysrDQo+Pj4gIGFyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcg
ICAgICAgICAgICAgICAgICB8ICAyMyArLQ0KPj4+ICAyMCBmaWxlcyBjaGFuZ2VkLCAyMDQ1IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3Yvc3VueGkueWFtbA0KPj4+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9hbGx3aW5uZXIvTWFrZWZpbGUNCj4+
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+Pj4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvYWxsd2lubmVy
L3N1bjIwaS1kMS1jbG9ja3dvcmtwaS12My4xNC5kdHMgY3JlYXRlDQo+Pj4gIG1vZGUgMTAwNjQ0
DQo+Pj4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIwaS1kMS1jb21tb24tcmVn
dWxhdG9ycy5kdHNpIGNyZWF0ZQ0KPj4+ICBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRz
L2FsbHdpbm5lci9zdW4yMGktZDEtZGV2dGVybS12My4xNC5kdHMNCj4+PiAgY3JlYXRlIG1vZGUg
MTAwNjQ0DQo+Pj4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIwaS1kMS1kb25n
c2hhbi1uZXpoYS1zdHUuZHRzIGNyZWF0ZQ0KPj4+ICBtb2RlIDEwMDY0NA0KPj4+ICBhcmNoL3Jp
c2N2L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW4yMGktZDEtbGljaGVlLXJ2LTg2LXBhbmVsLTQ4MHAu
ZHRzDQo+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPj4+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2Fs
bHdpbm5lci9zdW4yMGktZDEtbGljaGVlLXJ2LTg2LXBhbmVsLTcyMHAuZHRzDQo+Pj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NA0KPj4+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW4yMGkt
ZDEtbGljaGVlLXJ2LTg2LXBhbmVsLmR0c2kgY3JlYXRlDQo+Pj4gIG1vZGUgMTAwNjQ0IGFyY2gv
cmlzY3YvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIwaS1kMS1saWNoZWUtcnYtZG9jay5kdHMNCj4+
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjIw
aS1kMS1saWNoZWUtcnYuZHRzDQo+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPj4+ICBhcmNoL3Jp
c2N2L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW4yMGktZDEtbWFuZ29waS1tcS1wcm8uZHRzIGNyZWF0
ZSBtb2RlDQo+Pj4gIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW4yMGkt
ZDEtbmV6aGEuZHRzIGNyZWF0ZSBtb2RlDQo+Pj4gIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRz
L2FsbHdpbm5lci9zdW4yMGktZDEuZHRzaQ0KPj4NCj4+IEknbSBhc3N1bWluZyB0aGVzZSBhcmUg
YWltZWQgYXQgdGhlIFJJU0MtViB0cmVlPyAgSSdtIGdlbmVyYWxseSBPSyB3aXRoDQo+PiB0aGF0
LCB0aG91Z2ggdGhlIERUIGZvbGtzIGhhdmUgcG9pbnRlZCBvdXQgYSBoYW5kZnVsIG9mIGlzc3Vl
cyB0aGF0IGxvb2sNCj4+IHByZXR0eSByZWFzb25hYmxlIHRvIG1lLg0KPiANCj4gRFQgY2hhbmdl
cyBmb3IgQWxsd2lubmVyIEFSTSBTb0NzIGdvIHRyb3VnaCBzdW54aSB0cmVlLiBTaG91bGQgdGhp
cyBiZSBoYW5kbGVkDQo+IGRpZmZlcmVudGx5IGZvciBSSVNDLVY/DQoNCk1pY3JvY2hpcCBSSVND
LVYgRFQgZ28gdmlhIGEgTWljcm9jaGlwIHRyZWUgdG8gUGFsbWVyLiBUaGUgb3RoZXIgc3R1ZmYg
Z2V0cw0KcGlja2VkIGRpcmVjdGx5IGJ5IGhpbSBhcyBpdCBoYXMgbm8gY2xlYXIgIm93bmVyIi4g
SSB0aGluayBpdCB3b3VsZCBiZSBuaWNlDQp0byBiZSBjb25zaXN0ZW50IGZvciB0aGUgbmV3IHty
ZW5lc2FzLHN1bnhpfSBzdHVmZiBhbmQgc2VuZCB0aG9zZSB2aWEgdmVuZG9yDQp0cmVlcyB0byBQ
YWxtZXIgdG9vLiBKdXN0IG15IDIgY2VudHMuLi4NCg0KQ29ub3IuDQoNCg0K
