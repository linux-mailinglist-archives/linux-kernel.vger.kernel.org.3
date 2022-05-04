Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA59519B28
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346343AbiEDJKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiEDJKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:10:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A12718B3C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651655232; x=1683191232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uS5PbqPGgOzM5sgeB21zL4hDAdA1e9yfj8M0x7Uxzbs=;
  b=D9LCycem79X6jENAZCbjq//bki6u+rjSBenE4S+tUzNhds/xDCJRD5B+
   Tv4ECEc9PZX8JNFGXpmbUhW8/LX/581paVQhIAOKpg030+ugjbraA95Zi
   SgRUoniuSpizn8OseIM/P3tMNwm8aJBNNuUSLWbtFF18ZNPTTM3dBub/B
   McuvWSV5HWAAXVO3HwzUkBO383yZdLqoChkTF+4NP/a1yNlmJLwO/xlCf
   etEaSSIZmrj8kcrpcL1V2d9+0v/uSZ0mlyI8muOdVbBpVgenxvAldKNQV
   tl/zOOZYxeb3QqqyNtN2urlNcf9goVWeAcWn/Ra0taL3LOddEUGJVbQpk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248248901"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="248248901"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:07:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="584638750"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:07:03 -0700
Date:   Wed, 4 May 2022 17:07:00 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Jens Axboe <axboe@kernel.dk>, lkp@lists.01.org, lkp@intel.com,
        ltp@lists.linux.it, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [net] 5aa32dd9bd: INFO:task_blocked_for_more_than#seconds
Message-ID: <20220504090700.GG30775@xsang-OptiPlex-9020>
References: <20220504060305.GF30775@xsang-OptiPlex-9020>
 <64cbe8c1-a93f-1aad-2629-9feb6ee7a20e@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cbe8c1-a93f-1aad-2629-9feb6ee7a20e@gnuweeb.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ammar,

On Wed, May 04, 2022 at 02:29:10PM +0700, Ammar Faizi wrote:
> On 5/4/22 1:03 PM, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-11):
> > 
> > commit: 5aa32dd9bdb57e4a26143216df5e90f5e5c3dd2c ("net: add support for fast socket release")
> > https://github.com/ammarfaizi2/linux-block axboe/linux-block/sock-nolock.2
> > 
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20220430
> > with following parameters:
> > 
> > 	test: cve
> > 	ucode: 0x28
> > 
> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
> > 
> > 
> > on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 16G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> Hello,
> 
> Thank you for the testing effort. But it's an abandoned branch, please stop
> testing branch: axboe/linux-block/sock-nolock.2.
> 
> As Jens has said previously here:
> https://lore.kernel.org/lkml/f8de18da-e6ae-e82c-c6eb-6f4de6ce8e98@kernel.dk


sorry for this, will ignore this branch.


> 
> =========================================
> On Sat, 30 Apr 2022 at 08:58:21 -0600, Jens Axboe wrote:
> > 
> > Please just stop testing that branch, it's been abandoned.
> > 
> > -- 
> > Jens Axboe
> =========================================
> 
> -- 
> Ammar Faizi
