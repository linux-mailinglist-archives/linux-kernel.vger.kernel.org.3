Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42448FE92
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 19:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiAPS4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 13:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbiAPS4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 13:56:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5993C061574;
        Sun, 16 Jan 2022 10:56:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id e3so46718685lfc.9;
        Sun, 16 Jan 2022 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7przyJ74L+AMDtXI8Jcieq0A93wliGwhbvxNvoTD3A=;
        b=JklcGAPkoV7myZdRwAogQa5AhJkzvVQuYb0qTOs5AAhnOotdpB+P+taD/7ataky29+
         gl/IcfW/CW46sx+2xdRXQ/nrRdaPPfpquOgz8D8CxmSghxH+doqGESxgm15n7rdq3LeG
         yMpiKAmvauteFZ9D40y0S24V61WbThsd0pgnIjl/dz0K5M74l1pMxtZ0cEkT4DEd99oG
         7kG6dYl28Ins1Lm+aSTd7p5iRQiM1uykgVXV8FQ2gtEre6PMOZiiQFu6fpGjriyL8SV3
         fJiO+hJN3w9ClN9buv+LbmL34axzeAbNgNb83DHsmArLKVzrrVjx8Iwc229iGXL56SNX
         GY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7przyJ74L+AMDtXI8Jcieq0A93wliGwhbvxNvoTD3A=;
        b=P0sJaORIgSjdqHQ/zNX8eideeim9d1b62vHsxGrvgIBum2XdX+gZCUfVnsdueoNnhl
         A8uCZES+qlgsg6Bagu4LBTNax6pelMX0VaTyOJyGSDQNIA86LgB2nrDSs/pJY6AtOLzU
         t5ep4m+iu8Mow01bGYNNatD7Fi6WrrXLyBAStQMaETbWtQUoQHTm9G+K2EGfTbmbPB46
         5T3qwHb5HAsuy5sUgP7JIxIauv5spxAHRyYZzSugbNyu4CVnRqJdets8Zfd7+XyTm8Or
         0qr+2s7oslkV5u3CTan2/alSFo8JfAi6l1p8AZxleVukN8iNtap0gprx3HieAZ1ckb5I
         G6KQ==
X-Gm-Message-State: AOAM532HbtFTdGUP0A+/IfWJeJkQpOABJ5ePEHWIp1HmqMhXVp9YWcyR
        nP/Bz3zGpqG7v/T5dFe+A+g=
X-Google-Smtp-Source: ABdhPJx7UYqC3EGtAmGSFKE1yE4ONaTrL9rAQW/RZkbm/ERCynn/s/vb0T7QLpblskFLGMLFYUR7gg==
X-Received: by 2002:a05:6512:2521:: with SMTP id be33mr11449331lfb.276.1642359400266;
        Sun, 16 Jan 2022 10:56:40 -0800 (PST)
Received: from localhost.localdomain (46-138-227-157.dynamic.spd-mgts.ru. [46.138.227.157])
        by smtp.gmail.com with ESMTPSA id j2sm1179597lfe.18.2022.01.16.10.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 10:56:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] media: docs: dev-stateless-decoder: Document frame type flags
Date:   Sun, 16 Jan 2022 21:55:56 +0300
Message-Id: <20220116185556.10657-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220116185556.10657-1-digetx@gmail.com>
References: <20220116185556.10657-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document that frame type flags must be set for the coded buffer.
Decoders, like NVIDIA Tegra h264 decoder for example, won't work
properly without these flags.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../userspace-api/media/v4l/dev-stateless-decoder.rst          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
index 4a26646eeec5..845f4481d34f 100644
--- a/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-stateless-decoder.rst
@@ -271,6 +271,9 @@ A typical frame would thus be decoded using the following sequence:
           we are not sure that the current decode request is the last one needed
           to produce a fully decoded frame, then
           ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF`` must also be set.
+          ``V4L2_BUF_FLAG_KEYFRAME``, ``V4L2_BUF_FLAG_PFRAME`` and
+          ``V4L2_BUF_FLAG_BFRAME`` must be set if relevant to the coded
+          format.
 
       ``request_fd``
           must be set to the file descriptor of the decoding request.
-- 
2.33.1

