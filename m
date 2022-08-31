Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC55A7C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiHaLdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHaLdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:33:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A5B81CA;
        Wed, 31 Aug 2022 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661945596; x=1693481596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=enkKuCAIjIa/fpIIhpor6VZyc6Gm5x4DMNy5Doo46gA=;
  b=HuQP6jhRgoK3XmWTY14FXo452OBMnowSSZiQF3AbCffm7eI+MjgF7pIR
   88wtutDdQwBJBfqTf/a9nS59Pr+k+++spe2CJDzhc1xQkC9LUgEzDMuxC
   iq83TnsnEkQJfi7huwgE9QTtYyI6fu+rt3++N9bxyam693lJEEs0sd4DF
   lfzgpMq+Q1kuPxsZpjzdNUj34SUXJhBYDymL1ACSD22BVbWbIfYrhtrly
   ztSHCLaYkAJ2MwcN1ufoF+iNpTMYyuREDI/j/pP7Clvx5wAEUyexKNl8O
   hMERAl29eggVoy3ozGErV6czTS+8ZAO1pp01SB3Uz41XIVh5Y2gJAsLhj
   A==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="174974222"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 04:33:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 04:33:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 31 Aug 2022 04:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtxLV1HnAGYatGAAYmsFtj5/QJyJl9/c4f1fAtqFt4hzL/jvcATNNVTGLLfaJJ3sbKR1t8MpoX7qzLtehfrSLwAl9RuUNF7m6BRd87BpPJ3Ju0XPh3EcHuHSKmyyNuqWmonzC53nJ7zkmZd2eimzO9sQJWDA1WbXi9sZRrl5IaKNOYL/8TfPnHLlQ4sGlAVmJI2j/OMU2rs3dha0WZu6WlPPZxWvpU5+MKsMg3osMUFzGbSql+/q6cxVSgHUTOEIUEtjoK3gbaXrRu8IvlpRDm/0K5QtPF9b1l2Y1bf7YTGjdMj2QZP5hhTO6GorrYtKL9cqlj/55LwddVM59B3T1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enkKuCAIjIa/fpIIhpor6VZyc6Gm5x4DMNy5Doo46gA=;
 b=EqgTr80s4lNgBjrd76l96ej69WGiTizpAtj4oTsADFQegLD0vyxV2LjGTDDXTGcHmA+ZCm9Rg2VwELFv6m0VecnnpJO3E/dFKl7AkJ2FCwGVY8Gk7nTSyD4kZNhI33H1gD7Jli1nvtMH7uzrdNMyCuKmm9j0gQv6qaRfI1BEO5MS3Ogts0SWO7s5+bjXaNdnKVVzwr5blSuvvnHkNJD82SERKggKAKxA5Y+MHkXEoFyls0ijLS+grsplNQBIIC/C9A12bD6GMQZH38SYSIg+pMFJgBbbyfVA44OO7WuysO72YSvT0CEARTUDgAJNM6OW4U33kM+7UlgXRF6QiY8Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enkKuCAIjIa/fpIIhpor6VZyc6Gm5x4DMNy5Doo46gA=;
 b=XO22BzpTWOM0JQVGPsmvTUWTU/slw+K8mfih670nMvQrng5dwPpv6/IEJxepldRWYgArk98FhZF/ZBXDvogFpYm4wSB14JxG2MUGFDg/EhabgORpA6MZewyj0NE0LO0S6fypgoYdXH9Q1ceNKe2xxE0X9wzzV+vU0KDNHZM7SCY=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by MN2PR11MB4062.namprd11.prod.outlook.com (2603:10b6:208:150::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 11:32:50 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 11:32:50 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 5/5] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Topic: [PATCH 5/5] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Index: AQHYsg/XqkIAe3vIZE6pLV4/+6m2Xa3I2O2AgAAdwAA=
Date:   Wed, 31 Aug 2022 11:32:50 +0000
Message-ID: <ecd3a33a-7cf1-31b7-af06-597ac8625e5f@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-6-sergiu.moga@microchip.com>
 <b29233a6-88f8-42cd-806f-6b3e82cb0b27@microchip.com>
