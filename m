Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB64C4D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiBYSEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiBYSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:04:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2C2510ED
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:03:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 34D1E1F38D;
        Fri, 25 Feb 2022 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645812231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A4/rQl3tq18iWBnpNxSNODMK+KHp/IyzTqksKPj3yNY=;
        b=0/gABR4GV5MunslmpIWsHjyu4tyKJAyYu76tJS249RgGTcGDyCFi70riWxl9Ov5d2uBTMh
        Kdqw4hlU1urqBBZvYnly7TfdIbXWovGZdlGevpW5Waaq1vM9Ybx/gmbZHKC3I5YDJfBw0C
        YtzemmL1HiiRSyj34s8NU+UaAZgByGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645812231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A4/rQl3tq18iWBnpNxSNODMK+KHp/IyzTqksKPj3yNY=;
        b=jU0i+cFTNOB5gp2RO7cU6gFA7DdKmp1FGp6LrtKnfBTh+Wp3oKgUo3eQhzC5mSsgvKEKaA
        eoRLawnX88wWGaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0220213C17;
        Fri, 25 Feb 2022 18:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A6RCOwYaGWKSRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 25 Feb 2022 18:03:50 +0000
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
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
Date:   Fri, 25 Feb 2022 19:03:13 +0100
Message-Id: <20220225180318.20594-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; h=from:subject; bh=7wwPXU515VXzTFQhi+Z7ay+IsgwNFlOHE+QlyVJRv0w=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiGRnheS0dliAu4MteOLhQX7Og68SjckV01rHav/ln pW7FOUCJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYhkZ4QAKCRDgIcpz8YmpEBj6CA CynvJCe2aNMVhwZqBM7dyo023A1PjHtuiVCQ2on0ah9ITaCEx19EafpJQkKZqI5HFd5kVrzjCsle49 84HK5oQJ/kzR4yg887e2KkyWsoQ/gaF/DCAEKxij/AfENV/daLafKzexJ41mw3S8pdBvGb7/tnN5WX ISSGtk0P4DunpWry3i8YVtyreyCXpX3lKJqqlTlzVl8SydeqXJv8Lnbt3sDyIQ0yHQLLUlewt9/P4u Rk6y/dnFb1uh5xJtTO7TaGIW5tx3JdhJE8jx12WYV1VyLmq2UpD1tbM2YmVcZfacqQZHb0hD4KRCLC zWfz3bsUFt16I9tbnqkZ69vn0rCPpY
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

Hi,

this series combines and revives patches from Oliver's last year
bachelor thesis (where I was the advisor) that make SLUB's debugfs
files alloc_traces and free_traces more useful.
The resubmission was blocked on stackdepot changes that are now merged,
as explained in patch 2.

Patch 1 is a new preparatory cleanup.

Patch 2 originally submitted here [1], was merged to mainline but
reverted for stackdepot related issues as explained in the patch.

Patches 3-5 originally submitted as RFC here [2]. In this submission I
have omitted the new file 'all_objects' (patch 3/3 in [2]) as it might
be considered too intrusive so I will postpone it for later. The docs
patch is adjusted accordingly.

Also available in git, based on v5.17-rc1:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v1

I'd like to ask for some review before I add this to the slab tree.

[1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
[2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/

Oliver Glitta (4):
  mm/slub: use stackdepot to save stack trace in objects
  mm/slub: aggregate and print stack traces in debugfs files
  mm/slub: sort debugfs output by frequency of stack traces
  slab, documentation: add description of debugfs files for SLUB caches

Vlastimil Babka (1):
  mm/slub: move struct track init out of set_track()

 Documentation/vm/slub.rst |  61 +++++++++++++++
 init/Kconfig              |   1 +
 mm/slub.c                 | 152 +++++++++++++++++++++++++-------------
 3 files changed, 162 insertions(+), 52 deletions(-)

-- 
2.35.1

