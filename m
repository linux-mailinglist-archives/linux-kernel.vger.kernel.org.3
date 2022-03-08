Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4CE4D145E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbiCHKL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345703AbiCHKLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B542A11
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:10:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso1952315pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCEYLzINbSJ27Mxc1gQH0RSj42l80KVWvId+vHnO050=;
        b=VFlI3NcvOJtijZK9dnSyiiARFam7LJ8qmOTLKNc6BwqUaKaUlKU4+8f3icJASzdiix
         OthB+gk44a6lieASchFK+lLJcJ+pUaxnkcomxmj4/ef/plXlIWS42RAYtXU1/9+aRBkL
         h4lX3waAzusF3Hgh0IGsk99Q5//h4ggK0BCFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCEYLzINbSJ27Mxc1gQH0RSj42l80KVWvId+vHnO050=;
        b=I4kt9E3V6dY3lQKf2q/2iXxinQWgqbUIlYHok0rA85ywnrGB+dZpAMBSj4E0TKQw2B
         NhZC9L+qYxI1MHZZrKPvnMtPSJEtCB0mSJxjItyPCd1CrKN/IEawBEtisk4fFO0nmw19
         YP2OGf3Uxlz3c8gJ5v1uNlzGZu18lvrfGrDMUgOOM9MVooQ+9JB/3YRuBfi0QGEjgQls
         mn4NJ/hORiVOJPnhLqpD8MeAO+llMtYDYXxG5HI0MoGRsqF7V7Ysu5/lB9wGG9J0T6eL
         1oOP/Sma3aGRyLiGzJ0unIij52YJnvmFXKpz1IJ4Izao35/NmcITnI62536W6+zR9vNh
         QkOg==
X-Gm-Message-State: AOAM531uLhU0EzGX8UNf6OKCI/lVdyF7hNbcnOosDphDCQQlO9zd5zq6
        G2xF2nuLB6ZyLucKW4QqxswFig==
X-Google-Smtp-Source: ABdhPJxvlMwg053TxzUU1yh1e9ywYI4FTa148KhAT6lQrsDtI61chzmA/3TvSGQDlNZ1lmoCT8ZRig==
X-Received: by 2002:a17:902:ef4d:b0:14f:e82b:25fd with SMTP id e13-20020a170902ef4d00b0014fe82b25fdmr16531295plx.80.1646734216854;
        Tue, 08 Mar 2022 02:10:16 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:73f8:5e3f:6894:8f44])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm1707553pfu.106.2022.03.08.02.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:10:16 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 06/11] pinctrl: mediatek: paris: Skip custom extra pin config dump for virtual GPIOs
Date:   Tue,  8 Mar 2022 18:09:51 +0800
Message-Id: <20220308100956.2750295-7-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308100956.2750295-1-wenst@chromium.org>
References: <20220308100956.2750295-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual GPIOs do not have any hardware state associated with them. Any
attempt to read back hardware state for these pins result in error
codes.

Skip dumping extra pin config information for these virtual GPIOs.

Fixes: 184d8e13f9b1 ("pinctrl: mediatek: Add support for pin configuration dump via debugfs.")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 38a00a906daf..39487e0c2726 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -581,6 +581,9 @@ ssize_t mtk_pctrl_show_one_pin(struct mtk_pinctrl *hw,
 	if (gpio >= hw->soc->npins)
 		return -EINVAL;
 
+	if (mtk_is_virt_gpio(hw, gpio))
+		return -EINVAL;
+
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio];
 	pinmux = mtk_pctrl_get_pinmux(hw, gpio);
 	if (pinmux >= hw->soc->nfuncs)
-- 
2.35.1.616.g0bdcbb4464-goog

