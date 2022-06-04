Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133AD53D823
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 20:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiFDStC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiFDStB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 14:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6133E26
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 11:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2671660F57
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 18:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389F5C385B8;
        Sat,  4 Jun 2022 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654368538;
        bh=AykKsuKg8j2GCkZX46bMGZ6g4meFZe03Ce6ywzT0SiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fYBOrFm/9OJcfGHSlZUIzvWXc87Zqepjr5kVo8x5EvJdgrrWKpKadJQxSLe7fAFHz
         79eXlfeslRSr6w1kflo2RpTU6fxfcBIAuWfpp8p+fcCp2fWsoRi90eiEOTp/lPIHbn
         MYKD2wB10R6TRmk9slN27jms4CEtJPAEbL4AIYJM=
Date:   Sat, 4 Jun 2022 11:48:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [akpm-mm:mm-unstable 179/180] fs/xfs/xfs_file.c:1273:1:
 warning: no previous prototype for 'xfs_dax_fault'
Message-Id: <20220604114857.0e34301eb39cfda3ff509a59@linux-foundation.org>
In-Reply-To: <202206042008.WcIK2oVM-lkp@intel.com>
References: <202206042008.WcIK2oVM-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2022 20:33:01 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> head:   f06e3c5104126b9a6660b58f29619b53bfa33b2b
> commit: d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c [179/180] xfs: support CoW in fsdax mode
> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220604/202206042008.WcIK2oVM-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
>         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>         git fetch --no-tags akpm-mm mm-unstable
>         git checkout d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/xfs/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/xfs/xfs_file.c:1273:1: warning: no previous prototype for 'xfs_dax_fault' [-Wmissing-prototypes]
>     1273 | xfs_dax_fault(
>          | ^~~~~~~~~~~~~
> 

Works OK for me with gcc-12.1.0.

I assume this will fix it.

--- a/fs/xfs/xfs_file.c~xfs-support-cow-in-fsdax-mode-fix
+++ a/fs/xfs/xfs_file.c
@@ -1256,7 +1256,7 @@ xfs_file_llseek(
 }
 
 #ifdef CONFIG_FS_DAX
-int
+static int
 xfs_dax_fault(
 	struct vm_fault		*vmf,
 	enum page_entry_size	pe_size,
@@ -1269,7 +1269,7 @@ xfs_dax_fault(
 				&xfs_read_iomap_ops);
 }
 #else
-int
+static int
 xfs_dax_fault(
 	struct vm_fault		*vmf,
 	enum page_entry_size	pe_size,
_

