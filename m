Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098F5091D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382441AbiDTVOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382419AbiDTVOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:14:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191FB483BC;
        Wed, 20 Apr 2022 14:11:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so3254489pjb.1;
        Wed, 20 Apr 2022 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=br/mJIWvQycGaMYcFjzbZMt2KUCcKABdWBb1GxUivVQ=;
        b=SlfiELn3nd18umI6Db6JIdi1tHtLYQszGc3BnHDxYkPMQi7kwtBNf7lYn1e0/heeT/
         Pa4sjXZCqdHfg0F7vPXFiebjPzJEMeB1rsX7V1/IVsF+Ftwje3CdXhxJW4oi7pO9C0MW
         KsnvHnGoD8ZV8uJNxvsffYtzXs0gniOPPWIs3Xwh4bNSMjJHTUDGmr5DJnNi1AYltJSF
         EXniVOHH2FWLzIjRcsUJzzNW431F0aTEIciRd2sJvEi0ZjekJfRSOMlawXGOUrmDOnDs
         X1/Qu/5FaROzkUKDeqgpIaOP/w6fc/WvjaP+he+i2EjHRM478gbKSTpPUmXxtMJ7+4N6
         Jhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=br/mJIWvQycGaMYcFjzbZMt2KUCcKABdWBb1GxUivVQ=;
        b=mSCgG/wfffIN7KrAgd0+0fE+PLktJzf9fEewC+k6gVRYW7xG+9o9OHbIK4eb4bD79G
         Abwzj/y+XZwBZ4GvQOToI+aXzy7LmJlkWzhFiBMWjjWc/Lh8Vc6BLfSadoxrfhoNze3Q
         FBQDL69wDiXQ28wydLO8Eq4XFmw9qf4v5GxSzCdwSHyApWSwy4S0+SjPnKwOFaRRvBRE
         ROCRfvYqdmbfbKPNvRZLNK2ikZK3w/65rBMyRG/GujUx0mn+lKFmHUtatt/Uc9dIlYdD
         yJmyzkPBbLW7RAS8Zm2utgctBy2fQTKT534fsmjG/tI0SpqkEjRvS6kP8YDAQTH9542Y
         GqlQ==
X-Gm-Message-State: AOAM531tnJpAmgdywyOu7frbmjA5lTk9PVaqVc6W9xuRkEHTdW4ECkGg
        glLB7E/z3YrBHShNvqCPqH0rfxWfH5Q=
X-Google-Smtp-Source: ABdhPJxVayMEedPoG5tEg+a0LzNW0Ew1TEiv3qCjfZrSSfbqtfxaA87lQAqAccWC2XoPn+U3/wHCwg==
X-Received: by 2002:a17:903:11d0:b0:155:c240:a2c0 with SMTP id q16-20020a17090311d000b00155c240a2c0mr22251166plh.143.1650489086410;
        Wed, 20 Apr 2022 14:11:26 -0700 (PDT)
Received: from localhost.localdomain ([27.7.104.83])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001cd4989fee4sm106652pjd.48.2022.04.20.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:11:26 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] iio: accel: bma400: Add debugfs register access support
Date:   Thu, 21 Apr 2022 02:41:04 +0530
Message-Id: <20220420211105.14654-9-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420211105.14654-1-jagathjog1996@gmail.com>
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read/write byte from/to bma400 device from the userspace
using debugfs interface.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 073fff7d64a3..5b1b28972ef9 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1030,6 +1030,19 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int bma400_debugfs_reg_access(struct iio_dev *indio_dev,
+				     unsigned int reg,
+				     unsigned int writeval,
+				     unsigned int *readval)
+{
+	struct bma400_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+	else
+		return regmap_write(data->regmap, reg, writeval);
+}
+
 static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					     bool state)
 {
@@ -1060,6 +1073,7 @@ static const struct iio_info bma400_info = {
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
 	.read_event_config = bma400_read_event_config,
 	.write_event_config = bma400_write_event_config,
+	.debugfs_reg_access = bma400_debugfs_reg_access,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
-- 
2.17.1

