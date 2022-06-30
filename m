Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A1E56122C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiF3F77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiF3F7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:59:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B9B7C9;
        Wed, 29 Jun 2022 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656568788; x=1688104788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LY+AAMv+oovgJm6cPkCuWUeHStHzlqXZokhPmpxumwA=;
  b=qfzSqZgPtSnVigXELTwAQ+0gGeNnrmc2CNPqQBB35Q6cmzCUOcVSjQet
   s7+kBVM3+iKlP2HPNsE0TBvMRVafmTa1Cme84jfgi0AWaK2TpbgBRPH2b
   azgLIJCcMCOFYm1JB41ACxDWYVCNcy4EgkQ/FARHhjPQiIDZvCbxlo/Ve
   CcbDj2n4M3W1Gse/N0849bsQXdTwx8ObEBpk+jYa12U8FFg50l3/ykKWm
   3yRZTW0OTKCet191F55SPvhgEDsybZNuMy1azzNKlrHygN2RFQTcGhL+D
   eK/dkkE1om9FyjRX19DDhdwS1pmswjpc+cmN3HXy2HLkxu7veGAqtBbVN
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="165762950"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 22:59:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 22:59:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 29 Jun 2022 22:59:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e565TN8NpTXOyFAdjHxdb/U+Hzo+pbUDRcZKNm8izPwMMkHuWc1aXS+WopYV5Hxel7xaZ8sCmo2VGXGZCIPlvkcrx6Di1sU5HZJ/5qdhhTxMqGoKvVT6l1C+5uWLBtHeRxW6d4d30gp+yRMpbet+YdzL9A5KG//ZmTaVERTreL0coTVQpcvAtHPngMA0mIhKpyz9tb+tLb1vNrTRWwlc9h3B+O7cg++RWbdFGr0SCx+QwpdxyTn+qUCSQfE23HLMR2U8RMBKggFTrOaVsuoRyEdFxgELm7OkWM0Qj4cKHGXcn35aV8zLqouihvNxzJuRcCpS5AkxBnMAJ5ODuhSgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY+AAMv+oovgJm6cPkCuWUeHStHzlqXZokhPmpxumwA=;
 b=KKDF1uFtUwK0qBdxqXwLFuLbDG+4PKl2STV+a05IF1GswFJQjR8KI6R0+kKENe7H2A+WgPf4UFN6cNLxTXTizOFS5moNJeax/FofmCDFYuCgx7F+nEIQ9VEWIpUk3fX+5hjz/5x4yUiu8/ZaJIm15Ih/YrX4xJamWjfx56gzE98befAKjbNMkpcrTITAXRfjoXflimIg8u8BCD4D9m6MqWpyJ8Am1+9fsNEpDuCYnUeWsV9hfUzfbtbIuDZ0Xs+9scXSaSiV0e7Dx+rAzSzlDP0+22bxg16dw45mVNYTRz4a7H4N+hmKplXse97p5iAfCZ4P03UZ8q50RG/VFQTPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY+AAMv+oovgJm6cPkCuWUeHStHzlqXZokhPmpxumwA=;
 b=lv7uzshzHPmYK+nze8n9OVnz3AWRjZstdYg9aRO+G2zQgCuJD3Jja+eBODw3dkp/jmfiFE5E7aRpyZBT58DKmPeinPgsspVrltFFAIikh1iNUK9JItCDG1qfcsgSdKaqvKUVimTqae2J9JzYcWii4TWIOtHfXwa24jVKY0LYEqg=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BY5PR11MB3944.namprd11.prod.outlook.com (2603:10b6:a03:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 05:59:42 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::c1d:1b72:2d90:d496]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::c1d:1b72:2d90:d496%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 05:59:42 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Topic: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Index: AQHYi7hgu9BbfCeInkGneSj5bi0Tm61mX4IAgAEWOoA=
Date:   Thu, 30 Jun 2022 05:59:42 +0000
Message-ID: <86c09846-bd6a-a3de-7ce5-8e949d3844d1@microchip.com>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
 <a2422718-2ec4-dbad-0245-1d78dbb39f25@linaro.org>
