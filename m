Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7684A9866
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358401AbiBDL3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358367AbiBDL3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:29:24 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10666C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 03:29:24 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nFwmH-0002l2-Pj; Fri, 04 Feb 2022 12:29:21 +0100
Message-ID: <ed18f247-1ac4-5467-d876-e5b92e89f1de@leemhuis.info>
Date:   Fri, 4 Feb 2022 12:29:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [tip: irq/urgent] PCI/MSI: Remove bogus warning in
 pci_irq_get_affinity()
Content-Language: en-BS
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <87ee4n38sm.ffs@tglx>
 <164396506527.16921.1990922190197899743.tip-bot2@tip-bot2>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <164396506527.16921.1990922190197899743.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1643974164;6d3001aa;
X-HE-SMSGID: 1nFwmH-0002l2-Pj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[stripped the CC list to avoid spamming people, we all get enough mail]

Thx for fixing the regression. Sadly the fix didn't link to all places
where the issue was reported using "Link:" tags, as explained by both
Documentation/process/submitting-patches.rst and
Documentation/process/5.Posting.rst

Please consider placing them in the future, at least one tool is relying
on the presence of such links: my regression tracking bot 'regzbot',
which using them to automatically detect patch posting and commits
fixing tracked regressions -- which makes my my life as the Linux
kernel's regression tracker a lot easier, as otherwise I have to tell
regzbot about fixes manually:

#regzbot fixed-by: dd7f5a11ac5a6f733f422dc22b

tia!

Ciao, Thorsten

On 04.02.22 09:57, tip-bot2 for Thomas Gleixner wrote:
> The following commit has been merged into the irq/urgent branch of tip:
> 
> Commit-ID:     dd7f5a11ac5a6f733f422dc22b4d145d3260304e
> Gitweb:        https://git.kernel.org/tip/dd7f5a11ac5a6f733f422dc22b4d145d3260304e
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Mon, 31 Jan 2022 22:02:46 +01:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Fri, 04 Feb 2022 09:54:20 +01:00
> 
> PCI/MSI: Remove bogus warning in pci_irq_get_affinity()
> 
> The recent overhaul of pci_irq_get_affinity() introduced a regression when
> pci_irq_get_affinity() is called for an MSI-X interrupt which was not
> allocated with affinity descriptor information.
> 
> The original code just returned a NULL pointer in that case, but the rework
> added a WARN_ON() under the assumption that the corresponding WARN_ON() in
> the MSI case can be applied to MSI-X as well.
> 
> In fact the MSI warning in the original code does not make sense either
> because it's legitimate to invoke pci_irq_get_affinity() for a MSI
> interrupt which was not allocated with affinity descriptor information.
> 
> Remove it and just return NULL as the original code did.
> 
> Fixes: f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/87ee4n38sm.ffs@tglx
> 
> ---
>  drivers/pci/msi/msi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index c19c7ca..9037a78 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1111,7 +1111,8 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>  	if (!desc)
>  		return cpu_possible_mask;
>  
> -	if (WARN_ON_ONCE(!desc->affinity))
> +	/* MSI[X] interrupts can be allocated without affinity descriptor */
> +	if (!desc->affinity)
>  		return NULL;
>  
>  	/*

