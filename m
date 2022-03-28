Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB04E9C46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242197AbiC1QcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiC1QcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEC7D5A0B9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648485021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiudENfnRsT4mkm3HMsmOzfaooGwdtPXa8QtSU8kUEA=;
        b=gFdpGTMOOTXXDSMRK2bghgYtyR8jzhTgzrcETV3/G9+0exp3dCYqIoL6LO4VixEgLYxxxq
        v7Pl2tLucX7oPb/KbS55xQ8OJBmT3YgwHRz2kM5/6O1QcmLj+xiY0rz/mwhd55iBVCyX5g
        dofDvHukcsqK76FK1AZso62cK6jsSd8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-Z6-S3wu1PQa2takpoSfW3g-1; Mon, 28 Mar 2022 12:30:19 -0400
X-MC-Unique: Z6-S3wu1PQa2takpoSfW3g-1
Received: by mail-ej1-f71.google.com with SMTP id my15-20020a1709065a4f00b006dfd2b16e6cso7098080ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wiudENfnRsT4mkm3HMsmOzfaooGwdtPXa8QtSU8kUEA=;
        b=7Bt004/opGyagPjP7tRn10QIzGm/ztP+9ZjsI95mlgtg7DBzfjF0jmSEIC8E9y7/4h
         dFlCfM6jvRfCNH+8hkvRwPnuYemTTDOPu2jRq3c6mAssmzQjPAehNKzxOCkiYS6Xz2J8
         WRNzcUOO6Vl7oBFC9CJwHQxojpdwCgpEIDsqEyTageV+tJbFab+3QzxLaLPMGElaDXKh
         vQJHbYszxo/aEDYsf9/CPG4gjc/qVbSEYV4Uvcg4Cjs80OpZSNB0/dQBP3N2VbrlZuTH
         x3wzrn1mcqyQlqKKO2PY8Q3Thc+05YXLIKERQPPrpdPC59//oqSmjJb05frt9RiX0VXp
         xgSA==
X-Gm-Message-State: AOAM531LyUwuiAp4ozpFOqLxsFR+w9Ua2dV1mLi9Ac3Q4Og7uKWXmn23
        +K8AyOZJanz29m0WYyC7fLyMbRfwymV+4qCs67X7MY7ZW50RpQxuJfWXVQ7Udiir4dp4LjTL4ll
        z8i5lxhQtnqn3U1vMf0p6dkHK
X-Received: by 2002:a05:6402:51cf:b0:419:63e2:2b96 with SMTP id r15-20020a05640251cf00b0041963e22b96mr17326688edd.336.1648485018095;
        Mon, 28 Mar 2022 09:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz+bt47oyPZFi/Ryvt51VJ9F/T+S9PRZpzRWBjcQwdEqTRCtvrpERJNUCpr+3ZQXU7s8m1JQ==
X-Received: by 2002:a05:6402:51cf:b0:419:63e2:2b96 with SMTP id r15-20020a05640251cf00b0041963e22b96mr17326648edd.336.1648485017720;
        Mon, 28 Mar 2022 09:30:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090617d600b006e0df1a7d7csm3024582eje.15.2022.03.28.09.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 09:30:17 -0700 (PDT)
Message-ID: <9b30f546-308c-ef7b-e59e-740851592275@redhat.com>
Date:   Mon, 28 Mar 2022 18:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 3/4] input/i8042: Add debug output for quirks
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        kernel test robot <lkp@intel.com>, dmitry.torokhov@gmail.com,
        tiwai@suse.de, mpdesouza@suse.com, arnd@arndb.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <20220322162125.59838-4-wse@tuxedocomputers.com>
 <202203230435.z5FH2fWa-lkp@intel.com>
 <c53b864a-912b-4569-251d-aea20be1bc5c@redhat.com>
 <c8e0e071-7566-f958-f309-aefa2bd802ad@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c8e0e071-7566-f958-f309-aefa2bd802ad@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/28/22 18:28, Werner Sembach wrote:
> 
> Am 28.03.22 um 14:08 schrieb Hans de Goede:
>> Hi,
>>
>> On 3/22/22 21:50, kernel test robot wrote:
>>> Hi Werner,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on dtor-input/next]
>>> [also build test ERROR on v5.17 next-20220322]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Werner-Sembach/input-i8042-Move-__initconst-to-fix-code-styling-warning/20220323-012205
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
>>> config: ia64-defconfig (https://download.01.org/0day-ci/archive/20220323/202203230435.z5FH2fWa-lkp@intel.com/config)
>>> compiler: ia64-linux-gcc (GCC) 11.2.0
>>> reproduce (this is a W=1 build):
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # https://github.com/0day-ci/linux/commit/d92be72641d5753be3aa94fe5961e2dbe2b5bdc9
>>>         git remote add linux-review https://github.com/0day-ci/linux
>>>         git fetch --no-tags linux-review Werner-Sembach/input-i8042-Move-__initconst-to-fix-code-styling-warning/20220323-012205
>>>         git checkout d92be72641d5753be3aa94fe5961e2dbe2b5bdc9
>>>         # save the config file to linux build tree
>>>         mkdir build_dir
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>> i8042_dritek is only defined when building on x86, I would solve this
>> by moving the new pr_debug to inside i8042_check_quirks();
> 
> Thanks I missed that. But moving the debug function in i8042_check_quirks would make the output x86 exclusive, while the
> quirks in general are not (on non x86 they must be set via command line but still have effects on the code if i see that
> correctly)

True.

>> The i8042_nopnp not being defined order is slightly tricker, you
>> can more or less cleanly fix this by doing this at the end of
>> i8042_check_quirks() and then put the new pr_debug after this:
>>
>> #ifdef CONFIG_PNP
>>                 if (quirks & SERIO_QUIRK_NOPNP)
>>                         i8042_nopnp = true;
>> #else
>> #define i8042_nopnp 0
>> #endif
> 
> As an alternative i would suggest putting defines in the pr_debug call. Otherwise it might not be immediately that the
> #define i8042_nopnp 0 is there specifically for this one statement only.
> 
>     pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>         i8042_nokbd ? " nokbd" : "",
>         i8042_noaux ? " noaux" : "",
>         i8042_nomux ? " nomux" : "",
>         i8042_unlock ? " unlock" : "",
>         i8042_probe_defer ? "probe_defer" : "",
>         i8042_reset == I8042_RESET_DEFAULT ?
>             "" : i8042_reset == I8042_RESET_ALWAYS ?
>                 " reset_always" : " reset_never",
>         i8042_direct ? " direct" : "",
>         i8042_dumbkbd ? " dumbkbd" : "",
>         i8042_noloop ? " noloop" : "",
>         i8042_notimeout ? " notimeout" : "",
>         i8042_kbdreset ? " kbdreset" : "",
> #ifdef CONFIG_X86
>         i8042_dritek ? " dritek" : "",
> #else
>         "",
> #endif
> #ifdef CONFIG_PNP
>         i8042_nopnp ? " nopnp" : "");
> #else
>         "");
> #endif
> 
> As a side effect: like this the code snipped also stays completely position independed.

