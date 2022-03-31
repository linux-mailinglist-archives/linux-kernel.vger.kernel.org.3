Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C814EE3BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbiCaWFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbiCaWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:05:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7389D43391
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:03:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b15so874794edn.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g06L8lJBLjLYpTtLuAhJfyTVoQvqpjZZgd66GLledb8=;
        b=kFo+esT7qNOBc9YXt4W8NoFYL/ltieWci209TPLEWjxH33b72tGFTvanL7qy3G+qtQ
         St+gfSTzh2TVucNnXZTfMRLGUW+Pqw2RB3DBuQeLhpqmxKmzls3ph1O5V4zuGew+BdZ2
         xkXv8fkmVhs9zucE66AM5ajmgxafkqRRSUoMWa4bOd48nvtxN1ZSPUFuhUyBCDTqLagA
         y/GBzIhKPkkExOfPTQdEUbDhRGgE0fOqNpkGsYxRzM+/DEvlvnx168rBT/9YWPsym8f6
         sg8pFiB+vcDuP62PlshwT8TKfxnsOHZCdweA55g2Ji8cU2CH7tHuTn304Rj1EKnENmmC
         MeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g06L8lJBLjLYpTtLuAhJfyTVoQvqpjZZgd66GLledb8=;
        b=YG4gw34IlHWZvvZUbQM+183aXHnU+EIoIhpEZmz9JYSFaTidOhUve2Waogm5oglj2Q
         RsDcvwk6aez8A/JMSc/MUQvbXgRJbo16CStapAbYjPCtvInzE/58LhVVzOMzi2TwNkpy
         qE3yAVaDAjX4YQjghz6Foz5Tj7DW7hiIbakQUTWGfaaRPDliIQ4i5M1uLDag95KP6ZiF
         2cO09Wha+m74LzSEZvUWzCqt3IorNT8Ryb2PdrbkhpQxkZVnmzu6d53XO3twYX6EokdA
         reL+zJ9sSWPBzN7lxI3halDYTXnz8Syc7axjqmft1KO438jTL74617EPWhf/30NE8XC3
         i7TA==
X-Gm-Message-State: AOAM531NhWuXk15LaITXVTunVlmgXkaxvy/PxI4CXDvQrzAHUvJOIfzL
        ql9G5qHc6HDJajafO9ForUc=
X-Google-Smtp-Source: ABdhPJwCH+OkQyo2XKVNWbEL35S6WpC2JL9Zv8VMjXcUGl4e9aJJrg5dIUbzSnOjO+lbBJjllHNdBQ==
X-Received: by 2002:a05:6402:1742:b0:419:2707:747a with SMTP id v2-20020a056402174200b004192707747amr18500745edx.238.1648764200063;
        Thu, 31 Mar 2022 15:03:20 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id sb15-20020a1709076d8f00b006dfe4cda58fsm247312ejc.95.2022.03.31.15.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:03:19 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 2/2] dm: replace usage of found with dedicated list iterator variable
Date:   Fri,  1 Apr 2022 00:02:36 +0200
Message-Id: <20220331220236.884887-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331220236.884887-1-jakobkoschel@gmail.com>
References: <20220331220236.884887-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/md/dm-table.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 03541cfc2317..9cf87954c05a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -424,17 +424,16 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
  */
 void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 {
-	int found = 0;
 	struct list_head *devices = &ti->table->devices;
-	struct dm_dev_internal *dd;
+	struct dm_dev_internal *dd = NULL, *iter;
 
-	list_for_each_entry(dd, devices, list) {
-		if (dd->dm_dev == d) {
-			found = 1;
+	list_for_each_entry(iter, devices, list) {
+		if (iter->dm_dev == d) {
+			dd = iter;
 			break;
 		}
 	}
-	if (!found) {
+	if (!dd) {
 		DMWARN("%s: device %s not in table devices list",
 		       dm_device_name(ti->table->md), d->name);
 		return;
-- 
2.25.1

