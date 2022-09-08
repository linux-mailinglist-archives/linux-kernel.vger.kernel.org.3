Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2751D5B1C26
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiIHMF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIHMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:05:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83998F56EB;
        Thu,  8 Sep 2022 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662638752; x=1694174752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tO1NgdDllzZ9bORM5IcsssBAUO166s8MsLoeJc3I9LU=;
  b=FrbYwp2XFgJ+wJGchJ6NBVoILZk+5OBVKDkH3ytj5tSobyyeAz01QZ2v
   Pmdm9f+eENG8uji6jr/4kE/y5FOxxzMHtj3CzZW/3xj+4DWsTMLfZXAsf
   H+052B2gBJQuJbkk1Ow1TSwLdDmO9DeOU+8oeWZEz9vxmDPsUVZsNvb8P
   tdhqR4FGJGHa2ImQabzvM/O/ue9YRounQ0OlPC8nPJPvnghWxWuYBOV5C
   ouVZJqvZdNwBWuQ488T2TDHXiNp1onAB+6idR+9wHDRtSWbl9rCUqmdfD
   NVl5cCoQQQSQ9QlHCGcilq0bs5khARDKy8F89umMdfEvf7GfvgzhEUHf3
   A==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="189956732"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 05:05:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 05:05:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 05:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYhy8EDYIjAt9sgsQoBL7vUUeOwJr7btPxsIs96FJPaf8C22zaLNh4jvYJuy/VMTovcP1nxWElWftaQSFdisBAyoNYOpkqsv0VDcjw5Q7DoWToBbwRogZ/3QymE3otfs8a4KfJVTcaAnDXahsATdViufSHnm8gaV9i4hBep6MmB9aGirIcNUiyXnC5h2/fm869C1kd3AGCkgeViR/tMW/5hnYkanbbZA62N7kuAb6OMkkire34md4lWtecxzMs3hSBLab8O5h//korBNFv36O5i65FZS6olKEWBcODnvbTFDeaQiAZbiiA0chi+FzIrJdgqul5V0wowrC6RxeYgh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO1NgdDllzZ9bORM5IcsssBAUO166s8MsLoeJc3I9LU=;
 b=dvFHsqhjn/FwwkHXuYVYuW3cwMlG2ggZff4XAoV4AVOv3pkTzSQ83Im3m9AxHyJNsHe1lNRs1xswcF+cdNAkGjd4zw7c3cmb/Q9/fJ0qa3f7g1jIR+EjbhWxX45X8edh5Wp5gzFaH71Sy7Rd0feZOhpadMnFjMiU7QcFkuLvvsQ/7dv6nsO6y5N4OAJZsJI0x3AXMt50ATFKZytHT1pUR5n+xmdbXMxKL3gzv9XUJSt0V0U0/T/s1ysHpcIU2z1ljSswa0b3Bxw3LfugMVLgIN3EY2QBxI6dM8e6FFFKRmvNRsfgDQWwXdMFtoR+VRHq3l87FJw0MoZRU1m7uoeioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO1NgdDllzZ9bORM5IcsssBAUO166s8MsLoeJc3I9LU=;
 b=V/+qKLWUVJuv+WacGgX23vATTZPrIk17jwW078up5kmx/wBxo9InXAElm6GqVava/oAbJbq2FbRcuTF6p0sWatURV8HNWP8BcCRyiIwbNTL3NLXXSUuqSFPWP2zrWsq/qec9iYriwB3edXQDzLuPt6BNUcMZYxjY7SzKP1aSKDc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB6675.namprd11.prod.outlook.com (2603:10b6:510:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 12:05:37 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 12:05:37 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Shravan.Chippa@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Daire.McNamara@microchip.com>, <Shravan.Chippa@microchip.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Cyril.Jean@microchip.com>,
        <Lewis.Hanly@microchip.com>, <Praveen.Kumar@microchip.com>,
        <wg@aries-embedded.de>, <Hugh.Breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/10] riscv: dts: microchip: add a devicetree for
 aries' m100pfsevp
