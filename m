Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D201258BA39
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiHGI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiHGI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:29:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731C2BF68
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659860969; x=1691396969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zldi7ioVam3SXWkUXMr6S5cw/9YD9h1FQKzs/lHLIFg=;
  b=YQu/ZQ3uk/LFzI+C0Cr2RN1kcnbcusc/1FboKtLkAPa0BPw8gkgF6flT
   NvvUVdFBXtjh4OKV+GwtwZ3D91hKvIxjjdSLV6upEAdcsF8Ij9CGZ2pRF
   9RAuuxOqznTwde14RWqXNZUf1AlImEURx+eno4abWeOPe2TNhLtZsKSaU
   dtk90ZgJBBEaD8bNbdhGfdaHtL8wCGegyyOKt/d1Hjf4grRi40YegxSqP
   v1fGX2Yiz0mmNPSl3/tYPRGGXWPvVkP1Dw6rqeNmWeZIZMKPnLF1Fbc+c
   R1LqBnB8GWNUQ7HjaEqaSc6L4sQraZ4igksJuEJ9591aS5YlcFfTGsQeF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="273469597"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="273469597"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 01:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="746301907"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2022 01:29:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKbf4-000L9f-0N;
        Sun, 07 Aug 2022 08:29:26 +0000
Date:   Sun, 7 Aug 2022 16:29:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     studentxswpy@163.com, jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Xie Shaowen <studentxswpy@163.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH -next] f2fs: Replace kmalloc() with f2fs_kmalloc
Message-ID: <202208071605.XXehjTqy-lkp@intel.com>
References: <20220801092202.3134668-1-studentxswpy@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801092202.3134668-1-studentxswpy@163.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220728]

url:    https://github.com/intel-lab-lkp/linux/commits/studentxswpy-163-com/f2fs-Replace-kmalloc-with-f2fs_kmalloc/20220801-172502
base:    7c5e07b73ff3011c9b82d4a3286a3362b951ad2b
config: x86_64-randconfig-a002-20220801 (https://download.01.org/0day-ci/archive/20220807/202208071605.XXehjTqy-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ca9f7259448a8dc0a2c4a1ae0a34a8109df4d6e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review studentxswpy-163-com/f2fs-Replace-kmalloc-with-f2fs_kmalloc/20220801-172502
        git checkout ca9f7259448a8dc0a2c4a1ae0a34a8109df4d6e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/f2fs/dir.c:235:61: error: too few arguments to function call, expected 3, have 2
                   decrypted_name.name = f2fs_kmalloc(de_name_len, GFP_KERNEL);
                                         ~~~~~~~~~~~~                        ^
   fs/f2fs/f2fs.h:3316:21: note: 'f2fs_kmalloc' declared here
   static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
                       ^
   1 error generated.


vim +235 fs/f2fs/dir.c

   211	
   212	#if IS_ENABLED(CONFIG_UNICODE)
   213	/*
   214	 * Test whether a case-insensitive directory entry matches the filename
   215	 * being searched for.
   216	 *
   217	 * Returns 1 for a match, 0 for no match, and -errno on an error.
   218	 */
   219	static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
   220				       const u8 *de_name, u32 de_name_len)
   221	{
   222		const struct super_block *sb = dir->i_sb;
   223		const struct unicode_map *um = sb->s_encoding;
   224		struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
   225		struct qstr entry = QSTR_INIT(de_name, de_name_len);
   226		int res;
   227	
   228		if (IS_ENCRYPTED(dir)) {
   229			const struct fscrypt_str encrypted_name =
   230				FSTR_INIT((u8 *)de_name, de_name_len);
   231	
   232			if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
   233				return -EINVAL;
   234	
 > 235			decrypted_name.name = f2fs_kmalloc(de_name_len, GFP_KERNEL);
   236			if (!decrypted_name.name)
   237				return -ENOMEM;
   238			res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
   239							&decrypted_name);
   240			if (res < 0)
   241				goto out;
   242			entry.name = decrypted_name.name;
   243			entry.len = decrypted_name.len;
   244		}
   245	
   246		res = utf8_strncasecmp_folded(um, name, &entry);
   247		/*
   248		 * In strict mode, ignore invalid names.  In non-strict mode,
   249		 * fall back to treating them as opaque byte sequences.
   250		 */
   251		if (res < 0 && !sb_has_strict_encoding(sb)) {
   252			res = name->len == entry.len &&
   253					memcmp(name->name, entry.name, name->len) == 0;
   254		} else {
   255			/* utf8_strncasecmp_folded returns 0 on match */
   256			res = (res == 0);
   257		}
   258	out:
   259		kfree(decrypted_name.name);
   260		return res;
   261	}
   262	#endif /* CONFIG_UNICODE */
   263	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
