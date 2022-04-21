Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD549509936
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242699AbiDUHlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386051AbiDUHkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:40:53 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30651D0E8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:37:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D8F821BF216;
        Thu, 21 Apr 2022 07:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0Sm4Xz2dTAZCIP2aG40242xnWMl8eBIaOUNhSxdP1Q=;
        b=KWqUlTyJRVAwOsQev62w4lyZIPDZVaOiBYyei7VJv6sL4wkCvunPbGOQr/K9Z6NkjR9B9r
        X2A57140HWhOByKhxqKwvtXSsWE1VfIrevVfjaNkUdXoO/VBVz85aXHwRXe9MSeN6q4dTR
        Zjc4AdiWKXmfu7/9VTVUM2tONzTjBJ3P0SdezpeeQEyO9QJU5oEX8ouKIiQFmB7abkFLmg
        DnIIpKZn0+muKI9alPHsWpmPE1/ZT638fG1cnbVeG/DjdM9VL7AAQ6mErVvQui4FXuKrpd
        hUTnrPC/oOnJ7NBBexAFjM2r93sgFU+yolFhpF9+CbyDRFM2sdN8UTOilUUscg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zheyu Ma <zheyuma97@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: denali: Use managed device resources
Date:   Thu, 21 Apr 2022 09:37:16 +0200
Message-Id: <20220421073716.72814-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220411125808.958276-1-zheyuma97@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3a745b51cddafade99aaea1b93aad31e9614e230'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-11 at 12:58:08 UTC, Zheyu Ma wrote:
> All of the resources used by this driver has managed interfaces, so use
> them. Otherwise we will get the following splat:
> 
> [    4.472703] denali-nand-pci 0000:00:05.0: timeout while waiting for irq 0x1000
> [    4.474071] denali-nand-pci: probe of 0000:00:05.0 failed with error -5
> [    4.473538] nand: No NAND device found
> [    4.474068] BUG: unable to handle page fault for address: ffffc90005000410
> [    4.475169] #PF: supervisor write access in kernel mode
> [    4.475579] #PF: error_code(0x0002) - not-present page
> [    4.478362] RIP: 0010:iowrite32+0x9/0x50
> [    4.486068] Call Trace:
> [    4.486269]  <IRQ>
> [    4.486443]  denali_isr+0x15b/0x300 [denali]
> [    4.486788]  ? denali_direct_write+0x50/0x50 [denali]
> [    4.487189]  __handle_irq_event_percpu+0x161/0x3b0
> [    4.487571]  handle_irq_event+0x7d/0x1b0
> [    4.487884]  handle_fasteoi_irq+0x2b0/0x770
> [    4.488219]  __common_interrupt+0xc8/0x1b0
> [    4.488549]  common_interrupt+0x9a/0xc0
> 
> Fixes: 93db446a424c ("mtd: nand: move raw NAND related code to the raw/ subdir")
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
