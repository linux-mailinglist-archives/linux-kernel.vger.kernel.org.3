Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6552E50B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbiETGad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345861AbiETGa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:30:29 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96E814C773
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653028228; x=1684564228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J7+XjiLhdqM+VkYLr+Q09TuzFJAcZDJA7znxSB8HsKw=;
  b=d/ibAqZ5emXOWj8eFKVmemZVEf06SzczYYaDwMfybYG3eyii52aV4ejd
   ZHvN5HyEf9eK0F0pM28f9KZii8aeQd8iK5vA22hyXAUGsOEuFX7vQAxlS
   ooZxtwaDH/o8G2bUTW22jaYcxWvdQh4/bw9m7I7dd9WD4YKtv7h4QNYp4
   AVVDMRniljc8cxI6SOwzB5UOc8lALN2Ee06gXjIbnKEtOtn1pYbycksro
   /FDJjOxLxW195D3Vnc2OyMqyFjwwAdYBmvGxejgwBlg3w3F0DHLdE6UoP
   HEH82aeeOgDtG/5Q0IDhcSCw12/M1M85AkJdLENJlUtFeJZkney/1R6Fq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="56378549"
X-IronPort-AV: E=Sophos;i="5.91,238,1647270000"; 
   d="scan'208";a="56378549"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 15:30:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diuA3t04RZFyGvsa78QH6OghiT6R+UwoUmdScII9zu0JfE3B69euLfROOkJtN23ncI7bXl1pcCx1XveRcxmAcvM6b5C0vU1z74JV5IyS5vND0EhTQo4LukklrVkHgTVcGCGOWJ6JnAnmyJUrPCVOv29Jt6IguzZGwflPu/9hyFzz7mYmFaEDYf07l3rZ1ylevDrWs7nJzJeVThDCiNX1J4gDXTXN5yy00Av2WqLkE9IcRpNzdTCztNRSYhK/5tpBtQkIB0T4SBL1fe2AFxNSHC5dYBQe5j2Y4oxiqE8xn9pCx3NeoORYO5FWtz4s81ikSFTlAzZW7WNgArwk9A72gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7OqvdZg1nHdadDg6xzdc1V9UojigGxqCf1d234g1Xk=;
 b=YtjkcnAIHiby/D4B4tem5KrdFTclugGwQn1Od49cwBOK3VSZNQC4mkNmid7aPpODDak0K8Z8/fFi1IaXva4MQUDmtf0/kktKMeFxdPyAHcdbK1T3r1WkVa4jxI43q+hMb1frlLQ+C0qZYZ1EJGqHuGznGH6HIegDeaIhWw0Ve5u2DcOm7LhB+xYnTFV3reN4ucCEYh61VqHJa62uSY100mrNzGpI2NJ7stgtC3KL0Qjy4azNfvjihH2Qby6qNsNmYtJjq9kIf7KK9tBuugwzri+cvqGdLYnrVc5ST6VfteHUI69N2BTlgRaBIa/FOiO0GQmlxfuqJyKTlI8E4BWcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7OqvdZg1nHdadDg6xzdc1V9UojigGxqCf1d234g1Xk=;
 b=gsJ6VPKPV+bBmAzWLwDsve0sqyRZuKXxTyTOXNoKjaxJxZCRNKWFGejZpvCG+lSacGT0i7LWUcIpM6+62YaJ3GxIXN0Xjr2bbCYWBfv+XMlQSMNznV8sbFnl7/N2f142DYOE/iXW4+M9nGLDpu9LW0/cEFSUp5iV13YK5VDdLcg=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYCPR01MB7028.jpnprd01.prod.outlook.com (2603:1096:400:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 06:30:16 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8%7]) with mapi id 15.20.5273.015; Fri, 20 May 2022
 06:30:15 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 6/8] x86: Add hardware prefetch control support for x86
Thread-Topic: [PATCH v4 6/8] x86: Add hardware prefetch control support for
 x86
Thread-Index: AQHYaoDq7xJ4aiU+QEW7cdrhasBWQq0kMBYAgAMb2BA=
Date:   Fri, 20 May 2022 06:30:15 +0000
Message-ID: <OSBPR01MB2037623843E2507F7131945A80D39@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-7-tarumizu.kohei@fujitsu.com>
 <YoSVglItX1PhveEP@kroah.com>
