Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B36566560
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiGEIry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGEIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:47:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8D5DF88;
        Tue,  5 Jul 2022 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657010871; x=1688546871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nyCwULB6lF3JtFePsRWno81L8P+dMwc4a1OJxlcz5JQ=;
  b=TGrSqhAVDHWBQztsZk1UInGd6CukCsf8cV3O1RF/xv0yNCOZJVCnhcrS
   C8zIQs4v88E/YjQU4+jOjgbPimXW3ErdJEge1XzPxS+H1fCw0GeIyXZ/y
   0t6dyqMNHMfUsTlf4mg+RmximXzbCfswqWUqoHYVThJRa2VW5MlXt+S7J
   TwUuk0HRGgIjWAIXT5zD6JTlyLHK5NvzIMDW3+Dpc9545ALZaiJDARJuO
   Zw0DnRxuSqVEZzhnfXs7smCqIS3CKI7YFmQmUrpHTuYKRIaebh0p3aOGB
   HTil6uorjiAQZpWgTdFnoLnD3/lHJOjhpFFgRtsYJPs3o4po1aposgHJh
   g==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="170785759"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 01:47:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 01:47:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 01:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSp6J7Zc4IzdiykeCt1kCGHRHKrccCe8WJJwLaHak7qkogd0llikppxpwWeIK9tRZH0UyuAAtAnq40uVdUQLsvGStsliF4gMgiA9wTUAPErnCy069Js4Ydb10R34/IymyzrOwU66QBjek7GwMh2zE/EsguESOBJsqYqlVFulWcpKuNHLpoLx0U75LV4o1o9zCKFQzKtc6eAZavbKXFtC0c1xOHxsq5f38Cn3O6go071MuYPAmEH23zHydsOqxPgHE4bgH1XAlCfywic+45emHuDr2CFoFoqNk/Gss4++EGrMhTnxKrqcmda+QKzw6nPxinYmi2B5Q0D49rIfEz5CYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyCwULB6lF3JtFePsRWno81L8P+dMwc4a1OJxlcz5JQ=;
 b=KD6a6nb38abyF0ECgJz66VuQ3kvWexKHRbx6ZPvWGVTZ0qyjKhQcmBxUUQleBKoMc1N782KKpKHr/CjMzareJ19y8Bc4MybC+gWhR4vHehNvqtRN8XpmS67y2Cp1R7ir74lk4Nc6QqL+wS3UabRFe8qtCMRF1tJFlAY+L2geCkv9t7KyQ7Ffkorqyr5Zr76JfMKOqDAemNp8iO9Ir5laNVJNZywe59vCHwgW8uk7AGEXeWqJkiNGivDPzgzsyzyLrz+nV86M1EJtJ/G63SGophnL4AP2oaSI9uLEDuhyhEYulA7Adn7pdX4ZtchLPruDy3AVpkzdkd2XyITIae+Q0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyCwULB6lF3JtFePsRWno81L8P+dMwc4a1OJxlcz5JQ=;
 b=LzqGDmGJQuPS6c0jkx7fT39Z4DTypXmqHf+gJnZnWd24XCF31Efrd698YilFK6USq5jTrBNmx93sXpvOMoMBTdyNZT5xI1/RbP3my7FBExfpFNbYU6+kXNrW8mf8vu79nt1GuYbXOYBvTAbyr5ajxEar6M36pNKnTv1tS5vhqRE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 08:47:38 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 08:47:38 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH v6 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYkEvg6XveVIxJpUOe+/g5ihgFfA==
Date:   Tue, 5 Jul 2022 08:47:37 +0000
Message-ID: <0ca30eca-5c12-4b58-ccbf-b008d3413d4f@microchip.com>
References: <20220705065758.17051-1-kavyasree.kotagiri@microchip.com>
 <20220705065758.17051-2-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220705065758.17051-2-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1de87a7-9b30-485a-a228-08da5e63037c
