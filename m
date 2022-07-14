Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C179574130
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiGNCDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGNCDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:03:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C15F51;
        Wed, 13 Jul 2022 19:03:40 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso1089823pjo.0;
        Wed, 13 Jul 2022 19:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbXWRxkBF4v4bahA1QQdo+LHzdrxElL+2e0ry4cAShE=;
        b=ZRXUZjNwJF02iqB+QYx3KKKBSUmaAYDvKv3WDoXuqEsf7/r7wHWCh/pjHE/1/cQfyb
         SIlfjMxT+QX922D0YdBWjdJbdo/QQlAss9ZqfS1A9aIh9/8A8wsY0t8uN6o6vKmNsxEm
         ueGsDp/LMhzEfxf3regO105BaZyTeC4XOrZG8IJxRzQM5m6DkMGGiToUOEF5o2qlbygc
         gWAeDJjJKDCdiLcrLzKdrurhbScBQEgR7s09p+4Ynif7z78xYkywL6HArsEEEQjobLZ7
         RL/yI296SdOFN0diRQbCilPctIJcDMDS5SEoS1x+gHWZv9Ria9LbpzWMx7pj5h98BG6h
         hBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbXWRxkBF4v4bahA1QQdo+LHzdrxElL+2e0ry4cAShE=;
        b=XsfzOTeMSzAAgyqyvTvfI8nOIow1KYrKMw8CN10ZmViP3CEi/2JRd8bttNf6Dku+JO
         NV2vzrWB/g7PO5dzQxED/7Ao0WnmEdl+gjBfcQhmPfru+dylX4pkqK/Vi4DKkW0i4MPz
         lq30Q1dRdDvpumSisXVXg0zGQYJGKI20Jzo1NpVWNrVHmsvShglqJWW1FiWkNk5+nJyf
         L3aXRG9r2N3Nf4OfLSfpn3wAxKdOKSSiK/IJbIgb8MnxxZubVi2Ple0j2saSUvxBfV1n
         4RtaH4hfsvOcqwBu0IGRceYxYQTh1TMCcN47TsdP7u9ZRaHt5Uk+l6jNCWRe+QP/07Bh
         UvRg==
X-Gm-Message-State: AJIora8xUECoHUY26iRCSTmc3p33z34ULWoBmTzm0XIjS20AiEksCGFf
        4Zd76CYCxYCfgVe6VDEfimHd2vzgaMg=
X-Google-Smtp-Source: AGRyM1sZO7MsTMaKbjcD5sn5BbFq049du3/CqLIxnCLFf10yICu7IDGGOaiJNsW3udx9kQUghOqs9Q==
X-Received: by 2002:a17:902:ce88:b0:16c:1b1e:71b4 with SMTP id f8-20020a170902ce8800b0016c1b1e71b4mr6148710plg.153.1657764219481;
        Wed, 13 Jul 2022 19:03:39 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id i137-20020a62878f000000b0052542cbff9dsm230886pfe.99.2022.07.13.19.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 19:03:38 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com,
        andy.shevchenko@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 0/6] gpiolib: cdev: code cleanup following hte integration
Date:   Thu, 14 Jul 2022 10:03:13 +0800
Message-Id: <20220714020319.72952-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Changes v1 -> v2:
 Address Andy's review comments, specifically
  - Patch 4 move ternary initializer into a helper function.
  - Patch 5 variable declaration ordering.
  - Patch 6 remove obsoleted comment and tidy some if expressions.

Kent Gibson (6):
  gpiolib: cdev: simplify linereq_free
  gpiolib: cdev: simplify parameter in call to hte_edge_setup
  gpiolib: cdev: replace if-else chains with switches
  gpiolib: cdev: simplify line event identification
  gpiolib: cdev: consolidate edge detector configuration flags
  gpiolib: cdev: compile out HTE unless CONFIG_HTE selected

 drivers/gpio/gpiolib-cdev.c | 291 +++++++++++++++++++-----------------
 1 file changed, 151 insertions(+), 140 deletions(-)


base-commit: 7329b071729645e243b6207e76bca2f4951c991b
-- 
2.37.1

