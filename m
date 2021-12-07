Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9FB46BF6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbhLGPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:38:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44810 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbhLGPiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:38:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D7D7C1FDFE;
        Tue,  7 Dec 2021 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638891284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qARKTbo9G6ScPvbRSX5Dxag6hsPtbHrp4hKKyJh8Mt8=;
        b=un06l9sxN3l9MR/SrnE+SXGQ1x8vb85AJ0Oi+lWvXdxAjiGzDlSVO8u5xePG2iynOGVhua
        XC4T49lpy5T0m9sfmG25uxyAvWtokryYwwFLOtNMfe4+mYc8Fb+a7mWm2aZeE69FhR60+P
        mLYk0j9uEVVEalgQYjXqG5LdaJpfqcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638891284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qARKTbo9G6ScPvbRSX5Dxag6hsPtbHrp4hKKyJh8Mt8=;
        b=ZzTvmMJzDgCf43VaD6XljWDogfl8+6+9TfdE8fubSBK5J6/RM6JAc9h2ylvtHSew5LRh8k
        UpX+oVwMnIydKyBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B4D713A92;
        Tue,  7 Dec 2021 15:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JmU/IRR/r2EIDAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Dec 2021 15:34:44 +0000
Message-ID: <5ead526d-8499-4810-7657-6af5f2e96ccc@suse.cz>
Date:   Tue, 7 Dec 2021 16:34:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-6-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 05/66] Maple Tree: Add new data structure
In-Reply-To: <20211201142918.921493-6-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The maple tree is an RCU-safe range based B-tree designed to use modern
> processor cache efficiently.  There are a number of places in the kernel
> that a non-overlapping range-based tree would be beneficial, especially
> one with a simple interface.  The first user that is covered in this
> patch set is the vm_area_struct, where three data structures are
> replaced by the maple tree: the augmented rbtree, the vma cache, and the
> linked list of VMAs in the mm_struct.  The long term goal is to reduce
> or remove the mmap_sem contention.
> 
> The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
> nodes.  With the increased branching factor, it is significantly shorter than
> the rbtree so it has fewer cache misses.  The removal of the linked list
> between subsequent entries also reduces the cache misses and the need to pull
> in the previous and next VMA during many tree alterations.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

For now just some comments, reviewing fully is obviously rather hard, even
when ignoring the tests...

> ---
>  Documentation/core-api/index.rst              |     1 +
>  Documentation/core-api/maple-tree.rst         |   496 +
>  MAINTAINERS                                   |    12 +
>  include/linux/maple_tree.h                    |   559 +
>  include/trace/events/maple_tree.h             |   123 +
>  lib/Kconfig.debug                             |     9 +
>  lib/Makefile                                  |     3 +-
>  lib/maple_tree.c                              |  6771 +++
>  lib/test_maple_tree.c                         | 37202 ++++++++++++++++
>  tools/testing/radix-tree/.gitignore           |     2 +
>  tools/testing/radix-tree/Makefile             |    13 +-
>  tools/testing/radix-tree/generated/autoconf.h |     1 +
>  tools/testing/radix-tree/linux/maple_tree.h   |     7 +
>  tools/testing/radix-tree/maple.c              |    59 +
>  .../radix-tree/trace/events/maple_tree.h      |     3 +
>  15 files changed, 45258 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/core-api/maple-tree.rst
>  create mode 100644 include/linux/maple_tree.h
>  create mode 100644 include/trace/events/maple_tree.h
>  create mode 100644 lib/maple_tree.c
>  create mode 100644 lib/test_maple_tree.c
>  create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
>  create mode 100644 tools/testing/radix-tree/maple.c
>  create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h
> 
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 5de2c7a4b1b3..b487373d8585 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -43,6 +43,7 @@ Library functionality that is used throughout the kernel.
>     this_cpu_ops
>     timekeeping
>     errseq
> +   maple-tree
>  
>  Concurrency primitives
>  ======================
> diff --git a/Documentation/core-api/maple-tree.rst b/Documentation/core-api/maple-tree.rst
> new file mode 100644
> index 000000000000..70ec7c2801e0
> --- /dev/null
> +++ b/Documentation/core-api/maple-tree.rst

