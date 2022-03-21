Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57E4E218A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbiCUHrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbiCUHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:47:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264D3580C9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1756B8110D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED36C340EE;
        Mon, 21 Mar 2022 07:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647848762;
        bh=QldX2CgA/jrZgyN9GjhxNhil+DepyQR7nCll9agSBts=;
        h=Date:From:To:Cc:Subject:From;
        b=ck3ZkIUBA/csRuIiZRzDFv38GO5nDKZGp0SGz/GCchIIjtdylPAk/J2XzfDMA6mhh
         o2/cWWKkBHWwkDoCkBvnj0NyG31Td0W2ZPRFkuTpjmrzJnhkAlLM9MXbcNWzTuhwUe
         IuO9n29T9FTriCzPD5OgNzceksvOsGW16SSEVXXGIQBXeue8E7ycmQ7hfvqAhIr/Al
         rzMyTTyXyJe0dOEwz9cmJZ0I0Cf+rZ0nFfm+pfQPOgVzsP2JUP01SpDg0KDRurD4o8
         sj2PYRKf8AHmR0vbvSDwW10cHL3Li54zG3/XighK5Sf96QUiUZMmweMUi9uddHCCHn
         F24SDRw0PF6Uw==
Date:   Mon, 21 Mar 2022 15:45:38 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        lihongnan <hongnan.lhn@alibaba-inc.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        David Anderson <dvander@google.com>
Subject: [GIT PULL] erofs updates for 5.18-rc1
Message-ID: <YjgtIqJK0Io+zYeI@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        lihongnan <hongnan.lhn@alibaba-inc.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        David Anderson <dvander@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.18-rc1?

In this cycle, we continue converting to use meta buffers for all
remaining uncompressed paths to prepare for the upcoming subpage,
folio and fscache features.

We also fixed a double-free issue when sysfs initialization fails,
which was reported by syzbot.

Besides, in order for the userspace to control per-file timestamp
easier, we now switch to record mtime instead of ctime with a
compatible feature marked. And there are also some code cleanups
and documentation update as usual.

All commits have been in -next for a while and there is a minor
trivial merge conflict with folio -next tree [1].

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20220315203112.03f6120c@canb.auug.org.au

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc1

for you to fetch changes up to a1108dcd9373a98f7018aa4310076260b8ecfc0b:

  erofs: rename ctime to mtime (2022-03-17 23:41:14 +0800)

----------------------------------------------------------------
Changes since last update:

 - Avoid using page structure directly for all uncompressed paths;

 - Fix a double-free issue when sysfs initialization fails;

 - Complete DAX description for erofs;

 - Use mtime instead since there's no (easy) way for users to control
   ctime;

 - Several code cleanups.

----------------------------------------------------------------
David Anderson (1):
      erofs: rename ctime to mtime

Dongliang Mu (1):
      fs: erofs: add sanity check for kobject in erofs_unregister_sysfs

Gao Xiang (7):
      erofs: get rid of `struct z_erofs_collector'
      erofs: clean up preload_compressed_pages()
      erofs: silence warnings related to impossible m_plen
      erofs: clean up z_erofs_extent_lookback
      erofs: refine managed inode stuffs
      erofs: use meta buffers for reading directories
      erofs: use meta buffers for inode lookup

Jeffle Xu (1):
      erofs: use meta buffers for erofs_read_superblock()

lihongnan (1):
      Documentation/filesystem/dax: update DAX description on erofs

 Documentation/filesystems/dax.rst   |   6 +-
 Documentation/filesystems/erofs.rst |   2 +-
 fs/erofs/data.c                     |  12 ++-
 fs/erofs/dir.c                      |  21 ++--
 fs/erofs/erofs_fs.h                 |   5 +-
 fs/erofs/inode.c                    |   4 +-
 fs/erofs/internal.h                 |   2 +
 fs/erofs/namei.c                    |  54 +++++------
 fs/erofs/super.c                    |  21 ++--
 fs/erofs/sysfs.c                    |   8 +-
 fs/erofs/zdata.c                    | 184 +++++++++++++++++-------------------
 fs/erofs/zmap.c                     |  71 +++++++-------
 12 files changed, 189 insertions(+), 201 deletions(-)
