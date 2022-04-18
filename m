Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBDF5059DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbiDROan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbiDROYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:24:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127D4F46D;
        Mon, 18 Apr 2022 06:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91A6860F6C;
        Mon, 18 Apr 2022 13:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C82C385A8;
        Mon, 18 Apr 2022 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650287972;
        bh=qwW+KXmZ4MpkbXf5CjQzDRPBp7owf1X79RhEF+DEUgI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uY4DneylPE3wC7Cbk/kBwKtUJakpBeGILDpwfzSS/Ilq73esZIHZPEwzcDUWaGvcH
         wI3aMlkQxqHffITqhsadwpQJw0plsH/aGW+jhgpqdPuElzcyDQCPPyyYMUm4VbxUiA
         knaIew8MkzgCv7gl393zpRIYzzJEy55kDJWhFdA7xHqWIZpJBvQi9BVT85Sx0jUe5N
         B+p6lVoF/HGTkl/np7jY1JCm/dLnpxDqPJQNY53EUhQDNSUutY+N0J74Lq4+Q58luS
         Y79dQArcL6YYenzKzTBsPzpV5jMjSFK1XpyhrrAGTBf0FKBrur+yCT/84BqfqgsFN2
         gQw0KXn5Ew6VQ==
Message-ID: <73141a7e395ba9d78d5acded91c3658d78b4dca0.camel@kernel.org>
Subject: Re: [PATCH] ceph: prevent snapshots to be created in encrypted
 locked directories
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Apr 2022 09:19:30 -0400
In-Reply-To: <0c5c361c6d65f5b2fdb1dc89fd4317f22cbc3e74.camel@kernel.org>
References: <20220414135122.26821-1-lhenriques@suse.de>
         <20220418130839.9862-1-lhenriques@suse.de>
         <0c5c361c6d65f5b2fdb1dc89fd4317f22cbc3e74.camel@kernel.org>
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

On Mon, 2022-04-18 at 09:17 -0400, Jeff Layton wrote:
> On Mon, 2022-04-18 at 14:08 +0100, Luís Henriques wrote:
> > With snapshot names encryption we can not allow snapshots to be created in
> > locked directories because the names wouldn't be encrypted.  This patch
> > forces the directory to be unlocked to allow a snapshot to be created.
> > 
> > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > ---
> >  fs/ceph/dir.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index f48f1ff20927..93e2f08102a1 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1071,6 +1071,10 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> >  		err = -EDQUOT;
> >  		goto out;
> >  	}
> > +	if ((op == CEPH_MDS_OP_MKSNAP) && !fscrypt_has_encryption_key(dir)) {
> > +		err = -ENOKEY;
> > +		goto out;
> > +	}
> >  
> >  
> >  	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> 
> Looks good. I'll pull this and the v4 series into the wip-fscrypt later
> todat.  

Actually, I take it back...

This check doesn't test whether the parent is encrypted. Doesn't it need
to do that too before checking for the key?
-- 
Jeff Layton <jlayton@kernel.org>
