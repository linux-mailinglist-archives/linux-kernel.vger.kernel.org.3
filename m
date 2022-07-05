Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A37566222
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiGEELt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiGEELr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:11:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909BE12D01
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 21:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CY21txMQFpoIh83m44N99Am5Eqhu13dU37WffJzFNVz/hExBTf7lth11OtoDSdDMzUvx98n6+/t2qqZPBZ4t/4UB/PP8aHO2ZDvyYAAgNG9IcWASBzh/aue+lz2DAHp+Danl/tUKJN+7xLGVUcWDujUnGYWSlZwl7a78cjxY78lPUCYwtKNWiArUEMPtz0IoI8ENf++aMtcYfItBgYkxw54/PPrtzUC9J2DfwVXgfRFQ9+iP4p/XDPR6FYSMUhGOlRRn9o0fT8ZKb/FJbBGbSiIbIylwNnTSJkE2VCFdaqgMEOnwQOLpo5jFBgk7ajKEgsVoVjF/gFZJbK4cxgC5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVqHI7CiaUpjtN00P1B3vMrF9Yhu/LgmED47NzXaBfE=;
 b=EBd5FNcXRhB/aptSzwGop1lSfnkR2JmRnjT/RI7AgmwJ+FCOkLMFaPKoPJsygHFEvn33ekS/qZFB/fMgb14/sLHIuzN0PDnJ5MDSdLN+ezwPV1oZutD0iwkPs+IGbK+OkK5Ibor6BQN1CXr/4NShf+hgWIPPbqtdRi7f63s/lo89SC4ONi4OmA0B/L8OSlpznqAeayIe8cFmW69ytWs3TA/CZN6uzDNiOaDPPwRcHOvI8umPRI9mUhqzgua6UmmzKk+/31Bgkj2uxNW3lQkxlPro18aVybLug1ciW98cOWBo0BV+txA/MA0LyL6SrLZZ6+B6tQHEad1+ecbnoMFgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVqHI7CiaUpjtN00P1B3vMrF9Yhu/LgmED47NzXaBfE=;
 b=WUNiQf/SpZoZl3z5Vne6yhcH8BZz+Gs6WILGa8Nj12Zmhu4mupHHmumY8ea//hjKa9lS3LwfOdWbn0cnJwyXb2b12EGSaC2Krsqe/wBiReDtB367/Q3lnq9TNIZ86Pw4bz/UbYNJgpW4m8JiKEjft0NFsFYvKwjxjQXOA/VF1acC8ovVEdKhKs9BZRPOi1biry5uNwZMyai+HKLV5yDmo7Id8Y2SEXOSnq5flfIJX6AIKnAHm+PfPS48iKszrbU3lJJDeTdplnzxhO45GvuH+r/xrpg2edizeCIf1e086BL5UC/WvK2PWc4fKIeqtEiRMcIO1FeY3+EQudjANcaKew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN6PR1201MB2545.namprd12.prod.outlook.com (2603:10b6:404:b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 04:11:43 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 04:11:43 +0000
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
 <YsMAeU2fwEoysohr@casper.infradead.org>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v8 00/12] mm/demotion: Memory tiers and demotion
