Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066315A6B21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiH3RrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiH3RrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:47:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B411E62E9;
        Tue, 30 Aug 2022 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661881406; x=1693417406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zt0XpeFdz/NWhhYyjcqJyeosPbME3h4d/LSr7BuM6f0=;
  b=0o39BrY5SWrHiFbs1k3RMNX8QrxEBHjsCEIPETPqaqlJ7ozXw5Goe+Gi
   /kdS8pJJTS0MjSBQwHZ2OkZlsZaXt0dn6+JqOb+fGzaOGUNhPCe2P/70S
   pu/3vKceLahdJ4oc5afNl5+4e1XZDZYRCPdPq/NRpMW6n+TozkUY0/2B9
   S5jc6s9Hrkva+rPpiSdOzqCkDjAJFpsp6PAHHBErcoSvX7fel+yhx6JQ6
   DrYS60TfAT8Yo3dbSZRukE0BbffDF3la7WJpH5QWOb/MaaZzeZdMnIwrX
   90id0kwS/1StcsFLL622O99HN3uQ3kK78Pt30593fIVTQ4SMGRNoawCGK
   A==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="171640398"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 10:35:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 10:35:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 10:35:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8wvELx+hcMrS4T+AFOlq79eyARRPKw6rTToZXFZB/Kndg0J888LEXAMqPB2eU8GpYokIjzfmh77y3XUTKSmUr1qNrx7LZMuQcSnZ+LsGoEcK1l7YtzP4P0sddgkZxBNcIyN3N4VeLj7K3vkesuh+eDvjsEUGqVR5Smd8RaO1Dkh+kdBoMNoX/eZ3Ccv9WQrnYyqi2B6ZOgrRoeBce8JY6IkIhQMwdEbMf0dl7z6FHn286zPLE5v3ugSnqrs/NJQv7xPKJvqHv5EXWE64/14FFw18bs/gPjljbQAQsuoNrhwWvx2F1VQVNxPed8M5W0jGdcTIc4Sd1g3stLXgK0KDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt0XpeFdz/NWhhYyjcqJyeosPbME3h4d/LSr7BuM6f0=;
 b=YP32xsHZ29Ew1IbVz0ff3FmY0l0Xv7VfXFEDcwAcxSS6NDgMco7OCkUH5LBK1LhI6Rhe9BoT/eaAM2EKaRtxc61gX1+nuaGQvVi03Hzq9Anned7XyGNQlnytdv11LmVvBdQzyDLpCPD2ip0ov6rH4TYwvViE3zU7Aia6198ur2xSDIRfTV776Ao2qv25tyzIGX4CtGGZsHgRZGFfnNcq+kRdyM+ElxHoNcOoO8VXlrQNovqwbQJvSvuk/1NXshdprefklPPpeBKo9kW4DV3/SR8kbr5kgYvXhTav/H6AIulJN8VLOM0DN47asoJ2JyrLXtK5PspeZshjPpGWN9PVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt0XpeFdz/NWhhYyjcqJyeosPbME3h4d/LSr7BuM6f0=;
 b=SXIafkL30dXkUbtmSLP6ZWb3a7nwBa3PYJMq4njnjssVtBqbgNVaeDTnCSGqH/1VoYLKvI0GmGx2lWaIMDn4o6xC+8n0XDJQtJ9WgSrZ+t9iL9dV+JkYJ2JCW7lffcZx8njTNrHjhhf9u5OAhM2ergYbzaWK4p/fCN/8uwmD1aw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2825.namprd11.prod.outlook.com (2603:10b6:5:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 17:35:55 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 17:35:55 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <Daire.McNamara@microchip.com>, <Shravan.Chippa@microchip.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Cyril.Jean@microchip.com>,
        <Lewis.Hanly@microchip.com>, <Praveen.Kumar@microchip.com>,
        <wg@aries-embedded.de>, <Hugh.Breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Thread-Topic: [PATCH v2 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Thread-Index: AQHYvFnwSpVLiReZPUWC5HM7xMt/UK3Hg2QAgAANgQCAABkagIAAAP2AgAAIm4CAAAGfgA==
Date:   Tue, 30 Aug 2022 17:35:55 +0000
Message-ID: <8ae5c383-1c04-e16e-83a6-26861640deb1@microchip.com>
References: <20220830101803.1456180-1-conor.dooley@microchip.com>
 <20220830101803.1456180-3-conor.dooley@microchip.com>
 <a3a8e2ba-a6bd-6e66-fd04-e3a46661a34d@linaro.org>
 <27b8aa9e-9173-b40e-8f9c-a53fa5ba36c8@microchip.com>
 <1065bc99-d73a-9d19-7f09-26cd862fe0c7@linaro.org>
 <69027950-f18d-c9a7-9f0b-d73ef68197c7@microchip.com>
 <dc3bd6c6-852d-30a5-2ec1-ab5f7fd1488c@linaro.org>
In-Reply-To: <dc3bd6c6-852d-30a5-2ec1-ab5f7fd1488c@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 406dd98c-dcfe-47f1-81cb-08da8aae17d9
x-ms-traffictypediagnostic: DM6PR11MB2825:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j83j0bWqCbNblxbpyibQNvMVzLN5No9XWDLL6o07rvX7l2Jf+pXFW1624FF8W/mG2IRGGK6ZuO3iVKl/8JAWwdmQcUeMjZH+lJ7AKjla6NrjnVraRTnixodd8MXw6L57NigX7NRoUALBQ6lI4Dljfg825ot8ojYeHjBZzsDDdmq32SKK+p14dlc7MVvyfi8K5vR4UMkPW8lx43uue/JhsHWdch1EKWqyHkZvU0lUmw5BikbluGFFu6qpI5QOrh21Hok1+J0KtRunStWiRQYZ42oqICBTzH3shN/3FXBw7amAo284pVbgrDKfYqmCzqXs2u5QKYgyQiQV+TjZSuzykLk/MYcyrdObnbUg3hNDidnz91fcDMG/MY9lWw6Z5+COMkCFGuqqehyD7TS+dTN4+18aWNjFp+0lI+d04gorjrGe9QKV5QxohEYkWvuXjprLJAqyGjXOmlAntvNyPyXvaZysl/lVknC4CQ02GLT0Toep1Mu5BjQ9e7FCtymrlJF5AvtIgZatLQuplZnWT0+E6kcy+Y7S9+1M+xg6teYVJvtwLM9sZESsgAX0uy6+aWNZdouwpn/8l2n9OLxN7ZwZ9ysDnTwDYU8kctx3eIYSUycHywBEPr8Hm9mOW/PyC/2Owntdqisorw9JNLa2DYfEUt84doe8y3cbhdFUKEYEaoMWomrnQtqDTBgIpoqRmI+/cnbTDu5+wGlqtg+ckNfV1pev+rWuIhdCzIcvh9KlFZTVGOUnktb8XVNiU2pQRS1cxyFogMWPK8S3NY0xbxXmX/F4X+t/qSvQtDiUjfKGTUtBQh69jHRyMzwRM61naatT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(136003)(346002)(39860400002)(38100700002)(6512007)(2906002)(26005)(53546011)(6506007)(122000001)(2616005)(186003)(83380400001)(71200400001)(66556008)(66446008)(316002)(64756008)(66476007)(8676002)(66946007)(31686004)(31696002)(110136005)(76116006)(4326008)(54906003)(91956017)(6486002)(41300700001)(7416002)(36756003)(6636002)(8936002)(38070700005)(5660300002)(86362001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3VORi9xMHBFUXZnSmFrYW9qeFNYN054Z1FDU2NraTJCNE9kdnV4RjM3UFFQ?=
 =?utf-8?B?cDBOQTZaRkVhVG53M0w2TStDamJGYnVYbGN2NGp2MDNoUlNaTjNsNXEwMmND?=
 =?utf-8?B?TUNTaHUwUVo1Wmo4UHV6TXJVS0ZvR3lXZXpCNUJCMGlMRm5rbWFsbU1nOTN3?=
 =?utf-8?B?N1VWTTcvZ0liNUdhd1pYZTlWQklXaUFMZkpRUm1yZ1JNM2dROEVwNXI1R3Ev?=
 =?utf-8?B?cjRBVkI1c1NaN1VpQzVydEV5WEE5eXo2MEs3ejBZdDVPSm5TeWJaUGFBYUMy?=
 =?utf-8?B?aHhMZHBwV0tFZElId3cwWnZTbjJSSThubkZUTC9QS25XM2M1d2U1ejRVbjVs?=
 =?utf-8?B?bVFGWGEwV2xSVDF3NTFXU2tOSC9FMDJMSktSRGNLZXd0eWdGOHFtWGIzQU9p?=
 =?utf-8?B?WmJySlBoamprRytFV0hodXg2djdGbmpXYnJJV1dqckRXcWtNc2ZQYkp6R0Ny?=
 =?utf-8?B?eVpOZjNMMUlFTldyRURoWlVNZE85WFljR0ZWWEdmZjZnZ0RqT0p0QnAvbEd1?=
 =?utf-8?B?NVdYc2l4VldlZldJcWVKcTNnRXFsbFRwcldVTHg5by9oNXZML0VtV1AyTGU0?=
 =?utf-8?B?Wm1IS3k5djVIbFZONUptc0JqaDRjU3ZsSlpIMEZyQVlEK3c1UFZrZmRFUVdD?=
 =?utf-8?B?UlFLSWx2M1RCQjhhS3ViSTRaOHlCaXd3RFczRGg3UTFXd2xkVnYwODJaWE95?=
 =?utf-8?B?NTRETUZ1QUgrei9VNU1VOWZ2aHhHSm5Gc3paZTlzQ0JpR2JSUzR1OFUxNEN0?=
 =?utf-8?B?eHN3R1djcncwRElRUFMyaUgrOFZ3QlVnRCs0MWlwRFpGNHE2a3BsVVRrb1pB?=
 =?utf-8?B?UnF0b3h4TDhMaDduL1pOUGpXQzJJUVUzdWtDN0IyejFGaitseTJMRkR6Mldx?=
 =?utf-8?B?WjR1R0ZjQXVtU0JYREtwUFRXYzliV1hRQy9SZmdNOENJVWxONzNQMk9lU2NB?=
 =?utf-8?B?cTl0WHlSdUxheVkyYWd5VE1Id2VkK0l2ZTRUQzZrNGVsWXFTS0xmbmVtUTZO?=
 =?utf-8?B?Nnk1M2VqcEtoRkxXWmdGbFduNE9IWnhPaExaZkxva2R2bmhDSXVCSHIzRkxO?=
 =?utf-8?B?UDR2MHF0UGV2MzVmTnpCWmVRaVFjODJydWk2VTFEdU0zZndFT1c0NkZHVVYw?=
 =?utf-8?B?RGRPaUJwUVJnY0ZvQWlzMGFlQnh1RWYzTm9rSzFuaXJPeCtSSWp6NGlnQU0z?=
 =?utf-8?B?Q0gyUnN1RHVQbVhWMUc0MEVKeGtTcWlHU002RFhqNFdrVDJ3bGpuRE4rZ1E0?=
 =?utf-8?B?ZjRlYkVET2JZT0h2QldnVVVsOHpyMEFmYmpRTzdrUXFCRU1ENHM1TEZkOEtu?=
 =?utf-8?B?N2ZEZzlOQ25hdktnTVF0MEw2YStlaExqWWQwWU5JRkpCN2FON1l2blIxMHBO?=
 =?utf-8?B?MTZpRGdlZ2VpZzVEL3dMOW5vNjUxV1ErR0kvN25ZL0ova3JvZVlFWW82dTVP?=
 =?utf-8?B?V1kzV210bnJBVVBJdjAvUUdDTmdiL013N09WYnl2L05DdjRORDcrWmRCZUwy?=
 =?utf-8?B?WWZ2WVpaa0VyM3JVaFhoVTBFRjYxL2w5ajJRNEhkOGhRWFBEbHIxUmdRMG8w?=
 =?utf-8?B?cU1iNmFFbHVFb0drVkNTaFdLT3hsSHZBZDc3cWN5TEFRMWRCcG04em9XeFpK?=
 =?utf-8?B?NGZlVVA3eXhGbVFSSFRSNXZYVGZmd1dnZkI2ZmREY3M1VXd4dE8yekQ4NFRP?=
 =?utf-8?B?aTVFajFSTmo1d21uOUFaSGVnN1pJVEhrQUx6RFcvSmp6Q2RCS2lkR2N1cjdG?=
 =?utf-8?B?YzJSMEI1eURGY05SbkdiMElRZEZXLzBFWmgzRHVpMmwxVGJJTk5DVWh5T2ZK?=
 =?utf-8?B?T0gvcEo5N0t3emVZVTI5MFlNQ2pFeGZveHZmRVVjcVUySUdTWTU4YmJKSk5H?=
 =?utf-8?B?OWZnZ21BOGsxNC9Oa1cwRnA1R2cxcjBId2daSFJsYWlBUlMrUUpvaHI3dFRp?=
 =?utf-8?B?L2VVRTRkVVpaWmEwT2lQdnBCWWlJUkNLSWVITjNsR3JOTUxNeXdsZkFKQXZX?=
 =?utf-8?B?YmVTblVwc25iRUEvLzlOU21HaWlJS01jZElSV3p0Wmp0cisvUnRHWW5KZk9x?=
 =?utf-8?B?YjExMGlDaGRSdGF6Q2Y0M1BsdUlRbWV4WGw2WTRQYldLNlY5NHAwVVZGYXYv?=
 =?utf-8?B?emhxcnJSYnpHdklyWmNHaHlERkd0Z1FPb3N1MVJ1b0xRN1hhTy9GZGY5akty?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD0BAA9C5529F043B67902E282AED486@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406dd98c-dcfe-47f1-81cb-08da8aae17d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 17:35:55.5263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRJsGtwa5MeqIg4KaBCNfAIXTymM4gDVDwwSHckK5LLB2RfqvmWGqnvlXwvKO75h6fv/O18u+q5V1CA2V42zHsA504cbhV4L53bBO9R7cWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2825
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxODozMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAzMC8wOC8yMDIyIDE5OjU5LCBD
b25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4gdyBkdHMgd2VyZQ0KPj4+PiBu
ZWVkZWQgc28gdGhhdCB0aGUgZ3Bpby1ob2cgY291bGQgYmUgc2V0IGNvcnJlY3RseS4gT3V0IG9m
IGN1cmlvc2l0eSwgSSBjYW4NCj4+Pj4gaGF2ZSB0aGUgc2FtZSBjb21wYXRpYmxlIGluIG11bHRp
cGxlIGRldmljZXRyZWVzIHJpZ2h0PyBJbiB0aGF0IGNhc2UsIGl0DQo+Pj4+IHdvdWxkIGp1c3Qg
YmUgImFyaWVzLG0xMDBwZnNldnAiIGhlcmUgYW5kIEkgY291bGQgcHV0IHRoYXQgaW4gYm90aD8N
Cj4+Pj4gV291bGQgbWFrZSB0aGluZ3MgZWFzaWVyLi4NCj4+Pg0KPj4+IERlcGVuZHMsIGJ1dCBJ
IHdvdWxkIHNheSBmb3IgdGhpcyBjYXNlIHJhdGhlciBub3QuIFRoZSBjb21wYXRpYmxlIHNob3Vs
ZA0KPj4+IGlkZW50aWZ5IHRoZSBib2FyZC4gSWYgdGhlIGJvYXJkcyBhcmUgZGlmZmVyZW50LCBv
bmUgY29tcGF0aWJsZSBzaG91bGQNCj4+PiBub3QgaWRlbnRpZnkgYm90aCBvZiB0aGVtLiBJbWFn
aW5lIFUtQm9vdCAob3Igc29tZXRoaW5nIGVsc2UpIHRyeWluZyB0bw0KPj4+IG1hdGNoIHRoZSBE
VFMuDQo+Pg0KPj4gSXQgaXMgdGhlIHNhbWUgYm9hcmQgdGhvdWdoLCB0aGUgd2F5IHRoZSBib290
bG9hZGVyIHdvcmtzIGlzIHRoYXQgaWYgaXQNCj4+IGRldGVjdHMgYW4gU0QtY2FyZCBpdCB3aWxs
IHVzZSB0aGF0IHRvIGJvb3QgZnJvbSwgYW5kIGlmIG5vdCB3aWxsIGZhbGwgYmFjaw0KPj4gdG8g
dGhlIGVtbWMuDQo+IA0KPiBXYWl0LCBJIG1pZ2h0IG1pc3MgdGhhdCBwYXJ0LiBTbyB0aGlzIGlz
IGV4YWN0bHkgdGhlIHNhbWUgaGFyZHdhcmUgd2l0aA0KPiB0aGUgc2FtZSBTb00vU29DLCBzYW1l
IGVNTUMgYW5kIFNEIGNhcmQsIGV4Y2VwdCB0aGF0IG9uZSBoYXMgcGx1Z2dlZA0KPiB0aGlzIFNE
IGNhcmQgKGFzIGl0IGlzIGhvdC1wbHVnZ2FibGUpPw0KDQp5ZXNzaXINCg==
