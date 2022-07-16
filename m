Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDCA577046
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiGPRAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiGPRAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:00:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EEE1FCFE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:00:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z23so14046776eju.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHx3+JjARcVqLchAq3IBsPDCyyKS9HCXdr7RVf+WDMo=;
        b=mGoolG7fvxZVYt4/cOxod+dCqrOJ8LVz2j/jFt4HPC6fRE4doXmY2PMHp7wEwzmXpF
         Njm/1kC8mhEmuFQ80OpE+7FDElhEELWtuK8WntfnFda/c27FwckO5ngy2VPCZLzck1lf
         iyQuAu7VgiTKj1ldNuqE7UbT1Y5/avPsiv4ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHx3+JjARcVqLchAq3IBsPDCyyKS9HCXdr7RVf+WDMo=;
        b=FgjfdY8xunaWQ7kaXopnbARIZ4IqAepJb4mh2SYAEVV/mWLLMk+b6w4HuwKS8Z5oJ1
         I3jXqKRTj8WnS8/NZedCsZUPkafTDBjTiZScdbXV+uIrx/7+me12eBFj25Kj+OlLk7sI
         LDbXwD6LrB/5m/EBBjT8xDO218iA8kSRVh+yhVMkx++YxcJ2VypILhGV8THc6TcqDmuo
         PNkm4sinP5EoMMmDmtOhc5WJo1oYpot+D0Rfnu8iS+AbnWoiO/XcyCpk9xdXnOmOqhMJ
         qAC+rWd0QowhN6PU50+wOsB+9ima5PhDffE9/jkqA7DTzcuKVTgR9Rju0A4o4nOK+n0q
         GwFA==
X-Gm-Message-State: AJIora88ZlAQEfUaX4Nsiz5avsqqLMOrcWNgVlehzBIiL71+pMAriszn
        Rn06WliPXzY470phKcGC0etUuz4CMLaPIg==
X-Google-Smtp-Source: AGRyM1uF88RQH57CRh5vVpqwIC3K2c4oCtDjWaX27PtCv7WQqDeB376TmsjSDwXoYH10UWprZZS6yw==
X-Received: by 2002:a17:907:7294:b0:72b:1ae:9c47 with SMTP id dt20-20020a170907729400b0072b01ae9c47mr18608911ejc.253.1657990817736;
        Sat, 16 Jul 2022 10:00:17 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b0072b14836087sm3363135ejo.103.2022.07.16.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 10:00:17 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 4/5] can: slcan: use the generic can_change_mtu()
Date:   Sat, 16 Jul 2022 19:00:06 +0200
Message-Id: <20220716170007.2020037-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
References: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useless to define a custom function that does nothing but always
return the same error code. Better to use the generic can_change_mtu()
function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/slcan/slcan-core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 093d232c13dd..7a1540507ecd 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -727,16 +727,11 @@ static int slcan_netdev_open(struct net_device *dev)
 	return err;
 }
 
-static int slcan_netdev_change_mtu(struct net_device *dev, int new_mtu)
-{
-	return -EINVAL;
-}
-
 static const struct net_device_ops slcan_netdev_ops = {
 	.ndo_open               = slcan_netdev_open,
 	.ndo_stop               = slcan_netdev_close,
 	.ndo_start_xmit         = slcan_netdev_xmit,
-	.ndo_change_mtu         = slcan_netdev_change_mtu,
+	.ndo_change_mtu         = can_change_mtu,
 };
 
 /******************************************
-- 
2.32.0