Thread-Topic: [PATCH v4 10/10] riscv: dts: microchip: add a devicetree for
 aries' m100pfsevp
Thread-Index: AQHYw3TW0pnsugvpR0mwdYiwn3LqnK3VZX2AgAAKIIA=
Date:   Thu, 8 Sep 2022 12:05:37 +0000
Message-ID: <f5eab239-3814-c2ce-e0b5-42397e8c1755@microchip.com>
References: <20220908111712.665287-1-conor.dooley@microchip.com>
 <20220908111712.665287-11-conor.dooley@microchip.com>
 <CO6PR11MB5604046550E3D74CBBC8E94681409@CO6PR11MB5604.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB5604046550E3D74CBBC8E94681409@CO6PR11MB5604.namprd11.prod.outlook.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH7PR11MB6675:EE_
x-ms-office365-filtering-correlation-id: d804685d-5e69-4bb3-8e32-08da91927113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KKGI6JmO6J6UMhz7aVPTo5vaWbmXZmofx34WCXq5iU60A/pZ1fSdOwaL8aHehqfJtTr8OiSKiShF00TdqrmYJGuneqkbsB108eVI3JH/1U+nLDLPVB2GDjhkW8baxhkW3txqcEEswg0PYtlW2eSWkNCGMlx1m7/asWpgCF8RMqUHqGUrteJ9kQq0PrAmE85xtcFBKuhnMIhGH/kVS0tsvu267dYYETREk1rpZ5lQWhA3C/tLd08vtyQj7rElW1ri/Y/MOeZpH5UGT5N26VZoRyz9ciz7hesMmWXGam9cpQwPmyEWtccMfjJ3Bl3iTICKO7/FSciOgdHo05FcFi+HHoIprMLWAzOre+ENf3NOrRnRpodMK65ez243Pu5cS0XQYS1R3T15urIJWncNsVLOaJG3/8a9d9ARW7M9uZcgf1qs5q5JYBPIHkdkeucUccmJ+9biDv33rvGe4gh0OmmgRzjXeiqfdUCqrX03RESlREbr934QS+ZtsBlKy6NhO34AEnepV4FRocA9nWxYRGQlROmvD4LysVJ4CiGmrf+TKL20pQIJcuWB7DdEJVTsjtgbLpL9jHjlAeOEiiKR28wMMTtnciX1iT3kxVLDs/ifZvAkyS0NDRKImySttX+TD/lwEg2iryAgvGWZEpqH8QoSPWT27j9yX0AULt6Eu2N/m26ivoGBACXvTJasWgSHDcQIxPSU07LdcAF6/71/AGvmbzWpaxScW0wE+dKNR0MH23CKwAU96k373P2S7QDx/sQa6S3xeHh9TgLuWN/FuigmXd0IUHT34Gn/vvAMTKSu3dj+zT5oopapgG9bBrVjUFIt5iJYXpdhgoEuZIDzwJayBCwvo4N7Zm56/fEk5Zvi5My1enZ6Wgg0M9+GT93oJ1T+SNcb8wftCZ8AMwSspnNxcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(376002)(136003)(366004)(5660300002)(38070700005)(41300700001)(83380400001)(86362001)(6512007)(26005)(6506007)(38100700002)(53546011)(122000001)(84970400001)(31696002)(2616005)(186003)(31686004)(91956017)(36756003)(6862004)(4326008)(8676002)(66476007)(66556008)(64756008)(8936002)(66946007)(54906003)(71200400001)(478600001)(37006003)(76116006)(966005)(2906002)(6486002)(66446008)(316002)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2RsSEhnZmI2Y1pLRXo2NThNWjEwVHFhcm93QUFUcWdKMmNIdVFWQ3EySGdN?=
 =?utf-8?B?TjB2SlBUSVVkZjR1K3pmQms2M2JFM2M1eWtuaGtqWFkzWW9MSXozN2xaL1FE?=
 =?utf-8?B?Z25Ba081QndMUnl2bkZwaHZHT2dFNW8yVWlzZTFwYzZCL3hwMFU3ZTVHUzA0?=
 =?utf-8?B?a1BCZGJYdDZPY2hCT2QvSXlZRmkxdHd0S3VQMSsxRGI3TEwvTlhydGdYc0Iz?=
 =?utf-8?B?bk9HMDJaK0FUSllOajhIWVh6dTB1TzcvdWpXdmlpci94Q2JMWkdNeDRHeTBH?=
 =?utf-8?B?OGcydUNlSytsM2ltbXNsRTNVTFlVL1YyUXpQWERXZ3hPTmdKOXVZZDhrK3h4?=
 =?utf-8?B?UjZ4OTdFZllzOFV6U1pwNkY1N2tkdGJlMHQyWGsra0JqOWJtczM2aEF2bUky?=
 =?utf-8?B?Q2RkODBPVFgrUHFVcEptc3JKNkxYNWpZdm5XaHlpUE1BeTRpcDM4RzRUODNv?=
 =?utf-8?B?WUFGanZTbmpQZ0o2TGVGMXRZRkJhQ1JqOVpicUJCTzBuMDV5MXNzL1p6OWU3?=
 =?utf-8?B?SlBzM2wxbDBZVHJEZ2N4SldEeTZpSmcrN096b0JyRGdWOWxpQWEyRHJLZC8x?=
 =?utf-8?B?bXVqVjdMWjl4TWZ0clA0WFZPbCt1ZXh5elhYQ3JLektpb3A3eEJVcmVUNWJh?=
 =?utf-8?B?blpjcCtOY3JQMjNSS2NvV2xhbjdOdjR6RXFzTm1wK1JnbVZVMXlKMjNvOGJS?=
 =?utf-8?B?dTUyaHI2WFR0d2VPcEVaQ2hPSFRacFVSaTQ2dUdHZjhKSUpYUEFicDcxYnhr?=
 =?utf-8?B?MEF4ajdpSjAyTGRoY0dja2cvelRmUi9kTVNhdHFaNGdJcW1KUXcvTy8wZEds?=
 =?utf-8?B?R0lacjJNOUtyQUp3aDFiSWhOclZHWU10MzRJTURwYll3d1RPL0VqV0dvbUVN?=
 =?utf-8?B?NDJPSGdCaDNLekJYYTBzUk1BNmlJMVlQbTFRY0xkU003a1QyeGpMN2U3WTBv?=
 =?utf-8?B?di81QzFhdjJRS0I4TkM5MHR5SnUwQmZQa3ArV1dUK2xHK2w5YzFKbTYvNWpQ?=
 =?utf-8?B?bnlvaHZhUnJuNXR5QVg2Y3ZiVUNITHRqUkJFVWdKMERNc1EySlArOER6Zjlz?=
 =?utf-8?B?VEhIcC9Xd2lxOUQzODJYajRSUThseEs4TXczak1Fb3VyN1FHSUFsVDI3eWkv?=
 =?utf-8?B?YzcwWlUybFBVYXhJeUt5elV0S3NtdkVSbi9hajlvL25iSmdscXluWnU1T1dT?=
 =?utf-8?B?WjJJc292NklUdytoNDJkWVFoWTJ2RjNxS3ViZkwvSnVrWXc1Nk4zRFFudGZ3?=
 =?utf-8?B?dW1uQ3ZpejlyaGpLNkdVeU9CbWxCWkczb0dlSEZjdTBOMWk5alljNjhQSzMr?=
 =?utf-8?B?NmpFQWxEb0NoVEh1MjI5QytnRndBWktQUC9ESHhISWsyODAyc20rcnVOaUYv?=
 =?utf-8?B?SDlxOFN0NWNIT21ZQUsvVjFvd2lXa01SeUhobHg2VlIvN0IyTGRwc1h6MGc5?=
 =?utf-8?B?aWg3SjhVeWZrTjBML0dEN0hrVjFZSXVzRHF2ei9nckJlekQxNHZDamNzTFJv?=
 =?utf-8?B?L1o1SUlJM3BVQjkySzIwN1kvdzVpd1VpS1Y1OXNuQ1FuZVdvU05TVWgvbC9r?=
 =?utf-8?B?cTNQdnVQUWtFMTRuMFR1NmUxU1g2YzU4K0VKS0pkYTBDSU85N3ZqZ1NFQzky?=
 =?utf-8?B?SnlZaFRKNEZ6b2tJR3pNZ3pHdG5wM1J2bkVxM0hQSDYrWVVFRGR6ZGpja2tH?=
 =?utf-8?B?UWlkTTdCREk3dVNBYko3TGYxR043RGtKR0wvclhCMm8zOTQrZWt6OUtYWWlD?=
 =?utf-8?B?cWUzRVUyVUwxTUN5UTlJN3dQQzdjaTlKaDZoS1JZRmN6SmtZUGw5MTk4VEpi?=
 =?utf-8?B?QTBiNUR6NHE0NlJtQkNOS3ZqaCtna2tiYWFvdG9MRmdLYlJ5QjdBQSs0cGdQ?=
 =?utf-8?B?clF3bUNEOTlOU1c5NTFMNUczTUhyZENlNGxMMmcwTHhXWjFiVGpVZmFzREw0?=
 =?utf-8?B?Z3ZNaURqakpBZTlrTDRYU3MvbDBDYndkV0lKOVV6NHlxazJIV1NHSGtORGRU?=
 =?utf-8?B?a3ErUjRjWjArK3diT2RId0NBVlVTS0dLMDMxMEl4aEhMTi9kendGaWlwcWtK?=
 =?utf-8?B?SFpScFgzSDFjN2FzNjMza3dQcktXK0paQkEzQ3N6VGtkSlB4c3ZMcitOakpU?=
 =?utf-8?Q?Ea7A7xJNdg9HdbagVDtetI6e3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <522A16105D92F249949C351160618558@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d804685d-5e69-4bb3-8e32-08da91927113
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 12:05:37.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j7Iw15OTH5YpGWdT4JFh5dK3jSlRORF4tFLUZrNRIgmgnzNQBMULBPVP+c/BzWZJGRUasweYHW+TvtyTXlEbWljeajJI7FYhzJTM9sU6Bc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6675
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFNocmF2YW4sDQpQbGVhc2UgZG9uJ3QgZHJvcCB0aGUgbGlzdHMgZXRjIGZyb20gQ0MuDQoN
Ck9uIDA4LzA5LzIwMjIgMTI6MjksIHNocmF2YW4gQ2hpcHBhIC0gSTM1MDg4IHdyb3RlOj4NCj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
LmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4gU2VudDogMDggU2VwdGVtYmVyIDIwMjIgMDQ6NDcg
UE0NCj4+IFRvOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtv
emxvd3NraQ0KPj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9yIERv
b2xleSAtIE01MjY5MQ0KPj4gPENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tPjsgRGFpcmUgTWNO
YW1hcmEgLSBYNjE1NTMNCj4+IDxEYWlyZS5NY05hbWFyYUBtaWNyb2NoaXAuY29tPjsgc2hyYXZh
biBDaGlwcGEgLSBJMzUwODgNCj4+IDxTaHJhdmFuLkNoaXBwYUBtaWNyb2NoaXAuY29tPg0KPj4g
Q2M6IFBhdWwgV2FsbXNsZXkgPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbT47IFBhbG1lciBEYWJi
ZWx0DQo+PiA8cGFsbWVyQGRhYmJlbHQuY29tPjsgQWxiZXJ0IE91IDxhb3VAZWVjcy5iZXJrZWxl
eS5lZHU+OyBDeXJpbCBKZWFuIC0NCj4+IE0zMTU3MSA8Q3lyaWwuSmVhbkBtaWNyb2NoaXAuY29t
PjsgTGV3aXMgSGFubHkgLSBNMzQ3ODINCj4+IDxMZXdpcy5IYW5seUBtaWNyb2NoaXAuY29tPjsg
UHJhdmVlbiBLdW1hciAtIEkzMDcxOA0KPj4gPFByYXZlZW4uS3VtYXJAbWljcm9jaGlwLmNvbT47
IFdvbGZnYW5nIEdyYW5kZWdnZXIgPHdnQGFyaWVzLQ0KPj4gZW1iZWRkZWQuZGU+OyBIdWdoIEJy
ZXNsaW4gLSBNMzE4NjQgPEh1Z2guQnJlc2xpbkBtaWNyb2NoaXAuY29tPjsNCj4+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC0NCj4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+IFN1YmplY3Q6IFtQQVRDSCB2NCAxMC8x
MF0gcmlzY3Y6IGR0czogbWljcm9jaGlwOiBhZGQgYSBkZXZpY2V0cmVlIGZvciBhcmllcycNCj4+
IG0xMDBwZnNldnANCj4+DQo+PiBBZGQgZGV2aWNlIHRyZWVzIGZvciBib3RoIGNvbmZpZ3MgdXNl
ZCBieSB0aGUgQXJpZXMgRW1iZWRkZWQgTTEwMFBGU0VWUC4NCj4+IFRoZSBNMTAwT0ZTRVZQIGNv
bnNpc3RzIG9mIGEgTVBGUzI1MFQgb24gYSBTT00sDQo+PiBmZWF0dXJpbmc6DQo+PiAtIDJHQiBE
RFI0IFNEUkFNIGRlZGljYXRlZCB0byB0aGUgSE1TDQo+PiAtIDUxMk1CIEREUjQgU0RSQU0gZGVk
aWNhdGVkIHRvIHRoZSBGUEdBDQo+PiAtIDMyIE1CIFNQSSBOT1IgRmxhc2gNCj4+IC0gNCBHQnl0
ZSBlTU1DDQo+Pg0KPj4gYW5kIGEgY2FycmllciBib2FyZCB3aXRoOg0KPj4gLSAyeCBHaWdhYml0
IEV0aGVybmV0DQo+PiAtIFVTQg0KPj4gLSAyeCBVQVJUDQo+PiAtIDJ4IENBTg0KPj4gLSBURlQg
Y29ubmVjdG9yDQo+PiAtIEhTTUMgZXh0ZW5zaW9uIGNvbm5lY3Rvcg0KPj4gLSAzeCBQTU9EIGV4
dGVuc2lvbiBjb25uZWN0b3JzDQo+PiAtIG1pY3JvU0QtY2FyZCBzbG90DQo+Pg0KPj4gTGluazog
aHR0cHM6Ly93d3cuYXJpZXMtZW1iZWRkZWQuY29tL3BvbGFyZmlyZS1zb2MtZnBnYS1taWNyb3Nl
bWktDQo+PiBtMTAwcGZzLXNvbS1tcGZzMDI1dC1wY2llLXNlcmRlcw0KPj4gTGluazogaHR0cHM6
Ly93d3cuYXJpZXMtZW1iZWRkZWQuY29tL2V2YWx1YXRpb24ta2l0L2ZwZ2EvcG9sYXJmaXJlLQ0K
Pj4gbWljcm9jaGlwLXNvYy1mcGdhLW0xMDBwZnNldnAtcmlzY3YtaHNtYy1wbW9kDQo+PiBMaW5r
OiBodHRwczovL2Rvd25sb2Fkcy5hcmllcy0NCj4+IGVtYmVkZGVkLmRlL3Byb2R1Y3RzL00xMDBQ
RlMvSGFyZHdhcmUvTTEwMFBGU0VWUC1TY2hlbWF0aWNzLnBkZg0KPj4gQ28tZGV2ZWxvcGVkLWJ5
OiBXb2xmZ2FuZyBHcmFuZGVnZ2VyIDx3Z0Bhcmllcy1lbWJlZGRlZC5kZT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFdvbGZnYW5nIEdyYW5kZWdnZXIgPHdnQGFyaWVzLWVtYmVkZGVkLmRlPg0KPj4gU2ln
bmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtbTEwMHBm
c2V2cC5kdHMNCj4+IGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1tMTAwcGZz
ZXZwLmR0cw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4u
MTg0Y2IzNmExNzVlDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9hcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL21pY3JvY2hpcC9tcGZzLW0xMDBwZnNldnAuZHRzDQo+PiBAQCAtMCwwICsxLDE3OSBAQA0K
Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArLyoNCj4+ICsgKiBP
cmlnaW5hbCBhbGwtaW4tb25lIGRldmljZXRyZWU6DQo+PiArICogQ29weXJpZ2h0IChDKSAyMDIx
LTIwMjIgLSBXb2xmZ2FuZyBHcmFuZGVnZ2VyIDx3Z0Bhcmllcy0NCj4+IGVtYmVkZGVkLmRlPg0K
Pj4gKyAqIFJld3JpdHRlbiB0byB1c2UgaW5jbHVkZXM6DQo+PiArICogQ29weXJpZ2h0IChDKSAy
MDIyIC0gQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4gICovDQo+PiAr
L2R0cy12MS87DQo+PiArDQo+PiArI2luY2x1ZGUgIm1wZnMuZHRzaSINCj4+ICsjaW5jbHVkZSAi
bXBmcy1tMTAwcGZzLWZhYnJpYy5kdHNpIg0KPj4gKw0KPj4gKy8qIENsb2NrIGZyZXF1ZW5jeSAo
aW4gSHopIG9mIHRoZSBydGNjbGsgKi8NCj4+ICsjZGVmaW5lIE1USU1FUl9GUkVRCTEwMDAwMDAN
Cj4+ICsNCj4+ICsvIHsNCj4+ICsJbW9kZWwgPSAiQXJpZXMgRW1iZWRkZWQgTTEwMFBGRVZQUyI7
DQo+PiArCWNvbXBhdGlibGUgPSAiYXJpZXMsbTEwMHBmc2V2cCIsICJtaWNyb2NoaXAsbXBmcyI7
DQo+PiArDQo+PiArCWFsaWFzZXMgew0KPj4gKwkJZXRoZXJuZXQwID0gJm1hYzA7DQo+PiArCQll
dGhlcm5ldDEgPSAmbWFjMTsNCj4+ICsJCXNlcmlhbDAgPSAmbW11YXJ0MDsNCj4+ICsJCXNlcmlh
bDEgPSAmbW11YXJ0MTsNCj4+ICsJCXNlcmlhbDIgPSAmbW11YXJ0MjsNCj4+ICsJCXNlcmlhbDMg
PSAmbW11YXJ0MzsNCj4+ICsJCXNlcmlhbDQgPSAmbW11YXJ0NDsNCj4+ICsJCWdwaW8wID0gJmdw
aW8wOw0KPj4gKwkJZ3BpbzEgPSAmZ3BpbzI7DQo+PiArCX07DQo+PiArDQo+PiArCWNob3NlbiB7
DQo+PiArCQlzdGRvdXQtcGF0aCA9ICJzZXJpYWwxOjExNTIwMG44IjsNCj4+ICsJfTsNCj4+ICsN
Cj4+ICsJY3B1cyB7DQo+PiArCQl0aW1lYmFzZS1mcmVxdWVuY3kgPSA8TVRJTUVSX0ZSRVE+Ow0K
Pj4gKwl9Ow0KPj4gKw0KPj4gKwlkZHJjX2NhY2hlX2xvOiBtZW1vcnlAODAwMDAwMDAgew0KPj4g
KwkJZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4+ICsJCXJlZyA9IDwweDAgMHg4MDAwMDAwMCAw
eDAgMHg0MDAwMDAwMD47DQo+PiArCX07DQo+PiArCWRkcmNfY2FjaGVfaGk6IG1lbW9yeUAxMDQw
MDAwMDAwIHsNCj4+ICsJCWRldmljZV90eXBlID0gIm1lbW9yeSI7DQo+PiArCQlyZWcgPSA8MHgx
MCAweDQwMDAwMDAwIDB4MCAweDQwMDAwMDAwPjsNCj4+ICsJfTsNCj4+ICt9Ow0KPj4gKw0KPj4g
KyZjYW4wIHsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJmkyYzAg
ew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmaTJjMSB7DQo+PiAr
CXN0YXR1cyA9ICJva2F5IjsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZncGlvMCB7DQo+PiArCWludGVy
cnVwdHMgPSA8MTM+LCA8MTQ+LCA8MTU+LCA8MTY+LA0KPj4gKwkJICAgICA8MTc+LCA8MTg+LCA8
MTk+LCA8MjA+LA0KPj4gKwkJICAgICA8MjE+LCA8MjI+LCA8MjM+LCA8MjQ+LA0KPj4gKwkJICAg
ICA8MjU+LCA8MjY+Ow0KPiANCj4gQ29tbWVudGVkIGJlbGxvdy4uLg0KPiANCj4+ICsJbmdwaW9z
ID0gPDE0PjsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gKw0KPj4gKwlwbWljLWlycS1ob2cg
ew0KPj4gKwkJZ3Bpby1ob2c7DQo+PiArCQlncGlvcyA9IDwxMyAwPjsNCj4+ICsJCWlucHV0Ow0K
Pj4gKwl9Ow0KPj4gKw0KPj4gKwkvKiBTZXQgdG8gbG93IGZvciBlTU1DLCBoaWdoIGZvciBTRC1j
YXJkICovDQo+PiArCW1tYy1zZWwtaG9nIHsNCj4+ICsJCWdwaW8taG9nOw0KPj4gKwkJZ3Bpb3Mg
PSA8MTIgMD47DQo+PiArCQlvdXRwdXQtaGlnaDsNCj4+ICsJfTsNCj4+ICt9Ow0KPj4gKw0KPj4g
KyZncGlvMiB7DQo+PiArCWludGVycnVwdHMgPSA8MTM+LCA8MTQ+LCA8MTU+LCA8MTY+LA0KPj4g
KwkJICAgICA8MTc+LCA8MTg+LCA8MTk+LCA8MjA+LA0KPj4gKwkJICAgICA8MjE+LCA8MjI+LCA8
MjM+LCA8MjQ+LA0KPj4gKwkJICAgICA8MjU+LCA8MjY+LCA8Mjc+LCA8Mjg+LA0KPj4gKwkJICAg
ICA8Mjk+LCA8MzA+LCA8MzE+LCA8MzI+LA0KPj4gKwkJICAgICA8MzM+LCA8MzQ+LCA8MzU+LCA8
MzY+LA0KPj4gKwkJICAgICA8Mzc+LCA8Mzg+LCA8Mzk+LCA8NDA+LA0KPj4gKwkJICAgICA8NDE+
LCA8NDI+LCA8NDM+LCA8NDQ+Ow0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4gDQo+
IFNhbWUgaW50ZXJydXB0IG51bWJlcnMgR1BJTzIgYW5kIEdQSU8wPw0KPiANCj4gQXMgcGVyIG15
IHVuZGVyc3RhbmRpbmcsIEdQSU8yIGFuZCBHUElPMCBhcmUgdXNpbmcgbWF4ZWQgaW50ZXJydXB0
IGxpbmVzDQo+IE9ubHkgb25lIGJhbmsgR1BJTzAvR1BJTzIgY2FuIHdvcmsgaW4gZGlyZWN0IGlu
dGVycnVwdCBtb2RlDQo+IG90aGVyIHNob3VsZCBiZSBpbiBub24tZGlyZWN0IGludGVycnVwdCBt
b2RlLg0KDQpZZWFoLCBnb29kIHNwb3QgLSB0aGlzIGNhbm5vdCBiZSBjb3JyZWN0LiBJIGhhZCBh
IGxvb2sgaW4gdGhlIEhTUyBhbmQgdGhlcmUgZG9lcw0Kbm90IGFwcGVhciB0byBiZSBhbnl0aGlu
ZyBzZXR0aW5nIHRoZSBHUElPX0lOVEVSUlVQVF9GQUJfQ1IgZm9yIHRoZSBtMTAwcGZzZXZwDQp0
YXJnZXQgJiB0aGVyZWZvcmUgd291bGQgYmUgYXQgaXRzIGRlZmF1bHQgdmFsdWUgb2YgMCAtIHNv
IEdQSU8yIHNob3VsZCBiZSB1c2luZw0KaW50ZXJydXB0IDUzIGZvciBhbGwgR1BJT3MuDQpUaGFu
a3MsDQpDb25vci4NCg0KICANCj4+ICsNCj4+ICsmbWFjMCB7DQo+PiArCXN0YXR1cyA9ICJva2F5
IjsNCj4+ICsJcGh5LW1vZGUgPSAiZ21paSI7DQo+PiArCXBoeS1oYW5kbGUgPSA8JnBoeTA+Ow0K
Pj4gKwlwaHkwOiBldGhlcm5ldC1waHlAMCB7DQo+PiArCQlyZWcgPSA8MD47DQo+PiArCX07DQo+
PiArfTsNCj4+ICsNCj4+ICsmbWFjMSB7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ICsJcGh5
LW1vZGUgPSAiZ21paSI7DQo+PiArCXBoeS1oYW5kbGUgPSA8JnBoeTE+Ow0KPj4gKwlwaHkxOiBl
dGhlcm5ldC1waHlAMCB7DQo+PiArCQlyZWcgPSA8MD47DQo+PiArCX07DQo+PiArfTsNCj4+ICsN
Cj4+ICsmbWJveCB7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZt
bWMgew0KPj4gKwltYXgtZnJlcXVlbmN5ID0gPDUwMDAwMDAwPjsNCj4+ICsJYnVzLXdpZHRoID0g
PDQ+Ow0KPj4gKwljYXAtbW1jLWhpZ2hzcGVlZDsNCj4+ICsJY2FwLXNkLWhpZ2hzcGVlZDsNCj4+
ICsJbm8tMS04LXY7DQo+PiArCXNkLXVocy1zZHIxMjsNCj4+ICsJc2QtdWhzLXNkcjI1Ow0KPj4g
KwlzZC11aHMtc2RyNTA7DQo+PiArCXNkLXVocy1zZHIxMDQ7DQo+PiArCWRpc2FibGUtd3A7DQo+
PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZtbXVhcnQxIHsNCj4+ICsJ
c3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJm1tdWFydDIgew0KPj4gKwlzdGF0
dXMgPSAib2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICsmbW11YXJ0MyB7DQo+PiArCXN0YXR1cyA9
ICJva2F5IjsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZtbXVhcnQ0IHsNCj4+ICsJc3RhdHVzID0gIm9r
YXkiOw0KPj4gK307DQo+PiArDQo+PiArJnBjaWUgew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+
PiArfTsNCj4+ICsNCj4+ICsmcXNwaSB7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ICt9Ow0K
Pj4gKw0KPj4gKyZyZWZjbGsgew0KPj4gKwljbG9jay1mcmVxdWVuY3kgPSA8MTI1MDAwMDAwPjsN
Cj4+ICt9Ow0KPj4gKw0KPj4gKyZydGMgew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsN
Cj4+ICsNCj4+ICsmc3BpMCB7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ICt9Ow0KPj4gKw0K
Pj4gKyZzcGkxIHsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJnN5
c2NvbnRyb2xsZXIgew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4+ICsNCj4+ICsm
dXNiIHsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gKwlkcl9tb2RlID0gImhvc3QiOw0KPj4g
K307DQo+PiAtLQ0KPj4gMi4zNi4xDQo+IA0KDQo=
