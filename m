Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDFA54DE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376516AbiFPJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiFPJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:20:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1DC56F82;
        Thu, 16 Jun 2022 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655371227; x=1686907227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GyPHxjH6wStJJ8/qBj9WvgLkFGf6ucSY+z0I8ZRjhmg=;
  b=vyelb4b4uNyt07xUzowSu4RFRSnzXOgHHd1qTBzgNfiW09Wl9BdwNJ33
   Q27ixQuSnoftSZazZsyY5mocWm6g+5EK9gb8TxILSl0q9LOxinauoBMbZ
   h1GeBq3fElRBN+8tGNmHeqdlDvsttr9TJFhkDP+zFWcrlPjT+aWHjxD3b
   5M4pfVNA7Ue1e4DSNH+2NJ/34eBtqmxTEmsjbegk+VCAzM9cf3IE9mL8g
   QGmdZv+HmqDBqHwkTHdrwVwtCJ2eFWDqwYsuoW1qodhM6B2lJR0+t+8yY
   kRXDK5/R8cA/P8FLClhQtrBjgI0C5aOyMgiAXdvdNqan6GJ88LgsuYWvr
   A==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="178206357"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2022 02:20:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Jun 2022 02:20:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 16 Jun 2022 02:20:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3MAlXL6RDWYxiW6Vt06kDCFa+0jO3iYwo6z/P5xOLck2Nykv4PWiAzBUzyLXnYCGtntjBZtvO65Uxq8ptYumKbgNJW8xTiV/ZsYMsUT0oCD0aI8LpRqPQvr4troCecy9/x+6+m8xiC2z0oju+m/Jj+hq0qSR3emYfDjc4YRJg3oa1vyleXeEmmnapQuewxMw1g6oYz/8wmNf3Xrz8RcHwbHCIiVCUlzRn/W5uac52NGa6I6+9o+bd+06+CzQ19DQQ6qy9Pt9/8yUZIZgMsj/FhitRx3rTDOrWANgUZAbBWLkMzkEyVWYe2vVtzEQDDaAE3SjTWsUyWTGK1xUTnVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyPHxjH6wStJJ8/qBj9WvgLkFGf6ucSY+z0I8ZRjhmg=;
 b=HwFeN7dzuUHVgrUIJ3uReLSh5PVx9foGs32EPCJbTkjLz3el1ADSZeeur/Mvt3a13vrd99sCToF2bVOCC4GuHGnKAJZkop8j5TZ5Gajhe/tV/RO4fdyslbBafhItXjiPZli2LL5+6X5rQWTF1IKd9pyan2+MNjHF1gWuUGz3OraSS4Z4HA7g/aYy/mszUeQZt4QoU/YFFDkGcz85v3R2rLBBz78krVV8lfZA/avcspfDz6OPI2MfT96ncFWGOHklFQNXztvlB48J9zpp9dZmLGENOX7bsn4wQIauAUyflR9DIOPd+r6s4vOhEocvnUTt7fJaH3pQFelx3QK1XEiT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyPHxjH6wStJJ8/qBj9WvgLkFGf6ucSY+z0I8ZRjhmg=;
 b=C8caPnRFLUPc35KJ1cwzG4g7CO1MNmetU0anSiyT1Znp8e9svQ17xGlogY0vnRRmeZZ3XVPuZYLV6aVXJVSbvxfjzBoEt5SoNYB/ag/7xGK9OrL2qk/rKPamKhH5jZ+jXSi1AZPoL2UjLaIsOKYuBF/80BeLkAaaZvN0TDCOgIQ=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by BY5PR11MB4053.namprd11.prod.outlook.com (2603:10b6:a03:183::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 16 Jun
 2022 09:20:24 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a%9]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 09:20:24 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
Subject: RE: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYen2pp3p8FshMIEipCRWWl5uoqK1FMCyAgAAPIuCAAAFxAIAMjQJg
Date:   Thu, 16 Jun 2022 09:20:24 +0000
Message-ID: <CO1PR11MB4865A1D77AAD30410D8A815792AC9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
 <1345050e-b6a4-64be-1359-8d31d88769ab@linaro.org>
 <CO1PR11MB4865738B0AFB2F74CD184C5592A49@CO1PR11MB4865.namprd11.prod.outlook.com>
 <18c84400-2fb1-e802-d43a-766c7dcb80aa@linaro.org>
