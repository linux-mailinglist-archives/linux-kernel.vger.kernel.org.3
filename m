Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D3458430A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiG1PZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiG1PZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:25:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E414E614
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoPJnq+Dlpu+z6KsZDGp+MBckzfbzepG5ryaFJ0Of5wcCfEWNLo8xlhWm7axWHj7NPQHAbuG88PexhSMaU8iG+IbAJGwrh8+goyhVU6Fc8pKKMr4SwISki5NjCrSxu4GOcyw5JLiv5I87ooOVJKruaXIM/wIZ785MBeF/eCxn9c1G0oyVsTLB1DxHXnPT2gFcUCJ7hozwT+ZJt0BgeBiIx13w4syepGNwqgFxqVV4MY7orYpgHBGId+B63j4tgemE4PAwU3i3VoIeBuZA+Hpmw/pMhztdqesDYJ1w/CWOMUF8ebfmi8InQnCcXrmE3iGI0KTaFW8jYKOJZC5VSoRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR7G6Uf6lFjk4WkWdvZoiF/q16SzNJzhd60JRhinaNM=;
 b=Om7SE58nfgp3fuXMEgoLwiV7pzP+XFrhEFoL0rpqTsxSbmzlfzeRy1PzcNqJHE7dIm/oyAomPSxk2ERf5ePFmrUZuCIwSqlKynFcxNdzrhz7nhDtpq51B+qNsjEfz2uRMSU0NKc6n+w16XcSol1RChHPXeRbRzgRSFS1hMX6wpJfK9VmjHNcvMk3S1PHs2XE1cEZWBthstsoDtbB/J7Q6lVI0VGjPYCWHNOtY6yTd2ROXlMnnVfO+Z4PYp8x1CNAZbYv/s5S8sptoT5N7oQv0fc802AJ7vH6WEHh+pkwRqXhV1smSVVbaFsVeXgU9Aj7u2XQdEejjsKnsVoJlM/AZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR7G6Uf6lFjk4WkWdvZoiF/q16SzNJzhd60JRhinaNM=;
 b=RZfzBh9ojidS4QqpDz3QqZe2kUhaURR6XOnVT8cyLgXxJVN8YoINKQzNFYkFV7qdWDPmycN4s6HhAo4j/ZdDtD94RmzAHh/v6EagvMgzZC369u+t1ApZClwVrtZUn51Xs6YKGXrHObNkOTD5n3y2RZbnyH9C8JoHZN6GqzJVOhLaa/PE40e6ewD3K9SH09Qyh74BfR1Qo9A6ROdczRhxtUITHI/xpawyCyh3Rxw8Uf1C6YBAMUC+ii8KcDwr8cjTkpLlYLzmJWG7ikf88At5Y67A22Q91CIQ3nfHJnaNcO/EQScyw9D0hWKx5qh5BmAjuKzSdp3AK9fzig/ztnQV1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from VI1PR03MB4973.eurprd03.prod.outlook.com (2603:10a6:803:c5::12)
 by VE1PR03MB6352.eurprd03.prod.outlook.com (2603:10a6:803:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 15:25:30 +0000
Received: from VI1PR03MB4973.eurprd03.prod.outlook.com
 ([fe80::3974:3665:ac2:906]) by VI1PR03MB4973.eurprd03.prod.outlook.com
 ([fe80::3974:3665:ac2:906%4]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 15:25:30 +0000
Subject: Re: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>
References: <20220728144254.175385-1-vladimir.oltean@nxp.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <501b52ba-7691-0263-c007-38174c7e5c22@seco.com>
Date:   Thu, 28 Jul 2022 11:25:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220728144254.175385-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:610:38::32) To VI1PR03MB4973.eurprd03.prod.outlook.com
 (2603:10a6:803:c5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35b22333-9487-43b9-886c-08da70ad6823
X-MS-TrafficTypeDiagnostic: VE1PR03MB6352:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOQQMKGOw1bKYo1F7kEt8vXpVklOv9mvUM3WtFV2YXWwQJQ+4uEU0NSBNNl8u2uP0ng4G/ISj8+Hybfm3a9NexCE7kBkvtg1PIDZyvh+sYy94iq63cQZGLZd1MkLiO3zS915zLh50weo7JPsOX50QCg/MXtGz4D4KjC+At1vaO4aJskk47Tigtw+mR1Wwl1b5BYvO1h4zxSbK5zuHIKYE+D7B1fvtscRd9x4jzPiUj3TUhrxHkYhAEFhnOyVtCy8IAWtDksDI5oB0+raheGjByRhU2BLQDrhhW4Vhx7wKEpmhn1oPa5GiD4lkINZdJnjKQtI+FXqShB/DGvN5EPbkUT6gMfh/DEwYqSSGkWgoe5McikltBdkB7CaTJN63ckoEmdPNn7lgkupZOwS9MwJSnlA9UWta+NcGEm8bgdsVq1e9WNek2Tqt3i915IMoPgu84HIPBMr5vo965s1b4yXISb4YIZ0oYLoJdOzhSOCWpAU+Z+D4TITbEm2IDCPGR9ty6LVaF9gVVBl83zu++kKMoo5oxaMU+mDMj1LFausE3pmbnfTSiqN0ZKKIIO9L0aTLqgmlwCvoLOcgdFYthHS+zEiDIzW+jkrxJ9WR2n9Zdj1dBcX1KmmEl0GZCdPGi5clnSd6+RHb6xOiWDDMSGOKJs3LRRGoommcFzGkxwEKSCNz+FG3AbOUT/IJ8LpL3AmDz6HKO248sqHxOwKbEnVJ4d7NolvHbN7u9kfBt8LBdFtm8VolADXf8LwYj2di2yRCjdRY9SMSrkdEobhRJzvEwAXiEOJFVF1DpMQwUPJnn2V6mSFSpheJESPxJmjFdB/uiVGJdrmQl/us2gvnMUbSk9dKsSN4fOf7gKESrMmokbjxn+Ngz2yRuEJ/8IJRR1+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4973.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(396003)(346002)(366004)(136003)(376002)(6506007)(36756003)(31686004)(83380400001)(186003)(66946007)(66556008)(4326008)(54906003)(66476007)(8676002)(316002)(26005)(52116002)(53546011)(86362001)(6512007)(44832011)(2616005)(31696002)(41300700001)(6486002)(5660300002)(8936002)(478600001)(38100700002)(2906002)(6666004)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTFOVWFiU3V0NDZ6WDVMaG8xeHRvVXh6b1Fsb1F6Z1BRMkllSkY4bVdpazc2?=
 =?utf-8?B?TEpYakpvc2xLWDNzZWovZlg4MklCSWxMQWNtZTI4eUNhZkRhWjI4NERPeWVG?=
 =?utf-8?B?d295d09yMWQ1NHV0K1FzeE5kYmJvL0ZFcGJweUtVU1VkZFJ0cXpWZ1dnZUY1?=
 =?utf-8?B?dlNyYms2dDdLcENidmZQSWtFdlhWSVExR1JPTi9kWDhaYVBOM0tLeS9sVXkv?=
 =?utf-8?B?WTRWS0s1Q2ZsVmY3cHF3UzBYYWl6WGJSaE41YXY4QzloenJhY1E0aHZiTFRx?=
 =?utf-8?B?a2ltNjMyUWhtWnlTUWdPSWdZR0JvcHhtc1MrVlZUUkR1NjA2eGt0eWpXbW0z?=
 =?utf-8?B?Y3hhRWVXYkRGRWozUytRSWNmKzloc2FXYnNMZnN0WERDUHAxNzc2UTNEaFJ2?=
 =?utf-8?B?MFBaVitRWGF3NzBWWTcxbUIxN1ZMRml3MzZiTi81b2g1bUQ3QkhvWGtJc0hR?=
 =?utf-8?B?b1AxMGxZSnJaVzBHaUFVL3cvNjdxQlZEdlNWSzNvclBPSkl2TVNPUUhpY2dI?=
 =?utf-8?B?YnEwa0dOdEVYNERNQ2gwcHFWdEVMaWJLdkZ5bm4wU1ZhM01sVEpYa2Y0NWs0?=
 =?utf-8?B?eUVJRXZvMlk0a3gwSHAya3hEemYrRTFBTmNKd0djZElTWUo3VU01Q0tTWVEv?=
 =?utf-8?B?dUxZNWpWaU4xcldFMVZvZ0puaFdPT1paTnhPaHFINnBnNTBGbGN6YUZwNXU5?=
 =?utf-8?B?aVdqQmUyYTJ3cHBaRkw1eWY5Q0xlSjFGMDBBTTdJaHlkQXVJOWdvcW1Qc2g0?=
 =?utf-8?B?K29tMGFxSzNCbTRxSFFrS29BMlVhQnpsZXo5cDBoUGZPWHo4dk9KVWQvWFM1?=
 =?utf-8?B?SXZDcnArMmJyV0tJcGd4U3QyNThRR0w1MldhQWFrMlQrdHF0a3BFRVVWOEhq?=
 =?utf-8?B?QUdXWC83cTJlaTBrRnpGQnFzdVN5VG9Sd2hRb3pPemRxV2Q5d2ZGZkZvZTdI?=
 =?utf-8?B?VllFQjkzS1VCL2hQQ0hGZTViNnZTOWVmNDdEanVzSEV5d2RFQjJoN0FNY2pH?=
 =?utf-8?B?dGR1dzdQY2srODFCak4vdHZpb3FXd1RuZ25QcG1kd0lyVndlTGoyVHlWdEJm?=
 =?utf-8?B?Tkgzb0p3MjhFNG1HTHp4aVcyM29xd3Y4Q2FDMk1rNzNySWk5VFNCalBvQ0R0?=
 =?utf-8?B?ZlVNRjI0YmJPTUlSbm9uMmRTakhMVGlxSG5oancrT01ycjFLL05sem5uelQ1?=
 =?utf-8?B?eHpIbm1ZTmtoMk9XSjhIdWswVWhmRWFRWDVSRHBaeER3MU82V3NwRWtteUo3?=
 =?utf-8?B?OWlSK1RGMWhvdUdqTWorR1dST3VhMTFGcS9uU0Rmb2RFNk9JSTd2NElGYkdI?=
 =?utf-8?B?VHlRWStSZ0RPcnY0QnZpUTM3TlJWYkZqR0lmZVZtaGRMMzRPNVVLU0dESmxt?=
 =?utf-8?B?eGNadWNMWlBTd05RL0JsZEN0R0RkR0Z4L2JReXRzUVBtUkVZa2xKTDNmcUNv?=
 =?utf-8?B?ZUxXU3NQU0NwbS9qZ01UeGFkVHpTTUFkTGY2WDJWUmc2ZWEvekJRWlpSUk9K?=
 =?utf-8?B?VFFrdzNidkd5UmxqU3RTTE52SWtvdGVKeFVKWkRzcVExMVRuUjJ4QnVYWTN0?=
 =?utf-8?B?V0hYZ2pmVlBOVmhGekVDSFFuWmI2SCsweXFpTitmQ1doSnVkVm1uN01zVzlu?=
 =?utf-8?B?NitGczhJWjcwMTlUVm13REhZaDIxY2txRzY2Z2ViR0Z0cXpqNzFTRm01K0dG?=
 =?utf-8?B?cUoxZUNXQ2U3VUxJWlhZamtkMWxJU0hoZjFnYXdENVFlN0dsY1hjUEhoZXFF?=
 =?utf-8?B?VUpJa0U5NEg1SWsxN2N4T3RwQmRIaHNmS2c4UXlvR2NMWEt4MEROTjNCOEZX?=
 =?utf-8?B?aEV4eldMVWpXNURrdEZ0NHA0QUVUYlRqQVNXb2k3cUZQTEVEUlcvbzB0bHVV?=
 =?utf-8?B?UmlkMkoxaEZBYW0rdGNycnVhdjdjOGpvQ3MycHpqVVpjQ0NSeTYwYUlkbDdy?=
 =?utf-8?B?Z2JYbmhoQmZoUGtMakhMQ2lvVzZUMkxCVWpVTmEwU29SVjY4S01qbncxejZk?=
 =?utf-8?B?VllNeE03V3UxVmgrWkNGSGwySUJVeEthODlaNHhsV2V5aytuZlZXUHN4MCtU?=
 =?utf-8?B?am9Oa3dRR2VuRUcydXBiZUtGbS9Mak9PN0tWVXNKNWVieVZGdnYySWY3cU85?=
 =?utf-8?B?ajIzWjZoM2FIMWdZTDUwNWlBVEZhSHRKWTU4YTFTSDRZVWVySUdPT2xKd1ZM?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b22333-9487-43b9-886c-08da70ad6823
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4973.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 15:25:30.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDtbJQBQwDPzCozHy9NcIFoh8BURETifcUTQgISVjF/4MlDjPUCvKE9p+QSoTZDOL5WfI8PEUgLydNbXpoKSKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB6352
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/22 10:42 AM, Vladimir Oltean wrote:
> The irqchip->irq_set_type method is called by __irq_set_trigger() under
> the desc->lock raw spinlock.
> 
> The ls-extirq implementation, ls_extirq_irq_set_type(), uses an MMIO
> regmap created by of_syscon_register(), which uses plain spinlocks
> (the kind that are sleepable on RT).
> 
> Therefore, this is an invalid locking scheme for which we get a kernel
> splat stating just that ("[ BUG: Invalid wait context ]"), because the
> context in which the plain spinlock may sleep is atomic due to the raw
> spinlock. We need to go raw spinlocks all the way.

Could we just use use_raw_spinlock in the regmap config?

--Sean

> Make this driver ioremap its INTPCR register on its own, and stop
> relying on syscon to provide a regmap. Since the regmap we got from
> syscon belonged to the parent and the newly ioremapped region belongs
> just to us, the offset to the INTPCR register is now 0, because of the
> address translation that takes place through the device tree.
> 
> One complication, due to the fact that this driver uses IRQCHIP_DECLARE
> rather than traditional platform devices with probe and remove methods,
> is that we cannot use devres, so we need to implement a full-blown
> cleanup procedure on the error path.
> 
> Fixes: 0dcd9f872769 ("irqchip: Add support for Layerscape external interrupt lines")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
