Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12D25A93B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiIAJ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiIAJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:56:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432B12C3C9;
        Thu,  1 Sep 2022 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662026211; x=1693562211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FHon6np5VUGxbuHgzDAIdOIFJaL5U/T3+vxkp9X7oZs=;
  b=NSJZ5PZZSDsktHQMFr1aUmSi1MpouMLOuQ51PlHPovlDUoW/tlP00vCN
   Rc0nRQ7AcETK8H8XRPz+s/k26atjjucYfTHcI1p5JUUtWkNPDpzOtMTSt
   yNTEtrm7GZjqJXDvIxKXxFMLTfLo5WTjVCL+lMQovhFhpiwxxUybcA5Zd
   UNzrq9WLHr2UxkF23/RgTBvi0i5fW6PdtZ/Viv1nt6xinkmozvyd2mAO+
   AFrMysATuOQNI8bpyPuDkg00QA1pVvrlu4H2uw64dmJe2uUJyhdKftig1
   WekK7feLhH7PM+hKltt4Cviy85vkOIM6T7PNEcaivKENvxKnZFMHbqkWH
   A==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="178742314"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 02:56:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 02:56:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 02:56:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDc19NpITjpelDY0Vg60w5CLMgaZRKJILfT/BnB+7rpyTKJ5WMfOBs0GxNstU2QguGLXCvyU218Epg88bvzrZ+Nc+WJpoW+rTwevzV4NDzu1vHME/pyrCTJdqFbg6qDirsltFEWI8V5hFsZu7VwbRoFSz+/JOm/81xZPFwXfWIynINmKE8Mk0rxbziTb0DeUtWb4Zi4wQ84DkEBKq8GndHcdX/b9v6VqQMoj173FHrOgJfhR+NJXCdHLgrdRrQWIrcvT4ur5mj80NMhIJ44+uR0vIU6pLq4u3YGcrKRcCWagOnn83wJjZ/UoK4fUcOqBbPtcrrXAy/579jYcXIug7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHon6np5VUGxbuHgzDAIdOIFJaL5U/T3+vxkp9X7oZs=;
 b=j0OTAR9mx/AaYCPZkK3xV7B69P5V6RCJiyquJJIO4REvTxYkaTEx6ym/vD9Y0/IUoBMhkvb3Myi2GWrO56BEdZzzwDYOOhWmQDv7FCy2M2cm4BUW7hcJgEoQwYhOGTN+TTOa8x5Yt+tmvy3UxNmG5XnUsL3Q/fFfT2vBQvndasTNXIOgNgH2rg+LWQGxiQOMABIGGVoSgnzTso6DGmYUBxwUhtW9U9GTGEa4MI7fymHUmhpIFEA9z+eVSynfm3eWhKRbIixxcVfAXA7a371kTWAzPT3LKpA5ArAdqgt0OHm187CYXrIj65U5HeAu2h7c++7xhkIHtCG14nhQC3b8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHon6np5VUGxbuHgzDAIdOIFJaL5U/T3+vxkp9X7oZs=;
 b=U1GKMB+WO5PyQOn+zvcD7Df+gd1VGnkcaQPphSYAUQbp6gxLcjUS1pieHny81n+ZfAQkh1nRTpZocsqi1EPQtBr4b0OSnnx/0+it40FxUer4kY6jIRVdb34f/TSUt5CrMG3oguyqWQmMp7dL2mE+Q7Y5+FnhkIpKvtkIR5v1dxE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH2PR11MB4437.namprd11.prod.outlook.com (2603:10b6:610:47::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Thu, 1 Sep
 2022 09:56:48 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%10]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 09:56:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: add led configuration
