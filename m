Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA634593F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbiHOVI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344596AbiHOVDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:03:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A63D3EC9;
        Mon, 15 Aug 2022 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660590882; x=1692126882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SSPciaYSkCEE9I/C5ilQUfsAEGUTm0g5M7dRXUTbs3w=;
  b=T8MpOezAdYNs+64bEAhVZNIUMYkZSrV4hEKNjCAoLVEHUtXORkT4ij2n
   9gUtYDw2kjg5+95YLzK3xMD/cmCaNFeiP6ajKMf6dyv6wCMO3c2pgqwzP
   LDyiNKMkLUinUReXtp+DskGhrND3LTEtgEiiPdyd+kHDJNBI0oyLCZ7z+
   X2wfS/aoo9fN2oCAGy1WoG5l2VZwtyqsb2FjP/L9IQcgYanbHSOflvDMv
   bqlbstE2buPsy5nIEop3Kc3f56MI2XHagHfYDjQPgS2FmP2PpgN5XJlAX
   jl5A/bAHHwmUQXQmZy/120sAW457poXvmhnWx+5oJHxButwWQBIymfZCG
   g==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="169373542"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 12:14:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 12:14:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 15 Aug 2022 12:14:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1jY6+ySySAZ0d/15aHKBJvtzykBAd1k0aj0teZg7FbgcOL2UkmeGTrQTjoUNkQj503PFF6yA+C4nJCexvrQ6tn8gBX8GrYHVz35EBVkuRg0YSg/JGxX0/FISQVrVWZdqVCS4YL9MADg1CwoPAgd1VhkJaH9yWgKuZXMk+yNfad9NQdeC7Yzh8u22vFKGyxL4LzTMqe78IGABm6wl31d5Hfj2SCGq7ZkJ3jcsjzuo6fusaUk4Ux5Q3n7KxlA+Rke02ZfHHKTiyGEXCRUqfR8mm49AnHiskNorznZLOrUUvljIHoDtvcXIlZ2l5xUDAmoZ1SXmzi/Bhc3TKKGMDea0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSPciaYSkCEE9I/C5ilQUfsAEGUTm0g5M7dRXUTbs3w=;
 b=M3pkHSzyLhzisFhbag/+6BmR145FCTWHNrkqyFLkHDmUcBurtahIT0lMtL0Hbr6r4DlVUQ2YdexRkPpcaAtVwX2H8WDkuO7SE6ja0K6ev88FUzoqVcMFeaqPpQJs0DKNXHDJD5mybRfaxZsQM/vgcXhUnuHHBJpqjL7jusrgoY7LtknclZqJlhjkJ3n/alytSfdMppNPo2KKhHS1qkR1kYsw5l+5NhRGzJaDTW/3somwIkXeblWebQfAPrT659KOo6BDNO1IzVB3uiNR4TWPw4XXs4Ezkm4/nPbciUgTehWaImAT3oT+RMntmw9snJrhRRgvCKeisNGSW64XEImsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSPciaYSkCEE9I/C5ilQUfsAEGUTm0g5M7dRXUTbs3w=;
 b=KAWObnUXgU1Uqr1DEUBPQewuu8T4Allk6unQKmPFuNAY4n1ewg5eHV3EG3OSI3kqv5QKhJvWJEf8l/ZtfxyVso9TZ5c54jsO9D1OoidOjKAs5G13WRnULD8+v3F3sIxVpK6Am30K3AcVhktWhz/Vk2rJJ9hLawHWtv4oUN0K0Mw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5232.namprd11.prod.outlook.com (2603:10b6:5:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 19:14:37 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 19:14:37 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert+renesas@glider.be>
CC:     <anup@brainfault.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prabhakar.csengg@gmail.com>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: soc: renesas: renesas.yaml: Document
 Renesas RZ/Five SoC
Thread-Topic: [PATCH v2 3/8] dt-bindings: soc: renesas: renesas.yaml: Document
 Renesas RZ/Five SoC
Thread-Index: AQHYsLn3v99KeFhKkECk1bkoK2HiZq2wVRAA
Date:   Mon, 15 Aug 2022 19:14:37 +0000
Message-ID: <57e17d1e-e809-065e-831f-cdd3a8602e0a@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0618ab99-d380-4427-e409-08da7ef2654c
x-ms-traffictypediagnostic: DM4PR11MB5232:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EmFQ/0L+nRAtATNfpBsObmxCtSgQhy0/Mt2nawpWPkmOSVc5XvUtuhewNEPceSjM41xUmoj3IWCnYBEx/n0BrJJ4fV21Bn4Jla78KJoPkMzNaduVtEWx92dWQko3KPx2rmFIj32TvpAdO75ElfRKZA4t2+jBRqets0T4gy6dBAElO21j+OJFWv7ONCmykf8x925I6C09Tpg7rr4Phykn/obzog0WJh1t/A95erMDuZwiq6vCZ7HVkWrkmYUryBdok6+4gxZsCqtzjmKSZ/eAhYs8kIy30Bx16DaSbPyBNvLG5imD29cehTbVAqrLKaFG/qsa2NRfE1UfnLc8OUE51Sl2fh4ZQ+Uu6DimVAf5OpEdSKTz3tbQxlMZo0Kbkfoloc6eFqIqW78V0ZpsCF+nZa8ppdsjI6m87e6F9iS3HV+tEmEiqUqz+lJMVOmJLXuNu+IL99aEIfdjF3bXqsKk/1z+rdJAmXCrPNP5dacYh1khF92VQrXomZg0FdQPBlTQOK1OWnaQeZIjHJpzDGDyXe6siMSHi3hihmjwtP+sb+ILpJPt4Kg/gSREYv91ldSjMyp+GPJijZG39PZcpq9oKvkciFo2/4cwHRs7XPym7DR6xaXToTSc/drLs/BtAejZ69UvngDlF5Y7SxE5OITfg8ZtJpi70ICmeG2S0zksZjzvLNr3SrJNDwKvSigAUDlUKemWr7prYmh3tg69AlrcLZ4klhVnKXri2O/WwFvLjRqoZ6BqtBAJ38Y392PtJlvPcFN9UTWIfIwmGD1gZ3RmqD7hDvfm00CA0N/6iREvWMY4q56mW4R+NoHvJQXvGIctL8ZDPxCScJ8naJP60mm8oBgu8m6tfMd/Fd3l5bA+LXipAF+ha4q9r1vFRj9qajwikDqzl4u5oKhYNfUU/Jmhew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(39860400002)(376002)(366004)(64756008)(54906003)(2906002)(41300700001)(76116006)(316002)(8676002)(66476007)(4326008)(36756003)(66946007)(2616005)(83380400001)(31686004)(110136005)(186003)(66556008)(122000001)(38100700002)(26005)(66446008)(6506007)(6512007)(7416002)(31696002)(38070700005)(8936002)(71200400001)(966005)(91956017)(6486002)(86362001)(53546011)(478600001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjZuOFE4U0Vvb1U1dXNLYU0vc1lWaXV1RHh4NFlBcVovWExDOGVPL2JtMC9B?=
 =?utf-8?B?YytwdlhKTDJtVjl4VkIvaG1uSERPWDJQd212ZUF3OWU4bjBCWVZsWmN1RVU3?=
 =?utf-8?B?YXUvdXJsRll4MHlEeHozanBsQ2pNTUJDUFhPclVTUWNJb3dxSHVmQ2NIaCt5?=
 =?utf-8?B?RTUzZVNoMGFROTE1NGFvbjNHek1yeXBvVnpWV09wZ21oMEFxdkN4RlVBZGtJ?=
 =?utf-8?B?TGpRSVNna0k3eEJrV3ZINXU1czRaTUovc0lpaGdTYjdUbnVtd1NvaC94d2g0?=
 =?utf-8?B?UkxCME40NFlTTGRsL2o5dVFrM2V6QzNZa2RKV3hPWExOOGFJekNJY0lCWWtr?=
 =?utf-8?B?OVNqOTE5QmMzdDZnWTJpVDN3ODZGRERjRFo3b2FLTE9YdVZyZ1FNRC9vNFdu?=
 =?utf-8?B?cXZTb0lHQ1k4RnBtai81R1d0MzhLWW02TW9hZVQvTlJObW83ZVR0eEc2b1Bi?=
 =?utf-8?B?bUZkR3BxSTdJSlZhbnZmdWw0Mzl0YzNWZFBaSk52TGxyUEMvM3ViUUF1anhU?=
 =?utf-8?B?WUJKOUxjT0IyTmpmVlh4OEYrclhpRnY1SDRzYWtGOExsNk1CUVVPQ1puZXNO?=
 =?utf-8?B?eWQ4M1czS2g4VUdpd0t1cTdIOUc1SnV0NkVBYWRLSjh6QzY3Q3E4VFRFYXBX?=
 =?utf-8?B?RElwZTF2bkp0T0tsSUJYYVp4emt2eWFSV1RyYlFRVFF6VWJ4QW5Qb0hxK3VP?=
 =?utf-8?B?LzZVOWFVVlRxMmR3UTZnaDBxN0xFTGdKcGtraHZrdUVGS21uRnE1NFQ0QkJn?=
 =?utf-8?B?TEJoejdCWDF4WHNGN1c0RE9Nd3ZZVXlab2VreXM4QU9DQjMxQVQzcXMwYzhU?=
 =?utf-8?B?MFhlTHpwaVlMZ0FHdmxsbTFuRXYyL1pPb01TNldiOGJEdmN2ZTk1UEgxQ0FE?=
 =?utf-8?B?d1V3b2hvaEk2VFIybkJSN1daTEJqT1R2c0VPNmhobnJoNXRvRVEyNEpjNlRF?=
 =?utf-8?B?QTUvbVJoemJGWnY5Mm1jRUJtd2hFWkxtZ2NTa29pQVNZTVpmdUpQNktwaHpi?=
 =?utf-8?B?S0lNcU9BNmlCS2pwVDB6NjQ0V00zNFJHTlJaRlBkSkg4WjFmeGxpQzBuZFE3?=
 =?utf-8?B?a1UvYVNxaTExMUlJZmZ5Nk9iamE4OTJOWFFtM2NIOVhZT2JpYXNyQ0tidEc3?=
 =?utf-8?B?VEhKdEtVN2wwdVdqWFpNcVAwUExVY3JvWUNJZ25XRGhpdEFBS2ZEa2lwZjdI?=
 =?utf-8?B?bG1wZGQwUWFXSS9CR09Cd00yYi9mVC85SFhSaDF1VzRmWmlPMlZDcW9ueEJk?=
 =?utf-8?B?Yk5nVGNLMitNYTFDaFNSenNVa21ZWlorTndGQlZHU200b3Z6M2RMT0Y1RlJ6?=
 =?utf-8?B?VnY1WTI1UXNwUXdCYjAwUGlaOEpiR3BJeDJWMzJYUEIrSkxqcHh6RmZIczFz?=
 =?utf-8?B?Z1I5ZWNsQWM5c3pZeVhqY3pESzNJZWtVdHlOVnNGeFFBS3RxQkZGbmZqUnpQ?=
 =?utf-8?B?ZldaOTlYQ1czR08wM3MzaHNpa21ZZTZENmFuMEtTZTBvSTVqOEhMYXl5RU9y?=
 =?utf-8?B?ZzRHU0pEWlU1K2J1bXBKNjdJcFFYdjUvS1RBUkQrS0ZaRVAvcDQvUERzcFgx?=
 =?utf-8?B?N21KNjhTNGxUZWhlL3NlV2FxbkhKNFF5bWQvTTA3ZmplTHhTUktZYXczS3Nv?=
 =?utf-8?B?WTQzZStUVTY1UWNQcWVCN1Y5QkRhcFFZZmxlYlRuQ3dDRmNKYmVZbGNpSlM1?=
 =?utf-8?B?RkFhWm1kdEY3ZUJ2ak9vUUN2dm1Cci8wRkRWb1RTUndHU0xSYW00UU5jT2VM?=
 =?utf-8?B?VW9UaFp5cnVmeVVpTUl6cG1ZS3NGNzd5MHUyVzltaU1mWVlGN2dyU3BnYWcv?=
 =?utf-8?B?L1BmS0srM1kzN09mQ0pDV1Nmdjc4aUFHS29lZm1ycHRYZjQwVlRaaTNVMzc5?=
 =?utf-8?B?cnBaOFBBdnA1UVJUUTZidVJGMXdjeVR5NEduQ0tCZlhHZ1VmL1B0QjliQ1hL?=
 =?utf-8?B?dmRLWGJCai83NTJiWk5vZjdnMGtrRlZsQkZOaDlUQzBnUHFEMHlDM3Azc1Rm?=
 =?utf-8?B?YVJFTWpCYU9STGFFWU5wNTRvL1dwNWxlN3VHaTlqYUVRcHlUYS9CWk1RVFph?=
 =?utf-8?B?S1IvRzIzUmptUVBzMjFYMnRBZ1lwS0ZmQTFQZU9hSm1TaDhZMkU2S2VkRUJ4?=
 =?utf-8?Q?cAsUEwYZmUaJ1558tP/OAvx0a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB9A15512056D74E9572B1A8140E9010@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0618ab99-d380-4427-e409-08da7ef2654c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 19:14:37.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9lbPpkCmgxD+XcUeGqYG2ow/krP5bx2RU87OJsPpFRh9pApBsTfyz9lqLvB+lJ/M8yRNIbShpY7Ur2cXLWi/GGVg0JYO0aB5X4uJB9tWbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5232
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDgvMjAyMiAxNjoxNCwgTGFkIFByYWJoYWthciB3cm90ZToNCj4gZHQtYmluZGluZ3M6
IHNvYzogcmVuZXNhczogcmVuZXNhcy55YW1sOiBEb2N1bWVudCBSZW5lc2FzIFJaL0ZpdmUgU29D
IA0KDQpIZXkgTGFkLA0KDQpNYXliZSBJIGFtIG1pc3Npbmcgc29tZXRoaW5nIG9uIHRoZSBhcm0g
c2lkZSwgYnV0ICJzb2MiPw0KV2FzIHRoZSBpbnRlbnQgdG8gbW92ZSB0aGlzIHRvIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MNCmJ1dCB5b3UgbW92ZWQgaXQgYmFjayB0byBh
cm0gYnkgYWNjaWRlbnQ/DQoNClRoYW5rcywNCkNvbm9yLg0KDQoNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEb2N1bWVudCBSZW5lc2FzIFJaL0ZpdmUgKFI5QTA3
RzA0MykgU29DLg0KPiANCj4gTW9yZSBpbmZvIGFib3V0IFJaL0ZpdmUgU29DOg0KPiBodHRwczov
L3d3dy5yZW5lc2FzLmNvbS91cy9lbi9wcm9kdWN0cy9taWNyb2NvbnRyb2xsZXJzLW1pY3JvcHJv
Y2Vzc29ycy9yei1tcHVzL3J6Zml2ZS1yaXNjLXYtZ2VuZXJhbC1wdXJwb3NlLW1pY3JvcHJvY2Vz
c29ycy1yaXNjLXYtY3B1LWNvcmUtYW5kZXMtYXg0NW1wLXNpbmdsZS0xMC1naHotMmNoLWdpZ2Fi
aXQtZXRoZXJuZXQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXIgPHByYWJoYWth
ci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gLS0tDQo+IHYxLT52Mg0KPiAqIE5l
dyBwYXRjaA0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
cmVuZXNhcy55YW1sIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL3JlbmVzYXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vcmVuZXNhcy55YW1sDQo+IGluZGV4IGZmODAxNTJmMDkyZi4uMjMzODQ3ZWIy
M2ZkIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L3JlbmVzYXMueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL3JlbmVzYXMueWFtbA0KPiBAQCAtNDE1LDExICs0MTUsMTIgQEAgcHJvcGVydGllczoNCj4g
ICAgICAgICAgICAgICAgLSByZW5lc2FzLHJ6bjFkNDAwLWRiICMgUlpOMUQtREIgKFJaL04xRCBE
ZW1vIEJvYXJkIGZvciB0aGUgUlovTjFEIDQwMCBwaW5zIHBhY2thZ2UpDQo+ICAgICAgICAgICAg
LSBjb25zdDogcmVuZXNhcyxyOWEwNmcwMzINCj4gDQo+IC0gICAgICAtIGRlc2NyaXB0aW9uOiBS
Wi9HMlVMIChSOUEwN0cwNDMpDQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBSWi9GaXZlIGFuZCBS
Wi9HMlVMIChSOUEwN0cwNDMpDQo+ICAgICAgICAgIGl0ZW1zOg0KPiAgICAgICAgICAgIC0gZW51
bToNCj4gICAgICAgICAgICAgICAgLSByZW5lc2FzLHNtYXJjLWV2ayAjIFNNQVJDIEVWSw0KPiAg
ICAgICAgICAgIC0gZW51bToNCj4gKyAgICAgICAgICAgICAgLSByZW5lc2FzLHI5YTA3ZzA0M2Yw
MSAjIFJaL0ZpdmUgKFJJU0MtViBjb3JlKQ0KPiAgICAgICAgICAgICAgICAtIHJlbmVzYXMscjlh
MDdnMDQzdTExICMgUlovRzJVTCBUeXBlLTENCj4gICAgICAgICAgICAgICAgLSByZW5lc2FzLHI5
YTA3ZzA0M3UxMiAjIFJaL0cyVUwgVHlwZS0yDQo+ICAgICAgICAgICAgLSBjb25zdDogcmVuZXNh
cyxyOWEwN2cwNDMNCj4gLS0NCj4gMi4yNS4xDQo+IA0KDQo=
