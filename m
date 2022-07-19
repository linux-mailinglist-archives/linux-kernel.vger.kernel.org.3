Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5DB579A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiGSMMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiGSMMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:12:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F8C474EA;
        Tue, 19 Jul 2022 05:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F0F0B81B31;
        Tue, 19 Jul 2022 12:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED24C341C6;
        Tue, 19 Jul 2022 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658232219;
        bh=mYgorTCKW9dcyIfBO3uoP1zk+o/ZbssEvug0p5OqzbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AukUUfFkQYYFd9U5o35WNMCdV6axMWiM0Ctz98c7XQVObN6ZJM+ZEtXo5OpxxL3QF
         9+gdufdS8tsAArX3DWnxdtLBThtducDRKqq8m4DiffzZttvuEgV4KezPyhCN1dv53r
         E5iWBkU1QxgiVInf752wOTABwOQGOghy4TjqEMmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianglei Nie <niejianglei2021@163.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 53/71] net: sfp: fix memory leak in sfp_probe()
Date:   Tue, 19 Jul 2022 13:54:16 +0200
Message-Id: <20220719114557.474104305@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719114552.477018590@linuxfoundation.org>
References: <20220719114552.477018590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianglei Nie <niejianglei2021@163.com>

[ Upstream commit 0a18d802d65cf662644fd1d369c86d84a5630652 ]

sfp_probe() allocates a memory chunk from sfp with sfp_alloc(). When
devm_add_action() fails, sfp is not freed, which leads to a memory leak.

We should use devm_add_action_or_reset() instead of devm_add_action().

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20220629075550.2152003-1-niejianglei2021@163.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5657c604602e..beaa00342a13 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1878,7 +1878,7 @@ static int sfp_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sfp);
 
-	err = devm_add_action(sfp->dev, sfp_cleanup, sfp);
+	err = devm_add_action_or_reset(sfp->dev, sfp_cleanup, sfp);
 	if (err < 0)
 		return err;
 
-- 
2.35.1



