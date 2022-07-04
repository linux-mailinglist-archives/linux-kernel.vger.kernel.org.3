Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF9565526
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiGDM0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiGDM0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73032DED2;
        Mon,  4 Jul 2022 05:26:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eq6so11486362edb.6;
        Mon, 04 Jul 2022 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFmbK8M11XjJzoVFfZwjfb4w2B8a5R3YTDT8W3rNvcQ=;
        b=NlM/eU/CVXn5P0ezkZ5e677LBsMWNiIZ/jO8GRRSJUvGIB7Gcb+3WwXsLlr4QJw+Wi
         YYk6jkKLB6yTgPu1sR91RJ6KS2VV3sZJ5fbWK1SRKFB+Blbs81Pq1L5OrZvluIT9Vkjv
         4P8EyTF9942ejrxh/9ZblJqbBHBCNti0fI1ANJ+L1FHvTU7rnVjGJkRmtFxjp439lmGd
         +bgD0ObQZN7H/1Mga2a4dPR0dG3Mvs2ecxxIAl3vkb2U2XoP8USqm73avC5bWKOhAKqB
         1BEBulv3Vh29BETHCQwHUuVLBcYADS7MVJCu4SOJgh0UF0rB3RWh6zapkQ5zpeYBZpLl
         F61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFmbK8M11XjJzoVFfZwjfb4w2B8a5R3YTDT8W3rNvcQ=;
        b=atkItDwCC7u7Y8Kwd/oISj55XsFZtcl4NUaY0hQtXT4AnYIsJQzK59n3LExHWl5KQE
         Rg6Xf/oswpYGDoCJ++LCElOuJT6gqxVFIbm4/eeKvMo52rcwkxi4e4pVUXZu0GuM7ztN
         mlArj2CVJr9mP0BJ7CWno3IxLeHkMUh5rCiBerKJ5tc7ueaydD/PgEyWwM8fciYI/Pdl
         qTwf8NxOkXieIKscZ9jSpXyB6iI+RWe3+TYWy4OnO04OCJmy6GYlKofw8rjDHv2RArwa
         7WUtSPMo7H4xtjYzs/q+5b9SoXnH8IufRpFHaoba8W0z35gss6xuqbDU/A65uTw8pm4U
         1S1g==
X-Gm-Message-State: AJIora9TUqRQ+3reefVFoa9h9OL7cJm9yK+JqjPU/hDgAR6cNoS4753B
        9kU6+RVFbffuxgzwTCUC0hA=
X-Google-Smtp-Source: AGRyM1vrdJAUgasWOJCitvIq8KSyqbsx9MqUpTvE2e6JCRW0Rx5SwhMRixS1qRElY4PUBEA42Vnw6A==
X-Received: by 2002:aa7:cf08:0:b0:43a:6d32:f71d with SMTP id a8-20020aa7cf08000000b0043a6d32f71dmr3183320edy.192.1656937581504;
        Mon, 04 Jul 2022 05:26:21 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:21 -0700 (PDT)
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
Subject: [PATCH 03/11] docs: kernel-docs: reflect that it is community-maintained
Date:   Mon,  4 Jul 2022 14:25:29 +0200
Message-Id: <20220704122537.3407-4-lukas.bulwahn@gmail.com>
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

Remove and rephrase statements that only make sense if a single author
exclusively would maintain this document, but we would really want to
consider this being a page maintained by the kernel community, as it is
placed in the kernel repository,  and let us hope that more contributors
suggest some more documents.

Further, do some minor word-smithing.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/kernel-docs.rst | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 5d6fa71895cc..b2523267ffc7 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -3,7 +3,8 @@
 Index of Further Kernel Documentation
 =====================================
 
-          Juan-Mariano de Goyeneche <jmseyas@dit.upm.es>
+Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
+email address is defunct now.)
 
 The need for a document like this one became apparent in the
 linux-kernel mailing list as the same questions, asking for pointers
@@ -16,21 +17,16 @@ philosophy and design decisions behind this code.
 
 Unfortunately, not many documents are available for beginners to
 start. And, even if they exist, there was no "well-known" place which
-kept track of them. These lines try to cover this lack. All documents
-available on line known by the author are listed, while some reference
-books are also mentioned.
+kept track of them. These lines try to cover this lack.
 
 PLEASE, if you know any paper not listed here or write a new document,
-send me an e-mail, and I'll include a reference to it here. Any
-corrections, ideas or comments are also welcomed.
+include a reference to it here, following the kernel's patch submission
+process. Any corrections, ideas or comments are also welcome.
 
-The papers that follow are listed in no particular order. All are
-cataloged with the following fields: the document's "Title", the
-"Author"/s, the "URL" where they can be found, some "Keywords" helpful
-when searching for specific topics, and a brief "Description" of the
-Document.
-
-Enjoy!
+All documents are cataloged with the following fields: the document's
+"Title", the "Author"/s, the "URL" where they can be found, some
+"Keywords" helpful when searching for specific topics, and a brief
+"Description" of the Document.
 
 .. note::
 
-- 
2.17.1

