Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979535665EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiGEJRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiGEJRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:17:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B6C8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657012638; x=1688548638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rtXQxnduyTTcm2lhaAPpue6dJVzdw/SjRNiERiXVkxo=;
  b=SI/gYroyhQHp6obi41ldPOpOYD81+DDy+3Fg6D3MmMivw3HgbFnFtN5x
   hz4savE+dZw7X3vPhGW8Tpkn0XX++sDPbuSCpmaHchr+GOO2eJCRp4h46
   v/Eikq+rBaa/RmmQVuHWvcTZQScmMUTM4qRRJ8brUGOWWgq4CzF3GCkwj
   frQhhqjeXoPTFcY1mtaOEB7V93M0VwriFjEeJXzMv3ECdy1Nb7KcWzCjM
   HnbDxEpniv+WMXcYmEHmpx4dG1b78o1fO9dcZIz8B0hOeKlk7VKSfbsNg
   ZMDQpNfKqqPhNAnwkRFN6ehO542pVxN74QOwx3eGZ6wak10q1FDd3HRvi
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="166391599"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 02:17:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 02:17:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 5 Jul 2022 02:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH/Z1TGaTao2MxM00I7f5ePhEOw7OgCpCuHr9nrVApFpw/1hFpEawdU4i2Z5fJlMtMVWNue9IFydU5DvXMjrUMhs/GympAC0cgldelNarwc7iWkADbUwb9gNEMfsAOUSoX0Y76FH7Zjy9gWPp+J9Mtps/b2iMgXXjZ5dadRk4r7QdVgshFR2DYdf05pJppqv+vUQoHD5fwShkYgkbvvmsmzeeAWIJYUaE/B5GbL5jEQYLLn6xA6Bz+8BAxug/5oe3diiToZIDg0NolTHn1keHi4hFHYhHXdlRxHU55EO6L8ESGaXew2uaERuaJpfGZMUYU25XXAMAolXO3hcCqsRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtXQxnduyTTcm2lhaAPpue6dJVzdw/SjRNiERiXVkxo=;
 b=WmgWJJUC0PX4g3InUbxFab9dKsEwyp+TDnrahVM95jqqrhaLphWkiPgwsyMQug5Dj10h5xBOO5KQRd8eIwXao8+4x6BKIVylYWvMdgrCmfZiRXh+l2D1pPPeDsjQHms0UzZdb2TxrXKYGNylffpX9nRuos1EuEBou9+g1Nzc5YCWt5XFBjtjtqeKrkWuDwboIKdGkUcBCPueVjavQFyJ0YZHnZoMd7KJ0wv2I4OYum3c83mvQJhJJ9r0mRBvb6t7mYs/UWYePMNYsmqw1hh6qiM09C9eu87ZSFzsP4JQvUDAn0CwoherHqzFUQUvr6UkjBxPGGE1VrC7ZhPgSELlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtXQxnduyTTcm2lhaAPpue6dJVzdw/SjRNiERiXVkxo=;
 b=knI6Kqg060fSN6yH6cXdhXVYEhK2yrMlxt0FLfktc6A8haAPRFt4NTU2cdQHZBh8XzcHPOhHDYPzA7Z7xgL8u93OvdrfDO73Ro8szKLzoT7/hd7Sm6yDgNCnUPuKwBeQvi2SzruJnjpmiKNoOnywNA9BCRMw5kNBuG57z9UFK4Y=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH2PR11MB4358.namprd11.prod.outlook.com (2603:10b6:610:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 09:17:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 09:17:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <arm@kernel.org>,
        <soc@kernel.org>
CC:     <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] AT91 device tree changes for v5.20
Thread-Topic: [GIT PULL] AT91 device tree changes for v5.20
Thread-Index: AQHYkFAEtlTXdzBpsESbnKI3soK1HA==
Date:   Tue, 5 Jul 2022 09:17:14 +0000
Message-ID: <b7eff1a6-3063-a06d-4363-70ae429a89f6@microchip.com>
References: <20220705084637.818216-1-claudiu.beznea@microchip.com>
In-Reply-To: <20220705084637.818216-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6541164-7416-49dc-819a-08da5e67268c
x-ms-traffictypediagnostic: CH2PR11MB4358:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33O3RycQPT0XVQEIkrs+uv5/zVxWwLQd4xAKLqg/HKSDyWMMsdzscatX/Qur61zr6x1LNqJb7IDeMEXUeAxZKRd8o4cHOvIasb5dtcwlsU5TFXH+ZDzGhmSUG6TTkWyUKUOCNW/GnkCVR4thh0l5h5Mjs2WsKGsnnjvJqbowjbS25bQ8CeoyC+1Csw7mKACeTHGc5cCvtzoKbYOHPN/o6z933Y419eSs8S0Ml4WlRvpjzNSijcw/GpYx/c6W9a9mNOR71JeClE18ueECwKCdE/9ZcITgFLyHjYK+gcrvmT2hJD+gsKD/JGdkho40wx7scn4mrQSG8iVzTRsNioi7BeC9lu5Iwbs+r9WYYoKldiaSluviPh102KWOlRuA2TjKpz0hmoQMHEz23JMMxf4Jii0lnrbR0KegwEPC79JQwQhR/53H+wt1upLMrhmJSuq1AnjxPCMzI9/2eFBSIZd/QAz4LM5dTiDeGuAfvYHvrZnkZTEHM9NWEk67VF5xofOEiS0u0Z7yZgYhpYjGS8Zf1tt2rihsrXpsD06/YsjEUk288lGx9fAivLvuIqewSuzA1a/pv1uWSA1bqaEyTZsIIeyTzkfZr3HPr+X5tu6Lee1pl1n3FTaRwv9cduravBpyQehlkzoO2B98rsfdSEaVAQ+A+r6zpyyQaL6LVCtxFmhkSNNP9mICQnrO8yojdUqfJpzVnl2wFJvvG/AZYkE2y7UIho/a4t7ig40EOjwwCNdai7cA8wWm2tCyOnvVTlU16YUZbMD8raYkL6q53//3N+cZbD9Jx1ebM1uVYgDrPf0fKeUizgWa5YjMQCPJSFTzx4OkRbL4zvl5jVtPQSRFWe336TdNB4/JkkT51q5WPj9eQtZP9sR/K1Q+r8Stm5K8mv2QHO9QSGzXrKAdrYlPA4bbD9QtDW7vsERzHVDcCUEg7xawIYTeVL+o3wqr7mzm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(346002)(366004)(376002)(6512007)(316002)(6486002)(110136005)(966005)(26005)(38070700005)(8936002)(53546011)(5660300002)(31696002)(86362001)(41300700001)(122000001)(478600001)(54906003)(91956017)(31686004)(8676002)(83380400001)(2906002)(66946007)(64756008)(76116006)(36756003)(186003)(38100700002)(66556008)(66476007)(2616005)(4326008)(66446008)(6506007)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1oxNVpueDBHa2s4NkVBNzg2d3BBemxia0V3Qzd0VUFYNUZnT0xEb3pBWkww?=
 =?utf-8?B?MHhaRlkrNmhCYTFmamU1b3g5RU1MY29KRTlLQ3lWUE4wMnpWUDV6Y2d0SGZz?=
 =?utf-8?B?VnJjWTQrcC9idjF1Ykp1OVRhUjNaaGtFM0FNTG85T1NUekRVaVVJbnRZbWdJ?=
 =?utf-8?B?MjJRQ0NuQzZZWWVZR2VySlE5ZG15M09qM1hDUllld3lSWW1pMUFEQklRRnpE?=
 =?utf-8?B?REszR3RibjNtelZ5bGJNajh6TXhtVWVvZ2RZTS9FYmV4TzFtUjVPbFF3aW5m?=
 =?utf-8?B?VElNNVFKNzIxS2dUS3hpclA0anRPWXFTenRBODM4QkphZUg0LzZWSHN2dGVW?=
 =?utf-8?B?cUpyU0hLVVVlbHRTWnZyTlFRNVhMeElJNDl4RkpIZ0dlRjBhMEhtUm5EcnNO?=
 =?utf-8?B?SUJqek1ld2pVWks1Q2xudVJzN3hjYnpEN2NCSWJ4NytJdnE1amJodmJYeFBF?=
 =?utf-8?B?TkxXaE1oN2w0b3dnckdtc1BxenFRZEl5Ky8yc094SG5nTzA0QUdUc2tMUisx?=
 =?utf-8?B?THlvQkZmTUYvZUxYb21Gc1pDc1puZWtFSnlDTktCYVBVcW9YZVAyMG9RaEpl?=
 =?utf-8?B?TDBwQUV4VE1uSG1RYU51L0tKWGxycmlIaHNBK1hKN1lsSlpyc2wrYkVZUnJL?=
 =?utf-8?B?bnUzcHBlWEI5WVI5ZTh5Vmw3UWZnRnhFa2FVSVl2TmJxdU1VSS9GT3NnVUYx?=
 =?utf-8?B?bkU2dTlJODhRdFI0OHRXMHc5RjUyVFluaHpyTk43OUV1T0NiVG9WVE41WWNU?=
 =?utf-8?B?dEFIb0Voc0dRSmdqdHJXR0VpZ2NkOWx5WjN6VEVHbjhtQU9iTHlKZnFLdWRt?=
 =?utf-8?B?NGJXaTZya2FOMHlSREtJcUd0dnZqc2Y5VitLYlA0Ym9ENG1sdEh2TWRJdmVa?=
 =?utf-8?B?M083Y1prSk1iKzk1d3RMRXlVOHFXczlLdzJDNUtyUVJvcHBibGtWbjZ5OFVH?=
 =?utf-8?B?TUZWd0FHcjhRTC9OS0w2clhFUDBSZTBIRDIxNCthZk9rZ0w5QUpXZjRlNVNl?=
 =?utf-8?B?Mk1BTHppU0dZbjY4bVhmQVFzZDE2Mmg1N3ZHSzl5MEdJSzhyQUFyeXZJazEy?=
 =?utf-8?B?YUlaaVI0Sld5bkFtOTB5RGIydFFPUWZKUWU3TTNxYUlXYmljVUhxeTdtd2Zh?=
 =?utf-8?B?ejFVV0F2TzZabnFxdzcwbGNPc0ZIcTlpQ1V5dFJxa1B0eWtwY01nRlFUTkRO?=
 =?utf-8?B?Z0ZFc1FvNjgxVnkwSWZXVjVrK3BCTmR5R1c1Snk2VGRDT0FNZXBzcW1LaSt4?=
 =?utf-8?B?ZzRyK0h5UUZhcFBQbFppSExkVDFBaVllMlRtZVFjNmpHWHpRRG9BZzFFZXp5?=
 =?utf-8?B?aTVZZEYvUXJYWUNBQi9ob2VISlBzNXlGNnZTTHA1eW9kQXpFdmpiSlZWelN5?=
 =?utf-8?B?c2UzQ0x2YTFnVnNBWW9PbWpjRERyZE5UVHFmZndQSFVkcHg3b2U4LzNHWk9v?=
 =?utf-8?B?NkxiWDAyR3hLQ3lPMEFva2t2RkRZd2ozdkJ4czI3d2VNa1hXa3kyTmcraEVD?=
 =?utf-8?B?TTFCaFBFcGcySmR1cmRHSHhFaEhxVHNRRzVkMHBacnUxSEk2anFMRWVNU3dm?=
 =?utf-8?B?NC9oNFgxeHUwZWtpendERnJ6dTlHSDcyUDNsZXlGZm5Kb0x4WWw4NGtPYnRD?=
 =?utf-8?B?NHhaaVNSbXllUldZcWZBdTB5T1k0YndtVEpxSWp4Q0R5bzdMcW1QWVhnWm93?=
 =?utf-8?B?dzlKTTgxRVpBYjYxNTZ3Y1FkNHNJZTh5NGUyOFBTOEF2NVNYYzREWHlqWHQv?=
 =?utf-8?B?dEtMUTNVcTMrR3JNQVVtTTlESHlBTmFwUUVoTjlDaGs1WjVSZkl4eDJiQ2VB?=
 =?utf-8?B?QjJ6V2NSd1oyREE5djZMNHpWNDdzSlBIN3M1MXh6VzB3YlhLdXVJdzNCYWRJ?=
 =?utf-8?B?T2pNN29QK0lkMThGcUFhT2daaXZOcWVUbTZIcUg1Mlg4TVh3OXlQN3l5U3pW?=
 =?utf-8?B?cmZpQ3hIaUxneFduWTBiekpZUEFMdkI0OXkvc084WndCUXh0c3kzNDJDK0Zy?=
 =?utf-8?B?SHk0VjlKRjV0bXY0QkV2SGI1ZVZaZ01RenNoVEtrMEhkdzBaOS9tcFA2dEhs?=
 =?utf-8?B?c2pNQVNISVlyYmxpOCt1T3lLNEx1b2ZXSXZrOUtmakFWYy8rRUtSMHdja2Zl?=
 =?utf-8?B?R0RrdXFFTDVmQzVNTFBVT1ZQVHFoMmYyVlpwQjhkREhoMmhkNjJaSEUxWDFa?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C9663EAA1F8BD40862246D7752C9E2F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6541164-7416-49dc-819a-08da5e67268c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 09:17:14.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyZ3zGoxJ/Kmswcb7qusM/XJhvVtd1LdB4WZThVu4XrctwG9GK1lDlb4snZWP0EOYzrO0v0cjvISc6TGjzTsg1bgPyJ8OS1nr7urp0TkFZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4358
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMDcuMjAyMiAxMTo0NiwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksIEFybmQsIE9sb2YsIEFSTSBTb0MgbWFp
bnRhaW5lcnMsDQo+IA0KPiBQbGVhc2UgcHVsbCB0aGUgZm9sbG93aW5nIEFUOTEgZml4ZXMgZm9y
IHY1LjIwLg0KDQpzL2ZpeGVzL3VwZGF0ZXMNCg0KPiANCj4gVGhhbmsgeW91LA0KPiBDbGF1ZGl1
IEJlem5lYQ0KPiANCj4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBmMjkwNmFh
ODYzMzgxYWZiMDAxNWE5ZWI3ZmVmYWQ4ODVkNGU1YTU2Og0KPiANCj4gICBMaW51eCA1LjE5LXJj
MSAoMjAyMi0wNi0wNSAxNzoxODo1NCAtMDcwMCkNCj4gDQo+IGFyZSBhdmFpbGFibGUgaW4gdGhl
IEdpdCByZXBvc2l0b3J5IGF0Og0KPiANCj4gICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9hdDkxL2xpbnV4LmdpdCB0YWdzL2F0OTEtZHQtNS4yMA0KPiAN
Cj4gZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDRkZDFhNjEzZTQ2NGU5MDM2ZDUxNjNm
YzhlYzVmN2RjNmUzOTRiNTM6DQo+IA0KPiAgIEFSTTogZHRzOiBsYW45NjZ4OiBBZGQgVURQSFMg
c3VwcG9ydCAoMjAyMi0wNy0wNSAxMDo0MjoxOCArMDMwMCkNCj4gDQo+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gQVQ5
MSBEVCBmb3IgdjUuMjANCj4gDQo+IEl0IGNvbnRhaW5zOg0KPiAtIGNvbXBpbGF0aW9uIHdhcm5p
bmcgZml4ZXMgZm9yIFNBTUE1RDINCj4gLSB1cGRhdGVzIGZvciBhbGwgQVQ5MSBkZXZpY2UgdHJl
ZSB0byB1c2UgZ2VuZXJpYyBuYW1lIGZvciByZXNldA0KPiAgIGNvbnRyb2xsZXINCj4gLSByZXNl
dCBjb250cm9sbGVyIG5vZGUgZm9yIFNBTUE3RzUNCj4gLSBNQ0FOMSBhbmQgVURQSFMgbm9kZXMg
Zm9yIExBTjk2NiBTb0NzDQo+IC0gRmxleGNvbTMgYmluZGluZ3Mgd2VyZSB1cGRhdGVkIGZvciBs
YW45NjZ4LXBjYjgyOTEuZHRzIGJvYXJkIHRvIGNvcGUNCj4gICB3aXRoIHJlYWxpdHkNCj4gDQo+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gQ2xhdWRpdSBCZXpuZWEgKDQpOg0KPiAgICAgICBBUk06IGR0czogYXQ5MTog
c2FtYTVkMjogZml4IGNvbXBpbGF0aW9uIHdhcm5pbmcNCj4gICAgICAgQVJNOiBkdHM6IGF0OTE6
IHNhbWE1ZDI6IGZpeCBjb21waWxhdGlvbiB3YXJuaW5nDQo+ICAgICAgIEFSTTogZHRzOiBhdDkx
OiB1c2UgZ2VuZXJpYyBuYW1lIGZvciByZXNldCBjb250cm9sbGVyDQo+ICAgICAgIEFSTTogZHRz
OiBhdDkxOiBzYW1hN2c1OiBhZGQgcmVzZXQtY29udHJvbGxlciBub2RlDQo+IA0KPiBIZXJ2ZSBD
b2RpbmEgKDIpOg0KPiAgICAgICBkdC1iaW5kaW5nczogdXNiOiBhdG1lbDogQWRkIE1pY3JvY2hp
cCBMQU45NjYyIGNvbXBhdGlibGUgc3RyaW5nDQo+ICAgICAgIEFSTTogZHRzOiBsYW45NjZ4OiBB
ZGQgVURQSFMgc3VwcG9ydA0KPiANCj4gS2F2eWFzcmVlIEtvdGFnaXJpICgyKToNCj4gICAgICAg
QVJNOiBkdHM6IGxhbjk2Nng6IEFkZCBtY2FuMSBub2RlLg0KPiAgICAgICBBUk06IGR0czogbGFu
OTY2eDogQ2xlYW51cCBmbGV4Y29tMyB1c2FydCBwaW5jdHJsIHNldHRpbmdzLg0KPiANCj4gIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9hdG1lbC11c2IudHh0ICAgICAgICAgIHwgIDMgKysr
DQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3X3NvbTEuZHRzaSAgICAgICAgICB8
ICAyICsrDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3X3dsc29tMS5kdHNpICAg
ICAgICB8ICAyICsrDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfcHRjX2VrLmR0
cyAgICAgICAgICB8ICAyICsrDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfeHBs
YWluZWQuZHRzICAgICAgICB8ICAyICsrDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2
MC5kdHNpICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkx
c2FtOTI2MS5kdHNpICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBhcmNoL2FybS9ib290L2R0
cy9hdDkxc2FtOTI2My5kdHNpICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBhcmNoL2FybS9i
b290L2R0cy9hdDkxc2FtOWc0NS5kdHNpICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBhcmNo
L2FybS9ib290L2R0cy9hdDkxc2FtOW4xMi5kdHNpICAgICAgICAgICAgICAgICB8ICAyICstDQo+
ICBhcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOXJsLmR0c2kgICAgICAgICAgICAgICAgICB8ICAy
ICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOXg1LmR0c2kgICAgICAgICAgICAgICAg
ICB8ICAyICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzICAgICAg
ICAgICAgICB8IDE4ICsrKystLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2
eC5kdHNpICAgICAgICAgICAgICAgICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrDQo+
ICBhcmNoL2FybS9ib290L2R0cy9zYW05eDYwLmR0c2kgICAgICAgICAgICAgICAgICAgICB8ICAy
ICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9zYW1hNWQyLmR0c2kgICAgICAgICAgICAgICAgICAg
ICB8IDI0ICsrKysrKysrKy0tLS0tLS0tLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9zYW1hNWQz
LmR0c2kgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9z
YW1hNWQ0LmR0c2kgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBhcmNoL2FybS9ib290
L2R0cy9zYW1hN2c1LmR0c2kgICAgICAgICAgICAgICAgICAgICB8ICA3ICsrKysrKw0KPiAgMTkg
ZmlsZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pDQo+IA0KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsDQoNCg==
