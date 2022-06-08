Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC3542A39
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiFHJCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiFHJBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:01:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EAE212DAF;
        Wed,  8 Jun 2022 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654676430; x=1686212430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PvRgLsH+HQhmdQv9vtRbOiACxlxyLIfqTHxe014Cm3Q=;
  b=rWk0EtK6lx1h+DfDwRsLXnKNPIYJC7Bn4qvlitRUtrRfawkvUCltcH7K
   n+ENuVFgBm2zgBC2i6NynkDAwT1qD7K2KNc8ROYFrJW2pdxPDJXhOPOVt
   314EoXePmxL1CMqgAuy3AeZhJiWeZ8UqBJEW+eHWbyR/f0tR84JCdp98e
   iEiTr/rvtKuR3aQhLVcyZ9hq4UwoZl3zwy47FNwR7lTy48Z5BYgmyyIR5
   2JSSNYvwfD+UeDb8HMMlz28DSiHwLwTZrviojFkCZ6wREpfuKV+GcV2Up
   dp0WnTM0Rz4EMRryQw3L/Tholv01sGr4g+6l8cfGPmDDA5pPg85rtcq4A
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="177030712"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 01:20:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 01:20:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 8 Jun 2022 01:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7ufxRgLb5L3wCZKrloqghTIoUa0A8eZfKzcCkwHeglO/jUYK2plj5moWurFacKS5v204//Evc/Nq4aEwXSYB7jk0GgxK6lsgHIflNhRP652kDtEI0KiHW76dXranNuhs53Vw7PK/m/hfYYfCRVMLG5L9Yr3lc5cF3lLF0LEps49z/4jLJS0jNf6Ws4zilwFAu6y/NiRFByuzERoUoSPN0dkkgd0/dO12dBOZV0F6EW5boL5MAhdQiKsJ7PmvkIcVuHEZCSqxSr402bWpNA3KtFhxqLfq7WsVciAa/6QohO8oIBAa+wi8RY2KVR3c/A5+lXvFKrTVpLeB5S8G7aiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvRgLsH+HQhmdQv9vtRbOiACxlxyLIfqTHxe014Cm3Q=;
 b=fCe0lb4Oq5C73UwqrRH8ZlQYNC+BBu9JFYp5ATTmNC0EyGS9HWA26pglEVPHGgHMof27cFKMklAiJPeOq238Avg2LfwteBHgp1eQcb5sK3x9kZeGLhznQ0dwnV7SD/oE+V8duB6YLdOVpW4eYdKNm+A0UakX5g8MFRdUAcES19A8R5pKO55CNy8TQvV7zV19vphbRVTDmN7ewXMN5KePwRm8nnlNEhcYIIG6WfHLSF7LpesyEEpvsZo4BZkrgljc4QscDynKHOLSg/WNFSVLr9TDx/PJYQJ8jkWRWU1i9c9ReIE7jk1O68KeG8ah0c9lLS8dJ8cigNUsUGQkdON83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvRgLsH+HQhmdQv9vtRbOiACxlxyLIfqTHxe014Cm3Q=;
 b=NvP9/+i1Iim8SY4dXLMkGhIQzo7cnnQ1cHSGvNr/U5kXOhAxFiaEq40a+hTr2eC6JH3p/DfzGdUZoejLj9ykUXABRyUUdQR6Eh32DvzedlsNgqKNpIm8eBCXdQdSk3cWbjynvKZHa+PAUDkAQZ2AkcWwsXDlNDai4hn/+ecj+MU=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by CO1PR11MB4995.namprd11.prod.outlook.com (2603:10b6:303:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 08:20:25 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a%7]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 08:20:25 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: RE: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Topic: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Index: AQHYen2xLy/v/QXVdkSn5wTBKfw+1K1FH4sAgAAIsKA=
Date:   Wed, 8 Jun 2022 08:20:25 +0000
Message-ID: <CO1PR11MB4865879F14D49AF7550C2D1192A49@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-4-kavyasree.kotagiri@microchip.com>
 <9cf14336-16c3-5df5-b235-3f988d8b5151@microchip.com>
