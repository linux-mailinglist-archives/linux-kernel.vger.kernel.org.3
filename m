Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B3A5AFA69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiIGDJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGDJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:09:45 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E66DECB;
        Tue,  6 Sep 2022 20:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY4ojK0iVBs34fK+pgL1CkEHywKgJcgpJLRU9/XWfJ4Qs6PQJLYPIWfut73f15LZ4R/hzgW8Iw0yMwFZ+AsNBnXCiI+j7cMk5YEP9xuxJo3zUKKX/gLXYE/zTeK+WH2KxXg2wNNdkTqd/9kM5Oxf5kCbunZcUWuipZaNGRnIS3cSL+m+ujqPJqJBs56q5zfRB3+6r9c2DQWUP4j3YD967W0jaGg0TQ+w6iYOg83TevDtcH3RKzXUe6kpeXMwnWdIyfIWwbA8iOW/l2POVX4AtZgSgoSYNiBaVLiibzju1i4RLqEUGBslF8LAhhMr+O2Hrsg+wji720yXX9kye8sVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K518tdaQiVoLZNJOSJcPWpOOeNXiKJsnqfXvn9ixeXE=;
 b=gMDoLy1DZ/0L8e5X2s4jccQv0nsT9uDqkjWiwSIwqyUOaP8UYRfXOCrUTVH6PK6RqXkpjqB302A4xocrrQDB5rUuon/izxJtFnai0933U9u5DkfymzONPaUBKkubz+Lx6SHYBRWVWZjd2Puy9XzRPGIOFKtoU/S0kYPGIA6L07tvB/wYdHhxhrHqgP8jBzJH1xGsDj2Mr+XVkU2RnswGrpsXtA5Zj95OCK7vaom9HsveuPVkGM6zM5Fm5WXeQXFt9TTD12ka5/YK7nlU+DXdIvnGXxiSRrriL9P30rvzQICgoq84qqwyM+KG7EcnMOZH76CrV0AqaBo23elzQNxo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K518tdaQiVoLZNJOSJcPWpOOeNXiKJsnqfXvn9ixeXE=;
 b=GdZr7SSzTnZImuJfkkh663ZVo2gPzTGlaFsHcl0ZdkQJuOxA3cjE46yNGJHlT7EOyHt8/7vBEKAOtukxbjAE69Tbbxj7xxYLaL5FPYqqbEptOsGOdHGavZ+0rS+66dUWm0VQodaqTMaTmwBGYTZ30nqA1oYcRC2R2G805ciDWRPenUfKYstJW2ougD6UcPtKA+66mwpHDG/NewOwvpbxQiEfF0/9eYmN5sUelDkuMaoyrnX3CyZaN5cpaRnEsXWCe9VO5lw0m77oaPSlAAAUhQ7PzO+dTYC5JcBRp2d8y/9tg5RwNrLeZZYoLERkN2ZPqWzcf7sPxpodKgs/Czcfpg==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by SEZPR06MB5855.apcprd06.prod.outlook.com (2603:1096:101:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 03:09:33 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::68f1:4720:3bc0:196a]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::68f1:4720:3bc0:196a%7]) with mapi id 15.20.5588.015; Wed, 7 Sep 2022
 03:09:33 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2] crypto: aspeed: fix format unexpected build warning
Thread-Topic: [PATCH v2] crypto: aspeed: fix format unexpected build warning
Thread-Index: AQHYwOfVAHvQefTdZEqHfOPXdoG10K3TPRyAgAANhQCAAAHHIA==
Date:   Wed, 7 Sep 2022 03:09:32 +0000
Message-ID: <TY2PR06MB3213D3EB56E9B01521D86FC180419@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20220905052449.1830669-1-neal_liu@aspeedtech.com>
 <Yxf+W/mJvnSKzQgM@gondor.apana.org.au>
 <712da429-6d0d-325f-1c53-39326faa2d41@infradead.org>
