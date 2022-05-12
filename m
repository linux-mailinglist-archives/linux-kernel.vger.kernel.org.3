Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD85247F7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351533AbiELIhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351514AbiELIgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:36:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E75B54
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF0860DF0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03922C34100;
        Thu, 12 May 2022 08:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652344611;
        bh=o5vc0t4cN3VhTt01w0WPWP/zm+4fUUK1vnIfe10Nm9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyaYaNbVLuBiuAlPwmvtAk9+7JA1Fwa8JX6DlmMvWp0HK3gwTH8AMLFraAh0OU57W
         yB3beK8dgeoj7LYXo1HOOx1qAXkKHhfNT3TYci3Wn0RdmqtTA9XM4J7x63kFD9iuLa
         uwRuCp6s76ykoaI2yLbMvJLaODfWluCY4/XD1mtv7XlWcC5I4ZnmiTYpv6rkKPD6bY
         z+sulTGmc3UM/kVYpp4erPcP8BWWxy/ytfIzWsOv11X0YM6YPJOpVmNzTM4nxjXF5D
         YtP5dQV+E26vuIsj4Z0RfYjDO6LA0sBeqW82AxYnIVReIwzZVF1vm9RdcQ044TCwQ8
         7+7Soi0MAObqg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] platform/chrome: cros_ec_proto: drop unneeded BUG_ON() in prepare_packet()
Date:   Thu, 12 May 2022 16:36:22 +0800
Message-Id: <20220512083627.885338-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220512083627.885338-1-tzungbi@kernel.org>
References: <20220512083627.885338-1-tzungbi@kernel.org>
MIME-Version: 1.0
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

prepare_packet() gets called if `ec_dev->proto_version` > 2.  For now, it
must be equivalent to EC_HOST_REQUEST_VERSION.

Drop the BUG_ON().

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index ac1419881ff3..db1c8ba43171 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -60,7 +60,6 @@ static int prepare_packet(struct cros_ec_device *ec_dev,
 	int i;
 	u8 csum = 0;
 
-	BUG_ON(ec_dev->proto_version != EC_HOST_REQUEST_VERSION);
 	BUG_ON(msg->outsize + sizeof(*request) > ec_dev->dout_size);
 
 	out = ec_dev->dout;
-- 
2.36.0.512.ge40c2bad7a-goog

