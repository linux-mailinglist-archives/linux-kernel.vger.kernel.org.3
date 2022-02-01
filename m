Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F14A62EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbiBARsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241743AbiBARsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:48:37 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E60C06173B;
        Tue,  1 Feb 2022 09:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xJjdKO+w4KNIcTldRLc+m4pi8LsT5xMjo6sZOkgNjrs=; b=YpEeb5rxmcXyef8rWQs/BHg9PF
        GUx11+Ygka7ZBf8LOy5fqVGa6j5NN5f9ISBIzCsMS8KIQFi+hPy+JAud3eP3vcj0AJaFbtXv4hMC+
        N/wy6/p0xFZO3u5U30Ngv6RZQd0UXgGfuCwjmMlwhHU41N/2mqwqmKpn4131pLlO9JQN2WfN4Rxp8
        cceXa/inVYk+9NjnUwdOsYt6fm5nDlHARiU1k4dCWWiMrwwJREg39kJQ5i42VG2JuT+kLw00hEort
        iC7FchAQa+zHsdTWv/iyHfoUQFhPXuCI8fPNhDq/wd04Vwla+7R3V1D1tGioJwVM6uGggzNVb6bnO
        fU+lNEUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56976)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nExGV-0000uP-Oh; Tue, 01 Feb 2022 17:48:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nExGR-0002GH-Mq; Tue, 01 Feb 2022 17:48:23 +0000
Date:   Tue, 1 Feb 2022 17:48:23 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] ARM: sa1100/assabet: move dmabounce hack to ohci driver
Message-ID: <YflyZytGG49kbvV9@shell.armlinux.org.uk>
References: <20220201150339.1028032-1-arnd@kernel.org>
 <90333cef-9ad1-bbf5-5c46-86083c1f5b24@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90333cef-9ad1-bbf5-5c46-86083c1f5b24@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:10:38PM +0000, Robin Murphy wrote:
> On 2022-02-01 15:02, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The sa1111 platform is one of the two remaining users of the old Arm
> > specific "dmabounce" code, which is an earlier implementation of the
> > generic swiotlb.
> > 
> > Linus Walleij submitted a patch that removes dmabounce support from
> > the ixp4xx, and I had a look at the other user, which is the sa1111
> > companion chip.
> > 
> > Looking at how dmabounce is used, I could narrow it down to one driver
> > one one machine:
> > 
> >   - dmabounce is only initialized on assabet and pfs168, but not on
> >     any other sa1100 or pxa platform using sa1111.
> 
> Hmm, my reading of it was different. AFAICS it should affect all platforms
> with CONFIG_ARCH_SA1100 + CONFIG_SA1111 - the bus notifier from
> sa1111_init() will initialise dmabounce for everything where
> sa1111_configure_smc() has punched a hole in the DMA mask to handle the
> addressing erratum. sa1111_needs_bounce() looks to be a further
> consideration for platforms where DMA *additionally* cannot target an entire
> bank of memory at all.

Correct. The SA1111 companion can only access one SDRAM bank, whereas
the SA1110 SoC can address up to four SDRAM banks. On platforms where
there is only one bank of SDRAM, there is no issue. However, on the
Assabet there is one SDRAM bank, and on the Neponset daughter board
with the SA1111, there is a second bank. As explained in the commentry,
the SA1111 can be hardware-configured via resistive jumpers to access
either bank, but we only support the factory-shipped configuration,
which is bank 0 (the lowest addressable bank.)

The SA1111 also has an issue that one of its address lines doesn't
behave correctly, and depending on the SDRAM columns/rows, this
punches multiple holes in the SDRAM address space it can access,
which is what the sa1111_dma_mask[] array is about, and we end up
with every alternate megabyte of physical address space being
inaccessible.

The DMA mask, along with the logic in dmabounce (which truely uses the
DMA mask as, erm, a *mask* rather than the misnamed *limit* that it
has been) know about both of these issues.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
