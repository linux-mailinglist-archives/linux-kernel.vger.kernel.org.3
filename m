Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078EE508B44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379828AbiDTO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDTO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:58:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECDF39BA5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:55:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 18444210E4;
        Wed, 20 Apr 2022 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650466526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4r9x2BxAo5T5I81GfmQw8zowai0Cmqkvf3PmY/RrMbg=;
        b=UVa90Ln5oQmyRABzvAqBvZjHR5e6YZ1S7OaQDXWgVLu+8Cq1CcU4lr53d/t4Mhq6tLwnIY
        tBzvPZc26QNo6j7xQZ9KemJojy7bV9YMYIA//62beDCGnrPVXJxZaFOFGwKjLEL1C5FCOL
        fhNw6qrhWk2+Kmv561GLjID/ty6rYV8=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D02CF2C146;
        Wed, 20 Apr 2022 14:55:25 +0000 (UTC)
Date:   Wed, 20 Apr 2022 16:55:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 09/15] printk: refactor and rework printing
 logic
Message-ID: <YmAe3ZHtD2djIasE@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-10-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 01:52:31, John Ogness wrote:
> Refactor/rework printing logic in order to prepare for moving to
> threaded console printing.
> 
> - Move @console_seq into struct console so that the current
>   "position" of each console can be tracked individually.
> 
> - Move @console_dropped into struct console so that the current drop
>   count of each console can be tracked individually.
> 
> - Modify printing logic so that each console independently loads,
>   prepares, and prints its next record.
> 
> - Remove exclusive_console logic. Since console positions are
>   handled independently, replaying past records occurs naturally.
> 
> - Update the comments explaining why preemption is disabled while
>   printing from printk() context.
> 
> With these changes, there is a change in behavior: the console
> replaying the log (formerly exclusive console) will no longer block
> other consoles. New messages appear on the other consoles while the
> newly added console is still replaying.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

It might be because I have already seen this code several times. But
I really like how it splits the monolithic console_unlock().

It might also mean that I have become blind. But I do not see any
problem anymore ;-)

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
