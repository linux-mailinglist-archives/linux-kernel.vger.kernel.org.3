Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256FC59BF57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiHVMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHVMNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:13:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F612981F;
        Mon, 22 Aug 2022 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661170427; x=1692706427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UnMP60dYYaE6tGkgznUct5z6aIlwwt9W78OFI5QJSE8=;
  b=KypAHEPw6WoHva9xioSVbocvu32Djgswbd/B24Flg5q3DoFI7xhuSHNP
   h/ts2orOsve1LHb4quNQhVU2yHA/Kg166niVHaj18bsRUpIQTmNzWGtSP
   Z3A6rx/uPtZoH3woXBx5zZ82TNmhzUsyiCwMqU+Yf5dRRSFWgErhmUYC0
   zOBcXjLVfPZsx3NPNdjdt1DSjwRzaw47e/A3SZdhiA1yNqSrfnYo2n6NA
   PeAxDozPjhs5H2ZSdxSeoYs3+CRRnTC+o33oliH2bUBJVUKQE/NPeb/8f
   4f4YTdxQhHBd8J7I2Gg+XmrN262On6zkVC8WjHnv1F2VhxQ2+kcGEU+oE
   A==;
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="177214044"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2022 05:13:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 22 Aug 2022 05:13:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 22 Aug 2022 05:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIoMd5u1nrpNV7Gz/r/sjAonW+KkGP7uV5bPqyUQwHBjV3FeR2ZP1eBFgd14uLDs7YbTSiX9CsQeEAH6EpX8nz0EDeu5HG/Gne/0wUXIPOu/bZD9sR8Rz7EI3zSYmO9mJAEZFg4UHZa/VQfNEZc+u6j6Q6xNqa21MElPA8jxJoaxEu6bKW3HBr0oTWV5dUJBEHf/IpdeoIR4WXJyK7eCXmdI594X3e/f4kUpXyzzMAk8uODoq+kD5LJUFoKMwUTQP8QlHzSmcoSK2Bb4MSBPfb7SA99wqqb0s5QN00Vmz8UiOeFJZIfV73fV/OE9YWKBZfedio4mWeFzjM8K01v/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnMP60dYYaE6tGkgznUct5z6aIlwwt9W78OFI5QJSE8=;
 b=fnJTf2N5k4xm699bnuy2hngNbR/tj5eqra8aj/7D7q+jxWVkrBniW5BO0qBnZ7ozokwXE+t3RJ0cOF+P5isH57yIo8wbAAVQBwyCsvILuJphSnJSj9UjGUqmPwP54v7CScbJ4ITgjyZsXCMuAlSa8DPD/FKE3WPt/npsqY41m7/w3tRWhwMCHRk3A9o7M+GrAPwIdMgVNymMzjZ0XEiSC1CsVjv/4SdV93fud8JZ0zXvn2hYSNMVEAiBMbRXMLuZPQul/6tjDZFah8UD5rpevL2B8uYZO1YT4iYLOECa/PaaeDV1UfJb9YNp9ULfdK0mZriXeTED4pvaCfkYkiXvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnMP60dYYaE6tGkgznUct5z6aIlwwt9W78OFI5QJSE8=;
 b=emSp/orDRI0BKuZFk3f8ow25ZqBvbC4KUoVp5IF0sQsbqeW7TMqU+iHfpzlbv87dF1eIl6s/ZNzE1EfmeNxhlADG+wMZmw6KNncDREk9TWBFomD2L+YxhyYzhhlhwc11mFqlxmo989CGvCx1bZOLfG3HYk8GogHn+mtBVT2bR+I=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 12:13:42 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 12:13:42 +0000
From:   <Conor.Dooley@microchip.com>
To:     <geert@linux-m68k.org>, <andre.przywara@arm.com>
CC:     <devicetree@vger.kernel.org>, <aou@eecs.berkeley.edu>,
        <samuel@sholland.org>, <linux-kernel@vger.kernel.org>,
        <jernej.skrabec@gmail.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <wens@csie.org>,
        <robh+dt@kernel.org>, <palmer@dabbelt.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Thread-Topic: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Thread-Index: AQHYsGUwgMumzpPtekanQb2zMhKHQ62v8GmAgABAKYCAB+IqgIAAATuAgADecICAADeqgIABrtyAgAAHcYA=
