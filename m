Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431E85AD079
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbiIEKqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiIEKq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:46:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB16B4CA2F;
        Mon,  5 Sep 2022 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662374784; x=1693910784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1tAajSU3YxRg9haF8keeSe6wLS+bENdPS3ZSJrGtYQw=;
  b=i2CA9fOlEuOIOtRfSmQ6ZIKfLaxo2/Vi7ro0TPKPpcHVrM5TnmjD8e5i
   0qQpQjcT0/fRY9st0xfEODVT4K/80nbSxfKSf2xtfATAZqTN8mLcNgzua
   RItGOXEFiP9rqYRvaassyQUT/IrL23x1t5UY2TxMe8nb0WRgDnsyWsZ0A
   GEhkpKoRKw0H9IJAI5Hql158CAoyl6xStdXt5jfsYYZt6PQmsnqNvTrUp
   KtdV4uvGZP6nqfsSRkjrTFZPlpjlHrEYoMzeFT5zxipWbtX6Z9F5ojSOv
   pQXcX4Dr1JCB43X42eaYikolVGAN764cav5QtiNay/qCevELbYjojSea2
   w==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="179203804"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 03:46:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 03:46:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 5 Sep 2022 03:46:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diqgeCoPO2Yetu0bWhwUQQ/g0Ald/UNiwJqtlCPESOrHxWeCovIvHxLWBBPevVpL+8ihwbUt0wUxvits4fY5nxiiUDXVDyPeSsAmdOogPpa8yMPMqDqxDeS62oQlkPCeWQfTrXR3PuvUZdeUGevzA15CuFGB7Idx5D8ie8q/MmV35hhxqwgyXaImMX1KmldR9dbA3oejyBwqoNNoNgyourEebWy1R/P3LZdgCKIglp8t0TsoSASL6mhAdGxWB6icUqn2M6FOO7rWbemdAzuQq6tAgL7ahX7UBFvYHY1y6U5UwHvX0ClTVQB7Yj5h1/940Xhp1jhjfPX53k7C6v6sSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tAajSU3YxRg9haF8keeSe6wLS+bENdPS3ZSJrGtYQw=;
 b=LYdZCHjvMoTaGIEM2EGlecxpU4oVBKptqQEVWH3k8WBjBOYXiJhDzP4AekJ4fIRVvOPfRWHSxze6fjwHT0WM04yvp3ktqP1/LevpySz8cu2tke0K40p45ZnvQT0uI9mFmOHaj8zMrYPbLlwXGDYMGtTpGLJ9QBfHc6nUxe5BppwvmrW6r4GAjOhzPhl4PQj2S1f7e1QImBH1lPlrPt5R/eb7ob5zta/M/M0xSgJ0Ln/qcqVkrWGxq+8b2wVQHKMKV7agryvSwevAbpq0duhr3di47it9hZeE9ElsGgLyJzJs6D8i91kSr+ObAskJghRPZtpja+v1nLMfpw8+ddllYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tAajSU3YxRg9haF8keeSe6wLS+bENdPS3ZSJrGtYQw=;
 b=vBK4XNvb95ThXLLNeL2cFqBngZglVkBoJKhENlFQd6yaB0tjYh7dwv97zc0AB888UaKTU+QH4Rrk4B/RzTBvYBM+VKNsDEeG3nxcd76Y+JKGFXtkN1vx0zSeeSMh5dDeYvuNLe7HLOh4Le/qYTjMZzfLOpAKheakbaa48aBkh+w=
Received: from PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 by BN6PR11MB4052.namprd11.prod.outlook.com (2603:10b6:405:7a::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Mon, 5 Sep
 2022 10:46:19 +0000
Received: from PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::d9b3:8e55:269c:b122]) by PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::d9b3:8e55:269c:b122%6]) with mapi id 15.20.5588.012; Mon, 5 Sep 2022
 10:46:19 +0000
From:   <Lewis.Hanly@microchip.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <Conor.Dooley@microchip.com>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <palmer@dabbelt.com>,
        <maz@kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v6 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v6 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYsJ/Hf9/ChBUZqEipNmgMsTD4GK2601kAgA7F+QCABy7jAA==
