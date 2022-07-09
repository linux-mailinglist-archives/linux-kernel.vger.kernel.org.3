Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC07B56CA99
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiGIQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGIQVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:21:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB53746D83;
        Sat,  9 Jul 2022 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657383715; x=1688919715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BbikTAbR94v++TvK7V/eKJYBizm9SjPH8+tkNzaRGQU=;
  b=fDfRaf41mX02EiybpSdbQG1a1NBKIUrTPNdijy74UZ5y2s+7XzGf4Ny3
   lZrIQ3nFn2JWtSocDcWihYyFS1avP2l/jh37RjNSBypAWSGEu98ZoeBHo
   kj+rHM3zuHqdCNoRqFeDfDCUekb3wkIFr2NsC+b7uDu7bwH5nHL3FOlRL
   a6uhDXzXrjbu+wBuATE5XofacmyvVY8xrAF0weAd4TV0OJoKnwozoN+2M
   lDPGqvsfxryyGTmAh9tXnquJhRM/CqaTSyqwxhpcfy8ElDshH5q3eqCDJ
   VkaoJaVCctn3RIrctbaF0BcLfzRYYlqaKp6CD91B9Qvp9ju8ULvPM7Hbv
   A==;
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="171451162"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2022 09:21:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 9 Jul 2022 09:21:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sat, 9 Jul 2022 09:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cez2TbiYitFBLpOZJCUbA6iueSsitNxYtrr7mFYy7Fmbuq23nFMep2MxM1MLZojT0Gdk+gHsGgtSZTUC87i7wiu9paETBqNkmM7HXJKqIOfCqbwCb+s3exiOEgBszxJ6uTyRboFkopNqLKT6ahnaEN58dikBLqwggPXwCth1APzEDDk+zw7cWHGVq4VyLcG3YAAoBQlqIgW9cmVmDUQ0pKy/zupAfPmjfxO7Mz/s8+hpxz2vlezu16o8y26HoT9gsQ8vkvnTLvUgIchz5393IQHmTvBRwoF8qJ97WtMFvorwOBtFClVTWkh9XHGKjODGTYkmzS/oznKU5d4TZi+aYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbikTAbR94v++TvK7V/eKJYBizm9SjPH8+tkNzaRGQU=;
 b=O2SDPUsgGwRLkAxaLsPVF7cA0SLm/si9R0da5ZWL8jRmvGC2JuhQmAcw3xoFkKOLVPyqh5lsUtv4q5BMvPsQhSnDSFl2JCjZGKTv5eKMpBRbASIHI0EvN6rCOV81RJsKGTMDgz7ZKZ+4/KhfJWdn3jWmqr+I5C+dTiCyANjxwDsbG9h1RMeNlkRicF/ujgdoocKMm2FzpxtzWl5r81KYtOPzBrWgTHz/zbMMyuSxZYNuyGvDclPPbx+I5ZR5BRj4FJvLn42LiUgblZx7ZCp93dMOTmFDk7Jy4Za8s8+jK1J5i2RFHDB8orMr04qDifxSDytk1JGLQqUukOwYVNZAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbikTAbR94v++TvK7V/eKJYBizm9SjPH8+tkNzaRGQU=;
 b=WNsgSm+18kfcHD0+sTPj0+EoQ/Yac2uroq7xb1mXjXRl5D5YX4RDAH46dzVxHF1tlnzf6atC/tINn86wEq8uBE2EflWscXAv+ecIXdLtZL+Uw3iTfLl4lrQYWz17Nb5w1I4NiEC0wVtj9ntYD+ivjeQPjZPV9i48bOkgbCD6b80=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1853.namprd11.prod.outlook.com (2603:10b6:300:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sat, 9 Jul
 2022 16:21:47 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.025; Sat, 9 Jul 2022
 16:21:46 +0000
From:   <Conor.Dooley@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <Conor.Dooley@microchip.com>
CC:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Daire.McNamara@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 3/4] pwm: add microchip soft ip corePWM driver
Thread-Topic: [PATCH v5 3/4] pwm: add microchip soft ip corePWM driver
Thread-Index: AQHYktiKMJrSlPtjv0SK+U5DwIwspK12NMcAgAAFfoA=
Date:   Sat, 9 Jul 2022 16:21:46 +0000
Message-ID: <f2720cc9-be02-f457-7e8e-0d6b3845477c@microchip.com>
References: <20220708143923.1129928-1-conor.dooley@microchip.com>
 <20220708143923.1129928-4-conor.dooley@microchip.com>
 <20220709160206.cw5luo7kxdshoiua@pengutronix.de>
