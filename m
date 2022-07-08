Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA61B56BDF7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbiGHPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiGHPPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:15:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6842F38C;
        Fri,  8 Jul 2022 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657293354; x=1688829354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/GMoWQPwPrY9V5kshwpjpTSp84e3NgrNP/bQkZYj7ms=;
  b=quuE3Ss4kOBpXO7MvqNkdigaGetNOHCH5wGOHSFtUJpy3r6m1xC9bqj9
   7J3oHD6ZOLZtsgaKDQsySBpv7JUB4NgGil+Gpma0KRw6c8lmvEczH4aIg
   CWUEgkPDi5HQSHAWQH4OKddwg/T+JrD6/afI7op5PZlw0mMVePUovWBre
   H5X84l0jR7NtSKnmpV3H2Icyw75063MKUXSpJNmQiJR56a8CgxFrqFr8g
   OArG8hGrIqACyt4fQ+A2WcDM6Xf6eZqzgv/bsLy9D25DeXegDeIyviUea
   TiKZHO8syXcoqJcGdZMcE0mITMzNuFV6573ItzEvUC9z3TAyv7gQbTuBH
   g==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="163942839"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 08:15:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 08:15:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 8 Jul 2022 08:15:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGxYetBMXnBboExZwuRKcSX7XjgRYIDRS+R/Yf6h84QEEMdbeB7ShQYy/M4YWxBGBrycmRw86wmszCeBwMN3P5JMV//Wf2FqvJIHRTyuxXrZYHQk49k4E5IBPabLDfGXw1XqdWV8zfG+7zfLtW/KGlfDAuDAux/bgQdqRAjNojpindX7kyK4/UCSOUWOWJ3N2fp5Qd0vNbkF8JWeeJdO9jTFQ35Yvnnh0qxGQmm1+OsdnvEl0AvTsKqGej32hBp+XgEN47I62ml6uk/xkP+Y8dLfxbA2hwe5GHjI31Sr8wg+fUZrz+2voRk9MB+jiUO++e28RSq+ca6YMtSfgkaTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GMoWQPwPrY9V5kshwpjpTSp84e3NgrNP/bQkZYj7ms=;
 b=Se2xYLasRZU7hgYjuX+egnxtQp7AQXanUUhwSbiHlRJlMYV3RsD1JkY0e68NyrK10y7Wzhk2P5pkbZH/ZsV09o0dtoC9JGtqoOWZibX89Xs8I7iMMswjtO3cTwCbnaFISwQd69xw3loe0FUxmKoE5zy+TQZOwBXyX9v5+jib3EqJg+miJKX2wG78UyfSusLWSEVSEMJ2KhhhNDFqHlb3JzJlPhvrL6qvIb+rEQjCbgFgJ9LAEmJDbMBIOUlVbh0wg3otFu48j8BVyzwf5iQJxqpWJKZpuux6Bo29kvj2MTiUesfEbPkWeQAzyx37KGmhy4O5cHjG/eYEE6Q8/bSfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GMoWQPwPrY9V5kshwpjpTSp84e3NgrNP/bQkZYj7ms=;
 b=cGyB836cMi0CP/Pe86ryl85YU+NXKKpyF1QhlBcG2gfebTZUrLXWE/qSdoQE0yNn9261J2RPvVJkLeTmKC3tKWC5cQcfsZOGfb8buy4Ts5Nxn9OVERjHt8Up4q2l+Tt6FWd9PVo+If6AimD6sLTlnbx+ye3rosKKUYEhKqsmpY0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB5357.namprd11.prod.outlook.com (2603:10b6:5:394::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 15:15:47 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 15:15:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: kswitch-d10: use open drain mode for coma-mode
 pins
Thread-Topic: [PATCH] ARM: dts: kswitch-d10: use open drain mode for coma-mode
 pins
Thread-Index: AQHYkt2ZFjwvMdkWPU+KonuzGKSRfQ==
Date:   Fri, 8 Jul 2022 15:15:47 +0000
Message-ID: <8c166a4a-d0a8-b225-fee9-14ad2898ebc6@microchip.com>
References: <20220704150808.1104295-1-michael@walle.cc>
In-Reply-To: <20220704150808.1104295-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a398d47-57a3-4139-0de1-08da60f4bc66
x-ms-traffictypediagnostic: DM4PR11MB5357:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5HdHkKhKnSx1BUm6bsPCvvFEdI6uR3BQ95xCltg3HqE1KVX0dXEjG0Tuudu4z+HrkF+ktzLmMakLfrfWCSR3p97P05RhB6Bi+YZVuY8vhUX4EoMNmcHNr+DCc+XBDap0y8Vri39dx0SZjoxL+7fQXGCWnB0LUhx1JxetFtuaFklSVG72+aFpPPuFvtxNBAgA8J8Stvc9ZBOCGbQ/onWjx2iLfhIxm5k10TtOCRUkEPTXIA7ZV5AwGFrdqBdww/tLaNSOGNfp66TvPu/wIedXc4nWChHukq0FszhNogw3qUmNGi64FUxtTX5jMptNNaZkzvxdwtRAX5DAV64R/+NTLIl2qaowRHqLIAJdhqDp3hFQHOJ+17jWXlg6/IkfKn3QQuTJDQPbscPYtTFk5WCOzy8gKmtxd5u342fNFFfE5sDqTBHl6cT/q4iM5tCVatqbmivHwkxuaeS50WceibcDqgsHFT/Rb3kgw8aFHJokYt6JSNYUMjlVzlNS+6n+l56Jad8R3U1gYU9UfuJaFJ5JqS2JUBOCkrdGIL67TS6VZJsUN28iYs+Q+BwAZU5BY4Sg5qqBhte2rmrj6oY2qcpGjIORSxmlSKNG2/uxSfetbkFKqJKFZ3t1aEaF8MkG7JOxOllMg+pZHGX0amFU8uw/8p9SPCpi0bovJwiNGqsdCRaxnJpxQjFkHtbD3WoIXDOjXy799+Y7akxzQbpkjfQ4jylrL8mPvPw8e/Bw55EKe6VBMTzrbhdb3fbsC6h/J8k9Nin+7CUGTIzqdtG3hyPpe1LeGHv2JsNAPHDobnvUZpwVX8l5KiVwkPZb3b8BVCPuxp4KEtGkOyF66AvsCh3CKcSzd7ssZHJnLFqmOSCin43U8yMNMwsEQvKWnuMVgzT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(396003)(366004)(376002)(6506007)(122000001)(36756003)(316002)(6636002)(31696002)(31686004)(38070700005)(54906003)(2906002)(53546011)(86362001)(110136005)(38100700002)(2616005)(71200400001)(91956017)(6486002)(66556008)(83380400001)(66446008)(41300700001)(66946007)(64756008)(6512007)(26005)(8936002)(186003)(478600001)(5660300002)(4326008)(8676002)(76116006)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjN6cENzS0hQeVFxTGpuTEdPb1V2Sk9PV0NtQzFCOTRIZzFDODVtbFRFVUp3?=
 =?utf-8?B?R29nbC9hcnhDRWZITGtKSmJNbE04ZVRCMXRaSUoxN2pQeXBZSUVrZnBIcXFU?=
 =?utf-8?B?QTNGWjZabEtEZVVNNHBTS2c5WEJmeXR6R0FsZnc1ekFsendUa3JGeG1qRStr?=
 =?utf-8?B?TlREVldRUUVsZSsxT2lNVytSRlhCR3lwVitWaG95RGdpRlVWbW55OCtpVDRk?=
 =?utf-8?B?SGJkWEFQRzNXRmZnWFE0bUJjWXNYRFZjWlRiS09pOHByYmJsREFXdHhDcjBR?=
 =?utf-8?B?L2NsZUJhalB6Uy9xa0dkTUpCMnM2dXRQQXlGRUxRZTBncnhkTWZSQWs3L3E1?=
 =?utf-8?B?YnFlT3BnMzkzOXViVjVxZ2Vmd0p2eGdHeUtWRFZQK0x3WXBZTEM0cUpCYWxV?=
 =?utf-8?B?ZnJ5Mi9POWJRd1hIT2VEMTNRdSt4WHFHdjF5eUxsMGJxS2VRMDVOamdiYU13?=
 =?utf-8?B?MU1VOVlERTFkZ1RWaldnc1JPcW1LZHNSb3c3SGthbE1PeXJ1MC9udC9NbTky?=
 =?utf-8?B?N2I1clhkcTJUU3RjS3gwRlVjMTFiSEdYK3RvakozQmZYbWQyQmdzTTR0Mm5D?=
 =?utf-8?B?OEdyeCtRYmkwLzJJanlkbjcvejdUTXFZbzU3S0YwWjIwN1ZjN0V5eWYzWnBh?=
 =?utf-8?B?endmOHpySXluNjRLVmRvV1d6Y2x5WWw5OVA0YXVCdW8wajJ4NUhER3dhUFh3?=
 =?utf-8?B?MGpjem11SkExak1ISFI1OUhXVjhBWFNPVU1VbDFiVk01QzVpQWM0KzRId2pp?=
 =?utf-8?B?S0lwK3g5WHRSdTVSbDhFbTR2Rlg5NHBmMDJqdmF4RHY0V2VaWElBM21CdSt1?=
 =?utf-8?B?SkcxY3lDRWFQdEF2OFUySWJ1UXp4a01Mai82UWxEOUtnQmpuNlpzZ25MaGRM?=
 =?utf-8?B?MHVsdFVPVWRQcDYzT1N5UWVIRktVWHc3dFdWeVcvYWR1d2J5OTVlVzJiVmh1?=
 =?utf-8?B?bGM1V0Uzc0laOU1ENXZ2SWoxc3NqazZPV1pjR0lxQnRrelVkMmJ2bWVxZk1i?=
 =?utf-8?B?SE0rN2ZJUmZBM2FKV2tpVDJtSll3NjNXczNLTEpBVzRrWmw1VXluWHZvTmd2?=
 =?utf-8?B?RWNsY1YrNFdsV3V6K3JrdStZdUo0bWxaVWJYZVFXU3gvcmJteXF6Z21MaFhH?=
 =?utf-8?B?VnZGeE5ZQ3BkdUFOU2JaNFdvcmdKSCt3VjhZVG1vRnV5L2M5MHlCd0c5Z0tO?=
 =?utf-8?B?ejR0UzNMeVUyLzErUWVNbWdaYkY0djdRTkR2eGk2eUMxNXJnU0ovRGtjRXdm?=
 =?utf-8?B?a1NWajdjaWtvVk40ZHc2UVE0U2V4N1ZKbFdJWitxeFZOZHNKdTBPY05SUExB?=
 =?utf-8?B?blhGckJIU3IyMlUzd2FNMGRONjBvdlhmRzBjS21ZYWFjdXBVWndJZk1DVHRl?=
 =?utf-8?B?ZE5EMWVHR3FEMmJmWHgyMzdFVVI3ejJERlJ4b3R3UXRET1FoYktjZ0EvREdL?=
 =?utf-8?B?NVRrb29YQXlNWmQ0OCtlTSs4dzdPbEpXeS8zTHhHMTFXYmNvZUJheTRRZ1Ba?=
 =?utf-8?B?Tjl6bm9XOFJRUDcvREROVkw4WkNpWHNWN3FSTEhRc1QxbWVNOEw4SFZqVE41?=
 =?utf-8?B?S0d1K1I4UUNuNklvbXdpVVVqeG5ibStLSHRDWE9NYlpteDQ5Z0w4SHMySG1I?=
 =?utf-8?B?bElPTEZkeVZOUThzaVhQQjhtaXhhekpRdnFsRWVSSXBxNDBqa21pNXdzQi9U?=
 =?utf-8?B?Q2JtdSs5TFp4M3loZnBZMWxqNVp0WDI4TmJOQlJlQ2JPMXdIa1BKOFoxbFFm?=
 =?utf-8?B?RG5nc2pQUFhYNTgrbGpPTm9HcXlMSENveFVZaTJEdlZGdnZONjZFdGhRMG9k?=
 =?utf-8?B?c3pVZzJQdHR2U1NVMVhWS2F4aHlUK2F6VVNsUzNtakw5WCtiQ0NGaUVnMWl5?=
 =?utf-8?B?S1E5dUdsaVhUQThWdm8vSzdBMjRmd3BYeXRPa3MwelZtWFNVMU5pMXF0R1ZT?=
 =?utf-8?B?NnRqSHA5U0JsK2paN09GSXFqaGVqeHdNUm5CWjlCek5aOTRBOVM2RCtqbTNZ?=
 =?utf-8?B?MmJuQXlzMExlRjM5YWpDUDVOaFRjWEdURDRDYTczSExUZW52eWxTN3BYM0I0?=
 =?utf-8?B?NHk4S3JSVGZDdnJqMmNSNHVTd1FTTEVDbWxabXJLZVAzeXViMytBd1RIcWp2?=
 =?utf-8?B?bktVdjVLeVI2Z2RHSW11KzFJMGlFNW03UEJNa1Jla0xvaUJQOUFNdElCZUJk?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D87C4C31A196FA43A9FE0AE654FB115D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a398d47-57a3-4139-0de1-08da60f4bc66
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 15:15:47.5281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ca4Focntku4rflq/npbw0YsRDJem/A77xZh8ISVzCpZMshmk9JCkRngaUXFV76uy5BXJTcQe5BhI5oZ8M5yyHfARPEPzxng4LkfTX+vuksw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5357
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDcuMjAyMiAxODowOCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgZHJpdmVyIHVzZSB0aGUgY29tYS1tb2Rl
IHBpbnMgYXMgb3Blbi1kcmFpbi4gRmxhZyB0aGVtIGluIHRoZSBkZXZpY2UNCj4gdHJlZSBhY2Nv
cmRpbmdseS4gVGhpcyBhdm9pZHMgdGhlIGZvbGxvd2luZyBlcnJvcjoNCj4gWyAgIDE0LjExNDE4
MF0gZ3Bpby0yMDA3IChjb21hLW1vZGUpOiBlbmZvcmNlZCBvcGVuIGRyYWluIHBsZWFzZSBmbGFn
IGl0IHByb3Blcmx5IGluIERUL0FDUEkgRFNEVC9ib2FyZCBmaWxlDQo+IA0KPiBGaXhlczogNDZh
OTU1NmQ5NzdlICgiQVJNOiBkdHM6IGtzd2l0Y2gtZDEwOiBlbmFibGUgbmV0d29ya2luZyIpDQo+
IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQoNCkFwcGxp
ZWQgdG8gYXQ5MS1maXhlcywgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMv
bGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC5kdHNpIHwgOCArKysrLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10
LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10
LmR0c2kNCj4gaW5kZXggOTQ5ZDQ5OTQ0YTM3Li41YTZjNWY3YzM3MWEgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngta29udHJvbi1rc3dpdGNoLWQxMC1tbXQuZHRzaQ0K
PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10
LmR0c2kNCj4gQEAgLTg3LDIyICs4NywyMiBAQCAmbWRpbzAgew0KPiANCj4gICAgICAgICBwaHk0
OiBldGhlcm5ldC1waHlANSB7DQo+ICAgICAgICAgICAgICAgICByZWcgPSA8NT47DQo+IC0gICAg
ICAgICAgICAgICBjb21hLW1vZGUtZ3Bpb3MgPSA8JmdwaW8gMzcgR1BJT19BQ1RJVkVfSElHSD47
DQo+ICsgICAgICAgICAgICAgICBjb21hLW1vZGUtZ3Bpb3MgPSA8JmdwaW8gMzcgR1BJT19PUEVO
X0RSQUlOPjsNCj4gICAgICAgICB9Ow0KPiANCj4gICAgICAgICBwaHk1OiBldGhlcm5ldC1waHlA
NiB7DQo+ICAgICAgICAgICAgICAgICByZWcgPSA8Nj47DQo+IC0gICAgICAgICAgICAgICBjb21h
LW1vZGUtZ3Bpb3MgPSA8JmdwaW8gMzcgR1BJT19BQ1RJVkVfSElHSD47DQo+ICsgICAgICAgICAg
ICAgICBjb21hLW1vZGUtZ3Bpb3MgPSA8JmdwaW8gMzcgR1BJT19PUEVOX0RSQUlOPjsNCj4gICAg
ICAgICB9Ow0KPiANCj4gICAgICAgICBwaHk2OiBldGhlcm5ldC1waHlANyB7DQo+ICAgICAgICAg
ICAgICAgICByZWcgPSA8Nz47DQo+IC0gICAgICAgICAgICAgICBjb21hLW1vZGUtZ3Bpb3MgPSA8
JmdwaW8gMzcgR1BJT19BQ1RJVkVfSElHSD47DQo+ICsgICAgICAgICAgICAgICBjb21hLW1vZGUt
Z3Bpb3MgPSA8JmdwaW8gMzcgR1BJT19PUEVOX0RSQUlOPjsNCj4gICAgICAgICB9Ow0KPiANCj4g
ICAgICAgICBwaHk3OiBldGhlcm5ldC1waHlAOCB7DQo+ICAgICAgICAgICAgICAgICByZWcgPSA8
OD47DQo+IC0gICAgICAgICAgICAgICBjb21hLW1vZGUtZ3Bpb3MgPSA8JmdwaW8gMzcgR1BJT19B
Q1RJVkVfSElHSD47DQo+ICsgICAgICAgICAgICAgICBjb21hLW1vZGUtZ3Bpb3MgPSA8JmdwaW8g
MzcgR1BJT19PUEVOX0RSQUlOPjsNCj4gICAgICAgICB9Ow0KPiAgfTsNCj4gDQo+IC0tDQo+IDIu
MzAuMg0KPiANCg0K
