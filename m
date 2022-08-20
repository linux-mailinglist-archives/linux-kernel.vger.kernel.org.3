Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0D59AC01
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344164AbiHTHSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344125AbiHTHSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:18:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34792C6978;
        Sat, 20 Aug 2022 00:18:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 2so5851531pll.0;
        Sat, 20 Aug 2022 00:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UVlXPIqbQg02ChER46P6UD1TtAv817U4yKmxStFtpNo=;
        b=qT0e1xG0h2edkrLDl8PaMtsJUkpb3Mo9rJ+IslBNWlb5+HdEVyryeU6YrrT4UOvbmS
         mdw2GYJzN8VWcfLZexXCTCA5S8KKzojXcWIcypw5nNDLFiP+GchUrFs2DJ4OrlPN6OXi
         AbCkQSzSaQXa1nXDKZyJ2lHIeF7mno5swuScg2/nJM1ajZb9QS/W1Nq/+Rk9F2xV6WBp
         lk0PUDcdlUVqQHOc1omr2JwuLuTkpDp0REay18ZVX3K8wwfYM9+jl6//jc4Z5ne2slY4
         Y8W+6C99CTCEo9jfYFP9/KEXgkr8sp8w+QK/TR5bhU/ogE3FmPYxD+PHWc8k9zNIwqmP
         lTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UVlXPIqbQg02ChER46P6UD1TtAv817U4yKmxStFtpNo=;
        b=pgTZC9y18m9bdGGx2vgpQUlwsifC1rfLI1lkper/ltEIQLCDtAVe/DCMVBNKlIUTyx
         q+6xGppLFbsZKwUxcg+YR6y+zAlrW6I6FkFnGU0OojnEd2haxhPi/B9TX0cQH94B3cfO
         Jl3FaetqTeCQnljn4rbgdEMnUoxEsa56MaPegxbId8cAuYv3p2Te5ajeZPfGnJ0vpQ6b
         5UbBkKlfrGIhMgIafukpRa5bUEdlySt0sgq6DuSUKwKcZSaFF+vnSslUTECwUxZykFRJ
         TrXrDrUnSiyaWIxbFNvDo6Ci3HPdJJuXPgtKDEnslBSNExIMcc64UjkhBkINZyR7LwDH
         uQEw==
X-Gm-Message-State: ACgBeo21+mnjRftQnWaU12rkbqFGiFREAZg5gp1a+NcLXRYxdLJpXt9e
        Mx83qIdU1lzT9Q6CVjiHdt9d6Ayzoa7I8RiRiNs=
X-Google-Smtp-Source: AA6agR7ymADVZDxsBUTK/13Aqse5MQRxA8+cSckmzbdXcFfJGA84NWxfs2lPwNjJPRMG631LGqj/Lg==
X-Received: by 2002:a17:902:f604:b0:172:75a4:33ea with SMTP id n4-20020a170902f60400b0017275a433eamr10725001plg.7.1660979879913;
        Sat, 20 Aug 2022 00:17:59 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:17:59 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 07/10] ARM: OMAP2+: Select TWL6030_POWER for OMAP4
Date:   Sat, 20 Aug 2022 12:46:57 +0530
Message-Id: <20220820071659.1215-8-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820071659.1215-1-bavishimithil@gmail.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <contact@paulk.fr>

The TWL6030 is generally used with the OMAP4.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e4fea50c3..9af3bd488 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -144,6 +144,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select REGULATOR_FIXED_VOLTAGE
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3
+	select TWL6030_POWER if ARCH_OMAP4
 	select VFP
 	help
 	  Compile a kernel suitable for booting most boards
-- 
2.25.1

