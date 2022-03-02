Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A14CAC0C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiCBRdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244185AbiCBRcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:32:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0200E4FC53
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:31:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E875D1F383;
        Wed,  2 Mar 2022 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646242295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0F5iyAVUpAY+shMoqL/P7qWmQAtpvgs1Tiry295pM+U=;
        b=STDpbQqNfuoclYWu1flEt6xiogDYgw/jahRqnhJs9cK87PLSUvfIKppRaCH7FuAXbiMCqM
        AwfLU4mrR1+alT3s68x2Mkcx4xKIRpUtGAOYFzGuRSDSNQNlp72BvPdTmlAkyTI8LbHiQ/
        Pg+6a+l9z985ZWnxo19PI9gqw+oZ2/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646242295;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0F5iyAVUpAY+shMoqL/P7qWmQAtpvgs1Tiry295pM+U=;
        b=9bxUMlg/FV7BId79ULVCflh5Tz4oSYISm1grmEs19YkBkUoRvI08W1xir84/GppMSgnTPi
        4ONboN4A095HgVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9068D13A89;
        Wed,  2 Mar 2022 17:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TNSNIvepH2LPTAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 02 Mar 2022 17:31:35 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 0/6] SLUB debugfs improvements based on stackdepot
Date:   Wed,  2 Mar 2022 18:31:16 +0100
Message-Id: <20220302173122.11939-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368; h=from:subject; bh=B+yzyYiHDPGnwrNbtx8qgY0ZG8Ue2zyPZEAU7+tMVJc=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiH6nkvl6LWPKdV0YYkWFgwkLcDQYi6hxSzz0tQNuq uJds8I2JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYh+p5AAKCRDgIcpz8YmpEN5kCA CKf3q/CXp6s4z3xEGDGcxr7+KOTzPVsE2Lapbf0IIxJLhr51st5EtMorZEvAdqbjzdU79TH5rpLFxD 2t3JKjY5KpTsxs+1r1fX6zmi7xMAb23OPkCveN3KNrTdGUbSce8GwVTsvW1ihVfNvfunIz8UI5WNFS uByr0OiQwn6fololkU1zyNhTzvEQ0Ym1tYM84H4BGyFJ4Tre99dktMGBEBfWwvi3vxY8HKU/PwYXri C1M0GTRReU1kyr5j9E59sDe1mvIJ5eVBvRhHzUt7sfyZ1/XYkZ9gk6x8lpuy5iwP9GEKn4YwP6nvyT D2O9ALr20voAdAAXHaqdC0Ka9hcKXX
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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

Changes since v1:
https://lore.kernel.org/all/20220225180318.20594-1-vbabka@suse.cz/

- New Patch 1 to resolve bootstrap issues between stack depot and early
  cache creation reported by Hyeonggon Yoo
- Patch 3 use GFP_NOWAIT always in set_track to avoid sleeping in
  invalid context, reported by Hyeonggon Yoo
- Addressed minor feedback and added review/tests by Hyeonggon Yoo.

Hi,

this series combines and revives patches from Oliver's last year
bachelor thesis (where I was the advisor) that make SLUB's debugfs
files alloc_traces and free_traces more useful.
The resubmission was blocked on stackdepot changes that are now merged,
as explained in patch 3.

Patch 1 makes it possible to use stack depot without bootstrap issues.

Patch 2 is a new preparatory cleanup.

Patch 3 originally submitted here [1], was merged to mainline but
reverted for stackdepot related issues as explained in the patch.

Patches 4-6 originally submitted as RFC here [2]. In this submission I
have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
be considered too intrusive so I will postpone it for later. The docs
patch is adjusted accordingly.

Also available in git, based on v5.17-rc1:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v2

I'd like to ask for some more review/testing before I add this to the
slab tree.

[1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
[2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/

Oliver Glitta (4):
  mm/slub: use stackdepot to save stack trace in objects
  mm/slub: distinguish and print stack traces in debugfs files
  mm/slub: sort debugfs output by frequency of stack traces
  slab, documentation: add description of debugfs files for SLUB caches

Vlastimil Babka (2):
  lib/stackdepot: allow requesting early initialization dynamically
  mm/slub: move struct track init out of set_track()

 Documentation/vm/slub.rst  |  64 ++++++++++++++++++
 include/linux/stackdepot.h |  16 ++++-
 init/Kconfig               |   1 +
 lib/stackdepot.c           |   2 +
 mm/page_owner.c            |   9 ++-
 mm/slab_common.c           |   5 ++
 mm/slub.c                  | 135 +++++++++++++++++++++++++------------
 7 files changed, 183 insertions(+), 49 deletions(-)

-- 
2.35.1

