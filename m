Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7370D57F8FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 07:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiGYFgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 01:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYFgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 01:36:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265FB7E0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658727364; x=1690263364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jzlBd2F98xkh+hYnSzhDCk49q99Fzf5s/TcB7PCZ3pY=;
  b=UO1RgdOlcmFfEMYKblabRn3U5Tt8nqAWzILIYKQ0NtVKW7cNZ8LutyPT
   JLfTsaj+oxHxiEo7SvRzJu3ZFqTUqRirj79tiLJGtpNpV3lAKLw/TFLFk
   ++pqoGX5X2J9IZ9Knp3EJV9VjuPhqEJTYvq/FhvN2B7dCATsGajiOwRiR
   E1fIYDU9bcwhe6/P/mkDKNmxCeL386ANSPftE5krg7HxIX3vJR0W/4ORm
   vPYTHi5AE26PLfsVgrcSVjd9D/ABU8tAD+AXjMlqmIPE/WWL52PMUfnzs
   /S26JZ3tfyaaR9C0IXPdZ0HQKEqFZ47seYzM+dTmofG2G01OhIrrwGpHY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="351608714"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="351608714"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 22:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="549850910"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2022 22:36:01 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFql7-0004m1-0e;
        Mon, 25 Jul 2022 05:36:01 +0000
Date:   Mon, 25 Jul 2022 13:35:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: fs/ntfs3/fsntfs.c:2248:41: warning: taking address of packed member
 'de' of class or structure 'NTFS_DE_SII' may result in an unaligned pointer
 value
