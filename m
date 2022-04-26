Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9469550F0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244749AbiDZGJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244731AbiDZGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:09:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DE33CA5B;
        Mon, 25 Apr 2022 23:06:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so16258848pfe.10;
        Mon, 25 Apr 2022 23:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxsx4ZKYAxOkMFzPKK0OLLsxMKegRk3fFS29nU34Sng=;
        b=e24pDlaM+TWnZa8ggX7R5ojMhDcejDG5odEH9GhDu3UU+Q9/zxGz1EYxmrk3ieOaKz
         WuEZOFQdzU/Hq0B7cWKeZAoF7dkyauwDiGNphWRc8BI8DWtTF18Eu9DVIXIzE4287Lbu
         DsxzezPKoXc/Wrz/j6XofPpWYN8HFDeV2HJK74n87KtOfnqn1t6d6M5zl8VqUZzF5IUE
         nKPYjMSM///gFWuCKQ5wqcfwLjMqDhAo6Az+Gje+vPRQ4YqosfzJicBI4ig3GUXWwJSA
         68QCzub5/q3hsnJsKOelPy6qWBI2Xw+xRzWZcUD3VIHxroWuNHzdYssyZiaajpWDMb8Z
         sKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxsx4ZKYAxOkMFzPKK0OLLsxMKegRk3fFS29nU34Sng=;
        b=v+D6wRcS+KpJ9my1TCWx8CRko+ohb7g8DvftmguxRDkpAaT74cagV2FE/GswFxmEqJ
         0px/9SGUiVt4NoDVbPWdWCbYqcaKzIw4WkcyqGomQeXPjYmuAqKdEVNbvvQwv3seO8On
         HDtYtgxVtDkC08OwtTYUxDsS4WQeMidxJntWtfRdO91vrqVkHcVke+Gk59JPoXgmOUZ1
         S0DudrUefz4YvzYVNchFECuhixtQfrcneJzahvRzroqvVdS6XdAP+QKrmyKgwsXh/a07
         d7X+F5W7McG1zAa2BDi+tDCKSM915jLmoRII6k3P8SllDNjpkeQTxJCFKxfD6MZbc/vF
         MaqA==
X-Gm-Message-State: AOAM533cNI/DiFfSMKx6gPFfOV6utaV7hyEYPjbnhaIOCHllfObsUspA
        si4gcCdtU9oCqHpyjSzVG0c=
X-Google-Smtp-Source: ABdhPJxXbBZxgeu7xrYCSXDIlP9axe93Bw7d99jH5yPRqTlr8/+YgL/jCjaFmLg7n5eMDE6dNxZofQ==
X-Received: by 2002:aa7:943b:0:b0:505:70bd:61ab with SMTP id y27-20020aa7943b000000b0050570bd61abmr22531815pfo.58.1650953174977;
        Mon, 25 Apr 2022 23:06:14 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id k13-20020a056a00134d00b0050a5867dd73sm13969135pfu.157.2022.04.25.23.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:06:14 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 3/3] rpmsg: virtio: Fix the unregistration of the device rpmsg_ctrl
Date:   Tue, 26 Apr 2022 14:05:36 +0800
Message-Id: <20220426060536.15594-4-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426060536.15594-1-hbh25y@gmail.com>
References: <20220426060536.15594-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unregister the rpmsg_ctrl device instead of just freeing the
the virtio_rpmsg_channel structure.
This will properly unregister the device and call
virtio_rpmsg_release_device() that frees the structure.

Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 291fc1cfab7f..485e95f506df 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -862,7 +862,7 @@ static void rpmsg_virtio_del_ctrl_dev(struct rpmsg_device *rpdev_ctrl)
 {
 	if (!rpdev_ctrl)
 		return;
-	kfree(to_virtio_rpmsg_channel(rpdev_ctrl));
+	device_unregister(&rpdev_ctrl->dev);
 }
 
 static int rpmsg_probe(struct virtio_device *vdev)
-- 
2.25.1

