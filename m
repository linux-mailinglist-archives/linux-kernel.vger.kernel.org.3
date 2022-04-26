Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2550F0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244687AbiDZGJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbiDZGJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:09:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D73C493;
        Mon, 25 Apr 2022 23:06:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i62so3083887pgd.6;
        Mon, 25 Apr 2022 23:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKMVajePCkLYTsdraPhfT8Y66xPcxgdHhTEjl6+Zw6c=;
        b=GkFWtWhghH/aU5YmVPJwx1tYmqzCheL7g82PjRfM2Ac6OF26X/DAjLyME/EF8VTZUb
         LjtodfwIVJiX2qwpsTrYdGw/TJ9uRyj3SwNTcM90ndrnryyCt3AhufuWhZwtsEgx0lcD
         hvH9eJU11TuUihuw6N8Wn1NmffAS6dg4Y1niWGjhXm4186QsNT7XfT95fm7YCkE4y5H/
         QPMG+tTprovlO1s86pHoAQnynOW0FZYvECnIj1fDp5ieu/N7hbp4VoMUGQ3gCszE0aZo
         dFzCgxmpIHFNC8kdcvg85oXJu7a5P4dCkgoo1/75iJ772w+FYNX8jPixoUGpRM+KNQ0Z
         o0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKMVajePCkLYTsdraPhfT8Y66xPcxgdHhTEjl6+Zw6c=;
        b=5OrBq3BQ+3iw7THXTGwPce2yr5FPY7spaMS9CmQO7jF105J6NlYOToGpbY0XQkSYAw
         bbooXspatbeJibA20dsYVL1eE8LHSO85E5By/GYMhHRQmgx/mYMvKh2JVasJiKG2jbYm
         iDNjKIFnhhdCnlyq4gZm7kgJtllBkvHvW5Fd0zf4w+mgdfPxFfJ0W6X8Xj6WdppgIOFl
         tE81K2jtaCiv3nBCkRBf3ZXtNwJtSX9HgbWeMDF5gcuSit5C1Lp8HNeGJ7UDgMxQmzM3
         2MfrXRP4bRH/QacxLTODnuuds5tYXi30dXPjqFlFW0mfFAASewzEHJq/94vUph/jM2K0
         /Nmg==
X-Gm-Message-State: AOAM531XZaxRl8St4xF7l7ggmCrvsuW19QeSiNnCu3AX1TKGqHf7nXNp
        5nzjx59cNsKtEUIxM9K0Ats=
X-Google-Smtp-Source: ABdhPJzA6d1D8KlutAa7AdNQikutyGTzJDWCZKTgClev/PQ8zg/ZO8lgOsOv50Z2Wv5G/PSAqXFTHg==
X-Received: by 2002:a05:6a00:2402:b0:4e1:3df2:5373 with SMTP id z2-20020a056a00240200b004e13df25373mr22857741pfh.40.1650953171099;
        Mon, 25 Apr 2022 23:06:11 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id k13-20020a056a00134d00b0050a5867dd73sm13969135pfu.157.2022.04.25.23.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:06:10 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 2/3] rpmsg: virtio: fix possible double free in rpmsg_virtio_add_ctrl_dev()
Date:   Tue, 26 Apr 2022 14:05:35 +0800
Message-Id: <20220426060536.15594-3-hbh25y@gmail.com>
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

vch will be free in virtio_rpmsg_release_device() when
rpmsg_ctrldev_register_device() fails. There is no need to call
kfree() again.

Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 0130d0ba548c..291fc1cfab7f 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -851,7 +851,7 @@ static struct rpmsg_device *rpmsg_virtio_add_ctrl_dev(struct virtio_device *vdev
 
 	err = rpmsg_ctrldev_register_device(rpdev_ctrl);
 	if (err) {
-		kfree(vch);
+		/* vch will be free in virtio_rpmsg_release_device() */
 		return ERR_PTR(err);
 	}
 
-- 
2.25.1

