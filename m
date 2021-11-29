Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D784627E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhK2XOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbhK2XOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:14:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73512C09E2AB;
        Mon, 29 Nov 2021 14:42:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y196so15894734wmc.3;
        Mon, 29 Nov 2021 14:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSJ69WXnC1WdVb/bXAkyJh3OPxw+iRBQYM0yKG9SCbc=;
        b=jxpzTHscIrNgspMXiFoVTJk0lBc6o0Zapq0FvaHXff2MvLPuzzp1f6YZtng2TbXySG
         TMwos1nkY+pX15tSV53a9Pg2NvdenlwbkSwMxXEArijQ0btkPpfCO28bpl/5dTLWVFPN
         t0ZeA8HG5XF8EAjNl63KhFZrJTyN7yRVOyIxZRAPjcc9YsH0BmVg8KzoFoi+OdIBCBet
         YBDEDDmgQ3LU+g7KvdjYoQ3dd+YxSgomukiWJIVBhj7t5x5jxN0EM3mKpRLwwaQN5MkT
         8jR/tWxjV8l+mrIJXbUb46ZZz5OI0Kj8FYNLvtc+HPI609Z5R82DOKyXYe3reEWRr7Ro
         zWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSJ69WXnC1WdVb/bXAkyJh3OPxw+iRBQYM0yKG9SCbc=;
        b=nOsa1IVYMs4yLYz8Qmd1nXMQiQ5DnKWHsTft+N7zBenvdC7mGRm471Gn1qjReasxsr
         xg8g3XbbVnlRtCeFU6nY95O6WF9sXAozq+cZKiBb756w4sR7XTkyjxgNR7hUgSuir0u4
         04sSgDKp6jKPuWrJaE3e+kjC4ZOMJdlsonryK1/rN/eb7vJ7Ce8GiDmEenUJEYdVRLbE
         heeh3PuOdfI6YLzADhztvjOZLVUyWuuztYetMseeAM8lWu+3rFwbQvld7T/P7z7U7auu
         bQZ+D/vLQ0dVpJnalFOKA5aPux/1HNKen1/pOkrBZgBPK9hgMefeMqZEUmbKOiGG3MOU
         +GkQ==
X-Gm-Message-State: AOAM533VBuhO9RSwpCFORHiXz3ZBASgF6BffAHktQy8qmVsfu/a4S7T6
        xpetWSEBMyE5ydLqzNwhoHht4Q4=
X-Google-Smtp-Source: ABdhPJzCmAftKlAJF7pKfmu2M4+OGjYiKrbAcjK/ELLGn47QwqrbukpbA9WU3WWxGyWtm9i+SJrvKQ==
X-Received: by 2002:a05:600c:4982:: with SMTP id h2mr887917wmp.4.1638225758085;
        Mon, 29 Nov 2021 14:42:38 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a1sm19126546wri.89.2021.11.29.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:42:37 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8195: make several arrays static const
Date:   Mon, 29 Nov 2021 22:42:36 +0000
Message-Id: <20211129224236.506883-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate various arrays on the stack but instead make them
static const. Also makes the object code smaller by a few hundred
bytes.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-clk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
index 8420b2c71332..c2543f4cffb7 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
@@ -326,7 +326,7 @@ int mt8195_afe_enable_reg_rw_clk(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	int i;
-	unsigned int clk_array[] = {
+	static const unsigned int clk_array[] = {
 		MT8195_CLK_SCP_ADSP_AUDIODSP, /* bus clock for infra */
 		MT8195_CLK_TOP_AUDIO_H_SEL, /* clock for ADSP bus */
 		MT8195_CLK_TOP_AUDIO_LOCAL_BUS_SEL, /* bus clock for DRAM access */
@@ -347,7 +347,7 @@ int mt8195_afe_disable_reg_rw_clk(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	int i;
-	unsigned int clk_array[] = {
+	static const unsigned int clk_array[] = {
 		MT8195_CLK_AUD_A1SYS,
 		MT8195_CLK_AUD_A1SYS_HP,
 		MT8195_CLK_AUD_AFE,
@@ -380,11 +380,11 @@ static int mt8195_afe_enable_timing_sys(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	int i;
-	unsigned int clk_array[] = {
+	static const unsigned int clk_array[] = {
 		MT8195_CLK_AUD_A1SYS,
 		MT8195_CLK_AUD_A2SYS,
 	};
-	unsigned int cg_array[] = {
+	static const unsigned int cg_array[] = {
 		MT8195_TOP_CG_A1SYS_TIMING,
 		MT8195_TOP_CG_A2SYS_TIMING,
 		MT8195_TOP_CG_26M_TIMING,
@@ -403,11 +403,11 @@ static int mt8195_afe_disable_timing_sys(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	int i;
-	unsigned int clk_array[] = {
+	static const unsigned int clk_array[] = {
 		MT8195_CLK_AUD_A2SYS,
 		MT8195_CLK_AUD_A1SYS,
 	};
-	unsigned int cg_array[] = {
+	static const unsigned int cg_array[] = {
 		MT8195_TOP_CG_26M_TIMING,
 		MT8195_TOP_CG_A2SYS_TIMING,
 		MT8195_TOP_CG_A1SYS_TIMING,
-- 
2.33.1

