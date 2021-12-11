Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC22B470F64
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 01:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbhLKAZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhLKAZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:25:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DA3C061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Ggz87hFziXlCZUJuyehYGdwi+FztQdC7fGKcUudu1UU=; b=X3KlkOavsHzhCTs7O+1C+rtoK8
        9TokGztQBeYv6bbbJRKtkTDU2zqQsxZZmzDBEPEZPSH/svGcP10oAqP7LY8av1AbHMYCM17lli0+P
        d3ntRuTZYcKhL+f7yxvJDcQYg5DxfK7+LgL4rmRQYj3HtBx6g2kNnXKlD3FfgwJVh1K3feYUQDsM1
        dUdfpmukVNTdJevYh+OHFDjlqiv92nKOVcVl5cZgaue/JdMFZuvJj0Sfg7h8ifAKpNFtCKhcNHYBj
        ST3wIwd2vP7cDUQH43G41ryhtJTnh/Czk0IkgLg/3W7r3Ti/wBXTOU3MJc1p/zUKP4k0TxzilStLY
        Vk+qZyQQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvq9V-004La3-8j; Sat, 11 Dec 2021 00:22:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Zack Rusin <zackr@vmware.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Krastev <krastevm@vmware.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH -next] drm/vmwgfx: use %zu to print size_t
Date:   Fri, 10 Dec 2021 16:22:12 -0800
Message-Id: <20211211002212.31408-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent a build format warning by using the correct format specifier
to print size_t data.

Fixes this build warning:

../drivers/gpu/drm/vmwgfx/vmwgfx_gem.c:230:33: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Wformat=]

Fixes: 8afa13a0583f ("drm/vmwgfx: Implement DRIVER_GEM")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Zack Rusin <zackr@vmware.com>
Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Martin Krastev <krastevm@vmware.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- next-2021-1210.orig/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ next-2021-1210/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -227,7 +227,7 @@ static void vmw_bo_print_info(int id, st
 		break;
 	}
 
-	seq_printf(m, "\t\t0x%08x: %12ld bytes %s, type = %s",
+	seq_printf(m, "\t\t0x%08x: %12zu bytes %s, type = %s",
 		   id, bo->base.base.size, placement, type);
 	seq_printf(m, ", priority = %u, pin_count = %u, GEM refs = %d, TTM refs = %d",
 		   bo->base.priority,
