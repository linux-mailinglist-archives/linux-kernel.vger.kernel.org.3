Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28AA579FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiGSNrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiGSNrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:47:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085243E5F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:00:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C180235176;
        Tue, 19 Jul 2022 13:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658235656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDMSEZAHF3OcaIQOo45rhG/KwG5Za+30FTUI4M4qetc=;
        b=O7f3wtjAq62zIFs3du8GibUs+Jp3LEwHn6l8j7rPaASXzgoosiwNeTs3C80vufjBvNINSE
        /vADMqBHetBZdsFYXMLY8DZhjSlK343v04fIe45HItc5Kat0kuOJI8kUk2f1wO6Nz5stzX
        e7TrKgi+CkJwTj3PCVA52HofRWTzSz8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 69AAB2C141;
        Tue, 19 Jul 2022 13:00:56 +0000 (UTC)
Date:   Tue, 19 Jul 2022 15:00:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: design: was: Re: [RFC PATCH v2] printk: console: Allow each
 console to have its own loglevel
Message-ID: <YtarBVizQ0ImCKeP@alley>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <YshL2M8VdIEONDdc@alley>
 <Ys7bb8+/G0iMWfzb@chrisdown.name>
 <20220714154452.GB24338@pathway.suse.cz>
 <20220715124935.GE2737@pathway.suse.cz>
 <YtFk/3XA8dsaTu/c@chrisdown.name>
 <Ytafbe6jGQ9sW7HG@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytafbe6jGQ9sW7HG@chrisdown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-07-19 13:11:25, Chris Down wrote:
> Chris Down writes:
> > Ok, I will incorporate the EINVAL return for sysctl in a separate patch
> > first, and then add the new sysfs one to the existing changes for v3.
> > :-)
> 
> Thinking more about this, I will probably not change the existing
> kernel.printk semantics to return EINVAL, since it could silently(ish) cause
> regressions for existing misconfigured systems on boot. I'll just add the
> clamps to the new controls.

I guess that you are talking about the obsoleted sysctl
'kernel.printk' that has 4 values. And about syslog
behavior. I agree that changing he behavior might be risky.

But I think that we should return EINVAL in the newly added
interface. IMHO, people should know when the entered value
can't be used instead of silently changing it.

When talking about the new interface. I would either do not create
/proc/sys/kernel/minimum_console_loglevel or I would make it read
only. IMHO, this value was supposed to be a built in value and
was exported without much thinking. I guess that only few people know
what it really does and it is better to hide it.

Best Regards,
Petr
