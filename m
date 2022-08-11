Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804EA58F7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiHKGdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiHKGdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:33:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D070289925;
        Wed, 10 Aug 2022 23:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660199622; x=1691735622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9J/Oq2omGg3kV6w9BoLmf9GzWDVOK4bTwVdy4MVPWLY=;
  b=lOXAIOaEmymaHWIvc2KzgIyQDDflr8dYJ/Ns/1TJGTdZ2Z/uusABywsw
   f5eeFIS6SKXd7/pxLhE73O/uQaPER92/17yZlXwnh1MOMHolk5fR5GPH9
   9dFBPJJLdQ26snrDwIWBZN4UX1HGyX7KGPOu1918F/YW9Ea7lSXJDlWBP
   3wP+9GgaQo1rq8Q296D7BYs1+vLmeKWUZSQym0Iqzy0RvUf45VwzmEYaV
   XgEQTTaRnH3UmiTsPfoPuyk3y8jcTs9qpLPgoQ0HI+CWwpSsQPCZvG453
   Er9ocCp0P6t0hj1wwMbJrmusLJ2ZradIFn8UgjCmzHG0DZGGt2C1f+IbV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="317231377"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="317231377"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 23:33:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="556018518"
Received: from lkp-server02.sh.intel.com (HELO d10ab0927833) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2022 23:33:39 -0700
Received: from kbuild by d10ab0927833 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oM1lD-000039-0Y;
        Thu, 11 Aug 2022 06:33:39 +0000
Date:   Thu, 11 Aug 2022 14:33:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhoun <zhounan@nfschina.com>, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhounan <zhounan@nfschina.com>
Subject: Re: [PATCH] remove unnecessary type casting
Message-ID: <202208111453.iWFQgZet-lkp@intel.com>
References: <20220810083935.83452-1-zhounan@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810083935.83452-1-zhounan@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhoun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19 next-20220811]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhoun/remove-unnecessary-type-casting/20220810-164202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d4252071b97d2027d246f6a82cbee4d52f618b47
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220811/202208111453.iWFQgZet-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/644349c963daf046bc5ed629711825d917f1fcfc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhoun/remove-unnecessary-type-casting/20220810-164202
        git checkout 644349c963daf046bc5ed629711825d917f1fcfc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> security/apparmor/policy.c:1006:23: error: incompatible pointer types initializing 'struct aa_profile *' with an expression of type 'struct aa_policy *' [-Werror,-Wincompatible-pointer-types]
                           struct aa_profile *p = policy;
                                              ^   ~~~~~~
   1 error generated.


