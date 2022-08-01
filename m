Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C85586782
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiHAK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiHAK3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:29:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA16D19C1F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:29:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65C1661283;
        Mon,  1 Aug 2022 10:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659349789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qZ6j1nmBD+W4ZKl17RN0uYk8u3C+SzxzDwEjh+4og4o=;
        b=EqCglx56IH6khyQ7Wft7VWPsjs6ruBMW5q6zjngKXlfP50bcwncFLIzLXPvpR0aj77Lx94
        3CrsbMM3Ffti+rodGCYGmpLxWkG5zCfULVXQ0ZOPtgC+f2IQSbjc1hz00FAvis5siegvI6
        NkOSJCVAKigjDvVR7+hRlK011hxeH2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659349789;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qZ6j1nmBD+W4ZKl17RN0uYk8u3C+SzxzDwEjh+4og4o=;
        b=rOVuV4UsAEplI/ZOz5MWJtev30XifUfQOwMdcq2bXlJ7hk26S9g0UKFdw4gZBXX5dDUhgC
        06OU+NvuTi04YFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 403D613A72;
        Mon,  1 Aug 2022 10:29:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fQ8MDx2r52LFZgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 01 Aug 2022 10:29:49 +0000
Message-ID: <9a5df89d-e27a-22b4-faae-be65f6c7f54d@suse.cz>
Date:   Mon, 1 Aug 2022 12:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab for 5.20/6.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest slab changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.20_or_6.0

======================================

- An addition of 'accounted' flag to slab allocation tracepoints to indicate
  memcg_kmem accounting, by Vasily.

- An optimization of memcg handling in freeing paths, by Muchun.

- Various smaller fixes and cleanups.

Thanks,
Vlastimil

----------------------------------------------------------------
Hyeonggon Yoo (2):
      mm/sl[au]b: use own bulk free function when bulk alloc failed
      mm/slab_common: move generic bulk alloc/free functions to SLOB

Jiapeng Chong (1):
      mm, slab: fix bad alignments

Muchun Song (1):
      mm: slab: optimize memcg_slab_free_hook()

Stéphane Graber (1):
      tools/vm/slabinfo: Handle files in debugfs

Vasily Averin (1):
      mm/tracing: add 'accounted' entry into output of allocation tracepoints

Xiongwei Song (1):
      mm/slub: Simplify __kmem_cache_alias()

 include/trace/events/kmem.h | 40 +++++++++++-------
 mm/slab.c                   | 20 ++++-----
 mm/slab.h                   | 39 ++++--------------
 mm/slab_common.c            | 36 ++---------------
 mm/slob.c                   | 33 +++++++++++----
 mm/slub.c                   | 98 +++++++++++++++++----------------------------
 tools/vm/slabinfo.c         | 26 +++++++++++-
 7 files changed, 134 insertions(+), 158 deletions(-)
