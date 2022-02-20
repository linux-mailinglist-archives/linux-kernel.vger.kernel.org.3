Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D914D4BD057
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiBTRc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:32:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244361AbiBTRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:32:33 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7407D4E;
        Sun, 20 Feb 2022 09:32:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u20so14533238lff.2;
        Sun, 20 Feb 2022 09:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IO+00ag5H9UgwgXh7Y6aBKhP5QDoKDBvcFLhd/QJUA8=;
        b=JpDGxNWG8sLuTXYaiJQxzqnyddLCFDMrLR8cb0x1Gsn2CT+k70tpzV3ThMc3NHMl8q
         lNyeyjUK40m74p/K3qa8zb7zpiDYHVaiMRAXGg3rrwATaf1DKg2zKhjxn5PF70snjeww
         E2TOSbxWtEgcSv17D0ZnApUgjUVuNE+VCsM13nz3x0grKYSZO0YI47ld7/2W0TqBWjB/
         Khd4YUNef2F9Zm5ARfTrcgHm3sfIKJe3nX4REQ/N6NbUKo1G5zanhV7GxxcUcrhESm4L
         9sdseuuiUslEoQkxc7rkGorsr2fGBuLDOwD/tOhdisqbroPlSS/vd+0Sk5DcWDx+cic1
         Ry6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IO+00ag5H9UgwgXh7Y6aBKhP5QDoKDBvcFLhd/QJUA8=;
        b=yphjWc1IPfPLy1edviYC/FV2/4CBAr1bizGWLEZJ75zFBoJTWH6E0/ThRTtzGs6BGq
         REtzWLQH1ntyNSh3PaOYRn4bEwBQapLuz+S47ZHtYVO0/IM/OeSiUdMhQ5Tu5ffRoM3E
         EptNZzQFmQdHGR7/336DfUV0EgGT5TeBIPHqdCcoPtptPYyWNe6BZw3INTHSN+yN1otJ
         WZNqruWNcIoDIF8y4VDk0DSyl+y4vGH3qevYl6nHa/dSlpjVsJ4Kz29LQvv38Bvg1n7J
         5xtrquHupuGBSD1g9PqcIldFmmJ1gXcy0HMKoxEwlY0fEOXjbSCQHm1sFO8e91l/ytT9
         bzdg==
X-Gm-Message-State: AOAM530xHneW5h8WsS1g3pF2lIxEL+xNMGRX6/sfW6JCqxmLOOv3Qu2m
        996gEGaLy61HCN/0Rmyfc8A=
X-Google-Smtp-Source: ABdhPJxknnG7wpUNWgtPYbvVxTvMxVUm5Eh67LiSqNKka33MfIxMc9WagPQFc5eGtyH2/49qgzSOZQ==
X-Received: by 2002:a05:6512:306:b0:443:5e0b:1d9f with SMTP id t6-20020a056512030600b004435e0b1d9fmr11230083lfp.122.1645378329373;
        Sun, 20 Feb 2022 09:32:09 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id f8sm880490ljk.97.2022.02.20.09.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:32:08 -0800 (PST)
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
Subject: [PATCH v4 7/8] ARM: tegra_defconfig: Update CONFIG_TEGRA_VDE option
Date:   Sun, 20 Feb 2022 20:29:49 +0300
Message-Id: <20220220172950.3401-8-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220172950.3401-1-digetx@gmail.com>
References: <20220220172950.3401-1-digetx@gmail.com>
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