In-Reply-To: <b29233a6-88f8-42cd-806f-6b3e82cb0b27@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3359987f-e8ea-463e-cdc9-08da8b448950
x-ms-traffictypediagnostic: MN2PR11MB4062:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4bMW+E5tmIF6dxlDTqOKvTtzPzLXAuLY1vqqicEcuG7p2ixrJKLe6CSyqSSyw9UCDiRP6mkgwShYnHzswKuaYrnjmnMYR8tQ61/Xh4CrDsA22J88hjR100hFbAmFLTgEWQgKjYMBUoz1KtB7wrIj7ZB2eBbuLxfMN6cDqfRpl1yT/6K8hWVyPWQAKAGznrl5WWP9V8yAfFhVvxpRSXF2O8FeHFCakbDdeDY/P8zRWSHHkVMp31rd3IwYtgN6CIRy2O9xP+gFKb44KgaaZyENDiUdUnyqNoNObW1rt4/CriAKBEDL0PUxnV8rGzaf3FOZfIAlIatLo8uZ76ZH9zTQC8cgwgac2jKVK7NUUfnj6xu4N4MqkIfZr/+40zFkLz7VFgHAc9oyEJ319tfTTn8MgtzeVJEe+I81y0wACeOr34bxi7RxTwbrz++Y/XaO+y+5QZ9tYMk4lsNCWhO2OLauD4FiuFyRR7cRohhZgvzUKscCklOS49L5T4tbnQmll5GG92jay2nWWACYs8uvZ0FPQ6MCntD3exlyg1QCs5ozMYxOOe/1zAY2fk7AKSy4IzCxsTLFI6ECST+0RspuTY+PZqxQmpgsauO60fwia9wFigWk0NefCAPusRfZwHq2Ud2ut5unoSLZ42idc3W2q88bcNjD2NToCBSEAntp5O24rgywDhJImog6MHyFle9CnQbNdMpVAAdDABNV9kPvOWaz1D+PAGoI6rTaPwz77ICX7fynLyDHtDraDgkRfUfTQ0MMMXQMewh0o5rjGuDK0n41TCGUjW8glZ51VZu6bDLHoLLCIntKycUm8iHA+A2mEexk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(39860400002)(136003)(376002)(66946007)(53546011)(921005)(38070700005)(186003)(38100700002)(6636002)(54906003)(31686004)(110136005)(71200400001)(36756003)(6506007)(122000001)(66446008)(66476007)(66556008)(76116006)(86362001)(6486002)(31696002)(64756008)(91956017)(478600001)(8676002)(4326008)(7416002)(41300700001)(8936002)(316002)(5660300002)(6512007)(26005)(2906002)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjdTMFRtZTVpY0FWbzdHaVJoTS94TStoZWEwci9BQXh3bE51N0l1MjEvM2Vr?=
 =?utf-8?B?NWYwbFRoYWt3YjQ0VlhNZ1g1Mjk4YWhOUFV4eHFXaFh3b1k3d1lzNTF4RUww?=
 =?utf-8?B?eno2aDRWbGZ2WC9yWFFUY25KVU1GZTBCL1cwTnluVWhnbXVvTElUYVNIV1RJ?=
 =?utf-8?B?eVhYeXYwanVaOUh5c0V3OU1JSjUya1BEMGdMZXFJUmJjSWxvZFRTVStQVVla?=
 =?utf-8?B?Tkg3ZjlqY0ViS2pkeCs3OVpHZm9GNVQ5a2NrOUpVWktnSmdIdGpDZnQ4Rmhn?=
 =?utf-8?B?WTdCOWNPSktnQ080Q3U4RUpwbXpMNjc3QXlUQlVndnNsQ05WeldnSEZTR0NQ?=
 =?utf-8?B?eFdJNEJhai9aYlhET3RicmVLZW9tblZET2RKY0NtWmtvV0k4TnN3UWplWWQ1?=
 =?utf-8?B?Rkx1bHBQTGlMWnAwUnhsS0h4anRDNi9SRnVxWlR5VzN6bWhYcitmbDBFMmhL?=
 =?utf-8?B?R3VTZDJJVHJ2ZXJoaUFOMlIyYmtVU0s4ZWR5YTUrOEpLSHVnVGtZTDJ4a0dS?=
 =?utf-8?B?L0poNFpzczhsZFovUmVjbS8yWGRHOUV2RGRidGFzVXhYNElMZTV0b053NHdQ?=
 =?utf-8?B?UnJmSHRwaVlyZXl1ODl1UG55MTJBc3R4ZElMbUQ2cjM1bWIxMkx0Nk5MY2pa?=
 =?utf-8?B?dlpkU1JiVFhXUnZJN05vVzk2Qno5cnRqa0ZlZkNCNWdNaHpMY1pkQnlqTlN2?=
 =?utf-8?B?amJVa3RWYU04N0R4c0NabWhncTJjaDhmUVdjQk1FTVV2VUhCNnZJam1qd0NN?=
 =?utf-8?B?cWlXUFJqQXNNTVh1eXdDSjJpODBCM2RVZkZ0SkNmWWxZb2pZVmhXNi9kekxZ?=
 =?utf-8?B?L3B1RkpOb3RuYWozQTlJZFdQeDhtSkpWWnJ1d2JobVQvamExLzdFSG94R3l0?=
 =?utf-8?B?OUtOdFk2UW5ONVIxZUhMUUhoVmZHQjFwMjgzWWRXYkNyTHpqb25Xa21JblF6?=
 =?utf-8?B?RHpKVmdCYnJxL0hUN2xuUEMzSll2VlJ1Znl2TU9tY1ZkNXJZcFlJOFN2SDFD?=
 =?utf-8?B?TVBJbFlJbVVESHZsWUZVREFRMkdWM0d1U3F2V0FXTXhvK1lyWWVDdnpiUzZB?=
 =?utf-8?B?cTF6RXluQlpNNzBvZTdVdU5lYlN5WHJxVjhLd1M2Y1ZFODJCSTFQZEFaa1o1?=
 =?utf-8?B?ZWh3Ryt5QjFGYk43MnJlRjlsMXQraEJoNVkvMExGN2ZkZDMvVWNjZWUwQUdp?=
 =?utf-8?B?S2FiUWNCSnpFeXZLL2JzSjMvK0F5TEVuaCtXTmJPaU1MV1JoeGFaZG16c0ZS?=
 =?utf-8?B?dVJqcVBXRXNWVStxbzhwcDRNY0RoN21acHVRUENCSHZWUG9aQXBJZnVodFpx?=
 =?utf-8?B?YkFNU0ZaQ1UxMnB3Ulo2N3cyYnNQenczNXdSMDh4TXpNWFgxWi80VkJRenFX?=
 =?utf-8?B?eUNYcDVmQXZKeEpGRkRYWTRRc3RpUXZjVmMwODBRWHpjVGtCdW14MjJaa2hw?=
 =?utf-8?B?YjBOQVZTa0NOc29ETjA5Wmp2T25wSDNGeUpoSDlWNTBlKzBvTXRsL0RqUDR5?=
 =?utf-8?B?QmkrRGEwYmpybUdXVnFsaW8xUjcwOFVGcUV1SU5NS1oxMGxaQzhwbjRQMVZV?=
 =?utf-8?B?dUJRZ056aEltcjNrMjhWZ3VRMjV5cnlnMDUzUlNRVElrZ0w5emtUVisyMkE1?=
 =?utf-8?B?ZDlHeEw4bytlaXlxaG9zelVKVEFRdHJDRHo0V3U2TzZqSGNScUpvZEQyc2FN?=
 =?utf-8?B?NE5Yd3daWEVaUHIyS0IzWVV3UEZDWmVqcTFHc1NnSXBmVjZpS3hxQ3VwOC9j?=
 =?utf-8?B?WE5IbFJBS2Ntc1RnZ1Y0Q05zN3gxQ3IvNDZpS0xOTm9tZWppSlRJNGJsUXlO?=
 =?utf-8?B?UG8rOWhxUXAxQVo5cExLWWVwcHVhMGFROHVyLzdmSGg4b0xuUEc0QmhhZ1pT?=
 =?utf-8?B?K1VSVGtxbkMyVzdmWllueG4yQ0h4citBa1l2Q21GWHczditkbEIxRGZmMllU?=
 =?utf-8?B?eVM0dTdnYUczUUxtaHdzYmFLVFBBNlE1cGVCcS84bDRwZzlpM2dsclFDYVZm?=
 =?utf-8?B?b1h2WmJCOTRUbGpna2djeGttWkxSM2pjbGUreVZJc3c3N2doV1A0NHlpRFNQ?=
 =?utf-8?B?Z29JRWNDbXA4YjlBOWZVc0M0MXVVSlhHRHBGcm9STlo0am1BVk16SE1MeTZP?=
 =?utf-8?Q?oY1u6uge5DyHMfqCMDCsSA4LX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B345FE02693254CACEAF4FDCC6FD818@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3359987f-e8ea-463e-cdc9-08da8b448950
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 11:32:50.3845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnxPM6e0oT9cLy8dTw6Hae5rJUyOZH5mndOr7Pg5HATC77dBOAhk/5FbXahy1s3gHbxEAMyeBndYNeY8ehrgI7iujT0xIibGPxZ1UINzjMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4062
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDguMjAyMiAxMjo0NiwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IE9uIDE3LjA4LjIw
MjIgMTA6NTUsIFNlcmdpdSBNb2dhIHdyb3RlOg0KPj4gUHJldmlvdXNseSwgdGhlIGF0bWVsIHNl
cmlhbCBkcml2ZXIgZGlkIG5vdCB0YWtlIGludG8gYWNjb3VudCB0aGUNCj4+IHBvc3NpYmlsaXR5
IG9mIHVzaW5nIHRoZSBtb3JlIGN1c3RvbWl6YWJsZSBnZW5lcmljIGNsb2NrIGFzIGl0cw0KPj4g
YmF1ZHJhdGUgZ2VuZXJhdG9yLiBVbmxlc3MgdGhlcmUgaXMgYSBGcmFjdGlvbmFsIFBhcnQgYXZh
aWxhYmxlIHRvDQo+PiBpbmNyZWFzZSBhY2N1cmFjeSwgdGhlcmUgaXMgYSBoaWdoIGNoYW5jZSB0
aGF0IHdlIG1heSBiZSBhYmxlIHRvDQo+PiBnZW5lcmF0ZSBhIGJhdWRyYXRlIGNsb3NlciB0byB0
aGUgZGVzaXJlZCBvbmUgYnkgdXNpbmcgdGhlIEdDTEsgYXMgdGhlDQo+PiBjbG9jayBzb3VyY2Uu
IE5vdywgZGVwZW5kaW5nIG9uIHRoZSBlcnJvciByYXRlIGJldHdlZW4NCj4+IHRoZSBkZXNpcmVk
IGJhdWRyYXRlIGFuZCB0aGUgYWN0dWFsIGJhdWRyYXRlLCB0aGUgc2VyaWFsIGRyaXZlciB3aWxs
DQo+PiBmYWxsYmFjayBvbiB0aGUgZ2VuZXJpYyBjbG9jay4gVGhlIGdlbmVyaWMgY2xvY2sgbXVz
dCBiZSBwcm92aWRlZA0KPj4gaW4gdGhlIERUIG5vZGUgb2YgdGhlIHNlcmlhbCB0aGF0IG1heSBu
ZWVkIGEgbW9yZSBmbGV4aWJsZSBjbG9jayBzb3VyY2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
U2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgZHJp
dmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPj4gICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmggfCAgMSAr
DQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgYi9k
cml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4+IGluZGV4IDMwYmE5ZWVmN2IzOS4u
MGEwYjQ2ZWUwOTU1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3Nl
cmlhbC5jDQo+PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4+IEBA
IC0xNSw2ICsxNSw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQo+PiAgICNpbmNs
dWRlIDxsaW51eC9zZXJpYWwuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPj4gKyNp
bmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2NvbnNv
bGUuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3N5c3JxLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51
eC90dHlfZmxpcC5oPg0KPj4gQEAgLTc3LDYgKzc4LDggQEAgc3RhdGljIHZvaWQgYXRtZWxfc3Rv
cF9yeChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KTsNCj4+ICAgI2VuZGlmDQo+PiAgIA0KPj4gICAj
ZGVmaW5lIEFUTUVMX0lTUl9QQVNTX0xJTUlUCTI1Ng0KPj4gKyNkZWZpbmUgRVJST1JfUkFURShk
ZXNpcmVkX3ZhbHVlLCBhY3R1YWxfdmFsdWUpIFwNCj4+ICsJKChpbnQpKDEwMCAtICgoZGVzaXJl
ZF92YWx1ZSkgKiAxMDApIC8gKGFjdHVhbF92YWx1ZSkpKQ0KPj4gICANCj4+ICAgc3RydWN0IGF0
bWVsX2RtYV9idWZmZXIgew0KPj4gICAJdW5zaWduZWQgY2hhcgkqYnVmOw0KPj4gQEAgLTExMCw2
ICsxMTMsNyBAQCBzdHJ1Y3QgYXRtZWxfdWFydF9jaGFyIHsNCj4+ICAgc3RydWN0IGF0bWVsX3Vh
cnRfcG9ydCB7DQo+PiAgIAlzdHJ1Y3QgdWFydF9wb3J0CXVhcnQ7CQkvKiB1YXJ0ICovDQo+PiAg
IAlzdHJ1Y3QgY2xrCQkqY2xrOwkJLyogdWFydCBjbG9jayAqLw0KPj4gKwlzdHJ1Y3QgY2xrCQkq
Z2NsazsJCS8qIHVhcnQgZ2VuZXJpYyBjbG9jayAqLw0KPj4gICAJaW50CQkJbWF5X3dha2V1cDsJ
LyogY2FjaGVkIHZhbHVlIG9mIGRldmljZV9tYXlfd2FrZXVwIGZvciB0aW1lcyB3ZSBuZWVkIHRv
IGRpc2FibGUgaXQgKi8NCj4+ICAgCXUzMgkJCWJhY2t1cF9pbXI7CS8qIElNUiBzYXZlZCBkdXJp
bmcgc3VzcGVuZCAqLw0KPj4gICAJaW50CQkJYnJlYWtfYWN0aXZlOwkvKiBicmVhayBiZWluZyBy
ZWNlaXZlZCAqLw0KPj4gQEAgLTIxMTUsNiArMjExOSw4IEBAIHN0YXRpYyB2b2lkIGF0bWVsX3Nl
cmlhbF9wbShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCB1bnNpZ25lZCBpbnQgc3RhdGUsDQo+PiAg
IAkJICogVGhpcyBpcyBjYWxsZWQgb24gdWFydF9jbG9zZSgpIG9yIGEgc3VzcGVuZCBldmVudC4N
Cj4+ICAgCQkgKi8NCj4+ICAgCQljbGtfZGlzYWJsZV91bnByZXBhcmUoYXRtZWxfcG9ydC0+Y2xr
KTsNCj4+ICsJCWlmIChhdG1lbF9wb3J0LT5nY2xrICYmIF9fY2xrX2lzX2VuYWJsZWQoYXRtZWxf
cG9ydC0+Z2NsaykpDQo+IA0KPiBObyBuZWVkIHRvIGNoZWNrIGZvciBhdG1lbF9wb3J0LT5nY2xr
ICE9IE5VTEwuIGNsayBBUElzIGFyZSBhbHJlYWR5IGRvaW5nIHRoaXMuDQo+IA0KPj4gKwkJCWNs
a19kaXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5nY2xrKTsNCj4+ICAgCQlicmVhazsNCj4+
ICAgCWRlZmF1bHQ6DQo+PiAgIAkJZGV2X2Vycihwb3J0LT5kZXYsICJhdG1lbF9zZXJpYWw6IHVu
a25vd24gcG0gJWRcbiIsIHN0YXRlKTsNCj4+IEBAIC0yMTI5LDcgKzIxMzUsOCBAQCBzdGF0aWMg
dm9pZCBhdG1lbF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qga3Rl
cm1pb3MgKnRlcm1pb3MsDQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBhdG1lbF91YXJ0X3BvcnQgKmF0
bWVsX3BvcnQgPSB0b19hdG1lbF91YXJ0X3BvcnQocG9ydCk7DQo+PiAgIAl1bnNpZ25lZCBsb25n
IGZsYWdzOw0KPj4gLQl1bnNpZ25lZCBpbnQgb2xkX21vZGUsIG1vZGUsIGltciwgcXVvdCwgYmF1
ZCwgZGl2LCBjZCwgZnAgPSAwOw0KPj4gKwl1bnNpZ25lZCBpbnQgb2xkX21vZGUsIG1vZGUsIGlt
ciwgcXVvdCwgZGl2LCBjZCwgZnAgPSAwOw0KPj4gKwl1bnNpZ25lZCBpbnQgYmF1ZCwgYWN0dWFs
X2JhdWQsIGdjbGtfcmF0ZTsNCj4+ICAgDQo+PiAgIAkvKiBzYXZlIHRoZSBjdXJyZW50IG1vZGUg
cmVnaXN0ZXIgKi8NCj4+ICAgCW1vZGUgPSBvbGRfbW9kZSA9IGF0bWVsX3VhcnRfcmVhZGwocG9y
dCwgQVRNRUxfVVNfTVIpOw0KPj4gQEAgLTIyODgsNiArMjI5NSwzNyBAQCBzdGF0aWMgdm9pZCBh
dG1lbF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qga3Rlcm1pb3Mg
KnRlcm1pb3MsDQo+PiAgIAkJY2QgLz0gODsNCj4+ICAgCQltb2RlIHw9IEFUTUVMX1VTX1VTQ0xL
U19NQ0tfRElWODsNCj4+ICAgCX0NCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogSWYgdGhlcmUgaXMg
bm8gRnJhY3Rpb25hbCBQYXJ0LCB0aGVyZSBpcyBhIGhpZ2ggY2hhbmNlIHRoYXQNCj4+ICsJICog
d2UgbWF5IGJlIGFibGUgdG8gZ2VuZXJhdGUgYSBiYXVkcmF0ZSBjbG9zZXIgdG8gdGhlIGRlc2ly
ZWQgb25lDQo+PiArCSAqIGlmIHdlIHVzZSB0aGUgR0NMSyBhcyB0aGUgY2xvY2sgc291cmNlIGRy
aXZpbmcgdGhlIGJhdWRyYXRlDQo+PiArCSAqIGdlbmVyYXRvci4NCj4+ICsJICovDQo+PiArCWlm
ICghZnAgJiYgYXRtZWxfcG9ydC0+Z2Nsaykgew0KPj4gKwkJaWYgKF9fY2xrX2lzX2VuYWJsZWQo
YXRtZWxfcG9ydC0+Z2NsaykpDQo+PiArCQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGF0bWVsX3Bv
cnQtPmdjbGspOw0KPiANCj4gWW91IGRpc2FibGVkIGl0IGhlcmUsIHNldCBuZXcgcmF0ZSBidXQg
cmUtZW5hYmxlIGl0IGNvbmRpdGlvbmFsbHkgYWJvdmUsIGlzDQo+IHRoaXMgaW50ZW5kZWQ/IHRo
ZSBiZWxvdyBjb25kaXRpb24gbWF5IGZhaWwuDQo+IA0KDQpZZXMsIGl0IGlzIGludGVuZGVkLiBH
Y2xrIHNob3VsZCByZW1haW4gZGlzYWJsZWQgaWYgdGhlIGJlbG93IGNvbmRpdGlvbiANCmZhaWxz
Lg0KDQoNCj4+ICsJCWNsa19zZXRfcmF0ZShhdG1lbF9wb3J0LT5nY2xrLCAxNiAqIGJhdWQpOw0K
Pj4gKwkJZ2Nsa19yYXRlID0gY2xrX2dldF9yYXRlKGF0bWVsX3BvcnQtPmdjbGspOw0KPiANCj4g
WW91IHNob3VsZCBiZSBhYmxlIHRvIHVzZSBjbGtfcm91bmRfcmF0ZSgpIGhlcmU6DQo+IAkJZ2Ns
a19yYXRlID0gY2xrX3JvdW5kX3JhdGUoYXRtZWxfcG9ydC0+Z2NsaywNCj4gCQkJCQkgICAxNiAq
IGJhdWRyYXRlKTsNCj4gDQo+IFdpdGggdGhpcyB5b3UgY2FuIHJlLXdyaXRlIGFsbCB0aGlzIGJs
b2NrIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gCQlnY2xrX3JhdGUgPSBjbGtfcm91bmRfcmF0ZShh
dG1lbF9wb3J0LT5nY2xrLA0KPiAJCQkJCSAgIDE2ICogYmF1ZHJhdGUpOw0KPiAJCWFjdHVhbF9i
YXVkID0gZ2Nsa19yYXRlIC8gKDE2ICogY2QpOw0KPiAJCWlmIChhYnMoRVJST1JfUkFURShiYXVk
LCBhY3R1YWxfYmF1ZCkpID4NCj4gCQkgICAgYWJkKEVSUk9SX1JBVEUoYmF1ZCwgZ2Nsa19yYXRl
IC8gMTYpKSkgew0KPiAJCQltb2RlIHw9IEFUTUVMX1VTX0dDTEs7DQo+IAkJCWNkID0gMTsNCj4g
CQkJaWYgKF9fY2xrX2lzX2VuYWJsZWQoYXRtZWxfcG9ydC0+Z2NsaykpDQo+IAkJCQljbGtfZGlz
YWJsZV91bnByZXBhcmUoYXRtZWxfcG9ydC0+Z2NsaykNCj4gCQkJY2xrX3NldF9yYXRlKGF0bWVs
X3BvcnQtPmdjbGssIGdjbGtfcmF0ZSk7DQo+IAkJCWNsa19wcmVwYXJlX2VuYWJsZShhdG1lbF9w
b3J0LT5nY2xrKTsNCj4gCQl9DQo+IA0KPiANCg0KSG1tLCB5ZXMsIHlvdSBhcmUgcmlnaHQsIGl0
IGlzIG11Y2ggYmV0dGVyIHdpdGggdGhpcyBjbGtfcm91bmRfcmF0ZSgpIA0Kc2luY2UgdGhlcmUg
d291bGQgYmUgbm8gbmVlZCB0byBkaXNhYmxlIGdjbGsgYmVmb3JlIHNldHRpbmcgdGhlIG5ldyAN
CnJhdGUsIEkgZGlkIG5vdCBrbm93IG9mIHRoaXMgZnVuY3Rpb24gYXQgdGhhdCBwb2ludC4gSG93
ZXZlciwgaW4gdGhpcyANCmNhc2UsIHRoZSBpZihhYnMuLi4pIHdpbGwgYWxzbyBuZWVkIGFuIGVs
c2UgdG8gZGlzYWJsZSB0aGUgZ2NsayBpbiBjYXNlIA0KdGhlIGNvbmRpdGlvbiBmYWlsZWQgYW5k
IGl0IHdhcyBzb21laG93IGVuYWJsZWQgYmVmb3JlLg0KDQoNCj4+ICsJCWFjdHVhbF9iYXVkID0g
Y2xrX2dldF9yYXRlKGF0bWVsX3BvcnQtPmNsaykgLyAoMTYgKiBjZCk7DQo+PiArCQlpZiAoYWJz
KEVSUk9SX1JBVEUoYmF1ZCwgYWN0dWFsX2JhdWQpKSA+DQo+PiArCQkgICAgYWJzKEVSUk9SX1JB
VEUoYmF1ZCwgZ2Nsa19yYXRlIC8gMTYpKSkgew0KPj4gKwkJCW1vZGUgfD0gQVRNRUxfVVNfR0NM
SzsNCj4+ICsNCj4+ICsJCQkvKg0KPj4gKwkJCSAqIFNldCB0aGUgQ2xvY2sgRGl2aXNvciBmb3Ig
R0NMSyB0byAxLg0KPj4gKwkJCSAqIFNpbmNlIHdlIHdlcmUgYWJsZSB0byBnZW5lcmF0ZSB0aGUg
c21hbGxlc3QNCj4+ICsJCQkgKiBtdWx0aXBsZSBvZiB0aGUgZGVzaXJlZCBiYXVkcmF0ZSB0aW1l
cyAxNiwNCj4+ICsJCQkgKiB0aGVuIHdlIHN1cmVseSBjYW4gZ2VuZXJhdGUgYSBiaWdnZXIgbXVs
dGlwbGUNCj4+ICsJCQkgKiB3aXRoIHRoZSBleGFjdCBlcnJvciByYXRlIGZvciBhbiBlcXVhbGx5
IGluY3JlYXNlZA0KPj4gKwkJCSAqIENELiBUaHVzIG5vIG5lZWQgdG8gdGFrZSBpbnRvIGFjY291
bnQNCj4+ICsJCQkgKiBhIGhpZ2hlciB2YWx1ZSBmb3IgQ0QuDQo+PiArCQkJICovDQo+PiArCQkJ
Y2QgPSAxOw0KPj4gKwkJCWNsa19wcmVwYXJlX2VuYWJsZShhdG1lbF9wb3J0LT5nY2xrKTsNCj4+
ICsJCX0NCj4+ICsJfQ0KPj4gKw0KPj4gICAJcXVvdCA9IGNkIHwgZnAgPDwgQVRNRUxfVVNfRlBf
T0ZGU0VUOw0KPj4gICANCj4+ICAgCWlmICghKHBvcnQtPmlzbzc4MTYuZmxhZ3MgJiBTRVJfSVNP
NzgxNl9FTkFCTEVEKSkNCj4+IEBAIC0yODgzLDYgKzI5MjEsMTYgQEAgc3RhdGljIGludCBhdG1l
bF9zZXJpYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgCWlmIChy
ZXQpDQo+PiAgIAkJZ290byBlcnI7DQo+PiAgIA0KPj4gKwlhdG1lbF9wb3J0LT5nY2xrID0gZGV2
bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJnY2xrIik7DQo+PiArCWlmIChhdG1lbF9w
b3J0LT5nY2xrKSB7DQo+PiArCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoYXRtZWxfcG9ydC0+
Z2Nsayk7DQo+PiArCQlpZiAocmV0KSB7DQo+PiArCQkJYXRtZWxfcG9ydC0+Z2NsayA9IE5VTEw7
DQo+PiArCQkJcmV0dXJuIHJldDsNCj4+ICsJCX0NCj4+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShhdG1lbF9wb3J0LT5nY2xrKTsNCj4gDQo+IElzIHRoZXJlIGEgcmVhc29uIHlvdSBlbmFibGUg
dGhlbiBkaXNhYmxlIHRoZSBjbG9jayBoZXJlPw0KPiANCg0KDQpJIHRoaW5rIGl0J3MgYmV0dGVy
IHRvIG1ha2Ugc3VyZSBpbiB0aGUgcHJvYmUgbWV0aG9kIHRoYXQgZW5hYmxpbmcgdGhlIA0KZ2Ns
ayBpc3N1ZXMgbm8gZXJyb3JzLCBzbyB0aGF0IHRoZSBlcnJvciBkb2VzIG5vdCBhcHBlYXIgaW4g
DQpzZXRfdGVybWlvcygpLiBTaW5jZSB0aGUgdXNlciBtdXN0IHBsYWNlIHRoZSBvcHRpb25hbCBn
Y2xrIGluIERUIGlmIHRoZXkgDQp3YW50IGEgZmluZXIgcmF0ZSB3aGVuIG1pc3NpbmcgdGhlIEZy
YWN0aW9uYWwgUGFydCwgSSB0aGluayB0aGV5IHNob3VsZCANCmtub3cgYmVmb3JlIGV2ZW4gdHJ5
aW5nIHRvIG9wZW4gdGhlIHBvcnQgdGhhdCBpdCBpcyBmaXJzdCBjb3JyZWN0bHkgDQpzZXR1cCBp
biB0aGUgY2xvY2sgdHJlZSBhcyB3ZWxsIGJ5IG1ha2luZyB0aGUgcHJvYmUgbWV0aG9kIGZhaWwg
ZnJvbSB0aGUgDQp2ZXJ5IGJlZ2lubmluZyBpbiBjYXNlIGl0IGlzIG5vdC4NCg0KU28sIEkgZmly
c3QgZW5hYmxlIGl0IGFuZCBtYWtlIHN1cmUgdGhlcmUgYXJlIG5vIGVycm9ycyBhbmQgdGhlbiBk
aXNhYmxlIA0KaXQgYmVjYXVzZSBJIGRvIG5vdCBzZWUgdGhlIHBvaW50IG9mIGhhdmluZyBhbiBl
bmFibGVkIGNsb2NrIHRoYXQgbWlnaHQgDQpub3QgYmUgdXNlZC4NCg0KDQo+PiArCX0NCj4+ICsN
Cj4+ICAgCXJldCA9IGF0bWVsX2luaXRfcG9ydChhdG1lbF9wb3J0LCBwZGV2KTsNCj4+ICAgCWlm
IChyZXQpDQo+PiAgIAkJZ290byBlcnJfY2xrX2Rpc2FibGVfdW5wcmVwYXJlOw0KPj4gQEAgLTI5
MjksNiArMjk3Nyw4IEBAIHN0YXRpYyBpbnQgYXRtZWxfc2VyaWFsX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgIAkgKiBpcyB1c2VkDQo+PiAgIAkgKi8NCj4+ICAgCWNs
a19kaXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5jbGspOw0KPj4gKwlpZiAoYXRtZWxfcG9y
dC0+Z2NsayAmJiBfX2Nsa19pc19lbmFibGVkKGF0bWVsX3BvcnQtPmdjbGspKQ0KPj4gKwkJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGF0bWVsX3BvcnQtPmdjbGspOw0KPiANCj4gSXMgdGhpcyBkdWUg
dG8gdGhlIGVuYWJsZSBpbiBhdG1lbF9zZXRfdGVybWlvcygpPyBJcyB0aGF0IGNhbGxlZCBvbiBw
cm9iZQ0KPiBwYXRoPyBBbHNvLCB0aGVyZSBpcyBubyBuZWVkIHRvIGNoZWNrIGZvciBhdG1lbF9w
b3J0LT5nY2xrIGFzIGNsayBBUElzIGFyZQ0KPiBhbHJlYWR5IGRvaW5nIHRoaXMuDQo+IA0KDQoN
Ck5vLCBJIGd1ZXNzIHRoaXMgaXMgbm90IHJlYWxseSBuZWVkZWQsIHNpbmNlIGl0IGlzIGRpc2Fi
bGVkIG9uY2UgaXQgaXMgDQpjbGFpbWVkIGZyb20gRFQgaWYgZW5hYmxpbmcgaXQgc3VjY2VlZHMu
IEkgaW5pdGlhbGx5IHBsYWNlZCB0aGlzIGNvZGUgDQpzZXF1ZW5jZSB3aGVyZXZlciB0aGUgcGVy
aXBoZXJhbCBjbG9jayBpcyBkaXNhYmxlZCBhcyB3ZWxsLg0KDQo+PiAgIA0KPj4gICAJcmV0dXJu
IDA7DQo+PiAgIA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJp
YWwuaCBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuaA0KPj4gaW5kZXggMGQ4YTBm
OWNjNWMzLi5mYjcxODk3MmY4MWEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwv
YXRtZWxfc2VyaWFsLmgNCj4+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwu
aA0KPj4gQEAgLTYzLDYgKzYzLDcgQEANCj4+ICAgI2RlZmluZQkJQVRNRUxfVVNfUEFSX01BUksJ
CSgzIDw8ICA5KQ0KPj4gICAjZGVmaW5lCQlBVE1FTF9VU19QQVJfTk9ORQkJKDQgPDwgIDkpDQo+
PiAgICNkZWZpbmUJCUFUTUVMX1VTX1BBUl9NVUxUSV9EUk9QCQkoNiA8PCAgOSkNCj4+ICsjZGVm
aW5lIEFUTUVMX1VTX0dDTEsgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVCgxMikNCj4gDQo+
IEl0IHNlZW1zIHRoZXJlIGFyZSBzcGFjZXMgaGVyZS4NCj4gDQo+PiAgICNkZWZpbmUJQVRNRUxf
VVNfTkJTVE9QCQlHRU5NQVNLKDEzLCAxMikJLyogTnVtYmVyIG9mIFN0b3AgQml0cyAqLw0KPj4g
ICAjZGVmaW5lCQlBVE1FTF9VU19OQlNUT1BfMQkJKDAgPDwgMTIpDQo+PiAgICNkZWZpbmUJCUFU
TUVMX1VTX05CU1RPUF8xXzUJCSgxIDw8IDEyKQ0KPiANCg0KVGhhbmtzLA0KCVNlcmdpdQ0K
