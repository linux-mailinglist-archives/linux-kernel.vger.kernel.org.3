Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E45B0C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIGSlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiIGSlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:41:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E8A0324
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662576067; x=1694112067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b+ywTQT4kd30ojMBIKFx0Jg2JeeDuofyMffK5kuNmGY=;
  b=xEN5Q4uaCBBpd0NzF849cnFybZq5CQ4J0zYR+JLkVshkUASA/ksjMLb5
   KP09GGt7vC12tDFCYYXMRgRxmfOUeP2fs74nRz/DxENi+qffLsitBqhDp
   j0Obwi/oAc9Cevn+v5OagpTM7q1Hp8geA/vnQKYvlohdaEc71OuKxgIXs
   rzqjnPefSn3WbCZmk7nJ2o5HufnmN9a+gQ+vcAVOmmSlStFHD6DQtHSwf
   tRHd0R3Lzj6igQtnn/9tJly5ycJ1Bnw46kxiCJM2asClMUQmL3ikoQpfE
   XDEbuQHS1OmJ08Reuh+7l5Wghawqi+ZRLyX0GtaMpc6S90HGQmAxFmmyR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="179453344"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 11:41:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 11:41:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 11:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNKtF6p6cic6dNuWm8K9Yruu5Zue6UJKeJFxeQyheg+N7G1/TqyR2k4c9KX7VjwVDhZKsi8cXhWR1AyuW3/AVgFL1I1zfthHkPJN0zsqMm5wnt6GgSvnijOWON5x0In3cBJAxeqtAZrpUBLDxwRqVK3ce5MW+hIXYFp/JdpcOISklyRJ+Q8o2B5uVDhmGWOEHf6516Kymh3mjjoxqwyv9LNx3zBVB8ZDAD6qgBzkYw1LY9YaHMfj6hBTZqcnKiYWDqrq2CsvOJ7nKq9IzFem/K29oNCP4tbtBxcb4T3DKT0PxG+eyFqJlqrSPbk3/GqR9ImLR+5uTA6JTsNiMNT+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+ywTQT4kd30ojMBIKFx0Jg2JeeDuofyMffK5kuNmGY=;
 b=gTvNeroNfGoc1ptBbZsscjOcoM+ok4AAOqcI94+2B1LqDcPWSQbWkq4f6jZox3WztEYh430lWt6sOG3183wwqfE7h9K2z/t1WYosuIrtb/H7oz+YKMX7DOWz55bL0Y8gy4bjAne+AyolcffHEV3You4KR05Uw/afHURaGrblAO0IlhytbvWfaVr8Crz480Q+9PNwsDmhDQW43u7O3vFP46g+Rd+em4Mm3vs+PN4dGsv0kVwqo2Jwt1X6UVp5VmMIbCAY/Hi9JHi+qpTKHdzlKjb6fXnVQCWKbDE8GsmLjRmkmIx4MQZSNZpD5tQn9F4P1e4JRSVBlaMIk5dM6W1PkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+ywTQT4kd30ojMBIKFx0Jg2JeeDuofyMffK5kuNmGY=;
 b=AD3VaL2e5wt1fJSUMzJjsKM74okqLHNogGLglbi1LOBr1G91sO2p7Isfh0gh6L1lIhd6cXre5LHkN/dWyCd7LZSbGSRkr7IZGe3FgP+/JkWvctGlIv5ijxZfvXUw6uAyGRD301UnoEWjl6kwX7SL/vIf6EiNDByyyjl83dAoo2o=
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB3454.namprd11.prod.outlook.com (2603:10b6:805:c1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 18:40:52 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220%5]) with mapi id 15.20.5588.011; Wed, 7 Sep 2022
 18:40:52 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <samuel@sholland.org>, <guoren@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
Subject: Re: [PATCH] riscv: make t-head erratas depend on MMU
Thread-Topic: [PATCH] riscv: make t-head erratas depend on MMU
Thread-Index: AQHYwtGjWFgnBf3Kq0easQ/4mXN9Fa3UKiKAgAAXM4CAAAu7AA==
Date:   Wed, 7 Sep 2022 18:40:51 +0000
Message-ID: <1ae22496-6972-0a7a-d886-e19e1607bb25@microchip.com>
References: <20220907154932.2858518-1-heiko@sntech.de>
 <861b6cf0-c120-212f-43d8-3431551fe871@microchip.com>
 <3490524.MsWZr2WtbB@diego>
