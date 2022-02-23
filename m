Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28B34C0F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiBWJot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiBWJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:44:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0315F8D6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:44:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25CB41F3A3;
        Wed, 23 Feb 2022 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645609460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kXKiiDcCtIBF1plZCamNfShYp0xDLuW1hfasrJY5ejM=;
        b=XIAgOwVokEEDv4fI3b3xCxYyoeu2tzrnWX+4DQMasEoqrL+qqjAgoMNjiE9n+O7qBLkNLF
        PlzLPj/J4k0a0dyF2k71acCYpfwysif8J4KBsq3HsO9bs+DAYp+iSl+evYT6AQ6bPGrBwW
        vhawFJiOHBj7hKBMJL1A8mAAgYsW/zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645609460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kXKiiDcCtIBF1plZCamNfShYp0xDLuW1hfasrJY5ejM=;
        b=fiQMZk6c8sJCCoU96/YOuJ0e5qS0s2WvO30OIl59IW/Gnmak3O6+m4vcJj2TmwmrjTPZlQ
        5ymL4Nk3izuG8xBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC40E13C6E;
        Wed, 23 Feb 2022 09:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hhXYOPMBFmL9MgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Feb 2022 09:44:19 +0000
Message-ID: <02623bc1-fc54-bc5d-8879-e62d548924fd@suse.cz>
Date:   Wed, 23 Feb 2022 10:44:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab fixes for 5.17-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Language: en-US
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

please pull the slab fixes for 5.17-rc6 from

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.17-rc6

======================================

- Build fix (workaround) for clang.

- Fix a /proc/kcore based slabinfo script broken by struct slab changes in
  5.17-rc1.

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      slab: remove __alloc_size attribute from __kmalloc_track_caller

Roman Gushchin (1):
      tools/cgroup/slabinfo: update to work with struct slab

 include/linux/slab.h           |  3 +--
 tools/cgroup/memcg_slabinfo.py | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 17 deletions(-)
