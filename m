Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6550171E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344299AbiDNPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347661AbiDNN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED6846B3E;
        Thu, 14 Apr 2022 06:51:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5699A1F747;
        Thu, 14 Apr 2022 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649944259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gbIphq0QNBqc29zesgzd0IBueAhZON446tUirSSogoI=;
        b=KU2YavbKNIHGm/F1mZJnwxliny8xpEJ5SHTaYCZenKXiFpwngm93rchLD8c9LC5OdeODJp
        XjK+kLkflg0K5U/+0jGouCupkKZUdJdEAxKdb00frOy9RbbtugvqucZpyK/lHPDcF+hb0P
        3KdfFeEnHyP1i1jzz5GN3I/gUOYvBNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649944259;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gbIphq0QNBqc29zesgzd0IBueAhZON446tUirSSogoI=;
        b=GRzLswhuJrXY5wgLJh5O0fPWhbaOyZ6eBsVnf1cFVdlkxIR/ay2bzahaN4WmTDrm9W/g90
        TfaZF4AhuQsHJiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9D7D132C0;
        Thu, 14 Apr 2022 13:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cjbEMcImWGJnTgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 14 Apr 2022 13:50:58 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 187a4637;
        Thu, 14 Apr 2022 13:51:24 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v4 0/4] ceph: add support for snapshot names encryption
Date:   Thu, 14 Apr 2022 14:51:18 +0100
Message-Id: <20220414135122.26821-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi!

Time for another iteration on the encrypted snapshots names, which is
mostly a rebase to the wip-fscrypt branch.  To test this, I've used ceph
with the following PRs:

  mds: add protection from clients without fscrypt support #45073
  mds: use the whole string as the snapshot long name #45192
  mds: support alternate names for snapshots #45224
  mds: limit the snapshot names to 240 characters #45312

Changes since v3:

- Fixed WARN_ON() in ceph_encode_encrypted_dname()

- Updated documentation and copyright notice for the base64
  encoding/decoding implementaiton which was taken from the fscrypt base.

Changes since v2:

- Use ceph_find_inode() instead of ceph_get_inode() for finding a snapshot
  parent in function parse_longname().  I've also added a fallback to
  ceph_get_inode() in case we fail to find the inode.  This may happen if,
  for example, the mount root doesn't include that inode.  The iput() was
  also complemented by a discard_new_inode() if the inode is in the I_NEW
  state. (patch 0002)

- Move the check for '_' snapshots further up in the ceph_fname_to_usr()
  and ceph_encode_encrypted_dname().  This fixes the case pointed out by
  Xiubo in v2. (patch 0002)

- Use NAME_MAX for tmp arrays (patch 0002)

- Added an extra patch for replacing the base64url encoding by a different
  encoding standard, the one used for IMAP mailboxes (which uses '+' and
  ',' instead of '-' and '_').  This should fix the issue with snapshot
  names starting with '_'. (patch 0003)

Changes since v1:

- Dropped the dentry->d_flags change in ceph_mkdir().  Thanks to Xiubo
  suggestion, patch 0001 now skips calling ceph_fscrypt_prepare_context()
  if we're handling a snapshot.

- Added error handling to ceph_get_snapdir() in patch 0001 (Jeff had
  already pointed that out but I forgot to include that change in previous
  revision).

- Rebased patch 0002 to the latest wip-fscrypt branch.

- Added some documentation regarding snapshots naming restrictions.


Luís Henriques (4):
  ceph: add support for encrypted snapshot names
  ceph: add support for handling encrypted snapshot names
  ceph: update documentation regarding snapshot naming limitations
  ceph: replace base64url by the encoding used for mailbox names

 Documentation/filesystems/ceph.rst |  10 ++
 fs/ceph/crypto.c                   | 252 +++++++++++++++++++++++++----
 fs/ceph/crypto.h                   |  14 +-
 fs/ceph/dir.c                      |   2 +-
 fs/ceph/inode.c                    |  33 +++-
 5 files changed, 273 insertions(+), 38 deletions(-)

