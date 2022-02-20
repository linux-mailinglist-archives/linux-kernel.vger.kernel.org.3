Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5B04BD19C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiBTUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:47:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244996AbiBTUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:47:10 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146C2FE2;
        Sun, 20 Feb 2022 12:46:48 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p22so15047131lfu.5;
        Sun, 20 Feb 2022 12:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IO+00ag5H9UgwgXh7Y6aBKhP5QDoKDBvcFLhd/QJUA8=;
        b=fyfOOXRdPGTT5ZYvkvU5TtenqAFALurr8qi+olhrifwiYRgjJY1Vwgptang0GK6nmg
         eX0QM/ufrK6yfIsGVG5lpplkLVwKWejdrmFkz32dgivE4q8WNi1ER2XNWIaSHLs7AvTx
         hUQNbvdakNwbJlo0mrBxo862eLqw3kbqHQKNoLhVptbcGMMxtefmSnWIJNWXhrBj0zRj
         T5ejJvZ5Nx6kSGMnz7iqJCqB+RyJVfT+ExzfEPuRfERv79bRfkc3Ow5F68VhZiEbD2DB
         mFxdZylhUJmPzwl4N8Zj+ipC3S5hAZQKNli/DFWFDjsbTDROHg20M2P2C07I9Bkd28yq
         RD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IO+00ag5H9UgwgXh7Y6aBKhP5QDoKDBvcFLhd/QJUA8=;
        b=6lORaegjIb6ehV5Swsz8PnhPnxdssJnQolSYrT+fpiWr3DjzVrylLNYQCWMgq7+rmm
         jgPKmqFN8rHtBxEgQFLm4Nz6eYzDXm7CikRgp2ckNBFoTowYce4bJqz92QBBkFnoymOI
         bSThnHSaICPKH12bpIs/eDEKuZntLa5T1qwvQjXQIYcpzxveA64OwjasN6PfGuDDo+zq
         XQn5wIyK/1HjDnVX0dUkW2adZnSckiK3WeIKDuN7GH/iJT+40kiThrIlHsbyBbtVZhmK
         MyTsTV0td8QWikDJsTuI2O0IZCAL3nxoRFwqY6Uc3RwXC6OETG7M4itgM2qFNl50T76n
         +/ow==
X-Gm-Message-State: AOAM533zXHQy++1nbzrExunRlIu28udJz54kvRTPrzYueKqlXBMfYioV
        6ecGwx/svJWbKZMjdpge5qE=
X-Google-Smtp-Source: ABdhPJxmtfvx9srmoCc5Rw2k0UiFsSVC1z4t3pMwp/n7gS0DvPedg5hR/F67LM7wre3eN5NpMvsn7Q==
X-Received: by 2002:ac2:4ac5:0:b0:442:c5c5:14b6 with SMTP id m5-20020ac24ac5000000b00442c5c514b6mr11634135lfp.19.1645390006432;
        Sun, 20 Feb 2022 12:46:46 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id o14sm913955lfo.117.2022.02.20.12.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 12:46:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/8] ARM: tegra_defconfig: Update CONFIG_TEGRA_VDE option
Date:   Sun, 20 Feb 2022 23:46:22 +0300
Message-Id: <20220220204623.30107-8-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220204623.30107-1-digetx@gmail.com>
References: <20220220204623.30107-1-digetx@gmail.com>
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

The CONFIG_TEGRA_VDE has been deprecated and replaced with the new V4L
options after de-staging of the tegra-vde driver. Update the config entry.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index e7385c10a30b..0a39033a5c6f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -298,7 +298,8 @@ CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_STAGING_MEDIA=y
-CONFIG_TEGRA_VDE=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_TEGRA_VDE=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=m
-- 
2.34.1

