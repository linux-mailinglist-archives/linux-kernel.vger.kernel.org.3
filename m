Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97E2505AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbiDRP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiDRP3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E45154684;
        Mon, 18 Apr 2022 07:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E6060F6F;
        Mon, 18 Apr 2022 14:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5950C385A1;
        Mon, 18 Apr 2022 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650292282;
        bh=4Mke+YoC+26JsXzgwtOWJUwQVtYTiEGxubXFKQGh2hA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U59yE0j2Byft95NCGV+ne4Lw6QxAKXjd60HAk+kKoOr6QwbqtpgdUdja9ZVx9qEPQ
         GPMbZZr6WmwK1Jw4aHWjBpxmbRf2xz2E3ryl31eKzTZQO23JLJPE/q/aTv2cNwYLhP
         cz/h1logaZ1X5+m2I5wIbxDqQk9dXOAvapn5l7fKig8BFs23OA5dhnhA6Ncp4kjVeV
         j2d0UVNYyhVzpnGruhYwjEwQ287mmK/tywA+pdKzKcHXspNU4by7ulgIUse7Ny3yCj
         ckTh7Z1VljRKr+wIZ++xan/iMhuV8Q5GdJKI6yqfd5CHYzHSDJoWPV2H5NO3YIStib
         ydKNifx8CuoHQ==
Message-ID: <c75e80afbc476dae349f1b5f1cca7a71984e68d9.camel@kernel.org>
Subject: Re: [PATCH v5 0/5] ceph: add support for snapshot names encryption
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Apr 2022 10:31:20 -0400
In-Reply-To: <20220418135957.12056-1-lhenriques@suse.de>
References: <20220418135957.12056-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-18 at 14:59 +0100, Luís Henriques wrote:
> Hi!
> 
> And here's yet another revision.  The main difference from v4 is the
> addition of a patch to prevent the creation of snapshots in directories
> that are encrypted but that are not unlocked (i.e. no key available).
> 
> As before, the following ceph PRs are required:
> 
>   mds: add protection from clients without fscrypt support #45073
>   mds: use the whole string as the snapshot long name #45192
>   mds: support alternate names for snapshots #45224
>   mds: limit the snapshot names to 240 characters #45312
> 
> Changes since v4:
> 
> - Explicitly added the encoding base for kstrtou64() as we do know that
>   the inode numbers are in decimal.
> 
> - New patch to prevent the creation of snapshots in encrypted directories
>   that do not have the key loaded.
> 
> Changes since v3:
> 
> - Fixed WARN_ON() in ceph_encode_encrypted_dname()
> 
> - Updated documentation and copyright notice for the base64
>   encoding/decoding implementaiton which was taken from the fscrypt base.
> 
> Changes since v2:
> 
> - Use ceph_find_inode() instead of ceph_get_inode() for finding a snapshot
>   parent in function parse_longname().  I've also added a fallback to
>   ceph_get_inode() in case we fail to find the inode.  This may happen if,
>   for example, the mount root doesn't include that inode.  The iput() was
>   also complemented by a discard_new_inode() if the inode is in the I_NEW
>   state. (patch 0002)
> 
> - Move the check for '_' snapshots further up in the ceph_fname_to_usr()
>   and ceph_encode_encrypted_dname().  This fixes the case pointed out by
>   Xiubo in v2. (patch 0002)
> 
> - Use NAME_MAX for tmp arrays (patch 0002)
> 
> - Added an extra patch for replacing the base64url encoding by a different
>   encoding standard, the one used for IMAP mailboxes (which uses '+' and
>   ',' instead of '-' and '_').  This should fix the issue with snapshot
>   names starting with '_'. (patch 0003)
> 
> Changes since v1:
> 
> - Dropped the dentry->d_flags change in ceph_mkdir().  Thanks to Xiubo
>   suggestion, patch 0001 now skips calling ceph_fscrypt_prepare_context()
>   if we're handling a snapshot.
> 
> - Added error handling to ceph_get_snapdir() in patch 0001 (Jeff had
>   already pointed that out but I forgot to include that change in previous
>   revision).
> 
> - Rebased patch 0002 to the latest wip-fscrypt branch.
> 
> - Added some documentation regarding snapshots naming restrictions.
> 
> 
> Luís Henriques (5):
>   ceph: add support for encrypted snapshot names
>   ceph: add support for handling encrypted snapshot names
>   ceph: update documentation regarding snapshot naming limitations
>   ceph: replace base64url by the encoding used for mailbox names
>   ceph: prevent snapshots to be created in encrypted locked directories
> 
>  Documentation/filesystems/ceph.rst |  10 ++
>  fs/ceph/crypto.c                   | 252 +++++++++++++++++++++++++----
>  fs/ceph/crypto.h                   |  14 +-
>  fs/ceph/dir.c                      |   7 +-
>  fs/ceph/inode.c                    |  33 +++-
>  5 files changed, 278 insertions(+), 38 deletions(-)
> 

Looks good. I'll plan to merge these into wip-fscrypt later today.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
