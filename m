Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D995A6644
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiH3O0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiH3O0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:26:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA14BD4FB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661869605; x=1693405605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Nzfte33TfwdNPC0Yw7KDDU7ix+I/reykY89quQq3bGA=;
  b=p5kQxVMFkaiFj0KLeczdiD9AnV6NIVQdzILiLvItbZsJnOATV9R3QISC
   kM0ZZOv8j1Oph+PvqbEuWVwLAHrADH07a1V9ji+WhCtmlcMBQyMQuxC1N
   vzKISjVaPeJ53QOcf24MOC3ADAUne0XMzlqKSUtraeNMkaTR8OhoOG2Y0
   IxxeGloClAo8rQNzH2ah/geHq1/dON7loUMlWkIfpUqG89jrcVuydeQJ6
   E5gAEzviJnKnZb/oarlin1YsYBvn8ylPvolx2fjiOgi+E0WS4kZsAINbb
   4xPIKQDMokkDm3wGYjpy4mYRWe4Y6PCXQCZPXnJDvt+S85p5fRuFPrZz2
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="171602748"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 07:26:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 07:26:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 07:26:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyxeXeoz1BjLQ/RNcjpt7L+sBR1FaDR1L6BxTeVcUlRggtusdndkeFrJoGirFpdSZfd1mX22uzax6EQoZfAF9vD1VEEbCt8ScnPV3m5/Vk3rV2zDIy3414z05Z02YmNZGCrhtyqDi+aOmWnH7Q+F/Q1NyV+VQR1rJcp/x0RQzlsUa+8PDL8rpuQ3jkasidDePWqrSnyI2BuvEwIs3zsHSmtYPXTC+RdFjq7VrQTYtk3rhJIOPV0lXnAez4TOcKO4mr7Q7Lo0RuBQi3p4e2qOZtRk6+qoQWd8gZIpr8TzZUk3BnWOxnLQbN23Nv8Xhotq9VYcG19v5sn8903878ayCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nzfte33TfwdNPC0Yw7KDDU7ix+I/reykY89quQq3bGA=;
 b=aitq83mdS7BMH1JgNBnzphTclEuAV/hicfsmTQjMCYBwcxd2yrFNPer16cqAPyGcceIUXSwb47xGZMF2kEu4S7sdh7OzBuoyvEOdkNdLkUcDllV8FQELVHzLxArfpJAm0k4duat87LHTtT4Tis+1GQEqHwzGesKyVSSWgU8m/zuFg14hauZ+1F2XUO5TwQn/dcwt9wAxzhN9vuguVVCh4ZADLKQhIO5B6518c06Kkx5kIMm/N8LlcXL+VIVOXl6DM/7xOiXS7CO/XyzqhzUI9/sRU891jQEAFTm+vrRevmeq7ksCUHPPO2ul9UNbkoHkQwEHT4rP5gdY5n3GSP6D8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzfte33TfwdNPC0Yw7KDDU7ix+I/reykY89quQq3bGA=;
 b=d4mOlmKB1M8C2wvpzSyhV82vOtCKQT+9bfzhlSsGJP2nctk2SSILDSIYPCteLzQcm46dwaPHCNYKiy7vTY9jwLyGd3STshQIhwzVquao0UJ++Azq7YNQwIW28H/XPJUkOSYUEst5+q+QtGzvbAhk1kz+hz0R8EJm5RAwlTlN9hU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5437.namprd11.prod.outlook.com (2603:10b6:5:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 14:26:38 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 14:26:38 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jszhang@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] riscv: enable THP_SWAP for RV64
Thread-Topic: [PATCH v2] riscv: enable THP_SWAP for RV64
Thread-Index: AQHYufzf4JJbBuNch02tBI9sTRPCrK3DP5sAgAKut4CAADcFAIABWCIAgAAEioCAAAMJgA==
Date:   Tue, 30 Aug 2022 14:26:38 +0000
Message-ID: <22c254ae-2b84-1342-4b2d-f532f34e2c94@microchip.com>
References: <20220827095815.698-1-jszhang@kernel.org>
 <0256a458-440c-171c-2a6f-e88a50c16f82@microchip.com>
 <YwzI7VmfFnOvYWgf@xhacker>
 <4037b310-47c4-ca30-d4b6-a284e87da437@microchip.com>
 <Yw4XwsVQBB1HRw04@xhacker>
 <d9331af0-58bc-ed3b-10f5-8509795e3198@microchip.com>
