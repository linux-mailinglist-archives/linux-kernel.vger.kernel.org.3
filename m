Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222D59B8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiHVFua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiHVFu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:50:27 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2096.outbound.protection.outlook.com [40.107.135.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3247E25EB0;
        Sun, 21 Aug 2022 22:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2XQsDkQrMHtBR7IkILlxlrdi1tkJv2Q0YUbgRhO6/sz5XrxRfWM6rbVHKp9Ly1340Clx87zRdIXc1zko6WNMw0mlUM9FPh83LStuc8BW2KjikrUTlgToofQZqf5Brkb0PKzt8QXsEzCn+GQYD9bLPnrQuTKWMwdZb6u+bNxyv583wRKcc4JyRtWexiZDDGJo7ozNTaebLf8MKExnK9Bk0Iqvd8MIq4YEv2oUZF+iwjL9uaEta9bg12+Ty4eXU5ajoqcH0LwAON+H5kVNRo+uIgD/lS11twssEXmNdVPQgy+q0BOKpYOXz4E2MyK7ISa1X6rdZj8z0+siJjkF6Zh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ6w+fRY8XwOi8WXehmrPlr6hIpFUiQDPKZ6SjLymdk=;
 b=ZAhzDpJjDTVF+J/QU0pPdznGse5eF18te5JmdvhYSDrcgm/PR4caneKURWAl8DQQQ2qapKjuA8h8C6HpyIWNkfPhzNyHX+QU13slZdrkmCsdQnr/wN3cFVmZGqK0oTnTxFjryGA8hwdWp+e3xbEvW3cMAWFr1srcqWIUpI0dll1hnpwkkNuYF4T6fO3l43BfA1Y7sh2B4UMLMGE3brzDi8JFO8JWCVFN/yIYcuKfnDKSljsqK/9l7fe0gdcyDuFEFWRPN693ZWt0oIHPPeGM13F9vMhgaXZqMPG2EN1wttMH3lUDEdHo5KlZQYNBX20kRmw3E0pvQa+EzXbpZESpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ6w+fRY8XwOi8WXehmrPlr6hIpFUiQDPKZ6SjLymdk=;
 b=lO/go5DPHyBydCOogixFlO5Ow/8fVRApYTjUzGe4Ia/j978zZEYdMTeNpmpKsCUDarB110l5ZaidwKUUYQO820A6v/rCbTjjaJNkCCHymw1qAksqVyEyTTk9EYCwzWHr5Az7yCCO1/cy75+NuVyj+8bP4awrKizQvRaYC/z0Xeg=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR0P281MB1516.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 22 Aug
 2022 05:50:22 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::992c:32dd:290c:9688]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::992c:32dd:290c:9688%5]) with mapi id 15.20.5566.014; Mon, 22 Aug 2022
 05:50:22 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
Thread-Topic: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
Thread-Index: AQHYtACmW7LThFXrJk6XtUKUaL8f3K2230iAgAByLoCAAAHeAIAABmyAgAAIRACAAC62gIAAaR6AgAASRoCAAUoHAIABF/uA
Date:   Mon, 22 Aug 2022 05:50:22 +0000
Message-ID: <19d30866-1b2f-fd45-8ab7-3628319a70d2@fi.rohmeurope.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
 <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com>
 <CAHp75VdGhXpD8YgwkVPLCBEMmupBiTDS4FChocJFVo+BBZ-2KA@mail.gmail.com>
 <0823a6e8-b325-78c5-d060-c5f9442e3df8@fi.rohmeurope.com>
 <CAHp75VdMA5mkxkMrtiRTGn5F-5GWjxKyuD5iBuj3HKWqZZMxkg@mail.gmail.com>
 <cff8d041-f3c4-3faf-85a9-acabe60d2de2@gmail.com>
 <CAHp75VcVziFMbPtKi1FgD1VR42HjeLUJ5fzxYSRqEbfSZ185oQ@mail.gmail.com>
 <7c2651fe-4f3e-70fd-bdaa-35cb0d66a31a@gmail.com>
 <CAHp75VfOYrDvNJ-ikGN2EU1NRjmQbiyfX-5TL2cUpZ1dreFBUQ@mail.gmail.com>
