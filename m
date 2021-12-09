Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AECF46E51B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhLIJJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:09:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:62067 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236041AbhLIJJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639040755; x=1670576755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TA5EiU8XA0bdIsTrzaqccfZEBvGhfluXlV7YlnyK+uY=;
  b=JIwnJPBdLKG655aFGyt049QSiByokU4iPlnqNN8CqfEclWIwSVHhounq
   a8OK/xJlWXnGPrLWfucXbl00eBcqDArxS85AKodosUp2m358UCTkDlihs
   6q/STID5a0MPNBmieHAzbdKWoGEdxGqNuw2XkwVvDRqqsWG7Q4sztp+14
   tR09OsIb0dYTCS4mfl6VlPlbYAFfaxG6SITvBwc2j2ROOW5y0I2yI1Jk5
   2PORW8xM9N5/SOWzwQXHGdpLkFMR1HQjSgnllhjR7mcJoHpH5qoHbeoEU
   Or7hyJ5QiLGRWX29F1TsAABpxz6kiE4ABJIul7qQmjwcDdHX5TQrPHFZH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="225313562"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="225313562"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 01:05:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="680255154"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2021 01:05:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvFMZ-0001hn-QB; Thu, 09 Dec 2021 09:05:15 +0000
Date:   Thu, 9 Dec 2021 17:04:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 42/48] fs/f2fs/f2fs.h:4057:67: warning:
 'struct pagevec' declared inside parameter list will not be visible outside
 of this definition or declaration
