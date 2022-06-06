Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5553E254
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiFFHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiFFHlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:41:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2FF45FB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654501278; x=1686037278;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=os3LvkkQVk2lVKmzGB6ZvX9+s7De3JyHUsQR27Q1Qcs=;
  b=Dt++KtLSnKnh7NySWngeoDP2p/hsGXo4Vtk6cwhlnlaKDGoUHC+MIpyc
   tIVnDG9bRo/x2mJ7DOWns0pVoyIEmwBcD/8yTO/1I2pkSl6rfefxG0vGH
   LTcBt3cS5xRe9tm7lkQZR/+6YN7pdjbigCJa2DDnSp9jEh/ZzDfTvYxBh
   A9V10I4yRtJS9aym6cfUFxikopnwM8BqYE9f7rF+w1MZEgPNJ9LHFRWJI
   tdNjQPlnfkT7SSIwix02sFJUynVR0f6TWQD+AAU59NPUuNwslBzwkn88S
   mYstcdTeVk/tKsVLTA5VXbKqm3h95FDJCUZV29Jxiowu3tCiLWzeW2fa2
   A==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="167201815"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2022 00:41:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Jun 2022 00:41:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 6 Jun 2022 00:41:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWk0bGRqsycpbmNRQ3Qg7E92TXLSsrWjZzdfeMTKMmCSTCpflFGs9doQrBkO8Dg3HKOZq5MKo2QTY2PQ0ZF4NNn+Enxy+pLM3yH141biFjCNpAJaDaaktEctfy8HPv6kiLDclNmAJUwKhk1WtnuhXfnJdxMa9g8xbiSWd6o30GPaD1dDWHBp1m9UTnw4qsku3Zxsi5jF8qHKOM1o+nI9fi0S85ZCwEB8hM+6B7BzQhcaI0qlJo8Wltsog0JAvEeyGlQtToIFFDbCyomW6/7HZVkGK0txmeV+wHQkQ7pIvGgON2aeqzLREWTOiLxEGr6MXFT6RjUcq1wjgzkM3E9RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os3LvkkQVk2lVKmzGB6ZvX9+s7De3JyHUsQR27Q1Qcs=;
 b=fSBmplyhV8lsIl/Tj1DOxlAJzVzjPKPAO94W4A+QE2B1KczW/0Lsm5OXV+gZZb+uzm0BKgA9v4wuyQ+125xmLeyZHv8G/Fndy0J3YsGdZ+xnqmiQbkPRLshvz0cK2Gm7zlQdtvVYUlUTKZhgFdZmL2YtJ6ClwOAP6HlYe17yPPBKPPHzlLHYZcXL7L9vFhVBGdKN3MWbvrKOM8Y0vlx4gHzvVZu0dW0zs/IhevZfV0DI13qC/Sf669bRsqX2QKnCaJN30fCmxQlMhnuXfqWUmr3zBbyOZTDPF6qhpDsd1CydSy0CLC9iTZj0k0imrD4+phqYtNiN1+JBAzmqT8dw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os3LvkkQVk2lVKmzGB6ZvX9+s7De3JyHUsQR27Q1Qcs=;
 b=p3IrsviUCbwmX8MKloi4Zxt0aSjLawDam06Q5/qzhqQyW3itlntpMSFj3kScDaRKIH2AVshUgXl5DvBznGVzsyMm5RvhLEvqgWOvuBHtM5BmXCwg/ubgx++O/cNEnQHoQ2qiz7HVdDOkEYHpUb4PtL6iyRJ9BcLT5qvki5PamPA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 07:41:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99%10]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 07:41:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linmq006@gmail.com>, <Codrin.Ciubotariu@microchip.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <hcegtvedt@atmel.com>, <hskinnemoen@atmel.com>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] misc: atmel-ssc: Fix IRQ check in ssc_probe
