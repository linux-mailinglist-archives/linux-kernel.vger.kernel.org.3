Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C9521C64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344938AbiEJOgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244787AbiEJOJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:09:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5860BBD
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29B45B81DCF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B141C2BBE4;
        Tue, 10 May 2022 13:45:01 +0000 (UTC)
Date:   Tue, 10 May 2022 09:44:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: include/trace/stages/init.h:2:23: warning:
 'str__irq_vectors__trace_system_name' defined but not used
Message-ID: <20220510094459.5a462ad8@gandalf.local.home>
In-Reply-To: <202205100202.Ag0S76wP-lkp@intel.com>
References: <202205100202.Ag0S76wP-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 02:08:23 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
> commit: af6b9668e85ffd1502aada8036ccbf4dbd481708 tracing: Move the defines to create TRACE_EVENTS into their own files
> date:   8 weeks ago
> config: i386-randconfig-s002-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100202.Ag0S76wP-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af6b9668e85ffd1502aada8036ccbf4dbd481708
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout af6b9668e85ffd1502aada8036ccbf4dbd481708
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/trace/trace_events.h:27,
>                     from include/trace/define_trace.h:102,
>                     from arch/x86/include/asm/trace/irq_vectors.h:383,
>                     from arch/x86/kernel/irq.c:27:

Hmm, when I do:

	$ make arch/x86/kernel/irq.i
	$ astyle arch/x86/kernel/irq.i
	$ grep str__irq_irq_vectors__trace_system_name

  static const char str__irq_vectors__trace_system_name[] = "irq_vectors";
  static struct trace_event_class __attribute__((__used__)) __attribute__((__section__(".ref.data"))) event_class_x86_irq_vector = { .system = str__irq_vectors__trace_system_name, .fields_array = trace_event_fields_x86_irq_vector, .fields = { &(event_class_x86_irq_vector.fields),  &(event_class_x86_irq_vector.fields) }, .raw_init = trace_event_raw_init, .probe = trace_event_raw_event_x86_irq_vector, .reg = trace_event_reg, .perf_probe = perf_trace_x86_irq_vector, };
   static struct trace_event_class __attribute__((__used__)) __attribute__((__section__(".ref.data"))) event_class_vector_config = { .system = str__irq_vectors__trace_system_name, .fields_array = trace_event_fields_vector_config, .fields = { &(event_class_vector_config.fields), &(event_class_vector_config.fields) }, .raw_init = trace_event_raw_init, .probe = trace_event_raw_event_vector_config, .reg = trace_event_reg, .perf_probe = perf_trace_vector_config, };;
[..]

How is it not used?

-- Steve


> >> include/trace/stages/init.h:2:23: warning: 'str__irq_vectors__trace_system_name' defined but not used [-Wunused-const-variable=]  
>        2 | #define __app__(x, y) str__##x##y
>          |                       ^~~~~
>    include/trace/stages/init.h:3:21: note: in expansion of macro '__app__'
>        3 | #define __app(x, y) __app__(x, y)
>          |                     ^~~~~~~
>    include/trace/stages/init.h:5:29: note: in expansion of macro '__app'
>        5 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
>          |                             ^~~~~
>    include/trace/stages/init.h:8:27: note: in expansion of macro 'TRACE_SYSTEM_STRING'
>        8 |         static const char TRACE_SYSTEM_STRING[] =       \
>          |                           ^~~~~~~~~~~~~~~~~~~
>    include/trace/stages/init.h:11:1: note: in expansion of macro 'TRACE_MAKE_SYSTEM_STR'
>       11 | TRACE_MAKE_SYSTEM_STR();
>          | ^~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/str__irq_vectors__trace_system_name +2 include/trace/stages/init.h
> 
>    > 2	#define __app__(x, y) str__##x##y  
>      3	#define __app(x, y) __app__(x, y)
>      4	
> 

