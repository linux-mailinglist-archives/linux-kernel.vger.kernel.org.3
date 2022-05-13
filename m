Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4752525BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377560AbiEMG5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350833AbiEMG5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:57:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885351E5D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:57:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a6-20020a056902056600b0064b3d5c324eso5779443ybt.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iDPt3SFY7fcmY0YfnSfRRxdWeY/8Vlzh36Vkje0XzM8=;
        b=KaXHXBnRmMjnME4ARQhlwdpDglwTrHCQhEetad85l4axhrmYNyRHwHqNphN5bwcCuI
         +L63ZYMzUk3mwHr6PslYVF3h2yCPQZQ7f+8y3aLC25ST8PjIpdwOxF5mFky7F2GC1SuH
         LRzA76T9ZIw+J2uinFknSgKzHVgM/CyjPu3j2VhHece0/lHuqeXQNGRrcJdSiHFRQcsk
         Z8sDJXyhyreY74vzyrf/eXCdrMWtTRFnnuoKvlzvdJONTkRoLiny7KfFhtZmEf44T6lJ
         lV5E9wN4AkmYLdMBuI5zExltcJOGM8nLxjV0isQMpbPU9eHergU87xpQj3wv0y1mdKkp
         H4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iDPt3SFY7fcmY0YfnSfRRxdWeY/8Vlzh36Vkje0XzM8=;
        b=wUyfFq8ppAZ6pru1n2gDhpFTpRW9fm7Tio42Yt5BMZk1E+DFHv63ghz4cAPF1Kps3Z
         Hxmr1ANlMI212t9sK97581NvHeJX9tg3ZyOhxkRn0MIjQ38YuBTrlXUudA3YximXBwiF
         okXFK/eT+Loniyos4BNdGVw85J+Xc3+8nogA5gme/uNqwtr8xwv+Y0Q5M+0kySzODFN+
         pNfh5fwc01tpP+rXPsxdM1juUeU7exw/PX0q5BIT4QPMDlTSFZWoCoBgSFY2a6TS1y+n
         SvvAlyvCMrWA+X4LOl3khmGvR/TaMqhN7YH2WwcWYIpY4q/DCW2qKcuoZGRmrUS5yJEP
         zcdg==
X-Gm-Message-State: AOAM531BrfEeozLMR6/nXtVsyi0IQfcYP5M/aZsLgo/H9D67faeVdvCa
        iy7p2cha8GntBQmydfJRrIxt8yXBrkwJ4Ux+a2I=
X-Google-Smtp-Source: ABdhPJzR2FqMzEWeouqvc7K+YFz+tyGiM4HdBZASAo1RyxCnH63pwIuEJrvyZoefhM01ChR/twOwh0DyADq9SynlaEg=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:e637:c057:4cc2:c7d7])
 (user=albertccwang job=sendgmr) by 2002:a25:848b:0:b0:648:4e74:bf92 with SMTP
 id v11-20020a25848b000000b006484e74bf92mr3312015ybk.364.1652425035948; Thu,
 12 May 2022 23:57:15 -0700 (PDT)
Date:   Fri, 13 May 2022 14:57:09 +0800
Message-Id: <20220513065709.1606634-1-albertccwang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3] usb: dwc3: gadget: Move null pinter check after window closed
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
 v3: Add change log to be compliant with the canonical patch format
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

