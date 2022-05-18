Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E852BCB8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiERNtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiERNs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9091C5F84
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 569D561877
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCACC385A5;
        Wed, 18 May 2022 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652881734;
        bh=t6vg+AoJ0E/H4BIJrucLZJ9ullbTIosE8DLPtOShRiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A5m7V2RR7OaTSXjEbCi0zHLOpTXq014TbTQrThaWs7sZQkB4KopsSg44PV+J1FcRF
         65G05Yc3HBJkk72obmrCiet/bP4Cond4kGDPPXt1X+olgn9mWkPUHFhaY/9GX7YVSN
         5a+16PuyNn+LSovrK2HaxAewVJA9hcDFXCKsFTU1aDN3ML7qFSrdNdJlNYlyZ3tJXS
         Vju/zt+JZ4P2cmDLgBlL251w/3mGRwSeuzBTzJXCVPFHJ8oh952fgX/16fGGo13NLp
         LGNueXSChNUxnM1+UKEhjfuPkXzj0N+RcH94e7rM/2aGRUBolvEpDyx/Msb0yvYJIv
         gGMzkb1vmq92w==
Date:   Wed, 18 May 2022 22:48:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jeff Xie <xiehuan09@gmail.com>, rostedt@goodmis.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org, mingo@redhat.com,
        mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/4] trace: Add trace any kernel object
Message-Id: <20220518224849.b195cc2380fde43c593d79c5@kernel.org>
In-Reply-To: <202205130923.SJJN7oez-lkp@intel.com>
References: <20220512170008.1301613-2-xiehuan09@gmail.com>
        <202205130923.SJJN7oez-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Can you fix these errors, since these looks real bugs.

Thank you,

On Fri, 13 May 2022 10:01:48 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Jeff,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on rostedt-trace/for-next]
> [also build test WARNING on v5.18-rc6 next-20220512]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
> config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220513/202205130923.SJJN7oez-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220513-010820
>         git checkout 3c91aa291a0fe8b28b02a14827b0c4ca3ebda601
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/trace/trace_object.c:259:13: error: incompatible function pointer types initializing 'int (*)(struct seq_file *, struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
>            .print                  = trace_object_trigger_print,
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace_object.c:260:12: error: incompatible function pointer types initializing 'int (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
>            .init                   = event_object_trigger_init,
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace_object.c:261:12: error: incompatible function pointer types initializing 'void (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'void (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
>            .free                   = trace_object_trigger_free,
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace_object.c:266:13: error: incompatible function pointer types initializing 'int (*)(struct seq_file *, struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct seq_file *, struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
>            .print                  = trace_object_trigger_print,
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace_object.c:267:12: error: incompatible function pointer types initializing 'int (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'int (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
>            .init                   = event_object_trigger_init,
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace_object.c:268:12: error: incompatible function pointer types initializing 'void (*)(struct event_trigger_ops *, struct event_trigger_data *)' with an expression of type 'void (struct event_trigger_data *)' [-Werror,-Wincompatible-function-pointer-types]
>            .free                   = trace_object_trigger_free,
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/trace/trace_object.c:335:61: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
>                    pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
>                                                         ~~~                  ^~~~~~~~~~~~~~
>                                                         %u
>    include/linux/printk.h:489:33: note: expanded from macro 'pr_err'
>            printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>                                   ~~~     ^~~~~~~~~~~
>    include/linux/printk.h:446:60: note: expanded from macro 'printk'
>    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>                                                        ~~~    ^~~~~~~~~~~
>    include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
>                    _p_func(_fmt, ##__VA_ARGS__);                           \
>                            ~~~~    ^~~~~~~~~~~
>    kernel/trace/trace_object.c:356:3: error: implicit declaration of function 'event_trigger_unregister' [-Werror,-Wimplicit-function-declaration]
>                    event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
>                    ^
>    kernel/trace/trace_object.c:356:3: note: did you mean 'event_trigger_register'?
>    kernel/trace/trace.h:1650:12: note: 'event_trigger_register' declared here
>    extern int event_trigger_register(struct event_command *cmd_ops,
>               ^
>    kernel/trace/trace_object.c:370:64: error: too few arguments to function call, expected 7, have 4
>            ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
>                  ~~~~~~~~~~~~~~~~~~~~~~                                  ^
>    kernel/trace/trace.h:1650:12: note: 'event_trigger_register' declared here
>    extern int event_trigger_register(struct event_command *cmd_ops,
>               ^
>    1 warning and 8 errors generated.
> 
> 
> vim +335 kernel/trace/trace_object.c
> 
>    296	
>    297	static int
>    298	event_object_trigger_parse(struct event_command *cmd_ops,
>    299			       struct trace_event_file *file,
>    300			       char *glob, char *cmd, char *param_and_filter)
>    301	{
>    302		struct event_trigger_data *trigger_data;
>    303		struct objtrace_trigger_data *obj_data;
>    304		struct ftrace_event_field *field;
>    305		char *objtrace_cmd, *arg;
>    306		char *param, *filter;
>    307		int ret;
>    308		bool remove;
>    309	
>    310		remove = event_trigger_check_remove(glob);
>    311	
>    312		/*
>    313		 * separate the param and the filter:
>    314		 * objtrace:add:OBJ[:COUNT] [if filter]
>    315		 */
>    316		ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
>    317		if (ret)
>    318			return ret;
>    319	
>    320		objtrace_cmd = strsep(&param, ":");
>    321		if (!objtrace_cmd || strcmp(objtrace_cmd, "add")) {
>    322			pr_err("error objtrace command\n");
>    323			return -EINVAL;
>    324		}
>    325	
>    326		arg = strsep(&param, ":");
>    327		if (!arg)
>    328			return -EINVAL;
>    329	
>    330		field = trace_find_event_field(file->event_call, arg);
>    331		if (!field)
>    332			return -EINVAL;
>    333	
>    334		if (field->size != sizeof(void *)) {
>  > 335			pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
>    336			return -EINVAL;
>    337		}
>    338	
>    339		if (remove && !field_exist(file, cmd_ops, field->name))
>    340			return -EINVAL;
>    341	
>    342		obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
>    343		if (!obj_data)
>    344			return -ENOMEM;
>    345	
>    346		obj_data->field = field;
>    347		obj_data->tr = file->tr;
>    348		snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
>    349	
>    350		trigger_data = event_trigger_alloc(cmd_ops, cmd, param, obj_data);
>    351		if (!trigger_data) {
>    352			kfree(obj_data);
>    353			return -ENOMEM;
>    354		}
>    355		if (remove) {
>    356			event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
>    357			kfree(obj_data);
>    358			kfree(trigger_data);
>    359			return 0;
>    360		}
>    361	
>    362		ret = event_trigger_parse_num(param, trigger_data);
>    363		if (ret)
>    364			goto out_free;
>    365	
>    366		ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
>    367		if (ret < 0)
>    368			goto out_free;
>    369	
>    370		ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
>    371		if (ret)
>    372			goto out_free;
>    373	
>    374		return ret;
>    375	
>    376	 out_free:
>    377		event_trigger_reset_filter(cmd_ops, trigger_data);
>    378		kfree(obj_data);
>    379		kfree(trigger_data);
>    380		return ret;
>    381	}
>    382	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp


-- 
Masami Hiramatsu <mhiramat@kernel.org>
