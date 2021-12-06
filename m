Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0346AE9B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376467AbhLFXx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbhLFXx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:53:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C3C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:49:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q3so25729929wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 15:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YoZPnfaFJm1NVGIE6alXIS6Xkly4h3Gf7r5uJzp6qo=;
        b=bdEZA77yoCy5jlDOF7fcFoNBfzO2ekyxfZSZzS01rgsPfbwtoWttmnP7JhjaOo4s5j
         m99znndbP4+DVbcrdx+Hs81FutU+7lQw/McRotYEY24VAu4VQbfkFLaPEOAPQpHQwrEk
         OmSarv1sg+3ZIrNtsJGVortqFr9zY1yRyq8REhSo87bst39hX24N4kt78+zFAgGBtqSI
         obShZR4OlboBrP8bM4up+z79PZeefzPu4zGYk+2HUuecCX35B9agKMhHj4j5WpuKWWQ/
         mBNHU+oaRGFaGAn8pz1mFgjxfxa2DWs+1j1ST5kXgQSLYYuYUq49M3RJCqecs9Mkp1oH
         5DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YoZPnfaFJm1NVGIE6alXIS6Xkly4h3Gf7r5uJzp6qo=;
        b=1kvlhgjIYicMugmnI/XUxl+T4PXuNOqK5nyXZ+fMgBWcqKDqZleWqM6YoNzSL6Sw0K
         R40YqwFKruXDM2xyOShbMqzyWggMeKokAXNnHftGzRrZvT1dOQfnUEpYWlbD2mxu+tQ1
         nipBmEu64OGBGMHRm5vn/d5Csh2Rupnv3lwMXS3nTQibnTkwxnF0dOFgC0f4hzWHK/Mw
         3aL4edU17twNF/WNUKxapReOnqhSzT+gM8cpcgL1Wa2mcs0bELXDrjTegSgNEKz3aszw
         6sxKXktm9Z1hzo0B7qhcIOf/5OhZOcqYUx3Nv6mSaFzWWwWzVAK940y6lr5pge5QQ/NG
         UBqw==
X-Gm-Message-State: AOAM532ZSLY5txTXQrUXJdbDz8/vI2x8QYyILiRGR9g7HojPnZTdwZqn
        4/vKIcaqtf6HXYL/WAC6zlYXPw==
X-Google-Smtp-Source: ABdhPJydKDNkKKzaBGXb16sp9mizC1P/QZ+E3EObbHbie7C01srEFFSWZCRnbfUxIu+HDuWA+cIYsg==
X-Received: by 2002:adf:f489:: with SMTP id l9mr48233855wro.268.1638834596484;
        Mon, 06 Dec 2021 15:49:56 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id k187sm1241189wme.0.2021.12.06.15.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 15:49:55 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: r8188eu: some DBG_88E cleanups
Date:   Mon,  6 Dec 2021 23:49:50 +0000
Message-Id: <20211206234952.1238-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch set begins to convert/remove the 700+ DBG_88E calls
still in the driver source, with a few files to begin with whilst I have
time.

Phillip Potter (2):
  staging: r8188eu: convert DBG_88E calls in core/rtw_security.c
  staging: r8188eu: convert/remove DBG_88E calls in core/rtw_cmd.c

 drivers/staging/r8188eu/core/rtw_cmd.c      | 12 ++++-------
 drivers/staging/r8188eu/core/rtw_security.c | 22 +++++++++++++--------
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.33.1

