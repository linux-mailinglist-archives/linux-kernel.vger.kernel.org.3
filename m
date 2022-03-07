Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6440B4CEFD3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiCGCzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiCGCzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:55:02 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD037AAA;
        Sun,  6 Mar 2022 18:54:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W05jWzSomDUd3PqwxeqOc2pIVcvxoTV2IFop7WpKHDWKMzFhMtNAdHYgCVcLJeflz8JmPuZ/xiiqvkbZxmMxc0sxMegmE4Oa+LDtZ1OgDVShFB3qDSECJ9jGdZv8W3+35JKTOW7CsdMvCQIS4QUAmOC6Vv6UWGaGTlk6pzF/YmAmtBrWMPA5s7zGFTkEfK58JiARSbLQgubzJpZ+34q8zy7/qNHiwjWfURvXRI9f23H83nHOg2grinoJaJp34dPjMua6NlME7J6x9Bm2K2al7ah5SrZcIyjgO42GhlNuqGce71spuEJMGlT/hK2Nw7tywBvhtEjVT8C3HexRokRYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0ZK4sXQBnozsn6jEU3ZOnh3hC562dfAjCzYwcajmeA=;
 b=dQZejK8pck4V/+19lhyaaxVW0UEqywdozDI+E+nBHXhDTJ7MQ1vy/T7xNESnfkYx6gxTYEmjocJfIS7r7EiIJGRahaw6C5JoET+GKlKtR+bpWTL5c+4dIWqffiZhd3uAEbW4dpyrrjTTTQ4QQfG4RVmrhajKepyGwTCFbcwm8xi15ijRJylzTCSjIMJ3sPA0VjVhgB6+PUBQqfIkb64aJX+wXixbrePr6xXiA8CtwR5kWm23q+AP56bLc8qQdQYdW32H+tGAapp6+S9UzDVS/H6N/Law9s12mvf+bx9LPe/SqkRPvemNKYzP863LzWEzExnYG63bWYS/AAd6HEELEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0ZK4sXQBnozsn6jEU3ZOnh3hC562dfAjCzYwcajmeA=;
 b=vfaOM/ivdw6C/n6ujvxhA51v8NY7IYxvoX+FJo+v8++ZUyp0h8JPRJ2+GHanZ57VZUAL3+sE27jNn7o/yooozq8BICnIzNCppuDW2XORMg2nlvvxdf1OV/jGWm0gZsBZ5VRyJxWSulfqgxNa9hUnSGY1/MqFlD68UdJKZin73cY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BL0PR12MB2563.namprd12.prod.outlook.com (2603:10b6:207:4b::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.26; Mon, 7 Mar 2022 02:54:06 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 02:54:06 +0000
Date:   Mon, 7 Mar 2022 10:53:38 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "dsmythies@telus.net" <dsmythies@telus.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: Re: [PATCH V2 1/4] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
Message-ID: <YiVzssDCijRWZLoK@amd.com>
References: <20220304060724.314582-1-Jinzhou.Su@amd.com>
 <20220304060724.314582-2-Jinzhou.Su@amd.com>
 <YiG0uqa+Ho7XyuHJ@amd.com>
 <CAJZ5v0jG2uodQGrWv01xLcDLgdU1MRs5vyJ5s+E4L0U4-GuR0g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jG2uodQGrWv01xLcDLgdU1MRs5vyJ5s+E4L0U4-GuR0g@mail.gmail.com>
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dcd6e1f-c2f3-40f7-19c1-08d9ffe5be7d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2563:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB256345F8FD981AAC2BF68E6AEC089@BL0PR12MB2563.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PL7PnmCFpS7upziCT3U4N+tF11EfiP7+8nODWt5b+ut7HBWHE4v2qdllfnnlEAFyz6evl68NzTVnbWp632u2Ocw2n0RsN3w7pXoe/FYOr4mm5Jtw7QCYN9fw7UVyNmc0h1RWLOvu98s8F1FANLN4opfAfAmfZCFejb+kio323Udb7QMCVsCSOkWuR6jAMhlbSMnMiBPcE6Z2qH/ONIMnDPGvfAvM2fxR4/mHXtqwcnbjiWjR2u/301+2buiW/ry2CoESxcouS8oWvuwKmSwHZjRfrxPtJ4e9IVjYezdHJqswOnu6bGnn25nuaDpMAODMf382U5/A66eH3rZy8s36Urfg38cYZfIc6nh7BzzMHgZRWPpEGTDPw9urV8Y2MUbkpHRIHZQ1LoFlbS6XKdQYcK9j3hgPJ4ICwWFPFKGfW89+Qh6HwuxRDDpTuCGvPDMKVuQPt51Q8K4OMOt9djUYVP8OAGQEsRRCxsFlNSXLyunpIvq4JcP3DafJvAX6Ej+89rvJ2e4Mhm86CfzA9K02HWlkPL4cSxfD0Xe7P0AFzGLqmmKufqoJEkytYmJQn+daAA5IMhARKFmcqLT6zEGdGAZptj/YGaf/MMBQg3JVmhiChH+hMabpYrjNoLtwVCaiYdYQmjyKC9XIfylHRc7qbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(53546011)(26005)(83380400001)(2906002)(186003)(2616005)(86362001)(6506007)(66476007)(38100700002)(6666004)(66946007)(6512007)(66556008)(4326008)(508600001)(5660300002)(8936002)(8676002)(6916009)(54906003)(316002)(6486002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQKSn8g7Vc6lh4PR13zvwtYheqKM+sPIHjYmPXW5dRcsA8KaLKsYQ0Q4na0E?=
 =?us-ascii?Q?XXIfGAzUefUZQh93diZhlBD7a9QLCZIHXcScQCntVQab1K1IQ1za0wFLRcHB?=
 =?us-ascii?Q?G8UO1ZePBCeRrFl2rdK03yDYyNbctOOatXy4LMv/UX3dcGPguSJ0pHnaYfxj?=
 =?us-ascii?Q?/xxV1myGBR/SnHxbqvGyyg1MEp5zqXAemxxg6DCA0lRvGMpc/iU70y3zN9ys?=
 =?us-ascii?Q?Ynpxh/CACw6DGdNe83m2QZt2Ge1i5RJLb8F/tOcxfBioiSc76r9IAqJ0+gqc?=
 =?us-ascii?Q?pVY4GoUBgeh/+8nZMS2+Tj3YSbFLFiyvXTzEKcA4sKWreZVC25EC8zrJ3e7o?=
 =?us-ascii?Q?Nq5ue2S8OIbh1tznG1Nn6UNPGOv/SFXHGSKUHYh1B/1SpFYoPfArZ1bz1Ttj?=
 =?us-ascii?Q?0OZu7wU1sytKiAOOztFqCz9+atVMqcRoeoBmZy73Z3SBfLKy49Se83S7fwN6?=
 =?us-ascii?Q?D0trlUj7eXBIRfgc+19XPOVuZ3mMsBzHhzt+ul8n9XEJy3iqe/Xmhyotr3Hk?=
 =?us-ascii?Q?Rr+blU8YxgqeqRY9F984t0qAulmAKzJU4UgoWz9lFtUcznHZaCpFchszfE/3?=
 =?us-ascii?Q?Bl4vI9BZMJhJO5c0a2XvZKtf6Bs/dP7IvMzxa73sWdScekC5GCjq9ObHizLa?=
 =?us-ascii?Q?4D4Xy7z7obUfZY4VzF4NdpT68liKvW9uKjM1TQLBQtoiVf4MNvUznv/x4gHf?=
 =?us-ascii?Q?4yYFEnhk5eh9mbiB5IwCJzboZOfmdb1YPT4IGpmmytZwCmXPyAe5eOX7ktvG?=
 =?us-ascii?Q?UMPtsuDW8vngVjF2KCZyHR6OykrdyoW/1ZynWu/vtTtBtjXlmbxcS53G0g5J?=
 =?us-ascii?Q?AuMc3J/OdUZlWu5V2TSx6GO9q3s6gQ6ONEakQ4ugyybwScDR0c/5887tF5OU?=
 =?us-ascii?Q?Qzc6GTF0IEgzKeTp6KP0KL4MIVa2TniovRQ+7rhtWF4T/uQ2NeGEajLogVbl?=
 =?us-ascii?Q?cHvwDByvP7122ZrEVhgA+y6PjL89i2bJvNRFQpuSVKiAD3umVZfWkDmT8ejD?=
 =?us-ascii?Q?1ZgyyCcfIroCrxYPk8cGpOsnTrn4w8jA3OTsytjq0Cj8NYTjGr75byCHAOfZ?=
 =?us-ascii?Q?39ohqLCEZQGbkE9ISBArzHB++Jw/8NpRxQLyPCcV1Fg7J1pMDQLrW/udE4RS?=
 =?us-ascii?Q?1PPEUUtuZ9chw2w9njUdiH+PCHp59ejZ6hLtTJroqQ3S7gfJoafBWk4flJnO?=
 =?us-ascii?Q?oPKasPnaiJVJd3mb65oxHii7qkWymF/oiAwC6n+JX/kLHPZD9rx1MK0AXfxc?=
 =?us-ascii?Q?IDAQoJLll85srQ447ky9V2JIPCl3PxXtsN6nq0PuakC8l0nntGeTi3BNP+qU?=
 =?us-ascii?Q?rMVnsc5v7L4mJ+86WalTQAHeXSwekhwJ4xO8AxCqauvsbjT/IB0o8wxMCqyh?=
 =?us-ascii?Q?0R7obrZXqiKyZHy6xiaimSFjII8Ayq8EG2cuimEyk3wR0MCHxuISkHmqdI45?=
 =?us-ascii?Q?jE258DLYnIRMvCdY2/+avFB2ZGUm2pJ6vBG5FqPsClyrn+yccuFZJ3ru3Q6z?=
 =?us-ascii?Q?pmOIdcONg4sjpsirBf8Rea6ztNFWEiEYVMFis8UB0x3lO+DFRXofuVOy4psn?=
 =?us-ascii?Q?sIgzkDLmfspFSCz9gdv0ytipAtSKAIXlSaJv4ClxqUnz/QXZRvivnlPrxEbC?=
 =?us-ascii?Q?koHfpVHHeeMsJt6TuGQQ7fQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcd6e1f-c2f3-40f7-19c1-08d9ffe5be7d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 02:54:06.0442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHa1amjtTbGym8CPk8OAXtPS5pFMH5y16EoqZ1CneJqc7zFBxehWfj4rD9OMKry6d6GheXGR5EKA6Ek/36ua1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2563
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 02:49:51AM +0800, Rafael J. Wysocki wrote:
> On Fri, Mar 4, 2022 at 7:42 AM Huang Rui <ray.huang@amd.com> wrote:
> >
> > On Fri, Mar 04, 2022 at 02:07:21PM +0800, Su, Jinzhou (Joe) wrote:
> > > Add frequency, mperf, aperf and tsc in the trace. This can be used
> > > to debug and tune the performance of AMD P-state driver.
> > >
> > > Use the time difference between amd_pstate_update to calculate CPU
> > > frequency. There could be sleep in arch_freq_get_on_cpu, so do not
> > > use it here.
> > >
> > > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > > Co-developed-by: Huang Rui <ray.huang@amd.com>
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> >
> > Let's remove "Signed-off-by" of me, just leave "Co-developed-by".
> 
> Actually, they both need to be present (the C-d-b clarifies the S-o-b
> meaning), so the above is correct.
> 

OK, I see. Thanks to clarify this.

Best Regards,
Ray
