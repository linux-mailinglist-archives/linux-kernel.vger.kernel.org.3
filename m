Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B14F58BA37
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiHGI3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHGI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:29:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D756BC3A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659860969; x=1691396969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhs/4HQpgEECO1zoH2jpvSGy5xuBWQgxs4vDl/E5W8Y=;
  b=OQEBCICQ3ToBbFt5sz/e4qg6wfvHr+eWqQUVEtditmZrPlyUFJ+x+yJn
   k5Ptire+22RXO2lYpQWUbj6X80THKaHgyE1RrY/B8IIBCN2A5FTg+KAOE
   nhLyPCdodBxR4A2CATAr+QT9m9p86aHpuCqqSq72JIG8KX/mc3dOlhhgI
   a0ZMHRHOoTGsVP2bwqOdS0tqnrSiSOxg1FpRvkp7iFDw3SMNxOU91YGn/
   QNeHTTU5/hYe+RO8YESiAsKiVwS/ITwBKAQIsi9JaEg3y3sLtQXyh0fSU
   e8bPjRK1Kja+H0JC+o0LPGUdahat4OgiVevDKXOtIFN2C14sb6IcsRQxD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="291650739"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="291650739"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 01:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="693431170"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2022 01:29:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKbf4-000L9d-0J;
        Sun, 07 Aug 2022 08:29:26 +0000
Date:   Sun, 7 Aug 2022 16:29:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     studentxswpy@163.com, jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Xie Shaowen <studentxswpy@163.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH -next] f2fs: Replace kmalloc() with f2fs_kmalloc
Message-ID: <202208071655.jHZ9QodB-lkp@intel.com>
References: <20220801092202.3134668-1-studentxswpy@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801092202.3134668-1-studentxswpy@163.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220728]

url:    https://github.com/intel-lab-lkp/linux/commits/studentxswpy-163-com/f2fs-Replace-kmalloc-with-f2fs_kmalloc/20220801-172502
base:    7c5e07b73ff3011c9b82d4a3286a3362b951ad2b
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220807/202208071655.jHZ9QodB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ca9f7259448a8dc0a2c4a1ae0a34a8109df4d6e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review studentxswpy-163-com/f2fs-Replace-kmalloc-with-f2fs_kmalloc/20220801-172502
        git checkout ca9f7259448a8dc0a2c4a1ae0a34a8109df4d6e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/f2fs/dir.c: In function 'f2fs_match_ci_name':
>> fs/f2fs/dir.c:235:52: warning: passing argument 1 of 'f2fs_kmalloc' makes pointer from integer without a cast [-Wint-conversion]
     235 |                 decrypted_name.name = f2fs_kmalloc(de_name_len, GFP_KERNEL);
         |                                                    ^~~~~~~~~~~
         |                                                    |
         |                                                    u32 {aka unsigned int}
   In file included from fs/f2fs/dir.c:13:
   fs/f2fs/f2fs.h:3316:55: note: expected 'struct f2fs_sb_info *' but argument is of type 'u32' {aka 'unsigned int'}
    3316 | static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
         |                                  ~~~~~~~~~~~~~~~~~~~~~^~~
   fs/f2fs/dir.c:235:39: error: too few arguments to function 'f2fs_kmalloc'
     235 |                 decrypted_name.name = f2fs_kmalloc(de_name_len, GFP_KERNEL);
         |                                       ^~~~~~~~~~~~
   In file included from fs/f2fs/dir.c:13:
   fs/f2fs/f2fs.h:3316:21: note: declared here
    3316 | static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
         |                     ^~~~~~~~~~~~


vim +/f2fs_kmalloc +235 fs/f2fs/dir.c

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
