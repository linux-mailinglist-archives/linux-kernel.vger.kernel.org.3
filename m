Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4633C576DC5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGPMRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGPMRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:17:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94E1EC7A;
        Sat, 16 Jul 2022 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657973867; x=1689509867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8YxLicKQLU4Fu9/DsM/F1mmF3g4m3Q8Z6AbygG9ddgQ=;
  b=f10+s9bGxplIBx54lOEyTjkYzTNx7vw9sJVZCJ1UkvRUrrkWVCNfapmy
   P8kSl6ivHWKM+w3SqB+bSMjxWmVnWcrWSQDHX5awaV3JdxWZbVb9sIv76
   ifxdffQ0S+f07mf7IrLXVNd+GLG/m8koXQG9EDH1s21MtWT5nlS4Rd5BV
   OqNSpK68NIm4Q7tHYkYaXehHzvdSzsLsNbmdBZDgQz+/9dDWK+mcVelIq
   wdxKBMAqpOqNuPWx8PTvZBpoTwKZwY+zExZa0+og4+6a4s20iA7FAqy0I
   tsfbyyou8daTKe4GX9qlofljrf5wgARcHjsgqszKzrc34XTxaQQMzy90k
   w==;
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="172392818"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2022 05:17:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 16 Jul 2022 05:17:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sat, 16 Jul 2022 05:17:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez6FKezZ49zc3owwmAAHrFz+iXqRUadUj3JXIoE9sXDOr3slJichXV9PkBhc4lPAEnjponOFbFz6QUlE4o61rHQVTEOOJlQ10nqE8qTY22/4fMjCQG1wit8NM0lIWwFtiJZAHtfoNzi5G6KCd1PQ4SF04ZQBCEIR9dNeeG9p/cH6kzvrvyKOLyvePXRVy1xen9MbPEtWTY1u2EkXCzDWof3SGUrRmL3dW3dgO7xzs7uSQaWFYNZ8yAkiMUanHKhLreUUDTO7t6iqYNNt/L8FYtNtfjP5SdbF3v3GqOsOkRx5VfK2bM1sxkfXNiLhFkUxUs4G3pwWOq/0JUf7jxc3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YxLicKQLU4Fu9/DsM/F1mmF3g4m3Q8Z6AbygG9ddgQ=;
 b=RI18BUIi7+0DNDK5gC2IYh+K2tWctqBLXV5q2cYHC5hLFss/wy3cCEc8hJ8JUp0JfJ1Y9yrwOyaVdK9upqzyaL1CBIYI0scG8Aiby+b7YtDBBonqyvBRbSOkroCknqsuJX9QPPBeKTcTAg6pHyE7GE8hCOPEBrr0EBAqbnqU9LH2bG0WpGHOC/KyrithiBvzwk+SjBgfRmoi8tise1A24aA4lWdQsedoai3tZSUDt2d4KN8h3wvqiHLJoHOtn7umEsVv6ml82cshcKa/3Rvr4cpSrL75sPi8FGckP+OktJXID/ybxcf5Hnro3Q/0XtjSVV6AVA2MPy6Zrb6WCHe50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YxLicKQLU4Fu9/DsM/F1mmF3g4m3Q8Z6AbygG9ddgQ=;
 b=oOXGKyUMgjJzHnMnxnUvECWg6rboFnuwzAT09E5T7E1BG5kTzSpk2U8fmHCdf8/MxHmY3pB74d0e99sv8d6iU2v7F/rqhrsaZXGN3bhXBVIx4cIcXAkGd6mUcvFt+1RcvA1MuAa0A2flBAuS6lXxOrNYkLpAxiGk2/NjqDNqtH0=
Received: from PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 by PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Sat, 16 Jul
 2022 12:17:36 +0000
Received: from PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928]) by PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928%7]) with mapi id 15.20.5417.026; Sat, 16 Jul 2022
 12:17:36 +0000
From:   <Lewis.Hanly@microchip.com>
To:     <maz@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <Conor.Dooley@microchip.com>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYmONEe8u9iky0lEWQnR2PO9enTa2A0EIAgAAaB4A=
Date:   Sat, 16 Jul 2022 12:17:36 +0000
Message-ID: <6ac50f6a-684d-d2b3-a32d-97635abdff13@microchip.com>
References: <20220716071113.1646887-1-lewis.hanly@microchip.com>
 <20220716071113.1646887-2-lewis.hanly@microchip.com>
 <87pmi549rp.wl-maz@kernel.org>
