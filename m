Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B6A4A768E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346148AbiBBRLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:11:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47140 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiBBRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:11:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 637DAB81CA6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 17:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4A0C004E1;
        Wed,  2 Feb 2022 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643821872;
        bh=pu3bx4iXnMAjQRXJKN+VhqeBmhS6zV6w+q9P2aNnVP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsvPyjbVXgfyXONj3oXnunt2FfqRRS6FENdTjoRKMV35IWqFULFYH9FTztkJU6ehl
         2f6/gkQolrLE2Z3CILQk/XCEY2+X+NjC4+WxNPLZ1KGY/L4ZM3jnZp/lmme6/50py0
         TT67712jzMjT6leF1gldhSQ2eesvM9niPzkBjCdIVdMCP+8y6z1VVUzCquamGKlwov
         OBB9jA1u7r8FV3mIJIm4sE1YFThE9hZGdL6SCpvMdHbW+B3KjR4KhT5VoJk3ed8oUJ
         PTHqFavO0rJrHZYmOm/HQtpr6eThKnheuJvQFY+VqO7iofp6Ehv7ZPYL9dJ7ohH5+W
         eb7xbY57hwdAw==
Date:   Wed, 2 Feb 2022 19:11:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 07/70] Maple Tree: Add new data structure
Message-ID: <Yfq7J9LU58FqNFVW@kernel.org>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
 <20220202024137.2516438-8-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202024137.2516438-8-Liam.Howlett@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Wed, Feb 02, 2022 at 02:41:56AM +0000, Liam Howlett wrote:
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
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  Documentation/core-api/index.rst              |    1 +
>  Documentation/core-api/maple_tree.rst         |  196 +
>  MAINTAINERS                                   |   12 +
>  include/linux/maple_tree.h                    |  673 ++
>  include/trace/events/maple_tree.h             |  123 +
>  lib/Kconfig.debug                             |    9 +
>  lib/Makefile                                  |    3 +-
>  lib/maple_tree.c                              | 6943 +++++++++++++++++
>  tools/testing/radix-tree/.gitignore           |    2 +
>  tools/testing/radix-tree/Makefile             |   13 +-
>  tools/testing/radix-tree/generated/autoconf.h |    1 +
>  tools/testing/radix-tree/linux/maple_tree.h   |    7 +
>  tools/testing/radix-tree/maple.c              |   59 +
>  .../radix-tree/trace/events/maple_tree.h      |    3 +
>  14 files changed, 8042 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/core-api/maple_tree.rst
>  create mode 100644 include/linux/maple_tree.h
>  create mode 100644 include/trace/events/maple_tree.h
>  create mode 100644 lib/maple_tree.c
>  create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
>  create mode 100644 tools/testing/radix-tree/maple.c
>  create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h
> 
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 5de2c7a4b1b3..c669e0abcfd6 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -34,6 +34,7 @@ Library functionality that is used throughout the kernel.
>     kref
>     assoc_array
>     xarray
> +   maple_tree
>     idr
>     circular-buffers
>     rbtree
> diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
> new file mode 100644
> index 000000000000..06c54230d985
> --- /dev/null
> +++ b/Documentation/core-api/maple_tree.rst
> @@ -0,0 +1,196 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +
> +==========
> +Maple Tree
> +==========
> +
> +:Author: Liam R. Howlett
> +
> +Overview
> +========
> +
> +The Maple Tree is a B-Tree data type which is optimized for storing
> +non-overlapping ranges, including ranges of size 1.  The tree was designed to
> +be simple to use and does not require a user written search method.  It
> +supports iterating over a range of entries and going to the previous or next in

                                                                         entry ^

> +a cache-efficient manner.  The tree can also be put into an RCU-safe mode of
> +operation which allows reading and writing concurrently.  Writers must
> +synchronize on a lock, which can be the default spinlock, or the user can set
> +the lock to an external lock of a different type.
> +
> +The Maple Tree maintains a small memory footprint and was designed to use
> +modern processor cache efficiently.  The most important user of the Maple Tree
> +is the virtual memory area.

For me it sounds like VMA *is* the maple tree user. Maybe

  The most important usage of the Maple Tree is tracking of the virtual
  memory areas.

