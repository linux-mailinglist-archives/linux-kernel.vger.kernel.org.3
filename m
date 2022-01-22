Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176974969EC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiAVDzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiAVDy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:54:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A97C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:54:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v11-20020a17090a520b00b001b512482f36so7888539pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AZpnBw4RaqQoYcagsg73LF4yfaWi1RtR7CrBVPWFJk=;
        b=GCFLOCrbsT3vYYjj9sk0+iqHPAU3MLHKF65dsd63ve3ERaTGwlgAhWbIuXV7/qP0jD
         cfNREdPKYJL8TlLF1zuKbNcP3qtsmzHPVFzzMTtKapTLuhLclZwMfkBZMRrz+peIA4x0
         PNCckGsGHYkV/umugZOXh1zFqA5Q77jEsqHan+Z6uXtmQ5aXIR6/S6NT69MPnUrw/Hcg
         AjsO43kW4LJXOvWMObXxiRQPfnZ8bCiXEUS+ysmoLZv/41asA1TWA0repTbb1+WomnVO
         djJrSIk76Vy7j7FQYOWHgpowR+0mND4oc3icvUnfma0Tg+4g9Eds5tnLtpJcrFVSmXBB
         7doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AZpnBw4RaqQoYcagsg73LF4yfaWi1RtR7CrBVPWFJk=;
        b=R7kzGhrT1L2CPSVadwHlvNpZMElza0VIzHKgz19UZri0yBBvS6vi0J0w35ZR5fGLUJ
         /icpRjuC6wb2VHH/MUbTZmrEzxRyREhZHQ2wRlk2NBYax5rx6yKGrJL5vnLwhd2yqgCa
         B4xGEUYeWeF8LLaUk+WVhuPDw6/3HUlAzABVWNwOM5yd4JTgkWX7DeeqEWwoXinKZ/jZ
         /vZ0Q6CVDWbgWFm2laXeAEN5mUTxr/duMlGGm6P6/hUSCToorys73JVsrWUrc6L/BGuo
         Bd/KU8/E8PO1Velm/MYeupPdLuNJ7yB1qAnOi7irRV8lz8EpCDQ/OMlar55tap13y28S
         bbnw==
X-Gm-Message-State: AOAM531nfTrN59glNubRZbFSGH6f+hNH0aSthrgxiQpD+Dju2Uj/sWhQ
        S5t+zQEf7rhyd0GAVxLDfjo=
X-Google-Smtp-Source: ABdhPJwDYRuZLdzX0adpwP9PuSyBj4/BK+RZDPdijFhKrsxH1DKB9ec1FpU3+ccpt5KLM51iJ2Y2bA==
X-Received: by 2002:a17:90a:5d17:: with SMTP id s23mr3622752pji.65.1642823698692;
        Fri, 21 Jan 2022 19:54:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a1sm667255pjm.1.2022.01.21.19.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 19:54:58 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] soc: bcm: brcmstb: Make legacy PM code depend on !ARM_PSCI_FW
Date:   Fri, 21 Jan 2022 19:54:19 -0800
Message-Id: <20220122035421.4086618-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122035421.4086618-1-f.fainelli@gmail.com>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ARM 32-bit the legacy PM code would conflict with a PSCI based
implementation that we are going to introduce in subsequent commits.
Make PM_BRCMSTB depend on !ARM_PSCI_FW to exclude the two
implementations from each other.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/pm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/pm/Makefile b/drivers/soc/bcm/brcmstb/pm/Makefile
index 8e10abb14f8b..86004458260c 100644
--- a/drivers/soc/bcm/brcmstb/pm/Makefile
+++ b/drivers/soc/bcm/brcmstb/pm/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
+ifndef CONFIG_ARM_PSCI_FW
 obj-$(CONFIG_ARM)		+= s2-arm.o pm-arm.o
 AFLAGS_s2-arm.o			:= -march=armv7-a
+endif
 obj-$(CONFIG_BMIPS_GENERIC)	+= s2-mips.o s3-mips.o pm-mips.o
-- 
2.25.1

