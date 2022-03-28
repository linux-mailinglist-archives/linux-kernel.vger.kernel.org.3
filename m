Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02AA4E8E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiC1Gwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbiC1Gwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:52:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673C4F9EB;
        Sun, 27 Mar 2022 23:50:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gb19so13127446pjb.1;
        Sun, 27 Mar 2022 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdM4cL37RSuglpJuskBFKNTuLb+4KsQrXFdLYdudj7c=;
        b=piModocVnb2Lvf2pSrRSaV9PrBYf2Voogc+/VCKAZ6OwzdK2+xV6hG1P8kZZyt+GAg
         7OOxSJfpt5KR0vGLTsjRpL25RCi8s/BvJ9hYE9FRtQWQcZfyxgHnoWuK97cgljKMtc0c
         oRF2bgiSYATQFfyEhbGpkqyVeSTl6m2laLE5ZUYS0mvwPWz3Msp1so0a5VHTET8sleYa
         3Nk16NXiQ2EwqkONUKGF5xCV+ibb/bQbicC2oZnm/exLnb8PoxSOig/fs+4UaxNhU0LR
         7IzkQzuCH8Ewto9rvYR+Ka+rYbxgX0XQ4gU1m/iBlqgQOZjhRnMBOM2NoQRrGy3vkXbS
         CNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdM4cL37RSuglpJuskBFKNTuLb+4KsQrXFdLYdudj7c=;
        b=j0m6G8PpK2ZR8R3/LJV3c2AGPyHQZjwxaj0Cm5HG3BcCOhXtCkFZgRarQtMvldkHhw
         +xl7PvZRZO/s8tSs0b1++r3lJRm8F/1kpAfiWrm8hDY/RIzyA2IGLeDrveRcALBRpMC5
         FAgD2/jRuldzCQCfXRtY6X+fLR3Z+TCQV/tzD2D661jOrZ2Gl6JcX4ih94+p/I5Dltkw
         HLfMDxVDVICPG0ub+qksb43oGPihZ5fC6IT93YpjU20tP8azVTVuiJlGWkutn88cu9Nd
         1d4Orn+czCZpWRQeoY8DLX7ztIWnin3yuSHkbYx0+xnU8aaAEaeQji8oHbxQjlObgxid
         rteA==
X-Gm-Message-State: AOAM530hGkTnlu8tLvV+RkeGkSckSOPxdYApFrMN2wArVa8YckPONdQb
        03zwkmibcZCJ5Wwo6L9MhsUf5SMYZSW3qA==
X-Google-Smtp-Source: ABdhPJzpvgfIblXEmSmwLCWtUn+QQ9KFwLJc0uyKtr8UrJFG6ztiurWo/6XkkYGei/MOfv+MUoZZ0Q==
X-Received: by 2002:a17:90a:9f0b:b0:1c6:a876:4157 with SMTP id n11-20020a17090a9f0b00b001c6a8764157mr27399274pjp.173.1648450258881;
        Sun, 27 Mar 2022 23:50:58 -0700 (PDT)
Received: from ubuntu.mate (subs09a-223-255-225-67.three.co.id. [223.255.225.67])
        by smtp.gmail.com with ESMTPSA id il7-20020a17090b164700b001c779d50699sm17653551pjb.55.2022.03.27.23.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 23:50:58 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] Documentation: sphinx: replace "Introduction" chapter heading with page title
Date:   Mon, 28 Mar 2022 13:50:31 +0700
Message-Id: <20220328065030.24936-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328065030.24936-1-bagasdotme@gmail.com>
References: <20220328065030.24936-1-bagasdotme@gmail.com>
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

Replace first chapter heading ("Introduction") with page title named
"Using Sphinx for kernel documentation". This way, the first-level TOC
for doc-guide contains title instead of chapter headings for this page.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/doc-guide/sphinx.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index bb36f18ae9ac3e..2ff1ab4158d48e 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -1,7 +1,8 @@
 .. _sphinxdoc:
 
-Introduction
-============
+=====================================
+Using Sphinx for kernel documentation
+=====================================
 
 The Linux kernel uses `Sphinx`_ to generate pretty documentation from
 `reStructuredText`_ files under ``Documentation``. To build the documentation in
-- 
An old man doll... just what I always wanted! - Clara

