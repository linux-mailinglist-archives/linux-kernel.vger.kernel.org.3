Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B923C5ABAD4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiIBWd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIBWd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:33:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DB8D8E2B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662158005; x=1693694005;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=UbVPJ5o6JMgWLfJZvqXZoJcUvu3I2ChD02187KLDLnE=;
  b=D6HlRe5HE4SfFLhBBWBjrmbX1G3yPhR5P3ToyeriQ+QIkaJdgctXCK8b
   g8reyCm+yKfixVHnfB9T+Rr05wMQCdQfy7yKCbGvo7KtWNC06tY0DOFdG
   8ZpAFEfTgdTWlY5wONDjpGT82434sI5vGz1PohsGTywW/HuSAyHVHhTpA
   olb1UHf6vv5w6ylizzd52KaCSiOIhja61JTFRoD0vkrUuy08AiQB3Ab3i
   9Cv/Ke7JQhomGHQ7r49SQLkiJ8ZObvGUQtqGPclAh+99s3OdwlyXKFTZM
   bHWcLaVc+S7PHym0Wpotrp55z28MMKB6Ue/1ZdHZNUa5GDLYk1LswFXdH
   g==;
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="172216817"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 15:33:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 15:33:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 2 Sep 2022 15:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYUDkp2XHWzEV8Bm/9xyfevmu0fGJUdoamEPDEoaGj0/AOYZWEL7vfM/fZeVLhPgR/RAi4zaHi0vMJESPtuyQHYeh+OveTygDFABBqTtIr5sX3RL1QlhPydwiZjv5ZYKTHmw87BTt4/AjAqcESVwGM0mIhT8IqpZX/aweldxCP0buAOAgsezipidPqZwBcnAdbNDNySxtKbJm4AMb+tl3zCwB72MA0dj4lowh3rdcZx1OZo3B7QvF9Fo0fBAiYVTeYjaobv3Rih1CuIPiWDf3LRBt/z69ewcHdFb9gBQAX5+3/EOqAUxxHxt2I1xIF1f3WenZsEOMQR7gI0W0k0Fng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbVPJ5o6JMgWLfJZvqXZoJcUvu3I2ChD02187KLDLnE=;
 b=cISy0TccUPvFgH/9BTFu7Del0Fh82amlHUpIv7NwC0wOOpjg44XDyg8wNB2NSB//u7Jd2064r05QiTPlXxOdYSP23wjHWqvbgHfXoY3QAakXhk/h27KpbvNYz/f7fJpmNFRrsvMXaqf/Z4xpKSIlzjT8E1j4D6kEBdgM1mpMmdk3aU9y/LLe5Hbtl8NQmZjnN4a/zkpKi4Ti3MNdwOf6on6nLtKcstiukKuWfHrFfkqXG8BaBkHhqHLtHhNJTMeOYATcrjC8FugwQYC9xa6Es/0LevvVRqBQIGZ1AemrO7RldZ/i4OGd7i8O1jYp9kkaGe4S4S9oFKaDdV/AEhwR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbVPJ5o6JMgWLfJZvqXZoJcUvu3I2ChD02187KLDLnE=;
 b=K/2inFxZHlxTUWCov1iw5pppwULGGFonmLdZ1ZKBVFnPj96mKqx/MUsgEiNLyl6YlcLX8uSBf8ByIjgyNaWDGe09McbLRPeqtFA0oLynanAz7XLlOJHo3Pa8nr22Jgz4ZG0wgGZgyqznvsknNi8/lgQkOhcHUELhr3jlswENlh0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 22:33:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.016; Fri, 2 Sep 2022
 22:33:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ben.dooks@sifive.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <zong.li@sifive.com>
Subject: Re: [PATCH] soc: sifive: ccache: use pr_fmt() to remove CCACHE:
 prefixes
Thread-Topic: [PATCH] soc: sifive: ccache: use pr_fmt() to remove CCACHE:
 prefixes
