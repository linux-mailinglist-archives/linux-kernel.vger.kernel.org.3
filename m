Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3850A778
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390964AbiDURyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377741AbiDURyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:54:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C384A3FA;
        Thu, 21 Apr 2022 10:51:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s25so2851823wrb.8;
        Thu, 21 Apr 2022 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIOQLVETTpe3oazXPSLlxXYuEyunaEzJOFdoVd+MyTU=;
        b=GeduT2DIEMlZp0eQUJ/PLGQNyME6DfR+H9MwaQ/0gagJgPccM3LV8a8M10pRXRuFxa
         3K8fq3j3dnEmWSCyP/+qBzBN2RX0mhNn4NhuSUKk5EPeIrmUjj0AsA2lkLsSVjy3St8K
         pIUWoWo+Rb37aL/w6395IOATaSFqkfFbOr1rFMCPrgsoNxHBbkiq4UVkMoDSkjAXKLqM
         TrKnvjNR+zhp/7T97u1Rr6wmooqdQYk5EnCJqGbZvUZtrhqWqy0n6ER4YazDDFI1Mibk
         JbIQzZCLnofCYqLtCH6sFGtWc/QR/obzwtPiexkHoth3cCUQKX0PbUwcN1CKcQgpPV5p
         Xvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIOQLVETTpe3oazXPSLlxXYuEyunaEzJOFdoVd+MyTU=;
        b=PNp1Lqm6yP9HVYuqT1h14bdKnuh93bk8fKXFcIH1KGxZjwoj4AnmuUOxH8yke8bwH/
         v8+HnrzgWdGfGgfoZDLDsXtimmHdw08pLFGmruEY/zGO7kCjl4UCXmuYmaU9WUDBykAT
         psATrIVyoPZLGgm4/jd2pJmQdFKRMZhWeCLDZFoKqGPfqupVdBCa3JANvHeNUGKqdHgl
         +qIUyqDUbOnqfYKOVF1FWf5Azjhr4TC6K66Mo2hjDVsaTN6+JBZkqPeEmrQ9s1nn7UYz
         uhB7vxtTDgNpuQ/96LAV+ESyd77AhIsvoPgPb5ASd+YLXztD+30FJiu4J3rXX6ltwmbm
         fMPw==
X-Gm-Message-State: AOAM532XajJWfG9odrFvteiZssD7N6/y16mKPdbSP54CsOd2rRF27fUO
        aEapBNCcJiEpMzFXOT+mV8o=
X-Google-Smtp-Source: ABdhPJwSF1Xqo5hPAr/p9AVte7wvpvxqEDyiL2pF8X3B69/9ajN0efTQksgtrHB6tijw8xJfECcp3w==
X-Received: by 2002:a5d:6211:0:b0:1ef:85dd:c96b with SMTP id y17-20020a5d6211000000b001ef85ddc96bmr642720wru.456.1650563475181;
        Thu, 21 Apr 2022 10:51:15 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038ece66f1b0sm2685634wms.8.2022.04.21.10.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:51:14 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 3/5] HID: uclogic: Pass keyboard reports as is
Date:   Thu, 21 Apr 2022 19:50:50 +0200
Message-Id: <20220421175052.911446-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421175052.911446-1-jose.exposito89@gmail.com>
References: <20220421175052.911446-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kondrashov <spbnick@gmail.com>

Allow keyboard reports from interface #1 of Huion tablets to pass
unmodified, and stop the Wacom X.org driver from handling them.

The method for the latter is rather crude and also take the Dial reports
from the Wacom driver, but it's expected that libinput will be able to
handle them (still to be tested).

This enables Huion HS611 media and desktop keys.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 09c332c6a412..b85585ac3372 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -711,8 +711,12 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	iface = to_usb_interface(hdev->dev.parent);
 	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
 
-	/* If it's not a pen interface */
-	if (bInterfaceNumber != 0) {
+	/* If it's a custom keyboard interface */
+	if (bInterfaceNumber == 1) {
+		/* Keep everything intact */
+		goto output;
+	/* Else, if it's not a pen interface */
+	} else if (bInterfaceNumber != 0) {
 		uclogic_params_init_invalid(&p);
 		goto output;
 	}
-- 
2.25.1

