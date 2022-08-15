Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD28592D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbiHOJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiHOJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:39:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0531F2C3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:39:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s206so6103726pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7MIhZhyQf1iiQaCJxYZieUdU7Z/6XeeU6tWciUhQM70=;
        b=fzPUmgMpRnKlkWNT2SrLzEDGj/tEkFn6IsZGf4kObHoFSetYoZZ+gve2wb+vqt6Yne
         OHdEFNN01Xvdem3BkWhN+IbLrgtd42m93B15vSfNaEHSOb5+RNhSk5fLRm1Oj2ymoVT4
         kPNrFYfG6JFMOe07OcKituyuGM7hP5eMWDij4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7MIhZhyQf1iiQaCJxYZieUdU7Z/6XeeU6tWciUhQM70=;
        b=V1IEIQGYht9yqaqCtdXKqsVUNi59JPl4jyOyaoOn0G6BkgyocYlgtvptkqO1GecCGN
         3m5AAKv7IIal5idQpWhJjXaL9ZwJPY8T6mXh+PuYL91AGzrDIvoRy7B9noF7sVH2u2et
         Mz8JE/nEqpIPdODodkOmzC5OMNCL0DzJgb8TTZcgZcH1uFmhd7/CQUc3LGib8yUXE61y
         OwFVMbzPE0HP77brxI7KCPZi7XcvpczyZNCE6fjUEEn6S+nFDZR94pPfGumcpmwZ8CUq
         ffYZH7xTqaWYI3WtGYNFTTFcJOwJ98Yu3mpChe8KmOr7MXFiWQ+FF2axFKLRtZmGwj/9
         wYmA==
X-Gm-Message-State: ACgBeo0H/XK8Lva9Oa/EKVKiAqeLPsnyAwHGWW6PID3UhlhZ/DaTDfBf
        RzPOVssf/Hm8N/ow9aGikUDBqkRUDPj+hyf5
X-Google-Smtp-Source: AA6agR6NRtKS2CTIYBNCSm6wJ4Gn5jaSJ/CXvUpJQtzt+CO8e0li+ALCHXyFxo3riiphyjuuuXWzQg==
X-Received: by 2002:a65:6c10:0:b0:41b:ab8f:ff71 with SMTP id y16-20020a656c10000000b0041bab8fff71mr12969588pgu.308.1660556383875;
        Mon, 15 Aug 2022 02:39:43 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6fc6:4170:be4b:587])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001714fa07b74sm6680020plh.108.2022.08.15.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:39:43 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        rock.chiu@paradetech.corp-partner.google.com
Subject: [PATCH] drm/bridge: ps8640: Add double reset T4 and T5 to power-on sequence
Date:   Mon, 15 Aug 2022 17:39:07 +0800
Message-Id: <20220815093905.134164-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
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

The double reset power-on sequence is a workaround for the hardware
flaw in some chip that SPI Clock output glitch and cause internal MPU
unable to read firmware correctly. The sequence is suggested in ps8640
application note.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 49107a6cdac18..d7483c13c569b 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -375,6 +375,11 @@ static int __maybe_unused ps8640_resume(struct device *dev)
 	gpiod_set_value(ps_bridge->gpio_reset, 1);
 	usleep_range(2000, 2500);
 	gpiod_set_value(ps_bridge->gpio_reset, 0);
+	/* Double reset for T4 and T5 */
+	msleep(50);
+	gpiod_set_value(ps_bridge->gpio_reset, 1);
+	msleep(50);
+	gpiod_set_value(ps_bridge->gpio_reset, 0);
 
 	/*
 	 * Mystery 200 ms delay for the "MCU to be ready". It's unclear if
-- 
2.37.1.595.g718a3a8f04-goog

