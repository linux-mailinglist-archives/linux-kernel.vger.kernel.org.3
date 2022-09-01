Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806EE5A8D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiIAFLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiIAFLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:11:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7810F10D4FC;
        Wed, 31 Aug 2022 22:11:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E5A9D6E;
        Wed, 31 Aug 2022 22:11:56 -0700 (PDT)
Received: from [10.162.43.7] (unknown [10.162.43.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B05CD3F71A;
        Wed, 31 Aug 2022 22:11:48 -0700 (PDT)
Message-ID: <81864464-8cd1-8afe-ed57-c04b1b22a35b@arm.com>
Date:   Thu, 1 Sep 2022 10:41:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: build failure after merge of the perf tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220831083452.2fc938cf@canb.auug.org.au>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220831083452.2fc938cf@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

This seems to be the same problem as pointed by ACME on the patch series [1].
Could this be a compiler false positive ? Because the new code block is exact
same like the existing one. This warning seems to only occurs on powerpc64el
platform, but not on others.

[1] https://lore.kernel.org/lkml/Yw59CkHUVbfrHdkh@kernel.org/

- Anshuman

On 8/31/22 04:04, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the perf tree, today's linux-next build (native perf)
> failed like this:
> 
> In file included from /usr/include/stdio.h:866,
>                  from /home/sfr/next/next/tools/perf/util/branch.h:9,
>                  from util/branch.c:2:
> In function 'fprintf',
>     inlined from 'branch_type_stat_display' at util/branch.c:152:4:
> /usr/include/powerpc64le-linux-gnu/bits/stdio2.h:105:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
>   105 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   106 |                         __va_arg_pack ());
>       |                         ~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Presumably caused by commit
> 
>   9781e500dcb8 ("perf branch: Extend branch type classification")
> 
> "native" here is PowerPC64 LE.
> $ gcc --version
> gcc (Debian 11.2.0-10) 11.2.0
> 
> I have used the perf tree from next-20220830 for today.
> 
