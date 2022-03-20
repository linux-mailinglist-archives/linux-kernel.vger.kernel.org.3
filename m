Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E44E1CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbiCTQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbiCTQiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:38:25 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103803EAB5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 09:37:02 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.4])
        by gnuweeb.org (Postfix) with ESMTPSA id 7A33B7E2DA;
        Sun, 20 Mar 2022 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647794221;
        bh=7HDpyaqJ3Esg6x9zu/669IsMjA3/gjhXtFUxFcLvI2g=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=t/OJzLcPJ6palU0G8VBm8GL7mgyhaL4txMim5jjNoSSqxL+IHDtr9KTKTCFY3pajw
         boHc4Vs/H+D0WddZYUyGN98VqfBFrtB8eeKi/9oBKsu6Wgz0HgoQUW5/xqgXLHVhJg
         sangfkhey3/s3f7qGLgt5vdq83QQiB3222pw5lZpM1AYT1Y2rtroMdFY+YnQlzU6fo
         nJ1BTvZdtVKaz1x0n8tj9izDxMa4lasTqKhcgHU/I++Ss/FKyrylGxEZ2j9hQwrD1k
         erV9fk3ubqkvgPIORXHXwhI8eOY0Ub7x2OHrkPBzjVRUj747PFguEuvtO6X5xCg08H
         o/NV20RDq6loQ==
Message-ID: <c7129520-5e9a-f9d1-cc12-5af9456c917f@gnuweeb.org>
Date:   Sun, 20 Mar 2022 23:36:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-6-ammarfaizi2@gnuweeb.org>
 <20220320161644.GF8067@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH v1 5/6] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
In-Reply-To: <20220320161644.GF8067@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/22 11:16 PM, Willy Tarreau wrote:
> Ammar,
> 
> a few points below:
> 
> On Sun, Mar 20, 2022 at 04:37:49PM +0700, Ammar Faizi wrote:
>> +struct nolibc_heap {
>> +	size_t	len;
>> +	char	user_p[] __attribute__((__aligned__));
>> +};
> 
> Note that many programs assume that malloc() returns a field aligned
> to 2*sizeof(pointer) and unless I'm mistaken, above the user pointer
> will only be aligned by one pointer. This may have an impact when the
> compiler decides to use SIMD instructions.

Section 7.20.3 of C99 states this about `malloc()`:
"""
   The pointer returned if the allocation succeeds is suitably aligned
   so that it may be assigned to a pointer to any type of object.
"""

And this is what GCC doc says about __attribute__((__aligned__)):
"""
   The aligned attribute specifies a minimum alignment for the variable
   or structure field, measured in bytes. When specified, alignment must
   be an integer constant power of 2. Specifying no alignment argument
   implies the maximum alignment for the target, which is often, but by
   no means always, 8 or 16 bytes.
"""

Link: https://gcc.gnu.org/onlinedocs/gcc-11.2.0/gcc/Common-Variable-Attributes.html#Common-Variable-Attributes

Simple experiment on Linux x86-64...

```
ammarfaizi2@integral2:/tmp$ cat > test.c
#include <stdio.h>
int main(void)
{
	printf("alignof = %zu\n", __alignof__(long double));
	return 0;
}
ammarfaizi2@integral2:/tmp$ gcc -o test test.c
ammarfaizi2@integral2:/tmp$ ./test
alignof = 16
ammarfaizi2@integral2:/tmp$
```

We have `long double` which requires 16 byte alignment. So
__attribute__((__aligned__)) should cover this. And yes, it's true that
it's 2*sizeof(void*), but importantly for the above reason.

>> +#ifndef offsetof
>> +#define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
>> +#endif
>> +
>> +#ifndef container_of
>> +#define container_of(PTR, TYPE, FIELD) ({			\
>> +	__typeof__(((TYPE *)0)->FIELD) *__FIELD_PTR = (PTR);	\
>> +	(TYPE *)((char *) __FIELD_PTR - offsetof(TYPE, FIELD));	\
>> +})
>> +#endif
> 
> These ones are independent on the malloc code and should move to a
> different patch and likely to a different file. I'm seeing we already
> have a few macros in types.h and since it's shared by almost everything
> it might be more suitable there.

OK, will do it in the v2. Thanks!

-- 
Ammar Faizi
