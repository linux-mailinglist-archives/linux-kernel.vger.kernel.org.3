Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C153599CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349371AbiHSNPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349381AbiHSNP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:15:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D08DEE48A;
        Fri, 19 Aug 2022 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660914923; x=1692450923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eflQw37o37FmagzPujcUQ53RgfqhPVMV9qSDxhqw64w=;
  b=QnjFg7UVowbcmwD4gDapqjZdC2gWpSm6x0T5FoPsvkYa0LwBzRBGToAB
   VH9wVpnfzNZnOtJlBMoILNveABi9yQznUGt2Zu6cJiQAQf3cR+qUt5K1I
   B0UA9L6NqvG/0IIhyV+7AMXuiX6bnD7oFAVp0ZWHQs8aSNhEHkbWMiLg9
   TvOj3BCylztvpMQPFciE2QaixXjfrRai5OxDvXCUmp0pgTw7JMe5QOCUa
   LLNy2yBWArahqOQZxN2biQAd1wivD/lfF67cd1qbc6ydk+dOc0mgA+6lc
   0B+XViChJ8UtWogC6GoXEYGUIrDMpUpj0QTXN9NJ/s4UBExweHbhPpwp7
   A==;
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="109797179"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 06:15:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 06:15:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 06:15:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oapfos8WSk02C3QrzDPAVkWuBKd2Y0adi7LFE850M8C5zQj0aO8j60RkfSVfDSG6JxL1DdlU+7QAYmqtEmUEP49qDFPs97Vbo/ohnPhG9ZHW0C5gEljHOC1HvtkRf/1Jmrcx135JxoG10GHyDYfcipeFjK7Vcl8s/Uo12b0XukisEXtqHHKS0BPlZAsLQPX09JeBxX45OmrThsEjm+6lcCAssBF3ORDftjqfi+OsAu1XVOU7TEk0x8nu4gaMExG1lVmYk9B4amUnMAca8e6eDpSGP747d32NrsNlPjD/K6XyW4oI7MmpZ+YIOJHUmOYg6EyjTAvhaN87gw5XVQvYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eflQw37o37FmagzPujcUQ53RgfqhPVMV9qSDxhqw64w=;
 b=Oqo12hGswcKSlLFYCkzjmYIFbFKZUqWpxjp1xzz0/ctabPimPYrt7cG6DNUAed47xSbAg0atZM3u6Jdcpgb+Dm5K0lMZTxqfU9GUNSvRb8R2CbfkkrggVZMNQddYfzDwSv9r/HGK07JgCFgpOiFCdHTnzwwxN5zIaoBHw6depx7AkgA/c4G5lLLHQaS3O/kdMpLx3KhPLMCizcbFMsggMscdyV7Do10xRw3zjqMAQnt7DuedvjQ1zqXdb15lxwSnB4fjmq1r8armqHjWfzbH/xZKDaelKB7UkE3Qpv2JEgzmj5N7+iHYvygWuI+YJam9ipicpIRbdGJlk/Qxpcme6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eflQw37o37FmagzPujcUQ53RgfqhPVMV9qSDxhqw64w=;
 b=Hw8IzaUNB7Oxkm5mAcyDKhNrmAGioSCsHthoKmI1YhyMgERiyHUjAlD1zDSB7aSrLpP74M3Mpv91Qpzcdqj2Up+Bll7lotZ4D3IsH0+zA5SRXGVRErbhIjepT6d/snUOscDkCY4OCsPxZNM+5I8jGmcVf94eW9RuTsE+eNXI1ck=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB6330.namprd11.prod.outlook.com (2603:10b6:510:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Fri, 19 Aug
 2022 13:15:18 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 13:15:17 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 6/6] riscv: dts: microchip: add the mpfs' fabric clock
 control
Thread-Topic: [PATCH 6/6] riscv: dts: microchip: add the mpfs' fabric clock
 control
