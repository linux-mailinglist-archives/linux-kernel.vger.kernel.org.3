Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC405AAABC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiIBI6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiIBI6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:58:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB5EA1A60;
        Fri,  2 Sep 2022 01:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662109078; x=1693645078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+mUCgLSsBuMWiuVT4yyFtV3a7aMnMoEDOzA097ufzLs=;
  b=PT7W3Uyagb7g1GpvL3bsFHumzy0uJdABC0MNWMbkl9OteSCNCMuYW4iy
   AIg6v7GRQWaJLaPcLVW7RLTLePB4CaV2gons/Ep/qG0aqempre6cWuNuS
   tQn5Is/GGRPlO/DAFpTZqNWIqpWKr0IqUUyDKlks/mjqZvyogoUSmLbeh
   qiJPKDZI68EnW6UwMQ5swrYo+Y0l31yEEB/yEE964Mf4QMnUjMOGLPiTy
   BWgtA/63lFcLmyfF7utnoyRDy65eg//mwt7rXjEM6qlfzLlHV9yPsGPhC
   NeLkgI4SrMNJMHLqsb9hMqBm7c9r1+QhLbSNNPDzqzCyMfWLaZ4s1fMsi
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="178897123"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 01:57:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 01:57:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 2 Sep 2022 01:57:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcKDVZP1COT2inA2B2lcuyGZab5XFWbk78B5jiIuAZBsqeLM9vqwiS000J6wVebT4DJu7ruOUNZ6xqvc0+JIxwCceMBkATk15A4QAQ5Ti8gK7avXgxilK6+Tr561SX4dB1bFvpqdwORxq0PxH+/2ebeicvE0Sdw487LT7DwcqSq3UU2VhmRMX/QI4yv3JwOVhmH8EfnFgMHlJktnWrTQxoAk+oOdYLDqM2uZcFmPmNhMKes2s4jU0vv8cSo4Sxr1LOHC+N4kcpkejnlFs1AzkDtLMk7WkZvs0JtINk8IfEFswSDyavkWyLRULcPYpjzIY2bMSL9zC7UvWUq1EQjJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mUCgLSsBuMWiuVT4yyFtV3a7aMnMoEDOzA097ufzLs=;
 b=G5Spj3b/hEBlkTAXMaKTmFOqiVYzn36HsQBXdbiUuIy4MxGSkaqKI5FdkvVP39YGshZQtXvLE6XAxK0BsT4+bPdrOTw09o2sCy6A2VsISk4Pwlp0F9XjfXVnjnzzhNqUlc/GSLpO6pTPXU9LqlXLPW0WJDZos/W5uRU35KU+Q7SF4Q6lXwHXl+hLuPaTd9HDPju8XsJcSYQNwRkXBhHsOdsfQM357oHcBj7nhOUPmZm0vReqvb3Vifqhl1n8JVQruSvq9wjuZ7XD+guyQoaj/74Fy665E1oxebKAgMY7O9e/JOZ529GZHDxcOP8J1tBW/SGvYxucLizvDQJ4fOELKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mUCgLSsBuMWiuVT4yyFtV3a7aMnMoEDOzA097ufzLs=;
 b=LRgINS4b1qm/vszIYoLOQRekbrzsIoYi+96+AU3hzhmlzQp6+7mPWLqyxEdQuGNgGNBOzoo90pMX7QmBxfO5Wvie9LC7ksClf/9NB6EEIHjUEXa/kreH36ST4zVaKUtQPKCwSFeUslQJT1Q4vq1o+qWB4kmX9vxxdtxbSap5bhQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MW4PR11MB5798.namprd11.prod.outlook.com (2603:10b6:303:185::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 08:57:53 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 08:57:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2] ARM: dts: lan966x: add led configuration
