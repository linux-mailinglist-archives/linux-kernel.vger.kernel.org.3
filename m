Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D454667F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359562AbhLBQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359461AbhLBQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:28:43 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E68C061758;
        Thu,  2 Dec 2021 08:25:20 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id l7so775265lja.2;
        Thu, 02 Dec 2021 08:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqYniy4pFRsXD92ySrc+ZxB/2v4IriL3y3/YUqS2PUE=;
        b=BQwLoD5GsKuHwGcm9CCRNNoWfhuNnvmOM/2ZfVxwRSvlj+i9mrX6Mzj+ppnnqAI2rq
         E4tEwLGLm2ZnzLcmo7YCVVDjFY/vifIM4jmBBPiT9ZNPUUc6jzq+1MFNWnx+tx+iOPx1
         iCqsC/b3kAPfUNlk7ZZvnIGQb82xDqikIR2SFjicK1Bq8gRWRMpOORG1GxFsWkYuCL+4
         HshbFPgGDw1cizhpzuODlQc4P6wY2GQ3HLYY8tmbpgbAXrmgv4ynsB2RGnML4RhD0PEA
         hOOHxPmFfl9yyVqq1ELu6U0RJDWBjL6/FD8csHQz7n6CUkw0CaSpULEtIoeWnNSCiXy+
         A+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqYniy4pFRsXD92ySrc+ZxB/2v4IriL3y3/YUqS2PUE=;
        b=HSHzoOMPiTrAdQHOg7YA98loFRs9ahxTrwPMzzgLpjyuB/+XkEYbrV/RSu6nyjhpmv
         WSir2PpARjLjpuze1l5QpdxngDYd73CmeY4t9FRtU+iiX8pDAu+Rb8Xnxm/wDNhBrFK+
         YXrvf4PHGrg2y1FxQWfT56lfvioJOAP7wwBptPh6xb0PzHu6Lp77WYNk425aVVcYOTh5
         f8vh0v/eNvTEuQJW3e3JnkfrFSPHkLJ85L8Oi5AcJPQE25bSLWnhRhcPRuZm7Tb5cBnQ
         SHN1uv9Hlelmql7vMDLR6hn0mtE5rJfs2kTCyrod6DN36zkAfcE0J4+U4u2vAKN/QhHE
         w72Q==
X-Gm-Message-State: AOAM532S7RS+JJBSM6Pu4K/r188deH+b18M5BMyUrKv1zWqaK9YvmJME
        jPxlfm4+p1pBksbJ2ey4n1k=
X-Google-Smtp-Source: ABdhPJySugSp1rA4YrKTD7/t4BqlpGfdBZL4TlGHm+Feas4m0Bqsz3MGvtiX9EqaRmuZilIyrhztTA==
X-Received: by 2002:a2e:948:: with SMTP id 69mr12422486ljj.82.1638462318795;
        Thu, 02 Dec 2021 08:25:18 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:18 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 03/20] ASoC: dt-bindings: tegra20-i2s: Document new nvidia,fixed-parent-rate property
Date:   Thu,  2 Dec 2021 19:23:24 +0300
Message-Id: <20211202162341.1791-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new nvidia,fixed-parent-rate property which instructs that this
board wants parent clock to stay at a fixed rate. It allows to prevent
conflicts between audio components that share same parent PLL. For
instance, this property allows to have HDMI audio, speaker and headphones
in the system playing audio simultaneously, which is a common pattern for
consumer devices.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra20-i2s.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
index ad43b237d9af..68ae124eaf80 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
@@ -42,6 +42,13 @@ properties:
       - const: rx
       - const: tx
 
+  nvidia,fixed-parent-rate:
+    description: |
+      Specifies whether board prefers parent clock to stay at a fixed rate.
+      This allows multiple Tegra20 audio components work simultaneously by
+      limiting number of supportable audio rates.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.33.1