Date:   Mon, 5 Sep 2022 10:46:19 +0000
Message-ID: <e46a88a8b6b60e56db82c3a42f7ba38068aadecf.camel@microchip.com>
References: <20220815120834.1562544-1-lewis.hanly@microchip.com>
         <20220815120834.1562544-2-lewis.hanly@microchip.com>
         <CACRpkdbk_ZqYnDzXgmbnAxhs+mEe9f2X-y++9HDS-O=UO_tUmg@mail.gmail.com>
         <CAHp75Vc4cMGBdJpOsRMDLWU+6+eYwbsF3-Mz40-KazLGhwkHMA@mail.gmail.com>
In-Reply-To: <CAHp75Vc4cMGBdJpOsRMDLWU+6+eYwbsF3-Mz40-KazLGhwkHMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75205cfc-4e84-4eb5-bc56-08da8f2bddbe
x-ms-traffictypediagnostic: BN6PR11MB4052:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21t7SLQqW6nYoPRlE34mQRHLLAnCSXNTY6zM0jTc+fIFPXumHwL4j7JI6ibx8PvxrZvRJAAKPvCAhaZHDyY6EE//FKVTNy5lOX0YgCh4DoI8MLtRlla0UoSHBBYxXqEwoaY6PRo2vCrNh/8I2dA3vBqsZxoVypGKqIVZV2Xf/jBCTcgfqqDdKseTr1DX4q9WWDnNf6DdCszpM2VAW5ssJ7G20us1m1OekR0He1kfPToK0JSthH37IOs2u5BW/7tioMqq34EgyepmqN61joc7z7xtYNlHNhbvtTEtSU4WxZCEr8oja5nN3S0Y02J3UqbcEs1SAr9fXUK56CN37fnYwcxa7c9UHaP1kp8RCXXT5jKtPajQE3MHMNgyNaEQtVFhpY3HUWF9cpRcsPlGKcy7AZygPRrSQ8zhP6eaXAprNf48sCtJ3Ri+U4sdJKYi1XHNp3XvoD6OFiiRpsotmbe/wJ30emXff9ms/uT13KvAdnJyNh1jtts6492uM3kJ2llu1GEYnriPR/zY8YIQP03WVxJIdGvvD4tVZFA95OCBqQ5Oqup9KZAooJoAQA0k1vWjE07Shj1wshEDjFLIl4pw0EyneLwfOwekWJsqchXTblcQevj83Cwh55CFVjN1DpsWQ19LoL8MJdkbpPDHcNHw3RuS9uA12GMja6xo8Eg7e9K003m+v+P/00I2OZTfqu7/csOB9wEz2LVZBfd0FN+EYqelFRAzEWxX4xzZMA6r26anjGkDZ9+HNDOpU7DiJoT2w1cAJlaumRtikVBIyDpNTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(396003)(346002)(39860400002)(6486002)(478600001)(38070700005)(2906002)(2616005)(86362001)(8936002)(41300700001)(186003)(4744005)(4326008)(26005)(6512007)(6506007)(5660300002)(66556008)(36756003)(71200400001)(66446008)(38100700002)(66946007)(8676002)(54906003)(66476007)(64756008)(316002)(76116006)(110136005)(107886003)(91956017)(53546011)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVNSU0FLZWhWKzhmbWwxMG5Zc3lwMk1BdEFSV2RsMUZtTUpPektJOTQwL2xS?=
 =?utf-8?B?K1A3cHBKeVRkekNDMnVkVE1PTG5NbGtnQ1dQRUttc1ZPMjc4RGFzalJnbVlw?=
 =?utf-8?B?VmdzM1g4ZWlQbWxQNEJWbXIyRWJyYWs1NVNINENnV2NGTXJJdG0xT2ZUZUhL?=
 =?utf-8?B?WThwT3dRWVltZmxadExETzhtTVFZYmM3UGN2KzVUbWh1KzNsUzZTZzJNTnVh?=
 =?utf-8?B?bXVwcVl5VS9Zb1ppWU04V2tNZDdoa21yQWJNRTlabUhSckV3d09JaHNVVEtY?=
 =?utf-8?B?Zi9QVVpRMnZkYVBWUnNJaXMzV0N6VkVOc0R6c2wyNExOWE9kajJEQ2NvREFR?=
 =?utf-8?B?RzlWaFErR29vV1VwVTNydSt3TFlCbkg0SU54RXhyMkVZTjlzWnhJd0hGMWRJ?=
 =?utf-8?B?Smtpei84dmlFS2l3RFVXenBWTXV4M1R4dis4S1BNdFZJbXhYRTdnRkNBcHJv?=
 =?utf-8?B?cVNXY0RMS0dkYzBvUHViWUhuMUIzTENZOVhqOXY3RU85OE9ra3VKUFZnSjUy?=
 =?utf-8?B?Y1RhWXBySjJ3TDJnbUwvY3NqdjAvQ3ZLNklzYTVyZVBpWmx6SFFoVHdFUW00?=
 =?utf-8?B?N0FXWGlVNjltdk9yU3FFeUxOWjVqRVhzWWRBWHllN0JlMzdXYmFWYVE3REFG?=
 =?utf-8?B?QnFoMW0ycjhtYVU2ZWZsYzVNWGQwS2xnNDZqSnpINTlscGVZRGFlT3FtNTNG?=
 =?utf-8?B?bENJWlpZSVBPSUphY1M3Yktmdkw3eWFsOHJMaXZCY0NXUng0cXQ5UzNxYkVa?=
 =?utf-8?B?Q2tTQVFjRi9HOHV2SjV3OVYrbExmcnBucG9nQ0ZMVXg4Q2pnc2E4UXdZcVVJ?=
 =?utf-8?B?MFRpaWZMT21IbEVZSjg0NUtvNjFWVGxhZStBdW02YURXQ3Y5ZW1tREJXMmNW?=
 =?utf-8?B?dTlyWU1IV25kTy9zUnVXV2hCbVdCRWF2anRvcXJxMi9aVVdvUWdKZE9nU3Yv?=
 =?utf-8?B?RzFRTGFPL3J5dUFDV3k3OHp3K25sdDBBVitxRGhpL0d2TjVUY1RJSG1JVElL?=
 =?utf-8?B?cmlLRXBhd3ZXZjl0c0kvMVFFM3h6SmVlVXhkNksvVWl5WEdVaFBlb08vTGpt?=
 =?utf-8?B?T3NKN0hPbTI2VTZoNHN4TG9VZDQyVTY2Sk5JenBLdzh6dG9hN2xycks1ODQ0?=
 =?utf-8?B?d3JqRGZ5ODJ1QkFXSFU5N3AydnVpdnFHekVhNTFrQ2lrNTRGV1RkTTFraHpq?=
 =?utf-8?B?ZCt2ck55aThlMi8wSFBMYmNKVGU4OHp2UTBtcGt0R01SMExLRUgvSkp3ck84?=
 =?utf-8?B?cHpkZVAyOXpYN0pZOFVXRFpOK2xIcFpDa1VTTk1qRzBMNUo1TE1rRHFUeUVl?=
 =?utf-8?B?NFVnMnlTcHYxUkFpWXhsTXBPRHdYYkxrZStLSlA1MkY4TDU1eC9lT1lpM3Zl?=
 =?utf-8?B?RDVSMnI1WStWNTYySElRbm1jZDRSUFVDNzlDMTdHcUtVRXZsbk9oUGl4ZzQ1?=
 =?utf-8?B?c254TEhhM3RUM2V6WG1kNXZveldMNXdQa3l1c2VPK3JSUFRyZllLbVhIa0ht?=
 =?utf-8?B?UTNWSlpmaFpMNGk3aVd6YjFaNTE4TWdTbFc1aEZiakZsYlFlM21lM0ZWdktk?=
 =?utf-8?B?cnhLYVo1T0JVZU9odGk4OWlOYy8wTnpyOVBPcms4V1FlZjZCbkJhTk1DR2VZ?=
 =?utf-8?B?anBTcFVvczA2SlJmN2RQWG95WDA0bWZscUNpbVdmcDBnUlQ4eEZoaTMzQU5h?=
 =?utf-8?B?cHNzVWlndGlCd2szUHdEU0IvMU12dEZzTU91WjZHQ0pJbVNyOG5SWGFOMmov?=
 =?utf-8?B?OU0zQldWUFFKZ0JEemtIa2lxV3ZIL05na2dGVFBBME52c3lkeC9mR2pFeEFi?=
 =?utf-8?B?dUJwSmc0N3pUZGp4Ymc4b2tYd00yNUpxcHg5N3dubGEwNlNoRDl3bkZKUTFr?=
 =?utf-8?B?dTlnWGZ4OXVUUkVoNXlMRXhFQkRnL1Y3YU5hTjhWSGlKbUpNY0M5a2srNG83?=
 =?utf-8?B?QjVCT1YrekY2OTNEdmd2c2FIYjNEamtDblZ3dVZPVURoeFZyaFJKbEpDN2dW?=
 =?utf-8?B?SkdWZEYvZGJONmtkTjJRL1NESDJxWktTZ3ByR1FNcmQzTXVPRTdWMHFiSUFv?=
 =?utf-8?B?Q21uY0JjMmU2S1RSbXZNNW5sL3VvMkZISGxFS3ZtWTNQRkhTdnNxRzBFejBu?=
 =?utf-8?B?cTdwNFl5eEQ5WXA3b25pUUhxdmdKemNleU9NRUZEVVlZblNYei9pRm9GZWZC?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4139CC13E76B2D499095B37799AA5CE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75205cfc-4e84-4eb5-bc56-08da8f2bddbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 10:46:19.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5NnqlGFS2MRlRgN5kS/oZMU522TSYKYLQXGm0dCdXpj6cpWftVvoAi68I+NZNJFUscx5sCKfsEJ8T82keU27++dsyIpjb5N7VOWGima+4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4052
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTAxIGF0IDAwOjA0ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBB
dWcgMjIsIDIwMjIgYXQgMjozMCBQTSBMaW51cyBXYWxsZWlqIDwNCj4gbGludXMud2FsbGVpakBs
aW5hcm8ub3JnPiB3cm90ZToNCj4gPiBPbiBNb24sIEF1ZyAxNSwgMjAyMiBhdCAyOjA4IFBNIDxs
ZXdpcy5oYW5seUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPiBUaGlz
IGxvb2tzIGxpa2UgIHRleHRib29rIGV4YW1wbGUgb2YgYSBkcml2ZXIgdGhhdCBjYW4gdXNlDQo+
ID4gQ09ORklHX0dQSU9fR0VORVJJQw0KPiA+IFNlZSBlLmcuIGRyaXZlcnMvZ3Bpby9ncGlvLWZ0
Z3BpbzAxMC5jIGZvciBhbiBleGFtcGxlDQo+ID4gb2YgaG93IHRvIHVzZSBiZ3Bpb19pbml0KCkg
dG8gc2V0IHVwIHRoZSBoZWxwZXIgbGlicmFyeSB0byBoYW5kbGUNCj4gPiB0aGUgR1BJTyBzaWRl
IG9mIHRoaW5ncyBhbmQgY29tYmluZSBpdCB3aXRoIGFuIGlycWNoaXAuDQo+ID4gWW91IGdldCBn
ZXQvc2V0X211bHRpcGxlKCkgZm9yIGZyZWUgd2l0aCB0aGlzIGFwcHJvYWNoLg0KPiA+IEFsc28g
c2VlIGRvY3VtZW50YXRpb24gZm9yIGJncGlvX2luaXQoKSBpbg0KPiA+IGRyaXZlcnMvZ3Bpby9n
cGlvLW1taW8uYy4NCj4gDQo+IEkgd291bGQgYWxzbyBzdWdnZXN0IGxvb2tpbmcgYXQgZ3Bpby1y
ZWdtYXAuYy4NClRoYW5rcyBBbmR5IEkgd2lsbCByZXZpZXcgdGhlIHJlZ21hcC5jIGZpbGUNCj4g
DQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
