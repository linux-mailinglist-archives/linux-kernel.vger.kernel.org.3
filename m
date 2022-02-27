Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D74C5C95
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiB0PbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiB0PbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:31:00 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD1A3FD9C;
        Sun, 27 Feb 2022 07:30:23 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id fc19so10561197qvb.7;
        Sun, 27 Feb 2022 07:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPaFw68OuUtIuwUUWQ/YAMH/m6245D2UW9piC4irepM=;
        b=QjB3W0OjDdzllkWrrmQj4sqoi50Fvkt6qRrBwOXAUqncAhnM0ubVGdfmosWjbSAOqK
         SpjC5XeVyn5sxZftrpPDEzXijzLQ9ppZ8G6omobntjgUBWZIpiCLnJyuzAhU+MKn7oHh
         kUWlbpdTh6XP7k5W8A2VwZnyymPSpt8eHgqNQNo8I+sU7wsVkLjl+bmEUEyus35F0rKd
         6SlD41h444MhU13w3dyabf+U+dhquTPZ3cYjqoP0BL7XRcYXg5Arae4LlA0IgsCv6aKf
         9wkJXRm1b2DbU8uXh1Q8vq6/VdC/TmvyJQV/2Ss+n5LxBcYIjBY86U7EFC0pCFPkRMgj
         AXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPaFw68OuUtIuwUUWQ/YAMH/m6245D2UW9piC4irepM=;
        b=2ccwNCwfr0mYQvf4XeXi1qQEnN7UzCmzsZZcpeBu83PMIN7SzYiBxMwCWZw1BpMnVn
         aZKGz0wZ5HiW86aHQ0JVFcjfGhiMTtbzOzIzfPxg5pIXufnMi3psWXtsB2QXQjKrfd+O
         rdh38zmAFXppinKLxlp0r3ifFsoMpP2AdzMYfrfdBrRG1MuQJIz2PDlLw8PvNq6Ex2EF
         aOZRva3xF2GZF0n4imsXOrNLmctojU7ESP/NmMBJ/xvBadxx/g+x5jqGJljviS8Yo+4h
         RP7K5vICLCE2LsWDLmjruftHfz/jWgI6ujXse0gCIEhFNiHb8f+AtOqguZnIjRGACgFm
         XDgA==
X-Gm-Message-State: AOAM532bjS39tJsjauvXB9TqwyNEZB+KD4D4rZCVowSTsevBuOXWSKoO
        9xW14Ejrg1kuBS0I20Y6JsOqO2AcvRD+OQ==
X-Google-Smtp-Source: ABdhPJwkNiMKD4sq0eim8Kc7aMuv/O+aOeFGkOcC5q2lyFBzrPzgjJY5l22E0FN1OyJTUxaIQic55A==
X-Received: by 2002:a0c:e04c:0:b0:432:4007:b7de with SMTP id y12-20020a0ce04c000000b004324007b7demr11520611qvk.53.1645975822748;
        Sun, 27 Feb 2022 07:30:22 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a080a00b0062ce6f3f5d7sm3845767qks.16.2022.02.27.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:30:22 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, jbx6244@gmail.com,
        Bin Yang <yangbin@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode
Date:   Sun, 27 Feb 2022 10:30:13 -0500
Message-Id: <20220227153016.950473-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227153016.950473-1-pgwipeout@gmail.com>
References: <20220227153016.950473-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Yang <yangbin@rock-chips.com>

In the 3.0 device core, if the core is programmed to operate in
2.0 only, then setting the GUCTL1.DEV_FORCE_20_CLK_FOR_30_CLK makes
the internal 2.0(utmi/ulpi) clock to be routed as the 3.0 (pipe)
clock. Enabling this feature allows the pipe3 clock to be not-running
when forcibly operating in 2.0 device mode.

Signed-off-by: Bin Yang <yangbin@rock-chips.com>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/usb/dwc3/core.c | 5 +++++
 drivers/usb/dwc3/core.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 18adddfba3da..416d83a055fe 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1167,6 +1167,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->parkmode_disable_ss_quirk)
 			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
 
+		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY) &&
+		    (dwc->maximum_speed == USB_SPEED_HIGH ||
+		     dwc->maximum_speed == USB_SPEED_FULL))
+			reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
+
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eb9c1efced05..ea3ca04406bb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -259,6 +259,7 @@
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
+#define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
 
-- 
2.25.1