x-ms-traffictypediagnostic: BN9PR11MB5323:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2oFwIb7wQdHwO1x6z5hNOJX6qbfVKGfJUkGQeVezr5i+ECO8YSmUqPO6797IDyiAot4ooF4iZ+zJyLWMAK6J4HLyplF69C7GcznXcILkHqn1OwfIZWFJXuXsMOd7iTVBfJDqvqGlok42w7V7di/ErK4puhCb14dwo23UZOfL5AdlmJJrV/GUeqlJu7Avxrt9VHSRbizSHiituonvxCx6wSqSp9LV/9wWlAfp6h1Rs7eeWzMXEqEJcUrCa6aqpEFo72AAdMKowN2v+chW6OE+ZeDRfw3xe2/DfRmrI7cjB9tBsoT6eaYJGE2I4b+fOE+F7mBgNR2a9Exqqowqvrz+xallFfR97jA5EOHwKfjNRoGKhRfpvgeI5eNuiqtL+x71uZ5S76ndB4RN8Hjq4LpZA4Z3dsJ71nfbwM6ipjv20nC9VqDP7vysJhCO33k132Ts+EB/iIVukG823v+cduMe335BElyaBUtVI4ACoYDLghZSOpz5YoS8rj9mbG8ANr2OnPk0hBAuJS5c7BQhDlAbITY6BH4pZR6t2VU+djkSZbE4evljIfbTUjgnZvJgr8DUqALZY3QXVR6F6nOMtY3Or/HkApptnB5Bg2XlGx0KCq8ZP2N+pq6s68FMvbsWyuY9O8UGoDTPH0Z65wRaMHRMamxCSoQnChT/olCl89iRyUOdCNNF2+xyJtgTTWU3unwH1JAokvR+wENoty9ovgdvBgNs2M3t9G7GoHtS/NGTNJvbib8g9XRrAHfyyTQI7sU7m22BoWLzv1JBzEL8X7e/vPnJ6I3zZKDKLWRPJ3Pf1HzX2mLot0iQzQ8zN2aUwvu1H3c4Ksw9W5yn+9EYRKsToklurMWij2b0qCcbEQE1ottMG2kYWwdjxiLLmi/2ixxPm8ukDsefrn4gpesrElkcQsaqNJsQRq3IKJhCwBVzL+xZnkukqfZ7dK2/wd7noVEd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(8936002)(31696002)(38100700002)(966005)(6486002)(86362001)(478600001)(122000001)(66946007)(76116006)(4326008)(8676002)(64756008)(66446008)(6512007)(66476007)(66556008)(5660300002)(2616005)(71200400001)(91956017)(26005)(186003)(53546011)(36756003)(316002)(6636002)(31686004)(54906003)(2906002)(41300700001)(6506007)(83380400001)(110136005)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW1sUXhjU016NkdVNFRFVWdrakczeWNEbVIrYzBmQWVXbkh3cy9FYkZqTGdL?=
 =?utf-8?B?SEVGc1E0SktrNUhMZnpUYVFYZEtMS2ZYUjFQcUJBaE9OR1VDeXJ2cG1QaHRo?=
 =?utf-8?B?WVZVT2FiQ280cUlMakhVVkN5OHJoNTFidU1kWlFveU9uLzBmQUx1SzdNK2wx?=
 =?utf-8?B?Y2p1dlIxR0M5K3dINGpibVphQUhMRGFBV2NadXVlaFJoNURQc2cyYzBxUmJp?=
 =?utf-8?B?RXZmckt5NDBsdHY4S2hBQWdkMERVMzBIell6ampBaGI5WFhXN3BHd2YwWGdV?=
 =?utf-8?B?Vm5JTnQ4bTVYdEdNcmR3MnVwY3JyVmNNSVZWWXNqY245Q3ZsbVlRQnpmQmpL?=
 =?utf-8?B?alNQYjBOM0pYN1haZkJyT2dadWhKaml6REVqeFllUXBON3ZaOG9Pcmx5MVJ6?=
 =?utf-8?B?aHNpZlRlSVM2engwUUkrNXFqbVNyRks3NFg5d2RVYmtrdVBuN2VqR29JaHc4?=
 =?utf-8?B?RktkNGEvYUhsemMzVEhuaEVSamtLRitkb2xkM3A5TUJhdkRtQ3o0TkFSTE1E?=
 =?utf-8?B?bE1iY3kzaFVoa2RjM0g2YmQ4Wjg1YzFiWVhzYW9KbTgvenV3eUVwV2pZRGND?=
 =?utf-8?B?ZlloQ0xOUkRqUXJqVEMrMGh6THp1TzhWOHpLNUJHRC9ybHNBd1FpMEdiNEpi?=
 =?utf-8?B?bmJZSzRtdmhWa0tXV0l3Vk5Ka1BMRmJRTnYwRXpOdXdTQU5EWS9rUnJxUUtX?=
 =?utf-8?B?WDdqdlMzdjh6WGNUSGNBdXNPMlQ4d1I0dWNiQkhFbjhWcHB2dWpldGFLaTdC?=
 =?utf-8?B?b2pwdVE5TG5IUXpvNXFyYWlTYUN6SVRSald2bk9KSlRFNHY5dzdYa29ySDZS?=
 =?utf-8?B?TThIV3dIdTBGdkNvdHlISmxtNzRaQXNhMURGSVhUNEJISHlWNjhFNC9rZ3Jr?=
 =?utf-8?B?TWpBNm5BL05IclZsNXVEbVBZS0ZLYXFmL3Q0anVoTzRFV2NiM2R0a2dIL2dJ?=
 =?utf-8?B?VzBzK05OaFQ0NVdtQTZWOHhJQ1VOUElkVmNGVGplaTFxMzd0THdpdnlaNmVr?=
 =?utf-8?B?cnlNYld5RnlzWnUxeFdPZzRpYXdhQUpSOURwTzJ1MmNHcEM0bGdhc0R6Qzhv?=
 =?utf-8?B?cmxMLzdxWTU2RzFrLzYxYUk5ZTJzZU0vR2tXKzJqUFM4SVBUbzJxZlpNbHM0?=
 =?utf-8?B?dUpiNTRXQUIwcW5XMFhLUjhDSkFLdm9ZWW5iK3hpbUlid2tsWXZ2Um1OVXRN?=
 =?utf-8?B?R09HQVFFWnREV1FsNUN6TlpoWU96a0daOFp1MzVTd1RMMjMxT2lKM2pDNGw3?=
 =?utf-8?B?Z1M5MHVKR0MxRngrOW54aUFxZHQrZ0xPQ2J5ZmZCWDNDV3NNMnkyaDU1ZFM3?=
 =?utf-8?B?UlZXVFE4bVdvNlliWlJGN2o0cnJUREpXYXAvUFgwZHZpR20vaE5keitVeGFY?=
 =?utf-8?B?ZnV5dDgwa0NsVHNSTVRwUmpuNG5EaWF6L0xDM1lJR1JXdGIyc01lWDgydi9H?=
 =?utf-8?B?TzgzVm5NTzNqbU1MOXlpVzBFMEFiNW1LeDNydTR4TGZRdnUwYzJpM1dMZ3Rw?=
 =?utf-8?B?Y2VzcEMraTFBc1ViZENhV2N3ODNlWHBTZ1JTNk8ycGN3ajJCcmYvdlR2ZUhO?=
 =?utf-8?B?SEl3UFVydGJhOVZyRzNla1FYR1RXT0pmVXhEWDJ0L0NuTnpXZHBoelN3a3p4?=
 =?utf-8?B?Kys0aVh3MXdzdXJZRExuS3o2L3lxb3BiMkZwZVBsRmdJajk3TUpPZlBySmJp?=
 =?utf-8?B?V3VoM2pCNUZNVnVHZHR0TVhzSnNqazNSd1NiMjFhK0tXK1BmZnJMRnNzNElw?=
 =?utf-8?B?SnFTenlESGZZbFRpK3RGTWV1QTRTMnpWVGhyemg3RUxPVXRZV0kvOHNrMUtp?=
 =?utf-8?B?b0F2QXJySDlpb21mUms3S3VFRjN2VlpCaEhvcWZaWEljRng3RlNHK3FLdWRp?=
 =?utf-8?B?UUNrQ2VIcXg5VFZyK0tvRVlqWlRQQ0RwLzM1c01JUGoyM1FIRWQrRnhGMCsr?=
 =?utf-8?B?TU5tTnNVTW4zR3ZNZEZTRTF6MTlUL3REMU5MTS8vdTBiWmxma0p1bXVhKzZQ?=
 =?utf-8?B?L0ZQWDhhRjBiZVM0L1k2Zkt5clR6UDJCNS9wMVJRUERZM05YdnF3WVpicVky?=
 =?utf-8?B?cVJ5SlRiOHUvSUczYWlNRFRZUkQzNWtHWlM5MldsRkk3SWxxZytXM0ZGNlVw?=
 =?utf-8?B?azZ5eVlhaDIySGhUbjdyVVhkbFZvNEpPaDhyK0NWMkFKNms3Q0tiVjBxTjJD?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B82ED4D72A2340BB1D0BB0C617A9E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1de87a7-9b30-485a-a228-08da5e63037c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 08:47:37.9150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTDDlO8+N5IKPv0k7JQdvyhbFvPLGTwzxLISLoW4wgVxQSUwbIcJ0yXvg5VcYJ7zc9RncF95Lx+TxVR4UbG/QKGGayfAQoqGFWWQLxLOmAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMDcuMjAyMiAwOTo1NywgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBDb252ZXJ0
