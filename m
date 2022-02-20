Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307F14BD04A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbiBTRcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:32:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbiBTRcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:32:31 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B3CFB;
        Sun, 20 Feb 2022 09:32:09 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f37so14481200lfv.8;
        Sun, 20 Feb 2022 09:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4NNgPeseVQ7zc/okpigZG8JuoYTIL2ZK7mVcAwhCj0=;
        b=OcJt0nSJkSpqa3XuHEELanAYp0WYezb2ukpVkwYdIDnHKyZZ3dgi7I6lS/IVHSmHzo
         +i2OHT+8bh7ApJaxLXY3gnQbWdttnNMukXTFgUuzp8Mwcqgk9wdN//WbSsMcoLkYrjI1
         IEVDIw7ZhCm0ctl7Uy0mZF8+9j4FKLzJaXZTHdVaJcWvDqGe3WO8vG8jtM0cARxwCX11
         yaBtSPK37eji5xHnnM8JPte2b2g8HNVI60rbXpUS3hLVqZw2MQoJflGL8Gw1cV1M+t5V
         RjBxhm1iOyg82VOrgyPCA0qEw3FlICoSb/JKdjqZHr0JBRElSUXil8ivQ3N4BDF5cdE8
         Rkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4NNgPeseVQ7zc/okpigZG8JuoYTIL2ZK7mVcAwhCj0=;
        b=LAG1JqzCZFx7K65SK0snw449lcyfAyz9rreE2rspaWFuwwTgLVD+lcNE5PA4tzOaW3
         sgLbnzlSaSJj3ulMNaEk/J87FIGwu8N263j/uakEaDbpOk1w6/9zbEURUBETJudxEypc
         hzbVO+jb9WPipqB3ke25WjxUTqtla6rJgnxZPo6EU843YJbMFlF82KuCuiYvAMfC0D2O
         L1BNxM+u362SHeha1i3ktbnbC6517Wi2AGrY4S8s8btOe98yW0X0fNUAfmZMXhtV0OgW
         m5owEGe/CnrH1bi2AnzI2y+37OWj1lbpOUjI94DoErnQSiL5ngeOJoniJ2lICAxIVOud
         kWyg==
X-Gm-Message-State: AOAM531cFLZim6qBVxuoSRrXh/u3SUKteYIKAYoYy8moYwsN1TcFPGgL
        uHCWat2vF/9daWlShYxYEys=
X-Google-Smtp-Source: ABdhPJyOmQqYHemn1gtEi1nzc/l5k90gP+dC+iANF/Sg8KejEX6icQJ30KT9Gq0DvfdhTQ66d3zkGw==
X-Received: by 2002:a05:6512:11e3:b0:443:b9c4:48b8 with SMTP id p3-20020a05651211e300b00443b9c448b8mr8306370lfs.559.1645378327690;
        Sun, 20 Feb 2022 09:32:07 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id f8sm880490ljk.97.2022.02.20.09.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:32:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] media: staging: tegra-vde: Bump BSEV DMA timeout
Date:   Sun, 20 Feb 2022 20:29:47 +0300
Message-Id: <20220220172950.3401-6-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220172950.3401-1-digetx@gmail.com>
References: <20220220172950.3401-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BSEV DMA timeouts if VDE is downclocked by x10. Bump the timeout to allow
DMA to complete. We don't support freq scaling yet, this is just a minor
improvement which may become useful sometime later.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/h264.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/tegra-vde/h264.c b/drivers/staging/media/tegra-vde/h264.c
index a46c648a26c6..d8e5534e80c8 100644
--- a/drivers/staging/media/tegra-vde/h264.c
+++ b/drivers/staging/media/tegra-vde/h264.c
@@ -135,7 +135,7 @@ static int tegra_vde_wait_bsev(struct tegra_vde *vde, bool wait_dma)
 		return 0;
 
 	err = readl_relaxed_poll_timeout(vde->bsev + INTR_STATUS, value,
-					 !(value & BSE_DMA_BUSY), 1, 100);
+					 !(value & BSE_DMA_BUSY), 1, 1000);
 	if (err) {
 		dev_err(dev, "BSEV DMA timeout\n");
 		return err;
-- 
2.34.1

