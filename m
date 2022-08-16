Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB5596094
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiHPQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHPQvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:51:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE26C12C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660668665; x=1692204665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0dW7jiNnrdXixWopBiPkYKvyt5YusbK8gTjn13X4Lj0=;
  b=aWp68t7Pcbhj4uM83ah+eJWFDUdwMIvwVPihCjH/W399RUO8MJq6QzWo
   N3MIr599KmErzT0xmEW9bp0TPjL4+J3VRPR5DUr9ZgaCBcRAXqmiKsnsj
   x2wemSlQf3YZZVg4Ix9PP9U+KYZbnxssnSQ8/bLjLV/58NqIIzvNj4j1B
   Q+UI1tAG9F+B/e2MYQWHmwUi+fBuBa4YfEd68XUO/uxPEurV0FO5SLH9f
   46IAxdp7h9Igv9DoaxerS7OyJsrhcTP1JRtRWOBmv65sf/ooYUzqbs6iS
   Q0EuKmwELrgtb0Pw+OPVx7Zh702RB/Z5c6GYxKDlsVLV2a9q/Bvuzl4vP
   A==;
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="176627365"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2022 09:51:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 16 Aug 2022 09:51:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 16 Aug 2022 09:51:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0SctkJF0aYL+GLNe43wsxFpcjdBHA9quAxgfq8kk7Yaxz8jC5vKZ9PNW1HY4VJGrtnSuGvGg49jTDglgKyqvwspTR34xLW7heY81+eUbfHcYOqonE+O9fnWN4w3zFBb0F6mR9JZwvxDWuEZ+66a3qWfO2EE8PlFmshmHcOVbdw8rkolYqrwTP6kMWOd+8Y3udR47sXnlActefEgMW1p/mGQlUlW60SuYVLWjUGhZSq7+x8tyZP0hgK4+F88kDRXkrsqrRBF3unqRWGQZhCgIeYGOkREcI5t0Qoq2mv4ZOdaCrBFuNxk+aemFXbVQK0B63vMf/D1zu6qJkXirOll6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dW7jiNnrdXixWopBiPkYKvyt5YusbK8gTjn13X4Lj0=;
 b=dumf6zeKTQUtfcoiPtoEmvzQIYR4jSOdjI59LsVsFOy/kHTH+hhCttbj7qmPcqLnaWSCMtYXMCXQ3ViY2qAYYZmOlB0zJtINsnYQ8dLyIfILYWeTP0JZ1u+1Vv1NQgP3/62oH/eSBPX+/36iO2cfOXsfxZCV9bfEuKquILOOlhvJISpfKrmHUM+i+6+y0yC+YYx5r2MF5Sb8x2fgxplpFzOK5iP2Ffu85gpKmJuXXBxKPCIKcdepSyfPUuRDuhhYNZE+1RJWLWBvKr+FS1LsanPmrV3LqHDRzUc2Gun34AaGKZBDN6rzJ1GjV23J54/92oggjxmYNazZGhUyJWb6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dW7jiNnrdXixWopBiPkYKvyt5YusbK8gTjn13X4Lj0=;
 b=vGwawzSFq/t50uaPSE8sYN7YHGiK/nNCAUWEEYdyz6ElkjB0jYgcWR8AiRdmQBVoePGDr+nBSELudj/uUVTtk2nqQF2RWUiFg9VSnlK1zIViQv0+m3UXLldo+P9GMtIjeQh7d34nr/R2x7JCW5WOIk+8pVWfK76fxUKBxc7Xwmk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 16:50:56 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 16:50:56 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ajones@ventanamicro.com>, <Conor.Dooley@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <kvm-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <daolu@rivosinc.com>,
        <jszhang@kernel.org>, <palmer@dabbelt.com>, <re@w6rz.net>,
        <apatel@ventanamicro.com>
