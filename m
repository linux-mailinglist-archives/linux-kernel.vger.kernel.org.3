Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6B56AE44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiGGWWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiGGWWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:22:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A02761D4C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:22:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j3so9334429pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1d8oUSgHflYddbSglWNBA8zQUNolQOQTA7TIi861ndw=;
        b=n/XYJko9I2Vab10eSfGNHdTlWxcrLl2NLM/pY9JnXgKT8cJccpbSlK4P9XXGRIxhib
         UWAU5BhKT099hQo8qZgPL2hvfirXJTyydcYp48nwQMSRMTSEyNUwA4gs7+Bu5LMCY6bo
         S4x94Lj5FHH7rx9tDBxHDjeYTVeaHckI68jKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1d8oUSgHflYddbSglWNBA8zQUNolQOQTA7TIi861ndw=;
        b=R7WvYsDTci44Bj378axs+C+citjpCqkyya17NNKHSKExCcnslE02cC5q9twcMPL64z
         yYZusdWVYwPy5wnOWjYNKF4inmZEyJCnWfpnQmoj31jJlopO7hendTzJbs55D8/AtQWN
         4JQADbhwZqc9yk2SStEJRhfq/Q6bwQuCtT2qAo22uZDTG1a72FfmSaHq2TCz+lmVlaxz
         Wpch9Pfq67ytuSwTejJrlpJcc/WL4zmdikXOcft81/snN0WEUVZVa18nBDBfGOn5TND4
         tqkIzVT1OZFX1N2yEiSRRKYuEb1bv7t/nVfAaeQ8Ffi9+PWD5lDouVVRcO7CUwuWigxN
         T19Q==
X-Gm-Message-State: AJIora8a9ZnMJVZ/BJgn6ykrgbfAM8pMDS7rDcGrYfWsGWkYVEZV9UD6
        E+R8f8kkIHy83EX2C969Qqt4XBi8eO0JNQ==
X-Google-Smtp-Source: AGRyM1v3yQqQ+TNU43wur8Fhdh2vNt66qOELbhK2Z68f5Lwz32YRSI71HzG5/nHKgT3OD9oQ4ktf3g==
X-Received: by 2002:a63:ea05:0:b0:411:f94f:b80f with SMTP id c5-20020a63ea05000000b00411f94fb80fmr275064pgi.189.1657232525017;
        Thu, 07 Jul 2022 15:22:05 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 66-20020a620445000000b005289bfcee91sm5545657pfe.59.2022.07.07.15.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:22:04 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v3 2/9] usb: typec: Add retimer handle to port
Date:   Thu,  7 Jul 2022 22:20:09 +0000
Message-Id: <20220707222045.1415417-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220707222045.1415417-1-pmalani@chromium.org>
References: <20220707222045.1415417-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to mux and orientation switch, add a handle for registered
retimer to the port, so that it has handles to the various switches
connected to it.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v2:
- No changes.

Changes since v1:
- Relinquish retimer reference during typec_release.

 drivers/usb/typec/class.c | 9 +++++++++
 drivers/usb/typec/class.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9062836bb638..f08e32d552b4 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
 
 #include "bus.h"
 #include "class.h"
@@ -1736,6 +1737,7 @@ static void typec_release(struct device *dev)
 	ida_destroy(&port->mode_ids);
 	typec_switch_put(port->sw);
 	typec_mux_put(port->mux);
+	typec_retimer_put(port->retimer);
 	kfree(port->cap);
 	kfree(port);
 }
@@ -2249,6 +2251,13 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	port->retimer = typec_retimer_get(&port->dev);
+	if (IS_ERR(port->retimer)) {
+		ret = PTR_ERR(port->retimer);
+		put_device(&port->dev);
+		return ERR_PTR(ret);
+	}
+
 	ret = device_add(&port->dev);
 	if (ret) {
 		dev_err(parent, "failed to register port (%d)\n", ret);
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 43fcf9e37a8c..673b2952b074 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -55,6 +55,7 @@ struct typec_port {
 	enum typec_orientation		orientation;
 	struct typec_switch		*sw;
 	struct typec_mux		*mux;
+	struct typec_retimer		*retimer;
 
 	const struct typec_capability	*cap;
 	const struct typec_operations   *ops;
-- 
2.37.0.rc0.161.g10f37bed90-goog

