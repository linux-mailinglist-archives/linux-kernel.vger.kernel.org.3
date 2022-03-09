Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46314D30CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiCIOHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiCIOHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:07:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5D177D04
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:05:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i66so1424912wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 06:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9qAOoHj6pXfBEaK0pgqOpVtUmae2rVK+HUiENC7VtPo=;
        b=Cu9kv0KtKYA/7fzKJO1EF9fzAEDM9lsaVbE8iKKcXZV5FdHjCK+jvNM3uXzmTpcWNp
         fbtHPyUpra3lA3fKUEwkRS/yf/rh1d0DDdb5Ihb3Eil42NjYzll0/TwW9lq5gq7tfZ09
         xAq2EY7TJ4OxNBZBNJ0Hp3pnRGJ/yCt8tnPOg4ob5uxR0btb/mvsmPnTuRJyyF6GDNFO
         6Xstisheq/5Si/NcDKPx9PrULPWxyP016sRllXPfRbO6EYGIT2A3MHSscou/iq4tK/J0
         JkDwdwtV/CR7Lum5JO1AlI9b3E/GVZlbBtcAAUdZknV6JiQ5meUEU/pWx5bXtzxAiTx0
         JfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9qAOoHj6pXfBEaK0pgqOpVtUmae2rVK+HUiENC7VtPo=;
        b=65+Vpxqqz3TbfBPfD4Q6wH+twJ3lhFkrCywmmmi2rF3ve3LKfQhCDjTjLUwkO4DVNO
         VMZRPH+hzISfL8N5An/mY4GnH54zLixEcu0dtfGOvwbFMemcp6mlUqeb+dIO/UWxrFpa
         ASjAbmiJEltNEpaIsbgA5h2H2s0433uyPNtwuAssU5cSYd02HNLQEENL8PKbyC7YP4h3
         6N+aLJA91c8KcYB2BUBBvLmJrQk/1n/jkQpLK8AwtkftvnlD1uVO/S98n9lCuQkPdwTO
         7xAV1/3wiRpI1vLXtsHhL9fqhNdYuzMjv8t6o37nRMLt2L34X7zrBmZHD7L2C6rhziU1
         XQNg==
X-Gm-Message-State: AOAM533vkJ3ZJUcQ9SXfYRow8FDmFTEnsdS74LxVxdeTmMS5TxZSRhAu
        F9Hc77JsXWLPuGU29kxqIjWfdDqyeRlS5g==
X-Google-Smtp-Source: ABdhPJwyja8v3kq5xhmLrPkjUFLztuqnNmIl49Kx2XGkHxoP4LVB3mxhXu2PCUrUTfjrW7ByM8NClw==
X-Received: by 2002:a05:600c:589:b0:389:a59e:a53d with SMTP id o9-20020a05600c058900b00389a59ea53dmr7564018wmd.28.1646834755745;
        Wed, 09 Mar 2022 06:05:55 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a10-20020a7bc1ca000000b00389bc87db45sm1821323wmj.7.2022.03.09.06.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 06:05:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] ASoC: qcom: fix Kconfig for SC7280
Date:   Wed,  9 Mar 2022 14:05:52 +0000
Message-Id: <20220309140552.8065-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select would force the symbol to value without checking the dependencies.
In this case selecting TX and RX MACROs directly without checking its
dependency on COMMON_CLK would break builds on platform which do no
set COMMON_CLK.
ex:
WARNING: unmet direct dependencies detected for SND_SOC_LPASS_RX_MACRO
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMMON_CLK [=n]
  Selected by [m]:
  - SND_SOC_SC7280 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] &&
	 SND_SOC_QCOM [=m] && I2C [=y] && SOUNDWIRE [=m]

move select to imply which should enforce symbol to be set to 'n' if any
dependencies are not resolved.

Fixes: 57350bd41c3a ("ASoC: qcom: SC7280: Add machine driver")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- rebased on sound-next

 sound/soc/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 82f5eafb2f6c..28d0dfb4033c 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -195,8 +195,8 @@ config SND_SOC_SC7280
 	select SND_SOC_MAX98357A
 	select SND_SOC_WCD938X_SDW
 	select SND_SOC_LPASS_MACRO_COMMON
-	select SND_SOC_LPASS_RX_MACRO
-	select SND_SOC_LPASS_TX_MACRO
+	imply SND_SOC_LPASS_RX_MACRO
+	imply SND_SOC_LPASS_TX_MACRO
 	help
 	  Add support for audio on Qualcomm Technologies Inc.
 	  SC7280 SoC-based systems.
-- 
2.21.0

