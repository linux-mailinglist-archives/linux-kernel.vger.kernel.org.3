Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AF6553614
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351888AbiFUP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352878AbiFUP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:28:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8410E1836A;
        Tue, 21 Jun 2022 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655825301; x=1687361301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gBf0LqQowmHbqndEtyfr0waTAdzyPbEs2AQBRT64W14=;
  b=X+zmxlM8TrrwB8l30bIWLKflsW21Nta7F0SlW/DUJ8g8cviTsPG6Cyth
   rWDNU8VnZhf8aV3yj9cDjK3H9ucd6wMLVMGgqpn8GIxo5PM/dzxQ0dktE
   zVaJoMvEOS2XiZywXr8sf+/FvPGWPnweKob8q8M7bGqiIoCsianZfhFYa
   X5hh+QjPdEvDit5/9GeqMB0Ku2wcCgFm0bSIdczNiBMvUOEiI19Q73xat
   Q8ylmTbuQS4JjLTJ7Q24/aZJ0rYp1mzNEu1r8oaaFxW3p46Fb9bwlP6jk
   2i7wr21cyKhxTR0TQmGL87ZObo+WAjIcyKcxFOi8QrrBr4raFtUbL4oEX
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="178890249"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2022 08:28:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 21 Jun 2022 08:28:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 21 Jun 2022 08:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS9b3dimkETi0d7O7DemGfi2twyLc/QZiI94SQGyi0j9G7NopPyVx31ZZFYVaNzFc+Ec9+g/05oCDXrPVPgILpw8SQhZ6Eor6zdq6WENiB+kCmoPw0Xt67RwzyBOYPvRn0pUMF8lOaXyS8L8x25JYrSUuqEEIumcBpUoqvEvPp2UuRnlWG/MkRqxup+zOpyvWAdVKmUZbKLHp1+/RJiwIlGQR8My4+nnQk01jJ82YfQ84TxCbRVMQRA/4jkuairQj0Nuv/WWOz9zPNImPRXclgcLFM4D4Ao0m8XT6yLGTIjIQux0X6X1Fvjp1bFlMAblyXXJrTbMaj6aiy6x0GtGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBf0LqQowmHbqndEtyfr0waTAdzyPbEs2AQBRT64W14=;
 b=FPuuJZxsupyW8E4ew5Z/3gCFelZb6AAgQNMckHdn/R4QxZp0fCVthNIR8dQ7T0aZYVxsxmb8at2fwIKpN10yI0IeU7ELkM0bILjV6mDdDho2B88qxgYWXucUDI/0j3xt5dEmdS6Rk9Zl48oqnD2xUdN26rRV34UxkairMz71zh3AdZoBowdyp1x1moTPWWFDK87m8kiPvj2rgGdyMbQpv4ZK1miVtEOzLgEGx8aOAdT0HGCqS/SAl/DP4Pi/nZJHVf2A+5tJNo1gT051onVrDsAqDuMN9bA+pnCnXlQGbDGcl0aX6N64dnXeRxbcGmtIyGKfifxRvCt6oqqWwg6+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBf0LqQowmHbqndEtyfr0waTAdzyPbEs2AQBRT64W14=;
 b=EITnqaJ9LSbUA1T4GGHNhbnTiMLP/jGWtu/acR02CpksFpMG7RZD02Kq7o+nf2u9JVDEEqSYQu7qLzi+IJWl5jm2IS5xwN7ZsoALZr1TW+FKG9lNObWlGpsUH6QuFKIns227A7QkiLUujZMWo1WcgMsQuaZT+RdJsxpHUFm4HlQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB2037.namprd11.prod.outlook.com (2603:10b6:903:2f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 21 Jun
 2022 15:28:12 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 15:28:12 +0000
From:   <Conor.Dooley@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <b-liu@ti.com>, <Daire.McNamara@microchip.com>,
        <Valentina.FernandezAlanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <ben.dooks@codethink.co.uk>,
        <heinrich.schuchardt@canonical.com>, <Nicolas.Ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Thread-Topic: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Thread-Index: AQHYfxuMNjzv9qrP8E6NLA6/7ruhLa1Z+lWAgAALTQCAAAMwAA==
Date:   Tue, 21 Jun 2022 15:28:12 +0000
Message-ID: <ebeed0db-eb78-7f77-f4d8-93c7c7caab24@microchip.com>
References: <20220613114642.1615292-1-conor.dooley@microchip.com>
 <YrHXZYe4e4vlCHh3@kroah.com>
 <6c9001fa-5315-c9f4-b7b9-05248635750d@microchip.com>
In-Reply-To: <6c9001fa-5315-c9f4-b7b9-05248635750d@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5c2a207-b7fd-42f1-323c-08da539aa7a0
x-ms-traffictypediagnostic: CY4PR11MB2037:EE_
x-microsoft-antispam-prvs: <CY4PR11MB2037BFEADB23EA170D89655A98B39@CY4PR11MB2037.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNfb9pzylr80k0p3kmtUX3EuZCqob9oeC/rjRL/ddM1yM0BfoyQ4diCr7j1xACEiYFoF7jNb+yPehGife3AjexNqiZAVxXiiYkzt/T50F6qpSs7fDDNrO8RUV2pXQ+pGHZNDomqdUiJBr0aQlV9ByTMYsvcf9QpCDeFEVAwMmy2Lcq0LR9k+vCEpPcQWBVjPYkHCuPKy2LWfWfK1myMOJCao5APxn07B7U6JnstoBIGBTasuDOmzwTtFXxd2RLgI3w+rjOcZQmVDi/SYdtLmnUEGcpC2h6M+6AzYyErvN2cLZBaXJZBzfuLYVffzeRG9O9mEo7/npSD+JfCkPtxj0/RTdwVdjrA35AulgTQymhNonR33wZYg/PNp0XbNj0S9JLcapuC1diSyzjnnvscLDdIDbetXjVbeQhbPQO0m9wRHWJHzIb209ajJraL0UFH+J5Iw6AQRHSorO2FuSDn/ELBLfuvoYfucsfzfLnR02o2L4sVPWinB82nvtXxw3isDTKAzJh300kUmkTYSF3D0sb90js916xnKJpMVc1cSPuJrD1Opk7gpcoggLon4yKgkPQz8LQ4EKNPfZomfDbjFzU6b0/mcGQ5+cdbEKkPttfIJYTt1gQ2doO09evn/C16xHKGseOWR50g/xZ86+9Qxqr6my6gus/I1scPJ3a5dMx3TSAX8/ikRogNct69PJrDT6jXJrA8aoFWdEyUMLzp4ypDJXIHj3jAuB1Slf7joETPXUzabQJlNSTfKMdkKa69mXRaRnXiz+VDSXuFvMbo13g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(186003)(83380400001)(38070700005)(122000001)(86362001)(31696002)(38100700002)(6486002)(71200400001)(558084003)(5660300002)(2906002)(31686004)(478600001)(76116006)(54906003)(6916009)(66946007)(91956017)(316002)(6506007)(8936002)(66476007)(66446008)(66556008)(64756008)(107886003)(4326008)(8676002)(26005)(53546011)(6512007)(2616005)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3N6VUZ6a0hFQ0R5NHpaWUhWdm80WVdLR1VDS1k1S2IyMXFTZlA3S2d1NThK?=
 =?utf-8?B?K1ZSVjJoQVpqOUJYaXZacGJSNkliRC9DcGxnelVQWWRnRWpzSWhaYmx6d3ls?=
 =?utf-8?B?THgrS1liS2IzdXMwV08vT0hBWXpLaWlYWHJoV2I3TSt6dFh6QlZyL1pBbDQ1?=
 =?utf-8?B?OUdMS2xqUW5VNWNtZUxGZVQrdzQrOFRYRzE1OFprTVV1OU9rUXFBR3RhRElR?=
 =?utf-8?B?L3RrUE1vN2VrVzBobVhXdkt0ZTY3Wmwrc3Vyd3doN2FuM2tvR0hlVG1palNn?=
 =?utf-8?B?Q3UrRytYN1c0M24zVUV4dTRqc0psem9EekdFcnBjYkFEaEYrV3g5Ym05bERx?=
 =?utf-8?B?WjBsVW1YbWtmTzVnK2ZWeS9jVTMvSTJJWldTZzRkTS9PWDRUWGFVVmhhai9q?=
 =?utf-8?B?M2dkMHJTRkhHSWNEbDdRVU9qN2JzZHFOTnJTNDZNU3kyQS9va09XZlVVVlMy?=
 =?utf-8?B?WDhZL0l5Z056d05CdUh5SGFXRHQ1VWFPVitvWVlGVW1rTGQ2RGYyYW1aQU5w?=
 =?utf-8?B?VnZNT1NWOExpd3IxTHQxVkFLcVBWeVpVdjRpTjdBUnFRTmwvbWFvWmhQbXZY?=
 =?utf-8?B?dll0UXlHYzhLcW5KU09NRnRWcnppYnJBeE9QOUlCcHhlVG1iZnlscUd0Sysz?=
 =?utf-8?B?ZDFWeTRLMnhiTGZmWTVWdTdMS2hJRTZKdlBCTDhRYTYzMzNlSXdyUkdxTi9V?=
 =?utf-8?B?emNVMGxZc3M0dXE3VURqclNpYkgwelhyTFRkNWZpMmM1ZVJOUmo3eVdDZE9z?=
 =?utf-8?B?N0ZQU0w0TThMaDl2SGhIeFNaUEtjY2lNbWdQdHNpbTZVcmg5MHhWdjhxelZn?=
 =?utf-8?B?Rmx0c2xUSXU5aUZxWDR3emZHcDJRbGtBUHBZZHBSbEZTZk1UYzFKbWxRL3Nq?=
 =?utf-8?B?YUdGeTBiZnhXWVVQdHR3Zkh6STVMV2dEWjFSQW1QTU5vSU0rTHRCOTkwTzNv?=
 =?utf-8?B?a0FxVE53WVZ3WjdUVk5sKzhmeWl6aDE3bTd3ait4V1gydnV6RHpjSkV2d2xG?=
 =?utf-8?B?Q0d0THN5Y09ZZkE2ME1vV3lHazRqVUxTM0llOWcwcG5YYng1eDhSNVJHR0JC?=
 =?utf-8?B?dTh6NzdxOVZ1QjZuQnhqRHNZcVpPWVNqUHp3QlgzSk9COTB1MmFwVE8yQzFH?=
 =?utf-8?B?Q0U5MTRvRjFmNHZXMmdWd1Qycnd3N3U1SHdQVENPUUpEQm1FaUtBbkFhQUxN?=
 =?utf-8?B?UDRlWkhVck1VandLY01RdHp0R2tQdEpsOXp0aWNXYVJUMDdhT1hjWXh0eEJW?=
 =?utf-8?B?OFpPcXVzaWYzcFFmT21FTGZTNE9LRnVsQ25vazl5ZUQrZ0dnZ1orQ3ppdnpk?=
 =?utf-8?B?a2VWSkREYjl5MnF1TEo4ZFNLVjcvcUExZCtMNUllNVd6NTVQbXJROUkxSWFZ?=
 =?utf-8?B?S1luUWE1K3VFb1MrVWwyL0txNVM5aHo1eFJwWDFEM2VPWnVHbU9oWFA5VHQ3?=
 =?utf-8?B?Zy9PVnJNMkx6eFRRMUVnUDhaQjBOK2U3VUtqandOUkI5ZmptQ2ZXSUpOOHFB?=
 =?utf-8?B?dzFCdjlIWHRrcVNSN0pMQnllenladm1jU1pGWmw5MVhTM1RIYlk2Y3FOVmlG?=
 =?utf-8?B?UEV4ekg2eDBKTXYwTDVQMm1jZ0dyTnAwbWZDekZ0WDMrdG9IY09UR3ZRZllW?=
 =?utf-8?B?a3ZhTWswRnp2TG9Jdy9LbDVWOXhEeDJRZmJXRXE2WXlPWXJ3ZzFGM1NrcVJD?=
 =?utf-8?B?ZVNhZlYrVVdWU05SL0xRbDlwRGVJZ3pLWGdrdytKY3dmRW1RdC9pcmdaTmlj?=
 =?utf-8?B?dDZEN1ZzdmJybWxqbkYyS2sydmswTTNoZ0ZuWDREczZFQ3cwZVY1anBueHIz?=
 =?utf-8?B?ZWI1aUl4MVpHaE1oaGxvdFdHb1Q1YlhCd2VQY1VUcWpTZC9rWFZXdUVEVjE0?=
 =?utf-8?B?eEQ1OGpyRy9Ed3RlWXV0N3piZy95YkpsaGNwTHVHVW1qWUpRcjJxdHNwdktC?=
 =?utf-8?B?a2NtamtOenNOOU9rbkNnQ0xmWmszLyt6aG80SGZudWJWOW5pNEZPRWlhOGt6?=
 =?utf-8?B?OEVUb0dHV0hrOWZkenRwb1VwZ1FGS3VmR0tISllMbTgzQ1dEN2Y4dXltRS9o?=
 =?utf-8?B?N3h2a3pGdG0wMERLRWNiRzA2alp6K3R5WlEwMHMrYXdaNEFmY3dWaytENUVY?=
 =?utf-8?B?R0ptaU9VZUt2ek1uUng4R29zcXBCTXFhY3QwRFZFQk0xbFVSUkNCQTRVcnVD?=
 =?utf-8?B?cDR0TGlCcHM3WU5yMGVnRzJ3SFVBUTl0L3ZBa25UWU5qa0ZEWkkrMmt6M1FI?=
 =?utf-8?B?QjhRWXczUE9ROXVnVWVPQWV2ajJuTDFWWnlLd2lDdjVGbUpBM0RBR0NNY09R?=
 =?utf-8?B?RlpLTkpEL0dTQkJreWdpdnJtdzhUL1M2MGQvbHZOS1JUTHFGTytwQ3NqWklD?=
 =?utf-8?Q?IPNvV17pW9fGI3oE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D8C05E373096348AC9FFD81064629EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c2a207-b7fd-42f1-323c-08da539aa7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 15:28:12.8396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5djYuEQgJhy+SuF6i6I3h38ubrOOn6o+CwX4yLfCdeICRe8sI+wMh/CiDX6JUZtIMIgmM4P6wr8vLCuyVDxaw29TWIUN99CZKtflTSV4Ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2037
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEvMDYvMjAyMiAxNjoxNiwgQ29ub3IgRG9vbGV5IC0gTTUyNjkxIHdyb3RlOg0KPiANCj4g
DQo+IEkgY2FuIHJlc2VuZCBmcm9tIGFuIGFjY291bnQgdGhhdCBkb2VzIHBhc3MgREtJTSBpZiB5
b3UgbGlrZS4uLg0KDQpudm0sIEkgc2VlIHlvdSd2ZSBhcHBsaWVkIGl0Lg0KDQoNCg0K
