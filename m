Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66535A5FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiH3Jsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiH3Jsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:48:41 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7318DA0316
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fMLvcGcyJSODFnT4Iz/XOC3ekaKsMQFjA2PPCqmntjY=; b=nRAESfedUvvhQ7RX+ZGqkzn1sE
        Y3Mmo/ShftKSqebe5/XFpxICs/C8XvTY6wZyhiqAHS/nOd0e5kgMKJ70hId+nJn/5FQYSERW5tc8C
        m++NqG8kErJO75tvdC7AACFiLH3fgQM5HbHn2A2s2YWroyeq98cl4m1seFad+phdTx2LcS5OvJ0yU
        kP7n/bwGBTLb4QFzRdB/5vdNomw8DEWVKyarkm5pFiw7i03UH0tnCQcOB39DZFIc1Em01oiyrILOq
        NCeKmW+INVRb877TQQIT30QGmC8z3nmMuGd/DBE55MP3Di3gvwap9mgH1Z+mehUyt6aNVl/S/HeQ/
        OfogP4bg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33990)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oSxrI-0002V7-Mv; Tue, 30 Aug 2022 10:48:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oSxrI-0001PD-42; Tue, 30 Aug 2022 10:48:36 +0100
Date:   Tue, 30 Aug 2022 10:48:36 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in
 amba_probe()
Message-ID: <Yw3c9Dbai5E9Nvvp@shell.armlinux.org.uk>
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
 <CAGETcx8hfzAthF_gCMrmnVOgwgFJEPE=bwRuVeXaiB7ywUkWkg@mail.gmail.com>
 <Yw3cs6wb4PvnDN/7@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw3cs6wb4PvnDN/7@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:47:31AM +0100, Russell King (Oracle) wrote:
> How can we get to amba_probe() if amba_match() has not returned a
> positive match for an ID? Surely if that happens, the driver model
> is failed - since a probe function should not be called unless the
> driver matches the device.
> 
> This patch, and 9229/1 both feel like they're working around some
> brokenness elsewhere in the kernel.
> 
> The description in 9229/1, specifically "But not all drivers have .match

Sorry, meant 9238/1.

> hook, such as pl031, the dev->bus->probe will be called directly in
> __driver_attach()." AMBA drivers do not have a .match hook - the bus
> does, which all AMBA drivers must be a member of. If amba_match fails,
> there is no way that amba_probe() should ever be called.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
