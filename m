Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBAA4CA440
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiCBLxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiCBLxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:53:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5E49274
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:52:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AD2281F37E;
        Wed,  2 Mar 2022 11:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646221975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17Yx87zcUkbxgqjZC6j2RKiiBVRCwqSfkoMpziNTDNM=;
        b=nXIttdMYoc1ALis0aYUH0cDJw8pOnFSjZ7x9GMK6AF3pTLTf9rb7mXrDkRqGV/gCepIuGd
        Dqs4jXuWKFa1ihM5BrGLxKiwgD4hUchct6XQuu26F7UGjR5cxrUXHJnhaZgN4y1YQ5O0O7
        8fy/2eoT9zP6RrnbySW5W5Yt0Fv7rYM=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 18019A3B83;
        Wed,  2 Mar 2022 11:52:55 +0000 (UTC)
Date:   Wed, 2 Mar 2022 12:52:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [hnaz-mm:master 272/379] lib/vsprintf.c:991:13: warning:
 variable 'modbuildid' set but not used
Message-ID: <Yh9alvkQhbbgppW0@alley>
References: <202203012040.uFWGm3My-lkp@intel.com>
 <20220301102448.ff9bf910213d705842a2dd45@linux-foundation.org>
 <Yh5yhoW+y9qcn1RM@casper.infradead.org>
 <8735k0isum.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735k0isum.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 10:58:49, John Ogness wrote:
> On 2022-03-01, Matthew Wilcox <willy@infradead.org> wrote:
> >> >    lib/vsprintf.c: In function 'va_format':
> >> >    lib/vsprintf.c:1759:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
> >> >     1759 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
> >> >          |         ^~~
> >> 
> >> I wonder what this means.
> >
> > It means the compiler thinks we might want to add:
> >
> > __attribute__((format(gnu_printf, x, y))) to the function declaration so it
> > can type-check the arguments.
> >
> > 'format (ARCHETYPE, STRING-INDEX, FIRST-TO-CHECK)'
> >      The 'format' attribute specifies that a function takes 'printf',
> >      'scanf', 'strftime' or 'strfmon' style arguments that should be
> >      type-checked against a format string.  For example, the
> >      declaration:
> >
> >           extern int
> >           my_printf (void *my_object, const char *my_format, ...)
> >                 __attribute__ ((format (printf, 2, 3)));
> >
> >      causes the compiler to check the arguments in calls to 'my_printf'
> >      for consistency with the 'printf' style format string argument
> >      'my_format'.
> >
> >
> > I haven't looked into this at all and have no idea if we should.
> 
> AFAICT it is not possible to use the gnu_printf format attribute for
> this because the va_list to check is a field within the passed in struct
> pointer @va_fmt.

My understanding is that it can be handled by passing '0' as the
FIRST-TO-CHECK parameter:

<paste>
format (archetype, string-index, first-to-check)
The format attribute specifies that a function takes printf, scanf,
strftime or strfmon style arguments that should be type-checked
against a format string. For example, the declaration:

[...]

"For functions where the arguments are not available to be checked
(such as vprintf), specify the third parameter as zero."
<paste>

, cut&pasted from
https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes


Well, this particular function va_format() is never used with
open-coded @arg parameter. It always just passes @arg from
the caller. So that the check is not important.

Best Regards,
Petr