Date:   Mon, 22 Aug 2022 12:13:42 +0000
Message-ID: <538ae41e-664f-2efb-f941-9a063b727b6a@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com>
 <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
 <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
 <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
 <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me>
 <c7599abd-c4cf-9ddd-1e74-e47dec9366d4@microchip.com>
 <CAMuHMdUHVpj9ikE2NxpBSBtTG8K6v92vGdbw3GLmEYUoVzatvg@mail.gmail.com>
In-Reply-To: <CAMuHMdUHVpj9ikE2NxpBSBtTG8K6v92vGdbw3GLmEYUoVzatvg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ac0f859-f688-40f7-f421-08da8437c0fc
x-ms-traffictypediagnostic: DS7PR11MB6222:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uSjJw35so5pl67q+c4hwRFgkanJnxYNIBhlDDUeyjfbXGp7l8A5YDr0pJTMJhQhuUG4eL378pnPg+psHj1ib+UO9WSJT2ukhq89Odvqg3jaSJt9zBTLLNk2QmF3cLeluEGHMIjExTPXoHB6uyZNGY14g7AfhCWqHLc0+uFNTwEA7eItJeHoP4kyYOdPHmkVVkCgvksNm8Led9JQgcry0YpTR/Tsn12+BUzv9iN18baY7NRvPgVGsWnN8OoMl8veEveuiSMSvVVr/mT2x73ZuE7ijeDqWO8snUzdBpTpyzEBtjWufo2ReJ46EP2XraZf6/RkDrLaGFRlrTy97E6UBX4QgK2/HD0AL0Ja/t1VPq362OTu+BQcNn9btxmMvwVBcj/Q2NpxenNGevseX/fbIP/Jebzo1ZFPKqshSw1bCR0zWmLTblmEobZcYCx45GLU07CCpEQbMMPfvsBX68SWczNnGaC3bGPN6If7sMenCjY9oRh0cMviL2gZAh5XKZa/TqpVeJOw5MVk6To+8yFgPB+HAjGeJr8a5albT4+CfYhNpbdzETTLjmfZgW2RkNGRFgm6HT1TokWs2efhPo7f0/sSiuL55j007iQTbuju3ZmVJ0i1Jq4CxcAE5kPxl//+f62Rr0S+BLM6pnBsre0IhZROd1SA3f9mi22VeEBPu8eefbKMNoDtdZLik9N4tmd5jq/N8Op4SLkRb12tQ6DUcf+QoQADoPDUIYlR5Ym8sWIC4IM5TohPo6307reQzA60d7Rws37djRzXepiVRLEKx2SGCxRotSsRQCNT7LNlhOiQ2xxjxKY1YBvMon0BF/vj+1qw2xaLQO23kQ3ravtVg4HJ1az1zQXJVXTphsQXbmU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(376002)(136003)(31686004)(6486002)(478600001)(316002)(6506007)(6512007)(26005)(7416002)(5660300002)(8936002)(186003)(2906002)(2616005)(86362001)(966005)(53546011)(31696002)(54906003)(41300700001)(110136005)(38100700002)(83380400001)(38070700005)(66476007)(66446008)(66556008)(4326008)(64756008)(8676002)(122000001)(71200400001)(91956017)(66946007)(76116006)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVFnbkh5RmhCa3RGYml4ZWRmcTRyeUJOQ25NSVZPSUt0Vy9MTkQ1YUNQcEtS?=
 =?utf-8?B?VlhYRHg0K1R6Q3U0cVNpR2ZrbW1CRkFOai9NUTBSL1JySHUxTkJqb05TYmRV?=
 =?utf-8?B?WWpYc28rMU5kZGlGTjNrRVlyZTc1U0JLQUVEajNjeVBJZERaM00rSkNiVDg0?=
 =?utf-8?B?L1NlVllUMHhGempIK04rNzVjTlk1ZzFydU9Na2h2QVY1cU9QN1VBelRBMXlR?=
 =?utf-8?B?WXVZeGZOZWhNdzdFWlE1dk1uMW5yLzhjTXBYOFpkK1kyNVpyMGZMbms4b0ZY?=
 =?utf-8?B?Zkd2NXdPUlBmT2RveldraWpUaVlKeUhKdzRYWmlNVFY3Vy9CUEJjSzRTemZN?=
 =?utf-8?B?RDRxY3NoYWcwL0ZOaDVPQnFZNngyZHQ0dUlKeXk4bUdKNklYOVhyR0pmeTNa?=
 =?utf-8?B?djh3MTlVZmIycjN3OFNiaEJxVTQrYmRmYjVLU2JRK25uQ1Y4V2VFWGRyUTIz?=
 =?utf-8?B?aThVdTMrU2VobkJtNEFmOFZjcjJmVkFvTGlIWUY0Rzk0VjlidTh4ck1RYWNa?=
 =?utf-8?B?Q3BsZkZoeTRkZTIzWUQxT0FjY093OXlNejM5eWFWS3lCcjVLb0F2UXIvR3Za?=
 =?utf-8?B?TUZwNTRIdTh3Slcvb3J4Y2dzcThyTWE0MDArWVU2WngxQkd2Vk5wYWNVYUtG?=
 =?utf-8?B?N005c0I3OUJVaXZNNUJoRzJaQ3VzeHBMRzRUNGkxMGFJdGM0enRZcTJmN3Fq?=
 =?utf-8?B?eFk1TmlRSDNLcGU5YVJBeGo0R0tRZlJBSlpsMzRyYXdzaEVsaDJsTUJCVUxZ?=
 =?utf-8?B?c3YrUEZDdnNtZzJrWlIyZjd4ay9qeXVxSkt6aGRtdmVwaldNZFhKcTJTUEFL?=
 =?utf-8?B?dXg4K2Y4eFlSa0gzQzB6WDVpUURSU3VNdnpibzFNM1VtUnloZ2g0TW1MY2dk?=
 =?utf-8?B?UkZGaU9BVzRJMEJTQmh3N0ZjZnVyYkJSNVlvWjE2VmdNQzA5VFRMOGdMTXZI?=
 =?utf-8?B?UXUxbzVnVjg2TlhoM2pWM0tCNVBkWUN1RGFxcVVsMWZiUVMxeTZKK0pBRjRC?=
 =?utf-8?B?VG1LcjdxeDhTMlpQeE5XbkpHbmQ5a1EyczhVOXRsbEZ0RE5sdzl4anU4YlZF?=
 =?utf-8?B?YytnemNzdW9VYk80MndqNSt5SUlpQ04xUnlPTzFKSVNZd2YvcWlDZ0wrNlNz?=
 =?utf-8?B?WUFtZmRSdFEwMkZrZzBiQllPMUpic1RXTVBpN3BLMCtTUEtKRXdubnd3UTlt?=
 =?utf-8?B?UDVsVTdCMlB1SUdYSG05Z1lYcThVNi9OQlBncjFmN0ZhaVI2LzFReUxKaVFW?=
 =?utf-8?B?aVlEWUdjMmh4Y2E3NVZvSFF4QXF2Wmg5KzZBQy9XMTR5V0tuRXRjMTVJeHNN?=
 =?utf-8?B?cTFMRGJkUXlJb05uVU1oZksvakNFbmxidnhNdE52QWFDaHl5alVVZE1JeThF?=
 =?utf-8?B?ZjJTdi9haFZUZFd5YTNPdFJxcTZlSDF4WDVOOC9vdlY2WHBqa2thOUNkU0ZS?=
 =?utf-8?B?TGlqVTRvSFJvY3FhTGJpd0xlVjZrZktGbVA3OUdVemlnOTg2RnF5dzNaMlJ2?=
 =?utf-8?B?WUEvR3dEZ2R2bTR6QlhmUHQ4VkI1WXFnT1lYbVJPMlA4dDJZN0N5bWRNak1u?=
 =?utf-8?B?VjRnT0dFSkRJNGxFajNxdkhpcHY4VzFYeVA4bWhMT0hFSE10aHRsc29MWi9T?=
 =?utf-8?B?UjFnSHRWem9pSnJEcmtZeGF0ckFmQjZzNFQ4a3I5UWIrUExRNms4NXV2RkM3?=
 =?utf-8?B?Rmo5eUFKakVJUXBpNVNkSVdEQ1V3bndnOVEwY3hmSklMSEtQMThsWkJUankr?=
 =?utf-8?B?SE5qTTh6ZWZEdExRWmR6YmxKMVhtVjZlMElRTVcwaXdUSDBFdE5jZmp3bkFz?=
 =?utf-8?B?UUNiSWZjeXdmZ0w3clZtbDZ0WVVSV3BvZWwvWGV2eW5RRHFmLzZra3ZIRTRL?=
 =?utf-8?B?c1FBWjlkK3Y2bU9CT3o3S1lXQzdVa2NXUFpqNC8vck5oTGd5WHZBQTBjOXZz?=
 =?utf-8?B?dnRvQ3pRTkFPZWowTkJCZ216blpVa053NUE2aTJwMEFYRWM5VUk0ajZkeGlv?=
 =?utf-8?B?VmRtVmxhVTZjbjVSTC83ZnZPMFJBaTFmMEhDczgwZ1FCYzFiUjdHZFhvWU1C?=
 =?utf-8?B?VW01QnJvTDJ3R1JHd0IzQjJKWURWbndsN3Z6TldGQ096WWpGd1Z5bHFnaTY1?=
 =?utf-8?Q?7qIR4+PeoucgygPiRqmFjaJcX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5B14E67CDF67C4DBB559FDA7E4F4FA8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac0f859-f688-40f7-f421-08da8437c0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 12:13:42.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPK8Lp1cU/F6NETMFTMCmOiEFGrfX6yF0JomLIf9IdkxCTjtr5d7TniDmcA//vjeClmFDyVdSAo6f4rjasdn/TR90kClz1zGAtsERiGi5Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEdlZXJ0LA0KDQpPbiAyMi8wOC8yMDIyIDEyOjQ2LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQ29ub3Is
