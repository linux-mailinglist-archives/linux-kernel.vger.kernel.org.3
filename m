Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA2657703B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGPRAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiGPRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:00:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EC81FCC4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:00:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eq6so9978188edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yd81WywVreUCPKtVR38dM58arAjDVuFKjNWVnevwfZU=;
        b=X6UeE44psPVlTHMwYVOPKZTNB7yYCcjlID8BwyJAPuAvovOAJo+d70fvCYaQoityzi
         M+mAXKBKaqFvxJ2cRj/VW5G3+oB9vTZUbjvhtV9PDLms/RZornR98VORDMpR05NTWBRx
         Oe+tfs+gpwSXltXX6Sx64xl3jGRzZRjKK8EoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yd81WywVreUCPKtVR38dM58arAjDVuFKjNWVnevwfZU=;
        b=BVh39cEnDrEc8T3qBp2D4YvaqTxCXndeWK+8rfqYSE5ANk+V2ODe5Ou7pTzuKkzlM3
         XDCOEcd+TjGVySi5zIWSU+IZnVqkizKXsh8VdklBd6WDa7qJ23MJvuF03cRIlIE2BUHo
         SsFW31T1PFRRpBYsuJ3Z4+kOBwwAqoIO6t4jJYlx+pjA1dHnJdxLia6qR+2DcYPiKXGT
         XLoeC6mcf56oE3grvmpn2P8Pk7/9NVm8KO+ex/nYTEXuXbxwuQEBSmxiX5b0NEQqRBWW
         DnBqO7dNUE+ubdLe0PtbNbbA2/3U2fYATrYSXbbO6+8fIogyWVlyszGGquCnnhP7xdMZ
         SfRQ==
X-Gm-Message-State: AJIora8pN0s+vTr2iRtneTqcXz0o6fgTPwpyJAnC3jPLL0Xj5uPRe82/
        nxlYXjVUMAW5PeHTx0kd48ksE8R2w3Ke9w==
X-Google-Smtp-Source: AGRyM1v+gcC/2/bKQFhFrppiscuOUZNoYfDrLj9UeftfeuxjrF35z5i5ph11I7PSgrJihuRhb1GnFw==
X-Received: by 2002:aa7:d64b:0:b0:43b:1f5d:1443 with SMTP id v11-20020aa7d64b000000b0043b1f5d1443mr19322822edr.370.1657990813572;
        Sat, 16 Jul 2022 10:00:13 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b0072b14836087sm3363135ejo.103.2022.07.16.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 10:00:13 -0700 (PDT)
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
Subject: [RFC PATCH 1/5] can: slcan: remove useless header inclusions
Date:   Sat, 16 Jul 2022 19:00:03 +0200
Message-Id: <20220716170007.2020037-2-dario.binacchi@amarulasolutions.com>
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

Include only the necessary headers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/slcan/slcan-core.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index dfd1baba4130..3394d059fc29 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -36,26 +36,8 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
-
-#include <linux/uaccess.h>
-#include <linux/bitops.h>
-#include <linux/string.h>
 #include <linux/tty.h>
-#include <linux/errno.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <linux/rtnetlink.h>
-#include <linux/if_arp.h>
-#include <linux/if_ether.h>
-#include <linux/sched.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/workqueue.h>
-#include <linux/can.h>
 #include <linux/can/dev.h>
-#include <linux/can/skb.h>
 
 #include "slcan.h"
 
-- 
2.32.0

