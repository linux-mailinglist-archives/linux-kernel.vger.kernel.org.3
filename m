Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322D852445A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347622AbiELEh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347548AbiELEht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:37:49 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A23286C0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:37:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x4-20020a1709028ec400b0015e84d42eaaso2146923plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rc/b171eEbEHOcZ7/65TQW8GF+vL+OBn1WLQqFshNME=;
        b=Dc8S7aaRKMlDer6zT72Yq6vWe2t3Mq53+blU/I4gv0bMRmn+5rx/JqZmKkcleUXrKz
         R38rBX7mdy/ho+yWIPY/2vqvH/geclVvPd3FleGn2jf79tXm5aPpOBiddmPlvM74/otT
         7c/QXDAjLGEM7m8boPKze/sT+FgHHPZlmX3ercRPeG+3X/Vy1M/FgYuZoHil3VrbbhbR
         k8iJYy+xf6nOa6NtRlpKOtzWi+0m7C9g1owr7IG4tVbFJgX2hG5hA08QihzctvkocFqH
         jcBxpHBKPfSsqP5+1YKp/KrxXYtiQD9lvvRMoqhp1lJmUMnC+rpn9kEXrnOQHoxQOCBb
         U05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rc/b171eEbEHOcZ7/65TQW8GF+vL+OBn1WLQqFshNME=;
        b=6cIJxwbPpntXROxgO1cyE2SmYyIZspeKZSbgK9WQQ7CNyTxs0Jhv//xKpRX63aRo95
         Z2UDuEmJsbhyVmMYugQLxzMwvah3apfgfJCTAnp30xEHtQu/YemsvXzcmR4m5L9Xnn60
         /aMng9NGYyC5+WTVYFWoskYIvvJd8CdrY9NGdFUk5243EIkcWGQd6nOEIqjuaZ2PrDBf
         qoUOMD5ftYON05wgSdFasESLmm7nxz11zT3AJE13wHNTb4ZmDnk/Dvzi7bAsdcIG7k2z
         CKBvG2tGO41iAKzjUa6e5KaKrD36pySdHGzY5Z6eQ0avrskJHJZ9Qah/xVRWwRn7wAXh
         IY0A==
X-Gm-Message-State: AOAM530Tjns90T5NgV0jvpYw8/CTWmNMg+DTZZJFoEm2kBeVnVy8Ksu4
        kJcReiUMi2x3i859PnFg3WtBtrUVarrex2k3Y8o=
X-Google-Smtp-Source: ABdhPJxPx8NE9mhNjd9A52lMRPB9i6nr6yPV75/2jKbabGX6KHDl4XgMws2oMFSoQx8N9KeM8zKZyZCRPaK3IT3k3MA=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:8983:2d2c:f62b:626])
 (user=albertccwang job=sendgmr) by 2002:a62:e819:0:b0:510:693e:b20c with SMTP
 id c25-20020a62e819000000b00510693eb20cmr28178767pfi.60.1652330266640; Wed,
 11 May 2022 21:37:46 -0700 (PDT)
Date:   Thu, 12 May 2022 12:37:39 +0800
Message-Id: <20220512043739.1234857-1-albertccwang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2] usb: dwc3: gadget: Move null pinter check after window closed
From:   Albert Wang <albertccwang@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        quic_jackp@quicinc.com
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Albert Wang <albertccwang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After inspecting further, we do see the locking is implicit, with the
main gotcha being the unlock/re-lock. That creates a window for a race
to happen. This change moves the NULL check to be adjacent to where
to it's used and after the window is "closed".

Fixes: 26288448120b ("usb: dwc3: gadget: Fix null pointer exception")

Signed-off-by: Albert Wang <albertccwang@google.com>
---
 drivers/usb/dwc3/gadget.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 19477f4bbf54..fda58951cf27 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3366,14 +3366,19 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	struct dwc3		*dwc = dep->dwc;
 	bool			no_started_trb = true;
 
-	if (!dep->endpoint.desc)
-		return no_started_trb;
-
+	/*
+	 * This function eventually leads to dwc3_giveback() which unlocks
+	 * the dwc->lock and relocks afterwards. This actually creates a
+	 * a window for a race to happen.
+	 */
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
 		goto out;
 
+	if (!dep->endpoint.desc)
+		return no_started_trb;
+
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		list_empty(&dep->started_list) &&
 		(list_empty(&dep->pending_list) || status == -EXDEV))
-- 
2.36.0.550.gb090851708-goog

