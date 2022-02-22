Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067164BFB05
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiBVOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiBVOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:44:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A39652EC;
        Tue, 22 Feb 2022 06:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645541035; x=1677077035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BiIUcmZms5YzefP5dxsNarqwke5Fx6b7WqYKEr99ynQ=;
  b=2lQbn4NKLyLGyv9FjfnhoTeQzDhhb0hcSL0trzvctZdAr0C5YrHK2d86
   cFUQtAw5jbpQ9VaVuYuMqKvMKt+yJvkdUDIqmHlGtPMoLz7jUC8w7M6y2
   oZX3hnduRbaXhL9PGg4Yo0QyPxA7zz5763TqcNyNkd2MgFuwfcTdTmBBy
   1luo+5EzhQnBPiRvhLQz1dIgmLN710hyQvrbfAd+gyLuz8j4zD8JM+sjm
   u+uaxtoxYK0gxoRCLOevAslWQPbMRM6F+WAqGQEOIvxVsG1KxQs6Eze0X
   P5Z4PLDSEwk57j2EssmXxOTO5FZwR5POTqj66BpoPasWS/xhbWg5Ig+hG
   w==;
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="163157998"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2022 07:43:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 22 Feb 2022 07:43:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 22 Feb 2022 07:43:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1kzznL8CHeYJCvHjc9jbAD/FgDp7WX+ed25iiEaSUKhx19MgU5OppVX547lEaUxFrb9sFz2e3poNr2+HrSl4K/C3tTJNvK8miTUQRe08aLzMwYCM1yJpMFasip8K0LC5d+f0ipPtr6Rof7wVYez6etcYO8dUgca4M4oESyiS6t7uYstd681eP+cW8EIYr9RUdqrgUxMatl7GyKJpZFZgPF+1/jYAw5yq6ne6MolyEi1jCTmxdFMTiJaSvLb3rdZBH3ar/aJQKnwg/pd0rNcoO9BP5bV059PGn3tUFO1sexvZcDp4v703hbRobrjuFDsvmfSySItpr42f3kxplMWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiIUcmZms5YzefP5dxsNarqwke5Fx6b7WqYKEr99ynQ=;
 b=UoeGnwPgi7tw1WpsGYDQJQgZmHlr4lcXmog5uFtcjbL3Zlr9z9pZXwv15apB/DX/hVISMM8FMKqHbiOLB5hndb5IL9gl8x+smg8s22totcAsvqhgL5D3Mjx4Y76HLSm3iYmAgz91MrLuWuw0QUhbzxX9+8vtB8OSDNuPQdQJBRVLmV9KPGYTh1/hgIl6bzhj4beS44l6At99yWaas9J3wZRk+SXfmvLgSBpGjVnT2tNZih8dv6gjgbu4fVURLOAqotQSEJI1Dvf+9NKNgRdczCZBI+Ah/7lXPDDMFdCry8opFTtYBZuwibJKDUfiSA1VH9ksw1WifiWseKk81S5lLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiIUcmZms5YzefP5dxsNarqwke5Fx6b7WqYKEr99ynQ=;
 b=YHwtw5DOnDuYMEvOmppzkUGJnrzTSXpNhwKVVge6ohsq2TipbQXZ5rGQikRQGmBxRSLVlIhOqdNO4K4k/QquehJMnAmETSI1cWllg74AG2/u6N/6QfN+4l/ghuAvN/buwGYRa//XevWRbhPOa987cU/lVJaphzaVgst2S12A7oM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2960.namprd11.prod.outlook.com (2603:10b6:805:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 14:43:49 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 14:43:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Topic: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Index: AQHYJ/PF9hATniilJUe3fAFeGB3/Dw==
Date:   Tue, 22 Feb 2022 14:43:48 +0000
Message-ID: <3cd510ad-a6ab-d4a0-92e3-9156a0c7ddbf@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <44f655d027b49b87065915f6ba2744d2@walle.cc>
 <81d7c569-d6c2-9167-e007-eda72f34842b@microchip.com>
 <23fbbf2dde387e3832b4ca23d46816c0@walle.cc>
 <7cd74ef3-5a7d-4e65-3436-ee3399ca56a3@microchip.com>
 <e39d06684b8f3a63103f40f0e99e030e@walle.cc>