In-Reply-To: <20220709160206.cw5luo7kxdshoiua@pengutronix.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be4db90f-bfa3-43ac-bc6e-08da61c71e84
x-ms-traffictypediagnostic: MWHPR11MB1853:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xigzjqezk00rhrrmNQc8RE9Rraxu7AJRNC0FK7SpaJOgTWoKzBxuR+KYQcubZTNbn2ZMuSMizrvVsXY6mHyHEzsWGpUVrwKBVa6fJ/VGYkWnYm/FNZspfY2llzTRtUHnz79h6DxNCJkmY/9WSjYZ0wloM/m0BhF4uhLVYteBSu8vevh9Q4xCWm5IyDtDyLst0K8BSyjmACZr/kqWwK2VdHA39iVtql7ArYGwGKp4dEOk0bFpgyGsYjCnPeuP0sW/WK+BpYQt8otJfZWdzPZbKlf/sYaA9OcZNxjlIltI719Ds60VPAXXnc7LMtVVJw+Gj7JFSOf4nGe0ycDbP4wKvNydu8V+Sn2YGgzz13FH1FNolL4cLbJ8hFFP1eCeSjrWrRZlh6UjJ6UzX/zuvAbIAju1tYlUcP9DPagvowHibyJzmT25DjL0g35oFyOHzpBaNm3q4DUcJLNd1rL6wP9qRLIIrpMx8IbtRSNcLw0PWwmiz2QLLFncxgGir8MCwmqagCr8Nhiayje5m/VCL+3YXlGYGRVPhImSlg9HmQ3F3s9K4Oi5pmza3ZJG1kl3okLevkoymFY/5CwybLZ8ZMMGMlxmE8Q9lISUKahyeWKttJBrFipK0UXg2szephYKHhTDzsGi7dewHhbzx7UXFI+uWpXKyu3jQMdbnoHftqQ/esVM0d++HKAmnJh6rvDEE7qmCG7ZEaiZmdDcUM/HSI+zOzZhDWcYJ39i+GPNO3wdC73p9NGq5aGqq13YJWS2SwwBSt+cb0i1DBMAKZnSM3ssND4JJtIg5P7fysoJbkZ8bwTI/tFHSatYJgyd6E+xgGwcT/4//q/uwvBnqjDOihQpunsAHez9qNamtmJgJvU4SJEHxXBPSFQBaTQIZXGzRkhW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(346002)(366004)(376002)(8676002)(66446008)(66476007)(64756008)(71200400001)(4326008)(76116006)(91956017)(66946007)(66556008)(478600001)(6486002)(26005)(83380400001)(8936002)(5660300002)(6512007)(122000001)(186003)(110136005)(6506007)(54906003)(86362001)(316002)(41300700001)(38100700002)(53546011)(31696002)(2906002)(38070700005)(36756003)(66574015)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1lDb3BDbmpmZmd2QzlFMDVFVFg1cGlJRUp4YU9rV1lIMFhqV0xiQzMzRWw3?=
 =?utf-8?B?YkJZemxDS3FQdE5MT0N5R3hpOWM5N3l1eFB3ZWhYNTlkREp3T204Sk1zdjRv?=
 =?utf-8?B?NFAvbE9lMklQQjM0TzBBdnFrQytzU0pZU2dsNGxnRHVlMFRNazhQcWg2M29h?=
 =?utf-8?B?WkpRVHFtM09TM21BelB1Ynprdk1Zd000QUZKZFpLQldrTTNTM2Q3bGV4bUJU?=
 =?utf-8?B?UHVhNTFHVzlaU2NTWk1hSStUWDNwSks1OFh5VEZjQUtPS2ZPT1h3V1BYUVNu?=
 =?utf-8?B?SkJYOUh6UHNNSTBHQWhMWXJiZXgzN1I4QkpITmRRMGNOMHNJYjhTTjNMUkJn?=
 =?utf-8?B?RUxRV0tqbmszUEhLTVczTDdYWWdhQlI1aWxSTE1JT2FzRWZtRlJNN2V0MUVG?=
 =?utf-8?B?M2wrK0lpOWd4L3U0T2ZSL2d2akpIS3N2NlJpaVNYSWd1TVd4SVNFOThvYm45?=
 =?utf-8?B?MWVzWVlaNkhkUDBPcWEvSFE2clZKQ2NGRjJQKyt1YS9QSGx2MUtoa203TGIv?=
 =?utf-8?B?WW1kb1Q3WW9xa1QvQTJyQWpSdktibnpLSFlYZHRpeDM4cXBSdk5PZVlZV3BD?=
 =?utf-8?B?bmVlMno3UWJIUHZsby9zTjgvUHBUTWRiQUFXTXAwTlpYL2tuVUU1d2VNQ2ZY?=
 =?utf-8?B?SjhqMk9xTE5vY0NWOHE0aTUzSFFOQU0vYWIzVjhCaXBKQjBERmhFRVdnS2do?=
 =?utf-8?B?bDc4RDUwMU94OEMzblF1anJNR2hhYTcxZFhOb0JJQk9paVc5YnBwU1NwQ3RC?=
 =?utf-8?B?WWc1czMwTllvT1V0TklKZGtGSzkvNjQwQ01xVXBFVnIwQ0h6a244ajZyVUQx?=
 =?utf-8?B?bUg2QUkwTGhxc08weklVQ3RNMlRsVXZhRkV5M1drM1ZqTmVHWDdlbVByeGky?=
 =?utf-8?B?aEplVU10WWliK2FuQWpOQWE1em1sdDRsNjVwVDByZ0RjWXk0TXpWSnZIQ3pZ?=
 =?utf-8?B?QXRYWEhOdk1sWDJna05UUVBZS1JMMktZeXJ3a3FvcnhYaUZIMHpsNUhsRUg0?=
 =?utf-8?B?K0I0d2hlUFRLS21WNXVqTXpMWVZFKzhRYkJsSXBGYzlYT3hDSWtLVmlUTy81?=
 =?utf-8?B?S0JWbS9JalRQMW5nL1NtbTYzSUhuTWxwRSthT3Z0Y1JzUElzQ1hQQ0poUnBD?=
 =?utf-8?B?L1AxMTh3WENGbTBKdUtWVHJCRUEweGdTdytZUnN4OHRoZytjOWxGMjJkbjV6?=
 =?utf-8?B?ejFGMkZqWXpIY0lZRGRmN3djV3diRENZRUcrdHpwT1BqVjVuNlpabDNCeU9h?=
 =?utf-8?B?c2xmL0JyZU9xZDlXQVFZanp3QXFkbURpWGxRbTI5TEJHYzhwdlR6ek9rTyt3?=
 =?utf-8?B?VU5lQUlLeEl6UEJrZGJCSms3SzdxbGcyMzY5ay9UY0ZhWTJISkFMdWh2VmZ1?=
 =?utf-8?B?VE5tOVZJMkdLV0pZalUzQnY4U2xpVEhCT3BDc0hydTFkZnBVUjlxK2l4MkFI?=
 =?utf-8?B?VkVCNldVNThHaUR1MjRtcjlIYmY3SDhuNC8rTnBSbG9YeGNZdHNqTEZRaWpJ?=
 =?utf-8?B?bDRyMURlaTVBZmJob052YkxqVGROZUJEK2pURDRYOHJHcHlYdndDeVJDaGFi?=
 =?utf-8?B?VG5IVlc0L1NLL0Nzc2F4Z1llYU5xNUcxTE50eFVSLzlHRHM1NUhBUS84cjBN?=
 =?utf-8?B?a1NGQStzNzIxTlNZR2MxcXU1ZkVXOGJyNStLNXRJVkFKaWpTMkNtanFhUHhh?=
 =?utf-8?B?Y2gyYmxGWHhlTTZjanZHMXp5dytWeThpKzN4cFZkZ3dsaEVkMExCZkdUQTZK?=
 =?utf-8?B?RFRyVStVbXRRUks1bXR4QXhXcFRTd0I3Z2l1c0w1cEo2YkZKVUM0dGVYZVZo?=
 =?utf-8?B?VzVoQThSSXFwb3piV0FNbTNwTUNSczFTVEZDTjdkZ1dka1lNZ1h4UWRtcVZZ?=
 =?utf-8?B?ZUg4YzhiN1pITCtsVFpHRWdLK0hRc0V6aVZtSitpS3krWGhNS1ZHU1kyUHhu?=
 =?utf-8?B?Z2lPVGpkaDdibHh5Tmt3a3VjQWc1ZG8vaXozYmJqNWxaYUkxTU9vLzlkY2d1?=
 =?utf-8?B?SURXbEhlT0pZK0NabFViTzRzYlNIZVZqVkk5R2Q0OHFaK0I3ckFlWWNRL0NC?=
 =?utf-8?B?UWhKbFI0d0d2SWdJbWI4Ylgyajl1bEdITkVtalFNL1FRT3M5a0FtcERlQzZw?=
 =?utf-8?Q?zUH3VxXhqNdF24WJlY1YvbEMk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCDEE1C11C0BF542A37C4F8ABE2AE759@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4db90f-bfa3-43ac-bc6e-08da61c71e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 16:21:46.4435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nk0J+UQNoqwdvyGWp7n1TDx7XI3WIe4kF+JWcXSbnIUGb+MdqRjIaxB//hMJ0gJwrnYxxBjIbCcCBNhXdXIKcfqUVgXjRQLuWKdnhVUzYyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1853
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDcvMjAyMiAxNzowMiwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEhlbGxvIENv
bm9yLA0KPiANCj4gT24gRnJpLCBKdWwgMDgsIDIwMjIgYXQgMDM6Mzk6MjJQTSArMDEwMCwgQ29u
b3IgRG9vbGV5IHdyb3RlOg0KPj4gQWRkIGEgZHJpdmVyIHRoYXQgc3VwcG9ydHMgdGhlIE1pY3Jv
Y2hpcCBGUEdBICJzb2Z0IiBQV00gSVAgY29yZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25v
ciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KLS0tODwtLS0NCj4+ICsJbWNo
cF9jb3JlX3B3bV9hcHBseV9kdXR5KGNoaXAsIHB3bSwgc3RhdGUsIHByZXNjYWxlLCBwZXJpb2Rf
c3RlcHMpOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBOb3RpZnkgdGhlIGJsb2NrIHRvIHVwZGF0
ZSB0aGUgd2F2ZWZvcm0gZnJvbSB0aGUgc2hhZG93IHJlZ2lzdGVycy4NCj4+ICsJICogVGhlIHVw
ZGF0ZWQgdmFsdWVzIHdpbGwgbm90IGFwcGVhciBvbiB0aGUgYnVzIHVudGlsIHRoZXkgaGF2ZSBi
ZWVuDQo+PiArCSAqIGFwcGxpZWQgdG8gdGhlIHdhdmVmb3JtIGF0IHRoZSBiZWdpbm5pbmcgb2Yg
dGhlIG5leHQgcGVyaW9kLiBXZSBtdXN0DQo+PiArCSAqIHdyaXRlIHRoZXNlIHJlZ2lzdGVycyBh
bmQgd2FpdCBmb3IgdGhlbSB0byBiZSBhcHBsaWVkIGJlZm9yZSBjYWxsaW5nDQo+PiArCSAqIGVu
YWJsZSgpLg0KPj4gKwkgKi8NCj4+ICsJaWYgKG1jaHBfY29yZV9wd20tPnN5bmNfdXBkYXRlX21h
c2sgJiAoMSA8PCBwd20tPmh3cHdtKSkgew0KPj4gKwkJd3JpdGVsX3JlbGF4ZWQoMVUsIG1jaHBf
Y29yZV9wd20tPmJhc2UgKyBNQ0hQQ09SRVBXTV9TWU5DX1VQRCk7DQo+PiArCQl1c2xlZXBfcmFu
Z2Uoc3RhdGUtPnBlcmlvZCwgc3RhdGUtPnBlcmlvZCAqIDIpOw0KPj4gKwl9DQo+PiArDQo+PiAr
CXNwaW5fdW5sb2NrKCZtY2hwX2NvcmVfcHdtLT5sb2NrKTsNCj4+ICsNCj4+ICsJbWNocF9jb3Jl
X3B3bV9lbmFibGUoY2hpcCwgcHdtLCB0cnVlKTsNCj4gDQo+IEkgYWxyZWFkeSBhc2tlZCBpbiB0
aGUgbGFzdCByb3VuZDogRG8geW91IHJlYWxseSBuZWVkIHRvIHdyaXRlIHRoZQ0KPiBTWU5DX1VQ
RCByZWdpc3RlciB0d2ljZT8gSSB3b3VsZCBleHBlY3QgdGhhdCB5b3UgZG9uJ3Q/IQ0KDQpTb3Jy
eSwgSSB0aG91Z2h0IHRoYXQgSSBoYWQgcmVwbGllZCB0byB0aGlzIG9uIEZyaWRheSwgZGlkbid0
DQptZWFudCB0byBpZ25vcmUgeW91Lg0KDQpZZXMsIEkgZG8gbmVlZCB0byBrZWVwIHRoYXQgLSBv
dGhlcndpc2UgdGhlcmUgYXJlIHByb2JsZW1zIHdoZW4NCnR1cm5pbmcgb24gdGhlIFBXTSBjaGFu
bmVsIGZvciB0aGUgZmlyc3QgdGltZS4NCkJlZm9yZSB3cml0aW5nIHRvIHRoZSBlbmFibGUgcmVn
aXN0ZXJzLCB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0DQp0aGUgdmFsdWVzIGhhdmUgYmVlbiBh
cHBsaWVkIHNpbmNlIGJvdGggcG9zIGFuZCBuZWcgZWRnZSByZWdpc3RlcnMNCmNvbWUgb3V0IG9m
IHJlc2V0IHNldCB0byAweDAuDQoNCj4gDQo+IEFsc28gdGhlIGxvY2tpbmcgbG9va3MgZmlzaHkg
aGVyZS4gSXQgd291bGQgYmUgc2ltcGxlciAoYW5kIG1heWJlIGV2ZW4NCj4gbW9yZSByb2J1c3Qs
IGRpZG4ndCB0aGluayBkZWVwbHkgYWJvdXQgaXQpIHRvIGFzc3VtZSBpbg0KPiBtY2hwX2NvcmVf
cHdtX2VuYWJsZSgpIHRoYXQgdGhlIGNhbGxlciBob2xkcyB0aGUgbG9jay4gVGhlbiB5b3Ugb25s
eQ0KPiBncmFiIHRoZSBsb2NrIG9uY2UgZHVyaW5nIC5hcHBseSgpIGFuZCBub3RoaW5nIHN0cmFu
Z2UgY2FuIGhhcHBlbiBpbiB0aGUNCj4gZ2FwLg0KPiANCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0K
Pj4gKw0KPj4gK3N0YXRpYyB2b2lkIG1jaHBfY29yZV9wd21fZ2V0X3N0YXRlKHN0cnVjdCBwd21f
Y2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCj4+ICsJCQkJICAgIHN0cnVjdCBw
d21fc3RhdGUgKnN0YXRlKQ0KPj4gK3sNCj4+ICsJc3RydWN0IG1jaHBfY29yZV9wd21fY2hpcCAq
bWNocF9jb3JlX3B3bSA9IHRvX21jaHBfY29yZV9wd20oY2hpcCk7DQo+PiArCXU4IHByZXNjYWxl
LCBwZXJpb2Rfc3RlcHMsIGR1dHlfc3RlcHM7DQo+PiArCXU4IHBvc2VkZ2UsIG5lZ2VkZ2U7DQo+
PiArCXUxNiBjaGFubmVsX2VuYWJsZWQ7DQo+PiArDQo+IA0KPiBJJ2QgdGFrZSB0aGUgbG9jayBo
ZXJlIHRvIGJlIHN1cmUgdG8gZ2V0IGEgY29uc2lzdGVudCByZXR1cm4gdmFsdWUuDQo+IA0KPj4g
KwljaGFubmVsX2VuYWJsZWQgPSAoKCh1MTYpcmVhZGJfcmVsYXhlZChtY2hwX2NvcmVfcHdtLT5i
YXNlICsgTUNIUENPUkVQV01fRU4oMSkpIDw8IDgpIHwNCj4+ICsJCXJlYWRiX3JlbGF4ZWQobWNo
cF9jb3JlX3B3bS0+YmFzZSArIE1DSFBDT1JFUFdNX0VOKDApKSk7DQo+IA0KPiBtaWNybyBvcHRp
bWlzYXRpb246IFlvdSdyZSByZWFkaW5nIHR3byByZWdpc3RlciB2YWx1ZXMgaGVyZSwgYnV0IG9u
bHkgdXNlDQo+IG9uZS4gU2hhZG93aW5nIHRoZSBlbmFibGVkIHJlZ2lzdGVycyBpbiBtY2hwX2Nv
cmVfcHdtIG1pZ2h0IGFsc28gYmUgYW4NCj4gaWRlYS4NCj4gDQo+PiArCWlmIChjaGFubmVsX2Vu
YWJsZWQgJiAxIDw8IHB3bS0+aHdwd20pDQo+IA0KPiBJJ20gYWx3YXlzIHVuc3VyZSBhYm91dCB0
aGUgYXNzb2NpYXRpdml0eSBvZiAmIGFuZCA8PCwgc28gSSB3b3VsZCBoYXZlDQo+IHdyaXR0ZW4g
dGhhdCBhcw0KPiANCj4gCWlmIChjaGFubmVsX2VuYWJsZWQgJiAoMSA8PCBwd20tPmh3cHdtKSkN
Cj4gDQo+IEkganVzdCB0ZXN0ZWQgdGhhdCBmb3IgdGhlIHVtcHRlZW5zIHRpbWUgYW5kIHlvdXIg
Y29kZSBpcyBmaW5lLCBzbyB0aGlzDQo+IGlzIG9ubHkgZm9yIGh1bWFuIHJlYWRlcnMgbGlrZSBt
ZS4NCj4gDQo+PiArCQlzdGF0ZS0+ZW5hYmxlZCA9IHRydWU7DQo+PiArCWVsc2UNCj4+ICsJCXN0
YXRlLT5lbmFibGVkID0gZmFsc2U7DQo+PiArDQo+PiArCXByZXNjYWxlID0gUFJFR19UT19WQUwo
cmVhZGJfcmVsYXhlZChtY2hwX2NvcmVfcHdtLT5iYXNlICsgTUNIUENPUkVQV01fUFJFU0NBTEUp
KTsNCj4+ICsNCj4+ICsJcG9zZWRnZSA9IHJlYWRiX3JlbGF4ZWQobWNocF9jb3JlX3B3bS0+YmFz
ZSArIE1DSFBDT1JFUFdNX1BPU0VER0UocHdtLT5od3B3bSkpOw0KPj4gKwluZWdlZGdlID0gcmVh
ZGJfcmVsYXhlZChtY2hwX2NvcmVfcHdtLT5iYXNlICsgTUNIUENPUkVQV01fTkVHRURHRShwd20t
Pmh3cHdtKSk7DQo+PiArDQo+PiArCWR1dHlfc3RlcHMgPSBhYnMoKHMxNilwb3NlZGdlIC0gKHMx
NiluZWdlZGdlKTsNCj4gDQo+IElmIGR1dHlfc3RlcHMgPT0gMCB0aGUgcmV0dXJuZWQgcmVzdWx0
IGlzIHdyb25nLiBJIHN1Z2dlc3QgdG8gZml4IHRoYXQsDQo+IGF0IGxlYXN0IG1lbnRpb24gdGhl
IHByb2JsZW0gaW4gYSBjb21tZW50Lg0KDQpBaCByaWdodCB5ZWFoLCBJIGRpZG4ndCB1cGRhdGUg
dGhpcyBhZnRlciBjaGFuZ2luZyB0aGUgb3RoZXIgbG9naWMuIFNvcnJ5Lg0KDQo+IA0KPj4gKwlz
dGF0ZS0+ZHV0eV9jeWNsZSA9IGR1dHlfc3RlcHMgKiBwcmVzY2FsZSAqIE5TRUNfUEVSX1NFQzsN
Cj4gDQo+IENhbiB0aGlzIG92ZXJmbG93Pw0KPiANCj4+ICsJZG9fZGl2KHN0YXRlLT5kdXR5X2N5
Y2xlLCBjbGtfZ2V0X3JhdGUobWNocF9jb3JlX3B3bS0+Y2xrKSk7DQo+IA0KPiBXaGF0IGlzIHRo
ZSB0eXBpY2FsIHJldHVybiB2YWx1ZSBvZiBjbGtfZ2V0X3JhdGUobWNocF9jb3JlX3B3bS0+Y2xr
KT8NCg0KSXQncyBnb25uYSBiZSBsZXNzIHRoYW4gNjAwTQ0KPiBZb3UgbmVlZCB0byByb3VuZCB1
cCBoZXJlLiBEaWQgeW91IHRlc3QgeW91ciBkcml2ZXIgd2l0aCBQV01fREVCVUcgb24/DQo+IER1
cmluZyB0ZXN0IHBsZWFzZSBkbyBmb3IgYSBmZXcgZml4ZWQgcGVyaW9kczoNCj4gDQo+IAlmb3Ig
ZHV0eV9jeWNsZSBpbiBbMCAuLiBwZXJpb2RdOg0KPiAJCXB3bV9hcHBseShteXB3bSwgey5wZXJp
b2QgPSBwZXJpb2QsIC5kdXR5X2N5Y2xlID0gZHV0eV9jeWNsZSwgLmVuYWJsZWQgPSB0cnVlLCAu
Li59KQ0KPiANCj4gCWZvciBkdXR5X2N5Y2xlIGluIFtwZXJpb2QgLi4gMF06DQo+IAkJcHdtX2Fw
cGx5KG15cHdtLCB7LnBlcmlvZCA9IHBlcmlvZCwgLmR1dHlfY3ljbGUgPSBkdXR5X2N5Y2xlLCAu
ZW5hYmxlZCA9IHRydWUsIC4uLn0pDQo+IA0KPiBhbmQgY2hlY2sgdGhlcmUgaXMgbm8gb3V0cHV0
IGNsYWltaW5nIGEgbWlzY2FsY3VsYXRpb24uDQoNCkkgcmFuIHRoZSBzdHVmZiB5b3UgZ2F2ZSBt
ZSBsYXN0IHRpbWUsIGRvaW5nIHNvbWV0aGluZyBzaW1pbGFyIHcvIGENCnNoZWxsIGxvb3AuIEdv
dCBubyByZXBvcnRlZCBtaXNjYWxjdWxhdGlvbnMuDQpJJ2xsIGFkZCBleHBsaWNpdCByb3VuZGlu
ZyB0aG91Z2guDQoNCj4gDQo+PiArCXN0YXRlLT5wb2xhcml0eSA9IG5lZ2VkZ2UgPCBwb3NlZGdl
ID8gUFdNX1BPTEFSSVRZX0lOVkVSU0VEIDogUFdNX1BPTEFSSVRZX05PUk1BTDsNCj4+ICsNCj4+
ICsJcGVyaW9kX3N0ZXBzID0gUFJFR19UT19WQUwocmVhZGJfcmVsYXhlZChtY2hwX2NvcmVfcHdt
LT5iYXNlICsgTUNIUENPUkVQV01fUEVSSU9EKSk7DQo+PiArCXN0YXRlLT5wZXJpb2QgPSBwZXJp
b2Rfc3RlcHMgKiBwcmVzY2FsZSAqIE5TRUNfUEVSX1NFQzsNCj4+ICsJZG9fZGl2KHN0YXRlLT5w
ZXJpb2QsIGNsa19nZXRfcmF0ZShtY2hwX2NvcmVfcHdtLT5jbGspKTsNCj4gDQo+IHlvdSBuZWVk
IHRvIHJvdW5kIHVwIGhlcmUsIHRvby4NCj4gDQo+IChUaGUgcmVhc29uaW5nIGZvciB0aGUgcm91
bmRpbmcgZGlyZWN0aW9uIGlzIHRoYXQgYXBwbHlpbmcgdGhlIHN0YXRlDQo+IHJldHVybmVkIGJ5
IC5nZXRfc3RhdGUoKSBzaG91bGQgbm90IGNoYW5nZSB0aGUgaHcgc2V0dGluZ3MuIElmIHlvdSBy
b3VuZA0KPiBkb3duIGluIGJvdGggLmFwcGx5KCkgYW5kIC5nZXRfc3RhdGUoKSB0aGlzIGRvZXNu
J3Qgd29yay4pDQo+IA0KPj4gK30NCj4+ICsNCg0KVGhlIHJlc3Qgb2YgdGhpcyBhbGwgc2VlbXMg
ZmFpciB0byBtZSAmIEknbGwgc3BpbiB1cCBzb21ldGhpbmcNCmluIHRoZSBjb21pbmcgd2Vlay4N
ClRoYW5rcywNCkNvbm9yDQoNCg==
