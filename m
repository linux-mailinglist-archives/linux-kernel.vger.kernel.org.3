Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17684F4FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840029AbiDFBGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455471AbiDEQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707B580DF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:15:47 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90B3D1EC0502;
        Tue,  5 Apr 2022 17:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649171742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4rj24jI/yUMyg0PeqD763DeKOQodwsJYuc20fV3sUw=;
        b=CD0Bl5S4CUevZqWeAW+t0LZQ3sYvhujWzzjaduwde9Va4TUFNZ4EB9b76qzGjsrqOkp/0/
        1teXwyV66I5PiUvgs/OxTkvOQwZaUPhdM+k6gcfs1n64tuSx+2eDFhzHJ1ib52/R1RehGZ
        KQZ32meI6r9mYnOmXzTG54DgGaMmrrQ=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/11] drm/r128: Fix undefined behavior due to shift overflowing the constant
Date:   Tue,  5 Apr 2022 17:15:10 +0200
Message-Id: <20220405151517.29753-5-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405151517.29753-1-bp@alien8.de>
References: <20220405151517.29753-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fix:

  drivers/gpu/drm/r128/r128_cce.c: In function ‘r128_do_init_cce’:
  drivers/gpu/drm/r128/r128_cce.c:417:2: error: case label does not reduce to an integer constant
    case R128_PM4_64BM_64VCBM_64INDBM:
    ^~~~
  drivers/gpu/drm/r128/r128_cce.c:418:2: error: case label does not reduce to an integer constant
    case R128_PM4_64PIO_64VCPIO_64INDPIO:
    ^~~~

See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
details as to why it triggers with older gccs only.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/r128/r128_drv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/r128/r128_drv.h b/drivers/gpu/drm/r128/r128_drv.h
index 2e1bc01aa5c9..970e192b0d51 100644
--- a/drivers/gpu/drm/r128/r128_drv.h
+++ b/drivers/gpu/drm/r128/r128_drv.h
@@ -300,8 +300,8 @@ extern long r128_compat_ioctl(struct file *filp, unsigned int cmd,
 #	define R128_PM4_64PIO_128INDBM		(5  << 28)
 #	define R128_PM4_64BM_128INDBM		(6  << 28)
 #	define R128_PM4_64PIO_64VCBM_64INDBM	(7  << 28)
-#	define R128_PM4_64BM_64VCBM_64INDBM	(8  << 28)
-#	define R128_PM4_64PIO_64VCPIO_64INDPIO	(15 << 28)
+#	define R128_PM4_64BM_64VCBM_64INDBM	(8U  << 28)
+#	define R128_PM4_64PIO_64VCPIO_64INDPIO	(15U << 28)
 #	define R128_PM4_BUFFER_CNTL_NOUPDATE	(1  << 27)
 
 #define R128_PM4_BUFFER_WM_CNTL		0x0708
-- 
2.35.1

