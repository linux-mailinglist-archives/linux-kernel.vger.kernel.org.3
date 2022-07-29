Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED93584B06
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiG2FTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiG2FTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:19:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97AE4BD16
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659071950; x=1690607950;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0Yr8HJZydjdKJwy6MGE1XgQXC1I/9wNMrWmULjjGUIo=;
  b=AJBoXSRjx0B8L8Ak9nNMe/r92snPoASXttSjOerI9bg/DeoqvlfCa1W7
   qOrHFLFMA2kiDjber768sJE3mZfxKkYjKxNzPbdnxy/Dn96M3qVL00bSF
   a6we5Qb+Vgg8K0mVPI2YEJMphC8xgPhuVkAakby9dw8g7cPXNE/Qjuxfs
   RrbpyhK5a1hJy+6oDGqYIp7gZNWMMEtd1lEYeK43NAFvwhIQnuv38iZY7
   v1/R7ldELAy11igx/8mIgbLGz1EOQncoPm+wI4EHDnNm2g59ktT/e2Le/
   E39ZqN3I6+jlraHLroq+qOjRP0vbmyn91vEEomOIV3a1l1I12V3JcUKUR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="275576399"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="275576399"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 22:19:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="743416907"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2022 22:19:02 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 22:19:01 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 22:19:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 22:19:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 22:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciZUV5LnP4BIm2YIxtqkuBeLjECJYXfyOVq8O/ZHTPxs7LIb+QD5gETPebOeorScBucM78O5V9vygkKycYEKZRydertUUwHEIKgGZrOz1cO3oCcMyBWoV3OufJdOfmBLGoDKEJ074CTF85ziRGJw79Fc/Uxf5nQiaQShWNhY6A5RlbTFSk1hYTsWfCOVzqwIeATNcNgHkbnpqfZaQq1lPwkROYiNoYhIHjGfG8XyMgMBzGyo7JyDfcLHHVBkjgiKiLGA8LKKcFUe39cx5M5Cgf0bvczdLFh1UPnEQFjGNqBN64RisONR7ssfgY8pEEF0z6e9XATa9HxXftYBdtEYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IVr9UTZooe/e76+KvH+gqVh5kZTKnH8mgelMPCQS2o=;
 b=nV0Z3WyeM1sJ+PvDAXS1yuo8fTkWh8knkLsPJtkIQEu4/p1XiyRuus4NRwSDPAjAP30lCiwqaBgljdSfTTUGYg1C2wimlVjK+P6g52LEK/0meO71HOisdL2PEesBGLpHLyXvgignvbKSDk1GbHTqnMRajJD1X5x51WctCwMBoAFVMzcU2xCspFJIgq52kFph098VJzyNCOqPEcieBgP0agbnBpmoRhmxBNYa1IWFpAmlt94yrUAHiPYpFi5RdhZb08eah+EeM8v44csiTxuMrt2xZFK3kxVghozi5sxZAtC9gS9fbuhkMmQs5rJ3/BsDI+DjKDqhO2zGcmrv1K5R8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SJ0PR11MB6813.namprd11.prod.outlook.com (2603:10b6:a03:47f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 05:18:59 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c%6]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 05:18:59 +0000
