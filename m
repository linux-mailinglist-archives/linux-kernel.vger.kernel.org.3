Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921E353EF77
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiFFUUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiFFUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:20:23 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40DEDA0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:20:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j6so13566991pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zICvYCx4eGxVrXk8LpGPKi4keG/OpLNxmOtIxsqErvI=;
        b=IagWj/SYc4/Y9FtFzDCdKS0529Z4XuGo/muGY5dQdCpyLFUW4vJ6bi0MvsqL2kl5Ag
         x6oaZvLNOMpEwbKp3Hr7hRhbVM2hoMI1eIwsPfTLGax/rgzs75IqMS0pNkoSyhk9NLZz
         pebdYMxt0VX9bf4CyTFGLvAjhw/vC87BDFvfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zICvYCx4eGxVrXk8LpGPKi4keG/OpLNxmOtIxsqErvI=;
        b=vVcqedDD9Xk27/0BEylKFBYVczTfHvi8BzUZENAnMOjkN+7e8NajtWCsMzpKSSsAPW
         I4NFqDnmKBrF0jJK4mUuFnsrU8c8iGvu90dUtoJEOX/gXULlV25WPB4mwAbZxrKJ3uCE
         f4Oh/Eu6Irz0vmkw1FdD2AuxrHyfDSzpx1tMjls0tq9CNnIlr4sbISZcMOl16LnbMu82
         oof1PUYQ7kp2yewCSuQjAfkL+hcVsjb++0W3GPfI2ZnIttY5h6AHvUWozd+JD+LLveTD
         J1b8l6VonDENENQukJhplxoi2x11aSdfDdnsvPzxWuVJOGGRm//giW2zIKY+jGQgVjdI
         sa3g==
X-Gm-Message-State: AOAM5305JY0RgyR3LIWs/yE6v0BKhp/G2SDFn5uxEZwfDgPCQoDkwXvI
        kRc5fm9O/tWib3Ivm+JXewmqLrkMX3hDcdwR
X-Google-Smtp-Source: ABdhPJzhSZmC7qAnR3r/4uCpN7yK371WiuxS6DFokrY0B9A6JlwUmhG3U3RSl+6CPJFBjoOq2WeGEQ==
X-Received: by 2002:a63:2360:0:b0:3fb:ee61:82cf with SMTP id u32-20020a632360000000b003fbee6182cfmr22288194pgm.574.1654546810993;
        Mon, 06 Jun 2022 13:20:10 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b0015ef27092aasm10883034plk.190.2022.06.06.13.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:20:10 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROME HARDWARE PLATFORM
        SUPPORT)
Subject: [PATCH 3/3] platform/chrome: cros_ec_proto: Update size arg types
Date:   Mon,  6 Jun 2022 20:18:05 +0000
Message-Id: <20220606201825.763788-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606201825.763788-1-pmalani@chromium.org>
References: <20220606201825.763788-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_cmd() takes 2 size arguments. Update them to be of the more
appropriate type size_t.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 4 ++--
 include/linux/platform_data/cros_ec_proto.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b6bea183ee28..cefabfe45551 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -958,9 +958,9 @@ int cros_ec_cmd(struct cros_ec_device *ec_dev,
 		unsigned int version,
 		int command,
 		void *outdata,
-		int outsize,
+		size_t outsize,
 		void *indata,
-		int insize)
+		size_t insize)
 {
 	struct cros_ec_command *msg;
 	int ret;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 816da4eef3e5..85e29300f63d 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -232,7 +232,7 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
 int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command, void *outdata,
-		    int outsize, void *indata, int insize);
+		    size_t outsize, void *indata, size_t insize);
 
 /**
  * cros_ec_get_time_ns() - Return time in ns.
-- 
2.36.1.255.ge46751e96f-goog