Ok, the above solution is fine by me.

It also has the advantage of not defining i8042_nopnp which may
lead to accidentally getting used when not set later.

Regards,

Hans




>>> All errors (new ones prefixed by >>):
>>>
>>>    In file included from include/asm-generic/bug.h:22,
>>>                     from arch/ia64/include/asm/bug.h:17,
>>>                     from include/linux/bug.h:5,
>>>                     from include/linux/thread_info.h:13,
>>>                     from include/asm-generic/preempt.h:5,
>>>                     from ./arch/ia64/include/generated/asm/preempt.h:1,
>>>                     from include/linux/preempt.h:78,
>>>                     from include/linux/rcupdate.h:27,
>>>                     from include/linux/rculist.h:11,
>>>                     from include/linux/pid.h:5,
>>>                     from include/linux/sched.h:14,
>>>                     from include/linux/delay.h:23,
>>>                     from drivers/input/serio/i8042.c:12:
>>>    drivers/input/serio/i8042-x86ia64io.h: In function 'i8042_platform_init':
>>>>> drivers/input/serio/i8042-x86ia64io.h:1511:17: error: 'i8042_dritek' undeclared (first use in this function); did you mean 'i8042_direct'?
>>>     1511 |                 i8042_dritek ? " dritek" : "",
>>>          |                 ^~~~~~~~~~~~
>>>    include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
>>>      418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>>>          |                                 ^~~~~~~~~~~
>>>    include/linux/printk.h:132:17: note: in expansion of macro 'printk'
>>>      132 |                 printk(fmt, ##__VA_ARGS__);             \
>>>          |                 ^~~~~~
>>>    include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
>>>      576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>>          |         ^~~~~~~~~
>>>    drivers/input/serio/i8042-x86ia64io.h:1497:9: note: in expansion of macro 'pr_debug'
>>>     1497 |         pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>>>          |         ^~~~~~~~
>>>    drivers/input/serio/i8042-x86ia64io.h:1511:17: note: each undeclared identifier is reported only once for each function it appears in
>>>     1511 |                 i8042_dritek ? " dritek" : "",
>>>          |                 ^~~~~~~~~~~~
>>>    include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
>>>      418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>>>          |                                 ^~~~~~~~~~~
>>>    include/linux/printk.h:132:17: note: in expansion of macro 'printk'
>>>      132 |                 printk(fmt, ##__VA_ARGS__);             \
>>>          |                 ^~~~~~
>>>    include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
>>>      576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>>          |         ^~~~~~~~~
>>>    drivers/input/serio/i8042-x86ia64io.h:1497:9: note: in expansion of macro 'pr_debug'
>>>     1497 |         pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>>>          |         ^~~~~~~~
>>>
>>>
>>> vim +1511 drivers/input/serio/i8042-x86ia64io.h
>>>
>>>   1494	
>>>   1495		i8042_check_quirks();
>>>   1496	
>>>   1497		pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>>>   1498			i8042_nokbd ? " nokbd" : "",
>>>   1499			i8042_noaux ? " noaux" : "",
>>>   1500			i8042_nomux ? " nomux" : "",
>>>   1501			i8042_unlock ? " unlock" : "",
>>>   1502			i8042_probe_defer ? "probe_defer" : "",
>>>   1503			i8042_reset == I8042_RESET_DEFAULT ?
>>>   1504				"" : i8042_reset == I8042_RESET_ALWAYS ?
>>>   1505					" reset_always" : " reset_never",
>>>   1506			i8042_direct ? " direct" : "",
>>>   1507			i8042_dumbkbd ? " dumbkbd" : "",
>>>   1508			i8042_noloop ? " noloop" : "",
>>>   1509			i8042_notimeout ? " notimeout" : "",
>>>   1510			i8042_kbdreset ? " kbdreset" : "",
>>>> 1511			i8042_dritek ? " dritek" : "",
>>>   1512			i8042_nopnp ? " nopnp" : "");
>>>   1513	
>>>   1514		retval = i8042_pnp_init();
>>>   1515		if (retval)
>>>   1516			return retval;
>>>   1517	
>>>
> 