In-Reply-To: <a2422718-2ec4-dbad-0245-1d78dbb39f25@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92cfb917-a3cd-4a50-3399-08da5a5db9be
x-ms-traffictypediagnostic: BY5PR11MB3944:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bVNgKkrZ8V4xC57n3mfzwaCvl3jrUufLfMFZ/j1W2ufTPmffQ1kbWFHsUOOMM5HgktBOEvsGJdJ7A2vUf7YhVllClftpNyGtQmt6w8Zk1+ru8sM4BzUBgadHh6zD8V4iA5peMcfXxXrjxfS78oZb5HFFq7WQ1YOlMuC3mjKvh6sNgCKnqye3fl5iWnIUOlPC2hPZjDJ+uF0LS/fc4MuIWBssDEmbK2C5G/VZLTt3Jz8qgmKC2ICTF/au+V+XyitMOz9oYqh8L4BLX9ysf3QAmdmw3jxxMrRbwaFWGu2N2k8UJ8PYgToEf3PydChg7MHBAvXmg3B+Oe3u/+MxEr7OuFPjC8OYeQAw8L68AmqSpzg5M7c8mp4dF7Yv6Ixj+1NSEWbthf4shB6CgLMjpQmGCx8iZAC3cFhOwjk4MTB4E1W+FwCQmV3AsjzB9hTICCyBzHQ2jeV5VD1h3vvAVUCzB+W1Te5NPh3C0jPzPDrdj32hvZRNoM37pylRFUZD0Docx1487JekGYZd3oCLZzf/Fpzb1vr33jcJh21nKKlxSSt5eVCVGvEdfXQ7Tfi88Z6kXxgYz7WONeiMlarzqRgyupR9HYOb6hzREIvCHe0tNSXvtW+1kJU+no0u2I6pSQOZPEHlGxdmXBmMdAybMqzHWZ3neVdeVhqhun1mr8KGP5t++M/UgblCOFjIOI91V6Xu3jd4EKPpJ0Hz6Ws8ROZIFvnmfZ5F1snZ/a0JNj0MOzw3nzP14kUL3th0wyc5miLshFVWRTZmR3hNuVAkA8e/g56pJ91+u8yvwDAJ7xs3nRU7k8e8+SeZgvLHJ66TADBzhe3M7P0Enk5c0Ym/ETKt4RlFpBwdrhrFJt4U4f2s6GKiuoogB2DP1S/J5vtYAU7GT6EQoCWh4EBugQUCjBrlaqGSliSs149VYKORcDyGDc0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(366004)(39860400002)(346002)(186003)(6506007)(53546011)(41300700001)(2906002)(2616005)(107886003)(6512007)(26005)(31696002)(38100700002)(86362001)(122000001)(38070700005)(83380400001)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(36756003)(4326008)(8676002)(71200400001)(6486002)(478600001)(966005)(5660300002)(31686004)(8936002)(91956017)(316002)(6636002)(54906003)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXNLSUFRTmorcHNWSnhlTTBhdElqMVJRc0Y3WjBneUFBTkVKSkk2ajBja2Vv?=
 =?utf-8?B?bjF4cE9MemxWM1V4SHcwbUZaclRXTzFKMXE3SGNXTUswcXBrVk9aWGtVWmpn?=
 =?utf-8?B?RThDZy9uRFFtTTRPSzRXZU9Fd1FwSk5pL3JyZzh6MWttTmpnNWszWjFyN1BP?=
 =?utf-8?B?NTVYTDRTNkZxUzA1UjBSYjNoMzFFU21INHJpVENaQnJOaHY5KzVMUmY0S012?=
 =?utf-8?B?ZTh1ekRLSXlROGxqWGJqUm1QNEV1NDREMlZJOXBzaTZVMllLZEU2TXM4cFlh?=
 =?utf-8?B?cnZucWJ2cm8wYmR3L2hlQUw3aHhveEc2bTgvU2hDQzFuOVViZElTLzYvSm1u?=
 =?utf-8?B?Q1lYK3dkenZwK1ZRQjg2STN6cmRXWWxlMHIySmpKeU1iTW1GQ3d3YTRuTUZW?=
 =?utf-8?B?V0gvVEFVcHp0bzVtODk4S09GdDBwWXg4MTZ3V05sRmNOMzdJMFYyUFZCZ2Fq?=
 =?utf-8?B?ZUVncG5vdEltUHBMU2VpZHdQZjB4b1o0TjU0dG5ZcEN1V0U0OGY4MENhQ0Q3?=
 =?utf-8?B?ZGYrTllhZ2JaSGxHS0krbWRVSUVGT3JiZEsvakx2NUJZVWRzT1ExcFF5VlZ3?=
 =?utf-8?B?Mld6R2tYSGJsRWRwZklZb1Q1LzQ4cG82V2FVU2NLcUt3anpHaDBZSXZjTUIx?=
 =?utf-8?B?Yk9RMmJoVkJqYXpXOXltV2xYSERNVk5TQjlpS2FLOXRJdXQ3dEdpZjBUUkc1?=
 =?utf-8?B?LzFsM0tBRzZLSDMwdE82UDkvV2VXclV3WVVzRXhnaGJqNDljWUVmdlpDb1B5?=
 =?utf-8?B?S0pvYWtmYXE2ZUtHM203dGZaUDhzRUdnc1BjdXY5RVRkV0Uwbm44aWZaa2Z0?=
 =?utf-8?B?VjFZbEtJMTRWNTVnUjdaUGlVQkthOElxS2hLS251S0hLRXlkVUhRTjlNZVZ3?=
 =?utf-8?B?ZmNZSXJHQTBWbGFrWjNtYmF2RXB1ZEx4Y09XcmFiVzkrUGxiZko0OEV1U1NB?=
 =?utf-8?B?NHVvK1FZYmhDdW4xcTVPSm9PaEh3M081K0g3ekd3bklha1RtS0J6MGcvbjQw?=
 =?utf-8?B?QXJncnhxV1dNOTJmZEphMVc2WVV5Tk1KdGRLVUcwNmo0RFNpQ2xodlNteG9I?=
 =?utf-8?B?Qy91dUppaURVZmlDY2RNUC9ZWnZJT1djQUVYVEdadHBhMFVyTUlCbERsczgz?=
 =?utf-8?B?clE2ZXhWdURuS2tubWJ4UEVkTWFCdzFVa3RvY21OQzlMb1JEbUx1T0Rwa3Zl?=
 =?utf-8?B?TG1RRUtqL2hoMTRlcm81ZHFQbjV5WSswZy9LWTBJV245UGxVaEFjaWFmV2d2?=
 =?utf-8?B?QUhhRHd0RVpxV0lONXBuNFZIMk1Obkc2R0I4ODVyVnB0WmEyM0FOWEhZeHdJ?=
 =?utf-8?B?UGsxTDBzdjZlUWRHdFhObnRFWDBWbG12Tzd6L0Y4Y290TVJlUURkVW0yZVEy?=
 =?utf-8?B?cGplTUMvclhZZEEvZmhMY2JOWFRvaWk5Y3NlMGdIMmFubndBWWNDMERuV0Vq?=
 =?utf-8?B?R0ZUQ28yNGJ6aS9wcDRFaVhJSHA2Z0tRQWVGSVFKV3ZsRnNYdU5wZmRNUHFy?=
 =?utf-8?B?a0I5WlQrZnE0VzBpM1FuUHVXVmZ0VzRCanV1eHJ4N0k0aEpva1c1WFRLeHdE?=
 =?utf-8?B?WmpJQkdnSU45SWNOMFNvWWhMMkJSL09EdTZqZE9qN0xnS0Noak1QSDdtdzZS?=
 =?utf-8?B?RGk4Q2Z0V05GU3BqTXA4L01IS0Q3QUw0Ti9Ecll6dThvT0VZWStqZ0FJQzA3?=
 =?utf-8?B?N0owNWVMRmVPTU9WZkkrYWhwdURPSFlhL2lCdHdLMzhjcVVSTU8vdnNMdXZ4?=
 =?utf-8?B?bjduWkxoSmdmbUxrcWU2MzNTZHljTllvUk81NHVaU2thTkpSUXZ5c3Z6Qkgv?=
 =?utf-8?B?a1crR2VyR0I4MTIyQjNIakxqaDVPd2hjRWJ6cnU2Uy9xUnhyeWFFem4wUnp3?=
 =?utf-8?B?eE9kbWZtWDVLc1NkcXRuWGZVRGV6K0Z4WXBXajZueFBCcUt3RTZMMmJ2M01w?=
 =?utf-8?B?d2pVM0ZpbW9xanE3aHJtbTh2cVE0QzhwWWNSSW82N2JlaTFuQmU1N0M4cnF0?=
 =?utf-8?B?eXoycHN1bFpRRlZ4MlBoWkk1bjZUNlZlMWhzaFhNRjF3V1lSaHJVSGVCOUZM?=
 =?utf-8?B?bWJ2Z3pCeEovZTRCM0tNRkdBSGdxNWhjM1RlMlNmQko4eXBHZktoYTRsaklX?=
 =?utf-8?Q?2ArUfe6xYDqC2nEeWOh6eLlID?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C437502B4302EF4298D5FEA4A544AFCA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cfb917-a3cd-4a50-3399-08da5a5db9be
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 05:59:42.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8qUSc3DDu2GrCZNFyg5IEuQJbr2K4Je2SltfcgONB6/V/rTyy7QUa9+3Ycuxhxe9Xz8LiLMHPSyVUvjpcoAwTSBX2TOO85E1pCh2JzR9iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3944
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQpPbiAyOS4wNi4yMDIyIDE2OjIzLCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPiBPbiAyOS8wNi8yMDIyIDE0OjU4LCBTZXJnaXUgTW9nYSB3cm90ZToNCj4+
IENvbnZlcnQgU1BJIGJpbmRpbmcgZm9yIEF0bWVsL01pY3JvY2hpcCBTb0NzIHRvIERldmljZSBU
cmVlIFNjaGVtYQ0KPj4gZm9ybWF0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNlcmdpdSBNb2dh
IDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NwaS9hdG1lbCxzcGkueWFtbCAgICB8IDgyICsrKysrKysrKysrKysrKysrKysN
Cj4+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaV9hdG1lbC50eHQgICAgIHwgMzYg
LS0tLS0tLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCAzNiBkZWxl
dGlvbnMoLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zcGkvYXRtZWwsc3BpLnlhbWwNCj4+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpX2F0bWVsLnR4dA0KPj4NCj4+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVs
LHNwaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxz
cGkueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4u
NzUxNjE4YTQ3MjM1DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVsLHNwaS55YW1sDQo+PiBAQCAtMCwwICsxLDgyIEBA
DQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1D
bGF1c2UpDQo+PiArIyBDb3B5cmlnaHQgKEMpIDIwMjIgTWljcm9jaGlwIFRlY2hub2xvZ3ksIElu
Yy4gYW5kIGl0cyBzdWJzaWRpYXJpZXMNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6
IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NwaS9hdG1lbCxzcGkueWFtbCMNCj4+ICsk
c2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+
ICsNCj4+ICt0aXRsZTogQXRtZWwgU1BJIGRldmljZQ0KPj4gKw0KPj4gK21haW50YWluZXJzOg0K
Pj4gKyAgLSBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFRoaXMgc2hvdWxkIGJl
IHJhdGhlciBzb21lb25lIGZyb20gTWljcm9jaGlwLg0KPg0KPj4gKw0KPj4gK2FsbE9mOg0KPj4g
KyAgLSAkcmVmOiAic3BpLWNvbnRyb2xsZXIueWFtbCMiDQo+IE5vIG5lZWQgZm9yIHF1b3Rlcy4N
Cj4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgb25l
T2Y6DQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5
MXJtOTIwMC1zcGkNCj4+ICsgICAgICAtIGl0ZW1zOg0KPiBUaGVzZSBhcmUgbm90IGl0ZW1zLCBq
dXN0IHNpbmdsZSBlbnRyeS4gU2hvdWxkIGJlIGNvbWJpbmVkIHdpdGggYWJvdmUNCj4gYW5kIG1h
ZGUgYW4gJ2VudW0nLg0KPg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2
MC1zcGkNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtaWNyb2No
aXAsc2FtOXg2MC1zcGkNCj4+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXJtOTIwMC1z
cGkNCj4gVGhpcyBpcyB3cm9uZy4gRWl0aGVyIHRoaXMgaXMgYSBmYWxsYmFjayBvciBpdCBpcyBu
b3QuIEl0J3Mgbm90IHRoZQ0KPiBTY2hyb2VkaW5nZXIncyBjYXQuLi4gTWF5YmUgeW91ciBEVFMg
YXJlIHdyb25nLg0KDQpJbmRlZWQsIHRoaXMgbG9va3MgdW5uZWNlc3NhcnkuIFRoaXMgaGVyZSBp
cyBvbmx5IHRvIGF2b2lkIHRoZSBlcnJvciANCmNhdXNlZCBieSBhcm0vYm9vdC9kdHMvYXQ5MS1z
YW05eDYwZWsuZHRzLCBzaW5jZSBpdHMgc3BpMCBub2RlIGNvbnRhaW5zIA0KYm90aCBjb21wYXRp
Ymxlcy4NCg0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4g
KyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGNzLWdwaW9z
OiB0cnVlDQo+IE5vIG5lZWQsIGNvbWluZyBmcm9tIHNwaS1jb250cm9sbGVyLnlhbWwuDQo+DQo+
PiArDQo+PiArICBjbG9jay1uYW1lczoNCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAg
VHVwbGUgbGlzdGluZyBpbnB1dCBjbG9jayBuYW1lcywgInNwaV9jbGsiIGlzIGEgcmVxdWlyZWQg
ZWxlbWVudC4NCj4gU2tpcCBkZXNjcmlwdGlvbi4NCj4NCj4+ICsgICAgY29udGFpbnM6DQo+PiAr
ICAgICAgY29uc3Q6IHNwaV9jbGsNCj4+ICsgICAgYWRkaXRpb25hbEl0ZW1zOiB0cnVlDQo+IG5v
IGFkZGl0aW9uYWxJdGVtcy4NCj4NCj4+ICsNCj4+ICsgIGNsb2NrczoNCj4+ICsgICAgbWF4SXRl
bXM6IDENCj4+ICsNCj4+ICsgIGF0bWVsLGZpZm8tc2l6ZToNCj4+ICsgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+PiArICAgIGRlc2NyaXB0aW9uOiB8
DQo+PiArICAgICAgTWF4aW11bSBudW1iZXIgb2YgZGF0YSB0aGUgUlggYW5kIFRYIEZJRk9zIGNh
biBzdG9yZSBmb3IgRklGTw0KPj4gKyAgICAgIGNhcGFibGUgU1BJIGNvbnRyb2xsZXJzLg0KPiBt
aW5pbXVtIGFuZCBtYXhpbXVtIGZvciB2YWx1ZXMsIGlmIGl0IGlzIGtub3duLg0KPg0KPj4gKw0K
Pj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSBp
bnRlcnJ1cHRzDQo+PiArICAtIGNsb2NrLW5hbWVzDQo+PiArICAtIGNsb2Nrcw0KPj4gKw0KPj4g
K3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICsg
IC0gfA0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+PiArICAg
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4+ICsN
Cj4+ICsgICAgc3BpMTogc3BpQGZmZmNjMDAwIHsNCj4+ICsgICAgICAgIGNvbXBhdGlibGUgPSAi
YXRtZWwsYXQ5MXJtOTIwMC1zcGkiOw0KPj4gKyAgICAgICAgcmVnID0gPDB4ZmZmY2MwMDAgMHg0
MDAwPjsNCj4+ICsgICAgICAgIGludGVycnVwdHMgPSA8MTMgSVJRX1RZUEVfTEVWRUxfSElHSCA1
PjsNCj4+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICAgI3NpemUt
Y2VsbHMgPSA8MD47DQo+PiArICAgICAgICBjbG9ja3MgPSA8JnNwaTFfY2xrPjsNCj4+ICsgICAg
ICAgIGNsb2NrLW5hbWVzID0gInNwaV9jbGsiLCAic3RyMiI7DQo+IFRoaXMgZG9lcyBub3QgbWFr
ZSByZWFsbHkgc2Vuc2UuIFlvdSBoYXZlIG9uZSBjbG9jay4NCj4NCkkgYW0gc29ycnkgYWJvdXQg
dGhpcy4gWWVzLCB5b3UgYXJlIHJpZ2h0LCB0aGUgb3JpZ2luYWwgYmluZGluZyBkaWQgbm90IA0K
cmVhbGx5IGhhdmUgaXQgZWl0aGVyLiBJIGp1c3QgcHV0IGl0IGhlcmUgd2hpbGUgdGVzdGluZyBp
dCB0byBlbnN1cmUgDQp0aGF0IHRoZSBwcm9wZXJ0eSBhY2NlcHRzIG1vcmUgdGhhbiBqdXN0ICJz
cGlfY2xrIi4gSXQgc2VlbXMgdGhhdCBJIA0KZm9yZ290IHRvIHJlbW92ZSBpdCBiZWZvcmUgc2Vu
ZGluZyBpdC4gVGhhbmsgeW91IGZvciBwb2ludGluZyBpdCBvdXQhDQoNCj4+ICsgICAgICAgIGNz
LWdwaW9zID0gPCZwaW9CIDMgR1BJT19BQ1RJVkVfSElHSD47DQo+PiArICAgICAgICBhdG1lbCxm
aWZvLXNpemUgPSA8MzI+Ow0KPj4gKw0KPj4gKyAgICAgICAgbW1jQDAgew0KPj4gKyAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAibW1jLXNwaS1zbG90IjsNCj4+ICsgICAgICAgICAgICByZWcgPSA8
MD47DQo+PiArICAgICAgICAgICAgZ3Bpb3MgPSA8JnBpb0MgNCBHUElPX0FDVElWRV9ISUdIPjsg
ICAgLyogQ0QgKi8NCj4+ICsgICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwyNTAwMDAw
MD47DQo+PiArICAgICAgICB9Ow0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQoN
ClJlZ2FyZHMsDQoNCiDCoMKgwqAgU2VyZ2l1DQoNCg==