Thread-Index: AQHYs8dCZDCkQVxYIEq9YtBMJX9yKK22LDYAgAAHm4A=
Date:   Fri, 19 Aug 2022 13:15:17 +0000
Message-ID: <3ffba600-bda9-8ffa-a435-9a6f94e072b8@microchip.com>
References: <20220819122259.183600-1-conor.dooley@microchip.com>
 <20220819122259.183600-7-conor.dooley@microchip.com>
 <3df8d4bd-3d38-cecd-6589-ccc1be01b886@linaro.org>
In-Reply-To: <3df8d4bd-3d38-cecd-6589-ccc1be01b886@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d3cec93-863b-4750-9206-08da81e4dc86
x-ms-traffictypediagnostic: PH7PR11MB6330:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p1nAi9QtaforTaNZpdXWbLIidLndwiyCMQHKXZsjK4/VhteueHd2YFuxXIfpWFse2oYKFs7NhVU8UAe6A90/Sk3528sd21rW4t3funGzxVScD7h3euc0L/Sgcn86QM1/ufd7UdqCjLENOQSvYfTY2PzKk3QAL/2sj3ZfGlYRd5AfghnCeGihSjshuXCkCBgE6zAxazVbNHEYKXTE1iUic8QD2eNLaYfShCYbv5xPu2Us6wBVg/Zdom5G2dHVQ7T1Pesd9W9Sg9Mghx4bYIWHhDChHALgLGuHcG9wWkYTelvpRnRHbD657HpP+5OymPhdZ0feRsegeoaDdJvsqi8yGKTH36D8jszU3f0AKUAjZgO82xH060YRqF7l74OVrvutorr1knSWzLZ0JM+RKBy7/iSh87+gRw6Nr6LGx5tw8hulOn9kC4pEZEbAfYVyR0mWcAkKCGgEGqi8M9Rd/PQprdVTh9VCuRIRTotnufxCT9WHXFX3lla2goQtFvDnkv/Dwoes+RVppm8c7X3+jhp3nMKgeUV+8a/O5nxn5XaAuFuGNnyKJWmOqUEuWxl1EWEjJzAZxx/ieRxTmDsDsWoah9gZXvmG7kPKzl/2vIR1RjFWBVwFBWQpkywh+xbUNfSYs1Leh/T5W7J9VBZZ12lKv6dFigMMw2MN4UrMXZfAwmHWEPBYdpg26e1vhfM9Ag6JKroxO8cxnihAcnTQ5s03eGaEAv96O7skMjx5Q/yWFyrgMYejTutQQBKEtqickWmqFy4ZtAgdxQJ5QUDAgIvoKkrF/rwmYfC3QOx/kk6DkgZIMeG8lCANwddtvkVe0BT/eZMIGjcUSzXVDqsjW77xtSJuZlQU6iZeEDPr3ysQUyY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(346002)(366004)(396003)(8676002)(66556008)(66446008)(53546011)(64756008)(6512007)(41300700001)(66476007)(5660300002)(4326008)(66946007)(2906002)(54906003)(110136005)(6506007)(8936002)(6486002)(91956017)(186003)(83380400001)(26005)(6636002)(2616005)(76116006)(31696002)(478600001)(7416002)(38100700002)(36756003)(122000001)(71200400001)(86362001)(31686004)(316002)(38070700005)(45980500001)(43740500002)(86284004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUhQNVBDK1lsTkNzNGxCYk93QVFKOGpwU0FQejhoeDh6VXdnQUJ0L0luV0Fs?=
 =?utf-8?B?T2J6STlxcGY1cGZkWERMT0NnKy9ZVWNBZmsrKzhyS2hVa29CNXNaWDVjQTRG?=
 =?utf-8?B?Zm5wLyt5UUt3QW5jRHk1ZmNBQWFHblB2bXRrOGYzMWZzeDVMQUZvcVhoTXUy?=
 =?utf-8?B?aDU2Z0R1ZWozWGhadXJsdjJNYVFGa2dub2FBU2wvdnh4MnRLbzMwNmtVbHBk?=
 =?utf-8?B?aVdtNnNxZ0wwWmlDMTJYWVNqNDNNSTBaRlBCdW03VjlWN2V6Q1l6TTJSR2M5?=
 =?utf-8?B?NDhKOTN0V0k1UGpnWUhPZ09vUVBwS1pxTUJobmpBdUhHb1krcG9IcnMrckxx?=
 =?utf-8?B?d0lEU1pUWkNTb0F0WWIxOXVQTXNYbDhOWFZHNVhHQUxaTEJ4L2Y5SHkyT2ky?=
 =?utf-8?B?Q2MxWEN0eVRsemYvVEtCTW85dHZ3NGdzRVRsUllZcC9NU21IRzBqNDBHYWJj?=
 =?utf-8?B?TmduS3dnenRnWmdDYVlndEdUVjcvN1JzSUNOTDNYbkRnRlBYRnNuS3FwU1NJ?=
 =?utf-8?B?YkREdG9qUkFpblgvRW5PeFlzWUlLUVk3T0pwTGFpNEVKR3VwV29FMWl1d2xN?=
 =?utf-8?B?MVJLUXhiTEdGUml1VGRIZkt5SW4wZm9tUHZReVc2SFhWd29Ub1JFOFd4U1ZR?=
 =?utf-8?B?TlpERFA1UmxXckZRa09ZMVJJTHlsRUtXaUVYb01ja0FxV01FNWw2V1FnN0xD?=
 =?utf-8?B?UXlhR0dqenlrRVFtanpyVjZxNmlQQmExUTd4TGc2V3JJZmJjeXBBNzJzWDZB?=
 =?utf-8?B?UWd4ZDlMQWZkS1R0QXE5c2ljK3Z2Mi9zZkJyU2p2MW9TUkJ6RzZMZ1Zoa3l0?=
 =?utf-8?B?VGZ5S3pnK2V3MWc5eWNLNUxtd2Y3U0h1Ykt5UWZMcnNXTGJkWE5IYWN5TFVL?=
 =?utf-8?B?eGt2am5DRmpOVnQ5UnlsaDRYaEd6SHVsTnhtR0RVVXJiRGl2VVhGUnQwT1B2?=
 =?utf-8?B?bFh1aWwybDlZRlNCQ0lPOEllMWUweXo0Mm5SUm5wb1VRU0J0Y2JLSFhmQjdF?=
 =?utf-8?B?ajIrR21wNEhOaVJZMWJsRW9kQndKeThiSTFLQy9YcVF2WW14UG0yMmx1YzNX?=
 =?utf-8?B?Q3lLeVNiLzlWek80dWtvWEFxaVlNeU1yaFBET3I4Z3R1TzZhNmdvcWR3NlA4?=
 =?utf-8?B?T1BjU1V4MVU0dWI1Unh4MXBscnU2cHlLR2tiaXRXeTN4TzlUcTMvdkYwZHU1?=
 =?utf-8?B?NWVMNCtMTytqeGFManNpQkplaWNNZnVVbk90RGVBc2pBd1NiTUMxT0hMY3NH?=
 =?utf-8?B?NzduNkZ2L012Y1E1cW8ycXFDMHdMV3ZJNmlRM294d01NcGdSeUJFN0lZdmdX?=
 =?utf-8?B?Z1lreVVocG4wSHNsQUZQaU5Nc2J6VWdOTGRVb0Vubm1EMVR1RTM0YVhCR042?=
 =?utf-8?B?azR5UnMwNFlNdXVSY3BzSnJOTHBZbkdCY2pEOEJQY3MvZ09vcHZDaW52clpC?=
 =?utf-8?B?TVB1RVp0RDVKOUQ4dEZQV1hFbGxseVo3dG1mOUNwZUNkbXo5R0pvckRVUTZO?=
 =?utf-8?B?TGFhaVp5MXhXQ2pmUnFwaUJvUVk1b2Q3UTdkald6TmJYS3VFTm5MWUh5NlBB?=
 =?utf-8?B?RzBjbTgveXVoYTNTeFRvVXgwSmt3Uk1LYnV1NFhLandvOWU0OUU4djNHK240?=
 =?utf-8?B?bHVGckJhNzZKLzJHWWhTWEQwRFN5MzJqOUlkd2tQUWFLK3BQVkJpODdxQnN0?=
 =?utf-8?B?bXFZM2ZVUE81aHFVUVJZaWsyTFBpK21tWlRxU2NOUDhIdFVPb2w0SkZqbkl5?=
 =?utf-8?B?RnA1NnZoNjBTbmdkekhCTTBqTlV1WUY3RndNWWNZUExUQktrWTZWeVorbmwy?=
 =?utf-8?B?NzQxM2xBU1dTNWJDMW5TbDFweE9xUkJJSzVGS3p6OTQwZ0tVbkFpeExNMGQz?=
 =?utf-8?B?N1N0ZEUrWkpjTVV6c3FMYVpVVUpnRlE1eGpTRkpBdXhTc01KcHlFQk9MV1Q5?=
 =?utf-8?B?bkUzQ3BMQjdNemNzakx2bUQ0M3JqWjZsaU5pejZkVllLajc5cjFHZ3dFOTZa?=
 =?utf-8?B?b1gyU1RsSm1STUx0SnBjaHBldG9hMTkyREVJZWROYTJLM2J2OWdzZkswVERY?=
 =?utf-8?B?VFA5Rkk0aEx5SXN4K1RhdEppUkVOOXVvaUFPa2JVU3JIUERoR0UwNjhRV2oy?=
 =?utf-8?Q?o/JJu00AaHWhiqS2DnTYkkCmw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <143B11E6C2D4074DA906BFF1B9AAD5A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3cec93-863b-4750-9206-08da81e4dc86
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 13:15:17.8054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfuKll9fMQaBH7I77S2UWZOsa+V3kraKFdHeyDTpy4/37Ijv0uHyodMbcEVFSE8BiBL3D4+4a8F4m6qhL0KrrCZ6vl+/4ZNV2HCnPT881uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6330
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDgvMjAyMiAxMzo0NywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxOS8wOC8yMDIyIDE1OjIzLCBD
b25vciBEb29sZXkgd3JvdGU6DQo+PiBUaGUgImZhYnJpYyBjbG9ja3MiIGluIGN1cnJlbnQgUG9s
YXJGaXJlIFNvQyBkZXZpY2UgdHJlZXMgYXJlIG5vdA0KPj4gcmVhbGx5IGZpeGVkIGNsb2Nrcy4g
VGhlaXIgZnJlcXVlbmN5IGlzIHNldCBieSB0aGUgYml0c3RyZWFtLCBzbyBoYXZpbmcNCj4+IHRo
ZW0gbG9jYXRlZCBpbiAtZmFicmljLmR0c2kgaXMgbm90IGEgcHJvYmxlbSAtIHRoZXkncmUganVz
dCBhcyAiZml4ZWQiDQo+PiBhcyB0aGUgSVAgYmxvY2tzIGV0YyB1c2VkIGluIHRoZSBGUEdBIGZh
YnJpYy4NCj4+IEhvd2V2ZXIsIHRoZWlyIGNvbmZpZ3VyYXRpb24gY2FuIGJlIHJlYWQgYXQgcnVu
dGltZSAoYW5kIHRvIGFuIGV4dGVudA0KPj4gdGhleSBjYW4gYmUgY29udHJvbGxlZCwgYWx0aG91
Z2ggdGhlIGludGVuZGVkIHVzYWdlIGlzIHN0YXRpYw0KPj4gY29uZmlndXJhdGlvbnMgc2V0IGJ5
IHRoZSBiaXRzdHJlYW0pIHRocm91Z2ggdGhlIHN5c3RlbSBjb250cm9sbGVyIGJ1cy4NCj4+DQo+
IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guIFRoZXJlIGlzIHNvbWV0aGluZyB0byBkaXNj
dXNzL2ltcHJvdmUuDQo+IA0KPj4gKyZwY2llIHsNCj4+ICsgICAgIGNsb2NrcyA9IDwmZmFicmlj
X2NsazE+LCA8JmZhYnJpY19jbGsxPiwgPCZmYWJyaWNfY2xrMz47DQo+PiArICAgICBjbG9jay1u
YW1lcyA9ICJmaWMwIiwgImZpYzEiLCAiZmljMyI7DQo+PiArfTsNCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLmR0c2kgYi9hcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL21pY3JvY2hpcC9tcGZzLmR0c2kNCj4+IGluZGV4IDQ5OWMyZTYzYWQzNS4uZGQxNWI2ZDFh
M2M5IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy5k
dHNpDQo+PiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLmR0c2kNCj4+
IEBAIC0yMzYsNiArMjM2LDM4IEBAIGNsa2NmZzogY2xrY2ZnQDIwMDAyMDAwIHsNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPj4gICAgICAgICAgICAgICAg
fTsNCj4+DQo+PiArICAgICAgICAgICAgIGNjY19zZTogY2Njc2VjbGtAMzgwMTAwMDAgew0KPiAN
Cj4gQWx0aG91Z2ggeW91IGNhbGwgaXQgIkNsb2NrIENvbmRpdGlvbmluZyBDaXJjdWl0cnkiLCBi
dXQgdGhlIHJvbGUgb2YNCj4gdGhpcyBkZXZpY2UgaXMgYSBjbG9jay1jb250cm9sbGVyLCBpc24n
dCBpdD8gSWYgc28sIG5vZGUgbmFtZXMgc2hvdWxkIGJlDQo+IGdlbmVyaWMsIHNvICJjbG9jay1j
b250cm9sbGVyIi4NCg0KVGhhbmtzIGZvciB0aGUgcHJvbXB0IHJlcGx5IEtyenlzenRvZiENCkkg
c3VzcGVjdGVkIHRoYXQgdGhpcyBpcyB3aGF0IEkgd2FzIGdvaW5nIHRvIGhlYXIgYmFjay4gVGhl
IHJlYXNvbiBJDQpoYWQgdXNlZCB0aGUgbm9uLWdlbmVyaWMgbm9kZSBuYW1lIGlzIHRoYXQgSSB3
YW50ZWQgdG8gdXNlIGl0IGZvciB0aGUNCiJuYW1lIiBvZiB0aGUgY2xvY2tzIGluIHRoZSBjbG9j
ayBmcmFtZXdvcmsuIEFzIHlvdSBjYW4gc2VlLCB0aGVyZSBhcmUNCmZvdXIgaW5zdGFuY2VzIG9m
IHRoZSBzYW1lIGNsb2NrLCBhbmQgSSBhbSB1c2luZyB0aGUgb2Zfbm9kZSdzIG5hbWUgdG8NCmdl
bmVyYXRlIHRoZSB1bmlxdWUgbmFtZXMgdGhlIGNsb2NrIGZyYW1ld29yayByZXF1aXJlcywgbGlr
ZSBzbzoNCg0KIyBjYXQgY2xrX3N1bW1hcnkNCiAgICBjbG9jaw0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KICBjY2NyZWZjbGsNCiAgICAgY2NjbndjbGtfcGxsMQ0KICAgICAgICBjY2Nud2Ns
a19wbGwxX291dDMNCiAgICAgICAgY2NjbndjbGtfcGxsMV9vdXQyDQogICAgICAgIGNjY253Y2xr
X3BsbDFfb3V0MQ0KICAgICAgICBjY2Nud2Nsa19wbGwxX291dDANCiAgICAgY2NjbndjbGtfcGxs
MA0KICAgICAgICBjY2Nud2Nsa19wbGwwX291dDMNCiAgICAgICAgY2NjbndjbGtfcGxsMF9vdXQy
DQogICAgICAgIGNjY253Y2xrX3BsbDBfb3V0MQ0KICAgICAgICBjY2Nud2Nsa19wbGwwX291dDAN
CiAgICAgY2Njc3djbGtfcGxsMQ0KICAgICAgICBjY2Nzd2Nsa19wbGwxX291dDMNCiAgICAgICAg
Y2Njc3djbGtfcGxsMV9vdXQyDQogICAgICAgIGNjY3N3Y2xrX3BsbDFfb3V0MQ0KICAgICAgICBj
Y2Nzd2Nsa19wbGwxX291dDANCiAgICAgY2NjbnNjbGtfcGxsMA0KICAgICAgICBjY2Nzd2Nsa19w
bGwwX291dDMNCiAgICAgICAgY2Njc3djbGtfcGxsMF9vdXQyDQogICAgICAgIGNjY3N3Y2xrX3Bs
bDBfb3V0MQ0KICAgICAgICBjY2Nzd2Nsa19wbGwwX291dDANCg0KTWF5YmUgdGhhdCBpcyBtZSBl
eHBsb2l0aW5nIHRoZSAic2hvdWxkIiwgYnV0IEkgd2FzIG5vdCBzdXJlIGhvdyB0bw0KaW5jbHVk
ZSB0aGUgbG9jYXRpb24gaW4gdGhlIGRldmljZXRyZWUuDQoNCkkgaGFkIGV4cGVyaW1lbnRlZCB3
aXRoIGEgIm1pY3JvY2hpcCxvcmRpbmFsIiBvciAibWljcm9jaGlwLGxvY2F0aW9uIg0Kc3RyaW5n
IHByb3BlcnR5IHRvIGRvIHRoZSBzYW1lIHRoaW5nIGJ1dCBJIHRob3VnaHQgeW91L1JvYiBtaWdo
dCBub3QNCmxpa2UgdGhhdCAtIGlzIGxvY2F0aW9uL3BsYWNlbWVudCBvbiB0aGUgY2hpcCBhIHJl
bGV2YW50IHByb3BlcnR5IG9mIHRoZQ0KaGFyZHdhcmU/IEknZCBhcmd1ZSB0aGF0IGZvciBhbiBG
UEdBLCB3aGVyZSB0aGUgdXNlciBpcyB0aGUgb25lIGRlY2lkaW5nDQp3aGF0IGNsb2NrcyB3aGF0
LCBpdCBjb3VsZCBiZSByZWxldmFudCB0byBzb21lIGRlZ3JlZS4NCg0KS25vd2luZyBpZiBhIEND
QyBpcyB0aGUgbm9ydGgtd2VzdCBvbmUgaGFzIHNvbWUgZXh0cmEgYmVuZWZpdHMgYXMgaXQNCmlz
IGNvLWxvY2F0ZWQgd2l0aCB0aGUgUExMcyBmb3IgdGhlIHByb2Nlc3NvciAmIGhhcyBhIHJlZHVj
ZWQgaW5wdXQNCm11eCByYW5nZS4NCg0KQW55IHN1Z2dlc3Rpb25zIHdvdWxkIGJlIGFwcHJlY2lh
dGVkLCBldmVuIGlmIGl0IGlzIGp1c3QgYSBOQUsgdG8gYWxsIG9mDQp0aGUgYWJvdmUhDQoNClRo
YW5rcywNCkNvbm9yLg0KDQoNCg0KDQo=
