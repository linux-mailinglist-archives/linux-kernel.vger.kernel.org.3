Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7650A4A62E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbiBARrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiBARrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:47:48 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B281C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:47:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v13so33440212wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=US/OKgVIq7RQTvUVVDRe6xDQAKQFvgSJ0bC4ZgbJ/HE=;
        b=MYlzl6pGX5ozr5W0N8tzLgaoBaN7ZxAxMZrYHi1p9AMu45EI6sVmQjAh5LOzqZMZGn
         A26oIIkNc9Hb3em44A15yWRmAxlv2YJy/wSzcMI+TRimEmqiTu7jV4xSM5H9Xdruqn8W
         I41sDYM0ZJhdV+fycMWw99ORNq4UzOQwWJLFUhDisj7MSPt7hJooGByquusV3D78x5Lv
         nf3S3iJ50zUvejLNPg5C7KJ7o3a02xx6vbYwHZT4Ab8GxX0OzLyOZP+SswKKtbk+2zJT
         fwsVZD0lBkcVxYKQede0BS5A/ZoP3vVBaQB6HQsgBWpIAZdYk6JtrMWBXqVHjnXYYQOh
         L3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=US/OKgVIq7RQTvUVVDRe6xDQAKQFvgSJ0bC4ZgbJ/HE=;
        b=ajOCfzi4as299x9C7W8q2cilLrC8mXwMfF7RSJb4chLqllv1Bvx7CnGIgpjGWgUrv5
         0k+A2VkpLEnePodcS99w6Hi1DSw9xQs7ZdldGRhDteS0po+B58fTaYU/BeY8FNJ0Ow/T
         itzCVV/zYGldwed2lZgdNkm87riOGLk7DPDledcFzQnqXpqtUhanHN5P6sqEMnAw/G/N
         5vPEmK4ch/WDmAzu/jnJU3JbdSRDhenSVaBrP9ar9m63HwrrpVJTJiTHdme9vbdg996q
         Fao50sWta55oPF+zcnxwYxVQmfk8M9CX6cWi/8R//o4ibnu4wuGju7FiGU/TIvINYeOM
         8JdQ==
X-Gm-Message-State: AOAM530c3AvM3xlo+e363CoLPSobNaqmMW8CRL6bCH9RYDytpr0QCAJe
        eJcms7O2kEpebB/CS2SEIA04yAwktcwqSt9e
X-Google-Smtp-Source: ABdhPJyv91uAdSZ2+/CfoH19SZ7LhCK1uLFNm/z3HHrAL22Qmg4Ltwk+rufuf/oFeWKR6aywDtXvFA==
X-Received: by 2002:adf:e386:: with SMTP id e6mr2424961wrm.542.1643737666682;
        Tue, 01 Feb 2022 09:47:46 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r2sm3392332wmq.24.2022.02.01.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:47:46 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/msm: Remove spurious IRQF_ONESHOT flags from dsi & hdmi
Date:   Tue,  1 Feb 2022 17:47:31 +0000
Message-Id: <20220201174734.196718-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series corrects incorrect calls to
request_irq(..., IRQF_ONESHOT, ...). These anomalies are harmless on
regular kernels but cause odd behaviour on threadirq kernels and
break entirely on PREEMPT_RT kernels

I'm pretty certain these problems would also provoke lockdep splats on
kernels with CONFIG_PROVE_RAW_LOCK_NESTING enabled (because that is
intended to find code that breaks entirely on PREEMPT_RT kernels ;-) ).

Finally, and just in case anybody asks, yes! I did use coccinelle to do
a quick scan for similar issues. I didn't find any other instances in
drivers/drm/ .

Changes in v2:
 - Split into separate patches (Dmitry B)

Daniel Thompson (2):
  drm/msm/dsi: Remove spurious IRQF_ONESHOT flag
  drm/msm/hdmi: Remove spurious IRQF_ONESHOT flag

 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
--
2.34.1

