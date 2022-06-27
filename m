Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE255C197
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiF0PUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbiF0PTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA7911450;
        Mon, 27 Jun 2022 08:19:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o10so13568738edi.1;
        Mon, 27 Jun 2022 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFmbK8M11XjJzoVFfZwjfb4w2B8a5R3YTDT8W3rNvcQ=;
        b=EqM+us6vfLvad4kXXDn1AjcivBngldlek+jWxMpAm2Vc5HI676j2YS3QWCgrYGSLPc
         nRsdJCfinQfKudnDj9eJBV49m05r2C4B9nlJf+hA4FoLosukjqDb0yTd44foaslGZdDt
         KKBeTRTh6E1mSiP5NqCAWJpr0N6+mg+LA3TZuRcITUVJ4fW6nUPmCHo1qFiMsVicE6gE
         5s4Uqxx+XFgdULrm3sH/eUGT3PVAKuFQ6O/huxcr+cWL4ws8cDtN3AYviMN5XimUd6Z6
         abxOfzEEd5JmNAWlPyql1ecRqjgsGyFJZx4Mnejy95REwj4QYRxA6XuC/AvUZphGgaLl
         7pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFmbK8M11XjJzoVFfZwjfb4w2B8a5R3YTDT8W3rNvcQ=;
        b=i9XAvM6rQzS0PjluBDQRmJGk6lIjmK+/bwjnNLcMD/AqJ+9d97ZsAjUD2H53t6wGhe
         3UVqBFqt/654hAFYtwwqQNQC0FO2EnwkV7JZFpHZVy8WBWX7ixLa0wG5tVvOzbFIiSxg
         43tps2EioOxVYeRFbfAq8FxW6z8KOsCd/OZf7jVhOFOr5g4Uolf1rN1YT19WhXvT15vE
         LTLIULGjuIecfaSDjldrampeY2rQOmqDMFT/yPsfQ1EjYBljalQMxEY6MwqdYmotjn9s
         CvaEH+lSNVswB2AN3+C7QEiXpbrGC38dSeKvkqAIDVxKhlO8Oox4GQmnBcH118qc8FQr
         EiJg==
X-Gm-Message-State: AJIora8QoqlO5PkuEAWrAn3BVzhggjd6XBCwM8thzVmePxEYPnn+fyXF
        oSlhQaLI2zpRXwx4hqO2xSjuSQDrPfU=
X-Google-Smtp-Source: AGRyM1tRBnxf9cJdr2BSxJoHKIVNW+/xKayrwlNzxMc/10JnS47CN4eTCmWwkLRx0xYneB7u0fUPvA==
X-Received: by 2002:a05:6402:3299:b0:435:787f:8058 with SMTP id f25-20020a056402329900b00435787f8058mr17029183eda.79.1656343159850;
        Mon, 27 Jun 2022 08:19:19 -0700 (PDT)
Received: from felia.fritz.box (200116b826511b0021a0c74157938809.dip.versatel-1u1.de. [2001:16b8:2651:1b00:21a0:c741:5793:8809])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm5076901ejm.107.2022.06.27.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:19 -0700 (PDT)
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
Subject: [RFC PATCH 03/11] docs: kernel-docs: reflect that it is community-maintained
Date:   Mon, 27 Jun 2022 17:18:11 +0200
Message-Id: <20220627151819.22694-4-lukas.bulwahn@gmail.com>
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

