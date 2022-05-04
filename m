Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C41519712
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 07:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbiEDGAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiEDF75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:59:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE733201BC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 22:56:21 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651643779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4gZIDL4SXYoFWE4y++sOkoisUu5mBEu04VZLJ6Da3k=;
        b=HDzJK9xF0QUViF6InNkFLn1aDJyGLxf1Liu4VNGxtUJ96Gg5nqPfXftf4oXoZoyfl2f+s3
        dNTuEK3ALsewLQpLlDLkBXvCnQ7w25gWB8O3YKRNlv8FHEOO24AZp91Y9sj0RseCHQzKQc
        kS5TX0fGxAaW8MDIdMB4gpSWfJ0fyiwRLd8TaLrsObIyb1UM5bZE4/t3BMWnkp17JoQML5
        jzNwgKN5yb087IFldVhWBeevKWovU1xtMn8xi6zsmYuLaNOVTMz2dH4e32f5Ajdp79ZsV2
        cau41KD3H/krQL0ptv7KsIL5ryHz71yZLf5hl3DG9YJSyY3KvqNHtAGAVXExCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651643779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4gZIDL4SXYoFWE4y++sOkoisUu5mBEu04VZLJ6Da3k=;
        b=f+DoFRCkfWwFo6/8okdZxAJ8tv80c/O3h9qzst54Ax3zeh1bD/qs3SswAVPuwCSAF01nzO
        j2sEd1/ouC01vHBw==
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
In-Reply-To: <601d6979-7462-6f20-0d60-2fcfcf1e405b@samsung.com>
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
 <87y1zkkrjy.fsf@jogness.linutronix.de>
 <601d6979-7462-6f20-0d60-2fcfcf1e405b@samsung.com>
Date:   Wed, 04 May 2022 08:02:18 +0206
Message-ID: <87pmkton7h.fsf@jogness.linutronix.de>
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

On 2022-05-03, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> I suppose if you login via ssh and check /proc/interrupts, then type
>> some things over serial, then check /proc/interrupts again, you will
>> see there have been no interrupts for the uart. But interrupts for
>> other devices are happening. Is this correct?
>
> Right. The counter for ttyAML0 is not increased when lockup happens
> and I type something to the uart console.

Hmmm. This would imply that the interrupts are disabled fo the UART.

Just to be sure that we haven't corrupted something in the driver, if
you make the following change, everything works, right?

--------- BEGIN PATCH ------
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c7973266b176..1eaa323e335c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3578,7 +3578,7 @@ static int __init printk_activate_kthreads(void)
 	struct console *con;
 
 	console_lock();
-	printk_kthreads_available = true;
+	//printk_kthreads_available = true;
 	for_each_console(con)
 		printk_start_kthread(con);
 	console_unlock();
--------- END PATCH ------

The above change will cause the kthreads to not print and instead always
fallback to the direct method.

John
