Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BC647BDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhLUJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhLUJ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:56:25 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96886C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S0BQZTMwuXJKwBE41rMQETrlaUpB9DgVGX/MSnAdwYs=; b=O5whduXDU1UKYQY5xzxMYmecMJ
        I0K9o0WXX46mn0IZwQZXTMPToILfrxG6OoYSeZtgfyi57q1RmLdB0qQCgX8Ivbiv515gv0eE6B26Z
        5AGAuCUS7TPkveh40UuLV5m74Eq8dAsVdi5rlLddpLibBhbD59DWnOzyZW2W+4IvKbbsQvdy1Wqva
        Y7vbASn/aif+EUX/aZnA5dY6KPREtytRJ1jViGGqpG0zkt3mAzpIwdNZe3JSMgchznxyLBTMeFnq5
        XTNdyDt6yH1rMYs+rU5MIobjLtZwOMy8qn/6ezSwFU9WbWNraCSJ8GxaQvDcFw/f0FvX15OgtDR0C
        sy0sRnBA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56388)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mzbsZ-0004Hy-Vp; Tue, 21 Dec 2021 09:56:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mzbsX-0002RS-Vr; Tue, 21 Dec 2021 09:56:17 +0000
Date:   Tue, 21 Dec 2021 09:56:17 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm/sections: fix memory object end check
Message-ID: <YcGkwf0WSmfmOQXB@shell.armlinux.org.uk>
References: <20211221070624.1541842-1-agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221070624.1541842-1-agordeev@linux.ibm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 08:06:24AM +0100, Alexander Gordeev wrote:
> Function memory_contains() checks whether a memory object is
> entirely contained within a memory region. The condition that
> checks the upper bound of the object against the upper bound
> of the region is inclusive. That does not correspond to the
> similar checks in memory_intersects() friend function, nor
> to the actual regions memory_contains() is called against.
> 
> In particular, __init_end address assumed do not belong to
> the init section itself. Similarly, on ARM __idmap_text_end
> and __entry_text_end are affected.

__init_end is exclusive as are the other symbols you mention here.
They point at the byte immediately following the area.

When testing an virt + size, the resulting address of "virt + size" is
always exclusive - this also points at the byte immediately following
the range of addresses. The preceeding byte is part of the object.

For example, if size is one, then we have a single byte, which is at
address "virt". "virt + 1" is not part of the object. Therefore, if
size is 1MiB, then "virt + 1048576" is similarly not part of the
object.

Hence, we _do_ want to test address + size <= end.

This code appears to me to be correct, and this patch _introduces_ a
bug.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
