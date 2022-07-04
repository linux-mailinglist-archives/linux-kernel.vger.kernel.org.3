Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E734565527
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiGDM0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiGDM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8374FDF12;
        Mon,  4 Jul 2022 05:26:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dn9so11190171ejc.7;
        Mon, 04 Jul 2022 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y9fLCoDjX9rrrX0oj8XNyUYP/ZsreaQRf2qQi5uPknQ=;
        b=DRqfY6JbMfATouOPsUSQNEfx9Kyw4a43y9Du5iP5hmsEZ0wfcAURzG7iGGTHbc4M9y
         DoTRKPCdktO9x/jkN3XSnm3lVxnmWtD4vikqQlJsiLqkiIwurhyG+xorC4GOpYFZ7fDi
         WoyvjPrEB8vU0VxGrDARk93NSRS3xdgQ11DHGdehpmc4oRGgoEVukL9K+CpIJko5WANI
         GD/7mQJcjgKIh0QKkrFEFuDOViaJeJaaYu81XfLTzl4NtE0c/ksjcBTpqeJvNDClDPJD
         pdgUft/y2y8lLMB6foakioE158pIwXvPIWi7GR1mkbGMWoxMTVC3fk1A917ReCXx1Qsh
         2mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y9fLCoDjX9rrrX0oj8XNyUYP/ZsreaQRf2qQi5uPknQ=;
        b=Xbwy3u6e/SeyzbP0S7gl8zjgdjQAb865fGRitFNUOEseGqmKW6/Zrn3IsbY26IfNMX
         Mrgw5pgOoGBs/161RXVePumCH3DY1Uhyvfbds8Q+pT2pHtaZseH9WCW/AnEAx3co9gTy
         cZ8jifFa4PSOFgZJlXOomJcjP3qga/hCPn+X5yVI4Ohm8RsSW+sLUmPFy3KtN5o0+h8g
         xkf9k/wZSfiYHuVp3Ja9YCUMbwRGPQ8C1PZozwrBQ+0SCyF4a8t+ddWdbhrmUDk7cliO
         dQnoMfyy4dugl08I/mNKZ9hejLHyig60Z4dPGe0F5yrmko3aNaWUVNtW0s/5rp1nz1Df
         AVIQ==
X-Gm-Message-State: AJIora8RDNSXSnDmVw6S6j9Y2U9WbMfRzVPRaJyhFcZk5WVmi+pYY6In
        UFzVlKF/zQehQKpagff6gyU=
X-Google-Smtp-Source: AGRyM1sBsBxCmp/Zz9ME8e+BnQgqaA7vLFEcrkEnxfIM+oKL0HB2aL8D9yvw2BvCCT5cqqyYhVPorA==
X-Received: by 2002:a17:907:7da6:b0:72a:cf40:13e1 with SMTP id oz38-20020a1709077da600b0072acf4013e1mr2183621ejc.343.1656937583068;
        Mon, 04 Jul 2022 05:26:23 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:22 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 04/11] docs: kernel-docs: add a reference mentioned in submitting-drivers.rst
Date:   Mon,  4 Jul 2022 14:25:30 +0200
Message-Id: <20220704122537.3407-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One section in submitting-drivers.rst was just a collection of references
to other external documentation. All except the one added in this commit
is already mentioned in kernel-docs or other places in the kernel
documentation.

Add Arjan van de Ven's article on How to NOT write kernel driver to this
index of further kernel documentation.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/kernel-docs.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index b2523267ffc7..502289d63385 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -134,6 +134,20 @@ On-line docs
         describes how to write user-mode utilities for communicating with
         Card Services.
 
+    * Title: **How NOT to write kernel drivers**
+
+      :Author: Arjan van de Ven.
+      :URL: https://landley.net/kdocs/ols/2002/ols2002-pages-545-555.pdf
+      :Date: 2002
+      :Keywords: driver.
+      :Description: Programming bugs and Do-nots in kernel driver development
+      :Abstract: *Quit a few tutorials, articles and books give an introduction
+        on how to write Linux kernel drivers. Unfortunately the things one
+        should NOT do in Linux kernel code is either only a minor appendix
+        or, more commonly, completely absent. This paper tries to briefly touch
+        the areas in which the most common and serious bugs and do-nots are
+        encountered.*
+
     * Title: **Global spinlock list and usage**
 
       :Author: Rick Lindsley.
-- 
2.17.1

