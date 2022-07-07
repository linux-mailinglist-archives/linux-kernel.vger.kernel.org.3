Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B783B569AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiGGGyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiGGGym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:54:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384B32CDCB;
        Wed,  6 Jul 2022 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657176877; x=1688712877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zWlPko9JunG//ZOuFL/Svy0Pa8LsPyzKJYl1S+sAKRQ=;
  b=Dbt3Xjj5I0OBzQs9TtTmJKmGYi07MJGFzGmfh9IE9Debn9GbMcBNkylK
   NbFrhhbtxMM8wvD1OaVYdR8X52qMglYC1lryKlgUd7zrI1TWqwb117bVe
   oMSKwyPODZ+v28ndvBfBya/VJMk8/0ZofV6Q9ZOLuiNo3Z2CWKqx/14aS
   qvL2Lyqw8kqxImObd0LgEljQi/8at1VI0n4wcIP73kaMfxydP2ElvJNiO
   5Q/mhps5sELlx5GMDZLKtMrpj34NThDuUfBNlIIG4sjTn4UqQ+fbwEGuP
   g//SGo9xlRyHYDK8KOzFVC8HGsW1xHV6N6dWkUk4tpk6trjylqFmrAd1W
   w==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="171389837"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 23:54:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 23:54:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 6 Jul 2022 23:54:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB6gGpISuwoIPs5MfazelbgSo/1/XI8LSiinP4V1JgxP1a7AS+wGPEC/OfvYEhaQHyCypQUEIjSENslnqRzJk3A1IiVONmt5j4cUICLg1JIxcChOj3kIAMEg+hRxJzuUMpXn0fU4GLh6JAhdL4ZPW4qyfvFr4/RS2LECO5GKW2szg47WrYeOOAf5w0h+D0yFJX7+TNDevaoifhLDnV/LeteuqHORREa04F2nWTZPquZwLWC/ZlmS3XHZxx02YpIIVEP8joIU50gAA8uMCcNlzerTUt5XgoLMNTKJX4byHyIEN1t9Pi2bbopwCmA90wMrO5qNLwdN9wwEQqsOPZc3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWlPko9JunG//ZOuFL/Svy0Pa8LsPyzKJYl1S+sAKRQ=;
 b=Mrrsk9W5oppslzF92v8nOzvNqqHsh4oRNV9LwDlK65UFeU5N+Sr9m5Efx0fhyh43L2VWobtaJFMFUca3U3M15GCaspU+E0qFmJCV/hb2fNykysWckiTAK+Ie0jx/bI3D0ifOoWTSLsPRNWca9qycb4dJ/dLzQdS7uK2pzKUPRDYwduA0kJ3INQ1kg3qEKujK54/Ou2LDKN3vrJ0OFU7AzSN7K2q1I0PpOvIw0AmEi1buniRooaVY9qWqQXnjgQ+DeDJoxw4SiXdvJZAlXAP/IyCjg8rwSg8+K4oP4PD49fey1/a2KkL1aX4V5xJiOlPuBXA/YX+elPpy6DAxH0P4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWlPko9JunG//ZOuFL/Svy0Pa8LsPyzKJYl1S+sAKRQ=;
 b=LEQdqfQJ9Uc3bIVkThQ7n1YFvZRTkLlsIryPIJDKiuRsMGxGX4mWAhVQVD8d3wk1LhhY2QtX8wQQS8W4PbExTK284AgOvtksfeagYi9y/Jg6nmZXIqRaHbV9ntvpiJB73T6n0axo1n7FjVtfYTEl5DECzoh7zkphDt5kYNujZks=
