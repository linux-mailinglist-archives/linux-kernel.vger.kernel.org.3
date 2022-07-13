Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AFB572E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiGMGhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiGMGhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:37:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC738D2171;
        Tue, 12 Jul 2022 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657694238; x=1689230238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/77aCoq9n+yCkDeSkm8KC1XOdqPD2//cjSjUQtSJiUo=;
  b=ABVDo5qVPo1oh6Q0j2vj5nGVap6F36wnMOYjap4uYIcwRuQLfSyOo0xx
   97hEVn8aJzQSUZxt+/9Bv+syBf/9eYG6hFzdcQexOnc1ayaOfENrQo1aC
   dAbg2zAz8fd+nwzXFEDiPKFqWxSH8P0JsYOq5CDtaV6o11W0oy1taWR+5
   2aSGOmYI0WwlvqPHmjvDA+adtaQBkDms2IQhs+jnecDZuTT458FQZAzKa
   knXNgAi2/kiROV+Jx9PnNHK8ocSoqYIKft64cbdhUTaKbgd70jHhQZImG
   EkC1AyDWMFoW011O1LtTgHGkSwdc5asdh1meM4H2glSAqPIjpjjFzbdjE
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="164494639"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 23:37:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 23:37:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 12 Jul 2022 23:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODbRytO5KkPsfCDLT9z/sQpMv8KLM8eLvzASwuAeNIX4azJR6PmmC/WAKSs8mWI2WLT8Dn6xbLL48GMC7F2KIzRRDlu5G7EndYQsS3KCsdOSwGFWqadiOyCSzqwhcshuYDkcyLkp9LoTer9WO4KIMQAlHaU1G/Bg/CTP890m9x0Uk8i5VmFsxYKPkHbrB4RB+gh58V92m5BXwb7duEw1Zl9f+BjDnYtlKLphSI8V+mhnmaC1jKkNsYOuv0++eO6gdaDc8mG9znVYp0G0+fNPs9RAVSt3tgbbxJKa7EM55KU8sKGUnCICQItIWREqqs1JW3DRvGl1yQgk/ZW9fYYxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/77aCoq9n+yCkDeSkm8KC1XOdqPD2//cjSjUQtSJiUo=;
 b=ZUEqoUY9Rl0KTXja+wTUANexufMS98tNE5vICY+jmc55iLaSe7f/saEapa4RVIV6FA0RusBkeNN/QTt+P/4sg/kOCjXegRvWEzPU7GmM8+Gh8C20Al8w+CfsWuxH0RG9xRLGIvdXKKXxNbwC60GaLTDT1f0jIqrFauM44mjIgERLbYgCX5TFAwRO1fTrM+kOHCmvnUlYAbnVQRT4n+ZYgvwczN7uzdQwVwuIVyg3M+77Kr5KONUkqJuvD5KwKbjb6F2kNI+rnVErXlwyqg1QhNmItUZ8XjOaDeXfXLnY57A7fcrLhM29iH0Y2IQa5rlpPuGF3XuCraaiivklCvvEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/77aCoq9n+yCkDeSkm8KC1XOdqPD2//cjSjUQtSJiUo=;
 b=YEeGo4TIxjSoAQRY9xePnhw/5ZgEi3xxDdm56AsEq4vnkOIhf1r0+DLaRtFPlx8uTCgMq6DavcUofffWANt24wWH6MzkNUtkWDgaI/+59ne5R1ky1+WBbUENFEpqnDzR4Ac1zunTGnT61UThHs9fXJKYBmzS5haNGVEYWSQJVdc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2617.namprd11.prod.outlook.com (2603:10b6:5:ce::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 06:37:09 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:37:08 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yangyingliang@huawei.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] Revert "spi: simplify devm_spi_register_controller"
