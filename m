Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E072D596E42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbiHQMRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiHQMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:17:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED4A87689;
        Wed, 17 Aug 2022 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660738646; x=1692274646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rFtytMZmOqo7lJUeEmUHG859yWZ3pPUp+1x/qZ/nXjY=;
  b=mji3HQAC/XnLrxO6LRzChgUxFI0++O7SjQKgA/FiU9awm+W6Vx5rxkzT
   a076Z8vJaad5D6mISMIjsihTi877VqGcgfxZ9KHZ4THjjmfMEGAbfRTUP
   T/qZiXgu/D+5SP0PTp93QD5diGREHDWarZgMfe3AlVWsn5+so8YVfkJPw
   4T/YPA1XON68Qz7ygT3Mtu4vy8HxpuhTBRRlxWvLFmR6QBAH05afNx5GI
   tjXhCJEn5EADhqUmO2IJ4m+qq63BrcIIhbBNLAhDf7FUa4yqniesQ6XY+
   jjc+2aXxNh/PavBpktsi7Afno4c0668YXL8boQPpbxqFnuJw13rzjM1+o
   w==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="176747665"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 05:17:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 05:17:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 05:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClB0p2ol28P2d7nMYL5OwB0JvsN7/0SrgUFcNzJqFsRa7hKY0kZ2T2uI/H2euoParwu6rzOf27IY4V5PLptVqmzsWJb8LgiaV+LYNY0P7b9hcOcIBz7TGRUG2N/nHeKb/M2Gtkmgox9qMteItINbunrhaaOjNbiYswEYlqyz9bB6WYYzt95bsbjI3V+aW/y2ILGPqE3uehjYpV4MI22qb/wUN//4zEaCv8oK33pzGMQAQe9jCqZOn4EDUDgONBZTPlwgqlH+6UkpL4FGvxnMNR2nDOZcQuNqhK5+5A2VPRrPdAh0hRHwLrWbqQlq0Gy80oodIcZwKVTaYgBbys8YTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFtytMZmOqo7lJUeEmUHG859yWZ3pPUp+1x/qZ/nXjY=;
 b=g0esITalnVSy8K+J3Ea5ijiEVtlDcMxoMb3r4j3QsXkIp9wJF1FCuJccZ/96EeOhklz4uTsdbMV6bb847YfunadczzZGWOaZk694EowqEqs/n0Cq2AU08kERqjuRXRvU1oMpn2sDpSD5206l+mJ2WGqZR8hjI7wjh//+bUS9pGvZzJDKD2ECHV1e3QGRu8WZvIUOLKmO6iwrcSFLcqNL3XUWaViciGjp+h/hxse2i1AdU2U5mM9u4DfoaCOwXTupFgFeUPHAqTC8TwZ3R7bVU+e0mSIWbnzVMCXbM2bLq6rLAIb/hdAqP2kdqjcjKHxESdHiwf8AwNNmUvJr+AXiLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFtytMZmOqo7lJUeEmUHG859yWZ3pPUp+1x/qZ/nXjY=;
 b=oguvjmSS+89862t45MorC8fhdWb4dm/x/lCAOy9f8ve9oYWoytW98FXNHf+aVuqaudQdgOJkMGI+YuJ0dyk9sjtOHti4CYiqcNNC4myUsa0ZmLkjrn3naxTc6Tf8+MpCVT3qnG+K0h/PhJric8xFbFh3/hXdzDCxAGTUJvkuZWM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2267.namprd11.prod.outlook.com (2603:10b6:4:52::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 12:17:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 12:17:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <nathan@kernel.org>
CC:     <ndesaulniers@google.com>, <llvm@lists.linux.dev>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <Daire.McNamara@microchip.com>,
        <palmer@dabbelt.com>
Subject: Re: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Topic: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Index: AQHYj5/vIrxOVV1EL0SoHOsgiQHkyK2nacwAgAFM1ACAAAaZgIAAA0QAgAADOwCAASU6AIAEnVYAgATA8oA=
Date:   Wed, 17 Aug 2022 12:17:11 +0000
Message-ID: <62bb08d7-0a14-13e4-5ca2-edb5ef3b9793@microchip.com>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
 <bd14f1a2-750d-2511-df0a-85a9f5925f84@microchip.com>
 <YvP/bjh+wXihlrdG@dev-arch.thelio-3990X>
 <fc470bf4-33bb-d67b-3860-3ac775982f27@microchip.com>
 <YvQHtGObJwyBKGCQ@dev-arch.thelio-3990X>
 <3d2c56fa-8245-4992-2074-cd39677c2b3f@microchip.com>
 <d38d8b9c-45da-c464-264c-bebd084bdb17@microchip.com>
 <42354fef-8ca8-a81d-6af9-f250ecfd1924@microchip.com>
In-Reply-To: <42354fef-8ca8-a81d-6af9-f250ecfd1924@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2151dde8-ebfb-4405-4d39-08da804a697c
x-ms-traffictypediagnostic: DM5PR1101MB2267:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sCpBpW5rLdfN2nWtb2RxQ4lm09Nh+DY81TvugfWc08A/iqjDvaYNrFA0uM1dYhwmsKVP6E0zTtKZCBCgCNOa4pho7tBS2OUz4jW0YUinjkvTkMmifWTc/KEm1z7E/vbMqfeGMwWzX4Yujf29dXNlQFOQAQwuQghGAV6g2YB7bVcos/W8NnWrOJT93OCwmtyGA9ycY0LdY0+VT+WA31Qj4hF4m3vDspJFIipDwzexMvL3GBqJcUCMU7tW5RdjoLcN9LYZgMpTfICIFs4ze3WgOt9gpM/LUjpV94DDvw1hfBhkJENbr0Cr7lHl+CQ9LGPlW7sZflcyoCyYPVaaoDuE9vgWOtQE3Cp6HjcHOXA1HzCdc6jFutU4KNA6qT2eZ2bV5+Kz4iUCYZ60wV2mr2DRZHtPbV09ujTLVDzvmB0Hv+soCZOJkoD9BYysJ64jGP+/D5iuaSfED2zoG9tWnzx4X4uNg6XgJjclWEFEMNhazuR2hX36rerLDjLxkkLlFgUaClRBPhMar3Sl4/3j6VcFEtlD774Ovn7QdJjPshCAaNNLyRypTzchEx+iC1O4I3ookcsG+nDHLvdV912F/Uk0a5vsDPMXzVdRF0/87RAHbjsQcMFig7lu2bswge5BiM71ON62H+kStt61SEqj+xgpGGAniFozl3SGfbQ2gOPExwoWlEJjcp2SXLuEgxapun52r8EoARZ6hnuLbU+EffCZkB6y+D8G3vw180kI1BmGmn9FUAHiPk1Zi218dgg31v9xFMesxxnQrSx5+1AORApE/l1RSZPjKu7efvbm4rbuFGoAOf7aZd5/w2c3pY3MrRcvpYg8LePm50CxmYvFAd1Xi2aon3EQkA2r9r10XUchiv3o107DPIJ1K9HvqKhx2Uz+ABqcar2rPylxKnjLXNbAvxN4Z8Qps1Ce6HIbg6hJWrUlATCGjKCJPhQL0pOvwrzQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(376002)(396003)(366004)(4326008)(54906003)(45080400002)(91956017)(83380400001)(122000001)(38070700005)(86362001)(8676002)(66946007)(6916009)(76116006)(66556008)(66476007)(66446008)(64756008)(31696002)(38100700002)(8936002)(316002)(5660300002)(2906002)(7416002)(186003)(2616005)(6506007)(71200400001)(6512007)(53546011)(26005)(41300700001)(966005)(478600001)(6486002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU9Ddy9RdWVMZzNBY2VIbzlISUlCbmhXY1VvWlMxMElOS0pRRFhpUzN4NFhq?=
 =?utf-8?B?TXdQSEtvZktqQ2xRczJDeS9WUVZIZURocFNzOTdxUjJDQmZVb3JSNnJ3a2w4?=
 =?utf-8?B?NWFabzlSL0pLY2pHU3JOY2trQ2pISVk3VjRNdndnRVdJVlFvZGlQNU9RY0Zz?=
 =?utf-8?B?c210aktxdmVxdENkZGM2cHlXTUFkMlpIVVZVNllWNzJuUWlxSnBmVHEvMG5p?=
 =?utf-8?B?M1dWNk5yVCs1WWRob1RqRVcvYjhqeDA4Y0JZTi8rTDcyU010MDNFeGZacUo1?=
 =?utf-8?B?Szl2V0N1V3VsSWx4bEZvNjFIU3VQMm9zcStDZlVqdGtyQjY0MGZWVnQxU3dN?=
 =?utf-8?B?bUNsdis3N01vaU1MYllSN0FvdzNVR244L3pzZjlGODBqTDM5a0xrbUt5Z0xT?=
 =?utf-8?B?SHpjL1FCRENISnM1ZlBOL3BObnVYZXBOTHo2a1RIZUx5TmYzYTZMQit4M0NS?=
 =?utf-8?B?T0tZZzBzZ2M4MjNUVStDemkrZDg3Sk1Rek5pL0dJRjJUaXFDN0xvencwdWdF?=
 =?utf-8?B?SmhwZEF6SmoyOEl6c0J1Ly9hMW44cm0yUlRnckNHUXBpZTlFYlI5bkM5alg3?=
 =?utf-8?B?R0txVVlDNkFjeUV2NzU2ZG95TVhNaXo0UWtNN1JhNkxGbnp0VlVmdXd4SmR0?=
 =?utf-8?B?aVZpWUwvQlV6bjNhOWNhUWtzVTdHWXhSSFFKd0xKTlFzMEh6VHFFbUR6aHpG?=
 =?utf-8?B?UmNDYW9KTzdsK2FVNzNCQk5kWkpyYm1JakRnU3M5WWhRSlhOaklHNlhYb0Z2?=
 =?utf-8?B?N2hzYkN6VHY1TmFNRHhyQTN4eFNOSEF2bHA1blRZTHJ1WnRET29BY3BaRkNS?=
 =?utf-8?B?QWpjZjhmVElZMnd3NS9KQWFBTGowamcwMFV0RGZtc2UrZmt6UEZUUW4zS0Mz?=
 =?utf-8?B?M0xFNFQzT3pZT1BNd2tMTUlRTkoxOXh2ekJRVnBwb3Z3cmlGckxWYlE5Z3FG?=
 =?utf-8?B?aXR6ZVRhdzFzUGV3Z1FUOWJHNHFZcDM3N2V1Y1pDL3psUWpFZjg0clIrU0F6?=
 =?utf-8?B?aU0zbVJyRnFCSGpadTVyTlpVTEZnNDdQNWdMcmV6dEtnUWJleVVyMUVLZ1JF?=
 =?utf-8?B?Q2tNUUN5QUR3U29KTWxnTUZaL1F2TVhIMFBCZFlLMDJHS2tMYXFJVDg0dGdN?=
 =?utf-8?B?djlJZDF2Q1k3Z3VCNGxxbWRmYkJFWkpoeDRsSTEvaUUrYW5JKzViVFRWYlIz?=
 =?utf-8?B?NXM2OStBYmpEbEtEakJ6MUhhRnVmNi9KKzBXY05DVUJmQW1wa1MxZ1haVWtX?=
 =?utf-8?B?YnJXQVdJTFR5dlpoMEpaYlZMQ2ZQTDZlUFRNVEFXR1lUZit4MEYrcWd3Q1dt?=
 =?utf-8?B?WCs0R0VwUFQ2RXdsY3JwcFkzMWlERUZKMWFoSjdRbFovOEtNbDNQa3BOYUR2?=
 =?utf-8?B?QWZkdW5XbmNycVB4OXRQRHdOZGc4WGxXbldXVVlTaDRuV21MS3R4RXR3Nnkz?=
 =?utf-8?B?WjJVMHVNQXBWcVBTendpaSs5aWRMS3VNL2JteThkd3dEUWlMajE5RXF5aC95?=
 =?utf-8?B?SXMzWkZVTGtKbFA3MjEza0xuQTdFbVFJcEpHclQvSWVpZjdOZkcyRmdnTENG?=
 =?utf-8?B?Z1BOV3kvSmpuS3lhYUlOUEI4SHN4Y2JUWlFBZXMxY0txcGxFR3pZY0V4OCtH?=
 =?utf-8?B?a3FpUDlPMjFvajZOQlZST2pjUzkzN05TVGMxdmJveDRKRlBKZVR0RVdtbGhk?=
 =?utf-8?B?MFRwbUY1UERyeTlTQVRvQnp0d09Hck1SRzZpQWMyT0NHcmZZNWs4b2ZFdlR1?=
 =?utf-8?B?bGtDWGhnZVN2c1FidHpsa0RRVXFia1p5Sk9SdVp3VWlBNVp4V1FLNTRhRkVL?=
 =?utf-8?B?T2dGdWRzM2RuL0FtclpQUXdDTXJrdk1WWk1Ma21JaDBEMFRYb1I3SGlEbG5J?=
 =?utf-8?B?eXBhajdIWlB6N3hNa2dGVGdqakw1eVJpbFIwdFZuUUx2SVMxMFZmUVVtT2g3?=
 =?utf-8?B?cHh6RlAxdC9qemtLZWxtaEFad3NCTUU4YmViSGRZcmMvRHQrajNybU5PaTJL?=
 =?utf-8?B?a2N4VWQ2KytVUjE4UWc3TS80Z1VpYkF0MlZhbEg4Sll4QkdQSk5MMUN1OThR?=
 =?utf-8?B?eUZVVnBqWCtaLzBFZkFUS21BZkNwNThtc3ZLUEdkMVkzOVdlNVB5K3BndlBG?=
 =?utf-8?Q?N2fR8syjOl4yLm6aEXztQCnL8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17465025E1B51E4DA92E35B4C21E9DA9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2151dde8-ebfb-4405-4d39-08da804a697c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 12:17:11.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjHUH/4a3dmbjJs9jTWwG0rIkuF7L6U2jWYLYz8PyuwXWpOV3V6V/nKwcHHaUO7Wj1pa+ZUyy90kRHFcbWDyRQFv8GBsMwBmCwbHkINs63s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2267
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDgvMjAyMiAxMjo0MSwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
Pg0KPj4gRG9lc24ndCByZWFsbHkgbWF0dGVyIHNpbmNlIHRoYXRzIGxvbmcgZW5vdWdoIHRvIGdl
dCBwYXN0IHRoZSBzd2l0Y2gNCj4+IG91dCBvZiBlYXJseWNvbiB3aGljaCBpcyB3aGVyZSB0aGUg
Y2xhbmcgYnVpbHQga2VybmVsIGRpZXMuDQoNCkkgaGFkIGZvcmdvdHRlbiBzb21ldGhpbmcgb2J2
aW91czoga2VlcF9ib290Y29uLiBXaXRoIHRoYXQsIG9uIHRoZSBzYmkNCmNvbnNvbGUgSSBnZXQg
YSBuaWNlOg0KDQpbICAgIDAuNTgxNzU0XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwYjENClsg
ICAgMC41OTE1MjBdIE9vcHMgWyMxXQ0KWyAgICAwLjU5NDA0NV0gTW9kdWxlcyBsaW5rZWQgaW46
DQpbICAgIDAuNTk3NDM1XSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRl
ZCA2LjAuMC1yYzEtMDAwMTEtZzhlMTQ1OWNmNGVjYSAjMQ0KWyAgICAwLjYwNjE4OF0gSGFyZHdh
cmUgbmFtZTogTWljcm9jaGlwIFBvbGFyRmlyZS1Tb0MgSWNpY2xlIEtpdCAoRFQpDQpbICAgIDAu
NjEzMDEyXSBlcGMgOiBfX2Nsa19yZWdpc3RlcisweDRhNi8weDg1Yw0KWyAgICAwLjYxNzc1OV0g
IHJhIDogX19jbGtfcmVnaXN0ZXIrMHg0OWUvMHg4NWMNClsgICAgMC42MjI0ODldIGVwYyA6IGZm
ZmZmZmZmODAzZmFmN2MgcmEgOiBmZmZmZmZmZjgwM2ZhZjc0IHNwIDogZmZmZmZmYzgwNDAwYjcy
MA0KWyAgICAwLjYzMDQ2Nl0gIGdwIDogZmZmZmZmZmY4MTBlOTNmOCB0cCA6IGZmZmZmZmU3N2Zl
NjAwMDAgdDAgOiBmZmZmZmZlNzdmZmIzODAwDQpbICAgIDAuNjM4NDQzXSAgdDEgOiAwMDAwMDAw
MDAwMDAwMDBhIHQyIDogZmZmZmZmZmZmZmZmZmZmZiBzMCA6IGZmZmZmZmM4MDQwMGI3YzANClsg
ICAgMC42NDY0MjBdICBzMSA6IDAwMDAwMDAwMDAwMDAwMDEgYTAgOiAwMDAwMDAwMDAwMDAwMDAx
IGExIDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgICAwLjY1NDM5Nl0gIGEyIDogMDAwMDAwMDAwMDAw
MDAwMSBhMyA6IDAwMDAwMDAwMDAwMDAwMDAgYTQgOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDAu
NjYyMzczXSAgYTUgOiBmZmZmZmZmZjgwM2E1ODEwIGE2IDogMDAwMDAwMDIwMDAwMDAyMiBhNyA6
IDAwMDAwMDAwMDAwMDAwMDYNClsgICAgMC42NzAzNTBdICBzMiA6IGZmZmZmZmZmODEwOTlkNDgg
czMgOiBmZmZmZmZmZjgwZDZlMjhlIHM0IDogMDAwMDAwMDAwMDAwMDAyOA0KWyAgICAwLjY3ODMy
N10gIHM1IDogZmZmZmZmZmY4MTBlZDNjOCBzNiA6IGZmZmZmZmZmODEwZWQzZDAgczcgOiBmZmZm
ZmZlNzdmZmJjMTAwDQpbICAgIDAuNjg2MzA0XSAgczggOiBmZmZmZmZlNzdmZmIxNTQwIHM5IDog
ZmZmZmZmZTc3ZmZiMTU0MCBzMTA6IDAwMDAwMDAwMDAwMDAwMDgNClsgICAgMC42OTQyODFdICBz
MTE6IDAwMDAwMDAwMDAwMDAwMDAgdDMgOiAwMDAwMDAwMDAwMDAwMGM2IHQ0IDogMDAwMDAwMDAw
MDAwMDAwNw0KWyAgICAwLjcwMjI1OF0gIHQ1IDogZmZmZmZmZmY4MTBjNzhjMCB0NiA6IGZmZmZm
ZmU3N2ZmODhjZDANClsgICAgMC43MDgxMjVdIHN0YXR1czogMDAwMDAwMDIwMDAwMDEyMCBiYWRh
ZGRyOiAwMDAwMDAwMDAwMDAwMGIxIGNhdXNlOiAwMDAwMDAwMDAwMDAwMDBkDQpbICAgIDAuNzE2
ODY5XSBbPGZmZmZmZmZmODAzZmI4OTI+XSBkZXZtX2Nsa19od19yZWdpc3RlcisweDYyLzB4YWEN
ClsgICAgMC43MjM0MjBdIFs8ZmZmZmZmZmY4MDQwMzQxMj5dIG1wZnNfY2xrX3Byb2JlKzB4MWUw
LzB4MjQ0DQpbICAgIDAuNzI5NTkyXSBbPGZmZmZmZmZmODA0NTdkZWE+XSBwbGF0Zm9ybV9wcm9i
ZSsweDgyLzB4YTYNClsgICAgMC43MzU1ODFdIFs8ZmZmZmZmZmY4MDQ1NTkzYz5dIGNhbGxfZHJp
dmVyX3Byb2JlKzB4MjIvMHhhNA0KWyAgICAwLjc0MTg0OF0gWzxmZmZmZmZmZjgwNDU1N2RhPl0g
cmVhbGx5X3Byb2JlKzB4MTNhLzB4MjdhDQpbICAgIDAuNzQ3ODE5XSBbPGZmZmZmZmZmODA0NTQ5
Zjg+XSBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHhjNC8weGVlDQpbICAgIDAuNzU0NDYwXSBbPGZm
ZmZmZmZmODA0NTU0ZDA+XSBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4M2MvMHgxOTYNClsgICAgMC43
NjEwMTNdIFs8ZmZmZmZmZmY4MDQ1NTJjYz5dIF9fZGV2aWNlX2F0dGFjaF9kcml2ZXIrMHhhMi8w
eDE4Yw0KWyAgICAwLjc2Nzg1M10gWzxmZmZmZmZmZjgwNDUyODRhPl0gYnVzX2Zvcl9lYWNoX2Ry
disweDc2LzB4YmENClsgICAgMC43NzQwMTZdIFs8ZmZmZmZmZmY4MDQ1NDdjYT5dIF9fZGV2aWNl
X2F0dGFjaCsweGEwLzB4MTVhDQpbICAgIDAuNzgwMTc5XSBbPGZmZmZmZmZmODA0NTQ4OTY+XSBk
ZXZpY2VfaW5pdGlhbF9wcm9iZSsweDEyLzB4MWENClsgICAgMC43ODY3MzJdIFs8ZmZmZmZmZmY4
MDQ1MjljNj5dIGJ1c19wcm9iZV9kZXZpY2UrMHgyZS8weDdjDQpbICAgIDAuNzkyODk1XSBbPGZm
ZmZmZmZmODA0NGYyOTA+XSBkZXZpY2VfYWRkKzB4MjFhLzB4M2FhDQpbICAgIDAuNzk4NjkzXSBb
PGZmZmZmZmZmODA1YzMyM2E+XSBvZl9kZXZpY2VfYWRkKzB4MjgvMHgzMg0KWyAgICAwLjgwNDU3
OF0gWzxmZmZmZmZmZjgwNWMzYzU0Pl0gb2ZfcGxhdGZvcm1fZGV2aWNlX2NyZWF0ZV9wZGF0YSsw
eDg4LzB4YjINClsgICAgMC44MTIxODFdIFs8ZmZmZmZmZmY4MDVjM2U3MD5dIG9mX3BsYXRmb3Jt
X2J1c19jcmVhdGUrMHgxNGEvMHgxYTgNClsgICAgMC44MTkxMTddIFs8ZmZmZmZmZmY4MDVjM2Vh
Nj5dIG9mX3BsYXRmb3JtX2J1c19jcmVhdGUrMHgxODAvMHgxYTgNClsgICAgMC44MjYwNTNdIFs8
ZmZmZmZmZmY4MDVjM2YyYT5dIG9mX3BsYXRmb3JtX3BvcHVsYXRlKzB4NWMvMHg5Ng0KWyAgICAw
LjgzMjYwNl0gWzxmZmZmZmZmZjgwODJiYmFhPl0gb2ZfcGxhdGZvcm1fZGVmYXVsdF9wb3B1bGF0
ZV9pbml0KzB4YzIvMHhkNA0KWyAgICAwLjg0MDQwMF0gWzxmZmZmZmZmZjgwMDAyMGU4Pl0gZG9f
b25lX2luaXRjYWxsKzB4YmMvMHgyMTYNClsgICAgMC44NDY1NjNdIFs8ZmZmZmZmZmY4MDgwMTI2
Yz5dIGRvX2luaXRjYWxsX2xldmVsKzB4ODIvMHg5NA0KWyAgICAwLjg1MjgzMF0gWzxmZmZmZmZm
ZjgwODAxMWFlPl0gZG9faW5pdGNhbGxzKzB4NWMvMHg5OA0KWyAgICAwLjg1ODYxMV0gWzxmZmZm
ZmZmZjgwODAxMTRhPl0gZG9fYmFzaWNfc2V0dXArMHgyMC8weDI4DQpbICAgIDAuODY0NTgzXSBb
PGZmZmZmZmZmODA4MDEwZTA+XSBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweGJhLzB4MTA0DQpbICAg
IDAuODcxMjIzXSBbPGZmZmZmZmZmODA3NDY4NTY+XSBrZXJuZWxfaW5pdCsweDIyLzB4MWJhDQpb
ICAgIDAuODc3MDEzXSBbPGZmZmZmZmZmODAwMDM3MDA+XSByZXRfZnJvbV9leGNlcHRpb24rMHgw
LzB4Yw0KWyAgICAwLjg4MzIxOF0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0t
DQoNCkF0IGxlYXN0IEkgaGFkIHNvbWV3aGVyZSB0byBzdGFydC4gU2luY2UgUUVNVSByZXByb3Ms
IEkgY29udGludWVkIHRoZXJlIHdpdGg6DQoJJChRRU1VKS9xZW11LXN5c3RlbS1yaXNjdjY0IC1z
IC1TIC1NIG1pY3JvY2hpcC1pY2ljbGUta2l0IFwNCgkJLW0gMkcgLXNtcCA1IFwNCgkJLWtlcm5l
bCAkKHZtbGludXhfYmluKSBcDQoJCS1kdGIgJChkdGIpIFwNCgkJLWluaXRyZCAkKGluaXRyYW1m
cykgXA0KCQktZGlzcGxheSBub25lIC1zZXJpYWwgbnVsbCBcDQoJCS1zZXJpYWwgc3RkaW8NCg0K
RHVtcGluZyB0aGUgYmFja3RyYWNlIGF0IHRoZSBkZXZtX2Nsa19od19yZWdpc3RlcigpIGNhbGxz
aXRlcyBzaG93cyB0aGF0DQppdCBwYXNzZXMgZm9yOg0KLSB0aGUgbWFpbiBwbGwgaW4gbXBmc19j
bGtfcmVnaXN0ZXJfbXNzcGxscygpDQotIHRoZSAiY2ZnIiBjbG9ja3MgaW4gbXBmc19jbGtfcmVn
aXN0ZXJfY2ZncygpDQotIHRoZSBmaXJzdCA0IHBlcmlwaCBjbG9ja3MuLi4NCg0KSXQgZmFpbHMg
b24gImNsa19wZXJpcGhfdGltZXIiIC0gd2hpY2ggdXNlcyBhIGRpZmZlcmVudCBwYXJlbnQsIHRo
YXQgaXQNCnRyaWVzIHRvIGZpbmQgdXNpbmcgdGhlIG1hY3JvOg0KI2RlZmluZSBQQVJFTlRfQ0xL
KFBBUkVOVCkgKCZtcGZzX2NmZ19jbGtzW0NMS18jI1BBUkVOVF0uY2ZnLmh3KQ0KDQpJZiBwYXJl
bnQgaXMgUlRDUkVGLCB0aGF0IGJlY29tZXM6ICZtcGZzX2NmZ19jbGtzWzMzXS5jZmcuaHcNCg0K
QW5kIHllYWgsIHRoYXRzIHdlbGwgYmV5b25kIHRoZSBlbmQgb2YgdGhlIGFycmF5IQ0KDQpCb290
aW5nIHdpdGggZ2NjLCBhbmQgbG9va2luZyBhdCB0aGUgY2xvY2sgc3VtbWFyeToNCiAgbXNzcmVm
Y2xrICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgICAgICAgIDEgICAgICAgIDAgICAxMjUw
MDAwMDAgICAgICAgICAgMCAgICAgMCAgNTAwMDAgICAgICAgICBZDQogICAgIGNsa19ydGNyZWYg
ICAgICAgICAgICAgICAgICAgICAgICAwICAgICAgICAwICAgICAgICAwICAgICAxMDAwMDAwICAg
ICAgICAgIDAgICAgIDAgIDUwMDAwICAgICAgICAgWQ0KICAgICAgICBjbGtfcGVyaXBoX3RpbWVy
ICAgICAgICAgICAgICAgMCAgICAgICAgMCAgICAgICAgMCAgICAgMTAwMDAwMCAgICAgICAgICAw
ICAgICAwICA1MDAwMCAgICAgICAgIE4NCg0KVGhpcyBpcyByZXBvcnRlZCBjb3JyZWN0bHksIHNv
IGhvdyB0aGlzIHdvcmtzIGZvciBlaXRoZXIgZ2NjIG9yIGNsYW5nIG5vdywgb3INCmdjYyB3aXRo
IHRoZSBwYXRjaGVzIGFwcGxpZWQsIEkgYW0gbm90IHJlYWxseSB0b28gc3VyZS4uDQoNCk9uIHY2
LjAtcmMxLCBnY2MgYW5kIGNsYW5nIHNob3c6DQogIG1zc3JlZmNsayAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAxICAgICAgICAxICAgICAgICAwICAgMTI1MDAwMDAwICAgICAgICAgIDAgICAg
IDAgIDUwMDAwICAgICAgICAgWQ0KICAgICBjbGtfcnRjcmVmICAgICAgICAgICAgICAgICAgICAg
ICAgMCAgICAgICAgMCAgICAgICAgMCAgICAgMTAwMDAwMCAgICAgICAgICAwICAgICAwICA1MDAw
MCAgICAgICAgIFkNCg0KSSBndWVzcyB0aGlzIG1heSBmYWlsIGdyYWNlZnVsbHkgYXMgdGhlIHBv
aW50ZXIgaXMgYWN0dWFsbHkgbnVsbCwgYnV0DQp0aGUgZXh0cmEgbGV2ZWwgb2YgaW5kaXJlY3Rp
b24gYWRkZWQgYnkgbXkgcGF0Y2ggc3RhcnRlZCB0cmlwcGluZyB1cA0KdGhlIGVycm9yIGNoZWNr
aW5nLiBJIG11c3QganVzdCBub3QgaGF2ZSBub3RpY2VkIGJlY2F1c2UgSSBhZGRlZCBSVENSRUYN
CmluIGEgYml0IG9mIGEgaHVycnkgdHJ5aW5nIHRvIGZpeCBhIGJ1ZyBpbiB0aW1lIGZvciA1LjE4
Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtY2xrLzk4NmM3M2RmLTk2MzQtZDE4Yi1l
ZWQzLTM3NTg0ZmEyZWE4OUBjb25jaHVvZC5pZS8jdA0KDQpPYnZpb3VzbHkgSSd2ZSBnb3QgdG8g
Zml4IHRoZSBidWcgaXRzZWxmIG5vdywgYnV0IG5vdyBJIGFtIGxlZnQgd29uZGVyaW5nDQphYm91
dCBHQ0MncyBiZWhhdmlvdXIgcmF0aGVyIHRoYW4gY2xhbmcvbGx2bSdzIQ0KDQpUaGFua3MgTmF0
aGFuIC0gaWYgZXZlbiBqdXN0IGZvciBiZWluZyBhIHJ1YmJlciBkdWNrIDopDQoNCkNvbm9yLg0K
DQo+Pg0KPj4gRGlkbid0IGdldCBhIGNoYW5jZSB0byBsb29rIGF0IGRpc2Fzc2VtYmx5IGV0YyB0
b2RheSwgYnV0IGFzIEkgc2FpZA0KPj4gbGFzdCBuaWdodCBpdCByZXByb2R1Y2VzIHdpdGggR05V
IGJpbnV0aWxzLg0KPj4NCj4+IFRoYW5rcywNCj4+IENvbm9yLg0KPj4NCj4+IE9uIGFub3RoZXIg
bm90ZSwgYnJvdWdodCB1cCBvdXIgUUVNVSBwb3J0J3Mgc3RhdGUgdG9kYXkgc28gZml4aW5nDQo+
PiBpdCBpcyBub3cgb24gdGhlIGdvb2Qgb2xlLCBldmVyIGV4cGFuZGluZyB0b2RvIGxpc3QgOikN
Cj4gDQoNCg==
