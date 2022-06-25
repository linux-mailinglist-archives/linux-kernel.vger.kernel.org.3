Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD7955A6D0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 06:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiFYENW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 00:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiFYENU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 00:13:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C361401A;
        Fri, 24 Jun 2022 21:13:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 65so4134800pfw.11;
        Fri, 24 Jun 2022 21:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mr5shzl13r+vYnCYzjUyB9QMXbbWANAxHL0nyR6EkrM=;
        b=j8qTYW5NJu4W32prbYl+0LFabEqWxcw7KbHTKyTXLEiWAhbbIairQxRary5jGgs+qO
         IA6v3HfGuU4voe8/HCVMfxsd1+s51Z0W9dDv1pdnNrJiwx3mlJpa3lZ1eF3PswTts2g6
         +BrIKJ0TR10Ii5rYlI+epXnjyOXy15rhtE3rJ0KIRGRlLVJft90duC83lz1xjv4nJN5x
         LyVrXIYvxdQ1gIvTvVLR2sU7//h2GcmD5HiIKQVglVewupYHjC5frStxaVsoGh9oKXA0
         Pt3D6VSY8P93erBrnXJxuU7EwPRNC9lgOswhLhLf2m5BjRu5lDw/Iw01/ra0vusEkxZN
         uwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mr5shzl13r+vYnCYzjUyB9QMXbbWANAxHL0nyR6EkrM=;
        b=mFvbJjzsQESrNA1k5E/qOtqAn/c9qSweUhLmOmmRC10mJ3TgFbYSTFz9O0ClaRSMiq
         FbqYhDBSpbIrrh/GY3b5OIwIicM6dpfVKChd9jfG3uQvEdLMa9J0yEh3k6wSdQ063a0Z
         zfkV3+UOCzqzzywXgvWhQWXUDIlk5I2I/TfW3zpLqEHUDSdFb6Bd2YnKc4edMn9pPJga
         v5XWF8gF4cxAXAiNAOX/IK2VMJtcBgJgxjARS3lBjE5EXsc8+ngRfKNOUyXiwboCDqbF
         1kKGaPKo5sYA4QzSaseW5N1npSh0F1nqcUdnKt6bN58iv2lzjEedhrXaRPNvb7RNQGPv
         2clA==
X-Gm-Message-State: AJIora9DGQZ3d43MdIJD51+FhsBwP7KW7juXfR9WehU4RIUVgFCoJ+/Y
        aDLeU4uAAKV5N/DiqdvE5dzKX3AnwS9ciw==
X-Google-Smtp-Source: AGRyM1vvMtxsAP4aCW3R/tRfLt7Wqqg0E6/gUcve6ydGvvgoT4J79qo70FBsWrru+JaFP/0lSc5XRw==
X-Received: by 2002:a63:f506:0:b0:3fc:962b:6e02 with SMTP id w6-20020a63f506000000b003fc962b6e02mr2047242pgh.266.1656130398017;
        Fri, 24 Jun 2022 21:13:18 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-71.three.co.id. [180.214.233.71])
        by smtp.gmail.com with ESMTPSA id bx10-20020a17090af48a00b001e0c5da6a51sm2557820pjb.50.2022.06.24.21.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 21:13:17 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0B55D102D21; Sat, 25 Jun 2022 11:13:13 +0700 (WIB)
Date:   Sat, 25 Jun 2022 11:13:13 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 11/12] mm/demotion: Add documentation for memory
 tiering
Message-ID: <YraLWdkqv7irf3MV@debian.me>
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
 <20220622082513.467538-12-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622082513.467538-12-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 01:55:12PM +0530, Aneesh Kumar K.V wrote:
> From: Jagdish Gediya <jvgediya@linux.ibm.com>
> 

Hi Aneesh and Jagdish,

The documentation can be improved, see below.

> All N_MEMORY nodes are divided into 3 memoty tiers with tier ID value
> MEMORY_TIER_HBM_GPU, MEMORY_TIER_DRAM and MEMORY_TIER_PMEM. By default,
> all nodes are assigned to default memory tier.
> 
> Demotion path for all N_MEMORY nodes is prepared based on the tier ID value
> of memory tiers.
> 
> This patch adds documention for memory tiering introduction, its sysfs
> interfaces and how demotion is performed based on memory tiers.
> 

I think the patch message should just be:
"Add documentation for memory tiering. It also covers its sysfs
interfaces and how demotion is performed based on memory tiers."