Message-ID: <202207251310.pkR2CGeA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: 6e5be40d32fb1907285277c02e74493ed43d77fe fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
date:   12 months ago
config: arm-randconfig-r025-20220724 (https://download.01.org/0day-ci/archive/20220725/202207251310.pkR2CGeA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9e88cbcc403bdf82f29259ad60ff60a8fc4434a1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5be40d32fb1907285277c02e74493ed43d77fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5be40d32fb1907285277c02e74493ed43d77fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/staging/ fs/ntfs3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/ntfs3/fsntfs.c:1874:9: warning: variable 'cnt' set but not used [-Wunused-but-set-variable]
           size_t cnt, off;
                  ^
>> fs/ntfs3/fsntfs.c:2248:41: warning: taking address of packed member 'de' of class or structure 'NTFS_DE_SII' may result in an unaligned pointer value [-Waddress-of-packed-member]
           err = indx_insert_entry(indx_sii, ni, &sii_e.de, NULL, NULL);
                                                  ^~~~~~~~
   2 warnings generated.


vim +2248 fs/ntfs3/fsntfs.c

82cae269cfa953 Konstantin Komarov 2021-08-13  2075  
82cae269cfa953 Konstantin Komarov 2021-08-13  2076  /*
82cae269cfa953 Konstantin Komarov 2021-08-13  2077   * ntfs_insert_security
82cae269cfa953 Konstantin Komarov 2021-08-13  2078   *
82cae269cfa953 Konstantin Komarov 2021-08-13  2079   * inserts security descriptor into $Secure::SDS
82cae269cfa953 Konstantin Komarov 2021-08-13  2080   *
82cae269cfa953 Konstantin Komarov 2021-08-13  2081   * SECURITY Descriptor Stream data is organized into chunks of 256K bytes
82cae269cfa953 Konstantin Komarov 2021-08-13  2082   * and it contains a mirror copy of each security descriptor.  When writing
82cae269cfa953 Konstantin Komarov 2021-08-13  2083   * to a security descriptor at location X, another copy will be written at
82cae269cfa953 Konstantin Komarov 2021-08-13  2084   * location (X+256K).
82cae269cfa953 Konstantin Komarov 2021-08-13  2085   * When writing a security descriptor that will cross the 256K boundary,
82cae269cfa953 Konstantin Komarov 2021-08-13  2086   * the pointer will be advanced by 256K to skip
82cae269cfa953 Konstantin Komarov 2021-08-13  2087   * over the mirror portion.
82cae269cfa953 Konstantin Komarov 2021-08-13  2088   */
82cae269cfa953 Konstantin Komarov 2021-08-13  2089  int ntfs_insert_security(struct ntfs_sb_info *sbi,
82cae269cfa953 Konstantin Komarov 2021-08-13  2090  			 const struct SECURITY_DESCRIPTOR_RELATIVE *sd,
82cae269cfa953 Konstantin Komarov 2021-08-13  2091  			 u32 size_sd, __le32 *security_id, bool *inserted)
82cae269cfa953 Konstantin Komarov 2021-08-13  2092  {
82cae269cfa953 Konstantin Komarov 2021-08-13  2093  	int err, diff;
82cae269cfa953 Konstantin Komarov 2021-08-13  2094  	struct ntfs_inode *ni = sbi->security.ni;
82cae269cfa953 Konstantin Komarov 2021-08-13  2095  	struct ntfs_index *indx_sdh = &sbi->security.index_sdh;
82cae269cfa953 Konstantin Komarov 2021-08-13  2096  	struct ntfs_index *indx_sii = &sbi->security.index_sii;
82cae269cfa953 Konstantin Komarov 2021-08-13  2097  	struct NTFS_DE_SDH *e;
82cae269cfa953 Konstantin Komarov 2021-08-13  2098  	struct NTFS_DE_SDH sdh_e;
82cae269cfa953 Konstantin Komarov 2021-08-13  2099  	struct NTFS_DE_SII sii_e;
82cae269cfa953 Konstantin Komarov 2021-08-13  2100  	struct SECURITY_HDR *d_security;
82cae269cfa953 Konstantin Komarov 2021-08-13  2101  	u32 new_sec_size = size_sd + SIZEOF_SECURITY_HDR;
82cae269cfa953 Konstantin Komarov 2021-08-13  2102  	u32 aligned_sec_size = Quad2Align(new_sec_size);
82cae269cfa953 Konstantin Komarov 2021-08-13  2103  	struct SECURITY_KEY hash_key;
82cae269cfa953 Konstantin Komarov 2021-08-13  2104  	struct ntfs_fnd *fnd_sdh = NULL;
82cae269cfa953 Konstantin Komarov 2021-08-13  2105  	const struct INDEX_ROOT *root_sdh;
82cae269cfa953 Konstantin Komarov 2021-08-13  2106  	const struct INDEX_ROOT *root_sii;
82cae269cfa953 Konstantin Komarov 2021-08-13  2107  	u64 mirr_off, new_sds_size;
82cae269cfa953 Konstantin Komarov 2021-08-13  2108  	u32 next, left;
82cae269cfa953 Konstantin Komarov 2021-08-13  2109  
82cae269cfa953 Konstantin Komarov 2021-08-13  2110  	static_assert((1 << Log2OfSecurityDescriptorsBlockSize) ==
82cae269cfa953 Konstantin Komarov 2021-08-13  2111  		      SecurityDescriptorsBlockSize);
82cae269cfa953 Konstantin Komarov 2021-08-13  2112  
82cae269cfa953 Konstantin Komarov 2021-08-13  2113  	hash_key.hash = security_hash(sd, size_sd);
82cae269cfa953 Konstantin Komarov 2021-08-13  2114  	hash_key.sec_id = SECURITY_ID_INVALID;
82cae269cfa953 Konstantin Komarov 2021-08-13  2115  
82cae269cfa953 Konstantin Komarov 2021-08-13  2116  	if (inserted)
82cae269cfa953 Konstantin Komarov 2021-08-13  2117  		*inserted = false;
82cae269cfa953 Konstantin Komarov 2021-08-13  2118  	*security_id = SECURITY_ID_INVALID;
82cae269cfa953 Konstantin Komarov 2021-08-13  2119  
82cae269cfa953 Konstantin Komarov 2021-08-13  2120  	/* Allocate a temporal buffer*/
82cae269cfa953 Konstantin Komarov 2021-08-13  2121  	d_security = ntfs_zalloc(aligned_sec_size);
82cae269cfa953 Konstantin Komarov 2021-08-13  2122  	if (!d_security)
82cae269cfa953 Konstantin Komarov 2021-08-13  2123  		return -ENOMEM;
82cae269cfa953 Konstantin Komarov 2021-08-13  2124  
82cae269cfa953 Konstantin Komarov 2021-08-13  2125  	mutex_lock_nested(&ni->ni_lock, NTFS_INODE_MUTEX_SECURITY);
82cae269cfa953 Konstantin Komarov 2021-08-13  2126  
82cae269cfa953 Konstantin Komarov 2021-08-13  2127  	fnd_sdh = fnd_get();
82cae269cfa953 Konstantin Komarov 2021-08-13  2128  	if (!fnd_sdh) {
82cae269cfa953 Konstantin Komarov 2021-08-13  2129  		err = -ENOMEM;
82cae269cfa953 Konstantin Komarov 2021-08-13  2130  		goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2131  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  2132  
82cae269cfa953 Konstantin Komarov 2021-08-13  2133  	root_sdh = indx_get_root(indx_sdh, ni, NULL, NULL);
82cae269cfa953 Konstantin Komarov 2021-08-13  2134  	if (!root_sdh) {
82cae269cfa953 Konstantin Komarov 2021-08-13  2135  		err = -EINVAL;
82cae269cfa953 Konstantin Komarov 2021-08-13  2136  		goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2137  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  2138  
82cae269cfa953 Konstantin Komarov 2021-08-13  2139  	root_sii = indx_get_root(indx_sii, ni, NULL, NULL);
82cae269cfa953 Konstantin Komarov 2021-08-13  2140  	if (!root_sii) {
82cae269cfa953 Konstantin Komarov 2021-08-13  2141  		err = -EINVAL;
82cae269cfa953 Konstantin Komarov 2021-08-13  2142  		goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2143  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  2144  
82cae269cfa953 Konstantin Komarov 2021-08-13  2145  	/*
82cae269cfa953 Konstantin Komarov 2021-08-13  2146  	 * Check if such security already exists
82cae269cfa953 Konstantin Komarov 2021-08-13  2147  	 * use "SDH" and hash -> to get the offset in "SDS"
82cae269cfa953 Konstantin Komarov 2021-08-13  2148  	 */
82cae269cfa953 Konstantin Komarov 2021-08-13  2149  	err = indx_find(indx_sdh, ni, root_sdh, &hash_key, sizeof(hash_key),
82cae269cfa953 Konstantin Komarov 2021-08-13  2150  			&d_security->key.sec_id, &diff, (struct NTFS_DE **)&e,
82cae269cfa953 Konstantin Komarov 2021-08-13  2151  			fnd_sdh);
82cae269cfa953 Konstantin Komarov 2021-08-13  2152  	if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  2153  		goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2154  
82cae269cfa953 Konstantin Komarov 2021-08-13  2155  	while (e) {
82cae269cfa953 Konstantin Komarov 2021-08-13  2156  		if (le32_to_cpu(e->sec_hdr.size) == new_sec_size) {
82cae269cfa953 Konstantin Komarov 2021-08-13  2157  			err = ntfs_read_run_nb(sbi, &ni->file.run,
82cae269cfa953 Konstantin Komarov 2021-08-13  2158  					       le64_to_cpu(e->sec_hdr.off),
82cae269cfa953 Konstantin Komarov 2021-08-13  2159  					       d_security, new_sec_size, NULL);
82cae269cfa953 Konstantin Komarov 2021-08-13  2160  			if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  2161  				goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2162  
82cae269cfa953 Konstantin Komarov 2021-08-13  2163  			if (le32_to_cpu(d_security->size) == new_sec_size &&
82cae269cfa953 Konstantin Komarov 2021-08-13  2164  			    d_security->key.hash == hash_key.hash &&
82cae269cfa953 Konstantin Komarov 2021-08-13  2165  			    !memcmp(d_security + 1, sd, size_sd)) {
82cae269cfa953 Konstantin Komarov 2021-08-13  2166  				*security_id = d_security->key.sec_id;
82cae269cfa953 Konstantin Komarov 2021-08-13  2167  				/*such security already exists*/
82cae269cfa953 Konstantin Komarov 2021-08-13  2168  				err = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  2169  				goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2170  			}
82cae269cfa953 Konstantin Komarov 2021-08-13  2171  		}
82cae269cfa953 Konstantin Komarov 2021-08-13  2172  
82cae269cfa953 Konstantin Komarov 2021-08-13  2173  		err = indx_find_sort(indx_sdh, ni, root_sdh,
82cae269cfa953 Konstantin Komarov 2021-08-13  2174  				     (struct NTFS_DE **)&e, fnd_sdh);
82cae269cfa953 Konstantin Komarov 2021-08-13  2175  		if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  2176  			goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2177  
82cae269cfa953 Konstantin Komarov 2021-08-13  2178  		if (!e || e->key.hash != hash_key.hash)
82cae269cfa953 Konstantin Komarov 2021-08-13  2179  			break;
82cae269cfa953 Konstantin Komarov 2021-08-13  2180  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  2181  
82cae269cfa953 Konstantin Komarov 2021-08-13  2182  	/* Zero unused space */
82cae269cfa953 Konstantin Komarov 2021-08-13  2183  	next = sbi->security.next_off & (SecurityDescriptorsBlockSize - 1);
82cae269cfa953 Konstantin Komarov 2021-08-13  2184  	left = SecurityDescriptorsBlockSize - next;
82cae269cfa953 Konstantin Komarov 2021-08-13  2185  
82cae269cfa953 Konstantin Komarov 2021-08-13  2186  	/* Zero gap until SecurityDescriptorsBlockSize */
82cae269cfa953 Konstantin Komarov 2021-08-13  2187  	if (left < new_sec_size) {
82cae269cfa953 Konstantin Komarov 2021-08-13  2188  		/* zero "left" bytes from sbi->security.next_off */
82cae269cfa953 Konstantin Komarov 2021-08-13  2189  		sbi->security.next_off += SecurityDescriptorsBlockSize + left;
82cae269cfa953 Konstantin Komarov 2021-08-13  2190  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  2191  
82cae269cfa953 Konstantin Komarov 2021-08-13  2192  	/* Zero tail of previous security */
82cae269cfa953 Konstantin Komarov 2021-08-13  2193  	//used = ni->vfs_inode.i_size & (SecurityDescriptorsBlockSize - 1);
82cae269cfa953 Konstantin Komarov 2021-08-13  2194  
82cae269cfa953 Konstantin Komarov 2021-08-13  2195  	/*
82cae269cfa953 Konstantin Komarov 2021-08-13  2196  	 * Example:
82cae269cfa953 Konstantin Komarov 2021-08-13  2197  	 * 0x40438 == ni->vfs_inode.i_size
82cae269cfa953 Konstantin Komarov 2021-08-13  2198  	 * 0x00440 == sbi->security.next_off
82cae269cfa953 Konstantin Komarov 2021-08-13  2199  	 * need to zero [0x438-0x440)
82cae269cfa953 Konstantin Komarov 2021-08-13  2200  	 * if (next > used) {
82cae269cfa953 Konstantin Komarov 2021-08-13  2201  	 *  u32 tozero = next - used;
82cae269cfa953 Konstantin Komarov 2021-08-13  2202  	 *  zero "tozero" bytes from sbi->security.next_off - tozero
82cae269cfa953 Konstantin Komarov 2021-08-13  2203  	 */
82cae269cfa953 Konstantin Komarov 2021-08-13  2204  
82cae269cfa953 Konstantin Komarov 2021-08-13  2205  	/* format new security descriptor */
82cae269cfa953 Konstantin Komarov 2021-08-13  2206  	d_security->key.hash = hash_key.hash;
82cae269cfa953 Konstantin Komarov 2021-08-13  2207  	d_security->key.sec_id = cpu_to_le32(sbi->security.next_id);
82cae269cfa953 Konstantin Komarov 2021-08-13  2208  	d_security->off = cpu_to_le64(sbi->security.next_off);
82cae269cfa953 Konstantin Komarov 2021-08-13  2209  	d_security->size = cpu_to_le32(new_sec_size);
82cae269cfa953 Konstantin Komarov 2021-08-13  2210  	memcpy(d_security + 1, sd, size_sd);
82cae269cfa953 Konstantin Komarov 2021-08-13  2211  
82cae269cfa953 Konstantin Komarov 2021-08-13  2212  	/* Write main SDS bucket */
82cae269cfa953 Konstantin Komarov 2021-08-13  2213  	err = ntfs_sb_write_run(sbi, &ni->file.run, sbi->security.next_off,
82cae269cfa953 Konstantin Komarov 2021-08-13  2214  				d_security, aligned_sec_size);
82cae269cfa953 Konstantin Komarov 2021-08-13  2215  
82cae269cfa953 Konstantin Komarov 2021-08-13  2216  	if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  2217  		goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2218  
82cae269cfa953 Konstantin Komarov 2021-08-13  2219  	mirr_off = sbi->security.next_off + SecurityDescriptorsBlockSize;
82cae269cfa953 Konstantin Komarov 2021-08-13  2220  	new_sds_size = mirr_off + aligned_sec_size;
82cae269cfa953 Konstantin Komarov 2021-08-13  2221  
82cae269cfa953 Konstantin Komarov 2021-08-13  2222  	if (new_sds_size > ni->vfs_inode.i_size) {
82cae269cfa953 Konstantin Komarov 2021-08-13  2223  		err = attr_set_size(ni, ATTR_DATA, SDS_NAME,
82cae269cfa953 Konstantin Komarov 2021-08-13  2224  				    ARRAY_SIZE(SDS_NAME), &ni->file.run,
82cae269cfa953 Konstantin Komarov 2021-08-13  2225  				    new_sds_size, &new_sds_size, false, NULL);
82cae269cfa953 Konstantin Komarov 2021-08-13  2226  		if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  2227  			goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2228  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  2229  
82cae269cfa953 Konstantin Komarov 2021-08-13  2230  	/* Write copy SDS bucket */
82cae269cfa953 Konstantin Komarov 2021-08-13  2231  	err = ntfs_sb_write_run(sbi, &ni->file.run, mirr_off, d_security,
82cae269cfa953 Konstantin Komarov 2021-08-13  2232  				aligned_sec_size);
82cae269cfa953 Konstantin Komarov 2021-08-13  2233  	if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  2234  		goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2235  
82cae269cfa953 Konstantin Komarov 2021-08-13  2236  	/* Fill SII entry */
82cae269cfa953 Konstantin Komarov 2021-08-13  2237  	sii_e.de.view.data_off =
82cae269cfa953 Konstantin Komarov 2021-08-13  2238  		cpu_to_le16(offsetof(struct NTFS_DE_SII, sec_hdr));
82cae269cfa953 Konstantin Komarov 2021-08-13  2239  	sii_e.de.view.data_size = cpu_to_le16(SIZEOF_SECURITY_HDR);
82cae269cfa953 Konstantin Komarov 2021-08-13  2240  	sii_e.de.view.res = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  2241  	sii_e.de.size = cpu_to_le16(SIZEOF_SII_DIRENTRY);
82cae269cfa953 Konstantin Komarov 2021-08-13  2242  	sii_e.de.key_size = cpu_to_le16(sizeof(d_security->key.sec_id));
82cae269cfa953 Konstantin Komarov 2021-08-13  2243  	sii_e.de.flags = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  2244  	sii_e.de.res = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  2245  	sii_e.sec_id = d_security->key.sec_id;
82cae269cfa953 Konstantin Komarov 2021-08-13  2246  	memcpy(&sii_e.sec_hdr, d_security, SIZEOF_SECURITY_HDR);
82cae269cfa953 Konstantin Komarov 2021-08-13  2247  
82cae269cfa953 Konstantin Komarov 2021-08-13 @2248  	err = indx_insert_entry(indx_sii, ni, &sii_e.de, NULL, NULL);
82cae269cfa953 Konstantin Komarov 2021-08-13  2249  	if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  2250  		goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2251  
82cae269cfa953 Konstantin Komarov 2021-08-13  2252  	/* Fill SDH entry */
82cae269cfa953 Konstantin Komarov 2021-08-13  2253  	sdh_e.de.view.data_off =
82cae269cfa953 Konstantin Komarov 2021-08-13  2254  		cpu_to_le16(offsetof(struct NTFS_DE_SDH, sec_hdr));
82cae269cfa953 Konstantin Komarov 2021-08-13  2255  	sdh_e.de.view.data_size = cpu_to_le16(SIZEOF_SECURITY_HDR);
82cae269cfa953 Konstantin Komarov 2021-08-13  2256  	sdh_e.de.view.res = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  2257  	sdh_e.de.size = cpu_to_le16(SIZEOF_SDH_DIRENTRY);
82cae269cfa953 Konstantin Komarov 2021-08-13  2258  	sdh_e.de.key_size = cpu_to_le16(sizeof(sdh_e.key));
82cae269cfa953 Konstantin Komarov 2021-08-13  2259  	sdh_e.de.flags = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  2260  	sdh_e.de.res = 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  2261  	sdh_e.key.hash = d_security->key.hash;
82cae269cfa953 Konstantin Komarov 2021-08-13  2262  	sdh_e.key.sec_id = d_security->key.sec_id;
82cae269cfa953 Konstantin Komarov 2021-08-13  2263  	memcpy(&sdh_e.sec_hdr, d_security, SIZEOF_SECURITY_HDR);
82cae269cfa953 Konstantin Komarov 2021-08-13  2264  	sdh_e.magic[0] = cpu_to_le16('I');
82cae269cfa953 Konstantin Komarov 2021-08-13  2265  	sdh_e.magic[1] = cpu_to_le16('I');
82cae269cfa953 Konstantin Komarov 2021-08-13  2266  
82cae269cfa953 Konstantin Komarov 2021-08-13  2267  	fnd_clear(fnd_sdh);
82cae269cfa953 Konstantin Komarov 2021-08-13  2268  	err = indx_insert_entry(indx_sdh, ni, &sdh_e.de, (void *)(size_t)1,
82cae269cfa953 Konstantin Komarov 2021-08-13  2269  				fnd_sdh);
82cae269cfa953 Konstantin Komarov 2021-08-13  2270  	if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  2271  		goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  2272  
82cae269cfa953 Konstantin Komarov 2021-08-13  2273  	*security_id = d_security->key.sec_id;
82cae269cfa953 Konstantin Komarov 2021-08-13  2274  	if (inserted)
82cae269cfa953 Konstantin Komarov 2021-08-13  2275  		*inserted = true;
82cae269cfa953 Konstantin Komarov 2021-08-13  2276  
82cae269cfa953 Konstantin Komarov 2021-08-13  2277  	/* Update Id and offset for next descriptor */
82cae269cfa953 Konstantin Komarov 2021-08-13  2278  	sbi->security.next_id += 1;
82cae269cfa953 Konstantin Komarov 2021-08-13  2279  	sbi->security.next_off += aligned_sec_size;
82cae269cfa953 Konstantin Komarov 2021-08-13  2280  
82cae269cfa953 Konstantin Komarov 2021-08-13  2281  out:
82cae269cfa953 Konstantin Komarov 2021-08-13  2282  	fnd_put(fnd_sdh);
82cae269cfa953 Konstantin Komarov 2021-08-13  2283  	mark_inode_dirty(&ni->vfs_inode);
82cae269cfa953 Konstantin Komarov 2021-08-13  2284  	ni_unlock(ni);
82cae269cfa953 Konstantin Komarov 2021-08-13  2285  	ntfs_free(d_security);
82cae269cfa953 Konstantin Komarov 2021-08-13  2286  
82cae269cfa953 Konstantin Komarov 2021-08-13  2287  	return err;
82cae269cfa953 Konstantin Komarov 2021-08-13  2288  }
82cae269cfa953 Konstantin Komarov 2021-08-13  2289  

:::::: The code at line 2248 was first introduced by commit
:::::: 82cae269cfa953032fbb8980a7d554d60fb00b17 fs/ntfs3: Add initialization of super block

:::::: TO: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
:::::: CC: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
