Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1875D59ABB6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbiHTGTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiHTGTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:19:08 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2114.outbound.protection.outlook.com [40.107.127.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7714746D89;
        Fri, 19 Aug 2022 23:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1MYm63xGoOvtYHfnz4LjVuZSKLlSOvw40eOLh2YNqap5r441sKN/TEss0qAYtS3xB3hes6WMNwTklrf3G5r5Fk21iqEC/lb3+7X8fZbTjSmV3KmCeCLAZzeZ32XoBotVsqBKHCKhu/Az8yl6mQGxwALvgQO6E9uEvobLSUvgcBlfOMzbWOkFKOhZWVO/YwU5Pstb/K8UCwQ8nVTcxuroAGUmqEqSpcLdeLvinZeVcODPD6A6mzHBGPx+2C7v6WSrRwVoRtvOUZJj6/MoUcEYngSN7fh6me4qwFhv7M5ILVaOQ1IwppNSAZOUH8xpNJZF1jyNlaVJJSgy38PWMp0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cXH418cIFooul1UwMGsbJ4yNy7sRQcccN3U3BEp4kY=;
 b=k+8UISzOr37S6hXDMwayETMGEy+7+hQj9OHR0xlNGqMornrZowa7VmlIjUE7hyUyW/iGRPaXqBKmssCAEmybU+LUmMthTXARkQ82moKmMpQwpSoU87yQUwOBuJIZQptLSdDW0g/KJLjFBp/LGDPIs83JVPfBhXVSOgB7TS58cFqwRrj8AmZNKQuSgRWAhozxTdyRItwRdadjGAsd9OD2Plo7dSsRnL/bnG/skQmLxdv4eXTpBfyRplrFeLwe68KSC1Qgqd62mXIjDKhtXeqeZdMG7pp7gNUD0ay6RcmGN+knpX1qgnNDwwZdN2Bn21IvnssxhhRwrnh81lEoV9V/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cXH418cIFooul1UwMGsbJ4yNy7sRQcccN3U3BEp4kY=;
 b=PqPDyKsBMo+pDXzDRwEJ7dwVtMvVhypQaGmcsS4AUrkUJ7/ZOwVu7z/56wOfsByzYMNtHrlcyEO7cdjgmh+uPpLxowf04qoZdhR9r74AZ/4wRxHJ9RcrFJv4dM9EAUBH2E6ABwKBh6UiMDZhEwoNKwpYU996kudaQXt6hpSM7X8=
Received: from FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:44::8) by
 FR3P281MB1998.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:34::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.9; Sat, 20 Aug 2022 06:19:00 +0000
