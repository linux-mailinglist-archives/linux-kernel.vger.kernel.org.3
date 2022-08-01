Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4DB586D0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiHAOkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiHAOkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A04537185
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OgqhE+gnu6wIXIAF0NLfff8Tx1dAcg+s0AiRearY4Bw=;
        b=jKKp6ijs62iALrIHw5dEpdJnUhWWhftH9DqKcSXR2Wn36utdh26glAn4Esv8NMxJ7WdMTF
        JxPBdKz2FyIe9+Cv15mnvMMn/5wrvdt6Uo3pyl9qq4Ls17W8BC989zpRh93nfnNPr9rGNZ
        po5awplZSMLH3cPYuls5CnaNmzydjvg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-lr3gSQvSPXGEkokmH3FIIg-1; Mon, 01 Aug 2022 10:40:37 -0400
X-MC-Unique: lr3gSQvSPXGEkokmH3FIIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E694C85A587;
        Mon,  1 Aug 2022 14:40:36 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA143141510F;
        Mon,  1 Aug 2022 14:40:32 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 00/11] mm: ioremap:  Convert architectures to take GENERIC_IOREMAP way
Date:   Mon,  1 Aug 2022 22:40:18 +0800
Message-Id: <20220801144029.57829-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, many architecutres have't taken the standard GENERIC_IOREMAP
way to implement ioremap_prot(), iounmap(), and ioremap_xx(), but make
these functions specifically under each arch's folder. Those cause many
duplicated codes of ioremap() and iounmap().

In this patchset, firstly adapt the hooks io[re|un]map_allowed, then
make use of them to convert those ARCH-es to take GENERIC_IOREMAP method.
With these change, duplicated ioremap/iounmap() code uder ARCH-es are
removed.

This is suggested by Christoph in below discussion:
https://lore.kernel.org/all/Yp7h0Jv6vpgt6xdZ@infradead.org/T/#u

And it's basically further action after arm64 has converted to
GENERIC_IOREMAP way in below patchset.
[PATCH v5 0/6] arm64: Cleanup ioremap() and support ioremap_prot()
https://lore.kernel.org/all/20220607125027.44946-1-wangkefeng.wang@huawei.com/T/#u

And some change of io[re|un]map_allowed() is borrowed from the v3 of
arm64 converting patch.
[PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
https://lore.kernel.org/all/20220519082552.117736-5-wangkefeng.wang@huawei.com/T/#u

For patch 1~3, I don't merge them because I made them in different
rounds of changing. And splitting them makes me easily describe the
intention and make review easier. I can merge them after v1 reviewing
if anyone thinks they should be merged.

Testing:
It passes the testing on arm64 and s390. For other ARCHes, I only tried
to pass build with existing RPMs of cross compiling tools. ARCHes like
openrisc, parisc, don't build because of lack of cross compiling RPMS.

Baoquan He (11):
  mm/ioremap: change the return value of io[re|un]map_allowed
  mm: ioremap: fixup the physical address
  mm: ioremap: allow ARCH to have its own ioremap definition
  arc: mm: Convert to GENERIC_IOREMAP
  hexagon: mm: Convert to GENERIC_IOREMAP
  ia64: mm: Convert to GENERIC_IOREMAP
  openrisc: mm: Convert to GENERIC_IOREMAP
  parisc: mm: Convert to GENERIC_IOREMAP
  s390: mm: Convert to GENERIC_IOREMAP
  sh: mm: Convert to GENERIC_IOREMAP
  xtensa: mm: Convert to GENERIC_IOREMAP

 arch/arc/Kconfig               |  1 +
 arch/arc/include/asm/io.h      | 19 +++++++---
 arch/arc/mm/ioremap.c          | 60 +++++--------------------------
 arch/arm64/include/asm/io.h    |  3 +-
 arch/arm64/mm/ioremap.c        | 17 ++++++---
 arch/hexagon/Kconfig           |  1 +
 arch/hexagon/include/asm/io.h  |  9 +++--
 arch/hexagon/mm/ioremap.c      | 44 -----------------------
 arch/ia64/Kconfig              |  1 +
 arch/ia64/include/asm/io.h     | 26 ++++++++------
 arch/ia64/mm/ioremap.c         | 50 ++++++--------------------
 arch/openrisc/Kconfig          |  1 +
 arch/openrisc/include/asm/io.h | 16 ++++++---
 arch/openrisc/mm/ioremap.c     | 49 ++++++++-----------------
 arch/parisc/include/asm/io.h   | 16 ++++++---
 arch/parisc/mm/ioremap.c       | 66 ++++------------------------------
 arch/s390/Kconfig              |  1 +
 arch/s390/include/asm/io.h     | 26 +++++++++-----
 arch/s390/pci/pci.c            | 60 +++++--------------------------
 arch/sh/Kconfig                |  1 +
 arch/sh/include/asm/io.h       | 47 ++++++++----------------
 arch/sh/mm/ioremap.c           | 62 +++++++-------------------------
 arch/xtensa/Kconfig            |  1 +
 arch/xtensa/include/asm/io.h   | 39 ++++++++++----------
 arch/xtensa/mm/ioremap.c       | 56 +++++++----------------------
 include/asm-generic/io.h       | 24 +++++++------
 mm/ioremap.c                   | 21 ++++++-----
 27 files changed, 232 insertions(+), 485 deletions(-)
 delete mode 100644 arch/hexagon/mm/ioremap.c

-- 
2.34.1

