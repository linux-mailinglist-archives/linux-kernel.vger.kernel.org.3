Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C735A51219C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiD0Swh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiD0SwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:52:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B606DD0AAB;
        Wed, 27 Apr 2022 11:38:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r13so5141222ejd.5;
        Wed, 27 Apr 2022 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jf9i3ztTNjfWPutrOO+p/55EBe7ejBl7ElvzXmHGQEg=;
        b=X2Wrw6aGSdtD6osErIZoyheLcvMUX8NAYUDuh9B4v8dSyZZoDLP601yJkl5p94uFnU
         5Ubb9b8EMYHGAcI5U44jJCxVgx+RD1VwFmHUdyD5P7xlBN87TredFXCsIbeLg9ULH4hy
         QaRH63Crb0DyI1GApXZDihx/uU0BG4rIdnvz+EYoc3+UAW7d4LpS44swBX6qmC8y7h/S
         O1YnCBF0RnDKYI1OBIf9L4RBD6zeOcjMUXcxjnR4ZS4pSimK43YIIDodIy9zWc/TXV7z
         UHdigbdNTV0YYN6+rESapEtYvmFruijwAMEkgjY+m0NzxqMfETrmSaftKX0A4EUVE3wu
         WWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jf9i3ztTNjfWPutrOO+p/55EBe7ejBl7ElvzXmHGQEg=;
        b=T3GOw5AHrGQIAJ6GfhOejbApJwkoUDYTTNV28Qgj1yquv/cOVMNRDddFDRdvbYE3hL
         ano9RfC2Kam3f9ZL9AoOZWYi+RuLl7bCmQ9EBkIo06angnj5eKaJWeeLeyW4clx/Ygwv
         TkCo3VdE/V3bqOY5dZNRp0LeMW05MiJWIeaMxVFlG8Way+ncs1h/qlawrOMtEPjGaLfo
         PtKdAvbKuslEYg58vlVVJ1YT+Jb3LZU9WtvGtaYmDDQbJkSjQX8g3Qu6ACJE5bkE80fq
         vOVUKk6HEJMGTyRe51nnanYU/q4wsNS8H0YXGsYddacSX540ZuzHl4V+CGq5VSHK8Yvz
         VHWw==
X-Gm-Message-State: AOAM531OqPNDgCYA3vIonRro22Ol5r7uQUmmEsYSvU86Tn7ESBlB51bx
        uJhn5W7kjNBMiNEbPvN1NNAYjSJQbaI=
X-Google-Smtp-Source: ABdhPJxYmulAe68OxOgM9m3Ff9OqMHejTV4BuNDsrsdH/lnJG7g4ZBSf8iATJgr6HWV37aVYAGJZZA==
X-Received: by 2002:a17:906:3104:b0:6ce:6b85:ecc9 with SMTP id 4-20020a170906310400b006ce6b85ecc9mr27247261ejx.339.1651084705994;
        Wed, 27 Apr 2022 11:38:25 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b006f38f2e9ebesm4691667ejc.64.2022.04.27.11.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:38:24 -0700 (PDT)
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
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 0/4] Extend and reorganize Highmem's documentation 
Date:   Wed, 27 Apr 2022 20:38:17 +0200
Message-Id: <20220427183821.1979-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series has the purpose to extend and reorganize Highmem's
documentation.

This is still a work in progress, because some information should still be
moved from highmem.rst to highmem.h and highmem-internal.h. Specifically
I'm talking about moving the "how to" information to the relevant headers,
as it as been suggested by Ira Weiny (Intel).

This series is composed by four patches gathered from a previous series
made of two, plus two more single patches. The subject of this cover has
changed and the layout of the changes across the four patches has
changed too. For this reason it is very hard to show a valid versions'
log. Therefore, I decided to start over and drop versions (Maintainers
of the previous patch have been told to drop them).

Changes from v1 to v2:

        1/4 - Fix typos (Mike Rapoport); re-write the description of @page
              because the original was wrong (Ira Weiny); add Ira's and
              Mike's tags in the commit message.
        2/4 - Add Ira's and Mike's tags in the commit message.
        3/4 - Rework the subject to better summarize what this patch
              changes; merge the section which was removed from highmem.rst
              with the kdocs of highmem.h (suggested by Ira Weiny); add
              Ira's tag in the commit message.
        4/4 - Reformulate a sentence that was incomprehensible due to my
              own mistakes in copying and pasting the text of another
              paragraph (problem noted by Ira Weiny); refer to the kdocs
              of kmap_local_page () to show how nested mappings should be
              handled; fix grammar error; add Ira's tag in the commit
              message.

Changes from v2 to v3:

	1/4 - Add a deprecation notice to kunmap_atomic() for consistency
	      with the same notice in kmap_atomic() (Sebastian Andrzej
	      Siewior); shorten subject and extend commit message.
	2/4 - No changes.
	3/4 - No changes.
	4/4 - Correct a technical inaccuracy about preemption disabling / 
	      re-enabling in kmap_atomic() / kunmap_atomic() (Sebastian
	      Andrzej Siewior).

Fabio M. De Francesco (4):
  mm/highmem: Fix kernel-doc warnings in highmem*.h
  Documentation/vm: Include kdocs from highmem*.h into highmem.rst
  Documentation/vm: Move "Using kmap-atomic" to highmem.h
  Documentation/vm: Rework "Temporary Virtual Mappings" section

 Documentation/vm/highmem.rst     | 104 +++++++++++++++++++------------
 include/linux/highmem-internal.h |  15 ++++-
 include/linux/highmem.h          |  49 +++++++++++----
 3 files changed, 112 insertions(+), 56 deletions(-)

-- 
2.34.1

