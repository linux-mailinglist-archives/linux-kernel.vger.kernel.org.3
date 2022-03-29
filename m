Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313044EB6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiC2XYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiC2XYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:24:22 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B3185452;
        Tue, 29 Mar 2022 16:22:37 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w127so20516732oig.10;
        Tue, 29 Mar 2022 16:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QpqqAPwXMV7VT51UYWKaBPgknrObFDs8Es/GevAG7kU=;
        b=VcDxO8qvQWw5GbBfG73UfmNJXuF5cW5bBU2Mxd1Ye0e/wAvQp0V/4uLuI9mi4aFOvi
         8rLVNAbCFXzaez+GOUvJnkbmxtauuKUojy0PS5ee1RKtoNiigjLsy6sZkBcJmlhp06gz
         LspK2FG0NrGx7KMkZW+F2leRMEOMmE+yor5d+5hVYOG/5B4IjN5iItf4xKBh8aSKtfMd
         XaL5FtVJ7KOHhye0b0JeiMuBmswZjq1bh5O/25ODjo1cWhQCtI99+462rOWTj3H5zNBT
         V2y2a/6TVQwwdVjfRXPfdrVXKpUWZ0/092pGazQtTP0t7MCCAZ07srzkIYxxNstGGMVo
         X07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QpqqAPwXMV7VT51UYWKaBPgknrObFDs8Es/GevAG7kU=;
        b=IRnvPvNj+iNxB+MyVdlIvTreGkpC68edPLFquqQQtaD++U2Hb8vKIMNCIdzIEDbqDj
         Q/uylxszRtXvItvKuILO07bJ/N0UE3PfXZU+gRotonXCO/ZzdDrQTGOG52PETto3buM2
         pQUzhZLw3flZZqrVbry4sby1WBbfKqR7U8F/FyzK9nHDZk2U2Q1W1mr8vRp4AyhffFtl
         99x/DprRdFYwj8dfQoEfIH84Qh856nop7QKaiSv/ypBn33GryvRsuTg3upM5o+7x+jOP
         WtgDlrEJfia0qUqwx+F6vl4Wvj+7AXWpauCXEmziePoX0KmKY+gdHNN4Igc7K5L63S2g
         WkAw==
X-Gm-Message-State: AOAM532c/L/teu7f+HlFx17wS8N+pnPYg/W2WwII1k8W1jwGmJkTetzp
        EhYPMcnBiDw3JWqRejtS9k8GpuT9/76ZNA==
X-Google-Smtp-Source: ABdhPJwLwdyr0zHskTf4h5I0h/Ib3yG+ow7VZ1snYhxwk9oPN1BT/f87G57+3qxMYvrf++beR0LDkw==
X-Received: by 2002:a05:6808:140b:b0:2ec:f41e:a4c6 with SMTP id w11-20020a056808140b00b002ecf41ea4c6mr674496oiv.17.1648596156540;
        Tue, 29 Mar 2022 16:22:36 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1503:f300:282c:2283:f732:e1c7])
        by smtp.gmail.com with ESMTPSA id u22-20020a4ae696000000b0032158ab4ce9sm9231964oot.26.2022.03.29.16.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:22:36 -0700 (PDT)
Date:   Tue, 29 Mar 2022 20:22:30 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com
Cc:     linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        dan.carpenter@oracle.com, julia.lawall@inria.fr
Subject: [PATCH v2 1/2] Documentation: dev-tools: Add a section for static
 analysis tools
Message-ID: <9b8233e89227617a2cb47d85c654603c6583323d.1648593132.git.marcelo.schmitt1@gmail.com>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complement the Kernel Testing Guide documentation page by adding a
section about static analysis tools.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
Change log:
- Brought generic tool characteristics to the intro paragraph
- Made explicit that these tools run at compile time
- Added a note of caution about false positives
- Updated Coccinelle info to make it sound better and be more skimmable

 Documentation/dev-tools/testing-overview.rst | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index 65feb81edb14..b5e02dd3fd94 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -115,3 +115,34 @@ that none of these errors are occurring during the test.
 Some of these tools integrate with KUnit or kselftest and will
 automatically fail tests if an issue is detected.
 
+Static Analysis Tools
+=====================
+
+In addition to testing a running kernel, one can also analyze kernel source code
+directly (**at compile time**) using **static analysis** tools. The tools
+commonly used in the kernel allow one to inspect the whole source tree or just
+specific files within it. They make it easier to detect and fix problems during
+the development process.
+
+Sparse can help test the kernel by performing type-checking, lock checking,
+value range checking, in addition to reporting various errors and warnings while
+examining the code. See the Documentation/dev-tools/sparse.rst documentation
+page for details on how to use it.
+
+Smatch extends Sparse and provides additional checks for programming logic
+mistakes such as missing breaks in switch statements, unused return values on
+error checking, forgetting to set an error code in the return of an error path,
+etc. Smatch also has tests against more serious issues such as integer
+overflows, null pointer dereferences, and memory leaks. See the project page at
+http://smatch.sourceforge.net/.
+
+Coccinelle is another static analyzer at our disposal. Coccinelle is often used
+to aid refactoring and collateral evolution of source code, but it can also help
+to avoid certain bugs that occur in common code patterns. The types of tests
+available include API tests, tests for correct usage of kernel iterators, checks
+for the soundness of free operations, analysis of locking behavior, and further
+tests known to help keep consistent kernel usage. See the
+Documentation/dev-tools/coccinelle.rst documentation page for details.
+
+Beware, though, that static analysis tools suffer from **false positives**.
+Errors and warns need to be evaluated carefully before attempting to fix them.
-- 
2.35.1