> +
> +The Maple Tree can store between 0 and ``ULONG_MAX``.  The Maple Tree reserves

                          ^ values

> +values with the bottom two bits set to '10' which are below 4096 (ie 2, 6, 10
> +.. 4094) for internal use.  If the entries may use reserved entries then the
> +users can convert the entries using xa_mk_value() and convert them back by

Maybe

  If an entry needs to use a reserved value then the user can convert the
  value using ...

> +calling xa_to_value().  The reserved values can be used by the advanced API,
> +but are blocked by the normal API.

I'd add a sentence about existence of "normal" and "advanced" API to the
first two paragraphs.

> +
> +The Maple Tree can also be configured to support searching for a gap of a given
> +size (or larger).  The tree must be initialized as an allocation tree to
> +support this feature.

I afraid it's not clear at this point what "an allocation tree" means. I
think the first sentence alone would be enough for the overview section.

> +
> +Pre-allocating of nodes is also supported using the advanced API.  This is
> +useful for users who must guarantee a successful store operation within a given
> +code segment when allocating cannot be done.  Allocations of nodes are
> +relatively small at 256 bytes.

I doubt the size here will get timely updates when the node size will
change in the code, maybe use "around" or "roughly" to be future proof? :)

> +
> +Normal API
> +==========
> +
> +Start by initialising a maple tree, either with DEFINE_MTREE() for statically
> +allocated maple trees or mt_init() for dynamically allocated ones.  A
> +freshly-initialised maple tree contains a ``NULL`` pointer for the range 0 -
> +``ULONG_MAX``.  There are currently two types of maple trees supported: the
> +allocation tree and the regular tree.  The regular tree has a higher branching
> +factor for internal nodes.  The allocation tree has a lower branching factor
> +but allows the user to search for a gap of a given size or larger from either 0
> +upwards or ``ULONG_MAX`` down.  An allocation tree can be used by passing in
> +the ``MAPLE_ALLOC_RANGE`` flag when initialising the tree.
> +
> +You can then set entries using mtree_store() or mtree_store_range().
> +mtree_store will overwrite any entry with the new entry and return the previous

             ^ Did you intentionally drop brackets here?

> +entry stored at that index.  mtree_store_range works in the same way but only
> +returns the first entry that is overwritten.  mtree_load() is used to retrieve

kernel-doc of these functions says that they return 0 or errno. What did I
miss?

> +the entry stored at a given index.  You can use mtree_erase() to erase an
> +entire range by only knowing one value within that range, or mtree_store() call
> +with an entry of NULL may be used to partially erase a range.
> +
> +If you want to only store a new entry to a range (or index) if that range is
> +currently ``NULL``, you can use mtree_insert_range() or mtree_insert() which
> +return -EEXIST if the range is not empty.
> +
> +You can search for an entry from an index upwards by using mt_find().
> +
> +You can walk each entry within a range by calling mt_for_each().  You must
> +provide a temporary variable to store a cursor.  If you want to walk each
> +element of the tree then 0 and ``ULONG_MAX`` may be used as the range.  If the

Why 0 and ULONG_MAX have different markup?

> +caller is going to hold the lock for the duration of the walk then it is worth

Do you refer to the maple tree internal lock or any lock here?

> +looking at the mas_for_each() API in the Advanced API section.

Maybe make "Advanced API" a hyperlink.

> +
> +Sometimes it is necessary to ensure the next call to store to a maple tree does
> +not allocate memory, please see the advanced API for this use case.
> +
> +Finally, you can remove all entries from a maple tree by calling
> +mtree_destroy().  If the maple tree entries are pointers, you may wish to free
> +the entries first.
> +
> +Allocating Nodes
> +----------------
> +
> +When using the normal API, the allocations are handled by the internal
> +tree code.

Since this is a part of "Normal API" description the "When using normal
API" seems redundant.

> +
> +Locking
> +-------
> +
> +When using the Normal API, you do not have to worry about locking.

Ditto

