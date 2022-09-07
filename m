Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18515B0A78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiIGQp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIGQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:45:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B1640E0C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662569100; x=1694105100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xCIyn3jqlOiR9ihONsREEaIhNpNbzs+vLQBv1EVaQmM=;
  b=PLVI5uSdTMaTekCKydgFT/3C4dr65fW3MGSGapryVF1k732/SSBwSqtZ
   dXu4OhNlz7lIlMihxetMYwlAFlsG7hjkLagwgERBuZczQvh7Ssl4S7991
   yfOqcTe94cvnHMRmIli8Nz1eaKBp8NEWVZFsRn2f5UId24pFWcU0Fe9tl
   3nmZbJe9IpNQv+vc8YsAPMF7SKADvpH3knwVE9PQrU61pUqAcEPrcfPhQ
   DIzgjaj3sTkiz0GhWetspD2laSRQoGEX7MjcmbtQ0GbfjjC0IJjOD4Bvu
   ec7Fdu5kWb2YjuAkG1JAhtxvefkNXjY4JEkny/hXB32MTGQtzwKD2Uh4t
   A==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="179568020"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 09:45:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 09:44:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 09:44:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft5scaUKLvp9ldXpyB6dnm//Ijoyr2p+xaCWwwqIfFd30xOdFhL4sGd1YxrdHXz//HVFsJHYJ94UiGg+Spm4FuJsuVOe3yOVL5PNJ1F3cyeYIDDbsNZbG8FYKjZHuoP/KJYRJph8xB7ZYicHJ7R7wp2qqipJC+EHnmvcvpTp/4X+WxqD6D/QYwCjbzXSGJgVyIYYpDcN8s1H3Fqzv377E/ov5+8zPYvC0PKhnC8U2mfbjbVWk59J27YGrL4xkKksC+I2oe9PH9BqOZbwNL3+bthbpGTYQtSijD4VYDBp/aqBkhJtQjfibpj+o8vr6/Nfh6Dl8763ZLhaCicQuvGg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCIyn3jqlOiR9ihONsREEaIhNpNbzs+vLQBv1EVaQmM=;
 b=VCTkKadcGqCgVmGpxx3PwGn77POZrBlq8FdYa0tGMsDoNYyXYWE0rreAjiD/9gzYUmSUN78SKM7CL7HUkOUsRpkuJFQng7JxdKzohdINtHSY1EChbhaf1Gd8C/VA8JPOZZDysg3Y8dNFfS4D28xanyqZINcHLsA4Boa5wuLDJ/vafXAlzkHxXDETI2/92CVxuF9Aupj+ZdcAsclguttkmRE/p0zuxSBXnKMqqvS/mqXw6NmtrfRWOAynqf9M9Qq9mHgjgIcN45PuDI5mBaA2ImLB2KYBJPFIZ+MG5ag/NW5Ak+gVu0ykGk3U5HYKkWWXQrZe1giHHTzDPw7qjoPkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCIyn3jqlOiR9ihONsREEaIhNpNbzs+vLQBv1EVaQmM=;
 b=SgO1sba28fTfVFbHiYPwiVxXIGt9sMm0+SJS6ogxiW1vMJ9GPYDmWj0zvUeFNcWt5KzhzzVB0hN8aNe3IE8Z1MMtWIG/UOJuqLAeyde2pC0jEA8inzOqQUvihmHj9nbszPQAD703cGhKhEh4/LpGSdi8QDJWfHo4USgKco8zJ7U=
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by BL1PR11MB5463.namprd11.prod.outlook.com (2603:10b6:208:315::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Wed, 7 Sep
 2022 16:44:55 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220%5]) with mapi id 15.20.5588.011; Wed, 7 Sep 2022
 16:44:55 +0000
From:   <Conor.Dooley@microchip.com>
To:     <will@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <sudeep.holla@arm.com>, <palmer@dabbelt.com>,
        <catalin.marinas@arm.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <atishp@atishpatra.org>,
        <Brice.Goglin@inria.fr>, <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] Fix RISC-V's arch-topology reporting
Thread-Topic: [GIT PULL] Fix RISC-V's arch-topology reporting
Thread-Index: AQHYsPRyXnHNGxm8rkSgpyoSWfWKT63UTuQAgAAAnICAAADmAA==
Date:   Wed, 7 Sep 2022 16:44:55 +0000
Message-ID: <d1a6f072-d182-5150-043f-bffac0524b62@microchip.com>
References: <4849490e-b362-c13a-c2e4-82acc3268a3f@microchip.com>
 <afa3b7a8-3615-36bb-4850-b7966028f74c@microchip.com>
 <20220907164140.GA30683@willie-the-truck>