In-Reply-To: <18c84400-2fb1-e802-d43a-766c7dcb80aa@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2af6beb0-5bac-46bb-5177-08da4f7971af
x-ms-traffictypediagnostic: BY5PR11MB4053:EE_
x-microsoft-antispam-prvs: <BY5PR11MB4053370BCE16A8550EB631C792AC9@BY5PR11MB4053.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XfDw7y3X+HIZJ6+RJ9yBpPeRZGqQcjYHEb+NPTH3bYoQQz8f5pp1+xqo6Y4Sf61B8/zpE6bp+YVw6gUl7PeqHVW1xr65Qs4C7+Dl0TdcR5ulb4MSlwfBphcKeZbkRQRoa1FFUgm2UHbPo40PJOTvp0RHFqZ0CoLjzIiqZ1P5mhF2slKZGRZ8zarNZbOUxPmLrmXBTv9Phs4NZmBmhoYOXexPxYKY8TlKHmfi4JHP2lU2f0NulhLJQ0MKawzJZyBWlHKF0kyWmny0vn58gODfv2MpupjvjBVhbBWtWKHfwrdrpkBUZGtqTTttPkeWm8zVzYz3kBcgh1Ya4FRJgUaYwjiWbjdWLRGqzHDU1vUTsoTgpJeJumBPe5WxtjqaXI0tNYUCOD+IsBbe+n7EmhPQx374LmnsSdxx5NNdRbwBlKVTheunoUJoNP5EGeNzhBfXibaWscl3lcV59jEEWGkm9jzsZLYDql7sMJYOSjoCwwz8z4rPEPlUfOvTCy2nMmeuEP3D3ICqnptBusb5o8o++Sz+EQjWPtOE4/rQCZ8IKk22srudiRmeaumLlKv/G5XArCyh5mi9T6nlzJEMuHw1VmbNrZ29WEYmMvcMDPgLL9tCXfaiK5MMvg4u5duhZq3/TgZHaTitHTqcavsAokvIKmiv8j4Wh3LwXYheVUg6io6fwLZoDiPfQY6dpXnd6S0RNuH0AR9/GhZXJsxNbH7uib9tzPlSpSm8q24WDKOAdEUPuNJpE+67U+am7D/JQgHJVcma6dWgtAv7VPijSQ2xsHu2wGYtfIqPrXibY5PMQoV/c7TXQU8GWmi7SM2/eluR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(122000001)(71200400001)(4326008)(55016003)(7696005)(6506007)(33656002)(66446008)(86362001)(107886003)(26005)(54906003)(9686003)(66476007)(52536014)(2906002)(38100700002)(5660300002)(186003)(76116006)(66946007)(966005)(316002)(38070700005)(6916009)(8936002)(64756008)(508600001)(66556008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aklzSEM0WDdrL1cvWi9RSVRsMkhhcC8rVE1DaHBwWU5JMGlEeDBvOTlZeU9o?=
 =?utf-8?B?THJLajZjTlEwenFnYmZldUNyTCs1Yy94bVpRWmdBYy9ycVZLWVp0bitnbHNB?=
 =?utf-8?B?VnRPdDV5WDlUMnIycWhUREoreW9Da1NkZHREaG12WCs0b0YwZ2JMUW9VSjB4?=
 =?utf-8?B?bEM4cUpxMWpVVWFiVlViWWdZaVRrdjA4ZzNWYU1TSHc1Y29LYXhkM05QZlFm?=
 =?utf-8?B?UnBwM21oVUNKZG5HWVJvbWRaTmFVWGNPQWd0Um84OStGQTFuc3h6cXY3Kzdz?=
 =?utf-8?B?eDd1dVZ2TlhUU2ZrNFNTRm43dWdHbkpwZlhUcDJweDRMTHlCRDJZb3pYVDZk?=
 =?utf-8?B?VVpDMHFiaWZXZDUxSFZkMnRidW1wN0Y4U2hXMFNrdU5RT3RVeVhrOWhWUXY1?=
 =?utf-8?B?VnZ2WWppbjg5N243bGkzVmtWd3h4T21oajRUaklUN1F0MUVsS2xtSHQza00r?=
 =?utf-8?B?NzlyZXhzZVNwdWtEOERrdFRQRjlrUVp4R3pTQ0YxSS9HdlpEUENvQjNtR0VQ?=
 =?utf-8?B?djZ0UFB5cDZRd3ZlV3lwSUsrRWFPK3l2N1JTbHB4VDRzNXdZQmZLa3dKS2dM?=
 =?utf-8?B?bkJzbFVPcW9BVU1FQU5wWUEvdGlmT2lnN2dBK2M2aGZ6UEI4UWhGSFd5WGJ1?=
 =?utf-8?B?K2Q1OHFNTWh2b2JDT1JreDJyNWcyR0gwUTYzdnpGOVczQVR2c1V5VUZiWVdw?=
 =?utf-8?B?SExyZGFUMUJScUVIZmJPWVV1ZUl6ZjljcHdodnpWK0lWekE4dVk1NjRzUWQz?=
 =?utf-8?B?dVNpYzREMlZKVU5LTTNZT3BXUDJOUFR2em92TzhtYVY4bTZkeW5kRlp3MXZo?=
 =?utf-8?B?bUt1KzlVRGljT1FJM091N09SUlEwTFE0czRYaU9pcGN0RE1sSHJ6ZnhXZ0J6?=
 =?utf-8?B?bnVBYkNsWG4xbXFxMGN1dlYyNDByZTB1UUlIWFZ5SjJZR1A2NHowTXBzeWVD?=
 =?utf-8?B?NGxONW9MYkZlbzRBMGFoUmJJSXI1RXFUc3JwV2czK3VSbWZJdTlNNVV2eGdv?=
 =?utf-8?B?Q3Azd3JaRDdya2VRdGExcnU0bFp1UkRHMEtJNCswcWlIbE9ZVFlKOGRPaTR5?=
 =?utf-8?B?RlFNL2NGOHBVMVVKSmxkZXJLY3RUWk4rTXVXR0xCclIwQ2h4Q0hpQUZxblc0?=
 =?utf-8?B?QnF1NFYxU2dLcFVDekpTM3V2by9TbllJQnB2SDRjVkFVSlVWbGR4bENyRDdq?=
 =?utf-8?B?cWV1ZXhuanNZb1diOFVsZUhtTjFIM09lNklQRjhqWEZjS3JvRGswd0UxTXNK?=
 =?utf-8?B?V3ZueEw5YWVjRjBWQnlsaS9qZkNjR1Bua3E0OGsxOTcyUDhuQTNESkY2N2ts?=
 =?utf-8?B?MlhINmRSNHFPY1E4SXRVMjA3U2lnVGlPa3M1NUpkOWc5NExwNXZBaGJ6MHg4?=
 =?utf-8?B?RHR1dzFFbTBVN0Y3VWdmNkwwcXc4WHBvTEloUWdCWFEvaEJ2TWw3YVo4SWJp?=
 =?utf-8?B?Si9jajNINWF6WDQ4MGJWOEZrN1ZuZ1lvaUx4WVhFR0EyWUIyTEUwN1IrNGsx?=
 =?utf-8?B?d1NxVThkUERKMEw2Qk9Gd2U3VUdqamVCQlZTVVZmS0J3eXBHa1hmVzBPRWVu?=
 =?utf-8?B?L1NkSWFqV2ZPbnpqMFllS0pMd21hSnRVejdRcHp5NWw0aldTdmVrOCtscFU4?=
 =?utf-8?B?YjZTWFVFbHVmL1VnV1NKakxLaUVlMmNwdmREMXNlVzJYNVU2K2VlNTh1cFpl?=
 =?utf-8?B?YU5wS1Y4Y2Q2VU1nQXFCcVFvd0Z0M1B6NGhMVlhya2VZL2NvREdzWW1GV0w1?=
 =?utf-8?B?Q0NxNVRWdW1BdG5VQ3ptZGd2aTN2WHQvWmlwV3dWa1pQRnR2NElxcHBmUDRZ?=
 =?utf-8?B?OUV6SE4zOW1ydU9vMnYvS1U5Z0pCOTRxUnZvbS92UjFVKzlrczJQVzBTb3Zy?=
 =?utf-8?B?TnV3NitKTTdoRytxeHJNbllvQXNFYmRmVmJBeTJ1c2ZjcnpJQjVVd1hmdkk2?=
 =?utf-8?B?MDF5WEtlekk1VHJhWE5XQnQvWGNKOHVaVThwNnFRZ1VlbkNXQldUODEybTFV?=
 =?utf-8?B?dElpc2lEZWs3SU1SM3RIb3RXbTRLai9sdHRoWlUxYzBWVVdlQ2EzWkNoMEIy?=
 =?utf-8?B?ZWNQalFpdXhZMzA1aDZucEVDdDZzS3czYm1kNUdhVEhUeXpmcXo0TjQvdFdk?=
 =?utf-8?B?dXREay8xQkljTUozTCtPeUNzSDhhb3psVHA3OW56aGVhY1RQWjQ4bk5rNzc1?=
 =?utf-8?B?VW5ZQUZiblExUVl0Z0F1REFJbjI5dldVVmVTZ1d6Tjk0TEVNSVhyRGUzV1Fj?=
 =?utf-8?B?emtTbWxjbFRseXdvMHd0aGFLaEZaWk9IT0hpSldHVXFxWEhlY05LSVY2T2ho?=
 =?utf-8?B?UzlOdG9jeVk2bTFTcFBBa0JaRTdtUkIxZGl1SGJCNlROMkVaT1V5alRsaGZt?=
 =?utf-8?Q?FlVTlDCexUk7rnpU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af6beb0-5bac-46bb-5177-08da4f7971af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 09:20:24.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRhFxYfQHK4zAA9IbmIRzPJVuW1ouHSd7jwyqLJFo/2Ij5NnMUoiCarLq+51XRf23pSxp6GDlmELAp0b+zcZFWT4bMxKpkQFF/+nugIR9LICMkLchwtMhohz9Hd1qVak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4053
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gQ29udmVydCB0aGUgQXRtZWwgZmxleGNvbSBkZXZpY2UgdHJlZSBiaW5kaW5ncyB0byBq
c29uIHNjaGVtYS4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBLYXZ5YXNyZWUgS290YWdp
cmkgPGthdnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiB2
MSAtPiB2MjoNCj4gPj4+ICAtIEZpeCB0aXRsZS4NCj4gPj4+DQo+ID4+PiAgLi4uL2JpbmRpbmdz
L21mZC9hdG1lbCxmbGV4Y29tLnlhbWwgICAgICAgICAgIHwgOTcgKysrKysrKysrKysrKysrKysr
Kw0KPiA+Pj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC1mbGV4Y29tLnR4dCB8
IDYzIC0tLS0tLS0tLS0tLQ0KPiA+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgOTcgaW5zZXJ0aW9ucygr
KSwgNjMgZGVsZXRpb25zKC0pDQo+ID4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1sDQo+ID4+
PiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
ZmQvYXRtZWwtDQo+ID4+IGZsZXhjb20udHh0DQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdA0KPiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1s
DQo+ID4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4
Y29tLnlhbWwNCj4gPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+PiBpbmRleCAwMDAwMDAw
MDAwMDAuLjA1Y2I2ZWJiNGIyYQ0KPiA+Pj4gLS0tIC9kZXYvbnVsbA0KPiA+Pj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4g
Pj4+IEBAIC0wLDAgKzEsOTcgQEANCj4gPj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPj4+ICslWUFNTCAxLjINCj4gPj4+ICst
LS0NCj4gPj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21mZC9hdG1lbCxm
bGV4Y29tLnlhbWwjDQo+ID4+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEt
c2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4+PiArDQo+ID4+PiArdGl0bGU6IEF0bWVsIEZsZXhjb20g
KEZsZXhpYmxlIFNlcmlhbCBDb21tdW5pY2F0aW9uIFVuaXQpDQo+ID4+PiArDQo+ID4+PiArbWFp
bnRhaW5lcnM6DQo+ID4+PiArICAtIEthdnlhc3JlZSBLb3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFn
aXJpQG1pY3JvY2hpcC5jb20+DQo+ID4+PiArDQo+ID4+PiArZGVzY3JpcHRpb246DQo+ID4+PiAr
ICBUaGUgQXRtZWwgRmxleGNvbSBpcyBqdXN0IGEgd3JhcHBlciB3aGljaCBlbWJlZHMgYSBTUEkg
Y29udHJvbGxlciwNCj4gPj4+ICsgIGFuIEkyQyBjb250cm9sbGVyIGFuZCBhbiBVU0FSVC4gT25s
eSBvbmUgZnVuY3Rpb24gY2FuIGJlIHVzZWQgYXQgYQ0KPiA+Pj4gKyAgdGltZSBhbmQgaXMgY2hv
c2VuIGF0IGJvb3QgdGltZSBhY2NvcmRpbmcgdG8gdGhlIGRldmljZSB0cmVlLg0KPiA+Pj4gKw0K
PiA+Pj4gK3Byb3BlcnRpZXM6DQo+ID4+PiArICBjb21wYXRpYmxlOg0KPiA+Pj4gKyAgICBjb25z
dDogYXRtZWwsc2FtYTVkMi1mbGV4Y29tDQo+ID4+DQo+ID4+IFNhbWUgY29tbWVudCBhcHBsaWVz
IGFzIGJlZm9yZS4uLiBZb3VyIHByZXZpb3VzIHNldCB3YXMgYmV0dGVyIGhlcmUNCj4gYW5kDQo+
ID4+IGZvciBzb21lIHJlYXNvbiB5b3UgZGVjaWRlZCB0byBjaGFuZ2UgaXQuIFRoaXMgc2hvdWxk
IGJlIGVudW0gc28geW91DQo+ID4+IGF2b2lkIHVzZWxlc3MgY2hhbmdlIG5leHQgcGF0Y2guDQo+
ID4+DQo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiA+IERvIHlvdSBtZWFuIHVzZSAi
ZW51bSIgaW5zdGVhZCBvZiAiY29uc3QiIGluIGN1cnJlbnQgcGF0Y2ggaXRzZWxmIGFuZA0KPiBh
ZGQgbmV3IGNvbXBhdGlibGUgaW4gMi8zIHBhdGNoPw0KPiANCj4gWWVzLiBUaGlzIGlzIGhvdyB5
b3UgZGlkIGl0IGluIHByZXZpb3VzIHBhdGNoc2V0cy4NCj4gDQpJIGRpZCBzbyBpbiB2MyBzZXJp
ZXMsIGJ1dCBiZWxvdyBlcnJvcnMgYXJlIHJlcG9ydGVkIG9uIDEvMyBwYXRjaDoNCmR0c2NoZW1h
L2R0YyB3YXJuaW5ncy9lcnJvcnM6DQovYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtcmV2aWV3
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1s
OiBwcm9wZXJ0aWVzOmNvbXBhdGlibGU6ZW51bTogJ2F0bWVsLHNhbWE1ZDItZmxleGNvbScgaXMg
bm90IG9mIHR5cGUgJ2FycmF5Jw0KICAgICAgICBmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6Ly9qc29u
LXNjaGVtYS5vcmcvZHJhZnQtMDcvc2NoZW1hIw0KL2J1aWxkcy9yb2JoZXJyaW5nL2xpbnV4LWR0
LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhj
b20ueWFtbDogcHJvcGVydGllczpjb21wYXRpYmxlOmVudW06ICdhdG1lbCxzYW1hNWQyLWZsZXhj
b20nIGlzIG5vdCBvZiB0eXBlICdhcnJheScNCiAgICAgICAgZnJvbSBzY2hlbWEgJGlkOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2tleXdvcmRzLnlhbWwjDQovYnVpbGRzL3Jv
YmhlcnJpbmcvbGludXgtZHQtcmV2aWV3L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZmQvYXRtZWwsZmxleGNvbS55YW1sOiBwcm9wZXJ0aWVzOmNvbXBhdGlibGU6ZW51bTogJ2F0
bWVsLHNhbWE1ZDItZmxleGNvbScgaXMgbm90IG9mIHR5cGUgJ2FycmF5Jw0KICAgICAgICBmcm9t
IHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvc3RyaW5nLWFy
cmF5LnlhbWwjDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
