Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995845A5BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiH3GXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3GXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:23:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEFB7963B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661840590; x=1693376590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oMWfKkuGFtyMXWM0ppj8xs3NB80avGY1sqXgraJwtR0=;
  b=oj0zcJo8y+X+0GBkZC6Oq+DQQcCKYebf1lDofuPm0ZSMPvQR9qkteRhz
   3Ag8QiKxk9f9+HZ12MKmf7rTl78+JUK/kuW+qTWD0PkwYu8SdrB40zVlO
   lorPFFLUKd/68dZLGxHbLK8vboHgoVh3yDWl1dJ1eFfqaYXQWqyMvutwC
   DBS7/6IGeAA74ExWBfxrGX3x6a4Xrh8vsLm/UzZ3rwRhJQ1jPFlNBPeBV
   HZrjLkRJRFlKtnDmPCOqS3/IMOfzSAN2SeF0AxROxfII1G8T0Or7PZ2Kr
   CDd/GowJoh7PpX3X3Ffukls3nLiINr76Pn7wr2y6v1Y6zmdIYgdmNT5Zr
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="174754181"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2022 23:23:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 29 Aug 2022 23:23:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 29 Aug 2022 23:23:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNFgGWNiVKzFLoKfBmbKENbOgb4R2mbld9GAiQFyuhF8jbTW2t61H5ZQhXaVi3AXgM0zsELGqwzHu5h8tNobkLKf0kfgX5flScRuuT5pcWgN7xsLuMdbG7oHTod/GBCujvgs5NNyOCQhm2QCVD04jwzBkjOnWrGGJbIyVtslKY6BASPH7UXyi9eBKGx0t4bGurJFAhsUKtD6paalioCklNAIKu/pzZE2A27U7wyEzxZCiOiwcV6Z4dvVPb6E61J8atQUrfzqq1I0Xto3FKLCUkh9zvnTnkQ4AVnT4Rj7QiWUz6A2lFlKIsmTMNaLatUbwaaxClhDj76pDs02VDJK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMWfKkuGFtyMXWM0ppj8xs3NB80avGY1sqXgraJwtR0=;
 b=mIxoxKFPSt8R2ql6FwI0YI8q87YrnPmt/qIZP5XuaRj47sszpvfNJxS8qs7VoZEVef5KhEd5+fLLveOABu2dw6gayWfWXRZTzAB6un9lptrzRvmNr78YIvHIKG5lZ+beo0HZNHzV01d3vALwtfylzJPeedS5EHbKusDvCxh2c85OHs0TsteevkLCwVx8GBgKUraScxz9qKWlA+FPRAFigQ7skJpYJWsXXSyvIBm6Zu5hJD6njAV5WHcEPN/19QNz3sTDJAang7Pt2aZW2Kskslo1C3bmlKr1YeEZO5cvbT6Xy/yXos1Ne5+SIQ1ead4BKuE9ulQHV+yCUAnYyh6BXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMWfKkuGFtyMXWM0ppj8xs3NB80avGY1sqXgraJwtR0=;
 b=E/ETQHQuRH763H0Xf1qSgnK4cNUEoacpb4qBzSrB32RytVUdQPvOG1Ie/b9cXXbQtTCBuDt6d1RQD+MuBgLDe70e/seGTrwplK5iYxMcKVVqUmL2O+eJMDH+jUDbLMCBoEQaByuGC0wDTVnVrfhqU8De72TM/4YKH8vdHsbg7nI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB3663.namprd11.prod.outlook.com (2603:10b6:208:f5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 06:23:03 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 06:23:03 +0000
From:   <Conor.Dooley@microchip.com>
To:     <apatel@ventanamicro.com>
CC:     <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <atishp@atishpatra.org>, <heiko@sntech.de>, <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add PMEM support for RISC-V
Thread-Topic: [PATCH 0/4] Add PMEM support for RISC-V
Thread-Index: AQHYu6ZO+JUY+heYt0OoC/OUwNufja3GJbOAgAC5BICAABvTAA==
Date:   Tue, 30 Aug 2022 06:23:03 +0000
Message-ID: <7227f283-4644-b226-e875-23de8da86e1e@microchip.com>
References: <20220829125226.511564-1-apatel@ventanamicro.com>
 <f4b2daab-72f6-ab5a-5743-b41bd5e2c920@microchip.com>
 <CAK9=C2UOGR2VQao8CCJ82mRP4kL_1V=8uXyKj_vnOXW7a=Kt8A@mail.gmail.com>
In-Reply-To: <CAK9=C2UOGR2VQao8CCJ82mRP4kL_1V=8uXyKj_vnOXW7a=Kt8A@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de4b2bf3-259a-46a1-ed9e-08da8a50183a
x-ms-traffictypediagnostic: MN2PR11MB3663:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKGGvYaFM5U7sgYCyDDk+LUZvxsUH3qrYRdLBPUWjcR+DHkAqmA4efmkK86d0aRwpGp3cMzZbu792soCh0GWns5qB2uTXhGqOfiD3G4E3x9hWCUzw02nKvP0uWtdAQeJdPFS7/39py0lihNpHKtffxAhwAYFa4ItGpFOmnr+d2FWtLVXR/jqo7g9EjGwF0/vc+74skmn7rhbwfutrrt8OF2Qb1zBCWEd+GMB0M9tYaraRXpJoAaxvZnhshNveLbgbpLBudlHWYjlMD7bRI6A6hFkuqM5Wp4rjUgSU6nWzAN6aMd6rK/jIHC7sfGXTtVrYebDFIb39Eha7nQerW8AsLkVJx9HFrFqu6bpcW+XKTkZkhTNl1Ak2ulCWUQ3Vl2y5XxCslUYgRdpZA8iQGvAOITt1GDFU7j0rdl0mUviR9uedFX5vPANCVnOPdbh4YekuA2KidEWrbnxTLJEfSiwHc3uVtE3+q1CVGsAEkdN9B6zAzHjo3EYyUZIEIdK7dx/nmNmHSOGo41vdTGnmr9QxFOt6VhU0Je5LRP2Gwr6sFhKuAMaUa0Pht9OlfQz5vamjCXWOdZ38LIycm5WCdtKFwvBcDnWAKYiGYRS78eqdHg/oK8GSpTGdwI31VpsnVyxpGJdO2fIRsf3vFNxkMwJ2XAZctaIQ3IXzCQnM8tMZl2UXQXV1uEfeGxSHxD3epAMNoUGJFRxItRuyti0BtfCGlkXLbQ8Y2DUnnrFGucAJRqL6+IPbtF9TWCEhxMGmOFL0NTfNCUOd7EM6trSs+t+ArpNwekzwu6rcNpsAHX38HpFqLGF1pcghdqvs7lwu52wT7VzbGrXIGvDmpCz8a+rCuHlnJeja1ktXnpm8IB5Kbg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(39860400002)(366004)(346002)(91956017)(966005)(316002)(6916009)(54906003)(66476007)(86362001)(66556008)(6486002)(8676002)(76116006)(31686004)(4326008)(66946007)(31696002)(66446008)(71200400001)(64756008)(5660300002)(478600001)(36756003)(38070700005)(41300700001)(8936002)(4744005)(2616005)(122000001)(26005)(6506007)(2906002)(38100700002)(53546011)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlhLNk5vZU1BdENYdEtRTkZ0RHJFbnRNNE1CV1gxSFNselEzY1V3T3FRdXk5?=
 =?utf-8?B?cTIyVFJiTE9iRHpxTUcrVm4yWGJDVUg3bmVEYzFsbk1EYURwYk8xRUdYeVJ1?=
 =?utf-8?B?OXZUNU1BdVlNZVBTVGFQdlBtVkUwL05EbGJsc2NNdTIybzhCYytmZklPRTFz?=
 =?utf-8?B?V0hnTVQxZU9YSGlycmsyZ2hiY1VMQzlXamsydWR1RmtLZXRsVm1CT0VRcSsw?=
 =?utf-8?B?N3pXZnFyMy9GMDZQenNYVFJaYkk0aTN4T2pneEVndVFBdHYxcWloNmZ3RkJH?=
 =?utf-8?B?d01scTROYzZxeldVYnNZNkF6cmxQcXRwK1JlcFlmVVdPNnBCUSs1UWt4Vkh2?=
 =?utf-8?B?SEU5ZDVuY1dCb0JiVFFHc2hwSzE2c0hNM1loY1ZwWHk1QjA5MTZISzNPc1NB?=
 =?utf-8?B?Y2lJZlZFMHpHaUF5ZmJER2VRTGpHTFlZeExtRm0zaEsxdERNVkNvTFY4WjFx?=
 =?utf-8?B?NlhuTWNrZ2lTMzA4NDVnYSs3WlAwYU9HMWRkd0ppOEdXcFdabVFMNSt6TzB4?=
 =?utf-8?B?SEE3Y3FjbGNpNmRBLzBwNnBUY3ROQXVPQVVBajBOK29lRXlqcjhqSXg0c1N4?=
 =?utf-8?B?dGxwTXE0RllhdEZkZDZxOEcwTkhYd3FibmROcnl5Nng1S1hCNGV5UXY0RXMx?=
 =?utf-8?B?OEhhMUhPOWxxazlxaWZUU2Y5bDkyVlMxN0o0VThTN3djd3VabnVEbEo2UmJT?=
 =?utf-8?B?cHdLdVAvQVZBcjV0U3UxeGIyZUt5QkJSQkdRNnNoWmgwcUdKSTNmL3VFd052?=
 =?utf-8?B?R29VdS96bWhnbVF3SHJHckNZUlJEdEtpMzNZbTlQTllWWmlvQnZtcjZqanJJ?=
 =?utf-8?B?NzQ2UFA0THcvekxZbW9IdkJCdkMwR3FNbDM1M0NjV0t0bGpEZkVGVnA1b2NS?=
 =?utf-8?B?TWpPdXdNcUNTZ1hGRHo3dkJCVE5PT2srMlRBUisrNDZDQVlvU1YrQkhLVjJP?=
 =?utf-8?B?ODVWeitRMW5ZWTBPSEJCZ0g5c05yRklZbUErazBEMXdKZHdBWjdBcHF4QTFh?=
 =?utf-8?B?Y2F4bFdURHdCWG9reGxHcGk5bCtDWkE1enUrVFhhekZZaGxnMWxSRENYYWdP?=
 =?utf-8?B?Qk5yNUxjZ3VFM1JZQlRqV1h3K3hlTGo1NnZncE1JRk9xVE5UdDN4VTBzRmZH?=
 =?utf-8?B?NEMwemlic1J1ZnF0UkwwVTRzdHNPc2hKYlhOVkhxOVFUOFZlTVhTTElKbEd6?=
 =?utf-8?B?WmVnQ2lRalRmM0ExMDlRMUU2T2FVaTU2ZXZlcldVQVNwajYyVjZlWjdMdEpl?=
 =?utf-8?B?cGR0eEZVOXZXRkY4bnM3SzQ5a0JOWm55azYrVWxEZHVnY3pvd05BVk44emdH?=
 =?utf-8?B?MFhHVWQxZEgwN1NWak9ZRHJKdGlPemRmTG5TYUdSOTJyTm9pb2dSN1o3b0g5?=
 =?utf-8?B?NTdlSDc3bS9tWFMzQWI2Yzk3a0R6clFRbHJNZFhuVVVKaE96R3dJaEFyUjg2?=
 =?utf-8?B?RFBXWCtwa09aM0p4S2JHeTE4aTVPSTZ0ZmQxc0FmYUMwOWcrWElkOUcwdnkv?=
 =?utf-8?B?SDUrZHZzZGdkOUI5TUhyUy9TVkszYmcvQk90VWFPb0U2TjNlT2RUbVZsbUVL?=
 =?utf-8?B?V3RWY1pEYlFZZTN6b3M0cnhSa1NzTFcwdktIRU15Y2hjNHdtU1Y4Y3Jhb0tq?=
 =?utf-8?B?bnBYZWZreEdxQTgvUHRkM2dxdzZ4ckFlOWNNRFlqeWY4c1BENE5hTFR3dThq?=
 =?utf-8?B?cmhTNmQvR3lDcVhMSDhub250SWpia1g4Q3oyT0paSjBDaXFMNDhxSmNiVGw2?=
 =?utf-8?B?YVAvdnRHdjdBaEt5RnV0U3FrNDM0OGIxUGVCV2hWTTFmSkdNREJ4d0o3YVFH?=
 =?utf-8?B?L0cxMFd3ZCsrT0FoNldvRDRUNkhOYkIwSjBvVVlpVFdFUVRkOXBON2dnUzFB?=
 =?utf-8?B?dERQNGptalFmK0lZZ1VPak84OFRnYldTb0lZaFQydnNoUE1wVkkvaVNzVDdZ?=
 =?utf-8?B?MktJU0YzckY1Rys3bzZ2bUNWb1pTZllDN21KcXRWVkt0SnI1VUFjbGRteHBV?=
 =?utf-8?B?aEtYcEQwYjB5R2tWUTBvNEFLNVM1ZEpXOFBkUjBKUG5nbkRmYWtSQmdOWnNJ?=
 =?utf-8?B?cVlpZDJva3pYbXJlWUdWdG1rclhDdSsxMmEzL3FZMXRLVGdrMmNHaWdyRzU4?=
 =?utf-8?Q?sbeizgDTpjJ9LNg46eaxGb3hW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3468389B9BB46E4799BF1A70F097E4BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4b2bf3-259a-46a1-ed9e-08da8a50183a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 06:23:03.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpDwhvvxq9A76UX9e4LleLr4ARX0JTRnxy/7MTeG5+y8L/+I09GCuZDdEH499Gfby9DCIy8LBKWhui4sf63fLubSzM/Qt0yfQEVO9RX8M7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3663
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAwNTo0MywgQW51cCBQYXRlbCB3cm90ZToNCj4gT24gTW9uLCBBdWcgMjks
IDIwMjIgYXQgMTE6MTEgUE0gPENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+
IExLUCBhbHJlYWR5IGNvbXBsYWluZWQgYWJvdXQgdGhpcyBwcmlvciB0byB5b3UgcG9zdGluZyAm
IGFzIGl0IGhhcw0KPj4gYWxsIHRoZSByZXBybyBuZWVkZWQsIHRoZXJlJ3Mgbm90IG11Y2ggcG9p
bnQgaW4gbWUgc2hhcmluZyBteSBjb25maWcNCj4+IGV0YzoNCj4+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDIyMDgyNzIwMjguSXdyTlowVXItbGtwQGludGVsLmNvbS8NCj4gDQo+IFN0
cmFuZ2UsIEkgbmV2ZXIgZ290IHRoaXMgZW1haWwuDQoNCkdvb2Qgb2xlIGNvcnBvcmF0ZSBmaXJl
d2FsbCBtYXliZS4uDQoNCg==
