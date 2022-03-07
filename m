Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C8E4D08CB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbiCGUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiCGUw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:52:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F60A29CA1;
        Mon,  7 Mar 2022 12:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=9tM1IcUHnS8qh7d8odUKJS/jksWImABpShrJtrAv/fU=; b=nl0IUzM8m9zG2uM2Bg1l50f93u
        KdNLWT3fvZCaIQHByKLJO5y2Buzwqj8Unp7PsxqY+A/7hfqDwG1abfy6lpWiWax7EH6HCkI8Rifpf
        pTbTkH/N4loW4QOk09E5UVOaVV6Zy3Hp9/YBxSjW6rCbb1+zFcI+jldU/JHP/KL8JrgEzuDHfLFEQ
        PEPholr+lgZBFTNDokot78d3MP0pRcaOE3Qv3H2xjgpOmgwESq5DoseTRGpfnpAB8MMHy3zBC+HK+
        PH2a7IlVhUJDYCHvL/J7yHfRuTSvMcXAOMxYUHrkNM2Z35el1UXIQ2mj8tv/06ctcHAD1H+MFX325
        t9kuHWtg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRKK7-00FXcm-Nt; Mon, 07 Mar 2022 20:51:20 +0000
Message-ID: <ea27ccf9-9ef2-f1db-815b-176b4ed1a907@infradead.org>
Date:   Mon, 7 Mar 2022 12:51:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [next] mips-mt.c:233:19: error: conflicting types for 'mt_init'
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Matthew Wilcox <willy@infradead.org>
References: <CA+G9fYtEx=k9TM7c7EihbO3U0qxZLbKX26NWJ1L=jjEOuy7cHQ@mail.gmail.com>
 <4c8f31d0-d51c-bb8c-acae-da1f1b1ada51@infradead.org>
 <20220307191537.jz6rho2vikdybpam@revolver>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220307191537.jz6rho2vikdybpam@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/22 11:15, Liam Howlett wrote:
> Hello Randy,
> 
> I did address this when it occurred on the 24th [1].  I had looked at
> this and was thinking I would rename the maple tree function, but
> Matthew suggested renaming the mips function instead.  I looked into the
> conflict and the arch/mips/kernel/mips-mt.c uses the mips_ prefix for
> almost all of the functions. So I generated a patch on my tree for
> next-20220225 which fixes the issue by renaming the mips side of things.
> Please see 51e773764d11 for the very small rename.
> 
> [1]
> https://lore.kernel.org/linux-mm/202202241817.MXoE0NcM-lkp@intel.com/
> 
> Thanks,
> Liam

OK, sounds good. Thanks.

> 
> * Randy Dunlap <rdunlap@infradead.org> [220305 22:50]:
>> Hi Liam,
>>
>> Would you consider renaming maple tree's "mt_init()" function to
>> maple_tree_init() or mtree_init() or something that does not
>> conflict with the mt_init() function in arch/mips/ so that
>> these build errors don't happen?
>>
>> thanks.
>>
>> On 2/24/22 23:09, Naresh Kamboju wrote:
>>> [Please ignore this email if it is already reported]
>>>
>>> Linux next-20220224 arch mips build errors / warnings noticed [1].
>>>
>>> Build configs:
>>>   -  mips-gcc-8-malta_defconfig
>>>   -  mips-gcc-10-malta_defconfig
>>>   -  mips-gcc-8-defconfig
>>>   -  mips-gcc-10-defconfig
>>>
>>> metadata:
>>>     git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>>>     git_sha: 44948bd49d878dad6c9707e34f4a06df73c3a800
>>>     git_short_log: 44948bd49d87 (\Add linux-next specific files for 20220224\)
>>>     kconfig: defconfig
>>>     target_arch: mips
>>>     toolchain: gcc-10
>>>
>>>
>>> Build errors / warnings:
>>>
>>> arch/mips/kernel/mips-mt.c:233:19: error: conflicting types for 'mt_init'
>>>   233 | static int __init mt_init(void)
>>>       |                   ^~~~~~~
>>> In file included from include/linux/mm_types.h:12,
>>>                  from include/linux/mmzone.h:21,
>>>                  from include/linux/gfp.h:6,
>>>                  from include/linux/radix-tree.h:12,
>>>                  from include/linux/idr.h:15,
>>>                  from include/linux/kernfs.h:12,
>>>                  from include/linux/sysfs.h:16,
>>>                  from include/linux/kobject.h:20,
>>>                  from include/linux/energy_model.h:7,
>>>                  from include/linux/device.h:16,
>>>                  from arch/mips/kernel/mips-mt.c:7:
>>> include/linux/maple_tree.h:589:20: note: previous definition of
>>> 'mt_init' was here
>>>   589 | static inline void mt_init(struct maple_tree *mt)
>>>       |                    ^~~~~~~
>>> make[3]: *** [scripts/Makefile.build:288: arch/mips/kernel/mips-mt.o] Error 1
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> Steps to reproduce:
>>> ------------------
>>> # To install tuxmake on your system globally:
>>> # sudo pip3 install -U tuxmake
>>>
>>> tuxmake --runtime podman --target-arch mips --toolchain gcc-10
>>> --kconfig defconfig
>>>
>>> --
>>>
>>> [1] https://builds.tuxbuild.com/25aFF2X7uoyebURaYzNHW9FVEmN/
>>
>> -- 
>> ~Randy

-- 
~Randy
