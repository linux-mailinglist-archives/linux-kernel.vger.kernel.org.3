Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B740A572AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiGMBhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGMBhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:37:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2F4CC7B8;
        Tue, 12 Jul 2022 18:37:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x184so8974809pfx.2;
        Tue, 12 Jul 2022 18:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiQw5xtWuVb3JEhTrsrjdizSo7y5LocTHKSFxPGksMg=;
        b=TPFErudOTtoJgISHaUQ/3LR5PKDTeM90Vn/UaSOhEK+AbmmKw1hcAy/aXR7JZNOcjZ
         FTG1J2/8c4+GfVZN+N5b8fU2z/WhoYuu4DmpVD9ZtY+1FLPPEeQqAhKYkJrTFD1qbC7S
         cOofUdALWa7zqWJqHkxwZiFuCqRIPSxPjEjBL0FckUh294gMNN2g37t1sNdDxB1Qneno
         D3qsDQNQoKe7v2t0jNNcLRx5dApImFdLnNfoN2DTSv8paOjhmqxGaBLbgLQzJxOaSozC
         +ZDe8b1VNm3yrotuplSsnieHqVrd/7rIgqxjW9vRwsr3uV7eF813VdiTTfvDA1isNvXj
         nOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiQw5xtWuVb3JEhTrsrjdizSo7y5LocTHKSFxPGksMg=;
        b=IJMfQ/rTT3l6l8sGgc38rglyI8QiHtvNXpZsEZ0Ml2oWICZL7ItC5sPDaGmcUPpMQR
         Q67GxXn5csx+y5u2LAZVn8ezGwBJQ1obExTh61AOvJyBCbuExI39zn8yE06HmKgT7ort
         F2FQKqvS325bzpVxi9ag4F8x2rMLsOjdjANE2cnOJ5le6UlzBJSBGF+rNn9itvqC0zlj
         zrSRgYGwm2XYWe/RBypeB1Kl5seUj7Iv9edidgoIvMaZ8JRH4ElB5IbxwRBaDugAPmlz
         vjVAlLw97RK+1RXFHTw7p77zREVYnyeWF/R1dquF9UDa7rcVesyIa//w08gXQzWpX6g8
         LfEA==
X-Gm-Message-State: AJIora8brq2SYvcvcx5HNR7vO90H45XmJCzWCrlGaGem0tQnw94fLgWY
        8Q0Q9tRWsKw297UmBMwtEzI06+ObjFM=
X-Google-Smtp-Source: AGRyM1t7vou/o6yVAGmZ7XUH7M7BbEUBUIpNHocMrML58WMWtkEiK2kZUU0ybJQ/M6LG8Ih4jjiaag==
X-Received: by 2002:a63:9049:0:b0:412:b11b:c630 with SMTP id a70-20020a639049000000b00412b11bc630mr913236pge.175.1657676255832;
        Tue, 12 Jul 2022 18:37:35 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id ob2-20020a17090b390200b001ef76dbae28sm225879pjb.36.2022.07.12.18.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:37:35 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 0/6] gpiolib: cdev: code cleanup following hte integration
Date:   Wed, 13 Jul 2022 09:37:15 +0800
Message-Id: <20220713013721.68879-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a collection of improvements to simplify the
code, improve readability, and compile out unused code.
There are no functional changes.

The first patch is a cleanup for my recent linereq_free() fix. I
noted then that the edge_detector_stop() could probably be safely
moved inside the line desc check block, but wanted to keep that
change minimal just in case.  It can be safely moved, and so here
it is.

Patch 2 makes use of an existing macro to simplify a call.

Patch 3 replaces some more if-else chains with switches, which is
more readable (YMMV).

Patch 4 reorganizes the line identification code to share code
common to alternate paths.

Patch 5 consolidates a number of separate flags into one.  This
reduces code complexity, simplifies any future edge source additions,
and makes patch 6 significantly simpler.

Patch 6 totally compiles out the hte specific code when CONFIG_HTE
is not selected.

I've based this series on gpio/for-current, as it requires the fix
patch -
commit c8e27a4a5136 ("gpiolib: cdev: fix null pointer dereference in linereq_free()")
Happy to rebase if that doesn't suit.

Dipen, I don't have any HTE compatible hardware to test with, so
could you check that this still works for you?


Kent Gibson (6):
  gpiolib: cdev: simplify linereq_free
  gpiolib: cdev: simplify parameter in call to hte_edge_setup
  gpiolib: cdev: replace if-else chains with switches
  gpiolib: cdev: simplify line event identification
  gpiolib: cdev: consolidate edge detector configuration flags
  gpiolib: cdev: compile out HTE unless CONFIG_HTE selected

 drivers/gpio/gpiolib-cdev.c | 286 +++++++++++++++++++-----------------
 1 file changed, 149 insertions(+), 137 deletions(-)


base-commit: 7329b071729645e243b6207e76bca2f4951c991b
-- 
2.37.0

