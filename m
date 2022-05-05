Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B7651B744
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 06:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbiEEEyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 00:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243127AbiEEEyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:54:14 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723192314C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 21:50:32 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u18-20020a170902e21200b0015e5e660618so1737164plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 21:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aaLeQx94OzKlMeJnpwdtHsiW+D9Y9/PlRf6bEzbVUSs=;
        b=Y/Me6uZVm5lLfHLAI+Hter7HNsHr60x7+4Hi/q4ybb9MyX3tTDWbQ9w7G+Kj+vVSd7
         LhLXZNKN02pf4SmfofgybeZ1DYwbiey6lhCU6CRVyYLDj04oQrr9UDhLWeX7m1rcjdI6
         KFHB0OJbijcgXM+ZhA2vtpborw0LvvTSMnQ5gSspNApleWjUSFvidXwJ+MMKIjlGuWdH
         R1FGgCFToIt5tosQgKfMyaMN7V4wMKENwCE8l3WrjUdBFtl2Guq2CyJkHQNQ5GtnUuTm
         HBSaZ/V/j2sjELVaMN6M7o9V3GVbVs6k/LvwVoeR8r8jPZtnS+BPDhWojeIglnDZn3rj
         O1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aaLeQx94OzKlMeJnpwdtHsiW+D9Y9/PlRf6bEzbVUSs=;
        b=LqGw3k32g1BRHoiv6vxnvLpUdHt6okysJ2cjGMxLZBDH0v5KJkyAWVGyn8Q/BN2VYB
         QxdhaxhIPmaDLlwxNwD+GFby8StU+rRiB+1oOOkaaRJrAEJcGDt0FB+MaWiV2u6dtbj7
         LyPGGa4eU6BCqOKcaDQQhL8hp0NpNZfLhrLfDzeP62S2GIfikzvphlOgN0l0JQRBLGSP
         szqzE5a2x4V34DStcM6KF/3vMOgM5//9L/3wpdjhA+Ytfz+5Nphdtw9PhaecOhjZcRZS
         kRdxAxDYW5m5cC4wTfav5uSIO4OS7rPHpP5Ynynqx9yuPZ43KQkgqgKwdqy1W7UmuN4w
         xOTg==
X-Gm-Message-State: AOAM532pHOYAxbk7DhZEclEMgS9AWgtTvNHbeT6Iu11TcP/KKf3YoJjX
        wrROZFGWvoKB+5qVNF08s3ju3rU=
X-Google-Smtp-Source: ABdhPJyzuZlnnrigT/cb1rTzTVwtvPoydUWr/ASpJgtWKpNRGiO6RQr1rnm+NKeDEvU+W+Umd7UYPlk=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a17:90a:db51:b0:1dc:9da2:793b with SMTP id
 u17-20020a17090adb5100b001dc9da2793bmr3830044pjx.77.1651726231886; Wed, 04
 May 2022 21:50:31 -0700 (PDT)
Date:   Thu,  5 May 2022 04:50:01 +0000
Message-Id: <20220505045001.363548-1-ovt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH] dma-buf: add option text so it can be enabled by users
From:   Oleksandr Tymoshenko <ovt@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Oleksandr Tymoshenko <ovt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3b32a592ea6e4 ("dma-buf: drop option text so users
don't select it.") to allow users select DMA_SHARED_BUFFER option
explicitly. This is required for out-of-tree modules that depend on
dma-buf functionality, for instance drivers that rely on Google's Gasket
framework.

On general-purpose Linux systems the option is usually implicitely
enabled in the default kernel config by subsystems that use it but
systems with smaller kernel footprint have to rely on side-effects
from enabling unrelated options to get dma-buf functionality built.

Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 drivers/base/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 6f04b831a5c0..108bf9b38ce6 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -198,7 +198,7 @@ config SOC_BUS
 source "drivers/base/regmap/Kconfig"
 
 config DMA_SHARED_BUFFER
-	bool
+	bool "Buffer framework to be shared between drivers"
 	default n
 	select IRQ_WORK
 	help
-- 
2.36.0.464.gb9c8b46e94-goog

