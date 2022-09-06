Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA85AE1A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiIFHzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiIFHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:55:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF1F1263B;
        Tue,  6 Sep 2022 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662450900; x=1693986900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2V0/TGR6qaCW0TW7ZaBP4I4tQ0y6uacyePPhtnBQNFo=;
  b=Cdt9hsho+TTrYXdry5iDENzAPvw31FICbjXjy5QL/1banHQAK1oXk8+I
   rRneAb/IREXrWnO6OBgF+EtoUq1qqAq9c98zkSeJMeE2/XXHtIBN8ZVHY
   dLjYLC/UrWurV6vMWfTDRKxHwm1pJwYsOsjPjAPdStHUIv8S0LDIZmdFt
   /cKuYLJuCunLF0ZhekmwldmlTvdU5WavL38dpwLTZA09GqkqOVNDDNWxy
   gz5Acsh1hKPZGAkc26MDha0dJJkD0mlMtGrdusTUDta0VTL3DRyRXXAvZ
   eiCSGnqlv4N/6YKYylvRn+KEXRdXrn2PeaYaRP+g3m49P/n9DvIvGMkHI
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="112326414"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 00:54:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 00:54:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 00:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBgASD1XhZM9IBchP1EHxigOF55qQtlY0IxihfzII5ylIiU9MQk2C/E1sl+qbN6HrnsZ5HOqwW9ge9ypZTevI2yOFmpELgFgWCxT8ANUIvvUqxQ+OHq/1+/3TY23LW2KHEnS8YxIp7ZkArv2woyRxpYkZpFzE1bORouM4CggGktr2EoJDwECw7iq9+X84YJi4QFp2+/TGa7qJByPSl6ppsBiYZYTQUN8Ufqn+bkC+NdcY7HJYeg6PmA+m6C/D4B84SGib6nSGRhNeZfsLONwasaQGflXh9os9DapwhTZl4ualciXMvkHjugbKZJ9eJ5Mtkv+bQl8wPs1A4h2u/h4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V0/TGR6qaCW0TW7ZaBP4I4tQ0y6uacyePPhtnBQNFo=;
 b=kqopTCDqcwOuH64RMjiIWIGKhUAm5Nyz4058OODctC54R5vNNvNKPDwBZJR/0md1tvCJNAFntZfhwKzqGqwHPRUbBAFCBP754D3YexB7Ui+zve7/LtF0VIY02wo2diuP1bL/zYklgI/NK/6ZB7QP8D6ceXGrIoh9E3aEKnLFaq1ys+vUzc/CZycrPUoDdB+yKxKxrnmqk9QJJsKkXd9Yth9DzaUtvsuILz087ZF8Iwi1Z/Y02Z0G+8bBlMPzmqoTkEDkvFP+DW6zUQrLj3v7IKmRE8GGTQD3PXLjqs28TstOLEKEpPc584Kwk8GZCjv/TD/SPmSs5f87CTiW8HqwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V0/TGR6qaCW0TW7ZaBP4I4tQ0y6uacyePPhtnBQNFo=;
 b=pyNGAucR9deIbmBJ8m2DFeEGJzpR6Pct60abaROMUYazpeku8LHYspT2XeLzyk2JDA4FFs/z7gnseLAYKN2dve2HkurjpDbw7gWhw9+XhFaI3RbkCZda/0yQS3spini3gp3BddLW57kzegEp+0ck1WTHTRID5ujUa7AnlHnrOBU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5499.namprd11.prod.outlook.com (2603:10b6:408:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 07:54:54 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:54:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>, <Hugh.Breslin@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 4/5] clk: microchip: add PolarFire SoC fabric clock
 support
Thread-Topic: [PATCH v4 4/5] clk: microchip: add PolarFire SoC fabric clock
 support
Thread-Index: AQHYvGw2pGE3bq7Jh02DNE/vEJB+3a3SC6KAgAAHVgA=
Date:   Tue, 6 Sep 2022 07:54:53 +0000
Message-ID: <119689dc-f264-4a33-cef3-400e07fc7517@microchip.com>
References: <20220830122855.2207752-1-conor.dooley@microchip.com>
 <20220830122855.2207752-5-conor.dooley@microchip.com>
 <e3477cef-dc8f-3c20-126b-cbd514233867@microchip.com>