In-Reply-To: <87pmi549rp.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b086bb2-4dc0-49b0-2e4e-08da67252b70
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/yVrFn7TY60zylUvLwDudSovnS/5yrsYgTfM0vbh0SqNs04bLwSxwLjHhi1GS2bsNpua/6fYlNh+hTDEsTb6kd6Ts/iXw4ao668gHZ2MbAI2aZzAgG9AeUwe1b48OsosYy1Vd8WhuLJpyQQMO6kfIn7EfDhKzh4Qq8WINydOE72Re+RYip4TaRJ1jd+/NRBp/BscfVZqu+1KVo3GwGVL4S9YsCwh9abDAu1zvsE85nFVC3B1P/NBS48wiEmdcxxMqo0U0N2u17wiZlMKkLHKY6F6R+6JrPvJ6zPFlt40Q1+Dk5l12ovbaHJPY4aMetMQE5389UDIKCDA/KcQpO0qMnIybMMwVHwD8WBW85/MnoeVuCLryykCtSWW3OXSFHhVwRYdE4TZeKRSoOCc2FdZi1+k4tfRiLyoF59IFwOzmJ4zOluF00Sw/WANpXTwojbviUY1bJ/9vPlRfK4Z4aJPmIs+H8WT4l9NlLUD133GfJx2x8RqnmQazF5vSbFxeU+KhkofFJR51DY6sMMPYxl5oT3Zz+23PWSvjEglhWq5TVVqYCsqLuEUjUf33ZssMb/aCbq9z25oB/erb2xk6+eLoEpJtPnt7cv88x0LWPQmI43UdIbEwMRxkTCfNQMz4N24Pqqzvblf7PaAu38tnh8VDsBcN8QIrhCYRZAS92xmu8VIkVfC5sl3rEcCx8/kDd/rGUGcZLYMkaRn934SSizIXqubQpEhLcpF5sG4iYpN2Zjp+Y4+WzKubf7vHD4MIOTq+hEOI1b20yAqo8BZ6kFBH/z/iTmgMiCRRoQTZxmFGKl8DvJcy+Qo5RndoRVbbsavy9DSgm8RJXUmWuWYX4K20nN7uzbdF5AhNRAeTNrq0xFL1WU/uykHyA0PGsB5w9Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(136003)(39860400002)(396003)(2616005)(107886003)(186003)(2906002)(53546011)(41300700001)(6506007)(6512007)(26005)(83380400001)(38100700002)(38070700005)(122000001)(31686004)(31696002)(86362001)(66946007)(8676002)(4326008)(66476007)(66556008)(66446008)(64756008)(76116006)(71200400001)(5660300002)(91956017)(36756003)(478600001)(6486002)(8936002)(54906003)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjUzSWdpb2dPbFhUdmdUTnQybDh4MC9nblNxcHlQU2xhVFZodkdPNGJuNXBx?=
 =?utf-8?B?Tm5jUmpYRFpFWGlLZXU1ckhQa1U0ZVdrTE9Sdk9xOHlOVkR4MmF6SkFGVnVL?=
 =?utf-8?B?SkYrekR1bDVLWHhtbXJ0WGVZWXBKK3pvSmZIR3l0T3U5MFdSNEJ0NkF4Z0ds?=
 =?utf-8?B?NVh6QVNmSXk2M1IzcytadVJYRkVkeWhuNThWemFnU0pISVlaNTk2V2hVa3Bm?=
 =?utf-8?B?VXM4Y0RNeXNZV3ZYcFpuODcwZEpxUzdmK2Rjd1RpVFhENy95bVJDSzE0WC9P?=
 =?utf-8?B?NVhiem1oVWwvZWFKVmVtemk5Z053V2N0YmNZWHFCL0ptdDQ0VTdnRUZ4ZUtr?=
 =?utf-8?B?N0ovUm1SRExQcmFtRjBQVUdJS1hYM1FicE5udklKbWhCelVacXBJR3RsekZN?=
 =?utf-8?B?Q2Uxa2tOdDRwTjJTaktsTnRGMG40bi9EdnlLV1U5OGdCZHNwZktqSXg5OWZi?=
 =?utf-8?B?TVpZRFFqVnlKc0k0c1RlNEl0cFIxR3dGd0NtRm1BY3BpTFF4ODhUci9WOVRP?=
 =?utf-8?B?SXAwdkxQM3FZdUxYVlhyYXVuNDE5a3I2UjBBaDduV2NDZERTbS8rU21EZ01O?=
 =?utf-8?B?YmdCSnZnN2hZaEhXS3FhSzBLU3VoSEZzWnRNdU5hYUJIVjBWUXpjZDhRRnNQ?=
 =?utf-8?B?RDQvN2tSWTlKQ3I4NXg0SW9DQlU2ZEZVNHliTjFuSEU3YUFiMW9UdVF0Y2NP?=
 =?utf-8?B?Ni9uQXVDcExDNnhuR2RJWVQ2NXpEckM1QjY5d1lSbk9yV0YzZE02QUVsSU9x?=
 =?utf-8?B?UW9NSnd2c0lRdXNHSFN0Z2huUDlLTjN6ZkZLRWhrVnFReklmY0RoRE0wWVRX?=
 =?utf-8?B?UWV6c1F2R29uRis5Y1B3N3NnU1RnaDZGTGsybkNkd1U4UlZwdVYwUTJCODN1?=
 =?utf-8?B?ek1RNVdSdXlBRUtTemVaWGJmWVdqc1ZzU3UwOGQyZHJQTXdRNTF0YTBRa0Zl?=
 =?utf-8?B?WmJyRnBvWnI2RTh2djJBNGhtcUhZamdtTEQza2tXZDc4TEtZVzlOY3VxN1pP?=
 =?utf-8?B?all0SC85TmlzOWRwaGlmMzlnQlR1MytxQ1ZBaVFxRjQ3bDZIVGN3NkZyTjF6?=
 =?utf-8?B?SlZXaWdXNUxYbG5raVBmSzUrQ2w2OFlDc1REamxMWlMrS04yZVpDdkZrK2ZK?=
 =?utf-8?B?V1F5Rm5pa0Vnc2wzTFZ1VDZYd0JVVDRMSVVPYXJwOWVYVmtXZC92a1dwUlUz?=
 =?utf-8?B?dGZsQXBqUm5ZR29Jck91Wm5zOTYxOWRZQkk0ejB3VG9pUjdPL1V1bTFjQ2wv?=
 =?utf-8?B?bS9wejlvODhWRFZOWmpiMW5DQ1UzZGJHTnVlMDBHbGNXaTVBc0N5Z015QUVh?=
 =?utf-8?B?ZGd1RWpaUHlSV3ZQVGlkUDVYN2dUYkdZVWY3S3AwMDhEZDJHU1M4enpJNUZy?=
 =?utf-8?B?SDNxYUNHSkZlZmhjM0ZkaHo5aWhSNGtSUGszalVxS3lLM0dFMmJac0FIdmR1?=
 =?utf-8?B?ekJKVXJuYU5UN3RlZnVqZURmUHJIWmlhWGExVkxwM0k4VE5NN3oxNHdMY3VD?=
 =?utf-8?B?VHJRWWNmcUNYR3o4N3I5bnplQ3d1YUxBcGlrY1llUHJiZjkzcko3VVJkM1ov?=
 =?utf-8?B?V21teVozWkZ2RTRFR2N5eFBSK0ZKRXpVWVRmTUVsSy9YeXhoMEtwRWEwN285?=
 =?utf-8?B?dkZ0Y0c4TFd1d2Q2M2RnSTN2SnpNS0JTc0JXTkJKcHR6K0ROWHZGdkRhZTFv?=
 =?utf-8?B?R3M1Vk9ZZ1pWT0pMUEpjRDA1M1g0dWdPc2Q0QnBnaDJzTkJLN054ZGFNNU5R?=
 =?utf-8?B?M2c1SmljU0N1aHhjelY4cGdrRTNsdXFnRlowRGRqL3VQdEp2d05ZTUVwRkxl?=
 =?utf-8?B?bHNLdlNjU2Z5cWN5TTdSRm9BRXhSQVU2WkZocDhiZXpReFlPOXlHcFFTS1lG?=
 =?utf-8?B?RHNCc0NkUXNwdnRHNUJvNUJ2eTRoZFBEblZNRGlaTk12QkRsUUU4QTRZdGF4?=
 =?utf-8?B?UkJRcDRlaUwrTUdkUWFNN0FIVTEwV250VFhUM2QySnAwR25uckk1aFFRMk9P?=
 =?utf-8?B?MitJOXZNOTB2cElLY3VibENGMUhnUzBweHZjNksveUZNam1xYkRha21pSjRy?=
 =?utf-8?B?Z0IvWmdmb3R3SzBzT2NTU0F5bG5EZFRFVXZvbUl6NTU3RGtlaWI1U3pTNUk5?=
 =?utf-8?Q?RgBkeHMp0A0nKvIxTkwB4Vtva?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <722235E86769E94CAAA486D26B625304@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b086bb2-4dc0-49b0-2e4e-08da67252b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 12:17:36.5944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNAn7tIWFifRFlfiz+gND4cr7jdCXFgUPyg8wf27M3YEggoAeONUOeZiR7U3VTozFUrWIkduFTgmmmXfmDjSjjK/LIxmF5LiYKxRKoxE4HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5611
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDcvMjAyMiAxMTo0NCwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFNhdCwgMTYgSnVsIDIwMjIgMDg6MTE6MTMg
KzAxMDAsDQo+IDxsZXdpcy5oYW5seUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+DQo+PiBGcm9t
OiBMZXdpcyBIYW5seSA8bGV3aXMuaGFubHlAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBBZGQgYSBk
cml2ZXIgdG8gc3VwcG9ydCB0aGUgUG9sYXJmaXJlIFNvQyBncGlvIGNvbnRyb2xsZXIuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogTGV3aXMgSGFubHkgPGxld2lzLmhhbmx5QG1pY3JvY2hpcC5jb20+
DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncGlvL0tjb25maWcgICAgIHwgICA5ICsNCj4+ICAgZHJp
dmVycy9ncGlvL01ha2VmaWxlICAgIHwgICAxICsNCj4+ICAgZHJpdmVycy9ncGlvL2dwaW8tbXBm
cy5jIHwgMzYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAz
IGZpbGVzIGNoYW5nZWQsIDM3MSBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL2dwaW8vZ3Bpby1tcGZzLmMNCj4gDQo+IEEgY291cGxlIG9mIG90aGVyIG5pdHM6
DQo+IA0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG1wZnNfb2ZfaWRzW10g
PSB7DQo+PiArICAgICB7IC5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGZzLWdwaW8iLCB9LA0K
PiANCj4gV2hlcmUgaXMgdGhlIERUIGJpbmRpbmcgZm9yIHRoaXM/DQpBbHJlYWR5IHVwc3RyZWFt
LCANCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL21pY3JvY2hpcCUyQ21w
ZnMtZ3Bpby55YW1sDQo+IA0KPj4gKyAgICAgeyAvKiBlbmQgb2YgbGlzdCAqLyB9DQo+PiArfTsN
Cj4+ICsNCj4+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtcGZzX2dwaW9fZHJpdmVy
ID0gew0KPj4gKyAgICAgLnByb2JlID0gbXBmc19ncGlvX3Byb2JlLA0KPj4gKyAgICAgLmRyaXZl
ciA9IHsNCj4+ICsgICAgICAgICAgICAgLm5hbWUgPSAibWljcm9jaGlwLG1wZnMtZ3BpbyIsDQo+
PiArICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IG1wZnNfb2ZfaWRzLA0KPj4gKyAgICAg
fSwNCj4+ICsgICAgIC5yZW1vdmUgPSBtcGZzX2dwaW9fcmVtb3ZlLA0KPiANCj4gTm8sIHBsZWFz
ZS4gWW91IGNhbm5vdCBlbmZvcmNlIHRoYXQgdGhlcmUgYXJlIG5vIGludGVycnVwdHMgYmVpbmcg
dXNlZA0KPiAoYW5kIG5vdGhpbmcgY2hlY2tzIGZvciB0aGlzKSwgYW5kIHlvdSdyZSBwcmV0dHkg
bXVjaCBndWFyYW50ZWVkIHRoYXQNCj4gdGhlIHN5c3RlbSB3aWxsIGNhdGNoIGZpcmUgb24gdGhl
IGZpcnN0IGludGVycnVwdCBiZWluZyBkZWxpdmVyZWQuDQo+IE1vcmVvdmVyLCB5b3VyICJyZW1v
dmUiIGNhbGxiYWNrIG9ubHkgdHVybnMgdGhlIGNsb2NrIG9mZiwgd2hpY2ggaXMNCj4geWV0IGFu
b3RoZXIgbmFpbCBvbiB0aGF0IGNvZmZpbi4NCldpbGwgcmVtb3ZlLg0KPiANCj4gICAgICAgICAg
TS4NCj4gDQo+IC0tDQo+IFdpdGhvdXQgZGV2aWF0aW9uIGZyb20gdGhlIG5vcm0sIHByb2dyZXNz
IGlzIG5vdCBwb3NzaWJsZS4NCg0K
