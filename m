Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8E4C92F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiCASZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiCASZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:25:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8619A6514D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:24:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C851B81BE7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C5EC340EE;
        Tue,  1 Mar 2022 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646159089;
        bh=n/9fph0OsL5mWwjCtTZsQ6kPOtBrGnou15HhkeitYVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ckVbb9w9WVZ2MiNi83aQBsFy2DyavnCa3DU4epjPmJZLSesO9NcNtK0X2w3tzoYTJ
         tCR85yHgMG3gM9aa+i2rVjje5otvlJ7vcxullMf3u/yR9ZYY2M2bR2iQ642V77Uv/z
         i8/gEtbOvxOR7dJl9RgOQK/V0KNdJeHobxCkdenw=
Date:   Tue, 1 Mar 2022 10:24:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [hnaz-mm:master 272/379] lib/vsprintf.c:991:13: warning:
 variable 'modbuildid' set but not used
Message-Id: <20220301102448.ff9bf910213d705842a2dd45@linux-foundation.org>
In-Reply-To: <202203012040.uFWGm3My-lkp@intel.com>
References: <202203012040.uFWGm3My-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 20:11:04 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://github.com/hnaz/linux-mm master
> head:   a46912c14343fd3269cc133494988af90b377d9f
> commit: b314f622e664eb263ea03ef7f4580e37146f123f [272/379] kallsyms: enhance %pS/s/b printing when KALLSYSMS is disabled
> config: arm-eseries_pxa_defconfig (https://download.01.org/0day-ci/archive/20220301/202203012040.uFWGm3My-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/hnaz/linux-mm/commit/b314f622e664eb263ea03ef7f4580e37146f123f
>         git remote add hnaz-mm https://github.com/hnaz/linux-mm
>         git fetch --no-tags hnaz-mm master
>         git checkout b314f622e664eb263ea03ef7f4580e37146f123f
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    lib/vsprintf.c: In function 'sprint_module_info':
> >> lib/vsprintf.c:991:13: warning: variable 'modbuildid' set but not used [-Wunused-but-set-variable]
>      991 |         int modbuildid = 0;
>          |             ^~~~~~~~~~

Do we care about this?  [-Wunused-but-set-variable isn't normally set. 
Under what circumstances does it get set in your setup?

I did this:

--- a/lib/vsprintf.c~kallsyms-enhance-%ps-s-b-printing-when-kallsysms-is-disabled-fix
+++ a/lib/vsprintf.c
@@ -988,7 +988,7 @@ static int sprint_module_info(char *buf,
 	unsigned long base;
 	int ret = 0;
 	const char *modname;
-	int modbuildid = 0;
+	int modbuildid __maybe_unused = 0;
 	int len;
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
 	const unsigned char *buildid = NULL;
_


>    lib/vsprintf.c: In function 'va_format':
>    lib/vsprintf.c:1759:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>     1759 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
>          |         ^~~

I wonder what this means.
