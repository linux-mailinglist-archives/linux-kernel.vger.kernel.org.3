Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037C84AB0B1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244931AbiBFQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244748AbiBFQmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:42:04 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63534C043189
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:42:03 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:f5f1:f284:117e:4f61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 7788429DB9A;
        Sun,  6 Feb 2022 17:42:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1644165720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2tUGuwnHub3ohgaQu7AuDy49z5IJSV+VEq/ifqJrvOk=;
        b=HCeuvXG6e7l7YfnF9qmNsumlTNKIJ8qn+TTtTcvmcAgneaYBWlSBJ2LpAZpJydtTmw89Qo
        lV+vqCpkoNN66t/jc93t+W4iWsBMI83icqfMeJCCeZw0OMMfblUz+xyr29JICm509eC8tV
        tY22nJUI2AZaDA1QhrkFrecO2afC1HyULQxP5gaO5Y2McatqdXad4rTUYkGyCSsFN5FRRz
        Hh0gHFM98Iy9KHnVs/WyvVLODyYgKgaaiO2xTBVe9WsW5wyOKA+jESpXIhEEVJqREuZUEA
        W+h65Jb/IT88RQJRjfaOU4hQyo0GQ3vHsu3JdlTVu5NCyehz9DGWUPKbKUreTg==
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 0/3] Per-parent domains for realtek-rtl IRQ driver
Date:   Sun,  6 Feb 2022 17:41:50 +0100
Message-Id: <cover.1644165421.git.sander@svanheule.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original implementation for this interrupt controller/router used
an interrupt-map parser to determine which parent interrupts were
present. However, this controller is not transparent, so a list of
parent interrupts seems more appropriate, while also getting rid of the
assumed routing to parent interrupts.

Additionally, N real cascaded interrupts are implemented, instead of
handling all input interrupts with one cascaded interrupt. Otherwise it
is possible that the priority of the parent interrupts is not respected.

Changes since v3:
Link: https://lore.kernel.org/all/cover.1641739718.git.sander@svanheule.net/

- Patches with fixes were merged, so these are no longer included.
- Update the devicetree changes to more clearly indicate the controller
  is not transparent.

Changes since v2 (RFC):
Link: https://lore.kernel.org/all/cover.1640548009.git.sander@svanheule.net/

- Define new, two-part compatibles for devicetree bindings. The existing format
  is kept for the old one-part compatible, but deprecated. New compatibles will
  require a different way of specifying parent interrupts and interrupt routing.
- Add change to handle all pending SoC interrupts in one go.

Changes since v1 (RFC):
Link: https://lore.kernel.org/all/cover.1640261161.git.sander@svanheule.net/

- Split some of the changes to limit the patch scope to one issue.
- Dropped some small (spurious or unneeded) changes
- Instead of dropping/replacing interrupt-map, the last patches now provide an
  implementation that amends the current situtation.

Sander Vanheule (3):
  dt-bindings: interrupt-controller: realtek,rtl-intc: require parents
  irqchip/realtek-rtl: use parent interrupts
  irqchip/realtek-rtl: use per-parent domains

 .../realtek,rtl-intc.yaml                     |  82 +++++--
 drivers/irqchip/irq-realtek-rtl.c             | 231 ++++++++++++------
 2 files changed, 221 insertions(+), 92 deletions(-)

-- 
2.34.1

