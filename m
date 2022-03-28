Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7B4EA0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbiC1UCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344234AbiC1UB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:01:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E13B3E3;
        Mon, 28 Mar 2022 13:00:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 8DFC11F43871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497605;
        bh=m44B+xryaDUBDC4OQZH1svm4TvbuzUk06rZQFsjsWkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dd0806z1QOOqDJRf/6nckgUYaYCCCq1RZvmymLye4MrEVbi/GLzoVD/98K8xpdfpd
         OOaBuahZWQqWJFxiGJsE1E24+2+QPUgfsWbegMOGbgE7oQ3IodaVuMENc6XqD7whtI
         RWTqn0EinA3/ORAu0d9Ov8Zkr7eM7+HZMgfvPrr3smH7Dv5rRtNpY34ypTVM6zRLVa
         LnoF9n9Xb8b903lw7Fj2I4G7gRqV90tOvH0uOQUKTxWWE7ZVUvzupw5sUOtKHjQCEe
         DrwhIK95JOVt9WxEySFw9DmEwC4A0tZVSH/8ay9040P/sk2PbBgVaXYnJZ0pesC1m/
         +YcQ6pe5ShX9A==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/24] media: rkvdec: Stop overclocking the decoder
Date:   Mon, 28 Mar 2022 15:59:24 -0400
Message-Id: <20220328195936.82552-13-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this overclock hack seems to works on some implementation (some
ChromeBooks, RockPi4) it is also causing instability on other
implementation (notably LibreComputer Renegade, but saw more reports in
the LibreELEC project, were this is already removed). While performance is
indeed affectied (tested with GStreamer), 4K playback still works as long
as you don't operate in lock step and keep at least 1 frame ahead of time
in the decode queue.

After discussion with ChromeOS members, it would seem that their
implementation indeed synchronously decode each frames, so this hack was
simply compensating for their code being less efficienti. This hack
should in my opinion have stayed downstream and I'm removing it to ensure
stability across all RK3399 variants.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index c0cf3488f970..2df8cf4883e2 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -1027,12 +1027,6 @@ static int rkvdec_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Bump ACLK to max. possible freq. (500 MHz) to improve performance
-	 * When 4k video playback.
-	 */
-	clk_set_rate(rkvdec->clocks[0].clk, 500 * 1000 * 1000);
-
 	rkvdec->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rkvdec->regs))
 		return PTR_ERR(rkvdec->regs);
-- 
2.34.1

