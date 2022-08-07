Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D009758B9BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 07:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiHGFrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 01:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiHGFrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 01:47:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458349FF3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 22:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659851238; x=1691387238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fQEwccqKBxBgleoFHUt43RaWKXdm57ihZ0cjtePpcy8=;
  b=iljY4lJb68n0FvCbcTEYySRXyZeuURgn61hb6w34E2b2cSpQGv3zyVL4
   UqEtOgmmhTXhgBsgvxJUzHBt5OrT9f5OEb3jCF0NAgB2H7RZPqnEeuVWF
   5JVkM4Agh4D/iQBicddRmPoAQ0fU41yhPhtOT2Az8Aru2BMsr1on5c4Ea
   PAKCmTX0FkZNqTar/Sg232RpMHhCJ40mCh6mKLEvN96FsnkE/SRYqT81z
   YDY3drAVxSYQyMIt/D7CrGwzpjkfLiAX/TCOUO/86vMAdLgFl+wMNkPDn
   RlkIhv3rEcAlvexWMxxGbF6Xp2/yB0MkBt02vsZDMSPs3e1BdVlHY51mR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="376707783"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="376707783"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 22:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="849736162"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2022 22:47:18 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 6 Aug 2022 22:47:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 6 Aug 2022 22:47:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sat, 6 Aug 2022 22:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmPIupWKk0wWEQyrq5vsRFYxJ9MPYjXB/xMXvI4rZQZVHglhM2lDNjAzgJM4tb6GO3p1xAYv/6JMJ0wCuohqXCs3pI40xAdF9f0/rqrvE757NDL9zJYjh7CvcReo/Gn2QCRx9zLz2JVBe9yHxYAL3WJdDkSI202exbe8IPva3YiyylYIE4kAZdgR3duxt6xmQBq+pWsCP+lxTBjQRAe4OSwOKT1Lkp24wK81f1ybuLhM6VMLHRnCKFFOVYNMgZJR/Q48vK/I8PQBC5SEHnkLk9JJ3snVoXrc6Zgq5Dd2Ctgriy3uEFwIDS+JEGPMGAc0cqekFGMpAt+JyoBen6gnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvDXz7a/4sXSp9Dt2dS55ZRVHFCUAxpDyF0ASlwh8ZA=;
 b=SUBqfR+pTYBLeXmJr+wGSeNAFQE+iGn/9dEJCpQ9twdIzjsT+4oxqIflvFFAu/t0JoVQzVD3UILdQjNtZ23r/fu1brlflDH8irf0AfVHGaG3IFwvdkPfSmOShgvzxZhIsF7fvUKSMZRFC9oeKyMaoAM2u99ic/v9FeLUxS4j5IbSdz+zaa/jkguUoZKH3+1bpJGr/xd0rJrI4Ui8OSJArCtX4zeTeX7Tp5LGRO9XDmMo5khYTiam8W3MBPN4e5WG2LhNVxFbl2xy2ceV5oXK01OLM3i/OB6p0c9tNrhrCFTxKLHDPC89j5OoUIfpxtv8Gm11jPHdoZ7Xbl7VcB04rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Sun, 7 Aug 2022 05:47:10 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49%7]) with mapi id 15.20.5504.017; Sun, 7 Aug 2022
 05:47:10 +0000