vim +1006 security/apparmor/policy.c

   882	
   883	/**
   884	 * aa_replace_profiles - replace profile(s) on the profile list
   885	 * @policy_ns: namespace load is occurring on
   886	 * @label: label that is attempting to load/replace policy
   887	 * @mask: permission mask
   888	 * @udata: serialized data stream  (NOT NULL)
   889	 *
   890	 * unpack and replace a profile on the profile list and uses of that profile
   891	 * by any task creds via invalidating the old version of the profile, which
   892	 * tasks will notice to update their own cred.  If the profile does not exist
   893	 * on the profile list it is added.
   894	 *
   895	 * Returns: size of data consumed else error code on failure.
   896	 */
   897	ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
   898				    u32 mask, struct aa_loaddata *udata)
   899	{
   900		const char *ns_name = NULL, *info = NULL;
   901		struct aa_ns *ns = NULL;
   902		struct aa_load_ent *ent, *tmp;
   903		struct aa_loaddata *rawdata_ent;
   904		const char *op;
   905		ssize_t count, error;
   906		LIST_HEAD(lh);
   907	
   908		op = mask & AA_MAY_REPLACE_POLICY ? OP_PROF_REPL : OP_PROF_LOAD;
   909		aa_get_loaddata(udata);
   910		/* released below */
   911		error = aa_unpack(udata, &lh, &ns_name);
   912		if (error)
   913			goto out;
   914	
   915		/* ensure that profiles are all for the same ns
   916		 * TODO: update locking to remove this constaint. All profiles in
   917		 *       the load set must succeed as a set or the load will
   918		 *       fail. Sort ent list and take ns locks in hierarchy order
   919		 */
   920		count = 0;
   921		list_for_each_entry(ent, &lh, list) {
   922			if (ns_name) {
   923				if (ent->ns_name &&
   924				    strcmp(ent->ns_name, ns_name) != 0) {
   925					info = "policy load has mixed namespaces";
   926					error = -EACCES;
   927					goto fail;
   928				}
   929			} else if (ent->ns_name) {
   930				if (count) {
   931					info = "policy load has mixed namespaces";
   932					error = -EACCES;
   933					goto fail;
   934				}
   935				ns_name = ent->ns_name;
   936			} else
   937				count++;
   938		}
   939		if (ns_name) {
   940			ns = aa_prepare_ns(policy_ns ? policy_ns : labels_ns(label),
   941					   ns_name);
   942			if (IS_ERR(ns)) {
   943				op = OP_PROF_LOAD;
   944				info = "failed to prepare namespace";
   945				error = PTR_ERR(ns);
   946				ns = NULL;
   947				ent = NULL;
   948				goto fail;
   949			}
   950		} else
   951			ns = aa_get_ns(policy_ns ? policy_ns : labels_ns(label));
   952	
   953		mutex_lock_nested(&ns->lock, ns->level);
   954		/* check for duplicate rawdata blobs: space and file dedup */
   955		list_for_each_entry(rawdata_ent, &ns->rawdata_list, list) {
   956			if (aa_rawdata_eq(rawdata_ent, udata)) {
   957				struct aa_loaddata *tmp;
   958	
   959				tmp = __aa_get_loaddata(rawdata_ent);
   960				/* check we didn't fail the race */
   961				if (tmp) {
   962					aa_put_loaddata(udata);
   963					udata = tmp;
   964					break;
   965				}
   966			}
   967		}
   968		/* setup parent and ns info */
   969		list_for_each_entry(ent, &lh, list) {
   970			struct aa_policy *policy;
   971	
   972			ent->new->rawdata = aa_get_loaddata(udata);
   973			error = __lookup_replace(ns, ent->new->base.hname,
   974						 !(mask & AA_MAY_REPLACE_POLICY),
   975						 &ent->old, &info);
   976			if (error)
   977				goto fail_lock;
   978	
   979			if (ent->new->rename) {
   980				error = __lookup_replace(ns, ent->new->rename,
   981							!(mask & AA_MAY_REPLACE_POLICY),
   982							&ent->rename, &info);
   983				if (error)
   984					goto fail_lock;
   985			}
   986	
   987			/* released when @new is freed */
   988			ent->new->ns = aa_get_ns(ns);
   989	
   990			if (ent->old || ent->rename)
   991				continue;
   992	
   993			/* no ref on policy only use inside lock */
   994			policy = __lookup_parent(ns, ent->new->base.hname);
   995			if (!policy) {
   996				struct aa_profile *p;
   997				p = __list_lookup_parent(&lh, ent->new);
   998				if (!p) {
   999					error = -ENOENT;
  1000					info = "parent does not exist";
  1001					goto fail_lock;
  1002				}
  1003				rcu_assign_pointer(ent->new->parent, aa_get_profile(p));
  1004			} else if (policy != &ns->base) {
  1005				/* released on profile replacement or free_profile */
> 1006				struct aa_profile *p = policy;
  1007				rcu_assign_pointer(ent->new->parent, aa_get_profile(p));
  1008			}
  1009		}
  1010	
  1011		/* create new fs entries for introspection if needed */
  1012		if (!udata->dents[AAFS_LOADDATA_DIR]) {
  1013			error = __aa_fs_create_rawdata(ns, udata);
  1014			if (error) {
  1015				info = "failed to create raw_data dir and files";
  1016				ent = NULL;
  1017				goto fail_lock;
  1018			}
  1019		}
  1020		list_for_each_entry(ent, &lh, list) {
  1021			if (!ent->old) {
  1022				struct dentry *parent;
  1023				if (rcu_access_pointer(ent->new->parent)) {
  1024					struct aa_profile *p;
  1025					p = aa_deref_parent(ent->new);
  1026					parent = prof_child_dir(p);
  1027				} else
  1028					parent = ns_subprofs_dir(ent->new->ns);
  1029				error = __aafs_profile_mkdir(ent->new, parent);
  1030			}
  1031	
  1032			if (error) {
  1033				info = "failed to create";
  1034				goto fail_lock;
  1035			}
  1036		}
  1037	
  1038		/* Done with checks that may fail - do actual replacement */
  1039		__aa_bump_ns_revision(ns);
  1040		__aa_loaddata_update(udata, ns->revision);
  1041		list_for_each_entry_safe(ent, tmp, &lh, list) {
  1042			list_del_init(&ent->list);
  1043			op = (!ent->old && !ent->rename) ? OP_PROF_LOAD : OP_PROF_REPL;
  1044	
  1045			if (ent->old && ent->old->rawdata == ent->new->rawdata) {
  1046				/* dedup actual profile replacement */
  1047				audit_policy(label, op, ns_name, ent->new->base.hname,
  1048					     "same as current profile, skipping",
  1049					     error);
  1050				/* break refcount cycle with proxy. */
  1051				aa_put_proxy(ent->new->label.proxy);
  1052				ent->new->label.proxy = NULL;
  1053				goto skip;
  1054			}
  1055	
  1056			/*
  1057			 * TODO: finer dedup based on profile range in data. Load set
  1058			 * can differ but profile may remain unchanged
  1059			 */
  1060			audit_policy(label, op, ns_name, ent->new->base.hname, NULL,
  1061				     error);
  1062	
  1063			if (ent->old) {
  1064				share_name(ent->old, ent->new);
  1065				__replace_profile(ent->old, ent->new);
  1066			} else {
  1067				struct list_head *lh;
  1068	
  1069				if (rcu_access_pointer(ent->new->parent)) {
  1070					struct aa_profile *parent;
  1071	
  1072					parent = update_to_newest_parent(ent->new);
  1073					lh = &parent->base.profiles;
  1074				} else
  1075					lh = &ns->base.profiles;
  1076				__add_profile(lh, ent->new);
  1077			}
  1078		skip:
  1079			aa_load_ent_free(ent);
  1080		}
  1081		__aa_labelset_update_subtree(ns);
  1082		mutex_unlock(&ns->lock);
  1083	
  1084	out:
  1085		aa_put_ns(ns);
  1086		aa_put_loaddata(udata);
  1087		kfree(ns_name);
  1088	
  1089		if (error)
  1090			return error;
  1091		return udata->size;
  1092	
  1093	fail_lock:
  1094		mutex_unlock(&ns->lock);
  1095	
  1096		/* audit cause of failure */
  1097		op = (ent && !ent->old) ? OP_PROF_LOAD : OP_PROF_REPL;
  1098	fail:
  1099		  audit_policy(label, op, ns_name, ent ? ent->new->base.hname : NULL,
  1100			       info, error);
  1101		/* audit status that rest of profiles in the atomic set failed too */
  1102		info = "valid profile in failed atomic policy load";
  1103		list_for_each_entry(tmp, &lh, list) {
  1104			if (tmp == ent) {
  1105				info = "unchecked profile in failed atomic policy load";
  1106				/* skip entry that caused failure */
  1107				continue;
  1108			}
  1109			op = (!tmp->old) ? OP_PROF_LOAD : OP_PROF_REPL;
  1110			audit_policy(label, op, ns_name, tmp->new->base.hname, info,
  1111				     error);
  1112		}
  1113		list_for_each_entry_safe(ent, tmp, &lh, list) {
  1114			list_del_init(&ent->list);
  1115			aa_load_ent_free(ent);
  1116		}
  1117	
  1118		goto out;
  1119	}
  1120	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
