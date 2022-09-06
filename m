Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975ED5AF21D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiIFROf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbiIFRNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:13:44 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B5F8FD5A;
        Tue,  6 Sep 2022 10:03:16 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so8471126oth.8;
        Tue, 06 Sep 2022 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XjI3JQEiXwzsRWt/M8irfOaiWmTHLb3z63j8Zzx/as0=;
        b=SMRLrhO64BMjAoRWo5yIUqIHCvBvyhZfPGyHTSyX2FAnm4yuQfP5mK4qpUNGuEMzjv
         szkieXnp4bIxa8CgyTBgMSfXYrbJBVzpr4+NSK2mn+aMMJar5a2niuCiKpMqk7v5laoX
         SiKQe+F61EnSs8OhNVgDaBYK4iLZN6RT5s2wFXBZglZD8eJWIeOYcCkbkZrD0Ni8yeWQ
         Rv0woTE6mWOc7S1fnnuQXIdrXpQdoNUs0mn9IUMbpHr4DCDz1tVLFissbc0A/uzx7rwl
         O+4nK9LwzWBYjgoXcft8zONGLPllEwhwbyt3/etuEHVv4xbstI6126MjMEUU4CZZKO/U
         s+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XjI3JQEiXwzsRWt/M8irfOaiWmTHLb3z63j8Zzx/as0=;
        b=KxQ+SCJmW2pXb/c8VuXXheJ+kSQtxcumyuaxK6truriSSCSVEpB2LS3UzkBouZmY6H
         /4UjgPiUuQ5VrneU9DfzPUzzXz2rdNe71GOCwUEcLinLvwTdOKxHtdswGLoIaFnH15R1
         e8z7kIiRURFWBjE9CauwP+oifhXx3/r0YpeF53vC8rRkKzGcXIYTqjSr9WNCmMp+WUNC
         4jK4XDQhOW8KWWETuY8uvZzsxtSoGWIQSH6mbKkWx2m5p3OuvvrwpRXS0si1SDEqEIGr
         WqUhPHa90SWx5LiMsr42wSUqK3c3CgiFt4cb9Bse0QnUpvnDF9v6UBsa7ShGIyc/o8hY
         Tl6Q==
X-Gm-Message-State: ACgBeo2GD5m1qM/ddSdTjki/k1n31Knf81by060tRmaYZd6dt213TEZO
        brz+CaPtvF9sURdH5P0uNn9A00QwlPw=
X-Google-Smtp-Source: AA6agR4jL192rwove6vYYrGTACHllK/hCOUHL6kR1Quiw3oBNFFDCg2SvxQi1G3M1tmvgCIugxf6Mw==
X-Received: by 2002:a05:6830:6308:b0:639:3942:7bad with SMTP id cg8-20020a056830630800b0063939427badmr22018527otb.221.1662483761455;
        Tue, 06 Sep 2022 10:02:41 -0700 (PDT)
Received: from grumpy-vm.hsd1.tx.comcast.net ([2601:2c3:480:7390::465])
        by smtp.gmail.com with ESMTPSA id j95-20020a9d17e8000000b00638dd127f54sm6049634otj.1.2022.09.06.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:02:40 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, balalic.enver@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org
Subject: [PATCH v1 1/1] hp-wmi: Setting thermal profile fails with 0x06
Date:   Tue,  6 Sep 2022 12:02:39 -0500
Message-Id: <20220906170239.30384-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Error 0x06 (invalid command parameter) is reported by hp-wmi module
when reading the current thermal profile and then proceed to set it
back. The failing condition occurs in Linux NixOS after user
configures the thermal profile to ‘quiet mode’ in Windows.  Quiet Fan
Mode is supported in Windows but was not supported in hp-wmi module.

This fix adds support for PLATFORM_PROFILE_QUIET in hp-wmi module for
HP notebooks other than HP Omen series.  Quiet thermal profile is not
supported in HP Omen series notebooks.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp-wmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index bc7020e9df9e..f5c13df35af0 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -177,7 +177,8 @@ enum hp_thermal_profile_omen_v1 {
 enum hp_thermal_profile {
 	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
 	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
-	HP_THERMAL_PROFILE_COOL			= 0x02
+	HP_THERMAL_PROFILE_COOL			= 0x02,
+	HP_THERMAL_PROFILE_QUIET		= 0x03,
 };
 
 #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
@@ -1194,6 +1195,9 @@ static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	case HP_THERMAL_PROFILE_COOL:
 		*profile =  PLATFORM_PROFILE_COOL;
 		break;
+	case HP_THERMAL_PROFILE_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1216,6 +1220,10 @@ static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	case PLATFORM_PROFILE_COOL:
 		tp =  HP_THERMAL_PROFILE_COOL;
 		break;
+	case PLATFORM_PROFILE_QUIET:
+		tp = HP_THERMAL_PROFILE_QUIET;
+		break;
+
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1266,6 +1274,7 @@ static int thermal_profile_setup(void)
 	}
 
 	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
+	set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
-- 
2.34.1

