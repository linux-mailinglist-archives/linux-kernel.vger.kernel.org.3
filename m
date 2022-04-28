Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D81513D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344358AbiD1V2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352281AbiD1V2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:28:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74A2DCF;
        Thu, 28 Apr 2022 14:25:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gh6so12089785ejb.0;
        Thu, 28 Apr 2022 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRInxovmtEp5kO7w1NKMCyeNmmaZA+H9IsO8MYD/nxk=;
        b=KN3k7n1J89F5FoVzgUechS/8skSrFw6kWMc2q1ASXXL4KXv8dVB+FxsubPDqxVFGXE
         3A/ANpJs9MTx0T4NUzDWUu6HdoEF+FtABc273Ca1TW5enA32DJ/U8omw7xy01MtlngGI
         lxtWTL5KgGJQcTh8VSbRtPgRwIslY1m2+Mn9EUwAUebUjUZzE98LAz3+sCc/pXr58Yqj
         L1mvHY6oBYsokOOels/Wm0CuusmPEyRdo/HC/pHUBVQNFrbw13GOGaBEwQ5kV+wRlmEY
         /347sGz/0QD6KpTP7yCOUBO/acX1rktqqNI0BbnedLlOnBviq0PfO1rJ1lWnG4PEIEKj
         tySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRInxovmtEp5kO7w1NKMCyeNmmaZA+H9IsO8MYD/nxk=;
        b=OamQbILlxIbX2xD4WE36L1o9bbpgidJXBZOUcIld5mpxmv90NqexDfkj0Gaw2p96QD
         hx8sx2TgeL5lARgFVH2Cvo7F6e2AuYVijmHCagkRNPTRC2X0eT7HVZjveTpKdWNvyOpu
         XmwNu5j0oaQ2UIEA3M+SYAiAbu6JyU5p3HL8Dqm/X2aPi92XMxZ9Q+kTnnxUKINjl5TM
         jAyeGLzzZd3OlOmBx/RzZMUKQc8TPE1ZevGnwKj4JFUkiuMtKTRxn0X5GJoZI5Z+Dj60
         1sFIOKjsRLy+qYQP7ibELB3+4+477Ss5cSxTUfq7Bt7Ha8D37+DdoaEuWBj0vKuUWjVR
         M5Iw==
X-Gm-Message-State: AOAM532E5vhuiyPFeIm66/WO+UyoD+MF7EBN/Jt96z5nhbfzZrjJ4Rff
        3B+MOpqvavctTjl9s+ECthaYDOUJRtQ=
X-Google-Smtp-Source: ABdhPJyps6JAZvGLNCALZ+xOu3cOWTimaZltmVZngEsBX7uAGmmNMQAy5qaL+rn1kwIdJ5q7+wXk7Q==
X-Received: by 2002:a17:906:4fcb:b0:6f3:b710:9752 with SMTP id i11-20020a1709064fcb00b006f3b7109752mr14085271ejw.445.1651181104913;
        Thu, 28 Apr 2022 14:25:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ze12-20020a170906ef8c00b006f3ef214e68sm37147ejb.206.2022.04.28.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:25:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 2/4] Documentation/vm: Include kdocs from highmem*.h into highmem.rst
Date:   Thu, 28 Apr 2022 23:24:53 +0200
Message-Id: <20220428212455.892-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220428212455.892-1-fmdefrancesco@gmail.com>
References: <20220428212455.892-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-docs that are in include/linux/highmem.h and in
include/linux/highmem-internal.h should be included in highmem.rst.

Use kdocs directives to include the above-mentioned comments into
highmem.rst.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index 0f69a9fec34d..ccff08a8211d 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -145,3 +145,10 @@ The general recommendation is that you don't use more than 8GiB on a 32-bit
 machine - although more might work for you and your workload, you're pretty
 much on your own - don't expect kernel developers to really care much if things
 come apart.
+
+
+Functions
+=========
+
+.. kernel-doc:: include/linux/highmem.h
+.. kernel-doc:: include/linux/highmem-internal.h
-- 
2.34.1

