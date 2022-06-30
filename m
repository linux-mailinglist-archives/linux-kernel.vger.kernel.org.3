Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4E5622FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiF3TUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiF3TUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:20:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA8D3F8BB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656616811; x=1688152811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vxXIJh80OxjVwv5zMHOfmwwiHYuAPZfkKb2eak7djAg=;
  b=yv68q0+2G3NQIWEk697WrEZk3vMaMWJUhPml0e0FCNzCMJffgjdr1hYx
   /n41ELKsTwqF2pkM6TB4h0oWrRuzw1HPuNAe4Y14jm8RrLxofuGrRXxj5
   KyzP4TsicoupZE8nRA1hXAg/XoajbYWW3W/I8n7gEcbGaL+RD9bh/AKyl
   0u+8Hqem0ri9BWme6P0TLu+CGHQ9I4ktxMkaz+AqpuISsTmDvX7cpFbSP
   VmVHKXiWjIFEkRgcy8thEUVIaMUabOphGCosC2cTm62azKb5pBEEfjibr
   ITTyIaTtELTRdwLWD4146WR7sOk1fgH3I1pgOZCzWedKNVdxJpja1WRiE
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="170308028"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 12:20:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 12:20:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 12:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBrgCccWKL6QU21uVc48R0vcjA9t4KH1vn3vR/+trG9f32sOlGt8seeo29k5g9t9sZ4v6AFo/SAL3U+aMmca4kKynFWWZaniumia+R02+7diTyq7yBx+rj3hbb3ZDrbyZQ/c8rUbih2P5sslpFO6BzI30KbzlEe2X+Z6ETq2q2JA6B4Ei0Gf94MDZ50volp5Hsup0bR5f94VqA4+X7b4Nx6gL6tDfUxOPRY5RGAoTcielleHScRfSPof6UGkvNgqMmvPbSr3An703f9N7hzFpxVHRtf7FBCk3JQv7G02ZeGkh7qhHIiHtAi3YhyMWzQfaWlqSpxy1cOCKxW4W2+AFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxXIJh80OxjVwv5zMHOfmwwiHYuAPZfkKb2eak7djAg=;
 b=Ro21huAMKlzKJGqUicxl3TqZRldjUwi5DFZqIbe+Nfk5gF3fI/DaG9n+9sJZVYVjZpXucsxnNP+LT/GlSLCioDBmTSCa1CLy+mLnAVnq53EOwLhNWsUBbHO4asEoL/r2tZQttYwZcemE73uKrqYjEcxqiPLCWBiFf09n46wZD43R+t8JSNKyOODsCu16wwtTVmhCiVn2h9e44fv4OocjfOgoVF4D0p0kIC2zcx4YjVLN2DHN0WlyJHQWeQAKyNlfz2S4IjnZggOwd6Oids2L/TJvFLr3xH4IaH/Kv5Tuj5uZy4mEP4z5k6FUnHQZwK5jMxvdL7KPv5y+SOUYH++BIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxXIJh80OxjVwv5zMHOfmwwiHYuAPZfkKb2eak7djAg=;
 b=IcBDSlBJR+Ge4ISWEc51cV+Mhmmb/+k7NQ8aKJ8hbHjCZFAPaTnx1dLMndkyNZCI2GzKU3BBbyCm4dNFkz5DOeiXSNWf+TM1FRME0cs91irkAXqd6uIARMZ8KCpqXclf5irwtrdNXtu38Tp3WKb4LtXeO0mB4S8Pp1eYM9MglSo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:20:04 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 19:20:04 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <Conor.Dooley@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <atishp@atishpatra.org>, <atishp@rivosinc.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEAgAAIIICAAAargIAAEAyAgAAEPgCAAAqJAIAAMFoAgAC8ZgCAAGP7gIAAEAqAgAAdSoA=
Date:   Thu, 30 Jun 2022 19:20:04 +0000
Message-ID: <3840dbf7-ca18-b7ab-4d7a-92c9305476fa@microchip.com>
References: <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184217.krzt6l7qadymbj6h@bogus>
 <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
 <20220629195454.vbsjvcadmukiunt7@bogus>
 <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
 <b2ab0ac1-bfef-5ba0-4ee5-15e604d8aa2e@microchip.com>
 <20220630103958.tcear5oz3orsqwg6@bogus>
 <9d9e80b8-17e2-b1d9-14fa-f1d8d7dfbd9a@microchip.com>
 <20220630173513.dyrrmjbpxzi3e6fe@bogus>
