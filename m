Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24AD51591E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380419AbiD2XrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbiD2XrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:47:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B30DB0D9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:43:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x52so6556771pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiS8qEoWRaz1WJHgDpdYQzj9UXTuORSLeUZZBuLbpAQ=;
        b=QfV9qZQSy7zKpLgp3XKRuVVGQgXKgCEdZT8M6YLWLWuzskyledgrDoNbnEeL6+vdAy
         J1x4CD4N/XKato7QqwqelKbTKiWvYbwUH3sZuY4jCfH6bKi9uUj8MsW6jOFLQXVjURAX
         OatmJuCqt75DW8gtrxh6zZLgi05jRW6xz/fmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiS8qEoWRaz1WJHgDpdYQzj9UXTuORSLeUZZBuLbpAQ=;
        b=lLdm5FetkXNRpJR6HiwX3C5T8PFgz2gxWUXXIkYt6yjXRFVXQ3f1DEPEZAGLpiWjMY
         RIKSE24XNAwsE3T6pa9K5PDUmD8IIgzPUv/5j/+D824SxMWm6apiadUqjpjmpkqXHqnn
         5EpNgsUmltZ/3Rn6famE+GLgS8n9Up04vqWV3hVfODWIhz8C/9/2X4Wwj9taS7gSyNHe
         gFRX7IT77WHhWT7UNMpfF3W7m8ZUGZxf7fsV93Fw4IISZMS5A3ecpgTwHhUnDX6ee/fR
         locdAticewiJ9bDWMykiwmIexlRrrBFaOchxrAGXmVmdqrFZhVesrwQZDit5JuN7hVey
         icWw==
X-Gm-Message-State: AOAM530+cZLfavUMbTmNiuAU9dw8SfGiuxk3+wMp7ftWWNcwCmq2wB/z
        i5BLka/BxxlyrTCh4QcuJOo8cA==
X-Google-Smtp-Source: ABdhPJyGwn4LqJY11HpxsF3RCIIDl8jF0wjSNEEMrwJ5U7v246J/p3J5Kt/Ft8+Hq1Ze7VFy0q1q0g==
X-Received: by 2002:a05:6a00:190f:b0:50d:8b82:cb90 with SMTP id y15-20020a056a00190f00b0050d8b82cb90mr1532752pfi.65.1651275835135;
        Fri, 29 Apr 2022 16:43:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:408:3697:902b:59f1])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709028bc100b0015e8d4eb26dsm152563plo.183.2022.04.29.16.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 16:43:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     swboyd@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        freedreno@lists.freedesktop.org,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] device property: Fix recent breakage of fwnode_get_next_parent_dev()
Date:   Fri, 29 Apr 2022 16:43:47 -0700
Message-Id: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a subtle typo, instead of commit 87ffea09470d ("device
property: Introduce fwnode_for_each_parent_node()") being a no-op
change, it ended up causing the display on my sc7180-trogdor-lazor
device from coming up unless I added "fw_devlink=off" to my kernel
command line. Fix the typo.

Fixes: 87ffea09470d ("device property: Introduce fwnode_for_each_parent_node()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 36401cfe432c..52e85dcb20b5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -600,7 +600,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
 	struct device *dev;
 
 	fwnode_for_each_parent_node(fwnode, parent) {
-		dev = get_dev_from_fwnode(fwnode);
+		dev = get_dev_from_fwnode(parent);
 		if (dev) {
 			fwnode_handle_put(parent);
 			return dev;
-- 
2.36.0.464.gb9c8b46e94-goog

