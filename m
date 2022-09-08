Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E775B201A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiIHOFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiIHOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:05:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44603ED7F;
        Thu,  8 Sep 2022 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662645899; x=1694181899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cs+IweJPQ8n+Ek1tHz6D3FxlLaS54to5SESt/Fl3Ulo=;
  b=KZXTeenzTKAmLe+rf8L1oVTY0pkYe2f7gMDIGDjcpzvfeB/reUsWjav3
   S/BY4eQ0mCQWmZGxMg2FrFLX5OTdNA6MEg9mTk7HEXIko6dV6LJTx2DeG
   tz0ncZNV3Y3JKF4ZwQH+2VObcaG+7r69jYX2QqwmufWv7srIN9h5R/zMm
   CdVDCOBJ3NCYj0CWnK4vmbLqTbKNJFVWdRSt729pahS6cFBMKMiohG0sU
   fWTUxNJg2X2qYQtcC9vjnCGZm0NDMZeK3mCzEDonjDtfgNZt56FG6Capn
   bJ0f6G2KaibY8UzbF2LVo/0EVVh6Ww4UT8Pq2xHYhT6WYQvWoYEaIgEVJ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="176227096"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 07:04:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 07:04:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 07:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKuiOE4yiByO7RFZ3fDuvcAF3Kn8fr2/mxEJA7B3zq6vOBcJDDs7qGL3s5zSLB9y4nMevmJ+3WdJVrG+sWrRJ1YSsNy7FpnMI+RYpvguGhuJWXOVsfveU+95KAKd5Zxo6O6F5mojHquHZWGvnRiMLFhjE8F5c26u5kBe6ndXAf1mkjWcK7BRKyfMJwkbJhMFc5cg6d5JfEFKzVrR/cKzcdYUl+ZOw+bz6WIs0BCKT/+teQ4qPItapiPfpmeuO/ttW05wrLRD2KH4E7llkg8A7r1lfVinTW7ZpAN/fFL0+Lg7Ts5i+zKKQj5Mb0nI4NCP793mN+VBDbQODwmsT/DDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs+IweJPQ8n+Ek1tHz6D3FxlLaS54to5SESt/Fl3Ulo=;
 b=f2b4FFSjhMq/HOk+toVI5l+PVINzDsQOO/vCqO5Dfthh0e3pFc46bALZYFDL5gWjSDKSERkYjrU1opOVb1eDL/Aaz9YNT8wli6xlbFKGV67+DacJ3Kdm2hboubhd9Kwwc+vLAsNH/BIDT0mv+lHuC2AXpiunRNGWobbw2SJqO2nfLFdJhFK4u08k5u7iXtnxxECJOOVXIbgbDyq78yRLdTRVq0g8UP9XELhFSkpq3Er6jUgu7IAeiRI6cjHcAwWuZIf3iqtBn84BdMo+Cdaj10HCRg4RbKrvZ95ZIUjTHcuqjmHaE7JkcUZdrTvsViHig87NVR1BO6GFOIqyUNS52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs+IweJPQ8n+Ek1tHz6D3FxlLaS54to5SESt/Fl3Ulo=;
 b=p284pCM7skYNCMKaQz0gz5avNpfKlXUL+LlcqCFdaBgoVXhz23FLLxKb/qH0ooGQgNCfknFBJ9f1rOn7HftEF3pfJlbbnoKAUpdA9kumv+3POuQK/KmSQL2kgcV4eo3Nsbo2p6V2WQH8DaP1xsduqdJJ3zVKrWtjuZNvysAj/3k=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 14:04:51 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 14:04:51 +0000
