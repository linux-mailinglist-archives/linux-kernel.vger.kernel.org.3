Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6DD58C5C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiHHJmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242414AbiHHJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:42:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAFBD43
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jabxQNmKugX49duLCRQ1WxMQ73IJlWHxcJdvAYi/ZBE=; b=i59R3fYUn+GkU9gh8J01B+Jci2
        8u6oRdOJM59SLJ9LoeHMpXvk6LWZcrP48cIqymCTEFH3Q4/xWKwd8iPqqJABo20JHYDnP576C/AUD
        MqxdUvz9EkoN8qAUskgdRpw7cOrrs33snGkeSqBpfghmx6lh24pJMs5lKsFK/2W1WAmH/hYUUA36q
        CR5fwThXeAq8bX0xWv5jYu9PMpF1yiKgMdVpcOhQWVx3dkjyW156fq1GczQxEmFFinsoHPIFecsDE
        OYRieMMqGBnXUrtI+zuhi1q/+Yj09hNaJJ0ZXCkQiXv4d+oZfpPFRX3Ns/Vq35oXEIJd9eAd91GMr
        xO1LBn8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33716)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oKzGm-0007tv-Ay; Mon, 08 Aug 2022 10:41:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oKzGj-0005Kl-N4; Mon, 08 Aug 2022 10:41:54 +0100
Date:   Mon, 8 Aug 2022 10:41:53 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk
Subject: Re: [PATCH] ARM: Remove the special printing format of pc and lr in
 __show_regs()
Message-ID: <YvDaYakZnP5Z+2ia@shell.armlinux.org.uk>
References: <20220801032016.1524-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801032016.1524-1-thunder.leizhen@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 11:20:16AM +0800, Zhen Lei wrote:
> Currently, instruction pointers are printed in [<%08lx>] format to make
> them more visible. However, it is not necessary in __show_regs() because
> they have the prefix 'pc :' or 'lr :', and it is also inconsistent with
> that of other registers, which causes misalignment.

The formatting is not "to make them more visible" - it was to mark the
addresses that we wanted the ksymoops utility to translate to kernel
symbols before we had kallsyms in the kernel. If one disables kallsyms,
then we still need a way to translate kernel addresses to symbols.

I notice there is a script which helps with this that is part of the
kernel source - scripts/decode_stacktrace.sh. I haven't tried this on
arm32 since I always use kallsyms - and I suspect that is rather
universally true as it avoids needing System.map files etc to decode
the oops. That said, if you're building a kernel for small systems,
you probably don't want the overhead of kallsyms.

So, there's an argument for keeping it - it's an API in that it
provides hints to scripting to identify which values need to be
converted to symbols. There's also the argument for getting rid of it,
which is that hardly anyone does that anymore.

The question is, which is the more important argument, and I don't
think there's a definite answer. So I'm inclined to leave this
as-is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
