Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417855E4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346597AbiF1NgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346208AbiF1NgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:36:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25BF7661
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656423360; x=1687959360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hkJILEn8D+UzuehCshdjWaKC4oVYeM+R+1OeR3UmSqI=;
  b=NWSE/v4gdSQhhV5Pflks6pToBEz4YiZpqcbSR1cQjrhO439/MK3JlVB9
   8wP3xbk+RcoRLXkJ0q4VQytlo1Ho8v60n6egbjLznE3Xv3o9qE7f0MOTM
   4zA2Js7fh0LQUIauezVcfVF/dB4EZEA0rEq+nxKZR4631KXdu5V4XnaMS
   fNZIQk7gR3ut6dGLrGOM7VOzf3XaoFqhS4h9WDnt9cBgPEDrAZeore7a5
   lpK8UzHin+tfQGWiL29k91nSeejFG8tA2AWLHsPtOsYTJi6u8zz1DuF3M
   rAW3aLuBwtKaXX9h0K7RBzzNyCgy6Y2UdZlXg2/VnRO9+cGxB9rHuV9Ch
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="102093876"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 06:36:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 06:36:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 06:36:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHUxTCkBMKcANQ4l+2gIZr5s5u0rPf6q09nQ7Bz5WwIuWXQszR7XBavjlLMKk6mx9aAO4sdw1d1i4/DQGE9L7AI1RbbjGgCwTahjSI9nWBFjQD2HtsnDnZrIZe1ZDWZht99mw6ibTp3EOFRbTrk8MbQrVls2EyglNg4p1vd4qNJUR4DKtKTIDeUMSquGN6iC8gbe2CMHH+5cGfL7N1FYlTAYe+CUV6+2WbfifQ5Y56rhp80tv8bOeHI1SPVP+gdc9ml7f3kQpXcnkKV6kv8FwGfcJLCrL4j7wGKIDadGP11z6lxeRKFtTrNFwkI+wmhmtwWkHqAW5a63bHnygrFlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkJILEn8D+UzuehCshdjWaKC4oVYeM+R+1OeR3UmSqI=;
 b=BGzH167Rl70bf2R6e56dMWaoHcf6Rwin10fyxF+rWLkU85oFS++CmuxmEd9kioNWcvorHlebyidHty/0ijNr8UJ2R8bID5It/SLotDm85wSzJfNV9jFdtv/hQZJ3qnRvkI3Ouk7/THIW3adK38f64RhpD73A8Kx+QBKY1snqKQQm17jToPc6dXlIvXdfyFnAGyMjr0AzmO600VAv2YF2wZxtDYxa0AxnMyhCJrfvxHTctLsDxhV3qmqh66bFraiZeVH6la393hwC8Ylq0loWhoYwChSk8HAuy4XOCtdeHVzZrUJ3o678RvzVyMROBo6P3O4YwUoORTL31Ccyg23acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkJILEn8D+UzuehCshdjWaKC4oVYeM+R+1OeR3UmSqI=;
 b=nADX/ybpsk2CPZPTmGrO+6FmjxRfqUNtCdFKnFNBjHh7VQTJy54ypJ00UKXfBMdXtySUa/pPNtnQDmj5+GbXnwuxrSKzLh0qFAf30GSY7MKWDpe6ZBrSSe6EkjeHMgmXbiOTiH6cIEl7QhxsAF2Dl3J/iAtjXNvlHolnprcyiDI=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by BN6PR11MB1713.namprd11.prod.outlook.com (2603:10b6:404:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 13:35:55 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0%10]) with mapi id 15.20.5373.018; Tue, 28 Jun
 2022 13:35:55 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <sboyd@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] ARM: at91: pm: fix wakeup from RTC for ULP1
