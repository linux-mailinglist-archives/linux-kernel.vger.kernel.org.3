Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF952E7A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347201AbiETIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347245AbiETIdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:33:05 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26715E63F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653035523; x=1684571523;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KBltdkz1Vlq8Eu3Zdk0MfYQZj6NjnDvZOgsXbqIasTw=;
  b=IoQBTDKdjpORcXGNerWF17t66yMILGvLSkAr7SPBUS5ejCDydvOal9MU
   HPZq4OMi9DBVRoP3bX30Y5WS+/Qo2cEyMTZ/z1eVKw7b60BX1Wp92i589
   BSbAPZ/9kLbGmVtWVXEmgcsb7l88xYa52v12omyburGhQvt7fB2dV0trv
   S1LffNlVVE+jCTpbGsL53I8dk3TaFGlyvgaNUaSkqfuyZzIYuXcb6e/J4
   pSqZFQEen+44TFNJV0PLIjx/LBQ5/fL4RN4hD4kWr4P9bp/a69CuRx1Jp
   V1SBjtRwdlgF6hEzDk5v+FCazTbGAjsNwrK7s12blor1k9JpX4V0RzAIQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="56258924"
X-IronPort-AV: E=Sophos;i="5.91,238,1647270000"; 
   d="scan'208";a="56258924"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 17:31:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrE5n2EXT04xp1me+UfNuF38AGJXDZYm4dDMByuVR6qDZeqHSLVWmQ1eH/obdsQhrx0x7kvEmlgZa76pwGbf5JyVQNsQLh+4/8yS6WUp/KwB1DzQw1cNPSJrSHDlb1LOgq4FXi/0/fFN+uiGRBInTHBTmzG3QThxhs3anaLGC3aDRV5n+Bp6wbSCBuXbZ8RBoPItsY+tN9t0R+v7WXhQOEM5ep+/+xocqyeIswPlKWTyxlIS4oEgV5iQQtd3i2vbI4IHGlIJX4xVo+P81F2dVt05WHrLZOe7y/ioty1Ou6hxKNIr0NhV43H+sJVSNLBpzJqEOEHuTawsj0rBxWy8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBltdkz1Vlq8Eu3Zdk0MfYQZj6NjnDvZOgsXbqIasTw=;
 b=fa2lsyqcZoO45tBpC9TwXdO+MwPgTWyeqiCE5qfWlnfh++mdmVOKw1ZaoM9ocdyBs4meCfSjF3S1H38w9B/3oKR7pyuNWU1s1lqqzw1vgfz1FTRLqicHJTNP1SOTRAzu9APaUZMCXNKVFp/PjGS0h1aVPOI4zPayCnC1ORI7NitPQZgPuJSD+2C9hD69as3GgDLZAdV+zrhQDzoPA4HHXYkHYMNo/ap5/cwWewuACBrJCumAeYqBN2pvHadT7SQEpz9tQDyBJbQKXYJ/KTNIRHLFsYUZzdJCoG0NNHb0ORMAneylcUAB1134oXT4rrmmmsAFoivsjnhodrolVhGKHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBltdkz1Vlq8Eu3Zdk0MfYQZj6NjnDvZOgsXbqIasTw=;
 b=ZTg7SMIhRaYkGyeitgpPnOacvyYwd+5izKs+DdLaV3dVuR0HSPtMLdAmlOMDja+6XLaiuV+mk2s2R9bRDHeMQrrPN9YCgtjgmYwFvOqRZKdAXgwuTbjqeaxTH9nfvtvIN+5ZPJXhbBL1e/+SKrWEmTxVJzn8GQKIlOdpgX+b/yE=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYWPR01MB8479.jpnprd01.prod.outlook.com (2603:1096:400:174::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 08:31:50 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8%7]) with mapi id 15.20.5273.015; Fri, 20 May 2022
 08:31:49 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Hector Martin' <marcan@marcan.st>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 0/8] Add hardware prefetch control driver for A64FX and
 x86
Thread-Topic: [PATCH v4 0/8] Add hardware prefetch control driver for A64FX
 and x86
