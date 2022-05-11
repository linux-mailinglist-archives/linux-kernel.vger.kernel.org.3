Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D648523467
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbiEKNh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbiEKNhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:37:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2503766C82
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:37:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id a191so1832266pge.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZddwKY35pUrh6R5AAj9OCEj0zF8sOKGHECLF2uLCy64=;
        b=jvnIeRP3G/HbVmLPD7w6dkgxT0piYIz88WFV06yyQu91PXBZ2cPblZHFShL3Kk7iJg
         SylzzqYDiMsmjkqyRYPPIMdPBTxPdba7UNRLnZb+aJD3siim0k+8zAK9bOcohRQ4fBnx
         C8/xCp0aqJpv2AiKulUVIAkeKPBFdYNmbOF4iI2ZN4GcGZHpbI6HqCqy9VQUWP5HGSuH
         S9Np3y3ao934wf7u5wpJIulciBzXm9tQDBDP8MX9lNrBy0cxldKW5lIXvmmMBsAPJe3T
         dUbZMZBqzCGCEAaGIdVcUu/l+xmzKkmYoOSJXh5Pk1V+frCY+JqgiDIQJCVJxC99LKl8
         u85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZddwKY35pUrh6R5AAj9OCEj0zF8sOKGHECLF2uLCy64=;
        b=CcADzU94zMlFBGhQaz6eUDk1EXuN2ARlEIhKwaPAErwNVSwet7WwFszPPdzttfIK1r
         Q+wsrhrOv6F70E8By2jvahDExxSM+v5CKHB2Rsds+Zu0oxSmjMfofP83zHw5UuNIjRIu
         Bnco5r27qcBMGDFjJ8ABQWycRItAzmFgFAMcYJaSrV8KFZnk2jV8Vc2rlbv9y+2I24gk
         a33a6//kRGr2WdhdjwJhKJHaeUapLlN1EkKge2eyZZTZYvlDexU0SebbimO7TlaCj7ka
         K8YeLN6GGDPbirDkwihfxyhXKyINPk6VfY1kU1qmS5eIercLST9zFmJObU8aZ2irgVvM
         bvzw==
X-Gm-Message-State: AOAM530Plq4DDvcJV+ZnLFusL0WnVm87yyGX1o7qU4wK732vqU1knvmE
        0Qqb1+RhLZDBGzGZj2MhE/Y=
X-Google-Smtp-Source: ABdhPJxL4qPnoibT3RMP2XXaUwIm8HlwdKX4ysIXOXXWBN6ZnU+aVvmJ/CK4tHzv9bgNCDSgwTbrvg==
X-Received: by 2002:aa7:83d0:0:b0:50c:eb2b:8e8a with SMTP id j16-20020aa783d0000000b0050ceb2b8e8amr25314048pfn.31.1652276260106;
        Wed, 11 May 2022 06:37:40 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id o16-20020a170902d4d000b0015e8d4eb299sm1971367plg.227.2022.05.11.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:37:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mxs-saif: Fix refcount leak in mxs_saif_probe
Date:   Wed, 11 May 2022 17:37:22 +0400
Message-Id: <20220511133725.39039-1-linmq006@gmail.com>
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
incremented, we should use of_node_put() on it when done.

Fixes: 08641c7c74dd ("ASoC: mxs: add device tree support for mxs-saif")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/mxs/mxs-saif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 879c1221a809..7afe1a1acc56 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -754,6 +754,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		saif->master_id = saif->id;
 	} else {
 		ret = of_alias_get_id(master, "saif");
+		of_node_put(master);
 		if (ret < 0)
 			return ret;
 		else
-- 
2.25.1

