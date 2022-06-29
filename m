Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B40560558
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiF2QGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiF2QGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:06:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BED5E6B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:06:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 65so15506812pfw.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBAwmf3hnEIm7QQKkyiSy9nlUtJMyt9Dhl/BWJJycfc=;
        b=buTrPCP9r/wJ5oPOB0f0DJpQ8V6tW7tfgOZx2uSKkWC/2vMmTvjE64AO/lHrRX+HQZ
         kv/SgncYR3nlgqpLobh8CHATSg3+hman5T/V8BqdImV4gzzCxVSyKUVDF4ugwYM5V0rB
         vsaHoCA+cobRTBtdrQ5roQiuTM4algBDblNEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBAwmf3hnEIm7QQKkyiSy9nlUtJMyt9Dhl/BWJJycfc=;
        b=05KXpDEevd7b+eyAxPzY+yJ0uKLEAzM6RbvptUVTApmiw9yAbCG1P/qtm3UkI9KOCP
         buBGWrsqWSgWHA0tb+MWZirDzloNpey6ob5DwfU7S4+rUFR/zdkynHVO4WWQES96f0CK
         WaCadvGVpHK53/e0m4I8tGT9abF1cPqAQNNMtdJ7e/wCRvy2BwbK/41EmqQZyxNrvw02
         ZljW6DskdMA7O/ObeaiXSgCcPRHVdNtaJEnGebzprEUDkPuZSvCXw5RaHVvNmJH1tCXh
         ILLRQfwo2N+ERze3QDKvNtISdmSBIy+WhBmAkcqubRSifGM0y+3e5K7TXefhd4FCwlV7
         0DDQ==
X-Gm-Message-State: AJIora9Hz0NjXA4/4nolvtWil7aOmozG8V0H0sfY2Y8e80QXU8dgOAB9
        3iMNkxVVd+TmV/dbB8W5EvPZSw==
X-Google-Smtp-Source: AGRyM1vhnDIT9TahKVUJ4QdTOs1R1i/R1LLtMlUuU993m40WNKgeQ8IODX+weGpoOHAl3yYNfw7CIg==
X-Received: by 2002:a05:6a00:23d2:b0:525:951a:edf1 with SMTP id g18-20020a056a0023d200b00525951aedf1mr10948462pfc.62.1656518759660;
        Wed, 29 Jun 2022 09:05:59 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9841:721:7d8b:4502])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902e3d300b00163f8ddf160sm11495350ple.161.2022.06.29.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:05:59 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>, Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] anx7625: Cleanup, fixes, and implement wait_hpd_asserted
Date:   Thu, 30 Jun 2022 00:05:46 +0800
Message-Id: <20220629160550.433980-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains:
Cleanup:
- Convert to use devm_i2c_new_dummy_device()
- Use pm_runtime_force_suspend(resume)
Fixes:
- Fix NULL pointer crash when using edp-panel
and Impelment wait_hpd_asserted() callback.

The patches are not related to each other, but they are all
anx7625 patches so they are all stacked in this series.

Hsin-Yi Wang (4):
  drm/bridge: anx7625: Convert to devm_i2c_new_dummy_device()
  drm/bridge: anx7625: Use pm_runtime_force_suspend(resume)
  drm/bridge: anx7625: Fix NULL pointer crash when using edp-panel
  drm/bridge: anx7625: Add wait_hpd_asserted() callback

 drivers/gpu/drm/bridge/analogix/anx7625.c | 179 ++++++++--------------
 1 file changed, 65 insertions(+), 114 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