In general this IMHO this could use some restructuring, right now it feels
like a mix of various implementation tidbits, while the usage of maple tree
seems to be just sketched.

The API functions in lib/maple_tree.c also seem to not have comments in the
proper doc format that starts with '/**' ?

> @@ -0,0 +1,496 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +
> +==========
> +Maple Tree
> +==========
> +
> +:Author: Liam R. Howlett
> +:Date: May 20, 2021
> +

...

> +Node Slots & Node Pivots
> +------------------------
> +
> +Leaf nodes do not store pointers to nodes, they store user data.
> +Users may store almost any bit pattern.  As noted above, the optimisation
> +of storing an entry at 0 in the root pointer cannot be done for data
> +which have the bottom two bits set to '10'.  We also reserve values
> +with the bottom two bits set to '10' which are below 4096 (ie 2, 6,
> +10 .. 4094) for internal use.  Some APIs return errnos as a negative
> +errno shifted right by two bits and the bottom two bits set to '10',
> +and while choosing to store these values in the array is not an error,
> +it may lead to confusion if you're testing for an error with mas_is_err().
> +
> +Non-leaf nodes store the type of the node pointed to (enum maple_type
> +in bits 3-6), bit 2 is reserved.  That leaves bits 0-1 unused for now.
> +
> +In regular B-Tree terms, pivots are called keys.  The term pivot is used
> +to indicate that the tree is specifying ranges,  Pivots may appear in
> +the subtree with an entry attached to the value whereas keys are unique
> +to a specific position of a B-tree.  Pivot values are inclusive of the
> +slot with the same index.
> +
> +
> +The following illustrates a partial layout of a range64 nodes slots and pivots.
> +
> +          _________________________________

This causes "make htmldocs" fail for me
Documentation/core-api/maple-tree.rst:248: (SEVERE/4) Unexpected section
title or transition.

