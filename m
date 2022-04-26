Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3714250F779
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347796AbiDZJhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347912AbiDZJGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:06:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2114.outbound.protection.outlook.com [40.107.220.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758A8B53EA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHLoQM3dNMOwDWT875YpGTgx8FR+xVnp/UGlnFKBvkz1fKyg7fiDjAJCI8KQDUqgaE0KRQBCR0fuwrD6wlxuqaXtNbEZiuGmyDMdDYVzw3H1HnydjoJOgbFNaruw7Vuv8uh/0LxX+xwIAn1DgzG9CVOqkuj0/OE/PaveIdbLEY3F3yIUVb8LpD5sSaOYAHFMs2S/F9klNm0ePVLCl3aOsQ4F7BOWc3wdtfWgjq55HF3ValtX4dERPYqEidavc7u1aQIePa64+4HeActAfWX/yikCKJKdhh5e1vvPofrVshmMe4eL4ApMbruXr5EMAvLm7cJ12UexBdXNuN9UBeHx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GZ0rjnqP7NXfi44JTdQ1Kes9U3VjX3qhaHqPKGLNSY=;
 b=erACd90slNSxhyImXAD14lN/G2BK+uPf6Rp2NdiRo/Fz+2B511wd6XC68neyuT6oT/w2CkvrN6VSJsO4fC8INrTsw76dLsSiRALVyrkPocj+TKvF7i+HqxegnAMFmeDcWZhxVq15vZyhywkrTDwdZguLuSr/000/JpUPPMlflGyAHcIUHFAosW2yhd7Omn2UxeHOLyVi50ugjG4rXLvWB5u8bTUguWNtCfy5k31amMAMo4cSw1Ep1hxHdoZ9ArwvB7MmmKAYe38VzcYY9nckqMRUDn73q6t+8YoZfkZ7Ts70XI/fZo7lelCuMIpIwNCNbgXkBXHNsJqstMUw47Ri8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GZ0rjnqP7NXfi44JTdQ1Kes9U3VjX3qhaHqPKGLNSY=;
 b=gR59OKhZIKbr0lQTlFZQsy2X/w/PUCRKKzdcZLvKGi3AcSpROlemgujj0KGOcW92AyMvKZ7z+YCXigz/cNLozqCs5WG0RPwTl9QuRdKWMirZwjquh0Zm/E5V2NgXmQxbmCKm1GM0vMPxMISxIyt1AqDJdh6nj5oFdGmgTv5PfgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 PH0PR01MB7505.prod.exchangelabs.com (2603:10b6:510:ff::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Tue, 26 Apr 2022 08:47:04 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::1c14:74a3:9d99:d21e]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::1c14:74a3:9d99:d21e%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 08:47:04 +0000
Date:   Tue, 26 Apr 2022 16:43:45 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        patches@amperecomputing.com, zwang@amperecomputing.com,
        darren@os.amperecomputing.com, pasha.tatashin@soleen.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Adam Li <adam.li@amperecomputing.com>
Subject: Re: [PATCH v2] arm64: kexec: flush log to console in NMI context
Message-ID: <Ymgg6p5TYFOHPbw5@hsj>
References: <20220424151952.183208-1-shijie@os.amperecomputing.com>
 <Ymeq9uD5Sz9iwW8H@alley>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymeq9uD5Sz9iwW8H@alley>
X-ClientProxiedBy: CH0PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:33::17) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a18b5644-c35d-4c52-ac86-08da2761562d
X-MS-TrafficTypeDiagnostic: PH0PR01MB7505:EE_
X-Microsoft-Antispam-PRVS: <PH0PR01MB7505FCB579B9F86AB42C12C6EDFB9@PH0PR01MB7505.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fm4pvlMrX357tfeT9YsqXIwPKKHik/3S++FwjZKayTcVi9GmfzzsdVwGO6UOjgLxfJZafgMIEjUCIT1J/E9OU4rI4RnI8/004m1lSzlylX70Ck/5TbEgjjwfqmNWiOCM18u+9AbgzFWlWB58WO51iAvaoX9XBt97x8MtCbXybO6y06mwksR4lTaBMzYIF1X4cur1ge542PVaxaMzWoV6FsKgNWllkinG47EB2+Oq6pU683UxqAnMXkFfM9d6vNQxdQtmxs1i/Upz+/WIRT1XIrYA/PSx0JNU6KGhP01Ud19tNs75tNXn1deUhNyQN/XigCMK0bUR4fymjgPkTyt4f1rap5CxUQvRTCC9a7reFN6eRe8mi+zGHhNjP/yUbPBz5ewN8BEV+K2mY99Dy26bOJjfzih//hZSXSH5YOYaS6edqUR4HytYseMbzuG5nE7Uiwph9ZOU/A20CAulrAF/auASFZYNGRXtS1MSXilNCCdIy9iWD5LXnfYehht6mtDb+BzcmtXkSmDl29ROuZFqjwcg3baYKAk8hG/Jd8EDtHbapL6RAHkdP+Jzng98hzuUwxz9VOoRQUfpz8asPekRS3o/AAwhTMaBd/obYQNEFzngw5RzJsE3n9HwGpg1iefpJFsX44/bIM8oIRXG7skCG8Rj8GAQJbTJNLz+4UefmqmeD1V1+FwiG6f8KZrdvFnNMBhqzpdiRXpZm0tn266vkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(9686003)(6486002)(508600001)(107886003)(66476007)(66556008)(66946007)(8676002)(4326008)(86362001)(38350700002)(6916009)(316002)(26005)(6512007)(186003)(83380400001)(38100700002)(33716001)(6666004)(52116002)(6506007)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R53k9/veMz852EZtRmIX7LKSZtqtrtIoUS2ithkF04bN5hEmVvYKiQBCWiiq?=
 =?us-ascii?Q?GsHCPmfuTofk3Tb2PVG3gtSs3pONCd6yWBdmiJ1M7EpR8C8d+n/kUKxCT1u4?=
 =?us-ascii?Q?RTh8QWqD6x9RIZsnGMkbDK6ajzHGN68WEqvXyzlzqK4SMpZ4fyWWMU/0+scf?=
 =?us-ascii?Q?XMeolX7A463ZQ+eG1ZMjtr4eeg/BozuRUTwOznpJb2VKp/ZyWTaCZuHN7fZO?=
 =?us-ascii?Q?cAhH7L0HTmUp64+ZOmzda/x7mFKJBOIfxXxRUS6yUL+gNS10Yk9Xia0iaNMJ?=
 =?us-ascii?Q?WoDIhC/ipCm1BTb2BFVN3Ufg8+LlnX+pVSywK7OOhGhXQyxmQ5eKErRdloLh?=
 =?us-ascii?Q?rpkkP5yBeXfYQb297ycNRo95KPvlrRrWsF+cSDbJwxaNwsjY+iqPqmQIixKg?=
 =?us-ascii?Q?XHI3UFCUcJj1ayqyZYA6BrwIuCvEZ2UfyQe5HVlVkmucxi44uEXp6x065QBz?=
 =?us-ascii?Q?0wQ1mphk783KBpQjtyfK0m6R72t+e7QWdFtbzC9mRWxgqYwou+i93Gb399O6?=
 =?us-ascii?Q?Muupa53R79+k3cml9Vxe07Zr5GB3l0vLhy1F6pFFX+42cyowpBDkxCu/Zmzv?=
 =?us-ascii?Q?s5Yfr0qTjgr0DuOxfCryJMUMjRRdfsJjHdETh28f0qHR/qIuNLzTqCaXgHNd?=
 =?us-ascii?Q?tRieyER14oe4Ak8aluFiMfZmKzzup/dfSbEVXaUGyTn0Voacb00m10byxtwj?=
 =?us-ascii?Q?QenvcK+W2n6QnPLSuGS4RyQwqZ9V8DtBirZK+kkMUtXQJ67KLJA8oPTAyGMN?=
 =?us-ascii?Q?lAG46bq7OFervKA3PCL2prFl9BF2SGmB4huRUzJbUmSxPalvjFzfTceVwFds?=
 =?us-ascii?Q?jVgm+m1Vs7bt00L8Vi9KMtfsyzTMMTE8NILzmKSKcpvk0LBKR8PxcJPOAijM?=
 =?us-ascii?Q?uu6fGhptrLfDPWMquXSHnDODWktOf7YcsX8yWbGR2uIeTZnEDX6DtIC8gdiq?=
 =?us-ascii?Q?1PyJcz+n6TmJv+fNb+mGW9/sfqPujL5aW/crAvAqhRCynjTwKNPxx/nAMuy4?=
 =?us-ascii?Q?eWaEt+vPNKCI6VQY2pXq/x4IWoBLFaPPAn0gUbuGXobJhR4Qb8m9fgaNJcvO?=
 =?us-ascii?Q?VMQi+XyEEkWsBtoTpWlrsuif2OioFH6s2fPQffI6Ve1vvrOAQN++AP3ScrbL?=
 =?us-ascii?Q?AiQZSQHCulxP6AGAWoEuuZBvfKg9255HYfZkGP038RlziUksI+HCxCwnGjvi?=
 =?us-ascii?Q?pkJvY6CpVzFJJm/juDA6EGknNIqpKx9M7W60xaNGJmUcmwoZs/wGnYm3Tw4X?=
 =?us-ascii?Q?ghGZy7YZ+Lpv0rS7cF3wgBwHU2zWmbQ9cZseHx59JIGKWeyqRkts8x9J3UEY?=
 =?us-ascii?Q?F4TDhbtMZek4zQOHTaNucUdqUdgXf5CPiHC3OqOgaZoTdbWGsWHcFQmh6xKu?=
 =?us-ascii?Q?AfdaWqeTrSAjKK2LyXflD5jNQzi3BbzUIitTKTQjqTwiKoMnukjCOSPVxfAW?=
 =?us-ascii?Q?hhkksrAxQGfoFc+rRTtbd4D3jrVT4eyyMSJgGWxWKblxf85HXnb+d4/MQfLk?=
 =?us-ascii?Q?scwWctnR3g9Ann57yAe92y1HwlbKBXL+eEKFkUCohNFywwKdTXJZlPv8QaJ6?=
 =?us-ascii?Q?dI9ihYRUlPOwgUGwEwqRWxQyUeRLRqX+utNoKzGM+9P1kqgRsUpSvBPdqVG6?=
 =?us-ascii?Q?waC0/Uno9aDDJ9BE9eLviMmPJTbUOAkzocs/z/AjTQA4Q9UM7P2OP+Bh9ZyT?=
 =?us-ascii?Q?XLLqazAAlb8dvos7JsAuJg2J0Pw7vgWpVPCW2kNpNbN/l4ohnlcpJAFWLogn?=
 =?us-ascii?Q?znuZCfRwIshPRAtq9FfCM/Qe3ud9qBrFHMd3NVNcyP/aigkq7EP/?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18b5644-c35d-4c52-ac86-08da2761562d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 08:47:04.1240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHlrgEnz74ye2Yq/aTdjM1g5+5IJavXylqFPoQwmO+M9I0HvbVnOLNc635KeREwQSrQ7oF+0hLqz1PEBSfBW3ObsAbzMsf1UBETmGx0IkWRjBey2lmcDRR7EMRtoUwe3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7505
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,
On Tue, Apr 26, 2022 at 10:19:02AM +0200, Petr Mladek wrote:
> On Sun 2022-04-24 15:19:52, Huang Shijie wrote:
> > If kdump is configured, nmi_panic() may run to machine_kexec().
> > 
> > In NMI context, the defer_console_output() defers the console
> > output by using wake_up_klogd to flush the printk ringbuffer
> > to console.
> > 
> > But in the machine_kexec, the system will reset, and there is
> > no chance for the wake_up_klogd to do its job. So we can _not_
> > see any log on the console since the nmi_panic
> > (nmi_panic() will disable the irq).
> >
> > This patch fixes this issue by using console_flush_on_panic()
> > to flush to console.
> > 
> > After this patch, we can see all the log since the nmi_panic
> > in the panic console.
> 
> This is not a good idea. The crashdump is the best source of
> information about the crashed system. It includes the complete
> log.
okay.