IHRoZSBBdG1lbCBmbGV4Y29tIGRldmljZSB0cmVlIGJpbmRpbmdzIHRvIGpzb24gc2NoZW1hLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdp
cmlAbWljcm9jaGlwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gLS0tDQo+IHY1IC0+IHY2Og0KPiAgLSBS
ZW1vdmVkIHNwaSBub2RlIGZyb20gZXhhbXBsZSBhcyBzdWdnZXN0ZWQgYnkgUm9iIGFuZA0KPiAg
ICBhbHNvIHBhdHRlcm4gcHJvcGVydGllcyhzcGkgZHQtYmluZGluZ3MgY29udmVyc2lvbiB0byB5
YW1sIHBhdGNoIGlzIHVuZGVyIHJldmlldykuDQo+ICAgIE9uY2UgdGhhdCBpcyBhY2NlcHRlZCwg
SSB3aWxsIGFkZCBiYWNrIHNwaSBleGFtcGxlIHRocm91Z2ggbmV3IHBhdGNoLg0KPiANCj4gdjQg
LT4gdjU6DQo+ICAtIEZpeGVkIGluZGVudGF0aW9ucy4NCj4gDQo+IHYzIC0+IHY0Og0KPiAgLSBD
b3JyZWN0ZWQgZm9ybWF0IG9mIGVudW0gdXNlZCBmb3IgY29tcGF0aWJsZSBzdHJpbmcuDQo+IA0K
PiB2MiAtPiB2MzoNCj4gIC0gdXNlZCBlbnVtIGZvciBjb21wYXRpYmxlIHN0cmluZy4NCj4gIC0g
Y2hhbmdlZCBpcnEgZmxhZyB0byBJUlFfVFlQRV9MRVZFTF9ISUdIIGluIGV4YW1wbGUuDQo+ICAt
IGZpeGVkIGR0c2NoZW1hIGVycm9ycy4NCj4gDQo+IHYxIC0+IHYyOg0KPiAgLSBGaXggdGl0bGUu
DQo+IA0KPiAgLi4uL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwgICAgICAgICAgIHwg
NzIgKysrKysrKysrKysrKysrKysrKw0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0
bWVsLWZsZXhjb20udHh0IHwgNjMgLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA3MiBpbnNlcnRpb25zKCspLCA2MyBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFt
bA0KDQpBRkFJQ1QgaXQgd291bGQgYmUgYmV0dGVyIHRvIGhhdmUgaXQgbmFtZWQgYXRtZWwsc2Ft
YTVkMi1mbGV4Y29tLnlhbWwuDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCj4gIGRl
bGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0
bWVsLWZsZXhjb20udHh0DQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmY1NzdiOGQ4ZTFlYQ0KPiAtLS0gL2Rldi9udWxs
DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxl
eGNvbS55YW1sDQo+IEBAIC0wLDAgKzEsNzIgQEANCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiArJVlBTUwgMS4yDQo+ICstLS0N
Cj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWZkL2F0bWVsLGZsZXhjb20u
eWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29y
ZS55YW1sIw0KPiArDQo+ICt0aXRsZTogQXRtZWwgRmxleGNvbSAoRmxleGlibGUgU2VyaWFsIENv
bW11bmljYXRpb24gVW5pdCkNCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gS2F2eWFzcmVl
IEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdpcmlAbWljcm9jaGlwLmNvbT4NCj4gKw0KPiArZGVz
Y3JpcHRpb246DQo+ICsgIFRoZSBBdG1lbCBGbGV4Y29tIGlzIGp1c3QgYSB3cmFwcGVyIHdoaWNo
IGVtYmVkcyBhIFNQSSBjb250cm9sbGVyLA0KPiArICBhbiBJMkMgY29udHJvbGxlciBhbmQgYW4g
VVNBUlQuIE9ubHkgb25lIGZ1bmN0aW9uIGNhbiBiZSB1c2VkIGF0IGENCj4gKyAgdGltZSBhbmQg
aXMgY2hvc2VuIGF0IGJvb3QgdGltZSBhY2NvcmRpbmcgdG8gdGhlIGRldmljZSB0cmVlLg0KPiAr
DQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGVudW06DQo+ICsgICAg
ICAtIGF0bWVsLHNhbWE1ZDItZmxleGNvbQ0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVt
czogMQ0KPiArDQo+ICsgIGNsb2NrczoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgICIj
YWRkcmVzcy1jZWxscyI6DQo+ICsgICAgY29uc3Q6IDENCj4gKw0KPiArICAiI3NpemUtY2VsbHMi
Og0KPiArICAgIGNvbnN0OiAxDQo+ICsNCj4gKyAgcmFuZ2VzOg0KPiArICAgIGRlc2NyaXB0aW9u
Og0KPiArICAgICAgT25lIHJhbmdlIGZvciB0aGUgZnVsbCBJL08gcmVnaXN0ZXIgcmVnaW9uLiAo
aW5jbHVkaW5nIFVTQVJULA0KPiArICAgICAgVFdJIGFuZCBTUEkgcmVnaXN0ZXJzKS4NCj4gKyAg
ICBpdGVtczoNCj4gKyAgICAgIG1heEl0ZW1zOiAzDQo+ICsNCj4gKyAgYXRtZWwsZmxleGNvbS1t
b2RlOg0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsgICAgICBTcGVjaWZpZXMgdGhlIGZsZXhj
b20gbW9kZSBhcyBmb2xsb3dzOg0KPiArICAgICAgMTogVVNBUlQNCj4gKyAgICAgIDI6IFNQSQ0K
PiArICAgICAgMzogSTJDLg0KPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmlu
aXRpb25zL3VpbnQzMg0KPiArICAgIGVudW06IFsxLCAyLCAzXQ0KPiArDQo+ICtyZXF1aXJlZDoN
Cj4gKyAgLSBjb21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gY2xvY2tzDQo+ICsgIC0gIiNh
ZGRyZXNzLWNlbGxzIg0KPiArICAtICIjc2l6ZS1jZWxscyINCj4gKyAgLSByYW5nZXMNCj4gKyAg
LSBhdG1lbCxmbGV4Y29tLW1vZGUNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNl
DQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiArDQo+ICsgICAgZmx4MDogZmxl
eGNvbUBmODAzNDAwMCB7DQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1m
bGV4Y29tIjsNCj4gKyAgICAgICAgcmVnID0gPDB4ZjgwMzQwMDAgMHgyMDA+Ow0KPiArICAgICAg
ICBjbG9ja3MgPSA8JmZseDBfY2xrPjsNCj4gKyAgICAgICAgcmFuZ2VzID0gPDB4MCAweGY4MDM0
MDAwIDB4ODAwPjsNCj4gKyAgICAgICAgYXRtZWwsZmxleGNvbS1tb2RlID0gPDI+Ow0KPiArICAg
IH07DQo+ICsuLi4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZmQvYXRtZWwtZmxleGNvbS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWZkL2F0bWVsLWZsZXhjb20udHh0DQo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0K
PiBpbmRleCA5ZDgzNzUzNTYzN2IuLjAwMDAwMDAwMDAwMA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLWZsZXhjb20udHh0DQo+ICsrKyAvZGV2L251
bGwNCj4gQEAgLTEsNjMgKzAsMCBAQA0KPiAtKiBEZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgQXRt
ZWwgRmxleGNvbSAoRmxleGlibGUgU2VyaWFsIENvbW11bmljYXRpb24gVW5pdCkNCj4gLQ0KPiAt
VGhlIEF0bWVsIEZsZXhjb20gaXMganVzdCBhIHdyYXBwZXIgd2hpY2ggZW1iZWRzIGEgU1BJIGNv
bnRyb2xsZXIsIGFuIEkyQw0KPiAtY29udHJvbGxlciBhbmQgYW4gVVNBUlQuIE9ubHkgb25lIGZ1
bmN0aW9uIGNhbiBiZSB1c2VkIGF0IGEgdGltZSBhbmQgaXMgY2hvc2VuDQo+IC1hdCBib290IHRp
bWUgYWNjb3JkaW5nIHRvIHRoZSBkZXZpY2UgdHJlZS4NCj4gLQ0KPiAtUmVxdWlyZWQgcHJvcGVy
dGllczoNCj4gLS0gY29tcGF0aWJsZToJCVNob3VsZCBiZSAiYXRtZWwsc2FtYTVkMi1mbGV4Y29t
Ig0KPiAtLSByZWc6CQkJU2hvdWxkIGJlIHRoZSBvZmZzZXQvbGVuZ3RoIHZhbHVlIGZvciBGbGV4
Y29tIGRlZGljYXRlZA0KPiAtCQkJSS9PIHJlZ2lzdGVycyAod2l0aG91dCBVU0FSVCwgVFdJIG9y
IFNQSSByZWdpc3RlcnMpLg0KPiAtLSBjbG9ja3M6CQlTaG91bGQgYmUgdGhlIEZsZXhjb20gcGVy
aXBoZXJhbCBjbG9jayBmcm9tIFBNQy4NCj4gLS0gI2FkZHJlc3MtY2VsbHM6CVNob3VsZCBiZSA8
MT4NCj4gLS0gI3NpemUtY2VsbHM6CQlTaG91bGQgYmUgPDE+DQo+IC0tIHJhbmdlczoJCVNob3Vs
ZCBiZSBvbmUgcmFuZ2UgZm9yIHRoZSBmdWxsIEkvTyByZWdpc3RlciByZWdpb24NCj4gLQkJCShp
bmNsdWRpbmcgVVNBUlQsIFRXSSBhbmQgU1BJIHJlZ2lzdGVycykuDQo+IC0tIGF0bWVsLGZsZXhj
b20tbW9kZToJU2hvdWxkIGJlIG9uZSBvZiB0aGUgZm9sbG93aW5nIHZhbHVlczoNCj4gLQkJCS0g
PDE+IGZvciBVU0FSVA0KPiAtCQkJLSA8Mj4gZm9yIFNQSQ0KPiAtCQkJLSA8Mz4gZm9yIEkyQw0K
PiAtDQo+IC1SZXF1aXJlZCBjaGlsZDoNCj4gLUEgc2luZ2xlIGF2YWlsYWJsZSBjaGlsZCBkZXZp
Y2Ugb2YgdHlwZSBtYXRjaGluZyB0aGUgImF0bWVsLGZsZXhjb20tbW9kZSINCj4gLXByb3BlcnR5
Lg0KPiAtDQo+IC1UaGUgcGhhbmRsZSBwcm92aWRlZCBieSB0aGUgY2xvY2tzIHByb3BlcnR5IG9m
IHRoZSBjaGlsZCBpcyB0aGUgc2FtZSBhcyBvbmUgZm9yDQo+IC10aGUgRmxleGNvbSBwYXJlbnQu
DQo+IC0NCj4gLUZvciBvdGhlciBwcm9wZXJ0aWVzLCBwbGVhc2UgcmVmZXIgdG8gdGhlIGRvY3Vt
ZW50YXRpb25zIG9mIHRoZSByZXNwZWN0aXZlDQo+IC1kZXZpY2U6DQo+IC0tIC4uL3NlcmlhbC9h
dG1lbC11c2FydC50eHQNCj4gLS0gLi4vc3BpL3NwaV9hdG1lbC50eHQNCj4gLS0gLi4vaTJjL2ky
Yy1hdDkxLnR4dA0KPiAtDQo+IC1FeGFtcGxlOg0KPiAtDQo+IC1mbGV4Y29tQGY4MDM0MDAwIHsN
Cj4gLQljb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDItZmxleGNvbSI7DQo+IC0JcmVnID0gPDB4
ZjgwMzQwMDAgMHgyMDA+Ow0KPiAtCWNsb2NrcyA9IDwmZmx4MF9jbGs+Ow0KPiAtCSNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPiAtCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAtCXJhbmdlcyA9IDwweDAg
MHhmODAzNDAwMCAweDgwMD47DQo+IC0JYXRtZWwsZmxleGNvbS1tb2RlID0gPDI+Ow0KPiAtDQo+
IC0Jc3BpQDQwMCB7DQo+IC0JCWNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXJtOTIwMC1zcGkiOw0K
PiAtCQlyZWcgPSA8MHg0MDAgMHgyMDA+Ow0KPiAtCQlpbnRlcnJ1cHRzID0gPDE5IElSUV9UWVBF
X0xFVkVMX0hJR0ggNz47DQo+IC0JCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+IC0JCXBp
bmN0cmwtMCA9IDwmcGluY3RybF9mbHgwX2RlZmF1bHQ+Ow0KPiAtCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gLQkJI3NpemUtY2VsbHMgPSA8MD47DQo+IC0JCWNsb2NrcyA9IDwmZmx4MF9jbGs+
Ow0KPiAtCQljbG9jay1uYW1lcyA9ICJzcGlfY2xrIjsNCj4gLQkJYXRtZWwsZmlmby1zaXplID0g
PDMyPjsNCj4gLQ0KPiAtCQlmbGFzaEAwIHsNCj4gLQkJCWNvbXBhdGlibGUgPSAiYXRtZWwsYXQy
NWY1MTJiIjsNCj4gLQkJCXJlZyA9IDwwPjsNCj4gLQkJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDIw
MDAwMDAwPjsNCj4gLQkJfTsNCj4gLQl9Ow0KPiAtfTsNCg0K
