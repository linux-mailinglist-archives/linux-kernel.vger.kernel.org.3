Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6DF5998CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347583AbiHSJ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347843AbiHSJ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:26:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D468BF43BD;
        Fri, 19 Aug 2022 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660901165; x=1692437165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8y23HCbnNgHKS/FPOn2YB2WtlXo94j8KgxceKNk7tDY=;
  b=womY3DMrYBo42tD4FLqCFd1AlDPd33XLrkdbPOkXfSSxg6dg31E3kt6c
   uW6OslyPFz5qdmUT4lFMq2Jw7RYNM0/Bk1s49Pc8HIBy/v/kEwMwnk5j5
   57rccpjM18KTIFdMVj1pbhybfDnsrjrfOiuHZDdhBhEZH397VXOgj7m2n
   JFMm5gDLwmE0MtSt2vcRouGG6P9RMnP7mSUE7aReXuZXAMeF7uqfwLrIf
   gjNjEdAzzylSBoSLP2k62H1XWGI4fN6tGDR5MP3QtkgTJzEviep8BbEg/
   yIujpaTU8cCvkCriB8U/7Z/O/L4v/JeQtg9dPug+DY7h/ZhKCp5o3QaED
   g==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="177052190"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 02:26:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 02:26:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 19 Aug 2022 02:26:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjSI6ppzwXI+XirbZlNvtuGTswqxnkQlMW0O4hINww2wJDSJODtsL69ubxGzRNIVNx5wcAdTpu3QGtq7rT07W0XIJHGx2k9n0/pdNRm9ZiHQyOUyNL68yVQWXn/+AsHU1WIkR31t5t925zNbujWXCw5HGJlF/f9YP7YX8tuBpFlTlgsagEHshDGbUc+Wq82ZumJxSNNIwppDtP1flsqwOFhp/uuzWwUNrfa3B+Y/na+wqSqRbZcGo/PJmLDFc7ZjoMDcspVm387cHltCZY3rZnyX0RxLbmDPMm94SHQB5QRrnW0zUO3AF3vdI7RhXfgvy/PiqBNkin7yuiUG0J+9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y23HCbnNgHKS/FPOn2YB2WtlXo94j8KgxceKNk7tDY=;
 b=LQhd+CbFbSR1QMkxnY5BPcKD2ARKaGMLwJ8Zp3YS7NtYiiR8h8msn854JNIYJP16SgrvUZnF1kW7IJRpLtwA25bGPtSzvZ1R1UJJLyfW1DxVf+5ifjokQrG+owI83qttPZbf2v5708psjSKL7yoahGWDJM9qR+vS+I/g0inHoSPshTfWnF8IqUTa7jQBe9WuRofkBF3uIZUcoe7YCSkfsDkSKvfkN6CobXVnTWOi/vGkeYjN0b4i3ZqMfJybShz7BE6L+y37MAxzDtDbos59uWxmRSmzyF8Kk6E3OVCHBYdLU1UixEx7pCq12goly73ojvr5Qq0Bjp8qXvLi+RJkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y23HCbnNgHKS/FPOn2YB2WtlXo94j8KgxceKNk7tDY=;
 b=lQJBbDe4eYJ9CKRfcPTUjx/V/TgcVYM/M3tPcWbCGqW9AtJ4E53ElfKN01ZTCyVZ8NLkvRiPZjKBdxgtMklok6tcW0o8ptwwsp8t/IsM0p7oqbAwPnl/f+frbqzz5gsB2Z1NOP163/Wan+i7tsnZ401N1X7wjxrbAVIrKXmuZkY=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BN6PR11MB1619.namprd11.prod.outlook.com (2603:10b6:405:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 19 Aug
 2022 09:25:58 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 09:25:57 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <radu_nicolae.pirea@upb.ro>,
        <richard.genoud@gmail.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Topic: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Index: AQHYsg/cwUZrhBU4AEegbceOuhne8K20V5eAgAGfqgA=
Date:   Fri, 19 Aug 2022 09:25:57 +0000
Message-ID: <ddd8ca9a-1fc1-7d37-07e8-f6f7f4617eef@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <c1a98a3e-609e-7783-b1b7-3bb39caa8c65@linaro.org>
In-Reply-To: <c1a98a3e-609e-7783-b1b7-3bb39caa8c65@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 788732b1-e30b-4dc2-cb1c-08da81c4d2dc
x-ms-traffictypediagnostic: BN6PR11MB1619:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2mI0X0+Dh3w1gH/UDp2CfHXcGQAZqi7jtG/WYO2nbU3/uiTaC0KcqdFsjdH4MsINPqq9iVERdH9KEuxY8JEuTpImVSDvDgrzS11jajMMvQgOG+DRy0Rm9Wouml/KVjAXAU/CNMNK7cKFKQCrg6IQV3DrLLG2fTxDvFqjpR+avYSDx0ghlmo7LXmVwYV1wOKdOBoM1Syy/qTNAZlp+Upqd5KKS2vWgwdTRnFLgV10XsoTIppRSYhfwlsX5R/gVAQgwrlrE4sk864bzuUnU/NHV42+vx3ccb+tZiY9YcmvrQcAXSq+y9DfwywViOrcPxQQHXXpGPF2XMzH15pBkMxPsVS9Ysi4Gjyna55Kl6pn+LX7A3mS1WH/45oVVLR/ic4R0nRBBa2DLZtRMex5fVvrwqt+BmN5zRjrkBpcknb7jJHLWZsu3T5aRz1FzriudNOk9rK8R2NxCvbIoONBlMFUj3aakN4mmyAbv1xmncGRqE3E7NxT1TOm8qhjUIHnOEujNdGHKJXLrv7G0QstRfViti5cGU4wZ+HjkxGuvvv3b2XlN/6iQCTp5S/RZl8fi9nUabKho9XYPLPx1wUpIbaF0inxpc8xY0taXu/0vlsAyMCpnoiZGr7clGPrluluE1T59iZmmQtndm81/n3U3dyFyPEu6i5+p0TZu5d8eutbPv+JeBKok4yCjqxbRLJKWT+ETe89UdKw8UjbjS9AJVdX1TVXgX3YkAIwafzlWwTagCHBnk+J9ul3mBOjdlsvjcjWDCzVnJoOQOU9V7jtf7meLqWY/EjRJFTS23Cb4ETKnodwUMgnaYkzfM/T5L0bqnpY/3nKWGhkzdrToKlAbBISAjgCtBzgnnooqwl6R6jfoaF/k8aj2myQUFUk6YlNsLN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(376002)(366004)(396003)(186003)(2616005)(26005)(6506007)(6486002)(83380400001)(53546011)(5660300002)(8936002)(7416002)(36756003)(478600001)(31686004)(966005)(6512007)(71200400001)(41300700001)(86362001)(31696002)(38100700002)(38070700005)(921005)(66446008)(66946007)(4326008)(76116006)(66476007)(2906002)(110136005)(64756008)(8676002)(66556008)(316002)(122000001)(6636002)(91956017)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkhJZ3dZMjBUUnY0QXBVblVxNWcrV0tZRXFBMlZSQ2VrRUpoNlNQK0ppQTM2?=
 =?utf-8?B?US94T3NkRVF5ZldHcVFBM1ptWXR4WXFQRzB3V0gvSlJvS1NaMk52Zm01aUtD?=
 =?utf-8?B?QjMvd2RKWXNDdlJENStydjArTXN0MllCYU1ubW1HZzJGWDBYWFdSS1FIR21R?=
 =?utf-8?B?RzluRVhhR0dtR0d2dk5aaDlwdFhOaDkwNFpQNk91RkFUNTdoNk0rMW9vZWdw?=
 =?utf-8?B?a0lNZlJOaFlsYUhYTWtOSTRyWml1OW91ZGhoUEFDMXRTcXkzdzZxYkFaeVZP?=
 =?utf-8?B?bmdFTmdwOGdiM1JXTE4rcmhjOVIrMGpyYmlxZmdQVTQvelVJVjFjandCbkVp?=
 =?utf-8?B?T0h0UVczaC9GYVpoUGh4Y3o0SEFtNThiMUlPZGFTNmdDaHFoREQ1MkpvNFdr?=
 =?utf-8?B?Z21qNjRuem56aTN6TDFWSCtkU3Y0RUdyVktPaVRLVW9KcXNYYkZIYlFacFk1?=
 =?utf-8?B?UDFnMDhGYXcrTjF0ek91WTFEci9kSE5yZFE2M2VQOUIzdE5oaFhLQWFhcGZ1?=
 =?utf-8?B?RlJTKzEyaThEVVRTQmRwUFhLTlM4LzBvR0tIOTlHVlBPODRERnZvNjlLem8x?=
 =?utf-8?B?ZExCdis5dzZubW9EbXZrOWVxa0RJaEtOc1dSVi9ubU0ySm1hTHlQMDBpRlRN?=
 =?utf-8?B?bEViTDRpaWVhOVBlMnA5R2dIeUZxanBrNG5FMzJtRkVubTVCY2I1SC9RK0hr?=
 =?utf-8?B?b3lVN290aDl1eE5OUVhzb0tmcVZjaG01ZEs4NllUSXgvT3hiWWhHMDR0V0NT?=
 =?utf-8?B?SWN1bk5SV1BTMGI0aFFoRVl6L1Bvbk00MkEyUm0vbSs2L2t6dmNEdkdVcEFt?=
 =?utf-8?B?MDdCUWlmSkszQUZRcjV3SFU3Tm9RTWRtNEwvUlNWbmcvMnRkazc4Wm9VTWhQ?=
 =?utf-8?B?dkE3d2Y3cjJIdWxOZm9jSk9haXNVZkppbktZeEt4bUtJZ2JjNy9JaDRFMm1M?=
 =?utf-8?B?KzRPVWIzaE1iSGQ5czZWdHU0RkwxZGNKRWhDenpESVNyK1FaSWtISE1HQkNC?=
 =?utf-8?B?YUxKOXlSeHFpQnF6U3UwMHREelVMUm4vTDVka2pUVllqV1paSkJ2MmtUbitG?=
 =?utf-8?B?RmJUbzA1VUpwODRYcFBiRnBUWGVydUFVRmdNeVYwZC9qQ3hnVTNPZmxGZHls?=
 =?utf-8?B?cFoyM1lCemRJM3BZd1N0N2F2SmFKVTZSYUQ4aHpTeEk2R3l2M1NqVTlYU3py?=
 =?utf-8?B?VmV6Wk5jU01UbTU4UFAvUmQvSDJuZWxaM1JidUdNT28rc3JqZzV1VEhWcC90?=
 =?utf-8?B?Z3c4NTBrYkZvcWVXWlMvVXNEUEc0ejJYUTJjUXhVb3IyMU95RC9hNU5JY2xQ?=
 =?utf-8?B?Qk8wZ01TRk1EZTBlVDZCSnhVVm5wZWlDb3hTNzdsK1g0Tk5aNjU5TlR2N0dq?=
 =?utf-8?B?TDNmQSsyaDZ3UXBRUVgvYnFXODNEM0pSUTdIVzQzRjJQNkRwV0VUa2JwOWJj?=
 =?utf-8?B?MWpPTzFVMUkrZ1ZReFcwbXM5cGRUQk5YQ2REeFR2UnBXOVB6TG1mdUszeGRW?=
 =?utf-8?B?MXU4bnNoajhXV29tSC9UcHh1K2FiMEdaaFB3VStIbnpVamUrR0IwcW16QmZy?=
 =?utf-8?B?MGpvdzdmSzhiQkVvT2o0Y1hxY3BSV2x0Rk5US1JqWUZaMTVxUVZxUDdzYWdl?=
 =?utf-8?B?V2dMYnNyRGVnb3Zjam94T2kybHZMUXRINC9YWEVhOXE4eGFFNjVJWm5zRlFu?=
 =?utf-8?B?NWgzUW9tczRRNnE4aXIvSTlLVFBSREptZlIvNndyS1E0TmN5c25aSmcyTjVt?=
 =?utf-8?B?UmhlSkJmYXN4WHpRSC90M28xWExabFV1VmhFbVVUL3pkOG9vVGdUZnRLM1BJ?=
 =?utf-8?B?eWhnNGJTZjEvK0FJRnZCUDRLcXhBeXpWT05oQzMwNSt2SE1Ud0d4NFBhQ2RH?=
 =?utf-8?B?Qkc3aEd2bkRpVWRhRFZ2ODlwekhkbVhSeVMrWVlaeWFaU2hRcVVNa05FK0Y5?=
 =?utf-8?B?cjV0eVpGcis1eDJyZ24vNkNDa1kwSmtoREdZUFFYQ0s3cnFaOXdtZDMxL2g1?=
 =?utf-8?B?aGFKd0Z4a21DbzZmZENyT2lnUzVKdC9jR2lGb3VPcUF1VEgycUlHbng1UGxL?=
 =?utf-8?B?cUtDOEdlN2ZvTFdNandUVTZlbkpTUHJEcFhLRjA3eWduZWhnTnFDc3p2OW54?=
 =?utf-8?Q?oKM44Qy0tB/EaeU16PR5KgevS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3FFE349E52A294682133501E80A5638@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788732b1-e30b-4dc2-cb1c-08da81c4d2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 09:25:57.7292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpbDda9yV5GHu/qI96JuGGquBIxDYH4a48AlgMg29HcoygbmSp/XcV+8VA8J78IKjNwu907/ZB036FI1/8LxswnhkGkWr5dcP1dwAwqX9Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1619
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTguMDguMjAyMiAxMTozOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTcv
MDgvMjAyMiAxMDo1NSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBDb252ZXJ0IGF0OTEgVVNBUlQg
RFQgQmluZGluZyBmb3IgQXRtZWwvTWljcm9jaGlwIFNvQ3MgdG8NCj4+IGpzb24tc2NoZW1hIGZv
cm1hdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWlj
cm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvbWZkL2F0bWVsLGF0OTEtdXNh
cnQueWFtbCAgICAgICAgfCAxOTAgKysrKysrKysrKysrKysrKysrDQo+PiAgIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21mZC9hdG1lbC11c2FydC50eHQgICB8ICA5OCAtLS0tLS0tLS0NCj4+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAxOTAgaW5zZXJ0aW9ucygrKSwgOTggZGVsZXRpb25zKC0pDQo+PiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZk
L2F0bWVsLGF0OTEtdXNhcnQueWFtbA0KPj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC11c2FydC50eHQNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkx
LXVzYXJ0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVs
LGF0OTEtdXNhcnQueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAw
MDAwMDAwMC4uY2YxNWQ3M2ZhMWU4DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGF0OTEtdXNhcnQueWFtbA0KPj4g
QEAgLTAsMCArMSwxOTAgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICsjIENvcHlyaWdodCAoQykgMjAyMiBNaWNyb2No
aXAgVGVjaG5vbG9neSwgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyVZQU1MIDEuMg0K
Pj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWZkL2F0bWVs
LGF0OTEtdXNhcnQueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQXRtZWwgVW5pdmVyc2FsIFN5
bmNocm9ub3VzIEFzeW5jaHJvbm91cyBSZWNlaXZlci9UcmFuc21pdHRlciAoVVNBUlQpDQo+PiAr
DQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIFJpY2hhcmQgR2Vub3VkIDxyaWNoYXJkLmdlbm91
ZEBnbWFpbC5jb20+DQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+
PiArICAgIG9uZU9mOg0KPiBUaGlzIGxvb2tzIHF1aXRlIGRpZmZlcmVudCB0aGFuIGJpbmRpbmdz
IGFuZCB5b3UgY29tbWl0IG1zZyBpcyBzYXlpbmcgaXQNCj4gaXMgb25seSBhIGNvbnZlcnNpb24u
IE1lbnRpb24gYW55IGNoYW5nZXMgYWdhaW5zdCBvcmlnaW5hbCBiaW5kaW5ncy4NCj4NCj4+ICsg
ICAgICAtIGNvbnN0OiBhdG1lbCxhdDkxcm05MjAwLXVzYXJ0DQo+PiArICAgICAgLSBjb25zdDog
YXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQNCj4+ICsgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2Ft
OXg2MC11c2FydA0KPiBUaGF0J3MgYW4gZW51bQ0KPg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiAr
ICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFybTkyMDAtZGJndQ0KPj4gKyAgICAgICAgICAt
IGNvbnN0OiBhdG1lbCxhdDkxcm05MjAwLXVzYXJ0DQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsg
ICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTkyNjAtZGJndQ0KPj4gKyAgICAgICAgICAt
IGNvbnN0OiBhdG1lbCxhdDkxc2FtOTI2MC11c2FydA0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiAr
ICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05eDYwLWRiZ3UNCj4+ICsgICAgICAgICAg
LSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtdXNhcnQNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4g
KyAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MC11c2FydA0KPj4gKyAgICAgICAg
ICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOTI2MC11c2FydA0KPiBUaGlzIGlzIG5vdCBjb3JyZWN0
IC0gY29udHJhZGljdHMgZWFybGllciBvbmUuDQo+DQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsg
ICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtZGJndQ0KPj4gKyAgICAgICAgICAt
IGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MC11c2FydA0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBh
dG1lbCxhdDkxc2FtOTI2MC1kYmd1DQo+PiArICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFz
YW05MjYwLXVzYXJ0DQo+IFdoYXQ/IFlvdSB3cm90ZSBhYm92ZSB0aGF0IG1pY3JvY2hpcCxzYW05
eDYwLWRiZ3UgaXMgY29tcGF0aWJsZSBvbmx5DQo+IHdpdGggbWljcm9jaGlwLHNhbTl4NjAtdXNh
cnQuIE5vdyB5b3Ugd3JpdGUgaXQgaXMgYWxzbyBjb21wYXRpYmxlIHdpdGgNCj4gb3RoZXIgb25l
cz8NCj4NCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsg
IGludGVycnVwdHM6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBjbG9jay1uYW1l
czoNCj4+ICsgICAgY29udGFpbnM6DQo+PiArICAgICAgY29uc3Q6IHVzYXJ0DQo+IE5vLCB0aGlz
IGhhcyB0byBiZSBzcGVjaWZpYy9maXhlZCBsaXN0Lg0KPg0KPj4gKw0KPj4gKyAgY2xvY2tzOg0K
Pj4gKyAgICBtaW5JdGVtczogMQ0KPj4gKyAgICBtYXhJdGVtczogMg0KPiBOb3QgcmVhbGx5IC0g
ZGVmaW5lIHRoZSBpdGVtcy4gT25lIGl0ZW0gY291bGQgYmUgb3B0aW9uYWwsIHRob3VnaC4NCj4N
Cj4+ICsNCj4+ICsgIGRtYXM6DQo+PiArICAgIGl0ZW1zOg0KPj4gKyAgICAgIC0gZGVzY3JpcHRp
b246IFRYIERNQSBDaGFubmVsDQo+PiArICAgICAgLSBkZXNjcmlwdGlvbjogUlggRE1BIENoYW5u
ZWwNCj4+ICsNCj4+ICsgIGRtYS1uYW1lczoNCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBj
b25zdDogdHgNCj4+ICsgICAgICAtIGNvbnN0OiByeA0KPj4gKw0KPj4gKyAgYXRtZWwsdXNhcnQt
bW9kZToNCj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWlu
dDMyDQo+PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+IE5vIG5lZWQgZm9yIHwNCj4NCj4+ICsgICAg
ICBNdXN0IGJlIGVpdGhlciAxIGZvciBTUEkgb3IgMCBmb3IgVVNBUlQuDQo+IE1lbnRpb24gdGhl
IGhlYWRlci4NCj4NCj4+ICsgICAgZW51bTogWyAwLCAxIF0NCj4+ICsNCj4+ICtyZXF1aXJlZDoN
Cj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsgIC0gaW50ZXJydXB0cw0KPj4g
KyAgLSBjbG9jay1uYW1lcw0KPj4gKyAgLSBjbG9ja3MNCj4+ICsNCj4+ICtpZjoNCj4gUHV0IGl0
IHVuZGVyIGFsbE9mLg0KDQoNCkkgbWlzc2VkIHRoaXMgaW4gdGhlIGZpcnN0IHJlYWQsIGJ1dCB3
aGF0IGRvIHlvdSBtZWFuIGJ5IHVuZGVyIGFsbE9mPyANClRoZSBvbmx5IGFsbE9mJ3MgaW4gdGhp
cyBmaWxlIGFyZSB1bmRlciB0aGUgdGhlbjoncy4NCg0KDQo+PiArICBwcm9wZXJ0aWVzOg0KPj4g
KyAgICAkbm9kZW5hbWU6DQo+PiArICAgICAgcGF0dGVybjogIl5zZXJpYWxAWzAtOWEtZl0rJCIN
Cj4+ICt0aGVuOg0KPj4gKyAgYWxsT2Y6DQo+PiArICAgIC0gJHJlZjogL3NjaGVtYXMvc2VyaWFs
L3NlcmlhbC55YW1sIw0KPj4gKyAgICAtICRyZWY6IC9zY2hlbWFzL3NlcmlhbC9yczQ4NS55YW1s
Iw0KPj4gKw0KPj4gKyAgcHJvcGVydGllczoNCj4+ICsgICAgYXRtZWwsdXNlLWRtYS1yeDoNCj4+
ICsgICAgICB0eXBlOiBib29sZWFuDQo+PiArICAgICAgZGVzY3JpcHRpb246IHVzZSBvZiBQREMg
b3IgRE1BIGZvciByZWNlaXZpbmcgZGF0YQ0KPj4gKw0KPj4gKyAgICBhdG1lbCx1c2UtZG1hLXR4
Og0KPj4gKyAgICAgIHR5cGU6IGJvb2xlYW4NCj4+ICsgICAgICBkZXNjcmlwdGlvbjogdXNlIG9m
IFBEQyBvciBETUEgZm9yIHRyYW5zbWl0dGluZyBkYXRhDQo+PiArDQo+PiArICAgIGF0bWVsLGZp
Zm8tc2l6ZToNCj4+ICsgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCj4+ICsgICAgICBkZXNjcmlwdGlvbjogfA0KPiBObyBuZWVkIGZvciB8DQo+DQo+
PiArICAgICAgICBNYXhpbXVtIG51bWJlciBvZiBkYXRhIHRoZSBSWCBhbmQgVFggRklGT3MgY2Fu
IHN0b3JlIGZvciBGSUZPDQo+PiArICAgICAgICBjYXBhYmxlIFVTQVJUUy4NCj4+ICsgICAgICBl
bnVtOiBbIDE2LCAzMiBdDQo+PiArDQo+PiArZWxzZToNCj4+ICsgIGlmOg0KPj4gKyAgICBwcm9w
ZXJ0aWVzOg0KPj4gKyAgICAgICRub2RlbmFtZToNCj4+ICsgICAgICAgIHBhdHRlcm46ICJec3Bp
QFswLTlhLWZdKyQiDQo+PiArICB0aGVuOg0KPj4gKyAgICBhbGxPZjoNCj4+ICsgICAgICAtICRy
ZWY6IC9zY2hlbWFzL3NwaS9zcGktY29udHJvbGxlci55YW1sIw0KPj4gKw0KPj4gKyAgICBwcm9w
ZXJ0aWVzOg0KPj4gKyAgICAgIGF0bWVsLHVzYXJ0LW1vZGU6DQo+PiArICAgICAgICBjb25zdDog
MQ0KPj4gKw0KPj4gKyAgICAgICIjc2l6ZS1jZWxscyI6DQo+PiArICAgICAgICBjb25zdDogMA0K
Pj4gKw0KPj4gKyAgICAgICIjYWRkcmVzcy1jZWxscyI6DQo+PiArICAgICAgICBjb25zdDogMQ0K
Pj4gKw0KPj4gKyAgICByZXF1aXJlZDoNCj4+ICsgICAgICAtIGF0bWVsLHVzYXJ0LW1vZGUNCj4+
ICsgICAgICAtICIjc2l6ZS1jZWxscyINCj4+ICsgICAgICAtICIjYWRkcmVzcy1jZWxscyINCj4+
ICsNCj4+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+PiArDQo+PiArZXhhbXBsZXM6
DQo+PiArICAtIHwNCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0K
Pj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+
DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9tZmQvYXQ5MS11c2FydC5oPg0KPj4gKyAg
ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZG1hL2F0OTEuaD4NCj4+ICsNCj4+ICsgICAgLyogdXNl
IFBEQyAqLw0KPj4gKyAgICB1c2FydDA6IHNlcmlhbEBmZmY4YzAwMCB7DQo+PiArICAgICAgICBj
b21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0IjsNCj4+ICsgICAgICAgIHJlZyA9
IDwweGZmZjhjMDAwIDB4NDAwMD47DQo+PiArICAgICAgICBpbnRlcnJ1cHRzID0gPDc+Ow0KPj4g
KyAgICAgICAgY2xvY2tzID0gPCZ1c2FydDBfY2xrPjsNCj4+ICsgICAgICAgIGNsb2NrLW5hbWVz
ID0gInVzYXJ0IjsNCj4+ICsgICAgICAgIGF0bWVsLHVzZS1kbWEtcng7DQo+PiArICAgICAgICBh
dG1lbCx1c2UtZG1hLXR4Ow0KPj4gKyAgICAgICAgcnRzLWdwaW9zID0gPCZwaW9EIDE1IEdQSU9f
QUNUSVZFX0xPVz47DQo+PiArICAgICAgICBjdHMtZ3Bpb3MgPSA8JnBpb0QgMTYgR1BJT19BQ1RJ
VkVfTE9XPjsNCj4+ICsgICAgICAgIGR0ci1ncGlvcyA9IDwmcGlvRCAxNyBHUElPX0FDVElWRV9M
T1c+Ow0KPj4gKyAgICAgICAgZHNyLWdwaW9zID0gPCZwaW9EIDE4IEdQSU9fQUNUSVZFX0xPVz47
DQo+PiArICAgICAgICBkY2QtZ3Bpb3MgPSA8JnBpb0QgMjAgR1BJT19BQ1RJVkVfTE9XPjsNCj4+
ICsgICAgICAgIHJuZy1ncGlvcyA9IDwmcGlvRCAxOSBHUElPX0FDVElWRV9MT1c+Ow0KPj4gKyAg
ICB9Ow0KPj4gKw0KPj4gKyAgLSB8DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlv
L2dwaW8uaD4NCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9s
bGVyL2lycS5oPg0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvbWZkL2F0OTEtdXNhcnQu
aD4NCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2RtYS9hdDkxLmg+DQo+PiArDQo+PiAr
ICAgIC8qIHVzZSBETUEgKi8NCj4+ICsgICAgdXNhcnQxOiBzZXJpYWxAZjAwMWMwMDAgew0KPj4g
KyAgICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCI7DQo+PiArICAg
ICAgICByZWcgPSA8MHhmMDAxYzAwMCAweDEwMD47DQo+PiArICAgICAgICBpbnRlcnJ1cHRzID0g
PDEyIElSUV9UWVBFX0xFVkVMX0hJR0ggNT47DQo+PiArICAgICAgICBjbG9ja3MgPSA8JnVzYXJ0
MF9jbGs+Ow0KPj4gKyAgICAgICAgY2xvY2stbmFtZXMgPSAidXNhcnQiOw0KPj4gKyAgICAgICAg
YXRtZWwsdXNlLWRtYS1yeDsNCj4+ICsgICAgICAgIGF0bWVsLHVzZS1kbWEtdHg7DQo+PiArICAg
ICAgICBkbWFzID0gPCZkbWEwIDIgQVQ5MV9ETUFfQ0ZHX1BFUl9JRCgzKT4sDQo+PiArICAgICAg
ICAgICAgICAgPCZkbWEwIDIgKEFUOTFfRE1BX0NGR19QRVJfSUQoNCkgfCBBVDkxX0RNQV9DRkdf
RklGT0NGR19BU0FQKT47DQo+PiArICAgICAgICBkbWEtbmFtZXMgPSAidHgiLCAicngiOw0KPj4g
KyAgICAgICAgYXRtZWwsZmlmby1zaXplID0gPDMyPjsNCj4+ICsgICAgfTsNCj4+ICsNCj4+ICsg
IC0gfA0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+PiArICAg
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4+ICsg
ICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL21mZC9hdDkxLXVzYXJ0Lmg+DQo+PiArICAgICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9kbWEvYXQ5MS5oPg0KPj4gKw0KPj4gKyAgICAvKiBTUEkgbW9kZSAq
Lw0KPj4gKyAgICBzcGkwOiBzcGlAZjAwMWMwMDAgew0KPj4gKyAgICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8MT47DQo+PiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4+ICsgICAgICAgIGNv
bXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiOw0KPj4gKyAgICAgICAgYXRtZWws
dXNhcnQtbW9kZSA9IDxBVDkxX1VTQVJUX01PREVfU1BJPjsNCj4+ICsgICAgICAgIHJlZyA9IDww
eGYwMDFjMDAwIDB4MTAwPjsNCj4gY29tcGF0aWJsZSwgdGhlbiByZWcgdGhlbiB0aGUgcmVzZXQg
b2YgcHJvcGVydGllcw0KPg0KPj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDwxMiBJUlFfVFlQRV9M
RVZFTF9ISUdIIDU+Ow0KPj4gKyAgICAgICAgY2xvY2tzID0gPCZ1c2FydDBfY2xrPjsNCj4+ICsg
ICAgICAgIGNsb2NrLW5hbWVzID0gInVzYXJ0IjsNCj4+ICsgICAgICAgIGRtYXMgPSA8JmRtYTAg
MiBBVDkxX0RNQV9DRkdfUEVSX0lEKDMpPiwNCj4+ICsgICAgICAgICAgICAgICA8JmRtYTAgMiAo
QVQ5MV9ETUFfQ0ZHX1BFUl9JRCg0KSB8IEFUOTFfRE1BX0NGR19GSUZPQ0ZHX0FTQVApPjsNCj4+
ICsgICAgICAgIGRtYS1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+PiArICAgICAgICBjcy1ncGlvcyA9
IDwmcGlvQiAzIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4gKyAgICB9Ow0KPiBCZXN0IHJlZ2FyZHMs
DQo+IEtyenlzenRvZg0KDQoNClJlZ2FyZHMsDQogwqDCoMKgIFNlcmdpdQ0KDQo=
