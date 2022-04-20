Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF935089D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379227AbiDTN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353518AbiDTN6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:58:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3379017A92
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:55:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F6631F380;
        Wed, 20 Apr 2022 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650462923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x3dx+LHNno/HPbY+9YOb7yhthLTHe9r2ka6DGaSdvkE=;
        b=n9B8OQSsVDkUF7HNENIYWbDlBKWfxV9YnfA5lH3yfCNhmBZJMj7tj6Pkh4M3o8jWrrtXEE
        kv7ewxr+HE9FaHVEQtivRaTVf5hD30mXE0hcsKgFECsqS/2mrVvPYZo/3RjZCMlQ+bOkNB
        ECwR30eF7dqehWLoXz0myLVQeeHJFjk=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C8A662C141;
        Wed, 20 Apr 2022 13:55:22 +0000 (UTC)
Date:   Wed, 20 Apr 2022 15:55:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 05/15] printk: wake waiters for safe and NMI
 contexts
Message-ID: <YmAQyvPEwy5XaKWl@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 01:52:27, John Ogness wrote:
> When printk() is called from safe or NMI contexts, it will directly
> store the record (vprintk_store()) and then defer the console output.
> However, defer_console_output() only causes console printing and does
> not wake any waiters of new records.
> 
> Wake waiters from defer_console_output() so that they also are aware
> of the new records from safe and NMI contexts.
> 
> Fixes: 03fc7f9c99c1 ("printk/nmi: Prevent deadlock when accessing the main log buffer in NMI")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Another great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