From:   <Conor.Dooley@microchip.com>
To:     <biju.das.jz@bp.renesas.com>, <atishp@atishpatra.org>,
        <palmer@dabbelt.com>, <guoheyi@linux.alibaba.com>,
        <guoren@linux.alibaba.com>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <atishp@rivosinc.com>, <apatel@ventanamicro.com>,
        <geert+renesas@glider.be>, <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prabhakar.csengg@gmail.com>
Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Topic: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Index: AQHYwdqljaYH7D6050aAz/t+qDALqK3SNfiAgAJOpACAAB1VgIAAlz4AgABEFACAAAUnAIAAEbiA
Date:   Thu, 8 Sep 2022 14:04:51 +0000
Message-ID: <02df5db7-99bc-5476-2530-4237c3904933@microchip.com>
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
 <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
 <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com>
 <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <5e894d87-8abb-540d-fbd6-8a1d6f9d0e91@microchip.com>
 <OS0PR01MB5922F6CC81114BCE7696BEDB86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922F6CC81114BCE7696BEDB86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|SA2PR11MB5002:EE_
x-ms-office365-filtering-correlation-id: 3fa75df4-8fa4-4231-d5b7-08da91a3193b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acBfem8em/nsY3jmflIO+yw2QEbnY7herK8+zmLFgeJ12d5f/f7PIoPbqLtTKWBPskmmGSd+r2zl/PTQVWZIZrW4BkKQgYKXtBaG9EbvGvADy4hN5IxpGpfJBnkUb/N56EFiDM064poFuEX1SY0Put9lk+DQfPMAokt4i5/x88Lh289SgnTpQO8H8YDBwZwbiZt40lLHG5NFxfctUHWuhJQRP+6r9W5uBsT7mjnHgnjiwaDypnLQYNWnTOhcBanHWO47qipmNWpqdwc6CECV7Mm4T60X6BC3rorbgManvdKMFnMFEchFrsxGRj9WkY/dWtZGzhI/xZbPNvMWqnTENmtauvo/allGaSOWeSzmchzAEPYtsSwWXs1icGXV33z02h59wD7hTvfmEORbE4nYTJ8yX6QuMtu3lI4DiDF6l1qUnpIaeWt+DJkQp9M7HYw1j0qJIFbqLB4IGK5P/41yGh6mC5c9ubXkqDnd+wYd981OoQdCZgIfL9WSp1/ZusmxJqZTq4bXKNwTnNBsAOR/7D3c6zUnDkjda9lAECEE+McsWsSwmlLQdryPA732nZKljMmuvjl/jJ/sY6CsB23EVr1L7mmGk6CnJphn4WS3S0T1V2jk556CfJPKqGDiEZ/vPjg8FswIiUmxwsb+GGhy1H0c0ViAi4V98sHrb6SWGAx31V5tlMxgZQFb2rYqliKQzix87W++cS5xxxAX5qH2Q2ggcaTJ3kM01sobGk1X40qlepH4MtZbSbz21qxVg8yenyWl9uSKlfs6qOOrxP64FUEivqv+AllAmpGMXi81jyCb2rL7ae+0I3rK7h2sfSIW4Y+n09rWlbmk2t9Ls3DiJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(366004)(396003)(376002)(86362001)(83380400001)(6506007)(8676002)(316002)(54906003)(110136005)(31696002)(38070700005)(508600001)(41300700001)(186003)(6486002)(2616005)(122000001)(26005)(6512007)(53546011)(31686004)(5660300002)(7416002)(36756003)(2906002)(71200400001)(38100700002)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(91956017)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SklnVW5oem9zdk8rNTZ2eUgvdWlJMXdtdk5YaDRUQU5HMGdrZXl3TzR4L0wz?=
 =?utf-8?B?YXRwZlJYS3lzOVdSaVFkUHFvWFZCRXVqL2cvK0RqSmNkT09MZkZ2dlVzK1I3?=
 =?utf-8?B?NzFLWE1zWnhWbitnRWdRUW52L1lka21mNHRqNXJuZW5qcGl6dk5BbEQreHJs?=
 =?utf-8?B?VkxkOHIyRnBDSGhBei9KM3hBQk9RWHdDL0VkNFZqaTJaU1lWanNJcXNTMHJD?=
 =?utf-8?B?S2h6ajVKY2tGM0c4OVl1cVFNT1ltZlJITDdhMHVZVnEvekNCa2VoNWpHemg3?=
 =?utf-8?B?T0xNZVZ4NklHcDJRQnhockVyZU9TVTlMU3RTRUJWQkpFQUNrM1VrclZJNnBX?=
 =?utf-8?B?VGVNbGVCa3d6UFY4S21RMnkzREtkeGl2b2swVi9pWlhWYTRXK2FyVlprcFpE?=
 =?utf-8?B?N3hQWG13YzdnZWZnMnVlT3ZiS1lvUHBzWEZtaVVGay9GUCtUMW4zTmxLb1Nt?=
 =?utf-8?B?SzVPSnE1UUNWaEVuOFZrMjhRUDFBa1hoVXBiRllSdFZFNWVLalJRZ1hkV0pw?=
 =?utf-8?B?ek9nQWpoajZ6akl1bHZVOVhzMXVmZ29jYVhmK1JLYkYxcHdJRFloM2NpTmc4?=
 =?utf-8?B?cGFrVjhISzBIZjRHMVlEanRjSm55KzMxR1hldzhYVGg2T1NKUmgyNjltNDd6?=
 =?utf-8?B?QkFnTnBDamdVNS9nN0hjVG1zNHhXR0kvR3JXUVNzQ2daMi96RjV3cEN2bE5G?=
 =?utf-8?B?eUxRUUVNYU1Lc3FqNUFPMVlDVjJPcmFrTWpWOUtoNmJtUUxQbXZSNFN0aXJ5?=
 =?utf-8?B?YlZrYjVjNzFPbnJoa2Z4TGZOQ0k2bVA1WThCQkZPTytnOS8zVjhqMEJ6b2hq?=
 =?utf-8?B?QWNzakYzaTRNRldEeUw5UjRoWjgvVDBJb1Nla1g0S0ovTlV0Rm5JWE1VLzFt?=
 =?utf-8?B?cnc3VHRWME5IZEJ2T1lWYUdwR1BDcFlkSEg3a0ZONzVQOG13MU8raHZBZHhQ?=
 =?utf-8?B?UjlTd2ZxOUJlK0RkZWM3ZlJCOEtoemdpdml0Vlp2d3hnSGdsUmRzSVhYcjNJ?=
 =?utf-8?B?ZGxYVWEwQ2RCQ1BlSmsvdEdQR2NDUktLL05YZG01a0c0Rkx1RnNuM1h1RUtY?=
 =?utf-8?B?bUJmR3VBNmtjdUM4SHcyTlExSjJRWldDNSt6d3ZwLzFvSjc3bWRtYnErNFNJ?=
 =?utf-8?B?R0V3VFhsSy9UYWhXQ2lKNUEyZm5hVXFCcExYSXJmcmRpbEZTa21kdGlFNERn?=
 =?utf-8?B?dEdmY1Fpd1F0YTJnZ25kSC9SK2hjelB6WFQ3TE1lNEVxSDgxSS9oamFBZk1G?=
 =?utf-8?B?ekFadnh0eS9rK1kxZ00vZmpROFFFZGpSQ1lSTTROOWc2bzRDUC9sNEwxVkhz?=
 =?utf-8?B?TDRiQnlVdHpETWRnMkN3dVprOUdDbDhKK0NhQUhlbHM4SWV4TnpQVzFjdXVC?=
 =?utf-8?B?L3ZFcXIvK1VySkYrOEhUWEhJeU02ZzFhZUNubCtRQ3pzdkdoTHV5Rmozczh6?=
 =?utf-8?B?a3paTlVSbGFTMjEvWnBNQWFTNUNqVzVrNGFuaXAzTElDTzU2UDlwRU5IcXlF?=
 =?utf-8?B?TllVQ3U2QUQvSXdKaXdZUCtoNHdTelFsUFlSb0ZPd2ZCMW13NWc0YTlySUw5?=
 =?utf-8?B?STkzWFpzV1VUd2dLRlhiWlRhdWg1bWVwaHFtRUdMWHg3UXRidzZJT0hPQUhs?=
 =?utf-8?B?YjVnSERQcEtTeC8yallzSFZrajlrN2VRcFB0RWxoWldKR0RPOGpNMzYrbmZV?=
 =?utf-8?B?Y09TSnFoV1J3Tmh0d0pLa1hvY0VXNHFYd0hCdmtvU3dXRlFzYzdqVzM0UERw?=
 =?utf-8?B?QTRYeUhtT256OTF2NlczVjcvdlNreS95ZmY4bWdnVWd4Q3pzQ0dhQUlZYlJS?=
 =?utf-8?B?RmtITEdITHpVdTJndEs5b0ZLVmxsTlZyL01acS9memhGaWlFSzVRc0loa3lF?=
 =?utf-8?B?YWwwU0F0eTJJQnhRZXJVa3FBbHZBVnFXeloxWUJHbkhMOUMwTU5qWnJGaHZT?=
 =?utf-8?B?TlFLMFJzSmxDeDV2R1NlVWRxTVVnaXNTb0EzTXFMMW40UXpaWDVxYktYVWRJ?=
 =?utf-8?B?cTdLSnF5bmsweG41ZzloT204SVhBRGw3ODFZdnUyVkFwVjVPVmxsTnd4b2hO?=
 =?utf-8?B?YUE2N1VKWGsvUWwrR2JvSE0rRm9hVm4zdkhxa2w5djJPTTBGMTMxSHlyZ3Zy?=
 =?utf-8?Q?CwczsT0fDw1w7xdUTB84lJcLU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEC670029B8AE64EA1DF3B84CEBC3B33@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa75df4-8fa4-4231-d5b7-08da91a3193b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 14:04:51.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFwPcWkjcYXUlRtDnrCAXR5eek2Wv06F9zvz44tgG82lnYWriCCxD1JLT8MqI6zw48R5R83sxYYc65y116hL+ncosBqHn7y8y6aGlY9IGIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDkvMjAyMiAxNDowMSwgQmlqdSBEYXMgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQ29ub3IsDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBm
