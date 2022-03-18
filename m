Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5A4DD894
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiCRK7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiCRK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:59:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B3F283
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:58:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so5582872pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=iD3SQVbluqBYYl9Q69vFkPZdZHA/c5gFmaZJqTpGnFU=;
        b=LB6IRGcklNnwQHkAZy+NfZBjeW2iyozb0k13pHIvTXLERYiuuiIQKxMQKG3jGjQDgH
         5XRzkxwO7s4RQAjA8UmlZ1YslJwftMpAv/RkjHvsLISVeZHtV4qqd9Bd/Js6RUpOMlcR
         vDv6K7HQ1iR2RCdmjNofYtP7kruyENxGSuGiokdOI++DeV6239nV5jZ54SbOzF5bB94t
         5rcjjahQ1gI5eW+ynRue/5Tr6szEjF4NIWPIuMeG8KwNOldqh61PB5jwfuoERXyi4hNE
         YhLwy+lgPIFL2ny4vnqdAYHj1Rw7oCXb0fYCSWjflD5vlNE45pplP5cRqitPb6OFbDqH
         4gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=iD3SQVbluqBYYl9Q69vFkPZdZHA/c5gFmaZJqTpGnFU=;
        b=sNEMWMLEamLGQvWzX6kD/GhMUej5GSqfCkPdNmqjv/MTlOVpDzLqsOKVFZV+IEQnfc
         08orZLjBZtfFbQp8Uj92JUwawYuLxNe45at2BSDBUqtjStxYOdtKxTEOYj0Mzd3cm4Ya
         OMXVyK0u8EH+EdQbfugydJHXc/jRhUIYfG/OFJlBPUALg3cAOPxeTS3a8LJNia+Ats0I
         ioNHNAChzV1b2BZ/m9VDSLQ8HRd/+WMD8JpZDT2MD0FefnZEUYO/vUI3k52N12GrpH+M
         dqIz0SvOUgA89lv7/OGoTCpD6K6skjDFXZBiERzNKgd3QUG3p6OEjJHbQxjPoVU+NT4x
         DU8w==
X-Gm-Message-State: AOAM533jxUHozjfY+nMJvZM8KaJ6UXTQjOKsVbyGh9lu1UzDO9u1rfSg
        G1UBD6cmeF66UefC9wAvMUh8a/b8bOL3WLnLzEw=
X-Google-Smtp-Source: ABdhPJz2XjBakfUvIu6Dk3uZ7H0HejvxnQ1wS/ofnXn23ahjHMcBc/HpZEz0xoC9PiU3Z1bfrlL9pg==
X-Received: by 2002:a17:90b:1a8b:b0:1bf:89c2:3a0f with SMTP id ng11-20020a17090b1a8b00b001bf89c23a0fmr10229585pjb.215.1647601079714;
        Fri, 18 Mar 2022 03:57:59 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id h6-20020a056a00230600b004fa1209e0f3sm9897718pfh.23.2022.03.18.03.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:57:59 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] phy: ti: omap-usb2: Fix error handling in omap_usb2_enable_clocks
Date:   Fri, 18 Mar 2022 10:57:46 +0000
Message-Id: <20220318105748.19532-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YjIC1hWuVN3qkdqx@shaak>
References: <YjIC1hWuVN3qkdqx@shaak>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The corresponding API for clk_prepare_enable is clk_disable_unprepare.
Make sure that the clock is unprepared on exit by changing clk_disable
to clk_disable_unprepare.

Fixes: ed31ee7cf1fe ("phy: ti: usb2: Fix logic on -EPROBE_DEFER")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- fix typo in commit message.
---
 drivers/phy/ti/phy-omap-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 3a505fe5715a..31a775877f6e 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -215,7 +215,7 @@ static int omap_usb2_enable_clocks(struct omap_usb *phy)
 	return 0;
 
 err1:
-	clk_disable(phy->wkupclk);
+	clk_disable_unprepare(phy->wkupclk);
 
 err0:
 	return ret;
-- 
2.17.1

