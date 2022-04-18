Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8E2504D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiDRIGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiDRIGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:06:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9AD1928C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lvGx/57LRCAClkTXqYBN9E9Z0ndJZZ3f3BxFPXiHEIY=; b=M2nhal4SneHWJyEAvf1CVjA8IX
        koPKllbhV9MXr8exLMXodRFDbJ0i3WVIOmCdbri5Pwe75IuPaWG9rjn6ulSVj58GxUls4zzX0iejm
        B9f3wbtI11SrvHlDGcqgxx7jMXZDE/dZZsML8oFpIvQ/LVX7W0KraQ1pQjUHxAs5D/dy3AgZrtLdj
        iz6R9XYOexoV9niuV6h1BZflr4TGx5rljH+QpICYYKqbUwXPVRVqRH3hB13DwTwcr7wNlx5+NHVap
        x6ULpsQBsz/1FU0Yfy66hm28HDbkPd1PoEUOsYuV6W7f95YrruuJvjkbggQ8uNDu+o5z74UNuK2GA
        uvfQJWEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58314)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ngMLi-0007sc-Mj; Mon, 18 Apr 2022 09:03:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ngMLf-0007xl-0U; Mon, 18 Apr 2022 09:03:03 +0100
Date:   Mon, 18 Apr 2022 09:03:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yuanzheng Song <songyuanzheng@huawei.com>
Cc:     ardb@kernel.org, arnd@arndb.de, linus.walleij@linaro.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: fix the incorrect value of sp in __die()
Message-ID: <Yl0bNhQwwnclGKKX@shell.armlinux.org.uk>
References: <20220418034516.521046-1-songyuanzheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418034516.521046-1-songyuanzheng@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 03:45:16AM +0000, Yuanzheng Song wrote:
> The dump_mem() will output useless content that exceed the stack
> in __die(), because sp will exceed the top of stack when the
> CONFIG_VMAP_STACK=y.

However, regs->ARM_sp _is_ the value of the stack pointer of the parent
context when the exception was taken, and is the correct value to start
printing the stack from.

If the first few prints are unreadable, then that's useful information.

> Insufficient stack space to handle exception!
> Task stack:     [0xf09dc000..0xf09de000]
> IRQ stack:      [0xf0800000..0xf0802000]
> Overflow stack: [0xc210e000..0xc210f000]
> Internal error: kernel stack overflow: 0 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 81 Comm: sh Not tainted 5.18.0-rc3 #4
> Hardware name: ARM-Versatile Express
> PC is at mmioset+0x20/0xa8
> LR is at recursive_loop+0x34/0x9c
> pc : [<c0777080>]    lr : [<c0a90c6c>]    psr: 20000013
> sp : f09dbf48  ip : f09dbf4c  fp : 00219644
> ...
> Stack: (0xf09dbf48 to 0xf09de000)
> bf40:                   ???????? ???????? ???????? ???????? ???????? ????????
> bf60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> bf80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> bfa0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> bfc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> bfe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
> c000: 57ac6e9d 00000000 00000000 00000000 00000000 00000000 00000000 00000000

The above is useful information - it tells us that 0xf09dbf48 to
0xf09dc000 fault when accessed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
