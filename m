Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6FD58EB82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiHJLuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJLuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:50:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378BD5C9F0;
        Wed, 10 Aug 2022 04:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660132249; x=1691668249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8Idu/mce8Ovg4tNAqc4xG14Lg5IJRqeWZCwAErx/sGc=;
  b=1hl0LqWg/Yn3jL27yVAowKtIfd0o+YV7M9IRSik/NmJNBBaXP97CbX0g
   BX1oezZq0MBW0RTd/iasEDuJXUIgLs/svqlBiT1HEZ9xAwb7SU/OAG7Ni
   x0uxueVRrAasdRzkmAY5ms5E7fBRnGx90UrH6kDNmwVLvwruOWIt6S2qs
   /jFPidXPho4nh8NOhh2gkKDAqYPweTzR1/jFSa6S85QebDJHVtUIDG0dV
   yo0px84T7776Dni3zgM1Qbr2VMUlGqO47ZGPoR+SEnOTVgsAWpXd5vdrp
   pzRzG5P1iCutZPdefEKFdg2A2KARLn7y+dXkuva/NbTlhcXIcMVqvbC6I
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="108402689"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2022 04:50:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 10 Aug 2022 04:50:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 10 Aug 2022 04:50:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH+FEq5yMh2EANGw/O/ej7ApVz1HoxYa+csMRpypp0Qf477AyMaAi5yC/NR2rkT5YOiBbKjlDpnI4txl4EDo98dtl/fQNN3xdxXwQV08VWKtRmeOgG54Uu2OPgSGe43x27VTfCvBRTI4uqvjsQ1N18QLGs4Oiwk9Z34oLsUZDE+kw9PRaxnRasafCT7S1eKandkgx3NhALH/Oq5XmOOxYvmw/2wiRuN/ZtVtAUz4yKPavNTUaHLXoQbgCfAFPGRBmZZOP3xtja4kNIhXcawH/hQJihonnj7Q2f7xosVuFXv05+0qv+q+RtmF5sRLihpxREtwKYt1dPBuvf+3O7dyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Idu/mce8Ovg4tNAqc4xG14Lg5IJRqeWZCwAErx/sGc=;
 b=f7UKsO6aE5ghoV0KKhBjvHmGwhMlIgZbvqbNaeTLKjOWFIR9lvoaB/IrounNJZHZVWitXRlJRCzIftPu5Mm20sEyfMRS5WjHweFt82Orkxdgknu/5zHdc/i2FpPBelRKJtM65JT3WdYKApKIf7x6yE8e94mTXSHLKIrVIVtJkSc0bi6QqrOQwoZw+pMJZkcp5iJr8pDn1CksLlu8/qE8/OsOa8/Gjb1T5bnEY44yaHsZbSu21ACHmRVLv4B3lutrSOh30ybxfrTka/wdR6AD94Z+3YRg1IRrTrNxs1rDa0R2jPY4lRhhhb/wnLhpCzpwPRJ5UA7KAlr4sALk/Ic8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Idu/mce8Ovg4tNAqc4xG14Lg5IJRqeWZCwAErx/sGc=;
 b=k8yCCLCOQ+7jQWrk7o8Cuvx1FQkvf/Kqubvk8DbpZMx4UoynWvCiC1jqmsXOm2DPbsp98oMFfNOt9AG04ANYlQiFObcmXgXk5e/XcyZ44mH2D6pjUqlTvgJJytP1ZEgrtAF0b7ErjlojMOrs0iTfHo3dphlrE+oPKwYOZiKiVcU=
Received: from SN6PR11MB3264.namprd11.prod.outlook.com (2603:10b6:805:bd::16)
 by MN2PR11MB3583.namprd11.prod.outlook.com (2603:10b6:208:ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 11:50:43 +0000
Received: from SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::c9b4:8aa2:5c9e:ffc2]) by SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::c9b4:8aa2:5c9e:ffc2%7]) with mapi id 15.20.5482.015; Wed, 10 Aug 2022
 11:50:43 +0000
From:   <Daire.McNamara@microchip.com>
To:     <p.zabel@pengutronix.de>, <palmer@dabbelt.com>,
        <Conor.Dooley@microchip.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <paul.walmsley@sifive.com>, <linux-riscv@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Topic: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Index: AQHYj5/vOL2GhL7ldEmlpRxgi0llCK2oP5SA
