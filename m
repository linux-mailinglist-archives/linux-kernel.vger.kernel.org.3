Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF734C03FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiBVVmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiBVVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:42:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0135E758
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645566137; x=1677102137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a47fUvwmAELWOtL2YGU5gBEiWT9a8JiqnHsi5bV5vvY=;
  b=GiPfvctO7tPB9pzeBmAtffSsW21lc09tk78Wx8xNpwXKhtNroRdQYOP5
   IOHjqM/ONN0oaZnV5MUDOS90LYxz7fDO8Y8PZJfTcNSGKAI0XCEH/WzUX
   KnaQ5oEnVLPaPxxsCZuRUc83jrYV1eKk41/nguJeOgSD9jgFlvNooFELF
   M+Jl0XObkfuuByGz6l5YcrmHvAeg95tl9PdsCjCqNMQC/DdohMxZ/WEx5
   iDPRz0z+3/BKeEA4PkicNismG0v7/hPKL1EsURxaujfb4/HNLfqArBmEC
   /n5kn/x6Du7cx0UvoUXyIPRoqr/jKEHFvLbU13/z0EKuAKulndr1Gig+G
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338256915"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="338256915"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 13:42:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="490950449"
Received: from psillosx-mobl.amr.corp.intel.com (HELO localhost) ([10.134.65.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 13:42:16 -0800
Date:   Tue, 22 Feb 2022 13:42:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Message-ID: <YhVYuOx1PBRaQm2I@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-21-ira.weiny@intel.com>
 <fd507c3259da765f4c6b42dc6b319d7f5ce29ce6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd507c3259da765f4c6b42dc6b319d7f5ce29ce6.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 09:43:17AM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > +int check_context_switch(int cpu)
> > +{
> > +       int switch_done[2];
> > +       int setup_done[2];
> > +       cpu_set_t cpuset;
> > +       char result[32];
> > +       int rc = 0;
> > +       pid_t pid;
> > +       int fd;
> > +
> > +       CPU_ZERO(&cpuset);
> > +       CPU_SET(cpu, &cpuset);
> > +       /*
> > +        * Ensure the two processes run on the same CPU so that they
> > go through
> > +        * a context switch.
> > +        */
> > +       sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset);
> > +
> > +       if (pipe(setup_done)) {
> > +               printf("ERROR: Failed to create pipe\n");
> > +               return -1;
> > +       }
> > +       if (pipe(switch_done)) {
> > +               printf("ERROR: Failed to create pipe\n");
> > +               return -1;
> > +       }
> > +
> > +       pid = fork();
> > +       if (pid == 0) {
> > +               char done = 'y';
> > +
> > +               fd = open(PKS_TEST_FILE, O_RDWR);
> > +               if (fd < 0) {
> > +                       printf("ERROR: cannot open %s\n",
> > PKS_TEST_FILE);
> > +                       return -1;
> 
> When this happens, the error is printed, but the parent process just
> hangs forever. Might make it hard to script running all the selftests.

Good point.  I've fixed this up.

> 
> Also, the other x86 selftests mostly use [RUN], [INFO], [OK], [FAIL],
> [SKIP] and [OK] in their print statements. Probably should stick to the
> pattern across all the print statements. This is probably a "[SKIP]".
> Just realized I've omitted the "[]" in the CET series too.

Thanks, fixed.

Ira

> 
> > +               }
> > +
> > +               cpu = sched_getcpu();
> > +               printf("Child running on cpu %d...\n", cpu);
> > +
> > +               /* Allocate and run test. */
> > +               write(fd, RUN_SINGLE, 1);
> > +
> > +               /* Arm for context switch test */
> > +               write(fd, ARM_CTX_SWITCH, 1);
> > +
> > +               printf("   tell parent to go\n");
> > +               write(setup_done[1], &done, sizeof(done));
> > +
> > +               /* Context switch out... */
> > +               printf("   Waiting for parent...\n");
> > +               read(switch_done[0], &done, sizeof(done));
> > +
> > +               /* Check msr restored */
> > +               printf("Checking result\n");
> > +               write(fd, CHECK_CTX_SWITCH, 1);
> > +
> > +               read(fd, result, 10);
> > +               printf("   #PF, context switch, pkey allocation and
> > free tests: %s\n", result);
> > +               if (!strncmp(result, "PASS", 10)) {
> > +                       rc = -1;
> > +                       done = 'F';
> > +               }
> > +
> > +               /* Signal result */
> > +               write(setup_done[1], &done, sizeof(done));
> > +       } else {
> > +               char done = 'y';
> > +
> > +               read(setup_done[0], &done, sizeof(done));
> > +               cpu = sched_getcpu();
> > +               printf("Parent running on cpu %d\n", cpu);
> > +
> > +               fd = open(PKS_TEST_FILE, O_RDWR);
> > +               if (fd < 0) {
> > +                       printf("ERROR: cannot open %s\n",
> > PKS_TEST_FILE);
> > +                       return -1;
> > +               }
> > +
> > +               /* run test with the same pkey */
> > +               write(fd, RUN_SINGLE, 1);
> > +
> > +               printf("   Signaling child.\n");
> > +               write(switch_done[1], &done, sizeof(done));
> > +
> > +               /* Wait for result */
> > +               read(setup_done[0], &done, sizeof(done));
> > +               if (done == 'F')
> > +                       rc = -1;
> > +       }
> 
> 
