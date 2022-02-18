Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA5C4BC2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 23:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiBRWnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 17:43:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiBRWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 17:43:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C0F40A12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:43:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A03A210E2;
        Fri, 18 Feb 2022 22:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645224197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MAAF1UrArLR3/kFKSC5XvKKA5dLaxWP8f2xQrIQUM6o=;
        b=WQkGpbwBk8jJmD6Ny45sTTKMcWh9pHcTfYCn5MS3AMp5JaSpUCRdAw+AGMarVTJvuzQLPO
        lm49jj6EOEJkxSpH/4Bx0UaDyuYxPIfDO0wtinhkvh8jFVI6UV5aPRCjZnEgj8eIiHYv7Q
        zqynSfPm27IVM2ohCn7MWgnvNK8K42s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645224197;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MAAF1UrArLR3/kFKSC5XvKKA5dLaxWP8f2xQrIQUM6o=;
        b=7+laXMoY04tlx5Jwv+Po738O0aJNT+0QwxjqGcw0N5HPkpHOGswsxyG7rWkSBr5g+/IYvI
        hO6HJzxv508wxSDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A85213CCE;
        Fri, 18 Feb 2022 22:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P7X7DgQhEGKMQwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 18 Feb 2022 22:43:16 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/1] Fix allocating nodes twice on x86
Date:   Fri, 18 Feb 2022 23:43:01 +0100
Message-Id: <20220218224302.5282-1-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was about to send this patch as a part of a cleanup patchset that goes on
top of last Michal's work about properly init memoryless nodes [1], but I
thought I may send it as a standalone one as it is the only real fix of
that series.

Discussing the fix with Michal, another concern came up, about whether
memoryless-nodes but with CPUs should be marked as online at all.
Here Michal and I have different opinions, while I think that
memoryless-nodes with its CPUs online should be marked online,
he thinks that the property 'online' applied to node has to do more
with memory, and I have to confess that after having a look at 
some of the usages of for_each_online_node, most of them are checked
to do something memory-realted afterwards, so I guess he has a point
there.

My main concern is that if memoryless-nodes do not get online, its
sysfs showing the cpu<->numa topology will not be created and I am
not sure about losing that information.
E.g: i guess 'numactl -H' would not be able to show the right
topolovy as it coul not walk sysfs to get it right (in case it does).

Anyway, as a quick test, I wanted to see what happens if init_node_to_cpu()
and init_gi_nodes(), do not online the nodes.
(those nodes get online because of the CPU and Generic Initiator
affinity).
The outcome is that we blow up badly down the chain, and we do because
of a nasty side-effect (more information can be found at the end of
patch#1)
Short-long story: by the time bringup_nonboot_cpus() gets called to
bring up the cpus and bring up their respective nodes, we have not even
registered the node_subsys bus yet, so
bringup_nonboot_cpus()->..->__try_online_node->()register_one_node()->bus_add_device()
will crash when dereferencing some of the bus' struct fields.

We happen not to crash now, because init_to_cpu_node() and
init_gi_nodes() mark the node online, and by doing that,
it has the effect of __try_online_node() backing off and not
calling register_one_node().

I think the whole thing is kinda broken, or at the very least subtle and
fragile.

I am willing to have a look at how we can make this optimal, but wanted
to share with you.

Anyway, It is getting late here, so I just wanted to 1) send this quick
fix, 2) expose some nasty behavior and 3) kick off a discussion about
how to improve this situation.

[1] https://lore.kernel.org/lkml/20220127085305.20890-1-mhocko@kernel.org/

Oscar Salvador (1):
  arch/x86/mm/numa: Do not initialize nodes twice

 arch/x86/mm/numa.c | 15 ++-------------
 include/linux/mm.h |  1 -
 mm/page_alloc.c    |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)

-- 
2.34.1

