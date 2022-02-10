Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F984B1576
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbiBJSoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:44:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBJSoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:44:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA3D3F47
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644518653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l+XLmNfpk7cwkO7aL9H8IvEkM0xjiYWbU4+0Qm8z5bk=;
        b=DVXBSe/ggK1kbaQfj7e60oiEIXy9SvWYbr9BkIT1A9EQLF0A84vFdQwkYGOjVmHWbyIi4a
        cXAxT95gQnuwKV1oUkrJd1GAffnoFVGv2uVKjZJkoOw+Y6SgJrI1AeprF4t0SnVVC4gkWp
        +4MUxOInfixGzXLYQk+ikSrDM2svtfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-74t1Cr2mOeWedFW95Lp3Fg-1; Thu, 10 Feb 2022 13:44:07 -0500
X-MC-Unique: 74t1Cr2mOeWedFW95Lp3Fg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A06B92502;
        Thu, 10 Feb 2022 18:44:06 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 876F27E124;
        Thu, 10 Feb 2022 18:44:00 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/2] drivers/base/memory: determine and store zone for single-zone memory blocks
Date:   Thu, 10 Feb 2022 19:43:57 +0100
Message-Id: <20220210184359.235565-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on v5.17-rc3 and:
* [PATCH v1] drivers/base/memory: add memory block to memory group
  after registration succeeded [1]
* [PATCH v1] drivers/base/node: consolidate node device subsystem
  initialization in node_dev_init() [2]
Which are already in -next via -mm.

--

I remember talking to Michal in the past about removing
test_pages_in_a_zone(), which we use for:
* verifying that a memory block we intend to offline is really only managed
  by a single zone. We don't support offlining of memory blocks that are
  managed by multiple zones (e.g., multiple nodes, DMA and DMA32)
* exposing that zone to user space via
  /sys/devices/system/memory/memory*/valid_zones

Now that I identified some more cases where test_pages_in_a_zone() might
go wrong, and we received an UBSAN report (see patch #3), let's get rid of
this PFN walker.

So instead of detecting the zone at runtime with test_pages_in_a_zone() by
scanning the memmap, let's determine and remember for each memory block
if it's managed by a single zone. The stored zone can then be used for
the above two cases, avoiding a manual lookup using test_pages_in_a_zone().

This avoids eventually stumbling over uninitialized memmaps in corner
cases, especially when ZONE_DEVICE ranges partly fall into memory block
(that are responsible for managing System RAM).

Handling memory onlining is easy, because we online to exactly one zone.
Handling boot memory is more tricky, because we want to avoid scanning
all zones of all nodes to detect possible zones that overlap with the
physical memory region of interest. Fortunately, we already have code that
determines the applicable nodes for a memory block, to create sysfs links
-- we'll hook into that.

Patch #1 is a simple cleanup I had laying around for a longer time.
Patch #2 contains the main logic to remove test_pages_in_a_zone() and
further details.

v1 -> v2:
* Keep returning -EINVAL when we have multiple zones
* s/memory_block_set_nid/memory_block_add_nid/ and add proper documentation
* Move sanity "single zone" check after "memory hole" check
* Minor fixes for spelling mistakes

[1] https://lkml.kernel.org/r/20220128144540.153902-1-david@redhat.com
[2] https://lkml.kernel.org/r/20220203105212.30385-1-david@redhat.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>

David Hildenbrand (2):
  drivers/base/node: rename link_mem_sections() to
    register_memory_block_under_node()
  drivers/base/memory: determine and store zone for single-zone memory
    blocks

 drivers/base/memory.c          | 101 +++++++++++++++++++++++++++++++--
 drivers/base/node.c            |  18 +++---
 include/linux/memory.h         |  12 ++++
 include/linux/memory_hotplug.h |   6 +-
 include/linux/node.h           |  16 +++---
 mm/memory_hotplug.c            |  56 +++++-------------
 6 files changed, 139 insertions(+), 70 deletions(-)

-- 
2.34.1