Date:   Sun, 7 Aug 2022 13:47:00 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Will Deacon <will@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>
Subject: Re: [sched]  9ae606bc74:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <Yu9R1NgpU5C5bcXi@xsang-OptiPlex-9020>
References: <Yt5Qia3AwDOodKI1@xsang-OptiPlex-9020>
 <20220725092057.GB20370@willie-the-truck>
 <YuNtuaIwGknyxJcm@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YuNtuaIwGknyxJcm@xsang-OptiPlex-9020>
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4097fd2-a480-494b-46a4-08da78384557
X-MS-TrafficTypeDiagnostic: DM4PR11MB6336:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rk34Jn1YVHmJTiqSEsjA98nkQ0CA1ucuG3c5QJsmPnmRh5l2Zuqk1utoDHZuJ4X0T8s+/OLR3eoPjNSKDUDlRlXrwfh+YCufi0tHBhJR3fu8p0wSwtd+QoeQQ4llZkdNu75k3oaF3wQy4JohXkdLL5RCZz5iA1N9sxC3tdA1mCciBeHgLP8SqY4S9yBaDQIX+FLuRxY2GOSHzexdOlKrT5oUXzgfxTwQu4G5lMUWFIKqHnwAaJP1z3JlnTq2jB5A2bfy9l8Xv8FOKqe79T6j9oH++9OMu1DtyLlaT3bX0wrPIzPlw/cMgOSa7zJ2CkTFaeOk+WJv5Wil4S82Gq8CMG09rb7FqtyXzCazJ02WUSTCpMaKAnawwmgLqFP4GsQj7I6BRlTJV4bWdQGO6mmGanGJWx3XKgrGUxFGEi6GLCCR1S8iey4lSx/J+QXlHoWB9F5sd0s67FZCJFcuFNfN9d5UtcjixUMenZTPCbtY2IMVt2jNDyXq+ACHbHg1tqetEg7ZKkbh8z2WZZpq3GffuEjmekvTN/g1TuZmN02g55x7nZ9aUoLNJxyNgx6mgQ5ZpCgHHeZHG4sCEo1g7ICqfE+Lp2OMq++KWsA74fLF/7UYARaDQ8ymTM7szaGWpkX0gVwYukXNTukko5HErHnuZy/O8JrUdf4mQci5U7xBOhDssCh4gX6/cfsaa4JuE3CaQsd6I7mt8uhB3R6hs8U3E7uC1ppi0vSFoLHIvUQayrNPc6iJ9QbRN9ti0E52GmMi9v05xFUERmixlAq5BvjmAfgGA+5oj+NtEMXja/Bn715FEo+2lg1jqBCLq+N4D6ox
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(136003)(39860400002)(396003)(346002)(8936002)(66946007)(33716001)(8676002)(66476007)(66556008)(5660300002)(4326008)(38100700002)(2906002)(44832011)(6512007)(82960400001)(478600001)(966005)(6486002)(9686003)(41300700001)(54906003)(6916009)(186003)(83380400001)(26005)(6666004)(316002)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VFutZCJSl8pLLFMIvZL/CXasTNStrSqRFqeMuFDWO5Wk1CAOjgEM/tzB/0OZ?=
 =?us-ascii?Q?hlxxsxW0MNZe/+g0fxbRA7SjauRiL9q9M0MjKrWGkQ611CRZKLE2/7dQlueD?=
 =?us-ascii?Q?Xj2kIoy6I2IjGzdeLOiTjQM7fxBjyv1q+3Xyaad3HnTx89pXmCS6qMeCgQUz?=
 =?us-ascii?Q?z75x+xSPNe+IqAhdCIrsYL11rsH0YF3GfWCq0rHcQfGD0W98nw2s9anUdaDV?=
 =?us-ascii?Q?2XFH0KJMWzpd3wFMIIOaumZ57YMQTv+dcHdks4pa0GRoZM0Iz7b4FELNoGcw?=
 =?us-ascii?Q?egqH6UqfvN/tYsiuizlcNgj7TyQ3pOhGeAhLkmaYt1RPtR6HAy7GeDURmimi?=
 =?us-ascii?Q?0Kj3Hy3L1pVSUqWiwoQdnO5a4k5OoWpe3SpJpYUAT24Iv/vibseIq6H28nvk?=
 =?us-ascii?Q?yt2g62GiK+HrH8O6RNNaUB9X/ILujaAz7uTjz1HapwdpeKT6tPw+/R/gBxxQ?=
 =?us-ascii?Q?pF79zBlmU7F6VVGjCEbU+p1iDwPjp2kKrw7+mYceMeAGqfNr5GYIm+M30oLj?=
 =?us-ascii?Q?Bsj+Ep4W/ezY7Og+iPxOzDiLS9FIgYUXYN8LPs8+shCuRQGWuh1RyBLIWcJf?=
 =?us-ascii?Q?96XhkivlTvadBdS+C02XzHk4qsIPZFFhzSZfuNZoYqNgEzLHK9clJDXd0ryg?=
 =?us-ascii?Q?BFYim0L8dmpQqa4gXLVDShjHzNUaHY0rNdR7RT4XKr0ng+TNbvae7tvW/KCu?=
 =?us-ascii?Q?ASsf35/Vy8drEevu19NRW6EhslgphJ8fovVxbGrOdy33iSuCYYMJscPOmB1Z?=
 =?us-ascii?Q?LnAp/fYR/YzLNOpLlOLIPKMGoVYSHppFDQZ1Tj/JrHaPIScqge5vL8PnETC1?=
 =?us-ascii?Q?OoFKR60Pw6yIqxJGFQQ60rPeNm18xpqvIFKCD/mj8ibVl+VNOZnqVLWgThgO?=
 =?us-ascii?Q?GkAGh9XmvBZOGichpWOAZHjQc7nq7A9tzi0nnUIXiglYQLS7yM0W/6TgXpzD?=
 =?us-ascii?Q?bQ9dxkduudb1MUA/i0IwD1yPzQyqx9ePjjFCi1TS0fYpf1YuDMWYHGfkLqLQ?=
 =?us-ascii?Q?yURq8Qw8bSLKraXbrKKNdFjYWYj2e7R76I25JM8+gFzXSlr7isUJbPZ4gQC3?=
 =?us-ascii?Q?2WcqdqkAKqx/G/0TTlhecYPehJg9OTMbBRiTLCvcFFM/YJ5sNm8rgUWFB3R8?=
 =?us-ascii?Q?8Q7dq+7Q/eSAWKmVt8hkjhOHb9ffVN4XfxKO20FXpWjCdUzs73OHCvLXsuVb?=
 =?us-ascii?Q?oFxQMnmKLEI97EEbbcVcQ8rCdT46Ggcn/1r+MkWOGxkFZS+IeZY31dJRnvMx?=
 =?us-ascii?Q?rz6QnYYNG781nPa59cD1FnjhbslQ/SHMomOdu3VX9/IAGCUzV5uRlmCF3nVw?=
 =?us-ascii?Q?vKHM5aBNoo3hmx5R+xeLZz4Jruxuxx+/MBI07w2wF8Ql6NbtiFyBLa6ldZiJ?=
 =?us-ascii?Q?10B5Mn68A7I9MXVbs46qLcGb/fHZhnM1HwFTTouhWuCIVobxXIk7/JVRjYL9?=
 =?us-ascii?Q?lG8vfpb1b08t8NSE+9PU3lcTDybi7nEZXLKXsVN6z/0fkATWRvXhiCN/qO8X?=
 =?us-ascii?Q?w6cF+B/Z7CWqGz145G5FzQGxPOiSM7k3LNPsLjmD9RzGVgtUg4Ay2RgQB+47?=
 =?us-ascii?Q?QeHKK8Ky/oCw4rtUOfuKpiMWyOHhFCC6oRGS1WAEFH4CwD/u9JIBuS5C5vWI?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4097fd2-a480-494b-46a4-08da78384557
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 05:47:10.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTgVQb2XGsLktCWXOwPZbcTW3qY2VT5kwqns8fyBhaghXwLgMGf91aGFBE8zPyMd1e5fiD1gA+2Uunla5nfJ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Will,

