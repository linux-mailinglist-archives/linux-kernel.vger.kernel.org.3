Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16353C04E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbiFBVM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiFBVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:12:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52092F14
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654204374; x=1685740374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EG4fFmbtoez27DKDle4Ouq6qSysWshoV4GNB3C6WPzQ=;
  b=iOnQ6GZ3xDhDfO/tQ06/nm93+BMdNiwxIXGetckSRUsT0WaQEmb2J0pu
   nCABJF9y2BbT/gdhLSZHd/lF+7KFdzBzv37qACDiiQvoiK6UTwBZv1vxO
   XtADgOCUSY9A2uG1+6Zba4x6XhFdxjW4KuGQ+jHeXKREUJnrHLiMkRnfT
   dHlx/bPKwxJMLa46nVPYhtbl6DSme2fB0MQVPPR7vWDJXGc9vcF4lajgO
   6Sd+udReiDLXaGEcCNoOuZR5aEAyQ4C1CjKZIxSbT63Q82fkhBuekQ7iO
   9rsw2LigDLhUnSO1fSHW/oxtV2q6llBPc+/JqVJdecBSIVLGDfVFKUttO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="336738610"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="336738610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 14:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="634232611"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2022 14:12:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nws7e-0005Rx-8h;
        Thu, 02 Jun 2022 21:12:50 +0000
Date:   Fri, 3 Jun 2022 05:12:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Xie <xiehuan09@gmail.com>, rostedt@goodmis.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, mingo@redhat.com,
        mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: Re: [PATCH v11 1/4] trace: Add trace any kernel object
Message-ID: <202206030515.4lqqkb3W-lkp@intel.com>
References: <20220602164518.286295-2-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602164518.286295-2-xiehuan09@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on b39181f7c6907dc66ff937b74758671fa6ba430c]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220603-004723
base:   b39181f7c6907dc66ff937b74758671fa6ba430c
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220603/202206030515.4lqqkb3W-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/765253f020469f94856aedc5a3fe5444e1e8f4e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220603-004723
        git checkout 765253f020469f94856aedc5a3fe5444e1e8f4e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/qxl/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_object.c:336:61: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
                   pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
                                                        ~~~                  ^~~~~~~~~~~~~~
                                                        %u
   include/linux/printk.h:489:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +336 kernel/trace/trace_object.c

   297	
   298	static int
   299	event_object_trigger_parse(struct event_command *cmd_ops,
   300			       struct trace_event_file *file,
   301			       char *glob, char *cmd, char *param_and_filter)
   302	{
   303		struct event_trigger_data *trigger_data;
   304		struct objtrace_trigger_data *obj_data;
   305		struct ftrace_event_field *field;
   306		char *objtrace_cmd, *arg;
   307		char *param, *filter;
   308		int ret;
   309		bool remove;
   310	
   311		remove = event_trigger_check_remove(glob);
   312	
   313		/*
   314		 * separate the param and the filter:
   315		 * objtrace:add:OBJ[:COUNT] [if filter]
   316		 */
   317		ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
   318		if (ret)
   319			return ret;
   320	
   321		objtrace_cmd = strsep(&param, ":");
   322		if (!objtrace_cmd || strcmp(objtrace_cmd, OBJTRACE_CMD_ADD)) {
   323			pr_err("error objtrace command\n");
   324			return -EINVAL;
   325		}
   326	
   327		arg = strsep(&param, ":");
   328		if (!arg)
   329			return -EINVAL;
   330	
   331		field = trace_find_event_field(file->event_call, arg);
   332		if (!field)
   333			return -EINVAL;
   334	
   335		if (field->size != sizeof(void *)) {
 > 336			pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
   337			return -EINVAL;
   338		}
   339	
   340		if (remove && !field_exist(file, cmd_ops, field->name))
   341			return -ENOENT;
   342	
   343		obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
   344		if (!obj_data)
   345			return -ENOMEM;
   346	
   347		obj_data->field = field;
   348		obj_data->tr = file->tr;
   349		snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
   350	
   351		trigger_data = event_trigger_alloc(cmd_ops, cmd, param, obj_data);
   352		if (!trigger_data) {
   353			kfree(obj_data);
   354			return -ENOMEM;
   355		}
   356		if (remove) {
   357			event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
   358			kfree(obj_data);
   359			kfree(trigger_data);
   360			return 0;
   361		}
   362	
   363		ret = event_trigger_parse_num(param, trigger_data);
   364		if (ret)
   365			goto out_free;
   366	
   367		ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
   368		if (ret < 0)
   369			goto out_free;
   370	
   371		ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
   372		if (ret)
   373			goto out_free;
   374	
   375		return ret;
   376	
   377	 out_free:
   378		event_trigger_reset_filter(cmd_ops, trigger_data);
   379		kfree(obj_data);
   380		kfree(trigger_data);
   381		return ret;
   382	}
   383	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