In-Reply-To: <d9331af0-58bc-ed3b-10f5-8509795e3198@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60a2c7c0-b1a6-42fa-cb11-08da8a93a652
x-ms-traffictypediagnostic: DM4PR11MB5437:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b23Nmp++eoTxcwV3qwNGsgT4sKfvXQr+zIH2zdTMpw1UQfrcX07u0SzkAMGggL/p12rxHlA9k3F5ONi957epzfHOb06l9Mhb5bytZjIcjtWIvk2UhDSLNWEMzWRG9aoGicojlGNtIfqFamzFutsi4c/DqRGASy+lam0wdHZJuJi9pTL2P6zACAgWeLLRqsn+1hCfY4l+L6OT7wP1TCXRbrwZg80rYIuOUOBNoVBR1ySI8w2Cscro2O/Y2v6ecLhXofcJq22TLlVljbwpb43tFv7zV9jKr8AGFPyM7EoshN/z8ygYTjCac2XxgcIZ1/38D3sCpOZu56k7+9qOwhgdq/8oPXTzQGRnME7gGaAg7LhYxnG1Uk10cQ+Zr9klO7EG2GCyAGJ+4nt56w1qwU34g8T7nzGYN3cocFyVB4tWVT63z6WaJibX58wsX/cQuHIA7bnomXXy3FKuJAna447y0B2yZCFGLFXFiA73X0m+r6lg/J5mbIWVj1hn92NN+qadoJmzJCxjEGZvGbwN+f0Zf+lxeD6WDFk08Z1usj00Fju8E0zL2fUoxGwD5i7cdhqZoKh3lqi2aor2yBlxTGfud+tALJoJMIwLXXaP3JqShsvS/K3bUQA5CW41rSdGVUPT2P3e8nGKb3PFAW2y3FLxPN/NW2eF9O8jonNesa34O3sayCRfUYbdL+2UXJun3hY5qJdl8deBCv5+kE0OoFAJCZ2pUaKBccizXoZgm8Ec/7rJsubLJzUf2Smj7WUjqjmriLeGaxsBQ+2Z5JWQJWuPngBDWsnmI6UEA8otyHKiSzIiBqljsXK95aDAWDrVBqZoCz/WJFpcs63Xbz/2aLu5HQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(376002)(396003)(39860400002)(66446008)(54906003)(64756008)(66556008)(66946007)(4326008)(5660300002)(8936002)(8676002)(66476007)(26005)(2616005)(76116006)(36756003)(31686004)(316002)(6916009)(2906002)(91956017)(6486002)(41300700001)(478600001)(6506007)(53546011)(86362001)(6512007)(71200400001)(31696002)(38070700005)(83380400001)(186003)(38100700002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1BaU0xNZEVqV0Z2Z1o1alhDdzU4ekhSRjVDS3NVdkxyZk15aWxueTR2c3Fw?=
 =?utf-8?B?QjltMVVIVGt0MVFualE2blAvV3AzZG5GeEFTTUU3Mjk3K0duWFFTNkwxWVZD?=
 =?utf-8?B?S0E4ejZ3TjFRQ2NRRHBOWXpVaGJFU1k0aisvTngxeGFqOTRUYVhoQUIxNkRI?=
 =?utf-8?B?VGNxbC8rd2VYM0lXNk10RjB2dEtxMkxkQ3Jka0RKSndDb1BhaWJiZGpqZ0FR?=
 =?utf-8?B?RS8vNlVDNFcwbTRhRG9OZjFVdE1LbXJPVEZOd0Y0RlJSV2VGc2p0aU16Qjcv?=
 =?utf-8?B?RW9TNXYzS3NURjRBa0RIeDVYTGJ3cnMwczk0c2dtUytHWmF1aklpb0FMQ1Zj?=
 =?utf-8?B?Z0ZSVUEvODl5VTBoa2wzM1ZoNGJickRGN3VvaTY3N0FvTXV3WFlzODg1NXEz?=
 =?utf-8?B?clVwWHkrZTA2WkFJUzQ4MkFRL3R1L0t5YzlKd1ZqZm90cWVGN2IwQUdZYysx?=
 =?utf-8?B?dEhYd2xxcUxobGdKdkt0UVl4OGFVME1zT3I4bVZqSVViNW8xdmJlaENPYXVD?=
 =?utf-8?B?NGRrUUVsd2IvdWt2UXVacTJZaDQwYVc3VUZZWWdQeExDWWpjWENnM0ZMVE9O?=
 =?utf-8?B?SUZnbm10dnZQNzczYThObDNuT3pkWk5teU1YLzFGM3pyenUwRURwc2x5SmNC?=
 =?utf-8?B?U1g2cC85Y3dmR0NEazFYZG5mYlhQUFJJbnFMU0JEREhpZU8zT2J3dUpmeTI5?=
 =?utf-8?B?UDdJUUhYUDQzQStqOTdZS2lLaEN0cGwvNWEvdDdDeFJ1OGFjM0MrM1NPZVYz?=
 =?utf-8?B?SkZEMVJUbHhSVnlLbWUrRE9Zd2lQY2Jra0hQTmtxeE5UYUhpd1pTclVKZTZW?=
 =?utf-8?B?eUF3TDRSZlVtaGtqS29mOWIvUjNHaHZ5YVBYb1NTaUlKblBIWGozaXNBeWYr?=
 =?utf-8?B?ZXVtdlowTDhKcXQxTEtTYmpHSHY1NVZ3UHdTTTFhVU8vdEtpWmc5aGJ0dU9Z?=
 =?utf-8?B?enhzaXk1RlV6SGR0ZHdZWDVqV0N1R0E0UlNaRHh0NUNLbE1YNlF2S2t0NCth?=
 =?utf-8?B?eGluWWRHY1ZPWTBtbHRuL1pJaDhLWUNHS0JTM0ZHd3hKYUlacVNSZW5JTnJ2?=
 =?utf-8?B?TmQ1U1h1NENYODdqQkpvc3RHS21lQksxUEFiWTA2dUhZMnhqTUFEWXlrTlhq?=
 =?utf-8?B?ODNqNE5tZWducloyOFhoYmlKTy8vRVdTVGZiN0IzTkdPUG1zc0wvaUk5cDVO?=
 =?utf-8?B?aTVxMmphTjgzZThEcnp5amxlSmlWUThvN2hMdWRvMkRwL2IxaHJKSWQveDFO?=
 =?utf-8?B?WEJHYzkzb3VYMWN6bm9HTS9tTndJa2hEblBXdmxIbkRGMkZDMVplei9RcUJl?=
 =?utf-8?B?UDR0V0twMDQxVmdTVmJ1OVN0eVBjRGtTb3BRZUNvNy9lbXJJVU9DRmZ6ZnF4?=
 =?utf-8?B?K3hZRmFhY2lxMUtKbDFHMmEzTHpZbUhqVjRIb08vUXZMbnRlQ3Z0TEtaRWxU?=
 =?utf-8?B?N0gxNHd4Y3oxZDhtRGlQVWdaTzM1Nkl6cUU0Qm1zNmp5bTM1Q0ZHZjBkVGRo?=
 =?utf-8?B?WGx6aDhWczdGUzhrVE1tUUpaeE1mSWMrTU1OOUQ1TmVJTk1RblBWMDU3V0Vw?=
 =?utf-8?B?Z3Z2bEh3MjdlZG1VNFZCS2lzNjhUNkFMNEJ5VEtFSVRIR3dycVVHdnpEUDhl?=
 =?utf-8?B?UkxBaDRIajE0RlUyaUpqeUdCcFByaldFN0padXVxRC9jWlZ5bzc5K2xFZVRz?=
 =?utf-8?B?eFVaSldiTTB5c1kwSHFKS0phOThZNndtKzdIeXBqYWZWd2w1M0N4dFF4dDlr?=
 =?utf-8?B?QlRoQVdQdFNmUVdXSFV2VmFYQ0tmcXpITEw1dmpVOUk5bU5zS0FXUVlKV2lD?=
 =?utf-8?B?K0pkbjJqRTRxZmt3Q0duNVlEVTZOQmZoeDgxdFlxeFgzbVlPOWc3UVZCUEE5?=
 =?utf-8?B?MElHdDZvN29zK2JCYjd3YTQ4ZVFHWTlqSXBuL0xQb2NicTNvM1kvd3VZN1Fp?=
 =?utf-8?B?aCtKY0JFQUNyQ3ZZWnR1SFdVTHZiaWQrN0VQTVdsc2FBVmhJSjNnVDVMd0V4?=
 =?utf-8?B?MEE1MHRFTXRrM3RCNU9IK1lrdjBFWkNuRlNJSWY4Q252TkZSOWZzNjF4VWdF?=
 =?utf-8?B?ODA3ZVdpRVJWMjEvSUFUR1ZCK3lqU3Q0Wm1rM0VCNG1LOWZnS1R5dzFsS1py?=
 =?utf-8?B?UjVPbHNQVGZPL0ZLV0xlQ1NoZThaYWxQNlJ2bFNuYkVXNmlUUyt5VnluUSty?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <631BB8EB030D9F428B3E294FF4A09CBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a2c7c0-b1a6-42fa-cb11-08da8a93a652
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 14:26:38.0988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9bcPIc7aDiR/fNeAM9IuULT5KxQq/hFqH9y/0aot+jsjBMEOvaVF5XJfxbbFw3tuvj4j2qNsH3C3EfgEJxnRfl/I/xCzXr5lDPfB5VWEvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5437
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxNToxNSwgQ29ub3IgRG9vbGV5IC0gTTUyNjkxIHdyb3RlOg0KPiBPbiAz
MC8wOC8yMDIyIDE0OjU5LCBKaXNoZW5nIFpoYW5nIHdyb3RlOg0KPj4gT24gTW9uLCBBdWcgMjks
IDIwMjIgYXQgMDU6Mjc6NDhQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+Pj4gT24gMjkvMDgvMjAyMiAxNToxMCwgSmlzaGVuZyBaaGFuZyB3cm90ZToNCj4+Pj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+DQo+Pj4+IE9uIFNhdCwgQXVn
IDI3LCAyMDIyIGF0IDA5OjEzOjAzUE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29t
IHdyb3RlOg0KPj4+Pj4gSGV5IEppc2hlbmcsDQo+Pj4+DQo+Pj4+IEhpIENvbm9yLA0KPj4+Pg0K
Pj4+Pj4gT24gMjcvMDgvMjAyMiAxMDo1OCwgSmlzaGVuZyBaaGFuZyB3cm90ZToNCj4+Pj4+PiBJ
IGhhdmUgYSBTaXBlZWQgTGljaGVlIFJWIGRvY2sgYm9hcmQgd2hpY2ggb25seSBoYXMgNTEyTUIg
RERSLCBzbw0KPj4+Pj4+IG1lbW9yeSBvcHRpbWl6YXRpb25zIHN1Y2ggYXMgc3dhcCBvbiB6cmFt
IGFyZSBoZWxwZnVsLiBBcyBpcyBzZWVuDQo+Pj4+Pj4gaW4gY29tbWl0IGQwNjM3YzUwNWY4YSAo
ImFybTY0OiBlbmFibGUgVEhQX1NXQVAgZm9yIGFybTY0IikgYW5kDQo+Pj4+Pj4gY29tbWl0IGJk
NGM4MmMyMmMzNjdlICgibW0sIFRIUCwgc3dhcDogZGVsYXkgc3BsaXR0aW5nIFRIUCBhZnRlcg0K
Pj4+Pj4+IHN3YXBwZWQgb3V0IiksIFRIUF9TV0FQIGNhbiBpbXByb3ZlIHRoZSBzd2FwIHRocm91
Z2hwdXQgc2lnbmlmaWNhbnRseS4NCj4+Pj4+Pg0KPj4+Pj4+IEVuYWJsZSBUSFBfU1dBUCBmb3Ig
UlY2NCwgdGVzdGluZyB0aGUgbWljcm8tYmVuY2htYXJrIHdoaWNoIGlzDQo+Pj4+Pj4gaW50cm9k
dWNlZCBieSBjb21taXQgZDA2MzdjNTA1ZjhhICgiYXJtNjQ6IGVuYWJsZSBUSFBfU1dBUCBmb3Ig
YXJtNjQiKQ0KPj4+Pj4+IHNob3dzIGJlbG93IG51bWJlcnMgb24gdGhlIExpY2hlZSBSViBkb2Nr
IGJvYXJkOg0KPj4+Pj4+DQo+Pj4+Pj4gdGhwIHN3cCB0aHJvdWdocHV0IHcvbyBwYXRjaDogNjY5
MDggYnl0ZXMvbXMgKG1lYW4gb2YgMTAgdGVzdHMpDQo+Pj4+Pj4gdGhwIHN3cCB0aHJvdWdocHV0
IHcvIHBhdGNoOiAzMjI2MzggYnl0ZXMvbXMgKG1lYW4gb2YgMTAgdGVzdHMpDQo+Pj4+Pg0KPj4+
Pj4gSSBrbm93IHRoZSBvcmlnaW5hbCBjb21taXQgbWVzc2FnZSBjb250YWlucyB0aGlzLCBidXQg
aXQncyBhIGxpdHRsZQ0KPj4+Pj4gb2RkLiBJZiB0aGUgcGF0Y2ggL2VuYWJsZXMvIFRIUCB0aGVu
IGhvdyB3b3VsZCB0aGVyZSBiZSBUSFAgc3dhcA0KPj4+Pj4gcHJpb3IgdG8gdGhlIHBhdGNoPw0K
Pj4+Pg0KPj4+PiBobW0sIGl0J3Mgc3dhcCBJJ2xsIHNlbmQgYSB2MyB0byBjb3JyZWN0IHRoZSBk
ZXNjcmlwdGlvbi4NCj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBJbXByb3ZlZCBieSAzODIl
IQ0KPj4+Pj4NCj4+Pj4+IEkgY291bGQgbm90IHJlcGxpY2F0ZSB0aGUgYWZ0ZXIgbnVtYmVycyBv
biBteSBuZXpoYSwgc28gSSBzdXNwZWN0DQo+Pj4+PiBJIGFtIG1pc3Npbmcgc29tZXRoaW5nIGlu
IG15IGNvbmZpZy9zZXR1cC4genN3YXAgaXMgZW5hYmxlZCBhbmQgaXMNCj4+Pj4NCj4+Pj4gc3dh
cCBvbiB6cmFtIHJhdGhlciB0aGFuIHpzd2FwIDspDQo+Pj4NCj4+PiBJIHRoaW5rIEkgdHJpZWQg
YWJvdXQgMzAgZGlmZmVyZW50IGNvbmZpZyB2YXJpYXRpb25zLCBpbml0aWFsbHkgbm90DQo+Pj4g
dXNpbmcgenN3YXAgYW5kIGxhdGVyIHVzaW5nIGl0Lg0KPj4+IE15IHpyYW1jdGwgbG9va3MgbGlr
ZSBzbyAoYWx0aG91Z2ggSSBkaWQgdHJ5IHpzdGQgdG9vKSBhZnRlciBydW5uaW5nDQo+Pj4gdGhl
IGRlbW8gYXBwbGljYXRpb24gZnJvbSB0aGF0IGNvbW1pdDoNCj4+Pg0KPj4+IE5BTUUgICAgICAg
QUxHT1JJVEhNIERJU0tTSVpFIERBVEEgQ09NUFIgVE9UQUwgU1RSRUFNUyBNT1VOVFBPSU5UDQo+
Pj4gL2Rldi96cmFtMCBsem8tcmxlICAgICAgIDI0MU0gIDIyTSAgOC40TSAgOS4xTSAgICAgICAx
IFtTV0FQXQ0KPj4+DQo+Pj4gSSBhbSB1c2luZyB0aGUgZGVmYXVsdCByaXNjdiBkZWZjb25maWcg
KyB0aGUgZm9sbG93aW5nOg0KPj4+IENPTkZJR19aUkFNPXkNCj4+PiBDT05GSUdfQ1JZUFRPX0RF
RkxBVEU9eQ0KPj4+IENPTkZJR19DUllQVE9fTFpPPXkNCj4+PiBDT05GSUdfQ1JZUFRPX1pTVEQ9
eQ0KPj4+IENPTkZJR19aUkFNX01FTU9SWV9UUkFDS0lORz15DQo+Pj4gQ09ORklHX1RSQU5TUEFS
RU5UX0hVR0VQQUdFPXkNCj4+PiBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0VfTUFEVklTRT15
DQo+Pj4gQ09ORklHX1RIUF9TV0FQPXkNCj4+Pg0KPj4+IEFtIEkganVzdCBtaXNzaW5nIHNvbWV0
aGluZyBvYnZpb3VzIGhlcmU/DQo+Pg0KPj4gc2ltaWxhciBjb25maWcgb3B0aW9ucyBoZXJlLiB3
aGF0J3MgeW91ciByb290ZnM/IElzIHlvdXIgYm9hcmQgYnVzeQ0KPj4gd2l0aCBzb21ldGhpbmc/
IEkgdXNlZCBhIG1pbmltYWwgcm9vdGZzIGJ1aWx0IGZyb20gYnVpbGRyb290Lg0KPj4gY2FuIHlv
dSBwbHogc2hvdyB5b3VyIG51bWJlcnMgdy8gYW5kIHcvbyB0aGUgcGF0Y2g/DQo+IA0KPiBJIHdh
cyB1c2luZyBmZWRvcmEgZm9yIHRoZSB0ZXN0aW5nLCBkb3dubG9hZGVkIGRpcmVjdGx5IGZyb20N
Cj4ga29qaS4gTXkgYmVmb3JlL2FmdGVyIG51bWJlcnMgdmFyaWVkLCBidXQgd2VyZSBhcm91bmQg
ODAsMDAwDQo+IGJ5dGVzL21zIG1vc3Qgb2YgdGhlIHRpbWUuDQo+IA0KPiBJZiBJIGluY3JlYXNl
ZCB0aGUgc2l6ZSB0byA1MDAgKiAxMDI0ICogMTAyNCBJIGdvdCBhcm91bmQgMTMway4NCg0KMTMw
ayBiZWZvcmUgJiBhZnRlci4qKg0KDQo+IA0KPiBCZWZvcmUvYWZ0ZXIgdGhlIHBhdGNoLCB0aGUg
bnVtYmVycyBkaWQgbm90IHJlYWxseSBjaGFuZ2UsIGJ1dA0KPiB0aGluZ3MgZGlkIGZsdWN0dWF0
ZSBxdWl0ZSB3aWxkbHkgLSBmcm9tIGFib3V0IDUwayB0byA5MGsgdXNpbmcNCj4gdGhlIDQwMCBz
aXplLg0KDQpXaGF0IEkgbWVhbiBpczogYmVmb3JlL2FmdGVyIHRoZSBwYXRjaCBoYWQgdmlzaWJs
ZSBwZXJmb3JtYW5jZQ0KZGlmZmVyZW5jZSBiZWNhdXNlIGl0IHdhcyBhbHdheXMgZmx1Y3VhdGlu
ZyBpbiB0aGUgc2FtZSByYW5nZS4NCg0KPiANCj4+DQo+PiBJIGFsc28gdHJpZWQgdGhlIHNpbXBs
ZSBiZW5jaG1hcmsgb24gcWVtdShqdXN0IGZvciByZWZlcmVuY2UsIHNpbmNlDQo+PiBJIGhhdmUg
bm8gb3RoZXIgcmlzY3YgYm9hcmRzIGV4Y2VwdCB0aGUgbGljaGVlIFJWIGRvY2sgYm9hcmQpOg0K
Pj4gc3dwIG91dCB3L28gcGF0Y2g6IDMwMDY2IGJ5dGVzL21zIChtZWFuIG9mIDEwIHRlc3RzKQ0K
Pj4gc3dwIG91dCB3LyBwYXRjaDogMTMwMDU1IGJ5dGVzL21zIChtZWFuIG9mIDEwIHRlc3RzKQ0K
Pj4gc28gaW1wcm92ZWQgYnkgMzMyLjclIA0KPiANCj4gSSdsbCBnaXZlIFFFTVUgYSBnbyBzbyA6
KQ0KDQo=
