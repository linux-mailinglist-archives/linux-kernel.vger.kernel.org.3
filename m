Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95742532643
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiEXJTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiEXJTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:19:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306947892E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:19:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C0A7121979;
        Tue, 24 May 2022 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653383968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJqPgN87UYNRsdNeSSFsjzHet7+5vgEzk9S+L5xumcg=;
        b=tUzJal9KdPkQ2D1bI89IAWjfabnibPussPwISv+c1Np0EMzF/hXlodVqFI/FHKtEftyrYy
        3FhvIxUFBMEFTpjiJFaSpdhkrWTNJjBPvbShUi5FA2/hILoJWOCecoC0wnr9EGPI17xZoc
        GFfyJDWADknjZjU23vvCcEKozuGnUjw=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A256D2C141;
        Tue, 24 May 2022 09:19:28 +0000 (UTC)
Date:   Tue, 24 May 2022 11:19:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoyjIFI0LTvUHGQr@alley>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoVM+KbdyJm8RSSr@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-05-18 20:46:00, Chris Down wrote:
> Greg Kroah-Hartman writes:
> > > +static int printk_sysctl_deprecated(struct ctl_table *table, int write,
> > > +				    void __user *buffer, size_t *lenp,
> > > +				    loff_t *ppos)
> > > +{
> > > +	int res = proc_dointvec(table, write, buffer, lenp, ppos);
> > > +
> > > +	if (write)
> > > +		pr_warn_ratelimited(
> > > +			"printk: The kernel.printk sysctl is deprecated and will be removed soon. Use kernel.force_console_loglevel, kernel.default_message_loglevel, kernel.minimum_console_loglevel, or kernel.default_console_loglevel instead.\n"
> > 
> > Please define "soon".
> 
> Petr, what do you think about the timebounds here? :-)

Good question. Honestly, I do not have experience with deprecating
such interfaces. Any advice would be helpful.

We might investigate the kernel log whether and how some sysctl
interface was deprecated.

I would personally keep the interface between 10-20 kernel
releases.

Best Regards,
Petr

PS: I still have to look deeper at the patchset. It might take
    some more days. It seems that nature is not the only one who
    woke up after the winter.
