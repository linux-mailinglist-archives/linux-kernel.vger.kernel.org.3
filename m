Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E6525AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377072AbiEMEvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377018AbiEMEvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:51:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C152B275C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652417462; x=1683953462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GQ/3W0yeRX01Td6eUwkb5hECWeK9LIDmrxjCcyOuNBE=;
  b=gPz/48nIpjdz8xbfHmX2+OPo82c0HxQdAcFfrDhofJkSKSqnsldOMESB
   xVX5HjHJ/WL4G3Uf3CsnFxseMF1IimUGi7HE4eP0Bn4qp0Z+HWA8tXmC5
   dw5MFYifla1olVOdF2q8hIBCC3vL19e/KbZhUmAlYjHOwdDw2xFxr7s7V
   bwzclX9h5aH9+I1DQyIxVorg6DVBIG3QgESSDNxt0xyyZ2/KPM8uD7+rI
   6/2KoG5ECohT4cz4D+pCi14RPwhNGya/DeHYD8yJm3uPpJPevF6dQXJn6
   X8m5bzIizrmCEMnhIovGG1PT0IqyFaW9tI71Hl6bwQ8Eh5yBzKoAS5COD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257761082"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="257761082"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 21:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="896095234"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2022 21:50:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npNGT-000LKw-SB;
        Fri, 13 May 2022 04:50:57 +0000
Date:   Fri, 13 May 2022 12:50:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Xie <xiehuan09@gmail.com>, rostedt@goodmis.org
Cc:     kbuild-all@lists.01.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org,
        Jeff Xie <xiehuan09@gmail.com>
Subject: Re: [PATCH v10 1/4] trace: Add trace any kernel object
Message-ID: <202205131202.bfJ4e2hY-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rostedt-trace/for-next]
[also build test ERROR on v5.18-rc6 next-20220512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220513/202205131202.bfJ4e2hY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
        git checkout 3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/trace/trace_object.c:259:35: error: initialization of 'int (*)(struct seq_file *, struct event_trigger_ops *, struct event_trigger_data *)' from incompatible pointer type 'int (*)(struct seq_file *, struct event_trigger_data *)' [-Werror=incompatible-pointer-types]
     259 |         .print                  = trace_object_trigger_print,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:259:35: note: (near initialization for 'objecttrace_trigger_ops.print')
>> kernel/trace/trace_object.c:260:35: error: initialization of 'int (*)(struct event_trigger_ops *, struct event_trigger_data *)' from incompatible pointer type 'int (*)(struct event_trigger_data *)' [-Werror=incompatible-pointer-types]
     260 |         .init                   = event_object_trigger_init,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:260:35: note: (near initialization for 'objecttrace_trigger_ops.init')
>> kernel/trace/trace_object.c:261:35: error: initialization of 'void (*)(struct event_trigger_ops *, struct event_trigger_data *)' from incompatible pointer type 'void (*)(struct event_trigger_data *)' [-Werror=incompatible-pointer-types]
     261 |         .free                   = trace_object_trigger_free,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:261:35: note: (near initialization for 'objecttrace_trigger_ops.free')
   kernel/trace/trace_object.c:266:35: error: initialization of 'int (*)(struct seq_file *, struct event_trigger_ops *, struct event_trigger_data *)' from incompatible pointer type 'int (*)(struct seq_file *, struct event_trigger_data *)' [-Werror=incompatible-pointer-types]
     266 |         .print                  = trace_object_trigger_print,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:266:35: note: (near initialization for 'objecttrace_count_trigger_ops.print')
   kernel/trace/trace_object.c:267:35: error: initialization of 'int (*)(struct event_trigger_ops *, struct event_trigger_data *)' from incompatible pointer type 'int (*)(struct event_trigger_data *)' [-Werror=incompatible-pointer-types]
     267 |         .init                   = event_object_trigger_init,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:267:35: note: (near initialization for 'objecttrace_count_trigger_ops.init')
   kernel/trace/trace_object.c:268:35: error: initialization of 'void (*)(struct event_trigger_ops *, struct event_trigger_data *)' from incompatible pointer type 'void (*)(struct event_trigger_data *)' [-Werror=incompatible-pointer-types]
     268 |         .free                   = trace_object_trigger_free,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_object.c:268:35: note: (near initialization for 'objecttrace_count_trigger_ops.free')
   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/seq_buf.h:5,
                    from include/linux/trace_seq.h:5,
                    from kernel/trace/trace_output.h:5,
                    from kernel/trace/trace_object.c:9:
   kernel/trace/trace_object.c: In function 'event_object_trigger_parse':
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'printk'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   kernel/trace/trace_object.c:335:17: note: in expansion of macro 'pr_err'
     335 |                 pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
         |                 ^~~~~~
>> kernel/trace/trace_object.c:356:17: error: implicit declaration of function 'event_trigger_unregister'; did you mean 'event_trigger_register'? [-Werror=implicit-function-declaration]
     356 |                 event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                 event_trigger_register
>> kernel/trace/trace_object.c:370:59: error: passing argument 4 of 'event_trigger_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
     370 |         ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
         |                                                           ^~~~~~~~~~~~
         |                                                           |
         |                                                           struct event_trigger_data *
   In file included from kernel/trace/trace_output.h:6,
                    from kernel/trace/trace_object.c:9:
   kernel/trace/trace.h:1653:41: note: expected 'char *' but argument is of type 'struct event_trigger_data *'
    1653 |                                   char *cmd,
         |                                   ~~~~~~^~~
>> kernel/trace/trace_object.c:370:15: error: too few arguments to function 'event_trigger_register'
     370 |         ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
         |               ^~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/trace_output.h:6,
                    from kernel/trace/trace_object.c:9:
   kernel/trace/trace.h:1650:12: note: declared here
    1650 | extern int event_trigger_register(struct event_command *cmd_ops,
         |            ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +259 kernel/trace/trace_object.c

   256	
   257	static struct event_trigger_ops objecttrace_trigger_ops = {
   258		.trigger		= trace_object_trigger,
 > 259		.print			= trace_object_trigger_print,
 > 260		.init			= event_object_trigger_init,
 > 261		.free			= trace_object_trigger_free,
   262	};
   263	
   264	static struct event_trigger_ops objecttrace_count_trigger_ops = {
   265		.trigger		= trace_object_count_trigger,
   266		.print			= trace_object_trigger_print,
   267		.init			= event_object_trigger_init,
   268		.free			= trace_object_trigger_free,
   269	};
   270	
   271	static struct event_trigger_ops *
   272	objecttrace_get_trigger_ops(char *cmd, char *param)
   273	{
   274		return param ? &objecttrace_count_trigger_ops : &objecttrace_trigger_ops;
   275	}
   276	
   277	static bool field_exist(struct trace_event_file *file,
   278				struct event_command *cmd_ops,
   279				const char *field_name)
   280	{
   281		struct event_trigger_data *data;
   282		struct objtrace_trigger_data *obj_data;
   283	
   284		lockdep_assert_held(&event_mutex);
   285	
   286		list_for_each_entry(data, &file->triggers, list) {
   287			if (data->cmd_ops->trigger_type == cmd_ops->trigger_type) {
   288				obj_data = data->private_data;
   289				if (!strcmp(obj_data->field->name, field_name))
   290					return true;
   291			}
   292		}
   293	
   294		return false;
   295	}
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
   335			pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
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
 > 356			event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
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
 > 370		ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
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
