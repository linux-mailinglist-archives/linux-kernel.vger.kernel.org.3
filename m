Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329CA539BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349459AbiFADkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349476AbiFADj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:39:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1051C9CCA0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:39:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u2so784308pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAOtSJQ0e7lMXAVSUZPZ1qHrCN9pnSWlg6iMnewBSfg=;
        b=I7Rwzn599nYSXO0ehdauIMZ913hZwSg4hgdHDi4NFjycN3mkFHslQfzGP5zMCMJhTw
         ZY2WxucR6T2h6FsWNtPsI+jPqEoMN47gW8e61OElRxQgKXqx3TIKQmYq6PR8lQoSH2Gc
         swltfB8cc+I7C5uI3Vnj5qIR8ImmocRWCNiBmmb2YI+E0F0IBalWIZxWH18tHjneVFuI
         bK0s9Zwy2llZfvWj4W35wOZywZ0mnDqhFYdDQqNPc2PmFWMR9DYnqznYEpYgquej7kBX
         5Nntt+BmHjK2A6gqupFV4Tl/IW4m6W8WNyDc3JGafp9DcNENPxWPSX4WRZO7Ynm1K7km
         J6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAOtSJQ0e7lMXAVSUZPZ1qHrCN9pnSWlg6iMnewBSfg=;
        b=tPRmMTrUbwJ/SjR8d++9ZrVqw5YXeJtpS7YNNeq7gIkSqpryM75NPWD0V4yHO1YLrm
         Y05fatlIcPio4rsBhQT0X4XrIqnqAj8DEEuxFgLsdS0ZIabzgAUJiDxZ5OwS337rhq0Q
         hqOhhi/whO5fIbbDhiitR3pEMjzQB0PVMyzukufyx3n2ckHJ/oYlN/imU3Z2Qx717M8l
         UrzAQwD9r8Ld6Dunx2Pm/zHmSgzIi57gXpyVO02O5b0YtuM9wgq09ElCy0hEnkS69rOg
         ehNEUV43kmdn3neO1qCfqBlskRbkU3sMUjGXQ7aLQ1w9WZ2PBvdlbOlGpRLu3B5aX+Xx
         cLow==
X-Gm-Message-State: AOAM531ezvqjQIiJHrAMErlYnt+jpWgJ5VJDr90xv2kAPGo0akqtbJ6X
        9ir+26E+EbHuov62IOzK0Og=
X-Google-Smtp-Source: ABdhPJw7vYFqNAuZ0ZS77DemhLpZ6cPkQti7TbLMdDwMmA1GStvhzPaixJeC7e2jd+/eSbyBBi8jlg==
X-Received: by 2002:a05:6a00:1946:b0:4fe:309f:d612 with SMTP id s6-20020a056a00194600b004fe309fd612mr65087189pfk.10.1654054796300;
        Tue, 31 May 2022 20:39:56 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id dw15-20020a17090b094f00b001e0b971196csm2732415pjb.57.2022.05.31.20.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 20:39:56 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH v2 1/2] drm/meson: encoder_cvbs: Fix refcount leak in meson_encoder_cvbs_init
Date:   Wed,  1 Jun 2022 07:39:26 +0400
Message-Id: <20220601033927.47814-2-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601033927.47814-1-linmq006@gmail.com>
References: <20220601033927.47814-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_graph_get_remote_node() returns remote device nodepointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 318ba02cd8a8 ("drm/meson: encoder_cvbs: switch to bridge with ATTACH_NO_CONNECTOR")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_cvbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
index fd8db97ba8ba..8110a6e39320 100644
--- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
@@ -238,6 +238,7 @@ int meson_encoder_cvbs_init(struct meson_drm *priv)
 	}
 
 	meson_encoder_cvbs->next_bridge = of_drm_find_bridge(remote);
+	of_node_put(remote);
 	if (!meson_encoder_cvbs->next_bridge) {
 		dev_err(priv->dev, "Failed to find CVBS Connector bridge\n");
 		return -EPROBE_DEFER;
-- 
2.25.1

