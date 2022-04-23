Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCED50CDE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 00:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbiDWWTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 18:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiDWWTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 18:19:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C68B14DEA4;
        Sat, 23 Apr 2022 15:16:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y3so2392567ejo.12;
        Sat, 23 Apr 2022 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lFjJJJlYM4H1S+bgrWGGgV2Wqrk7g+17B8HEDjArx4=;
        b=NUZQI1WhFEVKOCJDqtpRIuautN5VsgNc+CyCC2+2EATEdY/qZx63tx4kpBGaLIuDGF
         P/hTU/tn7D3yrLbEUcNwGZ/G+VhEM54t9mKxNxvxN02HMLCIUHAB05RIdMt/vtSYdgL/
         Aj12h+tPsAn2PqYAytgYl3DUsZOgzCUax6uv7CyN0i3KrBYe+g7+yv21L5n5O38YPWaX
         e90mGZDPQvt7rMTqRmkO/fVnA4r2ftcrlCm4gtbzzx+5DvLcrFMdczOXBweu1XaWXrpY
         eN+mCNGiJ5eNtHgW+2Y9CCgzhxGlzj4Eqz8C0usIyBE8jduG5FuPWgKDbPR4zaLbsyTC
         0NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lFjJJJlYM4H1S+bgrWGGgV2Wqrk7g+17B8HEDjArx4=;
        b=WZPcr4qW8MX5mvdd/8zB4UYI6Y6lzCa5O9IZ1bCoCMDPvJ+Lz3AahIzloh2CcrjjeD
         ISUIH1lrlZnPEeeVrdrOW4TQktYyx/sgkQDh1RKz5bQgrc/FltAAn6BgtW1/0gZaDMCk
         Ma1HvLPKrTeWpQ6sD0Loc94nTYqCkq360J1k5WrjAifyjKL30+fmHht9i3wbdtxUnIAR
         Y0g5XzyWNnxopGy1fi0b5vyssDcVZZEJ6HkVbYbqcalOodfV8/SFCnNNwfiI8/cvFcI8
         AOOjBAlelxyCz3zsHbJO1mLziLUNVG+dqtcOjrsF9b6bAZOykWVb6R2fhijaFkVkSEw1
         iUeg==
X-Gm-Message-State: AOAM533YsWFz+ATsxbjM9bs4Lz74jPp9ojDYexVbQ23iV3urupRA4ptS
        7FBJvSxzijSBASPrrv0gaMQ=
X-Google-Smtp-Source: ABdhPJwdtPCiIyMg6RvG8hPrGGPDvN1FyrrPBzSDQwui6YeEsm82lAiqhpzcIBtKMwFSGQO+7EOWVw==
X-Received: by 2002:a17:907:7e93:b0:6f0:2bde:a1ec with SMTP id qb19-20020a1709077e9300b006f02bdea1ecmr9613235ejc.225.1650752193052;
        Sat, 23 Apr 2022 15:16:33 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402036100b004240a3fc6b4sm2669484edw.82.2022.04.23.15.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 15:16:32 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linus.walleij@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 0/2] Two changes for eMMC
Date:   Sun, 24 Apr 2022 00:16:21 +0200
Message-Id: <20220423221623.1074556-1-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Hi Ullf,

Patch 1/2 here is a missing patch since the last commit, I've fixed the
warning: "Assign discards 'const' qualifier from pointer target type".

Patch 2/2 is new, please take a look.

thanks,
Bean Huo

Bean Huo (2):
  mmc: sdhci-omap: Use of_device_get_match_data() helper
  mmc: core: Allows to override the timeout value for ioctl() path

 drivers/mmc/core/block.c      | 8 ++++----
 drivers/mmc/host/sdhci-omap.c | 9 ++-------
 2 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.34.1

