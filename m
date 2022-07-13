Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283BE573A64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiGMPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiGMPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:45:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA64B0FC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:45:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w12so13896088edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0RDV3LfY9Xy3Jm7IZZiFccn5WkHlef0xh/HmK2Mp+Vk=;
        b=LmfgKrINvMuZlEn8iqQZ6HTz4/4vGZBsH9SLwcu8sX9PonQhZBiBxh8DCeWKAiLQC+
         /BzHsdGUcTbypRZkH4ipYSSiPo/BXDKF9BzxRia+hgVobwfLaiwTbS/MXU2oIVMvfUbQ
         L9nfav3udmn5ekoPnxs4iQq4PKnO+U5eZx0Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0RDV3LfY9Xy3Jm7IZZiFccn5WkHlef0xh/HmK2Mp+Vk=;
        b=yGTZPOjkDm4GasSGEkamW1Gv8fpHM7NICiKoOUmxOMzLkzwjhPWYebo+yhITi5prc7
         Cg55PffXblFwqbA3/rjPZr5V0ePXbaYn3KaI7BL/UXDW21WnTqnx1EJiaqpyDp4pcQ1d
         RoSlPDxHiLIHtKoYey24zfnFyyeMB8unnO5VEjMRxhkJAnAcCUz0fFwZbiTMp4ruvia6
         lOBnXLS7qDgqVePaLNMJPULYi53BzgwLUf+MM7OQrsydUqFdsF9KvGBcSuQb5F/XwYqq
         gBm4spdmMu/ce5B/91y08lrF30X0GL4uL58lwEE5r4PCg/W/dfcbnZXTPM0YR04KaIch
         uj4Q==
X-Gm-Message-State: AJIora+dZ5pOzpl+vUNOTxBH4PJhrxIAVnF56J5705aNMfm7898gVDzh
        SA8wvL6xp6g3akc8jeKDGIUR+U9RZ2PSkbnr
X-Google-Smtp-Source: AGRyM1t3DmASLYur8LXJjGGYj+/MpBaNAz/lRVvtFJB89fZFe2d4pgQ0c2/XFlStz8o/Fp8tJfUASQ==
X-Received: by 2002:a05:6402:28c4:b0:43a:cdde:e047 with SMTP id ef4-20020a05640228c400b0043acddee047mr5753304edb.368.1657727102841;
        Wed, 13 Jul 2022 08:45:02 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906300400b006fe9e717143sm5122181ejz.94.2022.07.13.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:45:02 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     lkp@lists.01.org, Jeroen Hofstee <jhofstee@victronenergy.com>,
        lkp@intel.com, kernel test robot <oliver.sang@intel.com>,
        Richard Palethorpe <rpalethorpe@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        ltp@lists.linux.it,
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
Subject: [PATCH v2] can: slcan: do not sleep with a spin lock held
Date:   Wed, 13 Jul 2022 17:44:58 +0200
Message-Id: <20220713154458.253076-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
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

We can't call close_candev() with a spin lock held, so release the lock
before calling it.

Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Release the lock just before calling the close_candev().

 drivers/net/can/slcan/slcan-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 54d29a410ad5..5214421dedf3 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -689,6 +689,7 @@ static int slc_close(struct net_device *dev)
 		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
 	}
 	netif_stop_queue(dev);
+	spin_unlock_bh(&sl->lock);
 	close_candev(dev);
 	sl->can.state = CAN_STATE_STOPPED;
 	if (sl->can.bittiming.bitrate == CAN_BITRATE_UNKNOWN)
@@ -696,7 +697,6 @@ static int slc_close(struct net_device *dev)
 
 	sl->rcount   = 0;
 	sl->xleft    = 0;
-	spin_unlock_bh(&sl->lock);
 
 	return 0;
 }
-- 
2.32.0

