Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584E056D810
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiGKIcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiGKIcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:32:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F211F2DA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:32:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ADE4C227A0;
        Mon, 11 Jul 2022 08:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657528333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YoBpN1lvaI78X/r2NUb3VKRDnI51NNOYRbZMd29y4RQ=;
        b=fuhsIEI3JBw5P6zU6Qz0+dis0c9M02cRQJpY64Z+7xlikuJkEzDebQvC2UAiclEdXpVFDX
        PQ+uCwaw13j6UPDFbU3yMHkJZpE5gmquCJ7Tnn5ITca0FL0zthyLOu8M7oY3UHsU764+ju
        smrA7K4kfi165Q8p4eFgvZNquUBGoCc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 625A42C171;
        Mon, 11 Jul 2022 08:32:13 +0000 (UTC)
Date:   Mon, 11 Jul 2022 10:32:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: design: was: Re: [RFC PATCH v2] printk: console: Allow each
 console to have its own loglevel
Message-ID: <YsvgDRQICB3nEc1l@alley>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <YshL2M8VdIEONDdc@alley>
 <87o7xz5su4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7xz5su4.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-07-08 21:10:35, John Ogness wrote:
> On 2022-07-08, Petr Mladek <pmladek@suse.com> wrote:
> > The console-specific loglevel might be set by:
> >
> >   + "console=device,options/loglevel" kernel parameter at boot time
> 
> I ask if we avoid the use of "/loglevel" and instead use a generic
> scheme of:
> 
> console=device,option,option,option
> 
> Of course, it would mean that the type of option would need to be
> specified. Something like:
> 
> console=ttyS0,115200n8,loglevel=3

I like this. It is longer but it makes the meaning very obvious.

I just think about using ':' instead of '=' to distinguish
the assignment of outer 'console' vs the inner 'loglevel' parameters.

It seems to be used in some cases, for example, for ca_keys, crashkernel,
drm.edid_firmware, efi_fake_mem. Even earlyprintk uses it for
bus:device.function.

> The reason why I make such a request is because I would like to be able
> to support disabling threading for certain consoles. Something like:
> 
> console=ttyS0,115200n8,nothread
> 
> or when we have atomic consoles that we can specify that they are always
> used with a "sync" option:
> 
> console=ttyS0,115200n8,sync

Good point.

Best Regards,
Petr
