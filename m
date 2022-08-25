Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71C45A127B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbiHYNj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiHYNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:39:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C625B56FD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:39:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E53232073D;
        Thu, 25 Aug 2022 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661434760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2azcP9tPZvQFnWr+B5701VWdlvj+WXIa4/SiL59J3Gc=;
        b=JVhxdBDZ8ECfBxGpsf1qS6JkalqzAoKaChz7p8wmqF60cq6cDhxExtUodo7EAN5uD7nWux
        hHez746eEQmgs6aQFkb3+M8Kl2KzB2NW5U3AcvkJE/f8QZC30NtnBcZukrheGc0ExNuAiN
        JaAt1ksz+1DJ5kNMHt+csMJaJcuG/3Y=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 24E082C141;
        Thu, 25 Aug 2022 13:39:20 +0000 (UTC)
Date:   Thu, 25 Aug 2022 15:39:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, rf@opensource.cirrus.com,
        will@kernel.org
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-ID: <Ywd7h68eYwGDYBtJ@alley>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <Yt6u34sigPEkeZ0Y@FVFF77S0Q05N.cambridge.arm.com>
 <Yt605xj898VSAsA3@casper.infradead.org>
 <YuPwLq+D8k53GZa3@smile.fi.intel.com>
 <YuPwgmHbcQYsA4Kp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuPwgmHbcQYsA4Kp@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-07-29 17:36:50, Andy Shevchenko wrote:
> On Fri, Jul 29, 2022 at 05:35:26PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 25, 2022 at 04:21:11PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 25, 2022 at 03:55:27PM +0100, Mark Rutland wrote:
> > > > On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> > > > > At many places in kernel, It is necessary to convert sysfs input
> > > > > to corrosponding bool value e.g. "false" or "0" need to be converted
> > > > > to bool false, "true" or "1" need to be converted to bool true,
> > > > > places where such conversion is needed currently check the input
> > > > > string manually, kstrtobool() can be utilized at such places but
> > > > > currently it doesn't have support to accept "false"/"true".
> > > > > 
> > > > > Add support to accept "false"/"true" as valid string in kstrtobool().
> > > > > 
> > > > > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > 
> > > > I've just spotted that this broke arm64's "rodata=full" command line option,

The problem still seems to be in mainline.


> > > That isn't a documented option.
> > > 
> > >         rodata=         [KNL]
> > >                 on      Mark read-only kernel memory as read-only (default).
> > >                 off     Leave read-only kernel memory writable for debugging.
> > > 
> > > Hopefully this is an object lesson in why you need to update the
> > > documentation when you extend a feature.
> > > 
> > > > since "full" gets parsed as 'f' = FALSE, when previously that would have been
> > > > rejected. So anyone passing "rodata=full" on the command line will have rodata
> > > > disabled, which is not what they wanted.
> > > > 
> > > > The current state of things is a bit messy (we prase the option twice because
> > > > arch code needs it early), and we can probably fix that with some refactoring,
> > > > but I do wonder if we actually want to open up the sysfs parsing to accept
> > > > anything *beginning* with [tTfF] rather than the full "true" and "false"
> > > > strings as previously, or whether it's worth reverting this for now in case
> > > > anything else is affected.
> > > 
> > > Well, that's going to break people who've started using the new option.
> > > As a quick fix, how about only allowing either "f\0" or "fa"?
> > 
> > I think we need to be more strict in kstrtobool(), i.e. 'f\0' ('t\0') and 'fal'
> > ('tru') perhaps?
> 
> Actually kstrtobool() has been designed as a generic parser that should have
> lowest priority. It means that the code that uses it should take care of any
> other custom cases _before_ calling for kstrtobool().

Makes sense.

Jagdish, could you please send a patch fixing the "rodata" early_param
in arch/arm64/mm/mmu.c?

Please, also add:

Cc: stable@vger.kernel.org # v5.19+

Best Regards,
Petr
