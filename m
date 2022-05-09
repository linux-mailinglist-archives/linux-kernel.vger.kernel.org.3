Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407EA51FB3C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiEIL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiEIL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:28:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36AA1F1CBC;
        Mon,  9 May 2022 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652095455; x=1683631455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+O3wP5osNTlRgfftymbzuwkAoQ1JUdpSE9DKOqspDwc=;
  b=sHPZQDPbYb6B7q43HMbhaxXVQ4TEK9hgGt2G75DA7/vzG1UbifeZyVF5
   OZffRgB9xhqCcc+oCUNKjLdLXrrtm5LR6ccHuL3xxStgwp9nLmt1O/9kd
   nrGTDF7KuCkT0Oto373E+QUTuUxuEnpIoMlAEusJ1Krf8d7uIG8L0XJf3
   wLB+93FuZabGa6/KwAdLKMtS3Po1KjKEtO2m5gADqzWbXclpHAAM3APOu
   Li62PVhue+CB7lycQ5uv8VZKD5zRM2iRhcGhpeCa4qbWKuiHShnOVPrO3
   Uh/LRjSWZdWA+9GWvWcTfoIQZMUNDv0/tRd6WtVbPuyQPxP1kM12dfyOA
   A==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="163225478"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 04:24:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 04:24:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 9 May 2022 04:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njzQ8xe9fWzvgXUV/eqxoNayeAGxypxitfzuCIXDUT6Qi2INni2yXOXIrPMEjxWLMEwMYQaswJjBkGihxtNPjTDwhlxxE53eLCB5wa7HGr/3/VRAlh4yr5YXL09tksIM5wO//g6jm0898f1zRx7UfuZJMBDnhCJa89043PeGn1GDvbUTYOijY3YeKxrZuQe0G5a8bdUJ81S4/3PGt70Tv59r2fR9/08F7wNgmSIZivHJdVfJeB0MJ6H6nSeNz3njU8kMheqxNCpxFHMaqZS6C4M9y1z/QXOkLzDHiXb4cZOM+db8/ZtAo9L3t9j0X7BIwgKOiY0+iV7BCK0yXfBleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O3wP5osNTlRgfftymbzuwkAoQ1JUdpSE9DKOqspDwc=;
 b=Y3Ou4GDhywAbQTvp9GotH+KOeZNAT5st8/obg6p76rEItPdg9J9x7rTqzkHyFzwhR9/4zR/AF3UCUw54WMnrWvBElSwiUCoEUFTpPl5eozDkg55gc3v1jv7mk7SBzaGYkwimK32G/9EfD8EslAPxvzI3EVLMQcJyufiwsN0XiSCXq2bAvjwcrDNV3l1E1OwsAOmNumxdWVx2TH+Z7GGCrGyvf9+srtNlpJKhmLNZWNtWLvmp8DiO8pFPSZT583bG/f/3DMUY0cBAhUQbXxFhvOF+NZM2zAZZyG58WnF/8VB28BQYtBEYV8NIHzlbibfN35gxVx4plqtJl+n6T8/EtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O3wP5osNTlRgfftymbzuwkAoQ1JUdpSE9DKOqspDwc=;
 b=C8uCz2X4guuqIHqXE+l6htciBpvd9utRpq47rV2oZurtUB0yYkmPYfp39bhVIdWCxICDaZUOYB3SN0AQ1XcFzyq743FiNt0ecMVDBIUmUilFa8fqsfAdwriueleVntn+/+fd4hYkq57SwvX/Nemx8JT+WEYtQuxLTxCZZqzTtTY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by PH7PR11MB5916.namprd11.prod.outlook.com (2603:10b6:510:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 9 May
 2022 11:24:12 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.025; Mon, 9 May 2022
 11:24:12 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <krzk+dt@kernel.org>, <palmer@dabbelt.com>,
        <robh+dt@kernel.org>, <mail@conchuod.ie>
CC:     <Cyril.Jean@microchip.com>, <Daire.McNamara@microchip.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <palmer@rivosinc.com>, <arnd@arndb.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 8/8] riscv: dts: microchip: add the sundance polarberry
Thread-Topic: [PATCH v4 8/8] riscv: dts: microchip: add the sundance
 polarberry
