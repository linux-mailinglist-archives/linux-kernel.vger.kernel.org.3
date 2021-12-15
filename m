Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE49475A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243171AbhLOOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:06:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44178 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbhLOOF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:05:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DEA3B81F22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959A7C34604;
        Wed, 15 Dec 2021 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639577157;
        bh=1NuavhntQUo/VcwMMfGjnpaSHV6QBbtUfg21sOkWXoM=;
        h=From:To:Cc:Subject:Date:From;
        b=HiTkbhY7CsTUo50jbkpMqVTBPIqvuxsXgNd1VD6uOEB3qthX27PgoUzer/QZ9dy5r
         g0gzDcoUF+T4WpOwOpKPYCCXuzRbqyyzTCjVWp8bquSrTxHRG6HVNYoo2uqg2jP9lb
         g4tFnIgmw2PYrIWFHtIn7e92c5CGex02DmglizF08OK0HbLKRBN284Nkg6cQranbiU
         uvSIFkp+qmQ59VuiAoTOiIGX9W+5mEfsBLkQ67ImufLJYk58sxBcfxbG9atzkVj0tM
         +W8itCY4AaVhHM6Z+P3MP1XmM8Hus3ZLT3HvDui84JgkQTuw4ei2ZDRV7UNV3mKSjQ
         nOa2kGPo/x1lQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Krastev <krastevm@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: fix size_t format string
Date:   Wed, 15 Dec 2021 15:05:40 +0100
Message-Id: <20211215140552.581719-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On architectures with size_t different from 'unsigned long', gcc
prints this warning:

drivers/gpu/drm/vmwgfx/vmwgfx_gem.c: In function 'vmw_bo_print_info':
drivers/gpu/drm/vmwgfx/vmwgfx_gem.c:230:40: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
  230 |         seq_printf(m, "\t\t0x%08x: %12ld bytes %s, type = %s",
      |                                    ~~~~^
      |                                        |
      |                                        long int
      |                                    %12d
  231 |                    id, bo->base.base.size, placement, type);
      |                        ~~~~~~~~~~~~~~~~~~
      |                                     |
      |                                     size_t {aka unsigned int}

Use the correct %zd modifier.

Fixes: 8afa13a0583f ("drm/vmwgfx: Implement DRIVER_GEM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index c016c434b6cb..3d4d703b20a8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -227,7 +227,7 @@ static void vmw_bo_print_info(int id, struct vmw_buffer_object *bo, struct seq_f
 		break;
 	}
 
-	seq_printf(m, "\t\t0x%08x: %12ld bytes %s, type = %s",
+	seq_printf(m, "\t\t0x%08x: %12zd bytes %s, type = %s",
 		   id, bo->base.base.size, placement, type);
 	seq_printf(m, ", priority = %u, pin_count = %u, GEM refs = %d, TTM refs = %d",
 		   bo->base.priority,
-- 
2.29.2

