Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C920479E12
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 00:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhLRW7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 17:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231351AbhLRW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 17:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639868341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKL1YmqVKts3QxLJQjQFkJ4hNOoI+EzTUC/9eQmE1k4=;
        b=Ff4xhhDg2UfSAd8H/7b9xBbZmESX0sYttmyH6oHBGmYD+h71lpOeBDz4cG8MwQvzVRUOD6
        NtK9NNgSLk8PI85zNZiV5BnragApX0eiQl1AqLCrJuxk5w6YFsusv813i/EuqLWfLlfaFI
        8ecNELfN/5a9ksFZLP0kEng4arZsQzs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-0kUZONihMz67mDFiCVlYRQ-1; Sat, 18 Dec 2021 17:59:00 -0500
X-MC-Unique: 0kUZONihMz67mDFiCVlYRQ-1
Received: by mail-wr1-f71.google.com with SMTP id k11-20020adfc70b000000b001a2333d9406so1820330wrg.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 14:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKL1YmqVKts3QxLJQjQFkJ4hNOoI+EzTUC/9eQmE1k4=;
        b=QJSV5nx96HSkZLicy5MKBzNLR2q7zRUorkxWjae+/NAfMqdeRYhwBY8nJ+dr7xkn86
         1o4W8JaNERH5lvdLShbceYcw3e815nkX8hoSyCVJ14kyxOqJdhRZI7illHFtNLdpqh5j
         zsWrPEJyChwj10uLj6rnjyUe3SmWQWIDIseniW2qWoOwiR6SYL/o6sm/8BPgzBxIOnrq
         3kklgNLDnpmSFELyz4n0nGmJkFaXEJ2SdTSbWqiLLpkcTjuclhWl1Q4j/5c9iqLCJ6Gw
         NepFXPDh6w1/aI/gFvkz/laXGBqGC5i+NP2glywsLcQeZ8EI+85ese0tkh0Pr1ZkUWAn
         jvkA==
X-Gm-Message-State: AOAM5326g35mkP5XIVoVnjOFIIlYYxkXrt4mpB2RsgckNG8L25GgKfp1
        wQIaOX4aqP9rJ34RCBUNZYJpNnv1FFq6gvbu7tfnn2/bHdwBkrEyNx0FvO8uZKlq+D5MoQFy7QS
        LmPgCSnPeJtLK2yQDuWAKNaKL
X-Received: by 2002:a1c:f217:: with SMTP id s23mr15024791wmc.70.1639868338952;
        Sat, 18 Dec 2021 14:58:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6XNPwqC4x+1n7wbfAYLEDuEUUa0YRDFZDM3AZOesJw01Di5J81acMjEVtY8JI8qBixVlHEA==
X-Received: by 2002:a1c:f217:: with SMTP id s23mr15024788wmc.70.1639868338808;
        Sat, 18 Dec 2021 14:58:58 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id u12sm11474338wrf.60.2021.12.18.14.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 14:58:58 -0800 (PST)
Date:   Sat, 18 Dec 2021 23:58:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: samples/ftrace/ftrace-direct-multi-modify.c:7:6: warning: no
 previous prototype for function 'my_direct_func1'
Message-ID: <Yb5nsJdwCl+8d8Fv@krava>
References: <202112190117.RKPcHQjE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112190117.RKPcHQjE-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 01:57:29AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9eaa88c7036eda3f6c215f87ca693594cf90559b
> commit: e1067a07cfbc5a36abad3752fafe4c79e06db1bb ftrace/samples: Add module to test multi direct modify interface
> date:   9 days ago
> config: x86_64-randconfig-a001-20211219 (https://download.01.org/0day-ci/archive/20211219/202112190117.RKPcHQjE-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4c9e31a4814592bbda7153833e46728dc7b21100)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1067a07cfbc5a36abad3752fafe4c79e06db1bb
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e1067a07cfbc5a36abad3752fafe4c79e06db1bb
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash samples/ftrace/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> samples/ftrace/ftrace-direct-multi-modify.c:7:6: warning: no previous prototype for function 'my_direct_func1' [-Wmissing-prototypes]
>    void my_direct_func1(unsigned long ip)
>         ^
>    samples/ftrace/ftrace-direct-multi-modify.c:7:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void my_direct_func1(unsigned long ip)
>    ^
>    static 
> >> samples/ftrace/ftrace-direct-multi-modify.c:12:6: warning: no previous prototype for function 'my_direct_func2' [-Wmissing-prototypes]
>    void my_direct_func2(unsigned long ip)
>         ^
>    samples/ftrace/ftrace-direct-multi-modify.c:12:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void my_direct_func2(unsigned long ip)
>    ^
>    static 
>    2 warnings generated.

ugh, not again.. of course :-\ will send the fix

thanks,
jirka

> 
> 
> vim +/my_direct_func1 +7 samples/ftrace/ftrace-direct-multi-modify.c
> 
>      6	
>    > 7	void my_direct_func1(unsigned long ip)
>      8	{
>      9		trace_printk("my direct func1 ip %lx\n", ip);
>     10	}
>     11	
>   > 12	void my_direct_func2(unsigned long ip)
>     13	{
>     14		trace_printk("my direct func2 ip %lx\n", ip);
>     15	}
>     16	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

