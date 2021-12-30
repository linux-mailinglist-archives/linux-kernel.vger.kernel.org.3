Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D960B4820EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 00:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbhL3X4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 18:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbhL3X4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 18:56:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67E5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 15:56:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso16782123wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 15:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=06S3zd2orIESj72FE3tHED43xQdHxTUMkfYYwe00wX0=;
        b=UN21p9i/HQBP5bIxdvrBzde1OUPTWPyofyKLJHtskKd+VUJIo4+fasBiQ1BZ38DGu2
         BS/OMU2bTo3CS0WrOgL+TfNYbfORze+G2kHzWVXQo1brPYoYmdoqoMr9juida9Pdr6lw
         2pYpTeV94yVc+jaaKNAgeSTYahZDSDK8IJfuSh8J2aiYFW3RwNabA0UgsSsA8BhLuoFn
         1Ofre4miz4RWoHxDkv9Wd3FKO7YKr18SHgt15sL4Ln4PJGuYO2UXTwzmey2tnGkeOJ2E
         dc7bWiOthsHX1JbCeT2A6N7eDF3aWYYMU9I1WXUleIAqcDKph89Ib54Rno3dzG59AX3d
         QfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=06S3zd2orIESj72FE3tHED43xQdHxTUMkfYYwe00wX0=;
        b=TdYRBrrodo3pI6jzUkyE4boWL67dGZEhVWYPPHBfD+YP0NDAajv6ZuTSqLN5UcgvqI
         26ZbVJ87GOtNh8lIJplKkO0/heEo7/G6/xw+JPHqwJ2KEg7L/fOtLVxEj5Cb/VIB8sMH
         enC4PHhouyNiCAfeJs3DUd+CUO4M0KYYzhCGUcteudbE9wkZZ0ExlY4zPlHvMG+MwO9u
         YQfBjYZ1z8o407LrMGWf6TtHNFS8JXm7ZJgfvegA6CnbHRF6nXiAAHbKcA9CqBSxHnyR
         tdyNotXRggraqAArmbYI5AK5gcnxTWfKflFUVOPKGlkxJy9N2bZ6GBz647Pib9KEVMOF
         1R3g==
X-Gm-Message-State: AOAM530QzvXNKNgiVTz2vcvEBt/fhvamCxDntp5vNuV2k8xluXU4u9qs
        l0JZN7N6BL3yD34OOcvpUJo=
X-Google-Smtp-Source: ABdhPJzgh/ofqaEUf89LPraq5gBtOMLdMCVoLABcXbmXGl/gXmAtu34+N2JtT7fliiicXAQ/+OwVlw==
X-Received: by 2002:a05:600c:1c18:: with SMTP id j24mr28248546wms.189.1640908574243;
        Thu, 30 Dec 2021 15:56:14 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c015-2400-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c015:2400:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id f16sm35137581wmg.27.2021.12.30.15.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:56:13 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] drm/meson: Error handling fix when AFBCD is used
Date:   Fri, 31 Dec 2021 00:55:13 +0100
Message-Id: <20211230235515.1627522-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

this series consists of a small cleanup patch and a fix for the error
handling in meson_drv_bind_master() when AFBCD is used.
The patches are based on drm-misc to not conflict with your previous
driver rework. Since the problem has not been observed in the wild I
decided not to Cc linux-stable.


Best regards,
Martin


Martin Blumenstingl (2):
  drm/meson: osd_afbcd: Add an exit callback to struct meson_afbcd_ops
  drm/meson: Fix error handling when afbcd.ops->init fails

 drivers/gpu/drm/meson/meson_drv.c       | 25 +++++++--------
 drivers/gpu/drm/meson/meson_osd_afbcd.c | 41 ++++++++++++++++---------
 drivers/gpu/drm/meson/meson_osd_afbcd.h |  1 +
 3 files changed, 41 insertions(+), 26 deletions(-)

-- 
2.34.1

