Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250795A675A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiH3P0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiH3P0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:26:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9626F578;
        Tue, 30 Aug 2022 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661873167; x=1693409167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Nqmbzl9dZkj7DdcZ7dwfJVdOUAs2mbNxS0EgJFXUbA=;
  b=MmYBI7ugnnZamtxovp3feySdfMAMGlrKE6kBHJA+Mmtc1qbgTtV2+PGf
   P3OxDjNLsrFggNTG64fd6JX27N4IsoG8zkE9e//qMZ0hVb88dmP+iEMTU
   qzAOfqW2MOhFEBA3ywq2WeOb1Q34BxRFX5Llp1WsiZnM00jDNbE/dw7xP
   4SFQP7GMTMRqfRA0Gm4vUCNn97s8p4Sy2FkzBMXjK7cYvD9xbBw0VsKdA
   LJxxe6v5szzqhmOIejp8SOZ3A+h2cu7yc3gMkePolrrqk1nrP2HFujdcb
   7AUyTvsiOGU3TTDUvYPAdKXJMLkGoBD5vDdQ4ebzIoSWu2AKLwx21EgN5
   A==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="188674128"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 08:26:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 08:26:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 08:26:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn+X1rQ4OCcaSROuyB3Faw1cstGA4X/WfNp2wxl8aWEB7piNuB45CxJyG6XJvhClfoKU+uA1TimD+fOhpb+58ANZYmuTwk7Ck47VUAbgF5mx9X2r2bG0ibbG2t3AXNheMcj5GOQFQgVF/5PKa331+il2djWtOQLlhyZ4RsDRlrQAux8+N9faSPS+NCcVISgtWMCESkB9hCdonsB/RQDnil6oGKL0FI85Cv38airIm9ASws35UjazQNnmFhinZwbBgvoqflE4cM7DDWuAgrLPO+YfJ1Ip5IM9n+SKciUztRof4uYT4Jq1gAKLBUP5Orr5UhxSJuyfgmRi1vHWKkd0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Nqmbzl9dZkj7DdcZ7dwfJVdOUAs2mbNxS0EgJFXUbA=;
 b=g1Ug/y0XTl5rUBZPmQuB0c7lDvOhcziUbuKS6ej4BaOdvxioI+86BTdpR68pshOWgpE3NWt66SeBOvL2IVaxPmzfy0UCWkrPZZ6eHQvzTPvozKpldCXbP59/MGuG6ovIJ0gtlG41llr8u3I2cof823z4WzkLtK5nRRsNpV2MwhFGN7lV5+PDc5GWTJrs+hhDQIXLThchjCiJEbuBTBr59oa2EVPdk2Qprvbgf0L+u7Rs5gLKhuH8eTrjgPwUlVWzgGofu9Ud3A4+cIObglNd/Xb+Dc2//rRiFDmO5ZfJzVWjovaS4obyZ0aTBLtXA9T1BMeFvI7n+ne846imSPC/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Nqmbzl9dZkj7DdcZ7dwfJVdOUAs2mbNxS0EgJFXUbA=;
 b=fKa/whb3VGSkz4C6mDPGM8SMRQwcbWw+bMksqF9WDQM1uNU05UuDnCsx8p1Ku/zI7bZmCLJoba+EXc5sdkBmvw/6xbler7ahAe5uXsmyTFqgXItN8FZlrukIfEcHkrtWswL08wg8A2IYagO+Lo30czVdj64+4vl2OPKiBVs+N+E=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3465.namprd11.prod.outlook.com (2603:10b6:5:b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Tue, 30 Aug 2022 15:25:57 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 15:25:57 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <Daire.McNamara@microchip.com>, <Shravan.Chippa@microchip.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Cyril.Jean@microchip.com>,
        <Lewis.Hanly@microchip.com>, <Praveen.Kumar@microchip.com>,
        <wg@aries-embedded.de>, <Hugh.Breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Thread-Topic: [PATCH v2 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Thread-Index: AQHYvFnwSpVLiReZPUWC5HM7xMt/UK3Hg2QAgAANgQA=
Date:   Tue, 30 Aug 2022 15:25:57 +0000
Message-ID: <27b8aa9e-9173-b40e-8f9c-a53fa5ba36c8@microchip.com>
References: <20220830101803.1456180-1-conor.dooley@microchip.com>
 <20220830101803.1456180-3-conor.dooley@microchip.com>
 <a3a8e2ba-a6bd-6e66-fd04-e3a46661a34d@linaro.org>
In-Reply-To: <a3a8e2ba-a6bd-6e66-fd04-e3a46661a34d@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e5d42f7-e443-43cb-bcb7-08da8a9befa5
x-ms-traffictypediagnostic: DM6PR11MB3465:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUaYOpDN48Ve0rb7NoE28MjxDUZgKpsjU+xm12ugXdxfRE2NboG8Ikv0cB9MmUHtWdKYF/0GdTj+ZpCJTckY2PRJHErJaMp4u6kAAKbx55hNMld/mUbYeCzRdMa6hsUd8j0XJ0TbFAOSYXhdjYOfN973tzf2fXhhhbLMDBPFevzRvslOElI8D7F6LNZ3vk8KxOBDL4gggdz63pu5V81TIhx4ZvYIYdqsgnjM4c/3vSuDhX7mRxGOd7eWLt2vtnZ9VJe3A4PK/CXycR7vKlW8nVzwsmGmmNYkUwOrND7ic3eMqghujHS9WbPdsDLV0TbTwz9ZVz3lxDH3g/53i5cKa9H5ReNK8JYdrYa5uD/SeAyAHXBSLGkpZbUHXG+RVAypX5l98C3Yqg0WTqFYHEAzRzp+qcx5dDWKJv1ptqy/jJAoBeCHxOCfs7H2/9Fbfv3gBHusGZDH43hcCHHlNd++PqwjxIcGX0pFqDOTREFctikK7uGCwBC0FyKm/HAAmQ/6MtugxO1rfuD1Nz4NzI/S4P42pgwW+pyDqBSLNdVcG6v14980Az0JMeWTYNEjmZtlrKG8jU6yAAd7juaBe3kpJFhJRGk/4tpMPNZRLSL1VCFRrP3EYZZC7GZZJeMfdGzef2BehFWteLLVr3+CJ8m+12h/+eijpJkj5G51uGovxfB23tiS1bn1QUezwByBGV8poxKC7ct1qeaxFt7w3oWyRVwE1iLOynA5F8D7Q7SiEApaTfOtebHNz3eDHZbMF05MNJvfDTucpzkcEwNlJBiov08KdAuk/P/v8WQVyrzZI5E3awWHc+9dqXZrjtPlF/9ZefqzUxV8W3ePKDEzxxsiUcb3yTmKAwDdG8A+UTAp69c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(966005)(26005)(53546011)(6506007)(6512007)(41300700001)(71200400001)(186003)(2906002)(6486002)(2616005)(7416002)(54906003)(66476007)(6636002)(4326008)(316002)(5660300002)(66446008)(66946007)(66556008)(64756008)(91956017)(76116006)(38070700005)(110136005)(8676002)(8936002)(36756003)(31686004)(122000001)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cklIbFRsaUhCSzN4R0NhRTJHTXVrTkpNcnJCc1E3UXhKYkROQ1RQQXEwdGxR?=
 =?utf-8?B?SUYrY2RuMStjMEZGbVUyMCttUWJrdGhwblpXcHVkNGlKN3dtSnh0VnpkK1pV?=
 =?utf-8?B?VGtHU2c1QXhhcWNhN2NGQ2tnWmxqQkVUK2JPY3VzQjViQkFyUE55VWd3cUlE?=
 =?utf-8?B?Nk40OUFVN2ZYNGxnVm5xNGpFcFlNbzBnNHdaVEpDdC9adGVlZjVhOXdMM2Zx?=
 =?utf-8?B?TVpIc0pPZFVvNnR2MHZXYUhEQ0psRGdJaDJ4WG1uZ1N5c1pIV1pqKzVkanZD?=
 =?utf-8?B?T1JXSzJGS21aQ3FXSWR1ODZIT2NJZHFiVWJlb08xMXBYaDFxdmoyYWJ0M1FD?=
 =?utf-8?B?Y1EvQkRkcCtMNlJYalgvTHN3elc1Ymp4ZDZleGtWdDEyMUl4c1laSTB5WDJt?=
 =?utf-8?B?aFNYRzdKNEl0d1JEaHlYdTN5SlMydDV2REU3VGE5Vks5MktIUHkwOUxJVnBY?=
 =?utf-8?B?a3lLd2hpZFFvcmF1MnFFejY3QlBZQUhUek5iNUo0SjR2QXBwanRleXcwYTZl?=
 =?utf-8?B?TGh0NmU1Znc5Yi9BUGhVNUdYTFRpTlJYTUxpZ1FqT2d4RzR1czdaMjFqWGw4?=
 =?utf-8?B?QUtVMlhpQVlVc042aHE5aGkxYkhXbzFJKzBlK2E2bHpIU2grK3dpWlZHZjg2?=
 =?utf-8?B?QzBlaU1HRFQwVTVlY3Y3bWRYVzh5ck1KUzl3bnQ5aXRrcklTNFplQUhtcTFM?=
 =?utf-8?B?TGRwa0owaEpPa3NSdnk2cFQ0V2xaVUs1dU16OFhrNnB5QzRmRGhUZWo5TjU0?=
 =?utf-8?B?cy9weTNraW5FN3NNN29lUUtmQ0hJbjVKdW9XcUZ3Z0tiYnFmWklNZjFPQ2dS?=
 =?utf-8?B?Z3NsQk42eWM2Z1NPMkdoVXpLNTFNUllrc0Ridjl6VUdoK0p3OXZKdUxOT1Ba?=
 =?utf-8?B?VlJCM25ZWm1VTk02R1R4ZVVaS2pwV0E0K0MzSmNybXJhQXRBSFlkYUY4Y3dQ?=
 =?utf-8?B?YjR0dmdHUW5CNklEY2lNL2NGR2xRa3NCL21WRW1WYnR4TWJ0NkgyZC9oa3hB?=
 =?utf-8?B?ZHNhVjlFd01rczV5VjhNR2g1R056MElsRjB0Zi9pSXNDRGh6RmpDL0FnenFD?=
 =?utf-8?B?Q0tpa2FPdUFHMStnMllVTkZoK3BDZXNzcUY4Ty9zLytCVTBJZVNXclozU0JP?=
 =?utf-8?B?R3NsZS9USitlS3Q4NGtCcnV4MncrVEpLdVVESjBua1FWUk10R1NRYWpIUzJL?=
 =?utf-8?B?T3c1RjZ5KzJ5RDJ5MW9JQzBzWUV5QWNZUTllclo0emtLY0JaaXBYbUlZV0xu?=
 =?utf-8?B?c1oxbHVKc0c2MEZWYjlTNmVpOVp2YTViRGtVVHhVemNUM09mUDhpN0J1U0xK?=
 =?utf-8?B?NHBtT3pBVzdrS1JxOGVPM29JRlRjM1NubU1YV1pvN1REWjZra01RaSs4TGcr?=
 =?utf-8?B?RjRaME91cTE1Njh6YTAxRzZUeWFLY3lhMWR3Z3Rsd1NsL3dUWXV6d2hkRTNY?=
 =?utf-8?B?MkFacXljbmtZaWFhYU4xK2gzaEQ0YzZzam0zZzM0NFo1VFBWTXlEZlFSVWY0?=
 =?utf-8?B?TlUwSUl5ekpIVG5hWVRvbzV5bHh6L211UWdJMnc0T2haMU5lZ3haWEV2ajRD?=
 =?utf-8?B?NzcvNTA1SGREa3hvcTZaeTV0Vm1hWGVJQWpyczlrUEh5enBvdG5rY1hhb2xR?=
 =?utf-8?B?VGl5N3dtTFptT1prNDNvVlB4S2MxUEVHMWxYWjRmM1FuNnlMZFZoTXVRcG8x?=
 =?utf-8?B?N3NCUTBZYkpBdlhKZXlNb1pTbjBGMElIMDB5S1ZpK29mV3JqMTVZSDlTUGlt?=
 =?utf-8?B?ZHFtam5pZjlvVTllY2Vub2xSUlF5MW02cmEyZU5CYmdXN3M0NVRSb1EvdlhI?=
 =?utf-8?B?MGhqWElDVkJhNkUwSjZ5Z0JVcDRmWHNwT0xRUWlJelNDOUdEM0dEZDZQb1pL?=
 =?utf-8?B?R04yZEJ0MHZvRGRaREwzeTAySlQydjk4Z3NrRnpYMG8yL0FzTG0zVmY2MVZL?=
 =?utf-8?B?dEZrdVJRZVhmS2kvUklqYXVYS2RwTTFveEx0UHQrd09OVHNKT0xFT05UTXgw?=
 =?utf-8?B?dHpTR0JFYzZVSmF6Y1I1U1JETW95WUdsM1g3ZlBKZmFiN2RXWUQ3VGQ3bnpx?=
 =?utf-8?B?MGw3S3VDUy93MGNxTmQ3VjRXbHY1K3lJbUdQdFFuL3JBa215STQyUEM2bEVm?=
 =?utf-8?B?OE9MS3BSYmwzN0NiMGtDZ0RZUUVPMFVVdExLTjB6WDc2cmRsN0xTVWpWZ2xY?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED88B1B28DC92D4A8F09F866385A0305@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5d42f7-e443-43cb-bcb7-08da8a9befa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 15:25:57.0901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pk4d9h2jWGRA19wGkSkmW022eIK4jpavJlqmf2z9ZKIemiIOUITtcvjxoxzCzLwRnQawXUacgMvitP369+oeJZw1qqn/mQ3HJwypb4h0tqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3465
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxNTozNywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAzMC8wOC8yMDIyIDEzOjE3LCBD
b25vciBEb29sZXkgd3JvdGU6DQo+PiBBZGQgY29tcGF0aWJsZXMgZm9yIGJvdGggY29uZmlndXJh
dGlvbnMgb2YgdGhlIEFyaWVzIEVtYmVkZGVkDQo+PiBNMTAwUEZTRVZQIFNPTSArIEVWSyBwbGF0
Zm9ybS4NCj4+DQo+PiBMaW5rOiBodHRwczovL3d3dy5hcmllcy1lbWJlZGRlZC5jb20vcG9sYXJm
aXJlLXNvYy1mcGdhLW1pY3Jvc2VtaS1tMTAwcGZzLXNvbS1tcGZzMDI1dC1wY2llLXNlcmRlcw0K
Pj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNv
bT4NCj4+IC0tLQ0KPj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9t
aWNyb2NoaXAueWFtbCB8IDMgKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmlzY3YvbWljcm9jaGlwLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmlzY3YvbWljcm9jaGlwLnlhbWwNCj4+IGluZGV4IDQ4NTk4MWZiZmI0Yi4uMDRlYmQ0OGNhYWE3
IDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2
L21pY3JvY2hpcC55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcmlzY3YvbWljcm9jaGlwLnlhbWwNCj4+IEBAIC0yNyw5ICsyNywxMiBAQCBwcm9wZXJ0aWVz
Og0KPj4NCj4+ICAgICAgICAtIGl0ZW1zOg0KPj4gICAgICAgICAgICAtIGVudW06DQo+PiArICAg
ICAgICAgICAgICAtIGFyaWVzLG0xMDBwZnNldnAtZW1tYw0KPj4gKyAgICAgICAgICAgICAgLSBh
cmllcyxtMTAwcGZzZXZwLXNkY2FyZA0KPiANCj4gVXN1YWxseSBzZCBjYXJkIGlzIHBsdWdnYWJs
ZSwgc28gd2hhdCBpcyB0aGUgYWN0dWFsIGRpZmZlcmVuY2UgaGVyZT8gRm9yDQo+IGV4YW1wbGUg
dGhpcyBvbmU6DQo+IGh0dHBzOi8vc2hvcC5hcmllcy1lbWJlZGRlZC5kZS9ldmFsdWF0aW9uLWtp
dC9tL20xMDBwZnNldnAvNDQ1L20xMDBwZnNldnAtMjUwYmFhYg0KPiBoYXMgZU1NQyBhbmQgU0Qg
Y2FyZC4uLg0KDQpZZWFoLCBib3RoIGFyZSB0aGVyZSBidXQgaXQgaXMgbXV4ZWQgYnkgdGhlIGJv
b3Rsb2FkZXIgdXNpbmcgYSBHUElPLiBGb3INCmljaWNsZSB0aGlzIGlzIGRvbmUgYnkgYSBtdXgg
aW4gdGhlIEZQR0EgZmFicmljIGluc3RlYWQuIFR3IGR0cyB3ZXJlDQpuZWVkZWQgc28gdGhhdCB0
aGUgZ3Bpby1ob2cgY291bGQgYmUgc2V0IGNvcnJlY3RseS4gT3V0IG9mIGN1cmlvc2l0eSwgSSBj
YW4NCmhhdmUgdGhlIHNhbWUgY29tcGF0aWJsZSBpbiBtdWx0aXBsZSBkZXZpY2V0cmVlcyByaWdo
dD8gSW4gdGhhdCBjYXNlLCBpdA0Kd291bGQganVzdCBiZSAiYXJpZXMsbTEwMHBmc2V2cCIgaGVy
ZSBhbmQgSSBjb3VsZCBwdXQgdGhhdCBpbiBib3RoPw0KV291bGQgbWFrZSB0aGluZ3MgZWFzaWVy
Li4NCg0KPiANCj4+ICAgICAgICAgICAgICAgIC0gc3VuZGFuY2UscG9sYXJiZXJyeQ0KPj4gICAg
ICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsbXBmcw0KPj4NCj4+ICsNCj4gDQo+IE5vIG5lZWQg
Zm9yIGxpbmUgYnJlYWsuDQoNCkdhaCwgdGhhdCdzIGEgc2lsbHkgb25lIHRvIG1pc3MuLg0KDQpD
b25vci4NCg==
