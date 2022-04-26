Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E85101B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352318AbiDZPVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347518AbiDZPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:20:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371811AC56E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:13:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 884381F388;
        Tue, 26 Apr 2022 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650985953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilqNI6bkLcv0GvaJ4q+HJDdDtII/9oekltf7dQ89U9Q=;
        b=mdJ1KGIHs4YiMxBMHho6GPV5nZqr5jlYCgkOB4AePzlZRpANqXVYFptdb/aNuRB3aD4kj/
        JnLWcxK5t7HMSY5fqQFmVLFk/Im+b4p+TKbJ/w+EoqzvV9FQzj1aR84NhLQCBb+B4g6kha
        e2HBxErTfMOCG3AoTvFbqOjrqV3jBfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650985953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilqNI6bkLcv0GvaJ4q+HJDdDtII/9oekltf7dQ89U9Q=;
        b=AQoCjGFKfzfwH1TlMeEMeRZUDBhzeYSzTBgdOWde+6cgvfmcwbhLV5CEDdifooxTr7jeaZ
        zWY/tutiR8jcg2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 335FF13AD5;
        Tue, 26 Apr 2022 15:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IIraC+ELaGIkXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 26 Apr 2022 15:12:33 +0000
Message-ID: <147b11c3-dbce-ccd3-3b0c-c5971135f949@suse.cz>
Date:   Tue, 26 Apr 2022 17:12:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        penberg@kernel.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
References: <20220422201830.288018-1-pcc@google.com>
 <202204251346.WbwgrNZw-lkp@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm: make minimum slab alignment a runtime property
