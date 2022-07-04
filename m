Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1555956552A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiGDM0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiGDM0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E60B869;
        Mon,  4 Jul 2022 05:26:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id fd6so11501687edb.5;
        Mon, 04 Jul 2022 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qrkTtNr9vkVoaS0GaHbwE3GT2+MGnjzP/retpDU/T28=;
        b=EJQs5W09F2VyAW/8CuPhKvtgGsrETDObNB0HTNw4CdQhIxVJtJ/LKQ8PJcBSasHT0i
         d9SAN8cc8CZvvaJEdz5oyoXkFSgsy45LWnNHCTB1rRA4Ju5pTKFvQsQfILLGEr6Ezg8n
         K9ZA2Mb8bhb7OfU3488yuA+lOWZSvl2dlhuxdfO1+dhwyb9zT8mfaxAJhzqSm11YWqBI
         EKJJ60gtbJvp0SCX807S6j9EJ8a1dEDzcBOjtHJJpX11crs5QAZZjQG4EQgFh6YMXf+b
         BTs4hMyhyo8W74T8ysGgc3yCtEFmub0B9mzrFXIrHgajotxtquUPclolTtIJn8k8Ze7m
         1D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrkTtNr9vkVoaS0GaHbwE3GT2+MGnjzP/retpDU/T28=;
        b=rLC99yfwbe7o4aLenw+MxxItT+brAuTkYztK//wXsayaK/XXHtAiq2wy50dTPOTqJZ
         yDJYjq1WTv7ugQKRy2Kd4HJIM9lDhg9Hlx612VqH53svHfxnht63XnbFLdtiPtqgabxz
         rH5nzjuqeGG6BSwKr7nOg4nWlzAXq8wR+FaOzof6UAfAEe4ZIP7Tg4qxCLcwlQ1QgrSJ
         mD/5xbL8tVP72+/HxFu9UsDNXhXvTClevN7wCXIvToRQNFY5pDAU/quI820zQSgLJ60M
         htjV2kxhGisxUE2BBi3lPzYa6gztkH0mRkQQC9q0E32UtUjl2gpu79B4yvsOpSc0d8n2
         3lTA==
X-Gm-Message-State: AJIora+nmjtBv8WFrcul+eHC0DPiMyFO2KBnukuXjRdcXnIQJx7lMrwC
        Ev88FYaTF3RMDcvNToII/4Y=
X-Google-Smtp-Source: AGRyM1u70NVrsGujVJqJeKk7rgKI1Etf7AVQXQQoRYPh8Nm9CdcP8zajnvGdRh+8bvhjKfTz24NyOQ==
X-Received: by 2002:aa7:cd66:0:b0:435:74d5:2d58 with SMTP id ca6-20020aa7cd66000000b0043574d52d58mr39153512edb.34.1656937578326;
        Mon, 04 Jul 2022 05:26:18 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:17 -0700 (PDT)
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
Subject: [PATCH 01/11] docs: kernel-docs: order reference from newest to oldest
Date:   Mon,  4 Jul 2022 14:25:27 +0200
Message-Id: <20220704122537.3407-2-lukas.bulwahn@gmail.com>
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

