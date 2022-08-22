Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FBC59BB24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiHVINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiHVINQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:13:16 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2108.outbound.protection.outlook.com [40.107.127.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3E21F;
        Mon, 22 Aug 2022 01:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBWCg1nz4UYAsDBWsKYBkxWa8y118/pweLvyjFq1a8QWLQKMm9A13sfeI+i0c/x5xSUOuiVE4Q+2rrbID6QphPcHCKiDOhKBjTAYm5sgWNi7H0p6JJdVP3Nt5+xw+ZcVRhFIQ1spvSRuet0QdKt7zF3v2UbxzONn2qghTAX09oU515rxAeqRjhTMMBQUTUANqda0FhesttOIDy4UDbKceFXZ7OMqSdSMjKeYhPZrtmFDItzet8x1Oy3thmBPGwBELhETm3NCS5C295KxW40p+cVbBLeH5KtbwSx+GfH9T7TC3IfdfAZWySswONR4Z1UOobtLpc+IVFTzDtFx+2MTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIHR/S9mZWphX5dUmTr4SWbyCV7X2E21j7Y6V8eSd2A=;
 b=NuFJ6dITofWXO19mH9iSudLh2QXUE6obzTvZpQmotcTezS4k+jdNEtY5k6yMJ2QOS38MgDmqeIs8zi+iNoyVZwvB2w8F6zXVPSYCd2SSAiOGahpyEwtYQ9jLfOaN21ZYZJfLL4eI4YUtSUqJkeE2NyDBKlH1pMzEWv0nKHWaGmTdCZdmJUEdeBGU6V7P6wdlU1U6NP4bqm5qq5IwMncvhLXpPo8ngljREmCtx5QVDG4brRhe1W7SHIXmhTPa1YGnb1/7RlUE9mfTyMfPNb0kZP6xKJ5vYaG2ZMd8oEfRQOOUWmNCrt20GB6Zyz5vvvGb/eQ9EVC6UMRdKjgQxFQJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIHR/S9mZWphX5dUmTr4SWbyCV7X2E21j7Y6V8eSd2A=;
 b=JI9q3I28zg8M3b4hfI6OfS4QYjfF3/r1FKaytXgSHlHHrgI3LMTXWgufq5s0ACMJNAK1wnsHQkoEDGUmGrxSvl+PWeuD6PTdB6b2Z8oQy21EFZGyscL8hjfsCF+bn4UKFwyrWfiSdQevBD8G5m28bzN4EKsPOsOdJZFIPuhWVjA=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BE0P281MB0194.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 22 Aug
 2022 08:13:09 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::992c:32dd:290c:9688]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::992c:32dd:290c:9688%5]) with mapi id 15.20.5566.014; Mon, 22 Aug 2022
 08:13:09 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
Thread-Topic: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
Thread-Index: AQHYtACcw3J8Xk+6tkuH4OsH18rwpa23pfAAgAAmQ4CAACoggIAAFp4AgAADQYCAABYJgIABMUqAgAE+gYA=
Date:   Mon, 22 Aug 2022 08:13:09 +0000
Message-ID: <9482dea1-fd70-00a7-df4c-640772ea53b4@fi.rohmeurope.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
 <20220820122120.57dddcab@jic23-huawei>
 <412c5d22-d59b-9191-80dd-e3ca11360bc4@gmail.com>
 <CAHp75VdoKtc2QqFcDuJ00KBz6mjg0fnM_WhyVqhCmDVo_3K6kg@mail.gmail.com>
 <01fec744-f3d4-b633-d3ce-bcd86a153132@gmail.com>
 <CAHp75Vd3vyAZbWpZT9SmyD=ecGTAdVNWK=fs_n4OSAqGtGj_gg@mail.gmail.com>
 <103abfae-6c0d-9a2e-2d59-0da4c8be3eb4@gmail.com>
 <CAHp75VchPCHsBcx7mMoGUjz=s4hmfnO6t7DqtpWfg=aGrbo1Fg@mail.gmail.com>
