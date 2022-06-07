Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDAA5402A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbiFGPlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245408AbiFGPlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:41:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78EAF68B2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qwLWXlxuviBmART+Bnfo0IjLKJRcEnIz9kWD4zgAtRc=; b=OdyEFd84h3FJPPA5jInPkts/E7
        WiZDMPrOetMixZj2/YzKN5W9Zi2BGWHMmSsITlbNXUBAXqGJxYASqKQP5Ut7eIeyVohTcBmL+Neh6
        UWw0ie4N8APZeNVlgJwrSSiqfE583zztUA2g/nqiSfbqfBDkQ3NpDJpKXEP7vxuzzXg6yu9uU/Rh1
        D7i/qvNBVF6EC1slpJ57MHX6AyYX+V0AlWek0JDKolB06iMnreaJfGOjyPHfr0eMbqPLSZO8YMXw1
        iLONrx8q1Evgg/YZq/gQPvCUG1FQHaH+TtfvXIDhgI2q42ZcTC7Mk+BXFDB1JWziq/hJcJ9R3i/ZM
        7emmiGqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32772)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nybKE-0003fa-0C; Tue, 07 Jun 2022 16:40:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nybK8-0000v2-1V; Tue, 07 Jun 2022 16:40:52 +0100
Date:   Tue, 7 Jun 2022 16:40:52 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 1/6] ARM: mm: kill unused runtime hook arch_iounmap()
Message-ID: <Yp9xhIzh0DR3nZex@shell.armlinux.org.uk>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
 <20220607125027.44946-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607125027.44946-2-wangkefeng.wang@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 08:50:22PM +0800, Kefeng Wang wrote:
> Since the following commits,
> 
> v5.4
>   commit 59d3ae9a5bf6 ("ARM: remove Intel iop33x and iop13xx support")
> v5.11
>   commit 3e3f354bc383 ("ARM: remove ebsa110 platform")
> 
> The runtime hook arch_iounmap() on ARM is useless, kill arch_iounmap()
> and __iounmap().
> 
> Cc: Russell King <linux@armlinux.org.uk>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
