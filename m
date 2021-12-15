Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AE547642B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhLOVE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:04:27 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:50251 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhLOVE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:04:26 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id xbRmmUOmyw2XxxbRmmRN4I; Wed, 15 Dec 2021 22:04:23 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 15 Dec 2021 22:04:23 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/omapdrm: Remove a useless bitmap_clear() call
Date:   Wed, 15 Dec 2021 22:04:20 +0100
Message-Id: <df026c2dfeb096dbf551025bae2a4da395dad38e.1639602203.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'tcm->bitmap' is kzalloc'ed just a few lines above, at the same time as
'tcm'. There is no need to initialize it another time here.

Remove the useless bitmap_clear() call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/omapdrm/tcm-sita.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/tcm-sita.c b/drivers/gpu/drm/omapdrm/tcm-sita.c
index fde0208ec01e..e2c7340c5ac4 100644
--- a/drivers/gpu/drm/omapdrm/tcm-sita.c
+++ b/drivers/gpu/drm/omapdrm/tcm-sita.c
@@ -239,7 +239,6 @@ struct tcm *sita_init(u16 width, u16 height)
 
 	spin_lock_init(&tcm->lock);
 	tcm->bitmap = (unsigned long *)(tcm + 1);
-	bitmap_clear(tcm->bitmap, 0, width*height);
 
 	tcm->map_size = width*height;
 
-- 
2.30.2

