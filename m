Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C43C4CA162
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiCBJxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240725AbiCBJxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:53:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4767DE14
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:52:52 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646214770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HiQwZhLO+V+Li9Vx/L/RByuSq1OOXUO7G6tMy6whFQ0=;
        b=VjJ7rxcbWgG73klIYAkTGinVMC3bmnh7/4mRK9dyNVmBlyaDNFkCR43qhKPEp8Z1ZgC8dy
        LcP9w8Vo/Zj3GJhu/tL09rn1AQt23gFYC7hohyh+yNuZk5ogw8vh7N3/ey1aLOca2dzkhe
        K2OyZjEc/jinADBHIs8sgkMZn4D9Ga+CvfPDSAP22tqPw6RFqouyvSrtvgi3arpGcsNAJV
        /TsymlCcFSXHmDdYUcqEoW1LPzKWRnk3eejf1X/+SO+apwgr+zc870HMbXD+MkWRzU8aiQ
        OeshiCCwKxWLuONur0XKloT/xSIAh0ovgv/YSarih4rDFyx/vFAGEPK+DKuVAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646214770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HiQwZhLO+V+Li9Vx/L/RByuSq1OOXUO7G6tMy6whFQ0=;
        b=l1E3u1waIbN+5wcPD0XM4nTY3Rf+hEiYAYMgq9ynvte4swHlxadupcOlQSv6kteJjX+EbO
        Uu9h2HxMd6LtOLDg==
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [hnaz-mm:master 272/379] lib/vsprintf.c:991:13: warning:
 variable 'modbuildid' set but not used
In-Reply-To: <Yh5yhoW+y9qcn1RM@casper.infradead.org>
References: <202203012040.uFWGm3My-lkp@intel.com>
 <20220301102448.ff9bf910213d705842a2dd45@linux-foundation.org>
 <Yh5yhoW+y9qcn1RM@casper.infradead.org>
Date:   Wed, 02 Mar 2022 10:58:49 +0106
Message-ID: <8735k0isum.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-01, Matthew Wilcox <willy@infradead.org> wrote:
>> >    lib/vsprintf.c: In function 'va_format':
>> >    lib/vsprintf.c:1759:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>> >     1759 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
>> >          |         ^~~
>> 
>> I wonder what this means.
>
> It means the compiler thinks we might want to add:
>
> __attribute__((format(gnu_printf, x, y))) to the function declaration so it
> can type-check the arguments.
>
> 'format (ARCHETYPE, STRING-INDEX, FIRST-TO-CHECK)'
>      The 'format' attribute specifies that a function takes 'printf',
>      'scanf', 'strftime' or 'strfmon' style arguments that should be
>      type-checked against a format string.  For example, the
>      declaration:
>
>           extern int
>           my_printf (void *my_object, const char *my_format, ...)
>                 __attribute__ ((format (printf, 2, 3)));
>
>      causes the compiler to check the arguments in calls to 'my_printf'
>      for consistency with the 'printf' style format string argument
>      'my_format'.
>
>
> I haven't looked into this at all and have no idea if we should.

AFAICT it is not possible to use the gnu_printf format attribute for
this because the va_list to check is a field within the passed in struct
pointer @va_fmt.

John Ogness
