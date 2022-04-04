Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B74F11DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353596AbiDDJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiDDJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:21:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76372CE07
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:19:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u14so4372686pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=qelAC5YBe1yCBESGwxgX8ahq4gTeEnW6KQzbNy86Lmw=;
        b=QhY3lkav8Do3muF1gDCrngcr8qjDJsUGqV5+jSiL9RnhGvCVCVxHc4U3HJUMCUawiK
         SExYUSdLGARgxQYmRuVi5P/UoCLVmwB+rjMb0/3/t3ksuVTO9moUrXWdJhfIQKvLvtxO
         0w7swdR+B5zpWIuCZacVt4q5IDtHcT1RABQdWnjGG6N+e5NpVUk+dlIK79B3DelTcFBp
         dcNA0Eb65hlCwcV7XVxghU8v5DcylXg55svAKLR9ttpTDaF6Grf7VxVb7vKyymcLymEx
         ik0ZHvKLojiskAxAw1bDToCjpHgCbzKC/A94J6nlKbWqSZwhgMd8qxi6BbH34W9HxmcA
         wHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qelAC5YBe1yCBESGwxgX8ahq4gTeEnW6KQzbNy86Lmw=;
        b=w+4v3fJL+a4A+HVPbr6Dq9Gb7eHvVvZ9DnieCVYLlQ5ae3Jr4t8F5yRqglLM94AmGZ
         00kkfJBGfxKEVsMVUzUv9XU6F2GbH4Gmfp5svdmLQ51xYrbA7AlK/Y6zAcLsQRlCcG4e
         7KT1v2db4gtF1zULUPB4ejQUcBxaBEBCITm9bHHqZrA3n6pHVu0QBOLqCUpBDSSpAobI
         +7Btd3Vazg+PDgYTJJLQen8nz/DvTdELgtYiXe2kIlwTRBpqiHD7vr/SaqVZeBHRXSfm
         nJQBEIIC5kMzLgFekSItXmrIuj1kpaj2a1WznmjRPBia/RcA8b7K+QzMA+ChgvLuwLnj
         /ytg==
X-Gm-Message-State: AOAM532SKXPAe7KbUy9vpRVnwSKQNQOoS8A1VA8LHUKoxCdlmh9ZR6Qs
        Ftt08wJ6cnL+teFQ6Nlp52U=
X-Google-Smtp-Source: ABdhPJy408c3fmOLzgDMpCG5li8dOVT+a7bUMRN+8w6SDFrtFTqFr0YJgL7iSUdPJQYwwQrK67gANg==
X-Received: by 2002:a17:902:bcc6:b0:153:53c2:7e2c with SMTP id o6-20020a170902bcc600b0015353c27e2cmr22483820pls.14.1649063972253;
        Mon, 04 Apr 2022 02:19:32 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id n52-20020a056a000d7400b004fad9132d73sm11135143pfv.129.2022.04.04.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:19:31 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ALSA: pxa2xx: Add missing of_node_put() in pxa_ssp_probe
Date:   Mon,  4 Apr 2022 09:19:26 +0000
Message-Id: <20220404091926.22115-1-linmq006@gmail.com>
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

This node pointer is returned by of_parse_phandle() with refcount
incremented in this function. Calling of_node_put() to avoid
the refcount leak.

Fixes: 2023c90c3a2c ("ASoC: pxa: pxa-ssp: add DT bindings")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 7f13a35e9cc1..167b90b48d7f 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -770,6 +770,7 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 		}
 
 		priv->ssp = pxa_ssp_request_of(ssp_handle, "SoC audio");
+		of_node_put(ssp_handle);
 		if (priv->ssp == NULL) {
 			ret = -ENODEV;
 			goto err_priv;
-- 
2.17.1

