Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06265827B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiG0N3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiG0N3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:29:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C323147;
        Wed, 27 Jul 2022 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658928559; x=1690464559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mm91TBiE1TlZsrImgmkcT/3A5Qw110rJF4uPxO09qjs=;
  b=tuMSbEPZKKxzSHOEUR1j8Gq73j6xBRRvqy3AhCE2quUOjK85occGs/Xc
   oXtt6coqiIXq8N/9dSGxxvUWWFwjS8U1qd6j4I4S3tEPzRW3a0kHEcl/4
   1E2Ox+3C4OeWG6mfgbujBjOJuU/uajoSLeDCcSynmetSld76qQ+govTcV
   JbjQYXWGwGe8XVDjU77+Rk760mML1Z42FicwYXV6efIS3ZfLBio56gzCH
   RyEBsbsOWWVhoG3og4LcMZ5OHRHd/U8WyZyi7N0AE1j8il/t9bGb+JZZ2
   a9h+5jvkxoQQ7X0W0z1KePjJqwk+tH4+0VprCmNwJblJEeaLQbvBtXbfn
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="106363915"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 06:29:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 06:29:16 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 06:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jits8wOhUt1eYwwYJCTDoMChuNn8gQ8fHg9m1rU8HMRBm4JIqocq0L55hZnAOraiHHUMQY+c2trRX7CZdFVOUmtAyJsEIEzG31gFi3gVsN+i8JD6Z1fpdiBi25hRreaCKMfC2XV1KaZlt+PM0c5kbJ4DhEA51QzOXOlUcetEclYllvmQLDr+9xLHGhcb5IaQBzy9KWb9P/Ek7GaRbl661JKGi48vc9nBNadN7oZTcqNEM7T5umpPx3dmZbuDP9mMwyWiJx0dbv3FLywKgvf5d1teEuwb0p9EvbPtEg8/y96zuJzYmApRhqGN1ZndhjF3w+02pBElOb4yRMn2UwLJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm91TBiE1TlZsrImgmkcT/3A5Qw110rJF4uPxO09qjs=;
 b=H3LHJ6T49nPnakBkIG1QXa9dV/N/tyo2+05GW2x8L961f5Sn7/WreiamY2T23IckexOPYIYQpPYMB+K1oGs9iqu5PxklI20nGMBTIn5yxWleP0mlj63H1gRfjzwHmb+3iOOgcHbaqI7jUhS98/PvrhFcC6Y+uobOtH+v9lvhVMXA8xHQl1aLQ4IbQFao5MFOzzHjotPmIpgusoi4UvKRlESc/BSaoD7IhME8FF7r6AvNj4C2li37WkW7fTy5vDUeqKR0zUWLioSbsBepMStvdy2OQt71+2AWQ0LqaVU3GQ7dS/GCI489wVN8Uo/9Q/wtJj6ZITRjxe6ZiGupSchStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm91TBiE1TlZsrImgmkcT/3A5Qw110rJF4uPxO09qjs=;
 b=uKybLObxjPCM9KYXZ724jqJUr5QOXy13RWiaCdpAwHn1KbE9FpcVaHtFczu41Wv7CHYAGQNykWgGbvjsmeuY6hhdT4CSAiyanTPXLfRv8c0cb144Voz79FTgyUQM8U7DL3YpZwZ1AIhbpGxivJi+jGnZCqjSveef/gt6i2lDGHU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.25; Wed, 27 Jul 2022 13:29:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 13:29:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.csengg@gmail.com>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <geert+renesas@glider.be>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Thread-Topic: [PATCH 4/6] dt-bindings: riscv: Add DT binding documentation for
 Renesas RZ/Five SoC and SMARC EVK
Thread-Index: AQHYoRqa9YiD9Yfw2Eu80dWx4G03OK2R6rmAgAADK4CAAA22gIAAAzUAgAAAzoCAABjHAIAAAfcAgAAKK4CAAARlgIAABXIAgAABLACAAAgYAA==
Date:   Wed, 27 Jul 2022 13:29:11 +0000
Message-ID: <5292fbdd-9eae-2398-1260-cbef652f6af2@microchip.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220726180623.1668-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <636e9214-4b36-e9a6-3c6b-b6edb944335e@linaro.org>
 <CA+V-a8sTw1qzuTeD2vb7RgDmmNdEP5qEcxXCjrFgkyrBrLrt5Q@mail.gmail.com>
 <e64cc15e-b31e-876d-b3cf-b60d255c495b@linaro.org>
 <CA+V-a8u1VW9xaj2KjySyMuegpisLVENO_6uJOpAFZGbKziYLYw@mail.gmail.com>
 <e31e0c1f-4755-704e-8428-93970877d8f5@linaro.org>
 <CA+V-a8sX=Frs_cds9MriauTFRvcZUNCvoeZ+SaC0GUpL7L6qhg@mail.gmail.com>
 <9f32a4a9-66b4-ba2e-1713-436103c2faf8@linaro.org>
 <OS0PR01MB5922763582B836DA45CDFF0886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <80f08089-e3bb-983e-313b-45613364829e@linaro.org>
 <OS0PR01MB5922FDF8CFFE44A611D3783886979@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <75e5ace3-3255-2302-65f5-9fbef9cb1147@linaro.org>
