Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1A1468571
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242914AbhLDOlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbhLDOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:01 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310CEC061751;
        Sat,  4 Dec 2021 06:37:36 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id i63so11977162lji.3;
        Sat, 04 Dec 2021 06:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eb7uDgOyBpxldHIEI+VonaK+Xu/ASCFuEjbDdDXN+6A=;
        b=KGnKA/dQc8pbQH0H3RIo4qaNKiRY7d6IAIGib9U78EeBrBD/UO9dBe39jn6NgwttBT
         jNS8LifWCAC6/vvC65qiJ585D9msh7sKwa2ZYt9WGQa6By9MrbEE/f5CC5RsaJ0mIIB2
         TJbx5dCfEdNn+VlHCLE/7DollFvrYKaP3BZ8zUtdAjX5rJHLshRJ4iHArEL57GLRzotm
         FPRXwdsppJ+fypDqncS0FQ2Xnkm92/QOqvfu0yQ9Do6TDxruI30g9yzSURNHxDvHQUWU
         CNsfOhgo0bGgWEqY9ECgmDBN1xOjLkEftjUTzDxwrnaKbQ6JrujXIJartr0qyZVNSC2f
         ADnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eb7uDgOyBpxldHIEI+VonaK+Xu/ASCFuEjbDdDXN+6A=;
        b=ayNpMUq9ROw7CbDVIK5wrn1pdvsLRsm1mQV4QTkQE4HIb3+IRjbtn8Um9Di0yqD5Uc
         cq7gPjsAZo0DiM94FIbNGCLIC1zEEtfnJXqT2bk3APBI87eEvCTRybEQ2Ohpyns2c4TB
         HTTh1gJJnBzCo2y/PC3hiD7Rn9L829RZy8pvwvHlo4bNaZLTuqIfzVOuubYS2aWlAWOB
         g1qOhYydAzyynG+vXzf7tr6IC1sKxAOSqIZixfyGSz0sXGqUfdhYz9mHR+4osc+ohI8t
         M8ozkaU1TVngz8iaSByI1TVP/0KzhKuvziZ7h2Fu0+7OWnZsXFR2cKpOn56M1xdKSz2u
         y0nA==
X-Gm-Message-State: AOAM531FiGp+FNyOyJlNQ5aha0q9ylS4o5O/pqqYJLBfS5zKRKN5jJWq
        mpm486M3MSNrDuqWyeyeWQU=
X-Google-Smtp-Source: ABdhPJxG9CwWehDg+cjNOGJNJ68s2+9n0UqBCW/yFW5nzEyc+H1ZMEC6RTa4ZNUFnEefQ+7xWgLCFQ==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr24483040ljg.13.1638628654467;
        Sat, 04 Dec 2021 06:37:34 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 04/22] dt-bindings: host1x: Document optional HDMI sound-dai-cells
Date:   Sat,  4 Dec 2021 17:37:07 +0300
Message-Id: <20211204143725.31646-5-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
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

