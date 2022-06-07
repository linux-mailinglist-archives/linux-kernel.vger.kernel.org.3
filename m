Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5753FA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbiFGJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbiFGJss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:48:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C2E8B82
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:48:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z9so2223870wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fk8bZMyNT/2KuBRASzmCZE/YrWdzGKg6dBkYG4hiWJw=;
        b=SsiTzfOZ02QdRLudEU448JckZ0SZYrjEWMdbOw80QQGOgx4cEEZq6rjVu3qT60gpC2
         PUFmRc/aOGoIpqIysMLGE6wwPzDf8YeuEXuNKLo3lTPlfzOQlx8u8ufzUTmnuZgZxrsK
         5kq7REwTodNGbj8NADbiiWnUtIFrzYPxIqseE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fk8bZMyNT/2KuBRASzmCZE/YrWdzGKg6dBkYG4hiWJw=;
        b=0eWhC2bQjy0dDQTk7qa73sPQETnQnQhhGdRQwVQm/XIQ94nC1mRgVWHT5QpT0oVXqO
         OYhjeJer6hy/Y2Vc+10d790KP6im1nItkoYCMO9YyR0qYTlUMqMtQfhpsoGBF+gvzuv/
         IkW3ttE19AcbISBCNrtX6NrGtHAmMUiGN0+iaK8VdsysqJRqWlVQidczjP1UTw+wq+FU
         wqLV9jC7I2zGX/aKcUfqU/QIulm/h5wEWcrD+adckn0HItfbexgEO//SNfgbPeBztLVu
         JEbnT5VoQCZJd2X162Yy0iCxFpcamFkyaEiV1NUelPr/aeQehH0Pn2LTCDDTT88M66ml
         x5lg==
X-Gm-Message-State: AOAM533xbQDVJx+qssamXZ19Soqo1k6F+7WBCJ0zDnybuS5nOCT0EtZB
        wgOVela/16IPzotm4a83xFtx1NxROfK/vQ==
X-Google-Smtp-Source: ABdhPJz8EkqmfDk/JdyrKqxaKIRDzQIEeM7WRkwX8FOC+6KohO6nT10JUUd03OWAnk3kiniw+AIkgQ==
X-Received: by 2002:a1c:4e03:0:b0:39c:5bbc:e0d2 with SMTP id g3-20020a1c4e03000000b0039c5bbce0d2mr1050675wmh.184.1654595309817;
        Tue, 07 Jun 2022 02:48:29 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-137-51.net.vodafone.it. [5.90.137.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0039748be12dbsm23200547wms.47.2022.06.07.02.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:48:29 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
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
Subject: [RFC PATCH 10/13] can: slcan: move driver into separate sub directory
Date:   Tue,  7 Jun 2022 11:47:49 +0200
Message-Id: <20220607094752.1029295-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
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

