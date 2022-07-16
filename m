Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989BE576FD8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiGPPV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:21:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6961CB29;
        Sat, 16 Jul 2022 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657984915; x=1689520915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wCaL2JbHF7/CxwR35tWrdwL5PQ8qkqOcTZbW31EUqVs=;
  b=cUcLwFFYpePJHNbyNh8eu+EIPqS9htkAjbt7OMMHo0ob/ig9My13tGSu
   bRb1JGkZpULL2MeZHcuHBFEiyQBWbEe2vXd9zPQpgffRE56152Xygl/q6
   DrZSaElNHPZUUCNhb3ChlBaC+gSj3v4UcDBCIZhSRC3zpp8x+NFirZrqU
   o8w6wFeoLPZmHcuxcfzVmmEjqkUY+dHpmg/7S4S2gSCkzbDolB8MlaE92
   DJhXxGn0fEyMWUIJPAzv6/qa1B/OteqPQw+m2mOncxPrNl6JPcSwB91ud
   VcQ4i7gXvLn7m8VCo71F8gvbIg7bYxX+gmIENdkqHQcgmQ4XeNAgN/QTo
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="168147391"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2022 08:21:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 16 Jul 2022 08:21:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sat, 16 Jul 2022 08:21:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogFVlDRPiqJ0C6xbGIqMPgdU1hFvbxk9YUPPUIZ0Wlk7cZniNl2Fzg+tPYpzauzCbwGJROGu+9Y3BzECpttholSY6k5ZrGDRivG6Pzqsql3wf4J+0jNA72M+DUqoaoTzUNNzNpHcirojjg/6pbQ2o2SIy6Bu10PUHxFKGsuo+m947DeEOII0u9Mfr1dPO22jXgYAIWXFBLRx+k9WWmIatGWRV237H2pzQVS+pK1P9VZpZTdMdMckg9lk6+oxpdGL10n6Q/bPdPB9NNEMofAb3MduvNsGh+VmsC4U4BcCSv0aLUNasYNhnuQ3P2DXlQHx9xeAGaSPXG9uhZ00xe+RDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCaL2JbHF7/CxwR35tWrdwL5PQ8qkqOcTZbW31EUqVs=;
 b=KqIX4sQqIsT1u2+Sg0yBNCmrQuEx1U0TdUnWLeIFrGjWBZV2PUBFXPrtu/GatuM6MQwYLOVaCZSxyRYzYlrY8T3xSMQlJBebQ0I7iskZltgi6F8srrS6kTOFozsFFQHjmEVPj+e5hj77SL9v2mS7bp/2pazmg1pqZbVN42qnswMeNpacl/qOIWYVv5upLrqnDJNtJN7ZWK7Jls7FH273BtSyVeSQRM/oiFPbKMwqNs8+cB7XpWDQnPhH/sM2a5+OjJH/Lik3qVj1Nw4bdxPqqOpiYedepIN9iplixpM0VxLN2Jk7KPuVT08vLYQbbJl2XIq9shWz99fcsMXsOXk/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCaL2JbHF7/CxwR35tWrdwL5PQ8qkqOcTZbW31EUqVs=;
 b=tU8oPhTpPNK8iMZIdSZFLgxIVMZ5WW3UAZ6JPQDc6oaY263Sg8y6+ZKoC5y+Xing/AjQFi+GK+5mH7lPwd3LRYwEmNrJlD4BCu5V4bOi3t5+uq7c/zlrxJZ4spZtYQlq9G0dP1k/tMCg9Exn3GPk/Wu5UgW92i5gww36fzY5Avc=
Received: from PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 by BY5PR11MB3960.namprd11.prod.outlook.com (2603:10b6:a03:185::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sat, 16 Jul
 2022 15:21:48 +0000
Received: from PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928]) by PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928%7]) with mapi id 15.20.5417.026; Sat, 16 Jul 2022
 15:21:48 +0000