Date:   Wed, 10 Aug 2022 11:50:43 +0000
Message-ID: <7d259ef8bfd7345906a6694bb5897bf2ada4acb2.camel@microchip.com>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
In-Reply-To: <20220704121558.2088698-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 113f0672-5615-4af7-96da-08da7ac68e2b
x-ms-traffictypediagnostic: MN2PR11MB3583:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pGWxlL6l9ilKienCuj3ZjwMxWHFNJ1/7vBCuDzyH+pkqz0mv9fnhEamDLL26E2QtgDx4/wnK3fPZPWPYVjt0IILzaTPz48UwMqquFIZLH4R1BWD7JIkDT9jfQerfR6joZEWtmfFwAcj0n0vlaS5XZr0ugBrCyOLxaYTJPtoHSBEGZW9U6cwOxvKq8NCUaRwShXdvWwU1CT75T3fM/BuJaANUqxV9MTaGH2r0WFXYrCjKPlfcD4Ltqy464gqxPRCldS9J5AxpG1Tz2psN+Y/S6fIBcfmxA2VvXSb+pawTPAiS+H+IZLVlSwX3JNIckXgx0KTiosUnSZdBY9+ujJX3w2pbqXOmV10+rwcf/iXfpM23rANDYXsAap86R1HOhgm8CaxjwhpULPAdIwLnQgpFQBKf2mFE6xfJ4/SL/AqgyY8FpmD9FclB6R55jdgHGN6Q5casmSdRiDR5WUc8WpWIZEPUpggZxhTLnEMX7b1oy12+bbEjDpSwBpRATVr960KJxCe2lMrPu1UITDeE7rZs0GEL/kRBJZ69C18T9xYZyX4i1Lsim1wUkuwkgPxjtJaZx4M/GkHq1Z4/KLESr00LS7fMaxqtiGGqtwaRca8jBT948Oi7GLW98za7hF806YRZPj4WaGAz3NYmVgRS2OzUYwOzK8k4Y/+VMgf6IGdSb5BagW9PGiXc3stkGUt7E/ezGZsAH8no3XTuKIHmXuH6hZxD8SJdgq5HMNaWp5jX/El/+wQxhnUbYAGBeMmZ30UhhKLlgul7u6EKMBN+SHX0ChXqmEgi7uJ+iDYcxGC2SlSRZiWmHSPUYLd5cKwW+iVz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3264.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(376002)(366004)(396003)(186003)(8936002)(41300700001)(122000001)(36756003)(71200400001)(2616005)(83380400001)(66556008)(66946007)(7416002)(66476007)(64756008)(66446008)(26005)(38100700002)(5660300002)(54906003)(6486002)(38070700005)(91956017)(966005)(316002)(8676002)(4326008)(76116006)(6506007)(2906002)(86362001)(110136005)(478600001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlovS2JwMVRoRlBqTVhLMXJMRWtaSExpa3pidkk2WFJ3dkNDdzVNRVQwc0sw?=
 =?utf-8?B?eHJ1UWxCdlNrLzhoQk9KTHRWam13aGZhTGk4dXEzSmFHTjBSZ1VjSU9uNHJH?=
 =?utf-8?B?S3l4M01LOS9XVUJNNTNvb1NvUW5vVzFJZXNJSDU0OVFSdHh3VWlKZzRHU0Yw?=
 =?utf-8?B?WHdUOW56dkhjZVF0OWJkUVozY2xqbjZjWnR1Slpvd2hXdlA1akZoVEpGQnhr?=
 =?utf-8?B?WVZ6aFhFd044Q1NYOVlGNk0rVHlGRFZiRjFyZHk3ZkxpOXM0NFd0TExGTTFu?=
 =?utf-8?B?K0lPUnBUcWE4dUVCWlRzZ0ZCOEFQVDJhQ1Z2UkpCZHQ1Tzg1b1FMWHg2S3Bw?=
 =?utf-8?B?Z0ZlbWs5VjBMWEtQVlg5a1lWUG9JOFh4eEJiUXU1WHk2Y3dmM3JOaHdNRlZa?=
 =?utf-8?B?RExYNVJUN0FXck01a21JZDZVcm05bitBYXZzd3JLOVQyRkoyLzFLWnl1NjRX?=
 =?utf-8?B?RkZJQjlqRmhYWnFMcjdIUkQ5SzlwaG1GaU1ISXc4ZjJZYzFMMXlMaGhzREVW?=
 =?utf-8?B?c2diaU1lTXpWa0lyZG95SUxTTFlQKzJzZTRzMElPODNTTDVsNEs5RkxTdTJZ?=
 =?utf-8?B?SXAvMldVWVpXNE1nNFlPWXVja3FjMWZsM2U4L2ZhMmdudVpWRU8yY3RvN0dN?=
 =?utf-8?B?MGZuRFo5c2tqYU91aGhGeWhlL2paNysvRmNTTnBVWGs0RHFBNitUS2xDcmNE?=
 =?utf-8?B?NWI1czJMOW5JbFlLS29pTkF1aGttUVpOOHVQbnBHVHhaU0RSd3VUdmtNOTZX?=
 =?utf-8?B?RjBkbk1QMEUwa3p5azNwcVVPMEVYbUtLMlR2d05BL3liQjlJN095V1NobmNS?=
 =?utf-8?B?V2Y4TmFFOGFMaWZUUUgzVlVtT2RYMGFISzMxMGczcG1Vcm52UWFWLzhaTUN1?=
 =?utf-8?B?Q2I5NUQ4eW45czluekt4UlZ3OFBrYmcrckJxMExHaXo1enJhWVJiRDVaZlNn?=
 =?utf-8?B?bHVSWHNkOWdEcFlrUHJFZERneDk3UXB4aGgxU2Vmb3ZZZ2RwRlUwZ25odThs?=
 =?utf-8?B?MmUrRFFlbkF0a1VmUCsxcng0VnVEeHVoVkI0SUlpV0tXaG9pR0NFeCsya2Vs?=
 =?utf-8?B?dEtkOGRxYlBmV1R0UVk0Q1N1c2lNVGduZzJualRORFhvSUkvSVdsSWo4VmRG?=
 =?utf-8?B?YWhqSFJPWU4rcFErR2FNcGg0bzl5ZjV4UmRoNVd4OWUxVm9tRjhnbW5FRTRq?=
 =?utf-8?B?RjJRQUNoTm9PNzFoWm11MVZXa3VSYzkxUnpjN1plQ2JwYUpNbi9jVXNRbmdS?=
 =?utf-8?B?NzV6RVFVTUVkaDJraGR5QjJ4MDB5N0JYMXZob1pqaXcvaUE3MDVsQU9yUDJ6?=
 =?utf-8?B?RTdEaXlaTFErOEZsWjRmMnNPM2xHZm1zVC9CYmFSN0tjUGsvRVJhTXl6K0ov?=
 =?utf-8?B?b0RvbExmR1BUSEF1bDRFdzhzTEU1c2VMSzBsWXI5M1V4RjJYRHd1dlVuWUJi?=
 =?utf-8?B?RXAzZzIrRTFoZVVZTTkyTFBUSHZvazJOT01YcklnZkVWOWZJSjdEMVEwV05v?=
 =?utf-8?B?dDBJSVROWmFCbEVlSnNycGlRMG4zQmcwR3pSRFNsbmdCcVUvTjNQanJCV2NF?=
 =?utf-8?B?ZkV0bnpxMlA3UkUvZUxHa0lScjVNYUhXVGNQMjVSc3BKY3U0bmFyWXBWWVNZ?=
 =?utf-8?B?SnYwUHZ6WEhPeHVRS1hwc1dlUENiZEtMcGt0SXB3aFNGNmRKRHJseUZ3bSsr?=
 =?utf-8?B?R3ArdElub2ZVZEZrak52TW9tUkFEcHNleFpaZFFTZjZMVVIxMVJqNWtNcVhv?=
 =?utf-8?B?bFZ4Y01nZGRadmxRUTBNNldNbnZSMCtWd1RBMHJOS252Q3dXa1U2c3ZFOHVt?=
 =?utf-8?B?VWs1SVdubHJ1amhyUWVGdFhYM0hyYmorQ24yS1VKa2lPbFpiV1hsQzhsS3c1?=
 =?utf-8?B?b3VwQXlhQ2Z2ejV3bzh6ZUF0SjVORjJiN0haVlFDenVsdU0zQWZZaHB3Y3RF?=
 =?utf-8?B?Rjhocm5YQlVYUStOZ0pEM3g2c2VEeDFRZFhyYk1KRThUa1VqZWx0TEZxZGlv?=
 =?utf-8?B?SW5mWjJza1JNbVJBcWxpWVdyek9IbDFBUmNxSTROS3IwSjFNN1ZwZGNvQm1n?=
 =?utf-8?B?ZHhZSGlzUEdIc0dZRVFCVEVHYkdBZnhkTDZHeEd0NHh2Um1rSm1qSlVnWUx6?=
 =?utf-8?B?T2RQYys0NjRwRzdIRkl2Y2NlNTVGTFEvZGdLUmM5YzZFWFpQNFRhWVF3QkJE?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA9A43233831D64B941B62B3276A79B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3264.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113f0672-5615-4af7-96da-08da7ac68e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 11:50:43.3524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPpT4eIivm9Fop9FNLxqLbmXVDMavEe9o4B/Xc2t/6Snqc+fUOaCJRMdlXAWAIB1lQjKArdOD3tC5F3SfD4o6+cVv2sZkHvHlWi7pJdt2c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3583
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29t
Pg0KDQpPbiBNb24sIDIwMjItMDctMDQgYXQgMTM6MTUgKzAxMDAsIENvbm9yIERvb2xleSB3cm90
ZToNCj4gSGV5IGFsbCwNCj4gSSBrbm93IEkgaGF2ZSBub3Qgc2F0IG9uIHRoZSBSRkMgSSBzZW50
IGFib3V0IHRoZSBhdXguIGJ1cyBwYXJ0cw0KPiBmb3IgdG9vIGxvbmcsIGJ1dCBmaWd1cmVkIEkn
ZCBqdXN0IHNlbmQgdGhlIHdob2xlIHRoaW5nIGFueXdheSB0byBhbGwNCj4gbGlzdHMgZXRjLg0K
PiANCj4gS2luZGEgdHdvIHRoaW5ncyBoYXBwZW5pbmcgaW4gdGhpcyBzZXJpZXMsIGJ1dCBJIHNl
bnQgaXQgdG9nZXRoZXIgdG8NCj4gZW5zdXJlIHRoZSBzZWNvbmQgcGFydCB3b3VsZCBhcHBseSBj
b3JyZWN0bHkuDQo+IA0KPiBUaGUgZmlyc3QgaXMgdGhlIHJlc2V0IGNvbnRyb2xsZXIgdGhhdCBJ
IHByb21pc2VkIGFmdGVyIGRpc2NvdmVyaW5nDQo+IHRoZQ0KPiBpc3N1ZSB0cmlnZ2VyZWQgYnkg
Q09ORklHX1BNICYgdGhlIHBoeSBub3QgY29taW5nIHVwIGNvcnJlY3RseS4gSQ0KPiBoYXZlDQo+
IG5vdyByZW1vdmVkIGFsbCB0aGUgbWVzc2luZyB3aXRoIHJlc2V0cyBmcm9tIGNsb2NrIGVuYWJs
ZS9kaXNhYmxlDQo+IGZ1bmN0aW9ucyAmIG5vdyB1c2UgdGhlIGF1eCBidXMgdG8gc2V0IHVwIGEg
cmVzZXQgY29udHJvbGxlciBkcml2ZXIuDQo+IFNpbmNlIEkgbmVlZGVkIHNvbWV0aGluZyB0byB0
ZXN0IGl0LCBJIGhvb2tlZCB1cCB0aGUgcmVzZXQgZm9yIHRoZQ0KPiBDYWRlbmNlIE1BQ0Igb24g
UG9sYXJGaXJlIFNvQy4gVGhpcyBoYXMgYmVlbiBzcGxpdCBpbnRvIGEgc2Vjb25kDQo+IHNlcmll
cw0KPiBmb3IgdjI6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDcwNDExNDUx
MS4xODkyMzMyLTEtY29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20vDQo+IA0KPiBUaGUgc2Vjb25k
IHBhcnQgYWRkcyByYXRlIGNvbnRyb2wgZm9yIHRoZSBNU1MgUExMIGNsb2NrLCBmb2xsb3dlZCBi
eQ0KPiBzb21lIHNpbXBsaWZpY2F0aW9ucyB0byB0aGUgZHJpdmVyICYgY29udmVyc2lvbnMgb2Yg
c29tZSBjdXN0b20NCj4gc3RydWN0cw0KPiB0byB0aGUgY29ycmVzcG9uZGluZyBzdHJ1Y3RzIGlu
IHRoZSBmcmFtZXdvcmsuDQo+IA0KPiBUaGFua3MsDQo+IENvbm9yLg0KPiANCj4gQ2hhbmdlcyBz
aW5jZSB2MToNCj4gLSBzcGxpdCBvZmYgdGhlIG5ldCBwYXRjaGVzDQo+IC0gY2xrOiBhY3R1YWxs
eSBwYXNzIHRoZSBzcGlubG9jayB0byB0aGUgY29udmVydGVkIGRpdmlkZXJzICYgZ2F0ZXMNCj4g
LSByZXNldDogYWRkZWQgYSBzcGlubG9jayBhcm91bmQgUk1XIGFjY2VzcyB0byByZWdpc3RlcnMN
Cj4gLSByZXNldDogc3dpdGNoZWQgdG8gQklUKGkpIG1hY3Jvcw0KPiAtIHJlc2V0OiB1c2VkIGxv
Y2FsIGNvcGllcyBvZiBzb21lIHZhcmlhYmxlcyBhcyBwb2ludGVkIG91dCBieQ0KPiBQaGlsaXBw
DQo+IC0gcmVzZXQ6IGRyb3BwZWQgdGhlIHN1Y2Nlc3MgcHJpbnRvdXQNCj4gDQo+IENvbm9yIERv
b2xleSAoMTIpOg0KPiAgIGR0LWJpbmRpbmdzOiBjbGs6IG1pY3JvY2hpcDogbXBmczogYWRkIHJl
c2V0IGNvbnRyb2xsZXIgc3VwcG9ydA0KPiAgIGNsazogbWljcm9jaGlwOiBtcGZzOiBhZGQgcmVz
ZXQgY29udHJvbGxlcg0KPiAgIHJlc2V0OiBhZGQgcG9sYXJmaXJlIHNvYyByZXNldCBzdXBwb3J0
DQo+ICAgTUFJTlRBSU5FUlM6IGFkZCBwb2xhcmZpcmUgc29jIHJlc2V0IGNvbnRyb2xsZXINCj4g
ICByaXNjdjogZHRzOiBtaWNyb2NoaXA6IGFkZCBtcGZzIHNwZWNpZmljIG1hY2IgcmVzZXQgc3Vw
cG9ydA0KPiAgIGNsazogbWljcm9jaGlwOiBtcGZzOiBhZGQgbW9kdWxlX2F1dGhvcnMgZW50cmll
cw0KPiAgIGNsazogbWljcm9jaGlwOiBtcGZzOiBhZGQgTVNTIHBsbCdzIHNldCAmIHJvdW5kIHJh
dGUNCj4gICBjbGs6IG1pY3JvY2hpcDogbXBmczogbW92ZSBpZCAmIG9mZnNldCBvdXQgb2YgY2xv
Y2sgc3RydWN0cw0KPiAgIGNsazogbWljcm9jaGlwOiBtcGZzOiBzaW1wbGlmeSBjb250cm9sIHJl
ZyBhY2Nlc3MNCj4gICBjbGs6IG1pY3JvY2hpcDogbXBmczogZGVsZXRlIDIgbGluZSBtcGZzX2Ns
a19yZWdpc3Rlcl9mb28oKQ0KPiAgIGNsazogbWljcm9jaGlwOiBtcGZzOiBjb252ZXJ0IGNmZ19j
bGsgdG8gY2xrX2RpdmlkZXINCj4gICBjbGs6IG1pY3JvY2hpcDogbXBmczogY29udmVydCBwZXJp
cGhfY2xrIHRvIGNsa19nYXRlDQo+IA0KPiAgLi4uL2JpbmRpbmdzL2Nsb2NrL21pY3JvY2hpcCxt
cGZzLnlhbWwgICAgICAgIHwgIDE3ICstDQo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2No
aXAvbXBmcy5kdHNpICAgICAgIHwgICA3ICstDQo+ICBkcml2ZXJzL2Nsay9taWNyb2NoaXAvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9jbGsvbWljcm9jaGlwL2Ns
ay1tcGZzLmMgICAgICAgICAgICAgIHwgMzc5ICsrKysrKysrKy0tLS0tLS0NCj4gLS0NCj4gIGRy
aXZlcnMvcmVzZXQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArDQo+ICBk
cml2ZXJzL3Jlc2V0L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4g
IGRyaXZlcnMvcmVzZXQvcmVzZXQtbXBmcy5jICAgICAgICAgICAgICAgICAgICB8IDE1NyArKysr
KysrKw0KPiAgaW5jbHVkZS9zb2MvbWljcm9jaGlwL21wZnMuaCAgICAgICAgICAgICAgICAgIHwg
ICA4ICsNCj4gIDkgZmlsZXMgY2hhbmdlZCwgMzg2IGluc2VydGlvbnMoKyksIDE5MyBkZWxldGlv
bnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Jlc2V0L3Jlc2V0LW1wZnMuYw0K
PiANCj4gDQo+IGJhc2UtY29tbWl0OiBiMTNiYWNjYzM4NTBjYThiOGNjY2JmOGVkOTkxMmRiYWEw
ZmRmN2YzDQo=
