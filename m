Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFCF569307
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiGFUG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiGFUG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:06:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8481C92F;
        Wed,  6 Jul 2022 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657138015; x=1688674015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OsT7+iFnUFxBTwPoCbsG0Y3dbWn3BHOnQ9pa9U1NbDY=;
  b=MJYip3nHuiQo5MSH6crjDtQRAOgUKHmXE2/MS0FBIivOjHQ1Nict6W2+
   XyKslHrm82iQIuV5g0UCojH2l5od4Z4mTWsRWEzpWWS5wzHgs8+p1czYr
   Os1n37OxE1zlKGaqZi+0CvOLBTbIlod1svDnYHmm3buDWBN8C9dvc3dQC
   R8ASX673xYN5BKfqqA3IbR7e9VLB03EaM+eTtdD5wPqsSP7Ranxd4Shgq
   EkByQtNIk9cpO4T6sWlNd77pc6ZpKwGIwLjGbjNObFSkV0UNgtEKsRwCM
   mMFxGXQ9apgxSZb8uTzHaEZwaCG/RgfYuI50oJyfkMnHB31CmYtGChrrl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="264273730"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="264273730"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 13:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="568215524"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 13:06:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 13:06:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 13:06:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 13:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJtCw+H+PoPAdT7ttFc/gWuwQ0kV3IAT4kyXH9T1c4dz543CDIk3m7VhxmxbInqOl2WLYviTV4c2TYovU7v6nueGgmLMy2CktKZngXO9TKFFAfRtxNH/g5D29V8DOhw57M+TGU6gx4llGeQz9kq1LRjJE+Ij7EVrs8ElfY/fJ9yGdIcXp80Woqs3h/dcrYlFelXgoQY58+uf9mMXCPwgPAa0hparmuXuKWhHQskJSmD4ZLFD3B+XgTEIsWCdjD0TW0+Up09o5HTr3WdZMlPy0RoIhmyriIHffqLJ+nSzdU+yCjTU1dt/DjmIzwdqyvEEOx1pnrSwJTqSh46WVbjY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VXeyh/mAd/IsUQuYiPNdP2keUkS8z4h4dFKoAN8meI=;
 b=Fji2UtkBhtaVcKqqX1a9+z8NwSvLcdSGKZsrcn04myoMjBInViUHPM40Sxf5rcOBC9VN/D3X0soO53mQ177XtjD0ipW9XCawYGwF5ZNCF1eq6nv/EEj4+Q/rI93vTNXrLKMGkz7b/uMlGPYzk8d7QbldRK1qyFTB5jEd3me4pLBpNqNNCMG+fgEI7T0ZDDRw1Ij38odIvJhShXmdxXPKNmZ/gvLvSQKh+j28spVg5A+5AdEJSbcttTYElFjCu+sHMf2Io0ssDrQFb8gUugaEoMGC/SFUFQJrYOMYKOatPnS1j//UJyjhxY072WLkcYFsgJYuW+wtifLH61yqHBed3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 20:06:51 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 20:06:51 +0000
