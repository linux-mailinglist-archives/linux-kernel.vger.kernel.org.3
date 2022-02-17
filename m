Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C884BAB57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbiBQU4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:56:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbiBQU4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:56:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81507606E5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:55:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 170AEB824C4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74549C340E8;
        Thu, 17 Feb 2022 20:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645131354;
        bh=/qfIvuEnZiYisePyk5Fyfjy1PkbsP8GTfWH3Fe9Xkgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ul/yTwB0cHWwxKTGk2Xl5JxIKPJ5CQpExkPYUNYHoc221kQfQy+o4ufMUyMt2tYnV
         sZKrHqVwa9yQuOQRLpwD1FCAlD1zT91PvSgkA6/unxLqbYsNCAlCiHVWZJEPG1qkF3
         8YkfHGfrp3gvdNhL1JmWdJPXxhbxO5olJmnq3QuE=
Date:   Thu, 17 Feb 2022 12:55:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [hnaz-mm:master 237/343]
 arch/powerpc/mm/book3s64/pgtable.c:540:15: warning: no previous prototype
 for 'memremap_compat_align'
Message-Id: <20220217125553.88a9ce7723ea8fd39c76a199@linux-foundation.org>
In-Reply-To: <202202172347.lJ6oYVOE-lkp@intel.com>
References: <202202172347.lJ6oYVOE-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 03:46:17 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://github.com/hnaz/linux-mm master
> head:   8857950589bc3b4920d69c3e0b2c06d33f445d21
> commit: 236e08e72c118cbb20e780cc853378e2c341825c [237/343] mm: don't include <linux/memremap.h> in <linux/mm.h>
> config: powerpc64-randconfig-m031-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172347.lJ6oYVOE-lkp@intel.com/config)
> compiler: powerpc64le-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/hnaz/linux-mm/commit/236e08e72c118cbb20e780cc853378e2c341825c
>         git remote add hnaz-mm https://github.com/hnaz/linux-mm
>         git fetch --no-tags hnaz-mm master
>         git checkout 236e08e72c118cbb20e780cc853378e2c341825c
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/book3s64/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/powerpc/mm/book3s64/pgtable.c:540:15: warning: no previous prototype for 'memremap_compat_align' [-Wmissing-prototypes]
>      540 | unsigned long memremap_compat_align(void)
>          |               ^~~~~~~~~~~~~~~~~~~~~

Thanks, I did this.

--- a/arch/powerpc/mm/book3s64/pgtable.c~mm-dont-include-linux-memremaph-in-linux-mmh-fix-2-fix
+++ a/arch/powerpc/mm/book3s64/pgtable.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/mm_types.h>
 #include <linux/memblock.h>
+#include <linux/memremap.h>
 #include <linux/debugfs.h>
 #include <misc/cxl-base.h>
 
_


