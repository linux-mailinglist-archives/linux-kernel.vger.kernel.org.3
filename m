Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83EC4C1AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbiBWScl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbiBWSc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13733CE0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:31:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 442D3B8216A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73904C340E7;
        Wed, 23 Feb 2022 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645641111;
        bh=57Os8rZQTBt/21dIEa4Unw4EhiZmeQp+Mh1wUSN8JA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqWEARh4IRX3NEirZczSLGUC6ADpUb/7QGzrp7s13L8UCDvK7SEe2cZ1He/ZxPGbg
         rR6IK38kVZm7+uL9Y5v1IyHxh/xp/VC9K8oRiVOjcI+Xv4ObiQ4qRqLbWckV7oVU6b
         5kuaTkNlfSgBk5OauYdGIJe52Z5UP2OUcgBw4S8s=
Date:   Wed, 23 Feb 2022 19:31:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH printk v1 13/13] console: introduce CON_MIGHT_SLEEP for vt
Message-ID: <YhZ9lHQjq7urH120@kroah.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-14-john.ogness@linutronix.de>
 <YhY4s1WH5Rfjn+mn@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhY4s1WH5Rfjn+mn@alley>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 02:37:55PM +0100, Petr Mladek wrote:
> On Mon 2022-02-07 20:49:23, John Ogness wrote:
> > Deadlocks and the framebuffer console have been a recurring issue
> > that is getting worse. Daniel Vetter suggested [0] that
> > fbcon->write() should no longer be called from an atomic context.
> 
> We should make it clear that people will not longer see kernel
> messages on ttyX during early boot, panic, and in some other
> situations when printk kthreads are not available.
> 
> Or do I miss something?
> 
> Do we really want this?
> 
> Do the tty maintainers really want to give up on supporting
> modes when processes/kthreads do not work?

I would love that, but:

> Maybe, it is inevitable. Maybe, people are not using tty
> for debugging too much.

People are using tty consoles for debugging all the time.  We can not
break that.

thanks,

greg k-h
