Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E157509B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbiGNORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbiGNORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:17:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE6643E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657808261; x=1689344261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q91PePa7u5Ov1oPdd1gp0xpdb7VrUejHUIMW/yAE37w=;
  b=DhzMVkbiib8z62JEsXZ3T38R9VSwXEwpQMAo6sMtfAS6EYMbSwoQHFkx
   tMxsNBqdPODyX1qLP9wJwCdAIP7QV8mow1ZpbVLdYDoG7AjnqhfLOyfF7
   +UF1mLlBFDksyIAFhgYSFwuXBqkYmAvCT9+7HgJ0iOeX+meTmNx5BbG4q
   B+4Mn3fca4pMqrly6xqglnZ4K+hqWrHLJ81tCf9RyPXGBPVPIqTHo1aom
   59mLgz/zoXkuwsY9Z/N6UTEeZOn0uQ9Pcx9+70WCojIHlosyAvJm7nRzO
   gM/z+SLYGigOjUVEFiWvhvtUSo/Flx4dGzrbrIiMAFvOwTccnOitcOpYP
   A==;
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="182180235"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2022 07:17:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 14 Jul 2022 07:17:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 14 Jul 2022 07:17:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey+uYY1lYooxtz48ZAJwVa69fybOnvcT5kioMqNwmwS85eOILFCzU/qSqVi4ThFLHq7QyieQa4Bq7YtN7EEMxNDdee1rLUeuvZNYOo6Q4tRu+V+iG/VwFd6zw//2yYOnkOlTYiJf21zqPFjbhGfe/o76kOA6/Umrv/SKCYqg9bHMldmOB3gGMWyqlP8oYBhy9190/IwLHOOyXQ66tImyDm6O4GOsTZCBzKOchZFZKVXrEFj9HxgWtw1iIr1g7KBC+lFgU3FvwKbZzCy8cVm4ba0di5nh5fxHADMTJ27BrwkWRPCC8DHnDJgoU9RnQXzNUjbfJAlgxjKa2GQmtzKTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q91PePa7u5Ov1oPdd1gp0xpdb7VrUejHUIMW/yAE37w=;
 b=NJXB3aWqavB5g42DneUzwQOySLl0O8tFo2NxI9u5ICEqZF66TG9KMLheVZQ9NOdh9Dee27kpXPHz8+q3lQkuQUiWreiu17qQKl1vhuvvQdQWXPvhF/Lxl9kjizuwKnSPRsjfa1Ill6bGXDJBG59EHVnmHo57aY8bNJUhdSZdmJDRIaonFfJDaCvvrksR5+Ct+JNgIbBPxhWr0DCEWUtErvdN1LVLSBAYhn5Snp5Ztc35qc4uTbPX1F22hPBXp+2hnkz9N4PzWYyC2w5Bef/lZ+N+DwgmWrJimAVumWh7Vzy3YEuibIUe+IQSq6SI8D3m8wZfOPfO7MDnKm4o79Jlqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q91PePa7u5Ov1oPdd1gp0xpdb7VrUejHUIMW/yAE37w=;
 b=svlrlcDij0KyKjFypluDer6loqrBZxkd2ATuErXmdKDXAQs4t4E8+Ast9LOcKML0BU45ndE0Dr4Lu3T4ZjGr5aMGRJ2s4wO2YIzXkhW5yEz3t8DKKN3bcsFqNk+HKQwTsiJjqHDpGJWn/GVtLG7B3bNTjNqeG/mpApZyyZDZNqI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA0PR11MB4685.namprd11.prod.outlook.com (2603:10b6:806:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 14:17:33 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 14:17:33 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <linux-kernel@vger.kernel.org>,
        <Conor.Dooley@microchip.com>
CC:     <gregkh@linuxfoundation.org>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <ionela.voinescu@arm.com>,
        <pierre.gondois@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Topic: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Index: AQHYlr1LjktvAhTwm0O5ibr9nGIi2q19638A
Date:   Thu, 14 Jul 2022 14:17:33 +0000
Message-ID: <0abd0acf-70a1-d546-a517-19efe60042d1@microchip.com>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
In-Reply-To: <20220713133344.1201247-1-sudeep.holla@arm.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a7657e9-0b29-45bb-b25e-08da65a39867
x-ms-traffictypediagnostic: SA0PR11MB4685:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUVpmOwecdkz2/LSEor733YWy+jXJATJKVIKg8Dr7e43iwkNlDX8DQM1YXzQBkYiPxpzkscz+9CjuHF820V1YnzeRShQD1V76Dc+8MSCWxxJmBX3kjCI/9GyUdGwP5Om4J7+av+X1SUymxdyQ4SGRvG6ri+tu/RWCRmzq0/LaZ3w0E5pw0NikOz5YweK3Pb51sJCtZyGfXALCEkAawIEQ0BBtYYhbKaUgcSJYWl4w54phetXIOMz+Ule9ZlvgFLCmBXWQ4Y+2QV28jZdvLDc+9HMo8pAf1W5/AN7srniSX+tJwXR1IWnlWAzx5PfhTymFS0yDVqtPhP0QdkFZy2CFiYsGQWfk/hOq/Nus4Sw2YNMOvTfgp9xerUXLxC6xBOUjHoviZIR4vi0ZCnNv4PoS+6V93xeXfrR9Vd07734w37izAhKze4NN98nvR5DjF5wxKJv4GnG+DOaANe1W0FF1e65xbMGJDuGW7MGvusVAY+r1k6wT5VVK2TCLega50bKV9a9xkdKMEMZijEU1QJ2qmrrw+7OUTnMtFbEa4iKIfaP7Cj6sKhyK4hrH/Ncn+M09fIKvEdsgzi2ZF2JgdXyeBTXesUQRJukDACbR+Psh3atsg9IwawS5s4vzhb1aAWg7iJtwbhzL2PbZHkJONomy2Fl3mWdOAeR4Z1O0R79Wz4e7t6wFo1ElklHQS/qyUAmFGP4XWXuwQXzlm+E+gbM63lNFpPlnKjvtaH5YE//uEnmLUoYR5kpKIAZdZYAetzDO0vMgHRySqtWmajd8dWxExRUk6Ar9X23EOHO6bzrc41oB2D3Esgk7eTYAFBrN0PB11UYLImdwhsV1Wrgmc38l02Xw5cUBQSu9lv20T2UuudXatVsEUI9+5qPkHurC/xA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(39860400002)(346002)(376002)(186003)(91956017)(4326008)(83380400001)(110136005)(8676002)(64756008)(66946007)(54906003)(66476007)(76116006)(66556008)(66446008)(6512007)(71200400001)(36756003)(2616005)(41300700001)(26005)(31686004)(53546011)(2906002)(6506007)(86362001)(31696002)(122000001)(38070700005)(5660300002)(316002)(6486002)(38100700002)(478600001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUVFZGhidVFnaTdNd1cwdVFoYS9mMVVVVHE5OThrenNxcGhCcWJnZHdqVFFE?=
 =?utf-8?B?NWtMaDRhdzZwQ3pXLzFyUWlZc21RUlk3TEd3ZWJXT1FmTG8rSENpTTAxeGlF?=
 =?utf-8?B?ZVZzcWgzUE43Qy83RzJRNisydVJaZ0hXbllvVlV5eTUzZmY4S1JWTXNzMTZH?=
 =?utf-8?B?d2ZGZ2U5eUorZE1rc2N1VG1VbjdaMkxpaVRYbElXa2RreS9oc3IxUFJoeDQw?=
 =?utf-8?B?ZHdpR3V2TjgrVDdIdUQzMEZBbkdEZ2gvcmRIRTRhTDZHbmFQU1ZOZlcycHdv?=
 =?utf-8?B?aFN1b1ZkaWZ2Q1lTWXRBVVVzaXB2OFJoMTRONFlGWGRFTmw5WndzUnBWYjNQ?=
 =?utf-8?B?SnU0bURyakMreTdYZDd0QkJPVk9oRURyU0pXeHZSUjVaaG50SFZvODRrM0NY?=
 =?utf-8?B?aWtmTmhsMU9PQlFoSW5PckQ4QmxySWptNmg1RU93ZlpGWWtCTk10c2Y5Mmkx?=
 =?utf-8?B?aGhYTWpPZ0h1clZVajhXYnRmMHQzWHdKYkZaaER1djJnTDdOdzYwUEJEK3NE?=
 =?utf-8?B?bXFnWTBSM0IycHl1S0UyK1NRUmdaR2QwY2plMVRVY0YyWFRaMGtUYTZ6MmtB?=
 =?utf-8?B?dGlmZjhtZVVyUFkwOGJxUlRGSmludUxPWWhWdnhaaUJIMWlkZUloTmpwVWxp?=
 =?utf-8?B?ZkEramRaUzBFS1BoQlNFQUdFaVEwbWZ3YlFUMHdzQkh2Uy9MQjd6N1ZaQjJD?=
 =?utf-8?B?aEZkVzVvaG02SFpRaGYyellLSUZxdG5BQ2t4c1VKdmt5QWkvMjhYQXFnZXE2?=
 =?utf-8?B?aUNqTFQ0aXFEK01vUWhDNm02VHQvQzNWdjZLSllJRm8zOGFmMm9ROU5RU0pm?=
 =?utf-8?B?bDhkMmtUOXZqaUNtS003M2pLOEhTcktpMDNWS2dMUTZVWTNES0w2YkJYQ001?=
 =?utf-8?B?MEVxbUJHdCs5YjRGbjVrSTdRK0wyS2pyeEt4dm1nK1BVb0Q3Y3dKNzRNRTZZ?=
 =?utf-8?B?QS8xb3VxK3BwTGUwTE5IU0dnakpRRTQyWFVaM2pIcU9yOXVBYXNFM09JSFhs?=
 =?utf-8?B?TU1QTEJnUWFmcGE2ZGdZZGtscTVKUkJwWldJTWEwR2Njd2QwUW1BMHdTZ3Mv?=
 =?utf-8?B?SHRZdklhWVljWWoycVhPU2VHenlPbksxdVBPTHdZNU1TdzloSlZ1TjNRWVBr?=
 =?utf-8?B?Y3o5L1d2c0NZVE0zVEtjS25UZzY5L212TjNMdlJsSE1JNFplUW9aZnk4R3FT?=
 =?utf-8?B?WUdXUlhVYWNCOVArWmdPZ05kMktpb25IWTEvVVlJT1VUWFdPM3BHSWRhTjZ1?=
 =?utf-8?B?RXdWbzF5VWFWVHdMM1dtZmdjdHhVQnQ0S2E1L01SWmZyRDd3Z2FueUdRV3h1?=
 =?utf-8?B?RFdTcWFaUzBWeEZqV2YxcllQN1FWZk1QY3dvZ29raG9NVWdaN3ZmRUphZzVK?=
 =?utf-8?B?KzhBVnVUVjlhQjFJd3pPZk9sZjIwOURXcTNnUHdBTElUa3QxMW9nYUpFQmgr?=
 =?utf-8?B?TW1vSk4reGxQaW5SVjEzV1RVVVpISzlmbm9VTzhLNU54SEZvWFlsRWJvdVpn?=
 =?utf-8?B?dWV0eC91QXo2cWcwdFE0MTdvaWxtblVvNGUrSy9USTJIMDdWYnZiOS9JT3JO?=
 =?utf-8?B?bGM1MTgvUjdoSHkzQy82Z2lvUUdYNXNsYXFnNmpYRXZvT1BES1ljVHo3Qk04?=
 =?utf-8?B?OVF4c2FIOHNXczlLd3dRNGFFWHpUNGkzd2FCNnBPZEVaT1FTWGMzSWZ2OUtQ?=
 =?utf-8?B?QzNLUEtwSnVzVEN2TmZyT0MraEhidHpzSXh2ZFBpeWFxRDJERm1saklxRllx?=
 =?utf-8?B?UEg2WUVWajE1eXBXNExXSzhiWmVWTnpoTldrcGgxK2ZpbHkyMlB2Q3dubjlu?=
 =?utf-8?B?eXo1QnJuajBvbFk5Tmk4QXR6Q1FJQTN6N1FOOGJjajkrSVBhMjY4eWNYbVVx?=
 =?utf-8?B?M2x6MmdEQ2xRYmlwVER0QjNMekVBTmE3RFVKS3FXdzhqb3FIRWxHSmNoNDdJ?=
 =?utf-8?B?OCtpSVJFMi91andkNmh0UWN6MGFONUtEbUVVNTZ6bFFXK3Bzamc0MDJQQTRO?=
 =?utf-8?B?TjVQWkhOUzdwcTlwUWovcGtobXBKVVc2U1l0TmJHY1lVWGRkNmRDV0U2Yy9j?=
 =?utf-8?B?S2NjbnE5QW4reUwva3ZLeWdTL0pqRG1zczJhNHVZVE9KQ29PWEZkZUd2UzdY?=
 =?utf-8?Q?1CHGbpuCvoC+OepqhP5e7Z9cp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0817EC7AB79DA2469EC47A83C1011F24@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7657e9-0b29-45bb-b25e-08da65a39867
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 14:17:33.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCsgNT7NLBr2IQccgCsDs9EN4qzafhvBH/5bIHCbRMliDqaYQgMrwwBgUSSrf+sOJUlDvp5SzU7zb9xEVXivCEexUwisoNLss4ei5QQDeB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4685
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDcvMjAyMiAxNDozMywgU3VkZWVwIEhvbGxhIHdyb3RlOg0KDQpIZXkgU3VkZWVwLA0K
SSBjb3VsZCBub3QgZ2V0IHRoaXMgcGF0Y2ggdG8gYWN0dWFsbHkgYXBwbHksIHRyaWVkIGEgY291
cGxlDQpkaWZmZXJlbnQgdmVyc2lvbnMgb2YgLW5leHQgOi8NCg0KSXQgaXMgaW4gLW5leHQgYWxy
ZWFkeSB0aG91Z2gsIHdoaWNoIEkgc3VzcGVjdCBtaWdodCBiZSBwYXJ0IG9mIHdoeQ0KaXQgZG9l
cyBub3QgYXBwbHkuLiBTdXJlbHkgeW91IGNhbiBmYXN0IGZvcndhcmQgeW91ciBhcmNoX3RvcG9s
b2d5DQpmb3ItbmV4dCBicmFuY2ggdG8gZ3JlZ3MgbWVyZ2UgY29tbWl0IHJhdGhlciB0aGFuIGdl
bmVyYXRpbmcgdGhpcw0KZnJvbSB0aGUgcHJlbWVyZ2UgYnJhbmNoICYgcmUtbWVyZ2luZyBpbnRv
IHlvdXIgYnJhbmNoIHRoYXQgU3RlcGhlbg0KcGlja3MgdXA/DQoNCkVpdGhlciB3YXksIEkgdGVz
dGVkIGl0IGRpcmVjdGx5IGluIC1uZXh0IHNpbmNlIHRoYXQncyBiYWNrIHRvDQpib290aW5nIGZv
ciBtZSB0b2RheSBhbmQgLi4uDQoNCj4gaW5pdF9jcHVfdG9wb2xvZ3koKSBpcyBjYWxsZWQgb25s
eSBvbmNlIGF0IHRoZSBib290IGFuZCBhbGwgdGhlIGNhY2hlDQo+IGF0dHJpYnV0ZXMgYXJlIGRl
dGVjdGVkIGVhcmx5IGZvciBhbGwgdGhlIHBvc3NpYmxlIENQVXMuIEhvd2V2ZXIgd2hlbg0KPiB0
aGUgQ1BVcyBhcmUgaG90cGx1Z2dlZCBvdXQsIHRoZSBjYWNoZWluZm8gZ2V0cyByZW1vdmVkLiBX
aGlsZSB0aGUNCj4gYXR0cmlidXRlcyBhcmUgYWRkZWQgYmFjayB3aGVuIHRoZSBDUFVzIGFyZSBo
b3RwbHVnZ2VkIGJhY2sgaW4gYXMgcGFydA0KPiBvZiBDUFUgaG90cGx1ZyBzdGF0ZSBtYWNoaW5l
LCBpdCBlbmRzIHVwIGNhbGxlZCBxdWl0ZSBsYXRlIGFmdGVyIHRoZQ0KPiB1cGRhdGVfc2libGlu
Z3NfbWFza3MoKSBhcmUgY2FsbGVkIGluIHRoZSBzZWNvbmRhcnlfc3RhcnRfa2VybmVsKCkNCj4g
cmVzdWx0aW5nIGluIHdyb25nIGxsY19zaWJsaW5nX21hc2tzLg0KPiANCj4gTW92ZSB0aGUgY2Fs
bCB0byBkZXRlY3RfY2FjaGVfYXR0cmlidXRlcygpIGluc2lkZSB1cGRhdGVfc2libGluZ3NfbWFz
a3MoKQ0KPiB0byBlbnN1cmUgdGhlIGNhY2hlaW5mbyBpcyB1cGRhdGVkIGJlZm9yZSB0aGUgTExD
IHNpYmxpbmcgbWFza3MgYXJlDQo+IHVwZGF0ZWQuIFRoaXMgd2lsbCBmaXggdGhlIGluY29ycmVj
dCBMTEMgc2libGluZyBtYXNrcyBnZW5lcmF0ZWQgd2hlbg0KPiB0aGUgQ1BVcyBhcmUgaG90cGx1
Z2dlZCBvdXQgYW5kIGhvdHBsdWdnZWQgYmFjayBpbiBhZ2Fpbi4NCj4gDQo+IFJlcG9ydGVkLWJ5
OiBJb25lbGEgVm9pbmVzY3UgPGlvbmVsYS52b2luZXNjdUBhcm0uY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jIHwgMTYgKysrKysrLS0tLS0tLS0tLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gSGkgQ29u
b3IsDQo+IA0KPiBJb25lbGEgcmVwb3J0ZWQgYW4gaXNzdWUgd2l0aCB0aGUgQ1BVIGhvdHBsdWcg
YW5kIGFzIGEgZml4IEkgbmVlZCB0bw0KPiBtb3ZlIHRoZSBjYWxsIHRvIGRldGVjdF9jYWNoZV9h
dHRyaWJ1dGVzKCkgd2hpY2ggSSBoYWQgdGhvdWdodCB0byBrZWVwDQo+IGl0IHRoZXJlIGZyb20g
Zmlyc3QgYnV0IGZvciBubyByZWFzb24gaGFkIG1vdmVkIGl0IHRvIGluaXRfY3B1X3RvcG9sb2d5
KCkuDQo+IA0KPiBXb25kZXIgaWYgdGhpcyBmaXhlcyB0aGUgLUVOT01FTSBvbiBSSVNDLVYgYXMg
dGhpcyBvbmUgaXMgY2FsbGVkIG9uIHRoZQ0KPiBjcHUgaW4gdGhlIHNlY29uZGFyeSBDUFVzIGlu
aXQgcGF0aCB3aGlsZSBpbml0X2NwdV90b3BvbG9neSBleGVjdXRlZA0KPiBkZXRlY3RfY2FjaGVf
YXR0cmlidXRlcygpIGZvciBhbGwgcG9zc2libGUgQ1BVcyBtdWNoIGVhcmxpZXIuIEkgdGhpbmsN
Cj4gdGhpcyBtaWdodCBoZWxwIGFzIHRoZSBwZXJjcHUgbWVtb3J5IG1pZ2h0IGJlIGluaXRpYWxp
c2VkIGluIHRoaXMgY2FzZS4NCg0KQWN0dWFsbHksIHdlIGFyZSBub3cgd29yc2Ugb2ZmIHRoYW4g
YmVmb3JlOg0KICAgICAwLjAwOTgxM10gc21wOiBCcmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAu
Li4NClsgICAgMC4wMTE1MzBdIEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52
YWxpZCBjb250ZXh0IGF0IGluY2x1ZGUvbGludXgvc2NoZWQvbW0uaDoyNzQNClsgICAgMC4wMTE1
NTBdIGluX2F0b21pYygpOiAxLCBpcnFzX2Rpc2FibGVkKCk6IDEsIG5vbl9ibG9jazogMCwgcGlk
OiAwLCBuYW1lOiBzd2FwcGVyLzENClsgICAgMC4wMTE1NjZdIHByZWVtcHRfY291bnQ6IDEsIGV4
cGVjdGVkOiAwDQpbICAgIDAuMDExNTgwXSBDUFU6IDEgUElEOiAwIENvbW06IHN3YXBwZXIvMSBO
b3QgdGFpbnRlZCA1LjE5LjAtcmM2LW5leHQtMjAyMjA3MTQtZGlydHkgIzENClsgICAgMC4wMTE1
OTldIEhhcmR3YXJlIG5hbWU6IE1pY3JvY2hpcCBQb2xhckZpcmUtU29DIEljaWNsZSBLaXQgKERU
KQ0KWyAgICAwLjAxMTYwOF0gQ2FsbCBUcmFjZToNClsgICAgMC4wMTE2MjBdIFs8ZmZmZmZmZmY4
MDAwNTA3MD5dIGR1bXBfYmFja3RyYWNlKzB4MWMvMHgyNA0KWyAgICAwLjAxMTY2MV0gWzxmZmZm
ZmZmZjgwNjZiMGM0Pl0gc2hvd19zdGFjaysweDJjLzB4MzgNClsgICAgMC4wMTE2OTldIFs8ZmZm
ZmZmZmY4MDY3MDRhMj5dIGR1bXBfc3RhY2tfbHZsKzB4NDAvMHg1OA0KWyAgICAwLjAxMTcyNV0g
WzxmZmZmZmZmZjgwNjcwNGNlPl0gZHVtcF9zdGFjaysweDE0LzB4MWMNClsgICAgMC4wMTE3NDVd
IFs8ZmZmZmZmZmY4MDAyZjQyYT5dIF9fbWlnaHRfcmVzY2hlZCsweDEwMC8weDEwYQ0KWyAgICAw
LjAxMTc3Ml0gWzxmZmZmZmZmZjgwMDJmNDcyPl0gX19taWdodF9zbGVlcCsweDNlLzB4NjYNClsg
ICAgMC4wMTE3OTNdIFs8ZmZmZmZmZmY4MDE0ZDc3ND5dIF9fa21hbGxvYysweGQ2LzB4MjI0DQpb
ICAgIDAuMDExODI1XSBbPGZmZmZmZmZmODAzZDYzMWM+XSBkZXRlY3RfY2FjaGVfYXR0cmlidXRl
cysweDM3YS8weDQ0OA0KWyAgICAwLjAxMTg1NV0gWzxmZmZmZmZmZjgwM2U4ZmJlPl0gdXBkYXRl
X3NpYmxpbmdzX21hc2tzKzB4MjQvMHgyNDYNClsgICAgMC4wMTE4ODVdIFs8ZmZmZmZmZmY4MDAw
NWYzMj5dIHNtcF9jYWxsaW4rMHgzOC8weDVjDQpbICAgIDAuMDE1OTkwXSBzbXA6IEJyb3VnaHQg
dXAgMSBub2RlLCA0IENQVXMNCg0KPiANCj4gQW55d2F5cyBnaXZlIHRoaXMgYSB0cnksIGFsc28g
dGVzdCB0aGUgQ1BVIGhvdHBsdWcgYW5kIGNoZWNrIGlmIG5vdGhpbmcNCj4gaXMgYnJva2VuIG9u
IFJJU0MtVi4gV2Ugbm90aWNlZCB0aGlzIGJ1ZyBvbmx5IG9uIG9uZSBwbGF0Zm9ybSB3aGlsZQ0K
DQpTbywgb3VyIHN5c3RlbSBtb25pdG9yIHRoYXQgcnVucyBvcGVuU0JJIGRvZXMgbm90IGFjdHVh
bGx5IHN1cHBvcnQNCmFueSBob3RwbHVnIGZlYXR1cmVzIHlldCwgc286DQoNCiMgZWNobyAwID4g
L3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1My9vbmxpbmUNClsgICA0Ny4yMzM2MjddIENQVTM6
IG9mZg0KWyAgIDQ3LjIzNjAxOF0gQ1BVMyBtYXkgbm90IGhhdmUgc3RvcHBlZDogMw0KIyBlY2hv
IDEgPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUzL29ubGluZQ0KWyAgIDU0LjkxMTg2OF0g
Q1BVMzogZmFpbGVkIHRvIHN0YXJ0DQoNCkFuZCB0aGlzIG9uZSBjb25mdXNlZCB0aGUgaGVsbCBv
dXQgb2YgaXQuLi4NCg0KIyBlY2hvIDAgPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUxL29u
bGluZQ0KWyAyOTAzLjA1NzcwNl0gQ1BVMTogb2ZmDQpIU1NfT3BlblNCSV9SZWJvb3QoKSBjYWxs
ZWQNClsgMjkwMy4wNjI0NDddIENQVTEgbWF5IG5vdCBoYXZlIHN0b3BwZWQ6IDMNCiMNCiMgWzgu
MjE4NTkxXSBIU1NfQm9vdF9QTVBTZXR1cEhhbmRsZXIoKTogSGFydDEgc2V0dXAgY29tcGxldGUN
Cg0KVGhpcyBpcyB0aGUgaGFydCB0aGF0IGJyb3VnaHQgdXAgb3BlblNCSSBzbyB3aGVuIHRoZSBy
ZXF1ZXN0DQp0byBvZmZsaW5lIGl0IGNvbWVzIHRocm91Z2ggaXQgY2F1c2VzIGEgc3lzdGVtIHJl
Ym9vdCBoYWhhDQoNCkVpdGhlciB3YXksIEkgdGhpbmsgYm90aCBpbXBseSB0aGF0IHRoZSBob3Rw
bHVnIGNvZGUgb24gdGhlDQpMaW51eCBzaWRlIGlzIHNhbmUuDQoNCkZXSVcgU3VkZWVwLCBpZiB5
b3UgIHdhbnQgdG8gYWRkIG1lIGFzIGEgcmV2aWV3ZXIgZm9yIGdlbmVyaWMNCmFyY2ggdG9wb2xv
Z3kgc3R1ZmYgc2luY2UgSSBkbyBjYXJlIGFib3V0IHRlc3RpbmcgaXQgZXRjLCBwbGVhc2UNCmZl
ZWwgZnJlZSAoYWx0aG91Z2ggZm9yIHRoZSBzYWtlIG9mIG15IGZpbHRlcnMsIG1ha2UgdGhlIGVt
YWlsDQpjb25vckBrZXJuZWwub3JnIGlmIHlvdSBkbykuDQoNClRoYW5rcywNCkNvbm9yLg0KDQo+
IA0KPiBSZWdhcmRzLA0KPiBTdWRlZXANCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2Uv
YXJjaF90b3BvbG9neS5jIGIvZHJpdmVycy9iYXNlL2FyY2hfdG9wb2xvZ3kuYw0KPiBpbmRleCA0
NDFlMTRhYzMzYTQuLjA0MjRiNTliNjk1ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9iYXNlL2Fy
Y2hfdG9wb2xvZ3kuYw0KPiArKysgYi9kcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jDQo+IEBA
IC03MzIsNyArNzMyLDExIEBAIGNvbnN0IHN0cnVjdCBjcHVtYXNrICpjcHVfY2x1c3Rlcmdyb3Vw
X21hc2soaW50IGNwdSkNCj4gICB2b2lkIHVwZGF0ZV9zaWJsaW5nc19tYXNrcyh1bnNpZ25lZCBp
bnQgY3B1aWQpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgY3B1X3RvcG9sb2d5ICpjcHVfdG9wbywgKmNw
dWlkX3RvcG8gPSAmY3B1X3RvcG9sb2d5W2NwdWlkXTsNCj4gLQlpbnQgY3B1Ow0KPiArCWludCBj
cHUsIHJldDsNCj4gKw0KPiArCXJldCA9IGRldGVjdF9jYWNoZV9hdHRyaWJ1dGVzKGNwdWlkKTsN
Cj4gKwlpZiAocmV0KQ0KPiArCQlwcl9pbmZvKCJFYXJseSBjYWNoZWluZm8gZmFpbGVkLCByZXQg
PSAlZFxuIiwgcmV0KTsNCj4gICAJLyogdXBkYXRlIGNvcmUgYW5kIHRocmVhZCBzaWJsaW5nIG1h
c2tzICovDQo+ICAgCWZvcl9lYWNoX29ubGluZV9jcHUoY3B1KSB7DQo+IEBAIC04MjEsNyArODI1
LDcgQEAgX193ZWFrIGludCBfX2luaXQgcGFyc2VfYWNwaV90b3BvbG9neSh2b2lkKQ0KPiAgICNp
ZiBkZWZpbmVkKENPTkZJR19BUk02NCkgfHwgZGVmaW5lZChDT05GSUdfUklTQ1YpDQo+ICAgdm9p
ZCBfX2luaXQgaW5pdF9jcHVfdG9wb2xvZ3kodm9pZCkNCj4gICB7DQo+IC0JaW50IHJldCwgY3B1
Ow0KPiArCWludCByZXQ7DQo+ICAgCXJlc2V0X2NwdV90b3BvbG9neSgpOw0KPiAgIAlyZXQgPSBw
YXJzZV9hY3BpX3RvcG9sb2d5KCk7DQo+IEBAIC04MzYsMTMgKzg0MCw1IEBAIHZvaWQgX19pbml0
IGluaXRfY3B1X3RvcG9sb2d5KHZvaWQpDQo+ICAgCQlyZXNldF9jcHVfdG9wb2xvZ3koKTsNCj4g
ICAJCXJldHVybjsNCj4gICAJfQ0KPiAtDQo+IC0JZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkg
ew0KPiAtCQlyZXQgPSBkZXRlY3RfY2FjaGVfYXR0cmlidXRlcyhjcHUpOw0KPiAtCQlpZiAocmV0
KSB7DQo+IC0JCQlwcl9pbmZvKCJFYXJseSBjYWNoZWluZm8gZmFpbGVkLCByZXQgPSAlZFxuIiwg
cmV0KTsNCj4gLQkJCWJyZWFrOw0KPiAtCQl9DQo+IC0JfQ0KPiAgIH0NCj4gICAjZW5kaWYNCj4g
LS0yLjM3LjENCj4gDQo=
