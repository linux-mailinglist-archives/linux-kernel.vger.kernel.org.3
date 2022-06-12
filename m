Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE0547A90
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 16:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiFLOtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 10:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiFLOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 10:49:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6B3C08
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:49:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n28so4230535edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rSYb7WFjE8zoNskNTn4KK0LTbD3WJCu9gXFXTJhr6NA=;
        b=DpKtqRz965ab2i6y6lqT1h829jS37b9OM/X/HXYgxukSHjmHIso7zrHx2DNMvrGrbM
         VXYrVXtBo7mNpOLdw3oONOrdh3if/xAl00j+2USQGua7DTIBh0weFfBbNQ6Xkqi7I30d
         Sfc/jNM4SrtaeuXWdPhYm/ZoscHgexojfwbCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rSYb7WFjE8zoNskNTn4KK0LTbD3WJCu9gXFXTJhr6NA=;
        b=Fk0mq1MII6GBTMnetaoaM2Idz2/d0GRXv1abIwEyxwuCZ8g0ZxM6M2SOPdYFlIsaXk
         +cD0bymTgIlwT7DszJHUckFg+pbeYnGRMOMnbHWOrOxPjZ94UnADehX6axm7yVFFQRkF
         nBBLYT/lXIY1DTRRTovYxbUT3J5aCYpCMKWLSiv8JkqdAu9WmEbwtZd8AgIPlNlm2AMu
         DU+vpreY1P+ZTdImvf94Vx7v5jynXow8kCVoPYMu0Y+vxgjyWNqCe25x/jPKUOGjbmCp
         CwjEdPH/SiOlH3N0KckRR3m78gHSC8BLh/SBg2u5MCWi53k6BvzlgchQLTZBL6QAY+hC
         1n6g==
X-Gm-Message-State: AOAM533XRzn49/zGA4SoM1QjZnHt71AV3M+kC1nZbxcEGTOwrV5YbH33
        z6gf4TFGx2UzFJ9zTyGqbBgzmw==
X-Google-Smtp-Source: ABdhPJz6VW1bBC6PVZCZNV8EQxR11CGCL5uV9+5wD8r+5bBipMpMJseYJtMpdQiGB8ZncgAbn2qkYQ==
X-Received: by 2002:a05:6402:50d2:b0:431:53c8:2356 with SMTP id h18-20020a05640250d200b0043153c82356mr41780544edb.300.1655045354020;
        Sun, 12 Jun 2022 07:49:14 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id cm20-20020a0564020c9400b004316f94ec4esm3257076edb.66.2022.06.12.07.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 07:49:13 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Archit Taneja <architt@codeaurora.org>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/2] drm: bridge: adv7511: two fixes for CEC
Date:   Sun, 12 Jun 2022 16:48:52 +0200
Message-Id: <20220612144854.2223873-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Previously sent back in March, see here:

https://lore.kernel.org/dri-devel/20220319145939.978087-1-alvin@pqrs.dk/

No changes besides rebasing on today's drm-misc-fixes.

Alvin Šipraga (2):
  drm: bridge: adv7511: fix CEC power down control register offset
  drm: bridge: adv7511: unregister cec i2c device after cec adapter

 drivers/gpu/drm/bridge/adv7511/adv7511.h     | 5 +----
 drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 4 ++--
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 5 ++---
 3 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.36.1

