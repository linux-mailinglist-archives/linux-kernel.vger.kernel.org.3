Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5254555224
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358862AbiFVRR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358735AbiFVRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A051A1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A64BE61BA6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16193C34114;
        Wed, 22 Jun 2022 17:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655918271;
        bh=X5zHmARP4o9w5Als0RrcdIqb8TjGKy4BRH9KZCUBEl0=;
        h=From:To:Cc:Subject:Date:From;
        b=ciH6giKXozyPDS82RKGfyWHSbyB1w1IbONC/j50IW0bii2dJ5MsURoITpKeFXMwvI
         IX71ob3yU28+KUS32zrFV/IsX6533KbkkmBBchnAo+88MHh7VbxNDmeJl4t1fa4zo5
         SXtPJB7/35lwE+1zigwGcPNXJgveUnZUSJQDCNF5L3OsPeK7DX9VLrnuM5s1RX8F/B
         /A17Y/QJYmmr+hyeSXmsM9RuatYmTZ0Lmw7gHkw5p/bGdQBFuCB6+6GOulgYCSHCYQ
         zqnF/qBvHKg5HkUosAYeo2LUGCEumMOo2FnlA04TPBkc74F4LeXALkNf9sMbV9m+Y6
         i3ks+2GwfJNhQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dong Aisheng <dongas86@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] regmap: Don't warn about cache only mode for devices with no cache
Date:   Wed, 22 Jun 2022 18:17:23 +0100
Message-Id: <20220622171723.1235749-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; h=from:subject; bh=X5zHmARP4o9w5Als0RrcdIqb8TjGKy4BRH9KZCUBEl0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBis06B5RFEDqmaW/J9L4VaTdUXHiSq04nH81ud5S2y 9cCC/1OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYrNOgQAKCRAk1otyXVSH0DxSB/ 92mPU+4++0OlnB7T9dw5w6e+cmCQx8WhRmHJe4OJg0iPdY3bO3rqDgmaMFVkO431fKsdmMB3OyTDfP X4dd7wADpPn1oqtkPWPN1G4A1gLK1fTpUX0ftwp2ZQtroXqDuMTjOpydzXrFn4aTY7BT94L+73RyAX AC+qIshQsrLkEWx6vRAkR2xbZ6gUAt2kwOa/MUJELhYhzAeFYAiyqbiFDbym2CAjqjmEyx17fIKg5q 8HgCD0p1WPNfQnA5BhlRlvN1ZLVQL73QoYaF8UoR+TgJlPFWJtDDOA0s3p2qotR0XUyVE4GOn9c18A JDQJJjUxmyEszG/Tox2z5Xv8qW0syP
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices with no cache it can make sense to use cache only mode as a
mechanism for trapping writes to hardware which is inaccessible but since
no cache is equivalent to cache bypass we force such devices into bypass
mode. This means that our check that bypass and cache only mode aren't both
enabled simultanously is less sensible for devices without a cache so relax
it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 2eaffd3224c9..ef62ec225d81 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -495,7 +495,8 @@ EXPORT_SYMBOL_GPL(regcache_drop_region);
 void regcache_cache_only(struct regmap *map, bool enable)
 {
 	map->lock(map->lock_arg);
-	WARN_ON(map->cache_bypass && enable);
+	WARN_ON(map->cache_type != REGCACHE_NONE &&
+		map->cache_bypass && enable);
 	map->cache_only = enable;
 	trace_regmap_cache_only(map, enable);
 	map->unlock(map->lock_arg);
-- 
2.30.2

