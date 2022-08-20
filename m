Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B878359ABD3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbiHTGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245589AbiHTGsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:48:50 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2130.outbound.protection.outlook.com [40.107.127.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632E829C82;
        Fri, 19 Aug 2022 23:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpIbPzn9FLujIK5ZtPfhNpv4DVxIPXcsqQt1K1+K6TqgsC0beyxOw42WHTzDwCYp00ugAvkaRP4yyejh3gFnLpdVgqpZMQO9HQg6B9618Nr/BmOy2p3E+z1IQbKMZKc2tgjvmGfTeA0wWiOqwc0CnnRsp8I/l0wlxSK6Oi4GikO2cYAOUw4tEqQ0WInbFfziJgQbEVakq0KJu3MksLJYIhIvgiAwS5vWwPbGMo92zwUVte5s/vCMHXSB6BNZteh/LcFI7sZTXQF9KY00Tb1jgXJNRFhQPaRjnWHEZnuq+uqhO8dUbjZBmEAm/gf4hSrQVMvuBSGMZRhHA9PmcmZkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEWK4OgjuPUQRb+S1geULLr3dLEGX3fm1WL3Tx05xTk=;
 b=AbosPkjRQNg3m0yHjaE4YzqAIwtiMJ55kZZe4zZ293yxxAYAUT5nUmivwrArsubwQTGHw0ov8mdkzWJVK/ADd1lB8NAPeL5sxEoaOqpLL/7ZawEfgpHMmVdCjLM8aBz2XyqC2tXV208HgM/8mYtl2D5qkBvk+05O7p+ubaOWKpg9e7FT9ZGMmw1nVTcPy5skB7TjsTypCUCVZuBW1o8gkNFSJHMu3OraN/EzdrbKBaiaktzLskoeVVffYGY52vSgVZyOYmTezKrGFZ+n56oiPQziDwXB1EeK+306Ul4zXOOIvigUADiYSptVr8bvA9p/VymZAXjdkWTEpUmFPeHUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEWK4OgjuPUQRb+S1geULLr3dLEGX3fm1WL3Tx05xTk=;
 b=ynlIeZwXggPfiD4qLRYIP54oAG/aynoqthdq46jg7M5A7JN1ymZOCaMWp66RgoWbeKakIZl4+0sNprS0xSeOfzcMyMnsTvolBtxXwgXW7X2sVXzgh19bE6WbbHTq/iC39FFdhEtMDRlK8rSUUE96kEC08YpgzWyBXc4sAXspQfI=
Received: from FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:44::8) by
 BE0P281MB0066.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.10; Sat, 20 Aug 2022 06:48:40 +0000
Received: from FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7171:f645:764c:13d4]) by FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7171:f645:764c:13d4%9]) with mapi id 15.20.5566.004; Sat, 20 Aug 2022
 06:48:40 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
Thread-Index: AQHYtACmW7LThFXrJk6XtUKUaL8f3K2230iAgAByLoCAAAHeAIAABmyA
Date:   Sat, 20 Aug 2022 06:48:40 +0000
Message-ID: <0823a6e8-b325-78c5-d060-c5f9442e3df8@fi.rohmeurope.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
 <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com>
 <CAHp75VdGhXpD8YgwkVPLCBEMmupBiTDS4FChocJFVo+BBZ-2KA@mail.gmail.com>
