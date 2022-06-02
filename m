Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1753B7FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiFBLpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiFBLpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:45:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B6244081
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:45:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p8so4543663pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+d98QRju/iof/J3fqnwUoOBnWzIJ1MsMResY4ThMXQw=;
        b=BbGlo5bKFJ98FdM1OaSDYxQb5y8x7/n6+RNxsoobAWzJkuaAPlQoberr4i7ui0ZeWo
         m7mkIIC9PpknwkzVMuoVmmENO61cORNGJDsGXb99v+62IAkAbgJ9jpYYMemMdIrAvv98
         bqZTqBaYFYt+awEnpfswZXqwXZJsRAMTXoEPeKkBtOOr19C9AgZKkTZCXbgYvYpnbxi8
         eUfdf6Pb1ZiDwnzDOumHbZRtmQU/TkYa3xLRbIMKapFCTdFj0oLc/l3C5STXB8/E6/xB
         ojmj3dvE7WfO1EBWXpJ/8og1Ufuze3Zfahry58UBmL498SwhuRHvsklLkrQumYY01LwV
         fPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+d98QRju/iof/J3fqnwUoOBnWzIJ1MsMResY4ThMXQw=;
        b=Mt2SU5weqRpMTNWJbkqf9E/vFcnnK+7utqN95bgZbN2BpM+npc9whaaTJ6McH+40IT
         pn+ynbyyp9zYfCqTukmdZ9Js1XLMYVhowm7KqVX8TEJvO+F37iAo9+b+WpYvSt3iXG7q
         VTUrO00JN5pLJL1d1/eWS20JdLKTQ4isTAX3LWU+rduOZbyC9zQt0u+tl982wn52h4vG
         b5f8trLz+/9fy54S1y0FyE9l3uhqzP8774el30fB57jyPK2y/MProa51VvTm3n3VCX7u
         ovdfnrSR9qCdqGPH2kH9oC1DuaM1ggvvKyiPeSinEfvbb9+1jVBnrigL5cjiy9PU/hwv
         BqMw==
X-Gm-Message-State: AOAM532BE+4tyQRUKyWAWvJcY+zO1K+NDeQPthAoiRPrlIlI+TxFoVbD
        fksjjfbr8JDeVxkf8oB50EQ=
X-Google-Smtp-Source: ABdhPJyLq+i7vaKBUknNiqsbWkl+78YNSRhu19ou3RjHDXCtiMckU2vPaHBuflOii75VX75Ob3CuXw==
X-Received: by 2002:a63:ef41:0:b0:3fb:c201:797d with SMTP id c1-20020a63ef41000000b003fbc201797dmr4090679pgk.104.1654170339825;
        Thu, 02 Jun 2022 04:45:39 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s17-20020a170902c65100b0015ee60ef65bsm3221335pls.260.2022.06.02.04.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 04:45:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_probe
Date:   Thu,  2 Jun 2022 15:45:29 +0400
Message-Id: <20220602114529.6303-1-linmq006@gmail.com>
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: format:b6bc07d4360d ("ASoC: cros_ec_codec: support WoV")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/codecs/cros_ec_codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 8b0a9c788a26..11e7b3f6d410 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -995,6 +995,7 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
 			dev_dbg(dev, "ap_shm_phys_addr=%#llx len=%#x\n",
 				priv->ap_shm_phys_addr, priv->ap_shm_len);
 		}
+		of_node_put(node);
 	}
 #endif
 
-- 
2.25.1

