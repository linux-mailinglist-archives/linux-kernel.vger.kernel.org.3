Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DBF5997CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347239AbiHSIic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbiHSIhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:37:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C8D422FE;
        Fri, 19 Aug 2022 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660898253; x=1692434253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t79yE4KPtwc4nBXF9YERZOAwZbFWATRndph8DVg8cw0=;
  b=CAkO6uNrr62pVMiES0HVkmUK2/2QBDeeG1Hsd2b5pp8nylpMFbMV4apl
   JIj7a1JbsJUhDNohqfJccsyBPj9JzHmcIk8JXZ9bzwLtJjnlYl2+Db22c
   c8iG0x22g9hNngwBeopRT1lPUFcytfjENlxcRYJjdnfVhXvzV1v/tPLtD
   9XPXs4oOCElILBOTpA9UI7cf+B5GmevUweGma1dEdpDpBk1l87cpAC3Jy
   i+RTBzIZhbEHNuJJUzYxZYKYGJG7Z1FP+WoStj4VaYUTEFTyVwwKrmYrp
   /L1zUMagks4t/oTUhu+ulK6A4Z3BekSdpKXMKbF8ea4HNHNxnDX4iKepB
   w==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="187169038"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 01:37:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 01:37:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 01:37:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn1Ds2EpDL3bnOulcawhpdvYqZks3nUGNsOb6qTeIKU4ihE4AsuQ30wLrPg1z0/R8ZN5dhu+JVaKVmcrFTs5PlNzlJYJMca+Jhyss5U3R72xG4OfxwY4tGLZfFEE9tJ4lxHDVYStzt2AgUR3d6C+hzxIGbsSyKeovBEb0e73Z8ARlUp3l9zv8bnz/DvzaHF5nZ3N+hcP0zHBNgQKcCvyp9pzjhNFpnDOAc0F9eyoZV/5r3O1+LrRFkpmiD49XJS8p7m7NaO2aQ9UdHhu8vKFY4PW5+ueFc+hcoyenOclPuzuo9MqwY7tGBVUq6t4T9in4ZnjDMiPSFVJ4RWfOd9vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t79yE4KPtwc4nBXF9YERZOAwZbFWATRndph8DVg8cw0=;
 b=Ul7l3WRyp1q0ag6zukoPdbs2g+u5Wcs1cdKYtOqi3YgCUt3AHX6tmZNLU3E6YXS14fk3RvtiYx4Vqx39UM3nzKBn6kigN/Kb5NI5It+wvSBBfOqEyJeMmqnJlwAQV1gFXqsZwhif5l3rr/CLSiiYtoSZdmYHBCv55UtdpTC+v1lxJ5JcNSuN0KsX4FsNJh1csrZ0I9jAzZmAcVTX0bSxs09q7vQVULeRwR2iy2Bdkq8xRfGJ7y11Hi0pCyuh6knEzQuGyzpaQdslljVOSU+QEfYmmCVDpJin9GdpRnRFFeGPjnMZeHCjnr8S1qQoUkRzr9zfQkVW6mkh4gdSxjMp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t79yE4KPtwc4nBXF9YERZOAwZbFWATRndph8DVg8cw0=;
 b=pqpn+0amLx2kEix/ihg6YIVlBAuD///A2FbYzExtPuioe7BykdIPmUYZrzX/v+5ub6UU8yTenUy/7uMmYRvnCp5Qm8pp2MNvJG5tTo4qp19VMM8iDJFR+D8EIhu1u28uvZ09V12ZTWc1GC29cEj3a3Ou8R9bYTNHujD6GxEWq/U=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by DM6PR11MB3354.namprd11.prod.outlook.com (2603:10b6:5:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Fri, 19 Aug 2022 08:37:19 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 08:37:18 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <radu_nicolae.pirea@upb.ro>,
        <richard.genoud@gmail.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Topic: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Thread-Index: AQHYsg/cwUZrhBU4AEegbceOuhne8K20V5eAgAGSEoA=
