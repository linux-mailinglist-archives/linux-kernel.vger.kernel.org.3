Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143C75933F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiHORTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiHORTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:19:01 -0400
Received: from zeeaster.vergenet.net (zeeaster.vergenet.net [206.189.110.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21627CF6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:18:59 -0700 (PDT)
Received: from madeliefje.horms.nl (2a02-a44a-2918-403-201-8eff-fe22-8fea.fixed6.kpn.net [IPv6:2a02:a44a:2918:403:201:8eff:fe22:8fea])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by zeeaster.vergenet.net (Postfix) with ESMTPSA id 9DBEE20101;
        Mon, 15 Aug 2022 17:18:57 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
        id 6E5E6D3C; Mon, 15 Aug 2022 18:18:57 +0100 (BST)
Date:   Mon, 15 Aug 2022 18:18:57 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Liu Song <liusong@linux.alibaba.com>, bhelgaas@google.com,
        pablo@netfilter.org, davem@davemloft.net, nathan@kernel.org,
        apw@canonical.com, joe@perches.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig: eliminate abnormal characters displayed under
 menuconfig
Message-ID: <YvqAATtWg1xLzyRs@vergenet.net>
References: <1659435153-119538-1-git-send-email-liusong@linux.alibaba.com>
 <20220809025147.GA1264335@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220809025147.GA1264335@bhelgaas>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 09:51:47PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 02, 2022 at 06:12:33PM +0800, Liu Song wrote:
> > From: Liu Song <liusong@linux.alibaba.com>
> > 
> > Use "find ./linux/* | grep Kconfig | xargs file | grep UTF", can find
> > files with utf-8 encoded characters, these files will display garbled
> > characters in menuconfig, except for characters with special meanings
> > that cannot be modified, modify the characters with obvious errors to
> > eliminate the wrong display under meunconfig.
> > 
> > Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> 
> I did suggest fixing everything at once.  But I think there are
> actually two problems here.  The first is that some are just wrong,
> e.g., drivers/pci/Kconfig using CYRILLIC SMALL LETTER DZE instead of
> "s", or net/netfilter/ipvs/Kconfig using NO-BREAK SPACE for no good
> reason.
> 
> arch/Kconfig looks like it's using RIGHT SINGLE QUOTATION MARK instead
> of the basic APOSTROPHE.  That one is debatable; I think it's fair to
> argue that RIGHT SINGLE QUOTATION MARK would be preferred if rendered
> correctly.
> 
> The second problem is that I think menuconfig doesn't handle UTF-8
> correctly.  For example, in a gnome terminal with the default
> LC_ALL=en_US.UTF-8, these look fine:
> 
>   $ grep -A10 MTD_SPI_NOR_USE_4K_SECTORS drivers/mtd/spi-nor/Kconfig
>   ...
>   64 KiB block instead of 16 × 4 KiB sectors.
> 
>   $ grep -A1 MTD_NAND_CAFE drivers/mtd/nand/raw/Kconfig
>   config MTD_NAND_CAFE
> 	tristate "OLPC CAFÉ NAND controller"
> 
> But when menuconfig in the same terminal displays that same text, it
> looks like "16  ~W 4 KiB sectors" and "OLPC CAF ~I NAND".
> 
> On the other hand, gconfig and xconfig do render these correctly.  So
> I think there's something wrong with UTF-8 in menuconfig, and we
> should fix that as well.
> 
> Anyway, I'm fine with this patch as far as it goes:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

IPVS portion:

Acked-by: Simon Horman <horms@verge.net.au>

