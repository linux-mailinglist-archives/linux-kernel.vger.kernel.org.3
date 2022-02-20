Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A49B4BD19A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbiBTUri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:47:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244992AbiBTUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:47:10 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F08EC68;
        Sun, 20 Feb 2022 12:46:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id e5so14998082lfr.9;
        Sun, 20 Feb 2022 12:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4NNgPeseVQ7zc/okpigZG8JuoYTIL2ZK7mVcAwhCj0=;
        b=TVEYLvhADpy6TUhdB4vzPnPjsMHti8s/g42gFVHYAWkWn1CjkM5S1GG2AFeeVtd1jM
         wdH3DVKPn9bdiQyQU0Jhn3m27Iv3pm1XL96esbgDAfy6v4hYeAbQuVGnZDuGrcS5DlXu
         QGUL4aa3Bfce20gK8t1v7XrwaFpJ1CRb3Nq+Za1ypMbIC/UnDrisZsWCMNdDlmuyUk0B
         kKAu9N89i49A9670p/H0lrS/cm4Mczc+7JMVgw2XNAgRQ2EBvmltNexCNM9yemoAmiqH
         XzGtYxzdjYrUBqodAXm6pwC61Zh6IxXDpeBfVF1yB//L88+EetgGL7OazJnCHGKJJHTe
         aaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4NNgPeseVQ7zc/okpigZG8JuoYTIL2ZK7mVcAwhCj0=;
        b=L1pJqdKo0Nizuq08lDRWtUHvgJYSebUFjgogoEiKK4OEhUqhvjyvJ7MnMXiGqgqFNE
         Xi0unzSXalz9GnoVik6Hsr+PKLQLYw+HzlBtWkJk15/U40QfRdvz9/APLrQp3AhGfcj0
         jYbmQJ9rOPVM6S1baHWbD0u6WXLHLZbWJHrfDdz2yUi5cERC/lgd452dIvA20cTtCbXI
         P4pdoQUkv7IBdWgHJEd2HJCX8VL2UH1/og9TqZy5KqlvK2uahMJp/rT3HCPD5Vmo3d43
         2DfGmMVkrRUrt4Zq9i+7uwO77ztCD+Adr43sm4QUEs38C7zYbbXi1v1It8zqYqzx8OVj
         FkgA==
X-Gm-Message-State: AOAM531QxoCuVenMailY5dvbbRaSKuxWMXze5VI9jMZ2mFTgsY3mkW+w
        +xAzhDxkXoDFLSZImcTf5Yw=
X-Google-Smtp-Source: ABdhPJzshzL+KSV2yLT9MUX88yqjVxdxMGn/JUgPJDkWdM1MTgyIa8QKiAAeyt5yqld8hrhRS2cVjg==
X-Received: by 2002:ac2:5de4:0:b0:443:5b80:d4c4 with SMTP id z4-20020ac25de4000000b004435b80d4c4mr12044367lfq.373.1645390004777;
        Sun, 20 Feb 2022 12:46:44 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id o14sm913955lfo.117.2022.02.20.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 12:46:44 -0800 (PST)
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
Subject: [PATCH v5 5/8] media: staging: tegra-vde: Bump BSEV DMA timeout
Date:   Sun, 20 Feb 2022 23:46:20 +0300
Message-Id: <20220220204623.30107-6-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220204623.30107-1-digetx@gmail.com>
References: <20220220204623.30107-1-digetx@gmail.com>
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

