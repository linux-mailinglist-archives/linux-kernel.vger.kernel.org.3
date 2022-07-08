Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427E56B90F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbiGHL5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiGHL5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:57:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7CA9A6B7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657281434; x=1688817434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=65ATGNPso/m/tpy/inYOgZ3nZza+czTamcyMvtT8ZRk=;
  b=NfoW67UlgL/7zyZPnXHdYjB/aaHCYh40W3zpn8R0FB44oDS038UkfaBo
   hZXEbT/5Nj3DIPdffcEIFNQm3XznWtDLEW/+8vba8K3JiS/xCVAdQy7Uz
   GUvYcgfMPS+UPt+IcKqksftuEU9Csx7cw5tZOZyWK3ynFE26ivvNzk8iq
   viNVRv8cP5G1aKCh95VwmUU3kP5mM/LqCC7wFKJPkT/PjQpYA7GtQjNWc
   vwP7ROwh5CfgVv/NaGHooB5vfMlnMujYUy4ZGT8sTFyPpbsgJ1vNTpFJk
   +M61EFEi0ZqDjHwajv2Da5T33QIFGp4fZjKktTbRkV0TrOtwEJqfRklLT
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="103632131"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 04:57:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 04:57:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 8 Jul 2022 04:57:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djUVkR+SKBrB9TrbgzDGG8IzbZGLc+xzFqjOdQdhE9VVSURcYnnPIPv3LBGf9jph6h4QjAFDFfNlbLHNDKC9ui/Kfddk9KHuIXHfLEDeYjiQlMl/QBOJ5GDG2CR/fA0gBZ7MUdhRSbbH6hEL1sJcISToQ1UxcYU+XvwycT0vUG9eXmRdboj7QLjIlb+Q9S9NdBA9o34HIui8B1OmY8ZXzDEjRR4pihYu/gMS9B/ygO+xl0GMGhnTxwUmCJGf7yRyGzkNQj+6AuMmx1WmLec+PCl0XpZiXOdH4W+PMVnegCAI8MNPex1PrP0urLhGtweAcPoxREbWD7GTvDnH7e66Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65ATGNPso/m/tpy/inYOgZ3nZza+czTamcyMvtT8ZRk=;
 b=bz4JF2okKFFSsov4Dx6AIHLtf6pbkhdu5jp0xYkGGzIrEaD1krNYXAX86ZaqmiSkqjf2ovPcvD98lfge3CX5aKcGITigrwrZrl2uCK+Og7xCelpJR7c2RXBM/TRArnL734Gf0CcdWmR9HX1Sugzhhd7YuomYduNuh5it+JVbKpTlrBXkH7hX/vfaFw+lI2pMp8f4GdapZX+DZXYILBTNzIIXPdp9HPocl1NpWKvlxePYd/AT0BnQEacXeIW5KUUBO6r8XjjQQqtJiIIEuEmUvicr4WnbEUM6eSVflT7CskuPTNOq7DrCGPJk0T2+Sgp3gu5o3g/OkTeKf74ce5Ga7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65ATGNPso/m/tpy/inYOgZ3nZza+czTamcyMvtT8ZRk=;
 b=pdL1YcYWHWoNXwivdKBMe/e6pWofVqsrWc7zYmM7kpaJd77V9oBAN2x13Xw/0W7Ui9PkAiEafGqQsdztp0SOTLnxgRIY4NA/US2ZCor/HKrRhD64wHcocp5cURks3mYOlTNuXM/Kh0HTWR9pOTBXvy04W2m4MgfESaqva/f6z9w=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB4145.namprd11.prod.outlook.com (2603:10b6:405:7b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 11:57:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 11:57:05 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <gregkh@linuxfoundation.org>
CC:     <geert@linux-m68k.org>, <Conor.Dooley@microchip.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
        <Daire.McNamara@microchip.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <zong.li@sifive.com>,
        <kernel@esmil.dk>, <hahnjo@hahnjo.de>, <guoren@kernel.org>,
        <anup@brainfault.org>, <atishp@atishpatra.org>,
        <changbin.du@intel.com>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [RFC 2/4] arch-topology: add a default implementation of
 store_cpu_topology()
Thread-Topic: [RFC 2/4] arch-topology: add a default implementation of
 store_cpu_topology()
Thread-Index: AQHYkk3HIdduEfI8FU+fdqjoS8H9IK10I72AgAADKgCAAAyQAIAAAguAgAAFRQCAAASdgIAAGrOAgAAFA4A=
Date:   Fri, 8 Jul 2022 11:57:05 +0000
Message-ID: <9f8d4e4d-f24b-faf3-687f-90370939c72f@microchip.com>
References: <20220707220436.4105443-1-mail@conchuod.ie>
 <20220707220436.4105443-3-mail@conchuod.ie>
 <20220708082443.azoqvuj7afrg7ox7@bogus>
 <473e6b17-465b-3d14-b04d-01b187390e66@microchip.com>
 <20220708092100.c6mgmnt7e2k7u634@bogus>
 <CAMuHMdXUjmG9n3BuRAz_irkmHQbp=7SYxe5VEfOhMdT4D2JfwQ@mail.gmail.com>
 <20220708094710.rxk6flrueegdsggr@bogus> <YsgA/eycDF9TgCIT@kroah.com>
 <20220708113915.ui77mgqckjzalwlh@bogus>
In-Reply-To: <20220708113915.ui77mgqckjzalwlh@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6042a628-87a3-4203-96eb-08da60d8fa6c
x-ms-traffictypediagnostic: BN6PR11MB4145:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUDK2yq7pChMPOsHMWtYQllEEVThVqYX+bGStzZkWFd0aaE0B+AB8PdmVdJd1tlJfZnMw0NJi5VpLnuTLie7GB5dfTeopexwzKKMk0L1gboJ2IZUhshhbK9OdFwHsZa09omN/1oYi9ZGSFNl2Ea6yu7ylOjmkv7oOP++3sQ5S3xueI78y+b0iFmch+vCsOwqmD9uADeZpn1gP9+3SklvQTBqCZaPPXbWQXrLHn31Pa4A6Z+OurJhOO6wflPpGtc2xwv6Tm/DM31AgQrNrwhN3KrNkTXuVzFWApSx5UWhpKw5KhQMjICJRUmAqSBVBAqzO3jDkteGpYF8EYs2EsYC34azhR+3+aMItveLuRbnQ7W+laKf7B6OWe1N0d72U2MzQK3fw3YxnbBxYkzkb5wxtAf+bVCOtd7xqsCmq/jy5uM06D9ncAoTZaZFt56uvgJP6LCT8vun0S/14DzGNz2at4EG119NeYhkYlgZCzaaHZuHmy2Ay+6M4ry9wXISNsDC3JygZ9uf4EDGCK+nDvz0uEJNo/gaTdN8zzeXNB9SJO8EA7v7csVohpNTVI7I6osIaiZwOQELotUiqyUCI0vSYcqRPmIDW/RV5KkR9Gfb2pRLupAQ2xd2t4rOGHnNzjdOk6y6A+UUbqwZY8ln6dT8upSNyFbfqWRomWlFSdNUDi4JbCQg3S4PX36+Qx2ZKrFyJAzchPAN6M2lDCF5GouVIfEF4WHGR/YwKEpotvZbfqJ3wpmRX4fW+Ub7hUiR0D55PrqUKoEplvgzrtNJjRnUUy6ssj6eXgE639JD39HRTMb0xwlHTVr/evwW6Fy+olgBQlo7QCojpKIcRPDRD1stmaxHsk5c1o4ZOYo2SGSP2EyWFdnYOHrO2gMDqIFjfl4i+uJbjZJnn8sqyaxiPEa8jaIhpVo1KzvKGYWvxa0CyjxcD1ZdLflKXnZ5O2wSWTBs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(366004)(346002)(39860400002)(66476007)(91956017)(8676002)(4326008)(66946007)(66446008)(66556008)(76116006)(64756008)(54906003)(110136005)(31696002)(38070700005)(316002)(71200400001)(86362001)(186003)(26005)(2616005)(31686004)(2906002)(36756003)(122000001)(41300700001)(38100700002)(53546011)(83380400001)(6506007)(6486002)(7416002)(5660300002)(8936002)(478600001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTZYUmMxV01DbnRsUDRRejA1T1licEdwdnMzeXdGemdqYmxBcTJFRjJKcFdR?=
 =?utf-8?B?YzdKSm5XMGI3dGkrMnFrc2pKYm1LSkU4YVgzZ05GdXY2dG5ZRXhoMlBIT3lZ?=
 =?utf-8?B?cmVURTJOb2d1eEhxMEpFc1B2ZEkrNiswNG9sb0JoSUt4RnQwMFJXU2ZvYWlF?=
 =?utf-8?B?SThJMnU1dVB5dUJNZTgwdlA3VC9YcE9hK25EN1gxN3ZLdEZEUWJ3SWtqOVZu?=
 =?utf-8?B?UE1tT2tVQ3hEbEZwNWF3ZmlScGt2T0M2aXhYT2IvTkZnbEVIVWFzWHRpb0FH?=
 =?utf-8?B?bU5iSXJhQk5NWVR5RW11NW03Wjhva3h3ckQzUVhPbTh2UFl4ZzhnUVRRR3ZR?=
 =?utf-8?B?bVoxY0NIcHMzVURZYm4wNnVSMGdCb25sMFpYYUNtSncwOVY2NmxpTWxVbUJJ?=
 =?utf-8?B?S1hVWkJWcm5zaEhUWUdVcU9KTElFNHVuY2dDM1N0KzhRS3hKVXA0NThYbkpN?=
 =?utf-8?B?V0FISjg4NFF6aDl1OWU3YTBWcTRsR0xiV1pZaDhhSGJmWjM4NTNVSEtVN1JG?=
 =?utf-8?B?bFZpd01yWFVtNkE5Qm43UzFCQ2VSRVZyQ3kvdnBMVnhQczh3QzdnQ1ZIQjFJ?=
 =?utf-8?B?RDdjME9obllhWXBNZ1Z4ZCtkYWdBMjdBME5FWGFMVkpUc0w2aVNvREJHbGlS?=
 =?utf-8?B?TTd2bTRjR2pXK3BFQytCTDZJaW5yazdFRFhzRTRiMmpMMmNON2ZjUjhXRGVU?=
 =?utf-8?B?YXhaU1QwMEhWeGNKTmNLdHFnbjlSNXAyMlppR0xoc2NwNFY4U3grKzBPbWZI?=
 =?utf-8?B?VGlWOHZCblJ0WDNiQ3FLTEc5ZmliOHlXMGk2ZU5rUklRT3FTUEVwbkJCNFFV?=
 =?utf-8?B?eG50dGtLdWRSOG5aZlQ5ZEhCaFNUakRKUm5Bc08xdktnaEdwOVZzaFpzeXRD?=
 =?utf-8?B?c0U1Z2JGdzIrNDIzckpQMmh6alFUZk1pOXUrTjZBQlNpTDd3V2hPYzFzSERJ?=
 =?utf-8?B?cy9aN2h3UGkvNkdvNFZXQkZ3RXl6RzlUSkVMVWlQamNTR1NiMFlGL1lESGJn?=
 =?utf-8?B?dlNVSHZwZEQ0N1djV05UNElaWS9XMkNRcFZLMHhxMmhHVUl6MDhRRDk0cVFE?=
 =?utf-8?B?UWJ5cDdKKzNIVHFjQVcyWGlIeVg5VEJJWFpoM1pudzA4YkxwSUpnTkpaRVFz?=
 =?utf-8?B?b0xMRzYvRzZsWnJvNjBteDBpTEI3VS9RWlg5RHB3OGRHTzRoekVKTVhONnFy?=
 =?utf-8?B?cnp3OHpSdnZuU09rKzY5WUVrRlR1eUowMkd2U0pUSkRQVmVxNzhvdUhUN0lY?=
 =?utf-8?B?bTVFd2t5b3IyS2dURFNIb1c4bjllRnZCUEhWdVF5WWRVbHRnenI5cWtGWk9a?=
 =?utf-8?B?MytOenZBMmxtVkljeThueTNISFZOZHpUZEppdC9GbU5xRlEwd1VtWFhvU2dh?=
 =?utf-8?B?ZTkxNVBRcDZJRU9hZG0zODBjS0tlK3YrSFZOdUhsbjBnby9qY2EyN2p2TE9a?=
 =?utf-8?B?ZENuQTNEOFpkNVVRLzVRbldsamJUem1lMUV0N3NiQ25wOGoycFJKckx1TDNY?=
 =?utf-8?B?NTZ5YTFqMWdnbGF2ZkVyRXdrdDE2dVRqbitWcE8yd3Z1elh0TU1xVGdUbGha?=
 =?utf-8?B?YkYyUk1kRkd1QkdZSGR2TngwL29VanZ0dDZtWDJFRHQ5RERxRUkxYzdUOElt?=
 =?utf-8?B?bEFQOWZmRjVyTFQvbVVQV0JIMkduYWNONE5tWlU2NlpLN0V2TTh0Q1RGcmJz?=
 =?utf-8?B?bFZ5NCthbVNFUWpRKzVrZGVVdEJaMEowOENVQngzeVg0K0VGd2x6eExQMjVp?=
 =?utf-8?B?ekx4ZC9aaEpEZ09LZFVIU3k3aU5RNG42b25YdTV4Wk9WYTM2K1ZwRExnMUdS?=
 =?utf-8?B?ZmVqVXIzTzJFZEhBdmoxVm8zRkFRQ0lsNVlFUCtZaDNqNTlrZVc2Z1ZjZE5K?=
 =?utf-8?B?TktUSENTSzNJWFdRbE5aVVFncGxRL0JLZ2llN1Nnb08wVXFqcGRIZzdPY0F2?=
 =?utf-8?B?WUV0aUdONUdGQ2JCL1dNTXZSNFljcHh0SUNTNFp2eVk3Ymh1VnF5Rjg1V05N?=
 =?utf-8?B?Q1FDTUgxVlhmWGhlcmI3cUJGdDNEaVFQc2tGQjNoUXJxbVFWc05TMUVVbEN1?=
 =?utf-8?B?cmYzN3Bnakh4WCtZdjFsczZqYTZoK0ZuWjFyY0d6NmEvLzdmSG9WY2NjMzV5?=
 =?utf-8?Q?bkEib5zL+oAHM6Vi0utlxckR5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC4EDF3865E62541BCB77A07E03EE081@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6042a628-87a3-4203-96eb-08da60d8fa6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 11:57:05.6500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1C2xcqla/op/VIlHLiPJNgw7Bj35oMx3fqwGh9VdE+Wf14NbScd2Yjxpx4rLY7fR9oDPUegjnNjsKTnit7XqYmH47N/CnuW78T3hGl7My8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4145
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDcvMjAyMiAxMjozOSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBPbiBGcmksIEp1bCAw
OCwgMjAyMiBhdCAxMjowMzo0MVBNICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPj4gT24gRnJpLCBK
dWwgMDgsIDIwMjIgYXQgMTA6NDc6MTBBTSArMDEwMCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4+
IE9uIEZyaSwgSnVsIDA4LCAyMDIyIGF0IDExOjI4OjE5QU0gKzAyMDAsIEdlZXJ0IFV5dHRlcmhv
ZXZlbiB3cm90ZToNCj4+Pj4gSGkgU3VkZWVwLA0KPj4+Pg0KPj4+PiBPbiBGcmksIEp1bCA4LCAy
MDIyIGF0IDExOjIyIEFNIFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+IHdyb3Rl
Og0KPj4+Pj4gT24gRnJpLCBKdWwgMDgsIDIwMjIgYXQgMDg6MzU6NTdBTSArMDAwMCwgQ29ub3Iu
RG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+Pj4gSWYgeW91J3JlIG9rYXkgd2l0aCBw
YXRjaCAxLzQsIEknbGwgcmVzdWJtaXQgaXQgYXMgYSBzdGFuZGFsb25lIHYyLg0KPj4+Pj4+DQo+
Pj4+Pg0KPj4+Pj4gVGhhdCB3b3VsZCBiZSBncmVhdCwgdGhhbmtzLiBZb3UgY2FuIG1vc3QgdGhl
IGNvZGUgdG8gbW92ZSB0byBnZW5lcmljIGZyb20NCj4+Pj4+IGJvdGggYXJtNjQgYW5kIHJpc2Mt
diBvbmNlIHdlIGhhdmUgdGhpcyBpbiB2NS4yMC1yYzENCj4+Pj4NCj4+Pj4gV2h5IG5vdCBpZ25v
cmUgcmlzYy12IGZvciBub3csIGFuZCBtb3ZlIHRoZSBhcm02NCBpbXBsZW1lbnRhdGlvbiB0bw0K
Pj4+PiB0aGUgZ2VuZXJpYyBjb2RlIGZvciB2NS4yMCwgc28gZXZlcnkgYXJjaCB3aWxsIGhhdmUg
aXQgYXQgb25jZT8NCj4+Pj4NCj4+Pg0KPj4+IFdlIGNvdWxkIGJ1dCwNCj4+PiAxLiBUaGlzIGFy
Y2hfdG9wb2xvZ3kgaXMgbmV3IGFuZCBoYXMgYmVlbiBnb2luZyB0aHJvdWdoIGxvdCBvZiBjaGFu
Z2VzDQo+Pj4gICAgIHJlY2VudGx5IGFuZCBoYXZpbmcgY29kZSB0aGVyZSBtaWdodCBtYWtlIGl0
IGRpZmZpY3VsdCB0byBiYWNrcG9ydA0KPj4+ICAgICBjaGFuZ2VzIHRoYXQgYXJlIHJlcXVpcmVk
IGZvciBSSVNDLVYobXkgZ3Vlc3MpDQo+Pg0KPj4gV29ycnkgYWJvdXQgZnV0dXJlIGlzc3VlcyBp
biB0aGUgZnV0dXJlLiAgTWFrZSBpdCBzaW1wbGUgbm93IGFzIHlvdSBrbm93DQo+PiB3aGF0IHlv
dSBhcmUgZGVhbGluZyB3aXRoIGF0IHRoZSBtb21lbnQuDQo+Pg0KPiANCj4gU3VyZSwgSSB3YXMg
anVzdCBzdWdnZXN0aW5nIGFuZCBleHBlY3Rpbmcgc29tZW9uZSBmcm9tIFJJU0MtViBjb21tdW5p
dHkgb3INCj4gbWFpbnRhaW5lcnMgdG8gbWFrZSBhIGNhbGwuIEFzIEkgc2FpZCBpdCBpcyBiYXNl
ZCBvbiBteSB1bmRlcnN0YW5kaW5nLg0KPiBoZW5jZSBJIGhhdmUgbWVudGlvbmVkIGFzIGd1ZXNz
LiBTbyBJIGFtIG5vdCBhZ2FpbnN0IGl0IGFzIHN1Y2guDQoNCkkgZGlkIGEgbGl0dGxlIGJpdCBv
ZiBwb2tpbmcgaW4gdGhlIGdpdCBoaXN0b3J5Lg0KVGhlIGxhc3QgY29kZSB0b3VjaGluZyB0aGUg
YXJtIGltcGxlbWVudGF0aW9uIHdhczoNCjMxMDJiYzBlNmFjNyAoImFybTY0OiB0b3BvbG9neTog
U3RvcCB1c2luZyBNUElEUiBmb3IgdG9wb2xvZ3kgaW5mb3JtYXRpb24iKQ0Kb24gRnJpIE9jdCAy
IDEyOjAxOjQxIDIwMjAgKzAxMDANCg0KVGhlIGludHJvZHVjdGlvbiBvZiBhcmNoLXRvcG9sb2d5
IHN0dWZmIHRvIFJJU0MtViB3YXM6DQowM2YxMWYwM2RiZmUgKCJSSVNDLVY6IFBhcnNlIGNwdSB0
b3BvbG9neSBkdXJpbmcgYm9vdC4iKQ0Kb24gVGh1IEp1biAyNyAxMjo1MzowMCAyMDE5IC0wNzAw
DQoNCkJhY2twb3J0aW5nIGFzIGZhciBhcyB2NS4xMCBzaG91bGQgYmUgbm8gcmVhbCBlZmZvcnQg
YW5kIEkgZG9uJ3QgdGhpbmsNCnRvIHY1LjQgdGhhdCBzaG91bGQgYmUgbWVhbmluZnVsbHkgaGFy
ZGVyLiBJZiAzMTAyYmMwZTZhYzcgaGFzbid0IGJlZW4NCmJhY2twb3J0ZWQgYWxyZWFkeSwgbWF5
YmUgaXQgc2hvdWxkIGJlIHNpbmNlIGl0IGFwcGVhcnMgdG8gaGF2ZSBiZWVuDQpmaXhpbmcgYSBw
cm9ibGVtIHRvby4NCg0KQmFzZWQgb24gdGhhdCwgSSB0aGluayBkb2luZyB0aGlzIHRoZSBzdHJh
aWdodGZvcndhcmQgd2F5IGluIHRoZSBmaXJzdA0KcGxhY2UgaXMgYSBiZXR0ZXIgaWRlYS4NCg0K
SSdsbCByZXNwaW4gdGhlIHNlcmllcyBhczoNCnBhdGNoIDE6IE1vdmUgYXJtNjQgdG8gdGhlIGdl
bmVyaWMgaW1wbGVtZW50YXRpb24NCnBhdGNoIDI6IE1ha2UgUklTQy1WIHVzZSB0aGUgZ2VuZXJp
YyBpbXBsZW1lbnRhdGlvbg0KDQpUaGFua3MsDQpDb25vci4NCg==