Thread-Topic: [PATCH] Revert "spi: simplify devm_spi_register_controller"
Thread-Index: AQHYloL5xmNePOp8S0K8PC9ENibmGQ==
Date:   Wed, 13 Jul 2022 06:37:08 +0000
Message-ID: <bf2811e4-86f4-140e-2a3d-388d265557c7@microchip.com>
References: <20220712135504.1055688-1-yangyingliang@huawei.com>
In-Reply-To: <20220712135504.1055688-1-yangyingliang@huawei.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae6fb7fe-1a0e-4088-7111-08da649a1c4f
x-ms-traffictypediagnostic: DM6PR11MB2617:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ug984U7ARJ15o0Bx5mjxEWs3VWjgAPrqA5GtS+uaz71d2MoVPrxAOnIeUBZQWvlxisMISij0D1hnhiLQ71kaLK3pacPV9BYzJ84DDeQwnWro+UsSLtzz2Jb+Q/p2V5I4WrwOdu9O6gS9/oqztS2sjTVCE9dNm17mJRZDvuv4T10YLMIQFKD5zQ8VnyLCTFqU46W4yNTEVHJx+YaU/K5jv4XujvbLjaSVdCewcX8V6SVZBIoS4jz0upSAfmyOnYLkDMdtr8RkdKpuOYYlH0W46YgO+I5++yrOi/A8gdq3b/cS9wGlmvhGLN/BA9pLJJ7pDSynF187SFpeKPBBKrfVOZqX/58H6ZkE4JzY29jBLIznTAS7cjhb09gQjKgH34TS1f3tDlC/mfbmyRZUcIT7WdZGSDkna+QZKr2eymEzmveFys9mUfl36e/uOXez2RA6/Km/QcUCkDoV4z6yr+R+7G+uD/4qUu4fcsEhYZd0skqskkKzu04nAFPNoTwAZIhdJahv4EysXsgqjKmtikms5oIi7mro40rxNPW7bnQWiyJRNx7ZACZa1JF/VvWL5b+NPryCHFQelIolN6/4DrXemHpzPssZcvuCf8zWgZFcc/ldoZ35uBzuROwa4vPILxosJgEQQxaQYIeHbtUyyt0yqoR/lGHmjffAddJOqDH0uvV1HPq0BX2+FF+mSIY/6rxCykv+kzhu6mdQSaww2tSc8QoSr8T5jFRmtm+1JByZi+FQvIrOvIaI6u02fLpjk/7adGqULQfixYB+K46uz70536UIllvSWD0vqF62MugMCIskt4/XfJ0bMwxpeNc9+Lvrk62pZhYzrEUyC5se3b0gPZmj0gco5FCFk2dVA0oYD8ffvpe/19hE6IlggSEXt5E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(366004)(39860400002)(5660300002)(8676002)(66556008)(66446008)(83380400001)(31696002)(91956017)(54906003)(110136005)(38100700002)(64756008)(8936002)(86362001)(6486002)(76116006)(41300700001)(38070700005)(4326008)(316002)(66476007)(36756003)(26005)(2616005)(122000001)(31686004)(66946007)(186003)(71200400001)(53546011)(2906002)(6512007)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDYrdnh1Njl5b0pwVEs4ZG9tYzFjUDlVTTBhRjZxV0kvdElYOXBLRitxaEFl?=
 =?utf-8?B?RTVpc1A1STExbm05UFZyY3VmQUdYUmpWdklQK2JYSmE5dXdYbTlOZCtValdK?=
 =?utf-8?B?VnlSRFBQb3g2alRUOHhrbmp0bTRna2M4ZWcwUHdIM0VyVUhTZEtKQldZN2NR?=
 =?utf-8?B?NnNWbCt4K1RXcmZPdHJna1NxcEpOSjk3VjdoQXd5M1p5ZFIvNG1xZW8veFAx?=
 =?utf-8?B?Q2JVZmc2a3ZGRmNnTUFRcUFtRnhURDY0Qk5HeXdpSjQvNWJKVkM1bWk3cXRn?=
 =?utf-8?B?THpsY3p3cEZnbGlJWVpGWEo5VW4rTEl2K3Y4SGlHbCt5bEh1d1o3K0t5MW85?=
 =?utf-8?B?QTMwUXZjTDdqejZKbDk4S3dpNVZBYkJ4aVowaDJkSm90KzB1OTJycEZUdEFG?=
 =?utf-8?B?S0pLWFhMY3QxV0VhTVJidVI5VGRta1N0bjFQM2M1UU9YYVg1OVJRUHRhUGVG?=
 =?utf-8?B?ZlBTY2ZLTkpEYlJBSFVQRXNINmF3YU9NY1B6Ymh1YWVXWnlxUlMzendlNXJt?=
 =?utf-8?B?SFY3Wk9hemVmeVB1WnJQTElCYXl1em0rbXV6KzF6L2g0MXVWZDY3Nnp0WitS?=
 =?utf-8?B?a0d6cGRkajZ1QWNyQkx4MFdNUXlDRUtkWWF5RjExOXVTZndjeUppRCtQN1BY?=
 =?utf-8?B?LzNRY1d3MldoRjNteDg0M05UY1pnQTJweElyS2hVOTZxR2tpOGFhSXpYYndU?=
 =?utf-8?B?Q2RnUUZ5MTNHc3I0R1lwdmFqN1Q5ZTFSTTRVR0RuSjdtOU5BcDluZVJBaTZM?=
 =?utf-8?B?V3RXcmt6SHZaNTFkZGF6TjJNWURHUzlJdHUvSVovU2h2RlVJem5rSk5oYjQ4?=
 =?utf-8?B?WURZZC9ST0RmWHhaMTlya3IralpKNGxHZUVqaUIzRlk0OVg0elFEOWFPdWUv?=
 =?utf-8?B?U2sxU1hkUDlnMzFxQ0xPRml6c2s3SklIRXNOUkRZYVpnZXQzSUdKQWFxMHIv?=
 =?utf-8?B?SzVxQkp1Tk9XQWJkRzg5Yi9mMmxMMWEyQmFYWmRvTGtmbU80cDVndkNmQ2J5?=
 =?utf-8?B?UTh0ME1vYi9ZeEs0b0M3dGtFamJsNVdTd2kwUDhWQzdKVmFWeFBncFFmZGl4?=
 =?utf-8?B?N2E2L1ArMDNMRkxKMDRwNWE0RUFTZHpMVmFvbXY5Qm5neXJlOHdGdVhlSS91?=
 =?utf-8?B?Tk14MFFxUHQ4THBIM1YyalVxUGhKUys5VGF2akdOWUpmT2NMcVIxV2VmTVNj?=
 =?utf-8?B?WGtjK0FhSEdNTVpSakJpOHNrUEpReGR4ZExrTk5XWkwzOGg4LzI0TS9yTm5u?=
 =?utf-8?B?azVFUTdReWZnWnlUejZQYWtRRWplWWFJSEZZVk15eXFDYXpJeWJrOXFaZDIx?=
 =?utf-8?B?UmFGdDI4anJ0ODc0WVhZanZwcDZuV1pQNDZjMkVnZGNybHBxaXZKbTU0MHU4?=
 =?utf-8?B?QUNmeDVUcmt2cEJOTHZERlpxNGw3S25kSUN0anBPUURFcCtTK3ZKSUUyUzlZ?=
 =?utf-8?B?ZTRZMnpOWktGTzRHUEJRQ3UwNUN2SC9UU0dBTkwxWnhvR05qTEJ1QnpCcUxX?=
 =?utf-8?B?anh5V2pPN2xKeENuRkhPcG41RE9xNk9PMmtUOFBocXlRcDVsZW1yRnJPczgz?=
 =?utf-8?B?c3lkS05lVWp3cm5xLythWGVVanRPZTZPZVJKK2lmZXdyQ2xDMVU3TllsSDg5?=
 =?utf-8?B?NDQ5WkFRWlkvcnpMa2IyMU5EeEVxaGJ5NnRJOFBLN2VhV2pPSEsyYnNHQ0ls?=
 =?utf-8?B?QURQL3VETElyL0tMc3k1MGtpNG5nWmpTRi9tTkF1RkN6cUhQTXpVd1k0RTlh?=
 =?utf-8?B?WnhVNFFIcjF2TE9wU1Fmb3dYczlNbEZ1a0pGcVlTUnNraHhzNi9lS1lBUnkz?=
 =?utf-8?B?R3BjUk5sTElGY3o0Y0UwZWZXZTBzZlNZdmJwVlNqTEF2d0NZUzNuWlFYQjZw?=
 =?utf-8?B?WU9rRzE0NkFaMlJuUFYrcW1ER1pRYTBTditlSkh2ajgrbytRUnJ6d1ZwK1hn?=
 =?utf-8?B?dmZSMEtYQWdHSzF3TWF5Z2s2Ykx3QmJFRFRrSWhnQWFYNkdFZ0EyM29MUDlR?=
 =?utf-8?B?amJqVkZKRjZnUEhBbC8wL2pVU1JJWkNzVkJGYVZNeXE4My9IdExGbnBEczVz?=
 =?utf-8?B?bGtnNmdtYmNicE9ldjVobTZEMGx4Z2dNQzIxZDVUYm5GWEJQdXdtT0EvRW5k?=
 =?utf-8?Q?tbQWozrwx9pdU9HxU8gmza7hV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18DF0DF0021530499EB0C2C2380BAB3F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6fb7fe-1a0e-4088-7111-08da649a1c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 06:37:08.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gwk8BKgIyR1s9G2S80hr/UxN7a1DuRuU0hrf+XjK6VSRxHgjoQU6FB0tkby6YJ31sBd4mJ7U1JPulH8dPRaRb99Dz1AJSPBACYT/0byRdhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2617
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDcvMjAyMiAxNDo1NSwgWWFuZyBZaW5nbGlhbmcgd3JvdGU6DQo+IFRoaXMgcmV2ZXJ0
cyBjb21taXQgNTllYmJlNDBmYjUxZTMwNzAzMmFlN2Y2M2IyNzQ5ZmFkMmQ0NjM1YS4NCj4gDQo+
IElmIGRldm1fYWRkX2FjdGlvbigpIGZhaWxzIGluIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgp
LA0KPiBkZXZtX3NwaV91bnJlZ2lzdGVyKCkgd2lsbCBiZSBjYWxsZWQsIGl0IGRlY3JlYXNlcyB0
aGUNCj4gcmVmY291bnQgb2YgJ2N0bHItPmRldicgdG8gMCwgdGhlbiBpdCB3aWxsIGNhdXNlIHVh
ZiBpbg0KPiB0aGUgZHJpdmVycyB0aGF0IGNhbGxpbmcgc3BpX3B1dF9jb250cm9sbGVyKCkgaW4g
ZXJyb3IgcGF0aC4NCg0KV2hldGhlciBhIHJldmVydCBpcyB0aGUgcmlnaHQgZml4IG9yIG5vdCwg
dGhpcyBpcyB0aGUgc2FtZQ0KY29uY2x1c2lvbiBJIGNhbWUgdG8gcmVhZGluZyB5b3VyIHBhdGNo
IGZvciBteSBkcml2ZXIgJiBvbg0KdGhhdCBiYXNpczoNCg0KUmV2aWV3ZWQtYnk6IENvbm9yIERv
b2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNClNlZW1zIGxpa2UgdGhlIG1hc3Rl
ciB2YXJpYW50IG9mIHRoaXMgaXMgdXNlZCBvdmVyIDQwIHRpbWVzOg0KcmcgIig/cylkZXZtX3Nw
aV9yZWdpc3Rlcl9tYXN0ZXIuKm1hc3Rlcl9wdXQiIGRyaXZlcnMvc3BpIC0tbXVsdGlsaW5lIC1s
DQoNCj4gDQo+IEZpeGVzOiA1OWViYmU0MGZiNTEgKCJzcGk6IHNpbXBsaWZ5IGRldm1fc3BpX3Jl
Z2lzdGVyX2NvbnRyb2xsZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFlpbmdsaWFuZyA8eWFu
Z3lpbmdsaWFuZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3NwaS9zcGkuYyB8IDE5
ICsrKysrKysrKysrKysrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGkuYyBi
L2RyaXZlcnMvc3BpL3NwaS5jDQo+IGluZGV4IGRjMWEzMjRlMzI3MS4uZWY3NTFjY2Q2NWJlIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGkuYw0KPiArKysgYi9kcml2ZXJzL3NwaS9zcGku
Yw0KPiBAQCAtMzEzMCw5ICszMTMwLDkgQEAgaW50IHNwaV9yZWdpc3Rlcl9jb250cm9sbGVyKHN0
cnVjdCBzcGlfY29udHJvbGxlciAqY3RscikNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwo
c3BpX3JlZ2lzdGVyX2NvbnRyb2xsZXIpOw0KPiAgIA0KPiAtc3RhdGljIHZvaWQgZGV2bV9zcGlf
dW5yZWdpc3Rlcih2b2lkICpjdGxyKQ0KPiArc3RhdGljIHZvaWQgZGV2bV9zcGlfdW5yZWdpc3Rl
cihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKnJlcykNCj4gICB7DQo+IC0Jc3BpX3VucmVnaXN0
ZXJfY29udHJvbGxlcihjdGxyKTsNCj4gKwlzcGlfdW5yZWdpc3Rlcl9jb250cm9sbGVyKCooc3Ry
dWN0IHNwaV9jb250cm9sbGVyICoqKXJlcyk7DQo+ICAgfQ0KPiAgIA0KPiAgIC8qKg0KPiBAQCAt
MzE1MSwxMyArMzE1MSwyMiBAQCBzdGF0aWMgdm9pZCBkZXZtX3NwaV91bnJlZ2lzdGVyKHZvaWQg
KmN0bHIpDQo+ICAgaW50IGRldm1fc3BpX3JlZ2lzdGVyX2NvbnRyb2xsZXIoc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiAgIAkJCQkgc3RydWN0IHNwaV9jb250cm9sbGVyICpjdGxyKQ0KPiAgIHsNCj4g
KwlzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKipwdHI7DQo+ICAgCWludCByZXQ7DQo+ICAgDQo+ICsJ
cHRyID0gZGV2cmVzX2FsbG9jKGRldm1fc3BpX3VucmVnaXN0ZXIsIHNpemVvZigqcHRyKSwgR0ZQ
X0tFUk5FTCk7DQo+ICsJaWYgKCFwdHIpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICAg
CXJldCA9IHNwaV9yZWdpc3Rlcl9jb250cm9sbGVyKGN0bHIpOw0KPiAtCWlmIChyZXQpDQo+IC0J
CXJldHVybiByZXQ7DQo+ICsJaWYgKCFyZXQpIHsNCj4gKwkJKnB0ciA9IGN0bHI7DQo+ICsJCWRl
dnJlc19hZGQoZGV2LCBwdHIpOw0KPiArCX0gZWxzZSB7DQo+ICsJCWRldnJlc19mcmVlKHB0cik7
DQo+ICsJfQ0KPiAgIA0KPiAtCXJldHVybiBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCBk
ZXZtX3NwaV91bnJlZ2lzdGVyLCBjdGxyKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAgIH0NCj4gICBF
WFBPUlRfU1lNQk9MX0dQTChkZXZtX3NwaV9yZWdpc3Rlcl9jb250cm9sbGVyKTsNCj4gICANCg==
