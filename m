Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553A15462EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348057AbiFJJ6y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Jun 2022 05:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347393AbiFJJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:58:51 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 02:58:47 PDT
Received: from pout.email.it (pout.email.it [77.93.251.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CAB040C;
        Fri, 10 Jun 2022 02:58:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pout.email.it (Postfix) with ESMTP id 4A930CBD01;
        Fri, 10 Jun 2022 11:52:07 +0200 (CEST)
Received: from pout.email.it ([127.0.0.1])
        by localhost (ir-mtaout02.email.it [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id a-vjGxilERSg; Fri, 10 Jun 2022 11:52:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by pout.email.it (Postfix) with ESMTP id F2B8ECE1CF;
        Fri, 10 Jun 2022 11:52:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at ir-mtaout02.email.it
Received: from pout.email.it ([127.0.0.1])
        by localhost (ir-mtaout02.email.it [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NW5ds1gH4l21; Fri, 10 Jun 2022 11:52:06 +0200 (CEST)
Received: from ir-zstore42.email.it (unknown [192.168.25.42])
        by pout.email.it (Postfix) with ESMTP id DB257CBD01;
        Fri, 10 Jun 2022 11:52:05 +0200 (CEST)
Date:   Fri, 10 Jun 2022 11:52:05 +0200 (CEST)
From:   blinkin@email.it
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>
Message-ID: <1131544892.7359423.1654854725508.JavaMail.zimbra@email.it>
Subject: Re: Bug report for kernel v4.15-rc8+
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [93.146.250.201]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - GC102 (Linux)/8.8.15_GA_4257)
Thread-Index: 3jCrU3LIC1isKA2ySsKGyjGyPR+46g==
Thread-Topic: Bug report for kernel v4.15-rc8+
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello, any news on this?

----- Messaggio originale -----
Da: "Thomas Gleixner" <tglx@linutronix.de>
A: blinkin@email.it
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>, linux-acpi@vger.kernel.org
Inviato: Mercoledì, 11 agosto 2021 16:20:41
Oggetto: Re: Bug report for kernel v4.15-rc8+

On Wed, Aug 11 2021 at 15:51, blinkin@email.it wrote:
> 1) You're booting with an out of tree module
>
>   Uninstalled virtualbox, reproduced same behavior without the module.
>   dmesg outputs attached with and without the workaround
>   (dmesg_novboxdrv_clean.txt and dmesg_novboxdrv_irqaffinity0.txt)

Ok.

> 2) Please provide information what is consuming 90% of a CPU
>
>   top shows a kworker process consistently at 50% without the
>   workaround, 60% with the workaround. No significant activity amounts
>   from other processes.  Sometimes that 50% is split between two
>   kworker processes for a short time.  CPU core #0 activity is a
>   constant 60% without the workaround, 90% with the workaround

That's broken. /proc/interrupts gives some hint:

1) Stock kernel

>             CPU0       CPU1       CPU2       CPU3       
>    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
>    1:          0          0          0          9  IR-IO-APIC    1-edge      i8042
>    8:          0          1          0          0  IR-IO-APIC    8-edge      rtc0
>    9:          0     923411          0          0  IR-IO-APIC    9-fasteoi   acpi

900k ACPI interrupts right after boot

>             CPU0       CPU1       CPU2       CPU3       
>    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
>    1:          0          0          0         11  IR-IO-APIC    1-edge      i8042
>    8:          0          1          0          0  IR-IO-APIC    8-edge      rtc0
>    9:          0    4869059          0          0  IR-IO-APIC    9-fasteoi   acpi

One minute later it's 4.8M

With affinity forced to CPU0 it's even more:

>             CPU0       CPU1       CPU2       CPU3       
>    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
>    1:          9          0          0          0  IR-IO-APIC    1-edge      i8042
>    8:          1          0          0          0  IR-IO-APIC    8-edge      rtc0
>    9:    7576456          0          0          0  IR-IO-APIC    9-fasteoi   acpi

7.5M right after boot

>             CPU0       CPU1       CPU2       CPU3       
>    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
>    1:         11          0          0          0  IR-IO-APIC    1-edge      i8042
>    8:          1          0          0          0  IR-IO-APIC    8-edge      rtc0
>    9:   10992420          0          0          0  IR-IO-APIC    9-fasteoi   acpi

10.9M after one minute. Though the delta between right after boot and 1
minute later is in the same ballpark.

Cc'ed the ACPI people for clues.

Thanks,

        tglx
