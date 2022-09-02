Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DDE5AB59A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiIBPsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiIBPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:47:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD1656B95
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:37:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so2499396pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xjZHYttz+7urWvtOVsT02sLNgt+L2/+i45ffFn6TJvQ=;
        b=EEwoZk3q04e7SP63bgx2MgP8cZ4glRWXKdlzqbP4HbeT8u4udN7aNSJxOXgArCh0TJ
         eOyeLcN1/xYU7fYeWtl/whv0nNvjUsL1opNfXamQc/b9r7llXt50BeRL/ElNHPM6aEVh
         M//xGmC6AkcftdO3DYQhGqgVA5fhHFWXm/GSyFqhk3JtnS38Y3RQzur/5hUQ0ZBj/9Hx
         aiY/rloCmMMFVFsyrMopdOzy3KLOCloL5i71gNbYOU42m46k7T644cV5euPdXRei67qz
         gmdgy+2XVNxcFmh1ys5vz2gQ3vLscImoe4XRhv5+nT4n3Mgzogy2CLU3Ad+rHBHSLAWn
         +BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xjZHYttz+7urWvtOVsT02sLNgt+L2/+i45ffFn6TJvQ=;
        b=v7Hgbr3SI2MFxjIwKRJ70tBZjo/2kBhAEKvh+cryPjTRh1rAAV96N5Zn+zboUuofs9
         Y6Iy7whkA6SSEBSSKTM8S7iqR8+kFkFL8KBpmBN4u1KaRhzWMr23JfXRjNA+Iftdz3GD
         Dq5TC7e4b4+km9z4dALqFxT5y4sIwNXOOUNXlVCsd6wMILwtXSUz8kmdsuKszoOBr9vL
         ohUJIfwdikeFXo3EI9Oh9JpNBQPtvVnCbXJJlQoYyytwTekKx7LyYIVfA39mAgeAX2tv
         rFs11vBZktr7d/39h0bbMT/seAyMGfqFzE4J/j7XlLAgt3nZVHnN2rsTQQK1udkiYQ8o
         kKOQ==
X-Gm-Message-State: ACgBeo2GMzmBHXRUI4OfnZXKLK/i765eDj9cqg+BhtNHkNV+EmxnDolh
        i0cLlL3fTS1sK/PDtlxlHO+mortxToO8bA==
X-Google-Smtp-Source: AA6agR73cagUX3hdIB9k+r9ZHEWNTzy2eU1L4rUfBWY0xcKW0+Kgr8rCs+udhEM6SwyFSnYLxp+X+A==
X-Received: by 2002:a17:90b:1d02:b0:1fe:36a:6e01 with SMTP id on2-20020a17090b1d0200b001fe036a6e01mr5445100pjb.102.1662133031995;
        Fri, 02 Sep 2022 08:37:11 -0700 (PDT)
Received: from [10.4.97.191] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090a3d0c00b001f262f6f717sm5428837pjc.3.2022.09.02.08.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 08:37:11 -0700 (PDT)
Message-ID: <52d6d592-efb6-036b-5390-635913c598f3@bytedance.com>
Date:   Fri, 2 Sep 2022 23:37:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: mm/khugepaged.c:2046:56: warning: 'struct khugepaged_mm_slot'
 declared inside parameter list will not be visible outside of this definition
 or declaration
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202209022248.TEjW4Cld-lkp@intel.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <202209022248.TEjW4Cld-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/2 22:23, kernel test robot wrote:
> tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220901-154717/Qi-Zheng/add-common-struct-mm_slot-and-use-it-in-THP-and-KSM/20220831-112149
> head:   32b787e37af17f7fe75f9b9c9bb22bf044722229
> commit: 7ad02cf1645071c2bf1ed6ae0e48907aa0a3119e mm: thp: fix build error with CONFIG_SHMEM disabled
> date:   30 hours ago
> config: sparc-randconfig-r023-20220901 (https://download.01.org/0day-ci/archive/20220902/202209022248.TEjW4Cld-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/7ad02cf1645071c2bf1ed6ae0e48907aa0a3119e
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review UPDATE-20220901-154717/Qi-Zheng/add-common-struct-mm_slot-and-use-it-in-THP-and-KSM/20220831-112149
>          git checkout 7ad02cf1645071c2bf1ed6ae0e48907aa0a3119e
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> mm/khugepaged.c:2046:56: warning: 'struct khugepaged_mm_slot' declared inside parameter list will not be visible outside of this definition or declaration
>      2046 | static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
>           |                                                        ^~~~~~~~~~~~~~~~~~
>     mm/khugepaged.c: In function 'khugepaged_scan_mm_slot':
>     mm/khugepaged.c:2076:45: error: passing argument 1 of 'khugepaged_collapse_pte_mapped_thps' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      2076 |         khugepaged_collapse_pte_mapped_thps(mm_slot);
>           |                                             ^~~~~~~
>           |                                             |
>           |                                             struct mm_slot *

It looks like the robot tested "mm: thp: fix build error with
CONFIG_SHMEM disabled" alone without "[PATCH v2 2/7] mm: thp: convert to
use common struct mm_slot". So this is a false positive.

>     mm/khugepaged.c:2046:76: note: expected 'struct khugepaged_mm_slot *' but argument is of type 'struct mm_slot *'
>      2046 | static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
>           |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>     cc1: some warnings being treated as errors
> 
> 
> vim +2046 mm/khugepaged.c
> 
>    2045	
>> 2046	static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
>    2047	{
>    2048	}
>    2049	#endif
>    2050	
> 

-- 
Thanks,
Qi
