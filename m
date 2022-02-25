Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11CB4C42B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiBYKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiBYKs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:48:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC822BEB1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:47:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1028B616DE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2163DC340E7;
        Fri, 25 Feb 2022 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645786073;
        bh=Y2/YHWWHhHoEygfaYfTncLZs7LflEru8aRjpfPKRQYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDIHgDc5o2sCzSgxChoVsYRaK3/t8HfQOctlMb1/QMQEsKKAz9LjimA1l/cX9bZXq
         ZrPC3k3l/LLOU8I38NSUom1lw1dcuUccOivrOG3CtdaTfhhh2ZIVAUSOIqatdl5Ir9
         JiZoN+TRt+4sNBvPnB6Hi9wP2iZmr4OQcI20oiCQ=
Date:   Fri, 25 Feb 2022 11:47:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Julius Werner <jwerner@chromium.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH v2] firmware: google: Properly state IOMEM dependency
Message-ID: <Yhiz1s35vfqC4S0v@kroah.com>
References: <20220225041502.1901806-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225041502.1901806-1-davidgow@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:15:02PM +0800, David Gow wrote:
> The Google Coreboot implementation requires IOMEM functions
> (memmremap, memunmap, devm_memremap), but does not specify this is its
> Kconfig. This results in build errors when HAS_IOMEM is not set, such as
> on some UML configurations:
> 
> /usr/bin/ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
> coreboot_table.c:(.text+0x311): undefined reference to `memremap'
> /usr/bin/ld: coreboot_table.c:(.text+0x34e): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
> memconsole-coreboot.c:(.text+0x12d): undefined reference to `memremap'
> /usr/bin/ld: memconsole-coreboot.c:(.text+0x17e): undefined reference to `devm_memremap'
> /usr/bin/ld: memconsole-coreboot.c:(.text+0x191): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
> vpd.c:(.text+0x300): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
> vpd.c:(.text+0x382): undefined reference to `memremap'
> /usr/bin/ld: vpd.c:(.text+0x459): undefined reference to `memunmap'
> /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
> vpd.c:(.text+0x59d): undefined reference to `memremap'
> /usr/bin/ld: vpd.c:(.text+0x5d3): undefined reference to `memunmap'
> collect2: error: ld returned 1 exit status
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>
> Acked-By: Julius Werner <jwerner@chromium.org>
> ---

What commit id does this fix?

thanks,

greg k-h
