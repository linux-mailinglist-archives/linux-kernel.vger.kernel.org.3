Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C663B52E5B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346193AbiETHB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346202AbiETHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:01:20 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4485C3F8B8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653030067; x=1684566067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LLNK5bDUfCAF+m9ya0YtBMdTjsCBjQun5zQvpbjsaUQ=;
  b=bqIzkpDB4+K0hsIgeof7T8WLYwgOxCBxymRGm8r4ov9pCxdgeIapYaQO
   m/FZz8u/a84SfjRsV/MSbDVqAftuyLj8x1a+keSb0XhoCUgFHpccx7Mam
   ha78Yl7vHhjuLhaZfMvMxVmBFm28LFBayW88gJTG8CPP4R9jZC0HVoWMA
   eud3sh1E/bWntnbdJ9+B2eX6+l6MnoqCDuU7ndJ4tPzwYKGH0BydpaGx6
   CiveSqZ3WrZPxxfVTzMU/MxkbdPHLkaceP+Rg4QwfIuw/dVDTWmyW7C6E
   +HA1PnIAOfPhgizy/f883BWQ0rub95AbWm4v4Hj37vMbVpVSs4K3NHR43
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="56445979"
X-IronPort-AV: E=Sophos;i="5.91,238,1647270000"; 
   d="scan'208";a="56445979"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 16:00:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu3O+3hivu2Aq2Voe8sUNIV077dlQHyiLJykS/z4DoXAuoJpIOGnJaBAcakTfQ6t1SjWJUvExc/qYEA6HygJb/oSnI3nkJjZCvJs47gwJntiLwBAuJjUfLpTqF0OEOhkjIcmQtDnxrlOjQqwoegQ6L+GCg0kIIRfhhzYDFWIpOkd+2oSDzV4mMjva54wKGK73cxIEn+PAedN/r17ImGf+qP9YZsFnfHE6jIyIFWUNLlDzl7CF5zTwjfmyo6SZZQl0lQ5M3ZvZOxR/ShDNIVqLh+3gWcIrhc1wm0sQFsB1ACFU/mjmd5sA9Tkq14MOkQ1k+NY1C6n6WMsbuZ6Lokq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLNK5bDUfCAF+m9ya0YtBMdTjsCBjQun5zQvpbjsaUQ=;
 b=aM7BGYgQ34LJpbmFPRGenytj3p1LX9xOr/CJDiL/FGv9dbWZejNpLkkprj1O/E9M6gTzNLl5gxeHJ/3sC98CRHAHQv9UBg4YZJsjz77d5vEQ9IjLI/h7vHQD4/Fg3E0Bvh4kwjZkEVE2N4oRR/3lYs0bNXj6jf5aL0o9eIKFgsDoXZpzJThASOTsf1RpsiCrwDYp+gWIMawL1zujQQwC3qPbiTjCCsI/SGEGQrSrPBRuEDIChhyWFMy6JqxZRkqFQqdWeQw99L53zKnv9HiDFZR9D1mTZ9Xh5415cuL6MVU23IEr1V9huKXPOhQC1dip0WH3x0hLZpLDNLL0EidpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLNK5bDUfCAF+m9ya0YtBMdTjsCBjQun5zQvpbjsaUQ=;
 b=TKDsiyoBBvH/myD07OCz1hMUtbejG0KMhpsIsXy7JSWRvtNtIwqS7AsAWhjWHK7Qg7911HsROYa7iWx5OrSgYvWa9Hg+J3RMFxfu/HYj97QlHmne2S7V68Zf9VEBClKke8kxR2Xv2tz24Ksy45GHW8YAeNeCyEec0o9W+EKEKfo=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB5075.jpnprd01.prod.outlook.com (2603:1096:604:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 07:00:53 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8%7]) with mapi id 15.20.5273.015; Fri, 20 May 2022
 07:00:53 +0000
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
Subject: RE: [PATCH v4 5/8] arm64: Create cache sysfs directory without ACPI
 PPTT for hardware prefetch control
Thread-Topic: [PATCH v4 5/8] arm64: Create cache sysfs directory without ACPI
 PPTT for hardware prefetch control
Thread-Index: AQHYaoDpup2ZRNER00mPpJtDf+y12a0kN4cAgAMdW7A=
Date:   Fri, 20 May 2022 07:00:53 +0000
Message-ID: <OSBPR01MB203760BF2269EE91184ABDA280D39@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-6-tarumizu.kohei@fujitsu.com>
 <YoSbwJIDoXz5Aipv@kroah.com>
