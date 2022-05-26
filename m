Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93994534971
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbiEZDqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245303AbiEZDqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:46:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1124FD38
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:46:21 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id e18-20020a170902ef5200b0016153d857a6so396735plx.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6MNgMENOyD6oT5LvMsfOpHfBO2ZH4FG1eUHU37bxLow=;
        b=cwMuN3FusGYuQwW0vzhutxD5D0QU51D/+Sueh2qUlBal2JEFrqoNA7a6wSV/+RZmXv
         Z6Ww0mhE/LLpZckd0Dyl5fg7aqF5/vy2brnsU40OG1GYBlzhUcpn7G+tqA5smx/FvBBD
         DAcVlcjxzbKZp/y0A3EWxudBIcUtQY0LQcXeez5jllaQGMZ3nfCoiTaX2ORs2bxqv84L
         LM6DkaNLYs1+mkAVP2lC+mMN5D/NEia0aTu8T1CFBKirqNuBd4v+757OlLH8GBz+YRtP
         aZFkXkUJRi3V7LZgBzdnxVONx32kF/VndiaLZJerfB7eZZgparT/PYo89rZonbonn7at
         QCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6MNgMENOyD6oT5LvMsfOpHfBO2ZH4FG1eUHU37bxLow=;
        b=4GBZljI+TFfJZ517ihHwOg2ijmhxjZnalhHM3onlTcnO/gLOg1u9FX4Jxqw4DunZ8z
         A99liVlAF15MCKryCC0UcYMNvECsrHKWb9++nZ2NyW0qXjbz0lERZPOLyuVhu17NY11w
         FWv4UJOJTayyjFQPkNBLH4RVLfty3B4nSKo7FtgTlA5yuxH6rvivqlrt15Q97LjR82Li
         tgNSSqRYIN+63MkTC7+cg/S+ylYC37L1SecYyKBHibEJAW/6c/Ja9WIdcRckbDd18RAm
         rq2N0v7kjps6KkIUBzCofxxr9A+DlGLz0lOhwss6zj16rK7nOi7xPEttmXVD8kfrUjo8
         HBKQ==
X-Gm-Message-State: AOAM531MCWFCraUENZH7UH1fprjDci2u4uNfYZyH0YGy9MjwYg6mjjWX
        yQUQLmIZlSKiLd+1k3f6xDGS4SS4ros3kDA=
X-Google-Smtp-Source: ABdhPJzvyi8HTzIzW8ZO9SiL2k3tZwthIn6V/jOlzo2pc4pIRW/s3uLbEF7iZt/YPGQhY346pubKNrle350ZskE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:cbc9:88bf:e847:ab95])
 (user=saravanak job=sendgmr) by 2002:a17:902:cecd:b0:163:794c:fa9 with SMTP
 id d13-20020a170902cecd00b00163794c0fa9mr1134158plg.136.1653536781324; Wed,
 25 May 2022 20:46:21 -0700 (PDT)
Date:   Wed, 25 May 2022 20:46:09 -0700
In-Reply-To: <20220526034609.480766-1-saravanak@google.com>
Message-Id: <20220526034609.480766-3-saravanak@google.com>
Mime-Version: 1.0
References: <20220526034609.480766-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v1 2/2] driver core: Set default deferred_probe_timeout back
 to 0.
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we had to effectively reverted
commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
until the deferred_probe_timeout fires") in an earlier patch, a non-zero
deferred_probe_timeout will break NFS rootfs mounting [1] again. So, set
the default back to zero until we can fix that.

[1] - https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/

Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: 2b28a1a84a0e ("driver core: Extend deferred probe timeout on driver registration")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 91f63cd33b12..251b5ba1b84a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -256,12 +256,7 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
-#ifdef CONFIG_MODULES
-int driver_deferred_probe_timeout = 10;
-#else
 int driver_deferred_probe_timeout;
-#endif
-
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
 
 static int __init deferred_probe_timeout_setup(char *str)
-- 
2.36.1.124.g0e6072fb45-goog