> + Slots -> | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
> +          ┬   ┬   ┬   ┬   ┬   ┬   ┬   ┬   ┬
> +          │   │   │   │   │   │   │   │   └─ Implied maximum
> +          │   │   │   │   │   │   │   └─ Pivot 6
> +          │   │   │   │   │   │   └─ Pivot 5
> +          │   │   │   │   │   └─ Pivot 4
> +          │   │   │   │   └─ Pivot 3
> +          │   │   │   └─ Pivot 2
> +          │   │   └─ Pivot 1
> +          │   └─ Pivot 0
> +          └─  Implied minimum
> +
> +Slot contents:
> + Internal (non-leaf) nodes contain pointers to other nodes.
> + Leaf nodes contain entries.
> +
> +
> +Node Parent
> +-----------
> +
> +The node->parent of the root node has bit 0 set and the rest of the
> +pointer is a pointer to the tree itself.  No more bits are available in
> +this pointer (on m68k, the data structure may only be 2-byte aligned).
> +
> +Internal non-root nodes can only have maple_range_* nodes as parents.
> +The parent pointer is 256B aligned like all other tree nodes.
> +When storing a 32 or 64 bit values, the offset can fit into 4 bits.
> +The 16 bit values need an extra bit to store the offset.  This extra bit
> +comes from a reuse of the last bit in the node type.  This is possible
> +by using bit 1 to indicate if bit 2 is part of the type or the slot.
> +
> +Once the type is decided, the decision of an allocation range type
> +or a range type is done by examining the immutable tree flag for the
> +MAPLE_ALLOC_RANGE flag.
> +
> + Node types:
> +  0x??1 = Root
> +  0x?00 = 16 bit nodes
> +  0x010 = 32 bit nodes
> +  0x110 = 64 bit nodes
> +
> + Slot size and location in the parent pointer:
> +  type  : slot location
> +  0x??1 : Root
> +  0x?00 : 16 bit values, type in 0-1, slot in 2-6
> +  0x010 : 32 bit values, type in 0-2, slot in 3-6
> +  0x110 : 64 bit values, type in 0-2, slot in 3-6
> +
> +Node Metadata
> +-------------
> +
> +The node->meta is currently only supported in allocation range 64
> +(arange_64) node type.  As a result of tracking gaps, there is a small
> +area that is not used for data storage in this node type.  This area is
> +reused to store metadata related to the node itself including the data
> +end and the largest gap location.  This metadata is used to optimize
> +the gap updating code and in reverse searching for gaps or any other
> +code that needs to find the end of the data.
> +
> +Auxiliary Data
> +--------------
> +
> +At tree creation time, the user can specify that they're willing to
> +trade off storing fewer entries in a tree in return for storing more
> +information in each node.
> +
> +The maple tree supports recording the largest range of NULL entries
> +available in this node, also called gaps.  This optimises the tree for
> +allocating a range.
> +
> +
> +Maple State
> +-----------
> +
> +The maple state is defined in the struct ma_state and is used to keep
> +track of information during operations, and even between operations when
> +using the advanced API.
> +
> +If state->node has bit 0 set then it references a tree location which
> +is not a node (eg the root).  If bit 1 is set, the rest of the bits
> +are a negative errno.  Bit 2 (the 'unallocated slots' bit) is clear.
> +Bits 3-6 indicate the node type.
> +
> +state->alloc either has a request number of nodes or an allocated node.
> +If stat->alloc has a requested number of nodes, the first bit will be
> +set (0x1) and the remaining bits are the value.  If state->alloc is
> +a node, then the node will be of type maple_alloc.  maple_alloc has
> +MAPLE_NODE_SLOTS - 1 for storing more allocated nodes, a total, and
> +the node_count in this node.  total is the number of nodes allocated.
> +node_count is the number of allocated nodes in this node.  The scaling
> +beyond MAPLE_NODE_SLOTS - 1 is handled by storing further nodes into
> +state->alloc->slot[0]'s node.  Nodes are taken from state->alloc by
> +removing a node from the state->alloc node until state->alloc->node_count
> +is 1, when state->alloc is returned and the state->alloc->slot[0] is
> +promoted to state->alloc.  Nodes are pushed onto state->alloc by putting
> +the current state->alloc into the pushed node's slot[0].
> +
> +The state also contains the implied min/max of the state->node, the depth
> +of this search, and the offset. The implied min/max are either from the
> +parent node or are 0-oo for the root node.  The depth is incremented or
> +decremented every time a node is walked down or up.  The offset is the
> +slot/pivot of interest in the node - either for reading or writing.
> +
> +When returning a value the maple state index and last respectively contain
> +the start and end of the range for the entry.  Ranges are inclusive in
> +the Maple Tree.
> +
> +Tree Operations
> +===============
> +
> +Inserting
> +---------
> +
> +Inserting a new range inserts either 0, 1, or 2 pivots within the tree.
> +If the insert fits exactly into an existing gap with a value of NULL,
> +then the slot only needs to be written with the new value.  If the range
> +being inserted is adjacent to another range, then only a single pivot
> +needs to be inserted (as well as writing the entry).  If the new range
> +is within a gap but does not touch any other ranges, then two pivots
> +need to be inserted: the start - 1, and the end.  As usual, the entry
> +must be written.  Most operations require a new node to be allocated
> +and replace an existing node to ensure RCU safety, when in RCU mode.
> +The exception to requiring a newly allocated node is when inserting at
> +the end of a node (appending).  When done carefully, appending can reuse
> +the node in place.
> +
> +Storing
> +-------
> +
> +Storing is the same operation as insert with the added caveat that it
> +can overwrite entries.  Although this seems simple enough, one may want
> +to examine what happens if a single store operation was to overwrite
> +multiple entries within a self-balancing B-Tree.
> +
> +Erasing
> +-------
> +
> +Erasing is the same as a walk to an entry then a store of a NULL to
> +that entry.  In fact, it is implemented as such using the advanced API.
> +
> +Splitting
> +---------
> +
> +Splitting is handled differently from any other B-tree; the Maple Tree
> +splits up.  Splitting up means that the split operation occurs when the