In-Reply-To: <202204251346.WbwgrNZw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 07:12, kernel test robot wrote:
> Hi Peter,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on hnaz-mm/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Collingbourne/mm-make-minimum-slab-alignment-a-runtime-property/20220423-042024
> base:   https://github.com/hnaz/linux-mm master
> config: arm64-buildonly-randconfig-r002-20220425 (https://download.01.org/0day-ci/archive/20220425/202204251346.WbwgrNZw-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/3aef97055dd4a480e05dff758164f153aaddbb49
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Peter-Collingbourne/mm-make-minimum-slab-alignment-a-runtime-property/20220423-042024
>         git checkout 3aef97055dd4a480e05dff758164f153aaddbb49
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/bounds.c:10:
>    In file included from include/linux/page-flags.h:10:
>    In file included from include/linux/bug.h:5:
>    In file included from arch/arm64/include/asm/bug.h:26:
>    In file included from include/asm-generic/bug.h:22:
>    In file included from include/linux/printk.h:9:
>    In file included from include/linux/cache.h:6:
>    In file included from arch/arm64/include/asm/cache.h:56:
>    In file included from include/linux/kasan-enabled.h:5:
>    In file included from include/linux/static_key.h:1:

Hmm looks like a circular include, cache.h is too "low-level" in the
hierarchy to bring in kasan->static_key->jump_label.h definitions?
jump_label.h does include bug.h, but we have it above already and have
already passed #define _LINUX_BUG_H.

So, a different kind of header with arm64-specific variant?

>>> include/linux/jump_label.h:285:2: error: call to undeclared function 'WARN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            STATIC_KEY_CHECK_USE(key);
>            ^
>    include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
>    #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
>                                      ^
>    include/linux/jump_label.h:291:2: error: call to undeclared function 'WARN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            STATIC_KEY_CHECK_USE(key);
>            ^
>    include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
>    #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
>                                      ^
>    include/linux/jump_label.h:313:2: error: call to undeclared function 'WARN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            STATIC_KEY_CHECK_USE(key);
>            ^
>    include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
>    #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
>                                      ^
>>> include/linux/jump_label.h:316:3: error: call to undeclared function 'WARN_ON_ONCE'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
>                    ^
>    include/linux/jump_label.h:324:2: error: call to undeclared function 'WARN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            STATIC_KEY_CHECK_USE(key);
>            ^
>    include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
>    #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
>                                      ^
>    include/linux/jump_label.h:327:3: error: call to undeclared function 'WARN_ON_ONCE'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
>                    ^
>    6 errors generated.
>    make[2]: *** [scripts/Makefile.build:122: kernel/bounds.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1283: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:226: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> 
> vim +/WARN +285 include/linux/jump_label.h
> 
> bf5438fca2950b Jason Baron     2010-09-17  282  
> c5905afb0ee655 Ingo Molnar     2012-02-24  283  static inline void static_key_slow_inc(struct static_key *key)
> d430d3d7e646eb Jason Baron     2011-03-16  284  {
> 5cdda5117e125e Borislav Petkov 2017-10-18 @285  	STATIC_KEY_CHECK_USE(key);
> d430d3d7e646eb Jason Baron     2011-03-16  286  	atomic_inc(&key->enabled);
> d430d3d7e646eb Jason Baron     2011-03-16  287  }
> bf5438fca2950b Jason Baron     2010-09-17  288  
> c5905afb0ee655 Ingo Molnar     2012-02-24  289  static inline void static_key_slow_dec(struct static_key *key)
> bf5438fca2950b Jason Baron     2010-09-17  290  {
> 5cdda5117e125e Borislav Petkov 2017-10-18  291  	STATIC_KEY_CHECK_USE(key);
> d430d3d7e646eb Jason Baron     2011-03-16  292  	atomic_dec(&key->enabled);
> bf5438fca2950b Jason Baron     2010-09-17  293  }
> bf5438fca2950b Jason Baron     2010-09-17  294  
> ce48c146495a1a Peter Zijlstra  2018-01-22  295  #define static_key_slow_inc_cpuslocked(key) static_key_slow_inc(key)
> ce48c146495a1a Peter Zijlstra  2018-01-22  296  #define static_key_slow_dec_cpuslocked(key) static_key_slow_dec(key)
> ce48c146495a1a Peter Zijlstra  2018-01-22  297  
> 4c3ef6d79328c0 Jason Baron     2010-09-17  298  static inline int jump_label_text_reserved(void *start, void *end)
> 4c3ef6d79328c0 Jason Baron     2010-09-17  299  {
> 4c3ef6d79328c0 Jason Baron     2010-09-17  300  	return 0;
> 4c3ef6d79328c0 Jason Baron     2010-09-17  301  }
> 4c3ef6d79328c0 Jason Baron     2010-09-17  302  
> 91bad2f8d30574 Jason Baron     2010-10-01  303  static inline void jump_label_lock(void) {}
> 91bad2f8d30574 Jason Baron     2010-10-01  304  static inline void jump_label_unlock(void) {}
> 91bad2f8d30574 Jason Baron     2010-10-01  305  
> d430d3d7e646eb Jason Baron     2011-03-16  306  static inline int jump_label_apply_nops(struct module *mod)
> d430d3d7e646eb Jason Baron     2011-03-16  307  {
> d430d3d7e646eb Jason Baron     2011-03-16  308  	return 0;
> d430d3d7e646eb Jason Baron     2011-03-16  309  }
> b202952075f626 Gleb Natapov    2011-11-27  310  
> e33886b38cc82a Peter Zijlstra  2015-07-24  311  static inline void static_key_enable(struct static_key *key)
> e33886b38cc82a Peter Zijlstra  2015-07-24  312  {
> 5cdda5117e125e Borislav Petkov 2017-10-18  313  	STATIC_KEY_CHECK_USE(key);
> e33886b38cc82a Peter Zijlstra  2015-07-24  314  
> 1dbb6704de91b1 Paolo Bonzini   2017-08-01  315  	if (atomic_read(&key->enabled) != 0) {
> 1dbb6704de91b1 Paolo Bonzini   2017-08-01 @316  		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
> 1dbb6704de91b1 Paolo Bonzini   2017-08-01  317  		return;
> 1dbb6704de91b1 Paolo Bonzini   2017-08-01  318  	}
> 1dbb6704de91b1 Paolo Bonzini   2017-08-01  319  	atomic_set(&key->enabled, 1);
> e33886b38cc82a Peter Zijlstra  2015-07-24  320  }
> e33886b38cc82a Peter Zijlstra  2015-07-24  321  
> 

