Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61E35A7182
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiH3XQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiH3XQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:16:26 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9090361D47
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:17 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b142so10578983iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9y7lXZfKic1LpjpQXIA9tlb8KUkVBW2jlGcm93skgJQ=;
        b=NcJfK/oaE+ozKaG0LkF54DJtrz2QVlpP3O6ijlLw4aPafT/KGp1lHiHSpirPVul/pi
         8MgftYJtdSiaGFqZ5tpZX1dfUJfdfvncN+Lgg2crIJX0tU73PGyk2jSydcAYdUF6CQg9
         N1XCIrmJSzZV3tPTWDO3lezzc66SBBeCWJQ+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9y7lXZfKic1LpjpQXIA9tlb8KUkVBW2jlGcm93skgJQ=;
        b=turJaIbna+fwHxPCAf7Pbv0i0VnRYABWkOWLGmAb1HOozRvlz59hJ74N6MInZiyJaI
         OHbkgj8l4M6Gh3zyG/o2/q1TzkKOnHzJzfApAHlMEt9koOu//oEv7TZoDNummyldOq0P
         ORyOh/7Z4nHfPKr05D1dz6uP97hBvm0omMUmVx3H5v4zwRY2TyJoLxMoWtKr9VlcybhG
         yOxB4A21DejRbYWO5Z+rDwNU+5sh5qcuDSqeWGVfwCYGpVBGHjJMCYDSVAN5fS4yxN0O
         1O7QKglnFoX2QtU1MtjyD455NSYD5BEG37+cTyDg4KbTYEemAP0CutWnV9Mr7Hbgqza9
         62FA==
X-Gm-Message-State: ACgBeo13G3j5OvBhVKiYkfPPl2zQ6cYpMHlHf9FGSnpUajj/oR0GTAFF
        stJUqFGwArqFNBxqHKVE9C/baQ==
X-Google-Smtp-Source: AA6agR5O6/8tXAxW3fbQdsvlk23iJZe+hw4eqjCS74ugbqYtFuBc+Z/YJhAGmZm8FSUp1ousJAgNLg==
X-Received: by 2002:a05:6638:1456:b0:346:856f:f3c4 with SMTP id l22-20020a056638145600b00346856ff3c4mr13545825jad.179.1661901377151;
        Tue, 30 Aug 2022 16:16:17 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id z30-20020a056602081e00b0068b1858c81asm6165821iow.13.2022.08.30.16.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:16:16 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     hdegoede@redhat.com, mario.limonciello@amd.com, timvp@google.com,
        rafael@kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] Input: elan_i2c - Don't set wake_irq when using ACPI
Date:   Tue, 30 Aug 2022 17:15:39 -0600
Message-Id: <20220830171332.6.I7309b8f322082437b93581c6e2953886eeb998d7@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220830231541.1135813-1-rrangel@chromium.org>
References: <20220830231541.1135813-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-core will now handle setting the wake_irq for ACPI systems.

I didn't delete the whole block since this also covers systems that
don't use ACPI or DT, but I'm honestly not sure if that's a valid
config.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/input/mouse/elan_i2c_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 7d997d2b56436b..d434c8ff8c4ca2 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1333,10 +1333,10 @@ static int elan_probe(struct i2c_client *client,
 	}
 
 	/*
-	 * Systems using device tree should set up wakeup via DTS,
+	 * Systems using device tree should set up wakeup via DTS or ACPI,
 	 * the rest will configure device as wakeup source by default.
 	 */
-	if (!dev->of_node) {
+	if (!dev->of_node && !has_acpi_companion(dev)) {
 		device_init_wakeup(dev, true);
 		dev_pm_set_wake_irq(dev, client->irq);
 	}
-- 
2.37.2.672.g94769d06f0-goog

