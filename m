Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF059233A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 17:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiHNPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbiHNPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 11:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D01A805;
        Sun, 14 Aug 2022 08:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFCE560CF5;
        Sun, 14 Aug 2022 15:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83DCC433C1;
        Sun, 14 Aug 2022 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660491407;
        bh=2IANWfcDXn8gdk1Z4gv51ItWI+UvkHS6CpqklXgJFeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CP+djlBD/sA/kbRYMsdmL0uHLHBhqxxzPeiEfK4o+nkl29XrQKUNk15qrq4WwcQBL
         AdW88K/+oOZPkSeeg8JKiNmanwPichFwn+gcMu8Z/2GNi06PLranSATbw6zYcfrrM/
         r5ILS4HkfbBhVDjHcZL3EjyEilKNdEeVbAjOXiUEdltL28uCWaSGb9jHPnfL9XMZ8e
         25NRc8QNerJt/vwZ7S5VFS4IKdj7Y7QD+T12SUaMZfzlwBqNCi0+sfLrvySEpJZagZ
         2+2d0wXp6XJxccdx0xVwcRnrCkCLVcihqQVi+sJ1waQPUixXB39ZK317aT8R3q9bEq
         zcfx1sWWYJK7w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jozef Martiniak <jomajm@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, balbi@kernel.org,
        stern@rowland.harvard.edu, axboe@kernel.dk, hbh25y@gmail.com,
        rdunlap@infradead.org, mingo@kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/9] gadgetfs: ep_io - wait until IRQ finishes
Date:   Sun, 14 Aug 2022 11:36:32 -0400
Message-Id: <20220814153637.2380406-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814153637.2380406-1-sashal@kernel.org>
References: <20220814153637.2380406-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jozef Martiniak <jomajm@gmail.com>

[ Upstream commit 04cb742d4d8f30dc2e83b46ac317eec09191c68e ]

after usb_ep_queue() if wait_for_completion_interruptible() is
interrupted we need to wait until IRQ gets finished.

Otherwise complete() from epio_complete() can corrupt stack.

Signed-off-by: Jozef Martiniak <jomajm@gmail.com>
Link: https://lore.kernel.org/r/20220708070645.6130-1-jomajm@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/legacy/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 53d17e1bb65a..f0f41cc8b2f1 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -365,6 +365,7 @@ ep_io (struct ep_data *epdata, void *buf, unsigned len)
 				spin_unlock_irq (&epdata->dev->lock);
 
 				DBG (epdata->dev, "endpoint gone\n");
+				wait_for_completion(&done);
 				epdata->status = -ENODEV;
 			}
 		}
-- 
2.35.1