In-Reply-To: <YoSbwJIDoXz5Aipv@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 083cd9ac-17d2-4929-b5fb-08da3a2e7b57
x-ms-traffictypediagnostic: OSAPR01MB5075:EE_
x-microsoft-antispam-prvs: <OSAPR01MB5075D4BF287B8E116A150C6480D39@OSAPR01MB5075.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rAIz3IoxMY/MHSR2OLHw+YoW0/YrcQt4NRaaMmFucwrkRFXq7KTBIz3mqwt/lUtA7nNBOrITA6pRUY63JmBSzp9Qa9WcntWdmlnXTCulb7aP2xJSw/LbqwMGAVYXfv/lqT0A8NorQYyHLnpO2NSvcWVDHODVjyHLV0dtiVX/5QvfXZ8cuXpaFyeYnvuScmB+xjnKbtinaNU/UpjGRAPLJthy3p7LV5S7ndFeOLFZ3ITOhfLeK0n8HGI/oGeB5fqwseUd4mLyFNc8PXDCJLT79l+UatxaTS5OSicCKOBvJy5CRSEIE7yD0gX22XfRtM/7CI8pyHg8nWEDx2GO++1abN8lUa5Vwxrk+mN3LVrbNxhv3w4El7sQh3e+OmKAIXIMLQ0AKy42mhCRdx+TWkd0c18J9WvMaIP4QARWncRy+PPF9p8QD27AIfz/C2RaDWtTGwmCRpCICmzZgIZqBY4ZAlKxkjd1seQmoMgN6uPMr4u3qa0H+X4dm9b68g+tHn7P8XNC36gmQsdLiTgOCoCnMKgjoqr8grk55s0DjcSxh3cDVmV7lLGcpJLOO8WlQbdadV4qQOYegd9tdL2LfisAKZhIM6XWWHvEPVoYItKiZKJ2FAxfBGo1ywTlcltYQtb4ni1ZDUWZgSGkuAfCTSoNsZjD3ZlaXFgyhaLZtX0vHq+/5cbPgRM/1sBxJUVQFFshN5xM2KaciuObw9GrjQ+siA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(558084003)(86362001)(52536014)(9686003)(6506007)(26005)(85182001)(2906002)(82960400001)(122000001)(71200400001)(66946007)(66476007)(38100700002)(4326008)(33656002)(76116006)(186003)(66556008)(66446008)(8676002)(6916009)(64756008)(54906003)(5660300002)(8936002)(38070700005)(316002)(508600001)(7416002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TU1Yc3IwaFBGNUZiaGdPQ1UySk9wWTN6eHpDTkRTK2tQa09HWWhqYWhz?=
 =?iso-2022-jp?B?VUd3M1dIc09UczZ6d3c0c0ZaUTdnVEs0WFpSeG9nZXdjVWhLV3l5TndU?=
 =?iso-2022-jp?B?WUcyNFV0bHNONjZzRElNWmFxOS94YXpoZUxGQU1wV3ZMUjZiOEUvV2gy?=
 =?iso-2022-jp?B?eTIwZTErR1FTWVRERTJvOTJqVlJSYmRVOE93M1JlV0ZaZVNPQm45dS9M?=
 =?iso-2022-jp?B?dEszRHRGWEhLQjF3akh1aitpRlpvVVdGd0VsUzV4MythUlN3OFZ2M3BL?=
 =?iso-2022-jp?B?Q3BRTzZVK3Q3UFJoODAwV0pBWHZRRTN5RDZHYjZuSnNmYTFhdWZSQW8r?=
 =?iso-2022-jp?B?UERLb0dWSktYOU0zdDV2YVhIYnZxWlFORFdOMzFjVm9vK0hIR2lXa2pU?=
 =?iso-2022-jp?B?c0Q2aEJ2bXdWVkE5NzYwYnl6anZaem41cXhwZnovT0VNTVZWaktMYjYx?=
 =?iso-2022-jp?B?NkhwMk91WjY2WlVxTnlrU1NaZmdvWmxjQU1hUjFPblpZR3dzNmxHQktC?=
 =?iso-2022-jp?B?RWNzdFlUTml1dnlmTGtEWUc3R1FBakxDTUQzd3ZnS0RUQUgyakc5cUwy?=
 =?iso-2022-jp?B?MGg3TkMyRUJNV2FRd0ZQOERsTmZsNEI0SW5IaCtnVzVCYnUwK1cwbnN3?=
 =?iso-2022-jp?B?Sm1mQTVvaE9lYTkvRStqY0tabk1xV3BkTHZacDh1SUhjcWRXZ2xpeVZ2?=
 =?iso-2022-jp?B?eXhZR1RsRWNHT1dkNkMxaWZpWWYyV0lmaGJuR2pYbWF0Q3YvVXlBb2ZV?=
 =?iso-2022-jp?B?ODV1Sy8rblBsZHJNWFhwUzdTSUdta2tHQXJjVkZhYmtQdUdKZ3ljeng0?=
 =?iso-2022-jp?B?MUtOU3Nya2tYWFEwUUEyLy9jWjdqeU5EUXlDQjRLZUZyYUwxYXZDWXcr?=
 =?iso-2022-jp?B?aUJTYjQremx4K1lZRnRwaEZ0TlZ1eldxY0JOM09teFltenozYmtkRzlH?=
 =?iso-2022-jp?B?RGJFWFl0MnEwR3Z3ZiswbTdvdnJlVlNpSHRCS1hzN0s4VmgrVkxibVl3?=
 =?iso-2022-jp?B?aXZ1czE2S2NjWDBJcWFFczk2UzcveU9QNlhXa0N2NU8va2pJcENLaHk3?=
 =?iso-2022-jp?B?N3E5b3l3OXF2UG1FZGZUbG5hYjBGS0F6bHVkTWx5SGZ4bVBLYWZaZlpx?=
 =?iso-2022-jp?B?MkcxVXFpaW14NVdyTlhPakNQSHFhV2tpalRySlA0RW9CKzczZ2xRS3NS?=
 =?iso-2022-jp?B?VEYvS1g1TnJNMnlMbFNPc1o1a24rUkNWSFQxYWtGMGxwbEhObW4wYzRq?=
 =?iso-2022-jp?B?cTQ0SXVPQXNmaU9JMTN5YUNjb3lHYzJETUtmSGwwZWFmL3NrNWdnZ2ZD?=
 =?iso-2022-jp?B?REs2WGc2RjJuaFVTRnZzc2ZWR3c0am4yWEh2WW10clJOTjFsaEl0bjBP?=
 =?iso-2022-jp?B?ZWdNdVYwaVN3UHd5NDd6cEw0Tk9na3pnNmlPdEFPTm9GUVZ6WTJLKyt6?=
 =?iso-2022-jp?B?cGFsWUphdllueTdWQWErSkVVRVZLTFNiVVlLTkZuakR4WW1YdFdLQ2dk?=
 =?iso-2022-jp?B?aGJPSG9mNlVZT0JuLzhaUlhWVDZZYmxhRUNvdVE0NU5WUXFwQlJPRVQ2?=
 =?iso-2022-jp?B?emdiK3hKeFNuYlBpS3NmMUZ3RzhQRi94cVo5dFEwdFRjekt3eXpIZlJ1?=
 =?iso-2022-jp?B?V29XSkZGQU1oaUxOVDV3SGZ1ZnVnZkR5d0JFT1MvRlV4NWxLdFZ3RHdF?=
 =?iso-2022-jp?B?Q3BWbHZhTFFEQ1ZtdWU0QUpKYUVBa2RpdXdINHJtd1BrVFNDemloc1BL?=
 =?iso-2022-jp?B?TllFdlg4RGVYYm9KTjZVcm5pb0xneTlVSlBwZHpYVDlFZjFBd0Frb05x?=
 =?iso-2022-jp?B?QUVuVjFXS0JFcXRydzVkbnd0dDFNaXV0RmJlZ2lXWEdRYVIxV2RIR1VS?=
 =?iso-2022-jp?B?b3FBc096dFdobElWeFhMSTNqbm1yZTQ5N0g4Zm02K2hMQXZ5RkRBN2hM?=
 =?iso-2022-jp?B?MnBydHY0WS9nUzRKZVdVR1pVemdjLzF5VjVPcmIySmxGb1ZhcWxNQWFm?=
 =?iso-2022-jp?B?QnZuZjdCdlc5RzhnMDNHbjIxSityQjlGM01Vai9JZUJhNHF2blgxYnBC?=
 =?iso-2022-jp?B?WmRtODM5NzlJeEpZMGRsU2JXU1o1TjhSZWNmYTJ3a2pocTNjMS9HRkhF?=
 =?iso-2022-jp?B?a25yeUM1SlVQYlFmSmtuT0VqZUF1WFlIS25yUzhQV1YxRE1ZMjEzRldn?=
 =?iso-2022-jp?B?SG9wNEZzbFk5Rm1QS1ltYnpYOFA1MmFHSXVMOGY1OHNGS25kdjVpRmo4?=
 =?iso-2022-jp?B?WmlTTFFESElhRWpHcTdQZ2gzMHhhWTgvY1ZhTzJwbGErcEJudkJIZUZF?=
 =?iso-2022-jp?B?VUlUODh0b3JaYXY1cXg5ZW5oMHVQbXcra3VlMWJYZXZjdGpSZjMxZDVH?=
 =?iso-2022-jp?B?anQzSlhhTndaQ09qODRtbzByd2pjZXdPOU9WdS9naUE4L1ljazFQa3FC?=
 =?iso-2022-jp?B?U0tYdnRqVXZQaFhhRmM1dnIvMG5iNk5vZWV4N1dpa2dDS3ZKcUtpUnlQ?=
 =?iso-2022-jp?B?VUd1TUxkNXc2L1M0WExRb1ZFNUdDNXVRaDRYdEVWVHhRbmQ5L0I0TkQy?=
 =?iso-2022-jp?B?UDRRbllOOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083cd9ac-17d2-4929-b5fb-08da3a2e7b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 07:00:53.8130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwyVOHPyfEv8Y1HEg8qEt8KJ0TtUFue3kXZKy181n/4dDHt/sMPm/Wz7OxfX6vVwY1aT+DUj2Jl9o6QcRYJEb2hm4FtwrU7llYGiOINjJ34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5075
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please do not put #if in .c files.

> Same here, no #if is needed if you do it properly in your .h file.

I will try not to put #if in .c files and do it the proper way.