Message-ID: <202112091654.Ju5aGvVd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   9244dddc51b5e46444a334c881372aa66138f74a
commit: 3fda3cf387c172cc9a528b6556a024627c9843de [42/48] mm: Convert find_lock_entries() to use a folio_batch
config: ia64-buildonly-randconfig-r003-20211207 (https://download.01.org/0day-ci/archive/20211209/202112091654.Ju5aGvVd-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 3fda3cf387c172cc9a528b6556a024627c9843de
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/f2fs/dir.c:13:
>> fs/f2fs/f2fs.h:4057:67: warning: 'struct pagevec' declared inside parameter list will not be visible outside of this definition or declaration
    4057 | bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
         |                                                                   ^~~~~~~


vim +4057 fs/f2fs/f2fs.h

4c8ff7095bef64 Chao Yu       2019-11-01  4036  
4c8ff7095bef64 Chao Yu       2019-11-01  4037  /*
4c8ff7095bef64 Chao Yu       2019-11-01  4038   * compress.c
4c8ff7095bef64 Chao Yu       2019-11-01  4039   */
4c8ff7095bef64 Chao Yu       2019-11-01  4040  #ifdef CONFIG_F2FS_FS_COMPRESSION
4c8ff7095bef64 Chao Yu       2019-11-01  4041  bool f2fs_is_compressed_page(struct page *page);
4c8ff7095bef64 Chao Yu       2019-11-01  4042  struct page *f2fs_compress_control_page(struct page *page);
4c8ff7095bef64 Chao Yu       2019-11-01  4043  int f2fs_prepare_compress_overwrite(struct inode *inode,
4c8ff7095bef64 Chao Yu       2019-11-01  4044  			struct page **pagep, pgoff_t index, void **fsdata);
4c8ff7095bef64 Chao Yu       2019-11-01  4045  bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
4c8ff7095bef64 Chao Yu       2019-11-01  4046  					pgoff_t index, unsigned copied);
3265d3db1f1639 Chao Yu       2020-03-18  4047  int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
4c8ff7095bef64 Chao Yu       2019-11-01  4048  void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
4c8ff7095bef64 Chao Yu       2019-11-01  4049  bool f2fs_is_compress_backend_ready(struct inode *inode);
5e6bbde9598230 Chao Yu       2020-04-08  4050  int f2fs_init_compress_mempool(void);
5e6bbde9598230 Chao Yu       2020-04-08  4051  void f2fs_destroy_compress_mempool(void);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4052  void f2fs_decompress_cluster(struct decompress_io_ctx *dic);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4053  void f2fs_end_read_compressed_page(struct page *page, bool failed,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4054  							block_t blkaddr);
4c8ff7095bef64 Chao Yu       2019-11-01  4055  bool f2fs_cluster_is_empty(struct compress_ctx *cc);
4c8ff7095bef64 Chao Yu       2019-11-01  4056  bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
b368cc5e263411 Fengnan Chang 2021-10-22 @4057  bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
b368cc5e263411 Fengnan Chang 2021-10-22  4058  				int index, int nr_pages);
bbe1da7e34ac5a Chao Yu       2021-08-06  4059  bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
4c8ff7095bef64 Chao Yu       2019-11-01  4060  void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
4c8ff7095bef64 Chao Yu       2019-11-01  4061  int f2fs_write_multi_pages(struct compress_ctx *cc,
4c8ff7095bef64 Chao Yu       2019-11-01  4062  						int *submitted,
4c8ff7095bef64 Chao Yu       2019-11-01  4063  						struct writeback_control *wbc,
4c8ff7095bef64 Chao Yu       2019-11-01  4064  						enum iostat_type io_type);
4c8ff7095bef64 Chao Yu       2019-11-01  4065  int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
94afd6d6e52531 Chao Yu       2021-08-04  4066  void f2fs_update_extent_tree_range_compressed(struct inode *inode,
94afd6d6e52531 Chao Yu       2021-08-04  4067  				pgoff_t fofs, block_t blkaddr, unsigned int llen,
94afd6d6e52531 Chao Yu       2021-08-04  4068  				unsigned int c_len);
4c8ff7095bef64 Chao Yu       2019-11-01  4069  int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
4c8ff7095bef64 Chao Yu       2019-11-01  4070  				unsigned nr_pages, sector_t *last_block_in_bio,
0683728adab251 Chao Yu       2020-02-18  4071  				bool is_readahead, bool for_write);
4c8ff7095bef64 Chao Yu       2019-11-01  4072  struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
7f59b277f79e8a Eric Biggers  2021-01-04  4073  void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed);
7f59b277f79e8a Eric Biggers  2021-01-04  4074  void f2fs_put_page_dic(struct page *page);
94afd6d6e52531 Chao Yu       2021-08-04  4075  unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn);
4c8ff7095bef64 Chao Yu       2019-11-01  4076  int f2fs_init_compress_ctx(struct compress_ctx *cc);
8bfbfb0ddd706b Chao Yu       2021-05-10  4077  void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse);
4c8ff7095bef64 Chao Yu       2019-11-01  4078  void f2fs_init_compress_info(struct f2fs_sb_info *sbi);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4079  int f2fs_init_compress_inode(struct f2fs_sb_info *sbi);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4080  void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi);
31083031709eea Chao Yu       2020-09-14  4081  int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi);
31083031709eea Chao Yu       2020-09-14  4082  void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
c68d6c88302250 Chao Yu       2020-09-14  4083  int __init f2fs_init_compress_cache(void);
c68d6c88302250 Chao Yu       2020-09-14  4084  void f2fs_destroy_compress_cache(void);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4085  struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4086  void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4087  void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4088  						nid_t ino, block_t blkaddr);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4089  bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4090  								block_t blkaddr);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4091  void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino);
5ac443e26a0964 Daeho Jeong   2021-03-15  4092  #define inc_compr_inode_stat(inode)					\
5ac443e26a0964 Daeho Jeong   2021-03-15  4093  	do {								\
5ac443e26a0964 Daeho Jeong   2021-03-15  4094  		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
5ac443e26a0964 Daeho Jeong   2021-03-15  4095  		sbi->compr_new_inode++;					\
5ac443e26a0964 Daeho Jeong   2021-03-15  4096  	} while (0)
5ac443e26a0964 Daeho Jeong   2021-03-15  4097  #define add_compr_block_stat(inode, blocks)				\
5ac443e26a0964 Daeho Jeong   2021-03-15  4098  	do {								\
5ac443e26a0964 Daeho Jeong   2021-03-15  4099  		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
5ac443e26a0964 Daeho Jeong   2021-03-15  4100  		int diff = F2FS_I(inode)->i_cluster_size - blocks;	\
5ac443e26a0964 Daeho Jeong   2021-03-15  4101  		sbi->compr_written_block += blocks;			\
5ac443e26a0964 Daeho Jeong   2021-03-15  4102  		sbi->compr_saved_block += diff;				\
5ac443e26a0964 Daeho Jeong   2021-03-15  4103  	} while (0)
4c8ff7095bef64 Chao Yu       2019-11-01  4104  #else
4c8ff7095bef64 Chao Yu       2019-11-01  4105  static inline bool f2fs_is_compressed_page(struct page *page) { return false; }
4c8ff7095bef64 Chao Yu       2019-11-01  4106  static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
4c8ff7095bef64 Chao Yu       2019-11-01  4107  {
4c8ff7095bef64 Chao Yu       2019-11-01  4108  	if (!f2fs_compressed_file(inode))
4c8ff7095bef64 Chao Yu       2019-11-01  4109  		return true;
4c8ff7095bef64 Chao Yu       2019-11-01  4110  	/* not support compression */
4c8ff7095bef64 Chao Yu       2019-11-01  4111  	return false;
4c8ff7095bef64 Chao Yu       2019-11-01  4112  }
4c8ff7095bef64 Chao Yu       2019-11-01  4113  static inline struct page *f2fs_compress_control_page(struct page *page)
4c8ff7095bef64 Chao Yu       2019-11-01  4114  {
4c8ff7095bef64 Chao Yu       2019-11-01  4115  	WARN_ON_ONCE(1);
4c8ff7095bef64 Chao Yu       2019-11-01  4116  	return ERR_PTR(-EINVAL);
4c8ff7095bef64 Chao Yu       2019-11-01  4117  }
5e6bbde9598230 Chao Yu       2020-04-08  4118  static inline int f2fs_init_compress_mempool(void) { return 0; }
5e6bbde9598230 Chao Yu       2020-04-08  4119  static inline void f2fs_destroy_compress_mempool(void) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4120  static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4121  static inline void f2fs_end_read_compressed_page(struct page *page,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4122  						bool failed, block_t blkaddr)
7f59b277f79e8a Eric Biggers  2021-01-04  4123  {
7f59b277f79e8a Eric Biggers  2021-01-04  4124  	WARN_ON_ONCE(1);
7f59b277f79e8a Eric Biggers  2021-01-04  4125  }
7f59b277f79e8a Eric Biggers  2021-01-04  4126  static inline void f2fs_put_page_dic(struct page *page)
7f59b277f79e8a Eric Biggers  2021-01-04  4127  {
7f59b277f79e8a Eric Biggers  2021-01-04  4128  	WARN_ON_ONCE(1);
7f59b277f79e8a Eric Biggers  2021-01-04  4129  }
94afd6d6e52531 Chao Yu       2021-08-04  4130  static inline unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn) { return 0; }
bbe1da7e34ac5a Chao Yu       2021-08-06  4131  static inline bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4132  static inline int f2fs_init_compress_inode(struct f2fs_sb_info *sbi) { return 0; }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4133  static inline void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi) { }
31083031709eea Chao Yu       2020-09-14  4134  static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return 0; }
31083031709eea Chao Yu       2020-09-14  4135  static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi) { }
c68d6c88302250 Chao Yu       2020-09-14  4136  static inline int __init f2fs_init_compress_cache(void) { return 0; }
c68d6c88302250 Chao Yu       2020-09-14  4137  static inline void f2fs_destroy_compress_cache(void) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4138  static inline void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4139  				block_t blkaddr) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4140  static inline void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4141  				struct page *page, nid_t ino, block_t blkaddr) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4142  static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4143  				struct page *page, block_t blkaddr) { return false; }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4144  static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4145  							nid_t ino) { }
5ac443e26a0964 Daeho Jeong   2021-03-15  4146  #define inc_compr_inode_stat(inode)		do { } while (0)
94afd6d6e52531 Chao Yu       2021-08-04  4147  static inline void f2fs_update_extent_tree_range_compressed(struct inode *inode,
94afd6d6e52531 Chao Yu       2021-08-04  4148  				pgoff_t fofs, block_t blkaddr, unsigned int llen,
94afd6d6e52531 Chao Yu       2021-08-04  4149  				unsigned int c_len) { }
4c8ff7095bef64 Chao Yu       2019-11-01  4150  #endif
4c8ff7095bef64 Chao Yu       2019-11-01  4151  

:::::: The code at line 4057 was first introduced by commit
:::::: b368cc5e26341113453e7458f03cdfe0eeb84a40 f2fs: compress: fix overwrite may reduce compress ratio unproperly

:::::: TO: Fengnan Chang <changfengnan@vivo.com>
:::::: CC: Jaegeuk Kim <jaegeuk@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
