Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E657D569
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiGUVC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiGUVCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:02:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FD98FD5D;
        Thu, 21 Jul 2022 14:02:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so4066743wmi.1;
        Thu, 21 Jul 2022 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LUbqQkNcEA47t5z4D+rB9SkmqQ7VO2bp8iPexMuATqU=;
        b=OP+empOPZ1RB4JBaGjSPYztBbLFE4gQ/UMeL0BSMHnxPLK3k0KrYPjtb07qeYQxxJv
         XqQg8H7RuS7Scu1YTs0X0D+eJLso0hzu+0R5UpPGLKaLWO1MM7gplZKvSRZC2LNcR06U
         80Y+yOXRAgZvfBU2OTjZiz8xGAtZeG1vmJsROmrx35GfjE1ch48IjYQbQRyxGZ6haYgJ
         5GllGV4ItT92kO+9PVZf2AlXC0SsddoIVN4+Oak/14A3dEunFBoIwo8FJBPftKR0l20s
         pNfU5j5SeVss4s1WnlNRFvNLCHY/gyeCpwxSUsSKqHcUx9carxxFyyEdLp93fy2iQwmR
         6yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LUbqQkNcEA47t5z4D+rB9SkmqQ7VO2bp8iPexMuATqU=;
        b=PccAqZkRBt7z4d/qF/csg2w5PjzKCVJuOlulI9xD++eKipJnADrx2Y1NvJ55rwQDeR
         StFiSLLnq5KYDtOs7h6pMlY4vKpivOffkJmpuJPEok21XNScgsyOa5WjcwmyI1G64lfV
         psra8a8SXZxb/9pQ0XCJ+VVHlfqSNm8lS5SWeVPOtX+6sovr6ZCxZ1WrxKR6hHc91Ipe
         eSkppWezIaIpV8KvOV5bfY9FpKIprpNRHNT3hvG6QC/lQDbI+8b2TtBhGVxhscLbnPj/
         ukYHE6qyat6uOkTCpXUcUJzYI0NzPTYvojSSIWEj4ETtXAh7VP2HJPB1pcIZh+hxo8WY
         QNDg==
X-Gm-Message-State: AJIora+E414LjJ8UbGNsQruxz7hTTIixYSCIZevqxtJo64X+1SlyhAtq
        A/VbaVJKuKLhHh/4Gytc6X4=
X-Google-Smtp-Source: AGRyM1uP6Bx8g4K9CRYbsg9B23+EhG+3Brx44lVLjS+PZZ+KB82TJ8d8YOOK80DoXNHzV34OYmYkog==
X-Received: by 2002:a05:600c:601b:b0:3a3:21a2:8bcd with SMTP id az27-20020a05600c601b00b003a321a28bcdmr35141wmb.80.1658437335162;
        Thu, 21 Jul 2022 14:02:15 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b0021b8c554196sm2884383wrs.29.2022.07.21.14.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:02:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/7] highmem: Extend kmap_local_page() documentation 
Date:   Thu, 21 Jul 2022 23:01:59 +0200
Message-Id: <20220721210206.13774-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
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

The Highmem's interface is evolving and the current documentation does not
reflect the intended uses of each of the calls. Furthermore, after a
recent series of reworks, the differences of the calls can still be
confusing and may lead to the expanded use of calls which are deprecated.

This series is the second round of changes towards an enhanced
documentation of the Highmem's interface; at this stage the patches are
only focused to kmap_local_page().

In addition it also contains some minor clean ups.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Fabio M. De Francesco (7):
  highmem: Remove unneeded spaces in kmap_local_page() kdocs
  highmem: Specify that kmap_local_page() is callable from interrupts
  Documentation/mm: Don't kmap*() pages which can't come from HIGHMEM
  Documentation/mm: Avoid invalid use of addresses from
    kmap_local_page()
  Documentation/mm: Prefer kmap_local_page() and avoid kmap()
  highmem: Delete a sentence from kmap_local_page() kdocs
  Documentation/mm: Add details about kmap_local_page() and preemption

 Documentation/vm/highmem.rst | 31 +++++++++++++++++++++++++++----
 include/linux/highmem.h      |  7 +++----
 2 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.37.1

