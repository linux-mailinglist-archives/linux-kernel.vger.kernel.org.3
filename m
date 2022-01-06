Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBBB486CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245143AbiAFVsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245037AbiAFVrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:47:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE6C028C17
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:46:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t187so3559690pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N66rEkaY3Hcvo9L0yTqqS+dEsFgKt6MiGsAE0j7XsvA=;
        b=duTCpzs7Q9xBO5/jhvEz8d7dBWFz10UyRPM1+gs1MoWcr9Rjih5IN5nGhXwvevK79F
         LLH1VMRZRSRrbvBf8CSScTX1zcxPS5br+YawaCpH+p6G0YnWVaIEotrftZD5MdQGAOa4
         FzTGm8fqHdWdHKUkrTNtlgHPLN8gG7IbLg8cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N66rEkaY3Hcvo9L0yTqqS+dEsFgKt6MiGsAE0j7XsvA=;
        b=OE734rzUyfTt6MnVSe4Dy2Q6A12iOX9pxH8Lgm/cXNTv+pbGgX8GgNc/mHkkE6g/3F
         SmCKWX5IlV+DlTzkHFWKS69Mmbk8uIYdovZSDeC0KY/D9MfscETCgmD04WeRo8mGO9ur
         7t2NQDPS+jBfKbFLbhcP11R11wiKOIXi0CTLR4dk6YaUiBXrbBVaNVPBHCMQebDQ3YVH
         ouiHGFgL7QgYVrSDQjXXkuUDZVcrAKl6F0e5+6OJQ+BI8+PkgiIHfwFBW3w8MYwMwUYA
         eKj8IvaVWGpnvLxDQWoBBKjYViUW4spbcYl9o8mq5w8qETqd9w114d00uMvQU1gooRDp
         zUTg==
X-Gm-Message-State: AOAM53028GIGF00p7RjC38P63xPBdOVQzzIWlsP8XhdQ/esefj3pco9L
        inSDPEC9Kisaw5/vT5iooOatyQ==
X-Google-Smtp-Source: ABdhPJwMc7pXtV30yrUswG55aCMQDtvMJXNqLIxDsQ5YfePndNaTQa8QsvS1BLqjnpOZEiOenE8G+w==
X-Received: by 2002:a05:6a00:1150:b0:4a2:7328:cce6 with SMTP id b16-20020a056a00115000b004a27328cce6mr62400254pfm.67.1641505598770;
        Thu, 06 Jan 2022 13:46:38 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:38 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 30/32] ASoC: codecs: wcd938x: Migrate to aggregate driver
Date:   Thu,  6 Jan 2022 13:45:53 -0800
Message-Id: <20220106214556.2461363-31-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220106214556.2461363-1-swboyd@chromium.org>
References: <20220106214556.2461363-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Acked-by: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/codecs/wcd938x.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 52de7d14b139..f44f5d41bfdb 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4316,8 +4316,9 @@ static struct snd_soc_dai_driver wcd938x_dais[] = {
 	},
 };
 
-static int wcd938x_bind(struct device *dev)
+static int wcd938x_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct wcd938x_priv *wcd938x = dev_get_drvdata(dev);
 	int ret;
 
@@ -4400,8 +4401,9 @@ static int wcd938x_bind(struct device *dev)
 
 }
 
-static void wcd938x_unbind(struct device *dev)
+static void wcd938x_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct wcd938x_priv *wcd938x = dev_get_drvdata(dev);
 
 	device_link_remove(dev, wcd938x->txdev);
@@ -4411,9 +4413,13 @@ static void wcd938x_unbind(struct device *dev)
 	component_unbind_all(dev, wcd938x);
 }
 
-static const struct component_master_ops wcd938x_comp_ops = {
-	.bind   = wcd938x_bind,
-	.unbind = wcd938x_unbind,
+static struct aggregate_driver wcd938x_aggregate_driver = {
+	.probe	= wcd938x_bind,
+	.remove	= wcd938x_unbind,
+	.driver	= {
+		.name = "wcd938x_snd",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int wcd938x_compare_of(struct device *dev, void *data)
@@ -4482,7 +4488,7 @@ static int wcd938x_probe(struct platform_device *pdev)
 
 	wcd938x_reset(wcd938x);
 
-	ret = component_master_add_with_match(dev, &wcd938x_comp_ops, match);
+	ret = component_aggregate_register(dev, &wcd938x_aggregate_driver, match);
 	if (ret)
 		return ret;
 
@@ -4498,7 +4504,7 @@ static int wcd938x_probe(struct platform_device *pdev)
 
 static int wcd938x_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &wcd938x_comp_ops);
+	component_aggregate_unregister(&pdev->dev, &wcd938x_aggregate_driver);
 
 	return 0;
 }
-- 
https://chromeos.dev