Message-ID: <d318e4d1-fdf8-e6d0-8dec-bf05c4e9aa59@intel.com>
Date:   Wed, 6 Jul 2022 22:06:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v2] Fixes: 1ca81883c557 ("ARM: dts: at91: sama5d2: add
 nodes for I2S controllers")
Content-Language: en-US
To:     <Ryan.Wanner@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <nicolas.ferre@microchip.com>, <alexandre.berna@microchip.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220706162144.66831-1-Ryan.Wanner@microchip.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220706162144.66831-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8301687-6a21-4458-2ca7-08da5f8b109f
X-MS-TrafficTypeDiagnostic: LV2PR11MB6072:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXfSpMw3Djz0JN23ZxMuYD55983Xxu5vmlUV/gEm7r7d/JuKTAC4IdUQlyqrOQM4/EZZDHvF1BCW02Aoe/zXx9b76bmIYZ9ppSd21flBCj07H6MkIRt+rwaPyQ7vd2YdXVzG56AbeVkIbTTj2oDwhYqVvYj0Ue/hRon8HhKCSFHnYBs/a1Zp8jr62o3MhRjV7jZ5iQhQ9QKqq9PY6QwqCh1hNb+lDE+XU+7bTpNVq/yW5LFj0Dux/8XTYLsPW3UrpebZgBca0F4w+GoHD3Hvpm8DnR4NBbBdkQN6xrOMG8qoz9zNJGaz7xWu0VW01Uo5uaivhUMgIWcr6KvBDDulR03fEOxJrAopondmLAuML0eFggNVCpzAYqg6u+bEbs6/24cNIEUKT6g+7gWGmgRzhSR5s5OmHPnYxsBI8vdNAMOkSnJoa/bzDCMq5uBmffNL0LrhmZYAmH05/s5KAHypvceIW47EA0pNWhDesI3zr9npfj1VWEfx3+SwJR4K96g+js6HA1Vm5O64Nd1BY7kL4BiUJJxnZ3sqAVePQ07taJORQonlqsuA6dmoN3Q+o5HmHNZSgeFa72lyJvT9egyHWf/IoWiSNiVsSDvEgxaz5zcKnSpjrpB/qaP9jXR3eBKlFO1apNPWZpRyzu0wLAk1OwM3xoVvNY3KuMD1tvOoBKjG3j0mIeeUCLFwMXb909b2YyjxR51CQ2qB02+D11ycZzj7uW6N/oBJhxHGUQqZQyaFvcbHh7g6hjs2FezZI29R0Sgynh4fqdmC06rR2YTRB7DEq55IwcGUY5BuVOg8lcD8KtpPPhdlx6VjYB5r1Wo81ZHzvHP/y8pF0kjSB/1PTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(346002)(396003)(2906002)(478600001)(38100700002)(6486002)(82960400001)(316002)(66556008)(66946007)(66476007)(4326008)(31696002)(8676002)(86362001)(7416002)(53546011)(6666004)(31686004)(6512007)(5660300002)(186003)(6506007)(26005)(41300700001)(2616005)(83380400001)(8936002)(4744005)(36756003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtYL0RaaXF0aVB6RU5iZlBiaERuZE1INk1pbUJzVVYzZkl2cHRaODZwKzFT?=
 =?utf-8?B?ek90RFVXNDd6K0FWL3BnVGQvM2t2YVlQbzFuejNzK2ptTUlrYTVZWVhoMVhV?=
 =?utf-8?B?WmQwLzZDRmVTL0xDNmhINisyN0xQUTZTTVlkQ2oxai93R1RoajZoaWh6Q2pW?=
 =?utf-8?B?QU5VTTRnZ2F2a2I0MjJRZ0tyZklZb0MyRlRCQnFQQmJheFM2bzh3SjZ2K0xW?=
 =?utf-8?B?b2hvR2J0eDBTaTdSdExEQmsyVElTQitQTzVRZ1IwN21HN044dUxmN3Q1bVFp?=
 =?utf-8?B?TFBOYUQxMUFzNjRQaldDeEZ1aGFXR2lSNWlaZ2ZoQkRMd2V4OW5nNTdPTk1r?=
 =?utf-8?B?TEhycm5iQWh1dWpsOE5wOGI5T0ZiRUNVdVZyNXp5NGp6UktZdGtGenJGN09C?=
 =?utf-8?B?YkNqckVIdlBsMnBZTVZaQkR5b2JRSjlsUlp2cUttNHlsb3NjcjhNV3BZK3pw?=
 =?utf-8?B?Tkd1aFNrUUNsMkVFeDM0U3dJT09qMVRjUmRyVmwzTk5BK09OSDhoTTJ0bUND?=
 =?utf-8?B?S2lGSk42OUI0TWNLRGdhSGszWi9MdUJKeTkza2xvNFk0UnI5R3NIdDVGMElq?=
 =?utf-8?B?SVBjbXd2L0M2ZW9ZQVFjS2s4U0FUYXJRTWZOUTRETndpL09IeHE2Q1M4ZGY5?=
 =?utf-8?B?L3gxOGxUZWlCcUMzWmVCN29LQVhmMlVWdkNqajEwR0ZRSFNEdy9yZGhDU2U5?=
 =?utf-8?B?aUw3Sk5YYXlNL2V6aW5iQWtONlRLT0ttZCtNZEZRNnozZ0FScEpqV3Yzemh2?=
 =?utf-8?B?V3VPTUN2Y2p1RlNVcHJ3UlpNeThXeVF5UkNiRS91NkRiL3BZeUdSeXdONlJr?=
 =?utf-8?B?ZG5hNkRNVnh3akFhSGIxTkNJNDBCbktSNlo0VVBza0ROdGpYbmFYZTZKa1dy?=
 =?utf-8?B?TjA5eUx3Qk5FNEZjcnEwM1RvRGc0MjkxazNQUEk1NURDVEsxOSsyUWsxSE5L?=
 =?utf-8?B?ZGIreWdnc28wRlZlUW5SWnZpNkkyMWVxcTRtdk8waHlhS3d0dG1zVTM2WUw4?=
 =?utf-8?B?amEzL2IrbTMxU1NVdnI3TzdReERLSVhuRVJ6U3VvaU4rT0FGZHdBaENTUEVo?=
 =?utf-8?B?OWJ1eHNNYUlIeUVqNzJObjNaVjFxL2Y4ZUJ4MkYvcE9XUWMvdmNqckJSbWxj?=
 =?utf-8?B?L0hFQTc1U3Jsd1UyaFRZeGluS3JPenVmSGhEcFh4bDcxWnBtcER0TmlIZk8y?=
 =?utf-8?B?MkQvWlpFZlorY2hMUHhKTmNVRDdGY0hrTnlnZDdQSWYvZ0VHbmVZMmMrTW13?=
 =?utf-8?B?a1hHRDVUZ1diNmFDWTJXQk56eGdnMGVQVXhiV3k0Mmdyb1JyUFFnekdsVjZT?=
 =?utf-8?B?N1lBQk1vTlVTOWFBRitoQ1ZKMnhLTTNsY0FEZ2VEZHJ5S00wb1h1NStQZEp6?=
 =?utf-8?B?RXMxck9KbTB4NXRjeWhyUW5uM0lJS1Nvalo2Lzd0Z29nVi96S2o0UUlEL1hF?=
 =?utf-8?B?cWJhNUs1b09tczZhSWhzb2t3WmE4NmhDYjVXRXMwd1FPbnJyTEt2M3VSWGE4?=
 =?utf-8?B?SW5Ba3JQazZ3K0tYbVAwZGRqeWFUMTZPekpkZXVINktFYlp3cFBhU051Vis1?=
 =?utf-8?B?OG8xc1I1a2NuS2lwVnE1cTN2Q0dkdFJIQVpnL3ZTbHRDNWsraUhIcDdGRXdY?=
 =?utf-8?B?K1QvYjFveStIVGxXY1F0T2UwcnF3S2U3cGpTbGFCMk8wLytTUVFrajF1NU9q?=
 =?utf-8?B?NmdnWGJiMnU2cjdQTDY2cEhjN3RPWk8zWU1hS1VoNDRRb0UwbzA1OUd1RU5z?=
 =?utf-8?B?enlHQzdKTTYybXhMZXA5OTZUVW9FS3lhcVdlSjFBdUlTNmxMSEprVS9xd2ll?=
 =?utf-8?B?UEF3WXVjVFpSTFBzak40UFVQWHJSQjVFaWdmb3p1QnRXZWNyYUVHZ2p5RXA2?=
 =?utf-8?B?SnpxV1VhWmR5TWg2TmZZLy8zZU9uNzExN3RWMmZZTHNkNElmdjBCcmMzWGts?=
 =?utf-8?B?dG9uaG9MSWtDbkZ1cDV3a252N3hQU1BPT3RFaGxXcVZ5eFVnNTdPSGFvR0t5?=
 =?utf-8?B?NFRvMTlWZzdKV1czakdMMjhDMzhzUUtTd1lydndrZlpoUXFVNk84NWFub1I5?=
 =?utf-8?B?b24wNURrMGc3YnQ2clBwa3lOL00yaHpDWUNNamVDQnF1SG5HRDBZczRuT0M2?=
 =?utf-8?B?U2M4aE1QN2RrQ2UzUy94bXlMRkJLdFpaRVdWRVY0clZ1OTBPTHh4UFlScDZh?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8301687-6a21-4458-2ca7-08da5f8b109f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:06:51.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYEEZMTrBT7KwILnPMqGnOG6o32rRxodnGfMnPl9tLKTDJYgbnpoxpv72zZueLS8lSn7ppm2OlKEtTrtZMJNg4ggGhtr77kAk8dfB8rGTm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-06 6:21 PM, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Fixed typo in i2s1 node

Perhaps this email got twisted by my client but what I'm seeing is 
fixes-tag instead of a proper commit title.

If that's really the case, please reword your title - Fixes-tag belongs 
to the tag area and should be placed before your final signed-off tag.

Also, as commit message is _not_ a title and is made of sentences, it is 
expected to have each end with '.'.
Another suggestion - nothing is "Fixed" when patch lands on the mailing 
list. It's just a proposal until it actually gets integrated by the 
maintainer. As change targets _current_ code, s/Fixed/Fix/ is the 
recommended phrasing.


Czarek

> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
