Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324C64635D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbhK3Nx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbhK3Nxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:53:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F493C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:50:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n8so14992740plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmm+qnNre9RCCUNMLh0oisBpzWW72+UVqMfsZCWkkvk=;
        b=JwEoHDCS7McWDh59e+41QLHoBblGaZQar8L/KpMc19mb9Yr0kLCTaKxfAwHR48EkPY
         2Zw3t5E/0LqsqC3nQIVoGDT6p7W+iQMkQzK2i6rGJfq+C3SyBKyW44fJ+ZlOFyTCGoS2
         nvUTf5Kw5xJgouGm1Ggm4irhZRtQCDnxhDa02eepTSX/HbtClF00yfA5e7GD9xaOQRPc
         3Ay73XeXIpNZxGFJ2JyPdgCLm/Qt3uv55KlMWIno1hyf9/xGsAQnTTSAHs8zj7UKi9Am
         nQY0miRHH2G1Kc/qY+fxnnmZ/2nSmeQbJewuiT9NS0U9OaYktxRGvv50uuhXDT6O90YX
         Ej7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmm+qnNre9RCCUNMLh0oisBpzWW72+UVqMfsZCWkkvk=;
        b=tefAPMMEeBZ6LVbmfRNlAzLRMlaYQceAY9AQH2MUsAvQybZhr1QucViu7ARjLkJjdz
         AYWkKJFh7YhvvOQpkqSPfwY2dS9gkOzlnktIWqaJ31/LSLPZnq1yqlEnK23vJElr07Dx
         QJVF01mMD3Hipv3bS7z+J6wXQtLdkflhRYSqALqh9nWuzqutpCPR0Q4PE4MfwpBRhpCD
         gxEZmcN5COUk6Wx5cjfxrgMmjPRuae3Y58tlhB0/743DHiZ1duwpua4FpegMbyAch2Wj
         zX33UzcLw+UYUHv4uaUfxAxInHHSHSDeBu6KBwRUZbmHIfgYYBD0q4tXZHkYOYdazkU+
         km6A==
X-Gm-Message-State: AOAM531GD+yeJPBNo8WJ1JtpJCGUVaYhZC6JmpFdZavbrBZkb/xCBZeD
        Ly4gXrI4k0TtjFxydgrhcpJjMCAygWLB/A==
X-Google-Smtp-Source: ABdhPJx1rjxkJUxTUQRvDwmfb/HBlnFEuxSFucy6W/13/FspMgq3VNTYJCFfuZT6XZNaDVP+V6FQ+g==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id pj12mr6246540pjb.218.1638280229735;
        Tue, 30 Nov 2021 05:50:29 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.4])
        by smtp.gmail.com with ESMTPSA id v25sm20992925pfg.175.2021.11.30.05.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:50:29 -0800 (PST)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver: nvme: fix missing error code
Date:   Tue, 30 Nov 2021 21:50:14 +0800
Message-Id: <20211130135015.1818325-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:

drivers/nvme/host/multipath.c:865
nvme_mpath_init_identify() warn: missing error code 'error'

In one error handling path of nvme_mpath_init_identify(Line 865), error
is not initialized as an errno.

Fix this by assigning error to -EINVAL.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7f2071f2460c..2cbeb6d6b064 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -862,6 +862,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 			"ANA log page size (%zd) larger than MDTS (%zd).\n",
 			ana_log_size, max_transfer_size);
 		dev_err(ctrl->device, "disabling ANA support.\n");
+		error = -EINVAL;
 		goto out_uninit;
 	}
 	if (ana_log_size > ctrl->ana_log_size) {
-- 
2.25.1

