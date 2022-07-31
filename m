Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017C7585E3F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 10:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiGaI5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 04:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaI5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 04:57:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B0BCE03;
        Sun, 31 Jul 2022 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659257824; x=1690793824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AKZQDOQ4XRPUmfXPB1Mn44Y0wfjhStjWtn5owJR6G3o=;
  b=qIeJ5RgJP5FZbpEzmG+VrG2FGlUZohRpZpEyTWWriR9R7XyPrkvZUDwD
   5SpZpI1tmgnGMLvDJMdkBfptodWB/uUtZq5K71HMGwAF+uCNi8JkdWrXW
   ygtoXGqbeaJtTQI9g6jlSdbXM3xL3h527/5A7eAdw37bQ2sMYtgdKZtyL
   pJ74LfeuCTmuIY2lCIAsRH8M61dfFiqF+cN23eab3IYsTtCQ7q1KVxbCn
   KuBgNpY76txyWEUPSSLPxqpY3BIKO5Cz9BJ3gpFlGp7EXu2WzJLP0n/U4
   0l7kVAgDB/mW19AcWvkw4HLYNxY/H3CHgr6pbuEbK6L6/hJujT3g5rAIq
   A==;
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="106886443"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2022 01:57:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 01:57:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 31 Jul 2022 01:57:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R40G+3I+qejywf/EG5jbd8PDpCsVikUXSqBq1Xh+RvOb+Bo3WZd25wQKvF0UMcpAWmH+pb+JFui6BjdM40gSFTQA20KGuS9AMTGJclH79dHjVf2DGBZKxnn3U5U0WaAEz+0KRyHNl0HxmBUM2KDf3xR8AEgoVYJFlsDiGaqU44CDKQxZGUSi4ugbXabqTkReMOcSd/yN3IOzCfK/Kmtx423ablNRKF4SVOWH2zdD00WsL1hnZ2W1/rsKpCoxu4dXgZC8Q3C1ZgQWBhdSIYqMLM2OM3ovIWOiOQPC8tPoViTwtH377rMdll7rZAp8iqn3u6mb87De9EayzSY0e3l6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKZQDOQ4XRPUmfXPB1Mn44Y0wfjhStjWtn5owJR6G3o=;
 b=X4GwxWcDkVOuqsKpBdAvofrpu0bgn+G+ctpZRPV6frPQsDxoYe3Zic2xPabnP2Y/I37/bzgxg6q6lennEd8iSPTuDKZ4yExFoRoa94O5fvitgMwPQeaFVdO1aQRAPu+nuYilmNm2FuBT+X1/4z63fFml1xfyR1XgWpgeJXNre3m6TcC+vNikv4sh8FkcFkxVmjzI67E4sDGmBmOYfza0t/NRKckRK9vxVugWvri+ngiisKA+SIdxWOHqXaxFTWuLmz2DCNa9O3rTI2O5FRBNxKXdC6HFaUgwzF2wZ8cndALlI20Z3JHlsAxwJhtDE3RNRzaeMImWweMaf29+cP7kkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKZQDOQ4XRPUmfXPB1Mn44Y0wfjhStjWtn5owJR6G3o=;
 b=O7foZbfLiR+/8px+mtrPDhw5kJtl1lcVEYSS/b/yy3ab6TH7KhMNNdljE+VXIXcrG7yEzmKgnXA+z5zFkbJE8xGE3rQeLdgphKio9eN+ujReX9UylHT+L4hYIiiMeeTNGU1tew5qnJmDQnDemmlgtvC8j4ro88vP1cIgkJ30mzg=
Received: from PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 by BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Sun, 31 Jul
 2022 08:56:58 +0000
Received: from PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928]) by PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928%7]) with mapi id 15.20.5482.014; Sun, 31 Jul 2022
 08:56:57 +0000
From:   <Lewis.Hanly@microchip.com>
To:     <maz@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <Conor.Dooley@microchip.com>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <palmer@dabbelt.com>,
        <linux-kernel@vger.kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYmONEe8u9iky0lEWQnR2PO9enTa2AzRoAgBd4GYA=
Date:   Sun, 31 Jul 2022 08:56:57 +0000
Message-ID: <77fcd05bc976f9eb14a08974ea7c600b0292b145.camel@microchip.com>
References: <20220716071113.1646887-1-lewis.hanly@microchip.com>
         <20220716071113.1646887-2-lewis.hanly@microchip.com>
         <87r12l4aaj.wl-maz@kernel.org>