Sometimes, we cannot get the crashdump file, so any log is important
to us.

> 
> The system is in unknown state during panic(). Any operation
> might break. Flushing consoles increases the risk that
> the crashdump will not get generated. The crashdump is more
> important. If the crashdump succeeds than the consoles are
> not needed.
> 
> Note that printk() does not handle consoles in NMI because it might
> cause deadlock. console_flush_on_panic() tries to avoid deadlock
> caused by console_sem. Also the particular console drivers are
> more careful because oops_in_progress is set at this stage.
> But there is still a risk of the deadlock. There might be another
> locks that are do not check oops_in_progress. Also a potential
> double unlock might cause deadlock.
okay, thanks for the detail explanations.

> 
> IMHO, the main motivation for this patch was to flush the per-CPU
> printk buffers (v1). But it is not longer needed. The buffers
> were removed in 5.15-rc1, see the commit 93d102f094be9beab28e
> ("printk: remove safe buffers").
> 
> The only reason to call console drivers when crashdump is generated
> is to debug the kexec code path. But I am not sure if
> console_flush_on_panic() would help here. The kexec might fail
> anytime before or after this flush so that the important
> messages will not be visible anyway. John Ogness is going
> to add atomic serial console that might be better for this
> use case.
I hope it is ready as soon as possible..

Thanks
Huang Shijie
