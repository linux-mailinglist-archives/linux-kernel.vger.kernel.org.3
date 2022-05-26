Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A7534A83
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbiEZGwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiEZGwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:52:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42006BFF2;
        Wed, 25 May 2022 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653547950; x=1685083950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GLzaD+Q8oTT03n8zMx1FuoPcghPbSG28RO1r1Y+lJ58=;
  b=n6GacZsxEgNp/gvih+361Wy0zSDJhef63XTgQio7i53IGesuHM2GCgPv
   pJ75FdDrXKgVDm/8oXTy0X8tWQezTnxNjyP5s+hJEyBBSve1Ipa6+ZWVG
   RY4SI+m0/coBYQnBsNHFAUdXwBf6HQS3ny6HJ/V7+lD8EpfmMh4zFxsdU
   LN3Uoi/vi2Hofvit6JANHLo7VAGRYdBkEBvjh/NaoKETJEOiV5/971cwf
   LD5mtKhqVwoewv9h7lfL8dDUZP3N1yoBoRx7VIeebXAqLwnH2rb1fQKt/
   uXWgrM3SEP4tk5dJpxZN7sloTJVFN3CLASkGQMbjCsKlvYdus2Wtngunk
   A==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="157653076"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2022 23:52:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 25 May 2022 23:52:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 25 May 2022 23:52:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2n4S0DrwZPigcXXpH7ubiWPlqAR9EZA1cUFdwlAvuTyPWK8jwut5aOPhnKrFFq93xbzgR3WK323JaVd4SEU0BLIwLnbepKGFuRh57JbM/f2Ctb9PQz0E3y1MtWY7U28vfMf58hnoIuIwfiD10CyULsuidILMFwJhN2RkmdPag6aP2perQxS8I49pJS400UxHTBuR84Bzb74Q2tmCWtzKin8xKlW2A56xfhzd+4Zdj+LZ3+/mNr+ieGaqFbN7fhSeYTgBr0xMh73Q2HBA4g8BwG5b0dH3ySiDmkllRe7a4vonR4aLj/DoddcEO0ARP/KkubpzJ4ZXshTAePVWHeDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLzaD+Q8oTT03n8zMx1FuoPcghPbSG28RO1r1Y+lJ58=;
 b=LP4Jm7E1aXcNnIOwno8iH/IoHFXB4AgCKbx2ZOZ7LaE+yaOrkgTsa0u3/Rqi0G603RMr0RLd9xRi6N2HIQ/s8zsGuRqA1CvWu4P2fMlJ2ft466u2e2fd0QWaoNcERTzOoCi934TCKUqXTG6im2XvnZ67ox78z/X2oLhz2rqFhMYl0UsFAUDaidceisc06AWvafGdivLo8ixV56FHoiwVta3s3fR0LWJ4YldgVd1yNuDiHrYC7+1ClmAjewneKRehT8jN/nHE/TyvtdR/K+fmAStS324KQWS7LtgekdbyQeY2aORIidHUg8B0PYq9VU3I7qQPljFcHNLcqgXEyuwMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLzaD+Q8oTT03n8zMx1FuoPcghPbSG28RO1r1Y+lJ58=;
 b=h55ebpkwsCSij9lEtAemW7Wc/5pHwjumDaW5g4BXqeNB402b636wWK+Mf4ZAge70WZyyuR4zbbZKcyFvfeCF4VyT7qMqe+VZIyiOPEsMP9WvBUMuomR+zWdFqwDjkhcc8ZWopfg3y3xM7/Z9hU1gKV0EPt12p2JtAXvnZPgAh1E=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB5068.namprd11.prod.outlook.com (2603:10b6:806:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 06:52:23 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%6]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 06:52:23 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>
CC:     <krzysztof.kozlowski@linaro.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Fix unevaluatedProperties warnings in
 examples
Thread-Topic: [PATCH] spi: dt-bindings: Fix unevaluatedProperties warnings in
 examples
