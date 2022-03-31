Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6424EDCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiCaP3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiCaP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:29:00 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DE221BC6C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:27:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f23so60651ybj.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cx/jntd5MtnfHbFJ6wQ9WBx8f0jFn2F4QMSwBKsbTL4=;
        b=mVdPagKPXbg/QhIYsGWCJRl0DmguSrdOwYYbfPnVMr1G3le8ZKSu5YjOddra9OGvI7
         H9MV7C9xeMksTMeKlBwk8ErYL7URvVvdSuLRw2UkyQ+3z+/O/CkQoyU0eJvmk5hR9cnK
         4WPPALU0TjTgMtGG4XODtRfqfxn6IWI+Nyd1X6vtR9Mr+tiZZkVmXliVn7kafwcCZtX2
         hOboxmDzcDt3etSfNC8CVZF+ZAlam97F+dEOljJfqRohQB9bnHL3oj5SyOUYb0sfZ+3Q
         sp3maiD42lL+bTsT89OqAzWD/e8MwLwGi77A/KNGlJnd8Tp7K0o32Wt9ZRt9GZTus2lh
         ga1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cx/jntd5MtnfHbFJ6wQ9WBx8f0jFn2F4QMSwBKsbTL4=;
        b=P4RtZhIzqiTFGpnwJEYpmanq/LSSXdGwqd2sZQ2K1zs7yKIdjVpp4f3PX3oSTMYPUW
         Czu0ijDfzfXxzuPBBHNkb4wBKYsuPsH1sH/TaaIWWP+Fv4G2rjPS9swlAcOkDp8jG5vl
         SljHgKw0Sx2c2TJnXEHFmajCAzB9mJ2hwDUAO1LjdhY+6gK8r9L5w5neodPo7BTGmrxG
         oSV+vX/ma+Vp9shzVBnZVf1YCsTwW8tzPTlrATjy1V0Q/nV1etsVGGyBPI9aeFZI2w54
         58YdtWDxeQBXX1mGE4756/3wUuNz/8IY0XlMtVwOiEhv8JrNWFiKDSqzosavZu1259JQ
         ykrw==
X-Gm-Message-State: AOAM531XjbMu67AwkN9LQu+CqHAMlmBIjKziJ94z81aGZcoRlCVueAvv
        DFhdhDDTEjbXpF7GlC4gngxc30oHZKMU6/34ZL2KPw==
X-Google-Smtp-Source: ABdhPJymbOBZrreddHigBujDJlMqXgN3WqeEPo+QbNHV7yN5YOS5zGWkPHsxrYDAlBtOVDuhB3tZPjTB/KwbHkmJyuc=
X-Received: by 2002:a25:cdca:0:b0:633:c810:6ca with SMTP id
 d193-20020a25cdca000000b00633c81006camr4561768ybf.261.1648740431209; Thu, 31
 Mar 2022 08:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220330153745.20465-2-songmuchun@bytedance.com> <202203312010.ct30oFE6-lkp@intel.com>
In-Reply-To: <202203312010.ct30oFE6-lkp@intel.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 31 Mar 2022 23:26:35 +0800
Message-ID: <CAMZfGtU7ctporSD=U-MGFX7H+x=12ZSSOe-ds5qyFQakg4po0w@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
To:     kernel test robot <lkp@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 8:40 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Muchun,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on hnaz-mm/master]
> [also build test ERROR on mcgrof/sysctl-next linus/master next-20220331]
> [cannot apply to v5.17]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220330-234018
> base:   https://github.com/hnaz/linux-mm master
> config: ia64-randconfig-s031-20220331 (https://download.01.org/0day-ci/archive/20220331/202203312010.ct30oFE6-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://github.com/intel-lab-lkp/linux/commit/5164c566d4fbdb808689ee4552ed95eab421522e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220330-234018
>         git checkout 5164c566d4fbdb808689ee4552ed95eab421522e
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 prepare
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/ia64/include/asm/thread_info.h:10,
>                     from include/linux/thread_info.h:60,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/ia64/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:55,
>                     from include/linux/kref.h:16,
>                     from include/linux/mm_types.h:8,
>                     from mm/struct_page_size.c:10:
> >> arch/ia64/include/asm/asm-offsets.h:1:10: fatal error: generated/asm-offsets.h: No such file or directory
>        1 | #include <generated/asm-offsets.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.
>    make[2]: *** [scripts/Makefile.build:127: mm/struct_page_size.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1261: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:226: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>

It is a circular dependency issue, I'll fix this in the next version.
Thanks for your report.