Date:   Fri, 19 Aug 2022 08:37:18 +0000
Message-ID: <5fd68d8e-7132-2f58-0ef9-cd4a0fe45127@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <c1a98a3e-609e-7783-b1b7-3bb39caa8c65@linaro.org>
In-Reply-To: <c1a98a3e-609e-7783-b1b7-3bb39caa8c65@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d824da75-2a2e-4616-5ea1-08da81be0712
x-ms-traffictypediagnostic: DM6PR11MB3354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OkPrwRwRLhnE9riJdVllu3HKZSEILbLIp04O/LPVECGoxnReDqujuCtWu5Eyk2HxGY6tz8RWP1Zu2c95LkO0JrC0i3A9xjgzD56MgUW1/tStxBeomVxKlT7FZCRjFhY9Nw5cFL1YKs3DX3IvtgMBJKSUOy6uASKAsz9NryMduCm28R6Mg5PLBpqGC2vd3mJbzNe6v4u3qmqAbQ8UXL7PicW4+9lIco2cCcGJFpuEBkveNWpAl9bUW/5iVYv1JgSlCl3Mw1z85UMsBcbo29KZvQZUe3inDkhaL7uyDoSif4cT+KtU3M71r/S2ERO998xJNuXnzph6FyCHBNG4uNhOyWBp3Mr35hckhpHlIOLiSfNaopPZhRfZep10lBHAHW0AaQppWZPm986MhDKRnIdjTfKevHOyav0adkBsJQV74XQ2SLpYxOZq0uDsFHeLtihxFjKiQjfS/sqEaSF7crJ2vY0qbT8abu2nwmmdaa2lb0SoK/PDKJyoToHNwfWmTPGwZ4fQIGzfavSf3LSNXs3zmjgTEjnyX9ge7C+k2s9dzHo0cxpUhLi1ks30mvbGxDRH1IfOv7y1FMux8z7OwbM4aqS4qJ7IuFcZDyhjMGxrhRKDZN1JExMezdc2INQu06TFvBXRIEPHpBQBIyv2dZ1FlVua3SUv5+tK3ULVBjQfgos1/31LcuzTVNc50hB9maeSUsPOuiHTtpIfAiJT3a7APZVZEJydeWlXkKiHlwwVgEZCE8SFZaL3zec3ZF+35L552ZCLNEfX2UZLNyeGxd33Wl3EaZ7EE4pBpGdoyoGElQn/+zXDdDpX4fmfET3LAdsxi7KSOdyR27g6TooWYVUvmGe/Ym6MUvx6y4SDgWo2cgu0Ol3FI6pBlKIYK3somi1A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(376002)(136003)(396003)(36756003)(86362001)(2906002)(31696002)(316002)(38100700002)(6636002)(71200400001)(110136005)(31686004)(54906003)(122000001)(91956017)(26005)(4326008)(186003)(66946007)(5660300002)(8676002)(6486002)(66446008)(6506007)(53546011)(966005)(6512007)(76116006)(66476007)(2616005)(7416002)(64756008)(921005)(66556008)(83380400001)(38070700005)(478600001)(41300700001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUlad2tVVVRSa0Y4YUVmcnRTSis4dS9NL0dqV0g1TnQ3dDBGUEtyRGRCbW80?=
 =?utf-8?B?ZGptUGNpSXJlSjF4bFg0cHc0UWpnY2NxUlF4eU1PZjBYenAybk9ZdGMyem95?=
 =?utf-8?B?ejZLYjlOMFZ6OGNmTG1NUFhrc1ljQlZ2TmhiN0loY2FISXNXVk40YTdDdmhn?=
 =?utf-8?B?cVdiZ3NBb3lCZlBBT0xXMW4vQ3dqMEFFaWwwK0JaM2UyWkJuOEQvdFBxMmxE?=
 =?utf-8?B?ODg0ZnhBOUVSRmVSTUNBN3ZjbGNjdmZhYUZSeHhETHdySFFId2phVndPTGJ2?=
 =?utf-8?B?eWVuTEhTdjdaYTJNTzhUT0xEVG1xZmFSQ1F1UzFzcU50TUdEV1N0Q3RCaW5m?=
 =?utf-8?B?V0VINXh2MmpzUWVyRTU3VXVkUzJocVJxWXh5aXl4MW14b3JiRE9pTWs0MXY3?=
 =?utf-8?B?WG5PeVlwc1JnWWF1UnUvNDI2Tnk0OEF6Zmp5LzlWd0RSUi81L3hNU0NOM0tN?=
 =?utf-8?B?MXhnYTQ2WHQ5eVFJQ0NGN2tnUmRFL3dvSndxbUZtQ2JmSkw3SXpSQTNDMUVD?=
 =?utf-8?B?b0hDUEc4cUFDZEg0UU5zYm14bjZ0YVoxdmVMc0xMQk84Si9kK3ZnemZIbzlG?=
 =?utf-8?B?QTllMTFiaUlvVldzNkVqTWtNVlYwc2dzdVNORjMrODljdXovY05SWkV6UHlt?=
 =?utf-8?B?TmhHOG5FZ2hkYmhzNTcyQUhGOWxFblFvamNWR0JKamJsNTN0M1pDb3V2Skxh?=
 =?utf-8?B?Q1A0VEpaUk0xWDRmbU40cmZ5VUdRS2F6cG9IaXU3dGxDSDBaZUtKQVNOTVRF?=
 =?utf-8?B?Y1BpakpuVmYzeGdCbGp4VEpyazJlZzFpblBORXhVaFdUU2xTcVdtU1N1ZmxN?=
 =?utf-8?B?MTVqMWxpVHlVbmZDVGFkMUJMckFBR3NJbTVLaVo0VkRYZVhDaDEvbERoUzZR?=
 =?utf-8?B?aFNyVTJxMnRxMmw5a1dVbVBWVDg0Y3NFMHROVy9WUDFTd0IyTzhPemlGVW5a?=
 =?utf-8?B?NWkxSHI3RVVxa3NkVGtNYnE5NnkvTFJnNkJOY2xpRmcrUHJDQWk1QndFOGIw?=
 =?utf-8?B?dmxqejJsTDl1azAyMEJ0dElBa0p3WjNKa3NjR0tGYlI2ZG9DcFFCbCtvaG9Q?=
 =?utf-8?B?MkRFbWM1alZsMzQrWCtKVzRWaFFsMElBdVRUNC9CTW1XRGp6eWM4cFlZZW9y?=
 =?utf-8?B?WkJwQWlkTGRTdndxdHRMck5ubnROVTRZUnczSUxZNFlrb2Zld1UxdERzcDJu?=
 =?utf-8?B?eGpNSkI1TVNqN2YzR3hsalpxR0ZubksrZXZRQ0VQVVNBbHRXL093UGRXTGtw?=
 =?utf-8?B?UVp0MGtYLzRKRjQ3cjNDR1hIUEU1QjFCbmxieEhGYmNJZUFSbWVkT1RCNjhn?=
 =?utf-8?B?NU53NjN3cVQveERxSVRRU0FhR2o5SWxld1U2S1dMb1Fxd3dQNCs2amhwUXha?=
 =?utf-8?B?bjR5WVRPT2N0M1EvWlp5aGZCcXVLRWtrWm1zL1pNbGd1Rjh5akUzU0FDYkdE?=
 =?utf-8?B?a1Vjd1E5RklISU9FUDBNL0p3bldYNU1YQmp3a25qcHM0ZWMyYW5RS095ZmFD?=
 =?utf-8?B?bC9Cb0kxRmZxVmNpQzNLb2N0LzZGY29JVmlVN2x3WFRPYWJIWTVBTUQ1djVC?=
 =?utf-8?B?S0lneXZXYVZ1WTZkb3hlQkQvYVpFVGxFcVlOQ0hhdjRNY0NjQk45bGtlRk1K?=
 =?utf-8?B?c3UwUTYvL2ppc0huVEVhL1IvcWFEemFqVkZsc3JvTGh1Z3dGNVFlVUFpc0ZD?=
 =?utf-8?B?MUJncnRoRU9aR2FEd3VTSGY2MlJoYmZ1WXBDYmVVMkFOVlJNL0VoMTFQUnBT?=
 =?utf-8?B?VEZUU20vNWx3d3R1ZS9EeGxwMWhHcXpuN2ZnV2VXUE83QklXKzcxMHNUdXNL?=
 =?utf-8?B?bWRmWDZKSGh2MkJSb25MWkpLQjNKa1NtbkdhT2c2a25HTndxbWFWcnBJYThQ?=
 =?utf-8?B?TlF4MzNmSjBpWG1ieXp5TG1zdE1KMzM2VFdMUUxSOUZBb2w2M3NaZGFPcHgw?=
 =?utf-8?B?b3cwTzhVYUk0OU5nQU9YL0t1clhhclFoNFhZNVVhSlozeFg5eDBSU1pESHlG?=
 =?utf-8?B?cDZGdEVRN0l5d3dlajlVeWRxOWF1MGhTVml0NzBGZUp1T09QTVZaRVI5WmxM?=
 =?utf-8?B?Tm9yQWI1R3JLZnpGVnJJd2VOWXk2UDMzZlIrRlFSQnVKc1VmYkd1TVZMakxU?=
 =?utf-8?Q?JEFpOmodLeLU/hNXuyJbeKaz4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81F8927C6A3D5040B9E9255D0448F8E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d824da75-2a2e-4616-5ea1-08da81be0712
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 08:37:18.8603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uraBoe0yPcwgJGIBctrtOpSrK6EnqMqA1luV79Qmnecay1abukFFxndIWMZDb/kntScPO+UImZHgMUEQ27o854plypnOs16Ha+40QvooWq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3354
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTguMDguMjAyMiAxMTozOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IE9uIDE3LzA4LzIwMjIgMTA6NTUsIFNl
cmdpdSBNb2dhIHdyb3RlOg0KPj4gQ29udmVydCBhdDkxIFVTQVJUIERUIEJpbmRpbmcgZm9yIEF0
bWVsL01pY3JvY2hpcCBTb0NzIHRvDQo+PiBqc29uLXNjaGVtYSBmb3JtYXQuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+PiAt
LS0NCj4+ICAgLi4uL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwgICAgICAgIHwg
MTkwICsrKysrKysrKysrKysrKysrKw0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQv
YXRtZWwtdXNhcnQudHh0ICAgfCAgOTggLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwg
MTkwIGluc2VydGlvbnMoKyksIDk4IGRlbGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0
LnlhbWwNCj4+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQudHh0DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsYXQ5MS11c2FydC55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwN
Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmNmMTVkNzNm
YTFlOA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4+IEBAIC0wLDAgKzEsMTkwIEBA
DQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1D
bGF1c2UpDQo+PiArIyBDb3B5cmlnaHQgKEMpIDIwMjIgTWljcm9jaGlwIFRlY2hub2xvZ3ksIElu
Yy4gYW5kIGl0cyBzdWJzaWRpYXJpZXMNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6
IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21mZC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwj
DQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwjDQo+PiArDQo+PiArdGl0bGU6IEF0bWVsIFVuaXZlcnNhbCBTeW5jaHJvbm91cyBBc3luY2hy
b25vdXMgUmVjZWl2ZXIvVHJhbnNtaXR0ZXIgKFVTQVJUKQ0KPj4gKw0KPj4gK21haW50YWluZXJz
Og0KPj4gKyAgLSBSaWNoYXJkIEdlbm91ZCA8cmljaGFyZC5nZW5vdWRAZ21haWwuY29tPg0KPj4g
Kw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBvbmVPZjoNCj4g
VGhpcyBsb29rcyBxdWl0ZSBkaWZmZXJlbnQgdGhhbiBiaW5kaW5ncyBhbmQgeW91IGNvbW1pdCBt
c2cgaXMgc2F5aW5nIGl0DQo+IGlzIG9ubHkgYSBjb252ZXJzaW9uLiBNZW50aW9uIGFueSBjaGFu
Z2VzIGFnYWluc3Qgb3JpZ2luYWwgYmluZGluZ3MuDQoNCg0KTm90ZWQuIFdpbGwgbWFrZSB0aGUg
Y29tbWl0IG1lc3NhZ2UgbW9yZSBkZXNjcmlwdGl2ZSB0byBhbHNvIGluY2x1ZGUgdGhlIA0KbmV3
IGNvbXBhdGlibGVzLsKgIFBlcmhhcHMgdGhlIGFkZGl0aW9uIG9mIHRoZSBHQ0xLIHNob3VsZCBj
b21lIHVuZGVyIGEgDQpkaWZmZXJlbnQgcGF0Y2ggYXMgd2VsbC4NCg0KDQo+PiArICAgICAgLSBj
b25zdDogYXRtZWwsYXQ5MXJtOTIwMC11c2FydA0KPj4gKyAgICAgIC0gY29uc3Q6IGF0bWVsLGF0
OTFzYW05MjYwLXVzYXJ0DQo+PiArICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtdXNh
cnQNCj4gVGhhdCdzIGFuIGVudW0NCj4NCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAg
ICAtIGNvbnN0OiBhdG1lbCxhdDkxcm05MjAwLWRiZ3UNCj4+ICsgICAgICAgICAgLSBjb25zdDog
YXRtZWwsYXQ5MXJtOTIwMC11c2FydA0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAg
IC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLWRiZ3UNCj4+ICsgICAgICAgICAgLSBjb25zdDog
YXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAg
ICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MC1kYmd1DQo+PiArICAgICAgICAgIC0gY29uc3Q6
IG1pY3JvY2hpcCxzYW05eDYwLXVzYXJ0DQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAg
ICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtdXNhcnQNCj4+ICsgICAgICAgICAgLSBjb25z
dDogYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQNCj4gVGhpcyBpcyBub3QgY29ycmVjdCAtIGNvbnRy
YWRpY3RzIGVhcmxpZXIgb25lLg0KPg0KDQpZZXMsIHRoaXMgd2FzIGZvciBhIERUIG5vZGUgd2Ug
aGF2ZSBpbnRlcm5hbGx5LCBteSBiYWQuIFlvdSBhcmUgcmlnaHQsIA0KaXQgZG9lcyBub3QgcmVh
bGx5IG1ha2Ugc2Vuc2UgYW5kIGl0IHNob3VsZCBub3QgYmUgdGhlIG90aGVyIHdheSBhcm91bmQ6
IA0KaGF2aW5nIHRoZSBEVCB2YWxpZGF0ZSB0aGUgYmluZGluZy4gSSB3aWxsIHJlbW92ZSB0aGlz
IGNvbWJpbmF0aW9uIGluIA0KdGhlIG5leHQgdmVyc2lvbi4NCg0KDQo+PiArICAgICAgLSBpdGVt
czoNCj4+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtZGJndQ0KPj4gKyAg
ICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MC11c2FydA0KPj4gKyAgICAgICAgICAt
IGNvbnN0OiBhdG1lbCxhdDkxc2FtOTI2MC1kYmd1DQo+PiArICAgICAgICAgIC0gY29uc3Q6IGF0
bWVsLGF0OTFzYW05MjYwLXVzYXJ0DQo+IFdoYXQ/IFlvdSB3cm90ZSBhYm92ZSB0aGF0IG1pY3Jv
Y2hpcCxzYW05eDYwLWRiZ3UgaXMgY29tcGF0aWJsZSBvbmx5DQo+IHdpdGggbWljcm9jaGlwLHNh
bTl4NjAtdXNhcnQuIE5vdyB5b3Ugd3JpdGUgaXQgaXMgYWxzbyBjb21wYXRpYmxlIHdpdGgNCj4g
b3RoZXIgb25lcz8NCg0KDQpZZXMsIHRoaXMgb25lIGlzIGludGVuZGVkIGJlY2F1c2UgdGhlIDl4
NjAgSVAgaGFzIG5ldyBmdW5jdGlvbmFsaXRpZXMgb24gDQp0b3Agb2YgOTI2MCwgYW5kIHNvbWUg
bm9kZXMgZG8ga2VlcCBhbGwgZm91ciBhcyBmYWxsYmFjay4NCg0KDQo+PiArDQo+PiArICByZWc6
DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBpbnRlcnJ1cHRzOg0KPj4gKyAgICBt
YXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgY2xvY2stbmFtZXM6DQo+PiArICAgIGNvbnRhaW5zOg0K
Pj4gKyAgICAgIGNvbnN0OiB1c2FydA0KPiBObywgdGhpcyBoYXMgdG8gYmUgc3BlY2lmaWMvZml4
ZWQgbGlzdC4NCg0KDQpJIHdhbnRlZCB0byBoaWdobGlnaHQgdGhlIGZhY3QgdGhhdCBpdCBtdXN0
IGNvbnRhaW4gZWl0aGVyOg0KY2xvY2stbmFtZXMgPSAidXNhcnQiOw0Kb3INCmNsb2NrLW5hbWVz
ID0gInVzYXJ0IiwgImdjbGsiOw0KDQpXaGF0IHdvdWxkIGJlIHRoZSByZWNvbW1lbmRlZCB3YXkg
b2YgZG9pbmcgdGhpcyB0aGVuPw0KDQo+PiArDQo+PiArICBjbG9ja3M6DQo+PiArICAgIG1pbkl0
ZW1zOiAxDQo+PiArICAgIG1heEl0ZW1zOiAyDQo+IE5vdCByZWFsbHkgLSBkZWZpbmUgdGhlIGl0
ZW1zLiBPbmUgaXRlbSBjb3VsZCBiZSBvcHRpb25hbCwgdGhvdWdoLg0KPg0KPj4gKw0KPj4gKyAg
ZG1hczoNCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBkZXNjcmlwdGlvbjogVFggRE1BIENo
YW5uZWwNCj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBSWCBETUEgQ2hhbm5lbA0KPj4gKw0KPj4g
KyAgZG1hLW5hbWVzOg0KPj4gKyAgICBpdGVtczoNCj4+ICsgICAgICAtIGNvbnN0OiB0eA0KPj4g
KyAgICAgIC0gY29uc3Q6IHJ4DQo+PiArDQo+PiArICBhdG1lbCx1c2FydC1tb2RlOg0KPj4gKyAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4+ICsgICAg
ZGVzY3JpcHRpb246IHwNCj4gTm8gbmVlZCBmb3IgfA0KPg0KPj4gKyAgICAgIE11c3QgYmUgZWl0
aGVyIDEgZm9yIFNQSSBvciAwIGZvciBVU0FSVC4NCj4gTWVudGlvbiB0aGUgaGVhZGVyLg0KPg0K
Pj4gKyAgICBlbnVtOiBbIDAsIDEgXQ0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21w
YXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKyAgLSBpbnRlcnJ1cHRzDQo+PiArICAtIGNsb2NrLW5h
bWVzDQo+PiArICAtIGNsb2Nrcw0KPj4gKw0KPj4gK2lmOg0KPiBQdXQgaXQgdW5kZXIgYWxsT2Yu
DQo+DQo+PiArICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAkbm9kZW5hbWU6DQo+PiArICAgICAgcGF0
dGVybjogIl5zZXJpYWxAWzAtOWEtZl0rJCINCj4+ICt0aGVuOg0KPj4gKyAgYWxsT2Y6DQo+PiAr
ICAgIC0gJHJlZjogL3NjaGVtYXMvc2VyaWFsL3NlcmlhbC55YW1sIw0KPj4gKyAgICAtICRyZWY6
IC9zY2hlbWFzL3NlcmlhbC9yczQ4NS55YW1sIw0KPj4gKw0KPj4gKyAgcHJvcGVydGllczoNCj4+
ICsgICAgYXRtZWwsdXNlLWRtYS1yeDoNCj4+ICsgICAgICB0eXBlOiBib29sZWFuDQo+PiArICAg
ICAgZGVzY3JpcHRpb246IHVzZSBvZiBQREMgb3IgRE1BIGZvciByZWNlaXZpbmcgZGF0YQ0KPj4g
Kw0KPj4gKyAgICBhdG1lbCx1c2UtZG1hLXR4Og0KPj4gKyAgICAgIHR5cGU6IGJvb2xlYW4NCj4+
ICsgICAgICBkZXNjcmlwdGlvbjogdXNlIG9mIFBEQyBvciBETUEgZm9yIHRyYW5zbWl0dGluZyBk
YXRhDQo+PiArDQo+PiArICAgIGF0bWVsLGZpZm8tc2l6ZToNCj4+ICsgICAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4+ICsgICAgICBkZXNjcmlwdGlv
bjogfA0KPiBObyBuZWVkIGZvciB8DQo+DQo+PiArICAgICAgICBNYXhpbXVtIG51bWJlciBvZiBk
YXRhIHRoZSBSWCBhbmQgVFggRklGT3MgY2FuIHN0b3JlIGZvciBGSUZPDQo+PiArICAgICAgICBj
YXBhYmxlIFVTQVJUUy4NCj4+ICsgICAgICBlbnVtOiBbIDE2LCAzMiBdDQo+PiArDQo+PiArZWxz
ZToNCj4+ICsgIGlmOg0KPj4gKyAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICRub2RlbmFtZToN
Cj4+ICsgICAgICAgIHBhdHRlcm46ICJec3BpQFswLTlhLWZdKyQiDQo+PiArICB0aGVuOg0KPj4g
KyAgICBhbGxPZjoNCj4+ICsgICAgICAtICRyZWY6IC9zY2hlbWFzL3NwaS9zcGktY29udHJvbGxl
ci55YW1sIw0KPj4gKw0KPj4gKyAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgIGF0bWVsLHVzYXJ0
LW1vZGU6DQo+PiArICAgICAgICBjb25zdDogMQ0KPj4gKw0KPj4gKyAgICAgICIjc2l6ZS1jZWxs
cyI6DQo+PiArICAgICAgICBjb25zdDogMA0KPj4gKw0KPj4gKyAgICAgICIjYWRkcmVzcy1jZWxs
cyI6DQo+PiArICAgICAgICBjb25zdDogMQ0KPj4gKw0KPj4gKyAgICByZXF1aXJlZDoNCj4+ICsg
ICAgICAtIGF0bWVsLHVzYXJ0LW1vZGUNCj4+ICsgICAgICAtICIjc2l6ZS1jZWxscyINCj4+ICsg
ICAgICAtICIjYWRkcmVzcy1jZWxscyINCj4+ICsNCj4+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6
IGZhbHNlDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAgI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
aW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9tZmQvYXQ5MS11c2FydC5oPg0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZG1hL2F0
OTEuaD4NCj4+ICsNCj4+ICsgICAgLyogdXNlIFBEQyAqLw0KPj4gKyAgICB1c2FydDA6IHNlcmlh
bEBmZmY4YzAwMCB7DQo+PiArICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05MjYw
LXVzYXJ0IjsNCj4+ICsgICAgICAgIHJlZyA9IDwweGZmZjhjMDAwIDB4NDAwMD47DQo+PiArICAg
ICAgICBpbnRlcnJ1cHRzID0gPDc+Ow0KPj4gKyAgICAgICAgY2xvY2tzID0gPCZ1c2FydDBfY2xr
PjsNCj4+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gInVzYXJ0IjsNCj4+ICsgICAgICAgIGF0bWVs
LHVzZS1kbWEtcng7DQo+PiArICAgICAgICBhdG1lbCx1c2UtZG1hLXR4Ow0KPj4gKyAgICAgICAg
cnRzLWdwaW9zID0gPCZwaW9EIDE1IEdQSU9fQUNUSVZFX0xPVz47DQo+PiArICAgICAgICBjdHMt
Z3Bpb3MgPSA8JnBpb0QgMTYgR1BJT19BQ1RJVkVfTE9XPjsNCj4+ICsgICAgICAgIGR0ci1ncGlv
cyA9IDwmcGlvRCAxNyBHUElPX0FDVElWRV9MT1c+Ow0KPj4gKyAgICAgICAgZHNyLWdwaW9zID0g
PCZwaW9EIDE4IEdQSU9fQUNUSVZFX0xPVz47DQo+PiArICAgICAgICBkY2QtZ3Bpb3MgPSA8JnBp
b0QgMjAgR1BJT19BQ1RJVkVfTE9XPjsNCj4+ICsgICAgICAgIHJuZy1ncGlvcyA9IDwmcGlvRCAx
OSBHUElPX0FDVElWRV9MT1c+Ow0KPj4gKyAgICB9Ow0KPj4gKw0KPj4gKyAgLSB8DQo+PiArICAg
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4+ICsgICAgI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPj4gKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvbWZkL2F0OTEtdXNhcnQuaD4NCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL2RtYS9hdDkxLmg+DQo+PiArDQo+PiArICAgIC8qIHVzZSBETUEgKi8NCj4+ICsgICAgdXNh
cnQxOiBzZXJpYWxAZjAwMWMwMDAgew0KPj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxh
dDkxc2FtOTI2MC11c2FydCI7DQo+PiArICAgICAgICByZWcgPSA8MHhmMDAxYzAwMCAweDEwMD47
DQo+PiArICAgICAgICBpbnRlcnJ1cHRzID0gPDEyIElSUV9UWVBFX0xFVkVMX0hJR0ggNT47DQo+
PiArICAgICAgICBjbG9ja3MgPSA8JnVzYXJ0MF9jbGs+Ow0KPj4gKyAgICAgICAgY2xvY2stbmFt
ZXMgPSAidXNhcnQiOw0KPj4gKyAgICAgICAgYXRtZWwsdXNlLWRtYS1yeDsNCj4+ICsgICAgICAg
IGF0bWVsLHVzZS1kbWEtdHg7DQo+PiArICAgICAgICBkbWFzID0gPCZkbWEwIDIgQVQ5MV9ETUFf
Q0ZHX1BFUl9JRCgzKT4sDQo+PiArICAgICAgICAgICAgICAgPCZkbWEwIDIgKEFUOTFfRE1BX0NG
R19QRVJfSUQoNCkgfCBBVDkxX0RNQV9DRkdfRklGT0NGR19BU0FQKT47DQo+PiArICAgICAgICBk
bWEtbmFtZXMgPSAidHgiLCAicngiOw0KPj4gKyAgICAgICAgYXRtZWwsZmlmby1zaXplID0gPDMy
PjsNCj4+ICsgICAgfTsNCj4+ICsNCj4+ICsgIC0gfA0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvZ3Bpby9ncGlvLmg+DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1
cHQtY29udHJvbGxlci9pcnEuaD4NCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL21mZC9h
dDkxLXVzYXJ0Lmg+DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9kbWEvYXQ5MS5oPg0K
Pj4gKw0KPj4gKyAgICAvKiBTUEkgbW9kZSAqLw0KPj4gKyAgICBzcGkwOiBzcGlAZjAwMWMwMDAg
ew0KPj4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArICAgICAgICAjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAt
dXNhcnQiOw0KPj4gKyAgICAgICAgYXRtZWwsdXNhcnQtbW9kZSA9IDxBVDkxX1VTQVJUX01PREVf
U1BJPjsNCj4+ICsgICAgICAgIHJlZyA9IDwweGYwMDFjMDAwIDB4MTAwPjsNCj4gY29tcGF0aWJs
ZSwgdGhlbiByZWcgdGhlbiB0aGUgcmVzZXQgb2YgcHJvcGVydGllcw0KPg0KPj4gKyAgICAgICAg
aW50ZXJydXB0cyA9IDwxMiBJUlFfVFlQRV9MRVZFTF9ISUdIIDU+Ow0KPj4gKyAgICAgICAgY2xv
Y2tzID0gPCZ1c2FydDBfY2xrPjsNCj4+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gInVzYXJ0IjsN
Cj4+ICsgICAgICAgIGRtYXMgPSA8JmRtYTAgMiBBVDkxX0RNQV9DRkdfUEVSX0lEKDMpPiwNCj4+
ICsgICAgICAgICAgICAgICA8JmRtYTAgMiAoQVQ5MV9ETUFfQ0ZHX1BFUl9JRCg0KSB8IEFUOTFf
RE1BX0NGR19GSUZPQ0ZHX0FTQVApPjsNCj4+ICsgICAgICAgIGRtYS1uYW1lcyA9ICJ0eCIsICJy
eCI7DQo+PiArICAgICAgICBjcy1ncGlvcyA9IDwmcGlvQiAzIEdQSU9fQUNUSVZFX0hJR0g+Ow0K
Pj4gKyAgICB9Ow0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQoNClJlZ2FyZHMsDQog
wqDCoMKgIFNlcmdpdQ0KDQo=
