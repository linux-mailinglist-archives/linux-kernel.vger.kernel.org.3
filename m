Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32575B169A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiIHINt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiIHINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:13:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8CDABA2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:13:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y127so17165207pfy.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=VPow1DKAjakhyMLinUZ5Rwpgp/WG38k735WIpnbfb7k=;
        b=fDFpS6nHsOY3o4hTijEvnc/f/cbse/OgyA5dEFkmyLEvp/gzW/FXEiS2RGlEIrwdIw
         HmCqRbJ7AFvBqOb1QYCQ9Kcpp/ytZ18y55zxtKQT/urkAnyqDyS4x6Tw8n+i3oX6XTOP
         MmTj4pLb6jxhdRv4B02u1NB7HILtSBDQk/tEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VPow1DKAjakhyMLinUZ5Rwpgp/WG38k735WIpnbfb7k=;
        b=T7fYvBKt586RYWobB9C0n9n4eCEcDjq61cPNaqC1gjfuocPOg940uE55vbihX0ch9Y
         y4g2Hk+15c2w6ByJpdE/DlldLV/qJesu3SB/H5msA/Z47MAIO/wrgKcs0/43LNVV+H4i
         1mRDj/f40Smh08lOYTLy8DDoRj8+ugK2yu5OzNrDlorfAHffnPKSS/pJ3aKgLjkwp6y/
         CJZZfPkxiiBep5QlBhCziyRcK9CnyukgrIdnDVyD+clzUhxc0/sdc2gURBRPO99INEJQ
         8yGre0PciAQLinyALTBimE5+y1WVkHTFReM1SOUYe8Auf6bom0TKNVip1ktJvYUeNQ8m
         iZcw==
X-Gm-Message-State: ACgBeo01jmCni8rc3orzBMCnHDjyMfTEzBivc9KXU/UKedKELhlqT68b
        jopwJbgCqpPUzJ4iH+RjDN7F0A==
X-Google-Smtp-Source: AA6agR6s1PjBNJxaXTuwtlqbVBgqnTDUccsB/SS5RWjYR0hxnrEHMT+quiiR/ejjlM3SUu6v3SD/iA==
X-Received: by 2002:a05:6a00:23c5:b0:535:5c24:68df with SMTP id g5-20020a056a0023c500b005355c2468dfmr7954279pfc.62.1662624786883;
        Thu, 08 Sep 2022 01:13:06 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:5237:c185:9b01:8955])
        by smtp.gmail.com with ESMTPSA id z22-20020aa79496000000b0052d4cb47339sm14159702pfk.151.2022.09.08.01.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:13:06 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 0/2] drm/bridge: it6505: Power management fixes for it6505 bridge
Date:   Thu,  8 Sep 2022 16:12:56 +0800
Message-Id: <20220908081259.503236-1-treapking@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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

This series contains 2 fixes related to it6505 power management.


Pin-yen Lin (2):
  drm/bridge: it6505: Adapt runtime power management framework
  drm/bridge: it6505: Add pre_enable/post_disable callback

 drivers/gpu/drm/bridge/ite-it6505.c | 49 +++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 9 deletions(-)

-- 
2.37.2.789.g6183377224-goog

