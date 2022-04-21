Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41F450A7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391119AbiDUSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391103AbiDUSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:05:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AAB4B1C0;
        Thu, 21 Apr 2022 11:02:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so11590673ejd.9;
        Thu, 21 Apr 2022 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWSm35GKgzhZ2nsMVDxagYWw0p5o9vqwYX51NaxQrug=;
        b=XJsxSUUQc4rlVu1TWKgCPb23ms5Cf0+E/ldtQyI/Bnzra8P5sITAAQsvP55AunNBWu
         cAEefC/Y7EL6Rr54fEzFhBK7GaPER8T7/sPXZSQI8G7FPeNX6NAJImwJFqGRXZPfOTBI
         oTQIdm00ImB9obwuVpn0gVxYqN8faYmE4XkBubmwlicbJFI5tbcV9BOxBhicBOJTmHlE
         B6HDL2ajVcPSFVdRMoCAbX8fehDhEmqn2F0j/HZKUyIo/PO8V/LQtfffJTWitsTEqZm8
         Ch/JUgDH5ArKBS9zSJUZbXRN+NGBvBPCym7U6KBpiwdSGwXO66fCw30evrWskKtvNk/4
         Edug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWSm35GKgzhZ2nsMVDxagYWw0p5o9vqwYX51NaxQrug=;
        b=v00oysfcDeitBR9RzFp37SCPoJ1yy/pZa3uJDgfHyrunmwSflY9n+nsFFzcgyjGPIV
         Xcy61Qw+Es/+8gKbZqkZq95OPiknjjIVV9Di8mn6f9qfQoom8SLq5df+n71kKzk25guS
         gt4JklMznyjQelHxS9+vBK2cLzAz/o2Ha+KO0vVt66Yd2VxJAZ7XDxuqlif2jZBEvubl
         qExU6cb74TMjzTC/nttU5t738XOsltaePFUmdFg0kE8iazUMxCpzLVYkzkTT6RLIxahD
         afM2PhjL1bGapptzw3HRa0/y0mt4Levxxe8uW+SvtXGOp7d5lrPocbSSlIVBIayRztYu
         0FBw==
X-Gm-Message-State: AOAM531RdeAOEkGkNtd1zfcggYwFIEoRgCO2kUpFlxudugQE1w9w3qOZ
        HoLMtrI+Q1hGaFMpKFZKgTM=
X-Google-Smtp-Source: ABdhPJzz3okdqpk4g83+Y1lh1AY/TunHBPpCllIQOGmm8GGTU+6kn2uQoF4Jy63X4AgO3F04jvzdEA==
X-Received: by 2002:a17:907:7246:b0:6ef:828d:4b49 with SMTP id ds6-20020a170907724600b006ef828d4b49mr705192ejc.172.1650564133850;
        Thu, 21 Apr 2022 11:02:13 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402231100b0041d98ed7ad8sm11836204eda.46.2022.04.21.11.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:02:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/4] Documentation/vm: Include kdocs from highmem*.h into highmem.rst
Date:   Thu, 21 Apr 2022 20:01:58 +0200
Message-Id: <20220421180200.16901-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220421180200.16901-1-fmdefrancesco@gmail.com>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
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

