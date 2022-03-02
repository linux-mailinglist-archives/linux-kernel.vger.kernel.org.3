Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66B4CA471
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbiCBMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbiCBMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:08:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF831B7BC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:07:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 069C61F37E;
        Wed,  2 Mar 2022 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646222851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eo8d/qlFFmHzEnqL6EKmZWaAlz+V/Y6U9xR47zJcmUY=;
        b=mpnTEIP6J1FQb1UUKYFMSOUnb3u52cYN9YNW194AD5Cfwuk2tIS6Ua/dsaymEMv5AefFCf
        Oqk43prmg2hF3nuf9jCle1WIgFjteFGiSzGXsCGNeSJ+O7dbXo0SyX7sIpW1U2iNBIj+mT
        O+H7O0MYv5xjymbrqrZ4ZfzoZwyQqIQ=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ABCFAA3B8B;
        Wed,  2 Mar 2022 12:07:29 +0000 (UTC)
Date:   Wed, 2 Mar 2022 13:07:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [hnaz-mm:master 272/379] lib/vsprintf.c:991:13: warning:
 variable 'modbuildid' set but not used
Message-ID: <Yh9eAYwI3+sBIIo7@alley>
References: <202203012040.uFWGm3My-lkp@intel.com>
 <20220301102448.ff9bf910213d705842a2dd45@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301102448.ff9bf910213d705842a2dd45@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-03-01 10:24:48, Andrew Morton wrote:
> On Tue, 1 Mar 2022 20:11:04 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://github.com/hnaz/linux-mm master
> > head:   a46912c14343fd3269cc133494988af90b377d9f
> > commit: b314f622e664eb263ea03ef7f4580e37146f123f [272/379] kallsyms: enhance %pS/s/b printing when KALLSYSMS is disabled
> > config: arm-eseries_pxa_defconfig (https://download.01.org/0day-ci/archive/20220301/202203012040.uFWGm3My-lkp@intel.com/config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/hnaz/linux-mm/commit/b314f622e664eb263ea03ef7f4580e37146f123f
> >         git remote add hnaz-mm https://github.com/hnaz/linux-mm
> >         git fetch --no-tags hnaz-mm master
> >         git checkout b314f622e664eb263ea03ef7f4580e37146f123f
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    lib/vsprintf.c: In function 'sprint_module_info':
> > >> lib/vsprintf.c:991:13: warning: variable 'modbuildid' set but not used [-Wunused-but-set-variable]
> >      991 |         int modbuildid = 0;
> >          |             ^~~~~~~~~~
> 
> Do we care about this?  [-Wunused-but-set-variable isn't normally set. 
> Under what circumstances does it get set in your setup?
> 
> I did this:
> 
> --- a/lib/vsprintf.c~kallsyms-enhance-%ps-s-b-printing-when-kallsysms-is-disabled-fix
> +++ a/lib/vsprintf.c
> @@ -988,7 +988,7 @@ static int sprint_module_info(char *buf,
>  	unsigned long base;
>  	int ret = 0;
>  	const char *modname;
> -	int modbuildid = 0;
> +	int modbuildid __maybe_unused = 0;
>  	int len;
>  #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
>  	const unsigned char *buildid = NULL;

Looks good. I would fix this. I am not sure but I guess that there
are people that try to fix W=1 warnings.

That said, I would prefer to disable the patch "kallsyms: enhance
%pS/s/b printing when KALLSYSMS is disabled" for now. There are
two problems with it:

   + It discloses the base address of loaded modules. I am not sure
     if it is acceptable from the security point of view.

   + It duplicates a lot of code from kallsyms.c. I would like to
     avoid it.

I have pointed out both problems at
https://lore.kernel.org/r/YhzywNowPiQm3IN4@alley
I have to admit that they are hidden between less important comments.

Best Regards,
Petr
