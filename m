Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261264CA4F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbiCBMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiCBMkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:40:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDE16F4BF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:39:19 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7AF221F3A3;
        Wed,  2 Mar 2022 12:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646224758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMtu6VReqrtpDz6U1WbvY9HdGd5cuV9g37CNc4FCC0Y=;
        b=FZdgTQSRvkSTE/P0Kkk4tJFWi0nOh3p2hS3JtbqFam/VrILz1vafoSmQdCQq5DU3diiYLY
        umLBwDx1Rxxs3RauYh2PQkvYzf4lzRbQlmxx6Yh0oBRXCk4YLWOlnnsS3kTo89obzEGHGF
        8sAlUPsktMv9ZhgAK2pk5j6s3z/BLkc=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 461C2A3B85;
        Wed,  2 Mar 2022 12:39:17 +0000 (UTC)
Date:   Wed, 2 Mar 2022 13:39:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     Joe Perches <joe@perches.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>
Subject: Re: [PATCH v4] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
Message-ID: <Yh9ldXlLYz5/vyuf@alley>
References: <036f47fa1f929813cc2c7672654c7be9329b1fd9.camel@perches.com>
 <20220228073708.1610603-1-maninder1.s@samsung.com>
 <CGME20220228073715epcas5p1b3166e6b673d3c8b610f7e2f5745562b@epcms5p7>
 <20220302043259epcms5p7b3b3c30e8547784f7cec4320fb171536@epcms5p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302043259epcms5p7b3b3c30e8547784f7cec4320fb171536@epcms5p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 10:02:59, Maninder Singh wrote:
> Hi,
> 
> > On Mon, 2022-02-28 at 13:07 +0530, Maninder Singh wrote:
> > > with commit 98e35f5894cf ("printk: git rid of [sched_delayed] message for
> > > printk_deferred") printk_deferred and printk_deferred_once requires
> > > LOGLEVEL in argument, but checkpatch.pl was not fixed and still reports
> > > it as warning:
> > > 
> > > WARNING: Possible unnecessary KERN_ALERT
> > > printk_deferred(KERN_ALERT "checking deferred\n");
> >  
> > I don't care for this patch at all.
> 
> But still it needs to be fixed, either with current suggested patch or with something else.
>  
> > I think it's be better to modify vprintk_emit when LOGLEVEL_SCHED
> > is used and if a KERN_<LEVEL> exists in the format, use it.
> > Perhaps instead:
> > ---
> >  kernel/printk/printk.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >  
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 1ce242f34d2be..6b5baf14f6d56 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2247,7 +2247,13 @@ asmlinkage int vprintk_emit(int facility, int level,
> >                  return 0;
> >  
> >          if (level == LOGLEVEL_SCHED) {
> > -                level = LOGLEVEL_DEFAULT;
> > +                level = printk_get_level(fmt);
> > +                if (level) {
> > +                        level -= '0';
> > +                        fmt = printk_skip_level(fmt);
> > +                } else {
> > +                        level = LOGLEVEL_DEFAULT;
> > +                }
> >                  in_sched = true;
> >          }
>  
> And I think it is already handled for printk (facility = 0).

Yes, this is not needed. The log level will be updated by parsing
"fmt" even LOGLEVEL_SCHED was used. It is well described by Maninder
below.


> after setting level to KERN_DEFAULT at first for in_sched case to make it normal
> printk case as it is changed from vprintk_store as per the string in printk based on
> current default loglevel.
> 
> int vprintk_store(int facility, int level,
>                   const struct dev_printk_info *dev_info,
>                   const char *fmt, va_list args)
> {
> ...
>         /* Extract log level or control flags. */
>         if (facility == 0)
>                 printk_parse_prefix(&prefix_buf[0], &level, &flags);
> ..
> 
> So, for printk, printk_deferred, printk_deferred_once, its level is picked if its provided.
> thus level in printk_deferred is "not unnecessary".
> And checkpatch.pl should not give w WARNING for this.

Alternative solution would be to introduce pr_<level>_deferred()
wrappers. But there is a pushback against it. printk_deferred()
is a whack-a-mole approach. There is a chance that it will get
obsoleted by the offload to kthreads, see
https://lore.kernel.org/r/20220207194323.273637-1-john.ogness@linutronix.de

Best Regards,
Petr
