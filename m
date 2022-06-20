Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA3C55259F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbiFTULe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344282AbiFTUJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:09:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537DF21E16;
        Mon, 20 Jun 2022 13:07:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o8so16104302wro.3;
        Mon, 20 Jun 2022 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFP2epvfooKrZpPFT8BKKDNI28ulsq6H0dBYSPgFoyk=;
        b=AjebCnrCn0roYHEXtZUSrMTMzWgreVkEMmGmWHB4aW5MqCKA4G4WAtMmLhSH/wSD9O
         hErB+wW/nmuyZcj6VsVAhDUiCzXy1A0InOSiMOhVg1zOo944NV//bnCbQ2Nfq/Wvm/4X
         gHuja0BV7C29XQ21FTvJ66Q4m2HHGHfjAfbDNfzOus4oL46kEV7W/Ut/DNWQxw6A0wN3
         MaclksZzjz+wgvfYM3RiCRmGkMi+n+Veo8oqESntYKECZMRtvsRVSUdWqg/UzoMptmRp
         DOSCYB+7UcRMW3szUyAX5e47sGuNfYYpbyhUPLebUPzr6yz1Frjd0ZNrD8flYUO0+4T7
         n+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFP2epvfooKrZpPFT8BKKDNI28ulsq6H0dBYSPgFoyk=;
        b=m2PZwAKxSBFM29cdZs60Qvi1i/8UCO/KbK7InycUNlGZtaiD17J9ovFjPWph5VAF6Q
         blWNzyx1nWQpTl0LsKsQE0xcG4ioZHg67VfIVu6YzYDAR6mqKYp6Phi9c/b2nOPn/zhx
         QEt7m6pBAB3eLsDSNI8UWWNbrKY2zqZwnLn4QBl2G9zq2UcGcazBk89+y594Ax+EzEfn
         vj3/1j3wxAIbO6si80Rj6g180SzFyrHd2CuV8R3VW0NU8Hts7VhqBySe1cYvJ3o3jsjs
         rcP7g48NVPAJjTNwXoQ6de0cZyWE7fWL9Imal1u+N85WIx970TkJ0YDU1Y2Au3aAPoQx
         B7Qg==
X-Gm-Message-State: AJIora/62Qns/+mRDfFxNahq3W0E/MMMhNvMLTxm8trSibQzG0ALov3y
        wP+2qmbRW88yMZ+w9820p7k=
X-Google-Smtp-Source: AGRyM1tPhWdLWdfyykUlpNJ3PSEDMPtwatE94NYU/Ih24mSrC9Dy3BbzCPtCbJhpEUzIutMTZqJdog==
X-Received: by 2002:a05:6000:10d0:b0:21b:8ffb:80ad with SMTP id b16-20020a05600010d000b0021b8ffb80admr6433209wrx.444.1655755644354;
        Mon, 20 Jun 2022 13:07:24 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id o20-20020a1c7514000000b0039c4ec6fdacsm15898561wmc.40.2022.06.20.13.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:23 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: [PATCH 43/49] mfd: qcom-pm8008: Enable mask_writeonly flag for irq chip
Date:   Mon, 20 Jun 2022 21:06:38 +0100
Message-Id: <20220620200644.1961936-44-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8008 has separate set and clear registers for controlling
its interrupt masks. These are likely volatile registers which
read as 0, and writing a '1' bit sets or clears the corresponding
bit in the mask register.

The PM8008's regmap config doesn't enable a cache, so all register
access is already volatile. Adding the mask_writeonly flag should
reduce bus traffic by avoiding a read-modify-write on the mask
set/clear registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/qcom-pm8008.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 7bc6becfe7f4..c778f2f87a17 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -141,6 +141,7 @@ static struct regmap_irq_chip pm8008_irq_chip = {
 	.status_base		= PM8008_STATUS_BASE,
 	.mask_base		= PM8008_MASK_BASE,
 	.unmask_base		= PM8008_UNMASK_BASE,
+	.mask_writeonly		= true,
 	.ack_base		= PM8008_ACK_BASE,
 	.config_base		= pm8008_config_regs,
 	.num_config_bases	= ARRAY_SIZE(pm8008_config_regs),
-- 
2.35.1