Received: from FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7171:f645:764c:13d4]) by FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7171:f645:764c:13d4%9]) with mapi id 15.20.5566.004; Sat, 20 Aug 2022
 06:19:00 +0000
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
Thread-Index: AQHYtACmW7LThFXrJk6XtUKUaL8f3K2230iAgAByLoA=
Date:   Sat, 20 Aug 2022 06:19:00 +0000
Message-ID: <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
In-Reply-To: <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25d192ff-41f7-4604-54e7-08da8273df14
x-ms-traffictypediagnostic: FR3P281MB1998:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2b5DvCjamlbjWblPY/PfeI8CwNG9rvJLj0tYKQwkxxx2iZhveLo2L+3Ib1MXYAXvay4qBybzxtjGRrJdyejRW7+tGwm+NtO2OToyThYDcOWL0Tm1Lhyssp5TZJimpsNRH416vP9CJtR+ume9UKni4muNDWx3IfJ7af5wFY4ILvz3/lQgFUKZrS0Ja2HQYkUqRb4KtBWirPS6UMjD6Wc92hfMipWEP45sGYguSC8KH1IKJiqvNm380jzU6qDLiV+DdYoaeEAFJmWea5PBydSIzCzyNQTJG/lFezZLnqfegtZPjhXX3eNmU9XobexT/1C9pTOYCv7QPmSlBenYCqq4N7nDXLb4uDLHFsJ2wGCSvtGTlW0yF1J6rclf+VdKVsbQbtVWXOy4W/UbCFilflf1rjNgtF6utA3OUgmjy8t2FYPHhg2IPMZEZIahswfTHfM5ez22S/0nAB2YyURVoSac8a3vavnV1csccYAw4X1UsI2P2Pg1VqTNrPKxanhZ0mlxYb/ec0C8U9YDVrHtbnvw+SzZoPY2cWEv5557WT1YIEgmCQE2LBNysnhAmZJg6J5QOnHaSVWOBP6VAeJmUeQYhZxj2d1nw++9HHiZK8/c+M0FV+/V8LJb66q7QPvCkPnXyRd34S7hy3hImgboFWWVaV8ZtllD9erS/aDgUILQsMixkpy4/WLdB7r65Nb9sKGW51wqrgeG8eJw2rXA2/CZ+lfR5ZymElYa/Vd6SXe6NukmkBCDShnHtHIRdq+M/REd3ixKhJUlbbIEBso2liadLGHZkXlqD7d4dujAjPoizWYY/unmiiRPNpENafu2fsV0o/MW/X6GQCX1X3HvipQEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(366004)(39850400004)(64756008)(91956017)(8676002)(4326008)(110136005)(316002)(76116006)(66476007)(71200400001)(66446008)(66556008)(66946007)(8936002)(31686004)(41300700001)(54906003)(2906002)(53546011)(6506007)(6512007)(5660300002)(2616005)(186003)(86362001)(38070700005)(31696002)(122000001)(83380400001)(478600001)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3lQZFVqbG14S1lVYlNNcEVqOEYxdjRUOEZBRlVEeHdSNTZrUnZTN2RPQzh0?=
 =?utf-8?B?RWJIRW4waDc2UXB0ZXlGdXNpcE15SFQ2OS9Ba1RjK0dhYk1qRmZKbWxPVVNx?=
 =?utf-8?B?QWNXb2xadmEzZEd5SVhxeGxXY0JFU1VmZDJ1a0xSV0RxOXorUndFVUhaSjU0?=
 =?utf-8?B?MDQ4YUxwTVBnNE10V1ZLR3oxaW9BR2VIS1MwdkZ2QUVoQ1hqYk42QjhNQ0Qv?=
 =?utf-8?B?cXhzZWdYWXQvd3gwZHF6ZlVkOHNVdmRJZnJsL3NZMkgvUGRrenJZRHBIR2ZS?=
 =?utf-8?B?c25ZenJkcTUxOGVrRDhzbnAzQmgybFBLL0xDYkJRWlRWTVlzWE02MVZndmF1?=
 =?utf-8?B?TTRwNFB4MkY1V1c0VGRzYkVHeTg1cnMrR3doK3ZQcjBhdlYrUzFTbC94UWlr?=
 =?utf-8?B?WWZBRmNyUFl6SWlRSHIrMXNtQWZQVU5LWG1abTlHdlhOUHhTK3JBOUNaQnh2?=
 =?utf-8?B?WUhnN1pIL2wvZk9BbWJTQitvYkRNYVVtNUY4Q25VeHhva216RGlDZ2gybG1U?=
 =?utf-8?B?V2I2bEZja3g4b0dWZFBxQW9sSktsL0J4TGc1cDdlN1lDY2JzT0s1UWRuMHFy?=
 =?utf-8?B?enZVblR2Z00rdWlyeVNhN3NtK3pyUGpFYStmQW9TYkQzc0ZkV2RLWGhUa21J?=
 =?utf-8?B?bjdSdWdNbTkxR0V5N3lFS2UwNmJ4Y21wN1F4T0grTlF0eHdlam1haFd5VlNv?=
 =?utf-8?B?Sy9PdDYvaGp1RlJwN2krRStpMUpvZ1RaMTV4UFV6M0ZOT3JNVEJlZk5SbWh6?=
 =?utf-8?B?RWU1Z282ckMyT21hOXIySk9ZSk4zUk1LbzRlVGxSYnBJazl1WkwzSmxISDZx?=
 =?utf-8?B?dkNuY09CMHZUZ0JlZW5MZEZJK1dEa1NvaXYyOEFaR3Z3TitVVkZjb0ZzVHhL?=
 =?utf-8?B?ekxqYnpjZWFkQ0lZZS92UHJKM3c1eCszSHlZVjNNcTdnb2VBSHJBL2UwQWFm?=
 =?utf-8?B?dUMxSmpSZ0FhY0tuVklmQ0hqWktSa1phTGpJcXRpWS8vQXJkaGhiUHJ5UHdR?=
 =?utf-8?B?OVhOMWIxY2REUHBFTUkreldLbDIyV3Z5VEJxemJ6UElFNWh5bGt1TmZlYktN?=
 =?utf-8?B?SWpFVmxpZVovajlUYUFhY1pjS2hJcmRVTUtLazhZaGN0VzhLMUgrMmRRaXZH?=
 =?utf-8?B?cm9mRTNPWU1lZDdSbWZhcEt4akEvalZtWXc1bnhHckZWRnZtWE10NDZsblhX?=
 =?utf-8?B?b3JWQXJHNEV4NXI0dmRuVEFoN0hzanlkNm9abzlKTkRpNHljNFVRZWF3am5z?=
 =?utf-8?B?dE1UOEZmeWxLaFh5eDRSazdSZm5sVmI1c01jdm1VTGJpR1E4aGhHSVNUNHlU?=
 =?utf-8?B?eTMrMWdEZzd5QnVDb05vOTBBekk2eVZ5cTc3TmxnQUdqcWp0R2N0V2N2M1lG?=
 =?utf-8?B?VUE1eTRpNUIxVnRjWG5qbGJCKy9wTkpmcmI2QU5ldWM1MmtNbGFtOWMwT1lU?=
 =?utf-8?B?eXcza3dRYlUwSU5QbUhQbitqaEZnQTRjYU1mVHA5bTJKNEJCcXBVbytGd0pX?=
 =?utf-8?B?aytnYTBZZlgwNFI5ZGlZNHZiM05kZ21NNCtOcUoyTWVWY0xwbS9QK3dtbGsv?=
 =?utf-8?B?R21sSkpBbFBOdmd6Si9JZFQxTkNBVFhRb0Y0Ujc1eHRjbk9lejlRWHE3ZHlO?=
 =?utf-8?B?NVRPWXAycEN3YTBUY0VhQm5xY1FTbmpWVlJRWmJXZGRUNGdoODE3L0lhZmg3?=
 =?utf-8?B?c3BKWDJyQWx6SlhzWnlHVTQ0MEVpdW9RTWpaeVMxN1hqd1QvckJaeSsrczJD?=
 =?utf-8?B?cmhyaHYvcWxud0tXSHZyT1RvYUc3RTVzc2VEd0E0S0V6a1B1K042T0U0ckho?=
 =?utf-8?B?anFVTWhRRndUYkgwZktkaGtCMkdPKzAwOWNvOGc2aVZPc0lERVZjR1htTFZC?=
 =?utf-8?B?UWpJbFlDZnBXVTl0cmloSGQ0Z3J3YUd6S2hEVjlPSDNjZllEYVA2bVRYY3B5?=
 =?utf-8?B?ZjM3K0lUZzR6M01aVU1yZyt5UzlyTURnMTJTMDRjcmVqSFZzM292dEk2WUda?=
 =?utf-8?B?WWJoOG8ranZYR2FaZGxsemJmWTN1QXNNSHhmRk1ZMG1sWXpSSU5WQnNyMEJr?=
 =?utf-8?B?blk4UUVOSUgwZm1nQUlrM1lxaGlNajREKy82YXBReE9rUXdINEdDUUc3bkFx?=
 =?utf-8?B?TWlIL1lrMnZFcmFHaFMzSDlaZmV3ZlIwWnA0RWRPUEovZGRBb2JWT3FLYkdK?=
 =?utf-8?Q?PEGqQIfsQjyee4JXCFGDTcE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE3DE023BB08154D92DFDC1A5500C19F@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2461.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d192ff-41f7-4604-54e7-08da8273df14
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 06:19:00.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ASXdpPRVHA4S+xiXpu1TltCQBu4odms0D/wyi80YOpvO/xOp/zqrIK00XOXH4hYJkRm8u7dNYWIM1hbpqS+6115ZdLLjkQldn9RuM23d4R89GfNSnx+BDYGn0gFnVdW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1998
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3IEFuZHkNCg0KT24gOC8yMC8yMiAwMjozMCwgQW5keSBTaGV2
Y2hlbmtvIHdyb3RlOg0KPiBPbiBGcmksIEF1ZyAxOSwgMjAyMiBhdCAxMDoyMSBQTSBNYXR0aSBW
YWl0dGluZW4NCj4gPG1henppZXNhY2NvdW50QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gVXNl
IGRldm1fcmVndWxhdG9yX2J1bGtfZ2V0X2VuYWJsZSgpIGluc3RlYWQgb2Ygb3BlbiBjb2RlZCBi
dWxrLWdldCwNCj4+IGJ1bGstZW5hYmxlLCBhZGQtYWN0aW9uLXRvLWRpc2FibGUtYXQtZGV0YWNo
IC0gcGF0dGVybi4NCj4gDQo+IC4uLg0KPiANCj4+ICAgaW50IGJtZzE2MF9jb3JlX3Byb2JlKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHJlZ21hcCAqcmVnbWFwLCBpbnQgaXJxLA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKQ0KPj4gICB7DQo+PiAgICAgICAg
ICBzdHJ1Y3QgYm1nMTYwX2RhdGEgKmRhdGE7DQo+PiAgICAgICAgICBzdHJ1Y3QgaWlvX2RldiAq
aW5kaW9fZGV2Ow0KPj4gICAgICAgICAgaW50IHJldDsNCj4+ICsgICAgICAgc3RhdGljIGNvbnN0
IGNoYXIgKiBjb25zdCByZWd1bGF0b3JzW10gPSB7InZkZCIsICJ2ZGRpbyJ9Ow0KPiANCj4gUGxl
YXNlLCBrZWVwIHRoaXMgZm9sbG93aW5nIHRoZSAibG9uZ2VzdCBsaW5lIGZpcnN0IiBydWxlLiBO
b3RlLCBpbg0KDQpUaGlzIHdhcyBub3QgZm9sbG93aW5nIHRoZSAoSU1PIHNsaWdodGx5IHNpbGx5
KSBydWxlIGV2ZW4gcHJpb3IgbXkgDQpwYXRjaC4gSSBjYW4gZm9yIHN1cmUgbW92ZSBteSBsaW5l
IHVwIC0gYnV0IHRoYXQgd29uJ3QgZ2l2ZSB5b3UgdGhlIA0KInJldmVyc2UgWC1tYXMgdHJlZSIu
DQoNCkkgZG9uJ3QgaGF2ZSBhbnkgcmVhbCBvYmplY3Rpb25zIG9uIGNoYW5naW5nIHRoZSBzdHls
aW5nIHRob3VnaCAtIEkgDQpkb24ndCBleHBlY3QgdGhpcyB0byBiZSBtZXJnZWQgYmVmb3JlIHRo
ZSBkZXBlbmRlbmN5IGlzIGluIHJjMSAtIHNvIEkgDQpndWVzcyBJIHdpbGwgYW55d2F5cyBuZWVk
IHRvIHJlc3BpbiB0aGlzIGZvciBuZXh0IGN5Y2xlLiBJIGNhbiBkbyB0aGUgDQpzdHlsaW5nIHRo
ZW4uDQoNCj4gdGhpcyBjYXNlIHlvdSBldmVuIGNhbiBtb3ZlIGl0IG91dCBvZiB0aGUgZnVuY3Rp
b24sIHNvIHdlIHdpbGwgc2VlDQo+IGNsZWFybHkgdGhhdCB0aGlzIGlzIChub3QgYSBoaWRkZW4p
IGdsb2JhbCB2YXJpYWJsZS4NCg0KSGVyZSBJIGRvIGRpc2FncmVlIHdpdGggeW91LiBNb3Zpbmcg
dGhlIGFycmF5IG91dCBvZiB0aGUgZnVuY3Rpb24gbWFrZXMgDQppdCBfbXVjaF8gbGVzcyBvYnZp
b3VzIGl0IGlzIG5vdCB1c2VkIG91dHNpZGUgdGhpcyBmdW5jdGlvbi4gUmVhc29uIGZvciANCm1h
a2luZyBpcyAic3RhdGljIGNvbnN0IiBpcyB0byBhbGxvdyB0aGUgZGF0YSBiZSBwbGFjZWQgaW4g
cmVhZC1vbmx5IA0KYXJlYSAodGhhbmtzIHRvIEd1ZW50ZXIgd2hvIG9yaWdpbmFsbHkgZ2F2ZSBt
ZSB0aGlzIHRpcCkuDQoNCj4gUC5TLiBTYW1lIGFwcGxpZXMgZm9yIHRoZSByZXN0IG9mIHRoZSBz
aW1pbGFyIHBsYWNlcyBpbiB5b3VyIHNlcmllcy4NCj4gDQoNCkJyLA0KCS0tIE1hdHRpDQoNCi0t
IA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBW
YWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5s
YW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4g
dGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