In-Reply-To: <CAHp75VdGhXpD8YgwkVPLCBEMmupBiTDS4FChocJFVo+BBZ-2KA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca92e24a-ac7d-4b5e-4154-08da82780436
x-ms-traffictypediagnostic: BE0P281MB0066:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTyWHkwbmpMTdlYlqDJZLKpfUr438fSjwMmH72tyW4MsSX0ys9BTs6QYZfT/FCjigI0b3DSy5QSHWvrC1M13wCCD3frsiIe6UJKU9uQt53Rxxq/SdfDqn7uQfzMgvUpaDaqx365N8kYe2xBpIUur02nLrmeyHUgTrqha1od+5W0CpjPpvVfKS85pg31OomYs8ttBrv8HdAyGwQwOtxYUR5unhddUYjgelj71xvquSOQ2u9yK72OKLDGAkokF/uq4ZrTb2s8qY/CxyLK2pPrh0yThx78i6JmSF1jCF97r40q7401n4Hq/3FVDYEmYs0MKCP7xetW5MLz3NhN3IiHxgr3pOn0CNSIlGayYnUOWkX+LjvYiNjfDNRznk5N1l8Nlbky3cizboQ1eIlcHQlxT8YQyfASG5KsAZ7RRaydBWrT0gMHwgWoYI1sBqA2kySeZRKSx3Vj6qYGV5v4H9F3PP5g2Pyt37uNViRRQbxtShKTi4wux9rBkq8NxxCvCWxJdrXtLJBw0YfDJIuM/XWuhNXWW2xnLhbmiuiFRPPVj+sYKneL6sV26qaw5OzWEmnAW9DcQfCzOjtYF0A5ewQirv+gaMmQzF3PY/vdfnc52Bnh8lMoOUf/a/FVAZqB+u3s0h6Y3AZQsywpms4frIDYLNbezD95yyIvFeUE76z3UxMbE363BVqWxZCAOVrPu+F1/ydcKwBWjiwFsnNdDcBIZPXaoQNvLmxyYChBlCW/jhrkQo+8usrPov7Oyoz5mb21+aieozp4aXrCbunGqBh+zncerByfAayx6ORqX0Ry7g7N946XI3Ha66RAo4EtWLsf1+ECzkfFg1IpAKPAE7reFDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(396003)(39840400004)(376002)(2616005)(6512007)(31686004)(41300700001)(316002)(6506007)(53546011)(91956017)(122000001)(5660300002)(186003)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(38070700005)(86362001)(6486002)(38100700002)(2906002)(83380400001)(8936002)(478600001)(31696002)(71200400001)(6916009)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODBqODNLUGdBWkZsaDNaSmd4OUluSkVML29wcDRIQndDZFNvK3dFazZQaVJG?=
 =?utf-8?B?eTNYMUZjOTR6NGllK05iVWhvTUQ5a09ERmV3aCs5UGR6Q3N3akVjZE1waGRR?=
 =?utf-8?B?SkxwY1ZiM3lwckdOYkhTWnhMSGI4VUVyZkw5allrRUcvUFdvd3crcmNSbENn?=
 =?utf-8?B?ZXJ5c0drUXFQZlAxU0oyRlorNE8yOHRYWnh5RlNXcWxFNnNnWXRiaml0ZEla?=
 =?utf-8?B?QnZTMGFDYVhFUVlDNVNCS1B1ektEcmNOMlVpZmJQT2FOU0pzSUFqdlRUKzBX?=
 =?utf-8?B?WExySldpNEJ4dkdJT3FVdHNGUHpTcXVjL0wrSlVtTk02RkRHOGVvVjdycUtC?=
 =?utf-8?B?b0MvQVZXbU8rem1vS00rd0EwZmovMk03L0xaNy9tU0Z2VEE2REJOYkV6ZDY0?=
 =?utf-8?B?d2NGZUtWV3p6YTFZcElPN0x4RldsWjQxMUQ2dGtCcnJwMTI0ZHNya3Q1M1FR?=
 =?utf-8?B?WWk3ZTVnY3RIaGRFVmlaVUdKMWF2UDN0N3RScUsvQWR1MWc3K080ZkFkbTAy?=
 =?utf-8?B?Wkpsa1d4dVBZTitmaWlnTjY3aTVNOGtOay9YU2lKWGhpMFRubXl1TjhjZFJV?=
 =?utf-8?B?SEpjWVh0VUFrYU5FZjB4RDV1bTVldUVHNEVvME15OXBPNlYrRFM4bFF6Njds?=
 =?utf-8?B?aitobjNGR1lBSFlMNkxTWmtuZHppREk0NEtQdk1sMkhpYVd6YnJFYnU0VEl6?=
 =?utf-8?B?YmFIbGYwYkVJOTNCbExYNzBYeE1neGJ6S1l4dVhDTFFGQ214UDNDZnNZbVJW?=
 =?utf-8?B?alFocmZlc25vdmRQU1hwOUgxcG8xZkhZR1lqU1cvNlY5eG1jTWdXMVVEaFVX?=
 =?utf-8?B?U0pMUXVoUDVUYlcyOUZzVE9UTjJqOHpVZjlYaUhFUzJrQ0ZSQ2JCcVdyL20z?=
 =?utf-8?B?Szl3UGpyY1dhWG9kbWc1cWN2cFBaQXNQZnBxam8wLzJzbGV1Q3VaaVNaMmVs?=
 =?utf-8?B?cUZ3RHNrZlZuNVZyVVMyRjlDcHhlK1pCUkxPcTlITHBqTFgyZTk4L2hHWjg1?=
 =?utf-8?B?czhpNWp4b3BYV3dqdG8rVlh1eEhJV3ljNFA3a1Z1U3N4SWt6eXBUd1lGaVln?=
 =?utf-8?B?RXQyWEw2Z1pZVzNFL0Vib294eWI5WlJDdi9UVjV6R3RsTjBxSnhTSjZVMEgz?=
 =?utf-8?B?eXl4R095aDlxVmxZTStyc0Z2elBjdGNCeG81NzdGRVB2NDhsNEJGeCtBdkp5?=
 =?utf-8?B?bXNmeTUzSiswR0duYlEvbVloaG9HbE9jdU1tTUxacldvaHNPWkp3RUo2N3ZR?=
 =?utf-8?B?all1eWExZE1VZXJlT3QreGI1VFdyZ2hoUUNhTVk2R1hQRTdxMnQvTmtvL09S?=
 =?utf-8?B?Qlkvc0dYaU5jSWF5bmtGQWErazhzU0cySGNLQ1FoS0VzZkFnMC9WaTZWRUM2?=
 =?utf-8?B?TTFEVm5KQTZGQXRYOWxoNlN5Kzh1ZmRDaUltS01rYVpVTHpnMGNHeUVzVHZa?=
 =?utf-8?B?U0hYUlRvWWcyTUNuUDBTcXFrcWZ1T1AvelVRY2lhTXA5Z1RocmkwWkdncm1z?=
 =?utf-8?B?NmNEV1lsaldJRytKUWdSRkE3VGlHRHFacUVkbUcyOXNVWTEzWmlwZ1d5WDlE?=
 =?utf-8?B?R0doTUNDVUJrZTRmUlFQQW1haDVvL2NDWTVOOUZTRjV6ZVl5dzd6NU5YcXZL?=
 =?utf-8?B?RHIyM2NMREJjajhBZ3VZZ3VEeEsxRnJodDkrQWU1T0dkMUVubGlPUWNUN2hG?=
 =?utf-8?B?a2lkbHVPRElUOWM2SGI5MDd0Ui9zVnc1Zkl2c28vNmpaQlVLZXQzTWxUZUMr?=
 =?utf-8?B?SzZFU1diZlB3a1ZTTThyODJ3YnpkaDJjZUNiZzlaOHJoSjVGVWtaUTZhdGZi?=
 =?utf-8?B?YUpIbVNabVVhTFR0Wm55ZGtCNjBub3FLSisxOWlBbFozVnU2MlJvUC9oN0Rh?=
 =?utf-8?B?MEJPL1ZxWDVLWmxsc0hDSHNXYzNzb2xDU1hNRUhEOUkrMEhnRUtaeU9hMHJa?=
 =?utf-8?B?RHBzOEV0Z0JSRVVyeFI2czlCU3dKZzhudE9SUitXZy9kYW1pSE5UTkZnVFNr?=
 =?utf-8?B?SElJRTdEZkFHdVlzMG5ORUYwMXlCMVhpTlJydHdXSExFUmJrclo5VWplOEFi?=
 =?utf-8?B?a0hlaGhNYUVuNi96M1ptb3k0L3dlZmxZa2N4R09kRmp4SGtQRVhrTVBzajI4?=
 =?utf-8?B?VU5FdmRwZm1OdXZUbTh1a29hTUoydnVDRkV2a29aVm9lRHJoclJuc1MvZmJt?=
 =?utf-8?Q?4Ea88LNb2cBmFIpvOUp8dnc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47334B65C7ABE94DBA5115EB1D1D8D0D@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca92e24a-ac7d-4b5e-4154-08da82780436
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 06:48:40.4541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75IwqYsbdYgfJhokL5379TviEXuK8uVo24iYEcu9uAQu0C8Apg/XQ/NwDRgL4o/L0pUIE74I0+yjkqicAf5owOG0YYB6/dKPQxOd29aRq+qanaq5AJ3eOMjSO9xcXBz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0066
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMC8yMiAwOToyNSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBTYXQsIEF1ZyAy
MCwgMjAyMiBhdCA5OjE5IEFNIFZhaXR0aW5lbiwgTWF0dGkNCj4gPE1hdHRpLlZhaXR0aW5lbkBm
aS5yb2htZXVyb3BlLmNvbT4gd3JvdGU6DQo+PiBPbiA4LzIwLzIyIDAyOjMwLCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6DQo+Pj4gT24gRnJpLCBBdWcgMTksIDIwMjIgYXQgMTA6MjEgUE0gTWF0dGkg
VmFpdHRpbmVuDQo+Pj4gPG1henppZXNhY2NvdW50QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBX
aGF0IGRpZCBJIG1pc3M/DQoNCiA+Pj4+ICAgICAgICAgICBzdHJ1Y3QgYm1nMTYwX2RhdGEgKmRh
dGE7DQogPj4+PiAgICAgICAgICAgc3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCg0KVGhpcyBk
b2VzIGFscmVhZHkgdmlvbGF0ZSB0aGUgcnVsZS4NCg0KPiANCj4+PiB0aGlzIGNhc2UgeW91IGV2
ZW4gY2FuIG1vdmUgaXQgb3V0IG9mIHRoZSBmdW5jdGlvbiwgc28gd2Ugd2lsbCBzZWUNCj4+PiBj
bGVhcmx5IHRoYXQgdGhpcyBpcyAobm90IGEgaGlkZGVuKSBnbG9iYWwgdmFyaWFibGUuDQo+Pg0K
Pj4gSGVyZSBJIGRvIGRpc2FncmVlIHdpdGggeW91LiBNb3ZpbmcgdGhlIGFycmF5IG91dCBvZiB0
aGUgZnVuY3Rpb24gbWFrZXMNCj4+IGl0IF9tdWNoXyBsZXNzIG9idmlvdXMgaXQgaXMgbm90IHVz
ZWQgb3V0c2lkZSB0aGlzIGZ1bmN0aW9uLiBSZWFzb24gZm9yDQo+PiBtYWtpbmcgaXMgInN0YXRp
YyBjb25zdCIgaXMgdG8gYWxsb3cgdGhlIGRhdGEgYmUgcGxhY2VkIGluIHJlYWQtb25seQ0KPj4g
YXJlYSAodGhhbmtzIHRvIEd1ZW50ZXIgd2hvIG9yaWdpbmFsbHkgZ2F2ZSBtZSB0aGlzIHRpcCku
DQo+IA0KPiAic3RhdGljIiBpbiBDIGxhbmd1YWdlIG1lYW5zIHR3byB0aGluZ3MgKHRoYXQncyB3
aGF0IGNvbWUgdG8gbXkgbWluZCk6DQo+IC0gZm9yIGZ1bmN0aW9ucyB0aGlzIHRlbGxzIHRoYXQg
YSBmdW5jdGlvbiBpcyBub3QgdXNlZCBvdXRzaWRlIG9mIHRoZSBtb2R1bGU7DQo+IC0gZm9yIHZh
cmlhYmxlcyB0aGF0IGl0IGlzIGEgX2dsb2JhbF8gdmFyaWFibGUuDQo+IA0KPiBIaWRpbmcgc3Rh
dGljIGluc2lkZSBmdW5jdGlvbnMgaXMgbm90IGEgZ29vZCBjb2RpbmcgcHJhY3RpY2Ugc2luY2Ug
aXQNCj4gaGlkZXMgc2NvcGUgb2YgdGhlIHZhcmlhYmxlLg0KDQpGb3IgY29uc3QgYXJyYXlzIHRo
ZSBzdGF0aWMgaW4gZnVuY3Rpb24gZG9lcyBtYWtlIHNlbnNlLiBCZWluZyBhYmxlIHRvIA0KcGxh
Y2UgdGhlIGRhdGEgaW4gcmVhZC1vbmx5IGFyZWFzIGRvIGhlbHAgd2l0aCB0aGUgbWVtb3J5IG9u
IGxpbWl0ZWQgDQpzeXN0ZW1zLg0KDQo+IEFuZCBpZiB5b3UgbG9vayBpbnRvIHRoZSBrZXJuZWwg
Y29kZSwgSQ0KPiBiZWxpZXZlIHRoZSB1c2UgeW91IGFyZSBwcm9wb3NpbmcgaXMgaW4gbWlub3Jp
dHkuDQoNCkkgZG9uJ3Qga25vdyBhYm91dCB0aGUgc3RhdGlzdGljcy4gV2hhdCBJIGtub3cgaXMg
dGhhdCB3ZSBkbyBoYXZlIGEgDQp0ZWNobmljYWwgYmVuZWZpdHMgd2hlbiB3ZSB1c2Ugc3RhdGlj
IGNvbnN0IGFycmF5cyBpbnN0ZWFkIG9mIG5vbiBzdGF0aWMgDQpvbmVzIGluIHRoZSBmdW5jdGlv
bnMuIEkgZG8gYWxzbyBiZWxpZXZlIHBsYWNpbmcgdGhlIHZhcmlhYmxlcyBpbiBibG9ja3MgDQpp
cyBhIGdvb2QgcHJhY3RpY2UuDQoNCkkgdGVuZCB0byBhZ3JlZSB3aXRoIHlvdSB0aGF0IHVzaW5n
IGxvY2FsLCBub24gY29uc3Qgc3RhdGljcyBoYXMgDQpwaXRmYWxscyAtIGJ1dCB0aGUgcGl0ZmFs
bHMgZG8gbm90IHJlYWxseSBhcHBseSB3aXRoIGNvbnN0IG9uZXMuIFlvdSANCmtub3cgdGhlIHZh
bHVlIGFuZCBoYXZlIG5vIHJhY2VzLiBCZW5lZml0IGlzIHRoYXQganVzdCBieSBzZWVpbmcgdGhh
dCBubyANCnBvaW50ZXIgaXMgcmV0dXJuZWQgeW91IGNhbiBiZSBzdXJlIHRoYXQgbm8gInNhbmUg
Y29kZSIgdXNlcyB0aGUgZGF0YSANCm91dHNpZGUgdGhlIGZ1bmN0aW9uIGl0IHJlc2lkZXMuDQoN
CkJlc3QgUmVnYXJkcw0KCS0tIE1hdHRpDQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQg
Uk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2
ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kg
MUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEg
c2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
