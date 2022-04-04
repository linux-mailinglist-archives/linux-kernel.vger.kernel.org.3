Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1527A4F1E89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbiDDWGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379198AbiDDQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:43:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A835256
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:41:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DEE701F388;
        Mon,  4 Apr 2022 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649090479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=V3iMXpX6Tar2xkDlNhUvMoix/J+lSJgmsFNhG93IGiM=;
        b=CrPgANJ/sSXZxTQ7xJVM+uGnCopDznhZUcpP8opc36QKyVMgRK6VdXBwlMdAcSJO10/owc
        J2MBx8SbSsdwGoaDhVLVi8+LipbK4UEiW3K1JR7iM/txMB184k9VjMdPr0L73+vBEMuTIG
        5jHnR+BbKT/vc7HRURfVb6fey8+pmEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649090479;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=V3iMXpX6Tar2xkDlNhUvMoix/J+lSJgmsFNhG93IGiM=;
        b=4+kKzFqKI7ddROPL9a3r3tyGsRP1v5/M2+277F9Xejyg0wnsWVBRjWwEHFe0wztULHYMnz
        6FY/9eL68e7TDJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A404612FC5;
        Mon,  4 Apr 2022 16:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZXlhJ68fS2LjfAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Apr 2022 16:41:19 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 0/6] SLUB debugfs improvements based on stackdepot
Date:   Mon,  4 Apr 2022 18:41:06 +0200
Message-Id: <20220404164112.18372-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473; h=from:subject; bh=lxBvgkdfBhDx5k2EKLb+Jjc3yioj2tcbF+noYL8Yoao=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiSx+iE5eF6eT83nlbeIUVJqg2wTy5GVsOKTmFNmuh CmJlCBiJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYksfogAKCRDgIcpz8YmpEIw/B/ 0fY0qhz4pZh80RCU9uwp0xMzCOz5ovXepDpnbY/W8RcM128cedekgiPbeVWsD28lJaVa3xlcDQW8K7 ksT0Qp2uke1AAmwwAyahKFkv3xk6bZGlyW6QbYslkURRmjTTexx7DT3ZGgPoc2D+8mA5vXir7nY+tT GFCgiH8af6UTuBUp+1y8rcBcYesxD9N7l16+Ro8f1PUBF/CnWDISxEU6Ai/Mpzq9Tgrd1xHdNTIsGR qD3M/PX8sKh2hJfbRhA2Snz1cROrAqbqRNsVnVqYf31ajny4/yuIlwmMtrbILMkYj1pQYoYCeJkmWE O8+GT/6L2wIH8Q0LNYDn1b+bQF/KIS
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

Changes since v2:
https://lore.kernel.org/all/20220302173122.11939-1-vbabka@suse.cz/

- Reworked patch 1 based on feedback from Mike and Marco. Updated patch
  3 accordingly.
- Rebased to v5.18-rc1
- Add acks/reviews. Thanks all.

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

Also available in git, based on v5.18-rc1:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-stackdepot-v3r2

I plan to add this to the slab (-next) tree for 5.19. lkp has been
testing this already from my git, which resolved some more corner cases
and recently only uncovered a pre-existing kfence bug [3]

[1] https://lore.kernel.org/all/20210414163434.4376-1-glittao@gmail.com/
[2] https://lore.kernel.org/all/20210521121127.24653-1-glittao@gmail.com/
[3] https://lore.kernel.org/all/8368021e-86c3-a93f-b29d-efed02135c41@suse.cz/


Oliver Glitta (4):
  mm/slub: use stackdepot to save stack trace in objects
  mm/slub: distinguish and print stack traces in debugfs files
  mm/slub: sort debugfs output by frequency of stack traces
  slab, documentation: add description of debugfs files for SLUB caches

Vlastimil Babka (2):
  lib/stackdepot: allow requesting early initialization dynamically
  mm/slub: move struct track init out of set_track()

 Documentation/vm/slub.rst  |  64 ++++++++++++++++++
 include/linux/stackdepot.h |  26 +++++--
 init/Kconfig               |   1 +
 lib/Kconfig.debug          |   1 +
 lib/stackdepot.c           |  66 ++++++++++++------
 mm/page_owner.c            |   9 ++-
 mm/slab_common.c           |   5 ++
 mm/slub.c                  | 135 +++++++++++++++++++++++++------------
 8 files changed, 234 insertions(+), 73 deletions(-)

-- 
2.35.1