"splits up" is confusing - "splits upwards" perhaps?

> +walk of the tree hits the leaves and not on the way down.  The reason
> +for splitting up is that it is impossible to know how much space will be
> +needed until the leaf (or leaves) are reached.  Since overwriting data
> +is allowed and a range could overwrite more than one range or result in
> +changing one entry into 3 entries, it is impossible to know if a split
> +is required until the data is examined.
> +
> +Splitting is a balancing act between keeping allocations to a minimum
> +and avoiding a 'jitter' event where a tree is expanded to make room
> +for an entry followed by a contraction when the entry is removed.
> +To accomplish the balance, there are empty slots remaining in both left
> +and right nodes after a split.
> +
> +Another way that 'jitter' is avoided is to terminate a split up early
> +if the left or right node has space to spare.  This is referred to as
> +"pushing left" or "pushing right" and is similar to the B* tree, except
> +the nodes left or right can rarely be reused due to RCU, but the ripple
> +upwards is halted which is a significant savings.
> +
> +To support gap tracking, all NULL entries are kept together and a node
> +cannot end on a NULL entry, with the exception of the left-most leaf.
> +The limitation means that the split of a node must be checked for this
> +condition and be able to put more data in one direction or the other.
> +
> +3-way Split
> +-----------
> +
> +Although extremely rare, it is possible to enter what is known as the
> +3-way split scenario.  The 3-way split comes about by means of a store
> +of a range that overwrites the end and beginning of two full nodes.
> +The result is a set of entries that cannot be stored in 2 nodes.
> +Sometimes, these two nodes can also be located in different parent nodes
> +which are also full.  This can carry upwards all the way to the root in
> +the worst case.
> +
> +Spanning Store
> +--------------
> +
> +A store operation that spans multiple nodes is called a spanning store and
> +is handled early in the store call stack by the function mas_is_span_wr().
> +When a spanning store is identified, the maple state is duplicated.
> +The first maple state walks the left tree path to ``index``, the duplicate
> +walks the right tree path to ``last``.  The data in the two nodes are
> +combined into a single node, two nodes, or possibly three nodes (see the
> +3-way split above).  A ``NULL`` written to the last entry of a node is
> +considered a spanning store as a rebalance is required for the operation
> +to complete and an overflow of data may happen.
> +
> +The tree needs to be rebalanced and leaves need to be kept at the same
> +level.  Rebalancing is done by use of the ``struct maple_topiary``.
> +The maple_topiary struct keeps track of which nodes to free and which
> +to destroy (free the subtree).  See mas_spanning_rebalance().
> +
> +Each level of the tree is examined and balanced in
> +mas_spanning_rebalance().  Again, pushing data to the left or right,
> +or rebalancing against left or right nodes is employed to avoid rippling
> +up the tree to limit the amount of churn.  Once a new sub-section of the
> +tree is created, there may be a mix of new and old nodes.  The old nodes
> +will have the incorrect parent pointers and currently be in two trees: the
> +original tree and the partially new tree.  To remedy the parent pointers
> +in the old tree, the new data is swapped into the active tree and a walk
> +down the tree is performed and the parent pointers are updated.  At each
> +level there may be up to 3 correct parent pointers which indicates the
> +new nodes which need to be walked to find any new nodes at a lower level.
> +See mas_descend_adopt().
> +
> +Rebalance
> +---------
> +
> +Rebalancing occurs if a node is insufficient.  Data is rebalanced against
> +the node to the right if it exists, otherwise the node to the left of
> +this node is rebalanced against this node.  If rebalancing causes just
> +one node to be produced instead of two, then the parent is also examined
> +and rebalanced if it is insufficient.  Every level tries to combine the
> +data in the same way.  If one node contains the entire range of the tree,
> +then that node is used as a new root node.
> +
> +Bulk Loading
> +------------
> +
> +Sometimes it is necessary to duplicate a tree to a new tree, such as
> +forking a process and duplicating the VMAs from one tree to a new tree.
> +When such a situation arises, it is known that the new tree is not
> +going to be used until the entire tree is populated.  For performance
> +reasons, it is best to use a bulk load with RCU disabled.  This allows
> +for optimistic splitting that favours the left and reuse of nodes during
> +the operation.  Upon completion, the mas_destroy() operation on the maple
> +state will check the left-most node and rebalance against the node to
> +the right if necessary.  mas_destroy() will also free any unused nodes.
> +
> +
> +The Maple State
> +===============
> +
> +The ma_state struct keeps track of tree operations to make life easier
> +for both internal and external tree users.
> +
> +Functions and structures
> +========================
> +
> +.. kernel-doc:: include/linux/maple_tree.h
> +.. kernel-doc:: lib/maple_tree.c
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5250298d2817..e61b3e56e4b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11305,6 +11305,18 @@ L:	linux-man@vger.kernel.org
>  S:	Maintained
>  W:	http://www.kernel.org/doc/man-pages
>  
> +MAPLE TREE
> +M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +L:	linux-mm@kvack.org
> +S:	Supported
> +F:	Documentation/core-api/maple_tree.rst
> +F:	include/linux/maple_tree.h
> +F:	include/trace/events/maple_tree.h
> +F:	lib/maple_tree.c
> +F:	lib/test_maple_tree.c
> +F:	tools/testing/radix-tree/linux/maple_tree.h
> +F:	tools/testing/radix-tree/maple.c
> +
>  MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
>  M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
>  L:	linux-mips@vger.kernel.org
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> new file mode 100644
> index 000000000000..a03c7850080a
> --- /dev/null
> +++ b/include/linux/maple_tree.h
> @@ -0,0 +1,559 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef _LINUX_MAPLE_TREE_H
> +#define _LINUX_MAPLE_TREE_H
> +/*
> + * Maple Tree - An RCU-safe adaptive tree for storing ranges
> + * Copyright (c) 2018 Oracle
> + * Authors:     Liam R. Howlett <Liam.Howlett@Oracle.com>
> + *              Matthew Wilcox <willy@infradead.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/rcupdate.h>
> +#include <linux/spinlock.h>
> +/* #define CONFIG_MAPLE_RCU_DISABLED */
> +/* #define CONFIG_DEBUG_MAPLE_TREE_VERBOSE */

