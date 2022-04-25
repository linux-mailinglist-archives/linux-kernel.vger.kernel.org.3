Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3786250E32B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiDYOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242404AbiDYOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:33:12 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A124934BB4;
        Mon, 25 Apr 2022 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qDSAv76TkyAfJwUTMOz9uK+ekEfOD4SkGCFHfWwnOas=; b=xwNd34Btk/mXR+BaWCWgEQ7fKX
        MEqv2iqIQf/jn9tdFfCKrvt4mJ8CPtCm+c0vcNiOkaebz2Ghb++kRQ0+/jmFGHCyA0e4oZbGvOQa9
        2WVwBpwV6NJ2KrqzZCb1z8w1cDZr5rMB0dwehWlS2EGEaSnYFMe4IhQ+AJ9NhZB/CFJo6+ceGEWpg
        zKgj3a96W0tGzGAeRKItX5vuua29e5hEseCfUPjfpMtXAqTa6jsj2AOm15qGKPmGjvZZg7Aqbe/jR
        0zmHQk41QAOnTXXJFg8q2jGczFzS02HGf0/xcRzhSGqHTrBYhnwaZPcyrmkJDc4q1e9KpE5Dmb3zh
        +d0d7fQA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58396)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nizj1-0007OB-Lx; Mon, 25 Apr 2022 15:30:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nizj0-0006cV-1D; Mon, 25 Apr 2022 15:30:02 +0100
Date:   Mon, 25 Apr 2022 15:30:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Subject: Re: [PATCH v6 10/17] arm: use fallback for random_get_entropy()
 instead of zero
Message-ID: <YmawarJUQoOeVzVt@shell.armlinux.org.uk>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-11-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423212623.1957011-11-Jason@zx2c4.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 11:26:16PM +0200, Jason A. Donenfeld wrote:
> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
