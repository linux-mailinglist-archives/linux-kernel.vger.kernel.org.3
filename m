Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA75AF1E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiIFRIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiIFRHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:07:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D37E30C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:55:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bq9so3475689wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xh82u4mQI0vpD+SPbAbOTF4IJW7gl/lNmljBUcHdhrA=;
        b=D7pYmEHChJjmVTgGNvwVE4nrUPAzpULO6H6J2wrcF2qicEK9hAIEv2F/j6EoHN4dG1
         GnzM2fJb4/+l5zVoTOx2L8eBQo0nW7UMUVD7swnirgwT6Ectk3v6tgU+VoUtXfUqHdsx
         t3dyMwLru0dgJd0odBSAGohl9Ms9tTlgK6plTZ3VNyw5ff1h3WoTy0qX4LHQPNKmm/jk
         EtWP1JQQkmmQ4RYMQvI7KgnsvovRK6kvYG8ZL7NvyE+t1yMCoTHQqBU3rMMhvoIUX4WY
         i7XBXglhSZRJacmrXx0s57hf2n7592QLRDBQAlDkDZoEjiEMJCY2Ju6mokiCDWPwS0aI
         MLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xh82u4mQI0vpD+SPbAbOTF4IJW7gl/lNmljBUcHdhrA=;
        b=PWjByJd9sz0dW4Y+ObtkfyDPN8dbBYR43KM/RvZBVfsVPwX66Ix4IDjY4iSOfvKLiS
         /QC44JkuvxRP78nTp0R4Y97OkCBYVbARj+YtJo+I8TRNIIEjbq3DTBpnrSmCeFErEL6Y
         7dp8htPzwopmYnS153wR++cfr2GzxZ7eeZiDXeby78NvPkQo30O8/wYvPFTCrSsST5+n
         ebgdAq8r0S0RsnDEXbaO2VWFDZeyKW94Yvat9oIWjUFbQliJmhh17cx2taxMKXXslhGF
         JqkVNTlEPDUkAPFsGZ9L3sxDTQanKLlnAUfIRnKY2KyodHW2enZYwqrX3Rwkf8Whoij9
         oLuA==
X-Gm-Message-State: ACgBeo33UHK0nui1YX+z71L7a89fwfbAqZtOK+0RIOrDOFH2fxu2cV5x
        v4wbMbpgNE4oUXItohtEna9uxw==
X-Google-Smtp-Source: AA6agR59fsFWPW6nj0dDTZpiQhOPQoIZref6IIVobJPKCfEvS29RNTgznn4tg7Itpc1FFfAGon2YFA==
X-Received: by 2002:a05:6000:168d:b0:226:da6a:6d78 with SMTP id y13-20020a056000168d00b00226da6a6d78mr23740860wrd.180.1662483315738;
        Tue, 06 Sep 2022 09:55:15 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id co4-20020a0560000a0400b0021eed2414c9sm13775906wrb.40.2022.09.06.09.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:55:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/4] ASoC: qcom: common: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
Date:   Tue,  6 Sep 2022 17:55:05 +0100
Message-Id: <20220906165508.30801-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220906165508.30801-1-srinivas.kandagatla@linaro.org>
References: <20220906165508.30801-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_snd_parse_of depends on ASoC EXPORT_SYMBOL_GPL functions,
so make qcom_snd_parse_of and EXPORT_SYMBOL_GPL.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index c407684ce1a2..e53ad84f8ff5 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -175,6 +175,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	of_node_put(np);
 	return ret;
 }
-EXPORT_SYMBOL(qcom_snd_parse_of);
+EXPORT_SYMBOL_GPL(qcom_snd_parse_of);
 
 MODULE_LICENSE("GPL v2");
-- 
2.21.0

