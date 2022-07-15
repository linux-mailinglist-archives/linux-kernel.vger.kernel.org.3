Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF55575E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiGOJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiGOJP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:15:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC25B7AD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:14:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B1FA333AF3;
        Fri, 15 Jul 2022 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657876454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H11xd9RiwcHM8/pUTz7ymtF6A03GOByxCIR1ZLzFjSs=;
        b=nJYDbJFtZ/G68D5T1IS0mEbrBeduiWgwYOP9o2jjcy4ki1lEpfbg1cbb/pfF7VRc9/gAkr
        WkOymkTR7mtkBgJXsyb2fQvTOnAg8Gm/P+eFLcbrUh1f09rZ57pWmcfPBMI21TZbfCpsa3
        XxAoGbhRvRrI0WKQyu4NFQwK1naOiBc=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 639A92C141;
        Fri, 15 Jul 2022 09:14:14 +0000 (UTC)
Date:   Fri, 15 Jul 2022 11:14:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH v3] printk: do not wait for consoles when suspended
Message-ID: <20220715091413.GC24338@pathway.suse.cz>
References: <20220715061042.373640-1-john.ogness@linutronix.de>
 <20220715061042.373640-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715061042.373640-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-07-15 08:16:42, John Ogness wrote:
> The console_stop() and console_start() functions call pr_flush().
> When suspending, these functions are called by the serial subsystem
> while the serial port is suspended. In this scenario, if there are
> any pending messages, a call to pr_flush() will always result in a
> timeout because the serial port cannot make forward progress. This
> causes longer suspend and resume times.
> 
> Add a check in pr_flush() so that it will immediately timeout if
> the consoles are suspended.
> 
> Fixes: 3b604ca81202 ("printk: add pr_flush()")
> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>

The patch is committed in printk/linux.git, branch rework/kthreads.

I think about creating pull request for 5.19 later today or tomorrow
so that it is in the last rc.

Best Regards,
Petr
