Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63405702ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiGKMnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiGKMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:43:13 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 05:43:10 PDT
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2DC3C8DE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657542474; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mTYrTnKkEr+cHoZzwUWzoySyMDYwyJHGayRwmV3goFkvb4OBV7RimTOzTY/Lj0PfO9bJNJ3PFdQVj4sAYijZMxmUgZVI+awVdfE82SDlv0iyXWH/UkMb/Q1ARhKlHLdTLsP8gCoOnyRsB/Yb/znNDUaQN040rgBG1qML8nFAB+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657542474; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=ewN4EUuycObOYW0SLHnXrpbyF2hcjOKmDmqQa9qow+Q=; 
        b=eonyWLjjL3dIAg04CjrercdmL0p9ChaAeFzDHnjHy3ulSUQJe01/0daekqfQsLnJiD63hjiyfsoNvYFf3eRKbF5+RaNIyi84nicZcoFYcBX+zpbZ+Vm96+B0NnsqOEKeHDKUCSTwbiStYUq5IdQ7hi+kkPM14/BVfTSqjNKmdPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657542474;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=ewN4EUuycObOYW0SLHnXrpbyF2hcjOKmDmqQa9qow+Q=;
        b=O+f//ihUMnagKkZDjAeTqyZlBVXpvNhbaP8ksXbo7DOIOguy4f81+zQbl40Lb4Wm
        VIs5WyE5xPgp6xVrmMZRnc6Yp7E6hOqqXfSoPdl1u/gSNQUzL0Blf8H3tLbe4YASgLE
        xezfb81h0A0FGgB/yxIbvk+mZsrjHSXjyMXm2M0o=
Received: from sh-lchen.ambarella.net (180.169.129.130 [180.169.129.130]) by mx.zohomail.com
        with SMTPS id 1657542473449720.3148602247644; Mon, 11 Jul 2022 05:27:53 -0700 (PDT)
From:   Li Chen <me@linux.beauty>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Chen <me@linux.beauty>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/4] add struct page and Direct I/O support to reserved memory
Date:   Mon, 11 Jul 2022 20:24:50 +0800
Message-Id: <20220711122459.13773-1-me@linux.beauty>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series use ZONE_DEVICE and mhp to add Direct I/O support to reserved memory
when rmem is as dio's src buffer.

Our use case is when isp generates frame and writes to given memory region, arm(kernel) will
try to read frames from the reserved memory region. If throughput is low, frame loss
will be serious.

Before this patch series, we can only use bufferd I/O and the throughput is very low even
with the help of AIO/io_uring.

This patch is tested on v5.15.35 + no-map rmem region, and can be git am into
5.19-rc5 without conflicts.

Li Chen (4):
  of: add struct page support to rmem
  mm/sparse: skip no-map memblock check when fill_subsection_map
  arm64: mm: move memblock_clear_nomap after __add_pages
  sample/reserved_mem: Introduce a sample of struct page and dio support
    to no-map rmem

 arch/arm64/mm/mmu.c             |   2 +-
 drivers/of/Kconfig              |   9 ++
 drivers/of/of_reserved_mem.c    | 218 +++++++++++++++++++++++++++++++-
 include/linux/of_reserved_mem.h |  11 ++
 mm/sparse.c                     |   4 +-
 samples/Kconfig                 |   7 +
 samples/Makefile                |   1 +
 samples/reserved_mem/Makefile   |   2 +
 samples/reserved_mem/rmem_dio.c | 116 +++++++++++++++++
 9 files changed, 367 insertions(+), 3 deletions(-)
 create mode 100755 samples/reserved_mem/Makefile
 create mode 100755 samples/reserved_mem/rmem_dio.c

-- 
2.25.1

