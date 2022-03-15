Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0166E4D9FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350014AbiCOQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbiCOQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:20:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA8315A0A;
        Tue, 15 Mar 2022 09:19:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCA3621110;
        Tue, 15 Mar 2022 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647361183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6eKQGYnW1BIJ6/xGHQJXa3jiy9pawegcsZstuDrKNiQ=;
        b=WSvMmUvEL4iDt2qZViFSkVXDo9RrXX8EENrgOMjxvnZtBGcX/Z6O2LIxxYV8Piu4BodXX2
        sbxC2WbibDXEQagheDZ7uSUCV0o0p5BjziZ1Demhmipb4SYv44GV/WEoXI+EARkQgOIGGn
        Lf7b6Dw6FEvvTl3FUcBghY9pHbPpsNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647361183;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6eKQGYnW1BIJ6/xGHQJXa3jiy9pawegcsZstuDrKNiQ=;
        b=9vPyWGV7xqZEhVteX/JvCtSqc94JOG42/5MQhdpL2s8x7cQVhHW8rkUZfRS15P2b7KeCvG
        ZaYhc7K9sBF1++Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6438F13B4E;
        Tue, 15 Mar 2022 16:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DXd/FZ+8MGIKPQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 15 Mar 2022 16:19:43 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 3031f704;
        Tue, 15 Mar 2022 16:20:01 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH v2 0/3] ceph: add support for snapshot names encryption
Date:   Tue, 15 Mar 2022 16:19:56 +0000
Message-Id: <20220315161959.19453-1-lhenriques@suse.de>
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

A couple of changes since v1:

- Dropped the dentry->d_flags change in ceph_mkdir().  Thanks to Xiubo
  suggestion, patch 0001 now skips calling ceph_fscrypt_prepare_context()
  if we're handling a snapshot.

- Added error handling to ceph_get_snapdir() in patch 0001 (Jeff had
  already pointed that out but I forgot to include that change in previous
  revision).

- Rebased patch 0002 to the latest wip-fscrypt branch.

- Added some documentation regarding snapshots naming restrictions.

As before, in order to test this code the following PRs are required:

  mds: add protection from clients without fscrypt support #45073
  mds: use the whole string as the snapshot long name #45192
  mds: support alternate names for snapshots #45224
  mds: limit the snapshot names to 240 characters #45312

Luís Henriques (3):
  ceph: add support for encrypted snapshot names
  ceph: add support for handling encrypted snapshot names
  ceph: update documentation regarding snapshot naming limitations

 Documentation/filesystems/ceph.rst |  10 ++
 fs/ceph/crypto.c                   | 158 +++++++++++++++++++++++++----
 fs/ceph/crypto.h                   |  11 +-
 fs/ceph/inode.c                    |  31 +++++-
 4 files changed, 182 insertions(+), 28 deletions(-)

