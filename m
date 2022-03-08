Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564314D0E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbiCHCeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiCHCe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:34:28 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6854AC42
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:33:33 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c11so2780392pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 18:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=JHlL483tOPXXwrShSRIjSrIFbu7utMjXnFg9i5hed/o=;
        b=WEkcwRIgKqaeYDHUvRzHgwypMhdMJA7j9eG+yN5S8IeEe3Lw9dLXp7vuoF4rdLjZYH
         iHOeyF1zmrCYUPpJj8L44HMC/wzABiTl/xT3IfsBJpXbdL9CuNxN5mPNj4pxgcoarq4J
         jFUecfa7EpJ2s+MG6QjLSa/Gv3sg7ZBTEXEUaXitC9oUAoki/eooiwrlAbfHJcQZs71U
         RDBlDmCnyURAPGkT1xAs6St1K/JQyrnubKxoqNMIynU52soHzR/64MOd0zCiKAsZGWh0
         D8ma+B2LDuYNojD+uRIpApmn9HX/BxoZ3X/iW4Rwb3QsX7zSV7fCTiiZkj2AmbZIdK09
         KZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JHlL483tOPXXwrShSRIjSrIFbu7utMjXnFg9i5hed/o=;
        b=I8FxsNTGYzYfJjxtEuDScuEpLx1RdslMgF8gcmHqNraepgR8UNE2KkxD9ip8H1EXmT
         FVDxFPXuLXqpYGuCOlTXnO20Y80R+uH1ww9LG5RjytBQEUldN900wmjz8meaE0Ze08I6
         zkhQDObz7Q24tR2v7xaNQVlILdFWpQ4CXQQHUhRvvkPNTXmzdSEL5E9SC/51PEklMP1R
         9Tbb7Zf/yYsHGU4qzpOUlU+Z3q+dsrwqyssrifVW4RT6l6rn/snWpVhVbZM2HkPq+86j
         qAXVO1k2oui9I9h2sqV64L/QydZ3tZqfYK4tFEXuI9wNqvxOwKNRR04M7myf2wzecmra
         dHbw==
X-Gm-Message-State: AOAM530Vk/Y6AnNEANPqCJU4KfjOR7M8pPvS17SFicUzPeGGykF+hhWQ
        mJW87jeR3J5i5BQQDA1bDxE=
X-Google-Smtp-Source: ABdhPJxwTjC/2YyrJTs09m/FPQR/5h0YkmUvTnHXVS+nNfwwgujRr2t9vFbiZBCRxEjAV81GX2UXbw==
X-Received: by 2002:a65:4c06:0:b0:373:a7d1:75d5 with SMTP id u6-20020a654c06000000b00373a7d175d5mr12060573pgq.502.1646706812977;
        Mon, 07 Mar 2022 18:33:32 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id p186-20020a62d0c3000000b004f6fa49c4b9sm5895103pfg.218.2022.03.07.18.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 18:33:32 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: SOF: Add missing of_node_put() in imx8m_probe
Date:   Tue,  8 Mar 2022 02:33:23 +0000
Message-Id: <20220308023325.31702-1-linmq006@gmail.com>
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

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

Fixes: afb93d716533 ("ASoC: SOF: imx: Add i.MX8M HW support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/sof/imx/imx8m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 788e77bcb603..60251486b24b 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -224,6 +224,7 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
 	}
 
 	ret = of_address_to_resource(res_node, 0, &res);
+	of_node_put(res_node);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get reserved region address\n");
 		goto exit_pdev_unregister;
-- 
2.17.1