Make this real config or remove?

> +
> +/*
> + * Allocated nodes are mutable until they have been inserted into the tree,
> + * at which time they cannot change their type until they have been removed
> + * from the tree and an RCU grace period has passed.
> + *
> + * Removed nodes have their ->parent set to point to themselves.  RCU readers
> + * check ->parent before relying on the value that they loaded from the
> + * slots array.  This lets us reuse the slots array for the RCU head.
> + *
> + * Nodes in the tree point to their parent unless bit 0 is set.
> + */
> +#if defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
> +/* 64bit sizes */
> +#define MAPLE_NODE_SLOTS	31	/* 256 bytes including ->parent */
> +#define MAPLE_RANGE64_SLOTS	16	/* 256 bytes */
> +#define MAPLE_ARANGE64_SLOTS	10	/* 240 bytes */
> +#define MAPLE_ARANGE64_META_MAX	15	/* Out of range for metadata */
> +#define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 1)
> +#else
> +/* 32bit sizes */
> +#define MAPLE_NODE_SLOTS	63	/* 256 bytes including ->parent */
> +#define MAPLE_RANGE64_SLOTS	32	/* 256 bytes */
> +#define MAPLE_ARANGE64_SLOTS	21	/* 240 bytes */
> +#define MAPLE_ARANGE64_META_MAX	22	/* Out of range for metadata */
> +#define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 2)
> +#endif /* defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64) */
> +
> +#define MAPLE_NODE_MASK		255UL
> +
> +typedef struct maple_enode *maple_enode; /* encoded node */
> +typedef struct maple_pnode *maple_pnode; /* parent node */
> +
> +
> +/**
> + * DOC: maple_tree node explained
> + *
> + * Each node type has a number of slots for entries and a number of slots for
> + * pivots.  In the case of dense nodes, the pivots are implied by the position
> + * and are simply the slot index + the minimum of the node.
> + *
> + * In regular B-Tree terms, pivots are called keys.  The term pivot is used to
> + * indicate that the tree is specifying ranges,  Pivots may appear in the
> + * subtree with an entry attached to the value where as keys are unique to a
> + * specific position of a B-tree.  Pivot values are inclusive of the slot with
> + * the same index.
> + *
> + *
> + * The following illustrates the layout of a range64 nodes slots and pivots.
> + *
> + *           _________________________________
> + *  Slots -> | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
> + *           ┬   ┬   ┬   ┬   ┬   ┬   ┬   ┬   ┬
> + *           │   │   │   │   │   │   │   │   └─ Implied maximum
> + *           │   │   │   │   │   │   │   └─ Pivot 6
> + *           │   │   │   │   │   │   └─ Pivot 5
> + *           │   │   │   │   │   └─ Pivot 4
> + *           │   │   │   │   └─ Pivot 3
> + *           │   │   │   └─ Pivot 2
> + *           │   │   └─ Pivot 1
> + *           │   └─ Pivot 0
> + *           └─  Implied minimum
> + *
> + * Slot contents:
> + *  Internal (non-leaf) nodes contain pointers to other nodes.
> + *  Leaf nodes contain entries.
> + *
> + *
> + */
> +struct maple_metadata {
> +	unsigned char end;
> +	unsigned char gap;
> +
> +};
> +
> +struct maple_range_64 {
> +	struct maple_pnode *parent;
> +		unsigned long pivot[MAPLE_RANGE64_SLOTS - 1];

Inconsistent ident.

> +	union {
> +		void __rcu *slot[MAPLE_RANGE64_SLOTS];
> +		struct {
> +			void __rcu *pad[MAPLE_RANGE64_SLOTS - 1];
> +			struct maple_metadata meta;
> +		};
> +	};
> +};
> +
> +struct maple_arange_64 {
> +	struct maple_pnode *parent;
> +	unsigned long pivot[MAPLE_ARANGE64_SLOTS - 1];
> +	void __rcu *slot[MAPLE_ARANGE64_SLOTS];
> +	unsigned long gap[MAPLE_ARANGE64_SLOTS];
> +	struct maple_metadata meta;
> +};
> +
> +struct maple_alloc {
> +	unsigned long total;
> +	unsigned char node_count;
> +	unsigned int request_count;
> +	struct maple_alloc *slot[MAPLE_ALLOC_SLOTS];
> +};
> +
> +struct maple_topiary {
> +	struct maple_pnode *parent;
> +	struct maple_enode *next; /* Overlaps the pivot */
> +};
> +
> +enum maple_type {
> +	maple_dense,
> +	maple_leaf_64,
> +	maple_range_64,
> +	maple_arange_64,
> +};
> +
> +
> +/**
> + * DOC: Maple tree flags
> + *
> + * * MT_FLAGS_ALLOC_RANGE	- Track gaps in this tree
> + * * MT_FLAGS_USE_RCU		- Operate in RCU mode

Inconsistent ident.

> + * * MT_FLAGS_HEIGHT_OFFSET	- The position of the tree height in the flags
> + * * MT_FLAGS_HEIGHT_MASK	- The mask for the maple tree height value
> + * * MT_FLAGS_LOCK_MASK		- How the mt_lock is used
> + * * MT_FLAGS_LOCK_IRQ		- Acquired irq-safe
> + * * MT_FLAGS_LOCK_BH		- Acquired bh-safe
> + * * MT_FLAGS_LOCK_EXTERN	- mt_lock is not used
> + *

...

> +
> +void mas_dup_tree(struct ma_state *oldmas, struct ma_state *mas);
> +void mas_dup_store(struct ma_state *mas, void *entry);
> +/* This finds an empty area from the highest address to the lowest.
> + * AKA "Topdown" version,
> + */

