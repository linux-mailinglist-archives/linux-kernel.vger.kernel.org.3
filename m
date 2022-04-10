Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F44FAE31
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbiDJOT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiDJOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:19:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4CF4BFF5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 07:17:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so11949646pgn.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FMBgmq8WKX+31y3rGclfHeDGwB3PfPowydFLKHwFCfQ=;
        b=mLvHvlFkv6OT+7/x+LeJDrtZZr8fRBhJJ2mgrN717MhJA26x5JO4ysK2LM7P81ymhR
         k4glu0J8QDC6TPkV0AXEmKQvwzr8DyzKNLF/fk94lOB0nfuJA1p7pkCz5/+R6hH3pGT3
         37/cPCRNJDKj53Rgn/ktsG2VJznD+UqYBNdbGBJEcZ+Jh+kKugSo8bqNLThh4I0vQ594
         sBnuA6K5kOJtUNHzd56qIo1TQP66ntFROjh80n6+M6A1bLhS7w6K07qhZGdSC+1Yqmmm
         vWyVeteSS5VhXpBvGE90hD5i2nn0phU/lJkBHm7tSKAp3plwCB+ftCUP/h/BYrZtYdg3
         Vg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FMBgmq8WKX+31y3rGclfHeDGwB3PfPowydFLKHwFCfQ=;
        b=t0oeuU6it3VeTTMYmZ3GH80mBOM+xvPdoSJgJkFMJT0wafUWpPAalGsaybFTtSvpKh
         eOpAd42Zzxs++OnSOagMcWF8SC/zY4M2QDrwu6mT0io0w2sIUVbwkeTdEYQdObwTSSp7
         xZYfxCwGKm6nOYr6S0XpEIo93nYQqz1Raa+ymlC1c2Q7p5lcFDW0EBgU4XQ8L0CfwznL
         C7iBklb1I4qrIOoikz/UfwHEFjN391i7EoCa36rZMEzyYTY59v4RVF5xLw9tsdkAdLvG
         yp4hVwhENdco1VK1YeeEsONRp5niQ2x6fEA9MmOhR33mhdppHdaD6wyx76+xNDJeNEIB
         MBsQ==
X-Gm-Message-State: AOAM533KTnNhUv6pPraXj8MbcFF6Bssp1S2Ya7erVMQuqAlEat5exP3W
        l9PIdEUapwgpdoqbnTf0EkhQhW+huCOlpLgjkQ==
X-Google-Smtp-Source: ABdhPJznr7MjkdWgQf2yJa7FooAbfWqjAnQjRrdpSS6+CnEn4MUZoHzPicnQcAWZ5sW1Z0LFsgLUyp7RqWNXpTFZQyI=
X-Received: by 2002:a05:6a00:ad0:b0:4f7:a357:6899 with SMTP id
 c16-20020a056a000ad000b004f7a3576899mr28594362pfl.80.1649600266651; Sun, 10
 Apr 2022 07:17:46 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sun, 10 Apr 2022 22:17:35 +0800
Message-ID: <CAMhUBjn40pO7A=icudFKOoiMrckcH_o7mdi-uCmgCFHi6Ueuzw@mail.gmail.com>
Subject: [BUG] mtd: rawnand: denali_pci: page fault when probing fails
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a bug in the denali_pci module.
When the driver fails to probe, we will get the following splat:

[    4.472703] denali-nand-pci 0000:00:05.0: timeout while waiting for
irq 0x1000
[    4.474071] denali-nand-pci: probe of 0000:00:05.0 failed with error -5
[    4.473538] nand: No NAND device found
[    4.474068] BUG: unable to handle page fault for address:
ffffc90005000410
[    4.475169] #PF: supervisor write access in kernel mode
[    4.475579] #PF: error_code(0x0002) - not-present page
[    4.478362] RIP: 0010:iowrite32+0x9/0x50
[    4.486068] Call Trace:
[    4.486269]  <IRQ>
[    4.486443]  denali_isr+0x15b/0x300 [denali]
[    4.486788]  ? denali_direct_write+0x50/0x50 [denali]
[    4.487189]  __handle_irq_event_percpu+0x161/0x3b0
[    4.487571]  handle_irq_event+0x7d/0x1b0
[    4.487884]  handle_fasteoi_irq+0x2b0/0x770
[    4.488219]  __common_interrupt+0xc8/0x1b0
[    4.488549]  common_interrupt+0x9a/0xc0

It seems that the driver unmap the memory region before disabling the irq.

Regards,
Zheyu Ma
