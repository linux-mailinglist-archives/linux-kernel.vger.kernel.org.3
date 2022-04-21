Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6FE50A448
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388250AbiDUPf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiDUPfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:35:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613A3B847;
        Thu, 21 Apr 2022 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=UlrK2UBvxdMqDUsjxJEXKn2pxD/qQjI/AOd8I2Jov7k=; b=FnY3bky969vzjNorLHSkfXetcF
        G5APoF9zoTeF2Ar4VEr2KoaVMxpqwYjBU6GFNGQkHCG2OvTx7jwbeEpaqulM3M0LeHfu7o+G/Nyq6
        7nDZjBwM2O9yVFW0jajDjs7rPQg42o7UumUdenJ8OZrMrWN4lgOCRnBM69WxOcdLA8s8hojtBD6O3
        YlzIg5tCildFIjzRpUfJk+5RgSfqW+vjsh/uMILJma57NDgDJE02I6YT2jiXwqpeaMfshbCp0cKoD
        /T/vVEHF57ujO5sU6Qq9TYxYKz2SwG6WTbH+C5ZOMtrxIdwOAqP1arugT0JFJ91agq+rRiVp3ao3i
        2uJWziHA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhYnG-005D0K-Ou; Thu, 21 Apr 2022 15:32:31 +0000
Message-ID: <d7b81bef-5f51-2b42-6f84-ec09d9b469ff@infradead.org>
Date:   Thu, 21 Apr 2022 08:32:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [next] s390: build failed
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CA+G9fYvA9e760hFH==n2_gn8zNQeGBQ1=8_+Ot1sMCwoPiS15g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CA+G9fYvA9e760hFH==n2_gn8zNQeGBQ1=8_+Ot1sMCwoPiS15g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 02:57, Naresh Kamboju wrote:
> Linux next-20220421 s390 tinyconfig and allnoconfig builds failed [1].
> 
> Regressions found on s390:
>   - s390-clang-nightly-tinyconfig
>   - s390-gcc-10-tinyconfig
>   - s390-gcc-11-tinyconfig
>   - s390-clang-14-allnoconfig
>   - s390-clang-nightly-allnoconfig
>   - s390-clang-14-tinyconfig
>   - s390-clang-13-tinyconfig
>   - s390-gcc-10-allnoconfig
>   - s390-clang-13-allnoconfig
>   - s390-gcc-9-allnoconfig
>   - s390-gcc-9-tinyconfig
>   - s390-gcc-11-allnoconfig
>   - s390-gcc-8-tinyconfig
>   - s390-gcc-8-allnoconfig
> 
> In file included from arch/s390/mm/pageattr.c:6:
> include/linux/hugetlb.h:414:25: error: unknown type name
> 'zap_flags_t'; did you mean 'vm_flags_t'?
>   414 |                         zap_flags_t zap_flags)
>       |                         ^~~~~~~~~~~
>       |                         vm_flags_t
> make[3]: *** [scripts/Makefile.build:284: arch/s390/mm/pageattr.o] Error 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 

Here's a fix:

https://lore.kernel.org/lkml/20220421014723.5802-1-rdunlap@infradead.org/

> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> [1] https://builds.tuxbuild.com/2868Z0YrLSpSGSk9QDqRKYMJPug/

-- 
~Randy