In-Reply-To: <YoSVglItX1PhveEP@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b525d429-27c7-4ed5-0b5f-08da3a2a33d5
x-ms-traffictypediagnostic: TYCPR01MB7028:EE_
x-microsoft-antispam-prvs: <TYCPR01MB70284A4C70DE5D549593EAEF80D39@TYCPR01MB7028.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pZkTsqfuDpUNHgTfjkHp8eJCCkdKKw7d0ispSyVJLkF9S5eEfAP8eCH6F5PPgSz4tG9uKgLpLYl3xSjo2ezlKPeyQjpAwC2IKUmP8jtDYY7+0ETu4Z+/HsPHpbQFEfYXSQYCcbDrao4HAZBjQAO+z7gpHiLMAQ8EHj4CmjhKK1CdKtXGqxvVh1yXdA9ZywgyEsMSeW2OzpLjP4hg6RHKPpJUu97we76lcE5ehSB+rktLzgCyFl/sc8uRcUWrHZ0AqMKVtjUsBMhyM1lb4fSR9B4MwSQ8QRKcJYRZmhbYmc44kM+dhVY2vafA07pjf5oa+ccpE7Y5SYgzDwFnwFvbHzGtJSx0fldT/zSE4U6DL/lE4+j0wpoc/l0WdI3IkV80EUFXSSxbXL0NlC6Au1V+v3PeGFYoy2MQi0B2LQwugtgRH6fwTv1/lIflUKOF5Ao8ZJ02ge/JKE8WlskXb+5XN73kzqLUlevmurpFM/bNiPLmb0wY4Wug6AvgxJYvY3zEGUUSmNuwklcXv8k9islVuvoh2GoQ+8xo6eWc9Tv1hQ60aYppJF+VfOTMqjyEs19zbfUCP74PhaawZeUp5r/27Lkx4kMGBLTt1v2OEHX60yrFVmbPqdbPMo8zmmGnS3KlDc1gZiVgLPivsB+zQ0xno8oqc4N47HVPFI93kJI5W+XMD6v8UD7+ni/EQxFEOJg6Q+OorscCAsVjrZfAvM/Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(55016003)(7696005)(8936002)(85182001)(122000001)(508600001)(6506007)(54906003)(6916009)(4326008)(33656002)(38070700005)(38100700002)(66946007)(71200400001)(7416002)(66556008)(64756008)(66476007)(66446008)(76116006)(8676002)(26005)(52536014)(82960400001)(86362001)(9686003)(5660300002)(4744005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VGxMWjMxWTU5elptRmNvdjRUZEFtMHFzWFVhRmZxWndGRXRDM0J4SDcy?=
 =?iso-2022-jp?B?Y1NvVllIaWFHMnFWYngwSkhaU1FsUmdiUG10bWNvSGFYTVpJYkwrOFhq?=
 =?iso-2022-jp?B?d3BpSEFvM3I2WnRnMlVmcXhmNjRKeXR4azdMdDVFYVhjdDZwanZsY3U0?=
 =?iso-2022-jp?B?TG8wZmY1WFE1TXpmZVd0MW5wQ2dYYlZDNEZqV3JKc0ZFUUsxTEkvRmxQ?=
 =?iso-2022-jp?B?akdLMDZobDBOU2d5UXRiUXE4SkdrYzFLUWtjcXBvcFFiWGVRaTE3eXhS?=
 =?iso-2022-jp?B?T2lhV1o4VklVNWtvSmVtVnpTbDNuNkVjTCtUbVk1Nk1SMjdBSHhXaTFv?=
 =?iso-2022-jp?B?OERxNXE3YktWbVRRcWhlcXNZVTNTTzYrUlpOY3NTV0ozK0s2K0Ercjhv?=
 =?iso-2022-jp?B?eW42V29mYkxocFVJV0daajdWRnhKODN2ck5MRjVmbVBVVStRbWt3T3BS?=
 =?iso-2022-jp?B?VFNJUFZsaEkxaGlHVGhYWGhESWcrc0hRWEUrZTVNSUxxTVYzQVNZSUpU?=
 =?iso-2022-jp?B?QzYwZjNZTU1KYkkveWkwd2FpRllhZ2hMS2FLVjFER1ZxNURMdm9nWmNx?=
 =?iso-2022-jp?B?VFlZNncwVEJSTGdzUlVRZzVCQnpwenNJY2txU0xGcGlrRENPRjNCV2Vx?=
 =?iso-2022-jp?B?bE02Um92cEFCak9aZmw1NEdmUnkvR3laVGxxdytrcFBjUDZYWTdSZGs0?=
 =?iso-2022-jp?B?cmIrOFZwWVMrM0RTTjRIdHlCZmluRlNXWHlkN1pvN29MWitkZFdTTllw?=
 =?iso-2022-jp?B?c0FqN1k0MjlTUnpGS2FjR09LMXdyMzdEWnc1V0JkdE40cWU2OVJOc1Rn?=
 =?iso-2022-jp?B?bnRxLzVYYUcwVktuWVNnZnl6WXZEM2NOSmZGMXNtc2h6ajBZRDFtUGYy?=
 =?iso-2022-jp?B?K0drVDY1cWlzSEpVVG1aTnE3WHJSQ1lEMDYrUU5LNnpFU0RIS25qaFhv?=
 =?iso-2022-jp?B?VzVkajI5VjRQNDlyUEFJMUtDcE1NUzIzRUIxVHpMRHB0N2FDQzFJdkxJ?=
 =?iso-2022-jp?B?QXhVS0RXWGpKT2NhSUdUQzVsNWlKcGE4R0FnMXlHYTdUb1RIRXpHUFd6?=
 =?iso-2022-jp?B?NGtUTXZKRlV1QngvSVd4MkZuQ2ZyYkFiU09jRVRsSk5QUHRMZDJjVTNr?=
 =?iso-2022-jp?B?RVFDaEFseWRDVGo3cmM3bkpvc1F0RHk2SW43dHl4RXRidCt0TFhyTG1y?=
 =?iso-2022-jp?B?WThOV3NhVmRROFdZZmRibTd0RGFXc1NVbG1lOXE1RHNTcjJMaVdhTlhi?=
 =?iso-2022-jp?B?am0yaUZBTWF1VkR2UW5HUFJmR0thYlhWdktOMTZNL0pMT0IvdDZnV3BS?=
 =?iso-2022-jp?B?K21Kd2RQd2VVWXVYME9kckJoRGg4cmJkRDFHL3lxemFmcGY3MXk2NnpW?=
 =?iso-2022-jp?B?SXkvOVVrdzBuWEcxSTRLRkhiUlZHQUZkanpOR3o4SWNPZTFNa0kvR0dO?=
 =?iso-2022-jp?B?Y3UwVDROK2lWUGRSV0hyRnB2MEwwaXN3dVhqOXJvZmF4eDZxRkpuQXp5?=
 =?iso-2022-jp?B?ZThPYzJaZzFvR09HSjlQeDFET2lSSWFWcnRLaS9hYUlnZ1dXd0JXVlM2?=
 =?iso-2022-jp?B?eEg1ZElLMzFJVld6QjhJVjhsbCswZlpxMURVVUtKQUtzelhOUEsrTXVq?=
 =?iso-2022-jp?B?UnVvOXhZSFhtUjg3RkFHY3JBZzRHNHorazBDdEdGMk9zNVdERE1GOW9j?=
 =?iso-2022-jp?B?c1FseGsrZm9RZWJjS0dDdExMOVYyQnJUa2ZkVzNCQzYybSs1c0NNSnRN?=
 =?iso-2022-jp?B?eTg2NEwzRVI0OWRGaG1qOG5uazRJVWxQVStFOVVpaWw5YVZoUkVoOFhK?=
 =?iso-2022-jp?B?dEtYRWNLSHdKRk02V0xveE9mQkxqRllKUXBJT1hqSXM4bnBvc0c3MzYw?=
 =?iso-2022-jp?B?a0ZFWE80TGMxZjZBMVpBYVB5TVNNazJ6eU01a0NUSS9zQUp2NU91RHpn?=
 =?iso-2022-jp?B?MjNiWm9OZFc2QzBFUEM2RW9QUXhzZW1XMmlHeHc3TG9yaUZDNFdsbmJU?=
 =?iso-2022-jp?B?ZEF2SCtteFlsUlptUFQ3SCtBSlo0VDgzeXJpYVVSaUhpWVgxcWYwSGg1?=
 =?iso-2022-jp?B?MS9neVVOWm9vTVZ4a0RSQmVMcU4ydUF2RkJNZlhmSmJndTkzU1FHMlZ5?=
 =?iso-2022-jp?B?OVZTZVlLakJHRDBUTzNYYWhCMlhtWXNsWFVla3lHT084UG9sdk41ZEJD?=
 =?iso-2022-jp?B?M2RBYW1YLzF1a2JYKzkwbXF2VmFaTjIwMXl4YnJoSlYxcWlTUGQ0NzJt?=
 =?iso-2022-jp?B?MnBXL2tNejFhRU9SQ2d3ZlpYTkJVUlQxUFlrYSttZDF3Vit5SFhXMUtU?=
 =?iso-2022-jp?B?aFVSNStnNU5nQ1ZYOG55RE1kNjlOa1RqRkNoSmlqWlNTT2JqVW85QWZj?=
 =?iso-2022-jp?B?VHdpMitXbnRRTXZYWDBQQnh6QWhWUWhxR2JMS1ZCWlk3bjkrMUZOdk9Q?=
 =?iso-2022-jp?B?Yy9TbFZoRTg0cTdCT2IyNGhlcGhtQjg4RWNuY2ZkaHVqYlJyVUJWb3Rk?=
 =?iso-2022-jp?B?dGtZbmJQVThNU1pNc1h3UU1udXdKaUxvWHBIRHZsVXdDckhTajRZamVa?=
 =?iso-2022-jp?B?cUNGeWV5Yz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b525d429-27c7-4ed5-0b5f-08da3a2a33d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 06:30:15.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjNW+NsdKcw0Ydup3FewNdWJn8CkN/Na/CJ3aNfS8vB7uluPTrw6GzdKSrC3jP9eikm01ckjr2+Br5t+3l/riJwKMUL+AJk5+thQglY+4nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7028
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As much fun as it is to see a function like this, that is not ok, and nev=
er guaranteed
> to keep working, sorry.  Please find the device properly, never assume a =
specific
> driver model topology as they are guaranteed to break over time and never
> supposed to be static like this.

I will consider a method that does not depend on a specific driver
model topology in the next version.

> How do you know attributes are to be marked read only after init?  Do oth=
er parts
> of the kernel do that?  I don't think the driver core guarantees that at =
all.

I will fix a proper marking in the next version.
