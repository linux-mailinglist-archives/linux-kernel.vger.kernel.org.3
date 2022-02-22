Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B24BFC61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiBVPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiBVPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:22:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25552CD5E3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:22:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B79F2615E3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FE0C340E8;
        Tue, 22 Feb 2022 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645543335;
        bh=dJFaztZbOTKlwjszD+cQgkDqaaoQUaeR4abG0LlrMB4=;
        h=From:To:Cc:Subject:Date:From;
        b=DXHzm1Ojr/JdzsxpKmL+iNBWnbLZMRdxOs3Z6Lw0U0yZwOti1yflN+C6vng2Eba++
         i+vpqCBIIMuKux+/wtJht32wzJ7HVm3kE5VkuRBFdiSbB8S4Hlk7Lcgz5uZsekJXE1
         qV1Ljp+h6xRJF7YXQN/+qDTtQRuPAyRvTXZSJwAOnOfKMwOBcEePpACcjr6Vrb7HwY
         0UIwnMCgtZ54v+f+KYU6kpPC1h4J1ojPkGhkjPPWAPwBuastYyBzoktQThSsGVt4Z6
         73dHlUoFqFrUoSU0oK12YMxzPSHt9lFm48gh1/2cesQFXcKyu40FPSTA0i57xvcuN4
         Mf9izYSZYCRLg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH v2] drm/stm: Avoid using val uninitialized in ltdc_set_ycbcr_config()
Date:   Tue, 22 Feb 2022 08:20:46 -0700
Message-Id: <20220222152045.484610-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/gpu/drm/stm/ltdc.c:625:2: warning: variable 'val' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
          default:
          ^~~~~~~
  drivers/gpu/drm/stm/ltdc.c:635:2: note: uninitialized use occurs here
          val |= LxPCR_YCEN;
          ^~~
  drivers/gpu/drm/stm/ltdc.c:600:9: note: initialize the variable 'val' to silence this warning
          u32 val;
                 ^
                  = 0
  1 warning generated.

Use a return instead of break in the default case to fix the warning.
Add an error message so that this return is not silent, which could hide
issues in the future.

Fixes: 484e72d3146b ("drm/stm: ltdc: add support of ycbcr pixel formats")
Link: https://github.com/ClangBuiltLinux/linux/issues/1575
Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2: https://lore.kernel.org/r/20220207165304.1046867-1-nathan@kernel.org/

* Use DRM_ERROR() instead of drm_err() (Philippe).

* Collect tags from v1, as nothing substantial has changed.

 drivers/gpu/drm/stm/ltdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5eeb32c9c9ce..c9bc4ccb6d43 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -624,7 +624,8 @@ static inline void ltdc_set_ycbcr_config(struct drm_plane *plane, u32 drm_pix_fm
 		break;
 	default:
 		/* RGB or not a YCbCr supported format */
-		break;
+		DRM_ERROR("Unsupported pixel format: %u\n", drm_pix_fmt);
+		return;
 	}
 
 	/* Enable limited range */

base-commit: 542898c5aa5c6a3179dffb1d1606884a63f75fed
-- 
2.35.1

