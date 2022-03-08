Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2004D120F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbiCHIWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245265AbiCHIWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:22:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CEA3F304
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646727665; x=1678263665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NfWFL/orLX0h1N7O8Kalg21Xx0P7odcNaagk/MTds6w=;
  b=KxJqUvsWUA/Nc+3h7ii9Z8MP7PG8XiJeMYbSmKlN0XCjrNGTBqnKHbXA
   eCBEWPqlwfHgvOfpSYHqdrUwUX1t4M8t9p2ZzVfzSmJHwXRseE0k37ERt
   v5kuThBpFPa4XoTn6CbuksI9C0IH1JVJq+jfISMYEuE0H8HeucAc87F2N
   IQORJtEZzlgcLmbqAb+Ixa9VuqrdgAzEppTU3kugPIqkkD3QC/z1M8dRS
   lisIDepa2MGRUNzmogE36Vu7Erf/DCtXvngYF00y8hi6CODtLJ8En7Uh2
   ZjiyyATE0OvaZ+08qGu1zliO7hP/tFflZ6fAw+HXrSzZVwTu5lab+xlLN
   A==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643698800"; 
   d="scan'208";a="164897291"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 01:21:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 01:21:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 8 Mar 2022 01:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q39Q/Gh+A6D3gDQSh6i2fAe1Vg9ontJmEIQvVzjCjR7HNVOmkTG2mFH/gik3iLlA3MprKqsJh5skZZmJ1PEMrQGl0GPpEUApmgP+fBAMxRwEIlAEEMMpmgcaHwfEIYJUpR2mvIRsAboOHOVh5nvgnbDPrluHQu1vzej0RHpSOLGNHlt+GGRuwosWhyOtUk5or+GFwYV4LT83vjBzw8wo7tVWH1M1MBY/awYU50lkgHUO2V7N5FSYuWeuG3JaVRpQFyaBgta/hROOmloOzBONxyG4lCG3skHHNS1X3Rd0wtRFAJTqTbPQXpIApWW6v2hNvQaYdTA/rNaPxhXqNKr+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfWFL/orLX0h1N7O8Kalg21Xx0P7odcNaagk/MTds6w=;
 b=SfwxAq3V4Q+ThjJ51E1TNR8dXhoCJod7d46hqd/lsVs9g3cT817XJ3Cdf37w7EVjr88bK4DmSQ7aF9esCRPgdglz7n3bypSeNKs7piCKK5hpb3wRg3XTPc0TvaQ20AbXphoJTH2aErdFpLW7RgizpMXY2YONd2xw5eCIH4wd5hosegCuB8KsYqzU2e2ulWi2wq3UJjAojCnvR4Vl4tx9JpdkLCyFup8uBZyL3w9dMCjLADiCOZ9VBHaxih8sjE+R/W2mk6h2xIGjL3w2mfY6rHnI7oRldC6WEN4BcP8vDishSUADK+ncer+vRlXsKWBiOdof5oyFLBbDHEaRHW+cAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfWFL/orLX0h1N7O8Kalg21Xx0P7odcNaagk/MTds6w=;
 b=EM2xt9S7cRcijkdAmmexlL9AzYxb5p6ST2HBreTucG+oBv8zsGfna1flq0DzKPZNx9b+mkA+G8aMkUpJxDv6de2TqQ1APjW+PTgXW6xSgpC5oHJzgqcnFzTLojIQVRxEFkJropDXtl5NTiHKe38SSFZRPNSkA5B0Jlwg23tPTbg=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by SN6PR11MB2960.namprd11.prod.outlook.com (2603:10b6:805:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Tue, 8 Mar
 2022 08:21:01 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 08:21:01 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <clement.leger@bootlin.com>, <linux@armlinux.org.uk>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/2] ARM: at91: pm: add support for sama5d2 secure
 suspend
Thread-Topic: [PATCH v2 2/2] ARM: at91: pm: add support for sama5d2 secure
 suspend
