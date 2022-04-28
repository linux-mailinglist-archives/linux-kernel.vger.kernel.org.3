Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE4513D89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352243AbiD1V2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346246AbiD1V2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:28:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7357C1CC;
        Thu, 28 Apr 2022 14:25:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z19so6924523edx.9;
        Thu, 28 Apr 2022 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPQ3E9afTjlW5TilMvGAGVvq6Wv6p0MGgQrQX5vBToU=;
        b=Yp8Nn7etXHHyxHUU99zuitzC6s9xSi6HYAm4gUmHCRzWvw8tr6ZFQANoMPkfU96FJp
         79OtP6j5l0rTPnZnjqVrsMOYIWP09zmWBgRIzVXN2FK/y+BXhFJxFmPnrjMR4I+tyzwS
         TVEOiw3BQiqW8STaWzUDWyu5VjbAgjX6AOBiOplCCLdwhhcVafOP9Iop/fp2+p1pYL7t
         CkV0hno+pYyhrpXdgL34wu/fuxKxxxKprAmHe/qHhPeElQB6JZdJDFtEamY0N32vNs74
         n38W1eMnTHZUf1Dai2Tewk/ZtY7goElQioJ08iIYrOxtqASdELpdMJsX2dbYDWT0wuR4
         2OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPQ3E9afTjlW5TilMvGAGVvq6Wv6p0MGgQrQX5vBToU=;
        b=C7/FjogMiJUjqbIQz2VCyknDq2tpVCvLIil3l41ZP+iJUYjkhHvjZdO9AtNgTcLhnT
         IzqB1LclpZkyNgdXbDv48B4chiyiY0EnZadpP1sFki5dTbPooqy9p4t6NkdcKPsOhfZ+
         OQO14fgtVbms/75JS6Y3OzcObTqqCdFcllQl6UfqxM2dcVW04Ws1z3w7vnvUI3vwWlh0
         eb6x7lqEVafmchpMhaZgh3Cn1lRmaUVJmTrUUkSXhyXpwu1TzEzMb7VLRN3cL25OsaxC
         mlvR1vC6iiliQV5RRzAU337SA62ti5GyF56iY8rU+rhzMnAyBzKQRc2vQ/jl3o1nKow7
         lb6Q==
X-Gm-Message-State: AOAM533fVLz8+ixLoPv0upeitSTwHGKk8OEd5fSh2F44KhyHJECyqjeU
        /DtH586pNdSzujD68wzH7vA=
X-Google-Smtp-Source: ABdhPJxVfvZSIi6nZEKqLikrHqKrvrPVCUOyQoemYyu0IzSYp9ZETBQspl0NWkmxbfl1F1T7bv95tg==
X-Received: by 2002:a05:6402:5247:b0:426:27c4:97d0 with SMTP id t7-20020a056402524700b0042627c497d0mr5827312edd.65.1651181099850;
        Thu, 28 Apr 2022 14:24:59 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ze12-20020a170906ef8c00b006f3ef214e68sm37147ejb.206.2022.04.28.14.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:24:58 -0700 (PDT)
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
Subject: [PATCH v4 0/4] Extend and reorganize Highmem's documentation
Date:   Thu, 28 Apr 2022 23:24:51 +0200
Message-Id: <20220428212455.892-1-fmdefrancesco@gmail.com>
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

This is a work in progress because some information should still be moved
from highmem.rst to highmem.h and highmem-internal.h. Specifically I'm
talking about moving the "how to" information to the relevant headers, as
it as been suggested by Ira Weiny (Intel).

Also, this is a work in progress because some kdocs in highmem.h and
highmem-internal.h should be improved.

However, I think (and hope that my thoughts are also shared by Maintainers
and Reviewers) that this series constitues a sensible step forward
improving Highmem's documentation, despite some important issues are not
yet addressed.

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

Changes from v3 to v4:

	1/4 - Correct some techinal inaccuracies about the side effects
	      of calling kmap_atomic() and kmap_local_page() (Sebastian
	      Andrzej Siewior); drop "Acked-by:" and "Reviewed-by:" tags
	      because relevant parts of this patch have changed.
	2/4 - No changes.
	3/4 - No changes.
	4/4 - Shorten a couple of paragraphs by removing redundant
	      information (Sebastian Andrzej Siewior).

Fabio M. De Francesco (4):
  mm/highmem: Fix kernel-doc warnings in highmem*.h
  Documentation/vm: Include kdocs from highmem*.h into highmem.rst
  Documentation/vm: Move "Using kmap-atomic" from highmem.rst to
    highmem.h
  Documentation/vm: Rework "Temporary Virtual Mappings" section

 Documentation/vm/highmem.rst     | 100 ++++++++++++++++++-------------
 include/linux/highmem-internal.h |  18 +++++-
 include/linux/highmem.h          |  51 ++++++++++++----
 3 files changed, 113 insertions(+), 56 deletions(-)

-- 
2.34.1

