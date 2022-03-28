Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C164E963B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbiC1MJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiC1MJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D02E3192B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648469284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ocPIggEgNbhKZGS5mSJpLUGdUWPXJb1uvkari0tv3w=;
        b=BzkKoipyVKA0bn5Ivk9jZ9dObF24DLg9fEFfMs89IHKAlUbABqzAN+Fh6RAcRjuCtex5K6
        okxuyba44mhH91KaYF0OU0cfo3zJ2pP419+LyrWVH3j4IG2CUBA0Xa4MIa4TNxaMhFMHqe
        Fk8D8Vfu7yqj+5q42fNPuPo8ENNa5sk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-vMldH8yRMTahlaPg-QBW3A-1; Mon, 28 Mar 2022 08:08:02 -0400
X-MC-Unique: vMldH8yRMTahlaPg-QBW3A-1
Received: by mail-ej1-f70.google.com with SMTP id nd34-20020a17090762a200b006e0ef16745cso1324984ejc.20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4ocPIggEgNbhKZGS5mSJpLUGdUWPXJb1uvkari0tv3w=;
        b=UThMKoux5QaofqJ1oX3HBnAbzuUntzYcyvkFR+O3c/ilBJJBtwewKpYPYOaFNEuhs0
         xH+imcuXpkH/O71bwRwf4UjPimqXoeLgvrA75O+iQR96xrhRMbGQubqv5mhYUZL/nRpQ
         swFhF1dGTxp6JUDvpamH3S+QQGrSXIfENqEgz7A4rSXtNPf32KLkosN69hXIEemtLCz5
         mFAuuwIo7Po4OUYmaHPTUIbv7AplGLtMOoFAefMpqWN4IMj4J2qLg9pAXh2mioZJZBrD
         3S1arJxFl+SN9Tl2n2MZScoIxbjwbx7DCeA9S22nqlWvJTPTOBErKTEcnlwDeDdCU4gF
         DfnQ==
X-Gm-Message-State: AOAM53326ft+KElDqJ6XdIIMVW+nj5MjZI/yvAljZI8F1Tm88FnpKo5T
        SG+EhxygHCpFWx2f/EIapKcxAQ+yreyXBrJ/kqKAgjWnauI3Lf3+y1rQhK6GFKx05Fb2d1o3npy
        GM2k0IKYXegOCuafRNnVYOqSt
X-Received: by 2002:a17:907:3f18:b0:6e0:df2d:c76a with SMTP id hq24-20020a1709073f1800b006e0df2dc76amr12191898ejc.55.1648469281300;
        Mon, 28 Mar 2022 05:08:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeTIzs1mHsYk6zzSH0/MKOBXPwOtbpDjqkAK0U02OtKN+31InMzhbfHvLiju814dxcGA7qBg==
X-Received: by 2002:a17:907:3f18:b0:6e0:df2d:c76a with SMTP id hq24-20020a1709073f1800b006e0df2dc76amr12191871ejc.55.1648469281024;
        Mon, 28 Mar 2022 05:08:01 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906505600b006da7d71f25csm5868400ejk.41.2022.03.28.05.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 05:08:00 -0700 (PDT)
Message-ID: <c53b864a-912b-4569-251d-aea20be1bc5c@redhat.com>
Date:   Mon, 28 Mar 2022 14:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 3/4] input/i8042: Add debug output for quirks
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <20220322162125.59838-4-wse@tuxedocomputers.com>
 <202203230435.z5FH2fWa-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202203230435.z5FH2fWa-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/22/22 21:50, kernel test robot wrote:
> Hi Werner,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on dtor-input/next]
> [also build test ERROR on v5.17 next-20220322]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Werner-Sembach/input-i8042-Move-__initconst-to-fix-code-styling-warning/20220323-012205
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> config: ia64-defconfig (https://download.01.org/0day-ci/archive/20220323/202203230435.z5FH2fWa-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/d92be72641d5753be3aa94fe5961e2dbe2b5bdc9
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Werner-Sembach/input-i8042-Move-__initconst-to-fix-code-styling-warning/20220323-012205
>         git checkout d92be72641d5753be3aa94fe5961e2dbe2b5bdc9
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

i8042_dritek is only defined when building on x86, I would solve this
by moving the new pr_debug to inside i8042_check_quirks();

The i8042_nopnp not being defined order is slightly tricker, you
can more or less cleanly fix this by doing this at the end of
i8042_check_quirks() and then put the new pr_debug after this:

#ifdef CONFIG_PNP
                if (quirks & SERIO_QUIRK_NOPNP)
                        i8042_nopnp = true;
#else
#define i8042_nopnp 0
#endif

Regards,

Hans



> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/asm-generic/bug.h:22,
>                     from arch/ia64/include/asm/bug.h:17,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:13,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/ia64/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/rcupdate.h:27,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from include/linux/delay.h:23,
>                     from drivers/input/serio/i8042.c:12:
>    drivers/input/serio/i8042-x86ia64io.h: In function 'i8042_platform_init':
>>> drivers/input/serio/i8042-x86ia64io.h:1511:17: error: 'i8042_dritek' undeclared (first use in this function); did you mean 'i8042_direct'?
>     1511 |                 i8042_dritek ? " dritek" : "",
>          |                 ^~~~~~~~~~~~
>    include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
>      418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                                 ^~~~~~~~~~~
>    include/linux/printk.h:132:17: note: in expansion of macro 'printk'
>      132 |                 printk(fmt, ##__VA_ARGS__);             \
>          |                 ^~~~~~
>    include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
>      576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>          |         ^~~~~~~~~
>    drivers/input/serio/i8042-x86ia64io.h:1497:9: note: in expansion of macro 'pr_debug'
>     1497 |         pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>          |         ^~~~~~~~
>    drivers/input/serio/i8042-x86ia64io.h:1511:17: note: each undeclared identifier is reported only once for each function it appears in
>     1511 |                 i8042_dritek ? " dritek" : "",
>          |                 ^~~~~~~~~~~~
>    include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
>      418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                                 ^~~~~~~~~~~
>    include/linux/printk.h:132:17: note: in expansion of macro 'printk'
>      132 |                 printk(fmt, ##__VA_ARGS__);             \
>          |                 ^~~~~~
>    include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
>      576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>          |         ^~~~~~~~~
>    drivers/input/serio/i8042-x86ia64io.h:1497:9: note: in expansion of macro 'pr_debug'
>     1497 |         pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>          |         ^~~~~~~~
> 
> 
> vim +1511 drivers/input/serio/i8042-x86ia64io.h
> 
>   1494	
>   1495		i8042_check_quirks();
>   1496	
>   1497		pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>   1498			i8042_nokbd ? " nokbd" : "",
>   1499			i8042_noaux ? " noaux" : "",
>   1500			i8042_nomux ? " nomux" : "",
>   1501			i8042_unlock ? " unlock" : "",
>   1502			i8042_probe_defer ? "probe_defer" : "",
>   1503			i8042_reset == I8042_RESET_DEFAULT ?
>   1504				"" : i8042_reset == I8042_RESET_ALWAYS ?
>   1505					" reset_always" : " reset_never",
>   1506			i8042_direct ? " direct" : "",
>   1507			i8042_dumbkbd ? " dumbkbd" : "",
>   1508			i8042_noloop ? " noloop" : "",
>   1509			i8042_notimeout ? " notimeout" : "",
>   1510			i8042_kbdreset ? " kbdreset" : "",
>> 1511			i8042_dritek ? " dritek" : "",
>   1512			i8042_nopnp ? " nopnp" : "");
>   1513	
>   1514		retval = i8042_pnp_init();
>   1515		if (retval)
>   1516			return retval;
>   1517	
> 