Thread-Index: AQHYcKHQtFDNalpqs0iqgomN20Lhca0wuJ6A
Date:   Thu, 26 May 2022 06:52:23 +0000
Message-ID: <13a92f37-2491-9daa-05a7-f831d9bbb0e0@microchip.com>
References: <20220526014141.2872567-1-robh@kernel.org>
In-Reply-To: <20220526014141.2872567-1-robh@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91e0da96-6c01-4840-5b4b-08da3ee449b6
x-ms-traffictypediagnostic: SA2PR11MB5068:EE_
x-microsoft-antispam-prvs: <SA2PR11MB506870A5357E7EE0303B623898D99@SA2PR11MB5068.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JKaMV4S0fNJMWuffWO2COamzqQgcFjQuMcszY8G/3sBFi4InNDkRe1v7PMEwYrQXekUYWtSzhMJ7pFC5dC77Thm7W/QtyCsRWyXGEPxccXTs4C/jJZ4z9vHGhx4W0aV1aiuX7SC8f6UqzH5kCZatB1LL0iN8WjcEyiLsoq+EJJEcwqMQTh9AqA85jRoGQ3zBljZF541PVbG4M/l9o3M9YkxzzYWqGchruBlWzJszsyzJcYzaqVYG2oH5v+PUq2BN6C+d0+iHTSjcufZZDSmws1LfipXhnnMPY81djWhzbOc3NoRBN0nQggqSAjwIKXMaB9+lEMEA5DG4GSHpHDqVcpMBmtV73Ilm/tFbVOEHvlQF98hlPnIqIF0M3ul6/UUYwXv6shdOCHIwAbiDxIx3PNB14EPMkcXkjgyL/XXfgB+7GfyPLIeGGGZbHtfnKDx50wNGxSew4SmfvN4k4rSSHvvRP35CFEoy9d/Im4UoWAI3fuujApCtGGVCELSmxnhjGTtnfnocDAZQh5MTB9Znd3WP8FhWWcj4NL3yiaaMaI3ej7H6ROhcZR3ju3EEp4K79nDKJZTnkhOHWG+ca8EKx7PgmNQCH6rR61+7G0iiKThcfigICqiXjIvJYFrrBTcp1bEpIZRvvyaqzzsRxjNXxnm1otYDRHyf2qNULAW0kOTQRoyDe44LLA1o42CSx8EB5nDbrTNPPzSFoxV3OjNt8LQ8f5EZXs2lY4G/tOQbw1E2bKSdRL4wUA8gmZjxNPiLej46ScBznk8eScC66IQwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66446008)(66946007)(86362001)(66476007)(76116006)(4326008)(91956017)(2616005)(31696002)(64756008)(186003)(38070700005)(7416002)(83380400001)(5660300002)(2906002)(8936002)(122000001)(38100700002)(8676002)(26005)(31686004)(6512007)(6506007)(71200400001)(53546011)(508600001)(54906003)(6486002)(110136005)(36756003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1ZITSthS0RLVWt6blhDbmxoQW1XUk4wclFmRnpQT0owOUJqclh3OXFteW1P?=
 =?utf-8?B?VGxiZ0RTM1dremFZcnhyamJZczg4ME1YdW95dWsxdHJnVUtKRGUxMHlnYTRm?=
 =?utf-8?B?T1krZnBvZDNsOUxab0xta3NFeFlveFc2TU1ha0ZCUXpnNW9UelZ4NCtMZm9M?=
 =?utf-8?B?SWFCbzhOZ3NwSWRUNmNpZWY0RWdEOC9CZlVxbmE3R084MHdrTUxEYXpRWXlj?=
 =?utf-8?B?NEFFY0ZVTkZOditoaUdza0J2YmhjNlFmbU5ITTk1NXVSd3RvSVZjaGJxMWxp?=
 =?utf-8?B?K0dkc2xqdThqVkZFQ2ZJeHh5TlhBYzRWbTQ3aC9nWEM4UVNCL0ZiNExPUFZO?=
 =?utf-8?B?TmR3bGxSZWtLRGRRT2RKN3REWDN6bEJMMDFmVno1WUZXdE5IVWRKSDNHQzVu?=
 =?utf-8?B?VUVTVU80ZE44a3hjbFFIdGhPSHJtSEg1RnRxYldmazdHeURIT2JyRUVoTkE1?=
 =?utf-8?B?MjdqWGNRUmh1K09yenVyY0pUVmJBN281bGZUbkRxK0ZtdlNYcGU3dTlsUktB?=
 =?utf-8?B?VTk0UzB0TFQ0ZzZ5bkNtRXJRaEg2UmhaYTA3Z3BBNlJFeXM0dll2TGtUems0?=
 =?utf-8?B?cmV1YVRUVVU4dmx0dVRUcG1MSUZ5dHJYMXlTSUczOTBjTUtPbVVrVWM4Ykox?=
 =?utf-8?B?Q09MbUUybm51Vm1hTFBRbTgxSHN0NmhaWFhmMzhTM09BY2VqZ0liR3pkeVJM?=
 =?utf-8?B?Q3BjT3VpRjhDRHBHZVNiYU9KVi9FL0YxVkNjcFc3V1dSQ3Qwb3NpR1FkVUl5?=
 =?utf-8?B?WitKcHU0R0t4YVFvdnd2bjFpTStxcDl3V1NpMEFFalk4cHdBVFcxRHB2MmxD?=
 =?utf-8?B?RWt3WnkwUmtwaU9DekJyNDlmK21nMmFFZVkwcm02bXN6TVVsRjlGcnpCdGdm?=
 =?utf-8?B?YkZGUVdtUnRFVUQ4d1NEMUdqeXNZN1hqVzZFYmwvaG5IVnI5RG5jdWljRUdP?=
 =?utf-8?B?djltcGdnbFBZWHBhVzlBWk5hbzYzbzY1WW1WYkZuQStWMEZyVER3QUo1VGdF?=
 =?utf-8?B?Y0ZPVzZVRTBFenhHYU1LenlFTHNLQlZoRHRXU3U5T1J2THZUVCs5WXhlU2pw?=
 =?utf-8?B?cVJYUDVuMThZM2ltSnVqcjJjZjJsR0FoYW5PdU1KWndhSHJFWFl6WDQ3aHJq?=
 =?utf-8?B?NFJwek1QTkIzN3lIZ1RxVllTNk04Z2FTNnNIbzJ0d3BDMDdTVkwyeEkyVHBR?=
 =?utf-8?B?ekhIMzdhK0pYamtDOVdFWHRxdEtZa2tUL0JhbzdVOVlaRnlHWFFXR2hURlZT?=
 =?utf-8?B?Um13UXRKR1dMZFFNZ2hDRGsySWppZjFJeWpnNEZxc2NvS3pVNFA1N1JUdmt0?=
 =?utf-8?B?VHdyTVFrNWI0V1l5SHc5NXg3WTQ2UmsrTWo4cGlhNHMwRVhjbm4wWnJ6NFRO?=
 =?utf-8?B?c2NGdWM0T2ZSZldsV0ppNm1kZVJmMzY2U1kzZFgrMVJsMG1lWWt6T2FqSHA1?=
 =?utf-8?B?bW1UMU9mR050TTRYbUpoODFqUnRyZzdCNFVIV0k2VVlyVWlXU3paUktxNHpp?=
 =?utf-8?B?TmsxVHJtY0FsOE1maHhBZEt1d3pmRHc2VjVzcmIrUy9NSHRXcHBjYi9peXJk?=
 =?utf-8?B?UXNjZzhzMmpRQ284QXY0NUlrVEFTdEpKQW4xN2lOMUw3Qm5xOStKTVVoZWtt?=
 =?utf-8?B?SXd3YnY3Y3ROZDVONkJMZmNHMHJrN1dYdkp2SXpLMmwwV0xmSXRTdG1OVjBq?=
 =?utf-8?B?QnJJRUM0R1lZQmZrUDkzRGNzdFBHWVQxRzUxTlRnRkt6d3NlNWdKRVJtblhJ?=
 =?utf-8?B?eVlHUGw4enU3R0N4T3dqa2V5TWhnNjZPOXdBeDVNdWJncDUzV1AxMEVucFpD?=
 =?utf-8?B?UTVUaE9DdThXdUdYUVExemlQWjRYU1hnNmwyUWNsV0VSdTFWT08xUmcramZq?=
 =?utf-8?B?bkkzUmxDd2M5ZnFZekd3VHRIcmNVRXNRajRLNU9oUGhQZ3BXTDVkVzFFQ2Vw?=
 =?utf-8?B?Z2Y2M1JhSUN5WEZRbmZFYmZMNTlmbi9mN0dzcHhCZWxwN2ZqbGJvMnc2Z1lv?=
 =?utf-8?B?bWkwVFErNzVFOGpaWE85RDFtZHczcXVpc0lOdnVqbC90YnBUeUhuTVljSkVs?=
 =?utf-8?B?WE1aNFUwMm92R3o1d1BlS2pJMlRhRC94NHpwMi9YdW1XOHg4dWhlajV6WFMz?=
 =?utf-8?B?K3JDYVcreENCY2NiSWZnNHJxT2szTmNQbE90YW50aXZWK3QrWERVQmdQd0do?=
 =?utf-8?B?OFh6aG5JVVZtTy9SbTRQeEZhMDN0b0JwRHVPVk8ybkdaWUxIUkJQd2RTVlBv?=
 =?utf-8?B?QWZ2M2p1Zy9mUVp5bVo3bDRxMGVnbHEzTGc4akFxeUpsNkZzSmM5ak1vK0Q0?=
 =?utf-8?B?SEZTZ0ptUFdEQUZyTjJBNlNsck4rZ3JhdVYvalJOTk5ZYzAzWDdtUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <294273602AA42A4DB0108396FD31B550@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e0da96-6c01-4840-5b4b-08da3ee449b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 06:52:23.6342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttimGkBOhUTmKL21wqVg+bIhzzxcflSBKnRs2nSz2lDbGHYbp8Fmh/koBamrWmgdwygNSUj6susz3YlP7ZtGKrOMBQU+l1ymb5BZVZEFa0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5068
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDUvMjAyMiAwMjo0MSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlICd1bmV2YWx1YXRlZFByb3BlcnRpZXMnIHNj
aGVtYSBjaGVja3MgaXMgbm90IGZ1bGx5IHdvcmtpbmcgYW5kIGRvZXNuJ3QNCj4gY2F0Y2ggc29t
ZSBjYXNlcyB3aGVyZSB0aGVyZSdzIGEgJHJlZiB0byBhbm90aGVyIHNjaGVtYS4gQSBmaXggaXMg
cGVuZGluZywNCj4gYnV0IHJlc3VsdHMgaW4gbmV3IHdhcm5pbmdzIGluIGV4YW1wbGVzLg0KPiAN
Cj4gJ3NwaS1tYXgtZnJlcXVlbmN5JyBpcyBzdXBwb3NlZCB0byBiZSBhIHBlciBTUEkgcGVyaXBo
ZXJhbCBkZXZpY2UgcHJvcGVydHksDQo+IG5vdCBhIFNQSSBjb250cm9sbGVyIHByb3BlcnR5LCBz
byBkcm9wIGl0Lg0KDQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWlj
cm9jaGlwLmNvbT4NCg0KQXMgdGhpcyBwcm9wZXJ0eSBpcyBpbiB0aGUgbXBmcyBkZXZpY2V0cmVl
ICYgSSdsbCBuZWVkIHRvIGZpeCBpdCwgaXMgdGhpcw0KcGF0Y2ggdGFyZ2V0ZWQgYXQgNS4xOT8g
KEkgYXNzdW1lIGdpdmVuIHRoZSB3aW5kb3cgaXMgb3BlbiBhbmQgdGhlcmUncyBubw0KZml4ZXMg
dGFnIHRoYXQgaXQgaXNuJ3QpLg0KDQpBcyBhbiBhc2lkZSwgSSBtZWFudCB0byBzZW5kIHRoZSBk
cml2ZXIgb25jZSB0aGUgbWVyZ2Ugd2luZG93IGNsb3Nlcywgc28NCnRoYW5rcyBmb3Igc3BvdHRp
bmcgYSBwcm9ibGVtIHdpdGggdGhlIGRyaXZlciBiZWZvcmUgSSBldmVuIHNlbnQgaXQgOikNCg0K
VGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvbWljcm9jaGlwLG1wZnMtc3BpLnlhbWwgfCAxIC0NCj4gICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc3BpL3Fjb20sc3BpLWdlbmktcWNvbS55YW1sIHwgMSAtDQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWljcm9jaGlwLG1wZnMtc3BpLnlhbWwg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL21pY3JvY2hpcCxtcGZzLXNw
aS55YW1sDQo+IGluZGV4IGVjZTI2MWI4ZTk2My4uNzMyNmMwYTI4ZDE2IDEwMDY0NA0KPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL21pY3JvY2hpcCxtcGZzLXNw
aS55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWlj
cm9jaGlwLG1wZnMtc3BpLnlhbWwNCj4gQEAgLTQ3LDYgKzQ3LDUgQEAgZXhhbXBsZXM6DQo+ICAg
ICAgICAgICBjbG9ja3MgPSA8JmNsa2NmZyBDTEtfU1BJMD47DQo+ICAgICAgICAgICBpbnRlcnJ1
cHQtcGFyZW50ID0gPCZwbGljPjsNCj4gICAgICAgICAgIGludGVycnVwdHMgPSA8NTQ+Ow0KPiAt
ICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwyNTAwMDAwMD47DQo+ICAgICAgIH07DQo+ICAg
Li4uDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Bp
L3Fjb20sc3BpLWdlbmktcWNvbS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9xY29tLHNwaS1nZW5pLXFjb20ueWFtbA0KPiBpbmRleCBlMmM3YjkzNGM1MGQuLjc4
Y2ViOWQ2Nzc1NCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9xY29tLHNwaS1nZW5pLXFjb20ueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc3BpL3Fjb20sc3BpLWdlbmktcWNvbS55YW1sDQo+IEBAIC0xMTAs
NyArMTEwLDYgQEAgZXhhbXBsZXM6DQo+ICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiOw0KPiAgICAgICAgICAgcGluY3RybC0wID0gPCZxdXBfc3BpMV9kZWZhdWx0PjsNCj4gICAg
ICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA2MDIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+
IC0gICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCj4gICAgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ICAg
ICAgIH07DQo+IC0tDQo+IDIuMzQuMQ0KPiANCg0K
