Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9202525991
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376399AbiEMCCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiEMCC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:02:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE12A30AB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652407347; x=1683943347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=moqA+0wstnJxAfC8rVaGY/Z4okTIn8Iu7ndIIqiWfcQ=;
  b=Rc9AkiZ9nCK+wJj5mwiGRI+4SehCq7p/5rii2B6+JWwacMpAElpTz6F9
   S+XGiIUgjSJ8vvI2cwBmk+LVj9OLnrCEnKbjP7EeCIrdH7Vmesac/d1jI
   t8PDoLAXLKnHqgzR0alAlwh+4rS/MjEPXwj0/iUdqzyncBkIZ8J7ewek7
   FZkAA2HgKfEOCVddT+LNBT+yV0Arvf3aizxDrDcTwUXLppjp0hH7sNBcE
   uxPUjwG3OiUTMLs4P32iMPBBgKElPF/+opxx7tM1i3/a2MyTUzW2uzwDy
   VM0sVOxyeM7z22AJbNC0LtqKALQV2Cy7f35I6xN7DiFYAXkWBgXpD2hpt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269860031"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="269860031"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 19:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="603644069"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2022 19:02:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npKdL-000LBI-Uk;
        Fri, 13 May 2022 02:02:23 +0000
Date:   Fri, 13 May 2022 10:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Xie <xiehuan09@gmail.com>, rostedt@goodmis.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, mingo@redhat.com,
        mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: Re: [PATCH v10 1/4] trace: Add trace any kernel object
Message-ID: <202205130923.SJJN7oez-lkp@intel.com>
References: <20220512170008.1301613-2-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512170008.1301613-2-xiehuan09@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on v5.18-rc6 next-20220512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220513/202205130923.SJJN7oez-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
        git checkout 3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/trace_object.c:259:13: error: incompatible function pointer types initializing 'int (*)(struct seq_file *, struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .print                  = trace_object_trigger_print,
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:260:12: error: incompatible function pointer types initializing 'int (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .init                   = event_object_trigger_init,
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:261:12: error: incompatible function pointer types initializing 'void (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'void (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .free                   = trace_object_trigger_free,
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:266:13: error: incompatible function pointer types initializing 'int (*)(struct seq_file *, struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .print                  = trace_object_trigger_print,
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:267:12: error: incompatible function pointer types initializing 'int (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .init                   = event_object_trigger_init,
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:268:12: error: incompatible function pointer types initializing 'void (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'void (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .free                   = trace_object_trigger_free,
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace_object.c:335:61: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
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
   kernel/trace/trace_object.c:356:3: error: implicit declaration of function 'event_trigger_unregister' [-Werror,-Wimplicit-function-declaration]
                   event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
                   ^
   kernel/trace/trace_object.c:356:3: note: did you mean 'event_trigger_register'?
   kernel/trace/trace.h:1650:12: note: 'event_trigger_register' declared here
   extern int event_trigger_register(struct event_command *cmd_ops,
              ^
   kernel/trace/trace_object.c:370:64: error: too few arguments to function call, expected 7, have 4
           ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
                 ~~~~~~~~~~~~~~~~~~~~~~                                  ^
   kernel/trace/trace.h:1650:12: note: 'event_trigger_register' declared here
   extern int event_trigger_register(struct event_command *cmd_ops,
              ^
   1 warning and 8 errors generated.


vim +335 kernel/trace/trace_object.c

   296	
   297	static int
   298	event_object_trigger_parse(struct event_command *cmd_ops,
   299			       struct trace_event_file *file,
   300			       char *glob, char *cmd, char *param_and_filter)
   301	{
   302		struct event_trigger_data *trigger_data;
   303		struct objtrace_trigger_data *obj_data;
   304		struct ftrace_event_field *field;
   305		char *objtrace_cmd, *arg;
   306		char *param, *filter;
   307		int ret;
   308		bool remove;
   309	
   310		remove = event_trigger_check_remove(glob);
   311	
   312		/*
   313		 * separate the param and the filter:
   314		 * objtrace:add:OBJ[:COUNT] [if filter]
   315		 */
   316		ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
   317		if (ret)
   318			return ret;
   319	
   320		objtrace_cmd = strsep(&param, ":");
   321		if (!objtrace_cmd || strcmp(objtrace_cmd, "add")) {
   322			pr_err("error objtrace command\n");
   323			return -EINVAL;
   324		}
   325	
   326		arg = strsep(&param, ":");
   327		if (!arg)
   328			return -EINVAL;
   329	
   330		field = trace_find_event_field(file->event_call, arg);
   331		if (!field)
   332			return -EINVAL;
   333	
   334		if (field->size != sizeof(void *)) {
 > 335			pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
   336			return -EINVAL;
   337		}
   338	
   339		if (remove && !field_exist(file, cmd_ops, field->name))
   340			return -EINVAL;
   341	
   342		obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
   343		if (!obj_data)
   344			return -ENOMEM;
   345	
   346		obj_data->field = field;
   347		obj_data->tr = file->tr;
   348		snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
   349	
   350		trigger_data = event_trigger_alloc(cmd_ops, cmd, param, obj_data);
   351		if (!trigger_data) {
   352			kfree(obj_data);
   353			return -ENOMEM;
   354		}
   355		if (remove) {
   356			event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
   357			kfree(obj_data);
   358			kfree(trigger_data);
   359			return 0;
   360		}
   361	
   362		ret = event_trigger_parse_num(param, trigger_data);
   363		if (ret)
   364			goto out_free;
   365	
   366		ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
   367		if (ret < 0)
   368			goto out_free;
   369	
   370		ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
   371		if (ret)
   372			goto out_free;
   373	
   374		return ret;
   375	
   376	 out_free:
   377		event_trigger_reset_filter(cmd_ops, trigger_data);
   378		kfree(obj_data);
   379		kfree(trigger_data);
   380		return ret;
   381	}
   382	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
