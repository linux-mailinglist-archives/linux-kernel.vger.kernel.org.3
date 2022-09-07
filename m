Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27BA5AFB11
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIGEW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGEWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:22:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A29B89916;
        Tue,  6 Sep 2022 21:22:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33871042;
        Tue,  6 Sep 2022 21:22:58 -0700 (PDT)
Received: from [10.162.40.15] (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F22D3F534;
        Tue,  6 Sep 2022 21:22:50 -0700 (PDT)
Message-ID: <e091ed53-d5d0-101d-92a6-a215350e482e@arm.com>
Date:   Wed, 7 Sep 2022 09:52:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: build failure after merge of the perf tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220831083452.2fc938cf@canb.auug.org.au>
 <20220907050535.243e5030@canb.auug.org.au>
 <29e096e8-4ede-df66-4606-4bd0e5bda755@arm.com>
 <20220907130011.32818436@canb.auug.org.au>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220907130011.32818436@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/22 08:30, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 7 Sep 2022 08:01:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> On 9/7/22 00:35, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> On Wed, 31 Aug 2022 08:34:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
>>>>
>>>> After merging the perf tree, today's linux-next build (native perf)
>>>> failed like this:
>>>>
>>>> In file included from /usr/include/stdio.h:866,
>>>>                  from /home/sfr/next/next/tools/perf/util/branch.h:9,
>>>>                  from util/branch.c:2:
>>>> In function 'fprintf',
>>>>     inlined from 'branch_type_stat_display' at util/branch.c:152:4:
>>>> /usr/include/powerpc64le-linux-gnu/bits/stdio2.h:105:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
>>>>   105 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>>>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>   106 |                         __va_arg_pack ());
>>>>       |                         ~~~~~~~~~~~~~~~~~
>>>> cc1: all warnings being treated as errors
>>>>
>>>> Presumably caused by commit
>>>>
>>>>   9781e500dcb8 ("perf branch: Extend branch type classification")
>>>>
>>>> "native" here is PowerPC64 LE.
>>>> $ gcc --version
>>>> gcc (Debian 11.2.0-10) 11.2.0
>>>>
>>>> I have used the perf tree from next-20220830 for today.  
>>>
>>> I am still seeing this build failure.  
>>
>> But did you apply the fix patch from Arnaldo that removes -Wno-format-overflow
>> compiler option for the file util/branch.c ?
>>
>> https://lore.kernel.org/all/YxJBh3wvAGol+Ekq@kernel.org/
> 
> No, I expected a fix to be in the perf tree ...
> 
> Also note that the following fixes the problem for me:
> 
> diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
> index d40776c44b06..b7b898f2872e 100644
> --- a/tools/perf/util/branch.c
> +++ b/tools/perf/util/branch.c
> @@ -88,7 +88,8 @@ const char *branch_type_name(int type)
>  		"ERET",
>  		"IRQ",
>  		"SERROR",
> -		"NO_TX"
> +		"NO_TX",
> +		""
>  	};
>  
>  	if (type >= 0 && type < PERF_BR_MAX)

This looks right, makes sense.

> 
> 
> PERF_BR_MAX has been increased by one (when PERF_BR_EXTEND_ABI was
> added), but a new string has not been added to the array ...

Right, even though new branch_new_names[] array gets queried on when type
value is PERF_BR_EXTEND_ABI, branch_names[] should still contain an empty
string "" just to match the now incremented PERF_BR_MAX which extends the
array size as well. I guess the compiler detects this mismatch here and
just complains about it.

Hello Arnaldo,

As adding empty string to the array solves the build problem, I guess we
should fold this fix instead, rather than trying to drop the compiler
option itself, as discussed earlier.

The above fix should be folded into the following commit

9781e500dcb8 ("perf branch: Extend branch type classification")

in the following perf tree - branch.

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git (perf/core)

- Anshuman
