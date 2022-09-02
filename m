Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFA5AAB7C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiIBJdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiIBJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:33:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE9BCAC85
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662111214; x=1693647214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mneCBuOkPyjCH42d3wMnu7Kwbt0RJKQ3iQw9BTqfmVQ=;
  b=oXQLVu5FjayE1bcTFrEShuKFTqFfzY/Qx/L5rQkSHUJ/dkXqPlxHMfnW
   twJOUOu7I+HsBqeFRvDZL6atJ7yChn24vyvmvAEtEn/qmPtvEgxHVj2DV
   RsRbk38pPUkPCLN3LK8PHVlljGCbr/aMZAOdtLG27fdLO9nz7eSM0Xh6h
   4/9FRiwvNC0Ws2nnCBOgb+J5xaCXk0mLnvv7hQ8OES8LZ6ie6Tg3M7igh
   XVgy22hmvx9m82zPo82ELxAgtu1jnif5BAA1emrkNnWP3o3w9DpBmFbzV
   Pf+Wc9yI108nOgdDD7665j2B0fFCU2zigJAIPJQcBUkmnYQEDGj2VhFzC
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="175350860"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 02:33:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 02:33:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 2 Sep 2022 02:33:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpuemnX0+/2uwCwwa5KBI6dnIO6bzd59nZ6EL08TB4BTmEMpXk6/SmVjQwfeJ6RsbJZin9+BJs891IrBvqVU4zHPi26byvpLtlDi4MzptesnDGA1UiFmcRAL2PliExVa7gJAfI/XbvuZNDl8Vb+17Kccx0JeRmx8QkpHMup89zK4MDryM/UtjichAnxn3uCcUQCdAnGQxh87t2fwndRVaiHmXeCZkTN/nGiNo4hVmjmPAG/5xOM5AJlLGxGMpm21JViS25IiNTNVMQsv+FPBSUYHKGgsdrj0xt4YQhUoUn+EYNqSSxj1DkzaEzS5so7wIQoAUoSgw733R88b7qMsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mneCBuOkPyjCH42d3wMnu7Kwbt0RJKQ3iQw9BTqfmVQ=;
 b=llnr/mVOCu7pshFwAoVwiIy1dOgeA+8wSfi7IoxegTPmiWK4WrwCeZ0mCzmGmAzjLM4f0z+UYwVvHNpyxZUxAsesxRhi+XfzEwLOoWC+0ShKxRx13174GtDTTRBBywzq+oldgvfo9dbvjsy97JNY2volC3+MgVBQ73o6hMHMvoE7G3In68i4HoNHXeuESiqT5AUqJe546jEwGrsp7bte2DKXelv47pF3b+5/LFmORJlJQORv6t5RNPxX8vhAk4hexfa4k2sVxYz7VX+bnqetg78Baydm0OW4bnKKsLqBe0NhU/yP+p85i/YwvuTP5Zdl99IVxASt9rkTxEUUZUexGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mneCBuOkPyjCH42d3wMnu7Kwbt0RJKQ3iQw9BTqfmVQ=;
 b=BCY1ZQBTb3vvVWOKHzUD4lsP0KDOb+PsPLujaA8d9OIAsM1RzNV9r0GCC4MBWC9HS2/+k1InhFobwvq7Wx3ZKprLbrYL+oLjoG5itQI89KzK4ixTnZPtK0/u70xb4+om1dLVSZA+5aB2HpdZKxSDRroH13ogfTfxFYx8gZkdDzo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2363.namprd11.prod.outlook.com (2603:10b6:3:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 09:33:27 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 09:33:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <guoren@kernel.org>, <heiko@sntech.de>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <apatel@ventanamicro.com>,
        <atishp@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] riscv: check for kernel config option in t-head
 memory types errata
Thread-Topic: [PATCH 4/4] riscv: check for kernel config option in t-head
 memory types errata
