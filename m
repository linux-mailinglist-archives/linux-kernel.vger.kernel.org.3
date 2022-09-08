Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C05B20FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiIHOoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiIHOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:44:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4D63BD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:44:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id jm11so18051543plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f1u38+lpP3uUpdpRuDgUoYZwjE7yjDfDzNqW/1OTveQ=;
        b=ZNproLrsTmwfqHcFUDE41Pn3ppB+VvLZUt0OoQ/lZ8e72Q4YKxyaVCpMJUEyJDSnCa
         eSvRWzccMzwJdj0YsjFjIxTL0dooM5nXCJQP1PHx6bQAleNplo75lHpEsF01QFXIRXG5
         hWhwYer3PbDbVMh2Q+ageHD13Lg3lZ9UNYzjE6R3Kpgb6kr2VESZ2zW03pvIHxwhUhLQ
         VM/VmGpj/f69qM5euFPl+/zTJxdrJzD15osyWfZUKyDS3KpIYPFOb2AJBH0xSX0/InSq
         sbmzdRs2AAJLvnjkxQfmgN7ca08+AGeBoJY+Ywl58w7EF52lSkWP1Ztdmuv5l+ZSF/97
         tFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f1u38+lpP3uUpdpRuDgUoYZwjE7yjDfDzNqW/1OTveQ=;
        b=W/nvWOKduymV+bfLwo/xQg3qMl6hrBSCWZ/i+zJD/irlcw8tytaYviswB/i0r37lSc
         8ms+D26b3krB07G9zdT15ohoRaLNgQ0NVyRxxlJzZl684nzoA0NHMU0G+KHYKuk36uGj
         uhLv8xh/Gm+u5J1Nf8PcwjuoFp7Cp4/lVn7mNzoCnRFeIthS3EHQPGxrZwgfxM0ASXYd
         l1PAML9jU0EEVESj6s8WWYvpZNqsWBVPTqouoHH+1eyqZE+CdUwShSQZbcA77uypLqBV
         1LYFy0ejr6ViM+tcXlW8OXZMsAWl1hKblL57bmpHkMFTAHgQxhVK/JuA0cCbuvoKmSFn
         b4nQ==
X-Gm-Message-State: ACgBeo3EJeJDxEV4wzBasmmGpSKMr3KMvocRNLqczJRe4nq896vJZ3Zt
        YqOa+TnMsVurhxlHzG5noNgpkQ==
X-Google-Smtp-Source: AA6agR44jEvcjSHnfI5NxCT6ZhnkMwVUCWHJdZqCZKYRVa7ZlaxswBnb0759Edh4RKcLiWU9DD+ttw==
X-Received: by 2002:a17:90a:e586:b0:1fa:d28b:ab9b with SMTP id g6-20020a17090ae58600b001fad28bab9bmr4692671pjz.47.1662648270190;
        Thu, 08 Sep 2022 07:44:30 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d40400b001750361f430sm4484728ple.155.2022.09.08.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:44:29 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 0/6] Use composable cache instead of L2 cache
Date:   Thu,  8 Sep 2022 14:44:18 +0000
Message-Id: <20220908144424.4232-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since composable cache may be L3 cache if private L2 cache exists, we
should use its original name "composable cache" to prevent confusion.

This patchset contains the modification which is related to ccache, such
as DT binding and EDAC driver.

The DT binding is based on top of Conor's patch, it has got ready for
merging, and it looks that it would be taken into the next few 6.0-rc
version. If there is any change, the next version of this series will be
posted as well.
https://lore.kernel.org/linux-riscv/20220825180417.1259360-2-mail@conchuod.ie/

Ben Dooks (2):
  soc: sifive: ccache: reduce printing on init
  soc: sifive: ccache: use pr_fmt() to remove CCACHE: prefixes

Zong Li (4):
  dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
  soc: sifive: ccache: rename SiFive L2 cache to Composable cache.
  soc: sifive: ccache: determine the cache level from dts
  soc: sifive: ccache: define the macro for the register shifts

 ...five-l2-cache.yaml => sifive,ccache0.yaml} |  28 ++-
 drivers/edac/Kconfig                          |   2 +-
 drivers/edac/sifive_edac.c                    |  12 +-
 drivers/soc/sifive/Kconfig                    |   6 +-
 drivers/soc/sifive/Makefile                   |   2 +-
 .../{sifive_l2_cache.c => sifive_ccache.c}    | 200 ++++++++++--------
 .../{sifive_l2_cache.h => sifive_ccache.h}    |  16 +-
 7 files changed, 151 insertions(+), 115 deletions(-)
 rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)
 rename drivers/soc/sifive/{sifive_l2_cache.c => sifive_ccache.c} (31%)
 rename include/soc/sifive/{sifive_l2_cache.h => sifive_ccache.h} (12%)

-- 
2.17.1

