Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C044351700F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385189AbiEBNPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351348AbiEBNPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:15:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55075D69
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:11:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651497090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ggFgY/zK0y72ZUtp6KigXGll6Hp+UovEpSfnz2w+970=;
        b=vTF3+lOygvZywEc8UOCDeFCHievf/zlP6DE4bG/HypfnZQOxRZeWw0g2pq1ihKyBjafuS2
        5oVT4DtRYCHZargZ6EV/gP3DlCe9gjfV927uV+GZdruxjLImz+bPFQj6dfogkUBSeN8Q8c
        HIBRSY7rtXFYGUXRMN90xPvCw9L2m/wUyBbDvSUiWgL2NnhDIgNzbXaYV07+2vExx+SYTg
        wNyHvxHeSXjc4tpCEghafuSQlIAJkk7Z8scRZrIC6/nuf98VRHkRTD/SjFB57F3rkAunJ1
        pEER6DYEYZrU5hxZbR0qW+HcS3f3SKamkAz+6hnK88QpWLp+KanTIMtxnQivRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651497090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ggFgY/zK0y72ZUtp6KigXGll6Hp+UovEpSfnz2w+970=;
        b=3T6JKye25mxbWo8WRxifuqeA96PeYYZMI/3rW+b2iio0VVDVwarm0EcC24fy0Vn6+xcGXD
        esJc+78qanVrKEBQ==
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
In-Reply-To: <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
 <878rrs6ft7.fsf@jogness.linutronix.de> <Ymfgis0EAw0Oxoa5@alley>
 <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
Date:   Mon, 02 May 2022 15:17:29 +0206
Message-ID: <87y1zkkrjy.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-02, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Data written to /dev/kmsg and all kernel logs were always displayed
> correctly. Also data written directly to /dev/ttyAML0 is displayed
> properly on the console. The latter doesn't however trigger the input
> related activity.
>
> It looks that the data read from the uart is delivered only if other
> activity happens on the kernel console. If I type 'reboot' and press
> enter, nothing happens immediately. If I type 'date >/dev/ttyAML0' via
> ssh then, I only see the date printed on the console. However if I
> type 'date >/dev/kmsg', the the date is printed and reboot happens.

I suppose if you login via ssh and check /proc/interrupts, then type
some things over serial, then check /proc/interrupts again, you will see
there have been no interrupts for the uart. But interrupts for other
devices are happening. Is this correct?

> For comparison, here is a 't' sysrq result from the 'working' serial
> console (next-20220429), which happens usually 1 of 4 boots:
>
> https://pastebin.com/mp8zGFbW

This still looks odd to me. We should be seeing a trace originating from
ret_from_fork+0x10/0x20 and kthread+0x118/0x11c.

I wonder if the early creation of the thread is somehow causing
problems. Could you try the following patch to see if it makes a
difference? I would also like to see the sysrq-t output with this patch
applied:

---------------- BEGIN PATCH ---------------
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2311a0ad584a..c4362d25de22 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3837,7 +3837,7 @@ static int __init printk_activate_kthreads(void)
 
 	return 0;
 }
-early_initcall(printk_activate_kthreads);
+late_initcall(printk_activate_kthreads);
 
 #if defined CONFIG_PRINTK
 /* If @con is specified, only wait for that console. Otherwise wait for all. */
---------------- END PATCH ---------------

Thanks for your help with this!

John
