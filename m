Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB64248B295
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbiAKQuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiAKQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:50:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED33BC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:50:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38A86CE1ADB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 16:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579E6C36AEB;
        Tue, 11 Jan 2022 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641919826;
        bh=0imZngBEOEg5DCWHqSz0++mXWfrfZRG3aewehqBLgBc=;
        h=From:To:Cc:Subject:Date:From;
        b=XXbWddSK4zM17INboM9caeOUe4oWtEDTAmT19S1wDhKZL2c9GNyPp7VevE4I6eMj/
         qysxS8EbOLCe29YyMDwK9Bfb1CuZIG6F+WJo0NHpicBBXiu28BEJ4e49LKGpK2HZF/
         5h89citLifD3BZNIui9fbtujth+bKm5auq4f8f7MBJYuXC0ByYbT4+vedmaa8HdHjS
         tuEyrs83thFOzbI5cIK8UebwO6Jvp9p5M2JCU04ZHrMAbuXX2GEgnh0iioGJfk3hpq
         qu7jc0Hvgi/3ITnOJreBjZkTqUzRlC8ubRBvWrIuJyEF68ZHSDjX4l0xMZw/d9HVdJ
         LCh0cLq+t/ozg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] pcmcia: Guard yenta_dev_{resume,suspend}_noirq() on CONFIG_PM_SLEEP
Date:   Tue, 11 Jan 2022 09:50:04 -0700
Message-Id: <20220111165004.1764190-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building without CONFIG_PM_SLEEP:

drivers/pcmcia/yenta_socket.c:1322:12: error: ‘yenta_dev_resume_noirq’ defined but not used [-Werror=unused-function]
 1322 | static int yenta_dev_resume_noirq(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/pcmcia/yenta_socket.c:1303:12: error: ‘yenta_dev_suspend_noirq’ defined but not used [-Werror=unused-function]
 1303 | static int yenta_dev_suspend_noirq(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

SET_NOIRQ_SYSTEM_SLEEP_PM_OPS evaluates to an empty macro when
CONFIG_PM_SLEEP is not set. Every callback in yenta_pm_ops depends on
CONFIG_PM_SLEEP to work properly so just guard this whole block on
CONFIG_PM_SLEEP, rather than CONFIG_PM, which CONFIG_PM_SLEEP will
select.

Fixes: 3daaf2c7aae8 ("pcmcia: Make use of the helper macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/pcmcia/yenta_socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 837877daed62..3966a6ceb1ac 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1299,7 +1299,7 @@ static int yenta_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return ret;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int yenta_dev_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);

base-commit: fbb3485f1f931102d8ba606f1c28123f5b48afa3
-- 
2.34.1

