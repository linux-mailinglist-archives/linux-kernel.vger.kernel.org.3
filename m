Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6411D49FCC2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349411AbiA1P0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:26:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232396AbiA1P0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643383592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5TByn2+H7Z/Q1nf1GVCZH5w6HMAy4Lol4pqxeNfQkI8=;
        b=HtUO4OrNdT+FDnrW3pgYOpj1XWmQ2GN8BXSvIo2WHm9kWKO64E00t/NDxyrEoBKWsFkX/A
        Z3O+P1TevUSARy7Tlc9zuuAFOfsAdPx1oexzTMAxhCY1zPi+GRH4pytK60jmuyBGEQM1jU
        CVHg3JLRDz6Z/GQWxEVRLQojSJlZL0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-TPK6_5vpODm541tbgA5WSA-1; Fri, 28 Jan 2022 10:26:29 -0500
X-MC-Unique: TPK6_5vpODm541tbgA5WSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A695100CCC2;
        Fri, 28 Jan 2022 15:26:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F01307CAD6;
        Fri, 28 Jan 2022 15:26:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 0/2] drivers/base/memory: determine and store zone for single-zone memory blocks
Date:   Fri, 28 Jan 2022 16:26:18 +0100
Message-Id: <20220128152620.168715-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on v5.17-rc1 and:
* [PATCH v1] drivers/base/memory: add memory block to memory group
  after registration succeeded [1]
* [PATCH RFC v1] drivers/base/node: consolidate node device subsystem
  initialization in node_dev_init() [2]

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

In theory, we could do without [2], however, with a consolidated node
device initialization logic it's easier to verify that we actually have the
information we need (NIDs for memory blocks) around at the right time and
before anything else might rely on it.

[1] https://lkml.kernel.org/r/20220128144540.153902-1-david@redhat.com
[2] https://lkml.kernel.org/r/20220128151540.164759-1-david@redhat.com

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

 drivers/base/memory.c          | 92 ++++++++++++++++++++++++++++++++--
 drivers/base/node.c            | 18 +++----
 include/linux/memory.h         | 13 +++++
 include/linux/memory_hotplug.h |  6 +--
 include/linux/node.h           | 16 +++---
 mm/memory_hotplug.c            | 58 ++++-----------------
 6 files changed, 127 insertions(+), 76 deletions(-)

-- 
2.34.1

