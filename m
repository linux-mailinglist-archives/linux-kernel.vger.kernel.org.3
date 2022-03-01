Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB74C942C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiCATXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCATXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:23:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC3140CC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V7cO4Vt0cqwoaFpMPaL/vt8fgnm5Csm52tiUXCCqF1k=; b=pQo8E+ASPNjC9fWdI74CITZ4X5
        z8Ucp18NfeCkRJlhdwusTjtRF89LYP6qjuUYOzOAL/jS73Hr2BVkVirE8kKU9Deek9ExozWp7FQS8
        TqzaZfdaJjzsfH5OPpthFaANK4qHhX8fkfJIq1UlzONXJEIrQmslkqqxACkNMg2Xp49If1BH9x303
        XJgX8c0jID0aZDzCbT2J+Qz/wHmwwzxS164ajmAE4UIw6MCTF01cem8ZaAHI/12ujnu/HRvZ3ZvjZ
        p2BsPERIsgFVC7i0tCNb1fws6bgVpkKKvuYUN05HBIyyHnorpeM43E03otmCyKD1A4u6sGDXLDMw7
        MbUZ1MXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP858-009s4B-JU; Tue, 01 Mar 2022 19:22:46 +0000
Date:   Tue, 1 Mar 2022 19:22:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [hnaz-mm:master 272/379] lib/vsprintf.c:991:13: warning:
 variable 'modbuildid' set but not used
Message-ID: <Yh5yhoW+y9qcn1RM@casper.infradead.org>
References: <202203012040.uFWGm3My-lkp@intel.com>
 <20220301102448.ff9bf910213d705842a2dd45@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301102448.ff9bf910213d705842a2dd45@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 10:24:48AM -0800, Andrew Morton wrote:
> >    lib/vsprintf.c: In function 'va_format':
> >    lib/vsprintf.c:1759:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
> >     1759 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
> >          |         ^~~
> 
> I wonder what this means.

It means the compiler thinks we might want to add:

__attribute__((format(gnu_printf, x, y))) to the function declaration so it
can type-check the arguments.

'format (ARCHETYPE, STRING-INDEX, FIRST-TO-CHECK)'
     The 'format' attribute specifies that a function takes 'printf',
     'scanf', 'strftime' or 'strfmon' style arguments that should be
     type-checked against a format string.  For example, the
     declaration:

          extern int
          my_printf (void *my_object, const char *my_format, ...)
                __attribute__ ((format (printf, 2, 3)));

     causes the compiler to check the arguments in calls to 'my_printf'
     for consistency with the 'printf' style format string argument
     'my_format'.


I haven't looked into this at all and have no idea if we should.
