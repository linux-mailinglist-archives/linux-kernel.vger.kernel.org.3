Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7E4D0DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbiCHCCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiCHCCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:02:48 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192727150
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:01:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 132so15125382pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 18:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=/vVnL9eYRSzGukw8SFc4KUz6RxUiiMNRCtt3A6IgWHI=;
        b=WPJQz9gUASBXedyL88smBZOyRA9JuY+a6vfbE+eUe337T1Tdam2Tf3OdpOD35A7R70
         n4AZomhDj5LMij9G0rEak9DF6iZxzULyMTsFYg491ifyShip8mRnyv9lhVKxiuoAE3+w
         B1ahPQ2lO+Jb7T7wpPIbsWkHqTnRpEIcpnkTegl7jdwBLN/EhPOqAajySUM41nn4Eoq5
         3kOr3qn7HUpednBBnSY+H672xEHFyQK4x7Kk205sEjbyxfxQZO4EhM7QlIIFBXE6gVmK
         T1rRrXRKxl9glJm7PIf4pkFV+AK/lQ7JP+fTPNh87KLBSdJmKwu7tQ+tn5Sh4mnUfwlF
         LkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/vVnL9eYRSzGukw8SFc4KUz6RxUiiMNRCtt3A6IgWHI=;
        b=0vZSn/qgDR1C62c9fjXplSCKP0KoyEDrQrcy5DmdWnzCH3njJwK9i19MoLvIjv2BoU
         9wK9DgOMFl8VmQY2TAg9NOKuSdtkGvaK2+PreDQHD3MRBCkG8rXTckBYkera/mkyMAd7
         Oyes1yPzyJyC+I0ZToF6rCA9WCqvuwXpZXwzxuE9CfXOzDJa3WpZSa0PnCeCmctNbtos
         6KB5Vzq9pDvrA/baqYfjetWxG9tFJaNSg6MnC1q1H1Kf0Lzj4iQfojPf2RdIqh94d8sq
         8270+8sA2tlraCw8PhsLRU0MtNIqE0v23UtrALiC87Z12BB/j1/L/i91LQ/g7NYCcmHU
         SsOg==
X-Gm-Message-State: AOAM531SL15ewqcRFRccv7WCHbF6UYNFqjO1QbVsaogWuX76ZTyDlkXw
        gLoZtJ0F9+SY9oxM1BCA3JA=
X-Google-Smtp-Source: ABdhPJxCExbpTHk8a9vWWJJ96DNwpeeHzcqKYTbVm6C0ubr8FBGHGZ33z0smAzSg2JP/ol4UAJAeEQ==
X-Received: by 2002:a63:84c1:0:b0:380:64fd:a2d4 with SMTP id k184-20020a6384c1000000b0038064fda2d4mr4690598pgd.51.1646704912369;
        Mon, 07 Mar 2022 18:01:52 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id pc17-20020a17090b3b9100b001bf88fe5edcsm393672pjb.9.2022.03.07.18.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 18:01:52 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Miaoqian Lin <linmq006@gmail.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mxs: Fix error handling in mxs_sgtl5000_probe
Date:   Tue,  8 Mar 2022 02:01:44 +0000
Message-Id: <20220308020146.26496-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function only calls of_node_put() in the regular path.
And it will cause refcount leak in error paths.
For example, when codec_np is NULL, saif_np[0] and saif_np[1]
are not NULL, it will cause leaks.

of_node_put() will check if the node pointer is NULL, so we can
call it directly to release the refcount of regular pointers.

Fixes: e968194b45c4 ("ASoC: mxs: add device tree support for mxs-sgtl5000")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/mxs/mxs-sgtl5000.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 2412dc7e65d4..746f40938675 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -118,6 +118,9 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 	codec_np = of_parse_phandle(np, "audio-codec", 0);
 	if (!saif_np[0] || !saif_np[1] || !codec_np) {
 		dev_err(&pdev->dev, "phandle missing or invalid\n");
+		of_node_put(codec_np);
+		of_node_put(saif_np[0]);
+		of_node_put(saif_np[1]);
 		return -EINVAL;
 	}
 
-- 
2.17.1

