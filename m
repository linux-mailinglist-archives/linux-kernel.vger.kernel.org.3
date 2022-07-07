Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF156AE24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiGGWL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiGGWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:11:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B265726B;
        Thu,  7 Jul 2022 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657231912; x=1688767912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=26Rct29ITyXdbLnZ3Pum7KvG7Nx396u15009evWg6uM=;
  b=JEFApZYjyCk2TSSGZT+DqQL7MFxK5Lfw2la7AHwTUeX0H55URz/+M2su
   4MKG3b+8bBWYgHnOfXbP4t7ASuyKLV/AmvmkPzZ+IOiWXdOql0ro8njDJ
   87uWeS2iWeVJX2g5aCsBWQrFRUtcYT9s4qBId52/moYjxiLpZZY7iz7dd
   ZGf62W/i3I9Y7S4iH1CGo/Ufq20D5OqpjWxGr3ab1DxGdhFSi0fqErrXz
   +aZ7vLM1r7hAJygPUvuENJ5yeFN9/CXLWglRkqxkkItoyBIgpibNEW0As
   +ijsEBqN+bPc15zcSD46nnW9SpE4LOLH13xkm1nOjNGAArq9qGSALs1cm
   g==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="171232563"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 15:11:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 15:11:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 15:11:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar9a2pKORHqgpx09u8OURdrX0eRiC5J4yggbYxvbDZ5JOA1vhoBv3WlzxxesBpglvuZuLt6BBBQhUwMzQ8Gq1hA5tw++GRyiALGm7X1vM8tiMK/JKVl0qmUOBMQWISDm5Fo5MZez2vVcmMJcyiM7C6XEbPDJnccloYu/b7s8IcEXzT+iujeitbhhqkK2v2rdiHA+T3nCxJk4eTzFHpn4Y41uk1xKnWITiobp1jjgGL1yvRr0lppKh1aPIHUntdLAdvweyyq6gkGG5oh9/LOxAoDd3kq6C1uAkYMxBsM5WNh+CWqfPmYOkZZznHmFk3oDmLgaHls9dP0Dwx3ptI/Teg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26Rct29ITyXdbLnZ3Pum7KvG7Nx396u15009evWg6uM=;
 b=VykShNPI7BnNby+BHOP6ZotWJq3+bu0zQ20JZ3hoNkFCObeIsW7/E8f39BMR2GoXsoKKifL8W8xweYQ0o9pLM6N3eViYhGFxQ3CRsok1ITqr/R1gVycW/YU5waj+AuEUjhgJq2j2RCJk6s0cvEbM/BK7RStqyEaQurpgq0hmJAFQSj+Zito1jWCrTpF4ONpZaZAT3tszRMaUgBIL4xuV0R+0Lb/ciXsxm5dUmXR2J8+LguDHC8V1joXCCi/RMtXd3TLsKykwITnN6TyD8yKo/wqx2D1TogBJlC/a+kB8H7KQVJOWMdV9QCCMY0Y4gEg+2oZ1pJLfGKHstWWS7lr7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26Rct29ITyXdbLnZ3Pum7KvG7Nx396u15009evWg6uM=;
 b=ts/1o9HxNjy/ZjKKtbsGnyl7F10BkTIEx8lllYWFq6+0XaGF2zvHeaFmHWYpHx5UKN60izcqhMZCnB7Zb+z4MmlC91OAII4ZDyEyZOBpijN/jRcRCDBQFfnQjEzC+bmM03YKKuOBx5AytwFYGvta6xgTek6ySjdH7ER+i17u5us=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3708.namprd11.prod.outlook.com (2603:10b6:5:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 22:11:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 22:11:46 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Ryan.Wanner@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ARM: dts: at91: sama5d2: Fix typo in i2s1 node
Thread-Topic: [PATCH v3] ARM: dts: at91: sama5d2: Fix typo in i2s1 node
Thread-Index: AQHYkk6LGllEaoAEgU2Pkn0BigF9kg==
Date:   Thu, 7 Jul 2022 22:11:46 +0000
Message-ID: <d4de4dca-de58-2e7f-ad49-dc2cb1d275aa@microchip.com>
References: <20220707215812.193008-1-Ryan.Wanner@microchip.com>
In-Reply-To: <20220707215812.193008-1-Ryan.Wanner@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39e585ac-7937-45ba-ac89-08da6065ae89
x-ms-traffictypediagnostic: DM6PR11MB3708:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8UGvQ5ZLrVGcMmYxkKp3/VypetgToPAU3vlAOLxg4RuNmQEtTJjw2MeCb058qUi4+4+ciOpEeBTDu4T1RaVkpnrqM9KxL2oiccu/boHoDL5uN9f9zkdAtigKX7C8RQk/bapDdv7A4PvbgpZM3eiM4O68yZulVYmNrc96+MpfbwSeDOFyTyYE9Mx1DU0n1AcGx3sYBzI99pYhmKIB6Xt4ceoS1aVtMzR47feP7IWRLyjpGi00l0OfZytd6myxsX7e1BUWWHSQeqbg4+OpXab4W/Q5GsBU/Hc7iIKg+mEo/DpG2XMxsW2EMuFiWSnBxWS0pwEBPUQunOKpOcouMLDWF7k1VyzyaWCO3qkIJQ+Araum/VyJkIKxvNl6XiAyTbbgrO6uS4bU4/RbZ6H0NPGItVTDs/Q0mq3pSBuSpbjsHDcnuhPysf3ka389E7e7DNiarDgjhV1FELR0XMu/EqHLc/kpN1DOupvA+5Ym7tU6NlPNwy5rOMPUAeZzzX3liv7xVwGFrI7i6h4Ad+1Xi5IeY0uNOMOObpJvlMWDyL6u8dDmlFZmtmT4Cxzz+uVQniox3XHHd4TdFvBsm+Q3/x5dldqd4zkt1yV8AswcPHerpURcOKN9Ksfpt2OHV/goOWkLkQyv+o7U9b8rNzWTb0TJ2CNwVj9hEpqdfmjnaKEifgzt9LF8rQDxqe1NiSY/vYGVad5NVPZNmgIIM7Xu4jsiNJX29wmslgXRS9VmLp8e1HBvQfmWtlI770rIOKkQKcqN2pEdw9yfn4KOgkF1OYGPZvlKoaKY9OJ+s+B4y1Lc9IVhSGSVb3gSL8Uz5CgatBA5/ccC8vXF2xBwg157i0JLY+HgurLNbXc8sP2uxocsgpjwDzHCFmVQ/qpUihFai7B1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(39860400002)(366004)(346002)(2616005)(186003)(36756003)(91956017)(6512007)(6486002)(110136005)(38100700002)(54906003)(316002)(31686004)(53546011)(71200400001)(4326008)(38070700005)(8676002)(86362001)(31696002)(83380400001)(26005)(64756008)(6506007)(5660300002)(122000001)(66556008)(2906002)(41300700001)(478600001)(66446008)(8936002)(66476007)(76116006)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUNIcmpnZnorNnc2QWM3YVBXRHJ1aU5aNytyMWFOZ1BKS3djNDhsNzNKTWVp?=
 =?utf-8?B?ZDJab1dvUUJad0pIVHpWM1FVNHFDMm82QlE3N0syemMybUNKdFVWREl5L3M4?=
 =?utf-8?B?S3dVWTZZY3JxNjVKM2Uyam1UZUxBTXhYZHg0VllpMmlUcFVmWTlaNjhVb0Na?=
 =?utf-8?B?WkRYcWtPaHlZcGdGWXdUdkFjbmZzOHh1aTlsQ04wZFFiRWo4dVArRlh1TTAy?=
 =?utf-8?B?UE9qRmJQMGhTdkQ3R1lCVmJTS1hOaWcrOHFkZDFRcHRJaGNyVnd0S29KVWIx?=
 =?utf-8?B?Nm5Ua1o0MDBnQmRyeWJOU1liL2xqSnZYckR5ZkNkUzNWaENzTDFvN01MOEFC?=
 =?utf-8?B?UVhNOVdFaTBiWHZPY3F6UHFiL3pmZVlYa3lzTHBEczE4MkZubUlKcXBBSUVV?=
 =?utf-8?B?bWlnWlIyQ1ExVS95bXBCRnZ2UXRINjBvcDNVL3ZaT09Dc2MxOG90eldaZnFi?=
 =?utf-8?B?U2M4bm9aQnBxQVBKY2d0NThQSzh2cDJQQ2M0aGFYODdIazdNTWdSZVdXbUV3?=
 =?utf-8?B?RW92K3FhKzRqb0tJZEZRb0JoUEhEdEpKUUk0TlNGY2x0UGp0WXJaM3R5RUxz?=
 =?utf-8?B?YkJJOEFyUW9RbWpOVndGVGptUGlrNnRuM09kMlIvWDdoODJHQmZPQW5LVWdE?=
 =?utf-8?B?Z2N6d2R2NXZWdDVTV3o2NEZPYWxJanhaR1I1SXk5aXY1a3FCR2Fua0NWWVMz?=
 =?utf-8?B?UEFiSWRsQmJBWVBWc2Q5bzVUNkk4OFhLMXorMVYwdlhSZjhES1AzUXlzeVd2?=
 =?utf-8?B?azUxa240UldRYzNTREliVHlnWHFoaXg1VHhWZ0lYcXZIT1NwQzZxNXRicC9O?=
 =?utf-8?B?NmVpTHA4aTl3d3I0QXQ0am1rUzNrZzIwTkxORDVFVFlvNXlabGI0UVd0MEo5?=
 =?utf-8?B?djdQdHord0JYWmdtcmZRVy83bENJWW1IbENIMStUR1BLTFdRSVQ4dVlNWGlH?=
 =?utf-8?B?TStJb3dDdFRGQUhyL1Y2cWN5Q2pkbzdFZWJUR09ZYkVRT0hqNTFHQWw5ekRC?=
 =?utf-8?B?K0JMbExQSGs5ejU4WTRDVlFoWTgydXA4VFhMVm9KUWE3N2dYUzZYMlRzM3dH?=
 =?utf-8?B?S3o1RThRaVR6R0RIbzdaNWdPNm4zeUxYeFIxRU1tQlp1R0RaNmNlRzJOY0FN?=
 =?utf-8?B?eGJROW82dmVRb2tRSG5EcXlyOUdONWZ4UVBvS0xodXlxK0VlSlgrQ25TOHA3?=
 =?utf-8?B?ZVA1TlNHSnFZcVgxejMvMzdGdVZ1TTlwcUZIWUhxSTNpTnpPZ21aSVdYaGtO?=
 =?utf-8?B?TkU5cWM3VlRnS2Jybm53c010NEVvS0lsNEhPVGd0N0Z4VHoxVEFyWVJVOWhF?=
 =?utf-8?B?Q25pdGdaM3QxREticzRjMkhpNWFoa0luSE1mK2tYQ2ZLVlE4T245c2xNUzdB?=
 =?utf-8?B?Qit3RjBQMnpJSERoNCtpVHl4dEdwQnVBNVpHOHBOMG5sZGhPZW9DNzVDZGx1?=
 =?utf-8?B?M3A3dmpiaDZ4ckhEeCtKQ01hMGZzc0hCSTJPRTR6MFl4T0MzTENIemFqMG1F?=
 =?utf-8?B?dmdYNFlEd0lTb2hTcGc0NlB0d2dvUjY2dEpaL2lpaG5RZFFudjBDeHZhaWgx?=
 =?utf-8?B?eEc1Zm1OR0s3MVI2NGlwa3pOMDdpYUJzVzdabUpjNjNhWlJEcG5JMGRMVEVa?=
 =?utf-8?B?M3FjR2w0T0NKejBUcC9KT09zYXRLK05LR1owUzBQM2JGa3Y3M1Y2d0hBaXZB?=
 =?utf-8?B?QUNvanBzR0tJRndtZ1YzSjdaVlZvRHExYS93ckRXUy9MR1V6Zyt5UDMrZHNH?=
 =?utf-8?B?RkdkMHBSL2xPdzFTNHVYR0VGRGNpYmo2SU9uY0hyby81cGZiOXdrbmtOQkpa?=
 =?utf-8?B?VGN3WTladGxKbWxKQ1dzSnBoVWxtME1oRVZBc25MSUVqYkNsRXJwSENKOTVK?=
 =?utf-8?B?YjBQLzAwNU1leEdtSi9pL2VYMEhtbjg1SDM4NnJUMUJDV25JZmd2OXdRM0JQ?=
 =?utf-8?B?dkZXQTBab0gyNk96cHFVUGp3dWNaZ3Z3RjZZUy9PN0RFbG55ZGwxV3ZkODNR?=
 =?utf-8?B?cGMwZi8vYW1JY3h3MkszcVkraGF6UGZORmxCZ0dKQk5LTm5RQ0xPUUF4R0ly?=
 =?utf-8?B?ZmJ4MEZ6S1BRbWJOTlYzS3Y4aWpIOWRId2FMNmYzS2pnY1Z6dG9QK2dPYW0w?=
 =?utf-8?B?b1I4OHd5OEprYVp1bWZYWHIrY3EyeVV5RzJ2elZLdGZMbDN4S0FIcWoyNXF2?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1C9A83D6ECEA74891AC95F6A94B5FB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e585ac-7937-45ba-ac89-08da6065ae89
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 22:11:46.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPnlvo79xZ51s+/9xxHTJfYcWThUXBVNUsM8UGNiM0rUlJR0enSG1WplZtelN4qHOi47nQWbwk0Oeb9CtpaG823sFdEWmVV3FFAZiEZG3RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3708
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFJ5YW4sDQpKdXN0IGEgY291cGxlIG9mIG5pdC1waWNrIGNvbW1lbnRzOg0KDQpPbiAwNy8w
Ny8yMDIyIDIyOjU4LCBSeWFuLldhbm5lckBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBGcm9tOiBS
eWFuIFdhbm5lciA8Unlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbT4NCj4gDQo+IFR5cG8gaW4gaTJz
MSBjYXVzaW5nIGVycm9ycyBpbiBkdCBiaW5kaW5nIHZhbGlkYXRpb24uDQo+IENoYW5nZWQgYXNz
aWduZWQtcGFyZW5zIHRvIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgYW5kDQo+IHRvIG1hdGNoIGky
czAgbm9kZSBmb3JtYXR0aW5nLg0KDQpDb21taXQgbWVzc2FnZXMgYXJlIHVzdWFsbHkgd3JpdHRl
biBpbiB0aGUgaW1wZXJhdGl2ZSwgc28gcmF0aGVyDQp0aGFuICJjaGFuZ2VkIiwgd2UgdXN1YWxs
eSBzYXkgImNoYW5nZSIgZXRjLg0KDQo+IA0KPiBGaXhlczogMWNhODE4ODNjNTU3ICgiQVJNOiBk
dHM6IGF0OTE6IHNhbWE1ZDI6IGFkZCBub2RlcyBmb3IgSTJTIGNvbnRyb2xsZXJzIikNCj4gDQoN
ClRoZSBibGFuayBsaW5lIGhlcmUgaXNuJ3QgbmVlZGVkLg0KSSB3b3VsZG4ndCByZXNwaW4gYSB2
NCBmb3IgdGhpcyB1bmxlc3MgTmljb2xhcy9DbGF1ZGl1IHJlcXVlc3Qgb25lLg0KDQpUaGFua3Ms
DQpDb25vci4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIFdhbm5lciA8Unlhbi5XYW5uZXJAbWlj
cm9jaGlwLmNvbT4NCj4gLS0tDQo+IGNoYW5nZXMgaW4gdjI6DQo+IC1jb3JyZWN0ZWQgc3ViamVj
dCBhbmQgdGFncw0KPiBjaGFuZ2VzIGluIHYxOg0KPiAtY29ycmVjdGVkIGZvcm1hdHRpbmcgaXNz
dWVzDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMv
c2FtYTVkMi5kdHNpDQo+IGluZGV4IDg5YzcxZDQxOWY4Mi4uNjU5YTE3ZmM3NTVjIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW1hNWQyLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvc2FtYTVkMi5kdHNpDQo+IEBAIC0xMTI0LDcgKzExMjQsNyBAQCBBVDkxX1hETUFD
X0RUX1BFUklEKDMzKSk+LA0KPiAgCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVS
QUwgNTU+LCA8JnBtYyBQTUNfVFlQRV9HQ0sgNTU+Ow0KPiAgCQkJCWNsb2NrLW5hbWVzID0gInBj
bGsiLCAiZ2NsayI7DQo+ICAJCQkJYXNzaWduZWQtY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfQ09S
RSBQTUNfSTJTMV9NVVg+Ow0KPiAtCQkJCWFzc2lnbmVkLXBhcnJlbnRzID0gPCZwbWMgUE1DX1RZ
UEVfR0NLIDU1PjsNCj4gKwkJCQlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZwbWMgUE1DX1RZ
UEVfR0NLIDU1PjsNCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgCQkJfTsNCj4gIA0K
