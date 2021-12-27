Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF147FB56
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhL0Jab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhL0Ja3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:30:29 -0500
X-Greylist: delayed 1437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Dec 2021 01:30:29 PST
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84b6::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A605C06173E;
        Mon, 27 Dec 2021 01:30:29 -0800 (PST)
Received: from p54bc6060.dip0.t-ipconnect.de ([84.188.96.96] helo=[192.168.1.135]); authenticated
        by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n1lxc-0003Ep-Vr; Mon, 27 Dec 2021 10:06:29 +0100
Message-ID: <90a3ce57-875f-d34a-0714-f815acae12d4@birger-koblitz.de>
Date:   Mon, 27 Dec 2021 10:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v2 0/5] Rework realtek-rtl IRQ driver
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>,
        linux-kernel@vger.kernel.org
References: <cover.1640548009.git.sander@svanheule.net>
From:   Birger Koblitz <mail@birger-koblitz.de>
In-Reply-To: <cover.1640548009.git.sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1640597429;2c978a16;
X-HE-SMSGID: 1n1lxc-0003Ep-Vr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't think the IRQ routing has an off-by one error. This was chosen
by John to correspond to Realtek's own "documentation" and to
take account of the special meaning of IRQs 0, 1 for VSMP and 6 and 7
for the Realtek SoCs. In any case it would break the ABI as the meaning
of these values changes and I don't think the change in range actually
gives any additional functionality.

With regards to the RTL8390, that SoC actually has two IRQ controllers
to allow VSMP. The changes in parent routing have a good chance of breaking
VSMP on the RTL8390 targets. Did you stress test this new logic under VSMP?

Cheers,
   Birger


On 26/12/2021 20:59, Sander Vanheule wrote:
> After seeing some use, and with more devices tested, the current
> implementation for the Realtek SoC interrupt controller was found to
> contain a few flaws.
> 
> The driver requires the following fixes:
> - irq_domain_ops::map should map the virq, not the hwirq (patch 1)
> - routing has an off-by-one error. Routing values (1..6) correspond to
>    MIPS CAUSEF(2..7) (patch 2)
> 
> The following improvements should also be made:
> - Use N real cascaded interrupts with an interrupt-specific mask of
>    child irq lines. Otherwise a high-priority interrupt may cause a
>    low-priority interrupt to be handled first. (patch 3)
> - Get rid of assumed routing to parent interrupts of the original
>    implementation (patch 4, 5)
> 
> Changes since v1:
> Link: https://lore.kernel.org/all/cover.1640261161.git.sander@svanheule.net/
> 
> Still an RFC. Mainly since I don't like the open coding in the last
> patch, but also since I still have a question about the chained IRQ
> handlers.
> 
> - Split some of the changes to limit the patch scope to one issue.
> - Dropped some small (spurious or unneeded) changes
> - Instead of dropping/replacing interrupt-map, the last patches now
>    provide an implementation that amends the current situtation.
> 
> Sander Vanheule (5):
>    irqchip/realtek-rtl: map control data to virq
>    irqchip/realtek-rtl: fix off-by-one in routing
>    irqchip/realtek-rtl: use per-parent irq handling
>    dt-bindings: interrupt-controller: realtek,rtl-intc: map output lines
>    irqchip/realtek-rtl: add explicit output routing
> 
>   .../realtek,rtl-intc.yaml                     |  38 ++-
>   drivers/irqchip/irq-realtek-rtl.c             | 232 ++++++++++++++----
>   2 files changed, 218 insertions(+), 52 deletions(-)
> 
