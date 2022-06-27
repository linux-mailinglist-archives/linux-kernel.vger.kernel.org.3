Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4555C23E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiF0Ke7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiF0Ke5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:34:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950565F9A;
        Mon, 27 Jun 2022 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656326095; x=1687862095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JdVq0hqPjYw1SoGZyBtnr0ST4uGBGDGPp+1fV+lNhGI=;
  b=WrFdXCCn9rDz85iFgmuzhhFVwRO7k0NTCdekhdCM6nkCHWxyZ8UZ22mb
   uaulpW2xUj6LIsvySEQh6GvhLdG6m5N7IHBt4Os7zhduKhkTzZOkcXgXo
   X6ibYVIebvp6CbxJ7UlVVaWoXLq5TDMhRLlFB7seujs0mNuxHjw8Uky0v
   slPrk3tXdzukWWGV4dxzLe2ASDh2lF3xb8XpUY/TKiISMiXFMDmXGLzP/
   /NxIM02YTbYqFycuti9U7V2ECadBjItsIeeUF3Rq+TLA7jEpNMvdscPR5
   ILySWoNmqyb9yvC3s5ObMM3AJPXaeMWSW+UGIn2DtDAvA1YB04i/WomTd
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="101871777"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2022 03:34:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 27 Jun 2022 03:34:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 27 Jun 2022 03:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTLaSzYTrSx2G0Jjh7B3kRu7CjdcR8TNOY9GvRptu6vDBh+eU4u0pTfudxcR4Ku7zyrPWNeyyXqStLieKRxPGQ86k6RR5sD4g2YnhDmlhc4DAlya632MzNWVnrptNB9e2Wo9NTW2vVSMNTDNK2tIBlc9lhIHp7AjUOjuAW7GCYc5pXNpa2T7SR68DmVjdHcluj9z6XOznlhSGbdHs+TC9VzqcCQonX9hsbNYpmPSgP+0ILzfrBz2JXFlQqDZx5StrS9H/I6Yif94RMbjzMO3Rn3BqHfhcj1a2lp8kZ8EqXFY3FLdBO/pCScgNipErFaQ/1BcmDoUvJHmoN0Yn+kMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdVq0hqPjYw1SoGZyBtnr0ST4uGBGDGPp+1fV+lNhGI=;
 b=iihBq1lBZBx/4PqNtQHL9IqT0OC0cdR3ZkxpHQwDRE8V31UM+vST9RGgWaWO8PjkSUpITa6Hz4yF18XhcGgvawkOl5NUPmJzFZc8P5uqiS/U2lhI6QLhlueTiGsc/psOzBL5HyK4Tw+e2NC8260WtjzGS+i4YhuWGVCNhcO4hlNz7/JA46zsEpkUSFDo/Angvceb7X+5SiAdjacUSUhvI9mQpDMc5hLms1rNiq7fFq4+eJNQ8epStl8QKrZHzgt+vQ5LhpS4FJowRaqdwlmPBG5PfuqbSQ3obSxOOhte8tiyslsnnw5TyFOPvkQhsRdn60WnzybSssBhiJ52i9DoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdVq0hqPjYw1SoGZyBtnr0ST4uGBGDGPp+1fV+lNhGI=;
 b=ur43t5+6dPnCe+a61WlWuwTxCSeFHU3uDaECodDK8w15xRVSvjaPtdGPOinsp92la6j8PygyLczr4SdYCoynMG6JQi7JEMqsFygjvDhpdCetip/sMrJ7vMb/vmDt6b/k4rfRCeEMNBq3+PWWTARzAH/Yrex+AU1Sb18q0AZN9/4=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 10:34:51 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5373.015; Mon, 27 Jun 2022
 10:34:51 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Topic: [PATCH v5 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Index: AQHYihGI8mFobqnFUkSUiLJldqI61g==
Date:   Mon, 27 Jun 2022 10:34:51 +0000
Message-ID: <7110531a-36bd-3904-dc54-4697fd6a7316@microchip.com>
References: <20220620144634.25464-1-kavyasree.kotagiri@microchip.com>
 <20220620144634.25464-4-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220620144634.25464-4-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 181c64f2-87d8-45d3-bde0-08da5828aac1
x-ms-traffictypediagnostic: BL1PR11MB5239:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOnzThIFbog+oqmq+N442wwm6AtbiLmBm21Sl0Ue+kz34Cnm3W+QAYPjTClvfynPODQzDoL9QAwAvGmY/fSHlvUVIfaz9sQJQnpl6+VYYibtbwd2T0+FmsEOx2gPKgGTfVF3e/BPjXWTaQvqaapBT6F9XAY2FBCtRejIY6fEd1NCFO/Tbam8fdtJcvthg4+/ZhUHT/Hp02YKCbTz44kxi86XJA5zWMoDp8FpqTP8DVLwvSHCuzmu3+CpIhkSqkBapuTAwga/AP1lXJn1wmB9mGfdzdVK3WzJAPZuYAci6glBnZ6CLLA6AAYrT1pPxo/J8meNaTiICBGEDS6Pln3RCbLpeYKcIpkMye+3HV4irL9Ep4UTQw8XbAD2Zl6KjIBma7jwsdb2kPKP4cF8vJmWIO+NH9Cr1XJJyEyN64YuKrPD62UZSMyeRJRLggfJsmTPXkRqs4vGKR5jGh+TyTCAd+rp6TexmnM6qeE6NvahiD+8r3oyN+iuX+z9k50k1qXSllyUqr41iPn68KL0pUhb/9y0FKUw7/RkxavoSeAnzfwkX4CK/haC/wIBIXY5fbHpLxHj+/gUUYxFs1TnglgQpsGQ25ScY9aD1k0o1qtZmcWBzA4SFkgZRbDcwxdEuEv+6vLr/C00AilBs4l3SL+D4HWcUZH/kdi8AEjauwO18e2vB3LilmfYFD/nVqNzTiRDzPQ8I9lxZ9V713k1Nftn6cbsKig+Y0uyTKPQnX7gILCR8bq1BXSo2XisnMlQT4OyoZGhGfw6zs+1hdykUReXmupmW/e2YlnSTNvWDLRYcwSY3rjU/eS2eSC03y5ipuw+QHhRcrH7+9RKx2owLhFwXHiK/Fd+njrj65hf6gPnLV8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(346002)(39860400002)(396003)(136003)(38100700002)(6506007)(71200400001)(2616005)(2906002)(53546011)(86362001)(8936002)(5660300002)(186003)(478600001)(41300700001)(76116006)(38070700005)(122000001)(6486002)(26005)(83380400001)(36756003)(91956017)(6512007)(64756008)(8676002)(54906003)(110136005)(66556008)(66946007)(66446008)(66476007)(316002)(4326008)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2s5SUh4TFI5TFlRVXhGeFliVXk1cWRMZHpDd0dQNnhuV1N4UU9LUUtIWGo0?=
 =?utf-8?B?VUNpS2w3RWIzSWl4YUo1S2YydmpBRUt1Mk1qSTgvUnk5enpwajZza1RqS2xQ?=
 =?utf-8?B?a3lYQU1GcWxxT1J5UzZtNUsyYUlqbFhyemV0Z0g3bEYvM0c1QUV6Z2g4RDFG?=
 =?utf-8?B?VVNqUUZCeElCNnNkZTdXcDVTWHBJWFpFanZ4MjBDZml0QXRIQ3FzQ0s4VXgw?=
 =?utf-8?B?NGxhb01wQllYTlVCUUdXMCtHQS8xMmRWMEY4dDVpaWFVOHVDd0syT2JMa0NC?=
 =?utf-8?B?dXl6WGRia3dNMW9sNmwwNlZDRU1SQTUyN1dtZVlzRk1GMUhpVjgrd1cxTGFk?=
 =?utf-8?B?OERhMXY1bkRuaWdJc2ozVytiRmU4VEQ0aW9tdDJ5UTI4aTJVUlpLTnVydnQ4?=
 =?utf-8?B?VWUvcjZFZ0o5QS9lWS9uZ3ZPcUpsamEydHFlWkdHRUtYUHZOY3o5ekJpZE9x?=
 =?utf-8?B?N1dRbU51NS9ESm0za1ZZdlA5WGJPYnlZd0hvbWlNN2pBQVhXS1BVTUo3TmV3?=
 =?utf-8?B?ejFVWDlycDBYbitJQ1ZMM1VLYk5va0FYcXpDcHVSM3VXWklERFFOUmtFSEl2?=
 =?utf-8?B?NG81S2RVL09rKzJhc3B1N0hESWRjMlQ3YW1zT01LVWpzN0NPWXJwSEsyaSsy?=
 =?utf-8?B?SXA1bElzb3BWeGRsK0tNM0JDRlhvTk04UzNocmFZOThsWUcxb25LdnZLUGNi?=
 =?utf-8?B?VGI2L2YxczFYeE9LaWMzbDBLbnNKQ0VITVBUaVhKWTRCa1R0Ukt3dnBoWWx1?=
 =?utf-8?B?aXo5L1NCbVM3Z1ZzVnNBRVlNaEEvRlBEVmdMWnd4R2hxeWdQbTd3cmNmOWJj?=
 =?utf-8?B?Q25XTlp0aTVxZHU0eldsNGh6anpaS1B4VDhMWlVDWkNreHdPUFRqanpMYnN3?=
 =?utf-8?B?RXFtOXRWYlBObE5TSUl0NkMwUHVOUjE4ZHF1dHpYMTR2Zkl2dFR5L3hZbTQv?=
 =?utf-8?B?RXdMK0NtSFdQR2xwMEkwVTBBb1pZWXgxUmtQSThpb1gzSXl3SDZpWlVZS0th?=
 =?utf-8?B?TzQ1WE9OSGI2Sk5KTnJEU2RiV01oZjY5MkI5N0lYVU9NUGZNV2FrbW1jcU9L?=
 =?utf-8?B?V0RMQUE3Q2wyTnd2UjRKWjgrS2E3NElaUWdNajJhbGx6YXVhWkxMNVlkeGxC?=
 =?utf-8?B?SHdIU0dISzBPT1VoY1pOUVVSU3p1TGkwV0lMSXljdWExbUUvQ1VjMUJMRUFr?=
 =?utf-8?B?MnU5SFk3SmR0Wnh2d0l5MUY2WVJLeGt1cEM0OEZES3RlZjRDSFkyRHVPSHh2?=
 =?utf-8?B?bHJodFgvY2dYTDMySUtWSktibzU3dTdUTk1hMC8rR1l4TWEzTXZtODNObWRI?=
 =?utf-8?B?U1pGQXFycVdXd294MWRUV1B2WFV4M29mSUZ4QzJpSS9zRW9zellsN1pVaHQ1?=
 =?utf-8?B?elpHSURyaXFobHAxc2lrYWJWRXBuZEtCY0lSdCtjTnAyK0czamwvQXRDUFdw?=
 =?utf-8?B?eEYxLzVkYnd6blIvQXp3RUhRLzVhcjduTENBbG1KVEVMOEt4Ti9hZUpTbDRv?=
 =?utf-8?B?T3kvR2pqQlg0MjFCRDVrQWkva3Z1MmZPTXNJKzZ0UWF6VklMOGo5VVJINEcz?=
 =?utf-8?B?UXNrWVpQYjg3cS8rWmxwdkRFS2JvTzcwUjlLeGJiTUN1dklaZUlmdUFGN0w3?=
 =?utf-8?B?dWdtd2xKVUNaRkZpNldORUtkZ0RkRlQySmJzS0ZjMVRBcU5BNWhEQmNkdjRE?=
 =?utf-8?B?VnIxczNldmNQYkV5SjVrMmRLWVVjSTE2NVNGcUdvZERGUEgvZ3lvaVdmS2JQ?=
 =?utf-8?B?VFZ1YmZ2MWxGVlJaZldnbXk3am5zcHBJd2JaSzNrVUJqSVNJS2QvTkU2c1pW?=
 =?utf-8?B?bVNsckpJMWNEWDZ3eFhnRzh0MVFxTEtxVkE0bVpDUlRlTWFJcUdLdkkxMFRo?=
 =?utf-8?B?VzBsYVFkS1lYRTlmcHA4VmhJVUJhM2RISmI3d0NTS3YrZ3IyNTQ5MjMrV0xH?=
 =?utf-8?B?TFRHS2tJZmx1N1BKR0VBdy85eDc1OVorekx1TVZlVFRaN1YzYU5ONUxSZkhp?=
 =?utf-8?B?VjU4TnF3eG83YVpxNzIxYWp4aUR6cytGM2RZQkZlcmxDT25ibHpHQWlZdXM3?=
 =?utf-8?B?anlRamtJN1kxeU1EOW9yK2xaRTRXRG9sdVc0aHFCYk0xRDNRcHd1M1ZUd2Uz?=
 =?utf-8?B?eHdzWm0vTUdsb05mVjJRNlR1N1lRZkpraEI4cmllbjdiZjZDVFQ2N2NKQkV3?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6C19D766807834AB6932FBDCD5A3968@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181c64f2-87d8-45d3-bde0-08da5828aac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 10:34:51.2950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11ZZQ5dc4BiF+mOlhOE9N5e71h2OBEE2OhbfZIqGj43NjHqA/eHZzIDe8ik6jhVaLlPk809uErhf+0vOHK8sULS69zzu9SBFd6Yiz4cBn9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMDYuMjAyMiAxNzo0NiwgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBMQU45NjZ4
IFNvQyBoYXZlIDUgZmxleGNvbXMuIEVhY2ggZmxleGNvbSBoYXMgMiBjaGlwLXNlbGVjdHMNCj4g
d2hpY2ggYXJlIG9wdGlvbmFsIEkvTyBsaW5lcy4gRm9yIGVhY2ggY2hpcCBzZWxlY3Qgb2YgZWFj
aA0KPiBmbGV4Y29tIHRoZXJlIGlzIGEgY29uZmlndXJhdGlvbiByZWdpc3RlciBGTEVYQ09NX1NI
QVJFRFswLTRdOlNTX01BU0tbMC0xXS4NCj4gVGhlIHdpZHRoIG9mIGNvbmZpZ3VyYXRpb24gcmVn
aXN0ZXIgaXMgMjEgYmVjYXVzZSB0aGVyZSBhcmUNCj4gMjEgc2hhcmVkIHBpbnMgb24gZWFjaCBv
ZiB3aGljaCB0aGUgY2hpcCBzZWxlY3QgY2FuIGJlIG1hcHBlZC4NCj4gRWFjaCBiaXQgb2YgdGhl
IHJlZ2lzdGVyIHJlcHJlc2VudHMgYSBkaWZmZXJlbnQgRkxFWENPTV9TSEFSRUQgcGluLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdpcmlA
bWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJl
em5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+IHY0IC0+IHY1Og0KPiAgLSBObyBjaGFu
Z2VzLg0KPiANCj4gdjMgLT4gdjQ6DQo+ICAtIEFkZCBjb25kaXRpb24gZm9yIGEgZmxleGNvbSB3
aGV0aGVyIHRvIGNvbmZpZ3VyZSBjaGlwLXNlbGVjdCBsaW5lcw0KPiAgICBvciBub3QsIGJhc2Vk
IG9uICJtaWNyb2NoaXAsZmx4LXNocmQtcGlucyIgcHJvcGVydHkgZXhpc3RlbmNlIGJlY2F1c2UN
Cj4gICAgY2hpcC1zZWxlY3QgbGluZXMgYXJlIG9wdGlvbmFsLg0KPiANCj4gdjIgLT4gdjM6DQo+
ICAtIHVzZWQgZ290byBsYWJlbCBmb3IgY2xrX2Rpc2FibGUgaW4gZXJyb3IgY2FzZXMuDQo+IA0K
PiB2MSAtPiB2MjoNCj4gIC0gdXNlIEdFTk1BU0sgZm9yIG1hc2ssIG1hY3JvcyBmb3IgbWF4aW11
bSBhbGxvd2VkIHZhbHVlcy4NCj4gIC0gdXNlIHUzMiB2YWx1ZXMgZm9yIGZsZXhjb20gY2hpcHNl
bGVjdHMgaW5zdGVhZCBvZiBzdHJpbmdzLg0KPiAgLSBkaXNhYmxlIGNsb2NrIGluIGNhc2Ugb2Yg
ZXJyb3JzLg0KPiANCj4gIGRyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYyB8IDk0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5MyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQv
YXRtZWwtZmxleGNvbS5jIGIvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+IGluZGV4IDMz
Y2FhNGZiYTZhZi4uNDMwYjY3ODNiNWE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21mZC9hdG1l
bC1mbGV4Y29tLmMNCj4gKysrIGIvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+IEBAIC0y
OCwxNSArMjgsNjggQEANCj4gICNkZWZpbmUgRkxFWF9NUl9PUE1PREUob3Btb2RlKQkoKChvcG1v
ZGUpIDw8IEZMRVhfTVJfT1BNT0RFX09GRlNFVCkgJglcDQo+ICAJCQkJIEZMRVhfTVJfT1BNT0RF
X01BU0spDQo+ICANCj4gKy8qIExBTjk2NnggZmxleGNvbSBzaGFyZWQgcmVnaXN0ZXIgb2Zmc2V0
cyAqLw0KPiArI2RlZmluZSBGTEVYX1NIUkRfU1NfTUFTS18wCTB4MA0KPiArI2RlZmluZSBGTEVY
X1NIUkRfU1NfTUFTS18xCTB4NA0KPiArI2RlZmluZSBGTEVYX1NIUkRfUElOX01BWAkyMA0KPiAr
I2RlZmluZSBGTEVYX0NTX01BWAkJMQ0KPiArI2RlZmluZSBGTEVYX1NIUkRfTUFTSwkJR0VOTUFT
SygyMCwgMCkNCj4gKw0KPiArc3RydWN0IGF0bWVsX2ZsZXhfY2FwcyB7DQo+ICsJYm9vbCBoYXNf
Zmx4X2NzOw0KPiArfTsNCj4gKw0KPiAgc3RydWN0IGF0bWVsX2ZsZXhjb20gew0KPiAgCXZvaWQg
X19pb21lbSAqYmFzZTsNCj4gKwl2b2lkIF9faW9tZW0gKmZsZXhjb21fc2hhcmVkX2Jhc2U7DQo+
ICAJdTMyIG9wbW9kZTsNCj4gIAlzdHJ1Y3QgY2xrICpjbGs7DQo+ICB9Ow0KPiAgDQo+ICtzdGF0
aWMgaW50IGF0bWVsX2ZsZXhjb21fbGFuOTY2eF9jc19jb25maWcoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgYXRtZWxfZmxleGNvbSAqZGRhdGEgPSBkZXZf
Z2V0X2RydmRhdGEoJnBkZXYtPmRldik7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBk
ZXYtPmRldi5vZl9ub2RlOw0KPiArCXUzMiBmbHhfc2hyZF9waW5zWzJdLCBmbHhfY3NbMl0sIHZh
bDsNCj4gKwlpbnQgZXJyLCBpLCBjb3VudDsNCj4gKw0KPiArCWNvdW50ID0gb2ZfcHJvcGVydHlf
Y291bnRfdTMyX2VsZW1zKG5wLCAibWljcm9jaGlwLGZseC1zaHJkLXBpbnMiKTsNCj4gKwlpZiAo
Y291bnQgPD0gMCB8fCBjb3VudCA+IDIpIHsNCj4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiSW52
YWxpZCAlcyBwcm9wZXJ0eSAoJWQpXG4iLCAiZmx4LXNocmQtcGlucyIsDQo+ICsJCQkJY291bnQp
Ow0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwllcnIgPSBvZl9wcm9wZXJ0
eV9yZWFkX3UzMl9hcnJheShucCwgIm1pY3JvY2hpcCxmbHgtc2hyZC1waW5zIiwgZmx4X3NocmRf
cGlucywgY291bnQpOw0KPiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwll
cnIgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheShucCwgIm1pY3JvY2hpcCxmbHgtY3MiLCBm
bHhfY3MsIGNvdW50KTsNCj4gKwlpZiAoZXJyKQ0KPiArCQlyZXR1cm4gZXJyOw0KPiArDQo+ICsJ
Zm9yIChpID0gMDsgaSA8IGNvdW50OyBpKyspIHsNCj4gKwkJaWYgKGZseF9zaHJkX3BpbnNbaV0g
PiBGTEVYX1NIUkRfUElOX01BWCkNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJCWlm
IChmbHhfY3NbaV0gPiBGTEVYX0NTX01BWCkNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+
ICsJCXZhbCA9IH4oMSA8PCBmbHhfc2hyZF9waW5zW2ldKSAmIEZMRVhfU0hSRF9NQVNLOw0KPiAr
DQo+ICsJCWlmIChmbHhfY3NbaV0gPT0gMCkNCj4gKwkJCXdyaXRlbCh2YWwsIGRkYXRhLT5mbGV4
Y29tX3NoYXJlZF9iYXNlICsgRkxFWF9TSFJEX1NTX01BU0tfMCk7DQo+ICsJCWVsc2UNCj4gKwkJ
CXdyaXRlbCh2YWwsIGRkYXRhLT5mbGV4Y29tX3NoYXJlZF9iYXNlICsgRkxFWF9TSFJEX1NTX01B
U0tfMSk7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBp
bnQgYXRtZWxfZmxleGNvbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
ew0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gKwlj
b25zdCBzdHJ1Y3QgYXRtZWxfZmxleF9jYXBzICpjYXBzOw0KPiAgCXN0cnVjdCByZXNvdXJjZSAq
cmVzOw0KPiAgCXN0cnVjdCBhdG1lbF9mbGV4Y29tICpkZGF0YTsNCj4gIAlpbnQgZXJyOw0KPiBA
QCAtNzYsMTMgKzEyOSw1MiBAQCBzdGF0aWMgaW50IGF0bWVsX2ZsZXhjb21fcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkgKi8NCj4gIAl3cml0ZWwoRkxFWF9NUl9PUE1P
REUoZGRhdGEtPm9wbW9kZSksIGRkYXRhLT5iYXNlICsgRkxFWF9NUik7DQo+ICANCj4gKwljYXBz
ID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPiArCWlmICghY2Fwcykg
ew0KPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDb3VsZCBub3QgcmV0cmlldmUgZmxleGNvbSBj
YXBzXG4iKTsNCj4gKwkJZXJyID0gLUVJTlZBTDsNCj4gKwkJZ290byBjbGtfZGlzYWJsZTsNCj4g
Kwl9DQo+ICsNCj4gKwlpZiAoY2Fwcy0+aGFzX2ZseF9jcyAmJiBvZl9wcm9wZXJ0eV9yZWFkX2Jv
b2wobnAsICJtaWNyb2NoaXAsZmx4LXNocmQtcGlucyIpKSB7DQo+ICsJCWRkYXRhLT5mbGV4Y29t
X3NoYXJlZF9iYXNlID0gZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UocGRl
diwgMSwgTlVMTCk7DQo+ICsJCWlmIChJU19FUlIoZGRhdGEtPmZsZXhjb21fc2hhcmVkX2Jhc2Up
KSB7DQo+ICsJCQllcnIgPSBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsDQo+ICsJCQkJCVBUUl9F
UlIoZGRhdGEtPmZsZXhjb21fc2hhcmVkX2Jhc2UpLA0KPiArCQkJCQkiZmFpbGVkIHRvIGdldCBm
bGV4Y29tIHNoYXJlZCBiYXNlIGFkZHJlc3NcbiIpOw0KPiArCQkJZ290byBjbGtfZGlzYWJsZTsN
Cj4gKwkJfQ0KPiArDQo+ICsJCWVyciA9IGF0bWVsX2ZsZXhjb21fbGFuOTY2eF9jc19jb25maWco
cGRldik7DQo+ICsJCWlmIChlcnIpDQo+ICsJCQlnb3RvIGNsa19kaXNhYmxlOw0KPiArCX0NCj4g
Kw0KPiArY2xrX2Rpc2FibGU6DQo+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRkYXRhLT5jbGsp
Ow0KPiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQo+ICANCj4gIAlyZXR1cm4gZGV2bV9v
Zl9wbGF0Zm9ybV9wb3B1bGF0ZSgmcGRldi0+ZGV2KTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBhdG1lbF9mbGV4X2NhcHMgYXRtZWxfZmxleGNvbV9jYXBzID0ge307DQo+ICsN
Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXRtZWxfZmxleF9jYXBzIGxhbjk2NnhfZmxleGNvbV9j
YXBzID0gew0KPiArCS5oYXNfZmx4X2NzID0gdHJ1ZSwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0bWVsX2ZsZXhjb21fb2ZfbWF0Y2hbXSA9IHsNCj4g
LQl7IC5jb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDItZmxleGNvbSIgfSwNCj4gKwl7DQo+ICsJ
CS5jb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDItZmxleGNvbSIsDQo+ICsJCS5kYXRhID0gJmF0
bWVsX2ZsZXhjb21fY2FwcywNCj4gKwl9LA0KPiArDQo+ICsJew0KPiArCQkuY29tcGF0aWJsZSA9
ICJtaWNyb2NoaXAsbGFuOTY2eC1mbGV4Y29tIiwNCj4gKwkJLmRhdGEgPSAmbGFuOTY2eF9mbGV4
Y29tX2NhcHMsDQo+ICsJfSwNCj4gKw0KPiAgCXsgLyogc2VudGluZWwgKi8gfQ0KPiAgfTsNCj4g
IE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGF0bWVsX2ZsZXhjb21fb2ZfbWF0Y2gpOw0KDQo=