IEFuZHJlLA0KPiANCj4gT24gU3VuLCBBdWcgMjEsIDIwMjIgYXQgMTI6MDcgUE0gPENvbm9yLkRv
b2xleUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+IE9uIDIxLzA4LzIwMjIgMDc6NDUsIEljZW5v
d3kgWmhlbmcgd3JvdGU6DQo+Pj4g5ZyoIDIwMjItMDgtMjDmmJ/mnJ/lha3nmoQgMTc6MjkgKzAw
MDDvvIxDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbeWGmemBk++8mg0KPj4+PiBPbiAyMC8wOC8y
MDIyIDE4OjI0LCBTYW11ZWwgSG9sbGFuZCB3cm90ZToNCg0KPj4+Pj4gVGhpcyBpcyBub3QgZmVh
c2libGUsIGR1ZSB0byB0aGUgZGlmZmVyZW50ICNpbnRlcnJ1cHQtY2VsbHMuIFNlZQ0KPj4+Pj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvQ0FNdUhNZFhIU01jclZPSCt2Y3Jk
UlJGK2kyVGtNY0Zpc0d4SE1CUFVFYThuVE1GcHp3QG1haWwuZ21haWwuY29tLw0KPj4+Pj4NCj4+
Pj4+IEV2ZW4gaWYgd2Ugc2hhcmUgc29tZSBmaWxlIGFjcm9zcyBhcmNoaXRlY3R1cmVzLCB5b3Ug
c3RpbGwgaGF2ZSB0bw0KPj4+Pj4gdXBkYXRlIGZpbGVzDQo+Pj4+PiBpbiBib3RoIHBsYWNlcyB0
byBnZXQgdGhlIGludGVycnVwdHMgcHJvcGVydGllcyBjb3JyZWN0Lg0KPj4+Pj4NCj4+Pj4+IEkg
Z2V0IHRoZSBkZXNpcmUgdG8gZGVkdXBsaWNhdGUgdGhpbmdzLCBidXQgd2UgYWxyZWFkeSBkZWFs
IHdpdGgNCj4+Pj4+IHVwZGF0aW5nIHRoZQ0KPj4+Pj4gc2FtZS9zaW1pbGFyIG5vZGVzIGFjcm9z
cyBzZXZlcmFsIFNvQ3MsIHNvIHRoYXQgaXMgbm90aGluZyBuZXcuIEkNCj4+Pj4+IHRoaW5rIGl0
IHdvdWxkDQo+Pj4+PiBiZSBtb3JlIGNvbmZ1c2luZy9jb21wbGljYXRlZCB0byBoYXZlIGFsbCBv
ZiB0aGUgaW50ZXJydXB0cw0KPj4+Pj4gcHJvcGVydGllcw0KPj4+Pj4gb3ZlcnJpZGRlbiBpbiBh
IHNlcGFyYXRlIGZpbGUuDQo+Pj4+DQo+Pj4+IFllYWgsIHNob3VsZCBtYXliZSBoYXZlIGNpcmNs
ZWQgYmFjayBhZnRlciB0aGF0IGNvbnZlcnNhdGlvbiwgd291bGQNCj4+Pj4gaGF2ZSBiZWVuDQo+
Pj4+IG5pY2UgYnV0IGlmIHRoZSBEVEMgY2FuJ3QgZG8gaXQgbmljZWx5IHRoZW4gdy9lLg0KPj4+
DQo+Pj4gV2VsbCwgbWF5YmUgd2UgY2FuIG92ZXJ1c2UgdGhlIGZhY2lsaXR5IG9mIEMgcHJlcHJv
Y2Vzc29yPw0KPj4+DQo+Pj4gZS5nLg0KPj4+DQo+Pj4gYGBgDQo+Pj4gLy8gRm9yIEFSTQ0KPj4+
ICNkZWZpbmUgU09DX1BFUklQSEVSQUxfSVJRKG4pIEdJQ19TUEkgbg0KPj4+IC8vIEZvciBSSVND
LVYNCj4+PiAjZGVmaW5lIFNPQ19QRVJJUEhFUkFMX0lSUShuKSBuDQo+Pj4gYGBgDQo+Pj4NCj4+
DQo+PiBHZWVydCBwb2ludGVkIG91dCB0aGF0IHRoaXMgaXMgbm90IHBvc3NpYmxlIChhdCBsZWFz
dCBvbiB0aGUgUmVuZXNhcw0KPj4gc3R1ZmYpIGJlY2F1c2UgdGhlIEdJQyBpbnRlcnJ1cHQgbnVt
YmVycyBhcmUgbm90IHRoZSBzYW1lIGFzIHRoZQ0KPj4gUExJQydzICYgdGhlIERUQyBpcyBub3Qg
YWJsZSB0byBoYW5kbGUgdGhlIGFkZGl0aW9uOg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtcmlzY3YvQ0FNdUhNZFhIU01jclZPSCt2Y3JkUlJGK2kyVGtNY0Zpc0d4SE1CUFVFYThu
VE1GcHp3QG1haWwuZ21haWwuY29tLw0KPiANCj4gV2l0aG91dCB0aGUgYWJpbGl0eSB0byBkbyBh
ZGRpdGlvbnMgaW4gRFRDLCB3ZSBjb3VsZCBlLmcuIGxpc3QgYm90aA0KPiBpbnRlcnJ1cHRzIGlu
IHRoZSBtYWNybywgbGlrZToNCj4gDQo+ICAgICAgLy8gRm9yIEFSTQ0KPiAgICAgICNkZWZpbmUg
U09DX1BFUklQSEVSQUxfSVJRKG5hLCBucikgR0lDX1NQSSBuYQ0KPiAgICAgIC8vIEZvciBSSVND
LVYNCj4gICAgICAjZGVmaW5lIFNPQ19QRVJJUEhFUkFMX0lSUShuYSwgbnIpIG5yDQoNCkRvIHlv
dSB0aGluayB0aGlzIGlzIHdvcnRoIGRvaW5nPyBPciBhcmUgeW91IGp1c3QgcHJvdmlkaW5nIGFu
DQpleGFtcGxlIG9mIHdoYXQgY291bGQgYmUgZG9uZT8NCg0KV2hlcmUgd291bGQgeW91IGVudmlz
YWdlIHB1dHRpbmcgdGhlc2UgbWFjcm9zPyBJIGZvcmdldCB0aGUgb3JkZXINCm9mIHRoZSBDUFAg
b3BlcmF0aW9ucyB0aGF0IGFyZSBkb25lLCBjYW4gdGhleSBiZSBwdXQgaW4gdGhlIGR0cz8NCg0K
PiANCj4gT24gTW9uLCBBdWcgMjIsIDIwMjIgYXQgMTI6NTIgUE0gQW5kcmUgUHJ6eXdhcmEgPGFu
ZHJlLnByenl3YXJhQGFybS5jb20+IHdyb3RlOg0KPj4gVGhlcmUgYXJlIGludGVycnVwdC1tYXBz
IGZvciB0aGF0Og0KPj4gc3VuOGktcjUyOC5kdHNpOg0KPj4gICAgICAgICAgc29jIHsNCj4+ICAg
ICAgICAgICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsNCj4+ICAgICAgICAgICAgICAg
ICAgaW50ZXJydXB0LW1hcCA9IDwwICAxOCAmZ2ljIEdJQ19TUEkgIDIgSVJRX1RZUEVfTEVWRUxf
SElHSD4sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MCAgMTkgJmdpYyBH
SUNfU1BJICAzIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLi4uLg0KPj4NCj4+IHN1bjIwaS1kMS5kdHNpOg0KPj4gICAgICAgICAgc29j
IHsNCj4+ICAgICAgICAgICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsNCj4+ICAgICAg
ICAgICAgICAgICAgaW50ZXJydXB0LW1hcCA9IDwwICAxOCAmcGxpYyAgMTggSVJRX1RZUEVfTEVW
RUxfSElHSD4sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MCAgMTkgJnBs
aWMgIDE5IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPj4NCj4+IHRoZW4sIGluIHRoZSBzaGFyZWQg
LmR0c2k6DQo+PiAgICAgICAgICAgICAgICAgIHVhcnQwOiBzZXJpYWxAMjUwMDAwMCB7DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJzbnBzLGR3LWFwYi11YXJ0IjsN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4NCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnRlcnJ1cHRzID0gPDE4PjsNCj4gDQo+IE5pY2UhIEJ1dCBpdCdzIGdvbm5hIGJlIGEg
dmVyeSBsYXJnZSBpbnRlcnJ1cHQtbWFwLg0KDQpJIHF1aXRlIGxpa2UgdGhlIGlkZWEgb2Ygbm90
IGR1cGxpY2F0aW5nIGZpbGVzIGFjcm9zcyB0aGUgYXJjaHMNCmlmIGl0IGNhbiBiZSBoZWxwZWQs
IGJ1dCBub3QgYXQgdGhlIGV4cGVuc2Ugb2YgbWFraW5nIHRoZW0gaGFyZCB0bw0KdW5kZXJzdGFu
ZCAmIEkgZmVlbCBsaWtlIHVuZm9ydHVuYXRlbHkgdGhlIGxhcmdlIGludGVycnVwdCBtYXAgaXMN
CmluIHRoYXQgdGVycml0b3J5Lg0KDQpUaGFua3MsDQpDb25vci4NCg0KDQo=
