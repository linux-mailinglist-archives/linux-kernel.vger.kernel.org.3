Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A167458222D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiG0Ibf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0Ibc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:31:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE4B1F2ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658910690; x=1690446690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lmZxCsSW2vD+xxLQgVLHkL9QKlbYckLEJxzMbEcJsY8=;
  b=uPVcqxEuVe4dhIm0tvkbAAK7KlbDof8WcxQZB4LcFEuu5jwD6ubTW+u+
   7NeEjLH93sMcNNw0YiF0CbKwAQVXFvOOzb6b9jCnUIuCvs2KKilrMwf8v
   SU674i4Tr25VRQEE2GeL3jnPYEzS1jlFKS5bNpAYzvhlW+H6HFboQaB7w
   UP57VBym4NTOknb6TbW3QoiFQuUgqwuW/WPhm5a+eaJ54J4CEOpFKwhar
   JLSLrcOVrtFsPd0g3sqhQDpVAGXWtAwU4BPq7h/M4ssGYkzCt0SldUL2m
   nb+PhzMjGWmmzkeBir5rVeRghYOrTEUHTi+IGzr4PC9Utg1fiQKuAcwjJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="173961929"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 01:31:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 01:31:17 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 01:31:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NINrAbBpWPr78sHa9qhgGPdqHsWW9p6tFQLXkRrGC2MrK1bQRMiPjmAePl4rg7ilLkbC+d8Zal5kzFynEsVvINHs220MgG/t3PgF9eclaKtbDuow57ax6MZOKNJ5QiSnvHfmpVwVwmqZqDuowyXHX95/XhbrgeZn1eBUQ4fq9GZ6WN1P/UiKuXlqw158eBGhEwkdWUOMwUPzie+beBJ02hGyE04xNnRGpzXkg0SsG1MRc66pncBLDUb4x6hZ1Eh9MDSdqqMX1gyKMs39doQQdkQ/LcfxaHAWICOSx1DMQUU+vxhCx+GCoZT4Ht9V1PVyNmzAShNee8IBdhr4TPjDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmZxCsSW2vD+xxLQgVLHkL9QKlbYckLEJxzMbEcJsY8=;
 b=CkUsdQfom4KPJnDPdprTTL5gqDZ/2hkGq9MoaM6rS53etutfViUNDjt14sSrLxB0b0FiNv6w8Iq+P5Pd3aUZHpmEMZIqcFN9+t/K+tK/56b5L6hVT4ogujwUF2675/0Hbwj0O7DfbfRTfhHSL4XBap1a0A61yuscaO6STqUqsD+OpwkCWw6FXaapQNtkgtch84SVwEMM7EqItlp0OQkCo7xQCE9LZLyOM85RcKzk/Fc+9gXHFg9F+AMLdG1/ueX0FDIahNkgPTyuAHZ/ltCpUnIrqhCCtmbD45Ctd/6RekN2PkMSkoPwk7Q991+U/GhFyxXPde6aQgW13m812smE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmZxCsSW2vD+xxLQgVLHkL9QKlbYckLEJxzMbEcJsY8=;
 b=WiwyFhsTY77lc8cd3dJv3Y8NPTAPob6jHChdblE3rLJ6y0tn/Z2cIUh618z+aKSIDvQHiPNepIe8uhNIO/S3LQggTT1sUWypte/2Nl7D7kUIaIuT+tetCi62o7E1rAAfx+fG1anti5x6WBgjr4HRAE8mmILhHM+l37p/4XRFAEM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2684.namprd11.prod.outlook.com (2603:10b6:5:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Wed, 27 Jul
 2022 08:31:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 08:31:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <apatel@ventanamicro.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>
CC:     <arnd@arndb.de>, <anup@brainfault.org>,
        <linux-kernel@vger.kernel.org>,
        <heinrich.schuchardt@canonical.com>, <atishp@atishpatra.org>,
        <linux-riscv@lists.infradead.org>, <n.shubin@yadro.com>
Subject: Re: [PATCH v2] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
Thread-Topic: [PATCH v2] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
Thread-Index: AQHYoXL9tntjQdHtAUeuEXJmeRpsEK2R460A
Date:   Wed, 27 Jul 2022 08:31:11 +0000
Message-ID: <46752e20-b7c3-f22c-791b-1865bc109adb@microchip.com>
References: <20220727043829.151794-1-apatel@ventanamicro.com>
In-Reply-To: <20220727043829.151794-1-apatel@ventanamicro.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 523c2ace-86df-4bf9-70b7-08da6faa5c71
x-ms-traffictypediagnostic: DM6PR11MB2684:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IVya+mwAX4stpNEyJyb1PQILD3RWvvhzEFB0n4q4LOEOQjL8A0d7T1xKq3TIkvFBg8/a2zC/UeC/I1MDONm1RzSwhk6t2oj2GyrlP3ODndhGiyGUxHFtGGdmCgnlTkXhWjTHMvTvOHuw5p0qjti/g5B3dZqprO2dQxjx2fqJAS0SY/FlFe2XfIH3RIoY2mdOgzrL4vwHC6cUBojMrFBD1X1a4dOk6qbEVSNhiIBqc0uWxoNVCDrFR5sxxMTIrNlb1jPlflK2YmTriXkJi+Sk+5nEV2CDt4TgptRwohzQJ6TEx1vJOlpVEekqMeEIkXH4JUFT/bo8vIU6eYhPPjKVlWfA4QVfJ7mDxcgD/wVgNZmGH6BKx7fXev66kHCOneMvQ+zIqKQzHIII9UYrEh+ZI3xI3zDylkA1+WqIYYoRGPmLbuWzhZFGa1hg2XeAHxRk4VJmOLB9u7KmOsNmPFLgbiF4MTpUs1skLJUmV73SY5FmAUGUH5hD/w2WIaKMwlFQL3BURnfxsL2zKhH8QDQjmoSpl6JoGhL7JESIwl2f3WJY+wn20MQPeJbyAR069RtmzXYG3Mtl4+mkJ+5RwVa3yoHO2OypPbCfXpDl+5vNJqeOTYfI8bWGDAmtXaTIEdE1ZdDvu5YEopuawDan55qBQjIHq1m17/r+lalcraNHWn9tHYqn2LfynJu8YOQzmMBFxiyps8+oCPAlJaUFNIIOcAt4iYWR6lqL586bLWW51OjdS8RdAQaiZTUIHgTudDJb+trvV6acntQXRnShye9zOYLbPCRnn0ER0KGsuctVpoDfBZsQ+1Cp/1el/YWsIO/H3/RlsE9NB7waOIF0RBnp3Mdrlb//oPtqM3lSFgP4sXG5qWMgihdfyr6ODXR+38gZxrq23JGu3Niz2wi/mMV/gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(346002)(376002)(39860400002)(53546011)(122000001)(38070700005)(38100700002)(83380400001)(86362001)(186003)(966005)(2616005)(6506007)(41300700001)(6486002)(71200400001)(26005)(6512007)(478600001)(110136005)(54906003)(66476007)(66946007)(36756003)(5660300002)(91956017)(66446008)(64756008)(8676002)(8936002)(66556008)(76116006)(4326008)(31686004)(2906002)(316002)(31696002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXpvT093TXEyREtTNVU4WFFVaVRSWmw3R1krNXpKQXo0Uk5KSnBvcDlkZHp1?=
 =?utf-8?B?d2lhWkxRNlliSENvUHV6MWl2Vno1ZUdpcGtvUGo4ejJaSVpjRlRBbUhOaWtD?=
 =?utf-8?B?K1Y1eUFxakt5bDdwVEh4WVJIOVJoS2taZHlJSEF1RHkrQmNQMVBUREhBZlJm?=
 =?utf-8?B?cXcyQkxWMWVOdUMwWUlPbTVSaWNLR3NSNTNETllzOC9CWVZvNTRWYVJIeVFM?=
 =?utf-8?B?QUF4WWxPeVZiTnIxaXVxaGYxN1EzcGVkb05Dd3lNVFlzcjEwOVo2OW1lY0Iy?=
 =?utf-8?B?R0NOc09ldnRHOUExcU5uZGZ5clFLMldKUUhzQldwZHpsczl4VVFtdWloOERp?=
 =?utf-8?B?bjRkeTJNdGQ2U29jSStacGpsNDlwVmVCamhheU9RSTE4dEgyQ0hONmx6d0Jx?=
 =?utf-8?B?dWlkbzRXOFZISm1CdE13Z3ZwY0FabGxkMXI1d3d3T3dtZWZHZVpOV1RrMjNl?=
 =?utf-8?B?dlcwc2p0bythQlR5cCtzUmV5eUdaWkluVDhrdnhkRGJ5dHI1MkVTSytHaWRB?=
 =?utf-8?B?VDhoRmY1K2hxSWVDRTIrdVJaUjVlUmVLdk1oVy9IUlQyMTJKcEpRUmxwV0lM?=
 =?utf-8?B?UUlSUlZGM3ZnV0JEeGJQZER6TE9NZ3FQSEJzN3UzRC9XaUhXdzhOUGV5Y0xS?=
 =?utf-8?B?QnZLblM2eUZadWtEaWdJVkd1WUhDT1g1VEx0clVORUVJNGJseTUrRDBRK2ox?=
 =?utf-8?B?cHBxVzhjT0xMcG1GcWdUa1pwSFZaVzdyMHozNHRBQWFId3RaL1pkYjZOZmlx?=
 =?utf-8?B?bjFjdkd4QWc2SW81OFA0WWhPWGNGU0M1ZEJzMkRQbGpxSXFEOGM3c2lEQW5z?=
 =?utf-8?B?N2toVHk2elZUUVE0SUU1MVNNSmpTODRib0FXUitlWktNeWZMd0hXSy9XZlZF?=
 =?utf-8?B?K1ViU2NST1dQOFAzaEhaQU8yWXNrSWx6QnFKY1I1SmhVbFpZUGg5eWtqbytz?=
 =?utf-8?B?SXA3R1lpRXUzN1JHWERaOUJoWkJMZ1A3RXNZWm5RNXRkUDJ3MHZBSFlVTXRT?=
 =?utf-8?B?OUtTRW5vS01CRWZFM05yQWw4dWo1RGp5UEx2RlpsOVhrS2Y3bTYvNHZ2K0Rn?=
 =?utf-8?B?emVrc0UrY2pqSzM2T3NWRnpBK3VpV1cyNlFYc1FOTWdvdGIrRU11UDNKWTRO?=
 =?utf-8?B?OTdWVFRETVBUbFNDMFk5R2swN1NvQ3RzbGVvTjJrQ2V0TWdCNEQyTWRMVnpP?=
 =?utf-8?B?VnhjNFlJamVLelhDbDMvQTZBeXY5dVcvU3hkZEVlNlF0Ty8yZ3BNS2JCMGNz?=
 =?utf-8?B?Vm5CYllOS0g3UWYybXNqcUVMU2J1cDdYTllxbmVPTEJCb1h2RFpld0NEMmVC?=
 =?utf-8?B?Q1lPZFpTTDl6dm9Yb3FPUzZzNDZ2SmVNd1JIQkJkQXNLVmN6TWZMRkthbXpL?=
 =?utf-8?B?ZWtSTEZ2TS9PMDU3cWxwWFFmMG83a0hwdDJWN1hxMjVjak51TG5Ec3JRcXJ3?=
 =?utf-8?B?OW0xWHA5M295d3g1M0duZ3pnVzhzZDk1QTJtMTk2VmlYOEZKTWozZzY1MXEv?=
 =?utf-8?B?UWl0ZEF0aGl0Q1ExMHNob0Y0UFBwdlF4WmtubDkzSEc3bmNOOVRCbzJGcHln?=
 =?utf-8?B?VjAzN1RwZ2xHWmJLZjBBOVhyTStEUksyR1hLL1RDRlAzTkc4dTE2NDk4RnZq?=
 =?utf-8?B?cGJtZGpnbTZjcFFIZ3Y5MzhEM3BFQnR3QlhHQkxnUjNITGJPWVFqeGZxK1hK?=
 =?utf-8?B?Q1hldlI3VzQvQityS2hQaFJtek14RmlFUTVOS3Q1ejFWODhWeVhRZ2FnZEJD?=
 =?utf-8?B?U0RCd0FRdmZkQ1NhODN4ajlrYVM5ejkraVl4ZGlGVnB3UHlOT1k2NVNYWThI?=
 =?utf-8?B?Zml1a25qMUtKRzZYc2pscy9UU0YwdVArV1M4dE9MZGo0Z3djdVZ1Nmh5eWdZ?=
 =?utf-8?B?WnBOb2ROTUIwYklwNW1vWVBmb0RiTGc2VzE4U3hqdzhsNmJDdlhRVWcvSHdp?=
 =?utf-8?B?L1QwWGR4MGFpVjVKU2IvcEUyN0N5TnZDV3hxcXRwVFdlbWdUa1MyMk5SL0tV?=
 =?utf-8?B?ekhvV3lHM0tGeGwrTk9iS1JIMFlwaDZzVFp5bk1Ea1dCV3dhMVA3QVJ1SGdK?=
 =?utf-8?B?Rk9VS3pwRnVsUWlCYkw0S3VodnVteHhxa21weVlSOHM1ajEvV1ZCQ0tGV0Vx?=
 =?utf-8?Q?5AYWLVOi3DY8VlKj6mNfKR5/K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B7F4B8FE83C014CB96591096C0E230B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523c2ace-86df-4bf9-70b7-08da6faa5c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 08:31:11.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZ6B0itfZmnJJDuF+S22ZgK31I3g1mJVjWkmGfvRIcrLPcwUsLThrcCv74ISg+BGVEi/IPJlFoDPVQQlPQwxYNZwDkbz0OslrflBkp/UQy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2684
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDcvMjAyMiAwNTozOCwgQW51cCBQYXRlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJZGVudGlmeWluZyB0aGUgdW5kZXJseWluZyBSSVND
LVYgaW1wbGVtZW50YXRpb24gY2FuIGJlIGltcG9ydGFudA0KPiBmb3Igc29tZSBvZiB0aGUgdXNl
ciBzcGFjZSBhcHBsaWNhdGlvbnMuIEZvciBleGFtcGxlLCB0aGUgcGVyZiB0b29sDQo+IHVzZXMg
YXJjaCBzcGVjaWZpYyBDUFUgaW1wbGVtZW50YXRpb24gaWQgKGkuZS4gQ1BVSUQpIHRvIHNlbGVj
dCBhDQo+IEpTT04gZmlsZSBkZXNjcmliaW5nIGN1c3RvbSBwZXJmIGV2ZW50cyBvbiBhIENQVS4N
Cj4gDQo+IEN1cnJlbnRseSwgdGhlcmUgaXMgbm8gd2F5IHRvIGlkZW50aWZ5IFJJU0MtViBpbXBs
ZW1lbnRhdGlvbiBzbyB3ZQ0KPiBhZGQgbXZlbmRvcmlkLCBtYXJjaGlkLCBhbmQgbWltcGlkIHRv
IC9wcm9jL2NwdWluZm8gb3V0cHV0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW51cCBQYXRlbCA8
YXBhdGVsQHZlbnRhbmFtaWNyby5jb20+DQo+IFJldmlld2VkLWJ5OiBIZWlucmljaCBTY2h1Y2hh
cmR0IDxoZWlucmljaC5zY2h1Y2hhcmR0QGNhbm9uaWNhbC5jb20+DQo+IFRlc3RlZC1ieTogTmlr
aXRhIFNodWJpbiA8bi5zaHViaW5AeWFkcm8uY29tPg0KDQpSZWFkIGJhY2sgdGhlIGJvcmluZyB6
ZXJvcyBvbiBwb2xhcmZpcmUsIGlmIG9ubHkgSSBjb3VsZCB3cml0ZSBhDQpwYXRjaCBmb3IgdGhl
IGNvcmUgY29tcGxleC4uDQoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xl
eUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAgIC0gVXNl
IElTX0VOQUJMRUQoKSB0byBjaGVjayBDT05GSUcgZGVmaW5lcw0KPiAgIC0gQWRkZWQgUkIgYW5k
IFRCIHRhZ3MgaW4gY29tbWl0IGRlc2NyaXB0aW9uDQo+IC0tLQ0KPiAgIGFyY2gvcmlzY3Yva2Vy
bmVsL2NwdS5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3Yva2VybmVsL2NwdS5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmMNCj4gaW5k
ZXggZmJhOWU5ZjQ2YThjLi4wNGJjYzkxYzkxZWEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3Yv
a2VybmVsL2NwdS5jDQo+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdS5jDQo+IEBAIC0zLDEw
ICszLDEzIEBADQo+ICAgICogQ29weXJpZ2h0IChDKSAyMDEyIFJlZ2VudHMgb2YgdGhlIFVuaXZl
cnNpdHkgb2YgQ2FsaWZvcm5pYQ0KPiAgICAqLw0KPiANCj4gKyNpbmNsdWRlIDxsaW51eC9jcHUu
aD4NCj4gICAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9zZXFf
ZmlsZS5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiArI2luY2x1ZGUgPGFzbS9jc3Iu
aD4NCj4gICAjaW5jbHVkZSA8YXNtL2h3Y2FwLmg+DQo+ICsjaW5jbHVkZSA8YXNtL3NiaS5oPg0K
PiAgICNpbmNsdWRlIDxhc20vc21wLmg+DQo+ICAgI2luY2x1ZGUgPGFzbS9wZ3RhYmxlLmg+DQo+
IA0KPiBAQCAtNjQsNiArNjcsNTAgQEAgaW50IHJpc2N2X29mX3BhcmVudF9oYXJ0aWQoc3RydWN0
IGRldmljZV9ub2RlICpub2RlKQ0KPiAgIH0NCj4gDQo+ICAgI2lmZGVmIENPTkZJR19QUk9DX0ZT
DQo+ICsNCj4gK3N0cnVjdCByaXNjdl9jcHVpbmZvIHsNCj4gKyAgICAgICB1bnNpZ25lZCBsb25n
IG12ZW5kb3JpZDsNCj4gKyAgICAgICB1bnNpZ25lZCBsb25nIG1hcmNoaWQ7DQo+ICsgICAgICAg
dW5zaWduZWQgbG9uZyBtaW1waWQ7DQo+ICt9Ow0KPiArc3RhdGljIERFRklORV9QRVJfQ1BVKHN0
cnVjdCByaXNjdl9jcHVpbmZvLCByaXNjdl9jcHVpbmZvKTsNCj4gKw0KPiArc3RhdGljIGludCBy
aXNjdl9jcHVpbmZvX3N0YXJ0aW5nKHVuc2lnbmVkIGludCBjcHUpDQo+ICt7DQo+ICsgICAgICAg
c3RydWN0IHJpc2N2X2NwdWluZm8gKmNpID0gdGhpc19jcHVfcHRyKCZyaXNjdl9jcHVpbmZvKTsN
Cj4gKw0KPiArI2lmIElTX0VOQUJMRUQoQ09ORklHX1JJU0NWX1NCSSkNCj4gKyAgICAgICBjaS0+
bXZlbmRvcmlkID0gc2JpX3NwZWNfaXNfMF8xKCkgPyAwIDogc2JpX2dldF9tdmVuZG9yaWQoKTsN
Cj4gKyAgICAgICBjaS0+bWFyY2hpZCA9IHNiaV9zcGVjX2lzXzBfMSgpID8gMCA6IHNiaV9nZXRf
bWFyY2hpZCgpOw0KPiArICAgICAgIGNpLT5taW1waWQgPSBzYmlfc3BlY19pc18wXzEoKSA/IDAg
OiBzYmlfZ2V0X21pbXBpZCgpOw0KPiArI2VsaWYgSVNfRU5BQkxFRChDT05GSUdfUklTQ1ZfTV9N
T0RFKQ0KPiArICAgICAgIGNpLT5tdmVuZG9yaWQgPSBjc3JfcmVhZChDU1JfTVZFTkRPUklEKTsN
Cj4gKyAgICAgICBjaS0+bWFyY2hpZCA9IGNzcl9yZWFkKENTUl9NQVJDSElEKTsNCj4gKyAgICAg
ICBjaS0+bWltcGlkID0gY3NyX3JlYWQoQ1NSX01JTVBJRCk7DQo+ICsjZWxzZQ0KPiArICAgICAg
IGNpLT5tdmVuZG9yaWQgPSAwOw0KPiArICAgICAgIGNpLT5tYXJjaGlkID0gMDsNCj4gKyAgICAg
ICBjaS0+bWltcGlkID0gMDsNCj4gKyNlbmRpZg0KPiArDQo+ICsgICAgICAgcmV0dXJuIDA7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgX19pbml0IHJpc2N2X2NwdWluZm9faW5pdCh2b2lkKQ0K
PiArew0KPiArICAgICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICAgICByZXQgPSBjcHVocF9zZXR1
cF9zdGF0ZShDUFVIUF9BUF9PTkxJTkVfRFlOLCAicmlzY3YvY3B1aW5mbzpzdGFydGluZyIsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmlzY3ZfY3B1aW5mb19zdGFydGluZywg
TlVMTCk7DQo+ICsgICAgICAgaWYgKHJldCA8IDApIHsNCj4gKyAgICAgICAgICAgICAgIHByX2Vy
cigiY3B1aW5mbzogZmFpbGVkIHRvIHJlZ2lzdGVyIGhvdHBsdWcgY2FsbGJhY2tzLlxuIik7DQo+
ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAg
IHJldHVybiAwOw0KPiArfQ0KPiArZGV2aWNlX2luaXRjYWxsKHJpc2N2X2NwdWluZm9faW5pdCk7
DQo+ICsNCj4gICAjZGVmaW5lIF9fUklTQ1ZfSVNBX0VYVF9EQVRBKFVQUk9QLCBFWFRJRCkgXA0K
PiAgICAgICAgICB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCj4gICAgICAgICAgICAgICAgICAudXByb3AgPSAjVVBST1AsICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQo+IEBAIC0xNzgsNiArMjI1LDcgQEAgc3RhdGljIGlu
dCBjX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KQ0KPiAgIHsNCj4gICAgICAgICAg
dW5zaWduZWQgbG9uZyBjcHVfaWQgPSAodW5zaWduZWQgbG9uZyl2IC0gMTsNCj4gICAgICAgICAg
c3RydWN0IGRldmljZV9ub2RlICpub2RlID0gb2ZfZ2V0X2NwdV9ub2RlKGNwdV9pZCwgTlVMTCk7
DQo+ICsgICAgICAgc3RydWN0IHJpc2N2X2NwdWluZm8gKmNpID0gcGVyX2NwdV9wdHIoJnJpc2N2
X2NwdWluZm8sIGNwdV9pZCk7DQo+ICAgICAgICAgIGNvbnN0IGNoYXIgKmNvbXBhdCwgKmlzYTsN
Cj4gDQo+ICAgICAgICAgIHNlcV9wcmludGYobSwgInByb2Nlc3Nvclx0OiAlbHVcbiIsIGNwdV9p
ZCk7DQo+IEBAIC0xODgsNiArMjM2LDkgQEAgc3RhdGljIGludCBjX3Nob3coc3RydWN0IHNlcV9m
aWxlICptLCB2b2lkICp2KQ0KPiAgICAgICAgICBpZiAoIW9mX3Byb3BlcnR5X3JlYWRfc3RyaW5n
KG5vZGUsICJjb21wYXRpYmxlIiwgJmNvbXBhdCkNCj4gICAgICAgICAgICAgICYmIHN0cmNtcChj
b21wYXQsICJyaXNjdiIpKQ0KPiAgICAgICAgICAgICAgICAgIHNlcV9wcmludGYobSwgInVhcmNo
XHRcdDogJXNcbiIsIGNvbXBhdCk7DQo+ICsgICAgICAgc2VxX3ByaW50ZihtLCAibXZlbmRvcmlk
XHQ6IDB4JWx4XG4iLCBjaS0+bXZlbmRvcmlkKTsNCj4gKyAgICAgICBzZXFfcHJpbnRmKG0sICJt
YXJjaGlkXHRcdDogMHglbHhcbiIsIGNpLT5tYXJjaGlkKTsNCj4gKyAgICAgICBzZXFfcHJpbnRm
KG0sICJtaW1waWRcdFx0OiAweCVseFxuIiwgY2ktPm1pbXBpZCk7DQo+ICAgICAgICAgIHNlcV9w
dXRzKG0sICJcbiIpOw0KPiAgICAgICAgICBvZl9ub2RlX3B1dChub2RlKTsNCj4gDQo+IC0tDQo+
IDIuMzQuMQ0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1yaXNjdkBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtcmlzY3YNCg0K
