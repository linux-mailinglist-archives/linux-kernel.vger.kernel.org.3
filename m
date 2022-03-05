Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C94CE442
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 11:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiCEKpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 05:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiCEKpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 05:45:08 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E72359F3;
        Sat,  5 Mar 2022 02:44:17 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,157,1643670000"; 
   d="scan'208";a="7686855"
Received: from vlr74-1_migr-78-197-125-196.fbx.proxad.net (HELO randriaga) ([78.197.125.196])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2022 11:44:16 +0100
References: <87k0dbosis.fsf@irisa.fr>
 <CAK7LNARV4ax0t-drWMx0G==gDmcpXJoOvRuRQ6dS440245AwjQ@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   RANDRIANAINA Georges Aaron <georges-aaron.randrianaina@irisa.fr>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Acher <mathieu.acher@irisa.fr>
Subject: Re: [PATCH] kconfig: add KCONFIG_ALLCONFIG support for tinyconfig
Date:   Sat, 05 Mar 2022 10:05:18 +0100
In-reply-to: <CAK7LNARV4ax0t-drWMx0G==gDmcpXJoOvRuRQ6dS440245AwjQ@mail.gmail.com>
Message-ID: <87zgm41xwp.fsf@irisa.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masahiro Yamada <masahiroy@kernel.org> writes:

> On Fri, Mar 4, 2022 at 2:27 AM Randrianaina Georges Aaron
> <georges-aaron.randrianaina@irisa.fr> wrote:
>>
>> Since f8f0d06438e5, tinyconfig overrides KCONFIG_ALLCONFIG to
>> include kernel/configs/tiny-base.config. However, this ignores
>> user's preset if defined.
>>
>> This modification checks if the user has set KCONFIG_ALLCONFIG
>> and if so, concatenates it with kernel/configs/tiny-base.config
>> to be used as preset config symbols.
>>
>> Signed-off-by: Randrianaina Georges Aaron <georges-aaron.randrianaina@irisa.fr>
>> ---
>>  scripts/kconfig/Makefile | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
>> index b8ef0fb4bbef..337693fb4762 100644
>> --- a/scripts/kconfig/Makefile
>> +++ b/scripts/kconfig/Makefile
>> @@ -102,7 +102,13 @@ configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/c
>>
>>  PHONY += tinyconfig
>>  tinyconfig:
>> +ifeq ($(KCONFIG_ALLCONFIG),)
>>         $(Q)KCONFIG_ALLCONFIG=kernel/configs/tiny-base.config $(MAKE) -f $(srctree)/Makefile allnoconfig
>> +else
>> +       $(Q)cat $(KCONFIG_ALLCONFIG) <(echo) kernel/configs/tiny-base.config > .tmp.config
>
>
> I assume "<(echo)" exists here to insert a blank line.
> The process substitution is a bash'ism.
>
> If you execute it on Debian or its variants, where /bin/sh is a symlink
> to dash, it fails.
>
> masahiro@grover:~/ref/linux$ make  KCONFIG_ALLCONFIG=/tmp/dummy.config
> tinyconfig
> /bin/sh: 1: Syntax error: "(" unexpected
> make[1]: *** [scripts/kconfig/Makefile:108: tinyconfig] Error 2
> make: *** [Makefile:619: tinyconfig] Error 2
>
>
>
> We can delete '<(echo)', but another issue is that this does not work
> with O=<dir> option.

Yes, we can delete `<(echo)`. We can solve the remaining issue by adding
`$(srctree)` in the presets' path to make it work with O=<dir>.

>
>
> masahiro@grover:~/ref/linux$ make O=foo
> KCONFIG_ALLCONFIG=/tmp/dummy.config tinyconfig
> make[1]: Entering directory '/home/masahiro/ref/linux/foo'
>   GEN     Makefile
>   HOSTCC  scripts/basic/fixdep
> cat: kernel/configs/tiny-base.config: No such file or directory
> make[2]: *** [../scripts/kconfig/Makefile:108: tinyconfig] Error 1
> make[1]: *** [/home/masahiro/ref/linux/Makefile:619: tinyconfig] Error 2
> make[1]: Leaving directory '/home/masahiro/ref/linux/foo'
> make: *** [Makefile:219: __sub-make] Error 2
>
>
>
>
>
>> +       $(Q)KCONFIG_ALLCONFIG=.tmp.config $(MAKE) -f $(srctree)/Makefile allnoconfig
>> +       $(Q)rm -f .tmp.config
>> +endif
>>         $(Q)$(MAKE) -f $(srctree)/Makefile tiny.config
>>
>>  # CHECK: -o cache_dir=<path> working?
>> --
>> 2.34.1