In-Reply-To: <20220907164140.GA30683@willie-the-truck>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83430a91-57dc-478b-1b22-08da90f04afc
x-ms-traffictypediagnostic: BL1PR11MB5463:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h5M4fG5jvJpfC6LFJ/K5oGI3LBT/AGQLJbzE+zM9NnV4eFKfS4dlWpXoBXnQRIZPHuQtFSdP6YnZcEEb4AFjDcnZ0OEODst7P3IzNBU5asSYG3epntt8BsbGgE36dFw7e3uw3RT7OhZ+VfCeFqQJlMn52lmlvLYvA7fIK2RZPQ9RnReHECroWhwGDafPy9muvTuN9ALfubpfYnxMoRKGd+fiO6JP1FJ6BPOlRs7Z/cFzB9NijpMIUrkVAAWUKTEYt/7rC3iiAqr2gYiLtHvlTr+UzIlPpSD/UVg9hghON6vMG+EpAuwCrvJWeX4Y0yUscd4lycfxzMxfQjOT3HeYeGs+eVsK/pLhJCCSMljnQNGFjs3PIVRgC5lPc1Inu1L2nKWJQi29bETJO4T+6vqvl/B7TAQheAy5BiaftJx0UHNr0tAxpKltmnRo1zcKqfE9zFAddNayh8/GDCT+LvE3+tLIyHJ5BV5Y8VkWY1teoGkO3nBShFvSbxij6YntfDQIHp3zQOodMVt5KfKm+GD0P3iXshQHX11xo54jc8tSkLmiZNFHVpO/eU4D2nRhCKlfilNUjH5GEctLclNkSbt75SIAyRtDrVV2UcpmHxpY/0S1+mu3yjacraXnOpRlmI9DQS/YFZO7EuRwLZCxG7vOiLMb+0KbXWzl5AKts+bCuYji/AqY/G2wCf2DuvHolc6L0cMG6CsGuAQGYBIv8Xpl/eZ9WwaDVTYh+y5F54FAXBsOCdi9+GDBRYFpuTBRTAkwuvKCtRKCHFyFcvT/A7YPrnigfwyeOM1hnxMnZ01A9jhBbh2SsrxQo31onI0i1BgvfHhTfkwmUkFkdViZtq+ci+Yhe18Skb5YYzoxpUukZ2GKvzgH0OxxFEddXM3bq24BYccUCRVwZAUfNdVcXxER+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(366004)(39860400002)(136003)(86362001)(41300700001)(7416002)(5660300002)(6506007)(316002)(54906003)(6512007)(2906002)(31696002)(110136005)(26005)(53546011)(71200400001)(38100700002)(66476007)(186003)(66446008)(66946007)(76116006)(64756008)(66556008)(2616005)(8936002)(4326008)(6486002)(8676002)(966005)(122000001)(91956017)(36756003)(478600001)(31686004)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGdIYUsxclByaDhhQkVlbUkxMjRaZzZqdXh1SjhhTlhsdmRoUnZHSFZCd3Nn?=
 =?utf-8?B?bDdIYXNkMGh4M1RvLzZmcnUzOU5tQ2t5bW40K21GU2NVNG85dGdSZTY0eXNF?=
 =?utf-8?B?QjJ2VjcwOERTWDlKS3psWGd3UmoxMDg2b1BlUWg3WC9NMEdrSDVEMnVYZXFo?=
 =?utf-8?B?Q1VIU01CMnlQMEt0MHRHWm5tZnh6RFpPU05tVkd1bGhGd0xTQVJMR05Pa29y?=
 =?utf-8?B?TU04OGlEWE5iVzd2VG1lVWxXdzY1UGdhMktEVEp3UG1rMFQ3aHpDb3p1WDFR?=
 =?utf-8?B?U3ppVHJpR0VkY0RnenFYNE9uQkxzUllmVGkyY0d1SU5OMkJZcHNyUkhRcURC?=
 =?utf-8?B?NkpTMVFMM083dXlydVhPOVdiRXp4T0RtYUhKV2U1TGN2SHowYlVGYlJaazlF?=
 =?utf-8?B?QzZKSnE2ejdFbjhxaXNEa003ZUN4OE15ai9oTXFVRkhqdVE5aGFvNE9acmxC?=
 =?utf-8?B?cjRIVWRWa0RDTzlnQXo5NjNjM3VFQVhBVE43U3MvYjR1cy9UVFl1UTlPRndY?=
 =?utf-8?B?STlGRkl6dnRNU2d1Q0JKMlJUM3VXNDU5WVU2aGRFYThYRzg0Z0VMTlRWVW1R?=
 =?utf-8?B?SW1zWDAxOFhwZU5EY0doUTdQUVNBOG9oKzVPMk1EazF3L1dDamx4aTduc3Jr?=
 =?utf-8?B?RHVIblNLL1V0QUhyVWJsNWpjb2pmbFJwNkZOQk8reHVZd3lLbXZkc0lkUUlO?=
 =?utf-8?B?a05OM1dKMzVWVU01WVgrTldsNjlBNU1scy83a21VM0dBNUlFNm5hbER3bjk0?=
 =?utf-8?B?MXJESTNwZHl3Qm9QSkE1akxYNVE5elRCL1V4UnpZMHZ5dVhZYWhhNWZTb0tp?=
 =?utf-8?B?OGQxeS9YOG1JN1JHcjJPQ1FZT1IrdzRpT0hRU0FJa2IyaEJ5TEU0YWdxbGtU?=
 =?utf-8?B?VlQrZEtndTdScDR1aHp4dUVvUjR5dlh4Tkp3dG1mWHErMEVqdkNlR216aDFI?=
 =?utf-8?B?aVYyUmVmd1BOcnYvaUpCWXM0d1VlV2NNOHFaTmV5Ti9xWXh4RlY3UzIyeUVk?=
 =?utf-8?B?UFJ1L1pnem9ndmgzNmltZHJZK3NoVUs3WGpQay9xc2VPZjR3U3kxNzVRNm0y?=
 =?utf-8?B?L2s2Z1BsMmhFZ3BjK0FBSzEvWU9MZTdSVHI2V1pGZHNMNGp3Q2N1RWJlZUdL?=
 =?utf-8?B?WEc0MXk4UytMclNMdWZqdFZUVCtjeWdHVjc3d05JYmFDbXVXVzhLWnBrVDZW?=
 =?utf-8?B?Q0g3WHJScU9iT2Zyc3RqOWtxWjdWY0hLSnR2RGlSWDRnVUxoTXJ2aG0rMGZP?=
 =?utf-8?B?MEJXS0hpaktCZXozc3ZoOFJDckZuWmtROUkxM0hoY0R3RE55Mml3K3JXd3lI?=
 =?utf-8?B?MUQ4N1M5S0JzSDl3U3J6S29xVmJ2Ti9CMUhMS2ozZ0Rjc1Bwbk13dWhINmZJ?=
 =?utf-8?B?NVZHM2toOTJOQ2JIemJCMHdJUDFmQ1dGdUtFQjMvZXg3ZVJwbzdnV25DMk5R?=
 =?utf-8?B?S2x2VFRLOENUSlY4WWhLZkVadmMrMWJCakw5YWRCQzA0RzZTS3BpT2dKQ0pW?=
 =?utf-8?B?K256ZXdtNTNxajhhaVpBZVlHVUdMYjA4azkrTlY1ZG9jd05jUm9rZWJuNS9P?=
 =?utf-8?B?L1p2WlVBS0RzUk1XampEa2JoUlNlK3EzSmZEVVlMUlNxTUVibUVIZmkxU2dO?=
 =?utf-8?B?WGY3SjRDUldjYWtTTDNqQ0lXTVNJakhTTHN4cGtweU5wTU55SWVPRmYzOFVS?=
 =?utf-8?B?bXBjUTJnMHdmeEd0czJRTFc4aWJGb0ZVSm5oN0xleXFwaXgrQUpsY1RwRnNr?=
 =?utf-8?B?NGw2VWdobm5zK2RwajVxVDRIdmk4KzUrM2RNNVdhNW1BbHJiWGljK29ncVNL?=
 =?utf-8?B?T1RZQ3RSTWZURlJvZW5kNHNOSnczMmdzMFBSY2p6T0tTVlBtd3lOZjMyeEFt?=
 =?utf-8?B?aTZHWGxTZ1hRM2RRL2pNM2JtTytBbEpQVk9iZnlzUnVjT0VGUHZsOWdGZmty?=
 =?utf-8?B?STZQWFpiaHZCMGZqQVpQZG1NeHNXOG90SzRkTlVKcXd6YlR6V1V3WW1uWmJC?=
 =?utf-8?B?UDZNNHZQZXZkSDBFdmloWSs5Y3MrRVcrK0UwNnhRWmszb3RqcWhCV3FZaENx?=
 =?utf-8?B?NzZ1M2M2VkhMd1VhbTQrZWs3ZnY0RDFtWUZTdVk4QituaG85ZXFJdHBwUkRz?=
 =?utf-8?Q?mK6lO4t+VbarWGLd9ZRTiyQQ5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFAD852E460C44438B1F257BA376E7E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83430a91-57dc-478b-1b22-08da90f04afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 16:44:55.0620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oJnYlIQdMW7k/c53rfPy9K0iraBZGIOaT8GD2QBCYlhwLP9C+yvuqpjHAHWgpe5q1+ttdY+d59E6rflUoMAQRIRchCFGKyvNG0zdN04HVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5463
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDkvMjAyMiAxNzo0MSwgV2lsbCBEZWFjb24gd3JvdGU6DQo+IE9uIFdlZCwgU2VwIDA3
LCAyMDIyIGF0IDA0OjM5OjMxUE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4gT24gMTUvMDgvMjAyMiAyMzoxNCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4+IEhl
eSBXaWxsL1BhbG1lci9TdWRlZXAsDQo+Pj4NCj4+PiBDYXRhbGluIHN1Z2dlc3RlZCBbMF0gZHJv
cHBpbmcgdGhlIENDOiBzdGFibGUgZm9yIHRoZSBhcm02NCBwYXRjaCBhbmQNCj4+PiBpbnN0ZWFk
IG1ha2luZyBpdCBhIHNwZWNpZmljIHByZXJlcSBvZiB0aGUgUklTQy1WIHBhdGNoICYgbWFraW5n
IGEgUFIsDQo+Pj4gc28gaGVyZSB3ZSBhcmUuLiBJIHdhcyBzdGlsbCB1cCB3aGVuIC1yYzEgY2Ft
ZSBvdXQgc28gcHVzaGVkIGl0IGxhc3QNCj4+PiBuaWdodCB0byBnZXQgdGhlIHRlc3QgY292ZXJh
Z2UsIGJ1dCBMS1Agc2VlbXMgdG8gbm90IGhhdmUgcmVwb3J0ZWQgYQ0KPj4+IGJ1aWxkIHN1Y2Nl
c3Mgc2luY2UgZWFybHkgb24gdGhlIDEzdGggc28gbm90IGhvbGRpbmcgbXkgaG9yc2VzISBJIGJ1
aWx0DQo+Pj4gaXQgYWdhaW4gZm9yIGJvdGggQVJNcyBhbmQgUklTQy1WIG15c2VsZi4NCj4+Pg0K
Pj4+IEkgdGFnZ2VkIGl0IHRvbmlnaHQsIHNvIGl0J3Mgb24gY29ub3IvbGludXguZ2l0IGFzIHJp
c2N2LXRvcG8tb24tNi4wLXJjMQ0KPj4+IHdpdGggdGhlIHByZXJlcSBzcGVjaWZpZWQuDQo+Pj4N
Cj4+PiBOb3Qgc3VyZSBpZiB5b3Ugd2FudCB0byBtZXJnZSB0aGlzIHRvbyBTdWRlZXAgb3IgaWYg
dGhhdCdzIHVwIHRvIEdyZWc/DQo+Pg0KPj4gV2hhdCdzIHRoZSBzdG9yeSB3aXRoIHRoaXMgZnJv
bSBhbiBhcm02NCAmIHRvcG9sb2d5IFBvVj8NCj4+IFBhbG1lciBtZXJnZWQgdGhpcyBpbnRvIHJp
c2N2L2Zvci1uZXh0IGEgY291cGxlIHdlZWtzIGFnbywgc28ganVzdA0KPj4gd29uZGVyaW5nIHdo
YXQgdGhlIGNyYWljIGlzIG9uIHRoZSBvdGhlciBmcm9udHMuDQo+IA0KPiBJZiBpdCdzIG1lcmdl
ZCBpbiB0aGUgcmlzY3YgdHJlZSwgdGhlbiBJIGd1ZXNzIHdlIGRvbid0IG5lZWQgdG8gZG8gYW55
dGhpbmcNCj4gb24gdGhlIGFybTY0IHNpZGUuIEl0IHdvdWxkIGJlIGhhbmR5IGlmIGl0J3Mgb24g
aXRzIG93biBicmFuY2gsIGhvd2V2ZXIsDQo+IGp1c3QgaW4gY2FzZSB3ZSBydW4gaW50byBhIGNv
bmZsaWN0IGxhdGVyIG9uIGR1cmluZyB0aGUgY3ljbGUuDQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Nvbm9yL2xpbnV4LmdpdC9sb2cvP2g9YXJjaC10
b3BvDQoNCkZXSVcgaXQncyBoZXJlIGFzIDIgY29tbWl0cyBvbiB0b3Agb2YgdjYuMC1yYzENCg0K
PiANCj4gQ2F0YWxpbiAtLSB0aGlzIGlzIHRoZSBzZXJpZXMgd2Ugc3Bva2UgYWJvdXQgdGhlIG90
aGVyIGRheSB0b3VjaGluZyB0aGUNCj4gdG9wb2xvZ3kgY29kZS4NCj4gDQo+IENoZWVycywNCj4g
DQo+IFdpbGwNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1yaXNjdkBsaXN0cy5p
bmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtcmlzY3YNCg==
