Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337C54BD064
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbiBTRdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:33:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244364AbiBTRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:32:33 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD638D7B;
        Sun, 20 Feb 2022 09:32:11 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id o9so11491535ljq.4;
        Sun, 20 Feb 2022 09:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYoPT4Z7CKQZG/RxZi19Qq6arsiSyAJia5fwuEqEeTg=;
        b=qvROLuhzXHAvpOjVR7palKoACWhkVigTt/i9NcZDHHqbZ9NoBHzEPynFCe8G8GdZfF
         XE8x3aV7YYd+AEp2QhGKPO70bVkBgYh8REhh5pDAFm+OPfYjfxMINYxTGqCA1fuKhyPA
         VJ4S/hJk+dQ1MLKfe29BeotDHFB0X2OOdAbo3lsLkA7gAOaXlVAnAmFSPMwD1t0yOZpL
         emFTr5H75ESBZWm5KIY59Zl9hXlX/iP7zx5tjMNJbsJzAQFbZ3Ef4o/pQLeA620kt83i
         dL9l1zIEhP5BltwxBym6eiUpEaQgHVyz/aI+A1SnHshW+ZikrTLjDY0Ti9wW/SD2pykW
         WHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYoPT4Z7CKQZG/RxZi19Qq6arsiSyAJia5fwuEqEeTg=;
        b=ZWwYG+uWViFqjsQhahI0QwCu4OOmqp2f9dnH0T8TFpiwh/ipyA9QTO6RjGeBbUlrM+
         bx5ExDgm6EDiflB4dggVMLwag1AIFqy58GBIh+cYV30yMDA23yjtNV/BIDNIWtZgaWjs
         5XDDxe3Kfz5nZmR70mxItvp6K7GOY+jie4Ki4qQLgxWiu7z/L61VZ2VdWBQp0lVirz6A
         uIYeeB2yNBO7tfphziFdIIXR5H6a/DFxQCMdLHF8RaCrDqv9Vr1XOf5IORpjKTvb2j9m
         hlOfl7lC54ih/zlEI5Q6yhYKzA1ZBsV+0CisTxgnf2rZH6+FVuPbgGZ3Dig+1CNAl77j
         aimg==
X-Gm-Message-State: AOAM533iKZJ0QTRaxLSo/ZYszAQBRVKJG+0K5sj6h5jALm6VX+MdfKgt
        S0S8/t/1cNfOY8LXaAgDxSY=
X-Google-Smtp-Source: ABdhPJy0jHDNiQSjo2siQGsBvcghkwpSTrP8zhgIfLmZQZ0wYfrwBFmVfjDzbpMLDFTURYI2J/VUMA==
X-Received: by 2002:a05:651c:1505:b0:23c:95a8:33d2 with SMTP id e5-20020a05651c150500b0023c95a833d2mr11922301ljf.407.1645378330150;
        Sun, 20 Feb 2022 09:32:10 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id f8sm880490ljk.97.2022.02.20.09.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:32:09 -0800 (PST)
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
Subject: [PATCH v4 8/8] ARM: config: multi v7: Enable NVIDIA Tegra video decoder driver
Date:   Sun, 20 Feb 2022 20:29:50 +0300
Message-Id: <20220220172950.3401-9-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220172950.3401-1-digetx@gmail.com>
References: <20220220172950.3401-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJECT_DRUG_GAP_L,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable NVIDIA Tegra V4L2 video decoder driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index dc0581deea9f..8a360d7f517e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -669,6 +669,7 @@ CONFIG_VIDEO_STI_DELTA=m
 CONFIG_VIDEO_RENESAS_FDP1=m
 CONFIG_VIDEO_RENESAS_JPU=m
 CONFIG_VIDEO_RENESAS_VSP1=m
+CONFIG_VIDEO_TEGRA_VDE=m
 CONFIG_V4L_TEST_DRIVERS=y
 CONFIG_VIDEO_VIVID=m
 CONFIG_VIDEO_ADV7180=m
-- 
2.34.1

