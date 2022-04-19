Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DCA506D55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348298AbiDSNVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbiDSNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:21:51 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80391344FC;
        Tue, 19 Apr 2022 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650374349; x=1681910349;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=FEwok1lzjt/HO93wIkHzSCWrGpT3TbisaBs2ZCCYLc0=;
  b=x67D8AFHMemndeCBOdJuHzopTptr1WH+fOyvUfBDiIGp946j27+aQ6x5
   IPlny3LTJoGREEhCXlz8IsxAeeH3pYeh9TAc1wIC9fs5m1GuZu8r19TaY
   IaqXitwyP5AZ3Zc92X45pvAk9ZSTXjz82Vsd4vck9Hrrhy5HEfHBmyL1z
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 Apr 2022 06:19:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 06:19:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 06:19:07 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 06:19:01 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v2] ASoC: qcom: SC7280: Update machine driver startup, shutdown callbacks
Date:   Tue, 19 Apr 2022 18:48:49 +0530
Message-ID: <1650374329-7279-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update machine driver startup, shutdown callback functions to avoid
sound card registration failure on other platforms.
Without this change, platforms with WCD codec is failing to register
sound card.

Fixes: c5198db82d4c ("ASoC: qcom: Add driver support for ALC5682I-VS")

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
Changes Since V1:
   -- Update swith case in startup, shutdown callbacks for handling all dai id's
   -- Update commit message and add Fixes tag

 sound/soc/qcom/sc7280.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index 4ef4034..834c081 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -291,13 +291,7 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 					       SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		break;
-	case MI2S_SECONDARY:
-		break;
-	case LPASS_DP_RX:
-		break;
 	default:
-		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
-			cpu_dai->id);
 		break;
 	}
 }
@@ -312,14 +306,8 @@ static int sc7280_snd_startup(struct snd_pcm_substream *substream)
 	case MI2S_PRIMARY:
 		ret = sc7280_rt5682_init(rtd);
 		break;
-	case MI2S_SECONDARY:
-		break;
-	case LPASS_DP_RX:
-		break;
 	default:
-		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
-			cpu_dai->id);
-		return -EINVAL;
+		break;
 	}
 	return ret;
 }
-- 
2.7.4