Thread-Index: AQHYMsVx8HwDNHnwxUS/LKJ3M0lAkg==
Date:   Tue, 8 Mar 2022 08:21:01 +0000
Message-ID: <2177abd0-f25d-c82a-ec5a-7f2654352d25@microchip.com>
References: <20220307101550.95538-1-clement.leger@bootlin.com>
 <20220307101550.95538-3-clement.leger@bootlin.com>
In-Reply-To: <20220307101550.95538-3-clement.leger@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1491cf53-3b00-443b-e698-08da00dc94cd
x-ms-traffictypediagnostic: SN6PR11MB2960:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2960FFE50E952A3EFFF4085587099@SN6PR11MB2960.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzOfjDbiE4fTavm9fMVY3TOS+7dWNt4Wl6IqwnDlxEQjT7PAVXnoSbU3KsrAzNXLfC1rHkJfCs0sPiuED7iLsHjvyZfVRM4DYwJYKDT7inrW0yPkQ2M0J4NaYIzslgEJN7/fgKa+ltkVWxjx+V914fpAmA97EKK9a/9UqVwgagh8RdzOt7jKVXhia3dVBFSau5waQHNbHz0+cyP4cuIl7SOgx0iKP6Wp+Q5WlcySg5TiCydEG/ZbJVP71kS8juRXyOlbKa+Le0z79tJhxM084w6WD8EzUO3SI1y+eQX3yssANEKCzmoN8hnBaBDNXk8qW511beWCy+WalxbgEa5ki+AEn39IS9/10o3h6uFuK7+yPsZ4NQW2xicDpFlblPuHgD5a7J1qD+IF4rCr6QNkCpE1jGBdAF+SDSU6gx99f3btZbvSpnf3+4ipUICNxdLuJ70echqW7LTx1wbzrkbbbknxiwXSCvpMqc5dLM8amHhnvDG4aYfPNTd89UWEvkOnKm1gsAKoNDi2+TsG3TzGdS69Et4kXFV1IdOEe2ue8dJ5CEQkhRgY67kZbC4f2I/L2er59qJjhDVdFzT1N7G2tOvHVEq+vHmLdpoSfqL+Kb+W7io1Us9utQqZfTa+zgFsF90F7YJCskRVZPLr+rpiT9hmiAb87oua2FfTIrQ1gdgT/j639hgIgwZzjlxOgZz9jVDDgpki485iM+LlY4JR/kk0Ihj0Pc3+ukPi7JTSBIFEyuBrnE5in4COj29msb50ThPGcJyXK5nwaH1xXWASGtxrM0AFO5S6hPCx5/MJAlYlYelmhATnixCSvg16stL/RurA+t7fBrQE6AaiLKknOg+2PC3o5607zu55ECb5j5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(53546011)(508600001)(5660300002)(38070700005)(31696002)(76116006)(4326008)(86362001)(71200400001)(6506007)(15650500001)(83380400001)(966005)(6486002)(316002)(8676002)(36756003)(66946007)(64756008)(66556008)(66476007)(66446008)(66574015)(122000001)(38100700002)(186003)(26005)(2616005)(6636002)(54906003)(6512007)(110136005)(8936002)(31686004)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE41Nk5pVGJiNDJ2emdMNmlxZytSaUVoUVNMWWhjNndZOFgySDlBTUhkd2dq?=
 =?utf-8?B?a09TQXMxU1Z4eUE1UXFtVnJUMlJxMmZmT2pVeVA5N1hPVDJFRmhUTkJEdzNM?=
 =?utf-8?B?ZlY4ZTB6MUduaDdPQk0wVmpseXQ1TU0xNjJBZktPZmN6Zm50QXVJRXEzTHgx?=
 =?utf-8?B?T0NuQkhTd1lCNVZielVEdFFBNDl6U3cyZ2lJZmtSTi81SlZLb0Z5dmFvcGZ6?=
 =?utf-8?B?NFdjUEQ1N1gyK3EvSW5ZNXlHUnlpUTFWQld4RXFScVhOVzl1ZWlRbU1UN3RH?=
 =?utf-8?B?dlo2Y0dkRjgvclp0Qm5GcTdZVURESzZaKzNVWWV1MFQ2UFltMUx4OXdZRnZv?=
 =?utf-8?B?L1dVbC9rUklvcmhiVStWb3VQSHZWSUcyOVhUN1UvU1dZTlJXWmJmMWNvMVA0?=
 =?utf-8?B?MVBKb25DSVZTTHhRTUlXS0VrM20rcjFCL0RIVmwwdTE4ZmdXc2FFRjNBVVow?=
 =?utf-8?B?QnlNSHZVQnQ0K3o0TTRnU0tmK2ZkRUNvYWxHc2hrcWMrUnZyRmRIT3lzbHFN?=
 =?utf-8?B?cGhTakJ4TXRQNkEyMDRFcm0rYysxUzhxalRXZEtlemV2eW1sZGYzSGFRM0xY?=
 =?utf-8?B?WVRZcG4yUVVxTXdFL2xlbGJEQmc5UFJKcGRxNkhMV0dwS0s5d0JLZG9mMG9X?=
 =?utf-8?B?SXdjSE0rWk45K3dmU0RDd3A2TVBpRzBveHpQRWZCblFjQk43NzFnSmUvWEVV?=
 =?utf-8?B?M3JNcHhWaEV1YitNZ2w5UUdEWUZuL011R3pEeDlOQ1BzTGtjQmNxWFBwaGZ2?=
 =?utf-8?B?UmZKblJubXFrNThRQmdzaWFRb1p6VldSSzAyM1pJL0hpTXZ3bkkvRnNHZUVN?=
 =?utf-8?B?S1hlQ3JWS1FSdWV3ZzFBV3N4V3FlM0xta05wUEtUYjZoeTkwQTVIb0F0SUtE?=
 =?utf-8?B?bjR5TEprbENqbG92NVRob01aczF2SWZRRUZSNlBDd0R2UXNob0x4WVNBWVFl?=
 =?utf-8?B?WThNNHRHTGJIMG1mY0FlNGF2aThaZngyQko3M0QxRGhNUVVCN044WEZvU1dM?=
 =?utf-8?B?clk5ejZLM2phTVFlMmhxZ3VFcmpiYVpaNFZKcnFPVmUvWllOR2ZNNHdyNUl0?=
 =?utf-8?B?aWx0bi9pVG9YdUNmSHpwM2JBQ090dVJmSHdadTU1Nm1XM0owMXB6MEI4RUhK?=
 =?utf-8?B?dytvTGNYNTFtQnpDcFYwdnFSNUhEYzFYNzI1SjBFUWVvRDBlUjVNYng2aDVi?=
 =?utf-8?B?NFFEYWR3MXVJb3RteHNRK1g3KzVxZVNMRU4vNWpMTmZUUGcyV0I0bGxFdFZT?=
 =?utf-8?B?a3N3NEdjQXUzUzlvU0Uxd2RqV1cyR3VobXlqZGYvbTNhS01YZGNFam1obXda?=
 =?utf-8?B?dHU1QVhsc2JKWjFBYytOWE5YSUtlMkdiN2YwY05md2tmdlVDdFNUa2RDRzZZ?=
 =?utf-8?B?MjU0bUVBWU41djQ1cUg2K2Uzc3hJTmlmTHdxajdrd0JpQk92S1kxTFh4TURE?=
 =?utf-8?B?bTBrNWsxQytLRlE1ODlMdDlvaUJyQnp5LzNzbWNHZVRNRFpzZjE2cTZtV0JL?=
 =?utf-8?B?eU5MZ1M5czdINmRUYWtaanhpUnRxeC9Hc0Z1cU4zbVZacGlGWW9aVkpsMjB2?=
 =?utf-8?B?aWF2WFJNZmZZcWpPdEdGRExuKzl3R3drUTRsZUJRUktYM1RjQWcvUHh3MEdz?=
 =?utf-8?B?TTRHSkFtM1hDK0R3WC9xTmdTTlU3Nk9UQWV6Y05jL2pleGxGOXkvclhHYUZP?=
 =?utf-8?B?UzBCMUJRNVdTUzNMUER0QnZERlgwdm5qTTJFTW01Q3ozaTlabkhVdDQ3TmZp?=
 =?utf-8?B?MzR5V2s4czVFWC9qQld0MElFUzFOUTZ3NDRtZlhwYTBvYzh5OURQOEZ1NWZ4?=
 =?utf-8?B?Z1gzWkJoOW1qa2FvdisvRDU5NkpPSm9HeXBLNmFPaTEzMlc3T3ZlejhDQXV4?=
 =?utf-8?B?VUkzaGZQZWhaNlZsVytyRC9KOFNVbG9weXFlbEhNekV0OGFPcnFwRUdPbThD?=
 =?utf-8?B?RjFJWWREUkxHU003MnNoSFBTVTlVc05lMFBaYkJQOFVnSDdoWE9qYmdVc01N?=
 =?utf-8?B?bXlUYjVHc1V6djdtVnQzZE1vZlhDVG42bUtyV3V5Qkp6RDBHMXUrMTk0eXVS?=
 =?utf-8?B?YStObkdmM2pSaUMxK0FVc01udkNyNno2ZG1tb0hra1J0VUdOU2RzdTVicjhG?=
 =?utf-8?B?WG43c3pzZVJodGVTWHgyN054MDVOMzlRZVhLK2NLTEM3SjIrVFFheEh5U05v?=
 =?utf-8?B?Wm40cW04QkYrZlZnYVZHK2JmUDNlKzBtcGdMUHZsZGRNb3gyRzJndFF5SWgz?=
 =?utf-8?B?WjlJVU00UzBnNW5yY2RJZjNURm1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4ECAAE875B1CA40ABF995F7CD460CF5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1491cf53-3b00-443b-e698-08da00dc94cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 08:21:01.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTxFUGRBt26ldhJPVXCw+31CHEkQlfna/T+rfoWITYMyS7L6pQpu/8LDUv4KqJNZQ5kbEpJ6HPNa5Kj7DdxZ653LJxauc4ETtMJGl3sIxIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2960
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2zDqW1lbnQsDQoNCk9uIDA3LjAzLjIwMjIgMTI6MTUsIENsw6ltZW50IEzDqWdlciB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBXaGVuIHJ1bm5p
bmcgd2l0aCBPUC1URUUsIHRoZSBzdXNwZW5kIGNvbnRyb2wgaXMgaGFuZGxlZCBzZWN1cmVseS4N
Cj4gU3VzcGVuZCBjYW4gYmUgZW50ZXJlZCB1c2luZyBQU0NJIHN1cHBvcnQuIFNpbmNlIHRoZSBz
YW1hNWQyIHN1cHBvcnRzDQo+IG11bHRpcGxlIHN1c3BlbmQgbW9kZXMsIGFkZCBhIG5ldyBDT05G
SUdfQVRNRUxfU0VDVVJFX1BNIHdoaWNoIHdpbGwNCj4gc2VuZCBhIFNNQyBjYWxsIHRvIHNlbGVj
dCB0aGUgc3VzcGVuZCBtb2RlIGF0IGluaXQgdGltZS4NCj4gDQo+ICJhdG1lbC5wbV9tb2RlcyIg
Ym9vdCBhcmd1bWVudCBpcyBzdGlsbCBzdXBwb3J0ZWQgZm9yIGNvbXBhdGliaWxpdHkNCj4gcHVy
cG9zZXMgYnV0IHRoZSBzdGFuZGJ5IHZhbHVlIGlzIGFjdHVhbGx5IGlnbm9yZWQgc2luY2UgUFND
SSBzdXNwZW5kDQo+IGlzIHVzZWQgYW5kIGl0IG9ubHkgc3VwcG9ydCBvbmUgbW9kZSAoc3VzcGVu
ZCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBMw6lnZXIgPGNsZW1lbnQubGVnZXJA
Ym9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1hdDkxL0tjb25maWcgICAgICB8
IDEyICsrKysrKysrKystDQo+ICBhcmNoL2FybS9tYWNoLWF0OTEvcG0uYyAgICAgICAgIHwgMzgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL2FybS9tYWNoLWF0OTEv
c2FtX3NlY3VyZS5oIHwgIDQgKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1hdDkx
L0tjb25maWcgYi9hcmNoL2FybS9tYWNoLWF0OTEvS2NvbmZpZw0KPiBpbmRleCAwMmY2YjEwOGZk
NWQuLjVhNmNhMzhkNjMwMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1hdDkxL0tjb25m
aWcNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1hdDkxL0tjb25maWcNCj4gQEAgLTIwOCw3ICsyMDgs
MTcgQEAgY29uZmlnIFNPQ19TQU1BNQ0KPiAgICAgICAgIHNlbGVjdCBTUkFNIGlmIFBNDQo+IA0K
PiAgY29uZmlnIEFUTUVMX1BNDQo+IC0gICAgICAgYm9vbA0KPiArICAgICAgIGJvb2wgIkF0bWVs
IFBNIHN1cHBvcnQiDQo+ICsNCj4gK2NvbmZpZyBBVE1FTF9TRUNVUkVfUE0NCj4gKyAgICAgICBi
b29sICJBdG1lbCBTZWN1cmUgUE0gc3VwcG9ydCINCj4gKyAgICAgICBkZXBlbmRzIG9uIFNPQ19T
QU1BNUQyICYmIEFUTUVMX1BNDQo+ICsgICAgICAgc2VsZWN0IEFSTV9QU0NJDQo+ICsgICAgICAg
aGVscA0KPiArICAgICAgICAgV2hlbiBydW5uaW5nIHVuZGVyIGEgVEVFLCB0aGUgc3VzcGVuZCBt
b2RlIG11c3QgYmUgcmVxdWVzdGVkIHRvIGJlIHNldA0KPiArICAgICAgICAgYXQgVEVFIGxldmVs
LiBXaGVuIGVuYWJsZSwgdGhpcyBvcHRpb24gd2lsbCB1c2Ugc2VjdXJlIG1vbml0b3IgY2FsbHMN
Cj4gKyAgICAgICAgIHRvIHNldCB0aGUgc3VzcGVuZCBsZXZlbC4gUFNDSSBpcyB0aGVuIHVzZWQg
dG8gZW50ZXIgc3VzcGVuZC4NCj4gKyAgICAgICAgIE5PVEU6IFRoaXMgc3VwcG9ydCBpcyBtdXR1
YWxseSBleGNsdXNpdmUgd2l0aCBDT05GSUdfQVRNRUxfUE0NCg0KVGhpcyBub3RlIG1heSBiZSBh
IGJpdCBjb25mdXNpbmcgYXMgQVRNRUxfU0VDVVJFX1BNIGRlcGVuZHMgb24gQ09ORklHX0FUTUVM
X1BNLg0KDQo+IA0KPiAgY29uZmlnIFNPQ19TQU1BNw0KPiAgICAgICAgIGJvb2wNCj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL21hY2gtYXQ5MS9wbS5jIGIvYXJjaC9hcm0vbWFjaC1hdDkxL3BtLmMN
Cj4gaW5kZXggZGQ2ZjRjZTNmNzY2Li5lNDA1MTU2OTE1NDAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtL21hY2gtYXQ5MS9wbS5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9wbS5jDQo+IEBA
IC0yNyw2ICsyNyw3IEBADQo+IA0KPiAgI2luY2x1ZGUgImdlbmVyaWMuaCINCj4gICNpbmNsdWRl
ICJwbS5oIg0KPiArI2luY2x1ZGUgInNhbV9zZWN1cmUuaCINCj4gDQo+ICAjZGVmaW5lIEJBQ0tV
UF9ERFJfUEhZX0NBTElCUkFUSU9OICAgICAoOSkNCj4gDQo+IEBAIC04NTYsNiArODU3LDM1IEBA
IHN0YXRpYyBpbnQgX19pbml0IGF0OTFfcG1fYmFja3VwX2luaXQodm9pZCkNCj4gICAgICAgICBy
ZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIGF0OTFfcG1fc2VjdXJlX2luaXQo
dm9pZCkNCj4gK3sNCj4gKyAgICAgICBpbnQgc3VzcGVuZF9tb2RlOw0KPiArICAgICAgIHN0cnVj
dCBhcm1fc21jY2NfcmVzIHJlczsNCj4gKw0KPiArICAgICAgIHN1c3BlbmRfbW9kZSA9IHNvY19w
bS5kYXRhLnN1c3BlbmRfbW9kZTsNCj4gKw0KPiArICAgICAgIHJlcyA9IHNhbV9zbWNjY19jYWxs
KFNBTUE1X1NNQ19TSVBfU0VUX1NVU1BFTkRfTU9ERSwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdXNwZW5kX21vZGUsIDApOw0KPiArICAgICAgIGlmIChyZXMuYTAgPT0gMCkgew0K
PiArICAgICAgICAgICAgICAgcHJfaW5mbygiQVQ5MTogU2VjdXJlIFBNOiBzdXNwZW5kIG1vZGUg
c2V0IHRvICVzXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBwbV9tb2Rlc1tzdXNwZW5k
X21vZGVdLnBhdHRlcm4pOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiArICAgICAgIH0N
Cj4gKw0KPiArICAgICAgIHByX3dhcm4oIkFUOTE6IFNlY3VyZSBQTTogJXMgbW9kZSBub3Qgc3Vw
cG9ydGVkICFcbiIsDQo+ICsgICAgICAgICAgICAgICBwbV9tb2Rlc1tzdXNwZW5kX21vZGVdLnBh
dHRlcm4pOw0KPiArDQo+ICsgICAgICAgcmVzID0gc2FtX3NtY2NjX2NhbGwoU0FNQTVfU01DX1NJ
UF9HRVRfU1VTUEVORF9NT0RFLCAwLCAwKTsNCj4gKyAgICAgICBpZiAocmVzLmEwID09IDApIHsN
Cj4gKyAgICAgICAgICAgICAgIHByX3dhcm4oIkFUOTE6IFNlY3VyZSBQTTogZmFpbGVkIHRvIGdl
dCBkZWZhdWx0IG1vZGVcbiIpOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiArICAgICAg
IH0NCj4gKw0KPiArICAgICAgIHByX2luZm8oIkFUOTE6IFNlY3VyZSBQTTogdXNpbmcgZGVmYXVs
dCBzdXNwZW5kIG1vZGUgJXNcbiIsDQo+ICsgICAgICAgICAgICAgICBwbV9tb2Rlc1tzdXNwZW5k
X21vZGVdLnBhdHRlcm4pOw0KPiArDQo+ICsgICAgICAgc29jX3BtLmRhdGEuc3VzcGVuZF9tb2Rl
ID0gcmVzLmExOw0KPiArfQ0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXRt
ZWxfc2hkd2NfaWRzW10gPSB7DQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1h
NWQyLXNoZHdjIiB9LA0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4
NjAtc2hkd2MiIH0sDQo+IEBAIC0xMTg4LDYgKzEyMTgsMTEgQEAgdm9pZCBfX2luaXQgc2FtYTVk
Ml9wbV9pbml0KHZvaWQpDQo+ICAgICAgICAgaWYgKCFJU19FTkFCTEVEKENPTkZJR19TT0NfU0FN
QTVEMikpDQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiArICAgICAgIGlmIChJU19F
TkFCTEVEKENPTkZJR19BVE1FTF9TRUNVUkVfUE0pKSB7DQo+ICsgICAgICAgICAgICAgICBhdDkx
X3BtX3NlY3VyZV9pbml0KCk7DQo+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ICsgICAgICAg
fQ0KPiArDQo+ICAgICAgICAgYXQ5MV9wbV9tb2Rlc192YWxpZGF0ZShtb2RlcywgQVJSQVlfU0la
RShtb2RlcykpOw0KPiAgICAgICAgIGF0OTFfcG1fbW9kZXNfaW5pdChpb21hcHMsIEFSUkFZX1NJ
WkUoaW9tYXBzKSk7DQo+ICAgICAgICAgcmV0ID0gYXQ5MV9kdF9yYW1jKGZhbHNlKTsNCj4gQEAg
LTEyNjIsNiArMTI5Nyw5IEBAIHN0YXRpYyBpbnQgX19pbml0IGF0OTFfcG1fbW9kZXNfc2VsZWN0
KGNoYXIgKnN0cikNCj4gICAgICAgICBzb2NfcG0uZGF0YS5zdGFuZGJ5X21vZGUgPSBzdGFuZGJ5
Ow0KPiAgICAgICAgIHNvY19wbS5kYXRhLnN1c3BlbmRfbW9kZSA9IHN1c3BlbmQ7DQo+IA0KPiAr
ICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19BVE1FTF9TRUNVUkVfUE0pKQ0KPiArICAgICAg
ICAgICAgICAgcHJfd2FybigiQVQ5MTogU2VjdXJlIFBNOiBpZ25vcmluZyBzdGFuZGJ5IG1vZGVc
biIpOw0KDQpXaGF0IGhhcHBlbnMgd2l0aCBzb2NfcG0uZGF0YS5zdGFuZGJ5X21vZGU/IENhbiBM
aW51eCBzdGlsbCBzdXNwZW5kIHRvIGl0Pw0KSWYgdGhhdCdzIHRoZSBjYXNlIHRoZW4gdGhlIHBy
b3BlciBkYXRhIGZvciBzdGFuZGJ5IG1vZGUgaXMgbm90IGluaXRpYWxpemVkDQphcyBzYW1hNWQy
X3BtX2luaXQoKSByZXR1cm5zIGlmIENPTkZJR19BVE1FTF9TRUNVUkVfUE0gaXMgZW5hYmxlZCwg
dGh1cw0Kc3lzdGVtIG1heSBoYW5nIGluIHN1Y2ggYSBjYXNlLiBJcyB0aGlzIGludGVuZGVkPw0K
DQpPdGhlcndpc2UsIG1heWJlIHRoaXMgcHJfd2FybigpIGNvdWxkIGJlIG1vdmVkIGluIHNhbWE1
ZDJfcG1faW5pdCgpIGFzDQpzYW1hNWQyIGlzIHRoZSBvbmx5IHVzZXIgYXQgdGhlIG1vbWVudC4N
Cg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiArDQo+ICAgICAgICAgcmV0dXJuIDA7
DQo+ICB9DQo+ICBlYXJseV9wYXJhbSgiYXRtZWwucG1fbW9kZXMiLCBhdDkxX3BtX21vZGVzX3Nl
bGVjdCk7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWF0OTEvc2FtX3NlY3VyZS5oIGIv
YXJjaC9hcm0vbWFjaC1hdDkxL3NhbV9zZWN1cmUuaA0KPiBpbmRleCAzNjAwMzY2NzJmNTIuLjFl
N2Q4YjIwYmExZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1hdDkxL3NhbV9zZWN1cmUu
aA0KPiArKysgYi9hcmNoL2FybS9tYWNoLWF0OTEvc2FtX3NlY3VyZS5oDQo+IEBAIC04LDYgKzgs
MTAgQEANCj4gDQo+ICAjaW5jbHVkZSA8bGludXgvYXJtLXNtY2NjLmg+DQo+IA0KPiArLyogU2Vj
dXJlIE1vbml0b3IgbW9kZSBBUElzICovDQo+ICsjZGVmaW5lIFNBTUE1X1NNQ19TSVBfU0VUX1NV
U1BFTkRfTU9ERSAweDQwMA0KPiArI2RlZmluZSBTQU1BNV9TTUNfU0lQX0dFVF9TVVNQRU5EX01P
REUgMHg0MDENCj4gKw0KPiAgdm9pZCBfX2luaXQgc2FtX3NlY3VyZV9pbml0KHZvaWQpOw0KPiAg
c3RydWN0IGFybV9zbWNjY19yZXMgc2FtX3NtY2NjX2NhbGwodTMyIGZuLCB1MzIgYXJnMCwgdTMy
IGFyZzEpOw0KPiANCj4gLS0NCj4gMi4zNC4xDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KDQo=
