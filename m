Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD754F423
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380918AbiFQJVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380834AbiFQJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:21:11 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A215C651
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1655457670; x=1686993670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j71NTyDp7PK1wWZaLb+y/3Qz/6xrxQSPN5ebVAjrx5I=;
  b=ACChwKDnr31z5EWzVSwJlgPQBDfbkwU4XjxaSdQA3BknjFYup78NBo2F
   SXe+zvDjn9+GBUcZe91NjVcLKsfjW30XcxRx7jwRWd2z+oRtP5KKrc7oy
   L0EecPR9xREVATgIwccXRh83+1vgPv6aiqtYYwllb7//ZYDPGODb/g2G8
   ghgIOsodvJ8ddpOLd+A/VYtaWITEgcjKXqY4FtnHIS7/lk+4H36dEvC+S
   eLvwXVEV8gljDHDLnpilbmY9pCOX1T+VhjXnHLbmWC+9odTHTfIQq8iah
   CVDFZ+FreSP1vxoUENhObeWqaPn4gseeVkHiClmDVKTvZEbggZXNIuBCr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="58480575"
X-IronPort-AV: E=Sophos;i="5.92,306,1650898800"; 
   d="scan'208";a="58480575"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 18:21:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeOUUea8QIqm83mL0Uz8nDEa/fH9m1fgO7G3jjE5f+I8+9jT+PNTOFlyVIJowBp4meyIfCJJ3BTA3Ph3T7iPVMXeSlqLBKERwjIGsaO9SavYuDjA1ufg/cUkSq3/3cuHdcggrdXT5orgCzEnqx+kiW1NVQl47i+dAm0TCuornX9Y9RApF7FKT2C8GPRI61sLNlaOuA1znPEKvkFakCghHg1l7umfGDXrGRcEA8Mx4jXgYzlW9qnkIp4mnK5zTx2JE+oA8cA13zx6H7yEVQEY2dZ46AB7np57swA/XPeo1IY6trLHhEseymJKHpLtA0JaYqowzh0tFK0143w8j5RjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8bUKGlibHKRl8tOg8BWVMoYePfhs7xzNdxdKOF1Idk=;
 b=BG9EOBQ1ivEI6qjxkCOmC9k9VKaYbyykvLPtrasos7jQ0qtzvd1IVGtzqNC54qhdLua9IgHzQbVMNIlh7m00MAAs+ZUWa4e01kPwBp0PfYvD5RPxD/tDeCgSKZdf12HsHACdVUyadkRXlmRIckFnyNpYXlZZQb0711g/WHENnavWCJFEelwWf/R/01d9j610OR9yNxE5FJ79H7ZaNSrmYiWBQuCpyk1c0VgMzYE3UxbrOApQnQT7X15aXdXINzUh2ORbD2OwghFYr+ZvHpjVoiw8Df1X2YK8PqhHJerKTxAUlwrG5rGdx5EARStG+MLU77Zwe6XDM9kBhWVw7HDspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8bUKGlibHKRl8tOg8BWVMoYePfhs7xzNdxdKOF1Idk=;
 b=Sl9abzBBqUp9SoD0UI5RYFlATysplyFQVWHmolyKvlHz+IHDGScl++JNTFxeHmpFeiaUUs02mkzoC921PHEhh0RccqcUUMU13/HSCvAv5bXdeXP3cTOIA+hsH7ySJOGeHlRQ+E7Px3BFHsLstopH2fmh73lUjJc82oKaSOhE4FM=
