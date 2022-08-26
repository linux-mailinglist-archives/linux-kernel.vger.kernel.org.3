Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D995A2D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbiHZR2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiHZR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:28:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA303D86D3;
        Fri, 26 Aug 2022 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661534898; x=1693070898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=70dRe/FHZTVHaTjje4zrRq11TGxd6q/kSbKOzG7/i2A=;
  b=gChnLEL6x4TNUQb4qw1CjPNtSZdsazR0X89tz+x2hxaC1OWeZQZQaRHl
   vMEAb1+HHLEY1vCHI9rhjlYDljQK4qYSM5w13IKiQz3/DsQ/UnYAItfhm
   u9VDeI+WbwHXLhMjj6Nf9YgjKnWEsXIomogPvigOFBGoL176lKWFd/ACC
   zf5JWxTcn4fuInF1IOdTsQrwpncY/HU4Q6zBOyCJyL4iVw2tp7uxAbKst
   S9lxC9SZJE+3zuTKkXETo9gnHDKfH230e+LnuavNOLRyGgRt/XsczELC0
   uBXd/qrF2v0r753B112kbOtOVz404M/qHQ9eFjyRdx/Sb+aAD21MAOW7w
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="110945606"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 10:28:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 10:28:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 26 Aug 2022 10:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqtTZiwG2qdHfhW2EBdyrzSmdpEh2SuPUkRgRZ+DPJomfSeOssLm40Lhm0vm2Ht6m9wTxLnAF7+1Rce0AwVDWoiD+97yzz4lhAJJ18r2GkCYE++MvBJa/fhKNNuTJjEApyenemoUtdMWtcDDrOod+qqx5WaI46lkKBrExFoWWFFnjagveXtGIe9ar91uChQyM7TEpbF/hQTeqZjv1emo9G4XFSP4Fpj4tIJsPkLu3a+FhGRccDLi47YzceLiCDACb0dK6chHOo6/a4dNZFmGv4rO3ShoY/xkNIkRvDlXQRayx246Wm5mm23y2OTs97Lwx3FaNvd1pTudklXs+kLFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70dRe/FHZTVHaTjje4zrRq11TGxd6q/kSbKOzG7/i2A=;
 b=lSPvJ9t7HZL+N28InUx5c37awg/Nu4kSQRGfKG/4zPzJh0QMHnZty13eSwS/WCNVIXDyhzE2sQrWaqwrMyd1ffMOIENQ0s/4jCbj6U8GX8Cb30HmsOIsP0feZBS4jeMF850CLd9+Vk9VH1h6GCY5LaFUHdoFb+lhX70v4vLrO5wq6fKSrPoWgrij5BNe2RP+CwWzsLpx0aPiauW+cFfgua/ItMpjfYsJ3Eb2rlg7jkkVkux5GPSR64so6sk5K0qc4H1i9urjV8IzNh0iCVss8wUyBZbcIG0S69aMglU5rexpdHg+GZT3UK7WpKpdkcwqv9oDK8Rm1hiWVYRqRaQ2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70dRe/FHZTVHaTjje4zrRq11TGxd6q/kSbKOzG7/i2A=;
 b=qFQyumVgpfCw2Y5vpRQva2tw+EQavXvFH7K8ViIXE+oZctGEJKq/ufcx1JdCQuqbAsl7NRNEdWsqIZtVAwL0JtPEyDI9MPp0OahZc6Zyy2ksIS/8ssvaCQZqWkzUsscKlr+YVVsiHBI5qarXJrIXh9sn3h40GO8PCg/DE+Of/N8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BY5PR11MB4183.namprd11.prod.outlook.com (2603:10b6:a03:18e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 17:28:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:28:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <atishp@atishpatra.org>, <anup@brainfault.org>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <paul.walmsley@sifive.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <cmuellner@linux.com>, <philipp.tomsich@vrull.eu>
Subject: Re: [PATCH] drivers/perf: riscv_pmu_sbi: add perf_user_access sysctl
Thread-Topic: [PATCH] drivers/perf: riscv_pmu_sbi: add perf_user_access sysctl
Thread-Index: AQHYuV7zIdZzt1WIp0+BPxs9hl7WLK3Bb6IA
Date:   Fri, 26 Aug 2022 17:28:01 +0000
Message-ID: <9650ad31-d59e-9325-1e05-73261960ccdc@microchip.com>
References: <20220826151556.1708879-1-heiko@sntech.de>
In-Reply-To: <20220826151556.1708879-1-heiko@sntech.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cf2b0f4-620d-4e62-d5fd-08da8788538c
x-ms-traffictypediagnostic: BY5PR11MB4183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRbl3xI4n0ZSOjS8Gi69keHVIV2aGzeLikmEa47unCLXuAIClTRCqq5/QBewT8gNdWCwSS3oJcqXlcnpe/MQKAsictbm0KK/0O6hC11U62i5YI1L31/HnBRpuE/hQ5J2UtV2e/lBPRd7r1bpGSGxlAeBf/KwD/lb+hLV5lTI/W3p7n99SxMB+Kz2Zi6d/4AAIR5AJ35zUors9WOM28tuJ5C9snqDVeW44xEZQAoTUIsWBh9SgvCz7avPgWfODYG7UUErSTjBvWselqKbhw90XbAdDjuHiCmwqOunFKqMEXvMADwkqcEMsLy0C9fNVr9zp3iQiO0uaJyj0up/dWg6BYJkPY+PQ+Cjy7wqgxGpbC37Cm6NtrYE4pU81nc3phCMPavYawN/yAHMn8fMOd5uvO9TLjSFLtaBip78XFxysMPgk9NpbIRVgf27qhxe0IWkV4ZQkPOdpj8ybRmjY6O/jfmnn8NofNaislAAgh/5rteyl40LVnLq/PJGBaKaL8a7YqgaoBIxkEns8TqeJ+e9nhJKzHlMllbkYxaa3XoRWCGxf9Nt1scwrMjAXAx82n4nJUNt3bfmwSzDMf87UqzeqLI+2SfoX7D7jYP4D6bHC2Cmnui7K1AATiaDd0w0HNGpIMa1GGV4BqkO4TeXJRivET1R2JnnkmVLY1QQ3Ipfbvqnr0t8nEpS98M3khNRcsQHBPN/URg3/4iuw+9otJM7gYY1v650QmcD9PpLCM774ow91ICSzSrgUHO0EpNpjj2qbVUaa/cqygBC6eesxjF80GMw/iMZe0oGdEGlz8HauKyf1nqHRaZ3GrNyLJbcF6r/0JgOliYHE3gzwJ4veni6PYnPKLPsHRIV1lVQExVmCz8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(396003)(136003)(39860400002)(31696002)(5660300002)(86362001)(36756003)(26005)(31686004)(71200400001)(41300700001)(7416002)(6512007)(66476007)(66556008)(91956017)(8936002)(2906002)(2616005)(8676002)(64756008)(6506007)(76116006)(53546011)(66446008)(66946007)(4326008)(38070700005)(110136005)(122000001)(83380400001)(6486002)(186003)(478600001)(966005)(54906003)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk1BS0VUVHVMRXV0UTQ5SlgzOUpMZ0lITFBQcEp2WUNzdHdIRTBTajhkTUVY?=
 =?utf-8?B?U3E4WG1jdW5IRWJjRWgwd0U2RDBlQnJJU2hsWlVQQVNZTWhhZG9DVDN1TlN6?=
 =?utf-8?B?NXMwajVYd0hhZUF4bFd6WFE4bExMMEdKODVaYytlYmFpaHZNdjVFczdxK0pL?=
 =?utf-8?B?aGxrZG16bDlTb0VYRC9QR2haZ2k0ejFTMjZnVTZHek4rTUl3M2EyYjlGd0Rs?=
 =?utf-8?B?WlJXRXhZbjhrOTdoK0RQOXdmdzlmMzZxdE0yRys1Mmdjdmxsd0dpZ1dVR241?=
 =?utf-8?B?eHJHeDJSa1F6M3p6OTNqRjgwbjJtMzBBZ3U3MFNIRUlhTEJ4RDI2OHRGd1V6?=
 =?utf-8?B?eWtFNHJ3RzdCM3V3bzB4Q3psRHRWNk9lWHIwTU5jM1NldFlwOUxPbHRNOWZk?=
 =?utf-8?B?ZStGMXFGRWJ3VW1QMm9FQk5rd09kREhGUmlyeVpRbTNwcDRRS1BvWUFOang0?=
 =?utf-8?B?RC9hUncvZnZNZWRtYW02TU1mQUtwY25xYmc1UkZlbE1qLzcvTlFseklrVEVi?=
 =?utf-8?B?ZzBJMytrQnE5anNRMmYySXQxR3M5YTRLMjc1S3VuMlY1WXpiSFlNTUN3QTYz?=
 =?utf-8?B?QytIYmg1Z2d3K0lBK3FhcmFJQ0JxUFQ1aXlmSGNGakZ2bzhjT00rQlZRWVNz?=
 =?utf-8?B?OWZyV1I2akxMV2hyZnVLaVdYTnhSL05FbGRpeWtOb3kzOHlYOEZLUy9wNG9t?=
 =?utf-8?B?TmVNaGtQZGo4UTdmRzBVVlZ4MXAwMWhCMEtWbDNOdEFJU21EemJJYmlQbmdP?=
 =?utf-8?B?TldWeDdtTlNGS05CdnlRSnBzU3g4UE9IM0c3NmI0dDdkbi9zeFlPNWg2OHR2?=
 =?utf-8?B?czlzQjNiT1VzUE4zRVBZSll6YW4vcFR6bGxVSjY5MUxLQWVOMzcxL2J6OTJL?=
 =?utf-8?B?SG11S1FQREtpcDJIL2FtS2xURklVZy9OclMzMDVvaDJ3Z0xlajlsRU9SbElT?=
 =?utf-8?B?Q1pVbjhZOWFMR3FSTUFrZGpGKzRIY3Q1dk9QMjZGRi9PbXM5Y3ZiV3Y2bHZB?=
 =?utf-8?B?V3NaVEVoYU1vWXdoTWcvdnRMc2JkdU1WOGo2aitDZlg1bGhEUHFzS0dHZy9x?=
 =?utf-8?B?M1BjUW93NnMzYU8rUU4vaGl4andFc05UMkJZMllLUEpoWDdZZWRqU1h1ZUZw?=
 =?utf-8?B?bnQ1YVpwRHp2UmZIdFdrY3MyclhaTnVtSkt2ZzBlVy9OTVNRK0c2ZG1CY2l5?=
 =?utf-8?B?YW56U0RidlpGU1NWOFZybzBjU0czbjU0Y0E1TTNLbjdTb1JWVTFNK2NMNThw?=
 =?utf-8?B?UnBlNnkzZUpScy95M1l4UVRHZE80OXU3dlFVT2ZCbXhLVHgvbC9FU2xUVGow?=
 =?utf-8?B?blNCOTI2NlVlQ012K0ZTTEVSSXZpMkxGODNkYUFJQUs1amZOcXRYYWtUQ0ZF?=
 =?utf-8?B?TW9RMVVuK09MZEYwVEpsU0p3Yno2V2pqV21JaEhsTldlRnUwaXE0U3g1b1k3?=
 =?utf-8?B?c3VmbWdWNEw4WFAzZVpVMjFnekZUV1llV0lvTGlsR1ArNDRHWWRVbFp1b3RD?=
 =?utf-8?B?RGNoeUgveFhIcmIzV2c4TUxnaElXZVRyUGNWTUNRUkN6S0VjS2Npdkt1Ym40?=
 =?utf-8?B?SHNuMHkvcFhPTGtyVHQwRUJCa29lZXkraFNmalBMWjlwZElPOFFnVTVFTjBT?=
 =?utf-8?B?QmVFQittMHU3dnhoME13akJQK3I5dUpkdTl4MzYxRW9IN0FXNlByaVdtdklu?=
 =?utf-8?B?a29kZ2JQb0hEakUwYkszakNuSCt4enJ1aVJ1VXlGaFFNdnFCeUN5TnliOGlD?=
 =?utf-8?B?YUJtT29jMys5QmtiZE91S25FNkYxallRUXZEcFF4ejQ4K3F6bTExZFBIaEhr?=
 =?utf-8?B?LzNaWTRDMjJJSGpqeEVITXMzbjBHRFRUNWlXZ2RGZktIZnEzUmdpL1VNWURn?=
 =?utf-8?B?L0pnTzE5cTdtR3FMSTZkS0YxSW5icjJXbk9ycVVUellwVU9WZ0h5ZWZ1Skl2?=
 =?utf-8?B?amc1VHZLTjFxR0R1Tm45SDY1K2N5U3F5TU1aY1lpa05aUjh4SlkxdzdweFh2?=
 =?utf-8?B?dnRkZE1WWlp5dUFCalpQNGwzQWpxd3ZsRFdQUmYyeUNRM1gvMTdTcXBnTWdq?=
 =?utf-8?B?Qk0xTE83c1hjUTlSY25US0hsTXBFSjRwMHkraHVkVkhDRTc5aitHR0ZiNjFD?=
 =?utf-8?B?cmJkdXk3elFzVDJXb0hTV2N1blh6bEt3cnc5WXRwaVNBbk51dTJyQ0xxckhm?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7831CA7AE8E0B14AB94362AEE5264A59@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf2b0f4-620d-4e62-d5fd-08da8788538c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 17:28:01.2762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJUPql79QFttQYHQFXPljwBymb/f6i1RdDFKP6Bjf/zipQQryDPuaQVAQQF/xMmdpQR/gO7osbvxvMLBka1hXFsHdIetemsLG0TcE19Jkpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4183
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEhlaWtvLA0KQ291cGxlIGNvbW1lbnRzLCBtb3N0bHkgbml0cGlja3kgc29ydHMgb2YgdGhp
bmdzLi4NCg0KT24gMjYvMDgvMjAyMiAxNjoxNSwgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQWRkIGEgc3lzY3RsIHNpbWls
YXIgdG8gdGhlIG9uZSBvbiBhcm02NCB0byBlbmFibGUvZGlzYWJsZQ0KPiBhY2Nlc3MgdG8gY291
bnRlciBDU1JzIGZyb20gdS1tb2RlIG9uIFJJU0MtVi4NCj4gDQo+IFRoZSBkZWZhdWx0IGlzIG9m
IGNvdXJzZSBzZXQgdG8gZGlzYWJsZWQga2VlcGluZyB0aGUgY3VycmVudA0KPiBzdGF0ZSBvZiBh
Y2Nlc3MgLSB0byBvbmx5IHRoZSBUSU1FIENTUi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlaWtv
IFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9zeXNjdGwva2VybmVsLnJzdCB8ICA2ICstLQ0KPiAgZHJpdmVycy9wZXJmL3Jpc2N2
X3BtdV9zYmkuYyAgICAgICAgICAgICAgICB8IDQzICsrKysrKysrKysrKysrKysrKysrLQ0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvc3lzY3RsL2tlcm5lbC5yc3Qg
Yi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3N5c2N0bC9rZXJuZWwucnN0DQo+IGluZGV4IGVl
NjU3MmIxZWRhZC4uZWZkNGJjMzg1ZTdhIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Fk
bWluLWd1aWRlL3N5c2N0bC9rZXJuZWwucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUvc3lzY3RsL2tlcm5lbC5yc3QNCj4gQEAgLTg5NCwxNSArODk0LDE1IEBAIGVuYWJsZWQs
IG90aGVyd2lzZSB3cml0aW5nIHRvIHRoaXMgZmlsZSB3aWxsIHJldHVybiBgYC1FQlVTWWBgLg0K
PiAgVGhlIGRlZmF1bHQgdmFsdWUgaXMgOC4NCj4gDQo+IA0KPiAtcGVyZl91c2VyX2FjY2VzcyAo
YXJtNjQgb25seSkNCj4gLT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiArcGVy
Zl91c2VyX2FjY2VzcyAoYXJtNjQgYW5kIHJpc2N2IG9ubHkpDQo+ICs9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCj4gDQo+ICBDb250cm9scyB1c2VyIHNwYWNlIGFjY2Vz
cyBmb3IgcmVhZGluZyBwZXJmIGV2ZW50IGNvdW50ZXJzLiBXaGVuIHNldCB0byAxLA0KPiAgdXNl
ciBzcGFjZSBjYW4gcmVhZCBwZXJmb3JtYW5jZSBtb25pdG9yIGNvdW50ZXIgcmVnaXN0ZXJzIGRp
cmVjdGx5Lg0KPiANCj4gIFRoZSBkZWZhdWx0IHZhbHVlIGlzIDAgKGFjY2VzcyBkaXNhYmxlZCku
DQo+IA0KPiAtU2VlIERvY3VtZW50YXRpb24vYXJtNjQvcGVyZi5yc3QgZm9yIG1vcmUgaW5mb3Jt
YXRpb24uDQo+ICtTZWUgRG9jdW1lbnRhdGlvbi9hcm02NC9wZXJmLnJzdCBmb3IgbW9yZSBpbmZv
cm1hdGlvbiBvbiBhcm02NA0KDQpDb2RlIGFzaWRlLCB0aGlzIHJlYWRzIHNvbWV3aGF0IGNvbmZ1
c2luZ2x5LiBIb3cgY29tZSByaXNjdiBkb2Vzbid0IGhhdmUNCmZ1cnRoZXIgaW5mb3JtYXRpb24g
dG8gb2ZmZXI/DQoNCkV2ZW4gaWYgd2UgZG9uJ3QgaGF2ZSBhbnl0aGluZyBmcm9tIGEgcmlzY3Yg
cG9pbnQgb2YgdmlldywgaXQgd291bGQgcmVhZA0KYmV0dGVyIGlmIHRoaXMgc3RhdGVtZW50IG1l
bnRpb25lZCB3aGF0IGl0IGlzIGFib3V0IGFybTY0IHRoYXQgcmVxdWlyZXMNCm1vcmUgaW5mb3Jt
YXRpb24uIFNvbWV0aGluZyBsaWtlICJmb3IgbW9yZSBpbmZvcm1hdGlvbiBvbiBhcm02NCBvbmx5
DQpmZXR1cmVzIHgsIHkgJiB6Ii4NCg0KPiANCj4gDQo+ICBwaWRfbWF4DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BlcmYvcmlzY3ZfcG11X3NiaS5jIGIvZHJpdmVycy9wZXJmL3Jpc2N2X3BtdV9z
YmkuYw0KPiBpbmRleCA2ZjY2ODFiYmZkMzYuLjdhYWI4ZDY3MzM1NyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9wZXJmL3Jpc2N2X3BtdV9zYmkuYw0KPiArKysgYi9kcml2ZXJzL3BlcmYvcmlzY3Zf
cG11X3NiaS5jDQo+IEBAIC00MSw2ICs0MSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmli
dXRlX2dyb3VwICpyaXNjdl9wbXVfYXR0cl9ncm91cHNbXSA9IHsNCj4gICAgICAgICBOVUxMLA0K
PiAgfTsNCj4gDQo+ICtzdGF0aWMgaW50IHN5c2N0bF9wZXJmX3VzZXJfYWNjZXNzIF9fcmVhZF9t
b3N0bHk7DQo+ICsNCj4gIC8qDQo+ICAgKiBSSVNDLVYgZG9lc24ndCBoYXZlIGhldGVyZ2Vub3Vz
IGhhcnRzIHlldC4gVGhpcyBuZWVkIHRvIGJlIHBhcnQgb2YNCg0KTm90IGluIHlvdXIgY2hhbmdl
cywgYnV0IHMvaGV0ZXJnZW5vdXMvaGV0ZXJvZ2VuZW91cw0KDQo+ICAgKiBwZXJfY3B1IGluIGNh
c2Ugb2YgaGFydHMgd2l0aCBkaWZmZXJlbnQgcG11IGNvdW50ZXJzDQo+IEBAIC02NDAsMTMgKzY0
MiwyMiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgcG11X3NiaV9vdmZfaGFuZGxlcihpbnQgaXJxLCB2
b2lkICpkZXYpDQo+ICAgICAgICAgcmV0dXJuIElSUV9IQU5ETEVEOw0KPiAgfQ0KPiANCj4gKy8q
DQo+ICsgKiBEZXBlbmRpbmcgb24gdGhlIHBlcmZfdXNlcl9hY2Nlc3Mgc2V0dGluZywgZW5hYmxl
IHRoZSBhY2Nlc3MNCj4gKyAqIGZyb20gdXNlcm1vZGUgZWl0aGVyIGZvciBhbGwgY291bnRlcnMg
b3IgZm9yIFRJTUUgY3NyIG9ubHkuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lkIHJpc2N2X3BtdV91
cGRhdGVfdXNlcl9hY2Nlc3Modm9pZCAqaW5mbykNCj4gK3sNCj4gKyAgICAgICBjc3Jfd3JpdGUo
Q1NSX1NDT1VOVEVSRU4sIHN5c2N0bF9wZXJmX3VzZXJfYWNjZXNzID8gR0VOTUFTSygzMSwgMCkg
Og0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAweDIpOw0KDQpUaGlzIGZpbGUgZG9lcyBub3QgY29tcGx5IHRvIDgwIGNoYXJhY3Rl
ciBsaW1pdHMgdG8gYmVnaW4gd2l0aCwgc28gSQ0KdGhpbmsgdGhpcyB3b3VsZCBiZSBiZXR0ZXIg
b24gYW4gODIgY2hhcmFjdGVyIGxpbmUgdGhhbiBicm9rZW4gdXAuDQoNCj4gK30NCj4gKw0KPiAg
c3RhdGljIGludCBwbXVfc2JpX3N0YXJ0aW5nX2NwdSh1bnNpZ25lZCBpbnQgY3B1LCBzdHJ1Y3Qg
aGxpc3Rfbm9kZSAqbm9kZSkNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgcmlzY3ZfcG11ICpwbXUg
PSBobGlzdF9lbnRyeV9zYWZlKG5vZGUsIHN0cnVjdCByaXNjdl9wbXUsIG5vZGUpOw0KPiAgICAg
ICAgIHN0cnVjdCBjcHVfaHdfZXZlbnRzICpjcHVfaHdfZXZ0ID0gdGhpc19jcHVfcHRyKHBtdS0+
aHdfZXZlbnRzKTsNCj4gDQo+IC0gICAgICAgLyogRW5hYmxlIHRoZSBhY2Nlc3MgZm9yIFRJTUUg
Y3NyIG9ubHkgZnJvbSB0aGUgdXNlciBtb2RlIG5vdyAqLw0KPiAtICAgICAgIGNzcl93cml0ZShD
U1JfU0NPVU5URVJFTiwgMHgyKTsNCj4gKyAgICAgICByaXNjdl9wbXVfdXBkYXRlX3VzZXJfYWNj
ZXNzKE5VTEwpOw0KPiANCj4gICAgICAgICAvKiBTdG9wIGFsbCB0aGUgY291bnRlcnMgc28gdGhh
dCB0aGV5IGNhbiBiZSBlbmFibGVkIGZyb20gcGVyZiAqLw0KPiAgICAgICAgIHBtdV9zYmlfc3Rv
cF9hbGwocG11KTsNCj4gQEAgLTc4NSw2ICs3OTYsMzIgQEAgc3RhdGljIHZvaWQgcmlzY3ZfcG11
X2Rlc3Ryb3koc3RydWN0IHJpc2N2X3BtdSAqcG11KQ0KPiAgICAgICAgIGNwdWhwX3N0YXRlX3Jl
bW92ZV9pbnN0YW5jZShDUFVIUF9BUF9QRVJGX1JJU0NWX1NUQVJUSU5HLCAmcG11LT5ub2RlKTsN
Cj4gIH0NCj4gDQo+ICtzdGF0aWMgaW50IHJpc2N2X3BtdV9wcm9jX3VzZXJfYWNjZXNzX2hhbmRs
ZXIoc3RydWN0IGN0bF90YWJsZSAqdGFibGUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlu
dCB3cml0ZSwgdm9pZCAqYnVmZmVyLCBzaXplX3QgKmxlbnAsIGxvZmZfdCAqcHBvcykNCg0KSSBh
c3N1bWUgY2hlY2twYXRjaCB3aWxsIHdoaW5nZSBhYm91dCB0aGUgYWxpZ25tZW50IGhlcmUuDQoN
Cj4gK3sNCj4gKyAgICAgICBpbnQgcmV0ID0gcHJvY19kb2ludHZlY19taW5tYXgodGFibGUsIHdy
aXRlLCBidWZmZXIsIGxlbnAsIHBwb3MpOw0KPiArDQo+ICsgICAgICAgaWYgKHJldCB8fCAhd3Jp
dGUpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+ICsgICAgICAgb25fZWFj
aF9jcHUocmlzY3ZfcG11X3VwZGF0ZV91c2VyX2FjY2VzcywgTlVMTCwgMSk7DQo+ICsNCj4gKyAg
ICAgICByZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIHN0cnVjdCBjdGxfdGFibGUgc2Jp
X3BtdV9zeXNjdGxfdGFibGVbXSA9IHsNCj4gKyAgICAgICB7DQo+ICsgICAgICAgICAgICAgICAu
cHJvY25hbWUgICAgICAgPSAicGVyZl91c2VyX2FjY2VzcyIsDQo+ICsgICAgICAgICAgICAgICAu
ZGF0YSAgICAgICAgICAgPSAmc3lzY3RsX3BlcmZfdXNlcl9hY2Nlc3MsDQo+ICsgICAgICAgICAg
ICAgICAubWF4bGVuICAgICAgICAgPSBzaXplb2YodW5zaWduZWQgaW50KSwNCj4gKyAgICAgICAg
ICAgICAgIC5tb2RlICAgICAgICAgICA9IDA2NDQsDQoNCk1peGVkIHVzZSBvZiB3aGl0ZXNwYWNl
IGhlcmUsIHNvbWUgYXJlIHNwYWNlcyBhbmQgc29tZSB0YWJzLi4NCg0KVGhhbmtzLA0KQ29ub3Iu
DQoNCj4gKyAgICAgICAgICAgICAgIC5wcm9jX2hhbmRsZXIgICA9IHJpc2N2X3BtdV9wcm9jX3Vz
ZXJfYWNjZXNzX2hhbmRsZXIsDQo+ICsgICAgICAgICAgICAgICAuZXh0cmExICAgICAgICAgPSBT
WVNDVExfWkVSTywNCj4gKyAgICAgICAgICAgICAgIC5leHRyYTIgICAgICAgICA9IFNZU0NUTF9P
TkUsDQo+ICsgICAgICAgfSwNCj4gKyAgICAgICB7IH0NCj4gK307DQo+ICsNCj4gIHN0YXRpYyBp
bnQgcG11X3NiaV9kZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
IHsNCj4gICAgICAgICBzdHJ1Y3QgcmlzY3ZfcG11ICpwbXUgPSBOVUxMOw0KPiBAQCAtODM0LDYg
Kzg3MSw4IEBAIHN0YXRpYyBpbnQgcG11X3NiaV9kZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgZ290
byBvdXRfdW5yZWdpc3RlcjsNCj4gDQo+ICsgICAgICAgcmVnaXN0ZXJfc3lzY3RsKCJrZXJuZWwi
LCBzYmlfcG11X3N5c2N0bF90YWJsZSk7DQo+ICsNCj4gICAgICAgICByZXR1cm4gMDsNCj4gDQo+
ICBvdXRfdW5yZWdpc3RlcjoNCj4gLS0NCj4gMi4zNS4xDQo+IA0KPiANCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGlu
ZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KDQo=
