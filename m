Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2978C5B2261
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiIHPeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIHPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:34:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE2E120B0;
        Thu,  8 Sep 2022 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662651246; x=1694187246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eV7YX2ayG9+DxfvLAMkaum63RQo7RZsZAE5df/+DJss=;
  b=LPVrgaLXcCPW/M7/mazPl8l6KlN+KtWHqRLu2hpIk+l2vpn28Law0Wmi
   KdDpQ625fdRccXQC7eDJIU6lI5VymlbjNMVoI05IOia7vb+wx4tollVZQ
   6WTt/nS1k2hO7Stcwag8e1HZ9sHfxPTRULQG0XlRH26pryVMeTWYl2Cor
   kha04uhXb3AnVaNvwJbPcZDzXsaKuNyf3fo5fPDGMkw9NqBVr512u+8fo
   CgIs63/DOkrebbNTk0Gl/I85R3qXolVlfCqvqcQDdfgioMEk4jPugJKXO
   kKgIUN4ki4hpWs/O4yb39CjQtN5ZftXTy704U57mBzjmq2OwCLVvr2mPp
   A==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="189998939"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 08:34:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 08:34:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 08:34:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAfXs22FPCZyWdDldI0TkQ2pG4zPZcpJwtNAM+oCheBg28qjBwrSf6oTE3aJ4m2gml3tG/qYL/fXg05Ap+OMPMs8glsu23S1eVCYlLY8GUOaJ2dg0IyFt40tFW6JApxF59afT8N/+rwfKPHh2T0lQC5yX9Dad/0pt/YJo9krPJ8u3AvoejMDR7k3IC8oqJSsCII2uXjTFRgNmilSa2YblN1mlI1A/LjCjbdlsJKp1Kak6dwNq2zgpYNuvrVu3Fk3kt7AxRJTrfflXwKQTvHYbIBxtQIfBX+bETEx7+GLp1Wkp8ie4Jm9GYv792d42rL6l32mH7dgiF8sI/WH7l46KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV7YX2ayG9+DxfvLAMkaum63RQo7RZsZAE5df/+DJss=;
 b=CTgx8b3FAjJhYSbGAMkDj1vL8f2kxPXchNqhImU87XvBBXzwJ6I7bzO1GclMYNvqB08TFCSf16i7+lnNB5jQFigp1V+nD3L23L4rIJbCnMINSE8NgxjbzlJPKLHq063gY1RPrBqv+HzahwDsz/TIsF7/JGIr8ENhuc2vzYzNeR3LhjivULwa3p/908pkFR+xpCmpyRfYcEoAfb92ojNGA6s+XY8GSfxXiLJ1Qj61oJus1WuTEz04/S9BRN/sCvxBYsH8djwavCQ/HNyqofmhnPLfPgEu9Y1X/9MJIakzUI3888h11OZolbV77ooKYzW8nLqU9vuZhnVdsLaj+DSIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV7YX2ayG9+DxfvLAMkaum63RQo7RZsZAE5df/+DJss=;
 b=Yhdpt6pHAnFrlCvchUOdsRLv45mKYdl1B68qnIEvvF+fhtNojbdd5YmUxTv26gTUpKtW25DFScax/+HVd7As+N4J5AcbBkCO7t66j9g639qPo8LjsdmH/vu1ljLP+eDRYkHGo1K5VKZuvmvXCK5P+iyCiUVOcvLf2iImpGmmCyc=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BL1PR11MB5413.namprd11.prod.outlook.com (2603:10b6:208:30b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 15:33:59 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 15:33:59 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <richard.genoud@gmail.com>,
        <radu_nicolae.pirea@upb.ro>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 13/13] dt-bindings: serial: atmel,at91-usart: Add gclk
 as a possible USART clock
Thread-Topic: [PATCH v2 13/13] dt-bindings: serial: atmel,at91-usart: Add gclk
 as a possible USART clock
Thread-Index: AQHYwfjhqUbdrgGc80+alJQe+0orsa3VeuuAgAAx+wA=
Date:   Thu, 8 Sep 2022 15:33:59 +0000
Message-ID: <2df84acd-ac6c-0e0a-9a03-822a91e63085@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-14-sergiu.moga@microchip.com>
 <e93ef041-89d3-5718-4b1d-55bfd0c72797@linaro.org>