Thread-Topic: [PATCH v2 0/3] ARM: at91: pm: fix wakeup from RTC for ULP1
Thread-Index: AQHYivP+PFq8vGfaZEubO0yCzEwT4Q==
Date:   Tue, 28 Jun 2022 13:35:55 +0000
Message-ID: <c74942bc-1a66-ae01-5e61-bdccb85520bd@microchip.com>
References: <20220523092421.317345-1-claudiu.beznea@microchip.com>
In-Reply-To: <20220523092421.317345-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62c385b6-a01b-4924-3cf6-08da590b208d
x-ms-traffictypediagnostic: BN6PR11MB1713:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qG8r52T52Y/e2d5UJM4J5OCDQFDBXTzB8oImVp2zNiFiq8zabzKeYbn0j5UW75U+8vK7RrkNi9j1/zHr/DuYmeRt6UvgrswNG7/faH8XDjD2OnoWR6Bf72OHj30w7MXMt/cFaPQGDJX7E5C6TwtIJ54ONsm6mqc2gP47nT3HwXUQKMZSSftP3zYASTayR0LgZ4+feNUbMTyQMIWoGGIYn1pkxRkE6mDRvnzi8gCkYipzZZvpc1i6IOGJpTP8hcQDoLbjd36KbEDdRR5MKWm040fOf1HB/AY+Jcx0PxBs5ecoLepOSzA7TplSDlBLzki7NAENGEtI9hMv4pqIkwqABoYoQ2xnhLHC0AV/fZkthcvxvs68JfqDaMQyK4ot5qd+T+ySKYhK//sOW6GkWko14JWNq1pqx3yxGVYAKEaHIFsI7gcQIQfrl/C9lUkDEwuyG+CYYs3s4kNj4FHGdo8Y+2v0k3hNSXq81pkRe78JPR3qmQq+J0fdD1uci5ytVYrt+mHffx7TUryOensgM/ztOktJnaVl4Fyfku+HkmfHZRCA16iyV6sDgNw3+ck2SK0A5x24KOxRMttSplZaGdmjsF8ADrtZJ4Uawai/ztIPPUb5/Bfrv+Yk/g0zO50mhE4vupOYSCTSbreqkm/my+8IS4n7wcdTjg0y7263eBUSmDFUYBpt2hfo/8OUdbJoz/OGgTs2FYY0GczU6ko1JWP1FRLbTFuHiZoUWDbBaqYfZyjtsqCl3W7l/VnJy9B9MICeBidfOiPIGcf8OqdR3GqzsqTo8YdiwVFcPp6T38bWqk8ovNsv0trP83PW5pQ7bIKPltEwE1ZRX4/eGDVuboPsh8HWXVdftObtDfotfwnel/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(346002)(136003)(316002)(478600001)(66446008)(76116006)(66946007)(4326008)(66476007)(64756008)(8676002)(66556008)(6486002)(71200400001)(53546011)(110136005)(54906003)(91956017)(5660300002)(2906002)(4744005)(41300700001)(8936002)(83380400001)(31696002)(6512007)(36756003)(38100700002)(31686004)(26005)(2616005)(6506007)(38070700005)(122000001)(86362001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0FnT0M5VldYNHcyYWozZi9rUlZyZHMxaGNWSzdpdnhyQ040emVrUm94dmJ6?=
 =?utf-8?B?RTNZTGgxRG5mU2VKeTdWTEo4VHk5NVJlRjdQNDkxL01lZ3B3cGlWdVdmUnpL?=
 =?utf-8?B?Vzd2OVhxa2ZiK2E2bHY3bm03dFJrYzFJR1VhcGlKUkpSZHlZc2ZPbnoyaWti?=
 =?utf-8?B?RVgyS2dMa0JaQzhiazlrS05DdXE1SklBWXVHbUlLcWN1RENKSzJMQ3YwMFQ3?=
 =?utf-8?B?QkRzcWRDRFpTM2JndmFTbXVGeGh4UHVrZEFSWTRsYzRoVUVXUzN0R2ZuUFZ2?=
 =?utf-8?B?UWwvTFlPenJVOGJjTlp3REJFL2xJREJDUk5qOVpONC9JeDBnV1NpVjlBZCsy?=
 =?utf-8?B?MXg2d2hJNlJONzgrL1dMUGZRUExlblk1aWdwWUdUeFdFSVdIbVRqZUlQSUlx?=
 =?utf-8?B?cVVPd3lKOWYxdEpqU2tnVHJzUmZMcnpNbnh2dUxqWGlhQ1dQOGdXVTBXTkpT?=
 =?utf-8?B?ODRuVk1GVHMvL1k4Tk9hTVA2b0NFRC9sNnBSR3JWY251Q24reHRneVZ1MXZl?=
 =?utf-8?B?K2NTU3MvL3VUOWtVS2hSWXlRS014VlRhYzF2MkNCdHZ3M2VkY2FkaWxNc3Zi?=
 =?utf-8?B?RXlJWi9QOCsyaHNGNlRDYzkwNnc5VXc5Zmo0Zm92QnZLaWI3ZkVkQ0RrL2Rs?=
 =?utf-8?B?alFPbkk2QTgyR0lkRkJNM3JRTGZKdHNJd28rRmZWYWtXQzZzOS9DY3VLMFpE?=
 =?utf-8?B?dTluT1UwdlNHekczUVMzeVd2NmpNR21hTmxlNURpOFpHamE1VFFYTld6S1pz?=
 =?utf-8?B?WjA0d29VeG0xVEtFOUY1cFZkQzRvUEowa2VuYW1LWUhzWTRvNE1ibG5yL29W?=
 =?utf-8?B?T2trR0xzU2hvM01kVUdlR0NZOGlLcElSbnUwYVJOdG1SNWJlaWMvYzVodGJK?=
 =?utf-8?B?VFRPRnYwcEZLRkFjaU51R3lnUFduVFYxcmh5YXpCdEZiVGp6RzFKYlJjbEpo?=
 =?utf-8?B?Zy9FMW1obWNicVErSnRqWmNrcU9LWmFOUlVySDViMGFXdC9zdEtGS0NFNG9P?=
 =?utf-8?B?aGJuemxYZFNmRDI5eTJYQTAvRG1MWG9zVFFiY3pnb3RoTDBORDcxWHZWVVht?=
 =?utf-8?B?WkR1UWx3ZWVCWmZaUm5rNW5tZ3h1UU83NkNROEFMdkNqZUE0YU93YXF3MTlH?=
 =?utf-8?B?SXhWUGJFUldFR0pjN0tYbGVsUWcwNGFUREExZFZ1Vm55dGtDMDYxcE5ZTDdk?=
 =?utf-8?B?eG9ZdXJOZG9BVEY1dTdzRDkyWXlIMVoyNk1sL2NrVkRyUy8zRGlPdlZDdzc5?=
 =?utf-8?B?eXc1eVhxSDRhN2h1d25wa21qd2xFYlJIdkxoS2xIT1RFaEpqT3NmQWFNRG8y?=
 =?utf-8?B?ZUhRT1UybVgxbEZLelcxdnRtVGkzcWlaWldsVk0xSFNlNnR4bVIvK0Y0WUo5?=
 =?utf-8?B?ZUpJWFZSYXBiUnlEbFJXVlZTdHBhQUdXRzhqRjdHYnJGNzhYRnhxM0QwRHox?=
 =?utf-8?B?d0NyekV0S08vRXA4bEU0cHdNRmhlUnYweEIyVkNoRHliRG9YVWFCMTQ2OHM2?=
 =?utf-8?B?YkpnbnJTN0dxelNidFBDbThLUlp6ZS8vWUZLSUIwUWMwb2g3WXBuK3gybFJ2?=
 =?utf-8?B?b1E0Y0Z6L3R5U0pOdm82WkhKUmIyMkpMcmNYNjYwK0FWQzgxYnZHODRrZ2lE?=
 =?utf-8?B?ZExjN1kvSkFRN0RhRkdjKzRXaEFuNUF5QTlPS3V6MFZDcTgrOHk3c2dQN2J1?=
 =?utf-8?B?NFBQNmFjN2NuajdVODJnTWtMZ1ZnZTk5STBtb0Y4SHE1QVd1bGppY0NhbFFn?=
 =?utf-8?B?Rm11TGlSWGt1MGZRcHB6T1M1L0p3V2wyMnhuSTFEMlF1T0FKV0pyMEUyRHlU?=
 =?utf-8?B?WWpReVlNOXMxZDVqTkR6bHN5cjF2cmhhNSswMy9aYWEyVXRtNWZCUWpkNHhz?=
 =?utf-8?B?NDlReEIvandzVnBhalZrR1hlM0U1K0UxR1BjaFo4MC9VVjZYMURrOXcwMzlS?=
 =?utf-8?B?aEpqallTczlyRyt0ZHQ2dHdyYTNLZUJ3RG9iNC9wNHhpYTZ2YXRobnZFMFpp?=
 =?utf-8?B?dE9hRHF5cnZJNFhCaDNSNUxLMjU3cU5wdnpILzBIYmsxdkV3NjVTcUYwYzZC?=
 =?utf-8?B?NDNNNmdzUHhxeCtMMnJ1UHo0NDRuYXMyb3FaVUhUTTAwYThpb2FkNkh2cHN1?=
 =?utf-8?B?VS9xT1pNa2NGNG01SnVscmc0dGIzeEs2TnFjcnVIdGdkT3VoVm5lbit5QVZ2?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <961B219D6D02B846889E16342D03AA14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c385b6-a01b-4924-3cf6-08da590b208d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 13:35:55.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Rd9csAaB6fcUaAJvILQg2L0P3i2kfjiHV4OtB1UjJcmqu4Vr1Q8TziIp/7RFugK4LpzEQemLfWTFQVX7U+dUv3aqW5GatMWZj2AMJB8G3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1713
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMDUuMjAyMiAxMjoyNCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEhpLA0KPiANCj4g
U2VyaWVzIGZpeGVzIHRoZSB3YWtldXAgZnJvbSBSVEMgYWxhcm0gZm9yIFVMUDEgb24gU0FNOVg2
MCBhbmQgU0FNQTdHNS4NCj4gSSBrZXB0IHRoZW0gYXMgMyBwYXRjaGVzIHRvIGJlIGFibGUgdG8g
YmUgYmFja3BvcnRlZCB0byBwcm9wZXIga2VybmVscy4NCj4gDQo+IFRoYW5rIHlvdSwNCj4gQ2xh
dWRpdSBCZXpuZWENCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gYWRkZWQgcGF0Y2ggd2l0aCB0
aXRsZQ0KPiAgICJBUk06IGF0OTE6IHBtOiB1c2UgcHJvcGVyIGNvbXBhdGlibGVzIGZvciBzYW1h
NWQyJ3MgcnRjIg0KPiANCj4gQ2xhdWRpdSBCZXpuZWEgKDMpOg0KPiAgIEFSTTogYXQ5MTogcG06
IHVzZSBwcm9wZXIgY29tcGF0aWJsZXMgZm9yIHNhbWE1ZDIncyBydGMNCj4gICBBUk06IGF0OTE6
IHBtOiB1c2UgcHJvcGVyIGNvbXBhdGlibGVzIGZvciBzYW05eDYwJ3MgcnRjIGFuZCBydHQNCj4g
ICBBUk06IGF0OTE6IHBtOiB1c2UgcHJvcGVyIGNvbXBhdGlibGVzIGZvciBzYW1hN2c1J3MgcnRj
IGFuZCBydHQNCj4gDQo+ICBhcmNoL2FybS9tYWNoLWF0OTEvcG0uYyB8IDEwICsrKysrLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0K
DQpBcHBsaWVkIHRvIGF0OTEtZml4ZXMsIHRoYW5rcyENCg==