In-Reply-To: <CAHp75VfOYrDvNJ-ikGN2EU1NRjmQbiyfX-5TL2cUpZ1dreFBUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc68dad8-72ec-464b-808f-08da840233f4
x-ms-traffictypediagnostic: FR0P281MB1516:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: th/sMJTBOUWSz9E/3NxtzndH2XUEJLToUDmbBs4vQ/Vi2r2UFNcEX8w3g/tDeE141ImAZEmD6tLZXOF5PvhlFOedglF5ozTnwXpksKTzlmvJyIej8xBIJo7FZ+Koq2WTMQ3o6R1UuSYKsYdhq4OWffQR/7t4GJDb9Fvm9wGRuY0jg31ogY2i2PKvx4VCN9bw96K3DJUBwV2c5pbVepRkhEOHJ5sHOjRXx8f/GW39UJidh4H2Me4NUPx9jFmySferob4+/lAvFC2pajaq3+Pz8OifhpAWlSNQcRU9D4V0rKTjCiYKN6WirpCJ68J6KRPLZ9kT9B+OhR8jkCOKCK54z+1MVtc9WhqCFoNHivm7ws9+ZWEADJ2zb3JojGje1Wc8yIfjtSRP7ntO2tS0Fvy9b8CNqPTcX6cR1GZt2ngoO+BVzKy3CwEOUjPsJhTDks4EX8O/Flq7BY3xNhdukacLNZfTGsULpi5VN0CtKUANMuvZanhnF06aPhx3UqM9odJHdPIzf9Zg+0I3Soq/ovA7L+h2l03ifljSxqVkCYVu/HDjviPvQ56xA9YQFphhsg82m1s1+nzv1dmVaiqa4tuCW0Yw28R5JPjKIO74giqnY2BU9pYODktat6ZO7kOaJ0QKCpY3E7Pf8z9QA3lx/UvYE/ww1tslv02lc9TKNwirRZYyhfX6v9+I3l2bXQb7fhQ59MwLbDp2eejh0MP1sgYY4xAuKuhlX/zRCB9vB9SrrGo3OGaCWIxHisvkK0VSqNOJfgVBDKzCR/BHIFQRydB5MmzTgUrMvAW6PHgDVH2eEwS5VmROaze5r4NyBsyx4mRfsxacrA7e/TJxqGKMsrWWYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39830400003)(376002)(366004)(346002)(136003)(6486002)(41300700001)(8676002)(478600001)(4326008)(316002)(91956017)(54906003)(38100700002)(110136005)(76116006)(66946007)(66446008)(66476007)(66556008)(64756008)(8936002)(2616005)(186003)(83380400001)(38070700005)(31696002)(122000001)(2906002)(71200400001)(31686004)(86362001)(6506007)(6512007)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDREd0t2cEh6bk0wUGY1dk9QQ0ZPUHRWOVhkdTBCcGRuQXd5OHZoN0NVS29w?=
 =?utf-8?B?Zys3b1JNZHhGWjdmSXRqYjJNVFpmOTBKMG9aUHM3VncwcWhyTE5EcjZLeVlD?=
 =?utf-8?B?YTdIV3JDSGFza1hmay94cG4ybXFxcWwyelgxU29iQ3Q4c0JWMW9FN3MxYUVr?=
 =?utf-8?B?RTk5QmhwbHFYK1dZQkM0d0FkL01LOFBURE1FRTJDK3I3ZGpsYVdsOTVHeEE1?=
 =?utf-8?B?cG5qZnY2VmwzRDlVUm5iYU9uWHhkdjdUdzRGK2ZYNk9na2JqZ3pwY2x2eXJ0?=
 =?utf-8?B?RFI0VWhraTJ1Wlh1cy9zSnFsbWx1L1BHNDMwRWg0ZTcwdXNpc1I4d0pPSHpm?=
 =?utf-8?B?QjRGcG9kTUV5dHptYnNQalo5cjdCY29tVXh2V0FVdkVYZXVXcHdOM1BqbjRw?=
 =?utf-8?B?V1Jrc3VKeHF6b1FuVC9DWGloMnZLZjhCcjNwblBaaFhMMU1lMGt6U21ZbE9M?=
 =?utf-8?B?dmNqS09vWkg0SWt2S2VoNDExblRlbWEzVnh0aGkzZXBWNEFkWVZSVUNIdHJo?=
 =?utf-8?B?NGo0dzBZV1dVN3ozYnYvRU44OEd1dUNKb2RFQTNCR3IzZjMzSzdGcyt3Q1RI?=
 =?utf-8?B?UlR1WFFmS2hLMURQUk5pdHVjMlVZaTNFVlFTblpPWXM4bW9XeGpEb3BiYzlS?=
 =?utf-8?B?VEVOYTFWVnRET0o4Q2ZXYXNhVEYyVVUxTU1JcG95bjI0UlhoNWJ3ZC9WZmow?=
 =?utf-8?B?a0RIV1pra0xnZ0N3NVc2RnhUU29RK05kL1RsWnpTcmlJc29ZWndCUTRXTDg5?=
 =?utf-8?B?UWxZdmllempubFNaQmY1VC9EWEpLWUlQRGcwYWtoUm9McWJJUm5OWDdVSFVs?=
 =?utf-8?B?Vmh5SVNBSkZEdDVMSGJueklTT0NOSEhBMUxKckFaU0hZd2s2MDlkYS80MXh4?=
 =?utf-8?B?L0YrK3RlQkVJcjNpV05VVXBmMEd4OUpieTNDVWkwR1ZoVXVpakNXbjNQeEts?=
 =?utf-8?B?K1BRQUR4ZGN4SHQ3TkRmOW9MWE51L2RCVVdRRStUc213UWhpVmgvYVpZbVZN?=
 =?utf-8?B?OUlJUDVDRHd3U2UxdE4xZUFSVU5mSGpNQk1BdXVzdVMvdTdseWpkVHlJSHdL?=
 =?utf-8?B?eHNqSWZxMjRzZklqVzFRdGxwNDBhYTdZZmh3WkxSaWl2SGhJMU54VjN2WFRI?=
 =?utf-8?B?LzVjYVZzVkpMQ2E2YmpHM1h2K3JtMVV5d2NLMVBNM05WZTc4NHJ6a1pGeElr?=
 =?utf-8?B?dlRrbjN4cEw1aXFMR1B1cXhIL1FDOTFjdFVMK2k2YnJPRit1aDg0KzdDTVVm?=
 =?utf-8?B?TlJHN3krQkhaeC9aZDh3cURyUzVKZHdpMUtuVUhoQXd0NTFpa1dvUXlQSHFx?=
 =?utf-8?B?dmRUZ2dqczVLUGZMZTQrV1ZpV01OVHgwTnExYTIyeWl4dGdPV3M3SjJqUDZw?=
 =?utf-8?B?cWdtMHVSaTcxNjdIY21BcElSRWZMYkRNQTJlbHhwMWlpQytjSGMzYmR0MGNl?=
 =?utf-8?B?RDlxcWtVLzhxTEtzZ1h2b3hsOEFGVnlUTU1wNjhEVTBPbGlMcjRUS0VhNUJV?=
 =?utf-8?B?Tkp1VDFyV0ZjQ2ZucVovdnBpSU96R3hBTDlXT3g3SWFSS2k0Z1lWS21XWU9u?=
 =?utf-8?B?Lyt4WXlOSit3N3ZTZDlBS0wzSmd5Y1NMSUkxMU90aWc2Z21NbWljU2hXYWlQ?=
 =?utf-8?B?YWF4WXh3RFpGQi9iYjlxbVJVL050V2lRNzZ2WkxRc0tmSDJCeHRvcFYySnNW?=
 =?utf-8?B?bGpXSUd4ZHdrREhJY2dFNHVrdS96WWRqbmlNdFdpTUdYTmtWdGQxR0tTVlVX?=
 =?utf-8?B?MnFHbzlqbllaWDg2blcxVW1uRWQrS0dXaWFTT0ZxN1YvK2JWWHFZRk9FMEsz?=
 =?utf-8?B?ajlaYUJud1hMQmpSZGRMYXNxYUhBaFpOYXZJYk5WY3VDL3o4SExtTFBURnpq?=
 =?utf-8?B?bTk0WTYvaXBEaWpXTE1nMUFZalc5ZkpKTzFoN0ZZdkNVd01TQkEyUjVkWVhY?=
 =?utf-8?B?L2dTaVpibUkxbTNWU2Fwa3FTbHlsSVhxUmMxbFZWNGFsdXZIeHo4S2ZRYS9G?=
 =?utf-8?B?cUttU2Y3NEhOd3FzSVV4MzVvZ1V6UDBGTjBVajRHV3AvMlp3OHIvRWY1ckJT?=
 =?utf-8?B?UE9HR3BEL2hMZExzelBBSjc1WVdNSlNBeTk4bW90WUcxQWdnL2ZMeVhYRTZD?=
 =?utf-8?B?cXhDb0lNQy9pOWNvYko2L1dqdXgvQTFwdDFOU3k2WU5PQjBKODE3WnFwY1M2?=
 =?utf-8?Q?P6etQbUwiuKrvmaXiWwS2Y4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12751AC1F7754444AA23A62E2C7D7916@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dc68dad8-72ec-464b-808f-08da840233f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 05:50:22.2184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /84lD8vve5BY6yhdcbL9/FxrZdY0NXUIFUTEru/NJ4TH0A/pAVmeitwjNATxYCcuEb7YBr//Gj/+p+9i/kJhwB3C23neuWzADsV048AwBU02l6KkVVDR7t5aA4qFXCo7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1516
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMS8yMiAxNjowOCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBTYXQsIEF1ZyAy
MCwgMjAyMiBhdCA4OjI3IFBNIE1hdHRpIFZhaXR0aW5lbg0KPiA8bWF6emllc2FjY291bnRAZ21h
aWwuY29tPiB3cm90ZToNCj4+IE9uIDgvMjAvMjIgMTk6MjEsIEFuZHkgU2hldmNoZW5rbyB3cm90
ZToNCj4+PiBPbiBTYXQsIEF1ZyAyMCwgMjAyMiBhdCAxOjA1IFBNIE1hdHRpIFZhaXR0aW5lbg0K
Pj4+IDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+IHdyb3RlOg0KPj4+PiBPbiA4LzIwLzIyIDEw
OjE4LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4+PiBPbiBTYXQsIEF1ZyAyMCwgMjAyMiBh
dCA5OjQ4IEFNIFZhaXR0aW5lbiwgTWF0dGkNCj4+Pj4+IDxNYXR0aS5WYWl0dGluZW5AZmkucm9o
bWV1cm9wZS5jb20+IHdyb3RlOg0KPj4+Pj4+IE9uIDgvMjAvMjIgMDk6MjUsIEFuZHkgU2hldmNo
ZW5rbyB3cm90ZToNCj4+Pj4+Pj4gT24gU2F0LCBBdWcgMjAsIDIwMjIgYXQgOToxOSBBTSBWYWl0
dGluZW4sIE1hdHRpDQo+Pj4+Pj4+IDxNYXR0aS5WYWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+
IHdyb3RlOg0KPj4+Pj4+Pj4gT24gOC8yMC8yMiAwMjozMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3Rl
Og0KPj4+Pj4+Pj4+IE9uIEZyaSwgQXVnIDE5LCAyMDIyIGF0IDEwOjIxIFBNIE1hdHRpIFZhaXR0
aW5lbg0KPj4+Pj4+Pj4+IDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+IHdyb3RlOg0KDQovL3Nu
aXANCg0KPiBTSW5jZSBpdCdzIHN0YXRpYyBpdCdzIGdsb2JhbCBieSBuYXR1cmUsIGJ1dCBsb2Nh
bCBieSBuYW1lc3BhY2UuDQoNCldoaWNoIGlzIGFuIF9pbXByb3ZlbWVudF8gb3ZlciBoYXZpbmcg
aXQgaW4gZ2xvYmFsIG5hbWVzcGFjZT8NCg0KDQo+PiBJdCBjYXVzZXMgbm8gbW9yZSBuYW1lIGNv
bGxpc2lvbnMgdGhhbiBhIHJlZ3VsYXINCj4+IGxvY2FsIHZhcmlhYmxlIGRvZXMgc28gSSByZWFs
bHkgZG9uJ3QgdW5kZXJzdGFuZCB5b3VyIHJlYXNvbmluZy4NCj4gDQo+IEFuZCBJIGhhdmUgbm8g
b3RoZXIgd29yZHMgdG8gZXhwbGFpbiBpdCB0byB5b3UuIFlvdSBhcmUgdXNpbmcgYSBnbG9iYWwN
Cj4gdmFyaWFibGUgaW4gdGhlIHNjb3BlIG9mIGZ1bmN0aW9uLiBUaGlzIGlzIG5vdCBnb29kIGZv
ciB0aGUNCj4gbWFpbnRlbmFuY2UgYW5kIGRldmVsb3BtZW50IGFzIGl0J3MgcHJvbmUgdG8gZ2V0
IGFuIGlzc3VlIGluIHRoZQ0KPiBmdXR1cmUuDQoNCklmIHlvdSBmb3Jlc2VlIHNvbWUgaXNzdWVz
LCBwbGVhc2UgZGVzY3JpYmUgdGhlbSBhcyBJIGRvbid0IHNlZSBvbmUgDQpzaW5nbGUgcHJvYmxl
bSB3aXRoIGEgbG9jYWwgc3RhdGljIGNvbnN0IGRhdGEuIEkgaGF2ZSBzZWVuIHlvdSB0ZWxsaW5n
IA0KbWUgdGhhdCAic3RhdGljIGNvbnN0IiB2YXJpYWJsZXMgYXJlIF9oYXJkZXJfIGZvciB5b3Ug
dG8gcmV2aWV3LiBDb3VsZCANCnlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IGFyZSB0aGUgcG90ZW50
aWFsIG1pc3Rha2UocykgYSByZXZpZXdlciBjYW4gZG8sIA0KYW5kIHdoYXQgaXMgdGhlICdpc3N1
ZScgdGhhdCBtaXN0YWtlIGNhbiBjYXVzZT8NCg0KPj4+IFNvLCB3aG9tIHNob3VsZCB3ZSBsaXN0
ZW4gdG8gaGVyZT8gQmVjYXVzZSBiYWQgY29kZSBpcyBiYWQgY29kZS4gQW5kDQo+Pj4gdGhpcyBp
cyBjb2RlIGFib3ZlLg0KPj4NCj4+IEJhZCBpcyBhIHN1YmplY3RpdmUgY29uY2VwdC4gSSdkIHNh
eSB0aGUgY29kZSBnZXRzIG11Y2ggd29yc2UgaWYgd2UgbWFrZQ0KPj4gdGhlIGxvY2FsIHZhcmlh
YmxlIGEgZ2xvYmFsIG9uZS4NCj4gDQo+IC4uLg0KPiANCj4gDQo+IFRvIHN1bW1hcml6ZSwgd2Ug
aGF2ZSBhIGh1Z2UgZGlzYWdyZWVtZW50IG9uIHRoZSBwbGFjZW1lbnQgb2YgdGhlDQo+IHN0YXRp
YyB2YXJpYWJsZXMuIE5vdCBzdXJlIHdlIGV2ZXIgZ2V0IGludG8gY29tcHJvbWl6ZSBoZXJlLCBz
byBJDQo+IGxlYXZlIGl0IHVwIHRvIG1haW50YWluZXJzLCBidXQgbXkgb3BpbmlvbiB0aGF0IGl0
IGlzIHNpbXBseSBhIGJhZA0KPiBjb2RlIHByYWN0aWNlLg0KDQpCYWQgYW5kIGdvb2QgYXJlIGxh
YmVscyB3ZSBjYW4gcGxhY2Ugb24gdGhpbmdzLiBXZSBob3dldmVyIG5lZWQgdG8gaGF2ZSANCnRo
ZSByZWFzb24gZm9yIHRob3NlIGxhYmVscyB0byBiZSBtZWFuaW5nZnVsLiBJIGFtIHNvcnJ5IGJ1
dCBJIGRvbid0IA0Kd2FudCB0byBsYWJlbCB0aGUgbG9jYWwgX2NvbnN0XyBzdGF0aWMgdmFyaWFi
bGVzIGJhZCB3aXRob3V0IHJlYXNvbi4gDQpUaGlzIGRpc2N1c3Npb24gc3RhcnRzIHRvIHJlbWlu
ZCBtZSBvbiBzdGF0ZW1lbnRzIGxpa2UgInVzaW5nIGdvdG8gaXMgDQphbHdheXMgYmFkIiBvciAi
b25lIG11c3QgbmV2ZXIgdXNlIG1hY3JvcyBpbiBDIi4NCg0KWWVhaCAtIHVsdGltYXRlbHkgaXQg
aXMgYSBtYWludGFpbmVyIGRlY2lzaW9uLg0KDQpCZXN0IFJlZ2FyZHMNCi0tIE1hdHRpDQoNCi0t
IA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBW
YWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5s
YW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4g
dGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