In-Reply-To: <75e5ace3-3255-2302-65f5-9fbef9cb1147@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a4ecf91-ccb6-49fa-2aee-08da6fd3fdb2
x-ms-traffictypediagnostic: DS7PR11MB5968:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCfLte+oeFfNGyGsjTb+KxXqGSCFwTeReSXpXthMbhJooFvS+w6oUhZCNQobsJqnIoYwzV6od9Ssi8SRUfVNXMHYhH453Ci2KrRN+UU8bgldazy9oiL8OR1XQKSgh/UVewuhASc1n21UMpRSO6tzEUQKjjsoXxFbu1ZydK6tW/CJh+LWP2xXp76Cm3FLEMArHz4tHreDOAUd9JoB3J8Iq9/wB/X4FCxTrpyiJD+wKiduVI6WUGgf/KuVRoU+28tNV/0qGEhMKHXKxUHp8vtnnnY2tf332Qbg1dET8Ctr1GutCTigI7Q/rpvgDNGzG0mzb7srTpC9ElcSlFXlgeuKE6nqQg+ohQBAXQ6yTIFpQqu/zz8U9kFHw7qzRshA39TcVcJgAamVQ7+EUBbhrMPOx5ZOQfW8S5YaQJtmxaKKiuCjKPfJv24jFMVLODsMbAdqN9m2920Vix46HY9mbfhvrGZ/3Ix9QQzwblTDHdlmEDwHolliF9prz47YcMqEBbfF67fjz4lJkQb1bxQFYyBpNKeSuqh35lPHyw/o9TeSMqrUfxLqy0HeWWPJ4AZ13OkXryk/GM+wGEkuLL+qJTpk9oZkTlixFGC1tYh55BOW8k4ijoIOsHPudnyzqLQjH1EvO4XThzGpX892fDaO7sTblR4j83mYf3mwlKVNSdJr+OsozeHlaHe9xvMbwuQlm1hwWIQ0KVeYQrepe5gzN/kWjZEfELuRxPdUv14PkW7eUCZ5t9S6h0ATcRGqykXn3o3j+ayqrk+7xtg8TBi4t+4bA1XpMppm4bfzTJ4x0K8T8AdagjX82hNUhMoWW0/nx7E+NQE4iRQAOdnVFtv3LDUr510E+jsncgMmqkMxatTv873lHjvjHBLWNeUfOpbrTj49
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(396003)(346002)(366004)(64756008)(5660300002)(66476007)(8936002)(76116006)(8676002)(4326008)(31696002)(316002)(54906003)(110136005)(86362001)(7416002)(6512007)(6506007)(6486002)(38070700005)(26005)(66446008)(31686004)(53546011)(478600001)(66556008)(71200400001)(91956017)(41300700001)(36756003)(2616005)(122000001)(38100700002)(66946007)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q210V2tMaHY4ZG0zTVF0YldDTGc2NkljR2RjWTNNeStwT2YzajQrdU5uNDZM?=
 =?utf-8?B?VE9xQnB0VVkvUWxMZkpJTkUxSDFjb2p5WitCMGN0QjcvSjlGUENYbXRuWHVQ?=
 =?utf-8?B?THl6N1FXOE1aVElRWEZYRTBOWW5sSzN0SEVjbEpycTRjelFGSmRhMVlROS96?=
 =?utf-8?B?bE91b1NIV3l5VlZPUklUZjI1anFNUmFmOUxlVHdiMEJWSitqa0FBb0NpK0Fr?=
 =?utf-8?B?a3liNVQ2eFpxS1g4dUZ0SjJOUk4reGtUdmsyZFhhRm9YTTY0NHNycE8waUd0?=
 =?utf-8?B?d012Q0Q2ZmhEelY1ZGZ2dk1DanVKRmtFekVoTE5hNnpqVjVRa0Rza1k3QlZi?=
 =?utf-8?B?NHBJUXJXUHBmWjRYdnFqTlI1UHl1dC9uNXRWL3FoVkRDMCttWGpHd0V1TEpM?=
 =?utf-8?B?SzFMT2pxVkM4aUszYXF2SGxYUi83RWxqejVrSzB3N0dHSzJnd294ajRXYWZL?=
 =?utf-8?B?MXd2dHFpcWFUM0xDZnVoWkg5bkdWU0twWEFBL3VxZVYwQzExaTE4SUJmYUF5?=
 =?utf-8?B?RHUrQjFYMk5nbFUzNzJjaG53Rk1lN1prUmN3UUlZdWVldmN3L1lXMUxHSzZu?=
 =?utf-8?B?NWYyd3VPODVEZFBSVXptOUl0RVhpNi84NjRVSzhGREZQSjJLUjdFbzNhZ2cx?=
 =?utf-8?B?eW10QVpxSWxncFBWRjZXbGJIRjR4VStqMEVHMFpvQW80SzhyMTdSUTJ3bERt?=
 =?utf-8?B?WlVwUFpkN3F5SElKUHlZTWlscU4yS0N3M0dSenNxWVZsMFJ0MDBBRndrMnB0?=
 =?utf-8?B?NkwvK3BTQzdlczlpaC9ka2NDbTBoZ1VTNCtVemY5bkIzL0VXL0haWGZWUFpt?=
 =?utf-8?B?SW55WHNkbnREeTh4bmYvUHI1czlXQlYxRFh5Sm1aQUJNeThEQ2U5WiswZW1K?=
 =?utf-8?B?MGFRazEyMHRiSDF3SXRPTG9GU3dLYzhNeFhPMXE3UGRjYjhja0FrbnRGT29w?=
 =?utf-8?B?dG1Xb3FCMFlkSk8ydlE2ajZiMWx0R3VrcVVIMElpZmtrUEYxczJLZDJMOWxs?=
 =?utf-8?B?QlY4akR6RzUwM2ZZbEMxeW5GYllHZFR2ZnQvRHBrb2lFR1A0cVJVZklvTjhW?=
 =?utf-8?B?TjhzT3FCNk1WdHZRK1NidjZBMnE1Zkx5b3JBUEIyUUxGUEh2UUh5WVh1ejln?=
 =?utf-8?B?cGhwMDduZWowc1VFRnlqcWNLaEc5M0hYRmJHZnN1MjFqTGdsaFFRWGhmTXdw?=
 =?utf-8?B?WWk4UGtzN3lpZTlKOFRLMTlsT1pvaGhXVkFqdTRYTG1YVFo1WUE3YWEyMCta?=
 =?utf-8?B?RzlMWjN2Qkg0VlJkOWMwZFVBQ05RTXlMa1Y5WlhpWEJlWU5hMjFVblkyZTZQ?=
 =?utf-8?B?Wnh1K290VXlRMEh1MWxwL1hMcS9hdkVxN1d4SFdraTQ5S245a21iYjJvaFZY?=
 =?utf-8?B?dGhaOXhPRTl2Sm13NEhxV3MzSldtSi9kWU00MDJTWnlwZmoxWFFISEJGT2Fi?=
 =?utf-8?B?ZWtkemh3RVBEVTJlTllFK21uT1lNdnlOM1NDdmkwRkc5cElqOXlJOWhNMGQz?=
 =?utf-8?B?dGwvMWNUdlFyUVlKWXI0VzlIUTVUZFUyanJrZzZaR3V6Sk83UG9ERXVZV3R1?=
 =?utf-8?B?M0h0Sk4yWVF0UEZRR3IwUy9NdnpjZU9xY3NrWWtBWHhVOEVhYlZqeHY2ZTA5?=
 =?utf-8?B?OGdTN3ppeUNWV1JGU0tLWktBQngrLzVFMEZWOXJYZlJRTzFON2p0RGR2S0Zo?=
 =?utf-8?B?M1o5M1lJUXpLVW0xWloydGVwNFEzZGhZK3hidjJUQ29nVTM1VWtLakt1RUFU?=
 =?utf-8?B?VTJsNmE2SE9pdW02VCtpbENzWEIxdVhNclF4Y0dsOERzK3lta1VLVGR3eGd6?=
 =?utf-8?B?dEVldlZTdVdVVWlYUk5CWGV4b1RQYWNCNjVBMXlDa0Q4QnZBbTVHNmZXVFcy?=
 =?utf-8?B?b1Q2S1Vidmk2Z3BhWVFaY2djazhmVGc1bmZZQTRuYUh6UmV1K0RQK1NFbjdl?=
 =?utf-8?B?V1AwOUJPWGF2SnUvTExWNWVKcXFEREQyVmZySGwvTnFyV2tUeTVua010Z3kx?=
 =?utf-8?B?K3dxU0FrbnZ4S05mSkhJYUNSMHFVQmIvYllsbGNHeEM0SitKM0V4NG1rZWtw?=
 =?utf-8?B?YklLUDlOaU0rV25Sc2VNSG9PSkF4QW84eDZIaFAyY3JTMWZyMlhiNXRaa0Fu?=
 =?utf-8?Q?hkBeG6DNB4wETMLORk8YnUo6K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F39F163C534F024B98D2B24C452C7767@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4ecf91-ccb6-49fa-2aee-08da6fd3fdb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 13:29:11.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRsWaCg/6ayDSOgSptpgy5Fq9ceC5V3vU5F/Dnr+GuY/DMzpeGUsIzyPKXpBPkXx079JD+xsLFWYDbwcG10b2QD11ExJMSkpQewnSlEYzhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDcvMjAyMiAxNDowMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyNy8wNy8yMDIyIDE0OjU2LCBC
