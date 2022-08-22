Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC6959C952
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiHVTzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiHVTz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:55:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ABE40565;
        Mon, 22 Aug 2022 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661198126; x=1692734126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N+HszR+OR4dY3BqIZa/4qX629uZiZlnOrlEdCNLVnKI=;
  b=ioEBYnhhfsoFTTT/VwI0rAqoW75qOunEixbrbHC2eTwM58TNR9wgxY2Q
   80dxl17qYG8pMsm7xNn9pHGT9tmlXA7nwqUmmVvGu9v/0mz70k2YtMPPs
   WY/HQ5oKOYGvFltWaUS4tHW23qXoOxGm09PCC26ZgoT/h326EE1NW+LNM
   qubyyvW9/N5Av0N2Bogxvnrr9tOiWvBgMwyNmu6mLjGhuOPUcdGF6/5CM
   P5+DgQcelwmuDemnHrawtB8dkWzeYWFG5F3gauCgVhzBCwkxO4YzEiP4D
   CzWypxe/4gFpt489xEev7G09SwoNu0vfQMnBoQnFL5GIm/yK4W8nVAgeT
   g==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="187584186"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2022 12:55:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 22 Aug 2022 12:55:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 22 Aug 2022 12:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbT92yykLhrelQEAkvVpaZN1LBrFnJJMNCE2OdHPHG/SfLaZ34vl0jYsHy9M1gdEZyqKeQZOp5tt7keVlyMu/Pi8YhGiCdY6h7gUpMQWtrfEOrsQXJb8Ab3d83ve2XJF+GQDiEVS7C3xaknqDzUY3R1/fo6FuVQeaGuPQAS99ORm0bY9qWYTStw5X9ZqJt83Oncsl37IO8zSqM68ETGxlQYEARfncTzSGzxEwc7PV7LjbM8b6XooMamXbV+nqpR3kE94Na8gzaNkD+rNZJfxW1rpDQdHolCKIdXc4C7ekKu+Rg2sqOuCCYEm/h72DSx0m0MKvBrryCaXbDNWNABT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+HszR+OR4dY3BqIZa/4qX629uZiZlnOrlEdCNLVnKI=;
 b=BfgNKppuGvT6MEKKDqiZOLv4yG5jW1W+VosXv4YuWj2P2RqSr+HoDLfrs20i2IceR49R4ejoq0MfUTQjiF8cZXlnx5AeVRQalLTUMqJAAEWrlaCqd/VMQ6sQeBI19jeqLHdMi7Q1SuZhJx2HU7mF2Bqb+GDiZXdINaOYdufjx007afgP1Z86sUm6ldtklMMXgCG9gd6LbY4LlNBH3ftlioHbrNS5eq2Li9k+oInbC9HRCAcheYR5v/aXLVhVLaNhtpGfeQoUgzfYPK4lrgGurvO0b8ZjVX7CVgtZBVyzexVvO9Wu/yzswV+ib00zYYRQhkr6nYhU35aYSCQXBf3h0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+HszR+OR4dY3BqIZa/4qX629uZiZlnOrlEdCNLVnKI=;
 b=MxkO+xJAb4Oanje/Ps1v61qA+ZslY8TEBmN3Dg8Ezr6CnteoZqK/I6jODbRbXF5AJgaoNEDHPGwSpHXJ8Vd/Tl672XmqxwgzG8UspCQLy0ptgkh1cFH6Euu5E8inrAQY6WQJ/fJJp8AnmyktydRoAuauAH9tEcInC3ZZ1Kea+xs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3589.namprd11.prod.outlook.com (2603:10b6:a03:b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 19:55:20 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 19:55:20 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <jsarha@ti.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: gpio-gate-clock: Convert to
 json-schema
Thread-Topic: [PATCH] dt-bindings: clock: gpio-gate-clock: Convert to
 json-schema
Thread-Index: AQHYobqRL3nsopPr1Ei35aMlOpLPuq27fsGA
Date:   Mon, 22 Aug 2022 19:55:20 +0000
Message-ID: <12cfc1b3-4b52-8801-0892-264bd5dc45f1@microchip.com>
References: <20220727131015.2073100-1-conor.dooley@microchip.com>
In-Reply-To: <20220727131015.2073100-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c198c9e-34c0-43e4-8b9d-08da84783e43
x-ms-traffictypediagnostic: BYAPR11MB3589:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMiSzW6L79LjfTa2aGwx9p0gxbb4FROsf6pqgoaV2OLZ6VSQnj5SYqdEOT7C42I+AL8GQ8A6Js5N5o/+Jtr0yrxaCEbxiO9RF0odCqkqVWSEeLGoM4UzP4pgyYp2SO8GFLzybYHFct9Vv6KeEmK9yVPmyZvIUOWWm/HBj/5LhQyJBI+aPrB2cNq59bCc00Hr4C3gkTajvfL3OD4hj+40FwrorETxcpMydiCypE49e13J/kQnhY2eNuUG2E7afPmx3MstKxbsYFHbFmnglr+hUN6hjCDBqau5gWIx15wGAwEleP3M9kMaf8iBU+xLN4BZjkAUH31D0xLyEQ+jaNXF1z7YshYsdyH8NywgkDgu/TFe7zN6TQeg0P61glQfwlVgkKHq2vA3SKT2syofvAn2b93/42klSg4ikZ4g76fFDqksJVPzlxs/dNNG62q1j47vGeo2rXN+pRUaDoW0RgVeYtSWvkoXsnVpG8LeKM3ZCJHA2TP4vCiL8Fg+xH87nc6bg4pTzquQT5+VtROlKcLSIFqsZaILPEEtwq5mGjG7aPiMF8xtSA3y0PYnUi1jWH/4LHTIB30eJ1JclzwqUQ+plA+ZthisrtGiCUT85T0hARWzP9f+rcGTLHm1PIJIsAshksCBdCWj5Nj1RXGlDXn4RbgAsCM54C3c1sIPJTfKnjW9rKGpsD0OAPc1FszpiNNq/4L0vkfvKTxm3BOQj5M/8M3BGPcNxG/YrvCHEThSiJ1zO/kK8KKlzHRN5UkFPlSAXFVSNybKUBoSfh+B/LCXGyI0eYEtixB3hYshvn5Pcynbamxhkp2PapcO6JgZwrF/PXcvWPPCWbcuVooZ0vD2UHwa9Q0mkc/3eLJcQfIWG00FYWEU/mj9ICstR+UKTwfkZ06gZxJ3ZxY74mcv6rbUgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(136003)(346002)(376002)(186003)(31686004)(31696002)(2616005)(83380400001)(6512007)(53546011)(26005)(122000001)(38100700002)(66446008)(5660300002)(6506007)(66476007)(64756008)(8936002)(8676002)(66946007)(4326008)(76116006)(66556008)(2906002)(86362001)(478600001)(966005)(41300700001)(91956017)(316002)(36756003)(38070700005)(6486002)(54906003)(71200400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlBFMXFoS3pLWUdsOS9UVHBtaVB2Zjc4eUgzV1BXOTdldFBBVkFWdWVua3Nj?=
 =?utf-8?B?eFF1NmI2eVFNUjB1cU50OXNwVTlkUjdSWDdJNDZrR0pGMnVQc3M5cjJSQ3I0?=
 =?utf-8?B?RWFZM042UHNlSXhuYzB4RjdUUnNKUmY2bmZwR1d2ZjRPazUvQTZzSUI3NGpr?=
 =?utf-8?B?N29OaWUwZnJCVGNEck95MG1KNWNDOHRoNGFyL2cxL2crRVlFWjlDZmZVbEU2?=
 =?utf-8?B?bjlHWmltNjVILzJ0WXc2MG1lNUxmRXVBZDY2Y1VwZFZYM1hSS1FlbVFobzJp?=
 =?utf-8?B?VUU2NWh1ZlVheEZKQjNoYlN5aTlNZmlEbUk4Q1NMYjVQSFAzdDRBR3hJclZV?=
 =?utf-8?B?ay9MNEF1MVFxWWRYOGpHTzY5N05FY1l3VUt5UmxPb3dreVp6TzAwTnFaVHRO?=
 =?utf-8?B?SHpza05lNlhEb28wdGJ1eFhaTmx1ZlZtWUd4c0tINldBVkZmNDlxbFd0bG5y?=
 =?utf-8?B?c1kyOUdMRVNhK1orVkhaZnNONGpmVThjajU1a1pvaXZydHRpVVRrUis3SHVi?=
 =?utf-8?B?VmQwdmxLSnU0NlZDT0tiZkR1Z1BTSFpIYWJvNXFxamdkSWNTUFhEZWpCcTJY?=
 =?utf-8?B?dFhjZEN2VXRsQVg4SEZpVFFsanpWM0Z6RzVveFZvSnhqM0dzWHZvSi90MU0z?=
 =?utf-8?B?cDUvdWFHQ29LS3AwL1EvcURqK3lCM3NBbmRURzRwTkFHSXYxWlN5NjVsTVUr?=
 =?utf-8?B?c3JuazkrTUpXL2dCVUVFQ21qNlpFT2pvdGFVZk1BNGJyRlhMaThFRUNaVkpy?=
 =?utf-8?B?c2ZzMlZ3K05DU01XTVZzWTFmS2ZCTHNDWHRJbkVjRVFxcGNURmFRTS83b1ZD?=
 =?utf-8?B?Nm0vTkUwcnYyTHgvaTdPT2xGTUdDaVZhaUpGMzhuU3o3ZUswczI4THNMUTk3?=
 =?utf-8?B?YVJmREg0MFYxWGFCR09pTndFU2Vva1FVM3lrdnQzVmlRbGNadWl6UVhEakhS?=
 =?utf-8?B?UnU5c0YxUWZPT2tCaFZ1bXp3WkxmelRTZzg2Vyt5VlNuYktWMUJNY0cvNVl0?=
 =?utf-8?B?dDUyUE42QlFZbWhvMjRXTDNJZXNndWpDTXRQSi9OSjI3SFM2U2ZEckFBaUY0?=
 =?utf-8?B?ZWdnbnMwQkJNSlJPbEU1WktwQm5sVWtPT2VlcVlFQSs1a3c3OEtrMDFrQW9F?=
 =?utf-8?B?OUVIdmlLcTNKT3VZcS8rTG84empRQWdDTjFpNko3U0RFVlRSQWM0UmppSzll?=
 =?utf-8?B?RXg4S2dBUFY3aVV1SmpOanUvZUhlZ2ErSnlOSjh6bGlvQUUyVHkwTnU2SG1V?=
 =?utf-8?B?cE0wTGJLVHAvMHpJODVhUndYeDUzQ3orTGRsYW1RTnVMVnJRRWNndkZiRlF0?=
 =?utf-8?B?bUFzdEJ5SHBSbFJqVjJjMjBqSjh3MFpYSVY4WjF6NFlaT1VOcTZFK2ZIMnQz?=
 =?utf-8?B?V3E5dHBLUFFrSFk3d1dsVHliM1RIREZaZVhBWTBDNDJsZ2VWTVlzQlphbndX?=
 =?utf-8?B?emc0Y2lQU1F5N2IvSkNqaUlDa1poM3Q3dHF4blJTS1hnZnpmeFMzbTlmblBD?=
 =?utf-8?B?d29LclpaV2xSQ2NaYi90VmwzNVdQZ0Nad2h6bG9ob2dTZ1BXMzkyZUYzdWR2?=
 =?utf-8?B?Y0loNXVrZk5LTDlKOXB6N3R0R29ESTRyZjhVa1JBZzVsY21pQ0NpMzJuWEor?=
 =?utf-8?B?MlVXRmtvTTlKV0VpT0NaZTFHZ0M0SmVVQUYyQ2RFS1kvY3plNUNoTDJONDQ3?=
 =?utf-8?B?cU1zb0drSmpaYS9Ea3A0OTJ0T0l3VnAzQ0lDcVA1VEVXV1FzajRxSko0akJC?=
 =?utf-8?B?OGNPcjhSS28vU2lxeWVvcDBxNzNicnhyemhOUmczMUk3QTlWK0kwZ2ljTm90?=
 =?utf-8?B?UHdpTkZKTTNiMk5xT1FiZXR0YzNNdS9tczVyU3ZZZmljRlZwaFJicFl2REpO?=
 =?utf-8?B?anNVcTNGcnh4TDdoOHoxUXUwVFRPTk5ZSzdCSEx5QXB5OHlCZ3Q3dnRseGtx?=
 =?utf-8?B?UldOSnJTRlRpNlJIa0FpR252Kzd5VHh0TjE5aDhyNUpvNXkzWUsveko3RGUz?=
 =?utf-8?B?Uzc2eEFoYWxteGpHZHRoaXY1SjJXL2hBUC82VmJtblZwa2JiZTc5OGNMeGRo?=
 =?utf-8?B?Y29CTUdMV0xTUmRJeFViOG9BMkVsVmNOVHhFV25vTWVUcC9Gb1ZPTTk1SDRU?=
 =?utf-8?B?VnhKZWY1b2UwQ0VHTUY1NVkwcHpNWlV2N1lJcklhek9xRkhWM01zRDc3V1FJ?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D88D7DFA92575D4F9B1244F23F6660C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c198c9e-34c0-43e4-8b9d-08da84783e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 19:55:20.1590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHJpHaq31o/hwjnS8YoGf2aaTxBrGaHzINtIw6kFVLMAwlnqU0EQcMpWc3WkfHFA2FJYINXP2+9/HL1IEI/qJqNYOOz6nH0OUdLiiX5rzWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3589
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDcvMjAyMiAxNDoxMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KDQpIZXkgU3RlcGhlbiwN
Ckp1c3QgYSB3ZWUgYnVtcCBvbiB0aGlzIGNvbnZlcnNpb24uDQpUaGFua3MsDQpDb25vci4NCg0K
PiBDb252ZXJ0IHRoZSBzaW1wbGUgR1BJTyBjbG9jayBnYXRlIERldmljZSBUcmVlIGJpbmRpbmcg
dG8ganNvbi1zY2hlbWENCj4gYW5kIGZpeC11cCByZWZlcmVuY2VzIHRvIHRoaXMgZmlsZSBpbiBv
dGhlciB0ZXh0IGZvcm1hdCBiaW5kaW5ncy4NCj4gSnlyaSBTYXJoYSBpcyB0aGUgZmlsZSdzIG9u
bHkgZWRpdG9yL2F1dGhvciBzbyB0aGV5IGhhdmUgYmVlbiBhZGRlZCBhcw0KPiBtYWludGFpbmVy
IG9mIHRoZSBuZXcgeWFtbCBiaW5kaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9v
bGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+IFRoZSBvcmlnaW5hbCBm
aWxlIGRvZXMgbm90IHNwZWNpZml5IGR1YWwgbGljZW5zaW5nLCBidXQgd2hlbiBHZWVydCBkaWQN
Cj4gdGhlIGdwaW8tbXV4LWNsb2NrIGNvbnZlcnNpb24gdGhlIHlhbWwgYmluZGluZyB3YXMgY3Jl
YXRlZCB3aXRoIGR1YWwsDQo+IHNvIEkgaGF2ZSBkb25lIHRoZSBzYW1lIHRoaW5nIGhlcmUuDQo+
IC0tLQ0KPiAgLi4uL2JpbmRpbmdzL2Nsb2NrL2dwaW8tZ2F0ZS1jbG9jay50eHQgICAgICAgIHwg
MjEgLS0tLS0tLS0tLQ0KPiAgLi4uL2JpbmRpbmdzL2Nsb2NrL2dwaW8tZ2F0ZS1jbG9jay55YW1s
ICAgICAgIHwgNDIgKysrKysrKysrKysrKysrKysrKw0KPiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvY2xvY2svdGkvZ2F0ZS50eHQgICAgIHwgIDIgKy0NCj4gIC4uLi9iaW5kaW5ncy9jbG9jay90
aS9pbnRlcmZhY2UudHh0ICAgICAgICAgICB8ICAyICstDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDQ0
IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9ncGlvLWdhdGUtY2xvY2sudHh0
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Nsb2NrL2dwaW8tZ2F0ZS1jbG9jay55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dwaW8tZ2F0ZS1jbG9jay50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svZ3Bpby1nYXRlLWNsb2NrLnR4dA0K
PiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggZDMzNzlmZjliODRiLi4wMDAwMDAw
MDAwMDANCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dw
aW8tZ2F0ZS1jbG9jay50eHQNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSwyMSArMCwwIEBADQo+
IC1CaW5kaW5nIGZvciBzaW1wbGUgZ3BpbyBnYXRlZCBjbG9jay4NCj4gLQ0KPiAtVGhpcyBiaW5k
aW5nIHVzZXMgdGhlIGNvbW1vbiBjbG9jayBiaW5kaW5nWzFdLg0KPiAtDQo+IC1bMV0gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2Nsb2NrLWJpbmRpbmdzLnR4dA0KPiAt
DQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtLSBjb21wYXRpYmxlIDogc2hhbGwgYmUgImdw
aW8tZ2F0ZS1jbG9jayIuDQo+IC0tICNjbG9jay1jZWxscyA6IGZyb20gY29tbW9uIGNsb2NrIGJp
bmRpbmc7IHNoYWxsIGJlIHNldCB0byAwLg0KPiAtLSBlbmFibGUtZ3Bpb3MgOiBHUElPIHJlZmVy
ZW5jZSBmb3IgZW5hYmxpbmcgYW5kIGRpc2FibGluZyB0aGUgY2xvY2suDQo+IC0NCj4gLU9wdGlv
bmFsIHByb3BlcnRpZXM6DQo+IC0tIGNsb2NrczogTWF4aW11bSBvZiBvbmUgcGFyZW50IGNsb2Nr
IGlzIHN1cHBvcnRlZC4NCj4gLQ0KPiAtRXhhbXBsZToNCj4gLQljbG9jayB7DQo+IC0JCWNvbXBh
dGlibGUgPSAiZ3Bpby1nYXRlLWNsb2NrIjsNCj4gLQkJY2xvY2tzID0gPCZwYXJlbnRjbGs+Ow0K
PiAtCQkjY2xvY2stY2VsbHMgPSA8MD47DQo+IC0JCWVuYWJsZS1ncGlvcyA9IDwmZ3BpbyAxIEdQ
SU9fQUNUSVZFX0hJR0g+Ow0KPiAtCX07DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY2xvY2svZ3Bpby1nYXRlLWNsb2NrLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svZ3Bpby1nYXRlLWNsb2NrLnlhbWwNCj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kMDlkMGUzZjBjNmUNCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
Y2xvY2svZ3Bpby1nYXRlLWNsb2NrLnlhbWwNCj4gQEAgLTAsMCArMSw0MiBAQA0KPiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ICsl
WUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9j
bG9jay9ncGlvLWdhdGUtY2xvY2sueWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0aXRsZTogU2ltcGxlIEdQSU8g
Y2xvY2sgZ2F0ZQ0KPiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBKeXJpIFNhcmhhIDxqc2Fy
aGFAdGkuY29tPg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAg
IGNvbnN0OiBncGlvLWdhdGUtY2xvY2sNCj4gKw0KPiArICBjbG9ja3M6DQo+ICsgICAgbWF4SXRl
bXM6IDENCj4gKw0KPiArICAnI2Nsb2NrLWNlbGxzJzoNCj4gKyAgICBjb25zdDogMA0KPiArDQo+
ICsgIGVuYWJsZS1ncGlvczoNCj4gKyAgICBkZXNjcmlwdGlvbjogR1BJTyByZWZlcmVuY2UgZm9y
IGVuYWJsaW5nIGFuZCBkaXNhYmxpbmcgdGhlIGNsb2NrLg0KPiArICAgIG1heEl0ZW1zOiAxDQo+
ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSAnI2Nsb2NrLWNlbGxz
Jw0KPiArICAtIGVuYWJsZS1ncGlvcw0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9ncGlvL2dwaW8uaD4NCj4gKw0KPiArICAgIGNsb2NrIHsNCj4gKyAgICAgICAgY29tcGF0
aWJsZSA9ICJncGlvLWdhdGUtY2xvY2siOw0KPiArICAgICAgICBjbG9ja3MgPSA8JnBhcmVudGNs
az47DQo+ICsgICAgICAgICNjbG9jay1jZWxscyA9IDwwPjsNCj4gKyAgICAgICAgZW5hYmxlLWdw
aW9zID0gPCZncGlvIDEgR1BJT19BQ1RJVkVfSElHSD47DQo+ICsgICAgfTsNCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay90aS9nYXRlLnR4dCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay90aS9nYXRlLnR4dA0KPiBp
bmRleCBiNDgyMGIxZGU0ZjAuLjQ5ODI2MTVjMDFiOSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3RpL2dhdGUudHh0DQo+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay90aS9nYXRlLnR4dA0KPiBAQCAtMTAs
NyArMTAsNyBAQCB3aWxsIGJlIGNvbnRyb2xsZWQgaW5zdGVhZCBhbmQgdGhlIGNvcnJlc3BvbmRp
bmcgaHctb3BzIGZvcg0KPiAgdGhhdCBpcyB1c2VkLg0KPiAgDQo+ICBbMV0gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2Nsb2NrLWJpbmRpbmdzLnR4dA0KPiAtWzJdIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9ncGlvLWdhdGUtY2xvY2sudHh0
DQo+ICtbMl0gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dwaW8tZ2F0
ZS1jbG9jay55YW1sDQo+ICBbM10gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Ns
b2NrL3RpL2Nsb2NrZG9tYWluLnR4dA0KPiAgDQo+ICBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3RpL2lu
dGVyZmFjZS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svdGkv
aW50ZXJmYWNlLnR4dA0KPiBpbmRleCA5NGVjNzdkYzNjNTkuLmQzZWI1Y2E5MmE3ZiAxMDA2NDQN
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3RpL2ludGVy
ZmFjZS50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2Nr
L3RpL2ludGVyZmFjZS50eHQNCj4gQEAgLTksNyArOSw3IEBAIGNvbXBhbmlvbiBjbG9jayBmaW5k
aW5nIChtYXRjaCBjb3JyZXNwb25kaW5nIGZ1bmN0aW9uYWwgZ2F0ZQ0KPiAgY2xvY2spIGFuZCBo
YXJkd2FyZSBhdXRvaWRsZSBlbmFibGUgLyBkaXNhYmxlLg0KPiAgDQo+ICBbMV0gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2Nsb2NrLWJpbmRpbmdzLnR4dA0KPiAtWzJd
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9ncGlvLWdhdGUtY2xvY2su
dHh0DQo+ICtbMl0gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2dwaW8t
Z2F0ZS1jbG9jay55YW1sDQo+ICANCj4gIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAtIGNvbXBh
dGlibGUgOiBzaGFsbCBiZSBvbmUgb2Y6DQo=
