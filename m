Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2849BF25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiAYWvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiAYWui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:50:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A0AC061753;
        Tue, 25 Jan 2022 14:50:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA45960C0B;
        Tue, 25 Jan 2022 22:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48474C340EB;
        Tue, 25 Jan 2022 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643151037;
        bh=A+6x5HIcipmLX7MAIl49Tcq4C1TNDEakGFm4cHaCy3I=;
        h=Date:From:To:Cc:Subject:From;
        b=AnfpOrC3lCetTI4n+HRBoIh7HG9pgRM8yewmybCi3yHD8Nvv/eDlCC9QiHYEpMO0g
         dUUwgsSvNX1Qa7GYR84ZPiLdcv9Fru5v1UX/Xy2q6u+o6T+k+uT9Dsc/RXUtg7ZoGP
         n9SgRTBKqnmGJ2AYq+tAEAkFegU/+NezUZYGS6ApjO6UijQ0iYWzEHkcVs4AxVH+sV
         Z51ujurEa+5pgcYE7a3qC9qibJFOgzu8iq+jcb8ZQlnhjbkBZUlegxKmv5u7NydHMf
         9YA4K3g3GL3wECSEdjsH+6GYlSgrNAbqcbn9vUlEbPAlw3mU3kcSFufkrDOevRf6Gr
         YWezmOJy64jdQ==
Date:   Tue, 25 Jan 2022 16:57:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] hwspinlock: sprd: Use struct_size() helper in
 devm_kzalloc()
Message-ID: <20220125225723.GA78256@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/hwspinlock/sprd_hwspinlock.c:96:36: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/hwspinlock/sprd_hwspinlock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index d221fc9d756d..22e2ffb91743 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -93,8 +93,7 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	sprd_hwlock = devm_kzalloc(&pdev->dev,
-				   sizeof(struct sprd_hwspinlock_dev) +
-				   SPRD_HWLOCKS_NUM * sizeof(*lock),
+				   struct_size(sprd_hwlock, bank.lock, SPRD_HWLOCKS_NUM),
 				   GFP_KERNEL);
 	if (!sprd_hwlock)
 		return -ENOMEM;
-- 
2.27.0

