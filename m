Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA70510030
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351522AbiDZOSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351504AbiDZOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:18:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C710FFA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:15:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g19so32214051lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5igpQ4+58x30NEuf8p3ZClVfpP7R6adkl+B0PO3RM+s=;
        b=Sljc6axvqw0XWeN52OEIVzhwmuI3qvh3ELsWRZlLvIA8vnOSNGxgf5fZAxXE53/0Y/
         mfToiz2g+Sf7MSAPO2zTiLDWlpityvGqwiNwjP2vCHz7DGL71NPXiSPr9Q/L0+LWmryq
         NDVPI4XhtEv2XXuFeWDegT+ReEYDPq5U8VRAdpyB3ARRl5ZMCczzwuQQ0w+czWWXQXW7
         UQS96kLxa2WrPco6ljBrU1L5npvysddvCkaO0SERMzSbjSNIPEOezeE1gsAk0QwY8lcc
         LhNKFMyGlstDyUjEGCQLQCTEh2nADDXLroH5r0ZrSAVlaPdY2tZ++yCLr+mv72Ak4PuH
         GnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5igpQ4+58x30NEuf8p3ZClVfpP7R6adkl+B0PO3RM+s=;
        b=SqLPfRmwFJYbCeYf3E2IDFT2qnnJ25TNmi3JthoKu76uqKxUZ9+JCh25XumagjNyPX
         f0DRx+eHCWQk3QnLx7FZtiSM9xTi/7/Y0LbNZC3+o8HZKGpY+EhTD62GiFRRf/1gQKT6
         y0OPOQ5BLT1qNCurqZv4ah/Pi2EonRkwDA4cayQ2S3hh7rW4AFJFvsnhpllrIaoxFkmh
         kEPUzOtvSFsrOkfg9W+Fv7q8O6otNbsNBHPzpkPW+tWpNv2ZU0JS1qkOjtRZNvojH1ZC
         5sz2GMzUBtmR1bYmTgBbrUKGl5pNXeWU50P8AgXJoJxgLuT382t5W0CwBIlf4ZbiWg4N
         Qj5Q==
X-Gm-Message-State: AOAM531d7c/n6jQppAszJlVBDFxeheakGuRuuSxwv2o6qFZF0JIOzHq8
        cdei5pt5Qy2lbZb8m/ZsRDG9VA==
X-Google-Smtp-Source: ABdhPJwU3oGW/UlwxXr4jTVGYymcQtQY/xV0FDxikSrsdZH710NyFU3C4/61bf8yyTBw5C2SuRrVHQ==
X-Received: by 2002:a05:6512:1194:b0:471:b0dd:8755 with SMTP id g20-20020a056512119400b00471b0dd8755mr16062966lfr.212.1650982517515;
        Tue, 26 Apr 2022 07:15:17 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id g23-20020a2ea4b7000000b0024f096abebdsm1043360ljm.78.2022.04.26.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:15:14 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PM: domains: Some minor improvements for genpd_power_off()
Date:   Tue, 26 Apr 2022 16:15:04 +0200
Message-Id: <20220426141507.89868-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series intends to improve some of the execution paths when powering
off a genpd. More information is available in the commit messages.

Ulf Hansson (3):
  PM: domains: Add GENPD_FLAG_RPM_ALWAYS_ON for the always-on governor
  PM: domains: Drop redundant code for genpd always-on governor
  PM: domain: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd

 drivers/base/power/domain.c          | 10 ++++------
 drivers/base/power/domain_governor.c |  6 ------
 2 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.25.1

