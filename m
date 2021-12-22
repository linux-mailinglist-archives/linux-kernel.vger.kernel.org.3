Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C836947D391
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbhLVOVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245669AbhLVOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:20:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7FC06173F;
        Wed, 22 Dec 2021 06:20:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6910DB81CD7;
        Wed, 22 Dec 2021 14:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16154C36AEA;
        Wed, 22 Dec 2021 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640182852;
        bh=vcP7wy5cAnExbSb9ekWEQS6h8bnvR24/Ebd1+A2vMc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7PX/Z7O8znCbLR5TRN+k7uVNFkwxNWZdB+PSS55qB0xC8PaPSUSFSsMMrFPV+9rX
         ZkDfM0xY0eI8hZuNsRZuHOCBXQOGTXuSJmMekMa2PGsqdK+Y7VO4jSxRfrUckUXiRF
         5utzi0o350X4D1lcYMEp7J1igJ3ZMV6i5iUG5zH/fp1rdNBJA+AuABVuZ70Qaojhi/
         GHN/sxFxpRydm16OZBzc80W1O5Wr0bmaBPTD6UZ9vrQHaoPikiJxUtcgjxq84FHn17
         WEm1OynDhqdUPR1J0tsKrj/efEFilSekOrbSHX9Iqerbf3jPPS38I3gsy9pQfx8BuL
         yOqfAQL1hf1og==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1n02U0-0007uq-UA; Wed, 22 Dec 2021 15:20:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] media: davinci: vpif: drop probe printk
Date:   Wed, 22 Dec 2021 15:20:25 +0100
Message-Id: <20211222142025.30364-5-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211222142025.30364-1-johan@kernel.org>
References: <20211222142025.30364-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should generally not print anything for a successful probe, and
printing "success" before probe is done makes no sense.

Drop the unnecessary and misleading dev_info() call from probe.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/media/platform/davinci/vpif.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
index 4a260f4ed236..03b4e51bb13a 100644
--- a/drivers/media/platform/davinci/vpif.c
+++ b/drivers/media/platform/davinci/vpif.c
@@ -456,8 +456,6 @@ static int vpif_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get(&pdev->dev);
 
-	dev_info(&pdev->dev, "vpif probe success\n");
-
 	/*
 	 * If VPIF Node has endpoints, assume "new" DT support,
 	 * where capture and display drivers don't have DT nodes
-- 
2.32.0

