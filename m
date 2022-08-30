Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BDC5A658F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiH3NvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiH3NvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:51:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348610E;
        Tue, 30 Aug 2022 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661867364; x=1693403364;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jBen5paD7gcuEP0lrrkn7LvOB7QD0K1Dvoi3iICW1qQ=;
  b=bMIAho+sg4vMixPmzgOA0+GCZm/p/8FrmdpdMnQPBxg0lOqO/Rqmgs9s
   PDzZe67lqj6L62gSm0tJ/KCyRDF5mhW29p2AQM3f0a85eLD4En7Sb8D0u
   2W9L/F4vGJ2aEER3Xt6QV7cIq4py1EdcLhA2qZ3J+BPdhbcUejmRSTPpm
   Gga4YRayTkc2dWyI6tVn39PIeDFzOIn//JfZM8+IMgJAnLJYBd+qaqHML
   Txz4a25wbv8blL3IZntiFWvnNj7vizBPBLEXen0JrKzMECNjRHoz5+Mfj
   HY76zaymPblfWbgmisiXHL033lwshU2Y8CGnDbcUI3NmYp4+1vankZEdk
   A==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="171597113"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 06:49:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 06:49:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 06:49:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDuPkpnUFNMVmSPCAv5JXIY1u7PkeaEgKL5IYbt40CUt3WvoAKemo5DBc9b3LQSMZcRqKoakp3xJ1Ir4afoDHoIIMskdjYY2WTwFZejZ1/NSvK3CWnT+yeac0GIdxDIFkA5/c+vGoh/dYTiIxoE+fnmVwKgbbGQqpyx+RD6Nl3WdAMeb52Q74HGFk3vheexPSpBeRyaBu9br3T366DFE/C3nQAm1oYk9qM7rm/eWcEhSbGYz7rqhmDjAsddd9wFBlgttsta6t8fVtcjAOxWqEHm6xFkqXuzF3veIffSlqKjILBIwsbDn96kBfbjPqWaaOK9j0+gfyUimYoNSUG7QHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBen5paD7gcuEP0lrrkn7LvOB7QD0K1Dvoi3iICW1qQ=;
 b=aHpkkD4i3cNqj9/m78rn5k2NUQg0U5ekUF7VHci4BTkeV/wb5t9RJIqB4NJTIfm4y++88+miaGwGYyvzHYp25kN5g1bqsIrtUwdTBrvSPFrBxvXRSQ1BxQbHdgUnM3KWM1o3nCrPC4EQ2LODy50LRD8E1fx1YyxfA8ix+Ta1lyhrWVkrKeOQNlLOUeWL6Z/waLTxATpm3lfAOiBJCOJIWzyxoO2gDYAgXEzh8oRGe3YKUi+FML+JU8XNuJ0xDVSuzeQJzi4GQrVOUwauZDZnM2FUF4AIHxTz6GPKP5+Wy+7ePejtoLOwik5/r6mwfrEIlyMLvRlNmgeQiiuKaS4/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBen5paD7gcuEP0lrrkn7LvOB7QD0K1Dvoi3iICW1qQ=;
 b=naC46qQBv1aLyicK9R5j1CQfgGJ3P4O135tzGos0MkyE1A3S1GlLkSZecTlhA/BJV2iAGQgjvrBLqXQtHWM4+H6zNcRxCvbp8N2ptUc0vrfoF79/t6xwLrXtYd40OoVRrXvtMtOdYZE0Qp6sQ3rSzirGuf5W0Z48Pu1QKLJW65k=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1245.namprd11.prod.outlook.com (2603:10b6:300:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 13:49:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 13:49:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ben.dooks@sifive.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for l3
 cache
Thread-Topic: [RESEND PATCH] dt-bindings: sifive-ccache: fix cache level for
 l3 cache
Thread-Index: AQHYvG9DsO2L31s8JEW+tF32qWQ5gq3HZuqAgAAAiQCAAA5EgA==
Date:   Tue, 30 Aug 2022 13:49:16 +0000
Message-ID: <8422fb34-fc05-eddd-0eaa-3e713896d05d@microchip.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830125133.1698781-1-ben.dooks@sifive.com>
 <b810d354-18f3-9ae0-6310-57d9e36f4f9b@microchip.com>
 <6b6837c1-5a2c-567b-ba64-72a1dca38807@sifive.com>
In-Reply-To: <6b6837c1-5a2c-567b-ba64-72a1dca38807@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 997fe517-8896-40cb-893c-08da8a8e6e16
x-ms-traffictypediagnostic: MWHPR11MB1245:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezPPELok626k5PabdneN4aBoiZSnnRWT3PrDc/ohA5ruHGgsyNoNPmWPnrc5deN7Zi/IQkwrnYXzntZP4KyszFD+kUz/GEwyyPtcQYzhQ3WXCcVNTbXkaNI1hnu54VtUrbWxxW3fOpQeHEG39MciTkahLsphjn5ig2IROAX10yGNM7zXSiwI0OnkITEI6zy0JpBbuWr6Xvm3mRSuHLTreiqBZdSZP5Ihjr6jMEv+VeR3MrAwEMZQc/KY79azdlP88nihCE0SNEKz8E9CrzOWY8+HFrZUWNZAoKiJZdZHQSUXUMPXb7vZ0AdbmgFU2g2+Ran61hBOKmxW+EBV0IkfMFBS4Pa1iCsex7AcUfB7I4EjnORIBLbidecpW6VN0JZtmMCwxthL3tnen7K50Cmadel3VxLoGT8yGeYOUapxVg7C9sQYo4QDYLA/CbUWmI5DTcENvgQED+cn1BDvXdJ3qomdVKA6sMVHo6UYKwN6yKv04MKKgFLnSO5Lt7a1VaJFLn15pexJJyyA1ADoHN8HcDKZUZFeki8ns6wB2LuRp82ejNTpkUe7qwz46hpdz7KAHfz49Gtm9HcEuALihNjyaV11Lw7+wNKco9aWXGI/edrrugLu1bkjqdDDlKHFP2JEbJj4nfxsZ+9/VMchfgurEyBpTIbyeYXSwTgDSWj9WXojaOV3WxibR/iHwSLyO6kXOXWYyPp7JSfn460jM20eqEZ+kx3mvFkRkPKLtj5oetMS8SI/pfikWZUTMgm2tOWumqCG4eFi9GZHp5TQZY31c3Pa92uTKi+S5iqWOdR6JBg9dpMzX5jYe1VzeZ+fkr8OrKkZlTPhIof+U0SptoRG41PlZ1+hxUpEfFR9X2PUyoiqEalTvIxHwX2dhjHy51Zk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(136003)(366004)(91956017)(38100700002)(122000001)(36756003)(316002)(76116006)(66446008)(66946007)(66476007)(8676002)(64756008)(66556008)(86362001)(31686004)(31696002)(38070700005)(921005)(71200400001)(83380400001)(478600001)(6506007)(26005)(53546011)(6512007)(41300700001)(966005)(6486002)(110136005)(7416002)(2906002)(2616005)(186003)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnN3RkZrUlN4YmFreXpVQkdqay9OV3JGMHBHTDlWNWp5UmpWSjBOSjR6Nkdx?=
 =?utf-8?B?di9SK3ZsSkNHdmpZUmF6ZVlzVTY0TjlrbVpiS2dWbFlCMHJmZkQzejV5RnRD?=
 =?utf-8?B?WlJhcDU0L3A1VzlHYzYxM0lYZXhFY0VaZlRadkRMZjltRFdMOUFnODc1UldL?=
 =?utf-8?B?RW11VXEyRDB1NkFiVGU4bGlhd2tXSTJDaGZHZWR6dEhqdDc4bzhxRk40cmhj?=
 =?utf-8?B?dzlZd1ZzaXgyMzJFZjdyZXMreGE3WWlhdjg4VWUyVjYwbENiTDhlK0piMGg1?=
 =?utf-8?B?YndqNmZMSHZoQkJMbWlTQm9HcFBMNlY3cnFpTElXMVhTak1xaWxGdU5oRWhy?=
 =?utf-8?B?UFJRWGVTWEtIUVgrdmk3eVRWOTVKQ1JvaWF2N2JaNnZSRm9QdnhocHYvL1lU?=
 =?utf-8?B?dkd5S1pRUUF0WWs3SkI1a2VMM2RGNENtZ1UyNnRYQXYwT1N2OXBtSEZHNlh3?=
 =?utf-8?B?UEhHSmVtRHFzdEhPcWtGOVRZZHpDd0hRdTQydkdENFlxbjdEL2RCQWF2aDZO?=
 =?utf-8?B?aHV6WmVZUlBGRFBFK3FiZTJ2ZGhhLzU4QklnTk5kbVFGZVhiT0pabkU3UnRY?=
 =?utf-8?B?NG9RNVdwOExpbUYreUVRZlNTS1VQb08rMVZwUDZtTkNQL1RsNWZERW5NTHV3?=
 =?utf-8?B?S2Q2T2UzdG9SNVdGRGtFRHE0dTdyczVSWHhhVEs3NmlDdlpvUmdZZWdQY1p4?=
 =?utf-8?B?R0lrYlpTWlBvZzYyVXQvNDA0dWZjSnBpdis4Nk5tUzJ2UzFUSm41RnlRcENt?=
 =?utf-8?B?Z2NoazRGaWlRWEhtY0FOb3BrNGs0elhOT2hQR3ZOa2R4MUlIK2tHZFNDUkc0?=
 =?utf-8?B?YjQ2SXMyQkpXVEFXYXJBNmY5cGFmZ1FlOFdYUnNSTnJ0RVRQRkhGNVRPN0hT?=
 =?utf-8?B?UmpwZ3RBM1NxbzUzY3ZJQ3ViQmF5ZGdFeTJJSE80N2ZwdWdzR3pORUhwMHJH?=
 =?utf-8?B?R0dKWnlMUnUwNnIveWIxdlpTTnAzdllvdVhycVQ4clBkSE5Ic0Z2YXo1NVNo?=
 =?utf-8?B?S3NPS002R2FwNVVEWEhKVXk5WFV3cHFTZitUQmtsYTRNNVFUT1JnblYyUzVz?=
 =?utf-8?B?d1dFVHN6YUgva2dhMWFJeVZoMzlLL2Z5b01nYmsxSW4yOCttc094Vjd0bGVp?=
 =?utf-8?B?WUVITGRZU1ozNEpUTzNpSithTjBLdHRucFRWWHNIQ2dJSEVlVnpKelRRekRR?=
 =?utf-8?B?Y1pXZXMwbzFuSENqNHBubHd6VHVMR052c2lUMG1zSklOZC9ZcHVqRS9meUF2?=
 =?utf-8?B?ZUlDbllUS3JQSTdYaXRIUUdpRll0amRjSUJ3enR6UE96U09YclV4dHdGMHJu?=
 =?utf-8?B?N2JjbWVTU3QvcS8rR1NiMzEzWFdmQTBzY2dFRFJkL292N04rZnFBeHA5Z2RV?=
 =?utf-8?B?VVNsUWNIQXdhL2o4dzA2aExEUXpuek11MXNkUFpsQzBoVHV0Rk1wMUt4RXZP?=
 =?utf-8?B?aHFITUFrR0lVUElNTXhoa3l3djlTSW9lZVJieVZ5RFBiU0wybnd6WmN4THJ2?=
 =?utf-8?B?OU9IM1I0RFJwbm40SWRTT01aUUdtalJSb0x6YUJWcXgya1FuV3llblprOXQ3?=
 =?utf-8?B?K0s3Z2NGYWw5NE5KdmlMWHZRKy9ubjhtU3kzV0VMQkk4Y3RYYThPa0p1NDhk?=
 =?utf-8?B?dVdxQWphczFILzlBdEdpN3k2OWg1VUV1ZXNkTE1uZDU2R0ZveGVtK0hrL2Jx?=
 =?utf-8?B?UW9wN294Vk83Q0Zmb2YzU3h5S2tzenR6UEpuL2R0YXRMdFA1UHB3UUdCUzNj?=
 =?utf-8?B?V1dVYUF4cUpQM3dSWlEvSjdQSkNxY0dLenVLVTdkTDY2aHViM2ovQzdISTdv?=
 =?utf-8?B?MmdLcHlPVlRveFp1RzNaUmw5S2V1NXJvbDZac2g3SWVYdUtqczRBTFpyYVRR?=
 =?utf-8?B?WExsMjRaalNQQlJ2TUp4U2Zqc01wRFc3R1Ftb0ZxRWErZkpwMEV3NEl1SFZI?=
 =?utf-8?B?SDhjNkRDUWhQZllLWEJaN0NaVDgvdHlxWVJtYXJqMnFuOE9iMXkvbHYrVFRJ?=
 =?utf-8?B?REkzUzFuQ2tGQUlSUHk0cnY3U21hZzJQWmpLT2RteXBvdHM5UjFKZ2JhUXRs?=
 =?utf-8?B?dmJnZVgySFdETjJucktIRDhacDdLR2JBK3RNWUtCa0s2UUtkOFJBMGVrUjlr?=
 =?utf-8?B?U1I1bGprcWhEeVljaUJDbGRIUi9DVnFYTmY2UzZFUnhnY1YwWXFGRW5YMnJH?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B37883E513CDD14C917C3F454EAD2446@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997fe517-8896-40cb-893c-08da8a8e6e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 13:49:16.2838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sA9wrfCcGm+lO9TmSYlKjga44gc2hirG+usvtUgcZr1cvc0jzWTlqI3wG4r7pyRdLSuUxyKsYb7ee20h9ZkVxI7a2ECmeQ8aBGsMuOtXko0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1245
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxMzo1OCwgQmVuIERvb2tzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDMwLzA4LzIwMjIgMTM6NTYsIENvbm9yLkRvb2xl
eUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMzAvMDgvMjAyMiAxMzo1MSwgQmVuIERvb2tz
IHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4g
V2l0aCBuZXdlciBjb3JlcyBzdWNoIGFzIHRoZSBwNTUwLCB0aGUgU2lGaXZlIGNvbXBvc2FibGUg
Y2FjaGUgY2FuIGJlDQo+Pj4gYSBsZXZlbCAzIGNhY2hlLiBVcGRhdGUgdGhlIGNhY2hlIGxldmVs
IHRvIGJlIG9uZSBvZiAyIG9yIDMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBCZW4gRG9va3Mg
PGJlbi5kb29rc0BzaWZpdmUuY29tPg0KPj4+IC0tLQ0KPj4+IMKgwqAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L3NpZml2ZS1jY2FjaGUueWFtbCB8IDIgKy0NCj4+PiDC
oMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9z
aWZpdmUtY2NhY2hlLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvcmlz
Y3Yvc2lmaXZlLWNjYWNoZS55YW1sDQo+Pj4gaW5kZXggMWE2NGE1Mzg0ZTM2Li42MTkwZGViNjU0
NTUgMTAwNjQ0DQo+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jp
c2N2L3NpZml2ZS1jY2FjaGUueWFtbA0KPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9yaXNjdi9zaWZpdmUtY2NhY2hlLnlhbWwNCj4+PiBAQCAtNDUsNyArNDUsNyBA
QCBwcm9wZXJ0aWVzOg0KPj4+IMKgwqDCoMKgwqDCoCBjb25zdDogNjQNCj4+Pg0KPj4+IMKgwqDC
oMKgIGNhY2hlLWxldmVsOg0KPj4+IC3CoMKgwqAgY29uc3Q6IDINCj4+PiArwqDCoMKgIGVudW06
IFsyLCAzXQ0KPj4NCj4+IERvIHdlIHdhbnQgdG8gZW5mb3JjZSB0aGUgY2FjaGUgbGV2ZWwgbGlr
ZSB3ZSBjdXJyZW50bHkgZG8gZm9yDQo+PiBpbnRlcnJ1cHRzIGFuZCBjYWNoZS1zZXRzPw0KPiAN
Cj4gTm90IHN1cmUgb24gdGhhdCwgZm9yIHRoZSBQNTUwIGNvcmVzIHRoZSBjY2FjaGUgaXMgZ29p
bmcgdG8gYmUgbGV2ZWwzDQo+IGFuZCBteSBjb2xsZWFndWUgaGFzIHNhaWQgaXQgZG9lcyBjb25m
dXNlIHNvbWUgdG9vbGluZyBpZiB0aGUgbGV2ZWwgaXMNCj4gbm90IHNldCBjb3JyZWN0bHkuDQoN
CldoYXQgSSBtZWFudCB3YXM6DQpDdXJyZW50bHkgd2UgZW5mb3JjZSB0aGUgY29ycmVjdCBjYWNo
ZS1zZXRzICYgaW50ZXJydXB0cyBiYXNlZCBvbiB0aGUNCmNvbXBhdGlibGUgc3RyaW5nLiBBZGRp
bmcgZW51bTogWzIsIDNdIHJlbGF4ZXMgdGhlIGVuZm9yY2VtZW50IG9mIHRoZQ0KY2FjaGUtbGV2
ZWwgZm9yIGV4aXN0aW5nIGNvbXBhdGlibGVzIGFuZCBkb2VzIG5vdCBwcmV2ZW50IHNvbWVvbmUg
ZnJvbQ0Kc2V0dGluZyBhbiBpbmNvcnJlY3QgY2FjaGUgbGV2ZWwgZm9yIHA1NTAgY29yZXMuDQoN
CkkgdGhpbmsgdGhhdCBvbiB0b3Agb2YgYWRkaW5nIHRoZSBlbnVtLCB3ZSBzaG91bGQgYWRkIHNv
bWUgZW5mb3JjZW1lbnQNCnNvIHRoYXQgdGhlIGNhY2hlIGlzIG5vdCBpbmNvcnJlY3RseSBjb25m
aWd1cmVkIGZvciBib3RoIGV4aXN0aW5nIGwyDQpjYWNoZXMgYW5kIGZvciB0aGUgbmV3IGwzIHZl
cnNpb25zLg0KDQpAWm9uZywgY291bGQgeW91IHBsZWFzZSBpbmNvcnBvcmF0ZSBCZW4ncyBwYXRj
aGVzIGludG8geW91ciBWMj8gaXQNCndvdWxkIG1ha2UgaXQgYSBsb3QgZWFzaWVyIHRvIHJldmll
dyB3aGF0J3MgZ29pbmcgb24gaGVyZS4gSXQgbWF5DQphbHNvIG1ha2Ugc2Vuc2UgdG8gYWRkIHRo
ZSBjb21wYXRpYmxlIGZvciB0aGUgcDU1MCBjYWNoZSB3aGlsZSB3ZSBhcmUNCmF0IGl0Li4uDQoN
CkZZSSwgdGhlcmUgaXMgYWxzbyB0aGlzIHBhdGNoIGhlcmUgb3V0c3RhbmRpbmcgYWdhaW5zdCB0
aGUgbDI6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIyMDgyNTE4MDQx
Ny4xMjU5MzYwLTItbWFpbEBjb25jaHVvZC5pZS8NCg0KSSBpbnRlbmQgdGFraW5nIHRoaXMgaW50
byA2LjAtcmM1IG9yIHNvIGFzIGEgZml4LCBzbyBpZiB5b3UgY291bGQNCnJlYmFzZSB0aGUgc2Vy
aWVzIG9uIHRoYXQgc28gaXQgaXMgbm90IGxvc3QgaW4gdGhlIGR0LWJpbmRpbmcgcmVuYW1lDQp0
aGF0IHdvdWxkIGJlIGdyZWF0Lg0KDQpUaGFua3MsDQpDb25vci4NCg==
