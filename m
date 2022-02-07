Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48EB4AC025
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389014AbiBGNvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241501AbiBGNkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:40:39 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249FC043181;
        Mon,  7 Feb 2022 05:40:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d187so12991973pfa.10;
        Mon, 07 Feb 2022 05:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=TGF9rxKbfLgE4yzeN1f8tbFRCeGks8IIW/eVpPUyeiU=;
        b=ZyaZgt0719MVOEzqMhPX9YuwhOcvk4Tfgtci93hXXrWqzr0VZbI2hjq43PQTBQMuz8
         nIGCqRdMsDziUzsgblBes1baEbn8xA5hGHAkNjFYWF3vQLkNzx3HsIWUhhHM4RPA+8le
         tC51WGTcxkNfvVsF3DZfZ08jLbQ80xAuq+jnkAmSShFDCaPwuN+jkwkH9LYcJU7X4Zy6
         3QgQpGfke4WWvrb564nfUnAhbGpAgKoptflj7l1MBWG3lqMg++4W5Ide+nPfY/qnc2Dk
         L4t9PeoHicJ/YoBZK/SGm6Zl6qErkrGM88O1SL8CwidyADrMEJKKBtAxhpBzCJphZffh
         JPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TGF9rxKbfLgE4yzeN1f8tbFRCeGks8IIW/eVpPUyeiU=;
        b=ACrt0QpLhxJDcUrD5xliMowASCZMHDnJq+2V8Lz0PfMoyKXpN2A/U8ZoB3AfBrTbKq
         n2HE+vNgYMO8r7ioI852k8/YuulOzk4+fPmgZd+hj5LzOYHaCLPcvmXsDN18BpyM8vHq
         uIL+qnIDpjy4A9HZsYBecnI2jdAYr6KenJa91+hyaUlhnp2NMtNJ3dYPXgFfq2I/spDD
         6sJT2AfA/KSYubi7kDiyz7jUlyji/k1sXlEO6dqwxvpMzTgrKtj/diTOqkDAyW+Qh3ho
         SuUxSf+1PIzrdIbVb3Oc9PvL2Ip127ORKeb/xNa+CTWtJCVEG4aJY2GnMWowb3IMejth
         afgg==
X-Gm-Message-State: AOAM532/o7WPmf/Y3H2Stc6Ei0tMLuWWWQU+w2Zw0twv2O6ZzxO/50k1
        HgbDDAJhLNOupGF28YQztAU=
X-Google-Smtp-Source: ABdhPJzf4r4cyGazko/1XgNj0OygcynEqxH7DclCZ/kkCf8azez4RKIt62fonUr015Jjv6NO2Ylb/A==
X-Received: by 2002:a05:6a00:2350:: with SMTP id j16mr15992959pfj.78.1644241236437;
        Mon, 07 Feb 2022 05:40:36 -0800 (PST)
Received: from localhost.localdomain ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id u17sm8424156pgi.14.2022.02.07.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:40:36 -0800 (PST)
From:   Ayan Choudhary <ayanchoudhary1025@gmail.com>
To:     marvin24@gmx.de, gregkh@linuxfoundation.org
Cc:     Ayan Choudhary <ayanchoudhary1025@gmail.com>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: nvec: Fix ending in '(' error
Date:   Mon,  7 Feb 2022 05:39:21 -0800
Message-Id: <20220207133921.4287-1-ayanchoudhary1025@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

CHECK: Lines should not end with a '('
386: FILE: drivers/staging/nvec/nvec.c:386:
+		err = wait_for_completion_interruptible_timeout(

Signed-off-by: Ayan Choudhary <ayanchoudhary1025@gmail.com>
---
 drivers/staging/nvec/nvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 990d15c31a13..b3f114cb00dc 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -383,8 +383,8 @@ static void nvec_request_master(struct work_struct *work)
 		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
 		spin_unlock_irqrestore(&nvec->tx_lock, flags);
 		nvec_gpio_set_value(nvec, 0);
-		err = wait_for_completion_interruptible_timeout(
-				&nvec->ec_transfer, msecs_to_jiffies(5000));
+		err = wait_for_completion_interruptible_timeout(&nvec->ec_transfer,
+								msecs_to_jiffies(5000));
 
 		if (err == 0) {
 			dev_warn(nvec->dev, "timeout waiting for ec transfer\n");
-- 
2.17.1

