Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EED5343DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbiEYTIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbiEYTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:06:55 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C088311807;
        Wed, 25 May 2022 12:06:46 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 139EA1C000A;
        Wed, 25 May 2022 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShnSBA6h1ZBG7xxW8nZ//1YX0cs8S1JRXO0VG9uh+xg=;
        b=kk7s4W/ruFrG7csXC5kJYlaPv6OlQIo9avRpAJ4vEhHmVtCwoR0vIIK9Bw7Z0+VxAD9blu
        ifX0C9UQ699/HUuJUu2IZFZBr/Hm9GV+h1rrZE/U4xpbLGZ7HiuCdcfQEKNWtdj1CV4sUU
        AaNOLWNm2yaepE1vjnBPPo8RIlfIGroRGuCZE1ComIcep8u00PUC+B6aH2gLDAY8VR0EZw
        DpUg+7dNNCFshBdK6u34STg6Yy0ApZse1ZrbIm9K0dsCUAzVM1cbHsAEBiionDvzuIQx8i
        cP3J68rIcWG5Bpvw9K3yXbHa7M7EcAQhr5Zp+2W+rQbf97XXoCOhYIXsc+c7uQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 16/44] media: media-entity: Add helper to get a single enabled link
Date:   Wed, 25 May 2022 21:05:49 +0200
Message-Id: <20220525190617.696344-17-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
References: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a situation where multiple links can be connected to the same
pad of an entity, drivers might need to ensure that only a single
link is enabled to apply appropriate routing (when the hardware can
only use one at a time).

Add a helper to return the single enabled link of an entity given
a specific pad index, which errors out when zero or more than one
link candidates are found.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/mc/mc-entity.c | 26 ++++++++++++++++++++++++++
 include/media/media-entity.h | 13 +++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 11f5207f73aa..5387bd5f4cd7 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -900,6 +900,32 @@ media_entity_find_link(struct media_pad *source, struct media_pad *sink)
 }
 EXPORT_SYMBOL_GPL(media_entity_find_link);
 
+struct media_link *
+media_entity_get_single_enabled_link(struct media_entity *entity,
+				     u16 pad_index)
+{
+	struct media_link *candidate = ERR_PTR(-ENODEV);
+	struct media_link *link;
+
+	list_for_each_entry(link, &entity->links, list) {
+		struct media_pad *pad = link->sink->entity == entity ?
+					link->sink : link->source;
+
+		if (pad->index != pad_index ||
+		    !(link->flags & MEDIA_LNK_FL_ENABLED))
+			continue;
+
+		/* Error out with more than a single candidate. */
+		if (candidate != ERR_PTR(-ENODEV))
+			return ERR_PTR(-ENXIO);
+
+		candidate = link;
+	}
+
+	return candidate;
+}
+EXPORT_SYMBOL_GPL(media_entity_get_single_enabled_link);
+
 struct media_pad *media_entity_remote_pad(const struct media_pad *pad)
 {
 	struct media_link *link;
diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index a9a1c0ec5d1c..63c1436ffacf 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -847,6 +847,19 @@ int media_entity_setup_link(struct media_link *link, u32 flags);
 struct media_link *media_entity_find_link(struct media_pad *source,
 		struct media_pad *sink);
 
+/**
+ * media_entity_get_single_enabled_link - Get a single link for an entity pad
+ * @entity: The entity
+ * @pad_index: The index of the entity's pad expected to take part in link
+ *
+ * Return: returns a pointer to the single enabled link with the entity's pad.
+ * If no such link exists, returns a pointer error with %-ENODEV.
+ * If more than a single link exist, returns a pointer error with %-ENXIO.
+ */
+struct media_link *
+media_entity_get_single_enabled_link(struct media_entity *entity,
+				     u16 pad_index);
+
 /**
  * media_entity_remote_pad - Find the pad at the remote end of a link
  * @pad: Pad at the local end of the link
-- 
2.36.1

