Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C594F4AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573637AbiDEWwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457417AbiDEQDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C4713D7C;
        Tue,  5 Apr 2022 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649173376; x=1680709376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vGmj3Y0IIlIk6gpSt2hVgAmDTIyd+PehJrs89VgsB3E=;
  b=zh2xk9tRdaHkAVTJ9azz6n0hKR2ullGmeXRCJkY/uzj9strvUv9NeZ2Y
   6HmgrlnYm5TbK+bv7XqjflqlcUM2X7bBwSeeON82bNBw5qIXHrTHr3xie
   MYTnHYhyiPCTsAg7diJ/5+9IjhJPstHijGQHiasvVSj9jxNlhne8HDgSO
   Vk3pw0mZl4LYhBFvI4o1NU0wTd5Aa+bAbwCIHADupNvUodOmx3zg/V5SE
   WWrGmceCIs+hI7n/r0cmzm8AJz82UxcTNVUIiv+T7nDq/we8cpc0sFLUa
   0vxrwwS0ctm47BruFx074AxQwfqCc8Mcu3Yvdx/cQ0M95tR6/LUh/GErT
   w==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="159389694"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 08:42:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 08:42:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 5 Apr 2022 08:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hctkqS8dOVylk5WGHDJJ3USdl2MozYp92SaQih0FIZk4GF+tq9YPnPiM+rzXUuEYeuelHdQBcPg6yUTzGlv0PbVZiKL29YEFHR/9YSaP8M5AlFlVLUp1KL09gpkVZ3PQyF4otPbl65XbIHY6+YwNTgrhfBaw6caGo9v5vKhCTudulHBj0Ozr9opZkSqjqTiF/kGhBULuHZ/YrZL2kYLyOg4neaLPaizGnSt4O1ZDMk9OT5ZKCQZUKkI0ji7y4JuI6C3gJRmlQOy1rfLrOcX8sljwXCRHZ82+mY0gIyH7oW5zNSmsIDam8VmNB7Fi3jbyA6oH7z6j3Hw/Wp4mZF2tRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGmj3Y0IIlIk6gpSt2hVgAmDTIyd+PehJrs89VgsB3E=;
 b=ZClHL7tmtYVZrcphAPTiWl09ZzluL0cc5B9rtyZsJGi1k1v7trPo+eqLWTI4zsccNDJg/D4iKz6utV14WgPyiLWDQegjwkpiHv07H4vGOuxHaHH6SPXB/kqaqZGtifSdgaOk5hDvRhgIiSlmp2gT+osFKdOc7oumuCCHrnNVpToF3uTmNyc3cjEiMz25XYpJ608sSPy4SR4zRUXsZiWuIrU8MD/LkbSkJ9MzZnVw+fa+T2Jkuu8NXC+wr61p+caiwFhA0itXyK3t8eQ8dAt1DeyW5nLFZhiF3H3B1Wa4c1mxNsS2CI37cC0m+PyfuN65hMZXfHgMa8EtWJntZr/VxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGmj3Y0IIlIk6gpSt2hVgAmDTIyd+PehJrs89VgsB3E=;
 b=mOPeB18gsbxa6vLh4YQo9CXerowBJsk83rTS8RILYn7GUGZbfwRhakRsfmLY3bsZ2snzIoDpBRS3FFRp/6QJa97l7xf0yZiajg0aIh41rZcfHLusblAjLcqu3sDAduj55X4Oubkbxfqibbj2a+aDe9+jHSO7pwh9tygfN44JV74=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by MN2PR11MB3616.namprd11.prod.outlook.com (2603:10b6:208:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 15:42:42 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 15:42:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add reset_controller_dev
 support
Thread-Topic: [PATCH 6/8] power: reset: at91-reset: add reset_controller_dev
 support
Thread-Index: AQHYSPwE63noJBr7cUyVHBDjjcHiyQ==
Date:   Tue, 5 Apr 2022 15:42:42 +0000
Message-ID: <923f9a0d-0a5a-99ee-a20c-db69ab44a41c@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
 <20220405112724.2760905-7-claudiu.beznea@microchip.com>
 <0ff9a7cd2e6261a0de32db3bf16901e3737efef8.camel@pengutronix.de>
 <9683a951-160a-b4e4-9494-c2e6ee51582e@microchip.com>
 <f90d23f8c781d75bd0d171e1ab4e99c1d217d1ff.camel@pengutronix.de>
In-Reply-To: <f90d23f8c781d75bd0d171e1ab4e99c1d217d1ff.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0454216e-a798-4576-6410-08da171aec5e
x-ms-traffictypediagnostic: MN2PR11MB3616:EE_
x-microsoft-antispam-prvs: <MN2PR11MB3616DCFF7C1D23AD6BF1215D87E49@MN2PR11MB3616.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cy9ODmzHla+jKp4iNPv0RqkfVH2gqD6LWWu6IYKtZQFQUGyWi6CV6ZXlLxiw6mmzY3ik0m68XYzFHqSvGykYTP2IucHQ3+YMQ/ZLw/k1PQ+TC37+XQ4plEUyzWRwCG1eMc68enrFVcfnBFXF7smY1rn0UA/rP2guJQ9dPalwso8fgomIKICkHhryJv0ImrSeVKiak7Y4mqi5PFmEaF9WuKj2E2fUC7nvOYEDIoiuN0v3NsLwqS+iO9zPfKclIPAUgpqWcYzQOSHeFSIpMCcgM9BT8fBRYqZ0oQkjsl2igc2pof2+7capq3as93+RbEWw6rxm+hx6AQnLq3qe6IPOyLdt53qpiGRUdvMVg0sMEUSDClmuuwp2E5WuSW8DK2hg9h1FtFM2g8aJR3FW69/92AczQsb0nYX3TOpOxaHKqnYfI8Sz5knzAMvfh3Xq9Xk1eWtiEF2C+eLaHaG0KC8Y/sKeo2DY311vzvujMs62pbFBh5r15+lwTsP/XtfndXhxj/szmf4D408HaIEZ3CFJ9/J+ZkwhLE1Fj6Sl8/z0Zdp5s4GYWD3QL7QM2IMBT44EIXTSW9bQfQSr3C5PVrCD3Ivt9WTNGJXqYdk4EBV4seGdX4/Fbccr4EU4sgnDzdyf75Yw8zz5N4HdhuX9Ok8myIdNLRkJmbpZil18VKyx0LMqp87w5VNCwkRmEqUPdJ6pJxfiYlerd41Mwf4jLNfVoOzLbrbw1g8m+2x6GtWqjqLJnU7Y5OvCP1TUYCLR1h2qEUUy9FhiLwyH6XzS8JM63A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38070700005)(316002)(31686004)(6486002)(54906003)(110136005)(71200400001)(508600001)(36756003)(26005)(186003)(64756008)(66476007)(91956017)(66946007)(76116006)(66446008)(8676002)(66556008)(2906002)(8936002)(86362001)(2616005)(83380400001)(31696002)(6512007)(6506007)(53546011)(4326008)(122000001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QytzaGY1K1FjenVvaWFyVHVTN3pxOWlYY3lxSWR5N20vQllJZjRqc1Z2SDRW?=
 =?utf-8?B?ZEZHSk8rVjFNN1gyK2pWOXc4KzlRZTRXRFhtanpUOTlEWkV4Yk5zdFZ4RWR3?=
 =?utf-8?B?NXhSMDlZRDJPS2xhbG1QY3lrdFltWDJadmF5OEx3cHpYdG9xaDlCcWFjRjFK?=
 =?utf-8?B?bzdMbnU0dXNobFFzNG52ZWwrdmhENTNIVXVEODZTckpCa2E4MUxxaDRqa3NP?=
 =?utf-8?B?aEd2T0NxVlEyQzVKZWZkeVQ4czBBQURzejVFWXR6cHU3OEFBa2pMU1FoVStu?=
 =?utf-8?B?TmRlQWc0bFlkM2VwWThyQ2ZuRGN3VEkxcFBKbThjS2piYkp2NW01dno1QmZX?=
 =?utf-8?B?eS92c05wWnJ6Z1hvb1gzSVRVcXpsQjhLT2x5R1Vwdjg0R2N0dmM4MnJ6a25G?=
 =?utf-8?B?eUNsdlZNYU12REFYT0lPQUtCYTdCTnJuamhvMGJEOFF5a0pQdFZ6cEt4d2Js?=
 =?utf-8?B?MlVLWS94cnhjeWRiZ3g2NXlTZlZGRWV5ZVBCKzM4eVllNVcrMzFod3dhRUFv?=
 =?utf-8?B?MER6b1dwTjNVazUwaFFrQkEvUjA1RmJUMFJYVU9aeDIwNFZmZW1uRnhoTno5?=
 =?utf-8?B?d2dlUjNDbHFvWVk3VFltUUxOTUEybWlkYkhEZjN0aXpJU0ZUcnYzRHJtVFI3?=
 =?utf-8?B?dXJSalVKZENwTG1xQ0xNL2g3dlVBSFpRN1JhaW9pODIweUV3L1JldEMxeHFl?=
 =?utf-8?B?Z0c3eU4wdEEzN1hlcEV0T2N4eE4yaTdzRm5UY3pHMjlGVzJBSFZMS3d6TUsv?=
 =?utf-8?B?ekd3SlhOMUJzT1VSSzBHVjdYL0tVcm9tTXNvNExxdmJJSXIrNWRMVFpvblRl?=
 =?utf-8?B?Z2lGNVEvZTVYWjFwU0F1Q29CeElvOHozU3pjcFBmVnc5UURucUthaUpXZ0FZ?=
 =?utf-8?B?YzBXa3dxM2VLMVhsRXNjOURsUDBsUzVaenpJbCtuK3J4aWkzLy9oYjR0TjNN?=
 =?utf-8?B?ZU9acCsrN2w4K0trSGltNVFGRHM2bUFXeE9tMFVUMkJiZk5NVnZFQXl6KzBE?=
 =?utf-8?B?NmUvenlGZGlKeVo0M2o3b0w3Y0JzU2RyMnl0K0E5cnhkUXdHRUlMZ0Jqa0pQ?=
 =?utf-8?B?ZG43My93YnN0RkNURzY5dCs0b3R0MnR2TG5FcS85U0I3SWdOb1FIbU9oZFRo?=
 =?utf-8?B?U0lVRHI0WklRanQwaWJMcGZvdG5vODNqUE94eTRrUGlLb2xmdUhDRHhHa21Y?=
 =?utf-8?B?QkpMV1RmVkZlLzhycUQzbGFkQXBHYzQ0RXZoTVJkZjhUWDQ2bjJZQU41SmpQ?=
 =?utf-8?B?aGplM0tqUjBmS2t0VUVmUXRNbTRkS0xLOHRqOW9ENlVNcDNuUTZtVHRUWStB?=
 =?utf-8?B?eGx6Z25XRkU5VmRkRXRYVzU2WkRGbFNPM25FOGJvdzlHY0RZZDF5TndjcVBL?=
 =?utf-8?B?djJxcnpQWjJwcVBkdm1aWHBWL0FmbktvbTAyRnhwR1VUNDJlSWtIQmdxUEJN?=
 =?utf-8?B?Vi9jazZ3OVZtK3pZQ24zNDB6OHc4SnFQdHRCKzc0cW1hZmN3WXhCNEdCeEw3?=
 =?utf-8?B?WnZwSER4Q1BDNEM5N2J4UytFTVVzSHFYSGMvd0JkNXkrSkUyUm52WW9oaExK?=
 =?utf-8?B?NWp5NnZQckhsVXJMd2xLcUE2eVdoQkdYNk1YYkVMTFo2OVhGK1puRE1UdG5v?=
 =?utf-8?B?QlFaZ1FEQzE2YUt4RE5xR0ZvT3B3VzJEeGdnMFBkR1BZNzYrcnNPWEVQSTRa?=
 =?utf-8?B?eTVPRHhxdzRsMEQyTDhZN3V5UnIzNmhBb0FQOCtTOXNKNFNPNmY0VUZBZGtk?=
 =?utf-8?B?VVpxYWVucmJ0dGdmeVBnVFREWjBhWE90a1RnVU9ha0l0dmFJZW9Bd1ZxVmpH?=
 =?utf-8?B?dytnV1R4c3FtVEExRDdYcnhaMEFoaWhJd1A2TjMvZWh2THNJS1NyRG5MK2tJ?=
 =?utf-8?B?NkhqKzNyM3JrajRhbUdOT2RzRnVkL1lNTWcyTWR4TzYvN2k0L1c3N0M4RzNv?=
 =?utf-8?B?ZzFKWjBCL1VQT2tNTm9FeDExQ2V6OHlNVnFZRFlJYjVTcG9GUjVMMFNSVS9p?=
 =?utf-8?B?T1c1ZjZlTzN3N29jZzJORS9xK2hKa1pZWWhuOS9vYi9OV0NGTVE1K01VLzk2?=
 =?utf-8?B?UWNaSjQwclZtN3NWK0sxZm1SVS9CUWJDNVJKMHptWS94UTkreFhldWc3ajRO?=
 =?utf-8?B?RnFpUWZVdnlvV0NEYmhQQm1yZFhocWhQQ01vaFJkZTlUd1U5QmdCSDgreGRO?=
 =?utf-8?B?R1VmNkQ4R2NLcmdzQmM4K3VoSWZkcFVnckVWd0lUOE0vWVEzR29DSTlyWi9T?=
 =?utf-8?B?cXVUM2YzMTBsdU43bWVod2E4SjlmODFaMG9lRmE4Y0VwNEpGbXdTNEJhQUky?=
 =?utf-8?B?QU5vUmQ0b24xdFFLOGlkZWFhNmwrL0RoWmc3Q2JyNXN0UjA0cXAvaUZCRHFv?=
 =?utf-8?Q?DyixVylrHOePqJ+k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <643768DA49346B4C978AD610C2151C95@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0454216e-a798-4576-6410-08da171aec5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 15:42:42.7450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44MZsjTeA0RDq/faIBONHg5U6GFf0bcXtA8ub1FNAMKoH17EYIpADzWP2hCXHHwxmC4/lkU0ZQvLO5RfKwdhfafO/QDTa8TTa7uEYdoCjFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3616
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMDQuMjAyMiAxODoxNSwgUGhpbGlwcCBaYWJlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBDbGF1ZGlvLA0KPiANCj4gT24gRGksIDIw
MjItMDQtMDUgYXQgMTQ6NDcgKzAwMDAsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+PiBIaSwgUGhpbGlwcCwNCj4+DQo+PiBPbiAwNS4wNC4yMDIyIDE0OjQ3LCBQaGlsaXBw
IFphYmVsIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+Pj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pj4NCj4+PiBIaSBDbGF1ZGl1LA0KPj4+DQo+Pj4gT24gRGksIDIwMjItMDQtMDUgYXQgMTQ6
MjcgKzAzMDAsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4+PiBTQU1BN0c1IHJlc2V0IGNvbnRy
b2xsZXIgaGFzIDUgZXh0cmEgbGluZXMgdGhhdCBnb2VzIHRvIGRpZmZlcmVudA0KPj4+PiBkZXZp
Y2VzDQo+Pj4+ICgzIGxpbmVzIHRvIFVTQiBQSFlzLCAxIGxpbmUgdG8gRERSIGNvbnRyb2xsZXIs
IG9uZSBsaW5lIEREUiBQSFkNCj4+Pj4gY29udHJvbGxlcikuIFRoZXNlIHJlc2V0IGxpbmVzIGNv
dWxkIGJlIHJlcXVlc3RlZCBieSBkaWZmZXJlbnQNCj4+Pj4gY29udHJvbGxlcg0KPj4+PiBkcml2
ZXJzIChlLmcuIFVTQiBQSFkgZHJpdmVyKSBhbmQgdGhlc2UgY29udHJvbGxlcnMnIGRyaXZlcnMN
Cj4+Pj4gY291bGQNCj4+Pj4gYXNzZXJ0L2RlYXNzZXJ0IHRoZXNlIGxpbmVzIHdoZW4gbmVjZXNz
YXJ5LiBUaHVzIGFkZCBzdXBwb3J0IGZvcg0KPj4+PiByZXNldF9jb250cm9sbGVyX2RldiB3aGlj
aCBicmluZ3MgdGhpcyBmdW5jdGlvbmFsaXR5Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBD
bGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+Pj4gLS0tDQo+
Pj4+ICBkcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtcmVzZXQuYyB8IDkyDQo+Pj4+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgODggaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cG93ZXIvcmVzZXQvYXQ5MS1yZXNldC5jDQo+Pj4+IGIvZHJpdmVycy9wb3dlci9yZXNldC9hdDkx
LXJlc2V0LmMNCj4+Pj4gaW5kZXggMGQ3MjFlMjdmNTQ1Li5iMDRkZjU0YzE1ZDIgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1yZXNldC5jDQo+Pj4+ICsrKyBiL2Ry
aXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1yZXNldC5jDQo+Pj4+IEBAIC0xNyw2ICsxNyw3IEBADQo+
Pj4+ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPj4+PiAgI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RldmljZS5oPg0KPj4+PiAgI2luY2x1ZGUgPGxpbnV4L3JlYm9vdC5oPg0KPj4+
PiArI2luY2x1ZGUgPGxpbnV4L3Jlc2V0LWNvbnRyb2xsZXIuaD4NCj4+Pj4NCj4+Pj4gICNpbmNs
dWRlIDxzb2MvYXQ5MS9hdDkxc2FtOV9kZHJzZHIuaD4NCj4+Pj4gICNpbmNsdWRlIDxzb2MvYXQ5
MS9hdDkxc2FtOV9zZHJhbWMuaD4NCj4+Pj4gQEAgLTUzLDEyICs1NCwxNiBAQCBlbnVtIHJlc2V0
X3R5cGUgew0KPj4+PiAgc3RydWN0IGF0OTFfcmVzZXQgew0KPj4+PiAgICAgICAgIHZvaWQgX19p
b21lbSAqcnN0Y19iYXNlOw0KPj4+PiAgICAgICAgIHZvaWQgX19pb21lbSAqcmFtY19iYXNlWzJd
Ow0KPj4+PiArICAgICAgIHZvaWQgX19pb21lbSAqZGV2X2Jhc2U7DQo+Pj4+ICsgICAgICAgc3Ry
dWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2IHJjZGV2Ow0KPj4+PiAgICAgICAgIHN0cnVjdCBjbGsg
KnNjbGs7DQo+Pj4+ICAgICAgICAgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIG5iOw0KPj4+PiAgICAg
ICAgIHUzMiBhcmdzOw0KPj4+PiAgICAgICAgIHUzMiByYW1jX2xwcjsNCj4+Pj4gIH07DQo+Pj4+
DQo+Pj4+ICsjZGVmaW5lIHRvX2F0OTFfcmVzZXQocikgICAgICAgY29udGFpbmVyX29mKHIsIHN0
cnVjdA0KPj4+PiBhdDkxX3Jlc2V0LCByY2RldikNCj4+Pj4gKw0KPj4+PiAgc3RydWN0IGF0OTFf
cmVzZXRfZGF0YSB7DQo+Pj4+ICAgICAgICAgdTMyIHJlc2V0X2FyZ3M7DQo+Pj4+ICAgICAgICAg
dTMyIG5fZGV2aWNlX3Jlc2V0Ow0KPj4+PiBAQCAtMTkxLDYgKzE5Niw3OSBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPj4+PiBhdDkxX3Jlc2V0X29mX21hdGNoW10gPSB7DQo+
Pj4+ICB9Ow0KPj4+PiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYXQ5MV9yZXNldF9vZl9tYXRj
aCk7DQo+Pj4+DQo+Pj4+ICtzdGF0aWMgaW50IGF0OTFfcmVzZXRfdXBkYXRlKHN0cnVjdCByZXNl
dF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgbG9uZyBpZCwgYm9vbCBhc3NlcnQpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgICAg
c3RydWN0IGF0OTFfcmVzZXQgKnJlc2V0ID0gdG9fYXQ5MV9yZXNldChyY2Rldik7DQo+Pj4+ICsg
ICAgICAgdTMyIHZhbDsNCj4+Pj4gKw0KPj4+PiArICAgICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQo
cmVzZXQtPmRldl9iYXNlKTsNCj4+Pj4gKyAgICAgICBpZiAoYXNzZXJ0KQ0KPj4+PiArICAgICAg
ICAgICAgICAgdmFsIHw9IEJJVChpZCk7DQo+Pj4+ICsgICAgICAgZWxzZQ0KPj4+PiArICAgICAg
ICAgICAgICAgdmFsICY9IH5CSVQoaWQpOw0KPj4+PiArICAgICAgIHdyaXRlbF9yZWxheGVkKHZh
bCwgcmVzZXQtPmRldl9iYXNlKTsNCj4+Pg0KPj4+IFRoaXMgcmVhZC1tb2RpZnktdXBkYXRlIHNo
b3VsZCBiZSBwcm90ZWN0ZWQgYnkgYSBzcGlubG9jay4NCj4+Pg0KPj4+PiArDQo+Pj4+ICsgICAg
ICAgcmV0dXJuIDA7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBpbnQgYXQ5MV9yZXNl
dF9hc3NlcnQoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGlkKQ0KPj4+PiArew0KPj4+PiAr
ICAgICAgIHJldHVybiBhdDkxX3Jlc2V0X3VwZGF0ZShyY2RldiwgaWQsIHRydWUpOw0KPj4+PiAr
fQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgaW50IGF0OTFfcmVzZXRfZGVhc3NlcnQoc3RydWN0IHJl
c2V0X2NvbnRyb2xsZXJfZGV2DQo+Pj4+ICpyY2RldiwNCj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaWQpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgICAgcmV0
dXJuIGF0OTFfcmVzZXRfdXBkYXRlKHJjZGV2LCBpZCwgZmFsc2UpOw0KPj4+PiArfQ0KPj4+PiAr
DQo+Pj4+ICtzdGF0aWMgaW50IGF0OTFfcmVzZXRfZGV2X3N0YXR1cyhzdHJ1Y3QgcmVzZXRfY29u
dHJvbGxlcl9kZXYNCj4+Pj4gKnJjZGV2LA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBsb25nIGlkKQ0KPj4+PiArew0KPj4+PiArICAgICAgIHN0cnVjdCBh
dDkxX3Jlc2V0ICpyZXNldCA9IHRvX2F0OTFfcmVzZXQocmNkZXYpOw0KPj4+PiArICAgICAgIHUz
MiB2YWw7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICB2YWwgPSByZWFkbF9yZWxheGVkKHJlc2V0LT5k
ZXZfYmFzZSk7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICByZXR1cm4gISEodmFsICYgQklUKGlkKSk7
DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcmVzZXRfY29udHJv
bF9vcHMgYXQ5MV9yZXNldF9vcHMgPSB7DQo+Pj4+ICsgICAgICAgLmFzc2VydCA9IGF0OTFfcmVz
ZXRfYXNzZXJ0LA0KPj4+PiArICAgICAgIC5kZWFzc2VydCA9IGF0OTFfcmVzZXRfZGVhc3NlcnQs
DQo+Pj4+ICsgICAgICAgLnN0YXR1cyA9IGF0OTFfcmVzZXRfZGV2X3N0YXR1cywNCj4+Pj4gK307
DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBpbnQgYXQ5MV9yZXNldF9vZl94bGF0ZShzdHJ1Y3QgcmVz
ZXRfY29udHJvbGxlcl9kZXYNCj4+Pj4gKnJjZGV2LA0KPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3Qgc3RydWN0IG9mX3BoYW5kbGVfYXJncw0KPj4+PiAqcmVzZXRfc3Bl
YykNCj4+Pj4gK3sNCj4+Pj4gKyAgICAgICByZXR1cm4gcmVzZXRfc3BlYy0+YXJnc1swXTsNCj4+
Pj4gK30NCj4+Pg0KPj4+IEZvciAxOjEgbWFwcGluZ3MgdGhlcmUgaXMgbm8gbmVlZCBmb3IgYSBj
dXN0b20gb2ZfeGxhdGUgaGFuZGxlci4NCj4+PiBKdXN0DQo+Pj4gbGVhdmUgb2ZfeGxhdGUgYW5k
IG9mX3Jlc2V0X25fY2VsbHMgZW1wdHkuDQo+Pg0KPj4gSSd2ZSBkb3VibGUgY2hlY2tlZCB0aGF0
LiBUaGlzIHdvdWxkIHdvcmsgaWYgcmVzZXQgaWRzIGFyZSBjb250aW51b3VzDQo+PiBmcm9tDQo+
PiB6ZXJvIHRvIHJjZGV2Lm5yX3Jlc2V0cy4gVGhpcyB0aGUgb2ZfcmVzZXRfc2ltcGxlX3hsYXRl
Og0KPj4NCj4+IHN0YXRpYyBpbnQgb2ZfcmVzZXRfc2ltcGxlX3hsYXRlKHN0cnVjdCByZXNldF9j
b250cm9sbGVyX2RldiAqcmNkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzDQo+PiAqcmVzZXRfc3BlYykNCj4+IHsNCj4+
ICAgICAgICAgaWYgKHJlc2V0X3NwZWMtPmFyZ3NbMF0gPj0gcmNkZXYtPm5yX3Jlc2V0cykNCj4+
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICAgICAgICAgcmV0dXJuIHJlc2V0
X3NwZWMtPmFyZ3NbMF07DQo+PiB9DQo+Pg0KPj4gQnV0IGluIHRoaXMgZHJpdmVyJ3MgY2FzZSB3
ZSBoYXZlIDMgaWRzOiA0LCA1LCA2LiBUaGF0IGlzIHRoZSByZWFzb24NCj4+IEkgaGFkIHRoaXMg
c2ltcGxlIHhsYXRlIGZ1bmN0aW9uLg0KPiANCj4gSSBzZWUuIEluIHRoYXQgY2FzZSBJJ2Qgc2F5
IGtlZXAgdGhlIGN1c3RvbSBvZl94bGF0ZSBidXQgbGV0IGl0IHJldHVybg0KPiAtRUlOVkFMIGlm
IHRoZSBhcmdzWzBdIHZhbHVlIGlzIG5vdCA0LCA1LCBvciA2Lg0KDQpJIHdpbGwgZ28gZm9yIHRo
aXMgYXBwcm9hY2ggKEkgdGhvdWdoIG9mIGl0IGluaXRpYWxseSBidXQgbGV0IGFzaWRlIGFmdGVy
KQ0KdG8gYWxzbyBwcm90ZWN0IHRoZSBvdGhlciAyIHJlc2V0cyAoRERSIGNvbnRyb2xsZXIgYW5k
IEREUiBQSFkgY29udHJvbGxlcikNCndoaWNoIGFyZSBhdCBiaXRzIDAgYW5kIDIgaW4gcmVnaXN0
ZXIgYXQgcnN0Yy0+ZGV2X2Jhc2UuDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCj4g
DQo+IE9yIHlvdSBjb3VsZCBzZXQgbnJfcmVzZXRzIHRvIDcsIGJ1dCB1bmxlc3MgdGhlcmUgYXJl
IG1vcmUgcmVzZXRzIGF0DQo+IHRoZSBsb3dlciBiaXRzLCB0aGF0IHdvdWxkbid0IG5lY2Vzc2Fy
aWx5IGJlIGJldHRlci4NCj4gDQo+IHJlZ2FyZHMNCj4gUGhpbGlwcA0KDQo=
