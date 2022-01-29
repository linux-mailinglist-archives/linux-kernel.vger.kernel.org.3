Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187234A2E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbiA2LdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiA2LdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:33:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF49C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:33:12 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id h7so25461447ejf.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8cMBHSadmZr4dAO9qcJpmYsyYRstSSExIKtSE84QP8=;
        b=EnyQs4WGRqih35lUeR49tKcVZtbKi+1TmEz63Zob6D3Lvo2W66TaVKGPjrRYcCK+hh
         dJQzzD3682Z6ZVDFo9g00eTWaTsCD2IEBqfkk5NIsCCFzvAuJQq729sScFrFMTaJqkyj
         TpGCy6glOy1okwnYhh2/WCRM0IOV9GU1a+kav65aa0jxjPrRFLnh7bgt+hF+Z2TWXi1u
         tGl9sy1hBZ2jA5phMp5W4nmNO1/uHSXyyhO0baN2a7CLDotzdu4gvZGK1AvgBRv64gLb
         r12vMz0EAFLgSf1Sccp08aZuMevqM5V0jaw3qGIJGbW5P2et2FpD+mhmX5l6kdOCQjG5
         GU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8cMBHSadmZr4dAO9qcJpmYsyYRstSSExIKtSE84QP8=;
        b=1ut+H0jC+g3w93A8K2DQWIpmvi0m82CYpeJUNcx6p49QyFLSw2x089MiLMPPPyQcVR
         JxgchljBhp3Kh2Pcj7q8ispDxqyhK5NFf+3wjPVpwYFYX1yMggC+xe26knrRuDXfEfUf
         NWEXG1JwLgScMMFNNjg8EIuzVCQkXD+hG/dPM3s+Dt50B/eVZljFaHjxE3v4R24xEuXU
         NukPihKkSqTaVpylLDF9B0NNPOpRaG3JH46tGYy3LU8sjDjXfB/4AkR7PRoMUH9GLhk/
         zWo9tDYlYkuhkWCr5LyRg+nIk0iGRlkUURNRiUS12eMJwgBu2z5MMkS3Dl6nzgSnqATw
         xVSQ==
X-Gm-Message-State: AOAM5333HYx+UIljEgs5Yn93FLdKSMCKWNqvZHrwzClgt1D9nyqRDAe/
        fQBEslbFB628Fq+HWuclskspvdrHOhPdLA==
X-Google-Smtp-Source: ABdhPJx7Y+D1JzsMbkVc0vbHamUR42KtQ1jhHwAdhJ1EkQkzORMLGu59GtAmXP70NvnIvjkbWbQ+nQ==
X-Received: by 2002:a17:906:9491:: with SMTP id t17mr10015483ejx.339.1643455990740;
        Sat, 29 Jan 2022 03:33:10 -0800 (PST)
Received: from cosmos.lan (178.113.77.92.wireless.dyn.drei.com. [178.113.77.92])
        by smtp.gmail.com with ESMTPSA id g6sm8885062ejz.170.2022.01.29.03.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 03:33:10 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christian Lachner <gladiac@gmail.com>
Subject: [PATCH 0/3] hda/realtek: Add/Improve several Gigabyte X570(S) audio quirks
Date:   Sat, 29 Jan 2022 12:32:40 +0100
Message-Id: <20220129113243.93068-1-gladiac@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up and improves my previous work for the Gigabyte
X570 audio quirks and adds more mainboards to make use of it.

Christian Lachner (3):
  hda/realtek: Add missing fixup-model for Gigabyte X570 ALC1220 quirks
  hda/realtek: Fix silent output on Gigabyte X570S Aorus Master (newer
    chipset)
  hda/realtek: Fix silent output on Gigabyte X570 Aorus Xtreme after
    reboot from Windows

 sound/pci/hda/patch_realtek.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1

