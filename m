Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1957452CD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiESHkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiESHkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:40:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7A7A7E36
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bxteNy34es/2gB44/WfucEpDJqQxVwavARK5icRrPxI=; b=YpOZazgwTFkQP6DVhIUJwBCPnn
        jmSCu+nkNUV0k7xLtu4a7R8ONutkgCNHVsXqijiuDTm4ILgWTaS+e5qzjbnZp/w/x6ygh+kNVY5+Q
        S3NjVJh5/Yz8+ebati6vVQG93q7rAdM826XZ/NjZn1hb0gIs1VNdnnZn7nKsc2c8ltzbd8+ZeQnWb
        LemxtPmgcA284oTqwSlNyW01ONk1mbkTSftMftUj0upcxBzXCpeHvcaQe1+px+vSGYj7oR6iuOq6d
        SxubwOxqTnyoNVczO7AUpNGhtnSb0RHIeHkaxB21i5NPBT//jdREVkBXg6zEKB8m2/l+Vu4/sd4dP
        a8EjxV3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nralO-00CX9k-1b; Thu, 19 May 2022 07:40:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08B9A980BF7; Thu, 19 May 2022 09:40:00 +0200 (CEST)
Date:   Thu, 19 May 2022 09:39:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:sched/core 6/8] kernel/sched/fair.c:9199:30:
 error: implicit declaration of function 'adjust_numa_imbalance'
Message-ID: <20220519073959.GB2578@worktop.programming.kicks-ass.net>
References: <202205190911.n5iX1ftB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205190911.n5iX1ftB-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:55:17AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> head:   45ff65aa1bfd4826331c9c4daafdca21ef8f79f8
> commit: c81394419b54c2df2644a34892a6d6434fd922b3 [6/8] sched/numa: Apply imbalance limitations consistently
> config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220519/202205190911.n5iX1ftB-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=c81394419b54c2df2644a34892a6d6434fd922b3
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue sched/core
>         git checkout c81394419b54c2df2644a34892a6d6434fd922b3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/sched/fair.c: In function 'find_idlest_group':
> >> kernel/sched/fair.c:9199:30: error: implicit declaration of function 'adjust_numa_imbalance' [-Werror=implicit-function-declaration]
>     9199 |                         if (!adjust_numa_imbalance(imbalance,
>          |                              ^~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Clearly I can't type much...  I'll just wait for v2 or so.
