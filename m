Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751424C16AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbiBWPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiBWPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:25:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CBB46167;
        Wed, 23 Feb 2022 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645629908; x=1677165908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=efD1yI0mnd3YJlske2NZB8MKGnJ54CLYsHlCQeCtVdU=;
  b=tsmWvKxGwiv1gN2gb+NacgBWbpHQVFBOEqyk6TMicrhE2g8VpZeX6XpO
   Wr8uzsmeWk6Sv+0Flftysn6/WlIVz9J6XPMROqU1VjcbC1aXPloi1hOwx
   7Alt7y+Sg/JRCY2VeLacpxx35kTpa8tPz9Y2IRDGZ7qO62VEBz+QADRvx
   7y7MwAkrxqAA8l5aivN3uRarKZ3yHQ33511eNTq3fWT/nTTvbKe1hlPYE
   woyXMaGgy7k09avZvH3pLTGIIwfzNyR2U4lIzeWR3UyVY74Bm9/y4IJKK
   b+a1uw7G8DOpOpynpz7rNgoPtXdSgmX/21tWNOZ+vAI3anxZA2HcDrRvE
   A==;
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="149741061"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2022 08:25:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 23 Feb 2022 08:25:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 23 Feb 2022 08:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LY8kr+j1yZ68C3WCJLO99UXXJOdVDKJKp1U9VFWKW/nnIOGJ1AFZc7HWzdGGa/iIWJqTNN2N58yo9yUgUfvdbdkhlfs+r2XCY8rQWU3Q9WqbzzSIaNh+3StVhVx2x9NWS8h0OXOWWHbx2NfYRfBdja0XEQtzq4cLHUhNf0H3cvQzRq4QJExeXGvXFEZoEgKWRwm5876edIw8eIoiHxkrxlOTZdj3jwu4OZ7JLW3RBgXnyd+bBeXgi8lRkR7lQnwq6R4rQcafYSbW9WRPNaBMyXoC98HgFaT6PMLFrwVNbV+Woqkl0olT5JhYeeSjLjQ69Pzqw0eK6x4lkcFfKYIeqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efD1yI0mnd3YJlske2NZB8MKGnJ54CLYsHlCQeCtVdU=;
 b=PM0VTiP1+PNn1PiY/HMShkKUT762dWxDyYQFhRkVQsUYLI15CqG5mMw1ufju/WCGgzze0Usd+gLy9K2NLRVLrq0Lhbp9AnOySg8Vr72WpG5d4DDtbxXI+as6hdAOHtFo4sbVwGnDTgzSPu4AK8XY8m+tEQEAnc+cPZBszScZZ2RUA7ZwhiYn7+ms5TSM7T5hzdqWc3PVZJJW/TICUUczvdPqZIMS91nRKZM7dhioh1J/cDW4E8Z9N8SK8eXpPajaqdmdRscFRFrTK7Qx6Q+mqT8JN9lWFkjcUcjVeE3aIkDdvHCP5iuKWoYxfnIhVHfoIJ0bcQhp3nqljqBqQZskQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efD1yI0mnd3YJlske2NZB8MKGnJ54CLYsHlCQeCtVdU=;
 b=fXMCYktQXkRT2RdS1iJ4RVjScAGV67+V2furn9cvZxHk2QVfkR7+3Oyoz2DLZi5PKn6J+U4VJXKf6s7F6urQDB8El0Il4HDW2XbBesBxvj7to09c5gaLdO3ef/rqOZGBAkCZayg98dW5UV2z17PhBtX62HqAIPGwmd0iFht8uhE=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by CY4PR1101MB2104.namprd11.prod.outlook.com (2603:10b6:910:1b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 15:25:00 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d46c:fea3:ae31:aec]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d46c:fea3:ae31:aec%4]) with mapi id 15.20.4995.016; Wed, 23 Feb 2022
 15:25:00 +0000
From:   <Conor.Dooley@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <Lewis.Hanly@microchip.com>,
        <Daire.McNamara@microchip.com>, <Ivan.Griffin@microchip.com>,
        <atishp@rivosinc.com>, <palmer@rivosinc.com>, <robh@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert@linux-m68k.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 03/11] dt-bindings: rtc: add bindings for microchip
 mpfs rtc
Thread-Topic: [PATCH v7 03/11] dt-bindings: rtc: add bindings for microchip
 mpfs rtc
