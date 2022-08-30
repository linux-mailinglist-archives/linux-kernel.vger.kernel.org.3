Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC55A5AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiH3EvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3EvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:51:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48269C8E7;
        Mon, 29 Aug 2022 21:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661835061; x=1693371061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8Uv6rQXSNk/5Q4uCnwHKhuXzs5ZIR/u3qVTOSODfoC4=;
  b=kGg2qupRhN3ruz+ohXQXRjkCYSMHDUfEflznGbye9reTIwCTR6SJ5FtM
   dNXh8xZu0++Im+FsjVhhTjI0xxvq7d3wI68Oz47uOnJOhMWhh7WMbDqvi
   kEAYD7OqQ3lpaVxPj2a37MGuAe9xU5yT1v3SwPJqzdxxclBmlCU2B5nm+
   j1ueBiXi/HJd3oWFF/YmGH1uVGgiB4QAGPm81Cd42JL5tfpnAh3k5h8oB
   cTcLuTmAEbXMy3WmBftvkQqaiU23inUhIAVbwaUGEhlGfKl5YRRWZXbq+
   ZBObG77YG1gs/gFRvVaOeNWCF0jRI4celNVlg9jFNS7fAE9tWsNOccQcH
   A==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="171523463"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2022 21:50:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 29 Aug 2022 21:50:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 29 Aug 2022 21:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTJ7t5LVkFiLJ4ZyrT//6lSaM+WU7jTPcvI1Zb1gyR9cyvlk4Ps4YVTXZrg4Ng85lSLnrMxSRi47pj4huCFcmdKwy2gMlc77pJ/3goZsA038Wr22/HoGbHBCWLYTU8kmntJf2pEh+DB4qjj3JErHlGObBcl9Mw4WSO6oiNGnN2TfmiJHDwfEl2tGnuCX/crJMnZjojpVCKd6MALX+fU9H0hp4nBX17PmLvrzh75BlyrWy1xhWtYrPkvRFKt9kEYb4l3yATzVBQfLXzn/GTxExK5y1EYle6+vzQshe/KBOB3mQnUXdnmpTai9Mtm+ve0k0mGMY8gB+9lBq2ciimO+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Uv6rQXSNk/5Q4uCnwHKhuXzs5ZIR/u3qVTOSODfoC4=;
 b=lcKt66Ud+HmhATuGCy0PCqouCK4jzQuGO/19KbUUfwBmfJvfzbKO+k0FIp3xRxBa9O5L5/7uXUl7njSVORj4gCukrpMLk1ZCe/Pf+QuvY768hn2mAB8bvDtEhaezFtlpJv51RYCZj8Sv00Tw8E1GxzOzZ2P3330FymVNOwMyt6tGZtyHHTipo5zek21tcYQ4g+BGsRLIHMyDU9lbV9mjuU4Dld8+bukVpquk5qifjKzAh9Vt7NTwzOi2Bx0jvgZezBh7yoPSj6ZCr/FoNG9j1U7Tx8s1PPFa+m6iYT7+fmzpRlFJqw9jn7OC87JDLVXJDEmkLoBrBumKGW9PyOxjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Uv6rQXSNk/5Q4uCnwHKhuXzs5ZIR/u3qVTOSODfoC4=;
 b=p/kqMI2bpADVrsZz/845ua7CAS49ZUkjL0BisMFFRnvxogejPAB0gywnkblSVNyG4h8UHwpS0kLvtprTw+Rb2uUMRfAQRBFuOywkJ+xZMBAZxQP2y+sK97FlOLtnGaaQ2vQPj7shUt8DO9PujtFygvh8K/mOuTsmHca2soZqNiE=
Received: from PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 by PH7PR11MB6032.namprd11.prod.outlook.com (2603:10b6:510:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 04:50:40 +0000
Received: from PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::d9b3:8e55:269c:b122]) by PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::d9b3:8e55:269c:b122%6]) with mapi id 15.20.5566.014; Tue, 30 Aug 2022
 04:50:40 +0000
From:   <Lewis.Hanly@microchip.com>
To:     <linus.walleij@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <Conor.Dooley@microchip.com>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <maz@kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v6 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v6 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYsJ/Hf9/ChBUZqEipNmgMsTD4GK2601kAgAwjgYA=
Date:   Tue, 30 Aug 2022 04:50:40 +0000
Message-ID: <31d2bd0514652685cb87a7c9d17529b9064de2bf.camel@microchip.com>
References: <20220815120834.1562544-1-lewis.hanly@microchip.com>
         <20220815120834.1562544-2-lewis.hanly@microchip.com>
         <CACRpkdbk_ZqYnDzXgmbnAxhs+mEe9f2X-y++9HDS-O=UO_tUmg@mail.gmail.com>