In-Reply-To: <87r12l4aaj.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7f792ac-483c-44e2-234b-08da72d29ff9
x-ms-traffictypediagnostic: BYAPR11MB2999:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wRebixFJeqQHBTKqdDWVtN2u1Cq1lvMURIVmr4kaTPApsFu9TPqc88ViSCbNOggqQKkrrPhhAZHdXFQijd4EZQKG/kXN5hxp366J9kNkDRNw6kk2x3EavmtUnV7ShtuEErXDCHAucjQ7KWWpPryEEUU2LqX8q762p9U8ulyjDDrbreCWT0Re8/5elJoIZatzufNopIt7fPrjRZQ4q7I4pVMVdVLyL3WlbpHauhmJJtRe3ytwZVCeSbtuWH4UlBxKw9MXIEuJVSOD58u/p6TEIIQZ/MOhx2G3iFfLJDHm04D/agdKoyWdI5i/d3b8fE5weOCt0t6su884lvDAvxNp1pIxdVEHbjwxdrIFJNUUGoMKG7s3iYbXvmm4gGdQKNXVcFytBFbdA6bGibueaZbSpDxjQBWeQYMN3U1Y27iuurCK/b4ZkoxchLQkdZwkEXtBprrtrJ6Ae8Z5uUBmOHzGrHp9xDeP9wVjtJa6pK2QiniNGo6IkyZE0wY0fvKvgjjS2UOq5tFa3WdD07xHX5u73Y2SqH8SuJqotidCEXhjfsUTeCp0Xv532pl63h2gSo55dvba5uhApsHXX8wEi2E417L6FiLCPLbf1CWK2LuwSQMKLhaa89A/Rogk2taNjs+vCGpzKST9raHoVNxtoEsM6yDNq/FIEWixSywzrQ665meU32t7pCwg10l0bU8xLWcEnVkrtXvwKsNT2b6jSqxfUKrbT+txV7c7fGPd8mbOh0YK+qgmRO2fNcGJ461y4kXVsZCA+Khdy5hDc7Ypnymw9mIO0Ik2/d2jCmBCLnuak70=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(39850400004)(396003)(136003)(76116006)(91956017)(2616005)(66946007)(5660300002)(41300700001)(2906002)(107886003)(8936002)(478600001)(6506007)(26005)(6512007)(66446008)(66556008)(8676002)(71200400001)(4326008)(64756008)(66476007)(86362001)(6486002)(6916009)(54906003)(122000001)(38100700002)(83380400001)(186003)(38070700005)(316002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXhablZwaWovekxHbGhLaEhQQ2lxbEF6cjUzN1M3Sm8walVpV01jcGRhdmwy?=
 =?utf-8?B?QnA3RklXdElaek02c0w1N242RVAybzBkY21nczB0eUJHQnp0QUtGV2kwT2pa?=
 =?utf-8?B?TENac3RHYnZEU1JsZkxKZmRPOUQrWjNzRzZoMVgwOUNVRlNEN0dkRWxvUDNC?=
 =?utf-8?B?TjQrcWk4RVZ1R21YRDdhdGx1RG16bTk3RzJDbUgrWTdobXJ1bkpHN2d5bHAz?=
 =?utf-8?B?R0pZY2VrM01xbDFBVCtwaFVxRVUvS2xZYnMrWnVwQlRhbFFRNG1Ca2dtc2dO?=
 =?utf-8?B?aUNzdWZ6R3lUMjcvcnRqZnROcGp3RFNaWjJaQ2phWXpMcjZJU1NSTGZ2a3NE?=
 =?utf-8?B?cFRUMnY1K1hvT1Nzb2pPMkF1Y1RnS0dyLzBZQktkbmFEbVRuenhMV3Q0SjVU?=
 =?utf-8?B?bDJ3OXFUVEJPenRZbEI5aWIvM21EdUVRdjY1K0V6TG45cktQNTFUN3JVWUpT?=
 =?utf-8?B?L2JOcTFYZzFuVldHZU5raHpLTHk5YW5oWkV6Nlk5REZkS3RvOER5bWFmMDJs?=
 =?utf-8?B?SGw0Q1hWV3ZDNUVqY3haQkJWd3F5dENhcnNRL2Rpa0J5K3A0M1cwTlBLNU9U?=
 =?utf-8?B?dFpRcHA1cTBtVGZoVmoxdzdZaDVKQ1NtbjIvaXdGVFlUWFBvNUJ5Yml0RXRs?=
 =?utf-8?B?bWs5YVRMMzRRMTV5bWtKR0wrU1BTRTJZWFRrUEREVFZmMGw2Qy9hVGd2dXJW?=
 =?utf-8?B?d3J5Zml3bTRsM0hvb0VaTG13YlFSYVVqeGtoeW1IcGJVVmwrd1ppMVVxZnFv?=
 =?utf-8?B?b1dERXBPaDJhNXhQSUk3VVN1bkwwYzlnOHAxR0l2VHBzRVJDNnJtU0hEQUVv?=
 =?utf-8?B?ZTNoUG8zeXp4enkvUDJBTE4wajFENHg3LzcxaE9Vd0w2Y0cveHVwNGRNUWRr?=
 =?utf-8?B?eHpNalpVNG5yYmp1Y3Qwb3g0dFRuK0hHZXJnTERDZFR6QVlvVGFjL2xnZDhY?=
 =?utf-8?B?bzFhWVRkK0ptdS9DaXBNa3ROVklnRWlSdXFyU0RXdVV4QjE2Y1N1NDRpOGo3?=
 =?utf-8?B?S2pST2pYTGVsWTJxRzVZNWttY1gxMjFJNjRHVGRyN2lnQ0pQQUJJcWM0ajlW?=
 =?utf-8?B?ZCtWWVNrQmZvVGlQbUU2eHE0NjR1bnNOY1M5ZzNwZ2o0SnlaNVBvOHZQY1VW?=
 =?utf-8?B?RFRxajNReGNEMldGUGhoOGs3TjFaSjBwdDdmUjdEWEMwclBCMVRZR200NEpy?=
 =?utf-8?B?NmJWZy9MVU5laFhZM2EyV3ZxQUNZSGw5c1RxdEI2TmczQkJ3Tm4xU2FHbXhT?=
 =?utf-8?B?NkZkQ2tyR3NnbDVyUTFRL25jNEwvM1RxNVFkYStqdmtKaGZ2Q3JvQU4vL1hG?=
 =?utf-8?B?dU8rN2xSdk1TSVN6QXlMY0RzM1F1ZVRadmUyWjV0dGpma3dwaytKWW45dEg1?=
 =?utf-8?B?N2ZHRVZud0RxMnhvWllTU1U1ZVQvaFl5aWFManFGUGVSSy9xY1h1c1IyOEFy?=
 =?utf-8?B?c0N3cFBlSk9iT2Ztb2x0eVhkR3RDMDRoa1dJbUllcDM2RTNpVjVNL3VUQnBU?=
 =?utf-8?B?UVhzZ3hOOEVlZU9SeGlMcE9VTFdTWUhPdzZ0UE5rSzFLT3ZGWDc1VWZDRG9X?=
 =?utf-8?B?cEgrNEZhalBYT0J4UFlDSTY4aVRycFkyL2xOOVVCdGNMaWNlUFhMeUR4bUtC?=
 =?utf-8?B?emxoL3RiZUpBRFBha2s4Ykc4b3FKcHl2Szl4cS9QOGlFbmt6QStxM1p5d0ov?=
 =?utf-8?B?VTFYMlY2NHlZMEVpZ2dTRXlwV2pCd3dRTXdMUWQvSGZVMnByNU1TOS8zOFAw?=
 =?utf-8?B?bmRNNUJuVVNnWTJHaDhRTFJtZ2hHQ2Qwdlk2a1NJWEtsR0NZaFNpMDZNclNk?=
 =?utf-8?B?ZUtEMUI1eDM1MFpsWDZ0KytYRzJkZVN0NWF6UEtNU2RYdDJtRVVneGh4NVNP?=
 =?utf-8?B?VjByYUlucXZjMXR4a01vVTh2cm42cnRha3ZhWC9FbkdPVUtIMnRFTGxuWGpX?=
 =?utf-8?B?akQwVnpQYVFIN3lhWmRkWEh4Uk1BbCsxdXE0cnlWVXNSM041YkVJVXNMd1pG?=
 =?utf-8?B?aWhRRVBiQ2tIS0pOeitrU2p0Y0pkNGVUWnJuaVhMd3dTMFN3Z0hJcVBvY3lv?=
 =?utf-8?B?ZHF3TnU0N3phOXJydm9WOXBJcmxLMWY3USt2UFQxY1E2bGdiOU0ySjdGQ3pX?=
 =?utf-8?B?N05WWUtmVEU4NlpDSmx5Q09QczZ6ZE5vb3ZGdHhsZGVJM3dKWXR6K3JyMWdE?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20393F673F4B674DBBB5A72862C9A027@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f792ac-483c-44e2-234b-08da72d29ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2022 08:56:57.8626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zIIw41oFPcfG1llduWNUxZTT8JTuEpup2+iM2Cyj0Ze/3cWUYauzCOKrnMYP0fWdnHnoDtLlsDxLoxSRuXq5nn7vNN3g6FTHQiYK9z2TyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2999
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTA3LTE2IGF0IDExOjMzICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gU2F0LCAxNiBK
dWwgMjAyMiAwODoxMToxMyArMDEwMCwNCj4gPGxld2lzLmhhbmx5QG1pY3JvY2hpcC5jb20+IHdy
b3RlOg0KPiA+IEZyb206IExld2lzIEhhbmx5IDxsZXdpcy5oYW5seUBtaWNyb2NoaXAuY29tPg0K
PiA+IA0KPiA+IEFkZCBhIGRyaXZlciB0byBzdXBwb3J0IHRoZSBQb2xhcmZpcmUgU29DIGdwaW8g
Y29udHJvbGxlci4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZXdpcyBIYW5seSA8bGV3aXMu
aGFubHlAbWljcm9jaGlwLmNvbT4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+ICtzdGF0aWMgaW50IG1w
ZnNfZ3Bpb19jaGlsZF90b19wYXJlbnRfaHdpcnEoc3RydWN0IGdwaW9fY2hpcCAqZ2MsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgY2hp
bGQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25l
ZCBpbnQgY2hpbGRfdHlwZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCAqcGFyZW50LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50ICpwYXJlbnRfdHlwZSkNCj4gPiArew0KPiA+
ICsgICAgIHN0cnVjdCBtcGZzX2dwaW9fY2hpcCAqbXBmc19ncGlvID0gZ3Bpb2NoaXBfZ2V0X2Rh
dGEoZ2MpOw0KPiA+ICsgICAgIHN0cnVjdCBpcnFfZGF0YSAqZCA9IGlycV9nZXRfaXJxX2RhdGEo
bXBmc19ncGlvLQ0KPiA+ID5pcnFfbnVtYmVyW2NoaWxkXSk7DQo+IA0KPiBUaGlzIGxvb2tzIHRv
dGFsbHkgd3JvbmcuIEl0IG1lYW5zIHRoYXQgeW91IGhhdmUgYWxyZWFkeSBpbnN0YW50aWF0ZWQN
Cj4gcGFydCBvZiB0aGUgaGllcmFyY2h5LCBhbmQgaXQgaXMgbGlrZWx5IHRoYXQgeW91IHdpbGwg
Z2V0IG11bHRpcGxlDQo+IGhpZXJhcmNoeSBzaGFyaW5nIHNvbWUgbGV2ZWxzLCB3aGljaCBpc24n
dCBpbnRlbmRlZC4NClRoYW5rcyBNYXJjLCBhcyB5b3UgaGF2ZSBwb2ludGVkIG91dCB0aGUgaGll
cmFyY2hpY2FsIGludGVycnVwdCBmbG93IGlzDQpub3QgZml0dGluZyBvdXIgaHcuIEkgYW0gaW4g
dGhlIHByb2Nlc3Mgb2YgcmV3b3JraW5nIHRoZSBkcml2ZXIgdG8NCmltcGxlbWVudCBjaGFpbmVk
IGludGVycnVwdCBmbG93IGFzIHlvdSBwb2ludGVkIG91dCBiZWZvcmUuDQo+IA0KPiA+ICsgICAg
ICpwYXJlbnRfdHlwZSA9IElSUV9UWVBFX05PTkU7DQo+ID4gKyAgICAgKnBhcmVudCA9IGlycWRf
dG9faHdpcnEoZCk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW50IG1wZnNfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IGNsayAqY2xrOw0KPiA+ICsgICAgIHN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAgc3RydWN0IGRldmljZV9ub2Rl
ICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gKyAgICAgc3RydWN0IGRldmljZV9ub2Rl
ICppcnFfcGFyZW50Ow0KPiA+ICsgICAgIHN0cnVjdCBncGlvX2lycV9jaGlwICpnaXJxOw0KPiA+
ICsgICAgIHN0cnVjdCBpcnFfZG9tYWluICpwYXJlbnQ7DQo+ID4gKyAgICAgc3RydWN0IG1wZnNf
Z3Bpb19jaGlwICptcGZzX2dwaW87DQo+ID4gKyAgICAgaW50IGksIHJldCwgbmdwaW87DQo+ID4g
Kw0KPiA+ICsgICAgIG1wZnNfZ3BpbyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqbXBmc19n
cGlvKSwNCj4gPiBHRlBfS0VSTkVMKTsNCj4gPiArICAgICBpZiAoIW1wZnNfZ3BpbykNCj4gPiAr
ICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAgICBtcGZzX2dwaW8t
PmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ID4gKyAg
ICAgaWYgKElTX0VSUihtcGZzX2dwaW8tPmJhc2UpKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJu
IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKG1wZnNfZ3Bpby0+Y2xrKSwNCj4gPiAiaW5wdXQg
Y2xvY2sgbm90IGZvdW5kLlxuIik7DQo+ID4gKw0KPiA+ICsgICAgIGNsayA9IGRldm1fY2xrX2dl
dChkZXYsIE5VTEwpOw0KPiA+ICsgICAgIGlmIChJU19FUlIoY2xrKSkNCj4gPiArICAgICAgICAg
ICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihjbGspLCAiZGV2bV9jbGtfZ2V0
DQo+ID4gZmFpbGVkXG4iKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5h
YmxlKGNsayk7DQo+ID4gKyAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBk
ZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIGVuYWJsZQ0KPiA+IGNsb2NrXG4iKTsN
Cj4gPiArDQo+ID4gKyAgICAgbXBmc19ncGlvLT5jbGsgPSBjbGs7DQo+ID4gKw0KPiA+ICsgICAg
IG5ncGlvID0gb2ZfaXJxX2NvdW50KG5vZGUpOw0KPiA+ICsgICAgIGlmIChuZ3BpbyA+IE5VTV9H
UElPKSB7DQo+ID4gKyAgICAgICAgICAgICByZXQgPSAtRU5YSU87DQo+ID4gKyAgICAgICAgICAg
ICBnb3RvIGNsZWFudXBfY2xvY2s7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICBpcnFf
cGFyZW50ID0gb2ZfaXJxX2ZpbmRfcGFyZW50KG5vZGUpOw0KPiA+ICsgICAgIGlmICghaXJxX3Bh
cmVudCkgew0KPiA+ICsgICAgICAgICAgICAgcmV0ID0gLUVOT0RFVjsNCj4gPiArICAgICAgICAg
ICAgIGdvdG8gY2xlYW51cF9jbG9jazsNCj4gPiArICAgICB9DQo+ID4gKyAgICAgcGFyZW50ID0g
aXJxX2ZpbmRfaG9zdChpcnFfcGFyZW50KTsNCj4gPiArICAgICBpZiAoIXBhcmVudCkgew0KPiA+
ICsgICAgICAgICAgICAgcmV0ID0gLUVOT0RFVjsNCj4gPiArICAgICAgICAgICAgIGdvdG8gY2xl
YW51cF9jbG9jazsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIC8qIEdldCB0aGUgaW50
ZXJydXB0IG51bWJlcnMuICovDQo+ID4gKyAgICAgLyogQ2xlYXIvRGlzYWJsZSBBbGwgaW50ZXJy
dXB0cyBiZWZvcmUgZW5hYmxpbmcgcGFyZW50DQo+ID4gaW50ZXJydXB0cy4gKi8NCj4gPiArICAg
ICBmb3IgKGkgPSAwOyBpIDwgbmdwaW87IGkrKykgew0KPiA+ICsgICAgICAgICAgICAgbXBmc19n
cGlvLT5pcnFfbnVtYmVyW2ldID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBpKTsNCj4gDQo+IEJp
bmdvLiBZb3UgYXJlIGFsbG9jYXRpbmcgdGhlIGludGVycnVwdCBmb3IgdGhlIGxldmVsIGJlbG93
LiBZb3UNCj4gcmVhbGx5IHNob3VsZG4ndCBkbyB0aGF0Lg0KPiANCj4gSWYgeW91IG5lZWQgdG8g
cmV0cmlldmUgdGhlICpod2lycSogZm9yIHRoZSBsZXZlbCBiZWxvdywgeW91IG5lZWQgdG8NCj4g
cGFyc2UgdGhlIERUIHdpdGhvdXQgdHJpZ2dlcmluZyBhbiBJUlEgYWxsb2NhdGlvbiAob2ZfaXJx
X3BhcnNlX29uZSgpDQo+IGFuZCBjbykuDQo+IA0KPiAgICAgICAgIE0uDQo+IA0KPiAtLQ0KPiBX
aXRob3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUu
DQo=