In-Reply-To: <712da429-6d0d-325f-1c53-39326faa2d41@infradead.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 671f91df-9832-493b-41bb-08da907e630e
x-ms-traffictypediagnostic: SEZPR06MB5855:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5qsPHND3OyZn1ixi+iGsONJwzQBz8jveQG+lPifEs5iiFo/E/Qmwl0pB7UWWHFq7I5bEmljxVSEVUUF0ZchUjGDw6cV3t53QXy0jTlqO0fBjPuzjeuDo2qa0//3UUj9QJL7kgq2NG9UaLgEBe2zJ3fDnFIxb8p0zcXavnn3J9vhfyygQ9Z15uAQxgvocDZtcm4YgdjAd64OrQEW2D/z1hs4zW+0/gsJBGnY0M5YhHmz3xO37r/DhQMf0t/YsPfRVQDtf/ApnDo5fnct4CKvW/0vjmTihCwdP4o0fwGh4zLokulWxGBSEAOculxkGeE+HO2tZZMtfHR/niHBejTP08kjO2biDYY+1sb6ruCJeAZRC6P4usJA5VHtxjBf4rtrdaU/neT/jC/Yn7hQWy7rK9yL34DXronGRQ4YF3HQQupsL1HkyCMQn1Ifr9VuP2sEhlkbLalotvDWWeZp/R4MOI+9jx8mZKOiuQcsYcr2BlACAIdvbx9OLDrz20jgw0BU0s+vDRgNBzwqvNm7rx/mdGNCsrdUyCqo+yzVcNrgtJX760h4O5bHCdgZXXXWO30TQAP/XBmF2s9bvyBoXDS+yojBvyYrHPjJAHWyTufFp+Vje4JD6R/Bq6SGI4RG6MzmvgVti80ABM+fCgB1C6FNqNJaqOPP/DmXxQ0Sozf4TfBLxwOof54thnOXBLGbFN0mEJa9JPOApwmp00M5PHDj8YtVuBIQ3O3qJdhdTS7IM21hRb6H8rKRqD2tS50Kw0VLsggYEDAxooQOQ5pOmB3YAbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(346002)(136003)(376002)(396003)(366004)(83380400001)(38070700005)(186003)(71200400001)(110136005)(66446008)(52536014)(86362001)(53546011)(6506007)(5660300002)(478600001)(64756008)(4744005)(7696005)(8676002)(316002)(4326008)(2906002)(76116006)(33656002)(7416002)(54906003)(66556008)(66476007)(8936002)(38100700002)(26005)(9686003)(122000001)(41300700001)(55016003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGN4bUJiVldGTE1ZV1ZFN1d2dlJFb1ZBNFVaclJMU05oc1FGT09iTTdBeHBN?=
 =?utf-8?B?L0pYaWdOaE9USnQreGcyV2V5OGlITFBYekpoTFh5c1dBbzNjRE5WQ1kzdEZO?=
 =?utf-8?B?ZERwM3hKR0hoVkV5OTRPdGlDZ1djUDlhUE5GUkZ3N0t4RGV0QmpaMkQyZWNS?=
 =?utf-8?B?R2NUaUdCVWRRcTYyNE1qN0FwdXlHQXZYV1cwdG5zcjZuMU9JcHFKOFRHSkJx?=
 =?utf-8?B?K3NCVTJrTVNsMzdabkt4OUNNcVBPd04wc3JTd0tIREtaS0ZTOG0vckRCd21p?=
 =?utf-8?B?ZFBaYU5XTzFna3ZCZ0RGQlQzZytjdXJ4QkFja3JicnVKWHdIaHVJWGNpd20y?=
 =?utf-8?B?aGNzcVhHeHVVbXBiU0VKS3hZbXJxWVpldkhnMTdhOWpHazZMalF5RERocUFh?=
 =?utf-8?B?RkJSYlNKbDBYK21ZS2U4ZFVQZHdkSUk3NW1rMnkxWWNCUEtLeGxZU0x5bkZK?=
 =?utf-8?B?MDAzU3NKMldGcU9jeW95NWdCK05ZN25EcS83dU02azdVV3JHZUZ4b3NWM3Er?=
 =?utf-8?B?M2dpczA3eEJTbFNRWlA0dWkwVlRSN2ZTMlpKb0ZYS1c5WmRvYThNOWVlamJ0?=
 =?utf-8?B?MTNqWVY3WXRza1htTzB0UlNSSHVrWHNXWGNBSGRRaGkwNy9IWkw3T01TL0Mx?=
 =?utf-8?B?YTdRaGVIS3NUcHZvS1dWY0lGT1VkTmxsUXY1dXlpOXFHcklNRTZLWndORmpD?=
 =?utf-8?B?UkYwSTAvTDJxZit1QVVZbkY4NTREUlVFMDI1a05DWktPS3BaK2p0a21BMTlR?=
 =?utf-8?B?bFcwTzE1NC95TEIzM1EvbzVySGtVNHVZS0pDbEFhVXJGZnMrRTZHOVM2bU80?=
 =?utf-8?B?RjI5ckN0Y3hoTC9TbG1Tdmc0WVRvNXVGQ0RGeTlnWGxEVnBBQ1NpbjhiVUlV?=
 =?utf-8?B?YWlWZ2NSY3g3WGp1OUlvK0pJaG5nTlFNY1VuQ3Q1MkJoS29IVzRRNWViMWtP?=
 =?utf-8?B?bXpjOFRuOXAva05tNDNhN0tnRG1WYmNXZHplSTAwRXprL3V4NjB4MXhVcjJq?=
 =?utf-8?B?TWVPTVU1Qyt0TG9KcEd6bnluZVIzZm1qZXMxTDI4V2ZranpRTGZHOVJLSEc1?=
 =?utf-8?B?cGw5bXF4YjJWZ0p3YmdMdGhvbkhLL1RMaW1ZODIzdjQ4MjZPZkVyTTNCbWhP?=
 =?utf-8?B?a216cXJ3UXY4Y2FWSlZTSkVNR0d1RGczeW1EYXhGOUFvV3RQVktxdlhEMnlD?=
 =?utf-8?B?QVM5bFRuNVprUFBjaDJjYVcyczZpOU92Wm84c3lFNWZXbWxQNldHYUh5cm0y?=
 =?utf-8?B?UjJIOU5MQVZVOTgzUHIzd2c1Q0RUZ1VKZzdLRVdFZ2RUcFRJbHVJMUZOcTln?=
 =?utf-8?B?UnR6M3RkaHdFeVNxWTE2K2pLVVdQZlZEMnJJU20waWorb0FWUU5TODBrVEha?=
 =?utf-8?B?THRhL0xlS01WMzFKWUZEMWhaQXg4QWVZWFJVSjRwUkZMajdvZVFBbEorRjQv?=
 =?utf-8?B?azR0cDIwZmpiSEFJanFmM0VqQW1HWFRCWU51NlRUTmVVRjNOeW5NOS9KOTk0?=
 =?utf-8?B?M3dkTmExZzZHZGNJMlpBU2hBUk1PYWY5cFo1RzBNMnBjRkRWN210NHN3OFRO?=
 =?utf-8?B?aTJRU1FJbDQ1cTJsR2IwcklQT252THlxSjZQMGR1U21UZDRub1o1d3RzR1Qx?=
 =?utf-8?B?VUUzYVlWaDQyZkpTREc3ck1BYUhwZms5amg5SnNHNXhEdEVkd2x5b2NCV1M5?=
 =?utf-8?B?VlVYS2svQWtHQ1FBNzI4V3NlRVhjT0R5ekU1c095L1ZsN0V0WHo3RW45c1Rq?=
 =?utf-8?B?UlFxSW5WN2hlRzNLUjQ2dUFxNlh3K0IvU0NvU1RUWlc0M0JVNmNubnBZOXp4?=
 =?utf-8?B?M3B6NWRTSzRsb1dYN3I5R0RzSWxyUTJuaENWUGMzNmlOK3ZGUk11cHNhQURq?=
 =?utf-8?B?Ym82SDhabmZ2YW5EY3RJYXZWMk9UMFgzTHZ2R0NJSVBwdnR2WjZWczFqbHd2?=
 =?utf-8?B?MjlCWnFEK3lLRTBNMmJqTnhTZE1Eb09JeHRiaVMxQmd6Z08ycEVWc3cvczFO?=
 =?utf-8?B?azVYbmc5eHFCZGhQcFQvcEVmRkhmQVZ2MndxcmNEcUlrb0h0eVdnT2Y1R25U?=
 =?utf-8?B?akxQQWNjZnVJVmVDd05hZkhJZTJ2RmdyOUhjRjA3eDRSSnNKOENJTGZoODBO?=
 =?utf-8?Q?jYDZ5e4GxJ4jW96TUKolDdh3k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671f91df-9832-493b-41bb-08da907e630e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 03:09:32.8035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cBmmSODuofaneTesJ54AQOsSzXPaUyNKQxi/j8VVZzl+Bxt5mgrY5Y49JOd52e6Q6knHpxs9nkWBwhOShnrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA5LzYvMjIgMTk6MTMsIEhlcmJlcnQgWHUgd3JvdGU6DQo+ID4gT24gTW9uLCBTZXAgMDUs
