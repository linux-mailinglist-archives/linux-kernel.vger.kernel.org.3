Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C55471B05
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhLLPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 10:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhLLPAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 10:00:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06649C061714;
        Sun, 12 Dec 2021 07:00:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so22983811wrw.10;
        Sun, 12 Dec 2021 07:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+XKpi1Nw/K0WwguHbm8TyEDZ13WyLeSnzDDVy8OBGh0=;
        b=BbcEfHrxsflbtHwJaZkG3PwLNz7LaNIlm8ci1p6MU0ofHz22aTuqYTxsEFnTKQP8cM
         vM13Ir+W4lAOibTy/sioVVfDEY6VlreL5tuWit3/D68RJi1s97PUS/pGugsRrFE+hHuh
         ke0XGkzLVW3Oh310JSntNVoJ8SYPAy+buFww99kf98SGR70kjJETkHaJMgS3Cb9QOb6e
         uhtUAhg0T4Kq7giWtd/nleWouGZYmVt0E4vYy1RLhmneeGjzlzLf8Ttm/NnU2eO7Yw9N
         HAT6vtFW3UyY3nC5bWNAOIoyA6ck4834KmL7DIBqKSZw57Yer827Mn1JhiYFOk1IuY35
         /bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+XKpi1Nw/K0WwguHbm8TyEDZ13WyLeSnzDDVy8OBGh0=;
        b=CXUMIi+OCZ7mRkizxO6EWOFkGCmcHXQeoPM8sO7Ezd4z8oE2H95b+TJh49R8OBhGf9
         Df8ajqYInemGJnQ5NxYlI8lX6kX896E2tBiEHyoovV6QG71F/vHny9e9RLLD0yfQgH1A
         kEQzO3s4jTQt4tkwbY0RQSbwARUh3Xizw/TdSkPSG1o7poJ/bXN2AJwSGjzl4PL+dl27
         paiydFefXUdferEpX4O6jTokIM05i0jEw03Syh2y/frv7ZLG+T00cFo3p0NxE8H6w2gu
         6SxXfYyuacfLqAfAOU9dSqBRBKszcS5WyzFcDHJM/gu8YXAV+3Xv1xCAD6szvWaH2qnO
         YDNg==
X-Gm-Message-State: AOAM531O+52IijdmTYxIb5K6AqrhSdSIVIWbIE+3gedz+pemYKOaToW0
        CwfpRcnaaPaLCx8R6hPBTApsn3i7NEo=
X-Google-Smtp-Source: ABdhPJzTZpsZI1BAw5ZZwfPMws34vaAaoaZIAhFAGIM+aq5rlwXlEZPax6qRx+/jcnN6isMRKWD0oQ==
X-Received: by 2002:adf:ce08:: with SMTP id p8mr26313464wrn.154.1639321214331;
        Sun, 12 Dec 2021 07:00:14 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-6ebc-0100-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:6ebc:100:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id v6sm4284789wmh.8.2021.12.12.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 07:00:14 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ulf.hansson@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/2] mmc: meson-mx-sdhc: two fixes
Date:   Sun, 12 Dec 2021 15:59:54 +0100
Message-Id: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch in this series fixes Broadcom SDIO wifi cards (using
the brcmfmac driver) on Meson8 SoCs. Meson8b with Realtek (RTL8723BS)
SDIO wifi is unaffected by this (it worked fine before). Testing was
done (on the S82 board) in private by a user who wants to remain
anonymous.

The second patch in this series is a minor cleanup which I found when
working on the first patch.


Martin Blumenstingl (2):
  mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands
  mmc: meson-mx-sdhc: Drop unused MESON_SDHC_NUM_BUILTIN_CLKS macro

 drivers/mmc/host/meson-mx-sdhc-clkc.c | 2 --
 drivers/mmc/host/meson-mx-sdhc-mmc.c  | 9 +++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1