In-Reply-To: <e3477cef-dc8f-3c20-126b-cbd514233867@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff0579c4-49ec-4238-6175-08da8fdd1596
x-ms-traffictypediagnostic: BN9PR11MB5499:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CBr4UY9DJJnrd6IRCS94wro5LJr385HYqhYkMiYgRlAAvS4hVafmclM1BL7Oqpq9lAHmmwlBDXT1OXVJj4f1fz63ajv9Jo7Yav/jPWW4ynrtbSo0zcJiEhKd0vcepIxgW2p7e5il4+kKvJBC0DX1emYDHWtnWBBM2VZ0n0MQI48GkrrkwC7CO2I7ca7gUD+sF7eRImiXX/5H9gyuhWxgQn+hsak/w/JQlR/scfetBtNd7gE/4eeppTz4Rcqlcy6xLnybxw0yT337VKh0hyHsOszmiJs1n3Pna9SwC55ZAwiyw8u2nIel1RLIWzEmAtmzKwgCbpIUStwOiPbmOyhrF3yW6jWi7tYL+EesOc73QrcOrBEu6YhL2p05zAruqmWVdabya9YTvRbIZCMVcF+bBHfFEdUXslG+9laRU9In/GWwUJ+ribxvGvhD1ytFcfgodeQuyDM6cpSVbhMSj7mPsgpMYtllCXCeqkOpG0bXgjhAdUd2p8ZKkQ7ur7hm9os7T/IGVurk7NE4xB0OMyQM9+3lL64ZJIldRq46yLG2N6QRILD3ano7uA1o4R52lEQaS+vFqeb0fkaK7FB84wtYOH/tfaYBYentGl+Y50tn3Vs98khNRwwh5NscFXE1aCUL6+lXUhq5NnoOVE4Wwgc6x3uNF5sImMaB3MWnyokad3+QojZUirhVsWyEPoqVVtN11/uNiamPN/2Jlc/72gOWNZ2txY2zmIwbkem9Spgj9Zl6cGMal1UoOPaYdqEltGyPTCs8YvhTI8BL5edFtjE/yvFJYeRb18LW4PI6tcrXnUoqMSXP4DwxFvIsNTPSKs99TAut0acUSW6UsMEgfwddbrN4uRGewOfFF3x74aOnWxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(376002)(366004)(39860400002)(86362001)(2616005)(186003)(478600001)(71200400001)(6486002)(966005)(26005)(41300700001)(6512007)(31696002)(122000001)(53546011)(38100700002)(38070700005)(6506007)(83380400001)(5660300002)(316002)(54906003)(8676002)(2906002)(8936002)(4326008)(6636002)(36756003)(110136005)(91956017)(31686004)(66946007)(66446008)(7416002)(66476007)(66556008)(76116006)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm91dUNsbndtWktFMGVZMlUrZWF4dnkyZGd3U21QczRjaUxheklmVWFvQlNv?=
 =?utf-8?B?MVhOaVV2MjZVeEtqTVlRdWxGbEJtK3ZXNmp3b2ZNUDVoeEh3TkM5ZjhVdnAy?=
 =?utf-8?B?V2tTNklBeHNmdjhub2ZGa29ENVM1SHJFTm11WDNCY1VPdlNuZUV1d1JFd204?=
 =?utf-8?B?VG95a1pPaVJzUUs0aGlYVzJ4OWtLUFcwRDNrckVtSEJpdXdmTEhCaDViREda?=
 =?utf-8?B?cFhZaGh5azVmUWhYQmYvODBIcktNaGlMclFNZ25tU1ZjOFNmb2swenpIYkN2?=
 =?utf-8?B?TnYveUM0TnFJcWZ2Y09vTUM1MllteTlsYUVpWmt1N2F3MVAvMDhXR3lDYnJs?=
 =?utf-8?B?eHJRQUtFcU9tc0FwYkUrS28yeVZDYWZQSnc2Sm5qMEhUUnRWNWZ3MVhKQWtF?=
 =?utf-8?B?eEtkaVJjQzJmT2Z4NzV2Zmx1dGZmUWpXd29qMVE5SHRUZFJrUXcwWjlpMkhi?=
 =?utf-8?B?TFNDaWNDOWR5ZUdmNEpqdm03RFUyZGxTMEU5TlV4bU54QTg2dnF5SjVDNUVD?=
 =?utf-8?B?cjZNNHhuM3dkZlNsMjB0OXdCUUdvM3RvRDd3RFhNOEJRV01aU083bkJWSVRR?=
 =?utf-8?B?OWtFd3RFVi9KaldqSENLS1RBelFmaFAxemVHWHJzZVlsdHJCVkQwaGQ0YXVS?=
 =?utf-8?B?S3k4dU5YdnBhaTcwanQrbFVxMHRINlJleXpDRFgyNm91VnB6ZnAybktQUTB6?=
 =?utf-8?B?WisxNFdxbjFtOFZTWmk4SDdGdmhkUTBFYWFOd1ovbGh6cDU2cWNaUFhDQzBv?=
 =?utf-8?B?YmtUejN4a1lZTmhPNzZ4MUt3cVQ4VHlYWWdFUjFnVVBWKzdrYzNRbjUzSXJY?=
 =?utf-8?B?Q2ZQajFNU21DaVpZL3RzV200UzYycGdZL1lEWVhFQ2wrc2RzNHo4WHNpT3Ux?=
 =?utf-8?B?d0Y0Z2lFZGxKSkdiZUh2dDEyWkdaZ3lsYjh5UUlpenUwcWdqSjVoNW9pSmsr?=
 =?utf-8?B?UC9lWWtwTVpTK0VWczFqdWxUSVAyeTVRN0UrRXBZQnl5MlNITHdkaE0vdFRp?=
 =?utf-8?B?aDFZVG1IZFdWZDhyUGlVUmtabkppQjRKOGp6WW0yREVYLzg1T0FvQmo2QUJ6?=
 =?utf-8?B?SkwzQUo0MTNEa3VudWhaVEw4dnlhQnhLSG5tMHl2NFo4bGEyajhySDRMRDRV?=
 =?utf-8?B?TUV4cU5kaFlUeTBkQTV5TG5lcHNucmV6SDVQSENRREhXNlJUOHkybDJpa3Z0?=
 =?utf-8?B?S25BTDJCUFV5dGY0UThCVEJHeENCYWV0ejJHRys5M2V2amo3MDIxUHI3c1VE?=
 =?utf-8?B?dGZhSlBXRlY2aENmRGFGNDdGN1BpN1BJcGFRYnNFN08vOW9CdkNvYlBqNy9N?=
 =?utf-8?B?ZTZza2dFcVBSckFBQ1NKejZpL0hKTHdZL2xpQjladDd3SHRRTU5TSi8xRzNl?=
 =?utf-8?B?VDhnZks3TjlSSGNOTEhxMkVoM1huTkIzbTJKejBqSGtFV2t2SzJRN3JjVkU3?=
 =?utf-8?B?S1N3NnNUclFQd1VwVm0zcTBMK2hTRktHd1BWNXhLNmdxUVl6MEZGTGIrNkpX?=
 =?utf-8?B?aUdTSk1KUnNnQ0J2cFRWQnZ4NnN0c1FsMndWcEVvZmhQWWpUdVZiNVRzN3Nr?=
 =?utf-8?B?SFhpMXNPTmR2d1d4ODBlRnI0MVc1Ly9qbDJQbTBJMnNmeFBoOTBoem1OUUFL?=
 =?utf-8?B?eDRMWkJyMHVDTDMzK1ZWQkNxRFNtOFNWYWhLb2lPS0tMQ3pJQWFUdm52dTNS?=
 =?utf-8?B?NEhHVmNvNUphTXZPRVVEbnIxelp0Y2p3Y1RiYXVVclJBNDNQQ0ZyZ1VlTm1a?=
 =?utf-8?B?VXZiUSt1U09EU1BxaTBta1N2WThFYWVkaEQ2YW9ubU1BNkRLaWNxVHBocElG?=
 =?utf-8?B?WTlBQ3VjRnJESFJ2b3E1Mk1iRUhxd1g5SjU0T2V2RFVVRnlzcGNOTVU4SUx2?=
 =?utf-8?B?QTBrUUJQQ3IxNXdVL0tETFVNMWhmcDYxTjB6RVh6VGhzR2FiRldrekhxaU5T?=
 =?utf-8?B?WkF2ZHA5TURtN3AzZEx1THdJNWU2RitiRTVOVlN2N2E3ZUwxaHByYm92RVNE?=
 =?utf-8?B?QU5uQXhtaitqcWFOSWFYWlRCYjRjT0NyVE9XZDBvZDNsbU9tTWxZdklRYXgr?=
 =?utf-8?B?bzBmcWVITzBOcUExYmhLZUpJOUwvalpRSm5lTjJiUlQ1SWVzQitxaFZJeitI?=
 =?utf-8?Q?5WYE9Hs/bxNPv/l1FflyeYTyk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <669E4624F446D14E9651A17A0456435F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0579c4-49ec-4238-6175-08da8fdd1596
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 07:54:53.8755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbKxqR8yLNyyLmBJyMry0kwvdaVqK/VRcnxj3IQ7AXw93KRBN/BIJxCZ2tPBDd05A/1/+G/RrFHitAbpHRF1yEj+8OUIcus+Hw8J9XiuHDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5499
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDkvMjAyMiAwODoyOCwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDMwLjA4LjIwMjIgMTU6MjgsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IEFkZCBhIGRyaXZlciB0
byBzdXBwb3J0IHRoZSBQTExzIGluIFBvbGFyRmlyZSBTb0MncyBDbG9jayBDb25kaXRpb25pbmcN
Cj4+IENpcmN1aXRyeSwgYW4gaW5zdGFuY2Ugb2Ygd2hpY2ggaXMgbG9jYXRlZCBpbiBlYWNoIG9y
ZGluYWwgY29ybmVyIG9mDQo+PiB0aGUgRlBHQS4gT25seSBnZXRfcmF0ZSgpIGlzIHN1cHBvcnRl
ZCBhcyB0aGVzZSBjbG9ja3MgYXJlIGludGVuZGVkIHRvDQo+PiBiZSBzdGF0aWNhbGx5IGNvbmZp
Z3VyZWQgYnkgdGhlIEZQR0EgZGVzaWduLiBDdXJyZW50bHksIHRoZSBETExzIGFyZQ0KPj4gbm90
IHN1cHBvcnRlZCBieSB0aGlzIGRyaXZlci4gRm9yIG1vcmUgaW5mb3JtYXRpb24gb24gdGhlIGhh
cmR3YXJlLCBzZWUNCj4+ICJQb2xhckZpcmUgU29DIEZQR0EgQ2xvY2tpbmcgUmVzb3VyY2VzIiBp
biB0aGUgbGluayBiZWxvdy4NCj4+DQo+PiBMaW5rOiBodHRwczovL29ubGluZWRvY3MubWljcm9j
aGlwLmNvbS9wci9HVUlELThGMENDNEMwLTAzMTctNDI2Mi04OUNBLUNFNzc3M0VEMTkzMS1lbi1V
Uy0xL2luZGV4Lmh0bWwNCj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+DQoNCj4+ICsNCj4+ICsjZGVmaW5lIENMS19DQ0NfUExMKF9pZCwg
X3BhcmVudHMsIF9zaGlmdCwgX3dpZHRoLCBfZmxhZ3MsIF9vZmZzZXQpIHsJCVwNCj4+ICsJLmlk
ID0gX2lkLAkJCQkJCQkJCVwNCj4+ICsJLnNoaWZ0ID0gX3NoaWZ0LAkJCQkJCQkJXA0KPj4gKwku
d2lkdGggPSBfd2lkdGgsCQkJCQkJCQlcDQo+PiArCS5yZWdfb2Zmc2V0ID0gX29mZnNldCwJCQkJ
CQkJCVwNCj4+ICsJLmZsYWdzID0gX2ZsYWdzLAkJCQkJCQkJXA0KPj4gKwkucGFyZW50cyA9IF9w
YXJlbnRzLFwNCj4gDQo+IFRoZXJlIGlzIGEgYml0IG9mIG1pc3NhbGlnbm1lbnQgb2YgXCBpbiB0
aGlzIG1hY3JvLg0KPiANCg0KRXd3LCB0aGVyZSBpcy4uLg0KDQo+PiArc3RhdGljIGludCBtcGZz
X2NjY19yZWdpc3Rlcl9wbGxzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1wZnNfY2NjX3Bs
bF9od19jbG9jayAqcGxsX2h3cywNCj4+ICsJCQkJICB1bnNpZ25lZCBpbnQgbnVtX2Nsa3MsIHN0
cnVjdCBtcGZzX2NjY19kYXRhICpkYXRhKQ0KPj4gK3sNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+
ICsJZm9yICh1bnNpZ25lZCBpbnQgaSA9IDA7IGkgPCBudW1fY2xrczsgaSsrKSB7DQo+PiArCQlz
dHJ1Y3QgbXBmc19jY2NfcGxsX2h3X2Nsb2NrICpwbGxfaHcgPSAmcGxsX2h3c1tpXTsNCj4+ICsJ
CWNoYXIgKm5hbWUgPSBkZXZtX2t6YWxsb2MoZGV2LCAxOCwgR0ZQX0tFUk5FTCk7DQo+PiArDQo+
PiArCQlwbGxfaHctPmJhc2UgPSBkYXRhLT5wbGxfYmFzZVtpXTsNCj4+ICsJCXNucHJpbnRmKG5h
bWUsIDE4LCAiY2NjJXNfcGxsJXUiLCBzdHJjaHJudWwoZGV2LT5vZl9ub2RlLT5mdWxsX25hbWUs
ICdAJyksIGkpOw0KPj4gKwkJcGxsX2h3LT5uYW1lID0gKGNvbnN0IGNoYXIgKiluYW1lOw0KPj4g
KwkJcGxsX2h3LT5ody5pbml0ID0gQ0xLX0hXX0lOSVRfUEFSRU5UU19EQVRBX0ZJWEVEX1NJWkUo
cGxsX2h3LT5uYW1lLA0KPj4gKwkJCQkJCQkJICAgICAgcGxsX2h3LT5wYXJlbnRzLA0KPj4gKwkJ
CQkJCQkJICAgICAgJm1wZnNfY2NjX3BsbF9vcHMsIDApOw0KPj4gKw0KPj4gKwkJcmV0ID0gZGV2
bV9jbGtfaHdfcmVnaXN0ZXIoZGV2LCAmcGxsX2h3LT5odyk7DQo+PiArCQlpZiAocmV0KQ0KPj4g
KwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGNj
YyBpZDogJWRcbiIsDQo+PiArCQkJCQkgICAgIHBsbF9ody0+aWQpOw0KPj4gKw0KPj4gKwkJZGF0
YS0+aHdfZGF0YS5od3NbcGxsX2h3LT5pZF0gPSAmcGxsX2h3LT5odzsNCj4+ICsNCj4+ICsJCXJl
dCA9IG1wZnNfY2NjX3JlZ2lzdGVyX291dHB1dHMoZGV2LCBtcGZzX2NjY19wbGxvdXRfY2xrc1tp
XSwNCj4+ICsJCQkJCQlNUEZTX0NDQ19PVVRQVVRTX1BFUl9QTEwsIGRhdGEsIHBsbF9odyk7DQo+
PiArCQlpZiAocmV0KQ0KPj4gKwkJCXJldHVybiByZXQ7DQo+PiArCX0NCj4+ICsNCj4+ICsJcmV0
dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgbXBmc19jY2NfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICt7DQo+PiArCXN0cnVjdCBtcGZzX2NjY19kYXRh
ICpjbGtfZGF0YTsNCj4+ICsJdm9pZCBfX2lvbWVtICpwbGxfYmFzZVtBUlJBWV9TSVpFKG1wZnNf
Y2NjX3BsbF9jbGtzKV07DQo+PiArCXVuc2lnbmVkIGludCBudW1fY2xrczsNCj4+ICsJaW50IHJl
dDsNCj4+ICsNCj4+ICsJbnVtX2Nsa3MgPSBBUlJBWV9TSVpFKG1wZnNfY2NjX3BsbF9jbGtzKSAr
IEFSUkFZX1NJWkUobXBmc19jY2NfcGxsMG91dF9jbGtzKQ0KPj4gKwkJKyBBUlJBWV9TSVpFKG1w
ZnNfY2NjX3BsbDFvdXRfY2xrcyk7DQo+IA0KPiBVc3VhbGx5LCBhcyBmYXIgYXMgSSBjYW4gdGVs
bCwgdGhlcmUgYXJlIG5vIChvciBub3QgdG9vIG11Y2gpIGxpbmVzDQo+IHN0YXJ0aW5nIHdpdGgg
YXJpdGhtZXRpYyBzaWducywgYnV0IHRoZXNlIGdvZXMgYXQgdGhlIGVuZCBvZiB0aGUgcHJldmlv
dXMNCj4gbGluZXMuIFRoaXMgYWxsb3dzIHlvdSB0byBhbHNvIGFsaWduIHRoZSBBUlJBWV9TSVpF
KCkgbWFjcm9zIHRvIGVhY2ggb3RoZXJzLg0KPiANCj4gT3RoZXIgdGhhbiB0aGF0Og0KPiANCj4g
UmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Pg0KPiANCg0KSSB0aGluayBJIGp1c3Qgc3RhcnRlZCB0aGUgbGluZSB3aXRoIHRoZSBvcGVyYXRv
ciBhcyBJIGZpbmQgaXQNCmVhc2llciB0byByZWFkIHRoYXQgd2F5IGFyb3VuZCwgYnV0IG5vdCBh
IGJpZyBkZWFsLg0KDQpUaGFua3MsDQpDb25vci4NCg0KDQo=