From:   <Lewis.Hanly@microchip.com>
To:     <maz@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <Conor.Dooley@microchip.com>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <palmer@dabbelt.com>,
        <linux-kernel@vger.kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYmONEe8u9iky0lEWQnR2PO9enTa2AzRoAgABQpQA=
Date:   Sat, 16 Jul 2022 15:21:48 +0000
Message-ID: <2d7f72d3e89686d3ba5cff5df8cfe443d04fc5f4.camel@microchip.com>
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
x-ms-office365-filtering-correlation-id: a378170c-53b8-4c76-e284-08da673ee6f7
x-ms-traffictypediagnostic: BY5PR11MB3960:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1490JFRPUr6KSOHK7uxbwQVEUJaj88eRweOQXdpPrBi6BH8OELrNkQHJgsxNm8+TRdb5GoEr3aFMmuQrE0HFjnjWZNE3ZKLpNqoOgxUmwT87+wPJ889//3LlD8QvKw0K9fSEYJzo3xVhxlH8LPjLtGTtTNXpXlvdjThYo/zQR+DNyiFnOBYFod2pAlUFFz5nFy+Sj36MA+bq4i9NBYKwc26ei9pkRSyhaBFBSZ08VDdmFWTXpZEJn/mCC9SOTXarBjJEjwEWfurUinK03byhTtJHCNXtAABtVcj5q0wpPaQQoNGV7AlDqS4nY/a9BDtpQ2qYo+DlDDNKBi2kubBF+uN55FsbGaAZPb7WM7HpA28HxD/+DwwXViLnlCtZw4vHPKlkaa3vDz02lKhr1J90RP1Yw/AJs4AzSnK0LPl60KhQmP8y6pHF2lxuFeRN7hfAzk9i+HQtsf1kzulFuCb8IfYJ7rgANz0DOCtsfNJ1h1xpyTUWTS6zLCBrrRVf+SndaEgx02xRUEL0Bvx0WbB8oZ4dPtqZQVjw5sL7hL57ALAJTujQzxK+DB7pIrcsUMfzKesCdhc44FL+g5cKYoytwQ0BWs+lbDnnsH4lZMosCoZ6KIR+o67MnZwpbXMQa/HFUt7dXto1oakCfUkZPvl/bpr6iOSID9dXlSAQTyy0a5I5WPdSbAqt78kTqwuJbWHOvreAHXkWCgyApwpqoZUwzbyekhx+U1LtoE2PBACl2RqZKzVPD3iiI4lfblRUoII+K7VCGE0CwpZO3OxNCVeQca8D654ovR5QJp8isD7GB6KEVHbW2Tnf0SDmvCjUpbHR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(346002)(376002)(136003)(366004)(396003)(316002)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(38070700005)(38100700002)(54906003)(122000001)(6916009)(6512007)(26005)(5660300002)(8936002)(36756003)(2906002)(41300700001)(6506007)(4326008)(83380400001)(8676002)(71200400001)(6486002)(2616005)(478600001)(186003)(107886003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlhrWDZITzhYKzI2YUo4R3lLRUdVRkxGeWNEbUt6UkNraVczaHBWY1RIWVdX?=
 =?utf-8?B?Y3lBbnF4R0xDdVBaSWczK2twLzMyYXk1WGpZTGZ2aVRBU1BXMWYvMkpmOVZ0?=
 =?utf-8?B?WnhnNmNHRUw2V1FzUjBSWHFxNUtPampFK1gzTU4wSHk5Z2o3bEpMQWRTaUFn?=
 =?utf-8?B?RGZuTTZGS1VlRmVuN0JjSU50Nm5acDBCRDcxeVIzVVZySUh2b1M4NW00MFhW?=
 =?utf-8?B?WkNLL0JKUk5EU3A3REVEZm5wZU0zWUFtVjAwL2Q1Y09MMzJ4clF4T3QxbUNW?=
 =?utf-8?B?NU9DYXFSZVIzMGRTSHFib2E1Uk5yNnN6RXBYdDN0SkNuTFVrdy9ZNklDYk85?=
 =?utf-8?B?R1NPYjRtcG1pVnBuSmJtb3JGdnBlOVo0TXVtSkxoL0JScFY3eGQ3d2ZkaHhV?=
 =?utf-8?B?N0h4UFhNa2pJdUdJQmZueDFUNlovZElRVHlqcmdzWndhVXRsWFpPZE9TSmdN?=
 =?utf-8?B?cnJjMWFGRTI0cWMzcWZ3MklqeUJjRDlwTWdOb0FLOXBiSnJKOGg2dzloWFRR?=
 =?utf-8?B?WDRNNzFCSUJ4dDZjTGU2QkRJVENnRHFsc1VwZUV0bDFsb3gxVThRYkRHTFVD?=
 =?utf-8?B?ZEc1Uld1N1BwdnRxR2dIek95YTl2T1hITmZkT3QyS0VZblpPeVFGa0JjZUdZ?=
 =?utf-8?B?MlFDSUxKNmo0WVpWU1VVaXg0T3hBak9FVGo5MUZURGtET3pTUVZRbm85c1Bh?=
 =?utf-8?B?VS9ZeGZuTzk1T2VqOEpjclNqTVZER0hmUmZYa254UG5qb2p4VzZ1ZmxUMjN2?=
 =?utf-8?B?YStBaGtCMHF4WURhQXZEUk1lMlRBdkxvMmplUEhrSTAvcFF3OERaNFRQb0JI?=
 =?utf-8?B?VmNBdERzMTdKVUFmTlREVHZPRE1HeXJlTnFxY2ROeE5wZkpGRGdmLy8yZ1Rx?=
 =?utf-8?B?bTdoV2huTUt2Rms3WEdwV3F1SjIxUFFrUmY5RlFpeUNNdnRmOFA4alZmeFk4?=
 =?utf-8?B?ekwwSFhRSmdSd0xTWEdzSTJ4bzd1SmtHSFdnM3NSbTBYK2FEQzZyMWhjQUdo?=
 =?utf-8?B?MjhsazBmT0FYcGpZbFdqL1Ywd0dDLzN2bUh6RVVvU1hVZFY1MHlzQm11ZEdR?=
 =?utf-8?B?TFU2dkh2UlVxVDd6RkYySTREZjRrdnFQbVhVYmlYdkFNUXBuYmlVOHJZeVNW?=
 =?utf-8?B?d3g4cTNYbmY1OXQyNFBZcmFzSmhYWVQ3TncxdVBnRVpyTmFpaGtUSGNucUJ4?=
 =?utf-8?B?a3FPMzNzeVM2TGhXNHZhdkJIRHpNYmo4QXpURXBXT1lwNUx0d2JWbk5CM3hN?=
 =?utf-8?B?L2p5SDV0VDRFZzlzTVNKR05LeUN6Ym91NmZkY3lKcElrQ3cvdFlqR3M4SVV0?=
 =?utf-8?B?ek1uSVg1SjdDOWlPMzVyd1dHV1d4OURhRmo5NzU4SlVsWXJUK2tROHphVURh?=
 =?utf-8?B?aktCRm1jZ0RQZndjQU1tQytWS0VTaWE3YlkzQ1BCeHRoWFEwdGFOR1JxRGNx?=
 =?utf-8?B?c2UxSWcxaGFHUFZQV09DaTAvRVFRbktjU0VseVUzTDVFcUtSaysrYlNqTmFG?=
 =?utf-8?B?M0lOejl2UHJURGlJd3B1V0VrdHMzMHN1VklEMFJvbGw0MnNvRTUwdnUrYU41?=
 =?utf-8?B?VDNNL3ZNM1B3NnlWZ3JGMEJhSmpiZEdoV0pPdEt6bkNjdmVUWk53ZEI5aEFG?=
 =?utf-8?B?b09uU2poZ2t1R0w1VkRXdHROUmZmakNEMHcvNit0bURmMmNuUEJOUDRCdHNM?=
 =?utf-8?B?YVNNTEo2dDlQaTBidUFiRkhEbU52TzMrNGltVWxMMHBUUW9MeEYxRmVGQjNG?=
 =?utf-8?B?ZTk5d3YzOHZlVmVSMWRpUUR4dGRHTUMrNkZSb1ZWTDdVS3hsaS9MQ0dwZWU1?=
 =?utf-8?B?SWQyVy9NWkprL3JWaGZqbjUwdTBnajhwNXQvMjVWbFdnOFF5UVh0UjBWNTJH?=
 =?utf-8?B?VkxwbjNKV2R1ay9FMlMyL05JdzZvNXNQUFVzWmRxdEFWTU5lajV6SS9kTjdl?=
 =?utf-8?B?c0Znd3M5SHlRR0h4ZEd2UGEyekM1NGJyYjFkRktCeVB6Nmd6ckdRNEpHZHAy?=
 =?utf-8?B?cnFKcVMxdkxJYkc1UlNYSVJtYzRSc3g5dVVYTUhHa2Y2Vlg4OUZ3YUdmZnFi?=
 =?utf-8?B?cFluSUdUTUFlZXZ6NXovSWFUZ2ZzeEZkRndhRXpzNlBJQkw2YUU5ckFXbDA1?=
 =?utf-8?B?MW5UdUtFU2JsMVA5aWNSK0NBc2xzRjRQazh1ZkFFZ2hDUVd2QkYzVDVMdFUz?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0359106946BB044FAA32D4DFB17ECA1E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a378170c-53b8-4c76-e284-08da673ee6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 15:21:48.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4J7elq5YoKkfTU/QXMoy0GbZJPwEbuum0CGEpYyIWvmxmGZ2s4Am2112tv/EWqd7e2NmnHpy6HXWj24Yh22w2dDLzCafqthl5uEG1utIdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3960
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIE1hcmMsDQoNCk9uIFNhdCwgMjAyMi0wNy0xNiBhdCAxMTozMyArMDEwMCwgTWFyYyBa
eW5naWVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4g
DQo+IE9uIFNhdCwgMTYgSnVsIDIwMjIgMDg6MTE6MTMgKzAxMDAsDQo+IDxsZXdpcy5oYW5seUBt
aWNyb2NoaXAuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBMZXdpcyBIYW5seSA8bGV3aXMuaGFubHlA
bWljcm9jaGlwLmNvbT4NCj4gPiANCj4gPiBBZGQgYSBkcml2ZXIgdG8gc3VwcG9ydCB0aGUgUG9s
YXJmaXJlIFNvQyBncGlvIGNvbnRyb2xsZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTGV3
aXMgSGFubHkgPGxld2lzLmhhbmx5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBbLi4uXQ0KPiANCj4g
PiArc3RhdGljIGludCBtcGZzX2dwaW9fY2hpbGRfdG9fcGFyZW50X2h3aXJxKHN0cnVjdCBncGlv
X2NoaXAgKmdjLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dW5zaWduZWQgaW50IGNoaWxkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdW5zaWduZWQgaW50IGNoaWxkX3R5cGUsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgKnBhcmVudCwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAqcGFyZW50X3R5
cGUpDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1Y3QgbXBmc19ncGlvX2NoaXAgKm1wZnNfZ3BpbyA9
IGdwaW9jaGlwX2dldF9kYXRhKGdjKTsNCj4gPiArICAgICBzdHJ1Y3QgaXJxX2RhdGEgKmQgPSBp
cnFfZ2V0X2lycV9kYXRhKG1wZnNfZ3Bpby0NCj4gPiA+aXJxX251bWJlcltjaGlsZF0pOw0KPiAN
Cj4gVGhpcyBsb29rcyB0b3RhbGx5IHdyb25nLiBJdCBtZWFucyB0aGF0IHlvdSBoYXZlIGFscmVh
ZHkgaW5zdGFudGlhdGVkDQo+IHBhcnQgb2YgdGhlIGhpZXJhcmNoeSwgYW5kIGl0IGlzIGxpa2Vs
eSB0aGF0IHlvdSB3aWxsIGdldCBtdWx0aXBsZQ0KPiBoaWVyYXJjaHkgc2hhcmluZyBzb21lIGxl
dmVscywgd2hpY2ggaXNuJ3QgaW50ZW5kZWQuDQoNClNvbWUgYmFja2dyb3VuZCB3aHkgSSB1c2Ug
dGhlIGFib3ZlLg0KV2UgbmVlZCB0byBzdXBwb3J0IGJvdGggZGlyZWN0IGFuZCBub24tZGlyZWN0
IElSUSBjb25uZWN0aW9ucyB0byB0aGUNClBMSUMuIA0KSW4gZGlyZWN0IG1vZGUgdGhlIEdQSU8g
SVJRJ3MgYXJlIGNvbm5lY3RlZCBkaXJlY3RseSB0byB0aGUgUExJQyBhbmQNCmNlcnRhaW5seSBu
byBuZWVkIGZvciB0aGUgYWJvdmUuIEdQSU8ncyBjYW4gYWxzbyBiZSBjb25maWd1cmVkIGluIG5v
bi0NCmRpcmVjdCwgd2hpY2ggbWVhbnMgdGhleSB1c2UgYSBzaGFyZWQgSVJRLCBoZW5jZSB0aGUg
YWJvdmUuDQoNCg0KPiANCj4gPiArICAgICAqcGFyZW50X3R5cGUgPSBJUlFfVFlQRV9OT05FOw0K
PiA+ICsgICAgICpwYXJlbnQgPSBpcnFkX3RvX2h3aXJxKGQpOw0KPiA+ICsNCj4gPiArICAgICBy
ZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtcGZzX2dwaW9fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBj
bGsgKmNsazsNCj4gPiArICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+
ICsgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+
ICsgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqaXJxX3BhcmVudDsNCj4gPiArICAgICBzdHJ1Y3Qg
Z3Bpb19pcnFfY2hpcCAqZ2lycTsNCj4gPiArICAgICBzdHJ1Y3QgaXJxX2RvbWFpbiAqcGFyZW50
Ow0KPiA+ICsgICAgIHN0cnVjdCBtcGZzX2dwaW9fY2hpcCAqbXBmc19ncGlvOw0KPiA+ICsgICAg
IGludCBpLCByZXQsIG5ncGlvOw0KPiA+ICsNCj4gPiArICAgICBtcGZzX2dwaW8gPSBkZXZtX2t6
YWxsb2MoZGV2LCBzaXplb2YoKm1wZnNfZ3BpbyksDQo+ID4gR0ZQX0tFUk5FTCk7DQo+ID4gKyAg
ICAgaWYgKCFtcGZzX2dwaW8pDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4g
PiArDQo+ID4gKyAgICAgbXBmc19ncGlvLT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlKHBkZXYsIDApOw0KPiA+ICsgICAgIGlmIChJU19FUlIobXBmc19ncGlvLT5iYXNlKSkN
Cj4gPiArICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihtcGZz
X2dwaW8tPmNsayksDQo+ID4gImlucHV0IGNsb2NrIG5vdCBmb3VuZC5cbiIpOw0KPiA+ICsNCj4g
PiArICAgICBjbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCBOVUxMKTsNCj4gPiArICAgICBpZiAoSVNf
RVJSKGNsaykpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBU
Ul9FUlIoY2xrKSwgImRldm1fY2xrX2dldA0KPiA+IGZhaWxlZFxuIik7DQo+ID4gKw0KPiA+ICsg
ICAgIHJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShjbGspOw0KPiA+ICsgICAgIGlmIChyZXQpDQo+
ID4gKyAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImZhaWxlZCB0
byBlbmFibGUNCj4gPiBjbG9ja1xuIik7DQo+ID4gKw0KPiA+ICsgICAgIG1wZnNfZ3Bpby0+Y2xr
ID0gY2xrOw0KPiA+ICsNCj4gPiArICAgICBuZ3BpbyA9IG9mX2lycV9jb3VudChub2RlKTsNCj4g
PiArICAgICBpZiAobmdwaW8gPiBOVU1fR1BJTykgew0KPiA+ICsgICAgICAgICAgICAgcmV0ID0g
LUVOWElPOw0KPiA+ICsgICAgICAgICAgICAgZ290byBjbGVhbnVwX2Nsb2NrOw0KPiA+ICsgICAg
IH0NCj4gPiArDQo+ID4gKyAgICAgaXJxX3BhcmVudCA9IG9mX2lycV9maW5kX3BhcmVudChub2Rl
KTsNCj4gPiArICAgICBpZiAoIWlycV9wYXJlbnQpIHsNCj4gPiArICAgICAgICAgICAgIHJldCA9
IC1FTk9ERVY7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGNsZWFudXBfY2xvY2s7DQo+ID4gKyAg
ICAgfQ0KPiA+ICsgICAgIHBhcmVudCA9IGlycV9maW5kX2hvc3QoaXJxX3BhcmVudCk7DQo+ID4g
KyAgICAgaWYgKCFwYXJlbnQpIHsNCj4gPiArICAgICAgICAgICAgIHJldCA9IC1FTk9ERVY7DQo+
ID4gKyAgICAgICAgICAgICBnb3RvIGNsZWFudXBfY2xvY2s7DQo+ID4gKyAgICAgfQ0KPiA+ICsN
Cj4gPiArICAgICAvKiBHZXQgdGhlIGludGVycnVwdCBudW1iZXJzLiAqLw0KPiA+ICsgICAgIC8q
IENsZWFyL0Rpc2FibGUgQWxsIGludGVycnVwdHMgYmVmb3JlIGVuYWJsaW5nIHBhcmVudA0KPiA+
IGludGVycnVwdHMuICovDQo+ID4gKyAgICAgZm9yIChpID0gMDsgaSA8IG5ncGlvOyBpKyspIHsN
Cj4gPiArICAgICAgICAgICAgIG1wZnNfZ3Bpby0+aXJxX251bWJlcltpXSA9IHBsYXRmb3JtX2dl
dF9pcnEocGRldiwgaSk7DQo+IA0KPiBCaW5nby4gWW91IGFyZSBhbGxvY2F0aW5nIHRoZSBpbnRl
cnJ1cHQgZm9yIHRoZSBsZXZlbCBiZWxvdy4gWW91DQo+IHJlYWxseSBzaG91bGRuJ3QgZG8gdGhh
dC4NCj4gDQo+IElmIHlvdSBuZWVkIHRvIHJldHJpZXZlIHRoZSAqaHdpcnEqIGZvciB0aGUgbGV2
ZWwgYmVsb3csIHlvdSBuZWVkIHRvDQo+IHBhcnNlIHRoZSBEVCB3aXRob3V0IHRyaWdnZXJpbmcg
YW4gSVJRIGFsbG9jYXRpb24gKG9mX2lycV9wYXJzZV9vbmUoKQ0KPiBhbmQgY28pLg0KPiANCj4g
ICAgICAgICBNLg0KPiANCj4gLS0NCj4gV2l0aG91dCBkZXZpYXRpb24gZnJvbSB0aGUgbm9ybSwg
cHJvZ3Jlc3MgaXMgbm90IHBvc3NpYmxlLg0K