Thread-Topic: [PATCH] ARM: dts: lan966x: add led configuration
Thread-Index: AQHYvekmpJDdz/WGHkyu1zVOjUYB+w==
Date:   Thu, 1 Sep 2022 09:56:47 +0000
Message-ID: <53130a5f-653a-1814-c7e0-d455865fc4c3@microchip.com>
References: <20220831194430.53108-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220831194430.53108-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6762c5b9-1b62-4ba7-7f7e-08da8c0048cf
x-ms-traffictypediagnostic: CH2PR11MB4437:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzEekg9k4H9ufPMtIZLyA3YabhkVuHRyYJCmkMrBaOReYUimDThDNZA1ASPxiPqCGsJEj0isZgJSiJKepRVvYbmfUvlswmcgAVwxdWSKrOZ33Df4SFWE6gmxRdW09cV4myz2b9UxptkNUy8Qt95A1J6psh5OqJ8Q1FDTCRoRhsxAqTuyZnGl15x3F1XqAcutqpjuTJLiWKOaq+Fl1mHXMcgaiZ8JgVUjoNEAaZdsC8SHuvDnEfZclTapCMDcMrEIySvjwTxvacQ6nMtb/ibTFHLiZzHwxrA+PrDDHPr/t388/5JD7GLd5nZi41mFYCBwZyADqv5gE62PswDrnRB51eTRlkT1R4HvDo+Gw0N7HJn0etcmdnIrV2CuIuLlmzkeLPTOA1M3ZnJaA+rpE90jtAO16lsV/nC4/tnY++N/xUAVEtzzRdzYduFVc3RQXsLm7iU+JFzwZPVasd5qq5gFXSV56zmuY6rVjW9/dZd4djv27ycA8NcM9LwBLsAwc/DN6NMf7rMBWI9jn5/6bh1pyd6ccwj0Pbw78H+IMV4YifrwOe7GnhLs8FcE9MmsivqivaVxxd6behA4RCVFAZCRROSNST4u6LXSV12lb44MjIH+QKAKZn8M2R1p/L1ujNTaXBAF7zanwgwRDMP2vcVWnxRKuLC/qS+a8hK1Cda0gxN7V/JGlgyqrx+vgRj7JwUHQb9KHRU5EHH0RmDKl8PJLh+9RaqLuiPDHM0Bce09lf/+tdzpxIl4hzyugncqvTlaJ63FrcP5vxv3JmFCuQ2Bk685VsRkrkVroPL3BIgg/KtlTSvkUON7EsAm1rQbnfglZDteicih51lDkIW4bp+2Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(376002)(346002)(366004)(2616005)(186003)(4326008)(38070700005)(110136005)(6512007)(66556008)(66476007)(66946007)(8676002)(64756008)(6506007)(91956017)(6486002)(107886003)(41300700001)(76116006)(71200400001)(53546011)(86362001)(31696002)(316002)(66446008)(54906003)(26005)(2906002)(38100700002)(31686004)(122000001)(478600001)(36756003)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RURIYkJhU0VqV2hvekRKV2tOdlRuQjFEOWljTUZjZFZhMEpqVVg3R0hQMGRS?=
 =?utf-8?B?MTY2OWY0MVhsUms0M0txN2R2ZysvdVdZNTM5M1FxY3l6WWtmUENDNlV0Snhy?=
 =?utf-8?B?dmU0VTNSZEhJWmNXeTI0VGRjekE4VG5wSHA5RzU0Q3hRc09IdnlvcHUwYkph?=
 =?utf-8?B?R3R1dHF2Q1lyb3VYKzlJemcrUTl3KzZsYVBwNDA5RzNWWEwyZUlmQTJPWUVL?=
 =?utf-8?B?b091aHVTM215UElsQ2g0YW92ZmNlcEJFbTNVU2lNODF3eHdEVFJWUytvMHRy?=
 =?utf-8?B?YlFHT3lmUlRkM2VWeXRONlFTQmJha2Q3VXJJQkhXR0QrMlJ3elJ5RmR5MUtO?=
 =?utf-8?B?RDRvOG4reWRmQWUvR3daTGhJVG03bFJudDNpRGc2UGhmY3BBQk1sOGxoaEx5?=
 =?utf-8?B?NGRvUnpIeWFScnFJQm1TSkdUZEdFVVQ0NktnWC9ZZEZwd3FSYnoxNHozNmVn?=
 =?utf-8?B?aXJXS2FzbGxDZDFzd0UxeXdmc2hjRmloSjdLRWU0M0J2aUhMVy94SENjN2x1?=
 =?utf-8?B?dDhCRHNCS0Y0Nmc5SUpQTXkvN2hFVmE3YWJOTXR6OUJqZDFUdDRsQSt4ZmI5?=
 =?utf-8?B?ZkV0NUlsOHp1bkpySUxIMlhCYmRYUS85MVBMb3F4b3BGUHZrV2owNjk1NmZh?=
 =?utf-8?B?MnFCNXU1ZkpaYytCbytPem1aZ3NqTHcwZkx5WjgvQmVpdXVIL25uSnF2OGk5?=
 =?utf-8?B?d0cxY0ZCcE9lZlpIaXc2NjJ5K250ejBuK0RiZHNRREV6cFlaWWU3aDhXTzV3?=
 =?utf-8?B?eWFjUUJ6bnRXcHlSdnVjaDN3bHFiOHZGMWZ6SVh1MDlGY2JoUElicHA5TEJk?=
 =?utf-8?B?TlpubEJkNDQrR1ZKVjFScnhMWGNLZXNSSUZCZTBteWdUSnM5NTZvS3dnTXNZ?=
 =?utf-8?B?SFU1NWNicHpqcTIzVWljWlBmSDBXdjBqRk5JQW9aYUJuOHFzTVdRVWFBcE92?=
 =?utf-8?B?QnFTOHM4WUx6b2c4djI1UE5HQW1ZeklROExKa1dpcjMwdlF3em1RWWthc0Vo?=
 =?utf-8?B?aklqS0VoT1h4SUVVNVlyRzhzWnQ0Yk10U1Y3N2hVUkgyajVxcWZHeDZwUlNL?=
 =?utf-8?B?Z0pSS2oxbHc2Vmw1QUp3WmhZclFqV1ZhQ2V4VUJzQjFyc3VDRVJNbXdHbkRC?=
 =?utf-8?B?YitHaGlmV0d6WGg5bGFpaEo3N2lkMCs4OHIxSGt3MmltY285QkZ3RElwaXNn?=
 =?utf-8?B?SUtaZncwd3QxZFNSWnVlQzBldVFEZFdYUENmSFlrb1dOL2c3RXVtbVpQUzE5?=
 =?utf-8?B?YWtMY3RGV0JzYUZWSjNrdU9sUUc5S2ZUTXNRSlBNL1FGNitoNVRhYW1oNGY4?=
 =?utf-8?B?a3lIazlKd0VWUFFtd05nL2lqZWNKVG9abHdhQzdlU3hwa3hSYmF5Q0o4YVN1?=
 =?utf-8?B?NWV3QzJwV2FUSHdOWjlWZ3VqUzZLaE9KR2tHZ2swNVBVZmRWclBEQXJ6eURp?=
 =?utf-8?B?WDZITm9NWE5kT21CYW5xNHZidU9halcyZGtnL0RVZHVvcGhmMjhRZ3pock9p?=
 =?utf-8?B?ZTBtamFVc2cvcUVLbElYOFlYUDB4dTduRmRBbHd0M2V6eUNFUDN3R1Q0UWNM?=
 =?utf-8?B?OXp0d0swWEVwRy81R0JBZEdnWGN2anZ4VUpoSnJLaHc2cTkrM3hUckYxWmxN?=
 =?utf-8?B?bVRLVzFKdEg1WVNjR1V6c0FvSFIrYzNNNURxOUxQcmRtQXREYjJQY3doRW1x?=
 =?utf-8?B?VjhiYzdaY0padnRGc2ppZXhCdzVLZENERlNUejU0YWdBMGNaYTQwZTEvcGVu?=
 =?utf-8?B?aE1KSTNKOW5YWTllMlByV29VRWgxZjFqQjJGaXcwMU43bmdwZTBaYm9CQ1VC?=
 =?utf-8?B?QXdrVlZYOTBVZWZ2a1VzTW00RTcvRHpGK0ZPSk5mNlk5RUNwL0dNSnNsMkht?=
 =?utf-8?B?VTE3V1Q1ZS93S21kZjI3TFpzNzQ2bHhobVhMVkVscWV4MXVRb0N6TGI1YURS?=
 =?utf-8?B?bEVqWDdlR1ZPTzNLSURBQ0huRDZ3Q296bUdjWUhhYStQSVJQTUFEQWNsRGdz?=
 =?utf-8?B?Z2wraUs3QnAwMFpVWEZLR3NOcVVpZWE2eGVFQ0JNNXdFMU9Wa08wMDRSYkpG?=
 =?utf-8?B?STExU2o0OE1FSHBFK0hEYTE1akZicW5wWm1Lcy9HRFFCY2xHSmdHV1pTeEJ0?=
 =?utf-8?B?N2F4eEZ1SXpvQ1k5SVh1L2ZHcFp6Vit2dTF6VmZEeWZoSTRkZUNNQ3U1NVdJ?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61C00584E61F064C8E3540E3FF77CDF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6762c5b9-1b62-4ba7-7f7e-08da8c0048cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 09:56:47.5637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gw01MyGdIGARCgpA19Eyz1DgArG46LFBUknyXRcXVv7QdQ64zAAZVTBrFW7HaBrY3PoiAsdpI5Y+/AkeHMceuHE4PdiUUT9tbZxufvpfI9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4437
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDguMjAyMiAyMjo0NCwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFkZCBsZWQgY29u
ZmlndXJhdGlvbiBmb3IgcGNiODI5MSBhbmQgcGNiODMwOS4gQm90aCBwY2JzIGhhdmUgNCBsZWRz
IHdoaWNoDQo+IGFyZSBjb25uZWN0ZWQgdG8gdGhlIHNncGlvIGNvbnRyb2xsZXIuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBIb3JhdGl1IFZ1bHR1ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlwLmNv
bT4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzIHwgMjkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4
LXBjYjgzMDkuZHRzIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1w
Y2I4MjkxLmR0cw0KPiBpbmRleCAyNGQ5MDU1YzRhMDguLjY0OWNmZTY5ZDk4ZCAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0cw0KPiArKysgYi9hcmNo
L2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzDQo+IEBAIC0yMyw2ICsyMywzNSBAQCBn
cGlvLXJlc3RhcnQgew0KPiAgCQlncGlvcyA9IDwmZ3BpbyA1NiBHUElPX0FDVElWRV9MT1c+Ow0K
PiAgCQlwcmlvcml0eSA9IDwyMDA+Ow0KPiAgCX07DQo+ICsNCj4gKwlsZWRzIHsNCj4gKwkJY29t
cGF0aWJsZSA9ICJncGlvLWxlZHMiOw0KPiArCQlzdGF0dXMgPSAib2theSI7DQoNClRoZXJlIGlz
IG5vIG5lZWQgZm9yIHN0YXR1cyBoZXJlLiBEZWZhdWx0IGlzIG9rYXkuDQoNCj4gKw0KPiArCQls
ZWQtczAtYmx1ZSB7DQo+ICsJCQlsYWJlbCA9ICJzMDpibHVlIjsNCj4gKwkJCWdwaW9zID0gPCZz
Z3Bpb19vdXQgMiAwIEdQSU9fQUNUSVZFX0xPVz47DQo+ICsJCQlkZWZhdWx0LXN0YXRlID0gIm9m
ZiI7DQo+ICsJCX07DQo+ICsNCj4gKwkJbGVkLXMwLWdyZWVuIHsNCj4gKwkJCWxhYmVsID0gInMw
OmdyZWVuIjsNCj4gKwkJCWdwaW9zID0gPCZzZ3Bpb19vdXQgMiAxIEdQSU9fQUNUSVZFX0xPVz47
DQo+ICsJCQlkZWZhdWx0LXN0YXRlID0gIm9mZiI7DQo+ICsJCX07DQo+ICsNCj4gKwkJbGVkLXMx
LWJsdWUgew0KPiArCQkJbGFiZWwgPSAiczE6Ymx1ZSI7DQo+ICsJCQlncGlvcyA9IDwmc2dwaW9f
b3V0IDMgMCBHUElPX0FDVElWRV9MT1c+Ow0KPiArCQkJZGVmYXVsdC1zdGF0ZSA9ICJvZmYiOw0K
PiArCQl9Ow0KPiArDQo+ICsJCWxlZC1zMS1ncmVlbiB7DQo+ICsJCQlsYWJlbCA9ICJzMTpncmVl
biI7DQo+ICsJCQlncGlvcyA9IDwmc2dwaW9fb3V0IDMgMSBHUElPX0FDVElWRV9MT1c+Ow0KPiAr
CQkJZGVmYXVsdC1zdGF0ZSA9ICJvZmYiOw0KPiArCQl9Ow0KPiArCX07DQo+ICB9Ow0KPiAgDQo+
ICAmZ3BpbyB7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgz
MDkuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MzA5LmR0cw0KPiBpbmRleCAw
NWNlMjdlZDU2NDguLjRmMzA5NzViNGExMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC1wY2I4MzA5LmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4
LXBjYjgzMDkuZHRzDQo+IEBAIC00Miw2ICs0MiwzNSBAQCBpMmMxMDM6IGkyYy1zZnBAMiB7DQo+
ICAJCX07DQo+ICAJfTsNCj4gIA0KPiArCWxlZHMgew0KPiArCQljb21wYXRpYmxlID0gImdwaW8t
bGVkcyI7DQo+ICsJCXN0YXR1cyA9ICJva2F5IjsNCg0KRGl0dG8NCg0KPiArDQo+ICsJCWxlZC1z
MC1ncmVlbiB7DQo+ICsJCQlsYWJlbCA9ICJzMDpncmVlbiI7DQo+ICsJCQlncGlvcyA9IDwmc2dw
aW9fb3V0IDIgMCBHUElPX0FDVElWRV9MT1c+Ow0KPiArCQkJZGVmYXVsdC1zdGF0ZSA9ICJvZmYi
Ow0KPiArCQl9Ow0KPiArDQo+ICsJCWxlZC1zMC1yZWQgew0KPiArCQkJbGFiZWwgPSAiczA6cmVk
IjsNCj4gKwkJCWdwaW9zID0gPCZzZ3Bpb19vdXQgMiAxIEdQSU9fQUNUSVZFX0xPVz47DQo+ICsJ
CQlkZWZhdWx0LXN0YXRlID0gIm9mZiI7DQo+ICsJCX07DQo+ICsNCj4gKwkJbGVkLXMxLWdyZWVu
IHsNCj4gKwkJCWxhYmVsID0gInMxOmdyZWVuIjsNCj4gKwkJCWdwaW9zID0gPCZzZ3Bpb19vdXQg
MyAwIEdQSU9fQUNUSVZFX0xPVz47DQo+ICsJCQlkZWZhdWx0LXN0YXRlID0gIm9mZiI7DQo+ICsJ
CX07DQo+ICsNCj4gKwkJbGVkLXMxLXJlZCB7DQo+ICsJCQlsYWJlbCA9ICJzMTpyZWQiOw0KPiAr
CQkJZ3Bpb3MgPSA8JnNncGlvX291dCAzIDEgR1BJT19BQ1RJVkVfTE9XPjsNCj4gKwkJCWRlZmF1
bHQtc3RhdGUgPSAib2ZmIjsNCj4gKwkJfTsNCj4gKwl9Ow0KPiArDQo+ICAJbXV4OiBtdXgtY29u
dHJvbGxlciB7DQo+ICAJCWNvbXBhdGlibGUgPSAiZ3Bpby1tdXgiOw0KPiAgCQkjbXV4LWNvbnRy
b2wtY2VsbHMgPSA8MD47DQoNCg==