Received: from PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 06:54:32 +0000
Received: from PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::1884:3ecf:a6c7:c2cb]) by PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::1884:3ecf:a6c7:c2cb%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 06:54:32 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Topic: [PATCH v7 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Thread-Index: AQHYkSiOZg1vfaNbnEm+LtjpZR1JIa1xdhQAgADqqBCAAAZ9oA==
Date:   Thu, 7 Jul 2022 06:54:32 +0000
Message-ID: <PH0PR11MB4872FE079CBF99E39F894E9D92839@PH0PR11MB4872.namprd11.prod.outlook.com>
References: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
 <20220706110619.71729-2-kavyasree.kotagiri@microchip.com>
 <fca15370-f977-687a-ff62-22ae43046b58@linaro.org>
 <PH0PR11MB487299A211568CC3614682BC92839@PH0PR11MB4872.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB487299A211568CC3614682BC92839@PH0PR11MB4872.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87fff70b-c732-4358-aa21-08da5fe58be6
x-ms-traffictypediagnostic: SA0PR11MB4704:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KadAhFbc8JgDv/BV19ngPV5vglgktAFzyW4Av/FThkZG3/vlwDxTIcGTrJEeF/aMVGdNUfMwFPzbPZgyip3eLBNqk6nyHNUdi+dULMbAM7Ig6Pm1abKVYd5pbZvoazpuh07drmkPPJBIgbOQKy4UnCujbdzchOXauP6+qSN/qEngTCAJDB+zgoo+DjHnhJxqsFBKZjaZ3IHnlc6ztnuU5+fraaCvNKlhNcgmykFRxCkdSCb2dQRvcVA6tP2/idmDBzFCp2SAlxNfpcmKNOAX6xVFxWb4grSDKYJuSn29bHt9BV/FBPG2TOJv3BNK7zLvIdj+fCQsy1eGA6PH3ey/WviCKJKG2Wr4ab3g6CTR84E5Ebnqnwq1HBdSC2VXNQJF6vRtYWJNGxrkiXNuFtVx5ZyG0oh+5N9rF0OnM8qsKrtONX4HlfgXUaDeq5qJMc2V9eZ9PziOuHsPErSE6hsH/XQNWIPs3CXKd5sgVCZn0dTtlWnRnl3rfVZdJ5Z1LRXdQi8L3iMyWEicsmzFEFJh8JBueaexptnQSwQ5NgKHepztDhKG4RR1fcCUYNpejArqOmSVC75V0xOhbxRY1+WsflFfp0v8qRvijPCYu3DUgzyXvBc58cgE7OZDvo5+S6f2PCq+3uNO9xLhgqmJk8Ev1B5LN4r4h6nP0xFuRz2wMdgB8qbWXZBjViX/e5DFujUty4MpyKPL+GtYP9zku7D/sPRYM98OzS2XwL7QmhBqwsKsnOS6Phhel+2kqVsPWuIrjelEMgra4bLwB8skNpVCAOanHca56QEYV5ia4SLmzCvUCOK6yyU2tQZwTeI56HpZ2qJ8zHkYfq7HV1rRY6jKKqs8m7DFIPXOY7v43f/WCbHtIdazdoL5u8U55OdW+kpghgPEUNmpSJg2AtwXSFWGwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(396003)(346002)(39860400002)(38070700005)(33656002)(41300700001)(186003)(122000001)(66556008)(7696005)(6506007)(9686003)(2906002)(2940100002)(83380400001)(26005)(6636002)(110136005)(54906003)(478600001)(38100700002)(52536014)(966005)(8936002)(64756008)(4326008)(55016003)(66446008)(66476007)(66946007)(86362001)(8676002)(71200400001)(5660300002)(76116006)(316002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFFWWTZTMnJSYUdwM0tiQ3BFY0RvNkRqdWQ3RzZCREx4SGROMTlVUkxkbzd4?=
 =?utf-8?B?dnRyTXg1TWtQZ2N5Rzl6Y3Q2NXZGNEdsSlB4dkl2UmZMWnpjS0NDbDRBSllQ?=
 =?utf-8?B?NHlHNHBFaUEyaEN2Ly9XK0Zac2xmczZ6QW5VR3pSeWJpd0VkbEpnTFRxSlU2?=
 =?utf-8?B?ZC91Z21GaFpzWStqditWWWNWZm5kZUJvV3FuQis2U2hTN29KZ0ZYTjM1NGk1?=
 =?utf-8?B?cTlseHJmSXQ3UDUzc2VEaVBYNTJhOTZ1czY4WXMwN25XejdKd0hpaFd3U2gy?=
 =?utf-8?B?d3NZU3dhTjJGcEZCalRxaG5yZVhsU1hqSVZHb0I4OS8xa2VKRUhFU1AzWmNQ?=
 =?utf-8?B?US9OS05yVnZyRDUzTFFuTHZJK2swamtXVmhiTlcyb3o1Rm1Ob1h6OGFEOW5w?=
 =?utf-8?B?NzNtTGkzQkwyVmNuaCtuKzdxcGV0WmVxdUhtWjhnSzZqOHJwSk85V3EzQTBY?=
 =?utf-8?B?aStQQitiWEJ6d1VJSXBPd1BjQjlxWkxPMWN5VlRpUlhWdjcxaEJmbjZiU3Iw?=
 =?utf-8?B?UlllbmdlUzAwaHlLNGF6b1JDUTNHSWNSUGE4ZmxkMjNjZ3pMSEw3SklEZU5S?=
 =?utf-8?B?M3c3ekQxcmk1NDVzRy9KVlZKZm9lWUk4NFpWRFF5SFdRZCtBbVpETUFjMk8w?=
 =?utf-8?B?TUR2WmlURVl6cFVlNnlWUFYzR2FUd2pXMS9lQVoxOFdCWjF6UmJXUnF4Uk0z?=
 =?utf-8?B?MndSY1RaZTVQWFZiNWJZcFVOZyttWllpbmJIVFJlckFjOXNrL245a1BrRDJ0?=
 =?utf-8?B?N2kvR2k0eXZYL1YwVFpXWXZKcW9pN0lFRExkb0NlTDU5aTFiMGxEVEFYdUNp?=
 =?utf-8?B?Z28vMTlIZjhWQmNFbjlEbWJ5WGRCc1R1aVUrc2FNWFpjdWJZaXU5aGNUUDQ4?=
 =?utf-8?B?cHZCQk03ejNhNUNuZURpdFU5TDdUQTFucjZCbVdHRlZUUnRhQTJGSC9XT1Yv?=
 =?utf-8?B?Y05zblZEbXlSSFlOMjVTMjc2bzMzREtFcTF6ZGJqTGtqOXducW5DNTNZOTBF?=
 =?utf-8?B?WGdlODB0NGpIVjljUkFONTl5ZURlQ1VkNnRLTVdLa2NkbUprZFRCaUxSOVVl?=
 =?utf-8?B?YWhzM2hkVnRKZnZDVlg0K3F0OXl2UDJ5UmowTjc3MkdncEFLSUVYUVErQmNW?=
 =?utf-8?B?UFBhTFBqdDAxOWFpMy9WcjZ1REszMDEwR2k5UnNBL1Q4WHdYYkxpVTQ5Q3Zm?=
 =?utf-8?B?NkR5eTNyRi9ING5hdHR1VmpPTHRnWWluVUJacVNIOEhlTVZqSlJHU1JtYzNI?=
 =?utf-8?B?V25oendRam5NdzQ2RVIxU3lCeDk1bGpyWTJVaEVrcUxZamJ0WTBnZlBBZ1Z6?=
 =?utf-8?B?N1FlcENZUUR5SHFvRjJDTHQrWWNHV0o2bXVTc3BJZHBhcDd3SzNwUDNsNlZ1?=
 =?utf-8?B?MHpLQW55djhJMHhKaTdKMlFQR2MwbWdneVRzT2I4aWpPVC8rTkxTeENSSmc3?=
 =?utf-8?B?S1ZYbUVXNlhrVmZuV3p1RldXa3lYVUlnRUpqM1lEQnNVUS9HQmxxQmpHcyt0?=
 =?utf-8?B?OC8wM1BvclVRbEZEM0dBNHNJSFg1QUN4R21Sb3ZZS25sSlJXaE9LUjg2K0lB?=
 =?utf-8?B?Y1BWaUc1dkxsN2I3S3lrOFprQnE0bHVENmlRZ1NwSHV3S1N6dTlPSHlNLzF4?=
 =?utf-8?B?cklmRkJVdldtS3hEOGt4SmkvUW5DVkJ4bG1kVE1WSWN5QmFMdHRoYStMUyt5?=
 =?utf-8?B?QVViZkFxRlExZWt2T3NFMGJSa090Z1JuSDZCUlAwMGpDdnFTR2dKY0VZZ1cw?=
 =?utf-8?B?U0YvNWFHS2pGL0pxYmNjaXF2WFkvUDNzaVhmSG11KzV2UGYyVldvMlkzdk5W?=
 =?utf-8?B?R3dhTjJrSkZIUUFEZFl4UkxHSDdVM3I4KzhnSlAxYWZka3NreXpXRGRnaDJP?=
 =?utf-8?B?Rld3MklkLytrc2hYN0p6UmQxSi9GRWo0YjU2UkVBVVBucGY5UUZWMDYxbWVa?=
 =?utf-8?B?U2tvNjFEdG9vS1Btc1NzdWpmMWlRRVBQN25ocG02UlQ5U29nZ1M3Z3FXVThq?=
 =?utf-8?B?TjZyM29aZ200bC8veGM3TDNLcjNYTWViZjVUZzZCd3Y2Wkk5eGgzb0VwbFly?=
 =?utf-8?B?bW5UYS9MMVhjcDFBKzBNS1EyeWQzdFV6K3pFNExvazlYc3dmOG9XSVlJYWwx?=
 =?utf-8?B?M0tYR0hHaHhQWVNxVFplOTJ4eHRMS1dKSmRwQjVnZ0F3NmtsQ3dGekVmbURu?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fff70b-c732-4358-aa21-08da5fe58be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 06:54:32.5020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmu7or4jxY7FnqSp/BjdZAUj5gmn7FG8Lol3BXFXBgXKpzntgtaCIZG3L5CKO9FNIHX40iEqMKU/ZJhWMSDGrdw2JBaUpBM6z89oH4z14IqQBIcNIyRvJYBNCXxfJJEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gQ29udmVydCB0aGUgQXRtZWwgZmxleGNvbSBkZXZpY2UgdHJlZSBiaW5kaW5ncyB0byBq
c29uIHNjaGVtYS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLYXZ5YXNyZWUgS290YWdp
cmkgPGthdnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiB2
NiAtPiB2NzoNCj4gPiA+ICAtIENoYW5nZSBmaWxlbmFtZSB0byBhdG1lbCxzYW1hNWQyLWZsZXhj
b20ueWFtbA0KPiA+ID4gIC0gQWRkICNhZGRyZXNzLWNlbGxzLCAjc2l6ZS1jZWxscyB0byBmbGV4
Y29tIG5vZGUgLSBGaXhlZCB3YXJuaW5ncy4NCj4gPiA+DQo+ID4gPiB2NSAtPiB2NjoNCj4gPiA+
ICAtIFJlbW92ZWQgc3BpIG5vZGUgZnJvbSBleGFtcGxlIGFzIHN1Z2dlc3RlZCBieSBSb2IgYW5k
DQo+ID4gPiAgICBhbHNvIHBhdHRlcm4gcHJvcGVydGllcyhzcGkgZHQtYmluZGluZ3MgY29udmVy
c2lvbiB0byB5YW1sIHBhdGNoIGlzDQo+IHVuZGVyDQo+ID4gcmV2aWV3KS4NCj4gPiA+ICAgIE9u
Y2UgdGhhdCBpcyBhY2NlcHRlZCwgSSB3aWxsIGFkZCBiYWNrIHNwaSBleGFtcGxlIHRocm91Z2gg
bmV3IHBhdGNoLg0KPiA+ID4NCj4gPiA+IHY0IC0+IHY1Og0KPiA+ID4gIC0gRml4ZWQgaW5kZW50
YXRpb25zLg0KPiA+ID4NCj4gPiA+IHYzIC0+IHY0Og0KPiA+ID4gIC0gQ29ycmVjdGVkIGZvcm1h
dCBvZiBlbnVtIHVzZWQgZm9yIGNvbXBhdGlibGUgc3RyaW5nLg0KPiA+ID4NCj4gPiA+IHYyIC0+
IHYzOg0KPiA+ID4gIC0gdXNlZCBlbnVtIGZvciBjb21wYXRpYmxlIHN0cmluZy4NCj4gPiA+ICAt
IGNoYW5nZWQgaXJxIGZsYWcgdG8gSVJRX1RZUEVfTEVWRUxfSElHSCBpbiBleGFtcGxlLg0KPiA+
ID4gIC0gZml4ZWQgZHRzY2hlbWEgZXJyb3JzLg0KPiA+ID4NCj4gPiA+IHYxIC0+IHYyOg0KPiA+
ID4gIC0gRml4IHRpdGxlLg0KPiA+ID4NCj4gPiA+ICAuLi4vYmluZGluZ3MvbWZkL2F0bWVsLHNh
bWE1ZDItZmxleGNvbS55YW1sICAgfCA3NA0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtZmxleGNvbS50eHQgfCA2MyAtLS0t
LS0tLS0tLS0tLS0tDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCA2
MyBkZWxldGlvbnMoLSkNCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLHNhbWE1ZDItZmxleGNvbS55YW1sDQo+
ID4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZmQvYXRtZWwtDQo+ID4gZmxleGNvbS50eHQNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxzYW1hNWQyLQ0KPiA+
IGZsZXhjb20ueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRt
ZWwsc2FtYTVkMi0NCj4gPiBmbGV4Y29tLnlhbWwNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjg2NGY0OTBmZmI4Mw0KPiA+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9h
dG1lbCxzYW1hNWQyLQ0KPiA+IGZsZXhjb20ueWFtbA0KPiA+ID4gQEAgLTAsMCArMSw3NCBAQA0K
PiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTIt
Q2xhdXNlKQ0KPiA+ID4gKyVZQU1MIDEuMg0KPiA+ID4gKy0tLQ0KPiA+ID4gKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWZkL2F0bWVsLHNhbWE1ZDItZmxleGNvbS55YW1sIw0K
PiA+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55
YW1sIw0KPiA+ID4gKw0KPiA+ID4gK3RpdGxlOiBBdG1lbCBGbGV4Y29tIChGbGV4aWJsZSBTZXJp
YWwgQ29tbXVuaWNhdGlvbiBVbml0KQ0KPiA+ID4gKw0KPiA+ID4gK21haW50YWluZXJzOg0KPiA+
ID4gKyAgLSBLYXZ5YXNyZWUgS290YWdpcmkgPGthdnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAu
Y29tPg0KPiA+ID4gKw0KPiA+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ID4gKyAgVGhlIEF0bWVsIEZs
ZXhjb20gaXMganVzdCBhIHdyYXBwZXIgd2hpY2ggZW1iZWRzIGEgU1BJIGNvbnRyb2xsZXIsDQo+
ID4gPiArICBhbiBJMkMgY29udHJvbGxlciBhbmQgYW4gVVNBUlQuIE9ubHkgb25lIGZ1bmN0aW9u
IGNhbiBiZSB1c2VkIGF0IGENCj4gPiA+ICsgIHRpbWUgYW5kIGlzIGNob3NlbiBhdCBib290IHRp
bWUgYWNjb3JkaW5nIHRvIHRoZSBkZXZpY2UgdHJlZS4NCj4gPiA+ICsNCj4gPiA+ICtwcm9wZXJ0
aWVzOg0KPiA+ID4gKyAgY29tcGF0aWJsZToNCj4gPiA+ICsgICAgZW51bToNCj4gPiA+ICsgICAg
ICAtIGF0bWVsLHNhbWE1ZDItZmxleGNvbQ0KPiA+ID4gKw0KPiA+ID4gKyAgcmVnOg0KPiA+ID4g
KyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgY2xvY2tzOg0KPiA+ID4gKyAgICBt
YXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gKyAgIiNhZGRyZXNzLWNlbGxzIjoNCj4gPiA+ICsg
ICAgY29uc3Q6IDENCj4gPiA+ICsNCj4gPiA+ICsgICIjc2l6ZS1jZWxscyI6DQo+ID4gPiArICAg
IGNvbnN0OiAxDQo+ID4gPiArDQo+ID4gPiArICByYW5nZXM6DQo+ID4gPiArICAgIGRlc2NyaXB0
aW9uOg0KPiA+ID4gKyAgICAgIE9uZSByYW5nZSBmb3IgdGhlIGZ1bGwgSS9PIHJlZ2lzdGVyIHJl
Z2lvbi4gKGluY2x1ZGluZyBVU0FSVCwNCj4gPiA+ICsgICAgICBUV0kgYW5kIFNQSSByZWdpc3Rl
cnMpLg0KPiA+ID4gKyAgICBpdGVtczoNCj4gPiA+ICsgICAgICBtYXhJdGVtczogMw0KPiA+ID4g
Kw0KPiA+ID4gKyAgYXRtZWwsZmxleGNvbS1tb2RlOg0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjog
fA0KPiA+ID4gKyAgICAgIFNwZWNpZmllcyB0aGUgZmxleGNvbSBtb2RlIGFzIGZvbGxvd3M6DQo+
ID4gPiArICAgICAgMTogVVNBUlQNCj4gPiA+ICsgICAgICAyOiBTUEkNCj4gPiA+ICsgICAgICAz
OiBJMkMuDQo+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3VpbnQzMg0KPiA+ID4gKyAgICBlbnVtOiBbMSwgMiwgM10NCj4gPiA+ICsNCj4gPg0KPiA+IEFz
IHBvaW50ZWQgb3V0IGJ5IFJvYidzIGJvdCAtIHdoeSBkbyB5b3Ugbm90IGFsbG93IHRoZSBwcm90
b2NvbC1zcGVjaWZpYw0KPiA+IGNoaWxkcmVuIGhlcmU/IHNwaSwgc2VyaWFsIGV0Yz8NCj4gPg0K
PiB1c2FydC9zZXJpYWwsIHNwaSBhbmQgaTJjIGR0LWJpbmRpbmdzIGFyZSBpbiAudHh0IGZvcm1h
dC4gU28sIEkgY2Fubm90IHJlZmVyIHRoZW0NCj4gaGVyZS4gTGlrZSBJIG1lbnRpb25lZCBpbiB2
NSAtPiB2NiBjaGFuZ2VzIGRlc2NyaXB0aW9uLCBzcGkgZHQtYmluZGluZ3MNCj4gY29udmVyc2lv
biBpcyB1bmRlciBkaXNjdXNzaW9uLiBGb3Igbm93LCBJIGFtIHJlbW92aW5nIGNoaWxkIG5vZGVz
IGZyb20NCj4gZXhhbXBsZS4gSSB3aWxsIGFkZCBpdCB0aHJvdWdoIG5ldyBwYXRjaCBvbmNlIGJl
bG93IGJpbmRpbmdzIGFyZSBhY2NlcHRlZDoNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LWFybS0NCj4ga2VybmVsL3BhdGNoLzIwMjIwNjI5MTI1ODA0LjEzNzA5
OS0xLXNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20vDQo+IA0KQ291bGQgeW91IHBsZWFzZSB0ZWxs
IGlmIGNoaWxkIG5vZGVzIGNhbiBiZSBhZGRlZCBhcyBiZWxvdz8NCi0tLS0tLS0tLS0tDQorcGF0
dGVyblByb3BlcnRpZXM6DQorICAiXnNlcmlhbEBbMC05YS1mXSskIjoNCisgICAgZGVzY3JpcHRp
b246IFNlZSBhdG1lbC11c2FydC50eHQgZm9yIGRldGFpbHMgb2YgVVNBUlQgYmluZGluZ3MuDQor
ICAgIHR5cGU6IG9iamVjdA0KKw0KKyAgIl5zcGlAWzAtOWEtZl0rJCI6DQorICAgIGRlc2NyaXB0
aW9uOiBTZWUgLi4vc3BpL3NwaV9hdG1lbC50eHQgZm9yIGRldGFpbHMgb2YgU1BJIGJpbmRpbmdz
Lg0KKyAgICB0eXBlOiBvYmplY3QNCisNCisgICJeaTJjQFswLTlhLWZdKyQiOg0KKyAgICBkZXNj
cmlwdGlvbjogU2VlIC4uL2kyYy9pMmMtYXQ5MS50eHQgZm9yIGRldGFpbHMgb2YgSTJDIGJpbmRp
bmdzLg0KKyAgICB0eXBlOiBvYmplY3QNCi0tLS0tLS0tLS0tLS0NCg0KPiA+DQo+ID4gQmVzdCBy
ZWdhcmRzLA0KPiA+IEtyenlzenRvZg0K
