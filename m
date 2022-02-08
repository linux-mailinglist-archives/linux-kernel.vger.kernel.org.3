Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2984AE160
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385422AbiBHSrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353557AbiBHSrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:47:40 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4D4C06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:47:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x65so5919876pfx.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3J0QKkr84VrudaJ3bhOXmAFtwa7Bv5tWoh+lneUqWM=;
        b=CXeTCXrzzT3Ml1fOtNTfQXwkPNlG/WSDsQlqTW/zEywRyF7j0hBThR0OpQtEw29wF5
         THBzVhkjvzf2l/H5yqCg5ADcVm+vos7y8H4hYAEs2XS8GQg3Jz030Sp3iqyWbuQ1YXP8
         mt/25TAsI7zRzLsWfDb8xb5cSyI2oeNpM6NyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3J0QKkr84VrudaJ3bhOXmAFtwa7Bv5tWoh+lneUqWM=;
        b=EBbMhcP8elnhHwIysO7Cks+kTxoqVjo7GOu8MdOJtYkua9pGvyt7zsH5NLI/0vVaBl
         3/Rq6CNXVfEmHq2AAbSEH5QhAGydmJr4V376I4yjnFQ1u/2iibdYItl5SKYkz7q082+4
         /7GCtWOKJqwf4GahU0mSlhZ8tZJFMDbHlVJEFgeqaNLX7wZG1fywDIhNIhtwn2+daPH4
         jYnAcNq68PqO/GVFR9oNvvkH951uYfEi0KYF5qolj2u8VSWrnVZ/9DRGjN4r7VgesPyV
         bVSn9PvUs659Ugp58Mh4uTFh2MVGd5+Es7fjjGJQa+IOu2DD7KR5mzCeuIyTHdEOzzKd
         BpGw==
X-Gm-Message-State: AOAM5319l5ox5fY+xTs+2FSxVSlQ/UDEiKAVo0pHRMwpGOLq8b+k7n+2
        Ix1kYye/pM6iUXQIjhJkxOhJ/20GDBx61g==
X-Google-Smtp-Source: ABdhPJytsqdO5d2kpVqJ9mIDwNDjF08hSxlxJZgO7iZIJNRCJ4lHvtHfAQZ7XFMm+yJ82HUdKUUH5Q==
X-Received: by 2002:a63:61d3:: with SMTP id v202mr4607974pgb.193.1644346058707;
        Tue, 08 Feb 2022 10:47:38 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gk15sm3594453pjb.3.2022.02.08.10.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:47:38 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER), Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 1/4] platform/chrome: cros_ec_typec: Move mux flag checks
Date:   Tue,  8 Feb 2022 18:47:18 +0000
Message-Id: <20220208184721.1697194-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184721.1697194-1-pmalani@chromium.org>
References: <20220208184721.1697194-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mux and role flag checks inside of cros_typec_configure_mux(),
which is a more logical location for them.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Removed unrelated "ret" variable initialization.

 drivers/platform/chrome/cros_ec_typec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index c6f17e3ef72d..58d08dd02f65 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -521,6 +521,13 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	enum typec_orientation orientation;
 	int ret;
 
+	/* No change needs to be made, let's exit early. */
+	if (port->mux_flags == mux_flags && port->role == pd_ctrl->role)
+		return 0;
+
+	port->mux_flags = mux_flags;
+	port->role = pd_ctrl->role;
+
 	if (mux_flags == USB_PD_MUX_NONE) {
 		ret = cros_typec_usb_disconnect_state(port);
 		goto mux_ack;
@@ -983,13 +990,6 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		return 0;
 	}
 
-	/* No change needs to be made, let's exit early. */
-	if (typec->ports[port_num]->mux_flags == mux_resp.flags &&
-	    typec->ports[port_num]->role == resp.role)
-		return 0;
-
-	typec->ports[port_num]->mux_flags = mux_resp.flags;
-	typec->ports[port_num]->role = resp.role;
 	ret = cros_typec_configure_mux(typec, port_num, mux_resp.flags, &resp);
 	if (ret)
 		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
-- 
2.35.0.263.gb82422642f-goog

