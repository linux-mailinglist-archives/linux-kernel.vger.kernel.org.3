Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30867470C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243161AbhLJVAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbhLJVAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:00:43 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC7C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 12:57:07 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so10837616otg.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 12:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wobD4Jbzi5ufjdCOWA/nVYk8n1ISd9Z61aPS0wQf5zE=;
        b=JdY2WDN2p461FkGvsxWWgssB5bJvFhZYhUHH63DdzZaOS/BF8ZQTp0ZRohildNIGfX
         alWei8hF/dOiYXd1Z9hS5CEigliRsXzQO8xzs+kxd+ajDHK3eNMRM87q4Ju4rj6fd/gv
         lYsbndjN7dSsbgrIBFXGjMTA4PdACS//XRVN3ZbYkoy1n3FT5jlT/d0jDR4IQCv9A+Uy
         KByWYGgTkvVMxsGsOL2XYtQWqLYAPwOihXIJCui3XCZ95CJhgQCB1P4mw+mNY823BKGt
         0I8P5dypvRWs2TbprRkp1owmaruN+NMkRC5sjMK6j3MfLzBbi2qubfSIZVBUZhE9ccKN
         zL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wobD4Jbzi5ufjdCOWA/nVYk8n1ISd9Z61aPS0wQf5zE=;
        b=5BznyHjcwhcSLlgAfgYpwQrJL23xM+t3Ot8EkVXozbUpT1g6+xprOVfFmKDs1pDQtp
         TIILDhp0TmtMP9Evsa2UmDkW1QQe5mZKvGO3EqmejPNlP1zsmnC0uBlibVfgqYyq+DW9
         xscUwgWQQdvRtCMBbkHM12f9F0o17EWbReqhQXvB5IiWuNgrgUc4Pvct13OSv2v9wuyj
         hr/Bm7gzAlDtvgFUS58RbNRFqGh0SFhd6/cOkjHwhOZrXbIgKOozOqUdn7TEeuK3PRS7
         pmJXZ33s5glXPRJ63QiNu5vaPBHAMvjA7W6eUAZoYV1UbHBGZ88uza2PgdM5iUsnOg8X
         1EPQ==
X-Gm-Message-State: AOAM531zeLRYQpzCh3A+bXuKrDndTY1nP/Rl4vRnDu+iS1LI+6zLSJe3
        Ot7tzdgmqTRm91FYgbRTwiE=
X-Google-Smtp-Source: ABdhPJwjZrKA3qk3BYYk+5CCrYVxJPalsMFrhHqeEmEj9Q654spZxrRQ5lvqR74363+dwnEBfK8Nyg==
X-Received: by 2002:a05:6830:314b:: with SMTP id c11mr12958654ots.224.1639169827221;
        Fri, 10 Dec 2021 12:57:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t13sm926128oiw.30.2021.12.10.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:57:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iommu/mediatek: Validate number of phandles associated with "mediatek,larbs"
Date:   Fri, 10 Dec 2021 12:57:04 -0800
Message-Id: <20211210205704.1664928-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit baf94e6ebff9 ("iommu/mediatek: Add device link for smi-common
and m4u"), the driver assumes that at least one phandle associated with
"mediatek,larbs" exists. If that is not the case, for example if reason
"mediatek,larbs" is provided as boolean property, the code will use an
uninitialized pointer and may crash. To fix the problem, ensure that the
number of phandles associated with "mediatek,larbs" is at least 1 and
bail out immediately if that is not the case.

Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Fixes: baf94e6ebff9 ("iommu/mediatek: Add device link for smi-common and m4u")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iommu/mtk_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 25b834104790..0bbe32d0a2a6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -828,6 +828,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 					     "mediatek,larbs", NULL);
 	if (larb_nr < 0)
 		return larb_nr;
+	if (larb_nr == 0)
+		return -EINVAL;
 
 	for (i = 0; i < larb_nr; i++) {
 		u32 id;
-- 
2.33.0