On Fri, Jul 29, 2022 at 01:18:49PM +0800, Oliver Sang wrote:
> hi Will,
> 
> On Mon, Jul 25, 2022 at 10:20:58AM +0100, Will Deacon wrote:
> > On Mon, Jul 25, 2022 at 04:12:57PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with clang-15):
> > > 
> > > commit: 9ae606bc74dd0e58d4de894e3c5cbb9d45599267 ("sched: Introduce task_cpu_possible_mask() to limit fallback rq selection")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: rcutorture
> > > version: 
> > > with following parameters:
> > > 
> > > 	runtime: 300s
> > > 	test: cpuhotplug
> > > 	torture_type: trivial
> > > 
> > > test-description: rcutorture is rcutorture kernel module load/unload test.
> > > test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> > > 
> > > 
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > 
> > > +-------------------------------------------------------------------------+------------+------------+
> > > |                                                                         | 304000390f | 9ae606bc74 |
> > > +-------------------------------------------------------------------------+------------+------------+
> > > | WARNING:at_kernel/rcu/rcutorture.c:#synchronize_rcu_trivial[rcutorture] | 120        | 120        |
> > > | RIP:synchronize_rcu_trivial[rcutorture]                                 | 120        | 120        |
> > > | WARNING:at_kernel/rcu/update.c:#rcutorture_sched_setaffinity            | 120        | 120        |
> > > | RIP:rcutorture_sched_setaffinity                                        | 120        | 120        |
> > > | WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture] | 0          | 36         |
> > > | RIP:rcu_torture_stats_print[rcutorture]                                 | 0          | 36         |
> > > +-------------------------------------------------------------------------+------------+------------+
> > > 
> > > 
> > > please be noted, since 9ae606bc74 is kind of old, we also tested on a latest
> > > mainline commit:
> > > commit 515f71412bb73ebd7f41f90e1684fc80b8730789
> > > Merge: 301c8949322fe cf5029d5dd7cb
> > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > Date:   Sat Jul 23 10:22:26 2022 -0700
> > > 
> > > and confirmed the
> > >    WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
> > > still exists.
> > 
> > I'm not convinced by the bisection -- that commit should't have any effect
> > on x86.


recently we updated our clang to version 16 so we rerun this case, then found
the issue also could be reproduced on parent, though the rate seems quite
smaller than this commit.

304000390f88d049 9ae606bc74dd0e58d4de894e3c5
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          3:300         36%         112:300   dmesg.RIP:rcu_torture_stats_print[rcutorture]
        300:300         -0%         299:300   dmesg.RIP:rcutorture_sched_setaffinity
        300:300         -0%         299:300   dmesg.RIP:synchronize_rcu_trivial[rcutorture]
          3:300         36%         112:300   dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
        300:300         -0%         299:300   dmesg.WARNING:at_kernel/rcu/rcutorture.c:#synchronize_rcu_trivial[rcutorture]
        300:300         -0%         299:300   dmesg.WARNING:at_kernel/rcu/update.c:#rcutorture_sched_setaffinity


we also checked the dmesg, confirmed they have same Call Trace and similar
context when the issue reproduced. so this is a false positive.

sorry if this caused any inconvenience.

> 
> Thanks a lot for your information!
> we will do some further tests to see if below part could impact x86.
> will update you next week. thanks
> 
> @@ -3124,9 +3124,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
> 
>                 /* Look for allowed, online CPU in same node. */
>                 for_each_cpu(dest_cpu, nodemask) {
> -                       if (!cpu_active(dest_cpu))
> -                               continue;
> -                       if (cpumask_test_cpu(dest_cpu, p->cpus_ptr))
> +                       if (is_cpu_allowed(p, dest_cpu))
>                                 return dest_cpu;
>                 }
>         }
> 
> 
> > 
> > Will