Date:   Fri, 29 Jul 2022 13:18:49 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Will Deacon <will@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>
Subject: Re: [sched]  9ae606bc74:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
Message-ID: <YuNtuaIwGknyxJcm@xsang-OptiPlex-9020>
References: <Yt5Qia3AwDOodKI1@xsang-OptiPlex-9020>
 <20220725092057.GB20370@willie-the-truck>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220725092057.GB20370@willie-the-truck>
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d8e3c2d-64d5-479c-b44a-08da7121d76f
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6813:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kg5tuvWy0lziXlJHg6O3zSquUBWVzK2ddNQzBgXBnbsMXdHDR8GT3mvNvH4k3hTLwXlrA3Vj2n5ejB995K8ok0cJ65D7EZuw7Vre4+IeETjHCNcB/esjTWLMg1HnEtKC28dNqqEHEUjlFLfUHK6d4f6grlsJnyB1bAw6vas09K5c8yVCGrzHRzIVaAsRztJF+5c2ibU4MejqF7wMQbXpft20GVLq/QZBVfxskwczMzhnIrOBPdTmT8x+S17H0qJNJAlJ9wXd4N8A0+R0hE5vE4x4xIOercow1b5Je+HOwAJ/FfjgTXAKOT2pBima6KxO+zzDZUsV/S3kaR3VTWi4bJRjPsarfsEASyWY2rWCLnNUf8OM+wVIOgDzu9gN4JFSdk0PUzNYHxqrACzH5Y6bI6FBaPZyZt6x7ETP/cqkM7sts3F7T95aCbxWe9Mg/3DfAtaPZ2UY7g0oF+WqrloLSVf2dmwXCacQeJDYn4mHlK/GArpcOrpBjqUS93kXk9bDzrJ7cYjNM9sTL/B6qbDenJP6Y57p3PhRyiljHocvSFpgZGVdX8FOfmkC7/tdsmAK6CGp5Qp7ui8ZFYZEJrUkGJosN0lQDxco3TjuCn6L1uJPSKFxr+m4iwtfNes5INj1b9QuVs8MhjRe1R+meHB38A8IDIPwkVe21o+yLwQ4QR+G0glnmL0MTS3hTrbHqXRML3QFfgz88lQs1Q7a/O6ZP8k240zftgenOYMMapPs88kJZqXmXIhESK+vOoAEvLNMGSZCZamB6W20kT5+0PqNOuJWO232pfGLsdxNbvI1+M0F6UV5AtTe7AB3m5IXEVaY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(478600001)(82960400001)(316002)(2906002)(6666004)(86362001)(33716001)(41300700001)(44832011)(26005)(38100700002)(966005)(8676002)(6512007)(6506007)(9686003)(5660300002)(6916009)(66556008)(66946007)(66476007)(4326008)(6486002)(8936002)(54906003)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/pxK8uxvHSUMBF6cCXzcXtW7E2cIqZd8gOHV+4aXZyFAt3pyNfJYRTUPhq/?=
 =?us-ascii?Q?6BtwuYfNnLsTBrw1x1rF5TiKB0ydIyhI0oecE276c88RPDANIDYLsWrqx7ds?=
 =?us-ascii?Q?7P9Gq4jAzxR/4eACbd7MbydOjN4D8bKEdCB72NST0brEUY6uQa6EbNf7fKZJ?=
 =?us-ascii?Q?wqvWrqZ1DqFm5V37SkL1a9E2eqjb5Oe5+WJWD525oN3sHXyHdzWxXL9FbJgh?=
 =?us-ascii?Q?fZz+JJi83ThWepEjQvVGkXfaLUWJKyjuxn0dqDhAgSCQyVtKPJb6yimZXYWU?=
 =?us-ascii?Q?GqGwsy9s0FqCs0txODcGJtPglOcEOFK/uf97T/0osryIiXunXeuBcpUbNUky?=
 =?us-ascii?Q?SyKF/+mGTsE8tK5h+boyDGLlIKE55XmOf6unDDpmOCQGC6GFXhCv3flPmg9Q?=
 =?us-ascii?Q?HUim3GhRh4rSCMQgh9k2BYMQC0mUD7Y5ZIBMYdOhRH4mtNW/5CrJ4n6W1n5C?=
 =?us-ascii?Q?9ifBvtNwGt2lr6GkjJSEn51ida8BU1AxrIyV2P/1N6nPQTcT4jbj/AAykrow?=
 =?us-ascii?Q?11P0BGp2o6grFjn034rPZGESXfGvLyIefS7n3/tpG/xo6OnoiZA4Ic+s86tU?=
 =?us-ascii?Q?Ok2j9EHEvhSHty1Wvzh4nn/Dh3z8H/s5/4EtnnZxaDwawNC4mQd80l1KaUIp?=
 =?us-ascii?Q?u4d0MIS3wE2mwQIcBZj+FEgvdY7eSk6FoO0BaJpKwqbQNq4CG3xkbCFNCy1T?=
 =?us-ascii?Q?xz4sY0O8mlc7PSkmGKgQEkIWnFninGJUIYfLXhwzIqynQZSS/lZ/yIC5y8WK?=
 =?us-ascii?Q?V9O11QoVpszBfmQfu9FyRAUVKm++P/AqmyIHBgAKC2v5p4EL9U7fVCKDayuF?=
 =?us-ascii?Q?+Bz5tpnwJxxEnM7j1D46sHfH/ULZ5M+dTNJNdU2QObqJRWApxiy9ve1kZ8ha?=
 =?us-ascii?Q?XJntvMHs6rJqV1IqXQKglvcW0k+Po4oVQBKOMVTyCTPuRnA4VME67Pg3LMV7?=
 =?us-ascii?Q?XPjbQ8GvGdEexxOFRkG5Pnw7od1bJdEJmmxZ6dChRqeqVdW2G04rJlY1rCaE?=
 =?us-ascii?Q?o19s+wtEIyWmu3+3ZWFUtF31vyFgiMphfqQ980+Nzk9t7mUVBOxA0Ti/I/ti?=
 =?us-ascii?Q?FX5M4ie1aSZRlApDIcqFTYuGuvT8/OhqXLsafr5tGlWRjEx4C8bt4lqsadCN?=
 =?us-ascii?Q?MstSeeyEfG9GlhZrGnv7qKOmmTpy3U6zj3mzQPRXhh6nTEFo+0dTubBaXJsb?=
 =?us-ascii?Q?t9eWROMoFrTiRubS4fUXdbEZqZ6mBaWgXWh56/iEI4kEweuNJPMiZLQjATeu?=
 =?us-ascii?Q?iZWTUveibYymNmMnwlZLD9x/k8CqCr4YlglmRPZfCUQorXM/tv0qQ5cpe7RL?=
 =?us-ascii?Q?SdZmnR2nIjz7WyDVVosfZmANggyv0InIzKE2auBEnoBMicoVgnbnknl2j5o6?=
 =?us-ascii?Q?Hu7Rm0RMrTFFAeyTa/sMkffRdahlI/88I3GUpaAIazOmOG/Bx+0QfPWzst7F?=
 =?us-ascii?Q?s2n/oXDxpSMCH+HT6oMMzEOzQA+MXCo74a3DFVswBoCAucoJIWuLZ0V6QQJO?=
 =?us-ascii?Q?grIRFUr71ItYg+rV26tXb7ei5vKotPJgRoldeUBqRTZNTeDUZKc8ZqV1B2Te?=
 =?us-ascii?Q?Pzu2hP0XVfZ1CLzTNhUInmei2ZDa3UcmFtoWRgDjfRE5RxEoO8BcyuTKLnU7?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e3c2d-64d5-479c-b44a-08da7121d76f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 05:18:59.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWPP6jq5ysOcbVa3zwTzUpaA56s77zo6jwF8/5m0+4qzCsafUV3Me/eEIt/LXGwEjCLnIDqpcJ8JYSP1jaoZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6813
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Will,