> +The Maple Tree uses RCU and an internal spinlock to synchronise access:
> +
> +Takes RCU read lock:
> + * mtree_load()
> + * mt_find()
> + * mt_for_each()
> + * mt_next()
> + * mt_prev()
> +
> +Takes ma_lock internally:
> + * mtree_store()
> + * mtree_store_range()
> + * mtree_insert()
> + * mtree_insert_range()
> + * mtree_erase()
> + * mtree_destroy()
> + * mt_set_in_rcu()
> + * mt_clear_in_rcu()
> +
> +If you want to take advantage of the lock to protect the data structures

I believe this is about the internal lock, it would be nice to spell this
out.

> +that you are storing in the Maple Tree, you can call mtree_lock() before
> +calling mtree_load(), then take a reference count on the object you have
> +found before calling mtree_unlock().  This will prevent stores from
> +removing the object from the tree between looking up the object and
> +incrementing the refcount.  You can also use RCU to avoid dereferencing
> +freed memory, but an explanation of that is beyond the scope of this
> +document.
> +
> +Advanced API
> +============
> +
> +The advanced API offers more flexibility and better performance at the
> +cost of an interface which can be harder to use and has fewer safeguards.
> +You must take care of your own locking while using the advanced API.
> +You can use the ma_lock, RCU or an external lock for protection.
> +You can mix advanced and normal operations on the same array, as long
> +as the locking is compatible.  The normal API is implemented in terms
> +of the advanced API.
> +
> +The advanced API is based around the ma_state, this is where the 'mas'
> +prefix originates.  The ma_state struct keeps track of tree operations to make
> +life easier for both internal and external tree users.
> +
> +Initialising the maple tree is the same as in the normal API.  Please see
> +above.
> +
> +The maple state keeps track of the range start and end in mas->index and
> +mas->last, respectively.
> +
> +mas_walk() will walk the tree to the location of index and set the index
> +and last according to the range for the entry.

           ^ fields? or maybe even mas->index and mas->last?
> +
> +You can set entries using mas_store().  mas_store() will overwrite any entry
> +with the new entry and return the first existing entry that is overwritten.
> +The range is passed in as members of the maple state: index and last.
> +
> +You can use mas_erase() to erase an entire range by setting index and
> +last of the maple state to the desired range to erase.  This will erase
> +the first range that is found in that range, set the maple state index
> +and last as the range that was erased and return the entry that existed
> +at that location.
> +
> +You can walk each entry within a range by using mas_for_each().  If you want to
> +walk each element of the tree then 0 and ``ULONG_MAX`` may be used as the
> +range.  If the lock needs to be periodically dropped, see the locking section
> +mas_pause().
> +
> +Using a maple state allows mas_next() and mas_prev() to function as if the
> +tree was a linked list.  With such a high branching factor the amortized
> +performance penalty is outweighed by cache optimization.  mas_next() will
> +return the next entry which occurs after the entry at index.  mas_prev()
> +will return the previous entry which occurs before the entry at index.
> +
> +mas_find() will find the first entry which exists at or above index on
> +the first call, and the next entry from every subsequent calls.
> +
> +mas_find_rev() will find the fist entry which exists at or below the last on
> +the first call, and the previous entry from every subsequent calls.
> +
> +If the user needs to yield the lock during an operation, then the maple state
> +must be paused using mas_pause().
> +
> +There are a few extra interfaces provided when using an allocation tree.
> +If you wish to search for a gap within a range, then mas_empty_area()
> +or mas_empty_area_rev() can be used.  mas_empty_area searches for a

                                                      ^ brackets?

> +gap starting at the lowest index given up to the maximum of the range.
> +mas_empty_area_rev searches for a gap starting at the highest index

                    ^ and here?

