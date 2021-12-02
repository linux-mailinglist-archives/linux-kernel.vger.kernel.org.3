Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8541C4667ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359541AbhLBQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359473AbhLBQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:28:44 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B04C061759;
        Thu,  2 Dec 2021 08:25:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t26so72771231lfk.9;
        Thu, 02 Dec 2021 08:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eb7uDgOyBpxldHIEI+VonaK+Xu/ASCFuEjbDdDXN+6A=;
        b=lMiY1EXt4w+RL9u0IPATTDoQY0ybYySCgRRawq7FiQQ6cu8lGKSuRmzHsR0SYmAs9E
         NTwTFVZDuohdN6l5gAxtcgSan+WimVzGGoQLdRUHZccNPI2adS24DLVL1BUaefWqfIhJ
         CJuCuHsM6SA+zRVoRBhK4Okt3KwSdqS3aZhu6TRUnZo97joIoej0hmLU0eSlmKSokw22
         CfKi27lCSZXfyFjaclrJ+rFKYg3dtqoo0SDNuuysa/OSPlnIrAvPuIj9S4s2yzuXwWRP
         kUwBE+9zfZfWrjCsepQmTitsjcgaBbKcoKzsAP6P6BbqXGqxSIfPFu5nWAmeNYtQOQkw
         KG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eb7uDgOyBpxldHIEI+VonaK+Xu/ASCFuEjbDdDXN+6A=;
        b=LwpRaifYm+u5/qPYAY4JTH/Jj4Ly25RmyI+9XZh651jaSTaUoPaxxoiWURzcBsnF2H
         PrP0269Y5BJKCXHX4PlRUNYQkNcFxjuAU3ruQU9w/AEejcDvHOEyfKw+5a59RBgtpxi7
         NZYyn4LXyuK6V1zhsN25R12yXLApHnq+uAfBd+ugUGUVHYeU88oJERfzOffe2IwkkDph
         vMXoSbzkT7Z7mjVbzlT2JGIzJTliWeBzIX03JL8t0/4AWflBZLI2bgJW4RaIPgpEhZKU
         iI5wFSoZ5AINAOgPuG6aG8KPz/l25osSOHtKUBwq6SshlF9H0TRcs2UAJmW/8B0yH5HT
         bMpw==
X-Gm-Message-State: AOAM532Gel2QVCwiO6yxs85ebAR8GWFz0ipijKPKYT79qLUp2UTj9msP
        TPwBwLR17wTfYs2PGZwZMmE=
X-Google-Smtp-Source: ABdhPJwlmJsck7gfHr6wwFHtKiWtjlI65dHudAqSt9x2WsizwLZ0RHza4o9/pwyFMZ5LqykxSAe8yQ==
X-Received: by 2002:a05:6512:2304:: with SMTP id o4mr12337688lfu.104.1638462319854;
        Thu, 02 Dec 2021 08:25:19 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:19 -0800 (PST)
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
Subject: [PATCH v3 04/20] dt-bindings: host1x: Document optional HDMI sound-dai-cells
Date:   Thu,  2 Dec 2021 19:23:25 +0300
Message-Id: <20211202162341.1791-5-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new optional sound-dai-cells property of HDMI node. This node will
be used as endpoint of HDMI sound DAI graph.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index e61999ce54e9..27b746f28f31 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -297,6 +297,7 @@ of the following host1x client modules:
   - nvidia,edid: supplies a binary EDID blob
   - nvidia,panel: phandle of a display panel
   - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - #sound-dai-cells: Should be 0.
 
 - tvo: TV encoder output
 
-- 
2.33.1

