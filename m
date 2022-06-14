Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5D54B8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbiFNSiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFNSiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:38:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B6340F5;
        Tue, 14 Jun 2022 11:38:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q15so12370908wrc.11;
        Tue, 14 Jun 2022 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsJ5u2umY9+S+mCev0i/Sc2pgxCFrn1uJHhSVkU6Img=;
        b=nrg+QsCKmHI0Bt8jlxnugL6kmmj7Q2M/0Oqzm6eeYPqd6Xq/8Eno1RgjevR4EWVzTq
         kLeQcpw1i7J8QXjOlwrrPSVJHubL920hzCbb1L8Ijo5UZtcIDk4OL5VLpQsxnuDFHM9I
         wxx69E18GZJPZpPBOUwOLmBMevbA4DSUJE2BESoR0bp2s109g8RRLpOWqS+zOOYoUeEZ
         GHy0K39iuSb5G0dYXcQvLJhJQ0G6FJwXZDyvx0kyhac4OudcP0Se19obqIQ2jr8KgyUG
         cYakpuFk5ncN8Jp5a0WTegYE3ZrICStS+X6ZxdWtn6IWcrYPGEE9oBspB3Le0l/1ymC+
         Lptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsJ5u2umY9+S+mCev0i/Sc2pgxCFrn1uJHhSVkU6Img=;
        b=x7sKL11ugHFPDDbgz2duISxMfOVjIT9bRbZ2/o4bd3J+v2JSI7zbnA213PoxLiIqCd
         1s6EqaDMdMtQGG5ZAufgU6SpUCbQqCAEhz7nLebd4mt4Wh35OpzWofW8iMY8a/6wJFYI
         UXmLSJ6OhMPaEmyhWd3deQ4ERWsiyiANkIljkOzwVVA2DdA6Na1kEs8txbQFTXFq42JJ
         C9kk9Mwgv+JFSOPQa8+0MJvxgU2gJqV9jXXYCSeIaunDOktoWc5PiauFvQDZ0dq2/b2W
         ntzvEFYzIvXXIpYQ8wK2i0prqLHK+IYGiyPrDUl6XtZmVAPYbGMdlX3sCO5cjJayUIsj
         gzrw==
X-Gm-Message-State: AJIora8Dn9Q+L3geECpV4IYSUMvwyNolqgkA016FwNahjiMjQhz0ClLL
        7gvuIeBYpC9ozyNQ/q/GQESaLKOy70RZIu7W
X-Google-Smtp-Source: AGRyM1uAsMJfnYLUOIdK4OUtkl30vxeZBgEqqzIgFwWK3F8AHsx9AfxTYTNGfrwUzmhPuq6IWdl1sg==
X-Received: by 2002:a05:6000:1f8b:b0:219:bee5:6b77 with SMTP id bw11-20020a0560001f8b00b00219bee56b77mr6103544wrb.658.1655231891386;
        Tue, 14 Jun 2022 11:38:11 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a4-20020adff7c4000000b0021033caa332sm12928303wrq.42.2022.06.14.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:38:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Skylake: remove redundant re-assignments to pointer array
Date:   Tue, 14 Jun 2022 19:38:09 +0100
Message-Id: <20220614183809.163531-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two occurrences where the pointer array is being assigned a value
that is never read, the pointer gets updated in the next iteration of a
loop. These assignments are redundant and can be removed.

Cleans up clang scan-build warnings:
sound/soc/intel/skylake/skl-topology.c:2953:3: warning: Value stored to
'array' is never read [deadcode.DeadStores]
sound/soc/intel/skylake/skl-topology.c:3602:3: warning: Value stored to
'array' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/intel/skylake/skl-topology.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 9bdf020a2b64..e06eac592da1 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2950,9 +2950,6 @@ static int skl_tplg_get_pvt_data(struct snd_soc_tplg_dapm_widget *tplg_w,
 		block_size = ret;
 		off += array->size;
 
-		array = (struct snd_soc_tplg_vendor_array *)
-			(tplg_w->priv.data + off);
-
 		data = (tplg_w->priv.data + off);
 
 		if (block_type == SKL_TYPE_TUPLE) {
@@ -3599,9 +3596,6 @@ static int skl_tplg_get_manifest_data(struct snd_soc_tplg_manifest *manifest,
 		block_size = ret;
 		off += array->size;
 
-		array = (struct snd_soc_tplg_vendor_array *)
-			(manifest->priv.data + off);
-
 		data = (manifest->priv.data + off);
 
 		if (block_type == SKL_TYPE_TUPLE) {
-- 
2.35.3

