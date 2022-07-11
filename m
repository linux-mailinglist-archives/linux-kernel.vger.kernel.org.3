Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B1F56D6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiGKH3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGKH3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:29:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9915A08
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:29:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so4036446pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARuOjXkb9WXnMbJXcHgDAqXcx2iKK+w+U5wn5FQDR6Y=;
        b=LsrfyOyORhRqy17RRdlUiq4/FL4fmPohUX0HMOTvZcv3yzrGxL/RLEQkQLySym6zT8
         geDq4SkIulIvPi8e0WHHf2dW07ZZMJt8dp24O+BtXaI0YO58AfnC7Zqwzsci2gIJbXZt
         a+aFY/sJvcltJ2Kr5EIRakDkQo/wWXvOeY0H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARuOjXkb9WXnMbJXcHgDAqXcx2iKK+w+U5wn5FQDR6Y=;
        b=t2Mo3d7nTYPxrr+b3iS16r86AZ4LJQfXTCWZ0Jm4ioU61towl1skceArMhu7kyIXAr
         cdRxX/q9uIpgV3wsk30rpJq03C2lIN6bgkmB8OMPMzArkXz8IX5UrN82vXRkCmaLLN8x
         SCrk2rvcma859pXSS7dusliT6UoOIkWpbowj5cruRB4B02t5u6zMTNIB3R48gRxdBYWU
         1z5oKnhdataB5o3Op6Z3udHHV75QEAx0SgctGvwLm+775depRzUUWxj5Ey2OmbJRY3Nl
         xU8zZvdu0ajwYzRgBOHWabZsNTN065UdR5d1bYNvqqf4tcKhq4w1INuqNZEGe6EOthCN
         w8Eg==
X-Gm-Message-State: AJIora9+HT4pZYYl6lPWuEgEDg7/H1oUxckg+fJIItW+s82/Tf2IBqp2
        /Oo0GHpNHOckY3F2OSfV9RgiqtoPJca4Qg==
X-Google-Smtp-Source: AGRyM1uXjFYsxXcTBMnm60zGyOA7F3T8MVkEl93WM7/+YkjruocghxWq4EfsD+tnXUN+29P8LY1rYw==
X-Received: by 2002:a05:6a02:11b:b0:40d:dfdc:95d7 with SMTP id bg27-20020a056a02011b00b0040ddfdc95d7mr14907022pgb.536.1657524568710;
        Mon, 11 Jul 2022 00:29:28 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z8-20020aa79e48000000b0051bc5f4df1csm4012839pfq.154.2022.07.11.00.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:29:28 -0700 (PDT)
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
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v4 8/9] platform/chrome: cros_ec_typec: Cleanup switch handle return paths
Date:   Mon, 11 Jul 2022 07:23:02 +0000
Message-Id: <20220711072333.2064341-9-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
In-Reply-To: <20220711072333.2064341-1-pmalani@chromium.org>
References: <20220711072333.2064341-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the return paths for the cros_typec_get_switch_handles()
aren't necessary. Clean up the return paths to only undo the handle
get's which succeeded.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v3:
- No changes.

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 7cb2e35c4ded..39e6fd4491a9 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -157,12 +157,10 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 	return 0;
 
 role_sw_err:
-	usb_role_switch_put(port->role_sw);
-ori_sw_err:
 	typec_switch_put(port->ori_sw);
-mux_err:
+ori_sw_err:
 	typec_mux_put(port->mux);
-
+mux_err:
 	return -ENODEV;
 }
 
-- 
2.37.0.144.g8ac04bfd2-goog

