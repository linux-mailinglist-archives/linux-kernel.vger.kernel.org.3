Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E224A4CB893
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiCCIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiCCIUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:20:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCED171845
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646295584; x=1677831584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZuTcCNDFL2+kjqNCx+qYr69ZReosFWuWPyDJLkgs0TQ=;
  b=lbr1EFFnru8drfd8MOpYFTITY11kp1pqkQHTDN7FMTsHbNBjr92VzqcY
   PZ2mvEoJQJHh72JS8FxG2jt51Qc+u84UUUUsXnyvcXr4JqIHVZNFpC08P
   mESXyZU6/X6Ny6DFYE+XG/Id7bpE8adyfDwpHU4AHdpcEgDU0WErHPzMf
   2kjEW3tByAWAzQv0WCTaVnCQTWtMS+dc6zkFDkMFfzdJ4lyT8Kk0N2ALY
   mNGQ9zW+UJM9Wojld3XsW3fAiP4wsEn/fOiKZVfDnYIT38eIeHOxzv4yp
   8PbZ/In8XcTrN0Lt9UiaLcc5p6oEW3tZlaXjCT6b53cirhcUB4Rb63B3A
   g==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643698800"; 
   d="scan'208";a="87664377"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 01:19:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 01:19:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 3 Mar 2022 01:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inVEpVLN/COHnpNh68psYbOF0KgsLwiW+L/+++4SGBiuQcSJtwDgEq1KVMkk2bUsbd6NuB2BHWd2v/6MwDtrlZS8nUYwhstgnPd5LEwPWq3K7PVKvF5grJ1SVMqRorsG7Ocyb911laKlxsVOkUjs5SYAe2fqSt0ocIkOosQ+P8EDixvSBId6bqTaOTZHPKCN82a0Uf5tKUfylAqCdbL9i7bvtu8qQbZbjzq+6Xk2OvdU4+EN7U5alZQ35ktBjw5vCuP4+mMOjy8V4Pn03Nb754SQ+5Sui5VHYDXWC1zPeDEiNYrHPii5iSEaKAacDdw1vMH8IN0WK/TFfqgAE3JL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuTcCNDFL2+kjqNCx+qYr69ZReosFWuWPyDJLkgs0TQ=;
 b=CRBCBGCB12ftW2jwSksBX6V/6Rspoh4jPqT7+7ptHWy5Qek60veGuSgqacRlRgtkdjahIXWvpPfplYEVfNr5V4m28mDPmdPPXudsX718TKQdJxMq1TB2AO+93L1E8VoXiS8Cq9QxRgch8oULc9hqpZ60QfFnUHOOeyljmdoDsdINPHnl2s8D+BoeLlbqbKSbOrQOUUV8GKsFJiWuP4BD4k5jCvnGfw1DLJD2gnzZv+7Sp4q7QzhmI4R48zwZjZQKdsA4xBlu8/3m/n1m9Hmtl+7LQnLXmWnnZfYSf5hZK3Tx2GuVQmYYN+xV5s4HeMwJEOUQXvkcQgmt3utZ7O9XVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuTcCNDFL2+kjqNCx+qYr69ZReosFWuWPyDJLkgs0TQ=;
 b=T5n8USSuZ+qPPbNISRycZZ7aoDCxpwxx3JNbRoUUpswsZhb98deaSquisKjK7S5bjhybwf6W9apZuvQbMihJoI0oyCloHGMl2PgLcvC+X5LWQ/6ZaHrU6Qb/CzU6hAK/mzbwBERRB4hzA309PQeSihP67ly+iznsktFczN+JYSc=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by DM5PR1101MB2298.namprd11.prod.outlook.com (2603:10b6:4:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 08:19:37 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 08:19:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <Mihai.Sain@microchip.com>
Subject: Re: [PATCH] ARM: at91: add support in soc driver for new SAMA5D29
Thread-Topic: [PATCH] ARM: at91: add support in soc driver for new SAMA5D29
Thread-Index: AQHYLtdsiLAtAgbCzUSE5U4ZN3SI+Q==
Date:   Thu, 3 Mar 2022 08:19:37 +0000
Message-ID: <63d5bc08-7681-954a-2106-2653abf76b57@microchip.com>
References: <20220302155329.27668-1-nicolas.ferre@microchip.com>
In-Reply-To: <20220302155329.27668-1-nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b76facb-79b3-4187-909a-08d9fcee8e89
x-ms-traffictypediagnostic: DM5PR1101MB2298:EE_
x-microsoft-antispam-prvs: <DM5PR1101MB2298511FCAD1DECB4C42545F87049@DM5PR1101MB2298.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86z3NvT0uBz8urc6c/l3jYKhlRSwrhodSApH4AHZfVyS0bGGOK5jAl++H+WTXq4STgv5snfmHMY4I30nzBdaeU+K1/S/11hz8IQ9iPsar3LC6X9PW9dIr/z5CCYvohx2U2Xl+fW4lwtmgJFP922Go3clzmsRrgwLEXBAHKrguIvB0XZW+JTh7JbiYB8Y3QF+5puvpIUCdqRmPm+ZPK4d/qFp6fafFuQ80gQJdleLly9yL98igxBF9olHfLOXQTomq3mvE2NuVXqw0Nvfa/le90fmK/pG1fAjqmM5/J9ShbK1jq0lS0fQNRnRDpxL2h1nmu5xiZhXJElx/ou+6nZ4QoCQlp/46pxD8RtOFR9NXfHvOX+7M93bE0+LsrHjJHXrGlqn1SLtBiHJBwx+30To8lOpUMUS++A9okK8RjsUmvCA/u48vqjhRQviMNkxu+v13cbRPV//GwU7nTWRethzr08NX17RR8djTS8WEF53iLw6AHJ3ihRKSc73YwULjR8nAFTpvMo1YjnyZ9ebbnlu93KQov3Wl1v+er4GP6Z5Zjrpc8ZVJljsWtsouGK3gLjpmQ109NR3X0q+hnDPe1+6DpeTcs85kUIA6idc8f7sK9edvXLLgqT48Y4X2WOECP2IBawBbRFo/lY0tH/g8JjZlUBGEAcuhP5LqDpylBSMTFWAx8dL0TTldJzNglhRvrgv+0hsrki66TgLphdcl5twSLyB1CXSuZD3NxJVitqVABllofsrL12m9UrYOVea4ajsG+KtLxpSS9L2BgjzWGIVAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8936002)(2616005)(38100700002)(36756003)(53546011)(6506007)(31686004)(71200400001)(508600001)(122000001)(83380400001)(110136005)(54906003)(107886003)(316002)(6512007)(38070700005)(86362001)(31696002)(5660300002)(26005)(186003)(66556008)(66946007)(64756008)(66476007)(76116006)(66446008)(8676002)(91956017)(2906002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlpxbTkyVjU2UUhQMGcva2UwNG9tQzBlT2tOZDRreGI5d2kxbm5JZDZNSFk2?=
 =?utf-8?B?UnN6MFJxWEN2ZERTU3htRWpONmVHNHNESHIvV21yMGR4cWNsUk1UNjZUdEQz?=
 =?utf-8?B?NFA3Wjk0dkVHaEZQVkFCVWZrQVE5TEovUmpveTlXaytmM3MwQnNMQnkrMmFY?=
 =?utf-8?B?ZFJEYmt5VkQ2elpBaE02RGNXL3JiY0Y2eTdFRU5RNGVTS1lTUzZ1Qmxpa013?=
 =?utf-8?B?OC9nL0poSDUyQ0NqeU9PcUZVdjF0MzJjcXlYVHVsNC9SbGExc3FXQno3OTRI?=
 =?utf-8?B?dFVXVWRJcFBmUVd4V2tBbmRiRVBsY3UwaHh4ZFlPekNsdldsUmR3d1hvL3NQ?=
 =?utf-8?B?VnJEUXIxUmJVMkVrOHVodVQzMFlBMnMzTzN4RHlQSXdxZ2pxeFRYeEExUUsv?=
 =?utf-8?B?ejl6eUxIUTRMaFczRThFUzBpQWZkdno2T1BvanBLT25tWG1lYWJtTXlmem9l?=
 =?utf-8?B?cXAzZlhpMDhYZ25ObXFPMDdFeHhJWGtYeFBxZ0xNajhjbnVpaDlLWjNVandE?=
 =?utf-8?B?MXgvSVV3ajdlRjk1d3pLQ1VyUzlNTGhIVHR4TmloNUlqNThObkUyZUlkbVFH?=
 =?utf-8?B?ZXJEY0VLNDdPZ09ZMytWR2Y0cExNKzErQ3Jxdjd4NjVBNnFJa0c5ZGNTS1d6?=
 =?utf-8?B?RkdTcnJQQUMzdlg5M2J0SVovVUpuaW96R2F4VEVicHRrYVdmMURPWGRWRXMx?=
 =?utf-8?B?RDdWbURqM1Y0S2w0UVFQYXM5OFl4YzUzWE5DRWhMdi9ZYVhMbWdNd1dJZ2Ru?=
 =?utf-8?B?RlIzMkhZZkM0OUptL05RK2tJZHpyRFJFa2R6U25IM2dlaHNQcmE1eDFKcjBD?=
 =?utf-8?B?dFRrTTR3Q1hGZExyWE0vNXJVVlNrVUpyNDZEalhXdXpqcTdoSnpLOWM2WUdY?=
 =?utf-8?B?S0cvb0ZhT01vUWdiOTBRMGdlZjdCbWxEclVxeTA4ZXNlMDRzMVY0ZWNnMDZ1?=
 =?utf-8?B?cGtSS1NjTllDOGFnOER5SDROVVN0MFFWeHYzb2V6L3NtRFZweVhPY29XelFk?=
 =?utf-8?B?QjZPV1JLQ3pkTnhQL2ZIbUNvVXY5M0NycmJCUmducXcvb3JvUWFFRnJMWmts?=
 =?utf-8?B?VDRIUmdNRGdpdjR4YnRTWGtneGhhYnYrOGkzbFFCTUhzM3VkN1Q0SE0rOXpF?=
 =?utf-8?B?N0RHSXFkRXZYZnloa3ZBU0RnYVlJQjdzZGhhdUptYnZNdjBSMm0yZ0t4c1Vu?=
 =?utf-8?B?L1NVWitRb0xMRTZHR1dTajlpTHFkUW5vZUtTN0cvZmtpbG92azhOYW1DTTQv?=
 =?utf-8?B?d2RQOGxQZ3RjWHdDL0tPam8xNHVqalYrZ1RtbmtlNWlmK0w1NGthQjJNeGhr?=
 =?utf-8?B?dWZ3STRjYndOR3Jja3FpVWx4RVFtS2ExaWdYUzYwU1EveDZ3MHJZOEU5dlNU?=
 =?utf-8?B?QTlKcFJ6MEMrUDJycUEzRFFEOUx0eWNhcktjcUlwdENTQ2l2RUtUWk4zZ1l1?=
 =?utf-8?B?d29SNk5ma2JQOWlaTmI3Mkg2UDVXM2o4Y2VyeThENVNZWW5mRktBZWJRL3lq?=
 =?utf-8?B?Mk80ZHd6SWE5RlN2MSsyeHF3bTNGZFJOQ2ZRTHVLTjl0Y0lSZUZrMmJqM2l6?=
 =?utf-8?B?RVR2TlNXK0FaRnAvV2grM0s1TmM3WXIyUWJmSXEyZUJ0dXdvSmJaQVFNd1J3?=
 =?utf-8?B?Wm5zYzFzUTZwUStBeitXcUhudE9UZU9oMFZpb0Q0cldhbnJOWUdDYWhkQWM0?=
 =?utf-8?B?a3F5S2lPcWlkZUh2SXdEQ2o1MUhWaEc1Yy8rd28zSTAwcTlXODFUTjJHbXlh?=
 =?utf-8?B?am1IVXNaY2YzSUUzdkwvYndON1lQNEh0Z25LTG5PMmtvdXI1ZUxGcERzSjM3?=
 =?utf-8?B?MFVwSy9LbGFpRklOZUx5Z0FjOFpRekxBc2w0T3Q1dmhCMTlqcjZveE13Qld3?=
 =?utf-8?B?aGxLYmhtSzc3WGFDQTVpbFpHY3d0QUZQcFVuVnR3TittUGV0RnNjRnU4K09F?=
 =?utf-8?B?RW1zOTZ4cUtPVGM2d2dpdmtSTkVlTzh4SGFqSzBoUzVjdGY3MndHc3laMGVj?=
 =?utf-8?B?Q1RlaGhkYU1BRFh0ZVgxMTFPdEc3SXNTQTdqWVFpT2NaUktnaldaUG5aanBC?=
 =?utf-8?B?UHkrd216SnRaZGFyNUJxYkV1dzFRYlVGQnlWb3A3aThmUWtsVld1Q1NIQ2xG?=
 =?utf-8?B?UC9vN3JVaFYyMlZmNkl6OXZlQkFXYndBUHRHUEdiaFpUd0J6VjVFQ2Z6NUlh?=
 =?utf-8?B?bUdlVXFrVTdQQjIyTFhaWUZqclZVT0FyRDZOQjQ3dXFVTDJkTTFUMmFvZXJU?=
 =?utf-8?B?dE9ma0xFbEU0b24wdUhsaTExWmF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BE8AB11CE1E4C429F0BAF01195239E0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b76facb-79b3-4187-909a-08d9fcee8e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 08:19:37.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILVOxUZvVpZ6eyvqEUFADKpMtxePqdl3XThPe9g9eyrZoyQhLYaCe8T26FFSa2Ep1F2FroCiOGpXKWI5odVFVNc1zj4eU1ZIcOTWCI41Jqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2298
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMDMuMjAyMiAxNzo1Mywgbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiBGcm9tOiBNaWhhaSBTYWluIDxtaWhhaS5zYWluQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBBZGQg
ZGV0ZWN0aW9uIG9mIG5ldyBTQU1BNUQyOSBieSB0aGUgU29DIGRyaXZlci4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE1paGFpIFNhaW4gPG1paGFpLnNhaW5AbWljcm9jaGlwLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KDQpS
ZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3NvYy9hdG1lbC9zb2MuYyB8IDMgKysrDQo+ICBkcml2ZXJz
L3NvYy9hdG1lbC9zb2MuaCB8IDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9hdG1lbC9zb2MuYyBiL2RyaXZlcnMv
c29jL2F0bWVsL3NvYy5jDQo+IGluZGV4IGE0OTBhZDdlMDkwZi4uYjJkMzY1YWUwMjgyIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9hdG1lbC9zb2MuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9h
dG1lbC9zb2MuYw0KPiBAQCAtMTU2LDYgKzE1Niw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXQ5
MV9zb2Mgc29jc1tdIF9faW5pdGNvbnN0ID0gew0KPiAgCUFUOTFfU09DKFNBTUE1RDJfQ0lEUl9N
QVRDSCwgQVQ5MV9DSURSX01BVENIX01BU0ssDQo+ICAJCSBBVDkxX0NJRFJfVkVSU0lPTl9NQVNL
LCBTQU1BNUQyOENfTEQyR19FWElEX01BVENILA0KPiAgCQkgInNhbWE1ZDI4YyAyNTZNaUIgTFBE
RFIyIFNpUCIsICJzYW1hNWQyIiksDQo+ICsJQVQ5MV9TT0MoU0FNQTVEMl9DSURSX01BVENILCBB
VDkxX0NJRFJfTUFUQ0hfTUFTSywNCj4gKwkJIEFUOTFfQ0lEUl9WRVJTSU9OX01BU0ssIFNBTUE1
RDI5Q05fRVhJRF9NQVRDSCwNCj4gKwkJICJzYW1hNWQyOSIsICJzYW1hNWQyIiksDQo+ICAJQVQ5
MV9TT0MoU0FNQTVEM19DSURSX01BVENILCBBVDkxX0NJRFJfTUFUQ0hfTUFTSywNCj4gIAkJIEFU
OTFfQ0lEUl9WRVJTSU9OX01BU0ssIFNBTUE1RDMxX0VYSURfTUFUQ0gsDQo+ICAJCSAic2FtYTVk
MzEiLCAic2FtYTVkMyIpLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvYXRtZWwvc29jLmgg
Yi9kcml2ZXJzL3NvYy9hdG1lbC9zb2MuaA0KPiBpbmRleCBjM2ViM2M4ZjA4MzQuLjJlY2FhNzVi
MDBmMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvYXRtZWwvc29jLmgNCj4gKysrIGIvZHJp
dmVycy9zb2MvYXRtZWwvc29jLmgNCj4gQEAgLTk1LDYgKzk1LDcgQEAgYXQ5MV9zb2NfaW5pdChj
b25zdCBzdHJ1Y3QgYXQ5MV9zb2MgKnNvY3MpOw0KPiAgI2RlZmluZSBTQU1BNUQyOENfTEQyR19F
WElEX01BVENICTB4MDAwMDAwNzINCj4gICNkZWZpbmUgU0FNQTVEMjhDVV9FWElEX01BVENICQkw
eDAwMDAwMDEwDQo+ICAjZGVmaW5lIFNBTUE1RDI4Q05fRVhJRF9NQVRDSAkJMHgwMDAwMDAyMA0K
PiArI2RlZmluZSBTQU1BNUQyOUNOX0VYSURfTUFUQ0gJCTB4MDAwMDAwMjMNCj4gIA0KPiAgI2Rl
ZmluZSBTQU1BNUQzX0NJRFJfTUFUQ0gJCTB4MGE1YzA3YzANCj4gICNkZWZpbmUgU0FNQTVEMzFf
RVhJRF9NQVRDSAkJMHgwMDQ0NDMwMA0KDQo=
