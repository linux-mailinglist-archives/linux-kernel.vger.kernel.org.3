Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF904508840
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378584AbiDTMhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiDTMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:37:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B24CD2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:34:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE45C1F380;
        Wed, 20 Apr 2022 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650458091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/mzIHtYOca9ivGkXcLop9wA8toChfAbWT0m3l15a+g=;
        b=oC95MYYeoJbR9hKkj1VOb6aRZEanirfw5PTlbkD2ZXT+ouF1Aq3tf99fIKuLdgJfgkw3Re
        7h+n0F2VHsTaB+6cSfXPP9dEVn7b7b/uKUyR155YRZXeLRhmRmFzN2Uz0nJl4smBOyybj3
        LLp0kivQwr39ID2FqLidTgRJEfBrq2w=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA9A62C145;
        Wed, 20 Apr 2022 12:34:51 +0000 (UTC)
Date:   Wed, 20 Apr 2022 14:34:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 03/15] printk: add missing memory barrier to
 wake_up_klogd()
Message-ID: <Yl/9iDqRL3zKBoSJ@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 01:52:25, John Ogness wrote:
> It is important that any new records are visible to preparing
> waiters before the waker checks if the wait queue is empty.
> Otherwise it is possible that:
> 
> - there are new records available
> - the waker sees an empty wait queue and does not wake
> - the preparing waiter sees no new records and begins to wait
> 
> This is exactly the problem that the function description of
> waitqueue_active() warns about.
> 
> Use wq_has_sleeper() instead of waitqueue_active() because it
> includes the necessary full memory barrier.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Great catch! Looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