> +===========
> +Memory tiers
> +============
> +
> +This document describes explicit memory tiering support along with
> +demotion based on memory tiers.
> +

This causes htmldocs error, for which I have applied the fixup at [1].

> +Memory nodes are divided into 3 types of memory tiers with tier ID
> +value as shown based on their hardware characteristics.
> +
> +
> +MEMORY_TIER_HBM_GPU
> +MEMORY_TIER_DRAM
> +MEMORY_TIER_PMEM
> +

Use bullet list.

> +Sysfs interfaces
> +================
> +
> +Nodes belonging to specific tier can be read from,
> +/sys/devices/system/memtier/memtierN/nodelist (Read-Only)
> +
> +Where N is 0 - 2.

The "where" sentence can be compounded into the previous sentence above.

> +
> +Example 1:
> +For a system where Node 0 is CPU + DRAM nodes, Node 1 is HBM node,
> +node 2 is a PMEM node an ideal tier layout will be
> +
> +$ cat /sys/devices/system/memtier/memtier0/nodelist
> +1
> +$ cat /sys/devices/system/memtier/memtier1/nodelist
> +0
> +$ cat /sys/devices/system/memtier/memtier2/nodelist
> +2
> +

The code snippets should have been inside literal code blocks.

> +Example 2:
> +For a system where Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM
> +nodes.
> +
> +$ cat /sys/devices/system/memtier/memtier0/nodelist
> +cat: /sys/devices/system/memtier/memtier0/nodelist: No such file or
> +directory
> +$ cat /sys/devices/system/memtier/memtier1/nodelist
> +0-1
> +$ cat /sys/devices/system/memtier/memtier2/nodelist
> +2-3
> +

Use literal code block.

> +Default memory tier can be read from,
> +/sys/devices/system/memtier/default_tier (Read-Only)
> +
> +e.g.
> +$ cat /sys/devices/system/memtier/default_tier
> +memtier200
> +
> +Max memory tier ID supported can be read from,
> +/sys/devices/system/memtier/max_tier (Read-Only)
> +
> +e.g.
> +$ cat /sys/devices/system/memtier/max_tier
> +400
> +
> +Individual node's memory tier can be read of set using,
> +/sys/devices/system/node/nodeN/memtier	(Read-Write)
> +
> +where N = node id
> +
> +When this interface is written, Node is moved from the old memory tier
> +to new memory tier and demotion targets for all N_MEMORY nodes are
> +built again.
> +
> +For example 1 mentioned above,
> +$ cat /sys/devices/system/node/node0/memtier
> +1
> +$ cat /sys/devices/system/node/node1/memtier
> +0
> +$ cat /sys/devices/system/node/node2/memtier
> +2
> +

The same suggestions above apply here, too.

> +Enable/Disable demotion
> +-----------------------
> +
> +By default demotion is disabled, it can be enabled/disabled using
> +below sysfs interface,
> +
> +$ echo 0/1 or false/true > /sys/kernel/mm/numa/demotion_enabled
> +

Use literal code block.

> +preferred and allowed demotion nodes
> +------------------------------------
> +
> +Preferred nodes for a specific N_MEMORY node are the best nodes
> +from the next possible lower memory tier. Allowed nodes for any
> +node are all the nodes available in all possible lower memory
> +tiers.
> +
> +Example:
> +
> +For a system where Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM
> +nodes,
> +
> +node distances:
> +node   0    1    2    3
> +   0  10   20   30   40
> +   1  20   10   40   30
> +   2  30   40   10   40
> +   3  40   30   40   10
> +

Use reST table.

> +memory_tiers[0] = <empty>
> +memory_tiers[1] = 0-1
> +memory_tiers[2] = 2-3
> +
> +node_demotion[0].preferred = 2
> +node_demotion[0].allowed   = 2, 3
> +node_demotion[1].preferred = 3
> +node_demotion[1].allowed   = 3, 2
> +node_demotion[2].preferred = <empty>
> +node_demotion[2].allowed   = <empty>
> +node_demotion[3].preferred = <empty>
> +node_demotion[3].allowed   = <empty>
> +

What are these above? Node properties? BTW, use literal code block.

If you don't understand these suggestions above, here is the diff:

---- >8 ----