Date:   Tue, 05 Jul 2022 13:45:58 +1000
In-reply-to: <YsMAeU2fwEoysohr@casper.infradead.org>
Message-ID: <871qv0tczn.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e362f1-f7bb-42d1-2c6c-08da5e3c7804
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2545:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyNVDKBDGh/5oQoz0FmbkGoyLl3ufye8O4QWXvxqhf/zzU1yEbXX9f3ddw8OslhDPa4TO3FWMDw2p3uYCb6jNWzkd7gyn+3qaASjRjUEAj7uAJGbhX/tsoRkGyMUddPKkRXWVRAhU6OZ+9BlrJ3jJfqtTFbb/AYgFBMYQNo13+y2rVGG5XPqyhYhLyh+k6TFkABZtD6K5h1Hamod0+AxYAv0/A/zvAP8nVX+SAhi1mzmPLSfhOuCDPA21IiFC3Sh3mqfsHhCodX8VLLzxMcY9YFPiu4/OyDACL+caUYI+MFJXC0XnqjoiXQXXf3uoYjDS6b2bTAN9LmP7Ul0CPOkbZR5CY3xpsbrTFgqIb8A/VcnrkQKr3nsPMMjubsIVZK8Os1MsrQTN3oz5CAq95iN+/hJzXy4wtfUZJ8ohkZoFtVnraqfXpX+pU6tsJJW40lW2L9MRezjJrx7iY6EFt7JnxVXpAFvZjcAekCi/fWp7SO4baWzZ3LFB3m0GYd4M7bUzi17BcZaX3vdbJAuWFDt5tvR4uAUxf6nDTD2n5M055STvphWkW4DMWozUSnkTTf9ZCJ3VoTAqP0xzTAkufJARwVsbQXqwQvW5Z4/IKat0/bZew0JXvkraRhvatRUPkElI8HtUP6fyPNZ0M3S6bSBgmDFeGFeGHE7I8tOEeSNoDrVr21fODnu0m6T4Rv5JXQFhv+7CHSMNZIXUMDZdpzAGZKWBTA0gSOJogr0EOFQija4eQPOfhqcxXF79kgnaCdp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(66476007)(4326008)(8676002)(66556008)(66946007)(186003)(83380400001)(2906002)(6506007)(38100700002)(7416002)(26005)(6512007)(9686003)(6486002)(54906003)(478600001)(6666004)(41300700001)(5660300002)(86362001)(316002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gU9jE+t/u7BmZlNAHist7jyl9/PmYA3JA0XbtHbmJoA064IkRek6k5rNPU05?=
 =?us-ascii?Q?kvLbU7m1oNZZJ8I7fQleFkt3ulUiZAdBGrDN2tMdectHYdfiQAbgHR9g1fnl?=
 =?us-ascii?Q?seeNP0vcvpZI2IcuzpODc0c99YIbYKV6APWX9yhDkW0fSzXL0iRkag0scMmZ?=
 =?us-ascii?Q?30uS5NGGf3VYedqFFyJFWyuzLSoXlkBlond5zTcmUHmtlcooIeuAhPd8PjR9?=
 =?us-ascii?Q?3oi5eFyAho0lv63Hg8CWj1M89JBMblRspmn+PiatdTa9FMtP4xAvijpUUxLg?=
 =?us-ascii?Q?G6JVY5SphnyaZkjezZ/ssreh6v8wkUB9d5JIm90u2E+ACY5GzJ6E8bsK9mGy?=
 =?us-ascii?Q?cZqZ/cdqO4BDsc9/R22TtQXBqdHjMshdUbAojI1Iq5EHzynewp70KP0cgSJj?=
 =?us-ascii?Q?yNq4yYo5bKrqYr1HHM0ivmyjGekVa0C+6AGxHKtPIc2x7YrLf0Baaa7UpobR?=
 =?us-ascii?Q?NlRFam6pKYrED85imD9axcPT+MVlf93egeUt1FBFSh8/BzITfwtydl+yH2PJ?=
 =?us-ascii?Q?590KuZl6STmZb24iuBbXcex76T8cYL1el+KtBQAwlejCwC2ecpRinRGXYAWE?=
 =?us-ascii?Q?DytLokyHluKJ2KJgmzmXWFCa/BWzNLL8I0+946qXw4ATQST0N7cY6JmD3EeZ?=
 =?us-ascii?Q?X0gZhEDAkkEiLB50j+rkN88n68N+BxUpu7vr33vuRRdf/Cp6AAoveIi4Tcnm?=
 =?us-ascii?Q?YiUZl8ssoQ2EfBssTnrUmsILRAC9pTFiFasgT+tUkiwZ1FWfxAOp9gI5SEx6?=
 =?us-ascii?Q?AIraURhVpeUkKXG9rxV/vaDRg3WfTbXljWjzDVEY7NdF3r9LQHX2uciuYaK/?=
 =?us-ascii?Q?Cfay15+hb3mnOO71njEJLn8XqzNW3TesGi1YyVREbR2JxfECUadshV9V3Nel?=
 =?us-ascii?Q?UKZw2dFrSVNeMWvAWi9+zeqG7oV9/5zINg0SfrxaBdSzK6nbI2wBKRuxmfYL?=
 =?us-ascii?Q?edC3lpOpp173UlVhz+/0gdvKZVfqrHobIKo/DN79muwvLm3arZpn9UQt3+4F?=
 =?us-ascii?Q?ovkzCw3zHRkBa/ib1NfODiabkCJ3mY4bwDGnfdBV1SzDn2X2OJc4GVflRWuN?=
 =?us-ascii?Q?7joul9R++kZEuLYC4cCNcCGltcpD2EGjUfSY2XG1tucwavC7HMsxA7ucGcSF?=
 =?us-ascii?Q?vfXtaBdWAL0folnYdOGGsPYtKx4Sq2X6XhAhXmxepwehXyF9mSjoy+g0cXH9?=
 =?us-ascii?Q?17Rc2XobIt9Nm5kWmlFGKYfvEZI/jWR8fQQPkSSQM4aXsgL8vwjuFc3QC34F?=
 =?us-ascii?Q?EQgZEtpp6Z9wLqQTEaAxrPr70YUNJoeTyF9QEZOCI9QYnLU+OaFkjrdQ+/4m?=
 =?us-ascii?Q?mT6Z4RsOSnMqn+JtM6x5j1Ymn1kGpilWe8ECkNPGRJ06ki6msdEqWQcqXjXN?=
 =?us-ascii?Q?ZzxoKykCpYsk31JuHTYeFfNcWIZDb1BNEfoIQwdWnt74O/AC07XjSn2F5K9X?=
 =?us-ascii?Q?vpe6Q++a0wsEhNSu6hHedSxehvnNRDUUIYkfqaxXD9zDgPagOJsXkln/Hib5?=
 =?us-ascii?Q?kmd1KW5tZbMNJxg3xurBhkbqwv26BG6A0r29OPr7zGAG76907BfhSe0czKlr?=
 =?us-ascii?Q?wT7Y66gi6A5Mnl2NulioKTkL5/WYD9dtG60TlVAd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e362f1-f7bb-42d1-2c6c-08da5e3c7804
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 04:11:43.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDsI7WrPP6lWlaXTMNl8fKf9dVBhJdNkg+yQdueLsOuHnTIiEcokB8QEevMw7atS3tlW+MByH5TqsWDLRsPwEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2545
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Jul 04, 2022 at 12:36:00PM +0530, Aneesh Kumar K.V wrote:
>> * The current tier initialization code always initializes
>>   each memory-only NUMA node into a lower tier.  But a memory-only
>>   NUMA node may have a high performance memory device (e.g. a DRAM
>>   device attached via CXL.mem or a DRAM-backed memory-only node on
>>   a virtual machine) and should be put into a higher tier.
>>
>> * The current tier hierarchy always puts CPU nodes into the top
>>   tier. But on a system with HBM (e.g. GPU memory) devices, these
>>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
>>   with CPUs are better to be placed into the next lower tier.
>
> These things that you identify as problems seem perfectly sensible to me.
> Memory which is attached to this CPU has the lowest latency and should
> be preferred over more remote memory, no matter its bandwidth.

It is a problem because HBM NUMA node memory is generally also used by
some kind of device/accelerator (eg. GPU). Typically users would prefer
to keep HBM memory for use by the accelerator rather than random pages
demoted from the CPU as accelerators have orders of magnitude better
performance when accessing local HBM vs. remote memory.