ZWVkYmFjay4NCj4gDQo+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAxLzJdIHJpc2N2OiB2ZW5k
b3JzOiBhbmRlczogQWRkIHN1cHBvcnQgdG8NCj4+IGNvbmZpZ3VyZSB0aGUgUE1BIHJlZ2lvbnMN
Cj4+DQo+PiBPbiAwOC8wOS8yMDIyIDA5OjM5LCBCaWp1IERhcyB3cm90ZToNCj4+PiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93DQo+Pj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gSGkgQ29ub3IsIEF0aXNo
LA0KPj4+DQo+Pj4gV2hhdCBSSVNDLVYgZGV2aWNlcyB5b3UgaGF2ZT8NCj4+DQo+PiBBIGJ1bmNo
IDspDQo+Pg0KPj4gQSBfX2NvdXBsZV9fIFBvbGFyRmlyZSBTb0MgYm9hcmRzLCBIaUZpdmUgVW5s
ZWFzaGVkLCBEMSBOZXpoYSwgQ2FuYWFuDQo+PiBrMjEwIE1BSVggc29tZXRoaW5nICYgdGhlIFZp
c2lvbkZpdmUuDQo+IA0KPiBJZiBzdGFuZGFyZCBETUEgYXBpIHdvcmtzIHdpdGhvdXQgYW55IGlz
c3VlIG1lYW5zLCBvbiB0aGVzZSBwbGF0Zm9ybXMNCj4gSU8gQ29oZXJlbmNlIHBvcnQgaXMgZW5h
YmxlZCBpbiB0aGUgaGFyZHdhcmUuIFNvIGFsbCBwZXJpcGhlcmFscw0KPiBpbnZvbHZpbmcgRE1B
IHdvcmsgYXMgZXhwZWN0ZWQuDQo+IA0KPj4+IE91cnMgaXMgUklTQy1WIHVuaXByb2Nlc3NvciB3
aXRob3V0IElPIENvaGVyZW5jZSBQb3J0Lg0KPj4NCj4+IFdoYXQgZG9lcyAiSU8gQ29oZXJlbmNl
IFBvcnQiIG1lYW4/IFppY2JvKj8NCj4gDQo+IFRoZSBIVyB3aWxsIHByb3ZpZGUgY29oZXJlbmN5
IGJldHdlZW4gQ1BVIGFuZCBwZXJpcGhlcmFsLg0KPiANCj4gSWYgWmliY28qIGlzIHVuaXByb2Nl
c3NvciwgdGhlbiBoaWdobHkgaXQgbWF5IG5vdCBoYXZlIElPIGNvaGVyZW5jZQ0KPiBQb3J0IGVu
YWJsZWQgaW4gdGhlaXIgZGVzaWduLg0KDQpaaWNibyogYXJlIGNhY2hlIG1hbmFnZW1lbnQgZXh0
ZW5zaW9ucyBhcyBHZWVydCBwb2ludGVkIG91dC4NCg0KPiANCj4gR3VvLCBQbGVhc2UgY29uZmly
bS4NCj4gDQo+Pg0KPj4+IEN1cnJlbnRseSBVU0IsIGV0aGVybmV0LCBTREhJL2VNTUMgZG9lc24n
dCB3b3JrIHdpdGggc3RhbmRhcmQgRE1BDQo+Pj4gYXBpJ3MuDQo+Pg0KPj4gU291bmRzIHByZXR0
eSBzaW1pbGFyIHRvIHRoZSBEMSBzby4NCj4+DQo+Pj4gT24gUklTQy1WIHdvcmxkLCBob3cgZG8g
d2UgaGFuZGxlIERNQSBhcGkgZm9yIHVuaXByb2Nlc3NvciB3aXRob3V0IElPDQo+Pj4gQ29oZXJl
bmNlIFBvcnQ/DQo+Pg0KPj4gSWYgeW91IGRvIG1lYW4gWmljYm8qIHlvdSdyZSBpbnRvIGVycmF0
YSB0ZXJyaXRvcnkgdGhlcmUgJiBJIGRvbid0IGtub3cNCj4+IGlmIHRoYXQnbGwgYmUgYWNjZXB0
YWJsZSB1cHN0cmVhbSAtIG5vdCBmb3IgbWUgdG8gbWFrZSB0aGF0IGNhbGwuLi4NCj4gDQo+IEl0
IGlzIG5vdCBlcnJhdGEgZm9yIHN1cmUuIEl0IGlzIGEgSFcgZGVzaWduIHdoZXJlIHdlIGRvbid0
IGhhdmUNCj4gSU8gY2FjaGUgY29oZXJlbmN5IHBvcnQgZW5hYmxlZCBpbiB0aGUgSFcuIFNvIGxv
b2tzIGxpa2UgaXQgaXMgbm90DQo+IGFuIGV4dGVuc2lvbiBvciBlcnJhdGEgYnV0IGl0IGlzIGNv
cmUgc3R1ZmYuDQoNCklmIHlvdSBkbyBub24tY29oZXJlbnQgc3R1ZmYgdGhhdCBpcyBub3QgWmlj
Ym8qLCB0aGUgcHJlY2VkZW5jZSBzZXQgYnkNCnRoZSBEMSBpcyBlcnJhdGEuIEFzIEkgc2FpZCB0
byBQcmFiaGFrYXIgZWFybGllciwgZG8gYQ0KYGdpdCBncmVwICJFUlJBVEFfVEhFQUQqYC4gSSBh
bSBub3QgYSBtYWludGFpbmVyIHNvIEkgZG9uJ3Qga25vdyB0aGUNCiJydWxlcyIgYWJvdXQgZG9p
bmcgY2FjaGUgbWFuYWdlbWVudCB3aXRob3V0IHRoZSBkZWRpY2F0ZWQgZXh0ZW5zaW9ucw0KYXJl
Lg0KDQpIb3BlIHRoYXQgYXQgbGVhc3QgaGVscHMsDQpDb25vci4NCg0KDQo=
