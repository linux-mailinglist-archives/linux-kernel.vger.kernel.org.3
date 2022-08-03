Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682BA588A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiHCKcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiHCKbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:31:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29E615F;
        Wed,  3 Aug 2022 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522619; x=1691058619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NCNhe5KCO0o0vNAr0gyW9oiHPtanxYlK95lMEK38vdk=;
  b=YqsUZEwSVtpjap2vqsCFW0OlIMYsMTWmQOKf6HUumOnN0/AXH8qbeOHJ
   SSd2Nkd4Y4klI0T793BnmXHYhse9fKUUrn1AtmbtuCXcxY+snusrP8qcB
   qzkHCSR6cu1AHJoav1YYYqmVJeKMtRW4mB0ufCbQKujnWOqmneiTaNtJx
   Bes8HdRoGOvA+J2xoOKoqj4KfP1w/0wwXDBSYOzDRJagPPNjnmuYAV7eR
   QDZsAnr2eP5/wk7qTFqxDOLy90Q5UJJzm4fD5/F2SPMneRUDsZTk3cuxf
   4WpdQX9GwChIAf65Vbdq8iV7gziVjXQMAMQKJDnpnXg+N/mxStfGqvTDF
   g==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="184901953"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:30:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 03:30:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:30:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmz8cghhJDkWqwKnXEqBmZnm4zMsRHzJhX9sUZqg60P21Fn93gaN7oBe5WfDXg6apnrhNAUk8wcFrezD6mxg0WjeZwgHqn8i/y33tnOuy0tl3WlMAacc/jot7BxBvpDneCoDqhsDMb5xPWyFPEHBSe8PvTqyMnF9PI4XPzdaNgB9Yp3ZtME3U2mtdxZ3BgNuz975jCNKR8w9tyYzuCTDt5cMvmXyfasvEybVK5xDIpWCIwoyo/LZyDY2bsuWkmK/x88m0r1q27gBqEA2/3KjcQUu1/Rr004CUaxbUA/dm4WzgWuNpBCNhqG26rlsAzXE2dFNnY6on593mGwnOUBaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCNhe5KCO0o0vNAr0gyW9oiHPtanxYlK95lMEK38vdk=;
 b=XJocGIQo8vBMo5nV5HqcNzfjP+vBxeaaiD4IYfu1qIPkKHNLgURsPLrwfRA71JubSG8oyhpAM7FL4vPitfjpEzDSVlttHazNTH6D50gTwAKBm8j5dJXInczecgpk5r6aFoGPUWhFNbpR/r06HecZcGuekHKFAMM1jeyuMv+gdOP4VuP9lWoOZR198J27L8HK0l6GINsrJsFpyyYLhSbnXt0EvwbWNBun7byebuay6ynL6kbDec2JM8jtpTfb5tAn5JPpdCLEgQMgLzpdoWF28sOnX5eqettRyG32VXMaAZuxKK1s5tO5TaHpq0vXcA2sMQvsNhLetnj/YpxcHAk43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCNhe5KCO0o0vNAr0gyW9oiHPtanxYlK95lMEK38vdk=;
 b=M1pqohSZTfJ9DL8TkO2PfrD2WfYOIm6kMorqStTgvWqgQDRTOgqlQtYUiPZ/CYQDUOtW2kOlS9vA+nk9mslVPIDc41dYzWp/sXha4sGiLISlHte8b5Y9QYkgFg/0mF8399XIBbOGWlbz8w0x9lAQeeCcyoZ5t7O4v88ZbZzwWro=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BL1PR11MB5526.namprd11.prod.outlook.com (2603:10b6:208:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 10:30:05 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 10:30:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jic23@kernel.org>
CC:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 00/19] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Thread-Topic: [PATCH v2 00/19] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Thread-Index: AQHYpYujfuYmEdrMxEKQa2/KlwzRGq2c/OSA
Date:   Wed, 3 Aug 2022 10:30:04 +0000
Message-ID: <b6819c63-07fb-3f58-56ee-22dbcfa2a216@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
 <20220716174249.687af22b@jic23-huawei> <20220731211351.072e3334@jic23-huawei>
 <33008bfc-81f8-6943-0e72-70a1e91a10bf@microchip.com>
