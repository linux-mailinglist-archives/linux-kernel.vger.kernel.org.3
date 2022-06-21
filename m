Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BE552BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346074AbiFUHVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiFUHVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:21:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0112250D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g26so4150413ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I49iaT9479MLDi3TYueSZinlKruIKCVXqSN6hfWZ6x4=;
        b=gpAE1+YcSfcBdfh7BwfrIoGbRZBggiIKzxdzevy+uY0mwZ38SqW5C24UGUW26VY4UQ
         WP1S+RpCG/FKyBZUka5u2+CPPXZJ3KWRf8OHVm/eGamVrfkx0pZ8k/r1dCJiI/Y9tWmz
         1oQm+ijCrgg6t5IQfVcRYcG0EZ0onOIYztGApiM1tQeP5guXwyXfw38Q2H/4ynJnW2mS
         3D4OkdRnQ+BJI/MKwgR+djuQCWPssy+Hrsm09S+yer0zBBwLofZ5OECr99J3AzlS+crQ
         9DHd3RGJuWdVl8yX4ILXR2mG3nU1o6BthJk/4T+xZCQa/Ujz8QiKP9A6AoGoZqirNj/t
         B4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I49iaT9479MLDi3TYueSZinlKruIKCVXqSN6hfWZ6x4=;
        b=JW3awyhw+vuuoTzFcIO8it0osVZG9IXPi4ujuPwfRULaT6e8d492RYTqSyC04t3AiN
         l2Kjr37gnbn7zsW/FHVYJY/L+AzidRnEuu+mcryNd44+ZG3wH4hClWB4PFB8Mqln0wXU
         zXvlBkDpJQ098cJzY0jCcUnH7H16SeL5CklDToegzEWVo80fJ8Iui5xVnnHNHqRYzfk+
         zt96Rilc9IrRBSV/jtgXZXipQ3nM+RrS2D6nm3n3janY7swHdzyEc6OXWduUpXursRYd
         0vrCjYUQgEi2k7UyYZDgvG0LhExehv1srhurbZR/RBOOvfxWFqk8i07Um58Pn8NWUFqG
         p1VQ==
X-Gm-Message-State: AJIora+Jt+G5WbGhuwwqsG82Ymvtj8XVaBzrCeA/x5WTxiWAOV8T8voX
        EuCQ0HcFIagEpjG8v/T7xLWup2jfYa4=
X-Google-Smtp-Source: AGRyM1vduCB6Dl0uXtQ/uJ/zcFkNMY0AX9tE24LM9PyHr98TUnsUGHKRZg4/lze+IGydS4QD7MJIWw==
X-Received: by 2002:a17:906:6a28:b0:711:d032:caa4 with SMTP id qw40-20020a1709066a2800b00711d032caa4mr23990285ejc.80.1655796072583;
        Tue, 21 Jun 2022 00:21:12 -0700 (PDT)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b00722e771007fsm50711ejo.37.2022.06.21.00.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 00:21:11 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP)
Subject: [PATCH v2 0/4] Add support for GPU load values
Date:   Tue, 21 Jun 2022 09:20:46 +0200
Message-Id: <20220621072050.76229-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for loadavg values for GPU
sub-components. I am adding a SMA algorithm as I was not
really sure if EWMA would be a good fit for this use case.

Changes v2:
 - Addressed feedback from Lucas

Christian Gmeiner (4):
  drm/etnaviv: add simple moving average (SMA)
  drm/etnaviv: add loadavg accounting
  drm/etnaviv: show loadavg in debugfs
  drm/etnaviv: export loadavg via perfmon

 drivers/gpu/drm/etnaviv/etnaviv_drv.c     | 14 ++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c     | 76 +++++++++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h     | 37 +++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 79 +++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_sma.h     | 53 +++++++++++++++
 5 files changed, 257 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_sma.h

-- 
2.36.1

