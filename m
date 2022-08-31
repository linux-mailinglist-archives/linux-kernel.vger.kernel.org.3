Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0E5A7E67
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiHaNNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiHaNNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:13:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB00C6524;
        Wed, 31 Aug 2022 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661951596; x=1693487596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yx07JPWkVTrCh1lNzbyATrx9K6sZAkMoWbC7cGsdog4=;
  b=OnSH/JVtetIrX3wh7h9x8uwuuFhfAYfDitDh5ciVilqJ5ypnH7D4A0dB
   2FVdyyPSI1rDmTqm1+Mqm2d31Fazb9hbGE0pYHDw9tS3baHAZ/7L7uYS2
   q+kEIeo/WZNDGMUZIeCFjdihpWeGwpkV+ZCaN9YlFIKZa6nGObS9b9Y6W
   MJn8QkE1nXdOM7tL/Wyzr7oAdmhcinpFh26GImKHe4m6qI9KNyfMpPpdD
   hMmcGsNsnER2EGDqkEe+pA8wDHoW4nTabb6N600IRfHR/zPWuiRchSicx
   Cgui17oYu3RczXwF/tNAnaI/Houxr1tY3KHxpAvJUtccFFC+vT8CJLSng
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="282415868"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="282415868"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 06:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="645226788"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 31 Aug 2022 06:13:12 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTNWq-0000Jb-0v;
        Wed, 31 Aug 2022 13:13:12 +0000
Date:   Wed, 31 Aug 2022 21:13:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/3] fortify: cosmetic cleanups to __compiletime_strlen
Message-ID: <202208312049.JxYsAiD2-lkp@intel.com>
References: <20220830205309.312864-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830205309.312864-3-ndesaulniers@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

I love your patch! Perhaps something to improve:

