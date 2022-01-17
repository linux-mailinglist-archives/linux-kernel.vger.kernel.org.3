Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FC4900E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiAQEw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiAQEw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:52:57 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:52:57 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id w21so18869995uan.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZav6Qqz69x1CPSgB4unUJNOmMH6xqSsa+fH5HgealQ=;
        b=pZteWOubU+1UNF549R/VdU3j2v5g75Ql8w0yBUEUItb+LsNq2x+fhD9dfr2t39T03e
         pdjb9t4kVFHbaCIBwaY//+b7nrxuRUsq77kszp1fCsxJr+bw3SQHSvsUvye8kslo232F
         W/3/89gVntb3xldfzInpImetLXvzDYRakmNtxgwkvreU+wlonEfwcpteb6iRMhwLPyE6
         KtvV9i1HohETc9mFDN0IQIyrD+m7Cx2Gj8I3G76JbroMsH2HbEXmGT50Y3WrKBsso/XT
         t3KJnY/I6Lu+k0hcfgOLAbEBKFCpzae+qBRJqoAtHNB7+LQWsAR1uRrzwAe+fxplwDVv
         sv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DZav6Qqz69x1CPSgB4unUJNOmMH6xqSsa+fH5HgealQ=;
        b=QPXMpPA1XpAJatETXA9Thgi3mIkgfR7YlFkDBNtSdYVA8WK1AXbB6cKDw+hE90pPCq
         UDXwXv59hPYigxiHuJqo2jzYud2xWtpf5GI14YFdP3oDMstWjA8SUzZ7mIuB7TGXCEm0
         wZCWFlHgvUMPJOzormU+E5kAFgxGJfLjrlyn/OuaOqX0VDpTl8BUkPAmLzyKuA9SYhBb
         2CxtavLaq8twiPL0pNyCgrbN6w3Y/vTupGWTWs2TChnvf4ETo+AVdqqEtGQF1RgDNFFl
         2NhTo7YD4bTQ42lQQ0FwTdj9iNBMonJkxAcuU6YUPLB7Da+BIRDyIQgjwosbq5TE2cCo
         mq0A==
X-Gm-Message-State: AOAM530yppx2UOj2eEaL6UeTIqL9tD6Zye3l9azPRI3KA4V0lDwXV2a0
        XOjNgQKbVE+eoV9bbXzHOJY=
X-Google-Smtp-Source: ABdhPJz/tUBtqlzg2AR1oV/Aliq6lC+BH3Q4UMsbZpyzPGwjpOjFJ53tUnPE3zE8cr2IyYOA+wQ8ew==
X-Received: by 2002:a05:6102:3a08:: with SMTP id b8mr1821474vsu.53.1642395176043;
        Sun, 16 Jan 2022 20:52:56 -0800 (PST)
Received: from kubuntu-desktop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id s32sm3409994uas.3.2022.01.16.20.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 20:52:55 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     broonie@kernel.org, cezary.rojewski@intel.com,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, brent.lu@intel.com,
        kai.vehmanen@linux.intel.com, mac.chiang@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] ASoC: intel: fix unmet dependencies on GPIOLIB for SND_SOC_DMIC and SND_SOC_MAX98357A
Date:   Sun, 16 Jan 2022 23:52:54 -0500
Message-Id: <20220117045254.66037-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_INTEL_SOF_CS42L42_MACH is selected,
and GPIOLIB is not selected,
Kbuild gives the following warnings:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_INTEL_SOF_CS42L42_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_SOF_HDA_LINK [=y] || SND_SOC_SOF_BAYTRAIL [=y]) && I2C [=y] && ACPI [=y] && SND_HDA_CODEC_HDMI [=y] && SND_SOC_SOF_HDA_AUDIO_CODEC [=y] && (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=n])

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_INTEL_SOF_CS42L42_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_SOF_HDA_LINK [=y] || SND_SOC_SOF_BAYTRAIL [=y]) && I2C [=y] && ACPI [=y] && SND_HDA_CODEC_HDMI [=y] && SND_SOC_SOF_HDA_AUDIO_CODEC [=y] && (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=n])

This is because SND_SOC_INTEL_SOF_CS42L42_MACH
selects SND_SOC_MAX98357A and SND_SOC_DMIC without
selecting or depending on GPIOLIB, despite these
config options depending on GPIOLIB.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/intel/boards/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 34ccefcc30c7..6309a37789c7 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -279,6 +279,7 @@ endif ## SND_SOC_INTEL_SKL
 
 config SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
 	tristate
+	depends on GPIOLIB
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_MAX98390
@@ -288,6 +289,7 @@ config SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON
 	tristate
+	depends on GPIOLIB
 	select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
 
 if SND_SOC_INTEL_APL
@@ -485,7 +487,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
 
 config SND_SOC_INTEL_SOF_CS42L42_MACH
 	tristate "SOF with cs42l42 codec in I2S Mode"
-	depends on I2C && ACPI
+	depends on I2C && ACPI && GPIOLIB
 	depends on ((SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC) &&\
 		    (MFD_INTEL_LPSS || COMPILE_TEST))
 	select SND_SOC_CS42L42
-- 
2.32.0

