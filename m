Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339CC49DEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiA0KQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235212AbiA0KQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643278569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1CQku6VTFrfPBuixP/9+VfuHc14JTIA/+iFEDaOkC8=;
        b=ihwZErAMow5BleOke6ulUIM/EU9XsILEaQJyjfj2f2Iwngvz0Uwxl1E1wpFZ7tMDsj4GWR
        BTG8MO4DM1EkvwPa3ub66URyva8+Nl6SVjohOHIO9HrlEY4n11MsHR1GBpLyLY0niOhj3s
        l4oGZFAoazlujd2jGuAhOpwYl3afotQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-V2DECWBTPJSGuzlPjPT2Pw-1; Thu, 27 Jan 2022 05:16:05 -0500
X-MC-Unique: V2DECWBTPJSGuzlPjPT2Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C74F41091DA4;
        Thu, 27 Jan 2022 10:16:03 +0000 (UTC)
Received: from work (unknown [10.40.193.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B1EE4F865;
        Thu, 27 Jan 2022 10:16:01 +0000 (UTC)
Date:   Thu, 27 Jan 2022 11:15:57 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: fs/ext4/super.c:5649:3: warning: Value stored to 'ret' is never
 read [clang-analyzer-deadcode.DeadStores]
Message-ID: <20220127101557.pgxsdydkacolbp3f@work>
References: <202201261659.dZZOrgxb-lkp@intel.com>
 <1531501c-ec77-5219-8bd7-c9db3ae6f2fb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531501c-ec77-5219-8bd7-c9db3ae6f2fb@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch on the list is going to fix it

https://lore.kernel.org/linux-ext4/20220119130209.40112-1-lczerner@redhat.com/T/#u

Thanks!
-Lukas

On Thu, Jan 27, 2022 at 02:40:58PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
> commit: cebe85d570cf84804e848332d6721bc9e5300e07 ext4: switch to the new mount api
> date:   7 weeks ago
> config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220126/202201261659.dZZOrgxb-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cebe85d570cf84804e848332d6721bc9e5300e07
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout cebe85d570cf84804e848332d6721bc9e5300e07
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <yujie.liu@intel.com>
> 
> 
> clang-analyzer warnings: (new ones prefixed by >>)
> 
> >> fs/ext4/super.c:5649:3: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
>                    ret = -ENOMEM;
>                    ^     ~~~~~~~
> 
> vim +/ret +5649 fs/ext4/super.c
> 
> ac27a0ec112a08 Dave Kleikamp 2006-10-11  5639
> cebe85d570cf84 Lukas Czerner 2021-10-27  5640  static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5641  {
> cebe85d570cf84 Lukas Czerner 2021-10-27  5642  	struct ext4_fs_context *ctx = fc->fs_private;
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5643  	struct ext4_sb_info *sbi;
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5644  	const char *descr;
> cebe85d570cf84 Lukas Czerner 2021-10-27  5645  	int ret;
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5646
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5647  	sbi = ext4_alloc_sbi(sb);
> cebe85d570cf84 Lukas Czerner 2021-10-27  5648  	if (!sbi)
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27 @5649  		ret = -ENOMEM;
> 
> can use "return -ENOMEM;" here
> 
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5650
> cebe85d570cf84 Lukas Czerner 2021-10-27  5651  	fc->s_fs_info = sbi;
> cebe85d570cf84 Lukas Czerner 2021-10-27  5652
> cebe85d570cf84 Lukas Czerner 2021-10-27  5653  	/* Cleanup superblock name */
> cebe85d570cf84 Lukas Czerner 2021-10-27  5654  	strreplace(sb->s_id, '/', '!');
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5655
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5656  	sbi->s_sb_block = 1;	/* Default super block location */
> cebe85d570cf84 Lukas Czerner 2021-10-27  5657  	if (ctx->spec & EXT4_SPEC_s_sb_block)
> cebe85d570cf84 Lukas Czerner 2021-10-27  5658  		sbi->s_sb_block = ctx->s_sb_block;
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5659
> cebe85d570cf84 Lukas Czerner 2021-10-27  5660  	ret = __ext4_fill_super(fc, sb, fc->sb_flags & SB_SILENT);
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5661  	if (ret < 0)
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5662  		goto free_sbi;
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5663
> cebe85d570cf84 Lukas Czerner 2021-10-27  5664  	if (sbi->s_journal) {
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5665  		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5666  			descr = " journalled data mode";
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5667  		else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5668  			descr = " ordered data mode";
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5669  		else
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5670  			descr = " writeback data mode";
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5671  	} else
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5672  		descr = "out journal";
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5673
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5674  	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5675  		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
> cebe85d570cf84 Lukas Czerner 2021-10-27  5676  			 "Quota mode: %s.", descr, ext4_quota_mode(sb));
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5677
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5678  	return 0;
> cebe85d570cf84 Lukas Czerner 2021-10-27  5679
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5680  free_sbi:
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5681  	ext4_free_sbi(sbi);
> cebe85d570cf84 Lukas Czerner 2021-10-27  5682  	fc->s_fs_info = NULL;
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5683  	return ret;
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5684  }
> 7edfd85b1ffd36 Lukas Czerner 2021-10-27  5685
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

