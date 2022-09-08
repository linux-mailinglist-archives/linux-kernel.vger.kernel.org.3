Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821525B1502
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIHGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiIHGrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:47:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F5BD277C;
        Wed,  7 Sep 2022 23:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662619634; x=1694155634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZjqtsF450Qdg9iGW/mqEISK33RhzoHVIR8+aRiid/iE=;
  b=rm1hJMQ0Tuxi/YBECbSgGILqWHrhTC/bONspXOt5/boSNRHfEW1rrGsO
   m+oGxMA9B2m4v4WDayfQ2qCCRrO0QYZL5lqqA4c63E8KJiICX2Xx6WUGo
   ceAbVOzbr5QiVUM/82P0jDbasILr4wtaJTjRRImKrV6dIh6BJld17DIKG
   hldsLpj24XdlCa1lyuwjijLACjm2s1+8dyMy/uA67WMYfOH3hdjVA2PQv
   KBciJZhVeXcW8pBOtuWktwoTaXLioj90FYjirLZ1O7yGkrdakJabpTkVT
   6cJhO0LGgoGdfc9PpqULVXcQBQsOWYVsh0qrcXCYKucppkNUJtBdge1lP
   w==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="179519178"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:47:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:47:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 23:47:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7Q7c6HimiwUQ2215V3pyk6U3ixQqA6A2ylgyCePB21JfiGgqFqnzzms6yrVPd5A3snxWZBJx8zi4cWdtg/8SzgHBiOpp0q3p14zDDI1XW82x1hq7H0otMDclZ/DG0T/0zUrCWZqEtQ37AfpNK4zXXErlsZ/aXFe8PrMEmNZtaTpgRDszu3VfvTzd8pX7w7seZvshg9FfILThXABrcY/j+Z+c0Pf6M43bktEinbi6np1bHToNK/ig3h0Nv5PbhH7VaRqUah27JAas237bJFyNFA09/Q5eQfqwzj2Rn9q2nPCzije/24MxZ9L/0vBmez+wECvXPfkLavOwOhV8ai28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjqtsF450Qdg9iGW/mqEISK33RhzoHVIR8+aRiid/iE=;
 b=foSIx1PyWlHXIiDQy5jD/WWS2YdAPogHK9RTcRitIww/HHXRPB16AwUc4MTuvDyfjkAhZ7g1s4SfpraAdY+o4yOdhieHWdhaZXJd10/XVwPJUU6qDX4FAGBQ0b/BVTKnpOstVFdrdZoRqLnIOmyVmzKelfo62mh56CAQ5AmdYBEd1fIvKGbKAZPC2CwUW3d6dXeL9cyM7YOVOsupRsXtgJibRnGc7/cb5HNkUlwgEc/j90WILvyMPvRUHVGrq5McV2Y01vwTzOSQAzt8RJoa4FwjSVlDu6JLtYfqCQBvWFfQm8Qv2+NlJGgQBIXEumn5aidcN6apYae4Yfhk04XjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjqtsF450Qdg9iGW/mqEISK33RhzoHVIR8+aRiid/iE=;
 b=O6DU3pUIjYW7scwFevmrG1t7xJ2H9FUO6n8wq3+nL5iW4TvMOZvbkORAqvQQMPqJJeza1fpP5WaRC/egJ/MHq8ZcO0dtQmvwi3sEogFAXkdpq7UsiJziwPzDAXIXuSIC5QQGVQVEBH9nO4yWg629C1Ltk885vi8bbd8N73gyWzk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 06:47:04 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 06:47:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 10/13] clk: microchip: mpfs: delete 2 line
 mpfs_clk_register_foo()
Thread-Topic: [PATCH v4 10/13] clk: microchip: mpfs: delete 2 line
 mpfs_clk_register_foo()
