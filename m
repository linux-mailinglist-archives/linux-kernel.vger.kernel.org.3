Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A215338DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiEYIzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiEYIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:55:43 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A044A6EC47
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653468940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTR9Yx/HbeSF5EVcNf6OID05W1togWox6q4GWfB34ks=;
        b=WpSEC9ita79QjAzK/rqDRMbnyyBDz2Jnz1CySWuKlow03Ui5RkZRYwkpfi9/RNBXV9wIGQ
        NmW3utQcvD5r3Cx3AuhE8lDh56b3UD+aM9cHZg5cWspBYeAkhdkKaBSHJcGhDDWFskzcGE
        gWM/21d8HjvBQVWBWBw/RJ9qgY+fBHs=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-0tnFSb3aPIejMTwIfyS0Xw-1; Wed, 25 May 2022 10:55:39 +0200
X-MC-Unique: 0tnFSb3aPIejMTwIfyS0Xw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbAUAAaK87wjQJSEh8TQ+PhDvqKgZGWOzZqeIdYNCm/y4IfzlJgY4iDlJAjlaoT1s1SYQKeDCV7pi/V/Bap3LPGVDPPfnZb+gx/Kq5V8nlnKK241TeJRuHG4PFMYvuKOPzFLmJvk0hsOM34bZIolUng2O9VTJPxZbiqY/Tj5upkUouVomFREZxU0XJXYEmuwkzy9wjV7caxNnNcOFS/Xlxr5Eas/CislUPdk9T4/miSndqW/Jhf9mWbwkriZZKHTuJ2kt/Lm993oMWuOM1Mcvybaqx1gkFj7w5Ybm4Gcx++/A+ea3OOco9v5xOs7H+OByMUxX7jcStkZYnHDLmMZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTR9Yx/HbeSF5EVcNf6OID05W1togWox6q4GWfB34ks=;
 b=YHxXvqOxlA3/YSD3IMXG/nEAOX27ZGC5sPn/R6TsRUp9OWVUAeWobcill3xAOhqSOPZYJiFKY56BueaR4eUgaOdIOmmYZ2iEz/wGX7lb3LWlPznQc7L8YcDocLwhfLhkxG9wonnp6Wzcnneu+5D9HXalpECPTsF3PVAHBIvVaXJ2xtfxzIiY++IT5W8Wiss6c6F4wdvCa9k19Uie+wSxPKqi709h6mp+9tsstSmA3tQLlkfYOCO789qd+tZKHd24dl7Iy/84RKU9gZb+inhn9SNTI4WFf0GfNaRIsHdtOvjU+DNNnRNX8O/IA/Tb9BYqdplRGNyGh6vpCIQOGnnRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 08:55:37 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b%7]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 08:55:37 +0000
