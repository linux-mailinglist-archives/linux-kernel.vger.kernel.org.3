Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A230C4FB50E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbiDKHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245524AbiDKHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:39:32 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97CC3969E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:37:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8AA23200009;
        Mon, 11 Apr 2022 07:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649662637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f23x7rYso3qTtUKAOasLEySA7B77wZVwGhNXdFZuxHo=;
        b=hGiVuSiLd/yF1F9sGVaGV3TxN+/os56t3b2ohQUvEcKulmovYXMLRn49geBtJ65Xp7U1Np
        k0UzNgF63evz6fKL5gc8ec0EKUQQ0gOPS5+eT1647Tu9I91FdPvM6TAuuldGXSZr4Cj82m
        A1Fl5lDruqsNNkzW/pzDdmCdDtB06VeCXMivDozWq0kbm2YLKIYDYOCWFX8Jf7v6M5/f++
        cPO+0JAlJ50lG7ZrHtb7suOrw9uZRx4136LorPHWNxSAJxAPTqM5LcBcZ/Dj8BZLFIFTxx
        F9QiIR4VoG6WtJVi3tFpViLJz1SU25BUGNhR5qsl2w6D2r2nX+WUp8XqEguAbg==
Date:   Mon, 11 Apr 2022 09:37:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] mtd: rawnand: denali_pci: page fault when probing fails
Message-ID: <20220411093715.4cecc280@xps13>
In-Reply-To: <CAMhUBjn40pO7A=icudFKOoiMrckcH_o7mdi-uCmgCFHi6Ueuzw@mail.gmail.com>
References: <CAMhUBjn40pO7A=icudFKOoiMrckcH_o7mdi-uCmgCFHi6Ueuzw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheyu,

zheyuma97@gmail.com wrote on Sun, 10 Apr 2022 22:17:35 +0800:

> Hello,
>=20
> I found a bug in the denali_pci module.
> When the driver fails to probe, we will get the following splat:
>=20
> [    4.472703] denali-nand-pci 0000:00:05.0: timeout while waiting for
> irq 0x1000
> [    4.474071] denali-nand-pci: probe of 0000:00:05.0 failed with error -5
> [    4.473538] nand: No NAND device found
> [    4.474068] BUG: unable to handle page fault for address:
> ffffc90005000410
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
>=20
> It seems that the driver unmap the memory region before disabling the irq.

Thanks for the report! The mapping is done with devm_ helpers and so is
the IRQ registration, so it's slightly more complicated that just
moving a function call in the remove path, apparently. Would you mind
investigating and proposing a patch?

Thanks,
Miqu=C3=A8l
