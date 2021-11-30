Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889D046431C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbhK3X3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345405AbhK3X1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:42 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D677EC061746;
        Tue, 30 Nov 2021 15:24:21 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u22so44298522lju.7;
        Tue, 30 Nov 2021 15:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyjSvb4lk8LZ0fmi7jCFtYmjUWcyFJSJ9ZWFZBD+V/E=;
        b=MkhwEeO5+CdWqDlgitQ8yDbdzgWi6xh1tqG4982cZtFNn23ZgAFp7UUqDMMOMZQ9zr
         CLZmFy868oqlhjFA/PN8MsZONbNJi+2IafAu6MbsiH+cAepnux22bDTyXzo5d+Q10kHj
         yYTqy35mdksdJKEf2pM7tzrFkcBG7imAd3CkgkGQAwklUAKnQNsVfbc0ilhZMYOeuE0o
         TAARCpglriNMEXfI4vre2BQ2Cq71B1LawduNLAJfvU+r6gX7AhqwcqOOwpNAWP6UJye1
         xo3JWMHm2VkgpYf4F4tMr3/W7gvJsmd62ZbPHLnIdmXHrkmKygBm287r1NzRAbwbndLH
         z9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyjSvb4lk8LZ0fmi7jCFtYmjUWcyFJSJ9ZWFZBD+V/E=;
        b=qxlapP7tQk+1pOjVWoYXIuisifWgC8hMDE8siIwltae7WokJ/hnC6fvXGu//w6aR5p
         1eM8eQIb14Ra/YexezcZhF+mJ5it1ah3VE0/xu97mh0qyZCpm154dckHXuRpUetjr17Y
         DaW8amlvN2mlEK/o0WmKZBICfjflKuqInoUamvkoZKnOWmSYgmRz+k2JnAVf6NHlFw9/
         8vS/YKJZO8k95ErPdFXdBVuaO00cX0Vh8+PY/UDQwpEmGFcYqFIgYbW3SqNlWps6ZOqY
         ev4gCpNS9968zf2J4+Nx4T5iuI/wh91J71L1smd0+GSU3TP5aYzHf25gltLigj4PRxko
         1Jfw==
X-Gm-Message-State: AOAM530QExQvnR8Axkz9OuddI1NWLjMiOXf/xb+ct6be3g5RPrkZk9SY
        TQ29y/YgS6hwuc4c/B0jAyc=
X-Google-Smtp-Source: ABdhPJwa1SV6w3TVbjiUVfrrS5uM+KrPfqyISSji0kQwwgoD21u3jWP3tkLcipklfEsVy3Ju0ThTMQ==
X-Received: by 2002:a05:651c:549:: with SMTP id q9mr1927513ljp.25.1638314660235;
        Tue, 30 Nov 2021 15:24:20 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:19 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 26/40] media: dt: bindings: tegra-vde: Document OPP and power domain
Date:   Wed,  1 Dec 2021 02:23:33 +0300
Message-Id: <20211130232347.950-27-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new OPP table and power domain properties of the video decoder
hardware.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/media/nvidia,tegra-vde.yaml  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
index c143aaa06346..4ecdee1be37e 100644
--- a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
+++ b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
@@ -68,6 +68,16 @@ properties:
     description:
       Phandle of the SRAM MMIO node.
 
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property,
+      which is a bitfield indicating SoC speedo or process ID mask.
+
+  power-domains:
+    maxItems: 1
+    description:
+      Phandle to the SoC core power domain.
+
 required:
   - compatible
   - reg
@@ -104,4 +114,6 @@ examples:
       reset-names = "vde", "mc";
       resets = <&rst 61>, <&mem 13>;
       iommus = <&mem 15>;
+      operating-points-v2 = <&dvfs_opp_table>;
+      power-domains = <&domain>;
     };
-- 
2.33.1

