Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF64DC381
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiCQKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiCQKCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF9D4479;
        Thu, 17 Mar 2022 03:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341B261785;
        Thu, 17 Mar 2022 10:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CF1C340E9;
        Thu, 17 Mar 2022 10:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647511287;
        bh=WrEc+afiy/d9loZ1E8J9sV516aOJOmYPwqhlqgRxzJo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CurBUm3P0nv5dWNYXj7K80PuEjfS2/OXEHDyqBxr8Nk+RXRTp3pS7HIbpOusokcLm
         xaqPVVUBcEWu8vVE3+YFJTg0sCVk3QnADJU3p+Sj4Jaof0ZVYsrhVZ9eBNFcdWCGM0
         fmzujH9gi9jBDoSOxP7Xr54DZUKI7Pnz1HmiyCgKaR07aHdsl2Xt/ECfGxck0GKY2f
         qwTMOqHvzZws+w47tCKdiBj3+drDxmBSeT41GXCb835v9TlLIF5Q7pmt/Z5jn/CpVo
         IgBG4JDUQvTy+Z/C2Bgl9icnB5U2V8Lu/RcurvW9ZlvNabzpZcwWQ3MwjfMO4T/CXk
         iYAJMCIbCL5RQ==
Message-ID: <329abedd9d9938de95bf4f5600acdcd6a846e6be.camel@kernel.org>
Subject: Re: [RFC PATCH v2 0/3] ceph: add support for snapshot names
 encryption
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Mar 2022 06:01:25 -0400
In-Reply-To: <5b53e812-d49b-45f0-1219-3dbc96febbc1@redhat.com>
References: <20220315161959.19453-1-lhenriques@suse.de>
         <5b53e812-d49b-45f0-1219-3dbc96febbc1@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure we want to worry about .snap directories here since they
aren't "real". IIRC, snaps are inherited from parents too, so you could
do something like

    mkdir dir1
    mkdir dir1/.snap/snap1
    mkdir dir1/dir2
    fscrypt encrypt dir1/dir2

There should be nothing to prevent encrypting dir2, but I'm pretty sure
dir2/.snap will not be empty at that point.

-- Jeff 

On Thu, 2022-03-17 at 13:27 +0800, Xiubo Li wrote:
> Hi Luis,
> 
> There has another issue you need to handle at the same time.
> 
> Currently only the empty directory could be enabled the file encryption, 
> such as for the following command:
> 
> $ fscrypt encrypt mydir/
> 
> But should we also make sure that the mydir/.snap/ is empty ?
> 
> Here the 'empty' is not totally empty, which allows it should allow long 
> snap names exist.
> 
> Make sense ?
> 
> - Xiubo
> 
> 
> On 3/16/22 12:19 AM, Luís Henriques wrote:
> > Hi!
> > 
> > A couple of changes since v1:
> > 
> > - Dropped the dentry->d_flags change in ceph_mkdir().  Thanks to Xiubo
> >    suggestion, patch 0001 now skips calling ceph_fscrypt_prepare_context()
> >    if we're handling a snapshot.
> > 
> > - Added error handling to ceph_get_snapdir() in patch 0001 (Jeff had
> >    already pointed that out but I forgot to include that change in previous
> >    revision).
> > 
> > - Rebased patch 0002 to the latest wip-fscrypt branch.
> > 
> > - Added some documentation regarding snapshots naming restrictions.
> > 
> > As before, in order to test this code the following PRs are required:
> > 
> >    mds: add protection from clients without fscrypt support #45073
> >    mds: use the whole string as the snapshot long name #45192
> >    mds: support alternate names for snapshots #45224
> >    mds: limit the snapshot names to 240 characters #45312
> > 
> > Luís Henriques (3):
> >    ceph: add support for encrypted snapshot names
> >    ceph: add support for handling encrypted snapshot names
> >    ceph: update documentation regarding snapshot naming limitations
> > 
> >   Documentation/filesystems/ceph.rst |  10 ++
> >   fs/ceph/crypto.c                   | 158 +++++++++++++++++++++++++----
> >   fs/ceph/crypto.h                   |  11 +-
> >   fs/ceph/inode.c                    |  31 +++++-
> >   4 files changed, 182 insertions(+), 28 deletions(-)
> > 
> 

-- 
Jeff Layton <jlayton@kernel.org>
