Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A85248FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346306AbiELJcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352063AbiELJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:31:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05016129F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:31:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so40839057b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NwDgfb40ABLeF/4wC4EwhuT4Q1PDTckj0pFciejqkLU=;
        b=ec8MLKTMT2o+jDVzDjA87qLPemLf9Z+I4AQOrMY8QoGg7dRL05HEbTWYVdx6amvBJC
         4lhlj6TAYbQbbo0qrQHVheFenbABa+C60YA4QIYGAJTBnf4jEzZUcvDD9eIYXdZO3WRU
         blqLsxAvpVOoNIMlmI9vjeKooCgz98otGs8T4DaUUFR17T/iDvrjurp2ujOw1uVPH3b1
         509JVTtAEMwZztSC1mv8KDGDyg905FHTZ+38H3kR5zeBA5EfqPfiUynscXI4H/4Hmqdp
         nvaXhTOEz7m70CQhUMCNwf4JHKXgI7gZQw0Rc/K/PiJFOfBUWJh5+6RFt4V2mpUoa/vL
         +e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NwDgfb40ABLeF/4wC4EwhuT4Q1PDTckj0pFciejqkLU=;
        b=ynIg3kDgZ5Y5CVt9l047Ind0gnd+SD37geaZFvsC/T1M5KDlHaIUw3UbHEUetFP+w9
         zPkWnb00XlRQErmWWqVaY3+agRnt8ctfpQAvaFHxmgpCZm7YrWpcuRYzlDqRjD6M6AiQ
         2kNiJMX36nYKCVxgG+hwHDtqePkoVE4BUsKfyV8OzRr8GRNQtmrIGQLpzJe2EOJU7A1D
         QupsQGO//6clGpb/8YION7B0EuGNxKm8Y3EIGYYZOurl/DZvf2q0Jq7IJPTqZPfyQ83O
         hQbHSpZuaADsap5gQGdj1oTRgqP4tWuN4MS6wFS4A8FM6kwWMPssyIT7VsOockXSi4VB
         vycQ==
X-Gm-Message-State: AOAM531ovudN1+BwJ3HD2itNUgKX9fCB1/bE2r0DB1FRdtcqU3Zq09HX
        XT1XugdFo8M+AqahPEW5EBpScOZ1bd1CR2QJK7Q=
X-Google-Smtp-Source: ABdhPJzdglJecWxP6D2OZDCbt8U8bxbqo8komBdfAEQ2BpEYkFp8T8Lc0iAA1ROlyN1jw82ZrqK2VKM7K+4aZGv4HvI=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:8983:2d2c:f62b:626])
 (user=albertccwang job=sendgmr) by 2002:a81:af59:0:b0:2f4:d869:b5df with SMTP
 id x25-20020a81af59000000b002f4d869b5dfmr29984657ywj.367.1652347913055; Thu,
 12 May 2022 02:31:53 -0700 (PDT)
Date:   Thu, 12 May 2022 17:31:46 +0800
Message-Id: <20220512093146.1301669-1-albertccwang@google.com>
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
 v2: Remove redundant 'else' and add additional comments and more
     descriptive commit text

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