Thread-Index: AQHYIaqttStvU5ae7EKFzk9c8SSw/KygzymAgAB+uwCAAALKgA==
Date:   Wed, 23 Feb 2022 15:25:00 +0000
Message-ID: <3483b6c4-67a7-5ed5-2953-728ea8ba5874@microchip.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-4-conor.dooley@microchip.com>
 <5b0681a0-ff46-7eb4-3644-0d1173c1f0d4@microchip.com>
 <YhZQRqHib2+GR7Ma@piout.net>
In-Reply-To: <YhZQRqHib2+GR7Ma@piout.net>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dd5aa6f-8cb2-40f9-c9c7-08d9f6e0a870
x-ms-traffictypediagnostic: CY4PR1101MB2104:EE_
x-microsoft-antispam-prvs: <CY4PR1101MB21045DF18D328CF454DC3F62983C9@CY4PR1101MB2104.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFqtwHeYR2GNdiczTZC18CaXzw67IHRBe+EQiQ/nmpeJlmehJi/3GDQ6ZJ7c09rYle4CA1pb9XrfiyebHWGyp+fT87GgafSCawyym2+/5iWYFhwzMNbR5Bh7pPAFMN5FpDyDdmRseYr4Z6Wlf8jQUBVORc7Dal2YQ3E9jr6YbmGca/u+LHxVjbLr/Dgt9D1SL2d+xAhrFvIUp1K8nl1wb/M47Z/PI8IY2NbR4sRJIZf+pd60wxZNi/j5eHN5FuJ4vS+z6A7bobtEPx5sZA1zlKXlwhZztbSl/xfRatf6ZD8Lg8gU0SlN1GHS8IAnIIQQBj+35F2LVLlDtCxR95dW67f+nNDRQMP4+TjVuhitg48ySu/AT3+rCagi6Wen6VHVvH1UqY97+iYQshob9XtofJkuUV/4hhJt2K93WeQmg0VaxN1gLoWD3tSF48kbgRrjBl5/EUgZHAC6jfjV+FFitPcHugwkmAm9AvAcot83c6nD1NvAtwGxArhnvmDGSI5MQgNf4vuuJ528BHBNFB3FtKz4QSqDGPvZ3spWduHK0FL/0jzy+hgmmmcs6wXE0+vMn/mqBuQ/ev8LDVxRo2MpyKMXp8972fvMuZpiS6fAFMwJLjdUkfoK5S4rqLllfmsvo82aFzBFPHCFGTYufQm/70wGAP/EjiYeNTAZYWz2mCMdSO25HCnBfzDFUg9LEkaOq3LRJ9cF+LH6Ay+t+N636/PmJbj7D8iyvSB9fuQRCPgY1+tF5mG0p0O8Z30l7ij0AxFAhOjbCRS3Ywcd3TJ1Q8u/GHZxjRsR8BR4fsctsyc7WoHRRB7tG03UT8/QNtAJo8+jrjdbfzPp6VRhpd9JqxrucvLC2JMKhnhlpFxH9wFUwNjP0UX+YkIauu57pt2nkGWaw7qecSEc/u7ZuVUw+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(6916009)(86362001)(38100700002)(8936002)(31686004)(7416002)(54906003)(316002)(36756003)(71200400001)(83380400001)(5660300002)(6512007)(66946007)(186003)(91956017)(38070700005)(66556008)(66446008)(64756008)(66476007)(76116006)(26005)(8676002)(4326008)(508600001)(2906002)(6506007)(53546011)(966005)(6486002)(122000001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2hDNndzOW1rUksyajZXWVRHZGFydW9GSFYxeEl3Zm85UGlkUHVCaUZDWDI4?=
 =?utf-8?B?UHhucGtuRDdSeThJVDBGcnRlTnorMmRyeDlFSHlTUG5PSUJPUTNicGlMV0dS?=
 =?utf-8?B?YTZaK3ZLWUc0RFQrZEpUM24zK2ZNL1ZxcG9YanhySVVodjd4STBNRVo1S1ZO?=
 =?utf-8?B?bS9ZSGN6cXQ3K3BiQzFPa1l1TmdBbHdXQldVRkVuV0d4MVdxRUEwSWJqZmhQ?=
 =?utf-8?B?K2k2L01PcEZjY25NOTFFZnFsd3NhZGZwSEJ0bmlDTjVuU2wwZjlERmFDRnZt?=
 =?utf-8?B?RkFkSk8vME1xSDgwSkR2ZFRObkNGVzNsZnVWaWZYWlV4TE0rcVJ1N0dieGtY?=
 =?utf-8?B?UmZoMG1SZ3NHbDBmbURaMkpIRE92Z1dBeEJ6QnkwRFgyM2twSE1UTGNDN0dV?=
 =?utf-8?B?YWxvMWNySTNqWjYwZit6RU5OQ3dPa09Id2dvYzRSaXY3R2pXbmhLMFNQWG9J?=
 =?utf-8?B?UWFWcnFEeC9TRTc4c1ZobEYwcVdUemdoR2pjdnZYMWQxRHFQbCtBdU54SFhy?=
 =?utf-8?B?RGVHVFhycXVlcnBweFcwcVNnaTVCZXRrK29pV21YbE1URXJsL1JKR0xzUSt3?=
 =?utf-8?B?UVhMVUl1bk9EM1d5VzVMSVAyYUVBamt4SjNkTitlbW5DMHc4NC84QjNGVmo1?=
 =?utf-8?B?RlhsSG5JbFdKaWVnWEhsSTNSYmw1aTVnRGVIYnh5YTBiUnFxUTEwNTZHWmhJ?=
 =?utf-8?B?RHdQUmZ5RXFUR0tPYm1MOW5PV1dHQTkxbWFqcUw3NTJQcU5pYXREczdkU1Bp?=
 =?utf-8?B?Q09DY1hzaXpTcEZoNTZLOXhiL1VSZTIrSzVjSVFkbWd1dXhIZVVJNWNUdFNM?=
 =?utf-8?B?cnU2K2JCb3NGSmh2a2xxRUUyZXdQMVZtd0VxTkx1TlJEd2V1YnZrWmVhRUI2?=
 =?utf-8?B?TmtVSjZKT1dxTFBqWTkzMUtvS1poTlJnS2F5SDhGR0k5cHVjRVA1ME5GZE81?=
 =?utf-8?B?K1Zrci9ySFBoWUdkS2EyREZTeGEzSGMzT3k4Vi9Ockh6RW02UldsK3pHZFdB?=
 =?utf-8?B?c0lPVmxWa0NPY3I1OW56aVdNRUN1bUFSZVp3ZUFsc1A3TEExb0dqdVJRc2dt?=
 =?utf-8?B?dVdjVWdIL2pyU3h4WEVlTklaM1FXK3h3UzdKRWxwUmtJNW1sSFEvbHFNM0pk?=
 =?utf-8?B?bCthTkM5N2YxYTZHQ2E3Y0N3bUxzUGN5ZkdTdmUrTFVJK2hnOXRyV1BCTGtv?=
 =?utf-8?B?TlNBRTZtKy9NWHMxUUdDUnZXOGNPbFJ0WnBONC9lVmlPSWp4b1JWQ2dDL1hv?=
 =?utf-8?B?N1JlelllRGtGSVJHL0RMVXpWbWIwVnh2MnYxeGszT0NTVml4alBxYkV4ODFD?=
 =?utf-8?B?VTZTbHRFSTRxUG8yWXZnNHlvUXIvaFNxTFBWWHhLQ05VTStmd1NGdG1kQjAx?=
 =?utf-8?B?VGFVQXNlNUNMWlFWWXhjeElicW1KNDIzTlFieFZIZS82bDFHYzRzMEZ1bi9x?=
 =?utf-8?B?M1RBUFlpaVl1NzE3aWFnSlRPUkoxWXlwSDVxV0ZsNXFaMTZTSVFuWko3VFFi?=
 =?utf-8?B?L0JkenJkQys4YzgyWmJramZSbG9PVTBBZEN2K3luWlhraC9vY2ZUb0l1TDl3?=
 =?utf-8?B?MUpDOTB3bndIUjdnK0RlMGs3UGtDMWRFcGM2czUyRjhVajJYQ0lLMFZBRmNF?=
 =?utf-8?B?VkROby9ZcGJ0ZkFuVEJtMXhhbVZwa1JWSGoxWm8xZGJYbytuaVJ6eEUzOEh2?=
 =?utf-8?B?Ui9SOERta0VFTnZGWkVXT1lRRnA4NkxOS1g3dWtyaE55UGFocXZBZTIwcVJC?=
 =?utf-8?B?RVc3cXZKT09uNWJxRGRLS3hNcU9hMEJESTVmTENJRExjRUo4S0VIV01EMFVE?=
 =?utf-8?B?S1RMYmJYYkJmVWMvS3ZDZERyRW94enBWRTJiUGpIZThLd2hlUDJsNEFYallS?=
 =?utf-8?B?SVRvcExZY1hURGFseDlTYURheVVBUTBiejRRZWo1d2t0VWMxeTBGMm9PUzZv?=
 =?utf-8?B?b0RyeWRINkEzaUtWM1QyUmd5TGI2TElSTnV0WU5WQlZuUGttVzY2NndHMlBo?=
 =?utf-8?B?RWNJSVd0U0V1anhxb1ZnY0N6cndwSmczUzJKaWRQeTRFVWVYdUYwWDVwVzRv?=
 =?utf-8?B?Nmw1cy95dnRQMnpsUng2YXArcC9PQ3lEM3djUlVENlpKV0FPRFRXblRLYTZW?=
 =?utf-8?B?NFZIUkV5UWdVcDNqbnhiYnpiTVp4Vlk4L25RN2N5REhHcXppUHRncURUWDRw?=
 =?utf-8?B?aFJnSHJTS1ZhQndoY3NxUUsxSjBpVWE4ZmhLMXBWN3hjUy9UMXFwQVFUM0N3?=
 =?utf-8?B?MXhEa2ZTeEs5b1I5RmpYU2pNTUl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D44ADAE4C747C140A4BCC9AAF7DD5173@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd5aa6f-8cb2-40f9-c9c7-08d9f6e0a870
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 15:25:00.6363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpGXBoWuH6ZPwBKOOyH1rRYp/CWHEFpf7kJsyWIvap8hKW3JiBWdCPS0udR1P1YfSwkpnDxDGXWoyvvkc9xbICYKHex2BEWLUo1/m+dhuKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2104
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMDIvMjAyMiAxNToxOCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjMvMDIvMjAyMiAwNzo0MToyNysw
MDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpIEFsZXNzYW5kcm8s
IEFsZXhhbmRyZSwNCj4+IElmIG9uZSBvZiB5b3UgY291bGQgdGFrZSBhIGxvb2sgYXQgdGhpcywg
dGhhdCdkIGJlIGdyZWF0Lg0KPiANCj4gSSBhY3R1YWxseSBleHBlY3RlZCBzb21lb25lIGVsc2Ug
dG8gYXBwbHkgdGhpcywgd2hhdCBpcyB5b3VyIHBsYW4/DQoNCkkgd2FzIGdvaW5nIHRvIGFzayBQ
YWxtZXIgdG8gdGFrZSB0aGUgc2VyaWVzIHZpYSByaXNjdi4gU2luY2UgSSBoYXZlDQpSb2IncyBS
LWIsIEkgd2FzIGp1c3QgbG9va2luZyBmb3IgYSBzdWJzeXN0ZW0gbWFpbnRhaW5lciBhY2svUi1i
IGJlZm9yZQ0KYWN0dWFsbHkgYXNraW5nIGhpbS4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+
PiBUaGFua3MsDQo+PiBDb25vci4NCj4+DQo+PiBPbiAxNC8wMi8yMDIyIDEzOjU4LCBjb25vci5k
b29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
LmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4+DQo+Pj4gQWRkIGRldmljZSB0cmVlIGJpbmRpbmdz
IGZvciB0aGUgcmVhbCB0aW1lIGNsb2NrIG9uDQo+Pj4gdGhlIE1pY3JvY2hpcCBQb2xhckZpcmUg
U29DLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFt
YXJhQG1pY3JvY2hpcC5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+PiBBY2tlZC1ieTogUGFsbWVyIERhYmJlbHQgPHBh
bG1lckByaXZvc2luYy5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+DQo+Pj4gLS0tDQo+Pj4gICAgLi4uL2JpbmRpbmdzL3J0Yy9taWNyb2NoaXAsbWZw
cy1ydGMueWFtbCAgICAgIHwgNTggKysrKysrKysrKysrKysrKysrKw0KPj4+ICAgIDEgZmlsZSBj
aGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspDQo+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvbWljcm9jaGlwLG1mcHMtcnRjLnlhbWwN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cnRjL21pY3JvY2hpcCxtZnBzLXJ0Yy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3J0Yy9taWNyb2NoaXAsbWZwcy1ydGMueWFtbA0KPj4+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5hMmU5ODRlYTM1NTMNCj4+PiAtLS0gL2Rldi9u
dWxsDQo+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9taWNy
b2NoaXAsbWZwcy1ydGMueWFtbA0KPj4+IEBAIC0wLDAgKzEsNTggQEANCj4+PiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+Pj4gKyVZ
QU1MIDEuMg0KPj4+ICstLS0NCj4+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9ydGMvbWljcm9jaGlwLG1mcHMtcnRjLnlhbWwjDQo+Pj4gKw0KPj4+ICskc2NoZW1hOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+PiArDQo+Pj4gK3Rp
dGxlOiBNaWNyb2NoaXAgUG9sYXJGaXJlIFNvYyAoTVBGUykgUlRDIERldmljZSBUcmVlIEJpbmRp
bmdzDQo+Pj4gKw0KPj4+ICthbGxPZjoNCj4+PiArICAtICRyZWY6IHJ0Yy55YW1sIw0KPj4+ICsN
Cj4+PiArbWFpbnRhaW5lcnM6DQo+Pj4gKyAgLSBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1h
cmFAbWljcm9jaGlwLmNvbT4NCj4+PiArICAtIExld2lzIEhhbmx5IDxsZXdpcy5oYW5seUBtaWNy
b2NoaXAuY29tPg0KPj4+ICsNCj4+PiArcHJvcGVydGllczoNCj4+PiArICBjb21wYXRpYmxlOg0K
Pj4+ICsgICAgZW51bToNCj4+PiArICAgICAgLSBtaWNyb2NoaXAsbXBmcy1ydGMNCj4+PiArDQo+
Pj4gKyAgcmVnOg0KPj4+ICsgICAgbWF4SXRlbXM6IDENCj4+PiArDQo+Pj4gKyAgaW50ZXJydXB0
czoNCj4+PiArICAgIGl0ZW1zOg0KPj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiB8DQo+Pj4gKyAg
ICAgICAgICBSVENfV0FLRVVQIGludGVycnVwdA0KPj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiB8
DQo+Pj4gKyAgICAgICAgICBSVENfTUFUQ0gsIGFzc2VydGVkIHdoZW4gdGhlIGNvbnRlbnQgb2Yg
dGhlIEFsYXJtIHJlZ2lzdGVyIGlzIGVxdWFsDQo+Pj4gKyAgICAgICAgICB0byB0aGF0IG9mIHRo
ZSBSVEMncyBjb3VudCByZWdpc3Rlci4NCj4+PiArDQo+Pj4gKyAgY2xvY2tzOg0KPj4+ICsgICAg
bWF4SXRlbXM6IDENCj4+PiArDQo+Pj4gKyAgY2xvY2stbmFtZXM6DQo+Pj4gKyAgICBpdGVtczoN
Cj4+PiArICAgICAgLSBjb25zdDogcnRjDQo+Pj4gKw0KPj4+ICtyZXF1aXJlZDoNCj4+PiArICAt
IGNvbXBhdGlibGUNCj4+PiArICAtIHJlZw0KPj4+ICsgIC0gaW50ZXJydXB0cw0KPj4+ICsgIC0g
Y2xvY2tzDQo+Pj4gKyAgLSBjbG9jay1uYW1lcw0KPj4+ICsNCj4+PiArYWRkaXRpb25hbFByb3Bl
cnRpZXM6IGZhbHNlDQo+Pj4gKw0KPj4+ICtleGFtcGxlczoNCj4+PiArICAtIHwNCj4+PiArICAg
IHJ0Y0AyMDEyNDAwMCB7DQo+Pj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbXBm
cy1ydGMiOw0KPj4+ICsgICAgICAgIHJlZyA9IDwweDIwMTI0MDAwIDB4MTAwMD47DQo+Pj4gKyAg
ICAgICAgY2xvY2tzID0gPCZjbGtjZmcgMjE+Ow0KPj4+ICsgICAgICAgIGNsb2NrLW5hbWVzID0g
InJ0YyI7DQo+Pj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDw4MD4sIDw4MT47DQo+Pj4gKyAgICB9
Ow0KPj4+ICsuLi4NCj4+DQo+IA0KPiAtLQ0KPiBBbGV4YW5kcmUgQmVsbG9uaSwgY28tb3duZXIg
YW5kIENPTywgQm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5n
DQo+IGh0dHBzOi8vYm9vdGxpbi5jb20NCg0K
