Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7857F9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiGYGz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiGYGzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:55:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E358912747
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:54:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id oy13so18855949ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsO3FO8JgkL2eEGAFz/IqcQFBC6RPDGVM/v5Nl88GZc=;
        b=DDAXmyNUZ8AadIbDZexvUGtNxH16qExpXW7ZnSpyXqSPGDgESxXfwkpkOytnmn+FYC
         hK7BjBbhMaUIAwJNG9HiBwHMPnMDRy+fUnIzTX/bU20sIKHz1nvgqwLtcB6O/SLhyXi+
         BQ03QxIxBxFQ6dDGednxZOSEFjp2kG8lugnlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsO3FO8JgkL2eEGAFz/IqcQFBC6RPDGVM/v5Nl88GZc=;
        b=oME5xjb8qqXeEDnyq22hEKz+JO4pUhMIuzT3EdfOO28m59XUae49bAHyuss48yylag
         f9oAcXnwNgSm+XBGJqdCwBbat1B/2plxKylVA8ZTsCpCp01h27haBzBJCACUbAjCKZHt
         hszX5OTUl1siwyrkZRD9G6U/bDqY0xBAT5PkhnMncZ1FthOV1P2IPp29Fqgtes6WkYvJ
         B1Y+yQSBqgSgXwoSIoOMAD00kXi/OSqltNm8MeCiwz8wqdOMiiN/Wf8pOHAG4n6XBWZR
         LiIByHK+RhyEjB9ec0/fNGR+jcdWp3nSyClwSFhFtw3KVoJYbbsGKd8jyJt4KQqf8idE
         ZOfQ==
X-Gm-Message-State: AJIora/i3n1EKRL9UTOpexpFZNu9J0YeycnEyd5MzTc2EuQS4/2uM3QY
        hk6bcPZAz6NiHof9wmzNnZPGi4JIjmXqbg==
X-Google-Smtp-Source: AGRyM1thfMcjNltPAPoL06ihoDhX0dNExFvtEv/6fgOma/iRFbrtxb4ZH+0zUeCJg/tJ19rTwMEzhg==
X-Received: by 2002:a17:906:9b95:b0:72f:c504:45e with SMTP id dd21-20020a1709069b9500b0072fc504045emr7913376ejc.345.1658732065462;
        Sun, 24 Jul 2022 23:54:25 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-14-98-67.retail.telecomitalia.it. [87.14.98.67])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709060d4200b00722e57fa051sm4967711ejh.90.2022.07.24.23.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 23:54:24 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 1/6] can: slcan: remove useless header inclusions
Date:   Mon, 25 Jul 2022 08:54:14 +0200
Message-Id: <20220725065419.3005015-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220725065419.3005015-1-dario.binacchi@amarulasolutions.com>
References: <20220725065419.3005015-1-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
- Re-add headers that export at least one symbol used by the module.

 drivers/net/can/slcan/slcan-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index dfd1baba4130..c3dd7468a066 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -46,9 +46,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/rtnetlink.h>
-#include <linux/if_arp.h>
-#include <linux/if_ether.h>
-#include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-- 
2.32.0