[auto build test WARNING on kees/for-next/hardening]
[also build test WARNING on kees/for-next/pstore hid/for-next linus/master v6.0-rc3 next-20220831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Desaulniers/Fix-FORTIFY-y-UBSAN_LOCAL_BOUNDS-y/20220831-045536
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220831/202208312049.JxYsAiD2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ab66e7d1d8a90f6addac0da9b3ae13d77f095f76
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nick-Desaulniers/Fix-FORTIFY-y-UBSAN_LOCAL_BOUNDS-y/20220831-045536
        git checkout ab66e7d1d8a90f6addac0da9b3ae13d77f095f76
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mtd/ubi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/mtd/ubi/cdev.c: In function 'rename_volumes':
>> drivers/mtd/ubi/cdev.c:710:61: warning: array subscript -1 is below array bounds of 'struct <anonymous>[32]' [-Warray-bounds]
     710 |                         if (req->ents[i].vol_id == req->ents[n].vol_id) {
         |                                                    ~~~~~~~~~^~~
   In file included from drivers/mtd/ubi/cdev.c:33:
   include/uapi/mtd/ubi-user.h:404:11: note: while referencing 'ents'
     404 |         } ents[UBI_MAX_RNVOL];
         |           ^~~~
   drivers/mtd/ubi/cdev.c:715:68: warning: array subscript -1 is below array bounds of 'struct <anonymous>[32]' [-Warray-bounds]
     715 |                         if (!strcmp(req->ents[i].name, req->ents[n].name)) {
         |                                                        ~~~~~~~~~~~~^~~~~
   In file included from drivers/mtd/ubi/cdev.c:33:
   include/uapi/mtd/ubi-user.h:404:11: note: while referencing 'ents'
     404 |         } ents[UBI_MAX_RNVOL];
         |           ^~~~


vim +710 drivers/mtd/ubi/cdev.c

801c135ce73d5d Artem B. Bityutskiy 2006-06-27  668  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  669  /**
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  670   * rename_volumes - rename UBI volumes.
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  671   * @ubi: UBI device description object
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  672   * @req: volumes re-name request
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  673   *
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  674   * This is a helper function for the volume re-name IOCTL which validates the
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  675   * the request, opens the volume and calls corresponding volumes management
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  676   * function. Returns zero in case of success and a negative error code in case
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  677   * of failure.
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  678   */
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  679  static int rename_volumes(struct ubi_device *ubi,
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  680  			  struct ubi_rnvol_req *req)
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  681  {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  682  	int i, n, err;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  683  	struct list_head rename_list;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  684  	struct ubi_rename_entry *re, *re1;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  685  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  686  	if (req->count < 0 || req->count > UBI_MAX_RNVOL)
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  687  		return -EINVAL;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  688  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  689  	if (req->count == 0)
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  690  		return 0;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  691  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  692  	/* Validate volume IDs and names in the request */
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  693  	for (i = 0; i < req->count; i++) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  694  		if (req->ents[i].vol_id < 0 ||
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  695  		    req->ents[i].vol_id >= ubi->vtbl_slots)
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  696  			return -EINVAL;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  697  		if (req->ents[i].name_len < 0)
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  698  			return -EINVAL;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  699  		if (req->ents[i].name_len > UBI_VOL_NAME_MAX)
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  700  			return -ENAMETOOLONG;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  701  		req->ents[i].name[req->ents[i].name_len] = '\0';
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  702  		n = strlen(req->ents[i].name);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  703  		if (n != req->ents[i].name_len)
7fbbd05799976c Dan Carpenter       2014-09-19  704  			return -EINVAL;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  705  	}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  706  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  707  	/* Make sure volume IDs and names are unique */
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  708  	for (i = 0; i < req->count - 1; i++) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  709  		for (n = i + 1; n < req->count; n++) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13 @710  			if (req->ents[i].vol_id == req->ents[n].vol_id) {
326087033108e7 Tanya Brokhman      2014-10-20  711  				ubi_err(ubi, "duplicated volume id %d",
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  712  					req->ents[i].vol_id);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  713  				return -EINVAL;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  714  			}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  715  			if (!strcmp(req->ents[i].name, req->ents[n].name)) {
326087033108e7 Tanya Brokhman      2014-10-20  716  				ubi_err(ubi, "duplicated volume name \"%s\"",
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  717  					req->ents[i].name);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  718  				return -EINVAL;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  719  			}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  720  		}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  721  	}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  722  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  723  	/* Create the re-name list */
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  724  	INIT_LIST_HEAD(&rename_list);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  725  	for (i = 0; i < req->count; i++) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  726  		int vol_id = req->ents[i].vol_id;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  727  		int name_len = req->ents[i].name_len;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  728  		const char *name = req->ents[i].name;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  729  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  730  		re = kzalloc(sizeof(struct ubi_rename_entry), GFP_KERNEL);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  731  		if (!re) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  732  			err = -ENOMEM;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  733  			goto out_free;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  734  		}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  735  
892abde56c1c5a Richard Weinberger  2014-11-24  736  		re->desc = ubi_open_volume(ubi->ubi_num, vol_id, UBI_METAONLY);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  737  		if (IS_ERR(re->desc)) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  738  			err = PTR_ERR(re->desc);
326087033108e7 Tanya Brokhman      2014-10-20  739  			ubi_err(ubi, "cannot open volume %d, error %d",
326087033108e7 Tanya Brokhman      2014-10-20  740  				vol_id, err);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  741  			kfree(re);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  742  			goto out_free;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  743  		}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  744  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  745  		/* Skip this re-naming if the name does not really change */
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  746  		if (re->desc->vol->name_len == name_len &&
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  747  		    !memcmp(re->desc->vol->name, name, name_len)) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  748  			ubi_close_volume(re->desc);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  749  			kfree(re);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  750  			continue;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  751  		}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  752  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  753  		re->new_name_len = name_len;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  754  		memcpy(re->new_name, name, name_len);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  755  		list_add_tail(&re->list, &rename_list);
719bb84017fcfc Artem Bityutskiy    2012-08-27  756  		dbg_gen("will rename volume %d from \"%s\" to \"%s\"",
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  757  			vol_id, re->desc->vol->name, name);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  758  	}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  759  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  760  	if (list_empty(&rename_list))
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  761  		return 0;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  762  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  763  	/* Find out the volumes which have to be removed */
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  764  	list_for_each_entry(re, &rename_list, list) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  765  		struct ubi_volume_desc *desc;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  766  		int no_remove_needed = 0;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  767  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  768  		/*
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  769  		 * Volume @re->vol_id is going to be re-named to
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  770  		 * @re->new_name, while its current name is @name. If a volume
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  771  		 * with name @re->new_name currently exists, it has to be
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  772  		 * removed, unless it is also re-named in the request (@req).
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  773  		 */
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  774  		list_for_each_entry(re1, &rename_list, list) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  775  			if (re->new_name_len == re1->desc->vol->name_len &&
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  776  			    !memcmp(re->new_name, re1->desc->vol->name,
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  777  				    re1->desc->vol->name_len)) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  778  				no_remove_needed = 1;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  779  				break;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  780  			}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  781  		}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  782  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  783  		if (no_remove_needed)
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  784  			continue;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  785  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  786  		/*
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  787  		 * It seems we need to remove volume with name @re->new_name,
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  788  		 * if it exists.
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  789  		 */
f2863c54f30ccc Artem Bityutskiy    2008-12-28  790  		desc = ubi_open_volume_nm(ubi->ubi_num, re->new_name,
f2863c54f30ccc Artem Bityutskiy    2008-12-28  791  					  UBI_EXCLUSIVE);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  792  		if (IS_ERR(desc)) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  793  			err = PTR_ERR(desc);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  794  			if (err == -ENODEV)
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  795  				/* Re-naming into a non-existing volume name */
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  796  				continue;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  797  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  798  			/* The volume exists but busy, or an error occurred */
326087033108e7 Tanya Brokhman      2014-10-20  799  			ubi_err(ubi, "cannot open volume \"%s\", error %d",
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  800  				re->new_name, err);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  801  			goto out_free;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  802  		}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  803  
01ebc12f5f2e88 Julia Lawall        2010-08-07  804  		re1 = kzalloc(sizeof(struct ubi_rename_entry), GFP_KERNEL);
01ebc12f5f2e88 Julia Lawall        2010-08-07  805  		if (!re1) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  806  			err = -ENOMEM;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  807  			ubi_close_volume(desc);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  808  			goto out_free;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  809  		}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  810  
01ebc12f5f2e88 Julia Lawall        2010-08-07  811  		re1->remove = 1;
01ebc12f5f2e88 Julia Lawall        2010-08-07  812  		re1->desc = desc;
01ebc12f5f2e88 Julia Lawall        2010-08-07  813  		list_add(&re1->list, &rename_list);
719bb84017fcfc Artem Bityutskiy    2012-08-27  814  		dbg_gen("will remove volume %d, name \"%s\"",
01ebc12f5f2e88 Julia Lawall        2010-08-07  815  			re1->desc->vol->vol_id, re1->desc->vol->name);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  816  	}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  817  
f089c0b28cdba1 Artem Bityutskiy    2009-05-07  818  	mutex_lock(&ubi->device_mutex);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  819  	err = ubi_rename_volumes(ubi, &rename_list);
f089c0b28cdba1 Artem Bityutskiy    2009-05-07  820  	mutex_unlock(&ubi->device_mutex);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  821  
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  822  out_free:
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  823  	list_for_each_entry_safe(re, re1, &rename_list, list) {
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  824  		ubi_close_volume(re->desc);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  825  		list_del(&re->list);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  826  		kfree(re);
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  827  	}
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  828  	return err;
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  829  }
f40ac9cdf69912 Artem Bityutskiy    2008-07-13  830  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