Thread-Topic: [PATCH v2] ARM: dts: lan966x: add led configuration
Thread-Index: AQHYvqoV6utSGHEzd0qvPzEdx+Gsag==
Date:   Fri, 2 Sep 2022 08:57:52 +0000
Message-ID: <9f4c9fa4-bd26-3b3e-8ecb-e5dee6fed1b8@microchip.com>
References: <20220902062447.443846-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220902062447.443846-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57977fe7-8ec9-4451-bb78-08da8cc13859
x-ms-traffictypediagnostic: MW4PR11MB5798:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nyA0jfyoa32PZuOGt6TqD6oJAff/dmXGi1/McRxWgE3K+tYVOsQQVgfhu6MlypUHLjpcdMwcfVPFzo81UYN5YyZocRUIUfapNX+42yiHVap0rmaVBoAt7E8ZVkf2WC9hmg8BM7ECFesFAvO2Rk7ZDrU6wtJtj1nAznernmZUB4B1TYij28ELbh18nkdBcQrjtgzqEjgU+AYi8qzbNW4k191MyIHunn7OksKVwzjEwiFf6gwfaJHVd7Ddj3v+HqY8uN4quGLEBDs5uM4T2V4JPLGhWAK+SG06B22t+ZlgOCMtLgWwG4lucEQZX/GfQFNVyMbW/NlWsAZGWfim1PCDbt1beui7eEW3GqeZWkkbKpKXOQrIMLwp5d88Afg8sfmLbAAgitfO06hvmefBsBEOgnZ9d4Pb1XyNGIec2UEBWtC/lEAlVEKUxYzOYCtOvgir38d2xMQ1QIZh5ufupPEK9Qg2Pa93O8AcdgxjyxUYKbb7oWFg79g0L8ODuf+A30mSE7cQchLqHakqO4dzrBbXELey5VAHpohfOK6h5dahpL/9wxdmsch0uae97GvOoAeMtC19S9CX5CBxFCwdnwYr+H8c6xU6UB/vpx5SvUE7yL7L2QIe+eF5G/uMGOEPEkwVzRztzUvFSdVRkSYXDIt23rxLS6OsNLPucJQ9SI6D9aZ5hYhua409S9XCKUydH4m4tK+ApT2NijtcKG7VuFR4Qh5b+pJMiaVW1W9Bx/aC+VVPawQgkJHYbnWJ6R5KQM+A1iK9GF+5PNir7n5cgL35OiRxnFUSQHWgcawE/w2DS8L1DL+eBewiwHWXgU/tNWpa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(376002)(396003)(346002)(6506007)(6512007)(53546011)(26005)(2616005)(186003)(38100700002)(38070700005)(86362001)(31696002)(122000001)(31686004)(91956017)(64756008)(5660300002)(8676002)(8936002)(66476007)(107886003)(4326008)(66446008)(66946007)(66556008)(76116006)(2906002)(41300700001)(36756003)(316002)(478600001)(110136005)(71200400001)(54906003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0dhMURHZEErM1pRc3FmL1FOMTFQQzJKaGdvQnBKVFYzSUJLVHFwK2pkYW9a?=
 =?utf-8?B?MXE1QUo5WEtZK3kwM0dkdU9TaW9VMkFVUlp4M2dYK0lyd0wzK2RtWGpqQzRq?=
 =?utf-8?B?bFg3MTFqbmNzbGVDcW5zakJtQ1ArU2ZNYzVHaXFkOUN5NWZ4UUdudGxRK1ZY?=
 =?utf-8?B?VDNvTEFXa3gvdUNTLyt3L3JtOC9JVWtpWVpLNC96b0RaeE1pUnMvbUUrUDU1?=
 =?utf-8?B?OGZNMkpncVVxbHdxUUNobEpDQWtLUXJCdVVZRng4RVd3aExuZ0RLaUJZN2Np?=
 =?utf-8?B?bnQ4MXZsRWt1emZRWHBXQjhOc0lsRm9YQWRFOTA3SXg4Q0xBUXRUamZUOU5h?=
 =?utf-8?B?a0k2R2VvQnpMYzYvTWNTNjcvVTIzRVFuazRlYmIybmFQMWwwZGdJUlV1VWwx?=
 =?utf-8?B?MVVWWS81aC9PVkd1V3FKS09ROG1MbzQ4MlUvUFZNRllzVWxYemFpMktMUmdU?=
 =?utf-8?B?V2JIVHpqdlZrWmE3VEZzQzA5bHlBNjgraEsyVWViTUtlVUFpR0QyeWprdzVE?=
 =?utf-8?B?WXVwbXlyUjM4dEdyb3ZiZDBmcjM5MGhjU2NDTitKb1dDS1cxY3RoRlFscFlM?=
 =?utf-8?B?bjNLN0pPZm5rVStob0NuRk00Yllyb1JKMk9JUTB1bHpDK1RFZUFOUmJwS29p?=
 =?utf-8?B?MnRYekVRNWQ1RURTbXJsZWVRczE1RHQyRWNJWkp2V0IwaUJzNGhpMjQxNkFh?=
 =?utf-8?B?NWRLb0ROakVEK0ZWZXZlbXVHNDA5Wjg2ZFVpS0pUL2YvM01vT0h1dkkzVTVN?=
 =?utf-8?B?RVJoSnRCbjIxMGZ2RWJIcE5na3JqaE8rYXpsOS9YejByNUxQakZydVVKNXRh?=
 =?utf-8?B?dVA1bjRwV3lCd3Y5My9qckZndjljTU12RWQ0L2F4WUFQYm9RMTVIUXhhUGVO?=
 =?utf-8?B?c0tCWDA4OUV5N3hpVnViT083cTcxNkxhK0xuVDFmODAvS2N2WXIzRVdPMXUv?=
 =?utf-8?B?ZGY1VUtycTRGUTN1SS9GRktCRkJQT00wR21jWjBMMnVWcUk2U09RTHM5d2lJ?=
 =?utf-8?B?R09wYllkZzJIMFprZWdZTENkYXE3Qkhsa1NJTmRMVmdkVEhIQXRHWEFzL3JJ?=
 =?utf-8?B?VHU2cFNjZHVRclcyS2x3aVRTZWFaS2J2UzE5UFF0VDU0dTUreVdWbVZZYVdr?=
 =?utf-8?B?YkQvU2YvNkdCbHB6Y1FYOHFXNTNocmZGVmoxSXNTNEJxSTNad21xbXUzUEhF?=
 =?utf-8?B?YTNFTnZkU3ZWRW9hZ1ZSL2d3S0VrRFZ2dFV2NE1MSW03NiszaFdrTFNoNncy?=
 =?utf-8?B?Ylo0YmtESng3SkNnVU13d0dFTUNtQTAyT0VMaHROU3JtTXc3cDliWWN1d2hp?=
 =?utf-8?B?VWVqWkFQTHhpOUdmQWpvRXgvWVFEemp1eHZPSm1ISi9CUlVMTUIwc2F3K3lp?=
 =?utf-8?B?ZHZKNytFb0pyQThJKzZER0dXMEV3Z3FBdmRhVjlHMDlJaWREMzJRa0kyS0hE?=
 =?utf-8?B?dHQ0Qy9xSVpHZk9SazVWMWRXZkxBRDErTnhleHVEeC9SaWtBT1V0RU1wYzEx?=
 =?utf-8?B?NU5PWE5lYWFDdnVhbmtJMUpDclV0SnR4K0hzVVhVZTdMQ0pvUGpRQlRidU9j?=
 =?utf-8?B?VVlwdVpjOGZzVWROcHJhc1d6WWlsWXlnTnNvSFhrMlNGMVdBV3dsQWtiNlIz?=
 =?utf-8?B?N3FzUWlwamxINFJ3dHp0d2cxUHg5WW9mTis4bVlPanc2NHU3T3N0RGc4Ym8x?=
 =?utf-8?B?eGhJVVlvQmV2L2duRnJvL3ZTT0xqMDdwdWU4YnZhaEJtcHRtcFNzeEVXSFJu?=
 =?utf-8?B?OHZ3L3B3TTBmYUFtNXo0bjJOWElBbDNIV2tRVkdtRTFobTVUclUxb2FYMEhn?=
 =?utf-8?B?ZklCeE9ZRVZFVEtRbmpqK3diaDdNdVYra2NHSDFCNHlYMVRsL2M3SmFIT3Jj?=
 =?utf-8?B?OHNXTHZNTGxoZmU1cEVienVIa041S2pZb0QyQWRxQUxxa2JNdmQ4aFVnVXV0?=
 =?utf-8?B?SzZSOWtxdVdNT2oveFRYUnpVQVZRWVhFU1A2cER0WVFFS05tckZZeDBPSm5D?=
 =?utf-8?B?dHdmOVUvY1N6dXd4ZHRZZDFsQ3JnZG1Pa3hlelJMVm16dm9mT2NnbkNGYjhH?=
 =?utf-8?B?azBuNm9hOGhVbjMxbkNlcVRKYjU0S0hMOW9BUlFSck9oUURHajN0MG9vWERq?=
 =?utf-8?B?ZnFwQXZLM0pKK3hBWTA1TG9BcUNEVHFKOVdJczN3QkNrbGoyRndBbkdSaEpk?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1580500BE8AE047AC790AA84652259A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57977fe7-8ec9-4451-bb78-08da8cc13859
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 08:57:52.8171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UamFeSHSRynXO2Cp39NHq7VyWbNhrINLXxxwTQ6iC4RGJxTRxvMSw46HRYIEWlKTc5+/k+PF39xIjwrhNPMFdEn9ya4axXGgbof81BF7Sfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5798
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMDkuMjAyMiAwOToyNCwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFkZCBsZWQgY29u
ZmlndXJhdGlvbiBmb3IgcGNiODI5MSBhbmQgcGNiODMwOS4gQm90aCBwY2JzIGhhdmUgNCBsZWRz
IHdoaWNoDQo+IGFyZSBjb25uZWN0ZWQgdG8gdGhlIHNncGlvIGNvbnRyb2xsZXIuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBIb3JhdGl1IFZ1bHR1ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlwLmNv
bT4NCg0KQXBwbGllZCB0byBhdDkxLWR0LCB0aGFua3MhDQoNCj4gLS0tDQo+IHYxLT52MjoNCj4g
LSByZW1vdmUgc3RhdHVzIGZyb20gdGhlIGxlZHMgbm9kZSBhcyBkZWZhdWx0IGlzIG9rYXkNCj4g
LS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzIHwgMjggKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgz
MDkuZHRzIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDU2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9sYW45NjZ4LXBjYjgyOTEuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4Mjkx
LmR0cw0KPiBpbmRleCAyNGQ5MDU1YzRhMDguLjI4OWEzMTY0OTQyMiAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0cw0KPiArKysgYi9hcmNoL2FybS9i
b290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzDQo+IEBAIC0yMyw2ICsyMywzNCBAQCBncGlvLXJl
c3RhcnQgew0KPiAgCQlncGlvcyA9IDwmZ3BpbyA1NiBHUElPX0FDVElWRV9MT1c+Ow0KPiAgCQlw
cmlvcml0eSA9IDwyMDA+Ow0KPiAgCX07DQo+ICsNCj4gKwlsZWRzIHsNCj4gKwkJY29tcGF0aWJs
ZSA9ICJncGlvLWxlZHMiOw0KPiArDQo+ICsJCWxlZC1zMC1ibHVlIHsNCj4gKwkJCWxhYmVsID0g
InMwOmJsdWUiOw0KPiArCQkJZ3Bpb3MgPSA8JnNncGlvX291dCAyIDAgR1BJT19BQ1RJVkVfTE9X
PjsNCj4gKwkJCWRlZmF1bHQtc3RhdGUgPSAib2ZmIjsNCj4gKwkJfTsNCj4gKw0KPiArCQlsZWQt
czAtZ3JlZW4gew0KPiArCQkJbGFiZWwgPSAiczA6Z3JlZW4iOw0KPiArCQkJZ3Bpb3MgPSA8JnNn
cGlvX291dCAyIDEgR1BJT19BQ1RJVkVfTE9XPjsNCj4gKwkJCWRlZmF1bHQtc3RhdGUgPSAib2Zm
IjsNCj4gKwkJfTsNCj4gKw0KPiArCQlsZWQtczEtYmx1ZSB7DQo+ICsJCQlsYWJlbCA9ICJzMTpi
bHVlIjsNCj4gKwkJCWdwaW9zID0gPCZzZ3Bpb19vdXQgMyAwIEdQSU9fQUNUSVZFX0xPVz47DQo+
ICsJCQlkZWZhdWx0LXN0YXRlID0gIm9mZiI7DQo+ICsJCX07DQo+ICsNCj4gKwkJbGVkLXMxLWdy
ZWVuIHsNCj4gKwkJCWxhYmVsID0gInMxOmdyZWVuIjsNCj4gKwkJCWdwaW9zID0gPCZzZ3Bpb19v
dXQgMyAxIEdQSU9fQUNUSVZFX0xPVz47DQo+ICsJCQlkZWZhdWx0LXN0YXRlID0gIm9mZiI7DQo+
ICsJCX07DQo+ICsJfTsNCj4gIH07DQo+ICANCj4gICZncGlvIHsNCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODMwOS5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9s
YW45NjZ4LXBjYjgzMDkuZHRzDQo+IGluZGV4IDA1Y2UyN2VkNTY0OC4uY2ZkN2M4OTMzNzAzIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgzMDkuZHRzDQo+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODMwOS5kdHMNCj4gQEAgLTQyLDYgKzQy
LDM0IEBAIGkyYzEwMzogaTJjLXNmcEAyIHsNCj4gIAkJfTsNCj4gIAl9Ow0KPiAgDQo+ICsJbGVk
cyB7DQo+ICsJCWNvbXBhdGlibGUgPSAiZ3Bpby1sZWRzIjsNCj4gKw0KPiArCQlsZWQtczAtZ3Jl
ZW4gew0KPiArCQkJbGFiZWwgPSAiczA6Z3JlZW4iOw0KPiArCQkJZ3Bpb3MgPSA8JnNncGlvX291
dCAyIDAgR1BJT19BQ1RJVkVfTE9XPjsNCj4gKwkJCWRlZmF1bHQtc3RhdGUgPSAib2ZmIjsNCj4g
KwkJfTsNCj4gKw0KPiArCQlsZWQtczAtcmVkIHsNCj4gKwkJCWxhYmVsID0gInMwOnJlZCI7DQo+
ICsJCQlncGlvcyA9IDwmc2dwaW9fb3V0IDIgMSBHUElPX0FDVElWRV9MT1c+Ow0KPiArCQkJZGVm
YXVsdC1zdGF0ZSA9ICJvZmYiOw0KPiArCQl9Ow0KPiArDQo+ICsJCWxlZC1zMS1ncmVlbiB7DQo+
ICsJCQlsYWJlbCA9ICJzMTpncmVlbiI7DQo+ICsJCQlncGlvcyA9IDwmc2dwaW9fb3V0IDMgMCBH
UElPX0FDVElWRV9MT1c+Ow0KPiArCQkJZGVmYXVsdC1zdGF0ZSA9ICJvZmYiOw0KPiArCQl9Ow0K
PiArDQo+ICsJCWxlZC1zMS1yZWQgew0KPiArCQkJbGFiZWwgPSAiczE6cmVkIjsNCj4gKwkJCWdw
aW9zID0gPCZzZ3Bpb19vdXQgMyAxIEdQSU9fQUNUSVZFX0xPVz47DQo+ICsJCQlkZWZhdWx0LXN0
YXRlID0gIm9mZiI7DQo+ICsJCX07DQo+ICsJfTsNCj4gKw0KPiAgCW11eDogbXV4LWNvbnRyb2xs
ZXIgew0KPiAgCQljb21wYXRpYmxlID0gImdwaW8tbXV4IjsNCj4gIAkJI211eC1jb250cm9sLWNl
bGxzID0gPDA+Ow0KDQo=
