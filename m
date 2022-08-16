Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11B3596394
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbiHPUOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiHPUOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:14:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4A480533
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660680872; x=1692216872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mMqH9Lna6Tl6lUpkAGZH1C51BUVzqUYqcH5lBkKSi7k=;
  b=GMr7OLWP2cIfyUBSGBWkFQYjjpIPwSLeVjlbbQyENsHkSUNuL4+/OX6z
   j3nMxFfu4EN4iMIChu8ohFKS1aojsWcZq5SNZeAjlILXXp54qFxnx4gKe
   IOeUhqcke7rAjyrpgZHHzQM3GxScMyV6osEMoXz5N7PgyjgtvrQqZtjlB
   qTT10Asxe+5/8wXNfjgHo4e48lRJ2GN27zUVHUzFTW5A2g2p+XcVLeKhp
   ujcZ4RLRiXJxTR7OoiOxDBULVeWPSqKvXEYGXf8I7OZQhrst3A6JkGCkb
   D3GQ7hKw5hWvc1fbiueVtdycZ8Uyvp3WxWNQ+mkPJLlpWC7FtT+Tig8XX
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="176511216"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2022 13:14:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 16 Aug 2022 13:14:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 16 Aug 2022 13:14:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv/cRjPS6XQYa68FGsxIjLn0wZnSYhv+CWQpdKVWAD8XsZ3TQ/RJZwGJChuLDUnnRExF2vjfBvlKr9mcpumlf7Qn2fItlwrQ0ttE8tK3CWmmSDpPju5m0buoNKbMm6wCM9eDHepI6E8+/cgoXwFMcicNrKjB7iUvyTXl9tHUTUigGfzdC2rO/hezK64lEVVqWRldNFlxPtGZ+hu1/tRjnPCpQMmTI/b5ch7Lva0cjz5+YAOIIhF5VC74T+ipukXAM/Otra6L7msGVtCiG/ogX8wFD1qd1IEcUSdh7xwf+DgkRTkCs680F6Hl9YPDvP+2IMNO70lWRkfk63VSWv+xXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMqH9Lna6Tl6lUpkAGZH1C51BUVzqUYqcH5lBkKSi7k=;
 b=NZ+bYt/Qq45KTV5Jx9QjXjheloG23EI3qVhIpq/Gb4zQv9grFEasjR1EiAB5xcyGDLBKASjTcjXZKMP+2cLf0qsLczcNMRvYNR1B2919+dxzAIdmGgZcWM3X+jc+J/9EjYxMarhhJFt277r7VwhZgxl08GaDwk3jDkh4W1ocfEGmXIx9REEJyWB8vWG7av+d3W7GeG8Wt40TrJ4XtgLwZ50PR5zW5/hZ7EMxNaDv5idcxYYVHsBAVXKhCptIbQ9FwTBSA84ySYwCeTSBFhLRbpXUmEmbAExG+YErQzl55YW+C3sH+Kp5S9aQNZ037uqMYjxc7WVFEwfE8X1p0+/MWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMqH9Lna6Tl6lUpkAGZH1C51BUVzqUYqcH5lBkKSi7k=;
 b=ZciEvz8fT5ICTydzC/GgDKWTIv28b+IuO2rUFrYxGD9j4qUGGbmbSvkucwJCPdU++Oi06/mTTWR1JQfuLRF6oYXL6vHWy5Hu18diLbPahxR5k34wiQp6Tv2lA9+nfrSiCmHymZgqLllvoVDTbzOLQ0lpQxoVOVtuCeqpTYQUAeo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1407.namprd11.prod.outlook.com (2603:10b6:300:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 20:14:26 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 20:14:25 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ajones@ventanamicro.com>, <linux-riscv@lists.infradead.org>,
        <kvm-riscv@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <daolu@rivosinc.com>,
        <jszhang@kernel.org>, <palmer@dabbelt.com>, <re@w6rz.net>,
        <apatel@ventanamicro.com>
Subject: Re: [PATCH] riscv: Ensure isa-ext static keys are writable
Thread-Topic: [PATCH] riscv: Ensure isa-ext static keys are writable
Thread-Index: AQHYsY2eGYLw8iAi7E2kcFjuy+7hb62x9nSA
Date:   Tue, 16 Aug 2022 20:14:25 +0000
Message-ID: <6f392592-e2fd-9fa1-4f43-c79a489d95ae@microchip.com>
References: <20220816163058.3004536-1-ajones@ventanamicro.com>
In-Reply-To: <20220816163058.3004536-1-ajones@ventanamicro.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fb7b860-c9fa-4ec3-69bf-08da7fc3eab2
x-ms-traffictypediagnostic: MWHPR11MB1407:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NIyDZXfjziB305UeenVTh9UkpH6/8WOkBWjmDE/+g8+wg5zv6GynlGwlf1d0b6LJXpYdAM0dMibx4Mcs/tw7usCq0ut2vehQafQQeeNzClvwrKy44pZG3ydcn2v8VxF/GQ6V+tRPtIhSigSLH2hLa1hv51OCm8lu+agBFW9er5+dpdmk7elTNygj4B+BPQVrlQ/RATCW/8TPfeIjfJ92ecPW2GVwVYwQS/u1LpR7+EGacz+2kyQkJyHY6Qp/cq3W5W3v3EYVytGrBqy0dHzfBYqoHgMY9N5KylZm1ttGnccg3G2xm6BZ7DUCMEpYI/458xJccKcyTxF5mICRjHxmlVrSloVy5W+k0U3kv/RBAhBoj/JOSqjJlYCflExt6KVCSAStYNgnaf8dnOLFvNpQmdKl7OIlG5v6lXJ278Q5//1YV4JT5tAjLKEuAxgsX0WidCJiu0RqqM3c78z8lSi+ITnaow+NUf1NwFx5BgS5GOgEkBXK+/hi8eAgXkqKe78NlH2u3AiUfRZ2l9jd5c0STRkWOvlagNKZ0TVB7sVSl/5WekMQoA1h3F719hpYu2rDhjKwSRwn6otOQ1e/iN/3YvZk/uvQNP+6SBvcx95No42FBdNKzkEhRk0kcvCdmoUBZWvbYoPlJm7yWnc0QeVqOZWsEsbflKeE9OfOHXn8+G0CYWBBQfHF8v6kvjvTWY+b4QXR67iDTPeIpsYPns0eiB/jDjqRGKyMGnhym+K8f/SQrB8+RXk9V+Ptht7pY9OBqizMwq/eFEqpx9FjZmeWcIaqE9L6gfv+nBvuPsCGuvLPsIg5RzA1aOKzDQm6rUopVkWUaEjbsfo/upcGLpfUNp6VAVKYllPD9Bmyn9+AtGi2q/871GvNPc1MT6DuOJ9E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(2616005)(38100700002)(31696002)(316002)(86362001)(91956017)(66556008)(8676002)(64756008)(66446008)(4326008)(66476007)(122000001)(66946007)(38070700005)(6506007)(6486002)(76116006)(53546011)(478600001)(83380400001)(5660300002)(36756003)(8936002)(6512007)(186003)(26005)(54906003)(71200400001)(41300700001)(110136005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTVaVyt3V1hVTTc4emhJazg2QjRDT3lEVFoxd2xpSjBDdnhnMGhDQlpFdXhB?=
 =?utf-8?B?bzVsRUVmL0wvZGlIU2QrbkdqZ0drNUNYVXE0SXA4SWptRnBISUYrTmlTZWNQ?=
 =?utf-8?B?TTVhNENjTmNVYlRDT2ZkOTNrUjNkaC9WNEdLTXFIb2s0amROekorUXBCa0lY?=
 =?utf-8?B?TWk3NlYrVlFjT051R2g2TXU3YmdjVm1DMk9PUStpUFdzQXJCV3ZIcEFiaXVU?=
 =?utf-8?B?YzJmcXY3OUtNL1ZHUzRQbndYbjl4bGRvcVhOcE1NMlFaWW1IakhoYk8yZlla?=
 =?utf-8?B?WktVcmhKcnBRdnh5citIbEF0aTMwZXdmOFIwYjJRZXBQOVdsOEVXVVlkOElv?=
 =?utf-8?B?YUdRTnhENlJpNGk3YS92YnROVmtRRDN2WHlYeDhmdlpTSDN3MDFpQzlReWN1?=
 =?utf-8?B?cjEvamJKR1ptemVoQkpLQVRpWDhXalQwNkFncjk2N2dHRUYrUFc2S01BY1U1?=
 =?utf-8?B?bEE0M0k5Q3lZZHd2aVFxQjBEREk4T3RyNkJsdXErTlVYWmhTclZXQlZ0OWJN?=
 =?utf-8?B?RGdSMUdTNmYvYUVSdHJ2UXRsU3hhZVZsT29ldC94ZjdRVVNTTHM5YmFWbUNH?=
 =?utf-8?B?Ky9FZ0x1UkpVUHk1UUhxN2Jqb242bGZJY1BQWTdGdDJMd1JJZnVUY1lpR2Fl?=
 =?utf-8?B?SCtIT2I3dUYyWXZ5NGpMWXZuWnB0ZXRvcW9MczM3RDh2RVU2U0xUcjJMb05p?=
 =?utf-8?B?WlNhV0czU29wT2xOSjhwNGpsV29RUVBhbVY1S2dJdW05QzFrRUhKQ2R3b3NO?=
 =?utf-8?B?RFB3OUw4ZVMrTkVpeHlZU2JoNTFvVitEdmZVb1dDSERvRytaZXE2OE9aQldL?=
 =?utf-8?B?SWNkSHV6QzlLazkyMTB1RGd0aEd2OXV4ZlVmL3dZL016WDg1U1NyZ2h2M2I2?=
 =?utf-8?B?UW4rSVQyOGRBTUtremlXN1NzUmZTM2dVQk1IVlZaUWZLS2RUTFpNOFBkaWZv?=
 =?utf-8?B?clFiaGxySUdNUnJINmwwWVlwZFptWWFHQ2xZazdYTFZhWUt5ak9UcUJINUs4?=
 =?utf-8?B?UkRHZk1lb1pjbVNFeElOSGJZMWNVV0FLSXRIVzdGL1FUK3J6RldIUE81bnBG?=
 =?utf-8?B?aVZuMU5VQzNuUHpnQ1NIR3BOT05CZ0dDNmFxNXNkSGhBU0tRdmVPSGxqN2l6?=
 =?utf-8?B?aHlWVXN0SGF5NCtCSDg2dDNSU213YTRtNDRUTnQrWVNnT091MGVKbEp4bk1U?=
 =?utf-8?B?M3I3ay84S1dQTXg5SncyL0EzeklvUC92LzhYbEx1OENyYjBkMTFHMUo3c3I5?=
 =?utf-8?B?VENrUCs2WUlpWGVSdFNRWmh2U2QzWmlYS2g3MTgzL1dFdE1kSE1rOFlTNFBa?=
 =?utf-8?B?THpGd0NGSHB1QkNST3B0dXBGUjRmQTl0Z1lrQ2tUZE0vVVRwUi9CU3BEbE9x?=
 =?utf-8?B?ZnVZaSt0Vnd1ODZpU2t6aURsVDY5MkMxcGVEZ01RWkhVNEovZXdndTUvYnk1?=
 =?utf-8?B?SlhlUXlsczR4Wnl4WmNodUpnMTZlbnlWM29SSXYvQU8yTUVlWlF4bU1ZeHRi?=
 =?utf-8?B?UVYzVWhlWUdEbUkySFI2WndMZE1YYnU4OXkwWVJQd1NWUHlGQ3p5TW5pbzl6?=
 =?utf-8?B?bnlMVXlyaFJackRMRERObUt5UDhOSHZhNFJrUkZDamNIWEYyTTNlVzdmZ2pu?=
 =?utf-8?B?Z3VBdkpDc0pjODZqZWVtQk1RUm90Vm05KzAvZk1hQVZUTVoxU0FieGIzQVdi?=
 =?utf-8?B?alFUdHY4Zjc0UnNaNER5T1c0akhRUDBZVFpoRGcwdS9TVlIwVTFJbUxTQ2dJ?=
 =?utf-8?B?eEFaVUUwUlVpSTVncURlb2I2QUpkR0tBT3l6Yng0aVgvWUJQS1hhNllISWpu?=
 =?utf-8?B?UGRRRTBSRlo5akwxT1R6UVZuMU1Wak1abXZvQUg1NVZXb3BnQjRmeDBXdmFm?=
 =?utf-8?B?TnU5VGZzMGxHWVE2YUxOWHN5UXBCZjBJQi9VUjJjbXpGdVFoNUdxZjRCUFVs?=
 =?utf-8?B?SitsbkZXeDJibFdQYnFIR1UwQVQyZ2ZCMXRUYVNIMFY5cHVhak1BU21ONjM4?=
 =?utf-8?B?MlI3ajAzcE9oVXE4MjNqcDJzcmFtRXlERUhlemNTZ0YxNXN3S29KUjlTVjhq?=
 =?utf-8?B?TnNVaGVqdmlHSExsSkJxUXFxSkk2ZTloelhKeWY1N2lJc1RCNzlOMFk4S0RC?=
 =?utf-8?Q?LMIU0bkp9ikia18gCUZsr7CQt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90465026C89F844C9E8A2947815775B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb7b860-c9fa-4ec3-69bf-08da7fc3eab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 20:14:25.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuE6dw76LRteIIufEB/lvs693SRkhEoBX6+Ta/j3oXoFRcPz7rm8FFP3Jm7k7ZH4McPZL/yFvUs+csOYcXNB9ZSQQHA0sMOmKkfacDvzu6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1407
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDgvMjAyMiAxNzozMCwgQW5kcmV3IEpvbmVzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IHJpc2N2X2lzYV9leHRfa2V5c1tdIGlzIGFuIGFy
cmF5IG9mIHN0YXRpYyBrZXlzIHVzZWQgaW4gdGhlIHVuaWZpZWQNCj4gSVNBIGV4dGVuc2lvbiBm
cmFtZXdvcmsuIFRoZSBrZXlzIGFkZGVkIHRvIHRoaXMgYXJyYXkgbWF5IGJlIHVzZWQNCj4gYW55
d2hlcmUsIGluY2x1ZGluZyBpbiBtb2R1bGVzLiBFbnN1cmUgdGhlIGtleXMgcmVtYWluIHdyaXRh
YmxlIGJ5DQo+IHBsYWNpbmcgdGhlbSBpbiB0aGUgZGF0YSBzZWN0aW9uLg0KPiANCj4gVGhlIG5l
ZWQgdG8gY2hhbmdlIHJpc2N2X2lzYV9leHRfa2V5c1tdJ3Mgc2VjdGlvbiB3YXMgZm91bmQgd2hl
biB0aGUNCj4ga3ZtIG1vZHVsZSBzdGFydGVkIGZhaWxpbmcgdG8gbG9hZC4gQ29tbWl0IDhlYjA2
MGUxMDE4NSAoImFyY2gvcmlzY3Y6DQo+IGFkZCBaaWhpbnRwYXVzZSBzdXBwb3J0IikgYWRkcyBh
IHN0YXRpYyBicmFuY2ggY2hlY2sgZm9yIGEgbmV3bHkNCj4gYWRkZWQgaXNhLWV4dCBrZXkgdG8g
Y3B1X3JlbGF4KCksIHdoaWNoIGt2bSB1c2VzLg0KPiANCj4gRml4ZXM6IGMzNjBjYmVjMzUxMSAo
InJpc2N2OiBpbnRyb2R1Y2UgdW5pZmllZCBzdGF0aWMga2V5IG1lY2hhbmlzbSBmb3IgSVNBIGV4
dGVuc2lvbnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgSm9uZXMgPGFqb25lc0B2ZW50YW5h
bWljcm8uY29tPg0KDQpUZXN0ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQoNClRoYW5rcyBmb3IgdGhlIGZpeCENCg0KU3RpbGwgZ290IGlzc3VlcyBib290
aW5nIG1haW5saW5lIG9uIG15IEQxLCBidXQgdGhpcyBpcw0Kbm8gbG9uZ2VyIG9uZSBvZiB0aGVt
IDopDQoNCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L2tlcm5lbC9jcHVmZWF0dXJlLmMgfCAyICstDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9jcHVmZWF0dXJlLmMgYi9hcmNoL3Jpc2N2L2tl
cm5lbC9jcHVmZWF0dXJlLmMNCj4gaW5kZXggNTUzZDc1NTQ4M2VkLi4zYjU1ODNkYjlkODAgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPiArKysgYi9hcmNo
L3Jpc2N2L2tlcm5lbC9jcHVmZWF0dXJlLmMNCj4gQEAgLTI4LDcgKzI4LDcgQEAgdW5zaWduZWQg
bG9uZyBlbGZfaHdjYXAgX19yZWFkX21vc3RseTsNCj4gIC8qIEhvc3QgSVNBIGJpdG1hcCAqLw0K
PiAgc3RhdGljIERFQ0xBUkVfQklUTUFQKHJpc2N2X2lzYSwgUklTQ1ZfSVNBX0VYVF9NQVgpIF9f
cmVhZF9tb3N0bHk7DQo+IA0KPiAtX19yb19hZnRlcl9pbml0IERFRklORV9TVEFUSUNfS0VZX0FS
UkFZX0ZBTFNFKHJpc2N2X2lzYV9leHRfa2V5cywgUklTQ1ZfSVNBX0VYVF9LRVlfTUFYKTsNCj4g
K0RFRklORV9TVEFUSUNfS0VZX0FSUkFZX0ZBTFNFKHJpc2N2X2lzYV9leHRfa2V5cywgUklTQ1Zf
SVNBX0VYVF9LRVlfTUFYKTsNCj4gIEVYUE9SVF9TWU1CT0wocmlzY3ZfaXNhX2V4dF9rZXlzKTsN
Cj4gDQo+ICAvKioNCj4gLS0NCj4gMi4zNy4xDQo+IA0KDQo=