> +given and continues downward to the lower bound of the range.
> +
> +Allocating Nodes
> +----------------
> +
> +Allocations are usually handled internally to the tree, however if allocations
> +need to occur before a write occurs then calling mas_entry_count() will
> +allocate the worst-case number of needed nodes to insert the provided number of
> +ranges.  This also causes the tree to enter mass insertion mode.  Once
> +insertions are complete calling mas_destroy() on the maple state will free the
> +unused allocations.
> +
> +Functions and structures
> +========================
> +
> +.. kernel-doc:: include/linux/maple_tree.h
> +.. kernel-doc:: lib/maple_tree.c
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f41088418aae..a35478a3dee3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11415,6 +11415,18 @@ L:	linux-man@vger.kernel.org
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
> +F:	tools/testing/_adix-tree/linux/maple_tree.h
> +F:	tools/testing/radix-tree/maple.c
> +
>  MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
>  M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
>  L:	linux-mips@vger.kernel.org
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> new file mode 100644
> index 000000000000..14ddeaa8f3e7
> --- /dev/null
> +++ b/include/linux/maple_tree.h
> @@ -0,0 +1,673 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef _LINUX_MAPLE_TREE_H
> +#define _LINUX_MAPLE_TREE_H
> +/*
> + * Maple Tree - An RCU-safe adaptive tree for storing ranges
> + * Copyright (c) 2018 Oracle

2018 - 2022?

> + * Authors:     Liam R. Howlett <Liam.Howlett@Oracle.com>
> + *              Matthew Wilcox <willy@infradead.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/rcupdate.h>
> +#include <linux/spinlock.h>
> +/* #define CONFIG_MAPLE_RCU_DISABLED */
> +/* #define CONFIG_DEBUG_MAPLE_TREE_VERBOSE */
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

There are a lots of comments describing the maple tree internals here and
below. Did yaou consider adding a section "Implementation details" or
something like that to the maple_tree.rst and linking these comments there
with DOC: and some glue text?

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

...

> +/**
> + * DOC: Maple tree flags

I don't see this referenced in the Documentation/ changes

> + *
> + * * MT_FLAGS_ALLOC_RANGE	- Track gaps in this tree
> + * * MT_FLAGS_USE_RCU		- Operate in RCU mode
> + * * MT_FLAGS_HEIGHT_OFFSET	- The position of the tree height in the flags
> + * * MT_FLAGS_HEIGHT_MASK	- The mask for the maple tree height value
> + * * MT_FLAGS_LOCK_MASK		- How the mt_lock is used
> + * * MT_FLAGS_LOCK_IRQ		- Acquired irq-safe
> + * * MT_FLAGS_LOCK_BH		- Acquired bh-safe
> + * * MT_FLAGS_LOCK_EXTERN	- mt_lock is not used
> + *
> + * MAPLE_HEIGHT_MAX	The largest height that can be stored
> + */
> +#define MT_FLAGS_ALLOC_RANGE	0x01
> +#define MT_FLAGS_USE_RCU	0x02
> +#define	MT_FLAGS_HEIGHT_OFFSET	0x02
> +#define	MT_FLAGS_HEIGHT_MASK	0x7C

Is extra alignment here intentional?

> +#define MT_FLAGS_LOCK_MASK	0x300
> +#define MT_FLAGS_LOCK_IRQ	0x100
> +#define MT_FLAGS_LOCK_BH	0x200
> +#define MT_FLAGS_LOCK_EXTERN	0x300

...

> +/*
> + * More complicated stores can cause two nodes to become one or tree and

                                                                  ^ three?

> + * potentially alter the height of the tree.  Either half of the tree may need
> + * to be rebalanced against the other.  The ma_topiary struct is used to track
> + * which nodes have been 'cut' from the tree so that the change can be done
> + * safely at a later date.  This is done to support RCU.
> + */
> +struct ma_topiary {
> +	struct maple_enode *head;
> +	struct maple_enode *tail;
> +	struct maple_tree *mtree;
> +};

...

