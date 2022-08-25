Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C425A1015
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbiHYMNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbiHYMM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0087DAB04A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661429576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8i+ljzn6MB/eBmFGfmQrAmtwmX21MBronF2Ff991Uq0=;
        b=Tl5wIROAqgc9Dkm7P5xVsAYHwqvgQwSk1weoR6fyalKSXuCholJ1x3FqTlUAGvqkr+oTXY
        R76JYi/VbJ9keacoAykNaTMx39TsyR2uHemJwAFR+1lAe3KbYJV9/rBqZDqgtC+PA8Buvz
        F5JSUBYkDpIbtHzruGAxDJ0CbzXK00s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-OGkpsr8CO02np5SZcR8xcg-1; Thu, 25 Aug 2022 08:12:53 -0400
X-MC-Unique: OGkpsr8CO02np5SZcR8xcg-1
Received: by mail-wr1-f72.google.com with SMTP id i29-20020adfa51d000000b002251fd0ff14so3334578wrb.16
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=8i+ljzn6MB/eBmFGfmQrAmtwmX21MBronF2Ff991Uq0=;
        b=x5rAOVgZzHxmvfcr0gWDnXv2K73mKi5oStI53sfHHqn1/Dd5gkKS90iS1LA9f9jSRY
         rUAvkFlvCHEuTYQGehMvhubhqhZANQHbThWzqfMDhLrjTH8SwsZ4hOFezr4qhDvjKFhz
         ePcLyfrp6RvnHgdZLbfWCG+KyjjoJqQxkocmzEr1tdGVKDalH67uIQ2VzXXdBMtFBjC0
         nnovSzl2HQlC9R9KBU00PuyXbgKim4LVsTntFZlV7cltQj29EOSRGo8SfeKjItQXDx2B
         Fog9ZrZPN1ol8sTa+Ch3JVBls4npDuBvxfhTLEL6suklJ97jFYVnY7fdYK/rG8Rfr/IR
         doBA==
X-Gm-Message-State: ACgBeo14tJp5BpY1tGluU8qzMhIUxlzLNcZtld6M8IdSyNEYWZPkF0xc
        07VykA7xbWCvKVMCXeAIi4ocrN9iMGY7Pcff7PwrIFBzBZPXYv2GavkDW46g6q3vDkF/kVipLmh
        BjNDeH/YZmbgX8LsVUlmogNp8
X-Received: by 2002:a05:6000:250:b0:225:624b:13 with SMTP id m16-20020a056000025000b00225624b0013mr2006738wrz.127.1661429572666;
        Thu, 25 Aug 2022 05:12:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4XU9Thjdw3dtY8hDYFZgZjn5H98wAmkQlzCVmgXAIYgtj8pToIYo+QGnxLFtQp8Qh/i6f5kw==
X-Received: by 2002:a05:6000:250:b0:225:624b:13 with SMTP id m16-20020a056000025000b00225624b0013mr2006717wrz.127.1661429572383;
        Thu, 25 Aug 2022 05:12:52 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b003a601a1c2f7sm5259554wmq.19.2022.08.25.05.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:12:51 -0700 (PDT)
Message-ID: <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
Date:   Thu, 25 Aug 2022 14:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
In-Reply-To: <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.22 23:59, John Hubbard wrote:
> On 8/24/22 09:30, David Hildenbrand wrote:
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index 03eb53fd029a..a6d81ff578fe 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -1186,6 +1186,33 @@ expression used.  For instance:
>>  	#endif /* CONFIG_SOMETHING */
>>  
> 
> I like the idea of adding this documentation, and this is the right
> place. Naturally, if one likes something, one must immediately change
> it. :) Therefore, here is an alternative writeup that I think captures
> what you and the email threads were saying.
> 
> How's this sound?

Much better, thanks! :)

> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 03eb53fd029a..32df0d503388 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -1185,6 +1185,53 @@ expression used.  For instance:
>         ...
>         #endif /* CONFIG_SOMETHING */
>  
> +22) Do not crash the kernel
> +---------------------------
> +
> +Use WARN() rather than BUG()
> +****************************
> +
> +Do not add new code that uses any of the BUG() variants, such as BUG(),
> +BUG_ON(), or VM_BUG_ON(). Instead, use a WARN*() variant, preferably
> +WARN_ON_ONCE(), and possibly with recovery code. Recovery code is not required
> +if there is no reasonable way to at least partially recover.

I'll tend to keep in this section:

"Unavoidable data corruption / security issues might be a very rare
exception to this rule and need good justification."

Because there are rare exceptions, and I'd much rather document the
clear exception to this rule.

> +
> +Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
> +**************************************************
> +
> +WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it is
> +common for a given warning condition, if it occurs at all, to occur multiple
> +times. (For example, once per file, or once per struct page.) This can fill up

I'll drop the "For example" part. I feel like this doesn't really need
an example -- most probably we've all been there already when the kernel
log was flooded :)

> +and wrap the kernel log, and can even slow the system enough that the excessive
> +logging turns into its own, additional problem.
> +
> +Do not WARN lightly
> +*******************
> +
> +WARN*() is intended for unexpected, this-should-never-happen situations. WARN*()
> +macros are not to be used for anything that is expected to happen during normal
> +operation. These are not pre- or post-condition asserts, for example. Again:
> +WARN*() must not be used for a condition that is expected to trigger easily, for
> +example, by user space actions. pr_warn_once() is a possible alternative, if you
> +need to notify the user of a problem.
> +
> +Do not worry about panic_on_warn users
> +**************************************
> +
> +A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
> +available kernel option, and that many users set this option. This is why there
> +is a "Do not WARN lightly" writeup, above. However, the existence of
> +panic_on_warn users is not a valid reason to avoid the judicious use WARN*().
> +That is because, whoever enables panic_on_warn has explicitly asked the kernel
> +to crash if a WARN*() fires, and such users must be prepared to deal with the
> +consequences of a system that is somewhat more likely to crash.

Side note: especially with kdump() I feel like we might see much more
widespread use of panic_on_warn to be able to actually extract debug
information in a controlled manner -- for example on enterprise distros.
... which would then make these systems more likely to crash, because
there is no way to distinguish a rather harmless warning from a severe
warning :/ . But let's see if some kdump() folks will share their
opinion as reply to the cover letter.

-- 
Thanks,

David / dhildenb

