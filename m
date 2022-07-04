Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EDA565AB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiGDQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiGDQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:12:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D2A47D;
        Mon,  4 Jul 2022 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656951160; x=1688487160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ninbEw12HUSaj4cjHe+R7+l16ojjRHwWBaLplSmhPQI=;
  b=h5na/+QQwm0qd1vsxnXrpyimx7Ics/i/H+3kSP0FdV5sAO6/MUOSJxQu
   vwnzVKqmemT9rGgSxtrr90M08lFzGhvZeAgA0ADVZXv2kv6phO3qWN/eV
   xANrfbptQT58I90U3/61kfjiHI8Pyn84ziULJC5JybLZQqivVaCbFLXyI
   ZxQTSFlvY2eC5aDy/17Bw2+bxf4nzuD9w5vNaP9aMZlqigNC16dvC1DJ8
   y5LscIlrA1UWCtY/wPuwtwdq8bWdOGcImcpPtbNkZTQgXwL37OPhc47d+
   tRF0yp8D2j5yhoNVVdQI/SRg0iBKUjaYAnRsz34KT47qOe07Vw+iuS4At
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="163237478"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 09:12:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 09:12:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 4 Jul 2022 09:12:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLMQk/j1rVVmTSKFh+4BtU2ae9BbFW2cbWW/0RG2fGpdE7Mu8iHuf3qxJLyz/aDf9t4ilhUUzeEwFDJyv9MzrwWWj2zRx3Ju01UoIfYZirUt8C/aVup/oaB9/dcJGcYmXtTi+qozMgV5Urlm1nCM/TEbZ4D7EHgMwYL5y9izKB8n7hiOjcUP1bFGLRgKy7iiM51RkYEA8quc3zv5VlEkn1+jdnzc/XW4ig80Bb8drzwAjrytIBwHPcY/pCoAx8p3nY8/v5hajkemdj8lZli2Rrw0qVJHn78FwmzU79Gsoq5t+IiZyL855B9BnQNn3Hf+GMIMANjODLzwPqcm8v3EhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ninbEw12HUSaj4cjHe+R7+l16ojjRHwWBaLplSmhPQI=;
 b=CjqFaQJ497drMBb/gbobdXWSFjSryDhDvm4mhzfEkGnU7Z0Lk0Y0DTTxhodjAIF631J3gsBGIEuD0WgdVwcQngy5ohOZTF9WaL99UG0Q58HN85GMXNQeH7suooy1y8ePnvNGH4FMwRq7R1tnC7ffDQZcX+WkHSBm8kJ3H7Slu1XoNQfP1BaZKeIzeZj52WfpRNubUb+SjV2BbUVNLZYEo8WQ/wlA14qZ5im/MYc4Rfn2qfW+TmVUXWfJSbxYU5uFljeQoa3rKXTdAeO05Hq4gxEOCpowgUKrenybpUydXFPew4idXNZSE5Z5A+8RJgelaGRXFq6ZIvKqeeFCu8FbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ninbEw12HUSaj4cjHe+R7+l16ojjRHwWBaLplSmhPQI=;
 b=lYZRNBZQNshcwJdm423on37nGIJN8uPuijbTOv0suxriNDZyW+tHg+2SlU7SVpIvRAk/SDpbebbKd53CfvZrVs6D25Yh+YMl9qgRELsPfIg+K73dsEChDY12SpKDgeFH0EbQ/H5FTLNcM/NuLevZsg/8vofBY+bW57WbrTJ4ayk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:12:24 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:12:23 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@dabbelt.com>, <palmer@rivosinc.com>
CC:     <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-riscv@lists.infradead.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <paul.walmsley@sifive.com>,
        <devicetree@vger.kernel.org>, <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] riscv: dts: align gpio-key node names with dtschema