Thread-Index: AQHYaoDjIWwLbj2lFU6hicJ7XLMCMa0l4CeAgAF7OBA=
Date:   Fri, 20 May 2022 08:31:49 +0000
Message-ID: <OSBPR01MB2037247D7482C9E0E0CFA2C380D39@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <57184edb-8a04-b4bd-969b-bca152375d86@marcan.st>
In-Reply-To: <57184edb-8a04-b4bd-969b-bca152375d86@marcan.st>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63065f9e-fa09-464c-cf33-08da3a3b2f41
x-ms-traffictypediagnostic: TYWPR01MB8479:EE_
x-microsoft-antispam-prvs: <TYWPR01MB8479084B36329C82211DEB6480D39@TYWPR01MB8479.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5XraWrlyWXFmY9cy/I5qz1wMsUFykJApoB/D3pLEvZ2n1/6AOTvQfnirYT3L4YeSH3A9FCKVyiqurUiGQIl/ZCJBezsb/wdUUJutV4jzAXhcMixCzC1CgjPbwIXuA4yKQh8wxRbEkbrwxe4e8FLjxRDd9XRcAsqvffhJ1tVz6gtt33JjAud1mF4mBuyaKRAE8/40emEKThElGMuuzj1RGU3JHlw7RXrv9MqB6NtSIyQuqPvMwYXJjpck1cFrPtfW/mYnTQvlJ5pNAs05P2qo7m076MC6dryORrvtNjRJ+hhMykp69BwjX4lJYdCnTg703uN0IbdO6QOEaLipFvETjstwffIuFN8HRhW7jjs4cJPKfJrzj/Nc/PG/1gpf2dVduLXbt/cmNU8Mxp/uz94uBmLq/6wMnI3w3AXt9m7kspTydoARvU/C3ArRdZEl5FVQF5NzAQWnoj/hjjnjVzsxRBy4+495d9OsZvqtrdL7qBNcySXb5UdKjVNYMifP6sMd2/QiNtGuQQ7j2sL/IizPpIp/j7oaDUvcqPD9QDl0iCP8eb1cS83yC0NnH31KhyjMG3IgsvJkjmy/zJeBHWUasqMsg9VGU1t6vjgn3DA4o4TWwxEvamZG28zl7z+uCyhp5Sq0B/kuac686OB/110m32mQTizCokGKUiMxhLlslp5BdfiGgdI4UhmT8e/av+VChfRXWcqAMibvDg79IWFs0BsIXniZhASqAoKzzstK9xsJEP1lb62y0pHW5rLTigJPTM4+2KvFwD1OcnAI+IJgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(55016003)(7696005)(9686003)(26005)(71200400001)(33656002)(508600001)(38070700005)(82960400001)(38100700002)(122000001)(921005)(66446008)(110136005)(86362001)(186003)(85182001)(52536014)(66946007)(76116006)(7416002)(8676002)(66556008)(316002)(5660300002)(8936002)(66476007)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXM1alNFWGdTdnhvd2M5VnVUOHZRTW1ZZE0zNGtoNndSRUhPYkdrMEtRVVJy?=
 =?utf-8?B?L09NU1lpcnZLNjNDTkFEUVdlQkErNnFBYS9iREZWUXNEL2dwY045K1RCcHJx?=
 =?utf-8?B?M1dPVktpaHNZOCtXS0tBemJYMUxwWkx0cFZmN2hHc0VMT1lCM2dzaGpoK1VE?=
 =?utf-8?B?bUpyUFh5ODNzMXZrdDlmVkxqdUhJbGtJZmdDd2djQTdMYTEwYmI3dzhiREwv?=
 =?utf-8?B?L0g5N3hXNUdCckt6Z1ZBZlFoNDd4MXlObmtkbXpYcjJZU3F5bXVaUlZ4SS9o?=
 =?utf-8?B?L21QY0o0THFOYjhVSEowczhCQUJFd29jRmlWYnkrN2duSWdrMEh0MmpYT2dG?=
 =?utf-8?B?MVpHMkpJZStzWEtyTVUwOXkycHBZVzd0bS9kRWYwaVE2QXdRZG5QZXUvRzlo?=
 =?utf-8?B?RExMdFRCaS8zU2krZGZxZUlaSVhQaXhyYXo2Y3BRU1NGZkkrSFpOSGRIaTdQ?=
 =?utf-8?B?UGZlL1Y0SElIbmZXQ0htcGdvS0c2c0tPb3BGZ09xNnQzK0lqMTJCcFNsdEVl?=
 =?utf-8?B?bzRCQXVuREZYbHVCakhuRU5nRjNucmZlZU5zWlJPNlJIZkY1ZU1NM0JQTi80?=
 =?utf-8?B?RVRQWmx3S0c4UFltMlJ6WnFFQTh6UjJLZFkyZ2E0YXhocmVST3pRNE81RHQv?=
 =?utf-8?B?L0RmaHVDYVhlK01IUmxyVmwzVkY3Z1I4Y29YcnQzbkpCYmhHcTN6QU05Y2Zn?=
 =?utf-8?B?ellJQTRzMWs1RjJFeklVYUswVzRGVjZWNE12Y1F4VGpUclVORzFkWXhZVFFp?=
 =?utf-8?B?QXMvbWJ6MWFzQWJrVGdIVlVmWXRLMVI5WWd4Wm1sRDNEYlVBdlZIQmlZdWpX?=
 =?utf-8?B?TUFoYmhtU3BHU1lWbDhFN2I5cEFFOHh4c0U5QTcwVFd2bDZ5ZVhWWVRFdWxt?=
 =?utf-8?B?RXVoQWVsZDVMQitWWnBGQUJpR1Z6bFd2bzcwWEpodEtPSjVKMXd4c3B6RnVE?=
 =?utf-8?B?V3dNNHhDcVdFVXpDRnpWTjNHU1JpYlNndHNOcEdLY0pyQmFnTWxBR2Y1M3gw?=
 =?utf-8?B?eDJCY0tSSWRLVXhEU050UXd5WjJWOVRQUW9McXVDcldrakowbWRzV0dZbUpU?=
 =?utf-8?B?Z2NZdlNqN1h3U01VdEI5UU9nNUdhem1RUU1xYmtha2tUUG5QblgxQU1qenVu?=
 =?utf-8?B?QzNrdmgxa2t6dFY4M21McUNPMnh1TEZPTnZaZEZ6d1Y1dkpncmh4WFR3UTQ3?=
 =?utf-8?B?U2k0NEdCVm1razFORit2VzJQWWM5STM1NUhUY2pER21ycHR0STZjNmtiRzVO?=
 =?utf-8?B?OEJTMENBNzU3T3N0YWZqc245NXFnems4blRPUGVqT0R2ZkhYa1VKNWhVOE1V?=
 =?utf-8?B?TjJOWmlIWGR0YytnU0xISEprTzBIejE1QjBBa1JQZEtUbVlCdWdKeEtMb2w0?=
 =?utf-8?B?dmJiYXFWeXo4ZjFHeEY4dG9YcjhIMU4vWVVjZ2lUb25yUkYvTFpKRzd0Z3U2?=
 =?utf-8?B?WlVTT0pQa2hhRnE0eGhpU3hOOVg0dGpsdVlYcnA3dExPMnRtSnBKdGZzM3Jj?=
 =?utf-8?B?a1pUdktUcGZyZkliODVVdFU0S1BacVcxdGJ0aDd2YzJwVmZNUWtRL2tLRmR1?=
 =?utf-8?B?LzVVZ3BVSUFWcVR4Z1FrWHYycVJyZmVuR1ZCbEhVSlpXUDZza3VHRjMzZjJh?=
 =?utf-8?B?Wm1STEFyclFBaUJGVUFuWHV3SnNvSDRCT25aYkpXTTIzQUFJY2R3aDRXdVhq?=
 =?utf-8?B?NmIvLzc4OENkVktlWExUUTFxOGZyazE3a21KdFRMZ1F2VVB0aTZtRmtnRCtT?=
 =?utf-8?B?TVg1eTNmd1EyZVRSMEZ6YW1sTjFmZmIyRFJlTGhHaGN0U2l1dmxFOUpSajhl?=
 =?utf-8?B?V1JERjU3S2dwcHI4Nk9xTDNkSzNIclFhVUhOcUNwUlQrNkJtZ3FncHRSWlZn?=
 =?utf-8?B?anpZK1VyU2Rpa0pteDFzSnRSVTFlbDZJZlNJVEt0K080TWk5M3BabHlNRWlr?=
 =?utf-8?B?eE1wQ2pZRjF3QmFFT1FzTUV2elJUc2NuZnd3K0VFd1NiZXh2ZmFRejZqZEUy?=
 =?utf-8?B?YXpVT3pOYkFtbW1BL2N1eTNxeWNQei96b3lac0FIdjYyWWVMSWltblN3UUlK?=
 =?utf-8?B?TWVpVXBxOXF0SGtuYXNPZzY1clVUcE9udHdSMURjcTkxT2FUZGZaR01QNTlD?=
 =?utf-8?B?TjIwTi9CTUo4WXRrUmRTbmk1eWN6cUNSam9URHBjTzZKTzk2ZzhxeHVlazFi?=
 =?utf-8?B?bDRMekZoQmk1WWJYMHpMdi9rOW9lSjNjaFA3clR3ZHU1MTdxTHRuR0Jub3BY?=
 =?utf-8?B?RU42U0F5aGpFZEtxV1JBNWlBc2t2TllRYnFaYkg3VWEyZ2NrMTYwTm80cms0?=
 =?utf-8?B?MVNqbDdqM0hoSjZIWURKelBQMThCdFFSYjJVQkJCNWJMcDRPcnJVbFZsNU1K?=
 =?utf-8?Q?uwzQdjyL2t4Is85g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63065f9e-fa09-464c-cf33-08da3a3b2f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 08:31:49.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8olRTMr9qcrHrjqIw74NW43sj74b6Bhrya4+OO2CY8ngLi3ronh+B8pBMHr6CHbWUgffVIJz6OU0gPPr9PZSCn2/jWhMSDh0M/nsELL+3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8479
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB0aGUgY29tbWVudC4NCg0KPiBJZiB0aGlzIGlzIHNvbWV0aGluZyB0byBiZSB0
dW5lZCBmb3Igc3BlY2lmaWMgYXBwbGljYXRpb25zLCBzaG91bGRuJ3QgaXQgYmUgYSBwcmN0bCBv
cg0KPiBzaW1pbGFyIGFuZCBwYXJ0IG9mIHByb2Nlc3MgY29udGV4dCwgc28gZGlmZmVyZW50IGFw
cGxpY2F0aW9ucyBjYW4gdXNlIGRpZmZlcmVudA0KPiBzZXR0aW5ncyAob3IgZXZlbiBhIHNpbmds
ZSBhcHBsaWNhdGlvbiBkZXBlbmRpbmcgb24gd2hhdCBpdCdzIGRvaW5nKT8gRXNwZWNpYWxseSBp
Zg0KPiB3cml0aW5nIHRob3NlIHN5c3JlZ3MvTVNScyBpcyBjaGVhcC4NCg0KPiBJbiBwYXJ0aWN1
bGFyLCBjb25maWd1cmluZyB0aGluZ3Mgc2VwYXJhdGVseSBmb3IgZGlmZmVyZW50IGNvcmVzIGZl
ZWxzIHN0cmFuZ2UuIFlvdSdkDQo+IHRoZW4gaGF2ZSB0byBwaW4gYXBwbGljYXRpb25zIHRvIHNw
ZWNpZmljIGNvcmVzIHRvIGdldCB0aGUgYmVuZWZpdHMsIGFuZCB3b3VsZG4ndCBiZQ0KPiBhYmxl
IHRvIG9wdGltaXplIGZvciBtdWx0aXBsZSBhcHBsaWNhdGlvbnMgcnVubmluZyBzaW11bHRhbmVv
dXNseSB0aGF0IG5lZWQNCj4gZGlmZmVyZW50IHByZWZldGNoIGJlaGF2aW9yIGlmIHRoZXkgc2hh
cmUgY29yZXMuDQoNCkFzIHlvdSBzYXksIHRoaXMgaXMgdXNlZCBmb3IgdHVuaW5nIHNwZWNpZmlj
IGFwcGxpY2F0aW9ucy4NCg0KSSBhc3N1bWUgdGhhdCB1c2VycyB1c2luZyB0aGlzIGZlYXR1cmUg
YmluZCBhbiBhcHBsaWNhdGlvbiB0byBhIHNwZWNpZmljDQpjb3JlIGFuZCB1c2UgaXQgZXhjbHVz
aXZlbHkuIFRoaXMgaXMgbm90IG9ubHkgZm9yIHBmY3RsLCBidXQgYWxzbyB0bw0KcHJldmVudCBw
ZXJmb3JtYW5jZSBmcm9tIGJlaW5nIGFmZmVjdGVkIGJ5IGNvbnRleHQgc3dpdGNoZXMsIGV0Yy4N
Cg0KSSBhZ3JlZSB0aGF0IGl0IGlzIGFsc28gdXNlZnVsIHRvIGJlIGFibGUgdG8gY29udHJvbCBp
biB0aGUgcHJvY2Vzcw0KY29udGV4dC4gSG93ZXZlciwgaW4gdGhpcyBjYXNlLCBJIHRoaW5rIHRo
YXQgaXQgaXMgc3VmZmljaWVudCBpZiBpdCBjYW4NCmJlIHByb3ZpZGVkIGFzIGEgdXNlcnNwYWNl
IGludGVyZmFjZSB3aGljaCBleHByZXNzZXMgdGhlIGhhcmR3YXJlDQpwcmVmZXRjaCByZWdpc3Rl
ciBkaXJlY3RseSwgYXNzdW1pbmcgdGhlIGFib3ZlIHVzYWdlLg0KDQo=
