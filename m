Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FF8489067
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiAJGxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiAJGxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:53:22 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D42C06173F;
        Sun,  9 Jan 2022 22:53:22 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id l8so8841229plt.6;
        Sun, 09 Jan 2022 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=y8qyK9Z1xdNQlga6YeRs4Ebp3n/3+IX2v6kqUk3/oSc=;
        b=Cr7WEcflIJBG/7P3XHctuvDTTVxF9JqvZi0hyBxz6tEKEgJaAefi4qKIxkAFn0Drf6
         UimMAPjrYQm3XhyWATzqAMX7bIlspftZHJZBhOY+mGhHI1ajEAiKcjU4I/hmu8x58QtW
         o+egbDqiuRAdYIcaHY0/vcBI9Z+PapWwowh/PkKhqI19Wx/VDRNH8uuOrZYm9jTUGymF
         vLvNNMaeOkuhBxwSt0Y6pk96ozOPK4DCDK1QDXK1PnjELkEFfWHcf+H8dXCJj20v1coy
         +u2dsjMqC7Qizsr06eNEOo5IU1/fgqijb/UIiJ2Pw9HXghrJkyGG85U17q6ivzKGtZaO
         +e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y8qyK9Z1xdNQlga6YeRs4Ebp3n/3+IX2v6kqUk3/oSc=;
        b=CNyNm8EFx0mptmmmUWwz1ZTpcwBNiE9K1LZnpa1B0BgrB5bpqHanvTC331JYShi5kC
         VlLdSCBOU7dGKi0C0H5bH3C7YvUgEX1e3XinnPPF1aG3KT6BSJrjiczclofokAqJUfFv
         4j71PZGtyYKD2w96ypC2Ni7pgX7RdX8++8K/gIeQDZzYtXBv0x7LZHNZSYkZttdtYUfx
         zaqLCMI+YrwcSb+cHXWPPQmr+Pgz4SBr6OxHQv48DPcf84vKdUG+FJUqUCgMHN0JnrtT
         W/8YNzxHjzHRCKeUcMi2q9RPfo3GEnpscU2fltcW+vUYDTz/YCja9OTykZsWLUX9rQnT
         aAPg==
X-Gm-Message-State: AOAM530M+ibWYaEzc17KHaO98POcMyM1LeszoyFDIIXi4kgpiixoRYqR
        S6BYrBOriGQ1gW1jDIALVqE=
X-Google-Smtp-Source: ABdhPJyD/SU7nRKBl+/czf25l/KE05P6+YzALyMSx5Y1DQzALekriTvfDZTscUp1R64rAwbo6oWrig==
X-Received: by 2002:a17:90b:1d8b:: with SMTP id pf11mr22900394pjb.119.1641797601781;
        Sun, 09 Jan 2022 22:53:21 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id y16sm1083219pfi.7.2022.01.09.22.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 22:53:21 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tegra: Fix reference leak in tegra_dsi_ganged_probe
Date:   Mon, 10 Jan 2022 06:53:16 +0000
Message-Id: <20220110065316.6023-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore. Add put_device() call to fix this.

Fixes: e94236cde4d5 ("drm/tegra: dsi: Add ganged mode support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/tegra/dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index f46d377f0c30..de1333dc0d86 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1538,8 +1538,10 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
 		dsi->slave = platform_get_drvdata(gangster);
 		of_node_put(np);
 
-		if (!dsi->slave)
+		if (!dsi->slave) {
+			put_device(&gangster->dev);
 			return -EPROBE_DEFER;
+		}
 
 		dsi->slave->master = dsi;
 	}
-- 
2.17.1

