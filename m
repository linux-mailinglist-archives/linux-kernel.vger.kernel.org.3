Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BCB55EA13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiF1Qni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiF1QmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:42:14 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37AD021839;
        Tue, 28 Jun 2022 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nt05P
        26I+/2qRv1d4aL/V6BIimpJ94Vgajr7RbdM3fE=; b=ixESMC2SVpxKnKjcPuT8d
        Ii/rwpVHzGEpzqphF/mLkA0jWuafIfBAEc4pprTg0Da702z3zDxAVs77ChpRvJTc
        yDl6xSKoIqyyDW2kVnFGK5LesGsklIRc2uQM0XlCk8oLf1iENODHH0NlNyOqK+Vh
        xAWm+0Q7+jlaIk8VdJKgJ4=
Received: from ubuntu.localdomain (unknown [223.73.235.3])
        by smtp9 (Coremail) with SMTP id DcCowAAnhwySLrtiwy+mLw--.51135S2;
        Wed, 29 Jun 2022 00:38:50 +0800 (CST)
From:   Guiling Deng <greens9@163.com>
To:     daniel@ffwll.ch, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guiling Deng <greens9@163.com>
Subject: [PATCH] fbdev: fbmem: Fix logo center image dx issue
Date:   Tue, 28 Jun 2022 09:36:41 -0700
Message-Id: <20220628163641.4167-1-greens9@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAnhwySLrtiwy+mLw--.51135S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW3Zr1ktw48WrWfAFy7Wrg_yoW3ArgEkw
        4jvF97Zr9Ik3WIkFnYk3W3AFZayrWfZ3W3u3ZFkrykCF9Fgr4rXr1UZrsYqayagwnrXFZF
        qwnFqr48WryfCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRltC3JUUUUU==
X-Originating-IP: [223.73.235.3]
X-CM-SenderInfo: pjuhv0jvz6il2tof0z/1tbiURou3GDEOaLlSgAAsp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Image.dx gets wrong value because of missing '()'.

If xres == logo->width and n == 1, image.dx = -16.

Signed-off-by: Guiling Deng <greens9@163.com>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index c4a18322dee9..1fd2bdb11266 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -511,7 +511,7 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 
 		while (n && (n * (logo->width + 8) - 8 > xres))
 			--n;
-		image.dx = (xres - n * (logo->width + 8) - 8) / 2;
+		image.dx = (xres - (n * (logo->width + 8) - 8)) / 2;
 		image.dy = y ?: (yres - logo->height) / 2;
 	} else {
 		image.dx = 0;
-- 
2.25.1