> +/* Advanced API */
> +
> +/*
> + * The maple state is defined in the struct ma_state and is used to keep track
> + * of information during operations, and even between operations when using the
> + * advanced API.
> + *
> + * If state->node has bit 0 set then it references a tree location which is not
> + * a node (eg the root).  If bit 1 is set, the rest of the bits are a negative
> + * errno.  Bit 2 (the 'unallocated slots' bit) is clear.  Bits 3-6 indicate the
> + * node type.
> + *
> + * state->alloc either has a request number of nodes or an allocated node.  If
> + * stat->alloc has a requested number of nodes, the first bit will be set (0x1)
> + * and the remaining bits are the value.  If state->alloc is a node, then the
> + * node will be of type maple_alloc.  maple_alloc has MAPLE_NODE_SLOTS - 1 for
> + * storing more allocated nodes, a total, and the node_count in this node.
> + * total is the number of nodes allocated.  node_count is the number of

Maybe merge "total is the number of nodes allocated" with "a total":

... allocated nodes, total number of nodes allocated, and the node_count...

> + * allocated nodes in this node.  The scaling beyond MAPLE_NODE_SLOTS - 1 is
> + * handled by storing further nodes into state->alloc->slot[0]'s node.  Nodes
> + * are taken from state->alloc by removing a node from the state->alloc node
> + * until state->alloc->node_count is 1, when state->alloc is returned and the
> + * state->alloc->slot[0] is promoted to state->alloc.  Nodes are pushed onto
> + * state->alloc by putting the current state->alloc into the pushed node's
> + * slot[0].
> + *
> + * The state also contains the implied min/max of the state->node, the depth of
> + * this search, and the offset. The implied min/max are either from the parent
> + * node or are 0-oo for the root node.  The depth is incremented or decremented
> + * every time a node is walked down or up.  The offset is the slot/pivot of
> + * interest in the node - either for reading or writing.
> + *
> + * When returning a value the maple state index and last respectively contain
> + * the start and end of the range for the entry.  Ranges are inclusive in the
> + * Maple Tree.
> + */
> +struct ma_state {
> +	struct maple_tree *tree;	/* The tree we're operating in */
> +	unsigned long index;		/* The index we're operating on - range start */
> +	unsigned long last;		/* The last index we're operating on - range end */
> +	struct maple_enode *node;	/* The node containing this entry */
> +	unsigned long min;		/* The minimum index of this node - implied pivot min */
> +	unsigned long max;		/* The maximum index of this node - implied pivot max */
> +	struct maple_alloc *alloc;	/* Allocated nodes for this operation */
> +	unsigned char depth;		/* depth of tree descent during write */
> +	unsigned char offset;
> +	unsigned char mas_flags;
> +};

...

> +/**
> + * mt_for_each - Searches for an entry starting at index until max.

Isn't it an iterator?

> + * @tree: The Maple Tree
> + * @entry: The current entry
> + * @index: The index to update to track the location in the tree
> + * @max: The maximum limit for @index
> + *
> + * Note: Will not return the zero entry.
> + */
> +#define mt_for_each(tree, entry, index, max) \
> +	for (entry = mt_find(tree, &index, max); \
> +		entry; entry = mt_find_after(tree, &index, max))
> +
> +

...

> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> new file mode 100644
> index 000000000000..6a57745319ba
> --- /dev/null
> +++ b/lib/maple_tree.c
> @@ -0,0 +1,6943 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Maple Tree implementation
> + * Copyright (c) 2018 Oracle Corporation
> + * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
> + *	    Matthew Wilcox <willy@infradead.org>
> + */
> +
> +/*
> + * Interesting implementation details of the Maple Tree

DOC:? 

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
> + *
> + *  Slots -> | 0 | 1 | 2 | ... | 12 | 13 | 14 | 15 |
> + *           ┬   ┬   ┬   ┬     ┬    ┬    ┬    ┬    ┬
> + *           │   │   │   │     │    │    │    │    └─ Implied maximum
> + *           │   │   │   │     │    │    │    └─ Pivot 14
> + *           │   │   │   │     │    │    └─ Pivot 13
> + *           │   │   │   │     │    └─ Pivot 12
> + *           │   │   │   │     └─ Pivot 11
> + *           │   │   │   └─ Pivot 2
> + *           │   │   └─ Pivot 1
> + *           │   └─ Pivot 0
> + *           └─  Implied minimum
> + *
> + * Slot contents:
> + *  Internal (non-leaf) nodes contain pointers to other nodes.
> + *  Leaf nodes contain entries.
> + *
> + * The location of interest is often referred to as an offset.  All offsets have
> + * a slot, but the last offset has an implied pivot from the node above (or
> + * UINT_MAX for the root node.
> + *
> + * Ranges complicate certain write activities.  When modifying any of
> + * the B-tree variants, it is known that one entry will either be added or
> + * deleted.  When modifying the Maple Tree, one store operation may overwrite
> + * the entire data set, or one half of the tree, or the middle half of the tree.
> + *
> + */

...

