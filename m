Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D686B52D71F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbiESPMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbiESPMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:12:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE8CC142
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:12:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e3so6075592ios.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYUM9Hp1d5sabbtZb6luJU4yZ+5byuqgyPQE1mhLONs=;
        b=JzSMmah+FxGQaRWTBuVsfP27ouH5MKBWWdI1leSNqmZTJ6wdLKx8B+IEgV/XqZ1kCm
         v4rb3edqpdympwyK/AWfiM+xDFsz3Nj+cIlHP8zGwWhMIidXjnCCwb5fxwFyz7c8kgxR
         /kTBjmOg7OxyS3Gp4Geux+kRGD2d30Y3rcke207uYv45+toVudUM1CTeZd8OMsMQUKQ9
         GZm1muZTB3jEVSj5TlupQoeEYdVoFKNLsImibnsE0LqMI8vF5em1asnbWuX6aOQ5WQUh
         Mpg8v3reJ7a1XWT51TS9As18JZzNlFuRAlUMsYZ7IysEZs8qhVMafA9qqscXZyOqsCKj
         mYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYUM9Hp1d5sabbtZb6luJU4yZ+5byuqgyPQE1mhLONs=;
        b=3iKuG+LuRRtSV/Z9TARuOAbFw3qhiNLfoR77yMJWPOeSrjlkiFsZnpfFikIu8RN2m7
         1oqrtrV0SJArUqGL9RW5gXDTbA89NmwAKgDlbeAZIJU2laQ1ySBKgC+9Q3GrzFgRydnH
         3XUT0M/tZEjmIhsH6sxwIsPV1CKpcIFPWJp+Z9VXs5urlawggo3VqlKKe3joZ6XULs08
         zqmbaMS254mMuUuHBVWMbpcNEBPTVgtcOkId1+olLy90fJPG3cNkDKaJj3h09McFCTU6
         Axp0Vq5h67hl++aqwgrYbn8FkeBLZhM36aPMKuyxCF1/hLwWAddXKf20Dzi2VGBeNDx6
         WoHw==
X-Gm-Message-State: AOAM532eQeJulOA7SkWBMNoVVdPrmxZx2vBf7jEB80DdH1yJUfu7pa+L
        MiKnc09cIGmcPFO1mU0nJRfv6w==
X-Google-Smtp-Source: ABdhPJzTKkd0m7xtwQWy7LWH7Epps7ucmg/bNPXVPLgzjldn2w6B2u3+tKGUU34CN8dGFfPbDNKnJg==
X-Received: by 2002:a05:6602:1507:b0:65a:9eef:74d8 with SMTP id g7-20020a056602150700b0065a9eef74d8mr2862909iow.140.1652973141927;
        Thu, 19 May 2022 08:12:21 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a025b06000000b0032e271a558csm683887jab.168.2022.05.19.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:12:21 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/7] net: ipa: drop an unneeded transaction reference
Date:   Thu, 19 May 2022 10:12:11 -0500
Message-Id: <20220519151217.654890-2-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220519151217.654890-1-elder@linaro.org>
References: <20220519151217.654890-1-elder@linaro.org>
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

In gsi_channel_update(), a reference count is taken on the last
completed transaction "to keep it from completing" before we give
the event back to the hardware.  Completion processing for that
transaction (and any other "new" ones) will not occur until after
this function returns, so there's no risk it completing early.  So
there's no need to take and drop the additional transaction
reference.

Use local variables in the call to gsi_evt_ring_doorbell().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index db4cb2de218c0..5eb30113974cd 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1490,12 +1490,8 @@ static struct gsi_trans *gsi_channel_update(struct gsi_channel *channel)
 	if (index == ring->index % ring->count)
 		return NULL;
 
-	/* Get the transaction for the latest completed event.  Take a
-	 * reference to keep it from completing before we give the events
-	 * for this and previous transactions back to the hardware.
-	 */
+	/* Get the transaction for the latest completed event. */
 	trans = gsi_event_trans(channel, gsi_ring_virt(ring, index - 1));
-	refcount_inc(&trans->refcount);
 
 	/* For RX channels, update each completed transaction with the number
 	 * of bytes that were actually received.  For TX channels, report
@@ -1510,9 +1506,7 @@ static struct gsi_trans *gsi_channel_update(struct gsi_channel *channel)
 	gsi_trans_move_complete(trans);
 
 	/* Tell the hardware we've handled these events */
-	gsi_evt_ring_doorbell(channel->gsi, channel->evt_ring_id, index);
-
-	gsi_trans_free(trans);
+	gsi_evt_ring_doorbell(gsi, evt_ring_id, index);
 
 	return gsi_channel_trans_complete(channel);
 }
-- 
2.32.0

