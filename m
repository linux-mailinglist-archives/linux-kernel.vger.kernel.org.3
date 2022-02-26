Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260D54C52FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbiBZBTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiBZBTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:19:36 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E93C18FAE0;
        Fri, 25 Feb 2022 17:19:03 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d187so6143930pfa.10;
        Fri, 25 Feb 2022 17:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Xf19W65T+aquV1Z1erkfVQlxQTRcO+WOHA5YfbjFpt8=;
        b=a8tbBrwGlVOHOsnoyKWhOvTDR1Cf9SHfvKAVNRRrL7COKs27aA6ywdStVwjvpCXGst
         GYJcMo2dbLdt8cAxbDNytTj3oPENWquE/I3gzxBTCIg3cmbM402ZUc/h6KgCeZoGbQnE
         mzMLEdZPjd9QidlBroktklkDLtHLtxtWoed92992F7DF42S4l8KuRRlf15SLOWGnpvMW
         S9vrOsG2Agrf0N3ZNlvTDfg5UqL1DN1l2C/XR733whZcU9e3WmtX8WC7lPpsb7pc0qb9
         HetdyFCOfSpEFKsDstYSCH7KInVyra0yb9zJ5T3SW6sYAbO+esjs1U2Q8EucNduZ/OWZ
         LNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Xf19W65T+aquV1Z1erkfVQlxQTRcO+WOHA5YfbjFpt8=;
        b=k9mlnR1bY1fS6vMnYJ1HZbrrlwW6JHdMnpnlsUYGrW8CjOq7uTpALMfJpQnnTKtP7O
         ZqUVPG/dsJvGqEF5KYxYdcsNqRrW4s7I6PJVzXMIU4cnjVC9BviLa/ZwdWA14qOb9PQ9
         FZ7QwIZkkEAgujIsk7M3DYiVZupFcT7LXLcJ3bVzLfOR5/ZQlaG2qQBtqFR+Nq9s0qVn
         6fpC5hTHsesFMRwknh0cfOh044tmHqPjBNFRtIYo6hjhZ3Mvwazn2tbRPeI8HdOEYbwm
         iEiOdcgRcZMLFNeGzEdYfgxd/iLlcb6gu8MyINkjmSNhMrG+ta8EmiHYG3TxOrdGr17j
         4eDw==
X-Gm-Message-State: AOAM532Tac8/b1yHA6bicR7sgeQRHtkSze8z5+Pr4z3ftvsZZ1sNaERY
        5E+wexq7/FlCRfX1SxmKX4I=
X-Google-Smtp-Source: ABdhPJwjeRTDm7011IRGtBPbDTV0Te++YAWJ7c4gjaYcwyX8DUUeQvuL0nuNYtqh58upWEp1j5boLQ==
X-Received: by 2002:a62:e813:0:b0:4e1:922a:2a6d with SMTP id c19-20020a62e813000000b004e1922a2a6dmr10660636pfi.50.1645838342573;
        Fri, 25 Feb 2022 17:19:02 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a91a:1bbf:dba0:d0eb])
        by smtp.gmail.com with ESMTPSA id j19-20020a62b613000000b004e1b0df0713sm4197867pff.188.2022.02.25.17.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 17:19:01 -0800 (PST)
Date:   Fri, 25 Feb 2022 17:18:58 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Sean O'Brien <seobrien@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: vivaldi: fix sysfs attributes leak
Message-ID: <YhmAAjNeTjiNoLlJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver creates the top row map sysfs attribute in input_configured()
method; unfortunately we do not have a callback that is executed when HID
interface is unbound, thus we are leaking these sysfs attributes, for
example when device is disconnected.

To fix it let's switch to managed version of adding sysfs attributes which
will ensure that they are destroyed when the driver is unbound.

Fixes: 14c9c014babe ("HID: add vivaldi HID driver")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Compiled only.

 drivers/hid/hid-vivaldi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-vivaldi.c b/drivers/hid/hid-vivaldi.c
index efa6140915f4..42ceb2058a09 100644
--- a/drivers/hid/hid-vivaldi.c
+++ b/drivers/hid/hid-vivaldi.c
@@ -144,7 +144,7 @@ static void vivaldi_feature_mapping(struct hid_device *hdev,
 static int vivaldi_input_configured(struct hid_device *hdev,
 				    struct hid_input *hidinput)
 {
-	return sysfs_create_group(&hdev->dev.kobj, &input_attribute_group);
+	return devm_device_add_group(&hdev->dev, &input_attribute_group);
 }
 
 static const struct hid_device_id vivaldi_table[] = {
-- 
2.35.1.574.g5d30c73bfb-goog


-- 
Dmitry
