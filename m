Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E3B4BE81E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357420AbiBUMMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:12:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357364AbiBUMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:09:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD56201BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso13390506wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WbusBDevTL0id1+rC6qLSGi8eX9Tec+0gEdUp6beE0=;
        b=D/T2RPldzgpWaePTaWvFPRInmTGPvf5JQV2GkaAY4ibltSxUGvo267U3iNBvxTTNVf
         oXgkIEryAs8WFCi8dNoB0wHLcM4GAuZ02L1fSj+7wu84dKzey4l7F/ctcAAC+8Tncay7
         2DXF7IOzXCF7JtZvr4rWoTOGYLmmotDBg/0Ij/PUQeZy86dO/RFVogFYAwxMuOQrAOjb
         FnDjxhbedsPEUBohewERqQvuUbkUKCqoQjT5JTMxy4ZbonuZwrfYj9TLXXW8yPeacSZd
         sOOx9U/UEXhXCV1h1mX+Mqz2OFFhsMbokU3w8p2zTaJOAngv0/lpFrKLeZ+Dg7U7rU3o
         LrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WbusBDevTL0id1+rC6qLSGi8eX9Tec+0gEdUp6beE0=;
        b=B4v6jDz1Z0aajomIJU3WXRF1TdispRLnFOTgcK6zoIk7alzlZQyrrpB6Gti1W2Njry
         YXFAMswXbTgTTCvddPzfRz4L/nHw6tuS2KE0EGcHcPqdb4bOHtTnAIY/+c98gEgEVtOK
         slnWjIL+pcIiE7pz83WHyIYfTaBIqZeF89Ia/VEXKC0JZI/mABp2mpGPIblIoAvK4frx
         g71lfgItNGMPW1LtH1iq8UlMOXm6DRHt/+tYnnaRP9mG/w3WUoe+upm46i1uypGKtYwj
         5U3sX8hZLHLGmCYc46OPyaD0t5KdQRJMPBn5nYA7HWW5TtVeq8+DPZWNIL9/mAdGLf6F
         EgqQ==
X-Gm-Message-State: AOAM531GfLRfBoppA0h9jAPKwkbLLnqdnpdEnswt4bZJaXmTXqbXUL7f
        C5V2l17QFOQBV339+pFc7OHb+Q==
X-Google-Smtp-Source: ABdhPJyA8PlOfDHHxH/OqNVLLFns7QOhkyM6XRROGBV6oQogaZvQ9JL5vuO0S3f6KL+yexhcV87zBQ==
X-Received: by 2002:a1c:7c0d:0:b0:37d:1e29:5cc6 with SMTP id x13-20020a1c7c0d000000b0037d1e295cc6mr20767654wmc.31.1645445324664;
        Mon, 21 Feb 2022 04:08:44 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a8sm11821546wra.0.2022.02.21.04.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 04:08:44 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        linus.walleij@linaro.org, narmstrong@baylibre.com,
        ulli.kroll@googlemail.com, wens@csie.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 5/5] crypto: engine: check if BH is disabled during completion
Date:   Mon, 21 Feb 2022 12:08:33 +0000
Message-Id: <20220221120833.2618733-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221120833.2618733-1-clabbe@baylibre.com>
References: <20220221120833.2618733-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing iperf over ipsec with crypto hardware sun8i-ce, I hit some
spinlock recursion bug.

This is due to completion function called with enabled BH.

Add check a to detect this.

Fixes: 735d37b5424b ("crypto: engine - Introduce the block request crypto engine framework")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/crypto_engine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index fb07da9920ee..6056a990c9f2 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -53,6 +53,7 @@ static void crypto_finalize_request(struct crypto_engine *engine,
 				dev_err(engine->dev, "failed to unprepare request\n");
 		}
 	}
+	lockdep_assert_in_softirq();
 	req->complete(req, err);
 
 	kthread_queue_work(engine->kworker, &engine->pump_requests);
-- 
2.34.1

