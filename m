Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E228955C592
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiF0PUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbiF0PTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E912AE1;
        Mon, 27 Jun 2022 08:19:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so13492295edb.11;
        Mon, 27 Jun 2022 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y9fLCoDjX9rrrX0oj8XNyUYP/ZsreaQRf2qQi5uPknQ=;
        b=pLeurTZ6VbuBl15KuR6fVVIpAjrXu1MWRc6f+75rhPwq1s/LHegop0H73efOqzZWeB
         CbJQjcqz3VkGTR7z3xshixE5nkH/B/ieCZwEBYcIWKRo6lcE4RTcNpzfxRXl35qSlMNE
         8tS5spLfrlEfUOmXeycqtITRMggZ3jH5t2XTTV1Lds02cA0otEdxG8NjKn7L949ZFWnu
         xEpPXfRHcXvXKpVd9e3YcsLhMustaOrZzoWhG+uvlBrxiZknjRwz7WJTPL/He+ToA2b8
         /uPELxBnRTiKstgXGA96w0h3oGZubgW4u9qAI4UkCHSW9EWy581uHofSQwxmIu09oIlt
         MyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y9fLCoDjX9rrrX0oj8XNyUYP/ZsreaQRf2qQi5uPknQ=;
        b=RAoB8j4Y0l61Svb0L3eLqwlQDX6B15ruP3H8MJF2BKGqJm8cTGByQTlvXRUSlZmpRG
         jw7nG8n39MC18eVdTP1lBcsNYJSgq+dNjdZW11fprfxyeQ7Y/kKTbnajE7ioYgSfgH0i
         mEr8t8542JUL4ru72zcVRStnzclayks8ircRAdUyG30timOGdaZIJoZbwVyMcVAr7qLg
         7YYIMFg8IdyQ5lpXdby+1+YwcyyS0K95GRV4eeEgItzqQuPM+lGngl0JDbz0eX9FdXg1
         ajMjBD7+vNGmXddeaP6MY2ZbdLlitRj59vXRW+v3I7CwkiPR7KmeC891ACx7tqVw45zG
         L0UA==
X-Gm-Message-State: AJIora+6WSe5J9fApRF95bxt3+YPBVRUk0iqT0jMbSAlGI++tgtEfghY
        nflDfHJxkDwAGRVMrqFRj5I=
X-Google-Smtp-Source: AGRyM1uTtKgDwut5RI26tx1pUpEvODCSgxKJR29m8yG2RZvqCW1pnlbj1xuBuqOptkfmmuXsD7xo0g==
X-Received: by 2002:a50:cb8b:0:b0:435:68a3:4d40 with SMTP id k11-20020a50cb8b000000b0043568a34d40mr17552648edi.394.1656343161640;
        Mon, 27 Jun 2022 08:19:21 -0700 (PDT)
Received: from felia.fritz.box (200116b826511b0021a0c74157938809.dip.versatel-1u1.de. [2001:16b8:2651:1b00:21a0:c741:5793:8809])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm5076901ejm.107.2022.06.27.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:21 -0700 (PDT)
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
Subject: [RFC PATCH 04/11] docs: kernel-docs: add a reference mentioned in submitting-drivers.rst
Date:   Mon, 27 Jun 2022 17:18:12 +0200
Message-Id: <20220627151819.22694-5-lukas.bulwahn@gmail.com>
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