> +/* Interface */
> +
> +/**
> + * mas_store() - Store an @entry.
> + * @mas: The maple state.
> + * @entry: The entry to store.
> + *
> + * The @mas->index and @mas->last is used to set the range for the @entry.
> + * Note: The @mas should have pre-allocated entries to ensure there is memory to
> + * store the entry.  Please see mas_expected_entries()/mas_destroy() for more details.

Return: ?

> + */
> +void *mas_store(struct ma_state *mas, void *entry)
> +{
> +	MA_WR_STATE(wr_mas, mas, entry);
> +
> +	trace_ma_write(__func__, mas, 0, entry);
> +#ifdef CONFIG_DEBUG_MAPLE_TREE
> +	if (mas->index > mas->last)
> +		printk("Error %lu > %lu %p\n", mas->index, mas->last, entry);
> +	MT_BUG_ON(mas->tree, mas->index > mas->last);
> +	if (mas->index > mas->last) {
> +		mas_set_err(mas, -EINVAL);
> +		return NULL;
> +	}
> +
> +#endif
> +
> +/*
> + * Storing is the same operation as insert with the added caveat that it can
> + * overwrite entries.  Although this seems simple enough, one may want to
> + * examine what happens if a single store operation was to overwrite multiple
> + * entries within a self-balancing B-Tree.
> + */
> +	mas_wr_store_setup(&wr_mas);
> +	mas_wr_store_entry(&wr_mas);
> +	return wr_mas.content;
> +}

...

> +/**
> + * mt_next() - get the next value in the maple tree
> + * @mt: The maple tree
> + * @index: The start index
> + * @max: The maximum index to check
> + *
> + * Returns: The entry at @index or higher, or %NULL if nothing is found.

Please s/Returns/Return/

> + */
> +void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
> +{
> +	void *entry = NULL;
> +	MA_STATE(mas, mt, index, index);
> +
> +	rcu_read_lock();
> +	entry = mas_next(&mas, max);
> +	rcu_read_unlock();
> +	return entry;
> +}
> +EXPORT_SYMBOL_GPL(mt_next);

...

