Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4916501791
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358356AbiDNPlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354279AbiDNOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:41:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416C8D1CF3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:34:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f3so5033517pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JR7TGUzg2jTgqyV7dtws4W0P36w8/I4C5KP+KUJ6XkY=;
        b=e/V0toUXFKIfbzcWd3+aVJ6Rmm/EpLtj5P9sXxAoSV5ff6JEJlaZJEtSh3kvQI50QE
         wazu2qVsYBARhMzzJnyULXLSLNXJRTvqXWlZl0WJmUyxzhrXzHSqrJgXHWkmZLbFJE+i
         SiRJweI/ucaEcCKzvQW3k0KmmBBt1B2AOQnxdeYZG39hurUIUfGETH/4XttlHlRXFe4e
         8e/KtAADwZk2MplvC14VF5f/7ml0h+b3bJmtS1dQmL3B5L1dP0ERLUQgXMNdBMm2NJNK
         tiSVKTE0pjhwDhrlEx4+EBeIbeHrGEAomsW2G1g1F9P7xqZRqhbo5uxa9aJQSU5ewMnJ
         i5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JR7TGUzg2jTgqyV7dtws4W0P36w8/I4C5KP+KUJ6XkY=;
        b=ZY7LC9k6qIdl7xkCsUHe6BvoVA8Vqs6E9TnG1b6KsDNHtbpw5rNKycTVUj/pdiu14d
         TpKWN8B839Xc//mlYjXj9JT8FvGRU3shQ32XTg13G/qSJDQBfzZCcP8PJ7kdV2BcBa5e
         e3QX35LuJXWTwSTdH6dzuSQGlRpTZlSeSlSZwAXG9CribEUsXzSoKDbDCKknlKyeu/VC
         yh1ZYlZxuSlaYK9bSvG3nUDIs89lXnneIiLp6o0D3RZI5QvPR4bE11KjPs2mvDxAa/QO
         wqGHEipY4k/WuMC0KZu2QKCNzH1UMxDwooRGO+9+heS6avd8+W1Doi87ayRDia27tcCh
         1vNw==
X-Gm-Message-State: AOAM532EW2p5i+cnnv7FihCiEejmIM8iSMgMuRxs6qPmq7H0w/VShPwl
        P8Da0MoXyQnvNd5mpExNcZs=
X-Google-Smtp-Source: ABdhPJwE+zcDwE+ksowryjT2STP8byQ3rarD4EqmnKcvx4kkuBg2EJ8HEW9UA/mzKKQTl8P4SUy0jA==
X-Received: by 2002:a05:6a00:b8e:b0:505:8d7e:cb02 with SMTP id g14-20020a056a000b8e00b005058d7ecb02mr4202119pfj.68.1649946876042;
        Thu, 14 Apr 2022 07:34:36 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090ac50500b001cd5ffcca96sm4411017pjt.27.2022.04.14.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 07:34:35 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] mtd: spinand: add support for detection with param page
Date:   Thu, 14 Apr 2022 22:34:24 +0800
Message-Id: <20220414143426.723168-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This patchset adds support for spi-nand detection using parameter page.
This helps dealing with future JEDEC ID conflicts introduced by crazy
vendors. Also, the added ability to auto-detect chip capacity can help
reducing number of entries in our spi-nand id table.

Chuanhong Guo (2):
  mtd: spinand: add support for detection with param page
  mtd: spinand: probe Winbond W25N01GV/W using param page

 drivers/mtd/nand/spi/Makefile  |   2 +-
 drivers/mtd/nand/spi/core.c    |  23 +--
 drivers/mtd/nand/spi/onfi.c    | 298 +++++++++++++++++++++++++++++++++
 drivers/mtd/nand/spi/winbond.c |  25 ++-
 include/linux/mtd/spinand.h    |  53 ++++++
 5 files changed, 380 insertions(+), 21 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/onfi.c

-- 
2.35.1