Thread-Index: AQHYvu8NLkT3QQwUk0iPzNsS6HUW0q3MuhcA
Date:   Fri, 2 Sep 2022 22:33:10 +0000
Message-ID: <fdcca7c2-2921-3c65-1b2b-bc97247c4423@microchip.com>
References: <20220902171105.257436-1-ben.dooks@sifive.com>
In-Reply-To: <20220902171105.257436-1-ben.dooks@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a822aca-2673-4b4d-d036-08da8d331d83
x-ms-traffictypediagnostic: IA1PR11MB6217:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvLcYDvLTNU+qHO4JeasqYlGCQSM/2xynhZ5cigS6Of71ogpe6Q1e6nq/3hyri7UGn9CTS3mKWzq7ljkJpj24CNIWmP3PcyUh7zYyYLBn7Al99eIxgelTqzNLGxTrKa0I9QyboDidVqxQn4TcPQYvVEQcr2gkmlesQTVbAnXkfwUnapDUyYvFyVzyc+eSxDRZxz6uHeFh1YexeCFFh2mkm1Cgp3l4D/d26F+oknOI1FtRqFGvEDJeFBnMDevXWnncSd341JMtGJPfbztcr2pqDe2FnS5fI/HgLOpAFRK42sO6tCGNAqbZN5N9ieypUjaQgRP5hA6wsLAV8+QfC6meW4vCj29A8PiVha0g+WzR5NA+WyvB/LcHRhOjYp9nGOFYyMJIYi8v5caxr/Q8+PsrWIOrJYdmyNSFhyyO0LtINmDgE7EtK5mLd1WvMKXQXTy0WrPwxvlgwbNgQrdTLLpmpKZrSEObdAavRfyhIYK96yKDrFUxl83nXhSjiRN/GHABq0fFZsNC3SRvn/Qo1Fg6GTdm4JIDQDaZnSN6hYyy8GI1T+IhWEwzA0XeasbPfsrJ9UobyEjHwbdzWH1POtrYbHOfKDuvOeOtgVn8eRt9cfwoHL0H3IwTii6gl+OS8PORQcp6x2B0CjHqMdOVDBoDYerY7C2vnuYWjXljv9q199bSDB8o9Fsdp6S2Hky1M2anVz6B4xeTEJ2GHi58MhVg3Nom/UxSTt4JA4TMkLTfVa9aSOnct7w83yRBkQRWfab9HLJDM/0JFIMAFuxX+ppi0i0KSC03y106tEV7MciGh6jlhYx7Aj55SjMOVPxFjx7Dby6053b5Xr9jl3Vkl+glVi1ZdVp/u9CTo/WEc9nkeM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(396003)(376002)(39860400002)(186003)(6486002)(2616005)(478600001)(86362001)(41300700001)(6512007)(26005)(38100700002)(83380400001)(71200400001)(53546011)(31696002)(122000001)(921005)(38070700005)(2906002)(8936002)(66476007)(5660300002)(91956017)(36756003)(6506007)(110136005)(316002)(76116006)(66556008)(66446008)(7416002)(8676002)(66946007)(64756008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDdGUlFVM0JEQ29udTZYVGNyZnhVdnhkZGRiR24zSDhiV0hMSE1mMVBCWC9Z?=
 =?utf-8?B?dUt6Q1E0V2d6SEYzOFBtYWRUd0JQWWdxZHdhMlZJMWVRdStxeFVmV05Fa2pZ?=
 =?utf-8?B?RzNrQ1g5aFFJUnRNT2tPc2NFQTl2bzFIS0pqbno4eElTcG1ISVo4d0h4U0xC?=
 =?utf-8?B?RW9wc0EzMWNnQlpUOUpudUZBc2VsT3JhNXppZmFYSldjbEJkc1U4bndaQ2ln?=
 =?utf-8?B?T0JSL1hpNGo2a3J2RFlSeVBySmhaTGJiTWdrbTA0VCs4bG4vRlUwakdNY2tp?=
 =?utf-8?B?UTFGKzJMOUEzTGduVkJBL3RRUVMwbEpkY0VxQzd6WDk2WXBqdllmc1hnZWtN?=
 =?utf-8?B?WFV5ckxOSFQ2aGhMdlRNS0NxUHJJTHRhbkVGSytMaGN1VFZzRzR5alNwOWpi?=
 =?utf-8?B?OGV1VURVemZCcHBYUzNMQnFGMXkyLzgwT0JNTWtXTzZNaHBKL2dvME9wRkgz?=
 =?utf-8?B?SmdnaGRwQ2pZQk56UVR1UEFjZGZlWGVWZ3FITS9TZnlsZVYycVhYZS91RVNK?=
 =?utf-8?B?akd4cjArazJQWlJyVTBNSmFPb2NIQ1FQU0hZcmtHcCtYWTNIOFpxenhwM2Zy?=
 =?utf-8?B?b2k2Vnk0WVplZ3ZtZ0ZZaGYreVZIbHloTWgrejlBTFBOcXB3ajU0dkI5Wnlk?=
 =?utf-8?B?bC80WFJReGdaV0dxVzdWdFVTZW5vUnhuTE13UkR6RVN5c1BjdGJlQ1JqeGx6?=
 =?utf-8?B?YS9nVTZDa0IxdzU5MkFTN0g5RVh2Rmw2SWcxOFRFejVQZHVkKzNLK0pXbWJj?=
 =?utf-8?B?b2Q5ZjdoaDhmazVacFFTUm1GWG51UVR6WFlvYjExRmZHei9FVXNNSGdPSHkz?=
 =?utf-8?B?OE5UTW9lc3BpOVY5YkNCUDJFejN1V1VQNjRyeU5zK3hFNDI2azFqNVZoZzRI?=
 =?utf-8?B?dVgyMnpjNmNTeXBucUIrZGE3OUkwOWdqR1d3NWZlc3N4QlVpcHpHUW5GUGo5?=
 =?utf-8?B?ajdzMGFvZEhwa2VyY3N1aTRjMDl5L2VnaWJhMlRJb0lJdVh6Tkg2Ym1FWjBt?=
 =?utf-8?B?TFg0OTJVMzdpdUNFNEVYZDloOThpV3NJdmVOdnd4NWcyYmxpL0NCK1R1eXFT?=
 =?utf-8?B?MlA0Z3dmRlhqYlJPbnpVVTJKanFPTnBzR016cWRNVi9vWk9zczFuZldQWVY1?=
 =?utf-8?B?MTZVTmJBV0UzeEFpQW1xOFY5V0IwS2hRbEZMZnkzUFdWMkNGQTVtam5kbXNT?=
 =?utf-8?B?RnIwN0JDa2lVNG8vZkd5b1pUeXJxQUVoK3puTEFkOHFoMHlEQVhJWGZYaVZC?=
 =?utf-8?B?dlV3NEhlTUhHYkxEUjRBajMwNHBEd3BSMU1aZUttM2lVK2ZVRHQvbHhaVDZH?=
 =?utf-8?B?OFl4Rmx5aXk5MEZxVHA5WU1kRjVBZWk1eWtwR09nYURudE1lSUNHSG1WR2lM?=
 =?utf-8?B?K203SWFXeWliWWhNMFNaR2FpQ21scUJsLzgrcktFT3lUdlIvd29zdVNKa2JU?=
 =?utf-8?B?L3AxdnJVQWcxQ2gxVHVVbitIVHZUS0h3ZVd1WklUTVE5YkR5V1FsYVBnUUlY?=
 =?utf-8?B?MlhwbTZPZHBEd1BpZm5WTHBsRnZ2Z2xBTmRaNWUwYy8xdWZKa0pGMWREa1lV?=
 =?utf-8?B?UUcvU0ZBL3VtanljcmpQekhqS0FzWkhSckpJOER4b3drNHhHTWdob0tjZ2dT?=
 =?utf-8?B?UFVKMHNiWWJBVzAxTVlTakpIcFVMK21rTmlIQ2FVMGluM1VsSjJxZkgzMXJS?=
 =?utf-8?B?UlhhUnZpblg1UmV2ZEt3QXpKZ0xlSEtJdXhhTHZnRnVyVStCckoyMnJNRjZ5?=
 =?utf-8?B?YWNiYTdva3p6ak9Ec2UrSXAzUVY5K2wzMEFvVnNHQ21QZkJrS1BseU9mcWpp?=
 =?utf-8?B?Qkc3K2hNc0FpWTBpdjF5eURaamZ5K2dGU2JrQmo3MElST2pEcWZHbi92ZGtv?=
 =?utf-8?B?WWtkWVpkNzJFdU1Qdzc1YktSb2NYV3dlTW9BVnZCeXVORDNWRExyZi94TWE1?=
 =?utf-8?B?VlVFK1VreGRSazgyY2NWMkZPdGJtOW9zaW01MjhLTGNoWDZFUmcwcVhSSXIz?=
 =?utf-8?B?R2RPb2IxeFVyVWtaZUJLRmlRZEI0RFV6S0JDaGMvQjRpU3VzcEpRL0ZaWkYr?=
 =?utf-8?B?bWVIbXZjTmZtOTZ1cEp1TmpZaFVmUE1jbnF4UTR6SDVZK1lmSno3eEFKb2tJ?=
 =?utf-8?Q?ynzOc31ZxZ4Qxo9OfERYruqMu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A2545F808A87B42AB7B23E61A605FDB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a822aca-2673-4b4d-d036-08da8d331d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 22:33:10.4045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6/mEXfLjmnVjj2QelW1YEZBIJ/9hqwfPXOn33zBBtLPq42L4z4/EyYNXm2D3UXxViTp0hcUzo9hRPCQdmU2B65nPfSJUAY6riuEyOURuIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6217
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDkvMjAyMiAxODoxMSwgQmVuIERvb2tzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFVzZSB0aGUgcHJfZm10KCkgbWFjcm8gdG8gcHJlZml4
IGFsbCB0aGUgb3V0cHV0IHdpdGggIkNDQUNIRToiDQo+IHRvIGF2b2lkIGhhdmluZyB0byB3cml0
ZSBpdCBvdXQgZWFjaCB0aW1lLCBvciBtYWtlIGEgbGFyZ2UgZGlmZg0KPiB3aGVuIHRoZSBuZXh0
IGNoYW5nZSBjb21lcyBhbG9uZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbiBEb29rcyA8YmVu
LmRvb2tzQHNpZml2ZS5jb20+DQoNCk9ubHkgcmVwbHlpbmcgaGVyZSwgYnV0IGJvdGggdGhlc2Ug
cGF0Y2hlcyBMR1RNLg0KSSdsbCBsZWF2ZSBhbiBSLWIgb24gWm9uZydzIGNvbWJpbmVkIHZlcnNp
b24gb2YgdGhlIHNlcmllcy4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVf
Y2NhY2hlLmMgfCAxNSArKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mv
c2lmaXZlL3NpZml2ZV9jY2FjaGUuYyBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hl
LmMNCj4gaW5kZXggNDBkMmFjNzg5NWEyLi45MGQyMWExYTRhYWUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hlLmMNCj4gKysrIGIvZHJpdmVycy9zb2Mvc2lm
aXZlL3NpZml2ZV9jY2FjaGUuYw0KPiBAQCAtNSw2ICs1LDkgQEANCj4gICAqIENvcHlyaWdodCAo
QykgMjAxOC0yMDE5IFNpRml2ZSwgSW5jLg0KPiAgICoNCj4gICAqLw0KPiArDQo+ICsjZGVmaW5l
IHByX2ZtdChmbXQpICJDQ0FDSEU6ICIgZm10DQo+ICsNCj4gICNpbmNsdWRlIDxsaW51eC9kZWJ1
Z2ZzLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvb2ZfaXJxLmg+DQo+IEBAIC04MCwxMyArODMsMTMgQEAgc3RhdGljIHZvaWQgY2NhY2hlX2Nv
bmZpZ19yZWFkKHZvaWQpDQo+IA0KPiAgICAgICAgIGNmZyA9IHJlYWRsKGNjYWNoZV9iYXNlICsg
U0lGSVZFX0NDQUNIRV9DT05GSUcpOw0KPiANCj4gLSAgICAgICBwcl9pbmZvKCJDQ0FDSEU6ICV1
IGJhbmtzLCAldSB3YXlzLCBzZXRzL2Jhbms9JWxsdSwgYnl0ZXMvYmxvY2s9JWxsdVxuIiwNCj4g
KyAgICAgICBwcl9pbmZvKCIldSBiYW5rcywgJXUgd2F5cywgc2V0cy9iYW5rPSVsbHUsIGJ5dGVz
L2Jsb2NrPSVsbHVcbiIsDQo+ICAgICAgICAgICAgICAgICAoY2ZnICYgMHhmZiksIChjZmcgPj4g
OCkgJiAweGZmLA0KPiAgICAgICAgICAgICAgICAgQklUX1VMTCgoY2ZnID4+IDE2KSAmIDB4ZmYp
LA0KPiAgICAgICAgICAgICAgICAgQklUX1VMTCgoY2ZnID4+IDI0KSAmIDB4ZmYpKTsNCj4gDQo+
ICAgICAgICAgY2ZnID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX1dBWUVOQUJM
RSk7DQo+IC0gICAgICAgcHJfaW5mbygiQ0NBQ0hFOiBJbmRleCBvZiB0aGUgbGFyZ2VzdCB3YXkg
ZW5hYmxlZDogJWRcbiIsIGNmZyk7DQo+ICsgICAgICAgcHJfaW5mbygiSW5kZXggb2YgdGhlIGxh
cmdlc3Qgd2F5IGVuYWJsZWQ6ICVkXG4iLCBjZmcpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNpZml2ZV9jY2FjaGVfaWRzW10gPSB7DQo+IEBAIC0xNDgs
NyArMTUxLDcgQEAgc3RhdGljIGlycXJldHVybl90IGNjYWNoZV9pbnRfaGFuZGxlcihpbnQgaXJx
LCB2b2lkICpkZXZpY2UpDQo+ICAgICAgICAgaWYgKGlycSA9PSBnX2lycVtESVJfQ09SUl0pIHsN
Cj4gICAgICAgICAgICAgICAgIGFkZF9oID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NB
Q0hFX0RJUkVDQ0ZJWF9ISUdIKTsNCj4gICAgICAgICAgICAgICAgIGFkZF9sID0gcmVhZGwoY2Nh
Y2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RJUkVDQ0ZJWF9MT1cpOw0KPiAtICAgICAgICAgICAg
ICAgcHJfZXJyKCJDQ0FDSEU6IERpckVycm9yIEAgMHglMDhYLiUwOFhcbiIsIGFkZF9oLCBhZGRf
bCk7DQo+ICsgICAgICAgICAgICAgICBwcl9lcnIoIkRpckVycm9yIEAgMHglMDhYLiUwOFhcbiIs
IGFkZF9oLCBhZGRfbCk7DQo+ICAgICAgICAgICAgICAgICAvKiBSZWFkaW5nIHRoaXMgcmVnaXN0
ZXIgY2xlYXJzIHRoZSBEaXJFcnJvciBpbnRlcnJ1cHQgc2lnICovDQo+ICAgICAgICAgICAgICAg
ICByZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfRElSRUNDRklYX0NPVU5UKTsNCj4g
ICAgICAgICAgICAgICAgIGF0b21pY19ub3RpZmllcl9jYWxsX2NoYWluKCZjY2FjaGVfZXJyX2No
YWluLCBTSUZJVkVfQ0NBQ0hFX0VSUl9UWVBFX0NFLA0KPiBAQCAtMTU3LDcgKzE2MCw3IEBAIHN0
YXRpYyBpcnFyZXR1cm5fdCBjY2FjaGVfaW50X2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2aWNl
KQ0KPiAgICAgICAgIGlmIChpcnEgPT0gZ19pcnFbREFUQV9DT1JSXSkgew0KPiAgICAgICAgICAg
ICAgICAgYWRkX2ggPSByZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfREFURUNDRklY
X0hJR0gpOw0KPiAgICAgICAgICAgICAgICAgYWRkX2wgPSByZWFkbChjY2FjaGVfYmFzZSArIFNJ
RklWRV9DQ0FDSEVfREFURUNDRklYX0xPVyk7DQo+IC0gICAgICAgICAgICAgICBwcl9lcnIoIkND
QUNIRTogRGF0YUVycm9yIEAgMHglMDhYLiUwOFhcbiIsIGFkZF9oLCBhZGRfbCk7DQo+ICsgICAg
ICAgICAgICAgICBwcl9lcnIoIkRhdGFFcnJvciBAIDB4JTA4WC4lMDhYXG4iLCBhZGRfaCwgYWRk
X2wpOw0KPiAgICAgICAgICAgICAgICAgLyogUmVhZGluZyB0aGlzIHJlZ2lzdGVyIGNsZWFycyB0
aGUgRGF0YUVycm9yIGludGVycnVwdCBzaWcgKi8NCj4gICAgICAgICAgICAgICAgIHJlYWRsKGNj
YWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9EQVRFQ0NGSVhfQ09VTlQpOw0KPiAgICAgICAgICAg
ICAgICAgYXRvbWljX25vdGlmaWVyX2NhbGxfY2hhaW4oJmNjYWNoZV9lcnJfY2hhaW4sIFNJRklW
RV9DQ0FDSEVfRVJSX1RZUEVfQ0UsDQo+IEBAIC0xNjYsNyArMTY5LDcgQEAgc3RhdGljIGlycXJl
dHVybl90IGNjYWNoZV9pbnRfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkZXZpY2UpDQo+ICAgICAg
ICAgaWYgKGlycSA9PSBnX2lycVtEQVRBX1VOQ09SUl0pIHsNCj4gICAgICAgICAgICAgICAgIGFk
ZF9oID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RBVEVDQ0ZBSUxfSElHSCk7
DQo+ICAgICAgICAgICAgICAgICBhZGRfbCA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0ND
QUNIRV9EQVRFQ0NGQUlMX0xPVyk7DQo+IC0gICAgICAgICAgICAgICBwcl9lcnIoIkNDQUNIRTog
RGF0YUZhaWwgQCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9sKTsNCj4gKyAgICAgICAgICAg
ICAgIHByX2VycigiRGF0YUZhaWwgQCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9sKTsNCj4g
ICAgICAgICAgICAgICAgIC8qIFJlYWRpbmcgdGhpcyByZWdpc3RlciBjbGVhcnMgdGhlIERhdGFG
YWlsIGludGVycnVwdCBzaWcgKi8NCj4gICAgICAgICAgICAgICAgIHJlYWRsKGNjYWNoZV9iYXNl
ICsgU0lGSVZFX0NDQUNIRV9EQVRFQ0NGQUlMX0NPVU5UKTsNCj4gICAgICAgICAgICAgICAgIGF0
b21pY19ub3RpZmllcl9jYWxsX2NoYWluKCZjY2FjaGVfZXJyX2NoYWluLCBTSUZJVkVfQ0NBQ0hF
X0VSUl9UWVBFX1VFLA0KPiBAQCAtMjAwLDcgKzIwMyw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHNp
Zml2ZV9jY2FjaGVfaW5pdCh2b2lkKQ0KPiAgICAgICAgICAgICAgICAgZ19pcnFbaV0gPSBpcnFf
b2ZfcGFyc2VfYW5kX21hcChucCwgaSk7DQo+ICAgICAgICAgICAgICAgICByYyA9IHJlcXVlc3Rf
aXJxKGdfaXJxW2ldLCBjY2FjaGVfaW50X2hhbmRsZXIsIDAsICJjY2FjaGVfZWNjIiwgTlVMTCk7
DQo+ICAgICAgICAgICAgICAgICBpZiAocmMpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
cHJfZXJyKCJDQ0FDSEU6IENvdWxkIG5vdCByZXF1ZXN0IElSUSAlZFxuIiwgZ19pcnFbaV0pOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoIkNvdWxkIG5vdCByZXF1ZXN0IElSUSAl
ZFxuIiwgZ19pcnFbaV0pOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmM7DQo+
ICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiAtLQ0KPiAyLjM1LjENCj4gDQoNCg==
