Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A482F552524
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbiFTUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245705AbiFTUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F71EC56;
        Mon, 20 Jun 2022 13:06:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n1so15842863wrg.12;
        Mon, 20 Jun 2022 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYKul7O4rkuRHadVgAD9GkF5EF0/tHVMEgyPNxDHsC8=;
        b=gfHGkEQotdDXzonMB5rbM3c8h6BVBrRvbtHhDjj8TB7PUfzKOirNkdHY6GRUcU3QOh
         pN3K3EMybUVH+S6paaWqW87mojZHxKV/KVv6mbG0MfLyFrJiMUS8aEEqAvLcWCbt6l/P
         Hzm7Ul+OYaXZyv/zNw15FgCOHKUCC7ntnW4BdzAX7j1i0rwhvAYiIhbdm+UfaPQ12HgW
         /Ba3wUF9pXtUbhcj50Zvj7lQx6eqKf5c0AarPVaEOvSYvWp73IjYJvOHQOtJ9XQF3QAI
         uc7N5zEeDGCklg2w1zbzB14CeQdszSSXX0bBBbgpTOXk4/oeMs384ZrqD+jYJS8NiWaQ
         MGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYKul7O4rkuRHadVgAD9GkF5EF0/tHVMEgyPNxDHsC8=;
        b=p7B2b9nZT2ovvpxnqZcgamRzBptiyk6u2YH1/Jby8J6YVCLE/SJ6JoYkmGuKxskJEV
         MSVaB5Eqx4nFGVRf8/Ov6Ml+DOZmAng6576zkBUicixtuco5DWrikcvVIjeEcR6NWZ5E
         HRK5Pbpn+OOahzHXPq6QqQxjk+/qmf352gaskfnBjElIaXwo4Cu5D02wdzeKBaktKs5y
         91G+MOeUYhLP8kB+Lvc26GmPR4a4bJPKZkW1RqxokH130w0CaXzyAQsgrJbgnBmy7aE5
         DUEPBbZbPY8LicD0cm/IAD1WmDjjtluHGRSE8yyrRuPVwLwN5GJMvQF7L79XUi38EpN2
         W9uA==
X-Gm-Message-State: AJIora+wxQ+bXqN7rANt8F2I/M/0r5oV9lwymMQ9LpXbfLV+whjlc66W
        W93J2qUpILjx8kaQx1bCttAZBrcnnDk=
X-Google-Smtp-Source: AGRyM1syc7S1LTS1FFXH6QNulnGOQO1vhdeYnisKeurGdpZwcIyfiJ171d1MMzBPPFFYg3HyKCPoOw==
X-Received: by 2002:a5d:410a:0:b0:21b:9549:e151 with SMTP id l10-20020a5d410a000000b0021b9549e151mr2036808wrp.702.1655755598450;
        Mon, 20 Jun 2022 13:06:38 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id t2-20020a1c4602000000b0039db60fa340sm19508415wma.33.2022.06.20.13.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:37 -0700 (PDT)
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
Subject: [PATCH 15/49] regmap-irq: Change the behavior of mask_writeonly
Date:   Mon, 20 Jun 2022 21:06:10 +0100
Message-Id: <20220620200644.1961936-16-aidanmacdonald.0x0@gmail.com>
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

No drivers currently use mask_writeonly, and in its current form
it seems a bit misleading. When set, mask registers will be
updated with regmap_write_bits() instead of regmap_update_bits(),
but regmap_write_bits() still does a read-modify-write under the
hood. It's not a write-only operation.

Performing a simple regmap_write() is probably more useful, since
it can be used for chips that have separate set & clear registers
for controlling mask bits. Such registers are normally volatile
and read as 0, so avoiding a register read minimizes bus traffic.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index dd22d13c54c8..4c0d7f7aa544 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -84,7 +84,7 @@ static int regmap_irq_update_bits(struct regmap_irq_chip_data *d,
 				  unsigned int val)
 {
 	if (d->chip->mask_writeonly)
-		return regmap_write_bits(d->map, reg, mask, val);
+		return regmap_write(d->map, reg, val & mask);
 	else
 		return regmap_update_bits(d->map, reg, mask, val);
 }
-- 
2.35.1