Subject: Re: [PATCH] riscv: Ensure isa-ext static keys are writable
Thread-Topic: [PATCH] riscv: Ensure isa-ext static keys are writable
Thread-Index: AQHYsY2eGYLw8iAi7E2kcFjuy+7hb62xua4AgAADnQCAAABOAA==
Date:   Tue, 16 Aug 2022 16:50:56 +0000
Message-ID: <88a888fe-afbf-3579-73d2-9c95bfcfda55@microchip.com>
References: <20220816163058.3004536-1-ajones@ventanamicro.com>
 <bef1a711-506a-d07b-dbd6-3a0c5f90aef2@microchip.com>
 <20220816164950.vyo7iiiehhhasxpr@kamzik>
In-Reply-To: <20220816164950.vyo7iiiehhhasxpr@kamzik>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abcff16c-1d1e-47f2-bc49-08da7fa77d79
x-ms-traffictypediagnostic: CO1PR11MB4964:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ROf9cQ2Skks8A04Gi3Wo2G9jLBXSrhtlWqbQDeaSXEgiFMoWeX22CengqvI9wkC3abdqfPDqq5PhGrs7oHqu2vmrwrp5AQ5CRFqf0fB3fYCboYuIioPCturrN8xfPt7zAycpjnmbS+HotgLnr3PKRvzihHZK0ZAY1linqfzzcX5bKFPPL5ZfnwgoC/qD3NpIT+drOBPY/7crqZiMTwtD3dBY6vF5Cz4mXC9pLKPGcWZhY1oD05SQ3rmLIbYUTbsyF9vBpUd2uZHGehgs9GfA5wSkNd38/IaYRCgn6Xn6wPMlXcRzWPiL66XlMg7RHqpyPVWXT/RVYM05XiKprSBTob6SF4MXaPTDEF8iMJrOc3KZT++FXDlGhz6ulhbGAnqh9we+SYH8eNAqtei0HX6LO2WUQLK5yqglSOOfRtdD+jlDsR6tHG5JgAeoHbRwqkJ/2lLBrongYA2ZbbRUZvjnToFYi69y7DbwsfPpy4vY5TXpSoAYSu89mhqO/yGaizUYHA8cFNN4SshCXxdVaHoBq0h3XNXJv4ZTp1K1inmi3rnbS/Ae1Z4HTF+jL5tMTieIWYyUSY8qIJImAUybtGECP6ow2Uy8Ns/44ulhwfEGAw5bATK+mEUYaMMyTeLlFkMUHNj/OEK+XTuyWPodj6bE44YYdt+ypwU4zZ40KBoNF94GJfETl7NN4dJCY+88H9l6CVlyTvq9BkbK1YB6Yr1OCpkO8D1kgGNGXF1jTFPLJL/h/Gu8YNNl+obfWstdF65nI6u92Dgw2gHeTSydrpSnRRKmXzeCdtN54F/jsJtPzPcsmKxL0xZ77Pr108LMz6pv/e/jlCKAjxfe02Sc+f/HvRzUdLCx17SBoip9I21VPBADk4hGmwhIxJfHBDekp0175FrjdeMzdJRK7bxjySjIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(346002)(396003)(136003)(4326008)(83380400001)(71200400001)(110136005)(478600001)(41300700001)(6486002)(966005)(54906003)(8936002)(66556008)(66476007)(8676002)(64756008)(5660300002)(316002)(66446008)(66946007)(91956017)(76116006)(2906002)(53546011)(122000001)(31686004)(36756003)(186003)(38100700002)(26005)(2616005)(6512007)(38070700005)(86362001)(31696002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXRUa3JENVZ3QUs4VDVPZjUwdkFBam0vQ2NuNW9INFQvcGhOaVN4QS9sOEFP?=
 =?utf-8?B?OThvUERaYXJldC80ZTdDQnFCRlhkVnFhZUp6VlJUbCs1MTlGKzFWOTh3S0sw?=
 =?utf-8?B?MjhKU1NpaFQwTjkrMUw1Q1NsSUJXRzFvakNCVTNjSk9mL1psa09HWXZlZ0lC?=
 =?utf-8?B?WWpmL2R4UHdvbzZUY1k3b1VpR0lqaE5IQThQUFAvbmxEa1ZTcE43ZG9MQ2h1?=
 =?utf-8?B?Ui93WnZEM0tVWS9lSGhwRFVUZksvNW9TUE9qZ3V6eGhsak1BeDZxV0VzQTJk?=
 =?utf-8?B?cDhpZkZrVW9hUksvSWxpNlp6YUkrTC9IQXpvTE9lRFpwUjZCU01iNldGYzlo?=
 =?utf-8?B?eGQrcnpYTkNnNkZCaGVPOTRJU3JwYVBHZHo0TlZxWHBaTDVnQ1JaNmE1R1BG?=
 =?utf-8?B?SXRzaFFvNG03WXhXV2k4RkpINGdFWElpRksvT1ZZbFl0UVZrdUV5ZFRUNDll?=
 =?utf-8?B?VVFLUzFCRkFqYzdxT1dNT0R4Zm5LYzUrWm9RVFVLVTdHQU9aRU8xS2FMdGRV?=
 =?utf-8?B?RjFyZS9VbnFUSWZldDYyZkp5WXF6ZitMQk5odDJIQ0xnZDNBNUZoY2FGQUM0?=
 =?utf-8?B?Nk1UTlJiMWtXYkJ5eHFTSmYzZXRuUXJTMmF2K2FjSUptK0pXeUtETjVTN2xC?=
 =?utf-8?B?SEUwektIQnB4SlF5TmxYTUR3MzVrZngxdjNIaWZvK1FOVjhsdmIxUVdNc09B?=
 =?utf-8?B?L0kxTk9Hd3kyazBTZHVpQmtScE40Z3oyb1Y2YUtha1Z3cU13ZWZwQVhiUFhu?=
 =?utf-8?B?bCtDckt5bFZsR004cTRKcmFUaGVIaGZ5TnBseDVaR0NoL2pMWHZhM3gvcVJp?=
 =?utf-8?B?YmljcWRZUmZyekdRdTdEeFVxMmZXSUVMNVgyTjJDalFBTjd1QldXeVNXbEpI?=
 =?utf-8?B?ZFZIejI1SmFBZ2hWY2ZEcnh1eVpFQmx5L21EbHJqNkw0MUNwUzZXYlRzdEY1?=
 =?utf-8?B?ZjhOYjdJUlJMZzlaZ28vZEl6SDVSNUFKTUVqcllMOVB5R0w5bzdJRjA4UVdU?=
 =?utf-8?B?Z05ETk1QaUMxMFR3Vkt0RTdqZFZZd2pFc29lcU9SV09NdUFLYzJJM1NUNEtr?=
 =?utf-8?B?c1N4cVNtWWIwM2NYcmdtR3FPZlpuMG5YWXJEdU0xczROMUZGai9RK1lIREVR?=
 =?utf-8?B?QUlmU3FISjkzUUh2YkRnUzFLV1I2TFVFdmREdzErekI2d2RpbXBHVUhxMTJr?=
 =?utf-8?B?UHZwQ2RqUGRUZTlNTWpYc2s3UTlvTUhwblJwTWRNQ3NjTE5ObUp5MjFQbW5j?=
 =?utf-8?B?RjVGeGpGMkZBc2hmdCs2VDRMUXQ4cjZzNXRDRGRLTjhCSlVXWGovakg0TWJx?=
 =?utf-8?B?TU9GUW5SY2MyMnZ1N2VydUo0NUNvWHVKamhhSEZrVDkwS3o4blNVYnF2Z2ZC?=
 =?utf-8?B?MkF2Q0QraUozak9zWHZJVmg4M011aHNXTXdseXZrYjFWbXVqNnpJQzVJVEYr?=
 =?utf-8?B?cStOOUtRVGNvNThPQWRVT1d5b01oWkNRZjRpcUZTT3B3N3k1cFBDbEl3M0dy?=
 =?utf-8?B?TVhKMW9GTWV2VVNtMGhJR2hXbHExQ0IwaklOckFRdHpQVnhlOXJOQWZqMjY4?=
 =?utf-8?B?c1QvOHJmNFpLMlh1ZnI4TU1zNXl1WTZiV1BQbDZKeXJpV1dHdG80UnRxR1dp?=
 =?utf-8?B?WVNwM0grdWNPbFU4NEdrRjF6ZW9MMmg1ZnR3U0VjV0N3eU5mN3k3RGRBeXk2?=
 =?utf-8?B?T3dVeEMwY3krUFEvRTk4U1ZpOXdwMUovOVVhUFVsdzVsbHBmNkxWYzJoQVVo?=
 =?utf-8?B?bXJKNHNPZFdSbGpWTjBLNXh1allkUUVUSVEvMUg1YlBuSU96UExoQ1R4Zkt1?=
 =?utf-8?B?MVVsTmFybUFucXEzMCt0Nk8xcHVsL28xck0rRnNCQ0ZTTitYZUg5eXIwVkZX?=
 =?utf-8?B?K0xrOW5vOEZidkFhUTdrK3B4OFB5bFhFc05OSkJaT2E5eGduMGdiampld0xl?=
 =?utf-8?B?dFEyOHlWaFZVcXZwZFhNamZVQTcwYjczUzE1dUh6Q0ZTbDN1eHpyTDBpcC9n?=
 =?utf-8?B?aS94cVNLMjRGWXBJWSthYk1uRmpFUTV0K2NHQTJZSFZJa1Nyaitzd1E2bHZD?=
 =?utf-8?B?Z0htVGovWE56cnJPMU9YL1NYQXlTemxFbFpqeXdCeDZzK0tpcVVEbWxhRTZ4?=
 =?utf-8?Q?A/t1AyS5m/wRVaintNzeuxIjy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36B789116EC393469E0E7C8A3B4B4B3A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcff16c-1d1e-47f2-bc49-08da7fa77d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 16:50:56.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xq34sze/NFDdQ4rFQqLrj6p2Ky9lI28uSPKtKxNjXsaZh4TtxNarm2iDhjTmc/gayqRgF68AlLcwWSuqYBcebXwN3lJlLFJizM2q70+Dor4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE2LzA4LzIwMjIgMTc6NDksIEFuZHJldyBKb25lcyB3cm90ZToNCj4gT24gVHVlLCBB
dWcgMTYsIDIwMjIgYXQgMDQ6MzY6NTVQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+PiBPbiAxNi8wOC8yMDIyIDE3OjMwLCBBbmRyZXcgSm9uZXMgd3JvdGU6DQo+
Pj4gcmlzY3ZfaXNhX2V4dF9rZXlzW10gaXMgYW4gYXJyYXkgb2Ygc3RhdGljIGtleXMgdXNlZCBp
biB0aGUgdW5pZmllZA0KPj4+IElTQSBleHRlbnNpb24gZnJhbWV3b3JrLiBUaGUga2V5cyBhZGRl
ZCB0byB0aGlzIGFycmF5IG1heSBiZSB1c2VkDQo+Pj4gYW55d2hlcmUsIGluY2x1ZGluZyBpbiBt
b2R1bGVzLiBFbnN1cmUgdGhlIGtleXMgcmVtYWluIHdyaXRhYmxlIGJ5DQo+Pj4gcGxhY2luZyB0
aGVtIGluIHRoZSBkYXRhIHNlY3Rpb24uDQo+Pj4NCj4+PiBUaGUgbmVlZCB0byBjaGFuZ2Ugcmlz
Y3ZfaXNhX2V4dF9rZXlzW10ncyBzZWN0aW9uIHdhcyBmb3VuZCB3aGVuIHRoZQ0KPj4+IGt2bSBt
b2R1bGUgc3RhcnRlZCBmYWlsaW5nIHRvIGxvYWQuIENvbW1pdCA4ZWIwNjBlMTAxODUgKCJhcmNo
L3Jpc2N2Og0KPj4+IGFkZCBaaWhpbnRwYXVzZSBzdXBwb3J0IikgYWRkcyBhIHN0YXRpYyBicmFu
Y2ggY2hlY2sgZm9yIGEgbmV3bHkNCj4+PiBhZGRlZCBpc2EtZXh0IGtleSB0byBjcHVfcmVsYXgo
KSwgd2hpY2gga3ZtIHVzZXMuDQo+Pj4NCj4+PiBGaXhlczogYzM2MGNiZWMzNTExICgicmlzY3Y6
IGludHJvZHVjZSB1bmlmaWVkIHN0YXRpYyBrZXkgbWVjaGFuaXNtIGZvciBJU0EgZXh0ZW5zaW9u
cyIpDQo+Pg0KPj4gSGV5IERyZXcsDQo+PiBIb3cgYWJvdXQgYWRkaW5nOg0KPj4NCj4+IFJlcG9y
dGVkLWJ5OiBSb24gRWNvbm9tb3MgPHJlQHc2cnoubmV0Pg0KPj4gUmVwb3J0ZWQtYnk6IEFudXAg
UGF0ZWwgPGFwYXRlbEB2ZW50YW5hbWljcm8uY29tPg0KPj4gUmVwb3J0ZWQtYnk6IENvbm9yIERv
b2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBTdXJlLCBzaG91bGQgSSBy
ZXBvc3Qgb3IgY2FuIHRob3NlIGJlIHBpY2tlZCB1cCB3aGVuL2lmIHRoZSBwYXRjaCBpcw0KPiBw
aWNrZWQgdXA/DQoNCk9oIGdvZCBubywgZG9uJ3QgcmVwb3N0IGZvciB0aGF0IGFsb25lLg0KU29y
cnksIHNob3VsZCd2ZSBzcGVjaWZpZWQuDQpDb25vci4NCg0KPiANCj4gVGhhbmtzLA0KPiBkcmV3
DQo+IA0KPj4NCj4+IFRoYW5rcywNCj4+IENvbm9yLg0KPj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBB
bmRyZXcgSm9uZXMgPGFqb25lc0B2ZW50YW5hbWljcm8uY29tPg0KPj4+IC0tLQ0KPj4+ICBhcmNo
L3Jpc2N2L2tlcm5lbC9jcHVmZWF0dXJlLmMgfCAyICstDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gv
cmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUu
Yw0KPj4+IGluZGV4IDU1M2Q3NTU0ODNlZC4uM2I1NTgzZGI5ZDgwIDEwMDY0NA0KPj4+IC0tLSBh
L2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPj4+ICsrKyBiL2FyY2gvcmlzY3Yva2Vy
bmVsL2NwdWZlYXR1cmUuYw0KPj4+IEBAIC0yOCw3ICsyOCw3IEBAIHVuc2lnbmVkIGxvbmcgZWxm
X2h3Y2FwIF9fcmVhZF9tb3N0bHk7DQo+Pj4gIC8qIEhvc3QgSVNBIGJpdG1hcCAqLw0KPj4+ICBz
dGF0aWMgREVDTEFSRV9CSVRNQVAocmlzY3ZfaXNhLCBSSVNDVl9JU0FfRVhUX01BWCkgX19yZWFk
X21vc3RseTsNCj4+PiAgDQo+Pj4gLV9fcm9fYWZ0ZXJfaW5pdCBERUZJTkVfU1RBVElDX0tFWV9B
UlJBWV9GQUxTRShyaXNjdl9pc2FfZXh0X2tleXMsIFJJU0NWX0lTQV9FWFRfS0VZX01BWCk7DQo+
Pj4gK0RFRklORV9TVEFUSUNfS0VZX0FSUkFZX0ZBTFNFKHJpc2N2X2lzYV9leHRfa2V5cywgUklT
Q1ZfSVNBX0VYVF9LRVlfTUFYKTsNCj4+PiAgRVhQT1JUX1NZTUJPTChyaXNjdl9pc2FfZXh0X2tl
eXMpOw0KPj4+ICANCj4+PiAgLyoqDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gbGludXgt
cmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2DQo=
