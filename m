Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5285AB5ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiIBP4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbiIBPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:55:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A54118361
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:49:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so2891377wri.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NdB5Eag8SJU/73u2oaBSVfu1iUfNn2HCQO16zSHjpzg=;
        b=eXC39A+yiomTisTXC9s7xJThOie1Rft8B27qPaJIvhls1vFK5hOAMgCTp6PU3Qu74N
         KA9zU7b2/Wobt9Kjot5Y9FHUZkNL0rmtPniMGzXfnauNfXOYQObc4E+IOr8WO80o/mMq
         NbXc6QBzAeUZcGFzxNOSbKTKemEFGUuhftPaui01HiSKz4PqYNBdLKHWpwU9fI9/NocA
         T+2x4w2vLQRadmKUh1xg3yoQukVK5xYWwc5aaHXuFMG8Sar3ASMK2EWrrzBRcVM7Q5nM
         2MeNFIztD7m8ELBS6+Ecs2I5e23pOxQ+3dkN2G+Y4209E/jt24WRvOUkVctOdjfQFB7F
         EoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NdB5Eag8SJU/73u2oaBSVfu1iUfNn2HCQO16zSHjpzg=;
        b=XqgzoftGorDll9JfAQQhkqg7vA3DE0EC+KtxESBxRQzOq7Byn/gBJwFwdSr3TezecQ
         MCaiRtE+KperrhSuEuLQEj4aT96veDzE58Vj8x2X0A0e5EUYryBCUp0wH/eDxHgJ/Fuz
         9Eze6bfnc+svG9+QWtQ5/x3PybVnSB7lGJGJ2rn9vKrethwDhFXsoyt/VeD9llUHRF9J
         PJqcAwEAt03diT571ilSCy2JPvlNYNGmsTwyzrOndoUswIK52UXV1/XNNqqGbyI3nLyh
         B8j1tmKnRr9+oG76yEKztVKiBBOwgz5A6JxcIoyHN6CpcSrleL6nLmRXIXJ+kggB/pwZ
         k09Q==
X-Gm-Message-State: ACgBeo0hG3eUEC1vjzfvlgrbvqt6NuBMfmLfNsaIHgvOEyUQlQDOo+iL
        /gQ339AJ+gNBX3+fA98ZyE0y3g==
X-Google-Smtp-Source: AA6agR4skcEyurrXWHxYzdpRjPzwxE5s2Huk6n1q5S6bzfvsnDzROMvnA2Mc+qKg123h13IkISOxhQ==
X-Received: by 2002:a5d:588a:0:b0:228:462f:a49 with SMTP id n10-20020a5d588a000000b00228462f0a49mr1970077wrf.616.1662133762010;
        Fri, 02 Sep 2022 08:49:22 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600010c100b002250f9abdefsm2046741wrx.117.2022.09.02.08.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:49:21 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 01/10] misc: fastrpc: Rename audio protection domain to root
Date:   Fri,  2 Sep 2022 18:48:51 +0300
Message-Id: <20220902154900.3404524-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902154900.3404524-1-abel.vesa@linaro.org>
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
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

The AUDIO_PD will be done via static pd, so the proper name here is
actually ROOT_PD.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 58654d394d17..8d803ee33904 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -83,7 +83,7 @@
 #define FASTRPC_RMID_INIT_MEM_UNMAP    11
 
 /* Protection Domain(PD) ids */
-#define AUDIO_PD	(0) /* also GUEST_OS PD? */
+#define ROOT_PD		(0) /* also GUEST_OS PD? */
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
@@ -1889,7 +1889,7 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 		err = fastrpc_invoke(fl, argp);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH:
-		err = fastrpc_init_attach(fl, AUDIO_PD);
+		err = fastrpc_init_attach(fl, ROOT_PD);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
 		err = fastrpc_init_attach(fl, SENSORS_PD);
-- 
2.34.1

