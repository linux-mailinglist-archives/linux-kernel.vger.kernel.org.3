Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4652560AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiF2Twb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiF2Tw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:52:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5C829CB1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656532345; x=1688068345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AKhwUpjBhKGBvO4lAhy+4pvqeru9s+d6mYt8BwmwRP4=;
  b=joR7lirKt3x29flO+VQCsPtW2+wjdHvpwSZL3jW0DqVI9HSz1l53AU3r
   xoXlQjSELN58f5pW5yUaz0DcSs009YKIrxocRnem1suzYNCyP7rnumXxu
   mJlzVzjrqGFnt716SpyXlXJfoR0TDYI/6OEiZuC6HkOnJBSM/slLQR1Ky
   /62ylOGxDf3f2n/YWVdTbPdNV1zY01YrTiP6a/GLIoYP2sCjqPnd7d9VG
   229NDTZwmf5dLIWCF562HjIgTsjODMLOYVi6dDAzv32Z5hjLC0ZZrlQFi
   X2nR/U/dUBdwtXawbZoIO6mBRBqRHQOOF5qd81sBQKXnDdbfZQPHSMlAb
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="170427698"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 12:52:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 12:52:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Jun 2022 12:52:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXDJVzLhCktn3Xi5qQP4+rXf6Vm9dC0vTR50DuoHa1uGdbQvejrQIXYiD7uExQWt8SinHplARLNFQ9U91XlZNf4FvD5dBJ7g+XlKkmMksWSelac5DvKVOMojctpLdoOLj52GZGnu7dVoGH4cC6jxHDLn7qXRULD0LT2/4nrOxwyWvotiK0hSria4wjo+eniaCrKqLwOpJmgGQ0XdhkRjjiDje2B1+subHwLTwSJ87sGp1xOFqfyOlGyZEZ8vmLOSMiBNZK+Id97i30RGEBoLhGOdFk/m+CQA1ragjdqqvUEhHKnuERgC2tCiuQtT4gZ+Uy0MJlegCHjaNCh+LzUVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKhwUpjBhKGBvO4lAhy+4pvqeru9s+d6mYt8BwmwRP4=;
 b=LkcCNVHT/QxTXznzwOX36neoQhv6jox8QPMIO7Va49QHn1689TlyDR+F+awcwhf6yRP+hsM2UG0ejw6sj10mmtIRB9MkPgNMvMNGY8lr3jOHtjfJwLruY9OrGtAV2UDsbufbbe9blnN4PaPM1KUd+Mj0gr+n5MWfFMBa6YANohsD6KyiXOx3wDedh2PMJOhSP0IcuKq6ndcvO/RyTnZvjfO0FOOQzoBfOk+H22ChbzjIVFhe+oBccq5r0xfXergxzH2oN60iR/5ZlTAmJ71ufzndqYUkteIzIp71CJx4SUV+WqMvLzwBm/8R18cqslBG1jeeNehBpn4eg9lfY5H+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKhwUpjBhKGBvO4lAhy+4pvqeru9s+d6mYt8BwmwRP4=;
 b=UU7gn3FuKwxl2draYDZed/vH6nyQaYmpRl02y+XHkuakXdlocGARR9DAECw0OJkVNA+7/VBP7hpyZl9LfQiv63w7yPqzK7g0AQsK57zalhSyB9XJZcYG7ctLXyVx8YTMLbSKNj8R1+bddZFgzchv4PcG8sHXi8q69ByTgqdE7BA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB1783.namprd11.prod.outlook.com (2603:10b6:903:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 19:52:13 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Wed, 29 Jun 2022
 19:52:13 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <atishp@atishpatra.org>, <atishp@rivosinc.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEAgAAIIICAAAgGAIAAAp2AgAAEkQCAAAOXgIAABQOAgAACZgA=
Date:   Wed, 29 Jun 2022 19:52:13 +0000
Message-ID: <fe14c407-817b-fcaf-39c1-3e2a33c5cfab@microchip.com>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184708.x5exgjoy4sblyqml@bogus>
 <88ef07ea-fbde-b997-6c0c-99f5fb7be201@microchip.com>
 <20220629191250.mg3dybgl6hnlnqee@bogus>
 <f569aff9-fbe1-66f1-d308-cec428aa5886@microchip.com>
 <20220629194337.3cmrqed2xbalihif@bogus>
In-Reply-To: <20220629194337.3cmrqed2xbalihif@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5531e9cc-a718-4fe3-2a3b-08da5a08dc97
x-ms-traffictypediagnostic: CY4PR11MB1783:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yE7zZ+7FfqlJ0apUqInV6aji9W5fsadDxD/h1Kmw8x42vY2P0F82TDoKoMNfTqUUG3hkGwGZS59XdN8aPGZjuLI7MITsC1P1ksGxndh6w7iXIAuV5H72xDeKloCTPC7QOHOkXKHwaRJsc+diztPz2yImW/DjbjjVj/LsPO8T4hgqnBjDysZO2vJh2i+r3i5G/tv5h5OFJBdxB49tRtU/hIx47jV3bynAVSQQjXcOCoMqmhDnDG6DpsXE33E7TNC9+XfoQ1c2tmGVtyi48j1GWacWY0zxDw6XWDjTMMcsuo3FIWni6BQ0UwadAttB/v+9XBDfmWXttQ/XGW44wJtC0gK+Tip5D2Y8hZiY4uTh/DJcaxD0l6bMCtrEoJ4zuqc9QRxaElz+JBkcevwvJmWEGOZrIF0YWsDhxRAjBDGa8TLqW2RHy3O2QEFf9ckfDUkgjEUvCptZDG8kcjiHF3zawmfIJ/1RgffKKuuqYv6bdsTzq5cDL3LcYq+jCfolM4LMbB26Sg6wMvuRx0Pr/3p/k/5nJBGFfXy5GCfch1xRVDdRJpOlsPPZTRAh942E9aKXvG8k7nJda4GXEigzyKO+osnlkGBbgq7VoU/n/+s5YGdK0p3DZ6KlfYsqSV3fhJgZarfd0k9TsDFJDcBmixckVzo3m4T5X6qXDVZ+BwD5eUNTOrWcIsAr2MdCvRc3VVZ7DUxzRz+GJhF5a/p+5HTGS1m+30wweDxzGdGlUGkw1pjH4VjQMP5L7aP7+o5gd1dPMKRxF9S0JTT7sLW9hYnJ8Z5fKbV5AFAy0/UuXn8k8wi/gPG7v2mgaFZfJYnUmCKD5HmbcAJ3iNbJJWPlhvT3FM916vxJ//EV4hcVZaoQygg+9vai0VujiEJipM/6rwXS7PiC1KdwJJae79/3PjCuWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(396003)(39860400002)(376002)(38100700002)(54906003)(86362001)(122000001)(966005)(31696002)(5660300002)(107886003)(2616005)(41300700001)(478600001)(71200400001)(38070700005)(8676002)(316002)(8936002)(76116006)(64756008)(6486002)(66946007)(66476007)(26005)(66556008)(7416002)(6916009)(4326008)(6506007)(91956017)(6512007)(2906002)(31686004)(66446008)(186003)(36756003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0k5L21KZHN1Zkk0UVF5SXNnQ054WC9xZ2FrcVBMbFJtc2plZ2N0RU5QcTJF?=
 =?utf-8?B?TnFPeWxsakZOYitiNjlWdk9RTW43aFloYWM1S2JFZUJOUlRtdmtac29SMkZZ?=
 =?utf-8?B?NjFyaUl2c1dCYlJLU3RRQ0R3aGVMTDBLWGVaQnV3Qk1ORWpFM3RyYXR4dDNY?=
 =?utf-8?B?MncvaG96YmRLTDl2bmxmamZ3dTNUWjI0eHNwQTl1VUZZU01sVWJSMUxMQTQw?=
 =?utf-8?B?RkZwUnZ6bHJYbkZvZllYdEtXV0Y5bDUybG9adUhpeGk5TlluVUFpdllxcGZs?=
 =?utf-8?B?SDBGMGV1eVErQlRZRjlNQ2lIY1J6NkxwUmpjUWxMTU4xNkhSNUdLZ09WeXJu?=
 =?utf-8?B?T1BsdUVNaFNyUDRlTjVJa0pCSmpWdEM2KzA3VFhQV2dHd3Yxcm4zQ25Jbzht?=
 =?utf-8?B?QnZudkZnSU5FRGN3aHNpN2tWbHZGM1o1bTE1SFBpQ2NXeldxQm5nbUdVUmps?=
 =?utf-8?B?SWUwK2M4N3NWMGZqRGZSenNBbDBYK1RwUEd4Q3Nwajh1eHU1ZkUrNWZrZ3J0?=
 =?utf-8?B?SkMwWWplLy9DT3N4cy96eHdzcHpTRnd0WldGN2o1Zy8wL1hUUnBYb0dwRngx?=
 =?utf-8?B?UWxSVmZyVjlMMUU5WkVqWlZWeVhScXQvUTFhdC9MUERIa2pMQWVON2c0VXlu?=
 =?utf-8?B?VHFEbXNEeXozZytYSzZHMTlMZkZSN3ExL0dEaWJhYVlhZXU0Q3dBVFg5UU9Q?=
 =?utf-8?B?SUhZVjlQTFdLNDd4YkN2SDI4T2wyVFdZS2RhbHpiUWUvOEtmNnZtL0FlVDc2?=
 =?utf-8?B?NlJnNHlYWXlpQkh0MzloL1RUSUYzZy8zRDZBTlpSZExMVzlHeHpPVmFDd2cy?=
 =?utf-8?B?Q1JaQXFuRTdJcHBLUFdNcUc5a0ZpeCt0dnI3b0E5dllaNnNtMURqc3hWNzc1?=
 =?utf-8?B?dkRWRWFXV3FUNXUxd0ZkYVpmY1A0ZXJiMDhvMFBLU3ZDZXdLTi9zM3VGVFVi?=
 =?utf-8?B?OUx6d0k4Rzk3dW5PdU8rWmVTcU1DMEVQdFR2NmFrWTNnZGVveG9PMU1hL0Jl?=
 =?utf-8?B?RTJUZklpYkh4WklRVjBFSHlVa1dSaEFjUGlFWlMyQmF5Vm93bEZlTmd4Smda?=
 =?utf-8?B?LzIyTklYVnZnZmp1NWxFWVhhSm5aMm9JbFZzaGxENDFvdUdBTGhtQ2U4UFF6?=
 =?utf-8?B?RjRPZXptWDYrUjF2K0RGQVh1Y1labEh3c3lCMlRmNUs1OTNONjlHb1lFN2VV?=
 =?utf-8?B?aUxSR3dkLzdRbStZT1ZCa0w2c3FlQlVuMmtCc2pORzh0RkdsUC9Eby9CR1pN?=
 =?utf-8?B?ak82UWx3VkVKSVVLby8vbUUwcGJtSi83YVB4RmlNNDNTanZDUDNldndiRFFz?=
 =?utf-8?B?dThpb1U0UC9iZ3BqQ3h4dUJsVGZENDNvSkVuOFI3TzJZUkdLbXJsakxUTk9F?=
 =?utf-8?B?aVA3K1B1MjNjS0tRNVhCT0FLeVRTMENONll4SXJVVEVxU1hOWlEzTFBVckx5?=
 =?utf-8?B?dFJFV2ViMFo4K0pkckFnSlpoN0t1a2ZNQ25pTGk1WVp4cXExY1dFcittVWlj?=
 =?utf-8?B?bEx0S0xYem1SVVVKVmw4VjBlT1Y4VzdrMjZxb1dESG9JZkhvYVQ5VVhNVm1Y?=
 =?utf-8?B?TFByRWxFNE90VXNqVURvd1puMWxGcjhnYzJGbUc2TVluZEZJbHo5Y1BtT1lP?=
 =?utf-8?B?TVFubEg2ZWtQVy8yRUFMTndVVTNNTkFaak53OVZvVGdtNlZuQlpPUnlYUmhD?=
 =?utf-8?B?djBrOVdrcGlIVVhtOHVnZ2pYSjFvalRnenpmTHZNd2tuejhjYm5DZEpnOGpI?=
 =?utf-8?B?QlN3TWRXZ2FTSC83YmlMditoTWtlSGJuR1NYbXpBT3p6QWVBN1V4S3o3OVhQ?=
 =?utf-8?B?eEw3K0VjRC85cUhFQkpFRnZSUkxBRDV3bGY3aE5PUG9DSm1zbTZMcWpYeGtx?=
 =?utf-8?B?LzJhTHVsOHlTOTFqSVdqbldNcmV3M294dWlEaER0WklYZTErVWlDeklNeE9w?=
 =?utf-8?B?V0V4Q0ZoQnlKSWZNQU9EK1IzdWtES2hUeHV1Yk5IdmZOK0hsSGV0a0Y2RFpH?=
 =?utf-8?B?QmR5aG5aTENKYlpjQWtCR2hjTlpoZ1p6S2FncVh0MU92eTVka0s1Z2h4WWlC?=
 =?utf-8?B?WjBGcS82UHVQU0hqR1B3cGZiVEVpRU05ck51aEF2SHlvQUxydUJaMkVwNDBP?=
 =?utf-8?B?QWh3L2trM2xDWFRwUko5aUxvVVRPemxQNW5wV2poS0RuQXB5cUVOb2x6dGVO?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEEAE281BAA0E248B3C48D586A2C68BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5531e9cc-a718-4fe3-2a3b-08da5a08dc97
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 19:52:13.3166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIOeZbECFdiXW6e0clz0KIvDEVHhhHGTxK+tJ/GmEPgxI6sU+k1wdcWL1SNKPJgGgQfjxiAFUjXOGnYxCZImKkUZYwkj+kA4a6uB19MeJ7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1783
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDYvMjAyMiAyMDo0MywgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0IDA3OjI1
OjQxUE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4NCj4+DQo+
PiBPbiAyOS8wNi8yMDIyIDIwOjEyLCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+Pj4gT24gV2VkLCBK
dW4gMjksIDIwMjIgYXQgMDY6NTY6MjlQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+Pj4+IE9uIDI5LzA2LzIwMjIgMTk6NDcsIFN1ZGVlcCBIb2xsYSB3cm90ZToN
Cj4+Pj4+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0IDA2OjE4OjI1UE0gKzAwMDAsIENvbm9yLkRv
b2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4+IE9uIDI5LzA2LzIwMjIgMTg6NDksIENv
bm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4+PiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4+Pj4NCj4+Pj4+Pj4gT24gMjcvMDYvMjAyMiAxNzo1MCwg
U3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4+Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gVGhlIGNhY2hlaW5mbyBpcyBub3cgaW5pdGlhbGlz
ZWQgZWFybHkgYWxvbmcgd2l0aCB0aGUgQ1BVIHRvcG9sb2d5DQo+Pj4+Pj4+PiBpbml0aWFsaXNh
dGlvbi4gSW5zdGVhZCBvZiByZWx5aW5nIG9uIHRoZSBMTEMgSUQgaW5mb3JtYXRpb24gcGFyc2Vk
DQo+Pj4+Pj4+PiBzZXBhcmF0ZWx5IG9ubHkgd2l0aCBBQ1BJIFBQVFQgZWxzZXdoZXJlLCBtaWdy
YXRlIHRvIHVzZSB0aGUgc2ltaWxhcg0KPj4+Pj4+Pj4gaW5mb3JtYXRpb24gZnJvbSB0aGUgY2Fj
aGVpbmZvLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFRoaXMgaXMgZ2VuZXJpYyBmb3IgYm90aCBEVCBh
bmQgQUNQSSBzeXN0ZW1zLiBUaGUgQUNQSSBMTEMgSUQgaW5mb3JtYXRpb24NCj4+Pj4+Pj4+IHBh
cnNlZCBzZXBhcmF0ZWx5IGNhbiBub3cgYmUgcmVtb3ZlZCBmcm9tIGFyY2ggc3BlY2lmaWMgY29k
ZS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSGV5IFN1ZGVlcCwNCj4+Pj4+Pj4gSSBiaXNlY3RlZCBicm9r
ZW4gYm9vdCBvbiBQb2xhckZpcmUgU29DIHRvIHRoaXMgcGF0Y2ggaW4gbmV4dC0yMDIyMDYyOSA6
Lw0KPj4+Pj4+PiBJIHN1c3BlY3QgdGhlIGlzc3VlIGlzIGEgbWlzc2luZyAibmV4dC1sZXZlbC1j
YWNoZSIgaW4gdGhlIHRoZSBkdDoNCj4+Pj4+Pj4gYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2No
aXAvbXBmcy5kdHNpDQo+Pj4+Pg0KPj4+Pj4gR29vZCB0aGF0IEkgaW5jbHVkZWQgdGhpcyBpbiAt
bmV4dCwgSSBoYWQgbm90IHJlY2VpdmVkIGFueSBmZWVkYmFjayBmcm9tDQo+Pj4+PiBSSVNDLVYg
ZXZlbiBhZnRlciA1IGl0ZXJhdGlvbnMuDQo+Pj4+DQo+Pj4+IEknbGwgYmUgaG9uZXN0LCBJIHNh
dyB0aGUgdGl0bGVzIGFuZCBDQyBsaXN0IGFuZCBtYWRlIHNvbWUgaW5jb3JyZWN0DQo+Pj4+IGFz
c3VtcHRpb25zIGFzIHRvIHdoZXRoZXIgbG9va2luZyBhdCBpdCB3YXMgd29ydGh3aGlsZSEgSSBh
bSBub3QgYXQNCj4+Pj4gdGhpcyBhbGwgdG9vIGxvbmcgYW5kIHdoYXQgaXMvaXNuJ3QgaW1wb3J0
YW50IHRvIGxvb2sgYXQgb2Z0ZW4gaXMgbm90DQo+Pj4+IG9idmlvdXMgdG8gbWUuDQo+Pj4NCj4+
PiBObyB3b3JyaWVzLCB0aGF0J3Mgd2h5IEkgdGhvdWdodCBiZXR0ZXIgdG8gaW5jbHVkZSBpbiAt
bmV4dCB0byBnZXQgc29tZQ0KPj4+IGF0dGVudGlvbiBhbmQgSSBkaWQgZ2V0IGl0IHRoaXMgdGlt
ZSwgaHVycmF5ISDwn5iEDQo+Pj4NCj4+Pj4gQnV0IGhleSwgb3VyIENJIGJvb3RzIC1uZXh0IGV2
ZXJ5IGRheSBmb3IgYSByZWFzb24gOykNCj4+Pj4NCj4+Pg0KPj4+IEdvb2QgdG8ga25vdyBhbmQg
dGhhdCBpcyByZWFsbHkgZ3JlYXQuIEFueXdheXMgbGV0IG1lIGtub3cgaWYgdGhlIGRpZmYgSSBz
ZW50DQo+Pj4gaGVscHMuIEkgc3Ryb25nbHkgc3VzcGVjdCB0aGF0IGlzIHRoZSByZWFzb24sIGJ1
dCBJIG1heSBiZSB3cm9uZy4NCj4+DQo+PiBBeWUsIEknbGwgZ2V0IGJhY2sgdG8geW91IG9uIHRo
YXQgb25lIGluIGEgbW9tZW50IG9yIHR3bw0KPj4NCj4gDQo+IFN1cmUsIHRha2UgeW91ciB0aW1l
Lg0KPiANCj4+Pg0KPj4+Pj4gSSBhbHNvIHNlZSB0aGlzIERUUyBpcyB2ZXJ5IG9kZC4gSXQgYWxz
bw0KPj4+Pj4gc3RhdGVzIENQVTAgZG9lc24ndCBoYXZlIEwxLUQkIHdoaWxlIHRoZSBvdGhlciA0
IENQVXMgaGF2ZSBMMS1EJC4gSXMgdGhhdA0KPj4+Pj4gYSBtaXN0YWtlIG9yIGlzIGl0IHRoZSBy
ZWFsaXR5ID8NCj4+Pj4NCj4+Pj4gQUZBSUssIHJlYWxpdHkuIEl0J3MgdGhlIHNhbWUgZm9yIHRo
ZSBTaUZpdmUgZnU1NDAgKHdpdGggd2hpY2ggdGhpcyBzaGFyZXMNCj4+Pj4gYSBjb3JlIGNvbXBs
ZXguIFNlZSBwYWdlIDEyOg0KPj4+PiBodHRwczovL3N0YXRpYy5kZXYuc2lmaXZlLmNvbS9GVTU0
MC1DMDAwLXYxLjAucGRmDQo+Pj4+DQo+Pj4+PiBBbm90aGVyIGJyZWFrYWdlIGluIHVzZXJzcGFj
ZSBjYWNoZWluZm8NCj4+Pj4+IHN5c2ZzIGVudHJ5IG9mIGNwdTAgaGFzIGJvdGggSSQgYW5kIEQk
Lg0KPj4+Pg0KPj4+PiBDb3VsZCB5b3UgY2xhcmlmeSB3aGF0IHRoaXMgbWVhbnMgcGxlYXNlPw0K
Pj4+DQo+Pj4gSWdub3JlIG1lIGlmIHRoZSBjcHUwIHJlYWxseSBkb2Vzbid0IGhhdmUgTDEtRCQu
IEhvd2V2ZXIgdGhlIHVzZXJzcGFjZQ0KPj4+IHN5c2ZzIGNhY2hlaW5mbyBpcyBpbmNvbXBsZXRl
IHdpdGhvdXQgbGlua2luZyBMMiwgc28gaXQgY2FuIGJlIGNvbnNpZGVyZWQNCj4+PiBhcyB3cm9u
ZyBpbmZvIHByZXNlbnRlZCB0byB0aGUgdXNlci4NCj4+DQo+PiBZZWFoLCBJJ2xsIHNlbmQgYSBw
YXRjaCBob29raW5nIHVwIHRoZSBMMi4NCj4+IEl0IHdhc24ndCBpbiB0aGUgaW5pdGlhbCBmdTU0
MCBkdHNpIHNvIEkgZ3Vlc3MgaXQgd2FzIGFkZGVkIGFmdGVyIHRoZQ0KPj4gaW5pdGlhbCBkdHMg
Zm9yIG15IHN0dWZmIHdhcyBjcmVhdGVkIGJhc2VkIG9uIHRoYXQuDQo+Pg0KPiANCj4gVGhhbmtz
IQ0KPiANCj4+Pg0KPj4+IENoZWNrIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTxuPi9jYWNo
ZS9pbmRleDxpPi8qLg0KPj4+IEwyIHdvbid0IGJlIHByZXNlbnQgdGhlcmUgYXMgdGhlIGxpbmsg
d2l0aCBuZXh0LWxldmVsLWNhY2hlIGlzIG1pc3NpbmcuDQo+Pj4gU28gdXNlcnNwYWNlIGNhbiBp
bnRlcnByZXQgdGhpcyBhcyBhYnNlbmNlIG9mIEwyLg0KPj4+DQo+Pg0KPj4gIyBjYXQgL3N5cy9k
ZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jYWNoZS9pbmRleDAvDQo+PiBjb2hlcmVuY3lfbGluZV9z
aXplICAgIHNoYXJlZF9jcHVfbGlzdCAgICAgICAgdHlwZQ0KPj4gbGV2ZWwgICAgICAgICAgICAg
ICAgICBzaGFyZWRfY3B1X21hcCAgICAgICAgIHVldmVudA0KPj4gbnVtYmVyX29mX3NldHMgICAg
ICAgICBzaXplICAgICAgICAgICAgICAgICAgIHdheXNfb2ZfYXNzb2NpYXRpdml0eQ0KPj4gIyBs
cyAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NhY2hlLw0KPj4gaW5kZXgwICBpbmRleDEg
IHVldmVudA0KPj4gIyBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jYWNoZS9pbmRl
eDAvbGV2ZWwNCj4+IDENCj4+ICMgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY2Fj
aGUvaW5kZXgxL2xldmVsDQo+PiAxDQo+Pg0KPiBJZGVhbGx5IHRoZXJlIG11c3QgL3N5cy9kZXZp
Y2VzL3N5c3RlbS9jcHUvY3B1Ki9jYWNoZS9pbmRleDIvbGV2ZWwNCj4gd2hpY2ggcmVhZHMgMiBv
bmNlIHlvdSBsaW5rIGl0IGluIHRoZSBEVC4NCg0KIyBscyAvc3lzL2RldmljZXMvc3lzdGVtL2Nw
dS9jcHUwL2NhY2hlLw0KaW5kZXgwICBpbmRleDEgIGluZGV4MiAgdWV2ZW50DQojIGNhdCAvc3lz
L2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NhY2hlL2luZGV4Mi9sZXZlbCANCjINCiMgY2F0IC9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY2FjaGUvaW5kZXgxL2xldmVsIA0KMQ0KIyBjYXQg
L3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jYWNoZS9pbmRleDAvbGV2ZWwgDQoxDQoNClN3
ZWV0IDopDQoNCj4gDQo+PiBjcHUwIGlzIC9ub3QvIHRoZSBvbmUgd2l0aCBvbmx5IGluc3RydWN0
aW9uIGNhY2hlLCB0aGF0IGlzIG5vdA0KPj4gcnVubmluZyBMaW51eC4NCj4gDQo+IEFoLCBzbyB0
aGVyZSBMaW51eCBydW5zIG9ubHkgb24gY3B1IDEtNCA/DQoNCkNvcnJlY3QuIGNwdTAgc3VwcG9y
dHMgZmV3ZXIgaW5zdHJ1Y3Rpb25zICYgd2UganVzdCB1c2UgaXQgYXMgYQ0KbW9uaXRvciBjb3Jl
IGZvciBvcGVuc2JpIGV0Yy4NCg0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gU3VkZWVwDQoNCg==
