Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D178F4BCF3D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbiBTPE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:04:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbiBTPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:04:56 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68431DC8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1adgmye6FZ2zQFuk/q4+n4x9dXXIaAhx2pGahFGCNHg=; b=LfcR975FHg0DlzDVRLyShx+0dS
        Oj72AFCCf+IlswF4U2Yk4tT5hFQejNQRd6NB0t+Q43H9W9slRb5PNnXubJkGmz8QRmYXat0hBoH2e
        zzCs82kcVQ/ECE0OBcZogpw/Zu3YSTNobVAPmiCr2/LKK0K5nqoY3/WcfG4Hy0eT0TzsD2TSMj+W3
        W06LVicDbP2c2/VIaOwyMszpk5ilaaVdy+w29isivK1/qVbpc9fFtLpISFp5IX++ZRoGOE8VF3/v6
        +NYEO9cBHnMkQSHRbAJdvi1SZedFdPG4lAM06AwRiBoxV1i/QHyDNGUu3fKCpzXWZc1DbpKGdeo9b
        e6IxeWcg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57378)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nLnl8-0007lp-Oq; Sun, 20 Feb 2022 15:04:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nLnl4-0006RE-HH; Sun, 20 Feb 2022 15:04:18 +0000
Date:   Sun, 20 Feb 2022 15:04:18 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Barry Song <21cnbao@gmail.com>
Cc:     maz@kernel.org, tglx@linutronix.de, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com, Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to
 smp before issuing ipi
Message-ID: <YhJYct7aW0kGXNXp@shell.armlinux.org.uk>
References: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 05:55:49AM +0800, Barry Song wrote:
> dsb(ishst) should be enough here as we only need to guarantee the
> visibility of data to other CPUs in smp inner domain before we
> send the ipi.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 5e935d97207d..0efe1a9a9f3b 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
>  	 * Ensure that stores to Normal memory are visible to the
>  	 * other CPUs before issuing the IPI.
>  	 */
> -	wmb();
> +	dsb(ishst);

On ARM, wmb() is a dsb(st) followed by other operations which may
include a sync operation at the L2 cache, and SoC specific barriers
for the bus. Hopefully, nothing will break if the sledge hammer is
replaced by the tack hammer.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
