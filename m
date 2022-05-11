Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB21522961
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbiEKCE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiEKCEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:04:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5662BD6;
        Tue, 10 May 2022 19:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09878B820EB;
        Wed, 11 May 2022 02:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E53C385D4;
        Wed, 11 May 2022 02:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652234690;
        bh=RqytgUQmYxvDTXBUw55j51kKtaUX/T2ojOwIJ6HZEiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VBO7kizVkXUSaa6HmoCSB9sOGvIGYnAyrJKrueHyNZW3nqHwMync9fdvyD0jIWLB3
         BWm3UD/7XCPZ5egCQJKBcse8rbcVpPBoMBEAqKU8BjWdY/hurJsSHM8rL7YUxVGyKo
         jE9NYVKIhAdH/oaFOs4aYV+DNZcFV5aQnNczUPtM=
Date:   Tue, 10 May 2022 19:04:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        mike.kravetz@oracle.com, catalin.marinas@arm.com, will@kernel.org,
        kbuild-all@lists.01.org, songmuchun@bytedance.com,
        tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.osdn.me, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue
 when migration
Message-Id: <20220510190448.5e352897a147622ffa87175f@linux-foundation.org>
In-Reply-To: <202205110919.CWIcIqYE-lkp@intel.com>
References: <ea5abf529f0997b5430961012bfda6166c1efc8c.1652147571.git.baolin.wang@linux.alibaba.com>
        <202205110919.CWIcIqYE-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 09:19:17 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Baolin,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [cannot apply to hnaz-mm/master arm64/for-next/core linus/master v5.18-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/Fix-CONT-PTE-PMD-size-hugetlb-issue-when-unmapping-or-migrating/20220510-114753
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: h8300-buildonly-randconfig-r001-20220509 (https://download.01.org/0day-ci/archive/20220511/202205110919.CWIcIqYE-lkp@intel.com/config)
> compiler: h8300-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/b666792b4c5f9774c350977ff88837bafc36365a
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Baolin-Wang/Fix-CONT-PTE-PMD-size-hugetlb-issue-when-unmapping-or-migrating/20220510-114753
>         git checkout b666792b4c5f9774c350977ff88837bafc36365a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=h8300 SHELL=/bin/bash
> 
> ...

Thanks. 
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-rmap-fix-cont-pte-pmd-size-hugetlb-issue-when-migration-fix.patch
(which is in current mm-everything) fixes this up.

