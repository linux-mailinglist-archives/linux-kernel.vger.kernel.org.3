Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91C159150B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiHLRo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHLRoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:44:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D46710FF8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:44:21 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s206so1364855pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=eg4O+lUqSgQjO8nXVbPprUy9GOqPze3ptelQzcMBZ3E=;
        b=dgbQUeUBzObk/twVOnvdV2e4rxd1DIB2foGp9FDqbzd3U/rLQxAjKY/go2bZAqy7re
         bnQgLOn7k+f+di33ZH0eQh5u168u2s0sfnZvfjsGN0BnVFN6Lh+WtNHXKFeQ/iWxstxo
         wiIhtBoiHXZbtT6bxCyVBRx9AhL8z/TFlv3djQGDKx6ir9rTHz+OIVd2QoWBEJtFrqIw
         1siruUlQRX3mejoJ3L+j7abj6vk9oCqRlt+YcfCg5wV7FfBjpSi2Nyx766leAm7c/fWx
         mvcESQmUlDRnUHFNKbzZMSNrrJnqu/0CcbbQPHg5OAsxpGaTI3FLHgaIUUCvzIum2MCj
         UEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=eg4O+lUqSgQjO8nXVbPprUy9GOqPze3ptelQzcMBZ3E=;
        b=DMXhUzMwlJBHxdY5KH9SaPM+87gU2lKdZyZiBdwPBLeiCQfJ8dnGOxpHZOpb//anM5
         4BNIlIR+1VXSk7n1iIZ7rrEXZ3PA58gN52ILszvhd71aJjm3lP6lf3I79qdbQtPWSeiy
         hMQ6O17xXJk9SvAkLptOs0CAPA+jEKUSO0d8cp/xQ9vAgaPFsNhXgM1DZoywv64UcBSQ
         Tq0UXw2esD2YcF5lY2cuNwjMZQrol7kfCvdXojOBBYkuspFwkF2qb+6bcx4NlqKi6jzB
         tB7dlfgzobm2zRFuC/YRUYkXR1tx2YLZi8uvAvjJORdn9lzGZf7ePgKwtxXwecN4H3AU
         fEng==
X-Gm-Message-State: ACgBeo0apBeZ5P0cD1qqJCk19nKnX3DBNrIkqNJVGbqJdVq4D4wTB+dY
        NOjaAcQzbDcYH2Mps7StIF5JHep4LisGZA==
X-Google-Smtp-Source: AA6agR7Dyd+8rj/dm58maQ2aj+yUNIPdvdd8c5R3h1OiaobrEVcOKAVBj0ukowd0+VHQYAKAho49QA==
X-Received: by 2002:a65:648e:0:b0:41d:fc09:4a5c with SMTP id e14-20020a65648e000000b0041dfc094a5cmr3930463pgv.262.1660326261083;
        Fri, 12 Aug 2022 10:44:21 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c20100b0016b81679c1fsm2023174pll.216.2022.08.12.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:44:20 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH] of: irq: Export of_msi_get_domain
Date:   Fri, 12 Aug 2022 10:44:20 -0700
Message-Id: <20220812174420.2706827-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Export of_mis_get_domain to enable it for users from outside.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20200122104723.16955-1-peter.ujfalusi@ti.com
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Peter tried to resurrect this in 2020 (c.f. Link tag in log) but it
didn't work.  Here's one more attempt.  I need this enable building
some TI DMA drivers as modules.

 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index d22f605fa7ee..c9308baa32c5 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -727,6 +727,7 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_msi_get_domain);
 
 /**
  * of_msi_configure - Set the msi_domain field of a device
-- 
2.34.0