In-Reply-To: <CACRpkdbk_ZqYnDzXgmbnAxhs+mEe9f2X-y++9HDS-O=UO_tUmg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5e942f0-44b4-4735-bc96-08da8a433061
x-ms-traffictypediagnostic: PH7PR11MB6032:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: osvNzLCde166D8SFOZr4sxrELZYOVuryygKRBOum1dBhYpOH7Adlv2tWAbzsHNAbjU547M9tP/vekJlFi55eHXMV4X3XV7ndAuexXKVw7V0Sx/CdXkEHI1NIniYJRTXtP4ddGlB+ju8D0ea2pexn7TPtX/lIrvadoml51gIgyZ6Z2la8LUld/os+24DRehCQd32js/ecgtvvUOrCKN45mHfRuEa6avDuSCISoTqktZzSQJlr4R/vFCoXF8ehTUsCtefr7s9uGWqNIdzNTXQbXDAwg4z30cgttc6POFwd6VTh4+kfziF+c1l5hbqaEuJBlee44RVPOEwPwHkuy/UinVFpV3WBFaOsyC+gFN8AovhD14W2lQfo/ur27NkCt+qh6gCFR2jNRlhECwAwRnJeiuq0Zi8paX4mbYiBrOlfD09rFeJGp4I6gI7nGS/WgRerx487xh7gc1cNzxlCWGS+pPuGTLFe4++Oduna7/PsjXKlRigSoYz8iy5XxROLINLJN0jNn606zY75rlzFlXRyCyECNDhzvdpbtYr/+2m0yoArauJhdzjfRn15kMpeM3bNaWNcAj3V/24CGVWfKwKxT4sVXRXKBO3ceMLRJtNYBdoSGyYlPME2Ljfz9/Bvcd7DkJ07Stvwzso2MpJ/gzJSofvsAOHyqYB8pdPnJ0cSCIR4F/SXEoSybF9ODg9KR78PywwDjJn3xehZ9tpdgjgc6gH4qq8uDDAoarl1ROtqB2pKmR0TsHIloei0wCmU0v0KnKy+W4i/nIJmxovxPegBEQY9MExEKQHUcOf1uW2Bt5A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(136003)(366004)(26005)(86362001)(53546011)(71200400001)(966005)(478600001)(107886003)(6486002)(6506007)(41300700001)(186003)(6512007)(83380400001)(38100700002)(122000001)(38070700005)(2616005)(91956017)(64756008)(6916009)(66476007)(66556008)(4326008)(8936002)(5660300002)(8676002)(66446008)(66946007)(316002)(2906002)(54906003)(76116006)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWp6SlpOYWN0TXdVT05saTJ5WVVoQkJyaHhBTXRSTEV1T2Era2pjeWtSbThN?=
 =?utf-8?B?Y0VrUWF4NktnNjYwUHZicEM3eC9yQXIrMnRKaXhGYXBuWXZjZW96TDFkaXFI?=
 =?utf-8?B?SC9hK0pmVlZaeWliRUdBaW1wbDlNMGEvU0ovWWgzYlc2MnFVNWh3cFF4eFNC?=
 =?utf-8?B?LzYxeGxrRFh4UlZ3ZzkxNjZsTHMvQzBJNGswTDZYVmlkVkRkbzVRWEJFZk9I?=
 =?utf-8?B?bk5WY1pQZkVuYVRXN3NqY2NUcFk1cmdWSDhCZE5QOExuczRvREIxUjIzU29Y?=
 =?utf-8?B?OTNiVnk5OVpRNlJRY29ieW9NdVIxZ1Fod2hZWHIvVVpTbVAzVGNvTFVWMlpI?=
 =?utf-8?B?MXFNVEpNcFJPQk1nU3U3QkpycEw2b2llQWxKTWpHK1dhOW9tMUlnVGNuNUNa?=
 =?utf-8?B?a0xycklVK0djbXRiL3E3S3BicVFBemI3eFBEamRmcVVzdDUveXE3TjB4Z01y?=
 =?utf-8?B?b3dIWndNUUQwK3RNQ0VkOUFkZUQzdStmaC9BeitYb3hMdWJWbXhXYTdCUDZt?=
 =?utf-8?B?cndLSk90NGVkS0pDOXlWY3R3SXNRQnlKS3EzdTBMVjVXaCtFOGZtUGFtcVJo?=
 =?utf-8?B?T3BBdmxiYWFCNEpwWnlqVkhOR2NROVlVb2xLOEllMXlJdEVURDdnRSt4NlI1?=
 =?utf-8?B?Y2FIeUtKdmFTUThoQlFMOFJsbGVtVEtiWnZhZXdLTEVUWTZaY0RJQWJyM0NP?=
 =?utf-8?B?aktyamdaMGoxcVNZVkxFbHlvVVZxa3JRRm43NnlhZyttWjgxTGpaalJtYmh5?=
 =?utf-8?B?WS9aZCsxOVJqZ3JTYWV3b0RjblQ3K01BbWh3bnorYWRieEVnRW9BeEpOT29H?=
 =?utf-8?B?VDFPTWNlaXZuS3dDeTZSRVZIYmVDVkVHemlEVkgzUVBMR0hJK2lrUFhPMm91?=
 =?utf-8?B?dVdySi81ZTNYZ21ZcG42czZEL1RiZWFmWFYwOWxQeFYrNW02ODB2ZTRTUmhY?=
 =?utf-8?B?alg1NkszeVlia21IS0lRR1F3Rm05WTN3bGNaNXVFVmFMSE9XUWdpd29vRHdj?=
 =?utf-8?B?VTFUem5IblpDeUtTV0ljcG15ckwrYnZYeW16Y1diTThuMHRSaTl1QzdKNkcz?=
 =?utf-8?B?cjRGemdhaGhTZjZuUkpRaWFwdTh4SWg5aEtHaEtXd0VFa3UwSzFsd1JaM1Uv?=
 =?utf-8?B?ajJCTnNmM1ZXTXRpcS9uU1MxUG1ydC9DQTJubGRHMUErYVBUejY0ZVZkVkl0?=
 =?utf-8?B?eXFJWUFweURsWmtTK0NLRmxGM3dKVEQ3d1MySFBKcHg3T1BtYTBuRXRQNkNF?=
 =?utf-8?B?aVV1ZjVZQks0UjB6NlJLL2JkZjdpb0NNQnpabnlrZjFicVVYUU1mY0dMRFhG?=
 =?utf-8?B?d0FNS2I4ZXRpYnFZSnM1aDJNRHEza205QmFBUXh1VGRGaUpVNmdSWi9HdmFD?=
 =?utf-8?B?cmFlbFJwVXVvWk01Ui9ZSDdSRmlPQjZKcm81SWJIeGZCSnBZSEhjaGtxdEV6?=
 =?utf-8?B?enlBZ2k0cWpPZk9JeGE1aWNNVG1zeFhNeXVGMkNFSWpPcmM5eUlUL3kxYXRk?=
 =?utf-8?B?WVJHUEFyWjlQY2c4N2Z0Vkl1UzNDU1BWd1A2a3J1b1dCSEpsZFkyMU0wdlFG?=
 =?utf-8?B?T09LTlcxZFNISHBDL2l6Y3c2cTY1TnQwOWpBdEs2RTJaTEpnK2xlbS91UXY4?=
 =?utf-8?B?REg0allsTzczVHEwdGd0dVowTVg3SlZ1Rzc3elVQMVlNWUF2aGVaTjJjNW9M?=
 =?utf-8?B?UWhHQjRnRVJWSXNiTFV6UU1iemo3N0cxSzI4dlFmV2pMTTBvREVMK2ZsUHlp?=
 =?utf-8?B?WHRCcTIraENFMlJNREJoQTE3N2QvSVc2OFoybFl5WWgySEdldnZlTUw3b0VW?=
 =?utf-8?B?T3ZrK1ZrTmxsdUtPbTlTSWpZaDBuT0wzK2lJUDZZT0JMNFB0cjE5eTJ5UEYy?=
 =?utf-8?B?ZXhsdjBFbzhIWktFL3pERkdwK3ZJNUw4M0kxSUpCaWlrbUNsQlR1bHJRL01N?=
 =?utf-8?B?cUhUbGh3Sjl0eXF1eGRva1EwTyt2RndSWXRQYU1sL04zaGtEK2NUdDBwTWVm?=
 =?utf-8?B?akZWQmNwRHJaWStHTlBUNFNWMzNkQURGZkVEUk1iOWJ0TnRPMkMvWlNwTlMw?=
 =?utf-8?B?bVBMRmdBc0dWMGdjUXh1T2N1ZmxteExKL0xWRG5rOFk1YmRxT0NVR0NENkl0?=
 =?utf-8?B?NDkzZndSUHppTk9Uc2taRS9DUFM2VWVWTGlpcmZJQTdqQSs4bHY2UXlFMGJa?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46E8D3E1F4383A47B7E8346469D1D0E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e942f0-44b4-4735-bc96-08da8a433061
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 04:50:40.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UK13jj+yFNzi1Aev/Lzw5qtRLpOvWwG27AIRaNyyiMbl98cGbTOydaluZEKnjy001ItbIN0fqMo0YmRmBSiVnmy8cf7wWQrtdDdE6GecTxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6032
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTIyIGF0IDEzOjI4ICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgQXVn
IDE1LCAyMDIyIGF0IDI6MDggUE0gPGxld2lzLmhhbmx5QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0K
PiANCj4gPiBGcm9tOiBMZXdpcyBIYW5seSA8bGV3aXMuaGFubHlAbWljcm9jaGlwLmNvbT4NCj4g
PiANCj4gPiBBZGQgYSBkcml2ZXIgdG8gc3VwcG9ydCB0aGUgUG9sYXJmaXJlIFNvQyBncGlvIGNv
bnRyb2xsZXINCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZXdpcyBIYW5seSA8bGV3aXMuaGFu
bHlAbWljcm9jaGlwLmNvbT4NCj4gDQo+IFRoaXMgbG9va3MgbGlrZSAgdGV4dGJvb2sgZXhhbXBs
ZSBvZiBhIGRyaXZlciB0aGF0IGNhbiB1c2UNCj4gQ09ORklHX0dQSU9fR0VORVJJQw0KPiANCj4g
PiArY29uZmlnIEdQSU9fUE9MQVJGSVJFX1NPQw0KPiA+ICsgICAgICAgYm9vbCAiTWljcm9jaGlw
IEZQR0EgR1BJTyBzdXBwb3J0Ig0KPiA+ICsgICAgICAgZGVwZW5kcyBvbiBPRl9HUElPDQo+ID4g
KyAgICAgICBzZWxlY3QgR1BJT0xJQl9JUlFDSElQDQo+IA0KPiBzZWxlY3QgR1BJT19HRU5FUklD
DQo+IA0KPiBTZWUgZS5nLiBkcml2ZXJzL2dwaW8vZ3Bpby1mdGdwaW8wMTAuYyBmb3IgYW4gZXhh
bXBsZQ0KPiBvZiBob3cgdG8gdXNlIGJncGlvX2luaXQoKSB0byBzZXQgdXAgdGhlIGhlbHBlciBs
aWJyYXJ5IHRvIGhhbmRsZQ0KPiB0aGUgR1BJTyBzaWRlIG9mIHRoaW5ncyBhbmQgY29tYmluZSBp
dCB3aXRoIGFuIGlycWNoaXAuDQo+IFlvdSBnZXQgZ2V0L3NldF9tdWx0aXBsZSgpIGZvciBmcmVl
IHdpdGggdGhpcyBhcHByb2FjaC4NCj4gQWxzbyBzZWUgZG9jdW1lbnRhdGlvbiBmb3IgYmdwaW9f
aW5pdCgpIGluDQo+IGRyaXZlcnMvZ3Bpby9ncGlvLW1taW8uYy4NCj4gDQo+IFlvdXJzLA0KPiBM
aW51cyBXYWxsZWlqDQoNClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLg0KV2UgaGFkIGxvb2tl
ZCBhdCB0aGUgYnBncGlvX2luaXQsIG91ciBjb250cm9sbGVyIGlzIG5vdCBmdWxseSBtZW1vcnkN
Cm1hcHBlZCB0byBzdXBwb3J0IHRoZSBiZ3Bpb19pbml0KCkgYW5kIGdldCBhbGwgcm91dGluZXMg
Zm9yIGZyZWUuDQpXaGlsZSB3ZSBoYXZlIGluL291dCBhbmQgaW50ciAoaW50ZXJydXB0IHN0YXRl
KSAzMi1iaXQgcmVnaXN0ZXJzLCB3ZQ0Kd291bGQgbm90IGdldCBhcyBtdWNoIGZyZWUgYXMgb3Ro
ZXIgZ2VuZXJpYyBtZW1vcnkgbWFwcGVkIGNvbnRyb2xsZXJzLg0KDQoNCg0KRm9yIGRldGFpbHMg
b24gdGhlIGdwaW8gY29udHJvbGxlcjoNCmh0dHBzOi8vb25saW5lZG9jcy5taWNyb2NoaXAuY29t
L3ByL0dVSUQtMEUzMjA1NzctMjhFNi00MzY1LTlCQjgtOUUxNDE2QTBBNkU0LWVuLVVTLTMvaW5k
ZXguaHRtbD9HVUlELUEwMjE0RjNDLUM2OEEtNDVBOS1CODFDLTQ2OTVBNThDNEE0NiNHVUlELUEw
MjE0RjNDLUM2OEEtNDVBOS1CODFDLTQ2OTVBNThDNEE0Nl9fSUQtMDAwMDBBQjANCg0K