In-Reply-To: <33008bfc-81f8-6943-0e72-70a1e91a10bf@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40e56242-7472-4221-eca6-08da753b2143
x-ms-traffictypediagnostic: BL1PR11MB5526:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QpSNgbWhizoOp+JeMlU8u+MfcXIKxlmp377eiWVxQDl8xbmZp2wkcIi3VqzV+NT+fIljGfwFM29qQBebkQ7JLwoswsWAB1SsvIMfnwye7K0qdiB4XnciX2NUBMq3lYCbDfkKljMky2MclvSk5El80K8a9ZCNXZuou223aExE6/2VuUdONpet4aj93Jm4fUeHxw+MX5TyuNkffnC9HzIuTss3XqlixNZLuhobXxNHBSQ9BD7Fqtn6ezzwJaOmP1+zxdGGJQuKt+QuTqQkoj/fqmZNVxzpp6RPD82wzjsevCSKgl73BCvBvRizqOXncYior7qgJvliWyIOV+fNr0WlKs6s6kctN1rKnBPwVRO9uhPDmAzlhZM3+894W117x7zNXEt2UDQ6e41/vxAY2JYG5mXcSUR390ds64x31F4T6KJOKzC1+o0/TBhnmRL4/cJDpMmtEu22GxKtdNxeK+sc2mAkS+Cd43mip1BnQ0ibkT2GG73ebaSMP/bi+8NMZ3JABdKUeJUc7KWeqU2/rMuzBDlsZWi9i/YP784Le9eX6N6VouiOAY39/PbatLex1P9VIqIbNJn85j1IOKQcTfYp9A4+4S3BG76ork18+x3xAr38sg4x8Ok3yOc5AjNu48SO06VucTWmJXs3M/9YxbBk9Y2WlUSYiWNCB/9s9BP9mXdgks7P14MHsw+gJjMWEtylF0+PsC21sMkKO+YfB5TPPXl8xhskprw82iu1fOzNn+jcvlGVe6aKRr+ACe6Dfo2bnvV9LkmmnaSZnuad6OuPdsrTkxLKNsk75dfr80A5N3Xi5lNnm19ZrtSxcyjIOmt0sCoyq4BniGOfgHFFtqGz/MJVW6V46Nc98qIGN4EpFAvrJfMntOTz0eYItRSNlrqUzejl3QiW6B/KiNqmfKVWFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(346002)(376002)(136003)(83380400001)(4326008)(2906002)(66556008)(66946007)(2616005)(186003)(91956017)(66446008)(76116006)(8676002)(66476007)(36756003)(64756008)(31686004)(5660300002)(8936002)(316002)(6486002)(966005)(26005)(53546011)(6512007)(6916009)(31696002)(41300700001)(71200400001)(54906003)(86362001)(478600001)(6506007)(38070700005)(38100700002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHF3cTJ4eUdkbXd0d1FVeWdjbmJYWmZkLzVjNUpSQ1Yya1c2djQraUdFaXZB?=
 =?utf-8?B?YklWenFVUlpKZTcveGNFYnN6TXZkN0F1QVFBVU5VM2pwQ1Z0MVEza3greVBu?=
 =?utf-8?B?dVlxc2VGTEpHNkY5OURtZmpNcWlLbTZmM3IxcnUwVmxjMDJLdjgxaWJBamto?=
 =?utf-8?B?YlZWYjhoK3pBT3N1anQvYnh4L2pMN2s1elgxZC9LOWZ1Z29xUXNRN2RVYkhh?=
 =?utf-8?B?N0lxN3dBeVYvQWd6QnUwdk5SeGZFek15YUh5dWhMcEhvcnRic1VyQ1JDVWhE?=
 =?utf-8?B?Z0I3NmhXdlVmUHVQT0xQWWRMcTE4dzdQMk1yemF0b3VnRUF2djdlZThNMVV0?=
 =?utf-8?B?c0xyZkhkRHFZeWdJTEN1S0FNYmV1cHEzOFlGd2VHSTlWYkxlYk5SN3ErOW8y?=
 =?utf-8?B?OHFGd3ZHNlJVaHhWU1UrTGVzVVl6ZzhrMzRlNDZRYjl4ZEx6ay9tSmIwSDNq?=
 =?utf-8?B?SDZOUjVDQml6NnpyQzlzTldaQ1JRcnNiYUtNKzhDY3dUQ1czditCYkF5bGVq?=
 =?utf-8?B?d3dtWUVZbTNjaThXN1YrUDRXNXBJbXRWWmo5Q2tJSkdEOTZIZ2J1dHAvRytF?=
 =?utf-8?B?b3Rycko4MlRwNWJHTVlrSU1JSXZrVENYM2szVkk4L2NTbWd3Ykk3L1FONk1u?=
 =?utf-8?B?SlNVL0tHcUFndEFtdTRpUFNPTzEwQ0ZMQUpvTHJOaEIrTm1MTll1cExyamQ4?=
 =?utf-8?B?QldTVWVnVDFjZW9sRjlYejhFRThib2Y4b3VhK0owTGxVTWl4bGowSTJZTjI5?=
 =?utf-8?B?azlOYWUyWXFmT1o5RiszVkVKM1ozRzBzVnJsYng2d2F2K2tydE04dkFrdHlG?=
 =?utf-8?B?anZPRnFoWjQyeFpncnMrbVpKbE1kS1FNNGtQazM4ZGYrRUg5SitMSUJ0L3lP?=
 =?utf-8?B?YytCck9VSTA5QmpsZjlRMFlUZXdHTndaNTJ3STNLYS82U0lWMXoxSGxTN0hH?=
 =?utf-8?B?dnFmZ2lMMHl0T3VadXhjWmdxZUNSUGVBcmRpRUNQZEVLQmJnUDJ3MlFpeU1Y?=
 =?utf-8?B?YlppOEtlbUVMbzVTSklQcnFNcVJmYUpOZitMUkVacEJlV3hBU24zRDNQaFpQ?=
 =?utf-8?B?VktycGNlbDJTU2ttTzlXRFo0VWdXQWF5RmVldy9MOWJ0NU5EM1l3eVNmRWFE?=
 =?utf-8?B?OE5YeTR1ZEY0aDgwNjNSeTZ4Y0ExRTFxQm9sdm5YcnZkelhOc3p1OUVPU1R6?=
 =?utf-8?B?NDJtdmhZQ2xHVGxRU2M2SmcxSU9qelJ4MHR4OS9zWHlHZ2NGZWFGSk54ZWpa?=
 =?utf-8?B?YmNCclM3cXhHdXk0SHRzRGRYeXkyQnkvdjJhNUhOVWRaN0NXdkxWaXNYeGhF?=
 =?utf-8?B?VktQbCs0cFRaVk9aRGdqMTl0Z3FxeTlSVzdSdkxWckx3YVEzVUJQWkJrUEEy?=
 =?utf-8?B?WGlJOGRTMzN4VWR1d3dCaDJVeDVoeVVJVWkzR1lTSnNwZUdqK3NQRXNQQmYw?=
 =?utf-8?B?eklyaHRSN2ZjRFJGbFBjSlNveFREVHNmV2FhamNrc3F5MjlPYW9UT0k1U2U4?=
 =?utf-8?B?aWVoZFhGUHNBbjFVaHo5OUk3c20yYnNaWFFOSVhnMzFDeUJRMjBjd3AwZDFG?=
 =?utf-8?B?T2VYMURVRHBFS2kvcVRNdUR4ZFpoa3p2M1BkQmswZWJ6YkZKVTNtYjZDalRH?=
 =?utf-8?B?NlgySkpFQnd6WGROcnNMSDVRMTlMUEN5ck8wTDlBTGN4c2JwMnI2VEZXMGV4?=
 =?utf-8?B?Y04zL1dJMElZL3oyWUhRakd5NmplSVhyMkdVQXZTUVBwNkcvSlhhQW94cHNZ?=
 =?utf-8?B?QzllTjFUNFMza1VURDdHSStDUUlMZkVLZjMrV2VlNUpMQVZBNEFsZ1ZVY0Jo?=
 =?utf-8?B?bWFidlgwQnUxOWZaWTBGcER0MXZCRllyMjAwcW5iOElibC96WGNnTFVHaTF0?=
 =?utf-8?B?a0kvQ2s4V05HbXRDTndFWHAwaU9WRkpBWHVCbGFaTWY0cnRXUW8yWGp2dENT?=
 =?utf-8?B?MUtjeHR6TGVvZmp4RTZjR3dZSGlrOWNPSGJBUXhWbnhTUHg3b01MdGFHdE9W?=
 =?utf-8?B?NWJoeEszalpZZjVqTWxsZ2VNRjB2VVJRWUZpSHhIZXhyT2RqMjY0a0VzTHVl?=
 =?utf-8?B?VzRSSVlaa0pWclBCaGdhTFI1V3BXNTl0V1FBaUlZSDV0S29BQ253c1hrb1VJ?=
 =?utf-8?B?MkFrZ2x3aC9DWmRpdHcraE9nZjNrVDBLOEV3ak1FZnJuM25hTm95alA3c1Jm?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2333D1A49DC3704AAE3553B2BFFC78B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e56242-7472-4221-eca6-08da753b2143
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 10:30:04.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ficXg5tOxhBcJuUTlobfjMYA21LZWCItCdeOY0gDKaE1yoTMRIwTrKTOCxfSSUKgXESVbKlPAwjpIrGEv/uHFe8WKFepb8TZkEyiUyww1Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5526
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDguMjAyMiAxMjo0NiwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDMxLjA3LjIwMjIgMjM6MTMsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+PiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+DQo+PiBPbiBTYXQsIDE2IEp1bCAyMDIyIDE3OjQy
OjQ5ICswMTAwDQo+PiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPiB3cm90ZToN
Cj4+DQo+Pj4gT24gVHVlLCAyOCBKdW4gMjAyMiAxODoxNjoxMiArMDMwMA0KPj4+IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+Pg0KPj4+PiBI
aSwNCj4+Pj4NCj4+Pj4gVGhlIGZvbGxvd2luZyBzZXJpZXMgYWRkIHN1cHBvcnQgZm9yIHRlbXBl
cmF0dXJlIHNlbnNvciBhdmFpbGFibGUgb24NCj4+Pj4gU0FNQTdHNS4NCj4+Pj4NCj4+Pj4gVGVt
cGVyYXR1cmUgc2Vuc29yIGF2YWlsYWJsZSBvbiBTQU1BN0c1IHByb3ZpZGVzIDIgb3V0cHV0cyBW
VEVNUCBhbmQgVkJHLg0KPj4+PiBWVEVNUCBpcyBwcm9wb3J0aW9uYWwgdG8gdGhlIGFic29sdXRl
IHRlbXBlcmF0dXJlIHZvbHRhZ2UgYW5kIFZCRyBpcyBhDQo+Pj4+IHF1YXNpLXRlbXBlcmF0dXJl
IGluZGVwZW5kZW50IHZvbHRhZ2UuIEJvdGggYXJlIG5lY2Vzc2FyeSBpbiBjb21wdXRpbmcNCj4+
Pj4gdGhlIHRlbXBlcmF0dXJlIChmb3IgYmV0dGVyIGFjY3VyYWN5KS4gQWxzbywgZm9yIGJldHRl
ciBhY2N1cmFjeSB0aGUNCj4+Pj4gZm9sbG93aW5nIHNldHRpbmdzIHdlcmUgaW1wb3NlZCB3aGVu
IG1lYXN1c2luZyB0aGUgdGVtcGVyYXR1cmU6DQo+Pj4+IG92ZXJzYW1wbGluZyByYXRlIG9mIDI1
Niwgc2FtcGxpbmcgZnJlcXVlbmN5IG9mIDEwTUh6LCBhIHN0YXJ0dXAgdGltZSBvZg0KPj4+PiA1
MTIgdGlja3MsIE1SLnRyYWNrdGltPTB4ZiwgRU1SLnRyYWNreD0weDMuDQo+Pj4+DQo+Pj4+IEZv
ciBjb21wdXRpbmcgdGhlIHRlbXBlcmF0dXJlIG1lYXN1cmVkIGJ5IEFEQyBjYWxpYnJhdGlvbiBk
YXRhIGlzDQo+Pj4+IG5lY2Vzc2FyeS4gVGhpcyBpcyBwcm92aWRlZCB2aWEgT1RQIG1lbW9yeSBh
dmFpbGFibGUgb24gU0FNQTdHNS4NCj4+Pj4NCj4+Pj4gUGF0Y2hlcyAxLzE5LTQvMTkgcHJvdmlk
ZXMgc29tZSBmaXhlcy4NCj4+Pj4gUGF0Y2hlcyA1LzE5LTE2LzE5IHByZXBhcmVzIGZvciB0aGUg
YWRkaXRpb24gb2YgdGVtcGVyYXR1cmUgc2Vuc29yDQo+Pj4+IHN1cHBvcnQuDQo+Pj4+IFBhdGNo
IDE3LzE2IGFkZHMgdGhlIHRlbXBlcmF0dXJlIHNlbnNvciBzdXBwb3J0Lg0KPj4+Pg0KPj4+PiBB
bG9uZyB3aXRoIHRlbXBlcmF0dXJlIHNlbnNvciBzdXBwb3J0IEkgdG9vayB0aGUgY2hhbmNlIGFu
ZCBhZGRlZA0KPj4+PiBydW50aW1lIFBNIHN1cHBvcnQgaW4gdGhpcyBzZXJpZXMsIHRvbyAoaGFu
ZGxlZCBpbiBwYXRjaCAxOS8xOSkuDQo+Pj4+DQo+Pj4+IFRoZSByZXN0IG9mIHBhdGNoZXMgaW4g
dGhpcyBzZXJpZXMgYXJlIG1pbm9yIGNsZWFudXBzLg0KPj4+DQo+Pj4gT3RoZXIgdGhhbiB0aGUg
dXNlIG9mIE1FR0EgaW4gcGF0Y2ggMTcsIEknbSBmaW5lIHdpdGggdGhpcyBub3csIGJ1dA0KPj4+
IHdvdWxkIGxpa2UgdG8gbGVhdmUgbW9yZSB0aW1lIGZvciBFdWdlbiBhbmQgb3RoZXJzIHRvIGNv
bW1lbnQgaWYgdGhleQ0KPj4+IHdpc2guICBHaXZlbiB0aW1pbmcsIEknbSBhZnJhaWQgdGhpcyBp
cyB2ZXJ5IHVubGlrZWx5IHRvIG1ha2UgdGhlIG5leHQNCj4+PiBtZXJnZSB3aW5kb3cgYW55d2F5
IG5vdywgc28gd2UgaGF2ZSBsb3RzIG9mIHRpbWUuDQo+Pg0KPj4gTG9uZyBlbm91Z2guICBJJ2xs
IHF1ZXVlIHRoaXMgdXAgdGhvdWdoIGZvciBub3cgaXQnbGwgb25seSBiZSBleHBvc2VkIGFzIHRl
c3RpbmcNCj4+IGFzIEknbGwgYmUgcmViYXNpbmcgdGhlIHRvZ3JlZyB0cmVlIG9uIHJjMSBvbmNl
IGF2YWlsYWJsZS4NCj4gDQo+IEkgc2F3IHRoYXQga2J1aWxkIHJvYm90IGZvdW5kIHNvbWV0aGlu
ZyAocmVwb3J0ZWQgYXQgWzFdKS4gSXMgaXQgT0sgdG8ganVzdA0KPiBzZW5kIGEgcGF0Y2ggZml4
aW5nIHRoZSBpc3N1ZSBvciB3b3VsZCB5b3UgbGlrZSBtZSB0byBpbnRlZ3JhdGUgdGhlIGNoYW5n
ZXMNCj4gaW4gcGF0Y2ggWzIxLzMwXSBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzogYWRqdXN0
IG9zciBiYXNlZCBvbiBzcGVjaWZpYw0KPiBwbGF0Zm9ybSBkYXRhIGFuZCByZXNlbmQgdGhlIHdo
b2xlIHNlcmllcy4NCg0KSGksIEpvbmF0aGFuLA0KDQpJJ3ZlIHBvc3RlZCBhIG5ldyB2ZXJzaW9u
IGZpeGluZyB0aGUgY29tcGlsYXRpb24gd2FybmluZzogcGF0Y2hlcyAxMC8xOSBhbmQNCjExLzE5
IHdlcmUgYWRhcHRlZC4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4gVGhh
bmsgeW91LA0KPiBDbGF1ZGl1IEJlem5lYQ0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIyMDgwMTA3NDUuUVpSWUNpaHUtbGtwQGludGVsLmNvbS8NCj4gDQo+Pg0KPj4g
VGhhbmtzLA0KPj4NCj4+IEpvbmF0aGFuDQo+Pg0KPj4+DQo+Pj4gU29ycnkgZm9yIHRoZSBkZWxh
eSBpbiBteSByZXZpZXdpbmcgdjIuIFBlc2t5IGNvdmlkLg0KPj4+DQo+Pj4gSm9uYXRoYW4NCj4+
Pg0KPj4+Pg0KPj4+PiBUaGFuayB5b3UsDQo+Pj4+IENsYXVkaXUgQmV6bmVhDQo+Pj4+DQo+Pj4+
IENoYW5nZXMgaW4gdjI6DQo+Pj4+IC0gYWRkcmVzc2VkIHJldmlldyBjb21tZW50cw0KPj4+PiAt
IHdpdGggdGhpcywgbmV3IHBhdGNoZXMgd2VyZSBpbnRydWNlZCBpbiB0aGlzIHNlcmllczogMi8x
OSwgNC8xOSwNCj4+Pj4gICA4LzE5LCA5LDE5DQo+Pj4+IC0gcnVudGltZSBwbSBzdXBwb3J0IGhh
cyBiZWVuIGFkYXB0ZWQgdG8gd29yayBhbHNvIHdoZW4gQ09ORklHX1BNDQo+Pj4+ICAgaXMgbm90
IGVuYWJsZWQNCj4+Pj4gLSBjb2xsZWN0ZWQgdGFncw0KPj4+Pg0KPj4+PiBDbGF1ZGl1IEJlem5l
YSAoMTkpOg0KPj4+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBmaXggQVQ5MV9TQU1B
NUQyX01SX1RSQUNLVElNX01BWA0KPj4+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBj
aGVjayByZXR1cm4gc3RhdHVzIGZvciBwcmVzc3VyZSBhbmQgdG91Y2gNCj4+Pj4gICBpaW86IGFk
YzogYXQ5MS1zYW1hNWQyX2FkYzogbG9jayBhcm91bmQgb3ZlcnNhbXBsaW5nIGFuZCBzYW1wbGUg
ZnJlcQ0KPj4+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBkaXNhYmxlL3ByZXBhcmUg
YnVmZmVyIG9uIHN1c3BlbmQvcmVzdW1lDQo+Pj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9h
ZGM6IGV4aXQgZnJvbSB3cml0ZV9yYXcoKSB3aGVuIGJ1ZmZlcnMgYXJlDQo+Pj4+ICAgICBlbmFi
bGVkDQo+Pj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGhhbmRsZSBkaWZmZXJlbnQg
RU1SLk9TUiBmb3IgZGlmZmVyZW50IGh3DQo+Pj4+ICAgICB2ZXJzaW9ucw0KPj4+PiAgIGlpbzog
YWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBtb3ZlIHRoZSBjaGVjayBvZiBvdmVyc2FtcGxpbmcgaW4g
aXRzDQo+Pj4+ICAgICBmdW5jdGlvbg0KPj4+PiAgIGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRj
OiBkcm9wIEFUOTFfT1NSX1hTQU1QTEVTIGRlZmluZXMNCj4+Pj4gICBpaW86IGFkYzogYXQ5MS1z
YW1hNWQyX2FkYzogYWRkIC5yZWFkX2F2YWlsKCkgY2hhbl9pbmZvIG9wcw0KPj4+PiAgIGlpbzog
YWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBhZGp1c3Qgb3NyIGJhc2VkIG9uIHNwZWNpZmljIHBsYXRm
b3JtIGRhdGENCj4+Pj4gICBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzogYWRkIDY0IGFuZCAy
NTYgb3ZlcnNhbXBsaW5nIHJhdGlvDQo+Pj4+ICAgaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6
IG1vdmUgb3ZlcnNhbXBsaW5nIHN0b3JhZ2UgaW4gaXRzIGZ1bmN0aW9uDQo+Pj4+ICAgaWlvOiBh
ZGM6IGF0OTEtc2FtYTVkMl9hZGM6IHVwZGF0ZSB0cmFja3ggb24gZW1yDQo+Pj4+ICAgaWlvOiBh
ZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGFkZCBzdGFydHVwIGFuZCB0cmFja3RpbSBhcyBwYXJhbWV0
ZXIgZm9yDQo+Pj4+ICAgICBhdDkxX2FkY19zZXR1cF9zYW1wX2ZyZXEoKQ0KPj4+PiAgIGlpbzog
YWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBsb2NrIGFyb3VuZCBhdDkxX2FkY19yZWFkX2luZm9fcmF3
KCkNCj4+Pj4gICBkdC1iaW5kaW5nczogaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGFkZCBp
ZCBmb3IgdGVtcGVyYXR1cmUNCj4+Pj4gICAgIGNoYW5uZWwNCj4+Pj4gICBpaW86IGFkYzogYXQ5
MS1zYW1hNWQyX2FkYzogYWRkIHN1cHBvcnQgZm9yIHRlbXBlcmF0dXJlIHNlbnNvcg0KPj4+PiAg
IGlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBhZGQgZW1wdHkgbGluZSBhZnRlciBmdW5jdGlv
bnMNCj4+Pj4gICBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzogYWRkIHJ1bnRpbWUgcG0gc3Vw
cG9ydA0KPj4+Pg0KPj4+PiAgZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyAgICAg
ICAgICAgIHwgNjgzICsrKysrKysrKysrKysrKy0tLQ0KPj4+PiAgLi4uL2R0LWJpbmRpbmdzL2lp
by9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5oICAgIHwgICAzICsNCj4+Pj4gIDIgZmlsZXMgY2hhbmdl
ZCwgNTY2IGluc2VydGlvbnMoKyksIDEyMCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pg0KPj4NCj4g
DQoNCg==
