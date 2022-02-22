Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4844C0166
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiBVSdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiBVSdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:33:01 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF83B65FB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so35073167wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gs0UQYeLXZEFiZSAa7cijQLwxToifauUEWbaq2HVPLo=;
        b=SG8yKfuDMo92Gj+ppDPWnH5Z/qVOKABWnTVjTMNpa5Blh2Lh7NmjPfENG/wwsBjGym
         gZQTS7fycdhAyz/lVF7KAqAjbpy8a/or4Dk3cQC7HAxo1Yzmj9oreNJtPBHiQkUxvVVD
         gOMKXgrFD+VD1YeWaBjA0x65zJlhaX4olAuUpJm9M4s8rnrPhFgaX43CjdyFYtX43SLo
         2B/FiQyuL8+6ALRpNVzEDqT1dM3rsOFDR1jzvPi0tYx2NIdAJnOnAODkHSu4bwWcInLW
         4jPwv+ULu9yNl/Tzl+dqpBDGLrS6p+/9hSaLT5U5hxtBEa71KZv4if7zn/87DjG7j5TB
         Cq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gs0UQYeLXZEFiZSAa7cijQLwxToifauUEWbaq2HVPLo=;
        b=3H6rzdC6yVFW23FLRD9Y80dYGacVMZFPEng3Hlx1Fi5cWaTCe+auUVOlHA4wmLfAJ1
         RWP+rqVX3z3PfCQif6Us/o6ewqWAAekAJkBh2Vajdl2Ij854uPKsmy56q+vXomujZApO
         axHxIqIRrFHpNyDnxrDoy5OUfzb6AFgIEzWw0OJ5bgoGmYLqF+w5P86PoXTBA/U0eal1
         kS3hMpEbnY2/hREjbPPYsbs3cfPX29CckagPZxaCZVyFaCZn4SfMyG4hwJCuoyExRVTV
         +XjLigU7WYgMiaHJfikdML4NM2wkRpHNWU+JJrDZbFWJ0FIHeRKrM02QeVtt+rD0n86q
         hh8g==
X-Gm-Message-State: AOAM530fCkbV9k/Bd/AgTOsVxIWIPwNSsyWtGkuZvHBTleCCPMC61FbB
        wC0Q9XUrG3jwRlPaZgt2tpu/9w==
X-Google-Smtp-Source: ABdhPJx9ufhte9u4mOwDexPtu1IQtPstNEvnTrTxaGq3xRUlczgS5HyGu7VLb7Ai7VgEWDiOd3HhMA==
X-Received: by 2002:a5d:45ca:0:b0:1ea:9bf9:ce5a with SMTP id b10-20020a5d45ca000000b001ea9bf9ce5amr2408659wrs.620.1645554753408;
        Tue, 22 Feb 2022 10:32:33 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:33 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 7/9] ASoC: codecs: wcd938x: fix kcontrol max values
Date:   Tue, 22 Feb 2022 18:32:10 +0000
Message-Id: <20220222183212.11580-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
References: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
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

set "HPH Type" Kcontrol max value of WCD_MBHC_HPH_STEREO instead of UINT_MAX.
set "HPHL/R Impedance" Kcontrols max value to INT_MAX instead of UINT_MAX as
max field is integer type.

Without this patch amixer for these controls will show -1 as max value to userspace.

Fixes: bcee7ed09b8e ("ASoC: codecs: wcd938x: add Multi Button Headset Control support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index deecc83eb592..782877db8c3c 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3577,14 +3577,14 @@ static int wcd938x_hph_impedance_get(struct snd_kcontrol *kcontrol,
 }
 
 static const struct snd_kcontrol_new hph_type_detect_controls[] = {
-	SOC_SINGLE_EXT("HPH Type", 0, 0, UINT_MAX, 0,
+	SOC_SINGLE_EXT("HPH Type", 0, 0, WCD_MBHC_HPH_STEREO, 0,
 		       wcd938x_get_hph_type, NULL),
 };
 
 static const struct snd_kcontrol_new impedance_detect_controls[] = {
-	SOC_SINGLE_EXT("HPHL Impedance", 0, 0, UINT_MAX, 0,
+	SOC_SINGLE_EXT("HPHL Impedance", 0, 0, INT_MAX, 0,
 		       wcd938x_hph_impedance_get, NULL),
-	SOC_SINGLE_EXT("HPHR Impedance", 0, 1, UINT_MAX, 0,
+	SOC_SINGLE_EXT("HPHR Impedance", 0, 1, INT_MAX, 0,
 		       wcd938x_hph_impedance_get, NULL),
 };
 
-- 
2.21.0

