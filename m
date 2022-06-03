Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D9B53CA67
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244508AbiFCNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiFCNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:06:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB813B3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:06:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso7179339pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3vUdnokUr6xPDhF0AvWg+SWqFU7xQQlluilxzt4oqA=;
        b=ZWgpkAawyrGv5cgAys6c9xPOe/uIe6rZD87MpikzCyKjdtbY40ZPvb3fx4HxB/pcXG
         Sg2rNs8MkzfbO51CRppIyrmFW4pUfZZ8tApmbt6RSWRm3LgVUY2o2MDMNtetT1iuRtbO
         /IKuAwA6BHaCfx6a2A0k3jbIpE99MXPPjEv1VTl+K2GUnN1LYVlbTAQe5rBfomQ8mQ8Q
         TtncodvkSHgrpt6Bp56owgYjVx9kCPpi8BNxeMys5wh/1zn2BXmHIrqKwHKvNiczR6wh
         NiBwWkH4puarM+tiSttArLJVA+tUSbMODcc7GE3lEC+BlbTV+q3kx+yJ3KxnCaf+y+98
         stRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3vUdnokUr6xPDhF0AvWg+SWqFU7xQQlluilxzt4oqA=;
        b=G05Z1iuYEZDYspM4VKDxAlNK7tppLzoV6a0hnRh5tWKuq7s4KymQKHVDvj1vQAdcev
         CdplRvSZmamdiqyfA3aiWW4ahhMbe7pSxqYq0p5H/WoioDcwnLKIs6wFOvMuSgwJ6G+X
         jct3Whug8TCGvRMgLe1aga8jfm+Tnk7PekGksHv8iQxT0dEISjKAzvJZvsZ/QHf2Gkf2
         a4DICEI03qFm/U+oKVsq4s7yqBIKnzqbuz78McTLWy+QkLYbKUZPj+/J0d/8iLFcO1En
         WgIiMuMUTZxXYuNpyhy0RbdDHm3HjPUeEp/vkd2N/3ctPgY/6DQjxpCQWB2RWYXLvXI5
         wQgQ==
X-Gm-Message-State: AOAM531aCSmUiAOOPl+rhtxQ1ZfYbU50/TGOPWl2GzhneB+ENZWKspHd
        wciD1sbtdXJYl5RNyyIYVnI=
X-Google-Smtp-Source: ABdhPJyVzZsXhLPbZlT5aB7VVCZYSxkeRJt3tG4+jZj5qunY+vfuaTRanCISxwpBR7kKfWr1H0a1/Q==
X-Received: by 2002:a17:902:ac8f:b0:163:fbb7:b057 with SMTP id h15-20020a170902ac8f00b00163fbb7b057mr10294401plr.67.1654261609606;
        Fri, 03 Jun 2022 06:06:49 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id fh6-20020a17090b034600b001cd4989fec6sm7608329pjb.18.2022.06.03.06.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:06:48 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] ASoC: samsung: Fix error handling in aries_audio_probe
Date:   Fri,  3 Jun 2022 17:06:39 +0400
Message-Id: <20220603130640.37624-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
This function is missing of_node_put(cpu) in the error path.
Fix this by goto out label. of_node_put() will check NULL pointer.

Fixes: 7a3a7671fa6c ("ASoC: samsung: Add driver for Aries boards")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update Fixes tag.
v1 Link: https://lore.kernel.org/r/20220602130218.14901-1-linmq006@gmail.com
---
 sound/soc/samsung/aries_wm8994.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index bb0cf4244e00..edee02d7f100 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -628,8 +628,10 @@ static int aries_audio_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	codec = of_get_child_by_name(dev->of_node, "codec");
-	if (!codec)
-		return -EINVAL;
+	if (!codec) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	for_each_card_prelinks(card, i, dai_link) {
 		dai_link->codecs->of_node = of_parse_phandle(codec,
-- 
2.25.1

