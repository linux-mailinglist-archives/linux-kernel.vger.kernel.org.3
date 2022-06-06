Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD7F53E2E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiFFImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiFFIjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B25B340E5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654504768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ypMuOqTgTs5fR/SVFA8vgdnkIg+2FoxNQIZyHecvz0A=;
        b=UwWC42Ps8QgY4nZ9/faUqAnN1J4igVH8yehlS7M0zw/HKq8OXnMvVpbr79xdoBIrf3WmMD
        WrIENIv1QhrJE4Slci/yED1KTzbDJ43baoWTWInt47Yi7wmrXwI8fQBi8lyKTMBPzBunlL
        S+2Eb9+q36I57Y60fpZYY/QIHXzuzo4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-qbNHrptDO92AJQPUiBeNlw-1; Mon, 06 Jun 2022 04:39:25 -0400
X-MC-Unique: qbNHrptDO92AJQPUiBeNlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C3D9800882;
        Mon,  6 Jun 2022 08:39:25 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-14-4.pek2.redhat.com [10.72.14.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E2D71121314;
        Mon,  6 Jun 2022 08:39:21 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org
Cc:     npiggin@gmail.com, urezki@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/5] Cleanup patches of vmalloc
Date:   Mon,  6 Jun 2022 16:39:04 +0800
Message-Id: <20220606083909.363350-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanup patches found when reading vmalloc code.

Built kernel and run on x86_64 machine.

Baoquan He (5):
  mm/vmalloc: remove the unnecessary type check
  mm/vmalloc: remove the redundant boundary check
  mm/vmalloc: fix typo in local variable name
  mm/vmalloc: Add code comment for find_vmap_area_exceed_addr()
  mm: ioremap: rename ioremap_page_range() to ioremap_range()

 Documentation/ia64/aliasing.rst  |  2 +-
 arch/alpha/kernel/proto.h        |  2 +-
 arch/arc/mm/ioremap.c            |  2 +-
 arch/arm/mm/ioremap.c            |  6 +++---
 arch/arm64/mm/ioremap.c          |  2 +-
 arch/hexagon/mm/ioremap.c        |  2 +-
 arch/ia64/mm/ioremap.c           |  2 +-
 arch/mips/loongson64/init.c      |  2 +-
 arch/mips/mm/ioremap.c           |  2 +-
 arch/openrisc/mm/ioremap.c       |  2 +-
 arch/parisc/mm/ioremap.c         |  2 +-
 arch/powerpc/kernel/isa-bridge.c |  2 +-
 arch/powerpc/kernel/pci_64.c     |  2 +-
 arch/powerpc/mm/ioremap.c        |  2 +-
 arch/s390/pci/pci.c              |  2 +-
 arch/sh/kernel/cpu/sh4/sq.c      |  2 +-
 arch/sh/mm/ioremap.c             |  2 +-
 arch/x86/mm/ioremap.c            |  2 +-
 arch/xtensa/mm/ioremap.c         |  2 +-
 drivers/pci/pci.c                |  2 +-
 include/linux/io.h               |  4 ++--
 mm/ioremap.c                     |  2 +-
 mm/vmalloc.c                     | 27 ++++++++++++---------------
 23 files changed, 37 insertions(+), 40 deletions(-)

-- 
2.34.1