diff --git a/Documentation/admin-guide/mm/memory-tiering.rst b/Documentation/admin-guide/mm/memory-tiering.rst
index 0a75e0dab1fd8e..10ec5aab6ddd53 100644
--- a/Documentation/admin-guide/mm/memory-tiering.rst
+++ b/Documentation/admin-guide/mm/memory-tiering.rst
@@ -14,13 +14,13 @@ Introduction
 
 Many systems have multiple types of memory devices e.g. GPU, DRAM and
 PMEM. The memory subsystem of these systems can be called a memory
-tiering system because the performance of the different types of
+tiering system because the performance of each type of
 memory is different. Memory tiers are defined based on the hardware
 capabilities of memory nodes. Each memory tier is assigned a tier ID
 value that determines the memory tier position in demotion order.
 
 The memory tier assignment of each node is independent of each
-other. Moving a node from one tier to another tier doesn't affect
+other. Moving a node from one tier to another doesn't affect
 the tier assignment of any other node.
 
 Memory tiers are used to build the demotion targets for nodes. A node
@@ -32,10 +32,9 @@ Memory tier rank
 Memory nodes are divided into 3 types of memory tiers with tier ID
 value as shown based on their hardware characteristics.
 
-
-MEMORY_TIER_HBM_GPU
-MEMORY_TIER_DRAM
-MEMORY_TIER_PMEM
+  * MEMORY_TIER_HBM_GPU
+  * MEMORY_TIER_DRAM
+  * MEMORY_TIER_PMEM
 
 Memory tiers initialization and (re)assignments
 ===============================================
@@ -49,68 +48,73 @@ hotplug, the memory tier with default tier ID is assigned to the memory node.
 Sysfs interfaces
 ================
 
-Nodes belonging to specific tier can be read from,
-/sys/devices/system/memtier/memtierN/nodelist (Read-Only)
+Nodes belonging to specific tier can be read from
+/sys/devices/system/memtier/memtierN/nodelist, where N is 0 - 2 (read-only)
 
-Where N is 0 - 2.
+Examples:
 
-Example 1:
-For a system where Node 0 is CPU + DRAM nodes, Node 1 is HBM node,
-node 2 is a PMEM node an ideal tier layout will be
+1. On a system where Node 0 is CPU + DRAM nodes, Node 1 is HBM node,
+   node 2 is a PMEM node an ideal tier layout will be:
 
-$ cat /sys/devices/system/memtier/memtier0/nodelist
-1
-$ cat /sys/devices/system/memtier/memtier1/nodelist
-0
-$ cat /sys/devices/system/memtier/memtier2/nodelist
-2
+   .. code-block::
 
-Example 2:
-For a system where Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM
-nodes.
+      $ cat /sys/devices/system/memtier/memtier0/nodelist
+      1
+      $ cat /sys/devices/system/memtier/memtier1/nodelist
+      0
+      $ cat /sys/devices/system/memtier/memtier2/nodelist
+      2
 
-$ cat /sys/devices/system/memtier/memtier0/nodelist
-cat: /sys/devices/system/memtier/memtier0/nodelist: No such file or
-directory
-$ cat /sys/devices/system/memtier/memtier1/nodelist
-0-1
-$ cat /sys/devices/system/memtier/memtier2/nodelist
-2-3
+2. On a system where Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM
+   nodes:
 
-Default memory tier can be read from,
-/sys/devices/system/memtier/default_tier (Read-Only)
+   .. code-block::
 
-e.g.
-$ cat /sys/devices/system/memtier/default_tier
-memtier200
+      $ cat /sys/devices/system/memtier/memtier0/nodelist
+      cat: /sys/devices/system/memtier/memtier0/nodelist: No such file or
+      directory
+      $ cat /sys/devices/system/memtier/memtier1/nodelist
+      0-1
+      $ cat /sys/devices/system/memtier/memtier2/nodelist
+      2-3
 
-Max memory tier ID supported can be read from,
-/sys/devices/system/memtier/max_tier (Read-Only)
+Default memory tier can be read from
+/sys/devices/system/memtier/default_tier (read-only), e.g.:
 
-e.g.
-$ cat /sys/devices/system/memtier/max_tier
-400
+.. code-block::
 
-Individual node's memory tier can be read of set using,
-/sys/devices/system/node/nodeN/memtier	(Read-Write)
+   $ cat /sys/devices/system/memtier/default_tier
+   memtier200
 
-where N = node id
+Max memory tier ID supported can be read from
+/sys/devices/system/memtier/max_tier (read-only), e.g.:
 