Thread-Index: AQHYX/aLhjmiyDTjgkGB2sKDjIUqMK0WascAgAAD0QA=
Date:   Mon, 9 May 2022 11:24:12 +0000
Message-ID: <5de89e89-c30d-d9fc-4ef7-f4c0327a28e8@microchip.com>
References: <20220504203051.1210355-1-mail@conchuod.ie>
 <20220504203051.1210355-9-mail@conchuod.ie> <8060906.T7Z3S40VBb@diego>
In-Reply-To: <8060906.T7Z3S40VBb@diego>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 672f86ec-f35e-4c13-16da-08da31ae718f
x-ms-traffictypediagnostic: PH7PR11MB5916:EE_
x-microsoft-antispam-prvs: <PH7PR11MB591668F10801E66EACD466FE98C69@PH7PR11MB5916.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWSNhlfLAYom+5Cue8mYkRUwSu+tQc1PPnIrjWpWRUYTslEIs+IRyqlM//fk1OgQVYV2XQ5jccAiGi6fezWBVzYb+/OPeJOPA55UMaJNNhHQTfaLaXNrYNwpWThQFhq2j2ZBIs7iMKJVXUC0nVRurueFkGrKvjOuLno2laGSicuYXnwJG4SgxU68KK21Ccy4BlcVRb2rxRQ7Q69+VjbmeAgrYHSQfUwyOcjVtw4hm+QwoULaJRMWB5qsrRGhPKuvk8eH6Arq13nhICUiHax4IiunUKXFUS+jqfsZvSB4Cx74oKCs59LRJsGWBFD8DlnKNduqXP7ENC64SBwqYmuBBuBuls71tbEBWtY8RKumKL+9BzPNB3kLmFQmxrIQfM03Sf/5QBoYnE3Q5yqzH1j9yQrTvY7LYR10zG0qXp7SfL6y1J7mlpZMrW/94zdiDJBI5jJLlneWhvHVCVTukOgVhiWZIRhVNKxTZ6MS6EcIg+iWww4HvqkOMSHcrNv/BZE9ZEaeWhtKOmY+i35XuEj68zwJ26sSbM4ajZ1aK18+4l+Nz02t1/PUsDjGV/a1L6mN172bcmxVoFnf01Mkk6T3fxNXnh7ESzgvsrYdFRp7W05b/rYrVcgEosSBhuvxaPbGjVIa00giF1AF+JykcDpn8bzHcgfdvWnBe31r0Q+y1Jlch4MiivG0cQJZ14p3P+z2CW5xXeDG3tYPJ2FRPXH4ScgI9k0X/HUQRs7yI9NP/dei6sqsodQfl/Y5kTMscQemJSc5IgI7nXrL4/zW0oINDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(71200400001)(36756003)(91956017)(4326008)(2616005)(76116006)(6506007)(66946007)(26005)(66556008)(316002)(66574015)(83380400001)(5660300002)(8676002)(66446008)(66476007)(31686004)(64756008)(508600001)(38100700002)(122000001)(6486002)(38070700005)(8936002)(2906002)(31696002)(86362001)(110136005)(54906003)(6512007)(53546011)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWdxdlYzQWZSaW1vcDdxMTNqTENyUmpscmYzeE5qemtjV0xobzlVNEhXNFJC?=
 =?utf-8?B?ZUowSlpaTUI2MVprRUN0VnRZMjJQeHljZjZ2dDJwL1U0dFdrcUxNdDh2S3Vo?=
 =?utf-8?B?VTd0OGxTblRwZEhKR1YyUmxyRGdnU2lSRmUyOTRLM3RheWFvTmIwenFabWN6?=
 =?utf-8?B?MWFOU3lKVXRYanBqcHBQR2EzZWVwY2pMcjg4OUU3QVZvYTZtOERJTnVINGQ4?=
 =?utf-8?B?TkFHaW9ra0VyUGVGS3BIZ2VDVUhiMVllWlF4elFSa3BXWHE1OW1pZ2dZWHdI?=
 =?utf-8?B?Z2RjenRLc2lYZWI5Z1d0L0RaYlZMWUI5TmhKOTZJOGJOc0JIOVYyc245Rk1R?=
 =?utf-8?B?Q1BUMWdIL2FCR3paUXUwcjRXNWlRQ1g3NGU2cUdDR0pwazFMRDRvcWZ4eWRM?=
 =?utf-8?B?WE5XaVlGVDVKamFFZ3RyU3lGUkZpai9DRFNNaytTWHNrc1l5M2JJbjhoczE1?=
 =?utf-8?B?R0FHL3RXTVFhK0tleFo3NTVTVktvdFhJQUNsWmQzZkxDVjVuNGFhQWZNWUY1?=
 =?utf-8?B?OTk4a1pTYXprb0w4cnNja21LTVVnYmJWZzEwbkVGOE52My9IL3o0cXU4S0pW?=
 =?utf-8?B?N2RHcGNCWWNZREs2dnBHejJ5OHB2UGRITTZKS2Z5aGFWZFFVRHZmL1BsWXBs?=
 =?utf-8?B?b1hCdXJIencwYjU5RWNTU09hQ1g3cjUrMkhtVnB2b01GT3ZpS21sQXdHRnl5?=
 =?utf-8?B?aDJ4UjF3UGRGSTNOdXpldHhaVEFwekFZVnFOVStUeG9TZUNRSVRzNUJkNUdP?=
 =?utf-8?B?TXdURnJJeTlPMThDR2ZIeXZ1WVZkRDdEUCtnZk5kU2RZRnNSK0M0SFdERlZz?=
 =?utf-8?B?MHJOMFZOTE1SZ0dSc1VYUThYNDZ5Q21uWXdFeE1TaWdwTTlaVWpwMFBuazdS?=
 =?utf-8?B?QmxCcEdCcWNSSThzak9Ea2o4Ri9jSEVjZW51bG9oKy9PY2paL1hVSUpYZ2FU?=
 =?utf-8?B?QXpXeHM1ejJjd2FPUS9LUERJUE8zcmo0Y3IvZlRxZ1Z5QVgvQlhQUVBseGor?=
 =?utf-8?B?cjF5MUJVTjdUeXZGVExYUlZvZSsxbjNtWU9WS0FncmdwdDBoV3ViSzFlMC8y?=
 =?utf-8?B?NEFuQWhQVVdLN05heEhmcWg1UzNoaTcwWFpTdTNSalFIcUFVNlo3MTYzSDda?=
 =?utf-8?B?S2VaTG1kVWJrRGZ5YXZGbWM2TUNNVER2aUh0MjNCbFI5TSthT2FqdGl0Vnlz?=
 =?utf-8?B?ekY5ZWJCaEtieEJRWEh2Y2FCaXBReWxQWHNYL2FMd1hLaDJINllXblRyOVNT?=
 =?utf-8?B?M1EyN0hXRml2RURjd0RlbFNLVVlDaUdkaVhvR3M1bVFBVDN0MUV4OUsxaGFa?=
 =?utf-8?B?a3A0YkFib0loT2NOeEEybktnSU5lOHo2dFovWC9sSlN6Y0V4LzJMUXhnMXEz?=
 =?utf-8?B?UDA2aXl1c0haQ3BkNm1ZL3ZUMU1tTzh6U2xDT3dTMHpzWDlIeVRGYnpUQkRH?=
 =?utf-8?B?U0UwOFc2MUtoWWpIMWJGMjlwNjRKT1hHOVQ0NmQ5cXpxZXhLUVN6bmZ6UHJX?=
 =?utf-8?B?Y2dpTnJSeExQcllZazFDT1VPRFNUbkhDOE1seDJMWGhLR2w2U28vQ045Mmg0?=
 =?utf-8?B?aVUwNGFneFRqNG8yRHVkTTBpMGxyWklwUm0zMGtVaHhkTU9kVkg3TXRDL0Yy?=
 =?utf-8?B?Sm5QcWp2UlZUZTJtdnc5MXVjWDMveUVtdFl0V2REc01sbnF2c00yeW1jNmFO?=
 =?utf-8?B?eDdZa1BKTW5BQ3c0VCtNVGRGLzh2cGc1Sm1yeFU3eW1ERkFEOGhxSjd6QWJ5?=
 =?utf-8?B?aTFtWW9oeDMrdXJxckJ0UlNZMk9rZ2VNUktKOEVWVzZCeXJXU0ZmUGh3ZWUr?=
 =?utf-8?B?Zk5mcm9NVzNlQk9MVHhPUm5xWm40L3lMbkRVYTVrVEZSNEYxcGkyakdacERU?=
 =?utf-8?B?VjVicEhrZ3plYTgrcUtrZEdRZ3RGS3JGOTdBU3ZYOGpvTnR1ajM4YjR0cTFH?=
 =?utf-8?B?TEtuNTYzT2U0TGJwYy9nNjdqeFdReDNzRWVRb1RuRkpMTWVMaktzRUpUR2hr?=
 =?utf-8?B?ZVQ2Zk1LdGhqRnVrbUR3KzVWU25vV2dXeklIWFFCYXlwTllycDNjaTRBajFY?=
 =?utf-8?B?SVdMbEsyeEt1VFN1WWZ6Q0FmNWU2UGpzOG0xZE5JdDRJWEhpSFVUbTM3QkVH?=
 =?utf-8?B?RkxrME95WERyOGpad3FRVkFmakZYUUxoVkMvVXRramZkUWRqbzdyY3luQll5?=
 =?utf-8?B?T08wTGdwZVZSOW84RFMvL091bHhGWXViMFEvVlZ6K0xNZGhweUVaeElZSk5H?=
 =?utf-8?B?TVNleHBwYTNLSG5oa0JTcENnUXo3RVVMbG8rN1JvYnhIOEdscFRmdmNzcURr?=
 =?utf-8?B?OTBFRUF1eWdLR1gyZ0VaVHpFWFF4WUpMMFJZTEx0aTRCQ2lvaG01QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9461788DA93D14895D3B7C254785F58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672f86ec-f35e-4c13-16da-08da31ae718f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 11:24:12.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfWPUSlNbH+vV6WhRgiURqmSmgaBeEf8842ij1365kOBOpWAgC9cuSVAYODXApaPb6aPxEq4vhRO2+z9ewSeuiH7MdID0JgyCYExUd7g4+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5916
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDUvMjAyMiAxMjoxMCwgSGVpa28gU3TDvGJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gTWl0dHdvY2gsIDQuIE1haSAyMDIyLCAy
MjozMDo1MiBDRVNUIHNjaHJpZWIgQ29ub3IgRG9vbGV5Og0KPj4gRnJvbTogQ29ub3IgRG9vbGV5
IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBBZGQgYSBtaW5pbWFsIGRldmlj
ZSB0cmVlIGZvciB0aGUgUG9sYXJGaXJlIFNvQyBiYXNlZCBTdW5kYW5jZQ0KPj4gUG9sYXJCZXJy
eS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNy
b2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL01h
a2VmaWxlICAgICAgICB8ICAxICsNCj4+ICAgLi4uL2R0cy9taWNyb2NoaXAvbXBmcy1wb2xhcmJl
cnJ5LWZhYnJpYy5kdHNpIHwgMTYgKysrDQo+PiAgIC4uLi9ib290L2R0cy9taWNyb2NoaXAvbXBm
cy1wb2xhcmJlcnJ5LmR0cyAgICB8IDk3ICsrKysrKysrKysrKysrKysrKysNCj4+ICAgMyBmaWxl
cyBjaGFuZ2VkLCAxMTQgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJj
aC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1wb2xhcmJlcnJ5LWZhYnJpYy5kdHNpDQo+
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZz
LXBvbGFyYmVycnkuZHRzDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMv
bWljcm9jaGlwL01ha2VmaWxlIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvTWFrZWZp
bGUNCj4+IGluZGV4IGFmM2E1MDU5YjM1MC4uMzlhYWU3YjA0ZjFjIDEwMDY0NA0KPj4gLS0tIGEv
YXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvTWFrZWZpbGUNCj4+ICsrKyBiL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvbWljcm9jaGlwL01ha2VmaWxlDQo+PiBAQCAtMSwzICsxLDQgQEANCj4+ICAg
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gICBkdGItJChDT05GSUdfU09D
X01JQ1JPQ0hJUF9QT0xBUkZJUkUpICs9IG1wZnMtaWNpY2xlLWtpdC5kdGINCj4+ICtkdGItJChD
T05GSUdfU09DX01JQ1JPQ0hJUF9QT0xBUkZJUkUpICs9IG1wZnMtcG9sYXJiZXJyeS5kdGINCj4+
ICAgb2JqLSQoQ09ORklHX0JVSUxUSU5fRFRCKSArPSAkKGFkZHN1ZmZpeCAubywgJChkdGIteSkp
DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1wb2xh
cmJlcnJ5LWZhYnJpYy5kdHNpIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1w
b2xhcmJlcnJ5LWZhYnJpYy5kdHNpDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi40OTM4MGM0MjhlYzkNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2Fy
Y2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtcG9sYXJiZXJyeS1mYWJyaWMuZHRzaQ0K
Pj4gQEAgLTAsMCArMSwxNiBAQA0KPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMCBPUiBNSVQpDQo+PiArLyogQ29weXJpZ2h0IChjKSAyMDIwLTIwMjIgTWljcm9jaGlwIFRl
Y2hub2xvZ3kgSW5jICovDQo+PiArDQo+PiArLyB7DQo+PiArICAgICBmYWJyaWNfY2xrMzogZmFi
cmljLWNsazMgew0KPj4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsN
Cj4+ICsgICAgICAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPj4gKyAgICAgICAgICAgICBj
bG9jay1mcmVxdWVuY3kgPSA8NjI1MDAwMDA+Ow0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICsgICAg
IGZhYnJpY19jbGsxOiBmYWJyaWMtY2xrMSB7DQo+PiArICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAiZml4ZWQtY2xvY2siOw0KPj4gKyAgICAgICAgICAgICAjY2xvY2stY2VsbHMgPSA8MD47DQo+
PiArICAgICAgICAgICAgIGNsb2NrLWZyZXF1ZW5jeSA9IDwxMjUwMDAwMDA+Ow0KPj4gKyAgICAg
fTsNCj4+ICt9Ow0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlw
L21wZnMtcG9sYXJiZXJyeS5kdHMgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZz
LXBvbGFyYmVycnkuZHRzDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAw
MDAwMDAwLi4xY2FkNWIwZDQyZTENCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvcmlz
Y3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtcG9sYXJiZXJyeS5kdHMNCj4+IEBAIC0wLDAgKzEs
OTcgQEANCj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgTUlUKQ0K
Pj4gKy8qIENvcHlyaWdodCAoYykgMjAyMC0yMDIyIE1pY3JvY2hpcCBUZWNobm9sb2d5IEluYyAq
Lw0KPj4gKw0KPj4gKy9kdHMtdjEvOw0KPj4gKw0KPj4gKyNpbmNsdWRlICJtcGZzLmR0c2kiDQo+
PiArI2luY2x1ZGUgIm1wZnMtcG9sYXJiZXJyeS1mYWJyaWMuZHRzaSINCj4+ICsNCj4+ICsvKiBD
bG9jayBmcmVxdWVuY3kgKGluIEh6KSBvZiB0aGUgcnRjY2xrICovDQo+PiArI2RlZmluZSBNVElN
RVJfRlJFUSAgMTAwMDAwMA0KPj4gKw0KPj4gKy8gew0KPj4gKyAgICAgbW9kZWwgPSAiU3VuZGFu
Y2UgUG9sYXJCZXJyeSI7DQo+PiArICAgICBjb21wYXRpYmxlID0gInN1bmRhbmNlLHBvbGFyYmVy
cnkiLCAibWljcm9jaGlwLG1wZnMiOw0KPj4gKw0KPj4gKyAgICAgYWxpYXNlcyB7DQo+PiArICAg
ICAgICAgICAgIGV0aGVybmV0MCA9ICZtYWMxOw0KPj4gKyAgICAgICAgICAgICBzZXJpYWwwID0g
Jm1tdWFydDA7DQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgY2hvc2VuIHsNCj4+ICsgICAg
ICAgICAgICAgc3Rkb3V0LXBhdGggPSAic2VyaWFsMDoxMTUyMDBuOCI7DQo+PiArICAgICB9Ow0K
Pj4gKw0KPj4gKyAgICAgY3B1cyB7DQo+PiArICAgICAgICAgICAgIHRpbWViYXNlLWZyZXF1ZW5j
eSA9IDxNVElNRVJfRlJFUT47DQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgZGRyY19jYWNo
ZV9sbzogbWVtb3J5QDgwMDAwMDAwIHsNCj4+ICsgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAi
bWVtb3J5IjsNCj4+ICsgICAgICAgICAgICAgcmVnID0gPDB4MCAweDgwMDAwMDAwIDB4MCAweDJl
MDAwMDAwPjsNCj4+ICsgICAgIH07DQo+PiArDQo+PiArICAgICBkZHJjX2NhY2hlX2hpOiBtZW1v
cnlAMTAwMDAwMDAwMCB7DQo+PiArICAgICAgICAgICAgIGRldmljZV90eXBlID0gIm1lbW9yeSI7
DQo+PiArICAgICAgICAgICAgIHJlZyA9IDwweDEwIDB4MDAwMDAwMDAgMHgwIDB4QzAwMDAwMDA+
Ow0KPj4gKyAgICAgfTsNCj4+ICt9Ow0KPj4gKw0KPj4gKy8qDQo+PiArICogcGh5MCBpcyBjb25u
ZWN0ZWQgdG8gbWFjMCwgYnV0IHRoZSBwb3J0IGl0c2VsZiBpcyBvbiB0aGUgKG9wdGlvbmFsKSBj
YXJyaWVyDQo+PiArICogYm9hcmQuDQo+PiArICovDQo+PiArJm1hYzAgew0KPj4gKyAgICAgc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4+ICsgICAgIHBoeS1tb2RlID0gInNnbWlpIjsNCj4+ICsgICAg
IHBoeS1oYW5kbGUgPSA8JnBoeTA+Ow0KPiANCj4gbml0OiBpdCBtYWtlcyBpdCB3YXMgZWFzaWVy
IHJlY29nbml6aW5nIHRoZSBzdGF0dXMgaWYgaXQncyBpbiB0aGUNCj4gc2FtZSBwbGFjZSBhbGwg
dGhlIHRpbWUgKGZvciBleGFtcGxlIGFzIHRoZSBsYXN0IHByb3BlcnR5KQ0KPiBsaWtlIGluICZt
bWMgYmVsb3cuDQo+IA0KPiBUaG91Z2ggdGhhdCBtYXkganVzdCBiZSBteSBwcmVmZXJlbmNlIDst
KSAuDQo+IFRoZSBvdGhlciBvcHRpb24gd291bGQgYmUgdG8gYWRoZXJlIHRvIHN0cmljdGVyIHNv
cnRpbmcNCj4gYmVjYXVzZSByaWdodCBub3cgc3RhdHVzIGlzIG5laXRoZXIgaW4gb25lIHBsYWNl
IG5vciBzb3J0ZWQuDQoNCk15IEkgaGFkIGl0IGluIG15IGhlYWQgKGFuZCBjb3JyZWN0IG1lIGlm
IEkgYW0gd3JvbmcgcGxlYXNlKSwgdGhhdCBpdCBpcw0Kb2theSB0byBzb3J0IHRoZSBwaHlzIGFm
dGVyIHRoZSBzdGF0dXMuIEl0IGRvZXNuJ3QgbWF0dGVyIGVpdGhlciB3YXkgdG8NCm1lLCBidXQg
dGhlcmUgYXJlIHBsZW50eSBvZiBkdHMgdGhhdCBkbyBpdCB0aGlzIHdheS4NCg0KSSBkb24ndCBj
YXJlIGVpdGhlciB3YXksIHNvIEkgYW0gaGFwcHkgdG8gY2hhbmdlIGlmIHRob3NlIGFyZSBiYWQg
ZXhhbXBsZXMNCnRvIGZvbGxvdyENCg0KPiANCj4gDQo+PiArfTsNCj4+ICsNCj4+ICsmbWFjMSB7
DQo+PiArICAgICBzdGF0dXMgPSAib2theSI7DQo+PiArICAgICBwaHktbW9kZSA9ICJzZ21paSI7
DQo+PiArICAgICBwaHktaGFuZGxlID0gPCZwaHkxPjsNCj4gDQo+IG5pdCAoMSk6IHNhbWUgYXMg
YWJvdmUNCj4gbml0ICgyKTogYmxhbmsgbGluZSBiZXR3ZWVuIHByb3BlcnRpZXMgYW5kIHN1Ym5v
ZGVzIG1ha2VzDQo+ICAgIGV2ZXJ5dGhpbmcgbW9yZSByZWFkYWJsZS4NCg0KQXllLCBub3Qgd3Jv
bmcuIEknbGwgZml4IHRoaXMgcmVnYXJkbGVzcyBvZiB3aGF0IGhhcHBlbnMgd2l0aA0KdGhlIHN0
YXR1cyBvcmRlcmluZy4NClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPj4gKyAgICAgcGh5MTogZXRo
ZXJuZXQtcGh5QDUgew0KPj4gKyAgICAgICAgICAgICByZWcgPSA8NT47DQo+PiArICAgICAgICAg
ICAgIHRpLGZpZm8tZGVwdGggPSA8MHgwMT47DQo+PiArICAgICB9Ow0KPiANCj4gbml0OiBibGFu
ayBsaW5lPw0KPiANCj4gT3RoZXJ3aXNlOg0KPiBSZXZpZXdlZC1ieTogSGVpa28gU3R1ZWJuZXIg
PGhlaWtvQHNudGVjaC5kZT4NCj4gDQo+PiArICAgICBwaHkwOiBldGhlcm5ldC1waHlANCB7DQo+
PiArICAgICAgICAgICAgIHJlZyA9IDw0PjsNCj4+ICsgICAgICAgICAgICAgdGksZmlmby1kZXB0
aCA9IDwweDAxPjsNCj4+ICsgICAgIH07DQo+PiArfTsNCj4+ICsNCj4+ICsmbWJveCB7DQo+PiAr
ICAgICBzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmbW1jIHsNCj4+ICsgICAg
IGJ1cy13aWR0aCA9IDw0PjsNCj4+ICsgICAgIGRpc2FibGUtd3A7DQo+PiArICAgICBjYXAtc2Qt
aGlnaHNwZWVkOw0KPj4gKyAgICAgY2FwLW1tYy1oaWdoc3BlZWQ7DQo+PiArICAgICBjYXJkLWRl
dGVjdC1kZWxheSA9IDwyMDA+Ow0KPj4gKyAgICAgbW1jLWRkci0xXzh2Ow0KPj4gKyAgICAgbW1j
LWhzMjAwLTFfOHY7DQo+PiArICAgICBzZC11aHMtc2RyMTI7DQo+PiArICAgICBzZC11aHMtc2Ry
MjU7DQo+PiArICAgICBzZC11aHMtc2RyNTA7DQo+PiArICAgICBzZC11aHMtc2RyMTA0Ow0KPj4g
KyAgICAgc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJm1tdWFydDAgew0KPj4g
KyAgICAgc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJnJlZmNsayB7DQo+PiAr
ICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MTI1MDAwMDAwPjsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZy
dGMgew0KPj4gKyAgICAgc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJnN5c2Nv
bnRyb2xsZXIgew0KPj4gKyAgICAgc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+Pg0KPiANCj4g
DQo+IA0KPiANCg0K