In-Reply-To: <CAHp75VchPCHsBcx7mMoGUjz=s4hmfnO6t7DqtpWfg=aGrbo1Fg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e16539c4-58bf-47d2-5b33-08da84162674
x-ms-traffictypediagnostic: BE0P281MB0194:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vfvk1tL4IwMUCKgZ/l7lWaGsI7J2PHYFarrWR6Qok+uVU4CuJX+Nc0y5wFUHdzxiGHhPDV9dEQwwajIv04nmqosvvOUySqHExJsTuIzqOauIHxhcrYpWz190xai2eEIJD68aU89pZ2e0EyeKe521unUpfECBQQVW5p5UCbb2smyEUBnHOxOPwNFLVCuaP3w8tJmpaU3+xirVTM//gB0+RYmRjr/vxqtKDQxzOzDHwj5dF2Cq+o9l9zCfOcggM9vND31eWQHxLwdgRZzay0Qv93tVSUZVQZIeKUsA3Xtw51Q7T6PorIZC7noEPm9mUBimRFV5t1hQBs/fpkET8XIn6qch8wVnS/qWvV0a0Lmc9cRsZNP8hvXh9ujm2B2cL4/wwO1uVa4h7FvCFbU8aJXzH9E4Dqnkj2oVOlX2BID/jvCvPHu5RGR61n4YFolE+LuYx7kWOXk1mJ5yZ5krVOrabDl2dmsBWA2KGHf4IzlbbqCBdV4TwBWdfw0OBW2h50Tw/l7PoUH9/WLpR67T314zQQ0rspRypQM7m16c/63a9hJrT6Acvn++LwwSplM5+aLh3ZGV0RdIg+2U1ZtZWs6m9sj9zvKTt+zCz7LO9krFL9sVJvs7cBnoKTyCRGF0iTjwIW0hCU2j9tKbHk8aeuo/6myp+WKKUZmMB8cQs1Oi2KHxb6b/WRsQNKnGvgDuIFYuLarqW3hQ8s/Vnf7P2wdnvJWcd+KTCMlFQLj4ME6szMxBhLf3yX1QZVJhJ2w+jXZh9jQ9B1YX8vIvMG6yrM1iYSu7onFy5MoeIs7XjdTU9/IP/r2/Dt+Bk2hclww+CDhjQa7B7g86abRLYulO57ZbxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39840400004)(376002)(136003)(366004)(346002)(316002)(54906003)(110136005)(5660300002)(53546011)(2616005)(6512007)(41300700001)(31686004)(26005)(2906002)(6506007)(186003)(38070700005)(31696002)(86362001)(83380400001)(6486002)(91956017)(4326008)(66556008)(8936002)(76116006)(66476007)(478600001)(64756008)(66446008)(8676002)(66946007)(71200400001)(38100700002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGp0TE9Ubys3aGtUWWh2SzNGRjY2RFFsZEhUSXlyWjdqdUxTcEM5WVBWOUtZ?=
 =?utf-8?B?a0VlOFVrZHZEVGJ6Kzc0RUh0NzJSYVZleWc0Qk5XZ1VlVW0xUlM3bWQ5djNU?=
 =?utf-8?B?Y2NSMXRZeG80SklSY1JlQ25JNEdkdlZaTFZvZmxBdVNzQm5HbGx1ZmtVN0RO?=
 =?utf-8?B?Mm84N3BXVEJvc2tGeXgvRlJqVUdzYTV4UkFYOVBHRmp6L2lhbjNJTE1EWC9L?=
 =?utf-8?B?MTlLNEZxdGJRREZTeUdXcmF0dnZ6dkdpZEl3c3JIbkU2cUVuK2RsVGN1ekJF?=
 =?utf-8?B?TG8vUkxRdU9lTzRGRTRaWTkvZFRNMFFCaGpSb0hRL3pOazVTendoamgrVE9J?=
 =?utf-8?B?YWt6ZUtVTVJJRjVoQm1zVWRrelFmZmd1OWNzOTFaY0pUbzVSTThXR3RmYnFU?=
 =?utf-8?B?VWw5WEJvNndQaVcrZmlUSFNTTkxtV3hsWWhNZFlTdllwN0hmazJjOElwZGY2?=
 =?utf-8?B?N29VcFcwdXVFRUNNbFlMOEdiZytUTmkzTnc3elVhNVNyUG5lVWhqTHFvZldn?=
 =?utf-8?B?bFNUMGprZWtPL0ZwQXZ3ZjFSQWlOQ3lPcTA0bE9UMmtFWlJWaytaWWsvWG5t?=
 =?utf-8?B?UEpLSG9OL0tyM2pFcHVSU04vcVdrMzNLTEFkU0Qzby96bFhNakNSelRFUUFJ?=
 =?utf-8?B?Z1A0eXFnUmpLTHdJY0tYSEtON25pYTYrczB5RnVqZlY0NE9yY0R1Q0h1ZW8z?=
 =?utf-8?B?N2U1R0xabjFhazR0ZDAwcXdDS01WZmY1VWRZcXhZclFQWlBaU2RrZVJROElk?=
 =?utf-8?B?K2daV0JxcklsTmV3QkF1cjNqMC9GZHhTSFY4azZzM0R6eTJVSFlHNG13WDdR?=
 =?utf-8?B?NDNnRXBkdlZHVmppcUt2NFJTZDJiKzBGYituWTZad25TRGE4ZytULzI1dEh4?=
 =?utf-8?B?WW1jc1U2cm5HVmJadVZDejc0VU1LNWhPNXdDNHNlUzhtUTIwNDNpbHNqanBn?=
 =?utf-8?B?VXZYd2taUmsyRFlOaFVUK2ZYUUZFb2tUbW82WUZBa3RWTFp5OHFTQ3l5NE9J?=
 =?utf-8?B?UWdFMDltN3paekxEL3RqWnZvV0NsMzJtSVk2L0M4bVk5Nzc3elVFS3ZGYUo5?=
 =?utf-8?B?emVyY2RRZUNiRTBuZUVxNG5QRXdUN0c0NTcvZWJCWXVIOElUeUlxUFJwZUlz?=
 =?utf-8?B?U2tEZThwcTNvb3A0b3ZEZWVObVErNzRDd0sxZUViK2ZFS3NUS1pvVklrTTNP?=
 =?utf-8?B?Q2F0dG9VL0NhSkFqUGN4YWpHK2xLZHNVUXU2YU5OQ2hqVFVZRWdIOXlzV3ZW?=
 =?utf-8?B?bVdmeGtwM25mMC9IekN0TmVLYkdnbUh1NTlYbkhUZ1ZNQ1BwSnhGVXo3RCsz?=
 =?utf-8?B?M0NlSEVRVGYxRWh6Q1dlTzRrRTl1blpHNDJNUVcrcHgybi9ONDhoQnd4RFB6?=
 =?utf-8?B?eWYzcDc5RnN0OERlMndwYnd0Vk9rYnVsZmEwSXFYNnhjbUkyUjV0RlYzck85?=
 =?utf-8?B?dFhZTjBxeTdxNHhWOFNBTzYrN2drMmRPUkc1THlMbDJLVE9sSjJZZVNqOVN3?=
 =?utf-8?B?Z0swZTd4N3NPcjlrZTJpMlJsdXM1MDFtbFVyK0luNnVFaTBLTjVTYzVOeXF0?=
 =?utf-8?B?V1IyWnorU3F2eW9VdFZwaVI3WGJMcXpaa0NaL21ZcUZZNmc2ZXRyVk1LdzRq?=
 =?utf-8?B?eGx1SkNTckp2QnJuUVZvcnM4eTR3MkJ6MDM5Z0s5T1RRbHJ0a0dvOHN6emJa?=
 =?utf-8?B?K3NaK1hFUWVsQjcxYmd4eHlzTVhnL3NmUkRsV2tBWnFCTE1nT3l0QXY1aTlo?=
 =?utf-8?B?TUhMclpsa0tSb0xVVksvZWRxc2hUQzZuMld0YjVpanJDcUkzVG5id2xCcjlz?=
 =?utf-8?B?dmloTDlDRWxyaGtJSXJERTNvSHMzbng1NERDK1ZZYzFhRk5iKzhPVDdLMGxZ?=
 =?utf-8?B?ZUtOaG5lR1BTYSt2Y3ZPTm44YWpYcGhnOFJRT1RieHVhbVdPWWhoMmo2NGVr?=
 =?utf-8?B?OHIwK1hpOXRPbmdObzZOWXQ3bXJTWkVYS2EyM2Y5cFFBL3BFNk5wVE9CMERF?=
 =?utf-8?B?S2l0TUpoaW45aXh1eGIyNm5PQzIzbDYvN1h5NkUya24xTzE5ZnM1YWd4OGRl?=
 =?utf-8?B?ZnlBSVhrVzJzSk4rSzFITlZTb1hSRHFRUzhhay9NSEp0YmNZOC9vTEFVaG5r?=
 =?utf-8?B?NmJEOFY0NlNjWFMzeTF2aU5ET2poS0o5S2pwMUlYNEFqaW9XZ0U0VWwybzZ0?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89152AFEC88BCB43AA0CC8C399F5CAF5@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e16539c4-58bf-47d2-5b33-08da84162674
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 08:13:09.5021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xA28w4NgJXS5V4P8SXX3ReUSw1eEL+Pk7hCaXhegwre/RVudgm0p8BNs0Ki/IXRy1QyLjqjhakxI9LH2Qto5fTYaCtZfL0EfOodNohgwRHChj38qOHiCcKh2NshVSJyY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0194
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMS8yMiAxNjoxMywgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBTYXQsIEF1ZyAy
MCwgMjAyMiBhdCAxMDowMCBQTSBNYXR0aSBWYWl0dGluZW4NCj4gPG1henppZXNhY2NvdW50QGdt
YWlsLmNvbT4gd3JvdGU6DQo+PiBPbiA4LzIwLzIyIDIwOjQxLCBBbmR5IFNoZXZjaGVua28gd3Jv
dGU6DQo+Pj4gT24gU2F0LCBBdWcgMjAsIDIwMjIgYXQgODozMCBQTSBNYXR0aSBWYWl0dGluZW4N
Cj4+PiA8bWF6emllc2FjY291bnRAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4gT24gOC8yMC8yMiAx
OTowOSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+Pj4gT24gU2F0LCBBdWcgMjAsIDIwMjIg
YXQgNDo0NSBQTSBNYXR0aSBWYWl0dGluZW4NCj4+Pj4+IDxtYXp6aWVzYWNjb3VudEBnbWFpbC5j
b20+IHdyb3RlOg0KPj4+Pj4+IE9uIDgvMjAvMjIgMTQ6MjEsIEpvbmF0aGFuIENhbWVyb24gd3Jv
dGU6DQo+Pj4+Pj4+IE9uIEZyaSwgMTkgQXVnIDIwMjIgMjI6MTk6MTcgKzAzMDANCj4+Pj4+Pj4g
TWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+IHdyb3RlOg0KPj4+DQo+
Pj4gLi4uDQo+Pj4NCj4+Pj4+Pj4gRm9yIHRoZSB3aG9sZSBzdGF0aWMgLyB2cyBub24gc3RhdGlj
LiBNeSBwZXJzb25hbCBwcmVmZXJlbmNlIGlzIG5vdA0KPj4+Pj4+PiB0byBoYXZlIHRoZSBzdGF0
aWMgbWFya2luZyBidXQgSSBkb24ndCBjYXJlIHRoYXQgbXVjaC4NCj4+Pj4+Pg0KPj4+Pj4+IEkn
ZCBsaWtlIHRvIHN0aWNrIHdpdGggdGhlIHN0YXRpYyBoZXJlLiBJIGtub3cgdGhpcyBvbmUgcGFy
dGljdWxhciBhcnJheQ0KPj4+Pj4+IGRvZXMgbm90IGhhdmUgbXVjaCBvZiBhIGZvb3RwcmludCAt
IGJ1dCBJJ2QgbGlrZSB0byBlbmNvdXJhZ2UgdGhlIGhhYml0DQo+Pj4+Pj4gb2YgY29uc2lkZXJp
bmcgdGhlIG1lbW9yeSB1c2FnZS4gVGhpcyBkaXNjdXNzaW9uIHNlcnZlcyBhcyBhbiBleGFtcGxl
IG9mDQo+Pj4+Pj4gaG93IHVua25vd24gdGhlIGltcGFjdCBvZiBtYWtpbmcgY29uc3QgZGF0YSBz
dGF0aWMgaXMuIEkgZGlkbid0IGtub3cNCj4+Pj4+PiB0aGlzIG15c2VsZiB1bnRpbCBTZWJhc3Rp
YW4gZWR1Y2F0ZWQgbWUgOikgIEhlbmNlIG15IHN0cm9uZyBwcmVmZXJlbmNlDQo+Pj4+Pj4gb24g
a2VlcGluZyB0aGlzICdzdGF0aWMnIGFzIGFuIGV4YW1wbGUgZm9yIG90aGVycyB3aG8gYXJlIGFz
IGlnbm9yYW50IGFzDQo+Pj4+Pj4gSSB3ZXJlIDspIEFmdGVyIGFsbCwgaGF2aW5nIGNvbnN0IGRh
dGEgYXJyYXlzIHN0YXRpYyBpcyBxdWl0ZSBhbiBlYXN5DQo+Pj4+Pj4gd2F5IG9mIGltcHJvdmlu
ZyB0aGluZ3MgLSBhbmQgaXQgcmVhbGx5IGRvZXMgbWF0dGVyIHdoZW4gdGhlcmUgaXMgbWFueQ0K
Pj4+Pj4+IG9mIGFycmF5cyAtIG9yIHdoZW4gdGhleSBjb250YWluIGxhcmdlIGRhdGEuDQo+Pj4+
Pg0KPj4+Pj4gQnV0IHN0aWxsIHRoZSBzYW1lIGNvbW1lbnQgYWJvdXQgZ2xvYmFsIHNjb3BlIG9m
IHRoZSB2YXJpYWJsZSBpcyBhcHBsaWVkLg0KPj4+Pg0KPj4+PiBJIGRvbid0IHVuZGVyc3RhbmQg
d2h5IHlvdSBrZWVwIGNsYWltaW5nIHRoZSB2YXJpYWJsZSBpcyBnbG9iYWwgd2hlbiBpdA0KPj4+
PiBpcyBub3Q/DQo+Pj4NCj4+PiBJdCBpcy4gVGhlIHN0YXRpYyBrZXl3b3JkIG1ha2VzIGl0IGds
b2JhbCwgYnV0IHB1dHRpbmcgdGhlIGVudGlyZQ0KPj4+IGRlZmluaXRpb24gaW50byB0aGUgZnVu
Y3Rpb24gaXMgYXNraW5nIGZvciB0cm91Ymxlcy4NCj4gDQo+PiBQbGVhc2UsIGRlc2NyaWJlIHRo
ZSB0cm91YmxlIHdlIGNhbiBnZXQgd2l0aCBhIGxvY2FsIHN0YXRpYyBjb25zdA0KPj4gdmFyaWFi
bGU/IEEgcmVhbCBjb25jcmV0ZSB0aHJlYXQgdGhlcmUgaXMuIEkgaGF2ZSBleHBsYWluZWQgdGhl
IGJlbmVmaXQuDQo+PiBJIGhhdmUgYWxzbyBleHBsYWluZWQgdGhlIGNvbmNyZXRlIHBvc3NpYmls
aXR5IG9mIG5hbWUgY29sbGlzaW9uIHdoZW4gd2UNCj4+IHJlYWxseSBkbyBhIGdsb2JhbCBvdXQg
b2YgbG9jYWwuDQo+IA0KPiBJIHRvbGQgeW91LCB0aGUgYmVuZWZpdCBpcyBub3QgdG8gcGxheSBk
aXJ0eSB0cmlja3Mgb24gZGV2ZWxvcGVycywNCj4gbWFpbnRhaW5lcnMgYW5kIHJldmlld2Vycy4N
Cg0KSSBzZWUgbm90aGluZyBjb25jcmV0ZSBpbiB0aGF0IHN0YXRlbWVudC4NCg0KPiBJdCdzIHNp
bXBseSBoYXJkZXIgdG8gcmVhZCB0aGUgY29kZSBhbmQgZ2V0DQo+IHRoZSB1c2FnZSBvZiB0aGUg
dmFyaWFibGUgdGhhdCBsaWZldGltZSBpcyBvdXQgb2Ygc2NvcGUgb2YgdGhlDQo+IGZ1bmN0aW9u
Lg0KDQpUaGlzIHN0aWxsIG1ha2VzIG5vIHNlbnNlIHRvIG1lLiBMaWZldGltZSBpcyB0aGUgc2Ft
ZSBldmVuIGlmIHdlIHB1dCB0aGUgDQp2YXJpYWJsZSBvdXQgb2YgdGhlIGZ1bmN0aW9uIGFzIHlv
dSBzdWdnZXN0ZWQuIEl0IGRvZXMgbm90IGNoYW5nZS4gQW5kIGEgDQpyZXZpZXdlciBtaXNzaW5n
IHRoYXQgZmFjdCBmb3IgYSBjb25zdCBkYXRhIGRvZXMgcmVhbGx5IG5vdCBtYXR0ZXIuIA0KVmFy
aWFibGUgaXMgdGhlcmUgd2hlbiBmdW5jdGlvbiBpcyBlbnRlcmVkLCBpdCBoYXMgYWx3YXlzIHRo
ZSBzYW1lIHZhbHVlIA0KLSBpdCBqdXN0IGlzIG5vdCBpbiB0aGUgc3RhY2suIEkgYWdyZWUgdGhh
dCBhIHZhcmlhYmxlIHdoaWNoIHZhbHVlIG1heSANCmNoYW5nZSBiZXR3ZWVuIGZ1bmN0aW9uIGNh
bGxzIGlzIG1vcmUgZGlmZmljdWx0IHRvIHRyYWNrIHdoZW4gaXQgaXMgDQpzdGF0aWMuIFRoaXMg
aXMgbm90IHRoZSBjYXNlIGhlcmUuDQoNCkZvciBhIHJldmlld2VyIG9yIGNvZGUgcmVhZGVyIGl0
IGlzIGFjdHVhbGx5IF9tdWNoIHNpbXBsZXJfIHRvIHNlZSB3aGVyZSANCnRoZSB2YXJpYWJsZSBp
cyB1c2VkIHdoZW4gd2UgcHV0IGl0IGluIHRoZSBibG9jayB3aGVyZSBpdCBpcyB1c2VkLiBJZiBJ
IA0KZGlkIGFzIHlvdSBzdWdnZXN0ZWQgYW5kIHB1bGxlZCBpdCBvdXQgb2YgdGhlIGZ1bmN0aW9u
IHRoZW4gZXZlcnkgY29kZSANCnJlYWRlciBzaG91bGQgZ3JlcCB0aGUgd2hvbGUgZmlsZSB0byBk
ZXRlY3QgdGhlIHVzZS4gTm93IHJlYWRlcnMgb25seSANCm5lZWQgdG8gY2hlY2sgaWYgYSBwb2lu
dGVyIHRvIHRoZSB2YXJpYWJsZSBpcyByZXR1cm5lZCBvdXQgb2YgdGhlIA0KZnVuY3Rpb24uIE9o
LCBhbmQgdGhpcyBzYW1lIGNoZWNrIHNob3VsZCBiZSBkb25lIGZvciB0cnVseSBnbG9iYWwgDQp2
YXJpYWJsZXMgdG9vIC0gYXMgdXNlcnMgY2FuIHN0b3JlIHRoZSBwb2ludGVyIHRvIHNvbWV0aGlu
ZyB3aGljaCBkb2VzIA0Kbm90IG1hdGNoIHRoZSBncmVwLg0KDQpTbywgYWdhaW4uIFB1dHRpbmcg
dGhlIHZhcmlhYmxlcyAoYWxzbyBzdGF0aWMgb25lcykgaW4gdGhlIGJsb2NrcyBkbyANCm1ha2Ug
Y29kZSByZWFkaW5nIGFuZCByZXZpZXdpbmcgX2Vhc2llcl8uDQoNCj4gDQo+Pj4gSSBndWVzcyBz
b21lIEMgc3RhbmRhcmQgY2hhcHRlciBkZXNjcmliZXMgdGhhdCBpbiBub24tdW5kZXJzdGFuZGFi
bGUgbGFuZ3VhZ2UuDQo+Pj4NCj4+Pj4+IEFzIEkgZXhwbGFpbmVkIGJlZm9yZSwgaGlkaW5nIGds
b2JhbCB2YXJpYWJsZXMgaW5zaWRlIGEgZnVuY3Rpb24gaXMgYQ0KPj4+Pj4gYmFkIGNvZGUgcHJh
Y3RpY2UuDQo+Pj4+DQo+Pj4+IEkgZG9uJ3QgcmVhbGx5IGdldCB3aGF0IHlvdSBtZWFuIGhlcmUu
IEFuZCBJIGRlZmluaXRlbHkgZG9uJ3Qgc2VlIGFueQ0KPj4+PiBpbXByb3ZlbWVudCBpZiB3ZSB3
b3VsZCByZWFsbHkgdXNlIGEgZ2xvYmFsIHZhcmlhYmxlIGluc3RlYWQgb2YgYSBsb2NhbCBvbmUu
DQo+Pj4NCj4+PiBUaGUgaW1wcm92ZW1lbnQgaXMgYXZvaWQgaGlkaW5nIHRoZSBnbG9iYWwgdmFy
aWFibGUgdG8gdGhlIGxvY2FsIG5hbWVzcGFjZS4NCj4+DQo+PiBJIGd1ZXNzIHlvdSBtZWFuIHRo
YXQgeW91IG1heSBtaXNzIHRoZSBmYWN0IHRoYXQgYSB2YXJpYWJsZSBzdGF5cyB0aGVyZQ0KPj4g
ZXZlbiBhZnRlciBleGVjdXRpb24gZXhpdHMgdGhlIGZ1bmN0aW9uLCByaWdodD8gT2ssIGxldCdz
IGFzc3VtZSBzb21lb25lDQo+PiBtaXNzZXMgdGhpcyBwb2ludCB3aGVuIHJlYWRpbmcgdGhlIGNv
ZGUuIE5vdywgcGxlYXNlIGRlc2NyaWJlIG1lIHRoZQ0KPj4gcG90ZW50aWFsIGlzc3VlcyB0aGlz
IGNhbiBjYXVzZSBrbm93aW5nIG91ciBzdGF0aWMgaXMgY29uc3QgYW5kIGRvZXNuJ3QNCj4+IGNo
YW5nZSB0aGUgdmFsdWUuDQo+IA0KPiBXaGVuIHlvdSBoaWRlIHRoZSBzdGF0aWMgdmFyaWFibGUg
aW5zaWRlIHRoZSBmdW5jdGlvbiwgeW91IHNpbXBseQ0KPiBuYXJyb3cgdmlzaWJpbGl0eSB0byB0
aGUgY29tcGlsZXIsIGJ1dCB0aGUgdmFyaWFibGUgc3RheXMgYWxsIHRoZSB0aW1lDQo+IHRoZSBt
b2R1bGUgaXMgaW4uDQoNClllcy4gVGhlIGNvbnN0YW50LCB1bmNoYW5naW5nIGRhdGEgc3RheXMg
dGhlcmUgYWxsIHRoZSB0aW1lLiBIb3cgZG9lcyBpdCANCm1ha2UgeW91ciByZXZpZXdpbmcgaGFy
ZGVyPyBXaHkgZG8geW91IGNhcmUgd2hldGhlciB0aGUgZGF0YSBzdGF5cyBpbiANCnRoZSBzYW1l
IHBsYWNlIG9yIG5vdD8gV2hhdCB5b3Ugc2hvdWxkIGJlIGludGVyZXN0ZWQgaXMgd2hlcmUgYW5k
IGhvdyANCnRoZSBkYXRhIGlzIGFjY2Vzc2VkIC0gYW5kIHRoaXMgaXMgd2hlcmUgaGF2aW5nIHRo
ZSB2YXJpYWJsZSBsb2NhbCB3aWxsIA0KYWN0dWFsbHkgaGVscCB5b3UuDQoNCk1vcmUgSSB0aGlu
ayBvZiB0aGlzLCBsZXNzIEkgY2FuIHNlZSB0aGUgcHJvYmxlbSB5b3Ugc2VlIDooDQoNCkJlc3Qg
UmVnYXJkcw0KCS0tIE1hdHRpDQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBT
ZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpS
T0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkw
MjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0
dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