-When this interface is written, Node is moved from the old memory tier
+.. code-block::
+
+   $ cat /sys/devices/system/memtier/max_tier
+   400
+
+Individual node's memory tier can be read or set using
+/sys/devices/system/node/nodeN/memtier (read-write), where N = node id.
+
+When this interface is written, node is moved from the old memory tier
 to new memory tier and demotion targets for all N_MEMORY nodes are
 built again.
 
-For example 1 mentioned above,
-$ cat /sys/devices/system/node/node0/memtier
-1
-$ cat /sys/devices/system/node/node1/memtier
-0
-$ cat /sys/devices/system/node/node2/memtier
-2
+For example 1 mentioned above:
+
+.. code-block::
+
+   $ cat /sys/devices/system/node/node0/memtier
+   1
+   $ cat /sys/devices/system/node/node1/memtier
+   0
+   $ cat /sys/devices/system/node/node2/memtier
+   2
 
 Additional memory tiers can be created by writing a tier ID value to this file.
-This results in a new memory tier creation and moving the specific NUMA node to
-that memory tier.
+This results into creating a new tier and moving the specific NUMA node to
+that tier.
 
 Demotion
 ========
@@ -128,19 +132,20 @@ be used.
 
 Instead of a page being discarded during reclaim, it can be moved to
 persistent memory. Allowing page migration during reclaim enables
-these systems to migrate pages from fast(higher) tiers to slow(lower)
-tiers when the fast(higher) tier is under pressure.
+these systems to migrate pages from fast (higher) tiers to slow (lower)
+tiers when the fast (higher) tier is under pressure.
 
 
 Enable/Disable demotion
 -----------------------
 
-By default demotion is disabled, it can be enabled/disabled using
-below sysfs interface,
+By default demotion is disabled. It can be toggled by:
 
-$ echo 0/1 or false/true > /sys/kernel/mm/numa/demotion_enabled
+.. code-block::
 
-preferred and allowed demotion nodes
+   $ echo 0/1 or false/true > /sys/kernel/mm/numa/demotion_enabled
+
+Preferred and allowed demotion nodes
 ------------------------------------
 
 Preferred nodes for a specific N_MEMORY node are the best nodes
@@ -148,35 +153,40 @@ from the next possible lower memory tier. Allowed nodes for any
 node are all the nodes available in all possible lower memory
 tiers.
 
-Example:
+For example, on a system where Node 0 & 1 are CPU + DRAM nodes,
+node 2 & 3 are PMEM nodes:
 
-For a system where Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM
-nodes,
+  * node distances
 
-node distances:
-node   0    1    2    3
-   0  10   20   30   40
-   1  20   10   40   30
-   2  30   40   10   40
-   3  40   30   40   10
+    ====  ==   ==   ==   ==
+    node   0    1    2    3
+    ====  ==   ==   ==   ==
+       0  10   20   30   40
+       1  20   10   40   30
+       2  30   40   10   40
+       3  40   30   40   10
+    ====  ==   ==   ==   ==
 
-memory_tiers[0] = <empty>
-memory_tiers[1] = 0-1
-memory_tiers[2] = 2-3
+  * node properties
 
-node_demotion[0].preferred = 2
-node_demotion[0].allowed   = 2, 3
-node_demotion[1].preferred = 3
-node_demotion[1].allowed   = 3, 2
-node_demotion[2].preferred = <empty>
-node_demotion[2].allowed   = <empty>
-node_demotion[3].preferred = <empty>
-node_demotion[3].allowed   = <empty>
+    .. code-block::
+
+       memory_tiers[0] = <empty>
+       memory_tiers[1] = 0-1
+       memory_tiers[2] = 2-3
+
+       node_demotion[0].preferred = 2
+       node_demotion[0].allowed   = 2, 3
+       node_demotion[1].preferred = 3
+       node_demotion[1].allowed   = 3, 2
+       node_demotion[2].preferred = <empty>
+       node_demotion[2].allowed   = <empty>
+       node_demotion[3].preferred = <empty>
+       node_demotion[3].allowed   = <empty>
 
 Memory allocation for demotion
 ------------------------------
 
-If a page needs to be demoted from any node, the kernel 1st tries
-to allocate a new page from the node's preferred node and fallbacks to
-node's allowed targets in allocation fallback order.
-
+If a page needs to be demoted from any node, the kernel first tries
+to allocate a new page from the node's preferred target node and fallbacks
+to node's allowed targets in allocation fallback order.


Thanks.

[1]: https://lore.kernel.org/linux-doc/YrZ5cTFOSuWxlF2t@debian.me/

-- 
An old man doll... just what I always wanted! - Clara
