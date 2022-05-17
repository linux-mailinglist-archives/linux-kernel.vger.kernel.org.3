Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF4152ACCE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiEQUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbiEQUgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:36:35 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CA812D0A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:36:33 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h85so50163iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHgiralzuwbFYrH+IllvrNWzKpGXUYjClQCXhgMdPIg=;
        b=GKY+T8a74JPC5oygV6JYinz0XupyZf5nuPsS8x7/JQJd625CnhFlz9MXvOLFvi73LR
         i4XQ8WVu2rjVh4w7ftvXu1vazbiAUZTMQvaPPC5baLuUlBqPgUnp8zQck3y79SfoOXwU
         1LQxoi9EFlmiVwv/k7YM/V6r+2JqLN8TTm6DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHgiralzuwbFYrH+IllvrNWzKpGXUYjClQCXhgMdPIg=;
        b=t8cOlITvq07L7eyO65SeP2O16oHdioDa+WhrxH1ozix23u6SvYZPcokX0IanIvAU+h
         5lSJIod40YxN0tE2nkg0JpMvM9Q6zDHaimM1RxtTgGCN9NeNmNL6uTng6vgIHXTZAt0x
         TOn10wzcQmE2jVys9PySaGe7HkhnhXxYJl3KErhnqMJmHXT7fd7Tly1jm9LZDbvTurGb
         3sUwt8NCcpw3Q6fRCziA7inkH5Con2LNUCkbA4A11qsUhmxCjhuuL1neCz6lm86ndmMc
         Rv8htaJZRDHveOjaH2wA1Rr5fuHAy985782Ym0m5rIKISua2d6o92A2d+TR6D+0xjPzf
         S6kw==
X-Gm-Message-State: AOAM533XuTrjo8zR2Tic9jYqrz5/Fud6ZgOro/T2J8SwdDE0ZljtD0Gq
        lHjsjA3qtw1Ih28tpdTbClBIPQ==
X-Google-Smtp-Source: ABdhPJw4ZLk2eDS1D5mvut9Aory4w5I6AIEkUqZYTHdTGGciZm7EGv0WNnrJ3Ob4cjtDb+VgpkKWZQ==
X-Received: by 2002:a05:6638:1416:b0:32b:c48f:f9f5 with SMTP id k22-20020a056638141600b0032bc48ff9f5mr13053507jad.207.1652819792971;
        Tue, 17 May 2022 13:36:32 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h24-20020a0566380f1800b0032b3a7817d6sm17114jas.154.2022.05.17.13.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:36:32 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] misc: alcor_pci: set NULL intfdata and clear pci master
Date:   Tue, 17 May 2022 14:36:30 -0600
Message-Id: <20220517203630.45232-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alcor_pci doesn't set driver data to NULL and clear pci master when
probe fails. Doesn't clear pci master from remove interface. Clearing
pci master is necessary to disable bus mastering and prevent DMAs after
driver removal.

Fix alcor_pci_probe() to set driver data to NULL and clear pci master
from its error path. Fix alcor_pci_remove() to clear pci master.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/misc/cardreader/alcor_pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index 3f514d77a843..9080f9f150a2 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -317,12 +317,15 @@ static int alcor_pci_probe(struct pci_dev *pdev,
 	ret = mfd_add_devices(&pdev->dev, priv->id, alcor_pci_cells,
 			ARRAY_SIZE(alcor_pci_cells), NULL, 0, NULL);
 	if (ret < 0)
-		goto error_release_regions;
+		goto error_clear_drvdata;
 
 	alcor_pci_aspm_ctrl(priv, 0);
 
 	return 0;
 
+error_clear_drvdata:
+	pci_clear_master(pdev);
+	pci_set_drvdata(pdev, NULL);
 error_release_regions:
 	pci_release_regions(pdev);
 error_free_ida:
@@ -343,6 +346,7 @@ static void alcor_pci_remove(struct pci_dev *pdev)
 	ida_free(&alcor_pci_idr, priv->id);
 
 	pci_release_regions(pdev);
+	pci_clear_master(pdev);
 	pci_set_drvdata(pdev, NULL);
 }
 
-- 
2.34.1

