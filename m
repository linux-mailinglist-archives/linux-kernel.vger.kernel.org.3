Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8A484FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiAEJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbiAEJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:02:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29716C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 01:02:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q14so365752plx.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7paFOjR8m7HOb+sz9hC54Zc05xSSZt8Wcs+DKe0ERcU=;
        b=lDxJLTIC/CCDEUw5ofBdSPXs6MsGpm3H55V4nZaW8WRlH5GGG/OZB/sEKFs35wln83
         B8aYROhGOlQlFBAG86G0rc1Y5yLKcE/8UPA/KtkfSTmHR335+IP6df76V/uwibj0uc79
         BeZ39er5QWW8Zkd7Cj9PIMZ6pxQFlw4uCqj2Hl0daIBcG4S5HfZZ0HB19LxDJMGpv8Bj
         9mNi2pya97SfjnnRptMerFekVn8vIFP7ikENHj6q7FPQpRC4brh/xRAzmnoke3jLBkrb
         C5wnojanUSHtF5Fmoz0yEYbfjcpa7cw4D4y3G3Ly9m0xA9sIBhBeu07u3p9LAkblKbAv
         4cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7paFOjR8m7HOb+sz9hC54Zc05xSSZt8Wcs+DKe0ERcU=;
        b=XAc2T0mLDaB+0LZzDNVxkFR+v60mONs1BYufQ8uekurrwjAN4M9NLYFPQ6tjWLn60Y
         D4FJb9ecxAwGTFUdnecsRUHkmsmEfSnMuuSN8B3CYipl5k3Lj9y3r3Z4iwddy/VvxQwB
         lll8MWTvzEa+Y/f6QwR4zy034dCcUenv05Rb5vpOazoVlr2MmqtwYjrzv8Bu1cKT9kXr
         lDNZ117beHZHcuyiSzvFOICaFvAnZQxZo/65eDgXk0rhLdDNwf0E7U85eJPgsyXuubfP
         ewt93DTrzMbBWndL6duRDhVE1ppW6y2mynXFSS+PUnqqAos2TRNDhNgFdNFIf7vpS6Qe
         sJgQ==
X-Gm-Message-State: AOAM532UTv0HTkCnCyA2YIh12Y5Te3FieL39ypYzfb/0QBbfRNDx/EtI
        LlFbbk7MG7s2wQlNLzUE+Po=
X-Google-Smtp-Source: ABdhPJxCNLuRpiVZBvA7IBuRK5Cl7DwnRdWT+9r6cfwUWLPahAV74RUPshxG9RbNNbrHkYHRWmxjmg==
X-Received: by 2002:a17:90a:f283:: with SMTP id fs3mr2841516pjb.103.1641373350769;
        Wed, 05 Jan 2022 01:02:30 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f10sm49809816pfj.145.2022.01.05.01.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:02:30 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: ti: Add missing pm_runtime_disable() in probe function
Date:   Wed,  5 Jan 2022 09:02:20 +0000
Message-Id: <20220105090225.20507-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().
Add missing pm_runtime_disable() for serdes_am654_probe().

Fixes: 71e2f5c ("phy: ti: Add a new SERDES driver for TI's AM654x SoC")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index c1211c4f863c..b77ef9e0e0c7 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -838,7 +838,8 @@ static int serdes_am654_probe(struct platform_device *pdev)
 
 clk_err:
 	of_clk_del_provider(node);
-
+err_pm_disable:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
-- 
2.17.1

