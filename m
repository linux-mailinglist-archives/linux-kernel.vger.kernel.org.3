Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36E596488
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiHPVU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiHPVU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:20:56 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF30289CCE;
        Tue, 16 Aug 2022 14:20:54 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id p4so1727061qvr.5;
        Tue, 16 Aug 2022 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FXWTTPpQcqYtQbLK/BMIv1RIR9bk2L9ROhijUgzwZuQ=;
        b=I8NDX+zfDzTvkEN/lmfWRUSYdBpzFy3FwwksmOHfCQYdSLDSTMN5S/iQrz3ejsnDqQ
         xhso44fp9iCtH71spCyXFjCTjWlBFHIjEQJhnrfaMXcJiXY902Xcan2ORGsIXi/q5Wvb
         /+1JFQghomR5Kt2B6sKIlruX106T1SxmtmsLVEVlFoQomrUq+2ocUvmB0TzTgKuQ484M
         ZHOK8lFI1unEA/6smQPT5ORzkGqExEejBD0lIm2b2Tj2V9YEKt135k9GBd4u3qzhSUct
         M0yETpoRFDZVT9txajLtsx7NrDP7dK3cHUSJNL6KYeOoqnhIzrdljO5BCbCaz9Tsr4l3
         aGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FXWTTPpQcqYtQbLK/BMIv1RIR9bk2L9ROhijUgzwZuQ=;
        b=SB6bEEazWUvZtB8F4jLilFEUThHPhSq1Bu2JAVaby3ARRT7SONlJITwYJVRi3eHA8K
         UDLaF/a1QNGRnjpRjzJWjJcykzvFiV8iS8dQgbgr1WV820BswiVcLkfJaaVrSSmmrTu5
         3pKbg94QX1fFjGDWnNXdGS+FoDKSafWvZVaB3uZKBZS6ngbyjC2aNJ906PjwsrKtlSw7
         +ho/o8xvFbGVh+nN6gIiRTmA8F06VxqC5RBXlT5enducs8V97yn5IbpVQoet4zIx9XA2
         2vAgB/ijWb3mBGEIJbJQMu2hmxdNpAYT0aTBv7ZhoVXnATyaT0NOVOQKt+ZJtgX6ZRsW
         nOsA==
X-Gm-Message-State: ACgBeo1oBoIhkXvAcv8qth9xJ4yD4dqnYPGbQOHyQt6wxGjiFzNbs3uI
        vNTuobu81VDyLhyo/Km4Hi4=
X-Google-Smtp-Source: AA6agR7a3giQ8fZ0p0O1BAaM+sCDhRCk1XQq3cdPTGe5YvtQE6Ss0kH2Cgm4QgR++aTLafTOolstdg==
X-Received: by 2002:a05:6214:29cc:b0:477:38c2:105e with SMTP id gh12-20020a05621429cc00b0047738c2105emr19799248qvb.93.1660684853863;
        Tue, 16 Aug 2022 14:20:53 -0700 (PDT)
Received: from localhost.localdomain (rrcs-72-45-242-14.nys.biz.rr.com. [72.45.242.14])
        by smtp.googlemail.com with ESMTPSA id u19-20020a05620a0c5300b006b5f8f32a8fsm12516845qki.114.2022.08.16.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:20:53 -0700 (PDT)
From:   Benjamin Rood <benjaminjrood@gmail.com>
X-Google-Original-From: Benjamin Rood <brood@curbellmedical.com>
To:     dmitry.torokhov@gmail.com
Cc:     dmacdonald@curbellmedical.com,
        Benjamin Rood <benjaminjrood@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: pixcir_i2c_ts - lengthen reset pulse to touchscreen controller
Date:   Tue, 16 Aug 2022 17:15:18 -0400
Message-Id: <20220816211519.2175022-1-brood@curbellmedical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YvWLwpQemH1Rm95r@google.com>
References: <YvWLwpQemH1Rm95r@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Rood <benjaminjrood@gmail.com>

This patch adjust the reset pulse in the pixcir_i2c_ts driver to address
the following issue:

1. Not driving the reset signal HIGH for a long enough period, resulting
in a "shark fin" reset signal.  Some microcontrollers do not have "fast"
internal pullups, which may result in a "shark fin" signal if the delay
between asserting and releasing the signal is too short.  Even though as
noted in the driver code the duration of 80ns is the minimum duration to
assert the reset signal, a host microcontroller using an internal
pull-up to assert the reset signal may not drive the signal high enough
with this delay to effectively put the controller into reset.

We encountered this exact scenario with an NXP i.MX8M Plus directly
connected to the RST I/O of the pixcir controller, with a resulting
non-operative touchscreen on a cold-boot sequence.

The change included in this patch addresses the issue by:

1. Configuring the delay after driving the reset signal HIGH to use
usleep_range(500, 1000) to allow the reset signal to reach a full logic
HIGH voltage for a maximum period of 1ms.  This is overkill as the
datasheet specs 80ns as the minimum duration of the reset pulse, so by
overshooting the timing by quite a lot, it gives the driving chip enough
time to drive a logic HIGH to assert the reset.

Kudos also should be given to my colleage Dan MacDonald
<dmacdonald@curbellmedical.com> for helping to discover and fix these
issues.

Signed-off-by: Benjamin Rood <benjaminjrood@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index dc148b4bed74..4af4b9016c94 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -222,7 +222,7 @@ static void pixcir_reset(struct pixcir_i2c_ts_data *tsdata)
 {
 	if (!IS_ERR_OR_NULL(tsdata->gpio_reset)) {
 		gpiod_set_value_cansleep(tsdata->gpio_reset, 1);
-		ndelay(100);	/* datasheet section 1.2.3 says 80ns min. */
+		usleep_range(500, 1000);	/* datasheet section 1.2.3 says 80ns min. */
 		gpiod_set_value_cansleep(tsdata->gpio_reset, 0);
 		/* wait for controller ready. 100ms guess. */
 		msleep(100);
-- 
2.25.1

