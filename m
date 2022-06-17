Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC054F678
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382319AbiFQLL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381289AbiFQLL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:11:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E9F6CA88
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:11:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so3867697pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQLjYSyO5bnT1k2cMo+qtFEL9roIKTpXUxzFJ5E7YeU=;
        b=WEXQJ2c0zXPPo70AqX4ePE2lo2jfTA7rpG+C5RBXENB1K0P1BBjGTUBKWrVNIRgYMx
         HldHvQtAl/hTE2t7F2GKPeB/yiddMus1F8uOtTiwN9+rR9c0CSzHVt8S5NTgrhhhnsSe
         xRiJJZNKdeC7o73Bc1I3uTPEccX3CTIDbP26E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQLjYSyO5bnT1k2cMo+qtFEL9roIKTpXUxzFJ5E7YeU=;
        b=PSn+Ux7E3xV7Kn5b3l8mrmPYfthZrVWLWalPkbJ+wWsAQ+7xkycafIjXiEzedFanv9
         90uTZP8hBz8xcz039B0friRLtItAhYazEvn4e62IpKkIXK/mR0YlHNCkGU62NNCMecNe
         oDY/wERO/N8dwST8TCioTv6re/xuxBgSrAsE31E3t1hi1vi9LdcfzN747cM4axHpal67
         i10rAcb0G8cmU0woRGaxG76D11Quw3BQ+UDiYm2dAhhzD1v7XTzPe2C9HI7/6LnaIKS0
         7xZyIzsZPsjkoIIfRv+F+gfjSyv4v/Gq9jGMMHkTBWE2t3IljTPmdg0JyURdBPx7fKw2
         J4lg==
X-Gm-Message-State: AJIora+QcH3OCgsHYTxLSEu9hMDvNoV7zTCM2/ojvn99oUZT/JNbk+Mv
        IF3qF4XC5IkiToVeIrB0lv/leQ==
X-Google-Smtp-Source: AGRyM1tf2bQGeUv5328p9BV+crG8b7G31H6qrJWwNOzsEDjIHBFrwQCM7E2x9VN5sMfX6/KCSapUnw==
X-Received: by 2002:a17:903:32c4:b0:167:6e6f:204b with SMTP id i4-20020a17090332c400b001676e6f204bmr9221820plr.117.1655464315709;
        Fri, 17 Jun 2022 04:11:55 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:e616:b34a:9b5b:24ef])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c20900b00163f7935772sm3296754pll.46.2022.06.17.04.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:11:55 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Fei Shao <fshao@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] ASoC: mediatek: mt8186: Fix mutex double unlock in GPIO request
Date:   Fri, 17 Jun 2022 19:10:04 +0800
Message-Id: <20220617111003.2014395-1-fshao@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep mechanism revealed an unbalanced unlocking on MT8186:

  [    2.993966] WARNING: bad unlock balance detected!
  [    2.993978] -------------------------------------
  [    2.993983] kworker/u16:1/10 is trying to release lock (gpio_request_mutex) at:
  [    2.993994] [<ffffffdcd9adebf8>] mt8186_afe_gpio_request+0xf8/0x210
  [    2.994012] but there are no more locks to release!

The cause is that the mutex will be double unlocked if dai is unknown
during GPIO selection, and this patch fixes it.

Fixes: cfa9a966f12a ("ASoC: mediatek: mt8186: support gpio control in platform driver")

Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
- Trimmed the commit message

 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
index 255ffba637d3..274c0c8ec2f2 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
@@ -230,7 +230,6 @@ int mt8186_afe_gpio_request(struct device *dev, bool enable,
 		sel = enable ? MT8186_AFE_GPIO_PCM_ON : MT8186_AFE_GPIO_PCM_OFF;
 		break;
 	default:
-		mutex_unlock(&gpio_request_mutex);
 		dev_err(dev, "%s(), invalid dai %d\n", __func__, dai);
 		goto unlock;
 	}
-- 
2.36.1.476.g0c4daa206d-goog

