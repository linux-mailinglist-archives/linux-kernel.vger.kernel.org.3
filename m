Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E264C8169
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiCADES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCADEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:04:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0E36340
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:03:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so904832pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Ied1UTlwqdumSyFQ5GJiRBNsKqqAvuy3dy3lFXCbEHM=;
        b=cPRe/VY/fXxz4d+wzUsjqX+MuMmWLzIQZch8kPj5MiByAblJOcmrhnCWYPUPOVijuh
         h1lgQo21SyMQcmGnnsgtt7DvZ84cXfehFZf+nnsvaffmU6tVUbMbEo34vmQKnZjzmy4Y
         I7WiJtifBDtZSUz1yIBlB+85/N3nHi0PMU48bAsZBg4ZpMPLBfPXLL52PZJeCcDsuZWs
         NjtjOtd8/IjiVPf1LnaLfNvZlkKiyDAlhLq4LM0TwSq6+7QbGClNEPVKMyq26aCwTX7g
         pcL3rmvloXL0I1LmLxvhvxXmOIyA7OYcIrerNbm/+3W8H5TITfWgg0Wk6fxfzy2LVmo3
         hlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ied1UTlwqdumSyFQ5GJiRBNsKqqAvuy3dy3lFXCbEHM=;
        b=zY44m6X7ADoc960e8EZ21iCMbvP64CPfti5J7auMjx4cbAZmiHLrFUfAFbKo26XoKV
         w2Tvnn3qkOmkWW/edNnZ6VyeEv3pEjcPkFKpRmu+oCJ2C19G7S+zWHzr/nWdV8xAQo46
         1lJKq/UJSuw6y/PCPRgQOJRH3lEa5WncNns0oIlaI57T8rm2a/apkXr7iRYNtess/Hku
         TxQPM5OgPRLejI8MuD9DG8yWUhqNAPCEe40oSGf4ARaNGIL+NAzElsewSUK18gJvlgAF
         gdq5AESFc0RtreEgUigLgYv0hk5Aj8dtKHPAVbH6HgeKI8xyBVtV6XK3+77UcusGMlI/
         fNBA==
X-Gm-Message-State: AOAM5310Bdo+3iFAvz9bhqf08Gz+I2cy+PIV79lMAzTtOF2Ln0LJKB3k
        fjnp/eeu9kaNS89HrD9dATA=
X-Google-Smtp-Source: ABdhPJxOfz02CgHQFRf6Uuf4DvZywXM4YNQdW/qq3sZA69Q5ooNs/0W3K4OICWrSNsSRumeVrGZMbA==
X-Received: by 2002:a17:902:b202:b0:151:4f64:e516 with SMTP id t2-20020a170902b20200b001514f64e516mr13172147plr.16.1646103815064;
        Mon, 28 Feb 2022 19:03:35 -0800 (PST)
Received: from meizu.meizu.com ([137.59.103.163])
        by smtp.gmail.com with ESMTPSA id t38-20020a056a0013a600b004e1a0c14000sm15595983pfg.209.2022.02.28.19.03.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 19:03:34 -0800 (PST)
From:   Haowen Bai <baihaowen88@gmail.com>
To:     shengjiu.wang@gmail.com, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haowen Bai <baihaowen88@gmail.com>
Subject: [PATCH] ASoC: imx-pcm-rpmsg: Directly return 0 instead of using local ret variable
Date:   Tue,  1 Mar 2022 11:03:30 +0800
Message-Id: <1646103810-21724-1-git-send-email-baihaowen88@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes coccinelle warning:
sound/soc/fsl/imx-pcm-rpmsg.c:285:5-8: Unneeded variable: "ret". Return "0" on line 308

Signed-off-by: Haowen Bai <baihaowen88@gmail.com>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 3504904..afea28a 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -282,7 +282,6 @@ static int imx_rpmsg_pcm_close(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct rpmsg_info *info = dev_get_drvdata(component->dev);
 	struct rpmsg_msg *msg;
-	int ret = 0;
 
 	/* Flush work in workqueue to make TX_CLOSE is the last message */
 	flush_workqueue(info->rpmsg_wq);
@@ -305,7 +304,7 @@ static int imx_rpmsg_pcm_close(struct snd_soc_component *component,
 		dev_warn(rtd->dev, "Msg is dropped!, number is %d\n",
 			 info->msg_drop_count[substream->stream]);
 
-	return ret;
+	return 0;
 }
 
 static int imx_rpmsg_pcm_prepare(struct snd_soc_component *component,
-- 
2.7.4