Received: from TY2PR01MB2042.jpnprd01.prod.outlook.com (2603:1096:404:12::11)
 by TYAPR01MB3856.jpnprd01.prod.outlook.com (2603:1096:404:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 09:20:58 +0000
Received: from TY2PR01MB2042.jpnprd01.prod.outlook.com
 ([fe80::e13d:16ae:7ddb:a10a]) by TY2PR01MB2042.jpnprd01.prod.outlook.com
 ([fe80::e13d:16ae:7ddb:a10a%3]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 09:20:58 +0000
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
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and
 x86
Thread-Topic: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX
 and x86
Thread-Index: AQHYemckLVPNFhFQbU+IAdEo3cwBO61IoUEAgAYyEhCAAA4dgIAEfPmg
Date:   Fri, 17 Jun 2022 09:20:58 +0000
Message-ID: <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com>
 <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com>
In-Reply-To: <YqiAY689pOJbHKUd@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9NTBjMzc2YWItMmZhNy00M2YyLThkNDItODdk?=
 =?iso-2022-jp?B?NGJkNjIyMGExO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjItMDYtMTdUMDk6MDc6MDJaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf139050-0599-4be0-e1ed-08da5042b05b
x-ms-traffictypediagnostic: TYAPR01MB3856:EE_
x-microsoft-antispam-prvs: <TYAPR01MB385664F7A4C1D8501136947C80AF9@TYAPR01MB3856.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0n3K9AbyPo8CnC16G7Bvi9DT46mr6GhxvHrTH4B49t9OR25jqaKfEq6VAL9NtptzWSzy/x5TTALrwe1bF9i+5se8MW+zZJN7Ji/Fv4/XyRzeUxPjzJzUetGFbplMK8AV1vUFuQG3m2zur04Tl4CAI4x4zKnKFTuwBPSTF7uAheyu5PFvsO/A+7IS0CLk8w9Kd/Fde2pXH3Xpctvh+QPPiWPrH5p3TveW+yt7UqXFL6NC6KIqTjVU5Ayc5WVTJg0awuZp86I5+T7eeIPt1rA4UdPu+qBsFwVyK2vDk1yFoKr5BZtty3ArQL44mBIFSAc0C9GUFGuxl46PISQV2pO8hhejqjvdMJ+qcsKx1PktmBYFVUzNt0+Zj7wJy6IwtY2UwxTkLsf3ArZZRMa1K04QW+U0D9DVaJ2QQfkjLMma5RqgixOXEAQjrhlpjWspoHPFB07jjMx0f7NcVjkvXbjXjvGnFKghWAggX0wx7RbLuISnRway3OFT/ORqT4YH+/4RsOsAoF7OhgWpZqDpY1FakfvuflkUPK1wYoW14oy1T78xbHUSBOj56nTtT86sGShM4S/7zmZ0IdTbkN4NYVtSiBtJ0u5JuixVcDpQ1DSaMD/L+HpXKxKfAQkm0tz57RA4wzSBuQVJlj2V4UU1sRRuZ5Hx1yRmPNz5wkdveuo4S4aAQlEkgjW0hwNm3eWzh6pAVooLsERlpO3KAkpot4SL31Qwyf1nBkJk78WujzIV/7rSGrrgdg8ji+VgUw0+ecbmBWUdwqjsBVxxvQWdP9wWjP81ynw1C6WWDPavNIQrzaI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2042.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(316002)(186003)(86362001)(7416002)(5660300002)(82960400001)(38100700002)(52536014)(8936002)(122000001)(2906002)(8676002)(66946007)(76116006)(4326008)(38070700005)(66556008)(66476007)(64756008)(498600001)(85182001)(33656002)(66446008)(54906003)(7696005)(6916009)(6506007)(83380400001)(55016003)(26005)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?S1FoLzVXNm95RjN1azlNZCtXQ3FJckFxdlZ4M05lcnFnRnBJREhXaFow?=
 =?iso-2022-jp?B?MXZHWlpvWWxNb3l5Zzh5ckhDdi9hcEdiWEU4QnhkREErZEVCd1c4clF5?=
 =?iso-2022-jp?B?bFl6N1A3UEhjcTJWWXRLTjBEN2E3UHA0cXZvKzc1ZERXWlVmaDlKakRN?=
 =?iso-2022-jp?B?YU11aEFRZGpIamUrcFZ5UzBaUXl1SmhEZDBKaXR2VUJJWncxazQ3bTRZ?=
 =?iso-2022-jp?B?MGJqdUZ0bkdmdlZZL0dFR0x2Y3VQM3QwMnUzZFZnVFlDeGl1dmNuYmVo?=
 =?iso-2022-jp?B?VnpKSWZ0OGFkTWtvV2pVQitJZnY2Ujgya2R4TUdnWGk5M3E4QkVOV05J?=
 =?iso-2022-jp?B?blNaVHQ0UndqSWVCSnpZN3RSRm1XclF1aENQa2pkTHZBNHhGQzhWdDdX?=
 =?iso-2022-jp?B?ZDlqRmNtZ3I1VDZuNS9xblpFVHZDYmRtRVg1WFVOR1hZV3QxYm42Sm5N?=
 =?iso-2022-jp?B?eWpsWENuU2FZOExOZlJKQXNNb0hoS0JlaU94SHJnV0FQYlFoVUlhYStV?=
 =?iso-2022-jp?B?Q2t0azYvbEJtVmhWTFNQTFFKblV0M0I2Sm5jSDNwRnRRcFFxVnB1ZGow?=
 =?iso-2022-jp?B?VjFZL1JFL2tjbGxUNzJEUzFYRG1nSDVkQ0lyTVVHMEs5L2dxQ1RuMEpH?=
 =?iso-2022-jp?B?TzdMeTBaaWl4NnNuUXR6RkdZdTE0RzFEWmRiSEo5MC9uT3ZCWll2L0I5?=
 =?iso-2022-jp?B?b2lVU2s0dXJiTjJCU3ltcTVsKy9WMTFWbFJOdWRkZERkMWZKZENuYVNH?=
 =?iso-2022-jp?B?VUd0WkpKMGtFamZrYm5aVCtPazNaKytMYXFVcjcvSDN5RDJqNkV0bm9I?=
 =?iso-2022-jp?B?Q2s2MnZPUmFoOUZQbi9STFFvTGFodzYzZjhvTWtqRVRkQm5JRTBPRERF?=
 =?iso-2022-jp?B?WldYOWg1ZDhEazZITXlBaFRQSEJUQ1ZvZWgzdnR1bHoyMUhVNW5xNGlZ?=
 =?iso-2022-jp?B?Q0xzeWdEQlZXQ0VaWXd5Y2M0Qm5kUFJZK3NQbXduTU9ONC9GNXQ4OVdq?=
 =?iso-2022-jp?B?TDVuMHd6VkZVejZVdVV3c1JCRldmRGFNZ3FsNjFOWW1PRTJSRVFFKzRB?=
 =?iso-2022-jp?B?SHJnR240MFB0NGhPNWlCUGhPa1NLeW5ZK2ttdi96a2M5blBXSVNjMGhU?=
 =?iso-2022-jp?B?OEhQRFBzeVdrYlZCd2hrb24zL2tBaGViUVRHTjcxaXZpMVMvUjhRNW5G?=
 =?iso-2022-jp?B?Tk56QVcvZG9yaUNBZXAwVFYxdkFaaHdzejVmMUd0OHJtY0ZHaklFZFhE?=
 =?iso-2022-jp?B?TmRxUDI5akN6djdNODdLVnQrdHlKRjUxUHEzRXAwV3FmbVJDeFl0dy8z?=
 =?iso-2022-jp?B?Qm5wRWZJUGw0Y1NwQVQrS0dGek1IV2ZKeEdkckorT1ZtTU9SMTJ2MENi?=
 =?iso-2022-jp?B?WDVYYjRoU296NjUyQm5sQ2kyV1F5bHZFUTY5QmVhYUp1RXRtUTYrS0Rj?=
 =?iso-2022-jp?B?bkhST21ZbXgrTm9FSlRWcTlLalU0alBVdnRqREkwbnBZdGRWcWxpMnBs?=
 =?iso-2022-jp?B?KzZkUjhRYWJrelV2TGdKYmNwUXJFTEFGdlozRFpJUFo0RlY0OUE1OFJQ?=
 =?iso-2022-jp?B?cWhaVkFNWUtQRWZ4TGxpK1NsSmMyUHk3RmJyK1ZJS1NMTjVQbnhoWGsr?=
 =?iso-2022-jp?B?SEZUT1duNUwzR2J1QlZ4ZzBqV2xLTDhTejNSRElBZkJIdmt5Qy9ITU1z?=
 =?iso-2022-jp?B?cjQvM05abG1qYit4UmtqZUNNWnpNNzRDQytsdUUwRjRJWWxxNjV2Nlds?=
 =?iso-2022-jp?B?ZmVKSUdOSnlRSTNTSTN2ZWdKZkxHbEtrVUVjQTdYUHVUNWdOQjhsQjRu?=
 =?iso-2022-jp?B?RW8yMXE3eWsweXh4L1hRTnVoRXRtSVZXREg2WmN0V2hvWktlbVNKOVFN?=
 =?iso-2022-jp?B?cmZhSys4NjZrSnlNeEt6YjhzY2ZNNG41YUh0NVJiOFA4ZGhkZkNURjhZ?=
 =?iso-2022-jp?B?eWxjRllqTUE0WUtzR1VTQ0NtN0RMK3NIeTVRa253Ymh5b0RzN3Z1SWtB?=
 =?iso-2022-jp?B?d25QdnRBL29HblUwQ3I0MGNtUnZqMCtkUktJbzUzb3BscXBDUlNIVVpi?=
 =?iso-2022-jp?B?RnlJQmlYekhLVEhrb0R4R0dENVJsMGlFSnBya3FITmNrTmFmNXB5UWcr?=
 =?iso-2022-jp?B?bXk5V0k0UVE2TFhQQXQ0TkEza25RS01vNGQrUFlIZE1wRFFKVkZJTytY?=
 =?iso-2022-jp?B?UlluaEhQUmRqUGkzbVBHZjdGUlJsUzZodnN6TWh6b1gyR0ZLbTIrLzc0?=
 =?iso-2022-jp?B?T1NZUEllSnlLL1FBL1dRRzgwd0wzWWpQcVBPYk80QkdsK0c0YXc0aSt0?=
 =?iso-2022-jp?B?QjZaNDhqd0dnUHJHRk1rSWJpbUVYK1I1b0k2Rk5WZHdSaWpYWGk3OCtH?=
 =?iso-2022-jp?B?K1N0cndvcWdlazRrLzlRblczbjZPN0o3L28zeDljcmlnZE1jTFFmUU9a?=
 =?iso-2022-jp?B?eEJIMmxuTVRQbkJrWVhsajRTUHVhaFdybDJxejBkc3lIcGdFN3ljOTJI?=
 =?iso-2022-jp?B?YUlPSU5ESTY1enpHamRMRmZySDU2d1ZydmdMM3ZMSjB3eXgwNmhWMTJR?=
 =?iso-2022-jp?B?ZmpsSVlmND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2042.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf139050-0599-4be0-e1ed-08da5042b05b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 09:20:58.2596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TW7RGmN584FOcCMbCIerec6QdL2s3w0sGkiC4UrXjoAndEi5aV3S0s0QJ+Iu2E6W6JXrdSx8yEYFZUI/msI9GRBrebuLayxm9zBXgm0Wg1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3856
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> That's not ok.  Linux is a "general purpose" operating system and needs t=
o
> work well for all applications.  Doing application-specific-tuning based =
on the
> specific hardware like this is a nightmare for users,

Hardware prefetch behavior is enabled by default in x86 and A64FX.
Many applications can perform well without changing the register
setting. Use this feature for some applications that want to be
improved performance.

In particular, A64FX's hardware prefetch behavior is used for HPC
applications. The user running HPC applications needs to improve
performance as much as possible. This feature is useful for such
users. Therefore, some A64FX machines have their own drivers that
control hardware prefetch behavior. It is built into the software
products for A64FX and cannot be used without purchase.

I want to make this feature available to people who want to improve
performance without purchase the product. This is limited in use and
depends on the characteristics of the application. Isn't this match
with "general purpose"?

> and will be for you as you
> will now have to support this specific model to work correctly on all fut=
ure
> kernel releases for the next 20+ years.
> Are you willing to do that?

Rather than relying on a specific model of this API, I want to make it
generally available. However, it may not be so now. I am willing to
support this if I could make it a community-approved interface.

> Then perhaps it isn't anything that they should try out :)
>=20
> Shouldn't the kernel know how the application works (based on the resourc=
es
> it asks for) and tune itself based on that automatically?
>=20
> If not, how is a user supposed to know how to do this?

It is useful for users if it can be done automatically by the kernel.
I will consider if there is anything I can do using statistical
information.

> What is "1024" here?  Where is any of this documented?

This parameter means the difference in bytes between the memory
address the program is currently accessing and the memory address
accessed by the hardware prefetch. My document in
sysfs-devices-system-cpu does not specify what the distance means, so
I will add it.

For reference, the hardware prefetch details are described below.

"https://github.com/fujitsu/A64FX/tree/master/doc"
    A64FX_Microarchitecture_Manual_en_1.7.pdf

> And why these
> specific sysfs files and not others?

I wanted to show an example of changing only the hardware prefetch
distance. There is no special reason not to specify with other sysfs
files.

> If you have no such user today, nor a library, how do you know any of thi=
s works
> well?

The prefetch control function included in the software product for
A64FX does the similar operation, and it works well.

> And again, how will you support this going forward?
> Or is this specific api only going to be for one specific piece of hardwa=
re and
> never any future ones?

In order to make the interface widely usable in the future, I will
consider a different specification from the current one. For example
control groups which Linus proposaled is one of them.

> So you haven't tested this on any real applications?  We need real users =
before
> being able to add new apis.  Otherwise we can just remove the apis :)

At least, some A64FX users use this behavior. However, currently, I
don't have which applications and how much performance will be
improved. I will try to get the application actually used and confirm
that it is effective.

> Kernel programming for a general purpose operating system is hard, but it=
 is
> possible :)

I will try to do kernel programming for a general purpose operating
system.
