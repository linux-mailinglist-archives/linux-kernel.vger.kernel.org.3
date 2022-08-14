Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1F591F08
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 10:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiHNIFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiHNIFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 04:05:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B751C11C;
        Sun, 14 Aug 2022 01:05:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c24so4229100pgg.11;
        Sun, 14 Aug 2022 01:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=rWqpd+TDL+uhqq+ZM31CgYmJ/5I6ggTeiRIyfhpx6YE=;
        b=l/H4zND9Wh9LsleFV38bwrmFAMETQ3dei02nqbrPEQvrkhn/Fo7NFXn6zZM3oca66Z
         dxpf7bLIId8OuGXf8/KlgKEHlTse4HJ9JJWFgYQQakC3KHFaJNFKSf4r07fZTh2ITGbI
         /ZqPN8tJLKWrBjlCyDXDTtwddtCZKs1wHYyahsF37u2TYduFpYKX4TV4WwkOH7p0Otlo
         dvUmdgeQARI21JkRN/hstcFfHE/iO4Dt7XBad2lRXDgXkDA+jqh9UZFY/5Bv8sBl59Yh
         u6/wzAYEXig+/+dj1erB+v2YtTgzAwlTOg3w2GgF2Vp+O/ewzAZ6wkWV45gP8flej8HE
         YMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rWqpd+TDL+uhqq+ZM31CgYmJ/5I6ggTeiRIyfhpx6YE=;
        b=1E5XJ557rtf5zLoSn/ecdgR2RknIZ3Tq0AgKg+iJISKc1jVKpMBDPjwQmOX6DO6TJx
         dMshvQV9JJADBflPBzT1lsfVLUt4fACk4JMoKTq8a7MKTDvy5E8vFr8WyGz+ZI3jRPbL
         KYXibKiwOTU8mFW+TQovREXXUDaaflaMWlQJQoG9fLeGBl0v3z6hUn14FvqBb6TpBpxP
         WMY23OAVDWgbyhHtTtdVLuP/z/O8RSiioFjNMPzlQY/3N2vHVd+xWbsIuI8hYy2YyynN
         6tNOMRfDCRjf9njfP6sY8DF/cqkA5X5EUmk4udvy4/4+3BB4G/ph2wAgHGF5xzmqAtJb
         M5Qw==
X-Gm-Message-State: ACgBeo3NlU7ogZA/3YUBySrcmfeNVzPG77AA4tizPOtwwlGqQj7b+taQ
        steTKRAYIaeYbuDdwDRNxao=
X-Google-Smtp-Source: AA6agR44dMyyhdx5CLh7qHEoCxg2XQP01uFUUC2ZHzsviRdJfYmkYA7pSnB/CVOgcsGZBfQVeVGwSw==
X-Received: by 2002:aa7:8e91:0:b0:52d:8ebf:29a4 with SMTP id a17-20020aa78e91000000b0052d8ebf29a4mr11407833pfr.1.1660464337507;
        Sun, 14 Aug 2022 01:05:37 -0700 (PDT)
Received: from fedora.. ([103.159.189.159])
        by smtp.gmail.com with ESMTPSA id l27-20020a63ba5b000000b0041d95d805d6sm4173032pgu.57.2022.08.14.01.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 01:05:37 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Khalid Masum <khalid.masum.92@gmail.com>
Subject: [RFC PATCH] Soundwire: Initialize multi_link with fwnode props
Date:   Sun, 14 Aug 2022 14:04:15 +0600
Message-Id: <20220814080416.7531-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the TODO, In sw_bus_master_add, bus->multi_link is to be
populated with properties from FW node props. Make this happen by 
creating a new fwnode_handle flag FWNODE_FLAG_MULTI_LINKED and use 
the flag to store the multi_link value from intel_link_startup. Use 
this flag to initialize bus->multi_link.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
I do not think adding a new flag for fwnode_handle is a good idea.
So, what would be the best way to initialize bus->multilink with 
fwnode props?

  -- Khalid Masum

 drivers/soundwire/bus.c   | 4 ++--
 drivers/soundwire/intel.c | 1 +
 include/linux/fwnode.h    | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index a2bfb0434a67..80df1672c60b 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -74,9 +74,9 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 
 	/*
 	 * Initialize multi_link flag
-	 * TODO: populate this flag by reading property from FW node
 	 */
-	bus->multi_link = false;
+	bus->multi_link = (fwnode->flags & FWNODE_FLAG_MULTI_LINKED)
+		== FWNODE_FLAG_MULTI_LINKED;
 	if (bus->ops->read_prop) {
 		ret = bus->ops->read_prop(bus);
 		if (ret < 0) {
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 505c5ef061e3..034d1c523ddf 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1347,6 +1347,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 		 */
 		bus->multi_link = true;
 		bus->hw_sync_min_links = 1;
+		dev->fwnode->flags |= FWNODE_FLAG_MULTI_LINKED;
 	}
 
 	/* Initialize shim, controller */
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9a81c4410b9f..446a52744953 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -32,6 +32,7 @@ struct device;
 #define FWNODE_FLAG_NOT_DEVICE			BIT(1)
 #define FWNODE_FLAG_INITIALIZED			BIT(2)
 #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
+#define FWNODE_FLAG_MULTI_LINKED		BIT(4)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
-- 
2.37.1