Thread-Index: AQHYw07OWw/as+GhH0+GX4/bCdS+hg==
Date:   Thu, 8 Sep 2022 06:47:04 +0000
Message-ID: <ac348009-97bd-919c-3b1a-b12c4d7d5153@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-10-conor.dooley@microchip.com>
In-Reply-To: <20220830125249.2373416-10-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edbd3699-bfb6-4280-67f6-08da9165f0e7
x-ms-traffictypediagnostic: PH7PR11MB5766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: in80HUn4Xwx9Gbag5MpHrxACBv0WQeH45vxemAH7GIkKOfo9mRzjTIfZnvFHjLMg4Oy0Oe2lpBG/C/IugPsc+jafvQkOg488YIX28wtgNJuXYsJsv0Zv8Mr1ciJjt7B3OKzq2S0blKVoMhi7feM/LAXVqt6La1QLLqp/bRkP5+J0d2kGYGo1S39ocgviT8u1/L128feJbvchLOvJh99dK9v9x9wqCCb0Mxlq+gYv8fpsKV8f26BtDmQNZ4/E14T4X2JoW0NscMIy3OJ9UHbxGV5+warKB43VY71wSvg/ENinlakFeDmH17KAKEsqd+nMITWHvRMfEuhyclr5hZhEgnUoPhSfgUsE/qEugSqyfd7TWXrEBR4P8VMxVzDsQzErFkD7/huVxvYGJ12vUIdpWZqcB/Y6KNqwP5DtT5p60MTCcptzqFSZO1zVnsEiwubM5/5bDzfUdE15HSv8rOR9X0k4J51vAzsO+EK7vJ9O006U+ezCsnYF/oi/saWQqAnwh8Hq5IINtmZBwk2MupUi3RKoYx8+pQpwK2nJI84ZsTaSUXERa/iDvtf1j/UVNJQN5F+DPbJIubCl4v3x/gkHuE3zE5c8yhsjYwbIadr3PLlqRrARUs9nJBomp9J7sOx0Du6a9/I9r8hQ45k535Qg/7u8qD4f8tAnVMuBXx0wZzfN+KZlKmaFC8NSJw+P3VATq5j+kFrZ2YaoMYwJobg5IDoJrKaxLt/nRiaq1mBhUpulfnl3FMZ04ZL+uOvE2x939NnNCHvnw5jJ4poLSUF5Mu50tdumLh8HR28dGrzhb2Ye2ZFe8TnvqhHIoFK9K4vW4lqlMpcgmMCrXArQn5+WEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(66556008)(110136005)(316002)(2906002)(6636002)(83380400001)(6512007)(53546011)(6506007)(478600001)(54906003)(26005)(7416002)(5660300002)(38070700005)(31696002)(36756003)(86362001)(8936002)(66476007)(91956017)(66446008)(66946007)(64756008)(8676002)(31686004)(122000001)(4326008)(186003)(71200400001)(41300700001)(38100700002)(76116006)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z21wZXZDdDFUL2ZpWnh3MkJDZzJnTDhWcVp1eEVlM04vSnpod283Q0FCbjRV?=
 =?utf-8?B?bXRvQWV3aVZ3bmQ3Ym1YNVRLdWpVdFEzTzFvRnVtOHVCSVlQcFZxOGNwVjBW?=
 =?utf-8?B?dnk4YXN5ZXhuTWN2ZFVkUVhlN3JVZ3Myd21sSXpDelcydXBldWd2L0hscnR0?=
 =?utf-8?B?RFZleFk3QVR1UVlKYUdxSzZwUGF2VTh6ZWwrUWFFcWRKWjdlbFF1ZjgyUU9p?=
 =?utf-8?B?VDN0SmpJaGlGZHBqM3NaeWlCUkYvRy9sYWFwbnM3endPeUpGMzV4TWh6aDdS?=
 =?utf-8?B?NGFqdWtvYmFyZzU1M0pmbVFsak5nQkFpZ1FpZEx6MTlYQTZldm94RGVZQ2J0?=
 =?utf-8?B?RExvSTNZZm8xb0pmVVhmVnZUTklsYzZMODZMc1A3bkR4MWN1YUwyODBYZksx?=
 =?utf-8?B?QW5CN0FVeWFXMHIraERCeFlsZTM4ZjNtT1lpUlIwY2xZcUMrNHlFdWFrK3Na?=
 =?utf-8?B?UjlUcVdSellNeWxOOGRWSmVvSHY4KzBSdjNkVi9odDJNUjA1dkJnNTJwS2Nn?=
 =?utf-8?B?eXZuVTd3VmkxOVFHQWptM2Z3TEY0blVoSkd3WjFhRTdjYXUzSlN2QWpEU014?=
 =?utf-8?B?Wmo4NksvWXk3NVd2ZWxvODQzSFJwaXNJWnhRdElNaTFCeWFXOWwwc21GSFFG?=
 =?utf-8?B?aW1uNEdMSXoxSXAra1hBd2M3eWVldFdwR3BYNzJCNm1nS3FrOFVoZ0lRRlZm?=
 =?utf-8?B?NXRnNU8wSnRPM3pWeDY2S1F6NmtKR2c0VW5WblAwaVI2OXJWMTRpbGZGMWlx?=
 =?utf-8?B?ZjZheTV5UkJHcUE1djh3eWJuNHhpN0pQbk5SbXczWFlCNDE3R0J1SzBTWUdE?=
 =?utf-8?B?ZSt0eStQYWE4ZnJ6ckpyZGNUQmt4V2tNZUhRazBmOS9TZVpLSWhNODQ2eUk4?=
 =?utf-8?B?elB6dUlLY1krUmc4T0hmSXNIV0J3eXBKd3NuZFBWNFJCYkJlZHpLL3RiTWU2?=
 =?utf-8?B?eHQ4WFViN1AxcWVEUnBXVGJCMkNuT0Y3L0Ntd0JaeEtWajNiQ0pjeTRDT243?=
 =?utf-8?B?Y2VlZGUyb1JiTmlESnZaS3BJWDhjd3VKOXZva3dXVWkycFhkYTFSQTBCZlEx?=
 =?utf-8?B?SDY0bUxvd0dkbHptNGhWT212QWlwYnVsZGdleFZ2VWdDNUZmRzdNN1pVZmJG?=
 =?utf-8?B?bSszTGcva3JGZUFZajU1NzRvcWJnY2s0T2dIQ1RaazJXbEFMcVg1bUIrYk1V?=
 =?utf-8?B?YjByN0dOa1YwMDZ5OVVKZzNseVA1SHd0eUNZdUZmRHExa1UzT1E4NFFGNmFk?=
 =?utf-8?B?QTlENlFzQTEvNC9ZbVpReGdJSzFXb3RhYlovZmpvVmdrdzJZQk9BMjZOdTVk?=
 =?utf-8?B?TklOSDdHQUtuNDQ0eUVuVmRsdlEyejFVVStxWWh0Q2JwaE1sWjE5SUlySkZB?=
 =?utf-8?B?ZHNnMVhYVTlYODJGMENob1VtVmQ0OCtoR2pXWTVXTEw5RkRDcUhkUVk3T3pL?=
 =?utf-8?B?bmVKeFREcnE3TFFOb2dRZVpRSUpnQUp1WU5QaS8wUml1ZW00bSt2WDVBbUlH?=
 =?utf-8?B?ZUJRYTBCaTJQVDFxY05jY2ZlRlFFRk1JMHk3VjVoQnFkUkZIclRHQ1JPaTNP?=
 =?utf-8?B?SU1NRVJBSlF5Y2p2cmtQVGFIa2xkU2JzVTZlSDQyWEFkcE5QZEdBOWk5QlZL?=
 =?utf-8?B?N1dvdGFJejlIUVFTQWNrOWRmNVVvek1UOXdWcmRlUEVzYlpzY2tCVFBVT0I3?=
 =?utf-8?B?ZnRRWDZYb1dWWkYzS2dFejN4RkZEODJ4b1JQRW43MkR0TkwyRWJmSlNYMWVB?=
 =?utf-8?B?RjhaK0xuMnhGcmFLUldsV0xCcEU0S0w5RUVvWU84S3VudXo2bVJMaG40M05Z?=
 =?utf-8?B?OWhZdDFvZVVMNUhSUFN4K0htbXU2TVU3Y29VLzN4OEtwQ2lCcCsxYkM5SWYy?=
 =?utf-8?B?R1dLY29VSXMycWhlK2o4dkZILy95cGNMYUx2YTVQN0xnRUdXK3I1NUo2T29o?=
 =?utf-8?B?VjFvQ1NTWlZCb2dnR0NqTFVSY0hoT0orcWs2MVpFTVE1WWJaZXlXR2hldlRy?=
 =?utf-8?B?djRaa0Rld1cvWGRod0dZZ0R2RTZvZXRHOFB2cFdwcmxVOXBKRWZqTHpJdFJM?=
 =?utf-8?B?UWdaSithWWdhcXJWTlg2M1o3c3RRbDRvSEJzY0p0VWNtRWhYc3ZWRXYvUWtR?=
 =?utf-8?B?TkNrcUZ0LzRZYUs0WVV3cnFPVTRDZ2x3dHBmTnFrNmJqVGxMYTBhcGZkaXRr?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37BDF25920C0A34AA2FA4804A32B752D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbd3699-bfb6-4280-67f6-08da9165f0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:47:04.5299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjdGMbBlE+k7yI/jJMf+wuTob01Od/m/Wuk5pqCGqGgBFDqz28OsXAaiVWrJJTBJoQ4hqcWg85ofedMAhujKM40j0k7H4vNwiTEdA2p3WTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDguMjAyMiAxNTo1MiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBUaGUgcmVnaXN0ZXIg
ZnVuY3Rpb25zIGFyZSBub3cgY29tcHJpc2VkIG9mIG9ubHkgYSBzaW5nbGUgb3BlcmF0aW9uDQo+
IGVhY2ggYW5kIG5vIGxvbmdlciBhZGQgYW55dGhpbmcgdG8gdGhlIGRyaXZlci4gRGVsZXRlIHRo
ZW0uDQo+IA0KPiBSZXZpZXdlZC1ieTogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFtYXJhQG1p
Y3JvY2hpcC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5
QG1pY3JvY2hpcC5jb20+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvbWljcm9jaGlw
L2Nsay1tcGZzLmMgfCAzMyArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLmMgYi9kcml2ZXJzL2Nsay9t
aWNyb2NoaXAvY2xrLW1wZnMuYw0KPiBpbmRleCA2MGUxZTgyOTEyZmUuLjUzOGNiNTg5ZDIzMiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLmMNCj4gKysrIGIv
ZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLmMNCj4gQEAgLTIwMywxNCArMjAzLDYgQEAg
c3RhdGljIHN0cnVjdCBtcGZzX21zc3BsbF9od19jbG9jayBtcGZzX21zc3BsbF9jbGtzW10gPSB7
DQo+ICAJCU1TU1BMTF9GQkRJVl9XSURUSCwgMCwgUkVHX01TU1BMTF9TU0NHXzJfQ1IpLA0KPiAg
fTsNCj4gIA0KPiAtc3RhdGljIGludCBtcGZzX2Nsa19yZWdpc3Rlcl9tc3NwbGwoc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgbXBmc19tc3NwbGxfaHdfY2xvY2sgKm1zc3BsbF9odywNCj4gLQkJ
CQkgICAgdm9pZCBfX2lvbWVtICpiYXNlKQ0KPiAtew0KPiAtCW1zc3BsbF9ody0+YmFzZSA9IGJh
c2U7DQo+IC0NCj4gLQlyZXR1cm4gZGV2bV9jbGtfaHdfcmVnaXN0ZXIoZGV2LCAmbXNzcGxsX2h3
LT5odyk7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyBpbnQgbXBmc19jbGtfcmVnaXN0ZXJfbXNzcGxs
cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtcGZzX21zc3BsbF9od19jbG9jayAqbXNzcGxs
X2h3cywNCj4gIAkJCQkgICAgIHVuc2lnbmVkIGludCBudW1fY2xrcywgc3RydWN0IG1wZnNfY2xv
Y2tfZGF0YSAqZGF0YSkNCj4gIHsNCj4gQEAgLTIyMCw3ICsyMTIsOCBAQCBzdGF0aWMgaW50IG1w
ZnNfY2xrX3JlZ2lzdGVyX21zc3BsbHMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXBmc19t
c3NwbGxfaHdfYw0KPiAgCWZvciAoaSA9IDA7IGkgPCBudW1fY2xrczsgaSsrKSB7DQo+ICAJCXN0
cnVjdCBtcGZzX21zc3BsbF9od19jbG9jayAqbXNzcGxsX2h3ID0gJm1zc3BsbF9od3NbaV07DQo+
ICANCj4gLQkJcmV0ID0gbXBmc19jbGtfcmVnaXN0ZXJfbXNzcGxsKGRldiwgbXNzcGxsX2h3LCBk
YXRhLT5tc3NwbGxfYmFzZSk7DQo+ICsJCW1zc3BsbF9ody0+YmFzZSA9IGRhdGEtPm1zc3BsbF9i
YXNlOw0KPiArCQlyZXQgPSBkZXZtX2Nsa19od19yZWdpc3RlcihkZXYsICZtc3NwbGxfaHctPmh3
KTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAi
ZmFpbGVkIHRvIHJlZ2lzdGVyIG1zc3BsbCBpZDogJWRcbiIsDQo+ICAJCQkJCSAgICAgQ0xLX01T
U1BMTCk7DQo+IEBAIC0zMTQsMTQgKzMwNyw2IEBAIHN0YXRpYyBzdHJ1Y3QgbXBmc19jZmdfaHdf
Y2xvY2sgbXBmc19jZmdfY2xrc1tdID0gew0KPiAgCX0NCj4gIH07DQo+ICANCj4gLXN0YXRpYyBp
bnQgbXBmc19jbGtfcmVnaXN0ZXJfY2ZnKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1wZnNf
Y2ZnX2h3X2Nsb2NrICpjZmdfaHcsDQo+IC0JCQkJIHZvaWQgX19pb21lbSAqYmFzZSkNCj4gLXsN
Cj4gLQljZmdfaHctPmNmZy5yZWcgPSBiYXNlICsgY2ZnX2h3LT5yZWdfb2Zmc2V0Ow0KPiAtDQo+
IC0JcmV0dXJuIGRldm1fY2xrX2h3X3JlZ2lzdGVyKGRldiwgJmNmZ19ody0+aHcpOw0KPiAtfQ0K
PiAtDQo+ICBzdGF0aWMgaW50IG1wZnNfY2xrX3JlZ2lzdGVyX2NmZ3Moc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgbXBmc19jZmdfaHdfY2xvY2sgKmNmZ19od3MsDQo+ICAJCQkJICB1bnNpZ25l
ZCBpbnQgbnVtX2Nsa3MsIHN0cnVjdCBtcGZzX2Nsb2NrX2RhdGEgKmRhdGEpDQo+ICB7DQo+IEBA
IC0zMzEsNyArMzE2LDggQEAgc3RhdGljIGludCBtcGZzX2Nsa19yZWdpc3Rlcl9jZmdzKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IG1wZnNfY2ZnX2h3X2Nsb2NrICoNCj4gIAlmb3IgKGkgPSAw
OyBpIDwgbnVtX2Nsa3M7IGkrKykgew0KPiAgCQlzdHJ1Y3QgbXBmc19jZmdfaHdfY2xvY2sgKmNm
Z19odyA9ICZjZmdfaHdzW2ldOw0KPiAgDQo+IC0JCXJldCA9IG1wZnNfY2xrX3JlZ2lzdGVyX2Nm
ZyhkZXYsIGNmZ19odywgZGF0YS0+YmFzZSk7DQo+ICsJCWNmZ19ody0+Y2ZnLnJlZyA9IGRhdGEt
PmJhc2UgKyBjZmdfaHctPnJlZ19vZmZzZXQ7DQo+ICsJCXJldCA9IGRldm1fY2xrX2h3X3JlZ2lz
dGVyKGRldiwgJmNmZ19ody0+aHcpOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJcmV0dXJuIGRldl9l
cnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8gcmVnaXN0ZXIgY2xvY2sgaWQ6ICVkXG4iLA0K
PiAgCQkJCQkgICAgIGNmZ19ody0+aWQpOw0KPiBAQCAtNDU0LDE0ICs0NDAsNiBAQCBzdGF0aWMg
c3RydWN0IG1wZnNfcGVyaXBoX2h3X2Nsb2NrIG1wZnNfcGVyaXBoX2Nsa3NbXSA9IHsNCj4gIAlD
TEtfUEVSSVBIKENMS19DRk0sICJjbGtfcGVyaXBoX2NmbSIsIFBBUkVOVF9DTEsoQUhCKSwgMjks
IDApLA0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGludCBtcGZzX2Nsa19yZWdpc3Rlcl9wZXJpcGgo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXBmc19wZXJpcGhfaHdfY2xvY2sgKnBlcmlwaF9o
dywNCj4gLQkJCQkgICAgdm9pZCBfX2lvbWVtICpiYXNlKQ0KPiAtew0KPiAtCXBlcmlwaF9ody0+
cGVyaXBoLnJlZyA9IGJhc2UgKyBSRUdfU1VCQkxLX0NMT0NLX0NSOw0KPiAtDQo+IC0JcmV0dXJu
IGRldm1fY2xrX2h3X3JlZ2lzdGVyKGRldiwgJnBlcmlwaF9ody0+aHcpOw0KPiAtfQ0KPiAtDQo+
ICBzdGF0aWMgaW50IG1wZnNfY2xrX3JlZ2lzdGVyX3BlcmlwaHMoc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgbXBmc19wZXJpcGhfaHdfY2xvY2sgKnBlcmlwaF9od3MsDQo+ICAJCQkJICAgICBp
bnQgbnVtX2Nsa3MsIHN0cnVjdCBtcGZzX2Nsb2NrX2RhdGEgKmRhdGEpDQo+ICB7DQo+IEBAIC00
NzEsNyArNDQ5LDggQEAgc3RhdGljIGludCBtcGZzX2Nsa19yZWdpc3Rlcl9wZXJpcGhzKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IG1wZnNfcGVyaXBoX2h3X2MNCj4gIAlmb3IgKGkgPSAwOyBp
IDwgbnVtX2Nsa3M7IGkrKykgew0KPiAgCQlzdHJ1Y3QgbXBmc19wZXJpcGhfaHdfY2xvY2sgKnBl
cmlwaF9odyA9ICZwZXJpcGhfaHdzW2ldOw0KPiAgDQo+IC0JCXJldCA9IG1wZnNfY2xrX3JlZ2lz
dGVyX3BlcmlwaChkZXYsIHBlcmlwaF9odywgZGF0YS0+YmFzZSk7DQo+ICsJCXBlcmlwaF9ody0+
cGVyaXBoLnJlZyA9IGRhdGEtPmJhc2UgKyBSRUdfU1VCQkxLX0NMT0NLX0NSOw0KPiArCQlyZXQg
PSBkZXZtX2Nsa19od19yZWdpc3RlcihkZXYsICZwZXJpcGhfaHctPmh3KTsNCj4gIAkJaWYgKHJl
dCkNCj4gIAkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlZ2lz
dGVyIGNsb2NrIGlkOiAlZFxuIiwNCj4gIAkJCQkJICAgICBwZXJpcGhfaHctPmlkKTsNCg0K
