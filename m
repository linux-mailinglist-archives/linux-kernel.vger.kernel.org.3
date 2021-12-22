Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD40447CEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbhLVJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhLVJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:05:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8139C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:05:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q16so3470050wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFNkjOhkbVUPCPag3+lAuNDHEf6o3ru8j250NbFjPto=;
        b=PWovdBphqrEK39M+gpDvGqxAdVPJl6QRH08LDrE+POux+PO7tP7Nq3+hmvFGa/a53/
         XL4qcWwkKXpqepZ9OJ6dRIlDgLiBr3KiSIaAltvzLJG+QFcoIeTRF+DE3+Lq8xaCSkcO
         DCmqg/yNfXwUSWbixP4Nz4sPf/o+ES/VSQZ8Jq8iUBnnixA7IEI2eepCOHFPVWsyTEre
         VrauRXaUmPCXzMC+Pnr0GHA4Aj7LOhjmvVG1i0T5IXo8SZiYdj/FkZZ7dJSrSMSN3tbx
         c+6weXHSCO2prqtwazZPDjQ4pA2nwe5rCz5NLTI4oGG5wPHKr2CBamLoX96GgGiPaFHp
         cY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFNkjOhkbVUPCPag3+lAuNDHEf6o3ru8j250NbFjPto=;
        b=ZrnfpHmjxMLEwkSuCeRimHBWBjWssnhhgBrHwncSwGhUct5h5t4lu8udERvloDtqaZ
         p9llbDJ067i06cnDH4MzFxVByE+q7KBl1aTh18Pf1UZTIUWzJREC+gghGqout0xwy/NC
         53uqHOoUzEwfZNyR51YIGfUL4rjOhwaXhvy9ojIhMUaJQ8xCT0/yErsgUqn7dwuvqUvI
         E/OmQMN07kgNgw3Ex+hK2fvAjunOwIyF9dH0VQREJMlxuHgK4HGBUvJshBB+cwlpaq5v
         C6u78Sv4Rrvcpow+3htXCXf3XSyrf3trDwkolwAuzpy5rRegnUUUl6nVqKJX5NAqFiCn
         Fn6w==
X-Gm-Message-State: AOAM531AYqs4bG1zyKMtg6P05QXuv+21WAigjGDj+NQ61ANz3D1v2TxR
        0Ls1Y0UAkNQGSKyMBc8rmg8=
X-Google-Smtp-Source: ABdhPJy7flmzMTQMI+3SUiNfM2NPwtetHwfXTX+i112NC6r7WXwuYpXcaDAx0EErcXx/XtP7nmcycA==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr1384847wri.197.1640163956459;
        Wed, 22 Dec 2021 01:05:56 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id a22sm1139775wme.19.2021.12.22.01.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:05:56 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     contact@emersion.fr
Cc:     dmitry.baryshkov@linaro.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        marex@denx.de, stefan@agner.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/6] Add missing format_mod_supported functions
Date:   Wed, 22 Dec 2021 10:05:46 +0100
Message-Id: <20211222090552.25972-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset supersedes [1]. Now the title is a bit misleading, but
I left it this way to (hopefully) facilitate the maintainers' work.

A little context: Originally, I sent a patch adding modifiers to the
VKMS driver and Simon Ser kindly reviewed it and pointed out that
"format_mod_supported" was missing [2].
I asked if the docs were incorrect or if it was a bug in
"create_in_format_blob".

In the first version of this series, Simon Ser and Dmitry Baryshkov
agreed [1] that the code should behave as documented and
"create_in_format_blob" should be changed.

This second version implements the required changes and drops the
"format_mod_supported" in the drivers that can use the default
implementation.

Jose

[1] https://lore.kernel.org/dri-devel/CAA8EJpqJ-tWmb5Ba6XSK59toCtLb3nRRmVH8da4Ud_rrRYytmw@mail.gmail.com/T/
[2] https://lore.kernel.org/dri-devel/20211216170532.GA16349@elementary/T/

José Expósito (6):
  drm/plane: Make format_mod_supported truly optional
  drm/plane: Fix typo in format_mod_supported documentation
  drm/simple-kms: Drop format_mod_supported function
  drm/i915/display: Drop format_mod_supported function
  drm: mxsfb: Drop format_mod_supported function
  drm/stm: ltdc: Drop format_mod_supported function

 drivers/gpu/drm/drm_plane.c                 |  8 ++------
 drivers/gpu/drm/drm_simple_kms_helper.c     |  8 --------
 drivers/gpu/drm/i915/display/intel_cursor.c |  8 --------
 drivers/gpu/drm/mxsfb/mxsfb_kms.c           |  8 --------
 drivers/gpu/drm/stm/ltdc.c                  | 11 -----------
 include/drm/drm_plane.h                     |  2 +-
 6 files changed, 3 insertions(+), 42 deletions(-)

-- 
2.25.1

