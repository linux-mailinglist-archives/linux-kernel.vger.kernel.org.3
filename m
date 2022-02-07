Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894014ACB6E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbiBGVkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiBGVkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:40:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D4C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:40:53 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y7so6897475plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLTcgJEE5JgO7+vcfSsf1eN9sSCfARQf+RGdDGP6rwo=;
        b=SfFjpz5qq97wVAMpmv9jw6U2UOOU8z/fn7keqOWSGZgJ2JSWWhYtWvaONjLt8rsuRg
         /AXYYnec7GIsl94j84iAZ5Fe6LRIUMEKxsphuve2FJBuPmTySoltfHVbDSS+j+VUkVLR
         Ojg0G3Bbr3QZO5wn58fxf1CPXN0ZgS5Yu4J7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLTcgJEE5JgO7+vcfSsf1eN9sSCfARQf+RGdDGP6rwo=;
        b=7/nNChuUPYq9pFTCZKP+xIo5CiZOWrpkidv+98OwYEHong3Onbykhme0DOl2LqlfRW
         4UMWhOp0Bas0TmTqWn6/255TrbWwADmf0sDGXng+ubihfxZzqm7zOwA8fQiG4LEIDuY2
         hJk6TSP2jD65RrxCudxTd+Yvs3dCqBZS+FA/uTKPjV96/tYdPktnTwL8FM+9B2qET2Np
         fGd05Qku0mGKe/KBJWk/GTvoa+e+wFZNjVuGNzLwRq0PYzEnIn8ByOgMqbk5jvJ3ms75
         R4WBiW3G74VkMHakzojVmBbmdunf3GXmPcXUp3DLN2+e01QTfil7b7DkDQ72gqZxl4Xe
         pfnw==
X-Gm-Message-State: AOAM532Z0YM2Sh8KnrsdzdxPwtT7WZgGPayWQddRM6gHEg4V9GNaJsg1
        1mFbaNGUs5YAL/6zR9i9ptzIEEezxb58Rg==
X-Google-Smtp-Source: ABdhPJz8XeVRKNiZrIITbxZKovi5CB3bJAlwxEaK1wwdUZeiNzvobdhk5htJLyoVfrL6v/Hp/eILsA==
X-Received: by 2002:a17:90a:738d:: with SMTP id j13mr992638pjg.196.1644270052694;
        Mon, 07 Feb 2022 13:40:52 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s9sm9268010pgm.76.2022.02.07.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:40:52 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER), Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/4] platform/chrome: cros_ec_typec: Move mux flag checks
Date:   Mon,  7 Feb 2022 21:40:24 +0000
Message-Id: <20220207214026.1526151-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220207214026.1526151-1-pmalani@chromium.org>
References: <20220207214026.1526151-1-pmalani@chromium.org>
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
 drivers/platform/chrome/cros_ec_typec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index c6f17e3ef72d..445da4f122e7 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -519,7 +519,14 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct ec_params_usb_pd_mux_ack mux_ack;
 	enum typec_orientation orientation;
-	int ret;
+	int ret = 0;
+
+	/* No change needs to be made, let's exit early. */
+	if (port->mux_flags == mux_flags && port->role == pd_ctrl->role)
+		return 0;
+
+	port->mux_flags = mux_flags;
+	port->role = pd_ctrl->role;
 
 	if (mux_flags == USB_PD_MUX_NONE) {
 		ret = cros_typec_usb_disconnect_state(port);
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

