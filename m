Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217DD51D8E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392414AbiEFN0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392417AbiEFN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:26:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B20694AF;
        Fri,  6 May 2022 06:22:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so9998911wrg.12;
        Fri, 06 May 2022 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnE/wFgLIRN0jlfgB48rKqRGVy1eNhP4yxVMqJbknj0=;
        b=FjZdAY2wnuHAS93BTXhJAPrZAaWaHRy79IjcTfCUeBH/Kunt+OVla7vvHK1nHIXqFc
         weecEfU3K7auHBasZj5B/NC2ADNC/mh9HnZ5D8JJxhPKkNFloU0XaLUelAm9ooe+yxFt
         BYDzLYKqeV2to6dMADxt3oBSPk16AFQOYSJBKqaiyOYpkdcqbAzhzO6VjxOxGheB+cIm
         CA7vB/laPzLTh1/gyaLOKS22x32weAsUDZ3EyKZtPsSv8UascwFzbqgjbLpfKA8KN5fZ
         bbPkFsDM140FIRKsNzcYOY9iENIKFEbhuWTubSiuH3I9UUJSOKcCSMpFiwMShCcf+6MW
         MviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnE/wFgLIRN0jlfgB48rKqRGVy1eNhP4yxVMqJbknj0=;
        b=PIoFfRa8dpks3tNnQTpVc1t72WSImZik5TFUhk5jIOCaxq0etonH3/TDNJwnvs58PR
         sJcBpexz1mg4M41a8Xc0gb1xv4mlO73K9ey2o3VjM/80sttUrsLtFQlnRibOqulyDXHG
         Qu1Pd+s/dpxY2eCv2NRSGfNnbKXi6hgmtANYeS8AjIYv4d948x3c4Z7fAMMAoRj8tZX9
         T7X8Ed9IDpoO9ZlW862YjrsfX6WxtDyliRAobG+tdegF9FbIZwxeFKaypFgw7tV4SZSo
         GOx2ft43yzvJcDlj5cV3uZabu38G5DUf7GSVlWJMRTwm74105PDY1ZpmJWgV/UDlOtSj
         XA0A==
X-Gm-Message-State: AOAM530yJ2x/zkOcJ7pLe+lQvwBwBBcvjw5Uoq1CHRTblZyeHIZHceSE
        RJqWS01wI/7jsrAlEKM0QkIytGqRQZs=
X-Google-Smtp-Source: ABdhPJwkVFy1RIZuE8dDzKw9CHw0QD8uVDl3jH0vijBWoEoDBCzWo5pHNhstsX7sTNjoHykZsCoIcw==
X-Received: by 2002:adf:dc0e:0:b0:20c:8a3f:b523 with SMTP id t14-20020adfdc0e000000b0020c8a3fb523mr2715293wri.201.1651843355959;
        Fri, 06 May 2022 06:22:35 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600012cc00b0020c5253d8b9sm3635379wrx.5.2022.05.06.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:22:34 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] memory: tegra: Tegra234 and error logging support
Date:   Fri,  6 May 2022 15:22:25 +0200
Message-Id: <20220506132230.3910539-1-thierry.reding@gmail.com>
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