Message-ID: <dff7bcd3-affc-9272-81e9-d686d9c997d5@suse.com>
Date:   Wed, 25 May 2022 10:55:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Ping: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Content-Language: en-US
From:   Jan Beulich <jbeulich@suse.com>
To:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
In-Reply-To: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::35) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 980393e4-9679-43a8-3e59-08da3e2c5640
X-MS-TrafficTypeDiagnostic: DBAPR04MB7382:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB738247A34414E04828A581F6B3D69@DBAPR04MB7382.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fN6VQqSkdIO9q8AdEhJJoj7HsjnUN48LHgH/JnSEiF57ZDa8p12ZYXrPFL8Yfb1LmYx/XQLo46H8I+hzEKjeO9Ns6Fu9Lyi1LxB5DTnr1HkNvoLHHS6RXx3ENi52WfSHmmD8HYkVJqgL6sq8lQjx9G7U1xcWX9q6+6jkoAkG3LJv5hy+odp/7NrOrvaL+321np5VZwSYIaV2tZmR4s+vwLwSIUJaowU5IHO6vuzWzp40BTBArKL4193gPCWE9kBduKj2ZsUiqL7gLbWzFYL4A1+lew7btMufN/3OijPcGItXJ26MQTXeFIie/pJWvgghCas7hVDDlrG3xiYUZp2a34DyiXaL4242ixfBBCEK8jeJS+UhPJW2Ikxqfzvg9hFoelYdN/Usfy4qNP8OSmrDI0rQcRDGTyl4UwiUK7cobEMbyxRQupSlashf1E1KO0MiGk4JOJoaZZzJZhzfRvqY8fkmpUpl4hlKvaZHz/fhsxDMSUISrFk7UJl0+xrojfoc4uu6dJpuFTFCjPEdjexl17GVgCXRg3aiNwGMKrZt1zW8L7U+6s02QlGoPqlJY5iPwY5FQAVvRMfMhziRTGOdC7AYlzUL2aD/hpzf8W95FLy2wywL3CaWbOXpL2GB45giHI4fXdNoLP519tAx15pHiAh9s035uCxUr98VIl/l++QedZJRK6DsWQLFQr6ySbLqVoctDB+kjUPId4cqIEbI6emOwhuAypZMsH62DDSpaAHE+KHbDZrJ1aXBVhZu593I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(66476007)(186003)(66556008)(38100700002)(4326008)(66946007)(36756003)(8936002)(5660300002)(110136005)(6666004)(6506007)(54906003)(316002)(26005)(6486002)(6512007)(53546011)(31696002)(86362001)(508600001)(83380400001)(8676002)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUZIcDAwWUJUdytMK0FVbjA3a2w1NFJsSmF0eFNkNk9hcjVGVzJHUEU4Q2VC?=
 =?utf-8?B?ZStmcSs4eG00K2xuZGFlNktIWXZkT09hRlpxUG9GSmxuL001eVlhUVo3MUla?=
 =?utf-8?B?ZjVHNk5OOXVqenVQOFZZVlExeHJlcCt4WEpoUytjSXhlYk02OHNTL2JHdysz?=
 =?utf-8?B?SDI1ZkxUdmFpWm05UkpSTUJWeDI1SFpHSzRLOU1oelR6eE4vZ0YyWDV1a2FR?=
 =?utf-8?B?TldSQ09xMmtNTGVEL2xqMGdVVmtrdlBUWUMxRDM3UFJZdXJhT3NqdmRSY2NI?=
 =?utf-8?B?U29BMmxQcTBBTm9CRUtWSnJmblMzZ1pyNXdtQlpUVVl2Y2FJa0I0YVh6QUxK?=
 =?utf-8?B?dytPNk03SEF0VjZSekpNUitiZVpEVlRDNDg3d1ZYSDhZcGR2NnBJWWFGdlhz?=
 =?utf-8?B?RGFhRmJ5c0lrZmZ4SGxjVXNMcmt3SVVqckV2VWdobWptdzF6ZVpiU3E4UkxL?=
 =?utf-8?B?NHZReEY2K2JUMmgvc0FrNnFzWlhweSthZzFZV05tdUpzSENYNXhDN3c2bDQ0?=
 =?utf-8?B?dldRcGtYdFo0cmgycjNtUUdXSW5vNHAvcWNQaE4vRW9BRXIwLytQVGMrSXBx?=
 =?utf-8?B?OXd1NWxCS0ltZ09CaFFPUUR2Sy9mcU81cVp3Ny8yQ09pZTNNbVBWUkVtV0xo?=
 =?utf-8?B?aDIyTUV6dWZkWmQyc1E2Z0xjb0VmVi9qUHlWTFhpMWVOUldNQjhmSHk5RXpF?=
 =?utf-8?B?RitUc2xyaXp3NS8rS2EyU2dFbkVFekpMY3hGV3FFZFFYRTRaclp4NjBHcWZN?=
 =?utf-8?B?VXVhc0pmb0J3dm1uK082bWNtR1BXMnZ1M1VEZGliL1ZIZ2pyeXVSUDF3biti?=
 =?utf-8?B?L2JmSGZWK0dYVUlOSmRWU3BQdUdHclhpZ2lSYkJBTGY5UWFHVHExdmdlUWRv?=
 =?utf-8?B?Y2xtcHdDOGxEODlNWW5kWi8zTENNdEc3dFFDUVFsOVhpZDFBLzlqY1RzeEpj?=
 =?utf-8?B?cjRhOUUwK09JVXlqaTNGc0FnRUY4U1lHZW9BV0ZRRmlMSnI2ejRROStOdjJO?=
 =?utf-8?B?WUl2LzRsWFVGaXZkbmNUUm8vYmxOdERDditsT3pQdFlvQWh1NGhxd3g1Nk1y?=
 =?utf-8?B?eEp4MjlHOWhja3JRVytTUmZFeGI1OXExdTVUSnJiR2NTOHR2d3ZhejMwQ0xB?=
 =?utf-8?B?M3NZdjNwdHJKcUpwVjBaWEg3enZlSU5saTM0UEFtYVJzZnVQaVk4aXFGQTZp?=
 =?utf-8?B?UDg1Z01kZTJlYjJQRzUyQm5pOWJhU2I0RFFtN2ZlYk9SRWZaM2FUd2ZQNjIx?=
 =?utf-8?B?bnB2OFVzZDJQcnNKaTZKWHBSUVhQbU9mWWgwam1qVDJ6WlJOdUloL1RrOHJK?=
 =?utf-8?B?YTJ3bmJubzZrdzBBV0U5NEphQU10aUUyczNWUmVlNzNNS1VZQVkyT0VXZFJm?=
 =?utf-8?B?QmMyOUp5ZHlhd3M3T25zOExFdVF3cU9iTTFJcjdXbXBVMytyeGFObEk3dE1X?=
 =?utf-8?B?V1krUGcwdWdtSVlQb3FVZkQzMnkrZnNtQUMzMm9EQUJpYkF0WVlrNUVPUzA1?=
 =?utf-8?B?QW0zUGFhUHJVcUQ5VGpoM0Q2NmRZdEM2STZENVRtUTNUZmV1a3BUOHJYbk1u?=
 =?utf-8?B?VVN0YmFSWC9UTzBBNGQ5b2VXcHZlaGVrV2VuV2xBUUloaHB1UzcwcVhxTXI0?=
 =?utf-8?B?REU3cFZtZGVHeE9nUFdGdURiaFQ5M3BVWkF6R0dDeHFScVBoZjNwcU1iT2k4?=
 =?utf-8?B?c2lZRHpyenNhMXowS2ZyeGVzaE82dG0rcnkxUFVnQzNnWXA0aW5vc3BuQWxZ?=
 =?utf-8?B?aS9vZUtsVzk2Q2FUR2FLaFhObW9YczhHOGdaMys0dzlaeDdPeGQzYTBReEtX?=
 =?utf-8?B?UlZvREMwZVE3d1QvR2ZNaGZUdDkxM2hQZnMrWk5Kd0dYUTZqVjNPaFNtOUFK?=
 =?utf-8?B?clNYK1hQYnNrQ3BBWVgzeERyMlJvS3pEVnZvNU8rdjFnODVOMmpVYWwxWTVN?=
 =?utf-8?B?d1lqSk5SN3JtWVlzY2xoUG9QK3RPNGlEUkcvb0p1RUI0TnBhY3ZFUzY0KzRM?=
 =?utf-8?B?THJ6SjQ4OXNHOVJ1T21KQm03ZEFqeDJaQ3JXUjVnUFdQMHFPTDdsZlQwSzcw?=
 =?utf-8?B?UUc0Zms2bDU3a2VpaTJsREw2d2NjeGhnbW92Zmd5bVFnM0xXZ0Yrdy83Vklz?=
 =?utf-8?B?YjRRVlZVdjdmcUZpME95WEgzZi81NVpFNW95T3dFd0tOZ0t1ZDViMWphYllj?=
 =?utf-8?B?clFpcjJTckc3T1BHMXJSelNpd1luTTdNUHg0a2kwR3VtbzFrcjhlRHhuMmdi?=
 =?utf-8?B?TVBtc2ZlbVAybmNkNmp5UGRlelR2U0Fad3J3UFhpWFk0ditDSGEwN2t3K1Q5?=
 =?utf-8?B?dXJVTEZyYk1sYURJMEJZcG9zbnJEV2ZEVm9aeXlmR0VjYnp6azQrZz09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980393e4-9679-43a8-3e59-08da3e2c5640
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 08:55:37.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj//y2YqhxQJpBwrApsy2m2MFexxJrHrY8cAKkLlMCgtUi/gJfs59yV1pSIbwMQIaMnYgjtjVF7OFZcV1nkf9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.2022 16:50, Jan Beulich wrote:
> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
> with pat_enabled()") pat_enabled() returning false (because of PAT
> initialization being suppressed in the absence of MTRRs being announced
> to be available) has become a problem: The i915 driver now fails to
> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
> located the induced failure), and its error handling is flaky enough to
> (at least sometimes) result in a hung system.
> 
> Yet even beyond that problem the keying of the use of WC mappings to
> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
> graphics frame buffer accesses would have been quite a bit less
> performant than possible.
> 
> Arrange for the function to return true in such environments, without
> undermining the rest of PAT MSR management logic considering PAT to be
> disabled: Specifically, no writes to the PAT MSR should occur.
> 
> For the new boolean to live in .init.data, init_cache_modes() also needs
> moving to .init.text (where it could/should have lived already before).
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

The Linux kernel regression tracker is pestering me because things are
taking so long (effectively quoting him), and alternative proposals
made so far look to have more severe downsides.

Thanks, Jan

