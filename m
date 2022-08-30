Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F835A634E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiH3M2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH3M2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:28:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F9EE4A6;
        Tue, 30 Aug 2022 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661862498; x=1693398498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l+DOTxKIGtAvtdqKg0MYGZU9Ak/bOfzkaLeDwHnuqAA=;
  b=LOSznCxG1S2bLidCOwEpNpkgj4OdSZDjRKch5GbTrBMRB59MTEO92IYA
   8qOqUtF4H53oIkDjMCyFWH3d21EbyV7KCJUfKc/T6KEqZRyYqSWbhfoAM
   VPxTh0U4QpASny0F8jpVUJC0CHAdzNP8dYYr07oyFFECYVuRYWnJl1r2K
   Mvw277glVNfzSSwngmv/2cLVsiI1jhx0LlIF02UfgPsZKEpyl2Ulo46kO
   XWhYUKyMrnxLeLLlCouPcrhf9L2PnbrbADpo17hvgHURUzPqjvO9ZHbyW
   By/VhyRZoqJuXrwXULVrw7pKd9iVX/CwqWfzgF6HRsVOnQaxKw8L0Zr9j
   A==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="178431197"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 05:28:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 05:28:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 05:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jri5WDL0Zr7yJz09vC71abz43FzMa8VQyyFjPJTAvqmWo9SH3Uri/FAV7JMHqTPN+glnXV8r2k9vtE0c0GuLtdAFlTEF+MJGvf4RgvGJngjnwTONsZTv3mYPb6xteorLxdUj+iDtIkHZ2MdBv1EBqINnTD/0212ViRP0n/QKpSPuZZCtQiU2FaFa5ymGqyMeXqb6g6ojVj6ntmb3DfVWGMGR25y9BBE3eHBeKmCvdR2A7qltaFHvbGE0JO7/x0xz817YhKa/6olvcXUxsRiIRYLp/Btg41K5PKTAr9Y0wKfnmxV0su7vpyRv5d9cNBxNkpVBRspN2kcrwgiNz6YHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+DOTxKIGtAvtdqKg0MYGZU9Ak/bOfzkaLeDwHnuqAA=;
 b=XBZYzcy6GKZJ8NMGI3JR854miQO1b4EVplrmCbRRdFSRc/EPPVAAdf8tVykDRxY3WLiqVUoetdbbPT9mQMzNi5wRJcpLqPoiEXKCKYHUY9/5a2wbXpIl1P14vT8IuSCEMfVKXVkdeTgUxEqnpMBqj/ODEcAz7ArhLAcXYuOuVVK45OR6DXUgGs4WWsNxg/RxPVTXvGw7aXye56nqojwnGO783e2RmpYjplioL0D0uSBrTWrq40cxif4DMESu4d2J2oiv9l49CAdlLMGC/C44fZViypu8tAW+9tjkr1FlggB4WfWGP+RBR6mq7Syxzstt55DRyHX4hfbh8IvDFPwraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+DOTxKIGtAvtdqKg0MYGZU9Ak/bOfzkaLeDwHnuqAA=;
 b=CGdiE+KwYezUSHjeQORqHIiobYUTvEz6CbTk3HCU+pa0EhJjgoU5hPiw0EBBqCaNJHKh1SsAAe9QEeS+pbIC57KVAknrOxa+M38ryxMm+L8tPj1iFbIqeIDz3dq3/OHEWvGULCI0BQi3aHIczR1Xr7BGGDS0AIQOrVmNtgOP5bo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB2043.namprd11.prod.outlook.com (2603:10b6:3:e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Tue, 30 Aug 2022 12:28:15 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 12:28:15 +0000
From:   <Conor.Dooley@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <palmer@dabbelt.com>, <Daire.McNamara@microchip.com>,
        <Hugh.Breslin@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <Claudiu.Beznea@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 0/5] Add PolarFire SoC Fabric Clock Conditioning
 Circuitry Support
Thread-Topic: [PATCH v3 0/5] Add PolarFire SoC Fabric Clock Conditioning
 Circuitry Support
