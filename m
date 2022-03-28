Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA614E8E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiC1Gwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiC1Gwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:52:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6611032982;
        Sun, 27 Mar 2022 23:50:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k14so11557541pga.0;
        Sun, 27 Mar 2022 23:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulRhUBB/501Y6zLj3F+koUiiEJffcO52ksrV1+fMBQw=;
        b=B5TYK/Lj1riWa8lfJJsWT8BgE7PESXJpCTlmTbJ9gmzLNr89O+DLftQSpJopv5PTXv
         AFsmj9Zn4lrYTouSiF87DjItnhOWgvRIiP4eoGsMPcJKzBHQcBnqohrlea3DSrWNDT0N
         K3M6iT5vIR1Hzu/ZXFpZbI6JyRcfH1g5olVTefSNl3643VBWnyLv8+QgF0RxIfEaboFX
         JIJ8zCLpiDh57sTHOpjc2bIyqUBfKnpRd5vbQWehrazDAAzErBAiGlpwAZI5oPxCbkbp
         3B35BYPwEhf2vL6Xxv2a2QHvAztl4jkmn3tGBgnIhcTYIo9y2mXEb/zZBAs2PQADGqTo
         aytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulRhUBB/501Y6zLj3F+koUiiEJffcO52ksrV1+fMBQw=;
        b=ljbYRq1qrJyCBgSIH0Kxs2kApTA2StjQhx3CyelrSIjrRNDxGq7miRmydSmK84cn/z
         g5r0Easi/4dHrjByjE3ncLBCjfvqZU5OkxywXLTejxsvBrMyt58i3wFZqmF2vl3uDIOU
         kzunP1MIxCmsdmW/yf7YjDCeVa/slmSqq8jni8wQM0/3L5Id7pb8zSPRLDgxQVdPvtsS
         ka1F27/KhAimti6A+5O1y2oCBhPgjuKwQi0p3ipRLXr6x4Mebrq1sE9ugTSrCMAM5pmQ
         XZr3PMetblj6J22Z+43eyiF1rn40eS/BvIKG97geQihkc7tdkkvqYBp4qDpm+se0JCM5
         eaXg==
X-Gm-Message-State: AOAM530LnTPA+KEp664LjD5tatOzlx98t9EVcoc7jscBboM+g/U3ybVI
        dZpiwkF1uvR6YzrniXjGC2e4ulWgCszGaw==
X-Google-Smtp-Source: ABdhPJwVqooJONDPaNYNY2ZHmDu9fgfuBPw9KDbNO3FWyYXRlPMgiXe7aBojp23SFgXVhoWT3boz8A==
X-Received: by 2002:a65:6a4a:0:b0:380:fd52:1677 with SMTP id o10-20020a656a4a000000b00380fd521677mr9119180pgu.597.1648450254591;
        Sun, 27 Mar 2022 23:50:54 -0700 (PDT)
Received: from ubuntu.mate (subs09a-223-255-225-67.three.co.id. [223.255.225.67])
        by smtp.gmail.com with ESMTPSA id il7-20020a17090b164700b001c779d50699sm17653551pjb.55.2022.03.27.23.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 23:50:54 -0700 (PDT)
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
Subject: [PATCH v3 1/2] Documentation: kernel-doc: Promote two chapter headings to page title
Date:   Mon, 28 Mar 2022 13:50:30 +0700
Message-Id: <20220328065030.24936-2-bagasdotme@gmail.com>
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

Promote two chapter headings, named "Writing kernel-doc comments" and
"Including kernel-doc comments" to page title. These titles deserve
their own chapters in PDF output, although these will also appear as two
separate titles in table of contents in HTML output.

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
Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/doc-guide/kernel-doc.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 79aaa55d6bcf2b..a7cb2afd799007 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -1,3 +1,4 @@
+===========================
 Writing kernel-doc comments
 ===========================
 
@@ -436,6 +437,7 @@ The title following ``DOC:`` acts as a heading within the source file, but also
 as an identifier for extracting the documentation comment. Thus, the title must
 be unique within the file.
 
+=============================
 Including kernel-doc comments
 =============================
 
-- 
An old man doll... just what I always wanted! - Clara