Thread-Topic: [PATCH] riscv: dts: align gpio-key node names with dtschema
Thread-Index: AQHYh+0TSEsUfCu3dUCW8EahvV7Amq1ucdaA
Date:   Mon, 4 Jul 2022 16:12:23 +0000
Message-ID: <f10994df-5cf3-98d0-fc6a-b8f10414974e@microchip.com>
References: <20220624170811.66395-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624170811.66395-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb35de7d-5d82-4a3d-6c3b-08da5dd7fb1d
x-ms-traffictypediagnostic: MN0PR11MB5962:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Djoxj5TfnN3LT1LKbFMu7NNovn6NpS4ul98F3gsCskxm2G1hDxPtjGLTzVoRUX0GYVDlUwo/4JvTJnhNVJkBz0p4VWwJh0xAfLhykslsb2yRShXZJ3Ivwc3MQGzwZpXAMAHhNcaoU9/7pliL4ZKj9JNK3tNWGzs0rYP6MroZLox0LgAPGa9B+lEa1gxHhRUY+ZFoPvZIqhgLANYeuwJ968dDYlP2U0F8oCoYjg9gw6dHIqdFKQH/qkTd1xr42JY1ETAumIFwqxE0X4tw/Hc6au4jXjakGPl8hqydMGcy882sC/c0SlO022y3oxc/shxkD04wOtVPApTvuUGwBLc6blHRwaN0YJY9nzFQ536VbwAfaIktgOq1lbxgVaN9rC1+HjZ2WcyodW99l0tGC2PwN+H+ydITtrq+WgcHWUCBYxmwI4Y5g9gvTA4X8SyzD2UOd3bwc0AODZoETjNCTvUMQ8rTYj2AQqR+S6RzkYwli894IjeoKX1BMtumXgvREAI0D6zlrGT8vjISVbNohSAYQSs/i65EOCT58PRJ9xEpb7hGepH0DFwa8SifJjPgqmoP9y/pt2oUY5H5cg69ddKjQjF0gMU6Y3BL+6ZGrr7EaiJ09NcDu2u8qEYhMqFS2hi1HxyTb06ZN3P1JRFClJWj0OJcp0L0ZNMYI64j/BKpE5eJ/RWUcdh/xmhecNkOhR3p/vu508tj8wQu2zKmFee5u34nAGoSELypRRAAzg7kdVBkRR60A/uX1pTjsgGFB0D+pZMQKrZUhTG678paoPMGHW1F++lLe4DRH0IjpT75UEpJJrNjZHK2h8fl+N4CGg+EeBEKq79V2jBXhZxtFEsOliER5e+ZE7sgR0h8AqB5DONZX3O2Qy+okiQYjWkMC46XyVUseeAyB6wFABZBiLZ3YnBx2CDcMuG6j7dnh43x+nOedf12kWCpIo9qzTogap89
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(376002)(136003)(396003)(6512007)(26005)(6506007)(86362001)(2616005)(122000001)(966005)(53546011)(66556008)(8936002)(7416002)(5660300002)(41300700001)(478600001)(6486002)(8676002)(38070700005)(64756008)(186003)(83380400001)(31696002)(38100700002)(31686004)(91956017)(36756003)(66446008)(71200400001)(110136005)(316002)(66476007)(4326008)(76116006)(2906002)(66946007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VThOS3pkQ1lZS0JOTFp6T2dKOUFGeXpQMDJsY2c2WFVqaHZsa2xLY2JEV3Fm?=
 =?utf-8?B?OGhJUWtvbzhQTTFkWTRQTzBqK2I1Vi93ZUwvaXFaYmRXT3JzdFRYUThzMytH?=
 =?utf-8?B?RXhhQ1JyOHBObFZRbTdKQzgvSSsvK21yVWNNbGRVY3NEZzdsMysrQ1JPczNy?=
 =?utf-8?B?QXBvNWtmbDNWNlVGbzhOY2ozLzJpUU1kL2Jnb3loNnNwY3ZJZ0htelZMTWdO?=
 =?utf-8?B?ZjJSZlFuMVczSTMxd29rRHVLdEJEeFFka2w2TTBHUnNtcmkrK3JsRHIzdXhF?=
 =?utf-8?B?cEVUWXNpUVFLL2FvRWdKaGEvRWFWU2VsK1pGN0hqd0paN1hRU3JrTDdNN1do?=
 =?utf-8?B?dGVUdkY4aFVieUFXdEJRWnVJelJYeVpES2pUSGlXRTJtQk43M0hwOHZkd3NI?=
 =?utf-8?B?UEtDcDhSMmtRbjA2dnJlYXZVQW91dTFhNHdYVDhsNmdQK1VFcmdPU3dPYXRM?=
 =?utf-8?B?NmZYWitNYlNVR1hFblU0cWswMzlyMk9HNndqRXFRWnFqMVFnTTBMVDlCUDla?=
 =?utf-8?B?Z0dqTXV2UDhKa2ZtMldpTHg3QTg0ZjFqMWcwdnVxWXp0QStwL0hRNG5xTDBR?=
 =?utf-8?B?RWY0OFdQamlmTHIza01yUFAvL3dGZENDWTZUVnFXdE1xcC9EVTdUbUVzN0k1?=
 =?utf-8?B?UVlzSXQvbGpYbldHRFFhS1o4TjNkOVRnaGpwU09vcmcyNWRwbHNpa2xOVUFs?=
 =?utf-8?B?RG9JdFFnNnZrUHBrS0NwNDFOVkhyamdFOWxxZ0t3TWJKRzlXVGIxR0V2cXVT?=
 =?utf-8?B?UVFwL2JvaWNXL0Z6cUlsTFpucXIvUkl6TUFxYzIzSVJScWc3Q3ZkSlh3SWFp?=
 =?utf-8?B?NWM1YlJ1b2R6eGhBQlJGalpPVS81WWMvbTFWdjJGejdOMFdjcm5KbWlheGcx?=
 =?utf-8?B?NmdaVWpqbG5LemN0S2FUZzVmdnJSRDlpUEM5Uy9sUGJMN0RKaVF5OEhGUDJG?=
 =?utf-8?B?UXJuaUtLeERUSXlISWtLVmdSRGR5Q3NlOXh4d0pYV3A4dW5NUDk4Mk5kanZK?=
 =?utf-8?B?UUpFYjhYdlFYREFYV0NmQkJvT1NNUVNFN1BVTVVSNW4vaGJmS2tRcVpEejMv?=
 =?utf-8?B?czlQdVUwV1ZNbDdzU3NvSGJNb2p1OTA3dTdPZXF0Y2pVL3RqeHVxTFVZWkR6?=
 =?utf-8?B?bktGd2FzNlcyNmh0ZmZrSVdnRStCRFlrUUlGcVp2aHlTZ2lSQisweWdHalBW?=
 =?utf-8?B?VzY1V3FCMk5UdUF2WHBETWlkWkxsTFlpM0JEZ3BCb0VPeFJUaVNrVi9tZ2gy?=
 =?utf-8?B?S215bnlXSTZUS3ZtZmc1eDlZUHNuT0F1dHFSQkhhOW9GUUMwVVZmZCtWYTJI?=
 =?utf-8?B?Si9UZ21aSlo1T3hXMmdPdXpBczZSUUdlVzVLbWc0bFk5RTZIMmJaR0x2aEps?=
 =?utf-8?B?UFhEUzBybzhMUlJHRmY5Vm5OeWJqUGt5M0F1MHJsVVNVRVg1amkzZ0pYRVRH?=
 =?utf-8?B?dDhTcmJtNm9xcG8rRkI2T0trRW1DSlMxN25FTGQ2Y0Y0SXBwWFAxdkowZnV2?=
 =?utf-8?B?cmE1bEZuS3FjL3dNQjhOUHRKNjZqM2FhdzBhTFVFOFBJaHlXYnpCNGRGWS9n?=
 =?utf-8?B?c1ZVTlo4dlRIUnU2WWVrb3U0Mm1ydEE2OFpteGdqUHAwR1cwTEJndS9nVzJY?=
 =?utf-8?B?QXBiSEQ2UUNHSEF4VnhvZFppVmxXVDlSTEtzd2dqNkx5ZjdUbndSNi9HVUdr?=
 =?utf-8?B?VTFHbjdxbE91c0daS2NzenVCOWNyRzkyZ25ZNkJ1WXhJRHgybERBcVpYbWFT?=
 =?utf-8?B?eFp5d3lrYnZnREtKYUhtcEQ1QmxyMkJySXFTbTkzcENRdjRMc29UcHN3ak0v?=
 =?utf-8?B?THM4TmFhcWZic3Jjb3J6enJ3cWpEWlJXK05iQkNtMzB5ZzIvcFhxZUw3NjZL?=
 =?utf-8?B?RGpTNllCSXVwRlg0b0lVck4rRnA1bG1BWjZUWWVEYzNjS0hsaGtxdnVXS1h3?=
 =?utf-8?B?NlY4Q2RYcGZMMXIvQ3hnS1M4dlJ4ano5SUJ3bTRjbWhvRGpLZ1ZrOW1wZkZT?=
 =?utf-8?B?akdjNzBXdGloSU1JVkk3cGR3QTlHSzhvYU1Wc2lLS1VKNzZTdUhyOEZwSXVD?=
 =?utf-8?B?SnRVV2FOcE45K2xXRjl4Q2tkRG8vZHlweEllVnR3SFl6dit2b2dMWXpmdnEv?=
 =?utf-8?Q?sfqUTmczqojnF+W9kjH0uxh8w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3306FE34C65AB4BA68C2A30E1BE372B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb35de7d-5d82-4a3d-6c3b-08da5dd7fb1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 16:12:23.8551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fl5usxO3dFKHPJW6nTZy9DFwlGvOtan1O3u5w9OpHbbQj7yHEov+WOnJVtWYKAjp7vZ2IXNOrqdabAgeGQZRhWgOVfe86sLAtZ1vsorZ3NA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFBhbG1lciwNCk5vdCBteSBwYXRjaCB0byBidW1wLCBidXQgc2luY2UgSSB3YXMgYnVtcGlu
ZyBvdGhlciBEVFMgcmVsYXRlZCBwYXRjaGVzLA0KZmVsdCBpdCBtYWRlIHNlbnNlIHRvIGJ1bXAg
dGhpcyBwYXRjaCB0b28uDQpUaGFua3MsDQpDb25vci4NCg0KT24gMjQvMDYvMjAyMiAxODowOCwg
S3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+IA0KPiBUaGUgbm9kZSBuYW1lcyBzaG91bGQgYmUgZ2VuZXJpYyBhbmQgRFQgc2No
ZW1hIGV4cGVjdHMgY2VydGFpbiBwYXR0ZXJuDQo+IChlLmcuIHdpdGgga2V5L2J1dHRvbi9zd2l0
Y2gpLj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5r
b3psb3dza2lAbGluYXJvLm9yZz4NCj4gDQo+IC0tLQ0KPiANCj4gU2VlOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMjA2MTYwMDUyMjQuMTgzOTEtMS1rcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmcvDQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9jYW5hYW4vY2FuYWFu
X2tkMjMzLmR0cyAgICAgfCAyICstDQo+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9zaXBl
ZWRfbWFpeF9iaXQuZHRzICB8IDIgKy0NCj4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3Np
cGVlZF9tYWl4X2RvY2suZHRzIHwgMiArLQ0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9jYW5hYW4v
c2lwZWVkX21haXhfZ28uZHRzICAgfCA2ICsrKy0tLQ0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9j
YW5hYW4vc2lwZWVkX21haXhkdWluby5kdHMgfCAyICstDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jp
c2N2L2Jvb3QvZHRzL2NhbmFhbi9jYW5hYW5fa2QyMzMuZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0
cy9jYW5hYW4vY2FuYWFuX2tkMjMzLmR0cw0KPiBpbmRleCAwMzliOTJhYmYwNDYuLmY3MjU0MGJk
MTRhMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9jYW5hYW4vY2FuYWFuX2tk
MjMzLmR0cw0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9jYW5hYW5fa2QyMzMu
ZHRzDQo+IEBAIC0zNSw3ICszNSw3IEBAIGxlZDEgew0KPiAgICAgICAgIGdwaW8ta2V5cyB7DQo+
ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImdwaW8ta2V5cyI7DQo+IA0KPiAtICAgICAg
ICAgICAgICAga2V5MCB7DQo+ICsgICAgICAgICAgICAgICBrZXkgew0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBsYWJlbCA9ICJLRVkwIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbGlu
dXgsY29kZSA9IDxCVE5fMD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdwaW9zID0gPCZn
cGlvMCAxMCBHUElPX0FDVElWRV9MT1c+Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290
L2R0cy9jYW5hYW4vc2lwZWVkX21haXhfYml0LmR0cyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2Fu
YWFuL3NpcGVlZF9tYWl4X2JpdC5kdHMNCj4gaW5kZXggYjllMzBkZjEyN2ZlLi44YWJkYmUyNmEx
ZDAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4
X2JpdC5kdHMNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9jYW5hYW4vc2lwZWVkX21haXhf
Yml0LmR0cw0KPiBAQCAtNDcsNyArNDcsNyBAQCBsZWQyIHsNCj4gICAgICAgICBncGlvLWtleXMg
ew0KPiAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJncGlvLWtleXMiOw0KPiANCj4gLSAg
ICAgICAgICAgICAgIGJvb3Qgew0KPiArICAgICAgICAgICAgICAga2V5LWJvb3Qgew0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJCT09UIjsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgbGludXgsY29kZSA9IDxCVE5fMD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdw
aW9zID0gPCZncGlvMCAwIEdQSU9fQUNUSVZFX0xPVz47DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jp
c2N2L2Jvb3QvZHRzL2NhbmFhbi9zaXBlZWRfbWFpeF9kb2NrLmR0cyBiL2FyY2gvcmlzY3YvYm9v
dC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4X2RvY2suZHRzDQo+IGluZGV4IDhkMjM0MDFiMGJiYi4u
M2M2ZGYxZWNmNzZmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9z
aXBlZWRfbWFpeF9kb2NrLmR0cw0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9z
aXBlZWRfbWFpeF9kb2NrLmR0cw0KPiBAQCAtNTIsNyArNTIsNyBAQCBsZWQyIHsNCj4gICAgICAg
ICBncGlvLWtleXMgew0KPiAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJncGlvLWtleXMi
Ow0KPiANCj4gLSAgICAgICAgICAgICAgIGJvb3Qgew0KPiArICAgICAgICAgICAgICAga2V5LWJv
b3Qgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJCT09UIjsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgbGludXgsY29kZSA9IDxCVE5fMD47DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGdwaW9zID0gPCZncGlvMCAwIEdQSU9fQUNUSVZFX0xPVz47DQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9zaXBlZWRfbWFpeF9nby5kdHMgYi9hcmNo
L3Jpc2N2L2Jvb3QvZHRzL2NhbmFhbi9zaXBlZWRfbWFpeF9nby5kdHMNCj4gaW5kZXggMjRmZDgz
YjQzZDlkLi4wM2M5ODQzZDUwM2UgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMv
Y2FuYWFuL3NpcGVlZF9tYWl4X2dvLmR0cw0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL2Nh
bmFhbi9zaXBlZWRfbWFpeF9nby5kdHMNCj4gQEAgLTQ2LDE5ICs0NiwxOSBAQCBsZWQyIHsNCj4g
ICAgICAgICBncGlvLWtleXMgew0KPiAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJncGlv
LWtleXMiOw0KPiANCj4gLSAgICAgICAgICAgICAgIHVwIHsNCj4gKyAgICAgICAgICAgICAgIGtl
eS11cCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGxhYmVsID0gIlVQIjsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgbGludXgsY29kZSA9IDxCVE5fMT47DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGdwaW9zID0gPCZncGlvMV8wIDcgR1BJT19BQ1RJVkVfTE9XPjsNCj4gICAgICAg
ICAgICAgICAgIH07DQo+IA0KPiAtICAgICAgICAgICAgICAgcHJlc3Mgew0KPiArICAgICAgICAg
ICAgICAga2V5LXByZXNzIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAiUFJF
U1MiOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBsaW51eCxjb2RlID0gPEJUTl8wPjsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgZ3Bpb3MgPSA8JmdwaW8wIDAgR1BJT19BQ1RJVkVfTE9X
PjsNCj4gICAgICAgICAgICAgICAgIH07DQo+IA0KPiAtICAgICAgICAgICAgICAgZG93biB7DQo+
ICsgICAgICAgICAgICAgICBrZXktZG93biB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGxh
YmVsID0gIkRPV04iOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBsaW51eCxjb2RlID0gPEJU
Tl8yPjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ3Bpb3MgPSA8JmdwaW8wIDEgR1BJT19B
Q1RJVkVfTE9XPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3Np
cGVlZF9tYWl4ZHVpbm8uZHRzIGIvYXJjaC9yaXNjdi9ib290L2R0cy9jYW5hYW4vc2lwZWVkX21h
aXhkdWluby5kdHMNCj4gaW5kZXggMjUzNDFmMzgyOTJhLi43MTY0YWQwNjMxNzggMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4ZHVpbm8uZHRzDQo+
ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvY2FuYWFuL3NpcGVlZF9tYWl4ZHVpbm8uZHRzDQo+
IEBAIC0yMyw3ICsyMyw3IEBAIGNob3NlbiB7DQo+ICAgICAgICAgZ3Bpby1rZXlzIHsNCj4gICAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsNCj4gDQo+IC0gICAgICAgICAg
ICAgICBib290IHsNCj4gKyAgICAgICAgICAgICAgIGtleS1ib290IHsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgbGFiZWwgPSAiQk9PVCI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGxp
bnV4LGNvZGUgPSA8QlROXzA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICBncGlvcyA9IDwm
Z3BpbzAgMCBHUElPX0FDVElWRV9MT1c+Ow0KPiAtLQ0KPiAyLjM0LjENCj4gDQo+IA0KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1yaXNj
diBtYWlsaW5nIGxpc3QNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2DQoNCg==