Bad comment form, also ends with a comma.

...

> +++ b/lib/maple_tree.c
> @@ -0,0 +1,6771 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Maple Tree implementation
> + * Copyright (c) 2018 Oracle Corporation
> + * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
> + *	    Matthew Wilcox <willy@infradead.org>
> + */
> +
> +#include <linux/maple_tree.h>
> +#include <linux/xarray.h>
> +#include <linux/types.h>
> +#include <linux/export.h>
> +#include <linux/slab.h>
> +#include <linux/limits.h>
> +#include <asm/barrier.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/maple_tree.h>
> +
> +#define MA_ROOT_PARENT 1
> +
> +/* Maple state flags */
> +#define MA_STATE_BULK		1
> +#define MA_STATE_REBALANCE	2
> +
> +#define ma_parent_ptr(x) ((struct maple_pnode *)(x))
> +#define ma_mnode_ptr(x) ((struct maple_node *)(x))
> +#define ma_enode_ptr(x) ((struct maple_enode *)(x))
> +static struct kmem_cache *maple_node_cache;
> +
> +static const unsigned long mt_max[] = {
> +	[maple_dense]		= MAPLE_NODE_SLOTS,
> +	[maple_leaf_64]		= ULONG_MAX,
> +	[maple_range_64]	= ULONG_MAX,
> +	[maple_arange_64]	= ULONG_MAX,
> +};
> +#define mt_node_max(x) mt_max[mte_node_type(x)]
> +
> +static const unsigned char mt_slots[] = {
> +	[maple_dense]		= MAPLE_NODE_SLOTS,
> +	[maple_leaf_64]		= MAPLE_RANGE64_SLOTS,
> +	[maple_range_64]	= MAPLE_RANGE64_SLOTS,
> +	[maple_arange_64]	= MAPLE_ARANGE64_SLOTS,
> +};
> +#define mt_slot_count(x) mt_slots[mte_node_type(x)]
> +
> +static const unsigned char mt_pivots[] = {
> +	[maple_dense]		= 0,
> +	[maple_leaf_64]		= MAPLE_RANGE64_SLOTS - 1,
> +	[maple_range_64]	= MAPLE_RANGE64_SLOTS - 1,
> +	[maple_arange_64]	= MAPLE_ARANGE64_SLOTS - 1,
> +};
> +#define mt_pivot_count(x) mt_pivots[mte_node_type(x)]
> +
> +static const unsigned char mt_min_slots[] = {
> +	[maple_dense]		= MAPLE_NODE_SLOTS / 2,
> +	[maple_leaf_64]		= (MAPLE_RANGE64_SLOTS / 2) - 2,
> +	[maple_range_64]	= (MAPLE_RANGE64_SLOTS / 2) - 2,
> +	[maple_arange_64]	= (MAPLE_ARANGE64_SLOTS / 2) - 1,
> +};
> +#define mt_min_slot_count(x) mt_min_slots[mte_node_type(x)]
> +
> +#define MAPLE_BIG_NODE_SLOTS	(MAPLE_RANGE64_SLOTS * 2 + 2)
> +
> +struct maple_big_node {
> +	struct maple_pnode *parent;
> +	struct maple_enode *slot[MAPLE_BIG_NODE_SLOTS];
> +	unsigned long pivot[MAPLE_BIG_NODE_SLOTS - 1];
> +	unsigned long gap[MAPLE_BIG_NODE_SLOTS];
> +	unsigned long min;
> +	unsigned char b_end;
> +	enum maple_type type;
> +};
> +
> +struct maple_subtree_state {
> +	struct ma_state *orig_l;	/* Original left side of subtree */
> +	struct ma_state *orig_r;	/* Original right side of subtree */
> +	struct ma_state *l;		/* New left side of subtree */
> +	struct ma_state *m;		/* New middle of subtree (rare) */
> +	struct ma_state *r;		/* New right side of subtree */
> +	struct ma_topiary *free;	/* nodes to be freed */
> +	struct ma_topiary *destroy;	/* Nodes to be destroyed (walked and freed) */
> +	struct maple_big_node *bn;
> +};
> +
> +/* Functions */
> +static inline struct maple_node *mt_alloc_one(gfp_t gfp)
> +{
> +	return kmem_cache_alloc(maple_node_cache, gfp | __GFP_ZERO);
> +}
> +
> +static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
> +{
> +	return kmem_cache_alloc_bulk(maple_node_cache, gfp | __GFP_ZERO, size,
> +				     nodes);
> +}
> +
> +static inline void mt_free_bulk(size_t size, void __rcu **nodes)
> +{
> +	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
> +}
> +
> +static void mt_free_rcu(struct rcu_head *head)
> +{
> +	struct maple_node *node = container_of(head, struct maple_node, rcu);
> +
> +	kmem_cache_free(maple_node_cache, node);
> +}
> +
> +/*
> + * ma_free_rcu() - Use rcu callback to free a maple node
> + * @node: The node to free
> + *
> + * The maple tree uses the parent pointer to indicate this node is no longer in
> + * use and will be freed.
> + */
> +static void ma_free_rcu(struct maple_node *node)
> +{
> +	node->parent = ma_parent_ptr(node);
> +	call_rcu(&node->rcu, mt_free_rcu);
> +}
> +
> +static unsigned int mt_height(const struct maple_tree *mt)
> +{
> +	return (mt->ma_flags & MT_FLAGS_HEIGHT_MASK) >> MT_FLAGS_HEIGHT_OFFSET;
> +}
> +
> +static void mas_set_height(struct ma_state *mas)
> +{
> +	unsigned int new_flags = mas->tree->ma_flags;
> +
> +	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
> +	BUG_ON(mas->depth > MAPLE_HEIGHT_MAX);
> +	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
> +	mas->tree->ma_flags = new_flags;
> +}
> +
> +static unsigned int mas_mt_height(struct ma_state *mas)
> +{
> +	return mt_height(mas->tree);
> +}
> +
> +static inline enum maple_type mte_node_type(const struct maple_enode *entry)
> +{
> +	return ((unsigned long)entry >> MAPLE_NODE_TYPE_SHIFT) &
> +		MAPLE_NODE_TYPE_MASK;
> +}
> +
> +static inline bool ma_is_dense(const enum maple_type type)
> +{
> +	return type < maple_leaf_64;
> +}
> +
> +static inline bool ma_is_leaf(const enum maple_type type)
> +{
> +	return type < maple_range_64;
> +}
> +
> +static inline bool mte_is_leaf(const struct maple_enode *entry)
> +{
> +	return ma_is_leaf(mte_node_type(entry));
> +}
> +
> +/*
> + * We also reserve values with the bottom two bits set to '10' which are
> + * below 4096
> + */
> +static inline bool mt_is_reserved(const void *entry)
> +{
> +	return ((unsigned long)entry < MAPLE_RESERVED_RANGE) &&
> +		xa_is_internal(entry);

It's weird to suddenly see xa_ prefix here (and below). AFAICS it's nowhere
declared that maple tree is derived from xarray so while it's not completely
surprising given the overlap of authors, wouldn't it be more robust if maple
tree had its own independent set of these helpers?