In-Reply-To: <20220630173513.dyrrmjbpxzi3e6fe@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1c3d0ba-0e6d-4755-952d-08da5acd8944
x-ms-traffictypediagnostic: DS7PR11MB6246:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFH0fwOVB6z28/82dixLjy9IT5a5WlylHt9rLiyDzXGFsGOCrXwottotZKyUQcAP4sTjNXwUmMzb92LWV4StKc08Il5icssn5U26/JmfUOWxz5ViaqHvRZX4yvMB+dd/x4AVHduuBQDE7WM8fMnfNiOHp+YeRR5gNvryyaptBtfQplwYp8nGe8xII4c1yH9jGfKb75UYymv5pbHAeLCpHWQimWIxK7ayMvoI3Ba2dNSOFGxMcwxlY5o6HUN7JDlJVaPUztgDAiZc7J+dTXwVaBMW/TNW9kN2d4DC/lR7A87VN6RgdFdqmptUgl/H6O2fRHk9orD950N0yXGPeY1bYAQbTQZmv9wft32aY0BLUDgrINUy+s8DllLDJvPiIsxqez8RyhYMzekyOOztahXsVtP+lm3GmyhIOI7q9xQOSDMbQ8J16Yd9aARUx+w220yJbq8xptsudXISIiISmXLeTinHItnCgQeABSzqVByesiq7pxBZlNi/MkiUL6jBTREvJIaEAAVt5/f8KVUxv1kQOVu6zFAH6sknh0SZCiC6Wu9HwMF1t0u1foD7In8TTDYm7CFyrpA55opDSBaY+V0eciPSc0FSDJM32ypkAdhpZrbTuhnqt49JKb30AUSHo7ekzjT0ZZKOcSB37E3XT2UjKTVuWyQzebAZVzHmt3exCfMsCRYEJOcEWdvJFXhzRl3aIdW7PzOoheaWuQOQ/RKXdpqW5exYP50D5yV8WvJSTd/wSAwwHcnt/y1P6eGhHrTCNu+p2an3msCDABpCeLkeIgzvTqm6lQa+A6ECG0lMD6y8qBT6rBfqZm7wy6HMmtupnXXMpQg63g7vTUubbLGJBI7sahnVcgw+KuXj5adM4Ay6/ozdr5Z8E7lDbCksB5VsFB8h1vCrKPdfUy7t6WrSyaBwZKMorvIjDlhXagzAic0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(366004)(136003)(39860400002)(53546011)(316002)(36756003)(31686004)(966005)(71200400001)(7416002)(66556008)(478600001)(41300700001)(54906003)(122000001)(2906002)(86362001)(31696002)(2616005)(107886003)(5660300002)(110136005)(38070700005)(38100700002)(91956017)(66476007)(6512007)(8676002)(26005)(76116006)(66946007)(64756008)(66574015)(6486002)(6506007)(83380400001)(4326008)(66446008)(186003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWZFL1JWL1RBTkdjWHBGQXVTV2VJditMbjAvTnBtL2xhTElORjJ2K1VXSkZq?=
 =?utf-8?B?NWk3emlwd1hoS3pQRU5Hb0pMQ0tTNVhrS1lzYVk5S1FpL3dSYUE1Wkpla1BS?=
 =?utf-8?B?R01DczZZR2JZN1k3K0VoZ2tVQnZjTzNmZnU0L2JVZEpEK0NFTEd6NVhSem82?=
 =?utf-8?B?cEF0VlBGYmR3SWNZdG9kMk1TZzFEbmJxQ01ZYlJhamdrRS9DdGR0MWRMRURC?=
 =?utf-8?B?TE56N1BqYXRUa3JXcUZkc3NRRExVMURwTGRPR1BOWDllNlorZ1VSVjZJU09F?=
 =?utf-8?B?Vm5wdmwwNkxaSkwrQWhmQlQzaE9tZFh4ZE1LeVVRN1IzUDZPMGFyRkROVUhw?=
 =?utf-8?B?RDdseVBPK3dTM05oTHcyclpKMTZhYWhTSExjQkE2Si9kTS9kTDBsUXdEemZk?=
 =?utf-8?B?SjBWWWlFKzhLNXkxamducjVpSFRsa3M1TkVIc3FmNG0wNVllT0xFbUJDb2Z1?=
 =?utf-8?B?OTNqc2l1L1FaLzE4OUxzbnNyd2hBSTJadzRqUDZ2ZDJ4ZTA4blRLSzhNQm5N?=
 =?utf-8?B?a0lqaWQ0WTRGbC9aWUcrOUVELzRld3VGWExZK2FXSHYrUE40RkZTdEdNTkZx?=
 =?utf-8?B?bXRLTWZoRUoxenlsT0FZUFdjRGQ1TGVLcklCeUtEM2dZakJ3ZmlsTHpaWUtJ?=
 =?utf-8?B?RjBXSkVLMlBkWjFKWjB2MUk2bHJOelFvdjYvK1UzeU45aForTVdINFh6Z3Jn?=
 =?utf-8?B?amNyWk1VdjhqaUxSY1d5ZGYwQVAxRCtacUZKcmpiRytlY3FIQXVaaVNVbTRr?=
 =?utf-8?B?R2VQUlJlR2UxYnRDbms5Zk1SeFc4RXovNWg4c01xc1ZPcjh4amFZQk4xYkxy?=
 =?utf-8?B?L2pCZDJsbUNTK3pDYWx4M2FHc0lsL0ZDL29HeVJCMUhMOHZQQkNqcENOVDRq?=
 =?utf-8?B?YkxNUlc5M2RoblBJelI5dkVNZHgyOEJremo4azFJdzFMQ28zRjA4OEVBY2lv?=
 =?utf-8?B?STdzRTNqUXlhZUhxRW1MTUl3WEE2dy92ZUpDTlVrbkhYVlU0ZEpKRFpnVTFu?=
 =?utf-8?B?MlNWVzc5aUZwQ0JzOTdhSkhJR2ZJOG43cHZKV0d0QUJFM1dsLytiUnJOL0M0?=
 =?utf-8?B?S0dCT203dXZqZ1A0czJMdmUxSGZHWWtCMXZyRlVqdGNkaFNXODhHKzY2ZjBp?=
 =?utf-8?B?RnNCSnBjMW5RREQ2NnZ5VTVqeS82ckw3c0dIUXNtMlZ5RkoxME9BQWxNRXY1?=
 =?utf-8?B?TXp3bS9QVHdlWTl3b01ZNFZIUlRLeElRL2hPWVlhTnBQa3piRzlMV05KNDZM?=
 =?utf-8?B?VE1MWTZhNnBjdURFZ3l4Q2pvQ2ZMNUxFSTI0SEF4TmJNUE9DanpGb2Q5MUJR?=
 =?utf-8?B?UldyYVgxVnNWQ01BemJJcGVQUlpYRThVREl4c0g1eHZvTDVKSG9LcmpMTWJj?=
 =?utf-8?B?UitnWWRyT3N4RVExVHJJRnNobEI4bXh4cTlJT1JuMEZkZS82OHcvU0xNaisw?=
 =?utf-8?B?eHdZejhaRWFWa0ZMY3pXSVVsbitZVmprREdyeDV5Y3lnMkJkaDN6MlpmTGJR?=
 =?utf-8?B?WVZCSVVWaHVmNjJCSUZ1UjJONjROQVdQN2s4UklmNFVXdzV1d3JoT1BrR1dD?=
 =?utf-8?B?Rkl3b1ZUNHJaYTdiTzFaWFhiSnhDUmVvVlVpeUdyWWVFNWU1ck9wd1U5K2hJ?=
 =?utf-8?B?RGVpeXZXaHdTNll3V1gyV0h5ZktjL0gzaXRyanhJN3dUZE85Tnl5aXdOTnpB?=
 =?utf-8?B?WElMQ0Z2dkN6dnVwN0dwOFY2eXEwUVdJMk93S0NPVmh1ZXpUQjV0bUQ0MTdS?=
 =?utf-8?B?T0U3Y0dwU25TU0w5dmROLzZkMHBaZVZIOWZiRTZEeWliZWhUWVlUYlRxMUlK?=
 =?utf-8?B?NWJZckdMOENsL2dzbVMyZkRzeHJUcEZzWTEya3RyZmdqa0hGT1pxQTcxa3U2?=
 =?utf-8?B?U3FmS212ekRpb2xrTnRXSkdnTlNwM21yZXl6YjQ0TndHUkxlOUFVUEJnb1Vt?=
 =?utf-8?B?VEZxV2Nrb1pLTVd2NHlsYnhuN08vZjlOM0VqVHlsYzE2UDRMZWRISFBCZk5N?=
 =?utf-8?B?cGpIa1RyZFlYMmQ5a2pleDJNb3V0VGs3M1V1NkVHSFNCc3llVm1ZWkViOVpt?=
 =?utf-8?B?RTZhUFFjNHRMNWNnZkh6anA4VnFWRXA1Z09INEpDZ3BqNmlsYjFVRHpOWGYx?=
 =?utf-8?B?aHhQMDJoc0NpOGR3UkRjTXBxL0FjK1VrbEoyQW5tdmpGKytpZzIwQm4vUi9B?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F19832F5D84C38489DA2D6CBD0131DE4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c3d0ba-0e6d-4755-952d-08da5acd8944
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 19:20:04.3959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ED2GR+uuaE/i3/mqb9NKPYX36GA1C/25IV6RdCWfo1KnmKpQQxFN33nTh3g6EahBVpxhVuJp5PEKw2UFUVR6vWqR9Kk3uN1wa8xHgBAHVzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMwLzA2LzIwMjIgMTg6MzUsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gVGh1LCBK
dW4gMzAsIDIwMjIgYXQgMDQ6Mzc6NTBQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+PiBPbiAzMC8wNi8yMDIyIDExOjM5LCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+
Pj4NCj4+PiBJIGNhbid0IHRoaW5rIG9mIGFueSByZWFzb24gZm9yIHRoYXQgdG8gaGFwcGVuIHVu
bGVzcyBkZXRlY3RfY2FjaGVfYXR0cmlidXRlcw0KPj4+IGlzIGZhaWxpbmcgZnJvbSBpbml0X2Nw
dV90b3BvbG9neSBhbmQgd2UgYXJlIGlnbm9yaW5nIHRoYXQuDQo+Pj4NCj4+PiBBcmUgYWxsIFJJ
U0MtViBwbGF0Zm9ybXMgZmFpbGluZyBvbiAtbmV4dCBvciBpcyBpdCBqdXN0IHRoaXMgcGxhdGZv
cm0gPw0KPj4NCj4+IEkgZG9uJ3Qga25vdy4gSSBvbmx5IGhhdmUgU29DcyB3aXRoIHRoaXMgY29y
ZSBjb21wbGV4ICYgb25lIHRoYXQgZG9lcyBub3QNCj4+IHdvcmsgd2l0aCB1cHN0cmVhbS4gSSBj
YW4gdHJ5IG15IG90aGVyIGJvYXJkIHdpdGggdGhpcyBTb0MgLSBidXQgSSBhbSBvbg0KPj4gbGVh
dmUgYXQgdGhlIG1vbWVudCB3LyBhIGNvbXB1dGVyIG9yIGludGVybmV0IGR1cmluZyB0aGUgZGF5
IHNvIGl0IG1heSBiZQ0KPj4gYSBmZXcgZGF5cyBiZWZvcmUgSSBjYW4gdHJ5IGl0Lg0KPj4NCj4g
DQo+IFN1cmUsIG5vIHdvcnJpZXMuDQo+IA0KPj4gSG93ZXZlciwgTmlrbGFzIENhc3NlbCBoYXMg
dHJpZWQgdG8gdXNlIHRoZSBDYW5hYW4gSzIxMCBvbiBuZXh0LTIwMjIwNjMwDQo+PiBidXQgaGFk
IGlzc3VlcyB3aXRoIFJDVSBzdGFsbGluZzoNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXJpc2N2L1lyM1BLUjBVajFiRTVZNk9AeDEtY2FyYm9uL1QvI201MjAxNjk5NmZjZjVmYTA1
MDEwNjZkNzMzNTJlZDhlODA2ODAzZTA2DQo+PiBOb3QgZ29pbmcgdG8gY2xhaW0gYW55IHJlbGF0
aW9uLCBidXQgdGhhdCdzIG1pbnVzIDEgdG8gdGhlIHBsYXRmb3JtcyB0aGF0DQo+PiBjYW4gYmUg
dXNlZCB0byB0ZXN0IHRoaXMgb24gdXBzdHJlYW0gUklTQy1WLg0KPj4NCj4gDQo+IEFoIE9LLCB3
aWxsIGNoZWNrIGFuZCBhc2sgZnVsbCBsb2dzIHRvIHNlZSBpZiB0aGVyZSBpcyBhbnkgcmVsYXRp
b24uDQo+IA0KPj4+IFdlIG1heSBoYXZlIHRvIHRyeSB3aXRoIHNvbWUgbG9ncyBpbiBkZXRlY3Rf
Y2FjaGVfYXR0cmlidXRlcywNCj4+PiBsYXN0X2xldmVsX2NhY2hlX2lzX3ZhbGlkIGFuZCBsYXN0
X2xldmVsX2NhY2hlX2lzX3NoYXJlZCB0byBjaGVjayB3aGVyZSBpdA0KPj4+IGlzIGdvaW5nIHdy
b25nLg0KPj4+DQo+Pj4gSXQgbXVzdCBiZSBjcmFzaGluZyBpbiBzbXBfY2FsbGluLT51cGRhdGVf
c2libGluZ3NfbWFza3MtPmxhc3RfbGV2ZWxfY2FjaGVfaXNfc2hhcmVkDQoNCg0KU28sIGxvb2tz
IGxpa2UgdGhlcmUncyBhIHByb2JsZW0gaW4gY2FjaGVfbGVhdmVzX2FyZV9zaGFyZWQoKSB3aGlj
aCBpcyBoaXQNCmJ5IHRoZSBhYm92ZSBwYXRoLiBCb3RoIG9mIHRoZSBpZiBjbGF1c2VzIGFyZSBm
YWxzZSwgYW5kIHRoZSBmdW5jdGlvbiBmYWxscw0KdGhyb3VnaCB0byByZXR1cm4gc2liX2xlYWYt
PmZ3X3Rva2VuID09IHRoaXNfbGVhZi0+ZndfdG9rZW47DQpCb3RoIHNpYl9sZWFmICYgdGhpc19s
ZWFmIHNlZW0gdG8gYmUgbnVsbC4NCg0Kc3RhdGljIGlubGluZSBib29sIGNhY2hlX2xlYXZlc19h
cmVfc2hhcmVkKHN0cnVjdCBjYWNoZWluZm8gKnRoaXNfbGVhZiwNCgkJCQkJICAgc3RydWN0IGNh
Y2hlaW5mbyAqc2liX2xlYWYpDQp7DQoJLyoNCgkgKiBGb3Igbm9uIERUL0FDUEkgc3lzdGVtcywg
YXNzdW1lIHVuaXF1ZSBsZXZlbCAxIGNhY2hlcywNCgkgKiBzeXN0ZW0td2lkZSBzaGFyZWQgY2Fj
aGVzIGZvciBhbGwgb3RoZXIgbGV2ZWxzLiBUaGlzIHdpbGwgYmUgdXNlZA0KCSAqIG9ubHkgaWYg
YXJjaCBzcGVjaWZpYyBjb2RlIGhhcyBub3QgcG9wdWxhdGVkIHNoYXJlZF9jcHVfbWFwDQoJICov
DQoJaWYgKCEoSVNfRU5BQkxFRChDT05GSUdfT0YpIHx8IElTX0VOQUJMRUQoQ09ORklHX0FDUEkp
KSkNCgkJcmV0dXJuICEodGhpc19sZWFmLT5sZXZlbCA9PSAxKTsNCg0KCWlmICgoc2liX2xlYWYt
PmF0dHJpYnV0ZXMgJiBDQUNIRV9JRCkgJiYNCgkgICAgKHRoaXNfbGVhZi0+YXR0cmlidXRlcyAm
IENBQ0hFX0lEKSkNCgkJcmV0dXJuIHNpYl9sZWFmLT5pZCA9PSB0aGlzX2xlYWYtPmlkOw0KDQoJ
cmV0dXJuIHNpYl9sZWFmLT5md190b2tlbiA9PSB0aGlzX2xlYWYtPmZ3X3Rva2VuOw0KfQ0KDQpB
bnkgaWRlYXMgd2hhdCB0byBsb29rIGF0IG5leHQ/DQo=