aWp1IERhcyB3cm90ZToNCj4+Pg0KPj4+IFRoZW4gaXQgaXMgbm90IHRoZSBzYW1lIFNvQyEgU2Ft
ZSBtZWFucyBzYW1lLCBpZGVudGljYWwuIENQVQ0KPj4+IGFyY2hpdGVjdHVyZSBpcyBvbmUgb2Yg
dGhlIG1ham9yIGRpZmZlcmVuY2VzLCB3aGljaCBtZWFucyBpdCBpcyBub3QgdGhlDQo+Pj4gc2Ft
ZS4NCj4+DQo+PiBGYW1pbHkgU29DKFI5QTA3RzA0MykgaXMgYXQgdG9wIGxldmVsLiBUaGVuIGl0
IGhhcyBkaWZmZXJlbnQgU29DSWQgZm9yIHRha2luZyBjYXJlIG9mDQo+PiBkaWZmZXJlbmNlcyBm
b3IgU29DIGJhc2VkIG9uIEFSTVY4IGFuZCBSSVNDLVYgd2hpY2ggaGFzIHNlcGFyYXRlIGNvbXBh
dGlibGUgbGlrZQ0KPj4gcjlhMDdnMDQzdTExIGFuZCByOWEwN2cwNDNmMDE/DQo+IA0KPiBUaGlz
IGRvZXMgbm90IGFuc3dlciB0aGUgY29uY2VybiAtIGl0J3Mgbm90IHRoZSBzYW1lIFNvQy4gVGhl
IG1vc3QNCj4gZ2VuZXJpYyBjb21wYXRpYmxlIGRlbm90ZXMgdGhlIG1vc3QgY29tbW9uIHBhcnQu
IEkgd291bGQgYXJndWUgdGhhdA0KPiBpbnN0cnVjdGlvbiBzZXQgYW5kIGFyY2hpdGVjdHVyZSBh
cmUgdGhlIG1vc3QgaW1wb3J0YW50IGRpZmZlcmVuY2VzLg0KPiBOb25lIG9mIEFSTXY4IFNvQ3Mg
KFNvQ3MsIG5vdCBDUFUgY29yZXMpIGhhdmUgImFybSxhcm12OCIgY29tcGF0aWJsZSBhbmQNCj4g
eW91IHdlbnQgZXZlbiBtb3JlIC0geW91IGNvbWJpbmVkIHR3byBhcmNoaXRlY3R1cmVzIGluIHRo
ZSBtb3N0IGdlbmVyaWMNCj4gY29tcGF0aWJsZXMuDQoNCkkgd291bGQgaGF2ZSB0byBhZ3JlZSB3
aXRoIHRoaXMuIFRoZSBtb3N0ICJjb3JlIiBwYXJ0IG9mIHRoZSBTb0MgaXMNCml0cyBhcmNoaXRl
Y3R1cmUgYW5kIHdoaWxlIHRoZSBwZXJpcGhlcmFsIElQcyBtaWdodCBiZSB0aGUgc2FtZSBldGMN
CiYgdGhlIFJlbmVzYXMgbWFya2V0aW5nIHRlYW0gbWlnaHQgaGF2ZSBwdXQgdGhlbSBpbiB0aGUg
c2FtZSAiZmFtaWx5IiwNCmZvciB0aGUgcHVycG9zZXMgb2YgYSBkZXZpY2UgdHJlZSBJIGRvbid0
IHNlZSBob3cgaGF2aW5nIGEgY29tbW9uDQpmYWxsYmFjayBtYWtlcyBzZW5zZS4NCg0KQ29ub3Iu
DQo=
