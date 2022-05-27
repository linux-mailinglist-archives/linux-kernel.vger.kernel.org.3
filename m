Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21287535F78
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351355AbiE0Lhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351337AbiE0Lh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:37:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F2463BC6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:37:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 511E6219B3;
        Fri, 27 May 2022 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653651447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+hHq1dpI0VYa05+VLZiztmS29cD052lJCNPI3wyITqE=;
        b=i1vncFC7FieoHBoLCNPtu07PZQ387ayBsgK2AZWTiI3CHQypr4cY0RL/8uvDg/HGRtS0rn
        mfaKBUUBHVHHV6CM2mhG5Smqi3I7iev8f3D1anHSnHCMn23+IaPPyGd7A/qkpLtg8zsu9m
        +HpqfkHMjhQAECsywFE5+4MwP9xGawE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653651447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+hHq1dpI0VYa05+VLZiztmS29cD052lJCNPI3wyITqE=;
        b=9qo5Vlj+i7TW9t/JL+54OI0qlN7yQTgf2V2K6VhHk5DViMynpycv3iWNc1DR4GjG9M+PGv
        TuWFLkiO+j88fxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33947139C4;
        Fri, 27 May 2022 11:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +UYTDPe3kGKQDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 27 May 2022 11:37:27 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH 0/1] stackdepot hash table autosizing
Date:   Fri, 27 May 2022 13:37:05 +0200
Message-Id: <20220527113706.24870-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in response to Linus [1] I have been looking a bit into using
rhashtables in stackdepot, as stackdepot is gaining new users and the
config option-based static hash table size becomes unwieldy.

With rhashtables it would just scale fully automatically, and we could
also consider creating separate stackdepot instances (including own
rhashtable) for each user, as each will have a distinct set of stack
trackes to store, so there's no benefit of storing them together.

However, AFAIU stackdepot was initially created for KASAN, and is
sometimes called from restricted contexts, i.e. via
kasan_record_aux_stack_noalloc() where it avoids allocations, and it's
also why stackdepot uses raw_spin_lock.

rhashtable offloads allocations to a kthread, so that's fine, but uses
non-raw spinlock, so that would be a problem for some of the stackdepot
contexts. It also uses RCU read lock, while some of
kasan_record_aux_stack_noalloc() callsites are in the RCU implementation
code, so that could be also an issue (haven't investigated it in detail).

For the SLUB_DEBUG context specifically, rhashtable uses kmalloc() and
variants, so there's potential recursion issue. While it's expected
those allocations will eventually become large enough to be passed to
kmalloc_large() and avoid slab, we would have to make sure all of them
do.

So my impression is that we could convert some stackdepot users to
rhashtable, but not all. So maybe we could create a second stackdepot
API for those, but KASAN would have to use the original one anyway. As
such it makes sense to me to improve the existing API to replace the
problematic CONFIG_STACK_HASH_ORDER with something that is also not
resizable on the fly, but doesn't require build-time configuration
anymore, and picks automatically a size depending on the system memory
size. Hence I'm proposing the following patch, regardless of whether
we proceed with rhashtables for the other stackdepot users.

Vlastimil

[1] https://lore.kernel.org/all/CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com/

Vlastimil Babka (1):
  lib/stackdepot: replace CONFIG_STACK_HASH_ORDER with automatic sizing

 lib/Kconfig      |  9 ---------
 lib/stackdepot.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 20 deletions(-)

-- 
2.36.1

