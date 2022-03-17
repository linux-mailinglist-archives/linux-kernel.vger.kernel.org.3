Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB4D4DCA47
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiCQPqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiCQPqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:46:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262E126FA6;
        Thu, 17 Mar 2022 08:45:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52A5C1F390;
        Thu, 17 Mar 2022 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647531904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dN/tRmavsr/5lSp9HA/dteMDA5hXjEWxlRPogS3sLHg=;
        b=mU/ra/CfSjsWhWo2es6LXXvuJmqF8r9Sv+2yIpOiMvy6QYuHWJx6UQHhQckZIo4MkUOqGC
        hWJ0y18Ap9pHq7m6GqfykJzzyK41WfYbPO5MdBBz5FGMCQqAhUNAtkg66PZD685tA46pcw
        /V3+pbwz70sPV50dHMaoY1zQiu85bLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647531904;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dN/tRmavsr/5lSp9HA/dteMDA5hXjEWxlRPogS3sLHg=;
        b=f61F31Nx1vnyDkSxNto/oBxKO4Fp8Gyp1Kh6DfWD5PbxR9dGNlcQ6elrVJxXaCsGEzQ7lK
        J5ub59l64miTlNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2E4D13BB7;
        Thu, 17 Mar 2022 15:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vCNVMH9XM2L6UwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 17 Mar 2022 15:45:03 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b0c7e6d1;
        Thu, 17 Mar 2022 15:45:22 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH v3 0/4] ceph: add support for snapshot names encryption
Date:   Thu, 17 Mar 2022 15:45:17 +0000
Message-Id: <20220317154521.6615-1-lhenriques@suse.de>
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

Here's another iteration on my encrypted snapshot names series.  And
here's the changes since v1:

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

Regarding this last patch, there are other alternatives:

1. Simply replace any initial '_' in snapshot names by another character
   (I was using the '=').  This was a bit more hacky because this name
   could never be sent as-is to the base64 functions, so the '=' would
   need to be replace back by an '_'.

2. Append an extra (known) char to every snapshot name.  This would also
   be hacky because it would need to be removed again for base64
   operations.  And the snapshot name size limitations would need to be
   adjusted too.

3. Modify the fscrypt base64 encoding/decoding functions to receive an
   alternative table to use in these operations.  This would need to be
   accepted by the fscrypt maintainers, of course.

As before, in order to test this code the following PRs are required:

  mds: add protection from clients without fscrypt support #45073
  mds: use the whole string as the snapshot long name #45192
  mds: support alternate names for snapshots #45224
  mds: limit the snapshot names to 240 characters #45312

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
  ceph: handle encrypted snapshot names in subdirectories
  ceph: update documentation regarding snapshot naming limitations
  ceph: replace base64url by the encoding used for mailbox names

 Documentation/filesystems/ceph.rst |  10 ++
 fs/ceph/crypto.c                   | 238 +++++++++++++++++++++++++----
 fs/ceph/crypto.h                   |  14 +-
 fs/ceph/dir.c                      |   2 +-
 fs/ceph/inode.c                    |  33 +++-
 5 files changed, 259 insertions(+), 38 deletions(-)