Thread-Index: AQHYvGsBwsWIhQ+jCUSS/IGObfwRE63HXwkA
Date:   Tue, 30 Aug 2022 12:28:15 +0000
Message-ID: <23085a41-eaf5-2f36-17bb-afc6d2a53d66@microchip.com>
References: <20220830122023.2204485-1-conor.dooley@microchip.com>
In-Reply-To: <20220830122023.2204485-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73620e62-43bb-414a-89e3-08da8a831cf1
x-ms-traffictypediagnostic: DM5PR11MB2043:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwXZ8DXi2sxU8USemO/0ujSezx6BE3kjpp4mBZVyLC/n/xnpBJTd1OI/q8JtesmUHl7cXwyFqyzibepXfD32jDfMy6FCCQod4jtT/B9M7Kt+QwJTbxngnGHA3+jrP/xfr/XrDJ0g8e51RHFg4zNYW+tV7I3a2KDJml5VwcVhxFvfQM0T0/bXpTHi1saGtVWHP0SwzPoU3vcAuAFugDXhnqZKFzyB+G97oQCAU38lIN3pJZv0pugg5pDSbaAarUOx3jG0SUlxQ3BOwwlPG5fHjUGzWIMd6GshGUX2SaqhcidnCDLS/jD698yQB1liPpP19F/QXeUiQMi9LA9OYKqM3xdc0EvMJuQYLkCir9Wzz6xZrS34XFZ4B1B+VHLw4gvKQ1EFUPQFNIWtf7bToZHN8ObaJyFDsSDXxWPnkYufRBJM3X7ZcrouWxypwjAgrR4GQHI822BgAbhkNxwSj+iZP1Rlgd7w6uuyDrBDdmiym4GB+V3FFxThspf9plI2x8svZkfwLudMcg7qbddHhtqxxG7zHKT/8+8boodhP0lOLiMkhG3Emi8vPTvnuUtbjAh/JsIxa+ZjeGhi0bORB3PmHNAvgsRoCrVr1wmk1E2BiLPjr+w244mB67YzMr5GnjzsQve7nsWCYxGnyjXNL4vN5eZm24OHgPsyyWQaXklI24Od211LQbmgQs+MPwcfYs/iCc6/xhgSyQRhEn4RdqMqB+fD2TVhauUGpCDCruI/OaoLXrX5OxgWMBSIo8juD7Qh4Xm1LyOQF2cPdWFYs4PkRx9ocqlg/9v8VBlhPjHawVjpOb2rC1qO6fkLm+x75iXsynYg8zqKYP4B792oIsB5/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(346002)(366004)(396003)(31696002)(186003)(2616005)(26005)(316002)(71200400001)(6636002)(36756003)(6512007)(83380400001)(2906002)(6506007)(53546011)(66476007)(31686004)(86362001)(38070700005)(76116006)(122000001)(110136005)(41300700001)(7416002)(8936002)(6486002)(38100700002)(478600001)(91956017)(54906003)(5660300002)(66556008)(64756008)(66946007)(4326008)(8676002)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0kvOFp1WmFDNncya2ZaUWk0M3dQNzBkN1JYQVFHUTRGMEZXckRma3RPS2Nk?=
 =?utf-8?B?QS8zajlaNnJMdE1iSGpJS0FKbndkYXdKNkRVYnYwSkFESzRWVEg1aldDbHFG?=
 =?utf-8?B?dllqWUc5ZGl1MVB0K1FmMGNJdkgxMDZMd0R1THpDQm5ia2ZIN3BJZXFvOVhR?=
 =?utf-8?B?Y3J2T090NmhXRDdyT2pzM1psUWFEVXVNVGJUbG9zbi9BYUp6Q0w2enJydHdt?=
 =?utf-8?B?WEpFOWdxSTFxMHMzcHVyRUF5UGhiZitveUtER3poWVNJYTlPM3gwVEhXcXRT?=
 =?utf-8?B?UERxUCtQOHh4dCtLRkhJL1pNNUFuN1N1STVRWmFlNm54RDRRa0RTcVVhYmd1?=
 =?utf-8?B?Mnc2cUlXR0JReHVQVG11bVppVTh1VjFLY1ZIc1J6eFVGVUZzejJjcnBvbFNn?=
 =?utf-8?B?bGxOY1Jvb2o3Q01Ya2lrM2ordjJYOWxXM2JRSDkrVmtnS0U5eHBuaWNPdzkx?=
 =?utf-8?B?b2NOdW9haUhHcmxQMVEvdVhMOUppVnBQVSt0VE15bUoxS0RNeFE3YmJNVVVK?=
 =?utf-8?B?NU1nVWluemhSR1hzTlovc29TVVVXSzVHRklFSDdPSDRFRXJLa0JBVlVnVGwr?=
 =?utf-8?B?cFdCQ29nUEIrZnlrekEzc3hwb2dpQzB3cERhdEtBSXV5bUp2MzhWTGt0SzM1?=
 =?utf-8?B?ZUNmdlVzanIrOGM1aVRHb3JaM3lFY3dWbjNWdnk4NFB3RzhNWjFOZmkrWFFI?=
 =?utf-8?B?bHFzTzZ1ODFzblJxQXhjbG9hSlRSRjE2T1N3ZWZjUEYzM1VOYm1FSUU2Nll3?=
 =?utf-8?B?RkkvZWRUNG5Dc25FN0p5ekFaMHhBekYzU1lHRW5NVHdlMWVSYTVBaTBDSTZs?=
 =?utf-8?B?aGYzUjVGNkRjcFZlT043N1lNWVJDMlVIUTZoNU4xeTE2ZC9HOVhkd2t3MU1m?=
 =?utf-8?B?M3hLZnVTQ2R6cVAwNzFJcTFxbDllSnA0Nk9wTmRzZEJ4c1Z3ZFFJN0MyVlhq?=
 =?utf-8?B?R05aSGtZNG5EN0ZnaUtWQmdvL08yMzJyY3BTclVoR1RUWEh5WTVKTVJ2ME9l?=
 =?utf-8?B?OVBtT252SVRsMVlDVHh5UmdQYjFOTk1rRDEwK3gxMWNVaGtsbzJqQ2VUdktx?=
 =?utf-8?B?M3VHL1FjM1BLWWxpL04ya0RoNytTaGVtQjgvUEl2WENCNTNlUlVubHpRUGR5?=
 =?utf-8?B?STNNbHl5VzJIcHBmK3cxczJRaHFKL2tWcU80MXV5ak1xUVBMWVFLVUpGQVZK?=
 =?utf-8?B?YUZ5ZE5DUlR0UVB1R2JEaDA1NkdRMDdUb0xMN0xNSGtsclUwQ2tqckJlNWVR?=
 =?utf-8?B?M3RLa2NyYmF5Tm9JaTdMRy85UHRDZU9TU1dnL2tKYmE3b0prd2wrdnFKYmxy?=
 =?utf-8?B?eW9MbmxQcnd1bmRFU1FOR0hocjlzNEJiSFBHb3g2VlZSdzE1dUZURmVkWHJZ?=
 =?utf-8?B?SWNDK2REV0liQW9LdW5EaTBRKzF2UE9YU2M4THgza3RuanhNZnZBZ0p4Um9h?=
 =?utf-8?B?aUVmZzR6SVRIbENaeHRlZGVCMHRQbTgyNE1IVmlkQkVWNEw2NzVURUthMkpC?=
 =?utf-8?B?cUVrNWdFVlNyNXdXVG5nelVCNlprTFQxMGNWYmhmRFVZM3pLOCtJMVRON2lT?=
 =?utf-8?B?aHhRNk9taFhKZ2tYZTJIREdhSE52OXFKZlV3cmtBZUpEbFBhQVUvWGZJWjEw?=
 =?utf-8?B?ak5zY3BFeTdGV2tkZlh3bVJKTFFScGI5YkhBTTdYMlJ2OEZwR0VCV3A4eVly?=
 =?utf-8?B?bWtOTkRXTEJMMXVNNGY0Ly9udlAxeEpPdTQwaVZCWWNkRWVHVVBKbm16MU1Y?=
 =?utf-8?B?UFpnRGN3UWFxV2xBbGdDbEx1VGt2SjlITzFyNDhuN1JidEhVUkNNVEEvKzBV?=
 =?utf-8?B?UDhMb0VGRUdMRUFaS3JHekpySDFzdGFWZE13WWF4T0pOSWVKMG1rVTR6SW9w?=
 =?utf-8?B?NHRjOXBjSzlva01LeUZnZ25qcmZZUzRpZWp3Y3ppWnl5NnoyU2xoYnAxeGhZ?=
 =?utf-8?B?Y1Q5bXlDeVp0RFlaT1lCY2JNVzBlbXVVK1dua2hhd1d6YU1DZkZtUWdMRHJR?=
 =?utf-8?B?c1lUTnNHODJ4dFlXY2crR3VFeVRPV0tSWHVqbUgxZmdBQkg5aGhzSXJQTWJQ?=
 =?utf-8?B?NFVSM2d5c21wQzBVMHRUZCswUVFaOEZhVVIveHUrQ3ZPbEV3OW5SZUV6cTI4?=
 =?utf-8?Q?A0u14h6HyUC8I7N0rx9Hm4lvL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47F2B252C757414DA2067543F443E907@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73620e62-43bb-414a-89e3-08da8a831cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 12:28:15.7130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/J1Pko5hHJX+/Lfr0KtEK6+qpRirJT7xA68c05mUI5N1/oKVLQFMs/Mc7GkTHUi2xW6TirNem5YsD6VnCY03b3KJqVyIQRprR25WDmdfNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2043
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxMzoyMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPltQQVRDSCB2MyAwLzVd
IEFkZCBQb2xhckZpcmUgU29DIEZhYnJpYyBDbG9jayBDb25kaXRpb25pbmcgQ2lyY3VpdHJ5IFN1
cHBvcnQNCj4gDQo+IENoYW5nZXMgc2luY2UgdjM6DQoNCndvb3BzLCBJIGZvcmdvdCB0byBpbmNy
ZW1lbnQgdGhlIHZlcnNpb24gbnVtYmVyIQ0KSSB3aWxsIHJlc2VuZC4NCg0KPiAtIHJldHVybiBk
ZXZtX29mX2Nsa19hZGRfaHdfcHJvdmlkZXIoKSBkaXJlY3RseSBpbiBwcm9iZQ0KPiAtIGFkZCBh
IGBod19kYXRhLm51bSA9IG51bV9jbGtzYCB0aGF0IGdvdCBsb3N0IGFsb25nIHRoZSB3YXkgc29t
ZXdoZXJlDQo+IC0gbWFyayBhbGwgb3V0cHV0IGNsb2NrcyBhcyBDTEtfRElWSURFUl9PTkVfQkFT
RUQNCj4gDQo+IENoYW5nZXMgc2luY2UgdjI6DQo+IC0gUmVtb3ZlZCB0aGUgdW5pbnRlbnRpb25h
bHkgbGVmdG92ZXIgY2xvY2stb3V0cHV0LW5hbWVzDQo+IC0gRHJvcHBlZCB0aGUgcmlzY3YvbWlj
cm9jaGlwIGR0LWJpbmRpbmcgdXBkYXRlLiBJIGFtIG1vdmluZyBpdCB0bw0KPiAgICBhbm90aGVy
IHNlcmllcyBzbyB0aGF0IGFub3RoZXIgc2VyaWVzIGZvciB0aGUgZHRzLCB3aGljaCBpcyBsaWtl
bHkgdG8NCj4gICAgYmUgYXBwbGllZCBmaXJzdCB3b3VsZCBub3QgZGVwZW5kIG9uIHRoaXMgc2Vy
aWVzLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gLSBTdG9wcGVkIHVzaW5nIHRoZSBkdCBu
b2RlIG5hbWUgdG8gZ2VuZXJhdGUgdGhlIGNsayBuYW1lLiBSYXRoZXIgdGhhbg0KPiAgICB1c2Ug
Y2xvY2stb3V0cHV0LW5hbWVzIGV0YywgSSBqdXN0IG9wdGVkIHRvIGNhbGwgZWFjaCBQTEwgYWZ0
ZXIgaXQncw0KPiAgICBpbmRpdmlkdWFsIGJhc2UgYWRkcmVzczoNCj4gICAgY2NjcmVmY2xrDQo+
ICAgICAgY2NjQDM4MTAwMDAwX3BsbDANCj4gICAgICAgIGNjY0AzODEwMDAwMF9wbGwwX291dDMN
Cj4gICAgICAgIGNjY0AzODEwMDAwMF9wbGwwX291dDINCj4gICAgICAgIGNjY0AzODEwMDAwMF9w
bGwwX291dDENCj4gICAgICAgIGNjY0AzODEwMDAwMF9wbGwwX291dDANCj4gLSBkdCBub2RlcyBh
cmUgbm93IGFsbCBjYWxsZWQgImNsb2NrLWNvbnRyb2xsZXIiDQo+IA0KPiBDb25vciBEb29sZXkg
KDUpOg0KPiAgICBkdC1iaW5kaW5nczogY2xrOiByZW5hbWUgbXBmcy1jbGtjZmcgYmluZGluZw0K
PiAgICBkdC1iaW5kaW5nczogY2xrOiBkb2N1bWVudCBQb2xhckZpcmUgU29DIGZhYnJpYyBjbG9j
a3MNCj4gICAgZHQtYmluZGluZ3M6IGNsazogYWRkIFBvbGFyRmlyZSBTb0MgZmFicmljIGNsb2Nr
IGlkcw0KPiAgICBjbGs6IG1pY3JvY2hpcDogYWRkIFBvbGFyRmlyZSBTb0MgZmFicmljIGNsb2Nr
IHN1cHBvcnQNCj4gICAgcmlzY3Y6IGR0czogbWljcm9jaGlwOiBhZGQgdGhlIG1wZnMnIGZhYnJp
YyBjbG9jayBjb250cm9sDQo+IA0KPiAgIC4uLi9iaW5kaW5ncy9jbG9jay9taWNyb2NoaXAsbXBm
cy1jY2MueWFtbCAgICB8ICA4MCArKysrKw0KPiAgIC4uLnAsbXBmcy55YW1sID0+IG1pY3JvY2hp
cCxtcGZzLWNsa2NmZy55YW1sfSB8ICAgMiArLQ0KPiAgIC4uLi9kdHMvbWljcm9jaGlwL21wZnMt
aWNpY2xlLWtpdC1mYWJyaWMuZHRzaSB8ICAyNyArLQ0KPiAgIC4uLi9ib290L2R0cy9taWNyb2No
aXAvbXBmcy1pY2ljbGUta2l0LmR0cyAgICB8ICAgNCArDQo+ICAgLi4uL2R0cy9taWNyb2NoaXAv
bXBmcy1wb2xhcmJlcnJ5LWZhYnJpYy5kdHNpIHwgICA1ICsNCj4gICBhcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL21pY3JvY2hpcC9tcGZzLmR0c2kgICAgICAgfCAgMzQgKy0NCj4gICBkcml2ZXJzL2Nsay9t
aWNyb2NoaXAvTWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvY2xr
L21pY3JvY2hpcC9jbGstbXBmcy1jY2MuYyAgICAgICAgICB8IDI5MCArKysrKysrKysrKysrKysr
KysNCj4gICAuLi4vZHQtYmluZGluZ3MvY2xvY2svbWljcm9jaGlwLG1wZnMtY2xvY2suaCAgfCAg
MjMgKysNCj4gICA5IGZpbGVzIGNoYW5nZWQsIDQ1MyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlv
bnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Nsb2NrL21pY3JvY2hpcCxtcGZzLWNjYy55YW1sDQo+ICAgcmVuYW1lIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay97bWljcm9jaGlwLG1wZnMueWFtbCA9PiBt
aWNyb2NoaXAsbXBmcy1jbGtjZmcueWFtbH0gKDk2JSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLWNjYy5jDQo+IA0KPiANCj4gYmFzZS1jb21t
aXQ6IGI5MGNiMTA1MzE5MDM1M2NjMzBmMGZlZjBlZjFmMzc4Y2NjMDYzYzUNCg0K
