Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FFF53C7B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbiFCJjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiFCJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:39:11 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EDC3A5EC;
        Fri,  3 Jun 2022 02:39:10 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id u2so4782804iln.2;
        Fri, 03 Jun 2022 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4F0qudayc+M93j//60ABCGINuGmdSDmE1k3s0/tpIY=;
        b=ptoox3EvR5d8yx7hbII4t2fKA+Qr9RtMCdevGQjv+qch0HSQMaD8+vIjTdhK9Ilagx
         Cbbmd6pw16ZyMLSyyugZ+2QwdozoM/8QcKGp0g2akI7dAKiQ5epQdy3xTh9UFJk0Cach
         /5I2gpHS2Ppm/kGMc9fesWp19I8XIXcwYtODTzupBlDX+SQNTVzZNLCYwVP6BTvIrgWa
         +ZVpa0nhY+relt5AdnoDg+0JPX2+rwclUwWxxNytO0LOPOhU24t9LOvuSTjaK7k2fnMQ
         /yP8l1k7r4dMT78VjaE+nggCU7K0p3w/KlqdbEe7m2nZ9xJTdVRmgdmDyj3q01FZkKkX
         surg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4F0qudayc+M93j//60ABCGINuGmdSDmE1k3s0/tpIY=;
        b=MrcIvJZpJwlfqIKPIbo40Ddr1x5aTxIA4wSKyb5gHjeA78egNEtb/gC3YB1idhr5zr
         +YHFmelZHPA0C3sx2CxLLlMK9ZEvE17xBQUQx1wUZhl5bnaO2ekQ1+g9/fjDu8RL/J48
         kG27yR71YeVGaE9VT8qdLquc9sRaGkgBAn4If10QHieopp4IZBzWkVXy/273xrOtVKzy
         2Ng/LGKwhDMJcSUebrq3J8o7rowUo9ZtTYphOODmKxO4cdbiB5W5SbQFR3prhWdWxSqS
         rqTUKPmmxDE4N+FTyWPiAztqojBtPPSj479wKa4ULh9fMiLZk+aS7H4zeWKNKexOhBKX
         x7+Q==
X-Gm-Message-State: AOAM532alfISIrHex814Y0YvrBJfsIO1voRB1CWEY3g8N6KjC7JMKhQB
        iFeN4HYAYRmpFiUV9gw1R2tCcRzup4Kf6/2j
X-Google-Smtp-Source: ABdhPJzFjjxHNNWgJiTr5xAqufCU8cGVjPYvArJY7s9M6OZ/v86cLSHUBr5C1Fsuiht12lQ9uCQKlA==
X-Received: by 2002:a02:1986:0:b0:331:5c52:5b9b with SMTP id b128-20020a021986000000b003315c525b9bmr5222552jab.69.1654249149977;
        Fri, 03 Jun 2022 02:39:09 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id w69-20020a025d48000000b0032e2dce10aesm2314800jaa.160.2022.06.03.02.39.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2022 02:39:09 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     ndesaulniers@google.com, masahiroy@kernel.org,
        michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, Schspa Shi <schspa@gmail.com>
Subject: [PATCH] kbuild: Allow to select bash in a modified environment
Date:   Fri,  3 Jun 2022 17:38:52 +0800
Message-Id: <20220603093852.13818-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

This fixes the build error when the system has a default bash version
which is too old to support associative array variables.

The build error log as fellowing:
linux/scripts/check-local-export: line 11: declare: -A: invalid option
declare: usage: declare [-afFirtx] [-p] [name[=value] ...]

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 scripts/check-local-export | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/check-local-export b/scripts/check-local-export
index 017119d89cd2..2defd0bf3552 100755
--- a/scripts/check-local-export
+++ b/scripts/check-local-export
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Copyright (C) 2022 Masahiro Yamada <masahiroy@kernel.org>
-- 
2.24.3 (Apple Git-128)

