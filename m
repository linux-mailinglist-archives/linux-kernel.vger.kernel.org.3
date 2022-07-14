Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB5D5750B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiGNO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiGNO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:26:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926D5142D;
        Thu, 14 Jul 2022 07:26:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c15so2418126ljr.0;
        Thu, 14 Jul 2022 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhAdDwR7fkHmP5A2mwh6VjI19vPe0VaNlf9urUpx8Og=;
        b=hINe2A+4rDsO5qx9r85RBNBCkuJYvM+3sJiN3lY76d+aFcYM1FL4AzzIIMEQ9bBstP
         x2a+hNbdWpX2UFWFTcI/JqwAlb2WDj93S/d4pvcbo5HcL1XgKIDXRTmQ3EOJqlp7zmdy
         3f3KsIkym9rNdc6a8ECB66yrOVz1mU473DSP+hIvYFH9+G8MM9Jz7IcY6g81EIt/a4DY
         UwT/Gk78TtX5CsazY8xdZt6M1GwQEdRXMnbR0k2jtlaA0eBQ3kXpZSv67jhIls9uG7gV
         9wGeVkTCuKK3eSr7OpKj60z7aq9iweHaArBIqGtC7AJv405Hs7TDziT573dBeevw3aOh
         VHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhAdDwR7fkHmP5A2mwh6VjI19vPe0VaNlf9urUpx8Og=;
        b=xGKiD4XZleCAcS2ZMU/fUOteFcsyM7LFLqiZWmYh690rVAwA+5QzRVEunT8V8U9xTl
         kbKBH1MCvQ4r3sr5N2299B81Ec1Bsq2QT0qJnWRCzW5FCP+slbskg8Mq8vaIzZfnvEv7
         9HBkGTJOU0MqreV70vi+bK54TlouDEZ8lN4BRfKxhHloAtpAdxn6CxrUlEsQFcqI94YR
         ycjnb0ZCzuCCumF9lVbCU/L6OEjTQrimF1q0JYGSISi++HG16EPG7Fnt2zrIU1Qx8gqE
         d/9W5WgUchryVsmYJ7X30WCNKKrJnmclP6pYnisuxKmWX825y4kEC8+2FBGR7R6/ncEa
         UCig==
X-Gm-Message-State: AJIora/cwcmM7ratXatPzKzdxJEdDHyZsaldQN5rWNfU0Y27c7BWKVx4
        /Ir2U7CAW0Fo72N31y937XAu8tKWfaWpMQ==
X-Google-Smtp-Source: AGRyM1sI1Dl9Qmbe2UutdGzOYC6VzFsKnNHLtcRH+6OjgCWBc6AqXqI2QGNzP6O3eNnhay2PqUfk1g==
X-Received: by 2002:a2e:944a:0:b0:24f:10bd:b7e8 with SMTP id o10-20020a2e944a000000b0024f10bdb7e8mr4980778ljh.238.1657808794231;
        Thu, 14 Jul 2022 07:26:34 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id q17-20020a056512211100b00489c665af61sm382594lfr.274.2022.07.14.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:26:33 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-22) with ESMTP id 26EEQT1u027118;
        Thu, 14 Jul 2022 17:26:31 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 26EEQPC1027117;
        Thu, 14 Jul 2022 17:26:25 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) increase fan tach period (again)
Date:   Thu, 14 Jul 2022 17:23:44 +0300
Message-Id: <20220714142344.27071-1-fercerpav@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The old value allows measuring fan speeds down to about 970 RPM and
gives timeout for anything less than that. It is problematic because it
can also be used as an indicator for fan failure or absence.

Despite having read the relevant section of "ASPEED AST2500/AST2520 A2
Datasheet – V1.7" multiple times I wasn't able to figure out what
exactly "fan tach period" and "fan tach falling point of period" mean
(both are set by the driver from the constant this patch is amending).

Experimentation with a Tioga Pass OCP board (AST2500 BMC) showed that
value of 0x0108 gives time outs for speeds below 1500 RPM and the value
offered by the patch is good for at least 750 RPM (the fans can't spin
any slower so the lower bound is unknown). Measuring with the fans
spinning takes about 30 ms, sometimes down to 18 ms, so about the same
as with the previous value.

This constant was last changed in
762b1e88801357770889d013c5d20fe110d1f456.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 3cb88d6fbec0..d11f674e3dc3 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -159,7 +159,7 @@
  * 11: reserved.
  */
 #define M_TACH_MODE 0x02 /* 10b */
-#define M_TACH_UNIT 0x0210
+#define M_TACH_UNIT 0x0420
 #define INIT_FAN_CTRL 0xFF
 
 /* How long we sleep in us while waiting for an RPM result. */
-- 
2.32.0