In-Reply-To: <9cf14336-16c3-5df5-b235-3f988d8b5151@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d38f77c-3093-40dd-01e2-08da4927bd85
x-ms-traffictypediagnostic: CO1PR11MB4995:EE_
x-microsoft-antispam-prvs: <CO1PR11MB4995517F5155395246BCC95D92A49@CO1PR11MB4995.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3DEMxDuYaVKJgg2f8couvOEAlTAiBmndlMYsMO9NTWkozsprwlP9UxrfT7ph+BSPu1twAl4KtG600zaO+Q+Q5e0qDNzRJ627+yA1PxLwA30E/v+1tTJr5+JWsLf2yMjfkZzkia4yaFIloSadPkCIrjIAnWbMdWJrHcdP+IunI9uVjFs0dX+GAVrObvpSrEZi3mzQa54AsjT78OQaF3t7C0+nk2piTv4h1HCrHI0LjjMoWTSZtq3qNeYltbPynVBxPWFBr2IYu1uKzic7ABiDQFx0yniBLTfLuSEAM52I3xbogXKOzC8SloHnimg6ZMpiIIEKIU2VHY6bVVtxEl9CxJ1v+88BIrG4wyjdx58KJs49Ewwi/MjwYk5Z6ESz9B5yX+zzu4hYqdjQozPllvQfkCfmU8QGXgJIAy2mSEr3nJPNREKrBuYRAdEkNAxl5tz6nVcjh62HxBReg39KFHQvqIpdOTjgm5NW+XBlsYkJaFy0WjHI/ouJUc+jXs377nJjToMKmwUEhXOtSJGRgu323ecOaRvD4dyuQKWUOl7ejvanDGMdRR2p6cLrQUjWFY0Md7LtpKOTb58gNlxO9LdERwK4Q/BSrTjEX0LM4x4snVdVR6+20aUaQHFETt+xg+a/ZGN7YVFA+x5SR1JKjb639DWW2UW6T9UjuJn/r0ClBn/DEstkPR4BakpK7dI9w0ctdKQxseLiNrt/qOq7Fvj5VOdOoDotnG2fKVgKmuWW5zz71zDjOR070zwmTBGlEUWOQ2JvyLV0i9CTW3L7nYXUSXjAaCzRMNJD+sp8mVe2Qao=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(55016003)(52536014)(38070700005)(86362001)(186003)(122000001)(54906003)(33656002)(76116006)(508600001)(66946007)(8676002)(66476007)(6862004)(66556008)(66446008)(64756008)(45080400002)(4326008)(6636002)(316002)(6506007)(2906002)(8936002)(966005)(9686003)(5660300002)(71200400001)(38100700002)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUZJSExKVVVnVUxzTkJlN0RhQnFKUXRGWElDaUwxeEpCTS8reEFadllJNytT?=
 =?utf-8?B?N1d4NzdqT0Q4YjdqaEpjdC9MOGNTbVFqOU1GcEVYclhhU25QK2hqQlllN2xN?=
 =?utf-8?B?SFZ5Y3VMQ0E2TEE5cU9xQlpZVWFrclRYMndZYUJlOGxkREFBaUxPeDRteGdj?=
 =?utf-8?B?R1VCSUxzcXg5V0lSWUJvSkUzMDU2dUZrWVNMVWdhS1B3YU55NmxTWVM5Y3FC?=
 =?utf-8?B?dDEwbXFRSEM5eW5YY2g0ZlI4YkgyM3lNQ1FKYi9HWnZNZStNSlJndE9VU2gw?=
 =?utf-8?B?cmJaWGRrcFZHd1JEcEI0OG5CalJORlExQzRUOGxIVjJFTHRSQmN6dFVIWThw?=
 =?utf-8?B?UUI4amRKdUVVZ2o4RXR5WnlUVGlpOUpINHYraFcyTXFRcDNYVU1NcjlGQksr?=
 =?utf-8?B?NXR2WTBLeDFRdWN6aWJsa0ZucU9jTkhKaG43ZUhCWnpvandadlJUVGt5ekNH?=
 =?utf-8?B?UGJMQm9HakVUUk5TdjdWUzBla1BsNVAxSVd5UVFkb29KUUxXZmRrZkd3dmto?=
 =?utf-8?B?NmdpN01tK3dFcDVqVDF4V1lJM3JZSStCQ01mMW16c0syeHZ1bjREczMzdHYz?=
 =?utf-8?B?MFdYcGtMUFBKaDVqazJseWpVNmVRb2tRMi9pREV3djZXdFhXRGVVMW5ESVRp?=
 =?utf-8?B?d3hpTmVQWTN5OElERTdaTlp1SzFlUE13TG1pejhsdVo0Qjc2cGppZ3NTcE9D?=
 =?utf-8?B?QnB0YUxGWTZtVVE4d21mNklWNzlVS3FpNEZEc3ZRaEdCOXNmK3ptcjRka2lW?=
 =?utf-8?B?L1l2Z1REWGxqdFlab05RK0Ewcm5EdDJiWGNhOFBsZ3FOMXZqY09KOHFkUFd2?=
 =?utf-8?B?RnFyaW1GS29UKy9yZUFkRklIYzhkSGc2U0hyS2p5blFRZWhabUZJU3NtOTdJ?=
 =?utf-8?B?Z2FyL0hJU1c2a3lJYXR2YnJZQVd4WEZyNm5iNm9UT1hmbEUvU3pJZ2ZNekFa?=
 =?utf-8?B?RXM0UHBKTjJBcWZ2MEJBWkxxaWc3bDFnbmlpbHlpREYvVUxKUGQ3NnEybUtl?=
 =?utf-8?B?U0VNTVIranZWK05oL0czM2tSTDc1ZXUvL29Wb1dsQVlMYm9uUlpIVEFTZ2t5?=
 =?utf-8?B?UGlMYVJCcDU2UHBwcUpwNGQ5Z3RWT1JmYTQ1cmY1cWlPOTZNNCttV3h4ZTZk?=
 =?utf-8?B?b0ZJa2w4cUMzWUU5blFMWnhRaGQrQmxWS1Nha0F4ZVU0UURiR3J3OXQzbEtQ?=
 =?utf-8?B?K3FHREtmaTA4WG05dk16VnFvQmNFbHliZUR6TURHYWtmSW05T2J4S1VoKzdl?=
 =?utf-8?B?TURBU3E0UnI3REhyNlhQMUY2Q2I5a2pVT2hXOFJ1aHlqemVBNElyL1BlKzJX?=
 =?utf-8?B?NzMwM2ZNMWlqcXJxQmU3RkRUdWhBODdPK3NWS3pzWkNKOVNpRnpXUTRpc2ZH?=
 =?utf-8?B?bUhXMitNNk12dEVBT0MwL3hiSCs2YitGYVlqZk1KS3BFM2NWTzl4bG1Oa0ZO?=
 =?utf-8?B?cjJxZzdDSFVmRGNHQi9TMVB6a0VkaHpsTWRQaE04c1pkMllFRGRGaWFIaHU1?=
 =?utf-8?B?aGdTai84azRZdmRjOFRnNHp4NkNmczk0bHkrS2p4ajgrUHhLaUVkM0RLaHVq?=
 =?utf-8?B?ZnZIZUJvS28zQWxnUTI4K09hV1hZcVdjSlZuYkVXcm91U0FocVlrQisvYU9w?=
 =?utf-8?B?UzA2bDdPK1hwTXhyT2t6enJkM3dKVGdYVm9zdGtrWE5JV1BjeXdkTG9zY0pP?=
 =?utf-8?B?RkNNOVFrOHlQT081Q2dBUVZLcGUzWGIxa1lyZ0dSb2E3U3oxblRQSWdnTTMv?=
 =?utf-8?B?U1M1akg5Q1dCbkk5SkhoUTRldW94NFV5VHFsRnBKVzVqc09HeExaNks4T2Y5?=
 =?utf-8?B?dHhOaTVXbnhEZGdiRDcvSm9BdUFaUzZYYjNqaUo2UUV4VUZrSEs3N1ordE9m?=
 =?utf-8?B?R1dVWDIzd1dOa1FiTGM5WjdMRmwwSU1sLzNBaGJ6amEwSjY1bVRSY2JiQTc1?=
 =?utf-8?B?MW9EREhSamgydVBCNnpMck5zdDhkalh1SENtV1RjeWU3RHU4RjlxUlYza3J6?=
 =?utf-8?B?WFNHdWw1S2JnR0xoblU5ekVwOHVMVVNYRDRvenQ1OTFLdEVsRDNSSEh4OXRV?=
 =?utf-8?B?dTQwQ2NvbnRmdVBmc2JKbzg0YU1hb1dTMnQ5bjAySWEzVnRORnByS0RZYkhk?=
 =?utf-8?B?RDVYanNneG1yRm1IdFlvVjF0c0J6OGdqS0MxWXFXdlpQajFkaTB0bW5WdVRL?=
 =?utf-8?B?MTZjUmx4V1VCeEptTzhBbGRBZC9LTDQ5SzNWNENNYTBUTG9YRTJYS2ZjWnNn?=
 =?utf-8?B?WWRUMHlhVXRGVkJIcVBFTlZTOUkxcTNqS2hDWUF4eUs1RlhHZ0l1N3dTNk84?=
 =?utf-8?B?dlhGSEFFVUZaVnRUMW1mTEtSeWZQUzlpY0JqTzZLMHpua1l6dmc0bVo4TkdL?=
 =?utf-8?Q?Ml4AG6DMPmVVE9M4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d38f77c-3093-40dd-01e2-08da4927bd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 08:20:25.8197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ko5T1bGq/PwHCRezfZMUKuu0TX6j1uIQXLv5wc7J+0Gc0Yk3/Z2KJIl1rKDoSY7aI3dY6wzV38nqwQLqpPnOpHU+UGL5B012BuTEzbr/FEdb5HsWF1SA+I7PlapfHl49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4995
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IExBTjk2NnggU29DIGhhdmUgNSBmbGV4Y29tcy4gRWFjaCBmbGV4Y29tIGhhcyAyIGNoaXAt
c2VsZWN0cy4NCj4gPiBGb3IgZWFjaCBjaGlwIHNlbGVjdCBvZiBlYWNoIGZsZXhjb20gdGhlcmUg
aXMgYSBjb25maWd1cmF0aW9uDQo+ID4gcmVnaXN0ZXIgRkxFWENPTV9TSEFSRURbMC00XTpTU19N
QVNLWzAtMV0uIFRoZSB3aWR0aCBvZg0KPiA+IGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgaXMgMjEg
YmVjYXVzZSB0aGVyZSBhcmUgMjEgc2hhcmVkIHBpbnMNCj4gPiBvbiBlYWNoIG9mIHdoaWNoIHRo
ZSBjaGlwIHNlbGVjdCBjYW4gYmUgbWFwcGVkLiBFYWNoIGJpdCBvZiB0aGUNCj4gPiByZWdpc3Rl
ciByZXByZXNlbnRzIGEgZGlmZmVyZW50IEZMRVhDT01fU0hBUkVEIHBpbi4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEthdnlhc3JlZSBLb3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1pY3Jv
Y2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gdjEgLT4gdjI6DQo+ID4gIC0gdXNlIEdFTk1BU0sgZm9y
IG1hc2ssIG1hY3JvcyBmb3IgbWF4aW11bSBhbGxvd2VkIHZhbHVlcy4NCj4gPiAgLSB1c2UgdTMy
IHZhbHVlcyBmb3IgZmxleGNvbSBjaGlwc2VsZWN0cyBpbnN0ZWFkIG9mIHN0cmluZ3MuDQo+ID4g
IC0gZGlzYWJsZSBjbG9jayBpbiBjYXNlIG9mIGVycm9ycy4NCj4gPg0KPiA+ICBkcml2ZXJzL21m
ZC9hdG1lbC1mbGV4Y29tLmMgfCA5Mw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jIGIv
ZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+ID4gaW5kZXggMzNjYWE0ZmJhNmFmLi5hYzcw
MGE4NWI0NmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+
ID4gKysrIGIvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+ID4gQEAgLTI4LDE1ICsyOCw2
OCBAQA0KPiA+ICAjZGVmaW5lIEZMRVhfTVJfT1BNT0RFKG9wbW9kZSkJKCgob3Btb2RlKSA8PA0K
PiBGTEVYX01SX09QTU9ERV9PRkZTRVQpICYJXA0KPiA+ICAJCQkJIEZMRVhfTVJfT1BNT0RFX01B
U0spDQo+ID4NCj4gPiArLyogTEFOOTY2eCBmbGV4Y29tIHNoYXJlZCByZWdpc3RlciBvZmZzZXRz
ICovDQo+ID4gKyNkZWZpbmUgRkxFWF9TSFJEX1NTX01BU0tfMAkweDANCj4gPiArI2RlZmluZSBG
TEVYX1NIUkRfU1NfTUFTS18xCTB4NA0KPiA+ICsjZGVmaW5lIEZMRVhfU0hSRF9QSU5fTUFYCTIw
DQo+ID4gKyNkZWZpbmUgRkxFWF9DU19NQVgJCTENCj4gPiArI2RlZmluZSBGTEVYX1NIUkRfTUFT
SwkJR0VOTUFTSygyMCwgMCkNCj4gPiArDQo+ID4gK3N0cnVjdCBhdG1lbF9mbGV4X2NhcHMgew0K
PiA+ICsJYm9vbCBoYXNfZmx4X2NzOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RydWN0IGF0bWVs
X2ZsZXhjb20gew0KPiA+ICAJdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ICsJdm9pZCBfX2lvbWVt
ICpmbGV4Y29tX3NoYXJlZF9iYXNlOw0KPiA+ICAJdTMyIG9wbW9kZTsNCj4gPiAgCXN0cnVjdCBj
bGsgKmNsazsNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgaW50IGF0bWVsX2ZsZXhjb21fbGFu
OTY2eF9jc19jb25maWcoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+
ICsJc3RydWN0IGF0bWVsX2ZsZXhjb20gKmRkYXRhID0gZGV2X2dldF9kcnZkYXRhKCZwZGV2LT5k
ZXYpOw0KPiA+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0K
PiA+ICsJdTMyIGZseF9zaHJkX3BpbnNbMl0sIGZseF9jc1syXSwgdmFsOw0KPiA+ICsJaW50IGVy
ciwgaSwgY291bnQ7DQo+ID4gKw0KPiA+ICsJY291bnQgPSBvZl9wcm9wZXJ0eV9jb3VudF91MzJf
ZWxlbXMobnAsICJtaWNyb2NoaXAsZmx4LXNocmQtDQo+IHBpbnMiKTsNCj4gPiArCWlmIChjb3Vu
dCA8PSAwIHx8IGNvdW50ID4gMikgew0KPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkludmFs
aWQgJXMgcHJvcGVydHkgKCVkKVxuIiwgImZseC1zaHJkLQ0KPiBwaW5zIiwNCj4gPiArCQkJCWNv
dW50KTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwllcnIg
PSBvZl9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheShucCwgIm1pY3JvY2hpcCxmbHgtc2hyZC1waW5z
IiwNCj4gZmx4X3NocmRfcGlucywgY291bnQpOw0KPiA+ICsJaWYgKGVycikNCj4gPiArCQlyZXR1
cm4gZXJyOw0KPiA+ICsNCj4gPiArCWVyciA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2FycmF5KG5w
LCAibWljcm9jaGlwLGZseC1jcyIsIGZseF9jcywNCj4gY291bnQpOw0KPiA+ICsJaWYgKGVycikN
Cj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBjb3VudDsg
aSsrKSB7DQo+ID4gKwkJaWYgKGZseF9zaHJkX3BpbnNbaV0gPiBGTEVYX1NIUkRfUElOX01BWCkN
Cj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJCWlmIChmbHhfY3NbaV0gPiBG
TEVYX0NTX01BWCkNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJCXZhbCA9
IH4oMSA8PCBmbHhfc2hyZF9waW5zW2ldKSAmIEZMRVhfU0hSRF9NQVNLOw0KPiA+ICsNCj4gPiAr
CQlpZiAoZmx4X2NzW2ldID09IDApDQo+ID4gKwkJCXdyaXRlbCh2YWwsIGRkYXRhLT5mbGV4Y29t
X3NoYXJlZF9iYXNlICsNCj4gRkxFWF9TSFJEX1NTX01BU0tfMCk7DQo+ID4gKwkJZWxzZQ0KPiA+
ICsJCQl3cml0ZWwodmFsLCBkZGF0YS0+ZmxleGNvbV9zaGFyZWRfYmFzZSArDQo+IEZMRVhfU0hS
RF9TU19NQVNLXzEpOw0KPiANCj4gVGhlcmUgaXMgc3RpbGwgYW4gb3BlbiBxdWVzdGlvbiBvbiB0
aGlzIHRvcGljIGZyb20gcHJldmlvdXMgdmVyc2lvbi4NCj4gDQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1hcm0ta2VybmVsL1BIMFBSMTFNQjQ4NzI0REUwOUE1MEQ2N0YxRUE5RkJFMDky
RDg5QFBIMFBSMTFNQjQ4NzIubmFtcHJkMTEucHJvZC5vdXRsb29rLmNvbS8NCkFzIHBhcnQgb2Yg
Y29tbWVudHMgZnJvbSBQZXRlciBSb3NpbiAtIEluc3RlYWQgb2YgdXNpbmcgbXV4IGRyaXZlciwg
VGhpcyBwYXRjaCBpcyBpbnRyb2R1Y2luZyANCm5ldyBkdC1wcm9wZXJ0aWVzIGluIGF0bWVsLWZs
ZXhvbSBkcml2ZXIgaXRsc2VsZiB0byBjb25maWd1cmUgRmxleGNvbSBzaGFyZWQgcmVnaXN0ZXJz
LiANCkJhc2VkIG9uIHRoZSBjaGlwLXNlbGVjdCgwIG9yIDEpIHRvIGJlIG1hcHBlZCB0byBmbGV4
Y29tIHNoYXJlZCBwaW4sIHdyaXRlIHRvIHRoZQ0KcmVzcGVjdGl2ZSByZWdpc3Rlci4gDQpJZiB5
b3Ugc3RpbGwgaGF2ZSBhbnkgcXVlc3Rpb25zLCBwbGVhc2UgY29tbWVudC4NCg0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IGF0
bWVsX2ZsZXhjb21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgew0K
PiA+ICAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ICsJ
Y29uc3Qgc3RydWN0IGF0bWVsX2ZsZXhfY2FwcyAqY2FwczsNCj4gPiAgCXN0cnVjdCByZXNvdXJj
ZSAqcmVzOw0KPiA+ICAJc3RydWN0IGF0bWVsX2ZsZXhjb20gKmRkYXRhOw0KPiA+ICAJaW50IGVy
cjsNCj4gPiBAQCAtNzYsMTMgKzEyOSw1MSBAQCBzdGF0aWMgaW50IGF0bWVsX2ZsZXhjb21fcHJv
YmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCSAqLw0KPiA+ICAJd3Jp
dGVsKEZMRVhfTVJfT1BNT0RFKGRkYXRhLT5vcG1vZGUpLCBkZGF0YS0+YmFzZSArDQo+IEZMRVhf
TVIpOw0KPiA+DQo+ID4gKwljYXBzID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5k
ZXYpOw0KPiA+ICsJaWYgKCFjYXBzKSB7DQo+ID4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ291
bGQgbm90IHJldHJpZXZlIGZsZXhjb20gY2Fwc1xuIik7DQo+ID4gKwkJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKGRkYXRhLT5jbGspOw0KPiANCj4gQ291bGQgeW91IGtlZXAgYSBjb21tb24gcGF0aCB0
byBkaXNhYmxlIHRoZSBjbG9jaz8gQSBnb3RvIGxhYmVsIHNvbWV0aGluZw0KPiBsaWtlIHRoaXM6
DQo+IAkJcmV0ID0gLUVJTlZBTDsNCj4gCQlnb3QgY2xrX2Rpc2FibGVfdW5wcmVwYXJlOw0KPiAN
Cj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoY2Fwcy0+
aGFzX2ZseF9jcykgew0KPiA+ICsJCWRkYXRhLT5mbGV4Y29tX3NoYXJlZF9iYXNlID0NCj4gZGV2
bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMSwgTlVMTCk7DQo+ID4g
KwkJaWYgKElTX0VSUihkZGF0YS0+ZmxleGNvbV9zaGFyZWRfYmFzZSkpIHsNCj4gPiArCQkJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGRkYXRhLT5jbGspOw0KPiA+ICsJCQlyZXR1cm4gZGV2X2Vycl9w
cm9iZSgmcGRldi0+ZGV2LA0KPiA+ICsJCQkJCVBUUl9FUlIoZGRhdGEtDQo+ID5mbGV4Y29tX3No
YXJlZF9iYXNlKSwNCj4gPiArCQkJCQkiZmFpbGVkIHRvIGdldCBmbGV4Y29tIHNoYXJlZCBiYXNl
DQo+IGFkZHJlc3NcbiIpOw0KPiAJCQlyZXQgPSBkZXZfZXJyX3Byb2JlKC4uLik7DQo+IAkJCWdv
dG8gY2xrX2Rpc2FibGVfdW5wcmVwYXJlOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJZXJyID0g
YXRtZWxfZmxleGNvbV9sYW45NjZ4X2NzX2NvbmZpZyhwZGV2KTsNCj4gPiArCQlpZiAoZXJyKSB7
DQo+ID4gKwkJCWNsa19kaXNhYmxlX3VucHJlcGFyZShkZGF0YS0+Y2xrKTsNCj4gPiArCQkJcmV0
dXJuIGVycjsNCj4gCQkJZ290byBjbGtfZGlzYWJsZV91bnByZXBhcmU7DQo+ID4gKwkJfQ0KPiA+
ICsJfQ0KPiA+ICsNCj4gDQo+IGNsa191bnByZXBhcmU6DQo+ID4gIAljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoZGRhdGEtPmNsayk7DQo+IAlpZiAocmV0KQ0KPiAJCXJldHVybiByZXQ7DQo+ID4NCj4g
PiAgCXJldHVybiBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKCZwZGV2LT5kZXYpOw0KPiA+ICB9
DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhdG1lbF9mbGV4X2NhcHMgYXRtZWxfZmxl
eGNvbV9jYXBzID0ge307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF0bWVsX2Zs
ZXhfY2FwcyBsYW45NjZ4X2ZsZXhjb21fY2FwcyA9IHsNCj4gPiArCS5oYXNfZmx4X2NzID0gdHJ1
ZSwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IGF0bWVsX2ZsZXhjb21fb2ZfbWF0Y2hbXSA9IHsNCj4gPiAtCXsgLmNvbXBhdGlibGUgPSAiYXRt
ZWwsc2FtYTVkMi1mbGV4Y29tIiB9LA0KPiA+ICsJew0KPiA+ICsJCS5jb21wYXRpYmxlID0gImF0
bWVsLHNhbWE1ZDItZmxleGNvbSIsDQo+ID4gKwkJLmRhdGEgPSAmYXRtZWxfZmxleGNvbV9jYXBz
LA0KPiA+ICsJfSwNCj4gPiArDQo+ID4gKwl7DQo+ID4gKwkJLmNvbXBhdGlibGUgPSAibWljcm9j
aGlwLGxhbjk2NngtZmxleGNvbSIsDQo+ID4gKwkJLmRhdGEgPSAmbGFuOTY2eF9mbGV4Y29tX2Nh
cHMsDQo+ID4gKwl9LA0KPiA+ICsNCj4gPiAgCXsgLyogc2VudGluZWwgKi8gfQ0KPiA+ICB9Ow0K
PiA+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhdG1lbF9mbGV4Y29tX29mX21hdGNoKTsNCg0K
