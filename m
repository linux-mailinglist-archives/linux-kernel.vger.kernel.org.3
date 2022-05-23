Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93C530CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiEWJyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiEWJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:54:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8E1FA4A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:54:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F5FF1F8D1;
        Mon, 23 May 2022 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653299649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=erOshWmECESgqBp6Iuj7MaJ8okz8vOBNIGGhbQHexUI=;
        b=h7CjHUa2NCOqxv9L/6RzM4jEjuzpoPTbkaU5SVmtb+1lXLGAM3UFxsqVgjvKvcjbmCm+1m
        BCn0rD7a2/3dmnpykTxX4HGKHggenWNEvZnN9Qeymxe9Lsla+6h6otWe5iO3xXJC7DbOTa
        KY6ltwuEdtdn2EFtfUzhejeEy7kSabw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653299649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=erOshWmECESgqBp6Iuj7MaJ8okz8vOBNIGGhbQHexUI=;
        b=KuMdqXkkqrTFF0cBTGZ18aT7ud3Eii3GYBw8WNMefSNI8Mu22eo4cIOMW+KHSZ5F1lOPPT
        oFSUQ1YpKGjY0RDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01D72139F5;
        Mon, 23 May 2022 09:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sxIhO8BZi2LYbgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 May 2022 09:54:08 +0000
Message-ID: <8062f61e-5a4d-00a5-be1a-7921d3277e9d@suse.cz>
Date:   Mon, 23 May 2022 11:54:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Language: en-US
Subject: [GIT PULL] slab for 5.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest slab changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.19

======================================

- Conversion of slub_debug stack traces to stackdepot, allowing
  more useful debugfs-based inspection for e.g. memory leak
  debugging.  Allocation and free debugfs info now includes full
  traces and is sorted by the unique trace frequency.

  The stackdepot conversion was already attempted last year but
  reverted by ae14c63a9f20. The memory overhead (while not actually
  enabled on boot) has been meanwhile solved by making the large
  stackdepot allocation dynamic. The xfstest issues haven't been
  reproduced on current kernel locally nor in -next, so the slab
  cache layout changes that originally made that bug manifest were
  probably not the root cause.

- Refactoring of dma-kmalloc caches creation.

- Trivial cleanups such as removal of unused parameters, fixes
  and clarifications of comments.

- Hyeonggon Yoo joins as a reviewer.

Thanks,
Vlastimil

----------------------------------------------------------------
Andrey Konovalov (2):
      mm: slab: fix comment for ARCH_KMALLOC_MINALIGN
      mm: slab: fix comment for __assume_kmalloc_alignment

Hyeonggon Yoo (2):
      mm/slub, kunit: Make slub_kunit unaffected by user specified flags
      MAINTAINERS: add myself as reviewer for slab

JaeSang Yoo (2):
      mm/slub: remove unused parameter in setup_object*()
      mm/slub: remove meaningless node check in ___slab_alloc()

Jiyoup Kim (1):
      mm/slub: remove duplicate flag in allocate_slab()

Miaohe Lin (3):
      mm/slab: remove some unused functions
      mm/slub: remove unneeded return value of slab_pad_check
      mm/slub: remove unused kmem_cache_order_objects max

Ohhoon Kwon (1):
      mm/slab_common: move dma-kmalloc caches creation into new_kmalloc_cache()

Oliver Glitta (4):
      mm/slub: use stackdepot to save stack trace in objects
      mm/slub: distinguish and print stack traces in debugfs files
      mm/slub: sort debugfs output by frequency of stack traces
      slab, documentation: add description of debugfs files for SLUB caches

Vlastimil Babka (3):
      lib/stackdepot: allow requesting early initialization dynamically
      mm/slub: move struct track init out of set_track()
      Merge branches 'slab/for-5.19/stackdepot' and 'slab/for-5.19/refactor' into slab/for-linus

Yixuan Cao (1):
      mm/slab.c: fix comments

 Documentation/vm/slub.rst  |  64 +++++++++++++++++
 MAINTAINERS                |   1 +
 include/linux/slab.h       |  15 ++--
 include/linux/slub_def.h   |   1 -
 include/linux/stackdepot.h |  26 +++++--
 init/Kconfig               |   1 +
 lib/Kconfig.debug          |   1 +
 lib/slub_kunit.c           |  10 +--
 lib/stackdepot.c           |  67 +++++++++++------
 mm/page_owner.c            |   9 ++-
 mm/slab.c                  |  29 +++-----
 mm/slab.h                  |   5 +-
 mm/slab_common.c           |  23 +++---
 mm/slub.c                  | 174 ++++++++++++++++++++++++++++-----------------
 14 files changed, 283 insertions(+), 143 deletions(-)

