Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C9533CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiEYMk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbiEYMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:40:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B87CB19
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:19 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7DB903FD8F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482418;
        bh=wxP3HgqlZutRyZ4be1K5ovWzoc7v+dNBukvYrue+SPk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=urCriZisG0M774CjGi17JsZLvaX0CibGJb6r2h7fDycAFaql9ydbqjgjjAMcDVaHa
         wPiZO1Skf2pNEx8Li7uqrKP8n1vHhLgUM/FCW6s8XIsgrZcbEBfoREpvCnFY+Uh2vV
         GPTy+5ebtwf83qjgmbvyMuvZJHh8O1mbCDpt8T5usZYZXZbANiUdZea2CQUUvH+mBg
         RGTayfv+C6Kp2B8/+OtCkfQR1g5x0hsc8d5fCkLXVIErz2W5hUV6yAd3Bm4H2f7jxz
         o1RVFau5OKWqfSyd0fGhjWskZ0HAc5HRdHN89HjzVLpv93wxvIpobyssROmJjIbQ3q
         g+E8uSjaelALw==
Received: by mail-ed1-f71.google.com with SMTP id r10-20020aa7c14a000000b0042bcc99e4cdso810927edp.18
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxP3HgqlZutRyZ4be1K5ovWzoc7v+dNBukvYrue+SPk=;
        b=BCr0QLQTmwXlwt+WBAEBCJCrnVdJF9H2qYq5dIEhmgdb7yqR7/oeLYOcZ6vUt70buM
         ZCXkR2Eh6WkBEtLTGtSJMtNtr5EK85Ic3s38YZs/jVgv3LgTaspcIr7KfA+Ty1pF/6rK
         2IY+VOFX0KYn4B8qT93k8xLDmh3Kskus2GX07pm93y4KpmX5OtJL10nauGRUvOCwyCKf
         N3TRuiJcms1GSNcasi5rZ3HhiD/9yKQy0Nah7rOzYHKy5xFYs/sqQ92fYFd60vxBWXbY
         mhbSmnDnAC91whs8HoaQwACdmt8IshogUUL8erWnMqzLqMzHy0t4w20sJDK6lNb5QhyN
         P8Ng==
X-Gm-Message-State: AOAM533mBkZSQLQZwDoF0xfnuJA5czW4yrWML0CnNULEwwF+uSon2Ce2
        igLtg3reP1ZCTb+zkyhXeC9XPbwaUd/FN94NpnBo0M6zGHYnD/uETCtv2+0xSsIE3Y1ECSf6XhX
        axd2DCcjGEq82I2r7W2usckajEXoKo0lhAGjOm58xVQ==
X-Received: by 2002:a05:6402:190a:b0:42b:60b:592b with SMTP id e10-20020a056402190a00b0042b060b592bmr31295063edz.127.1653482418293;
        Wed, 25 May 2022 05:40:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIMAXsEqufeY6FOCVF5hwJzfTKb6LKPU2BWrQTsIhu4mtSwZ/E8Ri0gjrQfdHvSRWC1/8qFw==
X-Received: by 2002:a05:6402:190a:b0:42b:60b:592b with SMTP id e10-20020a056402190a00b0042b060b592bmr31295046edz.127.1653482418107;
        Wed, 25 May 2022 05:40:18 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:17 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 4/4] sh/mm: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 14:40:07 +0200
Message-Id: <20220525124007.45328-5-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525124007.45328-1-juerg.haefliger@canonical.com>
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/sh/mm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index ba569cfb4368..a563211aeb63 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -2,7 +2,7 @@
 menu "Memory management options"
 
 config MMU
-        bool "Support for memory management hardware"
+	bool "Support for memory management hardware"
 	depends on !CPU_SH2
 	default y
 	help
@@ -141,8 +141,8 @@ config ARCH_MEMORY_PROBE
 	depends on MEMORY_HOTPLUG
 
 config IOREMAP_FIXED
-       def_bool y
-       depends on X2TLB
+	def_bool y
+	depends on X2TLB
 
 config UNCACHED_MAPPING
 	bool
-- 
2.32.0

