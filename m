Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6474055DA13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiF0I3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiF0I3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:29:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5F625B;
        Mon, 27 Jun 2022 01:29:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 65so8279608pfw.11;
        Mon, 27 Jun 2022 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukkF+qHOzzJMvCgB5J2nCt+SiXX4tns6CZy4txdYFbU=;
        b=XxyEOMZwFzVx5EqLSOdfvMnVEC1pw/bEOwoadIsKwf1nVcHANtQJ22GQmY1QPa/0n/
         fx7Nqz9oO4lusnDOnJQq/hBe0NL62WNXNxb2FVZKsAGwv7jjJl6KgArZ5IuCfU4WtYrk
         clOJhaaue+7migoHXRwutGvYSWZXu0fPYEe9X6VF+sQT2ulz7yn9PeutINSUiZ5kw7Z5
         295/GFrIzBjTkxAcs4s+iMb9rerAqOmbWJ1vG70DgxWYzx7Kg8ZEWYkdd1t8/e7o8fOZ
         OIbccFFmOvAVQGWX11VoQl8Timd35Qy3RvBGIWwPnO7YZAzwkZXdiOXMT9kG5f1hpfdz
         V75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukkF+qHOzzJMvCgB5J2nCt+SiXX4tns6CZy4txdYFbU=;
        b=cfxkCd+NLvKNwQt6BZ+BD8e1/FYfjTU/Y4GD3VXuvNjEY2lhsM8tzY94SyxKVM6E0h
         /miGbysuLgkArtlluVMQMbhMJM4sC751Jrdr10LwU29vgxsryDvo04uaPbJMZYhYjDQs
         1YkxinOVgCxW7gHHI+9iSGpwDag23dYtbbIP+DnTwI/Zpf2E6z45VcIJmdvt4niHDvec
         jMtqeYPkHjP7/3fyYQJtFpqy47dvD11tIM7QPE+qiG+P9WX8nbD3ezBKPgKwcduiXElD
         Hcyetd+veNLNw4ae9BRr2Z6XGQPTF3PEv2XxASiEXgGrrlvIqs4K+AuYMMuCEu/72LvI
         2E3Q==
X-Gm-Message-State: AJIora8XpkWgrz+Svd7GyO3srs7GyEgCzWCVp59mUpZbYvhfygnLL3Ac
        3pNcK3HBIc7sIT/iv++gm7U=
X-Google-Smtp-Source: AGRyM1t5rT9Mx8i6fAAE3TL6UtytoFVyXcLJMuFRwjYYPjWjgJuidF7BRMqT7CWr0IQsni4W0A7WMA==
X-Received: by 2002:aa7:8e9e:0:b0:525:1d15:8fb8 with SMTP id a30-20020aa78e9e000000b005251d158fb8mr13469032pfr.35.1656318576800;
        Mon, 27 Jun 2022 01:29:36 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id bf27-20020a056a000d9b00b0051bd9981ccbsm6497050pfb.39.2022.06.27.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:29:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B3DDC10388D; Mon, 27 Jun 2022 15:29:30 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND next] Documentation: samsung-s3c24xx: Add blank line after SPDX directive
Date:   Mon, 27 Jun 2022 15:29:28 +0700
Message-Id: <20220627082928.11239-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging spdx tree for linux-next testing, Stephen Rothwell reported
htmldocs warning:

Documentation/arm/samsung-s3c24xx/cpufreq.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.

It is due to missing blank line separator between SPDX directive and
page title.

Add the blank line to fix the warning.

Link: https://lore.kernel.org/linux-next/20220614164506.6afd65a6@canb.auug.org.au/
Fixes: b7bc1c9e5b04da ("treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_147.RULE")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Allison Randal <allison@lohutok.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/arm/samsung-s3c24xx/cpufreq.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/arm/samsung-s3c24xx/cpufreq.rst b/Documentation/arm/samsung-s3c24xx/cpufreq.rst
index ed19ce1a462921..cd22697cf60660 100644
--- a/Documentation/arm/samsung-s3c24xx/cpufreq.rst
+++ b/Documentation/arm/samsung-s3c24xx/cpufreq.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0-only
+
 =======================
 S3C24XX CPUfreq support
 =======================
-- 
An old man doll... just what I always wanted! - Clara

