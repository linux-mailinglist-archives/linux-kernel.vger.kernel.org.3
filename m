Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6244AD3C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351288AbiBHImz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350732AbiBHImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:42:44 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83BC03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:42:42 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t14so23372295ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sXih+ccMxcBT8wCEbMO89tjHCwmk+TU2IW/0GU1YNk=;
        b=xMglItI55LyHwpmXQT9i4/capUmQ/SyZQhS2ZQe4/yss+9baUfxpl12RZOkkUW6UV/
         4HSga1o/zvckGlgofr3fjrpXMQzELQlpiDrNiO157uRtYaqpkvxNvu+8zX3bJhuGMzLq
         vFSNYE2of3XjzCoL3ZpxzFL0hFce6VPr3kEiiaTHsNCgUWhm4c0I3u6pDnia8W1c4ZA+
         8qPIsrEBjf3XsuA5pKW1Ccau2ovabd/q8H0ihEE+xIhJoZxpEn5MfbnyUbcReEc5PgzL
         83/QZrF9Xqs+warW5FjW5t+KggMqEV8WeckAUhliMW1GxxA0hmPHwRypkxtJMaL06uA8
         fE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sXih+ccMxcBT8wCEbMO89tjHCwmk+TU2IW/0GU1YNk=;
        b=4s+EU3YLLl3/FyszsHrK7ZI7mpy8XyTsIim4dCtF1L6DuUbfRbYRkuf0IBjqRtahWW
         SGZfRe2lSyoV0cwpfCTjgsn+W4Iz+ovEoBI5FlqNL+CYzUnE/wbqNcqI4yPL/elZFlGP
         nxDfa30QroEZ9P1uc6Q/cpGuvlcpLDt8cFZXEcPrVRN6se7WoVsl6yg78FjHiZ3AiqlW
         3/RxuJBzYmZJjnnAGjZ7fdd40U/M+7EQXvWo0rSEDEm7ymF240LWToDULU7Yd4HZDF1f
         9pYq07j7xLOZC7Hre6dYBa98rW6zo7p+9CsbuCfidupWfdMKGdQ9SVFaCLcRa2ed+pvb
         pBfg==
X-Gm-Message-State: AOAM531GaGtHjuYKb9V9USr9v7HunDF3NaqoXmaDGotqKDY0FyIB9fsB
        ilBgvciKYMLeIVUshzwBX+JzKQ==
X-Google-Smtp-Source: ABdhPJxj3u6KYnR1Lph70mDUde0CqcWPX+n/2AA8smx6d6xJkBjAYWrLPu6pDbFJHGQjQ5BzunD3dg==
X-Received: by 2002:a2e:95da:: with SMTP id y26mr2206876ljh.203.1644309760597;
        Tue, 08 Feb 2022 00:42:40 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id o12sm1830361lfu.96.2022.02.08.00.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:42:40 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 0/4] ASoC: pcm3168a: code cleanup
Date:   Tue,  8 Feb 2022 11:42:16 +0300
Message-Id: <20220208084220.1289836-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches clean up pcm3168a driver, without introducing any
functional change.

Nikita Yushchenko (4):
  ASoC: pcm3168a: cleanup unintuitive mask usage
  ASoC: pcm3168a: refactor hw_params routine
  ASoC: pcm3168a: refactor format handling
  ASoC: pcm3168a: remove numeric PCM3168A_NUM_SUPPLIES

 sound/soc/codecs/pcm3168a.c | 150 +++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 80 deletions(-)

-- 
2.30.2

