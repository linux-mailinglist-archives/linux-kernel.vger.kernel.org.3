Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2E547CA0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 23:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiFLVlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 17:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiFLVkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 17:40:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA43193EB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:40:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g7so4931355eda.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1QllzXGCUo8JTE+hOZVBSnNVj6x3XTlbwu5/oui3J8=;
        b=j683OfaqxoBiWn1BiwfjXqUk2WaqfT4QdfjP+wHvLbHubm2YMyvvz0S1/wEvj+zBh+
         ZJBgSWvHufKlrA0lDhg2S9Gv7/UcrTbeEc6XgSDrfup5cgRcQep+VPjI5gJPmYypelj7
         ZBhwEL2jGYTlNsCdrSo+5Srx/Cjp6dLGXP+/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1QllzXGCUo8JTE+hOZVBSnNVj6x3XTlbwu5/oui3J8=;
        b=eZHwEQMgx0EFFCxoBZ2V7u5LOzzMk7R+kWyzsjbqB0wSVufZ/DiZ/7mswjMy0CYrX7
         rcikuxHrvYKGrzOZDLGLgsfSg3qi10TJpjPwj1nsLpJs0ArVJrjYTNyqb+9AETt0+nT2
         tTpnGRObTiKWipokO6R98vW4lqoO1OKn0i6JnQAX8OewF5LskaqlDWfoF9Uij6amBCp+
         tMWGM2d1X/r+TfEJWrXt/WM0ZwaR8Rc/KdK7SfkzSSRdPzh9CY3B6r7HS/cFRdfzYRXL
         DqhOOyzeArlp2Nht5tDeoMqO3WvdWjVrERgBGgqrftnH39vhaVKkXrRpSK91oXIYlcfN
         fk+A==
X-Gm-Message-State: AOAM5301uAu/n/ARFAgD6FtP/qJl2+u16atmrCBo9L4m5r8tb6b/Adv4
        Cl8sW8iAT/enmnyt9+Zq3/eAS9Jk3zM5Eg==
X-Google-Smtp-Source: ABdhPJyCUKwRYN+7NoivIrBty///I6QyiekWSDvpNJazbHFWFe2uUq1To40HAXF68dITPwjP/KiumQ==
X-Received: by 2002:aa7:c34d:0:b0:42d:ce57:5df2 with SMTP id j13-20020aa7c34d000000b0042dce575df2mr61797916edr.315.1655070018727;
        Sun, 12 Jun 2022 14:40:18 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b00711d546f8a8sm2909398ejh.139.2022.06.12.14.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 14:40:18 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 10/13] can: slcan: move driver into separate sub directory
Date:   Sun, 12 Jun 2022 23:39:24 +0200
Message-Id: <20220612213927.3004444-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
References: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the slcan driver into a separate directory, a later
patch will add more files.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/Makefile                        | 2 +-
 drivers/net/can/slcan/Makefile                  | 6 ++++++
 drivers/net/can/{slcan.c => slcan/slcan-core.c} | 0
 3 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/can/slcan/Makefile
 rename drivers/net/can/{slcan.c => slcan/slcan-core.c} (100%)

diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 0af85983634c..210354df273c 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
-obj-$(CONFIG_CAN_SLCAN)		+= slcan.o
+obj-$(CONFIG_CAN_SLCAN)		+= slcan/
 
 obj-y				+= dev/
 obj-y				+= rcar/
diff --git a/drivers/net/can/slcan/Makefile b/drivers/net/can/slcan/Makefile
new file mode 100644
index 000000000000..2e84f7bf7617
--- /dev/null
+++ b/drivers/net/can/slcan/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CAN_SLCAN) += slcan.o
+
+slcan-objs :=
+slcan-objs += slcan-core.o
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan/slcan-core.c
similarity index 100%
rename from drivers/net/can/slcan.c
rename to drivers/net/can/slcan/slcan-core.c
-- 
2.32.0

