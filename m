Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C744BD195
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiBTUrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:47:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244997AbiBTUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:47:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C597B2ACE;
        Sun, 20 Feb 2022 12:46:48 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id e5so14998204lfr.9;
        Sun, 20 Feb 2022 12:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYoPT4Z7CKQZG/RxZi19Qq6arsiSyAJia5fwuEqEeTg=;
        b=bnploH8suwijQrwbMVg3fvPo8ek8FjJ78WxZMH4xFEpTl/H+3XzbOXqDYDdjucMJmM
         ZQhcYcp4Up6oPFzENNMMPbRIg9vKgkRvl0O0ltpe+Q/gFerRBGvUUW3ghxV6t6xW9vpg
         sy2RGPA1ed9EILRbqQXDmVSo1wuUSABsDLllzipwAyKjvMSV4mJ36JHSASZuQgrBdIkl
         ffrPT0bZBF7Dke6MmIckMH3tUdOu+bds08FChgOE/v185TELtmO8r6qh5fvExSAqUJpg
         na5cR+EHpAuOpWOxSGl2gAixN/eMfWMyGHJoG4jkvXu6JhjVXFr1pQLi40q5a5vnW/SW
         Mpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYoPT4Z7CKQZG/RxZi19Qq6arsiSyAJia5fwuEqEeTg=;
        b=Cq7ax6sQhGoIIu/hOVqh6iD2+6hwx9eDf04G51HQCcbwLw7lIh0LfiNjPLXFdkXCDC
         lFDoUs4rzQd6d7XCjDtztK6jF4QrNW2QvQXIlbWyq4TNDkhQ9CqLd99vPUF8LQq793Rc
         eGO/5EfOB/7hdztNm6yVfzB0JbM1TREn8eoSYpyMwuWW68ZWwJvJKxCStCw41+UoiVNG
         RW++0cAQLjD03XFpyT6ttli4p5syUz5VChdAQzAxJR0aHmPfy8MbjuyeQTT17lurNcRj
         ZDmNRyVDUdzkAXycXCJAGdnUPGVtKpTUA8vEFAbupBpXd/NFU/vZvxvhRuHZyl3lPMfn
         cefQ==
X-Gm-Message-State: AOAM533wawhNqg99ZlOMiNYdt+0ZQwX82/Tbobbvm13luT3AmdjlfY+9
        5GURJiCIb9uVSkYrVsX4iuU=
X-Google-Smtp-Source: ABdhPJy2AsiJXOFIQkabHeV9Ot4ScnYx6th0lVvMfVR9KgtrQJD5mWaAxemvUnRTfuKYKIkg1Q2LDQ==
X-Received: by 2002:a05:6512:c11:b0:442:bdfd:3b7d with SMTP id z17-20020a0565120c1100b00442bdfd3b7dmr11342577lfu.283.1645390007222;
        Sun, 20 Feb 2022 12:46:47 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id o14sm913955lfo.117.2022.02.20.12.46.46
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
Subject: [PATCH v5 8/8] ARM: config: multi v7: Enable NVIDIA Tegra video decoder driver
Date:   Sun, 20 Feb 2022 23:46:23 +0300
Message-Id: <20220220204623.30107-9-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220204623.30107-1-digetx@gmail.com>
References: <20220220204623.30107-1-digetx@gmail.com>
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