In-Reply-To: <e39d06684b8f3a63103f40f0e99e030e@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f283ad0-530c-4213-246f-08d9f611bc9f
x-ms-traffictypediagnostic: SN6PR11MB2960:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2960B978F5B76CF5515C80FAF03B9@SN6PR11MB2960.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /HHkAMVm5eh6Dlsez8OpPbIYBEjjbMwmIUnWRJjrumWUULx3Z8/bldAj13xXcZbLg/69BFds0QmwXHw8vouG6GbidGH5RkF2ZpPVkFB27PYtbbui15E8irJ9VNUXr+GtycVCIFyUOjtnKo4GXMvwjAWzE2S0zuuTcQ6nbeODubAwRxDKsOeeVILxYJOLCmnsjYUCZZ3ptSv0HS8YSYEs8q5s7KEf8KTSM2rlwhjqclGejJnYWt0nymZ4gOr5erfhAnm3qMQuMmVLA3XUsckXtMN3YMHfuT9PxQVyCSRg6c6IbwBDl7O/PtLe5kYZ1uI6S9DlKb4/OLJA/7tcT1RLAKv/axTGOlsVuA3kiNPyAQZaKUm3GPJpKEofFvh1gnh3troxI9PcdJwoAzUfeQ44Hr9bax7kcLFuwk4JxCobbVbu+jyUlQbZI7o+GZQqnOqFRLDIYHBiEpIT1tf0yVb6L0gqm4AIe1j7kcQS73y2n8vRY8jftEQ7AjhU/3FsdcPmgVknrOHnNaRzdXK12nZ/fB4MTz0HIGzbPZqsdDFzYOBV0G4nSKGlZXynvE/brcILReTQ2yp1G6kcyeApBFeqRt1ZIfarc6u73rDqTHLJnMOAVPRE7stRae47m4qVJH+49W9IHF7nRrxtOqSt0MDP5UA6RRx+8nhHdeNKEnsOeof7+F7tWb8TZqJ/XUQdalzV6h0tBpZz0O8WZJoCD0EHAECBhRnn/YVECbTbecp4CZe6mHPUAn0VL2l6MzLJyqWVnHt1Pf2VOya5WBHgMC3Cyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(91956017)(76116006)(6506007)(31686004)(122000001)(53546011)(508600001)(26005)(7416002)(6486002)(186003)(71200400001)(5660300002)(86362001)(31696002)(2616005)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(38070700005)(38100700002)(2906002)(54906003)(6916009)(83380400001)(6512007)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bExNdmZUNDk0dkVqdldBM2dRL1dGaHJmTHphem1FZENFcEFaTnpNRFdXRElj?=
 =?utf-8?B?VE82ZkdUWGI3QkY0QnJkcUt5aTN4dmd4aEYzOXdhcEFiSnNVdm11WjNHekdD?=
 =?utf-8?B?SEp4bWpGNGtYR3FHWW1RSHRkUVZPbjVWaUxKQTFzWVRlQTFRV3NKdnJQZkhW?=
 =?utf-8?B?am5sM1d1MWR4N3RRS0RKMW9veXlDYlNoMUhYUXp5VjNza1F0QjVlczJFRkp1?=
 =?utf-8?B?UHpFM0pJMXZWM1p3RkprVGNZSE1DQ3VyVXFpdEN5Z2Z0V0hRN0s2b3lHMHlS?=
 =?utf-8?B?YVRpOW5oTU9YSW5pM2wyQ0NFTEs1dkM2dFUrTmlKVzFVK0xpU0Izd05XaW52?=
 =?utf-8?B?dE5wRSsyQ3g2VVNraHlUTkhUR2pOTzBSRURrbkpYUmVxNGxBNnorSTNZNko1?=
 =?utf-8?B?NG9SNnU1dkppWHJDdnFlemdOSURCQmErTUM1aWpXZjdvc0pleFgvSXozOFZZ?=
 =?utf-8?B?R2xJNWlUSkhza2UvWWVudXlZbEhUMEV5UENBbzc3U0Q0THdtZTI5Ry9mQThZ?=
 =?utf-8?B?WWxFbWQrdkFDTy9qd2k2RlFVRGhkVXpEb2NVNzlPZ0xYcnFWWXpGUlRoaVRB?=
 =?utf-8?B?NDVFYUhXWFlEMmY1TWRWV1Fua2E5YkVJbzZpV0NpUnA0cUhNQzhmNzlsWlYv?=
 =?utf-8?B?dHFsYnBwT2dnVzZoaUIyNys3dzV4SDNxZkE0NU5uYmd6bWZHV1lCdmVNdEts?=
 =?utf-8?B?NzY0MGNUejZDbEtjU00wWEc2b0pjMEdValdHaWU4b0grTVpWSFc2MlJYQnh2?=
 =?utf-8?B?VTM5RENTazU5RzJ5ODhkZlZQdS9ZcG5adUJENXRRN3pWMzFiYXl5V0VUMi9q?=
 =?utf-8?B?QmswOTFKZkFlRmpqZTlvRVM4cmlhaTNxbytDUzQwY2JqOHRWeVBDV0FxUFlZ?=
 =?utf-8?B?NmE5Q2pqUkFNNUZaeEhKaEhzSWtkN2dsTlp5NVpEVlo5U2VVOXhsdDFtRmMz?=
 =?utf-8?B?YWFKNVRRaDRDQW1WeEpOQTlma3dxUVVRaUtWbWpMdW5nZXlVelZzWXQ4NU05?=
 =?utf-8?B?aGR0bjdqMUtyVThsK0FOVUM0QXpTY3hVd0lCTE43ZnR2OUppT0hwSlAxZlo1?=
 =?utf-8?B?NXppNVR2TGJLYnQydkNyNkVvMHZoYWJ2YU1mV04vWW9UcWl3cWhHYTkzMitz?=
 =?utf-8?B?T3htTHdEUEVlTzl1MGExME4ySkh3amVWL0pCVlY1UHQ2dHVBZWxvNExDc3py?=
 =?utf-8?B?Uk5CemdFanJCZzVRT212VFVXYmZpZHFtU2JSY2F6aEJkV1U1WFRCMncyV2tp?=
 =?utf-8?B?NUF2UVA0bVJxS0ZtUUZUUXRPNnhKVGtDbms4OVJwQTM2ckdzZkF3aGhsa3JH?=
 =?utf-8?B?OUlVOUE2dGlFTDVuNFpoVDR1NjFnbVFJRlZTRHI0N0VLbXN0RFowZ29ObEhK?=
 =?utf-8?B?WCtKRFJhelg5NjdyZWp5UFo3QVpUdnpJUEh0NDkxai93N1V3b3o3NVpyUDNQ?=
 =?utf-8?B?WWxJcG94U1pKdy9MZEsxTk52STBNN3N0eVRWYnFPb3lYb2tHc3dWaVdBU3Zi?=
 =?utf-8?B?WEVSaDBWY2d6cjcrV3NyMlZac0ZpTlpJOVNQQURuRzZtcG9ScUJYWk5Ca2xq?=
 =?utf-8?B?NzNQdnFnQlNCcDJUbWI4b3N2WHhiUEd1UW9acGc5OWZsRWkvbXRrQkwxOEw5?=
 =?utf-8?B?dUNuc2M0UVRKMTZPdkozRVhEcUw0eUxJTGFWOUt4eThMd25kSkwvcnhoU0ZH?=
 =?utf-8?B?ZlpFZ2NUb204djlmcllWVHZ5dks4MFlTRnhqeU9Xb3lyS2FpWXROeFdBaEZj?=
 =?utf-8?B?VlI0aE1selZMYVloQzRVdmhhOTRkTytXY04wMXA4KzRqMkZxMnVQNWZRcU5V?=
 =?utf-8?B?NCsrT0l0Ky9sdFFLa29zU2VDWXVaSzZtclBEV1pvdUU4ZmxJUUFPVXhldjNL?=
 =?utf-8?B?VUo5SXlUZ2NjM3JVQUN6TmZkUXAvSml1TDdLcWdKK2VOMmFYZjZ0Q0IrYUxE?=
 =?utf-8?B?YS8raTJCZ29CdStkd0FlU2pyNEdPZE5VQlhabVhhRVpNcW5rQ0pucDhQVlFK?=
 =?utf-8?B?aTlwWWNVbDVRL2dXUm5BZCtHYTJQczB4TStGcnJrTzZtRldTZUxoRDhCTTRQ?=
 =?utf-8?B?LzJHUEdHWlNOKzNJVW1EV01YUE0zNUlTWE53Vnd1emR2Vlh0WlFnRFM2YUUv?=
 =?utf-8?B?UXgrTlNRNXpBa0FQd090U08vdnpjbmh2NlVkSWwwV1VOdUlueEMzVXFnMUt1?=
 =?utf-8?B?aWZidUE3RTFOcjMzc0x5QWZFRCtJWkw0VGtLMk40a29BWjZBY1kya0U2M1ht?=
 =?utf-8?B?OHc0SVlNMkVQVXhYTWRKK2diVnJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2453CBA63CFBF441AF1AF8BB9B8E66E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f283ad0-530c-4213-246f-08d9f611bc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 14:43:48.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+WlTUpG1M3CBY7L/tW2Aa9FIjrq+z6C7ZDek/W82IDgFTbQOQuOu5kfvBrRbIRmWo7Dr4vEvCRbVG9X+M0gDh0Q8SvAqnW9hidBI13peJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2960
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMi8yMiAxNjoyNywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAyLTIyIDE1OjIzLCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDIvMjIvMjIgMTY6MTMsIE1pY2hhZWwg
V2FsbGUgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IEFtIDIwMjItMDItMjIgMTQ6NTQsIHNjaHJpZWIgVHVkb3IuQW1iYXJ1c0BtaWNy
b2NoaXAuY29tOg0KPj4+PiBPbiAyLzIxLzIyIDA5OjQ0LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0K
Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4+Pj4+IGtub3cNCj4+Pj4+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+
Pj4+DQo+Pj4+PiBBbSAyMDIyLTAyLTE4IDE1OjU4LCBzY2hyaWViIFR1ZG9yIEFtYmFydXM6DQo+
Pj4+Pj4gRm9ydHVuYXRlbHkgdGhlcmUgYXJlIGNvbnRyb2xsZXJzDQo+Pj4+Pj4gdGhhdCBjYW4g
c3dhcCBiYWNrIHRoZSBieXRlcyBhdCBydW50aW1lLCBmaXhpbmcgdGhlIGVuZGlhbm5lc3Nlcy4N
Cj4+Pj4+PiBQcm92aWRlDQo+Pj4+Pj4gYSB3YXkgZm9yIHRoZSB1cHBlciBsYXllcnMgdG8gc3Bl
Y2lmeSB0aGUgYnl0ZSBvcmRlciBpbiBEVFIgbW9kZS4NCj4+Pj4+DQo+Pj4+PiBBcmUgdGhlcmUg
YW55IHBhdGNoZXMgZm9yIHRoZSBhdG1lbC1xdWFkc3BpIHlldD8gV2hhdCBoYXBwZW5zIGlmDQo+
Pj4+DQo+Pj4+IG5vdCBwdWJsaWMsIGJ1dCB3aWxsIHB1Ymxpc2ggdGhlbSB0aGVzZSBkYXlzLg0K
Pj4+Pg0KPj4+Pj4gdGhlIGNvbnRyb2xsZXIgZG9lc24ndCBzdXBwb3J0IGl0PyBXaWxsIHRoZXJl
IGJlIGEgc29mdHdhcmUNCj4+Pj4+IGZhbGxiYWNrPw0KPj4+Pg0KPj4+PiBubyBuZWVkIGZvciBh
IGZhbGxiYWNrLCB0aGUgY29udHJvbGxlciBjYW4gaWdub3JlDQo+Pj4+IG9wLT5kYXRhLmR0cl9i
c3dhcDE2DQo+Pj4+IGlmDQo+Pj4+IGl0IGNhbid0IHN3YXAgYnl0ZXMuDQo+Pj4NCj4+PiBJIGRv
bid0IHVuZGVyc3RhbmQuIElmIHRoZSBjb250cm9sbGVyIGRvZXNuJ3Qgc3dhcCB0aGUgMTZiaXQg
dmFsdWVzLA0KPj4+IHlvdSB3aWxsIHJlYWQgdGhlIHdyb25nIGNvbnRlbnQsIG5vPw0KPj4+DQo+
Pg0KPj4gSW4gbGludXggbm8sIGJlY2F1c2UgbWFjcm9uaXggc3dhcHMgYnl0ZXMgb24gYSAyIGJ5
dGUgYm91bmRhcnkgYm90aCBvbg0KPj4gcmVhZHMgYW5kIG9uIHBhZ2UgcHJvZ3JhbS4gVGhlIHBy
b2JsZW0gaXMgd2hlbiB5b3UgbWl4IDhELThELThEIG1vZGUNCj4+IGFuZA0KPj4gMS0xLTEgbW9k
ZSBhbG9uZyB0aGUgYm9vdCBzdGFnZXMuIExldCdzIGFzc3VtZSB5b3Ugd3JpdGUgYWxsIGJvb3QN
Cj4+IGJpbmFyaWVzDQo+PiBpbiAxLTEtMSBtb2RlLiBXaGVuIHJlYWNoaW5nIHUtYm9vdCBpZiB5
b3UgZW5hYmxlIDhELThELThEIG1vZGUsIHdoZW4NCj4+IHUtYm9vdA0KPj4gd2lsbCB0cnkgdG8g
Z2V0IHRoZSBrZXJuZWwgaXQgd2lsbCBmYWlsLCBhcyB0aGUgZmxhc2ggc3dhcHMgdGhlIGJ5dGVz
DQo+PiBjb21wYXJlZA0KPj4gdG8gd2hhdCB3YXMgd3JpdHRlbiB3aXRoIDEtMS0xIG1vZGUuIFlv
dSB3cml0ZSBEMCBEMSBEMiBEMyBpbiAxLTEtMQ0KPj4gbW9kZSBhbmQNCj4+IHdoZW4gcmVhY2hp
bmcgdS1ib290IHlvdSB3aWxsIHJlYWQgRDEgRDAgRDMgRDIgYW5kIGl0IHdpbGwgbWVzcyB0aGUN
Cj4+IGtlcm5lbCBpbWFnZS4NCj4gDQo+IEJ1dCB5b3UgaGF2ZSB0byBjb25zaWRlciBhbHNvIDNy
ZCBwYXJ0aWVzLCBsaWtlIGFuIGV4dGVybmFsIHByb2dyYW1tZXINCj4gb3INCg0KV2h5PyBJZiB5
b3UgdXNlIHRoZSBzYW1lIG1vZGUgd2hlbiByZWFkaW5nIGFuZCB3cml0aW5nLCBldmVyeXRoaW5n
IGlzIGZpbmUuDQpJJ20gbm90IHN1cmUgd2hhdCdzIHlvdXIgc3VnZ2VzdGlvbiBoZXJlLg0KDQo+
IGFub3RoZXIgT1MuIFNvLCB0aGVyZSBoYXMgdG8gYmUgKm9uZSBjb3JyZWN0KiB3YXkgb2Ygd3Jp
dGluZy9yZWFkaW5nDQo+IHRoZXNlDQo+IGJ5dGVzLg0KPiANCg0KDQo=
