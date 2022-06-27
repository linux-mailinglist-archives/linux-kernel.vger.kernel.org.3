Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB4755DF94
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbiF0PT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbiF0PTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D437613CC2;
        Mon, 27 Jun 2022 08:19:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ay16so19897617ejb.6;
        Mon, 27 Jun 2022 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qrkTtNr9vkVoaS0GaHbwE3GT2+MGnjzP/retpDU/T28=;
        b=C5YbhQ6t4T37vQSfyF0SsFwnVBI9Lxc+Ze7LKYxlG9iQvUmwZ9nQatsceaJLaKk7yO
         bBI+c39nTx2kQPlPmWJIRf/S/yz+k+g2GkxxnCTuHXITXzB/26zD7v+VOesTs4rF9ZBh
         rfNpKizsJXfBZmWZfP6l+ULE+Fqy79ZjH5R23wuK79fbBy2N3R9FpqXBUc4RXPv/hI9u
         Hr8ER+wmwLnHY7VXi3csS6XGmSTpLOljer5uThNytHeOzskq2RRXM5mSPeGEL8sEXo7R
         gCDS42iUmgCTkrwSQX9xOZ+c3HxX+cFWzT8qnT5Zz6e/WV7B9GsoCVhcH3K3skI/v2wE
         81fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrkTtNr9vkVoaS0GaHbwE3GT2+MGnjzP/retpDU/T28=;
        b=TpBpV8vq4CN2E+6BNbZG8XtBH5o1qkmI1RQtn3COc/RNK8d1iQvdDYN0djNw2kewvQ
         6Vlm9F8FGgLJdUyZwsa2eg5qJwzznNnsowpS5PrnM86GhqCDV8VHeGPep0CGNNLiYtfE
         ExUzfpAynBQyyASFeFTutoQKfqy+YdSpVJY/6v+ER0DEAZjm7RgndnQRPUKX92kJT5rJ
         Cwj5NXblkvFNs0WQLrZpmok1jSpHHM1OeRWhCQxo0uirzVzYploxdI3HwERCIDqg3b9c
         541lK+3krkjLGSM+YTH5g7vasUG5BPfGuIeCWWU8XYQbOIvO4D3fJP1ISXteBbwkB7b1
         9Aww==
X-Gm-Message-State: AJIora/qHWzbKiCiWKo5RtDFtAdmySHNZBnLp49s9cYqAi60FDYjFy1u
        qVzxc5hoZ/4Jf0m9L+w+PFc=
X-Google-Smtp-Source: AGRyM1v0cHWaAH7E7lpWyIGSvwk+KfIIt13RPQoT9EnesD65eWN+G6gYFpk4GD6jpVqj/y3ES5w2cQ==
X-Received: by 2002:a17:907:9805:b0:726:96cf:2bd2 with SMTP id ji5-20020a170907980500b0072696cf2bd2mr9059635ejc.119.1656343155283;
        Mon, 27 Jun 2022 08:19:15 -0700 (PDT)
Received: from felia.fritz.box (200116b826511b0021a0c74157938809.dip.versatel-1u1.de. [2001:16b8:2651:1b00:21a0:c741:5793:8809])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm5076901ejm.107.2022.06.27.08.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:14 -0700 (PDT)
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
Subject: [RFC PATCH 01/11] docs: kernel-docs: order reference from newest to oldest
Date:   Mon, 27 Jun 2022 17:18:09 +0200
Message-Id: <20220627151819.22694-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documents on each section of this document are ordered by its
published date, from the newest to the oldest.

In the kernel-docs.rst, the references on each section of this document
are intended to be ordered by its published date, from the newest to the
oldest. The Linux Kernel Module Programming Guide was published in 2021;
so, it is placed at the top as the most recent publication after the
rolling-version "Linux Kernel Mailing List Glossary" reference.

Fixes: 630c8fa02f9a ("Documentation: Update details of The Linux Kernel Module Programming Guide")

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/kernel-docs.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index da9527502ef0..b4d98f6f797a 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -83,6 +83,18 @@ On-line docs
         Finally this trace-log is used as base for more a exact conceptual
         exploration and description of the Linux TCP/IP implementation.*
 
+    * Title: **The Linux Kernel Module Programming Guide**
+
+      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
+        Jim Huang.
+      :URL: https://sysprog21.github.io/lkmpg/
+      :Date: 2021
+      :Keywords: modules, GPL book, /proc, ioctls, system calls,
+        interrupt handlers .
+      :Description: A very nice GPL book on the topic of modules
+        programming. Lots of examples. Currently the new version is being
+        actively maintained at https://github.com/sysprog21/lkmpg.
+
     * Title: **On submitting kernel Patches**
 
       :Author: Andi Kleen
@@ -126,18 +138,6 @@ On-line docs
         describes how to write user-mode utilities for communicating with
         Card Services.
 
-    * Title: **The Linux Kernel Module Programming Guide**
-
-      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
-        Jim Huang.
-      :URL: https://sysprog21.github.io/lkmpg/
-      :Date: 2021
-      :Keywords: modules, GPL book, /proc, ioctls, system calls,
-        interrupt handlers .
-      :Description: A very nice GPL book on the topic of modules
-        programming. Lots of examples. Currently the new version is being
-        actively maintained at https://github.com/sysprog21/lkmpg.
-
     * Title: **Global spinlock list and usage**
 
       :Author: Rick Lindsley.
-- 
2.17.1