> +/*

kernel-doc?

> + * mas_find: If mas->node == MAS_START, find the first
> + * non-NULL entry >= mas->index.
> + * Otherwise, find the first non-NULL entry > mas->index

although this might render not nicely in html...

> + * @mas: The maple state
> + * @max: The maximum value to check.
> + *
> + * Must hold rcu_read_lock or the write lock.
> + * If an entry exists, last and index are updated accordingly.
> + * May set @mas->node to MAS_NONE.
> + *
> + * Return: The entry or %NULL.
> + */
> +void *mas_find(struct ma_state *mas, unsigned long max)
> +{
> +	if (unlikely(mas_is_paused(mas))) {
> +		if (unlikely(mas->last == ULONG_MAX)) {
> +			mas->node = MAS_NONE;
> +			return NULL;
> +		}
> +		mas->node = MAS_START;
> +		mas->index = ++mas->last;
> +	}
> +
> +	if (unlikely(mas_is_start(mas))) {
> +		/* First run or continue */
> +		void *entry;
> +
> +		if (mas->index > max)
> +			return NULL;
> +
> +		entry = mas_walk(mas);
> +		if (entry)
> +			return entry;
> +	}
> +
> +	if (unlikely(!mas_searchable(mas)))
> +		return NULL;
> +
> +	/* Retries on dead nodes handled by mas_next_entry */
> +	return mas_next_entry(mas, max);
> +}
> +
> +/**
> + * mas_find: If mas->node == MAS_START, find the first

mas_find_rev

> + * non-NULL entry <= mas->last.
> + * Otherwise, find the first non-NULL entry < mas->index

So does this look Ok in html? ;-)

> + * @mas: The maple state
> + * @min: The minimum value to check.
> + *
> + * Must hold rcu_read_lock or the write lock.
> + * If an entry exists, last and index are updated accordingly.
> + * May set @mas->node to MAS_NONE.
> + *
> + * Return: The entry or %NULL.
> + */void *mas_find_rev(struct ma_state *mas, unsigned long min)
> +{
> +	if (unlikely(mas_is_paused(mas))) {
> +		if (unlikely(mas->last == ULONG_MAX)) {
> +			mas->node = MAS_NONE;
> +			return NULL;
> +		}
> +		mas->node = MAS_START;
> +		mas->last = --mas->index;
> +	}
> +
> +	if (unlikely(mas_is_start(mas))) {
> +		/* First run or continue */
> +		void *entry;
> +
> +		if (mas->index < min)
> +			return NULL;
> +
> +		entry = mas_walk(mas);
> +		if (entry)
> +			return entry;
> +	}
> +
> +	if (unlikely(!mas_searchable(mas)))
> +		return NULL;
> +
> +	/* Retries on dead nodes handled by mas_next_entry */
> +	return mas_prev_entry(mas, min);
> +}
> +EXPORT_SYMBOL_GPL(mas_find);
> +
> +/**
> + * mas_erase() - Find the range in which index resides and erase the entire
> + * range.
> + * @mas: The maple state
> + *
> + * Must hold the write lock.
> + * Searches for @mas->index, sets @mas->index and @mas->last to the range and
> + * erases that range.
> + *
> + * Return: the entry that was erased, @mas->index and @mas->last are updated.

the entry that was erased or %NULL?

> + */
> +void *mas_erase(struct ma_state *mas)
> +{
> +	void *entry;
> +	MA_WR_STATE(wr_mas, mas, NULL);
> +
> +	if (mas_is_none(mas) || mas_is_paused(mas))
> +		mas->node = MAS_START;
> +
> +	/* Retry unnecessary when holding the write lock. */
> +	entry = mas_state_walk(mas);
> +	if (!entry)
> +		return NULL;
> +
> +write_retry:
> +	/* Must reset to ensure spanning writes of last slot are detected */
> +	mas_reset(mas);
> +	mas_wr_store_setup(&wr_mas);
> +	mas_wr_store_entry(&wr_mas);
> +	if (mas_nomem(mas, GFP_KERNEL))
> +		goto write_retry;
> +
> +	return entry;
> +}
> +EXPORT_SYMBOL_GPL(mas_erase);
> +
> +/*

kernel-doc?

> + * mas_nomem() - * Check if there was an error allocating and do the allocation

                   ^ not needed.
> + * if necessary If there are allocations, then free them.

                 ^ period?

> + * @mas: The maple state
> + * @gfp: The GFP_FALGS to use for allocations

Return:?

> + */
> +bool mas_nomem(struct ma_state *mas, gfp_t gfp)
> +	__must_hold(mas->tree->lock)
> +{
> +	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
> +		mas_destroy(mas);
> +		return false;
> +	}
> +
> +	if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
> +		mtree_unlock(mas->tree);
> +		mas_alloc_nodes(mas, gfp);
> +		mtree_lock(mas->tree);
> +	} else {
> +		mas_alloc_nodes(mas, gfp);
> +	}
> +
> +	if (!mas_allocated(mas))
> +		return false;
> +
> +	mas->node = MAS_START;
> +	return true;
> +}
> +
> +void __init maple_tree_init(void)
> +{
> +	maple_node_cache = kmem_cache_create("maple_node",
> +			sizeof(struct maple_node), sizeof(struct maple_node),
> +			SLAB_PANIC, NULL);
> +}
> +
> +/**
> + * mtree_load() - Load a value stored in a maple tree
> + * @mt: The maple tree
> + * @index: The index to load
> + *
> + * Return: the entry of %NULL

                       ^ or?
> + */
> +void *mtree_load(struct maple_tree *mt, unsigned long index)
> +{
> +	MA_STATE(mas, mt, index, index);
> +	void *entry;
> +
> +	trace_ma_read(__func__, &mas);
> +	rcu_read_lock();
> +retry:
> +	entry = mas_start(&mas);
> +	if (unlikely(mas_is_none(&mas)))
> +		goto unlock;
> +
> +	if (unlikely(mas_is_ptr(&mas))) {
> +		if (index)
> +			entry = NULL;
> +
> +		goto unlock;
> +	}
> +
> +	entry = mtree_lookup_walk(&mas);
> +	if (!entry && unlikely(mas_is_start(&mas)))
> +		goto retry;
> +unlock:
> +	rcu_read_unlock();
> +	if (xa_is_zero(entry))
> +		return NULL;
> +
> +	return entry;
> +}
> +EXPORT_SYMBOL(mtree_load);

-- 
Sincerely yours,
Mike.
