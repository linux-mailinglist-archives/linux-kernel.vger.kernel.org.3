Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0522553CBDB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245254AbiFCO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245245AbiFCO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:56:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D17AE36
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:56:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v25so10498252eda.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=39Qt6YV0FwGKKYhTeE9ToxWI/DQEBDcRES3gLcKo9F4=;
        b=e5A51A66u/0SUz0B94iSCOyvfYagEF/2TxdxjA9CmFKdNeO/J0N5sqDpvBbPU6WFg2
         gk8e+0UF1CeTlWFTJV+6ai4nhPgXKJ4AbaqyTwt2JeDC9U6+a3bwxmLAfl2fauHXMzBi
         dmiOm86ZRsEWg9BHtO7Pjs+WX8jzq83cW1QVqFUT/ov8PN+D6TtIiuNZO3cVs83vvKBH
         1pp/AsM3RQ1sgbGxY0JqebqJtkbbNgJ03qQbw0DfB4u6ed/pga5DtxNWt98R2otqJkHX
         +DgCohf0SgMcuecZU5IZ68VcrgfSj7lFh9+qqN7sR0u9QAMx0M+m4DOdgIDNV5v0Rvu9
         1Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=39Qt6YV0FwGKKYhTeE9ToxWI/DQEBDcRES3gLcKo9F4=;
        b=pj85fFnQ9GkyKHAaF8cep65xnbul1/H7hiEuwO22Ljv3Xlj/1gJjhcmaa3xbY9f9EM
         2PgJQTOg7PjAobuoZvb3fsEYSTPTg8ftkFFJYgL1J5sivjxaKU+63VU2IRf7Qz5nPNFl
         jzYqH13+kCxVqLkn/Kg7oYd15CV2MN95zY3osk3vuE1DnDNkeMzfcY3uBdAHw7cbJmPo
         XLALt/55mZMRtyJRoaKrd5pXg2cisEPKJCSyTQh1+6OswXD1Sl+6To7WqkTcQfmuExtU
         7o8R77AmKW6I7DCXBgcstL1ryqB6VfLbLLQxMNdu67za2oHnnqez/Pe64v26LDSX26z9
         3V4A==
X-Gm-Message-State: AOAM532WluVPd85As8XymL8yb4ib0W+1eY93PO0xiEwO/QpLbPESm+/a
        gGiIMajRzOMuV8RVjCTgFnA=
X-Google-Smtp-Source: ABdhPJwd9zjK40T7IiYBa1JINrlDj45THKbt8M6DpIODKZse3VhsfKpoBF+/R+oC7IAlwEM+YGwCWQ==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr11271819edb.273.1654268207704;
        Fri, 03 Jun 2022 07:56:47 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id u19-20020a056402111300b0042dc6336684sm4021965edv.73.2022.06.03.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:56:46 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id A9D03A007B; Fri,  3 Jun 2022 16:57:20 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH v4 0/2] Refactor of vma_merge and new merge call
Date:   Fri,  3 Jun 2022 16:57:17 +0200
Message-Id: <20220603145719.1012094-1-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently working on my master's thesis trying to increase
number of merges of VMAs currently failing because of page offset
incompatibility and difference in their anon_vmas. The following
refactor and added merge call included in this series is just two
smaller upgrades I created along the way.

The rest of the work is still being worked on but was send to mailing
list as a RFC:
https://lore.kernel.org/all/20220516125405.1675-1-matenajakub@gmail.com/

This patch series is based on mm-unstable branch (specifically commit
1bdf44dbc966e31c635199d413ee064a7d320844). This is fourth version,
I added a mremap expand merge test, added a comment and new variables to
the merge call and based the series on the mm-unstable kernel branch.

Jakub Matěna (2):
  mm: refactor of vma_merge()
  mm: add merging after mremap resize

 mm/mmap.c   | 87 +++++++++++++++++++++++------------------------------
 mm/mremap.c |  8 +++--
 2 files changed, 43 insertions(+), 52 deletions(-)

-- 
2.35.1

