Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABA9490B68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbiAQPdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:33:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58940 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiAQPdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:33:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A57621138;
        Mon, 17 Jan 2022 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642433583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qD8D98EtGtghmZr3jvOj2j5NtXzPnCgyaV65+nnknkk=;
        b=WWxYDDtGw1Xaxj4kTnUpsGYqfXos8gTyXNN1juSbEKBYz5dQ7aHOHSPGSynU9B3ohL/ynR
        3w/94i+XoQ7KLsu+uxri5CYT5zg5SItvngUR0+X92NqtqlkTiIP/by2VFkBsj3FBg7ODgY
        HLoKNGcLsWgI4TQzitpRBGzLLyTC3tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642433583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qD8D98EtGtghmZr3jvOj2j5NtXzPnCgyaV65+nnknkk=;
        b=CxmtMrH6x1tc0oei7hCBfVX5kwrVTDlLWjm8BzisdTZNm0+DaXqd7WJ/xTPj8UzcLKx3nw
        2yE8JTInXexPOuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A47113C84;
        Mon, 17 Jan 2022 15:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hRYFAS+M5WF+QQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Jan 2022 15:33:03 +0000
Message-ID: <06e9cd6c-320c-af1a-ef12-55e2e8c13f17@suse.cz>
Date:   Mon, 17 Jan 2022 16:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab for 5.17 - part 2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the remaining slab changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.17-part2

======================================

- Finish the conversion to struct slab by removing slab-specific fields
  from struct page.

======================================

The previous pull request [1] did most of the conversion, but there was also
series in iommu tree removing the iommu's usage of struct page 'freelist'
field, blocking the final struct page cleanup. So this pull request is based on
the previous one, adds a merge of iommu tree and a single commit on top, and
has been like this in linux-next since Wed last week. The iommu tree went
mainline since then, so this should add just the single commit to mainline now.

Vlastimil

[1] https://lore.kernel.org/all/fa6573eb-9d5c-ef49-06b1-157c16efb868@suse.cz/

Matthew Wilcox (Oracle) (1):
      mm: Remove slab from struct page

Vlastimil Babka (1):
      Merge branch 'core' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu into slab-struct_slab-part2-v1

 drivers/iommu/amd/io_pgtable.c       | 110 ++++++--------
 drivers/iommu/dma-iommu.c            | 274 +++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.c          |  89 ++++--------
 drivers/iommu/io-pgtable-arm.c       |   9 +-
 drivers/iommu/iommu.c                |   3 +-
 drivers/iommu/iova.c                 | 209 ++------------------------
 drivers/vdpa/vdpa_user/iova_domain.c |   8 -
 include/linux/iommu.h                |   3 +-
 include/linux/iova.h                 |  68 +--------
 include/linux/mm_types.h             |  28 ----
 include/linux/page-flags.h           |  37 -----
 include/trace/events/iommu.h         |  10 +-
 mm/slab.h                            |   6 -
 13 files changed, 314 insertions(+), 540 deletions(-)
