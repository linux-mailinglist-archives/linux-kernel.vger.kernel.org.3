Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A96446421A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhK3XNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbhK3XNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:13:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CBDC061574;
        Tue, 30 Nov 2021 15:10:16 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id r26so57829909lfn.8;
        Tue, 30 Nov 2021 15:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AK1GJRUxxwNuwoBrLGoSOJFNKqVHQhLKUbE8ei09Fo=;
        b=PyPvqsasaTmSwk/nM+ISRUx+cnE3Qm9dW4HBLYLEhzTwmFHWE7dWTmBz5APhHJtiJT
         IunDl7PxcYbGlbbH14Tc+8rh9oGcvxZX4u7T4hx+wt1J4omIEK0xTQGVV5I2aadMMLw6
         clz3cdx93w0U+mve/K2JsMvamznGvFk74w1dZQm0gMs7MzRjF5VLahdsISL9W1/d8CiS
         JZ5rKoLDnKiQRFrkGn9K1KHPhF0ncGLaRWl/FaRZMV6rQdosuZz2DCbc78UIWZyRtu2D
         8OxOrJejOcUYvWScqcru/42pHbl4mkCPhz2mAKXshoU2R+vM7SpnqRC3uS2K2Hm28uF6
         VUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9AK1GJRUxxwNuwoBrLGoSOJFNKqVHQhLKUbE8ei09Fo=;
        b=HDWT5IoUiIzM+35KJrL9OrmHziARSBkW53cVI+hJ5EJMYec/NJdxFIOPjLduCkmVvm
         NzlHdqu8GDeRc3ciqa/t1JBuwiyTZ3Hv6kqu+LzQpql+TpMJ+v5yz9cZwzChpV2VNy1n
         ICnpnZ5EEcMlrDboA9W8AqHK210TBhNB7atfuC8hXJuAoRLufUlRucDgtIsxuLLjdqsa
         fhtQbLBXiXEOASs3aHyfRiaHXvruf8XV9llKkjX4rHI64LA3uK9UDzw363WD635m7OCW
         W4iaChdzVHP6odshZxvEqa4irCcUT/KyhEAEeCE04C2Blo6yCokdYMRHrIOoIJHIL7Y5
         vDSA==
X-Gm-Message-State: AOAM530k02wtc9jMGI34xK+RObyhgRaP6z+yFMIywFunth8ruyBLS7md
        6Di43K2pMsPX8UetWaHQMvM=
X-Google-Smtp-Source: ABdhPJwU742CHSh+SdR7WnEFyG0sTjhEbgVGjUL59FrH2/nPrx+4ou2/uazsEtX92zlhly1gL+J9PA==
X-Received: by 2002:a05:6512:33c9:: with SMTP id d9mr2045014lfg.615.1638313815095;
        Tue, 30 Nov 2021 15:10:15 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id k14sm2099846lfu.210.2021.11.30.15.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:10:14 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Graichen <thomas.graichen@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Restore Tegra DRM on Nyan Big Chromebook
Date:   Wed,  1 Dec 2021 02:09:53 +0300
Message-Id: <20211130230957.30213-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset restores regressed SOR driver probing on Nyan Chromebook.

Changelog:

v2: - Changed host1x and Tegra DRM drivers such that DRM device is
      registered early now. This removes the need to change DRM core.

    - Introduced dev_err_probe() patch again. Previously Thierry rejected
      it, saying that he likes his variant more, but I kept that patch in
      grate kernel and it happened to be very handy to have because I
      instantly identified the problem in the DP AUX driver with it,
      which would've been much more difficult to do otherwise.
      Please apply it this time.

Dmitry Osipenko (4):
  gpu/host1x: Add init/deinit callbacks to host1x driver framework
  drm/tegra: Create DRM device early
  drm/tegra: dpaux: Restore DP AUX DDC registration order
  drm/tegra: Use dev_err_probe()

 drivers/gpu/drm/tegra/dc.c    | 13 +++-------
 drivers/gpu/drm/tegra/dpaux.c | 26 +++++++++++++-------
 drivers/gpu/drm/tegra/drm.c   | 46 +++++++++++++++++++++++++----------
 drivers/gpu/drm/tegra/drm.h   |  2 ++
 drivers/gpu/drm/tegra/hdmi.c  | 34 +++++++-------------------
 drivers/gpu/host1x/bus.c      | 15 ++++++++++++
 include/linux/host1x.h        |  4 +++
 7 files changed, 83 insertions(+), 57 deletions(-)

-- 
2.33.1