Thread-Topic: [RESEND PATCH] misc: atmel-ssc: Fix IRQ check in ssc_probe
Thread-Index: AQHYeXjMyV5EyaDYVEOty+iUR3/dYg==
Date:   Mon, 6 Jun 2022 07:41:14 +0000
Message-ID: <66e77a9a-af88-c4f4-1ae3-65b2d0f9098b@microchip.com>
References: <20220601123026.7119-1-linmq006@gmail.com>
In-Reply-To: <20220601123026.7119-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 039eecbf-1afc-48f5-1d59-08da478fef0b
x-ms-traffictypediagnostic: PH7PR11MB6353:EE_
x-microsoft-antispam-prvs: <PH7PR11MB63539B1FB4908BF8E9036E7487A29@PH7PR11MB6353.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vEkdx/j1LgPIz1/bdFtDnwhaCBAz3Ktd7IlcEcic3iYsHvr6PXU2JjdY4mbL94haVRIDfVfhgH5UlLm4FeP+12pfZjFxoxxOjlfw1ruF2Z5FkRHAFB6dv3iuV17dxpBXy8o0Yo18gOjlAOUv54qtcXhsurmQ/8u9h2RCk3vZnbWc+iLkU5Th48N1rgX8vxQNr/qGl4YnH7WNY9IjGGRWL8Gsea62duAneY5JejhwehRpE305TUZWb4DS1KdTDGOnSagiMR2THWo0AL6EFPmZ3zfdCOkFVDKiAqwNZgo/Fh7M52xlPrw4iCTT5PNeW8hC/JzCYOOl1jlhpBRZOnZg7izcrCcbgDAvULnaaqRbS1oozVkTTKA98EAhxww1q2D3JdgMu01enWEHr1FRMrMh2nZdVTZWvGcXw3LloH6MKPDfYy1k9WqJlyPQLoUU7aJ63E6vyPSOODzwKQSthy4agaDLmjKxO3Vbn+DIFoKQiCikesMsw6yFxWxwwdrYlhTO5GPJq4FFpKTeh9V4vL/aFNJUEJzE1Y4bfTFVAp2FdtQygDGkwvEw5o0XBPlersTefcca7VTy6k6hpMnQrfY3NkxmEoIeFCMgyvKdUhQpoFB+WdJpbiAie6xmVP12+VGKVw38syuReyfTmwaq3bRTphjJXHLjmcv7P/SnD9j7T9Qg7m77WOi/nJY9bfsDRX7ALHjL0I+kF7QS8CCCK4XK1fA/afVe7GsC+j39jJpXL/7H/doGmp46KwLYY827KEu7dSMDOvw2kb5dLFpy6D7YwmE/Cc8OeYAD5xIIaXb1IO0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(86362001)(6486002)(53546011)(76116006)(71200400001)(186003)(26005)(6506007)(316002)(31696002)(2616005)(508600001)(2906002)(8936002)(6512007)(83380400001)(921005)(122000001)(36756003)(91956017)(38070700005)(5660300002)(64756008)(38100700002)(31686004)(8676002)(66446008)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZERTZHVzd1d4OFNIZnZvdjVGZFZCTUZIR1diZ3FmditzRUV0TWFtTXh0VEpz?=
 =?utf-8?B?ZlVwanFKTktLRkJLK0h2RE1qUjVKYjYzSTFFNlNnUHcrU05DV1ljSlhTUFIv?=
 =?utf-8?B?aGxzODdKb3ZkRGFFOWh1WHZvSml1d21HcVNybnJqUnF1QTVzY3VwUERzRWk3?=
 =?utf-8?B?dFpPdy9wbkh3MHhEVzBUMUc0amIrYzRMRjh6ZjJhZVhlYnY0NzVpNkY4amNL?=
 =?utf-8?B?OEVDQmx1a1dvUU5VekZ1Z3QxV1dKb0syeHZLTVFTWUVVNk5HNnB5NXk1Skh6?=
 =?utf-8?B?TG5jMk1YSTJKbDFkbzRzZ2drWWFrQTRoVUljcUp1Wk9BYTRBV21oYVJTSjlI?=
 =?utf-8?B?dEdXY2wxK21saXZrTW5NTUcxOElSMjVqa09xT3VwSUJOazEyTjZyYjlnVVpC?=
 =?utf-8?B?UjJlZXV4NjdRTmJBdXh0dnQxazZiSlBxWWl4QUl6QUZLOWJWK2IxeGJ6RU5T?=
 =?utf-8?B?amxBM0xSem10UG40TzFwRTg1cE5HbXdHczRwL3BDSlNSUUlnNjd4cE01ZnVT?=
 =?utf-8?B?a3dPMUVOM1F5cjdQK0RtN1J0UHJJL2srS3J4dkNYNmo3VFFhQ090Z1FxZjQv?=
 =?utf-8?B?Zk9VTDRsSFBiZnJ0L0FIQmNIUTE5OXF2QzJ0YUVVQ2ZVc2ZPZnBqeFRzclZD?=
 =?utf-8?B?MkFWOFpMOWo0ZFJ6WUQyQUFVcFNXV2dkQ0N1eTdjaDgwVFRrd3ZmMkh0bm1W?=
 =?utf-8?B?TndjT3hwN0NCMmYvNUY3VGVyTlh1UTdlK28xR1J4Q0I4ZU1sZkpEcVZZY1B0?=
 =?utf-8?B?bngxM1F4RWtobFNHMUpXVUJSSmIxSUszL3AyTStERFhqa0YxNDYrQzBBN1J0?=
 =?utf-8?B?NlhuZVM5bVFibW5COE9CY2NHcE9VTmgzU0x1MXhIYVdhSVJHRjNrMVYxdVRu?=
 =?utf-8?B?TitwRDFOZTlqQ0hObnQvQjlMMy9kNkRvRWxPZ3FPUkR5K2JnNmlITUtoRmI3?=
 =?utf-8?B?WVIvODNIcXVkSXYwcUxtcUZycFd5SFRvbDNsQTRkQTUwUVFJb2xzNmZtM1Qr?=
 =?utf-8?B?WkN4U0dNYWlMMEhEaGQ4SHl3SFdENUg2cjNDMXlDcTFhQXVzVFdIV01PckJL?=
 =?utf-8?B?ckdKMmRkdXd1UVN1QWZJR2FKWDBmeUNrMzdoelNucFpaNmd2QVBLUkEwOTE1?=
 =?utf-8?B?djg2S3h3TkxOdlhhVG4xQ0RtT3pOWEdyYlVuUXFqQ1NKWHYzNzFEVFovZUwy?=
 =?utf-8?B?N2M5ekhFRExydDh3N1FjUFl0Wm9JUEdZSVRTZEdqUVAxMHNKUW4rcFlkeEpo?=
 =?utf-8?B?aFVBci9QUUcvUUVKWEhOTU1iSUZ4VGViMmNYOXUyT2lmK0hLbVVieUY3Y1BF?=
 =?utf-8?B?dDN6SjdBU2hUUUJMQzRodTZpWUpIZHEyRWQ2aXdod3B6a3R3WHJtQUR5SGc4?=
 =?utf-8?B?c1ozWWJuT3lxdytwVjkwU1NrOFNuRTVDcXRDZE4zWTVCV1F2dWFORnBFV0sy?=
 =?utf-8?B?VW16WUZlNU8zK3d1SXBoRFNDdHJzcWlKVnNIK3dBa2tveW1ad2xtU0FRTytJ?=
 =?utf-8?B?MEhPU1JzZTJucFJMYTFtaE4wVDIrUExJSXFzMTMwajBNTjRTbUxrWitrQ2Ro?=
 =?utf-8?B?WVhzanE3ZXdqelN4VnZGYzlwVnJhM1JKeTBKRTBBTzNLS0RmdExacERXdE9L?=
 =?utf-8?B?Y284Z3Q3ZFllR2orc3oycUprN0o0VlJQOFpTWGRma1hKakNrcnZFYkJvOVlO?=
 =?utf-8?B?QUJ2ck1UeGFhbGVnU05CMVVpUjJGbFB6YjQ5YTkweFIyQmFZakk2NWdlcjNC?=
 =?utf-8?B?ZXYrcnVoNW81aG9heWNvUFJzZGg1dVlxQVArdkVicnZhaWxZMERRYWdKbmRw?=
 =?utf-8?B?bWRrY1YzbzFGaWthdlNyMFp5dE0rYm9EeDlzazYvQXNhY3EwU0tZMjdXeGw5?=
 =?utf-8?B?OHJ6SGs4d0pNSDFRQko1NWFMM3JBem45MGErUkoxcGwxY2w1YW83ZW5Sd0gz?=
 =?utf-8?B?bGpsMVd6UXhPa2g4bS9KNTJsNGZOSlNuZ3ZWR1VBMVNIUVBac0VQQTh6M21N?=
 =?utf-8?B?NUxSei93cVJUM25uUFVYUzRVYkpUWUoxaHVndU1xbzJ4dkNZQ2V0eFRycWJi?=
 =?utf-8?B?OHloYVZ1QlB6Z0FzV2VOamVrMDZMREJBNW9zUllFR3N1NGo2RklDZnlEZFYr?=
 =?utf-8?B?dzVyRlRZOGJxMU5EUTFhcEdMeG55K0lZL0FyQnczTDNHdnlaRXIwcndFM2l0?=
 =?utf-8?B?djU3R2lyVExDc1BFVjhYNDlvdzdHd1BXaWVGL085LzZMaFhMdXdqeUlmVGwz?=
 =?utf-8?B?T21helpYL3cyc3Nad05GdUs1SjUxcCtRa2tac2lSMGI4eXZQb0hHVkxQZy84?=
 =?utf-8?B?RFFMRktEbG5hSiszQ0J6RlBRcXcySC9wVXBhN2Jrb3JEcmllaGdhNHQ5YVAv?=
 =?utf-8?Q?2D9ehRxYFhWX01PQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23D9F5D9E879F94CA4EED39AD03BB464@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039eecbf-1afc-48f5-1d59-08da478fef0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 07:41:14.2256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcbQ4PzoP+S9RJtvPoyJ3Cwb/bIkpivi0RSXIzjVmlL/uyQBYTIKqEdXFfsGMRxdDJoHnKnXKYAY1u8yMgpTgTbEgk3EtGS9BADCpUiEo7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDYuMjAyMiAxNTozMCwgTWlhb3FpYW4gTGluIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IHBsYXRmb3JtX2dldF9pcnEoKSByZXR1cm5zIG5l
