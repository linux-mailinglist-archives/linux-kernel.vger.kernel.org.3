Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB24A4DAF09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355462AbiCPLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355443AbiCPLnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:43:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813B94AE2E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42D24B819DE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E38EC340E9;
        Wed, 16 Mar 2022 11:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430906;
        bh=Gh+etdguqtjz4aqGk5ePDpnviAYwBHvaLUHqkbc5x4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/Qz+qexecLXat8Hr2N/MCM+1R8gJCg05hLyhfH6solZqfL6RiYUsY93d/81lT6Lc
         y1rBEjxcZNZOEuXU45TPRUbMjhph2fyaXIuTM/bA7ptJZizExVHqGaewGtHpgLYY8j
         XPQE6w0YPUVWFH/VtqVm05/Qyx0tA9p+sy4qNKvLnVAzT/j2QYZchjqEBhOFJvydNY
         YK+u3NdK7uder8W8HVK+YORafrrMQkWY/0LKRdmBLdWz9lViyY99n5O8YWK3Brl246
         zDiJMo92My+7IxtpQaYZ7GbL+M3jTtHkYX4Dss8LKN2gcNHVIA9aX0omvLvv9RSFOD
         XqqvsQrnv19uw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 09/11] habanalabs/gaudi: avoid resetting max power in hard reset
Date:   Wed, 16 Mar 2022 13:41:27 +0200
Message-Id: <20220316114129.2520107-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316114129.2520107-1-ogabbay@kernel.org>
References: <20220316114129.2520107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The default max power is deduced from the card type value in the CPU-CP
info. This value is then set in the max power variable of the device
structure.
Getting the CPU-CP info is done as part of the late init phase
which is called also during reset. This means that a max power value
which is modified via sysfs will be reset during hard reset back to the
default value.
As the max power is updated in any case during device init in
hl_sysfs_init(), this setting in late init can be removed, and the
overriding during reset is thus avoided.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 950a7d6a4a35..3cb461288533 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8329,8 +8329,6 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 
 	set_default_power_values(hdev);
 
-	hdev->max_power = prop->max_power_default;
-
 	return 0;
 }
 
-- 
2.25.1

