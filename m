Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4CD508680
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377827AbiDTLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351910AbiDTLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:02:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37C1C91C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:00:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DC3E21F74E;
        Wed, 20 Apr 2022 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650452407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eers+BWbGc+1iHyvVXcqWTntrGa8/fIk6MV3Gi4a3aA=;
        b=V0bDgUE2UNQ92tNHVJmhOnooRsRtw1Exrf59ACs0jRyUznidnlHJyICFCqBzZXwPHmXSx0
        fMkY62Ojyz1kNR2qRMbSXgsiCOJ0cpNDdOl5b4L1WONp1bdANxpzA53pRRGD/h+3HfO5HU
        ybDJs/10o9JYyJ0WLXl0qm8jWnmewKU=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8A8EC2C141;
        Wed, 20 Apr 2022 11:00:07 +0000 (UTC)
Date:   Wed, 20 Apr 2022 13:00:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Maninder Singh <maninder1.s@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Cc:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "wedsonaf@google.com" <wedsonaf@google.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "void@manifault.com" <void@manifault.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH 1/1] kallsyms: add kallsyms_show_value definition in all
 cases
Message-ID: <Yl/ns04PGU8ahIKJ@alley>
References: <YlaWxh5qYCe40US7@alley>
 <20220413055305.1768223-1-maninder1.s@samsung.com>
 <CGME20220413055318epcas5p3df3cdde54a559d4002a74de9f23289f2@epcms5p5>
 <747830777.1512786.1650256482294@mail-kr5-3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747830777.1512786.1650256482294@mail-kr5-3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-04-18 10:04:42, Maninder Singh wrote:
> > It is really weird that the function is declared in kallsyms.h
> > and implemented in vsprintf.c.
> >
> 
> Yes it does not look good.
> Initially we thought to make it as static inline function in kallsyms.h only.
> But as function is little big and it will increase code size, so we added
> definition in vsprintf.c, because its alwyas compilable code and also it has
> some wrapper APIs for kallsyms.
>  
> But as you suggested to make a new file, it will be good.
> 
> > What about splitting kallsyms.c into two source files where one
> > would be always compiled? It would be usable also for the
> > spring function introduced by
> > https://lore.kernel.org/r/20220323164742.2984281-1-maninder1.s@samsung.com
> > 
> > It might be something like kallsyms_full.c and/or kallsyms_tiny.c.
> >
> 
> This patch is not taken by Luis yet in module-tetsing branch.
> So what will be the best approach to make new version of this patch ?

I am not sure about Luis' plans and if the patch applies on top of
the current module.c split patchset (linux-next).


> A) to make new file kallsyms_tiny.c and add only one definition in that file
> and when above patch of spring functions is merged in next we can move definitions
> to new file
>
> or
> 
> B) we send patch to Luis's branch of module-testing with moving definition(of earlier patch)
> to new file and current patch also.

I wonder how many conflicts it might cause. The patchset splitting
module.c actually does not touch kernel/kallsyms.c.

Anyway, I would probably prepare it on top of linux-next.

Best Regards,
Petr
