Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4225478C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhLQNg6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 08:36:58 -0500
Received: from pout.email.it ([77.93.251.230]:47444 "EHLO pout.email.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhLQNg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:36:57 -0500
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 08:36:57 EST
Received: from localhost (localhost [127.0.0.1])
        by pout.email.it (Postfix) with ESMTP id A1680A54BE;
        Fri, 17 Dec 2021 14:31:19 +0100 (CET)
Received: from pout.email.it ([127.0.0.1])
        by localhost (ir-mtaout02.email.it [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id om7RZFOX3haw; Fri, 17 Dec 2021 14:31:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by pout.email.it (Postfix) with ESMTP id 09633A54BF;
        Fri, 17 Dec 2021 14:31:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at ir-mtaout02.email.it
Received: from pout.email.it ([127.0.0.1])
        by localhost (ir-mtaout02.email.it [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RHvUWAiN1GIS; Fri, 17 Dec 2021 14:31:14 +0100 (CET)
Received: from ir-zstore42.email.it (unknown [192.168.25.42])
        by pout.email.it (Postfix) with ESMTP id D40E5A54BE;
        Fri, 17 Dec 2021 14:31:13 +0100 (CET)
Date:   Fri, 17 Dec 2021 14:31:13 +0100 (CET)
From:   blinkin@email.it
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>
Message-ID: <1554340286.2521703.1639747873475.JavaMail.zimbra@email.it>
Subject: Re: Bug report for kernel v4.15-rc8+
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [93.146.250.201]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - GC96 (Linux)/8.8.15_GA_4173)
Thread-Index: 0h6WKYAZX0mbI/bojPTMX5RwDzyHlw==
Thread-Topic: Bug report for kernel v4.15-rc8+
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