In-Reply-To: <3490524.MsWZr2WtbB@diego>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 632a1f43-450d-45e9-9b07-08da91007da3
x-ms-traffictypediagnostic: SN6PR11MB3454:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7cf7JJIH60m4Egs09K6QqE3Xm4IiAeQJA0dgHUgYG9kLKgOTE5u10x5a7bHARmW7/E0pY3cR0zKrnb5my6KdzyN0WLCV+cWzErd8HFWtcK1FGMUmdZnhulVPh3enA8GAz5nHK4cMeWvlSnhA0o2TMLCOX7lckBzVx4sMgY9xjp1GtUEYA9Zc24uUFMx4UixdIB2wrpO4W7/fA5kFmUTBj4Y63BN0/R2mn8qVW4XllDLiiXiJpCLynMuqIb+bnEb9x4Ya3DL7MokrTOLsvZuDDLRmUC7gUHUwMWLNHFTxLhrHnPWdDms6iTeFtiubNCVTPfLNUJ/IGK8/ssVaFsUptcV0Fhyotlw9BOvQ3crGZuIcjpAGgGBMiBVDCMnVCxzh/2zQjp9xNZ1T/t0zisACptL6TVURMJeyRuo0P0dtj7GWawubUq6GLK81yKEEsiQ7vNCksNs+7EhEJoblCoYwS53aukIFOdsuaY+GPIiFZ+368vPWh+HDuRYN6VRZ1umo+PVjxRFxvN+FwdBZdH8oblKiIksgLA9DMDYGpSjkzmwTNYmRL59P6aTzxr2WX/envPl68vzva3nl/gQOyYcCKASEWmn12MeH5Ck/9Ai2NEowaWZjZtsZF8M3gRRqXoh5gO0IUy8Np7YHdnZQFck572Ia+Pbvjem83qCv3EY4V/V1b9uCU7rkufVJgQ+sj6NYnlE6kkll7QNs9f+xPFpXrjAHhqMkzN+vqOhw85isNEHv1PMMUo4ENbItVZg814MSuX1R0WwbSvc4FyHS+mJDrUaGPaeLjshoIa0zBDsG4SKYLGpuN5lBNiL5cVO6pYWiiHg8gu/63D8dLVAVj7YtBjwQpdVPPhrpoikoxfEQgnhvPN6f5vshF+fypVLJXSE0IuxO0Ey8aOgEekP8Xx1Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(366004)(136003)(2906002)(66476007)(66446008)(31686004)(64756008)(66946007)(66556008)(76116006)(91956017)(83380400001)(2616005)(8676002)(122000001)(4326008)(8936002)(36756003)(5660300002)(38100700002)(38070700005)(316002)(54906003)(41300700001)(966005)(6486002)(478600001)(6506007)(6512007)(71200400001)(26005)(53546011)(110136005)(31696002)(86362001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clVQZ1pNNHVkaVN0MWR6MCtRZTNNbTFjV3VkTDdvS1BtU2MrQTcySjZ1ZmlT?=
 =?utf-8?B?UytIWDZUOVpJb0V5Sld2bnNKZTl3TE9XV2ovOUpBUjBJVDFnRGRBT3QwSmxk?=
 =?utf-8?B?L2hBYmRzTWhWR1p3eFI3YkNXYkhKeXhiZkZWaTJWTWllcEpxT2NhOVNCR21h?=
 =?utf-8?B?QmJFYWM5TTlKQXVhSzBnMHU0REtsMXFrRlVuU0FaaE0wekI4VXlFZDdxbHRZ?=
 =?utf-8?B?aVdDNnh0SFRKekc1b3N5aG5abXZRNmxOTnlXdEZVRWRTOTRDYTZVbVFaaUQ1?=
 =?utf-8?B?RkFVVThRRFpsQk45bjBvcmJBSW8wMkZxajlWa3IvTUloWllNbWt1TmlRbzhD?=
 =?utf-8?B?SGl5UVN0ajdzMlBDN1VoVnh3NmhlVXZrVVI0UjVJekVTSzBvSlp2THhqMk9M?=
 =?utf-8?B?ckcvVDdQVXp0MkwwZEJpOEFHazIyWjZVV1dkTDZhakRDQk5jYUhtbUVjWmFn?=
 =?utf-8?B?TlJvOTBUbmZDWDQyLzBqaVJNZ2FOL0N6WFhlRkJxZ0ZhcGVoQWwyc3QyT3B1?=
 =?utf-8?B?TWtQOU5mNlF6UXRrTXBpcU5PZGRrMnRQeWV5ZXZuQWZSWUdOVXVOMHE0RU4r?=
 =?utf-8?B?dXBlZDVONDJEWndVenBTYnNJQzNENDJKdjBraVpEZUFnMnNweXZLUWVQZnhh?=
 =?utf-8?B?VjdOTFVtbGVCRUVxOFRMY2QvdHZqNG1WcW9SYlExRWtRVXcxbmtXYURSNlBD?=
 =?utf-8?B?VnJlZndMT0IwRW9BVUhjVkhzZUx5TU9nbDh0SEwvTVNwdFlYOEZ6bFh2cHdr?=
 =?utf-8?B?RS94V3RHbmVid1pZUEdnbmhsQXVJcVpyQW1pSFVFN0tiNXpEZThvdWwrcFdv?=
 =?utf-8?B?ZTRUZWo5TVZRUWJIOGJObXV1ZFpOQlgrRkFWcXBtMVBLc2JKVCtiUHA2Um5z?=
 =?utf-8?B?YmlxZWdnNWFCZS8rcGlPVlAxOTdVanNZNXdXbEZmWERydXdEZ1RrMGlxeUNl?=
 =?utf-8?B?QWJsNUhhdWdHL2liZmgzVnRRRit4MU83TnhYU2ZuTk44d2k1aW0yeVpKa3pW?=
 =?utf-8?B?U2NTem05dTJybW1WaUNFSnZ6bzdMQzY0WHhFaXQzN1BSaTJFUGRGWDNraVBq?=
 =?utf-8?B?MHpDRExzYlUxWC9TR2thK2w3MW9qTExLMWd6YTNFWkNsV3RxT0FpVUhTcTYx?=
 =?utf-8?B?bEdyUWoyM25naEhlaEVFeXRSNXRaeXUveTA1RFB2WTMxaitqa1BSLzMwZldG?=
 =?utf-8?B?RDl5SHJzb0syd2pUTFRoQ0JpeUdVd1gxcFZyL1l1UDB6S3dnUjVaYk84aGVV?=
 =?utf-8?B?b3JRbExVYTh3OENPN29KTTRuUDVtQWx3RU9CZENXeHR1NWNlMVpVb3hnNXI3?=
 =?utf-8?B?R25YdEFpY09BZ0dKbVYvajFmM21nbE1nUVM0NnJEV2FGSjNseVpXVmNSNjFm?=
 =?utf-8?B?QlR3TWsvNGc0aE9WY2IxK0c4dXRJSkprTXFEMjdyVGpQMXdKZnZSd3lma3dL?=
 =?utf-8?B?L0U5bnhubGJCK0tTUWN0Y3ZQUjZPUStBbHNHanlhMEFWdHB0WHpuNFY0R1pJ?=
 =?utf-8?B?bnRUekFEM2tnd3plYVZrOGpQblRmY25SNkR2OUg1cjhRTkFpZmVVOEloOWNN?=
 =?utf-8?B?RVIyeFlQUTN5L2pPdG5uNE5vcDgrazd2NnlvNTZOZ0EzRytzMzY0T3h3eWtQ?=
 =?utf-8?B?Z2RkNmUzZ2tUMnNST0hucUN1eFRUM2M0eXAvczhuOE9WMWtqdDYrOU5nOEIr?=
 =?utf-8?B?UlV3UW1WSUdYaXowYnpvMEhEQXlPQTNWUDcreWFnZ3JwS0V1dWRKTEs0Um1l?=
 =?utf-8?B?VVF5TkhRdldxdm9IUDdJT043aDU3dExML3lSWTJVeEdZZ1ZzZlBmaVJtQlpt?=
 =?utf-8?B?Wk1VV2hySGZuV3A3dU9hYmpMZlEyWEtvVWJWcDNVUW9HeTZ3M1IveVc3aHBK?=
 =?utf-8?B?ZEl0UEkrZmVoV0lxWGw1ZVp5MHNxSWZJQ1hVN3gya2t3Y1ROZUJhaEtkQ0hi?=
 =?utf-8?B?SkM3Nyt4SjBhb0cycCtjOWY3RWFTb21BUjhpNDVyK1hoTUx3c1pUWVhMVDN3?=
 =?utf-8?B?V1FYckEyOGdJZmtoSWNnMUdBcjVMWU1rS0NwK2F3Y2lTYyt5YkhJZUJzSk5C?=
 =?utf-8?B?b1dBTEM4WDZEczh5RDZ2UEwwRUMzYnpzbUpXbDVEdGY4SE5kNEo0UGhKTmU2?=
 =?utf-8?Q?nrK7c3BScJN8nsgbTiYPOghrB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A79651078288DE468FEB4102C0310680@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632a1f43-450d-45e9-9b07-08da91007da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 18:40:51.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoeP2F9ieQ97JDZZr2TeeFi0/aYwy9wfYjLXc+VvuMPpdnXzimjdJMP6PLtEAzyNkuuxB6ETxoV8tSbxVF2noUAW7F/ebY8Cqnm77WgS2Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3454
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDkvMjAyMiAxODo1OCwgSGVpa28gU3TDvGJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gTWl0dHdvY2gsIDcuIFNlcHRlbWJlciAy
MDIyLCAxODozNTo1MCBDRVNUIHNjaHJpZWIgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb206DQo+
PiBPbiAwNy8wOS8yMDIyIDE2OjQ5LCBIZWlrbyBTdHVlYm5lciB3cm90ZToNCj4+PiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IEJvdGggYmFzaWMgZXh0ZW5zaW9u
cyBvZiBTVlBCTVQgYW5kIFpJQ0JPTSBkZXBlbmQgb24gQ09ORklHX01NVS4NCj4+PiBNYWtlIHRo
ZSBULUhlYWQgZXJyYXRhIGltcGxlbWVudGF0aW9ucyBvZiB0aGUgc2ltaWxhciBmdW5jdGlvbmFs
aXR5DQo+Pj4gYWxzbyBkZXBlbmQgb24gaXQgdG8gcHJldmVudCBidWlsZCBlcnJvcnMuDQo+Pj4N
Cj4+PiBGaXhlczogYTM1NzA3YzNkODUwICgicmlzY3Y6IGFkZCBtZW1vcnktdHlwZSBlcnJhdGEg
Zm9yIFQtSGVhZCIpDQo+Pj4gRml4ZXM6IGQyMGVjNzUyOTIzNiAoInJpc2N2OiBpbXBsZW1lbnQg
Y2FjaGUtbWFuYWdlbWVudCBlcnJhdGEgZm9yIFQtSGVhZCBTb0NzIikNCj4+PiBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+Pg0KPj4gSW4gY2FzZSBhbnlv
bmUgY2FyZXM6DQo+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA5MDcw
NTM2LmxJZWZzQnVSLWxrcEBpbnRlbC5jb20vDQo+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEhlaWtv
IFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+DQo+Pj4gLS0tDQo+Pj4gIGFyY2gvcmlzY3YvS2Nv
bmZpZy5lcnJhdGFzIHwgNCArKy0tDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9LY29u
ZmlnLmVycmF0YXMgYi9hcmNoL3Jpc2N2L0tjb25maWcuZXJyYXRhcw0KPj4+IGluZGV4IDY4NTBl
OTM4OTkzMC4uZjM2MjNkZjIzYjVmIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3YvS2NvbmZp
Zy5lcnJhdGFzDQo+Pj4gKysrIGIvYXJjaC9yaXNjdi9LY29uZmlnLmVycmF0YXMNCj4+PiBAQCAt
NDYsNyArNDYsNyBAQCBjb25maWcgRVJSQVRBX1RIRUFEDQo+Pj4NCj4+PiAgY29uZmlnIEVSUkFU
QV9USEVBRF9QQk1UDQo+Pj4gICAgICAgICBib29sICJBcHBseSBULUhlYWQgbWVtb3J5IHR5cGUg
ZXJyYXRhIg0KPj4+IC0gICAgICAgZGVwZW5kcyBvbiBFUlJBVEFfVEhFQUQgJiYgNjRCSVQNCj4+
PiArICAgICAgIGRlcGVuZHMgb24gRVJSQVRBX1RIRUFEICYmIDY0QklUICYmIE1NVQ0KPj4+ICAg
ICAgICAgc2VsZWN0IFJJU0NWX0FMVEVSTkFUSVZFX0VBUkxZDQo+Pj4gICAgICAgICBkZWZhdWx0
IHkNCj4+PiAgICAgICAgIGhlbHANCj4+PiBAQCAtNTcsNyArNTcsNyBAQCBjb25maWcgRVJSQVRB
X1RIRUFEX1BCTVQNCj4+Pg0KPj4+ICBjb25maWcgRVJSQVRBX1RIRUFEX0NNTw0KPj4+ICAgICAg
ICAgYm9vbCAiQXBwbHkgVC1IZWFkIGNhY2hlIG1hbmFnZW1lbnQgZXJyYXRhIg0KPj4+IC0gICAg
ICAgZGVwZW5kcyBvbiBFUlJBVEFfVEhFQUQNCj4+PiArICAgICAgIGRlcGVuZHMgb24gRVJSQVRB
X1RIRUFEICYmIE1NVQ0KPj4NCj4+ICJSYW5kb20iIHRob3VnaHQvcXVlc3Rpb246DQo+PiBUaGVz
ZSB0d28gKGFuZCB0aGUgc2lmaXZlKSBlcnJhdGEgYWxsIHVzZSBvbmVsaW5lciBkZXBlbmRzDQo+
PiBidXQgdGhlIFBNVSBzZXJpZXMgb2YgeW91cnMgaGFzOg0KPj4gY29uZmlnIEVSUkFUQV9USEVB
RF9QTVUNCj4+ICAgICAgIGJvb2wgIkFwcGx5IFQtSGVhZCBQTVUgZXJyYXRhIg0KPj4gICAgICAg
ZGVwZW5kcyBvbiBFUlJBVEFfVEhFQUQNCj4+ICAgICAgIGRlcGVuZHMgb24gUklTQ1ZfUE1VX1NC
SQ0KPj4NCj4+IFdoYXQncyB0aGUgcmF0aW9uYWxlIGJlaGluZCBub3Qgb25lbGluZXItaW5nIHRo
YXQgb25lPw0KPiANCj4gcHJvYmFibHkgbm90IHRoaW5raW5nIHRvbyBtdWNoIGFib3V0IGl0IGJl
Zm9yZWhhbmQgOy0pIC4NCj4gDQo+IEJ1dCB5ZXMgZ29pbmcgd2l0aCBvbmUgbGluZSBpcyBwcm9i
YWJseSBuaWNlciwgc28gSSB0cmFuc3BsYW50ZWQgdGhpcw0KPiBjb21tZW50IG92ZXIgdG8gdGhl
IHNiaS1wbXUgcGF0Y2gsIGZvciB3aGVuIGEgdjQgbWlnaHQgYmUgbmVjZXNzYXJ5Lg0KDQpFaGgg
bXkgT0NEIGp1c3QgZ290IHRyaWdnZXJlZCBieSBpdCB0aGF0J3MgYWxsLg0KSSd2ZSBiZWVuIGtp
bmRhIHdvbmRlcmluZyBpbiBnZW5lcmFsIHdoYXQncyBhIGdvb2QgcG9saWN5IGZvciBkZXBlbmRz
DQpsaW5lcywgc2VlbXMgbGlrZSBvbmUgb2YgdGhvc2UgdGhpbmdzIHRoYXQganVzdCB2YXJpZXMg
d2lsZGx5IHRiaC4uLg0KDQo+IA0KPiANCj4gSGVpa28NCj4gDQo+IA0KPj4gVGhhdCdzIG9idmlv
dXNseSBvcnRob2dvbmFsIHRvIHRoaXMgcGF0Y2ggdGhvdWdoLCBzbzoNCj4+IFJldmlld2VkLWJ5
OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+PiAgICAg
ICAgIHNlbGVjdCBSSVNDVl9ETUFfTk9OQ09IRVJFTlQNCj4+PiAgICAgICAgIGRlZmF1bHQgeQ0K
Pj4+ICAgICAgICAgaGVscA0KPj4+IC0tDQo+Pj4gMi4zNS4xDQo+Pj4NCj4+Pg0KPj4+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+Pj4gbGludXgtcmlz
Y3YgbWFpbGluZyBsaXN0DQo+Pj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4+
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YN
Cj4+DQo+Pg0KPiANCj4gDQo+IA0KPiANCg0K
