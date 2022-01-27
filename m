Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070AF49DCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiA0IxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:53:19 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:45630 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiA0IxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:53:14 -0500
Received: by mail-ej1-f46.google.com with SMTP id me13so4109182ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CaL9t3AsQp1ZYiDVZvWjFHtM9JB6P8GTVRUEIS2tyyc=;
        b=u0AWYhgNB/tZf/MECjeE63U9afqzw7Jom0MOyEdfwIy1nDdUnNbyTq7iC6lKPzhZKa
         Z+7Tn7wEMj9b+Rqf2s6Rxmi3+9djYgWMIJFjaGWeMQ2Tw/b8kXdzU8elNToATrKGAazf
         1ZAEAj8MtTkri0s8I7siMQU38Mf/BmDYCOZoEdk+n2NycxsYOFixt539AS7J5yj3RyLi
         Y6fxqdNEBI6mY6llB9MuN5aFRhoUp5MwhFAM9Ju7hsEoiIxH4UINVhLIqn/WAfPcS90g
         ymMmYblqEXy3ayXDdTcE5vuogxMEZjTDjJmDpnId/IABI9k86nCm+mb+AG2phRLH3KlU
         Xs1Q==
X-Gm-Message-State: AOAM533SF5Kt+U5wtqwCvg66MmAyTIzi8vFNoMmS5Hhz5tPVy6watD1a
        wto8cwyyKVimd1cZMaiel7YgYWBN+Cc=
X-Google-Smtp-Source: ABdhPJxD4LFw9fZs9C/5RXAgDdIMDtUp3CBcfP2JInagP8elmbBkKKR+0VQfe8/RfIXH0WUNuX4NAg==
X-Received: by 2002:a17:907:9619:: with SMTP id gb25mr2148302ejc.426.1643273593161;
        Thu, 27 Jan 2022 00:53:13 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-47-31.eurotel.cz. [85.160.47.31])
        by smtp.gmail.com with ESMTPSA id n11sm11029757edv.52.2022.01.27.00.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:53:12 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: [PATCH 0/6] mm, memory_hotplug: handle unitialized numa node gracefully
Date:   Thu, 27 Jan 2022 09:52:59 +0100
Message-Id: <20220127085305.20890-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the previous version of this patchset has been posted her:
http://lkml.kernel.org/r/20211214100732.26335-1-mhocko@kernel.org

I have ended up with 6 patches in the end. The core of the fix is patch
2 which also links existing bug reports. The high level goal is to have
all possible numa nodes have their pgdat allocated and initialized so 
	for_each_possible_node(nid)
		NODE_DATA(nid)
will never return a garbage. This has proven to be problem in several
places when an offline numa node is used for an allocation just to
realize that node_data and therefore allocation fallback zonelists are
not initialized and such an allocation request blows up.

There were attempts to address that by checking node_online in several
places including the page allocator. This patchset approaches the
problem from a different perspective and instead of special casing,
which just adds a runtime overhead, it allocates pglist_data for each
possible node. This can add some memory overhead for platforms with high
number of possible nodes if they do not contain any memory. This should
be a rather rare configuration though.

How to test this? David has provided and excellent howto:
http://lkml.kernel.org/r/6e5ebc19-890c-b6dd-1924-9f25c441010d@redhat.com

Patches 1 and 3-6 are mostly cleanups. The patchset has been reviewed by
Rafael (thanks!) and the core fix tested by Rafael and Alexey (thanks to
both). David has tested as per instructions above and hasn't found any
fallouts in the memory hotplug scenarios.

Please consider for inclusion.

Thanks!

Diffstat:
 arch/ia64/mm/discontig.c       |  11 +---
 include/linux/memory_hotplug.h | 118 ++++++++++++++++++++---------------------
 mm/memcontrol.c                |  14 +----
 mm/memory_hotplug.c            |  55 ++++---------------
 mm/page_alloc.c                |  70 +++++++++++++++++++++---
 5 files changed, 133 insertions(+), 135 deletions(-)


