Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4AB58437E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiG1Psx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiG1Psv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:48:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597168DC6;
        Thu, 28 Jul 2022 08:48:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mf4so3874620ejc.3;
        Thu, 28 Jul 2022 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NrXXUlA72mLwPl3oAk4hUgRmIIhHL59XBsnYMRfeqVE=;
        b=NqagBMgbyNgtyR49hnsdizviW+Es+0tf0pejD6z2HOyFzkeTGZn3npG03E2+BESDsm
         CboGjJ+Uy3XP3QHCxYvdi7xA5rcQ6HpDLElFChVGo9t0MyqQXGeMA+Ml8N2lOQl8ipwx
         NFx2Flq1i666usHInqux5vhFqJbQlltzIk8AtEnSpLD0EUde+h5RxeRbKbfvjPUuAsC9
         Ax/eWMBaz+49PkHLMPTSqqKnTmbSehJ178P+eVC1MB1S2hngGEz0DIe2m8V8Fk3/Um7e
         2vGJG9W1LysiS0T/ZfQejmWY95pCJkszNOzMvHb8WW110Wu2zTizSuGXpR1xhVXERTNE
         ZRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NrXXUlA72mLwPl3oAk4hUgRmIIhHL59XBsnYMRfeqVE=;
        b=6BDOnrLFaKST+ixxvIao1wU8+qs1oyAyLQ6TzEhX77L7FmaXqHGujI4ENFRIaeYvY4
         Y5NN+TN7pm7qOFffVo6RjDGLVVbTrovw8TgbgtTv87H+EKz8sFZWEN8A9L6S+cl5p+vm
         aBy2QCDSqzJmQmuLvgsRCAb3iJDy4wnWk3ahQ6OE6S52/7N0gKpHPtFcIJ+9yIdr/14T
         hgFp8qmiAVJK38C9BzABm44lD5DlsthvRBUIeN+8lXpbVyOghSDcL2KZVUCgTbF/vHJJ
         PoO4Sb6JzGgR57s5BH/U0Mn2B+POza/n1pGTcQjhuGrRgFbLXyqWDmuxitxGoLfhHj5z
         iXHw==
X-Gm-Message-State: AJIora+mQeNcDqHXvlZ4gNtPaI6k/DOOOeRUlZug0fTF2j3NaSMZ1Ygs
        yY9IzD0+Qnv9fEIYtLjcVPk=
X-Google-Smtp-Source: AGRyM1u7EeU+2cFHVHR6y1OHkYelmsRxVbrsR8TBIwjTP6Iz7jP3deEi+NWfMMQ7F0RHmB8UWkg9CA==
X-Received: by 2002:a17:907:3e11:b0:72b:49d1:2054 with SMTP id hp17-20020a1709073e1100b0072b49d12054mr22057461ejc.78.1659023329102;
        Thu, 28 Jul 2022 08:48:49 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm902487edy.20.2022.07.28.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:48:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/7] highmem: Extend kmap_local_page() documentation
Date:   Thu, 28 Jul 2022 17:48:37 +0200
Message-Id: <20220728154844.10874-1-fmdefrancesco@gmail.com>
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

v1->v2: According to a comment from Jonathan Corbet and some
modifications suggested by Ira Weiny, change a couple of phrases in 3/7.
1,2,4-7/7 have no changes since v1.

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