IDIwMjIgYXQgMDE6MjQ6NDlQTSArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4+DQo+ID4+IEBA
IC0zMjQsNyArMzI0LDcgQEAgc3RhdGljIGludCBhc3BlZWRfaGFjZV9haGFzaF90cmlnZ2VyKHN0
cnVjdA0KPiBhc3BlZWRfaGFjZV9kZXYgKmhhY2VfZGV2LA0KPiA+PiAgCXN0cnVjdCBhaGFzaF9y
ZXF1ZXN0ICpyZXEgPSBoYXNoX2VuZ2luZS0+cmVxOw0KPiA+PiAgCXN0cnVjdCBhc3BlZWRfc2hh
bV9yZXFjdHggKnJjdHggPSBhaGFzaF9yZXF1ZXN0X2N0eChyZXEpOw0KPiA+Pg0KPiA+PiAtCUFI
QVNIX0RCRyhoYWNlX2RldiwgInNyY19kbWE6MHgleCwgZGlnZXN0X2RtYToweCV4LA0KPiBsZW5n
dGg6MHgleFxuIiwNCj4gPj4gKwlBSEFTSF9EQkcoaGFjZV9kZXYsICJzcmNfZG1hOiV6dSwgZGln
ZXN0X2RtYTolenUsIGxlbmd0aDolenVcbiIsDQo+ID4+ICAJCSAgaGFzaF9lbmdpbmUtPnNyY19k
bWEsIGhhc2hfZW5naW5lLT5kaWdlc3RfZG1hLA0KPiA+PiAgCQkgIGhhc2hfZW5naW5lLT5zcmNf
bGVuZ3RoKTsNCj4gPg0KPiA+IFNob3VsZG4ndCB3ZSB1c2UgJXBhZCBpbnN0ZWFkIG9mICV6dSBm
b3IgZG1hX2FkZHJfdCAoeW91J2xsIGFsc28gbmVlZA0KPiA+IHRvIHBhc3MgaW4gYSBkbWFfYWRk
cl90IHBvaW50ZXIgaW5zdGVhZCBvZiB0aGUgdmFsdWUpPw0KPiANCj4gVGhhdCBzb3VuZHMgY29y
cmVjdC4NCj4gSSBvbmx5IGxvb2tlZCBhdCB0aGUgc2l6ZV90IHBhcnRzLi4uDQoNClRydWUuIEkn
bGwgcmV2aXNlIGl0IGFuZCBzZW5kIG5leHQgcGF0Y2gsIHRoYW5rcy4NCg0K
