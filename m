Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8254635D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbhK3N4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:56:46 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:52548 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhK3N4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:56:45 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Nov 2021 08:56:45 EST
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4J3NwN2C1QzQjlj;
        Tue, 30 Nov 2021 14:53:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1638280401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=181oU0HPgQagS5rGNx1alC4GUB5Nvu1JRAcuMk+Je3I=;
        b=pLHexAzNxCgIST0bt1VHCUKePxUguTHTrSRk+9wbvMTNTVsFP8xVdsZkMse439DnjlGnOT
        QWlIXhw7uApDzCHq30k+FBxFBCqCqz5G5jg53sKwcy0egJGGidOTBqHQsAlcduRVrHyZmE
        Sc5sOfG3cGx2Dit5YWISHN6T++AwNFZW17Yct54ahI65bD9p13kWHR4D9H0N+nORrh772F
        gjJ1MWJqAL1s41uPblYr4oCrQy+aqwVgLTGBW/aeVVCzrqa8KFWoXcRZ+uteaJDFRAZpb5
        ON1i81dFMXEMbhWg2BtYDxxBhdxQVCYH2va/Ok64lbxi8keUruQspAQADpVYsg==
Date:   Tue, 30 Nov 2021 14:53:18 +0100
From:   "Erhard F." <erhard_f@mailbox.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powermac: Add missing lockdep_register_key()
Message-ID: <20211130145318.5fcdf633@yea>
In-Reply-To: <69e4f55565bb45ebb0843977801b245af0c666fe.1638264741.git.christophe.leroy@csgroup.eu>
References: <69e4f55565bb45ebb0843977801b245af0c666fe.1638264741.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 10:32:42 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
> BUG: key c2d00cbc has not been registered!
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:4801 lockdep_init_map_type+0x4c0/0xb4c
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.5-gentoo-PowerMacG4 #9
> NIP:  c01a9428 LR: c01a9428 CTR: 00000000
> REGS: e1033cf0 TRAP: 0700   Not tainted  (5.15.5-gentoo-PowerMacG4)
> MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24002002  XER: 00000000
> 
> GPR00: c01a9428 e1033db0 c2d1cf20 00000016 00000004 00000001 c01c0630 e1033a73
> GPR08: 00000000 00000000 00000000 e1033db0 24002004 00000000 f8729377 00000003
> GPR16: c1829a9c 00000000 18305357 c1416fc0 c1416f80 c006ac60 c2d00ca8 c1416f00
> GPR24: 00000000 c21586f0 c2160000 00000000 c2d00cbc c2170000 c216e1a0 c2160000
> NIP [c01a9428] lockdep_init_map_type+0x4c0/0xb4c
> LR [c01a9428] lockdep_init_map_type+0x4c0/0xb4c
> Call Trace:
> [e1033db0] [c01a9428] lockdep_init_map_type+0x4c0/0xb4c (unreliable)
> [e1033df0] [c1c177b8] kw_i2c_add+0x334/0x424
> [e1033e20] [c1c18294] pmac_i2c_init+0x9ec/0xa9c
> [e1033e80] [c1c1a790] smp_core99_probe+0xbc/0x35c
> [e1033eb0] [c1c03cb0] kernel_init_freeable+0x190/0x5a4
> [e1033f10] [c000946c] kernel_init+0x28/0x154
> [e1033f30] [c0035148] ret_from_kernel_thread+0x14/0x1c
> 
> Add missing lockdep_register_key()
> 
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/platforms/powermac/low_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
> index f77a59b5c2e1..de34fa34c42d 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -582,6 +582,7 @@ static void __init kw_i2c_add(struct pmac_i2c_host_kw *host,
>  	bus->close = kw_i2c_close;
>  	bus->xfer = kw_i2c_xfer;
>  	mutex_init(&bus->mutex);
> +	lockdep_register_key(&bus->lock_key);
>  	lockdep_set_class(&bus->mutex, &bus->lock_key);
>  	if (controller == busnode)
>  		bus->flags = pmac_i2c_multibus;
> -- 
> 2.33.1
> 

The patch applied on 5.15.5 but unfortunately was not enough to fix the lockdep bug.

Originally was bug #200055 (https://bugzilla.kernel.org/show_bug.cgi?id=200055).

Regards,
Erhard