In-Reply-To: <e93ef041-89d3-5718-4b1d-55bfd0c72797@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc989803-8f0d-4486-44dc-08da91af8ca2
x-ms-traffictypediagnostic: BL1PR11MB5413:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkNOKg4zkmSbX0fhWAPN5GG7v3bSVf2nffMR8q5gEEMiPIOdJ05bipGWtZu2iJtkQSYVaKnwTiSsbhzyXj37+J4wWuaoe5NcTuOvaKU7lo538nItZX6Yq4pJHYrw3G6GGWCBlhEgsMJIyNfUHZ55UR5/yiQFneZW6bo4LJHoWjC7jkFrmYkZImZc/yrNi5bdebMxgmYbqvxqkKd4/9mMawsJgYUdNtZoNkhPBer5Fw6jKYaA+HHF0xAF6iCujSl3iN54M+Bmq7/jmrkl14Azpodck+gyJatZ9ksnimzUF3kO4br5dvBHDWTB1p78/toGxcIxopNH4zkHH+sWrhWL/WC50hdi8SJJht8Dn9i9UQwRnL8NMCILH3Ca8krUnLwewaGAGEB7jeUkDHKBGt14RxRD86XNb/dWo5hOmT7P8k28LNyb4zCh8/r+1y8DzyOhZHumLg8J6raW8O3GylniaY6LU4Xw7Cj1UevWaV32RUuE2O406AwCG4XgAQ6TfJw5vS+OGoxbuBmFDld11EkH7PTF/hSlc1bTMFCTRuwTiapLkXM/Yq8zrLBfl+YaRZalISuELNwUj82Bb09iacXhgmtx2dfioVivs7nVaiB+ZsJEyi4utrL39ynhDVIX+8N74aYLwJbbxpDjLKtv99qeLIMzrl0oRMvibqqXFFCo+9PFqgmvjfNZlWpzdbakf1tIYnDVCWHcecWIjjiEfp8dAZkbHsVlf6HH0bOTH6l1M9uCIg0OdYI2KMD7TyQsV8cA6OSgI0S9pQ7NEYSsMtAKMZVe9evmY+alxpuNHkGjik3wvn/7lkFE22MOkuhMMBlJapZlNlFRXXrZvsuSMYsGxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(366004)(136003)(39860400002)(83380400001)(921005)(6512007)(38070700005)(64756008)(122000001)(38100700002)(76116006)(66556008)(66476007)(6636002)(4326008)(66946007)(316002)(66446008)(91956017)(8676002)(110136005)(54906003)(53546011)(186003)(7416002)(26005)(5660300002)(8936002)(41300700001)(86362001)(2906002)(2616005)(71200400001)(6486002)(6506007)(31696002)(478600001)(31686004)(966005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGRWdk9RTzZocVI3VE9Pc2xVQU5VQTZQY1YrbUJmWDBxTDdITEY1YkdRcnNE?=
 =?utf-8?B?SXVqWUNzNWIzd3hTM0dRSDIzbzdwWElSWjVHOWhIenlldlB4SFpVOExjR2hP?=
 =?utf-8?B?N1lDS1VpNGhidmZmdStUTnRSNkJuVVE1NlY0TXUwUXdPNERCRld6eFdJTDRB?=
 =?utf-8?B?QjRRRTV2Ui9TSUtCNGM2b1kvTytKYzh0OUI4MjlHa2JMeHJhSmQ4eVVZVUlX?=
 =?utf-8?B?akZ1bkVWOFVtcWlPNXRsRERBOGZBVkgvWVQvaERHUnNVUHkvM0V3dEFIUVNN?=
 =?utf-8?B?TlQ2TFAvNnlYSUVkMWxSYjljQUF4U2FndktFa1F1d2E3dXFSU1ZZZ0RzSmVR?=
 =?utf-8?B?aWdtalJEMC9pUXFuUTdsWi9ONVhLQkEwWVhXUElia2FaWjZRZUVXdWFGbGo1?=
 =?utf-8?B?bFZjLzRaVjB4KzBaUG9CYmZtb2p3eFVyNVpZWkhXT0JzdVRGMGVTTVdwR3Qv?=
 =?utf-8?B?T3dYY05FM1VTVHJnTlVjUS9mNVlCUkxpQWpIaDVzRlhBaHg3WThXcXhlVGh1?=
 =?utf-8?B?U1V5YzhCdjRRMis1L3dWaEwzUWIxRUVMUTJYTGsrRjJRUWZoL0dDMDdZQXFH?=
 =?utf-8?B?T2VFcTVmdkM4MmRDbUFNTGZRTTBHeEZlV2RELzRSVnRQeFBweEV6R01KVS9a?=
 =?utf-8?B?Zyt6YnpIak9uN2dpTkU3NUZjTi9LTkZmd2d1UytQc2Q0dWNUcXV1dkRTOHRH?=
 =?utf-8?B?bElYdFY1N0VoaHdBNTNDRjh1THY0WUEvR3U0SmZRSWtYU0hKdTBlM1JFR1Va?=
 =?utf-8?B?U1BJYytreG1VaThJckZ4Y3ZXMSt4WFd5bmpxSVdzY0E1UjQ1dkg0VVQ0VUZW?=
 =?utf-8?B?UTIxeHZMNkFJVHV2WTNjUU9IODUyTFkxT1NYMmNaeitJalIvWjlsNkRWYUY1?=
 =?utf-8?B?RTNIZVN1S1RVcmF3VlEvSzBMbUNGZlJoem53Vlp3dG1XT011Wk9zUEVGNDRa?=
 =?utf-8?B?K3ZFZ3g0NFVFNnNYeWJlbUJmRmVjc0tZQkZHajNndDAvVHdvTFZJZGpJM0xt?=
 =?utf-8?B?cFRrbTU1UVplbmdnem5ZMWk2TlREdm9WT05XL0NwTUordTJCTlRTa2cvYzc3?=
 =?utf-8?B?eHF2NllPOXBiT01uRHlsQStOR0VVL3VkOU1OTDgrMnpJdnVLQW5IeEJ5OGdE?=
 =?utf-8?B?bS9leXZLTS9JaG9LTE5aWnoxMkN2Mmx1TzFkaVZXYjB1TVJYK0pjbjlBdWEz?=
 =?utf-8?B?VlY2SWdzdU5MZEswT3pNS0tJeXB0bkR4ZXBQYlRPMlg2b0lUSWJhZHVsL2dR?=
 =?utf-8?B?TGpBeHp6Vy9GS1YvV0VvZjlNTUwvRVhNMGhlbTIyMHduZlg2NWlaZ1FSSk5T?=
 =?utf-8?B?akxaNkVZeE5mU3g4Ym9uQmhLT3V2cUdISUxmV0swdjkrZ2dqcFQ4SEFZWkdL?=
 =?utf-8?B?dlhtOU1kME92TXR3SXVMYjhUeWhVMlZpUjlTNHkxZVRHcFQxTTJhTk5MYzVC?=
 =?utf-8?B?TEZuQlp4d1RhMEZUWFVCWFBLZ2Y5WDlneHVMbEtMVllwT2VCbWlqRlI4MWth?=
 =?utf-8?B?SSsvWGRUZ2VFY25TQ04xUGdKTk9ndUJKbFRHcHhEN0dFQjduQ1BXZ3M1emZw?=
 =?utf-8?B?c1pmakNhVlh5bEhBLzlvTkFXMk5RNVQxS2dvdVdkUERKQzBJeTFqWk9KTnpN?=
 =?utf-8?B?TTR5Tlc5cXY2R3F0TlRreGZZL1NNMEkrdEJCeTJVbXl6cTBQQnJQTnZ5cVZo?=
 =?utf-8?B?eXBWTEVCYlUxVHEvOFRQdkZJbzZmUVl5Y1IxR1B6bmVMcjJVUERXeEhRUmt5?=
 =?utf-8?B?VW9OWHNNbnZkdzRWWFp5TnBwb3Z4M0VHU1l5UVF1WUNjaGdVSWNiSjBCbEpx?=
 =?utf-8?B?ZzFBdGVTU1k2c3lTenR0eVcvZFZFcUt3aHBFNkZiblNsNkdyUUE4Z3RybFRQ?=
 =?utf-8?B?SksvQ2d0dEhyNnpSdm55NXV3WjE3a3JlQmgzbEdnTlBuaDZwTTVrNEM1Qjhv?=
 =?utf-8?B?c0dwVjUzYy9yaEZ3RHg1QTdoUzA0MS9ncGt5SE5CdW9iSTFZY3Y5ZWV0Tk1S?=
 =?utf-8?B?eFNScmVKbEtQUmlNZU1VOUJ6VEhRQnNWQmZlaE1WTGdFdDBwUjdZTHI2bmdI?=
 =?utf-8?B?V3FBVHVjR2YyR0dlZFN6TU9nMytwYnV1cUxYUzRZTEczVzEyWWZUalhzZHNl?=
 =?utf-8?Q?XomjfC0Rp+X94Y80KwKJore8t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34EF54650D34F5418D354F33FE2AF634@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc989803-8f0d-4486-44dc-08da91af8ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 15:33:59.0783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eREd9Nx9yy6os8KJYZhTz+TC51fTXLV/ZMX4ah3O1hZYTkPOaEBF11DX5RdLaNi8wYeVapoSsvGvgORtUf3O+g5gz5OagrGpRgWtAzpgL14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5413
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDkuMjAyMiAxNTozNSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDYv
MDkvMjAyMiAxNTo1NSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBUaGUgRGV2aWNldHJlZSBub2Rl
cyBmb3IgRkxFWENPTSdzIFVTQVJUIGNhbiBhbHNvIGhhdmUgYW4gYWx0ZXJuYXRpdmUNCj4+IGNs
b2NrIHNvdXJjZSBmb3IgdGhlIGJhdWRyYXRlIGdlbmVyYXRvciAob3RoZXIgdGhhbiB0aGUgcGVy
aXBoZXJhbA0KPj4gY2xvY2spLCBuYW1lbHkgdGhlIEdlbmVyaWNrIENsb2NrLiBUaHVzIG1ha2Ug
dGhlIGJpbmRpbmcgYXdhcmUgb2YNCj4+IHRoaXMgcG90ZW50aWFsIGNsb2NrIHRoYXQgc29tZW9u
ZSBtYXkgcGxhY2UgaW4gdGhlIGNsb2NrIHJlbGF0ZWQNCj4+IHByb3BlcnRpZXMgb2YgdGhlIFVT
QVJUIG5vZGUuDQo+IA0KPiBMYXN0IHNlbnRlbmNlIGlzIGNvbmZ1c2luZyAtIHdoYXQgaXMgdGhl
IHBvdGVudGlhbD8gSnVzdCBza2lwIGl0Lg0KPiANCg0KDQpJIGFtIHNvcnJ5LCBJIG1lYW50IHRv
IHNheSAicG9zc2libGUiLiBObyBpZGVhIGhvdyBJIGVuZGVkIHVwIHdyaXRpbmcgDQoicG90ZW50
aWFsIi4gR3Vlc3MgSSB3aWxsIGp1c3Qgc2tpcCBhbnkgYWRqZWN0aXZlcyBlbnRpcmVseS4NCg0K
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hp
cC5jb20+DQo+PiAtLS0NCj4+DQo+Pg0KPj4NCj4+IHYxIC0+IHYyOg0KPj4gLSBOb3RoaW5nLCB0
aGlzIHBhdGNoIHdhcyBub3QgaGVyZSBiZWZvcmUNCj4gDQo+IFlvdSBoYXZlIGNvbmZ1c2luZyBv
cmRlciBvZiBwYXRjaGVzLiBCaW5kaW5ncyBtaXhlZCB3aXRoIERUUyBtaXhlZCB3aXRoDQo+IGRy
aXZlcnMuIEtlZXAgdGhpbmdzIG9yZGVyZWQuDQo+IDEuIERUUyBjaGFuZ2VzIG5lZWRlZCBmb3Ig
YWxpZ25pbmcgdG8gc2NoZW1hLg0KPiAyLiBhbGwgYmluZGluZ3MNCj4gMy4gcmVzdA0KPiANCg0K
DQpBbHJpZ2h0LCBpdCBtYWtlcyBzZW5zZSwgd2lsbCBkbyBzby4gSSB0aG91Z2h0IGl0IHdvdWxk
IGhhdmUgbG9va2VkIA0KYmV0dGVyIGlmIEkgd2VyZSB0byBhZGQgdGhlIGdjbGsgaW4gdGhlIHNj
aGVtYSBhZnRlciBhZGRpbmcgaXQgaW4gdGhlIA0KZHJpdmVycy4NCg0KDQpPdGhlciB0aGFuIHRo
YXQgSSBob3BlIEkgZ290IHRoZSBleGFtcGxlWzFdIHlvdSBoYXZlIHByZXZpb3VzbHkgZ2l2ZW4g
bWUgDQpyaWdodC4NCg0KDQpbMV0gDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
Ni4wLXJjNC9zb3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2V4YW1wbGUt
c2NoZW1hLnlhbWwjTDkxDQoNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQoNClRo
YW5rcywNCglTZXJnaXUNCg==
