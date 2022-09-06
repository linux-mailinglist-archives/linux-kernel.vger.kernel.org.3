Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1E65AF0BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiIFQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiIFQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989EBBCD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4170615A7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 16:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB517C433B5;
        Tue,  6 Sep 2022 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662480985;
        bh=8WcaE0tiCNvuuwz8DZZ6kQiMgY1Udyvw/3H0BR4qL04=;
        h=Date:From:To:Cc:Subject:From;
        b=GckO6DabkKG7qGxm3/LoYg2wK75NSR1IFK7DOkEqi1HMfbsyqZ4V6eqpZ4GNJvAsr
         kEf5Zy9c1l9SQ68aZTh0wJ3qfVlDjj2dTKgNwD2MchkefmzXGBDnQMooi7/CNvRZMM
         Psovo/bRSch79Zwo4gp9hjMmKAAdCuhjkRf9XqZUV9ohyP5EZBjgUnJpcAKdF4j6Ah
         KYPQ4A7paV5wfTmVi4jIqidlmmYlh7C5H6iEvUpoYGe2sOeST9tEiYpzjGYNj0vkWh
         jLfLmIa3SVFan2IzJp67qli/+26nFYrNsxjwaz7bznl3xVCLleQ+E3kdgiErYgupi5
         YGqODi5M50ijg==
Date:   Wed, 7 Sep 2022 00:16:19 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Sun Ke <sunke32@huawei.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [GIT PULL] erofs fixes for 6.0-rc5
Message-ID: <YxdyU26Us1vmDxVJ@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Sun Ke <sunke32@huawei.com>, Jingbo Xu <jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these three fixes for 6.0-rc5?

One patch fixes error paths in fscache backend.  Another fixes a
use-after-free on UP platforms whose path is now dropped directly.
The rest addresses potential wrong pcluster sizes for later non-4K
lclusters.  It should have no effect on the existing fs images but
the fix is small and straight-forward so that it'd be better to be
fixed from now on.

All commits have been in linux-next and no merge conflicts.

Thanks,
Gao Xiang

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.0-rc5-fixes

for you to fetch changes up to 2f44013e39984c127c6efedf70e6b5f4e9dcf315:

  erofs: fix pcluster use-after-free on UP platforms (2022-09-05 23:23:30 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix return codes in erofs_fscache_{meta_,}read_folio error paths;

 - Fix potential wrong pcluster sizes for later non-4K lclusters;

 - Fix in-memory pcluster use-after-free on UP platforms.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix pcluster use-after-free on UP platforms

Sun Ke (1):
      erofs: fix error return code in erofs_fscache_{meta_,}read_folio

Yue Hu (1):
      erofs: avoid the potentially wrong m_plen for big pcluster

 fs/erofs/fscache.c  |  8 ++++++--
 fs/erofs/internal.h | 29 -----------------------------
 fs/erofs/zmap.c     | 16 ++++++++--------
 3 files changed, 14 insertions(+), 39 deletions(-)