On Mon, Jul 25, 2022 at 10:20:58AM +0100, Will Deacon wrote:
> On Mon, Jul 25, 2022 at 04:12:57PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with clang-15):
> > 
> > commit: 9ae606bc74dd0e58d4de894e3c5cbb9d45599267 ("sched: Introduce task_cpu_possible_mask() to limit fallback rq selection")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: rcutorture
> > version: 
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: cpuhotplug
> > 	torture_type: trivial
> > 
> > test-description: rcutorture is rcutorture kernel module load/unload test.
> > test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +-------------------------------------------------------------------------+------------+------------+
> > |                                                                         | 304000390f | 9ae606bc74 |
> > +-------------------------------------------------------------------------+------------+------------+
> > | WARNING:at_kernel/rcu/rcutorture.c:#synchronize_rcu_trivial[rcutorture] | 120        | 120        |
> > | RIP:synchronize_rcu_trivial[rcutorture]                                 | 120        | 120        |
> > | WARNING:at_kernel/rcu/update.c:#rcutorture_sched_setaffinity            | 120        | 120        |
> > | RIP:rcutorture_sched_setaffinity                                        | 120        | 120        |
> > | WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture] | 0          | 36         |
> > | RIP:rcu_torture_stats_print[rcutorture]                                 | 0          | 36         |
> > +-------------------------------------------------------------------------+------------+------------+
> > 
> > 
> > please be noted, since 9ae606bc74 is kind of old, we also tested on a latest
> > mainline commit:
> > commit 515f71412bb73ebd7f41f90e1684fc80b8730789
> > Merge: 301c8949322fe cf5029d5dd7cb
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Sat Jul 23 10:22:26 2022 -0700
> > 
> > and confirmed the
> >    WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print[rcutorture]
> > still exists.
> 
> I'm not convinced by the bisection -- that commit should't have any effect
> on x86.

Thanks a lot for your information!
we will do some further tests to see if below part could impact x86.
will update you next week. thanks

@@ -3124,9 +3124,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)

                /* Look for allowed, online CPU in same node. */
                for_each_cpu(dest_cpu, nodemask) {
-                       if (!cpu_active(dest_cpu))
-                               continue;
-                       if (cpumask_test_cpu(dest_cpu, p->cpus_ptr))
+                       if (is_cpu_allowed(p, dest_cpu))
                                return dest_cpu;
                }
        }


> 
> Will
