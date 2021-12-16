Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6F476D87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhLPJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhLPJip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:38:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50181C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:38:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE6761CF5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E02AC36AE4;
        Thu, 16 Dec 2021 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639647524;
        bh=6uDdUm7t8c9dr8lCSSGiV/upgQhtKF1tZAJg7RxaIGw=;
        h=From:To:Cc:Subject:Date:From;
        b=dfzaOZtlyFs0KE1rTqFkFQyMUNnq+g9DhLz9Wcax9qBV10ebeJ1QsHgK5oNSsja42
         R7yyhkvBCBcEgxOjbYj2KbJx9Fi+r4h8i16s38NwSyj2M2pxdW30cfmM6GhlRy4pyC
         6zzWNlM8fHln7JUoS+58lAkgylJkUuhhb8b8E3wSBmy4VU0mcRMP3lbxQPkeV7PLrN
         /3qR6xIZNnINHFGJ2GGpl7sM4/dV8DG/T2DxY1gPERw5NM8DfSgxjkl+5nW3pH2YmC
         oshxt9MXSGhwfpFhHzKgPyFszU+tcF1ruWdjBEgl6maVLN5SK7/FNCwSn1/rTOZ2ER
         5k46mLUAZuZkQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: fix endianness when reading cpld version
Date:   Thu, 16 Dec 2021 11:38:39 +0200
Message-Id: <20211216093839.1947031-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Current sysfs implementation does not take endianness into
consideration when dumping the cpld version.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 2f6de734ce37..1af568e46f46 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -139,7 +139,7 @@ static ssize_t cpld_ver_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
 	return sprintf(buf, "0x%08x\n",
-			hdev->asic_prop.cpucp_info.cpld_version);
+			le32_to_cpu(hdev->asic_prop.cpucp_info.cpld_version));
 }
 
 static ssize_t cpucp_kernel_ver_show(struct device *dev,
-- 
2.25.1

