Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57859575C57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiGOHaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiGOHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:30:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13ED7AC2E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:30:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e15so5223686edj.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHnTn6VhmtnfWqf0g7Gj+G785dxWqdgYwW9ZzmaeJh4=;
        b=AVIZkYqmlFqGyQyc7TgsQ34JecaSIs4T8qLG5N3Hp0xrVzxcXrS3uzP60Pb8HTdcmT
         NNGLnCb4Z9g7363Stm9NWRyWEhV7UQj1cA1KUh9ersScVzQznP+DuLsHeTVH54CzogV6
         sDh41C5MSXZZjAFvypRAwrByZXHmsniHxPdoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CHnTn6VhmtnfWqf0g7Gj+G785dxWqdgYwW9ZzmaeJh4=;
        b=u5gOusZAGJrQwuOsPWdmU2M1XpG+Dukh2SzSded6dymttiqUWfqE5Vz8owJMdO0KzV
         AtrjruCl8/2vWxL2QBAyI1NOzZpFm60Br2b7CSaow3fvzLFCb/hg8cwgz6UvJxw8aVqZ
         mr/wGBbc7uPWRqjOMR0RZKpm0egrWLPWVC29bVGNoDktxgP6aVJ3JvT1a8NiFTKIxbEj
         Kaj2hUtpPwnrm0JLtgUVyo5mqDtr6+eG4wCHYs21cV3pbl/mUcYC8kWzNcadQaDsAlFB
         fSOuGaGYAI/mgwz0zy/ddPuaf0RiChFJoFuomffCyTBnXAIDjW0F2MjacMIeaOCEjahU
         neEg==
X-Gm-Message-State: AJIora/vPYsKm0bpUqzJzAOdKiZ9h7TP1PXpfAFvnWisEjEgoJKpcNnz
        6RzAgZvmygX38I4HI9+MnzholJMg60ZMomy3
X-Google-Smtp-Source: AGRyM1veMbMMZYqaMJnj/C70UuvPpYLJnS6n0L96smOnFkBPJaiYLrr37MwwvBcLdyxnSZvMMZunqw==
X-Received: by 2002:aa7:c585:0:b0:43a:725b:9851 with SMTP id g5-20020aa7c585000000b0043a725b9851mr17229990edq.399.1657870207114;
        Fri, 15 Jul 2022 00:30:07 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-80-182-13-224.retail.telecomitalia.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id lb11-20020a170907784b00b007246492658asm1692756ejc.117.2022.07.15.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:30:06 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     ltp@lists.linux.it, Jeroen Hofstee <jhofstee@victronenergy.com>,
        lkp@intel.com, Richard Palethorpe <rpalethorpe@suse.de>,
        kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3] can: slcan: do not sleep with a spin lock held
Date:   Fri, 15 Jul 2022 09:29:51 +0200
Message-Id: <20220715072951.859586-1-dario.binacchi@amarulasolutions.com>
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
before calling it. After calling close_candev(), we can update the
fields of the private `struct can_priv' without having to acquire the
lock.

Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Update the commit message.
- Reset sl->rcount and sl->xleft before releasing the spin lock.

Changes in v2:
- Release the lock just before calling the close_candev().

 drivers/net/can/slcan/slcan-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 54d29a410ad5..d40ddc596596 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -689,15 +689,14 @@ static int slc_close(struct net_device *dev)
 		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
 	}
 	netif_stop_queue(dev);
+	sl->rcount   = 0;
+	sl->xleft    = 0;
+	spin_unlock_bh(&sl->lock);
 	close_candev(dev);
 	sl->can.state = CAN_STATE_STOPPED;
 	if (sl->can.bittiming.bitrate == CAN_BITRATE_UNKNOWN)
 		sl->can.bittiming.bitrate = CAN_BITRATE_UNSET;
 
-	sl->rcount   = 0;
-	sl->xleft    = 0;
-	spin_unlock_bh(&sl->lock);
-
 	return 0;
 }
 
-- 
2.32.0

