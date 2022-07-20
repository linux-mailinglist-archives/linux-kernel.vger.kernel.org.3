Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E057B52C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiGTLP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiGTLPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1280A2CDC4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B5F061CBC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DEBC341C7;
        Wed, 20 Jul 2022 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658315739;
        bh=sAxCp6gFRgk44z8dlt9bNoYAKcuXSkDkRTTQ1eBtAMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArNHwcgbe1eAB0Yj95uhZfN07nH7WSNWyY3lh1pU+mrK/uyU6V7fcxLHp9jvWl9h6
         /SWRpJOHONlZYYm0bqDgSz2vn90hhFC7h4dzoF6PnPVSU+3mfrWMiATNrbMExJ30Kd
         4+jmTwc6BU3uGzcMwRUXWd6uJq49oir0K+vEjoqtj153j7V+idVSLbfe8GEr4tiBoA
         /vj87Dhejo3KTftq2HmeRi3YpsidDwe41gG2uN1h5X3XqRPVAA8EpTl6r9oDYsu2Pt
         7yjR0uECE6cLwtlePoUc0ugro1ZYtQZg/lplxWQwYLQIhZvbWmGkqKVBAdIJXhc3z+
         KiUiOfU7VgU8A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 8/9] habanalabs: wrap macro arg with parentheses
Date:   Wed, 20 Jul 2022 14:15:22 +0300
Message-Id: <20220720111523.4069830-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720111523.4069830-1-ogabbay@kernel.org>
References: <20220720111523.4069830-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

The macro argument <val> is cast-ed to u32 in some of the places.
Because this arg can be some arithmetic computation (e.g. address +
offset) the cast should be on the whole expression.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 350bc5b9f174..d3efec600458 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2506,7 +2506,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 				break; \
 			(val) = __elbi_read; \
 		} else {\
-			(val) = RREG32((u32)addr); \
+			(val) = RREG32((u32)(addr)); \
 		} \
 		if (cond) \
 			break; \
@@ -2517,7 +2517,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 					break; \
 				(val) = __elbi_read; \
 			} else {\
-				(val) = RREG32((u32)addr); \
+				(val) = RREG32((u32)(addr)); \
 			} \
 			break; \
 		} \
-- 
2.25.1

