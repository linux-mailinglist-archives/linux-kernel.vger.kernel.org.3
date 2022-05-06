Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135BF51D8F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392452AbiEFN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392458AbiEFN07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:26:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B293C6973A;
        Fri,  6 May 2022 06:23:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u3so10050748wrg.3;
        Fri, 06 May 2022 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnE/wFgLIRN0jlfgB48rKqRGVy1eNhP4yxVMqJbknj0=;
        b=JiF3DAhzYm7/e7L1DaQyfoR7G2O1K6ozv6mNyT+HSHJd52YZZNMQDimtYXTm1omRFh
         UhwQ9JgC6MDWkqY7Xaik4IyKN9RyJ63HhtXiLQq9Abh1D7Hf/JW5JtpRZprN7PkPEUSc
         L4pqL+GccB4tOMHmVtDOHneuHecPNzEHU71AlxtH0wGuVR3QGClbL+ndGK3ebUrVD0rv
         RkoXxi7j7WERluTegqxPL6Z1PysYtd5CCYJPuI3W+retnSeSTKT7Rwp6kHFsd8Jo+KCp
         hI77jkAcVWzSomgL2g1kBcKYoFdNdPPdGcB3BM13Hqx1D+seYe1GYsmGlUq3hndI0GFu
         nR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnE/wFgLIRN0jlfgB48rKqRGVy1eNhP4yxVMqJbknj0=;
        b=xX6LT+Yxn/WbzOqiLNaAg7tahGv0eFNks7F56UuBspGJbFtwVFDn2s6koEBseTC5rW
         d1nYtlMBrYKOPo2sVO6r00vd/69Aoq4kiMoStepu1sKD6Wbp++fxRlxz8YMLOBrp1N6q
         cC8ImMm1LL+b+23RtD2aomkf83zJFFkrvaoDGmJ1cE6h3fjqyccRSoT+slQ05/ESTX4v
         r1F2cZNbKoaRTIsCrRJexNdd10goqbpNZim+lwthf985F71hCZuPSN0QIQLwSHmm79e1
         TQY0i6vMSTbuRi9WNEcUc9Vb1WpdkB/XaE0SLaZo2am8mi/UgZRHXJY4gIbMRajKNw2c
         MVTA==
X-Gm-Message-State: AOAM5326B7MG47EW7Pw40qECaOjxlbvEEiFUBWHSfyMptg7+VSl8qgVh
        d9Tv5LNx+Aa1xQ9MG6HpTT8=
X-Google-Smtp-Source: ABdhPJxDIOo/91MLqpkkLWtm4F1e8Lt9PbrlPfZcykME1tNBYeHX7KBGqZZUF5aPu4mh0z+/0Wgrfw==
X-Received: by 2002:adf:d4c6:0:b0:20a:deab:ec2c with SMTP id w6-20020adfd4c6000000b0020adeabec2cmr2691483wrk.359.1651843394195;
        Fri, 06 May 2022 06:23:14 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d510b000000b0020c5253d8c9sm3556349wrt.21.2022.05.06.06.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:23:13 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] memory: tegra: Tegra234 and error logging support
Date:   Fri,  6 May 2022 15:23:08 +0200
Message-Id: <20220506132312.3910637-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
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

From: Thierry Reding <treding@nvidia.com>

Hi Krzysztof,

here's the set of patches that add the initial Tegra234 support with
Ashish's error logging support applied on top. This should all apply
cleanly onto v5.18-rc1 (and consequently to your tree).

Thierry

Ashish Mhetre (2):
  memory: tegra: Add memory controller channels support
  memory: tegra: Add MC error logging on Tegra186 onward

Sameer Pujar (1):
  memory: tegra: Add APE memory clients for Tegra234

Thierry Reding (1):
  memory: tegra: Add Tegra234 support

 drivers/memory/tegra/Makefile       |   2 +
 drivers/memory/tegra/mc.c           | 137 ++++++++++++++++++++++++----
 drivers/memory/tegra/mc.h           |  50 +++++++++-
 drivers/memory/tegra/tegra186-emc.c |   3 +
 drivers/memory/tegra/tegra186.c     |  39 ++++++++
 drivers/memory/tegra/tegra194.c     |   9 ++
 drivers/memory/tegra/tegra234.c     | 110 ++++++++++++++++++++++
 include/soc/tegra/mc.h              |   8 +-
 8 files changed, 339 insertions(+), 19 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra234.c

-- 
2.35.1

