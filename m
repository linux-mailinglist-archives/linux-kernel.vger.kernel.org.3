Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D320502CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355190AbiDOPb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiDOPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:31:23 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C755D5557;
        Fri, 15 Apr 2022 08:28:38 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EBF2DE000C;
        Fri, 15 Apr 2022 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AwUrbk9xN7kWCavabWhVUg8awWsKfRcf5Qh4VFDHSYg=;
        b=C1/bzxmQK7wcYkDQkjj6tUZVz+WVzJYTqAREMSKC5hBO0qzwINn8TsJpw8fTbJyqvAySAD
        HrZVlDHmRUeER8xta11h69T3ysCRC0QByqAc4EA3Zdm0DC233BUqJ48tA2IAUtPw1vy6FH
        UH0xzcYfJjNtM9xB8/jd7aeTzix65FOuuEdIZQDzsdJriEDfzpQznHG0t8Ba6GS1AZFBFW
        cQHqdM5JD6MkSxrleCiMjfmSnvevQaf9Re44TidY4rtgL9r/hZoNpsUJX4iUscYIijZULS
        7gHTIFXpFLj5nE0jCElaIRgl5wBt9QKUYC4A7iP9pIwWpr2JpQRjkzSegCKRoA==
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
Subject: [PATCH v4 15/45] media: media-entity: Add helper to get a single enabled link
Date:   Fri, 15 Apr 2022 17:27:41 +0200
Message-Id: <20220415152811.636419-16-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 8ab0913d8d82..dafd99486d7c 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -878,6 +878,32 @@ media_entity_find_link(struct media_pad *source, struct media_pad *sink)
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
index 742918962d46..ee87224d4a89 100644
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
2.35.2

