Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB2B53CC63
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiFCPhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbiFCPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:37:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C813DCA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 86EFBCE2379
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B2FC34114;
        Fri,  3 Jun 2022 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654270652;
        bh=suq/woGG7vWxkcVyFOYn9ju0qxii5vlaISAzo0sGVLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5Oy2GwgtF3VGX/G9vLtV6KU1KzzAVFaVJ6z/d7Jj0z+U2r5YmmwH7ug8OQUw2H7R
         xy6QYSRvaIceLMy02O1JS6dMbV3eSTVn7DkWfXMZl1cLfLr5GgcvrOS50801luUByE
         A9564BbybLUSIVMZJeLdjNxgEXz4k1973wvEU8IW5Yo/FwHBgzyScsro4ZwynkjgjK
         m5WOtOZJ7lWhK+2QEsmJDXzjGS65Idx45IuREk+C8fFxxDab+0UpOeaWd/LvB9y2A7
         gv+EK1zJzIDpv7UK7BlVwrpw90SwzEpKLkhXGnv4BM8sR/ar90yRaKJ5I6KW+dL+ik
         CKb+a7Mf19BUw==
Date:   Fri, 3 Jun 2022 08:37:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, mingo@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] trace: Add trace any kernel object
Message-ID: <YpoqulzEvwNDHFMH@dev-arch.thelio-3990X>
References: <20220602164518.286295-2-xiehuan09@gmail.com>
 <202206030515.4lqqkb3W-lkp@intel.com>
 <CAEr6+ED6oJV1BmAQy6T592GX751t9QB==0vWcXUDMw3WL0YWtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEr6+ED6oJV1BmAQy6T592GX751t9QB==0vWcXUDMw3WL0YWtA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 09:48:07AM +0800, Jeff Xie wrote:
> Hi lkp,
> 
> On Fri, Jun 3, 2022 at 5:12 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Jeff,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on b39181f7c6907dc66ff937b74758671fa6ba430c]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220603-004723
> > base:   b39181f7c6907dc66ff937b74758671fa6ba430c
> > config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220603/202206030515.4lqqkb3W-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/765253f020469f94856aedc5a3fe5444e1e8f4e8
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-objtrace-trigger-to-trace-the-kernel-object/20220603-004723
> >         git checkout 765253f020469f94856aedc5a3fe5444e1e8f4e8
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/qxl/ kernel/trace/
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> kernel/trace/trace_object.c:336:61: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
> >                    pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
> >                                                         ~~~                  ^~~~~~~~~~~~~~
> >                                                         %u
> 
> I will  double check it ,the sizeof(void *) on x86_64 is type ‘long
> unsigned int’.

Per Documentation/core-api/printk-formats.rst, sizeof returns size_t,
which should use the %zu specifier.

Cheers,
Nathan

> >    include/linux/printk.h:489:33: note: expanded from macro 'pr_err'
> >            printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> >                                   ~~~     ^~~~~~~~~~~
> >    include/linux/printk.h:446:60: note: expanded from macro 'printk'
> >    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
> >                                                        ~~~    ^~~~~~~~~~~
> >    include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
> >                    _p_func(_fmt, ##__VA_ARGS__);                           \
> >                            ~~~~    ^~~~~~~~~~~
> >    1 warning generated.
> >
> >
> > vim +336 kernel/trace/trace_object.c
> >
> >    297
> >    298  static int
> >    299  event_object_trigger_parse(struct event_command *cmd_ops,
> >    300                         struct trace_event_file *file,
> >    301                         char *glob, char *cmd, char *param_and_filter)
> >    302  {
> >    303          struct event_trigger_data *trigger_data;
> >    304          struct objtrace_trigger_data *obj_data;
> >    305          struct ftrace_event_field *field;
> >    306          char *objtrace_cmd, *arg;
> >    307          char *param, *filter;
> >    308          int ret;
> >    309          bool remove;
> >    310
> >    311          remove = event_trigger_check_remove(glob);
> >    312
> >    313          /*
> >    314           * separate the param and the filter:
> >    315           * objtrace:add:OBJ[:COUNT] [if filter]
> >    316           */
> >    317          ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
> >    318          if (ret)
> >    319                  return ret;
> >    320
> >    321          objtrace_cmd = strsep(&param, ":");
> >    322          if (!objtrace_cmd || strcmp(objtrace_cmd, OBJTRACE_CMD_ADD)) {
> >    323                  pr_err("error objtrace command\n");
> >    324                  return -EINVAL;
> >    325          }
> >    326
> >    327          arg = strsep(&param, ":");
> >    328          if (!arg)
> >    329                  return -EINVAL;
> >    330
> >    331          field = trace_find_event_field(file->event_call, arg);
> >    332          if (!field)
> >    333                  return -EINVAL;
> >    334
> >    335          if (field->size != sizeof(void *)) {
> >  > 336                  pr_err("the size of the %s should be:%ld\n", field->name, sizeof(void *));
> >    337                  return -EINVAL;
> >    338          }
> >    339
> >    340          if (remove && !field_exist(file, cmd_ops, field->name))
> >    341                  return -ENOENT;
> >    342
> >    343          obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
> >    344          if (!obj_data)
> >    345                  return -ENOMEM;
> >    346
> >    347          obj_data->field = field;
> >    348          obj_data->tr = file->tr;
> >    349          snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
> >    350
> >    351          trigger_data = event_trigger_alloc(cmd_ops, cmd, param, obj_data);
> >    352          if (!trigger_data) {
> >    353                  kfree(obj_data);
> >    354                  return -ENOMEM;
> >    355          }
> >    356          if (remove) {
> >    357                  event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
> >    358                  kfree(obj_data);
> >    359                  kfree(trigger_data);
> >    360                  return 0;
> >    361          }
> >    362
> >    363          ret = event_trigger_parse_num(param, trigger_data);
> >    364          if (ret)
> >    365                  goto out_free;
> >    366
> >    367          ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
> >    368          if (ret < 0)
> >    369                  goto out_free;
> >    370
> >    371          ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
> >    372          if (ret)
> >    373                  goto out_free;
> >    374
> >    375          return ret;
> >    376
> >    377   out_free:
> >    378          event_trigger_reset_filter(cmd_ops, trigger_data);
> >    379          kfree(obj_data);
> >    380          kfree(trigger_data);
> >    381          return ret;
> >    382  }
> >    383
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> 
> Thanks,
> JeffXie
> 
