Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C46551822
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242215AbiFTMDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242242AbiFTMCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:02:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1231B18B23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:02:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74E301F45E;
        Mon, 20 Jun 2022 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655726565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=trD6oDP/oU8K8dJxIz+dxuUeJsrMnku6W+1r4BQpCf0=;
        b=ZorN7QgrzXhLExwAn218fgIC5FfaeIv6TReRRI7xdSxJkf1e/5k649P79PRZZMLqoQfC7s
        UUudXPlwKJB+3aJTfvO/fdaXQolnKaIuCWFbzXhhvp73npz3H0lPrvXns+EQ0Vq2x6/dht
        K8XYjTgDd6IXG9K7pf/yMoTuR8FUaT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655726565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=trD6oDP/oU8K8dJxIz+dxuUeJsrMnku6W+1r4BQpCf0=;
        b=ZSvL4DqDEL0UObQafmOG7pduvvvPOkc9D9tk704KMNDH+CCia7xbgahqmlsA5GRSBEgJYq
        wWRifN2kVyvq31Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CF85134CA;
        Mon, 20 Jun 2022 12:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xhEnEuVhsGLoFAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 20 Jun 2022 12:02:45 +0000
Message-ID: <a8082f00-3e00-f781-f5f0-20b4853b3335@suse.cz>
Date:   Mon, 20 Jun 2022 14:02:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab fixes for 5.19
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

Linus

please pull the slab fixes for 5.19 from

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.19-fixup

======================================

- A slub fix for PREEMPT_RT locking semantics from Sebastian.

- A slub fix for state corruption due to a possible race scenario from Jann.

Thanks,
Vlastimil

----------------------------------------------------------------
Jann Horn (1):
      mm/slub: add missing TID updates on slab deactivation

Sebastian Andrzej Siewior (1):
      mm/slub: Move the stackdepot related allocation out of IRQ-off section.

 mm/slub.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)
