Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB285A60BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiH3K2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH3K2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:28:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537C79D645
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iVRqb6pvYoEPCs3UsIknWmZQWN73wQEyaT6OK3Lynb4=; b=e36ywwCk/qloQi5u7GDXWcmGUm
        cv9tIADKqkkFFkA76US3eMzLIsceik6ifT5qlEDIOifT+yDDvf8CtKASL7gf1FkltxSnGxQYdmKPp
        Ujb8hjIhv39numbFGMz0InLFgq2eDuW7kWVf4h64MEO1dXFgMvGGKv2uvH5sJWG6DY7EWY683wbeJ
        NhPcod2oQeAw2o+PXtlxtVtrMMWqPEaAvw6cwcUNnLVgjx9m2+4niVbXukp9F6ElY0gELgxCFsiLb
        WUMNb025C2Sj37SC9a1JXuOBJKYZRvtup7SjZH/dLyUpUW3EpY62Lk470NhW/HjAmmVvdjyKFdvB/
        c1GOmHgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33996)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oSyTV-0002bP-89; Tue, 30 Aug 2022 11:28:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oSyTS-0001Qm-OW; Tue, 30 Aug 2022 11:28:02 +0100
Date:   Tue, 30 Aug 2022 11:28:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Saravana Kannan <saravanak@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in
 amba_probe()
Message-ID: <Yw3mMrx0oJjLGVN0@shell.armlinux.org.uk>
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830065413.638-1-thunder.leizhen@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:54:13PM +0800, Zhen Lei wrote:
> Commit f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
> forcibly invokes device_add() even if dev->periphid is not ready. Although
> it will be remedied in amba_match(): dev->periphid will be initialized
> if everything is in place; Otherwise, return -EPROBE_DEFER to block
> __driver_attach() from further execution. But not all drivers have .match
> hook, such as pl031, the dev->bus->probe will be called directly in
> __driver_attach(). Unfortunately, if dev->periphid is still not
> initialized, the following exception will be triggered.

Please check whether 9229/1 fixes this issue for you.

http://www.armlinux.org.uk/developer/patches/download.php?id=9229/1

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