Z2F0aXZlIGVycm9yIG51bWJlciBpbnN0ZWFkIDAgb24gZmFpbHVyZS4NCj4gQW5kIHRoZSBkb2Mg
b2YgcGxhdGZvcm1fZ2V0X2lycSgpIHByb3ZpZGVzIGEgdXNhZ2UgZXhhbXBsZToNCj4gDQo+ICAg
ICBpbnQgaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gICAgIGlmIChpcnEgPCAw
KQ0KPiAgICAgICAgIHJldHVybiBpcnE7DQo+IA0KPiBGaXggdGhlIGNoZWNrIG9mIHJldHVybiB2
YWx1ZSB0byBjYXRjaCBlcnJvcnMgY29ycmVjdGx5Lg0KPiANCj4gRml4ZXM6IGViMWYyOTMwNjA5
YiAoIkRyaXZlciBmb3IgdGhlIEF0bWVsIG9uLWNoaXAgU1NDIG9uIEFUMzJBUCBhbmQgQVQ5MSIp
DQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9xaWFuIExpbiA8bGlubXEwMDZAZ21haWwuY29tPg0KDQpS
ZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvbWlzYy9hdG1lbC1zc2MuYyB8IDQgKystLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21pc2MvYXRtZWwtc3NjLmMgYi9kcml2ZXJzL21pc2MvYXRtZWwtc3Nj
LmMNCj4gaW5kZXggZDZjZDU1MzcxMjZjLi42OWY5YjAzMzY0MTAgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbWlzYy9hdG1lbC1zc2MuYw0KPiArKysgYi9kcml2ZXJzL21pc2MvYXRtZWwtc3NjLmMN
Cj4gQEAgLTIzMiw5ICsyMzIsOSBAQCBzdGF0aWMgaW50IHNzY19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShzc2MtPmNs
ayk7DQo+IA0KPiAgICAgICAgIHNzYy0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsN
Cj4gLSAgICAgICBpZiAoIXNzYy0+aXJxKSB7DQo+ICsgICAgICAgaWYgKHNzYy0+aXJxIDwgMCkg
ew0KPiAgICAgICAgICAgICAgICAgZGV2X2RiZygmcGRldi0+ZGV2LCAiY291bGQgbm90IGdldCBp
cnFcbiIpOw0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsNCj4gKyAgICAgICAgICAg
ICAgIHJldHVybiBzc2MtPmlycTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIG11dGV4X2xv
Y2soJnVzZXJfbG9jayk7DQo+IC0tDQo+IDIuMjUuMQ0KPiANCg0K
