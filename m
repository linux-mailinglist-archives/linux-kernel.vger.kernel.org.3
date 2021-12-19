Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934D447A12C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhLSPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhLSPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:34:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBDDC061574;
        Sun, 19 Dec 2021 07:34:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so14853618wrr.8;
        Sun, 19 Dec 2021 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dfUL1c2VpDlpvRYp5J5tnSJmcolhRv7cYP/WcyTXpE=;
        b=P979BzXr3RvgooocRWemgZtMWBE1vmonRBBpWRWPBLJdnSm2YDpt5AWwBj942XdlRj
         CdHrU58tMcKYZps7MJsO/Tjhf7jIT3CD+1nmQMAYYUpBtLG6bI3rkD+FA1RnIvihJlh1
         KoZ0mvBbeJjBDttpkHy+yG1Ua4GCOI0xe6KeIlVXaphyFLTUVl80Z8hgQ8lECUy3d9to
         aRT68rBoHzyiFk3wVutHwzoCTuljfqHZhLK7E2AITRHyMtbf2whuAXUyfKo5sDK0KK8+
         nYeSCQhsX860SGCYBrkTJ5muXFaqNO/MqsDTpRSks60FCkFsPHRXTncZHeWvKjRZRvqa
         VUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8dfUL1c2VpDlpvRYp5J5tnSJmcolhRv7cYP/WcyTXpE=;
        b=LV7/kaFZPNPNGYtjfAjNo1/i+HXyhnI9VeIo84tMzlxMlJy6E+TvkrkiSFX7vZ05j5
         OlIdAgKfmbIikW9l7FQWaSt4qJMAVuqXU7gnzA7JT82ol6k8nBd6MWIxjFK9eSmmeVOC
         aYslWzOYBKPecfEcIxgA+agzcc404Mj3CYCykMD13q3JBk/we4sfqZcl7bxBRjR2E5Xv
         oP23FoUYPQEYaNRrabMr4ovAHs944lMVKh2ffkjH6EbTTxJb1v+oycBvWq5WGKNe1zn9
         KFdzVPqrbmzSwDmsoNAVusiXOc64l30B86C3qhDuSzJa0O9SVe6kK1mHXm9sEjY1FGX+
         Ihpg==
X-Gm-Message-State: AOAM5324QezU5rbFVRiDh8Nbgvvyw0oSeJS/XQlMNMxh6zEdQbKCqBxE
        rhCBPRQYZWEPAGGfkQ/i1qwwl4rfP+c=
X-Google-Smtp-Source: ABdhPJwB7cEhF+bnXpjr5aVYXXD8l0Z47msYuTlJCyoYNFxn5ax7p6hw3dg5/wQrpgfhKAQvqdoASg==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr10007446wrg.118.1639928093752;
        Sun, 19 Dec 2021 07:34:53 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-721d-8f00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:721d:8f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id d2sm9262020wrw.26.2021.12.19.07.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 07:34:53 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ulf.hansson@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] mmc: meson-mx-sdhc: two fixes
Date:   Sun, 19 Dec 2021 16:34:40 +0100
Message-Id: <20211219153442.463863-1-martin.blumenstingl@googlemail.com>
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

Changes since v1 [0]:
- Drop SD_IO_RW_DIRECT from the first patch since it has nothing to do
  with the actual problem. That command was carried over from the
  vendor driver. The patch description was also updated accordingly.
  Thanks to Ulf for spotting this!
- Add a comment to the manual_stop variable as suggested by Ulf


[0] https://patchwork.kernel.org/project/linux-amlogic/cover/20211212145956.1423755-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (2):
  mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands
  mmc: meson-mx-sdhc: Drop unused MESON_SDHC_NUM_BUILTIN_CLKS macro

 drivers/mmc/host/meson-mx-sdhc-clkc.c |  2 --
 drivers/mmc/host/meson-mx-sdhc-mmc.c  | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.34.1