Thread-Index: AQHYvlIzMjs1NuF9V0KyYwO1U6icxK3LU9uAgACNiAA=
Date:   Fri, 2 Sep 2022 09:33:27 +0000
Message-ID: <6865a605-2428-e6c2-09dc-aa2a66e48c55@microchip.com>
References: <20220901222744.2210215-1-heiko@sntech.de>
 <20220901222744.2210215-4-heiko@sntech.de>
 <CAJF2gTQsXMB+igwMiya-sqyku+3iQPop1JJuHwXtTToj163h-A@mail.gmail.com>
In-Reply-To: <CAJF2gTQsXMB+igwMiya-sqyku+3iQPop1JJuHwXtTToj163h-A@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 743a2344-be57-4ae1-6177-08da8cc630ac
x-ms-traffictypediagnostic: DM5PR1101MB2363:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FxoKrkforygdv4OEi6k4xSHQP/xrhuzZxs62DOg2ulCipvuaoNP21niJoTNcTXqwhFhi0hgz/7L7Y8QHH3Kz4IqbguAyvvfpFTnkBvnPrCFChdpypPMvkVFBy+tnIv+lK6peNoURnUgb5yCUJzcVDEOif+X7LOEBA4vNymN5rT+UaXwi3h91GLTcfvFXpSqv98OvvFBFfx2tTTo5lqeygngbWN9UaIyeR3xvvpHxCY0BI1ZOs8ZQYjMQB63gWcyOTRThaWBoHbn8HZHj9/0m2QYfjSTeFxniBfKs22K+q8oRbjt3rt/pubPatIvL3vMIHke8KviVOovdPST11ViQiPUgbrbiOkQLa3WHhlb/EEycmbmv60qwOTjC4AaEpsztxhrZh0+gjsa8BswVb9Wvpttrpq4b8EUngl5Y/+x1C/2d7G5JeeF499HZ1dZikogNNSU+nvD/vbF8fwo1O/yPnNVCIeHpPYUoL8+iK3hRWuHKpJb7MZt1eJkkF3Mt+vCMOuJLAGtdSNCXVL63u/R3SOkxAgmwmMKmcoDUTd0OijpCucm4Vf+8WiB3ALPVMzReQkf7zQ3qboKJ92DGeK2qC3ezD/1Kyy/7kKVLzGHhN/v/tmvWeQpKLwH9dRR4hV5+DqYJesqhfOhJEOTVL0QbKbohMNzt948iNP/+FhwlhjacwEwwTGB0xf1djcXjuXcHJWWx1ZeUS2IiQLHXkohdmcrj/lcftyTqcypPAcwDDqKosVg7FBjlZh8uu3aa30aGQh32ImwY4XC/WHutZuOrulFmQA1whWgNZG5irJLkGne3YLy63PavTUd4S2bCIqgX+iN0hx3KrT9C8AK0QEytlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(136003)(346002)(39860400002)(31696002)(38070700005)(122000001)(38100700002)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(110136005)(54906003)(316002)(2906002)(8936002)(5660300002)(53546011)(6512007)(26005)(6506007)(186003)(2616005)(71200400001)(6486002)(41300700001)(478600001)(86362001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emNUb2VwSFdxU25VSjduMHF3d1hqZkhpV3JDVDZNZmRScFU2WnFPRlZrbTMw?=
 =?utf-8?B?UkRIT2Y2NWhvWmtrRWdmRTcwMkVCeVBJb09FVWRoTHBaSUpjUnkwb3BoQmt0?=
 =?utf-8?B?bFhXY2lHRXVFVHNDcDU1blJ6OGVFSVlQU0E4a1krcXRpMERqZHdUbXZybWxq?=
 =?utf-8?B?OXM4NDZKRkk1ZGZJZmdzS3M2dEppdXhhRHZpcnFGMnpDMkRFeHdRMWlnaDNo?=
 =?utf-8?B?WDBLajZ2RGcvekpHaXpXcC8rNTlpMXVzS01XbE1xNnlUd0VCQWpyYVVYYUtB?=
 =?utf-8?B?SkxCc2k3TVRFbTYxLzJKejJ5SWFteXVWeXAzWEp4TVJjZUNpVFhZRkVwalh5?=
 =?utf-8?B?Qysxc0RNdWRndTY5bTM3TGJVU2p5MWxCbk56cmYwT1FTamthZXlYVVBjUlBX?=
 =?utf-8?B?MjgzN0dpMTBkS3VGZFlHUU1VdDRvODNqcC84RjNZUWw5RjFNeW5RTmtCbzFv?=
 =?utf-8?B?czViK3VybHlpMWFrQndkZFRIaHJsaHpvKzFzMVNEQ3lQc1VJLzVFOUM3aG8z?=
 =?utf-8?B?ek9RK2tEYktCdkprTVZtNU5wSFNEaStxb050ODZXNG9kM29ROUtjcy9HNm02?=
 =?utf-8?B?MFVLKzNjUi8yYldlNUx3WHQ5M2NCZzhiL0sxRk1CR29VMnh2REJ3THprYlor?=
 =?utf-8?B?aHNyaXBMQVp4c2Z4ZE1HV0Q1Q3g5d2pMa1Q3VFdLbkJmeEpLMGxYMUY1QmJU?=
 =?utf-8?B?bFhqTFRIVzJ3SitSR1RqYnZ3VU95UGZVRTNuSkhueDJnYmJ3eXl0VzNKNVp2?=
 =?utf-8?B?eWRzb0tFWHh3T29DZlZmMzJiS29BbEdBRTZaMHoxdkRSWHk0bGJSR21XcUxU?=
 =?utf-8?B?ZTFIZXFUdUF4b2piendObDN0aHJiaEhYTDVsVnlibFRnOGJLdWxkMmFFeVpP?=
 =?utf-8?B?d1hWMHJ4UUJtNklBR2kxYnZzNkRvcjVhWUZ4bUthSk1kYUZ5THZIdHVpdG5i?=
 =?utf-8?B?bThPR283S0wrcFFSb01hOVhRbkg2MXRMNHkzb0sveVp3QVdaVldBVVFwQkU0?=
 =?utf-8?B?Tk05cnFDWitXMFVUY0lFdHpjM2RINWhiRUVuSXd3Ry9MdEd6SXJUTm9CUS9j?=
 =?utf-8?B?MGQ5MGRqM0MveWhQbG1IcjhTRHpCWVh2a1ljaC9CZlllek5hOXpSQWNKa1hm?=
 =?utf-8?B?ZVpTMzVFNGhpK3ZoZWd4cTg2WUorSzAvUWNySDlacDNFd0tsdkVDT3RPRjRK?=
 =?utf-8?B?Tk10WmVNcExPY05jNW5LaDhwZ0VyKzlFYjJZdWprVXhsekg2Qnc0V2p2YThD?=
 =?utf-8?B?MjNiMUJoU0ZOaTRQUFBCUWhZeFdqS1pWSUN4MU1Ba2o3czAza0E0S05Rd1ls?=
 =?utf-8?B?QzVsRW16clZya3QyNTdFVHo0YTdkcmdPcFJzMENQS0FWSllZemZFaWFoUVRa?=
 =?utf-8?B?eFprL09pbHkzcFltbHIvWVB6VitDY2FxNkhWUXQveG9aN01JOFU1aXIwc1pT?=
 =?utf-8?B?dDNPU0wwYnBDMVFPR21oelN0QXBJZVB1cFgzOTFURnc4RWk4SkFaSXFsblJ5?=
 =?utf-8?B?azlZdzhBL3RWUm5IV0JVbGdobkV6cWY2cFVDcmQ4M0tmU1R1cXcrYUliQ0Z5?=
 =?utf-8?B?WUpFVHRIeFN5d0tuK2NiQzlmVnpjbkNXWkFaRkFKRGplL01nRVJRWlByTGI3?=
 =?utf-8?B?bjdRSVd0b3ljcHVVTFhQS0paRXBMUWpNSUVMVkNFODBXUE4zc3R4WHl5RlhC?=
 =?utf-8?B?OWphd3lFcW8xSW5QMDJIMU14a2xQWWNFK290SHY2akRha1UrSFNtMGNpRmZW?=
 =?utf-8?B?em1VMHZCVUoxL0VIZG9ERkpyYU55TDNaZnFwM3V2M2FTRlFSY3MrNjgrenRU?=
 =?utf-8?B?OE9QYUs0cjNDc1E4UTE1QnFPaWYvTm5ETStyeFBBMzBvTExEcXI1djhhWnlE?=
 =?utf-8?B?RElNdDlWYjhQYXAwSitKTS8vTEhvMlRyL1RKaTNnc2haQWR2VEwvZGZjbTY2?=
 =?utf-8?B?Zm1FNGRUSnhpNkVhYXh0YjZiYXFxaEI4cHpjTzF0TndxQkIwTVN2ZWloNkRO?=
 =?utf-8?B?M3BHT1NUZEtVbDYvUExYZG1wVXJDQ2hZQU1rbkNWcTJtUm9nakNycURlUEwr?=
 =?utf-8?B?QU1TeU1KOEFmYXlpaEpIUFFvbzlUaCt4dzVqN0FYSi9DcTlvMS96bVRCWkxj?=
 =?utf-8?Q?bFuaA+dLPXpJKxNgT31PlarAG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7E2F9A381DCE9449700A998E8BB449F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743a2344-be57-4ae1-6177-08da8cc630ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 09:33:27.3894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xD4dl94cstug7AbjmCuJ18n8x/1YXhTFqsCdFVqW+3ecYs1MyOYGCfHBPs25eadTGY2EUzrSS11YEs6wgi8Z1WjYM9knJg2hcBsoLGMPYlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2363
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDkvMjAyMiAwMjowNiwgR3VvIFJlbiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBJcyBpdCBhIEZpeGVzPw0KDQpMb29rcyBsaWtlIG9uZSB0
byBtZSwgc2VlbXMgYSBmaXhlcyB0YWcgd291bGQgYmUgZ29vZCB0bw0KaGF2ZSBoZXJlLi4uIEVp
dGhlciB3YXk6DQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9j
aGlwLmNvbT4NCg0KPiANCj4gT24gRnJpLCBTZXAgMiwgMjAyMiBhdCA2OjI4IEFNIEhlaWtvIFN0
dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+IHdyb3RlOg0KPj4NCj4+IFRoZSB0LWhlYWQgdmFyaWFu
dCBvZiBwYWdlLWJhc2VkIG1lbW9yeSB0eXBlcyBzaG91bGQgYWxzbyBjaGVjayBmaXJzdA0KPj4g
Zm9yIHRoZSBlbmFibGVkIGtlcm5lbCBjb25maWcgb3B0aW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+DQo+PiAtLS0NCj4+ICAgYXJjaC9y
aXNjdi9lcnJhdGEvdGhlYWQvZXJyYXRhLmMgfCAzICsrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvZXJyYXRhL3Ro
ZWFkL2VycmF0YS5jIGIvYXJjaC9yaXNjdi9lcnJhdGEvdGhlYWQvZXJyYXRhLmMNCj4+IGluZGV4
IGE2ZjRiZDhjY2YzZi4uOTAyZTEyNDUyODIxIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9l
cnJhdGEvdGhlYWQvZXJyYXRhLmMNCj4+ICsrKyBiL2FyY2gvcmlzY3YvZXJyYXRhL3RoZWFkL2Vy
cmF0YS5jDQo+PiBAQCAtMTcsNiArMTcsOSBAQA0KPj4gICBzdGF0aWMgYm9vbCBlcnJhdGFfcHJv
YmVfcGJtdCh1bnNpZ25lZCBpbnQgc3RhZ2UsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdW5zaWduZWQgbG9uZyBhcmNoX2lkLCB1bnNpZ25lZCBsb25nIGltcGlkKQ0KPj4gICB7
DQo+PiArICAgICAgIGlmICghSVNfRU5BQkxFRChDT05GSUdfRVJSQVRBX1RIRUFEX1BCTVQpKQ0K
Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsNCj4+ICAgICAgICAgIGlmIChh
cmNoX2lkICE9IDAgfHwgaW1waWQgIT0gMCkNCj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZh
bHNlOw0KPj4NCj4+IC0tDQo+PiAyLjM1LjENCj4+DQo+IA0KPiANCj4gLS0NCj4gQmVzdCBSZWdh
cmRzDQo+ICAgR3VvIFJlbg0KDQo=
