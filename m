Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB34F50F389
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbiDZIWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiDZIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:22:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B485237A8F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:19:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 174C91F388;
        Tue, 26 Apr 2022 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650961146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9ZKx+QwxCV2Wyjtpdmiy09b07N6ci4kM9MrK4D0Vzs=;
        b=J+XBJ2csTos0HHJsLDVb8XpaD5FNaiL1JE3Q9ttiUUmc5qvNs33gZXOpcqmR8ldzoHO3KB
        EmvV5tkg7w1tlidwxyfNk4CsyVTg+2IyUb44M7f6IjZN8YWQCaIO9M65EMK1zedauSf0I4
        zyWM8U4yvlN8G60RCq7oNd5gAlMA94U=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 99DFC2C143;
        Tue, 26 Apr 2022 08:19:05 +0000 (UTC)
Date:   Tue, 26 Apr 2022 10:19:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        patches@amperecomputing.com, zwang@amperecomputing.com,
        darren@os.amperecomputing.com, pasha.tatashin@soleen.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Adam Li <adam.li@amperecomputing.com>
Subject: Re: [PATCH v2] arm64: kexec: flush log to console in NMI context
Message-ID: <Ymeq9uD5Sz9iwW8H@alley>
References: <20220424151952.183208-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424151952.183208-1-shijie@os.amperecomputing.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-04-24 15:19:52, Huang Shijie wrote:
> If kdump is configured, nmi_panic() may run to machine_kexec().
> 
> In NMI context, the defer_console_output() defers the console
> output by using wake_up_klogd to flush the printk ringbuffer
> to console.
> 
> But in the machine_kexec, the system will reset, and there is
> no chance for the wake_up_klogd to do its job. So we can _not_
> see any log on the console since the nmi_panic
> (nmi_panic() will disable the irq).
>
> This patch fixes this issue by using console_flush_on_panic()
> to flush to console.
> 
> After this patch, we can see all the log since the nmi_panic
> in the panic console.

This is not a good idea. The crashdump is the best source of
information about the crashed system. It includes the complete
log.

The system is in unknown state during panic(). Any operation
might break. Flushing consoles increases the risk that
the crashdump will not get generated. The crashdump is more
important. If the crashdump succeeds than the consoles are
not needed.

Note that printk() does not handle consoles in NMI because it might
cause deadlock. console_flush_on_panic() tries to avoid deadlock
caused by console_sem. Also the particular console drivers are
more careful because oops_in_progress is set at this stage.
But there is still a risk of the deadlock. There might be another
locks that are do not check oops_in_progress. Also a potential
double unlock might cause deadlock.

IMHO, the main motivation for this patch was to flush the per-CPU
printk buffers (v1). But it is not longer needed. The buffers
were removed in 5.15-rc1, see the commit 93d102f094be9beab28e
("printk: remove safe buffers").

The only reason to call console drivers when crashdump is generated
is to debug the kexec code path. But I am not sure if
console_flush_on_panic() would help here. The kexec might fail
anytime before or after this flush so that the important
messages will not be visible anyway. John Ogness is going
to add atomic serial console that might be better for this
use case.

Best Regards,
Petr
